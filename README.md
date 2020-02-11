# Cloud Portal Application - bioexcel-jupyter
Cloud Portal application to create VM and install jupyter server on it.
It uses the ubuntu 18.04-python image from openstack and installs conda, jupyter using ansible.

---

## Requirements


## Instructions

## Default values

### `Deployment parameters`

| Parameter name               | Default value |Example value                           | Description |
| ---                          | ---       | --------                               |---|
| `remote_user`                | `ubuntu`  |                                        | |
| `machine_type`               | `s1.small`|                                        | Flavour of the instance |
| `floating_ip_pool`           | `ext-net` |                                        | Preexisting Floating IP pool |
| `network_name`               |           | `PROJECT-network`                      | Preexisting network to which an instance will be attached |
| `repo_url`                   |           | `https://github.com/bioexcel/biobb_wf_md_setup` | URL of Github repository containing the notebook |
| `conda_environment`          |           | `biobb_MDsetup_tutorial`               | Conda Environment name |
| `conda_environment_file_path`|           | `conda_env/environment.yml`            | Conda environment file path relative to the repository root |          
| `python_version`             |           | `3.6`                                  | Python version for Conda Environment |    | `package_install`            | Arbitrary list of packages, when environment path not specified plus `pocl`, when `package_install` not specified| `conda install pocl;conda install -y -c bioconda biobb_analysis==2.0.1` | Specify additional install commands, separated with a semicolon (;). |
| `post_install`               | Arbitrary `jupyter-nbextension` command, when `package_install` not specified | `jupyter-nbextension enable --py --user widgetsnbextension;jupyter-nbextension enable --py --user nglview` | Specify some additional commands to execute after activating environment |


### `Inputs`

| Parameter name          | Parameter value       |
| ---                     | ---                   |
| `disk_image_name`       | `ubuntu-18.04-python`        |

### Open Ports
The virtual machine provided will have this ports open.

`ICMP`: `all`  
`TCP` : `22`
`TCP` : `8443`

