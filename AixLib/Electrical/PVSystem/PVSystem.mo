within AixLib.Electrical.PVSystem;
model PVSystem "PVSystem"
  extends BaseClasses.PartialPVSystem;

  Modelica.Blocks.Interfaces.RealInput TOutside(final quantity=
        "ThermodynamicTemperature", final unit="K") "Ambient temperature"
    annotation (Placement(transformation(extent={{-140,56},{-100,96}}),
        iconTransformation(extent={{-140,56},{-100,96}})));
  AixLib.Utilities.Interfaces.SolarRad_in IcTotalRad
    "Solar radiation in W/m2"
    annotation (Placement(transformation(extent={{-124,-12},{-100,14}}),
        iconTransformation(extent={{-136,-24},{-100,14}})));

  Modelica.Blocks.Sources.RealExpression realExpression(y=IcTotalRad.I)
    annotation (Placement(transformation(extent={{-96,-10},{-76,10}})));
equation

  connect(TOutside, PVModuleDC.T_amb) annotation (Line(points={{-120,76},{-62,
          76},{-62,66},{-15,66}}, color={0,0,127}));
  connect(realExpression.y, PVModuleDC.SolarIrradiationPerSquareMeter)
    annotation (Line(points={{-75,0},{-48,0},{-48,54.4},{-14.6,54.4}}, color={0,
          0,127}));
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
     Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  PV model is based on manufactory data and performance factor
  including the NOC
</p>
<p>
  <br/>
  <b><span style=\"color: #008000;\">Assumptions</span></b>
</p>
<p>
  PV model is based on manufactory data and performance factor.
</p>
<h4>
  <span style=\"color: #008000\">References</span>
</h4>
<p>
  PV system data (DataBase Records) can be found:
</p>
<ul>
  <li>
    <a href=\"http://www.eks-solar.de/pdfs/aleo_s24.pdf\">eks-solar</a>
  </li>
  <li>
    <a href=
    \"https://www.solarelectricsupply.com/canadian-solar-cs6p-250-solar-panels-117\">
    solar-electric</a>
  </li>
  <li>
    <a href=
    \"http://www.fl200.com/gourdinne/energie/Datenblatt_Kid_SME_1_Serie_DE.pdf\">
    schueco</a>
  </li>
  <li>
    <a href=
    \"https://solarco.en.ec21.com/Solar_Module_SE6M60-Series--7320291_7320754.html\">
    solarco</a>
  </li>
</ul>
<p>
  <br/>
  Source of literature for the calculation of the pv cell efficiency:
</p>
<p>
  <q>Thermal modelling to analyze the effect of cell temperature on PV
  modules energy efficiency</q> by Romary, Florian et al.
</p>
<h4>
  <span style=\"color: #008000\">Example Results</span>
</h4>
<p>
  <a href=
  \"AixLib.Fluid.Solar.Electric.Examples.ExamplePV\">AixLib.Fluid.Solar.Electric.Examples.ExamplePV</a>
</p>
</html>",revisions="
<html><ul>
  <li>
    <i>October 20, 2017</i> ,by Larissa Kuehn:<br/>
    Implementation of PartialPVSystem.
  </li>
  <li>
    <i>October 11, 2016</i> ,by Tobias Blacha:<br/>
    Moved into AixLib
  </li>
  <li>
    <i>Februar 21, 2013</i> ,by Corinna Leonhardt:<br/>
    Implemented
  </li>
</ul>
</html>

"));
end PVSystem;
