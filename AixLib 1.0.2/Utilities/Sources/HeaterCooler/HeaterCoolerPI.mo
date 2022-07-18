within AixLib.Utilities.Sources.HeaterCooler;
model HeaterCoolerPI "heater and cooler with variable setpoints"
  extends AixLib.Utilities.Sources.HeaterCooler.PartialHeaterCoolerPI;
  parameter Boolean staOrDyn = true "Static or dynamic activation of heater" annotation(choices(choice = true "Static", choice =  false "Dynamic",
                  radioButtons = true));
  Modelica.Blocks.Interfaces.RealInput setPointCool(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC") if ((recOrSep and zoneParam.CoolerOn) or (not recOrSep
     and Cooler_on))    annotation (
      Placement(transformation(extent={{-120,-60},{-80,-20}}),
        iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-24,-72})));
  Modelica.Blocks.Interfaces.RealInput setPointHeat(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC") if ((recOrSep and zoneParam.HeaterOn) or (not recOrSep
     and Heater_on))    annotation (
      Placement(transformation(extent={{-120,20},{-80,60}}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={22,-72})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpressionHeater(y=if not
        recOrSep then Heater_on else zoneParam.HeaterOn) if staOrDyn annotation (Placement(transformation(extent={{-52,14},{-33,30}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpressionCooler(y=if not
        recOrSep then Cooler_on else zoneParam.CoolerOn) if staOrDyn annotation (Placement(transformation(extent={{-52,-30},{-32,-14}})));
  Modelica.Blocks.Interfaces.BooleanInput heaterActive if not staOrDyn
    "Switches Controler on and off" annotation (Placement(transformation(extent=
           {{-120,-6},{-80,34}}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={68,-72})));
  Modelica.Blocks.Interfaces.BooleanInput coolerActive if not staOrDyn
    "Switches Controler on and off" annotation (Placement(transformation(extent=
           {{-120,-34},{-80,6}}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-70,-72})));
equation
  if staOrDyn then
    connect(booleanExpressionHeater.y, pITempHeat.onOff) annotation (Line(points={{-32.05,
          22},{-24,22},{-24,15},{-19,15}}, color={255,0,255},
        pattern=LinePattern.Dash));
    connect(booleanExpressionCooler.y, pITempCool.onOff) annotation (Line(points={{-31,
          -22},{-24,-22},{-24,-15},{-19,-15}}, color={255,0,255},
        pattern=LinePattern.Dash));
  else
    connect(heaterActive, pITempHeat.onOff) annotation (Line(points={{-100,14},{-60,
           14},{-60,15},{-19,15}}, color={255,0,255},
        pattern=LinePattern.Dash));
    connect(pITempCool.onOff, coolerActive) annotation (Line(points={{-19,-15},{-24,
          -15},{-24,-14},{-100,-14}}, color={255,0,255},
        pattern=LinePattern.Dash));
  end if;
  connect(setPointHeat, pITempHeat.setPoint)
    annotation (Line(points={{-100,40},{-18,40},{-18,29}}, color={0,0,127}));
  connect(setPointCool, pITempCool.setPoint) annotation (Line(points={{-100,-40},
          {-58,-40},{-18,-40},{-18,-29}}, color={0,0,127}));
  annotation (Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  This is just as simple heater and/or cooler with a PI-controller. It
  can be used as an quasi-ideal source for heating and cooling
  applications.
</p>
<ul>
  <li>
    <i>October, 2015&#160;</i> by Moritz Lauster:<br/>
    Adapted to Annex60 and restructuring, combined V1 and V2 as well as
    seperate parameter and record from EBC Libs
  </li>
</ul>
<ul>
  <li>
    <i>June, 2014&#160;</i> by Moritz Lauster:<br/>
    Added some basic documentation
  </li>
</ul>
</html>"), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}})),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})));
end HeaterCoolerPI;
