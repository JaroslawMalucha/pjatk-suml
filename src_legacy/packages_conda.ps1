# run this in conda enabled terminal (it must have environment prompt prepended to the ps prompt)

$new_py_env = 'suml'
Write-Host $new_py_env

conda create --name $new_py_env --no-default-packages --yes
conda activate $new_py_env

conda info --envs
conda info # make sure you have appropriate active environment
conda list

conda install -n $new_py_env --yes --update-all `
    python=3.10 `
    conda `
    pip `
    streamlit `
    matplotlib `
    tensorflow


    
