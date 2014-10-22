within AixLib.HVAC.Sources;
model TempAndRad "Outdoor Temperature and solar irradiation"
  import AixLib;

  parameter AixLib.DataBase.Weather.WeatherBaseDataDefinition temperatureOT=
      AixLib.DataBase.Weather.WinterDay() "outdoor air tmeperature"
    annotation (choicesAllMatching=true);

  Modelica.Blocks.Sources.CombiTimeTable OutdoorConditions(
    table=temperatureOT.temperature,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    offset={0.01})
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealOutput T_out "Outdoor air temperature in C"
    annotation (Placement(transformation(extent={{96,-50},{116,-30}}),
        iconTransformation(extent={{96,-50},{116,-30}})));
  Modelica.Blocks.Interfaces.RealOutput Rad "Solar Irradiation in W/m2"
    annotation (Placement(transformation(extent={{96,30},{116,50}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC
    annotation (Placement(transformation(extent={{66,-50},{86,-30}})));
equation
  connect(OutdoorConditions.y[2], Rad) annotation (Line(
      points={{11,0},{54,0},{54,40},{106,40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(OutdoorConditions.y[1], from_degC.u) annotation (Line(
      points={{11,0},{54,0},{54,-40},{64,-40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(from_degC.y, T_out) annotation (Line(
      points={{87,-40},{106,-40}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics),
    Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>This source outputs the outdoor air temperature in K from a table given in database.</p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
</html>",
        revisions="<html>
<p>19.11.2013, Marcus Fuchs: implemented</p>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={Ellipse(
          extent={{-54,20},{54,-86}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={213,255,170}), Text(
          extent={{-38,16},{38,-74}},
          lineColor={0,0,255},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          textString="T_out"),Ellipse(
          extent={{-56,92},{52,-14}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={213,255,170}), Text(
          extent={{-28,64},{22,18}},
          lineColor={0,0,255},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          textString="G")}));
end TempAndRad;
