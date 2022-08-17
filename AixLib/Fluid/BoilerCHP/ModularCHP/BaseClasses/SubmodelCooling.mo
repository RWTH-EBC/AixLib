within AixLib.Fluid.BoilerCHP.ModularCHP.BaseClasses;
model SubmodelCooling

  replaceable package Medium_Coolant =
      DataBase.CHP.ModularCHPEngineMedia.CHPCoolantPropyleneGlycolWater (
                                 property_T=356, X_a=0.50) constrainedby
    Modelica.Media.Interfaces.PartialMedium
    "Coolant medium model used in the CHP plant" annotation (choicesAllMatching=true);
  parameter
    DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord
    CHPEngineModel=DataBase.CHP.ModularCHPEngineData.CHP_ECPowerXRGI15()
    "CHP engine data for calculations"
    annotation (choicesAllMatching=true, Dialog(group="Unit properties"));
  parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate m_flow=
      CHPEngineModel.m_floCooNominal
    "Nominal mass flow rate of coolant inside the engine cooling circle" annotation (Dialog(tab="Engine Cooling Circle"));
  parameter Modelica.Units.SI.ThermalConductance GEngToCoo=45
    "Thermal conductance of engine housing from the cylinder wall to the water cooling channels"
    annotation (Dialog(tab="Engine Cooling Circle", group=
          "Calibration Parameters"));
  parameter Boolean allowFlowReversalCoolant=true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal for coolant medium"
    annotation (Dialog(tab="Advanced", group="Assumptions"));
  parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
    mCool_flow_small=0.0001
    "Small coolant mass flow rate for regularization of zero flow"
    annotation (Dialog(tab="Advanced", group="Assumptions"));

  outer Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-100,-100},{-84,-84}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_outside
    "Heat port to engine"
    annotation (Placement(transformation(rotation=0, extent={{-10,-70},{10,-50}}),
        iconTransformation(extent={{-12,-66},{12,-42}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium_Coolant)
    "Fluid port for the return flow side of the cooling circuit model"
                        annotation (Placement(transformation(rotation=0, extent=
           {{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium_Coolant)
    "Fluid port for the supply flow side of the cooling circuit model"
                        annotation (Placement(transformation(rotation=0, extent=
           {{90,-10},{110,10}})));
  AixLib.Controls.Interfaces.CHPControlBus sigBus_coo
    "Signal bus of the cooling circuit components"    annotation (Placement(
        transformation(extent={{-28,26},{28,80}}), iconTransformation(extent=
            {{-28,26},{30,82}})));
  Movers.FlowControlled_m_flow                coolantPump(
    m_flow_small=mCool_flow_small,
    redeclare package Medium = Medium_Coolant,
    dp_nominal=CHPEngineModel.dp_Coo,
    allowFlowReversal=allowFlowReversalCoolant,
    addPowerToMedium=false,
    m_flow_nominal=m_flow,
    use_inputFilter=false) "Model of a fluid pump or fan"
    annotation (Placement(transformation(extent={{-30,-12},{-10,12}})));
  AixLib.Utilities.Logical.SmoothSwitch switch1 annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-30,34})));
  Modelica.Blocks.Sources.RealExpression massFlowPump(y=m_flow)
    annotation (Placement(transformation(extent={{-66,32},{-46,52}})));
  Modelica.Blocks.Sources.RealExpression minMassFlowPump(y=mCool_flow_small)
    annotation (Placement(transformation(extent={{-66,14},{-46,34}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort senTCooEngIn(
    redeclare package Medium = Medium_Coolant,
    allowFlowReversal=allowFlowReversalCoolant,
    m_flow_nominal=m_flow,
    m_flow_small=mCool_flow_small) "Temperature sensor of engine cooling inlet"
                                   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-60,0})));
  FixedResistances.Pipe engineHeatTransfer(
    redeclare package Medium = Medium_Coolant,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=CHPEngineModel.dp_Coo, m_flow_nominal=m_flow),
    Heat_Loss_To_Ambient=true,
    eps=0,
    isEmbedded=true,
    use_HeatTransferConvective=false,
    p_a_start=system.p_start,
    p_b_start=system.p_start,
    hCon_i=GEngToCoo/(engineHeatTransfer.perimeter*engineHeatTransfer.length),
    diameter=CHPEngineModel.dCoo,
    allowFlowReversal=allowFlowReversalCoolant)
    annotation (Placement(transformation(extent={{8,12},{32,-12}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort senTCooEngOut(
    redeclare package Medium = Medium_Coolant,
    allowFlowReversal=allowFlowReversalCoolant,
    m_flow_nominal=m_flow,
    m_flow_small=mCool_flow_small)
    "Temperature sensor of engine cooling outlet"
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));

equation
  connect(engineHeatTransfer.port_b, senTCooEngOut.port_a)
    annotation (Line(points={{32,0},{50,0}},        color={0,127,255}));
  connect(heatPort_outside, engineHeatTransfer.heatPort_outside) annotation (
      Line(points={{0,-60},{21.92,-60},{21.92,-6.72}},          color={191,0,0}));
  connect(port_a, senTCooEngIn.port_a)
    annotation (Line(points={{-100,0},{-70,0}}, color={0,127,255}));
  connect(port_b, senTCooEngOut.port_b)
    annotation (Line(points={{100,0},{70,0}}, color={0,127,255}));
  connect(senTCooEngIn.port_b, coolantPump.port_a)
    annotation (Line(points={{-50,0},{-30,0}}, color={0,127,255}));
  connect(engineHeatTransfer.port_a, coolantPump.port_b)
    annotation (Line(points={{8,0},{-10,0}},    color={0,127,255}));
  connect(switch1.y, coolantPump.m_flow_in) annotation (Line(points={{-23.4,
          34},{-20,34},{-20,14.4}}, color={0,0,127}));
  connect(sigBus_coo.isOnPump, switch1.u2) annotation (Line(
      points={{0.14,53.135},{-72,53.135},{-72,34},{-37.2,34}},
      color={255,204,51},
      thickness=0.5));
  connect(massFlowPump.y, switch1.u1) annotation (Line(points={{-45,42},{-42,42},
          {-42,38.8},{-37.2,38.8}},     color={0,0,127}));
  connect(minMassFlowPump.y, switch1.u3) annotation (Line(points={{-45,24},{-42,
          24},{-42,29.2},{-37.2,29.2}},     color={0,0,127}));
  connect(senTCooEngIn.T, sigBus_coo.meaTemInEng) annotation (Line(points={{-60,
          11},{-60,16},{-82,16},{-82,53.135},{0.14,53.135}}, color={0,0,127}));
  connect(senTCooEngOut.T, sigBus_coo.meaTemOutEng) annotation (Line(points={{
          60,11},{60,53.135},{0.14,53.135}}, color={0,0,127}));
  annotation (Icon(graphics={    Text(
          extent={{-151,113},{149,73}},
          lineColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255},
          textString="%name"),
        Line(
          points={{-60,32},{60,32},{60,32},{60,-32},{-60,-32},{-60,32}},
          color={0,127,255},
          thickness=0.5),
        Line(
          points={{60,-10},{60,14}},
          color={0,127,255},
          arrow={Arrow.Open,Arrow.None},
          thickness=0.5),
        Line(
          points={{0,7},{0,-15}},
          color={0,127,255},
          arrow={Arrow.Open,Arrow.None},
          origin={-60,3},
          rotation=360,
          thickness=0.5),
        Line(
          points={{0,7},{0,-15}},
          color={0,127,255},
          arrow={Arrow.Open,Arrow.None},
          origin={-4,-31},
          rotation=90,
          thickness=0.5),
        Line(
          points={{7,0},{-15,0}},
          color={0,127,255},
          arrow={Arrow.Open,Arrow.None},
          origin={4,31},
          rotation=360,
          thickness=0.5),
        Text(
          extent={{-40,20},{40,-20}},
          lineColor={238,46,47},
          lineThickness=0.5,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,0,0},
          textString="dQ = 0")}),Documentation(info="<html><p>
  Model of important cooling circuit components that needs to be used
  with the engine model to realise its heat transfer.
</p>
<p>
  Therefore a heat port is implemented as well as temperature sensors
  to capture the in- and outlet temperatures of the coolant medium for
  engine calculations.
</p>
<p>
  Depending on the unit configuration this model can be placed inside
  the cooling circuit before or after the fluid ports of the exhaust
  heat exchanger.
</p>
<h4>
  Assumptions:
</h4>
<p>
  The pressure level within the cooling circuit is assumed to be
  constant at about 3 bar.
</p>
<ul>
  <li>
    <i>April, 2019&#160;</i> by Julian Matthes:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/667\">#667</a>)
  </li>
</ul>
</html>"));
end SubmodelCooling;
