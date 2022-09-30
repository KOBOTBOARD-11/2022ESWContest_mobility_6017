import enum
import cv2
import face_recognition
import pickle
import os
import tensorflow as tf



def FaceTrain():
    file_count = sum(len(files) for _, _, files in os.walk(r'Image/user'))

    Image_paths = []
    Names = []
    Image_num = file_count
    image_type = '.jpg'
    encoding_file = 'encodings.pickle'
    model_method = 'CNN'
    ## CNN or HOG  TRADEOFF 존재

    ## CNN 정확하지만 느림
    ## HOG 빠르지만 정확도가 떨어짐 

    with open ("Image_path" , "r") as txt:
        Image_paths.append(txt.read().split())
    ## 이미지 경로 가져오기    
    with open ("Names" , "r") as txt:
        Names.append(txt.read().split())
        
    ## 사용자 정보 가져오기
    # print(Image_paths)
    # print(Names)

    knownEncodings = []
    knownNames = []

    for (i, Image_path) in enumerate(Image_paths[0]):
        name = Names[0][i]
        print(name)
        
        
        for idx in range(Image_num):
            file_name = Image_path + name+ str(idx+1) + image_type
            print(file_name)
            
            image = cv2.imread(file_name, cv2.IMREAD_COLOR)
            rgb_img = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
    # ################# 저장된 경로에서 이미지를 하나씩 읽어옴 ##################

            boxes = face_recognition.face_locations(rgb_img, 
                                                    model = model_method)  
            ##  face_recognition을 이용하여 얼굴 부분 확인 -> CNN 모델 사용
            
            encodings = face_recognition.face_encodings(image, boxes)
            ## face_recognition을 이용하여 얼굴 특징 인코딩  
            
            for encoding in encodings:
                print(file_name, name, encoding)
                knownEncodings.append(encoding)
                knownNames.append(name)
    #             ## 인코딩된 값을 저장
                
    ## 위에서 얻은 정보들을 파일로 저장
    data = {"encodings": knownEncodings, "names": knownNames}
    f = open(encoding_file, "wb")
    f.write(pickle.dumps(data))