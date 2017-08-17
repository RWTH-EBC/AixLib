within AixLib.Airflow.AirHandlingUnit.BaseClasses;
package Minimal_example_StateGraph
  extends Modelica.Icons.Package;
  model StateGraph_Ebene1 "Beispiel fuer Ebene 1"
    Modelica.StateGraph.TransitionWithSignal Kuehlen_anschalten
      annotation (Placement(transformation(extent={{30,70},{50,90}})));
    Modelica.StateGraph.InitialStepWithSignal Drift_HK(nIn=2, nOut=2)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,50})));
    Modelica.StateGraph.TransitionWithSignal Heizen_einschalten
      annotation (Placement(transformation(extent={{-30,70},{-50,90}})));
    Modelica.StateGraph.TransitionWithSignal Heizen_ausschalten
      annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
    Modelica.StateGraph.TransitionWithSignal Kuehlen_abschalten
      annotation (Placement(transformation(extent={{50,10},{30,30}})));
    Modelica.StateGraph.StepWithSignal Heizen annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={-70,50})));
    Modelica.StateGraph.StepWithSignal Kuehlen annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={70,50})));
    Auswertung_Temperaturen auswertung_Temperaturen(T_h=3)
      annotation (Placement(transformation(extent={{-84,-24},{-64,-4}})));
    Modelica.Blocks.Interfaces.RealInput T_in1
                                              "Eingangstemperatur"
      annotation (Placement(transformation(extent={{-126,-18},{-86,22}})));
    Modelica.Blocks.Interfaces.BooleanOutput Drift_Out
      annotation (Placement(transformation(extent={{96,62},{116,82}})));
    Modelica.Blocks.Interfaces.BooleanOutput Heizen_Out
      annotation (Placement(transformation(extent={{96,-10},{116,10}})));
    Modelica.Blocks.Interfaces.BooleanOutput Kuehlen_Out
      annotation (Placement(transformation(extent={{96,-72},{116,-52}})));
  equation

    connect(Drift_HK.outPort[2], Heizen_einschalten.inPort) annotation (Line(
          points={{0.25,60.5},{0.25,80},{-36,80}}, color={0,0,0}));
    connect(Drift_HK.outPort[1], Kuehlen_anschalten.inPort) annotation (Line(
          points={{-0.25,60.5},{-0.25,80},{36,80}}, color={0,0,0}));
    connect(Kuehlen_anschalten.outPort, Kuehlen.inPort[1])
      annotation (Line(points={{41.5,80},{70,80},{70,61}}, color={0,0,0}));
    connect(Kuehlen.outPort[1], Kuehlen_abschalten.inPort)
      annotation (Line(points={{70,39.5},{70,20},{44,20}}, color={0,0,0}));
    connect(Kuehlen_abschalten.outPort, Drift_HK.inPort[1])
      annotation (Line(points={{38.5,20},{-0.5,20},{-0.5,39}}, color={0,0,0}));
    connect(Heizen_ausschalten.outPort, Drift_HK.inPort[2])
      annotation (Line(points={{-38.5,20},{0.5,20},{0.5,39}}, color={0,0,0}));
    connect(Heizen_einschalten.outPort, Heizen.inPort[1])
      annotation (Line(points={{-41.5,80},{-70,80},{-70,61}}, color={0,0,0}));
    connect(Heizen.outPort[1], Heizen_ausschalten.inPort)
      annotation (Line(points={{-70,39.5},{-70,20},{-44,20}}, color={0,0,0}));
    connect(auswertung_Temperaturen.H_ein, Heizen_einschalten.condition)
      annotation (Line(points={{-63.4,-8},{-52,-8},{-52,68},{-40,68}}, color={
            255,0,255}));
    connect(auswertung_Temperaturen.H_aus, Heizen_ausschalten.condition)
      annotation (Line(points={{-63.4,-12},{-52,-12},{-52,8},{-40,8}}, color={
            255,0,255}));
    connect(auswertung_Temperaturen.K_ein, Kuehlen_anschalten.condition)
      annotation (Line(points={{-63.4,-16},{-12,-16},{-12,68},{40,68}}, color={
            255,0,255}));
    connect(auswertung_Temperaturen.K_aus, Kuehlen_abschalten.condition)
      annotation (Line(points={{-63.4,-20},{-12,-20},{-12,8},{40,8}}, color={
            255,0,255}));
    connect(auswertung_Temperaturen.T_in, T_in1) annotation (Line(points={{
            -84.8,-14},{-96,-14},{-96,2},{-106,2}}, color={0,0,127}));
    connect(Drift_HK.active, Drift_Out) annotation (Line(points={{11,50},{48,50},
            {48,72},{106,72}}, color={255,0,255}));
    connect(Heizen.active, Heizen_Out) annotation (Line(points={{-59,50},{-54,
            50},{-54,98},{92,98},{92,0},{106,0}}, color={255,0,255}));
    connect(Kuehlen.active, Kuehlen_Out) annotation (Line(points={{59,50},{60,
            50},{60,-62},{106,-62}}, color={255,0,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end StateGraph_Ebene1;

  model Auswertung_Temperaturen
    "Block zur Auswertung der Temperaturdaten"
    parameter Real T_h = 3;
    parameter Real T_soll = 20;

    Modelica.Blocks.Interfaces.RealInput T_in "Eingangstemperatur"
      annotation (Placement(transformation(extent={{-128,-20},{-88,20}})));
    Modelica.Blocks.Interfaces.BooleanOutput H_ein "Heizen einschalten"
      annotation (Placement(transformation(extent={{96,50},{116,70}})));
    Modelica.Blocks.Interfaces.BooleanOutput H_aus "Heizen ausschalten"
      annotation (Placement(transformation(extent={{96,10},{116,30}})));
    Modelica.Blocks.Interfaces.BooleanOutput K_ein "Kuehlen einschalten"
      annotation (Placement(transformation(extent={{96,-30},{116,-10}})));
    Modelica.Blocks.Interfaces.BooleanOutput K_aus "Kuehlen ausschalten"
      annotation (Placement(transformation(extent={{96,-70},{116,-50}})));

  equation

    if T_in <= T_soll - 2/3 * T_h then
        H_ein = true;
      else
        H_ein = false;
    end if;

    if T_in >= T_soll + 1/3 * T_h then
        H_aus = true;
      else
      H_aus = false;
    end if;

    if T_in >= T_soll + 2/3 * T_h then
        K_ein = true;
      else
        K_ein = false;
    end if;

    if T_in <= T_soll - 1/3 * T_h then
        K_aus = true;
      else
        K_aus = false;
    end if;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Auswertung_Temperaturen;

  model Ebene2_H "nur Heizen"
    Modelica.StateGraph.InitialStepWithSignal M8(nIn=2, nOut=2)
      "Modus 8, nur Rekuperation" annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-16,50})));
    Modelica.StateGraph.StepWithSignal M12(nIn=2, nOut=2)
      "Modus 12, Rekuperation + Heizregister" annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={22,52})));
    Modelica.StateGraph.StepWithSignal M16(nIn=2, nOut=2)
      "Modus 16, Rekuperation und Regeneration"
      annotation (Placement(transformation(extent={{-42,-34},{-22,-14}})));
    Modelica.StateGraph.StepWithSignal M20(nIn=2, nOut=2)
      "Modus 20, Rekuperation, Heizregister + Regeneration"
      annotation (Placement(transformation(extent={{40,-32},{60,-12}})));
    Modelica.StateGraph.TransitionWithSignal Heizregister_an
      annotation (Placement(transformation(extent={{-6,74},{14,54}})));
    Modelica.StateGraph.TransitionWithSignal Heizregister_aus
      annotation (Placement(transformation(extent={{10,40},{-10,20}})));
    Modelica.StateGraph.TransitionWithSignal Reg_aus2 annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={58,16})));
    Modelica.StateGraph.TransitionWithSignal Reg_an2 annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={24,16})));
    Modelica.StateGraph.TransitionWithSignal Heizregister_an_Reg
      annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
    Modelica.StateGraph.TransitionWithSignal Heizregister_aus_Reg
      annotation (Placement(transformation(extent={{10,-58},{-10,-38}})));
    Modelica.StateGraph.TransitionWithSignal Reg_aus annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={-22,0})));
    Modelica.StateGraph.TransitionWithSignal Reg_an annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={-54,0})));
    Modelica.Blocks.Interfaces.BooleanInput Reganforderung
      annotation (Placement(transformation(extent={{-130,-22},{-90,18}})));
    Modelica.Blocks.Logical.Not not1
      annotation (Placement(transformation(extent={{-100,12},{-80,32}})));
    Modelica.Blocks.Interfaces.RealInput Y09
      annotation (Placement(transformation(extent={{-130,24},{-90,64}})));
    Modelica.Blocks.Interfaces.RealInput Y02
      annotation (Placement(transformation(extent={{-130,66},{-90,106}})));
    Auswertung_Ebene2H auswertung_Y02_Y09_1
      annotation (Placement(transformation(extent={{-70,70},{-50,90}})));
    Modelica.Blocks.Interfaces.RealOutput M_Out
      annotation (Placement(transformation(extent={{96,-10},{116,10}})));
  equation

    M_Out = if M20.active then 20
      else if M16.active then 16
      else if M12.active then 12
      else 8;

    connect(M8.outPort[1], Heizregister_an.inPort) annotation (Line(points={{-16.25,
            60.5},{-10,60.5},{-10,64},{0,64}},         color={0,0,0}));
    connect(Heizregister_an.outPort, M12.inPort[1]) annotation (Line(points={{5.5,64},
            {20,64},{20,63},{22.5,63}},                         color={0,0,0}));
    connect(M12.outPort[1], Heizregister_aus.inPort) annotation (Line(points={{
            22.25,41.5},{22.25,30},{4,30}}, color={0,0,0}));
    connect(M8.outPort[2], Reg_an.inPort) annotation (Line(points={{-15.75,60.5},
            {-56,60.5},{-56,4},{-54,4}}, color={0,0,0}));
    connect(Heizregister_aus.outPort, M8.inPort[1]) annotation (Line(points={{
            -1.5,30},{-14,30},{-14,32},{-16.5,32},{-16.5,39}}, color={0,0,0}));
    connect(Reg_aus.outPort, M8.inPort[2])
      annotation (Line(points={{-22,1.5},{-22,39},{-15.5,39}}, color={0,0,0}));
    connect(M12.outPort[2], Reg_an2.inPort) annotation (Line(points={{21.75,
            41.5},{26,41.5},{26,20},{24,20}}, color={0,0,0}));
    connect(Reg_aus2.outPort, M12.inPort[2]) annotation (Line(points={{58,17.5},
            {42,17.5},{42,63},{21.5,63}}, color={0,0,0},
        smooth=Smooth.Bezier));
    connect(M16.outPort[1], Heizregister_an_Reg.inPort) annotation (Line(points=
           {{-21.5,-23.75},{-16,-23.75},{-16,-20},{-4,-20}}, color={0,0,0}));
    connect(M16.outPort[2], Reg_aus.inPort) annotation (Line(points={{-21.5,
            -24.25},{-20,-24.25},{-20,-4},{-22,-4}}, color={0,0,0}));
    connect(Reg_an.outPort, M16.inPort[2]) annotation (Line(points={{-54,-1.5},
            {-50,-1.5},{-50,-24.5},{-43,-24.5}}, color={0,0,0}));
    connect(Heizregister_aus_Reg.outPort, M16.inPort[1]) annotation (Line(
          points={{-1.5,-48},{-43,-48},{-43,-23.5}}, color={0,0,0}));
    connect(M20.outPort[2], Reg_aus2.inPort) annotation (Line(points={{60.5,
            -22.25},{62,-22.25},{62,-22},{64,-22},{64,-6},{58,-6},{58,12}},
          color={0,0,0}));
    connect(Reg_an2.outPort, M20.inPort[2]) annotation (Line(points={{24,14.5},
            {36,14.5},{36,-22},{38,-22},{38,-22.5},{39,-22.5}}, color={0,0,0}));
    connect(M20.outPort[1], Heizregister_aus_Reg.inPort) annotation (Line(
          points={{60.5,-21.75},{60,-21.75},{60,-48},{4,-48}}, color={0,0,0}));
    connect(Heizregister_an_Reg.outPort, M20.inPort[1]) annotation (Line(points=
           {{1.5,-20},{16,-20},{16,-24},{32,-24},{40,-24},{40,-21.5},{39,-21.5}},
          color={0,0,0}));
    connect(Reganforderung, Reg_an.condition)
      annotation (Line(points={{-110,-2},{-88,-2},{-88,0},{-66,0}},
                                                  color={255,0,255}));
    connect(Reganforderung, Reg_an2.condition) annotation (Line(points={{-110,-2},
            {-92,-2},{-92,-98},{94,-98},{94,-2},{36,-2},{36,16}},
                  color={255,0,255}));
    connect(not1.y, Reg_aus.condition)
      annotation (Line(points={{-79,22},{-34,22},{-34,0}}, color={255,0,255}));
    connect(not1.y, Reg_aus2.condition) annotation (Line(points={{-79,22},{-78,
            22},{-78,98},{100,98},{100,16},{70,16}}, color={255,0,255}));
    connect(Reganforderung, not1.u) annotation (Line(points={{-110,-2},{-110,11},{
            -102,11},{-102,22}},  color={255,0,255}));
    connect(Y02, auswertung_Y02_Y09_1.Y02) annotation (Line(points={{-110,86},{
            -91,86},{-91,88.6},{-71,88.6}}, color={0,0,127}));
    connect(Y09, auswertung_Y02_Y09_1.Y09) annotation (Line(points={{-110,44},{-91,
            44},{-91,78},{-71,78}},     color={0,0,127}));
    connect(auswertung_Y02_Y09_1.Anschalten, Heizregister_an.condition)
      annotation (Line(points={{-49.4,84},{4,84},{4,76}}, color={255,0,255}));
    connect(auswertung_Y02_Y09_1.Anschalten, Heizregister_an_Reg.condition)
      annotation (Line(points={{-49.4,84},{-28,84},{-28,92},{110,92},{110,-76},
            {12,-76},{12,-32},{0,-32}}, color={255,0,255}));
    connect(auswertung_Y02_Y09_1.Ausschalten, Heizregister_aus.condition)
      annotation (Line(points={{-49.4,76},{0,76},{0,42}},
          color={255,0,255}));
    connect(auswertung_Y02_Y09_1.Ausschalten, Heizregister_aus_Reg.condition)
      annotation (Line(points={{-49.4,76},{-38,76},{-38,94},{116,94},{116,-82},
            {0,-82},{0,-60}}, color={255,0,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false), graphics={
          Text(
            extent={{-46,70},{-36,60}},
            lineColor={28,108,200},
            textString="Index 1"),
          Text(
            extent={{-76,46},{-66,36}},
            lineColor={28,108,200},
            textString="Index 2"),
          Text(
            extent={{42,86},{52,76}},
            lineColor={28,108,200},
            textString="Index 1"),
          Text(
            extent={{54,42},{66,32}},
            lineColor={28,108,200},
            textString="Index 2"),
          Text(
            extent={{-42,-64},{-32,-74}},
            lineColor={28,108,200},
            textString="Index 1"),
          Text(
            extent={{-86,-28},{-76,-38}},
            lineColor={28,108,200},
            textString="Index 2"),
          Text(
            extent={{76,-24},{88,-34}},
            lineColor={28,108,200},
            textString="Index 2"),
          Text(
            extent={{28,-52},{38,-62}},
            lineColor={28,108,200},
            textString="Index 1"),
          Text(
            extent={{124,40},{148,6}},
            lineColor={28,108,200},
            textString="BusConnector")}));
  end Ebene2_H;

  model Ebene2_K "nur Kuehlen"
    Modelica.StateGraph.InitialStepWithSignal M10 annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-48,0})));
    Modelica.StateGraph.StepWithSignal M18 annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={50,0})));
    Modelica.StateGraph.TransitionWithSignal Reg_an
      annotation (Placement(transformation(extent={{-10,40},{10,20}})));
    Modelica.StateGraph.TransitionWithSignal Reg_aus
      annotation (Placement(transformation(extent={{10,-40},{-10,-20}})));
    Modelica.Blocks.Interfaces.BooleanInput condition1
      annotation (Placement(transformation(extent={{-128,-20},{-88,20}})));
    Modelica.Blocks.Logical.Not not1
      annotation (Placement(transformation(extent={{-42,-60},{-22,-40}})));
    Modelica.Blocks.Interfaces.RealOutput M_Out
      annotation (Placement(transformation(extent={{96,-10},{116,10}})));
  equation

    M_Out = if M18.active then 18 else if M10.active then 10 else 1;

    connect(M10.outPort[1], Reg_an.inPort)
      annotation (Line(points={{-48,10.5},{-48,30},{-4,30}}, color={0,0,0}));
    connect(Reg_an.outPort, M18.inPort[1])
      annotation (Line(points={{1.5,30},{50,30},{50,11}}, color={0,0,0}));
    connect(M18.outPort[1], Reg_aus.inPort)
      annotation (Line(points={{50,-10.5},{50,-30},{4,-30}}, color={0,0,0}));
    connect(Reg_aus.outPort, M10.inPort[1]) annotation (Line(points={{-1.5,-30},
            {-48,-30},{-48,-11}}, color={0,0,0}));
    connect(condition1, Reg_an.condition) annotation (Line(points={{-108,0},{
            -70,0},{-70,50},{0,50},{0,42}}, color={255,0,255}));
    connect(condition1, not1.u) annotation (Line(points={{-108,0},{-70,0},{-70,
            -50},{-44,-50}}, color={255,0,255}));
    connect(not1.y, Reg_aus.condition)
      annotation (Line(points={{-21,-50},{0,-50},{0,-42}}, color={255,0,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Ebene2_K;

  model Ebene2_D "Ebene 2 weder heizen noch kuehlen"
    Modelica.StateGraph.InitialStepWithSignal M2 annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-48,0})));
    Modelica.StateGraph.StepWithSignal M5 annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={50,0})));
    Modelica.StateGraph.TransitionWithSignal Reg_an
      annotation (Placement(transformation(extent={{-10,40},{10,20}})));
    Modelica.StateGraph.TransitionWithSignal Reg_aus
      annotation (Placement(transformation(extent={{10,-40},{-10,-20}})));
    Modelica.Blocks.Interfaces.BooleanInput condition1
      annotation (Placement(transformation(extent={{-128,-20},{-88,20}})));
    Modelica.Blocks.Logical.Not not1
      annotation (Placement(transformation(extent={{-42,-60},{-22,-40}})));
    Modelica.Blocks.Interfaces.RealOutput M_Out
      annotation (Placement(transformation(extent={{96,-10},{116,10}})));
  equation

    M_Out = if M5.active then 5 else if M2.active then 2 else 1;

    connect(M2.outPort[1], Reg_an.inPort)
      annotation (Line(points={{-48,10.5},{-48,30},{-4,30}}, color={0,0,0}));
    connect(Reg_an.outPort, M5.inPort[1])
      annotation (Line(points={{1.5,30},{50,30},{50,11}}, color={0,0,0}));
    connect(M5.outPort[1], Reg_aus.inPort)
      annotation (Line(points={{50,-10.5},{50,-30},{4,-30}}, color={0,0,0}));
    connect(Reg_aus.outPort, M2.inPort[1]) annotation (Line(points={{-1.5,-30},
            {-48,-30},{-48,-11}}, color={0,0,0}));
    connect(Reg_an.condition, condition1) annotation (Line(points={{0,42},{-70,
            42},{-70,0},{-108,0}}, color={255,0,255}));
    connect(condition1, not1.u) annotation (Line(points={{-108,0},{-70,0},{-70,
            -50},{-44,-50}}, color={255,0,255}));
    connect(not1.y, Reg_aus.condition)
      annotation (Line(points={{-21,-50},{0,-50},{0,-42}}, color={255,0,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Ebene2_D;

  model Auswertung_Ebene2H
    Modelica.Blocks.Interfaces.RealInput Y02
      annotation (Placement(transformation(extent={{-130,66},{-90,106}})));
    Modelica.Blocks.Interfaces.RealInput Y09
      annotation (Placement(transformation(extent={{-130,-40},{-90,0}})));
    Modelica.Blocks.Interfaces.BooleanOutput Anschalten
      "Connector of Boolean output signal"
      annotation (Placement(transformation(extent={{96,30},{116,50}})));
    Modelica.Blocks.Interfaces.BooleanOutput Ausschalten
      "Connector of Boolean output signal"
      annotation (Placement(transformation(extent={{96,-50},{116,-30}})));
  equation

   if Y02 <= 0 then
     Anschalten = true;
   else
     Anschalten = false;
   end if;

   if Y09 <= 0 then
     Ausschalten = true;
   else
     Ausschalten = false;
   end if;

      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false), graphics={Text(
            extent={{-26,26},{22,-14}},
            lineColor={28,108,200},
            textString="Lösung über Gleichungen")}));
  end Auswertung_Ebene2H;

  model Y02_actorsignal
    Modelica.StateGraph.InitialStepWithSignal Y02_geschlossen(nIn=2, nOut=2)
      "Signal Y02 ist 0" annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-50,50})));
    Modelica.StateGraph.StepWithSignal Y02_offen(nIn=2, nOut=2)
      "Signal Y02 ist 1" annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={50,50})));
    Modelica.StateGraph.TransitionWithSignal Anschalten_1_1
      annotation (Placement(transformation(extent={{-10,48},{10,28}})));
    Modelica.StateGraph.TransitionWithSignal Anschalten_0
      annotation (Placement(transformation(extent={{10,88},{-10,68}})));
    Modelica.StateGraph.StepWithSignal Y02_regelnd(nIn=2, nOut=2)
      "Signal Y02 wird geregelt" annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={0,-32})));
    Modelica.StateGraph.TransitionWithSignal Anschalten_Regelung2 annotation (
        Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={34,0})));
    Modelica.StateGraph.TransitionWithSignal Anschalten_1 annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={66,0})));
    Modelica.StateGraph.TransitionWithSignal Anschalten_00 annotation (
        Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={-50,0})));
    Modelica.StateGraph.TransitionWithSignal Anschalten_Regelung annotation (
        Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={-22,0})));
    Modelica.Blocks.Interfaces.RealInput M_in "Modus"
      annotation (Placement(transformation(extent={{-128,-20},{-88,20}})));
    Auswertung_Y02 auswertung_Y02_1
      annotation (Placement(transformation(extent={{-94,54},{-74,74}})));
  equation
    connect(Y02_geschlossen.outPort[1], Anschalten_Regelung.inPort) annotation (
       Line(points={{-49.75,39.5},{-50,39.5},{-50,26},{-22,26},{-22,4}}, color=
            {0,0,0}));
    connect(Anschalten_00.outPort, Y02_geschlossen.inPort[1]) annotation (Line(
          points={{-50,1.5},{-64,1.5},{-64,61},{-49.5,61}}, color={0,0,0}));
    connect(Anschalten_Regelung.outPort, Y02_regelnd.inPort[1]) annotation (
        Line(points={{-22,-1.5},{-22,-18},{0.5,-18},{0.5,-21}}, color={0,0,0}));
    connect(Y02_regelnd.outPort[1], Anschalten_00.inPort) annotation (Line(
          points={{0.25,-42.5},{-4,-42.5},{-4,-56},{-50,-56},{-50,-4}}, color={
            0,0,0}));
    connect(Anschalten_Regelung2.outPort, Y02_regelnd.inPort[2]) annotation (
        Line(points={{34,-1.5},{34,-16},{-0.5,-16},{-0.5,-21}}, color={0,0,0}));
    connect(Y02_regelnd.outPort[2], Anschalten_1.inPort) annotation (Line(
          points={{-0.25,-42.5},{2,-42.5},{2,-56},{66,-56},{66,-4}}, color={0,0,
            0}));
    connect(Y02_geschlossen.outPort[2], Anschalten_1_1.inPort) annotation (Line(
          points={{-50.25,39.5},{-22,39.5},{-22,38},{-4,38}}, color={0,0,0}));
    connect(Anschalten_0.outPort, Y02_geschlossen.inPort[2]) annotation (Line(
          points={{-1.5,78},{-44,78},{-44,61},{-50.5,61}}, color={0,0,0}));
    connect(Anschalten_1.outPort, Y02_offen.inPort[1]) annotation (Line(points=
            {{66,1.5},{58,1.5},{58,39},{49.5,39}}, color={0,0,0}));
    connect(Y02_offen.outPort[1], Anschalten_Regelung2.inPort) annotation (Line(
          points={{49.75,60.5},{49.75,60},{50,60},{50,60},{50,64},{34,64},{34,4}},
          color={0,0,0}));
    connect(Y02_offen.outPort[2], Anschalten_0.inPort) annotation (Line(points=
            {{50.25,60.5},{50.25,78},{4,78}}, color={0,0,0}));
    connect(Anschalten_1_1.outPort, Y02_offen.inPort[2]) annotation (Line(
          points={{1.5,38},{26,38},{26,36},{50.5,36},{50.5,39}}, color={0,0,0}));
    connect(M_in, auswertung_Y02_1.M_in) annotation (Line(points={{-108,0},{
            -108,32},{-94.8,32},{-94.8,64}}, color={0,0,127}));
    connect(auswertung_Y02_1.Anschalten_0, Anschalten_0.condition) annotation (
        Line(points={{-73.4,64},{-58,64},{-58,94},{0,94},{0,90}}, color={255,0,
            255}));
    connect(auswertung_Y02_1.Anschalten_0, Anschalten_00.condition) annotation (
       Line(points={{-73.4,64},{-66,64},{-66,0},{-62,0}}, color={255,0,255}));
    connect(auswertung_Y02_1.Anschalten_Regelung, Anschalten_Regelung.condition)
      annotation (Line(points={{-73.4,58},{-70,58},{-70,6},{-34,6},{-34,0}},
          color={255,0,255}));
    connect(auswertung_Y02_1.Anschalten_Regelung, Anschalten_Regelung2.condition)
      annotation (Line(points={{-73.4,58},{-70,58},{-70,-68},{46,-68},{46,0}},
          color={255,0,255}));
    connect(auswertung_Y02_1.Anschalten_1, Anschalten_1_1.condition)
      annotation (Line(points={{-73.2,70},{-36,70},{-36,60},{0,60},{0,50}},
          color={255,0,255}));
    connect(auswertung_Y02_1.Anschalten_1, Anschalten_1.condition) annotation (
        Line(points={{-73.2,70},{-74,70},{-74,98},{94,98},{94,0},{78,0}}, color=
           {255,0,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false), graphics={
          Text(
            extent={{-84,38},{-70,24}},
            lineColor={28,108,200},
            textString="index 1"),
          Text(
            extent={{-68,-22},{-54,-36}},
            lineColor={28,108,200},
            textString="index 1"),
          Text(
            extent={{30,-24},{44,-38}},
            lineColor={28,108,200},
            textString="index 2
"),       Text(
            extent={{-30,70},{-16,56}},
            lineColor={28,108,200},
            textString="index 2
"),       Text(
            extent={{82,22},{96,8}},
            lineColor={28,108,200},
            textString="index 1"),
          Text(
            extent={{10,70},{24,56}},
            lineColor={28,108,200},
            textString="index 2
")}));
  end Y02_actorsignal;

  model Auswertung_Y02
    Modelica.Blocks.Interfaces.RealInput M_in "Modus"
      annotation (Placement(transformation(extent={{-128,-20},{-88,20}})));
    Modelica.Blocks.Interfaces.BooleanOutput Anschalten_1
      "Connector of Boolean output signal"
      annotation (Placement(transformation(extent={{98,50},{118,70}})));
    Modelica.Blocks.Interfaces.BooleanOutput Anschalten_0
      "Connector of Boolean output signal"
      annotation (Placement(transformation(extent={{96,-10},{116,10}})));
    Modelica.Blocks.Interfaces.BooleanOutput Anschalten_Regelung
      "Connector of Boolean output signal"
      annotation (Placement(transformation(extent={{96,-70},{116,-50}})));

  equation

    if M_in <= 1 then
        Anschalten_0 = true;
      else
        Anschalten_0 = false;
    end if;

    if M_in >= 2 and M_in <= 7 then
        Anschalten_1 = true;
      else
        Anschalten_1 = false;
    end if;

    if M_in >= 8 and M_in <= 23 then
      Anschalten_Regelung = true;
    else
      Anschalten_Regelung = false;
    end if;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Auswertung_Y02;

  model Minimalbeispiel_Stategraph
    extends Modelica.Icons.Example;
    StateGraph_Ebene1 stateGraph_Ebene1_1
      annotation (Placement(transformation(extent={{-42,64},{-22,84}})));
    Modelica.Blocks.Sources.Sine T_in_variation(
      amplitude=5,
      freqHz=1/3600,
      offset=20)
      annotation (Placement(transformation(extent={{-104,66},{-84,86}})));
    Ebene2_H ebene2_H
      annotation (Placement(transformation(extent={{-64,-16},{-44,4}})));
    Ebene2_K ebene2_K
      annotation (Placement(transformation(extent={{-64,-44},{-44,-24}})));
    Ebene2_D ebene2_D
      annotation (Placement(transformation(extent={{-64,-72},{-44,-52}})));
    Modelica.Blocks.Sources.BooleanConstant Regenerationsanforderung(k=false)
      annotation (Placement(transformation(extent={{-104,22},{-84,42}})));
    Y02_actorsignal y02_actorsignal
      annotation (Placement(transformation(extent={{68,60},{88,80}})));
    Modelica.Blocks.Sources.Constant Y02(k=0.5)
      annotation (Placement(transformation(extent={{-114,-12},{-94,8}})));
    Modelica.Blocks.Sources.Constant Y09(k=0.5)
      annotation (Placement(transformation(extent={{-114,-46},{-94,-26}})));
    Modiauswertung modiauswertung
      annotation (Placement(transformation(extent={{6,26},{26,46}})));
    Y02_actorsignal y02_actorsignal1
      annotation (Placement(transformation(extent={{68,28},{88,48}})));
    Y02_actorsignal y02_actorsignal2
      annotation (Placement(transformation(extent={{66,2},{86,22}})));
    Y02_actorsignal y02_actorsignal3
      annotation (Placement(transformation(extent={{72,-26},{92,-6}})));
  equation
    connect(T_in_variation.y, stateGraph_Ebene1_1.T_in1) annotation (Line(
          points={{-83,76},{-46,76},{-46,74.2},{-42.6,74.2}}, color={0,0,127}));
    connect(Regenerationsanforderung.y, ebene2_H.Reganforderung) annotation (
        Line(points={{-83,32},{-76,32},{-76,-6.2},{-65,-6.2}}, color={255,0,255}));
    connect(Regenerationsanforderung.y, ebene2_K.condition1) annotation (Line(
          points={{-83,32},{-76,32},{-76,-34},{-64.8,-34}}, color={255,0,255}));
    connect(Regenerationsanforderung.y, ebene2_D.condition1) annotation (Line(
          points={{-83,32},{-76,32},{-76,-62},{-64.8,-62}}, color={255,0,255}));
    connect(Y02.y, ebene2_H.Y02) annotation (Line(points={{-93,-2},{-80,-2},{
            -80,2.6},{-65,2.6}}, color={0,0,127}));
    connect(Y09.y, ebene2_H.Y09) annotation (Line(points={{-93,-36},{-80,-36},{
            -80,-1.6},{-65,-1.6}}, color={0,0,127}));
    connect(stateGraph_Ebene1_1.Heizen_Out, modiauswertung.H) annotation (Line(
          points={{-21.4,74},{9,74},{9,46.2}}, color={255,0,255}));
    connect(stateGraph_Ebene1_1.Drift_Out, modiauswertung.D) annotation (Line(
          points={{-21.4,81.2},{16,81.2},{16,46.2}}, color={255,0,255}));
    connect(stateGraph_Ebene1_1.Kuehlen_Out, modiauswertung.K) annotation (Line(
          points={{-21.4,67.8},{23,67.8},{23,46.2}}, color={255,0,255}));
    connect(ebene2_H.M_Out, modiauswertung.Modus_H) annotation (Line(points={{
            -43.4,-6},{-18,-6},{-18,43},{5.6,43}}, color={0,0,127}));
    connect(ebene2_D.M_Out, modiauswertung.Modus_D) annotation (Line(points={{
            -43.4,-62},{-28,-62},{-28,-48},{-10,-48},{-10,36},{5.6,36}}, color=
            {0,0,127}));
    connect(ebene2_K.M_Out, modiauswertung.Modus_K) annotation (Line(points={{
            -43.4,-34},{-4,-34},{-4,29},{5.6,29}}, color={0,0,127}));
    connect(modiauswertung.M_Out, y02_actorsignal.M_in) annotation (Line(points=
           {{26.6,36},{48,36},{48,70},{67.2,70}}, color={0,0,127}));
  end Minimalbeispiel_Stategraph;

  model Modiauswertung
    Modelica.Blocks.Interfaces.RealOutput M_Out
      annotation (Placement(transformation(extent={{96,-10},{116,10}})));
    Modelica.Blocks.Interfaces.RealInput Modus_H
      annotation (Placement(transformation(extent={{-124,50},{-84,90}})));
    Modelica.Blocks.Interfaces.BooleanInput H annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={-70,102})));
    Modelica.Blocks.Interfaces.BooleanInput D annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={0,102})));
    Modelica.Blocks.Interfaces.BooleanInput K annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={70,102})));
    Modelica.Blocks.Interfaces.RealInput Modus_D
      annotation (Placement(transformation(extent={{-124,-20},{-84,20}})));
    Modelica.Blocks.Interfaces.RealInput Modus_K
      annotation (Placement(transformation(extent={{-124,-90},{-84,-50}})));

  equation

  M_Out = if H then Modus_H else if K then Modus_K else if D then Modus_D else 1;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Modiauswertung;
end Minimal_example_StateGraph;
