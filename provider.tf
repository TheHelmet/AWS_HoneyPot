# The default "aws" configuration is used for AWS resources in the root
# module where no explicit provider instance is selected.
provider "aws" {
  region = "us-west-1"
}

# An alternate configuration is also defined for a different
# region, using the alias "usw2".
provider "aws" {
  alias  = "usw2"
  region = "us-west-2"
}

# An alternate configuration is also defined for a different
# region, using the alias "apse2".
provider "aws" {
  alias  = "apse2"
  region = "ap-southeast-2"
}

# An alternate configuration is also defined for a different
# region, using the alias "euw2".
provider "aws" {
  alias  = "euw2"
  region = "eu-west-2"
}
