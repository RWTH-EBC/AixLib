within AixLib.Building.LowOrder.BaseClasses.ReducedOrderModel;
model ReducedOrderModelVDI
  extends ReducedOrderModel.partialReducedOrderModel;

parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaRad=5
    "Radiative Coefficient of heat transfer between inner and outer walls"
annotation(Dialog(tab="Inner walls",enable = if withInnerwalls then true else false));
protected
  parameter Integer dimension_help = if withInnerwalls then 2 else 1;
  parameter Real vector_help1[dimension_help]= if withInnerwalls then {(Ao - Aw)/(Ao + Ai - Aw),(Ai)/(Ao + Ai - Aw)} else {(Ao - Aw)/(Ao + Ai - Aw)};
  parameter Real vector_help2[dimension_help]= if withInnerwalls then {(Ao)/(Ao + Ai),(Ai)/(Ao + Ai)} else {(Ao)/(Ao + Ai)};

  SplitterThermPercentAir
    splitterThermPercentAir(ZoneFactor=vector_help1, dimension=dimension_help)
    annotation (Placement(transformation(extent={{-12,80},{8,100}})));
  SplitterThermPercentAir
    splitterThermPercentAir1(dimension=dimension_help, ZoneFactor=vector_help2)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={92,4})));
  Utilities.HeatTransfer.HeatConv radHeatTrans( alpha=alphaRad, A=Ao) if withInnerwalls
    annotation (Placement(transformation(extent={{0,10},{20,30}})));
equation

if withWindows and withOuterwalls then

  connect(solarRadToHeatWindowRad.heatPort, splitterThermPercentAir.signalInput)
    annotation (Line(
      points={{-27,90},{-12,90}},
      color={191,0,0},
      smooth=Smooth.None));
end if;

if withInnerwalls then
    connect(outerwall.port_b, radHeatTrans.port_a) annotation (Line(
      points={{-50,-0.909091},{-50,20},{0,20}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(radHeatTrans.port_b, innerwall.port_a) annotation (Line(
      points={{20,20},{56,20},{56,-0.909091}},
      color={191,0,0},
      smooth=Smooth.None));
end if;

  connect(splitterThermPercentAir1.signalInput, internalGainsRad) annotation (
      Line(
      points={{92,-6},{94,-6},{94,-66},{80,-66},{80,-90}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(splitterThermPercentAir1.signalOutput[2], innerwall.port_a)
    annotation (Line(
      points={{92,14},{92,16},{56,16},{56,-0.909091}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(splitterThermPercentAir1.signalOutput[1], outerwall.port_b)
    annotation (Line(
      points={{92,14},{92,32},{-50,32},{-50,-0.909091}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(splitterThermPercentAir.signalOutput[1], outerwall.port_b)
    annotation (Line(
      points={{8,90},{12,90},{12,32},{-50,32},{-50,-0.909091}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(splitterThermPercentAir.signalOutput[2], innerwall.port_a)
    annotation (Line(
      points={{8,90},{56,90},{56,-0.909091}},
      color={191,0,0},
      smooth=Smooth.None));

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end ReducedOrderModelVDI;
