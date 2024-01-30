within AixLib.Fluid.DistrictHeatingCooling.Supplies.ClosedLoop;
model IdealPlantPumpHPandCC
  "Supply node model with ideal HeatPump and CompressionChiller and Pump for heat and cold supply of uni-directional networks"

      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
      "Medium model for water"
      annotation (choicesAllMatching = true);

      parameter Modelica.SIunits.Pressure dp_nominal(displayUnit="Pa")=30000
      "Nominal pressure drop";

      parameter Modelica.SIunits.MassFlowRate m_flow_nominal
      "Nominal mass flow rate";

      parameter Modelica.SIunits.HeatFlowRate NetworkcoldDemand_max
      "maximum cold demand for scaling of heatpump in cooling mode in Watt";

      parameter Modelica.SIunits.HeatFlowRate NetworkheatDemand_max
      "maximum cold demand for scaling of heatpump in cooling mode in Watt";

  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium)
    "Fluid connector for connecting the ideal plant to the cold line of the network"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium)
    "Fluid connector for connecting the ideal plant to the warm line of the network"
    annotation (Placement(transformation(extent={{130,-10},{150,10}})));

  AixLib.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
        Medium,
    allowFlowReversal=false,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{108,-10},{128,10}})));
  Modelica.Blocks.Interfaces.RealInput TIn(unit="K")
    "Minimum supply temperature of the hot line of the bidirectional low-temperature network"
    annotation (Placement(transformation(extent={{-140,90},{-100,130}})));
  Sources.Boundary_pT bou(redeclare package Medium = Medium,
    use_p_in=false,
    p=200000,                                                nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-64,-34})));
  Sensors.TemperatureTwoPort senTemReturn(redeclare package Medium = Medium,
    allowFlowReversal=false,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Movers.FlowControlled_dp fan(redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    p_start=bou.p,
    allowFlowReversal=false,
    m_flow_nominal=m_flow_nominal,
      addPowerToMedium=false,
    tau=1,
    y_start=1,
    dp_start=fan.dp_nominal,
    dp_nominal=dpPump_nominal)
    annotation (Placement(transformation(extent={{-56,10},{-36,-10}})));
  Modelica.Blocks.Interfaces.RealInput dpIn(unit="Pa")
    "Input of pressure head for the pump"
    annotation (Placement(transformation(extent={{-140,-70},{-100,-30}})));
  parameter Modelica.SIunits.PressureDifference dpPump_nominal=3e5 "Nominal pressure raise, used to normalized the filter if use_inputFilter=true,
        to set default values of constantHead and heads, and
        and for default pressure curve if not specified in record per";

  parameter Modelica.SIunits.Density rho_default=Medium.density_pTX(
      p=Medium.p_default,
      T=Medium.T_default,
      X=Medium.X_default)
    "Default density (e.g., rho_liquidWater = 995, rho_air = 1.2)"
    annotation (Dialog(group="Advanced"));
  Modelica.Blocks.Interfaces.RealOutput P_el_tot annotation (Placement(
        transformation(extent={{140,110},{160,130}}),
                                                    iconTransformation(extent={{140,110},
            {160,130}})));
  Modelica.Blocks.Math.Add3 p_hp_cc(k2=+1) "pump and HP electrical Pwer"
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={124,120})));
  Sources.Boundary_pT              sinkHeating(
    redeclare package Medium = Medium,
    T=288.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-26,-40})));
  Sources.MassFlowSource_T              sourceHeating(
    use_m_flow_in=true,
    redeclare package Medium = Medium,
    use_T_in=true,
    T=288.15,
    nPorts=1) annotation (Placement(transformation(extent={{44,-48},{24,-28}})));
  Modelica.Blocks.Sources.RealExpression MassFlow_HeatSource(y=m_flow_nominal)
    annotation (Placement(transformation(extent={{-34,-90},{2,-70}})));
  Modelica.Blocks.Interfaces.RealInput TIn_HP_Source(unit="K")
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
  HeatPumps.Carnot_TCon              heaPum(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    QCon_flow_nominal=NetworkheatDemand_max,
    dp1_nominal=dp_nominal,
    dp2_nominal=dp_nominal,
    QCon_flow_max=NetworkheatDemand_max,
    use_eta_Carnot_nominal=true,
    etaCarnot_nominal=0.3)
    annotation (Placement(transformation(extent={{-20,-16},{0,4}})));
  Chillers.Carnot_TEva              chi(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    dp1_nominal=dp_nominal,
    dp2_nominal=dp_nominal,
    QEva_flow_min=-NetworkcoldDemand_max,
    QEva_flow_nominal=-NetworkcoldDemand_max,
    etaCarnot_nominal=0.3)
    annotation (Placement(transformation(extent={{70,-4},{90,16}})));
  Sensors.TemperatureTwoPort senTem_mid(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{8,-10},{28,10}})));
  Modelica.Blocks.Logical.Less cooling annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-54,50})));
  Modelica.Blocks.Logical.Switch hp_off
    "wenn HP aus sein soll, ist T supply gleich T return (dT =0, keine Temperaturerhöhung)"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-10,30})));
  Modelica.Blocks.Logical.Switch cc_off
    "wenn CC aus sein soll, ist T supply gleich T return (dT =0, keine Temperaturerhöhung)"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={28,50})));
  Sources.Boundary_pT              sinkHeating1(
    redeclare package Medium = Medium,
    T=288.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={114,54})));
  Sources.MassFlowSource_T              sourceHeating1(
    use_m_flow_in=true,
    redeclare package Medium = Medium,
    use_T_in=true,
    T=288.15,
    nPorts=1) annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={68,52})));
  Modelica.Blocks.Sources.RealExpression MassFlow_HeatSource1(y=m_flow_nominal)
    annotation (Placement(transformation(extent={{138,72},{102,92}})));
