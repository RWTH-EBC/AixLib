within ControlUnity.flowTemperatureController;
model flowTemperatureControl_heatingCurve
  "Flow temperature control (power control) with heating curve"
   extends ControlUnity.flowTemperatureController.partialFlowtemperatureControl;

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
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));

equation

  connect(heatingCurve.TSet, PID.u_s)
    annotation (Line(points={{-49,0},{44,0}}, color={0,0,127}));
  connect(u, heatingCurve.T_oda)
    annotation (Line(points={{-100,0},{-72,0}}, color={0,0,127}));
end flowTemperatureControl_heatingCurve;
