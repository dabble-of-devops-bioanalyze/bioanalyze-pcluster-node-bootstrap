.PHONY : help
help : Makefile
	@echo "Commands to bootstrap your nodes"

##################################
# Main installation and
# bootstrapping operations
##################################

install:
	@echo "Installing ansible"
	# sudo python3 -m pip install ansible
	# leave both in
	# we need the conda role as sudo and as the user!
	sudo ansible-galaxy install evandam.conda
	ansible-galaxy install evandam.conda

apply-compute:
	# This is here as a place holder
	# Anything you add here will include the launch time of a node!
	#$(make) install
	echo "Nothing to do here"

apply: install
apply:
	echo "apply"
	ansible-playbook ./playbooks/head-node/prepare.yaml
	ansible-playbook ./playbooks/head-node/easybuild.yaml
	ansible-playbook ./playbooks/head-node/jupyterhub.yaml

apply-all:
	echo "apply"
	ansible-playbook ./playbooks/head-node/prepare.yaml
	ansible-playbook ./playbooks/head-node/easybuild.yaml
	ansible-playbook ./playbooks/head-node/jupyterhub.yaml
	ansible-playbook ./playbooks/head-node/spack.yaml
	ansible-playbook ./playbooks/cloud-labs/R/r.yaml
	ansible-playbook ./playbooks/cloud-labs/bioconductor/bioconductor.yaml
	ansible-playbook ./playbooks/cloud-labs/py-ml/py-tensorflow.yaml
	ansible-playbook ./playbooks/cloud-labs/relion/relion.yaml
	ansible-playbook ./playbooks/cloud-labs/singularity/singularity.yaml
	ansible-playbook ./playbooks/cloud-labs/lmod/lmod.yaml
	ansible-playbook ./playbooks/cloud-labs/gromacs/gromacs.yaml
	ansible-playbook ./playbooks/cloud-labs/alphafold/alphafold.yaml
	ansible-playbook ./playbooks/cloud-labs/py-pymol/py-pymol.yaml

##################################
# Install software and data
##################################

easybuild:
	ansible-playbook ./playbooks/head-node/easybuild.yaml

spack:
	echo "Installing spack"
	ansible-playbook ./playbooks/head-node/spack.yaml

alphafold:
	echo "Installing alphafold"
	ansible-playbook ./playbooks/cloud-labs/alphafold/alphafold.yaml

alphafold/data:
	echo "Downloading alphafold data"
	ansible-playbook ./playbooks/cloud-labs/alphafold/download-data.yaml

gromacs:
	echo "Installing gromacs"
	ansible-playbook ./playbooks/cloud-labs/gromacs/gromacs.yaml

relion:
	echo "Installing relion"
	ansible-playbook ./playbooks/cloud-labs/relion/relion.yaml

##################################
# Troubleshooting
##################################

troubleshoot: install
	echo "troubleshoot"
	ansible-playbook ./playbooks/head-node/troubleshoot.yaml

troubleshoot/restart-services: install
	echo "troubleshoot/restart-services"
	ansible-playbook ./playbooks/head-node/restart-services.yaml
