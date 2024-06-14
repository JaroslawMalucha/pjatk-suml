from kedro.pipeline import Pipeline, node, pipeline

from .nodes import preprocess
from .nodes import preprocess_and_train_model


# def create_pipeline(**kwargs) -> Pipeline:
#     return Pipeline(
#         [
#             node(
#                 func=preprocess,
#                 inputs=[],
#                 outputs=["mid_train_generator", "mid_validation_generator"],
#                 name="preprocess_node",
#             )
#         ]
#     )
    
def create_pipeline(**kwargs) -> Pipeline:
    return Pipeline(
        [
            node(
                func=preprocess_and_train_model,
                inputs=[],
                outputs=["output_model", "output_model_class_indices"],
                name="preprocess_and_train_model_node",
            )
        ]
    )
