within AixLib.Obsolete.YearIndependent.FastHVAC.Components.Valves;
model ThermostaticValve
  extends AixLib.Obsolete.BaseClasses.ObsoleteModel;

  replaceable function valveCharacteristic =
      Modelica.Fluid.Valves.BaseClasses.ValveCharacteristics.linear
    constrainedby
    Modelica.Fluid.Valves.BaseClasses.ValveCharacteristics.baseFun
    "Inherent flow characteristic"
    annotation(choicesAllMatching=true);

  parameter Real opening_nominal(min=0,max=1)=1 "Nominal opening"
 annotation(Dialog(group="Nominal operating point",
                   enable = (CvData==Modelica.Fluid.Types.CvTypes.OpPoint)));

 parameter Boolean filteredOpening=false
    "= true, if opening is filtered with a 2nd order CriticalDamping filter"
   annotation(Dialog(group="Filtered opening"),choices(__Dymola_checkBox=true));
  parameter Modelica.Units.SI.Time riseTime=1
    "Rise time of the filter (time to reach 99.6 % of an opening step)"
    annotation (Dialog(group="Filtered opening", enable=filteredOpening));
 parameter Real leakageOpening(min=0,max=1)=0.001
    "The opening signal is limited by leakageOpening (to improve the numerics)"
   annotation(Dialog(group="Filtered opening",enable=filteredOpening));

parameter Real k(min=0, unit="1") = 0.1 "Gain of controller";
  parameter Modelica.Units.SI.Time Ti(
    min=Modelica.Constants.small,
    start=0.5) = 1000 "Time constant of Integrator block";

  parameter Modelica.Units.SI.MassFlowRate dotm_nominal=0.5;

//Modelica.SIunits.MassFlowRate dotm;
//Real relativeFlowCoefficient;

 Modelica.Blocks.Interfaces.RealOutput dotm_set( unit="kg/s")
    annotation (Placement(transformation(extent={{86,-12},{116,18}}),
        iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={90,0})));
protected
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
</HTML>
"),   Icon(coordinateSystem(
      preserveAspectRatio=true,
      extent={{-100,-100},{100,100}},
      grid={2,2}), graphics={
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
      Line(points={{-80,-70},{-50,-70},{50,70},{64,90}}, color={0,0,0}),
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
      extent={{-100,-100},{100,100}},
      grid={2,2}), graphics={
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
      Line(points={{-50,-40},{-30,-40},{30,40},{50,40}}, color={0,0,0}),
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
        textString="uMax")}),
      uses(Modelica(version="3.2")));
  end MinLimiter;

public
  Modelica.Blocks.Interfaces.RealInput T_set(unit="K")
    "Valve position in the range 0..1" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-98,-32}),iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,-30})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a T_room
    annotation (Placement(transformation(extent={{-100,20},{-80,40}}),
        iconTransformation(extent={{-100,20},{-80,40}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor
    temperatureSensor
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-44,30})));
  Modelica.Blocks.Continuous.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=k,
    Ti=Ti,
    yMax=1,
    yMin=0,
    xi_start=0,
    xd_start=0,
    y_start=0.5,
    initType=Modelica.Blocks.Types.Init.InitialOutput) annotation (Placement(
        transformation(
        extent={{11,-11},{-11,11}},
        rotation=180,
        origin={-25,-1})));
  FastHVAC.Components.Valves.BaseClases.HysteresisValve hysteresisValve(
    filteredOpening=filteredOpening,
    leakageOpening=leakageOpening,
    riseTime=riseTime)
    annotation (Placement(transformation(extent={{0,-12},{20,10}})));

  Modelica.Blocks.Sources.RealExpression realExpression(y=valveCharacteristic(
        hysteresisValve.opening_actual)*dotm_nominal)
    annotation (Placement(transformation(extent={{-10,12},{20,38}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{56,-6},{76,14}})));
equation

  connect(T_room, temperatureSensor.port) annotation (Line(
      points={{-90,30},{-50,30}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(temperatureSensor.T, PID.u_m) annotation (Line(
      points={{-38,30},{-25,30},{-25,12.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(T_set, PID.u_s) annotation (Line(
      points={{-98,-32},{-56,-32},{-56,-1},{-38.2,-1}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(PID.y, hysteresisValve.opening) annotation (Line(
      points={{-12.9,-1},{0,-1}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dotm_set, product.y) annotation (Line(
      points={{101,3},{90,3},{90,4},{77,4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(realExpression.y, product.u1) annotation (Line(
      points={{21.5,25},{54,25},{54,10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(hysteresisValve.opening_actual, product.u2) annotation (Line(
      points={{19.8,-1},{54,-1},{54,-2}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics), Icon(coordinateSystem(preserveAspectRatio=false,
                   extent={{-100,-100},{100,100}}),
                                      graphics={
                   Bitmap(extent={{-104,100},{102,-100}}, fileName=
              "modelica://HVAC/Images/ThermostaticHead_Icon.PNG")}),
    Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Thermostatic valve model.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The thermostatic valve model is designed as a pump controller. The
  mass flow set value is calculated based on nominal mass flow and the
  temperature difference between the setpoint and actual value.
</p>
<p>
  The valve opening characteristic is described by the function
  <code>valveCharacteristic</code>, linear characteristic by default,
  can be replaced by any user-defined function. Equal percentage with
  customizable rangeability and an optimal characteristic are already
  provided by the library.
</p>
<p>
  With the optional parameter \"filteredOpening\", the opening can be
  filtered with a <b>second order, criticalDamping</b> filter so that
  the opening demand is delayed by parameter \"riseTime\". The filtered
  opening is then available via the output signal \"opening_filtered\"
  and is used to control the valve equations. This approach
  approximates the driving device of a valve. The \"riseTime\" parameter
  is used to compute the cut-off frequency of the filter by the
  equation: f_cut = 5/(2*pi*riseTime). It defines the time that is
  needed until opening_filtered reaches 99.6 % of a step input of
  opening.
</p>
<h4>
  <span style=\"color:#008000\">Example Results</span>
</h4>
<p>
  <a href=
  \"FastHVAC.Examples.Valves.ThermostaticValveRadiator\">ThermostaticValve</a>
</p>
</html>",
        revisions="<html><ul>
  <li>
    <i>April 13, 2017&#160;</i> Tobias Blacha:<br/>
    Moved into AixLib
  </li>
  <li>
    <i>February 19, 2015&#160;</i> by Konstantin Finkbeiner:<br/>
    Implemented
  </li>
</ul>
</html>
"));
end ThermostaticValve;
