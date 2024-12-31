v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
B 2 610 -600 1410 -200 {flags=graph
y1=-0.37667006
y2=2.8083796
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0
x2=2e-07
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0


dataset=-1
unitx=1
logx=0
logy=0
rainbow=0

color="4 17 21 10"
node="osc_out
osc_div_2
osc_div_4
osc_div_8"}
T {tcleval(osc_freq=[concat [ev [xschem raw value osc_freq_mhz 0]] " MHz"])} 610 -690 0 0 0.4 0.4 {floater=1}
T {tcleval(osc_div_2_freq=[concat [ev [xschem raw value osc_div_2_freq_mhz 0]] " MHz"])} 610 -660 0 0 0.4 0.4 {floater=1}
T {tcleval(osc_div_4_freq=[concat [ev [xschem raw value osc_div_4_freq_mhz 0]] " MHz"])} 1110 -690 0 0 0.4 0.4 {floater=1}
T {tcleval(osc_div_8_freq=[concat [ev [xschem raw value osc_div_8_freq_mhz 0]] " MHz"])} 1110 -660 0 0 0.4 0.4 {floater=1}
N 380 -540 380 -530 {lab=osc_out}
N 380 -540 480 -540 {lab=osc_out}
N 480 -540 480 -530 {lab=osc_out}
N 380 -520 380 -510 {lab=osc_div_2}
N 380 -520 480 -520 {lab=osc_div_2}
N 480 -520 480 -510 {lab=osc_div_2}
N 380 -500 380 -490 {lab=osc_div_4}
N 380 -500 480 -500 {lab=osc_div_4}
N 480 -500 480 -490 {lab=osc_div_4}
N 380 -480 380 -470 {lab=osc_div_8}
N 380 -480 480 -480 {lab=osc_div_8}
N 480 -480 480 -470 {lab=osc_div_8}
N 580 -470 580 -450 {lab=VGND}
N 580 -490 580 -470 {lab=VGND}
N 580 -510 580 -490 {lab=VGND}
N 580 -530 580 -510 {lab=VGND}
N 580 -450 580 -420 {lab=VGND}
N 350 -530 380 -530 {lab=osc_out}
N 350 -510 380 -510 {lab=osc_div_2}
N 350 -490 380 -490 {lab=osc_div_4}
N 350 -470 380 -470 {lab=osc_div_8}
N 480 -470 500 -470 {lab=osc_div_8}
N 480 -490 500 -490 {lab=osc_div_4}
N 480 -510 500 -510 {lab=osc_div_2}
N 480 -530 500 -530 {lab=osc_out}
N 340 -300 400 -300 {lab=VGND}
N 380 -460 380 -450 {lab=osc_out_3v3}
N 380 -460 480 -460 {lab=osc_out_3v3}
N 350 -450 380 -450 {lab=osc_out_3v3}
N 500 -530 520 -530 {lab=osc_out}
N 500 -510 520 -510 {lab=osc_div_2}
N 500 -490 520 -490 {lab=osc_div_4}
N 500 -470 520 -470 {lab=osc_div_8}
N 500 -450 520 -450 {lab=osc_out_3v3}
N 480 -460 500 -460 {lab=osc_out_3v3}
N 500 -460 500 -450 {lab=osc_out_3v3}
C {devices/code.sym} 90 -220 0 0 {name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value="
** opencircuitdesign pdks install
.lib $::SKYWATER_MODELS/sky130.lib.spice tt
.include $::SKYWATER_STDCELLS/sky130_fd_sc_hd.spice

"
spice_ignore=false}
C {tt_um_oscillating_bones.sym} 200 -490 0 0 {name=x1}
C {devices/code.sym} 240 -220 0 0 {name=STIMULI only_toplevel=false value="

.tran 50p 200n
.save all

.control
run

meas tran tdiff TRIG "osc_out" VAL=1.7 RISE=2 TARG "osc_out" VAL=1.7 RISE=3
let osc_freq_mhz = (1 / (tdiff) / 1e6)
save osc_freq_mhz

meas tran tdiff_div2 TRIG "osc_div_2" VAL=1.7 RISE=2 TARG "osc_div_2" VAL=1.7 RISE=3
let osc_div_2_freq_mhz = (1 / (tdiff_div2) / 1e6)
save osc_div_2_freq_mhz

meas tran tdiff_div4 TRIG "osc_div_4" VAL=1.7 RISE=2 TARG "osc_div_4" VAL=1.7 RISE=3
let osc_div_4_freq_mhz = (1 / (tdiff_div4) / 1e6)
save osc_div_4_freq_mhz

meas tran tdiff_div8 TRIG "osc_div_8" VAL=1.7 RISE=2 TARG "osc_div_8" VAL=1.7 RISE=3
let osc_div_8_freq_mhz = (1 / (tdiff_div8) / 1e6)
save osc_div_8_freq_mhz

write testbench.raw
.endc
"}
C {devices/vsource.sym} 340 -330 0 0 {name=V1 value=1.8}
C {devices/gnd.sym} 370 -300 0 0 {name=l3 lab=VGND}
C {devices/vdd.sym} 340 -360 0 0 {name=l4 lab=VPWR}
C {devices/launcher.sym} 660 -160 0 0 {name=h5
descr="load waves" 
tclcommand="xschem raw_read $netlist_dir/testbench.raw tran"
}
C {devices/title.sym} 390 -60 0 0 {name=l5 author="Uri Shaked"}
C {lab_pin.sym} 380 -530 2 0 {name=p1 sig_type=std_logic lab=osc_out}
C {lab_pin.sym} 380 -510 2 0 {name=p2 sig_type=std_logic lab=osc_div_2}
C {lab_pin.sym} 380 -490 2 0 {name=p3 sig_type=std_logic lab=osc_div_4}
C {lab_pin.sym} 380 -470 2 0 {name=p4 sig_type=std_logic lab=osc_div_8}
C {devices/gnd.sym} 580 -420 0 0 {name=l1 lab=VGND}
C {res.sym} 550 -530 1 0 {name=R21
value=1Meg
footprint=1206
device=resistor
m=1}
C {res.sym} 550 -510 1 0 {name=R22
value=1Meg
footprint=1206
device=resistor
m=1}
C {res.sym} 550 -490 1 0 {name=R23
value=1Meg
footprint=1206
device=resistor
m=1}
C {res.sym} 550 -470 1 0 {name=R24
value=1Meg
footprint=1206
device=resistor
m=1}
C {devices/vsource.sym} 490 -330 0 0 {name=V2 value=0}
C {devices/gnd.sym} 490 -300 0 0 {name=l2 lab=VGND}
C {lab_pin.sym} 490 -360 0 0 {name=p5 sig_type=std_logic lab=0}
C {devices/vsource.sym} 250 -330 0 0 {name=V3 value=3.3}
C {devices/gnd.sym} 250 -300 0 0 {name=l6 lab=VGND}
C {devices/vdd.sym} 250 -360 0 0 {name=l7 lab=VAPWR}
C {devices/vdd.sym} 400 -360 0 0 {name=l8 lab=VDPWR}
C {devices/vsource.sym} 400 -330 0 0 {name=V4 value=1.8}
C {lab_pin.sym} 380 -450 2 0 {name=p6 sig_type=std_logic lab=osc_out_3v3}
C {res.sym} 550 -450 1 0 {name=R1
value=1Meg
footprint=1206
device=resistor
m=1}
