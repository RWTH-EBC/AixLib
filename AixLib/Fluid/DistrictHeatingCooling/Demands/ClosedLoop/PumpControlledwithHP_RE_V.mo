within AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop;
model PumpControlledwithHP_RE_V "Substation model for  low-temperature networks for buildings with 
  heat pump and chiller"

      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium model for water"
      annotation (choicesAllMatching = true);
      replaceable package MediumBuilding = AixLib.Media.Water
      "Medium in the building heating system"
      annotation (choicesAllMatching = true);

   final parameter Medium.ThermodynamicState sta_default = Medium.setState_pTX(
    T=Medium.T_default,
    p=Medium.p_default,
    X=Medium.X_default[1:Medium.nXi]) "Medium state at default properties";
    final parameter Modelica.SIunits.SpecificHeatCapacity cp_default =   Medium.specificHeatCapacityCp(sta_default)
                                                                                  "Cp-value of Water";
    parameter Modelica.SIunits.HeatFlowRate heatDemand_max "maximum heat demand for scaling of heatpump in Watt";
//    parameter Modelica.SIunits.HeatFlowRate coolingDemand_max=-5000
//                                                              "maximum cooling demand for scaling of chiller in Watt (negative values)";
    parameter Modelica.SIunits.Temperature T_supplyHeating "set temperature of supply heating";
    parameter Modelica.SIunits.Temperature T_supplyCooling "set temperature of supply heating";

 //   parameter Modelica.SIunits.Temperature deltaT_heatingSet "set temperature difference for heating on the site of building";
 //   parameter Modelica.SIunits.Temperature deltaT_coolingSet "set temperature difference for cooling on the building site";

    parameter Modelica.SIunits.Pressure dp_nominal=400000                  "nominal pressure drop";

    parameter Modelica.SIunits.MassFlowRate m_flow_nominal=(heatDemand_max)/4180
      /10
    "Nominal mass flow rate";

