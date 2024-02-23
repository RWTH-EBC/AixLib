within AixLib.DataBase.Pumps.PumpPolynomialBased;
record Pump_DN65_H1_17 "Pump with head 1 to 17m and 67.9m^3/h volume flow"
  extends PumpBaseRecord(
    maxMinHeight=[
           0.00, 17.73,  0.443;
           2.34, 17.54,  0.416;
           4.68, 17.22,  0.378;
           7.02, 16.93,  0.319;
           9.37, 16.61,  0.214;
          11.71, 16.26,  0.000;
          14.05, 16.03,  0.000;
          16.39, 16.01,  0.000;
          18.73, 15.64,  0.000;
          21.07, 15.23,  0.000;
          23.41, 14.85,  0.000;
          25.76, 14.48,  0.000;
          28.10, 14.08,  0.000;
          30.44, 13.69,  0.000;
          32.78, 13.39,  0.000;
          35.12, 13.06,  0.000;
          37.46, 12.63,  0.000;
          39.80, 12.15,  0.000;
          42.15, 11.62,  0.000;
          44.49, 11.01,  0.000;
          46.83, 10.40,  0.000;
          49.17,  9.77,  0.000;
          51.51,  9.12,  0.000;
          53.85,  8.46,  0.000;
          56.19,  7.82,  0.000;
          58.54,  7.12,  0.000;
          60.88,  6.41,  0.000;
          63.22,  5.67,  0.000;
          65.56,  4.89,  0.000;
          67.90,  4.10,  0.000]
      "maximum and minimum boundaries of pump (Q,Hmax,Hmin)",
    maxMinSpeedCurves = [
           0.00, 3100,  500;
           2.34, 3100,  500;
           4.68, 3100,  500;
           7.02, 3100,  500;
           9.37, 3100,  500;
          11.71, 3100,  500;
          14.05, 3100,  500;
          16.39, 3100,  500;
          18.73, 3100,  500;
          21.07, 3100,  500;
          23.41, 3100,  500;
          25.76, 3100,  500;
          28.10, 3100,  500;
          30.44, 3100,  500;
          32.78, 3100,  500;
          35.12, 3100,  500;
          37.46, 3100,  500;
          39.80, 3100,  500;
          42.15, 3100,  500;
          44.49, 3100,  500;
          46.83, 3100,  500;
          49.17, 3100,  500;
          51.51, 3100,  500;
          53.85, 3100,  500;
          56.19, 3100,  500;
          58.54, 3100,  500;
          60.88, 3100,  500;
          63.22, 3100,  500;
          65.56, 3100,  500;
          67.90, 3100,  500]
      "maximum and minimum boundaries of pump speed (Q,nMax,nMin)",
    nMin=500.0,
    nMax=3100.0,
    cHQN=[ 0.00000e+00,  0.00000e+00,  1.80885e-06;
           0.00000e+00, -1.72302e-05,  0.00000e+00;
          -2.05883e-03,  0.00000e+00,  0.00000e+00]
       "coefficients for H = f(Q,N)",
    cPQN=[ 2.76556e-01,  8.91053e-02, -8.74245e-05,  8.08353e-08, -7.69701e-12;
           0.00000e+00,  0.00000e+00,  2.10171e-06,  0.00000e+00,  0.00000e+00;
           0.00000e+00,  3.88746e-05,  0.00000e+00,  0.00000e+00,  0.00000e+00;
          -4.44859e-03,  0.00000e+00,  0.00000e+00,  0.00000e+00,  0.00000e+00]
       "coefficients for P = f(Q,N)");

  annotation(preferredView="text", Documentation(revisions="<html><ul>
  <li>2018-07-02 by Luca Vedda:<br/>
    Generated
  </li>
</ul>
</html>", info="<html>
<p>
  Pump for nominal pipe diameter of 65 mm, pump head range between 1 m
  and 17 m and maximum volume flow rate of 67.9 m³/h.
</p>
<h4>
  Measurement Data
</h4>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/DataBase/Pumps/PumpsPolynomialBased/Pump_DN65_H1_17.png\"
  alt=\"Pump Characterisistcs\">
</p>
<p>
  cHQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  1.80885e-06;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, -1.72302e-05,
  0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-2.05883e-03, 0.00000e+00,
  0.00000e+00</span>
</p>
<p>
  cPQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">2.76556e-01, 8.91053e-02,
  -8.74245e-05, 8.08353e-08, -7.69701e-12;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  2.10171e-06, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 3.88746e-05,
  0.00000e+00, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-4.44859e-03, 0.00000e+00,
  0.00000e+00, 0.00000e+00, 0.00000e+00</span>
</p>
</html>"));
end Pump_DN65_H1_17;
