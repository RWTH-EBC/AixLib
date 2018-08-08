within AixLib.Electrical.PVSystem;
model PVSystemTMY3
  extends BaseClasses.PartialPVSystem;

    parameter  Modelica.SIunits.Angle Latitude = 0.65798912800186
  "Location's Latitude"
       annotation (Dialog(group="Location"));

  parameter Modelica.SIunits.Angle til = 0.34906585039887
  "Surface's tilt angle (0:flat)"
       annotation (Dialog(group="Geometry"));

  parameter Modelica.SIunits.Angle azi = -0.78539816339745
  "Surface's azimut angle (0:South)"
         annotation (Dialog(group="Geometry"));

  AixLib.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{-120,-20},{-80,20}}),iconTransformation(extent={{-110,
            -10},{-90,10}})));
  Modelica.Blocks.Math.Add G "Total irradiation on tilted surface"
    annotation (Placement(transformation(extent={{-28,12},{-8,32}})));
  AixLib.BoundaryConditions.SolarIrradiation.DiffusePerez    HDifTil(
    til=til,
    lat=Latitude,
    azi=azi)               "Diffuse irradiation on tilted surface"
    annotation (Placement(transformation(extent={{-62,18},{-42,38}})));
  AixLib.BoundaryConditions.SolarIrradiation.DirectTiltedSurface    HDirTil(
    til=til,
    lat=Latitude,
    azi=azi)               "Direct irradiation on tilted surface"
    annotation (Placement(transformation(extent={{-62,-10},{-42,10}})));
equation

  connect(weaBus, HDifTil.weaBus) annotation (Line(
      points={{-100,0},{-70,0},{-70,28},{-62,28}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaBus, HDirTil.weaBus) annotation (Line(
      points={{-100,0},{-70,0},{-62,0}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(HDifTil.H, G.u1) annotation (Line(points={{-41,28},{-34,28},{-30,28}},
                    color={0,0,127}));
  connect(HDirTil.H, G.u2) annotation (Line(points={{-41,0},{-36,0},{-36,16},
          {-30,16}},
                color={0,0,127}));
  connect(PVModuleDC.T_amb, weaBus.TDryBul) annotation (Line(points={{-15,66},{
          -88,66},{-88,4},{-88,0},{-100,0}}, color={0,0,127}));
  connect(G.y, PVModuleDC.SolarIrradiationPerSquareMeter) annotation (Line(
        points={{-7,22},{-4,22},{-4,48},{-24,48},{-24,54.4},{-14.6,54.4}},
        color={0,0,127}));
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
<p><a href=\"AixLib.Fluid.Solar.Electric.Examples.ExamplePV_TMY3\">AixLib.Fluid.Solar.Electric.Examples.ExamplePV_TMY3</a></p>
</html>", revisions="<html>
<ul>
<li><i>October 20, 2017</i> ,by Larissa Kuehn:<br/>First implementation</li>
</ul>
</html>"));
end PVSystemTMY3;
