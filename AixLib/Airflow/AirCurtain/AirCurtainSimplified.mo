within AixLib.Airflow.AirCurtain;
model AirCurtainSimplified
  "Ideal model for the usage of an air curtain in the context of low order retail zones"
  parameter Modelica.Units.SI.VolumeFlowRate V_flowAirCur=5
    "Design volume flow rate of the air curtain";
  parameter Modelica.Units.SI.TemperatureDifference TAddAirCur=5
    "Temperature increase over the air curtain";
  parameter Real etaAirCur = 0.73
    "Efficiency of the air curtain";
  parameter Modelica.Units.SI.Density rho=1.25 "Air density";
  parameter Modelica.Units.SI.SpecificHeatCapacity c=1000
    "Specific heat capacity of air";
  parameter Modelica.Units.SI.Temperature TBou=287.15
    "Threshold of the ambient temperature when aircurtain becomes active";
  parameter Modelica.Units.SI.Power PAirCur=27500
    "The thermal Power of the air curtain, simplified use";
  Utilities.Psychrometrics.MixedTemperature mixedTemperature
    annotation (Placement(transformation(extent={{-6,-10},{14,10}})));
  Modelica.Blocks.Interfaces.RealInput TAmb "Ambient airtemperature in K"
    annotation (Placement(transformation(extent={{-128,-80},{-88,-40}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b
    port_b "heat port for heat transfer"
    annotation (Placement(transformation(extent={{110,-10},{130,10}})));

  Modelica.Blocks.Interfaces.RealOutput Power "Power used by the air curtain"
    annotation (Placement(transformation(extent={{118,70},{138,90}})));
  Modelica.Blocks.Interfaces.RealInput schedule "Signal for the schedule"
    annotation (Placement(transformation(extent={{-128,60},{-88,100}})));
equation

  if TAmb <= TBou and schedule > 0 then
    mixedTemperature.flowRate_flow2 = (1 - etaAirCur) * V_flowAirCur;
    mixedTemperature.flowRate_flow1 = etaAirCur * V_flowAirCur;
    mixedTemperature.temperature_flow1 = port_b.T + TAddAirCur;
    port_b.Q_flow = - etaAirCur * V_flowAirCur * rho * c * (mixedTemperature.mixedTemperatureOut - port_b.T);
    Power = PAirCur;
  else
    mixedTemperature.flowRate_flow2 = (1 - etaAirCur) * V_flowAirCur;
    mixedTemperature.flowRate_flow1 = etaAirCur * V_flowAirCur;
    mixedTemperature.temperature_flow1 = port_b.T;
    port_b.Q_flow = 0;
    Power = 0;
  end if;

  connect(TAmb, mixedTemperature.temperature_flow2) annotation (Line(points={{-108,
          -60},{-20,-60},{-20,-2},{-5.6,-2}}, color={0,0,127}));
   annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{120,120}}),                                  graphics={
        Rectangle(
          extent={{-80,80},{80,-80}},
          lineColor={28,108,200},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),                                                                                                                           Polygon(points={{
              -58,40},{-28,54},{24,50},{18,42},{70,34},{32,62},{26,56},{-44,56},
              {-58,40}},                                                                                                                                                                                                        lineColor = {0, 0, 0}, smooth = Smooth.Bezier, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid), Polygon(points={{
              60,-40},{30,-54},{-22,-50},{-16,-42},{-68,-34},{-30,-62},{-24,-56},
              {46,-56},{60,-40}},                                                                                                                                                                                                        lineColor = {0, 0, 0}, smooth = Smooth.Bezier, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid),
                                      Text(
          extent={{-152,118},{148,158}},
          textString="%name",
          lineColor={0,0,255})}),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            120,120}})),
    Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  This is an ideal model of an air curtain. It accounts for additional
  heat losses through an air curtain in the entrance zone.
</p>
<p>
  It accounts for an ideal temperature mixing of the ventilation air
  with the air curtain air.
</p>
<h4>
  <span style=\"color: #008000\">Assumptions</span>
</h4>
<p>
  Ideal mass balance: All air flow rate going outside through the
  entrance will be replace by ambient air flow going inside. This is
  mainly described by the air curtain efficiency. It mainly describes
  the share of total airflow of the air curtain staying inside.
</p>
<p>
  Ideal temperature mixing: Ideal mixing of two air flows with
  different temperatures
</p>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/Airflow/AirCurtain/AirCurtain.png\"
  alt=\"schema of AirCurtain\">
</p>
<ul>
  <li>
    <i>Novmeber, 2018&#160;</i> by Michael Mans:<br/>
    Model implemented
  </li>
</ul>
</html>"));
end AirCurtainSimplified;
