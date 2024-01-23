within AixLib.Obsolete.YearIndependent.FastHVAC.Components.HeatGenerators.Boiler;
model Boiler "Simple boiler model"
  extends AixLib.Obsolete.BaseClasses.ObsoleteModel;

  parameter FastHVAC.Media.BaseClasses.MediumSimple medium=
      FastHVAC.Media.WaterSimple()
    "Standard fluid charastics  (heat capacity, density, thermal conductivity)"
    annotation (choicesAllMatching);

  /* *******************************************************************
    Boiler Parameters
     ******************************************************************* */
  parameter
    AixLib.Obsolete.YearIndependent.FastHVAC.Data.Boiler.General.BoilerTwoPointBaseDataDefinition
    paramBoiler=
      AixLib.Obsolete.YearIndependent.FastHVAC.Data.Boiler.General.Boiler_Vitogas200F_11kW()
    "Parameters for Boiler" annotation (Dialog(tab="General", group=
          "Boiler type"), choicesAllMatching=true);

  parameter Modelica.Units.SI.Temperature T_start=
      Modelica.Units.Conversions.from_degC(50)
    "Initial temperature of heat source"
    annotation (Evaluate=true, Dialog(tab="General", group="Simulation"));

  /* *******************************************************************
      Components
      ******************************************************************* */

  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
                              heater
    annotation (Placement(transformation(extent={{-13.25,-12},{13.25,12}},
        rotation=180,
        origin={-3.25,-30})));

  Modelica.Blocks.Tables.CombiTable1Dv tableEfficiency(
    tableOnFile=false,
    table=paramBoiler.eta,
    columns={2},
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
    annotation (Placement(transformation(extent={{-17.5,22.5},{-7,33}})));
  Modelica.Blocks.Interfaces.RealInput dotQ_rel( unit="1") "[0 to 1]" annotation (
      Placement(transformation(
        extent={{-15.25,-15.25},{15.25,15.25}},
        rotation=270,
        origin={-40.25,98.75}), iconTransformation(
        extent={{-10.125,-10.125},{10.125,10.125}},
        rotation=270,
        origin={-20.125,70.125})));
  Modelica.Blocks.Math.Gain dotQNormated(k=paramBoiler.Q_nom)
    annotation (Placement(transformation(extent={{-18,43.5},{-6,56}})));
  Modelica.Blocks.Interfaces.RealOutput dotE_gas(unit="W") "1=gas consumption"
    annotation (Placement(transformation(extent={{98,24},{118,44}}),
        iconTransformation(extent={{50,40},{70,60}})));
  Modelica.Blocks.Interfaces.RealOutput E_gas(unit="J") "1=gas consumption"
    annotation (Placement(transformation(extent={{98,-10},{118,10}}),
        iconTransformation(extent={{50,-70},{70,-50}})));
  Modelica.Blocks.Continuous.Integrator integrator
    annotation (Placement(transformation(extent={{74,-10},{94,10}})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{26,24},{46,44}})));
  FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_a1
    "Thermal port for input values (temperature, mass flow rate, specific enthalpy, constant specific heat capacity)"
    annotation (Placement(transformation(extent={{-60,-12},{-40,8}}),
        iconTransformation(extent={{-60,-12},{-40,8}})));
  FastHVAC.Interfaces.EnthalpyPort_b enthalpyPort_b1
    "Thermal port for output values (temperature, mass flow rate, specific enthalpy, constant specific heat capacity)"
    annotation (Placement(transformation(extent={{40,-10},{60,10}}),
        iconTransformation(extent={{40,-10},{60,10}})));
  BaseClasses.WorkingFluid        boilerFluid(
  medium=medium,
  T0=T_start,
  m_fluid=medium.rho*paramBoiler.volume)
    annotation (Placement(transformation(extent={{-44,-82},{-4,-42}})));
  Modelica.Blocks.Interfaces.BooleanInput onOff_boiler annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-80,100}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={30,70})));
  Modelica.Blocks.Logical.Switch switch1 annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=0,
        origin={-44,28})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=0)
    annotation (Placement(transformation(extent={{-100,14},{-86,28}})));
  Modelica.Blocks.Math.Max max "ensures the lower boundary of boilers capacity" annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=270,
        origin={-56,50})));
  Modelica.Blocks.Sources.RealExpression capMin(y=paramBoiler.Q_min/
        paramBoiler.Q_nom) "Minimal capacity of boiler" annotation (
      Placement(transformation(
        extent={{-10,-9},{10,9}},
        rotation=270,
        origin={-71,74})));
