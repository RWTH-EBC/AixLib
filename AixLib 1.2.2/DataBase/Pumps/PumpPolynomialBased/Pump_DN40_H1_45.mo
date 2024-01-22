within AixLib.DataBase.Pumps.PumpPolynomialBased;
record Pump_DN40_H1_45 "Pump with head 1 to 45m and 47.5m^3/h volume flow"
  extends PumpBaseRecord(
    maxMinHeight=[
           0.00, 46.52,  0.498;
           1.64, 46.26,  0.473;
           3.28, 45.85,  0.367;
           4.91, 45.62,  0.144;
           6.55, 45.32,  0.000;
           8.19, 44.98,  0.000;
           9.83, 44.42,  0.000;
          11.47, 43.76,  0.000;
          13.10, 43.11,  0.000;
          14.74, 42.35,  0.000;
          16.38, 41.62,  0.000;
          18.02, 40.78,  0.000;
          19.66, 39.81,  0.000;
          21.29, 38.73,  0.000;
          22.93, 37.56,  0.000;
          24.57, 36.50,  0.000;
          26.21, 35.34,  0.000;
          27.84, 33.97,  0.000;
          29.48, 32.47,  0.000;
          31.12, 30.93,  0.000;
          32.76, 29.32,  0.000;
          34.40, 27.62,  0.000;
          36.03, 25.90,  0.000;
          37.67, 23.96,  0.000;
          39.31, 21.69,  0.000;
          40.95, 19.40,  0.000;
          42.59, 16.82,  0.000;
          44.22, 13.65,  0.000;
          45.86, 10.55,  0.000;
          47.50,  7.49,  0.000]
      "maximum and minimum boundaries of pump (Q,Hmax,Hmin)",
    maxMinSpeedCurves = [
           0.00, 4850,  500;
           1.64, 4850,  500;
           3.28, 4850,  500;
           4.91, 4850,  500;
           6.55, 4850,  500;
           8.19, 4850,  500;
           9.83, 4850,  500;
          11.47, 4850,  500;
          13.10, 4850,  500;
          14.74, 4850,  500;
          16.38, 4850,  500;
          18.02, 4850,  500;
          19.66, 4850,  500;
          21.29, 4850,  500;
          22.93, 4850,  500;
          24.57, 4850,  500;
          26.21, 4850,  500;
          27.84, 4850,  500;
          29.48, 4850,  500;
          31.12, 4850,  500;
          32.76, 4850,  500;
          34.40, 4850,  500;
          36.03, 4850,  500;
          37.67, 4850,  500;
          39.31, 4850,  500;
          40.95, 4850,  500;
          42.59, 4850,  500;
          44.22, 4850,  500;
          45.86, 4850,  500;
          47.50, 4850,  500]
      "maximum and minimum boundaries of pump speed (Q,nMax,nMin)",
    nMin=500.0,
    nMax=4850.0,
    cHQN=[ 0.00000e+00,  0.00000e+00,  1.94791e-06;
           0.00000e+00,  8.44521e-06,  0.00000e+00;
          -1.67798e-02,  0.00000e+00,  0.00000e+00]
       "coefficients for H = f(Q,N)",
    cPQN=[ 3.71377e+01, -1.28941e-02,  3.53022e-05,  2.55435e-09,  7.06236e-13;
           0.00000e+00,  0.00000e+00,  4.29325e-06,  0.00000e+00,  0.00000e+00;
           0.00000e+00, -2.25316e-05,  0.00000e+00,  0.00000e+00,  0.00000e+00;
          -1.71349e-02,  0.00000e+00,  0.00000e+00,  0.00000e+00,  0.00000e+00]
       "coefficients for P = f(Q,N)");

  annotation(preferredView="text", Documentation(revisions="<html><ul>
  <li>2018-07-02 by Luca Vedda:<br/>
    Generated
  </li>
</ul>
</html>", info="<html>
<p>
  Pump for nominal pipe diameter of 40 mm, pump head range between 1 m
  and 45 m and maximum volume flow rate of 47.5 m³/h.
</p>
<h4>
  Measurement Data
</h4>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/DataBase/Pumps/PumpsPolynomialBased/Pump_DN40_H1_45.png\"
  alt=\"Pump Characterisistcs\">
</p>
<p>
  cHQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  1.94791e-06;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 8.44521e-06,
  0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-1.67798e-02, 0.00000e+00,
  0.00000e+00</span>
</p>
<p>
  cPQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">3.71377e+01, -1.28941e-02,
  3.53022e-05, 2.55435e-09, 7.06236e-13;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  4.29325e-06, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, -2.25316e-05,
  0.00000e+00, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-1.71349e-02, 0.00000e+00,
  0.00000e+00, 0.00000e+00, 0.00000e+00</span>
</p>
</html>"));
end Pump_DN40_H1_45;
