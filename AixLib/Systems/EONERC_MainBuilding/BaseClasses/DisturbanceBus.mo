within AixLib.Systems.EONERC_MainBuilding.BaseClasses;
expandable connector DisturbanceBus "Disturbance Bus"
  extends Modelica.Icons.SignalBus;
  import Modelica.Units.SI;

  Real IntGains1;
  Real IntGains2;
  Real IntGains3;
  Real price_el;
  Real price_heat;
  Real price_cold;


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
end DisturbanceBus;
