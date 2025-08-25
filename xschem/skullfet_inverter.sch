v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 320 170 320 190 {
lab=Y}
N 320 220 320 290 {
lab=VGND}
N 280 120 280 220 {
lab=A}
N 320 170 410 170 {
lab=Y}
N 320 60 320 120 {lab=VDPWR}
N 320 150 320 170 {
lab=Y}
C {devices/ipin.sym} 280 170 0 0 {name=p1 lab=A}
C {devices/opin.sym} 410 170 0 0 {name=p2 lab=Y}
C {devices/gnd.sym} 320 290 0 0 {name=l3 lab=VGND}
C {devices/vdd.sym} 320 60 0 0 {name=l4 lab=VDPWR}
C {sg13g2_pr/sg13_lv_pmos.sym} 300 120 0 0 {name=M1
l=0.4u
w=4.05u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 300 220 0 0 {name=M2
l=0.4u
w=4.05u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
