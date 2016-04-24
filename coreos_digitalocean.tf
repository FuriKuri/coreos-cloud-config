variable "do_token" {}
variable "domain_name" {}
variable "ssh_fingerprint" {}

provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_droplet" "coreos1" {
  name = "coreos1"
  size = "512mb"
  image = "coreos-stable"
  region = "fra1"
  private_networking = true
  ssh_keys = ["${var.ssh_fingerprint}"]
  user_data = "${file(".build/service.yml")}"
}

resource "digitalocean_droplet" "coreos2" {
  name = "coreos2"
  size = "512mb"
  image = "coreos-stable"
  region = "fra1"
  private_networking = true
  ssh_keys = ["${var.ssh_fingerprint}"]
  user_data = "${file(".build/service.yml")}"
}

resource "digitalocean_droplet" "coreos3" {
  name = "coreos3"
  size = "512mb"
  image = "coreos-stable"
  region = "fra1"
  private_networking = true
  ssh_keys = ["${var.ssh_fingerprint}"]
  user_data = "${file(".build/service.yml")}"
}

resource "digitalocean_droplet" "coreos-worker1" {
  name = "coreos-worker1"
  size = "512mb"
  image = "coreos-stable"
  region = "fra1"
  private_networking = true
  ssh_keys = ["${var.ssh_fingerprint}"]
  user_data = "${file(".build/worker.yml")}"
}

resource "digitalocean_droplet" "coreos-worker2" {
  name = "coreos-worker2"
  size = "512mb"
  image = "coreos-stable"
  region = "fra1"
  private_networking = true
  ssh_keys = ["${var.ssh_fingerprint}"]
  user_data = "${file(".build/worker.yml")}"
}

resource "digitalocean_droplet" "coreos-worker3" {
  name = "coreos-worker3"
  size = "512mb"
  image = "coreos-stable"
  region = "fra1"
  private_networking = true
  ssh_keys = ["${var.ssh_fingerprint}"]
  user_data = "${file(".build/worker.yml")}"
}

resource "digitalocean_record" "coreos1" {
    domain = "${var.domain_name}"
    type = "A"
    name = "coreos1"
    value = "${digitalocean_droplet.coreos1.ipv4_address}"
}

resource "digitalocean_record" "coreos2" {
    domain = "${var.domain_name}"
    type = "A"
    name = "coreos2"
    value = "${digitalocean_droplet.coreos2.ipv4_address}"
}

resource "digitalocean_record" "coreos3" {
    domain = "${var.domain_name}"
    type = "A"
    name = "coreos3"
    value = "${digitalocean_droplet.coreos3.ipv4_address}"
}

resource "digitalocean_record" "coreos-worker1" {
    domain = "${var.domain_name}"
    type = "A"
    name = "coreos-worker1"
    value = "${digitalocean_droplet.coreos-worker1.ipv4_address}"
}

resource "digitalocean_record" "coreos-worker2" {
    domain = "${var.domain_name}"
    type = "A"
    name = "coreos-worker2"
    value = "${digitalocean_droplet.coreos-worker2.ipv4_address}"
}

resource "digitalocean_record" "coreos-worker3" {
    domain = "${var.domain_name}"
    type = "A"
    name = "coreos-worker3"
    value = "${digitalocean_droplet.coreos-worker3.ipv4_address}"
}

output "address_coreos1" {
  value = "${digitalocean_droplet.coreos1.ipv4_address}"
}

output "address_coreos2" {
  value = "${digitalocean_droplet.coreos2.ipv4_address}"
}

output "address_coreos3" {
  value = "${digitalocean_droplet.coreos3.ipv4_address}"
}

output "address_coreos-worker1" {
  value = "${digitalocean_droplet.coreos-worker1.ipv4_address}"
}

output "address_coreos-worker2" {
  value = "${digitalocean_droplet.coreos-worker2.ipv4_address}"
}

output "address_coreos-worker3" {
  value = "${digitalocean_droplet.coreos-worker3.ipv4_address}"
}
