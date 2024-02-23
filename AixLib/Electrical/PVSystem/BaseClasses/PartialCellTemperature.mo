within AixLib.Electrical.PVSystem.BaseClasses;
partial model PartialCellTemperature
  "Partial model for determining the cell temperature of a PV moduleConnector 
  for PV record data"

// Parameters from module data sheet
 replaceable parameter AixLib.DataBase.SolarElectric.PVBaseDataDefinition data
 constrainedby AixLib.DataBase.SolarElectric.PVBaseDataDefinition
 "PV Panel data definition"
                           annotation (choicesAllMatching);

  final parameter Modelica.Units.SI.Efficiency eta_0=data.eta_0
    "Efficiency under standard conditions";

  final parameter Modelica.Units.SI.Temperature T_NOCT=data.T_NOCT
    "Cell temperature under NOCT conditions";

 final parameter Real radNOCT(final quantity="Irradiance",
    final unit="W/m2")= 800
    "Irradiance under NOCT conditions";
 Modelica.Blocks.Interfaces.RealInput T_a(final quantity=
    "Temp_C", final unit="K")
    "Ambient temperature"
    annotation (Placement(transformation(extent={{-140,64},{-100,114}}),iconTransformation(extent={{-140,74},{-100,114}})));

 Modelica.Blocks.Interfaces.RealInput winVel(final quantity= "Velocity",
    final unit= "m/s")
    "Wind velocity"
    annotation (Placement(transformation(extent={{-140,24},{-100,74}}), iconTransformation(extent={{-140,44},{-100,74}})));

 Modelica.Blocks.Interfaces.RealInput eta(final quantity="Efficiency",
      final unit="1",
      min=0)
    "Efficiency of the PV module under operating conditions"
    annotation (Placement(transformation(extent={{-140,-72},{-100,-22}}),
                                                                        iconTransformation(extent={{-140,-62},{-100,-22}})));

 Modelica.Blocks.Interfaces.RealInput radTil(final quantity="Irradiance",
    final unit="W/m2")
    "Total solar irradiance on the tilted surface"
    annotation (Placement(transformation(extent={{-140,-102},{-100,-62}}), iconTransformation(extent={{-140,-102},{-100,
            -62}})));




 Modelica.Blocks.Interfaces.RealOutput T_c(final quantity=
    "ThermodynamicTemperature", final unit="K")
    "Cell temperature"
    annotation (Placement(transformation(extent={{100,-20},{140,20}}),  iconTransformation(extent={{100,-20},{140,20}})));





  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          lineColor={200,200,200},
          fillColor={248,248,248},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-100.0,-100.0},{100.0,100.0}},
          radius=25.0),
        Rectangle(
          lineColor={128,128,128},
          extent={{-100.0,-100.0},{100.0,100.0}},
          radius=25.0),      Polygon(points={{-80,-80},{-40,80},{80,80},{40,-80},
              {-80,-80}}, lineColor={0,0,0}),
        Line(points={{-60,-76},{-20,76}}, color={0,0,0}),
        Line(points={{-34,-76},{6,76}}, color={0,0,0}),
        Line(points={{-8,-76},{32,76}}, color={0,0,0}),
        Line(points={{16,-76},{56,76}}, color={0,0,0}),
        Line(points={{-38,60},{68,60}}, color={0,0,0}),
        Line(points={{-44,40},{62,40}}, color={0,0,0}),
        Line(points={{-48,20},{58,20}}, color={0,0,0}),
        Line(points={{-54,0},{52,0}}, color={0,0,0}),
        Line(points={{-60,-20},{46,-20}}, color={0,0,0}),
        Line(points={{-64,-40},{42,-40}}, color={0,0,0}),
        Line(points={{-70,-60},{36,-60}}, color={0,0,0}),
        Ellipse(
          extent={{-20,-88},{20,-50}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-12,50},{12,-58}},
          lineColor={191,0,0},
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-12,50},{-12,90},{-10,96},{-6,98},{0,100},{6,98},{10,96},{12,
              90},{12,50},{-12,50}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-12,50},{-12,-54}},
          thickness=0.5),
        Line(
          points={{12,50},{12,-54}},
          thickness=0.5),
        Text(
          extent={{126,-30},{6,-60}},
          lineColor={0,0,0},
          textString="T"),
        Line(points={{12,0},{60,0}}, color={0,0,127})}),
     Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PartialCellTemperature;
