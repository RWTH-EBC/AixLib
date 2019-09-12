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
    VEva=0.1,
    CEva=100,
    GEvaOut=5,
    CCon=100,
    GConOut=5,
    dpEva_nominal=42000,
    dpCon_nominal=44000,
    mFlow_conNominal=10,
    mFlow_evaNominal=10,
    VCon=0.176,
    use_conCap=false,
    use_evaCap=false,
    redeclare package Medium_con = Medium,
    redeclare package Medium_eva = Medium,
    use_revHP=true,
    redeclare model PerDataHea =
        Fluid.HeatPumps.BaseClasses.PerformanceData.LookUpTable2D (dataTable=
            AixLib.DataBase.HeatPump.EN14511.Vitocal200AWO201(tableQdot_con=[0,
            12.5,15; 26.5,291000,278000; 44.2,250000,254000], tableP_ele=[0,
            12.5,15; 26.5,51000,51000; 44.2,51000,51000])),
    redeclare model PerDataChi =
        Fluid.HeatPumps.BaseClasses.PerformanceData.LookUpTable2D (smoothness=
            Modelica.Blocks.Types.Smoothness.LinearSegments, dataTable=
            AixLib.DataBase.Chiller.EN14511.Vitocal200AWO201(tableQdot_con=[0,20,
            25,27,30,35; 7,203000,203000,203000,223000,203000; 18,203000,203000,
            203000,203000,203000], tableP_ele=[0,20,25,27,30,35; 7,51000,51000,51000,
            51000,51000; 18,51000,51000,51000,51000,51000])),
    use_refIne=false,
    TAmbCon_nominal=288.15,
    TAmbEva_nominal=273.15,
    TCon_start=303.15,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
                       annotation (Placement(transformation(
        extent={{-20,-24},{20,24}},
        rotation=90,
        origin={-8,2.5e-06})));

  Modelica.Blocks.Sources.Constant const(k=51)
    annotation (Placement(transformation(extent={{-78,-62},{-58,-42}})));
  Modelica.Blocks.Sources.Constant iceFac(final k=1) annotation (Placement(
        transformation(
        extent={{5,-5},{-5,5}},
        rotation=180,
        origin={25,-3})));
  Modelica.Blocks.Sources.Constant T_amb_internal(k=291.15)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-10,54})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(table=Data.August2016,
      smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments)
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-104,-16})));
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin1
                                                          annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={74,70})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold
    annotation (Placement(transformation(extent={{-46,-96},{-26,-76}})));
  Controls.Interfaces.HeatPumpControlBus
                           sigBusHP
    annotation (Placement(transformation(extent={{-6,-72},{24,-38}}),
        iconTransformation(extent={{6,-64},{24,-38}})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{-44,-54},{-24,-34}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant
    annotation (Placement(transformation(extent={{4,-88},{24,-68}})));
equation
  connect(boundary5.ports[1], heatPump.port_a1)
    annotation (Line(points={{-70,-20},{-20,-20}}, color={0,127,255}));
  connect(boundary3.ports[1], heatPump.port_a2)
    annotation (Line(points={{70,20},{4,20}}, color={0,127,255}));
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
  connect(combiTimeTable.y[13], boundary3.m_flow_in) annotation (Line(points={{
          -79,70},{24,70},{24,88},{102,88},{102,12},{92,12}}, color={0,0,127}));
  connect(toKelvin1.Kelvin, boundary3.T_in) annotation (Line(points={{80.6,70},
          {104,70},{104,66},{124,66},{124,16},{92,16}}, color={0,0,127}));
  connect(combiTimeTable.y[9], toKelvin1.Celsius)
    annotation (Line(points={{-79,70},{66.8,70}}, color={0,0,127}));
  connect(sigBusHP, heatPump.sigBusHP) annotation (Line(
      points={{9,-55},{9,-37.5},{-0.2,-37.5},{-0.2,-19.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(greaterThreshold.u, combiTimeTable.y[30]) annotation (Line(points={{-48,
          -86},{-138,-86},{-138,70},{-79,70}}, color={0,0,127}));
  connect(const.y, division.u2)
    annotation (Line(points={{-57,-52},{-46,-52},{-46,-50}}, color={0,0,127}));
  connect(combiTimeTable.y[29], division.u1) annotation (Line(points={{-79,70},{
          -64,70},{-64,-38},{-46,-38}}, color={0,0,127}));
  connect(division.y, heatPump.nSet) annotation (Line(points={{-23,-44},{-20,-44},
          {-20,-34},{-12,-34},{-12,-23.2}}, color={0,0,127}));
  connect(booleanConstant.y, heatPump.modeSet) annotation (Line(points={{25,-78},
          {-4,-78},{-4,-23.2}}, color={255,0,255}));
  connect(heatPump.port_b1, boundary.ports[1])
    annotation (Line(points={{-20,20},{-70,20}}, color={0,127,255}));
  connect(heatPump.port_b2, boundary2.ports[1])
    annotation (Line(points={{4,-20},{70,-20}}, color={0,127,255}));
  annotation (experiment(StopTime=9000), __Dymola_Commands(file="Resources/Scripts/Dymola/Systems/EONERC_MainBuilding/HeatPumpValidation/Simulate and plot.mos"));
end HeatpumpValidation;
