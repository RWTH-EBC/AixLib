within Testhall.Subsystems.CID.Components;
model CID_2 "Ceiling induction diffusers / DID Deckeninduktionsdurchlässe"

    replaceable package MediumWater =
      AixLib.Media.Water "Medium in the heatingsystem/hydraulic" annotation (
      choicesAllMatching=true);
  replaceable package MediumAir =
      AixLib.Media.Air
    "Medium in the system" annotation(choicesAllMatching=true);

  AixLib.Fluid.HeatExchangers.ConstantEffectiveness hex_office_heater[5](
    m1_flow_nominal=3.7,
    m2_flow_nominal=2.1,
    eps=0.95,
    m1_flow_small=0.01,
    m2_flow_small=0.01,
    dp1_nominal=0,
    dp2_nominal=0,
    redeclare package Medium1 = MediumWater,
    redeclare package Medium2 = MediumAir) "DID"
    annotation (Placement(transformation(extent={{50,56},{30,34}})));
  AixLib.Fluid.Actuators.Valves.TwoWayLinear Valve_office[5](
    redeclare package Medium = MediumAir,
    each m_flow_nominal=3.7,
    each CvData=AixLib.Fluid.Types.CvTypes.Kv,
    each Kv=100,
    each l=0.01) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={84,64})));
  AixLib.Fluid.FixedResistances.GenericPipe pipe_offices[5](
    redeclare package Medium = MediumAir,
    each parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_108x1_5(),
    each length=1,
    m_flow_nominal=3.7) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={112,64})));
  Modelica.Fluid.Interfaces.FluidPort_b heating_air_office[5](redeclare package
      Medium = MediumAir) "SUP" annotation (Placement(transformation(extent={{130,54},
            {150,74}}),     iconTransformation(extent={{-70,50},{-50,70}})));
  AixLib.Fluid.MixingVolumes.MixingVolume vol_hot(
    nPorts=6,
    redeclare package Medium = MediumAir,
    V=19,
    m_flow_nominal=4) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-8,54})));
  Modelica.Fluid.Interfaces.FluidPort_a office_heating_water_in(redeclare
      package Medium = MediumWater) annotation (Placement(transformation(extent
          ={{-190,-18},{-170,2}}), iconTransformation(extent={{-48,-70},{-28,-50}})));
  Modelica.Fluid.Interfaces.FluidPort_b office_heating_water_out(redeclare
      package Medium = MediumWater) annotation (Placement(transformation(extent
          ={{-190,-46},{-170,-26}}), iconTransformation(extent={{-76,-70},{-56,
            -50}})));
  Modelica.Fluid.Interfaces.FluidPort_a air_SUP(redeclare package Medium =
                       MediumAir)   annotation (Placement(transformation(extent={{-188,76},
            {-168,96}}),          iconTransformation(extent={{22,-70},{42,-50}})));
  Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.ControlBus controlBus
    annotation (Placement(transformation(extent={{74,94},{94,118}}),
        iconTransformation(extent={{0,0},{0,0}})));

  AixLib.Systems.HydraulicModules.Throttle cid_Throttle[5](
    length=1,
    each parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_22x1_2(),
    Kv=100,
    pipe1(length={9.5,24,24,24,24}),
    pipe2(length={1.2,7.5,12,13,16.5}),
    pipe3(length={11,31.5,36,37,40.5}),
    m_flow_nominal=2.3,
    redeclare package Medium = MediumWater,
    T_amb=273.15 + 10,
    T_start=323.15) annotation (Placement(transformation(
        extent={{-19,-19},{19,19}},
        rotation=0,
        origin={-31,-23})));
  AixLib.Fluid.MixingVolumes.MixingVolume     heater_offices_volume(
    redeclare package Medium = MediumWater,
    m_flow_nominal=2.3,
    V=0.012,
    nPorts=6,
    T_start=323.15) annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=180,
        origin={-73,-47})));
  AixLib.Fluid.MixingVolumes.MixingVolume     heater_offices_volume1(
    redeclare package Medium = MediumWater,
    m_flow_nominal=2.3,
    V=0.012,
    nPorts=6,
    T_start=323.15) annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=180,
        origin={-73,-7})));
  AixLib.Systems.HydraulicModules.BaseClasses.HydraulicBus
                                            hydraulicBus_heater_office_valve[5]
    annotation (Placement(transformation(extent={{-58,4},{-38,24}}),    iconTransformation(extent={{0,0},
            {0,0}})));
  BaseClass.ControlBus controlBus_office_heating annotation (Placement(
        transformation(extent={{-58,30},{-40,50}}), iconTransformation(extent={
            {0,0},{0,0}})));
  BaseClass.DistributeBus distributeBus_CID annotation (Placement(
        transformation(extent={{-82,100},{-46,138}}), iconTransformation(extent=
           {{-112,-16},{-86,14}})));
  AixLib.Systems.HydraulicModules.Injection2WayValve cid_Valve(
    redeclare package Medium = MediumWater,
    length=1,
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_28x1(),
    Kv=10,
    m_flow_nominal=2.3,
    redeclare
      AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(redeclare
          AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per)),
    pipe1(length=0.3),
    pipe2(length=0.15),
    pipe3(length=2.5),
    pipe5(length=0.15),
    pipe6(length=0.15),
    pipe4(length=3),
    pipe7(length=0.3),
    T_amb=273.15 + 10,
    T_start=323.15) annotation (Placement(transformation(
        extent={{-20.001,-20.0005},{19.999,19.9994}},
        rotation=180,
        origin={-130.001,-20.0005})));
