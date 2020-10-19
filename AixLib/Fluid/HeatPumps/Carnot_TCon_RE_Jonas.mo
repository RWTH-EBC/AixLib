within AixLib.Fluid.HeatPumps;
model Carnot_TCon_RE_Jonas
  "reversible HeatPump, build on the Model from Xiyuan \"Carnot_TCon_RE\""
 extends AixLib.Fluid.HeatPumps.BaseClasses.Carnot1(
    COP_is_for_cooling =  is_cooling,
    QEva_flow_nominal= if COP_is_for_cooling then Q_cooling_nominal else -  QCon_flow_nominal*(COP_nominal-1)/COP_nominal,
    QCon_flow_nominal= if COP_is_for_cooling then -QEva_flow_nominal*(1 + COP_nominal)/COP_nominal else Q_heating_nominal,
    TConAct(start=TCon_nominal + TAppCon_nominal)=
          if COP_is_for_cooling then Medium2.temperature(staB2) + QCon_flow/QCon_flow_nominal*TAppCon_nominal else Medium1.temperature(staB1) + QCon_flow/QCon_flow_nominal*TAppCon_nominal,
    TEvaAct(start=TEva_nominal - TAppEva_nominal)=
          if COP_is_for_cooling then min(TConAct-10, Medium1.temperature(staB1) - QEva_flow/QEva_flow_nominal*TAppEva_nominal) else Medium2.temperature(staB2) - QEva_flow/QEva_flow_nominal*TAppEva_nominal,
    QCon_flow= if COP_is_for_cooling then min(QCon_flow_max, Q_flow_internal.y) else max(0,con.Q_flow),
    QEva_flow= if COP_is_for_cooling then min(0,con.Q_flow) else max(QEva_flow_min,Q_flow_internal.y),
    redeclare HeatExchangers.PrescribedOutlet con(
    final use_X_wSet=false,
    final mWatMax_flow = 0,
    final mWatMin_flow = 0,
    final from_dp=from_dp1,
    final dp_nominal=dp1_nominal,
    final m_flow_nominal=m1_flow_nominal,
    final m_flow_small=0.0001,
    final linearizeFlowResistance=linearizeFlowResistance1,
    final deltaM=deltaM1,
    final tau=tau1,
    final T_start=T1_start,
    final energyDynamics=energyDynamics,
    final massDynamics = Modelica.Fluid.Types.Dynamics.SteadyState,
    use_TSet=true,
    final X_start=Medium1.X_default,
    QMax_flow = QCon_flow_max,
    QMin_flow = QEva_flow_min,
      final homotopyInitialization=false),
    redeclare  HeatExchangers.HeaterCooler_u eva(
    final from_dp=from_dp2,
    final m_flow_nominal=m2_flow_nominal,
    final m_flow_small=0.0001,
    final dp_nominal=dp2_nominal,
    final linearizeFlowResistance=linearizeFlowResistance2,
    final deltaM=deltaM2,
    final tau=tau2,
    final T_start=T2_start,
    final energyDynamics=energyDynamics,
    final homotopyInitialization=homotopyInitialization,
      final Q_flow_nominal=1));

  parameter Modelica.SIunits.HeatFlowRate QEva_flow_min(
    max=0) = -60000
    "Maximum heat flow rate for cooling (negative)";
  parameter Modelica.SIunits.HeatFlowRate QCon_flow_max(
    min=0) = 30000
    "Maximum heat flow rate for heating (positive)";
   parameter Modelica.SIunits.HeatFlowRate Q_heating_nominal(min = 0);
   parameter Modelica.SIunits.HeatFlowRate Q_cooling_nominal(max = 0);

  Modelica.Blocks.Interfaces.RealInput TSet(unit="K")
    "Condenser leaving water temperature"
    annotation (Placement(transformation(extent={{-140,70},{-100,110}})));

