#!/usr/bin/env bash
# Set color variable
CYAN='\033[1;36m'
NC='\033[0m' # No Color

set -e
# Provisions a virtual machine instance

# Local variables
export APP="${PORTAL_APP_REPO_FOLDER}"
echo "export APP=${APP}"

export TF_VAR_deployment_path="${PORTAL_DEPLOYMENTS_ROOT}/${PORTAL_DEPLOYMENT_REFERENCE}"
echo "export TF_VAR_deployment_path=${TF_VAR_deployment_path}"

export DPL="${PORTAL_DEPLOYMENTS_ROOT}/${PORTAL_DEPLOYMENT_REFERENCE}/"
echo "export DPL=${DPL}"

export PRIV_KEY_PATH="${DPL}${PORTAL_DEPLOYMENT_REFERENCE}"
echo "export PRIV_KEY_PATH=${PRIV_KEY_PATH}"

# Export input variables in the bash environment
export TF_VAR_name="$(awk -v var="${PORTAL_DEPLOYMENT_REFERENCE}" 'BEGIN {print tolower(var)}')"
echo "export TF_VAR_name=${TF_VAR_name}"

export KEY_PATH="${DPL}${PORTAL_DEPLOYMENT_REFERENCE}.pub"
echo "export KEY_PATH=${KEY_PATH}"

export TF_VAR_key_path="${KEY_PATH}"
echo "export TF_VAR_key_path=${TF_VAR_key_path}"

export TF_STATE=${DPL}'terraform.tfstate'
echo "export TF_STATE=${TF_STATE}"

# Launch provisioning of the VM
echo -e "\n\t${CYAN}Terraform apply${NC}\n"
terraform -chdir=${APP}'/ostack/terraform' init
terraform -chdir=${APP}'/ostack/terraform' apply -auto-approve --state=${DPL}'terraform.tfstate'

# Extract the external IP of the instance
external_ip=$(terraform output -state=${DPL}'terraform.tfstate' external_ip)
export external_ip=${external_ip}
echo "export external_ip=${external_ip}"

# Set default value for Ansible variables if they are either empty or undefined

cd ostack/ansible 

echo "Installing requirements!"
ansible-galaxy install -r requirements.yml 

# Used by terraform.py - env var holds directory containing terraform.tfstate file
export TERRAFORM_STATE_ROOT=${DPL}
echo "export TERRAFORM_STATE_ROOT=${DPL}"
# Used by ansible-playbook - local var holds host name (e.g. tsi1629995083720-1)
terraform_default_host="${TF_VAR_name}-1"
echo "Script var terraform_default_host=\"${TF_VAR_name}-1\""

export ANSIBLE_REMOTE_USER="${TF_VAR_remote_user:-ubuntu}"
echo "export ANSIBLE_REMOTE_USER=${ANSIBLE_REMOTE_USER}"

export JUPYTER_PASSWORD="${TF_VAR_jupyter_password:-jupytersecret}"
export TF_VAR_conda_environment="${TF_VAR_conda_environment:-biobb}"
export TF_VAR_conda_environment_file_path="${TF_VAR_conda_environment_file_path:-conda_env/environment.yml}"
export TF_VAR_python_version="${TF_VAR_python_version:-3.6}"
export TF_VAR_repo_url="${TF_VAR_repo_url:-https://github.com/bioexcel/biobb_workflows.git}"
export TF_VAR_docker_install="${TF_VAR_docker_install:-no}"

export TF_VAR_name="${TF_VAR_name}"
echo "export TF_VAR_name=${TF_VAR_name}"

# Launch Ansible playbook
echo -e "\n\t${CYAN}Launch Ansible playbook${NC}\n"
ansible-playbook -b playbook.yml -e 'ansible_python_interpreter=/usr/bin/python3' -e 'host_key_checking=False' --extra-vars "ecp_host=${terraform_default_host}"
