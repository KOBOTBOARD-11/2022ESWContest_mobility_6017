import argparse
from asyncio.log import logger
from configparser import Interpolation
import os
from pickle import FALSE
from re import L
import time
import datetime

from matplotlib.pyplot import flag

# limit the number of cpus used by high performance libraries
os.environ["OMP_NUM_THREADS"] = "1"
os.environ["OPENBLAS_NUM_THREADS"] = "1"
os.environ["MKL_NUM_THREADS"] = "1"
os.environ["VECLIB_MAXIMUM_THREADS"] = "1"
os.environ["NUMEXPR_NUM_THREADS"] = "1"

import sys
import numpy as np
from pathlib import Path
import torch
import torch.backends.cudnn as cudnn

FILE = Path(__file__).resolve()
ROOT = FILE.parents[0]  # yolov5 strongsort root directory
WEIGHTS = ROOT / 'weights'

if str(ROOT) not in sys.path:
    sys.path.append(str(ROOT))  # add ROOT to PATH
if str(ROOT / 'yolov5') not in sys.path:
    sys.path.append(str(ROOT / 'yolov5'))  # add yolov5 ROOT to PATH
if str(ROOT / 'strong_sort') not in sys.path:
    sys.path.append(str(ROOT / 'strong_sort'))  # add strong_sort ROOT to PATH
ROOT = Path(os.path.relpath(ROOT, Path.cwd()))  # relative

import logging
from yolov5.models.common import DetectMultiBackend
from yolov5.utils.dataloaders import VID_FORMATS, LoadImages, LoadStreams
from yolov5.utils.general import (LOGGER, check_img_size, non_max_suppression, scale_coords, check_requirements, cv2,
                                  check_imshow, xyxy2xywh, increment_path, strip_optimizer, colorstr, print_args, check_file)
from yolov5.utils.torch_utils import select_device, time_sync
from yolov5.utils.plots import Annotator, colors, save_one_box
from strong_sort.utils.parser import get_config
from strong_sort.strong_sort import StrongSORT

# remove duplicated stream handler to avoid duplicated logging
logging.getLogger().removeHandler(logging.getLogger().handlers[0])

from ast import Num
from distutils.command.config import config
from tabnanny import check
import pyrebase
import json
from firebase_admin import firestore
from firebase_admin import credentials
import firebase_admin

config = {
    "apiKey": "AIzaSyAiBPBNapR9sE1gD6-g0-CEDUCVW7Stz8o",
    "authDomain": "esc-car-keeper.firebaseapp.com",
    "projectId": "esc-car-keeper",
    "storageBucket": "esc-car-keeper.appspot.com",
    "messagingSenderId": "927007293579",
    "appId": "1:927007293579:web:2256ba6e94aaa98216548e",
    "serviceAccount" : "/home/kobot/Yolov5_DeepSort_Pytorch_ESC/firebase/serviceKey.json",
    "databaseURL" : "https://esc-carkeeper-default-rtdb.asia-southeast1.firebasedatabase.app",
  }

firebase = pyrebase.initialize_app(config)
storage = firebase.storage()
Token = "esc-car-keeper.firebaseapp.com" # fire storage

credpath = r"/home/kobot/Yolov5_DeepSort_Pytorch_ESC/firebase/serviceKey.json" # serviceKey Path
login = credentials.Certificate(credpath)
firebase_admin.initialize_app(login)
db = firestore.client()

import urllib.request
import threading
from saveimgfromVid import SaveImg
from facetrainfromIMG import FaceTrain
from recognition import detectAndDisplay
import os
import pickle

def Mode_snapshot(doc_snapshot, changes, read_time):
    global observerMode
    for doc in doc_snapshot:
        observerMode = (doc.to_dict()["mode"])
    callback_done.set()

def on_snapshot(doc_snapshot, changes, read_time):
    for doc in doc_snapshot:
        VideoURl.append(doc.to_dict()["VideoURL"])
    callback_done.set()
    
#-- save video from url --# 
def save_video(video_url) :
    savename = 'User/user.mp4'
    urllib.request.urlretrieve(video_url,savename)
    SaveImg(savename)
    FaceTrain()


doc_ref = db.collection(u'FaceID').document(u'user')
doc_ref.on_snapshot(on_snapshot)

callback_done = threading.Event()
VideoURl =[]
observerMode = 'off'

