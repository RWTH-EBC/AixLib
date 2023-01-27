within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler.Example;
model ModularBoiler_with_Consumers

  extends Modelica.Icons.Example;

  package MediumWater = AixLib.Media.Water;
  parameter Integer k(min=1)=2 "Number of heat curcuits";

  ModularBoiler_multiport
    modularBoiler_HierarchicalRegulation_wPump_wFeedback_wAdmix_(
    dTWaterNom=20,
    TColdNom=308.15,
    QNom=100000,
    m_flowVar=true,
    Pump=true,
    Advanced=false,
    k=k,
    hasFeedback=false,
    dp_Valve(displayUnit="Pa") = 10,
    dpFixed_nominal(displayUnit="Pa") = {10,10},
    use_advancedControl=true,
    use_flowTControl=true,
    simpleTwoPosition=true,
    TVar=false,
    manualTimeDelay=false,
    n_layers=1,
    declination=1,
    TMax=348.15,
    redeclare package Medium = MediumWater)
    annotation (Placement(transformation(extent={{-28,-30},{36,30}})));
  Fluid.Sources.Boundary_pT bou(
    use_T_in=false,
    redeclare package Medium = MediumWater,
    T(displayUnit="degC") = 288.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{-90,-28},{-66,-4}})));
  Interfaces.BoilerControlBus boilerControlBus
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  Modelica.Blocks.Sources.Sine BouT_sine(
    amplitude=1,
    freqHz=1/600,
    offset=303.15)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-126,-12})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
    annotation (Placement(transformation(extent={{-9,-8},{9,8}},
        rotation=180,
        origin={49,78})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression2(y=true)
    annotation (Placement(transformation(extent={{-13,-10},{13,10}},
        rotation=180,
        origin={53,60})));

  ModularConsumer.ModularConsumer_multiport modularConsumer_multiport(
      n_consumers=k, functionality="Q_flow_fixed",
    Q_flow_fixed={1000,1000})
    annotation (Placement(transformation(extent={{62,-10},{82,10}})));
  Modelica.Blocks.Sources.Constant TCon1(k=343.15) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-82,54})));
  Modelica.Blocks.Sources.Constant TCon2(k=323.15) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-82,20})));
  Modelica.Blocks.Sources.Constant TCon3(k=313.15) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-2,-78})));
  Modelica.Blocks.Sources.Sine      sine(
    amplitude=5,
    freqHz=1/86400,
    phase=-1.5707963267949,
    offset=293.15)
            "PI Controller for controlling the valve position"
            annotation (Placement(transformation(extent={{-154,68},{-134,88}})));
  Modelica.Blocks.Sources.Constant PLR_const(k=0.75)
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-72,94})));
  Modelica.Blocks.Sources.Constant dT_const(k=35)
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-34,60})));
equation
  connect(bou.ports[1],
    modularBoiler_HierarchicalRegulation_wPump_wFeedback_wAdmix_.port_a)
    annotation (Line(points={{-66,-17.2},{-40,-17.2},{-40,0},{-28,0}},
                                                                 color={0,127,255}));
  connect(boilerControlBus,
    modularBoiler_HierarchicalRegulation_wPump_wFeedback_wAdmix_.boilerControlBus)
    annotation (Line(
      points={{0,60},{0,30},{4,30}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanExpression.y, boilerControlBus.isOn)
    annotation (Line(points={{39.1,78},{20,78},{20,60},{0,60},{0,60.05},{0.05,60.05}},
                                                     color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanExpression2.y, boilerControlBus.internControl)
    annotation (
      Line(points={{38.7,60},{0,60}},                               color={255,0,
          255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

  connect(BouT_sine.y, bou.T_in) annotation (Line(points={{-115,-12},{-116,-12},
          {-116,-11.2},{-92.4,-11.2}},
                                  color={0,0,127}));
  connect(modularBoiler_HierarchicalRegulation_wPump_wFeedback_wAdmix_.ports_b,
    modularConsumer_multiport.ports_a)
    annotation (Line(points={{36,0},{62,0}}, color={0,127,255}));
  connect(modularConsumer_multiport.port_b, bou.ports[2]) annotation (Line(
        points={{82,0},{88,0},{88,-40},{-60,-40},{-60,-14.8},{-66,-14.8}},
        color={0,127,255}));
  connect(TCon1.y, modularBoiler_HierarchicalRegulation_wPump_wFeedback_wAdmix_.TCon[
    1]) annotation (Line(points={{-71,54},{-44,54},{-44,10},{-38,10},{-38,11.1},
          {-28,11.1}}, color={0,0,127}));
  connect(TCon2.y, modularBoiler_HierarchicalRegulation_wPump_wFeedback_wAdmix_.TCon[
    2]) annotation (Line(points={{-71,20},{-52,20},{-52,12},{-28,12},{-28,12.9}},
        color={0,0,127}));
  connect(TCon1.y, modularConsumer_multiport.T_Flow[1]) annotation (Line(points={{-71,54},
          {-44,54},{-44,-32},{50,-32},{50,-6.5},{62,-6.5}},      color={0,0,127}));
  connect(TCon2.y, modularConsumer_multiport.T_Flow[2]) annotation (Line(points={{-71,20},
          {-52,20},{-52,-32},{50,-32},{50,-5.5},{62,-5.5}},      color={0,0,127}));
  connect(TCon3.y, modularConsumer_multiport.T_Return[1]) annotation (Line(
        points={{9,-78},{58,-78},{58,-9.5},{62,-9.5}},
                                                     color={0,0,127}));
  connect(TCon3.y, modularConsumer_multiport.T_Return[2]) annotation (Line(
        points={{9,-78},{58,-78},{58,-8.5},{62,-8.5}},
                                                   color={0,0,127}));
  connect(sine.y, boilerControlBus.Tamb) annotation (Line(points={{-133,78},{
          -64,78},{-64,80},{0,80},{0,60}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(dT_const.y, boilerControlBus.DeltaTWater) annotation (Line(points={{
          -23,60},{-12,60},{-12,60.05},{0.05,60.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
annotation (
    experiment(
      StopTime=3600,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end ModularBoiler_with_Consumers;
