v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 320 150 320 190 {
lab=Y}
N 320 220 320 250 {
lab=VGND}
N 320 90 320 120 {
lab=VPWR}
N 280 120 280 220 {
lab=A}
N 320 170 410 170 {
lab=Y}
N 320 60 320 90 {lab=VPWR}
N 320 250 320 290 {lab=VGND}
C {sky130_fd_pr/pfet_01v8_hvt.sym} 300 120 0 0 {name=M1
L=0.4
W=4.05
nf=1
mult=1
ad=6.2694
pd=26.64
as=4.4307
ps=10.9
model=pfet_01v8_hvt
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8.sym} 300 220 0 0 {name=M2
L=0.4
W=4.05
nf=1 
mult=1
ad=4.2687
pd=10.82
as=6.4314
ps=26.72
model=nfet_01v8
spiceprefix=X
}
C {devices/ipin.sym} 280 170 0 0 {name=p1 lab=A}
C {devices/opin.sym} 410 170 0 0 {name=p2 lab=Y}
C {devices/gnd.sym} 320 290 0 0 {name=l3 lab=VGND}
C {devices/vdd.sym} 320 60 0 0 {name=l4 lab=VPWR}
