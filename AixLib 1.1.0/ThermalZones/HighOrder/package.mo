within AixLib.ThermalZones;
package HighOrder "Standard house models"
  extends Modelica.Icons.Package;


  annotation(conversion(noneFromVersion = "", noneFromVersion = "1.0", noneFromVersion = "1.1", noneFromVersion = "1.2", from(version = "1.3", script = "Conversions/ConvertFromHouse_Models_1.3.mos"), from(version = "2.0", script = "Conversions/ConvertFromHouse_Models_2.0_To_2.1"), from(version = "2.1", script = "Conversions/ConvertFromHouse_Models_2.1_To_2.2")), Documentation(revisions = "", info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Package for standard house models, derived form the EBC-Library
  HouseModels.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The H library aims to provide standard models for one family
  dwellings (stand alone house), single apartments and multi-family
  dwellings consisting of several apartments. The particularity of this
  library lies in providing ready to use models for the dynamic
  simulation of building energy systems, while allowing for a degree of
  flexibility in adapting or extending these models to ones needs.
</p>
<p>
  A library with models for standard houses as such does not yet exist.
  While at the moment the standard house models are tailor-made for the
  German market, it is possible to adapt them to other markets.
</p>
<p>
  When developing the HouseModels library we followed several goals:
</p>
<ul>
  <li>develop standard models
  </li>
  <li>model only the necessary physical processes
  </li>
  <li>build a model so that changing the parameters is easy, quick and
  will not lead to hidden mistakes
  </li>
  <li>have an easy to use graphical interface
  </li>
  <li>ensure a degree of flexibility for expanding or building new
  models
  </li>
</ul>
<p>
  <br/>
  We call these house models standard for the following reasons:
</p>
<ul>
  <li>the floor layouts were made based on existing buildings, by
  analyzing data provided by the German Federal Statistical Office and
  by consulting with experts
  </li>
  <li>for modeling realistical wall structures building catalogues as
  well as experts were consulted
  </li>
  <li>the physical properties of the materials for the wall layers were
  chosen to satisfy the insulation requirements of current and past
  German energy saving ordinances: WSchV 1984, WSchV1995, EnEV 2002 and
  EnEV 2009
  </li>
</ul>
<h4>
  <span style=\"color:#008000\">References</span>
</h4>
<p>
  Ana Constantin, Rita Streblow and Dirk Mueller The Modelica
  HouseModels Library: Presentation and Evaluation of a Room Model with
  the ASHRAE Standard 140 in Proceedings of Modelica Conference, Lund
  2014, Pages 293-299. DOI: <a href=
  \"http://dx.doi.org/10.3384/ECP14096293\">10.3384/ECP14096293</a>
</p>
</html>"));
end HighOrder;
