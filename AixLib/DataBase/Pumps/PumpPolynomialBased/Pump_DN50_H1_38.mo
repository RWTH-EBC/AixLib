within AixLib.DataBase.Pumps.PumpPolynomialBased;
record Pump_DN50_H1_38 "Pump with head 1 to 38m and 52.14m^3/h volume flow"
  extends PumpBaseRecord(
    maxMinHeight=[
           0.00, 38.00,  0.479;
           1.80, 37.78,  0.444;
           3.60, 37.38,  0.333;
           5.39, 36.97,  0.135;
           7.19, 36.52,  0.000;
           8.99, 36.07,  0.000;
          10.79, 35.59,  0.000;
          12.59, 34.95,  0.000;
          14.38, 34.00,  0.000;
          16.18, 32.95,  0.000;
          17.98, 32.03,  0.000;
          19.78, 31.23,  0.000;
          21.57, 30.40,  0.000;
          23.37, 29.42,  0.000;
          25.17, 28.30,  0.000;
          26.97, 27.15,  0.000;
          28.77, 25.96,  0.000;
          30.56, 24.68,  0.000;
          32.36, 23.29,  0.000;
          34.16, 21.94,  0.000;
          35.96, 20.52,  0.000;
          37.76, 19.08,  0.000;
          39.55, 17.58,  0.000;
          41.35, 15.97,  0.000;
          43.15, 13.88,  0.000;
          44.95, 12.31,  0.000;
          46.74, 10.67,  0.000;
          48.54,  8.98,  0.000;
          50.34,  7.00,  0.000;
          52.14,  3.81,  0.000]
      "maximum and minimum boundaries of pump (Q,Hmax,Hmin)",
    maxMinSpeedCurves = [
           0.00, 4600,  500;
           1.80, 4600,  500;
           3.60, 4600,  500;
           5.39, 4600,  500;
           7.19, 4600,  500;
           8.99, 4600,  500;
          10.79, 4600,  500;
          12.59, 4600,  500;
          14.38, 4600,  500;
          16.18, 4600,  500;
          17.98, 4600,  500;
          19.78, 4600,  500;
          21.57, 4600,  500;
          23.37, 4600,  500;
          25.17, 4600,  500;
          26.97, 4600,  500;
          28.77, 4600,  500;
          30.56, 4600,  500;
          32.36, 4600,  500;
          34.16, 4600,  500;
          35.96, 4600,  500;
          37.76, 4600,  500;
          39.55, 4600,  500;
          41.35, 4600,  500;
          43.15, 4600,  500;
          44.95, 4600,  500;
          46.74, 4600,  500;
          48.54, 4600,  500;
          50.34, 4600,  500;
          52.14, 4600,  500]
      "maximum and minimum boundaries of pump speed (Q,nMax,nMin)",
    nMin=500.0,
    nMax=4599.9954,
    cHQN=[ 0.00000e+00,  0.00000e+00,  1.79741e-06;
           0.00000e+00, -3.13331e-05,  0.00000e+00;
          -9.49292e-03,  0.00000e+00,  0.00000e+00]
       "coefficients for H = f(Q,N)",
    cPQN=[ 2.12113e+01,  2.29734e-02,  2.74104e-06,  1.08557e-08, -1.33157e-14;
           0.00000e+00,  0.00000e+00,  3.76420e-06,  0.00000e+00,  0.00000e+00;
           0.00000e+00, -9.60714e-05,  0.00000e+00,  0.00000e+00,  0.00000e+00;
          -1.05943e-02,  0.00000e+00,  0.00000e+00,  0.00000e+00,  0.00000e+00]
       "coefficients for P = f(Q,N)");

  annotation(preferredView="text", Documentation(revisions="<html><ul>
  <li>2018-07-02 by Luca Vedda:<br/>
    Generated
  </li>
</ul>
</html>", info="<html>
<p>
  Pump for nominal pipe diameter of 50 mm, pump head range between 1 m
  and 38 m and maximum volume flow rate of 52.14 m³/h.
</p>
<h4>
  Measurement Data
</h4>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/DataBase/Pumps/PumpsPolynomialBased/Pump_DN50_H1_38.png\"
  alt=\"Pump Characterisistcs\">
</p>
<p>
  cHQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  1.79741e-06;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, -3.13331e-05,
  0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-9.49292e-03, 0.00000e+00,
  0.00000e+00</span>
</p>
<p>
  cPQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">2.12113e+01, 2.29734e-02,
  2.74104e-06, 1.08557e-08, -1.33157e-14;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  3.76420e-06, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, -9.60714e-05,
  0.00000e+00, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-1.05943e-02, 0.00000e+00,
  0.00000e+00, 0.00000e+00, 0.00000e+00</span>
</p>
</html>"));
end Pump_DN50_H1_38;
