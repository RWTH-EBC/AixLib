within AixLib.Utilities.Sensors.ExergyMeter;
model FlowExergyMeter

  extends AixLib.Fluid.Interfaces.PartialTwoPort;
  extends Modelica.Icons.RoundSensor;

  Modelica.Blocks.Interfaces.RealInput X_ref[Medium.nX](
  final quantity="MassFraction", final unit="1", min=0, max=1)
    "Reference composition"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-90,-100})));
  Modelica.Fluid.Sources.Boundary_pT referenceEnvironment(
    redeclare replaceable package Medium = Medium,
    use_p_in=true,
    nPorts=2,
    use_T_in=true,
    use_X_in=true) "The reference environment used for exergy calculations"
                   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-56})));
  Modelica.Fluid.Sensors.MassFlowRate massFlowRate(
  redeclare package Medium = Medium)
    "Mass flow rate of the medium flow used in exergy calculations"
    annotation (Placement(transformation(extent={{-10,10},{10,-10}})));
  Modelica.Fluid.Sensors.SpecificEntropy specificEntropy(
  redeclare package Medium =
               Medium)
    "Specific entropy of the medium flow used in exergy calculations"
    annotation (Placement(transformation(extent={{70,0},{50,20}})));
  Modelica.Fluid.Sensors.SpecificEnthalpy specificEnthalpy(redeclare package Medium =
               Medium)
    "Specific enthalpy of the medium flow used in exergy calculations"
    annotation (Placement(transformation(extent={{-70,0},{-50,20}})));

  Modelica.Blocks.Interfaces.RealInput T_ref(final unit="K", displayUnit="degC",
    final quantity="ThermodynamicTemperature", min=0) "Reference temperature"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={90,-100})));
  Modelica.Blocks.Interfaces.RealInput p_ref(final quantity="Pressure",
  final unit="Pa", displayUnit="bar", min=0)
    "Reference pressure"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-100})));
  Modelica.Fluid.Sensors.SpecificEnthalpy specificEnthalpyRef(redeclare package
                                                                                Medium =
               Medium) "Specific enthalpy of the reference environment"
    annotation (Placement(transformation(extent={{-12,-62},{-32,-42}})));
  Modelica.Fluid.Sensors.SpecificEntropy specificEntropy_ref(redeclare package Medium =
               Medium) "Specific entropy of the reference environment"
    annotation (Placement(transformation(extent={{18,-64},{38,-42}})));
  Modelica.Blocks.Interfaces.RealOutput exergyFlow(final quantity="Power",
      final unit="W") "Exergy content of the medium flow" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,110})));
  Modelica.Blocks.Math.Add enthalpyDifference(k1=-1)
    "Difference between enthalpy content of medium flow and reference 
    environment"
    annotation (Placement(transformation(extent={{-36,20},{-16,40}})));
  Modelica.Blocks.Math.Add entropyDifference(k1=-1)
    "Difference between entropy content of medium flow and reference 
    environment"
    annotation (Placement(transformation(extent={{-36,46},{-16,66}})));
  Modelica.Blocks.Math.Product productWithReferenceTemperature
    "Calculate the product of reference temperature and entropy"
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  Modelica.Blocks.Math.Add specificExergy(k1=-1)
    "Specific exergy as difference of enthalpy and product of reference 
    temperature and entropy"
    annotation (Placement(transformation(extent={{40,40},{60,60}})));
  Modelica.Blocks.Math.Product exergyFlowRate
    "Exergy flow rate as product of specific exergy and mass flow rate"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={50,80})));
