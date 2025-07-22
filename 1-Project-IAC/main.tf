module "s3" {
  source         = "./modules/s3"
  s3_bucket_name = "bucket-initialization"
  s3_tags = {
    Iac     = true
    Project = "IAC"
  }
}

module "cloudfront" {
  source             = "./modules/cloudfront"
  origin_id          = module.s3.bucket_id
  bucket_domain_name = module.s3.bucket_domain_name
  cdn_price    = "PriceClass_200"
  cdn_tags = {
    Iac     = true
    Project = "IAC"
  }
  depends_on = [module.s3]
}

/* module "sqs" {
  source  = "terraform-aws-modules/sqs/aws"

  name = "sqs-initialization"

  create_dlq = true
 

  tags = {
    Iac = true
  }
}
*/