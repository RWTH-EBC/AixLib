within AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop;
model SubstationCooling

    replaceable package Medium =
    Modelica.Media.Interfaces.PartialMedium "Medium model for water"
      annotation (choicesAllMatching = true);

    parameter Modelica.SIunits.SpecificHeatCapacity cp_default = 4180 "Cp-value of Water";

    parameter Modelica.SIunits.HeatFlowRate CoolingDemand_max "maximum cooling demand for scaling of chiller in Watt (negative values)";

    parameter Modelica.SIunits.Temperature deltaT_coolingSet "set temperature difference for cooling on the building site";

    parameter Modelica.SIunits.Temperature deltaT_coolingGridSet "set temperature difference for cooling on the side of the thermal network";

    parameter Modelica.SIunits.Pressure dp_nominal(displayUnit="Pa")=30000;

  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-152,-10},{-132,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  AixLib.Fluid.Delays.DelayFirstOrder vol(
    nPorts=2,
    redeclare package Medium = Medium,
    tau=600,
    m_flow_nominal=2)
             annotation (Placement(transformation(extent={{-90,6},{-70,26}})));
  AixLib.Fluid.Delays.DelayFirstOrder vol1(
    nPorts=2,
    redeclare package Medium = Medium,
    tau=600,
    m_flow_nominal=2,
    T_start=288.15)
             annotation (Placement(transformation(extent={{70,6},{90,26}})));
  AixLib.Fluid.Movers.FlowControlled_m_flow pumpCooling(redeclare package
      Medium = Medium, m_flow_nominal=2,
    addPowerToMedium=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    use_inputFilter=false)
    annotation (Placement(transformation(extent={{48,-10},{28,10}})));
  AixLib.Fluid.Chillers.Carnot_TEva       chiller(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    allowFlowReversal1=true,
    use_eta_Carnot_nominal=true,
    dp1_nominal=dp_nominal,
    dp2_nominal=dp_nominal,
    allowFlowReversal2=false,
    QEva_flow_nominal=CoolingDemand_max,
    dTEva_nominal=-5,
    dTCon_nominal=6,
    etaCarnot_nominal=0.3)
                      annotation (Placement(transformation(
        extent={{-15,10},{15,-10}},
        rotation=180,
        origin={5,-48})));
  AixLib.Fluid.Sources.MassFlowSource_T boundary1(
    use_m_flow_in=true,
    use_T_in=true,
    redeclare package Medium = Medium,
    nPorts=1)
    annotation (Placement(transformation(extent={{-50,-70},{-30,-50}})));
  Modelica.Blocks.Sources.Constant deltaT_coolingBuildingSite(k=
        deltaT_coolingSet)
    annotation (Placement(transformation(extent={{-126,-100},{-106,-80}})));
  AixLib.Fluid.Sources.FixedBoundary bou1(redeclare package Medium = Medium,
      nPorts=1)
    annotation (Placement(transformation(extent={{60,-70},{40,-50}})));
  Modelica.Blocks.Sources.Constant const(k=-(cp_default*deltaT_coolingSet))
    annotation (Placement(transformation(extent={{-90,-38},{-78,-26}})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{-48,-34},{-34,-20}})));
  Modelica.Blocks.Sources.Constant const1(k=-(cp_default*deltaT_coolingGridSet))
    annotation (Placement(transformation(extent={{-24,42},{-12,54}})));
  Modelica.Blocks.Math.Division division1
    annotation (Placement(transformation(extent={{-8,64},{6,78}})));
  Modelica.Blocks.Interfaces.RealInput coolingDemand
    "in Watt (negative values for cooling)"
    annotation (Placement(transformation(extent={{-166,60},{-126,100}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
        Medium, m_flow_nominal=2)
    annotation (Placement(transformation(extent={{-34,-10},{-14,12}})));
  Modelica.Blocks.Interfaces.RealInput T_supplyCoolingSet
    annotation (Placement(transformation(extent={{-166,10},{-126,50}})));
  Modelica.Blocks.Math.Add add(k2=+1)
    annotation (Placement(transformation(extent={{-92,-80},{-72,-60}})));
  Modelica.Blocks.Math.Add add1(k2=-1)
    annotation (Placement(transformation(extent={{-44,64},{-24,84}})));
  Modelica.Blocks.Interfaces.RealOutput powerConsumptionChiller
    annotation (Placement(transformation(extent={{100,86},{120,106}})));
  Modelica.Blocks.Interfaces.RealOutput powerConsumptionPump
    annotation (Placement(transformation(extent={{100,66},{120,86}})));
  Modelica.Blocks.Interfaces.RealOutput powerConsumptionSubstation
    annotation (Placement(transformation(extent={{100,46},{120,66}})));
  Modelica.Blocks.Math.Sum sum1(nin=1)
    annotation (Placement(transformation(extent={{60,46},{80,66}})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{-108,70},{-88,90}})));
equation
  connect(port_a, vol.ports[1])
    annotation (Line(points={{-142,0},{-82,0},{-82,6}}, color={0,127,255}));
  connect(port_b, vol1.ports[1])
    annotation (Line(points={{100,0},{78,0},{78,6}}, color={0,127,255}));
  connect(pumpCooling.port_a, vol1.ports[2])
    annotation (Line(points={{48,0},{82,0},{82,6}}, color={0,127,255}));
  connect(const.y, division.u2) annotation (Line(points={{-77.4,-32},{-68,-32},{
          -68,-31.2},{-49.4,-31.2}}, color={0,0,127}));
  connect(division.y, boundary1.m_flow_in) annotation (Line(points={{-33.3,-27},
          {-20,-27},{-20,-40},{-62,-40},{-62,-52},{-52,-52}}, color={0,0,127}));
  connect(const1.y, division1.u2) annotation (Line(points={{-11.4,48},{-10,48},{
          -10,66},{-10,66},{-9.4,66},{-9.4,66.8}},
                                   color={0,0,127}));
  connect(boundary1.ports[1], chiller.port_a2) annotation (Line(points={{-30,-60},
          {-26,-60},{-26,-62},{-20,-62},{-20,-54},{-10,-54}}, color={0,127,255}));
  connect(chiller.port_b2, bou1.ports[1]) annotation (Line(points={{20,-54},{
          28,-54},{28,-60},{40,-60}},
                                   color={0,127,255}));
  connect(pumpCooling.port_b, chiller.port_a1)
    annotation (Line(points={{28,0},{20,0},{20,-42}}, color={0,127,255}));
  connect(chiller.port_b1, senTem.port_b)
    annotation (Line(points={{-10,-42},{-10,1},{-14,1}}, color={0,0,127}));
  connect(senTem.port_a, vol.ports[2])
    annotation (Line(points={{-34,1},{-78,1},{-78,6}}, color={0,127,255}));
  connect(add.y, boundary1.T_in) annotation (Line(points={{-71,-70},{-68,-70},{-68,
          -56},{-52,-56}}, color={0,0,127}));
  connect(deltaT_coolingBuildingSite.y, add.u2) annotation (Line(points={{-105,
          -90},{-100,-90},{-100,-76},{-94,-76}}, color={0,0,127}));
  connect(T_supplyCoolingSet, add.u1) annotation (Line(points={{-146,30},{-106,30},
          {-106,-64},{-94,-64}}, color={0,0,127}));
  connect(add1.y, division1.u1) annotation (Line(points={{-23,74},{-16,74},{-16,
          75.2},{-9.4,75.2}}, color={0,0,127}));
  connect(chiller.P, add1.u2) annotation (Line(points={{-11.5,-48},{-54,-48},
          {-54,68},{-46,68}},
                         color={0,0,127}));
  connect(T_supplyCoolingSet, chiller.TSet) annotation (Line(points={{-146,30},
          {60,30},{60,-39},{23,-39}},color={0,0,127}));
  connect(division1.y, pumpCooling.m_flow_in)
    annotation (Line(points={{6.7,71},{38,71},{38,12}}, color={0,0,127}));
  connect(chiller.P, powerConsumptionChiller) annotation (Line(points={{-11.5,
          -48},{-54,-48},{-54,96},{110,96}},                 color={0,0,127}));
  connect(pumpCooling.P, powerConsumptionPump) annotation (Line(points={{27,9},
          {20,9},{20,76},{110,76}}, color={0,0,127}));
  connect(sum1.y, powerConsumptionSubstation)
    annotation (Line(points={{81,56},{110,56}}, color={0,0,127}));
  connect(chiller.P, sum1.u[1]) annotation (Line(points={{-11.5,-48},{-54,-48},{
          -54,56},{58,56}},  color={0,0,127}));
  connect(coolingDemand, gain.u)
    annotation (Line(points={{-146,80},{-110,80}}, color={0,0,127}));
  connect(gain.y, add1.u1)
    annotation (Line(points={{-87,80},{-46,80}}, color={0,0,127}));
  connect(gain.y, division.u1) annotation (Line(points={{-87,80},{-62,80},{
          -62,-22.8},{-49.4,-22.8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,-100},
            {100,120}}), graphics={
        Rectangle(
          extent={{-140,120},{100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-90,34},{58,-80}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,34},{58,34}}, color={28,108,200}),
        Polygon(
          points={{-104,34},{-18,112},{70,34},{-104,34}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-58,18},{-30,-12}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{0,18},{28,-12}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-32,-28},{-6,-80}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-140,-100},{100,120}})));
end SubstationCooling;
