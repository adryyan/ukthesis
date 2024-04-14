# AGEThesis for Typst

Typst template for a thesis written in the AGE.

The template is build for use with _lualatex_ and _biblatex_ with _biber_,
the class file can be used with the LaTeX engine of your choice, it is completely independent.

All used packages and commands are explained
in depth in the materials of the PeP et al. LaTeX Workshop:

http://toolbox.pep-dortmund.de/notes.html


# Compiliation

Use the [collaborative online editor](https://typst.app/).

If you really want to work locally follow the installation instructions [here](https://github.com/typst/typst) and compile with

    typst compile main.typ

or use the Makefile

    make

or execute

    typst watch file.typ

for Typst to recompile on changes.
