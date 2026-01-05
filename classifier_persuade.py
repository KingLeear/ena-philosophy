#import a dataset from kaggle
from gettext import install
import pip
pip install pandas

import pandas as pd
#install pandas if not already installed
import kagglehub

path = kagglehub.dataset_download("julesking/tla-lab-persuade-dataset")

print("Path to dataset files:", path)
