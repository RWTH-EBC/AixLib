within AixLib.Utilities.Sources.HeaterCooler;
model HeaterCoolerPI

  parameter Boolean recOrSep = false "Use record or seperate parameters" annotation(choices(choice =  false
      "Seperate",choice = true "Record",radioButtons = true));

  parameter Boolean Heater_on = true "Activates the heater" annotation(Dialog(tab = "Heater",enable=not recOrSep));
  parameter Real h_heater = 0 "Upper limit controller output of the heater" annotation(Dialog(tab="Heater", group="Controller",enable=not recOrSep));
  parameter Real l_heater = 0 "Lower limit controller output of the heater" annotation(Dialog(tab="Heater", group="Controller",enable=not recOrSep));
  parameter Real KR_heater = 1000 "Gain of the heating controller" annotation(Dialog(tab = "Heater", group="Controller",enable=not recOrSep));
  parameter Modelica.Units.SI.Time TN_heater = 1 "Time constant of the heating controller" annotation (Dialog(tab="Heater",group="Controller",enable=not recOrSep));
  parameter Real fraRad_heater = 0 "Fraction of heating power to radiation" annotation(Dialog(tab = "Heater", group="Transfer system",enable=not recOrSep));
  parameter Real k_dampedTransfer_heater = 1 "Gain of PT1 for damped heating transfer" annotation(Dialog(tab="Heater", group="Transfer system", enable=not recOrSep));
  parameter Modelica.Units.SI.Time Tau_dampedTransfer_heater = 1 "Time Constant of PT1 for damped heating transfer" annotation (Dialog(tab="Heater", group = "Transfer system", enable=not recOrSep));

  parameter Boolean Cooler_on = true "Activates the cooler" annotation(Dialog(tab = "Cooler",enable=not recOrSep));
  parameter Real h_cooler = 0 "Upper limit controller output of the cooler"
                                                                           annotation(Dialog(tab = "Cooler", group = "Controller",enable=not recOrSep));
  parameter Real l_cooler = 0 "Lower limit controller output of the cooler"
                                                                           annotation(Dialog(tab = "Cooler", group = "Controller",enable=not recOrSep));
  parameter Real KR_cooler = 1000 "Gain of the cooling controller"
                                                                  annotation(Dialog(tab = "Cooler", group = "Controller",enable=not recOrSep));
  parameter Modelica.Units.SI.Time TN_cooler = 1 "Time constant of the cooling controller" annotation (Dialog(tab="Cooler",group="Controller",enable=not recOrSep));
  parameter Real fraRad_cooler = 0 "Fraction of cooling power to radiation" annotation(Dialog(tab="Cooler", group="Transfer system", enable=not recOrSep));
  parameter Real k_dampedTransfer_cooler = 1 "Gain of PT1 for damped heating transfer" annotation(Dialog(tab = "Cooler", group = "Transfer system", enable=not recOrSep));
  parameter Modelica.Units.SI.Time Tau_dampedTransfer_cooler = 1 "Time Constant of PT1 for damped heating transfer" annotation (Dialog(tab="Cooler", group = "Transfer system", enable=not recOrSep));

  parameter AixLib.DataBase.ThermalZones.ZoneBaseRecord zoneParam(
    heaLoadFacGrd=0,
    heaLoadFacOut=0) =  AixLib.DataBase.ThermalZones.ZoneRecordDummy()
    "Zone definition"
                     annotation(choicesAllMatching=true,Dialog(enable=recOrSep));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatCoolRoom
    "Heat port to thermal zone"
                               annotation(Placement(transformation(extent={{80,-50},
            {100,-30}}), iconTransformation(extent={{80,-50},{100,-30}})));
  AixLib.Controls.Continuous.PITemp pITempCool(
    rangeSwitch=false,
    h=if not recOrSep then h_cooler else zoneParam.hCool,
    l=if not recOrSep then l_cooler else zoneParam.lCool,
    KR=if not recOrSep then KR_cooler else zoneParam.KRCool,
    TN=if not recOrSep then TN_cooler else zoneParam.TNCool)
    if ((recOrSep and zoneParam.CoolerOn) or (not recOrSep and Cooler_on))
    "PI control for cooler"
    annotation (Placement(transformation(extent={{-20,-10},{0,-30}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heaCon
    if ((recOrSep and zoneParam.HeaterOn) or (not recOrSep and Heater_on))
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={58,80})));
  AixLib.Controls.Continuous.PITemp pITempHeat(
    rangeSwitch=false,
    h=if not recOrSep then h_heater else zoneParam.hHeat,
    l=if not recOrSep then l_heater else zoneParam.lHeat,
    KR=if not recOrSep then KR_heater else zoneParam.KRHeat,
    TN=if not recOrSep then TN_heater else zoneParam.TNHeat)
    if ((recOrSep and zoneParam.HeaterOn) or (not recOrSep and Heater_on))
    "PI control for heater"
    annotation (Placement(transformation(extent={{-20,10},{0,30}})));
  Modelica.Blocks.Interfaces.RealOutput heatingPower(
   final quantity="HeatFlowRate",
   final unit="W") if ((recOrSep and zoneParam.HeaterOn) or (not recOrSep and
    Heater_on))    "Power for heating"
    annotation (Placement(transformation(extent={{80,20},{120,60}}),
        iconTransformation(extent={{80,20},{120,60}})));
  Modelica.Blocks.Interfaces.RealOutput coolingPower(
   final quantity="HeatFlowRate",
   final unit="W") if ((recOrSep and zoneParam.CoolerOn) or (not recOrSep and
    Cooler_on))    "Power for cooling"
    annotation (Placement(transformation(extent={{80,-26},{120,14}}),
        iconTransformation(extent={{80,-26},{120,14}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorRad
    "Heat port to thermal zone" annotation (Placement(transformation(extent={{80,
            -80},{100,-60}}), iconTransformation(extent={{80,-100},{100,-80}})));
  Modelica.Blocks.Math.Gain gainRad(k=fraRad_heater)
    if ((recOrSep and zoneParam.HeaterOn) or (not recOrSep and Heater_on))
    annotation (Placement(transformation(extent={{20,40},{40,60}})));
  Modelica.Blocks.Math.Gain gainCon(k=1 - fraRad_heater)
    if ((recOrSep and zoneParam.HeaterOn) or (not recOrSep and Heater_on))
    annotation (Placement(transformation(extent={{20,70},{40,90}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heaRad
    if ((recOrSep and zoneParam.HeaterOn) or (not recOrSep and Heater_on))
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={58,50})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow cooCon
    if ((recOrSep and zoneParam.CoolerOn) or (not recOrSep and Cooler_on))
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={58,-62})));
  Modelica.Blocks.Math.Gain gainCooRad(k=fraRad_cooler)
    if ((recOrSep and zoneParam.CoolerOn) or (not recOrSep and Cooler_on))
    annotation (Placement(transformation(extent={{20,-102},{40,-82}})));
  Modelica.Blocks.Math.Gain gainCooCon(k=1 - fraRad_cooler)
    if ((recOrSep and zoneParam.CoolerOn) or (not recOrSep and Cooler_on))
    annotation (Placement(transformation(extent={{20,-72},{40,-52}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow cooRad
    if ((recOrSep and zoneParam.CoolerOn) or (not recOrSep and Cooler_on))
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={58,-92})));
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


protected
  Modelica.Blocks.Continuous.FirstOrder firstOrderCooling(
    k=if not recOrSep then k_dampedTransfer_heater else zoneParam.kDampedTransferHea,
    T=if not recOrSep then Tau_dampedTransfer_heater else zoneParam.TauDampedTransferHea,
    initType=Modelica.Blocks.Types.Init.InitialState)
      if ((recOrSep and zoneParam.CoolerOn) or (not recOrSep and Cooler_on))
    "Emulates the belayed cooling flow into the building due to thermal activated building systems"
    annotation (Placement(transformation(extent={{-16,-82},{4,-62}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrderHeating(
    k=if not recOrSep then k_dampedTransfer_cooler else zoneParam.kDampedTransferCoo,
    T=if not recOrSep then Tau_dampedTransfer_cooler else zoneParam.TauDampedTransferCoo,
    initType=Modelica.Blocks.Types.Init.InitialState)
      if ((recOrSep and zoneParam.HeaterOn) or (not recOrSep and Heater_on))
    "Emulates the belayed heat flow into the building due to thermal activated building systems"
    annotation (Placement(transformation(extent={{-20,58},{0,78}})));

equation

  connect(heaCon.port, heatCoolRoom) annotation (Line(
      points={{68,80},{90,80},{90,-40}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(pITempHeat.heatPort, heatCoolRoom) annotation (Line(
      points={{-16,11},{-16,-40},{90,-40}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(pITempCool.heatPort, heatCoolRoom) annotation (Line(
      points={{-16,-11},{-16,-40},{90,-40}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(pITempCool.y, coolingPower) annotation (Line(points={{-1,-20},{74,-20},
          {74,-6},{100,-6}}, color={0,0,127}));
  connect(pITempHeat.y, heatingPower) annotation (Line(points={{-1,20},{74,20},{
          74,40},{100,40}}, color={0,0,127}));
  connect(gainCon.y, heaCon.Q_flow)
    annotation (Line(points={{41,80},{48,80}}, color={0,0,127}));
  connect(gainRad.y, heaRad.Q_flow)
    annotation (Line(points={{41,50},{48,50}}, color={0,0,127}));
  connect(heaRad.port, heaPorRad) annotation (Line(points={{68,50},{74,50},{74,42},
          {76,42},{76,-70},{90,-70}}, color={191,0,0}));
  connect(gainCooCon.y, cooCon.Q_flow)
    annotation (Line(points={{41,-62},{48,-62}}, color={0,0,127}));
  connect(gainCooRad.y, cooRad.Q_flow)
    annotation (Line(points={{41,-92},{48,-92}}, color={0,0,127}));
  connect(cooRad.port, heaPorRad) annotation (Line(points={{68,-92},{74,-92},{74,
          -70},{90,-70}}, color={191,0,0}));
  connect(cooCon.port, heatCoolRoom) annotation (Line(points={{68,-62},{68,-40},
          {90,-40}},          color={191,0,0}));

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

  connect(firstOrderHeating.y, gainCon.u) annotation (Line(points={{1,68},{10,68},
          {10,80},{18,80}}, color={0,0,127}));
  connect(firstOrderHeating.y, gainRad.u)
    annotation (Line(points={{1,68},{8,68},{8,50},{18,50}}, color={0,0,127}));
  connect(pITempHeat.y, firstOrderHeating.u) annotation (Line(points={{-1,20},{-1,
          44},{-30,44},{-30,68},{-22,68}}, color={0,0,127}));
  connect(pITempCool.y, firstOrderCooling.u) annotation (Line(points={{-1,-20},{
          2,-20},{2,-48},{-34,-48},{-34,-72},{-18,-72}}, color={0,0,127}));
  connect(firstOrderCooling.y, gainCooCon.u) annotation (Line(points={{5,-72},{10,
          -72},{10,-62},{18,-62}}, color={0,0,127}));
  connect(firstOrderCooling.y, gainCooRad.u) annotation (Line(points={{5,-72},{12,
          -72},{12,-84},{10,-84},{10,-92},{18,-92}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p>This is a heater and/or cooler with a PI-controller and a PT1-damper. It can be used as a realistic source for heating and cooling applications, considering inert behaviour of thermal heat transfer. Parameters of the PT1-damper can be defined in the zone records.</p>
<ul>
  <li>January, 2026 by Jonatan Höpp:<br/>
  Aggregated partial and non partial ideal heater/cooler models into one model.<br/>
  This new model includes:<br/>
    - Basic ideal heater/cooler<br/>
    - Optional fractioning of heat transfer into radiative and convective transfer<br/>
    - Optional damped heat transfer<br/>
  </li>
  <li>January 15, 2025 by Fabian Wuellhorst:<br/>
    Add option to split power into radiative and convective.
  </li>
  <li>
    <i>March 20, 2020 by Philipp Mehrfeld:</i><br/>
    <a href=\"https://github.com/RWTH-EBC/AixLib/issues/879\">#879</a>
    Assign dummy record as default parameter for zoneParam.
  </li>
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
</html>"));
end HeaterCoolerPI;
