within AixLib.Systems.ModularEnergySystems.Modules.ModularHeatPump.BaseClasses;
model ModularControl



  parameter Modelica.Units.SI.TemperatureDifference DeltaTCon=7 "Temperature difference heat sink condenser"
   annotation (Dialog(tab="Advanced",group="General machine information"));

   parameter Modelica.Units.SI.Temperature THotNom=313.15 "Temperature difference heat sink condenser"
   annotation (Dialog(tab="Advanced",group="General machine information"));


 parameter Boolean Modulating=true "Is the heat pump inverter-driven?";


  Modelica.Blocks.Sources.BooleanExpression mode(y=true)
    annotation (Placement(transformation(extent={{-224,66},{-260,92}})));
  AixLib.Controls.Continuous.LimPID conPID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.05,
    Ti=1,
    yMax=1,
    Td=1,
    yMin=0.2)
    annotation (Placement(transformation(extent={{-196,-12},{-176,8}})));
  Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold
    annotation (Placement(transformation(extent={{-58,6},{-38,26}})));
  AixLib.Controls.Interfaces.VapourCompressionMachineControlBus sigBus1
                                                                       annotation (
      Placement(transformation(extent={{-302,24},{-272,58}}),
        iconTransformation(extent={{-108,-52},{-90,-26}})));
  Modelica.Blocks.Interfaces.RealInput tCold
    annotation (Placement(transformation(extent={{-340,-20},{-300,20}})));
  AixLib.Controls.Continuous.LimPID conPID1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.005,
    Ti=30,
    yMax=1,
    Td=1,
    yMin=0.25)
    annotation (Placement(transformation(extent={{48,-84},{68,-64}})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{-168,-174},{-148,-154}})));
  Modelica.Blocks.Math.Add add1(k2=-1)
    annotation (Placement(transformation(extent={{0,-52},{20,-32}})));
  Modelica.Blocks.Sources.RealExpression tColdNom1(y=DeltaTCon)
    "Nominal TCold"
    annotation (Placement(transformation(extent={{-262,-178},{-200,-150}})));
  Modelica.Blocks.Interfaces.RealInput tHot
    annotation (Placement(transformation(extent={{-340,-56},{-300,-16}})));
  Modelica.Blocks.Sources.BooleanExpression modulating(y=Modulating)
    annotation (Placement(transformation(extent={{-168,94},{-128,114}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-68,94},{-48,114}})));
  Modelica.Blocks.Sources.RealExpression tColdNom3(y=1)
    "Nominal TCold"
    annotation (Placement(transformation(extent={{-202,64},{-140,92}})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{112,-38},{132,-18}})));
  Modelica.Blocks.Sources.RealExpression tColdNom2(y=0)
    "Nominal TCold"
    annotation (Placement(transformation(extent={{12,60},{60,92}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{66,-46},{86,-26}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T=10)
    annotation (Placement(transformation(extent={{140,20},{160,40}})));
  Modelica.Blocks.Logical.Switch switch4
    annotation (Placement(transformation(extent={{-92,-82},{-72,-62}})));
  Modelica.Blocks.Math.Add add2(k2=-1)
    annotation (Placement(transformation(extent={{-178,-132},{-158,-112}})));
  Modelica.Blocks.Sources.RealExpression tColdNom4(y=THotNom)
    "Nominal TCold"
    annotation (Placement(transformation(extent={{-266,-102},{-204,-74}})));
  Modelica.Blocks.Logical.Switch switch5
    annotation (Placement(transformation(extent={{-2,-108},{18,-88}})));
equation
  connect(mode.y, sigBus1.modeSet) annotation (Line(points={{-261.8,79},{-261.8,
          78},{-286.925,78},{-286.925,41.085}},                     color={255,
          0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBus1.THotSet, conPID.u_s) annotation (Line(
      points={{-286.925,41.085},{-262,41.085},{-262,-2},{-198,-2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBus1.QRel, lessEqualThreshold.u) annotation (Line(
      points={{-286.925,41.085},{-286.925,16},{-60,16}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));

  connect(sigBus1.TConOutMea, conPID.u_m) annotation (Line(
      points={{-286.925,41.085},{-262,41.085},{-262,-14},{-186,-14}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(tCold, add1.u1) annotation (Line(points={{-320,0},{-280,0},{-280,-36},
          {-2,-36}}, color={0,0,127}));
  connect(tHot, add1.u2)
    annotation (Line(points={{-320,-36},{-2,-36},{-2,-48}}, color={0,0,127}));
  connect(tColdNom1.y, gain.u) annotation (Line(points={{-196.9,-164},{-170,-164}},
                                                       color={0,0,127}));
  connect(modulating.y, switch1.u2)
    annotation (Line(points={{-126,104},{-70,104}}, color={255,0,255}));
  connect(tColdNom3.y, switch1.u3) annotation (Line(points={{-136.9,78},{-108,
          78},{-108,96},{-70,96}},                 color={0,0,127}));
  connect(switch1.y, sigBus1.nSet) annotation (Line(points={{-47,104},{-12,104},
          {-12,58},{-286.925,58},{-286.925,41.085}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(conPID.y, switch1.u1) annotation (Line(points={{-175,-2},{-116,-2},{
          -116,112},{-70,112}}, color={0,0,127}));
  connect(switch3.y, sigBus1.mFlowSet) annotation (Line(points={{133,-28},{138,-28},
          {138,-10},{-170,-10},{-170,-22},{-278,-22},{-278,14},{-286.925,14},{-286.925,
          41.085}},                             color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(conPID1.y, switch2.u3) annotation (Line(points={{69,-74},{92,-74},{92,
          -60},{54,-60},{54,-44},{64,-44}}, color={0,0,127}));
  connect(tColdNom2.y, switch2.u1) annotation (Line(points={{62.4,76},{72,76},{72,
          74},{78,74},{78,16},{46,16},{46,-28},{64,-28}}, color={0,0,127}));
  connect(conPID1.y, switch3.u3) annotation (Line(points={{69,-74},{86,-74},{86,
          -72},{102,-72},{102,-36},{110,-36}}, color={0,0,127}));
  connect(lessEqualThreshold.y, switch2.u2) annotation (Line(points={{-37,16},{-20,
          16},{-20,12},{34,12},{34,-36},{64,-36}}, color={255,0,255}));
  connect(lessEqualThreshold.y, switch3.u2) annotation (Line(points={{-37,16},{100,
          16},{100,-28},{110,-28}}, color={255,0,255}));
  connect(switch2.y, firstOrder.u) annotation (Line(points={{87,-36},{92,-36},{92,
          -30},{106,-30},{106,30},{138,30}}, color={0,0,127}));
  connect(firstOrder.y, switch3.u1) annotation (Line(points={{161,30},{172,30},{
          172,28},{182,28},{182,2},{78,2},{78,-20},{110,-20}}, color={0,0,127}));
  connect(gain.y, switch4.u3) annotation (Line(points={{-147,-164},{-110,-164},{
          -110,-80},{-94,-80}}, color={0,0,127}));
  connect(switch4.y, conPID1.u_s) annotation (Line(points={{-71,-72},{-46,-72},{
          -46,-74},{46,-74}}, color={0,0,127}));
  connect(modulating.y, switch4.u2) annotation (Line(points={{-126,104},{-114,104},
          {-114,-72},{-94,-72}}, color={255,0,255}));
  connect(tColdNom1.y, add2.u2) annotation (Line(points={{-196.9,-164},{-192,-164},
          {-192,-162},{-180,-162},{-180,-128}}, color={0,0,127}));
  connect(tColdNom4.y, add2.u1) annotation (Line(points={{-200.9,-88},{-180,-88},
          {-180,-114},{-180,-114},{-180,-116}}, color={0,0,127}));
  connect(add2.y, switch4.u1) annotation (Line(points={{-157,-122},{-142,-122},
          {-142,-64},{-94,-64}}, color={0,0,127}));
  connect(add1.y, switch5.u3) annotation (Line(points={{21,-42},{30,-42},{30,
          -80},{-10,-80},{-10,-106},{-4,-106}}, color={0,0,127}));
  connect(tCold, switch5.u1) annotation (Line(points={{-320,0},{-302,0},{-302,
          -48},{-30,-48},{-30,-90},{-4,-90}}, color={0,0,127}));
  connect(switch5.y, conPID1.u_m)
    annotation (Line(points={{19,-98},{58,-98},{58,-86}}, color={0,0,127}));
  connect(modulating.y, switch5.u2) annotation (Line(points={{-126,104},{-108,
          104},{-108,98},{-86,98},{-86,-98},{-4,-98}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-320,
            -100},{100,160}})), Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-320,-100},{100,160}})));
end ModularControl;
