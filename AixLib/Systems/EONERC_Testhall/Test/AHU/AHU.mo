within AixLib.Systems.EONERC_Testhall.BaseClasses.AHU;
model AHU
  AixLib.Systems.ModularAHU.GenericAHU ahu(
    redeclare package Medium1 = AixLib.Media.Air,
    redeclare package Medium2 = AixLib.Media.Water,
    T_amb=288.15,
    m1_flow_nominal=3.7,
    m2_flow_nominal=2.3,
    usePreheater=true,
    useHumidifierRet=false,
    useHumidifier=false,
    preheater(
      hydraulicModuleIcon="Injection",
      m2_flow_nominal=2.3,
      redeclare AixLib.Systems.HydraulicModules.Injection hydraulicModule(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1(),
        Kv=6.3,
        valveCharacteristic=AixLib.Fluid.Actuators.Valves.Data.LinearLinear(),
        pipe1(length=1.2),
        pipe2(length=0.1),
        pipe3(length=0.1),
        pipe4(length=2.3),
        pipe5(length=2),
        pipe6(length=0.1),
        pipe7(length=1.3),
        pipe8(length=0.3),
        pipe9(length=0.3),
        redeclare
          AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per)))),
    cooler(
      hydraulicModuleIcon="Injection2WayValve",
      m2_flow_nominal=2.3,
      redeclare AixLib.Systems.HydraulicModules.Injection2WayValve
        hydraulicModule(
        pipeModel="SimplePipe",
        length=1,
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_6x1(),
        Kv=25,
        redeclare
          AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_PumpSpeedControlled
          PumpInterface(pumpParam=Testhall.Subsystems.AHU.Pump_Test.pump_cooler()))),
    heater(
      hydraulicModuleIcon="Injection2WayValve",
      m2_flow_nominal=2.3,
      redeclare AixLib.Systems.HydraulicModules.Injection2WayValve
        hydraulicModule(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1(),
        Kv=10,
        redeclare
          AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per)),
        pipe1(length=10),
        pipe2(length=0.6),
        pipe3(length=2),
        pipe4(length=5.5),
        pipe5(length=0.4),
        pipe6(length=10),
        pipe7(length=0.6))))
    annotation (Placement(transformation(extent={{-136,-50},{114,84}})));

  Modelica.Fluid.Interfaces.FluidPort_a rlt_ph_supprim(redeclare package Medium =
        AixLib.Media.Water) annotation (Placement(transformation(extent={{-120,-106},
            {-100,-86}}), iconTransformation(extent={{-170,-110},{-150,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b rlt_ph_retprim(redeclare package Medium =
        AixLib.Media.Water) annotation (Placement(transformation(extent={{-82,-106},
            {-62,-86}}), iconTransformation(extent={{-130,-110},{-110,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_a rlt_c_supprim(redeclare package Medium =
        AixLib.Media.Water) annotation (Placement(transformation(extent={{-26,-106},
            {-6,-86}}), iconTransformation(extent={{-10,-110},{10,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b rlt_c_retprim(redeclare package Medium =
        AixLib.Media.Water) annotation (Placement(transformation(extent={{8,-106},
            {28,-86}}), iconTransformation(extent={{32,-110},{52,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_a rlt_h_supprim(redeclare package Medium =
        AixLib.Media.Water) annotation (Placement(transformation(extent={{48,-106},
            {68,-86}}), iconTransformation(extent={{72,-110},{92,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b rlt_h_retprim(redeclare package Medium =
        AixLib.Media.Water) annotation (Placement(transformation(extent={{74,-106},
            {94,-86}}), iconTransformation(extent={{108,-110},{128,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_a ODA(redeclare package Medium =
        AixLib.Media.Air) annotation (Placement(transformation(extent={{-228,2},
            {-208,22}}), iconTransformation(extent={{-234,-12},{-214,8}})));
  Modelica.Fluid.Interfaces.FluidPort_a ETA(redeclare package Medium =
        AixLib.Media.Air) annotation (Placement(transformation(extent={{206,48},
            {226,68}}), iconTransformation(extent={{212,68},{232,88}})));
  Modelica.Fluid.Interfaces.FluidPort_b SUP(redeclare package Medium =
        AixLib.Media.Air) annotation (Placement(transformation(extent={{206,0},
            {226,20}}), iconTransformation(extent={{216,-12},{236,8}})));
  Modelica.Fluid.Interfaces.FluidPort_b EHA(redeclare package Medium =
        AixLib.Media.Air) annotation (Placement(transformation(extent={{-228,48},
            {-208,68}}), iconTransformation(extent={{-232,72},{-212,92}})));
  AixLib.Systems.ModularAHU.BaseClasses.GenericAHUBus
                            genericAHUBus "Bus connector for genericAHU"
    annotation (Placement(transformation(extent={{-42,82},{22,156}}),
        iconTransformation(extent={{-20,116},{20,164}})));
equation
  connect(rlt_ph_supprim, ahu.port_a3) annotation (Line(points={{-110,-96},{
          -110,-60},{-101.909,-60},{-101.909,-50}},
                                               color={0,127,255}));
  connect(rlt_ph_retprim, ahu.port_b3) annotation (Line(points={{-72,-96},{-72,
          -60},{-80,-60},{-80,-56},{-79.1818,-56},{-79.1818,-50}},
                                                              color={0,127,255}));
  connect(rlt_h_supprim, ahu.port_a5) annotation (Line(points={{58,-96},{58,-62},
          {34.4545,-62},{34.4545,-50}}, color={0,127,255}));
  connect(rlt_h_retprim, ahu.port_b5) annotation (Line(points={{84,-96},{84,-60},
          {56.0455,-60},{56.0455,-50}}, color={0,127,255}));
  connect(rlt_c_supprim, ahu.port_a4) annotation (Line(points={{-16,-96},{-16,-62},
          {-11,-62},{-11,-50}}, color={0,127,255}));
  connect(rlt_c_retprim, ahu.port_b4) annotation (Line(points={{18,-96},{18,-62},
          {11.7273,-62},{11.7273,-50}}, color={0,127,255}));
  connect(ahu.port_a1, ODA) annotation (Line(points={{-136,10.9091},{-136,12},{-218,
          12}}, color={0,127,255}));
  connect(ahu.port_b2, EHA) annotation (Line(points={{-136,59.6364},{-136,58},{
          -218,58}}, color={0,127,255}));
  connect(ahu.genericAHUBus, genericAHUBus) annotation (Line(
      points={{-11,84.6091},{-11,118},{-10,118},{-10,119}},
      color={255,204,51},
      thickness=0.5));
  connect(ahu.port_a2, ETA) annotation (Line(points={{115.136,59.6364},{115.136,
          58},{216,58}}, color={0,127,255}));
  connect(ahu.port_b1, SUP) annotation (Line(points={{115.136,10.9091},{200,
          10.9091},{200,10},{216,10}}, color={0,127,255}));
 annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-220,-100},
            {220,120}}),       graphics={
        Rectangle(
          extent={{-220,120},{220,-100}},
          lineColor={0,0,0},
          pattern=LinePattern.Dash,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-210,0},{-166,0},{-90,0}},  color={28,108,200}),
        Rectangle(visible=usePreheater, extent={{-164,38},{-116,-40}}, lineColor=
              {0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(extent={{-4,38},{44,-40}}, lineColor={0,0,0}),
        Rectangle(extent={{74,38},{122,-40}}, lineColor={0,0,0}),
        Rectangle(extent={{-90,100},{-30,-40}}, lineColor={0,0,0}),
        Line(visible=usePreheater,points={{-164,-40},{-116,38}}, color={0,0,0}),
        Line(points={{-4,-40},{44,38}}, color={0,0,0}),
        Line(points={{74,-40},{122,38}}, color={0,0,0}),
        Line(points={{-4,36},{44,-40}}, color={0,0,0}),
        Line(points={{-90,-34},{-36,100}}, color={0,0,0}),
        Line(points={{-84,-40},{-30,94}}, color={0,0,0}),
        Line(points={{-90,100},{-30,-40}},color={0,0,0}),
        Line(points={{122,0},{166,0}}, color={28,108,200}),
        Line(points={{144,80},{-30,80}},color={28,108,200}),
        Ellipse(extent={{202,-18},{166,18}}, lineColor={0,0,0}),
        Line(points={{176,16},{200,8}}, color={0,0,0}),
        Line(points={{200,-8},{176,-16}}, color={0,0,0}),
        Ellipse(
          extent={{18,-18},{-18,18}},
          lineColor={0,0,0},
          origin={162,80},
          rotation=180),
        Line(
          points={{-12,4},{12,-4}},
          color={0,0,0},
          origin={158,68},
          rotation=180),
        Line(
          points={{12,4},{-12,-4}},
          color={0,0,0},
          origin={158,92},
          rotation=180),
        Line(points={{212,80},{180,80}}, color={28,108,200}),
        Rectangle(visible=useHumidifier, extent={{138,38},{160,-40}}, lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(visible=useHumidifier, points={{146,24},{152,28}}, color={0,0,0}),
        Line(visible=useHumidifier, points={{152,24},{146,24}}, color={0,0,0}),
        Line(visible=useHumidifier, points={{152,20},{146,24}}, color={0,0,0}),
        Line(visible=useHumidifier, points={{146,0},{152,4}}, color={0,0,0}),
        Line(visible=useHumidifier, points={{152,0},{146,0}}, color={0,0,0}),
        Line(visible=useHumidifier, points={{152,-4},{146,0}}, color={0,0,0}),
        Line(visible=useHumidifier, points={{146,-20},{152,-16}}, color={0,0,0}),
        Line(visible=useHumidifier, points={{152,-20},{146,-20}}, color={0,0,0}),
        Line(visible=useHumidifier, points={{152,-24},{146,-20}}, color={0,0,0}),
        Rectangle(visible=useHumidifierRet, extent={{0,100},{20,58}}, lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(visible=useHumidifierRet, points={{8,86},{14,90}}, color={0,0,0}),
        Line(visible=useHumidifierRet, points={{14,90},{8,90}}, color={0,0,0}),
        Line(visible=useHumidifierRet, points={{14,90},{8,94}}, color={0,0,0}),
        Line(visible=useHumidifierRet, points={{8,66},{14,70}}, color={0,0,0}),
        Line(visible=useHumidifierRet, points={{14,70},{8,70}}, color={0,0,0}),
        Line(visible=useHumidifierRet, points={{14,70},{8,74}}, color={0,0,0}),
        Line(points={{0,78}}, color={28,108,200}),
        Line(points={{-90,80},{-210,80}}, color={28,108,200}),
        Line(points={{-30,0},{-4,0}}, color={28,108,200}),
        Line(points={{44,0},{74,0}}, color={28,108,200}),
        Line(points={{202,-2},{218,-2}},
                                       color={28,108,200}),
        Line(visible=usePreheater, points={{-160,-40},{-160,-90}}, color={28,108,200}),
        Line(visible=usePreheater, points={{-120,-40},{-120,-90}}, color={28,108,200}),
        Line(points={{0,-40},{0,-90}}, color={28,108,200}),
        Line(points={{40,-40},{40,-90}}, color={28,108,200}),
        Line(points={{80,-40},{80,-90}}, color={28,108,200}),
        Line(points={{118,-40},{118,-90}}, color={28,108,200})}),Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-220,-100},{220,120}})));
end AHU;
