within AixLib.DataBase.Pumps.PumpPolynomialBased;
model Pump_DN25_H05_12 "25/0.5-12 PN 10 maximum volume flow 12.0 m^3/h"
  extends AixLib.DataBase.Pumps.PumpPolynomialBased.PumpBaseRecord(
            maxMinHeight=
            [0,12.2,0.4; 0.5, 12.3, 0.4; 1, 12.3, 0.4; 1.5, 12.2, 0.4;
            2, 12, 0.3; 2.5, 11.8, 0.2; 3, 11.5, 0.3;
            4, 10.8, 0.5; 5, 9.9, 0.6; 6, 9, 1;
            7, 8.2, 1.4; 8, 7.4, 1.9; 9, 6.6, 2.4;
            10, 5.7, 2.9; 11, 4.8, 3.5],
            maxMinSpeedCurves=
            [0,4350,750; 11,4350,750],
            nMin=750,
            nMax=4350,
            cHQN=[ 0.00000e+00,  0.00000e+00,  5.42119e-07;
                   0.00000e+00,  9.63893e-05,  0.00000e+00;
                  -9.40049e-02,  0.00000e+00,  0.00000e+00]
       "coefficients for H = f(Q,N) from Pump_DN25_H1_8_V9 (DN25_H1_8_V9 and DN25_H1_6_V8 similar scale of the max volume flow)");
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p><span style=\"font-family: Courier New;\">maxMinHeight=[Q [m3/h], Hmax [m], Hmin [m]] (maximum and minimum boundaries of pump)</span></p>
<p><span style=\"font-family: Courier New;\">maxMinSpeedCurves=[Q [m3/h], nMax [rev/min], nMin [rev/min]](maximum and minimum boundaries of pump speed)</span></p>
</html>"));
end Pump_DN25_H05_12;
