import cv2
import face_recognition
import pickle
import time
import os
import tensorflow as tf
import numpy as np

os.environ["CUDA_VISIBLE_DEVICES"]="0"
gpus = tf.config.experimental.list_physical_devices('GPU')
if gpus:
    try:
        tf.config.experimental.set_memory_growth(gpus[0], True)
    except RuntimeError as e:
        print(e)


file_name = 'User1.mp4'
encoding_file = 'encodings.pickle'
Unknow_name = 'Unknown'
frame_resizing = 0.25
model_method = 'CNN'



def detectAndDisplay(image):
    start_time = time.time()
    small_frame = cv2.resize(frame, (0, 0), fx=frame_resizing, fy=frame_resizing)
    # small_frame = cv2.resize(image, (256,256), interpolation= cv2.INTER_LINEAR)
    rgb_small_frame = cv2.cvtColor(small_frame, cv2.COLOR_BGR2RGB)
    boxes = face_recognition.face_locations(rgb_small_frame,model=model_method)
    encodings = face_recognition.face_encodings(rgb_small_frame, boxes)
    
    names = []
    
    for encoding in encodings:
        matches = face_recognition.compare_faces(data["encodings"] ,
                                                 encoding)
        name = Unknow_name
        
        if True in matches:
            matchesIdxs = [i for (i,b) in enumerate(matches) if b]
            counts = {}
            
            for i in matchesIdxs:
                name = data["names"][i]
                print(name)
                counts[name] = counts.get(name,0) +1
                
                
            name = max(counts, key = counts.get)
        names.append(name)
        boxes = np.array(boxes)
        boxes = boxes / frame_resizing
        boxes = boxes.astype(int)
        
    for face_loc, name in zip(boxes, names):
        
        top, left, bottom, right = face_loc[0], face_loc[1], face_loc[2], face_loc[3]
        cv2.putText(image, name, (left, top - 1), cv2.FONT_HERSHEY_DUPLEX, 1, (0, 255, 0), 2)
        cv2.rectangle(image, (left,top), (right, bottom), (0, 0, 200), 4)
        
    end_time = time.time()
    print(end_time- start_time)
    
    # image = cv2.resize(frame, (0, 0), fx=frame_resizing, fy=frame_resizing)
    cv2.imshow("FACE", image)  



data = pickle.loads(open(encoding_file, "rb").read())
cap = cv2.VideoCapture(0)

if not cap.isOpened:
    print('EEEEEE')
    exit(0)
    
while True:
    ret, frame = cap.read()
    if frame is None:
        print("EEEEEEEEEEEE")
    detectAndDisplay(frame)
    
    
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break
cv2.destroyAllWindows()