// QEva_flow_nominal = -  QCon_flow_nominal*(COP_nominal-1)/COP_nominal;

  Modelica.Blocks.Sources.RealExpression P_el_cooling(y=abs(min(con.Q_flow, 0)/
        COP)) annotation (Placement(transformation(extent={{106,2},{52,22}})));
  Modelica.Blocks.Interfaces.BooleanInput  is_cooling
    annotation (Placement(transformation(extent={{-120,12},{-100,32}})));
  Modelica.Blocks.Logical.Switch Q_con annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={2,-10})));
  Modelica.Blocks.Sources.RealExpression Q_con_cooling(y=min(con.Q_flow, 0))
    annotation (Placement(transformation(extent={{-78,-12},{-36,8}})));
  Modelica.Blocks.Sources.RealExpression Q_con_heating(y=max(con.Q_flow, 0))
    annotation (Placement(transformation(extent={{-78,-28},{-36,-8}})));
  Modelica.Blocks.Logical.Switch P_el annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=-90,
        origin={42,-8})));
  Modelica.Blocks.Sources.RealExpression P_el_heating(y=max(con.Q_flow, 0)/COP)
    annotation (Placement(transformation(extent={{-22,2},{22,20}})));
protected
  Modelica.Blocks.Math.Add Q_flow_internal(final k1=-1, k2=+1)
    "Heat removed by evaporator" annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={36,-38})));
initial equation
//  assert(QCon_flow_nominal > 0, "Parameter QCon_flow_nominal must be positive.");
//  assert(COP_nominal > 1, "The nominal COP of a heat pump must be bigger than one.");
//  assert(QEva_flow_nominal< 0, "Parameter QCon_flow_nominal must be negative.");

