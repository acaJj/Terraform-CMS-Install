# Terraform-CMS-Install

Practice project created when I was first learning how to use Terraform and Docker. Creates a simple CMS environment with a MySQL database in Docker containers and provisions them using Terraform.

Has modules to create either a WordPress or Laravel website, to switch from one to the other go into the topmost 'main.tf' file and switch the source attribute for the 'cms_docker' module to the appropriate one.
