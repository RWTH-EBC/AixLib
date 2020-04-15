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
    annotation(Dialog(group="Humidifying",enable=humidifying));
  parameter Modelica.SIunits.Temperature TcooSur = 373.15
    "temperature of cooling surface set to high value if no condensate should be considered"
    annotation(Dialog(group="Cooling",enable=cooling or dehumidifying));

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
  Components.FanSimple fanOda
    annotation (Placement(transformation(extent={{-52,-40},{-32,-20}})));
  Components.FanSimple fanEta
    annotation (Placement(transformation(extent={{-28,20},{-48,40}})));
  Modelica.Blocks.Interfaces.RealOutput m_flow_airOutOda
    "mass flow rate of outgoing outdoor air"
    annotation (Placement(transformation(extent={{160,-30},{180,-10}})));
  Modelica.Blocks.Interfaces.RealOutput T_airOutOda
    "temperature of outgoing outdoor air"
    annotation (Placement(transformation(extent={{160,-60},{180,-40}}),
        iconTransformation(extent={{160,-60},{180,-40}})));
  Modelica.Blocks.Interfaces.RealOutput X_airOutOda
    "absolute humidity of outgoing outdoor air"
    annotation (Placement(transformation(extent={{160,-90},{180,-70}}),
        iconTransformation(extent={{160,-90},{180,-70}})));
  Modelica.Blocks.Interfaces.RealInput m_flow_airInOda
    "mass flow rate of incoming outdoor air"
    annotation (Placement(transformation(extent={{-180,-40},{-140,0}}),
        iconTransformation(extent={{-180,-30},{-160,-10}})));
  Modelica.Blocks.Interfaces.RealInput T_airInOda
    "temperature of incoming otudoor air"
    annotation (Placement(transformation(extent={{-180,-70},{-140,-30}}),
        iconTransformation(extent={{-180,-60},{-160,-40}})));
  Modelica.Blocks.Interfaces.RealInput X_airInOda
    "absolute humidity of incoming outdoor air"
    annotation (Placement(transformation(extent={{-180,-100},{-140,-60}}),
        iconTransformation(extent={{-180,-90},{-160,-70}})));
  Modelica.Blocks.Interfaces.RealInput m_flow_airInEta
    "mass flow rate of incoming exhaust air"
    annotation (Placement(transformation(extent={{180,60},{140,100}}),
        iconTransformation(extent={{180,70},{160,90}})));
  Modelica.Blocks.Interfaces.RealInput T_airInEta
    "temperature of incoming exhaust air"
    annotation (Placement(transformation(extent={{180,30},{140,70}}),
        iconTransformation(extent={{180,40},{160,60}})));
  Modelica.Blocks.Interfaces.RealInput X_airInEta
    "absolute humidity of incoming exhaust air"
    annotation (Placement(transformation(extent={{200,-10},{160,30}}),
        iconTransformation(extent={{180,10},{160,30}})));
  Modelica.Blocks.Interfaces.RealOutput m_flow_airOutEta
    "mass flow rate of outgoing exhaust air"
    annotation (Placement(transformation(extent={{-160,70},{-180,90}})));
  Modelica.Blocks.Interfaces.RealOutput T_airOutEta
    "temperature of outgoing exhaust air"
    annotation (Placement(transformation(extent={{-160,50},{-180,70}})));
  Modelica.Blocks.Interfaces.RealOutput X_airOutEta
    "absolute humidity of outgoing exhaust air"
    annotation (Placement(transformation(extent={{-160,30},{-180,50}})));
  Modelica.Blocks.Interfaces.RealInput dpInFanEta "Prescribed pressure rise"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,116}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,110})));
  Modelica.Blocks.Interfaces.RealInput dpInFanOda "Prescribed pressure rise"
    annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=-90,
        origin={-140,-120}),iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-140,-110})));
  Modelica.Blocks.Interfaces.RealInput Tset if heating or cooling or
    dehumidifying or heatRecovery "set temperature for supply air" annotation (Placement(
        transformation(
        extent={{20,-20},{-20,20}},
        rotation=-90,
        origin={-100,-120}), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-100,-110})));
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
        origin={-60,-120}),iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,-110})));
  Modelica.Blocks.Interfaces.RealInput PhiSet[2] if
       (dehumidifying or humidifying) and use_PhiSet
    "set value for relative humidity at ahu outlet"
    annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=-90,
        origin={-20,-120}), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-20,-110})));
  Controler.ControlerHumidifier controlerHumidifier(
    final use_PhiSet=use_PhiSet) if humidifying
    annotation (Placement(transformation(extent={{20,0},{40,20}})));

  Modelica.Blocks.Interfaces.RealOutput Pel "electrical power of ahu"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={140,-110})));

  Modelica.Blocks.Interfaces.RealOutput QHea "heating power of ahu"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={100,-110})));
  Modelica.Blocks.Interfaces.RealOutput QCoo "cooling power of ahu" annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={60,-110})));
  Modelica.Blocks.Interfaces.RealOutput QHum "humidifiying power of ahu"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={20,-110})));
