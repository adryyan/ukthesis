#import "agethesis.typ": *

// Additional options are available (see agethesis.typ)
#show: thesis.with(
  thesis: none, // Choose one of "Bachelor", "Master", "PhD"
  title: "Typst Template for a Bachelor / Master / PhD Thesis in AG Ehresmann",
  author: "Author Name",
  birthplace: "Birthplace",
  date: datetime.today(), // or datetime(year: 2024, month: 04, day: 12)
  supervisor: "Prof. Dr. Supervisor",
  corrector: (Erstgutachter: ("Prof. Dr. Firstcorrector",), Zweitgutachter: ("Prof. Dr. Secondcorrector",)),
  //corrector: (Gutachter: ("Prof. Dr. Erstgutachter", "Prof. Dr. Zweitgutachter"), Prüfer: ("Prof. Dr. Erstprüfer", "Prof. Dr. Zweitprüfer")),
  ukcolor: true, // false for less Uni Kassel red
  BCOR: 12mm, // Adjust binding correction based on page count and binding method
  two-sided: true, // set false for the submitted pdf version
  abstract: "content/00_abstract.typ", // change to none, uncomment or delete to remove the abstract page
  decleration: none, // specify a filepath to a .typ file for a custom decleration
)

// We generated the example code below so you can see how
// your document will look. Go ahead and replace it with
// your own content!

#include "content/01_introduction.typ"
#pagebreak()
#include "content/02_theory.typ"
#pagebreak()
#include "content/03_experiment.typ"
#pagebreak()
#include "content/04_analysis.typ"
#pagebreak()
#include "content/05_conclusion.typ"

// Appendix
#set heading(numbering: "A.1")
#counter(heading).update(0)
#pagebreak()
#include "appendix/a_appendix.typ"

// Bibliography
#pagebreak()
#bibliography("references.bib", style: 	"american-physics-society")

// Acknowledgements
#pagebreak()
#include "appendix/b_acknowledgements.typ"
