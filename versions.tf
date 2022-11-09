terraform {
  required_version = ">= 1.3.4"

  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = ">= 4.19"
      configuration_aliases = [aws.destination]
    }
  }
}