protected
  parameter Boolean use_X_set = dehumidifying "true if dehumidifying is chosen";
  Modelica.Blocks.Sources.Constant T_steamIn(k=Twat) if humidifying
    annotation (Placement(transformation(extent={{48,-60},{38,-50}})));
  Modelica.Blocks.Sources.Constant T_coolingSurf(k=TcooSur) if
       cooling or dehumidifying
    annotation (Placement(transformation(extent={{-34,-56},{-24,-46}})));
  Modelica.Blocks.Math.Add sumPowFan
    annotation (Placement(transformation(extent={{-84,-72},{-76,-64}})));
  Modelica.Blocks.Interfaces.RealInput QHeaIntern "internal connector for heating power";
  Modelica.Blocks.Interfaces.RealInput QCooIntern "internal connector for cooling power";
  Modelica.Blocks.Interfaces.RealInput QHumIntern "internal connector for humidification power";
equation
  // set internal connectors to zero, if no function is chosen
  if not humidifying then
    QHumIntern = 0;
  end if;
  if not heating or not dehumidifying then
    QHeaIntern = 0;
  end if;
  if not cooling or not dehumidifying then
    QCooIntern = 0;
  end if;

  // connect component connectors to internal connectors
  connect(heater.Q,QHeaIntern);
  connect(cooler.Q,QCooIntern);
  connect(humidifier.Q,QHumIntern);

  // connect internal connectors to outside
  connect(QHumIntern,QHum);
  connect(QHeaIntern,QHea);
  connect(QCooIntern,QCoo);

  // connect exhaust air to fanEta
  connect(m_flow_airInEta,fanEta.m_flow_airIn);
  connect(T_airInEta,fanEta.T_airIn);
  connect(X_airInEta,fanEta.X_airIn);

  if heatRecovery and (cooling and heating or dehumidifying) and humidifying then
    // connect outdoor air to HRS
    connect(m_flow_airInOda,heatRecoverySystem.m_flow_airInOda);
    connect(T_airInOda,heatRecoverySystem.T_airInOda);
    connect(X_airInOda,heatRecoverySystem.X_airInOda);
    // connect HRS to fan
    connect(heatRecoverySystem.m_flow_airOutOda,fanOda.m_flow_airIn);
    connect(heatRecoverySystem.T_airOutOda,fanOda.T_airIn);
    connect(heatRecoverySystem.X_airOutOda,fanOda.X_airIn);
    // connect fan to cooler
    connect(fanOda.m_flow_airOut,cooler.m_flow_airIn);
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
    connect(fanEta.m_flow_airOut,heatRecoverySystem.m_flow_airInEta);
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
    connect(heatRecoverySystem.m_flow_airOutOda,fanOda.m_flow_airIn);
    connect(heatRecoverySystem.T_airOutOda,fanOda.T_airIn);
    connect(heatRecoverySystem.X_airOutOda,fanOda.X_airIn);
    // connect fan to humidifier
    connect(fanOda.m_flow_airOut,humidifier.m_flow_airIn);
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
    connect(fanEta.m_flow_airOut,heatRecoverySystem.m_flow_airInEta);
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
    connect(heatRecoverySystem.m_flow_airOutOda,fanOda.m_flow_airIn);
    connect(heatRecoverySystem.T_airOutOda,fanOda.T_airIn);
    connect(heatRecoverySystem.X_airOutOda,fanOda.X_airIn);
    // connect fan to cooler
    connect(fanOda.m_flow_airOut,cooler.m_flow_airIn);
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
    connect(fanEta.m_flow_airOut,heatRecoverySystem.m_flow_airInEta);
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
    connect(heatRecoverySystem.m_flow_airOutOda,fanOda.m_flow_airIn);
    connect(heatRecoverySystem.T_airOutOda,fanOda.T_airIn);
    connect(heatRecoverySystem.X_airOutOda,fanOda.X_airIn);
    // connect fan to humidifier
    connect(fanOda.m_flow_airOut,humidifier.m_flow_airIn);
    connect(fanOda.T_airOut,humidifier.T_airIn);
    connect(fanOda.X_airOut,humidifier.X_airIn);
    // connect humidifier to outlet of supply air
    connect(humidifier.m_flow_airOut,m_flow_airOutOda);
    connect(humidifier.T_airOut,T_airOutOda);
    connect(humidifier.X_airOut,X_airOutOda);
    // connect fanEta to HRS
    connect(fanEta.m_flow_airOut,heatRecoverySystem.m_flow_airInEta);
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
    connect(heatRecoverySystem.m_flow_airOutOda,fanOda.m_flow_airIn);
    connect(heatRecoverySystem.T_airOutOda,fanOda.T_airIn);
    connect(heatRecoverySystem.X_airOutOda,fanOda.X_airIn);
    // connect fan to cooler
    connect(fanOda.m_flow_airOut,cooler.m_flow_airIn);
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
    connect(fanEta.m_flow_airOut,heatRecoverySystem.m_flow_airInEta);
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
    connect(heatRecoverySystem.m_flow_airOutOda,fanOda.m_flow_airIn);
    connect(heatRecoverySystem.T_airOutOda,fanOda.T_airIn);
    connect(heatRecoverySystem.X_airOutOda,fanOda.X_airIn);
    // connect fanOda to heater
    connect(fanOda.m_flow_airOut,heater.m_flow_airIn);
    connect(fanOda.T_airOut,heater.T_airIn);
    connect(fanOda.X_airOut,heater.X_airIn);
    // connect heater to outlet of supply air
    connect(humidifier.m_flow_airOut,m_flow_airOutOda);
    connect(humidifier.T_airOut,T_airOutOda);
    connect(humidifier.X_airOut,X_airOutOda);
    // connect fanEta to HRS
    connect(fanEta.m_flow_airOut,heatRecoverySystem.m_flow_airInEta);
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
    connect(heatRecoverySystem.m_flow_airOutOda,fanOda.m_flow_airIn);
    connect(heatRecoverySystem.T_airOutOda,fanOda.T_airIn);
    connect(heatRecoverySystem.X_airOutOda,fanOda.X_airIn);
    // connect fan to cooler
    connect(fanOda.m_flow_airOut,cooler.m_flow_airIn);
    connect(fanOda.T_airOut,cooler.T_airIn);
    connect(fanOda.X_airOut,cooler.X_airIn);
    // connect cooler to oulet of supply air
    connect(cooler.m_flow_airOut,m_flow_airOutOda);
    connect(cooler.T_airOut,T_airOutOda);
    connect(cooler.X_airOut,X_airOutOda);
    // connect fanEta to HRS
    connect(fanEta.m_flow_airOut,heatRecoverySystem.m_flow_airInEta);
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
    connect(heatRecoverySystem.m_flow_airOutOda,fanOda.m_flow_airIn);
    connect(heatRecoverySystem.T_airOutOda,fanOda.T_airIn);
    connect(heatRecoverySystem.X_airOutOda,fanOda.X_airIn);
    // connect fanOda to outlet of supply air
    connect(fanOda.m_flow_airOut,m_flow_airOutOda);
    connect(fanOda.T_airOut,T_airOutOda);
    connect(fanOda.X_airOut,X_airOutOda);
    // connect fanEta to HRS
    connect(fanEta.m_flow_airOut,heatRecoverySystem.m_flow_airInEta);
    connect(fanEta.T_airOut,heatRecoverySystem.T_airInEta);
    connect(fanEta.X_airOut,heatRecoverySystem.X_airInEta);
    // connect HRS to outlet of exhaust air
    connect(heatRecoverySystem.m_flow_airOutEta,m_flow_airOutEta);
    connect(heatRecoverySystem.T_airOutEta,T_airOutEta);
    connect(heatRecoverySystem.X_airOutEta,X_airOutEta);

  elseif (cooling and heating or dehumidifying) and humidifying then
    // connect outdoor air to fanOda
    connect(m_flow_airInOda,fanOda.m_flow_airIn);
    connect(T_airInOda,fanOda.T_airIn);
    connect(X_airInOda,fanOda.X_airIn);
    // connect fan to cooler
    connect(fanOda.m_flow_airOut,cooler.m_flow_airIn);
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
    // connect fanEta to outlet of exhaust air
    connect(fanEta.m_flow_airOut,m_flow_airOutEta);
    connect(fanEta.T_airOut,T_airOutEta);
    connect(fanEta.X_airOut,X_airOutEta);

  elseif heating and humidifying then
    // connect outdoor air to fanOda
    connect(m_flow_airInOda,fanOda.m_flow_airIn);
    connect(T_airInOda,fanOda.T_airIn);
    connect(X_airInOda,fanOda.X_airIn);
    // connect fan to humidifier
    connect(fanOda.m_flow_airOut,humidifier.m_flow_airIn);
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
    // connect fanEta to outlet of exhaust air
    connect(fanEta.m_flow_airOut,m_flow_airOutEta);
    connect(fanEta.T_airOut,T_airOutEta);
    connect(fanEta.X_airOut,X_airOutEta);

  elseif cooling and humidifying then
    // connect outdoor air to fanOda
    connect(m_flow_airInOda,fanOda.m_flow_airIn);
    connect(T_airInOda,fanOda.T_airIn);
    connect(X_airInOda,fanOda.X_airIn);
    // connect fan to cooler
    connect(fanOda.m_flow_airOut,cooler.m_flow_airIn);
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
    // connect fanEta to outlet of exhaust air
    connect(fanEta.m_flow_airOut,m_flow_airOutEta);
    connect(fanEta.T_airOut,T_airOutEta);
    connect(fanEta.X_airOut,X_airOutEta);

  elseif cooling and heating or dehumidifying then
    // connect outdoor air to fanOda
    connect(m_flow_airInOda,fanOda.m_flow_airIn);
    connect(T_airInOda,fanOda.T_airIn);
    connect(X_airInOda,fanOda.X_airIn);
    // connect fan to cooler
    connect(fanOda.m_flow_airOut,cooler.m_flow_airIn);
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
    // connect fanEta to outlet of exhaust air
    connect(fanEta.m_flow_airOut,m_flow_airOutEta);
    connect(fanEta.T_airOut,T_airOutEta);
    connect(fanEta.X_airOut,X_airOutEta);

  elseif humidifying then
    // connect outdoor air to fanOda
    connect(m_flow_airInOda,fanOda.m_flow_airIn);
    connect(T_airInOda,fanOda.T_airIn);
    connect(X_airInOda,fanOda.X_airIn);
    // connect fan to humidifier
    connect(fanOda.m_flow_airOut,humidifier.m_flow_airIn);
    connect(fanOda.T_airOut,humidifier.T_airIn);
    connect(fanOda.X_airOut,humidifier.X_airIn);
    // connect humidifier to outlet of supply air
    connect(humidifier.m_flow_airOut,m_flow_airOutOda);
    connect(humidifier.T_airOut,T_airOutOda);
    connect(humidifier.X_airOut,X_airOutOda);
    // connect fanEta to outlet of exhaust air
    connect(fanEta.m_flow_airOut,m_flow_airOutEta);
    connect(fanEta.T_airOut,T_airOutEta);
    connect(fanEta.X_airOut,X_airOutEta);

  elseif heating then
    // connect outdoor air to fanOda
    connect(m_flow_airInOda,fanOda.m_flow_airIn);
    connect(T_airInOda,fanOda.T_airIn);
    connect(X_airInOda,fanOda.X_airIn);
    // connect fanOda to heater
    connect(fanOda.m_flow_airOut,heater.m_flow_airIn);
    connect(fanOda.T_airOut,heater.T_airIn);
    connect(fanOda.X_airOut,heater.X_airIn);
    // connect heater to outlet of supply air
    connect(humidifier.m_flow_airOut,m_flow_airOutOda);
    connect(humidifier.T_airOut,T_airOutOda);
    connect(humidifier.X_airOut,X_airOutOda);
    // connect fanEta to outlet of exhaust air
    connect(fanEta.m_flow_airOut,m_flow_airOutEta);
    connect(fanEta.T_airOut,T_airOutEta);
    connect(fanEta.X_airOut,X_airOutEta);

  elseif cooling then
    // connect outdoor air to fanOda
    connect(m_flow_airInOda,fanOda.m_flow_airIn);
    connect(T_airInOda,fanOda.T_airIn);
    connect(X_airInOda,fanOda.X_airIn);
    // connect fan to cooler
    connect(fanOda.m_flow_airOut,cooler.m_flow_airIn);
    connect(fanOda.T_airOut,cooler.T_airIn);
    connect(fanOda.X_airOut,cooler.X_airIn);
    // connect cooler to oulet of supply air
    connect(cooler.m_flow_airOut,m_flow_airOutOda);
    connect(cooler.T_airOut,T_airOutOda);
    connect(cooler.X_airOut,X_airOutOda);
    // connect fanEta to outlet of exhaust air
    connect(fanEta.m_flow_airOut,m_flow_airOutEta);
    connect(fanEta.T_airOut,T_airOutEta);
    connect(fanEta.X_airOut,X_airOutEta);

  else
    // connect outdoor air to fanOda
    connect(m_flow_airInOda,fanOda.m_flow_airIn);
    connect(T_airInOda,fanOda.T_airIn);
    connect(X_airInOda,fanOda.X_airIn);
    // connect fanOda to outlet of supply air
    connect(fanOda.m_flow_airOut,m_flow_airOutOda);
    connect(fanOda.T_airOut,T_airOutOda);
    connect(fanOda.X_airOut,X_airOutOda);
    // connect fanEta to outlet of exhaust air
    connect(fanEta.m_flow_airOut,m_flow_airOutEta);
    connect(fanEta.T_airOut,T_airOutEta);
    connect(fanEta.X_airOut,X_airOutEta);
  end if;
  connect(fanEta.dpIn, dpInFanEta)
    annotation (Line(points={{-38,41},{0,41},{0,116}}, color={0,0,127}));
  connect(fanOda.dpIn, dpInFanOda) annotation (Line(points={{-42,-19},{-60,-19},
          {-60,-120},{-140,-120}},         color={0,0,127}));
  connect(Tset, heater.T_set) annotation (Line(points={{-100,-120},{-100,-78},{54,
          -78},{54,-12},{70,-12},{70,-20}},
                                       color={0,0,127}));
  connect(Tset, controlerCooler.Tset) annotation (Line(points={{-100,-120},{-100,
          -88},{-16,-88},{-16,-58},{-11,-58}},
                                          color={0,0,127}));
  connect(cooler.X_airIn, controlerCooler.X_coolerIn) annotation (Line(points={{
          -11,-28},{-16,-28},{-16,-82},{0,-82},{0,-75}}, color={0,0,127}));
  connect(controlerCooler.TCooSet, cooler.T_set) annotation (Line(points={{11,-60},
          {18,-60},{18,-14},{0,-14},{0,-20}}, color={0,0,127}));
  connect(controlerCooler.XCooSet, cooler.X_set) annotation (Line(points={{11,-68},
          {18,-68},{18,-14},{6,-14},{6,-20}}, color={0,0,127}));
  connect(controlerCooler.Xset, Xset) annotation (Line(points={{-11,-64},{-16,-64},
          {-16,-120},{-60,-120}},        color={0,0,127}));
  connect(PhiSet[2], controlerCooler.PhiSet) annotation (Line(points={{-20,-110},
          {-16,-110},{-16,-70},{-11,-70}},color={0,0,127}));
  connect(controlerHumidifier.XHumSet, humidifier.X_set) annotation (Line(
        points={{41,10},{48,10},{48,-12},{36,-12},{36,-19.8}}, color={0,0,127}));
  connect(Xset, controlerHumidifier.Xset) annotation (Line(points={{-60,-120},{-60,
          -88},{-16,-88},{-16,10},{19,10}}, color={0,0,127}));
  connect(PhiSet[1], controlerHumidifier.PhiSet) annotation (Line(points={{-20,-130},
          {-20,-100},{-16,-100},{-16,4},{19,4}},
                                     color={0,0,127}));
  connect(Tset, controlerHumidifier.Tset) annotation (Line(points={{-100,-120},{
          -100,-78},{-16,-78},{-16,16},{19,16}},
                                            color={0,0,127}));
  connect(T_steamIn.y, humidifier.T_steamIn) annotation (Line(points={{37.5,-55},
          {33,-55},{33,-39.4}}, color={0,0,127}));
  connect(T_coolingSurf.y, cooler.T_coolingSurf) annotation (Line(points={{-23.5,
          -51},{-4.9,-51},{-4.9,-39.9}}, color={0,0,127}));
  connect(fanEta.PelFan, sumPowFan.u1) annotation (Line(points={{-49,22},{-92,22},
          {-92,-65.6},{-84.8,-65.6}}, color={0,0,127}));
  connect(fanOda.PelFan, sumPowFan.u2) annotation (Line(points={{-31,-38},{-26,-38},
          {-26,-42},{-92,-42},{-92,-70.4},{-84.8,-70.4}}, color={0,0,127}));
  connect(sumPowFan.y, Pel) annotation (Line(points={{-75.6,-68},{-66,-68},{-66,
          -100},{140,-100},{140,-110}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,-100},
            {160,100}})),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-160,-100},{160,100}})));
end ModularAHU;
