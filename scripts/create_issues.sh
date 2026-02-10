#!/usr/bin/env bash
# Create 84 Day issues using the gh CLI (GitHub CLI).
# Usage:
#   gh auth login
#   bash scripts/create_issues.sh
#
# Requirements: gh (https://cli.github.com/), jq
REPO="alu99-slus/Azure-Start99"
TASKS_FILE="task.md"

if ! command -v gh >/dev/null 2>&1; then
  echo "gh CLI not found. Install it: https://cli.github.com/"
  exit 1
fi

if [ ! -f "$TASKS_FILE" ]; then
  echo "tasks.md not found. Make sure you saved tasks.md in repo root."
  exit 1
fi

echo "Creating issues from $TASKS_FILE in repo $REPO"

# Split tasks.md on '## Day ' headings and create issues
csplit -z -f /tmp/task- "$TASKS_FILE" '/^## Day [0-9]/' '{*}' >/dev/null 2>&1

for f in /tmp/task-*; do
  title=$(sed -n '1p' "$f" | sed 's/^## //')
  body=$(sed -n '2,$p' "$f")
  # create issue with label day-task
  echo "Creating issue: $title"
  gh issue create --repo "$REPO" --title "$title" --body "$body" --label "day-task"
  sleep 0.5
done

echo "Done. Check the repo issues page: https://github.com/$REPO/issues"