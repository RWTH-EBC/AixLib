within AixLib.DataBase.Pumps.PumpPolynomialBased;
record Pump_DN30_H1_12 "Pump with head 1 to 11m and 10,7m^3/h volume flow (Wilo Stratos 30/1-12)"
 extends PumpBaseRecord(
    maxMinHeight=[
           0.00, 11.53,  0.800;
           0.41, 11.62,  0.832;
           0.83, 11.71,  0.865;
           1.24, 11.79,  0.897;
           1.66, 11.88,  0.929;
           2.07, 11.97,  0.944;
           2.49, 12.05,  0.825;
           2.90, 12.14,  0.706;
           3.32, 12.18,  0.587;
           3.73, 11.66,  0.467;
           4.15, 11.14,  0.000;
           4.56, 10.62,  0.000;
           4.98, 10.09,  0.000;
           5.39,  9.64,  0.000;
           5.81,  9.21,  0.000;
           6.22,  8.78,  0.000;
           6.63,  8.35,  0.000;
           7.05,  7.92,  0.000;
           7.46,  7.50,  0.000;
           7.88,  7.09,  0.000;
           8.29,  6.67,  0.000;
           8.71,  6.25,  0.000;
           9.12,  5.82,  0.000;
           9.54,  5.34,  0.000;
           9.95,  4.86,  0.000;
          10.37,  4.39,  0.000;
          10.78,  3.90,  0.000;
          11.20,  3.32,  0.000;
          11.61,  2.73,  0.000;
          12.03,  2.15,  0.000]
      "maximum and minimum boundaries of pump (Q,Hmax,Hmin)",
    maxMinSpeedCurves = [
           0.00, 4800, 1400;
           0.41, 4800, 1400;
           0.83, 4800, 1400;
           1.24, 4800, 1400;
           1.66, 4800, 1400;
           2.07, 4800, 1400;
           2.49, 4800, 1400;
           2.90, 4800, 1400;
           3.32, 4800, 1400;
           3.73, 4800, 1400;
           4.15, 4779, 1400;
           4.56, 4737, 1400;
           4.98, 4694, 1400;
           5.39, 4314, 1400;
           5.81, 4300, 1400;
           6.22, 4289, 1400;
           6.63, 4275, 1400;
           7.05, 4264, 1400;
           7.46, 4248, 1400;
           7.88, 4236, 1400;
           8.29, 4223, 1400;
           8.71, 4207, 1400;
           9.12, 4195, 1400;
           9.54, 4182, 1400;
           9.95, 4166, 1400;
          10.37, 4157, 1400;
          10.78, 4141, 1400;
          11.20, 4124, 1400;
          11.61, 4116, 1400;
          12.03, 4100, 1400]
      "maximum and minimum boundaries of pump speed (Q,nMax,nMin)",
    nMin=1400,
    nMax=4800,
    cHQN=[-1.01075e+00,  2.58792e-04,  5.13022e-07;
           0.00000e+00,  4.56878e-04, -9.67357e-08;
          -1.50772e-01,  1.86098e-05,  0.00000e+00]
       "coefficients for H = f(Q,N)",
    cPQN=[1.58007e-01,  4.23265e-02, -3.56103e-05,  1.34721e-08, -1.37308e-12;
           4.20861e+01, -3.59259e-02,  7.41197e-06,  0.00000e+00,  0.00000e+00;
          -8.00976e+00,  8.90865e-03, -1.66637e-06,  0.00000e+00,  0.00000e+00;
          -6.17870e-01,  0.00000e+00,  3.18511e-08,  0.00000e+00,  0.00000e+00]
       "coefficients for P = f(Q,N)");

  annotation(preferredView="text", Documentation(revisions="<html>
<ul>
<li>2023-10-19 by Sarah Leidolf:<br>Generated</li>
</ul>
</html>", info="<html>
<h4>Measurement and Regression Data</h4>
<p>Dimension estimate, but inaccuracies occur due to lack of information in the data sheets.</p>
<p>Espacially because of missing information of actual speed.</p>
<p><br><img src=\"modelica://AixLib/Resources/Images/DataBase/Pumps/PumpsPolynomialBased/Pump_DN30_H1_12.png\"/> </p>
<p>cHQN:</p>
<p><span style=\"font-family: Courier New;\">-1.01075e+00, 2.58792e-04, 5.13022e-07;</span></p>
<p><span style=\"font-family: Courier New;\">0.00000e+00, 4.56878e-04, -9.67357e-08;</span></p>
<p><span style=\"font-family: Courier New;\">-1.50772e-01, 1.86098e-05, 0.00000e+00</span></p>
<p>cPQN:</p>
<p><span style=\"font-family: Courier New;\">1.58007e-01, 4.23265e-02, -3.56103e-05, 1.34721e-08, -1.37308e-12;</span></p>
<p><span style=\"font-family: Courier New;\">4.20861e+01, -3.59259e-02, 7.41197e-06, 0.00000e+00, 0.00000e+00;</span></p>
<p><span style=\"font-family: Courier New;\">-8.00976e+00, 8.90865e-03, -1.66637e-06, 0.00000e+00, 0.00000e+00;</span></p>
<p><span style=\"font-family: Courier New;\">-6.17870e-01, 0.00000e+00, 3.18511e-08, 0.00000e+00, 0.00000e+00</span></p>
</html>"));

end Pump_DN30_H1_12;
