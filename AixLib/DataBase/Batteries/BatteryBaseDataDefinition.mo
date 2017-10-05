within AixLib.DataBase.Batteries;
record BatteryBaseDataDefinition
  "Base data definition for the different battery models"

  extends Modelica.Icons.Record;
///////////input parameters////////////
  import SI = Modelica.SIunits;
  parameter SI.Height height "Height of the battery";
  parameter SI.Length width
    "Width of the battery (should be longer than the length)";
  parameter SI.Length length
    "Length of the battery (should be shorter than the width)";
  parameter SI.SpecificHeatCapacity cp
    "Specific heat capacity of the battery";
  parameter SI.Mass massBat "Mass of the battery";
  parameter SI.Area radiationArea "Battery's area for the radiation";
  parameter SI.Emissivity eps "Battery's emissivity coefficient";

  annotation (Icon(coordinateSystem(preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Text(
          lineColor={0,0,255},
          extent={{-150,60},{150,100}},
          textString="%name"),
        Rectangle(
          origin={0.0,-25.0},
          lineColor={64,64,64},
          fillColor={255,215,136},
          fillPattern=FillPattern.Solid,
          extent={{-100.0,-75.0},{100.0,75.0}},
          radius=25.0),
        Line(
          points={{-100.0,0.0},{100.0,0.0}},
          color={64,64,64}),
        Line(
          origin={0.0,-50.0},
          points={{-100.0,0.0},{100.0,0.0}},
          color={64,64,64}),
        Line(
          origin={0.0,-25.0},
          points={{0.0,75.0},{0.0,-75.0}},
          color={64,64,64})}),
        Documentation(info="<html>
    <p><b><font style=\"color: #008000; \">Overview</font></b> </p>
    <p>This record is the base data definition for the parameters of
    a single battery. </p>
    </html>",  revisions="<html>
    <ul>
    <li><i>July 26, 2017&nbsp;</i> by Paul Thiele:<br/>Implemented. </li>
    </ul>
    </html>"));
end BatteryBaseDataDefinition;
