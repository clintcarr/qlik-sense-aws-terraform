output "Qlik Sense Public IP" {
  value = "${aws_instance.qlik_sense.public_ip}"
}
