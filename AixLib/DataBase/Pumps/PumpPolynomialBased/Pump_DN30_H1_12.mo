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
           3.32, 4798, 1400;
           3.73, 4773, 1400;
           4.15, 4747, 1400;
           4.56, 4722, 1400;
           4.98, 4696, 1400;
           5.39, 4662, 1400;
           5.81, 4625, 1400;
           6.22, 4588, 1400;
           6.63, 4550, 1400;
           7.05, 4514, 1400;
           7.46, 4480, 1400;
           7.88, 4447, 1400;
           8.29, 4413, 1400;
           8.71, 4379, 1400;
           9.12, 4345, 1400;
           9.54, 4309, 1400;
           9.95, 4274, 1400;
          10.37, 4238, 1400;
          10.78, 4202, 1400;
          11.20, 4168, 1400;
          11.61, 4134, 1400;
          12.03, 4100, 1400]
      "maximum and minimum boundaries of pump speed (Q,nMax,nMin)",
    nMin=1400,
    nMax=4800,
    cHQN=[0.00000e+00,  0.00000e+00,  5.07080e-07;
           0.00000e+00,  6.15992e-05,  0.00000e+00;
          -6.58190e-02,  0.00000e+00,  0.00000e+00]
       "coefficients for H = f(Q,N)",
    cPQN=[4.06360e-05,  2.77185e-02, -2.02099e-05,  8.49238e-09, -8.67775e-13;
           0.00000e+00,  0.00000e+00,  1.21688e-06,  0.00000e+00,  0.00000e+00;
           0.00000e+00,  6.87022e-06,  0.00000e+00,  0.00000e+00,  0.00000e+00;
          -3.71130e-02,  0.00000e+00,  0.00000e+00,  0.00000e+00,  0.00000e+00]
       "coefficients for P = f(Q,N)");

  annotation(preferredView="text", Documentation(revisions="<html>
<ul>
<li>2023-10-19 by Sarah Leidolf:<br>Generated</li>
</ul>
</html>", info="<html>
<h4>Measurement and Regression Data</h4>
<p>Dimension estimate, but inaccuracies occur due to lack of information in the data sheets.</p>
<p>Espacially because of missing information of upper and lower limit of pump speed.</p>
<p><br><img src=\"modelica://AixLib/Resources/Images/DataBase/Pumps/PumpsPolynomialBased/Pump_DN30_H1_12.png\"/> </p>
<p>cHQN:</p>
<p><span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00, 5.07080e-07;</span></p>
<p><span style=\"font-family: Courier New;\">0.00000e+00, 6.15992e-05, 0.00000e+00;</span></p>
<p><span style=\"font-family: Courier New;\">-6.58190e-02, 0.00000e+00, 0.00000e+00</span></p>
<p>cPQN:</p>
<p><span style=\"font-family: Courier New;\">4.06360e-05, 2.77185e-02, -2.02099e-05, 8.49238e-09, -8.67775e-13;</span></p>
<p><span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00, 1.21688e-06, 0.00000e+00, 0.00000e+00;</span></p>
<p><span style=\"font-family: Courier New;\">0.00000e+00, 6.87022e-06, 0.00000e+00, 0.00000e+00, 0.00000e+00;</span></p>
<p><span style=\"font-family: Courier New;\">-3.71130e-02, 0.00000e+00, 0.00000e+00, 0.00000e+00, 0.00000e+00</span></p>
</html>"));

end Pump_DN30_H1_12;
