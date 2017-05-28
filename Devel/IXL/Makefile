# Ou aller chercher le compilo... Avec un / a la fin
BINDIR=
CAMLC=$(BINDIR)ocamlc
CAMLDEP=$(BINDIR)ocamldep
CAMLLEX=$(BINDIR)ocamllex
CAMLYACC=$(BINDIR)ocamlyacc

# User definitions must be here
EXEC = translate.x
SOURCES =  ixl_t.ml utils_IXL.ml logic.ml main.ml 
GENERATED = parser_IXL.ml lexer_IXL.ml parser_IXL.mli
OBJS = ixl_t.cmo utils_IXL.cmo logic.cmo \
parser_IXL.cmo lexer_IXL.cmo \
main.cmo

# Building the world
all: $(EXEC)

$(EXEC): $(OBJS)
	$(CAMLC) -cclib -lunix $(OBJS) -o $(EXEC) 

.SUFFIXES:
.SUFFIXES: .ml .mli .cmo .cmi .cmx
.SUFFIXES: .mll .mly

.ml.cmo:
	$(CAMLC) -c $<

.mli.cmi:
	$(CAMLC) -c $<

.mll.ml:
	$(CAMLLEX) $<

.mly.ml:
	$(CAMLYACC) $<

# Clean up
clean:
	rm -f *.cm[io] *.cmx *~ .*~ #*# *.o
	rm -f $(GENERATED)
	rm -f $(EXEC)

# Dependencies
depend: $(SOURCES) $(GENERATED) 
	$(CAMLDEP) $(SOURCES) $(GENERATED) > .depend

include .depend
