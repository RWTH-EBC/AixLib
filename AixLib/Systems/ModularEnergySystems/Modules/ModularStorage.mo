within AixLib.Systems.ModularEnergySystems.Modules;
package ModularStorage
  model ScalableStorage

    parameter Integer n=10 "number of layers";
    parameter Modelica.Units.SI.Volume V=10 "Volume";
    parameter Modelica.Units.SI.MassFlowRate m_Flow=3;
    parameter Modelica.Units.SI.Temperature T_start=318.15;
     parameter Modelica.Units.SI.Temperature TColdNom=311.15;
     parameter Modelica.Units.SI.Temperature THotNom=273.15+45;
     parameter Modelica.Units.SI.TemperatureDifference DeltaT=5;

    Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
          AixLib.Media.Water)
      annotation (Placement(transformation(extent={{-110,70},{-90,90}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
          AixLib.Media.Water)
      annotation (Placement(transformation(extent={{-110,-90},{-90,-70}})));

    Fluid.MixingVolumes.MixingVolume layer[n](
      redeclare package Medium = AixLib.Media.Water,
      T_start=T_start,
      m_flow_nominal=m_Flow,
      V=V/n,
      nPorts=2) annotation (Placement(transformation(extent={{60,-10},{80,10}})));
    Modelica.Blocks.Math.MultiSum multiSum( nu=n)
      annotation (Placement(transformation(extent={{80,28},{68,40}})));
    Modelica.Blocks.Math.Division division
      annotation (Placement(transformation(extent={{0,18},{-20,38}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=n)
      annotation (Placement(transformation(extent={{44,2},{24,22}})));
    Modelica.Blocks.Math.Add add(k2=-1)
      annotation (Placement(transformation(extent={{-40,62},{-60,82}})));
    Modelica.Blocks.Math.Division division1
      annotation (Placement(transformation(extent={{-154,-16},{-174,4}})));
    Modelica.Blocks.Math.Add add1(k2=-1)
      annotation (Placement(transformation(extent={{-40,-40},{-60,-20}})));
    Modelica.Blocks.Sources.RealExpression realExpression1(y=TColdNom)
      annotation (Placement(transformation(extent={{-100,-70},{-40,-50}})));
    Modelica.Blocks.Interfaces.RealOutput y
      annotation (Placement(transformation(extent={{-100,20},{-120,40}})));
    HeatTransferOnly heatTransferOnly(
      n=n,
      V=V,
      m_flow_nom=m_Flow)
      annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
    Modelica.Blocks.Nonlinear.Limiter limiter(uMax=2, uMin=0)
      annotation (Placement(transformation(extent={{-170,60},{-150,80}})));
    Modelica.Blocks.Sources.RealExpression realExpression2(y=THotNom)
      annotation (Placement(transformation(extent={{114,-38},{60,-16}})));
    Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor[n]
      annotation (Placement(transformation(extent={{82,70},{62,90}})));
    Modelica.Blocks.Interfaces.RealInput u
      annotation (Placement(transformation(extent={{140,-72},{100,-32}})));
    Modelica.Blocks.Sources.RealExpression realExpression3(y=DeltaT)
      annotation (Placement(transformation(extent={{36,-100},{-4,-76}})));
  equation

    connect(heatTransferOnly.therm, layer.heatPort);

    connect(port_a, layer[1].ports[1]);
    connect(layer[n].ports[2], port_b);
    connect(temperatureSensor[n].T, multiSum.u[n]);
    connect(layer[n].heatPort, temperatureSensor[n].port);



    //Connect layers
    for k in 1:n - 1 loop
      connect(layer[k].ports[2], layer[k + 1].ports[1]);
       connect(temperatureSensor[k].T, multiSum.u[k]);
       connect(layer[k].heatPort, temperatureSensor[k].port);
    end for;


    connect(multiSum.y, division.u1)
      annotation (Line(points={{66.98,34},{2,34}},    color={0,0,127}));
    connect(realExpression.y, division.u2) annotation (Line(points={{23,12},{8,12},
            {8,22},{2,22}},     color={0,0,127}));
    connect(division.y, add.u1) annotation (Line(points={{-21,28},{-26,28},{-26,78},
            {-38,78}},                   color={0,0,127}));
    connect(add.y, division1.u1) annotation (Line(points={{-61,72},{-68,72},{-68,8},
            {-120,8},{-120,0},{-152,0}},
                       color={0,0,127}));
    connect(division1.y, limiter.u) annotation (Line(points={{-175,-6},{-196,-6},{
            -196,70},{-172,70}}, color={0,0,127}));
    connect(limiter.y, y) annotation (Line(points={{-149,70},{-90,70},{-90,30},{-110,
            30}}, color={0,0,127}));

    connect(u, add1.u1) annotation (Line(points={{120,-52},{28,-52},{28,-24},{-38,
            -24}}, color={0,0,127}));
    connect(realExpression3.y, division1.u2) annotation (Line(points={{-6,-88},{-38,
            -88},{-38,-90},{-144,-90},{-144,-12},{-152,-12}}, color={0,0,127}));
    connect(realExpression3.y, add1.u2) annotation (Line(points={{-6,-88},{-12,
            -88},{-12,-36},{-38,-36}}, color={0,0,127}));
    connect(add1.y, add.u2) annotation (Line(points={{-61,-30},{-70,-30},{-70,6},
            {-38,6},{-38,66}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end ScalableStorage;

  model StoragePhysical

    parameter Modelica.Units.SI.Volume V=10 "Volume";
    parameter  Modelica.Units.SI.Temperature T_start=313.15;

    parameter Real StartLoad=0.5;

     package Medium = AixLib.Media.Water;

    Modelica.Units.SI.Mass m_hot(start=V*Medium.d_const*StartLoad);
    Modelica.Units.SI.Mass m_cold(start=V*Medium.d_const*(1-StartLoad));



     Modelica.Units.SI.Heat H_cold;
     Modelica.Units.SI.Heat H_hot;
     Modelica.Units.SI.Temperature T_hot;
    Modelica.Units.SI.Temperature T_cold;


    Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
          AixLib.Media.Water)
      annotation (Placement(transformation(extent={{-110,70},{-90,90}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
          AixLib.Media.Water)
      annotation (Placement(transformation(extent={{-110,-90},{-90,-70}})));
  equation

    port_a.m_flow=der(m_hot);
    port_b.m_flow=der(m_cold);

    m_hot=V*Medium.d_const-m_cold;

    H_hot=m_hot*Medium.cp_const*(T_hot-Medium.reference_T);
    der(H_hot)=der(m_hot)*actualStream(port_a.h_outflow);
    der(H_hot)=m_hot*Medium.cp_const*der(T_hot);

    H_cold=m_cold*Medium.cp_const*(T_cold-Medium.reference_T);
    der(H_cold)=m_cold*Medium.cp_const*der(T_cold);
    der(H_cold)=der(m_cold)*actualStream(port_b.h_outflow);

    port_a.p=port_b.p;
    actualStream(port_a.Xi_outflow)=actualStream(port_b.Xi_outflow);
    actualStream(port_a.C_outflow)=actualStream(port_b.C_outflow);

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end StoragePhysical;

  model Storage_SemiPhysical


    parameter Modelica.Units.SI.Volume V=10;

     parameter Real StartLoad=0.5;

     package Medium = AixLib.Media.Water;




    Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
          Media.Water)
      annotation (Placement(transformation(extent={{-110,70},{-90,90}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
          Media.Water)
      annotation (Placement(transformation(extent={{-110,-90},{-90,-70}})));
    Fluid.Sources.Boundary_pT bou(redeclare package Medium = Media.Water, nPorts=1)
      annotation (Placement(transformation(extent={{86,60},{66,80}})));
    Fluid.Sources.MassFlowSource_T boundary(
      redeclare package Medium = AixLib.Media.Water,
      use_m_flow_in=true,
      m_flow=0,
      use_T_in=true,
      T=323.15,
      nPorts=1) annotation (Placement(transformation(extent={{62,10},{42,30}})));
    Fluid.Sources.Boundary_pT bou1(redeclare package Medium =
          AixLib.Media.Water,
        nPorts=1)
      annotation (Placement(transformation(extent={{90,-50},{70,-30}})));
    Fluid.Sources.MassFlowSource_T boundary1(
      redeclare package Medium = AixLib.Media.Water,
      use_m_flow_in=true,
      use_T_in=true,
      nPorts=1)
      annotation (Placement(transformation(extent={{-14,-90},{-34,-70}})));
    Fluid.Actuators.Valves.TwoWayLinear val1(
      redeclare package Medium = AixLib.Media.Water,
      allowFlowReversal=false,
      m_flow_nominal=3,
      show_T=false,
      dpValve_nominal=1,
      use_inputFilter=false,
      riseTime=1)
      annotation (Placement(transformation(extent={{-30,60},{-10,80}})));
    Fluid.Sensors.MassFlowRate        senMasFloHP(redeclare package Medium =
          AixLib.Media.Water) annotation (Placement(transformation(
          extent={{8,8},{-8,-8}},
          rotation=180,
          origin={14,70})));
    Fluid.Sensors.MassFlowRate        senMasFloHP1(redeclare package Medium =
          Media.Water)        annotation (Placement(transformation(
          extent={{8,8},{-8,-8}},
          rotation=180,
          origin={16,-40})));
    Modelica.Blocks.Continuous.Integrator integrator(use_reset=true, use_set=true,
      initType=Modelica.Blocks.Types.Init.InitialState,
      y_start=V*Medium.d_const*(StartLoad))
      annotation (Placement(transformation(extent={{156,62},{176,82}})));
    Modelica.Blocks.Continuous.Integrator integrator1(
      use_reset=true,
      use_set=true,
      initType=Modelica.Blocks.Types.Init.InitialState,
      y_start=V*Medium.d_const*(1 - StartLoad))
      annotation (Placement(transformation(extent={{156,-50},{176,-30}})));
    Modelica.Blocks.Interfaces.BooleanInput u
      annotation (Placement(transformation(extent={{-140,0},{-100,40}})));
    Modelica.Blocks.Logical.Switch switch1
      annotation (Placement(transformation(extent={{100,38},{120,58}})));
    Modelica.Blocks.Math.Gain gain(k=-1)
      annotation (Placement(transformation(extent={{14,34},{26,46}})));
    Modelica.Blocks.Logical.Switch switch2
      annotation (Placement(transformation(extent={{102,-26},{122,-6}})));
    Modelica.Blocks.Math.Gain gain1(k=-1)
      annotation (Placement(transformation(extent={{56,-16},{68,-4}})));
    Modelica.Blocks.Nonlinear.Limiter limiter(uMax=V*Medium.d_const, uMin=0)
      annotation (Placement(transformation(extent={{194,62},{214,82}})));
    Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=V*Medium.d_const, uMin=0)
      annotation (Placement(transformation(extent={{196,-40},{216,-20}})));
    Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
      annotation (Placement(transformation(extent={{142,12},{162,32}})));
    Modelica.Blocks.Logical.Switch switch3
      annotation (Placement(transformation(extent={{-66,96},{-46,116}})));
    Modelica.Blocks.Logical.Switch switch4
      annotation (Placement(transformation(extent={{-70,-24},{-50,-4}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=1)
      annotation (Placement(transformation(extent={{-142,104},{-122,124}})));
    Modelica.Blocks.Sources.RealExpression realExpression1(y=1)
      annotation (Placement(transformation(extent={{-128,-40},{-108,-20}})));
    Modelica.Blocks.Sources.RealExpression realExpression2(y=0)
      annotation (Placement(transformation(extent={{-150,-16},{-130,4}})));
    Modelica.Blocks.Sources.RealExpression realExpression3(y=0)
      annotation (Placement(transformation(extent={{-158,88},{-138,108}})));
    Fluid.Actuators.Valves.TwoWayLinear val2(
      redeclare package Medium = AixLib.Media.Water,
      allowFlowReversal=false,
      m_flow_nominal=3,
      show_T=false,
      dpValve_nominal=1,
      use_inputFilter=false,
      riseTime=1)
      annotation (Placement(transformation(extent={{-34,-50},{-14,-30}})));
    Fluid.Sensors.TemperatureTwoPort senTHot(
      redeclare final package Medium = AixLib.Media.Water,
      final m_flow_nominal=3,
      final initType=Modelica.Blocks.Types.Init.InitialState,
      final transferHeat=false,
      final allowFlowReversal=false,
      final m_flow_small=0.001)
      "Temperature sensor of hot side of heat generator (supply)" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={44,70})));
    Fluid.Sensors.TemperatureTwoPort senTCold(
      redeclare final package Medium = AixLib.Media.Water,
      final m_flow_nominal=3,
      final initType=Modelica.Blocks.Types.Init.InitialState,
      final transferHeat=false,
      final allowFlowReversal=false,
      final m_flow_small=0.001)
      "Temperature sensor of hot side of heat generator (supply)" annotation (
        Placement(transformation(
          extent={{-9,-8},{9,8}},
          rotation=0,
          origin={47,-40})));
    Modelica.Blocks.Logical.Switch switch5
      annotation (Placement(transformation(extent={{178,-80},{160,-62}})));
    Modelica.Blocks.Logical.Switch switch6
      annotation (Placement(transformation(extent={{202,14},{184,32}})));
    Modelica.Blocks.Logical.GreaterThreshold greaterThreshold
      annotation (Placement(transformation(extent={{298,14},{280,32}})));
    Modelica.Blocks.Logical.GreaterThreshold greaterThreshold1
      annotation (Placement(transformation(extent={{240,-80},{222,-62}})));
    Fluid.Sensors.TemperatureTwoPort senTColdExit(
      redeclare final package Medium = AixLib.Media.Water,
      final m_flow_nominal=3,
      final initType=Modelica.Blocks.Types.Init.InitialState,
      final transferHeat=false,
      final allowFlowReversal=true,
      final m_flow_small=0.001)
      "Temperature sensor of hot side of heat generator (supply)" annotation (
        Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=0,
          origin={-78,-80})));
    Fluid.Sensors.TemperatureTwoPort senTHotExit(
      redeclare final package Medium = AixLib.Media.Water,
      final m_flow_nominal=3,
      final initType=Modelica.Blocks.Types.Init.InitialState,
      T_start=323.15,
      final transferHeat=false,
      final allowFlowReversal=true,
      final m_flow_small=0.001)
      "Temperature sensor of hot side of heat generator (supply)" annotation (
        Placement(transformation(
          extent={{-8,-10},{8,10}},
          rotation=0,
          origin={-72,80})));
  equation
    connect(val1.port_b, senMasFloHP.port_a)
      annotation (Line(points={{-10,70},{6,70}}, color={0,127,255}));
    connect(senMasFloHP.m_flow, boundary1.m_flow_in) annotation (Line(points={{14,78.8},
            {14,92},{140,92},{140,-72},{-12,-72}},       color={0,0,127}));
    connect(senMasFloHP1.m_flow, boundary.m_flow_in) annotation (Line(points={{16,
            -31.2},{16,0},{84,0},{84,28},{64,28}}, color={0,0,127}));
    connect(u, switch1.u2) annotation (Line(points={{-120,20},{-68,20},{-68,48},{98,
            48}}, color={255,0,255}));
    connect(senMasFloHP.m_flow, switch1.u1)
      annotation (Line(points={{14,78.8},{14,56},{98,56}}, color={0,0,127}));
    connect(switch1.y, integrator.u) annotation (Line(points={{121,48},{128,48},{128,
            72},{154,72}}, color={0,0,127}));
    connect(gain.y, switch1.u3)
      annotation (Line(points={{26.6,40},{98,40}}, color={0,0,127}));
    connect(senMasFloHP1.m_flow, gain.u) annotation (Line(points={{16,-31.2},{10,-31.2},
            {10,-32},{6,-32},{6,40},{12.8,40}}, color={0,0,127}));
    connect(senMasFloHP1.m_flow, switch2.u3)
      annotation (Line(points={{16,-31.2},{16,-24},{100,-24}},color={0,0,127}));
    connect(gain1.y, switch2.u1) annotation (Line(points={{68.6,-10},{88,-10},{88,
            -8},{100,-8}},  color={0,0,127}));
    connect(switch2.y, integrator1.u) annotation (Line(points={{123,-16},{130,
            -16},{130,-40},{154,-40}},
                                  color={0,0,127}));
    connect(senMasFloHP.m_flow, gain1.u) annotation (Line(points={{14,78.8},{14,92},
            {36,92},{36,-10},{54.8,-10}}, color={0,0,127}));
    connect(integrator1.y, limiter1.u)
      annotation (Line(points={{177,-40},{186,-40},{186,-30},{194,-30}},
                                                     color={0,0,127}));
    connect(limiter1.y, integrator1.set) annotation (Line(points={{217,-30},{
            222,-30},{222,-10},{172,-10},{172,-28}},
                                          color={0,0,127}));
    connect(limiter.y, integrator.set) annotation (Line(points={{215,72},{226,72},
            {226,102},{172,102},{172,84}}, color={0,0,127}));
    connect(integrator.y, limiter.u)
      annotation (Line(points={{177,72},{192,72}}, color={0,0,127}));
    connect(booleanExpression.y, integrator.reset)
      annotation (Line(points={{163,22},{172,22},{172,60}}, color={255,0,255}));
    connect(booleanExpression.y, integrator1.reset)
      annotation (Line(points={{163,22},{118,22},{118,-2},{94,-2},{94,-52},{172,
            -52}},                                           color={255,0,255}));
    connect(switch3.y, val1.y)
      annotation (Line(points={{-45,106},{-20,106},{-20,82}}, color={0,0,127}));
    connect(u, switch3.u2) annotation (Line(points={{-120,20},{-88,20},{-88,106},{
            -68,106}}, color={255,0,255}));
    connect(u, switch4.u2) annotation (Line(points={{-120,20},{-88,20},{-88,-14},{
            -72,-14}}, color={255,0,255}));
    connect(realExpression.y, switch3.u1)
      annotation (Line(points={{-121,114},{-68,114}}, color={0,0,127}));
    connect(realExpression1.y, switch4.u3) annotation (Line(points={{-107,-30},{-90,
            -30},{-90,-22},{-72,-22}}, color={0,0,127}));
    connect(realExpression2.y, switch4.u1) annotation (Line(points={{-129,-6},{-122,
            -6},{-122,-14},{-108,-14},{-108,-6},{-72,-6}}, color={0,0,127}));
    connect(realExpression3.y, switch3.u3)
      annotation (Line(points={{-137,98},{-68,98}}, color={0,0,127}));
    connect(val2.port_b, senMasFloHP1.port_a) annotation (Line(points={{-14,-40},{
            -8,-40},{-8,-40},{8,-40}}, color={0,127,255}));
    connect(switch4.y, val2.y) annotation (Line(points={{-49,-14},{-40,-14},{-40,-16},
            {-24,-16},{-24,-28}}, color={0,0,127}));
    connect(senMasFloHP.port_b, senTHot.port_a)
      annotation (Line(points={{22,70},{34,70}}, color={0,127,255}));
    connect(senTHot.port_b, bou.ports[1])
      annotation (Line(points={{54,70},{66,70}}, color={0,127,255}));
    connect(senMasFloHP1.port_b, senTCold.port_a)
      annotation (Line(points={{24,-40},{38,-40}}, color={0,127,255}));
    connect(senTCold.port_b, bou1.ports[1])
      annotation (Line(points={{56,-40},{70,-40}}, color={0,127,255}));
    connect(u, switch2.u2) annotation (Line(points={{-120,20},{-10,20},{-10,-16},{
            100,-16}}, color={255,0,255}));
    connect(limiter.y, greaterThreshold.u) annotation (Line(points={{215,72},{366,
            72},{366,24},{299.8,24},{299.8,23}}, color={0,0,127}));
    connect(greaterThreshold.y, switch6.u2)
      annotation (Line(points={{279.1,23},{203.8,23}}, color={255,0,255}));
    connect(switch6.y, boundary.T_in) annotation (Line(points={{183.1,23},{118,23},
            {118,24},{64,24}}, color={0,0,127}));
    connect(greaterThreshold1.y, switch5.u2) annotation (Line(points={{221.1,-71},
            {192,-71},{192,-71},{179.8,-71}}, color={255,0,255}));
    connect(switch5.y, boundary1.T_in) annotation (Line(points={{159.1,-71},{
            -12,-71},{-12,-76}},
                        color={0,0,127}));
    connect(limiter1.y, greaterThreshold1.u) annotation (Line(points={{217,-30},
            {242,-30},{242,-44},{268,-44},{268,-71},{241.8,-71}}, color={0,0,
            127}));
    connect(val2.port_a, senTColdExit.port_b) annotation (Line(points={{-34,-40},
            {-54,-40},{-54,-80},{-70,-80}}, color={0,127,255}));
    connect(boundary1.ports[1], senTColdExit.port_b)
      annotation (Line(points={{-34,-80},{-70,-80}}, color={0,127,255}));
    connect(senTColdExit.port_a, port_b)
      annotation (Line(points={{-86,-80},{-100,-80}}, color={0,127,255}));
    connect(senTHotExit.port_b, val1.port_a) annotation (Line(points={{-64,80},
            {-46,80},{-46,70},{-30,70}}, color={0,127,255}));
    connect(boundary.ports[1], senTHotExit.port_b) annotation (Line(points={{42,
            20},{6,20},{6,24},{-64,24},{-64,80}}, color={0,127,255}));
    connect(port_a, senTHotExit.port_a)
      annotation (Line(points={{-100,80},{-80,80}}, color={0,127,255}));
    connect(senTHotExit.T, switch5.u3) annotation (Line(points={{-72,91},{34,91},
            {34,94},{196,94},{196,-78.2},{179.8,-78.2}}, color={0,0,127}));
    connect(senTColdExit.T, switch6.u3) annotation (Line(points={{-78,-71.2},{
            -78,15.8},{203.8,15.8}}, color={0,0,127}));
    connect(senTColdExit.T, switch5.u1) annotation (Line(points={{-78,-71.2},{
            -78,-60},{179.8,-60},{179.8,-63.8}}, color={0,0,127}));
    connect(senTHotExit.T, switch6.u1) annotation (Line(points={{-72,91},{94,91},
            {94,102},{234,102},{234,32},{203.8,32},{203.8,30.2}}, color={0,0,
            127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Storage_SemiPhysical;

  model HeatTransferOnly

    Modelica.Units.SI.HeatFlowRate[n - 1] qFlow "Heat flow rate from segment i+1 to i";

      parameter Integer n(min=2)=150 "Number of layers";

     package Medium = AixLib.Media.Water "Medium model" annotation(choicesAllMatching);

      parameter Modelica.Units.SI.Volume V;
      parameter Modelica.Units.SI.MassFlowRate m_flow_nom "nominal mass flow rate of design point";

    Modelica.Units.SI.TemperatureDifference dT[n - 1]
      "Temperature difference between adjoining volumes";
    parameter Modelica.Units.SI.ThermalConductivity lambdaWater=0.64
      "Thermal conductivity of water";

  protected
    parameter Modelica.Units.SI.VolumeFlowRate V_flow_exp=0.25/3600 "Volume flow rate from experiment EBC-MA473";
    parameter Modelica.Units.SI.MassFlowRate m_flow_exp=V_flow_exp*Medium.d_const;
    parameter Modelica.Units.SI.Length diameter_exp=0.5 "diameter from experiment EBC-MA473";

    parameter Modelica.Units.SI.Area A=Modelica.Constants.pi/4*diameter_exp^2*m_flow_nom/m_flow_exp
      "Area of heat transfer between layers";
    parameter Modelica.Units.SI.Length height=V/A;

       Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[n] therm annotation (
        Placement(transformation(extent={{40,0},{60,20}}, rotation=0)));

  equation

    for i in 1:n-1 loop
      dT[i] = therm[i].T-therm[i+1].T;
      qFlow[i] = lambdaWater*A/height*dT[i];
    end for;

    // Positive heat flows here mean negative heat flows for the fluid layers
    therm[1].Q_flow = qFlow[1];
    for i in 2:n-1 loop
         therm[i].Q_flow = -qFlow[i-1]+qFlow[i];
    end for;
    therm[n].Q_flow = -qFlow[n-1];
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}),
                        graphics), Documentation(info="<html>
<p><b><span style=\"color: #008000;\">Overview</span> </b></p>
<p>Model for heat transfer between buffer storage layers. Models conductance of water. An effective heat conductivity is therefore calculated. Used in BufferStorage model. </p>
<p>Adaption from AixLib.Fluid.Storage.BaseClasses.HeatTransferOnlyConduction by mzu</p>
<p><b><span style=\"color: #008000;\">Sources</span> </b></p>
<p>R. Viskanta, A. KaraIds: Interferometric observations of the temperature structure in water cooled or heated from above. <i>Advances in Water Resources,</i> volume 1, 1977, pages 57-69. Bibtex-Key [R.VISKANTA1977] </p>
</html>",
     revisions="<html><ul>
  <li>
    <i>October 12, 2016&#160;</i> by Marcus Fuchs:<br/>
    Add comments and fix documentation
  </li>
  <li>
    <i>October 11, 2016&#160;</i> by Sebastian Stinner:<br/>
    Added to AixLib
  </li>
  <li>
    <i>December 10, 2013</i> by Kristian Huchtemann:<br/>
    New implementation in source code. Documentation.
  </li>
  <li>
    <i>October 2, 2013&#160;</i> by Ole Odendahl:<br/>
    Added documentation and formatted appropriately
  </li>
</ul>
</html>"),
      Icon(graphics={Text(
            extent={{-100,-60},{100,-100}},
            lineColor={0,0,255},
            textString="%name")}));
  end HeatTransferOnly;

  model GridStorage

    parameter Modelica.Units.SI.MassFlowRate m_Flow=3;
    parameter Modelica.Units.SI.Temperature T_start=45+273.15;
    parameter Modelica.Units.SI.Temperature TColdNom=38+273.15;

    parameter Modelica.Units.SI.Volume V=10 "Volume";


    Modules.ModularStorage.ScalableStorage scalableStorage(
      n=n,
      V=V,
      m_Flow=m_Flow,
      T_start=T_start,
      TColdNom=TColdNom)
      annotation (Placement(transformation(extent={{80,-18},{100,2}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a_Supply(redeclare package
        Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater)
      annotation (Placement(transformation(extent={{-110,10},{-90,30}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b_Supply(redeclare package
        Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater)
      annotation (Placement(transformation(extent={{-110,70},{-90,90}})));
    Fluid.Sensors.TemperatureTwoPort senTemStorageHot(redeclare package Medium =
          AixLib.Media.Water, m_flow_nominal=m_Flow)
      annotation (Placement(transformation(extent={{14,10},{32,30}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b_Return(redeclare package
        Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater)
      annotation (Placement(transformation(extent={{-110,-90},{-90,-70}})));
    Modelica.Blocks.Interfaces.RealInput T_Supply_Set
      annotation (Placement(transformation(extent={{-140,120},{-100,160}})));

    Modelica.Fluid.Interfaces.FluidPort_a port_a_Return(redeclare package
        Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater)
      annotation (Placement(transformation(extent={{-110,-30},{-90,-10}})));

    Fluid.Actuators.Valves.TwoWayLinear valSupply(
      redeclare package Medium = AixLib.Media.Water,
      allowFlowReversal=false,
      m_flow_nominal=m_Flow,
      dpValve_nominal=6000,
      use_inputFilter=false) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=-90,
          origin={-60,40})));
    Fluid.Actuators.Valves.TwoWayLinear valRetrunAdd(
      redeclare package Medium = AixLib.Media.Water,
      allowFlowReversal=true,
      m_flow_nominal=m_Flow,
      dpValve_nominal=6000,
      use_inputFilter=false)
      annotation (Placement(transformation(extent={{18,-26},{-2,-6}})));
    Fluid.Sensors.TemperatureTwoPort senTemSupply(redeclare package Medium =
          AixLib.Media.Water, m_flow_nominal=m_Flow)
      annotation (Placement(transformation(extent={{-70,68},{-86,92}})));
    AixLib.Controls.Continuous.LimPID PID_ReturnAdd(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.1,
      Ti=30,
      yMax=1,
      yMin=0,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      xi_start=T_start,
      y_start=1)
      annotation (Placement(transformation(extent={{-16,108},{4,128}})));
    Fluid.Actuators.Valves.TwoWayLinear valCold(
      redeclare package Medium = AixLib.Media.Water,
      allowFlowReversal=true,
      m_flow_nominal=m_Flow,
      dpValve_nominal=6000)
      annotation (Placement(transformation(extent={{-20,-58},{0,-38}})));
    Fluid.Sensors.TemperatureTwoPort senTemStorageCold(redeclare package Medium =
          AixLib.Media.Water, m_flow_nominal=m_Flow)
      annotation (Placement(transformation(extent={{60,-58},{40,-38}})));
    Fluid.Sensors.TemperatureTwoPort senTemStorageColdFeedback(redeclare
        package Medium =
                 AixLib.Media.Water, m_flow_nominal=m_Flow)
      annotation (Placement(transformation(extent={{76,-26},{56,-6}})));
    Fluid.Sensors.TemperatureTwoPort senTemReturn(redeclare package Medium =
          AixLib.Media.Water, m_flow_nominal=m_Flow)
      annotation (Placement(transformation(extent={{-68,-88},{-86,-72}})));
    Modelica.Blocks.Interfaces.RealOutput y
      annotation (Placement(transformation(extent={{-100,-10},{-120,10}})));

    AixLib.Controls.Continuous.LimPID PID_Supply(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.1,
      Ti=30,
      yMax=1,
      yMin=0,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      xi_start=TColdNom,
      y_start=1) annotation (Placement(transformation(extent={{-2,30},{-22,50}})));
    Fluid.Sensors.TemperatureTwoPort senTemReturn1(redeclare package Medium =
          AixLib.Media.Water, m_flow_nominal=m_Flow)
      annotation (Placement(transformation(extent={{-88,-30},{-72,-10}})));
    Modelica.Blocks.Sources.RealExpression tColdNom(y=TColdNom)
      annotation (Placement(transformation(extent={{54,30},{22,50}})));
    Modelica.Blocks.Math.Gain gain(k=-1)
      annotation (Placement(transformation(extent={{-62,162},{-42,182}})));
    Modelica.Blocks.Math.Gain gain1(k=-1)
      annotation (Placement(transformation(extent={{-78,110},{-58,130}})));
    AixLib.Controls.Continuous.LimPID PID_Return(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.1,
      Ti=30,
      yMax=1,
      yMin=0,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      xi_start=TColdNom,
      y_start=1)
      annotation (Placement(transformation(extent={{-22,-106},{-2,-86}})));
    Fluid.Actuators.Valves.TwoWayLinear valReturn(
      redeclare package Medium = AixLib.Media.Water,
      allowFlowReversal=true,
      m_flow_nominal=m_Flow,
      dpValve_nominal=6000) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-60,-50})));
    Modelica.Blocks.Math.Add add(k2=-1)
      annotation (Placement(transformation(extent={{60,-112},{80,-92}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=1)
      annotation (Placement(transformation(extent={{30,-106},{50,-86}})));
    AixLib.Controls.Continuous.LimPID PID_Return1(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.1,
      Ti=30,
      yMax=1,
      yMin=0,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      xi_start=TColdNom,
      y_start=1)
      annotation (Placement(transformation(extent={{84,110},{104,130}})));
  protected
     parameter Integer n=100 "number of layers";
  equation
    connect(port_a_Supply, port_a_Supply)
      annotation (Line(points={{-100,20},{-100,20}}, color={0,127,255}));
    connect(port_a_Return, port_a_Return)
      annotation (Line(points={{-100,-20},{-100,-20}}, color={0,127,255}));
    connect(port_a_Supply, valSupply.port_a)
      annotation (Line(points={{-100,20},{-60,20},{-60,30}}, color={0,127,255}));
    connect(valSupply.port_b, senTemSupply.port_a)
      annotation (Line(points={{-60,50},{-60,80},{-70,80}}, color={0,127,255}));
    connect(valRetrunAdd.port_b, senTemSupply.port_a) annotation (Line(points={{-2,-16},
            {-30,-16},{-30,80},{-70,80}},      color={0,127,255}));
    connect(senTemSupply.port_b, port_b_Supply)
      annotation (Line(points={{-86,80},{-100,80}}, color={0,127,255}));
    connect(port_a_Supply, senTemStorageHot.port_a)
      annotation (Line(points={{-100,20},{14,20}}, color={0,127,255}));
    connect(scalableStorage.port_b, senTemStorageCold.port_a)
      annotation (Line(points={{80,-16},{80,-48},{60,-48}}, color={0,127,255}));
    connect(senTemStorageCold.port_b, valCold.port_b)
      annotation (Line(points={{40,-48},{0,-48}}, color={0,127,255}));
    connect(scalableStorage.port_b, senTemStorageColdFeedback.port_a)
      annotation (Line(points={{80,-16},{76,-16}}, color={0,127,255}));
    connect(senTemStorageColdFeedback.port_b, valRetrunAdd.port_a)
      annotation (Line(points={{56,-16},{18,-16}},color={0,127,255}));
    connect(senTemReturn.port_b, port_b_Return)
      annotation (Line(points={{-86,-80},{-100,-80}}, color={0,127,255}));
    connect(scalableStorage.y, y) annotation (Line(points={{79,-5},{64,-5},{64,0},
            {-110,0}},                 color={0,0,127}));
    connect(senTemReturn1.port_b, valCold.port_a) annotation (Line(points={{-72,-20},
            {-32,-20},{-32,-48},{-20,-48}}, color={0,127,255}));
    connect(senTemReturn1.port_a, port_a_Return)
      annotation (Line(points={{-88,-20},{-100,-20}}, color={0,127,255}));
    connect(senTemReturn1.T, PID_Supply.u_m) annotation (Line(points={{-80,-9},
            {-80,22},{-12,22},{-12,28}},            color={0,0,127}));
    connect(PID_Supply.y, valSupply.y) annotation (Line(points={{-23,40},{-48,
            40}},                            color={0,0,127}));
    connect(tColdNom.y, PID_Supply.u_s) annotation (Line(points={{20.4,40},{0,
            40}},             color={0,0,127}));
    connect(PID_ReturnAdd.y, valRetrunAdd.y) annotation (Line(points={{5,118},{
            8,118},{8,-4}},                  color={0,0,127}));
    connect(gain1.y, PID_ReturnAdd.u_m) annotation (Line(points={{-57,120},{-57,
            92},{-6,92},{-6,106}},                       color={0,0,127}));
    connect(gain.y, PID_ReturnAdd.u_s) annotation (Line(points={{-41,172},{-41,
            118},{-18,118}},                                             color={0,
            0,127}));
    connect(T_Supply_Set, gain.u)
      annotation (Line(points={{-120,140},{-92,140},{-92,172},{-64,172}},
                                                      color={0,0,127}));
    connect(senTemSupply.T, gain1.u) annotation (Line(points={{-78,93.2},{-78,
            104},{-90,104},{-90,120},{-80,120}},      color={0,0,127}));
    connect(valCold.y, PID_Return.y) annotation (Line(points={{-10,-36},{20,-36},
            {20,-96},{-1,-96}},color={0,0,127}));
    connect(senTemSupply.T, PID_Return.u_m) annotation (Line(points={{-78,93.2},
            {-78,104},{-140,104},{-140,-114},{-12,-114},{-12,-108}},      color={0,
            0,127}));
    connect(T_Supply_Set, PID_Return.u_s) annotation (Line(points={{-120,140},{
            -116,140},{-116,34},{-36,34},{-36,-96},{-24,-96}},
                                                 color={0,0,127}));
    connect(senTemReturn1.port_b, valReturn.port_a) annotation (Line(points={{-72,
            -20},{-60,-20},{-60,-40}}, color={0,127,255}));
    connect(senTemReturn.port_a, valReturn.port_b) annotation (Line(points={{-68,
            -80},{-60,-80},{-60,-60}}, color={0,127,255}));
    connect(PID_Return.y, add.u2) annotation (Line(points={{-1,-96},{20,-96},{
            20,-108},{58,-108}}, color={0,0,127}));
    connect(realExpression.y, add.u1)
      annotation (Line(points={{51,-96},{58,-96}}, color={0,0,127}));
    connect(add.y, valReturn.y) annotation (Line(points={{81,-102},{86,-102},{
            86,-66},{-42,-66},{-42,-50},{-48,-50}}, color={0,0,127}));
    connect(senTemStorageHot.port_b, scalableStorage.port_a)
      annotation (Line(points={{32,20},{80,20},{80,0}}, color={0,127,255}));
    connect(tColdNom.y, PID_Return1.u_s) annotation (Line(points={{20.4,40},{18,
            40},{18,120},{82,120}}, color={0,0,127}));
    connect(senTemReturn1.T, PID_Return1.u_m) annotation (Line(points={{-80,-9},
            {-62,-9},{-62,10},{122,10},{122,86},{94,86},{94,108}}, color={0,0,
            127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end GridStorage;

  model GridStorageHydraulicSeparator

    parameter Modelica.Units.SI.MassFlowRate m_Flow=3;
    parameter Modelica.Units.SI.Temperature T_start=318.15;
    parameter Modelica.Units.SI.Temperature TColdNom=311.15;
    parameter Modelica.Units.SI.Temperature THotNom=273.15+45;
    parameter Modelica.Units.SI.TemperatureDifference DeltaT=5;

    parameter Modelica.Units.SI.Volume V=10 "Volume";

    ScalableStorage scalableStorage(
      n=n,
      V=V,
      m_Flow=m_Flow,
      T_start=T_start,
      TColdNom=TColdNom,
      THotNom=THotNom,
      DeltaT=DeltaT)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b_Return(redeclare package
        Medium =
          AixLib.Media.Water)
      annotation (Placement(transformation(extent={{-110,-90},{-90,-70}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a_Return(redeclare package
        Medium =
          AixLib.Media.Water)
      annotation (Placement(transformation(extent={{-110,-30},{-90,-10}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a_Supply(redeclare package
        Medium =
          AixLib.Media.Water)
      annotation (Placement(transformation(extent={{-110,10},{-90,30}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b_Supply(redeclare package
        Medium =
          AixLib.Media.Water)
      annotation (Placement(transformation(extent={{-110,70},{-90,90}})));
    Modelica.Blocks.Interfaces.RealOutput relLoadStorage annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-110,0})));

    Modelica.Blocks.Interfaces.RealInput u
      annotation (Placement(transformation(extent={{140,-22},{100,18}})));
  protected
     parameter Integer n=100 "number of layers";
  equation
    connect(scalableStorage.port_a, port_a_Supply) annotation (Line(points={{-10,8},
            {-20,8},{-20,20},{-100,20}}, color={0,127,255}));
    connect(scalableStorage.port_a, port_b_Supply) annotation (Line(points={{-10,8},
            {-20,8},{-20,80},{-100,80}},                   color={0,127,255}));
    connect(scalableStorage.port_b, port_a_Return) annotation (Line(points={{-10,-8},
            {-20,-8},{-20,-20},{-100,-20}}, color={0,127,255}));
    connect(scalableStorage.port_b, port_b_Return) annotation (Line(points={{-10,-8},
            {-20,-8},{-20,-80},{-100,-80}}, color={0,127,255}));
    connect(relLoadStorage, scalableStorage.y) annotation (Line(points={{-110,0},{
            -30,0},{-30,3},{-11,3}}, color={0,0,127}));
    connect(u, scalableStorage.u)
      annotation (Line(points={{120,-2},{12,-2},{12,-5.2}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end GridStorageHydraulicSeparator;
end ModularStorage;
