from fastapi import FastAPI, File, UploadFile, Form
from fastapi import Request
from fastapi.templating import Jinja2Templates
from pydantic import BaseModel
import tensorflow as tf
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from fastapi.staticfiles import StaticFiles  # StaticFiles 임포트 추가
from fastapi.responses import JSONResponse
import requests
from io import BytesIO
from PIL import Image
import numpy as np 
from typing import Optional
from app.classes.doodle import ref as doodle_ref
import cv2
import boto3
import dlib
import io

app = FastAPI()
# templates 폴더 설정
templates = Jinja2Templates(directory="app/templates")
# 정적 파일 제공을 위한 경로 설정
app.mount("/static", StaticFiles(directory="app/templates"), name="static")  # 추가

origins = ["*"]
app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# class ObjectImage(BaseModel):
#     image: str
#     answer: str

# class ResultDto(BaseModel):
#     image: str
#     result: list[str]

class Item(BaseModel):
    name: str
    description: Optional[str] = None
    price: float
    tax: Optional[float] = None

class image(BaseModel):
    image: str

class list(BaseModel):
    result: list[str]

#################################################################

# 낙서 모델 경로 지정
model_path = './app/model/thmodel2.h5'
# doodle_model.compile(optimizer='adam', loss=tf.keras.losses.SparseCategoricalCrossentropy(reduction=tf.keras.losses.Reduction.NONE), metrics=['accuracy'])
try:
    # 모델 로드
    doodle_model = tf.keras.models.load_model(model_path)
    print("####################Doodle Model loaded successfully.")

    # 모델 컴파일
    # doodle_model.compile(optimizer='adam', loss='sparse_categorical_crossentropy', metrics=['accuracy'])
    # doodle_model.compile(optimizer='adam', loss=tf.keras.losses.SparseCategoricalCrossentropy(reduction=tf.keras.losses.Reduction.NONE), metrics=['accuracy'])
    # print("Model compiled successfully.")
except FileNotFoundError as e:
    print("@@@@@@@@@@@@@@@@@@@@File not found:", str(e))
except Exception as e:
    print("!!!!!!!!!!!!!!!!!!!!Error loading DOODLE model:", str(e))

####################################################################
    
# 감정 모델 경로 지정
emotion_model_path = './app/model/emotion_model.hdf5'
# 얼굴 인식
try:
    # 표정 가중치 모델
    emotion_model = tf.keras.models.load_model(emotion_model_path)

    # 모델 전처리 위한 dlib
    predictor = dlib.shape_predictor('./app/model/shape_predictor_68_face_landmarks.dat')
    face_cascade = cv2.CascadeClassifier('./app/model/haarcascade_frontalface_default.xml')
    print("####################Emotion Model loaded successfully.")

except FileNotFoundError as e:
    print("@@@@@@@@@@@@@@@@@@@@File not found", str(e))
except Exception as e:
    print("!!!!!!!!!!!!!!!!!!!!Error loading EMOTION model", str(e))

###################################################################
    
# O,X 판별 모델 경로 지정
action_model_path = './app/model/model_unquant.tflite'
# 동작 인식
try:
    # 표정 가중치 모델
    action_model = tf.lite.Interpreter(action_model_path)
    action_model.allocate_tensors()

    # 모델 입력 및 출력 텐서 인덱스 가져오기
    input_details = action_model.get_input_details()
    output_details = action_model.get_output_details()
    print("####################Action Model loaded successfully.")

except FileNotFoundError as e:
    print("@@@@@@@@@@@@@@@@@@@@File not found", str(e))
except Exception as e:
    print("!!!!!!!!!!!!!!!!!!!!Error loading ACTION model", str(e))

###################################################################
    

s3 = boto3.client(
    "s3", aws_access_key_id="AKIARI2J3RH4QEK7CPSB", aws_secret_access_key="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"
)

@app.get("/")
async def home(request: Request):
    return templates.TemplateResponse("index.html",{"request":request})


