within AixLib.Fluid.FMI.Adaptors;

model ThermalZone

  "Adaptor for connecting a thermal zone to signal ports which then can be exposed at an FMI interface"



  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium

    "Medium model within the source" annotation (choicesAllMatching=true);



  // Don't use annotation(Dialog(connectorSizing=true)) for nPorts because

  // otherwise, in AixLib.Fluid.FMI.ExportContainers.Examples.FMUs.HVACZones

  // the fluid ports can not be assigned between the different zones by the user.

  parameter Integer nPorts(final min=2) "Number of fluid ports"

    annotation (Dialog(connectorSizing=false));



  Interfaces.Inlet fluPor[nPorts](

    redeclare each final package Medium = Medium,

    each final allowFlowReversal=true,

    each final use_p_in=false) "Fluid connector" annotation (Placement(

        transformation(extent={{-120,-10},{-100,10}}), iconTransformation(

          extent={{-142,-20},{-102,20}})));



  Modelica.Fluid.Interfaces.FluidPorts_b ports[nPorts](

    redeclare each final package Medium = Medium)

    annotation (Placement(transformation(extent={{90,

            40},{110,-40}}), iconTransformation(extent={{90,40},{110,-40}})));



  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorAir

    "Heat port for sensible heat input" annotation (Placement(transformation(

          extent={{90,-90},{110,-70}}), iconTransformation(extent={{90,-90},{110,-70}})));



