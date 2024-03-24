from fastapi import FastAPI, File, UploadFile
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
model_path = './app/model/keras.h5'
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
    return {"message": "Hello World"}


@app.post("/analyze/osy_doodle")
async def analyze_object(file: UploadFile = File(...)):
    try:
        # 업로드된 파일을 읽음
        contents = await file.read()

        # 클래스 이름을 읽음
        with open("./class_names2.txt", "r") as ins:
            class_names = [line.rstrip('\n') for line in ins]

        # 모델 로드
        test_model = tf.keras.models.load_model('./app/model/osy_model2.h5')

        # 이미지를 numpy 배열로 변환
        nparr = np.fromstring(contents, np.uint8)
        input_img = cv2.imdecode(nparr, cv2.IMREAD_GRAYSCALE)
        input_img = cv2.resize(input_img, (28, 28))
        input_img = input_img.reshape((28, 28, 1))
        input_img = (255 - input_img) / 255

        # 모델 추론
        pred = test_model.predict(np.expand_dims(input_img, axis=0))[0]
        ind = (-pred).argsort()[:3]
        index = [class_names[x] for x in ind]
        print(index)
        return index
    except Exception as e:
        return JSONResponse(content={"error": str(e)}, status_code=500)


# @app.post("/analyze/osy_doodle")
# async def encode_image(file: UploadFile = File(...)):
#     try:
#         contents = await file.read()
#     # Read class names
#         with open("./class_names.txt", "r") as ins:
#             class_names = []
#             for line in ins:
#                 class_names.append(line.rstrip('\n'))
#     # Load the model
#         test_model = tf.keras.models.load_model('./app/model/osy_model.h5')
#     # Load the input data
#         input_img = cv2.imread('input.png')
#         input_img = cv2.resize(input_img, (28, 28))
#         input_img = cv2.cvtColor(input_img, cv2.COLOR_BGR2GRAY)
#         input_img = input_img.reshape((28, 28, 1))
#         input_img = (255 -input_img) / 255
#         #Inference through model
#         pred = test_model.predict(np.expand_dims(input_img, axis=0))[0]
#         ind = (-pred).argsort()[:10]
#         index = [class_names[x] for x in ind]
#         print(index)
#         return index
#         # encoded_image = base64.b64encode(contents).decode("utf-8")
#         # return JSONResponse(content={"image_base64": encoded_image})
#     except Exception as e:
#         return JSONResponse(content={"error": str(e)}, status_code=500)




@app.post("/analyze/osy_doodle1")
async def create_item(item: Item):

    image_b64 = base64.encode('input.png')
    print(image_b64)

    # # Read class names
    # with open("./class_names.txt", "r") as ins:
    #     class_names = []
    #     for line in ins:
    #         class_names.append(line.rstrip('\n'))


    # # Load the model
    # test_model = tf.keras.models.load_model('./app/model/osy_model.h5')
    # test_model.summary()

    # # Load the input data
    # input_img = cv2.imread('input.png')
    # input_img = cv2.resize(input_img, (28, 28))
    # input_img = cv2.cvtColor(input_img, cv2.COLOR_BGR2GRAY)
    # input_img = input_img.reshape((28, 28, 1))
    # input_img = (255 -input_img) / 255

    # #Inference through model
    # pred = test_model.predict(np.expand_dims(input_img, axis=0))[0]

    # ind = (-pred).argsort()[:10]
    # index = [class_names[x] for x in ind]
    # print(index)
    # return index[0]

    


