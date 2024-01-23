within AixLib.Obsolete.Year2021.Fluid.Actuators.Valves;
model MixingValve

  extends AixLib.Obsolete.BaseClasses.ObsoleteModel;

  extends Modelica.Fluid.Fittings.BaseClasses.PartialTeeJunction;
  outer AixLib.Utilities.Sources.BaseParameters baseParameters
    "System wide properties";

  parameter Real Kvs = 1.4 "Kv value at full opening (=1)";
  parameter Boolean filteredOpening=false
    "= true, if opening is filtered with a 2nd order CriticalDamping filter"
    annotation(Dialog(group="Filtered opening"),choices(checkBox=true));
  parameter Modelica.Units.SI.Time riseTime=1
    "Rise time of the filter (time to reach 99.6 % of an opening step)"
    annotation (Dialog(group="Filtered opening", enable=filteredOpening));
  parameter Real leakageOpening(min=0,max=1)=1e-3
    "The opening signal is limited by leakageOpening (to improve the numerics)";

    ///////////////////////////////////////////////////////////////////////////
    //Valves                                                                 //
    ///////////////////////////////////////////////////////////////////////////
  AixLib.Obsolete.Year2021.Fluid.Actuators.Valves.SimpleValve Valve(
    Kvs=Kvs,
    m_flow_small=1e-4,
    redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  AixLib.Obsolete.Year2021.Fluid.Actuators.Valves.SimpleValve Valve2(
    Kvs=Kvs,
    m_flow_small=1e-4,
    redeclare package Medium = Medium) annotation (Placement(transformation(extent={{-44,-84},{-24,-64}})));

    ///////////////////////////////////////////////////////////////////////////
    //Calculation of Opening                                                 //
    ///////////////////////////////////////////////////////////////////////////
  Modelica.Blocks.Interfaces.RealInput opening(min=0, max=1)
    "Valve position in the range 0..1"
    annotation (Placement(transformation(
        origin={12,88},
        extent={{-20,-20},{20,20}},
        rotation=270), iconTransformation(
        extent={{-20,-20},{20,20}},
        origin={-80,-70})));
  Modelica.Blocks.Sources.Constant Constant(k=1)
    "To compute opening of second valve"
    annotation (Placement(transformation(extent={{16,-38},{-4,-18}})));
  Modelica.Blocks.Math.Add add(k1=-1) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-34,-40})));

    ///////////////////////////////////////////////////////////////////////////
    //Filter                                                                 //
    ///////////////////////////////////////////////////////////////////////////

  Modelica.Blocks.Interfaces.RealOutput opening_filtered if filteredOpening
    "Filtered valve position in the range 0..1"
    annotation (Placement(transformation(extent={{72,40},{92,60}}),
        iconTransformation(extent={{72,58},{92,78}})));

  Modelica.Blocks.Continuous.Filter filter(order=2, f_cut=5/(2*Modelica.Constants.pi
        *riseTime)) if filteredOpening
         annotation (Placement(transformation(extent={{40,44},{54,58}})));

  Modelica.Blocks.Interfaces.RealOutput opening_actual
    "Actual opening dpending if filtered or not."
    annotation (Placement(transformation(extent={{72,12},{92,32}})));
block MinLimiter "Limit the signal above a threshold"
 parameter Real uMin=0 "Lower limit of input signal";
  extends Modelica.Blocks.Interfaces.SISO;

