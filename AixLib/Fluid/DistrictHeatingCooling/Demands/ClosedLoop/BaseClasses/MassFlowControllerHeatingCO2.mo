within AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop.BaseClasses;
model MassFlowControllerHeatingCO2
  "mass flow controller for substation with decentral storage for heating (SubstationHeatingCooling_DC_CH_HP_HeatStorage)"

    final parameter Modelica.SIunits.Density rho = 1000 "Density of Water";
    final parameter Real cp_default = 4180 "Cp-value of Water";

    parameter Modelica.SIunits.TemperatureDifference deltaT_he = 15 "Set temperature difference for heat exchanger";
    parameter Modelica.SIunits.Temperature T_storage_min = 273.15 + 55 "Minimal temperature for heating supply";
    parameter Modelica.SIunits.Temperature T_storage_max = 273.15 + 65 "Maximal temperature for heating supply";
    parameter Modelica.SIunits.TemperatureDifference  deltaT_heatingSet = 4 "Set temperature difference for heating on the building site";
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal
    "Nominal mass flow rate";
    parameter Modelica.SIunits.Power capacity = 100000 "Capacity of heat pump (max. heating power)";
    parameter Modelica.SIunits.Duration charging_duration = 7200 "Duration of charging prozess in s";

    parameter Modelica.SIunits.Volume V_Storage = 2 "Volume of heat storage";

   // Modelica.SIunits.Power P_storageCharging  "available electrical power for storage charging";
    Modelica.SIunits.Power Q_demandHP;


    Modelica.Blocks.Interfaces.RealOutput m_flow_storage(start=0) "Output for storage pump mass flow rate"
    annotation (Placement(
        transformation(extent={{900,-26},{942,16}}), iconTransformation(extent={{762,
            -210},{812,-160}})));
    Modelica.Blocks.Interfaces.RealInput heat_Demand "Heat demand of building"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-114,22}),   iconTransformation(extent={{-21,-21},{21,21}},
          origin={-121,-491})));
    Modelica.Blocks.Interfaces.RealInput COP "COP of heat pump"
    annotation (Placement(
        transformation(
        extent={{20,20},{-20,-20}},
        rotation=180,
        origin={-114,76}), iconTransformation(
        extent={{21,21},{-21,-21}},
        rotation=180,
        origin={-119,71})));
    Modelica.Blocks.Interfaces.RealInput T_storageTop "Temperature of storage top layer"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-106,-92}),  iconTransformation(extent={{-21,-21},{21,21}},
          origin={-121,-165})));
    Modelica.Blocks.Interfaces.RealInput T_storageBottom "Temperature of storage bottom layer"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-110,-152}), iconTransformation(extent={{-21,-21},{21,21}},
          origin={-121,-65})));
    Modelica.Blocks.Interfaces.RealInput deltaT_grid "Temperature difference for heat pump operation on grid side"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,-364}), iconTransformation(extent={{-21,-21},{21,21}},
          origin={-119,-403})));
    Modelica.Blocks.Interfaces.RealOutput m_flow_gridHeating "Output for grid pump mass flow rate for heating"
    annotation (Placement(
        transformation(extent={{902,-126},{944,-84}}), iconTransformation(
          extent={{762,-276},{812,-226}})));
    Modelica.Blocks.Interfaces.BooleanOutput Charging
    annotation (Placement(transformation(extent={{896,-364},{940,-320}}),
        iconTransformation(extent={{762,118},{808,164}})));
    Modelica.Blocks.Logical.And charging "Requirements for storage charging"
    annotation (Placement(transformation(extent={{432,60},{452,80}})));
    Modelica.Blocks.Logical.Hysteresis hysteresis_discharge(uLow=T_storage_min + 0.1, uHigh=
        T_storage_max - 0.2)
                         "Temperature requirements for storage discharging"
    annotation (Placement(transformation(extent={{232,-102},{252,-82}})));
    Modelica.Blocks.Logical.Hysteresis hysteresis_charge(
    uLow=T_storage_max - 2,
    uHigh=T_storage_max - 0.5,
    pre_y_start=true) "Temperature requirements for storage charging"
    annotation (Placement(transformation(extent={{232,12},{252,32}})));
    Modelica.Blocks.Logical.And discharging "Requirements for storage discharging"
    annotation (Placement(transformation(extent={{424,-134},{444,-114}})));
    Modelica.Blocks.MathBoolean.Not not1
    annotation (Placement(transformation(extent={{350,42},{358,50}})));
    Modelica.Blocks.Interfaces.RealInput T_HP_in "Heat pump flow temperature"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-122,-480}), iconTransformation(extent={{-21,-21},{21,21}},
          origin={-117,-321})));
    Modelica.Blocks.Interfaces.RealInput m_flow_heatExchanger
    "Mass flow rate through heat exchanger" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,-422}), iconTransformation(extent={{-21,-21},{21,21}},
          origin={-119,-243})));
    Modelica.Blocks.Interfaces.RealInput COP_charging "COP of heat pump with charging temperature" annotation (
      Placement(transformation(
        extent={{20,20},{-20,-20}},
        rotation=180,
        origin={-122,170}), iconTransformation(
        extent={{21,21},{-21,-21}},
        rotation=180,
        origin={-123,147})));
    Modelica.Blocks.Interfaces.RealInput P_chiller "Power demand of chiller"
    annotation (Placement(
        transformation(extent={{-140,110},{-100,150}}), iconTransformation(
          extent={{-144,-28},{-100,16}})));
  Modelica.Blocks.Interfaces.BooleanInput chargingIn
    annotation (Placement(transformation(extent={{-130,290},{-72,348}})));
  Modelica.Blocks.Interfaces.BooleanInput dischargingIn
    annotation (Placement(transformation(extent={{-134,212},{-70,276}})));
