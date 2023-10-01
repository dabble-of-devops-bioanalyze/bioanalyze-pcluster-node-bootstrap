#!/usr/bin/env bash

##############################################
# This shell script shows how to run easybuild
# It will be updated each time you run make apply, so copy any changes to your own scripts
# Easybuild jobs are usually deployed either sync or async.
# Sync installations are run directly on the running node
# Async installations are submitted as jobs to the scheduler
# Sync installations should NOT be run on the head node
# Async installation can be run from the head node, because EB only submits jobs to the scheduler
##############################################

#SBATCH --constraint=m5a2xlarge
#SBATCH --exclusive
#SBATCH --partition=dev
#SBATCH --time=48:00:00

## Troubleshooting
# Only run these commands if you think something has gone awry
# rm -rf /apps/easybuild/4.5.4/software/.locks
# cd /apps/software-configs/bioanalyze-easyconfigs
# git pull origin main


source /usr/share/lmod/lmod/init/bash


export EASYBUILD_PREFIX=/apps/easybuild/4.5.4
export MODULEPATH=/apps/easybuild/4.5.4/modules/all
export ROBOT=/apps/software-configs/bioanalyze-easyconfigs

module purge
module load EasyBuild

export SBATCH_EXCLUSIVE=""
export SBATCH_PARTITION="dev"
export SBATCH_CONSTRAINT="m5a2xlarge"

cd ${ROBOT}
export EASYBUILD_JOB_BACKEND='Slurm'

#eb --robot=${ROBOT}: --job  \
eb --robot=${ROBOT}:  \
        --tmp-logdir $HOME/eb_tmplogs \
        /apps/software-configs/bioanalyze-easyconfigs/easybuild/easyconfigs/pangeo-notebook-2022.05.10/jupyterlab-2022.05.10.eb \
        /apps/software-configs/bioanalyze-easyconfigs/easybuild/easyconfigs/jupyterlab/jupyterlab-2023.09.17.eb \
        /apps/software-configs/bioanalyze-easyconfigs/easybuild/easyconfigs/jupyterlab/jupyterlab-2023.07.10.eb