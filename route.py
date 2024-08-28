from app.controllers.datarecord import DataRecord
from app.controllers.application import Application
import logging

datarecord = DataRecord()
active_sessions = {}

from bottle import Bottle, route, run, request, redirect, template, static_file, response

app = Bottle()
ctl = Application()


#-----------------------------------------------------------------------------
# Rotas:

@app.route('/static/<filepath:path>')
def serve_static(filepath):
    return static_file(filepath, root='./app/static')

@app.route('/helper')
def helper():
    return ctl.render('helper')

#-----------------------------------------------------------------------------
# Suas rotas aqui:

@app.route('/pagina', methods=['GET'])
@app.route('/pagina/<username>', methods=['GET'])
def action_pagina(username=None):
    if not username:
        return ctl.render('pagina')
    else:
        return ctl.render('pagina',parameter = username)
    


@app.route('/portal', method='GET')
def login():
    return ctl.render('portal')


@app.route('/portal', method='POST')
def action_portal():

    username = request.forms.get('username')
    password = request.forms.get('password')
    session_id, username= ctl.authenticate_user(username, password)
    print(f"Username: {username}")
    print(f"Session ID: {session_id}")
    if session_id:
        response.set_cookie('session_id', session_id, httponly=True, secure=True, max_age=3600)
        active_sessions[session_id] = username
        if datarecord.getAdmin(username):
            datarecord.read()
            user_accounts = datarecord.return_users()
            return template('app/views/html/admin', user_accounts=user_accounts)
        return redirect(f'/pagina/{username}')
    else:
        return redirect('/portal')

@app.route('/logout', method='POST')
def logout():
    ctl.logout_user()
    response.delete_cookie('session_id')
    redirect('/')

@app.route('/admin_change', method='POST')
def edit_user():
    try:
        # Parse the JSON body
        user_data = request.json
        if not user_data:
            raise ValueError("No JSON data received")
        username = user_data.get('username')
        new_username = user_data.get('new_username')
        new_password = user_data.get('new_password')

        print(f"Received data - username: {username}, new_username: {new_username}, new_password: {new_password}")

        # Call the mudar method to update the user
        result = ctl.mudar_user(username, new_username, new_password)

        if result:
            response.status = 200
            return {'status': 'success', 'message': 'User updated successfully'}
        else:
            response.status = 400
            return {'status': 'error', 'message': 'Invalid input'}

    except Exception as e:
        response.status = 500
        return {'status': 'error', 'message': str(e)}
    

#-----------------------------------------------------------------------------
@app.route('/')
def inicio():
    return ctl.render('inicial')

#-----------------------------------------------------------------------------


@app.route('/mudar', method= 'GET')
@app.route('/mudar/<username>', method= 'GET')
def action_mudar(username=None):
    if not username:
        return ctl.render('mudar')
    else:
        return ctl.render('mudar',parameter = username)

@app.route('/mudar/<username>', method='POST')
def action_mudando(username):
    print("POST /mudar/<username> route hit")
    print("Form data:", dict(request.forms))
    new_username = request.forms.get('new_username')
    new_password = request.forms.get('new_password')
    print(f"Received username: {new_username}, password: {new_password}")
    success = ctl.mudar_user(username, new_username, new_password)
    print(f"Operation success: {success}")
    if success:
        return redirect('/portal')
    else:
        return ctl.render('mudar', parameter=username)





#-----------------------------------------------------------------------------
@app.route('/register', method='GET')
def register():
    return ctl.render('register')


@app.route('/register', method='POST')
def action_register():
    username = request.forms.get('username')
    password = request.forms.get('password')
    success = ctl.register_user(username, password)

    if success:
        return redirect('/portal')
    else:
        return ctl.render('register')


if __name__ == '__main__':

    run(app=app, host='localhost', port=8081, debug=True, reloader= True)


