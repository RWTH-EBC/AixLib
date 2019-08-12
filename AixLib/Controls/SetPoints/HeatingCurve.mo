within AixLib.Controls.SetPoints;
model HeatingCurve "Model of a heating curve"
  //General
  parameter Boolean use_tableData=true "Choose between tables or function to calculate TSet" annotation (
  Dialog(descriptionLabel = true),choices(
      choice=true "Table Data",
      choice=false "Function",
      radioButtons=true));
  parameter Modelica.SIunits.ThermodynamicTemperature TOffset(displayUnit="K") = 0
    "Offset to heating curve temperature" annotation (Dialog(descriptionLabel = true));
  //Function
  replaceable function HeatingCurveFunction =
      AixLib.Controls.SetPoints.Functions.PartialBaseFct                 "Function to calculate set temperature"  annotation(Dialog(enable=not use_tableData), choicesAllMatching=True);
  //Table Data
  parameter AixLib.DataBase.Boiler.DayNightMode.HeatingCurvesDayNightBaseDataDefinition heatingCurveRecord
    "Record with information about heating curve data"                                                                                                        annotation(Dialog(enable=
          use_tableData),                                                                                                                                                                                                  choicesAllMatching=True);
  parameter Real declination=1 "Declination of curve"
    annotation (Dialog(enable=use_tableData));

  //Dynamic room temperature
  parameter Boolean use_dynTRoom=true "If different room temperatures are required, set to true"   annotation(choices(checkBox=true), Dialog(
        group="Dynamic room Temperature"));
  parameter Modelica.SIunits.ThermodynamicTemperature TRoom_nominal=293.15 "Constant desired room temperature "
    annotation (Dialog(group="Dynamic room Temperature",enable=not use_dynTRoom));
  //Day-Night Mode:
  parameter AixLib.Utilities.Time.Types.ZeroTime zerTim=AixLib.Utilities.Time.Types.ZeroTime.Custom
    "Enumeration for choosing how reference time (time = 0) should be defined"
    annotation (Dialog(group="Night-Mode"));
  parameter Real day_hour=6 "Hour of day at which day mode is enabled" annotation(Dialog(group="Night-Mode",descriptionLabel = true));
  parameter Real night_hour=22 "Hour of day at which night mode is enabled" annotation (Dialog(group="Night-Mode",descriptionLabel = true));

  Modelica.Blocks.Interfaces.RealInput T_oda(unit="K") "Outdoor air temperature"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput TRoom_in(unit="K") if use_dynTRoom
                                                "Desired room temperature"
    annotation (Placement(transformation(extent={{-140,36},{-100,76}})));
  Modelica.Blocks.Interfaces.RealOutput TSet(unit="K")
    "Set temperature calculated by heating curve"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

protected
  Modelica.Blocks.Tables.CombiTable2D tableDay(
    final tableOnFile=false,
    final table=heatingCurveRecord.varFlowTempDay,
    final smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments) if use_tableData "Combi Table for day data";

  Modelica.Blocks.Tables.CombiTable2D tableNight(
    final tableOnFile=false,
    final table=heatingCurveRecord.varFlowTempNight,
    final smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments) if use_tableData "Combi Table for night data";

  Modelica.Blocks.Interfaces.RealOutput TSet_internal "Internal set temperature";
  Modelica.Blocks.Sources.RealExpression TRoomExp(y=TRoom_nominal) "Real expression for room temperature";
  Modelica.Blocks.Sources.Constant dec(k=declination) "Declination constant for connectors";
  AixLib.Utilities.Time.CalendarTime calTime(zerTim = zerTim) "Calendar-time to get current hour";
  Modelica.Blocks.Interfaces.RealInput TRoom_internal "Actual room temperature to calculate with";
  Modelica.Blocks.Math.UnitConversions.To_degC to_degC "Convert Kelvin to degC";
  AixLib.Utilities.Logical.SmoothSwitch dayNightSwitch if use_tableData "Switch between day and night mode";
  Modelica.Blocks.Interfaces.BooleanOutput isDay "Boolean to evaluate whether it is daytime or nighttime";

