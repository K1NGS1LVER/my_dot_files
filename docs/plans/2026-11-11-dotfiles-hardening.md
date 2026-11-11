# Dotfiles Hardening & Context Optimization Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Close the repo's real gaps found in survey — no secret scanning, agent memory (CLAUDE.md) unversioned, 72MB git history full of image blobs, uncommitted manifest drift, zero CI — without breaking any deployed symlinks.

**Architecture:** All changes are repo-side: a pre-commit hook + CI workflow guard secrets and shell quality, CLAUDE.md moves into version control with an archived cold log, and the working-tree drift is committed. History rewrite of image blobs is an explicit opt-in task (force-push, irreversible).

**Tech Stack:** gitleaks (brew), shellcheck (brew), GitHub Actions, git filter-repo (opt-in only), existing `scripts/doctor` as the verification gate.

## Global Constraints

- Edit repo files only; never the symlink targets under `$HOME` (CLAUDE.md hard rule).
- All symlink changes go through `scripts/lib/manifest.sh` — no hand-created symlinks.
- Run `scripts/doctor` after any task that touches symlinks, shell config, themes, Brewfile, or AeroSpace.
- Never commit runtime state, active-theme files, or binary images (existing gitignore rules).
- Repo remote: `github.com/K1NGS1LVER/my_dot_files` (private? verify in Task 1).
- This machine has `HOMEBREW_REQUIRE_TAP_TRUST` set — if `brew install` fails on an untrusted tap, `brew trust <tap>` first before assuming the command is wrong.

---

### Task 1: Secret audit + commit the working-tree drift

**Files:**
- Modify (commit only): `docs/CHEATSHEET.md`, `scripts/lib/manifest.sh`, `shell/nushell/modules/docker.nu`, `shell/zsh/functions/docker.zsh`
- Add (commit only): `docker/` (untracked; contains `kind-config.yaml`, referenced by manifest.sh:19 already)

**Interfaces:**
- Consumes: nothing.
- Produces: clean working tree. Later tasks build on a known-good commit, and `docker/` being tracked resolves the manifest.sh↔repo mismatch.

- [ ] **Step 1: Review the drift before committing it**

```bash
git diff docs/CHEATSHEET.md scripts/lib/manifest.sh shell/nushell/modules/docker.nu shell/zsh/functions/docker.zsh
ls -R docker/
```

Confirm nothing in `docker/` or the diffs contains credentials (kind-config.yaml should have no kubeconfig tokens).

- [ ] **Step 2: Run doctor against the current tree**

