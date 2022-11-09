# empty provider definitiom has to be here because of this issue in terraform
# https://github.com/hashicorp/terraform/issues/28490

provider "aws" {
  alias = "destination"
}
