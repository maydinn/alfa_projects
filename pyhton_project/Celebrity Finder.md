Celebrity Finder

DESCRIPTION:

In this repository, you will find a GUI application of python, which finds celebrities who were born on the same day and year

DATA:

Wikipedia

examples of some important used methods:

#cleaning of citation brackets from datafile
def clean_klma(x):
    m = ""
    flag = True
    for i in x:
        if i == "[":
            flag = False
        elif i == "]":
            flag = True
            continue
        if flag:
            m += i
    return m

df_m['data'] = df_m.data.apply(clean_klma)


###Function executed when Button "Year of Birth vs. Age" is used to create a new window, and showed scatter plot of the number of people who were born on the same day over years. 
def createNewWindow():
    window = Toplevel(fenster)
    
    ###Match dropdown string value for month with numerical value for datatset call
    month=  variable_m.get()
    day=  e6.get()  
    if month == "January":
        month =1.0
    elif month == "Februar":
        month =2.0
    elif month == "March":
        month =3.0
    elif month == "April":
        month =4.0
    elif month == "May":
        month =5.0
    elif month == "June":
        month =6.0
    elif month == "July":
        month =7.0
    elif month == "August":
        month =8.0
    elif month == "September":
        month =9.0
    elif month == "October":
        month =10.0
    elif month == "November":
        month =11.0
    elif month == "December":
        month =12.0
    if day in ['01','02','03','04','05','06','07','08','09']:
        day = day[1]
    day = float(day)

    ###Create subdatasets of stars_data where column month and column day match the input value by the user
    data=df[(df['month'] == month) & (df['day'] == day)]
    
    ###Create plot for Birthyear vs. Age
    fig = plt.figure(figsize=(4, 5))
    plt.scatter(x="birth",y="alter", alpha=0.5, data=data)
    plt.title('Year of Birth vs. Age')
    plt.xlabel('Year of Birth')
    plt.ylabel('Age')
    ### specify the window as master
    canvas = FigureCanvasTkAgg(fig, master=window)
    canvas.draw()
    canvas.get_tk_widget().grid(row=1, column=0, ipadx=40, ipady=20)

Some insights:

1) In order to access data I used Selenium

2) Tkinter applied in order to make GUI form

3) Because of the formatting changes in Wikipedia pages, data about a few days of births could not be gotten into the dataset.

4)	Since there can be no available data for a given date, the length of the dataframe should be checked always in advance.

Limitation & Further:

1) Outcomes are based on only the given date, gender and country might be also included. 

2) Besides getting the name of celebrities, important events might be also another good option



