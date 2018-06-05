Clear

! Note that this is a 3-wire delta system. 
! Node voltages in OpenDSS are normally line-ground and may give strange-looking results
! Be careful if you put line-neutral connected loads or other devices on this circuit.

New object=circuit.ieee37
~ basekv=230 pu=1.00 MVAsc3=200000 MVAsc1=210000

! Substation Transformer
New Transformer.SubXF Phases=3 Windings=2 Xhl=8
~ wdg=1 bus=sourcebus conn=Delta kv=230   kva=2500   %r=1
~ wdg=2 bus=799       conn=Delta kv=4.8   kva=2500   %r=1

! Load Transformer
New Transformer.XFM1  Phases=3 Windings=2 Xhl=1.81
~ wdg=1 bus=709       conn=Delta kv=4.80  kva=500    %r=0.045
~ wdg=2 bus=775       conn=Delta kv=0.48  kva=500    %r=0.045

! import line codes with phase impedance matrices
Redirect        IEEELineCodes.dss

! Lines
New Line.L1     Phases=3 Bus1=701.1.2.3  Bus2=702.1.2.3  LineCode=722  Length=0.96
New Line.L2     Phases=3 Bus1=702.1.2.3  Bus2=705.1.2.3  LineCode=724  Length=0.4
New Line.L3     Phases=3 Bus1=702.1.2.3  Bus2=713.1.2.3  LineCode=723  Length=0.36
New Line.L4     Phases=3 Bus1=702.1.2.3  Bus2=703.1.2.3  LineCode=722  Length=1.32
New Line.L5     Phases=3 Bus1=703.1.2.3  Bus2=727.1.2.3  LineCode=724  Length=0.24
New Line.L6     Phases=3 Bus1=703.1.2.3  Bus2=730.1.2.3  LineCode=723  Length=0.6
New Line.L7     Phases=3 Bus1=704.1.2.3  Bus2=714.1.2.3  LineCode=724  Length=0.08
New Line.L8     Phases=3 Bus1=704.1.2.3  Bus2=720.1.2.3  LineCode=723  Length=0.8
New Line.L9     Phases=3 Bus1=705.1.2.3  Bus2=742.1.2.3  LineCode=724  Length=0.32
New Line.L10    Phases=3 Bus1=705.1.2.3  Bus2=712.1.2.3  LineCode=724  Length=0.24
New Line.L11    Phases=3 Bus1=706.1.2.3  Bus2=725.1.2.3  LineCode=724  Length=0.28
New Line.L12    Phases=3 Bus1=707.1.2.3  Bus2=724.1.2.3  LineCode=724  Length=0.76
New Line.L13    Phases=3 Bus1=707.1.2.3  Bus2=722.1.2.3  LineCode=724  Length=0.12
New Line.L14    Phases=3 Bus1=708.1.2.3  Bus2=733.1.2.3  LineCode=723  Length=0.32
New Line.L15    Phases=3 Bus1=708.1.2.3  Bus2=732.1.2.3  LineCode=724  Length=0.32
New Line.L16    Phases=3 Bus1=709.1.2.3  Bus2=731.1.2.3  LineCode=723  Length=0.6
New Line.L17    Phases=3 Bus1=709.1.2.3  Bus2=708.1.2.3  LineCode=723  Length=0.32
New Line.L18    Phases=3 Bus1=710.1.2.3  Bus2=735.1.2.3  LineCode=724  Length=0.2
New Line.L19    Phases=3 Bus1=710.1.2.3  Bus2=736.1.2.3  LineCode=724  Length=1.28
New Line.L20    Phases=3 Bus1=711.1.2.3  Bus2=741.1.2.3  LineCode=723  Length=0.4
New Line.L21    Phases=3 Bus1=711.1.2.3  Bus2=740.1.2.3  LineCode=724  Length=0.2
New Line.L22    Phases=3 Bus1=713.1.2.3  Bus2=704.1.2.3  LineCode=723  Length=0.52
New Line.L23    Phases=3 Bus1=714.1.2.3  Bus2=718.1.2.3  LineCode=724  Length=0.52
New Line.L24    Phases=3 Bus1=720.1.2.3  Bus2=707.1.2.3  LineCode=724  Length=0.92
New Line.L25    Phases=3 Bus1=720.1.2.3  Bus2=706.1.2.3  LineCode=723  Length=0.6
New Line.L26    Phases=3 Bus1=727.1.2.3  Bus2=744.1.2.3  LineCode=723  Length=0.28
New Line.L27    Phases=3 Bus1=730.1.2.3  Bus2=709.1.2.3  LineCode=723  Length=0.2
New Line.L28    Phases=3 Bus1=733.1.2.3  Bus2=734.1.2.3  LineCode=723  Length=0.56
New Line.L29    Phases=3 Bus1=734.1.2.3  Bus2=737.1.2.3  LineCode=723  Length=0.64
New Line.L30    Phases=3 Bus1=734.1.2.3  Bus2=710.1.2.3  LineCode=724  Length=0.52
New Line.L31    Phases=3 Bus1=737.1.2.3  Bus2=738.1.2.3  LineCode=723  Length=0.4
New Line.L32    Phases=3 Bus1=738.1.2.3  Bus2=711.1.2.3  LineCode=723  Length=0.4
New Line.L33    Phases=3 Bus1=744.1.2.3  Bus2=728.1.2.3  LineCode=724  Length=0.2
New Line.L34    Phases=3 Bus1=744.1.2.3  Bus2=729.1.2.3  LineCode=724  Length=0.28
New Line.L35    Phases=3 Bus1=799r.1.2.3 Bus2=701.1.2.3  LineCode=721  Length=1.85

