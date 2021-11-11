within ControlUnity.flowTemperatureController;
model flowTemperatureControl_heatingCurve
  "Flow temperature control (power control) with heating curve"
   extends ControlUnity.flowTemperatureController.partialFlowtemperatureControl(severalHeatcurcuits=false);

   //Heating Curve
 replaceable function HeatingCurveFunction =
      AixLib.Controls.SetPoints.Functions.HeatingCurveFunction constrainedby
    AixLib.Controls.SetPoints.Functions.PartialBaseFct;
 parameter Boolean use_tableData=true  "Choose between tables or function to calculate TSet";
 parameter Real declination=1;
 parameter Real day_hour=0;
 parameter Real night_hour=24;
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
    annotation (Placement(transformation(extent={{-60,34},{-40,54}})));

equation

  connect(heatingCurve.TSet, PID1.u_s)
    annotation (Line(points={{-39,44},{-12,44}}, color={0,0,127}));
  connect(u, heatingCurve.T_oda)
    annotation (Line(points={{-100,-16},{-100,44},{-62,44}}, color={0,0,127}));
end flowTemperatureControl_heatingCurve;
