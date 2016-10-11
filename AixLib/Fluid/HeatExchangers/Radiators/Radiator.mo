within AixLib.Fluid.HeatExchangers.Radiators;
model Radiator
  import AixLib;
  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface;

  parameter AixLib.DataBase.Radiators.RadiatiorBaseDataDefinition RadiatorType = AixLib.DataBase.Radiators.ThermX2_ProfilV_979W() annotation(choicesAllMatching = true);
  AixLib.Fluid.Sensors.TemperatureTwoPort
                            T_flow(redeclare package Medium = Medium,
      m_flow_nominal=0.01)         annotation(Placement(transformation(extent = {{-78, -10}, {-58, 10}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort
                            T_return(redeclare package Medium = Medium,
      m_flow_nominal=0.01)           annotation(Placement(transformation(extent = {{54, -10}, {74, 10}})));
  AixLib.Fluid.MixingVolumes.MixingVolume
                volume(V = RadiatorType.VolumeWater * 0.001,
    nPorts=2,
    redeclare package Medium = Medium,
    m_flow_nominal=0.01)                                     annotation(Placement(transformation(extent={{-10,2},
            {10,22}})));
  AixLib.HVAC.Interfaces.RadPort radPort
    annotation (Placement(transformation(extent={{30,68},{50,88}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a convPort annotation(Placement(transformation(extent = {{-52, 66}, {-32, 86}})));
  // Variables
  Modelica.SIunits.Power Power "current power of radiator";
  Modelica.SIunits.TemperatureDifference OverTemperature
    "current overtemperature";
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow annotation(Placement(transformation(extent={{-46,2},
            {-26,22}})));
protected
  parameter Modelica.SIunits.TemperatureDifference OverTemperature_Norm = (RadiatorType.T_flow_nom - RadiatorType.T_return_nom) / Modelica.Math.log((RadiatorType.T_flow_nom - RadiatorType.T_room_nom) / (RadiatorType.T_return_nom - RadiatorType.T_room_nom))
    "overtemperature according to norm";
equation
  // Calculate the current overtemperature
  //This equation works well for educational purposes. The overtemperature calculation only works by correct initailization of the system temperatures.
  //     if (T_flow.signal - convPort.T) > 1e-5 or (T_return.signal - convPort.T) > 1e-5 then
  //       OverTemperature = (T_flow.signal - T_return.signal)
  //       /  Modelica.Math.log((T_flow.signal - convPort.T)/(T_return.signal - convPort.T));
  //     else // for nummerical reasons
  //        OverTemperature = (T_flow.signal + T_return.signal)*0.5 - convPort.T;
  //     end if;
  // This equation works better for stable equations, because the overtemperature can actually be directly calculated
  OverTemperature = max(volume.heatPort.T - convPort.T, 0.0);
  //The average radiator temperature is assumed to be the temperature of the volume, this avoids any division by zero and improves stability
  //Calculate the current power
  Power = RadiatorType.NominalPower * (OverTemperature / OverTemperature_Norm) ^ RadiatorType.Exponent;
  // Distribute the power to the convective and radiative ports
  //Extract the power from the water volume
  prescribedHeatFlow.Q_flow = -Power;
  //Set the convective power
  convPort.Q_flow = -Power * (1 - RadiatorType.RadPercent);
  //Set the radiative power
  radPort.Q_flow = -Power * RadiatorType.RadPercent;
  connect(prescribedHeatFlow.port, volume.heatPort) annotation(Line(points={{-26,12},
          {-10,12}},                                                                                        color = {191, 0, 0}));
  connect(port_a, T_flow.port_a) annotation (Line(
      points={{-100,0},{-78,0}},
      color={0,127,255}));
  connect(T_flow.port_b, volume.ports[1]) annotation (Line(
      points={{-58,0},{-2,0},{-2,2}},
      color={0,127,255}));
  connect(volume.ports[2], T_return.port_a) annotation (Line(
      points={{2,2},{4,0},{54,0}},
      color={0,127,255}));
  connect(T_return.port_b, port_b) annotation (Line(
      points={{74,0},{100,0}},
      color={0,127,255}));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-100,
            -100},{100,100}}),                                                                           graphics={                                                       Rectangle(extent={{
              -40,56},{40,28}},                                                                                                    lineColor=  {255, 0, 0},
            lineThickness=                                                                                                    1), Text(extent=  {{-34, 52}, {36, 28}}, lineColor=  {255, 0, 0},
            lineThickness=                                                                                                    1, fillColor=  {0, 0, 255},
            fillPattern=                                                                                                    FillPattern.Solid, textString=  "Heat transfer equations"), Line(points={{0,
              24},{0,32},{-2,30},{0,32},{2,30}},                                                                                                    color=  {255, 0, 0}, thickness=  1), Line(points=  {{28, 58}, {34, 68}, {30, 66}, {34, 68}, {34, 64}}, color=  {255, 0, 0}, thickness=  1), Line(points=  {{-32, 60}, {-38, 68}, {-38, 64}, {-38, 68}, {-34, 66}}, color=  {255, 0, 0}, thickness=  1)}), Icon(graphics={  Rectangle(extent=  {{-68, 56}, {-60, -74}}, lineColor=  {95, 95, 95}, fillColor=  {215, 215, 215},
            fillPattern=                                                                                                    FillPattern.Solid), Rectangle(extent=  {{-48, 56}, {-40, -74}}, lineColor=  {95, 95, 95}, fillColor=  {215, 215, 215},
            fillPattern=                                                                                                    FillPattern.Solid), Rectangle(extent=  {{-28, 56}, {-20, -74}}, lineColor=  {95, 95, 95}, fillColor=  {215, 215, 215},
            fillPattern=                                                                                                    FillPattern.Solid), Rectangle(extent=  {{-8, 56}, {0, -74}}, lineColor=  {95, 95, 95}, fillColor=  {215, 215, 215},
            fillPattern=                                                                                                    FillPattern.Solid), Rectangle(extent=  {{12, 56}, {20, -74}}, lineColor=  {95, 95, 95}, fillColor=  {215, 215, 215},
            fillPattern=                                                                                                    FillPattern.Solid), Rectangle(extent=  {{32, 56}, {40, -74}}, lineColor=  {95, 95, 95}, fillColor=  {215, 215, 215},
            fillPattern=                                                                                                    FillPattern.Solid), Rectangle(extent=  {{52, 56}, {60, -74}}, lineColor=  {95, 95, 95}, fillColor=  {215, 215, 215},
            fillPattern=                                                                                                    FillPattern.Solid), Rectangle(extent=  {{-74, -60}, {62, -70}}, lineColor=  {95, 95, 95}, fillColor=  {230, 230, 230},
            fillPattern=                                                                                                    FillPattern.Solid), Rectangle(extent=  {{-72, 50}, {64, 40}}, lineColor=  {95, 95, 95}, fillColor=  {230, 230, 230},
            fillPattern=FillPattern.Solid)}),
Documentation(revisions="<html>
  <ul>
  <li><i>April 30, 2015&nbsp;</i>
     by Marcus Fuchs:<br/>
     Correct a few typos in code comments</li>
  <li><i>November 2014&nbsp;</i>
     by Marcus Fuchs:<br/>
     Changed model to use Annex 60 base class</li>
  <li><i>November 2013&nbsp;</i>
     by Ana Constantin:<br/>
     Implemented</li>
  </ul>
 </html>", info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Simple model for a radiator with one water volume. </p>
 <h4><span style=\"color:#008000\">Level of Development</span></h4>
 <p><img src=\"modelica://AixLib/Resources/Images/Stars/stars3.png\"
    alt=\"stars: 3 out of 5\"/></p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>The power is calculated according to the flow and return temperatures, the
 power and temperatures in the design case and the radiator exponent.</p>
 <p>The power is split between convective and radiative heat transfer. </p>
 <h4><span style=\"color:#008000\">Example Results</span></h4>
 <p><a href=\"AixLib.HVAC.Radiators.Examples.PumpRadiatorValve\">
    AixLib.HVAC.Radiators.Examples.PumpRadiatorValve</a></p>
 <p><a href=\"AixLib.HVAC.Radiators.Examples.PumpRadiatorThermostaticValve\">
    AixLib.HVAC.Radiators.Examples.PumpRadiatorThermostaticValve</a></p>
 </html>"));
end Radiator;
