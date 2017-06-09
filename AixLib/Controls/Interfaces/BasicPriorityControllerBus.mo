within AixLib.Controls.Interfaces;
expandable connector BasicPriorityControllerBus
  "Standard bus with Priority for controller selection"
  extends Modelica.Icons.SignalBus;

  Real priority "Priority for the usage of different controllers";

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Definition of a standard heat pump bus that contains basic data points that appear in every heat pump.</p>
</html>", revisions="<html>
<p>March 31, 2017, by Marc Baranski:</p>
<p>First implementation. </p>
</html>"));
end BasicPriorityControllerBus;
