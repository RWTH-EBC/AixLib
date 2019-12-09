within AixLib.Systems.EONERC_MainBuilding.Controller.EonERCModeControl;
model CtrHP "Heatpump Controller"
  Modelica.Blocks.Logical.GreaterThreshold thresholdON
    annotation (Placement(transformation(extent={{76,30},{96,50}})));
  Modelica.Blocks.Sources.Constant THPColdSet(k=T_ev_set)
    annotation (Placement(transformation(extent={{-98,-36},{-86,-24}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=273.15 + 7, uHigh=273.15
         + 11) annotation (Placement(transformation(extent={{-52,-66},{-40,-54}})));
  Modelica.Blocks.Logical.Switch switchSecurity
    annotation (Placement(transformation(extent={{46,-10},{66,10}})));
  Controls.Continuous.LimPID PIDcooling(
    final yMax=1,
    final yMin=0,
    final controllerType=Modelica.Blocks.Types.SimpleController.PI,
    final k=0.1,
    final Ti=60,
    final Td=0,
    initType=Modelica.Blocks.Types.InitPID.NoInit,
    final reverseAction=true,
    reset=AixLib.Types.Reset.Disabled)
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  Modelica.Blocks.Logical.Switch modeHeating
    annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  Modelica.Blocks.Logical.Switch switchCooling
    annotation (Placement(transformation(extent={{-30,-40},{-20,-30}})));
  Modelica.Blocks.Sources.Constant zero1(k=0)
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},
        rotation=180,
        origin={36,8})));
  Modelica.Blocks.Logical.Hysteresis       hysteresis3(uLow=5 + 273.15, uHigh=8
         + 273.15)
    annotation (Placement(transformation(extent={{-26,18},{-16,28}})));
  Modelica.Blocks.Logical.Or or2 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={10,30})));
  Modelica.Blocks.Logical.Hysteresis       hysteresis2(uLow=40 + 273.15, uHigh=
        45 + 273.15)
    annotation (Placement(transformation(extent={{-26,36},{-16,46}})));
  Modelica.Blocks.Sources.Constant zero2(k=0)
    annotation (Placement(transformation(extent={{3,-3},{-3,3}},
        rotation=0,
        origin={-25,-47})));
  Modelica.Blocks.Sources.Constant THPHotSet1(k=T_con_set)
    annotation (Placement(transformation(extent={{-98,4},{-86,16}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis1(uLow=273.15 + 30, uHigh=273.15
         + 35) annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-58,80})));
  Controls.Continuous.LimPID PIDheating(
    final yMax=1,
    final yMin=0,
    final controllerType=Modelica.Blocks.Types.SimpleController.PI,
    final k=0.1,
    final Ti=60,
    final Td=0,
    initType=Modelica.Blocks.Types.InitPID.NoInit,
    final reverseAction=false,
    reset=AixLib.Types.Reset.Disabled)
    annotation (Placement(transformation(extent={{-80,20},{-60,0}})));
  Modelica.Blocks.Logical.Switch switchCooling1
    annotation (Placement(transformation(extent={{-46,8},{-36,18}})));
  Modelica.Blocks.Sources.Constant zero3(k=0)
    annotation (Placement(transformation(extent={{3,-3},{-3,3}},
        rotation=0,
        origin={-45,27})));
  Modelica.Blocks.Interfaces.BooleanOutput On
                                    "Connector of Boolean output signal"
    annotation (Placement(transformation(extent={{100,30},{120,50}}),
        iconTransformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.RealOutput N_rel "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}}),
        iconTransformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput T_HS annotation (Placement(
        transformation(extent={{-140,60},{-100,100}}), iconTransformation(
          extent={{-136,82},{-100,118}})));
  Modelica.Blocks.Interfaces.RealInput T_CS annotation (Placement(
        transformation(extent={{-140,-100},{-100,-60}}), iconTransformation(
          extent={{-134,-68},{-100,-34}})));
  Modelica.Blocks.Interfaces.RealInput T_ev
    "Connector of measurement input signal" annotation (Placement(
        transformation(extent={{-140,-60},{-100,-20}}), iconTransformation(
          extent={{-136,-118},{-100,-82}})));
  Modelica.Blocks.Interfaces.RealInput T_con
    "Connector of measurement input signal" annotation (Placement(
        transformation(extent={{-140,20},{-100,60}}), iconTransformation(extent
          ={{-136,32},{-100,68}})));
  Modelica.Blocks.Interfaces.BooleanInput heatingModeActive
    "Connector of Boolean input signal" annotation (Placement(transformation(
          extent={{-140,-20},{-100,20}}), iconTransformation(extent={{-136,-18},
            {-100,18}})));
  parameter Real T_con_set=273.15 + 35 "Set temperature for heating mode";
  parameter Real T_ev_set=273.15 + 12 "Set point temperature for cooling mode";
  Modelica.Blocks.Interfaces.BooleanInput allowOperation
    "Connector of first Boolean input signal" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,118}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{0,60},{20,80}})));
  Modelica.Blocks.Logical.Or or1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={40,38})));
  Modelica.Blocks.Logical.Not not2
    annotation (Placement(transformation(extent={{-12,20},{-6,26}})));
