VARIANT ?= cuda_ad_rgb
SAMPLES_PER_PIXEL ?= 2048

GDS_LAYERS = diff li1 licon mcon met1 met2 met3 met4 nwell poly substrate via via2 via3 
GDS_FILE = ../gds/tt_um_oscillating_bones.gds
OBJ_FILES = $(foreach layer,$(GDS_LAYERS),../gds/tt_um_oscillating_bones.gds_$(layer).obj)
FINAL_IMAGE = oscillating_bones_${SAMPLES_PER_PIXEL}.png

all: $(FINAL_IMAGE)
.PHONY: all

$(FINAL_IMAGE): $(OBJ_FILES)
	python ./render_3d.py -v $(VARIANT) -s $(SAMPLES_PER_PIXEL) -o $(FINAL_IMAGE)

$(OBJ_FILES): ../gds/tt_um_oscillating_bones.gds
	python gds2obj.py $<

clean:
	rm -f $(OBJ_FILES) $(FINAL_IMAGE)
.PHONY: clean

