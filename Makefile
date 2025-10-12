# --- Makefile para proyecto MLOps ---

# Entrenar el modelo
train:
	python model.py

# Evaluar el modelo
evaluate:
	python evaluate.py

# Ejecutar ambos pasos
all: train evaluate

# Limpiar resultados anteriores
clean:
	rm -rf results/*
