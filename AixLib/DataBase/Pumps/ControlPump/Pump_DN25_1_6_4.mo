within AixLib.DataBase.Pumps.ControlPump;
record Pump_DN25_1_6_4 "DN25 1-6 4.25"
  extends PumpBaseRecord(
    pumpManufacturerString = "The Pump Builders Company",
    pumpModelString = "DN25 1-6 4.25",
    maxMinHeight=[
           0.00,  5.90,  0.466;
           0.25,  5.90,  0.466;
           0.50,  5.90,  0.440;
           0.75,  5.43,  0.391;
           1.00,  4.73,  0.320;
           1.25,  4.27,  0.226;
           1.50,  3.94,  0.109;
           1.75,  3.47,  0.000;
           2.00,  3.19,  0.000;
           2.25,  2.79,  0.000;
           2.50,  2.45,  0.000;
           2.75,  2.14,  0.000;
           3.00,  1.81,  0.000;
           3.25,  1.50,  0.000;
           3.50,  1.20,  0.000;
           3.75,  0.87,  0.000;
           4.00,  0.53,  0.000;
           4.25,  0.21,  0.000]
             "maximum and minimum boundaries of pump (Q,Hmax,Hmin)",
    maxMinSpeedCurves = [
           0.00, 4250, 1200;
           0.25, 4250, 1200;
           0.50, 4250, 1200;
           0.75, 4089, 1200;
           1.00, 3843, 1200;
           1.25, 3688, 1200;
           1.50, 3591, 1200;
           1.75, 3444, 1200;
           2.00, 3387, 1200;
           2.25, 3283, 1200;
           2.50, 3214, 1200;
           2.75, 3173, 1200;
           3.00, 3128, 1200;
           3.25, 3110, 1200;
           3.50, 3104, 1200;
           3.75, 3090, 1200;
           4.00, 3090, 1200;
           4.25, 3104, 1200]
             "maximum and minimum boundaries of pump speed (Q,nMax,nMin)",
    nMin=1200.0,
    nMax=4250.0,
    cHQN=[ 0.00000e+00,  0.00000e+00,  3.25798e-07;
           0.00000e+00,  2.73726e-05,  0.00000e+00;
          -1.82165e-01,  0.00000e+00,  0.00000e+00]
       "coefficients for H = f(Q,N)",
    cPQN=[ 2.60353e-05,  1.85264e-03, -5.34076e-07,  5.03223e-10, -2.76211e-14;
           0.00000e+00,  0.00000e+00,  1.18994e-06,  0.00000e+00,  0.00000e+00;
           0.00000e+00, -8.47293e-05,  0.00000e+00,  0.00000e+00,  0.00000e+00;
          -2.25479e-01,  0.00000e+00,  0.00000e+00,  0.00000e+00,  0.00000e+00]
       "coefficients for P = f(Q,N)");
  annotation(preferredView="text", Documentation(revisions="<html>
<ul>
<li>2018-02-15 by Peter Matthes:<br>removed &apos;zero&apos; rows maxMinSpeedCurves and maxMinHeight table.</li>
<li>2018-01-23 by Peter Matthes:<br>Generated</li>
</ul>
</html>", info="<html>
<p>Pump for nominal pipe diameter of 25 mm, pump head range between 1 m and 6 m and maximum volume flow rate of 4.25 m&sup3;/h.</p>
<h4>Measurement and Regression Data</h4>
<p><img src=\"modelica://Zugabe/Resources/Images/Zugabe_DB/Pump/Stratos_Pico_25_1-6.png\"/></p>
<p>cHQN:</p>
<p><span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00, 3.25798e-07;</span></p>
<p><span style=\"font-family: Courier New;\">0.00000e+00, 2.73726e-05, 0.00000e+00;</span></p>
<p><span style=\"font-family: Courier New;\">-1.82165e-01, 0.00000e+00, 0.00000e+00</span></p>
<p>cPQN:</p>
<p><span style=\"font-family: Courier New;\">2.60353e-05, 1.85264e-03, -5.34076e-07, 5.03223e-10, -2.76211e-14;</span></p>
<p><span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00, 1.18994e-06, 0.00000e+00, 0.00000e+00;</span></p>
<p><span style=\"font-family: Courier New;\">0.00000e+00, -8.47293e-05, 0.00000e+00, 0.00000e+00, 0.00000e+00;</span></p>
<p><span style=\"font-family: Courier New;\">-2.25479e-01, 0.00000e+00, 0.00000e+00, 0.00000e+00, 0.00000e+00</span></p>
<h4>Comparison of Measument and Regression</h4>
<p><img src=\"modelica://Zugabe/Resources/Images/Zugabe_DB/Pump/Stratos_Pico_25_1-6_diff-contour_HP.png\"/></p>
<p><img src=\"modelica://Zugabe/Resources/Images/Zugabe_DB/Pump/Stratos_Pico_25_1-6_diff-histogram_HP.png\"/></p>
</html>"));
end Pump_DN25_1_6_4;
