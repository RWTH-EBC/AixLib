within AixLib.DataBase.Pumps.PumpPolynomialBased;
record Pump_DN65_H1_16_V26 "Pump with head 1 to 16m and 26.23m^3/h volume flow"
  extends PumpBaseRecord(
    maxMinHeight=[
           0.00,  1.92,  1.315;
           0.90,  1.92,  1.326;
           1.81,  1.92,  1.327;
           2.71,  1.92,  1.336;
           3.62,  1.92,  1.326;
           4.52,  1.92,  1.315;
           5.43,  1.92,  1.326;
           6.33,  1.92,  1.320;
           7.24,  1.92,  1.326;
           8.14,  1.92,  1.295;
           9.05,  1.92,  1.269;
           9.95,  1.92,  1.236;
          10.85,  1.92,  1.195;
          11.76,  1.92,  1.133;
          12.66,  1.92,  1.091;
          13.57,  1.92,  1.041;
          14.47,  1.86,  0.975;
          15.38,  1.80,  0.887;
          16.28,  1.74,  0.785;
          17.19,  1.65,  0.688;
          18.09,  1.58,  0.612;
          18.99,  1.49,  0.510;
          19.90,  1.40,  0.360;
          20.80,  1.30,  0.000;
          21.71,  1.16,  0.000;
          22.61,  1.06,  0.000;
          23.52,  0.95,  0.000;
          24.42,  0.70,  0.000;
          25.33,  0.42,  0.000;
          26.23,  0.47,  0.000]
      "maximum and minimum boundaries of pump (Q,Hmax,Hmin)",
    maxMinSpeedCurves = [
           0.00, 1200,  950;
           0.90, 1200,  950;
           1.81, 1200,  950;
           2.71, 1200,  950;
           3.62, 1200,  950;
           4.52, 1200,  950;
           5.43, 1200,  950;
           6.33, 1200,  950;
           7.24, 1200,  950;
           8.14, 1200,  950;
           9.05, 1200,  950;
           9.95, 1200,  950;
          10.85, 1200,  950;
          11.76, 1200,  950;
          12.66, 1200,  950;
          13.57, 1200,  950;
          14.47, 1200,  950;
          15.38, 1200,  950;
          16.28, 1200,  950;
          17.19, 1200,  950;
          18.09, 1200,  950;
          18.99, 1200,  950;
          19.90, 1200,  950;
          20.80, 1200,  950;
          21.71, 1200,  950;
          22.61, 1200,  950;
          23.52, 1200,  950;
          24.42, 1200,  950;
          25.33, 1200,  950;
          26.23, 1200,  950]
      "maximum and minimum boundaries of pump speed (Q,nMax,nMin)",
    nMin=950.0,
    nMax=1200.0,
    cHQN=[ 0.00000e+00,  0.00000e+00,  1.38419e-06;
           0.00000e+00,  4.69154e-05,  0.00000e+00;
          -4.44085e-03,  0.00000e+00,  0.00000e+00]
       "coefficients for H = f(Q,N)",
    cPQN=[ 4.29488e-16,  3.38555e-13,  2.38276e-10,  1.26342e-07, -6.75873e-11;
           0.00000e+00,  0.00000e+00,  3.44640e-06,  0.00000e+00,  0.00000e+00;
           0.00000e+00,  6.63336e-05,  0.00000e+00,  0.00000e+00,  0.00000e+00;
          -4.81313e-03,  0.00000e+00,  0.00000e+00,  0.00000e+00,  0.00000e+00]
       "coefficients for P = f(Q,N)");

  annotation(preferredView="text", Documentation(revisions="<html><ul>
  <li>2018-09-21 by Luca Vedda:<br/>
    Generated
  </li>
</ul>
</html>", info="<html>
<p>
  Pump for nominal pipe diameter of 65 mm, pump head range between 1 m
  and 16 m and maximum volume flow rate of 26.23 m³/h.
</p>
<h4>
  Measurement Data
</h4>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/DataBase/Pumps/PumpsPolynomialBased/Pump_DN65_H1_16_V26.png\"
  alt=\"Pump Characterisistcs\">
</p>
<p>
  cHQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  1.38419e-06;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 4.69154e-05,
  0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-4.44085e-03, 0.00000e+00,
  0.00000e+00</span>
</p>
<p>
  cPQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">4.29488e-16, 3.38555e-13,
  2.38276e-10, 1.26342e-07, -6.75873e-11;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  3.44640e-06, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 6.63336e-05,
  0.00000e+00, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-4.81313e-03, 0.00000e+00,
  0.00000e+00, 0.00000e+00, 0.00000e+00</span>
</p>
</html>"));
end Pump_DN65_H1_16_V26;
