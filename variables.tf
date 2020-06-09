variable "container_image" {
  description = "Docker image to run in the ECS cluster"
  default     = "devopsmixtape/hello_world_docker:latest"
}

variable "container_count" {
  description = "Number of Docker containers to run"
  default     = 1
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "256"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "512"
}
