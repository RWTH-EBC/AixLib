within AixLib.DataBase.Pumps.PumpPolynomialBased;
record Pump_DN50_H10 "Pump with head 10m and 32.23m^3/h volume flow"
  extends PumpBaseRecord(
    maxMinHeight=[
           0.00,  9.13,  8.562;
           1.11,  9.13,  8.480;
           2.22,  9.14,  8.392;
           3.33,  9.14,  8.294;
           4.45,  9.15,  8.182;
           5.56,  9.17,  8.067;
           6.67,  9.13,  7.940;
           7.78,  9.08,  7.739;
           8.89,  9.04,  7.534;
          10.00,  8.97,  7.257;
          11.11,  8.88,  6.943;
          12.23,  8.76,  6.595;
          13.34,  8.59,  6.176;
          14.45,  8.38,  5.751;
          15.56,  8.10,  5.288;
          16.67,  7.73,  4.844;
          17.78,  7.36,  4.429;
          18.89,  7.00,  4.036;
          20.00,  6.63,  3.657;
          21.12,  6.22,  3.283;
          22.23,  5.81,  2.904;
          23.34,  5.39,  2.505;
          24.45,  4.96,  2.104;
          25.56,  4.48,  1.678;
          26.67,  3.97,  1.252;
          27.78,  3.40,  0.807;
          28.90,  2.82,  0.000;
          30.01,  2.21,  0.000;
          31.12,  1.59,  0.000;
          32.23,  0.93,  0.000]
      "maximum and minimum boundaries of pump (Q,Hmax,Hmin)",
    maxMinSpeedCurves = [
           0.00, 2916, 2820;
           1.11, 2908, 2797;
           2.22, 2898, 2773;
           3.33, 2888, 2748;
           4.45, 2878, 2719;
           5.56, 2869, 2689;
           6.67, 2861, 2661;
           7.78, 2853, 2632;
           8.89, 2845, 2595;
          10.00, 2834, 2554;
          11.11, 2823, 2512;
          12.23, 2813, 2470;
          13.34, 2804, 2430;
          14.45, 2795, 2392;
          15.56, 2788, 2369;
          16.67, 2782, 2349;
          17.78, 2777, 2332;
          18.89, 2772, 2323;
          20.00, 2769, 2319;
          21.12, 2768, 2319;
          22.23, 2766, 2323;
          23.34, 2765, 2337;
          24.45, 2763, 2350;
          25.56, 2765, 2370;
          26.67, 2767, 2389;
          27.78, 2770, 2414;
          28.90, 2774, 2419;
          30.01, 2779, 2419;
          31.12, 2778, 2419;
          32.23, 2742, 2419]
      "maximum and minimum boundaries of pump speed (Q,nMax,nMin)",
    nMin=2318,
    nMax=2916,
    cHQN=[ 0.00000e+00,  0.00000e+00,  1.05131e-06;
           0.00000e+00,  6.36015e-05,  0.00000e+00;
          -1.23177e-02,  0.00000e+00,  0.00000e+00]
       "coefficients for H = f(Q,N)",
    cPQN=[-2.81160e-02, -1.82546e+01,  2.31237e-02, -9.57285e-06,  1.30624e-09;
           0.00000e+00,  0.00000e+00,  4.55386e-06,  0.00000e+00,  0.00000e+00;
           0.00000e+00, -1.05488e-04,  0.00000e+00,  0.00000e+00,  0.00000e+00;
          -1.11489e-02,  0.00000e+00,  0.00000e+00,  0.00000e+00,  0.00000e+00]
       "coefficients for P = f(Q,N)");

  annotation(preferredView="text", Documentation(revisions="<html><ul>
  <li>2018-07-02 by Luca Vedda:<br/>
    Generated
  </li>
</ul>
</html>", info="<html>
<p>
  Pump for nominal pipe diameter of 50 mm, pump head 10 m and maximum
  volume flow rate of 32.23 m³/h.
</p>
<h4>
  Measurement Data
</h4>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/DataBase/Pumps/PumpsPolynomialBased/WetRunner_Solar_50_10.png\"
  alt=\"Pump Characterisistcs\">
</p>
<p>
  cHQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  1.05131e-06;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 6.36015e-05,
  0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-1.23177e-02, 0.00000e+00,
  0.00000e+00</span>
</p>
<p>
  cPQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">-2.81160e-02, -1.82546e+01,
  2.31237e-02, -9.57285e-06, 1.30624e-09;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  4.55386e-06, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, -1.05488e-04,
  0.00000e+00, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-1.11489e-02, 0.00000e+00,
  0.00000e+00, 0.00000e+00, 0.00000e+00</span>
</p>
</html>"));
end Pump_DN50_H10;
