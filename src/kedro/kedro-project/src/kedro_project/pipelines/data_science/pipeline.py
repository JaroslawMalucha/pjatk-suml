from kedro.pipeline import Pipeline, node, pipeline

from .nodes import train_model


# def create_pipeline(**kwargs) -> Pipeline:
#     return Pipeline(
#         [
#             node(
#                 func=train_model,
#                 inputs=["mid_train_generator", "mid_validation_generator"],
#                 outputs=["output_model", "output_model_class_indices"],
#                 name="train_model_node",
#             )
#         ]
#     )
