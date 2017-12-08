within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities.Properties;
record MaterialHX
  "Record that contains parameters describing the heat exchanger's material"

  // Definition of explicit parameters
  //
  parameter Modelica.SIunits.Density dWal = 8000
    "Density of the heat exchanger's wall"
    annotation(Dialog(tab="General", group="Properties of the wall"));
  parameter Modelica.SIunits.SpecificHeatCapacity cpWal = 485
    "Constant specific heat capacity of the heat exchanger's wall"
    annotation(Dialog(tab="General", group="Properties of the wall"));

  annotation (Icon(graphics={
        Rectangle(
          extent={{-90,40},{90,-100}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Forward),
        Text(
          lineColor={0,0,255},
          extent={{-100,50},{100,90}},
          textString="%name")}), Documentation(revisions="<html>
<ul>
  <li>
  December 08, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/516\">issue 516</a>).
  </li>
</ul>
</html>",
        info="<html>
<p>
This record summarises the basic parameters of material properties
of a moving boundary heat exchanger. These parameters are listed
below:
</p>
<ul>
<li>
Constant density of the wall's material.
</li>
<li>
Constant specific heat capacity of the wall's material.
</li>
</ul>
<p>
All models that include this record have access to the 
parameters listed above.
</p>
</html>"));
end MaterialHX;
