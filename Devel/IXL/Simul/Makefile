# Ou aller chercher le compilo... Avec un / a la fin
BINDIR=
CAMLC=$(BINDIR)ocamlc
CAMLDEP=$(BINDIR)ocamldep
CAMLLEX=$(BINDIR)ocamllex
CAMLYACC=$(BINDIR)ocamlyacc

# User definitions must be here
EXEC = simul.x
SOURCES =  simul_t.ml utils_simul.ml simulation.ml main.ml 
GENERATED = parser_simul.ml lexer_simul.ml parser_simul.mli
OBJS = simul_t.cmo utils_simul.cmo simulation.cmo \
parser_simul.cmo lexer_simul.cmo \
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
