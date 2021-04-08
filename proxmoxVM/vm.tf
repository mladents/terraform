provider "proxmox" {
    pm_tls_insecure = true
    pm_api_url = "https://192.168.178.200:8006/api2/json"
    pm_password = "MyUltraMegaGigaSecurePasswd"
    pm_user = "root@pam"
#    pm_otp = ""
}
resource "proxmox_vm_qemu" "cloudinit-test" {
  name = "test-vm-1"
  desc = "tf test vm"
  target_node = "homelab"

  clone = "linux-template"

  # The destination resource pool for the new VM
#  pool = "pool0"

  disk {
#    id = 0
    type = "virtio"
    storage = "data"
#    storage_type = "lvm"
    size = "9G"
  }

#  storage = "data"
  cores = 2
  sockets = 1
  memory = 2048
  cpu = "host"
#  disk_gb = 9
#  nic = "virtio"
#  bridge = "vmbr0"
    # Setup the network interface and assign a vlan tag: 256
  network {
    model = "virtio"
    bridge = "vmbr0"
#        tag = 256
  }


  os_type = "cloud-init"
  agent = 1

#  provisioner "remote-exec" {
#    inline = [
#      "ip add sh"
#    ]
#  }
}

provisioner "remote-exec" {
  inline = [
    "ip add sh"
  ]
}
