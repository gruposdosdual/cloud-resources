variable "environment" {
  type = string
}

# variables.tf or in main.tf

variable "container_insight_status" {
  description = "The status of container insights (enable or disable)"
  type        = object({
    disable = bool
  })
}

variable "vpc_id" {
    type = string
  
}
