// Template for a thesis in AG Ehresmann
// Created by Adrian Krone
#let thesis(
  logo: "logos/uk-logo.png",
  thesis: none,
  title: "Title of the Thesis",
  author: "Author Name",
  birthplace: "Birthplace",
  city: "Kassel",
  date: datetime.today(),
  supervisor: none,
  group: "AG Ehresmann",
  institute: "Institut für Physik und CINSaT \n FB 10 - Mathematik und Naturwissenschaften",
  university: "Universität Kassel",
  corrector: (Erstgutachter: ("Prof. Dr. Firstcorrector",), Zweitgutachter: ("Prof. Dr. Secondcorrector",)),
  ukcolor: false,
  BCOR: 0cm,
  DIV: 10,
  two-sided: true,
  abstract: none,
  decleration: none,
  language: "en",
  body,
) = {
  // Set the document's metadata.
  set document(title: title, author: author, date: date)

  // Uni Kassel Color
  let colors = (main: black)
  if ukcolor {
    colors.insert("main", rgb(199, 16, 92))
  }

  // Translate month to german manually until it becomes natively available
  let monate = ("Januar", "Februar", "März", "April", "Mai", "Juni", "Juli", "August", "September", "Oktober", "November", "Dezember")

  // Save heading and body font families in variables.
  let body-font = "New Computer Modern"
  let sans-font = "New Computer Modern Sans"

  // Page layout
  let div_width = (100% - BCOR) / DIV
  let div_height = 100% / DIV
  let margins = (top: div_height, bottom: 2 * div_height, x: 2 * div_width)
  set page(
    paper: "a4",
    margin: margins,
  )
  if two-sided {
    //margins.remove("x")
    margins.insert("inside", div_width)
    margins.insert("outside", 2 * div_width)
  }
  
  // Title page.
  set text(font: body-font, lang: "de")
  show math.equation: set text(weight: 400)
  
  set align(center)
  v(1fr)

  // Logo
  if logo != none and thesis != "PhD" {
    image(logo, width: 55%)
    v(2fr)
  }
  
  // Bachelor / Master / PhD
  if thesis == "Bachelor" {
    text(16pt)[Arbeit zur Erlangung des akademischen Grades \ Bachelor of Science]
  } else if thesis == "Master" {
    text(16pt)[Arbeit zur Erlangung des akademischen Grades \ Master of Science]
  } else if thesis == "PhD" {
    text(16pt)[Dissertation zur Erlangung des akademischen Grades \ Doktor der Naturwissenschaften (Dr. rer. nat.)]
  } else if thesis == none {
    text(16pt)[Arbeit zur Erlangung des akademischen Grades \ Bachelor / Master / PhD]
  } else {
    text(16pt, thesis)
  }
  v(2fr)

  // Title
  text(font: sans-font, 22pt, weight: 700, fill: colors.main, lang: language, title)
  v(2fr)

  // Author
  text(16pt)[#author \ geboren in #birthplace]
  v(1fr)

  // Date
  text(16pt)[#city, #monate.at(date.month() - 1) #date.year()]
  v(2fr)

  // Supervisor
  if supervisor != none and thesis != "PhD" {
    text(16pt)[Unter Anleitung von #supervisor]
    v(1fr)
  }

  // Affiliation
  text(16pt)[#group \ #institute \ #university]
  

  v(3fr)
  // End of title page

  // Set alignment to left
  set align(left)

  // Set page margins
  set page(
    margin: margins,
    binding: left,
  )

  // Set font size
  set text(11pt)

  // Corrector page
  pagebreak()
  v(1fr)
  let corr = ()
  for (key, arr) in corrector [
    #corr.push(key + ":")
    #for value in arr [
      #corr.push(value)
      #corr.push("")
    ]
    #if arr.len() > 1 {
      corr.push("") 
    } else {
      corr.pop()
    }
  ]
  grid(
    columns: 2,
    rows: corrector.len(),
    row-gutter: 0.5em,
    column-gutter: 0.75em,
    ..corr, text()[Abgabedatum:], text()[#date.day(). #monate.at(date.month() - 1) #date.year()]
  )
  // End of corrector page

  pagebreak()

  // Show page numbers
  set page(
    footer: context [
      #if not two-sided {
        align(center)[#text(fill: colors.main)[#counter(page).display("i")]]
      } else if calc.even(counter(page).get().at(0)) {
        align(left)[#text(fill: colors.main)[#counter(page).display("i")]]
      } else {
        align(right)[#text(fill: colors.main)[#counter(page).display("i")]]
      }
    ],
  )

  // Set the main language
  set text(lang: language)

  // Customize headings
  show heading.where(level: 1): set text(font: sans-font, fill: colors.main)
  set heading(numbering: "1.1")

  if abstract != none {
    include abstract
    pagebreak()
    set text(lang: language) // Set main language again after possibly different language in abstract
  }
  
  // Table of contents.
  show outline.entry.where(level: 1): it => [
    #set text(fill: colors.main, weight: "bold", font: sans-font)
    #v(15pt, weak: true)
    #link(it.element.location())[#it.body #box(width: 1fr, repeat(" ")) #it.page]
  ]
  show outline.entry.where(level: 2): it => [
    #link(it.element.location())[#it.body #box(width: 1fr, repeat(" . .")) #it.page]
  ]
  outline(depth: 2, indent: auto)

  // Start page numbering
  pagebreak()
  set page(
    footer: context [
      #if not two-sided {
        align(center)[#text(fill: colors.main)[#counter(page).display("1")]]
      } else if calc.even(counter(page).get().at(0)) {
        align(left)[#text(fill: colors.main)[#counter(page).display("1")]]
      } else {
        align(right)[#text(fill: colors.main)[#counter(page).display("1")]]
      }
    ],
    header: context {
      set align(center)
      set text(11pt, style: "italic")
      let elems_before = query(heading.where(level: 1).before(here()))
      let elems_after = query(heading.where(level: 1).after(here()))
      if elems_before.len() > 0 and elems_after.first().location().page() != here().page() {
        if not two-sided {
          align(center)[#text(elems_before.last())]
        } else if calc.even(counter(page).get().at(0)) {
          align(left)[#text(elems_before.last())]
        } else {
          align(right)[#text(elems_before.last())]
        }
        v(-7pt)
        line(length: 100%, stroke: 0.5pt + colors.main)
      }
    },
  )
  counter(page).update(1)

  // Main body.
  set par(justify: true)

  body

  // End of main body
  
  pagebreak()
  // Decleration
  if decleration != none {
    include decleration
  } else if thesis == "PhD" {
    heading(numbering: none, outlined: false)[Erklärung zur Arbeit im Einklang mit den Grundsätzen zur guten wissenschaftlichen Praxis]
    linebreak()
    text(lang: "de")[Hiermit versichere ich, dass ich die vorliegende Dissertation selbständig, ohne unerlaubte Hilfe Dritter angefertigt und andere als die in der Dissertation angegebenen Hilfsmittel nicht benutzt habe. Alle Stellen, die wörtlich oder sinngemäß aus veröffentlichten oder unveröffentlichten Schriften entnommen sind, habe ich als solche kenntlich gemacht. Dritte waren an der inhaltlichen Erstellung der Dissertation nicht beteiligt; insbesondere habe ich nicht die Hilfe eines kommerziellen Promotionsberaters in Anspruch genommen. Kein Teil dieser Arbeit ist in einem anderen Promotions- oder Habilitationsverfahren durch mich verwendet worden.]
    linebreak()
    linebreak()
    text(lang: "en")[I herewith give assurance that I completed this dissertation independently without prohibited assistance of third parties or aids other than those identified in this dissertation. All passages that are drawn from published or unpublished writings, either word-for-word or in paraphrase, have been clearly identified as such. Third parties were not involved in the drafting of the content of this dissertation; most specifically I did not employ the assistance of a dissertation advisor. No part of this thesis has been used in another doctoral or tenure process.]
  } else {
    heading(numbering: none, outlined: false)[Eigenständigkeitserklärung]
    linebreak()
    text(lang: "de")[Hiermit bestätige ich, dass ich die vorliegende Arbeit selbständig verfasst und keine anderen als die angegebenen Hilfsmittel benutzt habe. Die Stellen der Arbeit, die dem Wortlaut oder dem Sinn nach anderen Werken (dazu zählen auch Internetquellen) entnommen sind, wurden unter Angabe der Quelle kenntlich gemacht.]
  }
  // End of decleration
}