//////////////////////////////////////////////////////////////////
////
////                report_template_Typst
////                 template-manual.typ
////
//////////////////////////////////////////////////////////////////

// 設定ファイル
#import "settings.typ": *

#show: setup

// 複数の図を並べるための設定
#import "@preview/hallon:0.1.3" as hallon: subfigure
#import "@preview/smartaref:0.1.0": Cref, cref
#show: hallon.style-figures
#show figure.where(kind: image): set figure(supplement: "Figure")
#show figure.where(kind: image): set figure.caption(separator: h(1em))
#show figure.where(kind: "subfigure"): set figure(supplement: none, numbering: "a")


// 定理環境の設定
// #import cosmos.simple: *
// #import cosmos.fancy: *
#import cosmos.rainbow: *
// #import cosmos.clouds: *
#show: show-theorion

#set document(title: [
  ここに文書のタイトルを入れます
])
#show: doc => author(
  authors: (
    (
      name: "著者名",
      affiliation: "著者の所属・学年",
      email: "著者のメールアドレス",
    ),
    // (
    //   name: "第二著者",
    //   affiliation: "第二著者の所属・学年",
    //   email: "第二著者のメールアドレス",
    // ),
  ),
  date: [2026 年 5 月 23 日],
  doc,
)

= これは見出し
<sec:heading>

```Typst
= これは見出し
<sec:heading>
```

== これは小見出し
<ssec:subheading>

```Typst
== これは小見出し
<ssec:subheading>
```

=== これはさらに小さい見出し
<sssec:subsubheading>

```Typst
=== これはさらに小さい見出し
<sssec:subsubheading>
```

= Typst 文書の基本的な書き方
<sec:basic>

ここでは Typst 文書の基本的な書き方について説明します．

== コメント文・段落の変え方・強調の仕方
<ssec:paragraph>

// ← これはコメント文にするコマンドです．
// #rorem(xxx) これはダミーテキストです．
#roremu(154)  // ↓ 空白行を入れると改段落されます．

#text(fill: red)[*段落を変えたいときは空白行を入れます．*]  // 強調のために色と太さを変えました．
#roremu(154)

```Typst
// ← これはコメント文にするコマンドです．
// #rorem(xxx) これはダミーテキストです．
#roremu(154)  // ↓ 空白行を入れると改段落されます．

#text(fill: red)[*段落を変えたいときは空白行を入れます．*]  // 強調のために色と太さを変えました．
#roremu(154)
```

== 相互参照
<ssec:reference>

Typst の強みの一つは相互参照が簡単にできることです．
Typst では `<xxx>` のように `<` と `>` で囲まれた部分をラベルとして定義することができます．
例えば，この節は見出しのところで
```Typst
== 相互参照
<ssec:reference>
```
としているので，この見出しを参照したいときは
```Typst
第 @ssec:reference 節
```
とすれば「第 @ssec:reference 節」のように出力できます．
このような相互参照は見出しだけでなく，数式や図表などあらゆる要素に対して行うことができます．
`<` と `>` の間の文字列は自由に設定できるので，ジャンルごとにわかりやすいラベルをつけるといいでしょう#footnote[例：節の場合は `<sec:xxx>`，小節の場合は `<ssec:xxx>`，小々節の場合は `<sssec:xxx>`，式の場合は `<eq:xxx>`，図の場合は `<fig:xxx>`，表の場合は `<tb:xxx>` など，自分のわかりやすいラベルをつけるといいでしょう．ちなみにここに表示しているような脚注は `#footnote[脚注内の文字列]` で出力します．]．

== 強制改ページ
<ssec:pagebreak>

紙面の都合で強制的に改ページしたいときは `#pagebreak()` コマンドを使用します．
例えば，この段落の後で `#pagebreak()` とすれば，この段落の後で改ページされます．

#pagebreak()

== 箇条書き
<ssec:list>

箇条書きには番号なしのものと番号付きのものがあります．

=== 番号なしの箇条書き
<sssec:itemize>

番号なしの箇条書きの例として，明治大学のキャンパスと学部を挙げます．
箇条書きは入れ子にすることもできます．

#v(1em)

