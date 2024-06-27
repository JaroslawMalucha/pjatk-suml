exit 1


# autogluon.vision package versions conflict with our production versions of torch for the dogs app
# -> use separate vertual env for those usecases

##------------------------------------------------------------------------------
## kedro - quick redeploy
##------------------------------------------------------------------------------

rm -r ./.venv-kedro
& "$Env:LOCALAPPDATA\Programs\Python\Python39\python.exe" -m venv .venv-kedro
./.venv-kedro/Scripts/Activate.ps1

python -m pip install --require-virtualenv --upgrade pip setuptools wheel IPython
pip install --require-virtualenv --requirement "./requirements-kedro.txt"




##------------------------------------------------------------------------------
## kedro - manual reinstall and package refreeze
##------------------------------------------------------------------------------

rm -r ./.venv-kedro
& "$Env:LOCALAPPDATA\Programs\Python\Python39\python.exe" -m venv .venv-kedro
./.venv-kedro/Scripts/Activate.ps1

python -m pip install --require-virtualenv --upgrade pip setuptools wheel IPython

pip install --require-virtualenv `
    kedro `
    kedro-viz `
    pandas `
    numpy `
    tensorflow `
    Pillow

pip freeze --require-virtualenv > "./requirements-kedro.txt"

