within AixLib.Systems.ModularEnergySystems.ControlUnity.Energysystem;
model EnergySystem_Control

  Boolean x;

  Modelica.Blocks.Interfaces.BooleanOutput isOnBoiler
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealInput T "Required consumer power"
    annotation (Placement(transformation(extent={{-122,2},{-82,42}})));
    parameter Boolean pre_y_start=false "Value of pre(y) at initial time";
equation
  x=isOnBoiler;

isOnBoiler = pre(isOnBoiler) and (T < 360.15) or (T < 355.15);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Control system for the energy system.</p>
</html>"));
end EnergySystem_Control;
