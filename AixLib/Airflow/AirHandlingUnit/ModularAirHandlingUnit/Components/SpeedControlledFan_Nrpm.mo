within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components;
model SpeedControlledFan_Nrpm
                      extends BaseClasses.PartialFlowMachine(
      final computePowerUsingSimilarityLaws=true,
      final m_flow_nominal = max(per.pressure.V_flow)*rho_air,
                      eff(
      per(final pressure = per.pressure,
          final use_powerCharacteristic = per.use_powerCharacteristic),
      preVar=AixLib.Fluid.Movers.BaseClasses.Types.PrescribedVariable.Speed));
  Modelica.Blocks.Interfaces.RealInput n_in "Prescribed rotational speed"
    annotation (Placement(transformation(extent={{-128,26},{-100,54}})));

protected
  Modelica.Blocks.Continuous.Filter filter(
    order=2,
    f_cut=5/(2*Modelica.Constants.pi*riseTime),
    final init=init,
    x(each stateSelect=StateSelect.always),
    final analogFilter=Modelica.Blocks.Types.AnalogFilter.CriticalDamping,
    final filterType=Modelica.Blocks.Types.FilterType.LowPass,
    final y_start=y_start,
      u_nominal=1,
      u(final unit="1"),
      y(final unit="1")) if
        use_inputFilter
    "Second order filter to approximate valve opening time, and to improve numerics"
    annotation (Placement(transformation(extent={{-78,7},{-64,21}})));
  Modelica.Blocks.Math.Gain gaiSpe(
    u(final unit="1/min"),
    final k=1/per.speed_rpm_nominal)
    "Gain to normalized speed using speed_nominal or speed_rpm_nominal"
    annotation (Placement(transformation(extent={{-92,34},{-80,46}})));

initial equation
  assert(per.havePressureCurve,
   "SpeedControlled_Nrpm model requires to set the pressure vs. flow rate curve in record 'per'.");

equation

  if use_inputFilter then
     connect(filter.y, eff.y_in) annotation (Line(points={{-63.3,14},{-58,14},{-58,
            -16},{-24,-16},{-24,-42}},
                                     color={0,0,127}));

  else
     connect(gaiSpe.y, eff.y_in) annotation (Line(points={{-79.4,40},{-58,40},{-58,
          -16},{-24,-16},{-24,-42}}, color={0,0,127}));
  end if;

  connect(eff.PEle, heaDis.PEle) annotation (Line(points={{-9,-55},{0,-55},{0,
          -52},{10,-52}}, color={0,0,127}));
  connect(eff.PEle, P) annotation (Line(points={{-9,-55},{0,-55},{0,20},{80,20},
          {80,40},{110,40}}, color={0,0,127}));
  connect(n_in, gaiSpe.u)
    annotation (Line(points={{-114,40},{-93.2,40}}, color={0,0,127}));
  connect(gaiSpe.y, filter.u) annotation (Line(points={{-79.4,40},{-74,40},{-74,
          28},{-88,28},{-88,14},{-79.4,14}}, color={0,0,127}));

  annotation (
    preferredView="info",
    Documentation(info="<html>
    
    <p>

</p>This model describes a fan with prescribed speed in revolutions per minute.<p>



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
end SpeedControlledFan_Nrpm;
