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
            flex-direction: column;
            align-items: center;
            height: 100vh;
        }

        .container {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            text-align: center;
            margin-bottom: 20px;
        }

        h2 {
            color: #007BFF;
            margin-bottom: 20px;
            font-size: 1.5em;
        }

        h3 {
            color: #555;
            margin-bottom: 20px;
            font-size: 1.2em;
        }

        p {
            font-size: 1.1em;
            margin: 10px 0;
            color: #666;
        }

        canvas {
            border: 2px solid #000;
            background-color: #fff;
            margin-top: 20px;
            touch-action: none;
        }

        .button, .login-button, .logout-button {
            display: inline-block;
            margin: 0;
            padding: 10px 20px;
            background-color: #007BFF;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 1em;
            transition: background-color 0.3s ease;
            border: none;
            cursor: pointer;
            width: 100%;
            max-width: 200px;
        }

        .button:hover, .login-button:hover, .logout-button:hover {
            background-color: #0056b3;
        }

        .box {
            margin-top: 10px;
        }
    </style>
</head>
<body>

    % if transfered:
        <div class="container">
            <h2>Bem-vindo(a) <span>{{current_user.username}}</span> à página do usuário</h2>
            <h3>Aqui você tem acesso aos seus dados e pode alterá-los</h3>
            <h2>Dados do Usuário:</h2>
            <p>Username: {{current_user.username}}</p>
            <p>Password: {{current_user.password}}</p>
            <a href="/mudar/{{current_user.username}}" class="button">Mudar informações</a>
            <form action="/logout" method="post" class="box">
                <button type="submit" class="logout-button">Logout</button>
            </form>
        </div>

        <div class="container">
            <h1>Escreva o número que você deseja no quadro branco</h1>
            <canvas id="paintCanvas" width="280" height="280"></canvas>
            <div>
                <button id="sendButton">Enviar</button>
                <button id="clearButton">Limpar</button>
            </div>
            <div id="result"></div>
        </div>

        <script>
            const canvas = document.getElementById('paintCanvas');
            const ctx = canvas.getContext('2d');
            let painting = false;

            const scale = 10;
            ctx.scale(scale, scale);

            function startPosition(e) {
                painting = true;
                draw(e);
            }

            function endPosition() {
                painting = false;
                ctx.beginPath();
            }

            function getMousePos(e) {
                const rect = canvas.getBoundingClientRect();
                const x = (e.clientX - rect.left) / scale;
                const y = (e.clientY - rect.top) / scale;
                return { x, y };
            }

            function draw(e) {
                if (!painting) return;

                ctx.lineWidth = 1;
                ctx.lineCap = 'round';
                ctx.strokeStyle = 'black';

                const pos = getMousePos(e);
                ctx.lineTo(pos.x, pos.y);
                ctx.stroke();
                ctx.beginPath();
                ctx.moveTo(pos.x, pos.y);
            }

            canvas.addEventListener('mousedown', startPosition);
            canvas.addEventListener('mouseup', endPosition);
            canvas.addEventListener('mousemove', draw);

            document.getElementById('sendButton').addEventListener('click', function() {
                const dataURL = canvas.toDataURL('image/png');
                const username = '{{current_user.username}}';

                console.log('Sending data to server...');
            console.log(`Username: ${username}`);
            console.log('Image Data URL:', dataURL);
            console.log(`Data URL: ${dataURL.substring(0, 50)}...`); // Log the first 50 characters of the data URL
                fetch(`/pagina/${username}`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ image: dataURL })
                })
                .then(response => response.json())
                .then(data => {
                    document.getElementById('result').innerText = `Número previsto: ${data.prediction}`;
                })
                .catch(error => {
                    console.error('Erro:', error);
                    document.getElementById('result').innerText = `Erro na previsão.`;
                });
            });

            document.getElementById('clearButton').addEventListener('click', function() {
                ctx.clearRect(0, 0, canvas.width, canvas.height);
                ctx.beginPath();
                painting = false;
                document.getElementById('result').innerText = '';
            });
        </script>

    % else:
        <div class="container">
            <h2>Esta é a página do usuário, para ter acesso, primeiro faça o login</h2>
            <a href="/portal" class="login-button">Login</a>
        </div>
    % end

</body>
</html>