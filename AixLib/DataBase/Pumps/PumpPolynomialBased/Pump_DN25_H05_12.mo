within AixLib.DataBase.Pumps.PumpPolynomialBased;
record Pump_DN25_H05_12 "Pump with head 0.5 to 12,4m and 12,4m^3/h volume flow (25/0.5-12 PN)"
   extends PumpBaseRecord(
     maxMinHeight=[
           0.00, 12.30,  0.367;
           0.40, 12.37,  0.335;
           0.79, 12.44,  0.303;
           1.19, 12.40,  0.287;
           1.59, 12.23,  0.288;
           1.98, 12.07,  0.290;
           2.38, 11.84,  0.000;
           2.78, 11.61,  0.000;
           3.17, 11.35,  0.000;
           3.57, 11.07,  0.000;
           3.97, 10.79,  0.000;
           4.36, 10.48,  0.000;
           4.76, 10.17,  0.000;
           5.16,  9.83,  0.000;
           5.55,  9.47,  0.000;
           5.95,  9.11,  0.000;
           6.34,  8.78,  0.000;
           6.74,  8.47,  0.000;
           7.14,  8.15,  0.000;
           7.53,  7.82,  0.000;
           7.93,  7.49,  0.000;
           8.33,  7.14,  0.000;
           8.72,  6.80,  0.000;
           9.12,  6.45,  0.000;
           9.52,  6.10,  0.000;
           9.91,  5.75,  0.000;
          10.31,  5.34,  0.000;
          10.71,  4.91,  0.000;
          11.10,  4.48,  0.000;
          11.50,  4.05,  0.000]
      "maximum and minimum boundaries of pump (Q,Hmax,Hmin)",
    maxMinSpeedCurves = [
           0.00, 4333,  739;
           0.40, 4334,  740;
           0.79, 4335,  741;
           1.19, 4320,  753;
           1.59, 4286,  777;
           1.98, 4253,  801;
           2.38, 4208,  802;
           2.78, 4163,  802;
           3.17, 4128,  802;
           3.57, 4106,  802;
           3.97, 4084,  802;
           4.36, 4030,  802;
           4.76, 3974,  802;
           5.16, 3917,  802;
           5.55, 3861,  802;
           5.95, 3804,  802;
           6.34, 3768,  802;
           6.74, 3734,  802;
           7.14, 3705,  802;
           7.53, 3683,  802;
           7.93, 3661,  802;
           8.33, 3639,  802;
           8.72, 3617,  802;
           9.12, 3595,  802;
           9.52, 3573,  802;
           9.91, 3551,  802;
          10.31, 3517,  802;
          10.71, 3479,  802;
          11.10, 3442,  802;
          11.50, 3405,  802]
      "maximum and minimum boundaries of pump speed (Q,nMax,nMin)",
    nMin=750,
    nMax=4350,
    cHQN=[ 0.00000e+00,  0.00000e+00,  6.52362e-07;
           0.00000e+00,  6.12540e-05,  0.00000e+00;
          -4.34488e-02,  0.00000e+00,  0.00000e+00]
       "coefficients for H = f(Q,N)",
    cPQN=[1.17764e+00,  2.85662e-03, -2.38557e-06,  3.01986e-09, -2.01864e-13;
           0.00000e+00,  0.00000e+00,  1.75607e-06,  0.00000e+00,  0.00000e+00;
           0.00000e+00,  2.57857e-04,  0.00000e+00,  0.00000e+00,  0.00000e+00;
          -8.92872e-02,  0.00000e+00,  0.00000e+00,  0.00000e+00,  0.00000e+00]
       "coefficients for P = f(Q,N)");

  annotation(preferredView="text", Documentation(revisions="<html><ul>

  <li>2023-10-19 by Sarah Leidolf:<br/>
    Generated
  </li>
</ul>

</html>", info="<html><h4>
  Measurement and Regression Data
</h4>
<p>
  Impure curves at high pump speed because of inaccurate data of upper
  and lower limit of pump speed.
</p>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/DataBase/Pumps/PumpsPolynomialBased/Pump_DN25_H05_12.png\"
  alt=\"1\">

</p>
<p>
  cHQN:
</p>
<p>

  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  6.52362e-07;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 6.12540e-05,
  0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-4.34488e-02, 0.00000e+00,
  0.00000e+00</span>

</p>
<p>
  cPQN:
</p>
<p>

  <span style=\"font-family: Courier New;\">1.17764e+00, 2.85662e-03,
  -2.38557e-06, 3.01986e-09, -2.01864e-13;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  1.75607e-06, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 2.57857e-04,
  0.00000e+00, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-8.92872e-02, 0.00000e+00,
  0.00000e+00, 0.00000e+00, 0.00000e+00</span>
</p>
</html>"));
end Pump_DN25_H05_12;
