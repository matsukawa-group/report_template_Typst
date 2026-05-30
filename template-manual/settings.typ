//////////////////////////////////////////////////////////////////
///
///                report_template_Typst
///                    settings.typ
///
//////////////////////////////////////////////////////////////////

// 日本語のダミーテキスト
#import "@preview/roremu:0.1.0": roremu
// 数式を簡単に書くための設定
#import "@preview/physica:0.9.5": *
#let vr(v) = math.bold(math.upright(v)) // ベクトルを直立ボールドで表すコマンドを追加で作成
// 定理環境の設定
#import "@preview/theorion:0.6.0": *
// 図の作成 CeTZ
#import "@preview/cetz:0.5.2"
#import "@preview/cetz-plot:0.1.3": chart, plot
#import "@preview/fletcher:0.5.8" as fletcher: edge, node

#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *

// 単位に関する設定
#import "@preview/fancy-units:0.1.1": *

#let setup(doc) = {
  // CJK 文字を組むときのスペース
  import "@preview/cjk-spacer:0.2.1": cjk-spacer
  show: cjk-spacer

  // 本文のフォント
  set text(lang: "en", font: ("New Computer Modern", "BIZ UDMincho"))

  set par(
    justify: true, // 両端揃え
    leading: 0.65em, // 行送り
    spacing: 0.65em, // 段落間の間隔
    first-line-indent: (amount: 1em, all: false),
  )

  // ページ番号
  // 本文上の見た目と PDF 内部のページラベルを揃えるため
  // set page(numbering: "--- 1 ---")
  // のようには設定しない．
  set page(numbering: "1")
  set page(
    footer: context align(center)[
      --- #counter(page).display() ---
    ],
  )

  // タイトル
  show title: set text(font: "Segoe UI")
  show title: set align(center)

  // 見出し番号
  set heading(
    numbering: "1.",
    supplement: none,
  )

  // 見出し
  show heading: it => {
    set text(font: "Segoe UI")
    it
    par(text(size: 0pt, "")) // 見出しの後に字下げするために空の段落を設定
    v(-1em)
  }
  // 見出しの前後のスペース
  show heading: set block(above: 1.5em, below: 1.5em)

  // 番号なしの箇条書きの設定
  set list(
    indent: 1em,
  )
  show list: set block(
    spacing: 1em,
  )
  // 番号付きの箇条書きの設定
  set enum(
    indent: 1em,
  )
  show enum: set block(
    spacing: 1em,
  )

  // 複数行に亘る数式に関する設定
  import "@preview/equate:0.3.3": equate
  show: equate.with(breakable: true, sub-numbering: false)

  // 数式に関する設定
  set math.equation(
    numbering: (..n) => numbering("(1)", ..n),
    supplement: none,
  )
  show math.equation: set block(
    spacing: 1em,
  )

  // 参照に関する設定
  // show ref: it => {
  //   let eq = math.equation
  //   let el = it.element
  //   // Skip all other references.
  //   if el == none or el.func() != eq { return it }
  //   // Override equation references.
  //   link(el.location(), numbering(
  //     el.numbering,
  //     ..counter(eq).at(el.location()),
  //   ))
  // }

  // リンク
  show link: set text(fill: blue)
  show ref: set text(fill: blue)
  show footnote: set text(fill: blue)

  // 強調
  show strong: set text(
    weight: "bold",
    font: ("New Computer Modern", "BIZ UDGothic"),
  )

  // 引用文
  set quote(block: true)
  show quote: set pad(x: 5em)

  show: codly-init.with()

  // 単位に関する設定
  fancy-units-configure(
    per-mode: "slash",
    unit-separator: sym.dot,
  )
  // 単位のマクロを追加
  add-macros(
    u: sym.mu,
    celsius: [$degree:C$],
    fahrenheit: [$degree:F$]
  )

  doc
}

// 著者情報と日付の表示
#let author(
  authors: (),
  date: none,
  doc,
) = {
  place(
    top + center,
    float: true,
    scope: "parent",
    clearance: 3em,
    {
      title()

      let count = authors.len()
      let ncols = calc.min(count, 2)
      grid(
        columns: (1fr,) * ncols,
        row-gutter: 24pt,
        ..authors.map(author => [
          #author.name \
          #author.affiliation \
          #link("mailto:" + author.email)
        ]),
      )

      if date != none {
        v(1em)
        align(center)[#date]
      }
    },
  )

  doc
}

// showybox の設定
#import "@preview/showybox:2.0.4": showybox as original-showybox
#let showybox(
  title: none,
  ..args,
  body,
) = {
  original-showybox(
    ..args,
    title: if title == none {
      none
    } else {
      text(font: "Segoe UI")[#title]
    },
  )[
    #body
  ]
}

#let bluebox = (
  title-color: rgb("#007bff"),
  border-color: rgb("#007bff"),
  body-color: rgb("#f0f8ff"),
  footer-color: rgb("#f0f8ff"),
)

#let redbox = (
  title-color: rgb("#fc3e3e"),
  border-color: rgb("#fc3e3e"),
  body-color: rgb("#fff0f0"),
  footer-color: rgb("#fff0f0"),
)

#let greenbox = (
  title-color: rgb("#00cc4b"),
  border-color: rgb("#00cc4b"),
  body-color: rgb("#f0fff0"),
  footer-color: rgb("#f0fff0"),
)

#let graybox = (
  title-color: rgb("#666666"),
  border-color: rgb("#666666"),
  body-color: rgb("#F5F5F5"),
  footer-color: rgb("#F5F5F5"),
)
