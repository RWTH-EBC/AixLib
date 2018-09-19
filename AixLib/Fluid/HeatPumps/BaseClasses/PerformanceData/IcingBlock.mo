within AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData;
model IcingBlock
  "Block which decreases evaporator power by an icing factor"

  replaceable function iceFunc =
      AixLib.Fluid.HeatPumps.BaseClasses.Functions.IcingFactor.PartialBaseFct
                                                                       constrainedby
    AixLib.Fluid.HeatPumps.BaseClasses.Functions.IcingFactor.PartialBaseFct                                                                           "Replaceable function to calculate current icing factor" annotation(choicesAllMatching=true);
  Modelica.Blocks.Sources.RealExpression calcIceFac(final y=iceFac_internal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealInput T_flow_ev
    "Temperature at evaporator inlet"
    annotation (Placement(transformation(extent={{-128,0},{-100,28}}),
        iconTransformation(extent={{-116,12},{-100,28}})));

  Modelica.Blocks.Interfaces.RealInput T_ret_ev
    "Temperature at evaporator outlet" annotation (Placement(transformation(
          extent={{-128,-40},{-100,-12}}),iconTransformation(extent={{-116,-28},
            {-100,-12}})));
  Modelica.Blocks.Interfaces.RealInput T_oda "Outdoor air temperature"
    annotation (Placement(transformation(extent={{-128,46},{-100,74}}),
        iconTransformation(extent={{-116,52},{-100,68}})));
  Modelica.Blocks.Interfaces.RealInput m_flow_ev "Mass flow rate at evaporator"
    annotation (Placement(transformation(extent={{-128,-80},{-100,-52}}),
        iconTransformation(extent={{-116,-68},{-100,-52}})));
  Modelica.Blocks.Interfaces.RealOutput iceFac "Output of current icing factor"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,0})));
protected
  parameter Real iceFac_default = 1;
  Real iceFac_internal "Calculated value of icing factor";
equation
  iceFac_internal = iceFunc(T_flow_ev,T_ret_ev,T_oda,m_flow_ev);
  connect(calcIceFac.y, iceFac)
    annotation (Line(points={{11,0},{110,0}}, color={0,0,127}));
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
        coordinateSystem(preserveAspectRatio=false)));
end IcingBlock;
