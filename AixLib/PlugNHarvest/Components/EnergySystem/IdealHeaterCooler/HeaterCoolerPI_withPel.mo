within AixLib.PlugNHarvest.Components.EnergySystem.IdealHeaterCooler;
model HeaterCoolerPI_withPel
  extends
    PlugNHarvest.Components.EnergySystem.IdealHeaterCooler.BaseClasses.PartialHeaterCoolerPI;

  parameter Boolean isEl_heater = false "heater is electrical";
  parameter Boolean isEl_cooler = true "cooler is electrical";
  parameter Real etaEl_heater = 2.5 "electrical efficiency of heater";
  parameter Real etaEl_cooler = 3.0 "electrical efficiency of cooler";
  Modelica.Blocks.Interfaces.RealOutput electricalPower_heater(final unit="W",
      final quantity="ElectricityFlowRate") "Electrical power for heating"
                                                                annotation (
      Placement(transformation(extent={{80,-90},{120,-50}}), iconTransformation(
          extent={{80,-80},{100,-60}})));
  Modelica.Blocks.Interfaces.RealOutput electricalPower_cooler(final unit="W",
      final quantity="ElectricityFlowRate") "Electrical power for cooling"
                                                                annotation (
      Placement(transformation(extent={{80,-116},{120,-76}}),
        iconTransformation(extent={{80,-100},{100,-80}})));

  Controls.Bus.GenEnegGenControlBus              ControlBus_idealHeater
    annotation (Placement(transformation(extent={{-64,-108},{-26,-76}})));
  Controls.Bus.GenEnegGenControlBus              ControlBus_idealCooler
    annotation (Placement(transformation(extent={{4,-106},{42,-74}})));
equation
  if isEl_heater then
    electricalPower_heater = heatingPower / etaEl_heater;
  else
    electricalPower_heater = 0.0;
  end if;

  if isEl_cooler then
    electricalPower_cooler = (-1) * coolingPower / etaEl_cooler;
  else
    electricalPower_cooler = 0.0;
  end if;

  connect(pITempCool.setPoint, ControlBus_idealCooler.setT_room) annotation (
      Line(points={{-18,-29},{-18,-36},{-30,-36},{-30,-90},{-4,-90},{-4,
          -89.92},{23.095,-89.92}},                          color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pITempHeat.setPoint, ControlBus_idealHeater.setT_room) annotation (
      Line(points={{-18,29},{-18,34},{-30,34},{-30,-92},{-36,-92},{-36,-91.92},
          {-44.905,-91.92}},                              color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pITempHeat.onOff, ControlBus_idealHeater.isOn) annotation (Line(
        points={{-19,15},{-30,15},{-30,-14},{-60,-14},{-60,-91.92},{-44.905,
          -91.92}},                                             color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pITempCool.onOff, ControlBus_idealCooler.isOn) annotation (Line(
        points={{-19,-15},{-19,-14},{-28,-14},{-28,-14},{-60,-14},{-60,-89.92},
          {23.095,-89.92}},                               color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  annotation (Documentation(info="<html>
<h4>Objective</h4>
<p>An ideal heater cooler with PI controller which also outputs the electrical power.</p>
<p>It uses control buses to conect with the controllers.</p>
</html>", revisions="<html>
<ul>
<li><i>November 26, 2017&nbsp;</i> by Ana Constantin:<br>Implemented</li>
</ul>
</html>"));
end HeaterCoolerPI_withPel;
