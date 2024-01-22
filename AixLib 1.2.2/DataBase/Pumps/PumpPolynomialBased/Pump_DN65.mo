within AixLib.DataBase.Pumps.PumpPolynomialBased;
record Pump_DN65 "Pump with head 1 to 32m and 100m^3/h volume flow"
  extends PumpBaseRecord(
    maxMinHeight=[
           0.00, 32.49,  2.100;
           3.43, 32.82,  2.155;
           6.86, 33.13,  2.134;
          10.28, 33.39,  2.116;
          13.71, 33.51,  2.042;
          17.14, 33.52,  1.914;
          20.57, 33.27,  1.741;
          23.99, 33.34,  1.561;
          27.42, 33.53,  0.000;
          30.85, 33.71,  0.000;
          34.28, 33.62,  0.000;
          37.71, 33.43,  0.000;
          41.13, 33.15,  0.000;
          44.56, 32.86,  0.000;
          47.99, 32.55,  0.000;
          51.42, 32.11,  0.000;
          54.84, 31.46,  0.000;
          58.27, 30.92,  0.000;
          61.70, 30.34,  0.000;
          65.13, 29.73,  0.000;
          68.56, 29.12,  0.000;
          71.98, 28.51,  0.000;
          75.41, 27.89,  0.000;
          78.84, 27.24,  0.000;
          82.27, 26.32,  0.000;
          85.70, 25.39,  0.000;
          89.12, 24.31,  0.000;
          92.55, 23.13,  0.000;
          95.98, 21.99,  0.000;
          99.41, 20.79,  0.000]
      "maximum and minimum boundaries of pump (Q,Hmax,Hmin)",
    maxMinSpeedCurves = [
           0.00, 2958,  749;
           3.43, 2959,  748;
           6.86, 2959,  747;
          10.28, 2958,  748;
          13.71, 2957,  748;
          17.14, 2957,  748;
          20.57, 2956,  748;
          23.99, 2956,  748;
          27.42, 2955,  748;
          30.85, 2955,  748;
          34.28, 2954,  748;
          37.71, 2953,  748;
          41.13, 2953,  748;
          44.56, 2952,  748;
          47.99, 2951,  748;
          51.42, 2951,  748;
          54.84, 2950,  748;
          58.27, 2949,  748;
          61.70, 2948,  748;
          65.13, 2947,  748;
          68.56, 2947,  748;
          71.98, 2946,  748;
          75.41, 2945,  748;
          78.84, 2945,  748;
          82.27, 2932,  748;
          85.70, 2919,  748;
          89.12, 2903,  748;
          92.55, 2883,  748;
          95.98, 2863,  748;
          99.41, 2844,  748]
      "maximum and minimum boundaries of pump speed (Q,nMax,nMin)",
    nMin=748.0,
    nMax=2960.0,
    cHQN=[ 0.00000e+00,  0.00000e+00,  3.74328e-06;
           0.00000e+00,  2.53004e-05,  0.00000e+00;
          -1.73208e-03,  0.00000e+00,  0.00000e+00]
       "coefficients for H = f(Q,N)",
    cPQN=[ 1.25418e+02, -9.18914e-02,  1.55192e-04,  4.46658e-08,  9.42769e-12;
           0.00000e+00,  0.00000e+00,  5.73427e-06,  0.00000e+00,  0.00000e+00;
           0.00000e+00,  1.83142e-04,  0.00000e+00,  0.00000e+00,  0.00000e+00;
          -4.14183e-03,  0.00000e+00,  0.00000e+00,  0.00000e+00,  0.00000e+00]
       "coefficients for P = f(Q,N)");

  annotation(preferredView="text", Documentation(revisions="<html><ul>
  <li>2018-07-02 by Luca Vedda:<br/>
    Generated
  </li>
</ul>
</html>", info="<html>
<p>
  Pump for nominal pipe diameter of 65 mm, pump head range between 1 m
  and 32 m and maximum volume flow rate of 100 m³/h.
</p>
<h4>
  Measurement Data
</h4>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/DataBase/Pumps/PumpsPolynomialBased/Pump_DN65.png\"
  alt=\"Pump Characterisistcs\">
</p>
<p>
  cHQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  3.74328e-06;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 2.53004e-05,
  0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-1.73208e-03, 0.00000e+00,
  0.00000e+00</span>
</p>
<p>
  cPQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">1.25418e+02, -9.18914e-02,
  1.55192e-04, 4.46658e-08, 9.42769e-12;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  5.73427e-06, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 1.83142e-04,
  0.00000e+00, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-4.14183e-03, 0.00000e+00,
  0.00000e+00, 0.00000e+00, 0.00000e+00</span>
</p>
</html>"));
end Pump_DN65;
