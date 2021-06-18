within AixLib.Airflow.GreenWall;
model GreenWall
  import SI = Modelica.SIunits;
  import Modelica.Math;
  replaceable package Medium = Modelica.Media.Air.MoistAir(extraPropertiesNames = {"CO2", "VOC", "PM2.5", "PM10"}, C_nominal = {C_nomCO2, C_nomVOC, C_nomPM25, C_nomPM10});
  constant SI.Density rho_Air = 1.29 "Density of air";
  constant SI.Density rho_CO2 = 1.977 "Density of CO2";
  constant SI.MolarMass M_Air = 29 "Molar mass of air";
  constant SI.MolarMass M_CO2 = 44 "Molar mass of CO2";
  constant Real C_nomCO2 = 450 * 10 ^ (-6) * M_CO2 / M_Air "Nominal Concentration of CO2";
  //constant Real C_nomVOC = 200*10^(-9) "Nominal Concentration of VOC";
  constant Real C_nomVOC = 190 * 10 ^ (-9) "Nominal Concentration of VOC";
  constant Real C_nomPM25 = 0.01 / rho_Air * 10 ^ (-9) "Nominal Concentration of PM2.5";
  constant Real C_nomPM10 = 0.1 / rho_Air * 10 ^ (-9) "Nominal Concentration of PM10";
  Real X_ein "Parameter resulting of the different definitions of mass flow in modelica and elsewhere";
  Real X_aus "Parameter resulting of the different definitions of mass flow in modelica and elsewhere";
  //parameter SI.Pressure deltap= 0.5*10^5 "Pressure difference provided by plant wall ventilators";
  // if Medium.nXi > 0
  parameter Real c_W = 0.42 "Gradient to describe evaporation";
  //parameter Real c_T = 0.3 "Gradient to describe the temperature drop";
  //parameter Real delta_CO2 = 0.019E-3 "Delta for constant CO2 degradiation";
  parameter Real c_CO2 = 0.07 "Gradient for Concentration dependent CO2 degradiation";
  parameter Real c_VOC = 0.5 "Gradient for Concentration dependent VOC degradiation";
  parameter Real c_PM25 = 0.2 "Gradient for Concentration dependent PM2.5 degradiation";
  parameter Real c_PM10 = 1.8 "Gradient for Concentration dependent PM10 degradiation";
  parameter SI.RelativeDensity C_minCO2 = 400 * 10 ^ (-6) * M_CO2 / M_Air "Minial relativ CO2 concentration for the entire setup";
  parameter SI.RelativeDensity C_minVOC = 1E-9 "Minial relativ VOC concentration inside the plant wall";
  parameter SI.RelativeDensity C_offVOC = -120E-9 "Offset of VOC concentration because of the plant wall";
  parameter SI.RelativeDensity C_minPM25 = 0.01/1.29*10^(-9) "Minimal relativ PM 2.5 concentration inside the plant wall";
  parameter SI.RelativeDensity C_minPM10 = 0.1/1.29*10^(-9) "Minimal relativ PM 10 concentration inside the plant wall";
  //parameter SI.Temperature T_min = 19+273.15 "Minimal temperature for the entire setup";
  parameter SI.MassFlowRate mflow_plantwall = 50 / 3600 * rho_Air "Air flow treated by the plant wall";
  constant SI.SpecificHeatCapacity c_pL = 1.01 * 1000 "specific heat capacity of air";
  constant SI.SpecificHeatCapacity c_pW = 1.864 * 1000 "specific heat capacity of water";
  parameter Real phi_max = 0.82 "Maximal by the plant wall reached moisture content";
  constant Real h_evap = 2260 * 1000 "Evaporation enthalpy of water";
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium = Medium) annotation (
    Placement(transformation(extent = {{-112, -10}, {-92, 10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium = Medium) annotation (
    Placement(transformation(extent = {{90, -10}, {110, 10}})));
  Modelica.Fluid.Sensors.TraceSubstances sensorCO2(redeclare package Medium = Medium) annotation (
    Placement(transformation(extent = {{-60, 48}, {-40, 68}})));
  Modelica.Fluid.Sensors.Temperature temperature(redeclare package Medium = Medium) annotation (
    Placement(transformation(extent = {{-60, 14}, {-40, 34}})));
  Modelica.Fluid.Sensors.MassFractions massFraction(redeclare package Medium = Medium) annotation (
    Placement(transformation(extent={{-60,100},{-40,120}})));
  inner Modelica.Fluid.System system annotation (
    Placement(transformation(extent = {{80, 80}, {100, 100}})));
  Modelica.Blocks.Sources.Constant airExchangeRate(k = mflow_plantwall) annotation (
    Placement(transformation(extent = {{2, -46}, {22, -26}})));
  Modelica.Blocks.Sources.Constant airExchangeRate1(k = -mflow_plantwall) annotation (
    Placement(transformation(extent = {{-34, -46}, {-14, -26}})));
  BaseClasses.GreenWallConsumption             greenWallConsumption annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={10,-70})));
  Modelica.Blocks.Interfaces.RealOutput Vwater annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {-10, -104})));
  Modelica.Blocks.Interfaces.RealOutput Wel annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {32, -104})));
  Modelica.Fluid.Sources.MassFlowSource_T inlet(use_m_flow_in = true, redeclare
      package Medium =                                                                           Medium, nPorts = 1) annotation (
    Placement(transformation(extent = {{-18, -10}, {-38, 10}})));
  Modelica.Fluid.Sources.MassFlowSource_T outlet(use_m_flow_in = true, use_T_in = true, use_X_in = true, use_C_in = true, redeclare
      package Medium =                                                                                                                               Medium, nPorts = 1) annotation (
    Placement(transformation(extent = {{46, -10}, {66, 10}})));
  Modelica.Fluid.Fittings.SimpleGenericOrifice orifice(redeclare package Medium = Medium, diameter = 0.36, zeta = 5) annotation (
    Placement(transformation(extent = {{-72, -10}, {-52, 10}})));
  Modelica.Fluid.Sensors.TraceSubstances sensorVOC(redeclare package Medium = Medium, substanceName = "VOC") annotation (
    Placement(transformation(extent = {{-22, 50}, {-2, 70}})));
  Modelica.Fluid.Sensors.TraceSubstances sensorPM2_5(redeclare package Medium = Medium, substanceName = "PM2.5") annotation (
    Placement(transformation(extent = {{18, 50}, {38, 70}})));
  Modelica.Fluid.Sensors.TraceSubstances sensorPM10(redeclare package Medium = Medium, substanceName = "PM10") annotation (
    Placement(transformation(extent = {{58, 50}, {78, 70}})));
  AixLib.Utilities.Psychrometrics.Phi_pTX phi annotation (
    Placement(transformation(extent={{4,100},{24,120}})));
  Modelica.Fluid.Sensors.Temperature temperature1(redeclare package Medium =
        Medium)                                                                     annotation (
    Placement(transformation(extent={{-60,130},{-40,150}})));
  Modelica.Fluid.Sensors.Pressure pressure(redeclare package Medium = Medium) annotation (
    Placement(transformation(extent={{-60,74},{-40,94}})));
  AixLib.Utilities.Psychrometrics.X_pTphi x_pTphi_out
    annotation (Placement(transformation(extent={{4,10},{24,30}})));
