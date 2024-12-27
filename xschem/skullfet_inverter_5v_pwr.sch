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
lab=#net1}
N 280 120 280 220 {
lab=A}
N 320 170 410 170 {
lab=Y}
N 320 60 320 90 {lab=#net1}
N 320 250 320 290 {lab=VGND}
C {sky130_fd_pr/pfet_g5v0d10v5.sym} 300 120 0 0 {name=M1
L=0.5
W=4.5
nf=1
mult=1
ad=5.3775
pd=12.07
as=7.5825
ps=29.53
model=pfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/nfet_g5v0d10v5.sym} 300 220 0 0 {name=M2
L=0.5
W=4.5
nf=1 
mult=1
ad=7.8525
pd=29.65
as=5.1075
ps=11.95
model=nfet_g5v0d10v5
spiceprefix=X
}
C {devices/ipin.sym} 280 170 0 0 {name=p1 lab=A}
C {devices/opin.sym} 410 170 0 0 {name=p2 lab=Y}
C {devices/gnd.sym} 320 290 0 0 {name=l3 lab=VGND}
C {devices/ipin.sym} 320 60 0 0 {name=p3 lab=VDD}
