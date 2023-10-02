
from flask import Flask, render_template, request, jsonify
import subprocess

app = Flask(__name__)


# Initial state of the buttons: json 
button_states = [
    {'Title': 'Run Demo 00 - System Layout',    'Color': 'powderblue', 'Running': '/usr/src/app/00-Init/run.sh'},
    {'Title': 'Run Demo 01 - Deployment',       'Color': 'powderblue', 'Running': '/usr/src/app/01-Deployment/run.sh'},
    {'Title': 'Run Demo 02 - Daemonset',        'Color': 'powderblue', 'Running': '/usr/src/app/02-Daemonset/run.sh'},
    {'Title': 'Run Demo 03 - Job',              'Color': 'powderblue', 'Running': '/usr/src/app/03-Job/run.sh'},
    {'Title': 'Run Demo 04 - Statefulset',      'Color': 'powderblue', 'Running': '/usr/src/app/04-Statefulset/run.sh'}
]

@app.route('/')
def index():
    return render_template('index.html', button_states=button_states)

@app.route('/toggle/<button_id>')
def toggle_button(button_id):
    response_data = {'updatedButtons': []}
    for button in button_states:
        if button['Title'] == button_id:
            button['Color'] = 'salom'
            subprocess.run(["echo", button['Running']], check=True)
            subprocess.run([button['Running']], check=True)
            button['Color'] = 'palegreen'
        else:
            button['Color'] = 'powderblue'
        response_data['updatedButtons'].append({'id': button['Title'], 'color': button['Color'], 'text': button['Title']})

    print(response_data)  # this will print the dictionary to the console
    return jsonify(response_data)

if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=5000)


