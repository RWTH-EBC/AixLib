within AixLib.Building.LowOrder.BaseClasses.ImprovedLowOrderModel;
model ReducedOrderModel
  extends partialLOM;
  Utilities.HeatTransfer.HeatToStar heatToStarWindow(A=Aw, eps=epsw) if withWindows
    annotation (Placement(transformation(extent={{-16,72},{4,92}})));
  Utilities.HeatTransfer.HeatToStar heatToStarOuterwall(A=Ao, eps=epso) if withOuterwalls
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-46,28})));
  Utilities.HeatTransfer.HeatToStar heatToStarInnerwall(A=Ai, eps=epsi) if withInnerwalls
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,28})));
equation
  if withWindows and withOuterwalls then
  connect(solarRadToHeatWindowRad.heatPort, heatToStarWindow.Therm) annotation (
     Line(
      points={{-27,90},{-22,90},{-22,82},{-15.2,82}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(heatToStarWindow.Star, internalGainsRad) annotation (Line(
      points={{3.1,82},{12,82},{12,45},{80,45},{80,-90}},
      color={95,95,95},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  end if;

  if withOuterwalls then
      connect(outerwall.port_b, heatToStarOuterwall.Therm) annotation (Line(
      points={{-50,-0.909091},{-46,-0.909091},{-46,18.8}},
      color={191,0,0},
      smooth=Smooth.None));

  connect(heatToStarOuterwall.Star, internalGainsRad) annotation (Line(
      points={{-46,37.1},{-14,37.1},{-14,37},{12,37},{12,45},{80,45},{80,-90}},
      color={95,95,95},
      pattern=LinePattern.None,
      smooth=Smooth.None));

  end if;

  if withInnerwalls then
      connect(heatToStarInnerwall.Star, internalGainsRad) annotation (Line(
      points={{50,37.1},{12,37.1},{12,45},{80,45},{80,-90}},
      color={95,95,95},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(heatToStarInnerwall.Therm, innerwall.port_a) annotation (Line(
      points={{50,18.8},{54,18.8},{54,-0.909091},{56,-0.909091}},
      color={191,0,0},
      smooth=Smooth.None));
  end if;

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end ReducedOrderModel;
