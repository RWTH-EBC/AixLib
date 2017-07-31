within AixLib.Controls.Interfaces;
model HeatPumpBusSwitch "Switches between several signalBus outputs"

  parameter Real n=2 "number of switchable ports";


  HeatPumpControlBus       signalBus
    annotation (Placement(transformation(extent={{-20,78},{20,118}})));
  HeatPumpControlBus       signalBus1
    annotation (Placement(transformation(extent={{-112,-120},{-72,-80}})));
  HeatPumpControlBus       signalBus2
    annotation (Placement(transformation(extent={{-70,-120},{-30,-80}})));
//  HeatPumpControlBus       signalBus3
//    annotation (Placement(transformation(extent={{-20,-120},{20,-80}})));
//  HeatPumpControlBus       signalBus4
//   annotation (Placement(transformation(extent={{30,-120},{70,-80}})));
//  HeatPumpControlBus       signalBus5
//    annotation (Placement(transformation(extent={{72,-120},{112,-80}})));

  Modelica.Blocks.Routing.RealPassThrough Bus_N;
  Modelica.Blocks.Routing.RealPassThrough Bus_T_flow_ev;
  Modelica.Blocks.Routing.RealPassThrough Bus_T_flow_co;
  Modelica.Blocks.Routing.RealPassThrough Bus_T_ret_ev;
  Modelica.Blocks.Routing.RealPassThrough Bus_T_ret_co;
  Modelica.Blocks.Routing.RealPassThrough Bus_Pel;
  Modelica.Blocks.Routing.RealPassThrough Bus_m_flow_ev;
  Modelica.Blocks.Routing.RealPassThrough Bus_m_flow_co;
  Modelica.Blocks.Routing.RealPassThrough Bus_CoP;
  Modelica.Blocks.Routing.BooleanPassThrough Bus_onOff;
  Modelica.Blocks.Routing.BooleanPassThrough Bus_mode;


  Modelica.Blocks.Interfaces.IntegerInput u annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-76,100})));
equation
//connections
  connect(signalBus.N,Bus_N.y);
  connect(signalBus.T_flow_ev,Bus_T_flow_ev.u);
  connect(signalBus.T_flow_co,Bus_T_flow_co.u);
  connect(signalBus.T_ret_ev,Bus_T_ret_ev.u);
  connect(signalBus.T_ret_co,Bus_T_ret_co.u);
  connect(signalBus.Pel,Bus_Pel.u);
  connect(signalBus.m_flow_ev,Bus_m_flow_ev.u);
  connect(signalBus.m_flow_co,Bus_m_flow_co.u);
  connect(signalBus.CoP,Bus_CoP.u);
  connect(signalBus.onOff,Bus_onOff.y);
  connect(signalBus.mode,Bus_mode.y);

  if u==1 then
         signalBus1.N = Bus_N.u;
  else signalBus2.N=Bus_N.u;
  end if;

  if u==1 then
         signalBus1.T_flow_ev = Bus_T_flow_ev.y;
  else signalBus2.T_flow_ev=Bus_T_flow_ev.y;
  end if;

   if u==1 then
         signalBus1.T_flow_co = Bus_T_flow_co.y;
  else signalBus2.T_flow_co=Bus_T_flow_co.y;
  end if;

   if u==1 then
         signalBus1.T_ret_ev = Bus_T_ret_ev.y;
  else signalBus2.T_ret_ev=Bus_T_ret_ev.y;
  end if;

   if u==1 then
         signalBus1.T_ret_co = Bus_T_ret_co.y;
  else signalBus2.T_ret_co=Bus_T_ret_co.y;
  end if;

   if u==1 then
         signalBus1.Pel = Bus_Pel.y;
  else signalBus2.Pel=Bus_Pel.y;
  end if;

   if u==1 then
         signalBus1.m_flow_ev = Bus_m_flow_ev.y;
  else signalBus2.m_flow_ev=Bus_m_flow_ev.y;
   end if;

   if u==1 then
         signalBus1.m_flow_co = Bus_m_flow_co.y;
  else signalBus2.m_flow_co=Bus_m_flow_co.y;
   end if;

   if u==1 then
         signalBus1.CoP = Bus_CoP.y;
  else signalBus2.CoP=Bus_CoP.y;
  end if;

   if u==1 then
         signalBus1.onOff = Bus_onOff.u;
  else signalBus2.onOff=Bus_onOff.u;
  end if;


   if u==1 then
         signalBus1.mode = Bus_mode.u;
  else signalBus2.mode=Bus_mode.u;
  end if;







end HeatPumpBusSwitch;
