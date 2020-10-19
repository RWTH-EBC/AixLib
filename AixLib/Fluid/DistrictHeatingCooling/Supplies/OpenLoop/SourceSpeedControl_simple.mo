within AixLib.Fluid.DistrictHeatingCooling.Supplies.OpenLoop;
model SourceSpeedControl_simple
  "Simple supply node model with speed controled pump"
  extends
    AixLib.Fluid.DistrictHeatingCooling.BaseClasses.Supplies.OpenLoop.PartialSupplyLessInputs(
      senT_return(allowFlowReversal=true));

  parameter Modelica.SIunits.AbsolutePressure pReturn
    "Fixed return pressure";

  AixLib.Fluid.Sources.Boundary_pT source(          redeclare package Medium =
        Medium,
    use_T_in=true,
    p=pReturn,
    use_p_in=true,
    nPorts=1)
    "Ideal fluid source with prescribed temperature and pressure"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-24,40})));

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

  Modelica.Blocks.Interfaces.RealInput TIn "Prescribed boundary temperature"
    annotation (Placement(transformation(extent={{-124,40},{-84,80}})));
  Modelica.Blocks.Interfaces.RealInput RpmIn
    "Prescribed rotational speed"
    annotation (Placement(transformation(extent={{-120,-80},{-80,-40}})));
  AixLib.Fluid.HeatExchangers.Heater_T CHP(
    redeclare package Medium = Medium,
    m_flow_nominal=182,
    dp_nominal(displayUnit="bar") = 300000,
    QMax_flow(displayUnit="MW") = 30000000)
    annotation (Placement(transformation(extent={{0,70},{20,90}})));
  AixLib.Fluid.Sensors.DensityTwoPort senDen(redeclare package Medium = Medium,
      m_flow_nominal=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={40,20})));
  AixLib.Fluid.HeatExchangers.Heater_T Gas_Burner(
    redeclare package Medium = Medium,
    m_flow_nominal=182,
    dp_nominal(displayUnit="bar") = 300000)
    annotation (Placement(transformation(extent={{30,70},{50,90}})));
  Modelica.Blocks.Sources.Constant T_max_BHKW(k=273.15 + 115)
    annotation (Placement(transformation(extent={{-74,66},{-54,86}})));
  JuLib.RPM_char rPM_char(m_flow_in=senMasFlo.m_flow/senDen.d*3600)
    annotation (Placement(transformation(extent={{-20,-68},{0,-48}})));
  Modelica.Blocks.Sources.Constant p_return(k=pReturn)
    annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
  Modelica.Blocks.Math.Add p_return1
    annotation (Placement(transformation(extent={{16,-42},{36,-22}})));
equation
  Q_flow = (senT_supply.T - senT_return.T) * 4180 * senMasFlo.m_flow;
  connect(senT_return.port_a, sink.ports[1])
    annotation (Line(points={{-60,0},{-50,0},{-50,-20},{-44,-20}},
                                               color={0,127,255}));
  connect(senDen.port_b, senT_supply.port_a)
    annotation (Line(points={{40,10},{40,0}}, color={0,127,255}));
  connect(senT_return.T, source.T_in) annotation (Line(points={{-70,11},{-70,20},
          {-92,20},{-92,44},{-36,44}}, color={0,0,127}));
  connect(CHP.port_b, Gas_Burner.port_a)
    annotation (Line(points={{20,80},{30,80}}, color={0,127,255}));
  connect(senDen.port_a, Gas_Burner.port_b) annotation (Line(points={{40,30},{
          40,60},{60,60},{60,80},{50,80}}, color={0,127,255}));
  connect(T_max_BHKW.y, CHP.TSet) annotation (Line(points={{-53,76},{-28,76},{
          -28,88},{-2,88}}, color={0,0,127}));
  connect(TIn, Gas_Burner.TSet) annotation (Line(points={{-104,60},{-82,60},{
          -82,94},{28,94},{28,88}}, color={0,0,127}));
  connect(rPM_char.RPM_in, RpmIn)
    annotation (Line(points={{-20.8,-60},{-100,-60}}, color={0,0,127}));
  connect(p_return.y, p_return1.u1) annotation (Line(points={{1,-10},{6,-10},{6,
          -26},{14,-26}}, color={0,0,127}));
  connect(rPM_char.p_out, p_return1.u2) annotation (Line(points={{0.6,-58},{8,
          -58},{8,-38},{14,-38}}, color={0,0,127}));
  connect(p_return1.y, source.p_in) annotation (Line(points={{37,-32},{0,-32},{
          0,48},{-36,48}}, color={0,0,127}));
  connect(source.ports[1], CHP.port_a) annotation (Line(points={{-14,40},{-8,40},
          {-8,80},{0,80}}, color={0,127,255}));
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
end SourceSpeedControl_simple;
