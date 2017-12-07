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

  model sorptionSimple
    "simple model of the sorption process to dehumidify the air"

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

    parameter Modelica.SIunits.Temperature T_init = 293.15 "initialisation temperature";

    Fluid.Humidifiers.Humidifier_u Desorber(
      m_flow_nominal=1,
      dp_nominal=0,
      mWat_flow_nominal=0.01522,
      redeclare package Medium = Medium1,
      T_start=T_init)
      "humidifier to imitate the effect of the desorber module"
      annotation (Placement(transformation(extent={{10,270},{-10,290}})));
    Fluid.Humidifiers.Humidifier_u Absorber(
      m_flow_nominal=5.1,
      dp_nominal=300,
      mWat_flow_nominal=-0.012806,
      redeclare package Medium = Medium2,
      T_start=T_init)
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
    Modelica.Blocks.Interfaces.RealInput Y06_opening
      "valve Input for Y06 opening" annotation (Placement(transformation(
          extent={{36,-36},{-36,36}},
          rotation=90,
          origin={-138,426})));
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
    Modelica.Blocks.Sources.Constant InletFlow_mflowDes(k=0)
      "water mass flow in desorber"
      annotation (Placement(transformation(extent={{58,324},{38,344}})));
    Modelica.Blocks.Sources.Constant InletFlow_mflowAbs(k=0)
      "water mass flow in absorber"
      annotation (Placement(transformation(extent={{6,-194},{-14,-174}})));
    Modelica.Blocks.Interfaces.RealOutput Y06_actual
      "actual value of valve opening Y06"
      annotation (Placement(transformation(extent={{194,-60},{214,-40}})));
  equation
    connect(Y06_opening, Y06.y) annotation (Line(points={{-138,426},{-138,-332},
            {4,-332}},      color={0,0,127}));
    connect(senMasFlo.port_b, Absorber.port_a)
      annotation (Line(points={{46,-228},{-48,-228}},color={0,127,255}));
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
    connect(InletFlow_mflowDes.y, Desorber.u) annotation (Line(points={{37,334},
            {26,334},{26,286},{11,286}}, color={0,0,127}));
    connect(InletFlow_mflowAbs.y, Absorber.u) annotation (Line(points={{-15,
            -184},{-30,-184},{-30,-222},{-47,-222}}, color={0,0,127}));
    connect(Y06.y_actual, Y06_actual) annotation (Line(points={{-1,-327},{-6,
            -327},{-6,-338},{160,-338},{160,-50},{204,-50}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-420},
              {200,420}}), graphics={Rectangle(
            extent={{-200,420},{200,-420}},
            lineColor={28,108,200},
            fillColor={28,108,200},
            fillPattern=FillPattern.HorizontalCylinder)}),         Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-200,-420},{200,420}})));
  end sorptionSimple;

  model heatingRegister
    "model for a heating register with a pump and a three way valve"
   extends AixLib.Fluid.Interfaces.PartialFourPortInterface;

   parameter Modelica.SIunits.Temperature T_init = 293.15 "initialisation temperature";

    Fluid.HeatExchangers.ConstantEffectiveness HeatingCoil(
      dp1_nominal=0,
      redeclare package Medium1 = Medium1,
      redeclare package Medium2 = Medium2,
      dp2_nominal=10000,
      m1_flow_nominal=m1_flow_nominal,
      m2_flow_nominal=m2_flow_nominal)
      "Heating Coil after Recuperator for additional Heating"
      annotation (Placement(transformation(extent={{-10,44},{10,64}})));
    Fluid.Movers.SpeedControlled_y
                      pump(
      m_flow_small=m2_flow_small,
      redeclare package Medium = Medium2,
      addPowerToMedium=false,
      T_start=T_init,
      redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per)
                                                      annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={30,10})));
    Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear threeWayValveHeaCoi(
      redeclare package Medium = Medium2,
      y_start=0,
      dpValve_nominal=500,
      m_flow_nominal=m2_flow_nominal)
                           "Three way valve in the heating coil water circuit"
      annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={30,-16})));
    Fluid.MixingVolumes.MixingVolume vol(
      V=0.01,
      nPorts=3,
      redeclare package Medium = Medium2,
      T_start=T_init,
      m_flow_nominal=m2_flow_nominal)
                "mixing volume" annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={-46,-16})));
    Modelica.Blocks.Interfaces.RealInput u "valve Input"
      annotation (Placement(transformation(extent={{128,-36},{88,4}})));





    Fluid.Sensors.TemperatureTwoPort T03_senTemHea(
                                         redeclare package Medium = Medium1,
                     T_start=T_init,
      m_flow_nominal=m1_flow_nominal)
      "Temperature of supply air after heating coil"
      annotation (Placement(transformation(extent={{40,50},{60,70}})));
    Modelica.Blocks.Interfaces.RealOutput T03_senTemHeaCoi
      "Temperature sensor for T03 after heating coil" annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={50,106})));
    Modelica.Blocks.Interfaces.RealInput pumpN04
      "input value (0 or 1) for on/off pump"
      annotation (Placement(transformation(extent={{128,0},{88,40}})));
    Modelica.Blocks.Interfaces.RealOutput y09_actual
      "value of valve opening of Y09" annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={70,106})));
    Fluid.Sensors.TemperatureTwoPort T_Mixing(
      T_start=T_init,
      redeclare package Medium = Medium2,
      m_flow_nominal=m2_flow_nominal)
                                "Mixing Temperature after three way valve"
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={30,38})));
  equation
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
      annotation (Line(points={{30,-6},{30,0}},  color={0,127,255}));
    connect(HeatingCoil.port_b1, T03_senTemHea.port_a)
      annotation (Line(points={{10,60},{40,60}}, color={0,127,255}));
    connect(T03_senTemHea.port_b, port_b1)
      annotation (Line(points={{60,60},{100,60}}, color={0,127,255}));
    connect(T03_senTemHea.T, T03_senTemHeaCoi)
      annotation (Line(points={{50,71},{50,106}}, color={0,0,127}));
    connect(pump.y, pumpN04)
      annotation (Line(points={{42,10},{76,10},{76,20},{108,20}},
                                                  color={0,0,127}));
    connect(threeWayValveHeaCoi.y_actual, y09_actual) annotation (Line(points={
            {37,-11},{37,2},{70,2},{70,106}}, color={0,0,127}));
    connect(pump.port_b, T_Mixing.port_a)
      annotation (Line(points={{30,20},{30,28}}, color={0,127,255}));
    connect(T_Mixing.port_b, HeatingCoil.port_a2)
      annotation (Line(points={{30,48},{10,48}}, color={0,127,255}));
   annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={28,108,200},
            fillColor={238,46,47},
            fillPattern=FillPattern.Solid,
            radius=10)}),                                         Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end heatingRegister;

  model recHeaExc
    "heat exchanger and adiabatic cooling recuperator model"
     extends AixLib.Fluid.Interfaces.PartialFourPortInterface(
      final allowFlowReversal1=false,
      final allowFlowReversal2=false);

    import SI = Modelica.SIunits;

    //declare: T_wb_out_top, T_wb_in_top

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
    parameter Real UA_adia_on= 8300
      "UA value when using evaporative cooling, used when use_eNTU = true"
      annotation(Dialog(enable=use_eNTU));
    parameter Real UA_adia_off= 14500
      "UA value when not using evaporative cooling, used when use_eNTU = true"
      annotation(Dialog(enable=use_eNTU));
    parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
      "Formulation of energy balance"
      annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));
    parameter Modelica.Fluid.Types.Dynamics massDynamics=energyDynamics
      "Formulation of mass balance"
      annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));
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
    parameter Medium2.ExtraProperty C2_start[Medium2.nC](
         quantity=Medium2.extraPropertiesNames)=fill(0, Medium2.nC)
      "Start value of trace substances"
      annotation (Dialog(tab="Initialization", group = "Medium 2", enable=Medium2.nC > 0));
    parameter Medium2.ExtraProperty C2_nominal[Medium2.nC](
         quantity=Medium2.extraPropertiesNames) = fill(1E-2, Medium2.nC)
      "Nominal value of trace substances. (Set to typical order of magnitude.)"
     annotation (Dialog(tab="Initialization", group = "Medium 2", enable=Medium2.nC > 0));
    parameter SI.MassFlowRate m_flow_small=1E-4*abs(volTop.m_flow_nominal)
      "Small mass flow rate for regularization of zero flow";

    parameter Boolean simplifiedMassBalance=true
      "Use simplified evaporation model to determine outlet humidity of dumped air stream when evaporative cooling is on";

    SI.Power Q;
    SI.Energy E=volTop.U+volBot.U;
    Modelica.Blocks.Interfaces.BooleanInput adiabaticOn
      "Activate adiabatic cooling"
      annotation (Placement(transformation(extent={{120,-16},{88,16}})));
    Fluid.MixingVolumes.MixingVolumeMoistAir volTop(
      nPorts=2,
      redeclare package Medium = Medium1,
      prescribedHeatFlowRate=true,
      energyDynamics=energyDynamics,
      massDynamics=massDynamics,
      C_start=C1_start,
      C_nominal=C1_nominal,
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

    Fluid.MixingVolumes.MixingVolumeMoistAir volBot(
      redeclare package Medium = Medium2,
      prescribedHeatFlowRate=true,
      energyDynamics=energyDynamics,
      massDynamics=massDynamics,
      C_start=C2_start,
      C_nominal=C2_nominal,
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


    Modelica.Blocks.Sources.RealExpression mFloAdiBot(y=(Xw_out_bot - Xw_in_bot)*
          port_a2.m_flow)
      "Realexpression for setting condensation mass flow rate"
      annotation (Placement(transformation(extent={{110,-52},{42,-32}})));

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
        "Absolute humidity of top outlet air with a relative humidity of former 80%, now 93.74%.";
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
    SI.Temperature T_top_in_wet =  if adiabaticOn then wetBulIn.TWetBul else T_top_in
      "Temperature of the wet/dry HEX at extracted air inlet";
    //splicefunction required for disabling heat transfer for low mass flow rates
    SI.Power Qmax "Maximum heat transfer, including latent heat";
    Real C_top "Heat capacity rate of top stream";
    Real C_bot "Heat capacity rate of bottom stream";
    Real C_min = min(C_top,C_bot);
    Real C_max = max(C_top,C_bot);
    Real C_star = C_min*AixLib.Utilities.Math.Functions.inverseXRegularized(C_max,1);
    Real NTU=(if adiabaticOn then UA_adia_on else UA_adia_off) /max(1,C_min);

    //Real eps_NTU_half = 1-exp((exp(-C_star*(NTU/2)^0.78)-1)*IDEAS.Utilities.Math.Functions.inverseXRegularized(C_star*(NTU/2)^(-0.22),0.01));
    Real eps_NTU_half = 1-exp((exp(-C_star*(NTU/2)^0.78)-1)*AixLib.Utilities.Math.Functions.inverseXRegularized(C_star*(NTU/2)^(-0.22),0.01));

    Real eps_NTU_precise = (((1-eps_NTU_half*C_star)/max(0.01,1-eps_NTU_half))^2-1)/(((1-eps_NTU_half*C_star)/max(0.01,1-eps_NTU_half))^2-C_star);
    Real eps_NTU_limit = (2*eps_NTU_half)/(1+eps_NTU_half);

    //Real eps_NTU = (((1-eps_NTU_half*C_star)/max(0.01,1-eps_NTU_half))^2-1)/(((1-eps_NTU_half*C_star)/max(0.01,1-eps_NTU_half))^2-C_star);
    Real eps_NTU = max(eps_NTU_precise, eps_NTU_limit) "eps_NTU_precise is always higher than eps_NTU_limit, except near 1, because the regularization with 0.01";
    //Real eps_NTU = if C_star >= 0.9975 then eps_NTU_limit else eps_NTU_precise // "including the exception for C_star==1";
    //Real eps_NTU = if C_star >= 0.9975 then (2*eps_NTU_half)/(1+eps_NTU_half) else (((1-eps_NTU_half*C_star)/max(0.01,1-eps_NTU_half))^2-1)/(((1-eps_NTU_half*C_star)/max(0.01,1-eps_NTU_half))^2-C_star);

    //Real h_wb_out_top = 1000*(0.002*wetBulOut.TWetBul^3-0.0588*wetBulOut.TWetBul^2+3.2447*wetBulOut.TWetBul);
    //Medium1.specificEnthalpy(Medium1.setState_pTX(port_a1.p, wetBulOut.TWetBul, {wetBulOut.XiSat,1-wetBulOut.XiSat}));
    //Real h_wb_in_top = 1000*(0.002*wetBulIn.TWetBul^3-0.0588*wetBulIn.TWetBul^2+3.2447*wetBulIn.TWetBul);
    //Medium1.specificEnthalpy(Medium1.setState_pTX(port_a1.p, wetBulIn.TWetBul,  {wetBulIn.XiSat,1-wetBulIn.XiSat}));
    //Real dT_wb_top = AixLib.Utilities.Math.Functions.inverseXRegularized(wetBulOut.TWetBul-wetBulIn.TWetBul,0.01);
    //Real cp_top = (h_wb_out_top-h_wb_in_top)*dT_wb_top;


    Real cp_top= (6*(wetBulOut.TWetBul-273.15)^2-117.6*(wetBulOut.TWetBul-273.15) + 3244.7+6*(wetBulIn.TWetBul-273.15)^2-117.6*(wetBulIn.TWetBul-273.15)+3244.7)/2
    "polyfit aus GrenzwertTwb.m";

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


    Modelica.Blocks.Sources.RealExpression hLiq(y=
          AixLib.Media.Water.enthalpyOfLiquid(273.15 + 17))
      "Enthalpy of water at the given temperature"
      annotation (Placement(transformation(extent={{134,12},{94,36}})));
    Modelica.Blocks.Math.Product Q_flow
      "enthalpy added to the air from the water flow rate"
      annotation (Placement(transformation(extent={{70,26},{50,6}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHeaFloTop1(
                                                                          final
        alpha=0) "Prescribed heat flow rate for top volume"
      annotation (Placement(transformation(extent={{36,6},{16,26}})));
    Modelica.Blocks.Math.Product Q_flow1
      "heat flow rate added to the air from the water flow rate"
      annotation (Placement(transformation(extent={{70,-4},{50,-24}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHeaFloTop2(
                                                                          final
        alpha=0) "Prescribed heat flow rate for top volume"
      annotation (Placement(transformation(extent={{38,-36},{18,-16}})));
    Modelica.Blocks.Sources.RealExpression hLiq1(y=
          AixLib.Media.Water.enthalpyOfLiquid(273.15 + 17))
      "Enthalpy of water at the given temperature"
      annotation (Placement(transformation(extent={{136,-38},{96,-14}})));
  equation
    assert(port_a1.m_flow>-m_flow_small or allowFlowReversal1, "Flow reversal occured, for indirect evaporative heat exchanger model is not valid.");
    assert(port_a2.m_flow>-m_flow_small or allowFlowReversal2, "Flow reversal occured, for indirect evaporative heat exchanger model is not valid.");

    // model from: Liu, Z., Allen, W., & Modera, M. (2013). Simplified thermal modeling of indirect evaporative heat exchangers. HVAC&R Research, 19(March), 37–41. doi:10.1080/10789669.2013.763653
    Qmax=C_min*(T_bot_in-T_top_in_wet);
    C_top = port_a1.m_flow*(if adiabaticOn
                            then cp_top
                            else Medium1.specificHeatCapacityCp(Medium1.setState_phX(port_a1.p, inStream(port_a1.h_outflow), {inStream(port_a1.Xi_outflow[1]),1-inStream(port_a1.Xi_outflow[1])})));
                            //then max(cp_top_min,(h_wb_out_top-h_wb_in_top)*dT_wb_top)
                            //then (Medium1.specificEnthalpy(Medium1.setState_pTX(port_a1.p, wetBulOut.TWetBul, {wetBulOut.XiSat,1-wetBulOut.XiSat}))-Medium1.specificEnthalpy(Medium1.setState_pTX(port_a1.p, wetBulIn.TWetBul,  {wetBulIn.XiSat,1-wetBulIn.XiSat})))*AixLib.Utilities.Math.Functions.inverseXRegularized(wetBulOut.TWetBul-wetBulIn.TWetBul,0.01)

                          //else Medium1.specificHeatCapacityCp(Medium1.setState_pTX(Medium1.p_default, Medium1.T_default, Medium1.X_default)));
    C_bot = port_a2.m_flow*Medium2.specificHeatCapacityCp(Medium2.setState_phX(port_a2.p, inStream(port_a2.h_outflow), {inStream(port_a2.Xi_outflow[1]),1-inStream(port_a2.Xi_outflow[1])}));
                          //Medium2.specificHeatCapacityCp(Medium2.setState_pTX(Medium2.p_default, Medium2.T_default, Medium2.X_default));
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
      annotation (Line(points={{38.6,-42},{12,-42}}, color={0,0,127}));
    connect(hLiq.y, Q_flow.u1) annotation (Line(points={{92,24},{82,24},{82,10},
            {72,10}}, color={0,0,127}));
    connect(mFloAdiTop.y, Q_flow.u2) annotation (Line(points={{38.6,42},{36,42},
            {36,32},{76,32},{76,22},{72,22}}, color={0,0,127}));
    connect(Q_flow.y, preHeaFloTop1.Q_flow)
      annotation (Line(points={{49,16},{36,16}}, color={0,0,127}));
    connect(preHeaFloTop1.port, volTop.heatPort) annotation (Line(points={{16,16},
            {10,16},{10,34},{10,34},{10,50},{10,50}}, color={191,0,0}));
    connect(mFloAdiBot.y, Q_flow1.u1) annotation (Line(points={{38.6,-42},{38,-42},
            {38,-32},{86,-32},{86,-20},{72,-20}}, color={0,0,127}));
    connect(Q_flow1.y, preHeaFloTop2.Q_flow) annotation (Line(points={{49,-14},
            {44,-14},{44,-26},{38,-26}}, color={0,0,127}));
    connect(preHeaFloTop2.port, volBot.heatPort)
      annotation (Line(points={{18,-26},{10,-26},{10,-50}}, color={191,0,0}));
    connect(hLiq1.y, Q_flow1.u2) annotation (Line(points={{94,-26},{90,-26},{90,
            -8},{72,-8}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end recHeaExc;

  model Recuperator
    "model of the recuperator with adiabatic cooling after Jorissen et al."
   extends AixLib.Fluid.Interfaces.PartialFourPortInterface;

    import SI = Modelica.SIunits;

    Fluid.Actuators.Valves.TwoWayEqualPercentage
                             Y03(
      l=0.001,
      dpValve_nominal=10,
      y_start=0,
      redeclare package Medium = Medium1,
      m_flow_nominal=m1_flow_nominal)
               "damper at bypass of recuperator on exhaust air side"
      annotation (Placement(transformation(extent={{-10,50},{10,70}})));
    Fluid.Actuators.Valves.TwoWayEqualPercentage
                             Y01(
      l=0.001,
      dpValve_nominal=10,
      redeclare package Medium = Medium2,
      m_flow_nominal=m2_flow_nominal)
               "damper at entry of recuperator of supply air side" annotation (
        Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=-90,
          origin={50,-36})));
    Fluid.Actuators.Valves.TwoWayEqualPercentage
                             Y02(
      l=0.001,
      dpValve_nominal=10,
      y_start=0,
      redeclare package Medium = Medium2,
      m_flow_nominal=m2_flow_nominal)
               "damper at bypass of recuperator"
      annotation (Placement(transformation(extent={{10,-70},{-10,-50}})));
    Modelica.Blocks.Interfaces.RealInput Y03_opening
      "valve Input for Y03 opening" annotation (Placement(transformation(
          extent={{15,-15},{-15,15}},
          rotation=90,
          origin={31,103})));
    Modelica.Blocks.Interfaces.RealInput Y01_opening "valve Input for valve Y01"
      annotation (Placement(transformation(
          extent={{15,-15},{-15,15}},
          rotation=90,
          origin={71,103})));
    Modelica.Blocks.Interfaces.RealInput Y02_opening "valve Input for Y02"
      annotation (Placement(transformation(
          extent={{15,-15},{-15,15}},
          rotation=90,
          origin={-29,103})));
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
    Modelica.Blocks.Interfaces.RealOutput Y02_actual
      "actual value of valve opening of Y02" annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-106,0})));
    Fluid.FixedResistances.PressureDrop resSupAir(
      redeclare package Medium = Medium2,
      dp_nominal=132,
      m_flow_nominal=m2_flow_nominal)
                       "combined pressure loss of supply air side"
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-52,-18})));
    Fluid.FixedResistances.PressureDrop resSupAir1(
      redeclare package Medium = Medium1,
      m_flow_nominal=m1_flow_nominal,
      dp_nominal=127)  "combined pressure loss of supply air side"
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=270,
          origin={48,38})));
  equation
    connect(Y03_opening, Y03.y) annotation (Line(points={{31,103},{31,78},{0,78},
            {0,72}}, color={0,0,127}));
    connect(Y01_opening, Y01.y)
      annotation (Line(points={{71,103},{71,-36},{62,-36}},
                                                    color={0,0,127}));
    connect(Y02.y, Y02_opening) annotation (Line(points={{0,-48},{-29,-48},{-29,
            103}},       color={0,0,127}));
    connect(Y01.port_b, recHeaExc1.port_a2) annotation (Line(points={{50,-26},{
            48,-26},{48,10},{48,10},{48,10},{10,10},{10,10}}, color={0,127,255}));
    connect(adiCoo, recHeaExc1.adiabaticOn)
      annotation (Line(points={{106,16},{10.4,16}}, color={255,0,255}));
    connect(port_a2, Y01.port_a) annotation (Line(points={{100,-60},{50,-60},{
            50,-46}}, color={0,127,255}));
    connect(port_a2, Y02.port_a)
      annotation (Line(points={{100,-60},{10,-60}}, color={0,127,255}));
    connect(Y03.port_b, port_b1)
      annotation (Line(points={{10,60},{100,60}}, color={0,127,255}));
    connect(Y02.port_b, port_b2)
      annotation (Line(points={{-10,-60},{-100,-60}}, color={0,127,255}));
    connect(recHeaExc1.port_a1, port_a1) annotation (Line(points={{-10,22},{-54,
            22},{-54,60},{-100,60}}, color={0,127,255}));
    connect(Y03.port_a, port_a1)
      annotation (Line(points={{-10,60},{-100,60}}, color={0,127,255}));
    connect(Y02.y_actual, Y02_actual) annotation (Line(points={{-5,-53},{-79.5,
            -53},{-79.5,0},{-106,0}}, color={0,0,127}));
    connect(recHeaExc1.port_b2, resSupAir.port_a) annotation (Line(points={{-10,
            10},{-52,10},{-52,-8}}, color={0,127,255}));
    connect(resSupAir.port_b, port_b2) annotation (Line(points={{-52,-28},{-52,
            -60},{-100,-60}}, color={0,127,255}));
    connect(recHeaExc1.port_b1, resSupAir1.port_a)
      annotation (Line(points={{10,22},{48,22},{48,28}}, color={0,127,255}));
    connect(resSupAir1.port_b, port_b1)
      annotation (Line(points={{48,48},{48,60},{100,60}}, color={0,127,255}));
     annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={28,108,200},
            fillColor={0,0,255},
            fillPattern=FillPattern.CrossDiag,
            radius=10)}),                                           Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Recuperator;

  model AbsorberSimple
    "simple model of an absorber after Gandhisan2004"

    import SI = Modelica.SIunits;

    // Diagnostics
    parameter Boolean show_T = false
      "= true, if actual temperature at port is computed"
      annotation(Dialog(tab="Advanced",group="Diagnostics"));


    // Medien
    replaceable package Medium1 =
        Modelica.Media.Interfaces.PartialMedium "Medium 1 in the component, air"
        annotation (choicesAllMatching = true);

    replaceable package Medium2 =
        Modelica.Media.Interfaces.PartialMedium "Medium 2 in the component, water"
        annotation (choicesAllMatching = true);


    // Druckverluste
    parameter SI.Pressure dp_abs = 300 "Druckverlust im Absorber nominal: 300 Pa";
    parameter SI.Pressure dp_des = 0 "Druckverlust im Desorber, hier nicht notwendig, global definiert";
    parameter SI.Pressure dp_wat = 15300 "Druckverlust im Wasserkreislauf, laut Datenblatt. Prüfen, ob notwendig";


    //Port 1
    parameter Boolean allowFlowReversal1=true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal for medium 1"
      annotation (Dialog(tab="Assumptions"), Evaluate=true);
    parameter Modelica.SIunits.MassFlowRate m1_flow_nominal(min=0)
      "Nominal mass flow rate" annotation (Dialog(group="Nominal condition"));
    parameter Medium1.MassFlowRate m1_flow_small(min=0) = 1E-4*abs(
      m1_flow_nominal) "Small mass flow rate for regularization of zero flow"
      annotation (Dialog(tab="Advanced"));
    Medium1.MassFlowRate m1_flow=port_a1.m_flow
      "Mass flow rate from port_a1 to port_b1 (m1_flow > 0 is design flow direction)";
    Modelica.SIunits.PressureDifference dp1(displayUnit="Pa") = port_a1.p -
      port_b1.p "Pressure difference between port_a1 and port_b1";

    Medium1.ThermodynamicState sta_a1=Medium1.setState_phX(
        port_a1.p,
        noEvent(actualStream(port_a1.h_outflow)),
        noEvent(actualStream(port_a1.Xi_outflow))) if
           show_T "Medium properties in port_a1";
    Medium1.ThermodynamicState sta_b1=Medium1.setState_phX(
        port_b1.p,
        noEvent(actualStream(port_b1.h_outflow)),
        noEvent(actualStream(port_b1.Xi_outflow))) if
           show_T "Medium properties in port_b1";
  protected
    Medium1.ThermodynamicState state_a1_inflow=Medium1.setState_phX(
        port_a1.p,
        inStream(port_a1.h_outflow),
        inStream(port_a1.Xi_outflow))
      "state for medium inflowing through port_a1";
    Medium1.ThermodynamicState state_b1_inflow=Medium1.setState_phX(
        port_b1.p,
        inStream(port_b1.h_outflow),
        inStream(port_b1.Xi_outflow))
      "state for medium inflowing through port_b1";


    //Port 2
  public
    parameter Boolean allowFlowReversal2=true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal for medium 1"
      annotation (Dialog(tab="Assumptions"), Evaluate=true);
    parameter Modelica.SIunits.MassFlowRate m2_flow_nominal(min=0)
      "Nominal mass flow rate" annotation (Dialog(group="Nominal condition"));
    parameter Medium1.MassFlowRate m2_flow_small(min=0) = 1E-4*abs(
      m2_flow_nominal) "Small mass flow rate for regularization of zero flow"
      annotation (Dialog(tab="Advanced"));
    Medium1.MassFlowRate m2_flow=port_a2.m_flow
      "Mass flow rate from port_a2 to port_b2 (m2_flow > 0 is design flow direction)";
    Modelica.SIunits.PressureDifference dp2(displayUnit="Pa") = port_a2.p -
      port_b2.p "Pressure difference between port_a2 and port_b2";

    Medium1.ThermodynamicState sta_a2=Medium1.setState_phX(
        port_a2.p,
        noEvent(actualStream(port_a2.h_outflow)),
        noEvent(actualStream(port_a2.Xi_outflow))) if
           show_T "Medium properties in port_a2";
    Medium1.ThermodynamicState sta_b2=Medium1.setState_phX(
        port_b2.p,
        noEvent(actualStream(port_b2.h_outflow)),
        noEvent(actualStream(port_b2.Xi_outflow))) if
           show_T "Medium properties in port_b2";
  protected
    Medium1.ThermodynamicState state_a2_inflow=Medium1.setState_phX(
        port_a2.p,
        inStream(port_a2.h_outflow),
        inStream(port_a2.Xi_outflow))
      "state for medium inflowing through port_a2";
    Medium1.ThermodynamicState state_b2_inflow=Medium1.setState_phX(
        port_b2.p,
        inStream(port_b2.h_outflow),
        inStream(port_b2.Xi_outflow))
      "state for medium inflowing through port_b2";


    //Port 3
  public
    parameter Boolean allowFlowReversal3=true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal for medium 2"
      annotation (Dialog(tab="Assumptions"), Evaluate=true);
    parameter Modelica.SIunits.MassFlowRate m3_flow_nominal(min=0)
      "Nominal mass flow rate" annotation (Dialog(group="Nominal condition"));
    parameter Medium2.MassFlowRate m3_flow_small(min=0) = 1E-4*abs(
      m3_flow_nominal) "Small mass flow rate for regularization of zero flow"
      annotation (Dialog(tab="Advanced"));
    Medium2.MassFlowRate m3_flow=port_a3.m_flow
      "Mass flow rate from port_a3 to port_b3 (m3_flow > 0 is design flow direction)";
    Modelica.SIunits.PressureDifference dp3(displayUnit="Pa") = port_a3.p -
      port_b3.p "Pressure difference between port_a3 and port_b3";

    Medium2.ThermodynamicState sta_a3=Medium2.setState_phX(
        port_a3.p,
        noEvent(actualStream(port_a3.h_outflow)),
        noEvent(actualStream(port_a3.Xi_outflow))) if
           show_T "Medium properties in port_a3";
    Medium2.ThermodynamicState sta_b3=Medium2.setState_phX(
        port_b3.p,
        noEvent(actualStream(port_b3.h_outflow)),
        noEvent(actualStream(port_b3.Xi_outflow))) if
           show_T "Medium properties in port_b3";



    // Parameters for inverseXRegularized.
    // These are assigned here for efficiency reason.
    // Otherwise, they would need to be computed each time
    // the function is invocated.

  protected
    final parameter Real deltaReg = m1_flow_small/1E3
      "Smoothing region for inverseXRegularized";
    final parameter Real deltaInvReg = 1/deltaReg
      "Inverse value of delta for inverseXRegularized";
    final parameter Real aReg = -15*deltaInvReg
      "Polynomial coefficient for inverseXRegularized";
    final parameter Real bReg = 119*deltaInvReg^2
      "Polynomial coefficient for inverseXRegularized";
    final parameter Real cReg = -361*deltaInvReg^3
      "Polynomial coefficient for inverseXRegularized";
    final parameter Real dReg = 534*deltaInvReg^4
      "Polynomial coefficient for inverseXRegularized";
    final parameter Real eReg = -380*deltaInvReg^5
      "Polynomial coefficient for inverseXRegularized";
    final parameter Real fReg = 104*deltaInvReg^6
      "Polynomial coefficient for inverseXRegularized";

    // parameter description from Martin and Goswami, 2000

    parameter Real C1Y =  48.3    "parameter C1 for alpha";
    parameter Real C1H =  3.77    "parameter C1 for beta";
    parameter Real bY =   -0.751  "parameter b for alpha";
    parameter Real bH =   -0.528  "parameter b for beta";
    parameter Real k1Y =  0.396   "parameter k1 for alpha";
    parameter Real k1H =  0.289   "parameter k1 for beta";
    parameter Real m1Y =  -1.57   "parameter m1 for alpha";
    parameter Real m1H =  -1.12   "parameter m1 for beta";
    parameter Real k2Y =  0.0331  "parameter k2 for alpha";
    parameter Real k2H =  -0.0044 "parameter k2 for beta";
    parameter Real m2Y =  -0.906  "parameter m2 for alpha";
    parameter Real m2H =  -0.365  "parameter m2 for beta";

    Real aY = k1Y * gammaS_C + m1Y  "exponent for L/G in alpha";
    Real aH = k1H * gammaS_C + m1H  "exponent for L/G in beta";

    Real cY = k2Y * gammaS_C + m2Y  "exponent for a_t*Z in alpha";
    Real cH = k2H * gammaS_C + m2H  "exponent for a_t*Z in beta";

    final parameter Real s[Medium1.nXi] = {if Modelica.Utilities.Strings.isEqual(string1=Medium1.substanceNames[i],
                                              string2="Water",
                                              caseSensitive=false)
                                              then 1 else 0 for i in 1:Medium1.nXi}
      "Vector with zero everywhere except where species is";

    //influence parameters:
  public
    parameter SI.Mass m_ges =          400 "total mass of desiccant solution in the system";
    parameter Real x_sol =             0.365 "desiccant solution concentration at start";
    parameter SI.Temperature t_sol =   26+t_ref  "desiccant solution inlet temperature";
    parameter SI.Temperature t_ci =    22+t_ref "temperature of cooling water at inlet, from Menerga data sheet";
    parameter SI.Temperature t_ref =   273.15 "reference temperature";
    parameter Real a_t =               320 "specific surface area of packing in m^2/m^3";
    parameter Real Z =                 0.35 "packed bed height in m";
    parameter Real eps_HE =            0.8 "Heat exchanger effectiveness (absorber as a HE)";

    parameter SI.HeatCapacity lambda = 2430000 "latent heat of condensation in J/kg";
    parameter SI.SpecificHeatCapacity c_ps = 2700 "specific heat capacity of desiccant solution in J/kgK";
    parameter SI.SpecificHeatCapacity c_pa = 1005 "specific heat capacity of airflow in J/kgK";
    parameter SI.SpecificHeatCapacity c_pw = 4181.8 "specific heat capacity of water in J/kgK at 20°C";
    parameter SI.Density rho_s = 1220 "in kg/m^3, density of solution with x= 0,36 kg/kg and 30 °C";
    parameter SI.Density rho_a = 1.17 "in kg/m^3, density of air at 25°C and 50% relative humidity";
    parameter SI.SurfaceTension gamma_s = 88/1000 "Surface tension in N/m at 26°C and x = 0,375 kg/kg";
    parameter SI.SurfaceTension gamma_c = 29/1000 "critical surface tension of 15 mm PP Pall rings (martin, goswani, 2000)";
    parameter SI.Area A_a = 1.9367 "1810*1070, Area air of absorber in m^2";
    parameter SI.Area A_s = 0.8145 "1810*450, Area liquid of absorber in m^2";
    parameter SI.Area A_reg = 0.763 "1810*350Area of desorber in m^2";


    Real gammaS_C = gamma_s/gamma_c "quotient of surface tension of liquid by critical surface tension in Range 0,8-3,2";
    Real L_G "dimensionless quotient of mass flux (flow rate per area)
     of desiccant solution by Airflow in kg/m^2s in Range 3,5-15,4";
    Real atZ = a_t* Z "specific surface area * bed height in range 84 - 262";

    SI.MassFlowRate L = 15.2/3600*rho_s "original as mass flux, mass flow of desiccant solution in kg/s";
    //liegt hier eine andere Fläche vor als A?

    SI.MassFlowRate G = m1_flow "original as mass flux, mass flow of Air in kg/s";
    //SI.MassFlowRate R = m2_flow "mass flux (flow rate per area) of Airflow in regeneration in kg/m^2s";

    Real C_s "heat capacity flow of desiccant solution in kW/°C";
    Real C_a "heat capacity flow of airflow in kW/°C";

    Real Hai_Hsi "temperature ratio of air inlet by desiccant inlet in °C in range 0,4-1,9";

    Real alpha "humidity effectiveness, defined with absolute humidities, in this case simplified with water pressure";
    Real beta "enthalpy effectiveness, defined over enthalpy, here simplified with temperatures";

    //relevant variables for calculation of m from Gandhisan 2004
    //SI.Temperature t_ai_reg = t_ai;  //AixLib.Media.Air.temperature(state_a1_inflow)  "temperature of air at inlet";
    //SI.Temperature t_ao_reg  "temperature of air at outlet";

    SI.Temperature t_ai = Medium1.temperature(state_a1_inflow)  "temperature of air at inlet";
    SI.Temperature t_ao  "temperature of air at outlet";
    SI.Temperature t_si( start=t_sol)  "temperature of desiccant solution at inlet";
    SI.Temperature t_so  "temperature of desiccant solution at outlet";

    SI.MassFlowRate m "water vapor mass flow per area in kg/s going from desiccant to air flow";
    //Real m_reg "water vapor mass flow per area in kg/sm^2 in desorber going from air flow to desiccant";

    Modelica.SIunits.MassFlowRate m1Xi_flow[Medium1.nXi]
      "Mass flow rates of independent substances added to the medium";

    Real m1_flowInv(unit="s/kg") "Regularization of 1/m_flow of port_a";

    //Real X1_in[Medium1.nXi] = inStream(port_a1.Xi_outflow) "absolute humidity of outside air at entry in kg/kg";
    //Real X2_in[2] = inStream(port_a2.Xi_outflow) "absolute humidity of outside air at entry in kg/kg";

    //Real X1_out[Medium1.nXi]  "absolute humidity of supply air after absorber in kg/kg";
    //Real X2_out[2]  "absolute humidity of regeneration air after desorber in kg/kg";

    Real x_i( start=x_sol) "inlet concentration of desiccant solution";
    Real x_o "outlet concentration of desiccant solution";

    SI.Temperature t_s1( start=t_sol) "temperature of absorber solution tank";
    //SI.Temperature t_s2 "temperature of desorber solution tank";

    SI.Mass m_1 "mass of desiccant solution in absorber tank";
    SI.Mass m_2 "mass of desiccant solution in desorber tank";

    Real x_1( start=x_sol) "concentration of desiccant solution in absorber tank";
    //Real x_2 "concentration of desiccant solution in desorber tank";








    Modelica.Fluid.Interfaces.FluidPort_a port_a3(
      m_flow(min=if allowFlowReversal3 then -Modelica.Constants.inf else 0),
      redeclare final package Medium = Medium2,
      h_outflow(start=Medium2.h_default))
      "Fluid connector a3 (positive design flow direction is from port_a3 to port_b3)"
      annotation (Placement(transformation(extent={{-110,0},{-90,20}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b3(
      m_flow(max=if allowFlowReversal3 then +Modelica.Constants.inf else 0),
      redeclare final package Medium = Medium2,
      h_outflow(start=Medium2.h_default))
      "Fluid connector b3 (positive design flow direction is from port_a3 to port_b3)"
      annotation (Placement(transformation(extent={{-90,-20},{-110,0}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a1(
      redeclare final package Medium = Medium1,
      m_flow(min=if allowFlowReversal1 then -Modelica.Constants.inf else 0),
      h_outflow(start=Medium1.h_default))
      "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
      annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b1(
      redeclare final package Medium = Medium1,
      m_flow(max=if allowFlowReversal1 then +Modelica.Constants.inf else 0),
      h_outflow(start=Medium1.h_default))
      "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
      annotation (Placement(transformation(extent={{-90,-70},{-110,-50}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a2(
      redeclare final package Medium = Medium1,
      m_flow(min=if allowFlowReversal2 then -Modelica.Constants.inf else 0),
      h_outflow(start=Medium1.h_default))
      "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
      annotation (Placement(transformation(extent={{90,50},{110,70}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b2(
      redeclare final package Medium = Medium1,
      m_flow(max=if allowFlowReversal2 then +Modelica.Constants.inf else 0),
      h_outflow(start=Medium1.h_default))
      "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
      annotation (Placement(transformation(extent={{-90,50},{-110,70}})));

  initial equation
    // Assert that the substance with name 'water' has been found.
    assert(Medium1.nXi == 0 or abs(sum(s)-1) < 1e-5,
        "If Medium1.nXi > 1, then substance 'water' must be present for one component.'"
           + Medium1.mediumName + "'.\n"
           + "Check medium model.");

  equation

    m1_flowInv = AixLib.Utilities.Math.Functions.inverseXRegularized(
                         x=port_a1.m_flow,
                         delta=deltaReg, deltaInv=deltaInvReg,
                         a=aReg, b=bReg, c=cReg, d=dReg, e=eReg, f=fReg);

    //pressure loss
    dp1=dp_abs;
    dp2=dp_des;
    dp3=dp_wat;

    //Mass balance Air:
    port_b1.m_flow  =  m1_flow - m;
    port_b2.m_flow  =  m2_flow;//  -  m_reg;
    port_b3.m_flow  =  m3_flow;

    m_2  =  200;
    m_ges  =  m_1 + m_2;

    //Mass balance Water:
    port_a1.Xi_outflow  =  inStream(port_b1.Xi_outflow);
    port_a2.Xi_outflow  =  inStream(port_b2.Xi_outflow);

    port_b1.Xi_outflow  =  inStream(port_a1.Xi_outflow) + m1Xi_flow * m1_flowInv;
    port_b2.Xi_outflow  =  inStream(port_a2.Xi_outflow);

       //storage
    m_1 * der(x_1)  =  L * (x_o - x_1);
    //m_2 * der(x_2)  =  R * (x_1 - x_2) "stimmt so nicht, erst regeneration, dann speicher";

    //Energy balance:
    port_a1.h_outflow  =  inStream(port_b1.h_outflow);
    port_a2.h_outflow  =  inStream(port_b2.h_outflow);
    port_a3.h_outflow  =  inStream(port_b3.h_outflow);

    port_b1.h_outflow  =  c_pa*t_ao "Gleichung bestimmen";    //inStream(port_a1.h_outflow);//
    port_b2.h_outflow  =  inStream(port_a2.h_outflow);  //c_pa*t_ao_reg "Gleichung bestimmen";
    port_b3.h_outflow  =  inStream(port_a3.h_outflow);

      //storage
    m_1 * der(t_s1)  =  L * (t_so - t_s1);
    //m_2 * der(t_s2)  =  R * (t_s1 - t_s2);

    //particles
    port_b1.C_outflow  =  inStream(port_a1.C_outflow);
    port_b2.C_outflow  =  inStream(port_a2.C_outflow);

    t_so  =  t_ao  "Annahme: Ausgang der Sole hat die selbe Temperatur wie die Luft";

    //Hier Koeffizienten abbilden
    L_G      =  (L/A_s) / (G/A_a);
    Hai_Hsi  =  c_pa*(t_ai-t_ref) / (c_ps*(t_si-t_ref));

    //Test:
    //Hai_Hsi  =  (t_ai-t_ref) / (t_si-t_ref);


    alpha    =  1 - C1Y * (L_G)^aY * (Hai_Hsi)^bY * (atZ)^cY;
    beta     =  1 - C1H * (L_G)^aH * (Hai_Hsi)^bH * (atZ)^cH;


    //Capacity Streams
    C_a  =  G * c_pa;
    C_s  =  L * c_ps;


    //alpha   =  (p_ai-p_ao) / (p_ai-p_si);
    //beta    =  c_pa*(t_ai - t_ao) / (c_pa*(t_ai-t_ref) - c_ps*(t_si-t_ref));
    beta  =  (t_ai-t_ao) / (t_ai-t_si);

    //t_so-t_ref  =  ((t_si-t_ref) - eps_HE * c_pw/c_ps * (t_ci-t_ref)) / (1-eps_HE);
    //eps_HE  =  c_ps*(t_so - t_si) / (c_ps*(t_so-t_ref) - c_pw*(t_ci-t_ref));
    //eps_HE  =  c_ps*(t_s1 - t_si) / (c_ps*(t_s1-t_ref) - c_pw*(t_ci-t_ref));
    eps_HE  =  (t_s1 - t_si) / (t_s1 - t_ci);

    m = 1/lambda*(C_s*eps_HE/(1 - eps_HE)*(t_si - t_ci) - C_a*beta*(t_ai - t_si)) "water exchange in kg/s";

    // Species flow rate from connector mWat_flow
    m1Xi_flow = m * s;
    //m_reg = 0.015;  //1/lambda*(C_s*eps_HE/(1 - eps_HE)*(t_si - t_ci) - C_a*beta*(t_ai - t_si)) "water exchange in kg/s";

    1/x_o  =  1/x_i * (1 + m/L);
    x_i  =  x_1;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end AbsorberSimple;

  model AbsorberSimpleTank
    "simple model of an absorber after Gandhisan2004 without cooling heat exchanger and eps_HE model"

    import SI = Modelica.SIunits;

    // Diagnostics
    parameter Boolean show_T = false
      "= true, if actual temperature at port is computed"
      annotation(Dialog(tab="Advanced",group="Diagnostics"));

    // Medien
    replaceable package Medium1 =
        Modelica.Media.Interfaces.PartialMedium "Medium 1 in the component, air"
        annotation (choicesAllMatching = true);

    replaceable package Medium2 =
        Modelica.Media.Interfaces.PartialMedium "Medium 2 in the component, water"
        annotation (choicesAllMatching = true);

    // Druckverluste
    parameter SI.Pressure dp_abs = 300 "Druckverlust im Absorber nominal: 300 Pa";
    parameter SI.Pressure dp_des = 0 "Druckverlust im Desorber, hier nicht notwendig, global definiert";
    parameter SI.Pressure dp_wat = 15300 "Druckverlust im Wasserkreislauf, laut Datenblatt. Prüfen, ob notwendig";

    //Port 1
    parameter Boolean allowFlowReversal1=true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal for medium 1"
      annotation (Dialog(tab="Assumptions"), Evaluate=true);
    parameter Modelica.SIunits.MassFlowRate m1_flow_nominal(min=0)
      "Nominal mass flow rate" annotation (Dialog(group="Nominal condition"));
    parameter Medium1.MassFlowRate m1_flow_small(min=0) = 1E-4*abs(
      m1_flow_nominal) "Small mass flow rate for regularization of zero flow"
      annotation (Dialog(tab="Advanced"));
    Medium1.MassFlowRate m1_flow=port_a1.m_flow
      "Mass flow rate from port_a1 to port_b1 (m1_flow > 0 is design flow direction)";
    Modelica.SIunits.PressureDifference dp1(displayUnit="Pa") = port_a1.p -
      port_b1.p "Pressure difference between port_a1 and port_b1";

    Medium1.ThermodynamicState sta_a1=Medium1.setState_phX(
        port_a1.p,
        noEvent(actualStream(port_a1.h_outflow)),
        noEvent(actualStream(port_a1.Xi_outflow))) if
           show_T "Medium properties in port_a1";
    Medium1.ThermodynamicState sta_b1=Medium1.setState_phX(
        port_b1.p,
        noEvent(actualStream(port_b1.h_outflow)),
        noEvent(actualStream(port_b1.Xi_outflow))) if
           show_T "Medium properties in port_b1";
  protected
    Medium1.ThermodynamicState state_a1_inflow=Medium1.setState_phX(
        port_a1.p,
        inStream(port_a1.h_outflow),
        inStream(port_a1.Xi_outflow))
      "state for medium inflowing through port_a1";
    Medium1.ThermodynamicState state_b1_inflow=Medium1.setState_phX(
        port_b1.p,
        inStream(port_b1.h_outflow),
        inStream(port_b1.Xi_outflow))
      "state for medium inflowing through port_b1";

    //Port 2
  public
    parameter Boolean allowFlowReversal2=true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal for medium 1"
      annotation (Dialog(tab="Assumptions"), Evaluate=true);
    parameter Modelica.SIunits.MassFlowRate m2_flow_nominal(min=0)
      "Nominal mass flow rate" annotation (Dialog(group="Nominal condition"));
    parameter Medium1.MassFlowRate m2_flow_small(min=0) = 1E-4*abs(
      m2_flow_nominal) "Small mass flow rate for regularization of zero flow"
      annotation (Dialog(tab="Advanced"));
    Medium1.MassFlowRate m2_flow=port_a2.m_flow
      "Mass flow rate from port_a2 to port_b2 (m2_flow > 0 is design flow direction)";
    Modelica.SIunits.PressureDifference dp2(displayUnit="Pa") = port_a2.p -
      port_b2.p "Pressure difference between port_a2 and port_b2";

    Medium1.ThermodynamicState sta_a2=Medium1.setState_phX(
        port_a2.p,
        noEvent(actualStream(port_a2.h_outflow)),
        noEvent(actualStream(port_a2.Xi_outflow))) if
           show_T "Medium properties in port_a2";
    Medium1.ThermodynamicState sta_b2=Medium1.setState_phX(
        port_b2.p,
        noEvent(actualStream(port_b2.h_outflow)),
        noEvent(actualStream(port_b2.Xi_outflow))) if
           show_T "Medium properties in port_b2";
  protected
    Medium1.ThermodynamicState state_a2_inflow=Medium1.setState_phX(
        port_a2.p,
        inStream(port_a2.h_outflow),
        inStream(port_a2.Xi_outflow))
      "state for medium inflowing through port_a2";
    Medium1.ThermodynamicState state_b2_inflow=Medium1.setState_phX(
        port_b2.p,
        inStream(port_b2.h_outflow),
        inStream(port_b2.Xi_outflow))
      "state for medium inflowing through port_b2";

    //Port 3
  public
    parameter Boolean allowFlowReversal3=true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal for medium 2"
      annotation (Dialog(tab="Assumptions"), Evaluate=true);
    parameter Modelica.SIunits.MassFlowRate m3_flow_nominal(min=0)
      "Nominal mass flow rate" annotation (Dialog(group="Nominal condition"));
    parameter Medium2.MassFlowRate m3_flow_small(min=0) = 1E-4*abs(
      m3_flow_nominal) "Small mass flow rate for regularization of zero flow"
      annotation (Dialog(tab="Advanced"));
    Medium2.MassFlowRate m3_flow=port_a3.m_flow
      "Mass flow rate from port_a3 to port_b3 (m3_flow > 0 is design flow direction)";
    Modelica.SIunits.PressureDifference dp3(displayUnit="Pa") = port_a3.p -
      port_b3.p "Pressure difference between port_a3 and port_b3";

    Medium2.ThermodynamicState sta_a3=Medium2.setState_phX(
        port_a3.p,
        noEvent(actualStream(port_a3.h_outflow)),
        noEvent(actualStream(port_a3.Xi_outflow))) if
           show_T "Medium properties in port_a3";
    Medium2.ThermodynamicState sta_b3=Medium2.setState_phX(
        port_b3.p,
        noEvent(actualStream(port_b3.h_outflow)),
        noEvent(actualStream(port_b3.Xi_outflow))) if
           show_T "Medium properties in port_b3";

    // Parameters for inverseXRegularized.
    // These are assigned here for efficiency reason.
    // Otherwise, they would need to be computed each time
    // the function is invocated.

  protected
    final parameter Real deltaReg = m1_flow_small/1E3
      "Smoothing region for inverseXRegularized";
    final parameter Real deltaInvReg = 1/deltaReg
      "Inverse value of delta for inverseXRegularized";
    final parameter Real aReg = -15*deltaInvReg
      "Polynomial coefficient for inverseXRegularized";
    final parameter Real bReg = 119*deltaInvReg^2
      "Polynomial coefficient for inverseXRegularized";
    final parameter Real cReg = -361*deltaInvReg^3
      "Polynomial coefficient for inverseXRegularized";
    final parameter Real dReg = 534*deltaInvReg^4
      "Polynomial coefficient for inverseXRegularized";
    final parameter Real eReg = -380*deltaInvReg^5
      "Polynomial coefficient for inverseXRegularized";
    final parameter Real fReg = 104*deltaInvReg^6
      "Polynomial coefficient for inverseXRegularized";

    // parameter description from Martin and Goswami, 2000

    parameter Real C1Y =  48.3    "parameter C1 for alpha";
    parameter Real C1H =  3.77    "parameter C1 for beta";
    parameter Real bY =   -0.751  "parameter b for alpha";
    parameter Real bH =   -0.528  "parameter b for beta";
    parameter Real k1Y =  0.396   "parameter k1 for alpha";
    parameter Real k1H =  0.289   "parameter k1 for beta";
    parameter Real m1Y =  -1.57   "parameter m1 for alpha";
    parameter Real m1H =  -1.12   "parameter m1 for beta";
    parameter Real k2Y =  0.0331  "parameter k2 for alpha";
    parameter Real k2H =  -0.0044 "parameter k2 for beta";
    parameter Real m2Y =  -0.906  "parameter m2 for alpha";
    parameter Real m2H =  -0.365  "parameter m2 for beta";

    Real aY = k1Y * gammaS_C + m1Y  "exponent for L/G in alpha";
    Real aH = k1H * gammaS_C + m1H  "exponent for L/G in beta";

    Real cY = k2Y * gammaS_C + m2Y  "exponent for a_t*Z in alpha";
    Real cH = k2H * gammaS_C + m2H  "exponent for a_t*Z in beta";

    final parameter Real s[Medium1.nXi] = {if Modelica.Utilities.Strings.isEqual(string1=Medium1.substanceNames[i],
                                              string2="Water",
                                              caseSensitive=false)
                                              then 1 else 0 for i in 1:Medium1.nXi}
      "Vector with zero everywhere except where species is";

    //influence parameters:
  public
    parameter SI.Mass m_ges =          400 "total mass of desiccant solution in the system";
    parameter Real x_sol =             0.33 "desiccant solution concentration at start";
    parameter SI.Temperature t_sol =   26+t_ref  "desiccant solution inlet temperature";
    parameter SI.Temperature t_ci =    22+t_ref "temperature of cooling water at inlet, from Menerga data sheet";
    parameter SI.Temperature t_ref =   273.15 "reference temperature";
    parameter Real a_t =               320 "specific surface area of packing in m^2/m^3";
    parameter Real Z =                 0.35 "packed bed height in m";
    parameter Real eps_HE =            0.8 "Heat exchanger effectiveness (absorber as a HE)";

    parameter SI.HeatCapacity lambda = 2430000 "latent heat of condensation in J/kg";
    parameter SI.SpecificHeatCapacity c_ps = 2800 "specific heat capacity of desiccant solution in J/kgK";
    parameter SI.SpecificHeatCapacity c_pa = 1005 "specific heat capacity of airflow in J/kgK";
    parameter SI.SpecificHeatCapacity c_pw = 4181.8 "specific heat capacity of water in J/kgK at 20°C";
    parameter SI.Density rho_s = 1220 "in kg/m^3, density of solution with x= 0,36 kg/kg and 30 °C";
    parameter SI.Density rho_a = 1.17 "in kg/m^3, density of air at 25°C and 50% relative humidity";
    parameter SI.SurfaceTension gamma_s = 88/1000 "Surface tension in N/m at 26°C and x = 0,375 kg/kg";
    parameter SI.SurfaceTension gamma_c = 29/1000 "critical surface tension of 15 mm PP Pall rings (martin, goswani, 2000)";
    parameter SI.Area A_a = 1.9367 "1810*1070, Area air of absorber in m^2";
    parameter SI.Area A_s = 0.8145 "1810*450, Area liquid of absorber in m^2";
    parameter SI.Area A_reg = 0.763 "1810*350Area of desorber in m^2";

    Real gammaS_C = gamma_s/gamma_c "quotient of surface tension of liquid by critical surface tension in Range 0,8-3,2";
    Real L_G "dimensionless quotient of mass flux (flow rate per area)
     of desiccant solution by Airflow in kg/m^2s in Range 3,5-15,4";
    Real atZ = a_t* Z "specific surface area * bed height in range 84 - 262";

    SI.MassFlowRate L = 15.2/3600*rho_s "original as mass flux, mass flow of desiccant solution in kg/s";
    //liegt hier eine andere Fläche vor als A?

    SI.MassFlowRate G = m1_flow "original as mass flux, mass flow of Air in kg/s";
    //SI.MassFlowRate R = m2_flow "mass flux (flow rate per area) of Airflow in regeneration in kg/m^2s";

    Real C_s "heat capacity flow of desiccant solution in kW/°C";
    Real C_a "heat capacity flow of airflow in kW/°C";

    Real Hai_Hsi "temperature ratio of air inlet by desiccant inlet in °C in range 0,4-1,9";

    Real alpha "humidity effectiveness, defined with absolute humidities, in this case simplified with water pressure";
    Real beta "enthalpy effectiveness, defined over enthalpy, here simplified with temperatures";

    //relevant variables for calculation of m from Gandhisan 2004
    //SI.Temperature t_ai_reg = t_ai;  //AixLib.Media.Air.temperature(state_a1_inflow)  "temperature of air at inlet";
    //SI.Temperature t_ao_reg  "temperature of air at outlet";

    //Enthalpien und Temperaturen
    SI.Enthalpy h_ai = inStream(port_a1.h_outflow)  "inlet air enthalpy";

    SI.Temperature t_ai = Medium1.temperature(state_a1_inflow)  "temperature of air at inlet";
    SI.Temperature t_ao  "temperature of air at outlet";
    SI.Temperature t_si( start=t_sol)  "temperature of desiccant solution at inlet";
    SI.Temperature t_so  "temperature of desiccant solution at outlet";

    SI.MassFlowRate m "water vapor mass flow per area in kg/s going from desiccant to air flow";
    //Real m_reg "water vapor mass flow per area in kg/sm^2 in desorber going from air flow to desiccant";

    Modelica.SIunits.MassFlowRate m1Xi_flow[Medium1.nXi]
      "Mass flow rates of independent substances added to the medium";

    Real m1_flowInv(unit="s/kg") "Regularization of 1/m_flow of port_a";

    //Real X1_in[Medium1.nXi] = inStream(port_a1.Xi_outflow) "absolute humidity of outside air at entry in kg/kg";
    //Real X2_in[2] = inStream(port_a2.Xi_outflow) "absolute humidity of outside air at entry in kg/kg";

    //Real X1_out[Medium1.nXi]  "absolute humidity of supply air after absorber in kg/kg";
    //Real X2_out[2]  "absolute humidity of regeneration air after desorber in kg/kg";

    Real x_i( start=x_sol) "inlet concentration of desiccant solution";
    Real x_o "outlet concentration of desiccant solution";

    SI.Temperature t_s1( start=t_sol) "temperature of absorber solution tank";
    //SI.Temperature t_s2 "temperature of desorber solution tank";

    SI.Mass m_1 "mass of desiccant solution in absorber tank";
    SI.Mass m_2 "mass of desiccant solution in desorber tank";

    Real x_1( start=x_sol) "concentration of desiccant solution in absorber tank";
    //Real x_2 "concentration of desiccant solution in desorber tank";

    Modelica.Fluid.Interfaces.FluidPort_a port_a3(
      m_flow(min=if allowFlowReversal3 then -Modelica.Constants.inf else 0),
      redeclare final package Medium = Medium2,
      h_outflow(start=Medium2.h_default))
      "Fluid connector a3 (positive design flow direction is from port_a3 to port_b3)"
      annotation (Placement(transformation(extent={{-110,0},{-90,20}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b3(
      m_flow(max=if allowFlowReversal3 then +Modelica.Constants.inf else 0),
      redeclare final package Medium = Medium2,
      h_outflow(start=Medium2.h_default))
      "Fluid connector b3 (positive design flow direction is from port_a3 to port_b3)"
      annotation (Placement(transformation(extent={{-90,-20},{-110,0}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a1(
      redeclare final package Medium = Medium1,
      m_flow(min=if allowFlowReversal1 then -Modelica.Constants.inf else 0),
      h_outflow(start=Medium1.h_default))
      "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
      annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b1(
      redeclare final package Medium = Medium1,
      m_flow(max=if allowFlowReversal1 then +Modelica.Constants.inf else 0),
      h_outflow(start=Medium1.h_default))
      "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
      annotation (Placement(transformation(extent={{-90,-70},{-110,-50}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a2(
      redeclare final package Medium = Medium1,
      m_flow(min=if allowFlowReversal2 then -Modelica.Constants.inf else 0),
      h_outflow(start=Medium1.h_default))
      "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
      annotation (Placement(transformation(extent={{90,50},{110,70}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b2(
      redeclare final package Medium = Medium1,
      m_flow(max=if allowFlowReversal2 then +Modelica.Constants.inf else 0),
      h_outflow(start=Medium1.h_default))
      "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
      annotation (Placement(transformation(extent={{-90,50},{-110,70}})));

  initial equation
    // Assert that the substance with name 'water' has been found.
    assert(Medium1.nXi == 0 or abs(sum(s)-1) < 1e-5,
        "If Medium1.nXi > 1, then substance 'water' must be present for one component.'"
           + Medium1.mediumName + "'.\n"
           + "Check medium model.");

  equation

    m1_flowInv = AixLib.Utilities.Math.Functions.inverseXRegularized(
                         x=port_a1.m_flow,
                         delta=deltaReg, deltaInv=deltaInvReg,
                         a=aReg, b=bReg, c=cReg, d=dReg, e=eReg, f=fReg);

    //pressure loss
    dp1=dp_abs;
    dp2=dp_des;
    dp3=dp_wat;

    //Mass balance Air:
    port_b1.m_flow  =  m1_flow - m;
    port_b2.m_flow  =  m2_flow;//  -  m_reg;
    port_b3.m_flow  =  m3_flow;

    m_2  =  200;
    m_ges  =  m_1 + m_2;

    //Mass balance Water:
    port_a1.Xi_outflow  =  inStream(port_b1.Xi_outflow);
    port_a2.Xi_outflow  =  inStream(port_b2.Xi_outflow);

    port_b1.Xi_outflow  =  inStream(port_a1.Xi_outflow) + m1Xi_flow * m1_flowInv;
    port_b2.Xi_outflow  =  inStream(port_a2.Xi_outflow);

       //storage
    m_1 * der(x_1)  =  L * (x_o - x_1);
    //m_2 * der(x_2)  =  R * (x_1 - x_2) "stimmt so nicht, erst regeneration, dann speicher";

    //Energy balance:
    port_a1.h_outflow  =  inStream(port_b1.h_outflow);
    port_a2.h_outflow  =  inStream(port_b2.h_outflow);
    port_a3.h_outflow  =  inStream(port_b3.h_outflow);

    port_b1.h_outflow  =  c_pa*t_ao "Gleichung bestimmen";    //inStream(port_a1.h_outflow);//
    port_b2.h_outflow  =  inStream(port_a2.h_outflow);  //c_pa*t_ao_reg "Gleichung bestimmen";
    port_b3.h_outflow  =  inStream(port_a3.h_outflow);

      //storage
    m_1 * der(t_s1)  =  L * (t_so - t_s1);
    //m_2 * der(t_s2)  =  R * (t_s1 - t_s2);

    //particles
    port_b1.C_outflow  =  inStream(port_a1.C_outflow);
    port_b2.C_outflow  =  inStream(port_a2.C_outflow);

    t_so  =  t_ao  "Annahme: Ausgang der Sole hat die selbe Temperatur wie die Luft";
    t_si  =  t_s1  "Inlet entspricht Speichertemperatur";

    //Hier Koeffizienten abbilden
    L_G      =  (L/A_s) / (G/A_a);
    Hai_Hsi  =  h_ai / (c_ps*(t_si-t_ref));

    //Test:
    //Hai_Hsi  =  (t_ai-t_ref) / (t_si-t_ref);

    alpha    =  1 - C1Y * (L_G)^aY * (Hai_Hsi)^bY * (atZ)^cY;
    beta     =  1 - C1H * (L_G)^aH * (Hai_Hsi)^bH * (atZ)^cH;

    //Capacity Streams
    C_a  =  G * c_pa;
    C_s  =  L * c_ps;

    //alpha   =  (p_ai-p_ao) / (p_ai-p_si);
    //beta    =  (h_ai-h_ao) / (h_ai-h_si);
    beta  =  (t_ai-t_ao) / (t_ai-t_si);

    //t_so-t_ref  =  ((t_si-t_ref) - eps_HE * c_pw/c_ps * (t_ci-t_ref)) / (1-eps_HE);
    //eps_HE  =  c_ps*(t_so - t_si) / (c_ps*(t_so-t_ref) - c_pw*(t_ci-t_ref));
    //eps_HE  =  c_ps*(t_s1 - t_si) / (c_ps*(t_s1-t_ref) - c_pw*(t_ci-t_ref));
    //eps_HE  =  (t_s1 - t_si) / (t_s1 - t_ci);

    //m = 1/lambda*(C_s*eps_HE/(1 - eps_HE)*(t_si - t_ci) - C_a*beta*(t_ai - t_si)) "water exchange in kg/s";
    m  =  1/lambda*(C_s*(t_so-t_si) - C_a*beta*(t_ai - t_si));

    // Species flow rate from connector mWat_flow
    m1Xi_flow = m * s;
    //m_reg = 0.015;  //1/lambda*(C_s*eps_HE/(1 - eps_HE)*(t_si - t_ci) - C_a*beta*(t_ai - t_si)) "water exchange in kg/s";

    1/x_o  =  1/x_i * (1 + m/L);
    x_i  =  x_1;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end AbsorberSimpleTank;

  model Absorber
    "model of an absorber using partial vapor pressure of water"

    extends AixLib.Fluid.Interfaces.PartialTwoPortInterface;
    import SI = Modelica.SIunits;

    // Diagnostics
    parameter Boolean show_T=false "= true, if actual temperature at port is computed"
      annotation (Dialog(tab="Advanced", group="Diagnostics"));

    // Druckverluste
    parameter SI.Pressure dp_abs=0 "Druckverlust im Absorber nominal: 300 Pa";

  protected
    final parameter Real deltaReg=m_flow_small/1E3
      "Smoothing region for inverseXRegularized";
    final parameter Real deltaInvReg=1/deltaReg
      "Inverse value of delta for inverseXRegularized";
    final parameter Real aReg=-15*deltaInvReg
      "Polynomial coefficient for inverseXRegularized";
    final parameter Real bReg=119*deltaInvReg^2
      "Polynomial coefficient for inverseXRegularized";
    final parameter Real cReg=-361*deltaInvReg^3
      "Polynomial coefficient for inverseXRegularized";
    final parameter Real dReg=534*deltaInvReg^4
      "Polynomial coefficient for inverseXRegularized";
    final parameter Real eReg=-380*deltaInvReg^5
      "Polynomial coefficient for inverseXRegularized";
    final parameter Real fReg=104*deltaInvReg^6
      "Polynomial coefficient for inverseXRegularized";

    final parameter SI.Temperature T_cH2O=647.096
      "in K, temperature of water at critical point";

    final parameter Real s[Medium.nXi]={if Modelica.Utilities.Strings.isEqual(
        string1=Medium.substanceNames[i],
        string2="Water",
        caseSensitive=false) then 1 else 0 for i in 1:Medium.nXi}
      "Vector with zero everywhere except where species is";

    SI.MassFlowRate m1Xi_flow[Medium.nXi]
      "Mass flow rates of independent substances added to the medium";
    Real m_flowInv(unit="s/kg") "Regularization of 1/m_flow of port_a";
    //Real L_flowInv(unit="s/kg") "Regularization of 1/L_i";
    Real X1_in[Medium.nXi]=inStream(port_a.Xi_outflow)
      "absolute humidity of outside air at entry in kg/kg";
    parameter SI.Temperature t_ref=273.15 "reference temperature";

    //influence parameters:
  public
    parameter Real x_sol=0.33 "desiccant solution concentration at start";
    //parameter SI.Temperature t_sol =   26+273.15  "desiccant solution inlet temperature";
    parameter SI.Temperature t_sol=299.15 "desiccant solution inlet temperature";
    parameter Real a_t=320 "specific surface area of packing in m^2/m^3";
    parameter Real Z=0.35 "packed bed height in m";
    parameter Real V=0.871515 "in m^3, 1810*1070*450 mm";
    parameter Real eps=16/15  "0.85 for desorber, parameter for heat exchange in absorber / desorber unit";

    parameter Real beta=1.22345*10^(-7) "mass transfer coefficient with partial pressure as driving potential, 
  fitting parameter for mass transfer equation";
    //with inlet parameters: 6.0995*10^(-8)

    parameter SI.SpecificEnergy lambda=2430000 "latent heat of condensation in J/kg";
    //parameter SI.Area A_a = 1.9367 "1810*1070, Area air of absorber in m^2";
    //parameter SI.Area A_s = 0.8145 "1810*450, Area liquid of absorber in m^2";

    //thermodynamic states
    Media.Air.ThermodynamicState state_a=Media.Air.setState_phX(
        port_a.p,
        inStream(port_a.h_outflow),
        inStream(port_a.Xi_outflow)) "state for medium inflowing through port_a";

    Media.Air.ThermodynamicState state_b=Media.Air.setState_phX(
        port_b.p,
        port_b.h_outflow,
        port_b.Xi_outflow) "state for medium inflowing through port_b";

    //specific heat capacities
    SI.SpecificHeatCapacity c_pa_in=Media.Air.specificHeatCapacityCp(state_a)
      "specific heat capacity of airflow in J/kgK";
    SI.SpecificHeatCapacity c_pa_out=Media.Air.specificHeatCapacityCp(state_b)
      "in J/kgK, specific heat capacity of airflow at outlet";
    SI.SpecificHeatCapacity c_pw=Media.Water.specificHeatCapacityCp(state_a)
      "specific heat capacity of airflow in J/kgK";
    SI.SpecificHeatCapacity c_ps_in=BaseClasses.Utilities.specificHeatCapacityCpLiCl(t_si, x_i)
      "specific heat capacity of desiccant solution at inlet in J/kgK";
    SI.SpecificHeatCapacity c_ps_out=BaseClasses.Utilities.specificHeatCapacityCpLiCl(t_so, x_o)  "specific heat capacity of desiccant solution at inlet in J/kgK";

    //densities
    //SI.Density rho_a=Media.Air.density(state_a) "in kg/m^3, density of air";
    //SI.Density rho_s=BaseClasses.Utilities.densityLiCl(t_si, x_i) "in kg/m^3, density of LiCl solution";

    //mass flows
    SI.MassFlowRate L_o "outlet mass flow of desiccant solution in kg/s";
    //liegt hier eine andere Fläche vor als A?
    SI.MassFlowRate G_i=m_flow "original as mass flux, inlet mass flow of Air in kg/s";
    SI.MassFlowRate G_o "outlet mass flow of Air in kg/s";
    SI.MassFlowRate m
      "water vapor mass flow per area in kg/s going from air to desiccant flow";
    SI.MassFlowRate m_star
      "water vapor mass flow per area in kg/s going from air to desiccant flow without physical control of boundaries";

    //temperatures
    SI.Temperature t_ai=Media.Air.temperature(state_a) "temperature of air at inlet";
    SI.Temperature t_ao "temperature of air at outlet";
    SI.Temperature t_a = (t_ai+t_ao)/2 "average temperature of air ";
    SI.Temperature t_si(start=t_sol) "temperature of desiccant solution at inlet";
    SI.Temperature t_so  "(start=t_sol) temperature of desiccant solution at outlet";
    SI.Temperature t_s = (t_si + t_so)/2 "average temperature of brine";

    SI.HeatFlowRate Q "heat transfer between solution and air";

    //enthalpies
    SI.SpecificEnthalpy h_ai;
    SI.SpecificEnthalpy h_ao;
    SI.SpecificEnthalpy h_si;
    SI.SpecificEnthalpy h_so;

    //humidity
    Real X_iDry = inStream(port_a.Xi_outflow[1])/(1 - inStream(port_a.Xi_outflow[1]))
      "absolute humidity to dry air at inlet";
    Real X_oDry = port_b.Xi_outflow[1]/(1 - port_b.Xi_outflow[1])
      "absolute humidity to dry air at outlet";
    Real X_i = inStream(port_a.Xi_outflow[1])
      "absolute humidity to humid air at inlet";
    Real X_o = port_b.Xi_outflow[1]
      "absolute humidity to humid air at outlet";
    Real Xout_max[Medium.nXi]=
        AixLib.Utilities.Psychrometrics.Functions.X_pSatpphi(
        pSat=AixLib.Media.Air.saturationPressure(t_ao),
        p=port_a.p,
        phi=1)*s "maximum relative humidity at outlet (rh=1)";
    Real rh=Utilities.Psychrometrics.Functions.phi_pTX(
        port_a.p,
        t_ai,
        inStream(port_a.Xi_outflow[1])) "relative humidity of inlet air";

    //water mass flows
    SI.MassFlowRate w_in  "actual water mass flow at air inlet";
    //SI.MassFlowRate w_outmax  "maximum water mass flow at air outlet, negative";

    //salt mass flow
    SI.MassFlowRate ms_in = L_i * x_i;
    SI.MassFlowRate ms_out = L_o * x_o;

    //solution concentrations
    Real x_i(start=x_sol) "inlet concentration of desiccant solution";
    Real x_o(start=x_sol) "outlet concentration of desiccant solution";
    Real x = (x_i+x_o)/2 "average concentration of desiccant solution";

    //partial pressures
    SI.PartialPressure pw_s "average partial vapor pressure of desiccant solution";
    SI.PartialPressure pw_a "average partial vapor pressure of air flow";
    SI.PartialPressure pw_w "average partial vapor pressure of water";
    Real theta "average reduced temperature of desiccant solution T/ T_c,H20";
    Real pi "relative partial pressure of solution: pw_s / pw_a";
    //Integer PumpOn "1 if pump is on, 0 if not";

    Modelica.Blocks.Interfaces.RealInput x_in "Connector of Real input signal 1" annotation (
        Placement(transformation(extent={{-126,20},{-86,60}}), iconTransformation(extent={{-126,
              20},{-86,60}})));
    Modelica.Blocks.Interfaces.RealInput Ts_in "Connector of Real input signal 1" annotation (
        Placement(transformation(extent={{-126,60},{-86,100}}), iconTransformation(extent={{-126,
              60},{-86,100}})));
    Modelica.Blocks.Interfaces.RealOutput x_out "Connector of Real input signal 1" annotation (
       Placement(transformation(extent={{92,20},{132,60}}), iconTransformation(extent={{92,20},
              {112,40}})));
    Modelica.Blocks.Interfaces.RealOutput Ts_out "Connector of Real input signal 1"
      annotation (Placement(transformation(extent={{92,60},{132,100}}), iconTransformation(
            extent={{92,60},{112,80}})));
    Modelica.Blocks.Interfaces.RealOutput L_out "Connector of Real input signal 1" annotation (
       Placement(transformation(extent={{92,-90},{132,-50}}), iconTransformation(extent={{92,-80},
              {112,-60}})));
    Modelica.Blocks.Interfaces.RealInput L_i "Connector of Real input signal 1" annotation (
        Placement(transformation(extent={{-126,-80},{-86,-40}}), iconTransformation(extent={{-126,
              -70},{-86,-30}})));
    Modelica.Blocks.Interfaces.BooleanInput Pump(start=false) "Connector of Real input signal 1"
      annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={0,-110}), iconTransformation(
          extent={{20,-20},{-20,20}},
          rotation=270,
          origin={0,-100})));
    Modelica.Blocks.Interfaces.RealInput Y06 "Connector of Real input signal 1"
      annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={-50,-106}), iconTransformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={-56,-88})));
  initial equation
    // Assert that the substance with name 'water' has been found.
    assert(Medium.nXi == 0 or abs(sum(s) - 1) < 1e-5,
    "If Medium.nXi > 1, then substance 'water' must be present for one component.'"
       + Medium.mediumName + "'.\n" + "Check medium model.");

  equation

    if Pump then
      //PumpOn = 1;
      //Mass balance Air:
      G_o = G_i - m;
      //mass balance solution:
      L_o = L_i + m;
      //Mass balance Water:
      G_o * port_b.Xi_outflow = G_i * inStream(port_a.Xi_outflow) - m1Xi_flow;
      //mass transfer equation
      m_star = (1-Y06)*beta*a_t*V*(pw_a - pw_s);
      //equation for m considering physical boundaries:
      //m = m_star;
      m = min( m_star, w_in);
      //m = min( min(m_star, w_in),max(m_star, w_outmax));
      //concentration of desiccant solution
      L_i * x_i = L_o * x_o;
      //1/x_o = 1/x_i*(1 + m*L_flowInv);
      //1/x_o = 1/x_i *(1+m/L_i);

    else
      //PumpOn = 0;
      G_o = G_i;
      L_o = L_i;
      port_b.Xi_outflow = inStream(port_a.Xi_outflow);
      m_star = 0;
      m=0;
      x_o = x_i;

    end if;

    //water mass flow equations:
    w_in = X1_in[1] * G_i;
    //w_outmax = - Xout_max[1] * G_i  "not completely exact, should be outlet mass flow (G_o), use dry air alternatively";


    m_flowInv = AixLib.Utilities.Math.Functions.inverseXRegularized(
      x=port_a.m_flow,
      delta=deltaReg,
      deltaInv=deltaInvReg,
      a=aReg,
      b=bReg,
      c=cReg,
      d=dReg,
      e=eReg,
      f=fReg);

    //L_flowInv = AixLib.Utilities.Math.Functions.inverseXRegularized(x=L_i,delta=deltaReg,deltaInv=deltaInvReg, a=aReg,b=bReg,c=cReg,d=dReg,e=eReg,f=fReg);

    //pressure loss
    dp = dp_abs;

    //Mass balance Air:
    port_b.m_flow = - G_o  "Vorsicht: negatives Vorzeichen!";

    //mass balance solution:
    L_out = L_o;

    //Mass balance Water:
    port_a.Xi_outflow = inStream(port_b.Xi_outflow);

    //Energy balance:
    port_a.h_outflow = inStream(port_b.h_outflow);
    port_b.h_outflow = h_ao;

    h_ai = (1-X_i)*c_pa_in*(t_ai - t_ref) + X_i*(c_pw*(t_ai - t_ref) + lambda);
    h_ao = (1-X_o)*c_pa_out*(t_ao - t_ref) + X_o*(c_pw*(t_ao - t_ref) + lambda);
    h_si = c_ps_in*(t_si - t_ref);
    h_so = c_ps_out*(t_so - t_ref);

    L_i*h_si = L_o*h_so - Q;
    G_i*h_ai = G_o*h_ao + Q;

    //temperatures
    t_si = Ts_in;
    Ts_out = t_so;
    //t_so - t_ao  =  0  "Annahme: Ausgang der Sole hat die selbe Temperatur wie die Luft";
    t_so - t_ao = (1 - eps)*(t_si - t_ai) "Abweichung von t_ao=t_so in der Wärmeübertragung";

    //vapor pressure
    theta = t_s/T_cH2O "reduced temperature T/T_c,H20";

    pw_w = BaseClasses.Utilities.partialPressureWater(t_s);
    //welches T?
    pi = BaseClasses.Utilities.relativePartialPressureLiCl(theta, x_i);
    // ist x_i die mass fraction of solute?
    pw_s = pi*pw_w;

    pw_a = Utilities.Psychrometrics.Functions.pW_X((inStream(port_a.Xi_outflow[1])+port_b.Xi_outflow[1])/2);

    // Species flow rate from m
    m1Xi_flow = m*s;

    //concentration of desiccant solution
    x_i = x_in;
    x_out = x_o;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Rectangle(extent={{
                -100,100},{100,-100}}, lineColor={28,108,200}), Text(
            extent={{-80,80},{80,-80}},
            lineColor={28,108,200},
            textString="Absorber")}), Diagram(coordinateSystem(preserveAspectRatio=false)));
  end Absorber;

  model solutionTank "storage tank for desiccant solution"

    import SI = Modelica.SIunits;

  protected
    parameter SI.Temperature t_ref=273.15 "reference temperature";

  public
    parameter SI.Temperature t_sol=26 + 273.15 "starting temperature of absorber storage tank";
    parameter Real x_sol=0.4 "starting concentration of desiccant solution in absorber tank";
    parameter SI.Mass m_salt = 200 "starting salt mass of tank";
    parameter SI.VolumeFlowRate L_V =  15.2/3600 "Volume flow of desiccant solution in m^3/s";

    SI.Mass m(min=100, max=1000, nominal = m_salt/x_sol) "mass of desiccant solution in absorber tank";
    SI.Mass m_s( min=100, max=1000, start=m_salt) "mass of salt in absorber tank";
    SI.Mass m_w( min=100, max=1000) "mass of water in absorber tank";
    SI.Temperature t(start=t_sol) "temperature of absorber solution tank";
    Real x(min = 0.25, max = 0.45, start=x_sol) "concentration of desiccant solution in absorber tank";

    SI.SpecificHeatCapacity cp_in=BaseClasses.Utilities.specificHeatCapacityCpLiCl(T_in, x_in)
      "specific heat capacity of desiccant solution at inlet in J/kgK";
    SI.SpecificHeatCapacity cp_out=BaseClasses.Utilities.specificHeatCapacityCpLiCl(T_out, x_out)
      "specific heat capacity of desiccant solution at inlet in J/kgK";
    SI.SpecificHeatCapacity cp_reg=BaseClasses.Utilities.specificHeatCapacityCpLiCl(T_reg, x_reg)
      "specific heat capacity of desiccant solution at inlet in J/kgK";

    SI.Density rho = BaseClasses.Utilities.densityLiCl(t, x) "in kg/m^3, density of LiCl solution";
    SI.MassFlowRate L_o = L_V*rho "mass flow rate of desiccant solution in kg/s";

    Modelica.Blocks.Interfaces.RealInput T_in "Connector of Real input signal 1"
      annotation (Placement(transformation(extent={{-126,60},{-86,100}})));
    Modelica.Blocks.Interfaces.RealInput x_in "Connector of Real input signal 1"
      annotation (Placement(transformation(extent={{-126,30},{-86,70}})));
    Modelica.Blocks.Interfaces.RealOutput T_out
                                               "Connector of Real input signal 1"
      annotation (Placement(transformation(extent={{90,50},{130,90}}), iconTransformation(extent={{94,50},
              {114,70}})));
    Modelica.Blocks.Interfaces.RealOutput x_out
      "Connector of Real input signal 1"
      annotation (Placement(transformation(extent={{90,10},{130,50}}),   iconTransformation(extent={{94,-10},
              {114,10}})));
    Modelica.Blocks.Interfaces.RealInput L "Connector of Real input signal 1"
      annotation (Placement(transformation(extent={{-126,0},{-86,40}})));

    Modelica.Blocks.Interfaces.RealInput m_reg "Connector of Real input signal 1"
      annotation (Placement(transformation(extent={{-126,-100},{-86,-60}})));
    Modelica.Blocks.Interfaces.RealOutput L_out
      "Connector of Real input signal 1" annotation (Placement(transformation(
            extent={{94,-72},{134,-32}}), iconTransformation(extent={{94,-70},{114,
              -50}})));
    Modelica.Blocks.Interfaces.RealInput T_reg "Connector of Real input signal 1"
      annotation (Placement(transformation(extent={{-126,-40},{-86,0}})));
    Modelica.Blocks.Interfaces.RealInput x_reg "Connector of Real input signal 1"
      annotation (Placement(transformation(extent={{-126,-70},{-86,-30}})));
    Modelica.Blocks.Interfaces.BooleanInput Pump "Connector of Real input signal 1" annotation (
        Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={-70,110}), iconTransformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={0,100})));
    Modelica.Blocks.Interfaces.RealOutput m_storage
      "Connector of Real input signal 1" annotation (Placement(transformation(
            extent={{94,-110},{134,-70}}), iconTransformation(extent={{94,-100},{114,
              -80}})));
  equation
    if Pump then
    L_out = L_o;
    else
    L_out = 0;
    end if;

    der(m) = L - L_out + m_reg;
    x_out = x;
    T_out = t;

    der(m_s)  =  x_reg * m_reg + L * x_in - L_out * x_out;
    m_w  =  m - m_s;
    m_s  =  m * x;
    //m*der(x) = L*(x_in - x) + m_reg*(x_reg - x) - L_out*(x_out - x);

    //m*cp_out*der(t)  =  L * cp_in * (T_in - t_ref) - L_out * cp_out * (T_out - t_ref) + m_reg * cp_reg * (T_reg-t_ref);

    m * cp_out * der(t) = L * (cp_in * (T_in - t_ref) - cp_out * (t - t_ref))
      + m_reg * (cp_reg * (T_reg - t_ref) - cp_out * (t - t_ref))
      - L_out * cp_out * (T_out - t);
    m_storage = m;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end solutionTank;

  model sorptionExchange
    "model for exchange of mass between absorber and desorber"

    import SI = Modelica.SIunits;

    parameter Real eps = 0.8  "epsilon for heat exchange at hot (and cold) heat exchanger";
    parameter SI.MassFlowRate mAbs_max = 2  "0.6944, maximum mass flow rate through Y15 in kg/s";
    parameter SI.MassFlowRate mReg_max = 2  "0.6944, maximum mass flow rate through Y16 in kg/s";
    parameter SI.MassFlowRate mWat_max = 2.4716 "maximum water mass flow rate in regeneration coil in kg/s";
    parameter SI.Temperature t_sol =   299.15  "desiccant solution inlet temperature";
    parameter SI.Temperature t_ref =   273.15  "reference temperature";
    parameter SI.Temperature t_hot =   70+273.15  "temperature of hot water to regenerate brine";



    SI.SpecificHeatCapacity cpDes=BaseClasses.Utilities.specificHeatCapacityCpLiCl(TDes_in, xDes)
      "specific heat capacity of desiccant solution at inlet in J/kgK";
    SI.SpecificHeatCapacity cpAbs=BaseClasses.Utilities.specificHeatCapacityCpLiCl(TAbs_in, xAbs)
      "specific heat capacity of desiccant solution at inlet in J/kgK";
    SI.SpecificHeatCapacity cpSol=BaseClasses.Utilities.specificHeatCapacityCpLiCl(t_sol, xAbs)
      "specific heat capacity of desiccant solution at inlet in J/kgK";
    //SI.SpecificHeatCapacity cpWat=Modelica.Media.Water.WaterIF97_pT.specificHeatCapacityCp(Modelica.Media.Water.WaterIF97_pT.setState_pTX(101325, TWat));
    //Media.Water.specificHeatCapacityCp(Modelica.Media.Water.WaterIF97_pT.setState_pTX(101325, TWat)) "specific heat capacity of hot water in J/kgK";
    //Modelica.Media.Water.StandardWaterOnePhase.specificHeatCapacityCp(Modelica.Media.Water.StandardWaterOnePhase.setState_pTX(      121325,      TWat,      phase=1)) "specific heat capacity of hot water in J/kgK";
    SI.SpecificHeatCapacity cpWat=4187  "specific heat capacity at 70°C in J/kgK";
    SI.HeatFlowRate QAbs(start=0) "cooling of the brine before absorber";
    SI.HeatFlowRate QReg "heating of the brine before desorber";
    SI.HeatFlowRate QMix "heat exchange between abs and des brine";
    SI.HeatFlowRate QMax "maximum heat exchange between absorption and desorption brine";

    SI.HeatFlowRate QMax_reg "maximum heat flow from regeneration coil";
    Real CAbs "heat capacity flow of absorption flow inlet in kW/°C";
    Real CDes "heat capacity flow of desorption flow inlet in kW/°C";
    Real CReg "heat capacity flow of regenerated flow inlet in kW/°C";
    Real CMin "minimum heat capacity flow in kW/°C";

    Real CMin_reg "minimum heat capacity flow at regeneration coil in kW/°C";
    Real CWat "heat capacity flow of hot water in kW/°C";

    SI.MassFlowRate mWat(start=0)
                        " water mass flow rate in regeneration coil in kg/s";
    SI.MassFlowRate mHot
                        "(start=0) hot water mass flow rate in regeneration coil in kg/s";
    SI.MassFlowRate mMix(start=0)
                        " mixing water mass flow rate in regeneration coil in kg/s";

    SI.Temperature TWat(start=343.15) "temperature of mixed water in regeneration coil";
    SI.Temperature TWat_out "temperature of outlet water in regeneration coil";

    Boolean ABS "Boolean variable, only absorption is active";
    Boolean DES "Boolean variable, only regeneration is active";
    Boolean ABSDES "Boolean, absorption and desorption active";
    Boolean NONE "sorption is shut off";

    Modelica.Blocks.Interfaces.RealInput TAbs_in
      "Connector of Real input signal 1" annotation (Placement(transformation(
            extent={{-220,120},{-180,160}}),
                                           iconTransformation(extent={{-220,120},{-180,160}})));
    Modelica.Blocks.Interfaces.RealInput xAbs_in
      "Connector of Real input signal 1" annotation (Placement(transformation(
            extent={{-220,60},{-180,100}}),
                                          iconTransformation(extent={{-220,60},{-180,100}})));
    Modelica.Blocks.Interfaces.RealInput LAbs_in
      "Connector of Real input signal 1" annotation (Placement(transformation(
            extent={{-220,0},{-180,40}}),  iconTransformation(extent={{-220,0},{-180,40}})));
    Modelica.Blocks.Interfaces.RealInput Y15(min=0, max=1)
      "Connector of Real input signal 1" annotation (Placement(transformation(
            extent={{-220,-60},{-180,-20}}),iconTransformation(extent={{-220,-60},{-180,-20}})));
    Modelica.Blocks.Interfaces.RealInput TDes_in "Connector of Real input signal 1"
                                         annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={-90,208}), iconTransformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={-60,200})));
    Modelica.Blocks.Interfaces.RealInput xDes_in
      "Connector of Real input signal 1" annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={-50,208}), iconTransformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={0,200})));
    Modelica.Blocks.Interfaces.RealInput Y16(min=0, max=1)
      "Connector of Real input signal 1" annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={90,208}), iconTransformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={120,200})));
    Modelica.Blocks.Interfaces.RealInput LDes_in
      "Connector of Real input signal 1" annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={-10,208}),
                           iconTransformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={60,200})));
    Modelica.Blocks.Interfaces.RealOutput TAbs_reg
      "Connector of Real input signal 1" annotation (Placement(transformation(
            extent={{210,110},{250,150}}),
                                         iconTransformation(extent={{214,120},{234,140}})));
    Modelica.Blocks.Interfaces.RealOutput mAbs_reg(min=0)
      "Connector of Real input signal 1" annotation (Placement(transformation(
            extent={{194,60},{234,100}}),
                                        iconTransformation(extent={{214,80},{234,100}})));
    Modelica.Blocks.Interfaces.RealOutput TAbs "Connector of Real input signal 1"
      annotation (Placement(transformation(extent={{212,-50},{252,-10}}),
          iconTransformation(extent={{212,-60},{232,-40}})));
    Modelica.Blocks.Interfaces.RealOutput xAbs "Connector of Real input signal 1"
      annotation (Placement(transformation(extent={{212,-150},{252,-110}}),
          iconTransformation(extent={{212,-160},{232,-140}})));
    Modelica.Blocks.Interfaces.RealOutput LAbs(min=0)
      "Connector of Real input signal 1" annotation (Placement(transformation(
            extent={{212,-90},{252,-50}}),iconTransformation(extent={{212,-110},{232,-90}})));
    Modelica.Blocks.Interfaces.RealOutput TDes "Connector of Real input signal 1"
      annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={-130,-214}),iconTransformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-170,-202})));
    Modelica.Blocks.Interfaces.RealOutput xDes "Connector of Real input signal 1"
      annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={0,-212}),   iconTransformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-48,-204})));
    Modelica.Blocks.Interfaces.RealOutput LDes(min=0)
      "Connector of Real input signal 1" annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={-80,-212}), iconTransformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-110,-204})));
    Modelica.Blocks.Interfaces.RealOutput TReg "Connector of Real input signal 1"
      annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={70,-212}), iconTransformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={30,-202})));
    Modelica.Blocks.Interfaces.RealOutput mReg(min=0)
      "Connector of Real input signal 1" annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={130,-212}),iconTransformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={92,-202})));
    Modelica.Blocks.Interfaces.BooleanInput P05 "Connector of Real input signal 1" annotation (
        Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={-180,208}),
                            iconTransformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={-180,200})));
    Modelica.Blocks.Interfaces.RealInput Y10 "Connector of Real input signal 1" annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={-140,208}),
                          iconTransformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={-120,200})));
    Modelica.Blocks.Interfaces.BooleanInput P07 "Connector of Real input signal 1" annotation (
        Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=0,
          origin={-200,-120}),
                             iconTransformation(
          extent={{-20,-20},{20,20}},
          rotation=0,
          origin={-200,-140})));
    Modelica.Blocks.Interfaces.BooleanInput P08 "Connector of Real input signal 1" annotation (
        Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={170,208}),   iconTransformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={180,200})));

  equation

    //modi

    if (P07 and P08) then
      ABSDES = true;
      ABS = false;
      DES = false;
      NONE = false;
    elseif (P07 and not P08) then
      ABS = true;
      ABSDES = false;
      DES = false;
      NONE = false;
    elseif (not P07 and P08) then
      DES = true;
      ABS = false;
      ABSDES = false;
      NONE = false;
    else
      NONE = true;
      ABSDES = false;
      ABS = false;
      DES = false;
    end if;


    //mass balance
    LAbs_in  =  LAbs + mAbs_reg  "setting LAbs";
    LDes_in  =  LDes + mReg  "setting LDes";

    //concentrations
    xAbs = xAbs_in  "setting xAbs";
    xDes = xDes_in  "setting xDes";

    if ABSDES then  //absorbation and desorbation active

    assert(P05, "Regeneration Pump must be active", AssertionLevel.warning);

    mAbs_reg  =  mAbs_max*Y15  "setting mAbs_reg";
    mReg  =  mReg_max*Y16  "setting mReg";

    //cooling of absorbtion brine
    0  =  LAbs*(cpAbs*(TAbs_in - t_ref) - cpSol*(t_sol - t_ref)) - QAbs  "setting QAbs";
    0  =  LAbs*(cpAbs*(TAbs_in - t_ref) - cpSol*(TAbs - t_ref)) - QAbs  "setting TAbs";

    //heating of regeneration brine
    mWat  =  mWat_max  "setting mWat";
    mWat  =  mHot + mMix  "setting mMix";
    mHot  =  Y10 * mWat  "setting mHot";
    CWat  =  mWat * cpWat  "setting CWat";
    CDes  =  LDes * cpDes  "setting CDes";
    CMin_reg  =  min(CWat, CDes)  "setting CMin_reg";
    QMax_reg  =  CMin_reg * (TWat - TDes_in)  "setting QMax_reg";
    QReg  =  eps * QMax_reg  "setting QReg";

    CWat * (TWat-TWat_out) = QReg  "setting TWat_out";
    CDes * (TDes_in-TDes) = -QReg  "setting TDes";

    //mixing balance in regeneration coil threewayvalve
    mWat*TWat  =  mHot*t_hot + mMix * TWat_out  "setting TWat";

    //heat exchange between absorption and desorption brine
    QMax  =  CMin * (TDes_in - TAbs_in)  "setting QMax";
    QMix  =  eps * QMax  "setting QMix";

    CAbs  =  mAbs_reg  *  cpAbs  "setting CAbs";
    CReg  =  mReg  *  cpDes  "setting CReg";
    CMin  =  min(CAbs,CReg)  "setting CMin";
    CAbs * (TAbs_in-TAbs_reg)  =  -QMix  "setting TAbs_reg";
    CReg * (TDes_in-TReg)  =  QMix  "setting TReg";

    elseif ABS then //only absorbation, no heat exchange between desorption and absorption

    assert(not P05, "Regeneration Pump must be switched off", AssertionLevel.warning);

    mAbs_reg  =  mAbs_max*Y15  "setting mAbs_reg";
    mReg  =  0   "mReg_max*Y16  setting mReg";

    mWat  =  0  "setting mWat";
    mMix  =  0  "setting mMix";
    mHot  =  0  "setting mHot";

    //cooling of absorbtion brine
    0  =  LAbs*(cpAbs*(TAbs_in - t_ref) - cpSol*(t_sol - t_ref)) - QAbs  "setting QAbs";
    0  =  LAbs*(cpAbs*(TAbs_in - t_ref) - cpSol*(TAbs - t_ref)) - QAbs  "setting TAbs";

    //heating of regeneration brine
    CWat = 0;
    CDes  =  0  "setting CDes";
    CMin_reg = 0;
    QMax_reg = 0;
    QReg = 0;
    TDes = TDes_in;
    TWat_out = t_hot;
    TWat = t_hot;

    //heat exchange between absorption and desorption brine
    QMax  =  0  "setting QMax";
    QMix  =  0  "setting QMix";

    CAbs  =  mAbs_reg  *  cpAbs  "setting CAbs";
    CReg  =  0  "setting CReg";
    CMin  =  min(CAbs,CReg)  "setting CMin";
    TAbs_reg  =  TAbs_in  "setting TAbs_reg";
    TReg  =  TDes_in  "setting TReg";

    elseif DES then  //only desorption active

    assert(P05, "Regeneration Pump must be active", AssertionLevel.warning);

    mAbs_reg  =  0  "mAbs_max*Y15  setting mAbs_reg";
    mReg  =  mReg_max*Y16  "setting mReg";

    mWat  =  mHot + mMix  "setting mMix";
    mHot  =  Y10 * mWat  "setting mHot";

    //cooling of absorbtion brine
    QAbs  =  0  "setting QAbs";
    TAbs  =  TAbs_in  "setting TAbs";

    //heating of regeneration brine
    mWat  =  mWat_max  "setting mWat";
    CWat  =  mWat * cpWat  "setting CWat";
    CDes  =  LDes  *  cpDes  "setting CDes";
    CMin_reg  =  min(CWat, CDes)  "setting CMin_reg";
    QMax_reg  =  CMin_reg * (TWat - TDes_in)  "setting QMax_reg";
    QReg  =  eps * QMax_reg  "setting QReg";

    CWat * (TWat-TWat_out) = QReg  "setting TWat_out";
    CDes * (TDes_in-TDes) = -QReg  "setting TDes";

    //mixing balance in regeneration coil threewayvalve
    mWat*TWat  =  mHot*t_hot + mMix * TWat_out  "setting TWat";

    //heat exchange between absorption and desorption brine
    QMax  =  0  "setting QMax";
    QMix  =  0  "setting QMix";
    CAbs  =  0  "setting CAbs";
    CReg  =  mReg  *  cpDes  "setting CReg";
    CMin  =  min(CAbs,CReg)  "setting CMin";
    TAbs_reg  =  TAbs_in  "setting TAbs_reg";
    TReg  =  TDes_in  "setting TReg";

    elseif NONE then

        assert(not P05, "Regeneration Pump must be switched off", AssertionLevel.warning);

    mAbs_reg  =  0  "mAbs_max*Y15  setting mAbs_reg";
    mReg  =  0    "mReg_max*Y16  setting mReg";

    mWat = 0;
    mMix  =  0  "setting mMix";
    mHot  =  0  "setting mHot";

    //cooling of absorbtion brine
    QAbs  =  0  "setting QAbs";
    TAbs  =  TAbs_in  "setting TAbs";

    //heating of regeneration brine
    CWat = 0;
    CDes =  0;
    CMin_reg = 0;
    QMax_reg = 0;
    QReg = 0;
    TDes = TDes_in;
    TWat_out = t_hot;
    TWat = t_hot;


    //heat exchange between absorption and desorption brine
    QMax  =  0  "setting QMax";
    QMix  =  0  "setting QMix";

    CAbs  =  0  "setting CAbs";
    CReg  =  0  "setting CReg";
    CMin  =  min(CAbs,CReg)  "setting CMin";
    TAbs_reg  =  TAbs_in  "setting TAbs_reg";
    TReg  =  TDes_in  "setting TReg";

    else
      assert(ABSDES or ABS or DES or NONE, "no absorption mode active", AssertionLevel.error);

    mAbs_reg  = 0   "  mAbs_max*Y15  setting mAbs_reg";
    mReg  =  0    "mReg_max*Y16  setting mReg";

    mWat = 0;
    mMix  =  0  "setting mMix";
    mHot  =  0  "setting mHot";

    //cooling of absorbtion brine
    QAbs  =  0  "setting QAbs";
    TAbs  =  TAbs_in  "setting TAbs";

    //heating of regeneration brine
    CWat = 0;
    CDes = 0;
    CMin_reg = 0;
    QMax_reg = 0;
    QReg = 0;
    TDes = TDes_in;
    TWat_out = t_hot;
    TWat = t_hot;


    //heat exchange between absorption and desorption brine
    QMax  =  0  "setting QMax";
    QMix  =  0  "setting QMix";

    CAbs  =  0  "setting CAbs";
    CReg  =  0  "setting CReg";
    CMin  =  min(CAbs,CReg)  "setting CMin";
    TAbs_reg  =  TAbs_in  "setting TAbs_reg";
    TReg  =  TDes_in  "setting TReg";

    end if;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-200},{220,200}})),
                                                                   Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-200,-200},{220,200}})));
  end sorptionExchange;

  model sorptionPartialPressure "physical model of the sorption process"
    import AixLib;

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

    parameter Modelica.SIunits.Temperature T_init = 293.15 "initialisation temperature";
    parameter Real x_init = 0.4 "initialization concentration";

    Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium = Medium2)
      annotation (Placement(transformation(extent={{70,-240},{50,-220}})));
    Modelica.Blocks.Interfaces.RealInput Y06_opening "valve Input for Y06 opening"
                                    annotation (Placement(transformation(
          extent={{20,-20},{-20,20}},
          rotation=90,
          origin={-150,428}), iconTransformation(
          extent={{18,-18},{-18,18}},
          rotation=90,
          origin={-180,428})));
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
      annotation (Placement(transformation(extent={{194,-10},{222,18}})));
    Modelica.Blocks.Interfaces.RealOutput Y06_actual
      "actual value of valve opening Y06"
      annotation (Placement(transformation(extent={{194,-54},{222,-26}})));
    AixLib.Airflow.AirHandlingUnit.ComponentsAHU.Desorber desorber(
      redeclare package Medium = Medium1,
      x_sol=x_init,
      m_flow_nominal=1)
                    annotation (Placement(transformation(extent={{10,270},{-10,290}})));
    solutionTank               desorberTank(
      t_sol=64 + 273.15,
      x_sol=x_init)
                 annotation (Placement(transformation(extent={{-40,218},{-60,238}})));
    AixLib.Airflow.AirHandlingUnit.ComponentsAHU.Absorber absorber(m_flow_nominal=5,
        redeclare package Medium = Medium2,
      x_sol=x_init,
      allowFlowReversal=false)
      annotation (Placement(transformation(extent={{12,-240},{-8,-220}})));
    solutionTank               absorberTank(
      x_sol=x_init)
      annotation (Placement(transformation(extent={{-22,-190},{-42,-170}})));
    AixLib.Airflow.AirHandlingUnit.ComponentsAHU.sorptionExchange
                                   sorptionExchange
      annotation (Placement(transformation(extent={{-90,-14},{-64,12}})));
    Modelica.Blocks.Interfaces.RealInput Y10_opening "valve Input for Y10 opening" annotation (
       Placement(transformation(
          extent={{18,-18},{-18,18}},
          rotation=90,
          origin={-110,428}), iconTransformation(
          extent={{18,-18},{-18,18}},
          rotation=90,
          origin={-128,428})));
    Modelica.Blocks.Interfaces.RealInput Y15_opening "valve Input for Y15 opening" annotation (
       Placement(transformation(
          extent={{18,-18},{-18,18}},
          rotation=90,
          origin={-76,428}), iconTransformation(
          extent={{18,-18},{-18,18}},
          rotation=90,
          origin={-76,428})));
    Modelica.Blocks.Interfaces.RealInput Y16_opening "valve Input for Y16 opening" annotation (
       Placement(transformation(
          extent={{19,-19},{-19,19}},
          rotation=90,
          origin={-17,431}), iconTransformation(
          extent={{18,-18},{-18,18}},
          rotation=90,
          origin={-20,428})));
    Modelica.Blocks.Interfaces.BooleanInput P05 "Connector of Real input signal 1" annotation (
        Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={30,428}), iconTransformation(
          extent={{-18,-18},{18,18}},
          rotation=270,
          origin={40,428})));
    Modelica.Blocks.Interfaces.BooleanInput P07 "Connector of Real input signal 1" annotation (
        Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={90,428}),  iconTransformation(
          extent={{-18,-18},{18,18}},
          rotation=270,
          origin={110,428})));
    Modelica.Blocks.Interfaces.BooleanInput P08 "Connector of Real input signal 1" annotation (
        Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={150,428}),   iconTransformation(
          extent={{-18,-18},{18,18}},
          rotation=270,
          origin={180,428})));
    Modelica.Blocks.Interfaces.RealOutput massAbsorberTank
      "sensor signal of mass in the absorber tank"
      annotation (Placement(transformation(extent={{194,36},{222,64}})));
    Modelica.Blocks.Interfaces.RealOutput massDesorberTank
      "sensor signal of mass in the desorber tank"
      annotation (Placement(transformation(extent={{194,78},{222,106}})));
    Modelica.Blocks.Interfaces.RealOutput xDes
      "sensor signal of concentration in the desorber tank"
      annotation (Placement(transformation(extent={{194,178},{222,206}})));
    Modelica.Blocks.Interfaces.RealOutput TDes
      "sensor signal of temperature after regeneration heating"
      annotation (Placement(transformation(extent={{194,226},{222,254}})));
    Modelica.Blocks.Interfaces.RealOutput xAbs
      "sensor signal of concentration in the absorber tank"
      annotation (Placement(transformation(extent={{194,130},{222,158}})));
    AixLib.Fluid.Actuators.Valves.TwoWayEqualPercentage
                             Y06(
      dpValve_nominal=10,
      redeclare package Medium = Medium2,
      m_flow_nominal=5) "damper at entry to supply air stream"
               annotation (Placement(transformation(extent={{58,-270},{38,-290}})));
    AixLib.Fluid.Actuators.Valves.TwoWayEqualPercentage Y_help(
      dpValve_nominal=10,
      redeclare package Medium = Medium2,
      m_flow_nominal=5) "virtual damper to realise pressure loss in absorber"
      annotation (Placement(transformation(extent={{118,-220},{98,-240}})));
    Modelica.Blocks.Math.Feedback feedback
      annotation (Placement(transformation(extent={{82,-266},{102,-246}})));
    Modelica.Blocks.Sources.RealExpression valveMax(y=1)
      annotation (Placement(transformation(extent={{38,-266},{58,-246}})));
  equation
    connect(senMasFlo.m_flow, senMasFloAbs)
      annotation (Line(points={{60,-219},{60,-196},{160,-196},{160,4},{208,4}},
                                                          color={0,0,127}));
    connect(port_a1, desorber.port_a)
      annotation (Line(points={{200,280},{10,280}}, color={0,127,255}));
    connect(desorber.port_b, port_b1)
      annotation (Line(points={{-10,280},{-200,280}}, color={0,127,255}));
    connect(senMasFlo.port_b, absorber.port_a)
      annotation (Line(points={{50,-230},{12,-230}}, color={0,127,255}));
    connect(absorber.Ts_out, absorberTank.T_in) annotation (Line(points={{-8.2,
            -223},{-12,-223},{-12,-172},{-21.4,-172}},
                                      color={0,0,127}));
    connect(absorber.x_out, absorberTank.x_in) annotation (Line(points={{-8.2,
            -227},{-14,-227},{-14,-175},{-21.4,-175}},
                                      color={0,0,127}));
    connect(absorber.L_out, absorberTank.L) annotation (Line(points={{-8.2,-237},
            {-16,-237},{-16,-178},{-21.4,-178}},
                                 color={0,0,127}));
    connect(absorberTank.T_out, sorptionExchange.TAbs_in) annotation (Line(points={{-42.4,-174},
            {-110,-174},{-110,8.1},{-90,8.1}}, color={0,0,127}));
    connect(absorberTank.x_out, sorptionExchange.xAbs_in) annotation (Line(points={{-42.4,-180},
            {-106,-180},{-106,4.2},{-90,4.2}}, color={0,0,127}));
    connect(absorberTank.L_out, sorptionExchange.LAbs_in) annotation (Line(points={{-42.4,-186},
            {-102,-186},{-102,0.3},{-90,0.3}}, color={0,0,127}));
    connect(sorptionExchange.TDes, TDes) annotation (Line(points={{-88.1429,
            -14.13},{-88.1429,-42},{36,-42},{36,240},{208,240}},
                                          color={0,0,127}));
    connect(desorberTank.x_out, xDes) annotation (Line(points={{-60.4,228},{-78,228},{-78,192},
            {208,192}}, color={0,0,127}));
    connect(absorberTank.m_storage, massAbsorberTank) annotation (Line(points={{-42.4,-189},{-50,
            -189},{-50,-196},{160,-196},{160,50},{208,50}}, color={0,0,127}));
    connect(desorberTank.m_storage, massDesorberTank) annotation (Line(points={{-60.4,219},{-69.2,
            219},{-69.2,92},{208,92}}, color={0,0,127}));
    connect(sorptionExchange.TAbs, absorber.Ts_in) annotation (Line(points={{
            -63.8762,-4.25},{24,-4.25},{24,-222},{12.6,-222}},
                                           color={0,0,127}));
    connect(sorptionExchange.LAbs, absorber.L_i) annotation (Line(points={{
            -63.8762,-7.5},{20,-7.5},{20,-235},{12.6,-235}},
                                    color={0,0,127}));
    connect(sorptionExchange.xAbs, absorber.x_in) annotation (Line(points={{
            -63.8762,-10.75},{16,-10.75},{16,-226},{12.6,-226}},
                                            color={0,0,127}));
    connect(sorptionExchange.TReg, absorberTank.T_reg) annotation (Line(points={{-75.7619,-14.13},
            {-75.7619,-156},{-6,-156},{-6,-182},{-21.4,-182}}, color={0,0,127}));
    connect(sorptionExchange.mReg, absorberTank.m_reg) annotation (Line(points={{-71.9238,-14.13},
            {-71.9238,-152},{-4,-152},{-4,-188},{-21.4,-188}}, color={0,0,127}));
    connect(sorptionExchange.xDes, absorberTank.x_reg) annotation (Line(points={{
            -80.5905,-14.26},{-80.5905,-160},{-8,-160},{-8,-185},{-21.4,-185}},
                                                               color={0,0,127}));
    connect(desorber.Ts_out, desorberTank.T_in) annotation (Line(points={{-10.2,287},{-30,287},
            {-30,236},{-39.4,236}}, color={0,0,127}));
    connect(desorber.x_out, desorberTank.x_in) annotation (Line(points={{-10.2,283},{-26,283},{
            -26,233},{-39.4,233}}, color={0,0,127}));
    connect(desorber.L_out, desorberTank.L) annotation (Line(points={{-10.2,273},{-22,273},{-22,
            230},{-39.4,230}}, color={0,0,127}));
    connect(desorberTank.T_out, sorptionExchange.TDes_in) annotation (Line(points={{-60.4,
            234},{-81.3333,234},{-81.3333,12}},
                                           color={0,0,127}));
    connect(desorberTank.x_out, sorptionExchange.xDes_in) annotation (Line(points={{-60.4,
            228},{-77.619,228},{-77.619,12}},
                                         color={0,0,127}));
    connect(desorberTank.L_out, sorptionExchange.LDes_in) annotation (Line(points={{-60.4,
            222},{-73.9048,222},{-73.9048,12},{-73.9048,12}},
                                                         color={0,0,127}));
    connect(sorptionExchange.TDes, desorber.Ts_in) annotation (Line(points={{
            -88.1429,-14.13},{-88.1429,-42},{36,-42},{36,288},{10.6,288}},
                                                         color={0,0,127}));
    connect(sorptionExchange.LDes, desorber.L_i) annotation (Line(points={{
            -84.4286,-14.26},{-84.4286,-38},{32,-38},{32,275},{10.6,275}},
                                                color={0,0,127}));
    connect(sorptionExchange.xDes, desorber.x_in) annotation (Line(points={{
            -80.5905,-14.26},{-80.5905,-40},{34,-40},{34,284},{10.6,284}},
                                                color={0,0,127}));
    connect(sorptionExchange.TAbs_reg, desorberTank.T_reg) annotation (Line(points={{
            -63.7524,7.45},{-6,7.45},{-6,226},{-39.4,226}},
                                             color={0,0,127}));
    connect(sorptionExchange.mAbs_reg, desorberTank.m_reg) annotation (Line(points={{
            -63.7524,4.85},{-14,4.85},{-14,220},{-39.4,220}},
                                               color={0,0,127}));
    connect(sorptionExchange.xAbs, desorberTank.x_reg) annotation (Line(points={{-63.8762,-10.75},
            {-10,-10.75},{-10,223},{-39.4,223}}, color={0,0,127}));
    connect(Y10_opening, sorptionExchange.Y10) annotation (Line(points={{-110,
            428},{-110,396},{-150,396},{-150,22},{-85.0476,22},{-85.0476,12}},
                                                              color={0,0,127}));
    connect(Y15_opening, sorptionExchange.Y15) annotation (Line(points={{-76,428},{-76,396},{-150,
            396},{-150,-3.6},{-90,-3.6}}, color={0,0,127}));
    connect(Y16_opening, sorptionExchange.Y16) annotation (Line(points={{-17,431},
            {-17,396},{-150,396},{-150,22},{-70.1905,22},{-70.1905,12}},
                                                         color={0,0,127}));
    connect(P05, sorptionExchange.P05) annotation (Line(points={{30,428},{30,396},{-150,396},{-150,
            22},{-88.7619,22},{-88.7619,12}}, color={255,0,255}));
    connect(P07, sorptionExchange.P07) annotation (Line(points={{90,428},{90,396},{-150,396},{-150,
            -10.1},{-90,-10.1}}, color={255,0,255}));
    connect(P08, sorptionExchange.P08) annotation (Line(points={{150,428},{150,396},{-150,396},
            {-150,22},{-66.4762,22},{-66.4762,18},{-66.4762,12}}, color={255,0,255}));
    connect(P08, desorberTank.Pump) annotation (Line(points={{150,428},{150,396},{-50,396},{-50,
            238}}, color={255,0,255}));
    connect(P08, desorber.Pump) annotation (Line(points={{150,428},{150,396},{-50,396},{-50,256},
            {0,256},{0,270}}, color={255,0,255}));
    connect(P07, absorberTank.Pump) annotation (Line(points={{90,428},{90,396},{-174,396},{-174,
            -166},{-32,-166},{-32,-170}}, color={255,0,255}));
    connect(P07, absorber.Pump) annotation (Line(points={{90,428},{90,396},{
            -174,396},{-174,-248},{2,-248},{2,-240}},
                                color={255,0,255}));
    connect(absorberTank.x_out, xAbs) annotation (Line(points={{-42.4,-180},{-50,-180},{-50,-196},
            {160,-196},{160,144},{208,144}}, color={0,0,127}));
    connect(absorber.port_b, port_b2) annotation (Line(points={{-8,-230},{-106,
            -230},{-106,-280},{-200,-280}}, color={0,127,255}));
    connect(Y06_opening, absorber.Y06) annotation (Line(points={{-150,428},{
            -150,-338},{8,-338},{8,-288},{7.6,-288},{7.6,-238.8}}, color={0,0,
            127}));
    connect(port_a2, Y06.port_a)
      annotation (Line(points={{200,-280},{58,-280}}, color={0,127,255}));
    connect(Y06.port_b, port_b2)
      annotation (Line(points={{38,-280},{-200,-280}}, color={0,127,255}));
    connect(Y06_opening, Y06.y) annotation (Line(points={{-150,428},{-150,-338},
            {48,-338},{48,-292}}, color={0,0,127}));
    connect(Y06.y_actual, Y06_actual) annotation (Line(points={{43,-287},{31,
            -287},{31,-338},{180,-338},{180,-40},{208,-40}}, color={0,0,127}));
    connect(port_a2, Y_help.port_a) annotation (Line(points={{200,-280},{160,
            -280},{160,-230},{118,-230}}, color={0,127,255}));
    connect(Y_help.port_b, senMasFlo.port_a)
      annotation (Line(points={{98,-230},{70,-230}}, color={0,127,255}));
    connect(valveMax.y, feedback.u1)
      annotation (Line(points={{59,-256},{84,-256}}, color={0,0,127}));
    connect(feedback.y, Y_help.y) annotation (Line(points={{101,-256},{108,-256},
            {108,-242}}, color={0,0,127}));
    connect(Y06_opening, feedback.u2) annotation (Line(points={{-150,428},{-150,
            -338},{92,-338},{92,-264}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-420},
              {200,420}}), graphics={Rectangle(
            extent={{-200,420},{200,-420}},
            lineColor={28,108,200},
            fillColor={28,108,200},
            fillPattern=FillPattern.HorizontalCylinder)}),         Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-200,-420},{200,420}}),
          graphics={
          Rectangle(
            extent={{-200,0},{200,-266}},
            lineColor={28,108,200},
            fillColor={170,255,213},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-200,334},{200,0}},
            lineColor={28,108,200},
            fillColor={170,213,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-200,-266},{200,-420}},
            lineColor={28,108,200},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-54,-358},{54,-400}},
            lineColor={0,0,0},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid,
            textString="Bypass"),
          Text(
            extent={{36,-86},{154,-156}},
            lineColor={0,0,0},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid,
            textString="Absorption"),
          Text(
            extent={{58,256},{176,186}},
            lineColor={0,0,0},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid,
            textString="Desorption")}));
  end sorptionPartialPressure;

  model sorptionNoValve
    "physical model of the sorption process without bypass valve"
    import AixLib;

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

    parameter Modelica.SIunits.Temperature T_init = 293.15 "initialisation temperature";
    parameter Real x_init = 0.4 "initialization concentration";

    Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium = Medium2)
      annotation (Placement(transformation(extent={{70,-240},{50,-220}})));
    Modelica.Blocks.Interfaces.RealInput Y06_opening "valve Input for Y06 opening"
                                    annotation (Placement(transformation(
          extent={{20,-20},{-20,20}},
          rotation=90,
          origin={-150,428}), iconTransformation(
          extent={{18,-18},{-18,18}},
          rotation=90,
          origin={-180,428})));
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
      annotation (Placement(transformation(extent={{194,-10},{222,18}})));
    Modelica.Blocks.Interfaces.RealOutput Y06_actual
      "actual value of valve opening Y06"
      annotation (Placement(transformation(extent={{194,-54},{222,-26}})));
    AixLib.Airflow.AirHandlingUnit.ComponentsAHU.Absorber desorber(
      m_flow_nominal=5,
      V=0.285075,
      eps=0.85,
      redeclare package Medium = Medium1,
      dp_abs=0,
      x_sol=x_init,
      beta=8.41355*10^(-8),
      t_sol=337.15) annotation (Placement(transformation(extent={{10,270},{-10,290}})));
    solutionTank               desorberTank(
      t_sol=64 + 273.15,
      m_start=100,
      x_sol=x_init)
                 annotation (Placement(transformation(extent={{-40,218},{-60,238}})));
    AixLib.Airflow.AirHandlingUnit.ComponentsAHU.Absorber absorber(m_flow_nominal=5,
        redeclare package Medium = Medium2,
      x_sol=x_init,
      dp_abs=0)
      annotation (Placement(transformation(extent={{12,-240},{-8,-220}})));
    solutionTank               absorberTank(
      m_start=900, x_sol=x_init)
      annotation (Placement(transformation(extent={{-22,-190},{-42,-170}})));
    AixLib.Airflow.AirHandlingUnit.ComponentsAHU.sorptionExchange
                                   sorptionExchange
      annotation (Placement(transformation(extent={{-90,-14},{-64,12}})));
    Modelica.Blocks.Interfaces.RealInput Y10_opening "valve Input for Y10 opening" annotation (
       Placement(transformation(
          extent={{18,-18},{-18,18}},
          rotation=90,
          origin={-110,428}), iconTransformation(
          extent={{18,-18},{-18,18}},
          rotation=90,
          origin={-128,428})));
    Modelica.Blocks.Interfaces.RealInput Y15_opening "valve Input for Y15 opening" annotation (
       Placement(transformation(
          extent={{18,-18},{-18,18}},
          rotation=90,
          origin={-76,428}), iconTransformation(
          extent={{18,-18},{-18,18}},
          rotation=90,
          origin={-76,428})));
    Modelica.Blocks.Interfaces.RealInput Y16_opening "valve Input for Y16 opening" annotation (
       Placement(transformation(
          extent={{19,-19},{-19,19}},
          rotation=90,
          origin={-17,431}), iconTransformation(
          extent={{18,-18},{-18,18}},
          rotation=90,
          origin={-20,428})));
    Modelica.Blocks.Interfaces.BooleanInput P05 "Connector of Real input signal 1" annotation (
        Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={30,428}), iconTransformation(
          extent={{-18,-18},{18,18}},
          rotation=270,
          origin={40,428})));
    Modelica.Blocks.Interfaces.BooleanInput P07 "Connector of Real input signal 1" annotation (
        Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={90,428}),  iconTransformation(
          extent={{-18,-18},{18,18}},
          rotation=270,
          origin={110,428})));
    Modelica.Blocks.Interfaces.BooleanInput P08 "Connector of Real input signal 1" annotation (
        Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={150,428}),   iconTransformation(
          extent={{-18,-18},{18,18}},
          rotation=270,
          origin={180,428})));
    Modelica.Blocks.Interfaces.RealOutput massAbsorberTank
      "sensor signal of mass in the absorber tank"
      annotation (Placement(transformation(extent={{194,36},{222,64}})));
    Modelica.Blocks.Interfaces.RealOutput massDesorberTank
      "sensor signal of mass in the desorber tank"
      annotation (Placement(transformation(extent={{194,78},{222,106}})));
    Modelica.Blocks.Interfaces.RealOutput xDes
      "sensor signal of concentration in the desorber tank"
      annotation (Placement(transformation(extent={{194,178},{222,206}})));
    Modelica.Blocks.Interfaces.RealOutput TDes
      "sensor signal of temperature after regeneration heating"
      annotation (Placement(transformation(extent={{194,226},{222,254}})));
    Modelica.Blocks.Interfaces.RealOutput xAbs
      "sensor signal of concentration in the absorber tank"
      annotation (Placement(transformation(extent={{194,130},{222,158}})));
    Modelica.Blocks.Sources.RealExpression no_bypass(y=0)
      "the desorber has no bypass valve, i.e. the bypass is closed" annotation (
       Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=270,
          origin={6,236})));
  equation
    connect(senMasFlo.m_flow, senMasFloAbs)
      annotation (Line(points={{60,-219},{60,-196},{160,-196},{160,4},{208,4}},
                                                          color={0,0,127}));
    connect(port_a1, desorber.port_a)
      annotation (Line(points={{200,280},{10,280}}, color={0,127,255}));
    connect(desorber.port_b, port_b1)
      annotation (Line(points={{-10,280},{-200,280}}, color={0,127,255}));
    connect(senMasFlo.port_b, absorber.port_a)
      annotation (Line(points={{50,-230},{12,-230}}, color={0,127,255}));
    connect(absorber.Ts_out, absorberTank.T_in) annotation (Line(points={{-8.2,
            -223},{-12,-223},{-12,-172},{-21.4,-172}},
                                      color={0,0,127}));
    connect(absorber.x_out, absorberTank.x_in) annotation (Line(points={{-8.2,
            -227},{-14,-227},{-14,-175},{-21.4,-175}},
                                      color={0,0,127}));
    connect(absorber.L_out, absorberTank.L) annotation (Line(points={{-8.2,-237},
            {-16,-237},{-16,-178},{-21.4,-178}},
                                 color={0,0,127}));
    connect(absorberTank.T_out, sorptionExchange.TAbs_in) annotation (Line(points={{-42.4,-174},
            {-110,-174},{-110,8.1},{-90,8.1}}, color={0,0,127}));
    connect(absorberTank.x_out, sorptionExchange.xAbs_in) annotation (Line(points={{-42.4,-180},
            {-106,-180},{-106,4.2},{-90,4.2}}, color={0,0,127}));
    connect(absorberTank.L_out, sorptionExchange.LAbs_in) annotation (Line(points={{-42.4,-186},
            {-102,-186},{-102,0.3},{-90,0.3}}, color={0,0,127}));
    connect(sorptionExchange.TDes, TDes) annotation (Line(points={{-88.1429,
            -14.13},{-88.1429,-42},{36,-42},{36,240},{208,240}},
                                          color={0,0,127}));
    connect(desorberTank.x_out, xDes) annotation (Line(points={{-60.4,228},{-78,228},{-78,192},
            {208,192}}, color={0,0,127}));
    connect(absorberTank.m_storage, massAbsorberTank) annotation (Line(points={{-42.4,-189},{-50,
            -189},{-50,-196},{160,-196},{160,50},{208,50}}, color={0,0,127}));
    connect(desorberTank.m_storage, massDesorberTank) annotation (Line(points={{-60.4,219},{-69.2,
            219},{-69.2,92},{208,92}}, color={0,0,127}));
    connect(sorptionExchange.TAbs, absorber.Ts_in) annotation (Line(points={{
            -63.8762,-4.25},{24,-4.25},{24,-222},{12.6,-222}},
                                           color={0,0,127}));
    connect(sorptionExchange.LAbs, absorber.L_i) annotation (Line(points={{
            -63.8762,-7.5},{20,-7.5},{20,-235},{12.6,-235}},
                                    color={0,0,127}));
    connect(sorptionExchange.xAbs, absorber.x_in) annotation (Line(points={{
            -63.8762,-10.75},{16,-10.75},{16,-226},{12.6,-226}},
                                            color={0,0,127}));
    connect(sorptionExchange.TReg, absorberTank.T_reg) annotation (Line(points={{-75.7619,-14.13},
            {-75.7619,-156},{-6,-156},{-6,-182},{-21.4,-182}}, color={0,0,127}));
    connect(sorptionExchange.mReg, absorberTank.m_reg) annotation (Line(points={{-71.9238,-14.13},
            {-71.9238,-152},{-4,-152},{-4,-188},{-21.4,-188}}, color={0,0,127}));
    connect(sorptionExchange.xDes, absorberTank.x_reg) annotation (Line(points={{
            -80.5905,-14.26},{-80.5905,-160},{-8,-160},{-8,-185},{-21.4,-185}},
                                                               color={0,0,127}));
    connect(desorber.Ts_out, desorberTank.T_in) annotation (Line(points={{-10.2,287},{-30,287},
            {-30,236},{-39.4,236}}, color={0,0,127}));
    connect(desorber.x_out, desorberTank.x_in) annotation (Line(points={{-10.2,283},{-26,283},{
            -26,233},{-39.4,233}}, color={0,0,127}));
    connect(desorber.L_out, desorberTank.L) annotation (Line(points={{-10.2,273},{-22,273},{-22,
            230},{-39.4,230}}, color={0,0,127}));
    connect(desorberTank.T_out, sorptionExchange.TDes_in) annotation (Line(points={{-60.4,
            234},{-81.3333,234},{-81.3333,12}},
                                           color={0,0,127}));
    connect(desorberTank.x_out, sorptionExchange.xDes_in) annotation (Line(points={{-60.4,
            228},{-77.619,228},{-77.619,12}},
                                         color={0,0,127}));
    connect(desorberTank.L_out, sorptionExchange.LDes_in) annotation (Line(points={{-60.4,
            222},{-73.9048,222},{-73.9048,12},{-73.9048,12}},
                                                         color={0,0,127}));
    connect(sorptionExchange.TDes, desorber.Ts_in) annotation (Line(points={{
            -88.1429,-14.13},{-88.1429,-42},{36,-42},{36,288},{10.6,288}},
                                                         color={0,0,127}));
    connect(sorptionExchange.LDes, desorber.L_i) annotation (Line(points={{
            -84.4286,-14.26},{-84.4286,-38},{32,-38},{32,275},{10.6,275}},
                                                color={0,0,127}));
    connect(sorptionExchange.xDes, desorber.x_in) annotation (Line(points={{
            -80.5905,-14.26},{-80.5905,-40},{34,-40},{34,284},{10.6,284}},
                                                color={0,0,127}));
    connect(sorptionExchange.TAbs_reg, desorberTank.T_reg) annotation (Line(points={{
            -63.7524,7.45},{-6,7.45},{-6,226},{-39.4,226}},
                                             color={0,0,127}));
    connect(sorptionExchange.mAbs_reg, desorberTank.m_reg) annotation (Line(points={{
            -63.7524,4.85},{-14,4.85},{-14,220},{-39.4,220}},
                                               color={0,0,127}));
    connect(sorptionExchange.xAbs, desorberTank.x_reg) annotation (Line(points={{-63.8762,-10.75},
            {-10,-10.75},{-10,223},{-39.4,223}}, color={0,0,127}));
    connect(Y10_opening, sorptionExchange.Y10) annotation (Line(points={{-110,
            428},{-110,396},{-150,396},{-150,22},{-85.0476,22},{-85.0476,12}},
                                                              color={0,0,127}));
    connect(Y15_opening, sorptionExchange.Y15) annotation (Line(points={{-76,428},{-76,396},{-150,
            396},{-150,-3.6},{-90,-3.6}}, color={0,0,127}));
    connect(Y16_opening, sorptionExchange.Y16) annotation (Line(points={{-17,431},
            {-17,396},{-150,396},{-150,22},{-70.1905,22},{-70.1905,12}},
                                                         color={0,0,127}));
    connect(P05, sorptionExchange.P05) annotation (Line(points={{30,428},{30,396},{-150,396},{-150,
            22},{-88.7619,22},{-88.7619,12}}, color={255,0,255}));
    connect(P07, sorptionExchange.P07) annotation (Line(points={{90,428},{90,396},{-150,396},{-150,
            -10.1},{-90,-10.1}}, color={255,0,255}));
    connect(P08, sorptionExchange.P08) annotation (Line(points={{150,428},{150,396},{-150,396},
            {-150,22},{-66.4762,22},{-66.4762,18},{-66.4762,12}}, color={255,0,255}));
    connect(P08, desorberTank.Pump) annotation (Line(points={{150,428},{150,396},{-50,396},{-50,
            238}}, color={255,0,255}));
    connect(P08, desorber.Pump) annotation (Line(points={{150,428},{150,396},{-50,396},{-50,256},
            {0,256},{0,270}}, color={255,0,255}));
    connect(P07, absorberTank.Pump) annotation (Line(points={{90,428},{90,396},{-174,396},{-174,
            -166},{-32,-166},{-32,-170}}, color={255,0,255}));
    connect(P07, absorber.Pump) annotation (Line(points={{90,428},{90,396},{
            -174,396},{-174,-248},{2,-248},{2,-240}},
                                color={255,0,255}));
    connect(absorberTank.x_out, xAbs) annotation (Line(points={{-42.4,-180},{-50,-180},{-50,-196},
            {160,-196},{160,144},{208,144}}, color={0,0,127}));
    connect(absorber.port_b, port_b2) annotation (Line(points={{-8,-230},{-106,
            -230},{-106,-280},{-200,-280}}, color={0,127,255}));
    connect(Y06_opening, absorber.Y06) annotation (Line(points={{-150,428},{
            -150,-338},{8,-338},{8,-288},{7.6,-288},{7.6,-238.8}}, color={0,0,
            127}));
    connect(no_bypass.y, desorber.Y06) annotation (Line(points={{6,247},{6,
            271.2},{5.6,271.2}}, color={0,0,127}));
    connect(port_a2, senMasFlo.port_a) annotation (Line(points={{200,-280},{136,
            -280},{136,-230},{70,-230}}, color={0,127,255}));
    connect(Y06_opening, Y06_actual) annotation (Line(points={{-150,428},{-150,
            428},{-150,-40},{208,-40},{208,-40}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-420},
              {200,420}}), graphics={Rectangle(
            extent={{-200,420},{200,-420}},
            lineColor={28,108,200},
            fillColor={28,108,200},
            fillPattern=FillPattern.HorizontalCylinder)}),         Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-200,-420},{200,420}}),
          graphics={
          Rectangle(
            extent={{-200,0},{200,-266}},
            lineColor={28,108,200},
            fillColor={170,255,213},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-200,334},{200,0}},
            lineColor={28,108,200},
            fillColor={170,213,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-200,-266},{200,-420}},
            lineColor={28,108,200},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-54,-358},{54,-400}},
            lineColor={0,0,0},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid,
            textString="Bypass"),
          Text(
            extent={{36,-86},{154,-156}},
            lineColor={0,0,0},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid,
            textString="Absorption"),
          Text(
            extent={{58,256},{176,186}},
            lineColor={0,0,0},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid,
            textString="Desorption")}));
  end sorptionNoValve;

  model Desorber
    "model of an absorber using partial vapor pressure of water"

    extends AixLib.Fluid.Interfaces.PartialTwoPortInterface;
    import SI = Modelica.SIunits;

    // Diagnostics
    parameter Boolean show_T=false "= true, if actual temperature at port is computed"
      annotation (Dialog(tab="Advanced", group="Diagnostics"));

    // Druckverluste
    parameter SI.Pressure dp_abs=0 "Druckverlust im Absorber nominal: 300 Pa";

  protected
    final parameter Real deltaReg=m_flow_small/1E3
      "Smoothing region for inverseXRegularized";
    final parameter Real deltaInvReg=1/deltaReg
      "Inverse value of delta for inverseXRegularized";
    final parameter Real aReg=-15*deltaInvReg
      "Polynomial coefficient for inverseXRegularized";
    final parameter Real bReg=119*deltaInvReg^2
      "Polynomial coefficient for inverseXRegularized";
    final parameter Real cReg=-361*deltaInvReg^3
      "Polynomial coefficient for inverseXRegularized";
    final parameter Real dReg=534*deltaInvReg^4
      "Polynomial coefficient for inverseXRegularized";
    final parameter Real eReg=-380*deltaInvReg^5
      "Polynomial coefficient for inverseXRegularized";
    final parameter Real fReg=104*deltaInvReg^6
      "Polynomial coefficient for inverseXRegularized";

    final parameter SI.Temperature T_cH2O=647.096
      "in K, temperature of water at critical point";

    final parameter Real s[Medium.nXi]={if Modelica.Utilities.Strings.isEqual(
        string1=Medium.substanceNames[i],
        string2="Water",
        caseSensitive=false) then 1 else 0 for i in 1:Medium.nXi}
      "Vector with zero everywhere except where species is";

    SI.MassFlowRate m1Xi_flow[Medium.nXi]
      "Mass flow rates of independent substances added to the medium";
    Real m_flowInv(unit="s/kg") "Regularization of 1/m_flow of port_a";
    //Real L_flowInv(unit="s/kg") "Regularization of 1/L_i";
    Real X1_in[Medium.nXi]=inStream(port_a.Xi_outflow)
      "absolute humidity of outside air at entry in kg/kg";
    parameter SI.Temperature t_ref=273.15 "reference temperature";

    //influence parameters:
  public
    parameter Real x_sol=0.33 "desiccant solution concentration at start";
    //parameter SI.Temperature t_sol =   26+273.15  "desiccant solution inlet temperature";
    parameter SI.Temperature t_sol=337.15 "desiccant solution inlet temperature";
    parameter Real a_t=320 "specific surface area of packing in m^2/m^3";
    parameter Real Z=0.35 "packed bed height in m";
    parameter Real V=0.285075 "in m^3, 1810*350*450 mm";
    parameter Real eps=0.85  "parameter for heat exchange in absorber / desorber unit";

    parameter Real beta=8.41355*10^(-8) "mass transfer coefficient with partial pressure as driving potential, 
  fitting parameter for mass transfer equation";
    //with inlet parameters: 6.0995*10^(-8)

    parameter SI.SpecificEnergy lambda=2430000 "latent heat of condensation in J/kg";
    //parameter SI.Area A_a = 1.9367 "1810*1070, Area air of absorber in m^2";
    //parameter SI.Area A_s = 0.8145 "1810*450, Area liquid of absorber in m^2";

    //thermodynamic states
    Media.Air.ThermodynamicState state_a=Media.Air.setState_phX(
        port_a.p,
        inStream(port_a.h_outflow),
        inStream(port_a.Xi_outflow)) "state for medium inflowing through port_a";

    Media.Air.ThermodynamicState state_b=Media.Air.setState_phX(
        port_b.p,
        port_b.h_outflow,
        port_b.Xi_outflow) "state for medium inflowing through port_b";

    //specific heat capacities
    SI.SpecificHeatCapacity c_pa_in=Media.Air.specificHeatCapacityCp(state_a)
      "specific heat capacity of airflow in J/kgK";
    SI.SpecificHeatCapacity c_pa_out=Media.Air.specificHeatCapacityCp(state_b)
      "in J/kgK, specific heat capacity of airflow at outlet";
    SI.SpecificHeatCapacity c_pw=Media.Water.specificHeatCapacityCp(state_a)
      "specific heat capacity of airflow in J/kgK";
    SI.SpecificHeatCapacity c_ps_in=BaseClasses.Utilities.specificHeatCapacityCpLiCl(t_si, x_i)
      "specific heat capacity of desiccant solution at inlet in J/kgK";
    SI.SpecificHeatCapacity c_ps_out=BaseClasses.Utilities.specificHeatCapacityCpLiCl(t_so, x_o)  "specific heat capacity of desiccant solution at inlet in J/kgK";

    //densities
    //SI.Density rho_a=Media.Air.density(state_a) "in kg/m^3, density of air";
    //SI.Density rho_s=BaseClasses.Utilities.densityLiCl(t_si, x_i) "in kg/m^3, density of LiCl solution";

    //mass flows
    SI.MassFlowRate L_o "outlet mass flow of desiccant solution in kg/s";
    //liegt hier eine andere Fläche vor als A?
    SI.MassFlowRate G_i=m_flow "original as mass flux, inlet mass flow of Air in kg/s";
    SI.MassFlowRate G_o "outlet mass flow of Air in kg/s";
    SI.MassFlowRate m
      "water vapor mass flow per area in kg/s going from air to desiccant flow";
    SI.MassFlowRate m_star
      "water vapor mass flow per area in kg/s going from air to desiccant flow without physical control of boundaries";

    //temperatures
    SI.Temperature t_ai=Media.Air.temperature(state_a) "temperature of air at inlet";
    SI.Temperature t_ao "temperature of air at outlet";
    SI.Temperature t_a = (t_ai+t_ao)/2 "average temperature of air ";
    SI.Temperature t_si(start=t_sol) "temperature of desiccant solution at inlet";
    SI.Temperature t_so  "(start=t_sol) temperature of desiccant solution at outlet";
    SI.Temperature t_s = (t_si + t_so)/2 "average temperature of brine";

    SI.HeatFlowRate Q "heat transfer between solution and air";

    //enthalpies
    SI.SpecificEnthalpy h_ai;
    SI.SpecificEnthalpy h_ao;
    SI.SpecificEnthalpy h_si;
    SI.SpecificEnthalpy h_so;

    //humidity
    Real X_iDry = inStream(port_a.Xi_outflow[1])/(1 - inStream(port_a.Xi_outflow[1]))
      "absolute humidity to dry air at inlet";
    Real X_oDry = port_b.Xi_outflow[1]/(1 - port_b.Xi_outflow[1])
      "absolute humidity to dry air at outlet";
    Real X_i = inStream(port_a.Xi_outflow[1])
      "absolute humidity to humid air at inlet";
    Real X_o = port_b.Xi_outflow[1]
      "absolute humidity to humid air at outlet";
    Real Xout_max[Medium.nXi]=
        AixLib.Utilities.Psychrometrics.Functions.X_pSatpphi(
        pSat=AixLib.Media.Air.saturationPressure(t_ao),
        p=port_a.p,
        phi=1)*s "maximum relative humidity at outlet (rh=1)";
    Real rh=Utilities.Psychrometrics.Functions.phi_pTX(
        port_a.p,
        t_ai,
        inStream(port_a.Xi_outflow[1])) "relative humidity of inlet air";

    //water mass flows
    //SI.MassFlowRate w_in  "actual water mass flow at air inlet";
    SI.MassFlowRate w_outmax  "maximum water mass flow at air outlet, negative";

    //salt mass flow
    SI.MassFlowRate ms_in = L_i * x_i;
    SI.MassFlowRate ms_out = L_o * x_o;

    //solution concentrations
    Real x_i(start=x_sol) "inlet concentration of desiccant solution";
    Real x_o(start=x_sol) "outlet concentration of desiccant solution";
    Real x = (x_i+x_o)/2 "average concentration of desiccant solution";

    //partial pressures
    SI.PartialPressure pw_s "average partial vapor pressure of desiccant solution";
    SI.PartialPressure pw_a "average partial vapor pressure of air flow";
    SI.PartialPressure pw_w "average partial vapor pressure of water";
    Real theta "average reduced temperature of desiccant solution T/ T_c,H20";
    Real pi "relative partial pressure of solution: pw_s / pw_a";
    //Integer PumpOn "1 if pump is on, 0 if not";

    Modelica.Blocks.Interfaces.RealInput x_in "Connector of Real input signal 1" annotation (
        Placement(transformation(extent={{-126,20},{-86,60}}), iconTransformation(extent={{-126,
              20},{-86,60}})));
    Modelica.Blocks.Interfaces.RealInput Ts_in "Connector of Real input signal 1" annotation (
        Placement(transformation(extent={{-126,60},{-86,100}}), iconTransformation(extent={{-126,
              60},{-86,100}})));
    Modelica.Blocks.Interfaces.RealOutput x_out "Connector of Real input signal 1" annotation (
       Placement(transformation(extent={{92,20},{132,60}}), iconTransformation(extent={{92,20},
              {112,40}})));
    Modelica.Blocks.Interfaces.RealOutput Ts_out "Connector of Real input signal 1"
      annotation (Placement(transformation(extent={{92,60},{132,100}}), iconTransformation(
            extent={{92,60},{112,80}})));
    Modelica.Blocks.Interfaces.RealOutput L_out "Connector of Real input signal 1" annotation (
       Placement(transformation(extent={{92,-90},{132,-50}}), iconTransformation(extent={{92,-80},
              {112,-60}})));
    Modelica.Blocks.Interfaces.RealInput L_i "Connector of Real input signal 1" annotation (
        Placement(transformation(extent={{-126,-80},{-86,-40}}), iconTransformation(extent={{-126,
              -70},{-86,-30}})));
    Modelica.Blocks.Interfaces.BooleanInput Pump(start=false) "Connector of Real input signal 1"
      annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={0,-110}), iconTransformation(
          extent={{20,-20},{-20,20}},
          rotation=270,
          origin={0,-100})));
  initial equation
    // Assert that the substance with name 'water' has been found.
    assert(Medium.nXi == 0 or abs(sum(s) - 1) < 1e-5,
    "If Medium.nXi > 1, then substance 'water' must be present for one component.'"
       + Medium.mediumName + "'.\n" + "Check medium model.");

  equation

    if Pump then
      //PumpOn = 1;
      //Mass balance Air:
      G_o = G_i - m;
      //mass balance solution:
      L_o = L_i + m;
      //Mass balance Water:
      G_o * port_b.Xi_outflow = G_i * inStream(port_a.Xi_outflow) - m1Xi_flow;
      //mass transfer equation
      m_star = beta*a_t*V*(pw_a - pw_s);
      //equation for m considering physical boundaries:
      m = m_star;
      //m = min( m_star, w_in);
      //m = min( min(m_star, w_in),max(m_star, w_outmax));
      //concentration of desiccant solution
      L_i * x_i = L_o * x_o;
      //1/x_o = 1/x_i*(1 + m*L_flowInv);
      //1/x_o = 1/x_i *(1+m/L_i);

    else
      //PumpOn = 0;
      G_o = G_i;
      L_o = L_i;
      port_b.Xi_outflow = inStream(port_a.Xi_outflow);
      m_star = 0;
      m=0;
      x_o = x_i;

    end if;

    //water mass flow equations:
    //w_in = X1_in[1] * G_i;
    w_outmax = - Xout_max[1] * G_i  "not completely exact, should be outlet mass flow (G_o), use dry air alternatively";

    m_flowInv = AixLib.Utilities.Math.Functions.inverseXRegularized(
      x=port_a.m_flow,
      delta=deltaReg,
      deltaInv=deltaInvReg,
      a=aReg,
      b=bReg,
      c=cReg,
      d=dReg,
      e=eReg,
      f=fReg);

    //L_flowInv = AixLib.Utilities.Math.Functions.inverseXRegularized(x=L_i,delta=deltaReg,deltaInv=deltaInvReg, a=aReg,b=bReg,c=cReg,d=dReg,e=eReg,f=fReg);

    //pressure loss
    dp = dp_abs;

    //Mass balance Air:
    port_b.m_flow = - G_o  "Vorsicht: negatives Vorzeichen!";

    //mass balance solution:
    L_out = L_o;

    //Mass balance Water:
    port_a.Xi_outflow = inStream(port_b.Xi_outflow);

    //Energy balance:
    port_a.h_outflow = inStream(port_b.h_outflow);
    port_b.h_outflow = h_ao;

    h_ai = (1-X_i)*c_pa_in*(t_ai - t_ref) + X_i*(c_pw*(t_ai - t_ref) + lambda);
    h_ao = (1-X_o)*c_pa_out*(t_ao - t_ref) + X_o*(c_pw*(t_ao - t_ref) + lambda);
    h_si = c_ps_in*(t_si - t_ref);
    h_so = c_ps_out*(t_so - t_ref);

    L_i*h_si = L_o*h_so - Q;
    G_i*h_ai = G_o*h_ao + Q;

    //temperatures
    t_si = Ts_in;
    Ts_out = t_so;
    //t_so - t_ao  =  0  "Annahme: Ausgang der Sole hat die selbe Temperatur wie die Luft";
    t_so - t_ao = (1 - eps)*(t_si - t_ai) "Abweichung von t_ao=t_so in der Wärmeübertragung";

    //vapor pressure
    theta = t_s/T_cH2O "reduced temperature T/T_c,H20";

    pw_w = BaseClasses.Utilities.partialPressureWater(t_s);
    //welches T?
    pi = BaseClasses.Utilities.relativePartialPressureLiCl(theta, x_i);
    // ist x_i die mass fraction of solute?
    pw_s = pi*pw_w;

    pw_a = Utilities.Psychrometrics.Functions.pW_X((inStream(port_a.Xi_outflow[1])+port_b.Xi_outflow[1])/2);

    // Species flow rate from m
    m1Xi_flow = m*s;

    //concentration of desiccant solution
    x_i = x_in;
    x_out = x_o;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Rectangle(extent={{
                -100,100},{100,-100}}, lineColor={28,108,200}), Text(
            extent={{-80,80},{80,-80}},
            lineColor={28,108,200},
            textString="Absorber")}), Diagram(coordinateSystem(preserveAspectRatio=false)));
  end Desorber;
end ComponentsAHU;
