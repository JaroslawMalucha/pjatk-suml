
# RECOMMENDED OPTION

## // CONFIGURE PROJECT RUNTIME USING POETRY on WINDOWS

# 1. install python :) e.g. python 3.11
# rest of script assumes:
#   - cpython install
#   - python is on PATH
#   - python launcher is installed - py

# 1 B. if using conda instead of system python
#   - open conda enabled terminal
#   - create conda environmet with required python version
#   - activate conda environment
#   - create .venv (step 3. venv will use conda env python interpreter)

# 2. install poetry
(Invoke-WebRequest -Uri https://install.python-poetry.org -UseBasicParsing).Content | py -
poetry --version

# 3. create venv virtual envoronment
python -m venv .venv
# or the non default version
& "$Env:LOCALAPPDATA\Programs\Python\Python311\python.exe" -m venv .venv
& "$Env:LOCALAPPDATA\Programs\Python\Python38\python.exe" -m venv .venv

# 4. activate venv
# requried step if using a conda envir instead of system python, 
#   otherwise poetry packages will get installed into conda envir instead of .venv envir
./.venv/Scripts/Activate.ps1 

# 5. use poetry to install all packages from pyproject.lock with constraints from poetry.lock
# packages should install into venv
poetry install

# 6. to use env in terminal, activate using venv or poetry
./.venv/Scripts/Activate.ps1    # .venv activator, USE THIS
poetry shell                    # poetry activator, spawns a sub-shell; useless in vscode as will not allow to push lines to REPL

# 7. to use env in vscode: > select python interpreter > '.venv':Poetry

# 8. install package using poetry
poetry add your-package-name # installes and updates pyproject.toml

# 9. update lock file (if installed ok and all scripts worked)
poetry lock

#// ======= PACKAGES TO INSTALL - first time adding into a project
rm -r ./.venv
& "$Env:LOCALAPPDATA\Programs\Python\Python39\python.exe" -m venv .venv
# & "$Env:LOCALAPPDATA\Programs\Python\Python310\python.exe" -m venv .venv
# & "$Env:LOCALAPPDATA\Programs\Python\Python38\python.exe" -m venv .venv
#& "$Env:LOCALAPPDATA\Programs\Python\Python311\python.exe" -m venv .venv
./.venv/Scripts/Activate.ps1
python -m pip install --upgrade pip
pip install -U setuptools wheel --require-virtualenv
pip list
pip install autogluon.vision --require-virtualenv
pip freeze > "./requirements-autogluon.vision.txt"
pip install autogluon --require-virtualenv --constraint "./constraints-autogluon.vision.txt"
pip freeze > "./requirements-autogluon-plus-autogluon.vision.txt"

pip install torch==2.1.2 torchvision==0.16.2 --index-url https://download.pytorch.org/whl/cpu --require-virtualenv
pip install tensorflow --require-virtualenv


# torch                   1.12.1
# torchvision             0.13.1
# autogluon.common        0.6.2
# autogluon.core          0.6.2
# autogluon.features      0.6.2
# autogluon.multimodal    0.6.2
# autogluon.vision        0.6.2
# ERROR: pip's dependency resolver does not currently take into account all the packages that are installed. This behaviour is the source of the following dependency conflicts.
# autogluon-vision 0.6.2 requires autogluon.core==0.6.2, but you have autogluon-core 1.1.0 which is incompatible.
# autogluon-vision 0.6.2 requires autogluon.multimodal==0.6.2, but you have autogluon-multimodal 1.1.0 which is incompatible.
# autogluon-vision 0.6.2 requires pandas!=1.4.0,<1.6,>=1.2.5, but you have pandas 2.2.2 which is incompatible.
# autogluon-vision 0.6.2 requires Pillow<=9.4.0,>=9.3.0, but you have pillow 10.3.0 which is incompatible.
# autogluon-vision 0.6.2 requires timm<0.7.0,>=0.5.4, but you have timm 0.9.16 which is incompatible.
# torchtext 0.13.1 requires torch==1.12.1, but you have torch 2.1.2 which is incompatible.
# autogluon                 1.1.0
# autogluon.common          1.1.0
# autogluon.core            1.1.0
# autogluon.features        1.1.0
# autogluon.multimodal      1.1.0
# autogluon.tabular         1.1.0
# autogluon.timeseries      1.1.0
# autogluon.vision          0.6.2





poetry add tensorflow="~2.16.1" tensorflow-io-gcs-filesystem="0.31.0"   # works on py311,py310
#poetry add tensorflow="~2.10" tensorflow-io-gcs-filesystem="0.27.0"     # works on py38

poetry source add --priority=supplemental pytorch https://download.pytorch.org/whl/cpu
poetry add --source pytorch torch==2.1.2 torchvision==0.16.2
poetry add autogluon

poetry add pandas@*


## testing
poetry add autogluon.vision@*


## successful tries
# py311
pip install tensorflow
poetry add tensorflow="~2.16.1" tensorflow-io-gcs-filesystem="0.31.0"   # works on py311,py310; installed by pip on py311
## failed tries
# https://pypi.org/project/tensorflow-io-gcs-filesystem/
poetry add tensorflow="~2.15" tensorflow-io-gcs-filesystem="0.36.0" # failed on py311
poetry add tensorflow="~2.13" tensorflow-io-gcs-filesystem="0.34.0" # failed on py311
poetry add tensorflow="~2.13" tensorflow-io-gcs-filesystem="0.33.0" # failed on py311
poetry add tensorflow="~2.12" tensorflow-io-gcs-filesystem="0.32.0" # failed on py311
poetry add tensorflow="~2.11" tensorflow-io-gcs-filesystem="0.31.0" # failed on py311
poetry add tensorflow="~2.11" tensorflow-io-gcs-filesystem="0.28.0" # failed on py311

poetry add tensorflow-io-gcs-filesystem@*
poetry add tensorflow-io@*

poetry add tensorflow@* tensorflow-io-gcs-filesystem@*

poetry add autogluon.vision



#// ======= PACKAGES TO INSTALL - reinstall from pyproject.toml
./.venv/Scripts/Activate.ps1
poetry install





