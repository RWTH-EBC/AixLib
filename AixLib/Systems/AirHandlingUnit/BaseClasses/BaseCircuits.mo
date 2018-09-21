within AixLib.Systems.AirHandlingUnit.BaseClasses;
package BaseCircuits
  model Admix_Circuit "Circuit for Admix system"

    parameter Modelica.SIunits.Time tauSensorAir = 90 "Time constant of air temperature sensors"
                                                                                                annotation(Evaluate=false, Dialog(group = "SensorData"));
    parameter Modelica.SIunits.Time tauSensorWater = 15 "Time constant of water temperature sensors"
                                                                                                    annotation(Evaluate=false, Dialog(group = "SensorData"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nom_Water = 2.886*1000/3600 "nominal mass flow rate in kg/s in medium water"
                                                                                                                               annotation (Dialog(tab="General", group="Nominal Parameters"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nom_Air = 3000/3600*1.18 "nominal mass flow rate in kg/s in medium air"
                                                                                                                          annotation (Dialog(tab="General", group="Nominal Parameters"));




  replaceable package MediumWater =
        Modelica.Media.Water.ConstantPropertyLiquidWater;
  replaceable package MediumAir=AixLib.Media.Air;
    Fluid.HeatExchangers.BasicHX.BasicHXnew basicHXnew(
      allowFlowReversal1=true,
      allowFlowReversal2=true,
      nNodes=2,
      redeclare package MediumAir = MediumAir,
      redeclare package MediumWater = MediumWater,
      final m_flow_nom_Air=m_flow_nom_Air,
      C_wall_Water=5000,
      C_wall_Air=8000,
      Gc=1200,
      allowFlowReversal=true,
      use_T_start=true,
      final m_flow_nom_Water=m_flow_nom_Water,
      volume_Air=3.53,
      volume_Water=0.012,
      dp_nom_Air=66,
      dp_nom_Water=6000)
      annotation (Dialog(group=
            "HeatExchanger", enable=true),Placement(transformation(extent={{24,23},{-24,-23}},
          rotation=180,
          origin={-2,61})));


    HydraulicModules.Admix
             Circuit(
      vol=vol,
      m_flow_nominal=m_flow_nom_Water,
      kIns=0.035,
      allowFlowReversal=true,
      redeclare package Medium = MediumWater,
      d=0.055,
      T_start=T_start,
      T_start_outercir=T_start_outercir,
      final tau=tauSensorWater,
      T_amb=T_amb,
      val(
        tau=1,
        T_start=T_start,
        Kv=10,
        fraK=0.5),
      dIns=0.06,
      valveCharacteristics=false)
                    annotation (Dialog(group=
            "Admix Hydraulic Parameters", enable=true),Placement(transformation(
          extent={{-38,-38},{38,38}},
          rotation=90,
          origin={-2,-36})),choicesAllMatching=true);
    Modelica.Fluid.Sensors.TemperatureTwoPort TairIn(redeclare package Medium =
          MediumAir)
      annotation (Placement(transformation(extent={{-66,70},{-46,90}})));
    Modelica.Blocks.Continuous.FirstOrder Pt1TairIn(
      T=tauSensorAir,
      y_start=basicHXnew.T_start_Air,
      initType=Modelica.Blocks.Types.Init.SteadyState)
      annotation (Placement(transformation(extent={{-52,98},{-32,118}})));
    Zugabe.Modules.Consumer.Components.ConsumerBus consumerBus
      annotation (Placement(transformation(extent={{-20,142},{18,174}}),
          iconTransformation(extent={{-20,142},{18,178}})));
    Modelica.Blocks.Continuous.FirstOrder Pt1TairOut1(
      T=tauSensorAir,
      initType=Modelica.Blocks.Types.Init.SteadyState,
      y_start=basicHXnew.T_start_Air)                 annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={46,110})));
    Modelica.Fluid.Sensors.TemperatureTwoPort TairOut(redeclare package Medium =
          MediumAir)
      annotation (Placement(transformation(extent={{50,70},{70,90}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_airOut(redeclare package Medium =
          MediumAir) "outflow medium 2 (cold)" annotation (Placement(transformation(
            extent={{90,110},{110,130}}), iconTransformation(extent={{90,110},{110,
              130}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_airIn(redeclare package Medium =
          MediumAir) "inflow medium 2 (cold)" annotation (Placement(transformation(
            extent={{-110,110},{-90,130}}), iconTransformation(extent={{-110,110},
              {-90,130}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_fwrdIn(redeclare package Medium =
          MediumWater) annotation (Placement(transformation(extent={{-70,-110},{-50,-90}}),
          iconTransformation(extent={{-70,-110},{-50,-90}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_rtrnOut(redeclare package Medium =
          MediumWater) annotation (Placement(transformation(extent={{50,-110},{70,-90}}),
          iconTransformation(extent={{50,-110},{70,-90}})));
    Zugabe.Fluid.Hydraulics.HydraulicBus
                                  hydraulicBus annotation (Placement(
          transformation(extent={{-112,-34},{-76,2}}), iconTransformation(extent={
              {-116,-38},{-76,2}})));
  equation
    connect(TairIn.port_b, basicHXnew.port_a1) annotation (Line(points={{-46,80},{
            -34,80},{-34,74.8},{-26,74.8}}, color={0,127,255}));
    connect(TairIn.T,Pt1TairIn. u) annotation (Line(points={{-56,91},{-56,108},
            {-54,108}},                        color={0,0,127}));
    connect(Pt1TairOut1.u,TairOut. T) annotation (Line(points={{58,110},{60,110},{
            60,92},{60,92},{60,92},{60,91}}, color={0,0,127}));
    connect(basicHXnew.port_b1,TairOut. port_a) annotation (Line(points={{22,74.8},
            {37,74.8},{37,80},{50,80}}, color={0,127,255}));
    connect(hydraulicBus, Circuit.hydraulicBus) annotation (Line(
        points={{-94,-16},{-98,-16},{-98,-36},{-40,-36}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
    connect(TairIn.port_a, port_airIn) annotation (Line(points={{-66,80},{-82,80},
            {-82,120},{-100,120}}, color={0,127,255}));
    connect(TairOut.port_b, port_airOut) annotation (Line(points={{70,80},{84,80},
            {84,120},{100,120}}, color={0,127,255}));
    connect(Circuit.port_b2, port_rtrnOut) annotation (Line(points={{20.8,-74},
            {42.4,-74},{42.4,-100},{60,-100}},
                                         color={0,127,255}));
    connect(Circuit.port_a1, port_fwrdIn) annotation (Line(points={{-24.8,-74},
            {-42,-74},{-42,-100},{-60,-100}},
                                           color={0,127,255}));
    connect(Circuit.port_b1, basicHXnew.port_a2) annotation (Line(points={{
            -24.8,2},{-24,2},{-24,24},{22,24},{22,47.2}}, color={0,127,255}));
    connect(Circuit.port_a2, basicHXnew.port_b2) annotation (Line(points={{20.8,
            2},{20.8,16},{-16,16},{-16,38},{-26,38},{-26,47.2}}, color={0,127,
            255}));
    connect(Pt1TairIn.y, consumerBus.TairIn) annotation (Line(points={{-31,108},
            {-18,108},{-18,158.08},{-0.905,158.08}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(Pt1TairOut1.y, consumerBus.TairOut) annotation (Line(points={{35,
            110},{22,110},{22,158.08},{-0.905,158.08}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,160}}), graphics={
          Rectangle(
            extent={{-100,160},{100,-100}},
            lineColor={175,175,175},
            lineThickness=0.5,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            pattern=LinePattern.Dash),
          Rectangle(
            extent={{-48,-112},{46,-86}},
            pattern=LinePattern.None,
            lineThickness=0.5,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-60,20},{60,-20}},
            lineColor={95,95,95},
            lineThickness=0.5,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="Admix",
            origin={0,-100},
            rotation=360),
          Polygon(
            points={{0,0},{0,0}},
            lineColor={95,95,95},
            lineThickness=0.5,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid,
            origin={-60,46},
            rotation=360), Ellipse(
            extent={{-20,20},{20,-20}},
            lineColor={135,135,135},
            lineThickness=0.5,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid,
            origin={-60,18},
            rotation=360),                 Line(
            points={{-10,20},{10,0},{-10,-20}},
            color={135,135,135},
            thickness=0.5,
            origin={-60,28},
            rotation=90),
          Polygon(
            points={{-10,-10},{-10,10},{10,0},{-10,-10}},
            lineColor={95,95,95},
            lineThickness=0.5,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid,
            origin={-50,-40},
            rotation=180),
          Polygon(
            points={{10,-10},{10,10},{-10,0},{10,-10}},
            lineColor={95,95,95},
            lineThickness=0.5,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            origin={-60,-30},
            rotation=90),
          Polygon(
            points={{10,-10},{-10,-10},{0,10},{10,-10}},
            lineColor={95,95,95},
            lineThickness=0.5,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid,
            origin={-60,-50},
            rotation=360),
          Ellipse(
            extent={{-6,6},{6,-6}},
            lineColor={95,95,95},
            lineThickness=0.5,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid,
            origin={-74,-40},
            rotation=360),
          Line(
            points={{0,4},{0,-4}},
            color={95,95,95},
            thickness=0.5,
            origin={-64,-40},
            rotation=90),
          Line(
            points={{-60,-92},{-60,-60},{-60,-62}},
            color={28,108,200},
            thickness=1),
          Line(
            points={{-60,-20},{-60,-2}},
            color={28,108,200},
            thickness=1),
          Line(
            points={{-60,38},{-60,64}},
            color={28,108,200},
            thickness=1),
          Line(
            points={{-92,120},{-66,120}},
            color={28,108,200},
            thickness=1),
          Line(
            points={{-40,-40},{60,-40}},
            color={28,108,200},
            thickness=1),
          Line(
            points={{60,-92},{60,64}},
            color={28,108,200},
            thickness=1),
          Line(
            points={{60,120},{92,120}},
            color={28,108,200},
            thickness=1),
          Text(
            extent={{-130,2},{-66,-8}},
            lineColor={0,0,0},
            pattern=LinePattern.Dash,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid,
            textString="HydraulicBus"),
          Line(
            points={{-60,64},{-20,64},{-20,72}},
            color={28,108,200},
            thickness=1),
          Line(
            points={{20,72},{20,64},{60,64}},
            color={28,108,200},
            thickness=1),
          Line(
            points={{-66,120},{-66,140},{-20,140},{-20,130}},
            color={28,108,200},
            thickness=1),
          Line(
            points={{60,120},{60,140},{18,140},{18,130}},
            color={28,108,200},
            thickness=1),
          Ellipse(
            extent={{-68,-68},{-52,-84}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-68,-68},{-52,-84}},
            lineColor={0,128,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="Q"),
          Ellipse(
            extent={{-84,-68},{-68,-84}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-84,-68},{-68,-84}},
            lineColor={216,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="T"),
          Ellipse(
            extent={{38,-68},{54,-84}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{38,-68},{54,-84}},
            lineColor={216,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="T"),
          Line(points={{54,-76},{60,-76}}, color={28,108,200}),
          Ellipse(
            extent={{38,58},{54,42}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{38,58},{54,42}},
            lineColor={216,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="T"),
          Line(points={{54,50},{60,50}}, color={28,108,200}),
          Polygon(
            points={{0,0},{0,0}},
            lineColor={95,95,95},
            lineThickness=0.5,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid,
            origin={-60,46},
            rotation=360),
          Ellipse(
            extent={{-68,58},{-52,42}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-68,58},{-52,42}},
            lineColor={0,128,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="Q"),
          Ellipse(
            extent={{-84,58},{-68,42}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-84,58},{-68,42}},
            lineColor={216,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="T"),
          Ellipse(
            extent={{58,-38},{62,-42}},
            lineColor={28,108,200},
            lineThickness=1,
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-88,140},{-72,124}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-88,140},{-72,124}},
            lineColor={216,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="T"),
          Line(points={{-72,132},{-66,132}}, color={28,108,200}),
          Ellipse(
            extent={{66,140},{82,124}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{66,140},{82,124}},
            lineColor={216,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="T"),
          Line(points={{60,132},{66,132}}, color={28,108,200}),
          Polygon(
            points={{-40,72},{38,130},{-40,130},{-40,72}},
            lineThickness=0.5,
            fillColor={215,215,238},
            fillPattern=FillPattern.Solid,
            lineColor={135,135,135}),
          Polygon(
            points={{-40,72},{38,130},{38,72},{-40,72}},
            lineThickness=0.5,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid,
            lineColor={135,135,135}),
          Text(
            extent={{-32,182},{32,172}},
            lineColor={0,0,0},
            pattern=LinePattern.Dash,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid,
            textString="ConsumerBus")}), Diagram(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,160}})));
  end Admix_Circuit;

  model Injection_Circuit
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Injection_Circuit;

  model Throttle_Circuit
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Throttle_Circuit;
end BaseCircuits;