public
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium)
    "Fluid connector for connecting the substation to the warm line of the network"
    annotation (Placement(transformation(extent={{-270,-10},{-250,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium)
    "Fluid connector for connecting the substation to the cold line of the network"
    annotation (Placement(transformation(extent={{210,-10},{230,10}}),
        iconTransformation(extent={{210,-10},{230,10}})));
  Modelica.Blocks.Interfaces.RealInput[2] Q_flow_input
  "Input for heat demand profile of substation"
    annotation (Placement(transformation(extent={{-280,-60},{-240,-20}}),
        iconTransformation(extent={{232,76},{192,116}})));

  Modelica.Blocks.Math.Gain dhw_load(k=cp_default*40/3600)
    annotation (Placement(transformation(extent={{-260,-90},{-240,-70}})));
  Sensors.TemperatureTwoPort senTem1(redeclare package Medium = MediumBuilding,tau=0,
    m_flow_nominal=m_flow_nominal,
    T_start=308.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-84,-30})));
  Delays.DelayFirstOrder del1(
    redeclare package Medium = Medium,
    tau=600,
    m_flow_nominal=2*m_flow_nominal,
    T_start=283.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{140,12},{160,32}})));
  Sources.FixedBoundary bou(
    redeclare package Medium = MediumBuilding,
    use_p=true,
    use_T=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{-164,-30},{-144,-10}})));

  Sensors.TemperatureTwoPort senTem(redeclare package Medium = Medium,m_flow_nominal=2*m_flow_nominal, tau=0,
    T_start=283.15)
    annotation (Placement(transformation(extent={{46,-10},{66,10}})));
  Sources.FixedBoundary bou1(redeclare package Medium = Medium,          use_T=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{-182,14},{-162,34}})));
  Sensors.TemperatureTwoPort senTem2(redeclare package Medium =Medium,allowFlowReversal=false, tau=0,
    m_flow_nominal=2*m_flow_nominal)
    annotation (Placement(transformation(extent={{-78,-10},{-58,10}})));
  Modelica.Blocks.Sources.RealExpression T_dhw(y=273.15 + 65)
    annotation (Placement(transformation(extent={{42,-74},{22,-54}})));
  Modelica.Blocks.Sources.RealExpression T_room_r(y=switch1.y - heatload.y/(
        cp_default*m_flow_nominal))
    annotation (Placement(transformation(extent={{164,-72},{144,-52}})));
  Movers.FlowControlled_m_flow fan(
     dp_nominal= dp_nominal,
     redeclare package Medium = Medium,
    allowFlowReversal=false,
    m_flow_small=0.0001,
    use_inputFilter=true,
    y_start=1,
    m_flow_nominal=2,
    m_flow_start=1,
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{-142,-8},{-122,12}})));
  Modelica.Blocks.Sources.RealExpression realExpression5(y=1)
    annotation (Placement(transformation(extent={{-92,16},{-112,36}})));
  Sources.MassFlowSource_T boundary(
    redeclare package Medium =MediumBuilding,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{108,-38},{88,-18}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=m_flow_nominal)
    annotation (Placement(transformation(extent={{144,-30},{124,-10}})));
  Utilities.Sensors.EnergyMeter con_HM(q_joule(fixed=true, start=0))
    annotation (Placement(transformation(
        extent={{-6,-8},{6,8}},
        rotation=90,
        origin={-56,58})));
  Utilities.Sensors.EnergyMeter eva_HM annotation (Placement(transformation(
        extent={{-6,-8},{6,8}},
        rotation=90,
        origin={-12,60})));
  Utilities.Sensors.FuelCounter fuelCounter annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-38,58})));

  Modelica.Blocks.Sources.RealExpression heatload(y=Q_flow_input[1])
    annotation (Placement(transformation(extent={{-212,-66},{-192,-46}})));
  Sensors.TemperatureTwoPort senTem3(
  redeclare package Medium = MediumBuilding,
  tau=0,
  m_flow_nominal=m_flow_nominal,
  T_start=308.15)
    annotation (Placement(transformation(extent={{62,-22},{42,-42}})));
  HeatPumps.Carnot_TCon_RE heaPum(
  redeclare package Medium2 = Medium,
    redeclare package Medium1 = MediumBuilding,
    show_T=true,
    dTEva_nominal=-10,
    dTCon_nominal=10,
    etaCarnot_nominal=0.5,
    Q_heating_nominal=heatDemand_max,
    use_eta_Carnot_nominal=true,
    dp1_nominal=30000,
    dp2_nominal=30000,
    m2_flow_nominal=1,
    m1_flow_nominal=m_flow_nominal,
    Q_cooling_nominal=-15000,
    TEva_nominal=283.15)
    annotation (Placement(transformation(extent={{-4,-6},{-24,-26}})));
  Modelica.Blocks.Logical.Switch switch1 annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={0,-50})));
  Modelica.Blocks.Sources.TimeTable T_room(table=[0,273.15 + 35; 7.0e+06,273.15
         + 35; 7.0e+06,273.15 + 35; 1.2e+07,273.15 + 35; 1.2e+07,273.15 + 10;
        2.2e+07,273.15 + 10; 2.2e+07,273.15 + 35; 2.7e+07,273.15 + 35; 2.7e+07,
        273.15 + 35; 3.1536e+07,273.15 + 35])
    annotation (Placement(transformation(extent={{-48,-72},{-28,-52}})));
  Modelica.Blocks.Logical.Switch switch2 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={118,-50})));
  Modelica.Blocks.Sources.RealExpression T_dhw_r(y=switch1.y - dhw_load.y/(
        cp_default*m_flow_nominal))
    annotation (Placement(transformation(extent={{68,-72},{88,-52}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=10)
    annotation (Placement(transformation(extent={{-208,-96},{-188,-76}})));
equation

  //Power Consumptin Calculation
  //connect(pumpCooling.P, sum1.u[3]);
  //connect(pumpHeating.P, sum1.u[4]);

  connect(fan.port_b, senTem2.port_a) annotation (Line(points={{-122,2},{-100,2},
          {-100,0},{-78,0}}, color={0,127,255}));
  connect(bou1.ports[1], fan.port_a) annotation (Line(points={{-162,24},{-142,24},
          {-142,2}}, color={0,127,255}));
  connect(senTem.port_b, del1.ports[1])
    annotation (Line(points={{66,0},{148,0},{148,12}}, color={0,127,255}));
  connect(del1.ports[2], port_b) annotation (Line(points={{152,12},{152,12},{
          152,0},{220,0}}, color={0,127,255}));
  connect(port_a, fan.port_a) annotation (Line(points={{-260,0},{-202,0},{-202,
          2},{-142,2}}, color={0,127,255}));
  connect(realExpression1.y, boundary.m_flow_in) annotation (Line(points={{123,-20},
          {110,-20}},                     color={0,0,127}));
  connect(senTem1.port_b, bou.ports[1]) annotation (Line(points={{-94,-30},{-120,
          -30},{-120,-20},{-144,-20}}, color={0,127,255}));
  connect(Q_flow_input[2], dhw_load.u) annotation (Line(points={{-260,-30},{-264,
          -30},{-264,-80},{-262,-80}}, color={0,0,127}));
  connect(realExpression5.y, fan.m_flow_in)
    annotation (Line(points={{-113,26},{-132,26},{-132,14}}, color={0,0,127}));
  connect(boundary.ports[1], senTem3.port_a) annotation (Line(points={{88,-28},{
          76,-28},{76,-32},{62,-32}}, color={0,127,255}));
  connect(senTem2.port_b, heaPum.port_a2) annotation (Line(points={{-58,0},{-28,
          0},{-28,-10},{-24,-10}}, color={0,127,255}));
  connect(heaPum.port_b2, senTem.port_a)
    annotation (Line(points={{-4,-10},{-4,0},{46,0}}, color={0,127,255}));
  connect(senTem3.port_b, heaPum.port_a1) annotation (Line(points={{42,-32},{34,
          -32},{34,-22},{-4,-22}}, color={0,127,255}));
  connect(heaPum.port_b1, senTem1.port_a) annotation (Line(points={{-24,-22},{-74,
          -22},{-74,-30}}, color={0,127,255}));
  connect(eva_HM.p, heaPum.QEva_flow)
    annotation (Line(points={{-12,54.4},{-12,-7},{-25,-7}}, color={0,0,127}));
  connect(fuelCounter.fuel_in, heaPum.P) annotation (Line(points={{-38,48},{-36,
          48},{-36,-16},{-25,-16}}, color={0,0,127}));
  connect(con_HM.p, heaPum.QCon_flow) annotation (Line(points={{-56,52.4},{-52,52.4},
          {-52,-28},{-25,-28},{-25,-25}}, color={0,0,127}));
  connect(switch1.y, heaPum.TSet)
    annotation (Line(points={{0,-39},{-2,-39},{-2,-25}}, color={0,0,127}));
  connect(T_dhw.y, switch1.u1)
    annotation (Line(points={{21,-64},{8,-64},{8,-62}}, color={0,0,127}));
  connect(T_room.y, switch1.u3)
    annotation (Line(points={{-27,-62},{-8,-62}}, color={0,0,127}));
  connect(switch2.y, boundary.T_in)
    annotation (Line(points={{118,-39},{118,-24},{110,-24}}, color={0,0,127}));
  connect(T_dhw_r.y, switch2.u1)
    annotation (Line(points={{89,-62},{110,-62}}, color={0,0,127}));
  connect(T_room_r.y, switch2.u3)
    annotation (Line(points={{143,-62},{126,-62}}, color={0,0,127}));
  connect(dhw_load.y, greaterThreshold.u) annotation (Line(points={{-239,-80},{
          -224,-80},{-224,-86},{-210,-86}}, color={0,0,127}));
  connect(greaterThreshold.y, switch1.u2)
    annotation (Line(points={{-187,-86},{0,-86},{0,-62}}, color={255,0,255}));
  connect(greaterThreshold.y, switch2.u2) annotation (Line(points={{-187,-86},{
          118,-86},{118,-62}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-260,-120},
            {220,60}}),  graphics={
        Rectangle(
          extent={{-260,160},{220,-180}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-154,32},{118,-174}},
          lineColor={0,0,0},
          fillColor={28,108,200},
          fillPattern=FillPattern.HorizontalCylinder),
        Polygon(
          points={{-154,32},{-30,142},{118,32},{-154,32}},
          lineColor={0,0,0},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-102,4},{-56,-50}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-36,-100},{4,-174}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{10,2},{58,-54}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-260,-120},{220,60}})),
    Documentation(revisions="<html>
<ul>
<li><i>August 09, 2018</i> ,by Tobias Blacha:<br/>
Implemented </li>
</ul>
</html>", info="<html>
<p>Substation model for bidirctional low-temperature networks for buildings with heat pump and chiller. In the case of simultaneous cooling and heating demands, the return flows are used as supply flows for the other application. The mass flows are controlled equation-based. The mass flows are calculated using the heating and cooling demands and the specified temperature differences between flow and return (network side).</p>
</html>"));
end PumpControlledwithHP_RE_V;
