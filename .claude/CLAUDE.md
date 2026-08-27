@RTK.md

# Personal preferences

## Working style

- Chat with me in Portuguese; code, commits, and PRs in English.
- Ask before adding new dependencies or changing public APIs.
- If unsure about an API or behavior, say so and check the code/docs instead of guessing.
- After changing code, run the project's tests/linter if available and report the result.
- Do not create git worktrees; work on branches in the main clone.
- In plan mode, if I ask a question, just answer it. Only call ExitPlanMode when I explicitly ask for a plan or implementation.

## GitHub PRs

- When replying to or commenting on any GitHub Pull Request (reviews, review comments, PR descriptions, replies), always write in English, in "caveman style": short and direct, but not curt.

## Code comments

- Do not add comments to code unless truly necessary (e.g. non-obvious logic, workarounds, important caveats, TODOs). Never add comments that just restate what the code does.

## Local repositories

- When a task involves several services/repositories, you can check `~/Documents/work/apps/<repo>`; if you don’t find it, let me know, and I will clone it from GitHub for you.
- Most services/repositories have their own corresponding `<repo>-chart`; if you don’t find it, let me know, and I will clone it from GitHub for you.

- Ignore git worktrees: pule diretórios onde `.git` é um arquivo (não uma pasta) e qualquer `.claude/worktrees/` dentro dos repos. Mapeie só o clone principal.
