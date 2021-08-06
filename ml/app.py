import streamlit as st
import pickle
import pandas as pd
from sklearn.ensemble import RandomForestClassifier

def main():
    st.sidebar.title('Are you happy?')

    html_temp = """
    <div style="background-color:tomato;padding:10px">
    <h2 style="color:white;text-align:center;">Are you happy?</h2>
    </div><br><br>"""

    st.markdown(html_temp, unsafe_allow_html=True)

    economic_values = st.sidebar.slider("0 Your perception about economic values. income equality/ income differences ", value = 6 ,min_value=1,max_value = 10, step=1)
    corruption_preceptions = st.sidebar.slider("1. Your perception about corruption less corrupted/ more corrupted", 1, 10, 8,step=1)
    corruption_of_institutions = st.sidebar.slider("2. Your Perception about corruption in institutions less corrupted/ more corrupted", 1, 4,2, step=1)
    effect_of_immigration = st.sidebar.slider("3. Your perception about migration positive/negative", 0, 2,1 ,step=1)
    secure_in_neighborhood = st.sidebar.slider("4. Your perception about security in neigborhood more secured / less secured", 1, 4, 3,step=1)
    worried_about_risks_and_war = st.sidebar.slider("5. Your perception about your worrying about risks and wars more worried / less worried", 1, 4,3, step=1)
    science_and_technologie = st.sidebar.slider("6 Your perception about science and tech, it makes better / worse",1, 10, 6,step=1)
    importance_of_god = st.sidebar.slider("7 Your perception about importance of God less / more",1, 10, 8,step=1)
    religion_and_science = st.sidebar.slider("8 Your perception about religion and science religion over science / science over religion", 1, 4, 2,step=1)
    moral_rules = st.sidebar.slider("9 Your perception about moral values, hard to follow / easy",  1, 10, 5,step=1)
    Ethical_justification = st.sidebar.slider("10 Your perception about ethical justification less flexiable / more flexiable", 1, 10, 3,step=1)
    Interest_for_politics = st.sidebar.slider("11 Your perception about interest politics very/not much", 1, 4, 3,step=1)
    Political_action = st.sidebar.slider("12 Your perception about political action active/not active", 1, 3, 2,step=1)
    Electoral_integrity_battery = st.sidebar.slider("13 Your perception about electoral integrity free election/non free election", 1, 4,2, step=1)
    Importance_of_democracy = st.sidebar.slider("14 Your perception about importance of democracy not/very", 1, 10,8, step=1)
    Perceived_democraticness = st.sidebar.slider("15 Your perception about democracy in your country bad/god", 1, 10, 6,step=1)
    Satisfaction_with_system = st.sidebar.slider("16 Your perception about satifaction with the system not/very", 1, 10, 5,step=1)
    Respect_human_rights = st.sidebar.slider("17 Your perception about respect for human right very/not", 1, 4,2, step=1)
    Identity_levels = st.sidebar.slider("18 Your perception about idendity levels more/less", 1, 4,2, step=1)
    Social_class = st.sidebar.slider("19 Your perception about social class upper/lower", 1, 4, 2,step=1)
    nachbarn = st.sidebar.slider("20 Your perception about neigborhood more different/less", 1, 2, step=1)
    trust = st.sidebar.slider("21 Your perception about trust more/less", 1, 4, 2,step=1)
    active = st.sidebar.slider("22 Your perception about being social active non active/active", 0, 1, step=1)
    financial = st.sidebar.slider("23 Your perception about financial satisfction less/more", 1, 10, 6,step=1)
    main_goal = st.sidebar.slider("24 Your perception about main goal as your making your familiy proud important/not important", 1, 4, step=1)
    court = st.sidebar.slider("25 Your perception about confidance with court more/less" , 1, 4, 3, step=1)
    comparing_parents = st.sidebar.slider("26 Your perception about compering yourself with your family better/worse" , 1, 3, 2,step=1)
    family = st.sidebar.slider("27 Your perception about important of family very/not very", 1, 4, step=1)
    work = st.sidebar.slider("28 Your perception about importance of work very/not very" , 1, 4, step=1)

    my_dict = {
        'nachbarn': nachbarn,
        'trust': trust,
        'active': active,
        'main_goal': main_goal,
        'financial': financial,
        'court': court,
        'comparing_parents': comparing_parents,
        'family': family,
        'work': work,
        'economic_values': economic_values,
        'corruption_preceptions': corruption_preceptions,
        'corruption_of_institutions': corruption_of_institutions,
        'effect_of_immigration': effect_of_immigration,
        'secure_in_neighborhood': secure_in_neighborhood,
        'worried_about_risks_and_war': worried_about_risks_and_war,
        'science_and_technologie': science_and_technologie,
        'importance_of_god': importance_of_god,
        'religion_and_science': religion_and_science,
        'moral_rules': moral_rules,
        'Ethical_justification':Ethical_justification,
        'Interest_for_politics': Interest_for_politics,
        'Political_action': Political_action,
        'Electoral_integrity_battery': Electoral_integrity_battery,
        'Importance_of_democracy': Importance_of_democracy,
        'Perceived_democraticness': Perceived_democraticness,
        'Satisfaction_with_system': Satisfaction_with_system,
        'Respect_human_rights': Respect_human_rights,
        'Identity_levels': Identity_levels,
        'Social_class': Social_class
    }

    df = (pd.DataFrame.from_dict([my_dict]))
    df_ = df.T
    df_ = df_.rename(columns={0: 'values'})

    if st.button('see the values'):
        st.table(df_)


    model = pickle.load(open('saved_model', 'rb'))
    prediction = model.predict(df)
    prediction = prediction[0]
    prediction_prb = model.predict_proba(df)

    if prediction == 'happy':
        percent = prediction_prb[0][0]
    else:
        percent = prediction_prb[0][1]

    st.header("The configuration of your happiness score is below")

    st.subheader("Press predict if configuration is okay")

    if st.button('Predict'):
        if prediction == 'happy':
            st.success(f"you are {round(percent * 100,2)} % happy")
        else:
            st.warning(f"you are {round((1-percent) * 100,2)} % happy ")


if __name__ == '__main__':
    main()