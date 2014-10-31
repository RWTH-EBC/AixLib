within AixLib.Building.LowOrder.BaseClasses;
model ReducedOrderModelImproved
  import AixLib;
  extends AixLib.Building.LowOrder.BaseClasses.PartialClasses.partialLOM;

   parameter Modelica.SIunits.ThermalResistance RWin=0.017727777777
    "Resistor Window"
   annotation(Dialog(tab="Outer walls",group = "Windows",enable = if withWindows then true else false));
   parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaWin=3.16
    "Coefficient of convective heat transfer (Window)"
   annotation(Dialog(tab="Outer walls",group = "Windows",enable = if withWindows then true else false));
protected
  parameter Integer dimension_help = if withInnerwalls then 2 else 1;
  parameter Real vector_help1[dimension_help]= if withInnerwalls then {(Ao - Aw)/(Ao + Ai - Aw),(Ai)/(Ao + Ai - Aw)} else {(Ao - Aw)/(Ao + Ai - Aw)};
  parameter Real vector_help2[dimension_help]= if withInnerwalls then {(Ao)/(Ao + Ai),(Ai)/(Ao + Ai)} else {(Ao)/(Ao + Ai)};
public
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a equalAirTempWindow if withWindows
    annotation (Placement(transformation(extent={{-108,19},{-72,55}}),
        iconTransformation(extent={{-100,34},{-60,74}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResWindow(R=
        RWin) if withWindows annotation (Placement(transformation(extent={{-66,42},{-56,52}})));
  Utilities.HeatTransfer.HeatConv heatConvWinRes(alpha=alphaWin, A=Aw) if
                                                    withWindows
    annotation (Placement(transformation(extent={{-48,32},{-38,42}})));
  Utilities.HeatTransfer.HeatToStar heatToStarWinRes(A=Aw, eps=epsw) if
                                                        withWindows
    annotation (Placement(transformation(extent={{-48,46},{-38,56}})));
  Utilities.HeatTransfer.HeatToStar heatToStarOuterwall(A=Ao - Aw, eps=epso) if withOuterwalls
    annotation (Placement(transformation(extent={{-48,16},{-36,28}})));
  Utilities.HeatTransfer.HeatToStar heatToStarInnerwall(A=Ai, eps=epsi) if withInnerwalls
    annotation (Placement(transformation(extent={{52,16},{40,28}})));
  AixLib.Building.LowOrder.BaseClasses.SplitterThermPercentAir
    splitterThermPercentAir(ZoneFactor=vector_help1, dimension=dimension_help)
    annotation (Placement(transformation(extent={{-14,80},{6,100}})));
  AixLib.Building.LowOrder.BaseClasses.SplitterThermPercentAir
    splitterThermPercentAir1(dimension=dimension_help, ZoneFactor=vector_help2)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={94,0})));

equation
  if withWindows and withOuterwalls then
  connect(equalAirTempWindow, thermalResWindow.port_a) annotation (Line(
      points={{-90,37},{-78,37},{-78,47},{-66,47}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(thermalResWindow.port_b, heatToStarWinRes.Therm) annotation (Line(
      points={{-56,47},{-52,47},{-52,51},{-47.6,51}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(thermalResWindow.port_b, heatConvWinRes.port_a) annotation (Line(
      points={{-56,47},{-52,47},{-52,37},{-48,37}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(heatConvWinRes.port_b, airload.port) annotation (Line(
      points={{-38,37},{-7,37},{-7,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(solarRadToHeatWindowRad.heatPort, splitterThermPercentAir.signalInput)
    annotation (Line(
      points={{-27,90},{-14,90}},
      color={191,0,0},
      smooth=Smooth.None));
  end if;

  if withInnerwalls then
    connect(heatToStarInnerwall.Therm, innerwall.port_a) annotation (Line(
      points={{51.52,22},{56,22},{56,-0.909091}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(heatToStarWinRes.Star, heatToStarInnerwall.Star) annotation (Line(
      points={{-38.45,51},{2,51},{2,22},{40.54,22}},
      color={95,95,95},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(heatToStarOuterwall.Star, heatToStarInnerwall.Star) annotation (Line(
      points={{-36.54,22},{40.54,22}},
      color={95,95,95},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(splitterThermPercentAir1.signalOutput[2], innerwall.port_a)
    annotation (Line(
      points={{94,10},{94,16},{56,16},{56,-0.909091}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(splitterThermPercentAir.signalOutput[2], innerwall.port_a)
    annotation (Line(
      points={{6,90},{56,90},{56,-0.909091}},
      color={191,0,0},
      smooth=Smooth.None));
  end if;

  connect(heatToStarOuterwall.Therm, outerwall.port_b) annotation (Line(
      points={{-47.52,22},{-50,22},{-50,-0.909091}},
      color={191,0,0},
      smooth=Smooth.None));

  connect(internalGainsRad, splitterThermPercentAir1.signalInput) annotation (
      Line(
      points={{80,-90},{80,-26},{94,-26},{94,-10}},
      color={95,95,95},
      pattern=LinePattern.None,
      smooth=Smooth.None));

  connect(splitterThermPercentAir1.signalOutput[1], outerwall.port_b)
    annotation (Line(
      points={{94,10},{94,30},{-50,30},{-50,-0.909091}},
      color={191,0,0},
      smooth=Smooth.None));

  connect(splitterThermPercentAir.signalOutput[1], outerwall.port_b)
    annotation (Line(
      points={{6,90},{6,30},{-50,30},{-50,-0.909091}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics), Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics),
    Documentation(revisions="<html>
<p><ul>
<li><i>October 2014,&nbsp;</i> by Peter Remmen:<br/>Implemented.</li>
</ul></p>
</html>"));
end ReducedOrderModelImproved;
