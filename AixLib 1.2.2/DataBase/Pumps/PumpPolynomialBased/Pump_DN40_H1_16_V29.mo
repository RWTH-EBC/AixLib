within AixLib.DataBase.Pumps.PumpPolynomialBased;
record Pump_DN40_H1_16_V29 "Pump with head 1 to 16m and 28.9m^3/h volume flow"
  extends PumpBaseRecord(
    maxMinHeight=[
           0.00, 17.21,  1.244;
           1.00, 17.31,  1.264;
           1.99, 17.33,  1.264;
           2.99, 17.23,  1.274;
           3.99, 17.30,  1.252;
           4.98, 16.92,  1.208;
           5.98, 16.26,  1.130;
           6.98, 15.48,  1.006;
           7.97, 14.73,  0.877;
           8.97, 13.97,  0.738;
           9.97, 13.33,  0.530;
          10.96, 12.80,  0.000;
          11.96, 12.12,  0.000;
          12.96, 11.53,  0.000;
          13.95, 10.89,  0.000;
          14.95, 10.35,  0.000;
          15.95,  9.92,  0.000;
          16.94,  9.40,  0.000;
          17.94,  8.95,  0.000;
          18.94,  8.68,  0.000;
          19.93,  8.09,  0.000;
          20.93,  7.74,  0.000;
          21.93,  7.43,  0.000;
          22.92,  6.88,  0.000;
          23.92,  6.46,  0.000;
          24.92,  5.97,  0.000;
          25.91,  5.43,  0.000;
          26.91,  4.88,  0.000;
          27.91,  4.34,  0.000;
          28.90,  3.97,  0.000]
      "maximum and minimum boundaries of pump (Q,Hmax,Hmin)",
    maxMinSpeedCurves = [
           0.00, 3500,  950;
           1.00, 3500,  950;
           1.99, 3500,  950;
           2.99, 3500,  950;
           3.99, 3500,  950;
           4.98, 3465,  950;
           5.98, 3401,  950;
           6.98, 3313,  950;
           7.97, 3219,  950;
           8.97, 3143,  950;
           9.97, 3052,  950;
          10.96, 2997,  950;
          11.96, 2928,  950;
          12.96, 2864,  950;
          13.95, 2821,  950;
          14.95, 2755,  950;
          15.95, 2738,  950;
          16.94, 2720,  950;
          17.94, 2706,  950;
          18.94, 2687,  950;
          19.93, 2674,  950;
          20.93, 2665,  950;
          21.93, 2656,  950;
          22.92, 2652,  950;
          23.92, 2649,  950;
          24.92, 2644,  950;
          25.91, 2641,  950;
          26.91, 2635,  950;
          27.91, 2624,  950;
          28.90, 2615,  950]
      "maximum and minimum boundaries of pump speed (Q,nMax,nMin)",
    nMin=950.0,
    nMax=3500.0,
    cHQN=[ 0.00000e+00,  0.00000e+00,  1.37376e-06;
           0.00000e+00,  5.53270e-05,  0.00000e+00;
          -1.16039e-02,  0.00000e+00,  0.00000e+00]
       "coefficients for H = f(Q,N)",
    cPQN=[-2.01304e+01,  7.18841e-02, -3.93834e-05,  2.34207e-08, -1.61762e-12;
           0.00000e+00,  0.00000e+00,  3.13936e-06,  0.00000e+00,  0.00000e+00;
           0.00000e+00,  1.94557e-04,  0.00000e+00,  0.00000e+00,  0.00000e+00;
          -2.08205e-02,  0.00000e+00,  0.00000e+00,  0.00000e+00,  0.00000e+00]
       "coefficients for P = f(Q,N)");

  annotation(preferredView="text", Documentation(revisions="<html><ul>
  <li>2018-07-02 by Luca Vedda:<br/>
    Generated
  </li>
</ul>
</html>", info="<html>
<p>
  Pump for nominal pipe diameter of 40 mm, pump head range between 1 m
  and 16 m and maximum volume flow rate of 28.9 m³/h.
</p>
<h4>
  Measurement Data
</h4>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/DataBase/Pumps/PumpsPolynomialBased/Pump_DN40_H1_16_V29.png\"
  alt=\"Pump Characterisistcs\">
</p>
<p>
  cHQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  1.37376e-06;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 5.53270e-05,
  0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-1.16039e-02, 0.00000e+00,
  0.00000e+00</span>
</p>
<p>
  cPQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">-2.01304e+01, 7.18841e-02,
  -3.93834e-05, 2.34207e-08, -1.61762e-12;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  3.13936e-06, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 1.94557e-04,
  0.00000e+00, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-2.08205e-02, 0.00000e+00,
  0.00000e+00, 0.00000e+00, 0.00000e+00</span>
</p>
</html>"));
end Pump_DN40_H1_16_V29;
