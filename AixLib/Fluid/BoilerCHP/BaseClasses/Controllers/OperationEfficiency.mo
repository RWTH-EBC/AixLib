within AixLib.Fluid.BoilerCHP.BaseClasses.Controllers;
model OperationEfficiency

parameter Modelica.Units.SI.TemperatureDifference dTNom=20
    "Nominal temperature difference of supply and return";
  parameter Modelica.Units.SI.Temperature TRetNom=273.15 + 60
    "Nominal return temperature";
  parameter Modelica.Units.SI.HeatFlowRate QNom=50000
    "Nominal thermal capacity";
  parameter
    AixLib.DataBase.Boiler.NotManufacturer.EtaTExhaust.EtaTExhaustBaseDataDefinition
    paramEta=AixLib.DataBase.Boiler.NotManufacturer.EtaTExhaust.Ambient1();

package Medium=AixLib.Media.Water;

  Modelica.Blocks.Sources.RealExpression deltaTNom(y=dTNom)
    "Nominal temperature difference between supply and return"
    annotation (Placement(transformation(extent={{-100,-34},{-42,2}})));
  Systems.ModularEnergySystems.Interfaces.BoilerControlBus boilerControlBus
    annotation (Placement(transformation(extent={{-8,90},{12,110}})));
  Modelica.Blocks.Math.Add add2(k2=-1)
    annotation (Placement(transformation(extent={{-60,16},{-42,34}})));
  Modelica.Blocks.Math.Division rel_m_flow "relative water mass flow"
    annotation (Placement(transformation(extent={{-50,-64},{-30,-44}})));
  Modelica.Blocks.Sources.RealExpression nominal_m_fow(y=m_flow_nom) "Nominal mass flow rate"
    annotation (Placement(transformation(extent={{-100,-80},{-60,-52}})));
  Modelica.Blocks.Routing.Multiplex4 multiplex4_1
    annotation (Placement(transformation(extent={{24,12},{44,32}})));
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
    annotation (Placement(transformation(extent={{60,12},{80,32}})));
  Modelica.Blocks.Math.Division relative_dT "relative temperature difference"
    annotation (Placement(transformation(extent={{-30,10},{-12,28}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1, uMin=PLR_min)
    "Limiter to make SDF simulation robust"
    annotation (Placement(transformation(extent={{-12,-64},{8,-44}})));
  Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=1, uMin=PLR_min)
    "Limiter to make SDF simulation robust"
    annotation (Placement(transformation(extent={{-2,22},{8,32}})));
protected
  parameter Modelica.Units.SI.MassFlowRate m_flow_nom=QNom/(Medium.cp_const*dTNom);
  parameter Real PLR_min=0.2;
equation

  connect(boilerControlBus.m_flowMea, rel_m_flow.u1) annotation (Line(
      points={{2,100},{-100,100},{-100,-48},{-52,-48}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(nominal_m_fow.y, rel_m_flow.u2) annotation (Line(points={{-58,-66},{-56,
          -66},{-56,-60},{-52,-60}}, color={0,0,127}));
  connect(boilerControlBus.TColdMea, add2.u2) annotation (Line(
      points={{2,100},{-100,100},{-100,19.6},{-61.8,19.6}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(deltaTNom.y, multiplex4_1.u4[1]) annotation (Line(points={{-39.1,-16},
          {0,-16},{0,12},{22,12},{22,13}}, color={0,0,127}));
  connect(boilerControlBus.TSupplyMea, add2.u1) annotation (Line(
      points={{2,100},{-100,100},{-100,30.4},{-61.8,30.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(multiplex4_1.y, boilerEffciency2.u)
    annotation (Line(points={{45,22},{58,22}}, color={0,0,127}));
  connect(boilerEffciency2.y, boilerControlBus.Efficiency) annotation (Line(
        points={{81,22},{96,22},{96,68},{2,68},{2,100}},          color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(deltaTNom.y, relative_dT.u2) annotation (Line(points={{-39.1,-16},{-36,
          -16},{-36,13.6},{-31.8,13.6}}, color={0,0,127}));
  connect(rel_m_flow.y, limiter.u)
    annotation (Line(points={{-29,-54},{-14,-54}}, color={0,0,127}));
  connect(limiter.y, multiplex4_1.u3[1]) annotation (Line(points={{9,-54},{16,-54},
          {16,19},{22,19}},               color={0,0,127}));
  connect(relative_dT.y, limiter1.u)
    annotation (Line(points={{-11.1,19},{-11.1,27},{-3,27}}, color={0,0,127}));
  connect(limiter1.y, multiplex4_1.u2[1]) annotation (Line(points={{8.5,27},{12,
          27},{12,25},{22,25}},             color={0,0,127}));
  connect(add2.y, relative_dT.u1) annotation (Line(points={{-41.1,25},{-36.45,
          25},{-36.45,24.4},{-31.8,24.4}}, color={0,0,127}));
  connect(boilerControlBus.TColdMea, multiplex4_1.u1[1]) annotation (Line(
      points={{2,100},{2,46},{14,46},{14,31},{22,31}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
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
          textString="Operating
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
end OperationEfficiency;
