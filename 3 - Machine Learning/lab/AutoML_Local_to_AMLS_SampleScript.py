# -*- coding: utf-8 -*-
"""
DSBA 6190

Sample Script to Submit AutoML Experiment
from Local Machine to AMLS

By: Colby T. Ford, Ph.D.
"""
#%%
"""
Load in Libraries
"""
import json
import logging

import numpy as np
import pandas as pd

## pip install -U azureml-sdk --user
## pip install -U azureml.core --user
## pip install -U azureml.train.automl --user

## On macOS, you may have to install `brew install libomp` and then `pip install lightgbm` and run the following:
## import os
## os.environ['KMP_DUPLICATE_LIB_OK']='True'

import azureml.core
from azureml.core.experiment import Experiment
from azureml.core.workspace import Workspace
from azureml.train.automl import AutoMLConfig
from azureml.train.automl.run import AutoMLRun

#%%
"""
Get Information for the AMLS in Azure
"""
subscription_id = "<your_subscription_id>" #0bb59590-d012-407d-a545-7513aae8c4a7
resource_group = "<your_resource_group>" #DSBA6190-<groupname>
workspace_name = "<your_amls_workspace>" #dsba6190_<groupname>_ml
workspace_region = "<your_region>" #eastus2

#%%
"""
Setup the Workspace
"""
# Import the Workspace class and check the Azure ML SDK version.
from azureml.core import Workspace

ws = Workspace.create(name = workspace_name,
                      subscription_id = subscription_id,
                      resource_group = resource_group,
                      location = workspace_region,
                      exist_ok=True)
ws.get_details()

#%%
"""
Define the Experiment and Project
"""
#ws = Workspace.from_config()

# choose a name for experiment
experiment_name = '<your_experiment_name>'
# project folder
project_folder = './aml_project/<your_experiment_name>'

experiment=Experiment(ws, experiment_name)

output = {}
output['SDK version'] = azureml.core.VERSION
output['Subscription ID'] = ws.subscription_id
output['Workspace'] = ws.name
output['Resource Group'] = ws.resource_group
output['Location'] = ws.location
output['Project Directory'] = project_folder
output['Experiment Name'] = experiment.name
pd.set_option('display.max_colwidth', -1)
outputDf = pd.DataFrame(data = output, index = [''])
outputDf.T

#%%
"""
Load in Data
"""
## Usually 2 numpy-based arrays (one for the X variables and one for the y variable)

import pickle
X_train = pickle.load(open("../data/X_train.pkl", "rb"))
y_train = pickle.load(open("../data/y_train.pkl", "rb"))

#%%
"""
Configure AutoML
"""
automl_config = AutoMLConfig(task = 'regression',
                             name = experiment_name,
                             debug_log = 'automl_errors.log',
                             primary_metric = 'normalized_root_mean_squared_error',
                             iteration_timeout_minutes = 20,
                             iterations = 20,
                             max_cores_per_iteration = 1,
                             preprocess = True,
                             n_cross_validations = 5,
                             verbosity = logging.INFO,
                             X = X_train, 
                             y = y_train,
                             path = project_folder)

#%%
"""
Submit to AutoML
"""
local_run = experiment.submit(automl_config, show_output = True)