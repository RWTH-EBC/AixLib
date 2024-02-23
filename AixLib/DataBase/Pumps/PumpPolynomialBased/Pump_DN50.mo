within AixLib.DataBase.Pumps.PumpPolynomialBased;
record Pump_DN50 "Pump with head 1 to 12m and 43m^3/h volume flow"
  extends PumpBaseRecord(
    maxMinHeight=[
      -0.010, 11.735, 0.767;
       0.000, 11.735, 0.767;
       2.847, 11.545, 0.758;
       5.771, 11.475, 0.695;
       8.532, 11.432, 0.586;
       9.410, 11.409, 0.329;
      12.117, 11.336, 0.000;
      14.509, 11.209, 0.000;
      17.326, 11.020, 0.000;
      19.589, 10.826, 0.000;
      23.687, 10.406, 0.000;
      25.928, 10.160, 0.000;
      28.241,  9.838, 0.000;
      31.651,  9.227, 0.000;
      35.213,  8.500, 0.000;
      37.925,  7.805, 0.000;
      40.516,  7.075, 0.000;
      43.484,  6.358, 0.000]
        "maximum and minimum boundaries of pump (Q,Hmax,Hmin)",
    maxMinSpeedCurves = [
           0,  nMax, nMin;
        9.41,  nMax, nMin;
       10.00,  nMax,    0;
      43.484,  nMax,    0]
        "maximum and minimum boundaries of pump speed (Q,nMax,nMin)",
    nMin=765,
    nMax=2960,
    cHQN=[ 0,       0,        1.31E-06;
           0,       7.59E-06, 0;
          -0.00316, 0,        0],
    cPQN=[-2.45477E+01, 2.82590E-01, -2.38897E-04, 1.27064E-07, -1.27494E-11;
           0,           0,            3.23573E-06, 0,            0;
           0,           8.70834E-05,  0,           0,            0;
          -8.39000E-03, 0,            0,           0,            0]
      "coefficients for P = f(Q,N)");

  annotation(preferredView="text", Documentation(revisions="<html><ul>
  <li>2018-09-24 by Luca Vedda:<br/>
    Implemented
  </li>
</ul>
</html>", info="<html>
<p>
  Pump for nominal pipe diameter of 50 mm, pump head range between 1 m
  and 12 m and maximum volume flow rate of 43 m³/h.
</p>
<h4>
  Measurement Data
</h4>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/DataBase/Pumps/PumpsPolynomialBased/Pump_DN50.png\"
  alt=\"Pump Characterisistcs\">
</p>
<p>
  cHQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000000e+00 0.00000000e+00
  1.31089345e-06;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000000e+00 7.58844493e-06
  0.00000000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-3.15754820e-03
  0.00000000e+00 0.00000000e+00</span>
</p>
<p>
  cPQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">-2.45505545e+01
  2.82587745e-01 -2.38896170e-04 1.27063407e-07 -1.27493571e-11;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000000e+00 0.00000000e+00
  3.23573346e-06 0.00000000e+00 0.00000000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000000e+00 8.70833575e-05
  0.00000000e+00 0.00000000e+00 0.00000000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-8.39308427e-03
  0.00000000e+00 0.00000000e+00 0.00000000e+00 0.00000000e+00</span>
</p>
</html>"));
end Pump_DN50;