#columns(
  2,
  gutter: 2em,
)[
  - 和泉，駿河台キャンパス
    - 法学部
    - 商学部
    - 政治経済学部
    - 文学部
    - 経営学部
    - 情報コミュニケーション学部
  - 生田キャンパス
    - 理工学部
      - 機械工学科
      - 機械情報工学科
    - 農学部
  - 中野キャンパス
    - 国際日本学部
    - 総合数理学部
  #colbreak()
  ```Typst
  - 和泉，駿河台キャンパス
    - 法学部
    - 商学部
    - 政治経済学部
    - 文学部
    - 経営学部
    - 情報コミュニケーション学部
  - 生田キャンパス
    - 理工学部
      - 機械工学科
      - 機械情報工学科
    - 農学部
  - 中野キャンパス
    - 国際日本学部
    - 総合数理学部
  ```
]

=== 番号付きの箇条書き
<sssec:enumerate>

番号付きの箇条書きの例として，日本の苗字ランキングの上位を挙げます．
番号付きの箇条書きも入れ子にすることができます．

#v(1em)

#columns(
  2,
  gutter: 2em,
)[
  1. 佐藤
  2. 鈴木
  3. 高橋
    1. 高橋
    2. 髙橋
  4. 田中
  5. 伊藤
  #colbreak()
  ```Typst
  1. 佐藤
  2. 鈴木
  3. 高橋
    1. 高橋
    2. 髙橋
  4. 田中
  5. 伊藤
  ```
]

== 数式
<ssec:math>

次に，Typst における数式の書き方について説明します．

=== 基本的な数式の書き方
<sssec:math-basic>

Typst で文章中に数式を組み込むインライン数式の場合は，`$` と `$` で表示したい数式を囲って `$E = m c^2$` とすると，$E = m c^2$ のように出力できます．このとき，`$E = mc^2$` のように `m` と `c` の間にスペースを入れず `mc` とすると，`mc` という一つのコマンドとして認識されてしまうため，注意しましょう．
また，インライン数式で表示する場合は `$` と数式の間に空白を入れてはいけません．

最も基本的な別行立ての数式は

$
  pdv(u_r, t) + (vr(u) dot nabla) u_r = - 1/rho pdv(p, r) + nu (nabla^2 u_r - u_r/r^2 - 2/r^2 pdv(u_theta, theta)) #<eq:NSr>
$

```Typst
$
  pdv(u_r, t) + (vr(u) dot nabla) u_r = - 1/rho pdv(p, r) + nu (nabla^2 u_r - u_r/r^2 - 2/r^2 pdv(u_theta, theta)) #<eq:NSr>
$
```
または
```Typst
$ pdv(u_r, t) + (vr(u) dot nabla) u_r = - 1/rho pdv(p, r) + nu (nabla^2 u_r - u_r/r^2 - 2/r^2 pdv(u_theta, theta)) #<eq:NSr> $
```

のように `$` と数式の間に空白を設けることで出力できます．
式 @eq:NSr の数式は Typst でサポートされている最も標準的なコマンドと #link("https://typst.app/universe/package/physica/")[`physica`] パッケージで記述しています．
上付き添え字はキャレット `^`，下付き添え字はアンダースコア `_` を用いて表現します．
したがって，$u_theta^2$ は `u_theta^2` と書きます．
ここで注意点として，添え字が $u_theta^2$ のように一文字であれば問題ないのですが，$R_(i j)$ のように二文字以上の場合は `R_(i j)` のように括弧 `()` で囲んでください．
$rho$ や $theta$ のようなギリシャ文字も出力できるほか，$nabla$ や $sin$，$log$ のような数学で使う関数の類もコマンドが存在します（例：`nabla`，`sin`，`log`）．
$sin$ や $log$ は通常アップライト体（直立体，Roman 体）で書きます．
$s i n x$ などと書くことのないよう気をつけましょう．
分数はスラッシュ `/` を用いて `1/rho` と表現します．
ただし，インライン数式の $1 slash rho$ のようにスラッシュで分数表記したいときは `1 slash rho` としてください．
ベクトルの表記としては矢印を用いて $va(u)$ と表記する方法，イタリックボールド体で $vb(u)$ と表記する方法などがあります．
これらは `physica` パッケージでサポートされているコマンドを使用し，それぞれ `va(u)`，`vb(u)` とすることで出力できます．
式 @eq:NSr の左辺第二項では直立ボールド体の $vr(u)$ を採用していますが，これを簡単に出すコマンドは無いため，このテンプレートで自作したコマンドを使用し `vr(u)` とすることで出力できます．
他のテンプレートでは `vr(u)` と書いても出力できないので注意してください．

