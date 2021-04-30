within AixLib.DataBase.Pumps.PumpPolynomialBased;
record Pump_DN25_H1_8_V9
  "Pump with head 1 to 8m and 9m^3/h volume flow"
  extends PumpBaseRecord(
    maxMinHeight=[
           0.00,  7.52,  1.122;
           0.31,  7.59,  1.142;
           0.62,  7.61,  1.142;
           0.93,  7.64,  1.142;
           1.24,  7.64,  1.132;
           1.55,  7.65,  1.084;
           1.86,  7.64,  1.028;
           2.17,  7.63,  0.931;
           2.49,  7.63,  0.845;
           2.80,  7.65,  0.755;
           3.11,  7.34,  0.603;
           3.42,  6.94,  0.389;
           3.73,  6.55,  0.228;
           4.04,  6.22,  0.173;
           4.35,  5.74,  0.173;
           4.66,  5.36,  0.173;
           4.97,  5.14,  0.173;
           5.28,  4.68,  0.173;
           5.59,  4.22,  0.173;
           5.90,  3.94,  0.173;
           6.21,  3.59,  0.173;
           6.52,  3.37,  0.173;
           6.84,  2.81,  0.173;
           7.15,  2.61,  0.173;
           7.46,  2.19,  0.173;
           7.77,  1.81,  0.173;
           8.08,  1.47,  0.173;
           8.39,  1.35,  0.173;
           8.70,  0.74,  0.173;
           9.01,  0.52,  0.173]
      "maximum and minimum boundaries of pump (Q,Hmax,Hmin)",
    maxMinSpeedCurves = [
           0.00, 3700, 1400;
           0.31, 3700, 1400;
           0.62, 3700, 1400;
           0.93, 3700, 1400;
           1.24, 3700, 1400;
           1.55, 3700, 1400;
           1.86, 3700, 1400;
           2.17, 3700, 1400;
           2.49, 3700, 1400;
           2.80, 3697, 1400;
           3.11, 3645, 1400;
           3.42, 3554, 1400;
           3.73, 3484, 1400;
           4.04, 3424, 1400;
           4.35, 3351, 1400;
           4.66, 3308, 1400;
           4.97, 3276, 1400;
           5.28, 3227, 1400;
           5.59, 3180, 1400;
           5.90, 3162, 1400;
           6.21, 3150, 1400;
           6.52, 3132, 1400;
           6.84, 3121, 1400;
           7.15, 3111, 1400;
           7.46, 3109, 1400;
           7.77, 3096, 1400;
           8.08, 3097, 1400;
           8.39, 3106, 1400;
           8.70, 3101, 1400;
           9.01, 3116, 1400]
      "maximum and minimum boundaries of pump speed (Q,nMax,nMin)",
    nMin=1400.0,
    nMax=3700.0,
    cHQN=[ 0.00000e+00,  0.00000e+00,  5.42119e-07;
           0.00000e+00,  9.63893e-05,  0.00000e+00;
          -9.40049e-02,  0.00000e+00,  0.00000e+00]
       "coefficients for H = f(Q,N)",
    cPQN=[ 1.86404e-05,  1.15429e-02, -9.54392e-06,  4.26061e-09, -3.87948e-13;
           0.00000e+00,  0.00000e+00,  1.54239e-06,  0.00000e+00,  0.00000e+00;
           0.00000e+00,  1.16734e-04,  0.00000e+00,  0.00000e+00,  0.00000e+00;
          -1.06179e-01,  0.00000e+00,  0.00000e+00,  0.00000e+00,  0.00000e+00]
       "coefficients for P = f(Q,N)");

  annotation(preferredView="text", Documentation(revisions="<html><ul>
  <li>2018-07-02 by Luca Vedda:<br/>
    Generated
  </li>
</ul>
</html>", info="<html>
<p>
  Pump for nominal pipe diameter of 25 mm, pump head range between 1 m
  and 8 m and maximum volume flow rate of 9 m³/h.
</p>
<h4>
  Measurement Data
</h4>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/DataBase/Pumps/PumpsPolynomialBased/Pump_DN25_H1_8_V9.png\"
  alt=\"Pump Characterisistcs\">
</p>
<p>
  cHQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  5.42119e-07;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 9.63893e-05,
  0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-9.40049e-02, 0.00000e+00,
  0.00000e+00</span>
</p>
<p>
  cPQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">1.86404e-05, 1.15429e-02,
  -9.54392e-06, 4.26061e-09, -3.87948e-13;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  1.54239e-06, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 1.16734e-04,
  0.00000e+00, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-1.06179e-01, 0.00000e+00,
  0.00000e+00, 0.00000e+00, 0.00000e+00</span>
</p>
</html>"));
end Pump_DN25_H1_8_V9;
