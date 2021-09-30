within ;
model hierarchischeRegelung_modularBoiler
  parameter Real PLRmin=0.15;
  parameter Boolean use_erweiterteRegelung=true "Auswahl zwischen Zweipunktregelung und Vorlauftemperaturregelung";

  Modelica.Blocks.Interfaces.RealInput T_ein
    annotation (Placement(transformation(extent={{-120,50},{-80,90}})));
  Modelica.Blocks.Interfaces.RealOutput PLR_set
    annotation (Placement(transformation(extent={{90,64},{110,84}})));
  Modelica.Blocks.Interfaces.RealInput PLR_ein
    annotation (Placement(transformation(extent={{-120,0},{-80,40}})));
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
    annotation (Placement(transformation(extent={{-120,-26},{-80,14}})));
  Modelica.Blocks.Interfaces.RealOutput mFlow_relB
    annotation (Placement(transformation(extent={{90,-62},{110,-42}})));
  PIRegler_modularBoiler pIRegler_modularBoiler
    annotation (Placement(transformation(extent={{40,-20},{60,0}})));
  Modelica.Blocks.Sources.RealExpression realExpression1
    annotation (Placement(transformation(extent={{-70,-58},{-50,-38}})));
  Modelica.Blocks.Logical.LessThreshold lessThreshold(threshold=PLRmin)
    annotation (Placement(transformation(extent={{-60,-28},{-46,-14}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{-28,-36},{-12,-20}})));
equation

  connect(T_ein, notAusschalter_modularBoiler.T_ein) annotation (Line(points={{-100,
          70},{-82,70},{-82,41.2},{-60,41.2}}, color={0,0,127}));

    if use_erweiterteRegelung then
    connect(T_outdoor, vorlauftemperaturRegelung_modularBoiler1.T_outdoor)
    annotation (Line(points={{-100,-6},{-50,-6},{-50,-11},{0,-11}},   color={0,0,
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
  connect(realExpression.y, switch1.u1)
    annotation (Line(points={{15,-44},{42,-44}}, color={0,0,127}));

  connect(switch1.y, mFlow_relB)
    annotation (Line(points={{65,-52},{100,-52}}, color={0,0,127}));
  connect(pIRegler_modularBoiler.PLR_vorlauf, PLR_set) annotation (Line(points=
          {{60,-5},{66,-5},{66,74},{100,74}}, color={0,0,127}));
  connect(vorlauftemperaturRegelung_modularBoiler1.T_Vorlauf,
    pIRegler_modularBoiler.Tset) annotation (Line(points={{20,-11},{30,-11},{30,
          -5},{40,-5}}, color={0,0,127}));
  connect(T_ein, pIRegler_modularBoiler.T_m) annotation (Line(points={{-100,70},
          {-74,70},{-74,56},{34,56},{34,-13},{40,-13}}, color={0,0,127}));
  connect(lessThreshold.y, switch2.u2) annotation (Line(points={{-45.3,-21},{
          -36.65,-21},{-36.65,-28},{-29.6,-28}}, color={255,0,255}));
  connect(lessThreshold.y, switch1.u2) annotation (Line(points={{-45.3,-21},{
          -36,-21},{-36,-52},{42,-52}}, color={255,0,255}));
  connect(PLR_ein, lessThreshold.u) annotation (Line(points={{-100,20},{-70,20},
          {-70,-21},{-61.4,-21}}, color={0,0,127}));
  connect(switch2.y, notAusschalter_modularBoiler.PLR_ein) annotation (Line(
        points={{-11.2,-28},{-12,-28},{-12,12},{-66,12},{-66,34.8},{-60,34.8}},
        color={0,0,127}));
  connect(PLR_ein, switch2.u3) annotation (Line(points={{-100,20},{-70,20},{-70,
          -34.4},{-29.6,-34.4}}, color={0,0,127}));
  connect(realExpression1.y, switch2.u1) annotation (Line(points={{-49,-48},{
          -32,-48},{-32,-21.6},{-29.6,-21.6}}, color={0,0,127}));
  annotation (uses(Modelica(version="3.2.3")));
end hierarchischeRegelung_modularBoiler;
