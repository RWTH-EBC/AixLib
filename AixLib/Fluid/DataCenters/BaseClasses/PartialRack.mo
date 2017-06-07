within AixLib.Fluid.DataCenters.BaseClasses;
partial model PartialRack
  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface;


  parameter Integer n_servers = 16 "Number of servers in rack";
  parameter Integer n_racks = 1
    "Number of racks (only for experimental purposes, since this is a model of a single rack)";
  parameter Modelica.SIunits.Mass m_server = 24.4
    "Average mass of a single server (1 to 4 HU)";
  parameter Modelica.SIunits.SpecificHeatCapacity cp_IT = 600
    "Average heat capacity of all the IT equipments";
  parameter Modelica.SIunits.Mass m_RackHousing = 50
    "Mass of rack housing (usually about 50kg per rack)";
  parameter Real ConvectiveCoefficient = 12000
    "Real parameter representing the convective thermal conductance in [W/K] of the rack";
    parameter Modelica.SIunits.Temperature T_startIT = 307.15
    "Initial temperature of the IT surface";
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor rackHeatCapacitor(C=cp_IT*n_racks*(n_servers*m_server+m_RackHousing), T(start=
         T_startIT, fixed=true))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={60,66})));
  Modelica.Thermal.HeatTransfer.Components.Convection rackConvection
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={50,30})));
  Modelica.Blocks.Sources.Constant RackConvectiveCoefficient(k=
        ConvectiveCoefficient)
    annotation (Placement(transformation(extent={{6,20},{26,40}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={32,66})));
  Modelica.Fluid.Vessels.ClosedVolume rackVolume(
    use_HeatTransfer=true,
    nPorts=2,
    use_portsData=false,
    redeclare package Medium = Medium,
    T_start=T_startAir)     annotation (Placement(transformation(extent={{68,6},{88,26}})));
  Modelica.Fluid.Pipes.DynamicPipe coolingChannel(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-88,-10},{-68,10}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort flowTemperature(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{-62,-10},{-42,10}})));

  parameter Modelica.Media.Interfaces.Types.Temperature T_startAir=301.15
    "Start value of the air temperature inside the rack";
equation
  connect(RackConvectiveCoefficient.y,rackConvection. Gc) annotation (Line(
      points={{27,30},{40,30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(prescribedHeatFlow.port,rackHeatCapacitor. port) annotation (Line(
      points={{42,66},{50,66}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(rackHeatCapacitor.port,rackConvection. solid) annotation (Line(
      points={{50,66},{50,40}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(rackConvection.fluid,rackVolume. heatPort) annotation (Line(
      points={{50,20},{50,16},{68,16}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(port_b,rackVolume. ports[1]) annotation (Line(
      points={{100,0},{76,0},{76,6}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(port_a, coolingChannel.port_a) annotation (Line(
      points={{-100,0},{-88,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(coolingChannel.port_b, flowTemperature.port_a) annotation (Line(
      points={{-68,0},{-62,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(flowTemperature.port_b, rackVolume.ports[2]) annotation (Line(
      points={{-42,0},{80,0},{80,6}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-60,100},{60,-100}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-46,80},{46,70}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-46,58},{46,48}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-46,36},{46,26}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-46,-30},{46,-40}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-46,-8},{46,-18}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-46,14},{46,4}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-42,76},{-38,72}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-42,54},{-38,50}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-42,32},{-38,28}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-42,10},{-38,6}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-42,-12},{-38,-16}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-42,-34},{-38,-38}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-46,-52},{46,-62}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-46,-74},{46,-84}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-42,-56},{-38,-60}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-42,-78},{-38,-82}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    experiment,
    __Dymola_experimentSetupOutput(events=false));
end PartialRack;
