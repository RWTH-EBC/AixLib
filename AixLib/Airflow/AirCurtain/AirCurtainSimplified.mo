within AixLib.Airflow.AirCurtain;
model AirCurtainSimplified
  "Ideal model for the usage of an air curtain in the context of low order retail zones"
  Modelica.Blocks.Interfaces.RealInput T_ambient "Ambient airtemperature in K"
    annotation (Placement(transformation(extent={{-128,-80},{-88,-40}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b
    port_b "heat port for heat transfer"
    annotation (Placement(transformation(extent={{110,-10},{130,10}})));
  parameter Modelica.SIunits.VolumeFlowRate volumeFlowAirCurtain = 5
    "Design volume flow rate of the air curtain";
  parameter Modelica.SIunits.TemperatureDifference temperatureAdditionAirCurtain = 5
    "Temperature increase over the air curtain";
  parameter Real eta_air_curtain = 0.73
    "Efficiency of the air curtain";
  parameter Modelica.SIunits.Density rho = 1.25
    "Air density";
  parameter Modelica.SIunits.SpecificHeatCapacity c = 1000
    "Specific heat capacity of air";
  parameter Modelica.SIunits.Temperature temperatureThreshold = 287.15
    "Threshold of the ambient temperature when aircurtain becomes active";
  parameter Modelica.SIunits.Power powerAirCurtain = 27500
    "The thermal Power of the air curtain, simplified use";
  Utilities.Psychrometrics.MixedTemperature mixedTemperature
    annotation (Placement(transformation(extent={{-6,-10},{14,10}})));
  Modelica.Blocks.Interfaces.RealOutput powerOut
    "Power used by the air curtain"
    annotation (Placement(transformation(extent={{118,70},{138,90}})));
  Modelica.Blocks.Interfaces.RealInput schedule "Signal for the schedule"
    annotation (Placement(transformation(extent={{-128,60},{-88,100}})));
equation
  connect(T_ambient, mixedTemperature.temperature_flow2);
  if T_ambient <= TemperatureThreshold and schedule > 0 then
    mixedTemperature.flowRate_flow2 = (1 - eta_air_curtain) * VolumeFlowAirCurtain;
    mixedTemperature.flowRate_flow1 = eta_air_curtain * VolumeFlowAirCurtain;
    mixedTemperature.temperature_flow1 = port_b.T + TemperatureAdditionAirCurtain;
    port_b.Q_flow = - eta_air_curtain * VolumeFlowAirCurtain * rho * c * (mixedTemperature.mixedTemperatureOut - port_b.T);
    powerOut = PowerAirCurtain;
  else
    mixedTemperature.flowRate_flow2 = (1 - eta_air_curtain) * VolumeFlowAirCurtain;
    mixedTemperature.flowRate_flow1 = eta_air_curtain * VolumeFlowAirCurtain;
    mixedTemperature.temperature_flow1 = port_b.T;
    port_b.Q_flow = 0;
    powerOut = 0;
  end if;
   annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {120,120}}),                                        graphics={
        Rectangle(
          extent={{-80,80},{80,-80}},
          lineColor={28,108,200},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),                                                                                                                           Polygon(points={{
              -58,40},{-28,54},{24,50},{18,42},{70,34},{32,62},{26,56},{-44,56},
              {-58,40}},                                                                                                                                                                                                        lineColor = {0, 0, 0}, smooth = Smooth.Bezier, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent={{
              -30,34},{30,-32}},                                                                                                                                                      lineColor=
              {0,0,0},                                                                                                                                                                                       fillColor=
              {255,255,255},
            fillPattern=FillPattern.Solid,
          textString="AirCurtain"),                                                                                                             Polygon(points={{
              60,-40},{30,-54},{-22,-50},{-16,-42},{-68,-34},{-30,-62},{-24,-56},
              {46,-56},{60,-40}},                                                                                                                                                                                                        lineColor = {0, 0, 0}, smooth = Smooth.Bezier, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid)}),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{120,
            120}})),
    Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>This is an ideal model of an air curtain. It accounts for additional heat losses through an air curtain in the entrance zone.</p>
<p>It accounts for an ideal temperature mixing of the ventilation air with the air curtain air.</p>
<h4><span style=\"color: #008000\">Assumptions</span></h4>
<p>Ideal mass balance: All air flow rate going outside through the entrance will be replace by ambient air flow going inside. This is mainly described by the air curtain efficiency. It mainly describes the share of total airflow of the air curtain staying inside.</p>
<p>Ideal temperature mixing: Ideal mixing of two air flows with different temperatures</p>
<p><br><img src=\"//eonakku/home/ebc/mma/My Documents/My Pictures/AirCurtain.png\"/></p>
</html>", revisions="<html>
<ul>
  <li><i>Novmeber, 2018&nbsp;</i>
    by Michael Mans:<br/>
    Model implemented</li></p>
</html>"));
end AirCurtainSimplified;
