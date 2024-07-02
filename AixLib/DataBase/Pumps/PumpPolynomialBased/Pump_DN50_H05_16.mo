within AixLib.DataBase.Pumps.PumpPolynomialBased;
record Pump_DN50_H05_16 "Pump with head 0.5 to 15,8m and 54m^3/h volume flow (Wilo Stratos Maxo 50/0.5-16 PN6/10)"
   extends PumpBaseRecord(
    maxMinHeight=[
           0.00, 15.73,  0.427;
           1.82, 15.83,  0.451;
           3.64, 15.93,  0.475;
           5.45, 15.95,  0.422;
           7.27, 15.95,  0.349;
           9.09, 15.89,  0.246;
          10.91, 15.79,  0.123;
          12.73, 15.59,  0.000;
          14.54, 15.22,  0.000;
          16.36, 14.81,  0.000;
          18.18, 14.18,  0.000;
          20.00, 13.55,  0.000;
          21.82, 12.99,  0.000;
          23.63, 12.43,  0.000;
          25.45, 11.89,  0.000;
          27.27, 11.36,  0.000;
          29.09, 10.84,  0.000;
          30.91, 10.33,  0.000;
          32.72,  9.82,  0.000;
          34.54,  9.31,  0.000;
          36.36,  8.80,  0.000;
          38.18,  8.24,  0.000;
          40.00,  7.68,  0.000;
          41.81,  7.03,  0.000;
          43.63,  6.37,  0.000;
          45.45,  5.72,  0.000;
          47.27,  5.06,  0.000;
          49.09,  4.44,  0.000;
          50.90,  3.83,  0.000;
          52.72,  3.09,  0.000]
      "maximum and minimum boundaries of pump (Q,Hmax,Hmin)",
    maxMinSpeedCurves = [
           0.00, 3226,  534;
           1.82, 3186,  542;
           3.64, 3146,  551;
           5.45, 3121,  551;
           7.27, 3100,  549;
           9.09, 3085,  536;
          10.91, 3073,  515;
          12.73, 3047,  549;
          14.54, 2996,  549;
          16.36, 2946,  549;
          18.18, 2896,  549;
          20.00, 2846,  549;
          21.82, 2806,  549;
          23.63, 2765,  549;
          25.45, 2725,  549;
          27.27, 2685,  549;
          29.09, 2656,  549;
          30.91, 2635,  549;
          32.72, 2610,  549;
          34.54, 2579,  549;
          36.36, 2550,  549;
          38.18, 2530,  549;
          40.00, 2509,  549;
          41.81, 2488,  549;
          43.63, 2467,  549;
          45.45, 2461,  549;
          47.27, 2460,  549;
          49.09, 2446,  549;
          50.90, 2425,  549;
          52.72, 2391,  549]
      "maximum and minimum boundaries of pump speed (Q,nMax,nMin)",
    nMin=500,
    nMax=3200,
    cHQN=[ 0.00000e+00,  0.00000e+00,  1.52394e-06;
           0.00000e+00,  5.07893e-05,  0.00000e+00;
          -4.42148e-03,  0.00000e+00,  0.00000e+00]
       "coefficients for H = f(Q,N)",
    cPQN=[ 8.61711e+01, -3.19500e-01,  3.36762e-04, -1.12746e-07,  1.59435e-11;
           0.00000e+00,  0.00000e+00,  4.33938e-06,  0.00000e+00,  0.00000e+00;
           0.00000e+00,  5.09522e-05,  0.00000e+00,  0.00000e+00,  0.00000e+00;
          -4.54214e-03,  0.00000e+00,  0.00000e+00,  0.00000e+00,  0.00000e+00]
       "coefficients for P = f(Q,N)");

      annotation(preferredView="text", Documentation(revisions="<html><ul>

  <li>2023-10-19 by Sarah Leidolf:<br/>
    Generated
  </li>
</ul>

</html>", info="<html><h4>
  Measurement and Regression Data
</h4>
<p>
  Impure curves at high pump speed because of inaccurate data of upper
  and lower limit of pump speed.
</p>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/DataBase/Pumps/PumpsPolynomialBased/Pump_DN50_H05_16.png\"
  alt=\"1\">

</p>
<p>
  cHQN:
</p>
<p>

  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  1.52394e-06;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 5.07893e-05,
  0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-4.42148e-03, 0.00000e+00,
  0.00000e+000</span>

</p>
<p>
  cPQN:
</p>
<p>

  <span style=\"font-family: Courier New;\">8.61711e+01, -3.19500e-01,
  3.36762e-04, -1.12746e-07, 1.59435e-11;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  4.33938e-06, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 5.09522e-05,
  0.00000e+00, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-4.54214e-03, 0.00000e+00,
  0.00000e+00, 0.00000e+00, 0.00000e+00</span>

</p>
</html>"));

end Pump_DN50_H05_16;
