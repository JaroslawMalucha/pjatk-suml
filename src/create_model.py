import os
import numpy as np
import pandas as pd
import tensorflow as tf
import pickle
from tensorflow.keras.preprocessing.image import ImageDataGenerator
from tensorflow.keras.applications import MobileNetV2
from tensorflow.keras.layers import Dense, GlobalAveragePooling2D
from tensorflow.keras.models import Model
from tensorflow.keras.optimizers import Adam

# Load and preprocess data
labels_df = pd.read_csv('Data\\labels.csv')
labels_df['id'] = labels_df['id'].apply(lambda x: f"{x}.jpg")

train_dir = 'Data\\train'
valid_images = []
for img in labels_df['id']:
    if os.path.isfile(os.path.join(train_dir, img)):
        valid_images.append(img)
labels_df = labels_df[labels_df['id'].isin(valid_images)]
datagen = ImageDataGenerator(validation_split=0.2, rescale=1./255)

train_generator = datagen.flow_from_dataframe(
    labels_df,
    directory=train_dir,
    x_col='id',
    y_col='breed',
    subset='training',
    class_mode='categorical',
    target_size=(224, 224),
    batch_size=32
)

validation_generator = datagen.flow_from_dataframe(
    labels_df,
    directory=train_dir,
    x_col='id',
    y_col='breed',
    subset='validation',
    class_mode='categorical',
    target_size=(224, 224),
    batch_size=32
)

# Load pre-trained MobileNetV2 and add custom layers
base_model = MobileNetV2(weights='imagenet', include_top=False, input_shape=(224, 224, 3))
x = base_model.output
x = GlobalAveragePooling2D()(x)
x = Dense(1024, activation='relu')(x)
predictions = Dense(len(train_generator.class_indices), activation='softmax')(x)

model = Model(inputs=base_model.input, outputs=predictions)
for layer in base_model.layers:
    layer.trainable = False

model.compile(optimizer=Adam(), loss='categorical_crossentropy', metrics=['accuracy'])

# Train the model
model.fit(train_generator, validation_data=validation_generator, epochs=10)

# Save the model
model.save('dog_breed_classifier.h5')

# Save the class indices
with open('class_indices.pkl', 'wb') as f:
    pickle.dump(train_generator.class_indices, f)

