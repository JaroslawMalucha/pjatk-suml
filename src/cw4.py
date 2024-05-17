from autogluon.tabular import TabularDataset, TabularPredictor
import pandas as pd

# titanic data
train_csv = "./data/titanic/train.csv"
test_csv = "./data/titanic/test.csv"
train = pd.read_csv(train_csv)
test = pd.read_csv(test_csv)

train_data = TabularDataset(train)
test_data = TabularDataset(test)

predictor = TabularPredictor(
    label="Survived", path="./models/titanic", eval_metric="roc_auc"
).fit(train_data=train_data, presets="medium_quality") # presets="good_quality"

predictions = predictor.predict(data=test_data)
print(predictions)


print(predictor.leaderboard())




