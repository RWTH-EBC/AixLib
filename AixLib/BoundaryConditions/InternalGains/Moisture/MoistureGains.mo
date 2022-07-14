within AixLib.BoundaryConditions.InternalGains.Moisture;
model MoistureGains
  "Model for moisture gains that are produced by plants, cooking, etc."

  parameter Real specificMoistureProduction(unit="g/(h.m.m)") = 0.5
    "Specific moisture production without persons in the room due to plants, cooking, showering, etc.";
  parameter Modelica.Units.SI.Area roomArea=20 "Area of room";

  Modelica.Blocks.Interfaces.RealOutput QLat_flow
    "Latent heat of moisture gain"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Sources.Constant moistureGain(k=specificMoistureProduction)
    "Specific moisture production"
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  Modelica.Blocks.Math.Gain squareMetre(k=roomArea) "Room area"
    annotation (Placement(transformation(extent={{-30,0},{-10,20}})));
  Modelica.Blocks.Math.Gain toKgPerSeconds(k=1/(1000*3600))
    "Converter from g/h to kg/s"
    annotation (Placement(transformation(extent={{14,0},{34,20}})));
  Modelica.Blocks.Math.Product toLatentHeat
    "Converter from kg/s moisture to latent heat flow"
    annotation (Placement(transformation(extent={{4,-34},{-16,-14}})));
  Modelica.Blocks.Sources.RealExpression specificLatentHeat(y=h_fg)
  "Specific latent heat of moisture"
    annotation (Placement(transformation(extent={{56,-44},{36,-24}})));
protected
  constant Modelica.Units.SI.SpecificEnergy h_fg=
      Media.Air.enthalpyOfCondensingGas(273.15 + 37)
    "Latent heat of water vapor";
equation
  connect(moistureGain.y, squareMetre.u)
    annotation (Line(points={{-59,10},{-32,10}}, color={0,0,127}));
  connect(squareMetre.y, toKgPerSeconds.u)
    annotation (Line(points={{-9,10},{12,10}}, color={0,0,127}));
  connect(toKgPerSeconds.y, toLatentHeat.u1) annotation (Line(points={{35,10},{48,
          10},{48,-18},{6,-18}}, color={0,0,127}));
  connect(specificLatentHeat.y, toLatentHeat.u2) annotation (Line(points={{35,-34},
          {22,-34},{22,-30},{6,-30}}, color={0,0,127}));
  connect(toLatentHeat.y, QLat_flow) annotation (Line(points={{-17,-24},{-26,-24},
          {-26,-54},{68,-54},{68,0},{110,0}},  color={0,0,127}));
  annotation (Documentation(info="<html><p>
  <b><span style=\"color: #008000\">Overview</span></b>
</p>
<p>
  This model gives the output for latent heat release by plants,
  cooking, showering, etc. (except from persons). The moisture output
  has to be set in g/(h m²).
</p>
<p>
  <b><span style=\"color: #008000\">Concept</span></b>
</p>
<p>
  The moisture output is defined in some norms as an average output per
  hour and squaremetre. This output will be considered by this model.
</p>
<p>
  The latent heat output depends on the air temperature in the room
  where the moisture sources are located.
</p>
<ul>
  <li>Oktober 14, 2019, by Martin Kremer:<br/>
    Adapted model to latest changes in IBPSA. Providing latent heat of
    moisture at 37 degree Celsius.
  </li>
  <li>July, 2019, by Martin Kremer:<br/>
    First implementation.
  </li>
</ul>
</html>"), Icon(graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-64,36},{-28,0}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-64,20},{-62,30},{-58,42},{-52,52},{-42,62},{-38,66},{-40,56},
              {-40,50},{-38,44},{-36,38},{-34,32},{-30,26},{-64,20}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-24,-32},{12,-68}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-24,-46},{-22,-38},{-18,-26},{-12,-16},{-2,-6},{2,-2},{0,-12},
              {0,-18},{2,-24},{4,-30},{6,-36},{10,-42},{-24,-46}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{14,36},{50,0}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{14,20},{16,30},{20,42},{26,52},{36,62},{40,66},{38,56},{38,50},
              {40,44},{42,38},{44,32},{48,26},{14,20}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid)}));
end MoistureGains;
