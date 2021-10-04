within Regelungseinheit.BaseClass.twoPositionControllerCal;
model twoPositionController_top
  "Calculation of the temperature of the buffer storage with the temperature on the top level"
  extends Regelungseinheit.BaseClass.partialTwoPositionController(
      realExpression(y=Tref),
      layerCal=false);
  parameter Modelica.SIunits.Temperature Tref=273.15+60 "Reference temperature for two position controller using top level temperature";
  parameter Modelica.SIunits.Temperature Ttop=273.15+70 "Temperature on the top level of the buffer storage";

  Modelica.Blocks.Sources.RealExpression realExpression1(y=Ttop)
    annotation (Placement(transformation(extent={{-100,-42},{-80,-22}})));
equation
  connect(realExpression1.y, add.u2) annotation (Line(points={{-79,-32},{-34,-32},
          {-34,20},{10,20}}, color={0,0,127}));
  connect(TTop, add.u1) annotation (Line(points={{-100,0},{-56,0},{-56,32},{10,
          32}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end twoPositionController_top;
