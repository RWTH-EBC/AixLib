within AixLib.Systems.EONERC_MainBuilding.Examples;
model GeothermalFieldSimple
  "Test of geothermal field model of E.ON ERC main building"
  extends Modelica.Icons.Example;
    package Medium = AixLib.Media.Water
    annotation (choicesAllMatching=true);

  Fluid.Sources.Boundary_pT          boundary(
    redeclare package Medium = Medium,
    p=boundary1.p + 5000,
    T=292.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-20,40})));
  Fluid.Sources.Boundary_pT          boundary1(
    redeclare package Medium = Medium, nPorts=1)
              annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={22,40})));
  Modelica.Blocks.Sources.BooleanPulse    booleanPulse(period=3600*24*360)
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  AixLib.Systems.EONERC_MainBuilding.GeothermalFieldSimple gtf(
    redeclare package Medium = Medium,
    m_flow_nominal=10,
    T_amb=293.15)
             annotation (Placement(transformation(extent={{-20,-58},{20,-2}})));
  Controller.CtrGTFSimple ctrGTFSimple
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
equation
  connect(ctrGTFSimple.on, booleanPulse.y)
    annotation (Line(points={{-61,-30.2},{-70,-30.2},{-70,-30},{-79,-30}},
                                                   color={255,0,255}));
  connect(gtf.port_b, boundary1.ports[1]) annotation (Line(points={{16.6667,-2},
          {16.6667,30},{22,30}},       color={0,127,255}));
  connect(gtf.port_a, boundary.ports[1]) annotation (Line(points={{-16.6667,-2},
          {-16.6667,30},{-20,30}},
                                 color={0,127,255}));
  connect(ctrGTFSimple.gtfBus, gtf.twoCircuitBus) annotation (Line(
      points={{-38.7,-30},{-30,-30},{-30,-19.675},{-20.1667,-19.675}},
      color={255,204,51},
      thickness=0.5));
  annotation (experiment(StopTime=31536000),
                                         __Dymola_Commands(file(ensureSimulated=
           true)=
        "Resources/Scripts/Dymola/Systems/EONERC_MainBuilding/Validation/Simulate_and_plot_HeatpumpValidation.mos"
        "Simulate and plot"));
end GeothermalFieldSimple;
