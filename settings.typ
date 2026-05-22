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
#import "@preview/unify:0.8.0": num, qty, numrange, qtyrange
// カラーボックス
#import "@preview/showybox:2.0.4": showybox
// 定理環境
#import "@preview/theorion:0.3.2": *
#import cosmos.clouds: *
#show: show-theorion
// 図の作成 CeTZ
#import "@preview/cetz:0.5.2"
#import "@preview/cetz-plot:0.1.3": plot, chart
#import "@preview/fletcher:0.5.8" as fletcher: edge, node


#let setup(doc) = {
  // 本文のフォント
  set text(lang: "ja", font: ("New Computer Modern", "BIZ UDMincho"))

  // 本文を両端揃え + 段落冒頭一字下げ
  set par(
    justify: true,
    first-line-indent: (amount: 1em, all: true),
  )

  // ページ番号
  // 本文上の見た目と PDF 内部のページラベルを揃えるため
  // set page(numbering: "--- 1 ---")
  // のようには設定しない．
  set page(numbering: "1")
  set page(
    footer: context align(center)[
      --- #counter(page).display() ---
    ]
  )

  // 見出し番号
  set heading(numbering: "1.")

  // リンク
  show link: set text(fill: blue)

  // タイトル
  show title: set text(font: "Segoe UI")
  show title: set align(center)

  // 見出し
  show heading: it => [
    #set text(font: "Segoe UI")
    #block(it)
  ]

  // 強調
  show strong: set text(
    weight: "bold",
    font: ("New Computer Modern", "BIZ UDGothic"),
  )

  // 引用文
  set quote(block: true)
  show quote: set pad(x: 5em)

  doc
}
