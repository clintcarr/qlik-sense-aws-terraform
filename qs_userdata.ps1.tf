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
