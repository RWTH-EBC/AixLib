within AixLib.Controls.Interfaces;
model ComponentShellTwoPort
  "Basic model for physical component and several selectable controllers"

    extends AixLib.Fluid.Interfaces.PartialTwoPortInterface;

  BasicPriorityControllerBus
                           signalBus
    annotation (Placement(transformation(extent={{-20,78},{20,118}})));

  BasicControllerShell basicControllerShell
    annotation (Placement(transformation(extent={{-84,-22},{-44,12}})));
  BasicControllerShell basicControllerShell1
    annotation (Placement(transformation(extent={{-20,-22},{20,12}})));
  BasicControllerShell basicControllerShell2
    annotation (Placement(transformation(extent={{44,-22},{84,12}})));
  HeatPumpBusSwitch busSwitch
    annotation (Placement(transformation(extent={{-24,48},{2,74}})));
equation
  connect(busSwitch.signalBus, signalBus) annotation (Line(
      points={{-11,73.74},{-11,87.87},{0,87.87},{0,98}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ComponentShellTwoPort;
