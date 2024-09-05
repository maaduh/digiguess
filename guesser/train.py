import tensorflow as tf
from tensorflow.keras import datasets, layers, models
import numpy as np
import matplotlib.pyplot as plt
from sklearn.metrics import confusion_matrix
import seaborn as sns

# Carregar o conjunto de dados MNIST
(train_images, train_labels), (test_images, test_labels) = datasets.mnist.load_data()

# Normalizar os dados
train_images, test_images = train_images / 255.0, test_images / 255.0

# Expandir dimensões para adicionar o canal de cor
train_images = np.expand_dims(train_images, -1)
test_images = np.expand_dims(test_images, -1)

# Criar um gerador de aumento de dados para o treinamento
datagen = tf.keras.preprocessing.image.ImageDataGenerator(
    rotation_range=10,  # Rotacionar imagens aleatoriamente
    width_shift_range=0.1,  # Translação horizontal
    height_shift_range=0.1,  # Translação vertical
    zoom_range=0.1,  # Zoom aleatório
    shear_range=0.1,  # Aplicar cisalhamento
    horizontal_flip=False,  # Não flipar horizontalmente (não necessário para MNIST)
    fill_mode='nearest'  # Preencher pixels ausentes com o valor mais próximo
)

# Definir o modelo
model = models.Sequential([
    layers.Conv2D(32, (3, 3), activation='relu', input_shape=(28, 28, 1)),
    layers.MaxPooling2D((2, 2)),
    layers.Conv2D(64, (3, 3), activation='relu'),
    layers.MaxPooling2D((2, 2)),
    layers.Conv2D(64, (3, 3), activation='relu'),
    layers.Flatten(),
    layers.Dense(64, activation='relu'),
    layers.Dense(10, activation='softmax')
])

model.compile(optimizer='adam',
              loss='sparse_categorical_crossentropy',
              metrics=['accuracy'])

# Treinar o modelo com aumento de dados
model.fit(datagen.flow(train_images, train_labels, batch_size=64),
          epochs=5,
          validation_data=(test_images, test_labels))

# Avaliar o modelo
test_loss, test_accuracy = model.evaluate(test_images, test_labels)
print(f'Acurácia no conjunto de teste: {test_accuracy}')

# Fazer previsões no conjunto de teste
predictions = model.predict(test_images)
predicted_labels = np.argmax(predictions, axis=1)

# Gerar a matriz de confusão
cm = confusion_matrix(test_labels, predicted_labels)

# Plotar a matriz de confusão
plt.figure(figsize=(10, 7))
sns.heatmap(cm, annot=True, fmt='d', cmap='Blues', xticklabels=range(10), yticklabels=range(10))
plt.xlabel('Classe Predita')
plt.ylabel('Classe Real')
plt.title('Matriz de Confusão')
plt.show()

# Salvar o modelo treinado
model.save('mnist_cnn.h5')
