<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mudança</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f8ff;
            color: #333;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            width: 350px;
            text-align: center;
        }

        h1 {
            font-size: 26px;
            margin-bottom: 15px;
            color: #007BFF;
        }

        h2, h3 {
            font-size: 18px;
            margin-bottom: 20px;
            color: #555;
        }

        form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 12px;
            margin: 12px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            text-align: center;
            font-size: 14px;
        }

        input[type="submit"] {
            background-color: #007BFF;
            color: white;
            border: none;
            padding: 12px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }

        .login-button {
            display: inline-block;
            background-color: #007BFF;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        .login-button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    % if transfered:
        <div class="container">
            <h1>Vamos mudar suas informações!</h1>
            <h3>Todos os campos precisam ser preenchidos, se não quiser mudar algo, escreva igual</h3>
            <form action="/mudar/{{current_user.username}}" method="post">
                <input name="new_username" type="text" placeholder="Username" required />
                <input name="new_password" type="password" placeholder="Password" required />
                <input value="Mudar" type="submit" />
            </form>
        </div>
    % else:
        <div class="container">
            <h2>Esta é a página de mudanças no usuário e senha, para entrar faça o login</h2>
            <a href="/portal" class="login-button">Login</a>
        </div>
    % end
</body>
</html>
