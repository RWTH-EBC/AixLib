within ControlUnity.twoPositionController;
model twoPositionControllerSimple_modularBoiler "Simple two position controller"
  extends ControlUnity.twoPositionController.BaseClass.partialTwoPositionController(n=1,
      onOffController(bandwidth=2.5,
                      pre_y_start=false));

  parameter Modelica.SIunits.Temperature T_ref=273.15+70 "Solltemperatur";
  parameter Real bandwidth=0 "Bandbreite"; //bandwidth=Abgrenzung nach unten und oben, z.B; bandwidth=2 58,60,62

equation

  connect(TLayers[1], onOffController.u) annotation (Line(points={{-100,-22},{
          -36,-22},{-36,0},{32,0}}, color={0,0,127}));
    annotation (Placement(transformation(extent={{-122,0},{-82,40}})),
    Documentation(info="<html>
<p>-pre_y_start wurde auf true gesetzt, s.d. der Kessel auch zwischen 58&deg;C und 62&deg;C eingeschaltet ist.</p>
</html>"));
end twoPositionControllerSimple_modularBoiler;
