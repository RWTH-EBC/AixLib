within AixLib.DataBase.Pumps.PumpPolynomialBased;
record Pump_DN40_H10 "Pump with head 10m and 21m^3/h volume flow"
  extends PumpBaseRecord(
    maxMinHeight=[
           0.00,  9.71,  7.841;
           0.73,  9.74,  7.652;
           1.45,  9.74,  7.467;
           2.18,  9.68,  7.283;
           2.90,  9.60,  7.071;
           3.63,  9.51,  6.823;
           4.36,  9.42,  6.542;
           5.08,  9.34,  6.246;
           5.81,  9.21,  5.933;
           6.53,  9.08,  5.618;
           7.26,  8.93,  5.329;
           7.99,  8.76,  5.033;
           8.71,  8.58,  4.699;
           9.44,  8.38,  4.370;
          10.16,  8.16,  4.052;
          10.89,  7.90,  3.716;
          11.62,  7.62,  3.380;
          12.34,  7.32,  3.045;
          13.07,  6.99,  2.708;
          13.80,  6.64,  2.370;
          14.52,  6.29,  2.034;
          15.25,  5.92,  1.699;
          15.97,  5.51,  0.000;
          16.70,  5.09,  0.000;
          17.43,  4.65,  0.000;
          18.15,  4.23,  0.000;
          18.88,  3.88,  0.000;
          19.60,  3.44,  0.000;
          20.33,  2.96,  0.000;
          21.06,  2.46,  0.000]
      "maximum and minimum boundaries of pump (Q,Hmax,Hmin)",
    maxMinSpeedCurves = [
           0.00, 2901, 2604;
           0.73, 2892, 2570;
           1.45, 2884, 2534;
           2.18, 2876, 2495;
           2.90, 2867, 2458;
           3.63, 2860, 2420;
           4.36, 2853, 2376;
           5.08, 2842, 2330;
           5.81, 2832, 2286;
           6.53, 2823, 2246;
           7.26, 2815, 2211;
           7.99, 2805, 2181;
           8.71, 2798, 2154;
           9.44, 2790, 2129;
          10.16, 2782, 2109;
          10.89, 2776, 2089;
          11.62, 2770, 2075;
          12.34, 2764, 2066;
          13.07, 2757, 2062;
          13.80, 2753, 2061;
          14.52, 2749, 2062;
          15.25, 2745, 2063;
          15.97, 2740, 2064;
          16.70, 2739, 2064;
          17.43, 2738, 2064;
          18.15, 2736, 2064;
          18.88, 2738, 2064;
          19.60, 2739, 2064;
          20.33, 2739, 2064;
          21.06, 2742, 2064]
      "maximum and minimum boundaries of pump speed (Q,nMax,nMin)",
    nMin=2061,
    nMax=2901,
    cHQN=[ 0.00000e+00,  0.00000e+00,  1.14499e-06;
           0.00000e+00,  4.66276e-05,  0.00000e+00;
          -1.99893e-02,  0.00000e+00,  0.00000e+00]
       "coefficients for H = f(Q,N)",
    cPQN=[-6.16143e-03, -3.78851e+00,  4.98972e-03, -2.11796e-06,  2.96335e-10;
           0.00000e+00,  0.00000e+00,  3.30189e-06,  0.00000e+00,  0.00000e+00;
           0.00000e+00,  2.03751e-04,  0.00000e+00,  0.00000e+00,  0.00000e+00;
          -4.40060e-02,  0.00000e+00,  0.00000e+00,  0.00000e+00,  0.00000e+00]
       "coefficients for P = f(Q,N)");

  annotation(preferredView="text", Documentation(revisions="<html><ul>
  <li>2018-07-02 by Luca Vedda:<br/>
    Generated
  </li>
</ul>
</html>", info="<html>
<p>
  Pump for nominal pipe diameter of 40 mm, pump head 10 m and maximum
  volume flow rate of 21 m³/h.
</p>
<h4>
  Measurement Data
</h4>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/DataBase/Pumps/PumpsPolynomialBased/WetRunner_Solar_40_10.png\"
  alt=\"Pump Characterisistcs\">
</p>
<p>
  cHQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  1.14499e-06;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 4.66276e-05,
  0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-1.99893e-02, 0.00000e+00,
  0.00000e+00</span>
</p>
<p>
  cPQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">-6.16143e-03, -3.78851e+00,
  4.98972e-03, -2.11796e-06, 2.96335e-10;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  3.30189e-06, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 2.03751e-04,
  0.00000e+00, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-4.40060e-02, 0.00000e+00,
  0.00000e+00, 0.00000e+00, 0.00000e+00</span>
</p>
</html>"));
end Pump_DN40_H10;
