within AixLib.Building.Benchmark.Regelungsbenchmark;
model Testcontroller
  BusSystem.ControlBus controlBus
    annotation (Placement(transformation(extent={{80,-20},{120,20}})));
  Modelica.Blocks.Sources.RealExpression TSet_Boiler(y=273.15 + 95)
    annotation (Placement(transformation(extent={{-40,-78},{-60,-58}})));
  Modelica.Blocks.Sources.BooleanExpression Heatpump(y=true)
    annotation (Placement(transformation(extent={{-100,-106},{-80,-86}})));
  Modelica.Blocks.Sources.BooleanExpression CHP(y=false)
    annotation (Placement(transformation(extent={{-100,-92},{-80,-72}})));
  Modelica.Blocks.Sources.BooleanExpression Boiler(y=false)
    annotation (Placement(transformation(extent={{-100,-78},{-80,-58}})));
  Modelica.Blocks.Sources.RealExpression ElSet_CHP(y=26)
    annotation (Placement(transformation(extent={{-40,-92},{-60,-72}})));
  Modelica.Blocks.Sources.RealExpression TSet_CHP(y=273.15 + 80)
    annotation (Placement(transformation(extent={{-40,-106},{-60,-86}})));
  Modelica.Blocks.Sources.RealExpression Pump_Coldwater(y=0)
    annotation (Placement(transformation(extent={{20,-106},{0,-86}})));
  Modelica.Blocks.Sources.RealExpression Pump_Heatpump_Cold(y=80000)
    annotation (Placement(transformation(extent={{-40,-106},{-20,-86}})));
  Modelica.Blocks.Sources.RealExpression Pump_Heatpump_warm(y=20000)
    annotation (Placement(transformation(extent={{-40,-92},{-20,-72}})));
  Modelica.Blocks.Sources.RealExpression Pump_CHP(y=0)
    annotation (Placement(transformation(extent={{-40,-78},{-20,-58}})));
  Modelica.Blocks.Sources.RealExpression Pump_Warmwater(y=0)
    annotation (Placement(transformation(extent={{20,-92},{0,-72}})));
  Modelica.Blocks.Sources.RealExpression Pump_Hotwater(y=0)
    annotation (Placement(transformation(extent={{20,-78},{0,-58}})));
  Modelica.Blocks.Sources.RealExpression Pump_Aircooler(y=0)
    annotation (Placement(transformation(extent={{-40,-64},{-20,-44}})));
  Modelica.Blocks.Sources.RealExpression Fan_RLT(y=0)
    annotation (Placement(transformation(extent={{20,-106},{40,-86}})));
  Modelica.Blocks.Sources.RealExpression Fan_Aircooler(y=0)
    annotation (Placement(transformation(extent={{80,-106},{60,-86}})));
  Modelica.Blocks.Sources.RealExpression Valve1(y=1)
    annotation (Placement(transformation(extent={{-100,86},{-80,106}})));
  Modelica.Blocks.Sources.RealExpression Valve2
    annotation (Placement(transformation(extent={{-100,72},{-80,92}})));
  Modelica.Blocks.Sources.RealExpression Valve3(y=1)
    annotation (Placement(transformation(extent={{-100,58},{-80,78}})));
  Modelica.Blocks.Sources.RealExpression Valve4(y=1)
    annotation (Placement(transformation(extent={{-100,44},{-80,64}})));
  Modelica.Blocks.Sources.RealExpression Valve5
    annotation (Placement(transformation(extent={{-40,86},{-60,106}})));
  Modelica.Blocks.Sources.RealExpression Valve6(y=0)
    annotation (Placement(transformation(extent={{-40,72},{-60,92}})));
  Modelica.Blocks.Sources.RealExpression Valve7(y=0)
    annotation (Placement(transformation(extent={{-40,58},{-60,78}})));
  Modelica.Blocks.Sources.RealExpression Valve8
    annotation (Placement(transformation(extent={{-40,44},{-60,64}})));
  Modelica.Blocks.Sources.RealExpression Valve_WarmCold_OPO_1
    annotation (Placement(transformation(extent={{-40,86},{-20,106}})));
  Modelica.Blocks.Sources.RealExpression Valve_WarmCold_OPO_2
    annotation (Placement(transformation(extent={{20,86},{0,106}})));
  Modelica.Blocks.Sources.RealExpression X_OPO(y=0.01)
    annotation (Placement(transformation(extent={{20,86},{40,106}})));