Run: `scripts/doctor`
Expected: passes (or note any pre-existing failures so Task 6 doesn't blame them on this plan).

- [ ] **Step 3: Commit the drift**

```bash
git add docs/CHEATSHEET.md scripts/lib/manifest.sh shell/nushell/modules/docker.nu shell/zsh/functions/docker.zsh docker/
git commit -m "feat(docker): add kind config + docker shell modules, sync manifest and cheatsheet"
```

- [ ] **Step 4: Verify clean tree**

Run: `git status --short`
Expected: empty.

---

### Task 2: Add gitleaks + shellcheck, wire pre-commit hook

**Files:**
- Modify: `Brewfile` (add `brew "gitleaks"` and `brew "shellcheck"`)
- Create: `scripts/hooks/pre-commit` (executable)
- Create: `scripts/setup-hooks` (one-liner installer that symlinks the hook into `.git/hooks/`)

**Interfaces:**
- Consumes: Task 1's clean tree.
- Produces: `.git/hooks/pre-commit` → repo hook; CI (Task 4) reuses the same gitleaks+shellcheck checks verbatim.

- [ ] **Step 1: Install tools**

```bash
brew install gitleaks shellcheck
```

Then add to `Brewfile` (alphabetical placement):

```ruby
brew "gitleaks"
brew "shellcheck"
```

- [ ] **Step 2: Verify the known-history finding**

Run: `gitleaks git --no-banner .`
Expected: no real secret findings. Known context from survey: `nchat/key.conf` was in history but contains only nchat keybindings (40 `key=` lines, zero token/api/secret assignments) — so a full history rewrite is **not** justified. If gitleaks disagrees, stop and re-evaluate before continuing.

- [ ] **Step 3: Write the pre-commit hook**

Create `scripts/hooks/pre-commit`:

```bash
#!/bin/bash
# Pre-commit: block secrets and broken shell syntax. Kept fast (<5s).
set -e
REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

if command -v gitleaks >/dev/null; then
  gitleaks git --no-banner "$REPO_ROOT" --pre-commit || {
    echo "gitleaks: secret-like content in staged changes. Fix or use 'gitleaks git --pre-commit --redact' to inspect." >&2
    exit 1
  }
fi

if command -v shellcheck >/dev/null; then
  changed="$(git diff --cached --name-only --diff-filter=ACM -- '*.sh' '*.zsh')"
  if [ -n "$changed" ]; then
    for f in $changed; do
      # .zsh files use zsh-only syntax; skip shellcheck rather than false-fail
      case "$f" in *.zsh) continue ;; esac
      shellcheck -x "$REPO_ROOT/$f" || exit 1
    done
  fi
fi

exit 0
```

- [ ] **Step 4: Install hook into .git**

```bash
chmod +x scripts/hooks/pre-commit
mkdir -p .git/hooks && ln -sf "$PWD/scripts/hooks/pre-commit" .git/hooks/pre-commit
```

Document the symlink step in `docs/SETUP_GUIDE.md`'s install section (one line: `ln -sf "$DOTFILES/scripts/hooks/pre-commit" .git/hooks/pre-commit`) so fresh clones get it.

- [ ] **Step 5: Test the hook fires**

```bash
echo 'API_KEY="sk-live-FAKEtest123"' > /tmp/leak-test.txt && git add /tmp/leak-test.txt 2>/dev/null || cp /tmp/leak-test.txt ./leak-test.txt && git add leak-test.txt
git commit -m "test leak" || echo "HOOK BLOCKED — working"
git reset HEAD leak-test.txt 2>/dev/null; rm -f leak-test.txt /tmp/leak-test.txt
```

Expected: commit rejected by gitleaks.

- [ ] **Step 6: Commit**

```bash
git add Brewfile scripts/hooks/pre-commit docs/SETUP_GUIDE.md
git commit -m "feat(security): gitleaks+shellcheck pre-commit hook, add tools to Brewfile"
```

Run: `scripts/doctor`
Expected: passes (Brewfile changed — doctor must confirm).

---

### Task 3: Version-control CLAUDE.md, archive cold memory

**Files:**
- Modify: `.gitignore` (delete lines 107–109: `.claude/` block's `CLAUDE.md` line — keep `.claude/`)
- Modify: `CLAUDE.md`
- Create: `docs/learned-fixes-archive.md`

**Interfaces:**
- Consumes: nothing.
- Produces: CLAUDE.md committed; agents on fresh clones get project memory. `docs/learned-fixes-archive.md` is the cold log — referenced by path only, not loaded per-session.

- [ ] **Step 1: Un-ignore CLAUDE.md**

Edit `.gitignore`: remove the line `CLAUDE.md` (line 109). Keep `.claude/` ignored (session state).

- [ ] **Step 2: Check CLAUDE.md is safe to publish**

Run: `grep -inE '(token|api.?key|password|secret)\s*[:=]' CLAUDE.md`
Expected: no matches. (Survey: it's conventions + dated fix bullets only.)

- [ ] **Step 3: Move cold entries out of CLAUDE.md**

Move bullets dated before 2026-07-15 from "Learned fixes" into `docs/learned-fixes-archive.md` (same bullet format, header: `# Archived learned fixes (cold log — read on demand)`). Add one pointer line in CLAUDE.md:

```markdown
- Pre-July-2026 fixes: see `docs/learned-fixes-archive.md` (read on demand, not loaded per-session).
```

Rationale: 12 of the 16 bullets are from July — historical, rarely re-triggered. Hot log stays under ~8 bullets / ~4KB.

- [ ] **Step 4: Verify the trimmed file**

Run: `wc -c CLAUDE.md`
Expected: < 10KB (from 13.9KB).

- [ ] **Step 5: Commit**

```bash
git add .gitignore CLAUDE.md docs/learned-fixes-archive.md
git commit -m "feat(agents): version-control CLAUDE.md, archive cold learned-fixes"
```

- [ ] **Step 6: Add a growth rule to CLAUDE.md**

Append to CLAUDE.md's "Learned fixes" intro:

```markdown
Archive rule: when the hot log exceeds ~8 bullets, move the oldest dated bullets to `docs/learned-fixes-archive.md`.
```

---

### Task 4: CI — gitleaks + shellcheck on push

**Files:**
- Create: `.github/workflows/ci.yml`

**Interfaces:**
- Consumes: Task 2's tool choices (gitleaks, shellcheck).
- Produces: red CI on secrets or broken scripts.

- [ ] **Step 1: Write the workflow**

Create `.github/workflows/ci.yml`:

```yaml
name: ci
on: [push, pull_request]
jobs:
  secrets:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with: { fetch-depth: 0 }
      - uses: gitleaks/gitleaks-action@v2
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
  shell:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: brew install shellcheck
      - run: git ls-files '*.sh' | xargs shellcheck -x
      - name: no binary images tracked
        run: |
          ! git ls-files | grep -E '\.(png|jpg|jpeg|gif)$'
      - name: no .DS_Store tracked
        run: |
          ! git ls-files | grep -i 'DS_Store'
```

Notes: `fetch-depth: 0` so gitleaks scans full history (this repo's history already contains the benign `nchat/key.conf`; if gitleaks-action flags it, add a `.gitleaksignore` with the commit SHA + `# keybindings only, no credentials` comment — that's the documented mechanism, not a code change).
The image/DS_Store guards are CI-enforcement of the CLAUDE.md hard rule "never commit binary images" — currently only a gitignore convention that a force-add can bypass.

- [ ] **Step 2: Confirm repo is private or acceptable to expose file list**

Run: `gh repo view K1NGS1LVER/my_dot_files --json visibility -q .visibility`
If public and the user prefers private, flag to user before pushing — do not silently change visibility.

- [ ] **Step 3: Push and watch first run**

```bash
git push
gh run watch --exit-status
```

Expected: green, or `.gitleaksignore` needed per Step 1 note.

- [ ] **Step 4: Commit**

```bash
git add .github/workflows/ci.yml
git commit -m "ci: gitleaks + shellcheck + no-binary-image guards"
git push
```

---

### Task 5 (OPT-IN, ask user first): Shrink 72MB git history

**Files:**
- None created. Operation on `.git` + force-push.

**Interfaces:**
- Consumes: user approval (irreversible, force-push).
- Produces: smaller clone for fresh machines.

This is the only destructive task. **Blocked until user explicitly approves.**

- [ ] **Step 1: Measure what rewrite buys**

```bash
git filter-repo --analyze
# inspect .git/filter-repo/analysis/path-deleted-sizes.txt for blob totals
```

- [ ] **Step 2: Get user approval with concrete numbers**

Show: total blob bytes recoverable, backup plan (`git clone --mirror` to `~/dotfiles-history-backup.git` first), and consequence: all existing clones invalid, PRs/shas change, remote force-pushed.

- [ ] **Step 3: Only if approved — rewrite image blobs from history**

```bash
git clone --mirror "$PWD" /tmp/opencode/dotfiles-backup.git
git filter-repo --path-glob '*.{png,jpg,jpeg,gif}' --invert-paths --force
git push origin --force --all && git push origin --force --tags
```

- [ ] **Step 4: Re-verify after rewrite**

Run: `scripts/doctor && gitleaks git --no-banner . && git status --short`
Expected: all clean. Working tree is untouched by the rewrite (filter-repo operates on history; verify no symlink target changed).

Skip Task 5 entirely if measured savings < ~30MB — the complexity of a force-push isn't worth it.

---

### Task 6: Final verification sweep

**Files:**
- None (verification only), unless doctor finds failures.

**Interfaces:**
- Consumes: all prior tasks.
- Produces: evidence the repo is still healthy end-to-end.

- [ ] **Step 1: Full doctor**

Run: `scripts/doctor`
Expected: passes.

- [ ] **Step 2: Deploy dry check**

```bash
bash -n scripts/deploy && bash -n scripts/lib/manifest.sh
git status --short
```

Expected: clean tree, no syntax errors.

- [ ] **Step 3: CI green**

Run: `gh run list --limit 1`
Expected: latest run `completed / success`.

- [ ] **Step 4: Update CLAUDE.md learned-fixes log**

Append one dated bullet summarizing what shipped (gitleaks hook, CI, CLAUDE.md versioned) so future sessions know the guards exist.

---

## Self-review notes

- Spec coverage: security (Tasks 2, 4), stability (Tasks 1, 4, 6), context optimization (Task 3), QoL (Brewfile tooling, hook installer, SETUP_GUIDE note). History bloat = opt-in Task 5.
- The `nchat/key.conf` history finding was verified benign (keybindings, no creds) — plan explicitly does NOT mandate history rewrite for it.
- Task ordering matters: Task 1 first (clean tree), Task 2 before Task 4 (CI mirrors hook), Task 3 independent, Task 5 gated on user.
