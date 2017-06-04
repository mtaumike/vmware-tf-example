# used with remote storage in AWS S3, encryption, locking (via dynamo), etc
#terraform {
#  backend "s3" {
#    bucket     = "my-terraform-state"
#    key        = "vmware-tf-launch/terraform.tfstate"
#    region     = "us-east-2"
#    kms_key_id = "arn:aws:kms:us-east-2:ACCOUNT-NUMBER:key/MY-GUUID-OF-KEY"
#    encrypt    = "1"
#    lock_table = "my-tf-state"
#  }
#}

