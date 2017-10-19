within AixLib.Fluid.Solar.Electric;
model PVSystem "PVSystem"
  extends Electric.BaseClasses.PartialPVSystem;

  Modelica.Blocks.Interfaces.RealInput TempOutside(
    final quantity="ThermodynamicTemperature",
    final unit="K")
    "Ambient temperature"
     annotation (Placement(transformation(extent={{-140,56},{-100,96}}),
        iconTransformation(extent={{-140,56},{-100,96}})));
  AixLib.Utilities.Interfaces.SolarRad_in IcTotalRad
    "Solar radiation in W/m2"
    annotation (Placement(transformation(extent={{-124,-12},{-100,14}}),
        iconTransformation(extent={{-136,-24},{-100,14}})));
  BaseClasses.PVModuleDC pVmoduleDC1(
      final Eta0=data.Eta0,
      final NoctTemp=data.NoctTemp,
      final NoctTempCell=data.NoctTempCell,
      final NoctRadiation=data.NoctRadiation,
      final TempCoeff=data.TempCoeff,
      final Area=NumberOfPanels*data.Area)
      "PV module with temperature dependent efficiency"
      annotation (Placement(transformation(extent={{-9,60},{11,80}})));

equation
  connect(pVmoduleDC1.DCOutputPower, pVinverterRMS.DCPowerInput)
    annotation (Line(
      points={{12,70},{38,70},{38,10.2},{43.8,10.2}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(TempOutside, pVmoduleDC1.AmbientTemperature)
      annotation (Line(points={{-120,76},{-90,76},{-11,76},{-11,76}},
                                                       color={0,0,127}));
  connect(IcTotalRad, pVmoduleDC1.SolarIrradationPerSquareMeter) annotation (
      Line(points={{-112,1},{-32,1},{-32,64.4},{-11,64.4}},
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
NOC</p>
<p><br/>
<b><span style=\"color: #008000;\">Assumptions</span></b></p>
<p>PV model is based on manufactory data and performance factor.</p>
<h4><span style=\"color: #008000\">References</span></h4>
<p>PV system data (DataBase Records) can be found: </p>
<ul>
<li><a href=\"http://www.eks-solar.de/pdfs/aleo_s24.pdf\">eks-solar</a></li>
<li><a href=\"http://soehn-net.de/fileadmin/user_upload/pdf/module/canadian_solar/CS6P220-250P_engl..pdf\">soehn-net</a></li>
<li><a href=\"http://www.abc-wagner.de/uploads/media/Datenblatt_Kid_SME-1_Serie_DE.pdf\">abc-wagner</a></li>
<li><a href=\"http://www.renugen.co.uk/content/Solar_Panel_Brochures_part_4/Solar&amp;percnt;20Panel&amp;percnt;20Brochures&amp;percnt;20part&amp;percnt;204/symphony_brochure/symphony_energy_se-m225.pdf\">Renugen</a></li>
<li><a href=\"http://sunelec.com/datasheet-library/download/SMA-SunnyBoy-3000_3800_4000.pdf\">sunelec</a></li>
</ul>
<p><br/>
Source of literature for the calculation of the pv cell efficiency: </p>
<p><q>Thermal modelling to analyze the effect of cell temperature on PV
modules energy efficiency</q> by Romary, Florian et al.</p>
<h4><span style=\"color: #008000\">Example Results</span></h4>
<p><a href=\"AixLib.Fluid.Solar.Electric.Examples.ExamplePV\">AixLib.Fluid.Solar.Electric.Examples.ExamplePV</a></p>
</html>",revisions="<html>
<ul>
<li><i>October 11, 2016 </i> by Tobias Blacha:<br/>
Moved into AixLib</li>
<li><i>Februar 21, 2013 </i> by Corinna Leonhardt:<br/>
Implemented</li>
</ul>
</html>"));
end PVSystem;
