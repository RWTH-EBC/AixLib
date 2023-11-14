within AixLib.Systems.EONERC_Testhall.BaseClass.JetNozzle;
model JN_simpel "Reheater/Recooler jet nozzles"

    replaceable package MediumWater =
      AixLib.Media.Water "Medium in the heatingsystem/hydraulic" annotation (
      choicesAllMatching=true);
  replaceable package MediumAir =
      AixLib.Media.Air
    "Medium in the system" annotation(choicesAllMatching=true);

  Fluid.HeatExchangers.DynamicHX                    hx(
    redeclare package Medium1 = MediumAir,
    redeclare package Medium2 = MediumWater,
    m1_flow_nominal=2.64,
    m2_flow_nominal=0.4,
    m1_flow_small=0.01,
    m2_flow_small=0.01,
    dp1_nominal=10,
    dp2_nominal=10,
    dT_nom=1,
    Q_nom=1000*2)   "Reheater"
    annotation (Placement(transformation(extent={{-4,24},{-24,46}})));
  Modelica.Fluid.Interfaces.FluidPort_b air_out(redeclare package Medium =
        MediumAir) "SUP" annotation (Placement(transformation(extent={{-170,44},
            {-150,64}}), iconTransformation(extent={{-86,70},{-66,90}})));
  Modelica.Fluid.Interfaces.FluidPort_a heating_water_in(redeclare package
      Medium = MediumWater) annotation (Placement(transformation(extent={{-168,-30},
            {-148,-10}}),    iconTransformation(extent={{-44,-50},{-24,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_b heating_water_out(redeclare package
      Medium = MediumWater) annotation (Placement(transformation(extent={{164,-24},
            {184,-4}}),      iconTransformation(extent={{-74,-50},{-54,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_a air_in(redeclare package Medium =
        MediumAir) annotation (Placement(transformation(extent={{126,44},{146,
            64}}), iconTransformation(extent={{60,-50},{80,-30}})));
  HydraulicModules.ThrottlePump                   throttlePump(
    length=1,
    each parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_40x1(),
    Kv=4,
    redeclare
      AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_PumpSpeedControlled
      PumpInterface(pumpParam=
          AixLib.DataBase.Pumps.PumpPolynomialBased.Pump_DN30_H1_12()),
    pipe1(length=3),
    pipe2(length=1),
    pipe3(length=7),
    m_flow_nominal=0.4,
    redeclare package Medium = MediumWater,
    T_amb=273.15 + 10,
    T_start=323.15,
    pipe4(length=11))
                    "reheater jet nozzles" annotation (Placement(
        transformation(
        extent={{-26,-26},{26,26}},
        rotation=90,
        origin={-12,-30})));

  Fluid.Actuators.Dampers.Exponential        AirValve(
    redeclare package Medium = MediumAir,
    each m_flow_nominal=2.64,
    dpDamper_nominal=10,
    dpFixed_nominal=10,
    each l=0.01) "if Valve Kv=100 " annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={50,46})));
  BaseClass.DistributeBus distributeBus_JN annotation (Placement(transformation(
          extent={{32,88},{68,126}}),   iconTransformation(extent={{-112,-16},{
            -86,14}})));
  Fluid.Sensors.MassFlowRate        senMasFlo(redeclare package Medium =
        AixLib.Media.Water) annotation (Placement(transformation(
        extent={{6,7},{-6,-7}},
        rotation=270,
        origin={-27,12})));
equation

  connect(throttlePump.port_a2, hx.port_b2) annotation (Line(points={{3.6,-4},{
          2,-4},{2,26},{0,26},{0,28.4},{-4,28.4}}, color={0,127,255}));
  connect(throttlePump.port_b2, heating_water_out) annotation (Line(points={{
          3.6,-56},{2,-56},{2,-62},{160,-62},{160,-14},{174,-14}}, color={0,127,
          255}));
  connect(throttlePump.port_a1, heating_water_in) annotation (Line(points={{
          -27.6,-56},{-26,-56},{-26,-62},{-142,-62},{-142,-20},{-158,-20}},
        color={0,127,255}));
  connect(air_in, AirValve.port_a) annotation (Line(points={{136,54},{66,54},{
          66,46},{60,46}}, color={0,127,255}));
  connect(AirValve.port_b, hx.port_a1) annotation (Line(points={{40,46},{4,46},
          {4,41.6},{-4,41.6}},
                             color={0,127,255}));
  connect(hx.port_b1, air_out) annotation (Line(points={{-24,41.6},{-24,38},{
          -146,38},{-146,54},{-160,54}},
                                   color={0,127,255}));
  connect(distributeBus_JN.bus_jn, throttlePump.hydraulicBus) annotation (Line(
      points={{50.09,107.095},{50.09,64},{-48,64},{-48,-30},{-38,-30}},
      color={255,204,51},
      thickness=0.5));
  connect(AirValve.y, distributeBus_JN.bus_jn.Hall_AirValve) annotation (Line(
        points={{50,58},{50,82},{50,107.095},{50.09,107.095}}, color={0,0,127}));
  connect(throttlePump.port_b1, senMasFlo.port_a) annotation (Line(points={{
          -27.6,-4},{-27.6,-2},{-27,-2},{-27,6}}, color={0,127,255}));
  connect(senMasFlo.port_b, hx.port_a2) annotation (Line(points={{-27,18},{-27,
          22.2},{-24,22.2},{-24,28.4}}, color={0,127,255}));
  connect(senMasFlo.m_flow, distributeBus_JN.bus_jn.mflow) annotation (Line(
        points={{-34.7,12},{-38,12},{-38,107.095},{50.09,107.095}}, color={0,0,
          127}));
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
