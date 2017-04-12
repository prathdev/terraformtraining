variable "aws_access_key" {
  type = "string"
}

variable "aws_secret_key" {
  type = "string"
}

variable "aws_region" {
  type    = "string"
  default = "us-west-1"
}

variable "totalcount" {
  type    = "string"
  default = "3"
}

terraform {
  backend "atlas" {
    name = "pratheeksha/training"
  }
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  # ...
  count                  = "${var.totalcount}"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-7e08481a"
  ami                    = "ami-eea9f38e"
  vpc_security_group_ids = ["sg-834d35e4"]

  tags {
    Note     = "test instance"
    Input    = "ooutput"
    Identity = "autodesk-eagle"
    Name     = "web ${count.index+1}/${var.totalcount}"
  }
}

output "public_ip" {
  value = ["${aws_instance.web.*.public_ip}"]
}

output "public_dns" {
  value = ["${aws_instance.web.*.public_dns}"]
}
