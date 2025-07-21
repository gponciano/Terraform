variable "s3_bucket_name" {
  description = "The name of the S3 bucket."
  type        = string
  
}

variable "s3_tags" {
    type = map(string)
    default = {}
    description = "Tags to be applied to the S3 bucket."
}