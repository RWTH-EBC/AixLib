within AixLib.Controls.Interfaces;
expandable connector BoilerControlBus
  "Standard data bus with boiler information"
  extends Modelica.Icons.SignalBus;



  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  Definition of a standard boiler control bus that contains basic data
  points that appear in every boiler.
</p>
<ul>
  <li>June 06, 2023, by David Jansen:<br/>
    Remove variables from expandable connector.
  </li>
  <li>March 31, 2017, by Marc Baranski:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/371\">issue 371</a>).
  </li>
</ul>
</html>"));
end BoilerControlBus;
