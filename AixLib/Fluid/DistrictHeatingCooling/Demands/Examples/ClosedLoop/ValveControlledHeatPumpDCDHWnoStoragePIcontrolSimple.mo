within AixLib.Fluid.DistrictHeatingCooling.Demands.Examples.ClosedLoop;
model ValveControlledHeatPumpDCDHWnoStoragePIcontrolSimple
  import AixLib;
  extends Modelica.Icons.Example;

  package Medium = AixLib.Media.Specialized.Water.ConstantProperties_pT (
    T_nominal=284.28999999999996,
    p_nominal=100000.0,
    T_default=284.28999999999996);
  package MediumBuilding = AixLib.Media.Specialized.Water.ConstantProperties_pT
      (
    T_nominal=303.15,
    p_nominal=300000.0,
    T_default=303.15);

  Modelica.Blocks.Sources.TimeTable cold_demand(table=[0,0; 3600,0; 3600,0;
        7200,0; 7200,0; 10800,1000; 14400,10000; 18000,0; 18000,0; 24000,0;
        24000,0])
            annotation (Placement(transformation(extent={{98,-40},{78,-20}})));
  Modelica.Blocks.Sources.TimeTable dhw_demand(table=[0,0; 24000,0; 24000,5000;
        24350,5000; 24350,0; 45600,0; 45600,5000; 45950,5000; 45950,0; 63600,0])
    annotation (Placement(transformation(extent={{98,0},{78,20}})));

  Modelica.Blocks.Sources.TimeTable heat_demand(table=[0,13000; 3600,10000;
        3600,10000; 7200,5000; 7200,5000; 10800,0; 14400,0; 18000,0; 18000,0;
        21600,0; 21600,0; 31200,0; 31200,0; 42000,9000; 42000,9000])
    annotation (Placement(transformation(extent={{98,40},{78,60}})));
  AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop.ValveControlledHeatPumpDirectCoolingDHWnoStoragePIcontrolSimple
    House_PIsimple(
    redeclare package Medium = Medium,
    redeclare package MediumBuilding = MediumBuilding,
    heatDemand_max=13000,
    coldDemand_max=-10000,
    dp_nominal=50000,
    dT_Network=10,
    T_dhw_supply=65) "Valve controlls return temp to +- 10K with PI controller"
    annotation (Placement(transformation(
        extent={{-15,10},{15,-10}},
        rotation=180,
        origin={15,-30})));
  AixLib.Fluid.FixedResistances.PlugFlowPipe
                                pipeSupply(
    nPorts=1,
    redeclare package Medium = Medium,
    dh=0.05,
    length=50,
    m_flow_nominal=1,
    dIns=0.03,
    kIns=0.027) "Supply pipe" annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={50,30})));
  AixLib.Fluid.FixedResistances.PlugFlowPipe
                                pipeReturn(
    redeclare package Medium = Medium,
    dh=0.05,
    length=50,
    m_flow_nominal=1,
    dIns=0.03,
    kIns=0.027,
    nPorts=1)   "Return pipe" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-32,6})));
  Modelica.Blocks.Sources.Constant TSet(k=20 + 273.15)
                                                      "Set supply temperature"
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-70,70})));
  Modelica.Blocks.Sources.Constant dpSet(k=5e4)
    "Set pressure difference for substation" annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-70,40})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature TGround
    "Ground temperature" annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-70,-10})));
  Modelica.Blocks.Sources.Constant TGroundSet(k=10 + 273.15)
    "Set ground temperature" annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-70,-48})));
  Modelica.Blocks.Continuous.LimPID pControl(controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMax=6e5) "Pressure controller" annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-10,40})));
  AixLib.Fluid.DistrictHeatingCooling.Supplies.OpenLoop.SourceIdeal
                                sourceIdeal(
    redeclare package Medium = Medium,
    TReturn=273.15 + 20,
    pReturn=200000)      "Simple suppy model"
    annotation (Placement(transformation(extent={{20,50},{40,70}})));
equation
  connect(pipeSupply.ports_b[1], House_PIsimple.port_a) annotation (Line(points
        ={{50,20},{50,-26.3158},{30,-26.3158}}, color={0,127,255}));
  connect(House_PIsimple.port_b, pipeReturn.port_a) annotation (Line(points={{
          -0.103448,-26.3158},{-32,-26.3158},{-32,-4}}, color={0,127,255}));
  connect(TGroundSet.y,TGround. T)
    annotation (Line(points={{-81,-48},{-86,-48},{-86,-10},{-82,-10}},
                                                   color={0,0,127}));
  connect(TGround.port,pipeReturn. heatPort)
    annotation (Line(points={{-60,-10},{-54,-10},{-54,6},{-42,6}},
                                                         color={191,0,0}));
  connect(TGround.port,pipeSupply. heatPort) annotation (Line(points={{-60,-10},
          {14,-10},{14,30},{40,30}},         color={191,0,0}));
  connect(dpSet.y,pControl. u_s)
    annotation (Line(points={{-59,40},{-22,40}},color={0,0,127}));
  connect(House_PIsimple.dpOut, pControl.u_m) annotation (Line(points={{
          -0.517241,-23.1579},{-10,-23.1579},{-10,28}}, color={0,0,127}));
  connect(heat_demand.y, House_PIsimple.heat_input) annotation (Line(points={{
          77,50},{66,50},{66,-20},{31.0345,-20}}, color={0,0,127}));
  connect(dhw_demand.y, House_PIsimple.dhw_input) annotation (Line(points={{77,
          10},{68,10},{68,-24.5263},{31.0345,-24.5263}}, color={0,0,127}));
  connect(cold_demand.y, House_PIsimple.cold_input) annotation (Line(points={{
          77,-30},{72,-30},{72,-22.1053},{31.0345,-22.1053}}, color={0,0,127}));
  connect(pipeReturn.ports_b[1], sourceIdeal.port_a)
    annotation (Line(points={{-32,16},{-32,60},{20,60}}, color={0,127,255}));
  connect(pControl.y, sourceIdeal.dpIn) annotation (Line(points={{1,40},{10,40},
          {10,53},{19.4,53}}, color={0,0,127}));
  connect(TSet.y, sourceIdeal.TIn) annotation (Line(points={{-59,70},{-10,70},{
          -10,67},{19.4,67}}, color={0,0,127}));
  connect(sourceIdeal.port_b, pipeSupply.port_a)
    annotation (Line(points={{40,60},{50,60},{50,40}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    experiment(
      StopTime=86400,
      Interval=60,
      Tolerance=1e-007));
end ValveControlledHeatPumpDCDHWnoStoragePIcontrolSimple;
