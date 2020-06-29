within AixLib.Systems.EONERC_MainBuilding_old.Examples;
model SwitchingUnit "Test of switchingUnit model of E.ON ERC main building"
  extends Modelica.Icons.Example;
    package Medium = AixLib.Media.Water
    annotation (choicesAllMatching=true);

  AixLib.Systems.EONERC_MainBuilding_old.SwitchingUnit switchingUnit(redeclare
      package Medium = Medium, m_flow_nominal=2)
    annotation (Placement(transformation(extent={{-30,-46},{30,26}})));
  Fluid.Sources.Boundary_pT          boundary(
    redeclare package Medium = Medium,
    p=boundary1.p + 5000,
    T=292.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-80,20})));
  Fluid.Sources.Boundary_pT          boundary1(
    redeclare package Medium = Medium,
    T=303.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-80,-16})));
  Fluid.Sources.Boundary_pT          boundary2(
    redeclare package Medium = Medium,
    T=280.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={80,20})));
  Fluid.Sources.Boundary_pT          boundary3(
    redeclare package Medium = Medium,
    p=boundary2.p + 5000,
    T=280.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={80,-16})));
  Controller.CtrSWU sWUController
    annotation (Placement(transformation(extent={{-32,58},{-8,82}})));
  Modelica.Blocks.Sources.IntegerConstant integerConstant(k=1)
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = Medium,
    m_flow_nominal=4,
    V=0.1,
    nPorts=2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,-74})));
equation
  connect(boundary.ports[1], switchingUnit.port_a1)
    annotation (Line(points={{-70,20},{-30,20}}, color={0,127,255}));
  connect(boundary1.ports[1], switchingUnit.port_b2)
    annotation (Line(points={{-70,-16},{-30,-16}}, color={0,127,255}));
  connect(boundary2.ports[1], switchingUnit.port_b1)
    annotation (Line(points={{70,20},{30,20}}, color={0,127,255}));
  connect(boundary3.ports[1], switchingUnit.port_a2)
    annotation (Line(points={{70,-16},{30,-16}}, color={0,127,255}));
  connect(switchingUnit.sWUBus, sWUController.sWUBus) annotation (Line(
      points={{-0.3,26.6},{0,26.6},{0,70},{-8,70}},
      color={255,204,51},
      thickness=0.5));
  connect(sWUController.mode, integerConstant.y)
    annotation (Line(points={{-32,70},{-59,70}}, color={255,127,0}));
  connect(switchingUnit.port_b3, vol.ports[1]) annotation (Line(points={{-12,-46},
          {-8,-46},{-8,-64},{2,-64}}, color={0,127,255}));
  connect(vol.ports[2], switchingUnit.port_a3) annotation (Line(points={{-2,-64},
          {6,-64},{6,-46},{12,-46}}, color={0,127,255}));
  annotation (experiment(StopTime=23400),__Dymola_Commands(file(ensureSimulated=
           true)=
        "Resources/Scripts/Dymola/Systems/EONERC_MainBuilding/Validation/Simulate_and_plot_HeatpumpValidation.mos"
        "Simulate and plot"));
end SwitchingUnit;
