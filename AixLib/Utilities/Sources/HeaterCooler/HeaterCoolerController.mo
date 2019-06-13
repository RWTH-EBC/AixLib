within AixLib.Utilities.Sources.HeaterCooler;
model HeaterCoolerController

  parameter Modelica.SIunits.Temperature THeatingThreshold=273.15 + 15
    "Temperature below heating is applied";
  parameter Modelica.SIunits.Temperature TCoolingThreshold=273.15 + 24
    "Temperature above heating is applied";
  parameter Integer numZones(min=1) = 1 "Number of zones";
  BoundaryConditions.WeatherData.Bus weaBus
    "Weather data bus"
    annotation (Placement(
    transformation(extent={{-117,53},{-83,85}}), iconTransformation(
    extent={{-92,28},{-62,58}})));
  Modelica.Blocks.Sources.Constant TAirThresholdHeating(k=THeatingThreshold)
    annotation (Placement(transformation(extent={{-56,6},{-44,18}})));
  Modelica.Blocks.Logical.Less less annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-2,20})));
  Modelica.Blocks.Interfaces.BooleanOutput heaterActive[numZones]
    "true if heater is active" annotation (Placement(transformation(extent={{72,
            10},{92,30}}), iconTransformation(extent={{72,10},{92,30}})));
  Modelica.Blocks.Interfaces.BooleanOutput coolerActive[numZones]
    "true if cooler is active" annotation (Placement(transformation(extent={{72,
            -30},{92,-10}}), iconTransformation(extent={{72,-30},{92,-10}})));
  Modelica.Blocks.Logical.Greater
                               greater
                                    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-2,-20})));
  Modelica.Blocks.Sources.Constant TAirThresholdCooling(k=TCoolingThreshold)
    annotation (Placement(transformation(extent={{-56,-34},{-44,-22}})));
  Modelica.Blocks.Routing.BooleanReplicator booleanReplicator(nout=numZones)
    annotation (Placement(transformation(extent={{34,-30},{54,-10}})));
  Modelica.Blocks.Routing.BooleanReplicator booleanReplicatorHeating(nout=
        numZones)
    annotation (Placement(transformation(extent={{34,10},{54,30}})));
equation
  connect(TAirThresholdHeating.y, less.u2)
    annotation (Line(points={{-43.4,12},{-14,12}}, color={0,0,127}));
  connect(weaBus.TDryBul, less.u1) annotation (Line(
      points={{-100,69},{-32,69},{-32,20},{-14,20}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(TAirThresholdCooling.y, greater.u2)
    annotation (Line(points={{-43.4,-28},{-14,-28}}, color={0,0,127}));
  connect(weaBus.TDryBul, greater.u1) annotation (Line(
      points={{-100,69},{-100,-10},{-30,-10},{-30,-20},{-14,-20}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(booleanReplicatorHeating.y, heaterActive)
    annotation (Line(points={{55,20},{82,20}}, color={255,0,255}));
  connect(booleanReplicator.y, coolerActive)
    annotation (Line(points={{55,-20},{82,-20}}, color={255,0,255}));
  connect(less.y, booleanReplicatorHeating.u)
    annotation (Line(points={{9,20},{32,20}}, color={255,0,255}));
  connect(greater.y, booleanReplicator.u)
    annotation (Line(points={{9,-20},{32,-20}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                              Rectangle(extent = {{-80, 80}, {80, -80}}, lineColor = {135, 135, 135}, fillColor = {255, 255, 170},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{-58, 32}, {62, -20}}, lineColor = {175, 175, 175}, textString = "%name")}),
      Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview </span></h4>
<p>This is a simple controller which sets a threshold for heating and cooling  based on the outside temperature. This should prevent heating in summer if the AHU lowers the temperature below set temperature of ideal heater and cooler and vice versa in winter.</p>
</html>"));
end HeaterCoolerController;
