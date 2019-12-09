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
        origin={40,40})));
  Fluid.Sources.Boundary_pT          boundary1(
    redeclare package Medium = Medium, nPorts=1)
              annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-20,38})));
  Modelica.Blocks.Sources.BooleanPulse    booleanPulse(period=3600*24*360)
    annotation (Placement(transformation(extent={{-78,-24},{-58,-4}})));
  AixLib.Systems.EONERC_MainBuilding.GeothermalFieldSimple gtf(
    redeclare package Medium = Medium,
    m_flow_nominal=10,
    T_amb=293.15,
    V=8000,
    G=10000) annotation (Placement(transformation(extent={{16,-42},{-8,-10}})));
  Controller.CtrGTFSimple ctrGTFSimple
    annotation (Placement(transformation(extent={{-48,-24},{-28,-4}})));
equation
  connect(ctrGTFSimple.busPump, gtf.busPump) annotation (Line(
      points={{-27.7,-18.4},{-13.85,-18.4},{-13.85,-22.2},{-7.9,-22.2}},
      color={255,204,51},
      thickness=0.5));
  connect(ctrGTFSimple.busThrottle, gtf.busThrottle) annotation (Line(
      points={{-27.9,-9.6},{-14.95,-9.6},{-14.95,-14.6},{-7.9,-14.6}},
      color={255,204,51},
      thickness=0.5));
  connect(ctrGTFSimple.on, booleanPulse.y)
    annotation (Line(points={{-48,-14},{-57,-14}}, color={255,0,255}));
  connect(gtf.port_b, boundary1.ports[1]) annotation (Line(points={{-6,-10},{
          -10,-10},{-10,28},{-20,28}}, color={0,127,255}));
  connect(gtf.port_a, boundary.ports[1]) annotation (Line(points={{14,-10},{30,
          -10},{30,30},{40,30}}, color={0,127,255}));
  annotation (experiment(StopTime=31536000),
                                         __Dymola_Commands(file(ensureSimulated=
           true)=
        "Resources/Scripts/Dymola/Systems/EONERC_MainBuilding/Validation/Simulate_and_plot_HeatpumpValidation.mos"
        "Simulate and plot"));
end GeothermalFieldSimple;
