within AixLib.Systems.EONERC_Testhall.BaseClass.JetNozzle;
model JN_simpel "Reheater/Recooler jet nozzles"

    replaceable package MediumWater =
      AixLib.Media.Water "Medium in the heatingsystem/hydraulic" annotation (
      choicesAllMatching=true);
  replaceable package MediumAir =
      AixLib.Media.Air
    "Medium in the system" annotation(choicesAllMatching=true);

  AixLib.Fluid.HeatExchangers.ConstantEffectiveness hx(
    redeclare package Medium1 = MediumAir,
    redeclare package Medium2 = MediumWater,
    m1_flow_nominal=0.4,
    m2_flow_nominal=3,
    eps=0.95,
    m1_flow_small=0.01,
    m2_flow_small=0.01,
    dp1_nominal=10,
    dp2_nominal=10) "Reheater"
    annotation (Placement(transformation(extent={{-2,-10},{-22,12}})));
  Modelica.Fluid.Interfaces.FluidPort_b heating_air_hall1(redeclare package
      Medium = MediumAir) "SUP" annotation (Placement(transformation(extent={{-170,
            44},{-150,64}}), iconTransformation(extent={{-86,70},{-66,90}})));
  Modelica.Fluid.Interfaces.FluidPort_a heating_water_in(redeclare package
      Medium = MediumWater) annotation (Placement(transformation(extent={{-168,-30},
            {-148,-10}}),    iconTransformation(extent={{-44,-50},{-24,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_b heating_water_out(redeclare package
      Medium = MediumWater) annotation (Placement(transformation(extent={{164,-24},
            {184,-4}}),      iconTransformation(extent={{-74,-50},{-54,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_a air_RLT_SUP(redeclare package Medium =
        MediumAir) annotation (Placement(transformation(extent={{126,44},{146,64}}),
        iconTransformation(extent={{60,-50},{80,-30}})));
  HydraulicModules.Throttle                       throttle(
    length=1,
    each parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_40x1(),
    Kv=4,
    pipe1(length=3.5),
    pipe2(length=8),
    pipe3(length=11.5),
    m_flow_nominal=0.4,
    redeclare package Medium = MediumWater,
    T_amb=273.15 + 10,
    T_start=323.15) "reheater jet nozzles" annotation (Placement(
        transformation(
        extent={{-26,-26},{26,26}},
        rotation=90,
        origin={-12,-46})));

  Modelica.Blocks.Sources.Constant const1(k=0.2)
    annotation (Placement(transformation(extent={{-82,-20},{-70,-8}})));
  HydraulicModules.BaseClasses.HydraulicBus
    hydraulicBus_jn annotation (Placement(transformation(extent={{-72,-56},
            {-52,-36}}), iconTransformation(extent={{0,0},{0,0}})));
  AixLib.Fluid.Actuators.Valves.TwoWayLinear Valve(
    redeclare package Medium = MediumAir,
    each m_flow_nominal=0.8,
    CvData=AixLib.Fluid.Types.CvTypes.Kv,
    Kv=12000,
    dpValve_nominal=10,
    each l=0.01) "if Valve Kv=100 " annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-114,54})));
  BaseClass.DistributeBus distributeBus_JN annotation (Placement(transformation(
          extent={{-74,94},{-38,132}}), iconTransformation(extent={{-112,-16},{
            -86,14}})));
equation

  connect(throttle.hydraulicBus, hydraulicBus_jn) annotation (Line(
      points={{-38,-46},{-62,-46}},
      color={255,204,51},
      thickness=0.5));
  connect(throttle.port_a2, hx.port_b2) annotation (Line(points={{3.6,-20},{8,-20},
          {8,-5.6},{-2,-5.6}}, color={0,127,255}));
  connect(throttle.port_b1, hx.port_a2) annotation (Line(points={{-27.6,-20},{-27.6,
          -5.6},{-22,-5.6}}, color={0,127,255}));
  connect(hx.port_a1, air_RLT_SUP) annotation (Line(points={{-2,7.6},{-2,6},{
          136,6},{136,54}}, color={0,127,255}));
  connect(const1.y, hydraulicBus_jn.valveSet) annotation (Line(points={{-69.4,
          -14},{-61.95,-14},{-61.95,-45.95}},
                                     color={0,0,127}));
  connect(throttle.port_b2, heating_water_out) annotation (Line(points={{3.6,
          -72},{2,-72},{2,-78},{160,-78},{160,-14},{174,-14}}, color={0,127,255}));
  connect(throttle.port_a1, heating_water_in) annotation (Line(points={{-27.6,
          -72},{-26,-72},{-26,-78},{-142,-78},{-142,-20},{-158,-20}}, color={0,
          127,255}));
  connect(Valve.port_a, heating_air_hall1)
    annotation (Line(points={{-124,54},{-160,54}}, color={0,127,255}));
  connect(Valve.port_b, hx.port_b1) annotation (Line(points={{-104,54},{-66,54},
          {-66,7.6},{-22,7.6}}, color={0,127,255}));
  connect(Valve.y, distributeBus_JN.bus_jn.valveSet) annotation (Line(points={{-114,66},
          {-114,113.095},{-55.91,113.095}},          color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,-80},
            {160,120}}),graphics={Rectangle(
          extent={{-100,80},{100,-40}},
          lineColor={3,15,29},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid), Text(
          extent={{-58,46},{52,-2}},
          lineColor={3,15,29},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          textString="JN")}), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-160,-80},{160,120}})));
end JN_simpel;
