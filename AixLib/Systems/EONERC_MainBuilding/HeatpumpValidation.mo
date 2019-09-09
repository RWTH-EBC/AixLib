within AixLib.Systems.EONERC_MainBuilding;
model HeatpumpValidation
  "Validation of heatpump model of E.ON ERC main building"
  extends Modelica.Icons.Example;
    package Medium = AixLib.Media.Water
    annotation (choicesAllMatching=true);

    DataHPSystem Data;
  Fluid.Sources.Boundary_pT          boundary(
    redeclare package Medium = Medium,
    T=303.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-80,20})));
  Fluid.Sources.MassFlowSource_T        boundary5(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    m_flow=1,
    use_T_in=true,
    T=300.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-80,-20})));
  Fluid.Sources.Boundary_pT          boundary2(
    redeclare package Medium = Medium,
    T=285.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={80,-20})));
  Fluid.Sources.MassFlowSource_T        boundary3(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    m_flow=4,
    use_T_in=true,
    T=291.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={80,20})));
  Fluid.HeatPumps.HeatPump        heatPump(
    refIneFre_constant=1,
    scalingFactor=1,
    VEva=0.04,
    CEva=100,
    GEvaOut=5,
    CCon=100,
    GConOut=5,
    dpEva_nominal=1000,
    dpCon_nominal=1000,
    mFlow_conNominal=0.5,
    mFlow_evaNominal=0.5,
    VCon=0.4,
    use_conCap=false,
    use_evaCap=false,
    redeclare package Medium_con = Medium,
    redeclare package Medium_eva = Medium,
    use_revHP=true,
    redeclare model PerDataHea =
        Fluid.HeatPumps.BaseClasses.PerformanceData.LookUpTable2D (dataTable=
            AixLib.DataBase.HeatPump.EN14511.Vitocal200AWO201()),
    redeclare model PerDataChi =
        Fluid.HeatPumps.BaseClasses.PerformanceData.LookUpTable2D (smoothness=
            Modelica.Blocks.Types.Smoothness.LinearSegments, dataTable=
            AixLib.DataBase.Chiller.EN14511.Vitocal200AWO201()),
    use_refIne=false,
    TAmbCon_nominal=288.15,
    TAmbEva_nominal=273.15,
    TCon_start=303.15,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
                       annotation (Placement(transformation(
        extent={{-20,-24},{20,24}},
        rotation=90,
        origin={-8,2.5e-06})));
  Modelica.Blocks.Sources.Constant const(k=0.1)
    annotation (Placement(transformation(extent={{-42,-60},{-22,-40}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant
    annotation (Placement(transformation(extent={{2,-62},{22,-42}})));
  Modelica.Blocks.Sources.Constant iceFac(final k=1) annotation (Placement(
        transformation(
        extent={{5,-5},{-5,5}},
        rotation=180,
        origin={25,-3})));
  Modelica.Blocks.Sources.Constant T_amb_internal(k=291.15)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-10,54})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(table=Data.August2016)
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-104,-16})));
  Fluid.Sensors.TemperatureTwoPort senT_HP_h_out(redeclare package Medium =
        Medium, m_flow_nominal=10)
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  Fluid.Sensors.TemperatureTwoPort senT_HP_c_out(redeclare package Medium =
        Medium, m_flow_nominal=10)
    annotation (Placement(transformation(extent={{36,-30},{56,-10}})));
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin1
                                                          annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={74,70})));
equation
  connect(boundary5.ports[1], heatPump.port_a1)
    annotation (Line(points={{-70,-20},{-20,-20}}, color={0,127,255}));
  connect(boundary3.ports[1], heatPump.port_a2)
    annotation (Line(points={{70,20},{4,20}}, color={0,127,255}));
  connect(const.y, heatPump.nSet) annotation (Line(points={{-21,-50},{-16,-50},
          {-16,-23.2},{-12,-23.2}}, color={0,0,127}));
  connect(booleanConstant.y, heatPump.modeSet) annotation (Line(points={{23,-52},
          {14,-52},{14,-30},{-4,-30},{-4,-23.2}}, color={255,0,255}));
  connect(iceFac.y, heatPump.iceFac_in) annotation (Line(points={{30.5,-3},{49,
          -3},{49,-15.2},{19.2,-15.2}},          color={0,0,127}));
  connect(T_amb_internal.y, heatPump.T_amb_con) annotation (Line(points={{-10,65},
          {-8,65},{-8,22},{-28,22}},            color={0,0,127}));
  connect(T_amb_internal.y, heatPump.T_amb_eva) annotation (Line(points={{-10,65},
          {-10,22},{12,22}},           color={0,0,127}));
  connect(boundary5.m_flow_in, combiTimeTable.y[14]) annotation (Line(points={{-92,
          -12},{-96,-12},{-96,54},{-62,54},{-62,70},{-79,70}}, color={0,0,127}));
  connect(toKelvin.Kelvin, boundary5.T_in)
    annotation (Line(points={{-97.4,-16},{-92,-16}}, color={0,0,127}));
  connect(toKelvin.Celsius, combiTimeTable.y[12]) annotation (Line(points={{-111.2,
          -16},{-111.2,40},{-60,40},{-60,70},{-79,70}}, color={0,0,127}));
  connect(boundary.ports[1], senT_HP_h_out.port_a)
    annotation (Line(points={{-70,20},{-60,20}}, color={0,127,255}));
  connect(senT_HP_h_out.port_b, heatPump.port_b1)
    annotation (Line(points={{-40,20},{-20,20}}, color={0,127,255}));
  connect(boundary2.ports[1], senT_HP_c_out.port_b)
    annotation (Line(points={{70,-20},{56,-20}}, color={0,127,255}));
  connect(senT_HP_c_out.port_a, heatPump.port_b2)
    annotation (Line(points={{36,-20},{4,-20}}, color={0,127,255}));
  connect(combiTimeTable.y[13], boundary3.m_flow_in) annotation (Line(points={{
          -79,70},{24,70},{24,88},{102,88},{102,12},{92,12}}, color={0,0,127}));
  connect(toKelvin1.Kelvin, boundary3.T_in) annotation (Line(points={{80.6,70},
          {104,70},{104,66},{124,66},{124,16},{92,16}}, color={0,0,127}));
  connect(combiTimeTable.y[9], toKelvin1.Celsius)
    annotation (Line(points={{-79,70},{66.8,70}}, color={0,0,127}));
  annotation (experiment(StopTime=9000));
end HeatpumpValidation;
