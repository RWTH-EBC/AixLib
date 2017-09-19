within AixLib.Airflow.AirHandlingUnit;
package ComponentsAHU "contains different components for the AHU"
  extends Modelica.Icons.VariantsPackage;

  model RecuperatorSimple
    "simple model of the recuperator with adiabatic cooling "
   extends AixLib.Fluid.Interfaces.PartialFourPortInterface;

    import SI = Modelica.SIunits;
    parameter SI.MassFlowRate mWat_evap_nominal( min=0, max=2.77) = 0.05
                   "mass flow of water in evaporisation in kg/s";

    Fluid.HeatExchangers.ConstantEffectiveness recuperator(
      m1_flow_nominal=5.1,
      m2_flow_nominal=5.1,
      dp2_nominal=132,
      dp1_nominal=127,
      redeclare package Medium1 = Medium1,
      redeclare package Medium2 = Medium2)
                      "Adiabatic Recuperator between exhaust and supply air"
      annotation (Placement(transformation(extent={{10,-20},{30,0}})));
    Fluid.Humidifiers.Humidifier_u evaporator(
      m_flow_nominal=5.1,
      dp_nominal=0,
      mWat_flow_nominal=mWat_evap_nominal,
      redeclare package Medium = Medium1)
      "humidifier to imitate the effect of the evaporation in the recuperator"
      annotation (Placement(transformation(extent={{-24,-14},{-4,6}})));
    BaseClasses.evaporationHeatModel evaporationHeatModel
      "calculates the heat flow from the evaporisation"
      annotation (Placement(transformation(extent={{-92,-20},{-72,0}})));
    Modelica.Blocks.Math.Gain mWat_gain(k=mWat_evap_nominal)
      "calculates the mass flow of evaporated water"
      annotation (Placement(transformation(extent={{-92,20},{-72,40}})));
    Fluid.Actuators.Valves.TwoWayEqualPercentage
                             Y03(
      l=0.001,
      m_flow_nominal=5.1,
      dpValve_nominal=10,
      y_start=0,
      redeclare package Medium = Medium1)
               "damper at bypass of recuperator on exhaust air side"
      annotation (Placement(transformation(extent={{-10,50},{10,70}})));
    Fluid.Actuators.Valves.TwoWayEqualPercentage
                             Y01(
      l=0.001,
      m_flow_nominal=5.1,
      dpValve_nominal=10,
      redeclare package Medium = Medium2)
               "damper at entry of recuperator of supply air side" annotation (
        Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=-90,
          origin={50,-36})));
    Fluid.Actuators.Valves.TwoWayEqualPercentage
                             Y02(
      l=0.001,
      m_flow_nominal=5.1,
      dpValve_nominal=10,
      y_start=0,
      redeclare package Medium = Medium2)
               "damper at bypass of recuperator"
      annotation (Placement(transformation(extent={{10,-70},{-10,-50}})));
    Fluid.MixingVolumes.MixingVolume vol1(
      V=0.01,
      nPorts=3,
      m_flow_nominal=5.1,
      redeclare package Medium = Medium2)
                "mixing volume" annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=0,
          origin={50,-80})));
    Fluid.MixingVolumes.MixingVolume vol(
      V=0.01,
      nPorts=3,
      m_flow_nominal=5.1,
      redeclare package Medium = Medium2)
                "mixing volume" annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=0,
          origin={-50,-80})));
    Modelica.Blocks.Interfaces.RealInput Y03_opening
      "valve Input for Y03 opening" annotation (Placement(transformation(
          extent={{20,-20},{-20,20}},
          rotation=90,
          origin={30,106})));
    Modelica.Blocks.Interfaces.RealInput mWat_evaporator
      "input for water amount to be evaporised" annotation (Placement(
          transformation(
          extent={{20,-20},{-20,20}},
          rotation=90,
          origin={-80,106})));
    Modelica.Blocks.Interfaces.RealInput Y01_opening "valve Input for valve Y01"
      annotation (Placement(transformation(
          extent={{20,-20},{-20,20}},
          rotation=90,
          origin={80,106})));
    Modelica.Blocks.Interfaces.RealInput Y02_opening "valve Input for Y02"
      annotation (Placement(transformation(
          extent={{20,-20},{-20,20}},
          rotation=90,
          origin={-30,106})));
    Fluid.MixingVolumes.MixingVolume vol2(
      V=0.01,
      nPorts=3,
      m_flow_nominal=5.1,
      redeclare package Medium = Medium1)
                "mixing volume" annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-50,74})));
    Fluid.MixingVolumes.MixingVolume vol3(
      V=0.01,
      nPorts=3,
      m_flow_nominal=5.1,
      redeclare package Medium = Medium1)
                "mixing volume" annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={50,74})));
  equation
    connect(port_a2, vol1.ports[1]) annotation (Line(points={{100,-60},{52,-60},
            {52,-70},{52.6667,-70}},
                            color={0,127,255}));
    connect(vol1.ports[2], Y01.port_a) annotation (Line(points={{50,-70},{50,
            -46}},              color={0,127,255}));
    connect(Y01.port_b, recuperator.port_a2) annotation (Line(points={{50,-26},
            {50,-16},{30,-16}},  color={0,127,255}));
    connect(vol1.ports[3], Y02.port_a) annotation (Line(points={{47.3333,-70},{
            48,-70},{48,-60},{10,-60}},
                                    color={0,127,255}));
    connect(evaporator.port_b, recuperator.port_a1)
      annotation (Line(points={{-4,-4},{10,-4}},   color={0,127,255}));
    connect(port_a1, vol2.ports[1]) annotation (Line(points={{-100,60},{-52,60},
            {-52,64},{-52.6667,64}},
                                color={0,127,255}));
    connect(vol2.ports[2], evaporator.port_a) annotation (Line(points={{-50,64},
            {-50,-4},{-24,-4}},     color={0,127,255}));
    connect(vol2.ports[3], Y03.port_a) annotation (Line(points={{-47.3333,64},{
            -48,64},{-48,60},{-10,60}},
                                    color={0,127,255}));
    connect(Y03.port_b, vol3.ports[1]) annotation (Line(points={{10,60},{48,60},
            {48,64},{47.3333,64}},             color={0,127,255}));
    connect(recuperator.port_b1, vol3.ports[2]) annotation (Line(points={{30,-4},
            {50,-4},{50,64}},     color={0,127,255}));
    connect(vol3.ports[3], port_b1) annotation (Line(points={{52.6667,64},{52,
            64},{52,60},{100,60}},
                               color={0,127,255}));
    connect(Y03_opening, Y03.y) annotation (Line(points={{30,106},{30,78},{0,78},
            {0,72},{0,72}},
                     color={0,0,127}));
    connect(mWat_evaporator, evaporator.u)
      annotation (Line(points={{-80,106},{-80,78},{-110,78},{-110,2},{-25,2}},
                                                             color={0,0,127}));
    connect(mWat_evaporator, mWat_gain.u) annotation (Line(points={{-80,106},{
            -80,78},{-110,78},{-110,30},{-94,30}},
                                                color={0,0,127}));
    connect(mWat_gain.y, evaporationHeatModel.u) annotation (Line(points={{-71,30},
            {-68,30},{-68,8},{-96,8},{-96,-10},{-92.4,-10}},
                                           color={0,0,127}));
    connect(evaporationHeatModel.port_a, evaporator.heatPort) annotation (Line(
          points={{-72.2,-10},{-24,-10}},                 color={191,0,0}));
    connect(Y01_opening, Y01.y)
      annotation (Line(points={{80,106},{80,-36},{62,-36}},
                                                    color={0,0,127}));
    connect(Y02.port_b, vol.ports[1]) annotation (Line(points={{-10,-60},{-48,
            -60},{-48,-70},{-47.3333,-70}},
                                       color={0,127,255}));
    connect(recuperator.port_b2, vol.ports[2])
      annotation (Line(points={{10,-16},{-50,-16},{-50,-70}},color={0,127,255}));
    connect(vol.ports[3], port_b2) annotation (Line(points={{-52.6667,-70},{-52,
            -70},{-52,-60},{-100,-60}},
                                   color={0,127,255}));
    connect(Y02.y, Y02_opening) annotation (Line(points={{0,-48},{-30,-48},{-30,
            106}},       color={0,0,127}));
     annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={28,108,200},
            fillColor={0,0,255},
            fillPattern=FillPattern.CrossDiag,
            radius=10)}),                                           Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end RecuperatorSimple;

  model sorptionDehumidification
    "model of the sorption process to dehumidify the air"

    replaceable package Medium1 =
        Modelica.Media.Interfaces.PartialMedium "Medium 1 in the component"
        annotation (choicesAllMatching = true);
    replaceable package Medium2 =
        Modelica.Media.Interfaces.PartialMedium "Medium 2 in the component"
        annotation (choicesAllMatching = true);

    parameter Boolean allowFlowReversal1 = true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal for medium 1"
      annotation(Dialog(tab="Assumptions"), Evaluate=true);
    parameter Boolean allowFlowReversal2 = true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal for medium 2"
      annotation(Dialog(tab="Assumptions"), Evaluate=true);


    Fluid.Humidifiers.Humidifier_u Desorber(
      m_flow_nominal=1,
      dp_nominal=0,
      mWat_flow_nominal=0.01522,
      redeclare package Medium = Medium1)
      "humidifier to imitate the effect of the desorber module"
      annotation (Placement(transformation(extent={{10,270},{-10,290}})));
    Fluid.Humidifiers.Humidifier_u Absorber(
      m_flow_nominal=5.1,
      dp_nominal=300,
      mWat_flow_nominal=-0.012806,
      redeclare package Medium = Medium2)
      "dehumidifier to imitate the effect of the absorber module"
      annotation (Placement(transformation(extent={{-48,-238},{-68,-218}})));
    Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium = Medium2)
      annotation (Placement(transformation(extent={{66,-238},{46,-218}})));
    Fluid.Actuators.Valves.TwoWayEqualPercentage
                             Y06(
      l=0.001,
      m_flow_nominal=5.1,
      dpValve_nominal=10,
      redeclare package Medium = Medium2)
               "damper at bypass of absorber"
      annotation (Placement(transformation(extent={{14,-310},{-6,-330}})));
    Modelica.Blocks.Interfaces.RealInput desInput
      "input value for humidification of desorber" annotation (Placement(
          transformation(
          extent={{20,-20},{-20,20}},
          rotation=90,
          origin={40,426})));
    Modelica.Blocks.Interfaces.RealInput absInput
      "input for dehumidification of absorber" annotation (Placement(
          transformation(
          extent={{20,-20},{-20,20}},
          rotation=90,
          origin={-40,426})));
    Modelica.Blocks.Interfaces.RealInput Y06_opening
      "valve Input for Y06 opening" annotation (Placement(transformation(
          extent={{20,-20},{-20,20}},
          rotation=90,
          origin={-150,426})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a1(
    redeclare final package Medium = Medium1,
                       m_flow(min=if allowFlowReversal1 then -Modelica.Constants.inf else 0),
                       h_outflow(start = Medium1.h_default))
      "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
      annotation (Placement(transformation(extent={{190,270},{210,290}})));

    Modelica.Fluid.Interfaces.FluidPort_b port_b1(
                       redeclare final package Medium = Medium1,
                       m_flow(max=if allowFlowReversal1 then +Modelica.Constants.inf else 0),
                       h_outflow(start = Medium1.h_default))
      "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
      annotation (Placement(transformation(extent={{-210,270},{-190,290}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a2(
                       redeclare final package Medium = Medium2,
                       m_flow(min=if allowFlowReversal2 then -Modelica.Constants.inf else 0),
                       h_outflow(start = Medium2.h_default))
      "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
      annotation (Placement(transformation(extent={{190,-290},{210,-270}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b2(
                       redeclare final package Medium = Medium2,
                       m_flow(max=if allowFlowReversal2 then +Modelica.Constants.inf else 0),
                       h_outflow(start = Medium2.h_default))
      "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
      annotation (Placement(transformation(extent={{-210,-290},{-190,-270}})));
    Modelica.Blocks.Interfaces.RealOutput senMasFloAbs
      "sensor signal of mass flow through absorber"
      annotation (Placement(transformation(extent={{194,-10},{214,10}})));
  equation
    connect(Y06_opening, Y06.y) annotation (Line(points={{-150,426},{-150,-332},
            {4,-332}},      color={0,0,127}));
    connect(senMasFlo.port_b, Absorber.port_a)
      annotation (Line(points={{46,-228},{-48,-228}},color={0,127,255}));
    connect(desInput, Desorber.u)
      annotation (Line(points={{40,426},{40,286},{11,286}},color={0,0,127}));
    connect(absInput, Absorber.u) annotation (Line(points={{-40,426},{-40,-222},
            {-47,-222}},                 color={0,0,127}));
    connect(senMasFlo.m_flow, senMasFloAbs)
      annotation (Line(points={{56,-217},{56,0},{204,0}}, color={0,0,127}));
    connect(port_a1, Desorber.port_a)
      annotation (Line(points={{200,280},{10,280}},color={0,127,255}));
    connect(Desorber.port_b, port_b1)
      annotation (Line(points={{-10,280},{-200,280}}, color={0,127,255}));
    connect(port_a2, senMasFlo.port_a) annotation (Line(points={{200,-280},{108,
            -280},{108,-228},{66,-228}}, color={0,127,255}));
    connect(port_a2, Y06.port_a) annotation (Line(points={{200,-280},{108,-280},
            {108,-320},{14,-320}}, color={0,127,255}));
    connect(Absorber.port_b, port_b2) annotation (Line(points={{-68,-228},{-104,
            -228},{-104,-280},{-200,-280}}, color={0,127,255}));
    connect(Y06.port_b, port_b2) annotation (Line(points={{-6,-320},{-104,-320},
            {-104,-280},{-200,-280}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-420},
              {200,420}}), graphics={Rectangle(
            extent={{-200,420},{200,-420}},
            lineColor={28,108,200},
            fillColor={28,108,200},
            fillPattern=FillPattern.HorizontalCylinder)}),         Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-200,-420},{200,420}})));
  end sorptionDehumidification;

  model heatingRegister
    "model for a heating register with a pump and a three way valve"
   extends AixLib.Fluid.Interfaces.PartialFourPortInterface;

    Fluid.HeatExchangers.ConstantEffectiveness HeatingCoil(
      m1_flow_nominal=5.1,
      m2_flow_nominal=0.1,
      dp2_nominal=20,
      dp1_nominal=0,
      redeclare package Medium1 = Medium1,
      redeclare package Medium2 = Medium2)
      "Heating Coil after Recuperator for additional Heating"
      annotation (Placement(transformation(extent={{-10,44},{10,64}})));
    Fluid.Movers.Pump pump(
      MinMaxCharacteristics=DataBase.Pumps.Pump1(),
      m_flow_small=m2_flow_small,
      Head(start=0.4),
      ControlStrategy=1,
      redeclare package Medium = Medium2)             annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={30,20})));
    Modelica.Blocks.Sources.BooleanConstant isNight(final k=false)
      "boolean to activate the night modus for the pump"
      annotation (Placement(transformation(extent={{76,16},{66,26}})));
    Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear threeWayValveHeaCoi(
      m_flow_nominal=1,
      dpValve_nominal=500,
      redeclare package Medium = Medium2)
                           "Three way valve in the heating coil water circuit"
      annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={30,-16})));
    Fluid.MixingVolumes.MixingVolume vol(
      V=0.01,
      nPorts=3,
      m_flow_nominal=0.1,
      redeclare package Medium = Medium2)
                "mixing volume" annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={-46,-16})));
    Modelica.Blocks.Interfaces.RealInput u "valve Input"
      annotation (Placement(transformation(extent={{128,-36},{88,4}})));





    Fluid.Sensors.TemperatureTwoPort T03_senTemHea(
                     m_flow_nominal=5.1, redeclare package Medium = Medium1)
      "Temperature of supply air after heating coil"
      annotation (Placement(transformation(extent={{40,50},{60,70}})));
    Modelica.Blocks.Interfaces.RealOutput T03_senTemHeaCoi
      "Temperature sensor for T03 after heating coil" annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={50,106})));
  equation
    connect(isNight.y, pump.IsNight) annotation (Line(points={{65.5,21},{58,21},
            {58,20},{40.2,20}},      color={255,0,255}));
    connect(port_a1, HeatingCoil.port_a1)
      annotation (Line(points={{-100,60},{-10,60}}, color={0,127,255}));
    connect(HeatingCoil.port_b2, vol.ports[1]) annotation (Line(points={{-10,48},
            {-28,48},{-28,-13.3333},{-36,-13.3333}},
                                                  color={0,127,255}));
    connect(vol.ports[2], threeWayValveHeaCoi.port_3) annotation (Line(points={{-36,-16},
            {20,-16}},                      color={0,127,255}));
    connect(vol.ports[3], port_b2) annotation (Line(points={{-36,-18.6667},{-28,
            -18.6667},{-28,-60},{-100,-60}},
                         color={0,127,255}));
    connect(u, threeWayValveHeaCoi.y)
      annotation (Line(points={{108,-16},{42,-16}}, color={0,0,127}));
    connect(port_a2, threeWayValveHeaCoi.port_1) annotation (Line(points={{100,
            -60},{30,-60},{30,-26}}, color={0,127,255}));
    connect(threeWayValveHeaCoi.port_2, pump.port_a)
      annotation (Line(points={{30,-6},{30,10}}, color={0,127,255}));
    connect(pump.port_b, HeatingCoil.port_a2)
      annotation (Line(points={{30,30},{30,48},{10,48}}, color={0,127,255}));
    connect(HeatingCoil.port_b1, T03_senTemHea.port_a)
      annotation (Line(points={{10,60},{40,60}}, color={0,127,255}));
    connect(T03_senTemHea.port_b, port_b1)
      annotation (Line(points={{60,60},{100,60}}, color={0,127,255}));
    connect(T03_senTemHea.T, T03_senTemHeaCoi)
      annotation (Line(points={{50,71},{50,106}}, color={0,0,127}));
   annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={28,108,200},
            fillColor={238,46,47},
            fillPattern=FillPattern.Solid,
            radius=10)}),                                         Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end heatingRegister;

  model Recuperator
    "model of the recuperator with adiabatic cooling after Jorissen et al."
   extends AixLib.Fluid.Interfaces.PartialFourPortInterface;

    import SI = Modelica.SIunits;


    Fluid.Actuators.Valves.TwoWayEqualPercentage
                             Y03(
      l=0.001,
      m_flow_nominal=5.1,
      dpValve_nominal=10,
      y_start=0,
      redeclare package Medium = Medium1)
               "damper at bypass of recuperator on exhaust air side"
      annotation (Placement(transformation(extent={{-10,50},{10,70}})));
    Fluid.Actuators.Valves.TwoWayEqualPercentage
                             Y01(
      l=0.001,
      m_flow_nominal=5.1,
      dpValve_nominal=10,
      redeclare package Medium = Medium2)
               "damper at entry of recuperator of supply air side" annotation (
        Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=-90,
          origin={50,-36})));
    Fluid.Actuators.Valves.TwoWayEqualPercentage
                             Y02(
      l=0.001,
      m_flow_nominal=5.1,
      dpValve_nominal=10,
      y_start=0,
      redeclare package Medium = Medium2)
               "damper at bypass of recuperator"
      annotation (Placement(transformation(extent={{10,-70},{-10,-50}})));
    Fluid.MixingVolumes.MixingVolume vol1(
      V=0.01,
      nPorts=3,
      m_flow_nominal=5.1,
      redeclare package Medium = Medium2)
                "mixing volume" annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=0,
          origin={50,-80})));
    Fluid.MixingVolumes.MixingVolume vol(
      V=0.01,
      nPorts=3,
      m_flow_nominal=5.1,
      redeclare package Medium = Medium2)
                "mixing volume" annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=0,
          origin={-50,-80})));
    Modelica.Blocks.Interfaces.RealInput Y03_opening
      "valve Input for Y03 opening" annotation (Placement(transformation(
          extent={{20,-20},{-20,20}},
          rotation=90,
          origin={30,106})));
    Modelica.Blocks.Interfaces.RealInput Y01_opening "valve Input for valve Y01"
      annotation (Placement(transformation(
          extent={{20,-20},{-20,20}},
          rotation=90,
          origin={80,106})));
    Modelica.Blocks.Interfaces.RealInput Y02_opening "valve Input for Y02"
      annotation (Placement(transformation(
          extent={{20,-20},{-20,20}},
          rotation=90,
          origin={-30,106})));
    Fluid.MixingVolumes.MixingVolume vol2(
      V=0.01,
      nPorts=3,
      m_flow_nominal=5.1,
      redeclare package Medium = Medium1)
                "mixing volume" annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-50,74})));
    Fluid.MixingVolumes.MixingVolume vol3(
      V=0.01,
      nPorts=3,
      m_flow_nominal=5.1,
      redeclare package Medium = Medium1)
                "mixing volume" annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={50,74})));
    recHeaExc recHeaExc1(
      use_eNTU=true,
      redeclare package Medium1 = Medium1,
      redeclare package Medium2 = Medium2,
      m1_flow_nominal=m1_flow_nominal,
      m2_flow_nominal=m2_flow_nominal)
      annotation (Placement(transformation(extent={{-10,6},{10,26}})));
    Modelica.Blocks.Interfaces.BooleanInput adiCoo "adiabatic cooling on off"
      annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=180,
          origin={106,16})));
  equation
    connect(port_a2, vol1.ports[1]) annotation (Line(points={{100,-60},{52,-60},
            {52,-70},{52.6667,-70}},
                            color={0,127,255}));
    connect(vol1.ports[2], Y01.port_a) annotation (Line(points={{50,-70},{50,-46}},
                                color={0,127,255}));
    connect(vol1.ports[3], Y02.port_a) annotation (Line(points={{47.3333,-70},{
            48,-70},{48,-60},{10,-60}},
                                    color={0,127,255}));
    connect(port_a1, vol2.ports[1]) annotation (Line(points={{-100,60},{-52,60},
            {-52,64},{-52.6667,64}},
                                color={0,127,255}));
    connect(vol2.ports[2], Y03.port_a) annotation (Line(points={{-50,64},{-50,
            64},{-50,60},{-10,60}}, color={0,127,255}));
    connect(Y03.port_b, vol3.ports[1]) annotation (Line(points={{10,60},{48,60},
            {48,64},{47.3333,64}},             color={0,127,255}));
    connect(Y03_opening, Y03.y) annotation (Line(points={{30,106},{30,78},{0,78},{
            0,72},{0,72}},
                     color={0,0,127}));
    connect(Y01_opening, Y01.y)
      annotation (Line(points={{80,106},{80,-36},{62,-36}},
                                                    color={0,0,127}));
    connect(Y02.port_b, vol.ports[1]) annotation (Line(points={{-10,-60},{-48,
            -60},{-48,-70},{-47.3333,-70}},
                                       color={0,127,255}));
    connect(Y02.y, Y02_opening) annotation (Line(points={{0,-48},{-30,-48},{-30,106}},
                         color={0,0,127}));
    connect(vol2.ports[3], recHeaExc1.port_a1) annotation (Line(points={{
            -47.3333,64},{-47.3333,22},{-10,22}}, color={0,127,255}));
    connect(recHeaExc1.port_b1, vol3.ports[2])
      annotation (Line(points={{10,22},{50,22},{50,64}}, color={0,127,255}));
    connect(vol3.ports[3], port_b1) annotation (Line(points={{52.6667,64},{52,
            64},{52,60},{100,60}}, color={0,127,255}));
    connect(Y01.port_b, recHeaExc1.port_a2) annotation (Line(points={{50,-26},{
            48,-26},{48,10},{48,10},{48,10},{10,10},{10,10}}, color={0,127,255}));
    connect(recHeaExc1.port_b2, vol.ports[2]) annotation (Line(points={{-10,10},
            {-50,10},{-50,-70}}, color={0,127,255}));
    connect(adiCoo, recHeaExc1.adiabaticOn)
      annotation (Line(points={{106,16},{10.4,16}}, color={255,0,255}));
    connect(vol.ports[3], port_b2) annotation (Line(points={{-52.6667,-70},{-52,
            -70},{-52,-60},{-100,-60}}, color={0,127,255}));
     annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={28,108,200},
            fillColor={0,0,255},
            fillPattern=FillPattern.CrossDiag,
            radius=10)}),                                           Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Recuperator;

  model recHeaExc
    "heat exchanger and adiabatic cooling recuperator model"
     extends AixLib.Fluid.Interfaces.PartialFourPortInterface(
      final allowFlowReversal1=false,
      final allowFlowReversal2=false);

    import SI = Modelica.SIunits;

    //declare: h_wb_out_top, h_wb_in_top, T_wb_out_top, T_wb_in_top, cp

    parameter Real eps_adia_on = 0.9
      "Heat exchanger efficiency when adiabatic heat exchange is on, used when not use_eNTU"
      annotation(Dialog(enable=not use_eNTU));
    parameter Real eps_adia_off = 0.79
      "Heat exchanger efficiency when adiabatic heat exchange is off, used when not use_eNTU"
      annotation(Dialog(enable=not use_eNTU));
    parameter Boolean use_eNTU = true "Use NTU method for efficiency calculation"
      annotation(Evaluate=true);
    parameter SI.Time tau = 60
      "Thermal time constant of the heat exchanger";
    parameter Real UA_adia_on= 14000
      "WERT MUSS NOCH ERMITTELT WERDEN!!
    UA value when using evaporative cooling, used when use_eNTU = true"
      annotation(Dialog(enable=use_eNTU));
    parameter Real UA_adia_off= 23000
      "WERT MUSS NOCH ERMITTELT WERDEN!!
    UA value when not using evaporative cooling, used when use_eNTU = true"
      annotation(Dialog(enable=use_eNTU));
    parameter Real mSenFac(min=1)=1
      "Factor for scaling the sensible thermal mass of the volume"
      annotation(Dialog(tab="Dynamics"));

      // Initialization
    parameter Medium1.AbsolutePressure p1_start = Medium1.p_default
      "Start value of pressure"
      annotation(Dialog(tab = "Initialization", group = "Medium 1"));
    parameter Medium1.Temperature T1_start = Medium1.T_default
      "Start value of temperature"
      annotation(Dialog(tab = "Initialization", group = "Medium 1"));
    parameter Medium1.MassFraction X1_start[Medium1.nX] = Medium1.X_default
      "Start value of mass fractions m_i/m"
      annotation (Dialog(tab="Initialization", group = "Medium 1", enable=Medium1.nXi > 0));
    parameter Medium1.ExtraProperty C1_start[Medium1.nC](
         quantity=Medium1.extraPropertiesNames)=fill(0, Medium1.nC)
      "Start value of trace substances"
      annotation (Dialog(tab="Initialization", group = "Medium 1", enable=Medium1.nC > 0));
    parameter Medium1.ExtraProperty C1_nominal[Medium1.nC](
         quantity=Medium1.extraPropertiesNames) = fill(1E-2, Medium1.nC)
      "Nominal value of trace substances. (Set to typical order of magnitude.)"
     annotation (Dialog(tab="Initialization", group = "Medium 1", enable=Medium1.nC > 0));
    parameter Medium2.AbsolutePressure p2_start = Medium2.p_default
      "Start value of pressure"
      annotation(Dialog(tab = "Initialization", group = "Medium 2"));
    parameter Medium2.Temperature T2_start = Medium2.T_default
      "Start value of temperature"
      annotation(Dialog(tab = "Initialization", group = "Medium 2"));
    parameter Medium2.MassFraction X2_start[Medium2.nX] = Medium2.X_default
      "Start value of mass fractions m_i/m"
      annotation (Dialog(tab="Initialization", group = "Medium 2", enable=Medium2.nXi > 0));
    parameter SI.MassFlowRate m_flow_small=1E-4*abs(volTop.m_flow_nominal)
      "Small mass flow rate for regularization of zero flow";

    parameter Boolean simplifiedMassBalance=true
      "Use simplified evaporation model to determine outlet humidity of dumped air stream when evaporative cooling is on";

    SI.SpecificHeatCapacity CpAir_default = Medium1.specificHeatCapacityCp(Medium1.setState_pTX(Medium1.p_default, Medium1.T_default, Medium1.X_default)) "später wieder einfügen! specific heat capacity of air at default values";


    SI.Power Q;
    SI.Energy E=volTop.U+volBot.U;
    Modelica.Blocks.Interfaces.BooleanInput adiabaticOn
      "Activate adiabatic cooling"
      annotation (Placement(transformation(extent={{120,-16},{88,16}})));
    Fluid.MixingVolumes.MixingVolumeMoistAir volTop(
      nPorts=2,
      redeclare package Medium = Medium1,
      prescribedHeatFlowRate=true,
      m_flow_nominal=m1_flow_nominal,
      m_flow_small=m_flow_small,
      p_start=p1_start,
      T_start=T1_start,
      X_start=X1_start,
      mSenFac=mSenFac,
      simplify_mWat_flow=true,
      allowFlowReversal=allowFlowReversal1,
      V=m1_flow_nominal/rho_default*tau) "Top heat exchanger volume"
      annotation (Placement(transformation(extent={{10,60},{-10,40}})));
      //energyDynamics=energyDynamics,
      //massDynamics=massDynamics,
      //C_start=C1_start,
      //C_nominal=C1_nominal,
    Fluid.MixingVolumes.MixingVolumeMoistAir volBot(
      redeclare package Medium = Medium2,
      prescribedHeatFlowRate=true,
      m_flow_nominal=m2_flow_nominal,
      m_flow_small=m_flow_small,
      nPorts=2,
      p_start=p2_start,
      T_start=T2_start,
      X_start=X2_start,
      mSenFac=mSenFac,
      allowFlowReversal=allowFlowReversal2,
      V=m2_flow_nominal/rho_default*tau) "bottom heat exchanger volume"
      annotation (Placement(transformation(extent={{10,-60},{-10,-40}})));
      //energyDynamics=energyDynamics,
      //massDynamics=massDynamics,
      //C_start=C2_start,
      //C_nominal=C2_nominal,

    Modelica.Blocks.Sources.RealExpression mFloAdiBot(y=(Xw_out_bot - Xw_in_bot)*
          port_a2.m_flow)
      "Realexpression for setting condensation mass flow rate"
      annotation (Placement(transformation(extent={{118,-52},{50,-32}})));

    Modelica.Blocks.Sources.RealExpression mFloAdiTop(y=(Xw_out_top - Xw_in_top)*
          port_a1.m_flow) "Realexpression for setting evaporation mass flow rate"
      annotation (Placement(transformation(extent={{110,32},{42,52}})));
    Modelica.Blocks.Interfaces.RealOutput TOutBot "Bottom outlet temperature"
      annotation (Placement(transformation(extent={{98,-98},{118,-78}}),
          iconTransformation(extent={{98,-98},{118,-78}})));

  //protected
    final parameter SI.Density rho_default=Medium1.density(
       Medium1.setState_pTX(
        T=Medium1.T_default,
        p=Medium1.p_default,
        X=Medium1.X_default[1:Medium1.nXi]))
      "Density, used to compute fluid mass";
    SI.Temperature T_bot_in=Medium2.temperature_phX(p=port_a2.p, h=inStream(port_a2.h_outflow), X=inStream(port_a2.Xi_outflow));
    SI.Temperature T_top_in=Medium1.temperature_phX(p=port_a1.p, h=inStream(port_a1.h_outflow), X=inStream(port_a1.Xi_outflow));
    Medium1.MassFraction Xi_top_in[Medium1.nXi] = inStream(port_a1.Xi_outflow)
      "Species vector, needed because indexed argument for the operator inStream is not supported";
    Medium2.MassFraction Xi_bot_in[Medium2.nXi] = inStream(port_a2.Xi_outflow)
      "Species vector, needed because indexed argument for the operator inStream is not supported";

    Real Xw_in_top = Xi_top_in[1] "Water mass fraction of top stream";
    Real Xw_in_bot = Xi_bot_in[1] "Water mass fraction of bottom stream";

    Real Xw_80_Tout_top = if simplifiedMassBalance
                          then AixLib.Utilities.Psychrometrics.Functions.X_pSatpphi(pSat=AixLib.Media.Air.saturationPressure(volTop.heatPort.T), p=port_a1.p, phi=0.8)
                          else Xw_in_top + (Xw_sat_Tout_top-Xw_in_top)*eps_NTU
        "Absolute humidity of top outlet air with a relative humidity of 80%.";
    Real Xw_sat_Tin_top=AixLib.Utilities.Psychrometrics.Functions.X_pSatpphi(
       pSat=AixLib.Media.Air.saturationPressure(T_top_in), p=port_a1.p, phi=1)
      "Absolute humidity for saturated top inlet air";
    Real Xw_sat_Tout_top=AixLib.Utilities.Psychrometrics.Functions.X_pSatpphi(
       pSat=AixLib.Media.Air.saturationPressure(volTop.heatPort.T), p=port_b1.p, phi=1)
      "Absolute humidity for saturated top outlet air";
    Real Xw_sat_Tin_bot=AixLib.Utilities.Psychrometrics.Functions.X_pSatpphi(
       pSat=AixLib.Media.Air.saturationPressure(T_bot_in), p=port_a2.p, phi=1)
      "Absolute humidity for saturated bottom inlet air";
    Real Xw_sat_Tout_bot=AixLib.Utilities.Psychrometrics.Functions.X_pSatpphi(
       pSat=AixLib.Media.Air.saturationPressure(volBot.heatPort.T), p=port_b2.p, phi=1)
      "Absolute humidity for saturated bottom outlet air";
    Real Xw_out_top=min(if adiabaticOn then max(Xw_80_Tout_top,Xw_in_top) else Xw_in_top, Xw_sat_Tout_top);
    Real Xw_out_bot=min(Xw_in_bot, Xw_sat_Tout_bot);
    SI.Temperature T_top_in_wet =  if adiabaticOn then  wetBulIn.TWetBul else T_top_in
      "Temperature of the wet/dry HEX at extracted air inlet";
    //splicefunction required for disabling heat transfer for low mass flow rates
    SI.Power Qmax "Maximum heat transfer, including latent heat";
    Real C_top "Heat capacity rate of top stream";
    Real C_bot "Heat capacity rate of bottom stream";
    Real C_min = min(C_top,C_bot);
    Real C_max = max(C_top,C_bot);
    Real C_star = C_min*AixLib.Utilities.Math.Functions.inverseXRegularized(C_max,1);
    Real NTU=(if adiabaticOn then UA_adia_on else UA_adia_off) /max(1,C_min);
    Real eps_NTU_half = 1-exp((exp(-C_star*(NTU/2)^0.78)-1)*AixLib.Utilities.Math.Functions.inverseXRegularized(C_star*(NTU/2)^(-0.22),0.01));
    Real eps_NTU = (((1-eps_NTU_half*C_star)/max(0.01,1-eps_NTU_half))^2-1)/(((1-eps_NTU_half*C_star)/max(0.01,1-eps_NTU_half))^2-C_star);


    IDEAS.Utilities.Psychrometrics.TWetBul_TDryBulXi  wetBulIn(
      approximateWetBulb=false,
      TDryBul=T_top_in,
      p=port_a1.p,
      Xi=Xi_top_in[1:Medium1.nXi],
      redeclare package Medium = Medium1)
      "Wet bulb temperature based on wet channel inlet conditions";
    IDEAS.Utilities.Psychrometrics.TWetBul_TDryBulXi  wetBulOut(
      approximateWetBulb=false,
      TDryBul=volTop.heatPort.T,
      p=port_a1.p,
      Xi=volTop.ports[1].Xi_outflow[1:Medium1.nXi],
      redeclare package Medium = Medium1)
      "Wet bulb temperature based on wet channel outlet conditions";

  protected
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHeaFloTop(final
        alpha=0) "Prescribed heat flow rate for top volume"
      annotation (Placement(transformation(extent={{-14,-10},{6,10}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHeaFloBot(final
        alpha=0) "Prescribed heat flow rate for bottom volume"
      annotation (Placement(transformation(extent={{-14,-30},{6,-10}})));
    Modelica.Blocks.Sources.RealExpression Qexp(y=Q)
      "Expression for heat flow rate"
      annotation (Placement(transformation(extent={{-76,-10},{-64,10}})));
    Modelica.Thermal.HeatTransfer.Components.ThermalResistor theRes(R=50*tau/(
          volBot.V*rho_default*AixLib.Utilities.Psychrometrics.Constants.cpAir*
          mSenFac))
      "Temperature difference will settle after 3*50 time constants tau if m_flow=0"
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={32,-4})));
    Modelica.Blocks.Math.Gain negate(k=-1) "For minus sign"
      annotation (Placement(transformation(extent={{-46,-26},{-34,-14}})));
    Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
      annotation (Placement(transformation(extent={{40,-98},{60,-78}})));


  equation
    assert(port_a1.m_flow>-m_flow_small or allowFlowReversal1, "Flow reversal occured, for indirect evaporative heat exchanger model is not valid.");
    assert(port_a2.m_flow>-m_flow_small or allowFlowReversal2, "Flow reversal occured, for indirect evaporative heat exchanger model is not valid.");

    // model from: Liu, Z., Allen, W., & Modera, M. (2013). Simplified thermal modeling of indirect evaporative heat exchangers. HVAC&R Research, 19(March), 37–41. doi:10.1080/10789669.2013.763653
    Qmax=C_min*(T_bot_in-T_top_in_wet);
    C_top = port_a1.m_flow*(if adiabaticOn
                            then (Medium1.specificEnthalpy(Medium1.setState_pTX(port_a1.p, wetBulOut.TWetBul, {wetBulOut.XiSat,1-wetBulOut.XiSat}))-Medium1.specificEnthalpy(Medium1.setState_pTX(port_a1.p, wetBulIn.TWetBul,  {wetBulIn.XiSat,1-wetBulIn.XiSat})))*AixLib.Utilities.Math.Functions.inverseXRegularized(wetBulOut.TWetBul-wetBulIn.TWetBul,0.01)
                            else CpAir_default);
    C_bot = port_a2.m_flow*Medium2.specificHeatCapacityCp(Medium2.setState_pTX(Medium2.p_default, Medium2.T_default, Medium2.X_default));
    Q = Qmax*(if use_eNTU then eps_NTU else (if adiabaticOn then eps_adia_on else eps_adia_off));




    connect(port_a1, volTop.ports[1])
      annotation (Line(points={{-100,60},{2,60}}, color={0,127,255}));
    connect(volTop.ports[2], port_b1)
      annotation (Line(points={{-2,60},{100,60}}, color={0,127,255}));
    connect(port_a2, volBot.ports[1])
      annotation (Line(points={{100,-60},{2,-60}}, color={0,127,255}));
    connect(volBot.ports[2], port_b2)
      annotation (Line(points={{-2,-60},{-100,-60}}, color={0,127,255}));
    connect(Qexp.y,preHeaFloTop. Q_flow) annotation (Line(
        points={{-63.4,0},{-14,0}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(negate.y,preHeaFloBot. Q_flow)
      annotation (Line(points={{-33.4,-20},{-14,-20}}, color={0,0,127}));
    connect(negate.u,Qexp. y) annotation (Line(points={{-47.2,-20},{-56,-20},{-56,
            0},{-63.4,0}},   color={0,0,127}));
    connect(preHeaFloTop.port, volTop.heatPort)
      annotation (Line(points={{6,0},{10,0},{10,50}},         color={191,0,0}));
    connect(preHeaFloBot.port, volBot.heatPort) annotation (Line(points={{6,-20},{
            10,-20},{10,-50}},          color={191,0,0}));
    connect(volBot.heatPort, theRes.port_a)
      annotation (Line(points={{10,-50},{32,-50},{32,-14}}, color={191,0,0}));
    connect(theRes.port_b, volTop.heatPort)
      annotation (Line(points={{32,6},{32,50},{10,50}}, color={191,0,0}));
    connect(temperatureSensor.T,TOutBot)
      annotation (Line(points={{60,-88},{108,-88}}, color={0,0,127}));
    connect(volBot.heatPort, temperatureSensor.port)
      annotation (Line(points={{10,-50},{10,-88},{40,-88}}, color={191,0,0}));
    connect(mFloAdiTop.y, volTop.mWat_flow)
      annotation (Line(points={{38.6,42},{12,42}}, color={0,0,127}));
    connect(mFloAdiBot.y, volBot.mWat_flow)
      annotation (Line(points={{46.6,-42},{12,-42}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end recHeaExc;
end ComponentsAHU;
