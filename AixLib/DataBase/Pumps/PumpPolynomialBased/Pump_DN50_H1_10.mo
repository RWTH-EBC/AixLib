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
           0.38, 4450, 1400;
           0.76, 4450, 1400;
           1.14, 4450, 1400;
           1.52, 4450, 1400;
           1.90, 4450, 1400;
           2.28, 4450, 1400;
           2.66, 4450, 1400;
           3.03, 4450, 1400;
           3.41, 4450, 1400;
           3.79, 4450, 1400;
           4.17, 4450, 1400;
           4.55, 4200, 1400;
           4.93, 4014, 1400;
           5.31, 4006, 1400;
           5.69, 3993, 1400;
           6.07, 3986, 1400;
           6.45, 3972, 1400;
           6.83, 3965, 1400;
           7.21, 3951, 1400;
           7.59, 3944, 1400;
           7.97, 3930, 1400;
           8.34, 3920, 1400;
           8.72, 3909, 1400;
           9.10, 3900, 1400;
           9.48, 3888, 1400;
           9.86, 3880, 1400;
          10.24, 3867, 1400;
          10.62, 3859, 1400;
          11.00, 3846, 1400]
      "maximum and minimum boundaries of pump speed (Q,nMax,nMin)",
    nMin=1400,
    nMax=4450,
    cHQN=[0.00000e+00,  0.00000e+00,  5.24657e-07;
          -3.89844e-01,  1.45207e-04,  0.00000e+00;
           3.82070e-03,  0.00000e+00, -5.39588e-09]
       "coefficients for H = f(Q,N)",
    cPQN=[ 9.80257e-02,  4.36208e-02, -4.75382e-05,  1.80796e-08, -1.91681e-12;
           1.97155e+01, -2.01796e-02,  5.63182e-06,  0.00000e+00,  0.00000e+00;
          -5.52573e+00,  7.08360e-03, -1.58502e-06,  0.00000e+00,  0.00000e+00;
          -5.06448e-01,  0.00000e+00,  3.65647e-08,  0.00000e+00,  0.00000e+00]
       "coefficients for P = f(Q,N)");
      annotation(preferredView="text", Documentation(revisions="<html>
<ul>
<li>2023-10-19 by Sarah Leidolf:<br>Generated</li>
</ul>
</html>", info="<html>
<h4>Measurement and Regression Data</h4>
<p>Dimension estimate, but inaccuracies occur due to lack of information in the data sheets.</p>
<p>Espacially because of missing information of actual speed.</p>
<p><img src=\"modelica://AixLib/Resources/Images/DataBase/Pumps/PumpsPolynomialBased/Pump_DN50_H1_10.png\"/> </p>
<p>cHQN:</p>
<p><span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00, 5.24657e-07;</span></p>
<p><span style=\"font-family: Courier New;\">-3.89844e-01, 1.45207e-04, 0.00000e+00;</span></p>
<p><span style=\"font-family: Courier New;\">3.82070e-03, 0.00000e+00, -5.39588e-09</span></p>
<p>cPQN:</p>
<p><span style=\"font-family: Courier New;\">9.80257e-02, 4.36208e-02, -4.75382e-05, 1.80796e-08, -1.91681e-12;</span></p>
<p><span style=\"font-family: Courier New;\">1.97155e+01, -2.01796e-02, 5.63182e-06, 0.00000e+00, 0.00000e+00;</span></p>
<p><span style=\"font-family: Courier New;\">-5.52573e+00, 7.08360e-03, -1.58502e-06, 0.00000e+00, 0.00000e+00;</span></p>
<p><span style=\"font-family: Courier New;\">-5.06448e-01, 0.00000e+00, 3.65647e-08, 0.00000e+00, 0.00000e+00</span></p>
</html>"));
end Pump_DN50_H1_10;
