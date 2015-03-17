within AixLib.HVAC.HeatGeneration.Utilities;
model HeatDemand "Calculates heat demand to heat m_flow_in from T_in to T_set"
  Modelica.Blocks.Interfaces.RealInput T_set annotation(Placement(transformation(extent = {{-120, -20}, {-80, 20}})));
  Modelica.Blocks.Interfaces.RealInput T_in annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 90, origin = {-60, -100})));
  Modelica.Blocks.Interfaces.RealInput m_flow_in annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 90, origin = {20, -100})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow_out annotation(Placement(transformation(extent = {{96, -10}, {116, 10}})));

equation
  Q_flow_out = m_flow_in * 4184 * (T_set - T_in);
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), Documentation(info = "<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p><br/>This control is very simple. Its inputs are a given set temperature T_set, the temperature of the fluid T_in and the mass flow rate of the fluid m_flow_in. The model then calculates which Q_flow would be necessary to heat the fluid to the set temperature by equation </p>
 <pre>Q_flow_out&nbsp;=&nbsp;m_flow_in&nbsp;*&nbsp;cp&nbsp;*&nbsp;(T_set&nbsp;-&nbsp;T_in)</pre>
 <p>Should T_in &gt; T_set, this would result in a negative Q_flow_out (i.e. a cooling load). A limiter after this model can be used to ensure Q_flow is always &gt;= 0. </p>
 </html>", revisions = "<html>
 <p>07.10.2013, Marcus Fuchs</p>
 <ul>
 <li>implemented</li>
 </ul>
 </html>"));
end HeatDemand;
