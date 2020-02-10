#cms-integration/terragrunt.hcl

terraform {
  before_hook "before_hook" {
    commands = ["apply","plan"]
    execute = ["echo", "Running Terraform"]
  }

  after_hook "after_hook" {
    commands = ["apply", "plan"]
    execute = ["echo", "Finished running terraform"]
    run_on_error = true
  }
}
