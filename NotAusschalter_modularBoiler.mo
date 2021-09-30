within ;
model NotAusschalter_modularBoiler
                                   //Notausschaltung bei Überschreitung der Grenztemperatur und Abschaltung bei Unterschreitung von PLRmin
  parameter Modelica.SIunits.Temperature THotMax=273.15+90 "Grenztemperatur, ab der das System abgeschaltet wird";
  parameter Real PLRmin=0.15 "Minimal zulässiges PLR";

  Modelica.Blocks.Logical.Greater greater
    annotation (Placement(transformation(extent={{-56,20},{-36,40}})));
  Modelica.Blocks.Sources.RealExpression tHotMax(y=THotMax)
    annotation (Placement(transformation(extent={{-102,12},{-82,32}})));
  Modelica.Blocks.Interfaces.RealInput T_ein
    annotation (Placement(transformation(extent={{-120,32},{-80,72}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{34,20},{54,40}})));
  Modelica.Blocks.Sources.RealExpression realExpression
    annotation (Placement(transformation(extent={{-100,70},{-80,90}})));
  Modelica.Blocks.Interfaces.RealInput PLR_ein
    annotation (Placement(transformation(extent={{-120,-32},{-80,8}})));
  Modelica.Blocks.Interfaces.RealOutput PLR_set
    annotation (Placement(transformation(extent={{90,20},{110,40}})));
equation

  connect(tHotMax.y, greater.u2)
    annotation (Line(points={{-81,22},{-58,22}}, color={0,0,127}));
  connect(T_ein, greater.u1) annotation (Line(points={{-100,52},{-80,52},{-80,30},
          {-58,30}}, color={0,0,127}));
  connect(greater.y, switch1.u2)
    annotation (Line(points={{-35,30},{32,30}}, color={255,0,255}));
  connect(realExpression.y, switch1.u1) annotation (Line(points={{-79,80},{-10,80},
          {-10,38},{32,38}},
                           color={0,0,127}));
  connect(switch1.y, PLR_set)
    annotation (Line(points={{55,30},{100,30}}, color={0,0,127}));
  connect(PLR_ein, switch1.u3) annotation (Line(points={{-100,-12},{18,-12},{18,
          22},{32,22}}, color={0,0,127}));
  annotation (uses(Modelica(version="3.2.3")));
end NotAusschalter_modularBoiler;
