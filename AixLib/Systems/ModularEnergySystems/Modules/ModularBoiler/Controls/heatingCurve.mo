within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler.Controls;
model heatingCurve
  "Flow temperature control (power control) with heating curve"

   //Heating Curve
 replaceable function HeatingCurveFunction =
      AixLib.Controls.SetPoints.Functions.HeatingCurveFunction constrainedby
    AixLib.Controls.SetPoints.Functions.PartialBaseFct annotation (Dialog(group="Heating Curve"));
 parameter Boolean use_tableData=true "Choose between tables or function to calculate TSet" annotation (Dialog(group="Heating Curve"));
 parameter Real declination=1 annotation (Dialog(group="Heating Curve"));
 parameter Real day_hour=6 annotation (Dialog(group="Heating Curve"));
 parameter Real night_hour=22 annotation (Dialog(group="Heating Curve"));
 parameter AixLib.Utilities.Time.Types.ZeroTime zerTim=AixLib.Utilities.Time.Types.ZeroTime.NY2017
    "Enumeration for choosing how reference time (time = 0) should be defined. Used for heating curve" annotation (Dialog(group="Heating Curve"));
 parameter Modelica.Units.SI.ThermodynamicTemperature TOffset=0
    "Offset to heating curve temperature" annotation (Dialog(group="Heating Curve"));

 AixLib.Controls.SetPoints.HeatingCurve heatingCurve(
    final TOffset=TOffset,
    final use_dynTRoom=false,
    final zerTim=zerTim,
    final day_hour=day_hour,
    final night_hour=night_hour,
    final heatingCurveRecord=
        AixLib.DataBase.Boiler.DayNightMode.HeatingCurves_Vitotronic_Day23_Night10(),
    final declination=declination,
    redeclare function HeatingCurveFunction = HeatingCurveFunction,
    final use_tableData=use_tableData,
    final TRoom_nominal=293.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

 Modelica.Blocks.Interfaces.RealInput TAmb(unit="K")
    "Measured ambient temperature for heating curve"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));

  Modelica.Blocks.Interfaces.RealOutput TFlowSet(unit="K")
    "Set flow temperature calculated by heating curve"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation

  connect(TAmb, heatingCurve.T_oda)
    annotation (Line(points={{-100,0},{-12,0}}, color={0,0,127}));
  connect(heatingCurve.TSet, TFlowSet)
    annotation (Line(points={{11,0},{110,0}}, color={0,0,127}));
  annotation (Documentation(info="<html><p>
  Ambient temperature guided flow temperature control for heat
  generators. The temperature control can be switched on and off via
  the isOn input from the outside. A heating curve model is used to
  determine the required flow temperature depending on the ambient
  temperature. The associated data are recorded in a table and the
  values are determined by means of interpolation. Furthermore, the
  model has a day and night mode, in which the set temperatures differ
  at the same ambient temperature. The PI-Controller was set for this
  application.
</p>
<h4>
  Important parameters
</h4>
<ul>
  <li>declination: The user can choose the steepness of the curve. The
  higher the parameter, the higher the determined
  </li>
</ul>
</html>"), Icon(graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
                            Text(
          extent={{-90,36},{110,-8}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="%name")}));
end heatingCurve;
