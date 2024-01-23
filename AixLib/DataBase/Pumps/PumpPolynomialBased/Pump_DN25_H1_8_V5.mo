within AixLib.DataBase.Pumps.PumpPolynomialBased;
record Pump_DN25_H1_8_V5
  "Pump with head 1 to 8m and 5m^3/h volume flow"
  extends PumpBaseRecord(
    maxMinHeight=[
           0.00,  7.93,  0.086;
           0.25,  7.93,  0.086;
           0.50,  7.89,  0.051;
           0.75,  7.84,  0.000;
           1.00,  7.77,  0.000;
           1.25,  7.70,  0.000;
           1.50,  7.33,  0.000;
           1.75,  6.97,  0.000;
           2.00,  6.52,  0.000;
           2.25,  6.03,  0.000;
           2.50,  5.18,  0.000;
           2.75,  4.79,  0.000;
           3.00,  4.25,  0.000;
           3.25,  3.51,  0.000;
           3.50,  3.18,  0.000;
           3.75,  2.84,  0.000;
           4.00,  2.32,  0.000;
           4.25,  1.88,  0.000;
           4.50,  1.43,  0.000;
           4.75,  1.07,  0.000;
           5.00,  0.63,  0.000]
      "maximum and minimum boundaries of pump (Q,Hmax,Hmin)",
    maxMinSpeedCurves = [
           0.00, 4740,  515;
           0.25, 4740,  515;
           0.50, 4722,  510;
           0.75, 4711,  527;
           1.00, 4699,  527;
           1.25, 4696,  527;
           1.50, 4611,  527;
           1.75, 4536,  527;
           2.00, 4439,  527;
           2.25, 4340,  527;
           2.50, 4128,  527;
           2.75, 4075,  527;
           3.00, 3981,  527;
           3.25, 3823,  527;
           3.50, 3814,  527;
           3.75, 3812,  527;
           4.00, 3760,  527;
           4.25, 3744,  527;
           4.50, 3732,  527;
           4.75, 3762,  527;
           5.00, 3773,  527]
      "maximum and minimum boundaries of pump speed (Q,nMax,nMin)",
    nMin=500.0,
    nMax=4800.0,
    cHQN=[ 0.00000e+00,  0.00000e+00,  3.50629e-07;
           0.00000e+00,  5.18860e-05,  0.00000e+00;
          -2.13513e-01,  0.00000e+00,  0.00000e+00]
       "coefficients for H = f(Q,N)",
    cPQN=[ 6.63879e-01,  3.05941e-03, -1.79749e-06,  8.16507e-10, -4.46635e-14;
           0.00000e+00,  0.00000e+00,  1.30360e-06,  0.00000e+00,  0.00000e+00;
           0.00000e+00, -1.23850e-04,  0.00000e+00,  0.00000e+00,  0.00000e+00;
          -2.27780e-01,  0.00000e+00,  0.00000e+00,  0.00000e+00,  0.00000e+00]
       "coefficients for P = f(Q,N)");

  annotation(preferredView="text", Documentation(revisions="<html><ul>
  <li>2018-07-02 by Luca Vedda:<br/>
    Generated
  </li>
</ul>
</html>", info="<html>
<p>
  Pump for nominal pipe diameter of 25 mm, pump head range between 1 m
  and 8 m and maximum volume flow rate of 5 m³/h.
</p>
<p>
  cHQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  3.50629e-07;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-2.13513e-01, 0.00000e+00,
  0.00000e+00</span>
</p>
<p>
  cPQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">6.63879e-01, 3.05941e-03,
  -1.79749e-06, 8.16507e-10, -4.46635e-14;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  1.30360e-06, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, -1.23850e-04,
  0.00000e+00, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-2.27780e-01, 0.00000e+00,
  0.00000e+00, 0.00000e+00, 0.00000e+00</span>
</p>
</html>"));
end Pump_DN25_H1_8_V5;