equation
  connect(THPColdSet.y, PIDcooling.u_s)
    annotation (Line(points={{-85.4,-30},{-82,-30}}, color={0,0,127}));
  connect(switchSecurity.y, thresholdON.u)
    annotation (Line(points={{67,0},{70,0},{70,40},{74,40}}, color={0,0,127}));
  connect(hysteresis2.y, or2.u1) annotation (Line(points={{-15.5,41},{-8,41},{
          -8,30},{-2,30}}, color={255,0,255}));
  connect(PIDcooling.y, switchCooling.u1) annotation (Line(points={{-59,-30},{
          -54,-30},{-54,-31},{-31,-31}}, color={0,0,127}));
  connect(hysteresis.y, switchCooling.u2) annotation (Line(points={{-39.4,-60},
          {-39.4,-35},{-31,-35}}, color={255,0,255}));
  connect(zero2.y, switchCooling.u3) annotation (Line(points={{-28.3,-47},{-34,
          -47},{-34,-39},{-31,-39}}, color={0,0,127}));
  connect(switchCooling.y, modeHeating.u3) annotation (Line(points={{-19.5,-35},
          {-19.5,-18},{-2,-18}}, color={0,0,127}));
  connect(THPHotSet1.y, PIDheating.u_s)
    annotation (Line(points={{-85.4,10},{-82,10}}, color={0,0,127}));
  connect(hysteresis1.y, switchCooling1.u2) annotation (Line(points={{-51.4,80},
          {-51.4,13},{-47,13}}, color={255,0,255}));
  connect(switchCooling1.y, modeHeating.u1) annotation (Line(points={{-35.5,13},
          {-10,13},{-10,-2},{-2,-2}}, color={0,0,127}));
  connect(PIDheating.y, switchCooling1.u3)
    annotation (Line(points={{-59,10},{-47,10},{-47,9}}, color={0,0,127}));
  connect(zero3.y, switchCooling1.u1) annotation (Line(points={{-48.3,27},{-48,
          27},{-48,17},{-47,17}}, color={0,0,127}));
  connect(zero1.y, switchSecurity.u1)
    annotation (Line(points={{40.4,8},{44,8}}, color={0,0,127}));
  connect(modeHeating.y, switchSecurity.u3) annotation (Line(points={{21,-10},{
          26,-10},{26,-8},{44,-8}}, color={0,0,127}));
  connect(thresholdON.y, On)
    annotation (Line(points={{97,40},{110,40}}, color={255,0,255}));
  connect(switchSecurity.y, N_rel)
    annotation (Line(points={{67,0},{110,0}}, color={0,0,127}));
  connect(hysteresis1.u, T_HS)
    annotation (Line(points={{-65.2,80},{-120,80}}, color={0,0,127}));
  connect(PIDcooling.u_m, T_ev) annotation (Line(points={{-70,-42},{-92,-42},{
          -92,-40},{-120,-40}}, color={0,0,127}));
  connect(PIDheating.u_m, T_con)
    annotation (Line(points={{-70,22},{-70,40},{-120,40}}, color={0,0,127}));
  connect(hysteresis.u, T_CS) annotation (Line(points={{-53.2,-60},{-86,-60},{
          -86,-80},{-120,-80}}, color={0,0,127}));
  connect(modeHeating.u2, heatingModeActive) annotation (Line(points={{-2,-10},
          {-102,-10},{-102,0},{-120,0}}, color={255,0,255}));
  connect(allowOperation, not1.u)
    annotation (Line(points={{0,118},{-2,118},{-2,70}}, color={255,0,255}));
  connect(or2.y, or1.u2)
    annotation (Line(points={{21,30},{28,30}}, color={255,0,255}));
  connect(or1.u1, not1.y)
    annotation (Line(points={{28,38},{28,70},{21,70}}, color={255,0,255}));
  connect(or1.y, switchSecurity.u2) annotation (Line(points={{51,38},{54,38},{
          54,20},{24,20},{24,0},{44,0}}, color={255,0,255}));
  connect(hysteresis1.u, hysteresis2.u) annotation (Line(points={{-65.2,80},{
          -64,80},{-64,41},{-27,41}}, color={0,0,127}));
  connect(hysteresis3.u, hysteresis.u) annotation (Line(points={{-27,23},{-32,
          23},{-32,-20},{-53.2,-20},{-53.2,-60}}, color={0,0,127}));
  connect(hysteresis3.y, not2.u)
    annotation (Line(points={{-15.5,23},{-12.6,23}}, color={255,0,255}));
  connect(not2.y, or2.u2) annotation (Line(points={{-5.7,23},{-3.85,23},{-3.85,
          22},{-2,22}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CtrHP;