equation
  //Connect the room temperatures
  if use_dynTRoom then
    connect(TRoom_internal,TRoom_in);
  else
    connect(TRoom_internal,TRoomExp.y);
  end if;
  //Evaluate whether current time is daytime or nighttime
  if calTime.hour >= day_hour and calTime.hour < night_hour then
    isDay = true;
  else
    isDay = false;
  end if;
  //Convert Kelvin to degC for tables and function
  connect(T_oda, to_degC.u);
  //Connect all models if tables are used, else use the function to calculate the internal set temperature
  if use_tableData then
    connect(dec.y, tableDay.u2);
    connect(dec.y, tableNight.u2);
    connect(to_degC.y, tableDay.u1);
    connect(to_degC.y, tableNight.u1);
    connect(tableDay.y, dayNightSwitch.u1);
    connect(isDay, dayNightSwitch.u2);
    connect(tableNight.y, dayNightSwitch.u3);
    connect(dayNightSwitch.y, TSet_internal);
  else
    TSet_internal = HeatingCurveFunction(
      to_degC.y,
      TRoom_internal,
      isDay);
  end if;
  //Check if current outdoor air temperature is higher than the needed room temperature. If so, no heating is required
  //Else the needed offset is added and the temperature is adjusted according to the wished room temperature
  if T_oda >= TRoom_internal then
    TSet = TRoom_internal;
  else
    TSet =(TSet_internal + TOffset) + 273.15;
  end if;
  annotation (Icon(graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          lineColor={0,0,255},
          extent={{-150,105},{150,145}},
          textString="%name"),
        Ellipse(
          lineColor = {108,88,49},
          fillColor = {255,215,136},
          fillPattern = FillPattern.Solid,
          extent = {{-100,-100},{100,100}},
          visible = not use_tableData),
        Text(
          lineColor={108,88,49},
          extent={{-90.0,-90.0},{90.0,90.0}},
          textString="f",
          visible = not use_tableData),
        Line(points={{-112,-60},{-52,-92}}, color={28,108,200},visible = use_dynTRoom),
        Line(points={{-114,-64},{-110,-56}}, color={28,108,200},visible = use_dynTRoom),
        Line(points={{-100,-72},{-96,-64}}, color={28,108,200},visible = use_dynTRoom),
        Line(points={{-84,-80},{-80,-72}}, color={28,108,200},visible = use_dynTRoom),
        Line(points={{-68,-88},{-64,-80}}, color={28,108,200},visible = use_dynTRoom),
        Line(points={{-54,-96},{-50,-88}}, color={28,108,200},visible = use_dynTRoom),
        Line(points={{-82,-76},{-64,-42},{-38,-8},{2,28},{44,56},{86,78}}, color={238,46,47},visible = use_tableData and declination>=1.8 and declination <2.2),
        Line(points={{-82,-76},{-56,-50},{-28,-30},{8,-14},{48,-2},{86,4}}, color={238,46,47},visible = use_tableData and declination>=0 and declination <1.4),
        Line(points={{-82,-76},{-62,-48},{-34,-22},{2,2},{42,22},{86,34}}, color={238,46,47},visible = use_tableData and declination>=1.4 and declination <1.8),
        Line(points={{-82,-76},{-68,-28},{-44,18},{-14,54},{26,82}}, color={238,46,47},visible = use_tableData and declination>=2.2),
        Line(points={{-82,84}}, color={28,108,200}),
        Rectangle(
          extent={{-82,-76},{86,82}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.None,
          visible = use_tableData),
        Text(
          extent={{-104,-102},{-74,-88}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="TRoom",
          visible = use_dynTRoom),
        Text(
          extent={{-102,82},{-72,96}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="TSet",
          visible = use_tableData),
        Text(
          extent={{34,-92},{96,-78}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="- TOda",
          visible = use_tableData)}));
end HeatingCurve;
