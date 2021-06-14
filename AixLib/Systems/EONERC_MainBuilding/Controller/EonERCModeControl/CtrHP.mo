within AixLib.Systems.EONERC_MainBuilding.Controller.EonERCModeControl;
model CtrHP "Heatpump Controller"
  Modelica.Blocks.Sources.Constant THPColdSet(k=T_ev_set)
    annotation (Placement(transformation(extent={{-98,-36},{-86,-24}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=273.15 + 12, uHigh=273.15
         + 14) annotation (Placement(transformation(extent={{-52,-66},{-40,-54}})));
  Modelica.Blocks.Logical.Switch operating
    annotation (Placement(transformation(extent={{70,-10},{90,10}})));
  Controls.Continuous.LimPID PIDcooling(
    final yMax=N_rel_max,
    final yMin=N_rel_min,
    final controllerType=Modelica.Blocks.Types.SimpleController.PI,
    final k=0.2,
    final Ti=600,
    final Td=0,
    initType=Modelica.Blocks.Types.InitPID.NoInit,
    reset=AixLib.Types.Reset.Parameter,
    y_reset=N_rel_min,
    reverseActing=not (true))
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  Modelica.Blocks.Logical.Switch modeHeating
    annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
  Modelica.Blocks.Sources.Constant zero1(k=0)
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},
        rotation=0,
        origin={70,-18})));
  Modelica.Blocks.Logical.Hysteresis       hysteresis3(uLow=5 + 273.15, uHigh=7
         + 273.15)
    annotation (Placement(transformation(extent={{-26,18},{-16,28}})));
  Modelica.Blocks.Logical.Or or2 annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=0,
        origin={8,28})));
  Modelica.Blocks.Logical.Hysteresis       hysteresis2(uLow=40 + 273.15, uHigh=
        45 + 273.15)
    annotation (Placement(transformation(extent={{-26,36},{-16,46}})));
  Modelica.Blocks.Sources.Constant THPHotSet1(k=T_con_set)
    annotation (Placement(transformation(extent={{-98,4},{-86,16}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis1(uLow=273.15 + 30, uHigh=273.15
         + 35) annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-58,80})));
  Controls.Continuous.LimPID PIDheating(
    final yMax=N_rel_max,
    final yMin=N_rel_min,
    final controllerType=Modelica.Blocks.Types.SimpleController.PI,
    final k=0.2,
    final Ti=600,
    final Td=0,
    initType=Modelica.Blocks.Types.InitPID.NoInit,
    reset=AixLib.Types.Reset.Parameter,
    y_reset=N_rel_min,
    reverseActing=not (false))
    annotation (Placement(transformation(extent={{-80,20},{-60,0}})));
  Modelica.Blocks.Interfaces.BooleanOutput On
                                    "Connector of Boolean output signal"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}}),
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
        transformation(extent={{-140,20},{-100,60}}), iconTransformation(extent=
           {{-136,32},{-100,68}})));
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
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        rotation=270,
        origin={4.44089e-16,72})));
  Modelica.Blocks.Logical.Or securityOn annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=0,
        origin={27,41})));
  Modelica.Blocks.Logical.Not not2
    annotation (Placement(transformation(extent={{-12,20},{-6,26}})));
  Modelica.Blocks.Interfaces.BooleanOutput pumpsOn
    "Connector of Boolean output signal" annotation (Placement(transformation(
          extent={{100,70},{120,90}}), iconTransformation(extent={{100,70},{120,
            90}})));
  Modelica.Blocks.MathBoolean.OnDelay onDelay(delayTime=60)
    annotation (Placement(transformation(extent={{50,-4},{58,4}})));
  Modelica.Blocks.Logical.Not not4
    annotation (Placement(transformation(extent={{42,34},{56,48}})));
  Modelica.Blocks.Logical.And OnOff
    annotation (Placement(transformation(extent={{26,-6},{38,6}})));
  Modelica.Blocks.Logical.LogicalSwitch logicalSwitch
    annotation (Placement(transformation(extent={{6,-46},{26,-26}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold
    annotation (Placement(transformation(extent={{74,-70},{94,-50}})));
  Modelica.Blocks.Logical.Not not3
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        rotation=0,
        origin={-40,80})));
  parameter Real N_rel_max=1 "Upper limit of hp N_rel";
  parameter Real N_rel_min=0 "Lower limit of output N_rel";
equation
  connect(THPColdSet.y, PIDcooling.u_s)
    annotation (Line(points={{-85.4,-30},{-82,-30}}, color={0,0,127}));
  connect(hysteresis2.y, or2.u1) annotation (Line(points={{-15.5,41},{-8,41},{
          -8,28},{-1.6,28}},
                           color={255,0,255}));
  connect(THPHotSet1.y, PIDheating.u_s)
    annotation (Line(points={{-85.4,10},{-82,10}}, color={0,0,127}));
  connect(operating.y, N_rel)
    annotation (Line(points={{91,0},{110,0}}, color={0,0,127}));
  connect(hysteresis1.u, T_HS)
    annotation (Line(points={{-65.2,80},{-120,80}}, color={0,0,127}));
  connect(PIDcooling.u_m, T_ev) annotation (Line(points={{-70,-42},{-92,-42},{
          -92,-40},{-120,-40}}, color={0,0,127}));
  connect(PIDheating.u_m, T_con)
    annotation (Line(points={{-70,22},{-70,40},{-120,40}}, color={0,0,127}));
  connect(hysteresis.u, T_CS) annotation (Line(points={{-53.2,-60},{-86,-60},{
          -86,-80},{-120,-80}}, color={0,0,127}));
  connect(modeHeating.u2, heatingModeActive) annotation (Line(points={{-22,-10},
          {-102,-10},{-102,0},{-120,0}}, color={255,0,255}));
  connect(allowOperation, not1.u)
    annotation (Line(points={{0,118},{1.33227e-15,118},{1.33227e-15,76.8}},
                                                        color={255,0,255}));
  connect(or2.y, securityOn.u2) annotation (Line(points={{16.8,28},{18,28},{18,
          35.4},{18.6,35.4}}, color={255,0,255}));
  connect(securityOn.u1, not1.y) annotation (Line(points={{18.6,41},{18.6,67.6},
          {-4.44089e-16,67.6}}, color={255,0,255}));
  connect(hysteresis1.u, hysteresis2.u) annotation (Line(points={{-65.2,80},{
          -64,80},{-64,41},{-27,41}}, color={0,0,127}));
  connect(hysteresis3.u, hysteresis.u) annotation (Line(points={{-27,23},{-32,
          23},{-32,-20},{-53.2,-20},{-53.2,-60}}, color={0,0,127}));
  connect(hysteresis3.y, not2.u)
    annotation (Line(points={{-15.5,23},{-12.6,23}}, color={255,0,255}));
  connect(not2.y, or2.u2) annotation (Line(points={{-5.7,23},{-3.85,23},{-3.85,
          21.6},{-1.6,21.6}},
                        color={255,0,255}));
  connect(On, PIDcooling.trigger) annotation (Line(points={{110,-60},{110,-82},
          {-78,-82},{-78,-42}},color={255,0,255}));
  connect(On, PIDheating.trigger) annotation (Line(points={{110,-60},{110,56},{
          -78,56},{-78,22}}, color={255,0,255}));
  connect(securityOn.y, not4.u)
    annotation (Line(points={{34.7,41},{40.6,41}}, color={255,0,255}));
  connect(OnOff.y, onDelay.u)
    annotation (Line(points={{38.6,0},{48.4,0}}, color={255,0,255}));
  connect(onDelay.y, operating.u2) annotation (Line(points={{58.8,0},{64,0},{64,
          0},{68,0}}, color={255,0,255}));
  connect(OnOff.u1, not4.y) annotation (Line(points={{24.8,0},{24,0},{24,18},{
          56.7,18},{56.7,41}}, color={255,0,255}));
  connect(OnOff.y, pumpsOn) annotation (Line(points={{38.6,0},{44,0},{44,14},{
          72,14},{72,80},{110,80}}, color={255,0,255}));
  connect(zero1.y, operating.u3)
    annotation (Line(points={{65.6,-18},{68,-18},{68,-8}}, color={0,0,127}));
  connect(modeHeating.y, operating.u1)
    annotation (Line(points={{1,-10},{2,-10},{2,8},{68,8}}, color={0,0,127}));
  connect(heatingModeActive, logicalSwitch.u2) annotation (Line(points={{-120,0},
          {-56,0},{-56,-36},{4,-36}}, color={255,0,255}));
  connect(hysteresis.y, logicalSwitch.u3) annotation (Line(points={{-39.4,-60},
          {-16,-60},{-16,-44},{4,-44}}, color={255,0,255}));
  connect(logicalSwitch.y, OnOff.u2) annotation (Line(points={{27,-36},{27,-4.8},
          {24.8,-4.8}}, color={255,0,255}));
  connect(On, greaterThreshold.y)
    annotation (Line(points={{110,-60},{95,-60}}, color={255,0,255}));
  connect(greaterThreshold.u, N_rel) annotation (Line(points={{72,-60},{72,-36},
          {94,-36},{94,0},{110,0}}, color={0,0,127}));
  connect(PIDcooling.y, modeHeating.u3)
    annotation (Line(points={{-59,-30},{-22,-30},{-22,-18}}, color={0,0,127}));
  connect(PIDheating.y, modeHeating.u1) annotation (Line(points={{-59,10},{-44,
          10},{-44,-2},{-22,-2}}, color={0,0,127}));
  connect(hysteresis1.y, not3.u)
    annotation (Line(points={{-51.4,80},{-44.8,80}}, color={255,0,255}));
  connect(not3.y, logicalSwitch.u1) annotation (Line(points={{-35.6,80},{-4,80},
          {-4,-28},{4,-28}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-100,100},{-38,0},{-100,-100}},
          color={95,95,95},
          thickness=0.5),
          Text(
          extent={{-48,24},{98,-16}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Control")}),                               Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CtrHP;
