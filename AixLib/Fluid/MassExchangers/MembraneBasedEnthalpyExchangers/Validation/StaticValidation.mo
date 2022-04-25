within AixLib.Fluid.MassExchangers.MembraneBasedEnthalpyExchangers.Validation;
model StaticValidation
  "example containing validation for static behaviour of membrane-based enthalpy exchanger"
  extends Modelica.Icons.Example;

  // parameters (for better change on the fly)
  parameter Integer nParallel=184
    "Number of identical parallel flow devices";
  parameter Integer n = 15
    "number of discrete segments";
  parameter Modelica.Units.SI.Length heightDuct=0.00225 "height of duct";
  parameter Modelica.Units.SI.Length widthDuct=0.305 "width of duct";
  parameter Modelica.Units.SI.Length lengthDuct=0.34
    "length of duct in flow direction";
  parameter Real aspRatCroToTot = 0.25 "aspect ratio of cross flow";
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=400/3600*1.18
    "nominal mass flow rate";
  parameter Modelica.Units.SI.Pressure dp_nominal=119.5 "nominal pressure drop";
  parameter Modelica.Units.SI.Length thicknessMem=110E-6
    "thickness of membrane";
  parameter Modelica.Units.SI.SpecificHeatCapacity cpMem=1900
    "mass weighted heat capacity of membrane";
  parameter Modelica.Units.SI.ThermalConductivity lambdaMem=0.24
    "thermal conductivity of membrane";
  parameter Modelica.Units.SI.Density rhoMem=920 "density of membrane";
  parameter Modelica.Units.SI.Temperature T_start=283.15
    "membrane temperature start value";
  parameter Modelica.Units.SI.Temperature dT=10
    "Start value for port_b.T - port_a.T";
  parameter Modelica.Units.SI.Pressure p_start=1200.0
    "membrane concentration start value";
  parameter Modelica.Units.SI.Pressure dp=100.0
    "Start value for concentration gradient in membrane";
  parameter Modelica.Units.SI.MassFlowRate m_flow_start=m_flow_nominal
    "Start value for mass flow rate";
  parameter Real A=5.38E7 "constant A of linear dependency equation for permeability";
  parameter Real B=4.64E5 "constant B of linear dependency equation for permeability";

  EnthalpyExchanger enthalpyExchanger(
    redeclare package Medium = Media.Air,
    n=n,
    nParallel=nParallel,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    lengthDuct=lengthDuct,
    heightDuct=heightDuct,
    widthDuct=widthDuct,
    couFloArr=false,
    aspRatCroToTot=aspRatCroToTot,
    uniWalTem=true,
    local=true,
    nWidth=30,
    recDuct=true,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=dp_nominal,
    thicknessMem=thicknessMem,
    cpMem=cpMem,
    lambdaMem=lambdaMem,
    rhoMem=rhoMem,
      useConPer=false,
    T_start_m=T_start,
    dT_start=dT,
    p_start_m=p_start,
    dp_start=dp)
    annotation (Placement(transformation(extent={{-22,-14},{14,12}})));
  AixLib.Fluid.Sources.Boundary_pT souEta(
    redeclare package Medium = Media.Air,
    use_Xi_in=true,
    nPorts=1,
    use_T_in=true,
    T=294.0495)
    annotation (Placement(transformation(extent={{-76,50},{-56,70}})));
  Sensors.MassFractionTwoPort senMasFraEta(
    redeclare package Medium = Media.Air,
    m_flow_nominal=m_flow_nominal,
    tau=15,
    X_start=0.008)
            annotation (Placement(transformation(extent={{-52,50},{-32,70}})));
  Sensors.TemperatureTwoPort senTemEta(
    redeclare package Medium = Media.Air,
    m_flow_nominal=m_flow_nominal,
    tau=15,
    T_start=293.15)
            annotation (Placement(transformation(extent={{-28,50},{-8,70}})));
  Sensors.VolumeFlowRate senVolFloEta(
    redeclare package Medium = Media.Air,
    m_flow_nominal=0.2)
    annotation (Placement(transformation(extent={{-14,24},{-34,44}})));
  Sensors.TemperatureTwoPort senTemEha(
    redeclare package Medium = Media.Air,
    m_flow_nominal=m_flow_nominal,
    tau=15) annotation (Placement(transformation(extent={{10,50},{30,70}})));
  Sensors.MassFractionTwoPort senMasFraEha(
    redeclare package Medium = Media.Air,
    m_flow_nominal=m_flow_nominal,
    tau=15) annotation (Placement(transformation(extent={{36,50},{56,70}})));
  Sources.Boundary_pT sinEha(
    redeclare package Medium = Media.Air,
    nPorts=1) annotation (Placement(transformation(extent={{82,50},{62,70}})));
  Sources.Boundary_pT souOda(
    redeclare package Medium = Media.Air,
    use_Xi_in=true,
    nPorts=1,
    use_p_in=false,
    use_T_in=true,
    T=294.0495)
    annotation (Placement(transformation(extent={{76,-70},{56,-50}})));
  Sensors.MassFractionTwoPort senMasFraOda(
    redeclare package Medium = Media.Air,
    m_flow_nominal=m_flow_nominal,
    tau=15,
    X_start=0.002)
            annotation (Placement(transformation(extent={{48,-70},{28,-50}})));
  Sensors.TemperatureTwoPort senTemOda(
    redeclare package Medium = Media.Air,
    m_flow_nominal=m_flow_nominal,
    tau=15,
    T_start=283.15)
            annotation (Placement(transformation(extent={{22,-70},{2,-50}})));
  Sensors.VolumeFlowRate senVolFloOda(
    redeclare package Medium = Media.Air,
    m_flow_nominal=0.2)
    annotation (Placement(transformation(extent={{18,-18},{38,-38}})));
  Sources.Boundary_pT sinSup(
    redeclare package Medium = Media.Air,
    nPorts=1)
    annotation (Placement(transformation(extent={{-88,-70},{-68,-50}})));
  Sensors.MassFractionTwoPort senMasFraSup(
    redeclare package Medium = Media.Air,
    m_flow_nominal=m_flow_nominal,
    tau=6)  annotation (Placement(transformation(extent={{-42,-70},{-62,-50}})));
  Sensors.TemperatureTwoPort senTemSup(
    redeclare package Medium = Media.Air,
    m_flow_nominal=m_flow_nominal,
    tau=20) annotation (Placement(transformation(extent={{-14,-70},{-34,-50}})));
  Modelica.Blocks.Sources.CombiTimeTable bondaryEta(
    tableOnFile=true,
    tableName="Boundary",
    columns={2,3,4},
    fileName=ModelicaServices.ExternalReferences.loadResource("modelica://AixLib/Resources/Fluid/MembraneBasedEnthalpyExchanger/StaticValidationEta.txt"),
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    timeScale=2)
    annotation (Placement(transformation(extent={{-144,56},{-124,76}})));
  Utilities.Psychrometrics.ToTotalAir toTotAirEta
    annotation (Placement(transformation(extent={{-104,32},{-88,48}})));
  Modelica.Blocks.Sources.CombiTimeTable bondaryOda(
    tableOnFile=true,
    tableName="Boundary",
    fileName=ModelicaServices.ExternalReferences.loadResource("modelica://AixLib/Resources/Fluid/MembraneBasedEnthalpyExchanger/StaticValidationOda.txt"),
    columns={2,3,4},
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    timeScale=2)
    annotation (Placement(transformation(extent={{160,-70},{140,-50}})));
  Utilities.Psychrometrics.ToTotalAir toTotAirOda
    annotation (Placement(transformation(extent={{104,-86},{88,-70}})));
  Modelica.Blocks.Sources.CombiTimeTable Results(
    tableOnFile=true,
    columns={2,3,4,5},
    tableName="Result",
    fileName=ModelicaServices.ExternalReferences.loadResource("modelica://AixLib/Resources/Fluid/MembraneBasedEnthalpyExchanger/StaticValidationResult.txt"),
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    timeScale=2)
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
  Modelica.Blocks.Interaction.Show.RealValue T_Sup_exp
    annotation (Placement(transformation(extent={{-14,86},{4,106}})));
  Modelica.Blocks.Interaction.Show.RealValue X_Sup_exp
    annotation (Placement(transformation(extent={{-14,74},{4,94}})));
  Modelica.Blocks.Interaction.Show.RealValue V_flow_exp
    annotation (Placement(transformation(extent={{26,80},{44,100}})));
  Modelica.Blocks.Math.Gain m3hEta(k=3600)
    annotation (Placement(transformation(extent={{-108,22},{-118,32}})));
  Modelica.Blocks.Math.Gain m3hOda(k=3600)
    annotation (Placement(transformation(extent={{88,-32},{98,-22}})));
  Utilities.Psychrometrics.ToDryAir toDryAirSup
    annotation (Placement(transformation(extent={{-56,-36},{-66,-26}})));
  Modelica.Blocks.Sources.RealExpression sensibleEfficiency(
    y=min(1,max(0,(senTemSup.T-senTemOda.T)/(senTemEta.T-senTemOda.T))))
    annotation (Placement(transformation(extent={{-138,-44},{-118,-24}})));
  Modelica.Blocks.Sources.RealExpression latentEfficiency(
    y=min(1,max(0,(senMasFraSup.X-senMasFraOda.X)/
      (senMasFraEta.X-senMasFraOda.X))))
    annotation (Placement(transformation(extent={{-138,-62},{-118,-42}})));
  Modelica.Blocks.Sources.RealExpression Permeability(
    y=A*abs(senMasFraEta.X-senMasFraOda.X)+B)
    annotation (Placement(transformation(extent={{-70,-22},{-50,-2}})));
  Movers.FlowControlled_dp fan(
    redeclare package Medium = Media.Air,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    m_flow_nominal=m_flow_nominal,
    addPowerToMedium=false,
    dp_start=120,
    dp_nominal=dp_nominal)
    annotation (Placement(transformation(extent={{62,-18},{42,2}})));
  Controls.Continuous.LimPID conPID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=10,
    Ti=120,
    yMax=160) annotation (Placement(transformation(extent={{96,12},{76,32}})));
  Movers.FlowControlled_dp fan1(
    redeclare package Medium = Media.Air,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    m_flow_nominal=m_flow_nominal,
    addPowerToMedium=false,
    dp_start=120,
    dp_nominal=dp_nominal)
    annotation (Placement(transformation(extent={{-62,28},{-42,8}})));
  Controls.Continuous.LimPID conPID1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=10,
    Ti=120,
    yMax=160)
    annotation (Placement(transformation(extent={{-108,10},{-88,-10}})));
