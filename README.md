# tf-jenkins-as-code
Jenkins controller provisioned by Terraform on libvirt KVM, user data run by cloud-init, and configuration made by Ansible.  
[JCasC](https://www.jenkins.io/projects/jcasc/) is used for configuring Jenkins.  
Data persistence is achieved by storing all Jenkins data in a [NFS server](https://github.com/k-candidate/tf-nfs).

## Docker image
We use `jenkins/jenkins:<LTS-tag>` for the base image, and we basically add the plugins to it.  
The CasC is not applied at this point for security and flexibility.  
The image gets automatically built when any file inside the  `jenkins_image` directory is changed. The images can be found in https://hub.docker.com/r/kcandidate/jenkins-casc.  
The image is scanned via Trivy for vulnerabilities, and posted in the GitHub Security tab.  
All of these steps are done via GitHub Actions. See https://github.com/k-candidate/tf-jenkins-as-code/blob/main/.github/workflows/docker-image.yaml.

## Terraform, cloud-init, and Ansible
This part is decoupled from the previous Docker image build/push/scan part to keep flexibility, and to future-proof the ease of maintenance.  

We are using the module https://github.com/k-candidate/tf-module-kvm-vm. The flow is Terraform centric for ease of control, and to prescind from any scripts to glue the parts together.
- Terraform is used to provision the VM.
- Terraform triggers the user data part (cloud-init) and waits until it finishes.
- Terraform launches Ansible.
- Ansible maps the NFS server (where the Jenkins data is stored) to the VM, pulls the Docker image from https://hub.docker.com/r/kcandidate/jenkins-casc, and launches it with the CasC and volumes.

## Quickstart
Assuming you already have terraform, ansible, libvirt etc, you can clone the repo, and run the `apply.sh`.
<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_tf-module-kvm-vm"></a> [tf-module-kvm-vm](#module\_tf-module-kvm-vm) | git@github.com:k-candidate/tf-module-kvm-vm.git | v1.4.1 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_image_source"></a> [image\_source](#input\_image\_source) | Local path or URL for the image | `string` | `"https://cloud-images.ubuntu.com/releases/noble/release/ubuntu-24.04-server-cloudimg-amd64.img"` | no |
| <a name="input_jenkins_admin_id"></a> [jenkins\_admin\_id](#input\_jenkins\_admin\_id) | Jenkins admin username | `string` | n/a | yes |
| <a name="input_jenkins_admin_password"></a> [jenkins\_admin\_password](#input\_jenkins\_admin\_password) | Jenkins admin password | `string` | n/a | yes |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | Name of the libvirt network where this machine will be provisioned | `string` | `"default"` | no |
| <a name="input_nfs_ip"></a> [nfs\_ip](#input\_nfs\_ip) | IP of the NFS server | `string` | n/a | yes |
| <a name="input_ssh_private_key"></a> [ssh\_private\_key](#input\_ssh\_private\_key) | Private SSH key of the account | `string` | `"~/.ssh/id_ed25519"` | no |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | Public SSH key of the account | `string` | `"~/.ssh/id_ed25519.pub"` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | File for cloud-init user data cfg | `string` | `"cloud-init/user-data.cfg"` | no |
| <a name="input_vm_hostname"></a> [vm\_hostname](#input\_vm\_hostname) | Hostname of the machine | `string` | `"nfs-server.domain.dom"` | no |
| <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name) | Libvirt name or domain of the machine | `string` | `"jenkins-controller"` | no |
| <a name="input_vm_username"></a> [vm\_username](#input\_vm\_username) | Username of an account with SSH access | `string` | `"ubuntu"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->