import paho.mqtt.client as mqtt
import json

distance = 1000 # 초기값 설정 1000

def on_connect(client, userdata, flags, rc):
    if rc == 0:
        print("connected OK")
    else:
        print("Bad connection Returned code=", rc)
def on_disconnect(client, userdata, flags, rc=0):
    print(str(rc))
def on_subscribe(client, userdata, mid, granted_qos):
    print("subscribed: " + str(mid) + " " + str(granted_qos))
def on_message(client, userdata, msg) : # msg -> 거리
    global distance 
    distance = int(str(msg.payload.decode("utf-8")))
    print("초음파 거리: ", distance)
def on_publish(client, userdata, mid):
    print("on Send = ", mid)
    
client = mqtt.Client()
client.on_connect = on_connect
client.on_disconnect = on_disconnect
client.on_subscribe = on_subscribe
client.on_message = on_message

client.connect('10.3.60.134', 1883)
client.subscribe('ultraCarKeeper', 1)

@torch.no_grad()
def run(
        source='0',
        yolo_weights=WEIGHTS / 'yolov5m.pt',  # model.pt path(s),
        strong_sort_weights=WEIGHTS / 'osnet_x0_25_msmt17.pt',  # model.pt path,
        config_strongsort=ROOT / 'strong_sort/configs/strong_sort.yaml',
        imgsz=(640, 640),  # inference size (height, width)
        conf_thres=0.25,  # confidence threshold
        iou_thres=0.45,  # NMS IOU threshold
        max_det=1000,  # maximum detections per image
        device='',  # cuda device, i.e. 0 or 0,1,2,3 or cpu
        show_vid=False,  # show results
        save_txt=False,  # save results to *.txt
        save_conf=False,  # save confidences in --save-txt labels
        save_crop=False,  # save cropped prediction boxes
        save_vid=False,  # save confidences in --save-txt labels
        nosave=False,  # do not save images/videos
        classes=None,  # filter by class: --class 0, or --class 0 2 3
        agnostic_nms=False,  # class-agnostic NMS
        augment=False,  # augmented inference
        visualize=False,  # visualize features
        update=False,  # update all models
        project=ROOT / 'runs/track',  # save results to project/name
        name='exp',  # save results to project/name
        exist_ok=False,  # existing project/name ok, do not increment
        line_thickness=3,  # bounding box thickness (pixels)
        hide_labels=False,  # hide labels
        hide_conf=False,  # hide confidences
        hide_class=False,  # hide IDs
        half=False,  # use FP16 half-precision inference
        dnn=False,  # use OpenCV DNN for ONNX inference
        eval=False,  # run multi-gpu eval
):

    source = str(source)
    save_img = not nosave and not source.endswith('.txt')  # save inference images
    is_file = Path(source).suffix[1:] in (VID_FORMATS)
    is_url = source.lower().startswith(('rtsp://', 'rtmp://', 'http://', 'https://'))
    webcam = source.isnumeric() or source.endswith('.txt') or (is_url and not is_file)
    if is_url and is_file:
        source = check_file(source)  # download

    # Directories
    if not isinstance(yolo_weights, list):  # single yolo model
        exp_name = yolo_weights.stem
    elif type(yolo_weights) is list and len(yolo_weights) == 1:  # single models after --yolo_weights
        exp_name = Path(yolo_weights[0]).stem
    else:  # multiple models after --yolo_weights
        exp_name = 'ensemble'
    exp_name = name if name else exp_name + "_" + strong_sort_weights.stem
    save_dir = increment_path(Path(project) / exp_name, exist_ok=exist_ok)  # increment run
    (save_dir / 'tracks' if save_txt else save_dir).mkdir(parents=True, exist_ok=True)  # make dir

    # Load model
    if eval:
        device = torch.device(int(device))
    else:
        device = select_device(device)
    model = DetectMultiBackend(yolo_weights, device=device, dnn=dnn, data=None, fp16=half)
    stride, names, pt = model.stride, model.names, model.pt
    imgsz = check_img_size(imgsz, s=stride)  # check image size

    # Dataloader
    if webcam:
        show_vid = check_imshow()
        cudnn.benchmark = True  # set True to speed up constant image size inference
        dataset = LoadStreams(source, img_size=imgsz, stride=stride, auto=pt)
        nr_sources = len(dataset)
    else:
        dataset = LoadImages(source, img_size=imgsz, stride=stride, auto=pt)
        nr_sources = 1
    vid_path, vid_writer, txt_path = [None] * nr_sources, [None] * nr_sources, [None] * nr_sources

    # initialize StrongSORT
    cfg = get_config()
    cfg.merge_from_file(config_strongsort)

    # Create as many strong sort instances as there are video sources
    strongsort_list = []
    for i in range(nr_sources):
        strongsort_list.append(
            StrongSORT(
                strong_sort_weights,
                device,
                half,
                max_dist=cfg.STRONGSORT.MAX_DIST,
                max_iou_distance=cfg.STRONGSORT.MAX_IOU_DISTANCE,
                max_age=cfg.STRONGSORT.MAX_AGE,
                n_init=cfg.STRONGSORT.N_INIT,
                nn_budget=cfg.STRONGSORT.NN_BUDGET,
                mc_lambda=cfg.STRONGSORT.MC_LAMBDA,
                ema_alpha=cfg.STRONGSORT.EMA_ALPHA,

            )
        )
        strongsort_list[i].model.warmup()
    outputs = [None] * nr_sources
    
    picNum = 0
    wildboar_flag = False
    dog_flag = False
    waterdeer_flag = False
    racoon_flag = False
    human_flag = False
    user_flag = False
    
    doc_ref = db.collection(u'FaceID').document(u'user')
    doc_ref.on_snapshot(on_snapshot)

    while True:
        doc_ref.on_snapshot(on_snapshot)
        time.sleep(1)
        if(VideoURl):
            print(VideoURl[0])
            break
        
    save_video(VideoURl[0]) # Learning Part
  
    encoding_file = 'encodings.pickle'

    data = pickle.loads(open(encoding_file, "rb").read())
    
    # Run tracking
    model.warmup(imgsz=(1 if pt else nr_sources, 3, *imgsz))  # warmup
    dt, seen = [0.0, 0.0, 0.0, 0.0], 0
    curr_frames, prev_frames = [None] * nr_sources, [None] * nr_sources
    for frame_idx, (path, im, im0s, vid_cap, s) in enumerate(dataset):
        t1 = time_sync()
        im = torch.from_numpy(im).to(device)
        im = im.half() if half else im.float()  # uint8 to fp16/32
        im /= 255.0  # 0 - 255 to 0.0 - 1.0
        if len(im.shape) == 3:
            im = im[None]  # expand for batch dim
        t2 = time_sync()
        dt[0] += t2 - t1

        # Inference
        visualize = increment_path(save_dir / Path(path[0]).stem, mkdir=True) if visualize else False
        pred = model(im, augment=augment, visualize=visualize)
        t3 = time_sync()
        dt[1] += t3 - t2

        # Apply NMS
        pred = non_max_suppression(pred, conf_thres, iou_thres, classes, agnostic_nms, max_det=max_det)
        dt[2] += time_sync() - t3

        # Process detections
        
        for i, det in enumerate(pred): # detections per image
            # startDocRef = db.collection(u'CarKeeper').document(u'observer')
            # startDocRef.on_snapshot(Mode_snapshot)
            # if observerMode == 'off':
            #     print("--------- observerMode OFF ----------")
            #     time.sleep(1)
            #     pass
    
            seen += 1
            if webcam:  # nr_sources >= 1
                p, im0, _ = path[i], im0s[i].copy(), dataset.count
                p = Path(p)  # to Path 
                txt_file_name = p.name
                save_path = str(save_dir / p.name)  # im.jpg, vid.mp4, ...
            else:
                p, im0, _ = path, im0s.copy(), getattr(dataset, 'frame', 0)
                p = Path(p)  # to Path
                # video file
                if source.endswith(VID_FORMATS):
                    txt_file_name = p.stem
                    save_path = str(save_dir / p.name)  # im.jpg, vid.mp4, ...
                # folder with imgs
                else:
                    txt_file_name = p.parent.name  # get folder name containing current img
                    save_path = str(save_dir / p.parent.name)  # im.jpg, vid.mp4, ...
                    
                    
                    
            # im0 = cv2.cvtColor(im0, cv2.COLOR_GRAY2BGR) # !!! !!! !!! !!! !!! !!! !!!
            curr_frames[i] = im0

            txt_path = str(save_dir / 'tracks' / txt_file_name)  # im.txt
            # s += '%gx%g ' % im.shape[2:]  # print string
            imc = im0.copy() if save_crop else im0  # for save_crop

            annotator = Annotator(im0, line_width=2, pil=not ascii)
            if cfg.STRONGSORT.ECC:  # camera motion compensation
                strongsort_list[i].tracker.camera_update(prev_frames[i], curr_frames[i])

            if det is not None and len(det):
                # Rescale boxes from img_size to im0 size
                det[:, :4] = scale_coords(im.shape[2:], det[:, :4], im0.shape).round()

                # Print results
                for c in det[:, -1].unique():
                    n = (det[:, -1] == c).sum()  # detections per class
                    s += f"{n} {names[int(c)]}{'s' * (n > 1)}, "  # add to string

                xywhs = xyxy2xywh(det[:, 0:4])
                confs = det[:, 4]
                clss = det[:, 5]

                # pass detections to strongsort
                t4 = time_sync()
                outputs[i] = strongsort_list[i].update(xywhs.cpu(), confs.cpu(), clss.cpu(), im0)
                t5 = time_sync()
                dt[3] += t5 - t4

                # draw boxes for visualization
                if len(outputs[i]) > 0:
                    for j, (output, conf) in enumerate(zip(outputs[i], confs)):
    
                        bboxes = output[0:4]
                        id = output[4]
                        cls = output[5]

                        if save_txt:
                            # to MOT format
                            bbox_left = output[0]
                            bbox_top = output[1]
                            bbox_w = output[2] - output[0]
                            bbox_h = output[3] - output[1]
                    
                            # Write MOT compliant results to file
                            with open(txt_path + '.txt', 'a') as f:
                                f.write(('%g ' * 10 + '\n') % (frame_idx + 1, id, bbox_left,  # MOT format
                                                               bbox_top, bbox_w, bbox_h, -1, -1, -1, i))
                        
                        
                        if save_vid or save_crop or show_vid:  # Add bbox to image
                            c = int(cls)  # integer class
                            id = int(id)  # integer id
                            # Wildboar      0
                            # dog           1
                            # racoon        2
                            # waterdeer     3
                            # human         4
                            if c == 0 :
                                coordi = xywhs.tolist() # tensor to list
                                jsonObject = {
                                    "obj_flag": 1,
                                    "x_flag": 320 - coordi[0][0],
                                    "y_flag": 240 - coordi[0][1],
                                }
                                jsonStr = json.dumps(jsonObject)
                                client.publish('servoCarKeeper', jsonStr, 1)
                                
                                if wildboar_flag == False : 
                                    first_wildboar_time = time.time()
                                    wildboar_flag = True
                                elif wildboar_flag == True:
                                    measure_wildboar_time = time.time()
                                    if measure_wildboar_time - first_wildboar_time >= 5 and distance <= 200:
                                        print("upload!")
                                        wildboar_flag = False
                                        image_path = str(Path('pictures/' + 'pic_' + str(picNum) + ".jpg"))
                                        cv2.imwrite(image_path, im0)
                                        storage.child("pictures/pic/" + str(picNum)).put('/home/kobot/Yolov5_DeepSort_Pytorch_ESC/pictures/pic_' + str(picNum) + '.jpg')
                                        #storage
                                        pictures = db.collection("pictures") #Database
                                        pictures.document("pic" + str(picNum)).set({
                                            'time' : datetime.datetime.now().strftime("['%Y.%m.%d %H:%M:%S']"),
                                            'type' : 'wildboar',
                                            'pic' : storage.child("pictures/pic/" + str(picNum)).get_url(1)
                                        })
                                        
                            if c == 1 :
                                coordi = xywhs.tolist()
                                jsonObject = {
                                    "obj_flag": 1,
                                    "x_flag": 320 - coordi[0][0],
                                    "y_flag": 240 - coordi[0][1],
                                }
                                jsonStr = json.dumps(jsonObject)
                                client.publish('servoCarKeeper', jsonStr, 1)
                                if dog_flag == False : 
                                    first_dog_time = time.time()
                                    dog_flag = True
                                elif dog_flag == True:
                                    measure_dog_time = time.time()
                                    if measure_dog_time - first_dog_time >= 5 and distance <= 200:
                                        print("upload!")
                                        dog_flag = False
                                        image_path = str(Path('pictures/' + 'pic_' + str(picNum) + ".jpg"))
                                        cv2.imwrite(image_path, im0)
                                        storage.child("pictures/pic/" + str(picNum)).put('/home/kobot/Yolov5_DeepSort_Pytorch_ESC/pictures/pic_' + str(picNum) + '.jpg')
                                        #storage
                                        pictures = db.collection("pictures") #Database
                                        pictures.document("pic" + str(picNum)).set({
                                            'time' : datetime.datetime.now().strftime("['%Y.%m.%d %H:%M:%S']"),
                                            'type' : 'dog',
                                            'pic' : storage.child("pictures/pic/" + str(picNum)).get_url(1)
                                        })
                                        
                            if c == 2 :
                                coordi = xywhs.tolist()
                                jsonObject = {
                                    "obj_flag": 1,
                                    "x_flag": 320 - coordi[0][0],
                                    "y_flag": 240 - coordi[0][1],
                                }
                                jsonStr = json.dumps(jsonObject)
                                client.publish('servoCarKeeper', jsonStr, 1)
                                if racoon_flag == False : 
                                    first_racoon_time = time.time()
                                    racoon_flag = True
                                elif racoon_flag == True:
                                    measure_racoon_time = time.time()
                                    if measure_racoon_time - first_racoon_time >= 5 and distance <= 200:
                                        print("upload!")
                                        racoon_flag = False
                                        image_path = str(Path('pictures/' + 'pic_' + str(picNum) + ".jpg"))
                                        cv2.imwrite(image_path, im0)
                                        storage.child("pictures/pic/" + str(picNum)).put('/home/kobot/Yolov5_DeepSort_Pytorch_ESC/pictures/pic_' + str(picNum) + '.jpg')
                                        #storage
                                        pictures = db.collection("pictures") #Database
                                        pictures.document("pic" + str(picNum)).set({
                                            'time' : datetime.datetime.now().strftime("['%Y.%m.%d %H:%M:%S']"),
                                            'type' : 'racoon',
                                            'pic' : storage.child("pictures/pic/" + str(picNum)).get_url(1)
                                        })
                           
                            if c == 3 :
                                coordi = xywhs.tolist()
                                jsonObject = {
                                    "obj_flag": 1,
                                    "x_flag": 320 - coordi[0][0],
                                    "y_flag": 240 - coordi[0][1],
                                }
                                jsonStr = json.dumps(jsonObject)
                                client.publish('servoCarKeeper', jsonStr, 1)
                                
                                if waterdeer_flag == False : 
                                    first_waterdeer_time = time.time()
                                    waterdeer_flag = True
                                elif waterdeer_flag == True:
                                    measure_waterdeer_time = time.time()
                                    if measure_waterdeer_time - first_waterdeer_time >= 5 and distance <= 200:
                                        print("upload!")
                                        waterdeer_flag = False
                                        image_path = str(Path('pictures/' + 'pic_' + str(picNum) + ".jpg"))
                                        cv2.imwrite(image_path, im0)
                                        storage.child("pictures/pic/" + str(picNum)).put('/home/kobot/Yolov5_DeepSort_Pytorch_ESC/pictures/pic_' + str(picNum) + '.jpg')
                                        #storage
                                        pictures = db.collection("pictures") #Database
                                        pictures.document("pic" + str(picNum)).set({
                                            'time' : datetime.datetime.now().strftime("['%Y.%m.%d %H:%M:%S']"),
                                            'type' : 'waterdeer',
                                            'pic' : storage.child("pictures/pic/" + str(picNum)).get_url(1)
                                        })
                        
                            if c == 4 :
                                coordi = xywhs.tolist() # tensor to list
                                jsonObject = {
                                    "obj_flag": 1,
                                    "x_flag": 320 - int(coordi[0][0]),
                                    "y_flag": 240 - int(coordi[0][1]),
                                }
                                LOGGER.info(320 - int(coordi[0][0]))
                                LOGGER.info(240 - int(coordi[0][1]))
                                jsonStr = json.dumps(jsonObject)
                                client.publish('servoCarKeeper', jsonStr, 1)
                                if human_flag == False : 
                                    first_human_time = time.time()
                                    human_flag = True
                                elif human_flag == True:
                                    measure_human_time = time.time()
                                    if measure_human_time - first_human_time >= 5 and distance <= 200:
                                        
                                        faceImg = im0[int(coordi[0][1]-int(int(coordi[0][3])/2)):int(coordi[0][1]),int(coordi[0][0])-int(int(coordi[0][2])/2):int(coordi[0][0])+int(int(coordi[0][2])/2)]
                                        faceImg = cv2.resize(faceImg, (0, 0), fx = 3.0, fy = 3.0, interpolation= cv2.INTER_LANCZOS4) # faceImg -> frame
                                        
                                        ID = detectAndDisplay(faceImg,data)
                                        
                                        print("upload!")
                                        human_flag = False
                                        image_path = str(Path('pictures/' + 'pic_' + str(picNum) + ".jpg"))
                                        image_path2 = str(Path('user_pic/' + 'user_' + str(picNum) + ".jpg"))
                                        cv2.imwrite(image_path, im0) 
                                        cv2.imwrite(image_path2, faceImg)
                                        storage.child("pictures/pic/" + str(picNum)).put('/home/kobot/Yolov5_DeepSort_Pytorch_ESC/pictures/pic_' + str(picNum) + '.jpg')
                                        storage.child("user_pic/user/" + str(picNum)).put('/home/kobot/Yolov5_DeepSort_Pytorch_ESC/user_pic/user_' + str(picNum) + '.jpg')
                                       
                                        if ID :
                                            if ID[0] == 'CarOwner' :
                                                user_flag = 2
                                            elif ID[0] == 'stranger':
                                                user_flag = 1
                                        else :
                                            user_flag = 0
                                        
                                        pictures = db.collection("pictures") #Database
                                        pictures.document("pic" + str(picNum)).set({
                                            'time' : datetime.datetime.now().strftime("['%Y.%m.%d %H:%M:%S']"),
                                            'type' : 'human',
                                            'pic' : storage.child("pictures/pic/" + str(picNum)).get_url(1),
                                            'user_pic' : storage.child("user_pic/user/" + str(picNum)).get_url(1),
                                            'user_type' : user_flag
                                        })
                          
                            label = None if hide_labels else (f'{w} {names[c]}' if hide_conf else \
                                (f'{id} {conf:.2f}' if hide_class else f'{id} {names[c]} {conf:.2f}'))
                            annotator.box_label(bboxes, label, color=colors(c, True))
                            
                            if save_crop:
                                txt_file_name = txt_file_name if (isinstance(path, list) and len(path) > 1) else ''
                                save_one_box(bboxes, imc, file=save_dir / 'crops' / txt_file_name / names[c] / f'{id}' / f'{p.stem}.jpg', BGR=True)

                LOGGER.info(f'{s}Done.')

            else:
                strongsort_list[i].increment_ages()
             
                jsonObject = {
                    "obj_flag": 0
                }
                jsonStr = json.dumps(jsonObject)
                client.publish('servoCarKeeper', jsonStr, 1)

            # Stream results
            im0 = annotator.result()
            if show_vid:
                cv2.imshow(str(p), im0)
                cv2.waitKey(1)  # 1 millisecond

            # Save results (image with detections)
            if save_vid:
                if vid_path[i] != save_path:  # new video
                    vid_path[i] = save_path
                    if isinstance(vid_writer[i], cv2.VideoWriter):
                        vid_writer[i].release()  # release previous video writer
                    if vid_cap:  # video
                        fps = vid_cap.get(cv2.CAP_PROP_FPS)
                        w = int(vid_cap.get(cv2.CAP_PROP_FRAME_WIDTH))
                        h = int(vid_cap.get(cv2.CAP_PROP_FRAME_HEIGHT))
                    else:  # stream
                        fps, w, h = 30, im0.shape[1], im0.shape[0]
                    # save_path = str(Path(save_path).with_suffix('.mp4'))  # force *.mp4 suffix on results videos
                    image_path = str(Path('humanPic/' + 'human_' + str(picNum) + ".jpg")) #이미지 파일 저장 경로
                    cv2.imwrite(image_path, im0)
                    
                    vid_writer[i] = cv2.VideoWriter(save_path, cv2.VideoWriter_fourcc(*'mp4v'), fps, (w, h))
                vid_writer[i].write(im0)

            prev_frames[i] = curr_frames[i]

    # Print results
    t = tuple(x / seen * 1E3 for x in dt)  # speeds per image
    LOGGER.info(f'Speed: %.1fms pre-process, %.1fms inference, %.1fms NMS, %.1fms strong sort update per image at shape {(1, 3, *imgsz)}' % t)
    if save_txt or save_vid:
        s = f"\n{len(list(save_dir.glob('tracks/*.txt')))} tracks saved to {save_dir / 'tracks'}" if save_txt else ''
        LOGGER.info(f"Results saved to {colorstr('bold', save_dir)}{s}")
    if update:
        strip_optimizer(yolo_weights)  # update model (to fix SourceChangeWarning)

