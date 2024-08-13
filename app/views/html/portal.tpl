<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Portal</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f8ff;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
            width: 320px;
            text-align: center;
        }

        h1 {
            color: #333;
            font-size: 2.2em;
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-bottom: 10px;
            color: #555;
            font-weight: bold;
            text-align: left;
        }

        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 6px;
            box-sizing: border-box;
        }

        .button-container {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .button-container input[type="submit"], .button-container a {
            width: 100%;
            padding: 12px;
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 1em;
            text-decoration: none;
            text-align: center;
            box-sizing: border-box;
        }

        .button-container input[type="submit"]:hover, .button-container a:hover {
            background-color: #0056b3;
        }

        .box {
            margin-top: 20px;
        }

        .box button {
            width: 100%;
            padding: 12px;
            background-color: #FF6347;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 1em;
        }

        .box button:hover {
            background-color: #e5533d;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Login</h1>
        <form action="/portal" method="post">
            <label for="username">Nome:</label>
            <input id="username" name="username" type="text" required />

            <label for="password">Senha:</label>
            <input id="password" name="password" type="password" required />

            <div class="button-container">
                <input value="Login" type="submit" />
                <a href="/register" class="button">Registrar</a>
            </div>
        </form>
    </div>
</body>
</html>


