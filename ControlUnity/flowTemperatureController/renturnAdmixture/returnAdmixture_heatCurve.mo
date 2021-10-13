within ControlUnity.flowTemperatureController.renturnAdmixture;
model returnAdmixture_heatCurve
  extends ControlUnity.flowTemperatureController.renturnAdmixture.partialReturnAdmixture(
  y=valveSet);


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
    annotation (Placement(transformation(extent={{-56,-26},{-36,-6}})));
  Modelica.Blocks.Interfaces.RealInput Tamb "Outdoor temperature"
    annotation (Placement(transformation(extent={{-120,-36},{-80,4}})));
equation
  connect(heatingCurve.TSet, PID.u_s)
    annotation (Line(points={{-35,-16},{18,-16}}, color={0,0,127}));
  connect(Tamb, heatingCurve.T_oda) annotation (Line(points={{-100,-16},{-80,-16},
          {-80,-16},{-58,-16}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end returnAdmixture_heatCurve;
