within AixLib.Utilities.Sources.HeaterCooler;
partial model partialHeaterCoolerPI
  extends AixLib.Utilities.Sources.HeaterCooler.partialHeaterCooler;
  parameter Modelica.SIunits.HeatFlowRate Q_flow_heat
    "Heat flow rate of the heater" annotation(Dialog(tab = "Heater",enable=not recOrSep));
  parameter Real weightfactor_heater "weightfactor of the heater" annotation(Dialog(tab = "Heater",enable=not recOrSep));
  parameter Modelica.SIunits.HeatFlowRate Q_flow_cooler
    "Heat flow rate of the cooler" annotation(Dialog(tab = "Cooler",enable=not recOrSep));
  parameter Real weightfactor_cooler "weightfactor of the cooler" annotation(Dialog(tab = "Cooler",enable=not recOrSep));
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
  parameter Boolean Heater_on = false "Activates the heater"                                           annotation(Dialog(tab = "Heater",enable=not recOrSep));
  parameter Boolean Cooler_on = true "Activates the cooler" annotation(Dialog(tab = "Cooler",enable=not recOrSep));
  parameter Boolean withMeter = true
    "Select whether a heat meter is required. Saves significant integration time";
  parameter Boolean recOrSep = false "Use record or seperate parameters" annotation(choices(choice =  false
        "Seperate",choice = true "Record",radioButtons = true));
  parameter AixLib.DataBase.Buildings.ZoneBaseRecord zoneParam(Heater_on=false) annotation(choicesAllMatching=true,Dialog(enable=recOrSep));
  Sensors.TEnergyMeter coolMeter if Cooler_on "measures cooling energy" annotation(Placement(transformation(extent = {{40, -50}, {60, -30}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Cooling if (if not recOrSep then Cooler_on else zoneParam.Cooler_on) annotation(Placement(transformation(extent={{26,-23},
            {6,-2}})));
  Control.PITemp pITempCool(
    RangeSwitch=false,
    h=if not recOrSep then h_cooler else zoneParam.h_cooler,
    l=if not recOrSep then l_cooler else zoneParam.l_cooler,
    KR=if not recOrSep then KR_cooler else zoneParam.KR_cooler,
    TN=if not recOrSep then TN_cooler else zoneParam.TN_cooler) if                                                                                                     Cooler_on
    annotation (Placement(transformation(extent={{-20,-10},{0,-30}})));
  Sensors.TEnergyMeter heatMeter if Heater_on "measures heating energy" annotation(Placement(transformation(extent = {{40, 30}, {60, 50}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Heating if (if not recOrSep then Heater_on else zoneParam.Heater_on) annotation(Placement(transformation(extent={{26,22},
            {6,2}})));
  Control.PITemp pITempHeat(
    RangeSwitch=false,
    h=if not recOrSep then h_heater else zoneParam.h_heater,
    l=if not recOrSep then l_heater else zoneParam.l_heater,
    KR=if not recOrSep then KR_heater else zoneParam.KR_heater,
    TN=if not recOrSep then TN_heater else zoneParam.TN_heater) if                                                                                                     Heater_on
    annotation (Placement(transformation(extent={{-20,10},{0,30}})));
equation
  if (if not recOrSep then Heater_on else zoneParam.Heater_on) then
    connect(Heating.port, heatCoolRoom) annotation (Line(
        points={{6,12},{2,12},{2,0},{90,0}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(pITempHeat.Therm1, heatCoolRoom) annotation (Line(
        points={{-16,11},{-16,0},{90,0}},
        color={191,0,0},
        smooth=Smooth.None));
    if withMeter then
      connect(Heating.Q_flow, heatMeter.p)     annotation (Line(
        points={{26,12},{26,40},{41.4,40}},
        color={0,0,127},
        smooth=Smooth.None));
    end if;
  end if;
  if (if not recOrSep then Cooler_on else zoneParam.Cooler_on) then
    connect(pITempCool.y, Cooling.Q_flow) annotation (Line(
        points={{-1,-20},{26,-20},{26,-12.5}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Cooling.port, heatCoolRoom) annotation (Line(
        points={{6,-12.5},{2.4,-12.5},{2.4,0},{90,0}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(pITempCool.Therm1, heatCoolRoom) annotation (Line(
        points={{-16,-11},{-16,0},{90,0}},
        color={191,0,0},
        smooth=Smooth.None));
    if withMeter then
      connect(Cooling.Q_flow, coolMeter.p)     annotation (Line(
        points={{26,-12.5},{26,-40},{41.4,-40}},
        color={0,0,127},
        smooth=Smooth.None));
    end if;
  end if;
  connect(Heating.Q_flow, pITempHeat.y)
    annotation (Line(points={{26,12},{26,20},{-1,20}}, color={0,0,127}));
  annotation (Icon(graphics={  Rectangle(extent = {{-94, 6}, {80, -28}}, lineColor = {135, 135, 135}, fillColor = {135, 135, 135},
            fillPattern =                                                                                                   FillPattern.Solid), Polygon(points = {{-82, 6}, {-82, 40}, {-48, 6}, {-82, 6}}, lineColor = {135, 135, 135},
            lineThickness =                                                                                                   1, fillColor = {135, 135, 135},
            fillPattern =                                                                                                   FillPattern.Solid), Polygon(points = {{-46, 6}, {-8, 6}, {-8, 40}, {-46, 6}}, lineColor = {135, 135, 135},
            lineThickness =                                                                                                   1, fillColor = {135, 135, 135},
            fillPattern =                                                                                                   FillPattern.Solid), Polygon(points = {{30, 6}, {-8, 6}, {-8, 40}, {30, 6}}, lineColor = {135, 135, 135},
            lineThickness =                                                                                                   1, fillColor = {135, 135, 135},
            fillPattern =                                                                                                   FillPattern.Solid), Polygon(points = {{64, 6}, {64, 40}, {30, 6}, {64, 6}}, lineColor = {135, 135, 135},
            lineThickness =                                                                                                   1, fillColor = {135, 135, 135},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{64, -18}, {-80, -4}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   1, fillColor = {135, 135, 135},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "T_set_room<->T_air_room"), Line(points = {{-62, 24}, {-62, 50}}, color = {0, 128, 255}, thickness = 1), Line(points = {{-46, 10}, {-46, 50}}, color = {0, 128, 255}, thickness = 1), Line(points = {{-30, 24}, {-30, 50}}, color = {0, 128, 255}, thickness = 1), Line(points = {{-66, 48}, {-62, 54}, {-58, 48}}, color = {0, 128, 255}, thickness = 1), Line(points = {{-50, 48}, {-46, 54}, {-42, 48}}, color = {0, 128, 255}, thickness = 1), Line(points = {{-34, 48}, {-30, 54}, {-26, 48}}, color = {0, 128, 255}, thickness = 1), Line(points = {{16, 24}, {16, 50}}, color = {255, 0, 0}, thickness = 1), Line(points = {{12, 48}, {16, 54}, {20, 48}}, color = {255, 0, 0}, thickness = 1), Line(points = {{44, 24}, {44, 50}}, color = {255, 0, 0}, thickness = 1), Line(points = {{40, 48}, {44, 54}, {48, 48}}, color = {255, 0, 0}, thickness = 1), Line(points = {{30, 10}, {30, 50}}, color = {255, 0, 0}, thickness = 1), Line(points = {{26, 48}, {30, 54}, {34, 48}}, color = {255, 0, 0}, thickness = 1)}), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>This is the base class of an ideal heater and/or cooler. It is used in full ideal heater/cooler models as an extension. It extends another base class and adds some basic elements.</p>
 </html>", revisions = "<html>
 <ul>
 <li><i>June, 2014&nbsp;</i> by Moritz Lauster:<br/>Added some basic documentation</li>
 </ul>
 </html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})));
end partialHeaterCoolerPI;
