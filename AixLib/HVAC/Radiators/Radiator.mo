within AixLib.HVAC.Radiators;
model Radiator
  import AixLib;
  parameter AixLib.DataBase.Radiators.RadiatiorBaseDataDefinition RadiatorType = AixLib.DataBase.Radiators.ThermX2_ProfilV_979W() annotation(choicesAllMatching = true);
  Sensors.TemperatureSensor T_flow annotation(Placement(transformation(extent = {{-78, -10}, {-58, 10}})));
  Sensors.TemperatureSensor T_return annotation(Placement(transformation(extent = {{54, -10}, {74, 10}})));
  Volume.Volume volume(V = RadiatorType.VolumeWater * 0.001) annotation(Placement(transformation(extent = {{-8, -10}, {12, 10}})));
  Interfaces.RadPort radPort annotation(Placement(transformation(extent = {{30, 68}, {50, 88}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a convPort annotation(Placement(transformation(extent = {{-52, 66}, {-32, 86}})));
  // Variablen
  Modelica.SIunits.Power Power "current power of radiator";
  Modelica.SIunits.TemperatureDifference OverTemperature
    "current over temperature";
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow annotation(Placement(transformation(extent = {{-34, 2}, {-14, 22}})));
  Interfaces.Port_a port_a annotation(Placement(transformation(extent = {{-102, -10}, {-82, 10}})));
  Interfaces.Port_b port_b annotation(Placement(transformation(extent = {{82, -10}, {102, 10}})));
protected
  parameter Modelica.SIunits.TemperatureDifference OverTemperature_Norm = (RadiatorType.T_flow_nom - RadiatorType.T_return_nom) / Modelica.Math.log((RadiatorType.T_flow_nom - RadiatorType.T_room_nom) / (RadiatorType.T_return_nom - RadiatorType.T_room_nom))
    "over temperature according to norm";
equation
  // Calculate the current over temperature
  //This equation works well for educational purposes. The oevrtemperature calculation only works by correct initailization of the system tzemperatures.
  //     if (T_flow.signal - convPort.T) > 1e-5 or (T_return.signal - convPort.T) > 1e-5 then
  //       OverTemperature = (T_flow.signal - T_return.signal)
  //       /  Modelica.Math.log((T_flow.signal - convPort.T)/(T_return.signal - convPort.T));
  //     else // for nummerical reasons
  //        OverTemperature = (T_flow.signal + T_return.signal)*0.5 - convPort.T;
  //     end if;
  // This equation works better for stable equations, because the overtemperature can actually be directly calculated
  OverTemperature = max(volume.heatPort.T - convPort.T, 0.0);
  //the average radiator temperature is assumed to be the temperature of the volume, this avoids any division by zero and improves stability
  //Calculate the current power
  Power = RadiatorType.NominalPower * (OverTemperature / OverTemperature_Norm) ^ RadiatorType.Exponent;
  // Distribute the power to the convective and radiative ports
  //Extract the power from the water volume
  prescribedHeatFlow.Q_flow = -Power;
  //Set the convective power
  convPort.Q_flow = -Power * (1 - RadiatorType.RadPercent);
  //Set the radiative power
  radPort.Q_flow = -Power * RadiatorType.RadPercent;
  connect(prescribedHeatFlow.port, volume.heatPort) annotation(Line(points = {{-14, 12}, {2, 12}, {2, 10}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(port_a, T_flow.port_a) annotation(Line(points = {{-92, 0}, {-78, 0}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(T_flow.port_b, volume.port_a) annotation(Line(points = {{-58, 0}, {-8, 0}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(volume.port_b, T_return.port_a) annotation(Line(points = {{12, 0}, {54, 0}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(T_return.port_b, port_b) annotation(Line(points = {{74, 0}, {92, 0}}, color = {0, 127, 255}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Text(extent=  {{-80, -10}, {-54, -18}}, lineColor=  {0, 0, 0}, lineThickness=  1, fillColor=  {255, 0, 0}, fillPattern=  FillPattern.Solid, textString=  "T_flow"), Text(extent=  {{54, -10}, {76, -18}}, lineColor=  {0, 0, 0}, lineThickness=  1, fillColor=  {255, 0, 0}, fillPattern=  FillPattern.Solid, textString=  "T_return"), Rectangle(extent=  {{-40, 54}, {40, 26}}, lineColor=  {255, 0, 0}, lineThickness=  1), Text(extent=  {{-34, 52}, {36, 28}}, lineColor=  {255, 0, 0}, lineThickness=  1, fillColor=  {0, 0, 255}, fillPattern=  FillPattern.Solid, textString=  "Heat transfer equations"), Line(points=  {{0, 16}, {0, 24}, {-2, 22}, {0, 24}, {2, 22}}, color=  {255, 0, 0}, thickness=  1, smooth=  Smooth.None), Line(points=  {{28, 58}, {34, 68}, {30, 66}, {34, 68}, {34, 64}}, color=  {255, 0, 0}, thickness=  1, smooth=  Smooth.None), Line(points=  {{-32, 60}, {-38, 68}, {-38, 64}, {-38, 68}, {-34, 66}}, color=  {255, 0, 0}, thickness=  1, smooth=  Smooth.None)}), Icon(graphics = {Rectangle(extent=  {{-68, 56}, {-60, -74}}, lineColor=  {95, 95, 95}, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid), Rectangle(extent=  {{-48, 56}, {-40, -74}}, lineColor=  {95, 95, 95}, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid), Rectangle(extent=  {{-28, 56}, {-20, -74}}, lineColor=  {95, 95, 95}, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid), Rectangle(extent=  {{-8, 56}, {0, -74}}, lineColor=  {95, 95, 95}, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid), Rectangle(extent=  {{12, 56}, {20, -74}}, lineColor=  {95, 95, 95}, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid), Rectangle(extent=  {{32, 56}, {40, -74}}, lineColor=  {95, 95, 95}, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid), Rectangle(extent=  {{52, 56}, {60, -74}}, lineColor=  {95, 95, 95}, fillColor=  {215, 215, 215}, fillPattern=  FillPattern.Solid), Rectangle(extent=  {{-74, -60}, {62, -70}}, lineColor=  {95, 95, 95}, fillColor=  {230, 230, 230}, fillPattern=  FillPattern.Solid), Rectangle(extent=  {{-72, 50}, {64, 40}}, lineColor=  {95, 95, 95}, fillColor=  {230, 230, 230}, fillPattern=  FillPattern.Solid)}), Documentation(revisions = "<html>
 <p>13.11.2013, by <i>Ana Constantin</i>: implemented</p>
 </html>", info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Simple model for a radiator with one water volume. </p>
 <h4><span style=\"color:#008000\">Level of Development</span></h4>
 <p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>The power is calculated according to the flow and return temperatures, the power and temperatures in the design case and the radiator exponent.</p>
 <p>The power is split between convective and radiative heat transfer. </p>
 <h4><span style=\"color:#008000\">Example Results</span></h4>
 <p><a href=\"AixLib.HVAC.Radiators.Examples.PumpRadiatorValve\">AixLib.HVAC.Radiators.Examples.PumpRadiatorValve</a></p>
 <p><a href=\"AixLib.HVAC.Radiators.Examples.PumpRadiatorThermostaticValve\">AixLib.HVAC.Radiators.Examples.PumpRadiatorThermostaticValve</a></p>
 </html>"));
end Radiator;