equation
  y = smooth(0, noEvent( if u < uMin then uMin else u));
  annotation (
    Documentation(info="<HTML>
<p>
The block passes its input signal as output signal
as long as the input is above uMin. If this is not the case,
y=uMin is passed as output.
</p>
</html>"), Icon(coordinateSystem(
    preserveAspectRatio=true,
    extent={{-100,-100},{100,100}}), graphics={
    Line(points={{0,-90},{0,68}}, color={192,192,192}),
    Polygon(
      points={{0,90},{-8,68},{8,68},{0,90}},
      lineColor={192,192,192},
      fillColor={192,192,192},
      fillPattern=FillPattern.Solid),
    Line(points={{-90,0},{68,0}}, color={192,192,192}),
    Polygon(
      points={{90,0},{68,-8},{68,8},{90,0}},
      lineColor={192,192,192},
      fillColor={192,192,192},
      fillPattern=FillPattern.Solid),
    Line(points={{-80,-70},{-50,-70},{50,70},{64,90}}),
    Text(
      extent={{-150,-150},{150,-110}},
      lineColor={0,0,0},
            textString="uMin=%uMin"),
    Text(
      extent={{-150,150},{150,110}},
      textString="%name",
      lineColor={0,0,255})}),
    Diagram(coordinateSystem(
    preserveAspectRatio=true,
    extent={{-100,-100},{100,100}}), graphics={
    Line(points={{0,-60},{0,50}}, color={192,192,192}),
    Polygon(
      points={{0,60},{-5,50},{5,50},{0,60}},
      lineColor={192,192,192},
      fillColor={192,192,192},
      fillPattern=FillPattern.Solid),
    Line(points={{-60,0},{50,0}}, color={192,192,192}),
    Polygon(
      points={{60,0},{50,-5},{50,5},{60,0}},
      lineColor={192,192,192},
      fillColor={192,192,192},
      fillPattern=FillPattern.Solid),
    Line(points={{-50,-40},{-30,-40},{30,40},{50,40}}),
    Text(
      extent={{46,-6},{68,-18}},
      lineColor={128,128,128},
      textString="u"),
    Text(
      extent={{-30,70},{-5,50}},
      lineColor={128,128,128},
      textString="y"),
    Text(
      extent={{-58,-54},{-28,-42}},
      lineColor={128,128,128},
      textString="uMin"),
    Text(
      extent={{26,40},{66,56}},
      lineColor={128,128,128},
      textString="uMax")}));
end MinLimiter;

  MinLimiter minLimiter(uMin=leakageOpening)
    annotation (Placement(transformation(extent={{18,44},{32,58}})));

