within AixLib.Airflow.AirHandlingUnit.Examples;
model TestHeatingCoil "test model to validate Heating Coil"
    extends Modelica.Icons.Example;

      //Medium models
  replaceable package MediumAir = AixLib.Media.Air;
  replaceable package MediumWater = AixLib.Media.Water;

  parameter Real k_y09 = 0.1;  //0,06
  parameter Real Ti_y09 = 180;

  parameter Modelica.SIunits.Temperature T_In = 7.9+273.15;
  parameter Real X_In[2] = {0.005,0.995};

  Fluid.Sources.MassFlowSource_T
                            outsideAir(
    redeclare package Medium = MediumAir,
    nPorts=1,
    m_flow=5,
    T=T_In,
    X=X_In)   "Source for outside air"
    annotation (Placement(transformation(extent={{100,-10},{80,10}})));
  Fluid.Sources.Boundary_pT supplyAir(
    redeclare package Medium = MediumAir,
    nPorts=1,
    p=100000,
    T=294.15,
    X={0.01,0.99})
              "Sink for supply air"
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Fluid.Sensors.RelativeHumidityTwoPort senRHbefore(redeclare package Medium =
        MediumAir, m_flow_nominal=5)
    "Relative Humidity before steam humidifier"
    annotation (Placement(transformation(extent={{70,-10},{50,10}})));
  Fluid.Sensors.RelativeHumidityTwoPort senRHafter(redeclare package Medium =
        MediumAir, m_flow_nominal=5)
    "Relative Humidity after steam humidifier"
    annotation (Placement(transformation(extent={{-50,-10},{-70,10}})));
  Fluid.Sensors.TemperatureTwoPort T_after(redeclare package Medium = MediumAir,
      m_flow_nominal=5) "temperature after steam humidifier"
    annotation (Placement(transformation(extent={{-20,-10},{-40,10}})));
  Fluid.Sensors.TemperatureTwoPort T_before(redeclare package Medium = MediumAir,
      m_flow_nominal=5) "temperature before steam humidifier"
    annotation (Placement(transformation(extent={{40,-10},{20,10}})));
  Modelica.Blocks.Sources.IntegerExpression integerExpression(y=13)
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  ComponentsAHU.heatingRegister heatingRegister(
    redeclare package Medium1 = MediumAir,
    redeclare package Medium2 = MediumWater,
    m1_flow_nominal=5.1,
    m2_flow_nominal=2,
    T_init=293.15)
    annotation (Placement(transformation(extent={{10,-16},{-10,4}})));
  Modelica.Fluid.Sources.Boundary_pT WatSin(          redeclare package Medium =
        MediumWater, nPorts=1)
                     "Water sink" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,-70})));
  Modelica.Fluid.Sources.Boundary_pT WatSou(
    redeclare package Medium = MediumWater,
    nPorts=1,
    T=318.15) "Water source" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,-70})));
  BaseClasses.Controllers.OperatingModes.PN_Steuerung.Aktoren.controlvalve2
                                     valve_Y1( Y_Close(n=19, modes={1,2,3,4,5,6,
          7,8,9,10,11,14,15,16,17,18,19,22,23}), Y_Control(n=4, modes={12,13,20,
          21})) "controlValve"
    annotation (Placement(transformation(extent={{-72,60},{-52,80}})));
  BaseClasses.Controllers.OperatingModes.PN_Steuerung.Auswertemodule.heaCoiEva
    y09_evaluation(
    k=k_y09,
    Ti=Ti_y09,
    Setpoint=293.15)
    annotation (Placement(transformation(extent={{-36,60},{-16,80}})));
  BaseClasses.Controllers.OperatingModes.PN_Steuerung.Aktoren.Pump_On_Off
                                   pumpN04(Pump_Off(n=19, modes={1,2,3,4,5,6,7,8,
          9,10,11,14,15,16,17,18,19,22,23}), Pump_On(n=4, modes={12,13,20,21}))
    "on off signal of pump N04 for heating coil circuit for supply air"
    annotation (Placement(transformation(extent={{-72,40},{-52,60}})));
  Fluid.Sensors.TemperatureTwoPort T_after_water(redeclare package Medium =
        MediumWater, m_flow_nominal=2) "temperature before coil" annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={20,-36})));
  Fluid.Sensors.TemperatureTwoPort T_before_water(redeclare package Medium =
        MediumWater, m_flow_nominal=2) "temperature after coil" annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-20,-34})));
equation
  connect(outsideAir.ports[1], senRHbefore.port_a)
    annotation (Line(points={{80,0},{70,0}}, color={0,127,255}));
  connect(senRHbefore.port_b, T_before.port_a)
    annotation (Line(points={{50,0},{40,0}}, color={0,127,255}));
  connect(T_after.port_b, senRHafter.port_a)
    annotation (Line(points={{-40,0},{-50,0}}, color={0,127,255}));
  connect(senRHafter.port_b, supplyAir.ports[1])
    annotation (Line(points={{-70,0},{-80,0}}, color={0,127,255}));
  connect(T_before.port_b, heatingRegister.port_a1)
    annotation (Line(points={{20,0},{10,0}}, color={0,127,255}));
  connect(heatingRegister.port_b1, T_after.port_a)
    annotation (Line(points={{-10,0},{-20,0}}, color={0,127,255}));
  connect(integerExpression.y, valve_Y1.M_in)
    annotation (Line(points={{-79,70},{-72.8,70}}, color={255,127,0}));
  connect(valve_Y1.Close, y09_evaluation.Y_closed)
    annotation (Line(points={{-51.2,76},{-36.6,76}}, color={255,0,255}));
  connect(valve_Y1.Control, y09_evaluation.Y_control)
    annotation (Line(points={{-51.4,70},{-36.6,70}}, color={255,0,255}));
  connect(T_after.T, y09_evaluation.MeasuredValue) annotation (Line(points={{-30,
          11},{-36.6,11},{-36.6,63}}, color={0,0,127}));
  connect(y09_evaluation.y, heatingRegister.u) annotation (Line(points={{-15.4,70},
          {-16,-7.6},{-10.8,-7.6}}, color={0,0,127}));
  connect(integerExpression.y, pumpN04.M_in) annotation (Line(points={{-79,70},{
          -80,70},{-80,50},{-72.8,50}}, color={255,127,0}));
  connect(pumpN04.signal_Pump, heatingRegister.pumpN04) annotation (Line(points=
         {{-51.4,50},{-16,50},{-16,-4},{-10.8,-4}}, color={0,0,127}));
  connect(WatSin.ports[1], T_after_water.port_a)
    annotation (Line(points={{20,-60},{20,-46}}, color={0,127,255}));
  connect(T_after_water.port_b, heatingRegister.port_b2)
    annotation (Line(points={{20,-26},{20,-12},{10,-12}}, color={0,127,255}));
  connect(heatingRegister.port_a2, T_before_water.port_a) annotation (Line(
        points={{-10,-12},{-20,-12},{-20,-24}}, color={0,127,255}));
  connect(T_before_water.port_b, WatSou.ports[1])
    annotation (Line(points={{-20,-44},{-20,-60}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=1800));
end TestHeatingCoil;
