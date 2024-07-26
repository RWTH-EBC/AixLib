within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Examples;
model Test_PlateHeatExchanger
  "Simple test case for the two variants of plate heat exchanger"
  extends Modelica.Icons.Example;
  Components.HeatRecoverySystem plateHeatExchangerFixedEfficiency(redeclare
      model PartialPressureDrop = Components.PressureDrop.PressureDropSimple)
    annotation (Placement(transformation(extent={{-20,-60},{22,-20}})));
  Modelica.Blocks.Sources.Constant X_OdaIn(k=0.005)
    annotation (Placement(transformation(extent={{-100,-50},{-80,-30}})));
  Modelica.Blocks.Sources.Ramp T_OdaIn(
    height=10,
    duration=600,
    offset=273.15,
    startTime=600)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Modelica.Blocks.Sources.Ramp m_flow(
    height=1000/3600*1.18,
    duration=600,
    offset=2000/3600*1.18,
    startTime=1800)
    annotation (Placement(transformation(extent={{-100,30},{-80,50}})));
  Modelica.Blocks.Sources.Constant X_EtaIn(k=0.01)
    annotation (Placement(transformation(extent={{100,-40},{80,-20}})));
  Modelica.Blocks.Sources.Constant T_EtaIn(k=293.15)
    annotation (Placement(transformation(extent={{100,20},{80,40}})));
  Modelica.Blocks.Sources.Constant const(k=291.15)
    annotation (Placement(transformation(extent={{52,-10},{32,10}})));
equation
  connect(X_OdaIn.y, plateHeatExchangerFixedEfficiency.X_airInOda) annotation (
      Line(points={{-79,-40},{-60,-40},{-60,-36},{-22.1,-36}}, color={0,0,127}));
  connect(T_OdaIn.y, plateHeatExchangerFixedEfficiency.T_airInOda) annotation (
      Line(points={{-79,0},{-60,0},{-60,-30},{-22.1,-30}}, color={0,0,127}));
  connect(m_flow.y, plateHeatExchangerFixedEfficiency.m_flow_airInOda)
    annotation (Line(points={{-79,40},{-60,40},{-60,-24},{-22.1,-24}}, color={0,
          0,127}));
  connect(m_flow.y, plateHeatExchangerFixedEfficiency.m_flow_airInEta)
    annotation (Line(points={{-79,40},{-60,40},{-60,100},{60,100},{60,-24},{
          24.1,-24}}, color={0,0,127}));
  connect(X_EtaIn.y, plateHeatExchangerFixedEfficiency.X_airInEta) annotation (
      Line(points={{79,-30},{60,-30},{60,-36},{24.1,-36}}, color={0,0,127}));
  connect(T_EtaIn.y, plateHeatExchangerFixedEfficiency.T_airInEta) annotation (
      Line(points={{79,30},{60,30},{60,-30},{24.1,-30}}, color={0,0,127}));
  connect(const.y, plateHeatExchangerFixedEfficiency.T_set)
    annotation (Line(points={{31,0},{1,0},{1,-18}}, color={0,0,127}));
annotation (experiment(StopTime=3600, __Dymola_NumberOfIntervals=3600),
 Documentation(info="<html><p>
  Testing <a href=
  \"modelica://SimpleAHU.Components.PlateHeatExchanger\">SimpleAHU.Components.PlateHeatExchanger</a>
  and <a href=
  \"modelica://SimpleAHU.Components.PlateHeatExchangerFixedEfficiency\">SimpleAHU.Components.PlateHeatExchangerFixedEfficiency</a>
  with changing massflow and temperature for outdoor air and exhaust
  air.
</p>
</html>"), Icon(graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent = {{-100,-100},{100,100}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points = {{-36,60},{64,0},{-36,-60},{-36,60}})}));
end Test_PlateHeatExchanger;
