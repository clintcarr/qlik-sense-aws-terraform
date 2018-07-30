### Variables

# AWS Access key
variable "access_key" {}

# AWS secret key
variable "secret_key" {}

AWS region variable "region" {}

# User to create in Windows and grant adminstrator access to
variable "user" {}

# Password for user created above
variable "password" {}

# AMI to use in deployment
variable "sense_ami_name" {
  default = "qlik_sense_enterprise_ami_*"
}

# Machine size
variable ec2_machine_size {
  default = "r3.xlarge"
}

# AWS key name (license)
variable qlik_sense_key_name {}

# Service account passwor
variable qse_svc_password {}

# Postgres password for Qlik Sense administrator
variable qse_db_admin_password {}

# Postgres passworf for repository
variable qse_db_repository_password {}

# Qlik Sense serial number
variable qse_license {}

# Qlik Sense control number
variable qse_control {}

# Qlik Sense license name
variable qse_name {}

# Qlik Sense license organisation
variable qse_org {}
