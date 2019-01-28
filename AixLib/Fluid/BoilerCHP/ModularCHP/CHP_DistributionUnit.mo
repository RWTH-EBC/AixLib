within AixLib.Fluid.BoilerCHP.ModularCHP;
model CHP_DistributionUnit
  "Distribution unit model for CHP power units with heat storage and heating supply and return connection"


  replaceable package Medium_Heating =
      Modelica.Media.Water.ConstantPropertyLiquidWater          constrainedby
    Modelica.Media.Interfaces.PartialMedium annotation (
      __Dymola_choicesAllMatching=true);
  replaceable package Medium_Coolant =
      DataBase.CHP.ModularCHPEngineMedia.CHPCoolantPropyleneGlycolWater (
                                      property_T=356, X_a=0.50) constrainedby
    Modelica.Media.Interfaces.PartialMedium annotation (
      __Dymola_choicesAllMatching=true);

  parameter
    AixLib.DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord
    CHPEngineModel=DataBase.CHP.ModularCHPEngineData.CHP_ECPowerXRGI15()
    "CHP engine data for calculations"
    annotation (choicesAllMatching=true, Dialog(group="Unit properties"));
  parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate m_flowCoo=2
    "Nominal mass flow rate of coolant inside the engine cooling circle" annotation (Dialog(tab=
          "Engine Cooling Circle"));
  parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate m_flowHeaCir=
      CHPEngineModel.m_floCooNominal
    "Nominal mass flow rate inside the heating circuit" annotation (Dialog(tab="Engine Cooling Circle"));




  HeatExchangers.ConstantEffectiveness hex_DistributionUnit(
    redeclare package Medium1 = Medium_Heating,
    redeclare package Medium2 = Medium_Coolant,
    eps=0.9)
           annotation (Placement(transformation(
        extent={{-15,-16},{15,16}},
        rotation=90,
        origin={10,-35})));
  Actuators.Valves.ThreeWayLinear val(redeclare package Medium = Medium_Heating)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-50,80})));
  Movers.FlowControlled_m_flow fan(redeclare package Medium = Medium_Heating)
    annotation (Placement(transformation(extent={{-10,70},{-30,90}})));
  Modelica.Fluid.Sources.FixedBoundary boundary_HeatingCircuit(redeclare
      package Medium = Medium_Heating, nPorts=1)
    annotation (Placement(transformation(extent={{40,70},{20,90}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_PowerUnitSupply(redeclare package
      Medium = Medium_Coolant)
    annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_PowerUnitReturn(redeclare package
      Medium = Medium_Coolant)
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
  Movers.FlowControlled_m_flow pump_PrimaryCircuit(redeclare package Medium =
        Medium_Coolant) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={50,-10})));
  Modelica.Fluid.Sources.FixedBoundary boundary_PrimaryCircuit(nPorts=1,
      redeclare package Medium = Medium_Coolant) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,-80})));

  Actuators.Valves.ThreeWayLinear val1(redeclare package Medium =
        Medium_Heating)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,-10})));
  Movers.FlowControlled_m_flow pump_SecondaryCircuit(redeclare package Medium =
        Medium_Heating) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-50,-40})));
  Modelica.Fluid.Interfaces.FluidPort_b port_HeatingReturn(redeclare package
      Medium = Medium_Heating)
    annotation (Placement(transformation(extent={{-110,0},{-90,20}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_HeatingSupply(redeclare package
      Medium = Medium_Heating)
    annotation (Placement(transformation(extent={{-110,70},{-90,90}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_StorageHot(redeclare package
      Medium = Medium_Heating)
    annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
  Modelica.Fluid.Sources.FixedBoundary boundary_SecondaryCircuit(nPorts=1,
      redeclare package Medium = Medium_Heating) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,-80})));
  inner Modelica.Fluid.System system(p_ambient=101325, T_ambient=301.15)
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal teeJunction1(redeclare package
      Medium = Medium_Heating) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={0,40})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal teeJunction2(redeclare package
      Medium = Medium_Heating) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={0,60})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal teeJunction3(redeclare package
      Medium = Medium_Heating) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={0,-10})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempSupplyFlow(
    m_flow_small=mCool_flow_small,
    m_flow_nominal=CHPEngineModel.m_floCooNominal,
    redeclare package Medium = Medium_Heating)
    annotation (Placement(transformation(extent={{-74,74},{-86,86}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempSupplyFlow1(
    m_flow_small=mCool_flow_small,
    m_flow_nominal=CHPEngineModel.m_floCooNominal,
    redeclare package Medium = Medium_Heating)
    annotation (Placement(transformation(extent={{-86,4},{-74,16}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort tempStorageSupply(
    m_flow_small=mCool_flow_small,
    m_flow_nominal=CHPEngineModel.m_floCooNominal,
    redeclare package Medium = Medium_Heating)
    annotation (Placement(transformation(extent={{-74,34},{-86,46}})));
  FixedResistances.Pipe pipe
    annotation (Placement(transformation(extent={{-30,30},{-50,50}})));
equation
  connect(port_PowerUnitSupply, pump_PrimaryCircuit.port_a) annotation (Line(
        points={{100,-40},{80,-40},{80,-10},{60,-10}}, color={0,127,255}));
  connect(pump_PrimaryCircuit.port_b, hex_DistributionUnit.port_a2) annotation (
     Line(points={{40,-10},{19.6,-10},{19.6,-20}}, color={0,127,255}));
  connect(hex_DistributionUnit.port_b2, port_PowerUnitReturn) annotation (Line(
        points={{19.6,-50},{20,-50},{20,-60},{100,-60}}, color={0,127,255}));
  connect(boundary_PrimaryCircuit.ports[1], port_PowerUnitReturn)
    annotation (Line(points={{60,-70},{60,-60},{100,-60}}, color={0,127,255}));
  connect(val1.port_1, pump_SecondaryCircuit.port_a)
    annotation (Line(points={{-50,-20},{-50,-30}}, color={0,127,255}));
  connect(pump_SecondaryCircuit.port_b, hex_DistributionUnit.port_a1)
    annotation (Line(points={{-50,-50},{-50,-60},{0.4,-60},{0.4,-50}}, color={0,
          127,255}));
  connect(fan.port_b, val.port_2)
    annotation (Line(points={{-30,80},{-40,80}}, color={0,127,255}));
  connect(boundary_SecondaryCircuit.ports[1], hex_DistributionUnit.port_a1)
    annotation (Line(points={{-20,-70},{-20,-60},{0.4,-60},{0.4,-50}}, color={0,
          127,255}));
  connect(val.port_3, teeJunction2.port_3)
    annotation (Line(points={{-50,70},{-50,60},{-6,60}}, color={0,127,255}));
  connect(teeJunction2.port_1, teeJunction1.port_2)
    annotation (Line(points={{0,54},{0,46}}, color={0,127,255}));
  connect(teeJunction2.port_2, fan.port_a)
    annotation (Line(points={{0,66},{0,80},{-10,80}}, color={0,127,255}));
  connect(val1.port_3, teeJunction3.port_3)
    annotation (Line(points={{-40,-10},{-6,-10}}, color={0,127,255}));
  connect(teeJunction3.port_1, hex_DistributionUnit.port_b1) annotation (Line(
        points={{0,-16},{0,-18},{0,-20},{0.4,-20}}, color={0,127,255}));
  connect(teeJunction3.port_2, teeJunction1.port_1)
    annotation (Line(points={{0,-4},{0,34}}, color={0,127,255}));
  connect(boundary_HeatingCircuit.ports[1], fan.port_a)
    annotation (Line(points={{20,80},{-10,80}}, color={0,127,255}));
  connect(val.port_1, tempSupplyFlow.port_a)
    annotation (Line(points={{-60,80},{-74,80}}, color={0,127,255}));
  connect(tempSupplyFlow.port_b, port_HeatingSupply)
    annotation (Line(points={{-86,80},{-100,80}}, color={0,127,255}));
  connect(tempStorageSupply.port_b, port_StorageHot)
    annotation (Line(points={{-86,40},{-100,40}}, color={0,127,255}));
  connect(port_HeatingReturn, tempSupplyFlow1.port_a)
    annotation (Line(points={{-100,10},{-86,10}}, color={0,127,255}));
  connect(tempSupplyFlow1.port_b, val1.port_2)
    annotation (Line(points={{-74,10},{-50,10},{-50,0}}, color={0,127,255}));
  connect(teeJunction1.port_3, pipe.port_a)
    annotation (Line(points={{-6,40},{-29.6,40}}, color={0,127,255}));
  connect(pipe.port_b, tempStorageSupply.port_a)
    annotation (Line(points={{-50.4,40},{-74,40}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CHP_DistributionUnit;
