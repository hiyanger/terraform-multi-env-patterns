remote_state {
  backend = "local"
  config = {
    path = "${path_relative_to_include()}/terraform.tfstate"
  }
}

# プロバイダーキャッシュの共有設定
terraform {
  extra_arguments "plugin_cache" {
    commands = [
      "init",
      "plan",
      "apply",
      "destroy",
    ]
    
    env_vars = {
      TF_PLUGIN_CACHE_DIR = "${get_parent_terragrunt_dir()}/.terraform-plugin-cache"
    }
  }
}

generate "versions" {
  path      = "versions.tf"
  if_exists = "overwrite"
  contents  = <<-EOT
    terraform {
      required_version = "= 1.14.0"
      
      required_providers {
        aws = {
          source  = "hashicorp/aws"
          version = "6.23.0"
        }
      }
      
      backend "local" {}
    }
  EOT
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<-EOT
    provider "aws" {
      region  = "ap-northeast-1"
      profile = "test-profile"
    }
  EOT
}
