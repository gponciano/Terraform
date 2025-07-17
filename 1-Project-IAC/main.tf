resource "aws_s3_bucket" "s3_bucket" {
    bucket = "initial-bucket-iac-${terraform.workspace}"

    tags = {
        Name = "first-bucket-iac"
        Iac = true
        context = "${terraform.workspace}"
    }
}