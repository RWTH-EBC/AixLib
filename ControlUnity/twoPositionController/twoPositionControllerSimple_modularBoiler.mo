within ControlUnity.twoPositionController;
model twoPositionControllerSimple_modularBoiler

  parameter Modelica.SIunits.Temperature T_ref=273.15+60 "Solltemperatur";
  parameter Real bandwidth=0 "Bandbreite"; //bandwidth=Abgrenzung nach unten und oben, z.B; bandwidth=2 58,60,62

  Modelica.Blocks.Logical.OnOffController onOffController(
  bandwidth=bandwidth, pre_y_start=true)
    annotation (Placement(transformation(extent={{-54,24},{-34,44}})));

  Modelica.Blocks.Sources.RealExpression T_reference(y=T_ref)
    annotation (Placement(transformation(extent={{-96,38},{-76,58}})));

  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-4,24},{16,44}})));
  Modelica.Blocks.Sources.RealExpression realZero
    annotation (Placement(transformation(extent={{-102,-30},{-82,-10}})));
  Modelica.Blocks.Interfaces.RealInput PLR_ein
    annotation (Placement(transformation(extent={{-120,70},{-80,110}})));
  Modelica.Blocks.Interfaces.RealOutput PLR_aus
    annotation (Placement(transformation(extent={{90,24},{110,44}})));
  Modelica.Blocks.Interfaces.RealInput T_ein(quantity="ThermodynamicTemperature",unit="K")
    annotation (Placement(transformation(extent={{-120,8},{-80,48}})));
equation

  connect(T_reference.y, onOffController.reference)
    annotation (Line(points={{-75,48},{-62,48},{-62,40},{-56,40}},
                                               color={0,0,127}));
  connect(onOffController.y, switch1.u2)
    annotation (Line(points={{-33,34},{-6,34}}, color={255,0,255}));
  connect(switch1.y, PLR_aus)
    annotation (Line(points={{17,34},{100,34}}, color={0,0,127}));
  connect(T_ein, onOffController.u)
    annotation (Line(points={{-100,28},{-56,28}}, color={0,0,127}));
  connect(realZero.y, switch1.u3) annotation (Line(points={{-81,-20},{-16,-20},
          {-16,26},{-6,26}},
                        color={0,0,127}));
  connect(PLR_ein, switch1.u1) annotation (Line(points={{-100,90},{-16,90},{-16,
          42},{-6,42}}, color={0,0,127}));
    annotation (Placement(transformation(extent={{-122,0},{-82,40}})),
    Documentation(info="<html>
<p>-pre_y_start wurde auf true gesetzt, s.d. der Kessel auch zwischen 58&deg;C und 62&deg;C eingeschaltet ist.</p>
</html>"));
end twoPositionControllerSimple_modularBoiler;
