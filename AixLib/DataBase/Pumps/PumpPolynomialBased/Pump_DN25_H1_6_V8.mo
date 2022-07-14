within AixLib.DataBase.Pumps.PumpPolynomialBased;
record Pump_DN25_H1_6_V8
  "Pump with head 1 to 6m and 8.87m^3/h volume flow"
  extends PumpBaseRecord(
    maxMinHeight=[
           0.00,  7.53,  1.123;
           0.31,  7.59,  1.139;
           0.61,  7.62,  1.144;
           0.92,  7.65,  1.144;
           1.22,  7.65,  1.133;
           1.53,  7.66,  1.095;
           1.84,  7.65,  1.031;
           2.14,  7.64,  0.953;
           2.45,  7.64,  0.862;
           2.75,  7.64,  0.758;
           3.06,  7.44,  0.623;
           3.37,  7.02,  0.483;
           3.67,  6.62,  0.306;
           3.98,  6.31,  0.000;
           4.28,  5.82,  0.000;
           4.59,  5.38,  0.000;
           4.90,  5.15,  0.000;
           5.20,  4.74,  0.000;
           5.51,  4.43,  0.000;
           5.81,  4.02,  0.000;
           6.12,  3.70,  0.000;
           6.43,  3.40,  0.000;
           6.73,  3.06,  0.000;
           7.04,  2.60,  0.000;
           7.34,  2.30,  0.000;
           7.65,  1.92,  0.000;
           7.96,  1.58,  0.000;
           8.26,  1.28,  0.000;
           8.57,  0.93,  0.000;
           8.87,  0.54,  0.000]
      "maximum and minimum boundaries of pump (Q,Hmax,Hmin)",
    maxMinSpeedCurves = [
           0.00, 3700, 1400;
           0.31, 3700, 1400;
           0.61, 3700, 1400;
           0.92, 3700, 1400;
           1.22, 3700, 1400;
           1.53, 3700, 1400;
           1.84, 3700, 1400;
           2.14, 3700, 1400;
           2.45, 3700, 1400;
           2.75, 3699, 1400;
           3.06, 3658, 1400;
           3.37, 3570, 1400;
           3.67, 3489, 1400;
           3.98, 3438, 1400;
           4.28, 3366, 1400;
           4.59, 3305, 1400;
           4.90, 3277, 1400;
           5.20, 3231, 1400;
           5.51, 3201, 1400;
           5.81, 3168, 1400;
           6.12, 3152, 1400;
           6.43, 3137, 1400;
           6.73, 3126, 1400;
           7.04, 3112, 1400;
           7.34, 3110, 1400;
           7.65, 3103, 1400;
           7.96, 3094, 1400;
           8.26, 3101, 1400;
           8.57, 3103, 1400;
           8.87, 3100, 1400]
      "maximum and minimum boundaries of pump speed (Q,nMax,nMin)",
    nMin=1400.0,
    nMax=3700.0,
    cHQN=[ 0.00000e+00,  0.00000e+00,  5.42547e-07;
           0.00000e+00,  9.73525e-05,  0.00000e+00;
          -9.44653e-02,  0.00000e+00,  0.00000e+00]
       "coefficients for H = f(Q,N)",
    cPQN=[ 1.85342e-05,  1.14960e-02, -9.47363e-06,  4.22744e-09, -3.82959e-13;
           0.00000e+00,  0.00000e+00,  1.53784e-06,  0.00000e+00,  0.00000e+00;
           0.00000e+00,  1.22375e-04,  0.00000e+00,  0.00000e+00,  0.00000e+00;
          -1.07729e-01,  0.00000e+00,  0.00000e+00,  0.00000e+00,  0.00000e+00]
       "coefficients for P = f(Q,N)");

  annotation(preferredView="text", Documentation(revisions="<html><ul>
  <li>2018-09-28 by Luca Vedda:<br/>
    Generated
  </li>
</ul>
</html>", info="<html>
<p>
  Pump for nominal pipe diameter of 25 mm, pump head range between 1 m
  and 6 m and maximum volume flow rate of 8.87 m³/h.
</p>
<h4>
  Measurement Data
</h4>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/DataBase/Pumps/PumpsPolynomialBased/Pump_DN25_H1_6_V8.png\"
  alt=\"Pump Characterisistcs\">
</p>
<p>
  cHQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  5.42547e-07;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 9.73525e-05,
  0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-9.44653e-02, 0.00000e+00,
  0.00000e+00</span>
</p>
<p>
  cPQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">1.85342e-05, 1.14960e-02,
  -9.47363e-06, 4.22744e-09, -3.82959e-13;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  1.53784e-06, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 1.22375e-04,
  0.00000e+00, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-1.07729e-01, 0.00000e+00,
  0.00000e+00, 0.00000e+00, 0.00000e+00</span>
</p>
</html>"));
end Pump_DN25_H1_6_V8;
