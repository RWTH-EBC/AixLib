within AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses;
model MultizonePostProcessing
  parameter Modelica.SIunits.Volume VAir
     "Indoor air volume of building";
  parameter Integer numZones(min=1)
    "Number of zones";
  parameter AixLib.DataBase.ThermalZones.ZoneBaseRecord zoneParam[numZones]
    "Setup for zones" annotation (choicesAllMatching=false);
  Modelica.Blocks.Math.Sum PHeaterSum(nin=numZones)
    "Power consumed for heating with ideal heaters"
    annotation (Placement(transformation(extent={{40,52},{54,66}})));
  Modelica.Blocks.Math.Sum PCoolerSum(nin=numZones)
    "Power consumed for cooling with ideal coolers"
    annotation (Placement(transformation(extent={{40,24},{54,38}})));
  Modelica.Blocks.Continuous.Integrator WCoolerSum
    "Energy consumed for cooling with ideal coolers"
    annotation (Placement(transformation(extent={{60,24},{74,38}})));
  Modelica.Blocks.Continuous.Integrator WHeaterSum
    "Energy consumed for heating with ideal heaters"
    annotation (Placement(transformation(extent={{60,52},{74,66}})));
  Modelica.Blocks.Math.Sum TAirAverage(nin=numZones, k=zoneParam.VAir/VAir)
    "Average temperature of all zones"
    annotation (Placement(transformation(extent={{60,76},{74,90}})));

  Modelica.Blocks.Interfaces.RealInput TAir[numZones](final quantity="Temperature",
      final unit="K")
    "Air temperature of each zone" annotation (Placement(transformation(extent=
            {{-122,70},{-82,110}}), iconTransformation(extent={{-122,70},{-82,
            110}})));
  Modelica.Blocks.Interfaces.RealInput PCooler[numZones](final quantity="HeatFlowRate",
      final unit="W")
    "Power consumed for cooling with ideal coolers by each zone" annotation (
      Placement(transformation(extent={{-122,-14},{-82,26}}),
        iconTransformation(extent={{-122,-14},{-82,26}})));
  Modelica.Blocks.Interfaces.RealInput PHeater[numZones](final quantity="HeatFlowRate",
      final unit="W")
    "Power consumed for heating ling with ideal heaters by each zone"
    annotation (Placement(transformation(extent={{-122,28},{-82,68}}),
        iconTransformation(extent={{-122,28},{-82,68}})));
  Modelica.Blocks.Interfaces.RealInput PelAHU(final quantity="Power", final
      unit="W") "Electrical power of AHU"
    annotation (Placement(transformation(extent={{-122,-20},{-82,20}}),
        iconTransformation(extent={{-122,-52},{-86,-16}})));
  Modelica.Blocks.Interfaces.RealInput  PHeatAHU(final quantity="HeatFlowRate",
      final unit="W")
    "Thermal power of AHU for heating"
    annotation (
    Placement(transformation(extent={{-122,-56},{-82,-16}}),
    iconTransformation(extent={{-122,-90},{-86,-54}})));
  Modelica.Blocks.Interfaces.RealInput  PCoolAHU(final quantity="HeatFlowRate",
      final unit="W")
    "Thermal power of AHU for cooling"
    annotation (
    Placement(transformation(extent={{-122,-84},{-84,-46}}),
                                                           iconTransformation(
    extent={{-122,-128},{-86,-92}})));
  Modelica.Blocks.Continuous.Integrator WCoolAHU
    "Energy consumed for cooling by AHU"
    annotation (Placement(transformation(extent={{60,-72},{74,-58}})));
  Modelica.Blocks.Continuous.Integrator WElAHU
    "Electric energy consumed by AHU"
    annotation (Placement(transformation(extent={{60,-8},{74,6}})));
  Modelica.Blocks.Continuous.Integrator WHeatAHU
    "Energy consumed for heating by AHU"
    annotation (Placement(transformation(extent={{60,-40},{74,-26}})));
equation
  connect(PHeaterSum.y,WHeaterSum. u) annotation (Line(points={{54.7,59},{58.6,
          59}},                      color={0,0,127}));
  connect(PCoolerSum.y,WCoolerSum. u) annotation (Line(points={{54.7,31},{58.6,
          31}},                      color={0,0,127}));
  connect(TAirAverage.u, TAir)
    annotation (Line(points={{58.6,83},{58.6,90},{-102,90}}, color={0,0,127}));
  connect(PCoolerSum.u, PCooler)
    annotation (Line(points={{38.6,31},{-102,31},{-102,6}}, color={0,0,127}));
  connect(PHeater, PHeaterSum.u) annotation (Line(points={{-102,48},{-32,48},{
          -32,59},{38.6,59}}, color={0,0,127}));
  connect(PelAHU, WElAHU.u) annotation (Line(points={{-102,0},{-22,0},{-22,-1},
          {58.6,-1}}, color={0,0,127}));
  connect(PHeatAHU, WHeatAHU.u) annotation (Line(points={{-102,-36},{-22,-36},{
          -22,-33},{58.6,-33}}, color={0,0,127}));
  connect(PCoolAHU, WCoolAHU.u) annotation (Line(points={{-103,-65},{-23.5,-65},
          {-23.5,-65},{58.6,-65}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{40,24},{40,-16},{60,4},{40,24}},
          lineColor={28,108,200},
          fillColor={85,85,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-34,12},{42,-4}},
          lineColor={28,108,200},
          fillColor={85,85,255},
          fillPattern=FillPattern.Solid),                                 Text(
          extent={{-88,96},{92,136}},
          lineColor={0,0,255},
          textString="%name%")}),                                Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end MultizonePostProcessing;
