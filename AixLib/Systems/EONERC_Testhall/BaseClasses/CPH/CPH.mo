within AixLib.Systems.EONERC_Testhall.BaseClasses.CPH;
model CPH


  AixLib.Systems.HydraulicModules.Injection2WayValve cph_Valve(redeclare
      package Medium =
        AixLib.Media.Water,
    length=1,
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1(),
    Kv=1.2,
    m_flow_nominal=0.54,
     redeclare
          AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 per)),
    pipe1(length=0.4),
    pipe2(length=0.1),
    pipe3(length=1),
    pipe5(length=0.15),
    pipe4(length=1),
    pipe6(length=0.15),
    pipe7(length=0.3),
    T_amb=273.15 + 10,
    T_start=343.15) annotation (Placement(transformation(
        extent={{-50,-50},{49.9999,49.9999}},
        rotation=90,
        origin={-4,-116})));

  /**Pumpe Original: Wilo Stratos 25/1to6**/

  AixLib.Systems.HydraulicModules.Throttle cph_Throttle(
    length=1,
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_28x1(),
    Kv=8,
    m_flow_nominal=0.54,
    redeclare package Medium = AixLib.Media.Water,
    pipe1(length=1),
    pipe2(length=30, fac=2),
    pipe3(length=30),
    T_amb=273.15 + 10,
    T_start=343.15) annotation (Placement(transformation(
        extent={{-31,-31},{31,31}},
        rotation=90,
        origin={-7,15})));
  Components.RadiantCeilingPanelHeater radiantCeilingPanelHeater(
    genericPipe(
      parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_18x1(),
      length=17.2,
      m_flow_nominal=0.54),
    redeclare package Medium = AixLib.Media.Water,
    nNodes=3,
    each Gr=27) annotation (Placement(transformation(extent={{-34,58},{22,120}})));

  Modelica.Fluid.Interfaces.FluidPort_a cph_supprim(redeclare package Medium =
        AixLib.Media.Water) annotation (Placement(transformation(extent={{-44,-208},{-24,
            -188}}), iconTransformation(extent={{-86,-210},{-66,-190}})));
  Modelica.Fluid.Interfaces.FluidPort_b cph_retprim(redeclare package Medium =
        AixLib.Media.Water) annotation (Placement(transformation(extent={{16,-208},{36,
            -188}}), iconTransformation(extent={{2,-212},{22,-192}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heat_port_CPH
    annotation (Placement(transformation(extent={{-16,108},{4,128}}),
        iconTransformation(extent={{-38,70},{-18,90}})));
  BaseClass.DistributeBus distributeBus_CPH annotation (Placement(
        transformation(extent={{-152,-46},{-112,-4}}),  iconTransformation(
          extent={{-180,-76},{-140,-34}})));
  AixLib.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
        AixLib.Media.Water) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={-32,-40})));
equation
  connect(cph_Throttle.port_b2, cph_Valve.port_a2) annotation (Line(points={{11.6,
          -16},{10,-16},{10,-56},{26,-56},{26,-66.0001}},  color={0,127,255}));
  connect(radiantCeilingPanelHeater.port_b1,heat_port_CPH)
    annotation (Line(points={{-6,100.78},{-6,109.39},{-6,109.39},{-6,118}},
                                                  color={191,0,0}));
  connect(distributeBus_CPH.bus_cph_throttle, cph_Throttle.hydraulicBus)
    annotation (Line(
      points={{-131.9,-24.895},{-131.9,15},{-38,15}},
      color={255,204,51},
      thickness=0.5));
  connect(distributeBus_CPH.bus_cph, cph_Valve.hydraulicBus) annotation (Line(
      points={{-131.9,-24.895},{-131.9,-116},{-53.9999,-116}},
      color={255,204,51},
      thickness=0.5));
  connect(cph_supprim, cph_Valve.port_a1) annotation (Line(points={{-34,-198},{
          -34,-183},{-33.9999,-183},{-33.9999,-166}}, color={0,127,255}));
  connect(cph_retprim, cph_Valve.port_b2) annotation (Line(points={{26,-198},{
          26,-182},{26,-166},{26,-166}}, color={0,127,255}));
  connect(cph_Throttle.port_a2, radiantCeilingPanelHeater.radiantcph_ret)
    annotation (Line(points={{11.6,46},{10,46},{10,54},{26,54},{26,88},{24,88},
          {24,89},{22,89}}, color={0,127,255}));
  connect(cph_Throttle.port_b1, radiantCeilingPanelHeater.radiantcph_sup)
    annotation (Line(points={{-25.6,46},{-24,46},{-24,54},{-42,54},{-42,89},{
          -34,89}}, color={0,127,255}));
  connect(senMasFlo.port_b, cph_Throttle.port_a1) annotation (Line(points={{-32,
          -30},{-32,-16},{-25.6,-16}}, color={0,127,255}));
  connect(senMasFlo.port_a, cph_Valve.port_b1) annotation (Line(points={{-32,-50},
          {-33.9999,-50},{-33.9999,-66.0001}},      color={0,127,255}));
  connect(senMasFlo.m_flow, distributeBus_CPH.bus_cph.m_flow) annotation (Line(
        points={{-43,-40},{-106,-40},{-106,-24.895},{-131.9,-24.895}}, color={0,
          0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,
            -200},{100,120}}),graphics={
        Rectangle(
          extent={{-160,82},{102,-200}},
          lineColor={0,0,0},
          fillColor={212,212,212},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-94,-76},{36,-108}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-68,-110},{-68,-130}},
          color={255,128,0},
          pattern=LinePattern.Dash,
          thickness=1),
        Line(
          points={{-48,-110},{-48,-130}},
          color={255,128,0},
          pattern=LinePattern.Dash,
          thickness=1),
        Line(
          points={{-28,-110},{-28,-130}},
          color={255,128,0},
          pattern=LinePattern.Dash,
          thickness=1),
        Line(
          points={{-8,-110},{-8,-130}},
          color={255,128,0},
          pattern=LinePattern.Dash,
          thickness=1),
        Line(
          points={{12,-110},{12,-130}},
          color={255,128,0},
          pattern=LinePattern.Dash,
          thickness=1),
        Line(
          points={{32,-110},{32,-130}},
          color={255,128,0},
          pattern=LinePattern.Dash,
          thickness=1),
        Text(
          extent={{-80,32},{18,-48}},
          textColor={0,0,0},
          textString="CPH"),
        Line(
          points={{-90,-110},{-90,-130}},
          color={255,128,0},
          pattern=LinePattern.Dash,
          thickness=1)}), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-160,-200},{100,120}})),
    experiment(StopTime=7200, __Dymola_Algorithm="Dassl"));
end CPH;
