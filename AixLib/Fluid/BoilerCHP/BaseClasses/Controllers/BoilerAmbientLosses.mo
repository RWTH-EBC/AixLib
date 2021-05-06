within AixLib.Fluid.BoilerCHP.BaseClasses.Controllers;
model BoilerAmbientLosses
 parameter Modelica.SIunits.Temp_C TAmbient=20; // Ambient temperature

 Modelica.Blocks.Interfaces.RealInput QRel "Part load ratio of Boiler"
    annotation (Placement(transformation(extent={{-120,10},{-80,50}})));
 Modelica.Blocks.Interfaces.RealInput THot(
    final quantity="Temperature",
    final unit="degC",
    displayUnit="degC") "Temperature hot water"
    annotation (Placement(transformation(extent={{-120,-50},{-80,-10}})));
  Modelica.Blocks.Interfaces.RealOutput EtaLossesSet
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation

   EtaLossesSet=0.003/50*(THot - TAmbient)/QRel;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end BoilerAmbientLosses;
