exit 1


# !! autogluon.vision package versions conflict with our production versions of torch for the dogs app
# -> use separate vertual env for those usecases

##------------------------------------------------------------------------------
## autogluon - quick redeploy
##------------------------------------------------------------------------------

rm -r ./.venv-autogluon
& "$Env:LOCALAPPDATA\Programs\Python\Python39\python.exe" -m venv .venv-autogluon
./.venv-autogluon/Scripts/Activate.ps1

python -m pip install --require-virtualenv --upgrade pip setuptools wheel IPython
pip install --require-virtualenv --requirement "./requirements-autogluon-plus-autogluon.vision.txt"




##------------------------------------------------------------------------------
## autogluon - manual reinstall and package refreeze
##------------------------------------------------------------------------------

rm -r ./.venv-autogluon
& "$Env:LOCALAPPDATA\Programs\Python\Python39\python.exe" -m venv .venv-autogluon
./.venv-autogluon/Scripts/Activate.ps1

python -m pip install --require-virtualenv --upgrade pip setuptools wheel IPython

pip install --require-virtualenv autogluon.vision
pip freeze --require-virtualenv > "./requirements-autogluon.vision.txt"

pip install --require-virtualenv autogluon --constraint "./constraints-autogluon.vision.txt"
pip freeze --require-virtualenv > "./requirements-autogluon-plus-autogluon.vision.txt"

