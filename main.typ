//////////////////////////////////////////////////////////////////
///
///                report_template_Typst
///                       main.typ
///
//////////////////////////////////////////////////////////////////

// 設定ファイル
#import "settings.typ": *

#show: setup

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
  doc,
)

= これは見出し

#lorem(100)

== これは小見出し

#roremu(295)

#lorem(100)

