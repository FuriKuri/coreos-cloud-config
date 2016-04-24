variable "do_token" {}
variable "domain_name" {}
variable "ssh_fingerprint" {}

variable "service_count" {
  default = 3
}

variable "worker_count" {
  default = 3
}

provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_droplet" "coreos" {
  count = "${var.service_count}"
  name = "${format("coreos-%02d", count.index)}"
  size = "512mb"
  image = "coreos-stable"
  region = "fra1"
  private_networking = true
  ssh_keys = ["${var.ssh_fingerprint}"]
  user_data = "${file(".build/service.yml")}"
}

resource "digitalocean_droplet" "coreos-worker" {
  count = "${var.worker_count}"
  name = "${format("coreos-worker-%02d", count.index)}"
  size = "512mb"
  image = "coreos-stable"
  region = "fra1"
  private_networking = true
  ssh_keys = ["${var.ssh_fingerprint}"]
  user_data = "${file(".build/worker.yml")}"
}

resource "digitalocean_record" "coreos" {
    count = "${var.service_count}"
    domain = "${var.domain_name}"
    type = "A"
    name = "${format("coreos-%02d", count.index)}"
    value = "${element(digitalocean_droplet.coreos.*.ipv4_address, count.index)}"
}

resource "digitalocean_record" "coreos-worker" {
    count = "${var.worker_count}"
    domain = "${var.domain_name}"
    type = "A"
    name =  "${format("coreos-worker-%02d", count.index)}"
    value = "${element(digitalocean_droplet.coreos-worker.*.ipv4_address, count.index)}"
}
