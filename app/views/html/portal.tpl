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

        h1 {
            color: #333;
            font-size: 2em;
            margin-bottom: 20px;
        }

        form {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 300px;
            text-align: center;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: bold;
            text-align: left;
        }

        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        input[type="submit"], button {
            width: 100%;
            padding: 10px;
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1em;
        }

        input[type="submit"]:hover, button:hover {
            background-color: #0056b3;
        }

        button {
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div>
        <h1>Login</h1>
        <form action="/portal" method="post">
            <label for="username">Nome:</label>
            <input id="username" name="username" type="text" required />

            <label for="password">Senha:</label>
            <input id="password" name="password" type="password" required />

            <input value="Login" type="submit" />
        </form>
        <form action="/logout" method="post">
            <button type="submit">Logout</button>
        </form>
    </div>
</body>
</html>
