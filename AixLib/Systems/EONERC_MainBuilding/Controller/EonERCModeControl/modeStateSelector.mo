within AixLib.Systems.EONERC_MainBuilding.Controller.EonERCModeControl;
model modeStateSelector "Selects sub modes for heating and cooling"
  Modelica.Blocks.Interfaces.RealInput T_HS[2]
    "Connector of Real input signals" annotation (Placement(transformation(
          extent={{-140,40},{-100,80}}), iconTransformation(extent={{-136,42},{-100,
            78}})));
  Modelica.Blocks.Interfaces.RealInput T_CS[2]
    "Connector of Real input signals" annotation (Placement(transformation(
          extent={{-140,-80},{-100,-40}}), iconTransformation(extent={{-136,-78},
            {-100,-42}})));

  Modelica.Blocks.Interfaces.IntegerOutput modeSWU annotation (Placement(
        transformation(extent={{100,-90},{120,-70}}),iconTransformation(extent={{100,-90},
            {120,-70}})));
  Modelica.Blocks.Interfaces.RealInput T_air "Connector of Real input signals"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-40,-120}), iconTransformation(extent={{-18,-18},{18,18}},
        rotation=90,
        origin={40,-118})));
  Modelica.Blocks.Interfaces.RealInput T_geo "Connector of Real input signals"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={40,-120}), iconTransformation(extent={{-18,-18},{18,18}},
        rotation=90,
        origin={-40,-118})));
  Modelica.Blocks.Interfaces.BooleanOutput useHP
    "Connector of Boolean output signal" annotation (Placement(transformation(
          extent={{100,70},{120,90}}), iconTransformation(extent={{100,70},{120,
            90}})));
  Modelica.Blocks.Interfaces.BooleanOutput freeCoolingGC
    "Connector of Boolean output signal" annotation (Placement(transformation(
          extent={{100,30},{120,50}}), iconTransformation(extent={{100,-10},{120,
            10}})));
  Modelica.Blocks.Interfaces.BooleanOutput reCoolingGC
    "Connector of Boolean output signal" annotation (Placement(transformation(
          extent={{100,-10},{120,10}}), iconTransformation(extent={{100,30},{120,
            50}})));
  Modelica.Blocks.Interfaces.BooleanOutput useGTF
    "Connector of Boolean output signal" annotation (Placement(transformation(
          extent={{100,-50},{120,-30}}),
                                       iconTransformation(extent={{100,-50},{120,
            -30}})));
  Integer case "Operation case according to Fuetterer for debugging";

  Modelica.Blocks.Interfaces.BooleanOutput heatingMode
    "Connector of Boolean output signal" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={80,110}), iconTransformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,110})));

  Real dT_HS "Energy change of heat storage";
  Real dT_CS "Energy change of cold storage";
  Boolean heatingModeInt "Internal variable for heating mode";
  Modelica.Blocks.Interfaces.BooleanInput hpOn
    "Connector of Boolean input signal" annotation (Placement(transformation(
          extent={{-140,-20},{-100,20}}), iconTransformation(extent={{-136,-18},
            {-100,18}})));
  Modelica.Blocks.Continuous.Integrator int_HS(use_reset = true);
  Modelica.Blocks.Continuous.Integrator int_CS(use_reset = true);
  Modelica.StateGraph.InitialStepWithSignal demandEstimation(nOut=1, nIn=1)
    annotation (Placement(transformation(extent={{-90,-8},{-74,8}})));
  Modelica.StateGraph.Transition tran(enableTimer=true, waitTime=
        waitTimeEstimation)
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=0,
        origin={-62,0})));
  Modelica.StateGraph.StepWithSignal mode1(nIn=1, nOut=1)
                                           "To reset integrator"
    annotation (Placement(transformation(extent={{36,80},{48,92}})));
  Modelica.StateGraph.Alternative alternative(nBranches=8)
    annotation (Placement(transformation(extent={{-28,-100},{76,100}})));
  Modelica.StateGraph.TransitionWithSignal tran1
    annotation (Placement(transformation(extent={{10,80},{22,92}})));
  Modelica.StateGraph.TransitionWithSignal tran2
    annotation (Placement(transformation(extent={{10,60},{22,72}})));
  Modelica.StateGraph.StepWithSignal mode2(nIn=1, nOut=1)
                                           "To reset integrator"
    annotation (Placement(transformation(extent={{36,60},{48,72}})));
  Modelica.StateGraph.TransitionWithSignal tran3
    annotation (Placement(transformation(extent={{10,40},{22,52}})));
  Modelica.StateGraph.StepWithSignal mode3(nIn=1, nOut=1)
                                           "To reset integrator"
    annotation (Placement(transformation(extent={{36,40},{48,52}})));
  Modelica.StateGraph.TransitionWithSignal tran4
    annotation (Placement(transformation(extent={{10,20},{22,32}})));
  Modelica.StateGraph.StepWithSignal mode4(nIn=1, nOut=1)
                                           "To reset integrator"
    annotation (Placement(transformation(extent={{36,20},{48,32}})));
  Modelica.StateGraph.TransitionWithSignal tran5
    annotation (Placement(transformation(extent={{10,0},{22,12}})));
  Modelica.StateGraph.StepWithSignal mode5(nIn=1, nOut=1)
                                           "To reset integrator"
    annotation (Placement(transformation(extent={{36,0},{48,12}})));
  Modelica.StateGraph.TransitionWithSignal tran6
    annotation (Placement(transformation(extent={{10,-20},{22,-8}})));
  Modelica.StateGraph.StepWithSignal mode6(nIn=1, nOut=1)
                                           "To reset integrator"
    annotation (Placement(transformation(extent={{36,-20},{48,-8}})));
  Modelica.StateGraph.TransitionWithSignal tran7
    annotation (Placement(transformation(extent={{10,-40},{22,-28}})));
  Modelica.StateGraph.StepWithSignal mode7(nIn=1, nOut=1)
                                           "To reset integrator"
    annotation (Placement(transformation(extent={{36,-40},{48,-28}})));
  Modelica.StateGraph.TransitionWithSignal tran8
    annotation (Placement(transformation(extent={{10,-60},{22,-48}})));
  Modelica.StateGraph.StepWithSignal mode8(nIn=1, nOut=1)
                                           "To reset integrator"
    annotation (Placement(transformation(extent={{36,-60},{48,-48}})));
  Modelica.Blocks.Sources.BooleanExpression hpOnly(y=heatingModeInt and T_CS[1] >
        273.15 + 12)
               annotation (Placement(transformation(extent={{-14,68},{6,86}})));
  Modelica.Blocks.Sources.BooleanExpression HPandGTF(y=heatingModeInt and T_CS[1] <
        273.15 + 12)
    annotation (Placement(transformation(extent={{-14,48},{6,66}})));
  Modelica.Blocks.Sources.BooleanExpression GC_only(y=not heatingModeInt and
        T_air < 10 + 273.15 and T_air > 273.15)
    annotation (Placement(transformation(extent={{-14,28},{6,46}})));
  Modelica.Blocks.Sources.BooleanExpression GTF_only(y=not heatingModeInt and
        T_geo < 12 + 273.15)
    annotation (Placement(transformation(extent={{-14,8},{6,26}})));
  Modelica.Blocks.Sources.BooleanExpression GTF_and_HP(y=not heatingModeInt
         and T_geo < 17 + 273.15 and T_geo > 12 + 273.15 and 0.5*(T_HS[1] +
        T_HS[2]) < 273.15 + 33)
    annotation (Placement(transformation(extent={{-14,-12},{6,6}})));
  Modelica.Blocks.Sources.BooleanExpression GTF_HP_ReCooler(y=not
        heatingModeInt and T_geo > 12 + 273.15 and T_geo < 17 + 273.15 and 0.5*(
        T_HS[1] + T_HS[2]) > 273.15 + 33 and T_air > 274)
    annotation (Placement(transformation(extent={{-14,-32},{6,-14}})));
  Modelica.Blocks.Sources.BooleanExpression HP(y=not heatingModeInt and T_geo >
        17 + 273.15 and 0.5*(T_HS[1] + T_HS[2]) < 273.15 + 33)
    annotation (Placement(transformation(extent={{-14,-52},{6,-34}})));
  Modelica.Blocks.Sources.BooleanExpression HP_reCooler(y=not heatingModeInt
         and T_geo > 17 + 273.15 and 0.5*(T_HS[1] + T_HS[2]) > 273.15 + 33 and
        T_air > 274.15)
    annotation (Placement(transformation(extent={{-14,-72},{6,-54}})));
  Modelica.StateGraph.Transition tran9(enableTimer=true, waitTime=
        timeModeActive)
    annotation (Placement(transformation(extent={{50,80},{62,92}})));
  Modelica.StateGraph.Transition tran10(enableTimer=true, waitTime=
        timeModeActive)
    annotation (Placement(transformation(extent={{50,60},{62,72}})));
  Modelica.StateGraph.Transition tran11(enableTimer=true, waitTime=
        timeModeActive)
    annotation (Placement(transformation(extent={{50,40},{62,52}})));
  Modelica.StateGraph.Transition tran12(enableTimer=true, waitTime=
        timeModeActive)
    annotation (Placement(transformation(extent={{50,20},{62,32}})));
  Modelica.StateGraph.Transition tran13(enableTimer=true, waitTime=
        timeModeActive)
    annotation (Placement(transformation(extent={{50,0},{62,12}})));
  Modelica.StateGraph.Transition tran14(enableTimer=true, waitTime=
        timeModeActive)
    annotation (Placement(transformation(extent={{50,-20},{62,-8}})));
  Modelica.StateGraph.Transition tran15(enableTimer=true, waitTime=
        timeModeActive)
    annotation (Placement(transformation(extent={{50,-40},{62,-28}})));
  Modelica.StateGraph.Transition tran16(enableTimer=true, waitTime=
        timeModeActive)
    annotation (Placement(transformation(extent={{50,-60},{62,-48}})));
  Modelica.StateGraph.Step step(nIn=1, nOut=1)
    annotation (Placement(transformation(extent={{-52,-8},{-36,8}})));
  parameter Modelica.Units.SI.Time waitTimeEstimation=300
    "Wait time for demand estaimation";
  parameter Modelica.Units.SI.Time timeModeActive=1800
    "Time before mode estimation in which one mode is active";
