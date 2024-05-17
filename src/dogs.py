import streamlit as st
import numpy as np
import pandas as pd
import tensorflow as tf
from PIL import Image
import io
import pickle

# Load the trained model
model = tf.keras.models.load_model('dog_breed_classifier.h5')

# Load class indices
with open('class_indices.pkl', 'rb') as f:
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
    st.image(image, caption='Uploaded Image', use_column_width=True)
    st.write("Classifying...")

    # Preprocess the image and make prediction
    image = preprocess_image(image)
    predictions = model.predict(image)
    top_pred_idx = np.argmax(predictions, axis=1)[0]

    predicted_breed = index_to_class.get(top_pred_idx, "Unknown")
    st.write(f"Predicted Breed: {predicted_breed}")

    # Show probabilities for each breed
    prob_df = pd.DataFrame(predictions, columns=index_to_class.values())
    st.bar_chart(prob_df.T)
