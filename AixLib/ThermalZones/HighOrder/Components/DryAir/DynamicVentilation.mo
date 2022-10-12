within AixLib.ThermalZones.HighOrder.Components.DryAir;
model DynamicVentilation
  "Dynamic ventilation to ventilate away the solar gains"
  parameter Modelica.Units.SI.Temperature HeatingLimit=285.15
    "Outside temperature at which the heating activates";
  parameter Real Max_VR = 200 "Maximal ventilation rate";
  parameter Modelica.Units.SI.TemperatureDifference Diff_toTempset=2
    "Difference to set temperature";
  parameter Modelica.Units.SI.Temperature Tset=295.15 "set temperature";
  VarAirExchange varAirExchange annotation(Placement(transformation(extent={{36,-12},{62,12}})));
  Controls.Continuous.PITemp pITemp(h = 0, l = -Max_VR, PI(controllerType = Modelica.Blocks.Types.SimpleController.PI)) annotation(Placement(transformation(extent = {{-22, 26}, {-2, 46}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_inside annotation(Placement(transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={{88,-10},{108,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_outside annotation(Placement(transformation(extent={{-110,-10},{-90,10}}), iconTransformation(extent={{-110,-10},{-90,10}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor Sensor_Toutside annotation(Placement(transformation(extent={{-7,-7},{7,7}},          rotation = 90, origin={-93,19})));
  Modelica.Blocks.Logical.GreaterThreshold Higher_HeatingLimit(threshold = HeatingLimit) annotation(Placement(transformation(extent = {{-80, 20}, {-60, 40}})));
  Modelica.Blocks.Sources.Constant Input_Tset(k = Tset) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, origin = {-70, 90}), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-60, 90})));
  Modelica.Blocks.Math.MultiSum multiSum(nu = 2) annotation(Placement(transformation(extent = {{-40, 68}, {-28, 80}})));
  Modelica.Blocks.Sources.Constant Source_Tdiff(k = Diff_toTempset) annotation(Placement(transformation(extent = {{-80, 46}, {-60, 66}})));
  Modelica.Blocks.Math.Gain Inverter(k = -1) annotation(Placement(transformation(extent = {{8, 30}, {20, 42}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor Sensor_Tinside annotation(Placement(transformation(extent = {{10, -10}, {-10, 10}}, origin = {14, -80})));
  Modelica.Blocks.Logical.And Colder_and_HeatingLimit annotation(Placement(transformation(extent = {{-46, 28}, {-32, 42}})));
  Modelica.Blocks.Logical.Less less annotation(Placement(transformation(extent={{-76,-60},{-56,-40}})));
equation
  connect(port_outside, Sensor_Toutside.port) annotation(Line(points={{-100,0},{-100,-4},{-93,-4},{-93,12}},         color = {191, 0, 0}));
  connect(port_inside, pITemp.heatPort)
    annotation (Line(points={{100,0},{100,27},{-18,27}}, color={191,0,0}));
  connect(Sensor_Toutside.T, Higher_HeatingLimit.u) annotation(Line(points={{-93,26},{-93,30},{-82,30}},        color = {0, 0, 127}));
  connect(multiSum.y, pITemp.setPoint) annotation (Line(points={{-26.98,74},{-22,
          74},{-22,45},{-20,45}}, color={0,0,127}));
  connect(Source_Tdiff.y, multiSum.u[1]) annotation(Line(points = {{-59, 56}, {-50, 56}, {-50, 76.1}, {-40, 76.1}}, color = {0, 0, 127}));
  connect(pITemp.y, Inverter.u) annotation(Line(points = {{-3, 36}, {6.8, 36}}, color = {0, 0, 127}));
  connect(Inverter.y, varAirExchange.ventRate) annotation (Line(points={{20.6,
          36},{24,36},{24,-15.68},{37.3,-15.68}}, color={0,0,127}));
  connect(Input_Tset.y, multiSum.u[2]) annotation(Line(points = {{-59, 90}, {-54, 90}, {-54, 88}, {-50, 88}, {-50, 71.9}, {-40, 71.9}}, color = {0, 0, 127}));
  connect(Sensor_Tinside.port, port_inside) annotation(Line(points={{24,-80},{100,-80},{100,0}},        color = {191, 0, 0}));
  connect(Higher_HeatingLimit.y, Colder_and_HeatingLimit.u1) annotation(Line(points = {{-59, 30}, {-52, 30}, {-52, 35}, {-47.4, 35}}, color = {255, 0, 255}));
  connect(Colder_and_HeatingLimit.y, pITemp.onOff) annotation(Line(points = {{-31.3, 35}, {-24, 35}, {-24, 31}, {-21, 31}}, color = {255, 0, 255}));
  connect(less.u2, Sensor_Tinside.T) annotation(Line(points={{-78,-58},{-84,-58},{-84,-80},{4,-80}},            color = {0, 0, 127}));
  connect(Sensor_Toutside.T, less.u1) annotation(Line(points={{-93,26},{-84,26},{-84,-50},{-78,-50}},            color = {0, 0, 127}));
  connect(less.y, Colder_and_HeatingLimit.u2) annotation(Line(points={{-55,-50},{-52,-50},{-52,29.4},{-47.4,29.4}},          color = {255, 0, 255}));
  connect(port_outside, varAirExchange.port_a) annotation(Line(points={{-100,0},{36,0}},                   color = {191, 0, 0}));
  connect(varAirExchange.port_b, port_inside) annotation(Line(points={{62,0},{100,0}},                  color = {191, 0, 0}));
  annotation (Icon(graphics={  Rectangle(extent={{-100,100},{100,-100}},  lineColor = {0, 0, 0}, fillColor = {211, 243, 255},
            fillPattern =                                                                                                   FillPattern.Solid), Text(
          extent={{-60,60},{60,-60}},
          lineColor={0,0,0},
          textString="Dyn.
Vent.")}),                                                                                                                                        Documentation(revisions = "<html><ul>
  <li>
    <i>Mai 19, 2014&#160;</i> by Ana Constantin:<br/>
    Uses components from MSL and respects the naming conventions
  </li>
  <li>
    <i>May 02, 2013&#160;</i> by Ole Odendahl:<br/>
    Formatted documentation appropriately
  </li>
  <li>
    <i>October 16, 2011&#160;</i> by Ana Constantin:<br/>
    implemented<br/>
  </li>
</ul>
</html>", info = "<html>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  This model ventilates the solar gains away.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The model is used for simulations of heating periods. The outside
  temperature can be so high, that the heating system shuts down and
  the temperature in the room rises too high.
</p>
<p>
  When the outside temperature rises above the heating limit, the model
  is activated and tries to lower the temperature under the set
  temperature of the room plus 2K.
</p>
<p>
  Furthermore the model is only activated when the outdside temperature
  lower is than the inside temeperature.
</p>
<p>
  The maximum ventilation rate can be adjusted according to the type of
  building. You can try to set it really high, e.g. 200 1/h, in order
  to exhaust the potential of this type of ventilation for cooling the
  rooms.
</p>
<h4>
  <span style=\"color:#008000\">Example Results</span>
</h4>
<p>
  <a href=
  \"AixLib.Building.Components.Examples.DryAir.DryAir_test\">AixLib.Building.Components.Examples.DryAir.DryAir_test</a>
</p>
</html>"));
end DynamicVentilation;
