within AixLib.Utilities.Sensors.ExergyMeter;
model StoredExergyMeter

    extends Modelica.Icons.RoundSensor;

  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium in the sensor" annotation (choicesAllMatching=true);

  parameter Integer n=1 "Number of identical volumes";

  parameter Modelica.Units.SI.Mass mass=100 "mass of each layer";
  parameter Modelica.Units.SI.Temperature T_start=323.15
    "Start reference temperature of medium"
    annotation (Dialog(tab="Initialisation"));
  parameter Modelica.Units.SI.Temperature T_ref_start=273.15
    "Start reference temperature" annotation (Dialog(tab="Initialisation"));
  parameter Modelica.Units.SI.Energy exergyContent_start=1e+05
    "Start exergy content" annotation (Dialog(tab="Initialisation"));

  Modelica.Fluid.Sensors.SpecificEntropy specificEntropy[n](redeclare package Medium =
               Medium)
    "Specific entropy of the medium used in exergy calculations"
    annotation (Placement(transformation(extent={{70,0},{50,20}})));
  Modelica.Fluid.Sensors.SpecificEnthalpy specificEnthalpy[n](redeclare package
                                                                                Medium =
               Medium)
    "Specific enthalpy of the medium used in exergy calculations"
    annotation (Placement(transformation(extent={{-70,0},{-50,20}})));

  Modelica.Blocks.Interfaces.RealInput T_ref(final unit="K", displayUnit="degC",
    final quantity="ThermodynamicTemperature", min=0)
    "Reference temperature for exergy calculations in K"
    annotation (Placement(transformation(extent={{-120,50},{-80,90}})));
  Modelica.Blocks.Interfaces.RealInput p_ref(
  final quantity="Pressure", final unit="Pa", displayUnit="bar", min=0)
    "Reference pressure"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}}),
        iconTransformation(extent={{-120,-20},{-80,20}})));
  Modelica.Fluid.Sensors.SpecificEnthalpy specificEnthalpyRef[n](redeclare
      package                                                                      Medium =
                       Medium) "Specific enthalpy of the reference environment"
    annotation (Placement(transformation(extent={{-10,60},{-30,40}})));
  Modelica.Fluid.Sensors.SpecificEntropy specificEntropyRef[n](redeclare
      package                                                                    Medium =
                       Medium) "Specific enthalpy of the reference environment"
    annotation (Placement(transformation(extent={{10,60},{30,40}})));
  Modelica.Blocks.Interfaces.RealOutput exergyChangeRate(final quantity="Power",
      final unit="W")
    "Rate of change of the exergy content of the considered storage"
                      annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={106,-62})));
  Modelica.Fluid.Sources.Boundary_pT referenceEnvironment[n](
    redeclare package Medium = Medium,
    each use_p_in=true,
    each nPorts=2,
    each use_T_in=true,
    each use_X_in=true)
    "The reference environment used for exergy calculations"
                         annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,80})));
  Modelica.Fluid.Sources.Boundary_pT boundary[n](
    redeclare package Medium = Medium,
    each use_p_in=true,
    each use_T_in=true,
    each nPorts=2,
    each use_X_in=true)
    "Used for calculating the thermodynamic states of the considered medium"
                   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,0})));

  Modelica.Blocks.Interfaces.RealInput T[n](
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature",
    min=0) "Actual temperature"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-108}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-100})));
  Modelica.Blocks.Interfaces.RealInput p(
    final quantity="Pressure",
    final unit="Pa",
    displayUnit="bar",
    min=0) "Actual pressure"    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-50,-108})));
  Modelica.Blocks.Math.Sum enthalpySum(nin=n)
    "Sum up the enthalpy differences for all layers"
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  Modelica.Blocks.Math.Gain multiplyMassEnthalpy(k=mass)
    "Multiply mass and specific enthalpy"
    annotation (Placement(transformation(extent={{-26,-57},{-12,-43}})));
  Modelica.Blocks.Math.Add add[n](each k1=-1)
    "Difference between actual and reference enthalpy"
    annotation (Placement(transformation(extent={{-46,33},{-60,47}})));
  Modelica.Blocks.Math.Add add1[n](each k1=-1)
    "Difference between actual and reference entropy"
    annotation (Placement(transformation(extent={{46,33},{60,47}})));
  Modelica.Blocks.Math.Sum entropySum(nin=n)
    "Sum up the entropy differences for all layers"
    annotation (Placement(transformation(extent={{64,-42},{44,-22}})));
  Modelica.Blocks.Math.Add differenceExergyContent(each k1=-1)
    "Difference between enthalpy and product of reference temperature and 
    entropy"
    annotation (Placement(transformation(extent={{38,-69},{52,-55}})));
  Modelica.Blocks.Continuous.Derivative derivative(
    x_start=exergyContent_start,
    initType=Modelica.Blocks.Types.Init.InitialState,
    T=10)
    "Derivative to calculate the rate of change of the exergy content of the 
    storage"
    annotation (Placement(transformation(extent={{64,-72},{84,-52}})));
  Modelica.Blocks.Interfaces.RealOutput exergyContent(
    start=exergyContent_start,
    final quantity="Energy",
    final unit="J") "Exergy content of the considered storage"
                    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={106,-32})));
  Modelica.Blocks.Math.Product productTemperatureEntropy
    "Product of reference temperature and entropy difference" annotation (
      Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={14,-46})));
  Modelica.Blocks.Math.Gain multiplyMassEntropy(k=mass)
    "Multiply mass and specific entropy" annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=180,
        origin={27,-32})));
  Modelica.Blocks.Interfaces.RealInput X_ref[Medium.nX](
  final quantity="MassFraction", final unit="1", min=0, max=1)
    "Reference composition"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,-70})));
  Modelica.Blocks.Interfaces.RealInput X[Medium.nX](
    final quantity="MassFraction",
    final unit="1",
    min=0,
    max=1) "Actual composition"    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={50,-108})));
