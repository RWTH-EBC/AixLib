within AixLib.ThermalZones.ReducedOrder;
package Windows "This Package calculates solar gain through windows"
  extends Modelica.Icons.VariantsPackage;






  class UsersGuide "User's Guide"
      extends Modelica.Icons.Information;

    annotation (Documentation(info="<html>
<p>The Windows package contains the models to simulate transparent objects in
building simulations. It is based on the modelling of solar radiation of
VDI 6007. The upper models <a href=\"Windows.Window\">Window</a> and
<a href=\"Windows.ShadedWindow\">ShadedWindow</a> calculate the entering solar
energy into the room. They use the
 <a href=\"SolarGain.CorrectionGTaueDoublePane\">CorrectionGTaueDoublePane</a>
 to calculate correction values for non-vertical and non-parrallel irradiation.
   To respect the heat input  at closed sunscreen and open window the
<a href=\"Windows.BaseClasses.VentilationHeat\">VentilationHeat</a><\\p>
 model can be used. The <a href=\"Windows.ShadedWindow\">ShadedWindow</a>
 additionally considers shading because of window projections through the
  <a href=\"Windows.BaseClasses.SelfShadowing\">SelfShadowing</a>
  model and shading because of surrounding buildings through the
  <a href=\"Windows.BaseClasses.SkylineShadowing\">SkylineShadowing</a>  model.
   The entering visible light is also calculated by the upper classes.
    It can be used to determine the switch moment of the lighting with the
     <a href=\"Windows.BaseClasses.Illumination\">Illumination</a> model.
      The information sections of the individual models give extra information
      on the calculations.<\\p>
<p>The <a href=\"Windows.Examples\">Examples</a> package contains examples on
how the models should be integrated.<\\p>
<p>The <a href=\"Windows.Validation\">Validation</a> is splitted in
<a href=\"Windows.Validation.VDI2078\">VDI2078</a> and
<a href=\"Windows.Validation.Shadowing\">Shadowing</a>.
The <a href=\"Windows.BaseClasses.Illumination\">Illumination</a> and the
<a href=\"Windows.BaseClasses.VentilationHeat\">VentilationHeat</a> model were
tested with parts of test case 1 and parts of test case 3 of VDI2078.
<a href=\"SolarGain.CorrectionGTaueDoublePane\">CorrectionGTaueDoublePane</a>
 is tested within the test cases. The shadowing models are not included in the
 validation of VDI2078.
  Therfore the models were tested on plausibility with simple examples.<\\p>
</html>"));
  end UsersGuide;

  annotation (Documentation(revisions="<html>
<ul>
<li>July 17 2016,&nbsp; by Stanley Risch:<br>Implemented. </li>
</html>", info="<html>
<p>This package provides two models which calculate the solar heat transmitted
 through windows into the room. <a href=\"Windows.Window\">Window</a> considers
 correction values for non-parallel and non-vertical radiation.
  <a href=\"Windows.ShadedWindow\">ShadedWindow</a> additionally includes
  shadowing due to the window itself and surrounding buildings. The
   <a href=\"Windows.BaseClasses\">BaseClasses</a>-package contains an
    <a href=\"Windows.Illumination\">Illumination</a> model which calculates
    the activation and deactivation of the illumination <\\p>
</html>"));
end Windows;
