import os.path
import matplotlib.pyplot as plt
import numpy as np

#text file이 들어있는 path + text fileName
pathName = "C:/Users/Rehabilitation/Desktop/emg/"
fileName = os.path.join(pathName, "01051127751 - 2020-07-30 3_24_44 PM - Needle EMG - R ADD POLLICIS - Site 1.txt")

traceDuration = 0
sampleNum = 200
tSignal = []

#text file line별로 읽어서 content array에 옮김
with open (fileName, 'r', errors='ignore') as f:
    content = f.readlines()
content = [x.strip() for x in content]

#content array를 읽고 signal,trace duration 추출
for c in content:
    if c.startswith('Sweep  Data(mV)<960>='):
        tSignal.append(float(c[21:]))
    elif c.startswith('Trace Duration(ms)='):
        traceDuration = float(c[20:])/1000

#여기부터 그래프 부분입니다.
time = np.arange(0, traceDuration/1000, traceDuration*len(tSignal)/1000 - traceDuration/1000).tolist()

plt.plot(time, tSignal)
plt.xlabel("time (s)")
plt.show()