equation

  for i in 1:n loop
    connect(p, boundary[i].p_in) annotation (Line(points={{-50,-108},{-50,-72},{
            -8,-72},{-8,-12}}, color={0,0,127}));
    connect(T_ref, referenceEnvironment[i].T_in) annotation (Line(points={{-100,70},
            {-76,70},{-76,96},{4,96},{4,92}}, color={0,0,127}));
    connect(p_ref, referenceEnvironment[i].p_in) annotation (Line(points={{-100,0},
            {-78,0},{-78,98},{8,98},{8,92}},  color={0,0,127}));
    connect(X, boundary[i].X_in) annotation (Line(points={{50,-108},{50,-80},{2,
            -80},{2,-20},{4,-20},{4,-12}},
                                    color={0,0,127}));
    connect(X_ref, referenceEnvironment[i].X_in) annotation (Line(points={{-100,-70},
          {-72,-70},{-72,92},{-4,92}}, color={0,0,127}));

  end for;

  connect(specificEnthalpy[:].port, boundary[:].ports[1]) annotation (Line(
        points={{-60,0},{-40,0},{-20,0},{-20,20},{-4,20},{-2,20},{-2,10}},
        color={0,127,255}));
  connect(specificEntropy[:].port, boundary[:].ports[2]) annotation (Line(
        points={{60,0},{40,0},{20,0},{20,20},{2,20},{2,10}}, color={0,127,255}));
  connect(specificEnthalpyRef.h_out, add.u1) annotation (Line(points={{-31,50},{
          -38,50},{-38,44.2},{-44.6,44.2}}, color={0,0,127}));
  connect(specificEnthalpy.h_out, add.u2) annotation (Line(points={{-49,10},{-40,
          10},{-40,35.8},{-44.6,35.8}}, color={0,0,127}));
  connect(add.y, enthalpySum.u) annotation (Line(points={{-60.7,40},{-60.7,40},{
          -74,40},{-74,-50},{-62,-50}}, color={0,0,127}));
  connect(enthalpySum.y, multiplyMassEnthalpy.u) annotation (Line(points={{-39,-50},
          {-34,-50},{-27.4,-50}}, color={0,0,127}));
  connect(specificEntropyRef.s, add1.u1) annotation (Line(points={{31,50},{36,50},
          {36,44.2},{44.6,44.2}}, color={0,0,127}));
  connect(specificEntropy.s, add1.u2) annotation (Line(points={{49,10},{40,10},{
          40,35.8},{44.6,35.8}}, color={0,0,127}));
  connect(add1.y, entropySum.u) annotation (Line(points={{60.7,40},{60.7,40},{84,
          40},{84,-32},{66,-32}}, color={0,0,127}));
  connect(derivative.y,exergyChangeRate)
    annotation (Line(points={{85,-62},{106,-62}}, color={0,0,127}));
  connect(specificEnthalpyRef[:].port, referenceEnvironment[:].ports[1])
    annotation (Line(points={{-20,60},{-20,70},{2,70}}, color={0,127,255}));
  connect(specificEntropyRef[:].port, referenceEnvironment[:].ports[2])
    annotation (Line(points={{20,60},{20,70},{-2,70}}, color={0,127,255}));
  connect(entropySum.y, multiplyMassEntropy.u)
    annotation (Line(points={{43,-32},{40,-32},{35.4,-32}}, color={0,0,127}));
  connect(multiplyMassEntropy.y, productTemperatureEntropy.u1) annotation (Line(
        points={{19.3,-32},{14,-32},{14,-38.8},{17.6,-38.8}}, color={0,0,127}));
  connect(T_ref, productTemperatureEntropy.u2) annotation (Line(points={{-100,70},
          {-76,70},{-76,-28},{10.4,-28},{10.4,-38.8}}, color={0,0,127}));
  connect(derivative.u, differenceExergyContent.y)
    annotation (Line(points={{62,-62},{52.7,-62}}, color={0,0,127}));
  connect(multiplyMassEnthalpy.y, differenceExergyContent.u2) annotation (Line(
        points={{-11.3,-50},{4,-50},{4,-66.2},{36.6,-66.2}}, color={0,0,127}));
  connect(productTemperatureEntropy.y, differenceExergyContent.u1) annotation (
      Line(points={{14,-52.6},{14,-57.8},{36.6,-57.8}}, color={0,0,127}));
  connect(differenceExergyContent.y, exergyContent) annotation (Line(points={{52.7,
          -62},{58,-62},{58,-44},{90,-44},{90,-32},{106,-32}}, color={0,0,127}));
  connect(T, boundary.T_in) annotation (Line(points={{0,-108},{0,-108},{0,-28},{
          0,-22},{-4,-22},{-4,-12}}, color={0,0,127}));

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})), Documentation(info="<html><p>
  <span style=\"font-family: MS Shell Dlg 2;\">The model calculates the
  exergy content and its rate of change of a stratefied storage i. e.
  with multiple layers) filled with a medium consisting of multiple
  substances. The reference environment is variable and is modeled
  using a boundary with temperature, pressure and composition as input.
  The medium model is replaceable. The physical enthalpy and entropy
  are determined using the respective sensors from MSL. The rate of
  change of the exergy content is calculated using the approximate
  derivative block from MSL.</span>
</p>
<ul>
  <li>by Marc Baranski and Roozbeh Sangi:<br/>
    implemented
  </li>
</ul>
</html>"));
end StoredExergyMeter;
