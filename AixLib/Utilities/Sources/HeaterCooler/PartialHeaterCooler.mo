within AixLib.Utilities.Sources.HeaterCooler;
partial model PartialHeaterCooler
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatCoolRoom
    "Heat port to thermal zone"                                                                annotation(Placement(transformation(extent={{80,-50},
            {100,-30}}), iconTransformation(extent={{80,-50},{100,-30}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                   graphics={  Rectangle(extent={{-94,-30},{80,-50}},    lineColor = {135, 135, 135}, fillColor = {135, 135, 135},
            fillPattern =                                                                                                   FillPattern.Solid),                                                                                                    Line(points={{
              -46,-30},{-46,60}},                                                                                                    color={0,
              128,255}),                                                                                                    Line(points={{
              -66,36},{-46,60},{-26,36}},                                                                                                    color={0,
              128,255}),                                                                                                    Line(points={{
              30,-30},{30,60}},                                                                                                    color={255,
              0,0}),                                                                                                    Line(points={{
              10,36},{30,60},{50,36}}, color={255,0,0}),
        Rectangle(
          extent={{-68,-20},{-24,-30}},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{8,-20},{52,-30}},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None)}),                                                                                                    Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  This is the base class of an ideal heater and/or cooler. It is used
  in full ideal heater/cooler models as an extension.
</p>
<ul>
  <li>
    <i>October, 2015&#160;</i> by Moritz Lauster:<br/>
    Adapted to Annex60 and restructuring
  </li>
</ul>
<ul>
  <li>
    <i>June, 2014&#160;</i> by Moritz Lauster:<br/>
    Added some basic documentation
  </li>
</ul>
</html>"));
end PartialHeaterCooler;
