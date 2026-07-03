//////////////////////////////////////////////////////////////////
////
////                report_template_Typst
////                    settings.typ
////
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
  set math.cases(gap: 1em)

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
    fahrenheit: [$degree:F$],
  )

  // 図とキャプションの間のスペースを設定
  set figure(gap: 1em)
  // 参照時に図・表は番号だけ表示
  show ref: it => {
    let el = it.element

    if el != none and el.func() == figure {
      let loc = el.location()

      if el.kind == image {
        link(loc)[#numbering(
          el.numbering,
          ..counter(figure.where(kind: image)).at(loc),
        )]
      } else if el.kind == table {
        link(loc)[#numbering(
          el.numbering,
          ..counter(figure.where(kind: table)).at(loc),
        )]
      } else {
        it
      }
    } else {
      it
    }
  }

  doc
}

// 表紙・著者情報と日付の表示
#let author(
  authors: (),
  date: none,
  cover: false,
  doc,
) = {
  if cover {
    // 表紙あり
    page(
      numbering: "i",
      footer: none,
    )[
      #align(center + horizon)[
        #line(length: 100%, stroke: 2pt + rgb("#1f4e79"))
        #v(-0.2em)
        #line(length: 100%, stroke: 1pt + rgb("#1f4e79"))
        #v(0.3em)
        #title()
        #v(1em)
        #line(length: 100%, stroke: 1pt + rgb("#1f4e79"))
        #v(-0.2em)
        #line(length: 100%, stroke: 2pt + rgb("#1f4e79"))

        #v(10em)

        #let count = authors.len()
        #let ncols = calc.min(count, 2)

        #grid(
          columns: (1fr,) * ncols,
          row-gutter: 24pt,
          column-gutter: 36pt,
          ..authors.map(author => [
            #text(14pt, weight: "bold")[#author.name] \
            #v(0.5em)
            #author.affiliation \
            #v(0.5em)
            #link("mailto:" + author.email)
          ]),
        )

        #if date != none {
          v(15em)
          text(12pt)[#date]
        }
      ]
    ]
    counter(page).update(1)

    pagebreak()
    doc
  } else {
    // 表紙なし：従来通り
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
}

#let mytable(body) = {
  set table(
    stroke: (x, y) => (
      if y == 0 {
        (top: black)
        (bottom: black)
      }
        + if x == 0 {
          (right: black)
        }
    ),
    align: (x, y) => center,
    fill: (x, y) => {
      if y == 0 {
        none
      } else if calc.odd(y) {
        rgb("F7FBFD")
      } else {
        rgb("E6F2F7")
      }
    },
  )

  body
}

#let mytable2(body) = {
  set table(
    stroke: (x, y) => (
      if y == 0 {
        (top: black)
      }
        + if x == 0 {
          (right: black)
        }
    ),
    align: (x, y) => center,
    fill: (x, y) => {
      if calc.odd(y) {
        rgb("F7FBFD")
      } else {
        rgb("E6F2F7")
      }
    },
  )

  body
}

//========== 参考文献の設定 ============
#import "@preview/enja-bib:0.1.0": *
#import bib-setting-plain: *

#let doi-link(biblist, name) = {
  let doi = biblist.at(name).sum()
  link("https://doi.org/" + doi)[#raw(doi)]
}

#let url-link-if-no-doi(biblist, name) = {
  if biblist.at("doi", default: ()).len() == 0 {
    let url = biblist.at(name).sum()
    [URL: <#link(url)[#raw(url)]>]
  } else {
    []
  }
}

#let arxiv-link(biblist, name) = {
  let eprint = biblist.at(name).sum()
  [arXiv:#h(0.3em)#link("https://arxiv.org/abs/" + eprint)[#raw(eprint)]]
}

