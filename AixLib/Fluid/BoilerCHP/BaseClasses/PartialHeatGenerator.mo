within AixLib.Fluid.BoilerCHP.BaseClasses;
partial model PartialHeatGenerator "Partial model for heat generators"
  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface;

  parameter Modelica.SIunits.Time tau=1
    "Time constant of the temperature sensors at nominal flow rate"
    annotation (Dialog(tab="Advanced", group="Sensor Properties"));
  parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.InitialState
    "Type of initialization (InitialState and InitialOutput are identical)"
    annotation (Dialog(tab="Advanced", group="Sensor Properties"));
  parameter Modelica.SIunits.Temperature T_start=Medium.T_default
    "Initial or guess value of output (= state)"
    annotation (Dialog(tab="Advanced", group="Initialization"));
  parameter Boolean transferHeat=false
    "If true, temperature T converges towards TAmb when no flow"
    annotation (Dialog(tab="Advanced", group="Sensor Properties"));
  parameter Modelica.SIunits.Temperature TAmb=Medium.T_default
    "Fixed ambient temperature for heat transfer"
    annotation (Dialog(tab="Advanced", group="Sensor Properties"));
  parameter Modelica.SIunits.Time tauHeaTra=1200
    "Time constant for heat transfer, default 20 minutes"
    annotation (Dialog(tab="Advanced", group="Sensor Properties"));
  parameter Modelica.Media.Interfaces.Types.AbsolutePressure dp_start=0
    "Guess value of dp = port_a.p - port_b.p"
    annotation (Dialog(tab="Advanced", group="Initialization"));
  parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate m_flow_start=0
    "Guess value of m_flow = port_a.m_flow"
    annotation (Dialog(tab="Advanced", group="Initialization"));
  parameter Modelica.Media.Interfaces.Types.AbsolutePressure p_start=Medium.p_default
    "Start value of pressure"
    annotation (Dialog(tab="Advanced", group="Initialization"));

  parameter Modelica.SIunits.PressureDifference dp_nominal=m_flow_nominal ^ 2 * a / (rho_default ^ 2)
    "Pressure drop at nominal mass flow rate";
  parameter Boolean from_dp=false
    "= true, use m_flow = f(dp) else dp = f(m_flow)"
    annotation (Dialog(tab="Advanced", group="Pressure drop"));
  parameter Modelica.SIunits.Density rho_default = 1000 "Default density of medium. Value assumes water";
  parameter Boolean linearized=false
    "= true, use linear relation between m_flow and dp for any flow rate"
    annotation (Dialog(tab="Advanced", group="Pressure drop"));
  parameter Real deltaM=0.3
    "Fraction of nominal mass flow rate where transition to turbulent occurs"
    annotation (Dialog(tab="Advanced", group="Pressure drop"));
  parameter Real a "Coefficient of old approach from model Modelica.Fluid.Fittings.GenericResistances.VolumeFlowRate. Recalculated to dp_nominal based on IBPSA approach.";
  Sensors.TemperatureTwoPort senTCold(
    redeclare final package Medium = Medium,
    final tau=tau,
    final m_flow_nominal=m_flow_nominal,
    final initType=initType,
    final T_start=T_start,
    final transferHeat=transferHeat,
    final TAmb=TAmb,
    final tauHeaTra=tauHeaTra,
    final allowFlowReversal=allowFlowReversal,
    final m_flow_small=m_flow_small)
    "Temperature sensor of cold side of heat generator (return)"
    annotation (Placement(transformation(extent={{-80,-90},{-60,-70}})));
  Sensors.TemperatureTwoPort senTHot(
    redeclare final package Medium = Medium,
    final tau=tau,
    final m_flow_nominal=m_flow_nominal,
    final initType=initType,
    final T_start=T_start,
    final transferHeat=transferHeat,
    final TAmb=TAmb,
    final tauHeaTra=tauHeaTra,
    final allowFlowReversal=allowFlowReversal,
    final m_flow_small=m_flow_small)
    "Temperature sensor of hot side of heat generator (supply)"
    annotation (Placement(transformation(extent={{30,-90},{50,-70}})));
  Sensors.MassFlowRate senMasFlo(
    redeclare final package Medium = Medium,
    final allowFlowReversal=allowFlowReversal)
    "Sensor for mass flwo rate"
    annotation (Placement(transformation(extent={{60,-90},{80,-70}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heater
    "Prescribed heat flow" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-60,-50})));
  MixingVolumes.MixingVolume vol(
    redeclare final package Medium = Medium,
    final m_flow_nominal=m_flow_nominal,
    final m_flow_small=m_flow_small,
    final allowFlowReversal=allowFlowReversal,
    final nPorts=2,
    final p_start=p_start,
    final T_start=T_start)
    "Fluid volume"
    annotation (Placement(transformation(extent={{-50,-80},{-30,-60}})));
  FixedResistances.PressureDrop                             pressureDrop(
    redeclare final package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    final show_T=false,
    final allowFlowReversal=allowFlowReversal,
    final dp_nominal=dp_nominal)
    "Pressure drop"
    annotation (Placement(transformation(extent={{-20,-90},{0,-70}})));
  parameter Modelica.Media.Interfaces.Types.AbsolutePressure dp_start=0
    "Guess value of dp = port_a.p - port_b.p"
    annotation (Dialog(tab="Advanced", group="Initialization"));
  parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate m_flow_start=0
    "Guess value of m_flow = port_a.m_flow"
    annotation (Dialog(tab="Advanced", group="Initialization"));
  parameter Modelica.Media.Interfaces.Types.AbsolutePressure p_start=Medium.p_default
    "Start value of pressure"
    annotation (Dialog(tab="Advanced", group="Initialization"));
  parameter Modelica.SIunits.PressureDifference dp_nominal = m_flow_nominal ^2 * a / (rho_default^2)
    "Pressure drop at nominal mass flow rate based on pressure curve coefficient a";
  parameter Real a "Pressure curve coefficent based on PD in AixLib.DataBase.Boiler.General.BoilerTwoPointBaseDataDefinition";
  parameter Modelica.SIunits.Density rho_default = Medium.density_pTX(Medium.p_default, Medium.T_default, Medium.X_default);

