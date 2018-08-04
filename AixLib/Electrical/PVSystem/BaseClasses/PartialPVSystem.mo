within AixLib.Electrical.PVSystem.BaseClasses;
partial model PartialPVSystem "Partial model for PV System"

  parameter Integer NumberOfPanels = 1
    "Number of panels";
  parameter AixLib.DataBase.SolarElectric.PVBaseRecord data
    "PV data set"
    annotation (choicesAllMatching=true);
  parameter Modelica.SIunits.Power MaxOutputPower
    "Maximum output power for inverter";
  Modelica.Blocks.Interfaces.RealOutput PVPowerW(
    final quantity="Power",
    final unit="W")
    "Output Power of the PV system including the inverter"
     annotation (Placement(transformation(extent={{100,-10},{120,10}}),
        iconTransformation(extent={{100,-10},{120,10}})));

  BaseClasses.PVModuleDC PVModuleDC(
    final Eta0=data.Eta0,
    final NoctTemp=data.NoctTemp,
    final NoctTempCell=data.NoctTempCell,
    final NoctRadiation=data.NoctRadiation,
    final TempCoeff=data.TempCoeff,
    final Area=NumberOfPanels*data.Area)
    "PV module with temperature dependent efficiency"
    annotation (Placement(transformation(extent={{-13,50},{7,70}})));
  BaseClasses.PVInverterRMS PVInverterRMS(final uMax2=MaxOutputPower)
    "Inverter model including system management"
    annotation (Placement(transformation(extent={{40,0},{60,20}})));
equation

  connect(PVModuleDC.DCOutputPower, PVInverterRMS.DCPowerInput) annotation (
      Line(points={{8,60},{28,60},{28,10.2},{39.8,10.2}}, color={0,0,127}));
  connect(PVInverterRMS.PVPowerRmsW, PVPowerW) annotation (Line(points={{60,10},
          {82,10},{82,0},{110,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
     Rectangle(
      lineColor={0,0,0},
      fillColor={255,255,255},
      fillPattern=FillPattern.Solid,
      extent={{-100,100},{100,-100}}),
     Text(
      lineColor={0,0,0},
      extent={{-96,95},{97,-97}},
           textString="PV")}),                                   Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li><i>October 20, 2017 </i> ,by Larissa Kuehn<br/>First implementation</li>
</ul>
</html>"));
end PartialPVSystem;
