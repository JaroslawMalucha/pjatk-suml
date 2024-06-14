

##------------------------------------------------------------------------------
## kedro - run pipelines
##------------------------------------------------------------------------------

./.venv-kedro/Scripts/Activate.ps1
cd ./src/kedro/kedro-project
kedro run


##------------------------------------------------------------------------------
## kedro - initial project creation
##------------------------------------------------------------------------------

./.venv-kedro/Scripts/Activate.ps1
cd ./src/kedro
kedro new --name kedro-project --tools lint,test,log,docs,data,viz --example=n
