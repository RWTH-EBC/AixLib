within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler.Example;
model ModularBoiler_HierachicalRegulation_wPump_wFeedback_wAdmix
  extends Modelica.Icons.Example;

  package MediumWater = AixLib.Media.Water;
  parameter Integer k(min=1)=modularBoiler_HierarchicalRegulation_wPump_wFeedback_wAdmix_.k "Number of heat curcuits"
   annotation(Dialog(group="Admixture control"));

  ModularBoiler_multiport
    modularBoiler_HierarchicalRegulation_wPump_wFeedback_wAdmix_(
    dTWaterNom=20,
    TColdNom=308.15,
    QNom=100000,
    m_flowVar=true,
    Pump=true,
    Advanced=false,
    k=2,
    hasFeedback=false,
    dp_Valve(displayUnit="Pa") = 10,
    dpFixed_nominal(displayUnit="Pa") = {10,10},
    use_advancedControl=true,
    use_flowTControl=false,
    simpleTwoPosition=false,
    TVar=false,
    manualTimeDelay=false,
    declination=1,
    TMax=348.15,
    redeclare package Medium = MediumWater)
    annotation (Placement(transformation(extent={{-32,-30},{32,30}})));
  Fluid.Sources.Boundary_pT bou(
    use_T_in=false,
    redeclare package Medium = MediumWater,
    T(displayUnit="degC") = 288.15,
    nPorts=k+1)
    annotation (Placement(transformation(extent={{-108,-28},{-84,-4}})));
  Modelica.Blocks.Sources.Constant PLR_const(k=0.75)
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-50,80})));
  Interfaces.BoilerControlBus boilerControlBus
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  Modelica.Blocks.Sources.Constant dT_const(k=35)
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-50,48})));
  Modelica.Blocks.Sources.Constant TCon1_const(k=323.15)
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-92,80})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
    annotation (Placement(transformation(extent={{-9,-8},{9,8}},
        rotation=180,
        origin={49,78})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression2(y=true)
    annotation (Placement(transformation(extent={{-13,-10},{13,10}},
        rotation=180,
        origin={53,60})));
  Modelica.Blocks.Sources.Constant TCon2_const(k=313.15)
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-92,50})));

  Modelica.Blocks.Sources.Constant TCon1_const1(k=353.15)
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-72,-56})));
  Modelica.Blocks.Sources.Constant TCon1_const2(k=343.15)
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,-86})));
  Modelica.Blocks.Sources.Constant TCon1_const4(k=333.15)
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,-116})));
  Modelica.Blocks.Sources.Sine      sine(
    amplitude=5,
    freqHz=1/86400,
    phase=-1.5707963267949,
    offset=293.15)
            "PI Controller for controlling the valve position"
            annotation (Placement(transformation(extent={{-186,28},{-166,48}})));
equation
  connect(bou.ports[1],
    modularBoiler_HierarchicalRegulation_wPump_wFeedback_wAdmix_.port_a)
    annotation (Line(points={{-84,-16},{-42,-16},{-42,0},{-32,0}},
                                                                 color={0,127,255}));
  connect(boilerControlBus,
    modularBoiler_HierarchicalRegulation_wPump_wFeedback_wAdmix_.boilerControlBus)
    annotation (Line(
      points={{0,60},{0,30}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PLR_const.y, boilerControlBus.PLR)
    annotation (Line(points={{-39,80},{
          0.05,80},{0.05,60.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(dT_const.y, boilerControlBus.DeltaTWater)
    annotation (Line(points={{-39,
          48},{0.05,48},{0.05,60.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  for i in 1:k loop
    connect(
      modularBoiler_HierarchicalRegulation_wPump_wFeedback_wAdmix_.ports_b[
      i], bou.ports[i + 1])
       annotation (Line(points={{32,0},{40,0},{40,-40},{-40,-40},{-40,-16},{-84,
            -16}},                 color={0,127,255}));
  end for;
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
  connect(PLR_const.y, boilerControlBus.PLREx)
    annotation (Line(points={{-39,80},
          {-20,80},{-20,60},{0,60}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(TCon1_const.y,
    modularBoiler_HierarchicalRegulation_wPump_wFeedback_wAdmix_.TCon[1])
    annotation (Line(points={{-81,80},{-64,80},{-64,22},{-36,22},{-36,10.2},{
          -32,10.2}},
        color={0,0,127}));
  connect(TCon2_const.y,
    modularBoiler_HierarchicalRegulation_wPump_wFeedback_wAdmix_.TCon[2])
    annotation (Line(points={{-81,50},{-72,50},{-72,13.8},{-32,13.8}},
        color={0,0,127}));

  connect(TCon1_const1.y,
    modularBoiler_HierarchicalRegulation_wPump_wFeedback_wAdmix_.TLayers[2])
    annotation (Line(points={{-61,-56},{-54,-56},{-54,28},{-32,28},{-32,24}},
        color={0,0,127}));
  connect(TCon1_const2.y,
    modularBoiler_HierarchicalRegulation_wPump_wFeedback_wAdmix_.TLayers[1])
    annotation (Line(points={{-59,-86},{-42,-86},{-42,24},{-32,24}}, color={0,0,
          127}));
  connect(TCon1_const4.y,
    modularBoiler_HierarchicalRegulation_wPump_wFeedback_wAdmix_.TLayers[3])
    annotation (Line(points={{-59,-116},{-46,-116},{-46,24},{-32,24}}, color={0,
          0,127}));
  connect(sine.y, boilerControlBus.Tamb) annotation (Line(points={{-165,38},{
          -148,38},{-148,104},{-32,104},{-32,88},{0,88},{0,60}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
annotation (
    experiment(
      StopTime=3600,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end ModularBoiler_HierachicalRegulation_wPump_wFeedback_wAdmix;
