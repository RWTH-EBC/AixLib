within AixLib.DataBase.Pumps.PumpPolynomialBased;
record Pump_DN40_H1_12_V24 "Pump with head 1 to 12m and 24m^3/h volume flow"
  extends PumpBaseRecord(
    maxMinHeight=[
           0.00, 12.39,  1.142;
           0.83, 12.49,  1.179;
           1.65, 12.54,  1.183;
           2.48, 12.70,  1.175;
           3.31, 12.82,  1.165;
           4.13, 12.83,  1.086;
           4.96, 12.86,  0.958;
           5.79, 12.79,  0.795;
           6.61, 12.83,  0.616;
           7.44, 12.81,  0.418;
           8.27, 12.79,  0.000;
           9.09, 12.74,  0.000;
           9.92, 12.70,  0.000;
          10.75, 12.29,  0.000;
          11.57, 11.67,  0.000;
          12.40, 11.08,  0.000;
          13.23, 10.51,  0.000;
          14.05,  9.91,  0.000;
          14.88,  9.41,  0.000;
          15.71,  8.59,  0.000;
          16.53,  7.90,  0.000;
          17.36,  7.47,  0.000;
          18.19,  7.08,  0.000;
          19.01,  6.50,  0.000;
          19.84,  5.68,  0.000;
          20.67,  5.06,  0.000;
          21.49,  4.58,  0.000;
          22.32,  3.91,  0.000;
          23.15,  3.44,  0.000;
          23.97,  2.78,  0.000]
      "maximum and minimum boundaries of pump (Q,Hmax,Hmin)",
    maxMinSpeedCurves = [
           0.00, 4600, 1400;
           0.83, 4600, 1400;
           1.65, 4600, 1400;
           2.48, 4600, 1400;
           3.31, 4600, 1400;
           4.13, 4600, 1400;
           4.96, 4600, 1400;
           5.79, 4600, 1400;
           6.61, 4600, 1400;
           7.44, 4600, 1400;
           8.27, 4600, 1400;
           9.09, 4600, 1400;
           9.92, 4597, 1400;
          10.75, 4547, 1400;
          11.57, 4471, 1400;
          12.40, 4409, 1400;
          13.23, 4361, 1400;
          14.05, 4326, 1400;
          14.88, 4303, 1400;
          15.71, 4266, 1400;
          16.53, 4234, 1400;
          17.36, 4222, 1400;
          18.19, 4207, 1400;
          19.01, 4188, 1400;
          19.84, 4185, 1400;
          20.67, 4188, 1400;
          21.49, 4193, 1400;
          22.32, 4198, 1400;
          23.15, 4204, 1400;
          23.97, 4204, 1400]
      "maximum and minimum boundaries of pump speed (Q,nMax,nMin)",
    nMin=1400.0,
    nMax=4600.0,
    cHQN=[ 0.00000e+00,  0.00000e+00,  5.73723e-07;
           0.00000e+00,  6.28260e-05,  0.00000e+00;
          -2.41203e-02,  0.00000e+00,  0.00000e+00]
       "coefficients for H = f(Q,N)",
    cPQN=[ 1.88139e-05,  1.23610e-02,  4.55839e-07,  1.72215e-09,  1.78291e-13;
           0.00000e+00,  0.00000e+00,  1.09900e-06,  0.00000e+00,  0.00000e+00;
           0.00000e+00,  1.89239e-04,  0.00000e+00,  0.00000e+00,  0.00000e+00;
          -4.07739e-02,  0.00000e+00,  0.00000e+00,  0.00000e+00,  0.00000e+00]
       "coefficients for P = f(Q,N)");

  annotation(preferredView="text", Documentation(revisions="<html><ul>
  <li>2018-07-02 by Luca Vedda:<br/>
    Generated
  </li>
</ul>
</html>", info="<html>
<p>
  Pump for nominal pipe diameter of 40 mm, pump head range between 1 m
  and 12 m and maximum volume flow rate of 24 m³/h.
</p>
<h4>
  Measurement Data
</h4>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/DataBase/Pumps/PumpsPolynomialBased/Pump_DN40_H1_12_V24.png\"
  alt=\"Pump Characterisistcs\">
</p>
<p>
  cHQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  5.73723e-07;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 6.28260e-05,
  0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-2.41203e-02, 0.00000e+00,
  0.00000e+00</span>
</p>
<p>
  cPQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">1.88139e-05, 1.23610e-02,
  4.55839e-07, 1.72215e-09, 1.78291e-13;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  1.09900e-06, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 1.89239e-04,
  0.00000e+00, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-4.07739e-02, 0.00000e+00,
  0.00000e+00, 0.00000e+00, 0.00000e+00</span>
</p>
</html>"));
end Pump_DN40_H1_12_V24;
