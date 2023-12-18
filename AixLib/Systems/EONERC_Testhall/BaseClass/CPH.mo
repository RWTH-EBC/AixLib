within AixLib.Systems.EONERC_Testhall.BaseClass;
package CPH
  model CPH

    HydraulicModules.Injection2WayValve                       cph_Valve(
      redeclare package Medium = AixLib.Media.Water,
      pipeModel="SimplePipe",
      length=1,
      parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1(),
      Kv=12,
      redeclare
        AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_PumpSpeedControlled
        PumpInterface(pumpParam=
            AixLib.DataBase.Pumps.PumpPolynomialBased.Pump_DN25_H1_6_V4()),
      m_flow_nominal=0.2,
      pipe1(length=0.4),
      pipe2(length=0.1),
      pipe3(length=1),
      pipe5(length=0.3),
      pipe4(length=1),
      pipe6(length=0.3),
      T_amb=273.15 + 10,
      T_start=343.15,
      pipe7(length=0.3))
                      annotation (Placement(transformation(
          extent={{-50,-50},{49.9999,49.9999}},
          rotation=90,
          origin={-4,-116})));

    HydraulicModules.Throttle                       cph_Throttle(
      length=1,
      parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_28x1(),
      Kv=8,
      m_flow_nominal=0.2,
      redeclare package Medium = AixLib.Media.Water,
      pipe1(length=1),
      pipe2(length=30, fac=2),
      pipe3(length=30),
      T_amb=273.15 + 10,
      T_start=343.15) annotation (Placement(transformation(
          extent={{-31,-31},{31,31}},
          rotation=90,
          origin={-7,15})));
    RadiantCeilingPanelHeater radiantCeilingPanelHeater(
      genericPipe(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_22x1(),
        length=17.2,
        m_flow_nominal=0.54),
      nNodes=3,
      each Gr=27)
      annotation (Placement(transformation(extent={{-34,58},{22,120}})));

    Modelica.Fluid.Interfaces.FluidPort_a cph_supprim(redeclare package Medium =
          AixLib.Media.Water) annotation (Placement(transformation(extent={{-44,-208},{-24,
              -188}}), iconTransformation(extent={{-86,-210},{-66,-190}})));
    Modelica.Fluid.Interfaces.FluidPort_b cph_retprim(redeclare package Medium =
          AixLib.Media.Water) annotation (Placement(transformation(extent={{16,-208},{36,
              -188}}), iconTransformation(extent={{2,-212},{22,-192}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heat_port_CPH
      annotation (Placement(transformation(extent={{-16,108},{4,128}}),
          iconTransformation(extent={{-38,70},{-18,90}})));
    DistributeBus distributeBus_CPH annotation (Placement(transformation(extent=
             {{-152,-46},{-112,-4}}), iconTransformation(extent={{-180,-76},{-140,
              -34}})));
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
    connect(cph_supprim, cph_Valve.port_a1) annotation (Line(points={{-34,-198},
            {-34,-183},{-33.9999,-183},{-33.9999,-166}},color={0,127,255}));
    connect(cph_retprim, cph_Valve.port_b2) annotation (Line(points={{26,-198},
            {26,-182},{26,-166},{26,-166}},color={0,127,255}));
    connect(cph_Throttle.port_a2, radiantCeilingPanelHeater.radiantcph_ret)
      annotation (Line(points={{11.6,46},{10,46},{10,54},{26,54},{26,88},{24,88},
            {24,89},{22,89}}, color={0,127,255}));
    connect(cph_Throttle.port_b1, radiantCeilingPanelHeater.radiantcph_sup)
      annotation (Line(points={{-25.6,46},{-24,46},{-24,54},{-42,54},{-42,89},{
            -34,89}}, color={0,127,255}));
    connect(cph_Valve.port_b1, cph_Throttle.port_a1) annotation (Line(points={{
            -33.9999,-66.0001},{-32,-66.0001},{-32,-22},{-25.6,-22},{-25.6,-16}},
          color={0,127,255}));
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

  model RadiantCeilingPanelHeater


    parameter Integer nNodes "Number of elements";
    parameter Real Gr(unit="m2") = 1.5*18*0.9/nNodes
      "Net radiation conductance between two surfaces (see docu)";

    AixLib.Fluid.FixedResistances.GenericPipe
                                     genericPipe(
      nNodes=nNodes,
      redeclare package Medium = AixLib.Media.Water,
      T_start=343.15)
      annotation (Dialog(enable=true), Placement(transformation(extent={{-12,-12},{12,12}})));
    Modelica.Fluid.Interfaces.FluidPort_b radiantcph_ret(redeclare package
        Medium =
          AixLib.Media.Water)
      "Fluid connector b (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));
    Modelica.Fluid.Interfaces.FluidPort_a radiantcph_sup(redeclare package
        Medium =
          AixLib.Media.Water)
      "Fluid connector a (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
    Modelica.Thermal.HeatTransfer.Components.BodyRadiation bodyRadiation[nNodes](Gr=Gr)
                              annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,36})));
    Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector(m=
          nNodes) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={0,68})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b1
      annotation (Placement(transformation(extent={{-10,28},{10,48}}),
          iconTransformation(extent={{-10,28},{10,48}})));
  equation
    connect(genericPipe.port_b, radiantcph_ret)
      annotation (Line(points={{12,0},{100,0}}, color={0,127,255}));
    connect(genericPipe.port_a, radiantcph_sup)
      annotation (Line(points={{-12,0},{-100,0}}, color={0,127,255}));
    connect(thermalCollector.port_a, bodyRadiation.port_b)
      annotation (Line(points={{0,58},{0,46}}, color={191,0,0}));
    connect(thermalCollector.port_b, port_b1)
      annotation (Line(points={{0,78},{0,38},{0,38}},
                                               color={191,0,0}));
    connect(genericPipe.heatPort, bodyRadiation[nNodes].port_a)
      annotation (Line(points={{0,12},{0,26}}, color={191,0,0}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
            extent={{-60,10},{60,-10}},
            lineColor={0,0,0},
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-50,-12},{-50,-32}},
            color={255,128,0},
            pattern=LinePattern.Dash),
          Line(
            points={{-30,-12},{-30,-32}},
            color={255,128,0},
            pattern=LinePattern.Dash),
          Line(
            points={{-10,-12},{-10,-32}},
            color={255,128,0},
            pattern=LinePattern.Dash),
          Line(
            points={{10,-12},{10,-32}},
            color={255,128,0},
            pattern=LinePattern.Dash),
          Line(
            points={{30,-12},{30,-32}},
            color={255,128,0},
            pattern=LinePattern.Dash),
          Line(
            points={{50,-12},{50,-32}},
            color={255,128,0},
            pattern=LinePattern.Dash)}),                           Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end RadiantCeilingPanelHeater;
end CPH;