equation
  connect(TSet, con.TSet) annotation (Line(points={{-120,90},{-80,90},{-80,68},
          {-12,68}},color={0,0,127}));
  connect(Q_flow_internal.y, eva.u)
    annotation (Line(points={{36,-49},{36,-54},{12,-54}},color={0,0,127}));
  connect(Q_con.y, Q_flow_internal.u1)
    annotation (Line(points={{13,-10},{30,-10},{30,-26}}, color={0,0,127}));
  connect(is_cooling, Q_con.u2) annotation (Line(points={{-110,22},{-28,22},{
          -28,-10},{-10,-10}},
                           color={255,0,255}));
  connect(Q_con_cooling.y, Q_con.u1)
    annotation (Line(points={{-33.9,-2},{-10,-2}}, color={0,0,127}));
  connect(Q_con_heating.y, Q_con.u3)
    annotation (Line(points={{-33.9,-18},{-10,-18}}, color={0,0,127}));
  connect(is_cooling, P_el.u2)
    annotation (Line(points={{-110,22},{42,22},{42,1.6}},color={255,0,255}));
  connect(P_el.y, Q_flow_internal.u2)
    annotation (Line(points={{42,-16.8},{42,-26}}, color={0,0,127}));
  connect(P_el_cooling.y, P_el.u1) annotation (Line(points={{49.3,12},{48,12},{
          48,2},{48.4,2},{48.4,1.6}}, color={0,0,127}));
  connect(P_el_heating.y, P_el.u3) annotation (Line(points={{24.2,11},{36,11},{
          36,2},{35.6,2},{35.6,1.6}}, color={0,0,127}));
  connect(P_el.y, P) annotation (Line(points={{42,-16.8},{42,-22},{72,-22},{72,
          0},{110,0}}, color={0,0,127}));
  connect(P, P) annotation (Line(points={{110,0},{107,0},{107,0},{110,0}},
        color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false,extent={{-100,-100},
            {100,100}}),
            graphics={
        Text(
          extent={{-148,156},{-92,114}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="TCon"),
        Line(points={{-100,90},{-80,90},{-80,84},{80,84},{80,64}},
                                                    color={0,0,255})}),
defaultComponentName="heaPum",
Documentation(info="<html><p>
  This is a model of a heat pump whose coefficient of performance COP
  changes with temperatures in the same way as the Carnot efficiency
  changes. The control input is the setpoint of the condenser leaving
  temperature, which is met exactly at steady state if the heat pump
  has sufficient capacity.
</p>
<p>
  The model allows to either specify the Carnot effectivness
  <i>η<sub>Carnot,0</sub></i>, or a <i>COP<sub>0</sub></i> at the
  nominal conditions, together with the evaporator temperature
  <i>T<sub>eva,0</sub></i> and the condenser temperature
  <i>T<sub>con,0</sub></i>, in which case the model computes the Carnot
  effectivness as
</p>
<p style=\"text-align:center;font-style:italic;\">
  η<sub>Carnot,0</sub> = COP<sub>0</sub> ⁄ (T<sub>con,0</sub> ⁄
  (T<sub>con,0</sub>-T<sub>eva,0</sub>)).
</p>
<p>
  The heat pump COP is computed as the product
</p>
<p style=\"text-align:center;font-style:italic;\">
  COP = η<sub>Carnot,0</sub> COP<sub>Carnot</sub> η<sub>PL</sub>,
</p>
<p>
  where <i>COP<sub>Carnot</sub></i> is the Carnot efficiency and
  <i>η<sub>PL</sub></i> is a polynomial in heating part load ratio
  <i>y<sub>PL</sub></i> that can be used to take into account a change
  in <i>COP</i> at part load conditions. This polynomial has the form
</p>
<p style=\"text-align:center;font-style:italic;\">
  η<sub>PL</sub> = a<sub>1</sub> + a<sub>2</sub> y<sub>PL</sub> +
  a<sub>3</sub> y<sub>PL</sub><sup>2</sup> + ...
</p>
<p>
  where the coefficients <i>a<sub>i</sub></i> are declared by the
  parameter <code>a</code>.
</p>
<p>
  On the <code>Dynamics</code> tag, the model can be parametrized to
  compute a transient or steady-state response. The transient response
  of the model is computed using a first order differential equation
  for the evaporator and condenser fluid volumes. The heat pump outlet
  temperatures are equal to the temperatures of these lumped volumes.
</p>
<h4>
  Typical use and important parameters
</h4>
<p>
  When using this component, make sure that the condenser has
  sufficient mass flow rate. Based on the evaporator mass flow rate,
  temperature difference and the efficiencies, the model computes how
  much heat will be removed by to the evaporator. If the mass flow rate
  is too small, very low outlet temperatures can result, possibly below
  freezing.
</p>
<p>
  The condenser heat flow rate <code>QCon_flow_nominal</code> is used
  to assign the default value for the mass flow rates, which are used
  for the pressure drop calculations. It is also used to compute the
  part load efficiency. Hence, make sure that
  <code>QCon_flow_nominal</code> is set to a reasonable value.
</p>
<p>
  The maximum heating capacity is set by the parameter
  <code>QCon_flow_max</code>, which is by default set to infinity.
</p>
<p>
  The coefficient of performance depends on the evaporator and
  condenser leaving temperature since otherwise the second law of
  thermodynamics may be violated.
</p>
<h4>
  Notes
</h4>
<p>
  For a similar model that can be used as a chiller, see <a href=
  \"modelica://AixLib.Fluid.Chillers.Examples.Carnot_TEva\">AixLib.Fluid.Chillers.Examples.Carnot_TEva</a>.
</p>
</html>",
revisions="<html><ul>
  <li>January 3, 2017, by Michael Wetter:<br/>
    Removed parameters <code>effInpEva</code> and
    <code>effInpCon</code> and updated documentation. This is for
    <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/497\">issue
    497</a>.
  </li>
  <li>August 8, 2016, by Michael Wetter:<br/>
    Changed default temperature to compute COP to be the leaving
    temperature as use of the entering temperature can violate the 2nd
    law if the temperature lift is small.<br/>
    This is for <a href=
    \"https://github.com/ibpsa/modelica-ibpsa/issues/497\">Annex 60,
    issue 497</a>.
  </li>
  <li>November 25, 2015 by Michael Wetter:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end Carnot_TCon_RE_Jonas;