protected

  x_i_toX_w x_i_toX(

    redeclare final package Medium = Medium) if

    Medium.nXi > 0 "Conversion from x_i to X_w"

    annotation (Placement(transformation(extent={{-20,-30},{-40,-10}})));



  RealVectorExpression XiSup(

    final n=Medium.nXi,

    final y=inStream(ports[1].Xi_outflow)) if

       Medium.nXi > 0

      "Water vapor concentration of supply air"

    annotation (Placement(transformation(extent={{20,-30},{0,-10}})));



  RealVectorExpression CSup(

    final n=Medium.nC,

    final y=inStream(ports[1].C_outflow)) if

    Medium.nC > 0 "Trace substance concentration of supply air"

    annotation (Placement(transformation(extent={{20,-70},{0,-50}})));



  Sources.MassFlowSource_T bou[nPorts](

    each final nPorts=1,

    redeclare each final package Medium = Medium,

    each final use_T_in=true,

    each final use_C_in=Medium.nC > 0,

    each final use_X_in=Medium.nXi > 0,

    each use_m_flow_in=true) "Mass flow source"

    annotation (Placement(transformation(extent={{2,38},{22,58}})));



  Conversion.InletToAir con[nPorts](redeclare each final package Medium =

        Medium) "Connector between FMI signals and real input and real outputs"

    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));



  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor senTemAir

    "Room air temperature sensor"

    annotation (Placement(transformation(extent={{72,-90},{52,-70}})));



  BaseClasses.X_w_toX x_w_toX[nPorts](redeclare final package Medium = Medium)

    if Medium.nXi > 0 "Conversion from X_w to X"

    annotation (Placement(transformation(extent={{-40,46},{-20,66}})));



  Modelica.Blocks.Math.MultiSum multiSum(final nu=nPorts, final k=fill(1,

        nPorts)) "Sum of air mass flow rates"

    annotation (Placement(transformation(extent={{4,72},{16,84}})));



  AixLib.Utilities.Diagnostics.AssertEquality assEqu(

    message="\"Mass flow rate does not balance. The sum needs to be zero.",

      threShold=1E-4)

    "Tests whether the mass flow rates balance to zero"

    annotation (Placement(transformation(extent={{70,56},{90,76}})));

  Modelica.Blocks.Sources.Constant const(final k=0) "Outputs zero"

    annotation (Placement(transformation(extent={{30,68},{50,88}})));



  ///////////////////////////////////////////////////////////////////////////

  // Internal blocks

  block RealVectorExpression

    "Set vector output signal to a time varying vector Real expression"

    parameter Integer n "Dimension of output signal";

    Modelica.Blocks.Interfaces.RealOutput[n] y "Value of Real output"

    annotation (Dialog(group="Time varying output signal"), Placement(

        transformation(extent={{100,-10},{120,10}})));

    annotation (Icon(coordinateSystem(

        preserveAspectRatio=false,

        extent={{-100,-100},{100,100}}), graphics={

        Rectangle(

          extent={{-100,46},{94,-34}},

          lineColor={0,0,0},

          lineThickness=5.0,

          fillColor={200,200,200},

          fillPattern=FillPattern.Solid,

          borderPattern=BorderPattern.Raised),

        Rectangle(

          extent={{-92,30},{100,-44}},

          lineColor={0,0,0},

          lineThickness=5.0,

          fillColor={235,235,235},

          fillPattern=FillPattern.Solid,

          borderPattern=BorderPattern.Raised),

        Text(

          extent={{-96,15},{96,-15}},

          lineColor={0,0,0},

          textString="%y"),

        Text(

          extent={{-150,90},{140,50}},

          textString="%name",

          lineColor={0,0,255})}), Documentation(info="<html>
<p>
  The (time varying) vector <code>Real</code> output signal of this block can be defined in its parameter menu via variable <code>y</code>. The purpose is to support the easy definition of vector-valued Real expressions in a block diagram.
</p></html>",revisions="<html>
<ul>
  <li>April 27, 2016, by Thierry S. Nouidui:<br/>
    First implementation.
  </li>
</ul>
<ul>
  <li>November 8, 2016, by Michael Wetter:<br/>
    Removed wrong usage of <code>each</code> keyword.
  </li>
  <li>April 27, 2016, by Thierry S. Nouidui:<br/>
    First implementation.
  </li>
</ul>
<p>
  Block that converts a vector input for the water mass fraction <code>Xi</code> to a scalar output <code>X</code>. This is needed for models in which a scalar input signal <code>Xi</code> that may be conditionally removed is to be connected to a model with a vector input <code>X</code>, because the conversion from scalar to vector needs to access the conditional connector, but conditional connectors can only be used in <code>connect</code> statements.
</p>
<p>
  Adaptor that can be used to connect a model of a thermal zone (with acausal ports) to input/output signals, which can be exposed in an FMI interface.
</p>
<p>
  This model has a vector <code>fluPor</code> with dimension <code>nPorts</code> which can be exposed at the FMI interface for the connecting the HVAC system. These connectors contain for each fluid inlet the mass flow rate, the temperature, the water vapor mass fraction per total mass of the air (unless <code>Medium.nXi=0</code>), and the trace substances (unless <code>Medium.nC=0</code>).
</p>
<p>
  The connector <code>ports</code> can be used to connect the model with a thermal zone. The number of connections to <code>ports</code> must be equal to <code>nPorts</code>.
</p>
<h4>
  Assumption and limitations
</h4>
<p>
  The mass flow rates at <code>ports</code> sum to zero, hence this model conserves mass. If the mass flow rates at <code>fluPor</code> do not sum to zero, then this model stops with an error.
</p>
<p>
  This model does not impose any pressure, other than setting the pressure of all fluid connections to <code>ports</code> to be equal. The reason is that setting a pressure can lead to non-physical system models, for example if a mass flow rate is imposed and the HVAC system is connected to a model that sets a pressure boundary condition such as <a href=\"modelica://AixLib.Fluid.Sources.Outside\">AixLib.Fluid.Sources.Outside</a>. Also, setting a pressure would make it impossible to use multiple instances of this model (one for each thermal zone) and build in Modelica an airflow network model with pressure driven mass flow rates.
</p>
<p>
  The model has no pressure drop.
</p>
<h4>
  Typical use
</h4>
<p>
  See <a href=\"modelica://AixLib.Fluid.FMI.ExportContainers.ThermalZone\">AixLib.Fluid.FMI.ExportContainers.ThermalZone</a> for a model that uses this model.
</p>
<ul>
  <li>June 29, 2016, by Michael Wetter:<br/>
    Revised implementation and documentation.
  </li>
  <li>April 27, 2016, by Thierry S. Nouidui:<br/>
    First implementation.
  </li>
</ul>

</html>"));

end ThermalZone;

