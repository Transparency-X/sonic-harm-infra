# -----------------------------------------------------------------------------
# Provider
# -----------------------------------------------------------------------------
provider "github" {
  owner = var.github_org
  # Token is picked up from the GITHUB_TOKEN environment variable automatically
}

# -----------------------------------------------------------------------------
# Locals: read and parse the central registry
# -----------------------------------------------------------------------------
locals {
  registry_file = file("${path.module}/registry.yaml")
  registry      = yamldecode(local.registry_file)
  projects      = local.registry.projects

  # Build a map keyed by repository name for easy for_each usage
  projects_map = { for p in local.projects : p.name => p }
}

# -----------------------------------------------------------------------------
# Repository resources
# -----------------------------------------------------------------------------
resource "github_repository" "sonic_repo" {
  for_each = local.projects_map

  name        = each.value.name
  description = each.value.description
  visibility  = "public"           # change to "private" if needed
  auto_init   = true               # creates an initial commit so we can add files
  has_issues  = true
  has_wiki    = false
  topics      = each.value.topics

  # Enable if you want a standardised licence and .gitignore
  # template {
  #   owner      = var.github_org
  #   repository = "your-template-repo"
  # }
}

# -----------------------------------------------------------------------------
# README file for every repository – generated from the full registry
# -----------------------------------------------------------------------------
resource "github_repository_file" "readme" {
  for_each = local.projects_map

  repository          = github_repository.sonic_repo[each.key].name
  branch              = github_repository.sonic_repo[each.key].default_branch
  file                = "README.md"
  content             = templatefile("${path.module}/templates/readme.md.tpl", {
    project      = each.value
    all_projects = local.projects
    github_org   = var.github_org
  })
  commit_message      = "docs: auto-generated README with programme cross-links"
  commit_author       = "Sonic Harm Infrastructure Bot"
  commit_email        = "infra@transparency-x.org"
  overwrite_on_create = true
}

# -----------------------------------------------------------------------------
# (Optional) Branch protection for every repository’s main branch
# Uncomment if you want standard protection rules
# -----------------------------------------------------------------------------
# resource "github_branch_protection" "protect_main" {
#   for_each = local.projects_map

#   repository_id = github_repository.sonic_repo[each.key].node_id
#   pattern       = "main"

#   required_status_checks {
#     strict   = false
#     contexts = []
#   }

#   required_pull_request_reviews {
#     required_approving_review_count = 1
#   }
# }
