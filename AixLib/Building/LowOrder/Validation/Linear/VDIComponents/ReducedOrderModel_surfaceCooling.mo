within AixLib.Building.LowOrder.Validation.Linear.VDIComponents;
model ReducedOrderModel_surfaceCooling "Modell corresponding to VDI 6007"
  parameter Boolean withInnerwalls = true "If inner walls are existent" annotation(Dialog(tab = "Inner walls"));
  parameter Modelica.SIunits.ThermalResistance R1i = 0.0005955
    "Resistor 1 inner wall"                                                            annotation(Dialog(tab = "Inner walls", enable = if withInnerwalls then true else false));
  parameter Modelica.SIunits.HeatCapacity C1i = 14860000
    "Capacity 1 inner wall"                                                      annotation(Dialog(tab = "Inner walls", enable = if withInnerwalls then true else false));
  parameter Modelica.SIunits.Area Ai = 75.5 "Inner wall area" annotation(Dialog(tab = "Inner walls", enable = if withInnerwalls then true else false));
  parameter Modelica.SIunits.Temp_K T0all = 295.15
    "Initial temperature for all components";
  parameter Boolean withWindows = true "If windows are existent" annotation(Dialog(tab = "Outer walls", group = "Windows", enable = if withOuterwalls then true else false));
  parameter Real splitfac = 0 "Factor for conv. part of rad. through windows" annotation(Dialog(tab = "Outer walls", group = "Windows", enable = if withWindows and withOuterwalls then true else false));
  parameter Modelica.SIunits.Area Aw = 10.5 "Window area" annotation(Dialog(tab = "Outer walls", group = "Windows", enable = if withWindows and withOuterwalls then true else false));
  parameter Modelica.SIunits.Emissivity epsw = 0.95 "Emissivity of the windows"
                                                                                annotation(Dialog(tab = "Outer walls", group = "Windows", enable = if withWindows and withOuterwalls then true else false));
  parameter Modelica.SIunits.TransmissionCoefficient g = 0.7
    "Total energy transmittance"                                                          annotation(Dialog(tab = "Outer walls", group = "Windows", enable = if withWindows and withOuterwalls then true else false));
  parameter Boolean withOuterwalls = true
    "If outer walls (including windows) are existent"                                       annotation(Dialog(tab = "Outer walls"));
  parameter Modelica.SIunits.ThermalResistance RRest = 0.0427487
    "Resistor Rest outer wall"                                                              annotation(Dialog(tab = "Outer walls", enable = if withOuterwalls then true else false));
  parameter Modelica.SIunits.ThermalResistance R1o = 0.004366
    "Resistor 1 outer wall"                                                           annotation(Dialog(tab = "Outer walls", enable = if withOuterwalls then true else false));
  parameter Modelica.SIunits.HeatCapacity C1o = 1557570 "Capacity 1 outer wall"
                                                                                annotation(Dialog(tab = "Outer walls", enable = if withOuterwalls then true else false));
  parameter Modelica.SIunits.Area Ao = 10.5 "Outer wall area" annotation(Dialog(tab = "Outer walls", enable = if withOuterwalls then true else false));
  parameter Modelica.SIunits.Volume Vair = 52.5 "Volume of the air in the zone"
                                                                                annotation(Dialog(tab = "Room air"));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaiwi = 2.7
    "Coefficient of heat transfer for inner walls"                                                                   annotation(Dialog(tab = "Inner walls", enable = if withInnerwalls then true else false));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaowi = 2.7
    "Outer wall's coefficient of heat transfer (inner side)"                                                                   annotation(Dialog(tab = "Outer walls", enable = if withOuterwalls then true else false));
  parameter Modelica.SIunits.Density rhoair = 1.19 "Density of the air" annotation(Dialog(tab = "Room air"));
  parameter Modelica.SIunits.SpecificHeatCapacity cair = 1007
    "Heat capacity of the air"                                                           annotation(Dialog(tab = "Room air"));
  parameter Modelica.SIunits.Emissivity epsi = 0.95
    "Emissivity of the inner walls"                                                 annotation(Dialog(tab = "Inner walls", enable = if withInnerwalls then true else false));
  parameter Modelica.SIunits.Emissivity epso = 0.95
    "Emissivity of the outer walls"                                                 annotation(Dialog(tab = "Outer walls", enable = if withOuterwalls then true else false));
  Components.DryAir.Airload airload(V = Vair, rho = rhoair, c = cair) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {2, 2})));
  Utilities.HeatTransfer.HeatConv conv_innerwall(A = Ai, alpha = alphaiwi) if withInnerwalls annotation(Placement(transformation(extent = {{28, -10}, {48, 10}})));
  Building.LowOrder.BaseClasses.SimpleOuterWall outerwall(RRest = RRest, R1 = R1o, C1 = C1o, T0 = T0all) if withOuterwalls annotation(Placement(transformation(extent = {{-70, -10}, {-50, 10}})));
  Building.LowOrder.BaseClasses.SimpleInnerWall innerwall(R1 = R1i, C1 = C1i, T0 = T0all) if withInnerwalls annotation(Placement(transformation(extent = {{56, -10}, {76, 10}})));
  Utilities.HeatTransfer.HeatConv conv_outerwall_innerside(A = Ao, alpha = alphaowi) if withOuterwalls annotation(Placement(transformation(extent = {{-24, -10}, {-44, 10}})));
  Utilities.HeatTransfer.HeatToStar rad_outerwall_innerside(eps = epso, A = Ao) if withOuterwalls annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-46, 22})));
  Utilities.HeatTransfer.HeatToStar rad_innerwall(A = Ai, eps = epsi) if withInnerwalls annotation(Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 270, origin = {52, 22})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a innerLoadskonv(T(nominal = 273.15 + 22, min = 273.15 - 30, max = 273.15 + 60)) annotation(Placement(transformation(extent = {{-4, -100}, {16, -80}}), iconTransformation(extent = {{-28, -100}, {12, -60}})));
  Components.DryAir.VarAirExchange airexchange(V = Vair, c = cair, rho = rhoair) annotation(Placement(transformation(extent = {{-44, -40}, {-24, -20}})));
  Modelica.Blocks.Interfaces.RealInput InfiltrationVentilationRate annotation(Placement(transformation(extent = {{20, -20}, {-20, 20}}, rotation = 270, origin = {-40, -100}), iconTransformation(extent = {{20, -20}, {-20, 20}}, rotation = 270, origin = {-50, -80})));
  Modelica.Blocks.Interfaces.RealInput outdoorairtemp annotation(Placement(transformation(extent = {{-120, -82}, {-80, -42}}), iconTransformation(extent = {{-100, -28}, {-60, -68}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a equivalentoutdoortemp if withOuterwalls annotation(Placement(transformation(extent = {{-110, -20}, {-70, 20}}), iconTransformation(extent = {{-100, -16}, {-60, 24}})));
  Utilities.Interfaces.Star innerLoadsrad annotation(Placement(transformation(extent = {{70, -100}, {90, -80}}), iconTransformation(extent = {{54, -102}, {100, -58}})));
  Utilities.HeatTransfer.SolarRadToHeat conv_window_rad(coeff = g, A = Aw) if withWindows and withOuterwalls annotation(Placement(transformation(extent = {{-46, 74}, {-26, 94}}, rotation = 0)));
  Utilities.Interfaces.SolarRad_in Rad_In if withWindows and withOuterwalls annotation(Placement(transformation(extent = {{-102, 60}, {-82, 80}}, rotation = 0), iconTransformation(extent = {{-102, 34}, {-60, 74}})));
  Building.LowOrder.BaseClasses.SolarRadMultiplier rad_split_rad(x = 1 - splitfac) if withWindows and withOuterwalls annotation(Placement(transformation(extent = {{-72, 72}, {-52, 92}})));
  Building.LowOrder.BaseClasses.SolarRadMultiplier rad_split_conv(x = splitfac) if withWindows and withOuterwalls annotation(Placement(transformation(extent = {{-72, 48}, {-52, 68}})));
  Utilities.HeatTransfer.SolarRadToHeat conv_window_conv(A = Aw, coeff = g) if withWindows and withOuterwalls annotation(Placement(transformation(extent = {{-46, 50}, {-26, 70}}, rotation = 0)));
  Utilities.HeatTransfer.HeatToStar rad_window(A = Aw, eps = epsw) if withWindows and withOuterwalls annotation(Placement(transformation(extent = {{-20, 72}, {0, 92}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a surfaceCooling(T(nominal = 273.15 + 22, min = 273.15 - 30, max = 273.15 + 60)) annotation(Placement(transformation(extent = {{40, -100}, {60, -80}}), iconTransformation(extent = {{16, -100}, {56, -60}})));
protected
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature outdoorairtemp1 annotation(Placement(transformation(extent = {{-74, -64}, {-54, -44}})));
initial equation
  if abs(Aw) < 0.00001 and withWindows then
    Modelica.Utilities.Streams.print("WARNING!:in ReducedModel, withWindows is true (windows existent), but the area of the windows Aw is zero (or nearly zero). This might cause an error.");
  end if;
  if abs(Ao) < 0.00001 and withOuterwalls then
    Modelica.Utilities.Streams.print("WARNING!:in ReducedModel,withWindows is true (windows existent), but the area of the windows Aw is zero (or nearly zero). This might cause an error.");
  end if;
  if abs(Ai) < 0.00001 and withInnerwalls then
    Modelica.Utilities.Streams.print("WARNING!:in ReducedModel,withWindows is true (windows existent), but the area of the windows Aw is zero (or nearly zero). This might cause an error.");
  end if;
equation
  if withWindows and withOuterwalls then
    connect(conv_window_rad.heatPort, rad_window.Therm) annotation(Line(points = {{-27, 82}, {-19.2, 82}}, color = {191, 0, 0}, smooth = Smooth.None));
    if withOuterwalls then
    else
      assert(withOuterwalls, "There must be outer walls, windows have to be counted too!");
    end if;
    if withInnerwalls then
    end if;
  end if;
  if withOuterwalls then
    connect(equivalentoutdoortemp, outerwall.port_a) annotation(Line(points = {{-90, 0}, {-80, 0}, {-80, -0.909091}, {-70, -0.909091}}, color = {191, 0, 0}, smooth = Smooth.None));
    connect(outerwall.port_b, rad_outerwall_innerside.Therm) annotation(Line(points = {{-50, -0.909091}, {-46, -0.909091}, {-46, 12.8}}, color = {191, 0, 0}, smooth = Smooth.None));
    connect(outerwall.port_b, conv_outerwall_innerside.port_b) annotation(Line(points = {{-50, -0.909091}, {-46.5, -0.909091}, {-46.5, 0}, {-44, 0}}, color = {191, 0, 0}, smooth = Smooth.None));
    connect(conv_outerwall_innerside.port_a, airload.port) annotation(Line(points = {{-24, 0}, {-24, 0}, {-7, 0}}, color = {191, 0, 0}, smooth = Smooth.None));
    if withInnerwalls then
    end if;
  end if;
  if withInnerwalls then
    connect(innerwall.port_a, conv_innerwall.port_b) annotation(Line(points = {{56, -0.909091}, {51.5, -0.909091}, {51.5, 0}, {48, 0}}, color = {191, 0, 0}, smooth = Smooth.None));
    connect(innerLoadsrad, rad_innerwall.Star) annotation(Line(points = {{80, -90}, {80, 54}, {10, 54}, {10, 40}, {52, 40}, {52, 31.1}}, color = {95, 95, 95}, pattern = LinePattern.None, smooth = Smooth.None));
  end if;
  connect(outdoorairtemp1.T, outdoorairtemp) annotation(Line(points = {{-76, -54}, {-88, -54}, {-88, -62}, {-100, -62}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(airexchange.port_b, airload.port) annotation(Line(points = {{-24, -30}, {-16, -30}, {-16, 0}, {-7, 0}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(innerLoadskonv, airload.port) annotation(Line(points = {{6, -90}, {6, -30}, {-16, -30}, {-16, 0}, {-7, 0}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(airload.port, conv_innerwall.port_a) annotation(Line(points = {{-7, 0}, {-16, 0}, {-16, -30}, {20, -30}, {20, 0}, {28, 0}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(rad_innerwall.Therm, innerwall.port_a) annotation(Line(points = {{52, 12.8}, {52, -0.909091}, {56, -0.909091}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(rad_outerwall_innerside.Star, innerLoadsrad) annotation(Line(points = {{-46, 31.1}, {-46, 40}, {10, 40}, {10, 54}, {80, 54}, {80, -90}}, color = {95, 95, 95}, pattern = LinePattern.None, smooth = Smooth.None));
  connect(rad_window.Star, innerLoadsrad) annotation(Line(points = {{-0.9, 82}, {10, 82}, {10, 54}, {80, 54}, {80, -90}}, color = {95, 95, 95}, pattern = LinePattern.None, smooth = Smooth.None));
  connect(conv_window_conv.heatPort, airload.port) annotation(Line(points = {{-27, 58}, {-16, 58}, {-16, 0}, {-7, 0}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(outdoorairtemp1.port, airexchange.port_a) annotation(Line(points = {{-54, -54}, {-78, -54}, {-78, -30}, {-44, -30}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(InfiltrationVentilationRate, airexchange.InPort1) annotation(Line(points = {{-40, -100}, {-40, -60}, {-50, -60}, {-50, -36.4}, {-43, -36.4}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(surfaceCooling, conv_innerwall.port_b) annotation(Line(points = {{50, -90}, {50, 0}, {48, 0}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(Rad_In, rad_split_rad.solarRad_in) annotation(Line(points = {{-92, 70}, {-82, 70}, {-82, 82}, {-71, 82}}, color = {255, 128, 0}, smooth = Smooth.None));
  connect(rad_split_conv.solarRad_in, Rad_In) annotation(Line(points = {{-71, 58}, {-78, 58}, {-78, 70}, {-92, 70}}, color = {255, 128, 0}, smooth = Smooth.None));
  connect(rad_split_conv.solarRad_out, conv_window_conv.solarRad_in) annotation(Line(points = {{-53, 58}, {-46.1, 58}}, color = {255, 128, 0}, smooth = Smooth.None));
  connect(rad_split_rad.solarRad_out, conv_window_rad.solarRad_in) annotation(Line(points = {{-53, 82}, {-46.1, 82}}, color = {255, 128, 0}, smooth = Smooth.None));
  annotation(Line(points = {{50, -90}, {-4, -90}, {-4, -90}, {50, -90}}, color = {191, 0, 0}, smooth = Smooth.None), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), experiment(StopTime = 864000), experimentSetupOutput, Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent = {{-60, 74}, {100, -72}}, lineColor = {135, 135, 135}, fillColor = {135, 135, 135},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{14, 38}, {46, 12}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid,
            lineThickness =                                                                                                   1), Rectangle(extent = {{14, 12}, {46, -14}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid,
            lineThickness =                                                                                                   1), Rectangle(extent = {{-18, 12}, {14, -14}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid,
            lineThickness =                                                                                                   1), Rectangle(extent = {{-18, 38}, {14, 12}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                   FillPattern.Solid,
            lineThickness =                                                                                                   1)}), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <ul>
 <li>ReducedOrderModel is a simple component to compute the air temperature, heating load, etc. for a thermal zone. The zone is simplified to one outer wall, one inner wall and one air node. It is build out of standard components and <a href=\"AixLib.Building.LowOrder.BaseClasses.SimpleOuterWall\">SimpleOuterWall</a> and <a href=\"AixLib.Building.LowOrder.BaseClasses.SimpleInnerWall\">SimpleInnerWall</a>.</li>
 <li>The simplifications are based on the VDI 6007, which describes the thermal behaviour of a thermal zone with the equations for an electric circuit, hence they are equal. The heat transfer is described with resistances and the heat storage with capacitances.</li>
 <li>The resolution of the model is very rough (only one air node), so the model is primarly thought for computing the air temperature of the room and with that, the heating and cooling load. It is more a heat load generator than a full building model. It is thought mainly for city district simulations, in which a lot of buildings has to be taken into account and the specific cirumstances in one building can be neglected.</li>
 <li>Inputs: The model needs the outdoor air temperature and the Infiltration/VentilationRate for the Ventilation, the equivalent outdoor temperature (see <a href=\"AixLib.Building.LowOrder.BaseClasses.EqAirTemp\">EqAirTemp</a>) for the heat conductance through the outer walls and the solar radiation through the windows. There are two ports, one thermal, one star, for inner loads, heating etc. . </li>
 <li>Parameters: Inner walls: R and C for the heat conductance and storage in the wall, A, alpha and epsilon for the heat transfer. Outer walls: Similar to inner walls, but with two R&apos;s, as there is also a conductance through the walls. Windows: g, A, epsilon and a splitfac. Please see VDI 6007 for computing the R&apos;s and C&apos;s.</li>
 </ul>
 <h4><span style=\"color:#008000\">Level of Development</span></h4>
 <p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>The concept is described in VDI 6007. All outer walls and inner walls (including the windows) are merged together to one wall respectively. The inner walls are used as heat storages only, there is no heat transfer out of the zone (adiabate). This assumption is valid as long as the walls are in the zone or touch zones with a similar temperature. All walls, which touch other thermal zones are put together in the outer walls, which have an heat transfer with <a href=\"AixLib.Building.LowOrder.BaseClasses.EqAirTemp\">EqAirTemp</a>.</p>
 <p>The two different &QUOT;wall types&QUOT; are connected through a convective heat circuit and a star circuit (different as in VDI 6007). As the air node can only react to convective heat, it is integrated in the convectice heat circuit. To add miscellaneous other heat sources/sinks (inner loads, heating) to the circiuts, there is one heat port to the convective circuit and one star port to the star circuit.</p>
 <p>The last influence is the solar radiation through the windows. The heat transfer through the windows is considered in the outer walls. The beam is considered in the star circuit. There is a bypass from the beam to the convective circuit implemented, as a part of the beam is sometimes considered directly as convective heat.</p>
 <p><br><b><font style=\"color: #008000; \">References</font></b></p>
 <ul>
 <li>German Association of Engineers: Guideline VDI 6007-1, March 2012: Calculation of transient thermal response of rooms and buildings - Modelling of rooms.</li>
 <li>Lauster, M.; Teichmann, J.; Fuchs, M.; Streblow, R.; Mueller, D. (2014): Low order thermal network models for dynamic simulations of buildings on city district scale. In: Building and Environment 73, p. 223&ndash;231. DOI: <a href=\"http://dx.doi.org/10.1016/j.buildenv.2013.12.016\">10.1016/j.buildenv.2013.12.016</a></p>.</li>
 </ul>
 <h4><span style=\"color:#008000\">Example Results</span></h4>
 <p>See <a href=\"AixLib.Building.LowOrder.Validation\">Vadliation</a> for some results. </p>
 </html>", revisions = "<html>
 <p><ul>
 <li><i>January 2012,&nbsp;</i> by Moritz Lauster:<br/>Implemented.</li>
 <li><i>Febraury 2014</i>, by Moritz Lauster: Reduced model with cooling ceeling</li>
 </ul></p>
 </html>"));
end ReducedOrderModel_surfaceCooling;
