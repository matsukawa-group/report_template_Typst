//////////////////////////////////////////////////////////////////
///
///                report_template_Typst
///                    settings.typ
///
//////////////////////////////////////////////////////////////////

// 単位に関する設定
#import "@preview/unify:0.8.0": num, qty, numrange, qtyrange
// 日本語のダミーテキスト
#import "@preview/roremu:0.1.0": roremu

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