=== `physica` パッケージの数式コマンド
<sssec:math-physica>

#link("https://typst.app/universe/package/physica/")[`physica`] パッケージでサポートされている数式コマンドの一部を以下に示します．

#showybox(
  frame: bluebox,
  title: [`physica` パッケージの数式コマンド],
)[
  #align(center)[
    #mytable[
      #table(
        columns: (90mm, 50mm),
        inset: 6pt,
        table.header([コマンド], [出力]),
        [`va(u)`, `vb(u)`, `vu(u)`], $va(u), vb(u), vu(u)$,
        [`dd(x)`, `dd(x, y)`, `dd(x, 2)`, `dd(x, [n])`], $dd(x), dd(x, y), dd(x, 2), dd(x, [n])$,
        [`dv(, x)`, `dv(f, x)`, `dv(f, x, n)`], $display(dv(, x)"," dv(f, x)"," dv(f, x, n))$,
        [`pdv(, x)`, `pdv(f, x)`, `pdv(f, x, y)`, `pdv(f, x, [n])`],
        $display(pdv(, x)"," pdv(f, x)"," pdv(f, x, y)"," pdv(f, x, [n]))$,
        [`dv(, x, d: upright(D))`, `dv(f, x, d: upright(D))`, `dv(f, x, n, d: upright(D))`],
        $display(dv(, x, d: upright(D))"," dv(f, x, d: upright(D))"," dv(f, x, n, d: upright(D)))$,
        table.hline(),
      )
    ]
  ]
]




=== 複数行に亘る数式の書き方
<sssec:math-multiline>

複数の数式を並べる場合は
$
  a^2 & = b^2 + c^2 - 2 b c cos A #<eq:cosA> \
  b^2 & = a^2 + c^2 - 2 c a cos B #<eq:cosB> \
  c^2 & = a^2 + b^2 - 2 a b cos C #<eq:cosC>
$
```Typst
$
  a^2 & = b^2 + c^2 - 2 b c cos A #<eq:cosA>\
  b^2 & = a^2 + c^2 - 2 c a cos B #<eq:cosB>\
  c^2 & = a^2 + b^2 - 2 a b cos C #<eq:cosC>
$
```
のように `&` の位置で数式を揃えることができます．
式 @eq:cosA–@eq:cosC は $=$ の前に `&` を置いているため，$=$ の位置で数式が揃っています．
数式を改行するときは行末にバックスラッシュ `\` を入れます．
また，このやり方を応用すれば
$
  sin 2 alpha & = sin (alpha + alpha) #<equate:revoke> \
              & = sin alpha cos alpha + cos alpha sin alpha #<equate:revoke> \
              & = 2 sin alpha cos alpha #<eq:double-angle>
$
```Typst
$
  sin 2 alpha & = sin (alpha + alpha) #<equate:revoke> \
              & = sin alpha cos alpha + cos alpha sin alpha #<equate:revoke> \
              & = 2 sin alpha cos alpha #<eq:double-angle>
$
```
のように途中式も入れられます．
式番号を振らなくていい行は `#<equate:revoke>` コマンドを使用しています．

場合分けのある数式は `cases` が便利です．式 @eq:kronecker-delta は Kronecker のデルタです．
$
  delta_(i j) = cases(
    1"," quad i = j,
    0"," quad i != j
  )#<eq:kronecker-delta>
$
```Typst
$
  delta_(i j) = cases(
    1"," quad i = j,
    0"," quad i != j
  )#<eq:kronecker-delta>
$
```

=== 単位の書き方
<sssec:math-unit>

