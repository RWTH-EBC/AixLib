within AixLib.Controls.Interfaces;
model ComponentShellTwoPort
  "Basic model for physical component and several selectable controllers"

    extends AixLib.Fluid.Interfaces.PartialTwoPortInterface;

  BasicPriorityControllerBus
                           signalBus
    annotation (Placement(transformation(extent={{-20,78},{20,118}})));

  BasicControllerShell basicControllerShell
    annotation (Placement(transformation(extent={{-80,34},{-40,68}})));
  BasicControllerShell basicControllerShell1
    annotation (Placement(transformation(extent={{-22,34},{18,68}})));
  BasicControllerShell basicControllerShell2
    annotation (Placement(transformation(extent={{36,34},{76,68}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ComponentShellTwoPort;
