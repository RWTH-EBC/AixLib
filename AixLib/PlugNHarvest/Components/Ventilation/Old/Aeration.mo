within AixLib.PlugNHarvest.Components.Ventilation.Old;
model Aeration
  extends
    PlugNHarvest.Components.Ventilation.BaseClasses.PartialVentilationOutside;

  parameter Boolean withFan = true;
  parameter Boolean withInfiltration = true;
  Old.FanUnit fanUnit(
    redeclare package Medium = Medium,
    V_flow_nom=V_flow_nom,
    DV_flowDp=DV_flowDp) if                                                                         withFan
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Old.Infiltration infiltration(
    redeclare package Medium = Medium,
    q50=q50,
    wall_length=wall_length,
    wall_height=wall_height) if                                                                                              withInfiltration
    annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));

  parameter Modelica.SIunits.Velocity q50 = 1;
  parameter Modelica.SIunits.Length wall_length = 1;
  parameter Modelica.SIunits.Height wall_height = 1;
  parameter Real V_flow_nom(final unit="m3/h")=40 "nominal volume flow";
  parameter Real DV_flowDp(final unit="m3/(Pa.h)")=1 "gradient of the fan's characteristic curve";
  Modelica.Fluid.Sources.MassFlowSource_h boundary(redeclare package Medium = Medium, nPorts=1) if not withInfiltration and not withFan
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  if withFan then
  connect(fanUnit.port_b, port_b) annotation (Line(points={{10,50},{50,50},
            {50,0},{100,0}},
                           color={0,127,255}));
  end if;

  if withInfiltration then
  connect(infiltration.port_b, port_b) annotation (Line(points={{10,-50},{50,-50},
            {50,0},{100,0}},
                           color={0,127,255}));
  end if;
  connect(boundary.ports[1], port_b)
    annotation (Line(points={{10,0},{100,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Polygon(
          points={{-68,90},{-50,74},{-48,50},{-78,80},{-68,90}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          smooth=Smooth.Bezier),
        Polygon(
          points={{2,1.22465e-016},{2,14},{-40,14},{-20,-2},{2,1.22465e-016}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          origin={-34,90},
          rotation=90,
          lineColor={0,0,0},
          smooth=Smooth.Bezier),
        Polygon(
          points={{-48,50},{-24,52},{-8,70},{-18,80},{-48,50}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          smooth=Smooth.Bezier),
        Polygon(
          points={{-6,36},{-6,50},{-48,50},{-28,34},{-6,36}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          smooth=Smooth.Bezier),
        Polygon(
          points={{-28,10},{-46,26},{-48,50},{-18,20},{-28,10}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          smooth=Smooth.Bezier),
        Polygon(
          points={{-2,-1.22465e-016},{-2,-14},{40,-14},{20,2},{-2,
              -1.22465e-016}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          origin={-62,10},
          rotation=90,
          lineColor={0,0,0},
          smooth=Smooth.Bezier),
        Polygon(
          points={{-48,50},{-72,48},{-88,30},{-78,20},{-48,50}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          smooth=Smooth.Bezier),
        Polygon(
          points={{-90,64},{-90,50},{-48,50},{-68,66},{-90,64}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          smooth=Smooth.Bezier),
        Ellipse(
          extent={{-60,62},{-36,38}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Ellipse(
          extent={{-56,58},{-40,42}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{32,-10},{68,-90}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{20,-64},{40,-54},{60,-64},{80,-54},{80,-60},{60,-70},{40,
              -60},{20,-70},{20,-64}},
          lineColor={0,0,0},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          smooth=Smooth.Bezier),
        Polygon(
          points={{20,-52},{40,-42},{60,-52},{80,-42},{80,-48},{60,-58},{40,
              -48},{20,-58},{20,-52}},
          lineColor={0,0,0},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          smooth=Smooth.Bezier),
        Polygon(
          points={{20,-40},{40,-30},{60,-40},{80,-30},{80,-36},{60,-46},{40,
              -36},{20,-46},{20,-40}},
          lineColor={0,0,0},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          smooth=Smooth.Bezier),
        Line(points={{0,100},{0,-100}}, color={0,0,0}),
        Line(points={{-100,0},{100,0}}, color={0,0,0}),
        Rectangle(
          extent={{-98,4},{-2,2}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-98,98},{-2,96}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-98,98},{-2,2}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          visible= not withFan),
        Rectangle(
          extent={{2,-2},{98,-98}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          visible= not withInfiltration)}),                                                                                Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Aeration;