equation
  connect(filter.y, opening_filtered) annotation (Line(
      points={{54.7,51},{64.35,51},{64.35,50},{82,50}},
      color={0,0,127}));
  connect(minLimiter.y, filter.u) annotation (Line(
      points={{32.7,51},{38.6,51}},
      color={0,0,127}));
  connect(opening, minLimiter.u) annotation (Line(
      points={{12,88},{14,88},{14,51},{16.6,51}},
      color={0,0,127}));
  connect(Valve.opening, opening_actual) annotation (Line(
      points={{-60,8},{-60,22},{82,22}},
      color={0,0,127}));
  connect(port_3, Valve.port_a) annotation (Line(
      points={{0,100},{0,58},{-76,58},{-76,0},{-70,0}},
      color={0,127,255}));
  connect(Valve2.port_a, port_1) annotation (Line(
      points={{-44,-74},{-100,-74},{-100,0}},
      color={0,127,255}));
  connect(add.y, Valve2.opening) annotation (Line(
      points={{-34,-51},{-34,-66}},
      color={0,0,127}));
  connect(add.u1, opening_actual) annotation (Line(
      points={{-40,-28},{-40,22},{82,22}},
      color={0,0,127}));
  connect(add.u2, Constant.y) annotation (Line(
      points={{-28,-28},{-5,-28}},
      color={0,0,127}));
  connect(Valve.port_b, port_2) annotation (Line(
      points={{-50,0},{100,0}},
      color={0,127,255}));
  connect(Valve2.port_b, port_2) annotation (Line(
      points={{-24,-74},{58,-74},{58,0},{100,0}},
      color={0,127,255}));

  //Connection of Filter if used
  if filteredOpening then
     connect(filter.y, opening_actual);
  else
     connect(opening, opening_actual);
  end if;
  annotation (
    obsolete = "Obsolete model - Use one of the valves in package AixLib.Fluid.Actuators.Valves.",
    Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Polygon(
          points={{-40,20},{40,-20},{40,20},{-40,-20},{-40,20}},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Polygon(
          points={{0,0},{-20,40},{20,40},{0,0}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-20,-10},{20,-50}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-14,-16},{14,-44}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          textString="M"),
        Line(
          points={{0,0},{0,-10}}),
        Polygon(
          points={{0,-50},{-6,-60},{6,-60},{0,-50}},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid,
          pattern = LinePattern.None,
          lineColor={0,0,0}),
        Line(
          points={{-84,-70},{0,-70},{0,-60}},
          color={0,0,127}),
        Polygon(
          points={{-90,2},{-40,2},{-40,-2},{-92,-2},{-90,2}},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Line(
          points={{-78,0},{-52,0},{-54,2},{-52,0},{-54,-2}}),
        Polygon(
          points={{40,2},{92,2},{92,-2},{40,-2},{40,2}},
          fillColor={231,231,231},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Polygon(
          points={{-26,2},{26,2},{26,-2},{-26,-2},{-26,2}},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          origin={0,66},
          rotation=90),
        Line(
          points={{52,0},{78,0},{76,2},{78,0},{76,-2}}),
        Line(
          points={{0,11},{0,-11},{0,11},{-2,9},{0,11},{2,9}},
          origin={0,65},
          rotation=180)}),
          Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  This model is a model of a three-way mixing-valve. It mixes two
  incoming fluid-streams into one resulting fluid-stream. It is based
  on two seperate SimpleValve from the AixLib Library. The Model
  features a RealInput which controls the mixture of the streams in a
  range between 0 and 1. A filtered option is available.
</p>
<h4>
  <span style=\"color:#008000\">Assumptions</span>
</h4>
<p>
  The model assumes that pressure loss and friction phenomena of a
  mixing-valve correspond to the phenomena of a normal valve. The
  mixing of both streams is assumed ideal.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The MixingValve is put together from two single SimpleValves. It is
  controlled by a RealInput in the range between 0 and 1. Value 0 opens
  port_1 completely and closes port_3, value 1 closes port_1 completely
  and opens port_3. The function between those values is linear. The
  model features a filter which simulates the delay when opening a
  valve manually. For this see <a href=
  \"modelica://Modelica.Fluid.Valves.BaseClasses.PartialValve\">PartialValve</a>.
</p>
<p>
  <br/>
  <b><span style=\"color: #008000\">References</span></b>
</p>
<p>
  The following sheets can be used for finding apropriate values for
  Kv:
</p>
<p>
  <a href=
  \"http://www.armstronginternational.com/files/products/lynnwood/pdf/installation/IOM-442_CPAC0012.pdf\">
  http://www.armstronginternational.com/files/products/lynnwood/pdf/installation/IOM-442_CPAC0012.pdf</a><br/>

  <a href=
  \"http://www.herzvalves.com/www/downloads/DS_4037_Three_Way_Valve.pdf\">
  http://www.herzvalves.com/www/downloads/DS_4037_Three_Way_Valve.pdf</a>
</p>
<h4>
  <span style=\"color:#008000\">Example Results</span>
</h4>
<p>
  Verification:
</p>
<p>
  <a href=
  \"MixingValves.AixLib.Examples.MixingValveForwardDirection\">MixingValves.AixLib.Examples.MixingValveForwardDirection</a><br/>

  <a href=
  \"MixingValves.AixLib.Examples.MixingValveBackwardDirection\">MixingValves.AixLib.Examples.MixingValveBackwardDirection</a>
</p>
<ul>
  <li>
    <i>November 26, 2014&#160;</i> by Roozbeh Sangi:<br/>
    Implemented
  </li>
</ul>
</html>"));
end MixingValve;
