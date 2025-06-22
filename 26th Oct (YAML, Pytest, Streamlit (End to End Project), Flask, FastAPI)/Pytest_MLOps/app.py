# i am testing with the flask code
from flask import Flask
app = Flask(__name__) # in this format only

@app.route('/')
def hello_world():
     return "Hello from my CI/CD powered Flash APP! VI"

if __name__ == '__main__':
     app.run(debug=True,host ='0.0.0.0',port=5001)