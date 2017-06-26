within AixLib.Fluid;
package DistrictHeating "Package with models for district heating network"

  extends Modelica.Icons.VariantsPackage;

  partial model SolarDistrictHeating_BaseClass
    "Base class of a solar district heating  "

    replaceable package Medium = AixLib.Media.Water;

    ExergyBasedControl.DistrictHeating.HeatGeneratorUnit.BuffStorageExtHEx heatStorageSolarColl
      annotation (Placement(transformation(extent={{-330,-56},{-286,-15}})));
    ExergyBasedControl.DistrictHeating.HeatGeneratorUnit.SolarThermal solarCollector(
      Collector=AixLib.DataBase.SolarThermal.FlatCollector(),
      show_T=true,
      redeclare package Medium = Medium,
      MediumVolume=2,
      m_flow_nominal=10,
      T_ref=313.15,
      A=200) annotation (Placement(transformation(
          extent={{-18,-18},{18,18}},
          rotation=180,
          origin={-426,63})));

    AixLib.Fluid.Movers.FlowControlled_m_flow SolarLoopPump(
                                            redeclare package Medium =
          Medium, m_flow_nominal=12)         annotation (Placement(transformation(
          extent={{-11,-11},{11,11}},
          rotation=180,
          origin={-377,63})));

    AixLib.Fluid.Sources.FixedBoundary bou(          nPorts=1,
      redeclare package Medium = Medium,
      p=200000)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-356,38})));

    inner Modelica.Fluid.System system
      annotation (Placement(transformation(extent={{326,306},{360,338}})));
    AixLib.Fluid.HeatPumps.HeatPumpDetailed heatPump(
      P_eleOutput=true,
      CoP_output=true,
      HPctrlType=false,
          redeclare package Medium_con =
          Medium,
      redeclare package Medium_eva =
          Medium,
      mFlow_evaNominal=2,
      mFlow_conNominal=2,
      N_min=800,
      volume_eva=0.1,
      volume_con=0.1,
      N_max=3700,
      redeclare replaceable function data_poly =
          ExergyBasedControl.DistrictHeating.BaseClasses.Functions.Characteristics.VariableNrpm
          (N_max=3700, P_com=60000),
      T_startEva=303.15,
      T_startCon=313.15,
      T_conMax=353.15)
      annotation (Placement(transformation(extent={{-206,-48},{-146,-8}})));
    ExergyBasedControl.DistrictHeating.HeatGeneratorUnit.DividerUnit dividerUnit(
        redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{-212,53},{-192,73}})));
    AixLib.Fluid.Sensors.TemperatureTwoPort TempCondOut(redeclare package
        Medium =                                                                   Medium,
        m_flow_nominal=10) annotation (Placement(transformation(extent={{-128,2},{
              -108,22}})));
    AixLib.Fluid.Sensors.TemperatureTwoPort FlowTempDirSupp( redeclare package
        Medium =                                                                        Medium,
        m_flow_nominal=10)
      annotation (Placement(transformation(extent={{-148,52},{-126,74}})));
    AixLib.Fluid.Storage.BufferStorage bufferStorage(
      useHeatingRod=false,
      upToDownHC2=false,
      redeclare package Medium = Medium,
      redeclare model HeatTransfer =
          AixLib.Fluid.Storage.BaseClasses.HeatTransferLambdaEff,
      redeclare package MediumHC1 = Medium,
      redeclare package MediumHC2 = Medium,
      n=10,
      useHeatingCoil1=true,
      useHeatingCoil2=false,
      upToDownHC1=true,
      data=AixLib.DataBase.Storage.Generic_New_2000l(
            hTank=2,
            hUpperPorts=1.9,
            hHC1Up=1.9,
            hHC1Low=0.4,
            pipeHC1=AixLib.DataBase.Pipes.Copper.Copper_22x1_5(d_i=0.10, d_o=
            0.11),
            lengthHC1=140),
      TStart=313.15,
      TStartWall=313.15,
      TStartIns=313.15)
      annotation (Placement(transformation(extent={{-24,-30.5},{24,30.5}},
          rotation=0,
          origin={-42,-30.5})));
    AixLib.Fluid.Movers.FlowControlled_m_flow Stg2Hp(redeclare package Medium
        = Medium, m_flow_nominal=20)  annotation (Placement(transformation(
          extent={{-9,-9.5},{9,9.5}},
          rotation=180,
          origin={-125,-68.5})));
    AixLib.Fluid.Sources.FixedBoundary bou5(                   redeclare
        package Medium =
                 Medium,
      p=200000,
      nPorts=1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-116,-38})));
    AixLib.Fluid.Movers.FlowControlled_m_flow HpStg1(redeclare package Medium
        = Medium, m_flow_nominal=12)  annotation (Placement(transformation(
          extent={{-9,-9.5},{9,9.5}},
          rotation=270,
          origin={-202,-62.5})));
    ExergyBasedControl.DistrictHeating.HeatGeneratorUnit.CollectorUnit collectorUnit
      annotation (Placement(transformation(extent={{-213,-134},{-191,-111}})));
    AixLib.Fluid.Movers.FlowControlled_m_flow Stg2Stg1(redeclare package Medium
        = Medium, m_flow_nominal=12)  annotation (Placement(transformation(
          extent={{-9,-9.5},{9,9.5}},
          rotation=180,
          origin={-93,-122.5})));
    AixLib.Fluid.Sensors.TemperatureTwoPort TempEvaIn(redeclare package Medium
        =                                                                        Medium,
        m_flow_nominal=10) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-202,8})));
    AixLib.Fluid.Sensors.TemperatureTwoPort TempCondOut1(
                                                        redeclare package
        Medium =                                                                   Medium,
        m_flow_nominal=10) annotation (Placement(transformation(extent={{-7,-7},
              {7,7}},
          rotation=270,
          origin={-86,-45})));
    replaceable AixLib.Fluid.Interfaces.PartialTwoPortTransport Replaceable5
      constrainedby AixLib.Fluid.Interfaces.PartialTwoPort(redeclare final
        package Medium = Medium) annotation (Placement(transformation(
          extent={{-14,-14},{14,14}},
          rotation=180,
          origin={292,-122})));

    replaceable AixLib.Fluid.Interfaces.PartialTwoPortTransport Replaceable2
      constrainedby AixLib.Fluid.Interfaces.PartialTwoPort(redeclare final
        package Medium = Medium)
      annotation (Placement(transformation(extent={{-18,49},{8,75}})));

    replaceable AixLib.Fluid.Interfaces.PartialTwoPortTransport Replaceable3
      constrainedby AixLib.Fluid.Interfaces.PartialTwoPort(redeclare final
        package Medium = Medium) annotation (Placement(transformation(
          extent={{-9,-9},{9,9}},
          rotation=90,
          origin={-265,13})));

    replaceable AixLib.Fluid.Interfaces.PartialTwoPortTransport Replaceable4
      constrainedby AixLib.Fluid.Interfaces.PartialTwoPort(redeclare final
        package Medium = Medium) annotation (Placement(transformation(
          extent={{-9,-9},{9,9}},
          rotation=90,
          origin={-265,-83})));

    AixLib.Fluid.HeatExchangers.ConstantEffectiveness AuxSystem( redeclare
        package Medium1 =                                                                    Medium, redeclare
        package Medium2 =                                                                                                        Medium,
      m1_flow_nominal=10,
      m2_flow_nominal=10,
      dp1_nominal=10000,
      dp2_nominal=10000)
      "Auxiliary heat exchanger from a CHP unit" annotation (Placement(transformation(
          extent={{20,-18},{-20,18}},
          rotation=180,
          origin={122,73})));

    replaceable AixLib.Fluid.Interfaces.PartialTwoPortTransport Replaceable1 constrainedby
      AixLib.Fluid.Interfaces.PartialTwoPort(
     redeclare final package Medium = Medium)
      annotation (Placement(transformation(extent={{278,48},{306,76}})));

    replaceable AixLib.Fluid.Interfaces.PartialTwoPortTransport Replaceable6 constrainedby
      AixLib.Fluid.Interfaces.PartialTwoPort(
     redeclare final package Medium = Medium)
     annotation (Placement(transformation(
          extent={{-10.5,-10.5},{10.5,10.5}},
          rotation=270,
          origin={174.5,134.5})));

    replaceable AixLib.Fluid.Interfaces.PartialTwoPortTransport Replaceable7 constrainedby
      AixLib.Fluid.Interfaces.PartialTwoPort(
     redeclare final package Medium = Medium)
     annotation (Placement(transformation(
          extent={{-10.5,-10.5},{10.5,10.5}},
          rotation=90,
          origin={76.5,133.5})));

    AixLib.Fluid.BoilerCHP.CHP cHP( redeclare package Medium = Medium, m_flow_nominal=10,
      param=AixLib.DataBase.CHP.CHP_FMB_270_GSMK(),
      ctrlStrategy=true,
      minDeltaT=5,
      TFlowRange=2,
      vol(V=5),
      minCapacity=40,
      delayTime=1000,
      Kc=2,
      Tc=200,
      delayUnit=60)  annotation (Placement(transformation(extent={{102,238},{146,282}})));
    AixLib.Fluid.Sensors.TemperatureTwoPort FlowTempSDH(redeclare package
        Medium =                                                                   Medium,
        m_flow_nominal=10) annotation (Placement(transformation(extent={{223,50},
              {250,74}})));
    AixLib.Fluid.Movers.FlowControlled_m_flow CHPPump(redeclare package Medium
        = Medium, m_flow_nominal=12) annotation (Placement(transformation(
          extent={{-15,-15},{15,15}},
          rotation=90,
          origin={76,213})));
    AixLib.Fluid.Sources.FixedBoundary bou1(         nPorts=1,
      redeclare package Medium = Medium,
      p=200000)
      annotation (Placement(transformation(extent={{-11,-11},{11,11}},
          rotation=270,
          origin={147,295})));
    AixLib.Fluid.Actuators.Valves.TwoWayQuickOpening AuxValve(
      m_flow_nominal=1,
      redeclare package Medium = Medium,
      dpValve_nominal=10000) annotation (Placement(transformation(
          extent={{-14,-14},{14,14}},
          rotation=0,
          origin={64,62})));
    AixLib.Fluid.Actuators.Valves.TwoWayQuickOpening BypassValve(
      m_flow_nominal=1,
      redeclare package Medium = Medium,
      dpValve_nominal=10000) annotation (Placement(transformation(
          extent={{-13.75,-13.75},{13.75,13.75}},
          rotation=0,
          origin={90.25,14.25})));
    AixLib.Fluid.MixingVolumes.MixingVolume HighTempCons(
      nPorts=2,
      m_flow_nominal=10,
      V=0.5, redeclare package Medium = Medium) annotation (Placement(transformation(
          extent={{-14,-14},{14,14}},
          rotation=180,
          origin={120,174})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heater
      "Prescribed heat flow" annotation (
        Placement(transformation(
          extent={{-9,-9},{9,9}},
          rotation=90,
          origin={145,163})));
    Modelica.Blocks.Sources.BooleanConstant cHPsignal(k=true) annotation (
        Placement(transformation(
          extent={{-9,-9},{9,9}},
          rotation=180,
          origin={145,223})));
    Modelica.Blocks.Sources.Constant HighTempDemand(k=-50000)
                                                            annotation (Placement(
          transformation(
          extent={{-8,-8},{8,8}},
          rotation=0,
          origin={122,136})));
    Modelica.Blocks.Sources.Constant ConsMasFlow(k=2)
      annotation (Placement(transformation(extent={{16,224},{38,246}})));
    AixLib.Fluid.Sensors.TemperatureTwoPort cHPflowTemp(redeclare package
        Medium = Medium, m_flow_nominal=10) annotation (Placement(
          transformation(
          extent={{-10.5,-10.5},{10.5,10.5}},
          rotation=270,
          origin={174.5,227.5})));
    AixLib.Fluid.Sensors.TemperatureTwoPort cHPreturnTemp(redeclare package
        Medium = Medium, m_flow_nominal=10) annotation (Placement(
          transformation(
          extent={{-9,-10.5},{9,10.5}},
          rotation=90,
          origin={75.5,247})));
    AixLib.Fluid.Actuators.Valves.TwoWayQuickOpening heatExValve(
      m_flow_nominal=1,
      redeclare package Medium = Medium,
      dpValve_nominal=10000) annotation (Placement(transformation(
          extent={{-8,-8.5},{8,8.5}},
          rotation=270,
          origin={174.5,164})));
    AixLib.Fluid.Actuators.Valves.TwoWayQuickOpening highTempValve(
      m_flow_nominal=1,
      redeclare package Medium = Medium,
      dpValve_nominal=10000) annotation (Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=180,
          origin={158,188})));
    Modelica.Blocks.Sources.Constant masFlowDistcHP(k=0.85)
                                                           annotation (
        Placement(transformation(
          extent={{-7,-7},{7,7}},
          rotation=180,
          origin={219,181})));
    Modelica.Blocks.Sources.Constant masFlowDistHighCons(k=1)   annotation (
        Placement(transformation(
          extent={{-7,-7},{7,7}},
          rotation=180,
          origin={219,212})));
    Modelica.Blocks.Math.Gain CHPelePowerWatt(k=1000) annotation (Placement(
          transformation(
          extent={{-9,-9},{9,9}},
          rotation=180,
          origin={55,287})));
    Modelica.Blocks.Math.Add         masFlowDistHighCons1(k1=-1, k2=+1)
                                                                annotation (
        Placement(transformation(
          extent={{-7,-7},{7,7}},
          rotation=180,
          origin={189,205})));
  equation
    connect(heatStorageSolarColl.port_b, SolarLoopPump.port_a) annotation (Line(
          points={{-330,-27.3},{-330,-27},{-340,-27},{-340,63},{-366,63}},
          color={0,127,255},
        thickness=1));
    connect(SolarLoopPump.port_b, solarCollector.port_a)
      annotation (Line(points={{-388,63},{-408,63}},     color={0,127,255},
        thickness=1));
    connect(solarCollector.port_b, heatStorageSolarColl.port_a) annotation (Line(
          points={{-444,63},{-464,63},{-464,-56},{-464,-124},{-342,-124},{-342,
            -43.7},{-330,-43.7}},   color={0,127,255},
        thickness=1));
    connect(bou.ports[1], SolarLoopPump.port_a) annotation (Line(points={{-356,48},
            {-356,63},{-366,63}},            color={0,127,255}));

    connect(heatPump.port_conOut, TempCondOut.port_a) annotation (Line(
        points={{-150,-14},{-150,-14},{-150,12},{-128,12}},
        color={0,127,255},
        thickness=1));
    connect(dividerUnit.port_b1, FlowTempDirSupp.port_a)
      annotation (Line(points={{-192,63},{-148,63}},
                                                  color={0,127,255},
        thickness=1));
    connect(TempCondOut.port_b, bufferStorage.portHC1In) annotation (Line(
        points={{-108,12},{-108,12},{-86,12},{-86,-13.115},{-66.6,-13.115}},
        color={0,127,255},
        thickness=1));
    connect(Stg2Hp.port_b, heatPump.port_conIn) annotation (Line(
        points={{-134,-68.5},{-150,-68.5},{-150,-42}},
        color={0,127,255},
        thickness=1));
    connect(bou5.ports[1], Stg2Hp.port_a) annotation (Line(
        points={{-116,-48},{-116,-58},{-116,-68.5}},
        color={0,127,255}));
    connect(FlowTempDirSupp.port_b, bufferStorage.fluidportTop1) annotation (
        Line(
        points={{-126,63},{-124,63},{-50.4,63},{-50.4,0.305}},
        color={0,127,255},
        thickness=1));
    connect(bufferStorage.fluidportBottom1, Stg2Stg1.port_a) annotation (Line(
        points={{-50.1,-61.61},{-50.1,-122.5},{-84,-122.5}},
        color={0,127,255},
        thickness=1));
    connect(Stg2Stg1.port_b, collectorUnit.port_b1) annotation (Line(
        points={{-102,-122.5},{-191,-122.5}},
        color={0,127,255},
        thickness=1));
    connect(heatPump.port_evaOut, HpStg1.port_a) annotation (Line(
        points={{-202,-42},{-202,-53.5}},
        color={0,127,255},
        thickness=1));
    connect(HpStg1.port_b, collectorUnit.port_b) annotation (Line(
        points={{-202,-71.5},{-202,-92},{-202,-111}},
        color={0,127,255},
        thickness=1));
    connect(dividerUnit.port_b, TempEvaIn.port_a) annotation (Line(
        points={{-202,53},{-202,18}},
        color={0,127,255},
        thickness=1));
    connect(TempEvaIn.port_b, heatPump.port_evaIn) annotation (Line(
        points={{-202,-2},{-202,-14}},
        color={0,127,255},
        thickness=1));
    connect(TempCondOut1.port_a, bufferStorage.portHC1Out) annotation (Line(
        points={{-86,-38},{-86,-22.57},{-66.3,-22.57}},
        color={0,127,255},
        thickness=1));
    connect(TempCondOut1.port_b, Stg2Hp.port_a) annotation (Line(
        points={{-86,-52},{-86,-68.5},{-116,-68.5}},
        color={0,127,255},
        thickness=1));
    connect(Replaceable2.port_a, bufferStorage.fluidportTop2) annotation (Line(
        points={{-18,62},{-34.5,62},{-34.5,0.305}},
        color={0,127,255},
        thickness=1));
    connect(Replaceable3.port_a, heatStorageSolarColl.port_b1) annotation (Line(
        points={{-265,4},{-265,-27.3},{-286,-27.3}},
        color={0,127,255},
        thickness=1));
    connect(Replaceable4.port_b, heatStorageSolarColl.port_a1) annotation (Line(
        points={{-265,-74},{-265,-44.93},{-286,-44.93}},
        color={0,127,255},
        thickness=1));
    connect(Replaceable4.port_a, collectorUnit.port_a) annotation (Line(
        points={{-265,-92},{-265,-122.5},{-213,-122.5}},
        color={0,127,255},
        thickness=1));
    connect(AuxSystem.port_b2, Replaceable7.port_a) annotation (Line(
        points={{102,83.8},{76.5,83.8},{76.5,123}},
        color={0,127,255},
        thickness=1));
    connect(dividerUnit.port_a, Replaceable3.port_b) annotation (Line(
        points={{-212,63},{-265,63},{-265,22}},
        color={0,127,255},
        thickness=1));
    connect(bou1.ports[1], cHP.port_b) annotation (Line(points={{147,284},{147,260},
            {146,260}},                color={0,127,255}));
    connect(AuxValve.port_b, AuxSystem.port_a1) annotation (Line(
        points={{78,62},{102,62},{102,62.2}},
        color={0,127,255},
        thickness=1));
    connect(AuxSystem.port_b1, FlowTempSDH.port_a) annotation (Line(
        points={{142,62.2},{148,62.2},{148,62},{174,62},{223,62}},
        color={0,127,255},
        thickness=1));
    connect(BypassValve.port_b, FlowTempSDH.port_a) annotation (Line(
        points={{104,14.25},{140,14.25},{140,14},{196,14},{196,62},{210,62},{
            223,62}},
        color={0,127,255},
        thickness=1));
    connect(heater.port, HighTempCons.heatPort) annotation (Line(points={{145,172},
            {145,172},{145,174},{134,174}},           color={191,0,0}));
    connect(cHPsignal.y, cHP.on) annotation (Line(points={{135.1,223},{130.6,223},
            {130.6,240.2}}, color={255,0,255}));
    connect(HighTempDemand.y, heater.Q_flow) annotation (Line(points={{130.8,136},
            {145,136},{145,154}}, color={0,0,127}));
    connect(ConsMasFlow.y, CHPPump.m_flow_in) annotation (Line(points={{39.1,235},
            {50,235},{50,212.7},{58,212.7}},    color={0,0,127}));
    connect(HighTempCons.ports[1], CHPPump.port_a) annotation (Line(
        points={{122.8,188},{76,188},{76,198}},
        color={0,127,255},
        thickness=1));
    connect(cHP.port_b, cHPflowTemp.port_a) annotation (Line(
        points={{146,260},{174.5,260},{174.5,238}},
        color={0,127,255},
        thickness=1));
    connect(CHPPump.port_b, cHPreturnTemp.port_a) annotation (Line(
        points={{76,228},{76,227.5},{75.5,227.5},{75.5,238}},
        color={0,127,255},
        thickness=1));
    connect(cHPreturnTemp.port_b, cHP.port_a) annotation (Line(
        points={{75.5,256},{75.5,260},{102,260}},
        color={0,127,255},
        thickness=1));
    connect(cHPflowTemp.port_b, heatExValve.port_a) annotation (Line(
        points={{174.5,217},{174.5,194},{174.5,172}},
        color={0,127,255},
        thickness=1));
    connect(cHPflowTemp.port_b, highTempValve.port_a) annotation (Line(
        points={{174.5,217},{174.5,188},{166,188}},
        color={0,127,255},
        thickness=1));
    connect(highTempValve.port_b, HighTempCons.ports[2]) annotation (Line(
        points={{150,188},{128.85,188},{117.2,188}},
        color={0,127,255},
        thickness=1));
    connect(masFlowDistcHP.y, heatExValve.y) annotation (Line(points={{211.3,
            181},{196,181},{196,164},{184.7,164}}, color={0,0,127}));
    connect(cHP.electricalPower, CHPelePowerWatt.u) annotation (Line(points={{113,
            279.8},{113,287},{65.8,287}},      color={0,0,127}));
    connect(masFlowDistHighCons.y, masFlowDistHighCons1.u2) annotation (Line(
          points={{211.3,212},{206,212},{206,209.2},{197.4,209.2}}, color={0,0,
            127}));
    connect(masFlowDistcHP.y, masFlowDistHighCons1.u1) annotation (Line(points={{211.3,
            181},{206,181},{206,200.8},{197.4,200.8}},         color={0,0,127}));
    connect(masFlowDistHighCons1.y, highTempValve.y) annotation (Line(points={{
            181.3,205},{170,205},{170,174},{158,174},{158,178.4}}, color={0,0,
            127}));
    connect(Replaceable6.port_b, AuxSystem.port_a2) annotation (Line(
        points={{174.5,124},{174.5,124},{174.5,83.8},{142,83.8}},
        color={0,127,255},
        thickness=1));
    connect(bufferStorage.fluidportBottom2, Replaceable5.port_b) annotation (
        Line(
        points={{-35.1,-61.305},{-36,-61.305},{-36,-122},{278,-122}},
        color={0,127,255},
        thickness=1));
    connect(Replaceable1.port_a, FlowTempSDH.port_b) annotation (Line(
        points={{278,62},{272,62},{250,62}},
        color={0,127,255},
        thickness=1));
    connect(Replaceable2.port_b, AuxValve.port_a) annotation (Line(
        points={{8,62},{50,62}},
        color={0,127,255},
        thickness=1));
    connect(Replaceable2.port_b, BypassValve.port_a) annotation (Line(
        points={{8,62},{38,62},{38,14.25},{76.5,14.25}},
        color={0,127,255},
        thickness=1));
    connect(Replaceable7.port_b, CHPPump.port_a) annotation (Line(
        points={{76.5,144},{76,144},{76,150},{76,198}},
        color={0,127,255},
        thickness=1));
    connect(Replaceable6.port_a, heatExValve.port_b) annotation (Line(
        points={{174.5,145},{174,145},{174,156},{174.5,156}},
        color={0,127,255},
        thickness=1));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-500,
              -260},{360,340}}),
                          graphics={
    Rectangle(
            extent={{-500,340},{360,-260}},
            lineColor={0,0,0},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
                                    Text(
            extent={{-218,84},{84,-108}},
            lineColor={28,108,200},
            textString="%name
")}),                      Diagram(coordinateSystem(preserveAspectRatio=true,
            extent={{-500,-260},{360,340}})),
      experiment(StopTime=86400, Interval=5),
      Documentation(info="<html>
<h4>Overview</h4>
<p>This initial model represents a base class of a heat generation unit in a district heating network with replaceable components. For the initial model, no control input connectors are included. </p>
</html>", revisions="<html>
<ul>
<li><i>June 19, 2017&nbsp;</i> by Farid Davani:<br/>Initial configuration of the base class<
</ul>
</html>"));
  end SolarDistrictHeating_BaseClass;

  model SolarDistrictHeating
    "Solar district heating model with control input connectors"

     extends
      ExergyBasedControl.DistrictHeating.DistrictHeating_ExergyAnalysis.AixLib_SolarDistrictHeating_BaseClass(
      redeclare
        ExergyBasedControl.DistrictHeating.DistrictHeating_ExergyAnalysis.ExergyAnalysisTool.ExergyMeterMediumMixed
        Replaceable1,
      redeclare AixLib.Fluid.Movers.FlowControlled_dp Replaceable2(
        m_flow_nominal=10,
        redeclare
          AixLib.Fluid.Movers.Data.Pumps.Wilo.VeroLine80slash115dash2comma2slash2
          per,
        inputType=AixLib.Fluid.Types.InputType.Continuous),
      redeclare
        ExergyBasedControl.DistrictHeating.DistrictHeating_ExergyAnalysis.ExergyAnalysisTool.ExergyMeterMediumMixed
        Replaceable3,
      redeclare
        ExergyBasedControl.DistrictHeating.DistrictHeating_ExergyAnalysis.ExergyAnalysisTool.ExergyMeterMediumMixed
        Replaceable4,
      redeclare
        ExergyBasedControl.DistrictHeating.DistrictHeating_ExergyAnalysis.ExergyAnalysisTool.ExergyMeterMediumMixed
        Replaceable5,
      redeclare AixLib.Fluid.Sensors.TemperatureTwoPort Replaceable6(
          m_flow_nominal=10),
      redeclare AixLib.Fluid.Sensors.TemperatureTwoPort Replaceable7(
          m_flow_nominal=10),
      heatPump(redeclare function data_poly =
            ExergyBasedControl.DistrictHeating.BaseClasses.Functions.Characteristics.VariableNrpm
            (N_max=3700, P_com=60000)),
      cHP(
        m_flow_nominal=10,
        TSetIn=true,
        ctrlStrategy=true,
        minDeltaT=5,
        param=
            ExergyBasedControl.DistrictHeating.DataBase.CHP_TechnicalData_485KW(),

        minCapacity=40,
        Tc=200,
        TFlowRange=2,
        Kc=2,
        delayTime=1000),
      bufferStorage(data=AixLib.DataBase.Storage.Generic_New_2000l(
              hTank=2,
              hUpperPorts=1.9,
              hHC1Up=1.9,
              hHC1Low=0.4,
              pipeHC1=AixLib.DataBase.Pipes.Copper.Copper_22x1_5(d_i=0.10, d_o=
              0.11),
              lengthHC1=140)),
      ConsMasFlow(k=2),
      cHPsignal(k=true));

    Modelica.Blocks.Interfaces.RealInput Irradiation "Solar irradiation on a horizontal plane in [W/m2]"
      annotation (Placement(transformation(extent={{-516,-12},{-476,28}}), iconTransformation(extent={{-516,-12},{-476,28}})));
    Modelica.Blocks.Interfaces.RealInput Toutdoor "ambient temperature in [K]"
      annotation (Placement(transformation(extent={{-516,-52},{-476,-12}}),
                                                                          iconTransformation(extent={{-516,-52},{-476,-12}})));
    Modelica.Blocks.Interfaces.RealInput NetworkPresRise "Pressure rise of the network in [Pa]"
                                     annotation (Placement(transformation(
          extent={{-19,-19},{19,19}},
          rotation=270,
          origin={-67,344}),  iconTransformation(
          extent={{-27,-27},{27,27}},
          rotation=90,
          origin={-54,-243})));
    Modelica.Blocks.Interfaces.RealInput cHPflowTempSetpoint "Set point flow temperature of CHP in [K]" annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={94,346}), iconTransformation(
          extent={{-26,-26},{26,26}},
          rotation=270,
          origin={128,330})));
    Modelica.Blocks.Interfaces.RealInput SolarCirPumpMF "Constant mass flow rate of solar circuit pump in [kg/s]" annotation (Placement(transformation(
          extent={{-19,-19},{19,19}},
          rotation=90,
          origin={-295,-266}), iconTransformation(
          extent={{-27,-27},{27,27}},
          rotation=90,
          origin={-169,-245})));
    Modelica.Blocks.Interfaces.RealInput SeasStgCirPumpMF "Constant mass flow rate of seasonal storage circuit pump in [kg/s]" annotation (Placement(
          transformation(
          extent={{-19,-19},{19,19}},
          rotation=90,
          origin={-265,-266}), iconTransformation(
          extent={{-27,-27},{27,27}},
          rotation=90,
          origin={-347,-245})));
    Modelica.Blocks.Interfaces.RealInput ValveOpDirSupp "Valve opening for direct supply" annotation (Placement(transformation(
          extent={{-19,-19},{19,19}},
          rotation=90,
          origin={-235,-266}), iconTransformation(
          extent={{-27,-27},{27,27}},
          rotation=90,
          origin={-229,-245})));
    Modelica.Blocks.Interfaces.RealInput ValveOpIndirSupp "Valve opening for indirect supply" annotation (Placement(transformation(
          extent={{-19,-19},{19,19}},
          rotation=90,
          origin={-208,-266}), iconTransformation(
          extent={{-27,-27},{27,27}},
          rotation=90,
          origin={-289,-245})));
    Modelica.Blocks.Interfaces.RealInput HPevaMF "Constant mass flow rate of heat pump evaporator in [kg/s]" annotation (Placement(transformation(
          extent={{-19,-19},{19,19}},
          rotation=90,
          origin={-182,-266}), iconTransformation(
          extent={{-27,-27},{27,27}},
          rotation=90,
          origin={121,-243})));
    Modelica.Blocks.Interfaces.RealInput HPcondMF "Constant mass flow rate of heat pump condenser in [kg/s]" annotation (Placement(transformation(
          extent={{-19,-19},{19,19}},
          rotation=90,
          origin={-156,-266}), iconTransformation(
          extent={{-27,-27},{27,27}},
          rotation=90,
          origin={63,-243})));
    Modelica.Blocks.Interfaces.RealInput DirSuppMF
      "Constant mass flow rate for direct supply in [kg/s]" annotation (
        Placement(transformation(
          extent={{-19,-19},{19,19}},
          rotation=90,
          origin={-128,-266}), iconTransformation(
          extent={{-27,-27},{27,27}},
          rotation=90,
          origin={4,-243})));
    Modelica.Blocks.Interfaces.RealInput rpmHP "Constant mass flow rate for direct supply in [kg/s]" annotation (Placement(transformation(
          extent={{-19,-19},{19,19}},
          rotation=270,
          origin={-178,346}), iconTransformation(
          extent={{-27,-27},{27,27}},
          rotation=270,
          origin={-181,333})));
    Modelica.Blocks.Interfaces.BooleanInput OnOffHP "On/Off signal of the heat pump"
                                                    annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={-206,346}), iconTransformation(
          extent={{-27,-27},{27,27}},
          rotation=270,
          origin={-237,333})));
    Modelica.Blocks.Interfaces.RealOutput HPCondTemp "Condenser temperature of the heat pump in [°C]" annotation (Placement(transformation(
          extent={{-23,-23},{23,23}},
          rotation=180,
          origin={-515,293}), iconTransformation(
          extent={{-23,-23},{23,23}},
          rotation=180,
          origin={-510,310})));
    Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin3 annotation (
        Placement(transformation(
          extent={{-11,-11},{11,11}},
          rotation=180,
          origin={-457,293})));
    Modelica.Blocks.Interfaces.RealOutput TopTempBuffStg "Top temperature of the buffer storage in [°C]" annotation (Placement(transformation(
          extent={{-23,-23},{23,23}},
          rotation=180,
          origin={-515,329}), iconTransformation(
          extent={{-23,-23},{23,23}},
          rotation=180,
          origin={-510,118})));
    Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin1 annotation (
        Placement(transformation(
          extent={{-11,-11},{11,11}},
          rotation=180,
          origin={-457,321})));
    Modelica.Blocks.Interfaces.RealOutput TopTempSeasStg "Top temperature of the seasonal storage in [°C]" annotation (Placement(transformation(
          extent={{-23,-23},{23,23}},
          rotation=180,
          origin={-515,255}), iconTransformation(
          extent={{-23,-23},{23,23}},
          rotation=180,
          origin={-510,216})));
    Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin2 annotation (
        Placement(transformation(
          extent={{-11,-11},{11,11}},
          rotation=180,
          origin={-457,255})));
    Modelica.Blocks.Interfaces.RealOutput BottTempSeasStg "Bottom temperature of the seasonal storage in [°C]" annotation (Placement(transformation(
          extent={{-23,-23},{23,23}},
          rotation=180,
          origin={-515,218}), iconTransformation(
          extent={{-23,-23},{23,23}},
          rotation=180,
          origin={-510,166})));
    Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin4 annotation (
        Placement(transformation(
          extent={{-11,-11},{11,11}},
          rotation=180,
          origin={-457,218})));
    Modelica.Blocks.Interfaces.RealOutput flowTempSolCir "Flow temperature of the solar circuit in [°C]" annotation (Placement(transformation(
          extent={{-23,-23},{23,23}},
          rotation=180,
          origin={-515,178}), iconTransformation(
          extent={{-23,-23},{23,23}},
          rotation=180,
          origin={-510,264})));
    Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin5 annotation (
        Placement(transformation(
          extent={{-11,-11},{11,11}},
          rotation=180,
          origin={-457,180})));
    Modelica.Blocks.Interfaces.RealOutput flowTempSDH "Flow temperature of the solar circuit in [°C]" annotation (Placement(transformation(
          extent={{-23,-23},{23,23}},
          rotation=180,
          origin={-517,138}), iconTransformation(
          extent={{-23,-23},{23,23}},
          rotation=180,
          origin={-510,68})));
    Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin6 annotation (
        Placement(transformation(
          extent={{-11,-11},{11,11}},
          rotation=180,
          origin={-457,138})));
    Modelica.Blocks.Interfaces.RealInput ValveOpAuxValve "Valve opening of the auxiliary valve" annotation (Placement(transformation(
          extent={{-19,-19},{19,19}},
          rotation=270,
          origin={-35,343}), iconTransformation(
          extent={{-27,-27},{27,27}},
          rotation=270,
          origin={-43,333})));
    Modelica.Blocks.Interfaces.RealInput ValveOpBypValve "Valve opening of the bypass valve" annotation (Placement(transformation(
          extent={{-19,-19},{19,19}},
          rotation=270,
          origin={-5,343}), iconTransformation(
          extent={{-27,-27},{27,27}},
          rotation=270,
          origin={-99,333})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b( redeclare package Medium =
                 Medium)
      annotation (Placement(transformation(extent={{340,42},{384,82}}),
          iconTransformation(extent={{336,184},{384,228}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a( redeclare package Medium =
                 Medium)
      annotation (Placement(transformation(extent={{340,-142},{386,-100}}),
          iconTransformation(extent={{340,-182},{386,-138}})));
    Modelica.Blocks.Sources.Constant Pressure1(
                                              k=101300)
      annotation (Placement(transformation(extent={{19,19},{-19,-19}},
          rotation=90,
          origin={291,321})));
    Modelica.Blocks.Sources.Constant xRefWater(k=1)
      annotation (Placement(transformation(extent={{-19,-19},{19,19}},
          rotation=270,
          origin={231,321})));
  equation
    connect(Irradiation, solarCollector.Irradiation) annotation (Line(points={{-496,8},{-472,8},{-472,20},{-427.8,20},{-427.8,43.56}}, color={0,0,127}));
    connect(cHPflowTempSetpoint, cHP.TSet) annotation (Line(points={{94,346},{94,246.8},{108.6,246.8}}, color={0,0,127}));
    connect(SolarCirPumpMF, SolarLoopPump.m_flow_in) annotation (Line(points={{-295,-266},{-295,-150},{-376.78,-150},{-376.78,49.8}}, color={0,0,127}));
    connect(SeasStgCirPumpMF, heatStorageSolarColl.MassFlowStgLoop)
      annotation (Line(points={{-265,-266},{-265,-141},{-312.4,-141},{-312.4,-55.18}}, color={0,0,127}));
    connect(ValveOpDirSupp, collectorUnit.ValveOpDir)
      annotation (Line(points={{-235,-266},{-235,-234},{-235,-114.335},{-212.45,-114.335}}, color={0,0,127}));
    connect(ValveOpDirSupp, dividerUnit.ValveOpDir) annotation (Line(points={{-235,-266},{-235,70.1},{-211.5,70.1}}, color={0,0,127}));
    connect(ValveOpIndirSupp, collectorUnit.ValveOpIndir)
      annotation (Line(points={{-208,-266},{-208,-148},{-226,-148},{-226,-117.555},{-212.45,-117.555}}, color={0,0,127}));
    connect(dividerUnit.ValveOpIndir, ValveOpIndirSupp)
      annotation (Line(points={{-211.5,67.3},{-226,67.3},{-226,-148},{-208,-148},{-208,-266}}, color={0,0,127}));
    connect(HPevaMF, HpStg1.m_flow_in) annotation (Line(points={{-182,-266},{-182,-62.32},{-190.6,-62.32}}, color={0,0,127}));
    connect(HPcondMF, Stg2Hp.m_flow_in)
      annotation (Line(points={{-156,-266},{-156,-266},{-156,-232},{-156,-104},{-156,-88},{-124.82,-88},{-124.82,-79.9}}, color={0,0,127}));
    connect(DirSuppMF, Stg2Stg1.m_flow_in) annotation (Line(points={{-128,-266},
            {-128,-266},{-128,-220},{-92.82,-220},{-92.82,-133.9}}, color={0,0,
            127}));
    connect(rpmHP, heatPump.N_in) annotation (Line(points={{-178,346},{-178,-10}}, color={0,0,127}));
    connect(OnOffHP, heatPump.onOff_in) annotation (Line(points={{-206,346},{-206,346},{-206,116},{-186,116},{-186,-10}}, color={255,0,255}));
    connect(NetworkPresRise, Replaceable2.dp_in) annotation (Line(points={{-67,344},{-67,344},{-67,92},{-5.26,92},{-5.26,77.6}}, color={0,0,127}));
    connect(TempCondOut.T, fromKelvin3.Kelvin) annotation (Line(points={{-118,23},{-119,23},{-119,90},{-119,293},{-443.8,293}}, color={0,0,127}));
    connect(fromKelvin3.Celsius, HPCondTemp) annotation (Line(points={{-469.1,293},{-469.1,293},{-515,293}}, color={0,0,127}));
    connect(fromKelvin1.Kelvin, bufferStorage.TTop) annotation (Line(points={{-443.8,321},{-78,321},{-78,-3.66},{-66,-3.66}}, color={0,0,127}));
    connect(heatStorageSolarColl.StgTempTop, fromKelvin2.Kelvin)
      annotation (Line(points={{-285.12,-18.69},{-272,-18.69},{-272,-6},{-290,-6},{-290,255},{-443.8,255}}, color={0,0,127}));
    connect(fromKelvin2.Celsius, TopTempSeasStg) annotation (Line(points={{-469.1,255},{-469.1,255},{-515,255}}, color={0,0,127}));
    connect(fromKelvin4.Celsius, BottTempSeasStg) annotation (Line(points={{-469.1,218},{-469.1,218},{-515,218}}, color={0,0,127}));
    connect(heatStorageSolarColl.StgTempBott, fromKelvin4.Kelvin)
      annotation (Line(points={{-284.68,-51.49},{-278,-51.49},{-278,-10},{-296,-10},{-296,218},{-443.8,218}}, color={0,0,127}));
    connect(fromKelvin1.Celsius, TopTempBuffStg) annotation (Line(points={{-469.1,321},{-478,321},{-478,329},{-515,329}}, color={0,0,127}));
    connect(heatStorageSolarColl.TempSolCollFlow, fromKelvin5.Kelvin)
      annotation (Line(points={{-331.32,-51.9},{-344,-51.9},{-344,180},{-443.8,180}}, color={0,0,127}));
    connect(fromKelvin5.Celsius, flowTempSolCir) annotation (Line(points={{-469.1,180},{-515,180},{-515,178}}, color={0,0,127}));
    connect(fromKelvin6.Celsius, flowTempSDH) annotation (Line(points={{-469.1,138},{-517,138}}, color={0,0,127}));
    connect(FlowTempSDH.T, fromKelvin6.Kelvin) annotation (Line(points={{236.5,75.2},{236.5,100},{-368,100},{-368,138},{-443.8,138}}, color={0,0,127}));
    connect(ValveOpAuxValve, AuxValve.y) annotation (Line(points={{-35,343},{-35,114},{64,114},{64,78.8}}, color={0,0,127}));
    connect(ValveOpBypValve, BypassValve.y) annotation (Line(points={{-5,343},{-5,104},{44,104},{44,38},{90.25,38},{90.25,30.75}}, color={0,0,127}));
    connect(Replaceable5.port_a, port_a) annotation (Line(
        points={{306,-122},{363,-122},{363,-121}},
        color={0,127,255},
        thickness=1));
    connect(Replaceable1.port_b, port_b) annotation (Line(
        points={{303.455,62},{303.455,62},{362,62}},
        color={0,127,255},
        thickness=1));
    connect(Replaceable1.X_ref[1], xRefWater.y);
    connect(Replaceable1.p_ref, Pressure1.y);
    connect(Replaceable1.T_ref, Toutdoor);
    connect(Replaceable3.X_ref[1], xRefWater.y);
    connect(Replaceable3.p_ref, Pressure1.y);
    connect(Replaceable3.T_ref, Toutdoor);
    connect(Replaceable4.X_ref[1], xRefWater.y);
    connect(Replaceable4.p_ref, Pressure1.y);
    connect(Replaceable4.T_ref, Toutdoor);
    connect(Replaceable5.X_ref[1], xRefWater.y);
    connect(Replaceable5.p_ref, Pressure1.y);
    connect(Replaceable5.T_ref, Toutdoor);
    connect(solarCollector.T_air, Toutdoor) annotation (Line(points={{-415.2,43.56},{-416,43.56},{-416,-32},{-496,-32}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      Documentation(info="<html>
<h4>Overview</h4>
<p>This model represents a heat generation unit in a solar district heating network. For the model, required control input connectors are included. The main components of the heat generation unit are:</p>
<ol>
<li>Heat pump</li>
<li>Combined heat and power (CHP) unit</li>
<li>Solar collectors</li>
<li>Seasonal heat storage</li>
<li>Buffer storage</li>
</ol>
<h4>Concept</h4>
<p>The solar heat gained from the solar collectors is supplied to the seasonal heat storage by means of a heat exchanger. The stored heat in the seasonal heat storage is exclusively solar heat from the collectors. The seasonal heat storage is either connected to the buffer storage or to the heat pump, depending on the current operation mode. The heat pump, which is the heart of the heat generation unit, provides heating energy for the heat consumers. For peak shifting purposes, the heat supplied from the top of the seasonal heat storage or from the heat pump are both loaded into the buffer storage and from there the heat is delivered into the district heating network. If the heat pump does not cover the heat demand of the consumers, an auxiliary heat exchanger will be used as a back-up system to compensate the temperature difference between the desired flow temperature and the flow temperature of the heat generation unit.</p>
</html>",   revisions="<html>
<ul>
<li><i>June 19, 2017&nbsp;</i> by Farid Davani:<br/>First implementation of a solar district heating system<
</ul>
</html>"));
  end SolarDistrictHeating;

  model SolarDistrictHeatingController
    "Controller model for solar district heating "

    ExergyBasedControl.DistrictHeating.HeatGeneratorUnit.Controller.StgCirController_TempBased
      stgCirController_TempBased
      annotation (Placement(transformation(extent={{-8,-4},{22,20}})));
    ExergyBasedControl.DistrictHeating.HeatGeneratorUnit.Controller.SolCirController_TempIrradBased
      solCirController_TempIrradBased
      annotation (Placement(transformation(extent={{-64,16},{-28,42}})));
    Modelica.Blocks.Interfaces.RealInput CurrIrrad "measured irradiation"
      annotation (Placement(transformation(extent={{-124,34},{-88,70}}),
          iconTransformation(extent={{-122,30},{-100,52}})));
    Modelica.Blocks.Interfaces.RealInput SeasStgBotTemp
      "Storage temperature at the bottom" annotation (Placement(transformation(
            extent={{-124,-40},{-88,-4}}), iconTransformation(extent={{-122,-12},
              {-100,10}})));
    Modelica.Blocks.Interfaces.RealInput FlowTempSol
      "Solar flow temperature in C" annotation (Placement(transformation(extent={{-124,
              -14},{-88,22}}),      iconTransformation(extent={{-122,-56},{-100,
              -34}})));
    Modelica.Blocks.Interfaces.RealInput AmbTemp "ambient temperature in C"
      annotation (Placement(transformation(extent={{-124,10},{-88,46}}),
          iconTransformation(extent={{-122,10},{-100,32}})));
    Modelica.Blocks.Interfaces.RealOutput MFSolCirPump annotation (Placement(
          transformation(extent={{176,64},{200,88}}),iconTransformation(extent={{188,62},
              {206,80}})));
    Modelica.Blocks.Interfaces.RealOutput MFStgCirPump annotation (Placement(
          transformation(extent={{176,46},{200,70}}),  iconTransformation(
            extent={{188,44},{206,62}})));
    Modelica.Blocks.Interfaces.BooleanOutput SolColPump annotation (Placement(
          transformation(extent={{-12,-12},{12,12}},
          rotation=90,
          origin={50,82}),                           iconTransformation(extent={{-12,-12},
              {12,12}},
          rotation=90,
          origin={26,80})));
    Modelica.Blocks.Interfaces.BooleanOutput StgCirPump annotation (Placement(
          transformation(extent={{-12,-12},{12,12}},
          rotation=90,
          origin={72,82}),                             iconTransformation(
            extent={{-12,-12},{12,12}},
          rotation=90,
          origin={54,80})));
    Modelica.Blocks.Interfaces.RealInput SeasStgTopTemp
      "Storage temperature at the top" annotation (Placement(transformation(
            extent={{-126,-66},{-88,-28}}), iconTransformation(extent={{-122,
              -34},{-100,-12}})));
    Modelica.Blocks.Interfaces.RealInput setPointBuffStg
      "Set point temperature of buffer storage in [°C]"
                                                annotation (Placement(
          transformation(extent={{-125,58},{-87,96}}), iconTransformation(
            extent={{-122,52},{-100,74}})));
    Modelica.Blocks.Interfaces.RealOutput ValveOpIndir annotation (Placement(
          transformation(extent={{176,13},{200,37}}),  iconTransformation(
            extent={{188,9},{206,26}})));
    Modelica.Blocks.Interfaces.RealOutput ValveOpDir annotation (Placement(
          transformation(extent={{176,30},{200,54}}),iconTransformation(extent={{188,26},
              {206,44}})));
    ExergyBasedControl.DistrictHeating.HeatGeneratorUnit.Controller.StorageController_v2
      stateMachine
      annotation (Placement(transformation(extent={{-8,-52},{22,-28}})));
    Modelica.Blocks.Interfaces.RealOutput EvaMF
      annotation (Placement(transformation(extent={{176,-2},{200,22}}),
          iconTransformation(extent={{188,-10},{206,8}})));
    Modelica.Blocks.Interfaces.RealOutput ConMF
      annotation (Placement(transformation(extent={{176,-18},{200,6}}),
          iconTransformation(extent={{188,-28},{206,-10}})));
    Modelica.Blocks.Interfaces.RealOutput DirSuppMF
      annotation (Placement(transformation(extent={{176,-34},{200,-10}}),
          iconTransformation(extent={{188,-46},{206,-28}})));
    Modelica.Blocks.Interfaces.RealInput TopTempBuffStg
      "Top temperature of the buffer storage in [°C]" annotation (Placement(
          transformation(
          extent={{-19,-19},{19,19}},
          rotation=90,
          origin={-67,-85}), iconTransformation(
          extent={{-11,-11},{11,11}},
          rotation=270,
          origin={-73,74})));
    Modelica.Blocks.Interfaces.BooleanOutput hpSignal
      "OnOff signal of the heat pump" annotation (Placement(transformation(
          extent={{-12,-12},{12,12}},
          rotation=270,
          origin={16,-86}), iconTransformation(
          extent={{-11,-11},{11,11}},
          rotation=270,
          origin={25,-77})));
    Modelica.Blocks.Interfaces.BooleanOutput DirSupp annotation (Placement(
          transformation(
          extent={{-12,-12},{12,12}},
          rotation=270,
          origin={-2,-86}), iconTransformation(
          extent={{-11,-11},{11,11}},
          rotation=270,
          origin={-1,-77})));
    Modelica.Blocks.Interfaces.RealOutput hpRPM annotation (Placement(
          transformation(
          extent={{-12,-12},{12,12}},
          rotation=270,
          origin={36,-86}), iconTransformation(
          extent={{-11,-11},{11,11}},
          rotation=270,
          origin={51,-77})));
    Modelica.Blocks.Interfaces.RealInput hpCondTemp
      "Flow temperature of condensator in C" annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={-22,-85}), iconTransformation(
          extent={{-11,-11},{11,11}},
          rotation=0,
          origin={-111,-65})));
    ExergyBasedControl.DistrictHeating.HeatGeneratorUnit.Controller.CHP_Controller
      BackupSystemController
      annotation (Placement(transformation(extent={{62,-26},{104,4}})));
    Modelica.Blocks.Interfaces.RealInput FlowTempSDH
      "Flow temperature of the solar district heating network in [°C]"
      annotation (Placement(transformation(extent={{-127,-94},{-87,-54}}),
          iconTransformation(extent={{-11,-10.5},{11,10.5}},
          rotation=270,
          origin={-49,74.5})));
    Modelica.Blocks.Interfaces.RealOutput valOpBypass annotation (Placement(
          transformation(extent={{176,-56},{200,-32}}), iconTransformation(
            extent={{188,-64},{206,-46}})));
    Modelica.Blocks.Interfaces.RealOutput valOpAux annotation (Placement(
          transformation(extent={{176,-74},{200,-50}}), iconTransformation(
            extent={{188,-82},{206,-64}})));
  equation
    connect(CurrIrrad, solCirController_TempIrradBased.CurrIrradiation)
      annotation (Line(points={{-106,52},{-82,52},{-82,35.89},{-63.8875,35.89}},
          color={0,0,127}));
    connect(AmbTemp, solCirController_TempIrradBased.ambTemp) annotation (Line(
          points={{-106,28},{-82,28},{-82,31.47},{-63.8875,31.47}},
                                                                  color={0,0,
            127}));
    connect(FlowTempSol, solCirController_TempIrradBased.FlowTempSol)
      annotation (Line(points={{-106,4},{-106,10},{-78,10},{-78,26.53},{
            -63.8875,26.53}}, color={0,0,127}));
    connect(SeasStgBotTemp, solCirController_TempIrradBased.StgTempBott)
      annotation (Line(points={{-106,-22},{-72,-22},{-72,21.85},{-63.8875,21.85}},
          color={0,0,127}));
    connect(FlowTempSol, stgCirController_TempBased.FlowTempSol) annotation (
        Line(points={{-106,4},{-40,4},{-40,7.76},{-7.1,7.76}},     color={0,0,
            127}));
    connect(SeasStgBotTemp, stgCirController_TempBased.StgTempBott) annotation (
       Line(points={{-106,-22},{-24,-22},{-24,3.92},{-7.1,3.92}}, color={0,0,
            127}));
    connect(solCirController_TempIrradBased.MFSolColPump, MFSolCirPump)
      annotation (Line(points={{-27.8875,29},{130,29},{130,76},{188,76}},
                                                                        color={
            0,0,127}));
    connect(setPointBuffStg, stateMachine.setPointStg2) annotation (Line(points={{-106,77},
            {-76,77},{-76,-30.72},{-7.68421,-30.72}},           color={0,0,127}));
    connect(SeasStgTopTemp, stateMachine.Stg1TopTemp) annotation (Line(points={{-107,
            -47},{-58,-47},{-58,-34.4},{-7.76316,-34.4}},       color={0,0,127}));
    connect(stateMachine.ValveOpDir, ValveOpDir) annotation (Line(points={{22.3947,
            -31.28},{144,-31.28},{144,42},{188,42}},
                                                   color={0,0,127}));
    connect(stateMachine.ValveOpIndir, ValveOpIndir) annotation (Line(points={{22.5526,
            -37.84},{148,-37.84},{148,25},{188,25}}, color={0,0,127}));
    connect(TopTempBuffStg, stateMachine.Stg2TopTemp) annotation (Line(points={{-67,-85},
            {-67,-60},{-24,-60},{-24,-28.48},{-7.68421,-28.48}},
          color={0,0,127}));
    connect(stateMachine.MFDirSupp, DirSuppMF) annotation (Line(points={{22.3947,
            -33.68},{130,-33.68},{130,-22},{188,-22}},
                                             color={0,0,127}));
    connect(stateMachine.IndirSuppSignal, hpSignal) annotation (Line(points={{11.5789,
            -51.84},{11.5789,-64},{16,-64},{16,-86}},         color={255,0,255}));
    connect(stateMachine.DirSuppSignal, DirSupp) annotation (Line(points={{8.89474,
            -51.84},{8.89474,-64},{-2,-64},{-2,-86}}, color={255,0,255}));
    connect(solCirController_TempIrradBased.OnOffSolPump, SolColPump) annotation (
       Line(points={{-27.8875,36.15},{-27.8875,36},{14,36},{14,62},{50,62},{50,82}},
          color={255,0,255}));
    connect(stgCirController_TempBased.OnOffStgCirPump, StgCirPump) annotation (
        Line(points={{22.75,11.72},{22.75,12},{72,12},{72,82}}, color={255,0,255}));
    connect(stgCirController_TempBased.OnOffSolPump, SolColPump) annotation (Line(
          points={{-7.1,11.6},{-14,11.6},{-14,36},{14,36},{14,62},{50,62},{50,82}},
          color={255,0,255}));
    connect(stateMachine.CompRPM, hpRPM) annotation (Line(points={{22.3158,
            -50.24},{36,-50.24},{36,-86}}, color={0,0,127}));
    connect(hpCondTemp, stateMachine.HPCondTemp) annotation (Line(points={{-22,-85},
            {-22,-49.28},{-8,-49.28}},      color={0,0,127}));
    connect(stateMachine.evaMF, EvaMF) annotation (Line(points={{22.5526,-40.24},
            {156,-40.24},{156,10},{188,10}}, color={0,0,127}));
    connect(stateMachine.conMF, ConMF) annotation (Line(points={{22.7105,-46},{
            150,-46},{150,-6},{188,-6}}, color={0,0,127}));
    connect(stgCirController_TempBased.MFStgCirPump, MFStgCirPump) annotation (
        Line(points={{22.75,8},{138,8},{138,58},{188,58}},
                                                         color={0,0,127}));
    connect(setPointBuffStg, BackupSystemController.buffStgSetpoint)
      annotation (Line(points={{-106,77},{-56,77},{-56,44},{52,44},{52,-2.45},{
            62.825,-2.45}}, color={0,0,127}));
    connect(FlowTempSDH, BackupSystemController.FlowTempSDH) annotation (Line(
          points={{-107,-74},{-94,-74},{-84,-74},{-84,-11},{62.825,-11}}, color=
           {0,0,127}));
    connect(TopTempBuffStg, BackupSystemController.buffStgTopTemp) annotation (
        Line(points={{-67,-85},{-67,-19.25},{63.125,-19.25}}, color={0,0,127}));
    connect(BackupSystemController.BypassValve, valOpBypass) annotation (Line(
          points={{104.45,-4.325},{164,-4.325},{164,-44},{188,-44}}, color={0,0,
            127}));
    connect(BackupSystemController.AuxValve, valOpAux) annotation (Line(points=
            {{104.45,-11},{130,-11},{130,-62},{188,-62}}, color={0,0,127}));
    connect(DirSuppMF, DirSuppMF) annotation (Line(points={{188,-22},{184,-22},
            {184,-22},{188,-22}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,
              -80},{200,80}}), graphics={Rectangle(
            extent={{-120,80},{200,-80}},
            lineColor={0,0,0},
            fillColor={66,143,244},
            fillPattern=FillPattern.Solid), Text(
            extent={{26,4},{64,-22}},
            lineColor={255,255,255},
            textString="%name
")}),                                         Diagram(coordinateSystem(
            preserveAspectRatio=false, extent={{-120,-80},{200,80}}), graphics={
            Rectangle(
            extent={{-38,80},{28,72}},
            lineColor={33,130,241},
            fillColor={170,213,255},
            fillPattern=FillPattern.Solid),
            Text(
            extent={{-30,82},{22,64}},
            lineColor={0,0,255},
            fillColor={202,234,243},
            fillPattern=FillPattern.Solid,
            textString="***All temperature inputs should be in Celcius*** 

")}), Documentation(info="<html>
<h4>Overview</h4>
<p>This model represents a mode-based controller for the heat generation unit. The controller comprises following blocks: </p>
<ol>
<li>&QUOT;Solar circuit controller&QUOT; block which controls the pump in the solar circuit</li>
<li>&QUOT;Storage circuit controller&QUOT; block which controls the pump in the seasonal storage circuit</li>
<li>&QUOT;StateMachine&QUOT; block in which operation modes are defined</li>
<li>&QUOT;BackupSystemController&QUOT; block which controls control vavles after the buffer storage  </li>
</ol>
</html>"));
  end SolarDistrictHeatingController;

  package Examples "Collection of models that illustrate model use and test models"
  extends Modelica.Icons.ExamplesPackage;

    model SolarDistrictHeating "Example that illustrates use of solar district heating model"

        replaceable package Medium = AixLib.Media.Water;
        extends Modelica.Icons.Example;

      ExergyBasedControl.DistrictHeating.DistrictHeating_ExergyAnalysis.AixLib_SolarDistrictHeating solarDistrictHeating
        annotation (Placement(transformation(extent={{-18,4},{30,36}})));
      ExergyBasedControl.DistrictHeating.DistrictHeating_ExergyAnalysis.AixLib_SolarDistrictHeatingController solarDistrictHeatingController
        annotation (Placement(transformation(extent={{-46,-46},{-8,-20}})));
      AixLib.Fluid.Sources.Boundary_pT Sink(          redeclare package Medium =
                   Medium, nPorts=1)
                           annotation (Placement(
            transformation(
            extent={{-8,-8},{8,8}},
            rotation=180,
            origin={60,34})));
      AixLib.Fluid.Sources.Boundary_pT Source(
        redeclare package Medium = Medium,
        nPorts=1,
        T=303.15) annotation (Placement(transformation(
            extent={{-8,-8},{8,8}},
            rotation=180,
            origin={60,4})));
      Modelica.Blocks.Sources.CombiTimeTable WeatherData(
        tableOnFile=true,
        extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
        columns=2:3,
        tableName="WeatherData04150419",
        fileName=
            "N:/Forschung/EBC0155_PtJ_Exergiebasierte_regelung_rsa/Students/pma-fda/Masterarbeit/MonitoringData/WeatherData04150419/WeatherData04150419.mat")
        annotation (Placement(transformation(
            extent={{-9,-9},{9,9}},
            rotation=0,
            origin={-66,9})));
      Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin2 annotation (
          Placement(transformation(
            extent={{4,-4.5},{-4,4.5}},
            rotation=180,
            origin={-28,10.5})));
      Modelica.Blocks.Sources.Step     BuffStgSetpoint(
        startTime=43200,
        offset=50,
        height=10)
        annotation (Placement(transformation(extent={{-72,-28},{-60,-16}})));
      Modelica.Blocks.Sources.Constant flowTempCHP(k=273.15 + 80)
        annotation (Placement(transformation(extent={{-36,42},{-24,54}})));
      Modelica.Blocks.Sources.Constant PressureRise(k=50000) annotation (Placement(
            transformation(
            extent={{-6,-6},{6,6}},
            rotation=180,
            origin={34,-10})));
    equation
      connect(Source.ports[1], solarDistrictHeating.port_a) annotation (Line(points={{52,4},{
              44,4},{44,9.33333},{30.1674,9.33333}},         color={0,127,255}));
      connect(Sink.ports[1], solarDistrictHeating.port_b) annotation (Line(points={{52,34},
              {44,34},{44,28.8533},{30,28.8533}},        color={0,127,255}));
      connect(solarDistrictHeating.flowTempSolCir, solarDistrictHeatingController.FlowTempSol)
        annotation (Line(points={{-18.5581,31.9467},{-86,31.9467},{-86,-40.3125},
              {-44.9312,-40.3125}},
                          color={0,0,127}));
      connect(solarDistrictHeating.TopTempSeasStg, solarDistrictHeatingController.SeasStgTopTemp)
        annotation (Line(points={{-18.5581,29.3867},{-82,29.3867},{-82,-36.7375},
              {-44.9312,-36.7375}},
                          color={0,0,127}));
      connect(solarDistrictHeating.BottTempSeasStg, solarDistrictHeatingController.SeasStgBotTemp)
        annotation (Line(points={{-18.5581,26.72},{-78,26.72},{-78,-33.1625},{
              -44.9312,-33.1625}},
                          color={0,0,127}));
      connect(solarDistrictHeating.TopTempBuffStg, solarDistrictHeatingController.TopTempBuffStg)
        annotation (Line(points={{-18.5581,24.16},{-40.4188,24.16},{-40.4188,
              -20.975}},
            color={0,0,127}));
      connect(solarDistrictHeating.flowTempSDH, solarDistrictHeatingController.FlowTempSDH)
        annotation (Line(points={{-18.5581,21.4933},{-37.5688,21.4933},{
              -37.5688,-20.8937}},
            color={0,0,127}));
      connect(solarDistrictHeating.HPCondTemp, solarDistrictHeatingController.hpCondTemp)
        annotation (Line(points={{-18.5581,34.4},{-90,34.4},{-90,-43.5625},{
              -44.9312,-43.5625}},
                          color={0,0,127}));
      connect(solarDistrictHeatingController.MFSolCirPump, solarDistrictHeating.SolarCirPumpMF)
        annotation (Line(points={{-8.35625,-21.4625},{0.474419,-21.4625},{
              0.474419,4.8}},
            color={0,0,127}));
      connect(solarDistrictHeatingController.MFStgCirPump, solarDistrictHeating.SeasStgCirPumpMF)
        annotation (Line(points={{-8.35625,-24.3875},{-6,-24.3875},{-6,-16},{
              -9.46047,-16},{-9.46047,4.8}},
                                    color={0,0,127}));
      connect(solarDistrictHeatingController.ValveOpDir, solarDistrictHeating.ValveOpDirSupp)
        annotation (Line(points={{-8.35625,-27.3125},{-2.87442,-27.3125},{
              -2.87442,4.8}},
            color={0,0,127}));
      connect(solarDistrictHeatingController.ValveOpIndir, solarDistrictHeating.ValveOpIndirSupp)
        annotation (Line(points={{-8.35625,-30.1563},{4,-30.1563},{4,-2},{
              -6.22326,-2},{-6.22326,4.8}},
                               color={0,0,127}));
      connect(solarDistrictHeatingController.EvaMF, solarDistrictHeating.HPevaMF)
        annotation (Line(points={{-8.35625,-33.1625},{16.6605,-33.1625},{
              16.6605,4.90667}},
            color={0,0,127}));
      connect(solarDistrictHeatingController.ConMF, solarDistrictHeating.HPcondMF)
        annotation (Line(points={{-8.35625,-36.0875},{13.4233,-36.0875},{
              13.4233,4.90667}},
            color={0,0,127}));
      connect(solarDistrictHeatingController.DirSuppMF, solarDistrictHeating.DirSuppMF)
        annotation (Line(points={{-8.35625,-39.0125},{10.1302,-39.0125},{
              10.1302,4.90667}},
            color={0,0,127}));
      connect(solarDistrictHeatingController.valOpBypass, solarDistrictHeating.ValveOpBypValve)
        annotation (Line(points={{-8.35625,-41.9375},{84,-41.9375},{84,52},{
              4.3814,52},{4.3814,35.6267}},
                                 color={0,0,127}));
      connect(solarDistrictHeatingController.valOpAux, solarDistrictHeating.ValveOpAuxValve)
        annotation (Line(points={{-8.35625,-44.8625},{88,-44.8625},{88,56},{
              7.50698,56},{7.50698,35.6267}},
                                      color={0,0,127}));
      connect(solarDistrictHeatingController.hpRPM, solarDistrictHeating.rpmHP)
        annotation (Line(points={{-25.6938,-45.5125},{-25.6938,-52},{94,-52},{
              94,62},{-0.195349,62},{-0.195349,35.6267}},
                                                   color={0,0,127}));
      connect(solarDistrictHeatingController.hpSignal, solarDistrictHeating.OnOffHP)
        annotation (Line(points={{-28.7813,-45.5125},{-28.7813,-56},{98,-56},{
              98,66},{-3.32093,66},{-3.32093,35.6267}},
                                                 color={255,0,255}));
      connect(WeatherData.y[2], solarDistrictHeating.Irradiation) annotation (Line(
            points={{-56.1,9},{-48,9},{-48,18.2933},{-17.7767,18.2933}}, color={0,0,
              127}));
      connect(WeatherData.y[1], toKelvin2.Celsius) annotation (Line(points={{-56.1,9},
              {-36,9},{-36,10.5},{-32.8,10.5}}, color={0,0,127}));
      connect(toKelvin2.Kelvin, solarDistrictHeating.Toutdoor) annotation (Line(
            points={{-23.6,10.5},{-20,10.5},{-20,16.16},{-17.7767,16.16}}, color={0,
              0,127}));
      connect(WeatherData.y[2], solarDistrictHeatingController.CurrIrrad)
        annotation (Line(points={{-56.1,9},{-52,9},{-52,-26.3375},{-44.9312,
              -26.3375}},
            color={0,0,127}));
      connect(WeatherData.y[1], solarDistrictHeatingController.AmbTemp) annotation (
         Line(points={{-56.1,9},{-52,9},{-52,-29.5875},{-44.9312,-29.5875}}, color={
              0,0,127}));
      connect(BuffStgSetpoint.y, solarDistrictHeatingController.setPointBuffStg)
        annotation (Line(points={{-59.4,-22},{-44.9312,-22},{-44.9312,-22.7625}},
            color={0,0,127}));
      connect(flowTempCHP.y, solarDistrictHeating.cHPflowTempSetpoint) annotation (
          Line(points={{-23.4,48},{17.0512,48},{17.0512,35.4667}}, color={0,0,127}));
      connect(PressureRise.y, solarDistrictHeating.NetworkPresRise) annotation (
          Line(points={{27.4,-10},{6.89302,-10},{6.89302,4.90667}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(StopTime=86400));
    end SolarDistrictHeating;
  end Examples;
end DistrictHeating;
