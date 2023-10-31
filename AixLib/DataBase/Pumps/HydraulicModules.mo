within AixLib.DataBase.Pumps;
package HydraulicModules "Basic Hydraulic Systems without controller"
  extends Modelica.Icons.VariantsPackage;

  model Admix "Admix circuit with three way valve and pump"
    extends
      AixLib.DataBase.Pumps.HydraulicModules.BaseClasses.PartialHydraulicModule;

    parameter Modelica.Units.SI.Volume vol=0.0005 "Mixing Volume"
      annotation (Dialog(tab="Advanced"));

    parameter Fluid.Actuators.Valves.Data.GenericThreeWay valveCharacteristic "Valve characteristic of three way valve"
      annotation (choicesAllMatching=true,Placement(transformation(extent={{-120,-120},{-100,-100}})),Dialog(group="Actuators"));
                                                                             // = AixLib.Fluid.Actuators.Valves.Data.LinearEqualPercentage()

    Fluid.Actuators.Valves.ThreeWayTable valve(
      order=1,
      init=Modelica.Blocks.Types.Init.InitialState,
      CvData=AixLib.Fluid.Types.CvTypes.Kv,
      redeclare package Medium = Medium,
      T_start=T_start,
      y_start=0,
      tau=0.2,
      final m_flow_nominal=m_flow_nominal,
      final energyDynamics=energyDynamics,
      Kv=Kv,
      dpFixed_nominal={10,10},
      final flowCharacteristics1=valveCharacteristic.a_ab,
      final flowCharacteristics3=valveCharacteristic.b_ab) annotation (Dialog(
          enable=true, group="Actuators"), Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-30,20})));
    Fluid.FixedResistances.GenericPipe  pipe1(
      redeclare final package Medium = Medium,
      pipeModel=pipeModel,
      T_start=T_start,
      final m_flow_nominal=m_flow_nominal,
      final allowFlowReversal=allowFlowReversal,
      length=length,
      parameterPipe=parameterPipe,
      parameterIso=parameterIso,
      final hCon=hCon,
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics)           annotation (Dialog(enable=true,
          group="Pipes"), Placement(transformation(extent={{-78,28},{-62,12}})));
    Fluid.FixedResistances.GenericPipe  pipe2(
      redeclare final package Medium = Medium,
      pipeModel=pipeModel,
      T_start=T_start,
      final m_flow_nominal=m_flow_nominal,
      final allowFlowReversal=allowFlowReversal,
      length=length,
      parameterPipe=parameterPipe,
      parameterIso=parameterIso,
      final hCon=hCon,
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics)           annotation (Dialog(enable=true,
          group="Pipes"), Placement(transformation(extent={{-8,28},{8,12}})));
    Fluid.FixedResistances.GenericPipe  pipe3(
      redeclare final package Medium = Medium,
      pipeModel=pipeModel,
      T_start=T_start,
      final m_flow_nominal=m_flow_nominal,
      final allowFlowReversal=allowFlowReversal,
      length=length,
      parameterPipe=parameterPipe,
      parameterIso=parameterIso,
      final hCon=hCon,
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics)           annotation (Dialog(enable=true,
          group="Pipes"), Placement(transformation(extent={{60,28},{76,12}})));
    Fluid.FixedResistances.GenericPipe  pipe4(
      redeclare final package Medium = Medium,
      pipeModel=pipeModel,
      T_start=T_start,
      final m_flow_nominal=m_flow_nominal,
      final allowFlowReversal=allowFlowReversal,
      length=length,
      parameterPipe=parameterPipe,
      parameterIso=parameterIso,
      final hCon=hCon,
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics)           annotation (Dialog(enable=true,
          group="Pipes"), Placement(transformation(
          extent={{-8,8},{8,-8}},
          rotation=180,
          origin={32,-60})));
    Fluid.FixedResistances.GenericPipe  pipe5(
      redeclare final package Medium = Medium,
      pipeModel=pipeModel,
      T_start=T_start,
      final m_flow_nominal=m_flow_nominal,
      final allowFlowReversal=allowFlowReversal,
      length=length,
      parameterPipe=parameterPipe,
      parameterIso=parameterIso,
      final hCon=hCon,
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics)           annotation (Dialog(enable=true,
          group="Pipes"), Placement(transformation(
          extent={{-8,8},{8,-8}},
          rotation=180,
          origin={-58,-60})));
    Fluid.FixedResistances.GenericPipe  pipe6(
      redeclare final package Medium = Medium,
      pipeModel=pipeModel,
      T_start=T_start,
      final m_flow_nominal=m_flow_nominal,
      final allowFlowReversal=allowFlowReversal,
      length=length,
      parameterPipe=parameterPipe,
      parameterIso=parameterIso,
      final hCon=hCon,
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics)           annotation (Dialog(enable=true,
          group="Pipes"), Placement(transformation(
          extent={{-8,8},{8,-8}},
          rotation=90,
          origin={-30,-20})));
    Fluid.MixingVolumes.MixingVolume junc456(
      redeclare package Medium = Medium,
      final massDynamics=massDynamics,
      T_start=T_start,
      nPorts=3,
      final m_flow_nominal=m_flow_nominal,
      final V=vol,
      final energyDynamics=energyDynamics)
      annotation (Placement(transformation(extent={{-38,-60},{-22,-76}})));
    replaceable BaseClasses.BasicPumpInterface PumpInterface(
      redeclare package Medium = Medium,
      final allowFlowReversal=allowFlowReversal,
      final m_flow_nominal=m_flow_nominal,
      T_start=T_start,
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics)     "Needs to be redeclared" annotation (
      Dialog(group="Actuators"),
      choicesAllMatching=true,
      Placement(transformation(extent={{22,12},{38,28}})));

  equation

    connect(const.y, prescribedTemperature.T)
      annotation (Line(points={{55.2,-20},{49.6,-20}}, color={0,0,127}));
    connect(valve.port_2, pipe2.port_a)
      annotation (Line(points={{-20,20},{-8,20}}, color={0,127,255}));
    connect(valve.y, hydraulicBus.valveSet) annotation (Line(points={{-30,32},{-30,
            100},{-14,100},{-14,100.1},{0.1,100.1}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(valve.y_actual, hydraulicBus.valveMea) annotation (Line(points={{-25,
            27},{-25,100.5},{0.1,100.5},{0.1,100.1}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(pipe5.port_a,junc456. ports[1])
      annotation (Line(points={{-50,-60},{-31.0667,-60}}, color={0,127,255}));
    connect(pipe6.port_a,junc456. ports[2]) annotation (Line(points={{-30,-28},{
            -30,-44},{-30,-60},{-30,-60}},
                             color={0,127,255}));
    connect(pipe4.port_a, senT_a2.port_b)
      annotation (Line(points={{40,-60},{72,-60}}, color={0,127,255}));
    connect(pipe6.heatPort, prescribedTemperature.port)
      annotation (Line(points={{-22,-20},{32,-20}}, color={191,0,0}));
    connect(pipe2.heatPort, prescribedTemperature.port)
      annotation (Line(points={{0,12},{0,-4},{0,-20},{32,-20}}, color={191,0,0}));
    connect(pipe1.heatPort, prescribedTemperature.port) annotation (Line(points={{-70,12},
            {-70,6},{0,6},{0,-20},{32,-20}},     color={191,0,0}));
    connect(pipe3.heatPort, prescribedTemperature.port) annotation (Line(points={{68,
            12},{68,6},{0,6},{0,-20},{32,-20}}, color={191,0,0}));
    connect(pipe5.heatPort, prescribedTemperature.port) annotation (Line(points={{-58,-52},
            {-58,-48},{0,-48},{0,-20},{32,-20}},
                                               color={191,0,0}));
    connect(pipe4.heatPort, prescribedTemperature.port) annotation (Line(points={{32,
            -52},{32,-48},{0,-48},{0,-20},{32,-20}}, color={191,0,0}));
    connect(PumpInterface.pumpBus, hydraulicBus.pumpBus) annotation (Line(
        points={{30,28},{30,100.1},{0.1,100.1}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(PumpInterface.port_b, pipe3.port_a)
      annotation (Line(points={{38,20},{60,20}}, color={0,127,255}));
    connect(senT_a1.port_b,pipe1. port_a)
      annotation (Line(points={{-88,20},{-78,20}}, color={0,127,255}));
    connect(pipe1.port_b, valve.port_1)
      annotation (Line(points={{-62,20},{-40,20}}, color={0,127,255}));
    connect(pipe4.port_b, junc456.ports[3])
      annotation (Line(points={{24,-60},{-28.9333,-60}}, color={0,127,255}));
    connect(pipe5.port_b, senT_b2.port_a)
      annotation (Line(points={{-66,-60},{-78,-60}}, color={0,127,255}));
    connect(pipe2.port_b, PumpInterface.port_a) annotation (Line(points={{8,20},{
            16,20},{16,20},{22,20}}, color={0,127,255}));
    connect(pipe3.port_b, senT_b1.port_a)
      annotation (Line(points={{76,20},{88,20}}, color={0,127,255}));
    connect(pipe6.port_b, valve.port_3)
      annotation (Line(points={{-30,-12},{-30,10}}, color={0,127,255}));
    annotation (
      Icon(coordinateSystem(initialScale=0.1), graphics={
          Polygon(
            points={{-60,70},{-60,70}},
            lineColor={95,95,95},
            lineThickness=0.5,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{6,80},{46,40}},
            lineColor={135,135,135},
            lineThickness=0.5,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Line(
            points={{26,80},{46,60},{26,40}},
            color={135,135,135},
            thickness=0.5),
          Polygon(
            points={{-52,50},{-52,70},{-32,60},{-52,50}},
            lineColor={95,95,95},
            lineThickness=0.5,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-12,50},{-12,70},{-32,60},{-12,50}},
            lineColor={95,95,95},
            lineThickness=0.5,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{10,-10},{-10,-10},{0,10},{10,-10}},
            lineColor={95,95,95},
            lineThickness=0.5,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid,
            origin={-32,50},
            rotation=0),
          Line(
            points={{-32,40},{-32,-58}},
            color={0,128,255},
            thickness=0.5),
          Ellipse(
            extent={{-34,-58},{-30,-62}},
            lineColor={0,128,255},
            lineThickness=0.5,
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-92,60},{-76,42}},
            lineColor={135,135,135},
            textString="1"),
          Text(
            extent={{-12,60},{4,42}},
            lineColor={135,135,135},
            textString="2"),
          Text(
            extent={{48,60},{64,42}},
            lineColor={135,135,135},
            textString="3"),
          Text(
            extent={{18,-42},{34,-60}},
            lineColor={135,135,135},
            textString="4"),
          Text(
            extent={{-60,-42},{-44,-60}},
            lineColor={135,135,135},
            textString="5"),
          Text(
            extent={{-34,10},{-18,-8}},
            lineColor={135,135,135},
            textString="6")}),
      Diagram(coordinateSystem(extent={{-120,-120},{120,120}}, initialScale=0.1)),
      Documentation(info="<html><p>
  Admix circuit with a replaceable pump model for the distribution of
  hot or cold water. All sensor and actor values are connected to the
  hydraulic bus.
</p>
<h4>
  Characteristics
</h4>
<p>
  There is a connecting pipe between distributer and collector of
  manifold so that the pressure difference between them becomes
  insignificant. The main pump only works against the resistance in the
  main circuit.
</p>
<p>
  The mass flow in primary and secondary circuits stay constant.
</p>
<p>
  The scondary circuits do not affect each other when switching
  operational modes.
</p>
<ul>
  <li>August 09, 2018, by Alexander Kümpel:<br/>
    Extension from base PartioalHydraulicModuls
  </li>
  <li>October 25, 2017, by Alexander Kümpel:<br/>
    Transfer from ZUGABE to AixLib
  </li>
  <li>July 25, 2017 by Peter Matthes:<br/>
    Renames sensors and introduces PT1 behavior for temperature
    sensors. Adds sensors to icon.
  </li>
  <li>February 6, 2016, by Peter Matthes:<br/>
    First implementation
  </li>
</ul>
</html>",   revisions="<html><ul>
  <li>December 06, 2022, by EBC-Modelica group:<br/>
    Fixes to increase compatability to OpenModelica <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1378\">#1378</a>.
  </li>
  <li>2017-06 by Alexander Kümpel:<br/>
    Implemented
  </li>
</ul>
</html>"));
  end Admix;

  model Injection "Injection circuit with pump and three way valve"
    extends
      AixLib.DataBase.Pumps.HydraulicModules.BaseClasses.PartialHydraulicModule;

    parameter Fluid.Actuators.Valves.Data.GenericThreeWay valveCharacteristic "Valve characteristic of three way valve"
      annotation (choicesAllMatching=true,Placement(transformation(extent={{-120,-120},{-100,-100}})),Dialog(group="Actuators"));

    parameter Modelica.Units.SI.Volume vol=0.0005 "Mixing Volume"
      annotation (Dialog(tab="Advanced"));

    Fluid.Actuators.Valves.ThreeWayTable valve(
      order=1,
      init=Modelica.Blocks.Types.Init.InitialState,
      CvData=AixLib.Fluid.Types.CvTypes.Kv,
      redeclare package Medium = Medium,
      T_start=T_start,
      tau=0.2,
      final m_flow_nominal=m_flow_nominal,
      final energyDynamics=energyDynamics,
      y_start=0,
      Kv=Kv,
      dpFixed_nominal={10,10},
      flowCharacteristics1=valveCharacteristic.a_ab,
      flowCharacteristics3=valveCharacteristic.b_ab) annotation (Dialog(enable=
            true, group="Actuators"), Placement(transformation(
          extent={{8,8},{-8,-8}},
          rotation=0,
          origin={-40,-60})));

    Fluid.FixedResistances.GenericPipe  pipe1(
      redeclare package Medium = Medium,
      pipeModel=pipeModel,
      T_start=T_start,
      final m_flow_nominal=m_flow_nominal,
      final allowFlowReversal=allowFlowReversal,
      length=length,
      parameterPipe=parameterPipe,
      parameterIso=parameterIso,
      final hCon=hCon,
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics)           annotation (Dialog(enable=true,
          group="Pipes"), Placement(transformation(extent={{-80,28},{-66,12}})));

    Fluid.FixedResistances.GenericPipe  pipe2(
      redeclare package Medium = Medium,
      pipeModel=pipeModel,
      T_start=T_start,
      final m_flow_nominal=m_flow_nominal,
      final allowFlowReversal=allowFlowReversal,
      length=length,
      parameterPipe=parameterPipe,
      parameterIso=parameterIso,
      final hCon=hCon,
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics)           annotation (Dialog(enable=true,
          group="Pipes"), Placement(transformation(
          extent={{7,-8},{-7,8}},
          rotation=180,
          origin={-23,20})));
    Fluid.FixedResistances.GenericPipe  pipe3(
      redeclare package Medium = Medium,
      pipeModel=pipeModel,
      T_start=T_start,
      final m_flow_nominal=m_flow_nominal,
      final allowFlowReversal=allowFlowReversal,
      length=length,
      parameterPipe=parameterPipe,
      parameterIso=parameterIso,
      final hCon=hCon,
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics)           annotation (Dialog(enable=true,
          group="Pipes"), Placement(transformation(
          extent={{6,-8},{-6,8}},
          rotation=180,
          origin={30,20})));

    Fluid.FixedResistances.GenericPipe  pipe4(
      redeclare package Medium = Medium,
      pipeModel=pipeModel,
      T_start=T_start,
      final m_flow_nominal=m_flow_nominal,
      final allowFlowReversal=allowFlowReversal,
      length=length,
      parameterPipe=parameterPipe,
      parameterIso=parameterIso,
      final hCon=hCon,
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics)           annotation (Dialog(enable=true,
          group="Pipes"), Placement(transformation(extent={{74,28},{86,12}})));
    Fluid.FixedResistances.GenericPipe  pipe5(
      redeclare package Medium = Medium,
      pipeModel=pipeModel,
      T_start=T_start,
      final m_flow_nominal=m_flow_nominal,
      final allowFlowReversal=allowFlowReversal,
      length=length,
      parameterPipe=parameterPipe,
      parameterIso=parameterIso,
      final hCon=hCon,
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics)           annotation (Dialog(enable=true,
          group="Pipes"), Placement(transformation(extent={{60,-68},{40,-52}})));
      Fluid.FixedResistances.GenericPipe  pipe6(
      redeclare package Medium = Medium,
      pipeModel=pipeModel,
      T_start=T_start,
      final m_flow_nominal=m_flow_nominal,
      final allowFlowReversal=allowFlowReversal,
      length=length,
      parameterPipe=parameterPipe,
      parameterIso=parameterIso,
      final hCon=hCon,
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics)           annotation (Dialog(enable=true,
          group="Pipes"), Placement(transformation(extent={{0,-68},{-20,-52}})));

    Fluid.FixedResistances.GenericPipe  pipe7(
      redeclare package Medium = Medium,
      pipeModel=pipeModel,
      T_start=T_start,
      final m_flow_nominal=m_flow_nominal,
      final allowFlowReversal=allowFlowReversal,
      length=length,
      parameterPipe=parameterPipe,
      parameterIso=parameterIso,
      final hCon=hCon,
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics)           annotation (Dialog(enable=true,
          group="Pipes"), Placement(transformation(extent={{-60,-68},{-74,-52}})));
    Fluid.FixedResistances.GenericPipe  pipe8(
      redeclare package Medium = Medium,
      pipeModel=pipeModel,
      T_start=T_start,
      final m_flow_nominal=m_flow_nominal,
      allowFlowReversal=allowFlowReversal,
      length=length,
      parameterPipe=parameterPipe,
      parameterIso=parameterIso,
      final hCon=hCon,
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics)     annotation (Dialog(enable=true, group=
            "Pipes"), Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=-90,
          origin={-40,-20})));
    Fluid.FixedResistances.GenericPipe  pipe9(
      redeclare package Medium = Medium,
      pipeModel=pipeModel,
      T_start=T_start,
      final m_flow_nominal=m_flow_nominal,
      final allowFlowReversal=allowFlowReversal,
      length=length,
      parameterPipe=parameterPipe,
      parameterIso=parameterIso,
      final hCon=hCon,
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics)           annotation (Dialog(enable=true,
          group="Pipes"), Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=90,
          origin={16,-20})));

    Fluid.MixingVolumes.MixingVolume junc3v6(
      redeclare package Medium = Medium,
      final massDynamics=massDynamics,
      final T_start=T_start,
      final V=vol,
      final m_flow_nominal=m_flow_nominal,
      nPorts=3,
      final allowFlowReversal=allowFlowReversal,
      final energyDynamics=energyDynamics)
      annotation (Placement(transformation(extent={{12,-60},{20,-68}})));

    replaceable BaseClasses.BasicPumpInterface PumpInterface(
      redeclare package Medium = Medium,
      final allowFlowReversal=allowFlowReversal,
      final m_flow_nominal=m_flow_nominal,
      T_start=T_start,
      energyDynamics=energyDynamics,
      massDynamics=massDynamics)           "Needs to be redeclared" annotation (
      Dialog(group="Actuators"),
      choicesAllMatching=true,
      Placement(transformation(extent={{48,12},{64,28}})));

  protected
    Fluid.Sensors.VolumeFlowRate          VFSen_injection(redeclare package
        Medium = Medium, final allowFlowReversal=allowFlowReversal,
      final m_flow_nominal=m_flow_nominal)
      "Volume flow in injection line" annotation (Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=0,
          origin={0,20})));
    Fluid.MixingVolumes.MixingVolume junc15j(
      redeclare package Medium = Medium,
      final massDynamics=massDynamics,
      final V=vol,
      final T_start=T_start,
      final m_flow_nominal=m_flow_nominal,
      nPorts=3,
      final allowFlowReversal=allowFlowReversal,
      final energyDynamics=energyDynamics)
      annotation (Placement(transformation(extent={{-44,20},{-36,28}})));
    Fluid.MixingVolumes.MixingVolume juncjp6(
      redeclare package Medium = Medium,
      final massDynamics=massDynamics,
      final V=vol,
      final T_start=T_start,
      final m_flow_nominal=m_flow_nominal,
      nPorts=3,
      final allowFlowReversal=allowFlowReversal,
      final energyDynamics=energyDynamics)
      annotation (Placement(transformation(extent={{12,20},{20,28}})));

  equation
    connect(pipe7.port_a, valve.port_2)
      annotation (Line(points={{-60,-60},{-48,-60}}, color={0,127,255}));

    connect(PumpInterface.port_b, pipe4.port_a)
      annotation (Line(points={{64,20},{74,20}}, color={0,127,255}));
    connect(VFSen_injection.V_flow, hydraulicBus.VF_injection) annotation (Line(
          points={{0,28.8},{0,100}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));

    connect(PumpInterface.pumpBus, hydraulicBus.pumpBus) annotation (Line(
        points={{56,28},{56,100.1},{0.1,100.1}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(pipe8.heatPort, pipe9.heatPort)
      annotation (Line(points={{-32,-20},{8,-20}},  color={191,0,0}));
    connect(pipe2.port_a, junc15j.ports[1])
      annotation (Line(points={{-30,20},{-40.5333,20}},
                                                     color={0,127,255}));
    connect(VFSen_injection.port_b, juncjp6.ports[1])
      annotation (Line(points={{8,20},{15.4667,20}},
                                                color={0,127,255}));
    connect(pipe6.port_a, junc3v6.ports[1])
      annotation (Line(points={{0,-60},{15.4667,-60}},
                                                  color={0,127,255}));
    connect(juncjp6.ports[2], pipe3.port_a)
      annotation (Line(points={{16,20},{24,20}},   color={0,127,255}));
    connect(senT_a1.port_b, pipe1.port_a)
      annotation (Line(points={{-88,20},{-80,20}}, color={0,127,255}));
    connect(pipe5.port_a, senT_a2.port_b)
      annotation (Line(points={{60,-60},{72,-60}}, color={0,127,255}));
    connect(prescribedTemperature.port, pipe3.heatPort)
      annotation (Line(points={{32,-20},{30,-20},{30,12}},
                                                  color={191,0,0}));
    connect(pipe1.heatPort, pipe3.heatPort) annotation (Line(points={{-73,12},{
            -73,2},{30,2},{30,12}},
                                color={191,0,0}));
    connect(pipe2.heatPort, pipe3.heatPort) annotation (Line(points={{-23,12},{
            -23,2},{30,2},{30,12}},
                                color={191,0,0}));
    connect(pipe4.heatPort, pipe3.heatPort)
      annotation (Line(points={{80,12},{80,2},{30,2},{30,12}}, color={191,0,0}));
    connect(pipe7.heatPort, prescribedTemperature.port) annotation (Line(points={{-67,-52},
            {-67,-46},{30,-46},{30,-20},{32,-20}},
                                               color={191,0,0}));
    connect(pipe5.heatPort, prescribedTemperature.port) annotation (Line(points={{50,-52},
            {50,-46},{30,-46},{30,-20},{32,-20}},
                                              color={191,0,0}));
    connect(pipe6.heatPort, prescribedTemperature.port) annotation (Line(points={{-10,-52},
            {-10,-46},{30,-46},{30,-20},{32,-20}},
                                              color={191,0,0}));
    connect(valve.y, hydraulicBus.valveSet) annotation (Line(points={{-40,-69.6},
            {-40,-82},{-122,-82},{-122,100},{-60,100},{-60,100.1},{0.1,100.1}},
                                                            color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(valve.y_actual, hydraulicBus.valveMea) annotation (Line(points={{-44,
            -65.6},{-44,-82},{-122,-82},{-122,100},{-60,100},{-60,100.1},{0.1,
            100.1}},                                               color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(pipe1.port_b, junc15j.ports[2])
      annotation (Line(points={{-66,20},{-40,20}},   color={0,127,255}));
    connect(pipe2.port_b, VFSen_injection.port_a)
      annotation (Line(points={{-16,20},{-8,20}}, color={0,127,255}));
    connect(pipe3.port_b, PumpInterface.port_a)
      annotation (Line(points={{36,20},{48,20}}, color={0,127,255}));
    connect(pipe5.port_b, junc3v6.ports[2])
      annotation (Line(points={{40,-60},{16,-60}}, color={0,127,255}));
    connect(pipe6.port_b, valve.port_1)
      annotation (Line(points={{-20,-60},{-32,-60}}, color={0,127,255}));
    connect(pipe7.port_b, senT_b2.port_a)
      annotation (Line(points={{-74,-60},{-78,-60}}, color={0,127,255}));
    connect(pipe8.port_b, valve.port_3)
      annotation (Line(points={{-40,-28},{-40,-52}}, color={0,127,255}));
    connect(pipe9.port_b, juncjp6.ports[3]) annotation (Line(points={{16,-12},{16,
            20},{16.5333,20}},     color={0,127,255}));
    connect(pipe9.port_a, junc3v6.ports[3]) annotation (Line(points={{16,-28},{16,
            -60},{16.5333,-60}},       color={0,127,255}));
    connect(pipe4.port_b, senT_b1.port_a)
      annotation (Line(points={{86,20},{88,20}}, color={0,127,255}));
    connect(pipe8.port_a, junc15j.ports[3]) annotation (Line(points={{-40,-12},{
            -40,20},{-39.4667,20}}, color={0,127,255}));
    connect(pipe9.heatPort, prescribedTemperature.port) annotation (Line(points={
            {8,-20},{8,-34},{30,-34},{30,-20},{32,-20}}, color={191,0,0}));
    annotation (
      Icon(coordinateSystem(initialScale=0.1), graphics={
          Line(
            points={{-40,60},{-40,-40}},
            color={0,128,255},
            thickness=0.5),
          Polygon(
            points={{-66,-50},{-66,-50}},
            lineColor={95,95,95},
            lineThickness=0.5,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-60,-70},{-60,-50},{-40,-60},{-60,-70}},
            lineColor={95,95,95},
            lineThickness=0.5,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-20,-70},{-20,-50},{-40,-60},{-20,-70}},
            lineColor={95,95,95},
            lineThickness=0.5,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{10,10},{-10,10},{0,-10},{10,10}},
            lineColor={95,95,95},
            lineThickness=0.5,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid,
            origin={-40,-50},
            rotation=0),
          Ellipse(
            extent={{-42,62},{-38,58}},
            lineColor={0,128,255},
            lineThickness=0.5,
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Line(
            points={{2,60},{2,-58}},
            color={0,128,255},
            thickness=0.5),
          Ellipse(
            extent={{0,62},{4,58}},
            lineColor={0,128,255},
            lineThickness=0.5,
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{0,-58},{4,-62}},
            lineColor={0,128,255},
            lineThickness=0.5,
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{18,80},{58,40}},
            lineColor={135,135,135},
            lineThickness=0.5,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Line(
            points={{38,80},{58,60},{38,40}},
            color={135,135,135},
            thickness=0.5),
          Polygon(
            points={{-64,70},{-64,70}},
            lineColor={95,95,95},
            lineThickness=0.5,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-28,68},{-12,52}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-28,68},{-12,52}},
            lineColor={0,128,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="Q"),
          Text(
            extent={{-64,60},{-48,42}},
            lineColor={135,135,135},
            textString="1"),
          Text(
            extent={{76,60},{92,42}},
            lineColor={135,135,135},
            textString="4"),
          Text(
            extent={{32,-42},{48,-60}},
            lineColor={135,135,135},
            textString="5"),
          Text(
            extent={{-92,-42},{-76,-60}},
            lineColor={135,135,135},
            textString="7"),
          Text(
            extent={{-42,10},{-26,-8}},
            lineColor={135,135,135},
            textString="8"),
          Text(
            extent={{0,10},{16,-8}},
            lineColor={135,135,135},
            textString="9"),
          Text(
            extent={{-16,60},{0,42}},
            lineColor={135,135,135},
            textString="2"),
          Text(
            extent={{-20,-42},{-4,-60}},
            lineColor={135,135,135},
            textString="6"),
          Text(
            extent={{6,60},{22,42}},
            lineColor={135,135,135},
            textString="3")}),
      Diagram(coordinateSystem(extent={{-120,-120},{120,120}}, initialScale=0.1)),
      Documentation(info="<html><p>
  Injection circuit with a replaceable pump model for the distribution
  of hot or cold water. All sensor and actor values are connected to
  the hydraulic bus.
</p>
<h4>
  <span style=\"color: #008000\">Characteristics</span>
</h4>
<p>
  When the valve is fully opened, the consumer module is plugged into
  the primary hydronic circuit whereas when the valve is fully closed,
  the consumer is isolated from the primary hydronic circuit
</p>
<p>
  This model uses a pipe model to include the heat loss and insulation
  effects
</p>
</html>",   revisions="<html>
<ul>
  <li>December 06, 2022, by EBC-Modelica group:<br/>
    Fixes to increase compatability to OpenModelica <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1378\">#1378</a>.
  </li>
  <li>August 09, 2018, by Alexander Kümpel:<br/>
    Extension from base PartioalHydraulicModuls
  </li>
  <li>Mai 30, 2018, by Alexander Kümpel:<br/>
    Transfer from ZUGABE to AixLib
  </li>
  <li>2017-07-25 by Peter Matthes:<br/>
    Renames sensors and introduces PT1 behavior for temperature
    sensors. Adds sensors to icon.
  </li>
  <li>
    <i>March,2016&#160;</i> by Rohit Lad:<br/>
    Implemented
  </li>
</ul>
</html>"));
  end Injection;

  model Injection2WayValve
    "Injection circuit with pump and two way valve"
    extends
      AixLib.DataBase.Pumps.HydraulicModules.BaseClasses.PartialHydraulicModule;

    parameter Modelica.Units.SI.Volume vol=0.0005 "Mixing Volume"
      annotation (Dialog(tab="Advanced"));

    Fluid.Actuators.Valves.TwoWayTable  valve(
      CvData=AixLib.Fluid.Types.CvTypes.Kv,
      redeclare package Medium = Medium,
      final m_flow_nominal=m_flow_nominal,
      final allowFlowReversal=allowFlowReversal,
      Kv=Kv,
      order=1,
      init=Modelica.Blocks.Types.Init.InitialState,
      y_start=0,
      flowCharacteristics=Fluid.Actuators.Valves.Data.Linear())
             annotation (Dialog(enable=true, group="Actuators"), Placement(
          transformation(
          extent={{8,8},{-8,-8}},
          rotation=0,
          origin={-42,-60})));
        replaceable BaseClasses.BasicPumpInterface PumpInterface(
      redeclare package Medium = Medium,
      final allowFlowReversal=allowFlowReversal,
      final m_flow_nominal=m_flow_nominal,
      T_start=T_start,
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics)    "Needs to be redeclared" annotation (
      Dialog(group="Actuators"),
      choicesAllMatching=true,
      Placement(transformation(extent={{42,12},{58,28}})));
    Fluid.FixedResistances.GenericPipe  pipe1(
      redeclare package Medium = Medium,
      pipeModel=pipeModel,
      T_start=T_start,
      final m_flow_nominal=m_flow_nominal,
      final allowFlowReversal=allowFlowReversal,
      length=length,
      parameterPipe=parameterPipe,
      parameterIso=parameterIso,
      final hCon=hCon,
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics)           annotation (Dialog(enable=true,
          group="Pipes"), Placement(transformation(extent={{-40,28},{-24,12}})));
    Fluid.FixedResistances.GenericPipe  pipe2(
      redeclare package Medium = Medium,
      pipeModel=pipeModel,
      T_start=T_start,
      final m_flow_nominal=m_flow_nominal,
      final allowFlowReversal=allowFlowReversal,
      length=length,
      parameterPipe=parameterPipe,
      parameterIso=parameterIso,
      final hCon=hCon,
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics)           annotation (Dialog(enable=true,
          group="Pipes"), Placement(transformation(extent={{16,28},{32,12}})));

    Fluid.FixedResistances.GenericPipe  pipe3(
      redeclare package Medium = Medium,
      pipeModel=pipeModel,
      T_start=T_start,
      final m_flow_nominal=m_flow_nominal,
      final allowFlowReversal=allowFlowReversal,
      length=length,
      parameterPipe=parameterPipe,
      parameterIso=parameterIso,
      final hCon=hCon,
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics)           annotation (Dialog(enable=true,
          group="Pipes"), Placement(transformation(extent={{68,28},{84,12}})));
    Fluid.FixedResistances.GenericPipe  pipe4(
      redeclare package Medium = Medium,
      pipeModel=pipeModel,
      T_start=T_start,
      final m_flow_nominal=m_flow_nominal,
      final allowFlowReversal=allowFlowReversal,
      length=length,
      parameterPipe=parameterPipe,
      parameterIso=parameterIso,
      final hCon=hCon,
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics)           annotation (Dialog(enable=true,
          group="Pipes"), Placement(transformation(extent={{60,-68},{44,-52}})));
    Fluid.FixedResistances.GenericPipe  pipe5(
      redeclare package Medium = Medium,
      pipeModel=pipeModel,
      T_start=T_start,
      final m_flow_nominal=m_flow_nominal,
      final allowFlowReversal=allowFlowReversal,
      length=length,
      parameterPipe=parameterPipe,
      parameterIso=parameterIso,
      final hCon=hCon,
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics)           annotation (Dialog(enable=true,
          group="Pipes"), Placement(transformation(extent={{-4,-68},{-20,-52}})));

    Fluid.FixedResistances.GenericPipe  pipe6(
      redeclare package Medium = Medium,
      pipeModel=pipeModel,
      T_start=T_start,
      final m_flow_nominal=m_flow_nominal,
      final allowFlowReversal=allowFlowReversal,
      length=length,
      parameterPipe=parameterPipe,
      parameterIso=parameterIso,
      final hCon=hCon,
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics)           annotation (Dialog(enable=true,
          group="Pipes"), Placement(transformation(extent={{-58,-68},{-74,-52}})));
    Fluid.FixedResistances.GenericPipe  pipe7(
      redeclare package Medium = Medium,
      pipeModel=pipeModel,
      T_start=T_start,
      final m_flow_nominal=m_flow_nominal,
      final allowFlowReversal=allowFlowReversal,
      length=length,
      parameterPipe=parameterPipe,
      parameterIso=parameterIso,
      final hCon=hCon,
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics)           annotation (Dialog(enable=true,
          group="Pipes"), Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=90,
          origin={6,-20})));

     Fluid.MixingVolumes.MixingVolume junc3v6(
      redeclare package Medium = Medium,
      final massDynamics=massDynamics,
      final T_start=T_start,
      final V=vol,
      final m_flow_nominal=m_flow_nominal,
      nPorts=3,
      final allowFlowReversal=allowFlowReversal,
      final energyDynamics=energyDynamics)
      annotation (Placement(transformation(extent={{0,-60},{12,-72}})));

  protected
    Fluid.MixingVolumes.MixingVolume juncjp6(
      redeclare package Medium = Medium,
      final massDynamics=massDynamics,
      final V=vol,
      final T_start=T_start,
      final m_flow_nominal=m_flow_nominal,
      nPorts=3,
      final allowFlowReversal=allowFlowReversal,
      final energyDynamics=energyDynamics)
      annotation (Placement(transformation(extent={{0,20},{12,32}})));

  equation

    connect(PumpInterface.port_b, pipe3.port_a)
      annotation (Line(points={{58,20},{68,20}}, color={0,127,255}));

    connect(PumpInterface.pumpBus, hydraulicBus.pumpBus) annotation (Line(
        points={{50,28},{50,100.1},{0.1,100.1}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(pipe5.port_a, junc3v6.ports[1])
      annotation (Line(points={{-4,-60},{5.2,-60}},
                                                  color={0,127,255}));
    connect(valve.port_b, pipe6.port_a)
      annotation (Line(points={{-50,-60},{-58,-60}}, color={0,127,255}));
    connect(juncjp6.ports[1], pipe2.port_a)
      annotation (Line(points={{5.2,20},{16,20}}, color={0,127,255}));
    connect(senT_a1.port_b, pipe1.port_a)
      annotation (Line(points={{-88,20},{-40,20}}, color={0,127,255}));
    connect(pipe1.heatPort, prescribedTemperature.port) annotation (Line(points={{-32,
            12},{-32,0},{32,0},{32,-20}}, color={191,0,0}));
    connect(pipe2.heatPort, prescribedTemperature.port)
      annotation (Line(points={{24,12},{24,0},{32,0},{32,-20}}, color={191,0,0}));
    connect(pipe7.heatPort, prescribedTemperature.port)
      annotation (Line(points={{-2,-20},{20,-20},{20,-20},{32,-20}},
                                                   color={191,0,0}));
    connect(pipe3.heatPort, prescribedTemperature.port) annotation (Line(points={{76,
            12},{78,12},{78,0},{32,0},{32,-20}}, color={191,0,0}));
    connect(pipe5.heatPort, prescribedTemperature.port) annotation (Line(points={{-12,
            -52},{-12,-46},{32,-46},{32,-20}}, color={191,0,0}));
    connect(pipe6.heatPort, prescribedTemperature.port) annotation (Line(points={{-66,
            -52},{-66,-46},{32,-46},{32,-20}}, color={191,0,0}));
    connect(pipe4.heatPort, prescribedTemperature.port) annotation (Line(points={{52,
            -52},{52,-46},{32,-46},{32,-20}}, color={191,0,0}));
    connect(pipe4.port_a, senT_a2.port_b)
      annotation (Line(points={{60,-60},{72,-60}}, color={0,127,255}));
    connect(valve.y, hydraulicBus.valveSet) annotation (Line(points={{-42,-69.6},
            {-42,-80},{-122,-80},{-122,100.1},{0.1,100.1}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(valve.y_actual, hydraulicBus.valveMea) annotation (Line(points={{-46,
            -65.6},{-46,-80},{-122,-80},{-122,100.1},{0.1,100.1}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(pipe1.port_b, juncjp6.ports[2])
      annotation (Line(points={{-24,20},{6,20}}, color={0,127,255}));
    connect(pipe2.port_b, PumpInterface.port_a)
      annotation (Line(points={{32,20},{42,20}}, color={0,127,255}));
    connect(pipe3.port_b, senT_b1.port_a)
      annotation (Line(points={{84,20},{88,20}}, color={0,127,255}));
    connect(pipe4.port_b, junc3v6.ports[2])
      annotation (Line(points={{44,-60},{6,-60}}, color={0,127,255}));
    connect(pipe7.port_b, juncjp6.ports[3])
      annotation (Line(points={{6,-12},{6,20},{6.8,20}}, color={0,127,255}));
    connect(pipe7.port_a, junc3v6.ports[3])
      annotation (Line(points={{6,-28},{6.8,-28},{6.8,-60}}, color={0,127,255}));
    connect(pipe5.port_b, valve.port_a)
      annotation (Line(points={{-20,-60},{-34,-60}}, color={0,127,255}));
    connect(pipe6.port_b, senT_b2.port_a)
      annotation (Line(points={{-74,-60},{-78,-60}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(initialScale=0.1),          graphics={
          Polygon(
            points={{-66,-50},{-66,-50}},
            lineColor={95,95,95},
            lineThickness=0.5,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-60,-70},{-60,-50},{-40,-60},{-60,-70}},
            lineColor={95,95,95},
            lineThickness=0.5,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-20,-70},{-20,-50},{-40,-60},{-20,-70}},
            lineColor={95,95,95},
            lineThickness=0.5,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-4,60},{-4,-58}},
            color={0,128,255},
            thickness=0.5),
          Ellipse(
            extent={{-6,62},{-2,58}},
            lineColor={0,128,255},
            lineThickness=0.5,
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-6,-58},{-2,-62}},
            lineColor={0,128,255},
            lineThickness=0.5,
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{18,80},{58,40}},
            lineColor={135,135,135},
            lineThickness=0.5,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Line(
            points={{38,80},{58,60},{38,40}},
            color={135,135,135},
            thickness=0.5),
          Polygon(
            points={{-64,70},{-64,70}},
            lineColor={95,95,95},
            lineThickness=0.5,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-40,60},{-24,42}},
            lineColor={135,135,135},
            textString="1"),
          Text(
            extent={{76,60},{92,42}},
            lineColor={135,135,135},
            textString="3"),
          Text(
            extent={{32,-42},{48,-60}},
            lineColor={135,135,135},
            textString="4"),
          Text(
            extent={{-92,-42},{-76,-60}},
            lineColor={135,135,135},
            textString="6"),
          Text(
            extent={{0,10},{16,-8}},
            lineColor={135,135,135},
            textString="7"),
          Text(
            extent={{-20,-42},{-4,-60}},
            lineColor={135,135,135},
            textString="5"),
          Text(
            extent={{0,60},{16,42}},
            lineColor={135,135,135},
            textString="2")}),    Diagram(coordinateSystem(extent={{-120,-120},{120,
              120}}, initialScale=0.1)),
      Documentation(info="<html><p>
  Injection circuit with a replaceable pump model for the distribution
  of hot or cold water. All sensor and actor values are connected to
  the hydraulic bus.
</p>
<h4>
  <span style=\"color: #008000\">Characteristics</span>
</h4>
<p>
  When the valve is fully opened, the consumer module is plugged into
  the primary hydronic circuit (port_a1, port_b2) whereas when the
  valve is fully closed, the consumer is isolated from the primary
  hydronic circuit. The primary needs a supply pump or a pressure
  difference.
</p>
<p>
  This model uses a pipe model to include the heat loss and insulation
  effects
</p>
<ul>
  <li>August 09, 2018, by Alexander Kümpel:<br/>
    Extension from base PartioalHydraulicModuls
  </li>
  <li>June 30, 2018, by Alexander Kümpel:<br/>
    First implementation
  </li>
</ul>
</html>",   revisions="<html><ul>
  <li>December 06, 2022, by EBC-Modelica group:<br/>
    Fixes to increase compatability to OpenModelica <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1378\">#1378</a>.
  </li>
  <li>2017-06 by Alexander Kümpel:<br/>
    Implemented
  </li>
</ul>
</html>"));
  end Injection2WayValve;

  model Pump "Unmixed circuit with pump"
    extends
      AixLib.DataBase.Pumps.HydraulicModules.BaseClasses.PartialHydraulicModule(
        final Kv=0);

    replaceable BaseClasses.BasicPumpInterface PumpInterface(
      redeclare package Medium = Medium,
      final allowFlowReversal=allowFlowReversal,
      final m_flow_nominal=m_flow_nominal,
      T_start=T_start,
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics)    "Needs to be redeclared" annotation (
      Dialog(group="Actuators"),
      choicesAllMatching=true,
      Placement(transformation(extent={{-8,12},{8,28}})));
    Fluid.FixedResistances.GenericPipe  pipe1(
      redeclare package Medium = Medium,
      pipeModel=pipeModel,
      T_start=T_start,
      final m_flow_nominal=m_flow_nominal,
      final allowFlowReversal=allowFlowReversal,
      length=length,
      parameterPipe=parameterPipe,
      parameterIso=parameterIso,
      final hCon=hCon,
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics)           annotation (Dialog(enable=true,group="Pipes"),
        Placement(transformation(extent={{-60,30},{-40,10}})));

    Fluid.FixedResistances.GenericPipe  pipe2(
      redeclare package Medium = Medium,
      pipeModel=pipeModel,
      T_start=T_start,
      final m_flow_nominal=m_flow_nominal,
      final allowFlowReversal=allowFlowReversal,
      length=length,
      parameterPipe=parameterPipe,
      parameterIso=parameterIso,
      final hCon=hCon,
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics)           annotation (Dialog(enable=true,group="Pipes"),
        Placement(transformation(extent={{40,30},{60,10}})));
    Fluid.FixedResistances.GenericPipe  pipe3(
      redeclare package Medium = Medium,
      pipeModel=pipeModel,
      T_start=T_start,
      final m_flow_nominal=m_flow_nominal,
      final allowFlowReversal=allowFlowReversal,
      length=length,
      parameterPipe=parameterPipe,
      parameterIso=parameterIso,
      final hCon=hCon,
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics)           annotation (Dialog(enable=true,group="Pipes"),
        Placement(transformation(extent={{10,-70},{-10,-50}})));

  equation
    connect(PumpInterface.port_b, pipe2.port_a)
      annotation (Line(points={{8,20},{40,20}}, color={0,127,255}));
    connect(PumpInterface.pumpBus, hydraulicBus.pumpBus) annotation (Line(
        points={{0,28},{0,100.1},{0.1,100.1}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(senT_a1.port_b, pipe1.port_a)
      annotation (Line(points={{-88,20},{-60,20}}, color={0,127,255}));
    connect(pipe3.port_a, senT_a2.port_b)
      annotation (Line(points={{10,-60},{72,-60}}, color={0,127,255}));
    connect(pipe1.heatPort, prescribedTemperature.port) annotation (Line(points={{-50,
            10},{-50,-2},{32,-2},{32,-20}}, color={191,0,0}));
    connect(pipe2.heatPort, prescribedTemperature.port) annotation (Line(points={{50,
            10},{50,-2},{32,-2},{32,-20}}, color={191,0,0}));
    connect(pipe3.heatPort, prescribedTemperature.port)
      annotation (Line(points={{0,-50},{0,-20},{32,-20}}, color={191,0,0}));
    connect(pipe1.port_b, PumpInterface.port_a)
      annotation (Line(points={{-40,20},{-8,20}}, color={0,127,255}));
    connect(pipe2.port_b, senT_b1.port_a)
      annotation (Line(points={{60,20},{88,20}}, color={0,127,255}));
    connect(pipe3.port_b, senT_b2.port_a)
      annotation (Line(points={{-10,-60},{-78,-60}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(initialScale=0.1),          graphics={
          Ellipse(
            extent={{-20,80},{20,40}},
            lineColor={135,135,135},
            lineThickness=0.5,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Line(
            points={{0,80},{20,60},{0,40}},
            color={135,135,135},
            thickness=0.5),
          Line(
            points={{-90,-60},{-84,-60},{-84,-60},{84,-60},{84,-60},{90,-60}},
            color={0,128,255},
            thickness=0.5),
          Polygon(
            points={{-60,70},{-60,70}},
            lineColor={95,95,95},
            lineThickness=0.5,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{62,68},{78,52}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{62,68},{78,52}},
            lineColor={0,128,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="Q"),
          Ellipse(
            extent={{62,84},{78,68}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{62,84},{78,68}},
            lineColor={216,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="T"),
          Text(
            extent={{-56,60},{-40,42}},
            lineColor={135,135,135},
            textString="1"),
          Text(
            extent={{40,60},{56,42}},
            lineColor={135,135,135},
            textString="2"),
          Text(
            extent={{-16,-40},{0,-58}},
            lineColor={135,135,135},
            textString="3")}),Diagram(coordinateSystem(extent={{-120,-120},{120,120}},
            initialScale=0.1)),
      Documentation(revisions="<html><ul>
  <li>August 09, 2018, by Alexander Kümpel:<br/>
    Extension from base PartioalHydraulicModuls
  </li>
  <li>Mai 30, 2018, by Alexander Kümpel:<br/>
    Transfer from ZUGABE to AixLib
  </li>
  <li>2017-07-25 by Peter Matthes:<br/>
    Renames sensors and introduces PT1 behavior for temperature
    sensors. Adds sensors to icon.
  </li>
  <li>2017-06 by Alexander Kümpel:<br/>
    Implemented
  </li>
</ul>
</html>",   info="<html>
<p>
  Simple circuit with a pump for the distribution of hot or cold water.
  All sensor and actor values are connected to the hydraulic bus.
</p>
<h4>
  <span style=\"color: #008c48\">Characteristics</span>
</h4>
<p>
  The volume flow or pressure difference depends on the pump speed.
</p>
<p>
  This model uses a pipe model to include the heat loss and insulation
  effects.
</p>
</html>"));
  end Pump;

  model SimpleConsumer "Simple Consumer"
    extends AixLib.Fluid.Interfaces.PartialTwoPort;
    import    Modelica.Units.SI;

    parameter Real kA(unit="W/K")=1 "Heat transfer coefficient times area [W/K]" annotation (Dialog(enable = functionality=="T_fixed" or functionality=="T_input"));
    parameter SI.Temperature T_fixed = 293.15
                                             "Ambient temperature for convection" annotation (Dialog(enable = functionality=="T_fixed"));
    parameter SI.HeatCapacity capacity=1 "Capacity of the material";
    parameter SI.Volume V=0.001 "Volume of water";
    parameter SI.HeatFlowRate Q_flow_fixed = 0 "Prescribed heat flow" annotation (Dialog(enable = functionality=="Q_flow_fixed"));
    parameter Boolean allowFlowReversal=true
      "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
      annotation (Dialog(tab="Assumptions"), Evaluate=true);
    parameter SI.MassFlowRate m_flow_nominal(min=0)
      "Nominal mass flow rate";
    parameter SI.Temperature T_start=293.15
      "Initialization temperature" annotation(Dialog(tab="Advanced"));
    parameter String functionality "Choose between different functionalities" annotation (choices(
                choice="T_fixed",
                choice="T_input",
                choice="Q_flow_fixed",
                choice="Q_flow_input"),Dialog(enable=true));

    Fluid.MixingVolumes.MixingVolume volume(
      final V=V,
      final T_start=T_start,
      final allowFlowReversal=allowFlowReversal,
      final m_flow_nominal=m_flow_nominal,
      redeclare package Medium = Medium,
      nPorts=2)                          annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={0,10})));
    Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(
                            T(start=T_start, fixed=true), C=capacity)
      annotation (Placement(transformation(
          origin={44,40},
          extent={{-10,10},{10,-10}},
          rotation=90)));
    Modelica.Thermal.HeatTransfer.Components.Convection convection
   if functionality == "T_input" or functionality == "T_fixed"
      annotation (Placement(transformation(
          origin={10,70},
          extent={{-10,-10},{10,10}},
          rotation=90)));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
      prescribedTemperature if functionality == "T_input" or functionality == "T_fixed"
                            annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={40,80})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=kA) if functionality == "T_input"
       or functionality == "T_fixed"                            annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-30,78})));
    Modelica.Blocks.Sources.RealExpression realExpression1(y=T_fixed)
   if functionality == "T_fixed"                                annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={90,80})));
    Modelica.Blocks.Interfaces.RealInput T if functionality == "T_input"
                                           annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={60,120}), iconTransformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={80,100})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
   if functionality == "Q_flow_input" or functionality == "Q_flow_fixed"
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-62,58})));
    Modelica.Blocks.Sources.RealExpression realExpression2(y=Q_flow_fixed)
   if functionality == "Q_flow_fixed"                           annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-90,80})));
    Modelica.Blocks.Interfaces.RealInput Q_flow if functionality == "Q_flow_input"
                                                annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={-60,120}), iconTransformation(extent={{-20,-20},{20,20}},
          rotation=270,
          origin={-60,100})));
  equation
    connect(volume.heatPort,heatCapacitor. port) annotation (Line(points={{10,10},
            {10,40},{34,40}},               color={191,0,0},
        pattern=LinePattern.Dash));
    connect(heatCapacitor.port,convection. solid) annotation (Line(points={{34,40},
            {10,40},{10,60}},              color={191,0,0}));
    connect(convection.fluid,prescribedTemperature. port)
      annotation (Line(points={{10,80},{30,80}},   color={191,0,0},
        pattern=LinePattern.Dash));
    connect(realExpression.y,convection. Gc)
      annotation (Line(points={{-19,78},{-10,78},{-10,70},{0,70}},
                                                 color={0,0,127}));
    connect(realExpression1.y, prescribedTemperature.T)
      annotation (Line(points={{79,80},{52,80}},         color={0,0,127},
        pattern=LinePattern.Dash));
    connect(prescribedTemperature.T, T)
      annotation (Line(points={{52,80},{60,80},{60,120}}, color={0,0,127},
        pattern=LinePattern.Dash));
    connect(prescribedHeatFlow.Q_flow, realExpression2.y)
      annotation (Line(points={{-62,68},{-62,80},{-79,80}},
                                                   color={0,0,127},
        pattern=LinePattern.Dash));
    connect(prescribedHeatFlow.Q_flow, Q_flow)
      annotation (Line(points={{-62,68},{-62,94},{-60,94},{-60,120}},
                                                             color={0,0,127},
        pattern=LinePattern.Dash));
    connect(prescribedHeatFlow.port, heatCapacitor.port)
      annotation (Line(points={{-62,48},{-62,40},{34,40}}, color={191,0,0},
        pattern=LinePattern.Dash));
    connect(port_a, volume.ports[1])
      annotation (Line(points={{-100,0},{2,0}}, color={0,127,255}));
    connect(volume.ports[2], port_b)
      annotation (Line(points={{-2,0},{100,0}}, color={0,127,255}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                     Ellipse(
            extent={{-80,80},{80,-80}},
            lineColor={95,95,95},
            lineThickness=0.5,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),Ellipse(
            extent={{-60,60},{60,-60}},
            lineColor={95,95,95},
            lineThickness=0.5,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),Text(
            extent={{-56,18},{56,-18}},
            lineColor={95,95,95},
            lineThickness=0.5,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="CONSUMER")}),
      Diagram(coordinateSystem(preserveAspectRatio=false)),
      Documentation(info="<html><p>
  Model with a simple consumer. The consumed power depends either on
  the temperature (T_fixed or T_input) and the convective coefficient
  kA or the power is prescribed (Q_flow_input or _Q_flow_fixed). It is
  possible to choose between these options with the parameter
  \"functionality\".
</p>
<ul>
  <li>August 31, 2020, by Alexander Kümpel:<br/>
    Remove pipes
  </li>
  <li>October 31, 2019, by Alexander Kümpel:<br/>
    Add more options
  </li>
  <li>October 25, 2017, by Alexander Kümpel:<br/>
    Transfer from ZUGABE to AixLib
  </li>
  <li>
    <i>2016-03-06 &#160;</i> by Peter Matthes:<br/>
    added documentation
  </li>
  <li>
    <i>2016-02-17 &#160;</i> by Rohit Lad:<br/>
    implemented simple consumers model
  </li>
</ul>
</html>"));
  end SimpleConsumer;

  model Throttle "Throttle circuit with two way valve"
    extends
      AixLib.DataBase.Pumps.HydraulicModules.BaseClasses.PartialHydraulicModule;

    Fluid.Actuators.Valves.TwoWayTable         valve(
      redeclare package Medium = Medium,
      final m_flow_nominal=m_flow_nominal,
      CvData=AixLib.Fluid.Types.CvTypes.Kv,
      final allowFlowReversal=allowFlowReversal,
      Kv=Kv,
      order=1,
      init=Modelica.Blocks.Types.Init.InitialState,
      y_start=0,
      flowCharacteristics=Fluid.Actuators.Valves.Data.Linear())
             annotation (Dialog(enable=true, group="Actuators"), Placement(
          transformation(extent={{-12,10},{8,30}})));
    Fluid.FixedResistances.GenericPipe  pipe1(
      redeclare package Medium = Medium,
      pipeModel=pipeModel,
      T_start=T_start,
      final m_flow_nominal=m_flow_nominal,
      final allowFlowReversal=allowFlowReversal,
      length=length,
      parameterPipe=parameterPipe,
      parameterIso=parameterIso,
      final hCon=hCon,
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics)           annotation (Dialog(enable=true,group="Pipes"),
        Placement(transformation(extent={{-60,30},{-40,10}})));

    Fluid.FixedResistances.GenericPipe  pipe2(
      redeclare package Medium = Medium,
      pipeModel=pipeModel,
      T_start=T_start,
      final m_flow_nominal=m_flow_nominal,
      final allowFlowReversal=allowFlowReversal,
      length=length,
      parameterPipe=parameterPipe,
      parameterIso=parameterIso,
      final hCon=hCon,
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics)           annotation (Dialog(enable=true,group="Pipes"),
        Placement(transformation(extent={{40,30},{60,10}})));

    Fluid.FixedResistances.GenericPipe  pipe3(
      redeclare package Medium = Medium,
      pipeModel=pipeModel,
      T_start=T_start,
      final m_flow_nominal=m_flow_nominal,
      final allowFlowReversal=allowFlowReversal,
      length=length,
      parameterPipe=parameterPipe,
      parameterIso=parameterIso,
      final hCon=hCon,
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics)           annotation (Dialog(enable=true,group="Pipes"),
        Placement(transformation(extent={{10,-70},{-10,-50}})));

  equation
    connect(valve.port_b, pipe2.port_a)
      annotation (Line(points={{8,20},{40,20}}, color={0,127,255}));
    connect(valve.y, hydraulicBus.valveSet) annotation (Line(points={{-2,32},{-2,
            100.1},{0.1,100.1}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(valve.y_actual, hydraulicBus.valveMea) annotation (Line(points={{3,27},
            {3,100.1},{0.1,100.1}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(pipe3.port_a, senT_a2.port_b)
      annotation (Line(points={{10,-60},{72,-60}}, color={0,127,255}));
    connect(pipe1.port_a, senT_a1.port_b)
      annotation (Line(points={{-60,20},{-88,20}}, color={0,127,255}));
    connect(pipe1.heatPort, prescribedTemperature.port) annotation (Line(points={{-50,
            10},{-50,0},{32,0},{32,-20}}, color={191,0,0}));
    connect(pipe2.heatPort, prescribedTemperature.port)
      annotation (Line(points={{50,10},{50,0},{32,0},{32,-20}}, color={191,0,0}));
    connect(pipe3.heatPort, prescribedTemperature.port)
      annotation (Line(points={{0,-50},{0,-20},{32,-20}}, color={191,0,0}));
    connect(pipe1.port_b, valve.port_a)
      annotation (Line(points={{-40,20},{-12,20}}, color={0,127,255}));
    connect(pipe2.port_b, senT_b1.port_a)
      annotation (Line(points={{60,20},{88,20}}, color={0,127,255}));
    connect(pipe3.port_b, senT_b2.port_a)
      annotation (Line(points={{-10,-60},{-78,-60}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(initialScale=0.1),          graphics={
          Polygon(
            points={{-20,50},{-20,70},{0,60},{-20,50}},
            lineColor={95,95,95},
            lineThickness=0.5,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{20,50},{20,70},{0,60},{20,50}},
            lineColor={95,95,95},
            lineThickness=0.5,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-60,70},{-60,70}},
            lineColor={95,95,95},
            lineThickness=0.5,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-56,60},{-40,42}},
            lineColor={135,135,135},
            textString="1"),
          Text(
            extent={{38,60},{54,42}},
            lineColor={135,135,135},
            textString="2"),
          Text(
            extent={{-8,-40},{8,-58}},
            lineColor={135,135,135},
            textString="4")}),Diagram(coordinateSystem(extent={{-120,-120},{120,120}},
            initialScale=0.1)),
      Documentation(revisions="<html><ul>
  <li>August 09, 2018, by Alexander Kümpel:<br/>
    Extension from base PartioalHydraulicModuls
  </li>
  <li>Mai 30, 2018, by Alexander Kümpel:<br/>
    Transfer from ZUGABE to AixLib
  </li>
  <li>2017-07-25 by Peter Matthes:<br/>
    Renames sensors and introduces PT1 behavior for temperature
    sensors. Adds sensors to icon.
  </li>
  <li>2017-06 by Alexander Kümpel:<br/>
    Implemented
  </li>
</ul>
</html>",   info="<html>
<p>
  Throttle circuit with a valve for the distribution of hot or cold
  water. All sensor and actor values are connected to the hydraulic
  bus.
</p>
<h4>
  <span style=\"color: #008c48\">Characteristics</span>
</h4>
<p>
  The volume flow depends on the valve opening. If the valve is
  completly closed, there is no volume flow (except leackage).
</p>
<p>
  This model uses a pipe model to include the heat loss and insulation
  effects.
</p>
</html>"));
  end Throttle;

  model ThrottlePump "Throttle circuit with pump and two way valve"
    extends
      AixLib.DataBase.Pumps.HydraulicModules.BaseClasses.PartialHydraulicModule;

    Fluid.Actuators.Valves.TwoWayTable         valve(
      redeclare package Medium = Medium,
      m_flow_nominal=m_flow_nominal,
      CvData=AixLib.Fluid.Types.CvTypes.Kv,
      final allowFlowReversal=allowFlowReversal,
      Kv=Kv,
      order=1,
      init=Modelica.Blocks.Types.Init.InitialState,
      y_start=0,
      flowCharacteristics=Fluid.Actuators.Valves.Data.Linear())
             annotation (Dialog(enable=true, group="Actuators"), Placement(
          transformation(extent={{-36,10},{-16,30}})));
    replaceable BaseClasses.BasicPumpInterface PumpInterface(
      redeclare package Medium = Medium,
      final allowFlowReversal=allowFlowReversal,
      final m_flow_nominal=m_flow_nominal,
      T_start=T_start,
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics)    "Needs to be redeclared" annotation (
      Dialog(group="Actuators"),
      choicesAllMatching=true,
      Placement(transformation(extent={{32,12},{48,28}})));
    Fluid.FixedResistances.GenericPipe  pipe1(
      redeclare package Medium = Medium,
      pipeModel=pipeModel,
      T_start=T_start,
      final m_flow_nominal=m_flow_nominal,
      final allowFlowReversal=allowFlowReversal,
      length=length,
      parameterPipe=parameterPipe,
      parameterIso=parameterIso,
      final hCon=hCon,
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics)           annotation (Dialog(enable=true,group="Pipes"),
        Placement(transformation(extent={{-80,30},{-60,10}})));

    Fluid.FixedResistances.GenericPipe  pipe2(
      redeclare package Medium = Medium,
      pipeModel=pipeModel,
      T_start=T_start,
      final m_flow_nominal=m_flow_nominal,
      final allowFlowReversal=allowFlowReversal,
      length=length,
      parameterPipe=parameterPipe,
      parameterIso=parameterIso,
      final hCon=hCon,
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics)           annotation (Dialog(enable=true,group="Pipes"),
        Placement(transformation(extent={{0,30},{20,10}})));

    Fluid.FixedResistances.GenericPipe  pipe3(
      redeclare package Medium = Medium,
      pipeModel=pipeModel,
      T_start=T_start,
      final m_flow_nominal=m_flow_nominal,
      final allowFlowReversal=allowFlowReversal,
      length=length,
      parameterPipe=parameterPipe,
      parameterIso=parameterIso,
      final hCon=hCon,
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics)           annotation (Dialog(enable=true,group="Pipes"),
        Placement(transformation(extent={{60,30},{80,10}})));
    Fluid.FixedResistances.GenericPipe  pipe4(
      redeclare package Medium = Medium,
      pipeModel=pipeModel,
      T_start=T_start,
      final m_flow_nominal=m_flow_nominal,
      final allowFlowReversal=allowFlowReversal,
      length=length,
      parameterPipe=parameterPipe,
      parameterIso=parameterIso,
      final hCon=hCon,
      final energyDynamics=energyDynamics,
      final massDynamics=massDynamics)           annotation (Dialog(enable=true,group="Pipes"),
        Placement(transformation(extent={{20,-70},{0,-50}})));

  equation
    connect(valve.port_b, pipe2.port_a)
      annotation (Line(points={{-16,20},{0,20}}, color={0,127,255}));
    connect(valve.y, hydraulicBus.valveSet) annotation (Line(points={{-26,32},{-26,
            100.1},{0.1,100.1}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(PumpInterface.port_b, pipe3.port_a)
      annotation (Line(points={{48,20},{60,20}}, color={0,127,255}));
    connect(valve.y_actual, hydraulicBus.valveMea) annotation (Line(points={{-21,
            27},{-21,100.1},{0.1,100.1}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(PumpInterface.pumpBus, hydraulicBus.pumpBus) annotation (Line(
        points={{40,28},{40,100.1},{0.1,100.1}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(senT_a1.port_b, pipe1.port_a)
      annotation (Line(points={{-88,20},{-80,20}}, color={0,127,255}));
    connect(pipe4.port_a, senT_a2.port_b)
      annotation (Line(points={{20,-60},{72,-60}}, color={0,127,255}));
    connect(pipe2.heatPort, prescribedTemperature.port)
      annotation (Line(points={{10,10},{10,-20},{32,-20}}, color={191,0,0}));
    connect(pipe4.heatPort, prescribedTemperature.port)
      annotation (Line(points={{10,-50},{10,-20},{32,-20}}, color={191,0,0}));
    connect(pipe3.heatPort, prescribedTemperature.port) annotation (Line(points={{70,
            10},{70,-2},{10,-2},{10,-20},{32,-20}}, color={191,0,0}));
    connect(pipe1.heatPort, prescribedTemperature.port) annotation (Line(points={{-70,10},
            {-70,-2},{10,-2},{10,-20},{32,-20}},     color={191,0,0}));
    connect(pipe1.port_b, valve.port_a)
      annotation (Line(points={{-60,20},{-36,20}}, color={0,127,255}));
    connect(pipe2.port_b, PumpInterface.port_a)
      annotation (Line(points={{20,20},{32,20}}, color={0,127,255}));
    connect(pipe3.port_b, senT_b1.port_a)
      annotation (Line(points={{80,20},{88,20}}, color={0,127,255}));
    connect(pipe4.port_b, senT_b2.port_a)
      annotation (Line(points={{0,-60},{-78,-60}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(initialScale=0.1),          graphics={
          Ellipse(
            extent={{10,80},{50,40}},
            lineColor={135,135,135},
            lineThickness=0.5,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Line(
            points={{30,80},{50,60},{30,40}},
            color={135,135,135},
            thickness=0.5),
          Polygon(
            points={{-50,50},{-50,70},{-30,60},{-50,50}},
            lineColor={95,95,95},
            lineThickness=0.5,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-10,50},{-10,70},{-30,60},{-10,50}},
            lineColor={95,95,95},
            lineThickness=0.5,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-60,70},{-60,70}},
            lineColor={95,95,95},
            lineThickness=0.5,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-92,60},{-76,42}},
            lineColor={135,135,135},
            textString="1"),
          Text(
            extent={{-6,60},{10,42}},
            lineColor={135,135,135},
            textString="2"),
          Text(
            extent={{50,60},{66,42}},
            lineColor={135,135,135},
            textString="3"),
          Text(
            extent={{-8,-42},{8,-60}},
            lineColor={135,135,135},
            textString="4")}),Diagram(coordinateSystem(extent={{-120,-120},{120,120}},
            initialScale=0.1)),
      Documentation(revisions="<html><ul>
  <li>August 09, 2018, by Alexander Kümpel:<br/>
    Extension from base PartioalHydraulicModuls
  </li>
  <li>Mai 30, 2018, by Alexander Kümpel:<br/>
    Transfer from ZUGABE to AixLib
  </li>
  <li>2017-07-25 by Peter Matthes:<br/>
    Renames sensors and introduces PT1 behavior for temperature
    sensors. Adds sensors to icon.
  </li>
  <li>2017-06 by Alexander Kümpel:<br/>
    Implemented
  </li>
</ul>
</html>",   info="<html>
<p>
  Throttle circuit with a replaceable pump model and a valve for the
  distribution of hot or cold water. All sensor and actor values are
  connected to the hydraulic bus.
</p>
<h4>
  <span style=\"color: #008c48\">Characteristics</span>
</h4>
<p>
  The volume flow depends on the valve opening and the pump speed. If
  the pump is switched of or the valve is completly closed, there is no
  volume flow (except leackage).
</p>
<p>
  This model uses a pipe model to include the heat loss and insulation
  effects.
</p>
</html>"));
  end ThrottlePump;

  package Controller "Controller for hydraulic circuits"
    extends Modelica.Icons.VariantsPackage;

    model CalcHydraulicPower

      parameter Real rho = 1000 "Density of Medium";
      parameter Real cp = 4180 "Heat Capacity of Medium";
    public
      BaseClasses.HydraulicBus  hydraulicBus
        annotation (Placement(transformation(extent={{-124,-24},{-76,24}}),
            iconTransformation(extent={{-124,-24},{-76,24}})));
      Modelica.Blocks.Math.Add add(k1=-1, k2=+1)
        annotation (Placement(transformation(extent={{-20,22},{0,42}})));
      Modelica.Blocks.Math.Product product1
        annotation (Placement(transformation(extent={{58,-10},{78,10}})));
      Modelica.Blocks.Math.Gain gain(k=rho)
        annotation (Placement(transformation(extent={{-56,-10},{-38,8}})));
      Modelica.Blocks.Math.Gain gain1(k=cp)
        annotation (Placement(transformation(extent={{-22,-10},{-4,8}})));
      Modelica.Blocks.Interfaces.RealOutput Q_flow
        "Connector of Real output signal"
        annotation (Placement(transformation(extent={{98,-10},{118,10}})));
    equation
      connect(add.u2, hydraulicBus.TFwrdInMea) annotation (Line(points={{-22,26},{-99.88,
              26},{-99.88,0.12}},  color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(add.u1, hydraulicBus.TRtrnOutMea) annotation (Line(points={{-22,38},{-100,
              38},{-100,0.12},{-99.88,0.12}},   color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(product1.u1, add.y) annotation (Line(points={{56,6},{12,6},{12,32},{1,
              32}},   color={0,0,127}));
      connect(gain.u, hydraulicBus.VFlowInMea) annotation (Line(points={{-57.8,-1},{
              -64.9,-1},{-64.9,0.12},{-99.88,0.12}},   color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(gain.y, gain1.u)
        annotation (Line(points={{-37.1,-1},{-23.8,-1}}, color={0,0,127}));
      connect(gain1.y, product1.u2) annotation (Line(points={{-3.1,-1},{8,-1},{8,-6},
              {56,-6}},     color={0,0,127}));
      connect(product1.y, Q_flow)
        annotation (Line(points={{79,0},{108,0}}, color={0,0,127}));
      connect(Q_flow, Q_flow)
        annotation (Line(points={{108,0},{108,0}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),Line(
              points={{-100,100},{-36,-2},{-100,-100}},
              color={95,95,95},
              thickness=0.5),
              Text(
              extent={{-48,20},{98,-20}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              textString="Control")}), Diagram(coordinateSystem(preserveAspectRatio=
               false)),
        Documentation(revisions="<html><ul>
  <li>December 9, 2021, by Phillip Stoffel:<br/>
    First implementation.
  </li>
</ul>
</html>",     info="<html>
<p>
  Calculates the power auf hydraulic modules and returns the power as
  real
</p>
</html>"));
    end CalcHydraulicPower;

    block CtrMix "Controller for mixed and injection circuits "
      //Boolean choice;

      parameter Boolean useExternalTset = false "If True, set temperature can be given externally";
      parameter Modelica.Units.SI.Temperature TflowSet=289.15
        "Flow temperature set point of consumer";
      parameter Real k(min=0, unit="1") = 0.025 "Gain of controller";
      parameter Modelica.Units.SI.Time Ti(min=Modelica.Constants.small) = 130
        "Time constant of Integrator block";
      parameter Modelica.Units.SI.Time Td(min=0) = 4
        "Time constant of Derivative block";
      parameter Modelica.Units.NonSI.AngularVelocity_rpm rpm_pump(min=0) = 2000
        "Rpm of the Pump";
      parameter Modelica.Blocks.Types.Init initType=.Modelica.Blocks.Types.Init.InitialState
        "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
        annotation (Dialog(group="PID"));
      parameter Boolean reverseAction = true
        "Set to true if heating system, and false for cooling system";
      parameter Real xi_start=0
        "Initial or guess value value for integrator output (= integrator state)"
        annotation(Dialog(group="PID"));
      parameter Real xd_start=0
        "Initial or guess value for state of derivative block"
        annotation(Dialog(group="PID"));
      parameter Real y_start=0 "Initial value of output"
        annotation(Dialog(group="PID"));
      Modelica.Blocks.Interfaces.RealInput Tset if useExternalTset
        "Connector of second Real input signal"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      AixLib.Controls.Continuous.LimPID PID(
        final yMax=1,
        final yMin=0,
        final controllerType=Modelica.Blocks.Types.SimpleController.PID,
        final k=k,
        final Ti=Ti,
        final Td=Td,
        final initType=initType,
        final xi_start=xi_start,
        final xd_start=xd_start,
        final y_start=y_start,
        final reverseActing=reverseAction)
                annotation (Placement(transformation(extent={{-16,-60},{4,-40}})));
      Modelica.Blocks.Sources.Constant constRpmPump(final k=rpm_pump) annotation (Placement(transformation(extent={{20,-10},{40,10}})));

      Modelica.Blocks.Sources.Constant constTflowSet(final k=TflowSet) if not useExternalTset annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
      Modelica.Blocks.Sources.BooleanConstant booleanConstant
        annotation (Placement(transformation(extent={{60,20},{80,40}})));
    equation

    public
      BaseClasses.HydraulicBus  hydraulicBus
        annotation (Placement(transformation(extent={{76,-24},{124,24}}),
            iconTransformation(extent={{90,-22},{138,26}})));
    equation
        connect(PID.u_s, Tset) annotation (Line(
          points={{-18,-50},{-47.1,-50},{-47.1,0},{-120,0}},
          color={0,0,127},
          pattern=LinePattern.Dash));
        connect(constTflowSet.y, PID.u_s) annotation (Line(
          points={{-79,-50},{-18,-50}},
          color={0,0,127},
          pattern=LinePattern.Dash));

      connect(PID.y, hydraulicBus.valveSet) annotation (Line(points={{5,-50},{48,
              -50},{48,0.12},{100.12,0.12}},  color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(PID.u_m, hydraulicBus.TFwrdOutMea) annotation (Line(points={{-6,-62},
              {-6,-80},{100.12,-80},{100.12,0.12}},    color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(constRpmPump.y, hydraulicBus.pumpBus.rpmSet) annotation (Line(points={
              {41,0},{70,0},{70,0.12},{100.12,0.12}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(booleanConstant.y, hydraulicBus.pumpBus.onSet) annotation (Line(
            points={{81,30},{100.12,30},{100.12,0.12}}, color={255,0,255}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Text(
              extent={{-90,20},{56,-20}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              textString="HCMI"),
              Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),Line(
              points={{-100,100},{-36,-2},{-100,-100}},
              color={95,95,95},
              thickness=0.5),
              Text(
              extent={{-48,20},{98,-20}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              textString="Control")}),
                                    Diagram(coordinateSystem(preserveAspectRatio=
                false)),
        Documentation(revisions="<html><ul>
  <li>January 22, 2019, by Alexander Kümpel:<br/>
    External T_set added.
  </li>
  <li>October 25, 2017, by Alexander Kümpel:<br/>
    First implementation.
  </li>
</ul>
</html>",     info="<html>
<p>
  Simple controller for admix and injection circuit. The controlled
  variable is the outflow temperature T_fwrd_out and controlled by a
  PID controller. The pump is always on and has a constant frequency.
</p>
</html>"));
    end CtrMix;

    block CtrPump "controller for pump circuit"
      //Boolean choice;

      parameter Modelica.Units.NonSI.AngularVelocity_rpm rpm_pump(min=0) = 2000
        "Rpm of the Pump";

      Modelica.Blocks.Sources.Constant constRpmPump(final k=rpm_pump) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      Modelica.Blocks.Sources.BooleanConstant booleanConstant
        annotation (Placement(transformation(extent={{60,20},{80,40}})));
      BaseClasses.HydraulicBus hydraulicBus annotation (Placement(
            transformation(extent={{76,-24},{124,24}}), iconTransformation(extent={{90,-22},
                {138,26}})));
    equation
      connect(constRpmPump.y, hydraulicBus.pumpBus.rpmSet) annotation (Line(points={
              {11,0},{56,0},{56,0.12},{100.12,0.12}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(booleanConstant.y, hydraulicBus.pumpBus.onSet) annotation (Line(
            points={{81,30},{98,30},{98,0.12},{100.12,0.12}}, color={255,0,255}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),Line(
              points={{-100,100},{-36,-2},{-100,-100}},
              color={95,95,95},
              thickness=0.5),
              Text(
              extent={{-48,20},{98,-20}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              textString="Control")}),
                                    Diagram(coordinateSystem(preserveAspectRatio=
                false)),
        Documentation(revisions="<html><ul>
  <li>October 25, by Alexander Kümpel:<br/>
    First implementation.
  </li>
</ul>
</html>",     info="<html>
<p>
  Simple controller for unmixed circuit. Only the pump frequency has to
  be set. The pump is always on.
</p>
</html>"));
    end CtrPump;

    block CtrPumpVFlow
      "Volume Flow Set Point Controller for variable Speed pumps"
             Modelica.Blocks.Interfaces.RealInput vFlowAct
        "Connector of measurement input signal" annotation (Placement(
            transformation(extent={{-140,40},{-100,80}}), iconTransformation(extent=
               {{-140,40},{-100,80}})));
      Modelica.Blocks.Interfaces.RealInput vFlowSet
                                                if useExternalVset
        "Connector of second Real input signal" annotation (Placement(
            transformation(extent={{-140,-80},{-100,-40}}), iconTransformation(
              extent={{-140,-80},{-100,-40}})));
    public
      BaseClasses.HydraulicBus  hydraulicBus
        annotation (Placement(transformation(extent={{76,-24},{124,24}}),
            iconTransformation(extent={{90,-22},{138,26}})));
              parameter Boolean useExternalVset = false "If True, set Volume Flow can be given externally";
      parameter Modelica.Units.SI.VolumeFlowRate vFlowSetCon=0.01
        "Volume Flow in m³/s set point of consumer";
      parameter Real k(min=0, unit="1") = 100 "Gain of controller";
      parameter Modelica.Units.SI.Time Ti(min=Modelica.Constants.small) = 30
        "Time constant of Integrator block";
      parameter Modelica.Units.SI.Time Td(min=0) = 4
        "Time constant of Derivative block";
      parameter Modelica.Units.NonSI.AngularVelocity_rpm rpm_pump_max(min=0) = 2000
        "Rpm of the Pump";
      parameter Modelica.Blocks.Types.Init initType=.Modelica.Blocks.Types.Init.InitialState
        "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
        annotation (Dialog(group="PID"));
      parameter Boolean reverseAction = true
        "Set to true if heating system, and false for cooling system";
      parameter Real xi_start=0
        "Initial or guess value value for integrator output (= integrator state)"
        annotation(Dialog(group="PID"));
      parameter Real xd_start=0
        "Initial or guess value for state of derivative block"
        annotation(Dialog(group="PID"));
      parameter Real y_start=0 "Initial value of output"
        annotation(Dialog(group="PID"));
      Modelica.Blocks.Sources.Constant constVflowSet(final k=vFlowSetCon) if not useExternalVset annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
      AixLib.Controls.Continuous.LimPID PID(
        final yMax=rpm_pump_max,
        final yMin=0,
        final controllerType=Modelica.Blocks.Types.SimpleController.PID,
        final k=k,
        final Ti=Ti,
        final Td=Td,
        final initType=initType,
        final xi_start=xi_start,
        final xd_start=xd_start,
        final y_start=y_start,
        final reverseActing=reverseAction)
                annotation (Placement(transformation(extent={{-20,-40},{0,-60}})));

      Modelica.Blocks.Logical.GreaterThreshold
                                            pumpSwitchOff(final threshold=0)
        annotation (Placement(transformation(extent={{20,30},{40,50}})));
      Modelica.Blocks.Sources.Constant constValvSet(final k=1)         if not useExternalVset
        annotation (Placement(transformation(extent={{20,-10},{40,10}})));
    equation

        connect(PID.u_s,vFlowSet)  annotation (Line(
          points={{-22,-50},{-67.1,-50},{-67.1,-60},{-120,-60}},
          color={0,0,127},
          pattern=LinePattern.Dash));
        connect(constVflowSet.y, PID.u_s) annotation (Line(
          points={{-79,-20},{-66,-20},{-66,-50},{-22,-50}},
          color={0,0,127},
          pattern=LinePattern.Dash));

      connect(PID.u_m,vFlowAct)
        annotation (Line(points={{-10,-38},{-10,60},{-120,60}},        color={0,0,127}));
      connect(PID.y,pumpSwitchOff. u)
        annotation (Line(points={{1,-50},{8,-50},{8,40},{18,40}},   color={0,0,127}));
      connect(pumpSwitchOff.y, hydraulicBus.pumpBus.onSet) annotation (Line(points={{41,40},
              {100.12,40},{100.12,0.12}},            color={255,0,255}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(PID.y, hydraulicBus.pumpBus.rpmSet) annotation (Line(points={{1,-50},
              {100,-50},{100,0.12},{100.12,0.12}},
                                                 color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(constValvSet.y, hydraulicBus.valveSet) annotation (Line(points={{41,0},{
              48,0},{48,0.12},{100.12,0.12}},  color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),Line(
              points={{-100,100},{-36,-2},{-100,-100}},
              color={95,95,95},
              thickness=0.5),
              Text(
              extent={{-48,20},{98,-20}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              textString="Control")}),                               Diagram(
            coordinateSystem(preserveAspectRatio=false)),
                  Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),Line(
              points={{-100,100},{-36,-2},{-100,-100}},
              color={95,95,95},
              thickness=0.5),
              Text(
              extent={{-48,20},{98,-20}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              textString="Control")}),                               Diagram(
            coordinateSystem(preserveAspectRatio=false)),
                Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),Line(
              points={{-100,100},{-36,-2},{-100,-100}},
              color={95,95,95},
              thickness=0.5),
              Text(
              extent={{-48,20},{98,-20}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              textString="Control")}),
                                    Diagram(coordinateSystem(preserveAspectRatio=
                false)),
        Documentation(revisions="<html><ul>
  <li>April 14, 2021, by Phillip Stoffel:<br/>
    First implementation.
  </li>
</ul>
</html>",     info="<html>
<p>
  Simple controller for Throttle and ThrottlePump circuit that is based
  on a PID controller. The controlled variable needs to be connected to
  vFlowAct.
</p>
<p>
  The controller adjusts the pump speed to archive the specified volume
  flow
</p>
</html>"));
    end CtrPumpVFlow;

    block CtrThrottle "Controller for unmixed circuit with valve"
      //Boolean choice;

      parameter Boolean useExternalTset = false "If True, set temperature can be given externally";
      parameter Modelica.Units.SI.Temperature TflowSet=289.15
        "Flow temperature set point of consumer";
      parameter Real k(min=0, unit="1") = 0.025 "Gain of controller";
      parameter Modelica.Units.SI.Time Ti(min=Modelica.Constants.small) = 130
        "Time constant of Integrator block";
      parameter Modelica.Units.SI.Time Td(min=0) = 4
        "Time constant of Derivative block";
      parameter Modelica.Units.NonSI.AngularVelocity_rpm rpm_pump(min=0) = 2000
        "Rpm of the Pump";
      parameter Modelica.Blocks.Types.Init initType=.Modelica.Blocks.Types.Init.InitialState
        "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
        annotation (Dialog(group="PID"));
      parameter Boolean reverseAction = true
        "Set to true if heating system, and false for cooling system";
      parameter Real xi_start=0
        "Initial or guess value value for integrator output (= integrator state)"
        annotation(Dialog(group="PID"));
      parameter Real xd_start=0
        "Initial or guess value for state of derivative block"
        annotation(Dialog(group="PID"));
      parameter Real y_start=0 "Initial value of output"
        annotation(Dialog(group="PID"));
      Modelica.Blocks.Interfaces.RealInput Tact
                    "Connector of measurement input signal"
        annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
      Modelica.Blocks.Interfaces.RealInput Tset if useExternalTset
        "Connector of second Real input signal"
        annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
      Modelica.Blocks.Sources.Constant constTflowSet(final k=TflowSet) if not useExternalTset annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
      AixLib.Controls.Continuous.LimPID PID(
        final yMax=1,
        final yMin=0,
        final controllerType=Modelica.Blocks.Types.SimpleController.PID,
        final k=k,
        final Ti=Ti,
        final Td=Td,
        final initType=initType,
        final xi_start=xi_start,
        final xd_start=xd_start,
        final y_start=y_start,
        reverseActing=reverseAction)
                annotation (Placement(transformation(extent={{-20,-40},{0,-60}})));
      Modelica.Blocks.Sources.Constant constRpmPump(final k=rpm_pump) annotation (Placement(transformation(extent={{20,-10},{40,10}})));

      Modelica.Blocks.Logical.GreaterThreshold
                                            pumpSwitchOff(final threshold=0)
        annotation (Placement(transformation(extent={{16,32},{32,48}})));
    equation

    public
      BaseClasses.HydraulicBus  hydraulicBus
        annotation (Placement(transformation(extent={{76,-24},{124,24}}),
            iconTransformation(extent={{90,-22},{138,26}})));
    equation
        connect(PID.u_s, Tset) annotation (Line(
          points={{-22,-50},{-67.1,-50},{-67.1,-60},{-120,-60}},
          color={0,0,127},
          pattern=LinePattern.Dash));
        connect(constTflowSet.y, PID.u_s) annotation (Line(
          points={{-79,-20},{-68,-20},{-68,-50},{-22,-50}},
          color={0,0,127},
          pattern=LinePattern.Dash));

      connect(PID.y, hydraulicBus.valveSet) annotation (Line(points={{1,-50},{48,-50},
              {48,0.12},{100.12,0.12}},       color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(PID.u_m, Tact)
        annotation (Line(points={{-10,-38},{-10,60},{-120,60}},        color={0,0,127}));
      connect(PID.y,pumpSwitchOff. u)
        annotation (Line(points={{1,-50},{4,-50},{4,40},{14.4,40}}, color={0,0,127}));
      connect(constRpmPump.y, hydraulicBus.pumpBus.rpmSet) annotation (Line(points={
              {41,0},{100.12,0},{100.12,0.12}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(pumpSwitchOff.y, hydraulicBus.pumpBus.onSet) annotation (Line(points=
              {{32.8,40},{100.12,40},{100.12,0.12}}, color={255,0,255}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),Line(
              points={{-100,100},{-36,-2},{-100,-100}},
              color={95,95,95},
              thickness=0.5),
              Text(
              extent={{-48,20},{98,-20}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              textString="Control")}),
                                    Diagram(coordinateSystem(preserveAspectRatio=
                false)),
        Documentation(revisions="<html><ul>
  <li>January 22, 2019, by Alexander Kümpel:<br/>
    First implementation.
  </li>
</ul>
</html>",     info="<html>
<p>
  Simple controller for Throttle and ThrottlePump circuit that is based
  on a PID controller. The controlled variable needs to be connected to
  Tact.
</p>
<p>
  If the valve is fully closed, the pump will switch off. The pump
  frequency is constant, if pump is on
</p>
</html>"));
    end CtrThrottle;

    block CtrThrottleQFlow
      "Volume Flow Set Point Controller for Throttles"
             Modelica.Blocks.Interfaces.RealInput Q_flowMea
        "Connector of measurement input signal" annotation (Placement(
            transformation(extent={{-140,40},{-100,80}}), iconTransformation(extent=
               {{-140,40},{-100,80}})));
      Modelica.Blocks.Interfaces.RealInput Q_flowSet
                                                if useExternalQset
        "Connector of second Real input signal" annotation (Placement(
            transformation(extent={{-140,-70},{-100,-30}}), iconTransformation(
              extent={{-140,-70},{-100,-30}})));
      BaseClasses.HydraulicBus  hydraulicBus
        annotation (Placement(transformation(extent={{76,-24},{124,24}}),
            iconTransformation(extent={{90,-22},{138,26}})));

      parameter Boolean useExternalQset = false "If True, set Volume Flow can be given externally";
      parameter Modelica.Units.SI.Power Q_flowSetCon=0
        "Power set point of consumer in W";
      parameter Real k(min=0, unit="1") = 0.025 "Gain of controller";
      parameter Modelica.Units.SI.Time Ti(min=Modelica.Constants.small) = 130
        "Time constant of Integrator block";
      parameter Modelica.Units.SI.Time Td(min=0) = 4
        "Time constant of Derivative block";
      parameter Modelica.Units.NonSI.AngularVelocity_rpm rpm_pump(min=0) = 2000
        "Rpm of the Pump";
      parameter Modelica.Blocks.Types.Init initType=.Modelica.Blocks.Types.Init.InitialState
        "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
        annotation (Dialog(group="PID"));
      parameter Boolean reverseAction = true
        "Set to true if heating system, and false for cooling system";
      parameter Real xi_start=0
        "Initial or guess value value for integrator output (= integrator state)"
        annotation(Dialog(group="PID"));
      parameter Real xd_start=0
        "Initial or guess value for state of derivative block"
        annotation(Dialog(group="PID"));
      parameter Real y_start=0 "Initial value of output"
        annotation(Dialog(group="PID"));
      Modelica.Blocks.Sources.Constant constQ_flowSet(final k=Q_flowSetCon)
                                                                          if not useExternalQset
        annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
      AixLib.Controls.Continuous.LimPID PID(
        final yMax=1,
        final yMin=0,
        final controllerType=Modelica.Blocks.Types.SimpleController.PID,
        final k=k,
        final Ti=Ti,
        final Td=Td,
        final initType=initType,
        final xi_start=xi_start,
        final xd_start=xd_start,
        final y_start=y_start,
        final reverseActing=reverseAction)
                annotation (Placement(transformation(extent={{-20,-40},{0,-60}})));

      Modelica.Blocks.Logical.GreaterThreshold
                                            pumpSwitchOff(final threshold=0)
        annotation (Placement(transformation(extent={{20,30},{40,50}})));
      Modelica.Blocks.Sources.Constant constPumpSet(final k=rpm_pump)
        annotation (Placement(transformation(extent={{20,-10},{40,10}})));
    equation

      connect(PID.u_s, Q_flowSet) annotation (Line(
          points={{-22,-50},{-120,-50}},
          color={0,0,127},
          pattern=LinePattern.Dash));
      connect(constQ_flowSet.y, PID.u_s) annotation (Line(
          points={{-79,0},{-66,0},{-66,-50},{-22,-50}},
          color={0,0,127},
          pattern=LinePattern.Dash));

      connect(PID.u_m, Q_flowMea)
        annotation (Line(points={{-10,-38},{-10,60},{-120,60}}, color={0,0,127}));
      connect(PID.y,pumpSwitchOff. u)
        annotation (Line(points={{1,-50},{8,-50},{8,40},{18,40}},   color={0,0,127}));
      connect(pumpSwitchOff.y, hydraulicBus.pumpBus.onSet) annotation (Line(points={{41,40},
              {100.12,40},{100.12,0.12}},            color={255,0,255}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(constPumpSet.y, hydraulicBus.pumpBus.rpmSet) annotation (Line(points={
              {41,0},{70,0},{70,0.12},{100.12,0.12}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(PID.y, hydraulicBus.valveSet) annotation (Line(points={{1,-50},{100,-50},
              {100,0.12},{100.12,0.12}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),Line(
              points={{-100,100},{-36,-2},{-100,-100}},
              color={95,95,95},
              thickness=0.5),
              Text(
              extent={{-48,20},{98,-20}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              textString="Control")}),                               Diagram(
            coordinateSystem(preserveAspectRatio=false)),
                  Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),Line(
              points={{-100,100},{-36,-2},{-100,-100}},
              color={95,95,95},
              thickness=0.5),
              Text(
              extent={{-48,20},{98,-20}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              textString="Control")}),                               Diagram(
            coordinateSystem(preserveAspectRatio=false)),
                Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),Line(
              points={{-100,100},{-36,-2},{-100,-100}},
              color={95,95,95},
              thickness=0.5),
              Text(
              extent={{-48,20},{98,-20}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              textString="Control")}),
                                    Diagram(coordinateSystem(preserveAspectRatio=
                false)),
        Documentation(revisions="<html><ul>
  <li>April 14, 2021, by Phillip Stoffel:<br/>
    First implementation.
  </li>
</ul>
</html>",     info="<html>
<p>
  Simple controller for Throttle and ThrottlePump circuit that is based
  on a PID controller. The controlled variable needs to be connected to
  QFlowAct. The set point can be passed externally or as parameter.
</p>
<p>
  The controller adjusts the valve to archieve the specified thermal
  Power
</p>
</html>"));
    end CtrThrottleQFlow;

    block CtrThrottleVFlow
      "Volume Flow Set Point Controller for Throttles"
             Modelica.Blocks.Interfaces.RealInput vFlowAct
        "Connector of measurement input signal" annotation (Placement(
            transformation(extent={{-140,40},{-100,80}}), iconTransformation(extent=
               {{-140,40},{-100,80}})));
      Modelica.Blocks.Interfaces.RealInput vFlowSet
                                                if useExternalVset
        "Connector of second Real input signal" annotation (Placement(
            transformation(extent={{-140,-80},{-100,-40}}), iconTransformation(
              extent={{-140,-80},{-100,-40}})));
    public
      BaseClasses.HydraulicBus  hydraulicBus
        annotation (Placement(transformation(extent={{76,-24},{124,24}}),
            iconTransformation(extent={{90,-22},{138,26}})));
              parameter Boolean useExternalVset = false "If True, set Volume Flow can be given externally";
      parameter Modelica.Units.SI.VolumeFlowRate vFlowSetCon=0.01
        "Volume Flow in m³/s set point of consumer";
      parameter Real k(min=0, unit="1") = 0.025 "Gain of controller";
      parameter Modelica.Units.SI.Time Ti(min=Modelica.Constants.small) = 130
        "Time constant of Integrator block";
      parameter Modelica.Units.SI.Time Td(min=0) = 4
        "Time constant of Derivative block";
      parameter Modelica.Units.NonSI.AngularVelocity_rpm rpm_pump(min=0) = 2000
        "Rpm of the Pump";
      parameter Modelica.Blocks.Types.Init initType=.Modelica.Blocks.Types.Init.InitialState
        "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
        annotation (Dialog(group="PID"));
      parameter Boolean reverseAction = true
        "Set to true if heating system, and false for cooling system";
      parameter Real xi_start=0
        "Initial or guess value value for integrator output (= integrator state)"
        annotation(Dialog(group="PID"));
      parameter Real xd_start=0
        "Initial or guess value for state of derivative block"
        annotation(Dialog(group="PID"));
      parameter Real y_start=0 "Initial value of output"
        annotation(Dialog(group="PID"));
      Modelica.Blocks.Sources.Constant constVflowSet(final k=vFlowSetCon) if not useExternalVset annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
      AixLib.Controls.Continuous.LimPID PID(
        final yMax=1,
        final yMin=0,
        final controllerType=Modelica.Blocks.Types.SimpleController.PID,
        final k=k,
        final Ti=Ti,
        final Td=Td,
        final initType=initType,
        final xi_start=xi_start,
        final xd_start=xd_start,
        final y_start=y_start,
        final reverseActing=reverseAction)
                annotation (Placement(transformation(extent={{-20,-40},{0,-60}})));

      Modelica.Blocks.Logical.GreaterThreshold
                                            pumpSwitchOff(final threshold=0)
        annotation (Placement(transformation(extent={{20,30},{40,50}})));
      Modelica.Blocks.Sources.Constant constPumpSet(final k=rpm_pump)  if not useExternalVset
        annotation (Placement(transformation(extent={{20,-10},{40,10}})));
    equation

        connect(PID.u_s,vFlowSet)  annotation (Line(
          points={{-22,-50},{-67.1,-50},{-67.1,-60},{-120,-60}},
          color={0,0,127},
          pattern=LinePattern.Dash));
        connect(constVflowSet.y, PID.u_s) annotation (Line(
          points={{-79,-20},{-66,-20},{-66,-50},{-22,-50}},
          color={0,0,127},
          pattern=LinePattern.Dash));

      connect(PID.u_m,vFlowAct)
        annotation (Line(points={{-10,-38},{-10,60},{-120,60}},        color={0,0,127}));
      connect(PID.y,pumpSwitchOff. u)
        annotation (Line(points={{1,-50},{8,-50},{8,40},{18,40}},   color={0,0,127}));
      connect(pumpSwitchOff.y, hydraulicBus.pumpBus.onSet) annotation (Line(points={{41,40},
              {100.12,40},{100.12,0.12}},            color={255,0,255}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(constPumpSet.y, hydraulicBus.pumpBus.rpmSet) annotation (Line(points={
              {41,0},{70,0},{70,0.12},{100.12,0.12}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(PID.y, hydraulicBus.valveSet) annotation (Line(points={{1,-50},{100,-50},
              {100,0.12},{100.12,0.12}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),Line(
              points={{-100,100},{-36,-2},{-100,-100}},
              color={95,95,95},
              thickness=0.5),
              Text(
              extent={{-48,20},{98,-20}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              textString="Control")}),                               Diagram(
            coordinateSystem(preserveAspectRatio=false)),
                  Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),Line(
              points={{-100,100},{-36,-2},{-100,-100}},
              color={95,95,95},
              thickness=0.5),
              Text(
              extent={{-48,20},{98,-20}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              textString="Control")}),                               Diagram(
            coordinateSystem(preserveAspectRatio=false)),
                Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),Line(
              points={{-100,100},{-36,-2},{-100,-100}},
              color={95,95,95},
              thickness=0.5),
              Text(
              extent={{-48,20},{98,-20}},
              lineColor={95,95,95},
              lineThickness=0.5,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              textString="Control")}),
                                    Diagram(coordinateSystem(preserveAspectRatio=
                false)),
        Documentation(revisions="<html><ul>
  <li>April 14, 2021, by Phillip Stoffel:<br/>
    First implementation.
  </li>
</ul>
</html>",     info="<html>
<p>
  Simple controller for Throttle and ThrottlePump circuit that is based
  on a PID controller. The controlled variable needs to be connected to
  vFlowAct.
</p>
<p>
  The controller adjusts the valve to archive the specified volume flow
</p>
</html>"));
    end CtrThrottleVFlow;
    annotation (Documentation(info="<html>
</html>"));
  end Controller;

  package Example "Simple Examples"
    extends Modelica.Icons.ExamplesPackage;

    model Admix "Test for admix circuit"
      extends Modelica.Icons.Example;

      package Medium = AixLib.Media.Water
        annotation (choicesAllMatching=true);

      AixLib.DataBase.Pumps.HydraulicModules.Admix Admix(
        parameterPipe=DataBase.Pipes.Copper.Copper_35x1_5(),
        valveCharacteristic=Fluid.Actuators.Valves.Data.LinearEqualPercentage(),

        redeclare
          AixLib.DataBase.Pumps.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 per)),
        redeclare package Medium = Medium,
        m_flow_nominal=0.1,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        length=1,
        Kv=10,
        T_amb=293.15) annotation (Placement(transformation(
            extent={{-30,-30},{30,30}},
            rotation=90,
            origin={10,10})));

      AixLib.Fluid.Sources.Boundary_pT   boundary(
        nPorts=1,
        T=323.15,
        redeclare package Medium = Medium)
                  annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=-90,
            origin={-8,-50})));
      AixLib.Fluid.Sources.Boundary_pT   boundary1(
        nPorts=1,
        T=323.15,
        redeclare package Medium = Medium)
                  annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=-90,
            origin={28,-50})));

      AixLib.Fluid.FixedResistances.PressureDrop hydRes(
        m_flow_nominal=8*996/3600,
        dp_nominal=8000,
        m_flow(start=hydRes.m_flow_nominal),
        dp(start=hydRes.dp_nominal),
        redeclare package Medium = Medium)
        "Hydraulic resistance in distribution cirquit (shortcut pipe)" annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={10,60})));
      Modelica.Blocks.Sources.Ramp valveOpening(              duration=500,
          startTime=180)
        annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
      Modelica.Blocks.Sources.Constant RPM(k=2000)
        annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
      BaseClasses.HydraulicBus hydraulicBus
        annotation (Placement(transformation(extent={{-52,0},{-32,20}})));
      Modelica.Blocks.Sources.BooleanConstant pumpOn annotation (
        Placement(visible = true, transformation(origin = {-84, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation

      connect(Admix.port_b1, hydRes.port_a)
        annotation (Line(points={{-8,40},{-8,60},{0,60}},     color={0,127,255}));
      connect(Admix.port_a2, hydRes.port_b) annotation (Line(points={{28,40},{28,60},
              {20,60}},                color={0,127,255}));
      connect(Admix.port_a1, boundary.ports[1])
        annotation (Line(points={{-8,-20},{-8,-40}},         color={0,127,255}));
      connect(Admix.port_b2, boundary1.ports[1])
        annotation (Line(points={{28,-20},{28,-40}},           color={0,127,255}));
      connect(Admix.hydraulicBus, hydraulicBus) annotation (Line(
          points={{-20,10},{-42,10}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{-25,3},{-25,3}}));
      connect(valveOpening.y, hydraulicBus.valveSet) annotation (Line(points={{-79,
              10},{-60,10},{-60,10.05},{-41.95,10.05}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(RPM.y, hydraulicBus.pumpBus.rpmSet) annotation (Line(points={{-79,50},
              {-41.95,50},{-41.95,10.05}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(pumpOn.y, hydraulicBus.pumpBus.onSet) annotation (
        Line(points = {{-72, -30}, {-42, -30}, {-42, 10}}, color = {255, 0, 255}));
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
    end Admix;

    model ERC_ExperimentalHall_CoolingCircuit
      "Cooling circuit of the new ERC experimental hall"
      extends Modelica.Icons.Example;
      package Medium = AixLib.Media.Water
        "Medium within the system simulation"
        annotation (choicesAllMatching=true);
      parameter Modelica.Units.SI.Temperature T_amb=293.15 "Ambient temperature";

      AixLib.Fluid.Sources.Boundary_pT bou(nPorts=1, redeclare package Medium
          = Medium)
        annotation (Placement(transformation(extent={{-182,-78},{-162,-58}})));
      AixLib.Fluid.HeatExchangers.ConstantEffectiveness hex(
        m1_flow_nominal=0.1,
        m2_flow_nominal=0.1,
        dp1_nominal=10,
        dp2_nominal=10,
        redeclare package Medium1 = Medium,
        redeclare package Medium2 = Medium) annotation (Placement(transformation(
            extent={{-20,-25},{20,25}},
            rotation=90,
            origin={-121,-48})));
      AixLib.Fluid.Sources.MassFlowSource_T boundary(
        nPorts=1,
        m_flow=4,
        redeclare package Medium = Medium,
        T=280.15)
        annotation (Placement(transformation(extent={{-182,-38},{-162,-18}})));

      SimpleConsumer simpleConsumer(
        kA=2000,
        T_fixed=303.15,
        m_flow_nominal=1,
        redeclare package Medium = Medium,
        functionality="T_fixed",
        T_start=293.15)
        annotation (Placement(transformation(extent={{-84,36},{-54,66}})));
      SimpleConsumer simpleConsumer1(
        kA=20000,
        T_fixed=303.15,
        m_flow_nominal=1,
        redeclare package Medium = Medium,
        functionality="T_fixed",
        T_start=293.15)
        annotation (Placement(transformation(extent={{-10,36},{20,66}})));
      SimpleConsumer simpleConsumer2(
        T_fixed=303.15,
        m_flow_nominal=1,
        redeclare package Medium = Medium,
        functionality="T_fixed",
        kA=10000,
        T_start=293.15)
        annotation (Placement(transformation(extent={{60,36},{90,66}})));
      Controller.CtrMix ctrMix(
        Td=0,
        Ti=180,
        k=0.12,
        xi_start=0.5,
        initType=Modelica.Blocks.Types.Init.InitialState,
        reverseAction=false)
        annotation (Placement(transformation(extent={{-140,0},{-120,20}})));
      Controller.CtrThrottle ctrUnmixedThrottle(
        initType=Modelica.Blocks.Types.Init.InitialState,
        reverseAction=false,
        Td=0,
        rpm_pump=3000,
        TflowSet=291.15,
        k=0.2,
        Ti=60) annotation (Placement(transformation(extent={{-140,80},{-120,100}})));
      Controller.CtrPump ctrUnmixedSimple
        annotation (Placement(transformation(extent={{-140,60},{-120,80}})));
      AixLib.Fluid.Sources.Boundary_pT bou1(
        nPorts=1,
        redeclare package Medium = Medium,
        p=200000) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-106,-86})));
      AixLib.DataBase.Pumps.HydraulicModules.Pump unmixed(
        parameterPipe=DataBase.Pipes.Copper.Copper_35x1(),
        redeclare
          AixLib.DataBase.Pumps.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 per)),
        redeclare package Medium = Medium,
        m_flow_nominal=1,
        T_amb=T_amb,
        pipe1(length=2),
        pipe2(length=2),
        pipe3(length=4),
        energyDynamics=admix.energyDynamics,
        length=2) annotation (Placement(transformation(
            extent={{-25,-25},{25,25}},
            rotation=90,
            origin={6,4})));
      AixLib.DataBase.Pumps.HydraulicModules.ThrottlePump unmixedThrottle(
        parameterPipe=DataBase.Pipes.Copper.Copper_42x1_2(),
        valve(flowCharacteristics=AixLib.Fluid.Actuators.Valves.Data.Linear()),

        redeclare
          AixLib.DataBase.Pumps.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 per)),
        redeclare package Medium = Medium,
        m_flow_nominal=1,
        T_amb=T_amb,
        pipe1(length=1),
        pipe2(length=1),
        pipe3(length=1),
        energyDynamics=admix.energyDynamics,
        length=2,
        Kv=6.3,
        pipe4(length=2)) annotation (Placement(transformation(
            extent={{-25,-25},{25,25}},
            rotation=90,
            origin={74,4})));
      AixLib.DataBase.Pumps.HydraulicModules.Admix admix(
        parameterPipe=DataBase.Pipes.Copper.Copper_35x1_5(),
        valveCharacteristic=Fluid.Actuators.Valves.Data.LinearEqualPercentage(),

        redeclare
          AixLib.DataBase.Pumps.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 per)),
        redeclare package Medium = Medium,
        m_flow_nominal=1,
        T_amb=T_amb,
        pipe1(length=1),
        pipe2(length=1),
        pipe3(length=4),
        pipe4(length=5),
        pipe5(length=1),
        pipe6(length=1),
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        length=1,
        Kv=10) annotation (Placement(transformation(
            extent={{-25,-25},{25,25}},
            rotation=90,
            origin={-68,4})));
      BaseClasses.HydraulicBus hydraulicBus
        annotation (Placement(transformation(extent={{-124,94},{-104,114}})));
    equation
      connect(bou.ports[1],hex. port_a1) annotation (Line(points={{-162,-68},{-136,
              -68}},                         color={0,127,255}));
      connect(boundary.ports[1],hex. port_b1) annotation (Line(points={{-162,-28},{
              -136,-28}},                      color={0,127,255}));
      connect(bou1.ports[1], hex.port_b2)
        annotation (Line(points={{-106,-76},{-106,-68}}, color={0,127,255}));
      connect(unmixed.port_b1, simpleConsumer1.port_a)
        annotation (Line(points={{-9,29},{-9,38},{-10,38},{-10,51}},
                                                     color={0,127,255}));
      connect(unmixed.port_a2, simpleConsumer1.port_b)
        annotation (Line(points={{21,29},{21,38},{20,38},{20,51}},
                                                   color={0,127,255}));
      connect(unmixedThrottle.port_b1, simpleConsumer2.port_a)
        annotation (Line(points={{59,29},{59,38},{60,38},{60,51}},
                                                   color={0,127,255}));
      connect(unmixedThrottle.port_a2, simpleConsumer2.port_b)
        annotation (Line(points={{89,29},{89,38},{90,38},{90,51}},
                                                   color={0,127,255}));
      connect(simpleConsumer.port_a,admix.port_b1)
        annotation (Line(points={{-84,51},{-84,29},{-83,29}},
                                                     color={0,127,255}));
      connect(simpleConsumer.port_b,admix.port_a2)
        annotation (Line(points={{-54,51},{-54,29},{-53,29}},
                                                     color={0,127,255}));
      connect(ctrMix.hydraulicBus, admix.hydraulicBus) annotation (Line(
          points={{-118.6,10.2},{-104.455,10.2},{-104.455,4},{-93,4}},
          color={255,204,51},
          thickness=0.5));
      connect(ctrUnmixedSimple.hydraulicBus, unmixed.hydraulicBus) annotation (Line(
          points={{-118.6,70.2},{-19,70.2},{-19,4}},
          color={255,204,51},
          thickness=0.5));
      connect(ctrUnmixedThrottle.hydraulicBus, unmixedThrottle.hydraulicBus) annotation (Line(
          points={{-118.6,90.2},{-50,90.2},{-50,92},{50,92},{50,50},{49,50},{49,4}},
          color={255,204,51},
          thickness=0.5));
      connect(admix.port_a1, hex.port_a2) annotation (Line(points={{-83,-21},{-83,-28},{-106,-28}},
                           color={0,127,255}));
      connect(unmixed.port_a1, hex.port_a2) annotation (Line(points={{-9,-21},{-9,
              -28},{-106,-28}}, color={0,127,255}));
      connect(unmixedThrottle.port_a1, hex.port_a2) annotation (Line(points={{59,-21},
              {60,-21},{60,-28},{-106,-28}}, color={0,127,255}));
      connect(unmixedThrottle.port_b2, hex.port_b2) annotation (Line(points={{89,-21},
              {89,-68},{-106,-68}}, color={0,127,255}));
      connect(unmixed.port_b2, hex.port_b2) annotation (Line(points={{21,-21},{21,
              -68},{-106,-68}},
                           color={0,127,255}));
      connect(admix.port_b2, hex.port_b2) annotation (Line(points={{-53,-21},{-53,-68},{-106,-68}},
                           color={0,127,255}));
      connect(ctrUnmixedThrottle.hydraulicBus, hydraulicBus) annotation (Line(
          points={{-118.6,90.2},{-114.42,90.2},{-114.42,104},{-114,104}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(ctrUnmixedThrottle.Tact, hydraulicBus.TRtrnInMea) annotation (Line(
            points={{-142,96},{-152,96},{-152,104.05},{-113.95,104.05}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      annotation (Diagram(coordinateSystem(extent={{-180,-100},{100,100}})), Icon(
            coordinateSystem(extent={{-180,-100},{100,100}})),
        Documentation(revisions="<html><ul>
  <li>October 25, 2017, by Alexander Kümpel:<br/>
    First implementation.
  </li>
</ul>
</html>",     info="<html>
<p>
  This example demonstrates the use of the hydraulic modules and the
  controllers. The model represents a cooling circuit with different
  hydraulic circuits.
</p>
</html>"),
        experiment(StopTime=3600));
    end ERC_ExperimentalHall_CoolingCircuit;

    model Injection "Test for injection circuit"
      extends Modelica.Icons.Example;

      package Medium = AixLib.Media.Water
        annotation (choicesAllMatching=true);

      AixLib.DataBase.Pumps.HydraulicModules.Injection Injection(
        parameterPipe=DataBase.Pipes.Copper.Copper_35x1_5(),
        redeclare
          AixLib.DataBase.Pumps.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 per)),
        redeclare package Medium = Medium,
        m_flow_nominal=1,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        valveCharacteristic=Fluid.Actuators.Valves.Data.LinearEqualPercentage(),

        pipe8(length=0.5),
        length=1,
        Kv=10,
        pipe9(length=0.5),
        T_amb=293.15) annotation (Placement(transformation(
            extent={{-30,-30},{30,30}},
            rotation=90,
            origin={10,10})));

      AixLib.Fluid.FixedResistances.PressureDrop hydRes(
        m_flow_nominal=8*996/3600,
        dp_nominal=8000,
        m_flow(start=hydRes.m_flow_nominal),
        dp(start=hydRes.dp_nominal),
        redeclare package Medium = Medium)
        "Hydraulic resistance in distribution cirquit (shortcut pipe)" annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={10,60})));
      Modelica.Blocks.Sources.Ramp valveOpening(              duration=500,
          startTime=180)
        annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
      Modelica.Blocks.Sources.Constant RPM(k=2000)
        annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
      BaseClasses.HydraulicBus hydraulicBus
        annotation (Placement(transformation(extent={{-50,0},{-30,20}})));
      AixLib.Fluid.Sources.Boundary_pT   boundary(
        T=323.15,
        redeclare package Medium = Medium,
        nPorts=1) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=-90,
            origin={-8,-50})));
      AixLib.Fluid.Sources.Boundary_pT   boundary1(
        T=323.15,
        redeclare package Medium = Medium,
        nPorts=1) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=-90,
            origin={28,-50})));
      Modelica.Blocks.Sources.BooleanConstant pumpOn annotation (
        Placement(visible = true, transformation(origin = {-84, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation

      connect(hydraulicBus,Injection. hydraulicBus) annotation (Line(
          points={{-40,10},{-20,10}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-12,3},{-12,3}}));
      connect(hydRes.port_b, Injection.port_a2)
        annotation (Line(points={{20,60},{28,60},{28,40}},     color={0,127,255}));
      connect(hydRes.port_a, Injection.port_b1)
        annotation (Line(points={{0,60},{-8,60},{-8,40}},    color={0,127,255}));
      connect(boundary.ports[1], Injection.port_a1)
        annotation (Line(points={{-8,-40},{-8,-20}}, color={0,127,255}));
      connect(boundary1.ports[1], Injection.port_b2)
        annotation (Line(points={{28,-40},{28,-20},{28,-20}}, color={0,127,255}));
      connect(valveOpening.y, hydraulicBus.valveSet) annotation (Line(points={{-79,
              10},{-62,10},{-62,10.05},{-39.95,10.05}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(RPM.y, hydraulicBus.pumpBus.rpmSet) annotation (Line(points={{-79,50},
              {-39.95,50},{-39.95,10.05}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(pumpOn.y, hydraulicBus.pumpBus.onSet) annotation (
        Line(points = {{-72, -30}, {-40, -30}, {-40, 10}}, color = {255, 0, 255}));
                               annotation (Placement(transformation(
            extent={{-24,-24},{24,24}},
            rotation=90,
            origin={20,20})),
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
            "Resources/Scripts/Dymola/Systems/HydraulicModules/Examples/Injection.mos"
            "SImulate and plot"));
    end Injection;

    model Injection2WayValve "Test for injection circuit with a 2 way valve"
      extends Modelica.Icons.Example;

      package Medium = AixLib.Media.Water
        annotation (choicesAllMatching=true);

      AixLib.DataBase.Pumps.HydraulicModules.Injection2WayValve Injection(
        parameterPipe=DataBase.Pipes.Copper.Copper_28x1(),
        redeclare
          AixLib.DataBase.Pumps.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 per)),
        redeclare package Medium = Medium,
        m_flow_nominal=1,
        pipe7(length=0.5),
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        length=1,
        Kv=10,
        T_amb=293.15) annotation (Placement(transformation(
            extent={{-30,-30},{30,30}},
            rotation=90,
            origin={10,10})));

      AixLib.Fluid.FixedResistances.PressureDrop hydRes(
        m_flow_nominal=8*996/3600,
        dp_nominal=8000,
        m_flow(start=hydRes.m_flow_nominal),
        dp(start=hydRes.dp_nominal),
        redeclare package Medium = Medium)
        "Hydraulic resistance in distribution cirquit (shortcut pipe)" annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={10,60})));
      Modelica.Blocks.Sources.Ramp valveOpening(              duration=500,
          startTime=180)
        annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
      Modelica.Blocks.Sources.Constant RPM(k=2000)
        annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
      BaseClasses.HydraulicBus hydraulicBus
        annotation (Placement(transformation(extent={{-50,0},{-30,20}})));
      AixLib.Fluid.Sources.Boundary_pT   boundary(
        T=323.15,
        redeclare package Medium = Medium,
        nPorts=1) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=-90,
            origin={-8,-50})));
      AixLib.Fluid.Sources.Boundary_pT   boundary1(
        T=323.15,
        redeclare package Medium = Medium,
        nPorts=1) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=-90,
            origin={28,-50})));
      Modelica.Blocks.Sources.BooleanConstant pumpOn annotation (
        Placement(visible = true, transformation(origin = {-84, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation

      connect(hydraulicBus,Injection. hydraulicBus) annotation (Line(
          points={{-40,10},{-20,10}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-12,3},{-12,3}}));
      connect(hydRes.port_b, Injection.port_a2)
        annotation (Line(points={{20,60},{28,60},{28,40}},     color={0,127,255}));
      connect(hydRes.port_a, Injection.port_b1)
        annotation (Line(points={{0,60},{-8,60},{-8,40}},    color={0,127,255}));
      connect(valveOpening.y, hydraulicBus.valveSet) annotation (Line(points={{-79,
              10},{-62,10},{-62,10.05},{-39.95,10.05}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(boundary.ports[1], Injection.port_a1)
        annotation (Line(points={{-8,-40},{-8,-20}}, color={0,127,255}));
      connect(boundary1.ports[1], Injection.port_b2)
        annotation (Line(points={{28,-40},{28,-20},{28,-20}}, color={0,127,255}));
      connect(RPM.y, hydraulicBus.pumpBus.rpmSet) annotation (Line(points={{-79,50},
              {-39.95,50},{-39.95,10.05}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(pumpOn.y, hydraulicBus.pumpBus.onSet) annotation (
        Line(points = {{-72, -30}, {-40, -30}, {-40, 10}}, color = {255, 0, 255}));
                               annotation (Placement(transformation(
            extent={{-24,-24},{24,24}},
            rotation=90,
            origin={20,20})),
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
            "Resources/Scripts/Dymola/Systems/HydraulicModules/Examples/Injection2WayValve.mos"
            "SImulate and plot"));
    end Injection2WayValve;

    model Pump "Test for unmixed pump circuit"
      extends Modelica.Icons.Example;

      package Medium = AixLib.Media.Water
        annotation (choicesAllMatching=true);

      AixLib.DataBase.Pumps.HydraulicModules.Pump Unmixed(
        pipeModel="PlugFlowPipe",
        parameterPipe=DataBase.Pipes.Copper.Copper_35x1(),
        redeclare
          AixLib.DataBase.Pumps.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 per)),
        redeclare package Medium = Medium,
        m_flow_nominal=1,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        length=1,
        pipe3(length=2),
        T_amb=293.15) annotation (Placement(transformation(
            extent={{-30,-30},{30,30}},
            rotation=90,
            origin={10,10})));

      AixLib.Fluid.FixedResistances.PressureDrop hydRes(
        m_flow(start=hydRes.m_flow_nominal),
        dp(start=hydRes.dp_nominal),
        m_flow_nominal=1,
        dp_nominal=100,
        redeclare package Medium = Medium)
        "Hydraulic resistance in distribution cirquit (shortcut pipe)" annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={10,60})));
      AixLib.DataBase.Pumps.HydraulicModules.BaseClasses.HydraulicBus hydraulicBus
        annotation (Placement(transformation(extent={{-52,0},{-32,20}})));
      Modelica.Blocks.Sources.Ramp RPM_ramp(
        duration=500,
        height=3000, offset = 1,
        startTime=180)
        annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
      AixLib.Fluid.Sources.Boundary_pT   boundary(
        T=323.15,
        redeclare package Medium = Medium,
        nPorts=1) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=-90,
            origin={-8,-50})));
      AixLib.Fluid.Sources.Boundary_pT   boundary1(
        T=323.15,
        redeclare package Medium = Medium,
        nPorts=1) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=-90,
            origin={28,-50})));
      Modelica.Blocks.Sources.BooleanConstant pumpOn annotation (
        Placement(visible = true, transformation(origin = {-86, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(Unmixed.hydraulicBus, hydraulicBus) annotation (Line(
          points={{-20,10},{-42,10}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(hydRes.port_b, Unmixed.port_a2)
        annotation (Line(points={{20,60},{28,60},{28,40}},     color={0,127,255}));
      connect(hydRes.port_a, Unmixed.port_b1)
        annotation (Line(points={{0,60},{-8,60},{-8,40}},    color={0,127,255}));
      connect(boundary.ports[1], Unmixed.port_a1)
        annotation (Line(points={{-8,-40},{-8,-20}}, color={0,127,255}));
      connect(boundary1.ports[1], Unmixed.port_b2)
        annotation (Line(points={{28,-40},{28,-20},{28,-20}}, color={0,127,255}));
      connect(RPM_ramp.y, hydraulicBus.pumpBus.rpmSet) annotation (Line(points={{
              -79,10},{-60,10},{-60,10.05},{-41.95,10.05}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(pumpOn.y, hydraulicBus.pumpBus.onSet) annotation (
        Line(points={{-75,-28},{-41.95,-28},{-41.95,10.05}},
                                                           color = {255, 0, 255}));
      annotation (Placement(transformation(extent={{80,80},{100,100}})),
                  Icon(graphics,
                       coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{120,100}})),                                  Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}})),
        experiment(StopTime=800,Interval = 5),
        Documentation(revisions="<html><ul>
  <li>December 06, 2022, by EBC-Modelica group:<br/>
    Fixes to increase compatability to OpenModelica <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1378\">#1378</a>.
  </li>
  <li>October 25, 2017, by Alexander Kümpel:<br/>
    Transfer from ZUGABE to AixLib.
  </li>
</ul>
</html>"),
        __Dymola_Commands(file(ensureSimulated=true)=
            "Resources/Scripts/Dymola/Systems/HydraulicModules/Examples/Pump.mos"
            "Simulate and plot"));
    end Pump;

    model Throttle "Test for ummixed throttle circuit"
      extends Modelica.Icons.Example;

      package Medium = AixLib.Media.Water
        annotation (choicesAllMatching=true);

      AixLib.DataBase.Pumps.HydraulicModules.Throttle Throttle(
        redeclare package Medium = Medium,
        parameterPipe=DataBase.Pipes.Copper.Copper_28x1(),
        m_flow_nominal=1,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        T_amb=293.15,
        length=1,
        Kv=6.3,
        pipe3(length=2)) annotation (Placement(transformation(
            extent={{-30,-30},{30,30}},
            rotation=90,
            origin={10,10})));

      AixLib.Fluid.FixedResistances.PressureDrop hydRes(
        m_flow_nominal=8*996/3600,
        dp_nominal=8000,
        m_flow(start=hydRes.m_flow_nominal),
        dp(start=hydRes.dp_nominal),
        redeclare package Medium = Medium)
        "Hydraulic resistance in distribution cirquit (shortcut pipe)" annotation (Placement(
            transformation(
            extent={{-10,0},{10,20}},
            rotation=0,
            origin={10,50})));
      AixLib.DataBase.Pumps.HydraulicModules.BaseClasses.HydraulicBus hydraulicBus
        annotation (Placement(transformation(extent={{-52,0},{-32,20}})));
      Modelica.Blocks.Sources.Ramp valveOpening(              duration=500,
          startTime=180)
        annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
      AixLib.Fluid.Sources.Boundary_pT   boundary(
        p=boundary1.p + 1000,
        T=323.15,
        redeclare package Medium = Medium,
        nPorts=1) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=-90,
            origin={-8,-50})));
      AixLib.Fluid.Sources.Boundary_pT   boundary1(
        T=323.15,
        redeclare package Medium = Medium,
        nPorts=1) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=-90,
            origin={28,-50})));
    equation
      connect(Throttle.hydraulicBus, hydraulicBus) annotation (Line(
          points={{-20,10},{-42,10}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(hydRes.port_b, Throttle.port_a2)
        annotation (Line(points={{20,60},{28,60},{28,40}}, color={0,127,255}));
      connect(hydRes.port_a, Throttle.port_b1)
        annotation (Line(points={{0,60},{-8,60},{-8,40}},color={0,127,255}));
      connect(Throttle.port_a1, boundary.ports[1])
        annotation (Line(points={{-8,-20},{-8,-40}}, color={0,127,255}));
      connect(Throttle.port_b2, boundary1.ports[1])
        annotation (Line(points={{28,-20},{28,-40}}, color={0,127,255}));
      connect(valveOpening.y, hydraulicBus.valveSet) annotation (Line(points={{-79,
              10},{-41.95,10},{-41.95,10.05}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      annotation (Icon(graphics,
                       coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{120,100}})),                                  Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}})),
        experiment(StopTime=1000),
        Documentation(revisions="<html><ul>
  <li>October 25, 2017, by Alexander Kümpel:<br/>
    Transfer from ZUGABE to AixLib.
  </li>
</ul>
</html>"),
        __Dymola_Commands(file(ensureSimulated=true)=
            "Resources/Scripts/Dymola/Systems/HydraulicModules/Examples/Throttle.mos"
            "Simulate and plot"));
    end Throttle;

    model ThrottlePump "Test for unmixed throttle and pump circuit"
      extends Modelica.Icons.Example;

      package Medium = AixLib.Media.Water
        annotation (choicesAllMatching=true);

      AixLib.DataBase.Pumps.HydraulicModules.ThrottlePump ThrottlePump(
        parameterPipe=DataBase.Pipes.Copper.Copper_40x1(),
        redeclare
          AixLib.DataBase.Pumps.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
          PumpInterface(pump(redeclare
              AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 per)),
        redeclare package Medium = Medium,
        m_flow_nominal=1,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        length=1,
        Kv=6.3,
        T_amb=293.15) annotation (Placement(transformation(
            extent={{-30,-30},{30,30}},
            rotation=90,
            origin={10,10})));

      AixLib.Fluid.FixedResistances.PressureDrop hydRes(
        m_flow_nominal=8*996/3600,
        dp_nominal=8000,
        m_flow(start=hydRes.m_flow_nominal),
        dp(start=hydRes.dp_nominal),
        redeclare package Medium = Medium)
        "Hydraulic resistance in distribution cirquit (shortcut pipe)" annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={10,60})));
      AixLib.DataBase.Pumps.HydraulicModules.BaseClasses.HydraulicBus hydraulicBus
        annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
      Modelica.Blocks.Sources.Ramp valveOpening(              duration=500,
          startTime=180)
        annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
      Modelica.Blocks.Sources.Constant RPM(k=2000)
        annotation (Placement(transformation(extent={{-100,30},{-80,50}})));
      AixLib.Fluid.Sources.Boundary_pT   boundary(
        T=323.15,
        redeclare package Medium = Medium,
        nPorts=1) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=-90,
            origin={-8,-50})));
      AixLib.Fluid.Sources.Boundary_pT   boundary1(
        T=323.15,
        redeclare package Medium = Medium,
        nPorts=1) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=-90,
            origin={28,-50})));
      Modelica.Blocks.Sources.BooleanConstant pumpOn annotation (
        Placement(visible = true, transformation(origin = {-86, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(ThrottlePump.hydraulicBus, hydraulicBus) annotation (Line(
          points={{-20,10},{-50,10}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(ThrottlePump.port_b1, hydRes.port_a) annotation (Line(points={{-8,40},
              {-8,60},{0,60}},             color={0,127,255}));
      connect(ThrottlePump.port_a2, hydRes.port_b)
        annotation (Line(points={{28,40},{28,60},{20,60}},     color={0,127,255}));
      connect(valveOpening.y, hydraulicBus.valveSet) annotation (Line(points={{-79,
              10},{-64,10},{-64,10.05},{-49.95,10.05}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(ThrottlePump.port_a1, boundary.ports[1])
        annotation (Line(points={{-8,-20},{-8,-40},{-8,-40}}, color={0,127,255}));
      connect(ThrottlePump.port_b2, boundary1.ports[1])
        annotation (Line(points={{28,-20},{28,-40}}, color={0,127,255}));
      connect(RPM.y, hydraulicBus.pumpBus.rpmSet) annotation (Line(points={{-79,40},
              {-49.95,40},{-49.95,10.05}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(pumpOn.y, hydraulicBus.pumpBus.onSet) annotation (
        Line(points={{-75,-30},{-49.95,-30},{-49.95,10.05}},
                                                           color = {255, 0, 255}));
      annotation (Icon(graphics,
                       coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{120,100}})),                                  Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}})),
        experiment(StopTime=600),
        Documentation(revisions="<html><ul>
  <li>December 06, 2022, by EBC-Modelica group:<br/>
    Fixes to increase compatability to OpenModelica <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1378\">#1378</a>.
  </li>
  <li>October 25, 2017, by Alexander Kümpel:<br/>
    Transfer from ZUGABE to AixLib.
  </li>
</ul>
</html>"),
        __Dymola_Commands(file(ensureSimulated=true)=
            "Resources/Scripts/Dymola/Systems/HydraulicModules/Examples/ThrottlePump.mos"
            "Simulate and plot"));
    end ThrottlePump;
  end Example;

  package BaseClasses "Base classes for hydraulic modules"
    extends Modelica.Icons.BasesPackage;

    partial model BasicPumpInterface "Pump interface for different pump types"
     extends AixLib.Fluid.Interfaces.PartialTwoPortInterface;

      AixLib.Fluid.Movers.PumpsPolynomialBased.BaseClasses.PumpBus
        pumpBus annotation (Placement(transformation(extent={{-20,80},{20,120}}),
            iconTransformation(extent={{-20,80},{20,120}})));

      // Initialization
      parameter Modelica.Units.SI.Temperature T_start=Medium.T_default
        "Initialization temperature" annotation (Dialog(tab="Initialization"));

      // Dynamics
      parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
        "Type of energy balance: dynamic (3 initialization options) or steady state"
        annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));
      parameter Modelica.Fluid.Types.Dynamics massDynamics=energyDynamics
        "Type of mass balance: dynamic (3 initialization options) or steady state" annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));

      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Polygon(
              points={{20,-70},{60,-85},{20,-100},{20,-70}},
              lineColor={0,128,255},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid,
              visible=showDesignFlowDirection),
            Polygon(
              points={{20,-75},{50,-85},{20,-95},{20,-75}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              visible=system.allowFlowReversal),
            Line(
              points={{55,-85},{-60,-85}},
              color={0,128,255},
              visible=showDesignFlowDirection),
            Ellipse(
              extent={{-80,90},{80,-70}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={0,161,107}),
            Polygon(
              points={{-28,64},{-28,-40},{54,12},{-28,64}},
              lineColor={0,0,0},
              fillPattern=FillPattern.Sphere,
              fillColor={220,220,220})}),
        Diagram(coordinateSystem(preserveAspectRatio=false)),
        Documentation(revisions="<html><ul>
  <li>May 20, 2018, by Alexander Kümpel:<br/>
    First implementation.
  </li>
</ul>
</html>",     info="<html>
<p>
  This is a basic container model for different pump typs. A new
  container model for a specific pump should be extended from this
  class. In this way, replacing the pump model in the hydraulic modules
  is easy.
</p>
</html>"));
    end BasicPumpInterface;

    expandable connector HydraulicBus "Data bus for hydraulic circuits"
      extends Modelica.Icons.SignalBus;
      import      Modelica.Units.SI;
      AixLib.Fluid.Movers.PumpsPolynomialBased.BaseClasses.PumpBus
        pumpBus;
      Real valveSet(min=0, max=1) "Valve opening setpoint 0..1";
      Real valveMea(min=0, max=1) "Actual valve opening 0..1";
      SI.Temperature TFwrdInMea "Flow Temperature into forward line";
      SI.Temperature TFwrdOutMea "Flow Temperature out of forward line";
      SI.Temperature TRtrnInMea "Temperature into return line";
      SI.Temperature TRtrnOutMea "Temperature out of return line";
      SI.VolumeFlowRate VFlowInMea "Volume flow into forward line";
      SI.VolumeFlowRate VFlowOutMea "Volume flow out of forward line";
      annotation (
        Icon(graphics, coordinateSystem(preserveAspectRatio=false)),
        Diagram(graphics, coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html><p>
  Definition of a standard bus connector for hydraulic modules. A
  module bus should contain all the information that is necessary to
  exchange within a particular module type.
</p>
<ul>
  <li>January 09, 2020, by Alexander Kümpel:<br/>
    Variables renamed.
  </li>
  <li>October 25, 2017, by Alexander Kümpel:<br/>
    Adaption for hydraulic modules in AixLib.
  </li>
  <li>February 6, 2016, by Peter Matthes:<br/>
    First implementation.
  </li>
</ul>
</html>"));
    end HydraulicBus;

    partial model PartialHydraulicModule "Base class for hydraulic module."
      extends AixLib.Fluid.Interfaces.PartialFourPort(
        redeclare package Medium1 = Medium,
        redeclare package Medium2 = Medium,
        final allowFlowReversal1 = allowFlowReversal,
        final allowFlowReversal2 = allowFlowReversal);
      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
        "Medium in the system" annotation (choicesAllMatching=true);

      // General Parameters
      parameter String pipeModel="SimplePipe" annotation(choices(
                  choice="SimplePipe",
                  choice="PlugFlowPipe"),Dialog(group="Parameters"));
      parameter Modelica.Units.SI.Length length
        "Pipe length of all pipes (can be overwritten in each pipe)"
        annotation (Dialog(group="Pipes"));
      parameter DataBase.Pipes.PipeBaseDataDefinition parameterPipe=
          AixLib.DataBase.Pipes.Copper.Copper_6x1() "Pipe type and diameter (can be overwritten in each pipe)" annotation (choicesAllMatching=true, Dialog(group="Pipes"));
      parameter DataBase.Pipes.InsulationBaseDataDefinition parameterIso=
          AixLib.DataBase.Pipes.Insulation.Iso50pc() "Insulation Type (can be overwritten in each pipe)" annotation (choicesAllMatching=true, Dialog(group="Pipes"));
      parameter Real Kv "Kv value of valve (can be overwritten in the valve)"  annotation (Dialog(group="Actuators"));
      parameter Modelica.Units.SI.MassFlowRate m_flow_nominal(min=0)
        "Nominal mass flow rate" annotation (Dialog(group="Nominal condition"));

      // Initialization
      parameter Modelica.Units.SI.Temperature T_start=303.15
        "Initialization temperature" annotation (Dialog(tab="Initialization"));

      // Advanced
      parameter Modelica.Units.SI.Time tau=15
        "Time Constant for PT1 behavior of temperature sensors"
        annotation (Dialog(tab="Advanced"));
      parameter Modelica.Units.SI.Temperature T_amb=298.15
        "Ambient temperature for heat loss" annotation (Dialog(tab="Advanced"));
      parameter Modelica.Units.SI.Time tauHeaTra=parameterPipe.d_i*parameterPipe.d_i
          /4*1000*4180*(log(parameterPipe.d_i/parameterPipe.d_o)/2/parameterPipe.lambda
           + log(parameterPipe.d_o/parameterPipe.d_o*(1 + parameterIso.factor))/2/
          parameterIso.lambda + 1/hCon/parameterPipe.d_o*(1 + parameterIso.factor))
        "Time constant for heat transfer of temperature sensors to ambient"
        annotation (Dialog(tab="Advanced"));
      parameter Modelica.Units.SI.CoefficientOfHeatTransfer hCon=4
        "Convection heat transfer coeffient for all pipes"
        annotation (Dialog(tab="Advanced"));

      // Assumptions
      parameter Boolean allowFlowReversal=true
        "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
        annotation (Dialog(tab="Assumptions"), Evaluate=true);

      // Dynamics
      parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
        "Type of energy balance: dynamic (3 initialization options) or steady state"
        annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));
      parameter Modelica.Fluid.Types.Dynamics massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
        "Type of mass balance: dynamic (3 initialization options) or steady state" annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));

      BaseClasses.HydraulicBus hydraulicBus annotation (Placement(transformation(
              extent={{-20,80},{20,120}}), iconTransformation(extent={{-20,80},{20,120}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
        prescribedTemperature annotation (Placement(transformation(
            extent={{-8,-8},{8,8}},
            rotation=180,
            origin={40,-20})));

      Modelica.Blocks.Sources.Constant const(k=T_amb)
        annotation (Placement(transformation(extent={{72,-28},{56,-12}})));

      // -------------------------------------------------
      // Sensors
      // -------------------------------------------------

    protected
      Fluid.Sensors.VolumeFlowRate VFSen_out(
        redeclare package Medium = Medium,
        T_start=T_start,
        final m_flow_nominal=m_flow_nominal,
        final allowFlowReversal=allowFlowReversal)
        "Inflow into admix module in forward line" annotation (Placement(
            transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={-100,40})));
      Fluid.Sensors.VolumeFlowRate VFSen_in(
        redeclare package Medium = Medium,
        final m_flow_nominal=m_flow_nominal,
        T_start=T_start,
        final allowFlowReversal=allowFlowReversal) "Outflow out of forward line"
        annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=90,
            origin={100,42})));

      Fluid.Sensors.TemperatureTwoPort senT_a1(
        tau=0.01,
        T_start=T_start,
        redeclare package Medium = Medium,
        transferHeat=true,
        final TAmb=T_amb,
        final m_flow_nominal=m_flow_nominal,
        final allowFlowReversal=allowFlowReversal,
        tauHeaTra=tauHeaTra)
        annotation (Placement(transformation(extent={{-100,14},{-88,26}})));
      Fluid.Sensors.TemperatureTwoPort senT_a2(
        redeclare package Medium = Medium,
        tau=0.01,
        transferHeat=true,
        final TAmb=T_amb,
        final m_flow_nominal=m_flow_nominal,
        T_start=T_start,
        final allowFlowReversal=allowFlowReversal,
        tauHeaTra=tauHeaTra)
        annotation (Placement(transformation(extent={{84,-66},{72,-54}})));
      Fluid.Sensors.TemperatureTwoPort senT_b1(
        final m_flow_nominal=m_flow_nominal,
        tau=0.01,
        T_start=T_start,
        redeclare package Medium = Medium,
        transferHeat=true,
        final TAmb=T_amb,
        final allowFlowReversal=allowFlowReversal,
        tauHeaTra=tauHeaTra)
        annotation (Placement(transformation(extent={{88,14},{100,26}})));
      Fluid.Sensors.TemperatureTwoPort senT_b2(
        tau=0.01,
        T_start=T_start,
        redeclare package Medium = Medium,
        transferHeat=true,
        final TAmb=T_amb,
        final m_flow_nominal=m_flow_nominal,
        final allowFlowReversal=allowFlowReversal,
        tauHeaTra=tauHeaTra)
        annotation (Placement(transformation(extent={{-78,-66},{-90,-54}})));

      Modelica.Blocks.Continuous.FirstOrder PT1_b2(
        initType=Modelica.Blocks.Types.Init.SteadyState,
        y_start=T_start,
        final T=tau) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=0,
            origin={-110,-30})));
      Modelica.Blocks.Continuous.FirstOrder PT1_b1(
        initType=Modelica.Blocks.Types.Init.SteadyState,
        y_start=T_start,
        final T=tau) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={70,70})));
      Modelica.Blocks.Continuous.FirstOrder PT1_a1(
        initType=Modelica.Blocks.Types.Init.SteadyState,
        y_start=T_start,
        final T=tau) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={-70,70})));
      Modelica.Blocks.Continuous.FirstOrder PT1_a2(
        initType=Modelica.Blocks.Types.Init.SteadyState,
        y_start=T_start,
        final T=tau) annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=180,
            origin={110,-30})));

    equation

      connect(VFSen_out.V_flow, hydraulicBus.VFlowInMea) annotation (Line(
          points={{-111,40},{-112,40},{-112,100.1},{0.1,100.1}},
          color={0,0,127},
          visible=true), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(VFSen_in.V_flow,hydraulicBus.VFlowOutMea)  annotation (Line(
          points={{111,42},{116,42},{116,100.1},{0.1,100.1}},
          color={0,0,127},
          visible=true), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(VFSen_out.port_a, port_a1)
        annotation (Line(points={{-100,50},{-100,60}}, color={0,127,255}));
      connect(VFSen_in.port_b, port_b1)
        annotation (Line(points={{100,52},{100,60}}, color={0,127,255}));
      connect(port_b2, senT_b2.port_b)
        annotation (Line(points={{-100,-60},{-90,-60}}, color={0,127,255}));
      connect(VFSen_out.port_b, senT_a1.port_a) annotation (Line(points={{-100,30},{
              -100,20}},                  color={0,127,255}));
      connect(senT_b1.port_b, VFSen_in.port_a)
        annotation (Line(points={{100,20},{100,32}}, color={0,127,255}));
      connect(senT_a2.port_a, port_a2) annotation (Line(points={{84,-60},{92,-60},{92,
              -60},{100,-60}}, color={0,127,255}));
      connect(PT1_b2.u, senT_b2.T) annotation (Line(points={{-98,-30},{-84,-30},{-84,
              -53.4}}, color={0,0,127}));
      connect(senT_a1.T, PT1_a1.u) annotation (Line(points={{-94,26.6},{-82,26.6},{-82,
              58},{-70,58}}, color={0,0,127}));
      connect(senT_b1.T, PT1_b1.u) annotation (Line(points={{94,26.6},{86,26.6},{86,
              58},{70,58}}, color={0,0,127}));
      connect(PT1_b1.y, hydraulicBus.TFwrdOutMea) annotation (Line(points={{70,81},
              {70,100.1},{0.1,100.1}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(PT1_a1.y, hydraulicBus.TFwrdInMea) annotation (Line(points={{-70,81},
              {-70,100},{0.1,100},{0.1,100.1}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(PT1_b2.y, hydraulicBus.TRtrnOutMea) annotation (Line(points={{-121,-30},
              {-122,-30},{-122,100},{0.1,100},{0.1,100.1}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(senT_a2.T, PT1_a2.u)
        annotation (Line(points={{78,-53.4},{78,-30},{98,-30}}, color={0,0,127}));
      connect(PT1_a2.y, hydraulicBus.TRtrnInMea) annotation (Line(points={{121,-30},
              {130,-30},{130,100},{116,100},{116,100.1},{0.1,100.1}}, color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(const.y, prescribedTemperature.T)
        annotation (Line(points={{55.2,-20},{49.6,-20}}, color={0,0,127}));
      annotation (
        Documentation(info="<html><p>
  Admix circuit with a replaceable pump model for the distribution of
  hot or cold water. All sensor and actor values are connected to the
  hydraulic bus.
</p>
<h4>
  Characteristics
</h4>
<p>
  There is a connecting pipe between distributer and collector of
  manifold so that the pressure difference between them becomes
  insignificant. The main pump only works against the resistance in the
  main circuit.
</p>
<p>
  The mass flow in primary and secondary circuits stay constant.
</p>
<p>
  The secondary circuits do not affect each other when switching
  operational modes.
</p>
<ul>
  <li>August, 2018, by Alexander Kümpel:<br/>
    First implementation
  </li>
</ul>
</html>"),
        experiment(StopTime=86400),
        Icon(coordinateSystem(extent={{-100,-100},{100,100}}),
             graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.Dash),
            Line(
              points={{0,100}},
              color={95,95,95},
              thickness=0.5),
            Line(
              points={{-92,60},{98,60}},
              color={0,127,255},
              thickness=0.5),
            Line(
              points={{-94,-60},{96,-60}},
              color={0,127,255},
              thickness=0.5),
            Ellipse(
              extent={{-78,-38},{-62,-54}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-78,68},{-62,52}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-78,84},{-62,68}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{62,84},{78,68}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{62,68},{78,52}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{62,-38},{78,-54}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{70,-54},{70,-60}}, color={0,0,0}),
            Line(points={{-70,-54},{-70,-60}}, color={0,0,0}),
            Text(
              extent={{-78,-38},{-62,-54}},
              lineColor={216,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textString="T"),
            Text(
              extent={{-78,68},{-62,52}},
              lineColor={0,128,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textString="Q"),
            Text(
              extent={{-78,84},{-62,68}},
              lineColor={216,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textString="T"),
            Text(
              extent={{62,84},{78,68}},
              lineColor={216,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textString="T"),
            Text(
              extent={{62,68},{78,52}},
              lineColor={0,128,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textString="Q"),
            Text(
              extent={{62,-38},{78,-54}},
              lineColor={216,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textString="T"),
            Line(points={{-40,86},{88,86},{82,90}}, color={0,0,0}),
            Line(points={{88,86},{82,82}}, color={0,0,0}),
            Text(
              extent={{34,98},{80,88}},
              lineColor={95,95,95},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textString="Fwrd"),
            Line(
              points={{-64,-2},{64,-2},{58,2}},
              color={0,0,0},
              origin={-16,-76},
              rotation=180),
            Line(points={{-74,-70},{-80,-74}}, color={0,0,0}),
            Text(
              extent={{-76,-76},{-30,-86}},
              lineColor={95,95,95},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textString="Rtrn")}),
        Diagram(coordinateSystem(extent={{-120,-120},{120,120}}, initialScale=0.1)));
    end PartialHydraulicModule;

    model PumpInterface_PumpHeadControlled
      "Head controlled polynomial based pump with controller"
      extends
        AixLib.DataBase.Pumps.HydraulicModules.BaseClasses.BasicPumpInterface;

      parameter AixLib.DataBase.Pumps.PumpPolynomialBased.PumpBaseRecord pumpParam = AixLib.DataBase.Pumps.PumpPolynomialBased.PumpBaseRecord()
        "pump parameter record" annotation (choicesAllMatching=true);

      parameter Medium.AbsolutePressure p_start=Medium.p_default "Start value for pressure."
        annotation (Dialog(tab="Initialization", group="Pressure"));

      // Assumptions
      parameter Modelica.Units.SI.Volume V=0 "Volume inside the pump"
        annotation (Dialog(tab="Assumptions"), Evaluate=true);

      // Power and Efficiency
      parameter Boolean calculatePower=true "calc. power consumption?"
        annotation (Dialog(tab="General", group="Power and Efficiency"));
      parameter Boolean calculateEfficiency=false
        "calc. efficency? (eta = f(H, Q, P))" annotation (Dialog(
          tab="General",
          group="Power and Efficiency",
          enable=calculate_Power));

      Fluid.Movers.PumpsPolynomialBased.PumpHeadControlled physics(
        final allowFlowReversal=allowFlowReversal,
        final m_flow_nominal=m_flow_nominal,
        final pumpParam=pumpParam,
        redeclare final package Medium = Medium,
        final p_start=p_start,
        final T_start=T_start,
        final V=V,
        final energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
        final massDynamics=massDynamics,
        final calculatePower=calculatePower,
        final calculateEfficiency=calculateEfficiency,
        redeclare final function efficiencyCharacteristic =
            Fluid.Movers.PumpsPolynomialBased.BaseClasses.efficiencyCharacteristic.Wilo_Formula_efficiency)
        annotation (Placement(transformation(extent={{-30,-30},{30,30}})));

    equation
      connect(physics.port_a, port_a) annotation (Line(points={{-30,0},{-100,0}},
                                color={0,127,255}));
      connect(physics.port_b, port_b) annotation (Line(points={{30,0},{100,0}},
                           color={0,127,255}));
      connect(physics.pumpBus, pumpBus) annotation (Line(
          points={{0,30},{0,65},{0,65},{0,100}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Text(
              extent={{80,-40},{322,-58}},
              lineColor={0,0,0},
              horizontalAlignment=TextAlignment.Left,
              fontName="monospace",
              textString="CA: n_set"),
            Text(
              extent={{80,-60},{322,-78}},
              lineColor={0,0,0},
              horizontalAlignment=TextAlignment.Left,
              fontName="monospace",
              textString="H: %Hnom% m",
              visible=true),
            Text(
              extent={{80,-80},{338,-98}},
              lineColor={0,0,0},
              horizontalAlignment=TextAlignment.Left,
              fontName="monospace",
              textString="Q: %Qnom% m³/h",
              visible=true),
            Text(
              extent={{80,-20},{300,-38}},
              lineColor={0,0,0},
              horizontalAlignment=TextAlignment.Left,
              fontName="monospace",
              textString="%pumpParam.pumpModelString%")}),
        Diagram(coordinateSystem(preserveAspectRatio=false)),
        Documentation(revisions="<html><ul>
  <li>2019-09-18 by Alexander Kümpel:<br/>
    Renaming and extension from BasicPumpInterface.
  </li>
  <li>2018-03-01 by Peter Matthes:<br/>
    Improved parameter setup of pump model. Ordering in GUI, disabled
    some parameters that should be used not as input but rather as
    outputs (m_flow_start, p_a_start and p_b_start) and much more
    description in the parameter doc strings to help the user make
    better decisions.
  </li>
  <li>2018-02-01 by Peter Matthes:<br/>
    Fixes option choicesAllMatching=true for controller. Needs to be
    __Dymola_choicesAllMatching=true. Sets standard control algorithm
    to dp_var (<code><span style=
    \"color: #ff0000;\">PumpControlDeltaPvar</span></code>).
  </li>
  <li>2018-01-30 by Peter Matthes:<br/>
    * Renamed delivery head controlled pump model (blue) from Pump into
    PumpH as well as PumpPhysics into PumpPhysicsH. \"H\" stands for pump
    delivery head.<br/>
    * Moved efficiencyCharacteristic package directly into BaseClasses.
    This is due to moving the older pump model and depencencies into
    the Deprecated folder.
  </li>
  <li>2018-01-29 by Peter Matthes:<br/>
    * Removes parameter useABCcurves as that is the default to
    calculate speed and is only needed in the blue pump (PumpH) to
    calculate power from speed and volume flow. Currently there is no
    other way to compute speed other than inverting function H = f(Q,N)
    . This can only be done with the quadratic ABC formula. Therefore,
    an assert statement has been implemented instead to give a warning
    when you want to compute power but you use more that the ABC
    coefficients in cHQN.<br/>
    * Moves the energyBanlance and massBalance to the Assumptions tab
    as done in the PartialLumpedVolume model.<br/>
    * Removes replaceable function for efficiency calculation. There is
    only one formula at the moment and no change in sight so that we
    can declutter the GUI.<br/>
    * Removes parameter Nnom and replaces it with Nstart. As discussed
    with Wilo Nnom is not very useful and it can be replaced with a
    start value. The default value has been lowered to a medium speed
    to avoid collision with the speed/power limitation. For most pumps
    the maximum speed is limited for increasing volume flows to avoid
    excess power consumption.<br/>
    * Increases Qnom from 0.5*Qmax to 0.67*Qmax as this would be a more
    realistic value.
  </li>
  <li>2018-01-26 by Peter Matthes:<br/>
    * Changes parameter name n_start into Nstart to be
    compatible/exchangeable with the speed controlled pump (red
    pump).<br/>
    * Adds missing parameters to be compatible with red pump.
  </li>
  <li>2017-11-22 by Peter Matthes:<br/>
    Initial implementation.
  </li>
</ul>
</html>",     info="<html>
<p>
  Pump container for the
  AixLib.Fluid.Movers.PumpsPolynomialBased.PumpHeadControlled
</p>
</html>"));
    end PumpInterface_PumpHeadControlled;

    model PumpInterface_PumpSpeedControlled
      "Speed controlled polynomial based pump with controller"
      extends
        AixLib.DataBase.Pumps.HydraulicModules.BaseClasses.BasicPumpInterface;
      parameter AixLib.DataBase.Pumps.PumpPolynomialBased.PumpBaseRecord pumpParam=AixLib.DataBase.Pumps.PumpPolynomialBased.PumpBaseRecord()
        "pump parameter record" annotation (choicesAllMatching=true);

      parameter Medium.AbsolutePressure p_start=Medium.p_default "Start value for pressure."
        annotation (Dialog(tab="Initialization", group="Pressure"));

      parameter Modelica.Units.SI.Volume V=0 "Volume inside the pump"
        annotation (Dialog(tab="Assumptions"), Evaluate=true);
      // Power and Efficiency
      parameter Boolean calculatePower=false "calc. power consumption?"
        annotation (Dialog(tab="General", group="Power and Efficiency"));
      parameter Boolean calculateEfficiency=false
        "calc. efficency? (eta = f(H, Q, P))" annotation (Dialog(
          tab="General",
          group="Power and Efficiency",
          enable=calculate_Power));

      Fluid.Movers.PumpsPolynomialBased.PumpSpeedControlled physics(
        final allowFlowReversal=allowFlowReversal,
        final m_flow_nominal=m_flow_nominal,
        final pumpParam=pumpParam,
        redeclare final package Medium = Medium,
        final p_start=p_start,
        final T_start=T_start,
        final V=V,
        final energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
        final massDynamics=massDynamics,
        final calculatePower=calculatePower,
        final calculateEfficiency=calculateEfficiency,
        redeclare final function efficiencyCharacteristic =
            Fluid.Movers.PumpsPolynomialBased.BaseClasses.efficiencyCharacteristic.Wilo_Formula_efficiency)
        annotation (Placement(transformation(extent={{-30,-30},{30,30}})));

    equation
      connect(physics.port_a, port_a) annotation (Line(points={{-30,0},{-100,0}},
                                color={0,127,255}));
      connect(physics.port_b, port_b) annotation (Line(points={{30,0},{100,0}},
                           color={0,127,255}));
      connect(physics.pumpBus, pumpBus) annotation (Line(
          points={{0,30},{0,66},{0,66},{0,100}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Text(
              extent={{80,-40},{322,-58}},
              lineColor={0,0,0},
              horizontalAlignment=TextAlignment.Left,
              fontName="monospace",
              textString="CA: n_set"),
            Text(
              extent={{80,-60},{322,-78}},
              lineColor={0,0,0},
              horizontalAlignment=TextAlignment.Left,
              fontName="monospace",
              textString="H: %Hnom% m",
              visible=true),
            Text(
              extent={{80,-80},{338,-98}},
              lineColor={0,0,0},
              horizontalAlignment=TextAlignment.Left,
              fontName="monospace",
              textString="Q: %Qnom% m³/h",
              visible=true),
            Text(
              extent={{80,-20},{300,-38}},
              lineColor={0,0,0},
              horizontalAlignment=TextAlignment.Left,
              fontName="monospace",
              textString="%pumpParam.pumpModelString%")}),
        Diagram(coordinateSystem(preserveAspectRatio=false)),
        Documentation(revisions="<html><ul>
  <li>2019-09-18 by Alexander Kümpel:<br/>
    Renaming and extension from BasicPumpInterface.
  </li>
  <li>2018-03-01 by Peter Matthes:<br/>
    Improved parameter setup of pump model. Ordering in GUI, disabled
    some parameters that should be used not as input but rather as
    outputs (m_flow_start, p_a_start and p_b_start) and much more
    description in the parameter doc strings to help the user make
    better decisions.
  </li>
  <li>2018-02-01 by Peter Matthes:<br/>
    Fixes option choicesAllMatching=true for controller. Needs to be
    __Dymola_choicesAllMatching=true. Sets standard control algorithm
    to n_set (<code><span style=
    \"color: #ff0000;\">PumpControlNset</span></code>).
  </li>
  <li>2018-01-30 by Peter Matthes:<br/>
    * Renamed speed controlled pump model (red) from PumpNbound into
    PumpN as well as PumpPhysicsNbound into PumpPhysicsN. \"N\" stands
    for pump speed.<br/>
    * Moved efficiencyCharacteristic package directly into BaseClasses.
    This is due to moving the older pump model and depencencies into
    the Deprecated folder.
  </li>
  <li>2018-01-29 by Peter Matthes:<br/>
    * Removes parameter useABCcurves as that is the default to
    calculate speed and is only needed in the blue pump (PumpH) to
    calculate power from speed and volume flow. Currently there is no
    other way to compute speed other than inverting function H = f(Q,N)
    . This can only be done with the quadratic ABC formula. Therefore,
    an assert statement has been implemented instead to give a warning
    when you want to compute power but you use more that the ABC
    coefficients in cHQN.<br/>
    * Moves the energyBanlance and massBalance to the Assumptions tab
    as done in the PartialLumpedVolume model.<br/>
    * Removes replaceable function for efficiency calculation. There is
    only one formula at the moment and no change in sight so that we
    can declutter the GUI.<br/>
    * Removes parameter Nnom and replaces it with Nstart. As discussed
    with Wilo Nnom is not very useful and it can be replaced with a
    start value. The default value has been lowered to a medium speed
    to avoid collision with the speed/power limitation. For most pumps
    the maximum speed is limited for increasing volume flows to avoid
    excess power consumption.<br/>
    * Increases Qnom from 0.5*Qmax to 0.67*Qmax as this would be a more
    realistic value.
  </li>
  <li>2018-01-26 by Peter Matthes:<br/>
    * In calculation of m_flow_start changes reference to X_start into
    physics.X_start.<br/>
    * Changes Nnom from 80 % to 100 % of Nmax.
  </li>
  <li>2018-01-15 by Peter Matthes:<br/>
    Changes minimum mass flow rate in ports to
    +/-<code>1.5*<span style=\"color: #ff0000;\">max</span>(pumpParam.maxMinSpeedCurves[:,&#160;1])</code>
    in order to reduce search space.
  </li>
  <li>2018-01-10 by Peter Matthes:<br/>
    Adds parameter T_start to be compatible with PumpPyhsicsNbound
    model. This way this parameter can be transfert automatically when
    changing classes.
  </li>
  <li>2017-12-12 by Peter Matthes:<br/>
    Changes parameter name n_start into Nnom.
  </li>
  <li>2017-12-05 by Peter Matthes:<br/>
    Initial implementation (derived from Pump model with limitation of
    pump head). Changes nominal volume flow rate to
    \"Qnom=0.5*max(pumpParam.maxMinSpeedCurves[:,1])\".
  </li>
</ul>
</html>",     info="<html>
<p>
  Pump container for the
  AixLib.Fluid.Movers.PumpsPolynomialBased.PumpSpeedControlled
</p>
</html>"));
    end PumpInterface_PumpSpeedControlled;

    model PumpInterface_SpeedControlledNrpm
      "Interface for the SpeedControlled_Nrpm pump model"
      extends
        AixLib.DataBase.Pumps.HydraulicModules.BaseClasses.BasicPumpInterface;
      Fluid.Movers.SpeedControlled_Nrpm pump(
        redeclare package Medium = Medium,
        final energyDynamics=energyDynamics,
        T_start=T_start) annotation (Dialog(enable=true), Placement(transformation(
              extent={{-10,-10},{10,10}})));
      Modelica.Blocks.Logical.Switch switchToZero
        annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=270,
            origin={0,36})));
      Modelica.Blocks.Sources.Constant constZero(final k=0)
        annotation (Placement(transformation(extent={{-40,60},{-19,80}})));
    equation
      connect(pump.port_a, port_a)
        annotation (Line(points={{-10,0},{-100,0}}, color={0,127,255}));
      connect(pump.port_b, port_b)
        annotation (Line(points={{10,0},{100,0}}, color={0,127,255}));
      connect(pump.P, pumpBus.PelMea) annotation (Line(points={{11,9},{11,14},{22,
              14},{22,100.5},{0.1,100.5},{0.1,100.1}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pump.y_actual, pumpBus.rpmMea) annotation (Line(points={{11,7},{26,7},
              {26,100.1},{0.1,100.1}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(constZero.y, switchToZero.u3) annotation (Line(points={{-17.95,70},{-8,70},{-8,48}}, color={0,0,127}));
      connect(switchToZero.u2, pumpBus.onSet) annotation (Line(points={{2.22045e-15,
              48},{2.22045e-15,100.1},{0.1,100.1}}, color={255,0,255}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(switchToZero.y, pump.Nrpm) annotation (Line(points={{-1.9984e-15,25},{0,25},{0,12}},   color={0,0,127}));
      connect(switchToZero.u1, pumpBus.rpmSet) annotation (Line(points={{8,48},{8,
              92},{0.1,92},{0.1,100.1}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      annotation (Documentation(revisions="<html><ul>
  <li>May 20, 2018, by Alexander Kümpel:<br/>
    First implementation.
  </li>
</ul>
</html>",     info="<html>
<p>
  Pump container for the SpeedControlled_Nrpm pump.
</p>
</html>"));
    end PumpInterface_SpeedControlledNrpm;
  end BaseClasses;
end HydraulicModules;
