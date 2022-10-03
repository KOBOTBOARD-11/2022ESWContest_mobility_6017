import pickle
import cv2
from recognition import detectAndDisplay
encoding_file = 'encodings.pickle'


data = pickle.loads(open(encoding_file, "rb").read())
cap = cv2.VideoCapture(0)

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