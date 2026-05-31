# report_template_Typst

Typst で簡単なレポートを書く際のテンプレートです．ご自由にお使いください．

## Typst について

### Typst の環境構築

ターミナル上で以下のように入力する．

Windows の場合：

```
winget install --id Typst.Typst
```

Mac の場合：

```
brew install typst
```

### Typst のアップデート

ターミナル上で以下のように入力する．

```
typst update
```

## このレポートテンプレートの使用方法

### レポートリポジトリの作成

各自の Git/GitHub で管理することを前提に説明します．

1. Organization ではなく個人の GitHub アカウントに空のリポジトリを作成．ここでは仮に `report_physics` というリポジトリ名にする．リポジトリ作成時に `README.md` や `.gitignore` は作成しない．
2. Private になっていることを確認したら `Create repository` を押す．
3. このテンプレートのリポジトリをローカルにクローンする．

例えば `@Yuki-MATSUKAWA` がレポートを執筆する場合：

```
# ローカルにテンプレートをクローン
git clone https://github.com/matsukawa-group/report_template_Typst report_physics
cd report_physics

# リモート URL を自身のものに変更
git remote set-url origin https://github.com/Yuki-MATSUKAWA/report_physics

# URL の変更が反映されているか確認
git remote -v

# 自身のリモートリポジトリにテンプレートの中身を反映
git push origin HEAD
```

これでテンプレートの中身が自身のレポートリポジトリに反映されたので自由に編集して大丈夫です．

### テンプレートへの修正の反映

このレポートテンプレートが更新された場合は，以下のコマンドを実行して自身のリポジトリに反映してください．

```
# このレポートテンプレートのリポジトリを登録
git remote add upstream https://github.com/matsukawa-group/report_template_Typst.git

# テンプレートの最新状態を取得
git fetch upstream

# 自分が main ブランチにいることを確認し，テンプレートの最新状態をマージ
git switch main && git merge upstream/main

# 自身のリモートリポジトリを更新
git push origin HEAD
```
