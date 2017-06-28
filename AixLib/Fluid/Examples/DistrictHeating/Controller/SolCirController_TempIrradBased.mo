within AixLib.Fluid.Examples.DistrictHeating.Controller;
model SolCirController_TempIrradBased
  "Solar circuit controller based on temperatures and irradiation"
  Modelica.Blocks.Interfaces.RealInput CurrIrradiation annotation (Placement(
        transformation(extent={{-186,34},{-146,74}}), iconTransformation(
          extent={{-174,38},{-144,68}})));
  Modelica.Blocks.Tables.CombiTable1D TurnOnCurve(
    table=[-12,380; 15,180],
    tableOnFile=false,
    columns={2})
    annotation (Placement(transformation(extent={{-128,16},{-108,36}})));
  Modelica.Blocks.Interfaces.RealInput ambTemp
    "Ambient temperature in Celcius" annotation (Placement(transformation(
          extent={{-186,6},{-146,46}}), iconTransformation(extent={{-174,4},{
            -144,34}})));
  Modelica.Blocks.Math.Add add1(
                               k2=-1)
    annotation (Placement(transformation(extent={{-84,22},{-64,42}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(
    uHigh=0,
    uLow=-100,
    pre_y_start=false)
             annotation (Placement(transformation(extent={{-54,24},{-38,40}})));
  Modelica.Blocks.Interfaces.RealInput FlowTempSol
    "Flow temperature of solar collector" annotation (Placement(
        transformation(extent={{-186,-44},{-146,-4}}), iconTransformation(
          extent={{-174,-34},{-144,-4}})));
  Modelica.Blocks.Interfaces.RealInput StgTempBott
    "Temperature at the bottom of the storage" annotation (Placement(
        transformation(extent={{-186,-72},{-146,-32}}), iconTransformation(
          extent={{-174,-70},{-144,-40}})));
  Modelica.Blocks.Math.Add TempDifference(k2=-1)
    annotation (Placement(transformation(extent={{-112,-46},{-92,-26}})));
  Modelica.Blocks.Logical.LogicalSwitch logicalSwitch
    annotation (Placement(transformation(extent={{84,-38},{104,-18}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{108,14},{128,34}})));
  Modelica.Blocks.Sources.Constant MassFlow(k=8)
    "Mass flow when the pump is on"
    annotation (Placement(transformation(extent={{68,52},{88,72}})));
  Modelica.Blocks.Sources.Constant MassFlowInput(k=0)
    "Mass Flow if the pump is off"
    annotation (Placement(transformation(extent={{52,6},{72,26}})));
  Modelica.Blocks.Interfaces.RealOutput MFSolColPump
    annotation (Placement(transformation(extent={{146,-15},{176,15}})));
  Modelica.Blocks.Interfaces.BooleanOutput OnOffSolPump
    annotation (Placement(transformation(extent={{146,40},{176,70}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis1(
    pre_y_start=false,
    uLow=2,
    uHigh=5) annotation (Placement(transformation(extent={{-74,-46},{-56,-27}})));
  Modelica.Blocks.Logical.And and2
    annotation (Placement(transformation(extent={{-6,-38},{14,-18}})));
equation
  connect(TurnOnCurve.u[1], ambTemp)
    annotation (Line(points={{-130,26},{-166,26}}, color={0,0,127}));
  connect(CurrIrradiation, add1.u1) annotation (Line(points={{-166,54},{-96,
          54},{-96,38},{-86,38}}, color={0,0,127}));
  connect(TurnOnCurve.y[1], add1.u2)
    annotation (Line(points={{-107,26},{-86,26}}, color={0,0,127}));
  connect(add1.y, hysteresis.u)
    annotation (Line(points={{-63,32},{-55.6,32}}, color={0,0,127}));
  connect(FlowTempSol, TempDifference.u1) annotation (Line(points={{-166,-24},
          {-126,-24},{-126,-30},{-114,-30}}, color={0,0,127}));
  connect(MFSolColPump, MFSolColPump)
    annotation (Line(points={{161,0},{161,0}}, color={0,0,127}));
  connect(switch1.y, MFSolColPump) annotation (Line(points={{129,24},{140,24},
          {140,0},{161,0}}, color={0,0,127}));
  connect(TempDifference.y, hysteresis1.u) annotation (Line(points={{-91,-36},
          {-75.8,-36},{-75.8,-36.5}}, color={0,0,127}));
  connect(StgTempBott, TempDifference.u2) annotation (Line(points={{-166,-52},
          {-138,-52},{-138,-42},{-114,-42}}, color={0,0,127}));
  connect(hysteresis1.y, and2.u2) annotation (Line(points={{-55.1,-36.5},{-8,
          -36.5},{-8,-36}}, color={255,0,255}));
  connect(hysteresis.y, and2.u1) annotation (Line(points={{-37.2,32},{-24,32},
          {-24,-28},{-8,-28}}, color={255,0,255}));
  connect(and2.y, logicalSwitch.u2)
    annotation (Line(points={{15,-28},{82,-28}}, color={255,0,255}));
  connect(and2.y, logicalSwitch.u1) annotation (Line(points={{15,-28},{28,-28},
          {28,-20},{82,-20}}, color={255,0,255}));
  connect(logicalSwitch.y, switch1.u2) annotation (Line(points={{105,-28},{
          116,-28},{116,4},{88,4},{88,24},{106,24}}, color={255,0,255}));
  connect(MassFlow.y, switch1.u1) annotation (Line(points={{89,62},{96,62},{
          96,32},{106,32}}, color={0,0,127}));
  connect(MassFlowInput.y, switch1.u3)
    annotation (Line(points={{73,16},{106,16}},          color={0,0,127}));
  connect(logicalSwitch.y, OnOffSolPump) annotation (Line(points={{105,-28},{
          134,-28},{134,55},{161,55}}, color={255,0,255}));
  connect(hysteresis1.y, logicalSwitch.u3) annotation (Line(points={{-55.1,
          -36.5},{-40,-36.5},{-40,-48},{54,-48},{54,-36},{82,-36}}, color={
          255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,
            -100},{160,100}}), graphics={Rectangle(
          extent={{-160,100},{160,-100}},
          lineColor={0,0,0},
          fillColor={202,234,243},
          fillPattern=FillPattern.Solid), Text(
          extent={{-58,34},{62,-60}},
          lineColor={0,0,0},
          fillColor={202,234,243},
          fillPattern=FillPattern.Solid,
          textString="Solar circuit 
Controller
")}),                                                            Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-160,-100},{160,
            100}})),
    experiment(StopTime=604800, Interval=5));
end SolCirController_TempIrradBased;
