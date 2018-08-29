within AixLib.Controls.HeatPump;
package SecurityControls
  block SecurityControl "Block including all security levels"
    extends BaseClasses.PartialSecurityControl;
    Modelica.Blocks.Sources.BooleanConstant conTru(final k=true)
      "Always true as the two blocks OperationalEnvelope and OnOffControl deal with whether the nSet value is correct or not"
      annotation (Placement(transformation(extent={{58,-6},{70,6}})));
    parameter Boolean useMinRunTime=true
      "False if minimal runtime of HP is not considered"
      annotation (Dialog(group="OnOffControl"));
    parameter Modelica.SIunits.Time minRunTime "Mimimum runtime of heat pump"
      annotation (Dialog(group="OnOffControl",enable=useMinRunTim));
    parameter Boolean useMinLocTime=true
      "False if minimal locktime of HP is not considered"
      annotation (Dialog(group="OnOffControl"));
    parameter Modelica.SIunits.Time minLocTime "Minimum lock time of heat pump"
      annotation (Dialog(group="OnOffControl",enable=useMinLocTim));
    parameter Boolean useRunPerHou=true
      "False if maximal runs per hour HP are not considered"
      annotation (Dialog(group="OnOffControl"));
    parameter Real maxRunPerHou "Maximal number of on/off cycles in one hour"
      annotation (Dialog(group="OnOffControl",enable=useRunPerHour));

    parameter Boolean useOpeEnv=true
      "False to allow HP to run out of operational envelope"
      annotation (Dialog(group="Operational Envelope"));
    parameter Real tableLow[:,2] "Lower boundary of envelope"
      annotation (Dialog(group="Operational Envelope"));
    parameter Real tableUpp[:,2] "Upper boundary of envelope"
      annotation (Dialog(group="Operational Envelope"));
    OperationalEnvelope operationalEnvelope(final useOpeEnv=useOpeEnv,
      final tableLow=tableLow,
      final tableUpp=tableUpp)
      annotation (Placement(transformation(extent={{6,-18},{44,18}})));
    OnOffControl onOffController(
      final minRunTime=minRunTime,
      final minLocTime=minLocTime,
      useMinRunTime=useMinRunTime,
      useMinLocTime=useMinLocTime,
      useRunPerHou=useRunPerHou,
      maxRunPerHou=maxRunPerHou,
      pre_n_start=pre_n_start)
      annotation (Placement(transformation(extent={{-42,-18},{-6,18}})));

    parameter Boolean pre_n_start=true "Start value of pre(n) at initial time"
      annotation (Dialog(group="OnOffControl", descriptionLabel=true),choices(checkBox=true));
    DefrostControl defrostControl(final minIceFac=minIceFac) if
                                     use_deFro
      annotation (Placement(transformation(extent={{-104,-22},{-62,22}})));
    Modelica.Blocks.Routing.RealPassThrough realPasThrDef if not use_deFro
      "No 2. Layer"
      annotation (Placement(transformation(extent={{-92,28},{-76,44}})),
        choicesAllMatching=true);
    parameter Boolean use_deFro
      "True if defrost control should be enabled(only air-source HPs)"
      annotation (Dialog(group="Defrost"));
    parameter Real minIceFac
      "Minimal value above which no defrost is necessary"
      annotation (Dialog(group="Defrost"));
    Modelica.Blocks.Routing.BooleanPassThrough boolPasThrDef if
                                                             not use_deFro
      "No 2. Layer" annotation (Placement(transformation(extent={{-92,-50},{-76,
              -34}})), choicesAllMatching=true);
  equation
    connect(conTru.y,swiErr.u2)
      annotation (Line(points={{70.6,0},{84,0}}, color={255,0,255}));
    connect(onOffController.nOut, operationalEnvelope.nSet) annotation (Line(
          points={{-4.5,0},{0,0},{0,3.6},{3.46667,3.6}},                    color=
           {0,0,127}));

    connect(sigBusHP, onOffController.sigBusHP) annotation (Line(
        points={{-135,-69},{-44.25,-69},{-44.25,-12.42}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(sigBusHP, operationalEnvelope.sigBusHP) annotation (Line(
        points={{-135,-69},{3.625,-69},{3.625,-12.42}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(sigBusHP, defrostControl.sigBusHP) annotation (Line(
        points={{-135,-69},{-105.26,-69},{-105.26,-13.64}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(operationalEnvelope.nOut, swiErr.u1) annotation (Line(points={{45.5833,
            3.6},{50,3.6},{50,16},{78,16},{78,8},{84,8}},
                                                      color={0,0,127}));
    connect(nSet, defrostControl.nSet) annotation (Line(
        points={{-136,20},{-124,20},{-124,4.4},{-107.36,4.4}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(nSet, realPasThrDef.u) annotation (Line(
        points={{-136,20},{-116,20},{-116,36},{-93.6,36}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(realPasThrDef.y, onOffController.nSet) annotation (Line(
        points={{-75.2,36},{-52,36},{-52,0},{-44.4,0}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(operationalEnvelope.modeOut, modeOut) annotation (Line(points={{
            45.5833,-3.6},{50,-3.6},{50,-36},{114,-36},{114,-20},{130,-20}},
          color={255,0,255}));
    connect(modeSet, defrostControl.modeSet) annotation (Line(
        points={{-136,-20},{-120,-20},{-120,-4.4},{-107.36,-4.4}},
        color={255,0,255},
        pattern=LinePattern.Dash));
    connect(defrostControl.nOut1, onOffController.nSet) annotation (Line(
        points={{-59.9,4.4},{-59.9,0},{-44.4,0}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(defrostControl.modeOut, operationalEnvelope.modeSet) annotation (
        Line(
        points={{-59.9,-4.4},{-56,-4.4},{-56,-28},{0,-28},{0,-4},{4,-4},{4,-3.6},
            {3.46667,-3.6}},
        color={255,0,255},
        pattern=LinePattern.Dash));
    connect(modeSet, boolPasThrDef.u) annotation (Line(
        points={{-136,-20},{-120,-20},{-120,-42},{-93.6,-42}},
        color={255,0,255},
        pattern=LinePattern.Dash));
    connect(boolPasThrDef.y, operationalEnvelope.modeSet) annotation (Line(
        points={{-75.2,-42},{-2,-42},{-2,-4},{3.46667,-4},{3.46667,-3.6}},
        color={255,0,255},
        pattern=LinePattern.Dash));
  end SecurityControl;

  block OperationalEnvelope
    "Block which computes an error if the current values are outside of the given operatinal envelope"
    extends BaseClasses.PartialSecurityControl;
    parameter Boolean useOpeEnv
      "False to allow HP to run out of operational envelope";
    BaseClasses.BoundaryMap boundaryMap(final tableLow=tableLow, final tableUpp=
          tableUpp) if                   useOpeEnv
      annotation (Placement(transformation(extent={{-62,-28},{-4,22}})));
    Modelica.Blocks.Sources.BooleanConstant booConOpeEnv(final k=true) if not useOpeEnv
      annotation (Placement(transformation(extent={{10,-36},{24,-22}})));

    parameter Real tableLow[:,2]=[-15,0; 30,0] "Lower boundary of envelope";
    parameter Real tableUpp[:,2]=[-15,55; 5,60; 30,60]
      "Upper boundary of envelope";
    Modelica.Blocks.Math.UnitConversions.To_degC toDegCT_ret_co annotation (
        extent=[-88,38; -76,50], Placement(transformation(extent={{-82,-24},{
              -70,-12}})));
    Modelica.Blocks.Math.UnitConversions.To_degC toDegCT_flow_ev annotation (
        extent=[-88,38; -76,50], Placement(transformation(extent={{-82,6},{-70,
              18}})));
  equation
    connect(boundaryMap.noErr, swiErr.u2) annotation (Line(points={{-1.36364,-3},
            {42,-3},{42,0},{84,0}}, color={255,0,255}));
    connect(nSet,swiErr.u1)  annotation (Line(points={{-136,20},{32,20},{32,8},
            {84,8}},color={0,0,127}));
    connect(booConOpeEnv.y, swiErr.u2) annotation (Line(
        points={{24.7,-29},{24.7,-28},{42,-28},{42,0},{84,0}},
        color={255,0,255},
        pattern=LinePattern.Dash));

    connect(modeSet, modeOut) annotation (Line(points={{-136,-20},{-114,-20},{
            -114,-92},{114,-92},{114,-20},{130,-20}}, color={255,0,255}));
    connect(sigBusHP.T_flow_ev, toDegCT_flow_ev.u) annotation (Line(
        points={{-134.915,-68.925},{-98,-68.925},{-98,12},{-83.2,12}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(boundaryMap.x_in, toDegCT_flow_ev.y)
      annotation (Line(points={{-60.4182,12},{-69.4,12}}, color={0,0,127}));
    connect(boundaryMap.y_in, toDegCT_ret_co.y)
      annotation (Line(points={{-60.4182,-18},{-69.4,-18}}, color={0,0,127}));
    connect(sigBusHP.T_ret_co, toDegCT_ret_co.u) annotation (Line(
        points={{-134.915,-68.925},{-98,-68.925},{-98,-18},{-83.2,-18}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
  end OperationalEnvelope;

  block OnOffControl
    "Controlls if the minimal runtime, stoptime and max. runs per hour are inside given boundaries"

    Modelica.Blocks.Logical.GreaterThreshold
                                    nSetGreaterZero(final threshold=Modelica.Constants.eps)
                                                    "True if device is set on"
      annotation (Placement(transformation(extent={{-110,56},{-94,72}})));
    parameter Boolean useMinRunTime
      "False if minimal runtime of HP is not considered";
    parameter Modelica.SIunits.Time minRunTime(displayUnit="min")
      "Mimimum runtime of heat pump"
      annotation (Dialog(enable=useMinRunTim));
    parameter Boolean useMinLocTime
      "False if minimal locktime of HP is not considered";
    parameter Modelica.SIunits.Time minLocTime(displayUnit="min")
      "Minimum lock time of heat pump"
      annotation (Dialog(enable=useMinLocTim));
    parameter Boolean useRunPerHou
      "False if maximal runs per hour of HP are not considered";
    parameter Real maxRunPerHou "Maximal number of on/off cycles in one hour"
      annotation (Dialog(enable=useRunPerHour));

    Modelica.Blocks.Logical.GreaterThreshold
                                    nIsGreaterZero(final threshold=Modelica.Constants.eps)
      "True if the device is still on"
      annotation (Placement(transformation(extent={{-108,-50},{-92,-34}})));
    Modelica.Blocks.Logical.And andRun
      annotation (Placement(transformation(extent={{18,72},{30,84}})));
    Modelica.Blocks.Logical.Pre pre1(final pre_u_start=pre_n_start)
      annotation (Placement(transformation(extent={{-84,-48},{-72,-36}})));
    BaseClasses.RunPerHouBoundary runPerHouBoundary(final maxRunPer_h=
          maxRunPerHou, final delayTime=3600) if useRunPerHou
      annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
    BaseClasses.TimeControl locTimControl(final minRunTime=minLocTime) if
      useMinLocTime
      annotation (Placement(transformation(extent={{-40,-24},{-20,-4}})));
    Modelica.Blocks.Logical.Not notIsOn
      annotation (Placement(transformation(extent={{-66,-22},{-58,-14}})));
    BaseClasses.TimeControl runTimControl(final minRunTime=minRunTime) if
      useMinRunTime
      annotation (Placement(transformation(extent={{-40,52},{-20,72}})));
    Modelica.Blocks.Logical.And andLoc
      annotation (Placement(transformation(extent={{28,-66},{40,-54}})));

    Modelica.Blocks.Sources.BooleanConstant booleanConstantRunPerHou(final k=true) if not
      useRunPerHou
      annotation (Placement(transformation(extent={{0,-90},{14,-76}})));
    Modelica.Blocks.Sources.BooleanConstant booleanConstantLocTim(final k=true) if not
      useMinLocTime
      annotation (Placement(transformation(extent={{-34,-44},{-20,-30}})));
    Modelica.Blocks.Sources.BooleanConstant booleanConstantRunTim(final k=true) if not
      useMinRunTime
      annotation (Placement(transformation(extent={{-4,52},{10,66}})));
    Modelica.Blocks.Logical.Not notSetOn
      annotation (Placement(transformation(extent={{-66,72},{-56,82}})));
    Modelica.Blocks.Logical.And andTurnOff
      "Check if HP is on and is set to be turned off"
      annotation (Placement(transformation(extent={{-12,80},{0,92}})));
    Modelica.Blocks.Logical.And andTurnOn
      "Check if HP is Off and is set to be turned on"
      annotation (Placement(transformation(extent={{28,-90},{40,-78}})));
    Modelica.Blocks.Logical.And andIsOn
      "Check if both set and actual value are greater zero"
      annotation (Placement(transformation(extent={{16,12},{28,24}})));
    Modelica.Blocks.Interfaces.RealInput nSet
      "Set value relative speed of compressor. Analog from 0 to 1"
      annotation (Placement(transformation(extent={{-152,-16},{-120,16}})));
    Modelica.Blocks.Interfaces.RealOutput nOut
      "Relative speed of compressor. From 0 to 1"
      annotation (Placement(transformation(extent={{120,-10},{140,10}})));
    Controls.Interfaces.HeatPumpControlBus sigBusHP
      annotation (Placement(transformation(extent={{-152,-84},{-118,-54}})));
    Utilities.Logical.SmoothSwitch swinOutnSet
      "If any of the ornSet conditions is true, nSet will be passed. Else nOut will stay the same"
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));
    Modelica.Blocks.MathBoolean.Or orSetN(nu=4)
      "Output is true if nSet value is correct"
      annotation (Placement(transformation(extent={{52,-10},{72,10}})));
    Modelica.Blocks.Logical.And andIsOff
      "Check if both set and actual value are equal to zero"
      annotation (Placement(transformation(extent={{16,32},{28,44}})));
    Modelica.Blocks.Logical.And andLocOff
      annotation (Placement(transformation(extent={{52,-78},{64,-66}})));
    parameter Boolean pre_n_start=true "Start value of pre(n) at initial time";
  equation
    connect(pre1.u,nIsGreaterZero. y)
      annotation (Line(points={{-85.2,-42},{-91.2,-42}},
                                                       color={255,0,255}));
    connect(pre1.y, runPerHouBoundary.u) annotation (Line(points={{-71.4,-42},{-71.4,
            -70},{-42,-70}},         color={255,0,255}));
    connect(pre1.y, notIsOn.u) annotation (Line(points={{-71.4,-42},{-71.4,-28},{-72,
            -28},{-72,-18},{-66.8,-18}}, color={255,0,255}));
    connect(notIsOn.y, locTimControl.u) annotation (Line(points={{-57.6,-18},{-50,
            -18},{-50,-14},{-42,-14}}, color={255,0,255}));
    connect(runTimControl.y, andRun.u2) annotation (Line(points={{-19,62},{-8,62},
            {-8,73.2},{16.8,73.2}},color={255,0,255},
        pattern=LinePattern.Dash));
    connect(runTimControl.u, pre1.y) annotation (Line(points={{-42,62},{-71.4,62},
            {-71.4,-42}},                color={255,0,255}));
    connect(locTimControl.y, andLoc.u1) annotation (Line(points={{-19,-14},{6,-14},
            {6,-60},{26.8,-60}},         color={255,0,255},
        pattern=LinePattern.Dash));
    connect(runPerHouBoundary.y, andLoc.u2) annotation (Line(points={{-19,-70},{6,
            -70},{6,-64.8},{26.8,-64.8}}, color={255,0,255},
        pattern=LinePattern.Dash));
    connect(booleanConstantRunPerHou.y, andLoc.u2) annotation (Line(
        points={{14.7,-83},{16,-83},{16,-64.8},{26.8,-64.8}},
        color={255,0,255},
        pattern=LinePattern.Dash));
    connect(booleanConstantRunTim.y, andRun.u2) annotation (Line(
        points={{10.7,59},{10.7,73.2},{16.8,73.2}},
        color={255,0,255},
        pattern=LinePattern.Dash));

    connect(nSet,nSetGreaterZero. u) annotation (Line(points={{-136,0},{-120,0},{-120,
            64},{-111.6,64}}, color={0,0,127}));
    connect(nSetGreaterZero.y, notSetOn.u) annotation (Line(points={{-93.2,64},{-78,
            64},{-78,77},{-67,77}}, color={255,0,255}));
    connect(pre1.y, andIsOn.u2) annotation (Line(points={{-71.4,-42},{-71.4,12},{-72,
            12},{-72,14},{-42,14},{-42,13.2},{14.8,13.2}},
                                        color={255,0,255}));
    connect(nSetGreaterZero.y, andIsOn.u1) annotation (Line(points={{-93.2,64},{-86,
            64},{-86,18},{14.8,18}},                             color={255,0,255}));
    connect(nOut, nOut)
      annotation (Line(points={{130,0},{130,0}}, color={0,0,127}));
    connect(swinOutnSet.y, nOut)
      annotation (Line(points={{111,0},{130,0}}, color={0,0,127}));
    connect(nSet, swinOutnSet.u1) annotation (Line(points={{-136,0},{-120,0},{-120,
            100},{78,100},{78,8},{88,8}}, color={0,0,127}));
    connect(andTurnOff.y, andRun.u1) annotation (Line(points={{0.6,86},{8,86},{8,78},
            {16.8,78}}, color={255,0,255}));
    connect(orSetN.y, swinOutnSet.u2)
      annotation (Line(points={{73.5,0},{88,0}}, color={255,0,255}));
    connect(notSetOn.y, andIsOff.u1) annotation (Line(points={{-55.5,77},{-50,77},
            {-50,42},{16,42},{16,38},{14.8,38}}, color={255,0,255}));
    connect(andIsOff.y, orSetN.u[1]) annotation (Line(points={{28.6,38},{40,38},{40,
            5.25},{52,5.25}}, color={255,0,255}));
    connect(andIsOn.y, orSetN.u[2]) annotation (Line(points={{28.6,18},{38,18},{38,
            1.75},{52,1.75}}, color={255,0,255}));
    connect(andRun.y, orSetN.u[3]) annotation (Line(points={{30.6,78},{46,78},{46,
            -1.75},{52,-1.75}}, color={255,0,255}));
    connect(andLoc.y, andLocOff.u1) annotation (Line(points={{40.6,-60},{46,-60},{
            46,-72},{50.8,-72}}, color={255,0,255}));
    connect(andTurnOn.y, andLocOff.u2) annotation (Line(points={{40.6,-84},{46,-84},
            {46,-76.8},{50.8,-76.8}}, color={255,0,255}));
    connect(andLocOff.y, orSetN.u[4]) annotation (Line(points={{64.6,-72},{64.6,-32},
            {40,-32},{40,-5.25},{52,-5.25}}, color={255,0,255}));
    connect(notSetOn.y, andTurnOff.u2) annotation (Line(points={{-55.5,77},{-50,77},
            {-50,81.2},{-13.2,81.2}}, color={255,0,255}));
    connect(pre1.y, andTurnOff.u1) annotation (Line(points={{-71.4,-42},{-72,-42},
            {-72,86},{-13.2,86}}, color={255,0,255}));
    connect(nSetGreaterZero.y, andTurnOn.u2) annotation (Line(points={{-93.2,64},{
            -86,64},{-86,-98},{24,-98},{24,-88.8},{26.8,-88.8}}, color={255,0,255}));
    connect(notIsOn.y, andTurnOn.u1) annotation (Line(points={{-57.6,-18},{-56,-18},
            {-56,-96},{22,-96},{22,-84},{26.8,-84}}, color={255,0,255}));
    connect(notIsOn.y, andIsOff.u2) annotation (Line(points={{-57.6,-18},{-56,-18},
            {-56,33.2},{14.8,33.2}}, color={255,0,255}));
    connect(sigBusHP.N,nIsGreaterZero. u) annotation (Line(
        points={{-134.915,-68.925},{-134.915,-42},{-109.6,-42}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(sigBusHP.N, swinOutnSet.u3) annotation (Line(
        points={{-134.915,-68.925},{-134.915,-104},{78,-104},{78,-8},{88,-8}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(booleanConstantLocTim.y, andLoc.u1) annotation (Line(
        points={{-19.3,-37},{6,-37},{6,-60},{26.8,-60}},
        color={255,0,255},
        pattern=LinePattern.Dash));
    annotation (Documentation(info="<html>
<p>Checks if the nSet value is legal by checking if the device can either be turned on or off, depending on which state it was in.</p>
<p>E.g. If it is turned on, and the new nSet value is 0, it will only turn off if current runtime is longer than the minimal runtime. Else it will keep the current rotating speed.</p>
</html>"),
      Diagram(coordinateSystem(extent={{-120,-100},{120,100}})),
      Icon(coordinateSystem(extent={{-120,-100},{120,100}}), graphics={
          Polygon(
            points={{-42,20},{0,62},{-42,20}},
            lineColor={28,108,200},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-48,-26},{48,66}},
            lineColor={0,0,0},
            fillColor={91,91,91},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-36,-14},{36,54}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-60,20},{60,-80}},
            lineColor={0,0,0},
            fillColor={91,91,91},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-10,-30},{10,-70}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-14,-40},{16,-12}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-104,100},{106,76}},
            lineColor={28,108,200},
            lineThickness=0.5,
            fillColor={255,255,255},
            fillPattern=FillPattern.None,
            textString="%name"),
          Rectangle(
            extent={{-120,100},{120,-100}},
            lineColor={28,108,200},
            lineThickness=0.5,
            fillColor={255,255,255},
            fillPattern=FillPattern.None)}));
  end OnOffControl;

  block DefrostControl
    "Control block to ensure no frost limits heat flow at the evaporator"
    Modelica.Blocks.Logical.GreaterEqualThreshold
                                         iceFacGreMin(final threshold=minIceFac)
      "Check if icing factor is greater than a boundary" annotation (Placement(
          transformation(
          extent={{-8,-9},{8,9}},
          rotation=0,
          origin={-3,-62})));
    parameter Real minIceFac "Minimal value above which no defrost is necessary";
    Modelica.Blocks.Interfaces.BooleanInput modeSet "Set value of HP mode"
      annotation (Placement(transformation(extent={{-132,-36},{-100,-4}})));
    Modelica.Blocks.Interfaces.RealInput nSet
      "Set value relative speed of compressor. Analog from 0 to 1"
      annotation (Placement(transformation(extent={{-132,4},{-100,36}})));
    Utilities.Logical.SmoothSwitch        swiErr1
      "If an error occurs, the value of the conZero block will be used(0)"
      annotation (Placement(transformation(extent={{60,-16},{80,4}})));
    Modelica.Blocks.Sources.Constant conOneas(final k=1)
      "If Defrost is enabled, HP runs at full power"
      annotation (Placement(transformation(extent={{20,-30},{32,-18}})));
    Modelica.Blocks.Interfaces.RealOutput nOut1
      "Relative speed of compressor. From 0 to 1"
      annotation (Placement(transformation(extent={{100,10},{120,30}})));
    Modelica.Blocks.Interfaces.BooleanOutput modeOut
      annotation (Placement(transformation(extent={{100,-30},{120,-10}})));
    Controls.Interfaces.HeatPumpControlBus sigBusHP
      annotation (Placement(transformation(extent={{-120,-76},{-92,-48}})));
  equation
    connect(conOneas.y, swiErr1.u3) annotation (Line(points={{32.6,-24},{38,-24},
            {38,-14},{58,-14}}, color={0,0,127}));
    connect(swiErr1.y, nOut1) annotation (Line(points={{81,-6},{96,-6},{96,20},
            {110,20}},
                     color={0,0,127}));
    connect(iceFacGreMin.y, modeOut) annotation (Line(points={{5.8,-62},{60,-62},
            {60,-20},{110,-20}}, color={255,0,255}));
    connect(iceFacGreMin.y, swiErr1.u2)
      annotation (Line(points={{5.8,-62},{5.8,-6},{58,-6}}, color={255,0,255}));
    connect(nSet, swiErr1.u1) annotation (Line(points={{-116,20},{32,20},{32,2},
            {58,2}}, color={0,0,127}));
    connect(sigBusHP.iceFac, iceFacGreMin.u) annotation (Line(
        points={{-105.93,-61.93},{-78,-61.93},{-78,-62},{-12.6,-62}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={28,108,200},
            fillColor={255,255,170},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-36,34},{-36,-6}},
            color={28,108,200}),
          Line(
            points={{0,20},{0,-20}},
            color={28,108,200},
            origin={-36,14},
            rotation=90),
          Line(
            points={{-14,14},{14,-14}},
            color={28,108,200},
            origin={-36,14},
            rotation=90),
          Line(
            points={{14,14},{-14,-14}},
            color={28,108,200},
            origin={-36,14},
            rotation=90),
          Line(
            points={{8,64},{8,24}},
            color={28,108,200}),
          Line(
            points={{0,20},{0,-20}},
            color={28,108,200},
            origin={8,44},
            rotation=90),
          Line(
            points={{-14,14},{14,-14}},
            color={28,108,200},
            origin={8,44},
            rotation=90),
          Line(
            points={{14,14},{-14,-14}},
            color={28,108,200},
            origin={8,44},
            rotation=90),
          Line(
            points={{-34,-22},{-34,-62}},
            color={28,108,200}),
          Line(
            points={{0,20},{0,-20}},
            color={28,108,200},
            origin={-34,-42},
            rotation=90),
          Line(
            points={{-14,14},{14,-14}},
            color={28,108,200},
            origin={-34,-42},
            rotation=90),
          Line(
            points={{14,14},{-14,-14}},
            color={28,108,200},
            origin={-34,-42},
            rotation=90),
          Line(
            points={{14,6},{14,-34}},
            color={28,108,200}),
          Line(
            points={{0,20},{0,-20}},
            color={28,108,200},
            origin={14,-14},
            rotation=90),
          Line(
            points={{-14,14},{14,-14}},
            color={28,108,200},
            origin={14,-14},
            rotation=90),
          Line(
            points={{14,14},{-14,-14}},
            color={28,108,200},
            origin={14,-14},
            rotation=90),
          Text(
            extent={{-104,100},{106,76}},
            lineColor={28,108,200},
            lineThickness=0.5,
            fillColor={255,255,255},
            fillPattern=FillPattern.None,
            textString="%name")}),                                 Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      Documentation(info="<html>
<p>Basic model for a defrost control. The icing factor is calculated in the heat pump based on functions or other models.</p>
<p>If a given lower boundary is surpassed, the mode of the heat pump will be set to false(eq. Chilling) and the compressor speed is set to 1(eq. 100&percnt;) to make the defrost process as fast as possible.</p>
</html>"));
  end DefrostControl;

  package BaseClasses "Package with base classes for AixLib.Controls.HeatPump.SecurityControls"
    block BoundaryMap
      "A function yielding true if input parameters are out of the charasteristic map"
      Modelica.Blocks.Interfaces.BooleanOutput noErr
        "If an error occurs, this will be false"
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
      Modelica.Blocks.Interfaces.RealInput x_in "Current value of x-Axis"
        annotation (Placement(transformation(extent={{-128,46},{-100,74}})));
      Modelica.Blocks.Interfaces.RealInput y_in "Current value on y-Axis"
        annotation (Placement(transformation(extent={{-128,-74},{-100,-46}})));

      Modelica.Blocks.Tables.CombiTable1Ds uppCombiTable1Ds(final table=tableUpp, smoothness=
            Modelica.Blocks.Types.Smoothness.LinearSegments)
        annotation (Placement(transformation(extent={{-52,50},{-32,70}})));
      Modelica.Blocks.Tables.CombiTable1Ds lowCombiTable1Ds(final smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
          table=tableLow)
        annotation (Placement(transformation(extent={{-52,16},{-32,36}})));
      Modelica.Blocks.MathBoolean.Nor
                                 nor1(
                                     nu=4)
        annotation (Placement(transformation(extent={{44,-10},{64,10}})));
      Modelica.Blocks.Logical.Greater greaterLow
        annotation (Placement(transformation(extent={{-6,16},{14,36}})));
      Modelica.Blocks.Logical.Less lessUpp
        annotation (Placement(transformation(extent={{-6,50},{14,70}})));
      Modelica.Blocks.Logical.Less lessLef
        annotation (Placement(transformation(extent={{-6,-40},{14,-20}})));
      Modelica.Blocks.Logical.Greater greaterRig
        annotation (Placement(transformation(extent={{-6,-70},{14,-50}})));
      parameter Real tableLow[:,2]=fill(
          0.0,
          0,
          2) "Table matrix (grid = first column; e.g., table=[0,2])";
      parameter Real tableUpp[:,2]=fill(
          0.0,
          0,
          2) "Table matrix (grid = first column; e.g., table=[0,2])";
      Modelica.Blocks.Sources.Constant conXMin(k=xMin)
        annotation (Placement(transformation(extent={{-50,-46},{-38,-34}})));
      Modelica.Blocks.Sources.Constant conXMax(k=xMax)
        annotation (Placement(transformation(extent={{-50,-76},{-38,-64}})));
    protected
      parameter Real xMax=min(tableLow[end, 1], tableUpp[end, 1])
        "Minimal value of lower and upper table data";
      parameter Real xMin=max(tableLow[1, 1], tableUpp[1, 1])
        "Maximal value of lower and upper table data";
    initial equation
      assert(tableLow[end,1]==tableUpp[end,1],"The boundary values have to the same. For now the value to the safe operational side has been selected.", level = AssertionLevel.error);
      assert(tableLow[1,1]==tableUpp[1,1],"The boundary values have to the same. For now the value to the safe operational side has been selected.", level = AssertionLevel.error);

    equation
      connect(x_in, uppCombiTable1Ds.u)
        annotation (Line(points={{-114,60},{-54,60}}, color={0,0,127}));
      connect(x_in, lowCombiTable1Ds.u) annotation (Line(points={{-114,60},{-72,60},{-72,26},
              {-54,26}}, color={0,0,127}));
      connect(nor1.y, noErr)
        annotation (Line(points={{65.5,0},{110,0}}, color={255,0,255}));
      connect(y_in, greaterLow.u2) annotation (Line(points={{-114,-60},{-20,-60},{-20,18},
              {-8,18}}, color={0,0,127}));
      connect(lowCombiTable1Ds.y[1], greaterLow.u1)
        annotation (Line(points={{-31,26},{-8,26}}, color={0,0,127}));
      connect(y_in, lessUpp.u2) annotation (Line(points={{-114,-60},{-22,-60},{-22,52},{-8,
              52}}, color={0,0,127}));
      connect(uppCombiTable1Ds.y[1], lessUpp.u1)
        annotation (Line(points={{-31,60},{-8,60}}, color={0,0,127}));
      connect(lessUpp.y, nor1.u[1]) annotation (Line(points={{15,60},{32,60},{32,5.25},
              {44,5.25}}, color={255,0,255}));
      connect(greaterLow.y, nor1.u[2]) annotation (Line(points={{15,26},{32,26},{32,
              1.75},{44,1.75}}, color={255,0,255}));
      connect(lessLef.y, nor1.u[3]) annotation (Line(points={{15,-30},{32,-30},{32,
              -1.75},{44,-1.75}}, color={255,0,255}));
      connect(greaterRig.y, nor1.u[4]) annotation (Line(points={{15,-60},{32,-60},
              {32,-5.25},{44,-5.25}}, color={255,0,255}));
      connect(x_in, lessLef.u1) annotation (Line(points={{-114,60},{-72,60},{-72,-30},{-8,
              -30}}, color={0,0,127}));
      connect(x_in, greaterRig.u1) annotation (Line(points={{-114,60},{-72,60},{-72,-60},
              {-8,-60}}, color={0,0,127}));
      connect(conXMax.y, greaterRig.u2) annotation (Line(points={{-37.4,-70},{-22,-70},{-22,
              -68},{-8,-68}}, color={0,0,127}));
      connect(conXMin.y, lessLef.u2) annotation (Line(points={{-37.4,-40},{-24,-40},{-24,
              -38},{-8,-38}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},{100,
                100}}),                                             graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={28,108,200},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-88,74},{-88,-42},{-88,-88},{86,-88},{82,-86},{86,-88},{
                  82,-90}}, color={28,108,200}),
            Line(points={{-88,74},{-90,70},{-88,74},{-86,70}}, color={28,108,200}),
            Line(points={{-74,48},{-74,-60},{-46,-80},{46,-80},{82,-64},{82,42}},
                color={28,108,200}),
            Line(points={{-74,48},{-68,58},{-50,70},{-36,70},{-20,70},{18,70},{46,
                  70},{72,64},{82,42}}, color={28,108,200}),
            Line(points={{-96,74},{-94,70}}, color={28,108,200}),
            Line(points={{-92,74},{-96,66}}, color={28,108,200}),
            Line(points={{84,-92},{88,-98}}, color={28,108,200}),
            Line(points={{88,-92},{84,-98}}, color={28,108,200})}),  Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
        Documentation(info="<html>
<p>Given an input of the x and y-Axis, the block returns true if the given point is outside of the given envelope.</p><p>The maximal and minmal y-value depend on the x-Value and are defined by the upper and lower boundaries in form of 1Ds-Tables. The maximal and minimal x-values are obtained trough the table and are constant.</p>
</html>"));
    end BoundaryMap;

    partial block PartialSecurityControl "Base Block"
      Modelica.Blocks.Interfaces.RealInput nSet
        "Set value relative speed of compressor. Analog from 0 to 1"
        annotation (Placement(transformation(extent={{-152,4},{-120,36}})));
      Modelica.Blocks.Interfaces.RealOutput nOut
        "Relative speed of compressor. From 0 to 1"
        annotation (Placement(transformation(extent={{120,10},{140,30}})));
      AixLib.Utilities.Logical.SmoothSwitch swiErr
        "If an error occurs, the value of the conZero block will be used(0)"
        annotation (Placement(transformation(extent={{86,-10},{106,10}})));
      Modelica.Blocks.Sources.Constant conZer(final k=0)
        "If an error occurs, the compressor speed is set to zero"
        annotation (Placement(transformation(extent={{58,-24},{70,-12}})));
      Controls.Interfaces.HeatPumpControlBus sigBusHP
        annotation (Placement(transformation(extent={{-152,-84},{-118,-54}})));
      Modelica.Blocks.Interfaces.BooleanOutput modeOut
        annotation (Placement(transformation(extent={{120,-30},{140,-10}})));
      Modelica.Blocks.Interfaces.BooleanInput modeSet "Set value of HP mode"
        annotation (Placement(transformation(extent={{-152,-36},{-120,-4}})));
    equation
      connect(conZer.y,swiErr. u3) annotation (Line(points={{70.6,-18},{78,-18},
              {78,-8},{84,-8}}, color={0,0,127}));
      connect(swiErr.y, nOut)
        annotation (Line(points={{107,0},{118,0},{118,20},{130,20}},
                                                   color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{
                -120,-100},{120,100}}), graphics={
            Polygon(
              points={{-42,20},{0,62},{-42,20}},
              lineColor={28,108,200},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-48,-26},{48,66}},
              lineColor={0,0,0},
              fillColor={91,91,91},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-36,-14},{36,54}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-60,20},{60,-80}},
              lineColor={0,0,0},
              fillColor={91,91,91},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-10,-30},{10,-70}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-14,-40},{16,-12}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-104,100},{106,76}},
              lineColor={28,108,200},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.None,
              textString="%name"),
            Rectangle(
              extent={{-120,100},{120,-100}},
              lineColor={28,108,200},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.None)}),
                                         Diagram(coordinateSystem(
              preserveAspectRatio=false, extent={{-120,-100},{120,100}})));
    end PartialSecurityControl;

    block RunPerHouBoundary "Checks if a maximal run per hour value is in boundary"
      extends Modelica.Blocks.Interfaces.BooleanSISO;
      Modelica.Blocks.Logical.Less runCouLesMax
        "Checks if the count of total runs is lower than the maximal value"
        annotation (Placement(transformation(extent={{74,-8},{90,8}})));
      Modelica.Blocks.Sources.Constant inputRunPerHou(final k=maxRunPer_h)
        "Maximal number of on/off cycles in one hour"
        annotation (Placement(transformation(extent={{44,-22},{60,-6}})));
      Modelica.Blocks.MathInteger.TriggeredAdd triggeredAdd
        annotation (Placement(transformation(extent={{-36,6},{-24,-6}})));
      Modelica.Blocks.Sources.IntegerConstant intConPluOne(final k=1)
        "Value for counting"
        annotation (Placement(transformation(extent={{-62,-6},{-50,6}})));
      Modelica.Blocks.Math.IntegerToReal intToReal
        annotation (Placement(transformation(extent={{-14,-6},{-2,6}})));
      Modelica.Blocks.Math.Add sub(k2=-1)
        annotation (Placement(transformation(extent={{44,0},{60,16}})));
      Modelica.Blocks.Nonlinear.FixedDelay fixedDelay(final delayTime(displayUnit=
              "h") = delayTime)
                   annotation (Placement(transformation(extent={{14,-14},{24,-4}})));
      parameter Real maxRunPer_h "Number of maximal on/off cycles per hour";
      parameter Modelica.SIunits.Time delayTime(displayUnit="h") = 3600
        "Delay time of output with respect to input signal";
    equation
      connect(inputRunPerHou.y, runCouLesMax.u2) annotation (Line(points={{60.8,-14},
              {66,-14},{66,-6.4},{72.4,-6.4}}, color={0,0,127}));
      connect(intConPluOne.y, triggeredAdd.u)
        annotation (Line(points={{-49.4,0},{-38.4,0}}, color={255,127,0}));
      connect(intToReal.u, triggeredAdd.y)
        annotation (Line(points={{-15.2,0},{-22.8,0}}, color={255,127,0}));
      connect(intToReal.y, sub.u1) annotation (Line(points={{-1.4,0},{0.15,0},{0.15,
              12.8},{42.4,12.8}}, color={0,0,127}));
      connect(sub.y, runCouLesMax.u1) annotation (Line(points={{60.8,8},{66,8},{66,
              0},{72.4,0}}, color={0,0,127}));
      connect(intToReal.y, fixedDelay.u)
        annotation (Line(points={{-1.4,0},{0,0},{0,-9},{13,-9}}, color={0,0,127}));
      connect(fixedDelay.y, sub.u2) annotation (Line(points={{24.5,-9},{34,-9},{34,3.2},
              {42.4,3.2}}, color={0,0,127}));
      connect(runCouLesMax.y, y)
        annotation (Line(points={{90.8,0},{110,0},{110,0}}, color={255,0,255}));
      connect(u, triggeredAdd.trigger) annotation (Line(points={{-120,0},{-82,0},{
              -82,24},{-33.6,24},{-33.6,7.2}}, color={255,0,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                    Rectangle(
            extent={{-100,-100},{100,100}},
            lineColor={0,0,127},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
            Ellipse(extent={{-80,80},{80,-80}}, lineColor={160,160,164}),
            Line(points={{0,80},{0,60}}, color={160,160,164}),
            Line(points={{80,0},{60,0}}, color={160,160,164}),
            Line(points={{0,-80},{0,-60}}, color={160,160,164}),
            Line(points={{-80,0},{-60,0}}, color={160,160,164}),
            Line(points={{37,70},{26,50}}, color={160,160,164}),
            Line(points={{70,38},{49,26}}, color={160,160,164}),
            Line(points={{71,-37},{52,-27}}, color={160,160,164}),
            Line(points={{39,-70},{29,-51}}, color={160,160,164}),
            Line(points={{-39,-70},{-29,-52}}, color={160,160,164}),
            Line(points={{-71,-37},{-50,-26}}, color={160,160,164}),
            Line(points={{-71,37},{-54,28}}, color={160,160,164}),
            Line(points={{-38,70},{-28,51}}, color={160,160,164}),
            Line(
              points={{0,0},{-50,50}},
              thickness=0.5),
            Line(
              points={{0,0},{40,0}},
              thickness=0.5)}),                                      Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
<p>Everytime the boolean input signal has a rising edge, a counter is triggered and adds 1 to the total sum. This represents an on-turning of a certain device. With a delay this number is being substracted again, as this block counts the number of rising edges in a given amount of time(e.g. 1 hour). If this value is higher than a given maximal value, the output turns to false.</p>
</html>"));
    end RunPerHouBoundary;

    block TimeControl
      "Counts seconds a device is turned on and returns true if the time is inside given boundaries"
      extends Modelica.Blocks.Interfaces.BooleanSISO;
      Modelica.Blocks.Logical.Timer runTim
        "Counts the seconds the heat pump is locked still"
        annotation (Placement(transformation(extent={{-22,-8},{-6,8}})));
      Modelica.Blocks.Logical.GreaterEqualThreshold
                                           runTimGreaterMin(final threshold=
            minRunTime)
        "Checks if the runtime is greater than the minimal runtime"
        annotation (Placement(transformation(extent={{22,-8},{36,8}})));
      parameter Modelica.SIunits.Time minRunTime
        "Minimal time the device is turned on or off";
    equation
      connect(runTimGreaterMin.y, y)
        annotation (Line(points={{36.7,0},{110,0}}, color={255,0,255}));
      connect(u,runTim. u) annotation (Line(points={{-120,0},{-23.6,0}},
                          color={255,0,255}));
      connect(runTim.y, runTimGreaterMin.u)
        annotation (Line(points={{-5.2,0},{20.6,0}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                    Rectangle(
            extent={{-100,-100},{100,100}},
            lineColor={0,0,127},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
            Ellipse(extent={{-80,80},{80,-80}}, lineColor={160,160,164}),
            Line(points={{0,80},{0,60}}, color={160,160,164}),
            Line(points={{80,0},{60,0}}, color={160,160,164}),
            Line(points={{0,-80},{0,-60}}, color={160,160,164}),
            Line(points={{-80,0},{-60,0}}, color={160,160,164}),
            Line(points={{37,70},{26,50}}, color={160,160,164}),
            Line(points={{70,38},{49,26}}, color={160,160,164}),
            Line(points={{71,-37},{52,-27}}, color={160,160,164}),
            Line(points={{39,-70},{29,-51}}, color={160,160,164}),
            Line(points={{-39,-70},{-29,-52}}, color={160,160,164}),
            Line(points={{-71,-37},{-50,-26}}, color={160,160,164}),
            Line(points={{-71,37},{-54,28}}, color={160,160,164}),
            Line(points={{-38,70},{-28,51}}, color={160,160,164}),
            Line(
              points={{0,0},{-50,50}},
              thickness=0.5),
            Line(
              points={{0,0},{40,0}},
              thickness=0.5)}),                                      Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
<p>When the input is true, a timer thats counting seconds until it is false again. As long as the counted time is smaller than a given minimal time, the block yields false.</p><p>This block is used to validate a mimimal run- or loctime of a device.</p>
</html>"));
    end TimeControl;
  end BaseClasses;
end SecurityControls;
