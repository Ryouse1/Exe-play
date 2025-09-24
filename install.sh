#!/bin/bash
# ===============================================
# Psych Engine の .exe ファイルを GitHub にアップロードするスクリプト
# （ブラウザ実行ではなくダウンロード用）
# ===============================================

set -e

echo "=== 1. GitHubリポジトリ準備 ==="
if [ ! -f *.exe ]; then
  echo "このディレクトリにPsychEngineの.exeファイルを置いてください"
  exit 1
fi

if [ ! -d ".git" ]; then
  git init
  git branch -m main
  echo "GitHubのリポジトリURLを入力してください (例: https://github.com/ユーザー名/psychengine-exe.git):"
  read REPO_URL
  git remote add origin "$REPO_URL"
fi

echo "=== 2. exeファイルを追加してコミット ==="
git add *.exe
git commit -m "Add Psych Engine Windows exe" || true

echo "=== 3. GitHubへpush ==="
git push -u origin main

echo "=== 4. 完了！GitHubでexeが配布用リンクとして公開されます ==="
echo "→ GitHubページかReleaseにexeを置けば、他の人がダウンロードできます"
