within ControlUnity.flowTemperatureController;
model flowTemperatureControl_heatingCurve
  "Flow temperature control (power control) for the modularBoiler model"
   //Heating Curve
 replaceable function HeatingCurveFunction =
      AixLib.Controls.SetPoints.Functions.HeatingCurveFunction constrainedby
    AixLib.Controls.SetPoints.Functions.PartialBaseFct;
 parameter Boolean use_tableData=true  "Choose between tables or function to calculate TSet";
 parameter Real declination=1;
 parameter Real day_hour=6;
 parameter Real night_hour=22;
 parameter AixLib.Utilities.Time.Types.ZeroTime zerTim=AixLib.Utilities.Time.Types.ZeroTime.NY2017
    "Enumeration for choosing how reference time (time = 0) should be defined. Used for heating curve";

  AixLib.Controls.SetPoints.HeatingCurve heatingCurve(
    final TOffset=0,
    final use_dynTRoom=false,
    final zerTim=zerTim,
    final day_hour=day_hour,
    final night_hour=night_hour,
    final heatingCurveRecord=
        AixLib.DataBase.Boiler.DayNightMode.HeatingCurves_Vitotronic_Day23_Night10(),
    final declination=declination,
    redeclare function HeatingCurveFunction = HeatingCurveFunction,
    final use_tableData=true,
    final TRoom_nominal=293.15)
    annotation (Placement(transformation(extent={{-54,-20},{-34,0}})));

  Modelica.Blocks.Interfaces.RealInput Tamb "Outdoor temperature"
    annotation (Placement(transformation(extent={{-120,-30},{-80,10}})));
  PIRegler_modularBoiler pIRegler_modularBoiler
    annotation (Placement(transformation(extent={{22,-20},{42,0}})));
  Modelica.Blocks.Interfaces.RealInput Tin "Boiler temperature"
    annotation (Placement(transformation(extent={{-120,22},{-80,62}})));
  Modelica.Blocks.Interfaces.RealOutput PLRset
    annotation (Placement(transformation(extent={{90,-14},{110,6}})));
equation

  connect(Tamb, heatingCurve.T_oda)
    annotation (Line(points={{-100,-10},{-56,-10}}, color={0,0,127}));
  connect(heatingCurve.TSet, pIRegler_modularBoiler.Tset) annotation (Line(
        points={{-33,-10},{-6,-10},{-6,-5},{22,-5}}, color={0,0,127}));
  connect(Tin, pIRegler_modularBoiler.T_m) annotation (Line(points={{-100,42},{16,
          42},{16,-13},{22,-13}}, color={0,0,127}));
  connect(pIRegler_modularBoiler.PLR_vorlauf, PLRset) annotation (Line(points={{
          42,-5},{68,-5},{68,-4},{100,-4}}, color={0,0,127}));
end flowTemperatureControl_heatingCurve;
