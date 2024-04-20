variable "instance_type" {
 description = "instance type"
#  default = "t2.micro" is not provided it will ask interactively on commandline during terraform apply or plan
 type = string
 }

variable "object_var" {
    type = object ({
        instance_type=string
        instance_size=number

    })
    default = object ({
        instance_type="t2.micro"
        instance_size=20

    })

    validation {
      condition = alltrue([
      contains(["t2.micro", "t2.small", "t2.medium"], var.instance_config.instance_type),
      var.instance_config.instance_size >= 8 && var.instance_config.instance_size <= 100
    ])
    error_message = "Invalid instance configuration. The 'instance_type' must be one of ['t2.micro', 't2.small', 't2.medium'], and the 'instance_size' must be between 8 and 100 GB."
  }
  
}

variable "project_name" {
  
}