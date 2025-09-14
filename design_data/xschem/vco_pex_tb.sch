v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 1210 -30 2010 370 {flags=graph
y1=-0.004
y2=1.3
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0
x2=4.73128e-07
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node=vout
color=4
dataset=-1
unitx=1
logx=0
logy=0
rawfile=$netlist_dir/vco.raw}
N 760 -130 1000 -130 {lab=#net1}
N 760 -130 760 -60 {lab=#net1}
N 840 -60 890 -60 {lab=#net2}
N 1100 -60 1130 -60 {lab=Vout}
N 1000 10 1000 40 {lab=GND}
N 840 -0 840 40 {lab=GND}
N 760 0 760 40 {lab=GND}
C {devices/code_shown.sym} 1200 -100 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOSlv.lib mos_tt
.lib $::SG13G2_MODELS/cornerCAP.lib cap_typ_stat
"}
C {vsource.sym} 760 -30 0 0 {name=VPWR value=1.2 savecurrent=false}
C {vsource.sym} 840 -30 0 0 {name=vctl value=1 savecurrent=false}
C {gnd.sym} 840 40 0 0 {name=l2 lab=GND}
C {gnd.sym} 760 40 0 0 {name=l9 lab=GND}
C {opin.sym} 1130 -60 0 0 {name=p17 lab=Vout}
C {gnd.sym} 1000 40 0 0 {name=l1 lab=GND}
C {launcher.sym} 1750 -70 0 0 {name=h5
descr="load tran waves" 
tclcommand="xschem raw_read $netlist_dir/vco.raw tran"
}
C {vco.sym} 1000 -60 0 0 {name=x1}
C {devices/code_shown.sym} 750 100 0 0 {name=NGSPICE1 only_toplevel=true 
value="
.param temp=27
.control
save all
.options maxstep=10n reltol=1e-3 abstol=1e-6
save v(vout)
tran 100p 1u
write vco.raw
plot v(Vout) xlimit 500n 1u
fft v(Vout)
let vmag = db(mag(v(Vout)))
plot vmag xlabel 'Frequency (Hz)' xlimit 1Meg 100Meg
wrdata fft_output(Vcon=1).txt vmag
.endc
"}
