within AixLib.DataBase.Pumps.PumpPolynomialBased;
record Pump_DN65_H1_12_V48 "Pump with head 1 to 12m and 47.88m^3/h volume flow"
  extends PumpBaseRecord(
    maxMinHeight=[
           0.00, 12.43,  1.216;
           1.65, 12.44,  1.218;
           3.30, 12.52,  1.212;
           4.95, 12.55,  1.211;
           6.60, 12.54,  1.218;
           8.26, 12.52,  1.193;
           9.91, 12.48,  1.145;
          11.56, 12.37,  1.052;
          13.21, 11.82,  0.955;
          14.86, 11.25,  0.842;
          16.51, 10.70,  0.686;
          18.16, 10.26,  0.466;
          19.81,  9.90,  0.000;
          21.47,  9.34,  0.000;
          23.12,  8.86,  0.000;
          24.77,  8.31,  0.000;
          26.42,  7.88,  0.000;
          28.07,  7.37,  0.000;
          29.72,  6.86,  0.000;
          31.37,  6.45,  0.000;
          33.02,  5.95,  0.000;
          34.68,  5.47,  0.000;
          36.33,  5.02,  0.000;
          37.98,  4.59,  0.000;
          39.63,  4.13,  0.000;
          41.28,  3.63,  0.000;
          42.93,  3.06,  0.000;
          44.58,  2.55,  0.000;
          46.23,  1.98,  0.000;
          47.88,  1.42,  0.000]
      "maximum and minimum boundaries of pump (Q,Hmax,Hmin)",
    maxMinSpeedCurves = [
           0.00, 2900,  900;
           1.65, 2900,  900;
           3.30, 2900,  900;
           4.95, 2900,  900;
           6.60, 2900,  900;
           8.26, 2900,  900;
           9.91, 2900,  900;
          11.56, 2892,  900;
          13.21, 2829,  900;
          14.86, 2746,  900;
          16.51, 2680,  900;
          18.16, 2622,  900;
          19.81, 2565,  900;
          21.47, 2500,  900;
          23.12, 2452,  900;
          24.77, 2409,  900;
          26.42, 2376,  900;
          28.07, 2337,  900;
          29.72, 2303,  900;
          31.37, 2288,  900;
          33.02, 2260,  900;
          34.68, 2241,  900;
          36.33, 2228,  900;
          37.98, 2213,  900;
          39.63, 2199,  900;
          41.28, 2189,  900;
          42.93, 2183,  900;
          44.58, 2185,  900;
          46.23, 2189,  900;
          47.88, 2190,  900]
      "maximum and minimum boundaries of pump speed (Q,nMax,nMin)",
    nMin=900.0,
    nMax=2900.0,
    cHQN=[ 0.00000e+00,  0.00000e+00,  1.42201e-06;
           0.00000e+00,  4.24097e-05,  0.00000e+00;
          -4.17356e-03,  0.00000e+00,  0.00000e+00]
       "coefficients for H = f(Q,N)",
    cPQN=[-1.00813e+02,  3.06965e-01, -2.80623e-04,  1.33917e-07, -1.60284e-11;
           0.00000e+00,  0.00000e+00,  2.48789e-06,  0.00000e+00,  0.00000e+00;
           0.00000e+00,  1.74281e-04,  0.00000e+00,  0.00000e+00,  0.00000e+00;
          -7.79974e-03,  0.00000e+00,  0.00000e+00,  0.00000e+00,  0.00000e+00]
       "coefficients for P = f(Q,N)");

  annotation(preferredView="text", Documentation(revisions="<html><ul>
  <li>2018-07-02 by Luca Vedda:<br/>
    Generated
  </li>
</ul>
</html>", info="<html>
<p>
  Pump for nominal pipe diameter of 65 mm, pump head range between 1 m
  and 12 m and maximum volume flow rate of 47.88 m³/h.
</p>
<h4>
  Measurement Data
</h4>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/DataBase/Pumps/PumpsPolynomialBased/Pump_DN65_H1_12_V48.png\"
  alt=\"Pump Characterisistcs\">
</p>
<p>
  cHQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  1.42201e-06;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 4.24097e-05,
  0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-4.17356e-03, 0.00000e+00,
  0.00000e+00</span>
</p>
<p>
  cPQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">-1.00813e+02, 3.06965e-01,
  -2.80623e-04, 1.33917e-07, -1.60284e-11;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  2.48789e-06, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 1.74281e-04,
  0.00000e+00, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-7.79974e-03, 0.00000e+00,
  0.00000e+00, 0.00000e+00, 0.00000e+00</span>
</p>
</html>"));
end Pump_DN65_H1_12_V48;