#let bibtex-article-en = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "\"", title-en, ",\"", " ", (), ".")),
  ("journal", (none, "", all-emph, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","journal", "volume", "number"), "%year-doubling).")),
  ("volume", (none, "", all-bold, "", "", (), ".")),
  ("number", (none, "(", all-return, ")", "", (), ").")),
  ("pages", (none, ", ", page-set-without-p, ", ", "", (), ".")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-article-ja = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "「", all-return, "」, ", " ", (), ".")),
  ("journal", (none, "", all-return, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","journal", "volume", "number"), "%year-doubling).")),
  ("volume", (none, "", all-bold, "", "", (), ".")),
  ("number", (none, "(", all-return, ")", "", (), ").")),
  ("pages", (none, ", ", page-set-without-p, ", ", "", (), ".")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-book-en = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "\"", title-en, ",\"", " ", (), ".")),
  ("publisher", (none, "", all-emph, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","publisher"), "%year-doubling).")),
  ("volume", (none, "", all-bold, "", "", (), ".")),
  ("number", (none, "(", all-return, ")", "", (), ").")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-book-ja = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "「", all-return, "」, ", " ", (), ".")),
  ("publisher", (none, "", all-return, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","publisher"), "%year-doubling).")),
  ("volume", (none, "", all-bold, "", "", (), ".")),
  ("number", (none, "(", all-return, ")", "", (), ").")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-booklet-en = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "\"", title-en, ",\"", " ", (), ".")),
  ("howpublished", (none, "", all-emph, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","howpublished"), "%year-doubling).")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-booklet-ja = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "「", all-return, "」, ", " ", (), ".")),
  ("howpublished", (none, "", all-return, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","howpublished"), "%year-doubling).")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-conference-en = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "\"", title-en, ",\"", " ", (), ".")),
  ("booktitle", (none, "", all-emph, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","booktitle"), "%year-doubling).")),
  ("pages", (none, ", ", page-set-without-p, "", ", ", (), ".")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-conference-ja = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "「", all-return, "」, ", " ", (), ".")),
  ("booktitle", (none, "", all-return, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","booktitle"), "%year-doubling).")),
  ("pages", (none, ", ", page-set-without-p, "", ", ", (), ".")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-inbook-en = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "\"", title-en, ",\"", " ", (), ".")),
  ("publisher", (none, "", all-emph, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","publisher"), "%year-doubling).")),
  ("volume", (none, "", all-bold, "", "", (), ".")),
  ("pages", (none, "", page-set-without-p, "", ", ", (), ".")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-inbook-ja = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "「", all-return, "」, ", " ", (), ".")),
  ("publisher", (none, "", all-return, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","publisher"), "%year-doubling).")),
  ("volume", (none, "", all-bold, "", "", (), ".")),
  ("pages", (none, "", page-set-without-p, "", ", ", (), ".")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-incollection-en = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "\"", title-en, ",\"", " ", (), ".")),
  ("booktitle", (none, "", all-emph, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","booktitle"), "%year-doubling).")),
  ("pages", (none, "", page-set-without-p, "", ", ", (), ".")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-incollection-ja = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "「", all-return, "」, ", " ", (), ".")),
  ("booktitle", (none, "", all-return, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","booktitle"), "%year-doubling).")),
  ("pages", (none, "", page-set-without-p, "", ", ", (), ".")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-inproceedings-en = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "\"", title-en, ",\"", " ", (), ".")),
  ("booktitle", (none, "", all-emph, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","booktitle"), "%year-doubling).")),
  ("pages", (none, "", page-set-without-p, "", ", ", (), ".")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-inproceedings-ja = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "「", all-return, "」, ", " ", (), ".")),
  ("booktitle", (none, "", all-return, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","booktitle"), "%year-doubling).")),
  ("pages", (none, "", page-set-without-p, "", ", ", (), ".")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-manual-en = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "\"", title-en, "\"", " ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title"), "%year-doubling).")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-manual-ja = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "「", all-return, "」", " ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title"), "%year-doubling).")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),  
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-mastersthesis-en = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "\"", title-en, ",\"", " ", (), ".")),
  ("school", (none, "_Master's Thesis_, ", all-emph, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","school"), "%year-doubling).")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-mastersthesis-ja = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "「", all-return, "」, ", " ", (), ".")),
  ("school", (none, "", all-return, "修士論文", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","school"), "%year-doubling).")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-misc-en = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "\"", title-en, ",\"", " ", (), ".")),
  ("howpublished", (none, "", all-emph, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","howpublished"), "%year-doubling).")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("eprint", (none, "", arxiv-link, "", ", ", (), ".")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-misc-ja = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "「", all-return, "」, ", " ", (), ".")),
  ("howpublished", (none, "", all-return, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","howpublished"), "%year-doubling).")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("eprint", (none, "", arxiv-link, "", ", ", (), ".")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-online-en = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "\"", title-en, ",\"", " ", (), ".")),
  ("howpublished", (none, "", all-emph, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","howpublished"), "%year-doubling).")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
  ("access", (none, "(accessed on: ", all-return, ")", ", ", (), ").")),
)

