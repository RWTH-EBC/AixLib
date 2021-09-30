within ;
model PIRegelung_Tester
  extends Modelica.Icons.Example;


  vorlauftemperaturRegelung_modularBoiler
    vorlauftemperaturRegelung_modularBoiler1
    annotation (Placement(transformation(extent={{-42,0},{-22,20}})));
  PIRegler_modularBoiler pIRegler_modularBoiler
    annotation (Placement(transformation(extent={{20,0},{40,20}})));
  Modelica.Blocks.Sources.RealExpression T(y=273.15 + 23)
    annotation (Placement(transformation(extent={{-22,-32},{-2,-12}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=-5,
    duration=15,
    offset=273.15,
    startTime=10)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
equation

  connect(T.y, pIRegler_modularBoiler.T_m) annotation (Line(points={{-1,-22},{10,
          -22},{10,7},{20,7}}, color={0,0,127}));
  connect(vorlauftemperaturRegelung_modularBoiler1.T_Vorlauf,
    pIRegler_modularBoiler.Tset) annotation (Line(points={{-22,9},{-2,9},{-2,15},
          {20,15}}, color={0,0,127}));
  connect(ramp.y, vorlauftemperaturRegelung_modularBoiler1.T_outdoor)
    annotation (Line(points={{-79,10},{-60,10},{-60,9},{-42,9}}, color={0,0,127}));
  annotation (uses(Modelica(version="3.2.3")));
end PIRegelung_Tester;
