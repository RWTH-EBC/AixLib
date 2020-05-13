within AixLib.ThermalZones.ReducedOrder.Windows;
class UsersGuide "User's Guide"
      extends Modelica.Icons.Information;

    annotation (Documentation(info="<html><p>
  The Windows package contains the models to simulate transparent
  objects in building simulations. It is based on the modelling of
  solar radiation of VDI 6007. The upper models <a href=
  \"Windows.Window\">Window</a> and <a href=
  \"Windows.ShadedWindow\">ShadedWindow</a> calculate the entering solar
  energy into the room. They use the <a href=
  \"SolarGain.CorrectionGTaueDoublePane\">CorrectionGTaueDoublePane</a>
  to calculate correction values for non-vertical and non-parrallel
  irradiation. To respect the heat input at closed sunscreen and open
  window the <a href=
  \"Windows.BaseClasses.VentilationHeat\">VentilationHeat</a>&lt;\\p&gt;
  model can be used. The <a href=
  \"Windows.ShadedWindow\">ShadedWindow</a> additionally considers
  shading because of window projections through the <a href=
  \"Windows.BaseClasses.SelfShadowing\">SelfShadowing</a> model and
  shading because of surrounding buildings through the <a href=
  \"Windows.BaseClasses.SkylineShadowing\">SkylineShadowing</a> model.
  The entering visible light is also calculated by the upper classes.
  It can be used to determine the switch moment of the lighting with
  the <a href=\"Windows.BaseClasses.Illumination\">Illumination</a>
  model. The information sections of the individual models give extra
  information on the calculations.&lt;\\p&gt;
</p>
<p>
  The <a href=\"Windows.Examples\">Examples</a> package contains examples
  on how the models should be integrated.&lt;\\p&gt;
</p>
<p>
  The <a href=\"Windows.Validation\">Validation</a> is splitted in
  <a href=\"Windows.Validation.VDI2078\">VDI2078</a> and <a href=
  \"Windows.Validation.Shadowing\">Shadowing</a>. The <a href=
  \"Windows.BaseClasses.Illumination\">Illumination</a> and the <a href=
  \"Windows.BaseClasses.VentilationHeat\">VentilationHeat</a> model were
  tested with parts of test case 1 and parts of test case 3 of VDI2078.
  <a href=
  \"SolarGain.CorrectionGTaueDoublePane\">CorrectionGTaueDoublePane</a>
  is tested within the test cases. The shadowing models are not
  included in the validation of VDI2078. Therfore the models were
  tested on plausibility with simple examples.&lt;\\p&gt;
</p>
<h4>
  References
</h4>
<ul>
  <li>VDI 6007-1:<br/>
    VDI. German Association of Engineers Guideline VDI 6007-3 June
    2015. Calculation of transient thermal response of rooms and
    buildings - Modelling of rooms.
  </li>
  <li>VDI 6007-2:<br/>
    VDI. German Association of Engineers Guideline VDI 6007-2 March
    2012. Calculation of transient thermal response of rooms and
    buildings - Modelling of windows.
  </li>
  <li>VDI 6007-3:<br/>
    VDI. German Association of Engineers Guideline VDI 6007-3 June
    2015. Calculation of transient thermal response of rooms and
    buildings - Modelling of solar radiation.
  </li>
</ul>
<ul>
  <li>June 07, 2016,&#160; by Stanley Risch:<br/>
    Implemented.
  </li>
</ul>
</html>"));

end UsersGuide;
