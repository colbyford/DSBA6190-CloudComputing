// Tags

variable "class" {
  description = "Class Name"
  type        = string
  default     = "dsba6190"
}

variable "group" {
  description = "Group Name"
  type        = string
  default     = "class"
}

variable "environment" {
  description = "Environment (dev, stg, prd)"
  type        = string
  default     = "dev"
}

variable "region" {
  description = "Location of Resource Group"
  type        = string
  default     = "eastus"

  validation {
    condition     = contains(["westus3", "westus2", "westus", "eastus2", "eastus"], lower(var.region))
    error_message = "Unsupported Azure Region specified. Supported regions include: westus3, westus2, westus, eastus2, eastus."
  }
}

variable "suffix" {
  description = "Deployment suffix"
  type        = string
  default     = "001"
}

variable "semester" {
  description = "Semester Name"
  type        = string
  default     = "fall2024"
}

variable "instructor" {
  description = "Instructor Name"
  type        = string
  default     = "cford38"
}



// Azure-Specific Variables

/// Subscription
variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
  default     = "e9bc187a-e9a1-46be-822e-e955a2563601"
}