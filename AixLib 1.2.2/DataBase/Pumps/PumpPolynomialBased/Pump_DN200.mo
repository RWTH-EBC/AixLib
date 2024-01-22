within AixLib.DataBase.Pumps.PumpPolynomialBased;
record Pump_DN200 "Pump with head 1 to 18m and 590m^3/h volume flow"
  extends PumpBaseRecord(
    maxMinHeight=[
           0.00, 18.03,  1.181;
          20.34, 17.64,  1.120;
          40.69, 17.38,  1.098;
          61.03, 17.31,  1.043;
          81.38, 17.24,  0.945;
          101.72, 17.11,  0.867;
          122.06, 16.98,  0.697;
          142.41, 16.85,  0.474;
          162.75, 16.73,  0.000;
          183.09, 16.62,  0.000;
          203.44, 16.49,  0.000;
          223.78, 16.15,  0.000;
          244.13, 15.76,  0.000;
          264.47, 15.33,  0.000;
          284.81, 15.02,  0.000;
          305.16, 14.59,  0.000;
          325.50, 14.29,  0.000;
          345.84, 14.13,  0.000;
          366.19, 13.97,  0.000;
          386.53, 13.74,  0.000;
          406.88, 13.19,  0.000;
          427.22, 12.58,  0.000;
          447.56, 11.87,  0.000;
          467.91, 11.06,  0.000;
          488.25, 10.22,  0.000;
          508.59,  9.37,  0.000;
          528.94,  8.49,  0.000;
          549.28,  7.53,  0.000;
          569.63,  6.60,  0.000;
          589.97,  5.58,  0.000]
      "maximum and minimum boundaries of pump (Q,Hmax,Hmin)",
    maxMinSpeedCurves = [
           0.00, 1484,  378;
          20.34, 1482,  378;
          40.69, 1483,  379;
          61.03, 1483,  378;
          81.38, 1482,  378;
          101.72, 1484,  378;
          122.06, 1484,  378;
          142.41, 1484,  378;
          162.75, 1484,  378;
          183.09, 1484,  378;
          203.44, 1484,  378;
          223.78, 1484,  378;
          244.13, 1483,  378;
          264.47, 1484,  378;
          284.81, 1484,  378;
          305.16, 1483,  378;
          325.50, 1484,  378;
          345.84, 1484,  378;
          366.19, 1484,  378;
          386.53, 1484,  378;
          406.88, 1483,  378;
          427.22, 1484,  378;
          447.56, 1484,  378;
          467.91, 1484,  378;
          488.25, 1483,  378;
          508.59, 1483,  378;
          528.94, 1484,  378;
          549.28, 1484,  378;
          569.63, 1483,  378;
          589.97, 1484,  378]
      "maximum and minimum boundaries of pump speed (Q,nMax,nMin)",
    nMin=378.0,
    nMax=1484.0,
    cHQN=[ 0.00000e+00,  0.00000e+00,  7.85567e-06;
           0.00000e+00,  2.88600e-06,  0.00000e+00;
          -3.91145e-05,  0.00000e+00,  0.00000e+00]
       "coefficients for H = f(Q,N)",
    cPQN=[ 6.03247e+02, -2.72597e+00,  5.95903e-03,  3.44847e-07,  1.24204e-09;
           0.00000e+00,  0.00000e+00, -1.25130e-05,  0.00000e+00,  0.00000e+00;
           0.00000e+00,  1.13673e-04,  0.00000e+00,  0.00000e+00,  0.00000e+00;
          -1.95620e-04,  0.00000e+00,  0.00000e+00,  0.00000e+00,  0.00000e+00]
       "coefficients for P = f(Q,N)");

  annotation(preferredView="text", Documentation(revisions="<html><ul>
  <li>2018-07-02 by Luca Vedda:<br/>
    Generated
  </li>
</ul>
</html>", info="<html>
<p>
  Pump for nominal pipe diameter of 200 mm, pump head range between 1 m
  and 18 m and maximum volume flow rate of 590 m³/h.
</p>
<h4>
  Measurement Data
</h4>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/DataBase/Pumps/PumpsPolynomialBased/Pump_DN200.png\"
  alt=\"Pump Characterisistcs\">
</p>
<p>
  cHQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  7.85567e-06;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 2.88600e-06,
  0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-3.91145e-05, 0.00000e+00,
  0.00000e+00</span>
</p>
<p>
  cPQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">6.03247e+02, -2.72597e+00,
  5.95903e-03, 3.44847e-07, 1.24204e-09;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  -1.25130e-05, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 1.13673e-04,
  0.00000e+00, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-1.95620e-04, 0.00000e+00,
  0.00000e+00, 0.00000e+00, 0.00000e+00</span>
</p>
</html>"));
end Pump_DN200;
