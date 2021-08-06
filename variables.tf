variable "project" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "subnet_cidr" {
  type = map(string)

  default = {
    public_a = "",
    public_c = ""
  }
}

variable "az" {
  type = map(string)

  default = {
    az_a = "ap-northeast-1a"
    az_c = "ap-northeast-1c"
    az_d = "ap-northeast-1d"
  }
}

variable "key_pair" {
  type = string
}

variable "ami" {
  type = map(string)

  default = {
    amazon-linux-2 = "ami-06098fd00463352b6"
  }
}

variable "my_global_ip" {
  type = string
}
