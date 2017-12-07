within AixLib.Airflow.AirHandlingUnit.Examples;
model TestSteamHumid "test model to validate steam humidifier model"
    extends Modelica.Icons.Example;

      //Medium models
  replaceable package MediumAir = AixLib.Media.Air;
  replaceable package MediumWater = AixLib.Media.Water;

  parameter Real phi_Set = 0.5  "set value for phi (relative humidity) at T01";
  parameter Real k_phi = 0.28;  //80;
  parameter Real Ti_phi = 27;  //26;

  parameter Modelica.SIunits.Temperature T_In = 17+273.15;
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
  Fluid.Humidifiers.Humidifier_u steamHumidifier(
    dp_nominal=0,
    redeclare package Medium = MediumAir,
    m_flow_nominal=5,
    mWat_flow_nominal=0.02)
    "simple model for steam humidifier to create valve signal between 0 and 1"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}})));
  BaseClasses.steamHumidHeatModel steamHumidHeatModel
    annotation (Placement(transformation(extent={{-10,24},{10,44}})));
  Fluid.Sensors.RelativeHumidityTwoPort senRHbefore(redeclare package Medium =
        MediumAir, m_flow_nominal=5)
    "Relative Humidity before steam humidifier"
    annotation (Placement(transformation(extent={{72,-10},{52,10}})));
  Fluid.Sensors.RelativeHumidityTwoPort senRHafter(redeclare package Medium =
        MediumAir, m_flow_nominal=5)
    "Relative Humidity after steam humidifier"
    annotation (Placement(transformation(extent={{-50,-10},{-70,10}})));
  Fluid.Sensors.TemperatureTwoPort T_after(redeclare package Medium = MediumAir,
      m_flow_nominal=5) "temperature after steam humidifier"
    annotation (Placement(transformation(extent={{-20,-10},{-40,10}})));
  Fluid.Sensors.TemperatureTwoPort T_before(redeclare package Medium = MediumAir,
      m_flow_nominal=5) "temperature before steam humidifier"
    annotation (Placement(transformation(extent={{42,-10},{22,10}})));
  BaseClasses.Controllers.OperatingModes.PN_Steuerung.Aktoren.controlvalve2
                                     valve_Y11(Y_Close(n=15, modes={1,2,4,5,7,8,
          10,12,14,15,16,18,20,21,22}), Y_Control(n=8, modes={3,6,9,11,13,17,19,
          21})) "controlValve"
    annotation (Placement(transformation(extent={{-74,60},{-54,80}})));
  BaseClasses.Controllers.OperatingModes.PN_Steuerung.Auswertemodule.heaCoiEva
                                             y11_evaluation(
    k=k_phi,
    Ti=Ti_phi,
    Setpoint=phi_Set)
    annotation (Placement(transformation(extent={{-10,60},{10,80}})));
  Modelica.Blocks.Sources.IntegerExpression integerExpression(y=3)
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
equation
  connect(outsideAir.ports[1], senRHbefore.port_a)
    annotation (Line(points={{80,0},{72,0}}, color={0,127,255}));
  connect(senRHbefore.port_b, T_before.port_a)
    annotation (Line(points={{52,0},{42,0}}, color={0,127,255}));
  connect(T_before.port_b, steamHumidifier.port_a)
    annotation (Line(points={{22,0},{10,0}}, color={0,127,255}));
  connect(steamHumidifier.port_b, T_after.port_a)
    annotation (Line(points={{-10,0},{-20,0}}, color={0,127,255}));
  connect(T_after.port_b, senRHafter.port_a)
    annotation (Line(points={{-40,0},{-50,0}}, color={0,127,255}));
  connect(senRHafter.port_b, supplyAir.ports[1])
    annotation (Line(points={{-70,0},{-80,0}}, color={0,127,255}));
  connect(steamHumidifier.mWat_flow, steamHumidHeatModel.u) annotation (Line(
        points={{-11,6},{-16,6},{-16,34},{-10.4,34}}, color={0,0,127}));
  connect(steamHumidHeatModel.port_a, steamHumidifier.heatPort) annotation (
      Line(points={{9.8,34},{16,34},{16,-6},{10,-6}}, color={191,0,0}));
  connect(integerExpression.y, valve_Y11.M_in)
    annotation (Line(points={{-79,70},{-74.8,70}}, color={255,127,0}));
  connect(y11_evaluation.y, steamHumidifier.u) annotation (Line(points={{10.6,70},
          {18,70},{18,6},{11,6}}, color={0,0,127}));
  connect(senRHafter.phi, y11_evaluation.MeasuredValue) annotation (Line(points=
         {{-60.1,11},{-60.1,63},{-10.6,63}}, color={0,0,127}));
  connect(valve_Y11.Close, y11_evaluation.Y_closed)
    annotation (Line(points={{-53.2,76},{-10.6,76}}, color={255,0,255}));
  connect(valve_Y11.Control, y11_evaluation.Y_control)
    annotation (Line(points={{-53.4,70},{-10.6,70}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=1800));
end TestSteamHumid;
