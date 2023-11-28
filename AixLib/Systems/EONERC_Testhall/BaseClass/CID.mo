within AixLib.Systems.EONERC_Testhall.BaseClass;
package CID
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
    connect(cid_retprim, cid_Valve.port_b2) annotation (Line(points={{-180,-32},
            {-156,-32},{-156,-32.001},{-150.002,-32.001}},color={0,127,255}));

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

  model CID_ConsumerAir_and_Water

    Modelica.Fluid.Interfaces.FluidPort_a cid_vl_air(redeclare package Medium =
          AixLib.Media.Air) annotation (Placement(transformation(extent={{90,0},
              {110,20}}), iconTransformation(extent={{88,-54},{108,-34}})));
    Modelica.Fluid.Interfaces.FluidPort_a cid_vl_water(redeclare package Medium =
          AixLib.Media.Water) annotation (Placement(transformation(extent={{-42,
              -108},{-22,-88}}), iconTransformation(extent={{-22,-108},{-2,-88}})));
    Modelica.Fluid.Interfaces.FluidPort_b cid_rl_water(redeclare package Medium =
          AixLib.Media.Water) annotation (Placement(transformation(extent={{16,
              -108},{36,-88}}), iconTransformation(extent={{14,-108},{34,-88}})));
    Modelica.Fluid.Interfaces.FluidPort_b cid_rl_air(redeclare package Medium =
          AixLib.Media.Air)                                                                       annotation (Placement(transformation(extent={{88,40},
              {108,60}}),
          iconTransformation(extent={{88,40},{108,60}})));
    HydraulicModules.SimpleConsumer SimpleConsumer_Water(
      redeclare package Medium = AixLib.Media.Water,
      m_flow_nominal=0.15,
      T_start=291.15,
      functionality="Q_flow_input") "Thermal zone"
      annotation (Placement(transformation(extent={{-16,-76},{12,-50}})));
    Modelica.Blocks.Sources.TimeTable cid_heatflow(table=[0,0.5; 86400,3.5;
          2678400,9; 5270400,8.5; 7948800,7.9; 10627200,10.45; 13132800,8.3;
          15811200,5; 18403200,0.25; 21081600,1; 23673600,0; 26352000,0.6;
          29030400,7; 31536000,3.5])
      annotation (Placement(transformation(extent={{86,-38},{66,-18}})));
    Modelica.Blocks.Math.Gain gaincid(k=-1000) annotation (Placement(
          transformation(
          extent={{-5,-5},{5,5}},
          rotation=270,
          origin={-11,-35})));
    Fluid.FixedResistances.HydraulicDiameter res(
      redeclare package Medium = AixLib.Media.Air,
      m_flow_nominal=0.66,
      length=3) annotation (Placement(transformation(extent={{82,0},{62,20}})));
    HydraulicModules.SimpleConsumer SimpleConsumer_Air(
      redeclare package Medium = AixLib.Media.Air,
      m_flow_nominal=0.66,
      T_start=291.15,
      functionality="Q_flow_input") "Thermal zone" annotation (Placement(
          transformation(
          extent={{-14.5,-13.5},{14.5,13.5}},
          rotation=90,
          origin={25.5,27.5})));
    Fluid.FixedResistances.HydraulicDiameter res1(
      redeclare package Medium = AixLib.Media.Air,
      m_flow_nominal=0.66,
      length=3) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={72,50})));
    Modelica.Blocks.Math.Gain gaincid1(k=1000) annotation (Placement(
          transformation(
          extent={{-5,-5},{5,5}},
          rotation=0,
          origin={-17,23})));
    Fluid.FixedResistances.HydraulicDiameter res2(
      redeclare package Medium = AixLib.Media.Water,
      m_flow_nominal=0.15,
      length=3) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-32,-76})));
    Fluid.FixedResistances.HydraulicDiameter res3(
      redeclare package Medium = Media.Water,
      m_flow_nominal=0.15,
      length=3) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={26,-74})));
  equation
    connect(cid_rl_water, cid_rl_water)
      annotation (Line(points={{26,-98},{26,-98}}, color={0,127,255}));
    connect(cid_heatflow.y,gaincid. u) annotation (Line(points={{65,-28},{52,
            -28},{52,-20},{-11,-20},{-11,-29}},
                                color={0,0,127}));
    connect(gaincid.y, SimpleConsumer_Water.Q_flow) annotation (Line(points={{
            -11,-40.5},{-11,-45.25},{-10.4,-45.25},{-10.4,-50}}, color={0,0,127}));
    connect(cid_vl_air, res.port_a)
      annotation (Line(points={{100,10},{82,10}}, color={0,127,255}));
    connect(res1.port_b, cid_rl_air)
      annotation (Line(points={{82,50},{98,50}}, color={0,127,255}));
    connect(gaincid1.u, cid_heatflow.y) annotation (Line(points={{-23,23},{-23,
            -20},{52,-20},{52,-28},{65,-28}}, color={0,0,127}));
    connect(gaincid1.y, SimpleConsumer_Air.Q_flow) annotation (Line(points={{
            -11.5,23},{-11.5,22},{2,22},{2,18.8},{12,18.8}}, color={0,0,127}));
    connect(cid_vl_water, res2.port_a)
      annotation (Line(points={{-32,-98},{-32,-86}}, color={0,127,255}));
    connect(res2.port_b, SimpleConsumer_Water.port_a) annotation (Line(points={
            {-32,-66},{-32,-63},{-16,-63}}, color={0,127,255}));
    connect(SimpleConsumer_Water.port_b, res3.port_a) annotation (Line(points={
            {12,-63},{12,-64},{26,-64}}, color={0,127,255}));
    connect(cid_rl_water, res3.port_b)
      annotation (Line(points={{26,-98},{26,-84}}, color={0,127,255}));
    connect(SimpleConsumer_Air.port_b, res1.port_a) annotation (Line(points={{
            25.5,42},{24,42},{24,50},{62,50}}, color={0,127,255}));
    connect(res.port_b, SimpleConsumer_Air.port_a) annotation (Line(points={{62,
            10},{42,10},{42,6},{25.5,6},{25.5,13}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={28,108,200},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid)}),                      Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end CID_ConsumerAir_and_Water;

  model CID_ConsumerWater

    Fluid.Sources.Boundary_pT                   boundary1(
      redeclare package Medium = Media.Air,
      nPorts=1)       annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=180,
          origin={42,8})));
    Modelica.Fluid.Interfaces.FluidPort_a cid_vl_air(redeclare package Medium
        = Media.Air) annotation (Placement(transformation(extent={{90,-2},{110,
              18}}), iconTransformation(extent={{88,-54},{108,-34}})));
    Modelica.Fluid.Interfaces.FluidPort_a cid_vl_water(redeclare package Medium
        = Media.Water) annotation (Placement(transformation(extent={{-60,-108},
              {-40,-88}}), iconTransformation(extent={{-22,-108},{-2,-88}})));
    Modelica.Fluid.Interfaces.FluidPort_b cid_rl_water(redeclare package Medium
        = Media.Water) annotation (Placement(transformation(extent={{16,-110},{
              36,-90}}), iconTransformation(extent={{14,-108},{34,-88}})));
    Modelica.Fluid.Interfaces.FluidPort_b cid_rl_air(redeclare package Medium
        = Media.Air)                                                                              annotation (Placement(transformation(extent={{88,36},
              {108,56}}),
          iconTransformation(extent={{86,22},{106,42}})));
    Fluid.Sources.Boundary_pT                   boundary2(
      redeclare package Medium = AixLib.Media.Air,
      use_T_in=true,
      nPorts=1)       annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=180,
          origin={44,48})));
    Modelica.Blocks.Sources.CombiTimeTable Office_RoomTemp(
      tableOnFile=true,
      tableName="measurement",
      fileName=ModelicaServices.ExternalReferences.loadResource(
          "modelica://AixLib/Systems/EONERC_Testhall/DataBase/OfficeRoomTemp.txt"),
      columns=2:6,
      smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
      annotation (Placement(transformation(extent={{-100,44},{-80,64}})));

    Modelica.Blocks.Math.Gain T_office(k=1/5)
      annotation (Placement(transformation(extent={{-38,48},{-26,60}})));
    Modelica.Blocks.Math.MultiSum sum_T_office(nu=5)
      annotation (Placement(transformation(extent={{-66,50},{-56,60}})));
    HydraulicModules.SimpleConsumer SimpleConsumer(
      redeclare package Medium = Media.Water,
      m_flow_nominal=0.15,
      T_start=291.15,
      functionality="Q_flow_input") "Thermal zone"
      annotation (Placement(transformation(extent={{-22,-66},{6,-40}})));
    Modelica.Blocks.Sources.TimeTable cid_heatflow_kW(table=[0,0.5; 86400,3.5;
          2678400,9; 5270400,8.5; 7948800,7.9; 10627200,10.45; 13132800,8.3;
          15811200,5; 18403200,0.25; 21081600,1; 23673600,0; 26352000,0.6;
          29030400,7; 31536000,3.5])
      annotation (Placement(transformation(extent={{74,-36},{54,-16}})));
    Modelica.Blocks.Math.Gain heatflow_Watt(k=-1000) annotation (Placement(
          transformation(
          extent={{-5,-5},{5,5}},
          rotation=270,
          origin={-17,-21})));
    Fluid.FixedResistances.HydraulicDiameter res_vl_air(
      redeclare package Medium = AixLib.Media.Air,
      m_flow_nominal=0.66,
      length=3) annotation (Placement(transformation(extent={{84,-2},{64,18}})));
    Fluid.FixedResistances.HydraulicDiameter res_rl_air(
      redeclare package Medium = AixLib.Media.Air,
      m_flow_nominal=0.66,
      length=3) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={70,46})));
    Fluid.FixedResistances.PressureDrop res_vl_water(
      redeclare package Medium = AixLib.Media.Water,
      m_flow_nominal=0.15,
      dp_nominal=3000) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-50,-74})));
    Fluid.FixedResistances.PressureDrop res_rl_water(
      redeclare package Medium = AixLib.Media.Water,
      m_flow_nominal=0.15,
      dp_nominal=3000) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={26,-74})));
    Fluid.Sensors.TemperatureTwoPort senTem_vl(redeclare package Medium =
          AixLib.Media.Water, m_flow_nominal=0.15)
      annotation (Placement(transformation(extent={{-42,-58},{-30,-48}})));
    Fluid.Sensors.TemperatureTwoPort senTem_rl(redeclare package Medium =
          AixLib.Media.Water, m_flow_nominal=0.15)
      annotation (Placement(transformation(extent={{14,-58},{26,-48}})));
  equation
    connect(T_office.y, boundary2.T_in) annotation (Line(points={{-25.4,54},{30,
            54},{30,45.6},{36.8,45.6}}, color={0,0,127}));
    connect(sum_T_office.y, T_office.u) annotation (Line(points={{-55.15,55},{-55.15,
            54},{-39.2,54}}, color={0,0,127}));
    connect(Office_RoomTemp.y[1], sum_T_office.u[1]) annotation (Line(points={{
            -79,54},{-79,53.6},{-66,53.6}}, color={0,0,127}));
    connect(Office_RoomTemp.y[2], sum_T_office.u[2]) annotation (Line(points={{
            -79,54},{-79,54.3},{-66,54.3}}, color={0,0,127}));
    connect(Office_RoomTemp.y[3], sum_T_office.u[3])
      annotation (Line(points={{-79,54},{-79,55},{-66,55}}, color={0,0,127}));
    connect(Office_RoomTemp.y[4], sum_T_office.u[4]) annotation (Line(points={{
            -79,54},{-79,55.7},{-66,55.7}}, color={0,0,127}));
    connect(Office_RoomTemp.y[5], sum_T_office.u[5]) annotation (Line(points={{
            -79,54},{-79,56.4},{-66,56.4}}, color={0,0,127}));
    connect(cid_rl_water, cid_rl_water)
      annotation (Line(points={{26,-100},{26,-100}}, color={0,127,255}));
    connect(cid_heatflow_kW.y, heatflow_Watt.u) annotation (Line(points={{53,
            -26},{-6,-26},{-6,-15},{-17,-15}}, color={0,0,127}));
    connect(heatflow_Watt.y, SimpleConsumer.Q_flow) annotation (Line(points={{
            -17,-26.5},{-17,-33.25},{-16.4,-33.25},{-16.4,-40}}, color={0,0,127}));
    connect(cid_vl_air, res_vl_air.port_a)
      annotation (Line(points={{100,8},{84,8}}, color={0,127,255}));
    connect(res_vl_air.port_b, boundary1.ports[1])
      annotation (Line(points={{64,8},{48,8}}, color={0,127,255}));
    connect(boundary2.ports[1], res_rl_air.port_a)
      annotation (Line(points={{50,48},{50,46},{60,46}}, color={0,127,255}));
    connect(res_rl_air.port_b, cid_rl_air)
      annotation (Line(points={{80,46},{98,46}}, color={0,127,255}));
    connect(res_vl_water.port_a, cid_vl_water)
      annotation (Line(points={{-50,-84},{-50,-98}}, color={0,127,255}));
    connect(res_rl_water.port_b, cid_rl_water)
      annotation (Line(points={{26,-84},{26,-100}}, color={0,127,255}));
    connect(res_vl_water.port_b, senTem_vl.port_a) annotation (Line(points={{
            -50,-64},{-50,-52},{-42,-52},{-42,-53}}, color={0,127,255}));
    connect(senTem_vl.port_b, SimpleConsumer.port_a)
      annotation (Line(points={{-30,-53},{-22,-53}}, color={0,127,255}));
    connect(SimpleConsumer.port_b, senTem_rl.port_a)
      annotation (Line(points={{6,-53},{14,-53}}, color={0,127,255}));
    connect(senTem_rl.port_b, res_rl_water.port_a)
      annotation (Line(points={{26,-53},{26,-64}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={28,108,200},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid), Text(
            extent={{-74,18},{90,-48}},
            textColor={28,108,200},
            textString="CID
")}),                                                              Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end CID_ConsumerWater;
end CID;