equation
  connect(specificEnthalpyRef.port, referenceEnvironment.ports[1])
    annotation (Line(points={{-22,-62},{-22,-66},{2,-66}}, color={0,127,255}));
  connect(referenceEnvironment.ports[2], specificEntropy_ref.port)
    annotation (Line(points={{-2,-66},{28,-66},{28,-64}},
                                               color={0,127,255}));
  connect(massFlowRate.port_b,specificEntropy. port)
    annotation (Line(points={{10,0},{60,0}}, color={0,127,255}));
  connect(specificEnthalpy.h_out, enthalpyDifference.u2) annotation (Line(
        points={{-49,10},{-46,10},{-46,24},{-38,24}},   color={0,0,127}));
  connect(specificEnthalpyRef.h_out, enthalpyDifference.u1)
  annotation (Line(points={{-33,-52},{-44,-52},{-44,-24},{-44,36},{-38,36}},
  color={0,0,127}));
  connect(T_ref, productWithReferenceTemperature.u2)
  annotation (Line(points={{90,-100},{90,-100},{90,-34},{20,-34},{20,34},
  {-8,34},{-8,44},{-2,44}}, color={0,0,127}));
  connect(enthalpyDifference.y, specificExergy.u2)
  annotation (Line(points={{-15,30},{32,30},{32,44},{38,44}},color={0,0,127}));
  connect(port_a, specificEnthalpy.port)
    annotation (Line(points={{-100,0},{-80,0},{-60,0}}, color={0,127,255}));
  connect(specificEntropy.port, port_b)
    annotation (Line(points={{60,0},{80,0},{100,0}}, color={0,127,255}));
  connect(specificEntropy_ref.s, entropyDifference.u1)
  annotation (Line(points={{39,-53},{39,-53},{44,-53},{44,-27},{-86,-27},
  {-86,62},{-38,62}},color={0,0,127}));
  connect(productWithReferenceTemperature.y, specificExergy.u1)
    annotation (Line(points={{21,50},{22,50},{24,50},{32,50},{32,56},{38,56}},
    color={0,0,127}));
  connect(massFlowRate.m_flow, exergyFlowRate.u2)
  annotation (Line(points={{0,-11},{0,-26},{74,-26},{74,86},{62,86}},
  color={0,0,127}));
  connect(exergyFlowRate.y, exergyFlow)
    annotation (Line(points={{39,80},{0,80},{0,110}}, color={0,0,127}));
  connect(specificEntropy.s, entropyDifference.u2)
  annotation (Line(points={{49,10},{32,10},{32,-18},{-78,-18},{-78,50},
  {-38,50}}, color={0,0,127}));
  connect(entropyDifference.y, productWithReferenceTemperature.u1)
    annotation (Line(points={{-15,56},{-2,56}}, color={0,0,127}));
  connect(specificExergy.y, exergyFlowRate.u1) annotation (Line(points={{61,50},
          {68,50},{68,74},{62,74}}, color={0,0,127}));
  connect(X_ref, referenceEnvironment.X_in) annotation (Line(points={{-90,-100},
          {-90,-100},{-90,-78},{-90,-38},{-4,-38},{-4,-44}},
                                                  color={0,0,127}));
  connect(p_ref, referenceEnvironment.p_in)
  annotation (Line(points={{0,-100},{0,-70},{48,-70},{48,-36},{8,-36},{8,-40},
  {8,-44}},color={0,0,127}));
  connect(T_ref, referenceEnvironment.T_in) annotation (Line(points={{90,-100},
  {90,-100},{90,-86},{90,-34},{4,-34},{4,-44}},color={0,0,127}));
  connect(specificEnthalpy.port, massFlowRate.port_a)
    annotation (Line(points={{-60,0},{-36,0},{-10,0}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})), Documentation(info="<html><p>
  <b><span style=\"color: #008000;\">Overview</span></b>
</p>
<p>
  The model calculates the exergy content of a medium flow consisting
  of multiple substances. The reference environment is variable and
  modeled using a boundary with temperature, pressure and composition
  as input. The medium model is replaceable. The physical enthalpy and
  entropy are determined using the respective sensors from MSL. The
  sensor is ideal, i.e., it does not influence the fluid.
</p>
<ul>
  <li>by Marc Baranski and Roozbeh Sangi:<br/>
    implemented
  </li>
</ul>
</html>"),
    Icon(coordinateSystem(extent={{-100,-100},{120,100}})));
end FlowExergyMeter;
