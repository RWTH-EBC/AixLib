within AixLib.DataBase.Pumps.PumpPolynomialBased;
record Pump_DN65_H15 "Pump with head 15m and 52.21m^3/h volume flow"
  extends PumpBaseRecord(
    maxMinHeight=[
           0.00, 14.44, 12.426;
           1.80, 14.26, 12.205;
           3.60, 14.07, 11.978;
           5.40, 13.91, 11.729;
           7.20, 13.77, 11.473;
           9.00, 13.63, 11.202;
          10.80, 13.49, 10.895;
          12.60, 13.33, 10.588;
          14.40, 13.17, 10.282;
          16.20, 13.00,  9.975;
          18.00, 12.81,  9.631;
          19.80, 12.62,  9.263;
          21.61, 12.33,  8.863;
          23.41, 11.98,  8.441;
          25.21, 11.64,  8.001;
          27.01, 11.21,  7.547;
          28.81, 10.75,  7.084;
          30.61, 10.23,  6.604;
          32.41,  9.69,  6.124;
          34.21,  9.15,  5.597;
          36.01,  8.56,  5.061;
          37.81,  7.89,  4.484;
          39.61,  7.23,  3.897;
          41.41,  6.53,  3.310;
          43.21,  5.77,  2.723;
          45.01,  5.01,  2.136;
          46.81,  4.22,  1.549;
          48.61,  3.40,  0.000;
          50.41,  2.58,  0.000;
          52.21,  1.76,  0.000]
      "maximum and minimum boundaries of pump (Q,Hmax,Hmin)",
    maxMinSpeedCurves = [
           0.00, 2928, 2721;
           1.80, 2926, 2713;
           3.60, 2923, 2705;
           5.40, 2920, 2687;
           7.20, 2916, 2666;
           9.00, 2912, 2645;
          10.80, 2907, 2621;
          12.60, 2905, 2598;
          14.40, 2902, 2575;
          16.20, 2899, 2553;
          18.00, 2894, 2534;
          19.80, 2890, 2518;
          21.61, 2888, 2507;
          23.41, 2885, 2499;
          25.21, 2883, 2494;
          27.01, 2882, 2490;
          28.81, 2880, 2489;
          30.61, 2880, 2495;
          32.41, 2880, 2501;
          34.21, 2880, 2511;
          36.01, 2880, 2521;
          37.81, 2881, 2534;
          39.61, 2882, 2547;
          41.41, 2884, 2563;
          43.21, 2886, 2581;
          45.01, 2888, 2599;
          46.81, 2891, 2616;
          48.61, 2896, 2619;
          50.41, 2900, 2619;
          52.21, 2904, 2619]
      "maximum and minimum boundaries of pump speed (Q,nMax,nMin)",
    nMin=2487,
    nMax=2928,
    cHQN=[ 0.00000e+00,  0.00000e+00,  1.63907e-06;
           0.00000e+00,  1.78063e-05,  0.00000e+00;
          -5.38508e-03,  0.00000e+00,  0.00000e+00]
       "coefficients for H = f(Q,N)",
    cPQN=[-7.57114e-02, -5.11382e+01,  5.95325e-02, -2.29313e-05,  2.93959e-09;
           0.00000e+00,  0.00000e+00,  3.59473e-06,  0.00000e+00,  0.00000e+00;
           0.00000e+00,  7.24389e-05,  0.00000e+00,  0.00000e+00,  0.00000e+00;
          -1.28918e-02,  0.00000e+00,  0.00000e+00,  0.00000e+00,  0.00000e+00]
       "coefficients for P = f(Q,N)");

  annotation(preferredView="text", Documentation(revisions="<html><ul>
  <li>2018-07-02 by Luca Vedda:<br/>
    Generated
  </li>
</ul>
</html>", info="<html>
<p>
  Pump for nominal pipe diameter of 65 mm, pump head 15 m and maximum
  volume flow rate of 52.21 m³/h.
</p>
<h4>
  Measurement Data
</h4>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/DataBase/Pumps/PumpsPolynomialBased/WetRunner_Solar_65_15.png\"
  alt=\"Pump Characterisistcs\">
</p>
<p>
  cHQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  1.63907e-06;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 1.78063e-05,
  0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-5.38508e-03, 0.00000e+00,
  0.00000e+00</span>
</p>
<p>
  cPQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">-7.57114e-02, -5.11382e+01,
  5.95325e-02, -2.29313e-05, 2.93959e-09;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  3.59473e-06, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 7.24389e-05,
  0.00000e+00, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-1.28918e-02, 0.00000e+00,
  0.00000e+00, 0.00000e+00, 0.00000e+00</span>
</p>
</html>"));
end Pump_DN65_H15;
