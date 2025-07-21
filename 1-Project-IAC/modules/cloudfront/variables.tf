variable "origin_id" {
    type = string
    description = "ID of S3 bucket to be used as origin for CloudFront distribution."
}

variable "bucket_domain_name"  {
    type = string
    description = "The domain name of the S3 bucket."
}

variable "cdn_price" {
    type = string
    default = "PriceClass_200"
    description = "The price class for the CloudFront distribution."
}

variable "cdn_tags" {
    type = map(string)
    default = {}
    description = "Tags to be applied to the CloudFront distribution."
}