install:
	pip install --upgrade pip &&\
		pip install -r requirements.txt

format:	
	black *.py 

train:
	python train.py

SHELL = cmd.exe

eval:
	echo "## Model Metrics" > report.md
	type .\Results\metrics.txt >> report.md
	
	echo '\n## Confusion Matrix Plot' >> report.md
	echo ^<img alt="Confusion Matrix" src="./Results/model_results.png"^> >> report.md
	
		
update-branch:
	git config --global user.name $(USER_NAME)
	git config --global user.email $(USER_EMAIL)
	git commit -am "Agregar Flujo CI/CD"
	git push --force origin HEAD:update


hf-login: 
	pip install -U "huggingface_hub[cli]"
	git pull origin main
	git switch main
	huggingface-cli login --token $(HF) --add-to-git-credential

push-hub: 
	huggingface-cli upload fershik/Drug-Classification ./App --repo-type=space --commit-message="Sync App files"
	huggingface-cli upload fershik/Drug-Classification ./Model Model --repo-type=space --commit-message="Sync Model"
	huggingface-cli upload fershik/Drug-Classification ./Results Metrics --repo-type=space --commit-message="Sync Model"

deploy: hf-login push-hub

all: install format train eval update-branch deploy
