from firebase_admin import credentials
from firebase_admin import firestore
import urllib.request
import firebase_admin
import threading
import pyrebase
import collections
import time
from SaveimgFromVideo import SaveImg
from FaceTrainFromImage import FaceTrain
from recognition import detectAndDisplay
import os
import tensorflow as tf
import cv2
import pickle

os.environ["CUDA_VISIBLE_DEVICES"]="0"
gpus = tf.config.experimental.list_physical_devices('GPU')
if gpus:
    try:
        tf.config.experimental.set_memory_growth(gpus[0], True)
    except RuntimeError as e:
        print(e)

config = {
    "apiKey": "AIzaSyAiBPBNapR9sE1gD6-g0-CEDUCVW7Stz8o",
    "authDomain": "esc-car-keeper.firebaseapp.com",
    "projectId": "esc-car-keeper",
    "storageBucket": "esc-car-keeper.appspot.com",
    "messagingSenderId": "927007293579",
    "appId": "1:927007293579:web:2256ba6e94aaa98216548e",
    "serviceAccount" : "serviceKey.json",
    "databaseURL" : "https://esc-carkeeper-default-rtdb.asia-southeast1.firebasedatabase.app",
  }



#-- firebase setting --#
firebase = pyrebase.initialize_app(config)
Token = "esc-car-keeper.firebaseapp.com" # fire storage
credpath = r"serviceKey.json" # serviceKey Path
login = credentials.Certificate(credpath)
firebase_admin.initialize_app(login)
db = firestore.client()
callback_done = threading.Event()
VideoURl =[]

#-- live data --# 
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
    print("저장완료")

    
doc_ref = db.collection(u'FaceID').document(u'user')
doc_ref.on_snapshot(on_snapshot)


while True:
    doc_ref.on_snapshot(on_snapshot)
    time.sleep(1)
    if(VideoURl):
      print(VideoURl[0])
      break

save_video(VideoURl[0])

file_name = 'User/user.mp4'
encoding_file = 'encodings.pickle'
Unknow_name = 'Unknown'
model_method = 'CNN'

data = pickle.loads(open(encoding_file, "rb").read())
cap = cv2.VideoCapture(file_name)

if not cap.isOpened:
    print('EEEEEE')
    exit(0)
    
while True:
    ret, frame = cap.read()
    # frame = cv2.flip(frame,-1)
    frame = cv2.flip(frame,1)
    if frame is None:
        print("종료")
        break
    else :
        detectAndDisplay(frame,data)
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break
cv2.destroyAllWindows()