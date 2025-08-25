v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -320 -30 -280 -30 {lab=IN}
N 110 -10 110 30 {lab=#net1}
N 320 -10 320 30 {lab=#net2}
N -90 -30 -70 -30 {lab=ODIV2}
N 120 -30 140 -30 {lab=ODIV4}
N 320 -30 330 -30 {lab=ODIV8}
N 330 -80 330 -30 {lab=ODIV8}
N 120 -80 140 -80 {lab=ODIV4}
N 120 -80 120 -30 {lab=ODIV4}
N -90 -80 -70 -80 {lab=ODIV2}
N -90 -80 -90 -30 {lab=ODIV2}
N 110 -30 120 -30 {lab=ODIV4}
N -100 -30 -90 -30 {lab=ODIV2}
N -300 -10 -280 -10 {lab=#net3}
N -300 -10 -300 30 {lab=#net3}
N -300 30 -100 30 {lab=#net3}
N -100 -10 -100 30 {lab=#net3}
N -80 -10 -70 -10 {lab=#net1}
N -80 -10 -80 30 {lab=#net1}
N -80 30 110 30 {lab=#net1}
N 130 -10 140 -10 {lab=#net2}
N 130 -10 130 30 {lab=#net2}
N 130 30 320 30 {lab=#net2}
N -280 10 -280 50 {lab=#net4}
N -70 10 -70 50 {lab=#net4}
N -280 50 -70 50 {lab=#net4}
N -330 50 -280 50 {lab=#net4}
N 140 10 140 50 {lab=#net4}
N -70 50 140 50 {lab=#net4}
C {ipin.sym} -320 -30 0 0 {name=p1 lab=IN}
C {opin.sym} -70 -80 0 0 {name=p2 lab=ODIV2}
C {opin.sym} 140 -80 0 0 {name=p3 lab=ODIV4}
C {opin.sym} 330 -80 0 0 {name=p4 lab=ODIV8}
C {sg13g2_stdcells/sg13g2_dfrbp_2.sym} -190 -10 0 0 {name=x4 VDD=VDD VSS=VSS prefix=sg13g2_ }
C {sg13g2_stdcells/sg13g2_dfrbp_2.sym} 20 -10 0 0 {name=x1 VDD=VDD VSS=VSS prefix=sg13g2_ }
C {sg13g2_stdcells/sg13g2_dfrbp_2.sym} 230 -10 0 0 {name=x2 VDD=VDD VSS=VSS prefix=sg13g2_ }
C {devices/vdd.sym} -330 50 0 0 {name=l4 lab=VDPWR}
