packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "amznlnx" {
  ami_name      = "packer-linux-aws-tomcat"
  instance_type = "t2.micro"
  region        = "us-east-1"
  force_deregister = true
  force_delete_snapshot = true
  source_ami_filter {
    filters = {
      name                = "amzn2-ami-hvm*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["amazon"]
  }
  ssh_username = "ec2-user"
  
}



build {
  sources = [
    "source.amazon-ebs.amznlnx"
  ]
  provisioner "ansible" {
    playbook_file = "./providers/ansible/install_server.yaml"

  }
}
