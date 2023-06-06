within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses;
model RadiativeConvectiveHeatTransfer
  "Model for radiative and convective heat transfer from single heat port"

  parameter Modelica.Units.SI.Emissivity eps=0.95 "Emissivity";
  parameter Modelica.Units.SI.Temperature T_ref=
      Modelica.Units.Conversions.from_degC(16)
    "Reference temperature for optional linearization"
    annotation (Dialog(enable=radCalcMethod == 4));

  parameter Integer radCalcMethod=1 "Calculation method for radiation heat transfer" annotation (
    Evaluate=true,
    Dialog(group = "Radiation exchange equation", compact=true),
    choices(
      choice=1 "No approx",
      choice=2 "Linear approx at wall temp",
      choice=3 "Linear approx at rad temp",
      choice=4 "Linear approx at constant T_ref",
      radioButtons=true));
 parameter Integer calcMethod=2 "Calculation method for convective heat transfer coefficient" annotation (
    Dialog(descriptionLabel=true),
    choices(
      choice=1 "EN ISO 6946 Appendix A >>Flat Surfaces<<",
      choice=2 "By Bernd Glueck",
      choice=3 "Custom hCon (constant)",
      choice=4 "ASHRAE140-2017",
      radioButtons=true),
    Evaluate=true);

  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hCon_const=2.5
    "Custom convective heat transfer coefficient" annotation (Dialog(
        descriptionLabel=true, enable=if calcMethod == 3 then true else false));

  parameter Modelica.Units.SI.TemperatureDifference dT_small=0.1
    "Linearized function around dT = 0 K +/-" annotation (Dialog(
        descriptionLabel=true, enable=if calcMethod == 1 or calcMethod == 2 or
          calcMethod == 4 then true else false));

  // which orientation of surface?
  parameter Integer surfaceOrientation "Surface orientation" annotation (
      Dialog(descriptionLabel=true, enable=if calcMethod == 3 then false else true),
      choices(
      choice=1 "vertical",
      choice=2 "horizontal facing up",
      choice=3 "horizontal facing down",
      radioButtons=true),
      Evaluate=true);
  parameter Modelica.Units.SI.Area A(min=Modelica.Constants.eps)
    "Area of surface";

  Utilities.HeatTransfer.HeatToRad twoStar_RadEx(
    final eps=eps,
    final T_ref=T_ref,
    final use_A_in=false,
    final A=A,
    final radCalcMethod=radCalcMethod)
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  Utilities.HeatTransfer.HeatConvInside        heatConv(
    final dT_small=dT_small,
    final A=A,
    final hCon_const=hCon_const,
    final calcMethod=calcMethod,
    final surfaceOrientation=surfaceOrientation)        annotation (Placement(transformation(
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
