within AixLib.Fluid.BoilerCHP.BaseClasses;
model OffDesignOperation "Calculation of operation for non-nominal/off-design conditions"

  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal=50000
    "Design thermal capacity";

  parameter Modelica.Units.SI.Temperature TSup_nominal=273.15 + 80
    "Design supply temperature" annotation (Dialog(group="Design"),Evaluate=false);

  parameter Modelica.Units.SI.Temperature TRet_nominal=273.15 + 60
    "Design return temperature" annotation (Dialog(group="Design"),Evaluate=false);


package Medium=AixLib.Media.Water;

  Controls.Interfaces.BoilerControlBus                     boilerControlBus
    annotation (Placement(transformation(extent={{-8,90},{12,110}})));
  Modelica.Blocks.Math.Add add2(k2=-1)
    annotation (Placement(transformation(extent={{-68,-26},{-50,-8}})));
  Modelica.Blocks.Math.Division devision1
    annotation (Placement(transformation(extent={{-50,-64},{-30,-44}})));
  Modelica.Blocks.Sources.RealExpression m_flow_nominalExp(y=m_flow_nom)
    "Nominal mass flow rate"
    annotation (Placement(transformation(extent={{-100,-80},{-60,-52}})));
  Modelica.Blocks.Routing.Multiplex4 multiplex4
    annotation (Placement(transformation(extent={{24,10},{46,32}})));
  SDF.NDTable boilerEffciency(
    nin=4,
    readFromFile=true,
    filename=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Resources/Data/Fluid/BoilerCHP/BaseClasses/GenericBoiler/Boiler_Generic_Characteristic_Chart.sdf"),
    dataset="/Characteristic chart",
    dataUnit="-",
    scaleUnits={"K","K","-","-"},
    interpMethod=SDF.Types.InterpolationMethod.Linear,
    extrapMethod=SDF.Types.ExtrapolationMethod.Hold)
    "Characteristic chart of adiabatic efficiency"
    annotation (Placement(transformation(extent={{60,12},{80,32}})));

  Modelica.Blocks.Math.Division devision
    annotation (Placement(transformation(extent={{-30,-30},{-12,-12}})));
  Modelica.Blocks.Sources.RealExpression TRetNomExp(y=TRet_nominal)
    "Nominal return temperature"
    annotation (Placement(transformation(extent={{-92,18},{-46,42}})));
  Modelica.Blocks.Sources.RealExpression TSupNomExp(y=TSup_nominal)
    "Nominal supply temperature"
    annotation (Placement(transformation(extent={{-92,-4},{-46,20}})));
  Modelica.Blocks.Math.Add add1(k1=-1)
    annotation (Placement(transformation(extent={{-32,14},{-12,34}})));
protected
  parameter Modelica.Units.SI.MassFlowRate m_flow_nom=Q_flow_nominal/(Medium.cp_const
      *(TSup_nominal - TRet_nominal));
equation

  connect(boilerControlBus.m_flowMea, devision1.u1) annotation (Line(
      points={{2,100},{-100,100},{-100,-48},{-52,-48}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(m_flow_nominalExp.y, devision1.u2) annotation (Line(points={{-58,-66},
          {-56,-66},{-56,-60},{-52,-60}}, color={0,0,127}));
  connect(multiplex4.y, boilerEffciency.u)
    annotation (Line(points={{47.1,21},{52,21},{52,22},{58,22}},
                                               color={0,0,127}));
  connect(boilerEffciency.y, boilerControlBus.Efficiency) annotation (Line(
        points={{81,22},{96,22},{96,68},{2,68},{2,100}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(add2.y, devision.u1) annotation (Line(points={{-49.1,-17},{-36.45,-17},
          {-36.45,-15.6},{-31.8,-15.6}},
                                      color={0,0,127}));
  connect(TRetNomExp.y, add1.u1)
    annotation (Line(points={{-43.7,30},{-34,30}}, color={0,0,127}));
  connect(TSupNomExp.y, add1.u2) annotation (Line(points={{-43.7,8},{-42,8},{
          -42,18},{-34,18}},    color={0,0,127}));
  connect(add1.y, devision.u2) annotation (Line(points={{-11,24},{2,24},{2,4},{
          -38,4},{-38,-26.4},{-31.8,-26.4}},color={0,0,127}));
  connect(add1.y, multiplex4.u2[1]) annotation (Line(points={{-11,24},{2,24},{2,
          24.3},{21.8,24.3}}, color={0,0,127}));
  connect(devision1.y, multiplex4.u4[1]) annotation (Line(points={{-29,-54},{14,
          -54},{14,11.1},{21.8,11.1}}, color={0,0,127}));
  connect(devision.y, multiplex4.u3[1]) annotation (Line(points={{-11.1,-21},{8,
          -21},{8,17.7},{21.8,17.7}}, color={0,0,127}));
  connect(boilerControlBus.TRetMea, add2.u2) annotation (Line(
      points={{2,100},{-100,100},{-100,-22.4},{-69.8,-22.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boilerControlBus.TRetMea, multiplex4.u1[1]) annotation (Line(
      points={{2,100},{2,30.9},{21.8,30.9}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boilerControlBus.TSupMea, add2.u1) annotation (Line(
      points={{2,100},{-100,100},{-100,-11.6},{-69.8,-11.6}},
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
          textString="OffDesign
")}),                                                              Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p><span style=\"font-family: Arial;\">This model calculates the adiabatic efficiency (reference is the higher heating value (includes vaporization enthalpy)) for an operating point from a characteristic chart in dependency on:</span></p>
<ul>
<li><span style=\"font-family: Arial;\">Nominal return temperature (TColdNom)</span></li>
<li><span style=\"font-family: Arial;\">Nominale temperature difference (TColdNom-THotNom)</span></li>
<li><span style=\"font-family: Arial;\">Nominal relative temperature difference </span></li>
<li><span style=\"font-family: Arial;\">Nominal relative water mass flow </span></li>
</ul>
</html>", revisions="<html>
<ul>
<li>June, 2023  by Moritz Zuschlag &amp; David Jansen</li>
</ul>
</html>"));
end OffDesignOperation;