数式中の物理量は Italic 体で表記しますが，単位は直立体で表記するのが一般的です．
また，数値と単位の間には空白を設けるのが一般的な書き方です#footnote[例外的に空白を設けなくてもいい単位として，角度を表す $degree$ があります．$45 degree$ のように数値と単位を詰めて書くことが許容されています．ただし，温度を表す $#unit[celsius]$ は空白が必要です（$#qty[45][celsius]$）．ちなみに $degree$ を出力する `degree` コマンド自体は `fancy-units` パッケージのものではありません．]．
これらの要求を満たして簡単に単位を書けるのが #link("https://typst.app/universe/package/fancy-units")[`fancy-units`] パッケージです#footnote[単位の出力に関しては #link("https://typst.app/universe/package/fancy-units")[`fancy-units`] パッケージ以外にも #link("https://typst.app/universe/package/unify/")[`unify`] パッケージがあります．しかし，熱伝達率の単位 $#unit[W / ((m^2 K))]$ のような単位をこの見た目で出力するには `unify` パッケージよりも `fancy-units` パッケージの方が簡単だったので，このレポートテンプレートでは `fancy-units` パッケージを採用しています．単位に関するパッケージはこれからのアップデート次第で，このレポートテンプレートで採用するパッケージも変更する可能性があります．]．
単位のみの出力は `#unit[]` コマンド，数値と単位を併せての出力は `#qty[][]` コマンドを使用します．
`#qty[][]` コマンドを使用すると，数値と単位の間に適切な長さの空白を自動で入れてくれます．

#showybox(
  frame: bluebox,
  title: [`fancy-units` パッケージの単位コマンド],
)[
  #align(center)[
    #mytable[
      #table(
        columns: (90mm, 50mm),
        inset: 6pt,
        table.header([コマンド], [出力]),
        [`#unit[W / ((m^2 K))]`], $#unit[W / ((m^2 K))]$,
        [`#unit(per-mode: "power")[W / (m^2 K)]`], $#unit(per-mode: "power")[W / (m^2 K)]$,
        [`#unit(per-mode: "fraction")[W / (m^2 K)]`], $#unit(per-mode: "fraction")[W / (m^2 K)]$,
        [`#qty[45][W / ((m^2 K))]`], $#qty[45][W / ((m^2 K))]$,
        [`#qty[45][u:m]`], $#qty[45][u:m]$,
        [`45 degree`], $45 degree$,
        [`#qty[45][celsius]`], $#qty[45][celsius]$,
        [`#qty[45][mL]`], $#qty[45][mL]$,
        table.hline(),
      )
    ]
  ]
]

最後に示したミリリットル $#unit[mL]$ には気をつけてください．リットル $#unit[L]$ を昔は ℓ と表記したこともありましたが，「単位は直立体」という原則に合わないのでやめましょう．
また，小文字の $#unit[l]$ だと数字の $1$ と紛らわしいので，人名由来の単位ではありませんがリットルは大文字 $#unit[L]$ で書くようにしましょう．

= 図表の配置
<sec:figure-table>

== 図の配置
<ssec:figure>

=== 一枚の図を配置する方法
<sssec:figure-single>

ここでは図を1枚だけ配置する方法を紹介します．

#figure(
  placement: top,
  image("figure/example-image.pdf", width: 65%),
  caption: [Please write the figure caption here.],
)<fig:one_figure>

```Typst
#figure(
  placement: top,
  image("figure/example-image.pdf", width: 65%),
  caption: [Please write the figure caption here.],
)<fig:one_figure>

図 @fig:one_figure のように図を……
```

図 @fig:one_figure のように図を配置するときは `#figure()` コマンドで図を自動配置し，`#image()` コマンドで画像を挿入します．
図を配置する位置は次のように `placement` オプションで指定します．

- `top`：ページの上部に配置
- `bottom`：ページの下部に配置
- `auto`：`top` と `bottom` のどちらか近い方に配置
- `none`：その位置に配置

論文等の図は基本的にページ上部に配置するので，このテンプレートでは `top` を指定しています．
ただし，最初のページに図を配置したいときは氏名やタイトルよりも上に図があるのは不自然なので，その場合は `bottom` を指定してページ下部に配置するのがいいでしょう．
図の大きさは `#image()` コマンドの `width` オプションで指定できます．
`width: 60%` とすれば，ページ幅の60%の大きさで図を配置できます．
`width: 60mm` のように絶対的な長さで指定することもできます．

また，図も数式と同様に相互参照が可能です．
図を参照したいときは `@fig:one_figure` のように `@` とラベルを組み合わせて参照します．
ハイパーリンクも埋め込まれているので，該当する図が遠く離れた位置にあってもクリックすればすぐに飛べるようになっています．

