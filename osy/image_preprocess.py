import tensorflow as tf
from tensorflow import keras
import pandas as pd
import numpy as np
from PIL import Image
from numpy import asarray
import cv2


# Read class names
with open("class_names.txt", "r") as ins:
  class_names = []
  for line in ins:
    class_names.append(line.rstrip('\n'))

# Load the model
test_model = keras.models.load_model('./osy_model.h5')
#test_model.summary()

# Load the input data
input_img = cv2.imread('input.png')
input_img = cv2.resize(input_img, (28, 28))
input_img = cv2.cvtColor(input_img, cv2.COLOR_BGR2GRAY)
input_img = input_img.reshape((28, 28, 1))
input_img = (255 -input_img) / 255

#Inference through model
pred = test_model.predict(np.expand_dims(input_img, axis=0))[0]

ind = (-pred).argsort()[:10]
index = [class_names[x] for x in ind]
print(index)