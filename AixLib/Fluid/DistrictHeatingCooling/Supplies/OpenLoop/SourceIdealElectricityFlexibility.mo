within AixLib.Fluid.DistrictHeatingCooling.Supplies.OpenLoop;
model SourceIdealElectricityFlexibility
  "Simple supply node model with ideal flow source and return port with additional use of electrictiy for heat supply"
  extends BaseClasses.Supplies.OpenLoop.PartialSupply(senT_return(
        m_flow_nominal=m_flow_nominal), senT_supply(m_flow_nominal=
          m_flow_nominal));

  parameter Modelica.Units.SI.Power Q_maxHeater;
  parameter Modelica.Units.SI.Power Q_maxElectricHeater;
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal;

  parameter Modelica.Units.SI.AbsolutePressure pReturn
    "Fixed return pressure";

  parameter Modelica.Units.SI.Temperature TReturn
    "Fixed return temperature";

  AixLib.Fluid.Sources.Boundary_pT source(          redeclare package Medium =
        Medium,
    use_T_in=true,
    use_p_in=true,
    nPorts=1)
    "Ideal fluid source with prescribed temperature and pressure"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-10,0})));

  Sources.Boundary_pT   sink(redeclare package Medium = Medium,
    p=pReturn,
    nPorts=1)
    "Ideal sink for return from the network" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-40,0})));
  HeatExchangers.PrescribedOutlet electricHeater(
    redeclare package Medium = Medium,
    QMax_flow=Q_maxElectricHeater,
    QMin_flow=0,
    use_TSet=true,
    use_X_wSet=false,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=50000)
    annotation (Placement(transformation(extent={{-20,36},{0,56}})));
  HeatExchangers.PrescribedOutlet Heater(
    redeclare package Medium = Medium,
    QMin_flow=0,
    use_TSet=true,
    use_X_wSet=false,
    QMax_flow=Q_maxHeater,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=50000)
    annotation (Placement(transformation(extent={{26,36},{46,56}})));
  Sensors.TemperatureTwoPort senT_electricHeater(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal)
                annotation (Placement(transformation(extent={{6,40},{16,52}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow_elctricHeater
    annotation (Placement(transformation(extent={{96,70},{116,90}})));
  Modelica.Blocks.Interfaces.RealInput Tset_electricHeater
    annotation (Placement(transformation(extent={{-124,18},{-84,58}})));
equation
  connect(source.ports[1], electricHeater.port_a) annotation (Line(points={{0,0},{0,
          26},{-36,26},{-36,46},{-20,46}},          color={0,127,255}));
  connect(electricHeater.port_b, senT_electricHeater.port_a)
    annotation (Line(points={{0,46},{6,46}}, color={0,127,255}));
  connect(senT_electricHeater.port_b, Heater.port_a)
    annotation (Line(points={{16,46},{26,46}}, color={0,127,255}));
  connect(Heater.port_b, senT_supply.port_a) annotation (Line(points={{46,46},{58,
          46},{58,26},{28,26},{28,0},{40,0}}, color={0,127,255}));
  connect(dpIn, source.p_in) annotation (Line(points={{-106,-70},{-28,-70},{-28,
          8},{-22,8}}, color={0,0,127}));
  connect(senT_return.T, source.T_in) annotation (Line(points={{-70,11},{-70,20},
          {-26,20},{-26,4},{-22,4}}, color={0,0,127}));
  connect(electricHeater.Q_flow, Q_flow_elctricHeater)
    annotation (Line(points={{1,54},{6,54},{6,80},{106,80}}, color={0,0,127}));
  connect(TIn, Heater.TSet) annotation (Line(points={{-106,70},{18,70},{18,54},
          {24,54}}, color={0,0,127}));
  connect(Tset_electricHeater, electricHeater.TSet) annotation (Line(points={{
          -104,38},{-58,38},{-58,54},{-22,54}}, color={0,0,127}));
  connect(senT_return.port_a, sink.ports[1])
    annotation (Line(points={{-60,0},{-50,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(extent={{-120,-100},{100,100}}),
                   graphics={Ellipse(
          extent={{-78,40},{2,-40}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid)}), Documentation(revisions="<html><ul>
  <li>October 23, 2018, by Tobias Blacha:<br/>
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
end SourceIdealElectricityFlexibility;