! Regulator - open delta with C leading, A lagging, base LDC setting is 1.5 + j3
new transformer.reg1a phases=1 windings=2 buses=(799.1.2 799r.1.2) conns='delta delta' kvs="4.8 4.8" kvas="2000 2000" XHL=1
new regcontrol.creg1a transformer=reg1a winding=2 vreg=122 band=2 ptratio=40 ctprim=350 R=-0.201 X=3.348
new transformer.reg1c like=reg1a buses=(799.3.2 799r.3.2)
new regcontrol.creg1c like=creg1a transformer=reg1c R=2.799 X=1.848
New Line.Jumper Phases=1 Bus1=799.2      Bus2=799r.2     r0=1e-3 r1=1e-3 x0=0 x1=0 c0=0 c1=0

! spot loads
New Load.S701a      Bus1=701.1.2 Phases=1 Conn=Delta Model=1 kV=  4.800 kW= 140.0 kVAR=  70.0
New Load.S701b      Bus1=701.2.3 Phases=1 Conn=Delta Model=1 kV=  4.800 kW= 140.0 kVAR=  70.0
New Load.S701c      Bus1=701.3.1 Phases=1 Conn=Delta Model=1 kV=  4.800 kW= 350.0 kVAR= 175.0
New Load.S712c      Bus1=712.3.1 Phases=1 Conn=Delta Model=1 kV=  4.800 kW=  85.0 kVAR=  40.0
New Load.S713c      Bus1=713.3.1 Phases=1 Conn=Delta Model=1 kV=  4.800 kW=  85.0 kVAR=  40.0
New Load.S714a      Bus1=714.1.2 Phases=1 Conn=Delta Model=4 kV=  4.800 kW=  17.0 kVAR=   8.0
New Load.S714b      Bus1=714.2.3 Phases=1 Conn=Delta Model=4 kV=  4.800 kW=  21.0 kVAR=  10.0
New Load.S718a      Bus1=718.1.2 Phases=1 Conn=Delta Model=2 kV=  4.800 kW=  85.0 kVAR=  40.0
New Load.S720c      Bus1=720.3.1 Phases=1 Conn=Delta Model=1 kV=  4.800 kW=  85.0 kVAR=  40.0
New Load.S722b      Bus1=722.2.3 Phases=1 Conn=Delta Model=4 kV=  4.800 kW= 140.0 kVAR=  70.0
New Load.S722c      Bus1=722.3.1 Phases=1 Conn=Delta Model=4 kV=  4.800 kW=  21.0 kVAR=  10.0
New Load.S724b      Bus1=724.2.3 Phases=1 Conn=Delta Model=2 kV=  4.800 kW=  42.0 kVAR=  21.0
New Load.S725b      Bus1=725.2.3 Phases=1 Conn=Delta Model=1 kV=  4.800 kW=  42.0 kVAR=  21.0
New Load.S727c      Bus1=727.3.1 Phases=1 Conn=Delta Model=1 kV=  4.800 kW=  42.0 kVAR=  21.0
New Load.S728       Bus1=728   Phases=3 Conn=Delta Model=1 kV=  4.800 kW= 126.0 kVAR=  63.0
New Load.S729a      Bus1=729.1.2 Phases=1 Conn=Delta Model=4 kV=  4.800 kW=  42.0 kVAR=  21.0
New Load.S730c      Bus1=730.3.1 Phases=1 Conn=Delta Model=2 kV=  4.800 kW=  85.0 kVAR=  40.0
New Load.S731b      Bus1=731.2.3 Phases=1 Conn=Delta Model=2 kV=  4.800 kW=  85.0 kVAR=  40.0
New Load.S732c      Bus1=732.3.1 Phases=1 Conn=Delta Model=1 kV=  4.800 kW=  42.0 kVAR=  21.0
New Load.S733a      Bus1=733.1.2 Phases=1 Conn=Delta Model=4 kV=  4.800 kW=  85.0 kVAR=  40.0
New Load.S734c      Bus1=734.3.1 Phases=1 Conn=Delta Model=1 kV=  4.800 kW=  42.0 kVAR=  21.0
New Load.S735c      Bus1=735.3.1 Phases=1 Conn=Delta Model=1 kV=  4.800 kW=  85.0 kVAR=  40.0
New Load.S736b      Bus1=736.2.3 Phases=1 Conn=Delta Model=2 kV=  4.800 kW=  42.0 kVAR=  21.0
New Load.S737a      Bus1=737.1.2 Phases=1 Conn=Delta Model=4 kV=  4.800 kW= 140.0 kVAR=  70.0
New Load.S738a      Bus1=738.1.2 Phases=1 Conn=Delta Model=1 kV=  4.800 kW= 126.0 kVAR=  62.0
New Load.S740c      Bus1=740.3.1 Phases=1 Conn=Delta Model=1 kV=  4.800 kW=  85.0 kVAR=  40.0
New Load.S741c      Bus1=741.3.1 Phases=1 Conn=Delta Model=4 kV=  4.800 kW=  42.0 kVAR=  21.0
New Load.S742a      Bus1=742.1.2 Phases=1 Conn=Delta Model=2 kV=  4.800 kW=   8.0 kVAR=   4.0
New Load.S742b      Bus1=742.2.3 Phases=1 Conn=Delta Model=2 kV=  4.800 kW=  85.0 kVAR=  40.0
New Load.S744a      Bus1=744.1.2 Phases=1 Conn=Delta Model=1 kV=  4.800 kW=  42.0 kVAR=  21.0

Set VoltageBases = "230,4.8,0.48"
CalcVoltageBases
BusCoords IEEE37_BusXY.csv

! solve mode=direct
set maxiterations=100
solve

! show voltages LL Nodes
! show currents residual=y elements
! show powers kva elements
! show taps

