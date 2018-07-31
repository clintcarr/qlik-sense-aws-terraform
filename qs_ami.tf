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
