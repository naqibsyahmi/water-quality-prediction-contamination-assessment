# ======================================================

.gemini/

# ======================================================
# Docker Local Config
# ======================================================

.docker/

# ======================================================
# GCloud / GSUtil
# ======================================================

.gsutil/

# ======================================================
# Local Activity Files
# ======================================================

.lastactive

# ======================================================
# IDE
# ======================================================

.vscode/
.idea/

# ======================================================
# Data
# ======================================================

data/

# ======================================================
# Logs
# ======================================================

*.log

# ======================================================
# Temporary Files
# ======================================================

tmp/
temp/
*.tmp
*.temp

# ======================================================
# Environment Variables
# ======================================================

.env

# ======================================================
# Docker
# ======================================================

*.tar

# ======================================================
# MacOS
# ======================================================

.DS_Store

# ======================================================
# Notebook Exports
# ======================================================

*.html

# ======================================================
# Build Artifacts
# ======================================================

build/
dist/
*.egg-info/

# ======================================================
# Ignore Unused Files
# ======================================================

src/inference.py
src/inference_api.py

# ======================================================
# Ignore Unused Models
# ======================================================

model/xgb_model.pkl
EOF

git rm -r --cached .docker
git rm -r --cached .gsutil
git rm --cached .lastactive
git add .
git commit -m "Clean repository"
git remote add origin https://github.com/naqibsyahmi/river-water-quality-prediction-contamination-detection-V2.git
git branch -M main
git push -u origin main
git push -u origin main
clear
source venv/bin/activate
clear
python inference_api.py
cd src
python inference_api.py
clear
python inference_api.py
python inference_api.py
clear
touch .dockerignore
ls -la
ls
ls -la
cd ..
touch .dockerignore
ls -la
cd /home/jupyter
cat > .dockerignore <<EOF
# Python
__pycache__
*.pyc
*.pyo
*.pyd

# Virtual Environment
venv

# Jupyter
.ipynb_checkpoints

# Git
.git
.gitignore

# Logs
*.log

# Data Files
data

# Temporary Files
tmp
temp
EOF

# ======================================================
# Python Cache
# ======================================================

__pycache__
*.pyc
*.pyo
*.pyd

# ======================================================
# Virtual Environment
# ======================================================

venv

# ======================================================
# Jupyter
# ======================================================

.ipynb_checkpoints
*.ipynb

# ======================================================
# Git
# ======================================================

.git
.gitignore

# ======================================================
# Logs
# ======================================================

*.log

# ======================================================
# Data
# ======================================================

data

# ======================================================
# Shell Scripts
# ======================================================

*.sh

# ======================================================
# Ignore Unused Source Files
# ======================================================

src/inference.py
src/inference_api.py

# ======================================================
# Ignore Unused Models
# ======================================================

model/xgb_model.pkl

# ======================================================
# Temporary Files
# ======================================================

tmp
temp
docker build -f docker/Dockerfile -t river-water-quality-api .
docker build -f docker/Dockerfile -t river-water-quality-api .
cat > .dockerignore <<EOF
# Python Cache
__pycache__
*.pyc
*.pyo
*.pyd

# Virtual Environment
venv

# Jupyter
.ipynb_checkpoints
*.ipynb

# Git
.git
.gitignore

# Logs
*.log

# Data
data

# Shell Scripts
*.sh

# Ignore Unused Source Files
src/inference.py
src/inference_api.py

# Ignore Unused Models
model/xgb_model.pkl

# Temporary Files
tmp
temp

EOF

