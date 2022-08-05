within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating;
model HOMRadConvAdaptor

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
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Utilities.HeatTransfer.HeatConvInside        heatConv(
    final dT_small=dT_small,
    final A=A,
    final hCon_const=hCon_const,
    final calcMethod=calcMethod,
    final surfaceOrientation=surfaceOrientation)        annotation (Placement(transformation(
        origin={-50,-30},
        extent={{-12,-12},{12,12}},
        rotation=180)));
  Utilities.Interfaces.ConvRadComb heatFloor annotation (Placement(
        transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={{90,-10},
            {110,10}})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
             port_a annotation (Placement(transformation(extent={{-110,-10},{-90,
            10}})));
  Utilities.Interfaces.Adaptors.ConvRadToCombPort convRadToCombPort annotation (
     Placement(transformation(
        extent={{-10,8},{10,-8}},
        rotation=180,
        origin={10,0})));

equation
  connect(port_a, heatConv.port_b) annotation (Line(points={{-100,0},{-68,0},{-68,
          -30},{-62,-30}}, color={191,0,0}));
  connect(twoStar_RadEx.convPort, port_a) annotation (Line(points={{-60,30},{-68,
          30},{-68,0},{-100,0}}, color={191,0,0}));
  connect(heatConv.port_a, convRadToCombPort.portConv) annotation (Line(points={
          {-38,-30},{-6,-30},{-6,-5},{0,-5}}, color={191,0,0}));
  connect(convRadToCombPort.portRad, twoStar_RadEx.radPort) annotation (Line(
        points={{0,5},{0,4},{-34,4},{-34,30},{-39.9,30}}, color={0,0,0}));
  connect(convRadToCombPort.portConvRadComb, heatFloor) annotation (Line(points=
         {{20,-1.11022e-15},{60,-1.11022e-15},{60,0},{100,0}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HOMRadConvAdaptor;
