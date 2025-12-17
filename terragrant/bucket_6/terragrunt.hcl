include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../modules/s3-bucket"
}

inputs = {
  name = "6"
}
