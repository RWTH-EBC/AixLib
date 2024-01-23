within AixLib.Fluid.DistrictHeatingCooling.Supplies.ClosedLoop;
model IdealPlantPumpRevHPsingleModel
  "Supply node model with ideal reversible HeatPump and Pump for heat and cold supply of uni-directional networks"

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
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  HeatPumps.Carnot_TCon_Reversible
                                 rev_hea_pum(
    redeclare package Medium2 = Medium,
    redeclare package Medium1 = Medium,
    show_T=true,
    dTEva_nominal=-10,
    dTCon_nominal=10,
    use_eta_Carnot_nominal=true,
    etaCarnot_nominal=0.6,
    QEva_flow_min=-NetworkcoldDemand_max*1.2,
    QCon_flow_max=NetworkheatDemand_max*1.2,
    Q_heating_nominal=NetworkheatDemand_max,
    Q_cooling_nominal=-NetworkcoldDemand_max,
    dp1_nominal=30000,
    dp2_nominal=30000,
    m2_flow_nominal=m_flow_nominal,
    m1_flow_nominal=m_flow_nominal,
    TEva_nominal=283.15)
    annotation (Placement(transformation(extent={{2,-16},{22,4}})));

  AixLib.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
        Medium,
    allowFlowReversal=false,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Blocks.Interfaces.RealInput TIn(unit="K")
    "Minimum supply temperature of the hot line of the bidirectional low-temperature network"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Sources.Boundary_pT bou(redeclare package Medium = Medium,
    use_p_in=false,
    p=200000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,-30})));
  Sensors.TemperatureTwoPort senTemReturn(redeclare package Medium = Medium,
    allowFlowReversal=false,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-88,-10},{-68,10}})));
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
    annotation (Placement(transformation(extent={{-50,10},{-30,-10}})));
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
  Modelica.Blocks.Logical.Less cooling annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-50,50})));
  Modelica.Blocks.Interfaces.RealOutput P_el_tot annotation (Placement(
        transformation(extent={{100,70},{120,90}}), iconTransformation(extent={{
            100,70},{120,90}})));
  Modelica.Blocks.Math.Add p_and_hp(k2=+1) "pump and HP electrical Pwer"
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={70,70})));
  Sources.Boundary_pT              sinkHeating(
    redeclare package Medium = Medium,
    nPorts=1,
    T=288.15)
    annotation (Placement(transformation(extent={{-30,-48},{-10,-28}})));
  Sources.MassFlowSource_T              sourceHeating(
    use_m_flow_in=true,
    redeclare package Medium = Medium,
    nPorts=1,
    use_T_in=true,
    T=288.15) annotation (Placement(transformation(extent={{60,-44},{40,-24}})));
  Modelica.Blocks.Sources.RealExpression MassFlow_HeatSource(y=m_flow_nominal)
    annotation (Placement(transformation(extent={{26,-90},{62,-70}})));
  Modelica.Blocks.Interfaces.RealInput TIn_HP_Source(unit="K")
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
equation
  connect(port_a, senTemReturn.port_a)
    annotation (Line(points={{-100,0},{-88,0}}, color={0,127,255}));
  connect(port_b, senTem.port_b)
    annotation (Line(points={{100,0},{80,0}}, color={0,127,255}));
  connect(dpIn, fan.dp_in)
    annotation (Line(points={{-120,-50},{-40,-50},{-40,-12}},
                                                          color={0,0,127}));
  connect(senTemReturn.port_b, fan.port_a)
    annotation (Line(points={{-68,0},{-50,0}}, color={0,127,255}));
  connect(fan.port_b, rev_hea_pum.port_a1)
    annotation (Line(points={{-30,0},{2,0}}, color={0,127,255}));
  connect(rev_hea_pum.port_b1, senTem.port_a)
    annotation (Line(points={{22,0},{60,0}}, color={0,127,255}));
  connect(TIn, cooling.u1) annotation (Line(points={{-120,80},{-82,80},{-82,50},
          {-62,50}}, color={0,0,127}));
  connect(senTemReturn.T, cooling.u2)
    annotation (Line(points={{-78,11},{-78,42},{-62,42}}, color={0,0,127}));
  connect(cooling.y, rev_hea_pum.is_cooling) annotation (Line(points={{-39,50},
          {-16,50},{-16,-3.8},{1,-3.8}},color={255,0,255}));
  connect(fan.P, p_and_hp.u2) annotation (Line(points={{-29,-9},{-22,-9},{-22,
          76},{58,76}},
                    color={0,0,127}));
  connect(rev_hea_pum.P, p_and_hp.u1) annotation (Line(points={{23,-6},{46,-6},
          {46,64},{58,64}},color={0,0,127}));
  connect(p_and_hp.y, P_el_tot) annotation (Line(points={{81,70},{90,70},{90,80},
          {110,80}}, color={0,0,127}));
  connect(rev_hea_pum.TSet, TIn) annotation (Line(points={{0,3},{-12,3},{-12,80},
          {-120,80}}, color={0,0,127}));
  connect(MassFlow_HeatSource.y, sourceHeating.m_flow_in) annotation (Line(
        points={{63.8,-80},{94,-80},{94,-26},{62,-26}}, color={0,0,127}));
  connect(rev_hea_pum.port_a2, sourceHeating.ports[1]) annotation (Line(points={
          {22,-12},{34,-12},{34,-34},{40,-34}}, color={0,127,255}));
  connect(sinkHeating.ports[1], rev_hea_pum.port_b2) annotation (Line(points={{-10,
          -38},{-6,-38},{-6,-12},{2,-12}}, color={0,127,255}));
  connect(TIn_HP_Source, sourceHeating.T_in) annotation (Line(points={{-120,-80},
          {-60,-80},{-60,-60},{80,-60},{80,-30},{62,-30}}, color={0,0,127}));
  connect(bou.ports[1], fan.port_a)
    annotation (Line(points={{-60,-20},{-60,0},{-50,0}}, color={0,127,255}));
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
          fillPattern=FillPattern.None),
              Ellipse(extent={{-58,60},{60,-60}},
  lineColor = {0, 0, 0}, fillColor = {0, 127, 0},
            fillPattern=FillPattern.Solid),
            Polygon(points={{-30,46},{52,0},{-30,-44},{-30,46}},
            lineColor = {0, 0, 0}, fillColor = {175, 175, 175},
            fillPattern=FillPattern.Solid)}),                    Diagram(
        coordinateSystem(preserveAspectRatio=false)),
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
end IdealPlantPumpRevHPsingleModel;
