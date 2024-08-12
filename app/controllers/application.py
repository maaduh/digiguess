from app.controllers.datarecord import DataRecord
from bottle import template, redirect, request


class Application():

    def __init__(self):

        self.pages = {
            'pagina': self.pagina,
            'portal': self.portal,
            'inicial': self.inicial,
            'mudar': self.mudar,
            'register': self.register
        }

        self.__model= DataRecord()
        self.__current_loginusername= None

    def register_user(self, username, password):
        if self.__model.user_exists(username):
            return False
        self.__model.book(username, password)
        return True

    def render(self,page,parameter=None):
        content = self.pages.get(page, self.helper)
        if not parameter:
            return content()
        else:
            return content(parameter)


    def get_session_id(self):
        return request.get_cookie('session_id')


    def helper(self):
        return template('app/views/html/helper')


    def portal(self):
        return template('app/views/html/portal')

    def inicial(self):
        return template('app/views/html/inicial')

    def mudar(self):
        return template('app/views/html/mudar')

    def register(self):
        return template('app/views/html/register')


    def pagina(self,username=None):
        session_id = self.get_session_id()
        if username and session_id:
            if self.__model.getUserName(session_id) == username:
                user = self.__model.getCurrentUser(session_id)
                return template('app/views/html/pagina', \
                transfered=True, current_user=user)
            else:
                return template('app/views/html/pagina', \
                transfered=False)
        else:
            return template('app/views/html/pagina', \
            transfered=False)


    def is_authenticated(self, username):
        session_id = self.get_session_id()
        current_user = self.__model.getUserName(session_id)
        if username == current_user:
            return True
        else:
            return False


    def authenticate_user(self, username, password):
        self.logout_user()
        session_id = self.__model.checkUser(username, password)
        if session_id:
            self.__current_username= self.__model.getUserName(session_id)
            return session_id, username
        return None


    def logout_user(self):
        self.__current_username= None
        session_id = self.get_session_id()
        if session_id:
            self.__model.logout(session_id)
