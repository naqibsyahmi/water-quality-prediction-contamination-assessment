
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

git rm -r --cached .
git rm -r --cached -f .gemini
clear
git rm -r --cached -f .
git add .
git status
git commit -m "Initial commit"
git config --global user.name "naqibsyahmi"
git config --global user.email "naqibsyahmi12@gmail.com"
git commit -m "Initial commit"
git push
cat > .gitignore <<EOF
# ======================================================
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
# Gemini
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
