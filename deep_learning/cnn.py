import streamlit as st
import pickle
import pandas as pd
import numpy as np
from PIL import Image, ImageFile
ImageFile.LOAD_TRUNCATED_IMAGES = True
from tensorflow.keras.preprocessing.image import img_to_array
import tensorflow
from keras.models import load_model
from sklearn.ensemble import RandomForestClassifier
from skimage.color import rgba2rgb

def main():
    st.title("Upload + Classification Example")







    uploaded_file = st.file_uploader("Choose an image...", type="jpg")
    if uploaded_file is not None:
        l = []
        image = Image.open(uploaded_file)
        img = image.resize((128, 128), Image.ANTIALIAS)
        X = (img_to_array(img) / 255)

        l.append(X)
        l.append(X)
        X = np.array((l))
        st.image(image, caption='Uploaded Image.', use_column_width=True)
        st.write("")





        if st.button('submit'):

            st.write('Classifying...')

            predict_hand = load_model('mod_hand.h5')
            label = predict_hand.predict(X)
            a = np.round(label)[0][0]
            predict_box_not = load_model('mod_box_not.h5')
            label_box_not = predict_box_not(X)
            box_or_not = np.round(label_box_not)[0][0]
            st.write('Results...')

            if (box_or_not == 1) or (a == 1):
                st.write('there is either box or handy')
                predict_box_handy = load_model('box_handy.h5')
                label_box_handy = predict_box_handy(X)
                bh = np.round(label_box_handy)[0][0]

                if bh == 1:
                    st.write('and...')
                    predict_box = load_model('mod_box.h5')
                    label_box = predict_box(X)
                    b = np.round(label_box)[0][0]
                    if b == 0:
                        st.write('it is a apple box')
                    else:
                        st.write('it is a samsung box')

                else:
                    st.write('and...')
                    predict_tas = load_model('mod_tas.h5')
                    label_type = predict_tas.predict(X)
                    t = np.round(label_type)[0][0]
                    if t == 1:
                        st.write('it is a touch screen phone')
                        st.write('and...')
                        predict = load_model('model.h5')
                        label_three = predict(X)
                        three = np.argmax(label_three, 1)[0]
                        if three == 0:
                            st.write('it is an apple within three possibilities ')
                        elif three == 1:
                            st.write('it is a samsung within three possibilities ')
                        else:
                            st.write('it is an other type within three possibilities ')
                        st.write('and...')
                        predict2 = load_model('model2.h5')
                        label_two = predict2(X)
                        two = np.round(label_two)[0][0]
                        if two == 0:
                            st.write('it is a apple within two possibilities')
                        elif three == 1:
                            st.write('it is a samsung within two possibilities')

                    else:
                        st.write('it is not a touch screen phone')

            else:
                st.write('there in neither box nor handy')











if __name__ == '__main__':
    main()