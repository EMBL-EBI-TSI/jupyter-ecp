# Cloud Portal Application - bioexcel-jupyter
Cloud Portal application to create VM and install jupyter server on it.
It uses the ubuntu 18.04-python image from openstack and installs conda, jupyter using ansible.

---

## Requirements


## Instructions

## Default values

### `Deployment parameters`

| Parameter name          | Parameter value       |
| ---                     | ---                   |
| `remote_user`           | `ubuntu`              |
| `machine_type`          | `s1.small`            |
| `floating_ip_pool`      | `ext-net-37`          |
| `ssh_key`               | `users's pub key`     |
| `public_key_path`       | `~/.ssh/id_rsa.pub`   |
| `private_key_path`      | `~/.ssh/id_rsa`       |

### `Inputs`

| Parameter name          | Parameter value       |
| ---                     | ---                   |
| `disk_image_name`       | `ubuntu-18.04-python`        |

### Open Ports
The virtual machine provided will have this ports open.

`ICMP`: `all`  
`TCP` : `22`
`TCP` : `8443`

