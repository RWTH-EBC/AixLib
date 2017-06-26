within AixLib.Fluid.Solar.Electric;
model PVSystem "PVSystem"

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
     annotation (Placement(transformation(extent={{80,0},{100,20}})));
  Modelica.Blocks.Interfaces.RealInput TempOutside(
    final quantity="ThermodynamicTemperature",
    final unit="K")
    "Ambient temperature"
     annotation (Placement(transformation(extent={{-126,50},{-86,90}})));
  AixLib.Utilities.Interfaces.SolarRad_in IcTotalRad
    "Solar radiation in W/m2"
    annotation (Placement(transformation(extent={{-122,-20},{-98,6}})));
  BaseClasses.PVModuleDC pVmoduleDC1(
      final Eta0=data.Eta0,
      final NoctTemp=data.NoctTemp,
      final NoctTempCell=data.NoctTempCell,
      final NoctRadiation=data.NoctRadiation,
      final TempCoeff=data.TempCoeff,
      final Area=NumberOfPanels*data.Area)
      "PV module with temperature dependent efficiency"
      annotation (Placement(transformation(extent={{-15,60},{5,80}})));
  BaseClasses.PVInverterRMS pVinverterRMS(final uMax2=MaxOutputPower)
    "Inverter model including system management"
    annotation (Placement(transformation(extent={{44,0},{64,20}})));

equation
  connect(pVmoduleDC1.DCOutputPower, pVinverterRMS.DCPowerInput)
    annotation (Line(
      points={{6,70},{22,70},{22,66},{36,66},{36,10.2},{43.8,10.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pVinverterRMS.PVPowerRmsW, PVPowerW) annotation (Line(
      points={{64,10},{90,10}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(TempOutside, pVmoduleDC1.AmbientTemperature)
      annotation (Line(points={{-106,70},
          {-62,70},{-62,65.2},{-17,65.2}},             color={0,0,127}));
  connect(IcTotalRad, pVmoduleDC1.SolarIrradationPerSquareMeter) annotation (
      Line(points={{-110,-7},{-32,-7},{-32,75.4},{-17,75.4}},
       color={255,128,0}));
  annotation (
   Icon(
    coordinateSystem(extent={{-100,-100},{100,100}}),
    graphics={
     Rectangle(
      lineColor={0,0,0},
      fillColor={255,255,255},
      fillPattern=FillPattern.Solid,
      extent={{-100,100},{100,-100}}),
     Text(
      lineColor={0,0,0},
      extent={{-96,95},{97,-97}},
           textString="PV")}),
     Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
             {100,100}})),
     Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>PV model is based on manufactory data and performance factor including the
NOCT.</p>
<p><br><b><span style=\"color: #008000;\">Assumptions</span></b></p>
<p>PV model is based on manufactory data and performance factor.</p>
<h4><span style=\"color: #008000\">References</span></h4>
<p>PV system data (DataBase Records) can be found: </p>
<ul>
<li>http://www.eks-solar.de/pdfs/aleo_s24.pdf</li>
<li>http://soehn-net.de/fileadmin/user_upload/pdf/module/canadian_solar/CS6P220-250P_engl..pdf</li>
<li>http://www.abc-wagner.de/uploads/media/Datenblatt_Kid_SME-1_Serie_DE.pdf</li>
<li>http://www.renugen.co.uk/content/Solar_Panel_Brochures_part_4/Solar&percnt;20Panel&percnt;20Brochures&percnt;20part&percnt;204/symphony_brochure/symphony_energy_se-m225.pdf</li>
<li>http://sunelec.com/datasheet-library/download/SMA-SunnyBoy-3000_3800_4000.pdf</li>
</ul>
<p><br>Source of literature for the calculation of the pv cell efficiency: </p>
<p>&quot;Thermal modelling to analyze the effect of cell temperature on PV
modules energy efficiency&QUOT; by Romary, Florian et al.</p>
<h4><span style=\"color: #008000\">Example Results</span></h4>
<p><a href=\"HVAC.Examples.Solar_UC.Electric.Testing_PV\">AixLib.Fluid.Solar.Electric.Examples.Testing_PV</a></p>
</html>",revisions="<html>
<p><ul>
<li><i>October 11, 2016 </i> by Tobias Blacha:<br/>Moved into AixLib</li>
<li><i>Februar 21, 2013 </i> by Corinna Leonhardt:<br/>Implemented</li>
</ul></p>
</html>"));
end PVSystem;
