within AixLib.Fluid.BoilerCHP.BaseClasses;
model OffDesignOperation "Calculation of operation for non-nominal/off-design conditions"

  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal=50000
    "Design thermal capacity";

  parameter Modelica.Units.SI.Temperature TSup_nominal=273.15 + 80
    "Design supply temperature" annotation (Dialog(group="Design"),Evaluate=false);

  parameter Modelica.Units.SI.Temperature TRet_nominal=273.15 + 60
    "Design return temperature" annotation (Dialog(group="Design"),Evaluate=false);
  replaceable package Medium = AixLib.Media.Water "Medium in the component"
      annotation (choices(
        choice(redeclare package Medium = AixLib.Media.Air "Moist air"),
        choice(redeclare package Medium = AixLib.Media.Water "Water"),
        choice(redeclare package Medium =
            AixLib.Media.Antifreeze.PropyleneGlycolWater (
              property_T=293.15,
              X_a=0.40)
              "Propylene glycol water, 40% mass fraction")));
  parameter String filename=ModelicaServices.ExternalReferences.loadResource(
    "modelica://AixLib/Resources/Data/Fluid/BoilerCHP/BaseClasses/GenericBoiler/Boiler_Generic_Characteristic_Chart.sdf")
    "Filename for generic boiler curves" annotation(Dialog(tab="Advanced"));
  AixLib.Controls.Interfaces.BoilerControlBus boiBus "Boiler bus"
    annotation (Placement(transformation(extent={{-8,90},{12,110}})));
  Modelica.Blocks.Math.Add dTMea(k2=-1) "Measured temperature spread"
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
  Modelica.Blocks.Math.Division relMFlow "Calculate relative mass flow rate"
    annotation (Placement(transformation(extent={{-50,-64},{-30,-44}})));
  Modelica.Blocks.Sources.Constant conMFlowNom(k=m_flow_nominal)
    "Nominal mass flow rate"
    annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
  Modelica.Blocks.Routing.Multiplex4 multiplex4
    annotation (Placement(transformation(extent={{20,20},{40,40}})));
  SDF.NDTable boiEff(
    nin=4,
    readFromFile=true,
    filename=filename,
    dataset="/Characteristic chart",
    dataUnit="-",
    scaleUnits={"K","K","-","-"},
    interpMethod=SDF.Types.InterpolationMethod.Linear,
    extrapMethod=SDF.Types.ExtrapolationMethod.Hold)
    "Characteristic chart of adiabatic efficiency"
    annotation (Placement(transformation(extent={{60,20},{80,40}})));

  Modelica.Blocks.Math.Division relTemSpr "Relative temperature spread"
    annotation (Placement(transformation(extent={{-20,20},{0,0}})));
  Modelica.Blocks.Sources.Constant dT_nominal(k=TSup_nominal - TRet_nominal)
    "Nominal temperature spread"
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
protected
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=Q_flow_nominal/(
      Medium.cp_const*(TSup_nominal - TRet_nominal));
equation

  connect(boiBus.m_flowMea, relMFlow.u1) annotation (Line(
      points={{2,100},{-100,100},{-100,-48},{-52,-48}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(conMFlowNom.y, relMFlow.u2) annotation (Line(points={{-79,-70},{-60,-70},
          {-60,-60},{-52,-60}}, color={0,0,127}));
  connect(multiplex4.y, boiEff.u) annotation (Line(points={{41,30},{58,30}},
                           color={0,0,127}));
  connect(dTMea.y, relTemSpr.u1) annotation (Line(points={{-39,-10},{-30,-10},{-30,
          4},{-22,4}}, color={0,0,127}));
  connect(relMFlow.y, multiplex4.u4[1])
    annotation (Line(points={{-29,-54},{18,-54},{18,21}}, color={0,0,127}));
  connect(relTemSpr.y, multiplex4.u3[1]) annotation (Line(points={{1,10},{10,10},
          {10,27},{18,27}}, color={0,0,127}));
  connect(boiBus.TRetMea, dTMea.u2) annotation (Line(
      points={{2,100},{-92,100},{-92,-16},{-62,-16}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boiBus.TRetMea, multiplex4.u1[1]) annotation (Line(
      points={{2,100},{-20,100},{-20,39},{18,39}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boiBus.TSupMea, dTMea.u1) annotation (Line(
      points={{2,100},{-92,100},{-92,-4},{-62,-4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(dT_nominal.y, relTemSpr.u2) annotation (Line(points={{-39,30},{-30,30},
          {-30,16},{-22,16}}, color={0,0,127}));
  connect(dT_nominal.y, multiplex4.u2[1]) annotation (Line(points={{-39,30},{8,30},
          {8,33},{18,33}}, color={0,0,127}));
  connect(boiEff.y, boiBus.eta) annotation (Line(points={{81,30},{90,30},{90,100},
          {2,100}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
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
    <p>This model calculates the adiabatic efficiency (reference is the higher heating value (includes vaporization enthalpy)) at off-design conditions for an operating point from a characteristic chart in dependency on:</p>
<ul>
<li>Nominal return temperature (TColdNom)</li>
<li>Nominal temperature difference (TColdNom-THotNom)</li>
<li>Relative temperature difference </li>
<li>Relative water mass flow </li>
</ul>
</html>", revisions="<html>
<ul>
<li>
<i>June, 2023</i> by Moritz Zuschlag; David Jansen<br/>
    First Implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/1147\">#1147</a>)
</li>
</ul>
</html>"));
end OffDesignOperation;
