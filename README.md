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