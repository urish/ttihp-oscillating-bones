# SPDX-License-Identifier: Apache-2.0
# Author: Uri Shaked

PROJECT=tt_um_oscillating_bones

all: gds/$(PROJECT).gds lef/$(PROJECT).lef

gds/$(PROJECT).gds: mag/$(PROJECT).mag
	echo "select top cell; gds write \"$@\"" | magic -rcfile $(PDK_ROOT)/sky130A/libs.tech/magic/sky130A.magicrc -noconsole -dnull $<

lef/$(PROJECT).lef: mag/$(PROJECT).mag
	echo "select top cell; lef write \"$@\" -pinonly" | magic -rcfile $(PDK_ROOT)/sky130A/libs.tech/magic/sky130A.magicrc -noconsole -dnull $<

clean:
	rm -f gds/$(PROJECT).gds lef/$(PROJECT).lef
.PHONY: clean
