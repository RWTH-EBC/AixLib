within AixLib.Airflow.AirCurtain;
model AirCurtainSimplyfied
  "Ideal model for the usage of an air curtain in the context of low order retail zones"
  Modelica.Blocks.Interfaces.RealInput Tambient
    annotation (Placement(transformation(extent={{-130,-80},{-90,-40}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b
    port_b
    annotation (Placement(transformation(extent={{110,-10},{130,10}})));
  parameter Modelica.SIunits.VolumeFlowRate VolumeFlowAirCurtain;
  parameter Modelica.SIunits.TemperatureDifference TemperatureAdditionAirCurtain;
  parameter Real eta_air_curtain "Efficiency of the air curtain";
  parameter Modelica.SIunits.Density rho = 1.25 "Air density";
  parameter Modelica.SIunits.SpecificHeatCapacity c = 1000
    "Specific heat capacity of air";
  parameter Modelica.SIunits.Temperature TemperatureThreshold
    "Threshold of the ambient temperature when aircurtain becomes active";
  Utilities.Psychrometrics.MixedTemperature mixedTemperature
    annotation (Placement(transformation(extent={{-6,-10},{14,10}})));
equation
  connect(Tambient, mixedTemperature.temperature_flow2);
  if Tambient <= TemperatureThreshold then
    mixedTemperature.flowRate_flow2 = (1 - eta_air_curtain) * VolumeFlowAirCurtain;
    mixedTemperature.flowRate_flow1 = eta_air_curtain * VolumeFlowAirCurtain;
    mixedTemperature.temperature_flow1 = port_b.T + TemperatureAdditionAirCurtain;
    port_b.Q_flow = eta_air_curtain * VolumeFlowAirCurtain * rho * c * (mixedTemperature.mixedTemperatureOut - port_b.T);
  else
    mixedTemperature.flowRate_flow2 = (1 - eta_air_curtain) * VolumeFlowAirCurtain;
    mixedTemperature.flowRate_flow1 = eta_air_curtain * VolumeFlowAirCurtain;
    mixedTemperature.temperature_flow1 = port_b.T;
    port_b.Q_flow = 0;
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
              -30,34},{30,-32}},                                                                                                                                                      lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "Air"),
                                                                                                                                                Polygon(points={{
              60,-40},{30,-54},{-22,-50},{-16,-42},{-68,-34},{-30,-62},{-24,-56},
              {46,-56},{60,-40}},                                                                                                                                                                                                        lineColor = {0, 0, 0}, smooth = Smooth.Bezier, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid)}),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{120,
            120}})),
    Documentation(info="<html>
<p>It should account for the thermal impact of air curtains to the thermal zone due to heating the air volumen in the zone and additional ventilation of the leckage of the air curtain.</p>
</html>"));
end AirCurtainSimplyfied;
