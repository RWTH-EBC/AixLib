within AixLib.DataBase.Pumps.PumpPolynomialBased;
record Pump_DN40 "Pump with head 1 to 12m and 21m^3/h volume flow"
  extends PumpBaseRecord(
    maxMinHeight=[
           0.00, 11.89,  0.789;
           0.73, 11.88,  0.773;
           1.45, 11.88,  0.754;
           2.18, 11.90,  0.702;
           2.91, 11.91,  0.625;
           3.63, 11.91,  0.528;
           4.36, 11.88,  0.416;
           5.09, 11.79,  0.271;
           5.81, 11.69,  0.000;
           6.54, 11.53,  0.000;
           7.27, 11.30,  0.000;
           7.99, 11.07,  0.000;
           8.72, 10.78,  0.000;
           9.45, 10.44,  0.000;
          10.17, 10.11,  0.000;
          10.90,  9.80,  0.000;
          11.63,  9.45,  0.000;
          12.35,  9.09,  0.000;
          13.08,  8.63,  0.000;
          13.81,  8.17,  0.000;
          14.53,  7.69,  0.000;
          15.26,  7.19,  0.000;
          15.99,  6.66,  0.000;
          16.71,  6.12,  0.000;
          17.44,  5.57,  0.000;
          18.17,  5.01,  0.000;
          18.89,  4.41,  0.000;
          19.62,  3.78,  0.000;
          20.35,  3.16,  0.000;
          21.08,  2.55,  0.000]
      "maximum and minimum boundaries of pump (Q,Hmax,Hmin)",
    maxMinSpeedCurves = [
           0.00, 2933,  768;
           0.73, 2931,  767;
           1.45, 2930,  767;
           2.18, 2929,  766;
           2.91, 2929,  767;
           3.63, 2928,  766;
           4.36, 2928,  766;
           5.09, 2927,  766;
           5.81, 2927,  766;
           6.54, 2927,  766;
           7.27, 2926,  766;
           7.99, 2926,  766;
           8.72, 2925,  766;
           9.45, 2924,  766;
          10.17, 2923,  766;
          10.90, 2922,  766;
          11.63, 2922,  766;
          12.35, 2922,  766;
          13.08, 2915,  766;
          13.81, 2908,  766;
          14.53, 2899,  766;
          15.26, 2887,  766;
          15.99, 2883,  766;
          16.71, 2884,  766;
          17.44, 2884,  766;
          18.17, 2885,  766;
          18.89, 2885,  766;
          19.62, 2886,  766;
          20.35, 2887,  766;
          21.08, 2889,  766]
      "maximum and minimum boundaries of pump speed (Q,nMax,nMin)",
    nMin=765.0,
    nMax=2930.0,
    cHQN=[ 0.00000e+00,  0.00000e+00,  1.38228e-06;
           0.00000e+00,  2.99931e-05,  0.00000e+00;
          -2.43139e-02,  0.00000e+00,  0.00000e+00]
       "coefficients for H = f(Q,N)",
    cPQN=[ 7.76957e+00,  7.17032e-02, -5.12390e-05,  3.36215e-08, -3.02196e-12;
           0.00000e+00,  0.00000e+00,  4.75172e-06,  0.00000e+00,  0.00000e+00;
           0.00000e+00, -2.61724e-04,  0.00000e+00,  0.00000e+00,  0.00000e+00;
          -9.99727e-03,  0.00000e+00,  0.00000e+00,  0.00000e+00,  0.00000e+00]
       "coefficients for P = f(Q,N)");

  annotation(preferredView="text", Documentation(revisions="<html><ul>
  <li>2018-09-28 by Luca Vedda:<br/>
    Generated
  </li>
</ul>
</html>", info="<html>
<p>
  Pump for nominal pipe diameter of 40 mm, pump head range between 1 m
  and 12 m and maximum volume flow rate of 21 m³/h.
</p>
<h4>
  Measurement Data
</h4>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/DataBase/Pumps/PumpsPolynomialBased/Pump_DN40.png\"
  alt=\"Pump Characterisistcs\">
</p>
<p>
  cHQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  1.38228e-06;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 2.99931e-05,
  0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-2.43139e-02, 0.00000e+00,
  0.00000e+00</span>
</p>
<p>
  cPQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">7.76957e+00, 7.17032e-02,
  -5.12390e-05, 3.36215e-08, -3.02196e-12;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  4.75172e-06, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, -2.61724e-04,
  0.00000e+00, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-9.99727e-03, 0.00000e+00,
  0.00000e+00, 0.00000e+00, 0.00000e+00</span>
</p>
</html>"));
end Pump_DN40;