@app.post("/ai/analyze/drawing")
async def analyze_object(file: UploadFile = File(...), filename: Optional[str] = Form(None)):
    try:
        # 업로드된 파일을 읽음
        contents = await file.read()

        # S3에 업로드
        # s3.upload_fileobj(BytesIO(contents), "donggle", f"{filename}.png")

        # 클래스 이름을 읽음
        with open("./app/class_names.txt", "r") as ins:
            class_names = [line.rstrip('\n') for line in ins]

        # 모델 로드
        test_model = tf.keras.models.load_model('./app/model/thmodel2.h5')

        # 이미지를 numpy 배열로 변환
        nparr = np.fromstring(contents, np.uint8)
        input_img = cv2.imdecode(nparr, cv2.IMREAD_GRAYSCALE)
        input_img = cv2.resize(input_img, (28, 28))
        input_img = input_img.reshape((28, 28, 1))
        input_img = (255 - input_img) / 255

        # 모델 추론
        pred = test_model.predict(np.expand_dims(input_img, axis=0))[0]
        ind = (-pred).argsort()[:10]
        index = [class_names[x] for x in ind]
        answer = False
        for i in range(len(index)):
            # print(index[i], "file이름 : ",filename)
            if index[i] == filename:
                print(index[i])
                answer = True
            
        print(index)
        return answer
    except Exception as e:
        return JSONResponse(content={"error": str(e)}, status_code=500)

@app.post("/ai/analyze/emotions")
async def analyze_object(file: UploadFile = File(...), filename: Optional[str] = Form(None)):
    try:
        # 업로드된 파일을 읽음
        contents = await file.read()

        # 업로드된 파일 전처리
        image_stream = io.BytesIO(contents)
        image_stream.seek(0)
        frame = cv2.imdecode(np.frombuffer(image_stream.read(), np.uint8), cv2.IMREAD_COLOR)
    
        # # 표정 라벨링
        expression_labels = ['Angry', 'Disgust', 'Fear', 'Happy', 'Sad', 'Surprise', 'Neutral']

        # # 얼굴인식을 위해 gray 변환
        gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

        # 얼굴 인식
        # scaleFactor이 1에 가까울수록 표정 인식이 잘 되고 멀 수록 잘 안됨
        faces = face_cascade.detectMultiScale(gray, scaleFactor=1.1, minNeighbors=5, minSize=(30, 30))
        
        #region 얼굴이 인식되면 표정을 인식
        for (x, y, w, h) in faces:
            # 얼굴 크기에 알맞도록 사각형 그리기
            cv2.rectangle(frame, (x, y), (x+w, y+h), (0, 255, 0), 2)

            # 얼굴 크기 반환
            face_roi = gray[y:y+h, x:x+w]

            # 표정을 인식하기 위해 표정 dataset과 똑같은 사이즈 변환
            # dataset 이미지와 입력된 얼굴의 크기가 다르면 error 발생
            face_roi = cv2.resize(face_roi, (64, 64))
            face_roi = np.expand_dims(face_roi, axis=-1)
            face_roi = np.expand_dims(face_roi, axis=0)
            face_roi = face_roi / 255.0

            # 모델을 통해 표정 분석
            output = emotion_model.predict(face_roi)[0]

            # 해당 표정의 값 반환
            expression_index = np.argmax(output)

            # 표정에 따른 label 값 저장
            expression_label = expression_labels[expression_index]
            print(expression_label)
            if expression_label == filename:
                return True
            else:
                return False

    
    except Exception as e:
        return JSONResponse(content={"error": str(e)}, status_code=500)
        
@app.post("/ai/analyze/action")
async def analyze_object(file: UploadFile = File(...), filename: Optional[str] = Form(None)):
    try:
        # 업로드된 파일을 읽음
        contents = await file.read()

        contents_stream = BytesIO(contents)
        # 입력 이미지 경로 설정
        input_image = Image.open(contents_stream)
        # 모델 입력 크기에 맞게 이미지 크기 조정
        input_image = input_image.resize((224, 224))
        # 이미지를 numpy 배열로 변환하고 정규화
        input_image = np.array(input_image, dtype=np.float32) / 255.0
        # 모델 입력 형태에 맞게 차원 추가
        input_image = np.expand_dims(input_image, axis=0)

        
        # 추론 실행
        action_model.set_tensor(input_details[0]['index'], input_image)
        action_model.invoke()

        # 추론 결과 가져오기
        output = action_model.get_tensor(output_details[0]['index'])
        predicted_class = np.argmax(output)

        # 라벨 해석
        labels = ["O", "X", "N/A"]
        predicted_label = labels[predicted_class]
        print(predicted_label)
        if predicted_label == filename:
            return True
        else:
            return False

    
    except Exception as e:
        return JSONResponse(content={"error": str(e)}, status_code=500)