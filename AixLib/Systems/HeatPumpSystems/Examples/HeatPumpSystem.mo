within AixLib.Systems.HeatPumpSystems.Examples;
model HeatPumpSystem "Example for a heat pump system"
  import AixLib;
  replaceable package Medium_sin = AixLib.Media.Water
    constrainedby Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);
  replaceable package Medium_sou = AixLib.Media.Water
    constrainedby Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);
  AixLib.Fluid.MixingVolumes.MixingVolume vol(
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    redeclare package Medium = Modelica.Media.Air.SimpleAir,
    V=40,
    m_flow_nominal=40*6/3600)
    annotation (Placement(transformation(extent={{86,34},{106,54}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor theCon(G=20000/40)
    "Thermal conductance with the ambient"
    annotation (Placement(transformation(extent={{38,54},{58,74}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHea
    "Prescribed heat flow"
    annotation (Placement(transformation(extent={{38,84},{58,104}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heaCap(C=2*40*1.2*1006)
    "Heat capacity for furniture and walls"
    annotation (Placement(transformation(extent={{78,64},{98,84}})));
  Modelica.Blocks.Sources.CombiTimeTable timTab(
      extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
      smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    table=[-6*3600,0; 8*3600,4000; 18*3600,0])
                          "Time table for internal heat gain"
    annotation (Placement(transformation(extent={{-2,84},{18,104}})));
  AixLib.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad(
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_a_nominal(displayUnit="degC") = 323.15,
    dp_nominal=0,
    m_flow_nominal=20000/4180/5,
    Q_flow_nominal=20000,
    redeclare package Medium = Medium_sin,
    T_start=293.15,
    T_b_nominal=318.15,
    TAir_nominal=293.15,
    TRad_nominal=293.15)         "Radiator"
    annotation (Placement(transformation(extent={{40,2},{20,22}})));

  AixLib.Fluid.Sources.FixedBoundary preSou(
    nPorts=2,
    redeclare package Medium = Medium_sin,
    T=313.15)
    "Source for pressure and to account for thermal expansion of water"
    annotation (Placement(transformation(extent={{-42,-34},{-22,-14}})));

  AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        Modelica.Utilities.Files.loadResource(
        "modelica://AixLib/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{-118,54},{-98,74}})));
  AixLib.BoundaryConditions.WeatherData.Bus weaBus "Weather data bus"
    annotation (Placement(transformation(extent={{-78,54},{-58,74}}),
        iconTransformation(extent={{-78,54},{-58,74}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature TOut
    "Outside temperature"
    annotation (Placement(transformation(extent={{-2,54},{18,74}})));
  AixLib.Fluid.Sources.FixedBoundary sou(
    use_T=true,
    nPorts=1,
    redeclare package Medium = Medium_sou,
    use_p=true,
    p=200000,
    T=285.15) "Fluid source on source side"
    annotation (Placement(transformation(extent={{102,-100},{82,-80}})));

  AixLib.Fluid.Sources.FixedBoundary sin(
    use_T=true,
    nPorts=1,
    redeclare package Medium = Medium_sou,
    p=200000,
    T=281.15) "Fluid sink on source side"
    annotation (Placement(transformation(extent={{-48,-100},{-28,-80}})));
  AixLib.Systems.HeatPumpSystems.HeatPumpSystem heatPumpSystem(
    redeclare package Medium_con = Medium_sin,
    redeclare package Medium_eva = Medium_sou,
    mFlow_conNominal=1,
    mFlow_evaNominal=1,
    perCon=AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4(),
    dataTable=AixLib.DataBase.HeatPump.EN255.Vitocal350BWH113(),
    use_deFro=false,
    massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    use_revHP=false,
    refIneFre_constant=0.01,
    VCon=0.04,
    VEva=0.04,
    dpEva_nominal=0,
    dpCon_nominal=0,
    deltaM_con=0.1,
    use_opeEnvFroRec=true,
    tableUpp=[-100,100; 100,100],
    tableLow=[-100,0; 100,0],
    minIceFac=0,
    use_chiller=true,
    calcPel_deFro=100,
    use_conCap=false,
    use_evaCap=false,
    CEva=0,
    GEva=0,
    CCon=0,
    GCon=0,
    perEva=AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos80slash1to12(),
    use_minRunTime=true,
    minRunTime(displayUnit="min"),
    use_minLocTime=true,
    minLocTime(displayUnit="min"),
    use_runPerHou=true,
    pre_n_start=false,
    use_antLeg=false,
    use_refIne=true,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    minTimeAntLeg(displayUnit="min") = 900,
    Q_flow_nominal=5,
    use_secHeaGen=false,
    redeclare model TSetToNSet = AixLib.Controls.HeatPump.BaseClasses.OnOffHP (
          hys=2),
    scalingFactor=1,
    TCon_start=313.15,
    TEva_start=283.15,
    redeclare model PerDataHea =
        AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.LookUpTable2D (
          smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments, dataTable=
           AixLib.DataBase.HeatPump.EN255.Vitocal350BWH113(tableP_ele=[0,-5.0,
            0.0,5.0,10.0,15.0; 35,3750,3750,3750,3750,3833; 45,4833,4917,4958,
            5042,5125; 55,5583,5667,5750,5833,5958; 65,7000,7125,7250,7417,7583])))
    annotation (Placement(transformation(extent={{8,-86},{62,-26}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort
                             senT_a1(
    redeclare final package Medium = Medium_sin,
    final m_flow_nominal=1,
    final transferHeat=true,
    final allowFlowReversal=true)
                                "Temperature at sink inlet" annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={88,-20})));
equation
  connect(theCon.port_b,vol. heatPort) annotation (Line(
      points={{58,64},{68,64},{68,44},{86,44}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(preHea.port,vol. heatPort) annotation (Line(
      points={{58,94},{68,94},{68,44},{86,44}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(heaCap.port,vol. heatPort) annotation (Line(
      points={{88,64},{68,64},{68,44},{86,44}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(timTab.y[1],preHea. Q_flow) annotation (Line(
      points={{19,94},{38,94}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(rad.heatPortCon,vol. heatPort) annotation (Line(
      points={{32,19.2},{32,44},{86,44}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(rad.heatPortRad,vol. heatPort) annotation (Line(
      points={{28,19.2},{28,44},{86,44}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(weaDat.weaBus,weaBus)  annotation (Line(
      points={{-98,64},{-68,64}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(weaBus.TDryBul,TOut. T) annotation (Line(
      points={{-68,64},{-4,64}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(TOut.port,theCon. port_a) annotation (Line(
      points={{18,64},{38,64}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(sou.ports[1], heatPumpSystem.port_a2)
    annotation (Line(points={{82,-90},{62,-90},{62,-77.4286}},
                                                          color={0,127,255}));
  connect(sin.ports[1], heatPumpSystem.port_b2) annotation (Line(points={{-28,-90},
          {14,-90},{14,-77.4286},{8,-77.4286}},
                                       color={0,127,255}));
  connect(rad.port_b, preSou.ports[1]) annotation (Line(points={{20,12},{-8,12},{-8,-22},
          {-22,-22}},          color={0,127,255}));
  connect(preSou.ports[2], heatPumpSystem.port_a1)
    annotation (Line(points={{-22,-26},{-14,-26},{-14,-51.7143},{8,-51.7143}},
                                                           color={0,127,255}));
  connect(weaBus.TDryBul, heatPumpSystem.T_oda) annotation (Line(
      points={{-68,64},{-58,64},{-58,-39.0714},{3.95,-39.0714}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(senT_a1.port_a, heatPumpSystem.port_b1) annotation (Line(points={{88,
          -30},{88,-51.7143},{62,-51.7143}}, color={0,127,255}));
  connect(senT_a1.port_b, rad.port_a) annotation (Line(points={{88,-10},{90,-10},
          {90,12},{40,12}}, color={0,127,255}));
  connect(senT_a1.T, heatPumpSystem.TAct) annotation (Line(points={{77,-20},{54,
          -20},{54,-16},{3.95,-16},{3.95,-30.0714}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,
            -120},{120,120}})),
    experiment(StopTime=3600),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
</html>
"), 
    Icon(coordinateSystem(extent={{-120,-120},{120,120}}), graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent={{-120,-120},{120,120}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points={{-38,64},{68,-2},{-38,-64},{-38,64}})}));
end HeatPumpSystem;
