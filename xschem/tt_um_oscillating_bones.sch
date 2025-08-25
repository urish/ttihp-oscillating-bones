v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 390 -140 430 -140 {lab=uo_out[3]}
N 390 -160 430 -160 {lab=uo_out[2]}
N 390 -180 430 -180 {lab=uo_out[1]}
N 70 -200 430 -200 {lab=uo_out[0]}
N 70 -200 70 -180 {lab=uo_out[0]}
N 70 -180 90 -180 {lab=uo_out[0]}
N -160 -180 70 -180 {lab=uo_out[0]}
N 30 -220 30 -160 {lab=VDPWR}
N 30 -160 90 -160 {lab=VDPWR}
N 30 -140 90 -140 {lab=VGND}
N 30 -140 30 -130 {lab=VGND}
C {freq_divider.sym} 240 -160 0 0 {name=x22}
C {ring.sym} -305 -180 0 0 {name=x1}
C {opin.sym} 430 -180 0 0 {name=p1 lab=uo_out[1]}
C {opin.sym} 430 -200 0 0 {name=p2 lab=uo_out[0]}
C {opin.sym} 430 -160 0 0 {name=p3 lab=uo_out[2]}
C {opin.sym} 430 -140 0 0 {name=p5 lab=uo_out[3]}
C {devices/vdd.sym} 30 -220 0 0 {name=l8 lab=VDPWR}
C {devices/gnd.sym} 30 -130 0 0 {name=l2 lab=VGND}
