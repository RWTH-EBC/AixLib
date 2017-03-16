within AixLib.Utilities.Sensors.ExergyMeter;
model StoredExergyMeter

    extends Modelica.Icons.RotationalSensor;

  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium in the sensor" annotation (choicesAllMatching=true);

  parameter Integer n=1 "Number of identical volumes";

  parameter Modelica.SIunits.Mass mass=100 "mass of each layer";
  parameter Modelica.SIunits.Temperature T_start=323.15
    "Start reference temperature of medium"
    annotation (Dialog(tab="Initialisation"));
  parameter Modelica.SIunits.Temperature T_ref_start=273.15
    "Start reference temperature" annotation (Dialog(tab="Initialisation"));
  parameter Modelica.SIunits.Energy exergyContent_start = 1e+05
    "Start exergy content" annotation (Dialog(tab="Initialisation"));

  Modelica.Fluid.Sensors.SpecificEntropy specificEntropy[n](redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{70,0},{50,20}})));
  Modelica.Fluid.Sensors.SpecificEnthalpy specificEnthalpy[n](redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{-70,0},{-50,20}})));
public
  Modelica.Blocks.Interfaces.RealInput T_ref(final unit="K", displayUnit="degC",
    final quantity="ThermodynamicTemperature", min=0) "Reference temperature for EXERGY calculations in K.
  It must be distinguished between the the reference temperature used for exergy calculations and the reference
  for enthalpy/inner energy calculations. The latter should time invariant and the same for all components of a system"
    annotation (Placement(transformation(extent={{-120,50},{-80,90}})));
  Modelica.Blocks.Interfaces.RealInput p_ref(final quantity="Pressure", final unit="Pa", displayUnit="bar", min=0)
    "Reference pressure"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}}),
        iconTransformation(extent={{-120,-20},{-80,20}})));
  Modelica.Fluid.Sensors.SpecificEnthalpy specificEnthalpy1[n](redeclare
      package Medium = Medium)
    annotation (Placement(transformation(extent={{-10,60},{-30,40}})));
  Modelica.Fluid.Sensors.SpecificEntropy specificEntropy1[n](redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{10,60},{30,40}})));
  Modelica.Blocks.Interfaces.RealOutput ExergyChangeRate(final quantity="Power",
      final unit="W") annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={106,-62})));
  Modelica.Fluid.Sources.Boundary_pT referenceEnvironment[n](
    redeclare package Medium = Medium,
    each use_p_in=true,
    each nPorts=2,
    each use_T_in=true,
    each use_X_in=true)  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,80})));
  Modelica.Fluid.Sources.Boundary_pT boundary[n](
    redeclare package Medium = Medium,
    each use_p_in=true,
    each use_T_in=true,
    each nPorts=2,
    each use_X_in=true)
                   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,0})));
