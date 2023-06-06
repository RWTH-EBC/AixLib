within AixLib.Fluid.BoilerCHP.BaseClasses;
model NominalFuelConsumption "Estimates nominal fuel consumption"

   parameter Modelica.Units.SI.TemperatureDifference dTNom=20
    "Nominal temperature difference of supply and return";
  parameter Modelica.Units.SI.Temperature TRetNom=273.15 + 60
    "Nominal return temperature";
  parameter Modelica.Units.SI.HeatFlowRate QNom=50000
    "Nominal thermal capacity";
  Modelica.Blocks.Sources.RealExpression tReturnNom(y=TRetNom)
    "Nominal return temperature"
    annotation (Placement(transformation(extent={{-100,6},{-54,30}})));

  Modelica.Blocks.Sources.RealExpression dTNominal(y=dTNom)
    "Nominal temperature differences"
    annotation (Placement(transformation(extent={{-100,-36},{-50,-14}})));
  Modelica.Blocks.Sources.RealExpression rel_m_flow(y=1)
    "Nominal realtive water mass flow"
    annotation (Placement(transformation(extent={{-100,-16},{-54,8}})));

  Modelica.Blocks.Sources.RealExpression nominalLosses(y=QNom*0.003)
                                     "Nominal Heat Losses"
    annotation (Placement(transformation(extent={{-100,68},{-54,92}})));
  Modelica.Blocks.Sources.RealExpression qNom(y=QNom)
    "Nominal thermal capacity"
    annotation (Placement(transformation(extent={{-100,40},{-54,64}})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{26,48},{46,68}})));
  Modelica.Blocks.Interfaces.RealOutput nominalFuelConsumption(quantity="Power",
      final unit="W") "nominal Fuel Consumption" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,58}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,0})));
  Modelica.Blocks.Routing.Multiplex4 multiplex4_2
    annotation (Placement(transformation(extent={{18,-16},{38,4}})));
  SDF.NDTable boilerEffciency2(
    nin=4,
    readFromFile=true,
    filename=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/DataBase/Boiler/General/Boiler_Eta_4D.sdf"),
    dataset="/ETA_Kennfeld",
    dataUnit="-",
    scaleUnits={"degC","-","-","K"},
    interpMethod=SDF.Types.InterpolationMethod.Linear,
    extrapMethod=SDF.Types.ExtrapolationMethod.None)
    annotation (Placement(transformation(extent={{54,-16},{74,4}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-32,64},{-12,84}})));

equation

  connect(multiplex4_2.y, boilerEffciency2.u)
    annotation (Line(points={{39,-6},{52,-6}}, color={0,0,127}));
  connect(boilerEffciency2.y, division.u2) annotation (Line(points={{75,-6},{80,
          -6},{80,44},{8,44},{8,52},{24,52}},   color={0,0,127}));
  connect(rel_m_flow.y, multiplex4_2.u3[1]) annotation (Line(points={{-51.7,-4},
          {-34,-4},{-34,-10},{-10,-10},{-10,-9},{16,-9}},
                                      color={0,0,127}));
  connect(dTNominal.y, multiplex4_2.u4[1]) annotation (Line(points={{-47.5,-25},
          {-20,-25},{-20,-20},{16,-20},{16,-15}},
                                         color={0,0,127}));
  connect(nominalLosses.y, add.u1)
    annotation (Line(points={{-51.7,80},{-34,80}}, color={0,0,127}));
  connect(qNom.y, add.u2) annotation (Line(points={{-51.7,52},{-40,52},{-40,68},
          {-34,68}}, color={0,0,127}));
  connect(add.y, division.u1) annotation (Line(points={{-11,74},{16,74},{16,64},
          {24,64}}, color={0,0,127}));
  connect(division.y, nominalFuelConsumption)
    annotation (Line(points={{47,58},{110,58}}, color={0,0,127}));
  connect(rel_m_flow.y, multiplex4_2.u2[1]) annotation (Line(points={{-51.7,-4},
          {-34,-4},{-34,-3},{16,-3}}, color={0,0,127}));
  connect(tReturnNom.y, multiplex4_2.u1[1]) annotation (Line(points={{-51.7,18},
          {-10,18},{-10,3},{16,3}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                      Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255}),
        Rectangle(
          extent={{-82,84},{82,-88}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={199,199,199},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-72,-72},{58,-72}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-72,-72},{-72,58}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-72,-72},{20,-12}},
          color={0,0,0},
          thickness=1),
        Polygon(
          points={{58,-68},{64,-72},{58,-76},{58,-68}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-5,4},{3,4},{-1,-2},{-5,4}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          origin={-73,60},
          rotation=180),
        Polygon(
          points={{16,-10},{22,-10},{20,-16},{16,-10}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-42,74},{44,28}},
          textColor={0,0,0},
          fontName="Arial Black",
          textString="Nominal
")}),                                                              Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This model only calculates the efficiency for nominal conditions to get nominal fuel consumption [W] at the beginning of the simulation.</p>
<p><span style=\"font-family: Arial;\">The nominal efficiency comes from the SDF and depends on:</span></p>
<ul>
<li><span style=\"font-family: Arial;\">Nominal return temperature</span></li>
<li><span style=\"font-family: Arial;\">Nominale temperature difference</span></li>
<li><span style=\"font-family: Arial;\">Nominal relative water mass flow (=1)</span></li>
<li><span style=\"font-family: Arial;\">Nominal relative temperature difference (=1)</span></li>
</ul>
<p><br>Further assumptions are taken into account for nominal losses (see AixLib.Fluid.BoilerCHP.BoilerNoControl):</p>
<ul>
<li>G: a heat loss of 0.3 &percnt; of nominal power at a temperature difference of 50 K to ambient is assumed.</li>
<li>C: factor C/Q_nom is in range of 1.2 to 2 for boilers with nominal power between 460 kW and 80 kW (with c of 500J/kgK for steel). Thus, a value of 1.5 is used as default.</li>
</ul>
</html>", revisions="<html>
<ul>
<li>June, 2023  by Moritz Zuschlag &amp; David Jansen</li>
</ul>
</html>"));
end NominalFuelConsumption;
