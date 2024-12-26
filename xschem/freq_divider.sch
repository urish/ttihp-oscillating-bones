v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -320 -30 -280 -30 {lab=IN}
N 110 -10 110 10 {lab=#net1}
N -70 -10 -70 10 {lab=#net1}
N -70 10 110 10 {lab=#net1}
N 140 -10 140 10 {lab=#net2}
N 140 10 320 10 {lab=#net2}
N 320 -10 320 10 {lab=#net2}
N -280 -10 -280 10 {lab=#net3}
N -280 10 -100 10 {lab=#net3}
N -100 -10 -100 10 {lab=#net3}
N -100 -30 -70 -30 {lab=ODIV2}
N 110 -30 140 -30 {lab=ODIV4}
N 320 -30 330 -30 {lab=ODIV8}
N 330 -80 330 -30 {lab=ODIV8}
N 120 -80 140 -80 {lab=ODIV4}
N 120 -80 120 -30 {lab=ODIV4}
N -90 -80 -70 -80 {lab=ODIV2}
N -90 -80 -90 -30 {lab=ODIV2}
C {sky130_stdcells/dfxbp_1.sym} -190 -20 0 0 {name=x1 VGND=VGND VNB=VNB VPB=VPB VPWR=VPWR prefix=sky130_fd_sc_hd__ }
C {sky130_stdcells/dfxbp_1.sym} 20 -20 0 0 {name=x2 VGND=VGND VNB=VNB VPB=VPB VPWR=VPWR prefix=sky130_fd_sc_hd__ }
C {sky130_stdcells/dfxbp_1.sym} 230 -20 0 0 {name=x3 VGND=VGND VNB=VNB VPB=VPB VPWR=VPWR prefix=sky130_fd_sc_hd__ }
C {ipin.sym} -320 -30 0 0 {name=p1 lab=IN}
C {opin.sym} -70 -80 0 0 {name=p2 lab=ODIV2}
C {opin.sym} 140 -80 0 0 {name=p3 lab=ODIV4}
C {opin.sym} 330 -80 0 0 {name=p4 lab=ODIV8}
