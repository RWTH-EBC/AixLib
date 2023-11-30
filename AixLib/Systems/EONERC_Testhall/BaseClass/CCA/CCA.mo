within AixLib.Systems.EONERC_Testhall.BaseClass.CCA;
model CCA

  HydraulicModules.Injection2WayValve                       cca(
    redeclare package Medium = AixLib.Media.Water,
    pipeModel="SimplePipe",
    length=1,
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_54x1(),
    Kv=2.34,
    m_flow_nominal=0.8,
    redeclare
      AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_PumpSpeedControlled
      PumpInterface(pumpParam=
          AixLib.DataBase.Pumps.PumpPolynomialBased.Pump_DN50_H1_10()),
    pipe1(length=0.3),
    pipe2(length=0.2),
    pipe3(length=10, fac=10),
    pipe4(length=10),
    pipe6(length=0.2),
    pipe5(length=0.5),
    T_amb=273.15 + 10,
    T_start=323.15,
    pipe7(length=0.2))
                    annotation (Placement(transformation(
        extent={{-36,-36},{35.9999,35.9999}},
        rotation=90,
        origin={-12,-26})));

  ConcreteCoreActivation concreteCoreActivation(
    redeclare package Medium = AixLib.Media.Water,
    nNodes=6,
    C=200,
    Gc=41e6,
    pipe(
      parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1(),
      length=30,
      m_flow_nominal=1.79,
      T_start=323.15))
    annotation (Placement(transformation(extent={{-42,32},{14,86}})));
  Modelica.Fluid.Interfaces.FluidPort_a cca_supprim(redeclare package Medium =
        AixLib.Media.Water) annotation (Placement(transformation(extent={{-44,-110},
            {-24,-90}}), iconTransformation(extent={{-44,-110},{-24,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b cca_retprim(redeclare package Medium =
        AixLib.Media.Water) annotation (Placement(transformation(extent={{0,-110},
            {20,-90}}), iconTransformation(extent={{30,-110},{50,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heat_port_CCA
    annotation (Placement(transformation(extent={{-24,94},{-4,114}}),
        iconTransformation(extent={{-10,94},{10,114}})));
  DistributeBus dB_CCA annotation (Placement(transformation(extent={{-104,-42},
            {-78,-10}}), iconTransformation(extent={{-122,-24},{-82,16}})));
equation
  connect(dB_CCA.bus_cca, cca.hydraulicBus) annotation (Line(
      points={{-90.935,-25.92},{-69.4999,-25.92},{-69.4999,-26},{-47.9999,-26}},
      color={255,204,51},
      thickness=0.5));
  connect(cca_supprim, cca.port_a1) annotation (Line(points={{-34,-100},{-34,
          -81},{-33.5999,-81},{-33.5999,-62}},
                                color={0,127,255}));
  connect(cca_retprim, cca.port_b2) annotation (Line(points={{10,-100},{10,-81},
          {9.60002,-81},{9.60002,-62}},
                          color={0,127,255}));
  connect(cca.port_a2, concreteCoreActivation.port_ret) annotation (Line(points={{9.60002,
          9.9999},{8,9.9999},{8,28},{22,28},{22,59},{14,59}},            color={
          0,127,255}));
  connect(concreteCoreActivation.heatPort, heat_port_CCA) annotation (Line(
        points={{-14,88.7},{-14,104}},                         color={191,0,0}));
  connect(cca.port_b1, concreteCoreActivation.port_sup) annotation (Line(points
        ={{-33.5999,9.9999},{-32,9.9999},{-32,28},{-50,28},{-50,59},{-42,59}},
        color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={212,212,212},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{2,81},{-18,77},{-38,71},{-50,57},{-56,49},{-66,39},{-70,27},
              {-74,13},{-76,-1},{-74,-17},{-74,-29},{-74,-39},{-68,-51},{-62,
              -59},{-46,-63},{-28,-69},{-16,-69},{0,-71},{10,-75},{24,-75},{34,
              -73},{44,-67},{56,-61},{58,-59},{68,-47},{70,-39},{72,-37},{74,
              -21},{78,-7},{80,1},{80,17},{76,29},{68,39},{56,47},{46,55},{38,
              71},{28,79},{2,81}},
          lineColor={255,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-56,49},{-66,39},{-70,27},{-74,13},{-76,-1},{-74,-17},{-74,
              -29},{-74,-39},{-68,-51},{-62,-59},{-46,-63},{-28,-69},{-16,-69},
              {0,-71},{10,-75},{24,-75},{34,-73},{44,-67},{56,-61},{44,-63},{42,
              -63},{32,-65},{22,-67},{20,-67},{12,-67},{4,-63},{-10,-59},{-20,
              -59},{-28,-57},{-38,-51},{-48,-41},{-54,-29},{-56,-21},{-56,-11},
              {-58,1},{-58,9},{-58,21},{-56,31},{-54,33},{-50,41},{-46,49},{-42,
              59},{-38,71},{-56,49}},
          lineColor={255,0,0},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-67,21},{73,-10}},
          lineColor={0,0,0},
          textString="%CCA")}),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=100, __Dymola_Algorithm="Dassl"));
end CCA;
