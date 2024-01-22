within AixLib.DataBase.Pumps.PumpPolynomialBased;
record Pump_DN40_H1_8_V17 "Pump with head 1 to 8m and 17.5m^3/h volume flow"
  extends PumpBaseRecord(
    maxMinHeight=[
           0.00,  7.91,  0.683;
           0.60,  8.05,  0.704;
           1.21,  8.03,  0.713;
           1.81,  8.03,  0.710;
           2.41,  8.09,  0.704;
           3.01,  8.12,  0.686;
           3.62,  8.20,  0.594;
           4.22,  8.25,  0.491;
           4.82,  8.19,  0.372;
           5.43,  7.83,  0.183;
           6.03,  7.48,  0.000;
           6.63,  7.17,  0.000;
           7.24,  6.93,  0.000;
           7.84,  6.74,  0.000;
           8.44,  6.49,  0.000;
           9.04,  6.11,  0.000;
           9.65,  6.02,  0.000;
          10.25,  5.84,  0.000;
          10.85,  5.60,  0.000;
          11.46,  5.47,  0.000;
          12.06,  5.04,  0.000;
          12.66,  4.81,  0.000;
          13.27,  4.48,  0.000;
          13.87,  4.01,  0.000;
          14.47,  3.69,  0.000;
          15.07,  3.40,  0.000;
          15.68,  2.83,  0.000;
          16.28,  2.40,  0.000;
          16.88,  2.02,  0.000;
          17.49,  1.69,  0.000]
      "maximum and minimum boundaries of pump (Q,Hmax,Hmin)",
    maxMinSpeedCurves = [
           0.00, 4800, 1400;
           0.60, 4800, 1400;
           1.21, 4800, 1400;
           1.81, 4800, 1400;
           2.41, 4800, 1400;
           3.01, 4800, 1400;
           3.62, 4800, 1400;
           4.22, 4800, 1400;
           4.82, 4755, 1400;
           5.43, 4631, 1400;
           6.03, 4548, 1400;
           6.63, 4458, 1400;
           7.24, 4372, 1400;
           7.84, 4313, 1400;
           8.44, 4251, 1400;
           9.04, 4205, 1400;
           9.65, 4209, 1400;
          10.25, 4212, 1400;
          10.85, 4216, 1400;
          11.46, 4225, 1400;
          12.06, 4228, 1400;
          12.66, 4232, 1400;
          13.27, 4213, 1400;
          13.87, 4213, 1400;
          14.47, 4189, 1400;
          15.07, 4181, 1400;
          15.68, 4184, 1400;
          16.28, 4192, 1400;
          16.88, 4207, 1400;
          17.49, 4215, 1400]
      "maximum and minimum boundaries of pump speed (Q,nMax,nMin)",
    nMin=1400.0,
    nMax=4800.0,
    cHQN=[ 0.00000e+00,  0.00000e+00,  3.27983e-07;
           0.00000e+00,  7.36465e-05,  0.00000e+00;
          -3.14521e-02,  0.00000e+00,  0.00000e+00]
       "coefficients for H = f(Q,N)",
    cPQN=[ 2.33926e-05,  1.61643e-02, -8.64452e-06,  3.55112e-09, -1.90733e-13;
           0.00000e+00,  0.00000e+00,  7.43369e-07,  0.00000e+00,  0.00000e+00;
           0.00000e+00,  1.55677e-04,  0.00000e+00,  0.00000e+00,  0.00000e+00;
          -4.84242e-02,  0.00000e+00,  0.00000e+00,  0.00000e+00,  0.00000e+00]
       "coefficients for P = f(Q,N)");

  annotation(preferredView="text", Documentation(revisions="<html><ul>
  <li>2018-07-02 by Luca Vedda:<br/>
    Generated
  </li>
</ul>
</html>", info="<html>
<p>
  Pump for nominal pipe diameter of 40 mm, pump head range between 1 m
  and 8 m and maximum volume flow rate of 17.5 m³/h.
</p>
<h4>
  Measurement Data
</h4>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/DataBase/Pumps/PumpsPolynomialBased/Pump_DN40_H1_8_V17.png\"
  alt=\"Pump Characterisistcs\">
</p>
<p>
  cHQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  3.27983e-07;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 7.36465e-05,
  0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-3.14521e-02, 0.00000e+00,
  0.00000e+00</span>
</p>
<p>
  cPQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">2.33926e-05, 1.61643e-02,
  -8.64452e-06, 3.55112e-09, -1.90733e-13;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  7.43369e-07, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 1.55677e-04,
  0.00000e+00, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-4.84242e-02, 0.00000e+00,
  0.00000e+00, 0.00000e+00, 0.00000e+00</span>
</p>
</html>"));
end Pump_DN40_H1_8_V17;
