variable "project_id" {
  description = "The GCP project ID where resources will be created."
  type        = string
}

variable "region" {
  description = "The GCP region used for regional resources."
  type        = string
}

variable "zone" {
  description = "The GCP zone used for zonal resources."
  type        = string
}