variable "state_bucket" {
  type        = string
  default     = "iac-state-bucket-nanook"
  description = "Bucket to store Terraform state files."

}