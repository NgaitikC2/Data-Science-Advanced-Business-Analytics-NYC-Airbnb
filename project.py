import pandas as pd 
import matplotlib.pyplot as plt 
import numpy as np

df = pd.read_csv('/Users/alvis/Desktop/Project/listing789.csv', sep = ',' )

# df = df.groupby('Month').agg(
#     min=pd.NamedAgg(column='reviews_per_month', aggfunc=min),
#     mean=pd.NamedAgg(column='reviews_per_month', aggfunc=np.mean),
#     max=pd.NamedAgg(column='reviews_per_month', aggfunc=max),
# )

# df.plot.bar(rot=0)
# plt.ylabel('Average Monthly Reviews')
# plt.show()


## only take mean for considerations
df = df.groupby('Month').agg(
    mean=pd.NamedAgg(column='reviews_per_month', aggfunc=np.mean),
)

df.plot.bar(rot=0)
plt.ylabel('Average Monthly_Review')
plt.show()

df = df.groupby('Month').agg(
    max=pd.NamedAgg(column='reviews_per_month', aggfunc=max),
)

df.plot.bar(rot=0)
plt.ylabel('Maximum Monthly_Review')
plt.show()

df = df.groupby('Month').agg(
    min=pd.NamedAgg(column='reviews_per_month', aggfunc=min),
)

df.plot.bar(rot=0)
plt.ylabel('Minimum Monthly_Review')
plt.show()