equation
//determine heating or cooling mode

  dT_HS = 0.5*der(T_HS[1] + T_HS[2])*4000;
  dT_CS = 0.5*der(T_CS[1] + T_CS[2])*5000;

  if hpOn then
    int_HS.u = 0;
    int_CS.u = 0;
  else
    int_HS.u = abs(dT_HS);
    int_CS.u = abs(dT_CS);
  end if;

  //reset integrator after
  if demandEstimation.active then
                                // or mode2.active or mode3.active or mode4.active or mode5.active or mode6.active or mode7.active or mode8.active then
    int_HS.reset = true;
    int_CS.reset = true;
  else
    int_HS.reset = false;
    int_CS.reset = false;
  end if;

  if int_HS.y < int_CS.y and 0.5*(T_HS[1] + T_HS[2])>273.15+29 then
    heatingModeInt = false;
  else
    heatingModeInt = true;
  end if;


//heating modes
  //HP only
  if mode1.active then
    modeSWU = 4;
    useHP = true;
    freeCoolingGC = false;
    reCoolingGC = false;
    useGTF = false;
    heatingMode = true;
    case = 1;
  //HP + GTF
  elseif mode2.active then
    modeSWU = 1;
    useHP = true;
    freeCoolingGC = false;
    reCoolingGC = false;
    useGTF = true;
    heatingMode = true;
    case = 2;
