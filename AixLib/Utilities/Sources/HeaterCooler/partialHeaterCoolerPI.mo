within AixLib.Utilities.Sources.HeaterCooler;
partial model partialHeaterCoolerPI
  extends AixLib.Utilities.Sources.HeaterCooler.partialHeaterCooler;
  parameter Real h_heater "upper limit controller output of the heater" annotation(Dialog(tab = "Heater", group = "Controller",enable=not recOrSep));
  parameter Real l_heater "lower limit controller output of the heater" annotation(Dialog(tab = "Heater", group = "Controller",enable=not recOrSep));
  parameter Real KR_heater "Gain of the heating controller" annotation(Dialog(tab = "Heater", group = "Controller",enable=not recOrSep));
  parameter Modelica.SIunits.Time TN_heater
    "Time constant of the heating controller" annotation(Dialog(tab = "Heater", group = "Controller",enable=not recOrSep));
  parameter Real h_cooler "upper limit controller output of the cooler" annotation(Dialog(tab = "Cooler", group = "Controller",enable=not recOrSep));
  parameter Real l_cooler "lower limit controller output of the cooler"           annotation(Dialog(tab = "Cooler", group = "Controller",enable=not recOrSep));
  parameter Real KR_cooler "Gain of the cooling controller" annotation(Dialog(tab = "Cooler", group = "Controller",enable=not recOrSep));
  parameter Modelica.SIunits.Time TN_cooler
    "Time constant of the cooling controller" annotation(Dialog(tab = "Cooler", group = "Controller",enable=not recOrSep));
  parameter Boolean Heater_on "Activates the heater"                                           annotation(Dialog(tab = "Heater",enable=not recOrSep));
  parameter Boolean Cooler_on "Activates the cooler" annotation(Dialog(tab = "Cooler",enable=not recOrSep));
  parameter Boolean withMeter = true
    "Select whether a heat meter is required. Saves significant integration time";
  parameter Boolean recOrSep = false "Use record or seperate parameters" annotation(choices(choice =  false
        "Seperate",choice = true "Record",radioButtons = true));
  parameter AixLib.DataBase.Buildings.ZoneBaseRecord zoneParam annotation(choicesAllMatching=true,Dialog(enable=recOrSep));
  Sensors.TEnergyMeter coolMeter if (not recOrSep and Cooler_on or recOrSep and zoneParam.Cooler_on) and withMeter
    "measures cooling energy"                                                     annotation(Placement(transformation(extent = {{40, -50}, {60, -30}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Cooling if not recOrSep and Cooler_on or recOrSep and zoneParam.Cooler_on annotation(Placement(transformation(extent={{26,-23},
            {6,-2}})));
  Control.PITemp pITempCool(
    RangeSwitch=false,
    h=if not recOrSep then h_cooler else zoneParam.h_cooler,
    l=if not recOrSep then l_cooler else zoneParam.l_cooler,
    KR=if not recOrSep then KR_cooler else zoneParam.KR_cooler,
    TN=if not recOrSep then TN_cooler else zoneParam.TN_cooler) if not recOrSep and Cooler_on or recOrSep and zoneParam.Cooler_on
    "PI control for cooler"
    annotation (Placement(transformation(extent={{-20,-10},{0,-30}})));
  Sensors.TEnergyMeter heatMeter if (not recOrSep and Heater_on or recOrSep and zoneParam.Heater_on) and withMeter
    "measures heating energy"                                                     annotation(Placement(transformation(extent = {{40, 30}, {60, 50}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Heating if not recOrSep and Heater_on or recOrSep and zoneParam.Heater_on annotation(Placement(transformation(extent={{26,22},
            {6,2}})));
  Control.PITemp pITempHeat(
    RangeSwitch=false,
    h=if not recOrSep then h_heater else zoneParam.h_heater,
    l=if not recOrSep then l_heater else zoneParam.l_heater,
    KR=if not recOrSep then KR_heater else zoneParam.KR_heater,
    TN=if not recOrSep then TN_heater else zoneParam.TN_heater) if not recOrSep and Heater_on or recOrSep and zoneParam.Heater_on
    "PI control for heater"                                                                                                     annotation (Placement(transformation(extent={{-20,10},{0,30}})));
equation
  connect(Heating.port, heatCoolRoom) annotation (Line(
        points={{6,12},{2,12},{2,-40},{90,-40}},
        color={191,0,0},
        smooth=Smooth.None));
  connect(pITempHeat.Therm1, heatCoolRoom) annotation (Line(
        points={{-16,11},{-16,-40},{90,-40}},
        color={191,0,0},
        smooth=Smooth.None));
  connect(Heating.Q_flow, heatMeter.p)     annotation (Line(
        points={{26,12},{26,40},{41.4,40}},
        color={0,0,127},
        smooth=Smooth.None));
  connect(pITempCool.y, Cooling.Q_flow) annotation (Line(
        points={{-1,-20},{26,-20},{26,-12.5}},
        color={0,0,127},
        smooth=Smooth.None));
  connect(Cooling.port, heatCoolRoom) annotation (Line(
        points={{6,-12.5},{2.4,-12.5},{2.4,-40},{90,-40}},
        color={191,0,0},
        smooth=Smooth.None));
  connect(pITempCool.Therm1, heatCoolRoom) annotation (Line(
        points={{-16,-11},{-16,-40},{90,-40}},
        color={191,0,0},
        smooth=Smooth.None));
  connect(Cooling.Q_flow, coolMeter.p)     annotation (Line(
        points={{26,-12.5},{26,-40},{41.4,-40}},
        color={0,0,127},
        smooth=Smooth.None));
  connect(Heating.Q_flow, pITempHeat.y) annotation (Line(points={{26,12},{26,20},{-1,20}}, color={0,0,127}));
  annotation (Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>This is the base class of an ideal heater and/or cooler. It is used in full ideal heater/cooler models as an extension. It extends another base class and adds some basic elements.</p>
 </html>", revisions="<html>
 <ul>
 <li><i>October, 2015&nbsp;</i> by Moritz Lauster:<br/>Adapted to Annex60 and restructuring, implementing new functionalities</li>
 </ul>
 <ul>
 <li><i>June, 2014&nbsp;</i> by Moritz Lauster:<br/>Added some basic documentation</li>
 </ul>
 </html>"));
end partialHeaterCoolerPI;
