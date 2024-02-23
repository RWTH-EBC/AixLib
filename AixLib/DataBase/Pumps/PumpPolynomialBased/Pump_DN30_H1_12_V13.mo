within AixLib.DataBase.Pumps.PumpPolynomialBased;
record Pump_DN30_H1_12_V13
  "Pump with head 1 to 12m and 13.5m^3/h volume flow"
  extends PumpBaseRecord(
    maxMinHeight=[
           0.00, 11.52,  0.979;
           0.47, 11.64,  0.999;
           0.93, 11.72,  1.010;
           1.40, 11.77,  1.004;
           1.86, 11.85,  0.959;
           2.33, 11.99,  0.897;
           2.79, 12.06,  0.780;
           3.26, 12.13,  0.642;
           3.72, 12.18,  0.409;
           4.19, 12.14,  0.197;
           4.65, 12.03,  0.000;
           5.12, 11.63,  0.000;
           5.58, 10.89,  0.000;
           6.05, 10.44,  0.000;
           6.51,  9.86,  0.000;
           6.98,  9.26,  0.000;
           7.44,  8.91,  0.000;
           7.91,  8.31,  0.000;
           8.37,  7.70,  0.000;
           8.84,  7.19,  0.000;
           9.30,  6.55,  0.000;
           9.77,  6.01,  0.000;
          10.23,  5.31,  0.000;
          10.70,  4.92,  0.000;
          11.16,  4.11,  0.000;
          11.63,  3.47,  0.000;
          12.09,  3.21,  0.000;
          12.56,  2.38,  0.000;
          13.02,  1.65,  0.000;
          13.49,  1.18,  0.000]
      "maximum and minimum boundaries of pump (Q,Hmax,Hmin)",
    maxMinSpeedCurves = [
           0.00, 4800, 1400;
           0.47, 4800, 1400;
           0.93, 4800, 1400;
           1.40, 4800, 1400;
           1.86, 4800, 1400;
           2.33, 4800, 1400;
           2.79, 4800, 1400;
           3.26, 4800, 1400;
           3.72, 4800, 1400;
           4.19, 4800, 1400;
           4.65, 4799, 1400;
           5.12, 4744, 1400;
           5.58, 4629, 1400;
           6.05, 4573, 1400;
           6.51, 4502, 1400;
           6.98, 4414, 1400;
           7.44, 4396, 1400;
           7.91, 4343, 1400;
           8.37, 4318, 1400;
           8.84, 4294, 1400;
           9.30, 4274, 1400;
           9.77, 4257, 1400;
          10.23, 4245, 1400;
          10.70, 4239, 1400;
          11.16, 4235, 1400;
          11.63, 4227, 1400;
          12.09, 4228, 1400;
          12.56, 4250, 1400;
          13.02, 4269, 1400;
          13.49, 4282, 1400]
      "maximum and minimum boundaries of pump speed (Q,nMax,nMin)",
    nMin=1400.0,
    nMax=4800.0,
    cHQN=[ 0.00000e+00,  0.00000e+00,  4.88348e-07;
           0.00000e+00,  1.15190e-04,  0.00000e+00;
          -8.00446e-02,  0.00000e+00,  0.00000e+00]
       "coefficients for H = f(Q,N)",
    cPQN=[ 2.53904e-05,  1.86083e-02, -9.28813e-06,  3.15573e-09, -1.57051e-13;
           0.00000e+00,  0.00000e+00,  1.43568e-06,  0.00000e+00,  0.00000e+00;
           0.00000e+00,  1.16467e-04,  0.00000e+00,  0.00000e+00,  0.00000e+00;
          -9.73911e-02,  0.00000e+00,  0.00000e+00,  0.00000e+00,  0.00000e+00]
       "coefficients for P = f(Q,N)");

  annotation(preferredView="text", Documentation(revisions="<html><ul>
  <li>2018-07-02 by Luca Vedda:<br/>
    Generated
  </li>
</ul>
</html>", info="<html>
<p>
  Pump for nominal pipe diameter of 30 mm, pump head range between 1 m
  and 12 m and maximum volume flow rate of 13.5 m³/h.
</p>
<h4>
  Measurement Data
</h4>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/DataBase/Pumps/PumpsPolynomialBased/Pump_DN30_H1_12_V13.png\"
  alt=\"Pump Characterisistcs\">
</p>
<p>
  cHQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  4.88348e-07;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 1.15190e-04,
  0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-8.00446e-02, 0.00000e+00,
  0.00000e+00</span>
</p>
<p>
  cPQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">2.53904e-05, 1.86083e-02,
  -9.28813e-06, 3.15573e-09, -1.57051e-13;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  1.43568e-06, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 1.16467e-04,
  0.00000e+00, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-9.73911e-02, 0.00000e+00,
  0.00000e+00, 0.00000e+00, 0.00000e+00</span>
</p>
</html>"));
end Pump_DN30_H1_12_V13;
