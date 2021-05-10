#democracy level predictor


DESCRIPTION:

In this repository, you will find the analysis of the democracy level of countries with some selected values, and models to predict their values. Moreover, there is a part for creating Databank and application of some SQL queries.


DATA;

World Bank Indicator, Penn World Table, Freedom House Index, Polity5, Corruption Index

some used methods;

#pivotting dataframe to make score values as column
    df_fhouse = df_fhouse.pivot_table(columns=['score'], values=['value'], aggfunc='first', index=['country','variable']).reset_index()

#to create an useable column list, by eliminatinf "[]" and adding year and second variable 
    crt_list = ['rank','country']
    for i in tables[4].columns[2:]:
        for j in ['_score','_delta']:
            a = i[0][:4]+j
            if a not in crt_list:
                crt_list.append(a)

#using where clauses to get line plot for each status
    for i in ['F','NF','PF']:
        str_sql =f"select pe.hc, w.life_expectancy, s.Status \
        from penn pe \
        join world_bank w\
        on (w.countrycode = pe.countrycode ) and (w.year = pe.year)\
        join freedom_house s\
        on (s.country = w.country ) and (s.year = w.year)\
        where s.Status = '{i}'"
        sns.lmplot(data = pd.read_sql(str_sql, engine), x='hc', y='life_expectancy')
        plt.title(i)
        plt.show()

#getting time requirment for the model
        now = time.time()
        rand = RandomForestClassifier()
        rand.fit(X_train, y_train)
        now1 = time.time()
        y_pred = rand.predict(X_test)
        now2 = time.time()
        rand_f = f1_score(y_test,y_pred, average='weighted')

#droppping multi correlated columns according to their correlation with dependet variable
    def drop_multi_corr(df, target, value=0.7):
        df_c = df.copy()
        df_c = df_c._get_numeric_data()
        df_t =df_c[[target]]
        df_c.drop(target, 1, inplace=True)
        drop_list=[]
        for i in range(len(df_c.columns)-1):
            
            for j in range(i,len(df_c.columns)-1):
                 
                num = df_c.iloc[:,i].corr(df_c.iloc[:,j+1])

                if (num > value) or (num < -value):
                    if df_t[target].corr(df_c.iloc[:,i])*df_t[target].corr(df_c.iloc[:,i]) < df_t[target].corr(df_c.iloc[:,j+1])*df_t[target].corr(df_c.iloc[:,j+1]):
                        drop_list.append(df_c.columns[i])
                        print(df_c.columns[i])

                    else:
                        drop_list.append(df_c.columns[j+1])
                        print(df_c.columns[j+1])

        df_c.drop(columns= drop_list, inplace=True)
        
        return pd.concat([df_c,df_t,df.drop(columns = df._get_numeric_data().columns)],1)


# calculation of each country shares' at the world level
    df_model['share_of_pop']= df_model[['pop','year']].apply(lambda x: x['pop'] / (df_temp_gr['pop'][x.year]), 1)

Some insights:

1. The correlation between Polity5 and Freedom House Index is high, and when crosstab is used, then it seems that some missing values of the index can be filled regarding the values of Polity5

2. Because of data availability and stability, the dataset covers after 2000. 

3. The share of each country at the world level is calculated for GDP and population in order to measure its degree of world power.

4. According to results of Random Forest Model;
            - The main determinant factor to predict the democracy level is human capital. 
            - Second important factor is countries' share of world GDP
            - Exchange Rate and fixed capital formation as a share of GDP are the following determinant factors. 

5. For the one country analysis, KNeighborsClassifier was best the predictor. In terms of results of logistic regression; while the major positive determinant factor is human capital, the negative one  military expenditure as share GDP







