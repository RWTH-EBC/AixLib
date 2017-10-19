within AixLib.Fluid.Solar.Electric.BaseClasses;
partial model PartialPVSystem "Partial model for PV System"

  parameter  Modelica.SIunits.Angle lat = 0.65798912800186
  "Location's Latitude"
       annotation (Dialog(group="Location"));

  parameter Modelica.SIunits.Angle til = 0.34906585039887
  "Surface's tilt angle (0:flat)"
       annotation (Dialog(group="Geometry"));

  parameter Modelica.SIunits.Angle azi = -0.78539816339745
  "Surface's azimut angle (0:South)"
         annotation (Dialog(group="Geometry"));

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
  Electric.BaseClasses.PVInverterRMS pVinverterRMS(final uMax2=
        MaxOutputPower) "Inverter model including system management"
    annotation (Placement(transformation(extent={{44,0},{64,20}})));

equation

  connect(pVinverterRMS.PVPowerRmsW, PVPowerW) annotation (Line(
      points={{64,10},{88,10},{88,0},{110,0}},
      color={0,0,127},
      smooth=Smooth.None));

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
        coordinateSystem(preserveAspectRatio=false)));
end PartialPVSystem;
