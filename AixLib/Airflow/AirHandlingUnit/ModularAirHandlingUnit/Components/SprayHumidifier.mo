within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components;
model SprayHumidifier "Idealized model of a spray humidifier"
  extends
    AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.BaseClasses.PartialHumidifier;

  // Variables
  Modelica.Units.SI.SpecificEnthalpy hWatIn "specific enthalpy of incoming water";

  Real etaHum "humidification degree";


  Modelica.Blocks.Interfaces.RealOutput Q_flow "heat flow rate"
    annotation (Placement(transformation(extent={{100,-90},{120,-70}})));

  Modelica.Blocks.Interfaces.RealOutput mWat_flow "mass flow rate water"
    annotation (Placement(transformation(extent={{100,-64},{120,-44}})));
  Utilities.Psychrometrics.SaturationPressure pSat
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  Utilities.Psychrometrics.X_pW humRat(use_p_in=false)
    annotation (Placement(transformation(extent={{-30,30},{-10,50}})));
protected
  Real watToAirRat "water to air ratio";
  Modelica.Units.SI.Temperature T_intern "internal outlet temperature";

  Modelica.Blocks.Sources.RealExpression realExpression(y=T_intern)
    annotation (Placement(transformation(extent={{-78,-6},{-58,14}})));
  Modelica.Blocks.Math.Min min if use_X_set
    annotation (Placement(transformation(extent={{20,46},{40,66}})));
  Modelica.Blocks.Math.Min min1 if not use_X_set
    annotation (Placement(transformation(extent={{20,0},{40,20}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=X_intern)
    annotation (Placement(transformation(extent={{-20,-8},{0,12}})));
equation
  T_intern = TAirOut;
  mDryAirIn_flow * (1 + XAirIn) = mAirIn_flow;

  // mass balance
  mAirIn_flow + mWat_flow_intern * etaHum - mAirOut_flow = 0;
  mDryAirIn_flow * XAirIn + mWat_flow_intern * etaHum
    - mDryAirOut_flow * X_intern = 0;

  if not use_X_set then
    // water to air ratio
    watToAirRat =mWat_flow_intern/mAirIn_flow;
    // humidification degree
    etaHum = 1 - exp(-k * watToAirRat);
  else
    watToAirRat=0;
    etaHum = 1;
    X_intern =XAirOut;
  end if;
  mWat_flow = mWat_flow_intern;

  // energy balance
  mDryAirIn_flow * hAirIn + mWat_flow_intern * etaHum * hWatIn
    - mDryAirOut_flow * hAirOut = 0;

  // heat flow
  Q_flow = mWat_flow_intern*etaHum*hWatIn;

  // specific enthalpies
  hWatIn = cpWater * (TWatIn - 273.15);



  assert(
    XAirOut < humRat.X_w,
    "saturation exceeded with given set value. Humidification is reduced.",
    AssertionLevel.warning);

  connect(min.y, XAirOut);
  connect(min1.y, XAirOut);
  connect(pSat.pSat, humRat.p_w)
    annotation (Line(points={{-39,40},{-31,40}}, color={0,0,127}));
  connect(realExpression.y, pSat.TSat) annotation (Line(points={{-57,4},{-54,4},
          {-54,22},{-68,22},{-68,40},{-61,40}}, color={0,0,127}));
  connect(max.y, min.u1) annotation (Line(points={{-19,70},{-2,70},{-2,62},{18,62}},
        color={0,0,127}));
  connect(humRat.X_w, min.u2)
    annotation (Line(points={{-9,40},{4,40},{4,50},{18,50}}, color={0,0,127}));
  connect(humRat.X_w, min1.u1)
    annotation (Line(points={{-9,40},{4,40},{4,16},{18,16}}, color={0,0,127}));
  connect(realExpression1.y, min1.u2)
    annotation (Line(points={{1,2},{8,2},{8,4},{18,4}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Polygon(
          points={{-100,-68},{-94,-66},{-84,-64},{-66,-66},{-54,-64},{-34,-68},{
              -18,-64},{4,-68},{26,-66},{40,-68},{56,-66},{66,-68},{82,-68},{90,
              -66},{100,-66},{100,-94},{-100,-94},{-100,-68}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Line(
          points={{48,-68},{48,40}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{48,40},{30,50}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{48,40},{30,40}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{48,40},{30,30}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{86,94},{86,-94}},
          color={0,0,0},
          thickness=0.5,
          pattern=LinePattern.Dash),
        Line(
          points={{82,94},{82,-94}},
          color={0,0,0},
          thickness=0.5,
          pattern=LinePattern.Dash)}),                           Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  This model provides a idealized spray humidifier. The output air
  humidity is calculated either using the input air humidity and the
  mass flow rate of water:
</p>
<p style=\"text-align:center;\">
  <i>m<sub>air,in</sub> X<sub>air,in</sub> + m<sub>wat,in</sub>
  η<sub>B</sub> = m<sub>air,out</sub> X<sub>air,out</sub></i>
</p>
<p>
  or it is calculated using a set point for the humidity at the outlet
  if the parameter <i>use_X_set</i> is set to true. <b>Note:</b> If the
  relative humidity with the givin set-point or mass flow rate of water
  would exceed saturation the humidification is reduced to reach
  saturation as maximum. Additionally a warning will be thrown.
</p>
<p>
  The energy balance is formulated using the enthalpy of the air
  streams and the enthalpy of the water:
</p>
<p style=\"text-align:center;\">
  <i>m<sub>air,in</sub> h<sub>air,in</sub> + m<sub>wat,in</sub>
  h<sub>wat,in</sub> η<sub>B</sub> = m<sub>air,out</sub>
  h<sub>air,out</sub></i>
</p>
<p>
  The humidifying degree <i>η<sub>B</sub></i> is calculated using the
  water to air ratio <i>E</i>:
</p>
<p style=\"text-align:center;\">
  <i>η<sub>B</sub> = 1 - exp(-k E)</i>
</p>
<p style=\"text-align:center;\">
  <i>E = m<sub>wat,in</sub> ⁄ m<sub>air,in</sub></i>
</p>
<p>
  If the boolean variable <i>simplify_m_wat_flow</i> is set to true,
  the mass flow rate of the water is not considered for the mass
  balance. Moreover the enthalpy of the water is neglected for the
  energy balance.
</p>
<p>
  The equations are based on [1].
</p>
<h4>
  References
</h4>
<p>
  [1]: Baumgarth, Hörner, Reeker (Hrsg.): <i>Handbuch der
  Klimatechnik</i>, Band 2, 5. Auflage, VDE Verlag GmbH, 2011
  (pp.304-306)
</p>
</html>", revisions="<html>
<ul>
  <li>April, 2019, by Martin Kremer:<br/>
    First Implementation.
  </li>
  <li>April 2020, by Martin Kremer:<br/>
    Extended from PartialHumidifier.
  </li>
  <li>January 2022, by Martin Kremer:<br/>
    Implemented maximum limit for saturation.
  </li>
</ul>
</html>"));
end SprayHumidifier;
