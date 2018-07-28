within AixLib.Fluid.HeatPumps.BaseClasses.HeatPumpControlls;
block HeatingCurve "A basic heating curve model"
  extends Modelica.Blocks.Interfaces.SISO;

  parameter Modelica.SIunits.Temp_K TRoo "Desired room temperature";
  parameter Modelica.SIunits.Temp_K THeaBou "Temperature at which heating is turned off";
  parameter Boolean use_TableData = true "Select whether to use table data or an aproximation function of your choice";

equation

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HeatingCurve;
