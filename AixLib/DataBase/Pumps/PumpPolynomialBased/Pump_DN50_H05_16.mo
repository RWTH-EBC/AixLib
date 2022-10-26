within AixLib.DataBase.Pumps.PumpPolynomialBased;
record Pump_DN50_H05_16 "50/0.5-16 PN 6/10 maximum volume flow 53.0 m^3/h"
  extends AixLib.DataBase.Pumps.PumpPolynomialBased.PumpBaseRecord(
            maxMinHeight=
            [0,15.8,0.4; 3,16,0.4; 6,16,0.3; 9,16,0.2;
            11,15.9,0.05; 12,15.8,0; 14,15.4,0.1; 18,14.2,0.3;
            22,13,0.6; 26,11.7,0.8; 30,10.5,1; 35,9,1.2;
            40,7.6,1.8; 45,6,2.05; 50,4.3,2.7; 53,3,3],
            maxMinSpeedCurves=
            [0,3200,500; 53,3200,500],
            nMin=500,
            nMax=3200,
            cHQN=[ 0, 0, 1.31E-06;
                   0, 7.59E-06, 0;
                  -0.00316, 0, 0] "coefficients for H = f(Q,N) from Pump_DN50 (similar scale of max volume flow and maxmin Speed)",
            cPQN=[-2.45477E+01, 2.82590E-01, -2.38897E-04, 1.27064E-07, -1.27494E-11;
                   0, 0, 3.23573E-06, 0, 0;
                   0, 8.70834E-05, 0, 0, 0;
                  -8.39000E-03, 0, 0, 0, 0] "coefficients for P = f(Q,N) from Pump_DN50 (similar scale of max volume flow and maxmin Speed)");

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p><span style=\"font-family: Courier New;\">maxMinHeight=[Q [m3/h], Hmax [m], Hmin [m]] (maximum and minimum boundaries of pump)</span></p>
<p><span style=\"font-family: Courier New;\">maxMinSpeedCurves=[Q [m3/h], nMax [rev/min], nMin [rev/min]](maximum and minimum boundaries of pump speed)</span></p>
</html>"));

end Pump_DN50_H05_16;
