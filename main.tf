module "tf-module-kvm-vm" {
  source                  = "git@github.com:k-candidate/tf-module-kvm-vm.git?ref=v1.4.1"
  vm_name                 = var.vm_name
  network_name            = var.network_name
  image_source            = var.image_source
  use_cloud_init          = true
  cloud_init_cfg_filename = var.user_data
  vm_username             = var.vm_username
  cloud_init_vars = {
    vm_hostname    = var.vm_hostname
    vm_username    = var.vm_username
    ssh_public_key = file(var.ssh_public_key)
  }
  ssh_private_key = var.ssh_private_key
  use_ansible     = true
  extra_vars = {
    vm_username            = var.vm_username
    nfs_ip                 = var.nfs_ip
    jenkins_admin_id       = var.jenkins_admin_id
    jenkins_admin_password = var.jenkins_admin_password
    s3_endpoint_url        = var.s3_endpoint_url
    s3_access_key          = var.s3_access_key
    s3_secret_key          = var.s3_secret_key
    p12_password           = var.p12_password
  }
}