# GitHub Setup Guide

Complete guide to set up and push the AMOZIT Customer Flutter project to GitHub.

---

## Prerequisites

- Git installed on your system
- GitHub account (https://github.com/DoomCoder99)
- Repository created: `vigilant-fiesta` (https://github.com/DoomCoder99/vigilant-fiesta.git)

---

## Step 1: Verify Git Configuration

Check your Git configuration:

```bash
git config --global user.name
git config --global user.email
```

If not configured, set your Git identity:

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

---

## Step 2: Verify Remote Repository

Check if remote is already configured:

```bash
git remote -v
```

Expected output:
```
origin  https://github.com/DoomCoder99/vigilant-fiesta.git (fetch)
origin  https://github.com/DoomCoder99/vigilant-fiesta.git (push)
```

If not configured, add the remote:

```bash
git remote add origin https://github.com/DoomCoder99/vigilant-fiesta.git
```

---

## Step 3: Choose Authentication Method

### Method A: Personal Access Token (Recommended for HTTPS)

**Step 3A.1: Create Personal Access Token**

1. Go to GitHub Settings: https://github.com/settings/tokens
2. Click **"Generate new token"** → **"Generate new token (classic)"**
3. Give it a name: `amoz_customer_repo`
4. Select scopes:
   - ✅ `repo` (Full control of private repositories)
5. Click **"Generate token"**
6. **Copy the token immediately** (you won't see it again!)

**Step 3A.2: Push Using Token**

```bash
git push -u origin main
```

When prompted:
- **Username:** `DoomCoder99`
- **Password:** `<paste-your-personal-access-token>`

**Step 3A.3: Store Credentials (Optional)**

To avoid entering credentials every time:

```bash
# macOS
git config --global credential.helper osxkeychain

# Linux
git config --global credential.helper store

# Windows
git config --global credential.helper wincred
```

---

### Method B: SSH Key (Recommended for Long-term)

**Step 3B.1: Check for Existing SSH Key**

```bash
ls -al ~/.ssh
```

Look for files named `id_rsa.pub` or `id_ed25519.pub`

**Step 3B.2: Generate SSH Key (if needed)**

```bash
ssh-keygen -t ed25519 -C "your.email@example.com"
```

Press Enter to accept default file location, then enter a passphrase (optional but recommended).

**Step 3B.3: Add SSH Key to GitHub**

1. Copy your public key:
   ```bash
   cat ~/.ssh/id_ed25519.pub
   # or
   cat ~/.ssh/id_rsa.pub
   ```

2. Go to GitHub Settings → SSH and GPG keys: https://github.com/settings/keys
3. Click **"New SSH key"**
4. Title: `MacBook Pro` (or your device name)
5. Key: Paste your public key
6. Click **"Add SSH key"**

**Step 3B.4: Test SSH Connection**

```bash
ssh -T git@github.com
```

You should see: `Hi DoomCoder99! You've successfully authenticated...`

**Step 3B.5: Update Remote to Use SSH**

```bash
git remote set-url origin git@github.com:DoomCoder99/vigilant-fiesta.git
```

**Step 3B.6: Push Using SSH**

```bash
git push -u origin main
```

---

### Method C: GitHub CLI (Easiest)

**Step 3C.1: Install GitHub CLI**

```bash
# macOS
brew install gh

# Verify installation
gh --version
```

**Step 3C.2: Authenticate**

```bash
gh auth login
```

Follow the prompts:
- Choose GitHub.com
- Choose HTTPS or SSH
- Authenticate via browser

**Step 3C.3: Push**

```bash
git push -u origin main
```

---

## Step 4: Push Your Code

Once authenticated, push your code:

```bash
# Ensure you're on main branch
git branch -M main

# Push to GitHub
git push -u origin main
```

Expected output:
```
Enumerating objects: X, done.
Counting objects: 100% (X/X), done.
Delta compression using up to X threads
Compressing objects: 100% (X/X), done.
Writing objects: 100% (X/X), done.
Total X (delta X), reused 0 (delta 0), pack-reused 0
To https://github.com/DoomCoder99/vigilant-fiesta.git
 * [new branch]      main -> main
Branch 'main' set up to track 'remote/origin/main'.
```

---

## Step 5: Verify on GitHub

1. Go to: https://github.com/DoomCoder99/vigilant-fiesta
2. Verify all files are uploaded
3. Check the commit history

---

## Step 6: Set Up Repository Settings (Optional)

### Add Repository Description

On GitHub repository page:
- Click **"Settings"** → **"General"**
- Add description: `AMOZIT Customer - Flutter Mobile App (Android & iOS)`

### Add Topics/Tags

- Click **"Topics"** button
- Add: `flutter`, `dart`, `mobile-app`, `android`, `ios`, `getx`, `localization`

### Add README Badges (Optional)

Update `README.md` with badges:

```markdown
![Flutter](https://img.shields.io/badge/Flutter-3.9.2-blue)
![Dart](https://img.shields.io/badge/Dart-3.9.2-blue)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-lightgrey)
![License](https://img.shields.io/badge/License-Private-red)
```

---

## Troubleshooting

### Issue: "fatal: could not read Username"

**Solution:** Use Personal Access Token or SSH key (see Method A or B above)

### Issue: "Permission denied (publickey)"

**Solution:** 
1. Check SSH key is added to GitHub
2. Test SSH connection: `ssh -T git@github.com`
3. Ensure remote URL uses SSH: `git remote set-url origin git@github.com:...`

### Issue: "Repository not found"

**Solution:**
1. Verify repository exists: https://github.com/DoomCoder99/vigilant-fiesta
2. Check you have push access
3. Verify remote URL: `git remote -v`

### Issue: "Large file" or "File too large"

**Solution:**
- Check `.gitignore` excludes build files
- Use Git LFS for large assets if needed
- Remove large files from history if already committed

---

## Quick Reference Commands

```bash
# Check status
git status

# Check remote
git remote -v

# View commits
git log --oneline

# Push changes
git push origin main

# Pull changes
git pull origin main

# Create new branch
git checkout -b feature/new-feature

# Push new branch
git push -u origin feature/new-feature
```

---

## Next Steps After Setup

1. **Set up GitHub Actions** for CI/CD (optional)
2. **Add branch protection rules** for `main` branch
3. **Create `.github/` folder** with:
   - `ISSUE_TEMPLATE.md`
   - `PULL_REQUEST_TEMPLATE.md`
   - `CONTRIBUTING.md`
4. **Add collaborators** if working in a team
5. **Set up GitHub Pages** for documentation (if needed)

---

## Security Best Practices

1. ✅ **Never commit secrets** (API keys, passwords, tokens)
2. ✅ **Use `.gitignore`** for sensitive files
3. ✅ **Use environment variables** for configuration
4. ✅ **Review commits** before pushing
5. ✅ **Use Personal Access Tokens** instead of passwords
6. ✅ **Enable 2FA** on GitHub account

---

## Repository Structure on GitHub

After pushing, your repository will have:

```
vigilant-fiesta/
├── .gitignore
├── README.md
├── AGENTS.md
├── pubspec.yaml
├── lib/
├── assets/
├── android/
├── ios/
├── docs/
└── ...
```

---

**Last Updated:** November 2025  
**Repository:** https://github.com/DoomCoder99/vigilant-fiesta

