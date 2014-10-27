within AixLib.Building.LowOrder.BaseClasses.ImprovedLowOrderModel;
model ImprovedReducedOrderModel
  extends partialLOM;

   parameter Modelica.SIunits.ThermalResistance RWin=0.017727777777
    "Resistor Window"
   annotation(Dialog(tab="Outer walls",group = "Windows",enable = if withWindows then true else false));
   parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaWin=3.16
    "Coefficient of convective heat transfer (Window)"
   annotation(Dialog(tab="Outer walls",group = "Windows",enable = if withWindows then true else false));

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
  Utilities.HeatTransfer.HeatToStar heatToStarOuterwall(A=Ao - Aw, eps=epso)
    annotation (Placement(transformation(extent={{-48,16},{-36,28}})));
  Utilities.HeatTransfer.HeatToStar heatToStarInnerwall(A=Ai, eps=epsi)
    annotation (Placement(transformation(extent={{52,16},{40,28}})));
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
  end if;

  connect(heatToStarOuterwall.Therm, outerwall.port_b) annotation (Line(
      points={{-47.52,22},{-50,22},{-50,-0.909091}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(heatToStarOuterwall.Star, heatToStarInnerwall.Star) annotation (Line(
      points={{-36.54,22},{40.54,22}},
      color={95,95,95},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(heatToStarInnerwall.Therm, innerwall.port_a) annotation (Line(
      points={{51.52,22},{56,22},{56,-0.909091}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(heatToStarWinRes.Star, heatToStarInnerwall.Star) annotation (Line(
      points={{-38.45,51},{2,51},{2,22},{40.54,22}},
      color={95,95,95},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics), Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics));
end ImprovedReducedOrderModel;
