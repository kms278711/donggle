import tensorflow as tf
from keras.models import load_model



doodle_model = tf.models.load_model('./app/model/doodle_cnn.h5')


@app.get("/")
async def root():
    return {"message": "Hello World"}
