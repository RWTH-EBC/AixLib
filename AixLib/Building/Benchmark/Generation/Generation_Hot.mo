within AixLib.Building.Benchmark.Generation;
model Generation_Hot
  replaceable package Medium_Water =
    AixLib.Media.Water "Medium in the component";

  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_Hot(redeclare package Medium
      = Medium_Water)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,28},{110,48}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_Hot(redeclare package Medium
      = Medium_Water)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-30},{110,-10}})));

  Test.Boiler_Benchmark boiler_Benchmark(
    m_flow_nominal=1,
    paramBoiler=DataBase.Boiler.General.Boiler_Vitogas200F_11kW(),
    redeclare package Medium = Medium_Water)
    annotation (Placement(transformation(extent={{10,46},{30,66}})));

  Fluid.Movers.FlowControlled_dp Pump_Hotwater_CHP_dp(
    m_flow_nominal=1,
    addPowerToMedium=true,
    tau=1,
    dp_nominal=700,
    redeclare package Medium = Medium_Water,
    redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos80slash1to12 per)
    annotation (Placement(transformation(extent={{-40,6},{-20,26}})));

  Fluid.Actuators.Valves.ThreeWayLinear Valve6(
    m_flow_nominal=0.2,
    dpValve_nominal=2,
    y_start=1,
    redeclare package Medium = Medium_Water)
    annotation (Placement(transformation(extent={{8,26},{-12,6}})));

  Fluid.BoilerCHP.CHP cHP(
    electricityDriven=true,
    TSetIn=true,
    m_flow_nominal=0.2,
    m_flow_small=0.01,
    redeclare package Medium = Medium_Water,
    param=DataBase.CHP.CHP_Cleanergy_C9G(),
    minCapacity=24)
    annotation (Placement(transformation(extent={{-86,6},{-66,26}})));

  Fluid.Sources.Boundary_pT bou3(
    nPorts=1,
    p=100000,
    redeclare package Medium = Medium_Water)
              annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={26,-8})));
  BusSystem.ControlBus controlBus annotation (Placement(transformation(extent={
            {-20,80},{20,120}}), iconTransformation(extent={{-10,90},{10,110}})));
equation
  connect(Valve6.port_3, boiler_Benchmark.port_a)
    annotation (Line(points={{-2,26},{-2,56},{10,56}}, color={0,127,255}));
  connect(Pump_Hotwater_CHP_dp.port_b, Valve6.port_2)
    annotation (Line(points={{-20,16},{-12,16}}, color={0,127,255}));
  connect(cHP.port_b, Pump_Hotwater_CHP_dp.port_a)
    annotation (Line(points={{-66,16},{-40,16}}, color={0,127,255}));
  connect(Valve6.port_1, Fluid_out_Hot) annotation (Line(points={{8,16},{70,16},
          {70,38},{100,38}}, color={0,127,255}));
  connect(boiler_Benchmark.port_b, Fluid_out_Hot) annotation (Line(points={{30,
          56},{70,56},{70,38},{100,38}}, color={0,127,255}));
  connect(cHP.port_a, Fluid_in_Hot) annotation (Line(points={{-86,16},{-90,16},
          {-90,-20},{100,-20}}, color={0,127,255}));
  connect(bou3.ports[1], Fluid_in_Hot)
    annotation (Line(points={{26,-12},{26,-20},{100,-20}}, color={0,127,255}));
  connect(boiler_Benchmark.isOn, controlBus.OnOff_boiler) annotation (Line(
        points={{25,47},{25,40},{0.1,40},{0.1,100.1}}, color={255,0,255}));
  connect(cHP.on, controlBus.OnOff_CHP) annotation (Line(points={{-73,7},{-73,0},
          {-50,0},{-50,40},{0.1,40},{0.1,100.1}}, color={255,0,255}));
  connect(Pump_Hotwater_CHP_dp.dp_in, controlBus.Pump_Hotwater_CHP_dp)
    annotation (Line(points={{-30,28},{-30,40},{0.1,40},{0.1,100.1}}, color={0,
          0,127}));
  connect(Valve6.y, controlBus.Valve6) annotation (Line(points={{-2,4},{-2,-2},
          {12,-2},{12,30},{0.1,30},{0.1,100.1}}, color={0,0,127}));
  connect(cHP.elSet, controlBus.ElSet_CHP) annotation (Line(points={{-83,22},{
          -88,22},{-88,40},{0.1,40},{0.1,100.1}}, color={0,0,127}));
  connect(cHP.TSet, controlBus.TSet_CHP) annotation (Line(points={{-83,10},{-88,
          10},{-88,0},{-50,0},{-50,40},{0.1,40},{0.1,100.1}}, color={0,0,127}));
  connect(boiler_Benchmark.TSet, controlBus.TSet_boiler)
    annotation (Line(points={{13,63},{0.1,63},{0.1,100.1}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{28,80},{90,60}},
          lineColor={28,108,200},
          textString="Parameter passen nicht")}));
end Generation_Hot;
