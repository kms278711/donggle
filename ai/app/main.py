from fastapi import FastAPI, File, UploadFile, Form
import tensorflow as tf
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from keras.models import load_model
from fastapi.responses import JSONResponse
import requests
import io
from PIL import Image
import base64
import numpy as np 
from typing import Optional
from app.classes.doodle import ref as doodle_ref
import cv2

app = FastAPI()

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

# 모델 경로 지정
model_path = './app/model/thmodel2.h5'
# doodle_model.compile(optimizer='adam', loss=tf.keras.losses.SparseCategoricalCrossentropy(reduction=tf.keras.losses.Reduction.NONE), metrics=['accuracy'])
try:
    # 모델 로드
    doodle_model = tf.keras.models.load_model(model_path)
    print("#################################Model loaded successfully.")

    # 모델 컴파일
    # doodle_model.compile(optimizer='adam', loss='sparse_categorical_crossentropy', metrics=['accuracy'])
    # doodle_model.compile(optimizer='adam', loss=tf.keras.losses.SparseCategoricalCrossentropy(reduction=tf.keras.losses.Reduction.NONE), metrics=['accuracy'])
    print("Model compiled successfully.")
except FileNotFoundError as e:
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@File not found:", str(e))
except Exception as e:
    print("!!!!!!!!!!!!!!!!!!!!!!!Error loading model:", str(e))

####################################################################
@app.get("/")
async def root():
    return {"message": "Hello World th949"}


@app.post("/ai/analyze/drawing")
async def analyze_object(file: UploadFile = File(...), filename: Optional[str] = Form(None)):
    try:
        # 업로드된 파일을 읽음
        contents = await file.read()

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