def parse_opt():
    parser = argparse.ArgumentParser()
    parser.add_argument('--yolo-weights', nargs='+', type=Path, default=WEIGHTS / '/home/kobot/Yolov5_DeepSort_Pytorch_ESC/best.pt') #, help='model.pt path(s)')
    parser.add_argument('--strong-sort-weights', type=Path, default=WEIGHTS / 'osnet_x0_25_msmt17.pt')
    parser.add_argument('--config-strongsort', type=str, default='strong_sort/configs/strong_sort.yaml')
    parser.add_argument('--source', type=str, default='http://203.246.113.210:12345/video_feed', help='file/dir/URL/glob, 0 for webcam')
    # parser.add_argument('--source', type=str, default=0, help='file/dir/URL/glob, 0 for webcam')  
    
    parser.add_argument('--imgsz', '--img', '--img-size', nargs='+', type=int, default=[640], help='inference size h,w')
    parser.add_argument('--conf-thres', type=float, default=0.5, help='confidence threshold')
    parser.add_argument('--iou-thres', type=float, default=0.5, help='NMS IoU threshold')
    parser.add_argument('--max-det', type=int, default=1000, help='maximum detections per image')
    parser.add_argument('--device', default='', help='cuda device, i.e. 0 or 0,1,2,3 or cpu')
    parser.add_argument('--show-vid', action='store_true', help='display tracking video results')
    parser.add_argument('--save-txt', action='store_true', help='save results to *.txt')
    parser.add_argument('--save-conf', action='store_true', help='save confidences in --save-txt labels')
    parser.add_argument('--save-crop', action='store_true', help='save cropped prediction boxes')
    parser.add_argument('--save-vid', action='store_true', help='save video tracking results')
    parser.add_argument('--nosave', action='store_true', help='do not save images/videos')
    # class 0 is person, 1 is bycicle, 2 is car... 79 is oven
    parser.add_argument('--classes', nargs='+', type=int, help='filter by class: --classes 0, or --classes 0 2 3')
    parser.add_argument('--agnostic-nms', action='store_true', help='class-agnostic NMS')
    parser.add_argument('--augment', action='store_true', help='augmented inference')
    parser.add_argument('--visualize', action='store_true', help='visualize features')
    parser.add_argument('--update', action='store_true', help='update all models')
    parser.add_argument('--project', default=ROOT / 'runs/track', help='save results to project/name')
    parser.add_argument('--name', default='exp', help='save results to project/name')
    parser.add_argument('--exist-ok', action='store_true', help='existing project/name ok, do not increment')
    parser.add_argument('--line-thickness', default=3, type=int, help='bounding box thickness (pixels)')
    parser.add_argument('--hide-labels', default=False, action='store_true', help='hide labels')
    parser.add_argument('--hide-conf', default=False, action='store_true', help='hide confidences')
    parser.add_argument('--hide-class', default=False, action='store_true', help='hide IDs')
    parser.add_argument('--half', action='store_true', help='use FP16 half-precision inference')
    parser.add_argument('--dnn', action='store_true', help='use OpenCV DNN for ONNX inference')
    parser.add_argument('--eval', action='store_true', help='run evaluation')
    opt = parser.parse_args()
    opt.imgsz *= 2 if len(opt.imgsz) == 1 else 1  # expand
    print_args(vars(opt))
    return opt


def main(opt):
    check_requirements(requirements=ROOT / 'requirements.txt', exclude=('tensorboard', 'thop'))
    run(**vars(opt))


if __name__ == "__main__":
    client.loop_start()
    opt = parse_opt()
    main(opt)
    client.loop_stop()
