variable "github_org" {
  description = "GitHub organization or user name that owns the repositories"
  type        = string
  default     = "Transparency-X"
}

variable "github_token" {
  description = "GitHub personal access token (set via env GITHUB_TOKEN, not here)"
  type        = string
  sensitive   = true
  default     = ""
}
