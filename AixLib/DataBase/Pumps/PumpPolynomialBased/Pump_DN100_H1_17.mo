within AixLib.DataBase.Pumps.PumpPolynomialBased;
record Pump_DN100_H1_17 "Pump with head 1 to 17m and 136.48m^3/h volume flow"
  extends PumpBaseRecord(
    maxMinHeight=[
           0.00, 19.28,  0.928;
           4.71, 19.26,  0.910;
           9.41, 19.21,  0.852;
          14.12, 19.13,  0.776;
          18.82, 19.02,  0.657;
          23.53, 18.89,  0.517;
          28.24, 18.62,  0.350;
          32.94, 18.36,  0.000;
          37.65, 17.94,  0.000;
          42.35, 17.33,  0.000;
          47.06, 16.81,  0.000;
          51.77, 16.53,  0.000;
          56.47, 16.18,  0.000;
          61.18, 15.77,  0.000;
          65.89, 15.24,  0.000;
          70.59, 14.66,  0.000;
          75.30, 14.10,  0.000;
          80.00, 13.57,  0.000;
          84.71, 12.98,  0.000;
          89.42, 12.33,  0.000;
          94.12, 11.71,  0.000;
          98.83, 11.03,  0.000;
          103.53, 10.32,  0.000;
          108.24,  9.58,  0.000;
          112.95,  8.84,  0.000;
          117.65,  8.15,  0.000;
          122.36,  7.43,  0.000;
          127.06,  6.66,  0.000;
          131.77,  5.85,  0.000;
          136.48,  5.04,  0.000]
      "maximum and minimum boundaries of pump (Q,Hmax,Hmin)",
    maxMinSpeedCurves = [
           0.00, 2300,  500;
           4.71, 2300,  500;
           9.41, 2300,  500;
          14.12, 2300,  500;
          18.82, 2300,  500;
          23.53, 2300,  500;
          28.24, 2300,  500;
          32.94, 2300,  500;
          37.65, 2300,  500;
          42.35, 2300,  500;
          47.06, 2300,  500;
          51.77, 2300,  500;
          56.47, 2300,  500;
          61.18, 2300,  500;
          65.89, 2300,  500;
          70.59, 2300,  500;
          75.30, 2300,  500;
          80.00, 2300,  500;
          84.71, 2300,  500;
          89.42, 2300,  500;
          94.12, 2300,  500;
          98.83, 2300,  500;
          103.53, 2300,  500;
          108.24, 2300,  500;
          112.95, 2300,  500;
          117.65, 2300,  500;
          122.36, 2300,  500;
          127.06, 2300,  500;
          131.77, 2300,  500;
          136.48, 2300,  500]
      "maximum and minimum boundaries of pump speed (Q,nMax,nMin)",
    nMin=500.0,
    nMax=2300.0,
    cHQN=[ 0.00000e+00,  0.00000e+00,  3.71921e-06;
           0.00000e+00, -1.14576e-05,  0.00000e+00;
          -5.96302e-04,  0.00000e+00,  0.00000e+00]
       "coefficients for H = f(Q,N)",
    cPQN=[-5.72417e+01,  3.87631e-01, -4.56731e-04,  4.16084e-07, -4.47479e-11;
           0.00000e+00,  0.00000e+00,  3.80500e-06,  0.00000e+00,  0.00000e+00;
           0.00000e+00,  7.20835e-05,  0.00000e+00,  0.00000e+00,  0.00000e+00;
          -1.79833e-03,  0.00000e+00,  0.00000e+00,  0.00000e+00,  0.00000e+00]
       "coefficients for P = f(Q,N)");

  annotation(preferredView="text", Documentation(revisions="<html><ul>
  <li>2018-07-02 by Luca Vedda:<br/>
    Generated
  </li>
</ul>
</html>", info="<html>
<p>
  Pump for nominal pipe diameter of 100 mm, pump head range between 1 m
  and 17 m and maximum volume flow rate of 136.48 m³/h.
</p>
<h4>
  Measurement Data
</h4>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/DataBase/Pumps/PumpsPolynomialBased/Pump_DN100_H1_17.png\"
  alt=\"Pump Characterisistcs\">
</p>
<p>
  cHQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  3.71921e-06;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, -1.14576e-05,
  0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-5.96302e-04, 0.00000e+00,
  0.00000e+00</span>
</p>
<p>
  cPQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">-5.72417e+01, 3.87631e-01,
  -4.56731e-04, 4.16084e-07, -4.47479e-11;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  3.80500e-06, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 7.20835e-05,
  0.00000e+00, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-1.79833e-03, 0.00000e+00,
  0.00000e+00, 0.00000e+00, 0.00000e+00</span>
</p>
</html>"));
end Pump_DN100_H1_17;
