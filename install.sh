#!/bin/bash
# ===============================
# Psych Engine HTML5 ビルド & GitHub Pages公開用スクリプト
# ===============================

set -e

echo "=== 1. 必要パッケージインストール ==="
sudo apt update
sudo apt install -y git unzip curl build-essential python3 software-properties-common

echo "=== 2. Haxeインストール ==="
sudo add-apt-repository ppa:haxe/releases -y
sudo apt update
sudo apt install -y haxe
haxelib setup ~/.haxelib

echo "=== 3. Haxelibライブラリ ==="
haxelib install lime
haxelib install openfl
haxelib install flixel
haxelib install flixel-addons
haxelib install flixel-ui
haxelib install hxcpp
haxelib install linc_luajit
haxelib install hxdiscord_rpc
haxelib install hscript

echo "=== 4. PsychEngineソース取得 ==="
if [ ! -d "FNF-PsychEngine" ]; then
  git clone https://github.com/ShadowMario/FNF-PsychEngine.git
fi
cd FNF-PsychEngine

echo "=== 5. HTML5ビルド ==="
lime rebuild extension-webm html5 || true
openfl build html5 -final

echo "=== 6. GitHubリポジトリ作成 (push準備) ==="
cd export/release/html5/bin
if [ ! -d ".git" ]; then
  git init
  git branch -m main
  echo "GitHubのリポジトリURLを入力してください (例: https://github.com/ユーザー名/psychengine-html5.git):"
  read REPO_URL
  git remote add origin "$REPO_URL"
fi

git add .
git commit -m "Psych Engine HTML5 build" || true
git push -u origin main

echo "=== 7. 完了! GitHub Pagesを有効化してURLで遊べます ==="
echo "GitHub Pages URL: https://あなたのユーザー名.github.io/psychengine-html5/"
