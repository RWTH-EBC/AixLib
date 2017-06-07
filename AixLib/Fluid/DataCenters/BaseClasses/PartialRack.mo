within AixLib.Fluid.DataCenters.BaseClasses;
partial model PartialRack
  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface;


  parameter Integer nServers = 16 "Number of servers in rack" annotation (Dialog(group="Servers"));
  parameter Integer nRacks = 1
    "Number of racks (only for experimental purposes, since this is a model of a single rack)" annotation (Dialog(group="Racks"));
  parameter Modelica.SIunits.Mass mServers = 24.4
    "Average mass of a single server (1 to 4 HU)" annotation (Dialog(group="Servers"));
  parameter Modelica.SIunits.SpecificHeatCapacity cpIT = 600
    "Average heat capacity of all the IT equipments" annotation (Dialog(group="Servers"));
  parameter Modelica.SIunits.Mass mRackHousing = 50
    "Mass of rack housing (usually about 50kg per rack)" annotation (Dialog(group="Racks"));
  parameter Real ConvectiveCoefficient = 12000
    "Real parameter representing the convective thermal conductance in [W/K] of the rack" annotation (Dialog(group="Servers"));
    parameter Modelica.SIunits.Temperature T_startIT = 307.15
    "Initial temperature of the IT surface" annotation(Dialog(tab="Advanced", group="Initialization"));
  parameter Modelica.Media.Interfaces.Types.Temperature T_startAir=301.15
    "Start value of the air temperature inside the rack" annotation(Dialog(tab="Advanced", group="Initialization"));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor rackHeatCapacitor(                                                    T(start=
         T_startIT, fixed=true), C=cpIT*nRacks*(nServers*mServers +
        mRackHousing))
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
  Modelica.Fluid.Sensors.TemperatureTwoPort flowTemperature(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{-62,-10},{-42,10}})));

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
    Documentation(info="<html>
<p>
Partial rack model including the thermal capacities and a temperature sensor.
</p>
<p>
Classes that extend this model need to implement the calculation of the final heat generation from a main parameter such as CPU utilization and a pressure drop component.
</p>
<p>
The sizing of the volume and channel or pipe should be defined in the extended model as various cooling types use different components.
</p>
</html>", revisions="<html>
<ul>
<li>
<i>June 07, 2017&nbsp;</i>  by Pooyan Jahangiri:<br/>
First implementation.
</li>
</ul>
</html>"));
end PartialRack;
