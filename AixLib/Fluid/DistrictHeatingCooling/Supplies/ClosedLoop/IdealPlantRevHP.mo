within AixLib.Fluid.DistrictHeatingCooling.Supplies.ClosedLoop;
model IdealPlantRevHP
  "Supply node model with reversible water-water heat pump for heat and cold supply for bidirectional networks"

      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium model for water"
      annotation (choicesAllMatching = true);

     Modelica.SIunits.Temperature T_HpIn "Set outlet temperature of heat pump condenser";
     Modelica.SIunits.Temperature T_ChIn "Set outlet temperature of chiller evaporator";

     Modelica.SIunits.MassFlowRate m_flow_heatSource "Mass flow from heat source (heat pump operation)";
     Modelica.SIunits.MassFlowRate m_flow_heatSink "Mass flow from heat sink (chiller)";

     parameter Modelica.SIunits.Pressure dp_nominal(displayUnit="Pa")=30000 "Nominal pressure drop";
     parameter Modelica.SIunits.MassFlowRate m_flow_nominal "Nominal mass flow rate";

     parameter Modelica.SIunits.TemperatureDifference dT_heatSource "Temperature difference of heat source for mass flow calculation (heat pump operation)";
     parameter Modelica.SIunits.TemperatureDifference dT_heatSink "Temperature difference of heat sink for mass flow calculation (chiller operation)";

     parameter Modelica.SIunits.Power Q_flow_nominal_HP "Nominal heating flow rate (Q_flow_nominal_HP > 0)";
     parameter Modelica.SIunits.Power Q_flow_nominal_CH "Nominal cooling flow rate (Q_flow_nominal_CH < 0)";

  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium) "Inlet/Outlet of supply node"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium) "Inlet/Outlet of supply node"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-86,-10},{-66,10}})));
  Modelica.Blocks.Interfaces.RealInput T_coolingSet
    "Maximum outlet temperature, if port_b is outlet (max. outlet temperature of cold line, chiller operation)"
    annotation (Placement(transformation(extent={{-126,60},{-86,100}})));
  Modelica.Blocks.Interfaces.RealInput T_heatingSet "Maximum outlet temperature, if port_b is outlet (min. outlet temperature of hot line, heat pump operation)"
    annotation (Placement(transformation(extent={{-126,22},{-86,62}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{48,-10},{68,10}})));
  AixLib.Fluid.HeatPumps.Carnot_TCon heaPum(redeclare package Medium1 = Medium,
      redeclare package Medium2 = Medium,
    QCon_flow_nominal=Q_flow_nominal_HP,
    dp1_nominal=dp_nominal,
    dp2_nominal=dp_nominal,
    QCon_flow_max=Q_flow_nominal_HP,
    use_eta_Carnot_nominal=true,
    etaCarnot_nominal=0.3)
    annotation (Placement(transformation(extent={{-58,-16},{-38,4}})));
  AixLib.Fluid.Chillers.Carnot_TEva chi(redeclare package Medium1 = Medium,
      redeclare package Medium2 = Medium,
    dp1_nominal=dp_nominal,
    dp2_nominal=dp_nominal,
    QEva_flow_min=Q_flow_nominal_CH,
    QEva_flow_nominal=Q_flow_nominal_CH,
    etaCarnot_nominal=0.3)
    annotation (Placement(transformation(extent={{6,-4},{26,16}})));
  Modelica.Blocks.Sources.RealExpression Input_HP(y=T_HpIn)
    annotation (Placement(transformation(extent={{-78,12},{-58,32}})));
  Modelica.Blocks.Sources.RealExpression Input_CH(y=T_ChIn)
    annotation (Placement(transformation(extent={{-30,10},{-10,30}})));
  AixLib.Fluid.Sources.MassFlowSource_T sourceHeating(
    use_m_flow_in=true,
    redeclare package Medium = Medium,
    nPorts=1,
    use_T_in=true,
    T=288.15) annotation (Placement(transformation(extent={{10,-50},{-10,-30}})));
  AixLib.Fluid.Sources.Boundary_pT sinkHeating(
    redeclare package Medium = Medium,
    nPorts=1,
    T=288.15)
    annotation (Placement(transformation(extent={{-78,-50},{-58,-30}})));
  AixLib.Fluid.Sources.Boundary_pT sinkCooling(
    redeclare package Medium = Medium,
    nPorts=1,
    T=288.15) annotation (Placement(transformation(extent={{56,50},{36,70}})));
  AixLib.Fluid.Sources.MassFlowSource_T sourceCooling(
    use_m_flow_in=true,
    redeclare package Medium = Medium,
    nPorts=1,
    use_T_in=true,
    T=288.15) annotation (Placement(transformation(extent={{-32,50},{-12,70}})));
  Modelica.Blocks.Sources.RealExpression MassFlow_HeatSource(y=
        m_flow_heatSource)
    annotation (Placement(transformation(extent={{46,-36},{26,-16}})));
  Modelica.Blocks.Sources.RealExpression MassFlow_HeatSink(y=m_flow_heatSink)
    annotation (Placement(transformation(extent={{-72,66},{-52,86}})));

