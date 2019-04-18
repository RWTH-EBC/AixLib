within AixLib.PlugNHarvest.Components.SmartFacade;
model sahaix

  parameter Modelica.SIunits.MassFlowRate MassFlowSetPoint = 0.0306 "Mass Flow Set Point" annotation (Dialog(group = "Operational Parameters", descriptionLabel = true));
  parameter Modelica.SIunits.Area CoverArea = 1.2634 "Cover Area" annotation (Dialog(group = "Dimensions", descriptionLabel = true));
  parameter Modelica.SIunits.Area InnerCrossSection = 0.01181 "Channel Cross Section" annotation (Dialog(group = "Dimensions", descriptionLabel = true));
  parameter Modelica.SIunits.Length Perimeter = 1.348  "Perimeter" annotation (Dialog(group = "Dimensions", descriptionLabel = true));
  parameter Modelica.SIunits.Length SAHLength1 = 1.8 "Channel Length 1" annotation (Dialog(group = "Dimensions", descriptionLabel = true));
  parameter Modelica.SIunits.Length SAHLength2 = 1.5 "Channel Length 2" annotation (Dialog(group = "Dimensions", descriptionLabel = true));
  parameter Modelica.SIunits.HeatCapacity   AbsorberHeatCapacity = 3950 "Absorber Heat Capacity" annotation (Dialog(group = "Other Parameters", descriptionLabel = true));
  parameter Modelica.SIunits.TransmissionCoefficient CoverTransmitance = 0.84 "Cover Transmitance" annotation (Dialog(group = "Other Parameters", descriptionLabel = true));
  parameter Modelica.SIunits.ThermalConductance CoverConductance=3.2 "Cover Conductance" annotation (Dialog(group = "Other Parameters", descriptionLabel = true));

  Modelica.Thermal.HeatTransfer.Components.Convection convection
    annotation (Placement(transformation(extent={{-12,0},{8,20}})));

  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor absorber(C=
        AbsorberHeatCapacity, T(fixed=true, start=295.15))
    annotation (Placement(transformation(extent={{-98,10},{-78,30}})));
  Modelica.Blocks.Sources.RealExpression convenction_coefficient(y=25)
    annotation (Placement(transformation(extent={{32,24},{12,44}})));
  Modelica.Fluid.Sources.Boundary_pT environment_flow(
    redeclare package Medium =
        Modelica.Media.Air.DryAirNasa,
    use_T_in=true,
    nPorts=1,
    p=101300)
    annotation (Placement(transformation(extent={{90,42},{70,62}})));
  Modelica.Fluid.Pipes.DynamicPipe air_heater_f(
    isCircular=false,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
    diameter=1,
    m_flow_start=0.02,
    redeclare package Medium =
        Modelica.Media.Air.DryAirNasa,
    height_ab=0.45,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal(displayUnit="Pa") = 32, m_flow_nominal=0.028),
    crossArea=InnerCrossSection,
    perimeter=Perimeter,
    length=SAHLength1,
    T_start=295.15)
    annotation (Placement(transformation(extent={{-58,62},{-78,42}})));

  Modelica.Fluid.Pipes.DynamicPipe air_heater_b(
    isCircular=false,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
    diameter=1,
    m_flow_start=0.02,
    redeclare package Medium =
        Modelica.Media.Air.DryAirNasa,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal(displayUnit="Pa") = 32, m_flow_nominal=0.028),
    height_ab=-0.45,
    crossArea=InnerCrossSection,
    perimeter=Perimeter,
    length=SAHLength2,
    T_start=295.15)
    annotation (Placement(transformation(extent={{-92,62},{-112,42}})));

  Modelica.Fluid.Sensors.VolumeFlowRate volumeFlowRate(redeclare package Medium =
        Modelica.Media.Air.DryAirNasa)
    annotation (Placement(transformation(extent={{-20,-14},{-4,-30}})));
  Modelica.Fluid.Machines.PrescribedPump fan(
    use_N_in=true,
    redeclare package Medium =
        Modelica.Media.Air.DryAirNasa,
    redeclare function flowCharacteristic =
        Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.linearFlow (
          V_flow_nominal={0,0.04377}, head_nominal={12.626,0}),
    N_nominal=1500)
    annotation (Placement(transformation(extent={{-66,-12},{-46,-32}})));
  Modelica.Blocks.Sources.RealExpression flow_set_point(y=MassFlowSetPoint)
    annotation (Placement(transformation(extent={{-118,-66},{-98,-46}})));
  Modelica.Blocks.Continuous.LimPID Controller(
    limitsAtInit=false,
    Ti=0.01,
    k=15,
    Td=0.2,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=2500,
    yMin=1200)
    annotation (Placement(transformation(extent={{-78,-62},{-66,-50}})));
  Modelica.Fluid.Sensors.MassFlowRate massFlowRate(redeclare package Medium =
        Modelica.Media.Air.DryAirNasa)
    annotation (Placement(transformation(extent={{20,-14},{36,-30}})));
  AixLib.Utilities.HeatTransfer.SolarRadToHeat solarRadToHeat(coeff=
        CoverTransmitance, A=CoverArea)
    annotation (Placement(transformation(extent={{-26,18},{-46,38}})));
  Modelica.Fluid.Sensors.SpecificEnthalpyTwoPort specificEnthalpy(redeclare
      package Medium =
        Modelica.Media.Air.DryAirNasa)
    annotation (Placement(transformation(extent={{50,-12},{70,-32}})));
  Modelica.Fluid.Sources.Boundary_pT house(
    use_T_in=false,
    redeclare package Medium =
        Modelica.Media.Air.DryAirNasa,
    nPorts=1,
    p=101300)
    annotation (Placement(transformation(extent={{132,-32},{112,-12}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{62,-120},{82,-100}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedAmbTemperature1
    annotation (Placement(transformation(extent={{46,4},{34,16}})));
  Modelica.Blocks.Interfaces.RealInput T_in annotation (Placement(
        transformation(rotation=90,extent={{-20,-20},{20,20}},
        origin={100,128}),
        iconTransformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,102})));
  AixLib.Utilities.Interfaces.SolarRad_in solarRad_in annotation (Placement(
        transformation(
        rotation=90,
        extent={{-13,-16},{13,16}},
        origin={-18,133}),  iconTransformation(
        extent={{-13,-14},{13,14}},
        rotation=180,
        origin={111,0})));

  Modelica.Thermal.HeatTransfer.Components.ThermalConductor cover(G=
        CoverConductance)
    annotation (Placement(transformation(extent={{-62,-4},{-42,16}})));
  Modelica.Fluid.Sensors.SpecificEnthalpyTwoPort specificEnthalpyEnv(redeclare
      package Medium = Modelica.Media.Air.DryAirNasa)
    annotation (Placement(transformation(extent={{40,62},{60,42}})));
  Modelica.Blocks.Math.Add add(k1=-1)
    annotation (Placement(transformation(extent={{96,-70},{116,-50}})));
  Modelica.Blocks.Interfaces.RealOutput heatOutput
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{134,-120},{154,-100}})));
equation
  connect(convenction_coefficient.y,convection. Gc)
    annotation (Line(points={{11,34},{-2,34},{-2,20}},
                                                   color={0,0,127}));
  connect(air_heater_b.port_a,air_heater_f. port_b)
    annotation (Line(points={{-92,52},{-78,52}}, color={0,127,255}));
  connect(air_heater_b.port_b,fan. port_a) annotation (Line(points={{-112,52},{
          -122,52},{-122,-22},{-66,-22}},
                                        color={0,127,255}));
  connect(fan.port_b,volumeFlowRate. port_a) annotation (Line(points={{-46,-22},
          {-20,-22}},                     color={0,127,255}));
  connect(flow_set_point.y,Controller. u_s) annotation (Line(points={{-97,-56},
          {-79.2,-56}},                       color={0,0,127}));
  connect(volumeFlowRate.port_b,massFlowRate. port_a) annotation (Line(points={{-4,-22},
          {20,-22}},                         color={0,127,255}));
  connect(massFlowRate.m_flow,Controller. u_m) annotation (Line(points={{28,
          -30.8},{28,-68},{-72,-68},{-72,-63.2}},            color={0,0,127}));
  connect(absorber.port,air_heater_b. heatPorts[1]) annotation (Line(points={{-88,10},
          {-102.1,10},{-102.1,47.6}},         color={191,0,0}));
  connect(massFlowRate.port_b,specificEnthalpy. port_a)
    annotation (Line(points={{36,-22},{50,-22}}, color={0,127,255}));
  connect(house.ports[1],specificEnthalpy. port_b) annotation (Line(points={{112,-22},
          {70,-22}},                              color={0,127,255}));
  connect(massFlowRate.m_flow, product.u2) annotation (Line(points={{28,-30.8},{
          28,-116},{60,-116}},      color={0,0,127}));
  connect(prescribedAmbTemperature1.port, convection.fluid)
    annotation (Line(points={{34,10},{8,10}},      color={191,0,0}));
  connect(T_in, environment_flow.T_in) annotation (Line(points={{100,128},{100,
          56},{92,56}},          color={0,0,127}));
  connect(T_in, prescribedAmbTemperature1.T)
    annotation (Line(points={{100,128},{100,10},{47.2,10}}, color={0,0,127}));
  connect(solarRad_in, solarRadToHeat.solarRad_in) annotation (Line(points={{-18,133},
          {-18,26},{-25.9,26}},                      color={255,128,0}));
  connect(air_heater_f.heatPorts[1], absorber.port) annotation (Line(points={{-68.1,
          47.6},{-68.1,28},{-68,28},{-68,10},{-88,10}},
                                                      color={127,0,0}));
  connect(Controller.y, fan.N_in) annotation (Line(points={{-65.4,-56},{-56,-56},
          {-56,-32}},           color={0,0,127}));
  connect(cover.port_b, convection.solid)
    annotation (Line(points={{-42,6},{-28,6},{-28,10},{-12,10}},
                                                 color={191,0,0}));
  connect(cover.port_a, absorber.port)
    annotation (Line(points={{-62,6},{-76,6},{-76,10},{-88,10}},
                                                 color={191,0,0}));
  connect(solarRadToHeat.heatPort, absorber.port) annotation (Line(points={{-45,
          26},{-68,26},{-68,10},{-88,10}}, color={191,0,0}));
  connect(environment_flow.ports[1], specificEnthalpyEnv.port_b)
    annotation (Line(points={{70,52},{60,52}}, color={0,127,255}));
  connect(specificEnthalpyEnv.port_a, air_heater_f.port_a)
    annotation (Line(points={{40,52},{-58,52}}, color={0,127,255}));
  connect(specificEnthalpyEnv.h_out, add.u1) annotation (Line(points={{50,41},{
          88,41},{88,-54},{94,-54}}, color={0,0,127}));
  connect(specificEnthalpy.h_out, add.u2) annotation (Line(points={{60,-33},{76,
          -33},{76,-66},{94,-66}}, color={0,0,127}));
  connect(add.y, product.u1) annotation (Line(points={{117,-60},{117,-88},{56,
          -88},{56,-104},{60,-104}}, color={0,0,127}));

  connect(product.y, heatOutput)
    annotation (Line(points={{83,-110},{144,-110}}, color={0,0,127}));
      annotation (Documentation(info="<html> 
      <p>The Solar Air Heater Model was developed by CPERI/CERTH in the framework of the European Union’s Horizon 2020 research and innovation programme under grant agreement No 768735 (PLUG-N-HARVEST)</p>

      
 </html>", Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
                    Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
      revisions="<html>
<ul>
<li><i>April, 2019&nbsp;</i> by Ana Constantin:<br>Changed heat output of SAH to a normal real output</li>
</ul>
</html>"),             Dialog(group = "Dimensions", descriptionLabel = true),
    uses(Modelica(version="3.2.2"), AixLib(version="0.7.3")),
    Diagram(coordinateSystem(initialScale=0.1, extent={{-150,-150},{150,150}})),
    Icon(coordinateSystem(initialScale=0.1, extent={{-150,-150},{150,150}}),
        graphics={
        Rectangle(
          extent={{-34,80},{-16,-56}},
          lineColor={28,108,200},
          fillColor={255,186,189},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Rectangle(
          extent={{-16,80},{-6,-56}},
          lineColor={28,108,200},
          fillColor={217,211,244},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Rectangle(
          extent={{10,70},{12,-88}},
          lineColor={28,108,200},
          fillColor={127,0,0},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Rectangle(
          extent={{-34,-76},{-16,-88}},
          lineColor={28,108,200},
          fillColor={255,186,189},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Rectangle(
          extent={{-16,-76},{-6,-88}},
          lineColor={28,108,200},
          fillColor={217,211,244},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Rectangle(
          extent={{30,80},{36,-78}},
          lineColor={28,108,200},
          fillColor={129,216,223},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Line(
          points={{-6,-88},{10,-88}},
          color={28,108,200},
          thickness=0.5),
        Line(points={{12,-88},{34,-88}}, color={28,108,200}),
        Line(
          points={{36,-78},{46,-78}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{46,-78},{46,-96}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{12,-88},{34,-88}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{34,-88},{34,-96}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-6,80},{30,80}},
          color={28,108,200},
          thickness=0.5),
        Ellipse(
          extent={{-12,-56},{-10,-66}},
          lineColor={28,108,200},
          fillColor={152,152,152},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-12,-66},{-10,-76}},
          lineColor={28,108,200},
          fillColor={152,152,152},
          fillPattern=FillPattern.Solid),
    Text(lineColor={0,0,255},
      extent={{0,66},{0,124}},
          fontSize=12,
          textString="%name")}));
end sahaix;
