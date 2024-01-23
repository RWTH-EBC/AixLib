within AixLib.DataBase.HeatPump.PerformanceData;
model IcingBlock
  "Block which decreases evaporator power by an icing factor"
  AixLib.Utilities.Time.CalendarTime calTim(zerTim=zerTim, yearRef=yearRef);
  parameter Integer hourDay=16
                            "Hour of the day";
  parameter AixLib.Utilities.Time.Types.ZeroTime zerTim=AixLib.Utilities.Time.Types.ZeroTime.NY2016
    "Enumeration for choosing how reference time (time = 0) should be defined";
  parameter Integer yearRef=2016 "Year when time = 0, used if zerTim=Custom";
  replaceable function iceFunc =
      Functions.IcingFactor.BasicIcingApproach constrainedby
    AixLib.DataBase.HeatPump.Functions.IcingFactor.PartialBaseFct                                                                     "Replaceable function to calculate current icing factor" annotation(choicesAllMatching=true);
  Modelica.Blocks.Interfaces.RealInput T_flow_ev(unit="K", displayUnit="degC")
    "Temperature at evaporator inlet"
    annotation (Placement(transformation(extent={{-128,0},{-100,28}}),
        iconTransformation(extent={{-116,12},{-100,28}})));

  Modelica.Blocks.Interfaces.RealInput T_ret_ev(unit="K", displayUnit="degC")
    "Temperature at evaporator outlet" annotation (Placement(transformation(
          extent={{-128,-40},{-100,-12}}),iconTransformation(extent={{-116,-28},
            {-100,-12}})));
  Modelica.Blocks.Interfaces.RealInput T_oda(unit="K", displayUnit="degC") "Outdoor air temperature"
    annotation (Placement(transformation(extent={{-128,46},{-100,74}}),
        iconTransformation(extent={{-116,52},{-100,68}})));
  Modelica.Blocks.Interfaces.RealInput m_flow_ev(unit="kg/s") "Mass flow rate at evaporator"
    annotation (Placement(transformation(extent={{-128,-80},{-100,-52}}),
        iconTransformation(extent={{-116,-68},{-100,-52}})));
  Modelica.Blocks.Interfaces.RealOutput iceFac(min=0, max=1) "Efficiency factor (0..1) to estimate influence of icing. 0 means no heat is transferred through heat exchanger (fully frozen). 1 means no icing/frosting."
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,0})));
protected
  Real iceFac_internal "Calculated value of icing factor";
equation
  iceFac_internal = iceFunc(T_flow_ev,T_ret_ev,T_oda,m_flow_ev);
  iceFac = iceFac_internal;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Text(
          lineColor={0,0,255},
          extent={{-150,105},{150,145}},
          textString="%name"),
        Ellipse(
          lineColor = {108,88,49},
          fillColor = {255,215,136},
          fillPattern = FillPattern.Solid,
          extent = {{-100,-100},{100,100}}),
        Text(
          lineColor={108,88,49},
          extent={{-90.0,-90.0},{90.0,90.0}},
          textString="f")}),                                     Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html><ul>
  <li>
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
  </li>
</ul>
</html>", info="<html>
<p>
  Model for calculation of the icing factor. The replaceable function
  uses the inputs to calculate the resulting icing factor.
</p>
</html>"));
end IcingBlock;
