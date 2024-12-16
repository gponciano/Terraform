variable "origin_id" {
  type        = string
  default     = ""
  description = "S3 ID bucket"
}

variable "bucket_domain_name" {
  type        = string
  default     = ""
  description = "S3 domain "
}

variable "cdn_price_class" {
    type = string
    default = "PriceClass_200"
    description = "CDN price class"
}

variable "cdn_tags" {
    type = map(string)
    default = {}
    
}