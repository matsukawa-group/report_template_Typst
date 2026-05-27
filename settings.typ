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
// 単位に関する設定
#import "@preview/unify:0.8.0": num, numrange, qty, qtyrange
// カラーボックス
#import "@preview/showybox:2.0.4": showybox
// 定理環境
#import "@preview/theorion:0.3.2": *
#import cosmos.clouds: *
#show: show-theorion
// 図の作成 CeTZ
#import "@preview/cetz:0.5.2"
#import "@preview/cetz-plot:0.1.3": chart, plot
#import "@preview/fletcher:0.5.8" as fletcher: edge, node

#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *

#let setup(doc) = {
  // 本文のフォント
  set text(lang: "ja", font: ("New Computer Modern", "BIZ UDMincho"))

  set par(
    justify: true, // 両端揃え
    leading: 0.65em, // 行送り
    spacing: 0.65em, // 段落間の間隔
    first-line-indent: (amount: 1em, all: true), // 段落冒頭一字下げ
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
  set heading(numbering: "1.")

  // 見出し
  show heading: it => [
    #set text(font: "Segoe UI")
    #block(it)
  ]
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

  // 数式に関する設定
  set math.equation(
    numbering: "(1)",
    supplement: none,
  )
  show math.equation: set block(
    spacing: 1em,
  )

  // 参照に関する設定
  show ref: it => {
    let eq = math.equation
    let el = it.element
    // Skip all other references.
    if el == none or el.func() != eq { return it }
    // Override equation references.
    link(el.location(), numbering(
      el.numbering,
      ..counter(eq).at(el.location()),
    ))
  }

  // リンク
  show link: set text(fill: blue)

  // 強調
  show strong: set text(
    weight: "bold",
    font: ("New Computer Modern", "BIZ UDGothic"),
  )

  // 引用文
  set quote(block: true)
  show quote: set pad(x: 5em)

  show: codly-init.with()

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