#let bibtex-online-ja = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "「", all-return, "」, ", " ", (), ".")),
  ("howpublished", (none, "", all-return, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","howpublished"), "%year-doubling).")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
  ("access", (none, "(accessed on: ", all-return, ")", ", ", (), ").")),
)


#let bibtex-phdthesis-en = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "\"", title-en, ",\"", " ", (), ".")),
  ("school", (none, "_Ph.D. Dissertation_, ", all-emph, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","school"), "%year-doubling).")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-phdthesis-ja = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "「", all-return, "」, ", " ", (), ".")),
  ("school", (none, "", all-return, "博士論文", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","school"), "%year-doubling).")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-proceedings-en = (
  ("editor", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "\"", title-en, ",\"", " ", (), ".")),
  ("publisher", (none, "", all-emph, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("editor","title","publisher"), "%year-doubling).")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-proceedings-ja = (
  ("editor", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "「", all-return, "」, ", " ", (), ".")),
  ("publisher", (none, "", all-return, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("editor","title","publisher"), "%year-doubling).")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-techreport-en = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "\"", title-en, ",\"", " ", (), ".")),
  ("institution", (none, "", all-emph, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","institution"), "%year-doubling).")),
  ("number", (none, "(", all-return, "), ", "", (), ").")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-techreport-ja = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "「", all-return, "」, ", " ", (), ".")),
  ("institution", (none, "", all-return, "", ", ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title","institution"), "%year-doubling).")),
  ("number", (none, "(", all-return, "), ", "", (), ").")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-unpublished-en = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "\"", title-en, "\"", " ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title"), "%year-doubling).")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let bibtex-unpublished-ja = (
  ("author", (none, "", author-set, "", ", ", (), ".")),
  ("title", (none, "「", all-return, "」", " ", (), ".")),
  ("year", (" ","(",all-return, "%year-doubling)", ", ", ("author","title"), "%year-doubling).")),
  ("note", (none, " (", all-return, "), ", "", (), ").")),
  ("doi", (none, "DOI: ", doi-link, "", "", (), ".")),
  ("url", (none, "", url-link-if-no-doi, "", ", ", (), ".")),
)

#let my-bib-style = (
  bibtex-article-en: bibtex-article-en,
  bibtex-article-ja: bibtex-article-ja,
  bibtex-book-en: bibtex-book-en,
  bibtex-book-ja: bibtex-book-ja,
  bibtex-booklet-en: bibtex-booklet-en,
  bibtex-booklet-ja: bibtex-booklet-ja,
  bibtex-conference-en: bibtex-conference-en,
  bibtex-conference-ja: bibtex-conference-ja,
  bibtex-inbook-en: bibtex-inbook-en,
  bibtex-inbook-ja: bibtex-inbook-ja,
  bibtex-incollection-en: bibtex-incollection-en,
  bibtex-incollection-ja: bibtex-incollection-ja,
  bibtex-inproceedings-en: bibtex-inproceedings-en,
  bibtex-inproceedings-ja: bibtex-inproceedings-ja,
  bibtex-manual-en: bibtex-manual-en,
  bibtex-manual-ja: bibtex-manual-ja,
  bibtex-mastersthesis-en: bibtex-mastersthesis-en,
  bibtex-mastersthesis-ja: bibtex-mastersthesis-ja,
  bibtex-misc-en: bibtex-misc-en,
  bibtex-misc-ja: bibtex-misc-ja,
  bibtex-online-en: bibtex-online-en,
  bibtex-online-ja: bibtex-online-ja,
  bibtex-phdthesis-en: bibtex-phdthesis-en,
  bibtex-phdthesis-ja: bibtex-phdthesis-ja,
  bibtex-proceedings-en: bibtex-proceedings-en,
  bibtex-proceedings-ja: bibtex-proceedings-ja,
  bibtex-techreport-en: bibtex-techreport-en,
  bibtex-techreport-ja: bibtex-techreport-ja,
  bibtex-unpublished-en: bibtex-unpublished-en,
  bibtex-unpublished-ja: bibtex-unpublished-ja,
)
//=====================================


//========== showybox の設定 ============
#import "@preview/showybox:2.0.4": showybox as original-showybox
#let showybox(
  title: none,
  ..args,
  body,
) = {
  let title-arg = if title == none {
    (:)
  } else {
    (title: text(font: "Segoe UI")[#title])
  }

  original-showybox(
    ..args,
    ..title-arg,
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
//=======================================