# @app.post("/analyze/osy_doodle")
# async def analyze_object(imgdata: image):
        # Base64 디코딩
        # image_b64 = image.split(",")[1]
        # image_data = base64.b64decode(image_b64)
        # response = requests.get(imgdata.image)
        # new_image = Image.open(io.BytesIO(response.content)) # ===> 사과.png
        # return image_b64
        # Load the input data
        # input_img = cv2.imread(new_image)
        # input_img = cv2.resize(input_img, (28, 28))
        # input_img = cv2.cvtColor(input_img, cv2.COLOR_BGR2GRAY)
        # input_img = input_img.reshape((28, 28, 1))
        # input_img = (255 -input_img) / 255

        # # 이미지를 PIL.Image 객체로 변환
        # image_load = Image.open(io.BytesIO(image_data))
        # 이미지를 NumPy 배열로 변환
        # image_array = np.array(image_load)
        # image_array = np.array(new_image)

        # # NumPy 배열을 TensorFlow tensor로 변환
        # image_tensor = tf.convert_to_tensor(image_array, dtype=tf.float32)

        # 이미지의 크기를 (28, 28, 3)으로 조정
        # image_tensor = tf.image.resize(image_tensor, (128, 128))
        # image_tensor = tf.expand_dims(image_tensor, 0)

        # 모델 구동
        # prediction = doodle_model.predict(input_img)

        #Inference through model
        # pred = doodle_model.predict(np.expand_dims(input_img, axis=0))[0]

        # ind = (-pred).argsort()[:10]
        # index = [doodle_ref[x] for x in ind]
        # print(index)

        # 결과 후처리
        # idx = pred.argmax()
        # result = doodle_ref[idx]
        # result_data = {"result": result}

        # return JSONResponse(content=result_data)
    # except Exception as e:
    #     error_data = {"error": str(e)}
    #     return JSONResponse(content=error_data, status_code=500)

##############################################################









# @app.post('/analyze/osy_doodle')
# async def analyze_object(image: str):
#     try:
#         # Base64 디코딩
#         # image_b64 = image.split(",")[1]
#         # image_data = base64.b64decode(image)
#         response = requests.get(imgdata)
#         new_image = Image.open(io.BytesIO(response.content))

#         # # 이미지를 PIL.Image 객체로 변환
#         # image_load = Image.open(io.BytesIO(image_data))
#         # 이미지를 NumPy 배열로 변환
#         # image_array = np.array(image_load)
#         image_array = np.array(new_image)

#         # NumPy 배열을 TensorFlow tensor로 변환
#         image_tensor = tf.convert_to_tensor(image_array, dtype=tf.float32)
#         # 이미지의 크기를 (28, 28, 3)으로 조정
#         image_tensor = tf.image.resize(image_tensor, (28, 28))
#         image_tensor = tf.expand_dims(image_tensor, 0)

#         # 모델 구동
#         prediction = doodle_model.predict(image_tensor)

#         # 결과 후처리
#         idx = prediction.argmax()
#         result = doodle_ref[idx]
#         result_data = {"image": image_b64, "result": result}

#         return JSONResponse(content=result_data)
#     except Exception as e:
#         error_data = {"error": str(e)}
#         return JSONResponse(content=error_data, status_code=500)


# @app.post('/analyze/osy_doodle')
# async def analyze_object(imageDto: ObjectImage):

#     # 데이터 URL에서 Base64 인코딩된 이미지 데이터 추출
#     image_b64 = imageDto.image.split(",")[1]
#     # Base64 디코딩
#     image_data = base64.b64decode(image_b64)
#     # 이미지 데이터를 PIL.Image 객체로 변환
#     image_load = PIL.Image.open(io.BytesIO(image_data))
#     # 이미지를 NumPy 배열로 변환
#     image_array = np.array(image_load)

#     # numpy 배열을 TensorFlow tensor로 변환
#     image_tensor = tf.convert_to_tensor(image_array, dtype=tf.float32)
#     # 이미지의 크기를 (128, 128, 3)으로 조정
#     image_tensor = tf.image.resize(image_tensor, (28, 28))
#     image_tensor = tf.expand_dims(image_tensor, 0)

#     # 모델 구동
#     prediction = doodle_model.predict(image_tensor)

#     # 결과 후처리
#     idx = prediction.argmax()
#     result = doodle_ref[idx]
#     answer_dto = ResultDto(image=image_b64, result=(result == imageDto.answer))
    
#     # 반환
    # return answer_dto