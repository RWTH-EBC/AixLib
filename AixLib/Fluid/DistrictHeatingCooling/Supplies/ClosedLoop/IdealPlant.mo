within AixLib.Fluid.DistrictHeatingCooling.Supplies.ClosedLoop;
model IdealPlant
  "Supply node model with ideal heater and cooler for heat and cold supply of bidirectional networks"

      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium model for water"
      annotation (choicesAllMatching = true);

      parameter Modelica.SIunits.Pressure dp_nominal(displayUnit="Pa")=30000
      "Nominal pressure drop";
      parameter Modelica.SIunits.MassFlowRate m_flow_nominal "Nominal mass flow rate";

  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium)
    "Fluid connector for connecting the ideal plant to the cold line of the network"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium)
    "Fluid connector for connecting the ideal plant to the warm line of the network"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  AixLib.Fluid.HeatExchangers.PrescribedOutlet heater(redeclare package Medium =
        Medium,
    QMin_flow=0,use_X_wSet=false,
    dp_nominal=dp_nominal,
    m_flow_nominal=m_flow_nominal,
    use_TSet=true)
    annotation (Placement(transformation(extent={{-58,-10},{-38,10}})));
  AixLib.Fluid.HeatExchangers.PrescribedOutlet cooler(
    redeclare package Medium = Medium,
    QMax_flow=0,
    use_X_wSet=false,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=dp_nominal)
    annotation (Placement(transformation(extent={{46,-10},{26,10}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
        Medium, m_flow_nominal=2)
    annotation (Placement(transformation(extent={{-12,-10},{8,10}})));
  Modelica.Blocks.Interfaces.RealInput T_coolingSet(unit = "K")
  "Maximum supply temperature of the cold line of the bidirectional low-temperature network"
    annotation (Placement(transformation(extent={{-126,60},{-86,100}})));
  Modelica.Blocks.Interfaces.RealInput T_heatingSet(unit = "K")
  "Minimum supply temperature of the hot line of the bidirectional low-temperature network"
    annotation (Placement(transformation(extent={{-126,22},{-86,62}})));
  Sources.Boundary_pT bou(redeclare package Medium = Medium, nPorts=1)
    annotation (Placement(transformation(extent={{-60,36},{-40,56}})));
equation
  connect(port_b, cooler.port_a)
    annotation (Line(points={{100,0},{46,0}}, color={0,127,255}));
  connect(senTem.port_b, cooler.port_b)
    annotation (Line(points={{8,0},{26,0}}, color={0,127,255}));
  connect(heater.port_b, senTem.port_a)
    annotation (Line(points={{-38,0},{-12,0}}, color={0,127,255}));
  connect(port_a,heater. port_a)
    annotation (Line(points={{-100,0},{-58,0}}, color={0,127,255}));
  connect(T_heatingSet,heater. TSet) annotation (Line(points={{-106,42},{-90,42},
          {-90,42},{-74,42},{-74,8},{-60,8}}, color={0,0,127}));
  connect(T_coolingSet, cooler.TSet) annotation (Line(points={{-106,80},{60,80},
          {60,8},{48,8}}, color={0,0,127}));
  connect(bou.ports[1], senTem.port_a) annotation (Line(points={{-40,46},{-26,
          46},{-26,0},{-12,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-80,80},{80,0}},
          lineColor={28,108,200},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-80,-80},{80,0}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.None)}),                       Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html><ul>
  <li>
    <i>August 09, 2018</i> ,by Tobias Blacha:<br/>
    Implemented
  </li>
</ul>
</html>", info="<html>
This model represents the supply node of a bidirectional network with
indeal heater and ideal cooler. The operation mode of the depends on
the flow direction. In the case that port_b is the outlet, heating
operation takes place. In the case that port_a is the outlet, cooling
operation takes place.
</html>"));
end IdealPlant;
