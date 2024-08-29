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

        ul {
            list-style-type: none;
            padding: 0;
            margin: 0;
        }

        li {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #f9f9f9;
            padding: 8px 15px;
            border-radius: 5px;
            margin-bottom: 10px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
        }

        button {
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 5px 10px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #0056b3;
        }

        .back-button {
            margin-top: 20px;
            background-color: #dc3545;
        }

        .back-button:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Portal do ADM</h1>
        <ul>
            % for user in user_accounts:
            <li>{{ user.username }} <button onclick="editUser('{{ user.username }}')">Editar</button></li>
            % end
        </ul>
        <button class="back-button" onclick="window.location.href = '/';">Voltar</button>
    </div>

    <script>
        function editUser(username) {
            const newUsername = prompt("Digite o novo nome de usuário para " + username, username);
            const newPassword = prompt("Digite a nova senha para " + username);
            if (newUsername && newPassword) {
                fetch(`/admin_change`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        username: username,
                        new_username: newUsername,
                        new_password: newPassword
                    })
                }).then(response => {
                    if (response.ok) {
                        alert('Usuário atualizado com sucesso');
                        window.location.href = '/portal';
                    } else {
                        response.json().then(data => {
                            alert('Falha ao atualizar o usuário: ' + data.message);
                        });
                    }
                }).catch(error => {
                    console.error('Erro:', error);
                    alert('Falha ao atualizar o usuário');
                });
            }
        }
    </script>
</body>
</html>

        
       
        
    </script>
</body>
</html>