within AixLib.Fluid.Movers.DpControlledMovers;
model DpControlled_dp
  extends AixLib.Fluid.Interfaces.LumpedVolumeDeclarations(
    final mSenFac=1);
  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface(m_flow_nominal(final min=Modelica.Constants.small));   //FIXME: Use attributes in modifier as in PartialFlowMachine

  parameter Modelica.SIunits.PressureDifference dp_nominal(
    min=0,
    displayUnit="Pa")=
      if rho_default < 500 then 500 else 10000 "Nominal pressure raise, used to normalized the filter if use_inputFilter=true,
        to set default values of constantHead and heads, and
        and for default pressure curve if not specified in record per"
    annotation(Dialog(group="Nominal condition"));

  parameter AixLib.Fluid.Movers.DpControlledMovers.Types.CtrlType ctrlType "Type of mover control";

  replaceable parameter AixLib.Fluid.Movers.Data.Generic per(
    pressure(
    V_flow = m_flow_nominal/rho_default * {0, 1, 1.5, 2},
    dp =     dp_nominal * {1.3, 1, 0.75, 0}))
    constrainedby AixLib.Fluid.Movers.Data.Generic
    "Record with performance data"
    annotation (choicesAllMatching=true,
      Placement(transformation(extent={{52,60},{72,80}})));

  parameter AixLib.Fluid.Movers.BaseClasses.Characteristics.flowParameters pressureCurve_dpConst(
    V_flow = m_flow_nominal/rho_default * {0, 1, 1.5, 2},
    dp =     dp_nominal * {1, 1, 0.75, 0}) "Volume flow rate vs. total pressure rise"
    annotation(Dialog(group="Pressure curve", enable=(ctrlType==AixLib.Fluid.Movers.DpControlledMovers.Types.CtrlType.dpConst)));

  parameter AixLib.Fluid.Movers.BaseClasses.Characteristics.flowParameters pressureCurve_dpVar(
    V_flow = m_flow_nominal/rho_default * {0, 1, 1.5, 2},
    dp =     dp_nominal * {0.5, 1, 0.75, 0}) "Volume flow rate vs. total pressure rise"
    annotation(Dialog(group="Pressure curve", enable=(ctrlType==AixLib.Fluid.Movers.DpControlledMovers.Types.CtrlType.dpVar)));

  AixLib.Fluid.Movers.FlowControlled_dp mov(
    redeclare final package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    final per=per,
    dp_nominal=dp_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  Modelica.Blocks.Tables.CombiTable1D pressureCurveSelected(
    final tableOnFile=false,
    table=if (ctrlType == AixLib.Fluid.Movers.DpControlledMovers.Types.CtrlType.dpConst) then [cat(1, pressureCurve_dpConst.V_flow),cat(1, pressureCurve_dpConst.dp)] elseif (ctrlType == AixLib.Fluid.Movers.DpControlledMovers.Types.CtrlType.dpVar)
         then [cat(1, pressureCurve_dpVar.V_flow),cat(1, pressureCurve_dpVar.dp)] else [cat(1, per.pressure.V_flow),cat(1, per.pressure.dp)],
    final columns=2:size(pressureCurveSelected.table, 2),
    final extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    u(each final unit="m3/s"),
    y(each final unit="Pa")) annotation (Placement(transformation(extent={{-40,10},{-20,30}})));

  //FIXME: Check that table output for dp is 0, when measured mass flow rate > m_flow_max (default = 2*m_flow_nominal). e.g. when pumps are in series
  //FIXME: Use min of two curves between per.pressure and pressureCurve_dpConst/Var in current operating point.
  AixLib.Fluid.Sensors.VolumeFlowRate senVolFlo(redeclare final package Medium = Medium, final m_flow_nominal=m_flow_nominal) annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
protected
  final parameter Modelica.SIunits.Density rho_default=
    Medium.density_pTX(
      p=Medium.p_default,
      T=Medium.T_default,
      X=Medium.X_default) "Default medium density";

initial equation
  assert(pressureCurveSelected.table[1, 1] == 0.0,
    "\n+++++++++++++++++++++++++++++++++++++++++++\nParameterization error in component ("+getInstanceName()+".pressureCurveSelected):\nThe mover's (pump or fan) curve must have first point at V_flow = 0.0 m3/s.\n+++++++++++++++++++++++++++++++++++++++++++",
    AssertionLevel.error);
  assert(pressureCurveSelected.table[size(pressureCurveSelected.table, 1), size(pressureCurveSelected.table, 2)] == 0.0,
    "\n+++++++++++++++++++++++++++++++++++++++++++\nParameterization error in component ("+getInstanceName()+".pressureCurveSelected):\nThe mover's (pump or fan) curve must have last point at dp = 0.0 Pa.\n+++++++++++++++++++++++++++++++++++++++++++",
    AssertionLevel.error);
equation
  connect(mov.port_b, port_b)
    annotation (Line(points={{10,0},{100,0}}, color={0,127,255}));
  connect(pressureCurveSelected.y[1], mov.dp_in) annotation (Line(points={{-19,20},{0,20},{0,12}}, color={0,0,127}));
  connect(port_a, senVolFlo.port_a) annotation (Line(points={{-100,0},{-70,0}}, color={0,127,255}));
  connect(senVolFlo.port_b, mov.port_a) annotation (Line(points={{-50,0},{-10,0}}, color={0,127,255}));
  connect(senVolFlo.V_flow, pressureCurveSelected.u[1]) annotation (Line(points={{-60,11},{-60,20},{-42,20}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
        preferredView="info",
    Documentation(info="<html>

<style type=\"text/css\">
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-cly1{text-align:left;vertical-align:middle}
.tg .tg-18eh{border-color:#000000;font-weight:bold;text-align:center;vertical-align:middle}
.tg .tg-wa1i{font-weight:bold;text-align:center;vertical-align:middle}
.tg .tg-0a7q{border-color:#000000;text-align:left;vertical-align:middle}
</style>
<table class=\"tg\">
<thead>
  <tr>
    <th class=\"tg-18eh\">m_flow</th>
    <th class=\"tg-18eh\">dp_total</th>
    <th class=\"tg-18eh\">dp_constCtrl</th>
    <th class=\"tg-18eh\">dp_varCtrl</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td class=\"tg-0a7q\">0</td>
    <td class=\"tg-0a7q\">1.3</td>
    <td class=\"tg-0a7q\">1</td>
    <td class=\"tg-0a7q\">0.5</td>
  </tr>
  <tr>
    <td class=\"tg-0a7q\">1</td>
    <td class=\"tg-0a7q\">1</td>
    <td class=\"tg-0a7q\">1</td>
    <td class=\"tg-0a7q\">1</td>
  </tr>
  <tr>
    <td class=\"tg-0a7q\">1.5</td>
    <td class=\"tg-0a7q\">0.75</td>
    <td class=\"tg-0a7q\">0.75</td>
    <td class=\"tg-0a7q\">0.75</td>
  </tr>
  <tr>
    <td class=\"tg-0a7q\">2</td>
    <td class=\"tg-0a7q\">0</td>
    <td class=\"tg-0a7q\">0</td>
    <td class=\"tg-0a7q\">0</td>
  </tr>
</tbody>
</table>

<p><img src=\"modelica://AixLib/Resources/Images/Fluid/Movers/DpControlledMovers/CurveTypes.jpg\"/></p>
</html>"));
end DpControlled_dp;
