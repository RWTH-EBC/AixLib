within AixLib.DataBase.Pumps.PumpPolynomialBased;
record Pump_DN50_H1_10 "Pump with head 1 to 10.8m and 11.5m^3/h volume flow (Wilo Stratos 50/1-10)"
 extends PumpBaseRecord(
     maxMinHeight=[
           0.00, 10.26,  0.900;
           0.38, 10.32,  0.909;
           0.76, 10.37,  0.918;
           1.14, 10.43,  0.928;
           1.52, 10.49,  0.937;
           1.90, 10.55,  0.946;
           2.28, 10.60,  0.850;
           2.66, 10.64,  0.712;
           3.03, 10.68,  0.574;
           3.41, 10.44,  0.435;
           3.79,  9.96,  0.297;
           4.17,  9.46,  0.000;
           4.55,  8.95,  0.000;
           4.93,  8.44,  0.000;
           5.31,  7.94,  0.000;
           5.69,  7.47,  0.000;
           6.07,  7.01,  0.000;
           6.45,  6.58,  0.000;
           6.83,  6.15,  0.000;
           7.21,  5.74,  0.000;
           7.59,  5.34,  0.000;
           7.97,  4.94,  0.000;
           8.34,  4.48,  0.000;
           8.72,  4.00,  0.000;
           9.10,  3.54,  0.000;
           9.48,  3.08,  0.000;
           9.86,  2.63,  0.000;
          10.24,  2.11,  0.000;
          10.62,  1.55,  0.000;
          11.00,  1.00,  0.000]
      "maximum and minimum boundaries of pump (Q,Hmax,Hmin)",
    maxMinSpeedCurves = [
          0.00, 4450, 1400;
           0.40, 4450, 1400;
           0.79, 4450, 1400;
           1.19, 4450, 1400;
           1.59, 4450, 1400;
           1.98, 4450, 1400;
           2.38, 4450, 1400;
           2.78, 4450, 1400;
           3.17, 4450, 1400;
           3.57, 4431, 1400;
           3.97, 4411, 1400;
           4.36, 4381, 1400;
           4.76, 4349, 1400;
           5.16, 4318, 1400;
           5.55, 4286, 1400;
           5.95, 4254, 1400;
           6.34, 4224, 1400;
           6.74, 4195, 1400;
           7.14, 4164, 1400;
           7.53, 4131, 1400;
           7.93, 4098, 1400;
           8.33, 4065, 1400;
           8.72, 4033, 1400;
           9.12, 4001, 1400;
           9.52, 3969, 1400;
           9.91, 3937, 1400;
          10.31, 3905, 1400;
          10.71, 3873, 1400;
          11.10, 3846, 1400;
          11.50, 3830, 1400]
      "maximum and minimum boundaries of pump speed (Q,nMax,nMin)",
    nMin=1400,
    nMax=4450,
    cHQN=[0.00000e+00,  0.00000e+00,  5.29109e-07;
           0.00000e+00,  1.41007e-04, -2.69160e-08;
          -6.78540e-02,  0.00000e+00,  0.00000e+00]
       "coefficients for H = f(Q,N)",
    cPQN=[1.27173e+00,  2.83414e-02, -3.32976e-05,  1.37583e-08, -1.49621e-12;
           3.36126e+01, -2.82618e-02,  6.76678e-06,  0.00000e+00,  0.00000e+00;
          -7.91039e+00,  8.00678e-03, -1.65276e-06,  0.00000e+00,  0.00000e+00;
          -4.10723e-01,  0.00000e+00,  2.94088e-08,  0.00000e+00,  0.00000e+00]
       "coefficients for P = f(Q,N)");
      annotation(preferredView="text", Documentation(revisions="<html>
<ul>
<li>2023-10-19 by Sarah Leidolf:<br>Generated</li>
</ul>
</html>", info="<html>
<h4>Measurement and Regression Data</h4>
<p>Dimension estimate, but inaccuracies occur due to lack of information in the data sheets.</p>
<p>Espacially because of missing information of upper and lower limit of pump speed.</p>
<p><img src=\"modelica://AixLib/Resources/Images/DataBase/Pumps/PumpsPolynomialBased/Pump_DN50_H1_10.png\"/> </p>
<p>cHQN:</p>
<p><span style=\"font-family: Courier New;\">0.00000e+00,  0.00000e+00,  5.29109e-07;</span></p>
<p><span style=\"font-family: Courier New;\">0.00000e+00,  1.41007e-04, -2.69160e-08;</span></p>
<p><span style=\"font-family: Courier New;\">-6.78540e-02,  0.00000e+00,  0.00000e+00</span></p>
<p>cPQN:</p>
<p><span style=\"font-family: Courier New;\">1.27173e+00,  2.83414e-02, -3.32976e-05,  1.37583e-08, -1.49621e-12;</span></p>
<p><span style=\"font-family: Courier New;\"> 3.36126e+01, -2.82618e-02,  6.76678e-06,  0.00000e+00,  0.00000e+00;</span></p>
<p><span style=\"font-family: Courier New;\"> -7.91039e+00,  8.00678e-03, -1.65276e-06,  0.00000e+00,  0.00000e+00;</span></p>
<p><span style=\"font-family: Courier New;\">-4.10723e-01,  0.00000e+00,  2.94088e-08,  0.00000e+00,  0.00000e+00</span></p>
</html>"));
end Pump_DN50_H1_10;
