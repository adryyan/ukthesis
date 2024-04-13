all: build/thesis.pdf
                                                                                
build/thesis.pdf: FORCE | build
	typst compile main.typ build/thesis.pdf
	
FORCE:

build:
	mkdir -p build/

clean:
	rm -rf build