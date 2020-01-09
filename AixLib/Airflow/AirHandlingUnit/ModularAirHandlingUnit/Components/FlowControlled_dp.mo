within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components;
model FlowControlled_dp
                        extends BaseClasses.PartialFlowMachine(
                         final computePowerUsingSimilarityLaws=per.havePressureCurve,
                         eff(
per(final pressure = if per.havePressureCurve then
          per.pressure
        else
          AixLib.Fluid.Movers.BaseClasses.Characteristics.flowParameters(
            V_flow = {i/(nOri-1)*2.0*m_flow_nominal/rho_air for i in 0:(nOri-1)},
            dp =     {i/(nOri-1)*2.0*dp_nominal for i in (nOri-1):-1:0}),
      final use_powerCharacteristic = if per.havePressureCurve then per.use_powerCharacteristic else false), preVar=
          AixLib.Fluid.Movers.BaseClasses.Types.PrescribedVariable.PressureDifference));

     parameter Boolean use_defaultElectricalPower = true "Simple calculation of electrical power";
     Modelica.SIunits.Power Pe; // electrical Power consumed by fan if use_defaultElectricalPower is true

       parameter Modelica.SIunits.PressureDifference dp_nominal(
    min=0,
    displayUnit="Pa")=
      if rho_air < 500 then 500 else 10000 "Nominal pressure raise, used to normalized the filter if use_inputFilter=true,
        to set default values of constantHead and heads, and
        and for default pressure curve if not specified in record per"
    annotation(Dialog(group="Nominal condition"));

  Modelica.Blocks.Interfaces.RealInput dp_in "Prescribed pressure rise"
    annotation (Placement(transformation(extent={{-128,26},{-100,54}})));

  Modelica.Blocks.Sources.RealExpression Pele(y=Pe)
    annotation (Placement(transformation(extent={{2,46},{22,66}})));
protected
  Modelica.Blocks.Continuous.Filter filter(
    order=2,
    f_cut=5/(2*Modelica.Constants.pi*riseTime),
    final init=init,
    x(each stateSelect=StateSelect.always),
    final analogFilter=Modelica.Blocks.Types.AnalogFilter.CriticalDamping,
    final filterType=Modelica.Blocks.Types.FilterType.LowPass) if
        use_inputFilter
    "Second order filter to approximate valve opening time, and to improve numerics"
    annotation (Placement(transformation(extent={{-78,17},{-64,31}})));

equation

  Pe = m_flow_in * (1/(1.18 * eff.eta)) * dp_in;

  if use_inputFilter then
    connect(filter.y, eff.dp_in) annotation (Line(points={{-63.3,24},{-58,24},{-58,
          -20},{-16,-20},{-16,-42}}, color={0,0,127}));

  else
      connect(dp_in, eff.dp_in) annotation (Line(points={{-114,40},{-58,40},{-58,
            -20},{-16,-20},{-16,-42}},
                                     color={0,0,127}));

  end if;

  if use_defaultElectricalPower then
  connect(Pele.y, P) annotation (Line(points={{23,56},{40,56},{40,40},{110,40}},
        color={0,0,127}));
  connect(Pele.y, heaDis.PEle) annotation (Line(points={{23,56},{42,56},{42,8},
            {2,8},{2,-52},{10,-52}},
                                  color={0,0,127}));
  else
   connect(eff.PEle, heaDis.PEle) annotation (Line(points={{-9,-55},{0,-55},{0,
            -52},{10,-52}},
                     color={0,0,127}));
  connect(eff.PEle, P) annotation (Line(points={{-9,-55},{0,-55},{0,6},{40,6},{
            40,40},{110,40}},
                         color={0,0,127}));

  end if;

  connect(dp_in, filter.u) annotation (Line(points={{-114,40},{-84,40},{-84,24},
          {-79.4,24}}, color={0,0,127}));
    annotation (
    preferredView="info",
    Documentation(info="<html>
    
    <p>

</p>This model describes a fan. The input connector <code>dp_in</code> provides the difference between outlet minus inlet pressure.<p>
</p>The efficiency of the device is computed based
on the efficiency and pressure curves that are defined
in record <code>per</code>.<p>


</p>
<h4>Options</h4>

By setting <code>use_WeatherData</code> to true you can use weather data for the air flow.

<p>
</p> If <code>use_WeatherData</code> is set to false you need to give input values for air temperature and massfraction. <p>
</p>


</p>

    
</html>", revisions="<html>
<ul>

<li>September 2 , 2019, by Ervin Lejlic:<br>First Implementation</li>
</ul>
</html>"),    Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end FlowControlled_dp;