=== 複数枚の図を配置する方法
<sssec:figure-multiple>

関連する図（ここではそれぞれの図を「サブ図」と呼称します）を複数枚配置するときは `grid` と `subfigure` を使いましょう．
`subfigure` は #link("https://typst.app/universe/package/hallon")[`hallon`] パッケージのコマンドです．
`grid` コマンドでは列数や列間のスペースを指定できます．
`columns: 2` とすれば 2 列のグリッドを作ることができます．
また，`gutter: 2.5mm` とすれば列間のスペースを $#qty[2.5][mm]$ に設定できます．
図 @fig:two_figures は関連する図を左右に二枚配置した例です．
図 @fig:three_figures は関連する図を左右に三枚配置した例で，図 @fig:four_figures は関連する図を $2 times 2$ のグリッドで配置した例です．

#figure(
  placement: top,
  grid(
    columns: 2,
    gutter: 2.5mm,
    subfigure(
      image("figure/example-image-a.pdf", width: 100%),
      caption: [Left figure caption.],
      label: <subfig:two_figures-a>,
    ),
    subfigure(
      image("figure/example-image-b.pdf", width: 100%),
      caption: [Right figure caption.],
      label: <subfig:two_figures-b>,
    ),
  ),
  caption: [Two figures placed side by side.],
) <fig:two_figures>
```Typst
#figure(
  placement: top,
	grid(
		columns: 2,
		gutter: 2.5mm,
		subfigure(
			image("figure/example-image-a.pdf", width: 100%),
			caption: [Left figure caption.],
			label: <subfig:two_figures-a>,
		),
		subfigure(
			image("figure/example-image-b.pdf", width: 100%),
			caption: [Right figure caption.],
			label: <subfig:two_figures-b>,
		),
	),
	caption: [Two figures placed side by side.],
) <fig:two_figures>
```

#figure(
  placement: top,
  grid(
    columns: 3,
    gutter: 2.5mm,
    subfigure(
      image("figure/example-image-a.pdf", width: 100%),
      caption: [Left figure caption.],
      label: <subfig:three_figures-a>,
    ),
    subfigure(
      image("figure/example-image-b.pdf", width: 100%),
      caption: [Center figure caption.],
      label: <subfig:three_figures-b>,
    ),
    subfigure(
      image("figure/example-image-c.pdf", width: 100%),
      caption: [Right figure caption.],
      label: <subfig:three_figures-c>,
    ),
  ),
  caption: [Three figures placed side by side.],
) <fig:three_figures>


#figure(
  placement: top,
  grid(
    columns: 2,
    gutter: 3.5mm,
    subfigure(
      image("figure/example-image-a.pdf", width: 100%),
      caption: [Upper-left figure caption.],
      label: <subfig:four_figures-a>,
    ),
    subfigure(
      image("figure/example-image-b.pdf", width: 100%),
      caption: [Upper-right figure caption.],
      label: <subfig:four_figures-b>,
    ),

    subfigure(
      image("figure/example-image-c.pdf", width: 100%),
      caption: [Lower-left figure caption.],
      label: <subfig:four_figures-c>,
    ),
    subfigure(
      image("figure/example-image.pdf", width: 100%),
      caption: [Lower-right figure caption.],
      label: <subfig:four_figures-d>,
    ),
  ),
  caption: [Four figures placed in a $2 times 2$ grid.],
) <fig:four_figures>

#showybox(
  frame: bluebox,
  title: [図のラベルの参照方法],
)[
  #align(center)[
    #mytable[
      #table(
        columns: (120mm, 30mm),
        inset: 6pt,
        table.header([コマンド], [出力]),
        [`@fig:four_figures`], [@fig:four_figures],
        [`@subfig:four_figures-a`], [@subfig:four_figures-a],
        [`@fig:four_figures@subfig:four_figures-a`], [@fig:four_figures@subfig:four_figures-a],
        [`@fig:four_figures(@subfig:four_figures-a)`], [@fig:four_figures(@subfig:four_figures-a)],
        [`(@subfig:four_figures-a, @subfig:four_figures-b)`], [(@subfig:four_figures-a, @subfig:four_figures-b)],
        [`(@subfig:four_figures-a–@subfig:four_figures-c)`], [(@subfig:four_figures-a–@subfig:four_figures-c)],
        table.hline(),
      )
    ]
  ]
]
#h(1em)
また，`subfigure` を使うことでそれぞれのサブ図にラベルをつけることができます．
参照時には `@fig:four_figures` と入力すると @fig:four_figures のように全体の図を参照できますし，`@subfig:four_figures-a` と入力すると @subfig:four_figures-a のようにサブ図を参照できます．
図 @fig:four_figures(@subfig:four_figures-a) のように全体の図とサブ図を両方参照したいときは `@fig:four_figures(@subfig:four_figures-a)` と入力すれば出力できます．
このとき，`@subfig:four_figures-a` 前後の括弧 `()` を忘れないでください．
括弧をデフォルトで出力するような設定もできますが，図 @fig:four_figures(@subfig:four_figures-a, @subfig:four_figures-b) のように複数のサブ図を参照したいときもあるので，このテンプレートでは括弧は手動で入力する方式にしています．

