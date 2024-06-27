from typing import Dict, Tuple

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

def train_model(train_generator, validation_generator):

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

    # # Save the model
    # model.save(output_model_path)

    # # Save the class indices
    # with open(output_class_indices_path, 'wb') as f:
    #     pickle.dump(train_generator.class_indices, f)


    return (model, train_generator.class_indices)


