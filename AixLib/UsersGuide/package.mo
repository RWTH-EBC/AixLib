within AixLib;
package UsersGuide "User's Guide"
  extends Modelica.Icons.Information;


  annotation(DocumentationClass = true, Documentation(info="<html><p>
  <img src=\"modelica://AixLib/Resources/Images/EBC_Logo.png\" alt=
  \"EBC Logo\" width=\"1000\">
</p>
<p>
  The free open-source <code>AixLib</code> library is being developed
  for research and teaching purposes. It aims at dynamic simulations of
  thermal and hydraulic systems to develop control strategies for HVAC
  systems and analyse interactions in complex systems. It is used for
  simulations on component, building and city district level. As this
  library is developed mainly for academic purposes, user-friendliness
  and model robustness is not a main task. This research focus thus
  influences the layout and philosophy of the library. Various models
  are highly inspired by other libraries, especially by Modelica
  Standard Library and LBNL's Building Library.
</p>
<p>
  Various connectors of the Modelica Standard Library are used, e.g.
  <code>Modelica.Fluid</code> and <code>Modelica.HeatTransfer</code>.
  These are accompanied by own connectors for simplified hydraulics (no
  <code>fluid.media</code>, incompressible, one phase) , shortwave
  radiation (intensity), longwave radiation (heat flow combined with a
  virtual temperature) and combined longwave radiation and thermal. The
  pressure in the connectors is the total pressure. The used media
  models are simplified from the <code>Modelica.Media</code> library.
  If possible and necessary, components use continuously differentiable
  equations. In general, zero mass flow rate and reverse flow are
  supported.
</p>
<p>
  Most models have been analytically verified. In addition, hydraulic
  components are compared to empirical data such as performance curves.
  High and low order building models have been validated using a
  standard test suite provided by the ANSI/ASHRAE Standard 140 and VDI
  6007 Guideline. The library has only been tested with Dymola.
</p>
<p>
  The web page for this library is <a href=
  \"https://www.github.com/RWTH-EBC/AixLib\">https://www.github.com/RWTH-EBC/AixLib</a>.
  We welcome contributions from different users to further advance this
  library, whether it is through collaborative model development,
  through model use and testing or through requirements definition or
  by providing feedback regarding the model applicability to solve
  specific problems.
</p>
</html>"));
end UsersGuide;
