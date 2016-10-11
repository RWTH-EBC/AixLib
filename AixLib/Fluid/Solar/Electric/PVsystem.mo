within AixLib.Fluid.Solar.Electric;
model PVsystem "PVSystem"

   parameter Integer NumberOfPanels = 1 "number of Panels %NumberOfPanels";
  parameter AixLib.DataBase.SolarElectric.PV_data data=
      AixLib.DataBase.SolarElectric.SE6M181_14_panels()
    annotation (choicesAllMatching=true);

  parameter Modelica.SIunits.Power max_Output_Power
    " Maximum Output Power for Inverter in W";

 BaseClases.PVmoduleDC pVmoduleDC1(
    eta0=data.eta0,
    NOCT_Temp=data.NOCT_Temp,
    NOCT_Temp_Cell=data.NOCT_Temp_Cell,
    NOCT_radiation=data.NOCT_radiation,
    TempCoeff=data.Temp_coeff,
    Area=NumberOfPanels*data.Area)
    annotation (Placement(transformation(extent={{-15,60},{5,80}})));
   Modelica.Blocks.Interfaces.RealOutput PV_Power_W
     annotation (Placement(transformation(extent={{80,0},{100,20}})));
   Modelica.Blocks.Interfaces.RealInput Temp_outside "in C"
     annotation (Placement(transformation(extent={{-126,50},{-86,90}})));
  BaseClases.PVinverterRMS pVinverterRMS(uMax2=max_Output_Power)
    annotation (Placement(transformation(extent={{44,0},{64,20}})));
  AixLib.Utilities.Interfaces.SolarRad_in ic_total_rad
    annotation (Placement(transformation(extent={{-122,-20},{-98,6}})));
   Modelica.Blocks.Math.UnitConversions.To_degC to_degC
     annotation (Placement(transformation(extent={{-70,62},{-50,82}})));
equation
  connect(pVmoduleDC1.DC_output_power, pVinverterRMS.DC_power_input)
    annotation (Line(
      points={{5,70},{22,70},{22,66},{36,66},{36,10.2},{43.8,10.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pVinverterRMS.PV_Power_RMS_W, PV_Power_W) annotation (Line(
      points={{64,10},{90,10}},
      color={0,0,127},
      smooth=Smooth.None));

   pVmoduleDC1.Solar_Irradation_per_m2 =  ic_total_rad.I;

   connect(Temp_outside, to_degC.u) annotation (Line(
       points={{-106,70},{-90,70},{-90,72},{-72,72}},
       color={0,0,127},
       smooth=Smooth.None));
   connect(pVmoduleDC1.ambient_temperature_in_C, to_degC.y) annotation (Line(
       points={{-15.2,65.2},{-31.6,65.2},{-31.6,72},{-49,72}},
       color={0,0,127},
       smooth=Smooth.None));
  annotation (
   pVinverterRMS1(_base(t(flags=8194))),
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
   experiment(
       StopTime=3.1536e+007,
       NumberOfIntervals=300,
       Algorithm="Lsodar"),
     Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
             {100,100}}),
             graphics),
     __Dymola_experimentSetupOutput,
     Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>PV model is based on manufactory data and performance factor including the NOCT.</p>
<p><br><b><span style=\"color: #008000;\">Assumptions</span></b></p>
<p>PV model is based on manufactory data and performance factor.</p>
<p><img src=\"modelica://AixLib/Images/PV1.png\"/></p>
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
<p>&quot;Thermal modelling to analyze the effect of cell temperature on PV modules energy efficiency&QUOT; by Romary, Florian et al.</p>
<h4><span style=\"color: #008000\">Example Results</span></h4>
<p><a href=\"HVAC.Examples.Solar_UC.Electric.Testing_PV\">AixLib.Fluid.Solar.Electric.Examples.Testing_PV</a></p>
</html>",revisions="<html>
<p><ul>
<li><i>Februar 21, 2013 </i> by Corinna Leonhardt:<br/>Implemented</li>
<li><i>October 11, 2016 </i> by Tobias Blacha:<br/>Moved into AixLib</li>
</ul></p>
</html>"));
end PVsystem;