equation

  //  OutputPower = -port_b.m_flow * 4184 * (ControlerHeater.Therm1.T - Tcold.T);
  //  eEnergyMeter_S.p=OutputPower;

  connect(integrator.y, E_gas) annotation (Line(
      points={{95,0},{108,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dotQNormated.y, division.u1) annotation (Line(
      points={{-5.4,49.75},{24,49.75},{24,40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(tableEfficiency.y[1], division.u2) annotation (Line(
      points={{-6.475,27.75},{24,27.75},{24,28}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(division.y, dotE_gas) annotation (Line(
      points={{47,34},{108,34}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(division.y, integrator.u) annotation (Line(
      points={{47,34},{72,34},{72,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(boilerFluid.enthalpyPort_a, enthalpyPort_a1) annotation (Line(
      points={{-42,-62},{-50,-62},{-50,-2}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(boilerFluid.enthalpyPort_b, enthalpyPort_b1) annotation (Line(
      points={{-6,-62},{50,-62},{50,0}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(onOff_boiler, switch1.u2) annotation (Line(
      points={{-80,100},{-80,28},{-53.6,28}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(realExpression.y, switch1.u3) annotation (Line(
      points={{-85.3,21},{-54,21},{-54,21.6},{-53.6,21.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(switch1.y, tableEfficiency.u[1]) annotation (Line(
      points={{-35.2,28},{-32,28},{-32,27.75},{-18.55,27.75}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(switch1.y, dotQNormated.u) annotation (Line(
      points={{-35.2,28},{-32,28},{-32,49.75},{-19.2,49.75}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dotQ_rel, max.u1) annotation (Line(
      points={{-40.25,98.75},{-40.25,60},{-51.2,60},{-51.2,59.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(capMin.y, max.u2) annotation (Line(
      points={{-71,63},{-71,59.6},{-60.8,59.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(max.y, switch1.u1) annotation (Line(
      points={{-56,41.2},{-56,34.4},{-53.6,34.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dotQNormated.y, heater.Q_flow) annotation (Line(
      points={{-5.4,49.75},{14,49.75},{14,-30},{10,-30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heater.port, boilerFluid.heatPort) annotation (Line(
      points={{-16.5,-30},{-24,-30},{-24,-43.2}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-50,60.5},{50,-70}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={170,170,255}),
        Polygon(
          points={{-17.5,-29.5},{-25.5,-13.5},{-3.5,30.5},{4.5,4.5},{
              26.5,8.5},{16.5,-33.5},{-1.5,-29.5},{-7.5,-29.5},{-17.5,-29.5}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,127,0}),
        Rectangle(
          extent={{-25.5,-27.5},{28.5,-35.5}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Polygon(
          points={{-15.5,-27.5},{-5.5,-7.5},{20.5,-27.5},{-5.5,-27.5},{
              -15.5,-27.5}},
          lineColor={255,255,170},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
          Text(
          extent={{-152,-72},{148,-112}},
          textString="%name",
          lineColor={0,0,255})}),
    Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Boiler model without an internal controller.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The boilers parameterization is based on records from the <a href=
  \"DataBase.Boiler.General.BoilerTwoPointBaseDataDefinition\">DataBase</a>
  library. In the range of minimal and nominal heat power a modulating
  operation is possible.
</p>
<p>
  The control strategy is pretended from an external controller. There
  is an ON/OFF switch for the boiler and also a possibility to control
  the modulating operation, boilers capacity.
</p>
<p>
  Both, actually and intigrated gas consumption can be taken from
  boilers outputs.
</p>
<h4>
  <span style=\"color:#008000\">Example Results</span>
</h4>
<p>
  <a href=\"FastHVAC.Examples.HeatGenerators.Boiler.Boiler\">Boiler</a>
</p>
</html>",
  revisions="<html><ul>
  <li>
    <i>November 28, 2016&#160;</i> Tobias Blacha:<br/>
    Moved into AixLib
  </li>
  <li>
    <i>February 09, 2015&#160;</i> Konstantin Finkbeiner:<br/>
    Implemented
  </li>
</ul>
</html>"));
end Boiler;
