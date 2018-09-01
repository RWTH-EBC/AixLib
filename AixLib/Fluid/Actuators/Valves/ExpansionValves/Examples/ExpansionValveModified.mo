within AixLib.Fluid.Actuators.Valves.ExpansionValves.Examples;
package ExpansionValveModified
  model SubcoolingExpansionValveModified
    Modelica.Fluid.Sources.Boundary_ph boundary1(
      nPorts=1,
      use_h_in=true,
      redeclare package Medium =
          Media.Refrigerants.R410A_HEoS.R410a_IIR_P1_48_T233_340_Record,
      p=800000)
      annotation (Placement(transformation(extent={{100,-6},{80,14}})));
    SimpleExpansionValves.ExpansionValveModified expansionValveModified(
      m_flow_nominal=0.1,
      redeclare model MetastabilityCoefficient =
          Utilities.MetastabilityCoefficient.SpecifiedMetastabilityCoefficient.Poly_R410A_16_18_pth,
      redeclare model FlowCoefficient =
          Utilities.FlowCoefficient.SpecifiedFlowCoefficients.Buck_R22R407CR410A_EEV_16_18,
      Choice=AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.Types.Choice.Bernoullip_th,
      AVal=1.15e-6,
      redeclare package Medium =
          Media.Refrigerants.R410A_HEoS.R410a_IIR_P1_48_T233_340_Record)
                          annotation (Placement(transformation(extent={{10,-16},
              {30,4}})));

    Modelica.Blocks.Sources.Constant const(k=0.4)
      annotation (Placement(transformation(extent={{-86,66},{-66,86}})));
    Modelica.Blocks.Sources.TimeTable timeTable(table=[0,5; 11,15; 12,15])
      annotation (Placement(transformation(extent={{-142,10},{-122,30}})));
    Modelica.Fluid.Sources.Boundary_pT boundary2(
      nPorts=1,
      use_p_in=false,
      use_T_in=true,
      redeclare package Medium =
          Media.Refrigerants.R410A_HEoS.R410a_IIR_P1_48_T233_340_Record,
      p=2900000,
      T=278.15)
      annotation (Placement(transformation(extent={{-98,-14},{-78,6}})));
    Sensors.SpecificEnthalpy senSpeEnt
      annotation (Placement(transformation(extent={{-72,0},{-52,20}})));
  equation
    connect(expansionValveModified.port_b,boundary1. ports[1])
      annotation (Line(points={{30,-6},{42,-6},{42,4},{80,4}},
                                              color={0,127,255}));
    connect(const.y,expansionValveModified. manVarVal)
      annotation (Line(points={{-65,76},{-36,76},{-36,4.6},{15,4.6}},   color={0,0,127}));
    connect(boundary2.ports[1], senSpeEnt.port) annotation (Line(points={{-78,
            -4},{-70,-4},{-70,0},{-62,0}}, color={0,127,255}));
    connect(senSpeEnt.port, expansionValveModified.port_a) annotation (Line(
          points={{-62,0},{-34,0},{-34,-6},{10,-6}}, color={0,127,255}));
    connect(senSpeEnt.h_out, boundary1.h_in) annotation (Line(points={{-51,10},
            {22,10},{22,46},{102,46},{102,8}}, color={0,0,127}));
    connect(timeTable.y, boundary2.T_in) annotation (Line(points={{-121,20},{
            -112,20},{-112,0},{-100,0}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end SubcoolingExpansionValveModified;

  model UpStreamPressureExpansionValveModified
    Modelica.Fluid.Sources.Boundary_ph boundary1(
      nPorts=1,
      use_h_in=true,
      p=800000,
      redeclare package Medium =
          Media.Refrigerants.R410A_HEoS.R410a_IIR_P1_48_T233_340_Record)
      annotation (Placement(transformation(extent={{92,-8},{72,12}})));
    SimpleExpansionValves.ExpansionValveModified expansionValveModified(
      m_flow_nominal=0.1,
      redeclare model MetastabilityCoefficient =
          Utilities.MetastabilityCoefficient.SpecifiedMetastabilityCoefficient.Poly_R410A_16_18_pth,
      redeclare model FlowCoefficient =
          Utilities.FlowCoefficient.SpecifiedFlowCoefficients.Buck_R22R407CR410A_EEV_16_18,
      Choice=AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.Types.Choice.Bernoullip_th,
      redeclare package Medium =
          Media.Refrigerants.R410A_HEoS.R410a_IIR_P1_48_T233_340_Record,
      AVal=2.3e-6)        annotation (Placement(transformation(extent={{-8,-22},
              {12,-2}})));

    Modelica.Blocks.Sources.Constant const(k=0.4)
      annotation (Placement(transformation(extent={{-86,66},{-66,86}})));
    Modelica.Blocks.Sources.TimeTable timeTable(table=[0,10e5; 20,40e5; 20,40e5])
      annotation (Placement(transformation(extent={{-114,10},{-94,30}})));
    Modelica.Fluid.Sources.Boundary_pT boundary2(
      use_p_in=true,
      T=278.15,
      nPorts=1,
      redeclare package Medium =
          Media.Refrigerants.R410A_HEoS.R410a_IIR_P1_48_T233_340_Record)
      annotation (Placement(transformation(extent={{-96,-40},{-76,-20}})));
    Sensors.SpecificEnthalpy senSpeEnt
      annotation (Placement(transformation(extent={{-66,4},{-46,24}})));
  equation
    connect(expansionValveModified.port_b, boundary1.ports[1])
      annotation (Line(points={{12,-12},{42,-12},{42,2},{72,2}},
                                              color={0,127,255}));
    connect(const.y, expansionValveModified.manVarVal)
      annotation (Line(points={{-65,76},{-36,76},{-36,-1.4},{-3,-1.4}}, color={0,0,127}));
    connect(timeTable.y, boundary2.p_in) annotation (Line(points={{-93,20},{
            -83.5,20},{-83.5,-22},{-98,-22}},
                                          color={0,0,127}));
    connect(boundary2.ports[1], senSpeEnt.port) annotation (Line(points={{-76,
            -30},{-58,-30},{-58,4},{-56,4}}, color={0,127,255}));
    connect(senSpeEnt.port, expansionValveModified.port_a)
      annotation (Line(points={{-56,4},{-34,4},{-34,-12},{-8,-12}},
                                                 color={0,127,255}));
    connect(senSpeEnt.h_out, boundary1.h_in) annotation (Line(points={{-45,14},
            {22,14},{22,46},{94,46},{94,6}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
            preserveAspectRatio=false)));
  end UpStreamPressureExpansionValveModified;

  model DownStreamPressureExpansionValveModified

    Modelica.Fluid.Sources.Boundary_ph boundary1(
      h=250000,
      use_h_in=true,
      redeclare package Medium =
          Media.Refrigerants.R410A_HEoS.R410a_IIR_P1_48_T233_473_Horner,
      use_p_in=true,
      p=500000,
      nPorts=1) annotation (Placement(transformation(extent={{92,-8},{72,12}})));
    Modelica.Blocks.Sources.Constant const(k=1)
      annotation (Placement(transformation(extent={{-86,66},{-66,86}})));
    Modelica.Fluid.Sources.Boundary_pT boundary2(
      nPorts=1,
      use_p_in=false,
      redeclare package Medium =
          Media.Refrigerants.R410A_HEoS.R410a_IIR_P1_48_T233_473_Horner,
      p=2400000,
      T=278.15)
      annotation (Placement(transformation(extent={{-90,-22},{-70,-2}})));
    Sensors.SpecificEnthalpy senSpeEnt
      annotation (Placement(transformation(extent={{-58,-12},{-38,8}})));
    Modelica.Blocks.Sources.TimeTable timeTable(table=[0,4e5; 9,13e5; 10,13e5])
      annotation (Placement(transformation(extent={{54,28},{74,48}})));

    SimpleExpansionValves.IsenthalpicExpansionValve linearValve(
      show_flow_coefficient=true,
      show_staInl=true,
      show_staOut=false,
      useInpFil=false,
      calcProc=AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.Types.CalcProc.flowCoefficient,
      mFlowNom=0.1,
      m_flow_nominal=0.1,
      redeclare package Medium =
          Media.Refrigerants.R410A_HEoS.R410a_IIR_P1_48_T233_473_Formula,
      redeclare model FlowCoefficient =
          Utilities.FlowCoefficient.SpecifiedFlowCoefficients.Buck_R22R407CR410A_EEV_16_18,
      AVal=0.66e-6,
      dpNom=1000000)
      "Simple isothermal valve"
      annotation (Placement(transformation(extent={{-4,4},{16,24}})));

  equation
    connect(boundary2.ports[1], senSpeEnt.port) annotation (Line(points={{-70,-12},
            {-48,-12}},                          color={0,127,255}));
    connect(senSpeEnt.h_out, boundary1.h_in) annotation (Line(points={{-37,-2},
            {32,-2},{32,-16},{94,-16},{94,6}}, color={0,0,127}));
    connect(timeTable.y, boundary1.p_in) annotation (Line(points={{75,38},{88,
            38},{88,12},{94,12},{94,10}}, color={0,0,127}));
    connect(senSpeEnt.port, linearValve.port_a) annotation (Line(points={{-48,
            -12},{-26,-12},{-26,14},{-4,14}}, color={0,127,255}));
    connect(linearValve.port_b, boundary1.ports[1]) annotation (Line(points={{
            16,14},{44,14},{44,2},{72,2}}, color={0,127,255}));
    connect(const.y, linearValve.manVarVal) annotation (Line(points={{-65,76},{
            -32,76},{-32,24.6},{1,24.6}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
            preserveAspectRatio=false)));
  end DownStreamPressureExpansionValveModified;

  model AreaExpansionValveModified
    SimpleExpansionValves.ExpansionValveModified expansionValveModified(
      m_flow_nominal=0.1,
      Choice=AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.Types.Choice.Bernoullip_th,
      redeclare model MetastabilityCoefficient =
          Utilities.MetastabilityCoefficient.SpecifiedMetastabilityCoefficient.Poly_R410A_16_18_pth,
      redeclare package Medium =
          Media.Refrigerants.R410A_HEoS.R410a_IIR_P1_48_T233_473_Horner,
      redeclare model FlowCoefficient =
          Utilities.FlowCoefficient.SpecifiedFlowCoefficients.Poly_R22R407CR410A_EEV_15_22,
      AVal=2.3e-6)        annotation (Placement(transformation(extent={{-8,-18},
              {12,2}})));

    Modelica.Fluid.Sources.Boundary_pT boundary3(
      use_p_in=false,
      redeclare package Medium =
          Media.Refrigerants.R410A_HEoS.R410a_IIR_P1_48_T233_473_Horner,
      nPorts=1,
      p=2400000,
      T=278.15)
      annotation (Placement(transformation(extent={{-116,-18},{-96,2}})));
    Sensors.SpecificEnthalpy senSpeEnt
      annotation (Placement(transformation(extent={{-62,-8},{-42,12}})));
    Modelica.Fluid.Sources.Boundary_ph boundary2(
      h=250000,
      nPorts=1,
      use_h_in=true,
      redeclare package Medium =
          Media.Refrigerants.R410A_HEoS.R410a_IIR_P1_48_T233_473_Horner,
      use_p_in=false,
      p=850000) annotation (Placement(transformation(extent={{64,-18},{44,2}})));
    Modelica.Blocks.Sources.TimeTable timeTable(table=[0,0; 1,1; 2,1])
      annotation (Placement(transformation(extent={{-90,50},{-70,70}})));


  equation
    connect(boundary3.ports[1], senSpeEnt.port) annotation (Line(points={{-96,-8},
            {-52,-8}},                 color={0,127,255}));
    connect(senSpeEnt.port, expansionValveModified.port_a) annotation (Line(
          points={{-52,-8},{-8,-8}},                  color={0,127,255}));
    connect(senSpeEnt.h_out, boundary2.h_in) annotation (Line(points={{-41,2},{
            -16,2},{-16,42},{68,42},{68,-4},{66,-4}},
                                                color={0,0,127}));
    connect(expansionValveModified.port_b, boundary2.ports[1])
      annotation (Line(points={{12,-8},{44,-8}},
                                              color={0,127,255}));
    connect(timeTable.y, expansionValveModified.manVarVal) annotation (Line(
          points={{-69,60},{-12,60},{-12,2.6},{-3,2.6}},   color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
            preserveAspectRatio=false)));
  end AreaExpansionValveModified;

  model ModularExpansionValvesPressureDifference
    Sources.FixedBoundary source(
      use_p=true,
      use_T=true,
      nPorts=1,
      p=pInl,
      T=TInl,
      redeclare package Medium =
          Media.Refrigerants.R410A_HEoS.R410a_IIR_P1_48_T233_340_Formula)
              "Source of constant pressure and temperature"
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-40,70})));
    replaceable ModularExpansionValves.ModularExpansionValvesSensors modVal(
      nVal=nVal,
      redeclare model SimpleExpansionValve =
          SimpleExpansionValves.IsenthalpicExpansionValve,
      show_parVal=false,
      show_parCon=false,
      useInpFil={true,true,true},
      AVal={2e-6,1.5e-6,1e-6},
      risTim={0.25,0.25,0.5},
      useExt=true,
      redeclare model FlowCoefficient =
          Utilities.FlowCoefficient.SpecifiedFlowCoefficients.ConstantFlowCoefficient,
      redeclare model ModularController =
          Controls.HeatPump.ModularHeatPumps.ModularExpansionValveController,
      redeclare package Medium =
          Media.Refrigerants.R410A_HEoS.R410a_IIR_P1_48_T233_340_Formula)
      "Modular expansion valves in parallel" annotation (Placement(transformation(
          extent={{-18,18},{18,-18}},
          rotation=-90,
          origin={-40,0})));
    Interfaces.PortsAThroughPortB portsAThroughPortB(                                   nVal=nVal,
        redeclare package Medium =
          Media.Refrigerants.R410A_HEoS.R410a_IIR_P1_48_T233_340_Formula)
      "Model to connect each valves' outlet pipe with each other"
      annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-40,-40})));
    Sources.FixedBoundary              sink(
      p=pOut,
      T=TOut,
      nPorts=1,
      redeclare package Medium =
          Media.Refrigerants.R410A_HEoS.R410a_IIR_P1_48_T233_340_Formula)
      "Sink of constant pressure and temperature"
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=-90,
          origin={-40,-70})));
    Modelica.Blocks.Routing.Replicator repValOpe(nout=nVal)
      "Replicating the valves' opening signal"
      annotation (Placement(transformation(extent={{40,40},{20,60}})));
    Modelica.Blocks.Sources.Sine valOpe(
      freqHz=1,
      amplitude=0.45,
      offset=0.5)
      "Input signal to prediscribe expansion valve's opening"
      annotation (Placement(transformation(extent={{80,16},{60,36}})));
    Modelica.Blocks.Routing.Replicator repInt(nout=nVal)
      "Replicating the internal set signal"
      annotation (Placement(transformation(extent={{40,-10},{20,10}})));
    Modelica.Blocks.Routing.Replicator repCur(nout=nVal)
      "Replicating the current value of the manipulated variables"
      annotation (Placement(transformation(extent={{40,-60},{20,-40}})));
    Modelica.Blocks.Sources.Ramp ramCur(
      height=0.5,
      offset=0.3,
      duration=1)
      "Ramp to fake current value of the controlled variables"
      annotation (Placement(transformation(extent={{80,-60},{60,-40}})));
    Controls.Interfaces.ModularHeatPumpControlBus dataBus(nVal=nVal)
      "Data bus used to enable communication with dummy signals"
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,0})));
  equation
    connect(source.ports[1],modVal. port_a)
      annotation (Line(points={{-40,60},{-40,18}}, color={0,127,255}));
    connect(modVal.ports_b,portsAThroughPortB. ports_a)
      annotation (Line(points={{-40,-18},{-40,-30}}, color={0,127,255}));
    connect(portsAThroughPortB.port_b,sink. ports[1])
      annotation(Line(points={{-40,-50},{-40,-60}}, color={0,127,255}));
    connect(valOpe.y,repValOpe. u)
      annotation (Line(points={{59,26},{50,26},{50,50},{42,50}}, color={0,0,127}));
    connect(valOpe.y,repInt. u)
      annotation (Line(points={{59,26},{50,26},{50,0},{42,0}}, color={0,0,127}));
    connect(ramCur.y,repCur. u)
      annotation (Line(points={{59,-50},{50,-50},{42,-50}}, color={0,0,127}));
    connect(modVal.dataBus,dataBus)
      annotation (Line(
        points={{-22,0},{0,0}},
        color={255,204,51},
        thickness=0.5));
    connect(repValOpe.y,dataBus. expValBus.extManVarVal)
      annotation (Line(points={{19,50},{10,50},{10,0.05},{-0.05,0.05}},
                  color={0,0,127}));
    connect(repInt.y,dataBus. expValBus.intSetPoiVal)
      annotation (Line(points={{19,0},{10,0},{10,0.05},{-0.05,0.05}},
                  color={0,0,127}));
    connect(repCur.y,dataBus. expValBus.meaConVarVal)
      annotation (Line(points={{19,-50},{10,-50},{10,0.05},{-0.05,0.05}},
                  color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
            preserveAspectRatio=false), graphics={
                                  Text(
            extent={{12,86},{88,74}},
            lineColor={28,108,200},
            textString="Provide dummy signals"), Rectangle(extent={{10,90},{90,70}},
              lineColor={28,108,200})}));
  end ModularExpansionValvesPressureDifference;

  model ModularExpansionValveModifiedsMassFlowRate
    Sources.MassFlowSource_T source(
      redeclare package Medium = Medium,
      T=TInl,
      nPorts=1,
      m_flow=1) "Source of constant mass flow and temperature"
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-40,70})));
    replaceable ModularExpansionValves.ModularExpansionValvesSensors modVal(
      redeclare package Medium = Medium,
      nVal=nVal,
      redeclare model SimpleExpansionValve =
          SimpleExpansionValves.IsenthalpicExpansionValve,
      show_parVal=false,
      show_parCon=false,
      useInpFil={true,true,true},
      AVal={2e-6,1.5e-6,1e-6},
      risTim={0.25,0.25,0.5},
      controllerType={Modelica.Blocks.Types.SimpleController.P,Modelica.Blocks.Types.SimpleController.P,
          Modelica.Blocks.Types.SimpleController.P},
      useExt=true,
      redeclare model FlowCoefficient =
          Utilities.FlowCoefficient.SpecifiedFlowCoefficients.Power_R134a_EEV_15,
      redeclare model ModularController =
          Controls.HeatPump.ModularHeatPumps.ModularExpansionValveController)
      "Modular expansion valves in parallel" annotation (Placement(transformation(
          extent={{-18,18},{18,-18}},
          rotation=-90,
          origin={-40,0})));
    Interfaces.PortsAThroughPortB portsAThroughPortB(redeclare package Medium = Medium, nVal=nVal)
      "Model to connect each valves' outlet pipe with each other"
      annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-40,-40})));
    Sources.FixedBoundary              sink(
      redeclare package Medium = Medium,
      p=pOut,
      T=TOut,
      nPorts=1)
      "Sink of constant pressure and temperature"
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=-90,
          origin={-40,-70})));
    Modelica.Blocks.Routing.Replicator repValOpe(nout=nVal)
      "Replicating the valves' opening signal"
      annotation (Placement(transformation(extent={{40,40},{20,60}})));
    Modelica.Blocks.Sources.Sine valOpe(
      freqHz=1,
      amplitude=0.45,
      offset=0.5)
      "Input signal to prediscribe expansion valve's opening"
      annotation (Placement(transformation(extent={{80,16},{60,36}})));
    Modelica.Blocks.Routing.Replicator repInt(nout=nVal)
      "Replicating the internal set signal"
      annotation (Placement(transformation(extent={{40,-10},{20,10}})));
    Modelica.Blocks.Routing.Replicator repCur(nout=nVal)
      "Replicating the actual value of the manipulated variables"
      annotation (Placement(transformation(extent={{40,-60},{20,-40}})));
    Modelica.Blocks.Sources.Ramp ramCur(
      height=0.5,
      offset=0.3,
      duration=1)
      "Ramp to fake actual value of the controlled variables"
      annotation (Placement(transformation(extent={{80,-60},{60,-40}})));
    Controls.Interfaces.ModularHeatPumpControlBus dataBus(nVal=nVal)
      "Data bus used to enable communication with dummy signals" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,0})));
  equation
    connect(source.ports[1],modVal. port_a)
      annotation (Line(points={{-40,60},{-40,18}}, color={0,127,255}));
    connect(modVal.ports_b,portsAThroughPortB. ports_a)
      annotation (Line(points={{-40,-18},{-40,-30}}, color={0,127,255}));
    connect(portsAThroughPortB.port_b,sink. ports[1])
      annotation(Line(points={{-40,-50},{-40,-60}}, color={0,127,255}));
    connect(valOpe.y,repValOpe. u)
      annotation (Line(points={{59,26},{50,26},{50,50},{42,50}},
                  color={0,0,127}));
    connect(valOpe.y,repInt. u)
      annotation (Line(points={{59,26},{50,26},{50,0},{42,0}}, color={0,0,127}));
    connect(ramCur.y,repCur. u)
      annotation (Line(points={{59,-50},{50,-50},{42,-50}}, color={0,0,127}));
    connect(modVal.dataBus,dataBus)  annotation (Line(
        points={{-22,0},{0,0}},
        color={255,204,51},
        thickness=0.5));
    connect(repValOpe.y,dataBus. expValBus.extManVarVal)
      annotation (Line(points={{19,50},{10,50},{10,0.05},{-0.05,0.05}},
                  color={0,0,127}));
    connect(repInt.y,dataBus. expValBus.intSetPoiVal)
      annotation (Line(points={{19,0},{10,0},{10,0.05},{-0.05,0.05}},
                  color={0,0,127}));
    connect(repCur.y,dataBus. expValBus.meaConVarVal)
      annotation (Line(points={{19,-50},{10,-50},{10,0.05},{-0.05,0.05}},
                  color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
            preserveAspectRatio=false), graphics={
                                  Text(
            extent={{12,86},{88,74}},
            lineColor={28,108,200},
            textString="Provide dummy signals"), Rectangle(extent={{10,90},{90,70}},
              lineColor={28,108,200})}));
  end ModularExpansionValveModifiedsMassFlowRate;

  model StaticHeatPumpBoundaries
    Modelica.Blocks.Sources.CombiTimeTable inpDat(
      extrapolation=Modelica.Blocks.Types.Extrapolation.NoExtrapolation,
      columns=2:7,
      table=[0,64,285.15,5180,308.15,900,5.755555556; 1,64,283.15,4920,308.15,910,5.406593407; 2,63,280.15,
          4370,308.15,930,4.698924731; 3,64,285.15,4980,318.15,1140,4.368421053; 4,64,283.15,4730,318.15,
          1140,4.149122807; 5,55,285.15,4180,328.15,1240,3.370967742; 6,64,283.15,4650,328.15,1380,3.369565217;
          7,63,280.15,4160,318.15,1610,2.583850932; 8,55,275.15,2800,308.15,790,3.544303797; 9,106,258.15,
          3760,308.15,1570,2.394904459; 10,115,266.15,4850,308.15,1940,2.5; 11,55,275.15,2640,318.15,
          960,2.75; 12,111,258.15,4150,318.15,2120,1.95754717; 13,107,270.15,4780,318.15,2210,2.162895928;
          14,113,266.15,4560,318.15,2290,1.991266376; 15,100,266.15,3880,328.15,2240,1.732142857; 16,
          63,275.15,3280,328.15,1330,2.466165414; 17,63,280.15,4080,328.15,1400,2.914285714],
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative)
      "Static boundaries of compressor model"
      annotation (Placement(transformation(extent={{-90,-92},{-70,-72}})));
    Modelica.Blocks.Sources.RealExpression inpSetSpeEnt(y=con.hOut)
      "Expressions describing set point of specific enthalpy"
      annotation (Placement(transformation(extent={{-90,20},{-70,40}})));
    Modelica.Blocks.Sources.RealExpression inpAmbTemp(y=inpDat.y[2])
      "Expressions describing ambient temperature"
      annotation (Placement(transformation(extent={{-90,-24},{-70,-4}})));
    Modelica.Blocks.Sources.RealExpression inpColCap(y=inpDat.y[3] - inpDat.y[5])
      "Expressions describing col capacity"
      annotation (Placement(transformation(extent={{-90,-38},{-70,-18}})));
    Modelica.Blocks.Sources.RealExpression inpHeaCap(y=inpDat.y[3])
      "Expressions describing heat capacity"
      annotation (Placement(transformation(extent={{-90,-52},{-70,-32}})));
    Modelica.Blocks.Sources.RealExpression inpTFlo(y=inpDat.y[4])
      "Expressions describing flow temperature at heat capacity"
      annotation (Placement(transformation(extent={{-90,-66},{-70,-46}})));
    ExpansionValve.StaticHeatPumpBoundaries.StaticEvaporator
                     eva(
      redeclare final package Medium = Medium,
      final dTPin=dTPinEva,
      final dTSupHea=dTSupHea,
      nPorts=nVal)
      "Model that describes a simple static evaporator"
      annotation (Placement(transformation(extent={{-30,-20},{-10,0}})));
    Modelica.Blocks.Continuous.LimPID conPID(
      k=0.001,
      limitsAtInit=true,
      Ti=10,
      controllerType=Modelica.Blocks.Types.SimpleController.P,
      yMax=1,
      yMin=0.05)
      "PID controller to set valves' openings"
      annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
    Modelica.Blocks.Sources.RealExpression inpCurSpeEnt(y=eva.hInl)
      "Expressions describing current specific enthalpy"
      annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
    Modelica.Blocks.Routing.Replicator repMea(nout=nVal)
      "Replicating the current value of the manipulated variables"
      annotation (Placement(transformation(extent={{-30,20},{-10,40}})));
    ModularExpansionValves.ModularExpansionValvesSensors modExpVal(
      redeclare package Medium = Medium,
      nVal=nVal,
      AVal=fill(1.767e-6, nVal),
      useExt=true,
      useInpFil=fill(true, nVal),
      redeclare model FlowCoefficient =
          Utilities.FlowCoefficient.SpecifiedFlowCoefficients.Poly_R22R407CR410A_EEV_15_22,
      risTim=fill(0.01328, nVal),
      redeclare model SimpleExpansionValve =
          SimpleExpansionValves.ExpansionValveModified)
      "Model that describes modular expansion valves in parallel" annotation (
        Placement(transformation(
          extent={{20,20},{-20,-20}},
          rotation=90,
          origin={50,30})));
    ExpansionValve.StaticHeatPumpBoundaries.StaticCondenser
                    con(
      redeclare package Medium = Medium,
      dTSubCool=dTSubCool,
      dTPin=dTPinCond,
      dSec=dSec,
      cpSec=cpSec,
      V_flowSec=V_flowSec)
      "Model that describes a simple static condenser"
      annotation (Placement(transformation(extent={{-30,60},{-10,80}})));
    Controls.Interfaces.ModularHeatPumpControlBus        dataBus(nVal=nVal)
      "Connector that contains all control signals" annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={0,30}),   iconTransformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-98,0})));
  equation
    connect(con.port_b,modExpVal. port_a)
      annotation (Line(points={{-10,70},{50,70},{50,50}}, color={0,127,255}));
    connect(modExpVal.dataBus,dataBus)
      annotation (Line(
        points={{30,30},{30,30},{0,30}},
        color={255,204,51},
        thickness=0.5));
    connect(inpHeaCap.y,con. inpQ_flow)
      annotation (Line(points={{-69,-42},{-69,-42},{86,-42},{86,88},{-18,88},{-18,
            80}},                                      color={0,0,127}));
    connect(inpTFlo.y,con. inpTFlo)
      annotation (Line(points={{-69,-56},{-69,-56},{
            94,-56},{94,94},{-22,94},{-22,80}}, color={0,0,127}));
    connect(repMea.y,dataBus. expValBus.extManVarVal)
      annotation (Line(points={{-9,30},{0.05,30},{0.05,29.95}}, color={0,0,127}));
    connect(inpColCap.y,eva. inpQ_flow)
      annotation (Line(points={{-69,-28},{-69,-28},{-60,-28},{-60,-34},{-16,-34},{
            -16,-20}},        color={0,0,127}));
    connect(inpAmbTemp.y,eva. inpTAmb)
      annotation (Line(points={{-69,-14},{-50,-14},{-50,-28},{-24,-28},
                  {-24,-20}}, color={0,0,127}));
    connect(inpCurSpeEnt.y,conPID. u_m)
      annotation (Line(points={{-69,0},{-50,0},{-50,18}}, color={0,0,127}));
    connect(inpSetSpeEnt.y,conPID. u_s)
      annotation (Line(points={{-69,30},{-66,30},{-62,30}}, color={0,0,127}));
    connect(conPID.y,repMea. u)
      annotation (Line(points={{-39,30},{-35.5,30},{-32,30}}, color={0,0,127}));
    connect(eva.ports_b,modExpVal. ports_b)
      annotation (Line(points={{-10,-10},{2,
            -10},{50,-10},{50,10}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
            preserveAspectRatio=false)));
  end StaticHeatPumpBoundaries;

  model MassFlowRateValveModified
    Sources.FixedBoundary              source(
      use_p=true,
      use_T=true,
      redeclare package Medium =
          Media.Refrigerants.R410A_HEoS.R410a_IIR_P1_48_T233_340_Record,
      p=2400000,
      T=278.15)
      "Source of constant pressure and temperature"
      annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
    Sources.FixedBoundary              sink(
      T=TOut,
      redeclare package Medium =
          Media.Refrigerants.R410A_HEoS.R410a_IIR_P1_48_T233_340_Record,
      p=80000)
      "Sink of constant pressure and temperature"
      annotation (Placement(transformation(extent={{80,-10},{60,10}})));
    SimpleExpansionValves.ExpansionValveModified expansionValveModified(
      m_flow_nominal=0.1,
      Choice=AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.Types.Choice.Bernoullip_th,
      redeclare model MetastabilityCoefficient =
          Utilities.MetastabilityCoefficient.SpecifiedMetastabilityCoefficient.Poly_R410A_16_18_pth,
      redeclare package Medium =
          Media.Refrigerants.R410A_HEoS.R410a_IIR_P1_48_T233_473_Horner,
      redeclare model FlowCoefficient =
          Utilities.FlowCoefficient.SpecifiedFlowCoefficients.Poly_R22R407CR410A_EEV_15_22)
                          annotation (Placement(transformation(extent={{-8,-8},
              {12,12}})));

    Modelica.Blocks.Sources.Constant const
      annotation (Placement(transformation(extent={{-86,46},{-66,66}})));
  equation
    connect(const.y, expansionValveModified.manVarVal) annotation (Line(points=
            {{-65,56},{-34,56},{-34,12.6},{-3,12.6}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end MassFlowRateValveModified;
 annotation (Icon(graphics={
        Polygon(
          points={{0,18},{-40,48},{-40,-12},{0,18}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Polygon(
          points={{0,18},{40,48},{40,-12},{0,18}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Ellipse(
          extent={{-20,82},{20,42}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-20,82},{20,42}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          textString="M",
          textStyle={TextStyle.Bold}),
        Line(
          points={{0,42},{0,18}},
          color={0,0,0},
          thickness=0.5),
        Polygon(
          points={{-48,-50},{-88,-20},{-88,-80},{-48,-50}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Polygon(
          points={{-48,-50},{-8,-20},{-8,-80},{-48,-50}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Polygon(
          points={{48,-50},{8,-20},{8,-80},{48,-50}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Polygon(
          points={{48,-50},{88,-20},{88,-80},{48,-50}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5)}));
end ExpansionValveModified;
