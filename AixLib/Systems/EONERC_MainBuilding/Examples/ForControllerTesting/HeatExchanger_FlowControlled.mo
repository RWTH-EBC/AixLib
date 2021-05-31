within AixLib.Systems.EONERC_MainBuilding.Examples.ForControllerTesting;
model HeatExchanger_FlowControlled
  "Test of heat exachgner model of E.ON ERC main building"
  extends Modelica.Icons.Example;
    package Medium = AixLib.Media.Water
    annotation (choicesAllMatching=true);

  Fluid.Sources.Boundary_pT          boundary(
    redeclare package Medium = Medium,
    use_T_in=true,
    T=333.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-78,-18})));
  Fluid.Sources.Boundary_pT          boundary1(
    redeclare package Medium = Medium,
    T=303.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-78,10})));
  Fluid.Sources.Boundary_pT          boundary4(
    redeclare package Medium = Medium,
    use_T_in=true,
    T=303.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={20,-80})));
  Fluid.Sources.Boundary_pT          boundary5(
    redeclare package Medium = Medium,
    T=303.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={60,-80})));
  HeatExchangerSystem heatExchangerSystem(
    redeclare package Medium = Medium,
    m_flow_nominal=10,
    T_start=293.15)
    annotation (Placement(transformation(extent={{-40,-40},{68,40}})));
  Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = Medium,
    m_flow_nominal=2,
    V=0.1,
    nPorts=2) annotation (Placement(transformation(extent={{70,58},{50,78}})));
  BaseClasses.TwoCircuitBus hxBus1
    annotation (Placement(transformation(extent={{10,54},{30,74}})));
  Controller.CtrHXmflow ctrHXmflow(
    k=1,
    Ti=20,
    rpmPumpPrim=2500,
    rpmPumpSec=2500)
    annotation (Placement(transformation(extent={{-56,58},{-36,78}})));
  Modelica.Blocks.Interfaces.RealInput T_in_sec
    "Prescribed boundary temperature" annotation (Placement(transformation(
          extent={{-122,-102},{-100,-80}}), iconTransformation(extent={{-122,
            -102},{-100,-80}})));
  Modelica.Blocks.Interfaces.RealInput T_in_prim
    "Prescribed boundary temperature" annotation (Placement(transformation(
          extent={{-118,-32},{-98,-12}}),  iconTransformation(extent={{-118,-32},
            {-98,-12}})));
  Modelica.Blocks.Interfaces.RealInput mflowSet_prim
    "Connector of setpoint input signal" annotation (Placement(transformation(
          extent={{-122,62},{-100,84}}), iconTransformation(extent={{-122,62},{
            -100,84}})));
  Modelica.Blocks.Interfaces.RealInput mflowSet_sec
    "Connector of setpoint input signal" annotation (Placement(transformation(
          extent={{-126,26},{-100,52}}), iconTransformation(extent={{-126,26},{
            -100,52}})));
equation
  connect(heatExchangerSystem.port_a1, boundary.ports[1]) annotation (Line(
        points={{-40,-8},{-56,-8},{-56,-18},{-68,-18}},
                                                    color={0,127,255}));
  connect(heatExchangerSystem.port_b1, boundary1.ports[1]) annotation (Line(
        points={{-40,8},{-56,8},{-56,10},{-68,10}},     color={0,127,255}));
  connect(boundary4.ports[1], heatExchangerSystem.port_a2) annotation (Line(
        points={{20,-70},{44.8571,-70},{44.8571,-40}}, color={0,127,255}));
  connect(boundary5.ports[1], heatExchangerSystem.port_b3) annotation (Line(
        points={{60,-70},{60,-39.2},{60.2857,-39.2}}, color={0,127,255}));
  connect(heatExchangerSystem.port_b2, vol.ports[1]) annotation (Line(points={{44.8571,
          40},{46,40},{46,60},{62,60},{62,58}},         color={0,127,255}));
  connect(heatExchangerSystem.port_a3, vol.ports[2]) annotation (Line(points={{60.2857,
          40},{60,40},{60,58},{58,58}},         color={0,127,255}));
  connect(heatExchangerSystem.hxBus, hxBus1) annotation (Line(
      points={{9.37143,40},{12,40},{12,64},{20,64}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrHXmflow.hxBus, heatExchangerSystem.hxBus) annotation (Line(
      points={{-34.9,68.1},{10.55,68.1},{10.55,40},{9.37143,40}},
      color={255,204,51},
      thickness=0.5));
  connect(boundary4.T_in, T_in_sec) annotation (Line(points={{24,-92},{-40,-92},
          {-40,-91},{-111,-91}}, color={0,0,127}));
  connect(boundary.T_in, T_in_prim)
    annotation (Line(points={{-90,-22},{-98,-22},{-98,-20},{-102,-20},{-102,-22},
          {-108,-22}},                              color={0,0,127}));
  connect(ctrHXmflow.mflowSet_prim, mflowSet_prim) annotation (Line(points={{
          -56,73.4},{-102,73.4},{-102,73},{-111,73}}, color={0,0,127}));
  connect(ctrHXmflow.mflowSet_sec, mflowSet_sec) annotation (Line(points={{-56,
          62.2},{-72,62.2},{-72,39},{-113,39}}, color={0,0,127}));
  annotation (experiment(StopTime=23400),__Dymola_Commands(file(ensureSimulated=
           true)=
        "Resources/Scripts/Dymola/Systems/EONERC_MainBuilding/Validation/Simulate_and_plot_HeatExchanger.mos"
        "Simulate and plot"));
end HeatExchanger_FlowControlled;
