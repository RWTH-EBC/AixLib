within AixLib.Systems.EONERC_Testhall.Obsolete;
package JN
  model JN "Reheater/Recooler jet nozzles"

    /** Simplified model. Before use as Recooler, implementation of new pump curve of Wilo Stratos 30/0.5-6 is needed**/

    Fluid.HeatExchangers.DynamicHX                    hx(
      redeclare package Medium1 = AixLib.Media.Air,
      redeclare package Medium2 = AixLib.Media.Water,
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
          AixLib.Media.Air) "SUP" annotation (Placement(transformation(extent={{-170,44},
              {-150,64}}), iconTransformation(extent={{-86,70},{-66,90}})));
    Modelica.Fluid.Interfaces.FluidPort_a heating_water_in(redeclare package
        Medium = AixLib.Media.Water) annotation (Placement(transformation(extent={{-168,-30},
              {-148,-10}}),    iconTransformation(extent={{-44,-50},{-24,-30}})));
    Modelica.Fluid.Interfaces.FluidPort_b heating_water_out(redeclare package
        Medium = AixLib.Media.Water) annotation (Placement(transformation(extent={{164,-24},
              {184,-4}}),      iconTransformation(extent={{-74,-50},{-54,-30}})));
    Modelica.Fluid.Interfaces.FluidPort_a air_in(redeclare package Medium =
          AixLib.Media.Air) annotation (Placement(transformation(extent={{134,44},{154,64}}),
                     iconTransformation(extent={{60,-50},{80,-30}})));
    HydraulicModules.ThrottlePump                   throttlePump(
      length=1,
      each parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1(),
      Kv=2.5,
      redeclare
        AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_PumpSpeedControlled
        PumpInterface(pumpParam=
            AixLib.DataBase.Pumps.PumpPolynomialBased.Pump_DN30_H1_12()),
      pipe1(length=3),
      pipe2(length=1),
      pipe3(length=7),
      m_flow_nominal=0.4,
      redeclare package Medium = AixLib.Media.Water,
      T_amb=273.15 + 10,
      T_start=323.15,
      pipe4(length=11))
                      "reheater jet nozzles" annotation (Placement(
          transformation(
          extent={{-26,-26},{26,26}},
          rotation=90,
          origin={-12,-30})));

    Fluid.Actuators.Dampers.Exponential        AirValve(
      redeclare package Medium = AixLib.Media.Air,
      each m_flow_nominal=2.64,
      dpDamper_nominal=10,
      dpFixed_nominal=10,
      each l=0.01) "if Valve Kv=100 " annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={50,46})));
    Subsystems.BaseClasses.Interfaces.HallHydraulicBus distributeBus_JN
      annotation (Placement(transformation(extent={{32,88},{68,126}}),
          iconTransformation(extent={{-112,-16},{-86,14}})));
    Fluid.Sensors.MassFlowRate        senMasFlo(redeclare package Medium =
          AixLib.Media.Water) annotation (Placement(transformation(
          extent={{6,7},{-6,-7}},
          rotation=270,
          origin={-27,12})));
    Fluid.Sensors.MassFlowRate senMasFloAir(redeclare package Medium =
          AixLib.Media.Air) annotation (Placement(transformation(
          extent={{7.5,-6.5},{-7.5,6.5}},
          rotation=0,
          origin={111.5,53.5})));
  equation

    connect(throttlePump.port_a2, hx.port_b2) annotation (Line(points={{3.6,-4},{
            2,-4},{2,26},{0,26},{0,28.4},{-4,28.4}}, color={0,127,255}));
    connect(throttlePump.port_b2, heating_water_out) annotation (Line(points={{
            3.6,-56},{2,-56},{2,-62},{160,-62},{160,-14},{174,-14}}, color={0,127,
            255}));
    connect(throttlePump.port_a1, heating_water_in) annotation (Line(points={{
            -27.6,-56},{-26,-56},{-26,-62},{-142,-62},{-142,-20},{-158,-20}},
          color={0,127,255}));
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
    connect(senMasFloAir.port_a, air_in) annotation (Line(points={{119,53.5},{122,
            53.5},{122,54},{144,54}}, color={0,127,255}));
    connect(senMasFloAir.port_b, AirValve.port_a) annotation (Line(points={{104,53.5},
            {104,52},{66,52},{66,46},{60,46}}, color={0,127,255}));
    connect(senMasFloAir.m_flow, distributeBus_JN.bus_jn.mflowAir) annotation (
        Line(points={{111.5,60.65},{110,60.65},{110,107.095},{50.09,107.095}},
          color={0,0,127}));
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
  end JN;

  model JN_as_boundary
    Fluid.Sources.MassFlowSource_T              bound_sup(
      redeclare package Medium = AixLib.Media.Air,
      use_m_flow_in=true,
      nPorts=1)       annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=180,
          origin={30,-4})));
    Modelica.Blocks.Sources.CombiTimeTable JN_mflow(
      tableOnFile=true,
      tableName="measurement",
      fileName=ModelicaServices.ExternalReferences.loadResource(
          "modelica://AixLib/Systems/EONERC_Testhall/DataBase/JNmflow.txt"),
      columns=2:9,
      smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
      annotation (Placement(transformation(extent={{-62,-12},{-42,8}})));
    Modelica.Blocks.Math.MultiSum mflow_jn_total(nu=10)
      annotation (Placement(transformation(extent={{-26,-8},{-16,2}})));
    Modelica.Fluid.Interfaces.FluidPort_a jn_sup_air(redeclare package Medium =
          Media.Air) annotation (Placement(transformation(extent={{92,-14},{112,6}}),
          iconTransformation(extent={{88,-54},{108,-34}})));
    Modelica.Fluid.Interfaces.FluidPort_b jn_ret_air(redeclare package Medium =
          Media.Air) annotation (Placement(transformation(extent={{90,24},{110,44}}),
          iconTransformation(extent={{86,22},{106,42}})));
    Fluid.Sources.MassFlowSource_T              bound_ret(
      use_m_flow_in=true,
      redeclare package Medium = AixLib.Media.Air,
      use_T_in=true,
      nPorts=1)       annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=180,
          origin={46,36})));
    Modelica.Blocks.Sources.CombiTimeTable Hall1_Temp(
      tableOnFile=true,
      tableName="measurement",
      fileName=ModelicaServices.ExternalReferences.loadResource(
          "modelica://AixLib/Systems/EONERC_Testhall/DataBase/Office_Hall_Temp.txt"),
      columns=2:8,
      smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
      "1 to 5 Office, 6 - Hall1, 7 - Hall2"
      annotation (Placement(transformation(extent={{-40,28},{-20,48}})));

    Fluid.FixedResistances.HydraulicDiameter res_sup_air(
      redeclare package Medium = AixLib.Media.Air,
      m_flow_nominal=2.64,
      length=3) annotation (Placement(transformation(extent={{68,-14},{48,6}})));
    Modelica.Blocks.Math.Gain gain_mflow(k=-1)
      annotation (Placement(transformation(extent={{-4,-10},{8,2}})));
    Fluid.FixedResistances.HydraulicDiameter res_ret_air(
      redeclare package Medium = AixLib.Media.Air,
      m_flow_nominal=2.64,
      length=3) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={72,34})));
  equation
    connect(JN_mflow.y[1],mflow_jn_total. u[1]) annotation (Line(points={{-41,-2},
            {-28.5,-2},{-28.5,-4.575},{-26,-4.575}},    color={0,0,127}));
    connect(JN_mflow.y[2],mflow_jn_total. u[2]) annotation (Line(points={{-41,-2},
            {-41,-4.225},{-26,-4.225}},   color={0,0,127}));
    connect(JN_mflow.y[3],mflow_jn_total. u[3]) annotation (Line(points={{-41,-2},
            {-41,-3.875},{-26,-3.875}},   color={0,0,127}));
    connect(JN_mflow.y[4],mflow_jn_total. u[4]) annotation (Line(points={{-41,-2},
            {-41,-3.525},{-26,-3.525}},   color={0,0,127}));
    connect(JN_mflow.y[5],mflow_jn_total. u[5]) annotation (Line(points={{-41,-2},
            {-41,-3.175},{-26,-3.175}},   color={0,0,127}));
    connect(JN_mflow.y[6],mflow_jn_total. u[6]) annotation (Line(points={{-41,-2},
            {-41,-2.825},{-26,-2.825}},   color={0,0,127}));
    connect(JN_mflow.y[7],mflow_jn_total. u[7]) annotation (Line(points={{-41,-2},
            {-41,-2.475},{-26,-2.475}},   color={0,0,127}));
    connect(JN_mflow.y[8],mflow_jn_total. u[8]) annotation (Line(points={{-41,-2},
            {-41,-2.125},{-26,-2.125}},   color={0,0,127}));
    connect(JN_mflow.y[1],mflow_jn_total. u[9]) annotation (Line(points={{-41,-2},
            {-41,-1.775},{-26,-1.775}},   color={0,0,127}));
    connect(JN_mflow.y[2],mflow_jn_total. u[10]) annotation (Line(points={{-41,-2},
            {-41,-1.425},{-26,-1.425}},   color={0,0,127}));
    connect(gain_mflow.y, bound_sup.m_flow_in) annotation (Line(points={{8.6,-4},
            {8.6,-8.8},{22.8,-8.8}}, color={0,0,127}));
    connect(res_sup_air.port_b, bound_sup.ports[1])
      annotation (Line(points={{48,-4},{36,-4}}, color={0,127,255}));
    connect(bound_ret.ports[1], res_ret_air.port_a)
      annotation (Line(points={{52,36},{52,34},{62,34}}, color={0,127,255}));
    connect(res_ret_air.port_b, jn_ret_air)
      annotation (Line(points={{82,34},{100,34}}, color={0,127,255}));
    connect(gain_mflow.u, mflow_jn_total.y) annotation (Line(points={{-5.2,-4},{-5.2,
            -3},{-15.15,-3}}, color={0,0,127}));
    connect(mflow_jn_total.y,bound_ret. m_flow_in) annotation (Line(points={{-15.15,
            -3},{-12,-3},{-12,32},{38.8,32},{38.8,31.2}},
                                                      color={0,0,127}));
    connect(jn_sup_air, res_sup_air.port_a)
      annotation (Line(points={{102,-4},{68,-4}}, color={0,127,255}));
    connect(Hall1_Temp.y[6], bound_ret.T_in) annotation (Line(points={{-19,38},{
            -10,38},{-10,34},{38.8,34},{38.8,33.6}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={28,108,200},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid), Text(
            extent={{-52,18},{58,-48}},
            textColor={28,108,200},
            textString="JN
")}),                                                              Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=10000000, __Dymola_Algorithm="Dassl"));
  end JN_as_boundary;
end JN;
