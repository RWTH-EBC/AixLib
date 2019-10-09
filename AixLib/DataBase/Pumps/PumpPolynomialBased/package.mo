within AixLib.DataBase.Pumps;
package PumpPolynomialBased "Configuration data for pump model in Fluid.Movers.PumpPolynomialBased package"
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

    annotation(preferredView="text", Documentation(revisions="<html>
<ul>
<li>2018-07-02 by Luca Vedda:<br>Generated</li>
</ul>
</html>",   info="<html>
<p>Pump for nominal pipe diameter of 25 mm, pump head range between 1 m and 4 m and maximum volume flow rate of 3.17 m&sup3;/h.</p>
<h4>Measurement Data</h4>
<p><img src=\"modelica://AixLib/Resources/Images/DataBase/Pumps/PumpsPolynomialBased/Pump_DN25_H1_4_V3.png\" alt=\"Pump Characterisistcs\"/></p>
<p>cHQN:</p>
<p><span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00, 3.36913e-07;</span></p>
<p><span style=\"font-family: Courier New;\">0.00000e+00, 2.26535e-05, 0.00000e+00;</span></p>
<p><span style=\"font-family: Courier New;\">-1.76844e-01, 0.00000e+00, 0.00000e+00</span></p>
<p>cPQN:</p>
<p><span style=\"font-family: Courier New;\">2.49482e+00, -1.23598e-03, 1.90957e-06, -2.79676e-10, 5.88841e-14;</span></p>
<p><span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00, 1.10231e-06, 0.00000e+00, 0.00000e+00;</span></p>
<p><span style=\"font-family: Courier New;\">0.00000e+00, -4.20700e-05, 0.00000e+00, 0.00000e+00, 0.00000e+00;</span></p>
<p><span style=\"font-family: Courier New;\">-2.26424e-01, 0.00000e+00, 0.00000e+00, 0.00000e+00, 0.00000e+00</span></p>
</html>"));
  end Pump_DN25_H1_4_V3;

  record Pump_DN40_H1_12_V24 "Pump with head 1 to 12m and 24m^3/h volume flow"
    extends PumpBaseRecord(
      maxMinHeight=[
             0.00, 12.39,  1.142;
             0.83, 12.49,  1.179;
             1.65, 12.54,  1.183;
             2.48, 12.70,  1.175;
             3.31, 12.82,  1.165;
             4.13, 12.83,  1.086;
             4.96, 12.86,  0.958;
             5.79, 12.79,  0.795;
             6.61, 12.83,  0.616;
             7.44, 12.81,  0.418;
             8.27, 12.79,  0.000;
             9.09, 12.74,  0.000;
             9.92, 12.70,  0.000;
            10.75, 12.29,  0.000;
            11.57, 11.67,  0.000;
            12.40, 11.08,  0.000;
            13.23, 10.51,  0.000;
            14.05,  9.91,  0.000;
            14.88,  9.41,  0.000;
            15.71,  8.59,  0.000;
            16.53,  7.90,  0.000;
            17.36,  7.47,  0.000;
            18.19,  7.08,  0.000;
            19.01,  6.50,  0.000;
            19.84,  5.68,  0.000;
            20.67,  5.06,  0.000;
            21.49,  4.58,  0.000;
            22.32,  3.91,  0.000;
            23.15,  3.44,  0.000;
            23.97,  2.78,  0.000]
        "maximum and minimum boundaries of pump (Q,Hmax,Hmin)",
      maxMinSpeedCurves = [
             0.00, 4600, 1400;
             0.83, 4600, 1400;
             1.65, 4600, 1400;
             2.48, 4600, 1400;
             3.31, 4600, 1400;
             4.13, 4600, 1400;
             4.96, 4600, 1400;
             5.79, 4600, 1400;
             6.61, 4600, 1400;
             7.44, 4600, 1400;
             8.27, 4600, 1400;
             9.09, 4600, 1400;
             9.92, 4597, 1400;
            10.75, 4547, 1400;
            11.57, 4471, 1400;
            12.40, 4409, 1400;
            13.23, 4361, 1400;
            14.05, 4326, 1400;
            14.88, 4303, 1400;
            15.71, 4266, 1400;
            16.53, 4234, 1400;
            17.36, 4222, 1400;
            18.19, 4207, 1400;
            19.01, 4188, 1400;
            19.84, 4185, 1400;
            20.67, 4188, 1400;
            21.49, 4193, 1400;
            22.32, 4198, 1400;
            23.15, 4204, 1400;
            23.97, 4204, 1400]
        "maximum and minimum boundaries of pump speed (Q,nMax,nMin)",
      nMin=1400.0,
      nMax=4600.0,
      cHQN=[ 0.00000e+00,  0.00000e+00,  5.73723e-07;
             0.00000e+00,  6.28260e-05,  0.00000e+00;
            -2.41203e-02,  0.00000e+00,  0.00000e+00]
         "coefficients for H = f(Q,N)",
      cPQN=[ 1.88139e-05,  1.23610e-02,  4.55839e-07,  1.72215e-09,  1.78291e-13;
             0.00000e+00,  0.00000e+00,  1.09900e-06,  0.00000e+00,  0.00000e+00;
             0.00000e+00,  1.89239e-04,  0.00000e+00,  0.00000e+00,  0.00000e+00;
            -4.07739e-02,  0.00000e+00,  0.00000e+00,  0.00000e+00,  0.00000e+00]
         "coefficients for P = f(Q,N)");

    annotation(preferredView="text", Documentation(revisions="<html>
<ul>
<li>2018-07-02 by Luca Vedda:<br/>Generated</li>
</ul>
</html>",   info="<html>
<p>Pump for nominal pipe diameter of 40 mm, pump head range between 1 m and 12 m and maximum volume flow rate of 24 m&sup3;/h.</p>
<h4>Measurement Data</h4>
<p><img src=\"modelica://AixLib/Resources/Images/DataBase/Pumps/PumpsPolynomialBased/Pump_DN40_H1_12_V24.png\" alt=\"Pump Characterisistcs\"/></p>
<p>cHQN:</p>
<p><span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00, 5.73723e-07;</span></p>
<p><span style=\"font-family: Courier New;\">0.00000e+00, 6.28260e-05, 0.00000e+00;</span></p>
<p><span style=\"font-family: Courier New;\">-2.41203e-02, 0.00000e+00, 0.00000e+00</span></p>
<p>cPQN:</p>
<p><span style=\"font-family: Courier New;\">1.88139e-05, 1.23610e-02, 4.55839e-07, 1.72215e-09, 1.78291e-13;</span></p>
<p><span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00, 1.09900e-06, 0.00000e+00, 0.00000e+00;</span></p>
<p><span style=\"font-family: Courier New;\">0.00000e+00, 1.89239e-04, 0.00000e+00, 0.00000e+00, 0.00000e+00;</span></p>
<p><span style=\"font-family: Courier New;\">-4.07739e-02, 0.00000e+00, 0.00000e+00, 0.00000e+00, 0.00000e+00</span></p>
</html>"));
  end Pump_DN40_H1_12_V24;

  record Pump_DN40_H1_16_V29 "Pump with head 1 to 16m and 28.9m^3/h volume flow"
    extends PumpBaseRecord(
      maxMinHeight=[
             0.00, 17.21,  1.244;
             1.00, 17.31,  1.264;
             1.99, 17.33,  1.264;
             2.99, 17.23,  1.274;
             3.99, 17.30,  1.252;
             4.98, 16.92,  1.208;
             5.98, 16.26,  1.130;
             6.98, 15.48,  1.006;
             7.97, 14.73,  0.877;
             8.97, 13.97,  0.738;
             9.97, 13.33,  0.530;
            10.96, 12.80,  0.000;
            11.96, 12.12,  0.000;
            12.96, 11.53,  0.000;
            13.95, 10.89,  0.000;
            14.95, 10.35,  0.000;
            15.95,  9.92,  0.000;
            16.94,  9.40,  0.000;
            17.94,  8.95,  0.000;
            18.94,  8.68,  0.000;
            19.93,  8.09,  0.000;
            20.93,  7.74,  0.000;
            21.93,  7.43,  0.000;
            22.92,  6.88,  0.000;
            23.92,  6.46,  0.000;
            24.92,  5.97,  0.000;
            25.91,  5.43,  0.000;
            26.91,  4.88,  0.000;
            27.91,  4.34,  0.000;
            28.90,  3.97,  0.000]
        "maximum and minimum boundaries of pump (Q,Hmax,Hmin)",
      maxMinSpeedCurves = [
             0.00, 3500,  950;
             1.00, 3500,  950;
             1.99, 3500,  950;
             2.99, 3500,  950;
             3.99, 3500,  950;
             4.98, 3465,  950;
             5.98, 3401,  950;
             6.98, 3313,  950;
             7.97, 3219,  950;
             8.97, 3143,  950;
             9.97, 3052,  950;
            10.96, 2997,  950;
            11.96, 2928,  950;
            12.96, 2864,  950;
            13.95, 2821,  950;
            14.95, 2755,  950;
            15.95, 2738,  950;
            16.94, 2720,  950;
            17.94, 2706,  950;
            18.94, 2687,  950;
            19.93, 2674,  950;
            20.93, 2665,  950;
            21.93, 2656,  950;
            22.92, 2652,  950;
            23.92, 2649,  950;
            24.92, 2644,  950;
            25.91, 2641,  950;
            26.91, 2635,  950;
            27.91, 2624,  950;
            28.90, 2615,  950]
        "maximum and minimum boundaries of pump speed (Q,nMax,nMin)",
      nMin=950.0,
      nMax=3500.0,
      cHQN=[ 0.00000e+00,  0.00000e+00,  1.37376e-06;
             0.00000e+00,  5.53270e-05,  0.00000e+00;
            -1.16039e-02,  0.00000e+00,  0.00000e+00]
         "coefficients for H = f(Q,N)",
      cPQN=[-2.01304e+01,  7.18841e-02, -3.93834e-05,  2.34207e-08, -1.61762e-12;
             0.00000e+00,  0.00000e+00,  3.13936e-06,  0.00000e+00,  0.00000e+00;
             0.00000e+00,  1.94557e-04,  0.00000e+00,  0.00000e+00,  0.00000e+00;
            -2.08205e-02,  0.00000e+00,  0.00000e+00,  0.00000e+00,  0.00000e+00]
         "coefficients for P = f(Q,N)");

    annotation(preferredView="text", Documentation(revisions="<html>
<ul>
<li>2018-07-02 by Luca Vedda:<br/>Generated</li>
</ul>
</html>",   info="<html>
<p>Pump for nominal pipe diameter of 40 mm, pump head range between 1 m and 16 m and maximum volume flow rate of 28.9 m&sup3;/h.</p>
<h4>Measurement Data</h4>
<p><img src=\"modelica://AixLib/Resources/Images/DataBase/Pumps/PumpsPolynomialBased/Pump_DN40_H1_16_V29.png\" alt=\"Pump Characterisistcs\"/></p>
<p>cHQN:</p>
<p><span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00, 1.37376e-06;</span></p>
<p><span style=\"font-family: Courier New;\">0.00000e+00, 5.53270e-05, 0.00000e+00;</span></p>
<p><span style=\"font-family: Courier New;\">-1.16039e-02, 0.00000e+00, 0.00000e+00</span></p>
<p>cPQN:</p>
<p><span style=\"font-family: Courier New;\">-2.01304e+01, 7.18841e-02, -3.93834e-05, 2.34207e-08, -1.61762e-12;</span></p>
<p><span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00, 3.13936e-06, 0.00000e+00, 0.00000e+00;</span></p>
<p><span style=\"font-family: Courier New;\">0.00000e+00, 1.94557e-04, 0.00000e+00, 0.00000e+00, 0.00000e+00;</span></p>
<p><span style=\"font-family: Courier New;\">-2.08205e-02, 0.00000e+00, 0.00000e+00, 0.00000e+00, 0.00000e+00</span></p>
</html>"));
  end Pump_DN40_H1_16_V29;

  record Pump_DN50_H1_9_V29 "Pump with head 1 to 9m and 29.24m^3/h volume flow"
    extends PumpBaseRecord(
      maxMinHeight=[
             0.00, 11.57,  1.132;
             1.01, 11.80,  1.130;
             2.02, 11.39,  1.132;
             3.02, 11.69,  1.110;
             4.03, 11.46,  1.101;
             5.04, 12.03,  1.064;
             6.05, 11.33,  1.001;
             7.06, 10.97,  0.917;
             8.07, 11.64,  0.795;
             9.07, 10.80,  0.661;
            10.08, 10.56,  0.459;
            11.09, 10.11,  0.000;
            12.10,  9.89,  0.000;
            13.11,  9.35,  0.000;
            14.11,  8.89,  0.000;
            15.12,  8.44,  0.000;
            16.13,  8.01,  0.000;
            17.14,  7.64,  0.000;
            18.15,  7.24,  0.000;
            19.16,  6.85,  0.000;
            20.16,  6.51,  0.000;
            21.17,  6.11,  0.000;
            22.18,  5.64,  0.000;
            23.19,  5.18,  0.000;
            24.20,  4.75,  0.000;
            25.20,  4.15,  0.000;
            26.21,  3.78,  0.000;
            27.22,  3.26,  0.000;
            28.23,  2.76,  0.000;
            29.24,  2.48,  0.000]
        "maximum and minimum boundaries of pump (Q,Hmax,Hmin)",
      maxMinSpeedCurves = [
             0.00, 4600, 1400;
             1.01, 4600, 1400;
             2.02, 4485, 1400;
             3.02, 4534, 1400;
             4.03, 4489, 1400;
             5.04, 4600, 1400;
             6.05, 4474, 1400;
             7.06, 4400, 1400;
             8.07, 4525, 1400;
             9.07, 4422, 1400;
            10.08, 4347, 1400;
            11.09, 4253, 1400;
            12.10, 4219, 1400;
            13.11, 4113, 1400;
            14.11, 4050, 1400;
            15.12, 3994, 1400;
            16.13, 3948, 1400;
            17.14, 3898, 1400;
            18.15, 3863, 1400;
            19.16, 3827, 1400;
            20.16, 3818, 1400;
            21.17, 3789, 1400;
            22.18, 3782, 1400;
            23.19, 3769, 1400;
            24.20, 3770, 1400;
            25.20, 3770, 1400;
            26.21, 3775, 1400;
            27.22, 3793, 1400;
            28.23, 3797, 1400;
            29.24, 3821, 1400]
        "maximum and minimum boundaries of pump speed (Q,nMax,nMin)",
      nMin=1400.0,
      nMax=4600.0,
      cHQN=[ 0.00000e+00,  0.00000e+00,  5.39062e-07;
             0.00000e+00,  4.08623e-05,  0.00000e+00;
            -1.14430e-02,  0.00000e+00,  0.00000e+00]
         "coefficients for H = f(Q,N)",
      cPQN=[ 3.52564e-05,  2.35037e-02, -1.17407e-05,  6.50363e-09, -2.40575e-13;
             0.00000e+00,  0.00000e+00,  1.12838e-06,  0.00000e+00,  0.00000e+00;
             0.00000e+00,  1.47693e-04,  0.00000e+00,  0.00000e+00,  0.00000e+00;
            -2.42125e-02,  0.00000e+00,  0.00000e+00,  0.00000e+00,  0.00000e+00]
         "coefficients for P = f(Q,N)");

    annotation(preferredView="text", Documentation(revisions="<html>
<ul>
<li>2018-07-02 by Luca Vedda:<br/>Generated</li>
</ul>
</html>",   info="<html>
<p>Pump for nominal pipe diameter of 50 mm, pump head range between 1 m and 9 m and maximum volume flow rate of 29.24 m&sup3;/h.</p>
<h4>Measurement Data</h4>
<p><img src=\"modelica://AixLib/Resources/Images/DataBase/Pumps/PumpsPolynomialBased/Pump_DN50_H1_9_V29.png\" alt=\"Pump Characterisistcs\"/></p>
<p>cHQN:</p>
<p><span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00, 5.39062e-07;</span></p>
<p><span style=\"font-family: Courier New;\">0.00000e+00, 4.08623e-05, 0.00000e+00;</span></p>
<p><span style=\"font-family: Courier New;\">-1.14430e-02, 0.00000e+00, 0.00000e+00</span></p>
<p>cPQN:</p>
<p><span style=\"font-family: Courier New;\">3.52564e-05, 2.35037e-02, -1.17407e-05, 6.50363e-09, -2.40575e-13;</span></p>
<p><span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00, 1.12838e-06, 0.00000e+00, 0.00000e+00;</span></p>
<p><span style=\"font-family: Courier New;\">0.00000e+00, 1.47693e-04, 0.00000e+00, 0.00000e+00, 0.00000e+00;</span></p>
<p><span style=\"font-family: Courier New;\">-2.42125e-02, 0.00000e+00, 0.00000e+00, 0.00000e+00, 0.00000e+00</span></p>
</html>"));
  end Pump_DN50_H1_9_V29;

  record Pump_DN65_H1_12_V48 "Pump with head 1 to 12m and 47.88m^3/h volume flow"
    extends PumpBaseRecord(
      maxMinHeight=[
             0.00, 12.43,  1.216;
             1.65, 12.44,  1.218;
             3.30, 12.52,  1.212;
             4.95, 12.55,  1.211;
             6.60, 12.54,  1.218;
             8.26, 12.52,  1.193;
             9.91, 12.48,  1.145;
            11.56, 12.37,  1.052;
            13.21, 11.82,  0.955;
            14.86, 11.25,  0.842;
            16.51, 10.70,  0.686;
            18.16, 10.26,  0.466;
            19.81,  9.90,  0.000;
            21.47,  9.34,  0.000;
            23.12,  8.86,  0.000;
            24.77,  8.31,  0.000;
            26.42,  7.88,  0.000;
            28.07,  7.37,  0.000;
            29.72,  6.86,  0.000;
            31.37,  6.45,  0.000;
            33.02,  5.95,  0.000;
            34.68,  5.47,  0.000;
            36.33,  5.02,  0.000;
            37.98,  4.59,  0.000;
            39.63,  4.13,  0.000;
            41.28,  3.63,  0.000;
            42.93,  3.06,  0.000;
            44.58,  2.55,  0.000;
            46.23,  1.98,  0.000;
            47.88,  1.42,  0.000]
        "maximum and minimum boundaries of pump (Q,Hmax,Hmin)",
      maxMinSpeedCurves = [
             0.00, 2900,  900;
             1.65, 2900,  900;
             3.30, 2900,  900;
             4.95, 2900,  900;
             6.60, 2900,  900;
             8.26, 2900,  900;
             9.91, 2900,  900;
            11.56, 2892,  900;
            13.21, 2829,  900;
            14.86, 2746,  900;
            16.51, 2680,  900;
            18.16, 2622,  900;
            19.81, 2565,  900;
            21.47, 2500,  900;
            23.12, 2452,  900;
            24.77, 2409,  900;
            26.42, 2376,  900;
            28.07, 2337,  900;
            29.72, 2303,  900;
            31.37, 2288,  900;
            33.02, 2260,  900;
            34.68, 2241,  900;
            36.33, 2228,  900;
            37.98, 2213,  900;
            39.63, 2199,  900;
            41.28, 2189,  900;
            42.93, 2183,  900;
            44.58, 2185,  900;
            46.23, 2189,  900;
            47.88, 2190,  900]
        "maximum and minimum boundaries of pump speed (Q,nMax,nMin)",
      nMin=900.0,
      nMax=2900.0,
      cHQN=[ 0.00000e+00,  0.00000e+00,  1.42201e-06;
             0.00000e+00,  4.24097e-05,  0.00000e+00;
            -4.17356e-03,  0.00000e+00,  0.00000e+00]
         "coefficients for H = f(Q,N)",
      cPQN=[-1.00813e+02,  3.06965e-01, -2.80623e-04,  1.33917e-07, -1.60284e-11;
             0.00000e+00,  0.00000e+00,  2.48789e-06,  0.00000e+00,  0.00000e+00;
             0.00000e+00,  1.74281e-04,  0.00000e+00,  0.00000e+00,  0.00000e+00;
            -7.79974e-03,  0.00000e+00,  0.00000e+00,  0.00000e+00,  0.00000e+00]
         "coefficients for P = f(Q,N)");

    annotation(preferredView="text", Documentation(revisions="<html>
<ul>
<li>2018-07-02 by Luca Vedda:<br/>Generated</li>
</ul>
</html>",   info="<html>
<p>Pump for nominal pipe diameter of 65 mm, pump head range between 1 m and 12 m and maximum volume flow rate of 47.88  m&sup3;/h.</p>
<h4>Measurement Data</h4>
<p><img src=\"modelica://AixLib/Resources/Images/DataBase/Pumps/PumpsPolynomialBased/Pump_DN65_H1_12_V48.png\" alt=\"Pump Characterisistcs\"/></p>
<p>cHQN:</p>
<p><span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00, 1.42201e-06;</span></p>
<p><span style=\"font-family: Courier New;\">0.00000e+00, 4.24097e-05, 0.00000e+00;</span></p>
<p><span style=\"font-family: Courier New;\">-4.17356e-03, 0.00000e+00, 0.00000e+00</span></p>
<p>cPQN:</p>
<p><span style=\"font-family: Courier New;\">-1.00813e+02, 3.06965e-01, -2.80623e-04, 1.33917e-07, -1.60284e-11;</span></p>
<p><span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00, 2.48789e-06, 0.00000e+00, 0.00000e+00;</span></p>
<p><span style=\"font-family: Courier New;\">0.00000e+00, 1.74281e-04, 0.00000e+00, 0.00000e+00, 0.00000e+00;</span></p>
<p><span style=\"font-family: Courier New;\">-7.79974e-03, 0.00000e+00, 0.00000e+00, 0.00000e+00, 0.00000e+00</span></p>
</html>"));
  end Pump_DN65_H1_12_V48;

  record Pump_DN65_H1_16_V26 "Pump with head 1 to 16m and 26.23m^3/h volume flow"
    extends PumpBaseRecord(
      maxMinHeight=[
             0.00,  1.92,  1.315;
             0.90,  1.92,  1.326;
             1.81,  1.92,  1.327;
             2.71,  1.92,  1.336;
             3.62,  1.92,  1.326;
             4.52,  1.92,  1.315;
             5.43,  1.92,  1.326;
             6.33,  1.92,  1.320;
             7.24,  1.92,  1.326;
             8.14,  1.92,  1.295;
             9.05,  1.92,  1.269;
             9.95,  1.92,  1.236;
            10.85,  1.92,  1.195;
            11.76,  1.92,  1.133;
            12.66,  1.92,  1.091;
            13.57,  1.92,  1.041;
            14.47,  1.86,  0.975;
            15.38,  1.80,  0.887;
            16.28,  1.74,  0.785;
            17.19,  1.65,  0.688;
            18.09,  1.58,  0.612;
            18.99,  1.49,  0.510;
            19.90,  1.40,  0.360;
            20.80,  1.30,  0.000;
            21.71,  1.16,  0.000;
            22.61,  1.06,  0.000;
            23.52,  0.95,  0.000;
            24.42,  0.70,  0.000;
            25.33,  0.42,  0.000;
            26.23,  0.47,  0.000]
        "maximum and minimum boundaries of pump (Q,Hmax,Hmin)",
      maxMinSpeedCurves = [
             0.00, 1200,  950;
             0.90, 1200,  950;
             1.81, 1200,  950;
             2.71, 1200,  950;
             3.62, 1200,  950;
             4.52, 1200,  950;
             5.43, 1200,  950;
             6.33, 1200,  950;
             7.24, 1200,  950;
             8.14, 1200,  950;
             9.05, 1200,  950;
             9.95, 1200,  950;
            10.85, 1200,  950;
            11.76, 1200,  950;
            12.66, 1200,  950;
            13.57, 1200,  950;
            14.47, 1200,  950;
            15.38, 1200,  950;
            16.28, 1200,  950;
            17.19, 1200,  950;
            18.09, 1200,  950;
            18.99, 1200,  950;
            19.90, 1200,  950;
            20.80, 1200,  950;
            21.71, 1200,  950;
            22.61, 1200,  950;
            23.52, 1200,  950;
            24.42, 1200,  950;
            25.33, 1200,  950;
            26.23, 1200,  950]
        "maximum and minimum boundaries of pump speed (Q,nMax,nMin)",
      nMin=950.0,
      nMax=1200.0,
      cHQN=[ 0.00000e+00,  0.00000e+00,  1.38419e-06;
             0.00000e+00,  4.69154e-05,  0.00000e+00;
            -4.44085e-03,  0.00000e+00,  0.00000e+00]
         "coefficients for H = f(Q,N)",
      cPQN=[ 4.29488e-16,  3.38555e-13,  2.38276e-10,  1.26342e-07, -6.75873e-11;
             0.00000e+00,  0.00000e+00,  3.44640e-06,  0.00000e+00,  0.00000e+00;
             0.00000e+00,  6.63336e-05,  0.00000e+00,  0.00000e+00,  0.00000e+00;
            -4.81313e-03,  0.00000e+00,  0.00000e+00,  0.00000e+00,  0.00000e+00]
         "coefficients for P = f(Q,N)");

    annotation(preferredView="text", Documentation(revisions="<html>
<ul>
<li>2018-09-21 by Luca Vedda:<br/>Generated</li>
</ul>
</html>",   info="<html>
<p>Pump for nominal pipe diameter of 65 mm, pump head range between 1 m and 16 m and maximum volume flow rate of 26.23 m&sup3;/h.</p>
<h4>Measurement Data</h4>
<p><img src=\"modelica://AixLib/Resources/Images/DataBase/Pumps/PumpsPolynomialBased/Pump_DN65_H1_16_V26.png\" alt=\"Pump Characterisistcs\"/></p>
<p>cHQN:</p>
<p><span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00, 1.38419e-06;</span></p>
<p><span style=\"font-family: Courier New;\">0.00000e+00, 4.69154e-05, 0.00000e+00;</span></p>
<p><span style=\"font-family: Courier New;\">-4.44085e-03, 0.00000e+00, 0.00000e+00</span></p>
<p>cPQN:</p>
<p><span style=\"font-family: Courier New;\">4.29488e-16, 3.38555e-13, 2.38276e-10, 1.26342e-07, -6.75873e-11;</span></p>
<p><span style=\"font-family: Courier New;\">0.00000e+00, 0.00000e+00, 3.44640e-06, 0.00000e+00, 0.00000e+00;</span></p>
<p><span style=\"font-family: Courier New;\">0.00000e+00, 6.63336e-05, 0.00000e+00, 0.00000e+00, 0.00000e+00;</span></p>
<p><span style=\"font-family: Courier New;\">-4.81313e-03, 0.00000e+00, 0.00000e+00, 0.00000e+00, 0.00000e+00</span></p>
</html>"));
  end Pump_DN65_H1_16_V26;

  annotation (Documentation(revisions="<html>
<ul>
<li>2018-05-14 by Peter Matthes:<br/>Transfered package from internal &quot;Zugabe&quot; library into AixLib.</li>
</ul>
</html>"));
end PumpPolynomialBased;