equation
  connect(senMasFraEta.port_b,senTemEta. port_a)
    annotation (Line(points={{-32,60},{-28,60}}, color={0,127,255}));
  connect(souEta.ports[1], senMasFraEta.port_a)
    annotation (Line(points={{-56,60},{-52,60}}, color={0,127,255}));
  connect(senTemEta.port_b, senVolFloEta.port_a) annotation (Line(points={{-8,60},
          {-4,60},{-4,34},{-14,34}}, color={0,127,255}));
  connect(senTemEha.port_b,senMasFraEha. port_a)
    annotation (Line(points={{30,60},{36,60}}, color={0,127,255}));
  connect(enthalpyExchanger.port_b1, senTemEha.port_a) annotation (Line(points={
          {14,6.8},{18,6.8},{18,40},{4,40},{4,60},{10,60}}, color={0,127,255}));
  connect(senMasFraEha.port_b, sinEha.ports[1])
    annotation (Line(points={{56,60},{62,60}}, color={0,127,255}));
  connect(senMasFraOda.port_b,senTemOda. port_a)
    annotation (Line(points={{28,-60},{22,-60}}, color={0,127,255}));
  connect(souOda.ports[1], senMasFraOda.port_a)
    annotation (Line(points={{56,-60},{48,-60}}, color={0,127,255}));
  connect(senTemOda.port_b, senVolFloOda.port_a) annotation (Line(points={{2,-60},
          {0,-60},{0,-28},{18,-28}}, color={0,127,255}));
  connect(senTemSup.port_b,senMasFraSup. port_a)
    annotation (Line(points={{-34,-60},{-42,-60}}, color={0,127,255}));
  connect(senMasFraSup.port_b, sinSup.ports[1])
    annotation (Line(points={{-62,-60},{-68,-60}}, color={0,127,255}));
  connect(enthalpyExchanger.port_b2, senTemSup.port_a) annotation (Line(points={
          {-22,-8.8},{-30,-8.8},{-30,-28},{-8,-28},{-8,-60},{-14,-60}}, color={0,
          127,255}));
  connect(toTotAirEta.XiTotalAir, souEta.Xi_in[1]) annotation (Line(points={{-87.2,
          40},{-82,40},{-82,56},{-78,56}}, color={0,0,127}));
  connect(bondaryEta.y[2], toTotAirEta.XiDry) annotation (Line(points={{-123,66},
          {-110,66},{-110,40},{-104.8,40}}, color={0,0,127}));
  connect(bondaryOda.y[2], toTotAirOda.XiDry) annotation (Line(points={{139,-60},
          {120,-60},{120,-78},{104.8,-78}}, color={0,0,127}));
  connect(toTotAirOda.XiTotalAir, souOda.Xi_in[1]) annotation (Line(points={{87.2,
          -78},{82,-78},{82,-64},{78,-64}}, color={0,0,127}));
  connect(Results.y[3],V_flow_exp. numberPort)
    annotation (Line(points={{-39,90},{24.65,90}}, color={0,0,127}));
  connect(Results.y[1], T_Sup_exp.numberPort) annotation (Line(points={{-39,90},
          {-28,90},{-28,96},{-15.35,96}}, color={0,0,127}));
  connect(Results.y[2], X_Sup_exp.numberPort) annotation (Line(points={{-39,90},
          {-28,90},{-28,84},{-15.35,84}}, color={0,0,127}));
  connect(senVolFloEta.V_flow, m3hEta.u) annotation (Line(points={{-24,45},{-24,
          46},{-76,46},{-76,27},{-107,27}},color={0,0,127}));
  connect(senVolFloOda.V_flow, m3hOda.u) annotation (Line(points={{28,-39},{28,-42},
          {78,-42},{78,-27},{87,-27}}, color={0,0,127}));
  connect(senMasFraSup.X, toDryAirSup.XiTotalAir) annotation (Line(points={{-52,
          -49},{-52,-31},{-55.5,-31}}, color={0,0,127}));
  connect(Permeability.y, enthalpyExchanger.perMem) annotation (Line(points={{-49,-12},
          {-36,-12},{-36,-1},{-23.8,-1}},  color={0,0,127}));
  connect(fan.port_b, enthalpyExchanger.port_a2) annotation (Line(points={{42,-8},
          {28,-8},{28,-8.8},{14,-8.8}}, color={0,127,255}));
  connect(senVolFloOda.port_b, fan.port_a) annotation (Line(points={{38,-28},{74,
          -28},{74,-8},{62,-8}}, color={0,127,255}));
  connect(m3hOda.y, conPID.u_m) annotation (Line(points={{98.5,-27},{106,-27},{106,
          -2},{86,-2},{86,10}}, color={0,0,127}));
  connect(conPID.y, fan.dp_in)
    annotation (Line(points={{75,22},{52,22},{52,4}}, color={0,0,127}));
  connect(Results.y[3], conPID.u_s) annotation (Line(points={{-39,90},{-28,90},{
          -28,100},{114,100},{114,22},{98,22}}, color={0,0,127}));
  connect(fan1.port_b, enthalpyExchanger.port_a1) annotation (Line(points={{-42,
          18},{-34,18},{-34,6.8},{-22,6.8}}, color={0,127,255}));
  connect(senVolFloEta.port_b, fan1.port_a) annotation (Line(points={{-34,34},{-72,
          34},{-72,18},{-62,18}}, color={0,127,255}));
  connect(m3hEta.y, conPID1.u_m) annotation (Line(points={{-118.5,27},{-124,27},
          {-124,16},{-98,16},{-98,12}}, color={0,0,127}));
  connect(Results.y[3], conPID1.u_s) annotation (Line(points={{-39,90},{-28,90},
          {-28,100},{-160,100},{-160,0},{-110,0}}, color={0,0,127}));
  connect(conPID1.y, fan1.dp_in)
    annotation (Line(points={{-87,0},{-52,0},{-52,6}}, color={0,0,127}));
  connect(bondaryOda.y[1], souOda.T_in) annotation (Line(points={{139,-60},{110,
          -60},{110,-56},{78,-56}}, color={0,0,127}));
  connect(bondaryEta.y[1], souEta.T_in) annotation (Line(points={{-123,66},{
          -110,66},{-110,64},{-78,64}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(extent={{-160,-100},{160,100}})), Icon(
        coordinateSystem(extent={{-160,-100},{160,100}})),
    experiment(StopTime=29600, Interval=1, method="dassl",Tolerance=1E-6),
    __Dymola_Comands(file=
      "modelica://AixLib/Resources/Scripts/Dymola/Fluid/MassExchangers/MembraneBasedEnthalpyExchangers/Validation/StaticValidation.mos"
        "Simulate and plot"),
    Documentation(info="<html><p>
  This test case shows the comparison between static measurement
  results and the simulation results.
</p>
<p>
  Measurements were carried out on a membrane-based enthalpy exchanger
  used in domestic ventilation units by Zehnder Systems at the
  Institute for Energy Efficient Building and Indoor Climate, RWTH
  Aachen University.
</p>
</html>", revisions="<html>
<ul>
  <li>October 13, 2020, by Martin Kremer:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end StaticValidation;
