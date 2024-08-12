<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mudar</title>

</head>
<style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f3f4f6;
            color: #333;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            height: 100vh;
            margin: 0;
            padding: 0;
            text-align: center;
        }

        h1 {
            color: #007BFF;
            font-size: 3em;
            margin-bottom: 20px;
        }

        h2 {
            font-size: 1.5em;
            margin: 15px 0;
            color: #555;
            max-width: 600px;
        }

    </style>
<body>
    <div>
        <h1> Altere as informações de usuário </h1>

            <label for="username">Nome:</label>
            <input id="username" name="username" type="text" required />

            <label for="password">Senha:</label>
            <input id="password" name="password" type="password" required />

            <input value="submit" type="submit" />

    </div>
</body>
</html>
