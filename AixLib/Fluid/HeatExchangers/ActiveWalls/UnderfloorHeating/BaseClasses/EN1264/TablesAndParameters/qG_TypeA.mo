within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.EN1264.TablesAndParameters;
model qG_TypeA
  "Calculating the limiting heat flux for underfloor heating Types A and C according to EN 1264"
  import Modelica.Constants.e;

  extends
    UnderfloorHeating.BaseClasses.EN1264.TablesAndParameters.K_H_TypeA;

  parameter Modelica.Units.SI.Temperature T_Fmax "maximum surface temperature";
  parameter Modelica.Units.SI.Temperature T_Room "Room temperature";

  final parameter Real f_G = if s_u/T <= 0.173 then 1 else (q_Gmax - (q_Gmax - phi * B_G * (dT_HG375 / phi) ^(n_G) * 0.375 / T) * e^(-20 * (s_u / T - 0.173)^2)) / (phi * B_G * (dT_HG375 / phi) ^(n_G) * 0.375 / T);
  final parameter Real phi = ((T_Fmax - T_Room) / d_T0)^(1.1);
  final parameter Modelica.Units.SI.TemperatureDifference d_T0=9;
  final parameter Real B_G = if s_u / lambda_E <= 0.0792 then
    tableA4.y
 else
     tableA5.y;
  final parameter Real n_G = if s_u / lambda_E <= 0.0792 then
    tableA6.y
  else
    tableA7.y;

  final parameter Modelica.Units.SI.HeatFlux q_G=if T <= 0.375 then phi*B_G*(
      dT_HG/phi)^(n_G) else phi*B_G*(dT_HG/phi)^(n_G)*0.375/T*f_G
    "limiting heat flux";

  parameter Modelica.Units.SI.HeatFlux q_Gmax "maximum possible heat flux";

  final parameter Modelica.Units.SI.TemperatureDifference dT_HG375=phi*(B_G/(B*
      product_ai))^(1/(1 - n_G))
    "maximum temperature difference at Spacing = 0.375 m";
  final parameter Modelica.Units.SI.TemperatureDifference dT_HG=if T <= 0.375
       then phi*(B_G/(B*product_ai))^(1/(1 - n_G)) else phi*(B_G/(B*product_ai))
      ^(1/(1 - n_G))*f_G
    "maximum temperature difference between heating medium and room";
  parameter Modelica.Units.SI.TemperatureDifference dT_H
    "logarithmic temperature difference between heating medium and room";

  Tables.CombiTable2DParameter tableA4(
    table=[0.0,0.01,0.0208,0.0292,0.0375,0.0458,0.0542,0.0625,0.0708,0.0792; 0.05,
        85,91.5,96.8,100,100,100,100,100,100; 0.075,75.3,83.5,89.9,96.3,99.5,100,
        100,100,100; 0.1,66,75.4,82.9,89.3,95.5,98.8,100,100,100; 0.15,51,61.1,69.2,
        76.3,82.7,87.5,91.8,95.1,97.8; 0.2,38.5,48.2,56.2,63.1,69.1,74.5,81.3,86.4,
        90; 0.225,33,42.5,49.5,56.5,62,67.5,75.3,81.6,86.1; 0.3,20.5,26.8,31.6,36.4,
        41.5,47.5,57.5,65.3,72.4; 0.375,11.5,13.7,15.5,18.2,21.5,27.5,40,49.1,58.3],
    u2=s_u/lambda_E,
    u1=if T <= 0.375 then T else 0.375)
    "Table A.4 according to prEN 1264-2 p. 29"
    annotation (Placement(transformation(extent={{-96,-60},{-70,-34}})));

  Tables.CombiTable1DParameter tableA5(table=[0.173,27.5; 0.20,40; 0.25,57.5; 0.30,
        69.5; 0.35,78.2; 0.40,84.4; 0.45,88.3; 0.50,91.6; 0.55,94; 0.60,96.3; 0.65,
        98.6; 0.70,99.8; 0.75,100], u=if T <= 0.375 then s_u/T else s_u/0.375)
    "Table A.5 according to prEN 1264-2 p. 29"
    annotation (Placement(transformation(extent={{-54,-60},{-28,-34}})));

  Tables.CombiTable2DParameter tableA6(
    table=[0.0,0.01,0.0208,0.0292,0.0375,0.0458,0.0542,0.0625,0.0708,0.0792; 0.05,
        0.008,0.005,0.002,0,0,0,0,0,0; 0.075,0.024,0.021,0.018,0.011,0.002,0,0,0,
        0; 0.1,0.046,0.043,0.041,0.033,0.014,0.005,0,0,0; 0.15,0.088,0.085,0.082,
        0.076,0.055,0.038,0.024,0.014,0.006; 0.2,0.131,0.13,0.129,0.123,0.105,0.083,
        0.057,0.04,0.028; 0.225,0.155,0.154,0.153,0.146,0.13,0.11,0.077,0.056,0.041;
        0.2625,0.197,0.196,0.196,0.19,0.173,0.15,0.11,0.083,0.062; 0.3,0.254,0.253,
        0.253,0.245,0.228,0.195,0.145,0.114,0.086; 0.3375,0.322,0.321,0.321,0.31,
        0.293,0.26,0.187,0.148,0.115; 0.375,0.422,0.421,0.421,0.405,0.385,0.325,
        0.23,0.183,0.142],
    u2=s_u/lambda_E,
    u1=if T <= 0.375 then T else 0.375)
    "Table A.6 according to prEN 1264-2 p. 30"
    annotation (Placement(transformation(extent={{-96,-96},{-70,-70}})));
  Tables.CombiTable1DParameter tableA7(table=[0.173,0.32; 0.2,0.23; 0.25,0.145;
        0.3,0.097; 0.35,0.067; 0.4,0.048; 0.45,0.033; 0.5,0.023; 0.55,0.015; 0.6,
        0.009; 0.65,0.005; 0.7,0.002; 0.75,0], u=if T <= 0.375 then s_u/T else
        s_u/0.375) "Table A.7 according to prEN 1264-2 p. 30"
    annotation (Placement(transformation(extent={{-54,-96},{-28,-70}})));

initial equation
  assert(dT_H <= dT_HG, "Temperature difference between medium and room seems to be higher than the maximum temperature difference (see EN 1264)");

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end qG_TypeA;
