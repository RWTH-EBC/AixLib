within AixLib.Utilities.Sources.HeaterCooler;
partial model PartialHeaterCoolerPIFraRad
  extends AixLib.Utilities.Sources.HeaterCooler.PartialHeaterCooler;
  parameter Boolean Heater_on = true "Activates the heater" annotation(Dialog(tab = "Heater",enable=not recOrSep));
  parameter Boolean Cooler_on = true "Activates the cooler" annotation(Dialog(tab = "Cooler",enable=not recOrSep));
  parameter Real h_heater = 0 "Upper limit controller output of the heater" annotation(Dialog(tab = "Heater", group = "Controller",enable=not recOrSep));
  parameter Real l_heater = 0 "Lower limit controller output of the heater" annotation(Dialog(tab = "Heater", group = "Controller",enable=not recOrSep));
  parameter Real KR_heater = 1000 "Gain of the heating controller" annotation(Dialog(tab = "Heater", group = "Controller",enable=not recOrSep));
  parameter Modelica.Units.SI.Time TN_heater=1
    "Time constant of the heating controller" annotation (Dialog(
      tab="Heater",
      group="Controller",
      enable=not recOrSep));
  parameter Real h_cooler = 0 "Upper limit controller output of the cooler"
                                                                           annotation(Dialog(tab = "Cooler", group = "Controller",enable=not recOrSep));
  parameter Real l_cooler = 0 "Lower limit controller output of the cooler"          annotation(Dialog(tab = "Cooler", group = "Controller",enable=not recOrSep));
  parameter Real KR_cooler = 1000 "Gain of the cooling controller"
                                                                  annotation(Dialog(tab = "Cooler", group = "Controller",enable=not recOrSep));
  parameter Modelica.Units.SI.Time TN_cooler=1
    "Time constant of the cooling controller" annotation (Dialog(
      tab="Cooler",
      group="Controller",
      enable=not recOrSep));
  parameter Boolean recOrSep = false "Use record or seperate parameters" annotation(choices(choice =  false
        "Seperate",choice = true "Record",radioButtons = true));
  parameter AixLib.DataBase.ThermalZones.ZoneBaseRecord zoneParam(
    heaLoadFacGrd=0,
    heaLoadFacOut=0)                                              = AixLib.DataBase.ThermalZones.ZoneRecordDummy()
    "Zone definition"                                                            annotation(choicesAllMatching=true,Dialog(enable=recOrSep));
  parameter Real fraCooRad "Fraction of cooling power on radiative port";
  parameter Real fraHeaRad "Fraction of heating power on radiative port";
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
  Modelica.Blocks.Math.Gain gainRad(k=fraHeaRad)
    if ((recOrSep and zoneParam.HeaterOn) or (not recOrSep and Heater_on))
    annotation (Placement(transformation(extent={{20,40},{40,60}})));
  Modelica.Blocks.Math.Gain gainCon(k=1 - fraHeaRad)
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
  Modelica.Blocks.Math.Gain gainCooRad(k=fraCooRad)
    if ((recOrSep and zoneParam.CoolerOn) or (not recOrSep and Cooler_on))
    annotation (Placement(transformation(extent={{20,-102},{40,-82}})));
  Modelica.Blocks.Math.Gain gainCooCon(k=1 - fraCooRad)
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

  annotation (Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  This is the base class of an ideal heater and/or cooler. It is used
  in full ideal heater/cooler models as an extension. It extends
  another base class and adds some basic elements.
</p>
<ul>
  <li>
  <i>January 15, 2025 by Fabian Wuellhorst:</i><br/>
    Add option to split power into radiative and convective.
  </li>
  <li>
    <i>March 20, 2020 by Philipp Mehrfeld:</i><br/>
    <a href=\"https://github.com/RWTH-EBC/AixLib/issues/879\">#879</a>
    Assign dummy record as default parameter for zoneParam.
  </li>
  <li>
    <i>October, 2015&#160;</i> by Moritz Lauster:<br/>
    Adapted to Annex60 and restructuring, implementing new
    functionalities
  </li>
  <li>
    <i>June, 2014&#160;</i> by Moritz Lauster:<br/>
    Added some basic documentation
  </li>
</ul>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
end PartialHeaterCoolerPIFraRad;
