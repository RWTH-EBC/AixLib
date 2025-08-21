within AixLib.Systems.EONERC_MainBuilding.BaseClasses;
expandable connector ZoneMeaBus "Zone Bus"
  extends Modelica.Icons.SignalBus;
  import Modelica.Units.SI;

  SI.Temperature T_room;
  Real CO2;
  Real T_discomfort_heat;
  Real T_discomfort_heat_squared;
  Real T_discomfort_cold;
  Real T_discomfort_cold_squared;
  Real CO2_discomfort;
  Real CO2_discomfort_squared;

  annotation (
    Icon(graphics,
         coordinateSystem(preserveAspectRatio=false)),
    Diagram(graphics,
            coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Definition of a bus connector for the ERC Heatpump System.</p>
</html>", revisions="<html>
<ul>
<li>October 25, 2017, by Alexander K&uuml;mpel:<br/>Adaption for hydraulic modules in AixLib.</li>
<li>February 6, 2016, by Peter Matthes:<br/>First implementation. </li>
</ul>
</html>"));
end ZoneMeaBus;