== 表の配置
<ssec:table>

= 定理環境・かっこいい枠
<sec:theorem>

== 定理環境
<ssec:theorem>

数学や物理の定理や法則を示すための定理環境を #link("https://typst.app/universe/package/theorion/")[`theorion`] パッケージで用意しています．
このレポートテンプレート冒頭で
```Typst
// 定理環境の設定
// #import cosmos.simple: *
// #import cosmos.fancy: *
#import cosmos.rainbow: *
// #import cosmos.clouds: *
#show: show-theorion
```
のように，ここでは `cosmos.rainbow` を適用していますが，自分の好みの定理環境を選んで使用してください．

#theorem[Bernoulli's Theorem][
  $
    1/2 rho v^2 + rho g z + p = "const."
  $
]

また，`theorion` パッケージでは通常の定理環境以外にも，定義（definition）や補題（lemma）などの環境も用意されているので，必要に応じて使用してください．
その他，#link("https://github.blog/changelog/2023-12-14-new-markdown-extension-alerts-provide-distinctive-styling-for-significant-content/")[GitHub で利用できる Markdown 記法のアラートのようなもの] も `theorion` パッケージで用意されています．

#note-block[
  ユーザーがコンテンツをざっと目を通すだけでも知っておくべき有用な情報．
]
```Typst
#note-block[
  ユーザーがコンテンツをざっと目を通すだけでも知っておくべき有用な情報．
]
```

#caution-block[
  特定の行動に伴うリスクや悪影響について注意を促す．
]

#important-block[
  ユーザーが目標を達成するために知っておくべき重要な情報．
]

#warning-block[
  問題を回避するために，ユーザーが直ちに対応すべき緊急の情報．
]

#remark-block[
  補足事項や背景情報，例外事項などを示す．
]

#tip-block[
  物事をより良く，あるいはより簡単に行うための役立つアドバイス．
]

引用文を表示するためのブロックも `theorion` パッケージで用意されています．

#quote-block[
  引用文を表示するためのブロック．
]

== かっこいい枠
<ssec:frame>

定理環境としても使えるかっこいい枠を #link("https://typst.app/universe/package/showybox/")[`showybox`] パッケージで作成できます．
このレポートテンプレートでは枠の色に青・赤・緑・グレーの 4 色を用意しました．

#showybox(
  frame: bluebox,
  title: [青のカラーボックス],
  footer: [フッター部分],
)[
  これは青のカラーボックスの内容です．
][
  これも青のカラーボックスの内容です．
]
```Typst
#showybox(
  frame: bluebox,
  title: [青のカラーボックス],
  footer: [フッター部分]
)[
  これは青のカラーボックスの内容です．
][
  これも青のカラーボックスの内容です．
]
```

#showybox(
  frame: redbox,
  title: [赤のカラーボックス],
  footer: [フッター部分],
)[
  これは赤のカラーボックスの内容です．
][
  これも赤のカラーボックスの内容です．
]

#showybox(
  frame: greenbox,
  title: [緑のカラーボックス],
  footer: [フッター部分],
)[
  これは緑のカラーボックスの内容です．
][
  これも緑のカラーボックスの内容です．
]

#showybox(
  frame: graybox,
  title: [グレーのカラーボックス],
  footer: [フッター部分],
)[
  これはグレーのカラーボックスの内容です．
][
  これもグレーのカラーボックスの内容です．
]




