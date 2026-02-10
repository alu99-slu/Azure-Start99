![Progress](https://img.shields.io/badge/Progress-0%25-red)
  **Progress:** 0/1 tasks completed (0%)

This repository is a beginner-focused, fast‑path scaffold to learn Azure cloud engineering (Python sample app, Terraform skeleton, Dockerfile, Helm chart stub, GitHub Actions, and devcontainer). It also includes a script to create 84 "Day N" GitHub issues as a checklist and a calendar file (calendar.ics) with daily events.

What’s included
- app/: simple Python Flask sample app
- Dockerfile: containerize the sample app
- helm/: Helm chart stub for deploying to AKS
- terraform/: starter Terraform files to provision Azure infra
- .devcontainer/: VS Code devcontainer for reproducible dev env
- .github/workflows/: CI workflow and a progress-update workflow
- scripts/create_issues.sh + tasks.md: create 84 issues (runs with gh CLI)
- calendar.ics: import to your calendar to get daily reminders

Progress tracking
- README contains a progress placeholder badge that will be updated by the included GitHub Action (.github/workflows/update_progress.yml). The action counts closed Day issues and updates the progress % in the README.

Quick start (create & push repo)
1. Create a new public GitHub repo named `alkalk00/my-azure-starter` (on GitHub).
2. Clone it locally:
   - git clone https://github.com/alkalk00/my-azure-starter.git
   - cd my-azure-starter
3. Copy the files from this message into the repo paths below.
4. Commit & push:
   - git add .
   - git commit -m "Initial scaffold for Azure starter"
   - git push origin main

Create the 84 issues (local)
1. Install GitHub CLI: https://cli.github.com/
2. Authenticate: gh auth login
3. From repo root: bash scripts/create_issues.sh
   - This will create 84 issues titled "Day 1 — …" etc.

Import calendar
- Save calendar.ics from this repo to your machine and import into Google Calendar / Outlook (File > Import).

CI / Deploy notes
- GitHub Actions included are sample CI pipelines. Customize with your Azure container registry and AKS details.
- Terraform includes a skeleton; if you choose remote backend with Azure Storage, follow the instructions in terraform/README.md and set environment variables accordingly.

If you want me to push these files and create the issues directly, I can do that once you grant me push & issue permissions for the repo (or create the repo and grant me collaborator access). For now, follow the steps above and let me know if you want me to generate a ZIP of all files or step-by-step screenshots.

Good luck — and tell me when you want the repo pushed or if you want me to walk you through any step.