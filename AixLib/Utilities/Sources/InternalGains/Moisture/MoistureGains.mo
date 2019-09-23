within AixLib.Utilities.Sources.InternalGains.Moisture;
model MoistureGains
  "model for moisture gains that are produced by plants, cooking, etc."

  parameter Real specificMoistureProduction(unit="g/(h.m.m)") = 0.5
    "specific moisture production without persons in the room due to plants, cooking, showering, etc.";
  parameter Modelica.SIunits.Area RoomArea = 20 "Area of room";
  parameter Modelica.SIunits.Temperature T0 = Modelica.SIunits.Conversions.from_degC(22)
    "Initial temperature";

  Modelica.Blocks.Interfaces.RealOutput MoistGain "in kg/s"
    annotation (Placement(transformation(extent={{86,30},{106,50}})));
  Modelica.Blocks.Sources.Constant MoistureGain(k=specificMoistureProduction)
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  Modelica.Blocks.Math.Gain squareMetre(k=RoomArea)
    annotation (Placement(transformation(extent={{-30,0},{-10,20}})));
  Modelica.Blocks.Math.Gain toKgPerSeconds(k=1/(1000*3600))
    annotation (Placement(transformation(extent={{14,0},{34,20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow ConvectiveHeat(T_ref=T0)   annotation(Placement(transformation(extent={{22,-66},
            {42,-46}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ConvHeat
    "convective heat connector"                                                            annotation(Placement(transformation(extent={{80,-58},
            {100,-38}}),                                                                                                                                        iconTransformation(extent={{80,-58},
            {100,-38}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-90, 64})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a TRoom
    "Air temperature in room"                                                         annotation(Placement(transformation(extent={{-90,74},
            {-70,94}})));
  Modelica.Blocks.Math.UnitConversions.To_degC to_degC annotation(Placement(transformation(extent={{-6,-6},
            {6,6}},
        rotation=-90,
        origin={-90,36})));
  Modelica.Blocks.Math.Product toLatentHeat
    annotation (Placement(transformation(extent={{4,-34},{-16,-14}})));
  Modelica.Blocks.Sources.RealExpression specificLatentHeat(y=
        enthalpyOfEvaporation + cp_steam*(temperatureSensor.T - 273.15))
    annotation (Placement(transformation(extent={{56,-44},{36,-24}})));
protected
  constant Modelica.SIunits.SpecificHeatCapacity cp_steam = AixLib.Utilities.Psychrometrics.Constants.cpSte
    "specific heat capacity of steam";
  constant Modelica.SIunits.SpecificEnthalpy enthalpyOfEvaporation = AixLib.Utilities.Psychrometrics.Constants.h_fg
    "enthalpy of vaporization";
equation
  connect(MoistureGain.y, squareMetre.u)
    annotation (Line(points={{-59,10},{-32,10}}, color={0,0,127}));
  connect(squareMetre.y, toKgPerSeconds.u)
    annotation (Line(points={{-9,10},{12,10}}, color={0,0,127}));
  connect(toKgPerSeconds.y, MoistGain) annotation (Line(points={{35,10},{62,10},
          {62,40},{96,40}}, color={0,0,127}));
  connect(ConvectiveHeat.port,ConvHeat)  annotation(Line(points={{42,-56},{46,-56},
          {46,-48},{90,-48}},                                                                               color = {191, 0, 0}, pattern = LinePattern.Solid));
  connect(TRoom,temperatureSensor. port) annotation(Line(points={{-80,84},{-80,82},
          {-90,82},{-90,74}},                                                             color = {191, 0, 0}, pattern = LinePattern.Solid));
  connect(temperatureSensor.T, to_degC.u)
    annotation (Line(points={{-90,54},{-90,43.2}}, color={0,0,127}));
  connect(toKgPerSeconds.y, toLatentHeat.u1) annotation (Line(points={{35,10},{48,
          10},{48,-18},{6,-18}}, color={0,0,127}));
  connect(specificLatentHeat.y, toLatentHeat.u2) annotation (Line(points={{35,-34},
          {22,-34},{22,-30},{6,-30}}, color={0,0,127}));
  connect(toLatentHeat.y, ConvectiveHeat.Q_flow) annotation (Line(points={{-17,
          -24},{-26,-24},{-26,-56},{22,-56}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p><b><font style=\"color: #008000; \">Overview</font></b> </p>
<p>This model gives the output for moisture release and latent heat release by plants, cooking, showering, etc. (except from persons). The moisture output has to be set in g/(h m²). </p>
<p><b><font style=\"color: #008000; \">Concept</font></b> </p>
<p>The moisture output is defined in some norms as an average output per hour and squaremetre. This output will be considered by this model. </p>
<p>The latent heat output depends on the air temperature in the room where the moisture sources are located. </p>
<p><b><font style=\"color: #008000; \">Assumptions</font></b> </p>
<p>The latent heat output does not affect the room temperature. Therefore the moisture output will be multiplied with its specific heat in gaseous state at the room temperature. </p>
<p>The latent heat release is assumed to be convective only.</p>
</html>", revisions="<html>
<ul>
  <li>
  July, 2019, by Martin Kremer:<br/>
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
