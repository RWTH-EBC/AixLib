within AixLib.Fluid.HeatPumps.BaseClasses.HeatPumpControlls;
block DefrostControl
  "Control block to ensure no frost limits heat flow at the evaporator"
  Controls.Interfaces.HeatPumpControlBus heaPumControlBus
    annotation (Placement(transformation(extent={{-122,-96},{-94,-68}})));
  Modelica.Blocks.Interfaces.RealOutput nOut
    annotation (Placement(transformation(extent={{100,-12},{124,12}})));
  Modelica.Blocks.Interfaces.RealInput nSet
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{-128,-52},{-88,-12}}), iconTransformation(
          extent={{-120,-42},{-100,-22}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end DefrostControl;
