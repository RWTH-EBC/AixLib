within AixLib.Fluid.DistrictHeatingCooling.Supplies.OpenLoop;
model SourceIdealPowerIn
  "Simple supply node model with ideal flow source and return port"
  extends BaseClasses.Supplies.OpenLoop.PartialSupplyLessInputs(senT_return(
        allowFlowReversal=true));

  parameter Modelica.SIunits.AbsolutePressure pReturn
    "Fixed return pressure";

  parameter Modelica.SIunits.Temperature TReturn
    "Fixed return temperature";

  AixLib.Fluid.Sources.Boundary_pT source(          redeclare package Medium =
        Medium,
    use_T_in=true,
    use_p_in=true,
    nPorts=1)
    "Ideal fluid source with prescribed temperature and pressure"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={0,0})));

  Sources.Boundary_pT   sink(redeclare package Medium = Medium,
    p=pReturn,
    nPorts=1)
    "Ideal sink for return from the network" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-30,0})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow
    annotation (Placement(transformation(extent={{98,70},{118,90}})));
  Modelica.Blocks.Interfaces.RealInput Q_flow_in
    annotation (Placement(transformation(extent={{-128,60},{-88,100}})));
  Modelica.Blocks.Interfaces.RealInput dpIn
    annotation (Placement(transformation(extent={{-130,-60},{-90,-20}})));
  HeatExchangers.HeaterCooler_u hea(
    redeclare package Medium = Medium,
    m_flow_nominal=15,
    dp_nominal=0,
    Q_flow_nominal=315000)
    annotation (Placement(transformation(extent={{14,24},{34,44}})));
equation
  Q_flow = (senT_supply.T - senT_return.T) * 4180 * senMasFlo.m_flow;
  connect(senT_return.port_a, sink.ports[1])
    annotation (Line(points={{-60,0},{-40,0}}, color={0,127,255}));
  connect(dpIn, source.p_in) annotation (Line(points={{-110,-40},{-52,-40},{-52,
          8},{-12,8}}, color={0,0,127}));
  connect(senT_return.T, source.T_in) annotation (Line(points={{-70,11},{-32,11},
          {-32,4},{-12,4}}, color={0,0,127}));
  connect(source.ports[1], hea.port_a)
    annotation (Line(points={{10,0},{14,0},{14,34}}, color={0,127,255}));
  connect(hea.port_b, senT_supply.port_a) annotation (Line(points={{34,34},{38,
          34},{38,0},{40,0}}, color={0,127,255}));
  connect(Q_flow_in, hea.u) annotation (Line(points={{-108,80},{-48,80},{-48,40},
          {12,40}}, color={0,0,127}));
    annotation (Placement(transformation(extent={{98,50},{118,70}})),
              Icon(graphics={Ellipse(
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
</html>"));
end SourceIdealPowerIn;
