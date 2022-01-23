within ControlUnity.flowTemperatureController.renturnAdmixture;
model Admix_Control "Test for admix circuit"
  extends Modelica.Icons.Example;

  package Medium = AixLib.Media.Water
    annotation (choicesAllMatching=true);

  AixLib.Fluid.Sources.Boundary_pT   boundary(
    T=343.15,
    redeclare package Medium = Medium,
    nPorts=2) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-8,-50})));
  AixLib.Fluid.Sources.Boundary_pT   boundary1(
    T=323.15,
    redeclare package Medium = Medium,
    nPorts=2) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={28,-50})));

  Modelica.Blocks.Sources.Ramp valveOpening(              duration=500,
      startTime=180)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Admixture admixture[2](
    redeclare package Medium = Medium,
    k=2,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    Kv=10,
    each valveCharacteristic=AixLib.Fluid.Actuators.Valves.Data.LinearEqualPercentage(),
    m_flow_nominalCon=0.5,
    dp_nominalCon=5000,
    QNomCon=10000) annotation (Placement(transformation(
        extent={{-23,-23},{23,23}},
        rotation=90,
        origin={13,5})));




  AdmixtureBus admixtureBus[2] annotation (Placement(transformation(extent={{-60,-4},{-40,16}})));
  Modelica.Blocks.Sources.Ramp valveOpening1(duration=220, startTime=180)
    annotation (Placement(transformation(extent={{-100,38},{-80,58}})));
equation

  connect(admixtureBus, admixture.admixtureBus) annotation (Line(
      points={{-50,6},{-30,6},{-30,5},{-8.85,5}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boundary1.ports, admixture.port_b2) annotation (Line(points={{28,-40},{28,-30},{28,-18},
          {26.8,-18}}, color={0,127,255}));
  connect(boundary.ports, admixture.port_a1) annotation (Line(points={{-8,-40},{-4,-40},{-4,-24},
          {-0.8,-24},{-0.8,-18}}, color={0,127,255}));
  connect(valveOpening.y, admixtureBus[1].valveSet) annotation (Line(points={{
          -79,10},{-66,10},{-66,6.025},{-49.95,6.025}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(valveOpening1.y, admixtureBus[2].valveSet) annotation (Line(points={{
          -79,48},{-66,48},{-66,46},{-49.95,46},{-49.95,6.075}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(admixture.port_a2, admixture.port_b1) annotation (Line(points={{26.8,
          28},{26.8,58},{-0.8,58},{-0.8,28}}, color={0,127,255}));
  annotation (
    Icon(graphics,
         coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=800),
    Documentation(revisions="<html><ul>
  <li>October 25, 2017, by Alexander Kümpel:<br/>
    Transfer from ZUGABE to AixLib.
  </li>
</ul>
</html>"),
    __Dymola_Commands(file(ensureSimulated=true)=
        "Resources/Scripts/Dymola/Systems/HydraulicModules/Examples/Admix.mos"
        "Simulate and plot"));
end Admix_Control;
