OUT=output/

#INTP = $(shell ls *.py *.pl *.r *.js)
#COMP = $(shell ls *.c *.java)

INTP_DAT = $(shell ls $(shell ls *.py *.pl *.r *.js) | awk -F 'nothing-really' '{print "$(OUT)" $$1 ".dat"}')
COMP_DAT = $(shell ls $(shell ls *.c *.java) | awk -F 'nothing-really' '{print "$(OUT)" $$1 ".dat"}')

all: $(INTP_DAT) $(COMP_DAT)

$(OUT)%.c.dat: %.run
		@rm -f $@
		$(shell dirname $<)/$< > $@

%.run: %.c
		@rm -f $@
		cc -O3 -o $@ $<

$(OUT)%.java.dat: %.class
		@rm -f $@
		java $(shell basename $< .class) > $@

%.class: %.java
		@rm -f $@
		javac $<

$(OUT)%.py.dat : %.py
		@rm -f $@
		$(shell dirname $<)/$< > $@

$(OUT)%.pl.dat : %.pl
		@rm -f $@
		$(shell dirname $<)/$< > $@

$(OUT)%.r.dat : %.r
		@rm -f $@
		$(shell dirname $<)/$< > $@

$(OUT)%.js.dat : %.js
		@rm -f $@
		$(shell dirname $<)/$< > $@

