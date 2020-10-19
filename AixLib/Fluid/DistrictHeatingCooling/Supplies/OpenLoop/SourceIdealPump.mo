within AixLib.Fluid.DistrictHeatingCooling.Supplies.OpenLoop;
model SourceIdealPump
  "Simple supply node model with speed controled pump"
  extends
    AixLib.Fluid.DistrictHeatingCooling.BaseClasses.Supplies.OpenLoop.PartialSupplyLessInputs(
      senT_return(allowFlowReversal=true));

  parameter Modelica.SIunits.AbsolutePressure pReturn
    "Fixed return pressure";

  parameter Modelica.SIunits.MassFlowRate m_flow_nominal = 5 "Nominal mass flow rate";

  parameter Modelica.SIunits.PressureDifference dp_heater = 30000;

  parameter Modelica.SIunits.PressureDifference dp_pump = 300000;



  AixLib.Fluid.Sources.Boundary_pT source(          redeclare package Medium =
        Medium,
    nPorts=1,
    use_T_in=true,
    use_p_in=false,
    p=pReturn)
    "Ideal fluid source with prescribed temperature and pressure"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,40})));

  Sources.Boundary_pT                sink(
    redeclare package Medium = Medium,
    p=pReturn,
    nPorts=1) "Ideal sink for return from the network" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-34,-20})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow
    annotation (Placement(transformation(extent={{98,70},{118,90}})));

  Movers.FlowControlled_dp                 fan(        redeclare package Medium =
        Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    p_start=pReturn + 200000,
    allowFlowReversal=false,
    m_flow_nominal=m_flow_nominal,
    m_flow_small=1E-4*abs(m_flow_nominal),
    redeclare Movers.Data.Generic per,
    init=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=1,
    dp_start(displayUnit="bar") = 300000,
    dp_nominal(displayUnit="bar") = 300000)
    annotation (Placement(transformation(extent={{-40,90},{-20,70}})));
  Modelica.Blocks.Interfaces.RealInput TIn "Prescribed boundary temperature"
    annotation (Placement(transformation(extent={{-124,40},{-84,80}})));
  AixLib.Fluid.Sensors.DensityTwoPort senDen(redeclare package Medium = Medium,
      m_flow_nominal=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={40,20})));
  AixLib.Fluid.HeatExchangers.Heater_T IdealHeater(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dp_nominal(displayUnit="bar") = 50000)
    annotation (Placement(transformation(extent={{30,70},{50,90}})));
  Modelica.Blocks.Interfaces.RealInput dpIn
                                           "Prescribed boundary temperature"
    annotation (Placement(transformation(extent={{-124,-60},{-84,-20}})));
equation
  Q_flow = (senT_supply.T - senT_return.T) * 4180 * senMasFlo.m_flow;
  connect(senT_return.port_a, sink.ports[1])
    annotation (Line(points={{-60,0},{-50,0},{-50,-20},{-44,-20}},
                                               color={0,127,255}));
  connect(source.ports[1], fan.port_a) annotation (Line(points={{-60,40},{-50,40},
          {-50,80},{-40,80}}, color={0,127,255}));
  connect(senDen.port_b, senT_supply.port_a)
    annotation (Line(points={{40,10},{40,0}}, color={0,127,255}));
  connect(senT_return.T, source.T_in) annotation (Line(points={{-70,11},{-70,20},
          {-92,20},{-92,44},{-82,44}}, color={0,0,127}));
  connect(senDen.port_a, IdealHeater.port_b) annotation (Line(points={{40,30},{40,
          60},{60,60},{60,80},{50,80}}, color={0,127,255}));
  connect(TIn, IdealHeater.TSet) annotation (Line(points={{-104,60},{-82,60},{-82,
          94},{28,94},{28,88}}, color={0,0,127}));
  connect(fan.port_b, IdealHeater.port_a)
    annotation (Line(points={{-20,80},{30,80}}, color={0,127,255}));
  connect(dpIn, fan.dp_in) annotation (Line(points={{-104,-40},{-16,-40},{-16,
          44},{-30,44},{-30,68}}, color={0,0,127}));
    annotation (Placement(transformation(extent={{98,50},{118,70}})),
              Icon(coordinateSystem(extent={{-100,-100},{120,100}}),
                   graphics={Ellipse(
          extent={{-78,40},{2,-40}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid)}), Documentation(revisions="<html><ul>
  <li>March 3, 2018, by Marcus Fuchs:<br/>
    Implemented for <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/402\">issue 403</a>.
  </li>
</ul>
</html>", info="<html>
<p>
  This model represents the supply node with an ideal pressure source
  and sink. It provides a prescribed supply pressure and supply
  temperature to the network.
</p>
</html>"),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}})));
end SourceIdealPump;
