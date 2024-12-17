within AixLib.Utilities.KPIs.BaseClasses;
partial model PartialTemperatureAssessment
  "Partial model for temperature assessment"
  extends Modelica.Icons.UnderConstruction;
  Modelica.Blocks.Interfaces.RealInput T(final unit="K", final min=0)
    "Temperature input"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput degSecOutUppBou(final unit="K.s")
    "Degree-second greater than upper bound"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput degSecOutLowBou(final unit="K.s")
    "Degree-second less than lower bound"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  Modelica.Blocks.Interfaces.RealOutput absDegSecOutBou(final unit="K.s")
    "Absolute degree-second out of bound"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  IntegralErrorDualBounds intlErrDuaBou
    "Integral temperature error with dual bounds"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
equation
  connect(T, intlErrDuaBou.u)
    annotation (Line(points={{-120,0},{-24,0}}, color={0,0,127}));
  connect(intlErrDuaBou.yUpp, degSecOutUppBou) annotation (Line(points={{22,12},
          {80,12},{80,60},{110,60}}, color={0,0,127}));
  connect(intlErrDuaBou.yAbsTot, absDegSecOutBou)
    annotation (Line(points={{22,0},{110,0}}, color={0,0,127}));
  connect(intlErrDuaBou.yLow, degSecOutLowBou) annotation (Line(points={{22,-12},
          {80,-12},{80,-60},{110,-60}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PartialTemperatureAssessment;