public
  Modelica.Blocks.Interfaces.RealInput T[n](
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature",
    min=0) "Reference temperature for EXERGY calculations in K.
  It must be distinguished between the the reference temperature used for exergy calculations and the reference
  for enthalpy/inner energy calculations. The latter should time invariant and the same for all components of a system"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-112}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-100})));
  Modelica.Blocks.Interfaces.RealInput p(
    final quantity="Pressure",
    final unit="Pa",
    displayUnit="bar",
    min=0) "Reference pressure" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-50,-110})));
  Modelica.Blocks.Math.Sum sum1(nin=n)
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  Modelica.Blocks.Math.Gain gain(k=mass)
    annotation (Placement(transformation(extent={{-26,-57},{-12,-43}})));
  Modelica.Blocks.Math.Add add[n](each k1=-1)
    annotation (Placement(transformation(extent={{-46,33},{-60,47}})));
  Modelica.Blocks.Math.Add add1[n](each k1=-1)
    annotation (Placement(transformation(extent={{46,33},{60,47}})));
  Modelica.Blocks.Math.Sum sum2(nin=n)
    annotation (Placement(transformation(extent={{64,-42},{44,-22}})));
  Modelica.Blocks.Math.Add add2(each k1=-1)
    annotation (Placement(transformation(extent={{38,-69},{52,-55}})));
  Modelica.Blocks.Continuous.Derivative derivative(
    x_start=exergyContent_start,
    initType=Modelica.Blocks.Types.Init.InitialState,
    T=10)
    annotation (Placement(transformation(extent={{64,-72},{84,-52}})));
  Modelica.Blocks.Interfaces.RealOutput exergyContent(
    start=exergyContent_start,
    final quantity="Energy",
    final unit="J") annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={106,-32})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=270,
        origin={14,-46})));
  Modelica.Blocks.Math.Gain gain1(
                                 k=mass)
    annotation (Placement(transformation(extent={{-7,-7},{7,7}},
        rotation=180,
        origin={27,-32})));
  Modelica.Blocks.Interfaces.RealInput X_ref[Medium.nX](final quantity="MassFraction", final unit="1", min=0, max=1)
    "Reference composition"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,-70})));
  Modelica.Blocks.Interfaces.RealInput X[Medium.nX](
    final quantity="MassFraction",
    final unit="1",
    min=0,
    max=1) "Reference composition" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={50,-110})));
