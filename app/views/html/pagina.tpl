<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Minha segunda página com o BMVC</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f0f4f8;
            color: #333;
            margin: 0;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        div {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            text-align: center;
        }

        h2 {
            color: #007BFF;
            margin-bottom: 20px;
        }

        h3 {
            color: #555;
            margin-bottom: 20px;
        }

        p {
            font-size: 1.2em;
            margin: 10px 0;
            color: #666;
        }

        .button, .login-button {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #007BFF;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 1em;
            transition: background-color 0.3s ease;
        }

        .button:hover, .login-button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

    % if transfered:

        <div>
            <h2>Bem-vindo(a) <span>{{current_user.username}}</span> à página do usuário</h2>
            <h3>Aqui você tem acesso aos seus dados e pode alterá-los</h3>
            <h2>Dados do Usuário:</h2>
            <p>Username: {{current_user.username}}</p>
            <p>Password: {{current_user.password}}</p>
            <a href="/mudar" class="button">Mudar informações</a>
        </div>

    % else:

        <div>
            <h2>Esta é a página do usuário, para ter acesso, primeiro faça o login</h2>
            <a href="portal" class="login-button">Login</a>
        </div>

    % end

</body>
</html>

