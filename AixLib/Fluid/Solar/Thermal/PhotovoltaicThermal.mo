within AixLib.Fluid.Solar.Thermal;
model PhotovoltaicThermal "Simple Model of a photovoltaic thermal panel"
  extends AixLib.Fluid.Solar.Thermal.BaseClasses.PartialSolarThermal(solTheEff(
      final eta_zero=parCol.etaThe_zero,
      final c1=parCol.c1The,
      final c2=parCol.c2The));
  replaceable parameter AixLib.DataBase.PhotovoltaicThermal.PhotovoltaicThermalBaseDataDefinition
    parCol constrainedby
    AixLib.DataBase.PhotovoltaicThermal.PhotovoltaicThermalBaseDataDefinition
    "Properties of photovoltaic thermal collector"
     annotation(choicesAllMatching = true);

  Modelica.Blocks.Interfaces.RealOutput PEle(final quantity="Power",
      final unit="W") "DC output power of the PV array"
    annotation (Placement(transformation(extent={{100,40},{120,60}})));
  BaseClasses.ElectricalEfficiency eleEff(final eta_zero=parCol.etaEle_zero,
      final m=parCol.mEle)
    annotation (Placement(transformation(extent={{20,40},{40,60}})));
  Modelica.Blocks.Math.Gain conRelElePowToAbsElePow(final k=A) "Multiply by area"
    annotation (Placement(transformation(extent={{60,40},{80,60}})));
equation
  connect(calcMeaT.y, eleEff.TCol) annotation (Line(points={{-50,21},{-50,28},{25,
          28},{25,38}},        color={0,0,127}));
  connect(Irr, eleEff.G) annotation (Line(points={{0,100},{0,68},{31,68},{31,62}},
                             color={0,0,127}));
  connect(eleEff.PEle, conRelElePowToAbsElePow.u)
    annotation (Line(points={{41,50},{58,50}},   color={0,0,127}));
  connect(conRelElePowToAbsElePow.y, PEle)
    annotation (Line(points={{81,50},{110,50}}, color={0,0,127}));
  connect(TAir, eleEff.TAir) annotation (Line(points={{-60,100},{-60,72},{25,72},{
          25,62}},     color={0,0,127}));
  annotation (Documentation(info="<html><h4>
  Overview
</h4>
<p>
  Simplified model of a photovoltaic thermal collector, which builds
  upon the solar thermal model. Inputs are outdoor air temperature and
  solar irradiation. Based on these values and the collector properties
  from database, this model creates a heat flow to the fluid circuit
  and an electrical power output.
</p>
<h4>
  Concept
</h4>
<p>
  The model maps solar collector efficiency based on the equation
</p>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/Fluid/HeatExchanger/SolarThermal/equation-vRK5Io7E.png\"
  alt=\"1\">
</p>
<p>
  and similar for the electrical efficiency a linear approximation is
  used:
</p>
<p>
<code>eta=etaEle_zero - mEle * dT/G</code>
</p>
<p>
  Values for the linear and quadratic coefficients for the
  thermal efficiency as well as the coefficients for the linear
  approximation are derived from <a href=
  \"https://www.researchgate.net/publication/327882787_Thermal_management_of_PVT_collectors_development_and_modelling_of_highly_efficient_glazed_flat_plate_PVT_collectors_with_low_emissivity_coatings_and_overheating_protection\">
  this thesis </a> by Markus Lämmle, p.43
  Figure 3.12. The underlying data was validated with the following
  assumptions:
</p>
<ul>
  <li>solar irradiation G=1000 W/m^2
  </li>
  <li>windspeed Uwind=3m/s
  </li>
  <li>ambient temperature Ta= 25°C
  </li>
</ul>
<h4>
  Known Limitations
</h4>
<ul>
  <li>Connected directly with Sources.TempAndRad, this model only
  represents a horizontal collector. There is no calculation for
  radiation on tilted surfaces.
  </li>
  <li>With the standard BaseParameters, this model uses water as
  working fluid
  </li>
</ul>
<h5>
  Parameters
</h5>
<p>
  This model is an extension of <a href=
  \"modelica://AixLib.Fluid.Solar.Thermal.SolarThermal\">AixLib.Fluid.Solar.Thermal.SolarThermal</a>.
  Therefore the parameters can be found in the base model.
</p>
</html>", revisions="<html><ul>
  <li>
    <i>January 23, 2024</i> by Philipp Schmitz and Fabian Wuellhorst:<br/>
    First implementation. This is for
 <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1451\">
 issue 1451</a>.
  </li>
</ul>
</html>"), Icon(graphics={   Polygon(points={{-22,-80},{18,80},{98,80},{58,-80},{-22,
              -80}},      lineColor={0,0,0},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Line(points={{22,62},{88,62}},  color={255,255,255},
          thickness=1),
        Line(points={{36,-74},{76,78}}, color={255,255,255},
          thickness=1),
        Line(points={{18,46},{84,46}},  color={255,255,255},
          thickness=1),
        Line(points={{14,30},{80,30}},  color={255,255,255},
          thickness=1),
        Line(points={{10,14},{76,14}},  color={255,255,255},
          thickness=1),
        Line(points={{-6,-50},{60,-50}},color={255,255,255},
          thickness=1),
        Line(points={{-2,-34},{64,-34}},color={255,255,255},
          thickness=1),
        Line(points={{2,-18},{68,-18}}, color={255,255,255},
          thickness=1),
        Line(points={{6,-2},{72,-2}},   color={255,255,255},
          thickness=1),
        Line(points={{16,-74},{56,78}}, color={255,255,255},
          thickness=1),
        Line(points={{-4,-74},{36,78}}, color={255,255,255},
          thickness=1)}));
end PhotovoltaicThermal;
