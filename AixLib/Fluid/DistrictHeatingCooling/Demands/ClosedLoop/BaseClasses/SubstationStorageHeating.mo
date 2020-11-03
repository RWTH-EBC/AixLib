within AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop.BaseClasses;
model SubstationStorageHeating

  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium;

  final parameter Modelica.SIunits.Density rho = 1000 "Density of Water";
  final parameter Real cp_default = 4180 "Cp-value of Water";

  //parameter Modelica.SIunits.Temperature T_out_HE = 273.15 + 45 "Constant HE outlet temperature";
  parameter Modelica.SIunits.Temperature T_min = 273.15 + 55 "Minimal temperature for heating supply";
  parameter Modelica.SIunits.Temperature T_max = 273.15 + 65 "Maximal temperature for heating supply";
  parameter Modelica.SIunits.Temperature T_start = 333.15 "Start temperature storage tank";
  parameter Modelica.SIunits.Time time_step = 3600 "Time Step of considered demand";
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal;

  constant Integer nSeg=5 "Number of volume segments";
  parameter Modelica.SIunits.Volume VTan=20 "Tank volume";

  Modelica.Blocks.Interfaces.RealInput T_out_HE(
    final quantity="Leaving Temperature of Heat Exchanger",
    final unit="K",
    displayUnit="K")
    "Leaving Temperature of Heat Exchanger" annotation (Placement(
        transformation(
        extent={{20,20},{-20,-20}},
        rotation=180,
        origin={-362,536}), iconTransformation(
        extent={{20,20},{-20,-20}},
        rotation=180,
        origin={-362,420})));

  AixLib.Fluid.Storage.Stratified         tan(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    hTan=3,
    VTan=VTan,
    nSeg=nSeg,
    T_start=T_min,
    dIns=0.2)            annotation (Placement(transformation(extent={{42,-34},
            {110,34}})));

  AixLib.Fluid.Sensors.MassFlowRate senMasFlo_coldside(redeclare package Medium =
        Medium, allowFlowReversal=true)
    annotation (Placement(transformation(extent={{246,-10},{266,10}})));
  AixLib.Fluid.Sensors.MassFlowRate senMasFlo_heatside(redeclare package Medium =
        Medium, allowFlowReversal=true)
    annotation (Placement(transformation(extent={{-288,-10},{-268,10}})));

  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-350,-10},{-330,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{290,-10},{310,10}}),
        iconTransformation(extent={{290,-10},{310,10}})));

  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TMidBot
    "Temperature tank layer 2"
    annotation (Placement(transformation(extent={{72,122},{52,142}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TBot
    "Temperature tank bottom"
    annotation (Placement(transformation(extent={{70,72},{50,92}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TTop
    "Temperature tank top"
    annotation (Placement(transformation(extent={{70,306},{50,326}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TMidTop
    "Temperature tank layer 4"
    annotation (Placement(transformation(extent={{74,260},{54,280}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TMid
    "Temperature tank middle"
    annotation (Placement(transformation(extent={{68,198},{48,218}})));
  Modelica.Blocks.Interfaces.RealOutput Q_max_dis(
    final quantity="Maximum Heat Power for Discharging Storage",
    final unit="W",
    min=0,
    displayUnit="W") "Maximum Heat Power for Discharging Storage" annotation (
      Placement(transformation(
        extent={{-16,-16},{16,16}},
        rotation=0,
        origin={314,504}), iconTransformation(
        extent={{-41,-41},{41,41}},
        rotation=-90,
        origin={-29,-201})));
  Modelica.Blocks.Math.Sum sum2(nin=5)
    annotation (Placement(transformation(extent={{-116,386},{-88,414}})));
  Modelica.Blocks.Interfaces.RealOutput T_storage_average
    annotation (Placement(transformation(extent={{298,366},{346,414}}),
        iconTransformation(extent={{300,368},{376,444}})));
  Modelica.Blocks.Math.Gain gain(k=1/5)
    annotation (Placement(transformation(extent={{-56,390},{-36,410}})));
    Modelica.Blocks.Sources.RealExpression deltaTSet10(y=0)
    annotation (Placement(transformation(extent={{120,468},{140,488}})));
  Modelica.Blocks.Math.Max max_deltaT_HE
    annotation (Placement(transformation(extent={{200,492},{220,512}})));
  Modelica.Blocks.Interfaces.RealOutput SOC
    annotation (Placement(transformation(extent={{300,190},{350,240}}),
        iconTransformation(extent={{300,234},{370,304}})));
  Modelica.Blocks.Interfaces.RealOutput SOC_Wh
    annotation (Placement(transformation(extent={{300,84},{350,134}}),
        iconTransformation(extent={{300,84},{372,156}})));
    Modelica.Blocks.Sources.RealExpression deltaTSet11(y=(rho*cp_default/3600)*(
        (tan.VTan/5)*(T_max - TTop.T) + (tan.VTan/5)*(T_max - TMidTop.T) + (tan.VTan
        /5)*(T_max - TMid.T) + (tan.VTan/5)*(T_max - TMidBot.T) + (tan.VTan/5)*(
        T_max - TBot.T)))
    annotation (Placement(transformation(extent={{212,150},{232,170}})));
    Modelica.Blocks.Sources.RealExpression deltaTSet12(y=(T_storage_average -
        T_min)/(T_max - T_min))
    annotation (Placement(transformation(extent={{170,198},{190,218}})));
    Modelica.Blocks.Sources.RealExpression deltaTSet7(y=0)
    annotation (Placement(transformation(extent={{164,172},{184,192}})));
  Modelica.Blocks.Math.Add add3(k2=+1, k1=-1)
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=180,
        origin={56,530})));
  Modelica.Blocks.Math.Gain gain1(k=tan.VTan*rho*cp_default/3600)
    annotation (Placement(transformation(extent={{120,520},{140,540}})));
  Modelica.Blocks.Math.Max max_deltaT_HE1
    annotation (Placement(transformation(extent={{232,202},{252,222}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=293.15)
    annotation (Placement(transformation(extent={{48,-68},{134,-154}})));
equation

  connect(port_b, senMasFlo_coldside.port_b)
    annotation (Line(points={{300,0},{284,0},{284,0},{266,0}},
                                               color={0,127,255}));
  connect(TTop.port, tan.heaPorVol[1])
    annotation (Line(points={{70,316},{70,0},{76,0}},   color={191,0,0}));
  connect(TMidTop.port, tan.heaPorVol[2])
    annotation (Line(points={{74,270},{74,0},{76,0}},   color={191,0,0}));
  connect(TMid.port, tan.heaPorVol[3])
    annotation (Line(points={{68,208},{68,0},{76,0}},   color={191,0,0}));
  connect(TMidBot.port, tan.heaPorVol[4]) annotation (Line(points={{72,132},{86,
          132},{86,0},{76,0}}, color={191,0,0}));
  connect(TBot.port, tan.heaPorVol[5]) annotation (Line(points={{70,82},{64,82},
          {64,78},{76,78},{76,0}}, color={191,0,0}));
  connect(senMasFlo_heatside.port_a, port_a)
    annotation (Line(points={{-288,0},{-340,0}}, color={0,127,255}));
  connect(senMasFlo_coldside.port_a, tan.port_b) annotation (Line(points={{246,0},
          {110,0}},                 color={0,127,255}));
  connect(sum2.y, gain.u)
    annotation (Line(points={{-86.6,400},{-58,400}}, color={0,0,127}));
  connect(deltaTSet10.y, max_deltaT_HE.u2) annotation (Line(points={{141,478},{
          198.5,478},{198.5,496},{198,496}}, color={0,0,127}));
  connect(deltaTSet11.y, SOC_Wh) annotation (Line(points={{233,160},{280,160},{
          280,109},{325,109}}, color={0,0,127}));
  connect(senMasFlo_heatside.port_b, tan.port_a) annotation (Line(points={{-268,0},
          {42,0}},                      color={0,127,255}));
  connect(gain.y, T_storage_average) annotation (Line(points={{-35,400},{136,
          400},{136,390},{322,390}}, color={0,0,127}));
  connect(gain1.u, add3.y)
    annotation (Line(points={{118,530},{67,530}}, color={0,0,127}));
  connect(TTop.T, sum2.u[5]) annotation (Line(points={{50,316},{-56,316},{-56,
          320},{-166,320},{-166,402.24},{-118.8,402.24}}, color={0,0,127}));
  connect(TMidTop.T, sum2.u[4]) annotation (Line(points={{54,270},{-86,270},{
          -86,272},{-206,272},{-206,401.12},{-118.8,401.12}}, color={0,0,127}));
  connect(TMid.T, sum2.u[3]) annotation (Line(points={{48,208},{-22,208},{-22,
          214},{-270,214},{-270,400},{-118.8,400}}, color={0,0,127}));
  connect(TMidBot.T, sum2.u[2]) annotation (Line(points={{52,132},{-114,132},{
          -114,136},{-298,136},{-298,398.88},{-118.8,398.88}}, color={0,0,127}));
  connect(TBot.T, sum2.u[1]) annotation (Line(points={{50,82},{-136,82},{-136,
          96},{-322,96},{-322,397.76},{-118.8,397.76}}, color={0,0,127}));
  connect(T_out_HE, add3.u1) annotation (Line(points={{-362,536},{-158,536},{
          -158,536},{44,536}}, color={0,0,127}));
  connect(gain1.y, max_deltaT_HE.u1) annotation (Line(points={{141,530},{188,
          530},{188,508},{198,508}}, color={0,0,127}));
  connect(deltaTSet7.y, max_deltaT_HE1.u2) annotation (Line(points={{185,182},{
          206,182},{206,206},{230,206}}, color={0,0,127}));
  connect(deltaTSet12.y, max_deltaT_HE1.u1) annotation (Line(points={{191,208},
          {209.5,208},{209.5,218},{230,218}}, color={0,0,127}));
  connect(max_deltaT_HE1.y, SOC) annotation (Line(points={{253,212},{278,212},{
          278,215},{325,215}}, color={0,0,127}));
  connect(add3.u2, T_storage_average) annotation (Line(points={{44,524},{38,524},
          {38,400},{136,400},{136,390},{322,390}}, color={0,0,127}));
  connect(max_deltaT_HE.y, Q_max_dis) annotation (Line(points={{221,502},{262,
          502},{262,504},{314,504}}, color={0,0,127}));
  connect(tan.heaPorSid, fixedTemperature.port) annotation (Line(points={{95.04,0},
          {114,0},{114,-111},{134,-111}},    color={191,0,0}));
  connect(tan.heaPorBot, fixedTemperature.port) annotation (Line(points={{82.8,
          -25.16},{82.8,-66.58},{134,-66.58},{134,-111}}, color={191,0,0}));
  connect(tan.heaPorTop, fixedTemperature.port) annotation (Line(points={{82.8,
          25.16},{82.8,-41.42},{134,-41.42},{134,-111}}, color={191,0,0}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-340,-160},
            {300,580}}),         graphics={ Text(
            extent={{-150,76},{-24,58}},
            lineColor={135,135,135},
            fillColor={255,255,170},
            fillPattern=FillPattern.Solid,
            textString="%name"),                               Rectangle(extent={{
              -340,580},{300,202}},   lineColor={135,135,135},
            fillColor={238,46,47},
            fillPattern=FillPattern.Solid), Text(
            extent={{-196,370},{164,116}},
            lineColor={0,0,0},
            fillColor={255,255,170},
            fillPattern=FillPattern.Solid,
          textString="%Substation
Storage


"),                                                            Rectangle(extent={{
              -340,206},{300,-162}},  lineColor={135,135,135},
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid)}),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-340,-160},{300,
            580}})));
end SubstationStorageHeating;