equation
  connect(Boiler.y, controlBus.OnOff_boiler) annotation (Line(points={{-79,-68},
          {-70,-68},{-70,0.1},{100.1,0.1}}, color={255,0,255}));
  connect(Heatpump.y, controlBus.OnOff_heatpump) annotation (Line(points={{-79,
          -96},{-70,-96},{-70,0.1},{100.1,0.1}}, color={255,0,255}));
  connect(TSet_Boiler.y, controlBus.TSet_boiler) annotation (Line(points={{-61,
          -68},{-70,-68},{-70,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(ElSet_CHP.y, controlBus.ElSet_CHP) annotation (Line(points={{-61,-82},
          {-70,-82},{-70,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(TSet_CHP.y, controlBus.TSet_CHP) annotation (Line(points={{-61,-96},{
          -70,-96},{-70,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(Pump_Aircooler.y, controlBus.Pump_Aircooler_dp) annotation (Line(
        points={{-19,-54},{-10,-54},{-10,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(Pump_CHP.y, controlBus.Pump_Hotwater_CHP_dp) annotation (Line(points=
          {{-19,-68},{-10,-68},{-10,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(Pump_Heatpump_warm.y, controlBus.Pump_Warmwater_heatpump_dp)
    annotation (Line(points={{-19,-82},{-10,-82},{-10,0.1},{100.1,0.1}}, color=
          {0,0,127}));
  connect(Pump_Heatpump_Cold.y, controlBus.Pump_Coldwater_heatpump_dp)
    annotation (Line(points={{-19,-96},{-10,-96},{-10,0.1},{100.1,0.1}}, color=
          {0,0,127}));
  connect(Pump_Hotwater.y, controlBus.Pump_Hotwater_dp) annotation (Line(points
        ={{-1,-68},{-10,-68},{-10,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(Pump_Warmwater.y, controlBus.Pump_Warmwater_dp) annotation (Line(
        points={{-1,-82},{-10,-82},{-10,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(Pump_Coldwater.y, controlBus.Pump_Coldwater_dp) annotation (Line(
        points={{-1,-96},{-10,-96},{-10,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(Fan_RLT.y, controlBus.Fan_RLT) annotation (Line(points={{41,-96},{50,
          -96},{50,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(Fan_Aircooler.y, controlBus.Fan_Aircooler) annotation (Line(points={{
          59,-96},{50,-96},{50,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(Valve4.y, controlBus.Valve4) annotation (Line(points={{-79,54},{-70,
          54},{-70,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(Valve3.y, controlBus.Valve3) annotation (Line(points={{-79,68},{-70,
          68},{-70,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(Valve2.y, controlBus.Valve2) annotation (Line(points={{-79,82},{-70,
          82},{-70,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(Valve1.y, controlBus.Valve1) annotation (Line(points={{-79,96},{-70,
          96},{-70,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(Valve8.y, controlBus.Valve8) annotation (Line(points={{-61,54},{-70,
          54},{-70,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(Valve7.y, controlBus.Valve7) annotation (Line(points={{-61,68},{-70,
          68},{-70,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(Valve6.y, controlBus.Valve6) annotation (Line(points={{-61,82},{-70,
          82},{-70,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(Valve5.y, controlBus.Valve5) annotation (Line(points={{-61,96},{-70,
          96},{-70,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(Valve_WarmCold_OPO_1.y, controlBus.Valve_WarmCold_OpenPlanOffice_1)
    annotation (Line(points={{-19,96},{-10,96},{-10,0.1},{100.1,0.1}}, color={0,
          0,127}));
  connect(Valve_WarmCold_OPO_2.y, controlBus.Valve_WarmCold_OpenPlanOffice_2)
    annotation (Line(points={{-1,96},{-10,96},{-10,0.1},{100.1,0.1}}, color={0,
          0,127}));
  connect(X_OPO.y, controlBus.X_OpenPlanOffice) annotation (Line(points={{41,96},
          {50,96},{50,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(CHP.y, controlBus.OnOff_CHP) annotation (Line(points={{-79,-82},{-70,
          -82},{-70,0.1},{100.1,0.1}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Testcontroller;
