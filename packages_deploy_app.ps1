exit 1


# autogluon.vision package versions conflict with our production versions of torch for the dogs app
# -> use separate vertual env for those usecases

##------------------------------------------------------------------------------
## dogs app - quick redeploy
##------------------------------------------------------------------------------

rm -r ./.venv
& "$Env:LOCALAPPDATA\Programs\Python\Python39\python.exe" -m venv .venv
./.venv/Scripts/Activate.ps1

python -m pip install --require-virtualenv --upgrade pip setuptools wheel IPython
pip install --require-virtualenv --requirement "./requirements-app.txt"




##------------------------------------------------------------------------------
## dogs app - manual reinstall and package refreeze
##------------------------------------------------------------------------------

rm -r ./.venv
& "$Env:LOCALAPPDATA\Programs\Python\Python39\python.exe" -m venv .venv
./.venv/Scripts/Activate.ps1

python -m pip install --require-virtualenv --upgrade pip setuptools wheel IPython

pip install --require-virtualenv `
    streamlit `
    pandas `
    numpy `
    tensorflow

pip freeze --require-virtualenv > "./requirements-app.txt"

