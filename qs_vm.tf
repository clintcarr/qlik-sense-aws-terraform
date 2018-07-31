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
