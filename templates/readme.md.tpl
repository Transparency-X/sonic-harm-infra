# ${project.full_title}

${project.description}

> This repository is part of the **[Sonic Harm Programme](https://github.com/${github_org}/SonicHarm)** – a Transparency‑X research initiative.

## 📋 Sonic Harm Programme Projects

| Repository | Full Title | Domain |
|------------|------------|--------|
%{ for p in all_projects ~}
| [${p.name}](https://github.com/${github_org}/${p.name}) | ${p.full_title} | ${p.domain} |
%{ endfor ~}

---

For more information about the overall programme, visit the [Sonic Harm Registry](https://github.com/${github_org}/SonicHarm).
