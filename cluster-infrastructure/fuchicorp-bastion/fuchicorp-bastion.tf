provider "google" {
  credentials = "${file("./fuchicorp-service-account.json")}"
  project     = "${var.google_project_id}"
  zone        = "${var.zone}"
}



resource "google_compute_firewall" "default" {
  name    = "bastion-network-firewall"
  network = "${google_compute_instance.vm_instance.network_interface.0.network}"

  allow { protocol = "icmp" }
  allow { protocol = "tcp" ports = ["80", "443"] }

  source_ranges = ["0.0.0.0/0"]
  source_tags = ["bastion-firewall"]
}



resource "google_compute_instance" "vm_instance" {
  name         = "bastion-${replace(var.google_domain_name, ".", "-")}"
  machine_type = "${var.machine_type}"

  tags = ["bastion-firewall"]

  boot_disk {
    initialize_params {
      size = "${var.instance_disk_zie}" 
      image = "centos-cloud/centos-7"
    }

  }

  network_interface {
    network       = "default"
    # network       = "${google_compute_network.vpc_network.name}"
    access_config = {}
  }
  
  metadata {
    sshKeys = "${var.gce_ssh_user}:${file(var.gce_ssh_pub_key_file)}"
  }

  metadata_startup_script = <<EOF
  #!/bin/bash
  export GIT_TOKEN="${var.git_common_token}"
  echo 'export GIT_TOKEN="${var.git_common_token}"' >> /root/.bashrc
  sleep 10
  
  echo "Installing python and pip command"
  sudo yum install python-pip git jq wget unzip vim centos-release-scl scl-utils-build -y
  sudo yum install  python33 gcc python3 -y

  echo "Installing Helm v2.14.0"
  sudo curl https://storage.googleapis.com/kubernetes-helm/helm-v2.14.0-linux-amd64.tar.gz > ./helm.tar.gz
  sudo tar -xvf ./helm.tar.gz
  sudo mv ./linux-amd64/*  /usr/local/bin/

  echo "Installing docker daemon"
  sudo yum check-update
  sudo yum install -y yum-utils device-mapper-persistent-data lvm2
  sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
  sudo yum install -y docker-ce-17.12.1.ce
  sudo systemctl start docker
  sudo systemctl enable docker
  sudo chmod 777 /var/run/docker.sock

  echo "Installing Docker Compose"
  sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  docker–compose version
  python3 -m pip install awscli

  echo "Installing java and groovy"
  sudo yum install java-1.8.0-openjdk -y 
  sudo yum install groovy -y

  echo "Cloning common scripts and setting crontab"
  git clone -b master https://github.com/fuchicorp/common_scripts.git "/common_scripts"
  python3 -m pip install -r "/common_scripts/bastion-scripts/requirements.txt"
  cd /common_scripts/bastion-scripts/ && python3 sync-users.py

  echo "Installing kubectl command"
  curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.13.0/bin/linux/amd64/kubectl
  mv kubectl /usr/bin
  chmod +x /usr/bin/kubectl
  
  echo "Installing telnet command"
  sudo yum install bind-utils -y

  echo "Downloading terraform"
  wget https://releases.hashicorp.com/terraform/0.11.14/terraform_0.11.14_linux_amd64.zip --no-check-certificate
  unzip  terraform_0.11.14_linux_amd64.zip
  mv terraform /usr/bin
  chmod +x /usr/bin/terraform

  
  echo "30 * * * * source /root/.bashrc && cd /common_scripts/bastion-scripts/ && python3 sync-users.py" >> /sync-crontab
  crontab /sync-crontab
  echo "All scripts succesfully passed"
EOF
}

resource "null_resource" "local_generate_kube_config" {
  depends_on = ["google_compute_instance.vm_instance"]
  provisioner "local-exec" {
    command = <<EOF
    #!/bin/bash
    until ping -c1 ${google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip} >/dev/null 2>&1; do echo "Tring to connect bastion host '${google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip}' "; sleep 2; done
    wget https://raw.githubusercontent.com/fuchicorp/common_scripts/master/set-environments/kubernetes/set-kube-config.sh 
    ENDPOINT=$(kubectl get endpoints kubernetes | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')
    bash set-kube-config.sh $ENDPOINT
    ssh ${var.gce_ssh_user}@${google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip} sudo mkdir /fuchicorp | echo 'Folder exist'
    scp -r  "admin_config"   ${var.gce_ssh_user}@${google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip}:~/
    scp -r  "view_config"   ${var.gce_ssh_user}@${google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip}:~/
    ssh ${var.gce_ssh_user}@${google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip} sudo mv -f ~/*config /fuchicorp/
    rm -rf set-kube-config*
EOF
  }
}

resource "google_dns_record_set" "fuchicorp" {
  depends_on = ["google_compute_instance.vm_instance"]
  managed_zone = "fuchicorp"
  name         = "bastion.${var.google_domain_name}."
  type         = "A"
  ttl          = 300
  rrdatas      = ["${google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip}"]
}
