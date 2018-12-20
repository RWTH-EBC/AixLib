within AixLib.FastHVAC.BaseClasses;
model TwoPortHeatMassExchanger
  "Partial model transporting one fluid stream with storing mass or energy"
  extends AixLib.FastHVAC.Interfaces.PartialTwoPortInterface;

  BaseClasses.WorkingFluid workingFluid(m_fluid=m_fluid, medium=medium)
                                        annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,0})));

  parameter Modelica.SIunits.Mass m_fluid "Mass of working fluid";
  parameter Media.BaseClasses.MediumSimple medium=
      AixLib.FastHVAC.Media.WaterSimple()
    "Mediums charastics (heat capacity, density, thermal conductivity)";
equation
  connect(enthalpyPort_b, workingFluid.enthalpyPort_a) annotation (Line(points={
          {100,0},{50,0},{50,-1.77636e-15},{9,-1.77636e-15}}, color={176,0,0}));
  connect(workingFluid.enthalpyPort_b, enthalpyPort_a) annotation (Line(points={
          {-9,1.77636e-15},{-50,1.77636e-15},{-50,0},{-100,0}}, color={176,0,0}));
    annotation (Dialog(tab="Initialization", enable=Medium.nXi > 0),
    Documentation(info="<html>
<p>
This component transports one fluid stream.
It provides the basic model for implementing dynamic and steady-state
models that exchange heat and water vapor with the fluid stream.
The model also computes the pressure drop due to the flow resistance.
By setting the parameter <code>dp_nominal=0</code>, the computation
of the pressure drop can be avoided.
The variable <code>vol.heatPort.T</code> always has the value of
the temperature of the medium that leaves the component.
For the actual temperatures at the port, the variables <code>sta_a.T</code>
and <code>sta_b.T</code> can be used. These two variables are provided by
the base class
<a href=\"modelica://AixLib.Fluid.Interfaces.PartialTwoPortInterface\">
AixLib.Fluid.Interfaces.PartialTwoPortInterface</a>.
</p>

For models that extend this model, see for example
<ul>
<li>
the ideal heater or cooler
<a href=\"modelica://AixLib.Fluid.HeatExchangers.HeaterCooler_u\">
AixLib.Fluid.HeatExchangers.HeaterCooler_u</a>, and
</li>
<li>
the ideal humidifier
<a href=\"modelica://AixLib.Fluid.Humidifiers.Humidifier_u\">
AixLib.Fluid.Humidifiers.Humidifier_u</a>.
</li>
</ul>

<h4>Implementation</h4>
<p>
The variable names follow the conventions used in
<a href=\"modelica://Modelica.Fluid.Examples.HeatExchanger.BaseClasses.BasicHX\">
Modelica.Fluid.Examples.HeatExchanger.BaseClasses.BasicHX
</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
December 1, 2016, by Michael Wetter:<br/>
Updated model as <code>use_dh</code> is no longer a parameter in the pressure drop model.<br/>
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/480\">#480</a>.
</li>
<li>
January 26, 2016, by Michael Wetter:<br/>
Added <code>final quantity=Medium.substanceNames</code> for <code>X_start</code>.
</li>
<li>
May 6, 2015, by Michael Wetter:<br/>
Added missing propagation of <code>allowFlowReversal</code> to
instance <code>vol</code>.
This is for issue
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/412\">#412</a>.
</li>
<li>
May 1, 2015, by Marcus Fuchs:<br/>
Fixed links in documentation.
</li>
<li>
October 6, 2014, by Michael Wetter:<br/>
Changed medium declaration in pressure drop element to be final.
</li>
<li>
May 28, 2014, by Michael Wetter:<br/>
Removed <code>annotation(Evaluate=true)</code> for parameter <code>tau</code>.
This is needed to allow changing the time constant after translation.
</li>
<li>
November 12, 2013, by Michael Wetter:<br/>
Removed <code>import Modelica.Constants</code> statement.
</li>
<li>
October 8, 2013, by Michael Wetter:<br/>
Removed parameter <code>show_V_flow</code>.
</li>
<li>
December 14, 2012 by Michael Wetter:<br/>
Renamed protected parameters for consistency with the naming conventions.
</li>
<li>
October 17, 2012, by Michael Wetter:<br/>
Fixed broken link in documentation.
</li>
<li>
February 3, 2012, by Michael Wetter:<br/>
Removed assignment of <code>m_flow_small</code> as it is no
longer used in the pressure drop model.
</li>
<li>
January 15, 2011, by Michael Wetter:<br/>
Fixed wrong class reference in information section.
</li>
<li>
September 13, 2011, by Michael Wetter:<br/>
Changed assignment of <code>vol(mass/energyDynamics=...)</code> as the
previous assignment caused a non-literal start value that was ignored.
</li>
<li>
July 29, 2011, by Michael Wetter:<br/>
Added start value for outflowing enthalpy.
</li>
<li>
July 11, 2011, by Michael Wetter:<br/>
Changed parameterization of fluid volume so that steady-state balance is
used when <code>tau = 0</code>.
</li>
<li>
May 25, 2011, by Michael Wetter:<br/>
Removed temperature sensor and changed implementation of fluid volume
to allow use of this model for the steady-state and dynamic humidifier
<a href=\"modelica://AixLib.Fluid.MassExchangers.HumidifierPrescribed\">
AixLib.Fluid.MassExchangers.HumidifierPrescribed</a>.
</li>
<li>
March 25, 2011, by Michael Wetter:<br/>
Added homotopy operator.
</li>
<li>
March 21, 2010 by Michael Wetter:<br/>
Changed pressure start value from <code>system.p_start</code>
to <code>Medium.p_default</code> since HVAC models may have water and
air, which are typically at different pressures.
</li>
<li>
April 13, 2009, by Michael Wetter:<br/>
Added model to compute flow friction.
</li>
<li>
January 29, 2009 by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics={
        Rectangle(
          extent={{-70,60},{70,-60}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-101,5},{100,-4}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{0,-4},{100,5}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid)}));
end TwoPortHeatMassExchanger;
