within ControlUnity.twoPositionController;
model twoPositionControllerSimple_modularBoiler "Simple two position controller"
  extends ControlUnity.twoPositionController.BaseClass.partialTwoPositionController;

  parameter Modelica.SIunits.Temperature T_ref=273.15+60 "Solltemperatur";
  parameter Real bandwidth=0 "Bandbreite"; //bandwidth=Abgrenzung nach unten und oben, z.B; bandwidth=2 58,60,62

  Modelica.Blocks.Sources.RealExpression realExpression1
    annotation (Placement(transformation(extent={{-88,-20},{-68,0}})));
equation

  connect(TLayers[1], add.u1) annotation (Line(points={{-100,22.6667},{-52,
          22.6667},{-52,52},{-2,52}},
                        color={0,0,127}));
  connect(realExpression1.y, add.u2) annotation (Line(points={{-67,-10},{-36,
          -10},{-36,40},{-2,40}}, color={0,0,127}));
    annotation (Placement(transformation(extent={{-122,0},{-82,40}})),
    Documentation(info="<html>
<p>-pre_y_start wurde auf true gesetzt, s.d. der Kessel auch zwischen 58&deg;C und 62&deg;C eingeschaltet ist.</p>
</html>"));
end twoPositionControllerSimple_modularBoiler;
