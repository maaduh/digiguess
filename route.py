from app.controllers.application import Application
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
        return ctl.render('pagina',username)


@app.route('/portal', method='GET')
def login():
    return ctl.render('portal')


@app.route('/portal', method='POST')
def action_portal():
    username = request.forms.get('username')
    password = request.forms.get('password')
    session_id, username= ctl.authenticate_user(username, password)
    if session_id:
        response.set_cookie('session_id', session_id, httponly=True, \
        secure=True, max_age=3600)
        redirect(f'/pagina/{username}')
    else:
        return redirect('/portal')

@app.route('/logout', method='POST')
def logout():
    ctl.logout_user()
    response.delete_cookie('session_id')
    redirect('/helper')


#-----------------------------------------------------------------------------
@app.route('/inicial')
def inicio():
    return ctl.render('inicial')

#-----------------------------------------------------------------------------

@app.route('/mudar')
def mudar():
    return ctl.render('mudar')

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

    run(app, host='localhost', port=8081, debug=True)


