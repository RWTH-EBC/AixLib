within AixLib.DataBase.Pumps.ControlPump;
record Pump_DN30_1_12_13 "DN30 1-12 13"
  extends PumpBaseRecord(
    pumpManufacturerString = "The Pump Builders Company",
    pumpModelString = "DN30 1-12 13",
    maxMinHeight=[
           0.00, 11.60,  1.03;
           0.70, 11.60,  1.03;
           1.40, 11.87,  1.03;
           2.10, 12.06,  0.94;
           2.80, 12.17,  0.78;
           3.50, 12.21,  0.54;
           4.20, 12.16,  0.22;
           4.90, 12.03,  0.00;
           5.60, 10.84,  0.00;
           6.30, 10.22,  0.00;
           7.00,  9.21,  0.00;
           7.70,  8.44,  0.00;
           8.40,  7.61,  0.00;
           9.10,  6.88,  0.00;
           9.80,  5.95,  0.00;
          10.50,  5.11,  0.00;
          11.20,  4.18,  0.00;
          11.90,  3.18,  0.00;
          12.60,  2.31,  0.00;
          13.30,  1.36,  0.00;
          14.00,  0.17,  0.00]
      "maximum and minimum boundaries of pump (Q,Hmax,Hmin)",
    maxMinSpeedCurves = [
           0.00, 4800, 1400;
           0.70, 4800, 1400;
           1.40, 4800, 1400;
           2.10, 4800, 1400;
           2.80, 4800, 1400;
           3.50, 4800, 1400;
           4.20, 4800, 1400;
           4.90, 4798, 1400;
           5.60, 4609, 1400;
           6.30, 4547, 1400;
           7.00, 4426, 1400;
           7.70, 4367, 1400;
           8.40, 4314, 1400;
           9.10, 4295, 1400;
           9.80, 4254, 1400;
          10.50, 4245, 1400;
          11.20, 4235, 1400;
          11.90, 4227, 1400;
          12.60, 4256, 1400;
          13.30, 4283, 1400;
          14.00, 4282, 1400]
      "maximum and minimum boundaries of pump speed (Q,nMax,nMin)",
    nMin=1400.0,
    nMax=4800.0,
    cHQN=[ 0.00000e+00,  0.00000e+00,  4.88348e-07;
           0.00000e+00,  1.15190e-04,  0.00000e+00;
          -8.00446e-02,  0.00000e+00,  0.00000e+00]
       "coefficients for H = f(Q,N)",
    cPQN=[ 2.53904e-05,  1.86083e-02, -9.28813e-06,  3.15573e-09, -1.57051e-13;
           0.00000e+00,  0.00000e+00,  1.43568e-06,  0.00000e+00,  0.00000e+00;
           0.00000e+00,  1.16467e-04,  0.00000e+00,  0.00000e+00,  0.00000e+00;
          -9.73911e-02,  0.00000e+00,  0.00000e+00,  0.00000e+00,  0.00000e+00]
       "coefficients for P = f(Q,N)");
  annotation(preferredView="text", Documentation(revisions="<html>
<ul>
<li>2018-02-15 by Peter Matthes:<br />removed &apos;zero&apos; rows maxMinSpeedCurves and maxMinHeight table.</li>
<li>2018-01-09 by Peter Matthes:<br />Generated</li>
</ul>
</html>", info="<html>
<p>Pump for nominal pipe diameter of 30 mm, pump head range between 1 m and 12 m and maximum volume flow rate of 13 m&sup3;/h.</p>
<h4>Measurement and Regression Data</h4>
<p><img src=\"modelica://AixLib/Resources/Images/DataBase/Pumps/ControlPump/Pump_DN30_1-12_13_HP.png\" alt=\"Pump head and pump power draw\"/></p>
<p>cHQN:</p>
<p><span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00, 4.88348e-07;</span></p>
<p><span style=\"font-family: Courier New;\">0.00000e+00, 1.15190e-04, 0.00000e+00;</span></p>
<p><span style=\"font-family: Courier New;\">-8.00446e-02, 0.00000e+00, 0.00000e+00</span></p>
<p>cPQN:</p>
<p><span style=\"font-family: Courier New;\">2.53904e-05, 1.86083e-02, -9.28813e-06, 3.15573e-09, -1.57051e-13;</span></p>
<p><span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00, 1.43568e-06, 0.00000e+00, 0.00000e+00;</span></p>
<p><span style=\"font-family: Courier New;\">0.00000e+00, 1.16467e-04, 0.00000e+00, 0.00000e+00, 0.00000e+00;</span></p>
<p><span style=\"font-family: Courier New;\">-9.73911e-02, 0.00000e+00, 0.00000e+00, 0.00000e+00, 0.00000e+00</span></p>
<h4>Comparison of Measument and Regression</h4>
<p><img src=\"modelica://AixLib/Resources/Images/DataBase/Pumps/ControlPump/Pump_DN30_1-12_13_diff-contour_HP.png\" alt=\"Absolute minimum and maximum differences in pump head and pump power draw\"/></p>
<p><img src=\"modelica://AixLib/Resources/Images/DataBase/Pumps/ControlPump/Pump_DN30_1-12_13_diff-histogram_HP.png\" alt=\"Historgram of relative differences in pump head and pump power draw\"/></p>
</html>"));
end Pump_DN30_1_12_13;