equation
  connect(port_a, senTemReturn.port_a)
    annotation (Line(points={{-100,0},{-90,0}}, color={0,127,255}));
  connect(port_b, senTem.port_b)
    annotation (Line(points={{140,0},{128,0}},color={0,127,255}));
  connect(dpIn, fan.dp_in)
    annotation (Line(points={{-120,-50},{-46,-50},{-46,-12}},
                                                          color={0,0,127}));
  connect(senTemReturn.port_b, fan.port_a)
    annotation (Line(points={{-70,0},{-56,0}}, color={0,127,255}));
  connect(bou.ports[1], fan.port_a) annotation (Line(points={{-64,-24},{-64,0},
          {-56,0}},         color={0,127,255}));
  connect(fan.P, p_hp_cc.u2) annotation (Line(points={{-35,-9},{-30,-9},{-30,
          120},{112,120}}, color={0,0,127}));
  connect(p_hp_cc.y, P_el_tot)
    annotation (Line(points={{135,120},{150,120}}, color={0,0,127}));
  connect(MassFlow_HeatSource.y, sourceHeating.m_flow_in) annotation (Line(
        points={{3.8,-80},{70,-80},{70,-30},{46,-30}},  color={0,0,127}));
  connect(TIn_HP_Source, sourceHeating.T_in) annotation (Line(points={{-120,-80},
          {-60,-80},{-60,-60},{60,-60},{60,-34},{46,-34}}, color={0,0,127}));
  connect(chi.port_a2, senTem.port_a)
    annotation (Line(points={{90,0},{108,0}}, color={0,127,255}));
  connect(heaPum.port_b1, senTem_mid.port_a)
    annotation (Line(points={{0,0},{8,0}}, color={0,127,255}));
  connect(senTem_mid.port_b, chi.port_b2)
    annotation (Line(points={{28,0},{70,0}}, color={0,127,255}));
  connect(heaPum.port_a1, fan.port_b)
    annotation (Line(points={{-20,0},{-36,0}}, color={0,127,255}));
  connect(sourceHeating.ports[1], heaPum.port_a2) annotation (Line(points={{24,
          -38},{8,-38},{8,-12},{0,-12}}, color={0,127,255}));
  connect(sinkHeating.ports[1], heaPum.port_b2) annotation (Line(points={{-26,
          -30},{-26,-12},{-20,-12}}, color={0,127,255}));
  connect(TIn, cooling.u1) annotation (Line(points={{-120,110},{-92,110},{-92,
          50},{-66,50}}, color={0,0,127}));
  connect(senTemReturn.T, cooling.u2)
    annotation (Line(points={{-80,11},{-80,42},{-66,42}}, color={0,0,127}));
  connect(cooling.y, hp_off.u2) annotation (Line(points={{-43,50},{-32,50},{-32,
          30},{-22,30}}, color={255,0,255}));
  connect(senTemReturn.T, hp_off.u1)
    annotation (Line(points={{-80,11},{-80,38},{-22,38}}, color={0,0,127}));
  connect(hp_off.y, heaPum.TSet) annotation (Line(points={{1,30},{6,30},{6,16},
          {-28,16},{-28,3},{-22,3}}, color={0,0,127}));
  connect(TIn, hp_off.u3) annotation (Line(points={{-120,110},{-92,110},{-92,22},
          {-22,22}}, color={0,0,127}));
  connect(cc_off.y, chi.TSet) annotation (Line(points={{39,50},{44,50},{44,34},
          {28,34},{28,15},{68,15}}, color={0,0,127}));
  connect(cooling.y, cc_off.u2)
    annotation (Line(points={{-43,50},{16,50}}, color={255,0,255}));
  connect(TIn, cc_off.u1) annotation (Line(points={{-120,110},{10,110},{10,58},
          {16,58}}, color={0,0,127}));
  connect(senTem_mid.T, cc_off.u3) annotation (Line(points={{18,11},{18,22},{10,
          22},{10,42},{16,42}}, color={0,0,127}));
  connect(port_b, port_b)
    annotation (Line(points={{140,0},{140,0}}, color={0,127,255}));
  connect(heaPum.P, p_hp_cc.u3) annotation (Line(points={{1,-6},{4,-6},{4,128},
          {112,128}}, color={0,0,127}));
  connect(chi.P, p_hp_cc.u1) annotation (Line(points={{91,6},{96,6},{96,112},{
          112,112}}, color={0,0,127}));
  connect(sourceHeating1.ports[1], chi.port_a1)
    annotation (Line(points={{68,42},{68,12},{70,12}}, color={0,127,255}));
  connect(sinkHeating1.ports[1], chi.port_b1)
    annotation (Line(points={{114,44},{114,12},{90,12}}, color={0,127,255}));
  connect(MassFlow_HeatSource1.y, sourceHeating1.m_flow_in)
    annotation (Line(points={{100.2,82},{60,82},{60,64}}, color={0,0,127}));
  connect(TIn_HP_Source, sourceHeating1.T_in) annotation (Line(points={{-120,
          -80},{-60,-80},{-60,-60},{100,-60},{100,72},{64,72},{64,64}}, color={
          0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{140,140}}),                                  graphics={
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
          fillPattern=FillPattern.None),
              Ellipse(extent={{-58,60},{60,-60}},
  lineColor = {0, 0, 0}, fillColor = {0, 127, 0},
            fillPattern=FillPattern.Solid),
            Polygon(points={{-30,46},{52,0},{-30,-44},{-30,46}},
            lineColor = {0, 0, 0}, fillColor = {175, 175, 175},
            fillPattern=FillPattern.Solid)}),                    Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{140,
            140}})),
    Documentation(revisions="<html><ul>
  <li>
    <i>November 23, 2019</i> ,by Michael Mans:<br/>
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
end IdealPlantPumpHPandCC;
