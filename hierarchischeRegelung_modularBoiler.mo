within ;
model hierarchischeRegelung_modularBoiler
  parameter Real PLRmin=0.15;
  parameter Boolean use_erweiterteRegelung=true "Auswahl zwischen Zweipunktregelung und Vorlauftemperaturregelung";

  Modelica.Blocks.Interfaces.RealInput T_ein
    annotation (Placement(transformation(extent={{-120,50},{-80,90}})));
  Modelica.Blocks.Interfaces.RealOutput PLR_set
    annotation (Placement(transformation(extent={{90,64},{110,84}})));
  Modelica.Blocks.Interfaces.RealInput PLR_ein
    annotation (Placement(transformation(extent={{-120,-12},{-80,28}})));
  Modelica.Blocks.Interfaces.RealOutput T_set if use_erweiterteRegelung
    annotation (Placement(transformation(extent={{90,-20},{110,0}})));
  NotAusschalter_modularBoiler notAusschalter_modularBoiler
    annotation (Placement(transformation(extent={{-60,26},{-40,46}})));
  zweipunktRegler_modularBoiler zweipunktRegler_modularBoiler1(bandwidth=2) if not use_erweiterteRegelung
    annotation (Placement(transformation(extent={{0,60},{20,80}})));
  vorlauftemperaturRegelung_modularBoiler
    vorlauftemperaturRegelung_modularBoiler1 if use_erweiterteRegelung
    annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{44,-62},{64,-42}})));
  Modelica.Blocks.Interfaces.RealInput mFlow_rel
    annotation (Placement(transformation(extent={{-120,-80},{-80,-40}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=PLRmin)
    annotation (Placement(transformation(extent={{-6,-54},{14,-34}})));
  Modelica.Blocks.Interfaces.RealInput T_outdoor if  use_erweiterteRegelung "Außentemperatur"
    annotation (Placement(transformation(extent={{-120,-44},{-80,-4}})));
  Modelica.Blocks.Interfaces.RealOutput mFlow_relB
    annotation (Placement(transformation(extent={{90,-62},{110,-42}})));
equation

  connect(T_ein, notAusschalter_modularBoiler.T_ein) annotation (Line(points={{-100,
          70},{-82,70},{-82,41.2},{-60,41.2}}, color={0,0,127}));
  connect(PLR_ein, notAusschalter_modularBoiler.PLR_ein) annotation (Line(
        points={{-100,8},{-82,8},{-82,34.8},{-60,34.8}},     color={0,0,127}));

    if use_erweiterteRegelung then
  connect(vorlauftemperaturRegelung_modularBoiler1.T_Vorlauf, T_set)
    annotation (Line(points={{20,-11},{60,-11},{60,-10},{100,-10}},
                                                  color={0,0,127}));
  connect(notAusschalter_modularBoiler.PLR_set,
    vorlauftemperaturRegelung_modularBoiler1.PLR_ein) annotation (Line(points={{-40,39},
            {-22,39},{-22,-3},{0,-3}},       color={0,0,127}));
    connect(vorlauftemperaturRegelung_modularBoiler1.PLR_aus, PLR_set)
    annotation (Line(points={{20.4,-3},{74,-3},{74,74},{100,74}}, color={0,0,127}));
    connect(T_outdoor, vorlauftemperaturRegelung_modularBoiler1.T_outdoor)
    annotation (Line(points={{-100,-24},{-50,-24},{-50,-11},{0,-11}}, color={0,0,
          127}));
    else
  connect(notAusschalter_modularBoiler.PLR_set, zweipunktRegler_modularBoiler1.PLR_ein)
    annotation (Line(points={{-40,39},{-32,39},{-32,79},{0,79}}, color={0,0,127}));
  connect(T_ein, zweipunktRegler_modularBoiler1.T_ein) annotation (Line(points={
          {-100,70},{-62,70},{-62,72.8},{0,72.8}}, color={0,0,127}));
  connect(zweipunktRegler_modularBoiler1.PLR_aus, PLR_set) annotation (Line(
        points={{20,73.4},{50,73.4},{50,74},{100,74}}, color={0,0,127}));
    end if;


  connect(mFlow_rel, switch1.u3)
    annotation (Line(points={{-100,-60},{42,-60}}, color={0,0,127}));
  connect(notAusschalter_modularBoiler.PLRmin_boolean, switch1.u2) annotation (
      Line(points={{-40,31.2},{-30,31.2},{-30,-52},{42,-52}}, color={255,0,255}));
  connect(realExpression.y, switch1.u1)
    annotation (Line(points={{15,-44},{42,-44}}, color={0,0,127}));

  connect(switch1.y, mFlow_relB)
    annotation (Line(points={{65,-52},{100,-52}}, color={0,0,127}));
  annotation (uses(Modelica(version="3.2.3")));
end hierarchischeRegelung_modularBoiler;
