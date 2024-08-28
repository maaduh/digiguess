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
        }

        li {
            margin-bottom: 10px;
        }

        button {
            margin-left: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        
            <h1>Portal do ADM</h1>
            <ul>
                % for user in user_accounts:
                <li>{{ user.username }} <button onclick="editUser('{{ user.username }}', '{{ user.password }}')">Edit</button></li>
                % end
            </ul>
    
    </div>
    <div class="box">
        <button onclick="window.location.href = '/';">Voltar</button>
    </div>

    <script>
        function editUser(username) {
            const newUsername = prompt("Enter new username for " + username, username);
            const newPassword = prompt("Enter new password for " + username);
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
                        alert('User updated successfully');
                        window.location.href = '/portal';
                        console.log('User updated successfully');
                    } else {
                        response.json().then(data => {
                            alert('Failed to update user: ' + data.message);
                        });
                    }
                }).catch(error => {
                    console.error('Error:', error);
                    alert('Failed to update user');
                });
            }
        }
        
       
        
    </script>
</body>
</html>