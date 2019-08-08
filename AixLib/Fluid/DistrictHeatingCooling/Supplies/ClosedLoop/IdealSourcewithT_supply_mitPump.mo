within AixLib.Fluid.DistrictHeatingCooling.Supplies.ClosedLoop;
model IdealSourcewithT_supply_mitPump

      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium model for water"
      annotation (choicesAllMatching = true);

       parameter Modelica.SIunits.Pressure dp_nominal(displayUnit="Pa")=30000
      "Nominal pressure drop";

  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium)
    "Fluid connector for connecting the ideal plant to the cold line of the network"
    annotation (Placement(transformation(extent={{-136,-12},{-112,12}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium)
    "Fluid connector for connecting the ideal plant to the warm line of the network"
    annotation (Placement(transformation(extent={{106,-14},{134,14}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
        Medium, m_flow_nominal=2,
    tau=0,
    allowFlowReversal=false,
    T_start=283.15)
    annotation (Placement(transformation(extent={{14,10},{34,-10}})));
  Modelica.Blocks.Interfaces.RealInput  TIn(unit="K")
 "Prescribed supply temperature"
    annotation (Placement(transformation(extent={{-126,60},{-86,100}})));

  Sensors.MassFlowRate m_flow(redeclare package Medium = Medium,
      allowFlowReversal=false)
    annotation (Placement(transformation(extent={{68,10},{88,-10}})));
  Sensors.TemperatureTwoPort senTem1( redeclare package Medium = Medium,m_flow_nominal=2, tau=0,
    allowFlowReversal=false)
    annotation (Placement(transformation(extent={{-82,10},{-62,-10}})));
  MixingVolumes.MixingVolume vol(
    redeclare package Medium = Medium,
    nPorts=2,
    m_flow_nominal=2,
    V=5) annotation (Placement(transformation(extent={{-64,0},{-44,20}})));
  Sources.PropertySource_T proSou(redeclare package Medium = Medium,use_T_in=true)
    annotation (Placement(transformation(extent={{-42,-10},{-22,10}})));
  Sensors.SpecificEnthalpyTwoPort Re(redeclare package Medium = Medium,
      m_flow_nominal=2)
    annotation (Placement(transformation(extent={{-108,10},{-88,-10}})));
  Sensors.SpecificEnthalpyTwoPort For(redeclare package Medium = Medium,
      m_flow_nominal=2)
    annotation (Placement(transformation(extent={{42,10},{62,-10}})));
  Modelica.Blocks.Sources.RealExpression heat_flow(y=(Re.h_out - For.h_out)*
        m_flow.m_flow/1000)
    annotation (Placement(transformation(extent={{66,-48},{86,-28}})));
  Utilities.Sensors.EnergyMeter energyMeter
    annotation (Placement(transformation(extent={{94,-46},{106,-30}})));
  Movers.FlowControlled_m_flow fan(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    m_flow_nominal=3,
    m_flow_small=0.0002,
    m_flow_start=3,
    addPowerToMedium=false,
    dp_nominal=300000)
    annotation (Placement(transformation(extent={{-12,-10},{8,10}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=4)
    annotation (Placement(transformation(extent={{-26,24},{-6,44}})));
  Utilities.Sensors.FuelCounter fuelCounter
    annotation (Placement(transformation(extent={{18,24},{38,44}})));
  Sources.FixedBoundary bou(redeclare package Medium = Medium,nPorts=1)
    annotation (Placement(transformation(extent={{-44,-48},{-24,-28}})));
equation
  connect(m_flow.port_b, port_b)
    annotation (Line(points={{88,0},{98,0},{98,1.77636e-15},{120,1.77636e-15}},
                                              color={0,127,255}));
  connect(senTem1.port_b, vol.ports[1]) annotation (Line(points={{-62,0},{-56,0}},
                            color={0,127,255}));
  connect(vol.ports[2], proSou.port_a) annotation (Line(points={{-52,0},{-42,0}},
                            color={0,127,255}));
  connect(TIn, proSou.T_in)
    annotation (Line(points={{-106,80},{-36,80},{-36,12}},
                                                         color={0,0,127}));
  connect(port_a, Re.port_a)
    annotation (Line(points={{-124,0},{-108,0}},color={0,127,255}));
  connect(Re.port_b, senTem1.port_a)
    annotation (Line(points={{-88,0},{-82,0}}, color={0,127,255}));
  connect(senTem.port_b, For.port_a)
    annotation (Line(points={{34,0},{42,0}}, color={0,127,255}));
  connect(For.port_b, m_flow.port_a)
    annotation (Line(points={{62,0},{68,0}}, color={0,127,255}));
  connect(heat_flow.y, energyMeter.p)
    annotation (Line(points={{87,-38},{94.4,-38}}, color={0,0,127}));
  connect(proSou.port_b, fan.port_a)
    annotation (Line(points={{-22,0},{-12,0}}, color={0,127,255}));
  connect(fan.port_b, senTem.port_a)
    annotation (Line(points={{8,0},{14,0}}, color={0,127,255}));
  connect(realExpression.y, fan.m_flow_in) annotation (Line(points={{-5,34},{-4,
          34},{-4,12},{-2,12}}, color={0,0,127}));
  connect(fan.P, fuelCounter.fuel_in)
    annotation (Line(points={{9,9},{9,34},{18,34}}, color={0,0,127}));
  connect(bou.ports[1], fan.port_a) annotation (Line(points={{-24,-38},{-18,-38},
          {-18,0},{-12,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},
            {120,100}}),                                        graphics={
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
        coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},{120,100}})),
    Documentation(revisions="<html>
<ul>
<li><i>August 09, 2018</i> ,by Tobias Blacha:<br/>
Implemented </li>
</ul>
</html>"));
end IdealSourcewithT_supply_mitPump;