equation
  connect(pipe_offices.port_b, heating_air_office)
    annotation (Line(points={{122,64},{140,64}},color={0,127,255}));
  connect(vol_hot.ports[2:6], hex_office_heater.port_a2) annotation (Line(points={{
          -11.3333,64},{10,64},{10,51.6},{30,51.6}},
                                                  color={0,127,255}));
  connect(air_SUP, vol_hot.ports[1]) annotation (Line(points={{-178,86},{-34,86},
          {-34,64},{-4.66667,64}},               color={0,127,255}));

  connect(Valve_office[1].y, controlBus.Office1_Air_Valve)
    annotation (Line(points={{84,76},{84,106}},color={0,0,127}));
  connect(Valve_office[2].y, controlBus.Office2_Air_Valve)
    annotation (Line(points={{84,76},{84,106}},color={0,0,127}));
    connect(Valve_office[3].y, controlBus.Office3_Air_Valve)
    annotation (Line(points={{84,76},{84,106}},color={0,0,127}));
  connect(Valve_office[4].y, controlBus.Office4_Air_Valve)
    annotation (Line(points={{84,76},{84,106}},color={0,0,127}));
    connect(Valve_office[5].y, controlBus.Office5_Air_Valve)
    annotation (Line(points={{84,76},{84,106}},color={0,0,127}));

  connect(heater_offices_volume1.ports[1:5], cid_Throttle.port_a1) annotation (
      Line(points={{-74.4,0},{-61.5,0},{-61.5,-11.6},{-50,-11.6}},    color={0,127,
          255}));
  connect(heater_offices_volume.ports[1:5], cid_Throttle.port_b2) annotation (
      Line(points={{-74.4,-40},{-61.5,-40},{-61.5,-34.4},{-50,-34.4}}, color={0,
          127,255}));
  connect(cid_Throttle.port_b1, hex_office_heater.port_b1) annotation (Line(
        points={{-12,-11.6},{19,-11.6},{19,38.4},{30,38.4}}, color={0,127,255}));
  connect(hex_office_heater.port_a1, cid_Throttle.port_a2) annotation (Line(
        points={{50,38.4},{66,38.4},{66,-34.4},{-12,-34.4}}, color={0,127,255}));
  connect(Valve_office.port_b, pipe_offices.port_a) annotation (Line(points={{94,
          64},{100,64},{100,64},{102,64}}, color={0,127,255}));
  connect(Valve_office.port_a, hex_office_heater.port_b2) annotation (Line(
        points={{74,64},{62,64},{62,51.6},{50,51.6}}, color={0,127,255}));
  connect(hydraulicBus_heater_office_valve[1],controlBus_office_heating. office_1_valve_ctrl)
    annotation (Line(
      points={{-48,6},{-48,40.05},{-48.955,40.05}},
      color={255,204,51},
      thickness=0.5));
  connect(hydraulicBus_heater_office_valve[2],controlBus_office_heating. office_2_valve_ctrl)
    annotation (Line(
      points={{-48,10},{-48,40.05},{-48.955,40.05}},
      color={255,204,51},
      thickness=0.5));
  connect(hydraulicBus_heater_office_valve[3],controlBus_office_heating. office_3_valve_ctrl)
    annotation (Line(
      points={{-48,14},{-48.955,14},{-48.955,40.05}},
      color={255,204,51},
      thickness=0.5));
  connect(hydraulicBus_heater_office_valve[4],controlBus_office_heating. office_4_valve_ctrl)
    annotation (Line(
      points={{-48,18},{-48,40.05},{-48.955,40.05}},
      color={255,204,51},
      thickness=0.5));
  connect(hydraulicBus_heater_office_valve[5],controlBus_office_heating. office_5_valve_ctrl)
    annotation (Line(
      points={{-48,22},{-48,40.05},{-48.955,40.05}},
      color={255,204,51},
      thickness=0.5));
  connect(cid_Throttle.hydraulicBus, hydraulicBus_heater_office_valve)
    annotation (Line(
      points={{-31,-4},{-30.5,-4},{-30.5,14},{-48,14}},
      color={255,204,51},
      thickness=0.5));
  connect(controlBus_office_heating, distributeBus_CID.control_office_heating)
    annotation (Line(
      points={{-49,40},{-49,71},{-63.91,71},{-63.91,119.095}},
      color={255,204,51},
      thickness=0.5));
  connect(distributeBus_CID.controlBus_cid, controlBus) annotation (Line(
      points={{-64,119},{84,119},{84,106}},
      color={255,204,51},
      thickness=0.5));
  connect(office_heating_water_in, cid_Valve.port_a2) annotation (Line(points={
          {-180,-8},{-165,-8},{-165,-7.99998},{-150,-7.99998}}, color={0,127,
          255}));
  connect(office_heating_water_out, cid_Valve.port_b1) annotation (Line(points=
          {{-180,-36},{-156,-36},{-156,-31.9999},{-150,-31.9999}}, color={0,127,
          255}));
  connect(cid_Valve.port_b2, heater_offices_volume1.ports[6]) annotation (Line(
        points={{-110,-7.99998},{-110,-6},{-94,-6},{-94,6},{-74.1667,6},{
          -74.1667,2.66454e-15}}, color={0,127,255}));
  connect(cid_Valve.port_a1, heater_offices_volume.ports[6]) annotation (Line(
        points={{-110,-31.9999},{-110,-30},{-73,-30},{-73,-40}}, color={0,127,
          255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-80},
            {160,120}}),graphics={Rectangle(
          extent={{-100,60},{100,-60}},
          lineColor={3,15,29},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid), Text(
          extent={{-78,30},{74,-28}},
          lineColor={3,15,29},
          lineThickness=1,
          fillColor={135,135,135},
          fillPattern=FillPattern.None,
          textString="CID")}),                                   Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-180,-80},{160,120}})));
end CID_2;
