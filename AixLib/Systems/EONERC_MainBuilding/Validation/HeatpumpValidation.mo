within AixLib.Systems.EONERC_MainBuilding.Validation;
model HeatpumpValidation
  "Validation of heatpump model of E.ON ERC main building"
  extends Modelica.Icons.Example;
    package Medium = AixLib.Media.Water
    annotation (choicesAllMatching=true);

  parameter DataHPSystem Data;
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
    refIneFre_constant=0.1,
    scalingFactor=1,
    nthOrder=2,
    useBusConnectorOnly=true,
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
    use_refIne=true,
    transferHeat=true,
    allowFlowReversalEva=true,
    allowFlowReversalCon=true,
    tauHeaTraEva(displayUnit="h") = 43200,
    tauHeaTraCon(displayUnit="h") = 36000,
    TAmbCon_nominal=303.15,
    TAmbEva_nominal=303.15,
    TCon_start=303.15,
    TEva_start=298.15,
    massDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    redeclare model PerDataMainHP =
        DataBase.HeatPump.PerformanceData.LookUpTable2D (smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
          dataTable=AixLib.DataBase.HeatPump.EN255.Vitocal350AWI114(
            tableQdot_con=[0,12.5,15; 26.5,310000,318000; 44.2,251000,254000],
            tableP_ele=[0,12.5,15; 26.5,51000,51000; 44.2,51000,51000])),
    redeclare model PerDataRevHP =
        DataBase.Chiller.PerformanceData.LookUpTable2D (smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
          dataTable=AixLib.DataBase.Chiller.EN14511.Vitocal200AWO201(
            tableQdot_con=[0,12.5,15; 26.5,310000,318000; 44.2,251000,254000],
            tableP_ele=[0,12.5,15; 26.5,51000,51000; 44.2,51000,51000])))
                       annotation (Placement(transformation(
        extent={{-20,-24},{20,24}},
        rotation=90,
        origin={-8,2.5e-06})));

  Modelica.Blocks.Sources.Constant const(k=51)
    annotation (Placement(transformation(extent={{-80,-76},{-60,-56}})));
  Modelica.Blocks.Sources.Constant iceFac(final k=1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={50,-60})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(table=Data.October2015,
      smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments)
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={-100,32})));
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin1
                                                          annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={74,70})));
  AixLib.Controls.Interfaces.ThermalMachineControlBus
                           sigBusHP
    annotation (Placement(transformation(extent={{-16,-78},{16,-42}}),
        iconTransformation(extent={{6,-64},{24,-38}})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant
    annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
  Modelica.Blocks.Sources.Constant iceFac1(final k=0)
                                                     annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={56,-78})));
equation
  connect(boundary5.ports[1], heatPump.port_a1)
    annotation (Line(points={{-70,-20},{-20,-20}}, color={0,127,255}));
  connect(boundary3.ports[1], heatPump.port_a2)
    annotation (Line(points={{70,20},{4,20}}, color={0,127,255}));
  connect(toKelvin.Kelvin, boundary5.T_in)
    annotation (Line(points={{-100,25.4},{-100,-16},{-92,-16}},
                                                     color={0,0,127}));
  connect(toKelvin1.Kelvin, boundary3.T_in) annotation (Line(points={{80.6,70},{
          108,70},{108,16},{92,16}},                    color={0,0,127}));
  connect(sigBusHP, heatPump.sigBus) annotation (Line(
      points={{0,-60},{0,-37.5},{-0.2,-37.5},{-0.2,-19.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(const.y, division.u2)
    annotation (Line(points={{-59,-66},{-42,-66}},           color={0,0,127}));
  connect(heatPump.port_b1, boundary.ports[1])
    annotation (Line(points={{-20,20},{-70,20}}, color={0,127,255}));
  connect(heatPump.port_b2, boundary2.ports[1])
    annotation (Line(points={{4,-20},{70,-20}}, color={0,127,255}));
  connect(iceFac.y, sigBusHP.iceFac) annotation (Line(points={{39,-60},{29.25,-60},
          {29.25,-59.91},{0.08,-59.91}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(booleanConstant.y, sigBusHP.mode) annotation (Line(points={{1,-90},{12,
          -90},{12,-59.91},{0.08,-59.91}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(combiTimeTable.y[5], toKelvin.Celsius) annotation (Line(points={{-79,70},
          {-68,70},{-68,39.2},{-100,39.2}}, color={0,0,127}));
  connect(combiTimeTable.y[7], boundary5.m_flow_in) annotation (Line(points={{-79,
          70},{-68,70},{-68,38},{-92,38},{-92,-12}}, color={0,0,127}));
  connect(combiTimeTable.y[1], toKelvin1.Celsius)
    annotation (Line(points={{-79,70},{66.8,70}}, color={0,0,127}));
  connect(combiTimeTable.y[3], boundary3.m_flow_in) annotation (Line(points={{-79,
          70},{54,70},{54,48},{100,48},{100,12},{92,12}}, color={0,0,127}));
  connect(combiTimeTable.y[9], division.u1)
    annotation (Line(points={{-79,70},{-42,70},{-42,-54}}, color={0,0,127}));
  connect(division.y, sigBusHP.n) annotation (Line(points={{-19,-60},{-10,-60},
          {-10,-59.91},{0.08,-59.91}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (experiment(StopTime=23400),__Dymola_Commands(file(ensureSimulated=
           true)=
        "Resources/Scripts/Dymola/Systems/EONERC_MainBuilding/Validation/Simulate_and_plot_HeatpumpValidation.mos"
        "Simulate and plot"));
end HeatpumpValidation;
