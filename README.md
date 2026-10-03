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

### Visual Studio Code を使用する場合

エディタとして Visual Studio Code を使用すると編集が楽です．
拡張機能として [Tinymist Typst](https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist) を入れておくと，`Ctrl` + `K` `V` でリアルタイムのプレビューを見ることができます．

### フォントについて

OS によらず同じ見た目の PDF が得られるように，このテンプレートでは以下のフォントを使用しています．
各自でフォントをインストールする必要はありません．

| 用途 | フォント | 入手元 |
| --- | --- | --- |
| 本文（欧文） | New Computer Modern | Typst に内蔵 |
| 本文（和文） | BIZ UD明朝（BIZ UDMincho） | `fonts/` に同梱 |
| タイトル・見出し等（欧文・和文） | BIZ UDPゴシック（BIZ UDPGothic） | `fonts/` に同梱 |
| 本文中の太字（和文） | BIZ UDゴシック（BIZ UDGothic） | `fonts/` に同梱 |
| コード（欧文） | DejaVu Sans Mono | Typst に内蔵 |
| コード（和文） | BIZ UDゴシック（BIZ UDGothic） | `fonts/` に同梱 |

BIZ UD フォントはモリサワのユニバーサルデザインフォントです．
同梱しているフォントファイルは [Google Fonts](https://fonts.google.com/specimen/BIZ+UDMincho) で配布されているもので，[SIL Open Font License 1.1](https://openfontlicense.org/) のもとで再配布しています（ライセンス文は `fonts/` 内の各 `OFL.txt` を参照）．
Windows に標準で入っている BIZ UD フォントは使用許諾が異なるため，`fonts/` 内のファイルを置き換えないでください．

#### フォントを読み込むための設定

同梱フォントを Typst に読み込ませる必要があります．
必要な設定は OS ではなく，コンパイルの方法によって異なります．

| コンパイルの方法 | 必要な設定 |
| --- | --- |
| Visual Studio Code + Tinymist | 不要（`.vscode/settings.json` で設定済み） |
| ターミナルで `typst` コマンドを使う（Windows・Mac 共通） | `--font-path fonts` を付ける |

- Visual Studio Code + Tinymist の場合：
  このリポジトリのフォルダ（`main.typ` があるフォルダ）を VS Code で「フォルダーを開く」で開いてください．
  親フォルダを開いた場合や，ファイル単体で開いた場合は `.vscode/settings.json` が読み込まれません．
- ターミナルの場合：
  リポジトリのフォルダで以下のように入力します．

  ```
  # レポートをコンパイル
  typst compile --font-path fonts main.typ

  # 保存するたびに自動でコンパイル
  typst watch --font-path fonts main.typ

  # テンプレートマニュアルをコンパイル
  typst compile --font-path fonts template-manual/template-manual.typ
  ```

  毎回オプションを付けるのが面倒な場合は，環境変数 `TYPST_FONT_PATHS` にこのリポジトリの `fonts` フォルダの絶対パスを設定しておけば `--font-path` を省略できます．

#### フォントが読み込まれているかの確認

以下のコマンドの出力に `BIZ UDMincho`，`BIZ UDPGothic`，`BIZ UDGothic` が含まれていれば正しく読み込まれています．

```
typst fonts --font-path fonts
```

コンパイル時に `unknown font family: biz udmincho` のような警告が出る場合は，フォントが読み込まれていません．
この場合，PDF は別のフォントで作成されてしまうので上記の設定を確認してください．

## リポジトリの構成

```
report_template_Typst/
├── .gitignore                    # Git の追跡対象から除外するファイルを指定
├── .vscode/
│   └── settings.json             # Tinymist で同梱フォントを読み込むための設定
├── LICENSE                       # 本テンプレートのライセンス
├── README.md                     # リポジトリの概要および使用方法
├── bibliography.bib              # 参考文献の BibTeX データベース
├── main.typ                      # レポートのメイン Typst ファイル
├── settings.typ                  # 文書全体の書式および各種設定
│
├── figure/                       # レポートで使用する図
│
├── fonts/                        # 同梱フォント（SIL Open Font License 1.1）
│   ├── BIZUDGothic/              # BIZ UDゴシック
│   ├── BIZUDMincho/              # BIZ UD明朝
│   └── BIZUDPGothic/             # BIZ UDPゴシック
│
└── template-manual/              # テンプレートの使用方法を示したマニュアル
    ├── figure/                   # マニュアルで使用する図
    ├── bibliography.bib          # マニュアル用の参考文献データベース
    ├── settings.typ              # マニュアル用設定ファイル
    ├── template-manual.typ       # マニュアルのメイン Typst ファイル
    └── template-manual.pdf       # コンパイル済みマニュアル
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

## 参考文献

レポート執筆のほか，Typst の使用方法に関して参考になる文献を紹介します．
また，このリポジトリの `template-manual/` のディレクトリには Typst の使い方に関して簡単な説明があります．
テンプレートマニュアルを含め，説明事項の一部は以下の文献と重複する箇所があります． ご了承ください．

- [Typst ドキュメント 日本語版](https://typst-jp.github.io/docs/)
- [Typstの使い方](https://kumaroot.readthedocs.io/ja/latest/typst/typst-usage.html)
- [`tsukahara-lab/TUS-ME_thesis_typst_template`](https://github.com/tsukahara-lab/TUS-ME_thesis_typst_template)
- [`tsukahara-lab/TUS-ME_thesis_template`](https://github.com/tsukahara-lab/TUS-ME_thesis_template)