equation
  connect(port_a, senTCold.port_a) annotation (Line(points={{-100,0},{-90,0},{-90,
          -80},{-80,-80}}, color={0,127,255},
      thickness=1));
  connect(senTCold.port_b, vol.ports[1])
    annotation (Line(points={{-60,-80},{-42,-80}}, color={0,127,255},
      thickness=1));
  connect(vol.ports[2], pressureDrop.port_a) annotation (Line(
      points={{-38,-80},{-38,-80},{-20,-80}},
      color={0,127,255},
      thickness=1));
  connect(senMasFlo.port_b, port_b) annotation (Line(points={{80,-80},{90,-80},{
          90,0},{100,0}}, color={0,127,255},
      thickness=1));
  connect(pressureDrop.port_b, senTHot.port_a) annotation (Line(
      points={{0,-80},{0,-80},{30,-80}},
      color={0,127,255},
      thickness=1));
  connect(senTHot.port_b, senMasFlo.port_a)
    annotation (Line(points={{50,-80},{55,-80},{60,-80}}, color={0,127,255},
      thickness=1));
  connect(heater.port, vol.heatPort) annotation (Line(points={{-60,-60},{-60,-60},
          {-60,-66},{-60,-70},{-50,-70}}, color={191,0,0}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={Rectangle(
          extent={{-60,80},{60,-80}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={170,170,255})}),
    Documentation(info="<html><p>
  Partial model to implement heat generator models with one heat
  exchanger volume.
</p>
<p>
  Classes that extend this model need to implement the controller which
  shoud also calculate the heat flow to the heat exchanger volume.
</p>
<p>
  The volume of the heat exchanger as well as the pressure loss
  coefficient should be set for each heat generator separately.
</p>
<ul>
  <li>
    <i>December 08, 2016&#160;</i> by Moritz Lauster:<br/>
    Adapted to AixLib conventions
  </li>
  <li>October 11, 2016 by Pooyan Jahangiri:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end PartialHeatGenerator;
