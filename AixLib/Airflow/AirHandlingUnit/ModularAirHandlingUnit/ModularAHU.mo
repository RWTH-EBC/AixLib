within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit;
model ModularAHU "model of a modular air handling unit"

  parameter Boolean humidifying = false;
  parameter Boolean cooling = false;
  parameter Boolean dehumidifying = false;
  parameter Boolean heating = false;
  parameter Boolean heatRecovery = false;
  parameter Boolean use_PhiSet = false;

  parameter Modelica.SIunits.Temperature Twat = 373.15
    "water or steam temperature"
    annotation(Dialog(tab="Humidifying",enable=humidifying));

  Components.Cooler cooler(use_T_set=true, use_X_set=use_X_set) if
       cooling or dehumidifying
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  replaceable Components.SteamHumidifier humidifier(use_X_set=true) if
       humidifying
    annotation (Dialog(enable=humidifying),choices(
      choice(humidifier = Components.SteamHumidifier "Steam Humidifier"),
      choice(humidifier = Components.SprayHumidifier "Spray Humidifier")),
      Placement(transformation(extent={{26,-40},{46,-20}})));
  Components.Heater heater(use_T_set=true) if heating or dehumidifying
    annotation (Placement(transformation(extent={{60,-40},{80,-20}})));
  Components.PlateHeatExchangerFixedEfficiency heatRecoverySystem if
       heatRecovery
    annotation (Placement(transformation(extent={{-82,-10},{-62,10}})));
  Components.FlowControlled_dp fanOda(use_WeatherData=false)
    annotation (Placement(transformation(extent={{-52,-40},{-32,-20}})));
  Components.FlowControlled_dp fanEta
    annotation (Placement(transformation(extent={{-28,20},{-48,40}})));
  Modelica.Blocks.Interfaces.RealOutput m_flow_airOutOda
    "mass flow rate of outgoing outdoor air"
    annotation (Placement(transformation(extent={{100,-16},{120,4}})));
  Modelica.Blocks.Interfaces.RealOutput T_airOutOda
    "temperature of outgoing outdoor air"
    annotation (Placement(transformation(extent={{100,-36},{120,-16}})));
  Modelica.Blocks.Interfaces.RealOutput X_airOutOda
    "absolute humidity of outgoing outdoor air"
    annotation (Placement(transformation(extent={{100,-58},{120,-38}})));
  Modelica.Blocks.Interfaces.RealInput m_flow_airInOda
    "mass flow rate of incoming outdoor air"
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
  Modelica.Blocks.Interfaces.RealInput T_airInOda
    "temperature of incoming otudoor air"
    annotation (Placement(transformation(extent={{-140,-70},{-100,-30}})));
  Modelica.Blocks.Interfaces.RealInput X_airInOda
    "absolute humidity of incoming outdoor air"
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
  Modelica.Blocks.Interfaces.RealInput m_flow_airInEta
    "mass flow rate of incoming exhaust air"
    annotation (Placement(transformation(extent={{140,60},{100,100}})));
  Modelica.Blocks.Interfaces.RealInput T_airInEta
    "temperature of incoming exhaust air"
    annotation (Placement(transformation(extent={{140,30},{100,70}})));
  Modelica.Blocks.Interfaces.RealInput X_airInEta
    "absolute humidity of incoming exhaust air"
    annotation (Placement(transformation(extent={{140,0},{100,40}})));
  Modelica.Blocks.Interfaces.RealOutput m_flow_airOutEta
    "mass flow rate of outgoing exhaust air"
    annotation (Placement(transformation(extent={{-100,70},{-120,90}})));
  Modelica.Blocks.Interfaces.RealOutput T_airOutEta
    "temperature of outgoing exhaust air"
    annotation (Placement(transformation(extent={{-100,48},{-120,68}})));
  Modelica.Blocks.Interfaces.RealOutput X_airOutEta
    "absolute humidity of outgoing exhaust air"
    annotation (Placement(transformation(extent={{-100,28},{-120,48}})));
  Modelica.Blocks.Interfaces.RealInput dp_inEta "Prescribed pressure rise"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,116})));
  Modelica.Blocks.Interfaces.RealInput dp_inOda "Prescribed pressure rise"
    annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=-90,
        origin={-20,-116})));
  Modelica.Blocks.Interfaces.RealInput Tset if heating or cooling or
    dehumidifying or heatRecovery "set temperature for supply air" annotation (
      Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=-90,
        origin={40,-112})));
  Controler.ControlerCooler controlerCooler(
    final dehumidifying=dehumidifying,
    final use_PhiSet=use_PhiSet) if cooling or dehumidifying or use_PhiSet
    annotation (Placement(transformation(extent={{-10,-74},{10,-54}})));
  Modelica.Blocks.Interfaces.RealInput Xset if
       (dehumidifying or humidifying) and not use_PhiSet
    "set value for absolute humidity at ahu outlet" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={76,-112})));
  Modelica.Blocks.Interfaces.RealInput PhiSet[2] if
       (dehumidifying or humidifying) and use_PhiSet
    "set value for relative humidity at ahu outlet"
    annotation (Placement(transformation(extent={{140,-108},{100,-68}})));
  Controler.ControlerHumidifier controlerHumidifier(
    final use_PhiSet=use_PhiSet) if humidifying
    annotation (Placement(transformation(extent={{20,0},{40,20}})));

