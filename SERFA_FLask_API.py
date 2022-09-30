import numpy as np
import librosa
import pickle
from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/predict', methods=['POST'])
def predict():
  if(request.method == 'POST'):
        audio_file = request.files['file']
        loaded_model = pickle.load(open('ML_Model.sav', 'rb'))
        X, sample_rate = librosa.load(audio_file, res_type='kaiser_fast')
        result = np.array([])
        mfccs = np.mean(librosa.feature.mfcc(y=X, sr=sample_rate, n_mfcc=40).T, axis=0)
        result = np.hstack((result, mfccs))
        ans = loaded_model.predict([result])
        qwe = ans[0];
        res = {"emotion": qwe}
        return jsonify(res)

if(__name__ == "__main__"):  app.run(debug=True, port=4000)
