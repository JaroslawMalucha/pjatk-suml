import streamlit as st
import numpy as np
import pandas as pd
import tensorflow as tf
from PIL import Image
import io
import pickle

# paths
model_path = './models/dog_breed_classifier.h5'
class_indices_path = './models/class_indices.pkl'



# Load the trained model
model = tf.keras.models.load_model(model_path)

# Load class indices
with open(class_indices_path, 'rb') as f:
    class_indices = pickle.load(f)
index_to_class = {v: k for k, v in class_indices.items()}

# Function to preprocess image
def preprocess_image(image):
    image = image.resize((224, 224))
    image = np.array(image) / 255.0
    image = np.expand_dims(image, axis=0)
    return image

# Streamlit UI
st.title("Dog Breed Classifier")
st.write("Upload an image of a dog, and the model will predict its breed.")

uploaded_file = st.file_uploader("Choose an image...", type="jpg")

if uploaded_file is not None:
    image = Image.open(uploaded_file)
    st.image(image, caption='Uploaded Image', width=200)
    st.write("Classifying...")

    # Preprocess the image and make prediction
    image = preprocess_image(image)
    predictions = model.predict(image)[0]
    
    # Get the top 5 predictions
    top_indices = predictions.argsort()[-5:][::-1]
    top_breeds = [(index_to_class[idx], predictions[idx]) for idx in top_indices]

    # Display the top 5 predictions
    st.write("### Top 5 Predicted Breeds:")
    for i, (breed, prob) in enumerate(top_breeds):
        if i == 0:
            st.write(f"**{breed}: {prob*100:.3f} %**")
        else:
            st.write(f"{breed}: {prob*100:.3f} %")
