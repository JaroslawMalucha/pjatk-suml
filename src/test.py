import zipfile
import os
import pandas as pd
from autogluon.vision import ImagePredictor
import autogluon
import autogluon.vision

# train_zip = "./data/train.zip"
# test_zip = "./data/test.zip"
train_folder = "./data/dogs/train"
test_folder = "./data/dogs/test"
models_folder = "./models/dogs"

# with zipfile.ZipFile(train_zip, 'r') as z:
#     z.extractall(train_folder)

# with zipfile.ZipFile(test_zip, 'r') as z:
#     z.extractall(test_folder)

train_labels_file = "./data/dogs/labels.csv"
train_labels_df = pd.read_csv(train_labels_file)

def get_image_path_train(image_id):
    return os.path.join(train_folder, f"{image_id}.jpg")

train_labels_df['image'] = train_labels_df['id'].apply(get_image_path_train)

test_image_ids = [os.path.splitext(img)[0] for img in os.listdir(test_folder) if img.endswith(".jpg")]
test_df = pd.DataFrame({'id': test_image_ids})

def get_image_path_test(image_id):
    return os.path.join(test_folder, f"{image_id}.jpg")

test_df['image'] = test_df['id'].apply(get_image_path_test)

predictor = ImagePredictor(label='breed', path=models_folder, eval_metric='accuracy')
predictor.fit(train_labels_df, presets='medium_quality_faster_train') # ValueError: Preset 'medium_quality' was not found. Valid presets: ['best_quality', 'good_quality_fast_inference', 'medium_quality_faster_train','medium_quality_faster_inference']
# 23:57 - start
# <1:09 - finish

predictions = predictor.predict(test_df)
print(predictions)

print(predictor.leaderboard(train_labels_df))
