within AixLib.Fluid.BoilerCHP.BaseClasses.Controllers;
model OffDesignOperation

  parameter Modelica.Units.SI.HeatFlowRate QNom=50000 "Design thermal capacity";

    parameter Modelica.Units.SI.Temperature THotNom=273.15 + 80
    "Design supply temperature" annotation (Dialog(group="Design"),Evaluate=false);

  parameter Modelica.Units.SI.Temperature TColdNom=273.15 + 60
    "Design return temperature" annotation (Dialog(group="Design"),Evaluate=false);


package Medium=AixLib.Media.Water;

  Systems.ModularEnergySystems.Interfaces.BoilerControlBus boilerControlBus
    annotation (Placement(transformation(extent={{-8,90},{12,110}})));
  Modelica.Blocks.Math.Add add2(k2=-1)
    annotation (Placement(transformation(extent={{-60,16},{-42,34}})));
  Modelica.Blocks.Math.Division devision1
    annotation (Placement(transformation(extent={{-50,-64},{-30,-44}})));
  Modelica.Blocks.Sources.RealExpression nominal_m_fow(y=m_flow_nom) "Nominal mass flow rate"
    annotation (Placement(transformation(extent={{-100,-80},{-60,-52}})));
  Modelica.Blocks.Routing.Multiplex4 multiplex4
    annotation (Placement(transformation(extent={{24,12},{44,32}})));
  SDF.NDTable boilerEffciency(
    nin=4,
    readFromFile=true,
    filename=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/DataBase/Boiler/General/Boiler_Generic_Characteristic_Chart.sdf"),

    dataset="/Characteristic chart",
    dataUnit="-",
    scaleUnits={"K","K","-","-"},
    interpMethod=SDF.Types.InterpolationMethod.Linear,
    extrapMethod=SDF.Types.ExtrapolationMethod.Hold) "Characteristic chart"
    annotation (Placement(transformation(extent={{60,12},{80,32}})));

  Modelica.Blocks.Math.Division devision
    annotation (Placement(transformation(extent={{-30,10},{-12,28}})));
  Modelica.Blocks.Sources.RealExpression ReturnTemp(y=TColdNom)
    "Nominal return temperature"
    annotation (Placement(transformation(extent={{-94,-18},{-48,6}})));
  Modelica.Blocks.Sources.RealExpression SupplyTemp(y=THotNom)
    "Nominal supply temperature"
    annotation (Placement(transformation(extent={{-94,-40},{-48,-16}})));
  Modelica.Blocks.Math.Add add1(k1=-1)
    annotation (Placement(transformation(extent={{-34,-22},{-14,-2}})));
protected
  parameter Modelica.Units.SI.MassFlowRate m_flow_nom=QNom/(Medium.cp_const*
      (THotNom-TColdNom));
equation

  connect(boilerControlBus.m_flowMea, devision1.u1) annotation (Line(
      points={{2,100},{-100,100},{-100,-48},{-52,-48}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(nominal_m_fow.y, devision1.u2) annotation (Line(points={{-58,-66},{-56,
          -66},{-56,-60},{-52,-60}}, color={0,0,127}));
  connect(boilerControlBus.TColdMea, add2.u2) annotation (Line(
      points={{2,100},{-100,100},{-100,19.6},{-61.8,19.6}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boilerControlBus.TSupplyMea, add2.u1) annotation (Line(
      points={{2,100},{-100,100},{-100,30.4},{-61.8,30.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(multiplex4.y, boilerEffciency.u)
    annotation (Line(points={{45,22},{58,22}}, color={0,0,127}));
  connect(boilerEffciency.y, boilerControlBus.Efficiency) annotation (Line(
        points={{81,22},{96,22},{96,68},{2,68},{2,100}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(add2.y, devision.u1) annotation (Line(points={{-41.1,25},{-36.45,25},{
          -36.45,24.4},{-31.8,24.4}}, color={0,0,127}));
  connect(boilerControlBus.TColdMea, multiplex4.u1[1]) annotation (Line(
      points={{2,100},{2,31},{22,31}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ReturnTemp.y, add1.u1)
    annotation (Line(points={{-45.7,-6},{-36,-6}}, color={0,0,127}));
  connect(SupplyTemp.y, add1.u2) annotation (Line(points={{-45.7,-28},{-42,-28},
          {-42,-18},{-36,-18}}, color={0,0,127}));
  connect(add1.y, devision.u2) annotation (Line(points={{-13,-12},{6,-12},{6,6},
          {-38,6},{-38,13.6},{-31.8,13.6}}, color={0,0,127}));
  connect(add1.y, multiplex4.u4[1]) annotation (Line(points={{-13,-12},{6,-12},{
          6,13},{22,13}}, color={0,0,127}));
  connect(devision.y, multiplex4.u2[1]) annotation (Line(points={{-11.1,19},{-2,
          19},{-2,25},{22,25}}, color={0,0,127}));
  connect(devision1.y, multiplex4.u3[1]) annotation (Line(points={{-29,-54},{10,
          -54},{10,19},{22,19}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                      Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255}),
        Rectangle(
          extent={{-78,88},{86,-84}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={199,199,199},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-68,-68},{62,-68}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-68,-68},{-68,62}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-68,-68},{24,-8}},
          color={0,0,0},
          thickness=1),
        Polygon(
          points={{62,-64},{68,-68},{62,-72},{62,-64}},
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
          origin={-69,64},
          rotation=180),
        Polygon(
          points={{20,-6},{26,-6},{24,-12},{20,-6}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-32,76},{52,22}},
          textColor={0,0,0},
          fontName="Arial Black",
          textString="OffDesign
")}),                                                              Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p><span style=\"font-family: Arial;\">This model calculates the efficiency for operation from SDF in dependency on:</span></p>
<ul>
<li><span style=\"font-family: Arial;\">Return temperature</span></li>
<li><span style=\"font-family: Arial;\">Nominale temperature difference</span></li>
<li><span style=\"font-family: Arial;\">Relative water mass flow</span></li>
<li><span style=\"font-family: Arial;\">Realtive temperature difference</span></li>
</ul>
</html>", revisions="<html>
<ul>
<li>June, 2023  by Moritz Zuschlag &amp; David Jansen</li>
</ul>
</html>"));
end OffDesignOperation;
