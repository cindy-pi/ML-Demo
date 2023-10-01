
from flask import Flask, render_template, request, jsonify

app = Flask(__name__)


# Initial state of the buttons: json 
button_states = [
    {'Title': 'Run Demo 00 - System Layout', 	'Color': 'powderblue', 'Status': '00-init'},
    {'Title': 'Run Demo 01 - Deployment', 	'Color': 'powderblue', 'Status': '01-deployment'},
    {'Title': 'Run Demo 02 - Daemonset', 	'Color': 'powderblue', 'Status': '02-daemonset'},
    {'Title': 'Run Demo 03 - Job', 		'Color': 'powderblue', 'Status': '03-job'},
    {'Title': 'Run Demo 04 - Statefulset', 	'Color': 'powderblue', 'Status': '04-statefulset'}
]

@app.route('/')
def index():
    return render_template('index.html', button_states=button_states)

@app.route('/toggle/<button_id>')
def toggle_button(button_id):
    response_data = {'updatedButtons': []}
    for button in button_states:
        if button['Title'] == button_id:
            button['Color'] = 'palegreen'
        else:
            button['Color'] = 'powderblue'
        response_data['updatedButtons'].append({'id': button['Title'], 'color': button['Color'], 'text': button['Title']})

    print(response_data)  # this will print the dictionary to the console
    return jsonify(response_data)

if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=5000)


