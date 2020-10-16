within AixLib.Fluid.DistrictHeatingCooling.BaseClasses.Demands.NoReturn;
partial model PartialDemandFlowControlled
  "Base class for modeling demand nodes in DHC systems without return lines"

  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium model" annotation (choicesAllMatching=true);

  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium) "Inlet port of demand node"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senT_supply(redeclare package Medium =
        Medium, m_flow_nominal=1) "Supply flow temperature sensor"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  replaceable Demands.Substations.PartialSubstation substation(redeclare
      package Medium = Medium)
    "Substation model for demand node"
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Movers.FlowControlled_m_flow          sink(
    redeclare package Medium = Medium, m_flow_nominal=0.5)
                        "Sink extracting prescribed flow from the network"
                                              annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={60,0})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senT_return(redeclare package Medium =
        Medium, m_flow_nominal=1) "Return flow temperature sensor"
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));

protected
  final parameter Medium.ThermodynamicState sta_default = Medium.setState_pTX(
    T=Medium.T_default,
    p=Medium.p_default,
    X=Medium.X_default[1:Medium.nXi]) "Medium state at default properties";
  final parameter Modelica.SIunits.SpecificHeatCapacity cp_default=
    Medium.specificHeatCapacityCp(sta_default)
    "Specific heat capacity of the fluid";

public
  Sensors.Pressure senPre_supply(redeclare package Medium = Medium)
    "Supply pressure arriving at demand node"
    annotation (Placement(transformation(extent={{-90,10},{-70,30}})));
  Sources.FixedBoundary bou(nPorts=1, redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{100,-10},{80,10}})));
equation
  connect(senT_supply.port_b, substation.port_a)
    annotation (Line(points={{-40,0},{-20,0}}, color={0,127,255}));
  connect(substation.port_b, senT_return.port_a)
    annotation (Line(points={{0,0},{10,0},{20,0}}, color={0,127,255}));
  connect(port_a, senT_supply.port_a)
    annotation (Line(points={{-100,0},{-60,0}}, color={0,127,255}));
  connect(senPre_supply.port, senT_supply.port_a)
    annotation (Line(points={{-80,10},{-80,0},{-60,0}}, color={0,127,255}));
  connect(senT_return.port_b, sink.port_a)
    annotation (Line(points={{40,0},{50,0}}, color={0,127,255}));
  connect(sink.port_b, bou.ports[1])
    annotation (Line(points={{70,0},{80,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Polygon(
          points={{-90,40},{-90,-40},{-30,0},{-90,40}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html><ul>
  <li>May 27, 2017, by Marcus Fuchs:<br/>
    First implementation for <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/403\">issue 403</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This base class provides a common interface for demand node models
  that do not represent the return flow back into the network.
</p>
</html>"));
end PartialDemandFlowControlled;
