within AixLib.DataBase.Pumps.PumpPolynomialBased;
record Pump_DN25_H1_4_V3 "Pump with head 1 to 4m and 3.17m^3/h volume flow"
  extends PumpBaseRecord(
    maxMinHeight=[
           0.00,  0.49,  4.098;
           0.11,  0.48,  3.924;
           0.22,  0.48,  3.751;
           0.33,  0.48,  3.555;
           0.44,  0.46,  3.354;
           0.55,  0.45,  3.158;
           0.65,  0.43,  2.966;
           0.76,  0.41,  2.788;
           0.87,  0.37,  2.621;
           0.98,  0.34,  2.477;
           1.09,  0.30,  2.351;
           1.20,  0.26,  2.224;
           1.31,  0.21,  2.097;
           1.42,  0.16,  1.975;
           1.53,  0.11,  1.864;
           1.64,  0.06,  1.749;
           1.75,  0.02,  1.626;
           1.86,  0.00,  1.504;
           1.96,  0.00,  1.389;
           2.07,  0.00,  1.274;
           2.18,  0.00,  1.158;
           2.29,  0.00,  1.044;
           2.40,  0.00,  0.940;
           2.51,  0.00,  0.837;
           2.62,  0.00,  0.736;
           2.73,  0.00,  0.635;
           2.84,  0.00,  0.547;
           2.95,  0.00,  0.459;
           3.06,  0.00,  0.367;
           3.17,  0.00,  0.275]
      "maximum and minimum boundaries of pump (Q,Hmax,Hmin)",
    maxMinSpeedCurves = [
           0.00, 1200, 3494;
           0.11, 1200, 3418;
           0.22, 1200, 3343;
           0.33, 1200, 3251;
           0.44, 1200, 3153;
           0.55, 1200, 3065;
           0.65, 1200, 2981;
           0.76, 1200, 2905;
           0.87, 1200, 2834;
           0.98, 1200, 2772;
           1.09, 1200, 2717;
           1.20, 1200, 2665;
           1.31, 1200, 2616;
           1.42, 1200, 2572;
           1.53, 1200, 2542;
           1.64, 1200, 2510;
           1.75, 1200, 2474;
           1.86, 1200, 2441;
           1.96, 1200, 2420;
           2.07, 1200, 2399;
           2.18, 1200, 2376;
           2.29, 1200, 2354;
           2.40, 1200, 2347;
           2.51, 1200, 2340;
           2.62, 1200, 2335;
           2.73, 1200, 2330;
           2.84, 1200, 2334;
           2.95, 1200, 2339;
           3.06, 1200, 2340;
           3.17, 1200, 2340]
      "maximum and minimum boundaries of pump speed (Q,nMax,nMin)",
    nMin=1200,
    nMax=3495,
    cHQN=[ 0.00000e+00,  0.00000e+00,  3.36913e-07;
           0.00000e+00,  2.26535e-05,  0.00000e+00;
          -1.76844e-01,  0.00000e+00,  0.00000e+00]
       "coefficients for H = f(Q,N)",
    cPQN=[ 2.49482e+00, -1.23598e-03,  1.90957e-06, -2.79676e-10,  5.88841e-14;
           0.00000e+00,  0.00000e+00,  1.10231e-06,  0.00000e+00,  0.00000e+00;
           0.00000e+00, -4.20700e-05,  0.00000e+00,  0.00000e+00,  0.00000e+00;
          -2.26424e-01,  0.00000e+00,  0.00000e+00,  0.00000e+00,  0.00000e+00]
       "coefficients for P = f(Q,N)");

  annotation(preferredView="text", Documentation(revisions="<html><ul>
  <li>2018-07-02 by Luca Vedda:<br/>
    Generated
  </li>
</ul>
</html>", info="<html>
<p>
  Pump for nominal pipe diameter of 25 mm, pump head range between 1 m
  and 4 m and maximum volume flow rate of 3.17 m³/h.
</p>
<h4>
  Measurement Data
</h4>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/DataBase/Pumps/PumpsPolynomialBased/Pump_DN25_H1_4_V3.png\"
  alt=\"Pump Characterisistcs\">
</p>
<p>
  cHQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  3.36913e-07;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 2.26535e-05,
  0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-1.76844e-01, 0.00000e+00,
  0.00000e+00</span>
</p>
<p>
  cPQN:
</p>
<p>
  <span style=\"font-family: Courier New;\">2.49482e+00, -1.23598e-03,
  1.90957e-06, -2.79676e-10, 5.88841e-14;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00,
  1.10231e-06, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">0.00000e+00, -4.20700e-05,
  0.00000e+00, 0.00000e+00, 0.00000e+00;</span>
</p>
<p>
  <span style=\"font-family: Courier New;\">-2.26424e-01, 0.00000e+00,
  0.00000e+00, 0.00000e+00, 0.00000e+00</span>
</p>
</html>"));
end Pump_DN25_H1_4_V3;
