within AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Conversions;
model HDifToClearCovered "Splits the total diffuse irradiation in diffuse irradiation at clear and
  covered sky"
  extends Modelica.Blocks.Icons.Block;

  Modelica.Blocks.Interfaces.RealInput HDifHor(final quantity=
    "RadiantEnergyFluenceRate", final unit="W/m2")
    "Horizontal diffuse solar radiation."
     annotation (Placement(transformation(extent={{-116,-66},{-100,-50}}),
        iconTransformation(extent={{-120,-70},{-100,-50}})));

   Modelica.Blocks.Interfaces.RealInput HDifTil(final quantity=
    "RadiantEnergyFluenceRate", final unit="W/m2")
    "Hemispherical diffuse solar irradiation on a tilted surface from the sky"
    annotation (Placement(transformation(extent={{-116,54},{-100,70}}),
        iconTransformation(extent={{-120,50},{-100,70}})));
   Modelica.Blocks.Interfaces.RealOutput HDifHorCov(final quantity=
    "RadiantEnergyFluenceRate", final unit="W/m2")
    "Horizontal diffuse solar radiation at covered sky."
    annotation (Placement(transformation(extent={{104,-26},{120,-10}}),
        iconTransformation(extent={{100,-30},{120,-10}})));

  Modelica.Blocks.Interfaces.RealOutput HDifHorCle(final quantity=
    "RadiantEnergyFluenceRate", final unit="W/m2")
    "Horizontal diffuse solar radiation at clear sky."
    annotation (Placement(transformation(extent={{104,-66},{120,-50}}),
        iconTransformation(extent={{100,-70},{120,-50}})));

  Modelica.Blocks.Interfaces.RealOutput HDifTilCov(final quantity=
    "RadiantEnergyFluenceRate", final unit="W/m2")
    "Hemispherical diffuse solar irradiation on a tilted surface at covered sky"
    annotation (Placement(transformation(extent={{104,14},{120,30}}),
        iconTransformation(extent={{100,10},{120,30}})));
  Modelica.Blocks.Interfaces.RealOutput HDifTilCle(final quantity=
    "RadiantEnergyFluenceRate", final unit="W/m2")
    "Hemispherical diffuse solar irradiation on a tilted surface at clear sky"
    annotation (Placement(transformation(extent={{104,54},{120,70}}),
        iconTransformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealInput nTot( min=0,max=1,
    final unit="1") "Total sky Cover"
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}}),
        iconTransformation(extent={{-120,-10},{-100,10}})));

equation
  HDifTilCle=HDifTil*(1-nTot);
  HDifTilCov=HDifTil*nTot;
  HDifHorCle=HDifHor*(1-nTot);
  HDifHorCov=HDifHor*nTot;
  annotation (defaultComponentName="HDif_toCleCov",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(points={{-78,0},{42,0}}, color={191,0,0}),
        Polygon(
          points={{94,0},{34,20},{34,-20},{94,0}},
          lineColor={191,0,0},
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  This model calculates the diffuse irradiation at clear and covered
  sky out of the total diffuse irradiation. Therefore it uses the total
  sky cover.
</p>
</html>",
    revisions="<html><ul>
  <li>June 30, 2016,&#160; by Stanley Risch:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end HDifToClearCovered;
