import streamlit as st
from PIL import Image

def main():
    st.title("Image Upload and Description App")

    # Upload image file
    uploaded_file = st.file_uploader("Choose an image...", type=["jpg", "jpeg", "png"])

    if uploaded_file is not None:
        # Display the uploaded image
        image = Image.open(uploaded_file)
        st.image(image, caption="Uploaded Image", use_column_width=True)

        # Allow user to provide a description for the image
        description = st.text_input("Enter a description for the image (optional):")

        if st.button("Save Description"):
            # Save the description (this is just a placeholder)
            if description:
                st.success(f"Description saved: {description}")
            else:
                st.warning("Please enter a description.")

if __name__ == "__main__":
    main()
