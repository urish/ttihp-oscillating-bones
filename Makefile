# SPDX-License-Identifier: Apache-2.0
# Author: Uri Shaked

MACRO := tt_um_oscillating_bones
TARGET_GDS := gds/$(MACRO).gds
SOURCE_GDS := gds/$(MACRO).source.gds
TARGET_LEF := lef/$(MACRO).lef
SPICE := spice/$(MACRO).spice

PDK := ihp-sg13g2
MAGIC_RC := $(PDK_ROOT)/$(PDK)/libs.tech/magic/$(PDK).magicrc

all: $(TARGET_GDS) $(TARGET_LEF)
.PHONY: all

$(TARGET_GDS): $(SOURCE_GDS)
	python scripts/make_final_gds.py $< $@

$(TARGET_LEF): $(TARGET_GDS)
	echo "gds read $<; load $(MACRO); select top cell; lef write \"$@\" -pinonly -hide" | magic -rcfile $(MAGIC_RC) -noconsole -dnull

$(SPICE): $(TARGET_GDS)
	magic -rcfile $(MAGIC_RC) -noconsole -dnull scripts/extract_for_sim.tcl $< $@ $(MACRO)

spice/pdk_lib.spice:
	echo ".lib '$(PDK_ROOT)/$(PDK)/libs.tech/ngspice/models/cornerCAP.lib cap_typ' tt" > $@
	echo ".lib '$(PDK_ROOT)/$(PDK)/libs.tech/ngspice/models/cornerMOSlv.lib mos_tt' tt" >> $@
	echo ".include '$(PDK_ROOT)/$(PDK)/libs.ref/sg13g2_stdcell/spice/sg13g2_stdcell.spice'" >> $@

sim: $(SPICE) spice/pdk_lib.spice spice/testbench.spice
	ngspice spice/testbench.spice
.phony: sim drc

docs/layout_sim.svg:
	ngspice -b spice/testbench.spice spice/write_plot.spice

docs/layout_sim.png: docs/layout_sim.svg
	rsvg-convert -f png -o $@ $<

drc: $(TARGET_GDS)
	klayout -b -r $(PWD)/drc/sg13g2_mr.lydrc -rd 'in_gds=$<' -rd density=0
.phony: drc

clean:
	rm -f $(TARGET_GDS) $(SPICE)
.phony: clean
