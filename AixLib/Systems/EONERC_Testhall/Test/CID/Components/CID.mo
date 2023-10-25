within Testhall.Subsystems.CID.Components;
model CID "Ceiling induction diffusers / DID Deckeninduktionsdurchlässe"

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
    annotation (Placement(transformation(extent={{10,12},{-10,-10}})));
  AixLib.Fluid.Actuators.Valves.TwoWayLinear Valve_office[5](
    redeclare package Medium = MediumAir,
    each m_flow_nominal=3.7,
    each CvData=AixLib.Fluid.Types.CvTypes.Kv,
    each Kv=100,
    each l=0.01) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={44,20})));
  AixLib.Fluid.FixedResistances.GenericPipe pipe_offices[5](
    redeclare package Medium = MediumAir,
    each parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_108x1_5(),
    each length=1,
    m_flow_nominal=3.7) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={72,20})));
  Modelica.Fluid.Interfaces.FluidPort_b heating_air_office[5](redeclare package
      Medium = MediumAir) "SUP" annotation (Placement(transformation(extent={{90,
            10},{110,30}}), iconTransformation(extent={{-70,50},{-50,70}})));
  AixLib.Fluid.MixingVolumes.MixingVolume vol_hot(
    nPorts=6,
    redeclare package Medium = MediumAir,
    V=19,
    m_flow_nominal=4) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-48,10})));
  Modelica.Fluid.Interfaces.FluidPort_a office_heating_water_hot[5](redeclare
      package Medium = MediumWater) annotation (Placement(transformation(extent=
           {{88,-32},{108,-12}}), iconTransformation(extent={{-48,-70},{-28,-50}})));
  Modelica.Fluid.Interfaces.FluidPort_b office_heating_water_cold[5](redeclare
      package Medium = MediumWater) annotation (Placement(transformation(extent=
           {{-110,-32},{-90,-12}}), iconTransformation(extent={{-76,-70},{-56,-50}})));
  Modelica.Fluid.Interfaces.FluidPort_a air_SUP(redeclare package Medium =
                       MediumAir)   annotation (Placement(transformation(extent={{-110,8},
            {-90,28}}),           iconTransformation(extent={{22,-70},{42,-50}})));
  Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.ControlBus controlBus
    annotation (Placement(transformation(extent={{34,50},{54,74}}),
        iconTransformation(extent={{-114,-10},{-84,20}})));
equation
  connect(pipe_offices.port_b, heating_air_office)
    annotation (Line(points={{82,20},{100,20}}, color={0,127,255}));
  connect(vol_hot.ports[2:6], hex_office_heater.port_a2) annotation (Line(points={{
          -51.3333,20},{-30,20},{-30,7.6},{-10,7.6}},
                                                  color={0,127,255}));
  connect(hex_office_heater.port_b1, office_heating_water_cold) annotation (
      Line(points={{-10,-5.6},{-30,-5.6},{-30,-22},{-100,-22}}, color={0,127,255}));
  connect(hex_office_heater.port_a1, office_heating_water_hot) annotation (Line(
        points={{10,-5.6},{25,-5.6},{25,-22},{98,-22}}, color={0,127,255}));
  connect(air_SUP, vol_hot.ports[1]) annotation (Line(points={{-100,18},{-74,18},
          {-74,20},{-44.6667,20}},               color={0,127,255}));

  connect(Valve_office[1].y, controlBus.Office1_Air_Valve)
    annotation (Line(points={{44,32},{44,62}}, color={0,0,127}));
  connect(Valve_office[2].y, controlBus.Office2_Air_Valve)
    annotation (Line(points={{44,32},{44,62}}, color={0,0,127}));
    connect(Valve_office[3].y, controlBus.Office3_Air_Valve)
    annotation (Line(points={{44,32},{44,62}}, color={0,0,127}));
  connect(Valve_office[4].y, controlBus.Office4_Air_Valve)
    annotation (Line(points={{44,32},{44,62}}, color={0,0,127}));
    connect(Valve_office[5].y, controlBus.Office5_Air_Valve)
    annotation (Line(points={{44,32},{44,62}}, color={0,0,127}));

  connect(hex_office_heater.port_b2, Valve_office.port_a) annotation (Line(
        points={{10,7.6},{21,7.6},{21,20},{34,20}}, color={0,127,255}));
  connect(Valve_office.port_b, pipe_offices.port_a)
    annotation (Line(points={{54,20},{62,20}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-60},
            {100,60}}), graphics={Rectangle(
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
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-60},{100,60}})));
end CID;
