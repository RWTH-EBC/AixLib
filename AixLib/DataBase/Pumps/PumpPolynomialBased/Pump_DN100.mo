within AixLib.DataBase.Pumps.PumpPolynomialBased;
record Pump_DN100 "Pump with head 1 to 34m and 378.24m^3/h volume flow"
  extends PumpBaseRecord(
    maxMinHeight=[
           0.00, 33.39,  2.353;
          13.04, 33.58,  2.388;
          26.09, 33.75,  2.346;
          39.13, 33.96,  2.351;
          52.17, 34.18,  2.103;
          65.21, 34.40,  1.743;
          78.26, 34.36,  1.340;
          91.30, 34.25,  0.846;
          104.34, 33.85,  0.000;
          117.39, 33.69,  0.000;
          130.43, 33.67,  0.000;
          143.47, 33.63,  0.000;
          156.52, 33.08,  0.000;
          169.56, 32.30,  0.000;
          182.60, 31.33,  0.000;
          195.64, 30.30,  0.000;
          208.69, 29.22,  0.000;
          221.73, 27.93,  0.000;
          234.77, 26.51,  0.000;
          247.82, 25.20,  0.000;
          260.86, 23.85,  0.000;
          273.90, 22.43,  0.000;
          286.94, 20.94,  0.000;
          299.99, 19.14,  0.000;
          313.03, 17.41,  0.000;
          326.07, 15.64,  0.000;
          339.12, 13.69,  0.000;
          352.16, 11.69,  0.000;
          365.20,  9.59,  0.000;
          378.24,  7.34,  0.000]
      "maximum and minimum boundaries of pump (Q,Hmax,Hmin)",
    maxMinSpeedCurves = [
           0.00, 2960,  747;
          13.04, 2960,  746;
          26.09, 2960,  745;
          39.13, 2960,  744;
          52.17, 2959,  743;
          65.21, 2958,  743;
          78.26, 2958,  742;
          91.30, 2959,  742;
          104.34, 2958,  742;
          117.39, 2957,  742;
          130.43, 2957,  742;
          143.47, 2957,  742;
          156.52, 2956,  742;
          169.56, 2956,  742;
          182.60, 2956,  742;
          195.64, 2956,  742;
          208.69, 2955,  742;
          221.73, 2953,  742;
          234.77, 2952,  742;
          247.82, 2951,  742;
          260.86, 2950,  742;
          273.90, 2949,  742;
          286.94, 2946,  742;
          299.99, 2939,  742;
          313.03, 2934,  742;
          326.07, 2929,  742;
          339.12, 2926,  742;
          352.16, 2927,  742;
          365.20, 2931,  742;
          378.24, 2944,  742]
      "maximum and minimum boundaries of pump speed (Q,nMax,nMin)",
    nMin=746.0,
    nMax=2960.0,
    cHQN=[ 0.00000e+00,  0.00000e+00,  3.80934e-06;
           0.00000e+00,  1.28859e-05,  0.00000e+00;
          -2.74876e-04,  0.00000e+00,  0.00000e+00]
       "coefficients for H = f(Q,N)",
    cPQN=[ 2.41585e+02, -5.23760e-01,  6.87057e-04,  1.38862e-07,  3.61130e-11;
           0.00000e+00,  0.00000e+00,  5.57129e-06,  0.00000e+00,  0.00000e+00;
           0.00000e+00,  4.28832e-05,  0.00000e+00,  0.00000e+00,  0.00000e+00;
          -4.01650e-04,  0.00000e+00,  0.00000e+00,  0.00000e+00,  0.00000e+00]
       "coefficients for P = f(Q,N)");

  annotation(preferredView="text", Documentation(revisions="<html><ul>
  <li>2018-07-02 by Luca Vedda:<br/>
    Generated
  </li>
</ul>
</html>", info="<html>
<p>
  Pump for nominal pipe diameter of 100 mm, pump head range between 1 m
  and 34 m and maximum volume flow rate of 378.24 m³/h.
</p>
<h4>
  Measurement Data
</h4>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/DataBase/Pumps/PumpsPolynomialBased/Pump_DN100.png\"
  alt=\"Pump Characterisistcs\">
</p>
<p>
  cHQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  3.80934e-06;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 1.28859e-05,
  0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-2.74876e-04, 0.00000e+00,
  0.00000e+00</span>
</p>
<p>
  cPQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">2.41585e+02, -5.23760e-01,
  6.87057e-04, 1.38862e-07, 3.61130e-11;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  5.57129e-06, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 4.28832e-05,
  0.00000e+00, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-4.01650e-04, 0.00000e+00,
  0.00000e+00, 0.00000e+00, 0.00000e+00</span>
</p>
</html>"));
end Pump_DN100;
