import pandas as pd

url="https://raw.githubusercontent.com/billyrohh/dataset/master/dataset3.csv"

df = pd.read_csv(url,sep = ';')

df.to_csv('dataset3.csv', sep=',', index=False)