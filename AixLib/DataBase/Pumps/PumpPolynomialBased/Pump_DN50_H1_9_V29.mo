within AixLib.DataBase.Pumps.PumpPolynomialBased;
record Pump_DN50_H1_9_V29 "Pump with head 1 to 9m and 29.24m^3/h volume flow"
  extends PumpBaseRecord(
    maxMinHeight=[
           0.00, 11.57,  1.132;
           1.01, 11.80,  1.130;
           2.02, 11.39,  1.132;
           3.02, 11.69,  1.110;
           4.03, 11.46,  1.101;
           5.04, 12.03,  1.064;
           6.05, 11.33,  1.001;
           7.06, 10.97,  0.917;
           8.07, 11.64,  0.795;
           9.07, 10.80,  0.661;
          10.08, 10.56,  0.459;
          11.09, 10.11,  0.000;
          12.10,  9.89,  0.000;
          13.11,  9.35,  0.000;
          14.11,  8.89,  0.000;
          15.12,  8.44,  0.000;
          16.13,  8.01,  0.000;
          17.14,  7.64,  0.000;
          18.15,  7.24,  0.000;
          19.16,  6.85,  0.000;
          20.16,  6.51,  0.000;
          21.17,  6.11,  0.000;
          22.18,  5.64,  0.000;
          23.19,  5.18,  0.000;
          24.20,  4.75,  0.000;
          25.20,  4.15,  0.000;
          26.21,  3.78,  0.000;
          27.22,  3.26,  0.000;
          28.23,  2.76,  0.000;
          29.24,  2.48,  0.000]
      "maximum and minimum boundaries of pump (Q,Hmax,Hmin)",
    maxMinSpeedCurves = [
           0.00, 4600, 1400;
           1.01, 4600, 1400;
           2.02, 4485, 1400;
           3.02, 4534, 1400;
           4.03, 4489, 1400;
           5.04, 4600, 1400;
           6.05, 4474, 1400;
           7.06, 4400, 1400;
           8.07, 4525, 1400;
           9.07, 4422, 1400;
          10.08, 4347, 1400;
          11.09, 4253, 1400;
          12.10, 4219, 1400;
          13.11, 4113, 1400;
          14.11, 4050, 1400;
          15.12, 3994, 1400;
          16.13, 3948, 1400;
          17.14, 3898, 1400;
          18.15, 3863, 1400;
          19.16, 3827, 1400;
          20.16, 3818, 1400;
          21.17, 3789, 1400;
          22.18, 3782, 1400;
          23.19, 3769, 1400;
          24.20, 3770, 1400;
          25.20, 3770, 1400;
          26.21, 3775, 1400;
          27.22, 3793, 1400;
          28.23, 3797, 1400;
          29.24, 3821, 1400]
      "maximum and minimum boundaries of pump speed (Q,nMax,nMin)",
    nMin=1400.0,
    nMax=4600.0,
    cHQN=[ 0.00000e+00,  0.00000e+00,  5.39062e-07;
           0.00000e+00,  4.08623e-05,  0.00000e+00;
          -1.14430e-02,  0.00000e+00,  0.00000e+00]
       "coefficients for H = f(Q,N)",
    cPQN=[ 3.52564e-05,  2.35037e-02, -1.17407e-05,  6.50363e-09, -2.40575e-13;
           0.00000e+00,  0.00000e+00,  1.12838e-06,  0.00000e+00,  0.00000e+00;
           0.00000e+00,  1.47693e-04,  0.00000e+00,  0.00000e+00,  0.00000e+00;
          -2.42125e-02,  0.00000e+00,  0.00000e+00,  0.00000e+00,  0.00000e+00]
       "coefficients for P = f(Q,N)");

  annotation(preferredView="text", Documentation(revisions="<html><ul>
  <li>2018-07-02 by Luca Vedda:<br/>
    Generated
  </li>
</ul>
</html>", info="<html>
<p>
  Pump for nominal pipe diameter of 50 mm, pump head range between 1 m
  and 9 m and maximum volume flow rate of 29.24 m³/h.
</p>
<h4>
  Measurement Data
</h4>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/DataBase/Pumps/PumpsPolynomialBased/Pump_DN50_H1_9_V29.png\"
  alt=\"Pump Characterisistcs\">
</p>
<p>
  cHQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  5.39062e-07;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 4.08623e-05,
  0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-1.14430e-02, 0.00000e+00,
  0.00000e+00</span>
</p>
<p>
  cPQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">3.52564e-05, 2.35037e-02,
  -1.17407e-05, 6.50363e-09, -2.40575e-13;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  1.12838e-06, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 1.47693e-04,
  0.00000e+00, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-2.42125e-02, 0.00000e+00,
  0.00000e+00, 0.00000e+00, 0.00000e+00</span>
</p>
</html>"));
end Pump_DN50_H1_9_V29;
