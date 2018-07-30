provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_security_group" "qlik_sense_sg" {
  name        = "${upper(var.user)} - Qlik Sense"
  description = "Access rules for the Qlik Sense"

  tags {
    Name = "${upper(var.user)} - Qlik Sense Security Group"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = "true"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Get the latest Windows 2016 Base AMI
data "aws_ami" "qlik_sense_enterprise" {
  most_recent = true

  filter {
    name   = "name"
    values = ["${var.sense_ami_name}"]
  }

  filter {
    name   = "owner-id"
    values = ["679593333241"]
  }
}

data "template_file" "qlik_sense_userdata" {
  template = "${file("./qlikSenseUserdata.ps1")}"

  vars {
    user                       = "${var.user}"
    password                   = "${var.password}"
    qse_svc_password           = "${var.qse_svc_password}"
    qse_db_admin_password      = "${var.qse_db_admin_password}"
    qse_db_repository_password = "${var.qse_db_repository_password}"
    qse_license                = "${var.qse_license}"
    qse_control                = "${var.qse_control}"
    qse_name                   = "${var.qse_name}"
    qse_org                    = "${var.qse_org}"
  }
}

resource "aws_instance" "qlik_sense" {
  ami                    = "${data.aws_ami.qlik_sense_enterprise.id}"
  instance_type          = "${var.ec2_machine_size}"
  key_name               = "${var.qlik_sense_key_name}"
  vpc_security_group_ids = ["${aws_security_group.qlik_sense_sg.id}"]
  user_data              = "${data.template_file.qlik_sense_userdata.rendered}"

  tags {
    Name  = "${upper(var.user)} - Qlik Sense Client"
    Owner = "${upper(var.user)}"
  }
}