cat .dockerignore
docker build -f docker/Dockerfile -t river-water-quality-api .
docker images
docker history river-water-quality-api
du -sh model/*
clear
docker rmi river-water-quality-api
docker image prune -a
clear
docker image
docker images
docker build -f docker/Dockerfile -t river-water-quality-api .
docker images
clear
 cd src/
python inference_docker_api.py
clear
python inference_docker_api.py
clear
python inference_docker_api.py
clea
cd ..
touch .gitignore
cat > .gitignore <<EOF
# ======================================================
# Python
# ======================================================

__pycache__/
*.pyc
*.pyo
*.pyd

# ======================================================
# Virtual Environment
# ======================================================

venv/

# ======================================================
# Jupyter
# ======================================================

.ipynb_checkpoints/

# ======================================================
# Data
# ======================================================

data/

# ======================================================
# Docker
# ======================================================

*.tar

# ======================================================
# Logs
# ======================================================

*.log

# ======================================================
# Envir
cat > .gitignore <<EOF # ======================================================
# Python Cache
# ======================================================

__pycache__/
*.pyc
*.pyo
*.pyd

# ======================================================
# Virtual Environment
# ======================================================

venv/

# ======================================================
# Jupyter
# ======================================================

.ipynb_checkpoints/

# ======================================================
# Cache
# ======================================================

.cache/
.config/
.local/
.ipython/
.jupyter/

# ======================================================
# IDE
# ======================================================

.vscode/
.idea/

# ======================================================
# Data
# ======================================================

data/

# ======================================================
# Logs
# ======================================================

*.log

# ======================================================
# Temporary Files
# ======================================================

tmp/
temp/
*.tmp
*.temp

# ======================================================
# Environment Variables
# ======================================================

.env

# ======================================================
# Docker
# ======================================================

*.tar

# ======================================================
# MacOS
# ======================================================

.DS_Store

# ======================================================
# Notebook Exports
# ======================================================

*.html

# ======================================================
# Build Artifacts
# ======================================================

build/
dist/
*.egg-info/

# ======================================================
# Ignore Unused Files
# ======================================================

src/inference.py
src/inference_api.py

# ======================================================
# Ignore Unused Models
# ======================================================

model/xgb_model.pkl
git remote add origin https://github.com/naqibsyahmi/river-water-quality-prediction-contamination-detectio
git remote -v
git add .
git push
source venv/bin/activate
cd src
python inference_docker_api.py
git add .
git commit -m "modified docker sh file"
echo ".bash_history" >> .gitignore
git add .
git commit -m "modified docker sh file"
git push
clear
cd ..
docker images
docker tag river-water-quality-api asia-southeast1-docker.pkg.dev/river-water-quality-prediction/river-water-quality-repo/river-water-quality-api
docker push asia-southeast1-docker.pkg.dev/river-water-quality-prediction/river-water-quality-repo/river-water-quality-api
gcloud auth configure-docker asia-southeast1-docker.pkg.dev
docker push asia-southeast1-docker.pkg.dev/river-water-quality-prediction/river-water-quality-repo/river-water-quality-api
gcloud run deploy river-water-quality-api --image asia-southeast1-docker.pkg.dev/river-water-quality-prediction/river-water-quality-repo/river-water-quality-api --platform managed --region asia-southeast1 --allow-unauthenticated --memory 8Gi --cpu 2
clear
python inference_cloud_run_api.py
cd src
python inference_cloud_run_api.py
python inference_cloud_run_api.py
python inference_cloud_run_api.py
clear
cd ..
pip install -r requirements.txt
clear
cd src
python inference_cloud_run_api.py
clear
python inference_cloud_run_api.py
echo "telegram.txt" >> .gitignore
cd ..
git add .
git rm --cached telegram.txt
git commit -m "completed cloud run implementation"
git push
rm src/.dockerignore
rm src/.gitignore
git add .
git rm --cached telegram.txt
git commit -m "remove accidental created gitignore and dockerignore in src folder"
git push
cd ..
mkdir cloud_function
pwd
cd cloud_function
gcloud functions deploy automated-river-water-quality-monitoring --gen2 --runtime python312 --region asia-southeast1 --source . --entry-point automated_monitoring --trigger-http --allow-unauthenticated
gcloud services enable cloudfunctions.googleapis.com cloudbuild.googleapis.com artifactregistry.googleapis.com run.googleapis.com eventarc.googleapis.com
gcloud projects describe river-water-quality-prediction --format="value(projectNumber)"
gcloud projects add-iam-policy-binding river-water-quality-prediction --member="serviceAccount:988886574897-compute@developer.gserviceaccount.com" --role="roles/cloudbuild.builds.builder"
gcloud auth list
gcloud auth login
gcloud config set account naqibsyahmi12@gmail.com
gcloud auth list
gcloud projects add-iam-policy-binding river-water-quality-prediction --member="serviceAccount:988886574897-compute@developer.gserviceaccount.com" --role="roles/cloudbuild.builds.builder"
clear
gcloud functions deploy automated-river-water-quality-monitoring --gen2 --runtime python312 --region asia-southeast1 --source . --entry-point automated_river_water_quality_monitoring --trigger-http --allow-unauthenticated
cd src
gcloud functions deploy automated-river-water-quality-monitoring --gen2 --runtime python312 --region asia-southeast1 --source . --entry-point automated_river_water_quality_monitoring --trigger-http --allow-unauthenticated
cd ..
cd cloud_function
gcloud functions deploy automated-river-water-quality-monitoring --gen2 --runtime python312 --region asia-southeast1 --source . --entry-point automated_river_water_quality_monitoring --trigger-http --allow-unauthenticated
gcloud functions deploy automated-river-water-quality-monitoring --gen2 --runtime python312 --region asia-southeast1 --source . --entry-point automated_river_water_quality_monitoring --trigger-http --allow-unauthenticated
clear
gcloud services enable cloudscheduler.googleapis.com
gcloud scheduler jobs create http river-water-quality-monitoring-job --location=asia-southeast1 --schedule="0 9 * * *" --uri="https://asia-southeast1-river-water-quality-prediction.cloudfunctions.net/automated-river-water-quality-monitoring" --http-method=GET
gcloud scheduler jobs list
gcloud scheduler jobs list --location=asia-southeast1
