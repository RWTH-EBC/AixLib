within AixLib.Fluid.BoilerCHP.BaseClasses.Controllers;
model DesignOperation "Operating for design conditions"

  parameter Modelica.Units.SI.HeatFlowRate QNom=50000 "Design thermal capacity";

    parameter Modelica.Units.SI.Temperature THotNom=273.15 + 80
    "Design supply temperature" annotation (Dialog(group="Design"),Evaluate=false);

  parameter Modelica.Units.SI.Temperature TColdNom=273.15 + 60
    "Design return temperature" annotation (Dialog(group="Design"),Evaluate=false);



  Modelica.Blocks.Sources.RealExpression ReturnTemp(y=TColdNom)
    "Nominal return temperature"
    annotation (Placement(transformation(extent={{-100,6},{-54,30}})));

  Modelica.Blocks.Sources.RealExpression y_fullLoad(y=1) "realtive power"
    annotation (Placement(transformation(extent={{-100,-16},{-54,8}})));

  Modelica.Blocks.Sources.RealExpression conductance(y=0.0465*QNom + 4.9891)
    "Thermal conductance"
    annotation (Placement(transformation(extent={{-98,54},{-52,78}})));
  Modelica.Blocks.Sources.RealExpression NomCap(y=QNom)
    "Nominal thermal capacity"
    annotation (Placement(transformation(extent={{-98,28},{-52,52}})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{58,48},{78,68}})));
  Modelica.Blocks.Interfaces.RealOutput designPowerDemand(quantity="Power",
      final unit="W") "Nominal fuel demand" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,58}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,0})));
  Modelica.Blocks.Routing.Multiplex4 multiplex4_2
    annotation (Placement(transformation(extent={{18,-16},{38,4}})));
  SDF.NDTable boilerEffciency(
    nin=4,
    readFromFile=true,
    filename=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/DataBase/Boiler/General/Boiler_Generic_Characteristic_Chart.sdf"),

    dataset="/Characteristic chart",
    dataUnit="-",
    scaleUnits={"K","K","-","-"},
    interpMethod=SDF.Types.InterpolationMethod.Linear,
    extrapMethod=SDF.Types.ExtrapolationMethod.Hold)   "Characteristic chart"
    annotation (Placement(transformation(extent={{54,-16},{74,4}})));

  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{20,54},{40,74}})));

  Modelica.Blocks.Math.Add add1(k1=-1)
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  Modelica.Blocks.Sources.RealExpression ReturnTemp1(y=TColdNom)
    "Nominal return temperature"
    annotation (Placement(transformation(extent={{-100,-56},{-54,-32}})));
  Modelica.Blocks.Sources.RealExpression SupplyTemp(y=THotNom)
    "Nominal supply temperature"
    annotation (Placement(transformation(extent={{-100,-78},{-54,-54}})));
  Modelica.Blocks.Sources.RealExpression SupplyTemp1(y=THotNom - 293.15)
    "Nominal supply temperature"
    annotation (Placement(transformation(extent={{-100,80},{-54,104}})));
  Modelica.Blocks.Math.Product losses "Nominal boiler losses"
    annotation (Placement(transformation(extent={{-32,76},{-12,96}})));
equation

  connect(multiplex4_2.y, boilerEffciency.u)
    annotation (Line(points={{39,-6},{52,-6}}, color={0,0,127}));
  connect(boilerEffciency.y, division.u2) annotation (Line(points={{75,-6},{80,-6},
          {80,22},{50,22},{50,52},{56,52}}, color={0,0,127}));
  connect(y_fullLoad.y, multiplex4_2.u3[1]) annotation (Line(points={{-51.7,-4},
          {-34,-4},{-34,-9},{16,-9}}, color={0,0,127}));
  connect(NomCap.y, add.u2) annotation (Line(points={{-49.7,40},{-40,40},{-40,58},
          {18,58}}, color={0,0,127}));
  connect(add.y, division.u1) annotation (Line(points={{41,64},{56,64}},
                    color={0,0,127}));
  connect(division.y, designPowerDemand)
    annotation (Line(points={{79,58},{110,58}}, color={0,0,127}));
  connect(y_fullLoad.y, multiplex4_2.u2[1]) annotation (Line(points={{-51.7,-4},
          {-34,-4},{-34,-3},{16,-3}}, color={0,0,127}));
  connect(ReturnTemp.y, multiplex4_2.u1[1]) annotation (Line(points={{-51.7,18},
          {-10,18},{-10,3},{16,3}}, color={0,0,127}));
  connect(ReturnTemp1.y, add1.u1)
    annotation (Line(points={{-51.7,-44},{-42,-44}}, color={0,0,127}));
  connect(SupplyTemp.y, add1.u2) annotation (Line(points={{-51.7,-66},{-42,-66},
          {-42,-56}}, color={0,0,127}));
  connect(add1.y, multiplex4_2.u4[1]) annotation (Line(points={{-19,-50},{8,-50},
          {8,-15},{16,-15}}, color={0,0,127}));
  connect(conductance.y, losses.u2) annotation (Line(points={{-49.7,66},{-40,66},
          {-40,80},{-34,80}}, color={0,0,127}));
  connect(SupplyTemp1.y, losses.u1)
    annotation (Line(points={{-51.7,92},{-34,92}}, color={0,0,127}));
  connect(losses.y, add.u1) annotation (Line(points={{-11,86},{0,86},{0,70},{18,
          70}}, color={0,0,127}));
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
          textString="Design
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
end DesignOperation;
