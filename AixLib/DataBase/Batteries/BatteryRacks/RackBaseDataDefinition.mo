within AixLib.DataBase.Batteries.BatteryRacks;
record RackBaseDataDefinition
  "Base Data Definition for the different battery rooms"

  extends Modelica.Icons.Record;
  ///////////input parameters////////////
  parameter AixLib.DataBase.Batteries.BatteryTypes.BatteryBaseDataDefinition BatType
    "Battery Type of the Rack";
  parameter Integer nParallels "Number of batteries placed in one Series";
  parameter Integer nSeries "Number of battery series";
  parameter Integer nStacked "Number of batteries stacked on another";
  parameter Boolean AirBetweenStacks=false "Is there a gap between the stacks (nStacked>1)?" annotation (Dialog(
        descriptionLabel=true), choices(
      choice=true "Yes",
      choice=false "No",
      radioButtons=true));
  parameter Boolean BatArrangement=true "How are the batteries touching each other?" annotation (Dialog(
        descriptionLabel=true), choices(
      choice=true "Longer sides touch each other in one row",
      choice=false "Shorter sides touch each other in one row",
      radioButtons=true));
  parameter Modelica.SIunits.Area AreaStandingAtWall = 0 "default=0, area of the rack, which is placed at the wall, so there is no vertical heat convection.";

  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
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
          color={64,64,64})}),                        Documentation(info="<html>
<p>
This icon is indicates a record.
</p>
</html>"));
end RackBaseDataDefinition;
