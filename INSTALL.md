# gh-yocto - GitHub CLI Extension for Yocto Development

Yoctoビルド用の軽快なIDE環境を提供するGitHub CLI拡張

## 特徴

- 🚀 Ubuntu 24.04ベースのYoctoビルド環境
- 📝 Neovim統合（vim/viシンボリックリンク対応）
- 🐳 Dockerコンテナで隔離された開発環境
- 🔧 一般ユーザー権限での開発
- 💾 ホストディレクトリの自動マウント
- ⚙️  .envファイルでカスタマイズ可能

## インストール

### 前提条件

- GitHub CLI (`gh`) がインストールされていること
- Docker と Docker Compose がインストールされていること

### インストール方法

```bash
gh extension install kouji-sasaya/gh-yocto
```

または、ローカルでインストールする場合：

```bash
# リポジトリをクローン
git clone https://github.com/kouji-sasaya/gh-yocto.git
cd gh-yocto

# ローカルインストール
gh extension install .
```

## 使い方

### 1. 開発環境のビルド

```bash
gh yocto setup
```

初回実行時にDockerイメージをビルドします。イメージ名はデフォルトで `$(id -un)/yocto:local` になります。

### 2. コンテナシェルに入る

```bash
gh yocto shell
```

カレントディレクトリが `/workdir` にマウントされた状態でコンテナシェルに入ります。

### 3. Neovimでの開発

コンテナ内で `nvim`、`vim`、または `vi` コマンドが使用できます（すべてNeovimにリンクされています）。

```bash
# コンテナ内で
nvim myfile.bb
vim myrecipe.bb
vi myconfig.conf
```

## カスタマイズ

`.env` ファイルを作成して設定をカスタマイズできます：

```bash
# .env.example をコピーして編集
cp .env.example .env
```

利用可能な環境変数：

- `DOCKER_IMAGE_NAME`: Dockerイメージ名（デフォルト: `$(id -un)/yocto:local`）
- `USERNAME`: コンテナ内のユーザー名（デフォルト: `yocto`）

`USER_UID` / `USER_GID` は `gh-yocto` 実行時にホストから自動判別されます（`id -u` / `id -g`）。

## プロジェクト構成

```
gh-yocto/
├── gh-yocto           # メイン実行スクリプト
├── Dockerfile         # Ubuntu 24.04ベースのコンテナ定義
├── docker-compose.yml # Docker Compose設定
├── .env.example       # 環境変数のサンプル
└── README.md          # このファイル
```

## インストール済みパッケージ

Dockerイメージには以下が含まれています：

- Yoctoビルドに必要なすべての依存パッケージ
- Neovim（最新版）
- Python 3
- Git
- その他の開発ツール

## トラブルシューティング

### イメージが見つからない

```bash
Error: Docker image 'xxx/yocto:local' not found.
```

→ `gh yocto setup` を実行してイメージをビルドしてください。

### 権限エラー

`gh-yocto` はホストのUID/GIDを自動で利用します。通常は追加設定不要です。

## ライセンス

MIT License

## 開発要件（実装済み）

- ✅ Yoctoビルドの軽快なIDE環境
- ✅ 一般ユーザーでの開発
- ✅ Ubuntu 24.04
- ✅ docker-compose.yml + Dockerfile
- ✅ gh extension としての実装
- ✅ `gh yocto setup` コマンド
- ✅ `gh yocto shell` コマンド
- ✅ Neovimインストール
- ✅ vim → nvim シンボリックリンク
- ✅ vi → nvim シンボリックリンク
- ✅ SSH環境での軽快なIDE
- ✅ ${PWD}:/workdir ボリュームマウント
- ✅ FROM Ubuntu 24.04
- ✅ Yoctoコマンドのapt-getインストール
- ✅ イメージ名: $(id -un)/yocto:local
- ✅ .envでのカスタマイズ