protected
  final parameter Medium.ThermodynamicState sta_default = Medium.setState_pTX(
    T=Medium.T_default,
    p=Medium.p_default,
    X=Medium.X_default[1:Medium.nXi]) "Medium state at default properties";
  final parameter Modelica.SIunits.SpecificHeatCapacity cp_default=
    Medium.specificHeatCapacityCp(sta_default)
    "Specific heat capacity of the fluid";

public
  Modelica.Blocks.Interfaces.RealOutput Pel_Hp(
    quantity="Power",
    final unit="W") "Electrical power consumed by reversible heat pump"
    annotation (Placement(transformation(extent={{98,50},{118,70}})));
  Modelica.Blocks.Sources.RealExpression MassFlow_HeatSink1(y=chi.P + heaPum.P)
    annotation (Placement(transformation(extent={{66,50},{86,70}})));
  Modelica.Blocks.Interfaces.RealInput T_inlet_heatSource(
    quantity="Temperature",
    final unit="K") "Inlet temperature of source for heat pump operation"
    annotation (Placement(transformation(extent={{-128,-68},{-88,-28}})));
  Modelica.Blocks.Interfaces.RealInput T_inlet_coldSource(
    quantity="Temperature",
    final unit="K") "Inlet temperature of source for chiller operation"
    annotation (Placement(transformation(extent={{-128,-98},{-88,-58}})));
  Modelica.Blocks.Sources.RealExpression InletTemperature_HeatSource(y=
        T_inlet_heatSource)
    annotation (Placement(transformation(extent={{46,-54},{26,-34}})));
  Modelica.Blocks.Sources.RealExpression InletTemperature_ColdSource(y=
        T_inlet_coldSource)
    annotation (Placement(transformation(extent={{-72,48},{-52,68}})));
  Sources.Boundary_pT bou(redeclare package Medium = Medium, nPorts=1,
    use_T_in=false,
    T=303.15)
    annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={-8,-10})));
  Sensors.TemperatureTwoPort senTem2(redeclare package Medium = Medium,
      m_flow_nominal=2)
    annotation (Placement(transformation(extent={{-34,-6},{-14,14}})));
  Sensors.TemperatureTwoPort senTem3(redeclare package Medium = Medium,
      m_flow_nominal=2)
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
equation

  // Control of the operations mode by flow direction
  // port_a.m_flow >= 0: Heat pump operation
  if (port_a.m_flow >= 0) then
    T_HpIn = T_heatingSet;
    T_ChIn = 110 + 273.15;
    m_flow_heatSink = 0.1;
    m_flow_heatSource = port_a.m_flow;
    //m_flow_HeatSource = (port_a.m_flow * (T_heatingSet - senTem.T))/(cp_default * dT_HeatSource);

  // port_a.m_flow < 0: Chiller operation
  else
    T_ChIn = T_coolingSet;
    T_HpIn = 273.15 - 20;
    m_flow_heatSink = port_b.m_flow;
    //m_flow_HeatSink = (port_b.m_flow * (senTem1.T - T_coolingSet))/(cp_default * dT_HeatSink);
    m_flow_heatSource =0.1;
  end if;

  connect(port_a, senTem.port_a)
    annotation (Line(points={{-100,0},{-86,0}}, color={0,127,255}));
  connect(senTem1.port_b, port_b)
    annotation (Line(points={{68,0},{100,0}}, color={0,127,255}));
  connect(senTem.port_b, heaPum.port_a1)
    annotation (Line(points={{-66,0},{-58,0}}, color={0,127,255}));
  connect(chi.port_a2, senTem1.port_a)
    annotation (Line(points={{26,0},{48,0}}, color={0,127,255}));
  connect(Input_HP.y, heaPum.TSet) annotation (Line(points={{-57,22},{-52,22},{-52,
          3},{-60,3}}, color={0,0,127}));
  connect(Input_CH.y, chi.TSet) annotation (Line(points={{-9,20},{-4,20},{-4,15},
          {4,15}}, color={0,0,127}));
  connect(sinkHeating.ports[1], heaPum.port_b2) annotation (Line(points={{-58,-40},
          {-50,-40},{-50,-12},{-58,-12}}, color={0,127,255}));
  connect(heaPum.port_a2, sourceHeating.ports[1]) annotation (Line(points={{-38,-12},
          {-18,-12},{-18,-40},{-10,-40}},      color={0,127,255}));
  connect(sourceCooling.ports[1], chi.port_a1) annotation (Line(points={{-12,60},
          {-2,60},{-2,12},{6,12}}, color={0,127,255}));
  connect(chi.port_b1, sinkCooling.ports[1]) annotation (Line(points={{26,12},{
          30,12},{30,60},{36,60}}, color={0,127,255}));
  connect(MassFlow_HeatSink.y, sourceCooling.m_flow_in) annotation (Line(points={{-51,76},
          {-44,76},{-44,68},{-34,68}},          color={0,0,127}));
  connect(sourceHeating.m_flow_in, MassFlow_HeatSource.y) annotation (Line(
        points={{12,-32},{20,-32},{20,-26},{25,-26}}, color={0,0,127}));
  connect(MassFlow_HeatSink1.y, Pel_Hp)
    annotation (Line(points={{87,60},{108,60}}, color={0,0,127}));
  connect(sourceHeating.T_in, InletTemperature_HeatSource.y) annotation (Line(
        points={{12,-36},{20,-36},{20,-44},{25,-44}}, color={0,0,127}));
  connect(InletTemperature_ColdSource.y, sourceCooling.T_in) annotation (Line(
        points={{-51,58},{-44,58},{-44,64},{-34,64}}, color={0,0,127}));
  connect(heaPum.port_b1, senTem2.port_a) annotation (Line(points={{-38,0},{-36,
          0},{-36,4},{-34,4}}, color={0,127,255}));
  connect(senTem3.port_b, chi.port_b2) annotation (Line(points={{20,50},{14,50},
          {14,0},{6,0}}, color={0,127,255}));
  connect(senTem2.port_b, senTem3.port_a) annotation (Line(points={{-14,4},{-8,
          4},{-8,50},{0,50}},
                            color={0,127,255}));
  connect(bou.ports[1], senTem3.port_a)
    annotation (Line(points={{-8,-6},{-8,50},{0,50}},  color={0,127,255}));
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
    <i>November 15, 2019</i> ,by Tobias Blacha:<br/>
    Implemented
  </li>
</ul>
</html>", info="<html>
This model represents the supply node of a bidirectional network with a
reversible heat pump for heat and cold supply. The reversible heat pump
was created by combining the heat pump <a href=
\"modelica://AixLib.Fluid.HeatPumps.Carnot_TCon\">AixLib.Fluid.HeatPumps.Carnot_TCon</a>
and the chiller <a href=
\"modelica://AixLib.Fluid.Chillers.Carnot_TEva\">AixLib.Fluid.Chillers.Carnot_TEva</a>
. The operation mode of the reversible heat pump depends on the flow
direction. In the case that port_b is the outlet, heating operation
takes place. In the case that port_a is the outlet, cooling operation
takes place.
</html>"));
end IdealPlantRevHP;
