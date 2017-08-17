within AixLib.Airflow.AirHandlingUnit.BaseClasses;
package Minimal_example_PN
  model PN_Ebene1
    parameter Real T_h = 3;
    parameter Real T_soll = 20;

    PNlib.PD Heizen(nIn=1, nOut=1) "Petri-Stelle für Heizen" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-60,30})));
    PNlib.PD Kuehlen(nIn=1, nOut=1) "Petri-Stelle für Kühlen" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={60,30})));
    PNlib.PD Drift_HK(
      startTokens=1,
      nIn=2,
      nOut=2) "Petri-Stelle für den Drift-Zustand, weder heizen noch kühlen"
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={0,30})));
    PNlib.TD Heizen_aus(nIn=1, nOut=1,
      firingCon=T_in >= T_soll + 1/3*T_h)
                                       "Transition zum Ausschalten der Heizung"
      annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
    PNlib.TD Heizen_an(nOut=1, nIn=1,
      firingCon=T_in <= T_soll - 2/3*T_h)
                                      "Transition zum Anschalten der Heizung"
      annotation (Placement(transformation(extent={{-20,0},{-40,20}})));
    PNlib.TD Kuehlen_an(nIn=1, nOut=1,
      firingCon=T_in >= T_soll + 2/3*T_h)
                                       "Transition zum Anschalten der Kühlung"
      annotation (Placement(transformation(extent={{20,0},{40,20}})));
    PNlib.TD Kuehlen_aus(nOut=1, nIn=1,
      firingCon=T_in <= T_soll - 1/3*T_h)
                                        "Transition zum Ausschalten der Kühlung"
      annotation (Placement(transformation(extent={{40,40},{20,60}})));
    Modelica.Blocks.Interfaces.RealInput T_in "Eingangstemperatur"
      annotation (Placement(transformation(extent={{-128,-20},{-88,20}})));
  equation
    connect(Heizen_an.outPlaces[1],Heizen. inTransition[1])
      annotation (Line(points={{-34.8,10},{-60,10},{-60,19.2}}, color={0,0,0}));
    connect(Heizen.outTransition[1],Heizen_aus. inPlaces[1])
      annotation (Line(points={{-60,40.8},{-60,50},{-34.8,50}}, color={0,0,0}));
    connect(Heizen_aus.outPlaces[1],Drift_HK. inTransition[1]) annotation (Line(
          points={{-25.2,50},{-0.5,50},{-0.5,40.8}}, color={0,0,0}));
    connect(Kuehlen_aus.outPlaces[1],Drift_HK. inTransition[2])
      annotation (Line(points={{25.2,50},{0.5,50},{0.5,40.8}}, color={0,0,0}));
    connect(Drift_HK.outTransition[1],Heizen_an. inPlaces[1]) annotation (Line(
          points={{-0.5,19.2},{-0.5,10},{-25.2,10}}, color={0,0,0}));
    connect(Drift_HK.outTransition[2],Kuehlen_an. inPlaces[1])
      annotation (Line(points={{0.5,19.2},{0.5,10},{25.2,10}}, color={0,0,0}));
    connect(Kuehlen_an.outPlaces[1],Kuehlen. inTransition[1])
      annotation (Line(points={{34.8,10},{60,10},{60,19.2}}, color={0,0,0}));
    connect(Kuehlen.outTransition[1],Kuehlen_aus. inPlaces[1])
      annotation (Line(points={{60,40.8},{60,50},{34.8,50}}, color={0,0,0}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end PN_Ebene1;

  model Minimalbeispiel_PN
    extends Modelica.Icons.Example;
    Minimal_example_PN.PN_Ebene1 minimalbeispiel_PN
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Modelica.Blocks.Sources.Sine T_in_variation(
      amplitude=5,
      freqHz=1/3600,
      offset=20)
      annotation (Placement(transformation(extent={{-62,-10},{-42,10}})));
  equation
    connect(T_in_variation.y, minimalbeispiel_PN.T_in)
      annotation (Line(points={{-41,0},{-10.8,0}}, color={0,0,127}));
  end Minimalbeispiel_PN;
end Minimal_example_PN;
