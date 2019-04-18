within AixLib.PlugNHarvest.Components.SmartFacade.BaseClasses;
partial model PartialSmartFassade
  replaceable package AirModel = AixLib.Media.Air
                            "Air model" annotation ( choicesAllMatching = true);

  AixLib.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{-110,-14},{-70,26}}), iconTransformation(extent=
           {{-100,-10},{-80,10}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li><i>April, 2019&nbsp;</i> by Ana Constantin:<br>First implementation</li>
</ul>
</html>"));
end PartialSmartFassade;
