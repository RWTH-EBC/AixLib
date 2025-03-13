within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses;
model RadiativeConvectiveHeatTransfer
  "Model for radiative and convective heat transfer from single heat port"
  extends AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.RadiativeConvectiveHeatTransferParameters;

  parameter Modelica.Units.SI.Emissivity eps=0.95 "Emissivity";
  parameter Modelica.Units.SI.Area A(min=Modelica.Constants.eps)
    "Area of surface";

  AixLib.Utilities.HeatTransfer.HeatToRad twoStar_RadEx(
    final eps=eps,
    final T_ref=T_ref,
    final use_A_in=false,
    final A=A,
    final radCalcMethod=radCalcMethod)
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  AixLib.Utilities.HeatTransfer.HeatConvInside heatConv(
    final calcMethod=calcMethod,
    final dT_small=dT_small,
    final surfaceOrientation=surfaceOrientation,
    final A=A,
    final hCon_const=hCon_const)        annotation (Placement(transformation(
        origin={-2,-40},
        extent={{-12,-12},{12,12}},
        rotation=180)));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
             port_a annotation (Placement(transformation(extent={{-110,-10},{-90,
            10}})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
             portRad "Radiative heat port"
                    annotation (Placement(transformation(extent={{90,30},{110,
            50}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a portCon
    "Convective heat port"
    annotation (Placement(transformation(extent={{90,-50},{110,-30}})));

equation
  connect(port_a, heatConv.port_b) annotation (Line(points={{-100,0},{-78,0},{-78,
          -40},{-14,-40}}, color={191,0,0}));
  connect(twoStar_RadEx.convPort, port_a) annotation (Line(points={{-10,40},{-78,
          40},{-78,0},{-100,0}}, color={191,0,0}));
  connect(twoStar_RadEx.radPort, portRad)
    annotation (Line(points={{10.1,40},{100,40}}, color={0,0,0}));
  connect(heatConv.port_a, portCon)
    annotation (Line(points={{10,-40},{100,-40}}, color={191,0,0}));
  annotation (Icon(graphics={
        Rectangle(
          extent={{2,60},{22,-100}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={156,156,156},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{22,60},{42,-100}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={182,182,182},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{42,60},{62,-100}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={207,207,207},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{62,60},{82,-100}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={244,244,244},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-78,60},{2,-100}},
          lineColor={0,255,255},
          fillColor={211,243,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{82,60},{82,60},{62,20},{62,60},{82,60}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          lineThickness=0.5,
          fillColor={157,166,208},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{62,60},{62,20},{42,-20},{42,60},{62,60}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          lineThickness=0.5,
          fillColor={102,110,139},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{42,60},{42,-20},{22,-60},{22,60},{42,60}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          lineThickness=0.5,
          fillColor={75,82,103},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{22,60},{22,-60},{2,-100},{2,60},{22,60}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          lineThickness=0.5,
          fillColor={51,56,70},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-18,16},{-18,-64}},
          color={0,0,255},
          thickness=0.5),
        Line(
          points={{-18,16},{-28,4}},
          color={0,0,255},
          thickness=0.5),
        Line(
          points={{-36,16},{-46,4}},
          color={0,0,255},
          thickness=0.5),
        Line(
          points={{-52,16},{-62,4}},
          color={0,0,255},
          thickness=0.5),
        Line(
          points={{-36,16},{-36,-64}},
          color={0,0,255},
          thickness=0.5),
        Line(
          points={{-52,16},{-52,-64}},
          color={0,0,255},
          thickness=0.5),
        Rectangle(extent={{-78,60},{82,-100}}, lineColor={0,0,0}),                                                                              Text(extent={{-54,116},
              {84,6}},                                                                                                                                                                lineColor = {0, 0, 0},  pattern = LinePattern.None, fillColor = {135, 150, 177},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "2*")}));
end RadiativeConvectiveHeatTransfer;