protected
  parameter Boolean use_X_set = dehumidifying "true if dehumidifying is chosen";
  Modelica.Blocks.Sources.Constant T_steamIn(k=Twat) if humidifying
    annotation (Placement(transformation(extent={{48,-60},{38,-50}})));
equation
  // connect exhaust air to fanEta
  connect(m_flow_airInEta,fanEta.m_flow_in);
  connect(T_airInEta,fanEta.T_airIn);
  connect(X_airInEta,fanEta.X_airIn);

  if heatRecovery and (cooling and heating or dehumidifying) and humidifying then
    // connect outdoor air to HRS
    connect(m_flow_airInOda,heatRecoverySystem.m_flow_airInOda);
    connect(T_airInOda,heatRecoverySystem.T_airInOda);
    connect(X_airInOda,heatRecoverySystem.X_airInOda);
    // connect HRS to fan
    connect(heatRecoverySystem.m_flow_airOutOda,fanOda.m_flow_in);
    connect(heatRecoverySystem.T_airOutOda,fanOda.T_airIn);
    connect(heatRecoverySystem.X_airOutOda,fanOda.X_airIn);
    // connect fan to cooler
    connect(fanOda.m_flow_out,cooler.m_flow_airIn);
    connect(fanOda.T_airOut,cooler.T_airIn);
    connect(fanOda.X_airOut,cooler.X_airIn);
    // connect cooler to humidifier
    connect(cooler.m_flow_airOut,humidifier.m_flow_airIn);
    connect(cooler.T_airOut,humidifier.T_airIn);
    connect(cooler.X_airOut,humidifier.X_airIn);
    // connect humidifier to heater
    connect(humidifier.m_flow_airOut,heater.m_flow_airIn);
    connect(humidifier.T_airOut,heater.T_airIn);
    connect(humidifier.X_airOut,heater.X_airIn);
    // connect heater to outlet of supply air
    connect(heater.m_flow_airOut,m_flow_airOutOda);
    connect(heater.T_airOut,T_airOutOda);
    connect(heater.X_airOut,X_airOutOda);
    // connect fanEta to HRS
    connect(fanEta.m_flow_out,heatRecoverySystem.m_flow_airInEta);
    connect(fanEta.T_airOut,heatRecoverySystem.T_airInEta);
    connect(fanEta.X_airOut,heatRecoverySystem.X_airInEta);
    // connect HRS to outlet of exhaust air
    connect(heatRecoverySystem.m_flow_airOutEta,m_flow_airOutEta);
    connect(heatRecoverySystem.T_airOutEta,T_airOutEta);
    connect(heatRecoverySystem.X_airOutEta,X_airOutEta);

  elseif heatRecovery and heating and humidifying then
    // connect outdoor air to HRS
    connect(m_flow_airInOda,heatRecoverySystem.m_flow_airInOda);
    connect(T_airInOda,heatRecoverySystem.T_airInOda);
    connect(X_airInOda,heatRecoverySystem.X_airInOda);
    // connect HRS to fan
    connect(heatRecoverySystem.m_flow_airOutOda,fanOda.m_flow_in);
    connect(heatRecoverySystem.T_airOutOda,fanOda.T_airIn);
    connect(heatRecoverySystem.X_airOutOda,fanOda.X_airIn);
    // connect fan to humidifier
    connect(fanOda.m_flow_out,humidifier.m_flow_airIn);
    connect(fanOda.T_airOut,humidifier.T_airIn);
    connect(fanOda.X_airOut,humidifier.X_airIn);
    // connect humidifier to heater
    connect(humidifier.m_flow_airOut,heater.m_flow_airIn);
    connect(humidifier.T_airOut,heater.T_airIn);
    connect(humidifier.X_airOut,heater.X_airIn);
    // connect heater to outlet of supply air
    connect(heater.m_flow_airOut,m_flow_airOutOda);
    connect(heater.T_airOut,T_airOutOda);
    connect(heater.X_airOut,X_airOutOda);
    // connect fanEta to HRS
    connect(fanEta.m_flow_out,heatRecoverySystem.m_flow_airInEta);
    connect(fanEta.T_airOut,heatRecoverySystem.T_airInEta);
    connect(fanEta.X_airOut,heatRecoverySystem.X_airInEta);
    // connect HRS to outlet of exhaust air
    connect(heatRecoverySystem.m_flow_airOutEta,m_flow_airOutEta);
    connect(heatRecoverySystem.T_airOutEta,T_airOutEta);
    connect(heatRecoverySystem.X_airOutEta,X_airOutEta);

   elseif heatRecovery and cooling and humidifying then
    // connect outdoor air to HRS
    connect(m_flow_airInOda,heatRecoverySystem.m_flow_airInOda);
    connect(T_airInOda,heatRecoverySystem.T_airInOda);
    connect(X_airInOda,heatRecoverySystem.X_airInOda);
    // connect HRS to fan
    connect(heatRecoverySystem.m_flow_airOutOda,fanOda.m_flow_in);
    connect(heatRecoverySystem.T_airOutOda,fanOda.T_airIn);
    connect(heatRecoverySystem.X_airOutOda,fanOda.X_airIn);
    // connect fan to cooler
    connect(fanOda.m_flow_out,cooler.m_flow_airIn);
    connect(fanOda.T_airOut,cooler.T_airIn);
    connect(fanOda.X_airOut,cooler.X_airIn);
    // connect cooler to humidifier
    connect(cooler.m_flow_airOut,humidifier.m_flow_airIn);
    connect(cooler.T_airOut,humidifier.T_airIn);
    connect(cooler.X_airOut,humidifier.X_airIn);
    // connect humidifier to outlet of supply air
    connect(humidifier.m_flow_airOut,m_flow_airOutOda);
    connect(humidifier.T_airOut,T_airOutOda);
    connect(humidifier.X_airOut,X_airOutOda);
    // connect fanEta to HRS
    connect(fanEta.m_flow_out,heatRecoverySystem.m_flow_airInEta);
    connect(fanEta.T_airOut,heatRecoverySystem.T_airInEta);
    connect(fanEta.X_airOut,heatRecoverySystem.X_airInEta);
    // connect HRS to outlet of exhaust air
    connect(heatRecoverySystem.m_flow_airOutEta,m_flow_airOutEta);
    connect(heatRecoverySystem.T_airOutEta,T_airOutEta);
    connect(heatRecoverySystem.X_airOutEta,X_airOutEta);

  elseif heatRecovery and humidifying then
    // connect outdoor air to HRS
    connect(m_flow_airInOda,heatRecoverySystem.m_flow_airInOda);
    connect(T_airInOda,heatRecoverySystem.T_airInOda);
    connect(X_airInOda,heatRecoverySystem.X_airInOda);
    // connect HRS to fan
    connect(heatRecoverySystem.m_flow_airOutOda,fanOda.m_flow_in);
    connect(heatRecoverySystem.T_airOutOda,fanOda.T_airIn);
    connect(heatRecoverySystem.X_airOutOda,fanOda.X_airIn);
    // connect fan to humidifier
    connect(fanOda.m_flow_out,humidifier.m_flow_airIn);
    connect(fanOda.T_airOut,humidifier.T_airIn);
    connect(fanOda.X_airOut,humidifier.X_airIn);
    // connect humidifier to outlet of supply air
    connect(humidifier.m_flow_airOut,m_flow_airOutOda);
    connect(humidifier.T_airOut,T_airOutOda);
    connect(humidifier.X_airOut,X_airOutOda);
    // connect fanEta to HRS
    connect(fanEta.m_flow_out,heatRecoverySystem.m_flow_airInEta);
    connect(fanEta.T_airOut,heatRecoverySystem.T_airInEta);
    connect(fanEta.X_airOut,heatRecoverySystem.X_airInEta);
    // connect HRS to outlet of exhaust air
    connect(heatRecoverySystem.m_flow_airOutEta,m_flow_airOutEta);
    connect(heatRecoverySystem.T_airOutEta,T_airOutEta);
    connect(heatRecoverySystem.X_airOutEta,X_airOutEta);

  elseif heatRecovery and (cooling and heating or dehumidifying) then
    // connect outdoor air to HRS
    connect(m_flow_airInOda,heatRecoverySystem.m_flow_airInOda);
    connect(T_airInOda,heatRecoverySystem.T_airInOda);
    connect(X_airInOda,heatRecoverySystem.X_airInOda);
    // connect HRS to fan
    connect(heatRecoverySystem.m_flow_airOutOda,fanOda.m_flow_in);
    connect(heatRecoverySystem.T_airOutOda,fanOda.T_airIn);
    connect(heatRecoverySystem.X_airOutOda,fanOda.X_airIn);
    // connect fan to cooler
    connect(fanOda.m_flow_out,cooler.m_flow_airIn);
    connect(fanOda.T_airOut,cooler.T_airIn);
    connect(fanOda.X_airOut,cooler.X_airIn);
    // connect cooler to heater
    connect(cooler.m_flow_airOut,heater.m_flow_airIn);
    connect(cooler.T_airOut,heater.T_airIn);
    connect(cooler.X_airOut,heater.X_airIn);
    // connect heater to outlet of supply air
    connect(heater.m_flow_airOut,m_flow_airOutOda);
    connect(heater.T_airOut,T_airOutOda);
    connect(heater.X_airOut,X_airOutOda);
    // connect fanEta to HRS
    connect(fanEta.m_flow_out,heatRecoverySystem.m_flow_airInEta);
    connect(fanEta.T_airOut,heatRecoverySystem.T_airInEta);
    connect(fanEta.X_airOut,heatRecoverySystem.X_airInEta);
    // connect HRS to outlet of exhaust air
    connect(heatRecoverySystem.m_flow_airOutEta,m_flow_airOutEta);
    connect(heatRecoverySystem.T_airOutEta,T_airOutEta);
    connect(heatRecoverySystem.X_airOutEta,X_airOutEta);

  elseif heatRecovery and heating then
    // connect outdoor air to HRS
    connect(m_flow_airInOda,heatRecoverySystem.m_flow_airInOda);
    connect(T_airInOda,heatRecoverySystem.T_airInOda);
    connect(X_airInOda,heatRecoverySystem.X_airInOda);
    // connect HRS to fan
    connect(heatRecoverySystem.m_flow_airOutOda,fanOda.m_flow_in);
    connect(heatRecoverySystem.T_airOutOda,fanOda.T_airIn);
    connect(heatRecoverySystem.X_airOutOda,fanOda.X_airIn);
    // connect fanOda to heater
    connect(fanOda.m_flow_out,heater.m_flow_airIn);
    connect(fanOda.T_airOut,heater.T_airIn);
    connect(fanOda.X_airOut,heater.X_airIn);
    // connect heater to outlet of supply air
    connect(humidifier.m_flow_airOut,m_flow_airOutOda);
    connect(humidifier.T_airOut,T_airOutOda);
    connect(humidifier.X_airOut,X_airOutOda);
    // connect fanEta to HRS
    connect(fanEta.m_flow_out,heatRecoverySystem.m_flow_airInEta);
    connect(fanEta.T_airOut,heatRecoverySystem.T_airInEta);
    connect(fanEta.X_airOut,heatRecoverySystem.X_airInEta);
    // connect HRS to outlet of exhaust air
    connect(heatRecoverySystem.m_flow_airOutEta,m_flow_airOutEta);
    connect(heatRecoverySystem.T_airOutEta,T_airOutEta);
    connect(heatRecoverySystem.X_airOutEta,X_airOutEta);

  elseif heatRecovery and cooling then
    // connect outdoor air to HRS
    connect(m_flow_airInOda,heatRecoverySystem.m_flow_airInOda);
    connect(T_airInOda,heatRecoverySystem.T_airInOda);
    connect(X_airInOda,heatRecoverySystem.X_airInOda);
    // connect HRS to fan
    connect(heatRecoverySystem.m_flow_airOutOda,fanOda.m_flow_in);
    connect(heatRecoverySystem.T_airOutOda,fanOda.T_airIn);
    connect(heatRecoverySystem.X_airOutOda,fanOda.X_airIn);
    // connect fan to cooler
    connect(fanOda.m_flow_out,cooler.m_flow_airIn);
    connect(fanOda.T_airOut,cooler.T_airIn);
    connect(fanOda.X_airOut,cooler.X_airIn);
    // connect cooler to oulet of supply air
    connect(cooler.m_flow_airOut,m_flow_airOutOda);
    connect(cooler.T_airOut,T_airOutOda);
    connect(cooler.X_airOut,X_airOutOda);
    // connect fanEta to HRS
    connect(fanEta.m_flow_out,heatRecoverySystem.m_flow_airInEta);
    connect(fanEta.T_airOut,heatRecoverySystem.T_airInEta);
    connect(fanEta.X_airOut,heatRecoverySystem.X_airInEta);
    // connect HRS to outlet of exhaust air
    connect(heatRecoverySystem.m_flow_airOutEta,m_flow_airOutEta);
    connect(heatRecoverySystem.T_airOutEta,T_airOutEta);
    connect(heatRecoverySystem.X_airOutEta,X_airOutEta);

  elseif heatRecovery then
    // connect outdoor air to HRS
    connect(m_flow_airInOda,heatRecoverySystem.m_flow_airInOda);
    connect(T_airInOda,heatRecoverySystem.T_airInOda);
    connect(X_airInOda,heatRecoverySystem.X_airInOda);
    // connect HRS to fan
    connect(heatRecoverySystem.m_flow_airOutOda,fanOda.m_flow_in);
    connect(heatRecoverySystem.T_airOutOda,fanOda.T_airIn);
    connect(heatRecoverySystem.X_airOutOda,fanOda.X_airIn);
    // connect fanOda to outlet of supply air
    connect(fanOda.m_flow_out,m_flow_airOutOda);
    connect(fanOda.T_airOut,T_airOutOda);
    connect(fanOda.X_airOut,X_airOutOda);
    // connect fanEta to HRS
    connect(fanEta.m_flow_out,heatRecoverySystem.m_flow_airInEta);
    connect(fanEta.T_airOut,heatRecoverySystem.T_airInEta);
    connect(fanEta.X_airOut,heatRecoverySystem.X_airInEta);
    // connect HRS to outlet of exhaust air
    connect(heatRecoverySystem.m_flow_airOutEta,m_flow_airOutEta);
    connect(heatRecoverySystem.T_airOutEta,T_airOutEta);
    connect(heatRecoverySystem.X_airOutEta,X_airOutEta);

  elseif (cooling and heating or dehumidifying) and humidifying then
    // connect outdoor air to fanOda
    connect(m_flow_airInOda,fanOda.m_flow_in);
    connect(T_airInOda,fanOda.T_airIn);
    connect(X_airInOda,fanOda.X_airIn);
    // connect fan to cooler
    connect(fanOda.m_flow_out,cooler.m_flow_airIn);
    connect(fanOda.T_airOut,cooler.T_airIn);
    connect(fanOda.X_airOut,cooler.X_airIn);
    // connect cooler to humidifier
    connect(cooler.m_flow_airOut,humidifier.m_flow_airIn);
    connect(cooler.T_airOut,humidifier.T_airIn);
    connect(cooler.X_airOut,humidifier.X_airIn);
    // connect humidifier to heater
    connect(humidifier.m_flow_airOut,heater.m_flow_airIn);
    connect(humidifier.T_airOut,heater.T_airIn);
    connect(humidifier.X_airOut,heater.X_airIn);
    // connect heater to outlet of supply air
    connect(heater.m_flow_airOut,m_flow_airOutOda);
    connect(heater.T_airOut,T_airOutOda);
    connect(heater.X_airOut,X_airOutOda);
    // connect fanEta to HRS
    connect(fanEta.m_flow_out,heatRecoverySystem.m_flow_airInEta);
    connect(fanEta.T_airOut,heatRecoverySystem.T_airInEta);
    connect(fanEta.X_airOut,heatRecoverySystem.X_airInEta);
    // connect HRS to outlet of exhaust air
    connect(heatRecoverySystem.m_flow_airOutEta,m_flow_airOutEta);
    connect(heatRecoverySystem.T_airOutEta,T_airOutEta);
    connect(heatRecoverySystem.X_airOutEta,X_airOutEta);

  elseif heating and humidifying then
    // connect outdoor air to fanOda
    connect(m_flow_airInOda,fanOda.m_flow_in);
    connect(T_airInOda,fanOda.T_airIn);
    connect(X_airInOda,fanOda.X_airIn);
    // connect fan to humidifier
    connect(fanOda.m_flow_out,humidifier.m_flow_airIn);
    connect(fanOda.T_airOut,humidifier.T_airIn);
    connect(fanOda.X_airOut,humidifier.X_airIn);
    // connect humidifier to heater
    connect(humidifier.m_flow_airOut,heater.m_flow_airIn);
    connect(humidifier.T_airOut,heater.T_airIn);
    connect(humidifier.X_airOut,heater.X_airIn);
    // connect heater to outlet of supply air
    connect(heater.m_flow_airOut,m_flow_airOutOda);
    connect(heater.T_airOut,T_airOutOda);
    connect(heater.X_airOut,X_airOutOda);
    // connect fanEta to HRS
    connect(fanEta.m_flow_out,heatRecoverySystem.m_flow_airInEta);
    connect(fanEta.T_airOut,heatRecoverySystem.T_airInEta);
    connect(fanEta.X_airOut,heatRecoverySystem.X_airInEta);
    // connect HRS to outlet of exhaust air
    connect(heatRecoverySystem.m_flow_airOutEta,m_flow_airOutEta);
    connect(heatRecoverySystem.T_airOutEta,T_airOutEta);
    connect(heatRecoverySystem.X_airOutEta,X_airOutEta);

  elseif cooling and humidifying then
    // connect outdoor air to fanOda
    connect(m_flow_airInOda,fanOda.m_flow_in);
    connect(T_airInOda,fanOda.T_airIn);
    connect(X_airInOda,fanOda.X_airIn);
    // connect fan to cooler
    connect(fanOda.m_flow_out,cooler.m_flow_airIn);
    connect(fanOda.T_airOut,cooler.T_airIn);
    connect(fanOda.X_airOut,cooler.X_airIn);
    // connect cooler to humidifier
    connect(cooler.m_flow_airOut,humidifier.m_flow_airIn);
    connect(cooler.T_airOut,humidifier.T_airIn);
    connect(cooler.X_airOut,humidifier.X_airIn);
    // connect humidifier to outlet of supply air
    connect(humidifier.m_flow_airOut,m_flow_airOutOda);
    connect(humidifier.T_airOut,T_airOutOda);
    connect(humidifier.X_airOut,X_airOutOda);
    // connect fanEta to HRS
    connect(fanEta.m_flow_out,heatRecoverySystem.m_flow_airInEta);
    connect(fanEta.T_airOut,heatRecoverySystem.T_airInEta);
    connect(fanEta.X_airOut,heatRecoverySystem.X_airInEta);
    // connect HRS to outlet of exhaust air
    connect(heatRecoverySystem.m_flow_airOutEta,m_flow_airOutEta);
    connect(heatRecoverySystem.T_airOutEta,T_airOutEta);
    connect(heatRecoverySystem.X_airOutEta,X_airOutEta);

  elseif cooling and heating or dehumidifying then
    // connect outdoor air to fanOda
    connect(m_flow_airInOda,fanOda.m_flow_in);
    connect(T_airInOda,fanOda.T_airIn);
    connect(X_airInOda,fanOda.X_airIn);
    // connect fan to cooler
    connect(fanOda.m_flow_out,cooler.m_flow_airIn);
    connect(fanOda.T_airOut,cooler.T_airIn);
    connect(fanOda.X_airOut,cooler.X_airIn);
    // connect cooler to heater
    connect(cooler.m_flow_airOut,heater.m_flow_airIn);
    connect(cooler.T_airOut,heater.T_airIn);
    connect(cooler.X_airOut,heater.X_airIn);
    // connect heater to outlet of supply air
    connect(heater.m_flow_airOut,m_flow_airOutOda);
    connect(heater.T_airOut,T_airOutOda);
    connect(heater.X_airOut,X_airOutOda);
    // connect fanEta to HRS
    connect(fanEta.m_flow_out,heatRecoverySystem.m_flow_airInEta);
    connect(fanEta.T_airOut,heatRecoverySystem.T_airInEta);
    connect(fanEta.X_airOut,heatRecoverySystem.X_airInEta);
    // connect HRS to outlet of exhaust air
    connect(heatRecoverySystem.m_flow_airOutEta,m_flow_airOutEta);
    connect(heatRecoverySystem.T_airOutEta,T_airOutEta);
    connect(heatRecoverySystem.X_airOutEta,X_airOutEta);

  elseif humidifying then
    // connect outdoor air to fanOda
    connect(m_flow_airInOda,fanOda.m_flow_in);
    connect(T_airInOda,fanOda.T_airIn);
    connect(X_airInOda,fanOda.X_airIn);
    // connect fan to humidifier
    connect(fanOda.m_flow_out,humidifier.m_flow_airIn);
    connect(fanOda.T_airOut,humidifier.T_airIn);
    connect(fanOda.X_airOut,humidifier.X_airIn);
    // connect humidifier to outlet of supply air
    connect(humidifier.m_flow_airOut,m_flow_airOutOda);
    connect(humidifier.T_airOut,T_airOutOda);
    connect(humidifier.X_airOut,X_airOutOda);
    // connect fanEta to HRS
    connect(fanEta.m_flow_out,heatRecoverySystem.m_flow_airInEta);
    connect(fanEta.T_airOut,heatRecoverySystem.T_airInEta);
    connect(fanEta.X_airOut,heatRecoverySystem.X_airInEta);
    // connect HRS to outlet of exhaust air
    connect(heatRecoverySystem.m_flow_airOutEta,m_flow_airOutEta);
    connect(heatRecoverySystem.T_airOutEta,T_airOutEta);
    connect(heatRecoverySystem.X_airOutEta,X_airOutEta);

  elseif heating then
    // connect outdoor air to fanOda
    connect(m_flow_airInOda,fanOda.m_flow_in);
    connect(T_airInOda,fanOda.T_airIn);
    connect(X_airInOda,fanOda.X_airIn);
    // connect fanOda to heater
    connect(fanOda.m_flow_out,heater.m_flow_airIn);
    connect(fanOda.T_airOut,heater.T_airIn);
    connect(fanOda.X_airOut,heater.X_airIn);
    // connect heater to outlet of supply air
    connect(humidifier.m_flow_airOut,m_flow_airOutOda);
    connect(humidifier.T_airOut,T_airOutOda);
    connect(humidifier.X_airOut,X_airOutOda);
    // connect fanEta to HRS
    connect(fanEta.m_flow_out,heatRecoverySystem.m_flow_airInEta);
    connect(fanEta.T_airOut,heatRecoverySystem.T_airInEta);
    connect(fanEta.X_airOut,heatRecoverySystem.X_airInEta);
    // connect HRS to outlet of exhaust air
    connect(heatRecoverySystem.m_flow_airOutEta,m_flow_airOutEta);
    connect(heatRecoverySystem.T_airOutEta,T_airOutEta);
    connect(heatRecoverySystem.X_airOutEta,X_airOutEta);

  elseif cooling then
    // connect outdoor air to fanOda
    connect(m_flow_airInOda,fanOda.m_flow_in);
    connect(T_airInOda,fanOda.T_airIn);
    connect(X_airInOda,fanOda.X_airIn);
    // connect fan to cooler
    connect(fanOda.m_flow_out,cooler.m_flow_airIn);
    connect(fanOda.T_airOut,cooler.T_airIn);
    connect(fanOda.X_airOut,cooler.X_airIn);
    // connect cooler to oulet of supply air
    connect(cooler.m_flow_airOut,m_flow_airOutOda);
    connect(cooler.T_airOut,T_airOutOda);
    connect(cooler.X_airOut,X_airOutOda);
    // connect fanEta to HRS
    connect(fanEta.m_flow_out,heatRecoverySystem.m_flow_airInEta);
    connect(fanEta.T_airOut,heatRecoverySystem.T_airInEta);
    connect(fanEta.X_airOut,heatRecoverySystem.X_airInEta);
    // connect HRS to outlet of exhaust air
    connect(heatRecoverySystem.m_flow_airOutEta,m_flow_airOutEta);
    connect(heatRecoverySystem.T_airOutEta,T_airOutEta);
    connect(heatRecoverySystem.X_airOutEta,X_airOutEta);

  else
    // connect outdoor air to fanOda
    connect(m_flow_airInOda,fanOda.m_flow_in);
    connect(T_airInOda,fanOda.T_airIn);
    connect(X_airInOda,fanOda.X_airIn);
    // connect fanOda to outlet of supply air
    connect(fanOda.m_flow_out,m_flow_airOutOda);
    connect(fanOda.T_airOut,T_airOutOda);
    connect(fanOda.X_airOut,X_airOutOda);
    // connect exhaust air to fanEta
    connect(m_flow_airInEta,fanEta.m_flow_in);
    connect(T_airInEta,fanEta.T_airIn);
    connect(X_airInEta,fanEta.X_airIn);
    // connect fanEta to outlet of exhaust air
    connect(fanEta.m_flow_out,m_flow_airOutEta);
    connect(fanEta.T_airOut,T_airOutEta);
    connect(fanEta.X_airOut,X_airOutEta);
  end if;
  connect(fanEta.dp_in, dp_inEta)
    annotation (Line(points={{-26.6,34},{0,34},{0,116}}, color={0,0,127}));
  connect(fanOda.dp_in, dp_inOda) annotation (Line(points={{-53.4,-26},{-60,-26},
          {-60,-62},{-20,-62},{-20,-116}}, color={0,0,127}));
  connect(Tset, heater.T_set) annotation (Line(points={{40,-112},{40,-70},{54,-70},
          {54,-12},{70,-12},{70,-20}}, color={0,0,127}));
  connect(Tset, controlerCooler.Tset) annotation (Line(points={{40,-112},{40,-88},
          {-16,-88},{-16,-58},{-11,-58}}, color={0,0,127}));
  connect(cooler.X_airIn, controlerCooler.X_coolerIn) annotation (Line(points={{
          -11,-28},{-16,-28},{-16,-82},{0,-82},{0,-75}}, color={0,0,127}));
  connect(controlerCooler.TCooSet, cooler.T_set) annotation (Line(points={{11,-60},
          {18,-60},{18,-14},{0,-14},{0,-20}}, color={0,0,127}));
  connect(controlerCooler.XCooSet, cooler.X_set) annotation (Line(points={{11,-68},
          {18,-68},{18,-14},{6,-14},{6,-20}}, color={0,0,127}));
  connect(controlerCooler.Xset, Xset) annotation (Line(points={{-11,-64},{-16,-64},
          {-16,-88},{76,-88},{76,-112}}, color={0,0,127}));
  connect(PhiSet[2], controlerCooler.PhiSet) annotation (Line(points={{120,-78},
          {-16,-78},{-16,-70},{-11,-70}}, color={0,0,127}));
  connect(controlerHumidifier.XHumSet, humidifier.X_set) annotation (Line(
        points={{41,10},{48,10},{48,-12},{36,-12},{36,-19.8}}, color={0,0,127}));
  connect(Xset, controlerHumidifier.Xset) annotation (Line(points={{76,-112},{76,
          -88},{-16,-88},{-16,10},{19,10}}, color={0,0,127}));
  connect(PhiSet[1], controlerHumidifier.PhiSet) annotation (Line(points={{120,-98},
          {-16,-98},{-16,4},{19,4}}, color={0,0,127}));
  connect(Tset, controlerHumidifier.Tset) annotation (Line(points={{40,-112},{40,
          -78},{-16,-78},{-16,16},{19,16}}, color={0,0,127}));
  connect(T_steamIn.y, humidifier.T_steamIn) annotation (Line(points={{37.5,-55},
          {33,-55},{33,-39.4}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ModularAHU;
