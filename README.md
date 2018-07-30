# Qlik Sense AMI deployment - AWS

## Pre-requisites
1. An Amazon EC2 account
2. You must subscribe to the Qlik Sense AMI (https://aws.amazon.com/marketplace/pp/B01M5HCC0D?qid=1532912898605&sr=0-2&ref_=srh_res_product_title)
3. You need an EC2 access_key and security_key
4. Qlik Sense license

## Instructions
1. Download and install Terraform (https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_windows_amd64.zip)
2. Extract the archive and add the path to the file to your user/system path.
3. Clone this repository
4. run __terraform init__ from shell

## Variables
1. AWS Access key
2. AWS secret key
3. AWS region
4. User (Windows requires complex passwords Upper/Lower/Special/Min Length)
5. Password
6. Instance size
7. AWS key name (certificate)
8. Service Account Password (Windows requires complex passwords Upper/Lower/Special/Min Length)
9. Postgres admin password
10. Password for repository user
11. Qlik Sense serial number
12. Qlik Sense Control number
13. Qlik Sense license name
14. Qlik Sense license organisation





