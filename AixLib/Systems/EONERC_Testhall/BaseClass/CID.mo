within AixLib.Systems.EONERC_Testhall.BaseClass;
model CID "Ceiling induction diffusers / DID Deckeninduktionsdurchlässe"

    replaceable package MediumWater =
      AixLib.Media.Water "Medium in the heatingsystem/hydraulic" annotation (
      choicesAllMatching=true);
  replaceable package MediumAir =
      AixLib.Media.Air
    "Medium in the system" annotation(choicesAllMatching=true);

  Fluid.HeatExchangers.DynamicHX                    dynamicHX(
    each m1_flow_nominal=0.15,
    each m2_flow_nominal=0.66,
    each m1_flow_small=0.01,
    each m2_flow_small=0.01,
    each dp1_nominal=100,
    each dp2_nominal=5,
    redeclare package Medium1 = AixLib.Media.Water,
    redeclare package Medium2 = AixLib.Media.Air,
    dT_nom=1,
    Q_nom=1000*0.15)                       "DID"
    annotation (Placement(transformation(extent={{46,52},{26,30}})));
  Fluid.Actuators.Dampers.Exponential        Valve(
    redeclare package Medium = MediumAir,
    each m_flow_nominal=0.66,
    dpDamper_nominal=100,
    each l=0.01) "if Valve Kv=100 " annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-146,86})));

  Modelica.Fluid.Interfaces.FluidPort_b air_out(redeclare package Medium =
        MediumAir) "SUP" annotation (Placement(transformation(extent={{130,54},{
            150,74}}), iconTransformation(extent={{-70,50},{-50,70}})));
  Modelica.Fluid.Interfaces.FluidPort_a cid_supprim(redeclare package Medium =
        MediumWater) annotation (Placement(transformation(extent={{-190,-18},{-170,
            2}}), iconTransformation(extent={{-48,-70},{-28,-50}})));
  Modelica.Fluid.Interfaces.FluidPort_b cid_retprim(redeclare package Medium =
        MediumWater) annotation (Placement(transformation(extent={{-190,-42},{
            -170,-22}}),
                    iconTransformation(extent={{-76,-70},{-56,-50}})));
  Modelica.Fluid.Interfaces.FluidPort_a air_in(redeclare package Medium =
        MediumAir) annotation (Placement(transformation(extent={{-188,76},{-168,
            96}}), iconTransformation(extent={{22,-70},{42,-50}})));

  DistributeBus distributeBus_CID annotation (Placement(transformation(extent={
            {-82,100},{-46,138}}), iconTransformation(extent={{-112,-16},{-86,
            14}})));
  HydraulicModules.Injection2WayValve                       cid_Valve(
    redeclare package Medium = MediumWater,
    length=1,
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_22x1(),
    Kv=0.63,
    m_flow_nominal=0.15,
    redeclare
      AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(redeclare
          AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per)),
    pipe1(length=0.3, fac=10),
    pipe2(length=0.15, fac=10),
    pipe3(length=2.5, fac=10),
    pipe5(length=0.15),
    pipe6(length=0.15),
    pipe4(length=3, fac=5),
    pipe7(length=0.3),
    T_amb=273.15 + 10,
    T_start=323.15) annotation (Placement(transformation(
        extent={{-20.001,-20.0005},{19.999,19.9994}},
        rotation=0,
        origin={-130.001,-20.0005})));

  AixLib.Fluid.Sensors.MassFlowRate senMasFlo_hydraulics(redeclare package
      Medium = AixLib.Media.Water)
    annotation (Placement(transformation(extent={{-78,-18},{-58,2}})));
equation

  connect(cid_supprim, cid_Valve.port_a1) annotation (Line(points={{-180,-8},{-165.001,
          -8},{-165.001,-8.00108},{-150.002,-8.00108}}, color={0,127,255}));
  connect(cid_retprim, cid_Valve.port_b2) annotation (Line(points={{-180,-32},{
          -156,-32},{-156,-32.001},{-150.002,-32.001}}, color={0,127,255}));

  connect(cid_Valve.port_a2, dynamicHX.port_b1) annotation (Line(points={{
          -110.002,-32.001},{-96,-32.001},{-96,34.4},{26,34.4}}, color={0,127,
          255}));

  connect(cid_Valve.port_b1, senMasFlo_hydraulics.port_a) annotation (Line(
        points={{-110.002,-8.00108},{-108,-8.00108},{-108,-8},{-78,-8}}, color=
          {0,127,255}));
  connect(senMasFlo_hydraulics.port_b, dynamicHX.port_a1) annotation (Line(
        points={{-58,-8},{56,-8},{56,34.4},{46,34.4}}, color={0,127,255}));
  connect(cid_Valve.hydraulicBus, distributeBus_CID.bus_cid) annotation (Line(
      points={{-130.002,-0.0011},{-130.002,120},{-63.91,120},{-63.91,119.095}},
      color={255,204,51},
      thickness=0.5));

  connect(Valve.port_a, air_in)
    annotation (Line(points={{-156,86},{-178,86}}, color={0,127,255}));
  connect(Valve.port_b, dynamicHX.port_a2) annotation (Line(points={{-136,86},{
          18,86},{18,47.6},{26,47.6}}, color={0,127,255}));
  connect(senMasFlo_hydraulics.m_flow, distributeBus_CID.bus_cid.mflow)
    annotation (Line(points={{-68,3},{-68,120},{-63.91,120},{-63.91,119.095}},
        color={0,0,127}));
  connect(Valve.y, distributeBus_CID.bus_cid.Office_Air_Valve) annotation (
      Line(points={{-146,98},{-146,106},{-63.91,106},{-63.91,119.095}},
        color={0,0,127}));
  connect(air_out, dynamicHX.port_b2) annotation (Line(points={{140,64},{140,
          47.6},{46,47.6}}, color={0,127,255}));
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
        coordinateSystem(preserveAspectRatio=false, extent={{-180,-80},{160,120}})),
    experiment(StopTime=50000, __Dymola_Algorithm="Dassl"));
end CID;