equation
  //der(X_w) = c_W * X_w_in;
  //outlet.C_in[Medium.nC] = traceSource.C - delta_CO2;
  outlet.C_in[1] = sensorCO2.C - (sensorCO2.C - C_minCO2) * c_CO2;
  //outlet.C_in[1] =sensorCO2.C - (sensorCO2.C - C_minCO2)*c_CO2;
  outlet.C_in[2] = sensorVOC.C - (sensorVOC.C - C_minVOC) * c_VOC + C_offVOC;
  outlet.C_in[3] = sensorPM2_5.C - (sensorPM2_5.C - C_minPM25) * c_PM25;
  outlet.C_in[4] = sensorPM10.C - (sensorPM10.C - C_minPM10) * c_PM10;
  //outlet.X_in[1] = massFraction.Xi + (X_max - massFraction.Xi) * c_W;
  x_pTphi_out.phi = phi.phi + (phi_max - phi.phi) * c_W;
  outlet.X_in[1] = x_pTphi_out.X[1];
  outlet.X_in[2] = 1 - outlet.X_in[1];
  //outlet.T_in = temperature.T - (temperature.T-T_min) * c_T;
  X_aus = 1 / (1 / outlet.X_in[1] - 1);
  X_ein = 1 / (1 / massFraction.Xi - 1);
  //X_aus = outlet.X_in[1];
  //X_ein = massFraction.Xi;
  x_pTphi_out.T = temperature.T - (X_aus - X_ein) * h_evap / (X_aus * c_pW + c_pL);
  outlet.T_in = x_pTphi_out.T;
  connect(port_a, temperature.port) annotation (
    Line(points = {{-102, 0}, {-76, 0}, {-76, 14}, {-50, 14}}, color = {0, 127, 255}));
  connect(port_a, sensorCO2.port) annotation (
    Line(points = {{-102, 0}, {-76, 0}, {-76, 40}, {-50, 40}, {-50, 48}}, color = {0, 127, 255}));
  connect(massFraction.port, sensorCO2.port) annotation (
    Line(points={{-50,100},{-76,100},{-76,40},{-50,40},{-50,48}},          color = {0, 127, 255}));
  connect(greenWallConsumption.electricEnergy, Wel) annotation (Line(points={{
          12.8,-80.4},{31.4,-80.4},{31.4,-104},{32,-104}}, color={0,0,127}));
  connect(greenWallConsumption.waterVolume, Vwater) annotation (Line(points={{9,
          -80.4},{-10.5,-80.4},{-10.5,-104},{-10,-104}}, color={0,0,127}));
  connect(airExchangeRate1.y, inlet.m_flow_in) annotation (
    Line(points = {{-13, -36}, {-8, -36}, {-8, 8}, {-18, 8}}, color = {0, 0, 127}));
  connect(port_b, outlet.ports[1]) annotation (
    Line(points = {{100, 0}, {66, 0}}, color = {0, 127, 255}));
  connect(airExchangeRate.y, outlet.m_flow_in) annotation (
    Line(points = {{23, -36}, {28, -36}, {28, 10}, {46, 10}, {46, 8}}, color = {0, 0, 127}));
  connect(port_a, orifice.port_a) annotation (
    Line(points = {{-102, 0}, {-72, 0}}, color = {0, 127, 255}));
  connect(orifice.port_b, inlet.ports[1]) annotation (
    Line(points = {{-52, 0}, {-38, 0}}, color = {0, 127, 255}));
  connect(sensorVOC.port, sensorCO2.port) annotation (
    Line(points = {{-12, 50}, {-12, 40}, {-50, 40}, {-50, 48}}, color = {0, 127, 255}));
  connect(sensorPM2_5.port, sensorCO2.port) annotation (
    Line(points = {{28, 50}, {28, 40}, {-50, 40}, {-50, 48}}, color = {0, 127, 255}));
  connect(sensorPM10.port, sensorCO2.port) annotation (
    Line(points = {{68, 50}, {68, 40}, {-50, 40}, {-50, 48}}, color = {0, 127, 255}));
  connect(temperature1.port, sensorCO2.port) annotation (Line(points={{-50,130},
          {-76,130},{-76,40},{-50,40},{-50,48}}, color={0,127,255}));
  connect(pressure.port, sensorCO2.port) annotation (Line(points={{-50,74},{-76,
          74},{-76,40},{-50,40},{-50,48}}, color={0,127,255}));
  connect(pressure.p, phi.p)
    annotation (Line(points={{-39,84},{3,84},{3,102}}, color={0,0,127}));
  connect(massFraction.Xi, phi.X_w)
    annotation (Line(points={{-39,110},{3,110}}, color={0,0,127}));
  connect(temperature1.T, phi.T) annotation (Line(points={{-43,140},{-20,140},{-20,
          118},{3,118}}, color={0,0,127}));
  connect(pressure.p, x_pTphi_out.p_in)
    annotation (Line(points={{-39,84},{2,84},{2,26}}, color={0,0,127}));
  annotation (
    Icon(graphics={  Rectangle(origin = {3, -5}, fillPattern = FillPattern.Solid, extent = {{-63, 105}, {57, -95}}), Rectangle(origin = {2, 4}, fillColor = {0, 172, 0},
            fillPattern =                                                                                                                                                              FillPattern.CrossDiag, extent = {{-52, 86}, {46, -64}})}),
    Documentation(info = "<html>
<p><b>Overview</b> </p>
<p><br>The modelled plant wall is of the type Naava One built by Naava. It is 1003 mm&times; 2113 mm &times; 350 mm (height&times;width&times;depth) in size. The front is covered by 63 plants growing in horizontal containers. The plant species used are <i>philodendron scandens</i> and <i>dracaena dermensis</i>. To ensure the exchange between plants, microbiota and air, fans take in air through the plant containers and release it back into the room. </p>
<p><br>The water and energy supply of the plants is managed by an automatic watering system and LED lighting [2].</p>
<h4>Assumptions </h4>
<p>Further details and explanations can be found in [1]</p>
<ul>
<li>Filtering of the trace sources depends on the difference between the current concentration and a plant wall-specific saturation value</li>
<li>Increase of the humidity depends on the difference between the current concentration and a plant wall specific saturation value</li>
<li>The energy and water consumption is assumed to be constant using mean values extracted from the experiments<br></li>
</ul>
<h4>Known Limitations</h4>
<ul>
<li>The variation of fan speed is not included in the model </li>
<li>Changes in evaporation due to pumping speed, lighting and plant activities are not included</li>
</ul>
<h4>References </h4>
<ul>
<li>[1] Bardey, J. (2020): Measurement and analysis of the influence of plant wall systems on indoor climate control (master thesis). RWTH Aachen University, Aachen. E.ON Energy Research Center, Institute for Energy Efficient Buildings and Indoor Climate; supervised by: Baranski, M.; M&uuml;ller, D.</li>
<li>[2] Naava (2020): Product brochure naava, 2020. URL https://www.naava.io/hubfs/Downloads/naava-product-brochure-EN.pdf?hsLang=en</li>
</ul>
<h4>Example Results</h4>
<p>7 validation experiments for trace substance CO2 are documented in [1, chapter 4.1.1]. </p>
<p>8 validation experiments for trace substance VOC are documented in [1, chapter 4.1.1]. </p>
<p>8 validation experiments for trace substance PM10 and PM25 are documented in [1, chapter 4.1.2]. </p>
<p>4 validation experiments for humidification are documented in [1, chapter 4.1.3]. </p>
</html>"));
end GreenWall;