equation

  for i in 1:n loop
    connect(p, boundary[i].p_in) annotation (Line(points={{-50,-110},{-50,-72},{
            -8,-72},{-8,-12}}, color={0,0,127}));
    connect(T_ref, referenceEnvironment[i].T_in) annotation (Line(points={{-100,70},
            {-76,70},{-76,96},{4,96},{4,92}}, color={0,0,127}));
    connect(p_ref, referenceEnvironment[i].p_in) annotation (Line(points={{-100,0},
            {-78,0},{-78,98},{8,98},{8,92}},  color={0,0,127}));
    connect(X, boundary[i].X_in) annotation (Line(points={{50,-110},{50,-80},{2,-80},
          {2,-20},{4,-20},{4,-12}}, color={0,0,127}));
    connect(X_ref, referenceEnvironment[i].X_in) annotation (Line(points={{-100,-70},
          {-72,-70},{-72,92},{-4,92}}, color={0,0,127}));

  end for;

  connect(specificEnthalpy[:].port, boundary[:].ports[1]) annotation (Line(
        points={{-60,0},{-40,0},{-20,0},{-20,20},{-4,20},{-2,20},{-2,10}},
        color={0,127,255}));
  connect(specificEntropy[:].port, boundary[:].ports[2]) annotation (Line(
        points={{60,0},{40,0},{20,0},{20,20},{2,20},{2,10}}, color={0,127,255}));
  connect(specificEnthalpy1.h_out, add.u1) annotation (Line(points={{-31,50},{-38,
          50},{-38,44.2},{-44.6,44.2}}, color={0,0,127}));
  connect(specificEnthalpy.h_out, add.u2) annotation (Line(points={{-49,10},{-40,
          10},{-40,35.8},{-44.6,35.8}}, color={0,0,127}));
  connect(add.y, sum1.u) annotation (Line(points={{-60.7,40},{-60.7,40},{-74,40},
          {-74,-50},{-62,-50}},color={0,0,127}));
  connect(sum1.y, gain.u) annotation (Line(points={{-39,-50},{-34,-50},{-27.4,-50}},
        color={0,0,127}));
  connect(specificEntropy1.s, add1.u1) annotation (Line(points={{31,50},{36,50},
          {36,44.2},{44.6,44.2}}, color={0,0,127}));
  connect(specificEntropy.s, add1.u2) annotation (Line(points={{49,10},{40,10},{
          40,35.8},{44.6,35.8}}, color={0,0,127}));
  connect(add1.y, sum2.u) annotation (Line(points={{60.7,40},{60.7,40},{84,40},{
          84,-32},{66,-32}},
                          color={0,0,127}));
  connect(derivative.y, ExergyChangeRate)
    annotation (Line(points={{85,-62},{106,-62}}, color={0,0,127}));
  connect(specificEnthalpy1[:].port, referenceEnvironment[:].ports[1])
    annotation (Line(points={{-20,60},{-20,70},{2,70}},  color={0,127,255}));
  connect(specificEntropy1[:].port, referenceEnvironment[:].ports[2])
    annotation (Line(points={{20,60},{20,70},{-2,70}},color={0,127,255}));
  connect(sum2.y, gain1.u) annotation (Line(points={{43,-32},{40,-32},{35.4,-32}},
                 color={0,0,127}));
  connect(gain1.y, product.u1) annotation (Line(points={{19.3,-32},{14,-32},{14,
          -38.8},{17.6,-38.8}},     color={0,0,127}));
  connect(T_ref, product.u2) annotation (Line(points={{-100,70},{-76,70},{-76,-28},
          {10.4,-28},{10.4,-38.8}},        color={0,0,127}));
  connect(derivative.u, add2.y)
    annotation (Line(points={{62,-62},{52.7,-62}}, color={0,0,127}));
  connect(gain.y, add2.u2) annotation (Line(points={{-11.3,-50},{4,-50},{4,-66.2},
          {36.6,-66.2}},        color={0,0,127}));
  connect(product.y, add2.u1) annotation (Line(points={{14,-52.6},{14,-57.8},{36.6,
          -57.8}},       color={0,0,127}));
  connect(add2.y, exergyContent) annotation (Line(points={{52.7,-62},{58,-62},{58,
          -44},{90,-44},{90,-32},{106,-32}},          color={0,0,127}));
  connect(T, boundary.T_in) annotation (Line(points={{0,-112},{0,-112},{0,
          -28},{0,-22},{-4,-22},{-4,-12}},
                                     color={0,0,127}));

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})), Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">The model calculates the exergy content and its rate of change of a stratefied storage (i. e. with multiple layers) filled with a medium consisting of multiple substances. The reference environment is variable. The basic equation is</span></p>
<p><img src=\"modelica://ExergyBasedControl/Resources/Images/equations/equation-B3j7w7SU.png\" alt=\"E=m*(h-h_ref-T_ref*(s-s_ref))\"/></p>
<p>with <img src=\"modelica://ExergyBasedControl/Resources/Images/equations/equation-rWx4uyq3.png\" alt=\"E\"/>: exergy content, <img src=\"modelica://ExergyBasedControl/Resources/Images/equations/equation-oMdqxJls.png\" alt=\"m\"/>: mass, <img src=\"modelica://ExergyBasedControl/Resources/Images/equations/equation-LOSkR7rF.png\" alt=\"h\"/>: specific enthalpy, <img src=\"modelica://ExergyBasedControl/Resources/Images/equations/equation-0FrlJuWk.png\" alt=\"T\"/>: temperature, <img src=\"modelica://ExergyBasedControl/Resources/Images/equations/equation-aAdwzFu5.png\" alt=\"s\"/>:specific entropy</p>
<p><span style=\"font-family: MS Shell Dlg 2;\">The reference environment (subscript </span><img src=\"modelica://ExergyBasedControl/Resources/Images/equations/equation-TfOsTMad.png\" alt=\"_ref\"/>) <span style=\"font-family: MS Shell Dlg 2;\">is modeled using a boundary with temperature, pressure and composition as input. The medium model is replaceable. The physical enthalpy and entropy are determined using the respective sensors from MSL. The rate of change of the exergy content is calculated using the approximate derivative block from MSL.</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">Level of Development</span></b> </p>
<p><span style=\"font-family: MS Shell Dlg 2;\"><img src=\"modelica://AixLib/Resources/Images/Stars/stars3.png\"/></span></p>
</html>", revisions="<html>
<ul>
<li><i><span style=\"font-family: Arial,sans-serif;\">November 10, 2016&nbsp;</i> by Marc Baranski and Roozbeh Sangi:<br>Implemented.</span></li>
</ul>
</html>"));
end StoredExergyMeter;
