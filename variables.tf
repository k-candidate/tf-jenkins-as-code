variable "vm_name" {
  description = "Libvirt name or domain of the machine"
  type        = string
  default     = "jenkins-controller"
}

variable "network_name" {
  description = "Name of the libvirt network where this machine will be provisioned"
  type        = string
  default     = "default"
}

variable "image_source" {
  description = "Local path or URL for the image"
  type        = string
  default     = "https://cloud-images.ubuntu.com/releases/noble/release/ubuntu-24.04-server-cloudimg-amd64.img"
}

variable "user_data" {
  description = "File for cloud-init user data cfg"
  type        = string
  default     = "cloud-init/user-data.cfg"
}

variable "vm_username" {
  description = "Username of an account with SSH access"
  type        = string
  default     = "ubuntu"
}

variable "vm_hostname" {
  description = "Hostname of the machine"
  type        = string
  default     = "nfs-server.domain.dom"
}

variable "ssh_public_key" {
  description = "Public SSH key of the account"
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}

variable "ssh_private_key" {
  description = "Private SSH key of the account"
  type        = string
  default     = "~/.ssh/id_ed25519"
}

variable "nfs_ip" {
  description = "IP of the NFS server"
  type        = string
}

variable "jenkins_admin_id" {
  description = "Jenkins admin username"
  type        = string
}

variable "jenkins_admin_password" {
  description = "Jenkins admin password"
  type        = string
}

variable "s3_endpoint_url" {
  description = "url for Minio S3 bucket"
  type        = string
  default     = "http://minio.devops.dom:9000"
}

variable "s3_access_key" {
  description = "Access key id for Minio S3 bucket"
  type        = string
}

variable "s3_secret_key" {
  description = "Secret key for Minio S3 bucket"
  type        = string
}

variable "p12_password" {
  description = "Password of the p12 file"
  type        = string
  default     = "changeit"
}