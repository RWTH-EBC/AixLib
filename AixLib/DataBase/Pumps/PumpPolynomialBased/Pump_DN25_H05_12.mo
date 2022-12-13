within AixLib.DataBase.Pumps.PumpPolynomialBased;
model Pump_DN25_H05_12 "25/0.5-12 PN 10 maximum volume flow 12.0 m^3/h"
   extends AixLib.DataBase.Pumps.PumpPolynomialBased.PumpBaseRecord(
            maxMinHeight=
            [0, 12.269209486166007, 0.29600790513834063;
0.5227272727272729, 12.334664031620553, 0.2824901185770763;
1, 12.322213438735178, 0.3091699604743088;
1.5045454545454549, 12.230790513833991, 0.21774703557312414;
2.0090909090909093, 11.943715415019762, 0.16545454545454596;
2.5, 11.65699604743083, 0.07438735177865752;
3.018181818181818, 11.291660079051383, 0.09999999999999964;
3.9863636363636363, 10.561343873517785, 0.3486561264822132;
5.009090909090909, 9.713280632411067, 0.5176284584980237;
5.990909090909091, 8.905059288537547, 0.8050592885375494;
7.490909090909091, 7.613754940711462, 1.3528853754940702;
8.990909090909092, 6.283675889328062, 2.0181027667984175;
10.477272727272727, 4.796719367588931, 2.879328063241106;
11.527272727272727, 3.5954150197628447, 3.5954150197628447],
            maxMinSpeedCurves=
            [0,4350,750; 11,4350,750],
            nMin=750,
            nMax=4350,
            cHQN=[ 0.00000e+00,  0.00000e+00,  5.42119e-07;
                   0.00000e+00,  9.63893e-05,  0.00000e+00;
                  -9.40049e-02,  0.00000e+00,  0.00000e+00]
       "coefficients for H = f(Q,N) from Pump_DN25_H1_8_V9 (DN25_H1_8_V9 and DN25_H1_6_V8 similar scale of the max volume flow)",
               cPQN=[ 1.86404e-05,  1.15429e-02, -9.54392e-06,  4.26061e-09, -3.87948e-13;
           0.00000e+00,  0.00000e+00,  1.54239e-06,  0.00000e+00,  0.00000e+00;
           0.00000e+00,  1.16734e-04,  0.00000e+00,  0.00000e+00,  0.00000e+00;
          -1.06179e-01,  0.00000e+00,  0.00000e+00,  0.00000e+00,  0.00000e+00]
       "coefficients for P = f(Q,N) from Pump_DN25_H1_8_V9 (DN25_H1_8_V9 and DN25_H1_6_V8 similar scale of the max volume flow");
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p><span style=\"font-family: Courier New;\">maxMinHeight=[Q [m3/h], Hmax [m], Hmin [m]] (maximum and minimum boundaries of pump)</span></p>
<p><span style=\"font-family: Courier New;\">maxMinSpeedCurves=[Q [m3/h], nMax [rev/min], nMin [rev/min]](maximum and minimum boundaries of pump speed)</span></p>

Data sheet:
<a href=\"https://wilo.com/de/de/Katalog/de/produkte-expertise/wilo-stratos-maxo/stratos-maxo-25-0-5-12-pn-10\"
>https://wilo.com/de/de/Katalog/de/produkte-expertise/wilo-stratos-maxo/stratos-maxo-25-0-5-12-pn-10</a>

</html>"));
end Pump_DN25_H05_12;
