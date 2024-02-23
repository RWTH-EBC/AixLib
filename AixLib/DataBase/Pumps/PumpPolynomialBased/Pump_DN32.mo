within AixLib.DataBase.Pumps.PumpPolynomialBased;
record Pump_DN32 "Pump with head 1 to 24m and 22.34m^3/h volume flow"
  extends PumpBaseRecord(
    maxMinHeight=[
           0.00, 24.27,  1.470;
           0.77, 24.24,  1.470;
           1.54, 24.28,  1.457;
           2.31, 24.35,  1.387;
           3.08, 24.35,  1.194;
           3.85, 24.27,  1.000;
           4.62, 24.15,  0.723;
           5.39, 23.89,  0.369;
           6.16, 23.63,  0.000;
           6.93, 23.30,  0.000;
           7.70, 22.87,  0.000;
           8.47, 22.37,  0.000;
           9.24, 21.87,  0.000;
          10.01, 21.31,  0.000;
          10.78, 20.70,  0.000;
          11.56, 19.97,  0.000;
          12.33, 19.24,  0.000;
          13.10, 18.45,  0.000;
          13.87, 17.61,  0.000;
          14.64, 16.75,  0.000;
          15.41, 15.82,  0.000;
          16.18, 14.87,  0.000;
          16.95, 13.78,  0.000;
          17.72, 12.71,  0.000;
          18.49, 11.64,  0.000;
          19.26, 10.46,  0.000;
          20.03,  9.20,  0.000;
          20.80,  7.86,  0.000;
          21.57,  6.55,  0.000;
          22.34,  4.98,  0.000]
      "maximum and minimum boundaries of pump (Q,Hmax,Hmin)",
    maxMinSpeedCurves = [
           0.00, 2913,  760;
           0.77, 2912,  760;
           1.54, 2911,  760;
           2.31, 2911,  761;
           3.08, 2911,  761;
           3.85, 2912,  761;
           4.62, 2912,  762;
           5.39, 2912,  762;
           6.16, 2912,  762;
           6.93, 2913,  762;
           7.70, 2914,  762;
           8.47, 2913,  762;
           9.24, 2912,  762;
          10.01, 2911,  762;
          10.78, 2911,  762;
          11.56, 2911,  762;
          12.33, 2911,  762;
          13.10, 2911,  762;
          13.87, 2911,  762;
          14.64, 2911,  762;
          15.41, 2911,  762;
          16.18, 2911,  762;
          16.95, 2910,  762;
          17.72, 2910,  762;
          18.49, 2911,  762;
          19.26, 2912,  762;
          20.03, 2911,  762;
          20.80, 2913,  762;
          21.57, 2913,  762;
          22.34, 2917,  762]
      "maximum and minimum boundaries of pump speed (Q,nMax,nMin)",
    nMin=760.0,
    nMax=2920.0,
    cHQN=[ 0.00000e+00,  0.00000e+00,  2.84006e-06;
           0.00000e+00,  6.77095e-05,  0.00000e+00;
          -4.75300e-02,  0.00000e+00,  0.00000e+00]
       "coefficients for H = f(Q,N)",
    cPQN=[ 5.15586e-01,  1.69173e-01, -1.41779e-04,  8.36830e-08, -8.50026e-12;
           0.00000e+00,  0.00000e+00,  8.11074e-06,  0.00000e+00,  0.00000e+00;
           0.00000e+00, -9.51449e-05,  0.00000e+00,  0.00000e+00,  0.00000e+00;
          -3.06692e-02,  0.00000e+00,  0.00000e+00,  0.00000e+00,  0.00000e+00]
       "coefficients for P = f(Q,N)");

  annotation(preferredView="text", Documentation(revisions="<html><ul>
  <li>2018-09-28 by Luca Vedda:<br/>
    Generated
  </li>
</ul>
</html>", info="<html>
<p>
  Pump for nominal pipe diameter of 32 mm, pump head range between 1 m
  and 24 m and maximum volume flow rate of 22.23 m³/h.
</p>
<h4>
  Measurement Data
</h4>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/DataBase/Pumps/PumpsPolynomialBased/Pump_DN32.png\"
  alt=\"Pump Characterisistcs\">
</p>
<p>
  cHQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  2.84006e-06;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 6.77095e-05,
  0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-4.75300e-02, 0.00000e+00,
  0.00000e+00</span>
</p>
<p>
  cPQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">5.15586e-01, 1.69173e-01,
  -1.41779e-04, 8.36830e-08, -8.50026e-12;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  8.11074e-06, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, -9.51449e-05,
  0.00000e+00, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-3.06692e-02, 0.00000e+00,
  0.00000e+00, 0.00000e+00, 0.00000e+00</span>
</p>
</html>"));
end Pump_DN32;
