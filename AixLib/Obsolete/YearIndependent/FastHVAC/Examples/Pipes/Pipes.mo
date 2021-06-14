within AixLib.Obsolete.YearIndependent.FastHVAC.Examples.Pipes;
model Pipes
  extends Modelica.Icons.Example;
  Components.Pipes.DynamicPipe PipeInsulationAndConvectionandRadiation(
    withInsulation=true,
    withConvection=true,
    withRadiation=true)
    annotation (Placement(transformation(extent={{-14,-96},{6,-76}})));
  Components.Pumps.FluidSource fluidSource1
    annotation (Placement(transformation(extent={{-76,-96},{-56,-76}})));
  Components.Sinks.Vessel vessel1
    annotation (Placement(transformation(extent={{66,-94},{86,-74}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature
    fixedTemperatureSurroundingAir2(
                                   T=293.15)
    annotation (Placement(transformation(extent={{20,-76},{4,-60}})));
  Modelica.Blocks.Sources.Constant TFlow1(
                                         k=273.15 + 60)
    annotation (Placement(transformation(extent={{-100,-72},{-84,-58}})));
  Modelica.Blocks.Sources.Ramp mFlow1(
                                     height=1, duration=5000)
    annotation (Placement(transformation(extent={{-98,-94},{-84,-80}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature
    fixedTemperatureSurroundingAir3(T=288.15)
    annotation (Placement(transformation(extent={{-32,-76},{-16,-60}})));
  Components.Pipes.DynamicPipe PipeInsulationAndConvection(
    withInsulation=true,
    withConvection=true,
    withRadiation=false)
    annotation (Placement(transformation(extent={{-16,-28},{4,-8}})));
  Components.Pumps.FluidSource fluidSource2
    annotation (Placement(transformation(extent={{-74,-28},{-54,-8}})));
  Components.Sinks.Vessel vessel2
    annotation (Placement(transformation(extent={{68,-28},{88,-8}})));
  Modelica.Blocks.Sources.Constant TFlow2(
                                         k=273.15 + 60)
    annotation (Placement(transformation(extent={{-98,-2},{-82,12}})));
  Modelica.Blocks.Sources.Ramp mFlow2(
                                     height=1, duration=5000)
    annotation (Placement(transformation(extent={{-96,-26},{-82,-12}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature
    fixedTemperatureSurroundingAir5(T=288.15)
    annotation (Placement(transformation(extent={{-32,-10},{-16,6}})));
  Modelica.Blocks.Sources.Constant TFlow3(
                                         k=273.15 + 60)
    annotation (Placement(transformation(extent={{-98,62},{-82,76}})));
  Modelica.Blocks.Sources.Ramp mFlow3(
                                     height=1, duration=5000)
    annotation (Placement(transformation(extent={{-96,38},{-82,52}})));
  Components.Pumps.FluidSource fluidSource3
    annotation (Placement(transformation(extent={{-74,36},{-54,56}})));
  Components.Pipes.DynamicPipe PipeInsulation(
    withInsulation=true,
    withRadiation=false,
    withConvection=false)
    annotation (Placement(transformation(extent={{-16,32},{4,52}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature
    fixedTemperatureSurroundingAir1(T=288.15)
    annotation (Placement(transformation(extent={{-32,54},{-16,70}})));
  Components.Sinks.Vessel vessel3
    annotation (Placement(transformation(extent={{68,32},{88,52}})));
equation
  connect(TFlow1.y, fluidSource1.T_fluid) annotation (Line(points={{-83.2,-65},
          {-74,-65},{-74,-81.8}}, color={0,0,127}));
  connect(fixedTemperatureSurroundingAir2.port,
    PipeInsulationAndConvectionandRadiation.star) annotation (Line(points={{4,
          -68},{4,-80.8},{4.8,-80.8}}, color={191,0,0}));
  connect(fixedTemperatureSurroundingAir3.port,
    PipeInsulationAndConvectionandRadiation.heatPort_outside) annotation (
      Line(points={{-16,-68},{-16,-80.8},{-12.8,-80.8}}, color={191,0,0}));
  connect(TFlow2.y, fluidSource2.T_fluid) annotation (Line(points={{-81.2,5},
          {-72,5},{-72,-13.8}}, color={0,0,127}));
  connect(fixedTemperatureSurroundingAir5.port, PipeInsulationAndConvection.heatPort_outside)
    annotation (Line(points={{-16,-2},{-16,-12.8},{-14.8,-12.8}}, color={191,
          0,0}));
  connect(fluidSource2.enthalpyPort_b, PipeInsulationAndConvection.enthalpyPort_a1)
    annotation (Line(points={{-54,-17},{-43,-17},{-43,-18},{-15.8,-18}},
        color={176,0,0}));
  connect(fixedTemperatureSurroundingAir1.port, PipeInsulation.heatPort_outside)
    annotation (Line(points={{-16,62},{-16,47.2},{-14.8,47.2}}, color={191,0,
          0}));
  connect(TFlow3.y, fluidSource3.T_fluid) annotation (Line(points={{-81.2,69},
          {-81.2,59.5},{-72,59.5},{-72,50.2}}, color={0,0,127}));
  connect(fluidSource3.enthalpyPort_b, PipeInsulation.enthalpyPort_a1)
    annotation (Line(points={{-54,47},{-36,47},{-36,42},{-15.8,42}}, color={
          176,0,0}));
  connect(PipeInsulation.enthalpyPort_b1, vessel3.enthalpyPort_a)
    annotation (Line(points={{3.8,42},{71,42}}, color={176,0,0}));
  connect(PipeInsulationAndConvection.enthalpyPort_b1, vessel2.enthalpyPort_a)
    annotation (Line(points={{3.8,-18},{71,-18}}, color={176,0,0}));
  connect(fluidSource1.enthalpyPort_b,
    PipeInsulationAndConvectionandRadiation.enthalpyPort_a1) annotation (Line(
        points={{-56,-85},{-34,-85},{-34,-86},{-13.8,-86}}, color={176,0,0}));
  connect(PipeInsulationAndConvectionandRadiation.enthalpyPort_b1, vessel1.enthalpyPort_a)
    annotation (Line(points={{5.8,-86},{36,-86},{36,-84},{69,-84}}, color={
          176,0,0}));
  connect(mFlow3.y, fluidSource3.dotm) annotation (Line(points={{-81.3,45},{
          -77.65,45},{-77.65,43.4},{-72,43.4}}, color={0,0,127}));
  connect(mFlow2.y, fluidSource2.dotm) annotation (Line(points={{-81.3,-19},{
          -77.65,-19},{-77.65,-20.6},{-72,-20.6}}, color={0,0,127}));
  connect(mFlow1.y, fluidSource1.dotm) annotation (Line(points={{-83.3,-87},{
          -78.65,-87},{-78.65,-88.6},{-74,-88.6}}, color={0,0,127}));
  annotation (experiment(StopTime=5000), Diagram(graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-42,98},{30,96}},
          lineColor={238,46,47},
          fillColor={175,175,175},
          fillPattern=FillPattern.None,
          fontSize=14,
          textString="Dynamic pipes"),
        Text(
          extent={{-32,-50},{40,-52}},
          lineColor={28,108,200},
          fillColor={175,175,175},
          fillPattern=FillPattern.None,
          fontSize=14,
          textString="Insulation, convection and radiation"),
        Text(
          extent={{-38,20},{34,18}},
          lineColor={28,108,200},
          fillColor={175,175,175},
          fillPattern=FillPattern.None,
          fontSize=14,
          textString="Insulation and convection"),
        Line(points={{-102,-46},{98,-46}}, color={255,0,0}),
        Line(points={{-100,94},{100,94}}, color={255,0,0}),
        Line(points={{-100,24},{100,24}}, color={255,0,0}),
        Text(
          extent={{-40,90},{32,88}},
          lineColor={28,108,200},
          fillColor={175,175,175},
          fillPattern=FillPattern.None,
          fontSize=14,
          textString="Insulation only")}));
end Pipes;