//cooling modes
  //free cooling glycol cooler only
  elseif mode3.active then
    modeSWU = 4;
    useHP = false;
    freeCoolingGC = true;
    reCoolingGC = false;
    useGTF = false;
    heatingMode = false;
    case = 3;
  //all cooling by gtf
  elseif mode4.active then
    modeSWU = 5;
    useHP = false;
    freeCoolingGC = false;
    reCoolingGC = false;
    useGTF = true;
    heatingMode = false;
    case = 4;
  //gtf for cca, cooling network by HP
  elseif mode5.active then
    modeSWU = 3;
    useHP = true;
    freeCoolingGC = false;
    reCoolingGC = false;
    useGTF = true;
    heatingMode = false;
    case = 5;
  //gtf for cca, cooling network by HP and recooler
  elseif mode6.active then
    modeSWU = 3;
    useHP = true;
    freeCoolingGC = false;
    reCoolingGC = true;
    useGTF = true;
    heatingMode = false;
    case = 6;
  // cooling network by HP
  elseif mode7.active then
    modeSWU = 4;
    useHP = true;
    freeCoolingGC = false;
    reCoolingGC = false;
    useGTF = false;
    heatingMode = false;
    case = 7;
  elseif mode8.active then
    modeSWU = 4;
    useHP = true;
    freeCoolingGC = false;
    reCoolingGC = true;
    useGTF = false;
    heatingMode = false;
    case = 8;
  elseif demandEstimation.active then
    modeSWU = 4;
    useHP = false;
    freeCoolingGC = false;
    reCoolingGC = false;
    useGTF = false;
    heatingMode = false;
    case = 0;
  else
    modeSWU = 4;
    useHP = true;
    freeCoolingGC = false;
    reCoolingGC = false;
    useGTF = false;
    heatingMode = true;
    case = -1;
  end if;

  connect(hpOnly.y, tran1.condition) annotation (Line(points={{7,77},{8,77},{8,78.8},
          {16,78.8}},      color={255,0,255}));
  connect(tran2.condition, HPandGTF.y) annotation (Line(points={{16,58.8},{12,58.8},
          {12,57},{7,57}}, color={255,0,255}));
  connect(tran3.condition, GC_only.y) annotation (Line(points={{16,38.8},{12,38.8},
          {12,37},{7,37}}, color={255,0,255}));
  connect(tran4.condition, GTF_only.y) annotation (Line(points={{16,18.8},{12,18.8},
          {12,17},{7,17}}, color={255,0,255}));
  connect(tran5.condition, GTF_and_HP.y) annotation (Line(points={{16,-1.2},{12,
          -1.2},{12,-3},{7,-3}},
                           color={255,0,255}));
  connect(tran6.condition, GTF_HP_ReCooler.y) annotation (Line(points={{16,-21.2},
          {12,-21.2},{12,-23},{7,-23}},color={255,0,255}));
  connect(tran7.condition, HP.y) annotation (Line(points={{16,-41.2},{12,-41.2},
          {12,-43},{7,-43}},
                          color={255,0,255}));
  connect(tran8.condition, HP_reCooler.y) annotation (Line(points={{16,-61.2},{12,
          -61.2},{12,-63},{7,-63}}, color={255,0,255}));
  connect(tran1.inPort, alternative.split[1]) annotation (Line(points={{13.6,86},
          {-18,86},{-18,-43.75},{-17.08,-43.75}},
                                              color={0,0,0}));
  connect(tran2.inPort, alternative.split[2]) annotation (Line(points={{13.6,66},
          {-18,66},{-18,-31.25},{-17.08,-31.25}},
                                              color={0,0,0}));
  connect(tran3.inPort, alternative.split[3]) annotation (Line(points={{13.6,46},
          {-18,46},{-18,-18.75},{-17.08,-18.75}},
                                              color={0,0,0}));
  connect(tran4.inPort, alternative.split[4]) annotation (Line(points={{13.6,26},
          {-18,26},{-18,-6.25},{-17.08,-6.25}},
                                              color={0,0,0}));
  connect(tran5.inPort, alternative.split[5]) annotation (Line(points={{13.6,6},
          {-18,6},{-18,6.25},{-17.08,6.25}},   color={0,0,0}));
  connect(tran6.inPort, alternative.split[6]) annotation (Line(points={{13.6,-14},
          {-18,-14},{-18,18.75},{-17.08,18.75}}, color={0,0,0}));
  connect(tran7.inPort, alternative.split[7]) annotation (Line(points={{13.6,-34},
          {-18,-34},{-18,31.25},{-17.08,31.25}}, color={0,0,0}));
  connect(tran8.inPort, alternative.split[8]) annotation (Line(points={{13.6,-54},
          {-18,-54},{-18,43.75},{-17.08,43.75}}, color={0,0,0}));
  connect(tran9.outPort, alternative.join[1]) annotation (Line(points={{56.9,86},
          {62,86},{62,-43.75},{65.08,-43.75}},
                                           color={0,0,0}));
  connect(tran10.outPort, alternative.join[2]) annotation (Line(points={{56.9,66},
          {60,66},{60,-31.25},{65.08,-31.25}},
                                           color={0,0,0}));
  connect(tran11.outPort, alternative.join[3]) annotation (Line(points={{56.9,46},
          {60,46},{60,-18.75},{65.08,-18.75}},
                                           color={0,0,0}));
  connect(tran12.outPort, alternative.join[4]) annotation (Line(points={{56.9,26},
          {62,26},{62,-6.25},{65.08,-6.25}},
                                           color={0,0,0}));
  connect(tran13.outPort, alternative.join[5]) annotation (Line(points={{56.9,6},
          {60,6},{60,6.25},{65.08,6.25}},   color={0,0,0}));
  connect(tran14.outPort, alternative.join[6]) annotation (Line(points={{56.9,-14},
          {60,-14},{60,18.75},{65.08,18.75}}, color={0,0,0}));
  connect(tran15.outPort, alternative.join[7]) annotation (Line(points={{56.9,-34},
          {60,-34},{60,31.25},{65.08,31.25}}, color={0,0,0}));
  connect(tran16.outPort, alternative.join[8]) annotation (Line(points={{56.9,-54},
          {60,-54},{60,43.75},{65.08,43.75}}, color={0,0,0}));
  connect(tran1.outPort, mode1.inPort[1])
    annotation (Line(points={{16.9,86},{35.4,86}}, color={0,0,0}));
  connect(tran2.outPort, mode2.inPort[1])
    annotation (Line(points={{16.9,66},{35.4,66}}, color={0,0,0}));
  connect(tran3.outPort, mode3.inPort[1])
    annotation (Line(points={{16.9,46},{35.4,46}}, color={0,0,0}));
  connect(tran4.outPort, mode4.inPort[1])
    annotation (Line(points={{16.9,26},{35.4,26}}, color={0,0,0}));
  connect(tran5.outPort, mode5.inPort[1])
    annotation (Line(points={{16.9,6},{35.4,6}}, color={0,0,0}));
  connect(tran6.outPort, mode6.inPort[1])
    annotation (Line(points={{16.9,-14},{35.4,-14}}, color={0,0,0}));
  connect(tran7.outPort, mode7.inPort[1])
    annotation (Line(points={{16.9,-34},{35.4,-34}}, color={0,0,0}));
  connect(tran8.outPort, mode8.inPort[1])
    annotation (Line(points={{16.9,-54},{35.4,-54}}, color={0,0,0}));
  connect(mode2.outPort[1], tran10.inPort)
    annotation (Line(points={{48.3,66},{53.6,66}}, color={0,0,0}));
  connect(mode3.outPort[1], tran11.inPort)
    annotation (Line(points={{48.3,46},{53.6,46}}, color={0,0,0}));
  connect(mode4.outPort[1], tran12.inPort)
    annotation (Line(points={{48.3,26},{53.6,26}}, color={0,0,0}));
  connect(mode5.outPort[1], tran13.inPort)
    annotation (Line(points={{48.3,6},{53.6,6}}, color={0,0,0}));
  connect(mode6.outPort[1], tran14.inPort)
    annotation (Line(points={{48.3,-14},{53.6,-14}}, color={0,0,0}));
  connect(mode7.outPort[1], tran15.inPort)
    annotation (Line(points={{48.3,-34},{53.6,-34}}, color={0,0,0}));
  connect(mode8.outPort[1], tran16.inPort)
    annotation (Line(points={{48.3,-54},{53.6,-54}}, color={0,0,0}));
  connect(mode1.outPort[1], tran9.inPort)
    annotation (Line(points={{48.3,86},{53.6,86}}, color={0,0,0}));
  connect(demandEstimation.outPort[1], tran.inPort)
    annotation (Line(points={{-73.6,0},{-65.2,0}}, color={0,0,0}));
  connect(tran.outPort, step.inPort[1])
    annotation (Line(points={{-60.8,0},{-52.8,0}}, color={0,0,0}));
  connect(step.outPort[1], alternative.inPort)
    annotation (Line(points={{-35.6,0},{-29.56,0}}, color={0,0,0}));
  connect(alternative.outPort, demandEstimation.inPort[1]) annotation (Line(
        points={{77.04,0},{84,0},{84,110},{-96,110},{-96,0},{-90.8,0}}, color={
          0,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-100,100},{-38,0},{-100,-100}},
          color={95,95,95},
          thickness=0.5),
          Text(
          extent={{-48,24},{98,-16}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Control")}),                               Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-96,-20},{-24,-54}},
          lineColor={0,0,0},
          pattern=LinePattern.Dash,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="Outputs calculated in text code")}));
end modeStateSelector;
