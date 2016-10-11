within AixLib.Fluid.HeatGenerators.BaseClasses;
partial model PartialHeatGenerator
  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface;
  Sensors.TemperatureTwoPort senTCold(
    redeclare package Medium = Medium,
    tau=tau,
    m_flow_nominal=m_flow_nominal,
    initType=initType,
    T_start=T_start,
    transferHeat=transferHeat,
    TAmb=TAmb,
    tauHeaTra=tauHeaTra,
    allowFlowReversal=allowFlowReversal,
    m_flow_small=m_flow_small)
    annotation (Placement(transformation(extent={{-80,-90},{-60,-70}})));
  parameter Modelica.SIunits.Time tau=1
    "Time constant of the temperature sensors at nominal flow rate"
    annotation (Dialog(tab="Advanced", group="Sensor Properties"));
  parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.InitialState
    "Type of initialization (InitialState and InitialOutput are identical)"
    annotation (Dialog(tab="Advanced", group="Sensor Properties"));
  parameter Modelica.SIunits.Temperature T_start=Medium.T_default
    "Initial or guess value of output (= state)"
    annotation (Dialog(tab="Advanced", group="Sensor Properties"));
  parameter Boolean transferHeat=false
    "if true, temperature T converges towards TAmb when no flow"
    annotation (Dialog(tab="Advanced", group="Sensor Properties"));
  parameter Modelica.SIunits.Temperature TAmb=Medium.T_default
    "Fixed ambient temperature for heat transfer"
    annotation (Dialog(tab="Advanced", group="Sensor Properties"));
  parameter Modelica.SIunits.Time tauHeaTra=1200
    "Time constant for heat transfer, default 20 minutes"
    annotation (Dialog(tab="Advanced", group="Sensor Properties"));
  MixingVolumes.MixingVolume vol(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    m_flow_small=m_flow_small,
    allowFlowReversal=allowFlowReversal,
    nPorts=2)
    annotation (Placement(transformation(extent={{-50,-80},{-30,-60}})));
  Modelica.Fluid.Fittings.GenericResistances.VolumeFlowRate preDro(
    redeclare package Medium = Medium,
    b=0,
    m_flow_small=m_flow_small,
    show_T=false,
    show_V_flow=false,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{-20,-90},{0,-70}})));
  Sensors.MassFlowRate senMasFlo(redeclare package Medium = Medium,
      allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{60,-90},{80,-70}})));
  Sensors.TemperatureTwoPort senTHot(
    redeclare package Medium = Medium,
    tau=tau,
    m_flow_nominal=m_flow_nominal,
    initType=initType,
    T_start=T_start,
    transferHeat=transferHeat,
    TAmb=TAmb,
    tauHeaTra=tauHeaTra,
    allowFlowReversal=allowFlowReversal,
    m_flow_small=m_flow_small)
    annotation (Placement(transformation(extent={{30,-90},{50,-70}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heater annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-60,-50})));
equation
  connect(port_a, senTCold.port_a) annotation (Line(points={{-100,0},{-90,0},{-90,
          -80},{-80,-80}}, color={0,127,255}));
  connect(senTCold.port_b, vol.ports[1])
    annotation (Line(points={{-60,-80},{-42,-80}}, color={0,127,255}));
  connect(vol.ports[2], preDro.port_a) annotation (Line(points={{-38,-80},{-38,-80},
          {-20,-80}}, color={0,127,255}));
  connect(senMasFlo.port_b, port_b) annotation (Line(points={{80,-80},{90,-80},{
          90,0},{100,0}}, color={0,127,255}));
  connect(preDro.port_b, senTHot.port_a)
    annotation (Line(points={{0,-80},{0,-80},{30,-80}}, color={0,127,255}));
  connect(senTHot.port_b, senMasFlo.port_a)
    annotation (Line(points={{50,-80},{55,-80},{60,-80}}, color={0,127,255}));
  connect(heater.port, vol.heatPort) annotation (Line(points={{-60,-60},{-60,-60},
          {-60,-66},{-60,-70},{-50,-70}}, color={191,0,0}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={Rectangle(
          extent={{-60,80},{60,-80}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={170,170,255})}),
    Documentation(info="<html>
<p>
Partial model to implement heat generator models with one heat exchanger volume.
</p>
<p>
Classes that extend this model need to implement the controller which shoud also calculate
the heat flow to the heat exchanger volume.
</p>
<p>
The volume of the heat exchanger as well as the pressure loss coefficient should be set
for each heat generator separately.
</p>
</html>", revisions="<html>
<ul>
<li>
October 11, 2016 by Pooyan Jahangiri:<br/>
First implementation.
</li>
</ul>
</html>"));
end PartialHeatGenerator;
