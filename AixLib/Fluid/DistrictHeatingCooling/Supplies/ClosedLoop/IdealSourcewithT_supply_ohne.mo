within AixLib.Fluid.DistrictHeatingCooling.Supplies.ClosedLoop;
model IdealSourcewithT_supply_ohne

      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium model for water"
      annotation (choicesAllMatching = true);

       parameter Modelica.SIunits.Pressure dp_nominal(displayUnit="Pa")=30000
      "Nominal pressure drop";

  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium)
    "Fluid connector for connecting the ideal plant to the cold line of the network"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium)
    "Fluid connector for connecting the ideal plant to the warm line of the network"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
        Medium, m_flow_nominal=2,
    tau=0,
    allowFlowReversal=false,
    T_start=283.15)
    annotation (Placement(transformation(extent={{38,10},{58,-10}})));
  Modelica.Blocks.Interfaces.RealInput  TIn(unit="K")
 "Prescribed supply temperature"
    annotation (Placement(transformation(extent={{-126,60},{-86,100}})));

  Sensors.MassFlowRate m_flow(redeclare package Medium = Medium,
      allowFlowReversal=false)
    annotation (Placement(transformation(extent={{68,10},{88,-10}})));
  Sensors.TemperatureTwoPort senTem1( redeclare package Medium = Medium,m_flow_nominal=2, tau=0,
    allowFlowReversal=false)
    annotation (Placement(transformation(extent={{-88,10},{-68,-10}})));
  MixingVolumes.MixingVolume vol(
    redeclare package Medium = Medium,
    nPorts=2,
    m_flow_nominal=2,
    V=5) annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  Utilities.Sensors.EnergyMeter energyMeter
    annotation (Placement(transformation(extent={{90,16},{102,32}})));
  HeatExchangers.PrescribedOutlet preOut(
    redeclare package Medium = Medium,
    m_flow_nominal=3,
    use_X_wSet=false,
    dp_nominal=0)
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Sources.FixedBoundary bou( redeclare package Medium = Medium, nPorts=1)
    annotation (Placement(transformation(extent={{-92,28},{-72,48}})));
equation
  connect(m_flow.port_b, port_b)
    annotation (Line(points={{88,0},{100,0}}, color={0,127,255}));
  connect(senTem1.port_b, vol.ports[1]) annotation (Line(points={{-68,0},{-52,0}},
                            color={0,127,255}));
  connect(preOut.port_b, senTem.port_a)
    annotation (Line(points={{30,0},{38,0}}, color={0,127,255}));
  connect(TIn, preOut.TSet)
    annotation (Line(points={{-106,80},{8,80},{8,8}},     color={0,0,127}));
  connect(preOut.Q_flow, energyMeter.p) annotation (Line(points={{31,8},{32,8},{
          32,24},{90.4,24}},               color={0,0,127}));
  connect(port_a, senTem1.port_a)
    annotation (Line(points={{-100,0},{-88,0}}, color={0,127,255}));
  connect(senTem.port_b, m_flow.port_a)
    annotation (Line(points={{58,0},{68,0}}, color={0,127,255}));
  connect(bou.ports[1], senTem1.port_b) annotation (Line(points={{-72,38},{-66,38},
          {-66,0},{-68,0}},     color={0,127,255}));
  connect(vol.ports[2], preOut.port_a)
    annotation (Line(points={{-48,0},{10,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,
            -100},{100,100}}),                                  graphics={
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
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    Documentation(revisions="<html>
<ul>
<li><i>August 09, 2018</i> ,by Tobias Blacha:<br/>
Implemented </li>
</ul>
</html>"));
end IdealSourcewithT_supply_ohne;
