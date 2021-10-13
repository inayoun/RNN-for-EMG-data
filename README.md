# RNN Algorithm analyzing EMG data

Parameters needed: EMG wave data, 'Muscle Name', 'Age', 'Gender', 'CK', 'PatientNumber'

toWave file converts the exported .txt EMG data into wave data. Provided in Python and MATLAB, can convert several files at once, or a singular file to visualize EMG data.
RNN.m takes data (non EMG patient data) and the wave signal data as inputs. Using MATLAB's deeplearning toolbox, creates a Long Short-Term Memory Network, then splits the data to train and test the network. 
