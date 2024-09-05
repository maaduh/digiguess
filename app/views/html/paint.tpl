<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Web Paint - Adivinhador de Números</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            background-color: #f0f0f0;
        }
        h1 {
            color: #333;
        }
        canvas {
            border: 2px solid #000;
            background-color: #fff;
            margin-top: 20px;
            touch-action: none;
        }
        button {
            margin-top: 20px;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            border: none;
            background-color: #4CAF50;
            color: white;
            border-radius: 5px;
        }
        button:hover {
            background-color: #45a049;
        }
        #result {
            margin-top: 20px;
            font-size: 20px;
            color: #333;
        }
    </style>
</head>
<body>
    <h1>Escreva o número que você deseja no quadro branco</h1>
    <canvas id="paintCanvas" width="280" height="280"></canvas> <!-- Canvas maior para desenho -->
    <div>
        <button id="sendButton">Enviar</button>
        <button id="clearButton">Limpar</button>
    </div>
    <div id="result"></div>
    <script>
        const canvas = document.getElementById('paintCanvas');
        const ctx = canvas.getContext('2d');
        let painting = false;

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
            const x = (e.clientX - rect.left);
            const y = (e.clientY - rect.top);
            return { x, y };
        }

        function draw(e) {
            if (!painting) return;

            ctx.lineWidth = 10;
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

        function convertToGreyscale(imageData) {
            const data = imageData.data;
            for (let i = 0; i < data.length; i += 4) {
                // Convert to greyscale using the luminosity method
                const avg = 0.2989 * data[i] + 0.5870 * data[i + 1] + 0.1140 * data[i + 2];
                data[i] = avg; // Red
                data[i + 1] = avg; // Green
                data[i + 2] = avg; // Blue
                // Alpha channel remains unchanged
            }
            return imageData;
        }

        document.getElementById('sendButton').addEventListener('click', function() {
            // Cria um novo canvas para redimensionar a imagem
            const smallCanvas = document.createElement('canvas');
            smallCanvas.width = 28;
            smallCanvas.height = 28;
            const smallCtx = smallCanvas.getContext('2d');

            // Desenha a imagem do canvas principal no novo canvas redimensionado
            smallCtx.drawImage(canvas, 0, 0, 280, 280, 0, 0, 28, 28);

            // Captura a imagem redimensionada
            let imageData = smallCtx.getImageData(0, 0, 28, 28);

            // Converte a imagem para escala de cinza
            imageData = convertToGreyscale(imageData);
            smallCtx.putImageData(imageData, 0, 0);

            // Captura a imagem convertida
            const dataURL = smallCanvas.toDataURL('image/png');
            fetch('http://localhost:8081/paint', {
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
</body>
</html>
