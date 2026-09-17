


# gh-yocto

Yoctoビルド用の軽快なIDE環境を提供するGitHub CLI拡張

## 概要

gh-yoctoは、Yoctoプロジェクトの開発を快適に行うためのDockerベースの開発環境です。

Neovimを統合し、SSH環境でも軽快に動作するIDE環境を提供します。


## 特徴

✅ Yoctoビルドの軽快なIDE環境  
✅ 一般ユーザーで開発  
✅ Ubuntu 24.04ベース  
✅ docker-compose.yml + Dockerfileで構成  
✅ GitHub CLI拡張として実装  
✅ `gh yocto setup` でDockerコンテナをビルド  
✅ `gh yocto shell` でDockerコンテナに入る  
✅ Neovimインストール済み  
✅ vim/viはnvimへのシンボリックリンク  
✅ SSH環境での軽快なIDE（VSCodeは重すぎる問題を解決）  
✅ ${PWD}:/workdirでボリュームマウント  
✅ Yoctoビルドに必要なコマンドをDockerfileでインストール  
✅ イメージ名: $(id -un)/yocto:local  
✅ .envファイルでカスタマイズ可能  

## インストール

### 前提条件

- GitHub CLI (`gh`)
- Docker & Docker Compose

### インストール方法

```bash
gh extension install kouji-sasaya/gh-yocto
```

ローカルインストールの場合：

```bash
git clone https://github.com/kouji-sasaya/gh-yocto.git
cd gh-yocto
gh extension install .
```

## 使い方

### 開発環境のビルド

```bash
gh yocto setup
```

### コンテナシェルに入る

```bash
gh yocto shell
```

カレントディレクトリが `/workdir` にマウントされます。

### Neovimでの開発

コンテナ内で `nvim`、`vim`、`vi` が使用可能です：

```bash
nvim recipe.bb
vim config.conf
vi notes.txt
```

## カスタマイズ

`.env` ファイルで設定をカスタマイズできます：

```bash
cp .env.example .env
# .envを編集
```

設定可能な環境変数：

- `DOCKER_IMAGE_NAME` - Dockerイメージ名（デフォルト: `$(id -un)/yocto:local`）
- `USERNAME` - コンテナ内のユーザー名（デフォルト: `yocto`）

`USER_UID` / `USER_GID` は `gh-yocto` 実行時にホストから自動判別されます（`id -u` / `id -g`）。

## プロジェクト構成

```
gh-yocto/
├── gh-yocto           # メイン実行スクリプト
├── Dockerfile         # Ubuntu 24.04ベースのコンテナ定義
├── docker-compose.yml # Docker Compose設定
├── .env.example       # 環境変数のサンプル
├── README.md          # このファイル
└── INSTALL.md         # 詳細なインストール・使用方法
```

## 詳細ドキュメント

詳細な使用方法やトラブルシューティングは [INSTALL.md](INSTALL.md) を参照してください。

## ライセンス

MIT License





