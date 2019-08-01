within AixLib.Systems.Benchmark.ControlStrategies.Controller_PumpsAndFans;
model Pump_VariablePowerCost
  Model.BusSystems.Bus_measure measureBus
    annotation (Placement(transformation(extent={{-20,80},{20,120}})));
  Model.BusSystems.Bus_Control controlBus
    annotation (Placement(transformation(extent={{-20,-120},{20,-80}})));
  Modelica.Blocks.Continuous.LimPID Aircooler(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=200,
    k=0.01,
    yMax=0,
    yMin=-1) annotation (Placement(transformation(extent={{-68,28},{-56,40}})));
  Modelica.Blocks.Sources.RealExpression Heatpump1(y=273.15 + 9)
    annotation (Placement(transformation(extent={{-100,24},{-80,44}})));
  Modelica.Blocks.Math.Gain gain1(k=-1)
    annotation (Placement(transformation(extent={{-48,30},{-40,38}})));
  Modelica.Blocks.Sources.RealExpression Heatpump2(y=0.1)
    annotation (Placement(transformation(extent={{-90,-2},{-70,18}})));
  Modelica.Blocks.Math.Max max
    annotation (Placement(transformation(extent={{-28,18},{-8,38}})));
  Modelica.Blocks.Logical.Or or1
    annotation (Placement(transformation(extent={{-64,56},{-52,68}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-24,52},{-4,72}})));
  Modelica.Blocks.Sources.RealExpression Generatoren(y=1)
    annotation (Placement(transformation(extent={{-100,66},{-80,86}})));
  Modelica.Blocks.Sources.RealExpression Generatoren1(y=0.1)
    annotation (Placement(transformation(extent={{-100,38},{-80,58}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{-26,-14},{-6,6}})));
  Modelica.Blocks.Logical.Or or2
    annotation (Placement(transformation(extent={{-56,-10},{-44,2}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=1)
    annotation (Placement(transformation(extent={{-148,-54},{-128,-34}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=0)
    annotation (Placement(transformation(extent={{-148,-94},{-128,-74}})));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold(threshold=
       6)  annotation (Placement(transformation(extent={{-170,-62},{-158,-50}})));
  Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold(threshold=22)
    annotation (Placement(transformation(extent={{-170,-80},{-158,-68}})));
  Modelica.Blocks.Math.IntegerToReal integerToReal
    annotation (Placement(transformation(extent={{-206,-74},{-186,-54}})));
  Modelica.Blocks.Logical.And and2
    annotation (Placement(transformation(extent={{-144,-70},{-130,-56}})));
  Modelica.Blocks.Logical.Switch Pump_RLT_Pump_VerteilerHot
    annotation (Placement(transformation(extent={{-102,-74},{-82,-54}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(
                                                        y=1)
    annotation (Placement(transformation(extent={{-146,-110},{-126,-90}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=0.5)
    annotation (Placement(transformation(extent={{-146,-150},{-126,-130}})));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold1(threshold=
       6)  annotation (Placement(transformation(extent={{-168,-118},{-156,
            -106}})));
  Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold1(threshold=22)
    annotation (Placement(transformation(extent={{-168,-136},{-156,-124}})));
  Modelica.Blocks.Math.IntegerToReal integerToReal1
    annotation (Placement(transformation(extent={{-204,-130},{-184,-110}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{-142,-126},{-128,-112}})));
  Modelica.Blocks.Logical.Switch Pump_Verteiler
    annotation (Placement(transformation(extent={{-100,-130},{-80,-110}})));
  Modelica.Blocks.Sources.RealExpression Pump_TBA(y=1)
    annotation (Placement(transformation(extent={{-50,-46},{-30,-26}})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{48,34},{68,54}})));
  Modelica.Blocks.Sources.RealExpression Heatpump3(y=1)
    annotation (Placement(transformation(extent={{8,60},{28,80}})));
equation
  connect(Heatpump1.y, Aircooler.u_s)
    annotation (Line(points={{-79,34},{-69.2,34}}, color={0,0,127}));
  connect(Aircooler.y, gain1.u)
    annotation (Line(points={{-55.4,34},{-48.8,34}}, color={0,0,127}));
  connect(gain1.y, max.u1)
    annotation (Line(points={{-39.6,34},{-30,34}}, color={0,0,127}));
  connect(Heatpump2.y, max.u2) annotation (Line(points={{-69,8},{-49.5,8},{
          -49.5,22},{-30,22}}, color={0,0,127}));
  connect(or1.y, switch1.u2)
    annotation (Line(points={{-51.4,62},{-26,62}}, color={255,0,255}));
  connect(switch1.y, controlBus.Pump_Coldwater_heatpump_y)
    annotation (Line(points={{-3,62},{0.1,62},{0.1,-99.9}}, color={0,0,127}));
  connect(Generatoren.y, switch1.u1) annotation (Line(points={{-79,76},{-38,
          76},{-38,70},{-26,70}}, color={0,0,127}));
  connect(Generatoren1.y, switch1.u3) annotation (Line(points={{-79,48},{-40,
          48},{-40,54},{-26,54}}, color={0,0,127}));
  connect(or2.y, switch2.u2)
    annotation (Line(points={{-43.4,-4},{-28,-4}}, color={255,0,255}));
  connect(or2.u1, controlBus.OnOff_CHP) annotation (Line(points={{-57.2,-4},{
          -72,-4},{-72,-99.9},{0.1,-99.9}}, color={255,0,255}));
  connect(or2.u2, controlBus.OnOff_boiler) annotation (Line(points={{-57.2,-8.8},
          {-72,-8.8},{-72,-99.9},{0.1,-99.9}}, color={255,0,255}));
  connect(switch2.u1, switch1.u1) annotation (Line(points={{-28,4},{-32,4},{-32,
          70},{-26,70}}, color={0,0,127}));
  connect(switch2.u3, switch1.u3) annotation (Line(points={{-28,-12},{-40,-12},
          {-40,54},{-26,54}}, color={0,0,127}));
  connect(switch2.y, controlBus.Pump_Hotwater_CHP_y)
    annotation (Line(points={{-5,-4},{0.1,-4},{0.1,-99.9}}, color={0,0,127}));
  connect(switch2.y, controlBus.Pump_Hotwater_Boiler_y)
    annotation (Line(points={{-5,-4},{0.1,-4},{0.1,-99.9}}, color={0,0,127}));
  connect(integerToReal.y,greaterEqualThreshold. u) annotation (Line(points={{-185,
          -64},{-179.8,-64},{-179.8,-56},{-171.2,-56}},
                                                     color={0,0,127}));
  connect(lessEqualThreshold.u, integerToReal.y) annotation (Line(points={{
          -171.2,-74},{-180,-74},{-180,-64},{-185,-64}}, color={0,0,127}));
  connect(integerToReal.u, measureBus.Hour) annotation (Line(points={{-208,
          -64},{-218,-64},{-218,90},{0.1,90},{0.1,100.1}}, color={255,127,0}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(lessEqualThreshold.y, and2.u2) annotation (Line(points={{-157.4,-74},
          {-152,-74},{-152,-68.6},{-145.4,-68.6}}, color={255,0,255}));
  connect(greaterEqualThreshold.y, and2.u1) annotation (Line(points={{-157.4,
          -56},{-152,-56},{-152,-63},{-145.4,-63}}, color={255,0,255}));
  connect(and2.y, Pump_RLT_Pump_VerteilerHot.u2) annotation (Line(points={{
          -129.3,-63},{-116.65,-63},{-116.65,-64},{-104,-64}}, color={255,0,
          255}));
  connect(realExpression.y, Pump_RLT_Pump_VerteilerHot.u1) annotation (Line(
        points={{-127,-44},{-114,-44},{-114,-56},{-104,-56}}, color={0,0,127}));
  connect(realExpression2.y, Pump_RLT_Pump_VerteilerHot.u3) annotation (Line(
        points={{-127,-84},{-116,-84},{-116,-72},{-104,-72}}, color={0,0,127}));
  connect(Pump_RLT_Pump_VerteilerHot.y, controlBus.Pump_RLT_Central_hot_y)
    annotation (Line(points={{-81,-64},{0,-64},{0,-99.9},{0.1,-99.9}}, color=
          {0,0,127}));
  connect(Pump_RLT_Pump_VerteilerHot.y, controlBus.Pump_RLT_OpenPlanOffice_hot_y)
    annotation (Line(points={{-81,-64},{0.1,-64},{0.1,-99.9}}, color={0,0,127}));
  connect(Pump_RLT_Pump_VerteilerHot.y, controlBus.Pump_RLT_ConferenceRoom_hot_y)
    annotation (Line(points={{-81,-64},{0.1,-64},{0.1,-99.9}}, color={0,0,127}));
  connect(Pump_RLT_Pump_VerteilerHot.y, controlBus.Pump_RLT_MultiPersonOffice_hot_y)
    annotation (Line(points={{-81,-64},{0.1,-64},{0.1,-99.9}}, color={0,0,127}));
  connect(Pump_RLT_Pump_VerteilerHot.y, controlBus.Pump_RLT_Canteen_hot_y)
    annotation (Line(points={{-81,-64},{0.1,-64},{0.1,-99.9}}, color={0,0,127}));
  connect(Pump_RLT_Pump_VerteilerHot.y, controlBus.Pump_RLT_Workshop_hot_y)
    annotation (Line(points={{-81,-64},{0.1,-64},{0.1,-99.9}}, color={0,0,127}));
  connect(Pump_RLT_Pump_VerteilerHot.y, controlBus.Pump_RLT_Central_cold_y)
    annotation (Line(points={{-81,-64},{0.1,-64},{0.1,-99.9}}, color={0,0,127}));
  connect(Pump_RLT_Pump_VerteilerHot.y, controlBus.Pump_RLT_OpenPlanOffice_cold_y)
    annotation (Line(points={{-81,-64},{0.1,-64},{0.1,-99.9}}, color={0,0,127}));
  connect(Pump_RLT_Pump_VerteilerHot.y, controlBus.Pump_RLT_ConferenceRoom_cold_y)
    annotation (Line(points={{-81,-64},{0.1,-64},{0.1,-99.9}}, color={0,0,127}));
  connect(Pump_RLT_Pump_VerteilerHot.y, controlBus.Pump_RLT_MultiPersonOffice_cold_y)
    annotation (Line(points={{-81,-64},{0.1,-64},{0.1,-99.9}}, color={0,0,127}));
  connect(Pump_RLT_Pump_VerteilerHot.y, controlBus.Pump_RLT_Canteen_cold_y)
    annotation (Line(points={{-81,-64},{0.1,-64},{0.1,-99.9}}, color={0,0,127}));
  connect(Pump_RLT_Pump_VerteilerHot.y, controlBus.Pump_RLT_Workshop_cold_y)
    annotation (Line(points={{-81,-64},{0.1,-64},{0.1,-99.9}}, color={0,0,127}));
  connect(integerToReal1.y, greaterEqualThreshold1.u) annotation (Line(points=
         {{-183,-120},{-176,-120},{-176,-112},{-169.2,-112}}, color={0,0,127}));
  connect(lessEqualThreshold1.u, integerToReal1.y) annotation (Line(points={{
          -169.2,-130},{-176,-130},{-176,-120},{-183,-120}}, color={0,0,127}));
  connect(integerToReal1.u, measureBus.Hour) annotation (Line(points={{-206,
          -120},{-218,-120},{-218,90},{0.1,90},{0.1,100.1}}, color={255,127,0}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(lessEqualThreshold1.y, and1.u2) annotation (Line(points={{-155.4,
          -130},{-150,-130},{-150,-124},{-146,-124},{-146,-124.6},{-143.4,
          -124.6}}, color={255,0,255}));
  connect(greaterEqualThreshold1.y, and1.u1) annotation (Line(points={{-155.4,
          -112},{-150,-112},{-150,-120},{-146,-120},{-146,-119},{-143.4,-119}},
        color={255,0,255}));
  connect(and1.y, Pump_Verteiler.u2) annotation (Line(points={{-127.3,-119},{
          -124.65,-119},{-124.65,-120},{-102,-120}}, color={255,0,255}));
  connect(realExpression1.y, Pump_Verteiler.u1) annotation (Line(points={{
          -125,-100},{-122,-100},{-122,-112},{-102,-112}}, color={0,0,127}));
  connect(realExpression3.y, Pump_Verteiler.u3) annotation (Line(points={{
          -125,-140},{-124,-140},{-124,-128},{-102,-128}}, color={0,0,127}));
  connect(Pump_TBA.y, controlBus.Pump_TBA_OpenPlanOffice_y) annotation (Line(
        points={{-29,-36},{0.1,-36},{0.1,-99.9}}, color={0,0,127}));
  connect(Pump_TBA.y, controlBus.Pump_TBA_ConferenceRoom_y) annotation (Line(
        points={{-29,-36},{0.1,-36},{0.1,-99.9}}, color={0,0,127}));
  connect(Pump_TBA.y, controlBus.Pump_TBA_MultiPersonOffice_y) annotation (
      Line(points={{-29,-36},{0.1,-36},{0.1,-99.9}}, color={0,0,127}));
  connect(Pump_TBA.y, controlBus.Pump_TBA_Canteen_y) annotation (Line(points=
          {{-29,-36},{0.1,-36},{0.1,-99.9}}, color={0,0,127}));
  connect(Pump_TBA.y, controlBus.Pump_TBA_Workshop_y) annotation (Line(points=
         {{-29,-36},{0.1,-36},{0.1,-99.9}}, color={0,0,127}));
  connect(Pump_RLT_Pump_VerteilerHot.y, controlBus.Pump_Hotwater_y)
    annotation (Line(points={{-81,-64},{0.1,-64},{0.1,-99.9}}, color={0,0,127}));
  connect(Pump_Verteiler.y, controlBus.Pump_Warmwater_y) annotation (Line(
        points={{-79,-120},{0.1,-120},{0.1,-99.9}}, color={0,0,127}));
  connect(Pump_Verteiler.y, controlBus.Pump_Coldwater_y) annotation (Line(
        points={{-79,-120},{0.1,-120},{0.1,-99.9}}, color={0,0,127}));
  connect(Aircooler.u_m, measureBus.Aircooler) annotation (Line(points={{-62,
          26.8},{-62,22},{-72,22},{-72,90},{0.1,90},{0.1,100.1}}, color={0,0,
          127}));
  connect(or1.u2, controlBus.OnOff_heatpump_1) annotation (Line(points={{
          -65.2,57.2},{-72,57.2},{-72,-99.9},{0.1,-99.9}}, color={255,0,255}));
  connect(or1.u1, controlBus.OnOff_heatpump_2) annotation (Line(points={{
          -65.2,62},{-72,62},{-72,-99.9},{0.1,-99.9}}, color={255,0,255}));
  connect(switch1.y, controlBus.Pump_Warmwater_heatpump_1_y) annotation (Line(
        points={{-3,62},{0.1,62},{0.1,-99.9}}, color={0,0,127}));
  connect(switch1.y, controlBus.Pump_Warmwater_heatpump_2_y) annotation (Line(
        points={{-3,62},{0.1,62},{0.1,-99.9}}, color={0,0,127}));
  connect(switch3.u3, max.y) annotation (Line(points={{46,36},{36,36},{36,28},
          {-7,28}}, color={0,0,127}));
  connect(Heatpump3.y,switch3. u1) annotation (Line(points={{29,70},{36,70},{
          36,52},{46,52}}, color={0,0,127}));
  connect(switch3.y, controlBus.Pump_Aircooler_y) annotation (Line(points={{
          69,44},{78,44},{78,12},{0.1,12},{0.1,-99.9}}, color={0,0,127}));
  connect(switch3.u2, controlBus.OnOff_Aircooler_small) annotation (Line(
        points={{46,44},{0.1,44},{0.1,-99.9}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Pump_VariablePowerCost;
