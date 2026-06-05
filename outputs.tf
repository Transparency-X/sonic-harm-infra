output "repository_urls" {
  description = "HTTPS clone URLs for all Sonic Harm repositories"
  value       = { for name, repo in github_repository.sonic_repo : name => repo.html_url }
}