equation

  //P_storageCharging = P_renewable - heat_Demand/COP_charging - P_chiller;

  //charging
  if charging.y then
   m_flow_storage = -max(V_Storage * rho / charging_duration, (capacity-heat_Demand)/(cp_default*deltaT_he));
   Q_demandHP =heat_Demand - m_flow_storage*cp_default*deltaT_he;
   Charging = true;

  //discharging
  elseif discharging.y then
   m_flow_storage = -m_flow_heatExchanger;
   Q_demandHP =heat_Demand - m_flow_storage*cp_default*deltaT_he;
   Charging = false;

  //no storage operation
  else
   m_flow_storage = 0;
   Q_demandHP = heat_Demand;
   Charging = false;
  end if;

  m_flow_gridHeating = max(0, (Q_demandHP*(1 - 1/COP))/(cp_default*deltaT_grid));

  connect(T_storageBottom, hysteresis_charge.u) annotation (Line(points={{-110,-152},
          {54,-152},{54,22},{230,22}},      color={0,0,127}));
  connect(hysteresis_charge.y, not1.u) annotation (Line(points={{253,22},{302,22},
          {302,46},{348.4,46}},
                              color={255,0,255}));
  connect(T_storageTop, hysteresis_discharge.u) annotation (Line(points={{-106,-92},
          {230,-92}},                    color={0,0,127}));
  connect(hysteresis_discharge.y, discharging.u2) annotation (Line(points={{253,
          -92},{280,-92},{280,-132},{422,-132}}, color={255,0,255}));
  connect(not1.y, charging.u2) annotation (Line(points={{358.8,46},{378,46},{378,
          62},{430,62}}, color={255,0,255}));
  connect(chargingIn, charging.u1) annotation (Line(points={{-101,319},{354,319},
          {354,70},{430,70}}, color={255,0,255}));
  connect(dischargingIn, discharging.u1) annotation (Line(points={{-102,244},{322,
          244},{322,-124},{422,-124}}, color={255,0,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -540},{900,240}}),   graphics={ Text(
            extent={{-70,6},{56,-12}},
            lineColor={135,135,135},
            fillColor={255,255,170},
            fillPattern=FillPattern.Solid,
            textString="%name"),                               Rectangle(extent={{
              -98,238},{762,-540}},   lineColor={135,135,135},
            fillColor={255,255,170},
            fillPattern=FillPattern.Solid), Text(
            extent={{18,162},{602,-322}},
            lineColor={135,135,135},
            fillColor={255,255,170},
            fillPattern=FillPattern.Solid,
          textString="%Mass Flow
Controller Heating
and Storage
")}), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-540},{
            900,240}})));
end MassFlowControllerHeatingCO2;
