within AixLib.Systems.ModularEnergySystems.Controls;
model ControlMflowNotManufacturer

   parameter Modelica.Units.SI.Temperature THotMax=333.15 "Max. value of THot before shutdown"
  annotation (Dialog(tab="NotManufacturer", group="General machine information"));
  parameter Modelica.Units.SI.Temperature THotNom=313.15 "Nominal temperature of THot"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));
  parameter Modelica.Units.SI.Temperature TSourceNom=278.15 "Nominal temperature of TSource"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));
  parameter Modelica.Units.SI.HeatFlowRate QNom=150000
                                                     "Nominal heat flow"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));
  parameter Real PLRMin=0.4 "Limit of PLR; less =0"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));
  parameter Boolean HighTemp=false "true: THot > 60°C"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));
  parameter Modelica.Units.SI.TemperatureDifference DeltaTCon=7 "Temperature difference heat sink condenser"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));


  Modelica.Blocks.Interfaces.RealInput THot annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,-40})));
  Modelica.Blocks.Interfaces.RealOutput mFlowCon
    annotation (Placement(transformation(extent={{-100,-12},{-124,12}})));
  Modelica.Blocks.Interfaces.RealInput PLR annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,70})));
  Modelica.Blocks.Sources.RealExpression tHotNom1(y=THotNom)
    annotation (Placement(transformation(extent={{136,16},{100,44}})));
  Modelica.Blocks.Logical.Or or1
    annotation (Placement(transformation(extent={{40,52},{24,68}})));
  Modelica.Blocks.Logical.LessThreshold pLRMin(threshold=PLRMin)
    annotation (Placement(transformation(extent={{78,62},{62,78}})));

  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{64,-30},{46,-12}})));
  Modelica.Blocks.Math.Gain gain1(k=-1)
    annotation (Placement(transformation(extent={{80,8},{64,24}})));
  Modelica.Blocks.Math.Gain gain2(k=-1)
    annotation (Placement(transformation(extent={{-10,74},{-28,92}})));
  Modelica.Blocks.Math.Gain gain3(k=-1)
    annotation (Placement(transformation(extent={{-28,90},{-46,108}})));
  Modelica.Blocks.Interfaces.RealInput TCold
                                            annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,-90})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{7,-7},{-7,7}},
        rotation=0,
        origin={1,99})));
  Modelica.Blocks.Sources.RealExpression tHotNom3(y=DeltaTCon)
    annotation (Placement(transformation(extent={{114,90},{78,116}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{8,-8},{-8,8}},
        rotation=0,
        origin={-76,0})));
  AixLib.Controls.Continuous.LimPID conPID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.008,
    Ti=10,
    yMin=0.5,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    xi_start=0,
    y_start=1)
    annotation (Placement(transformation(extent={{-82,88},{-104,110}})));
  AixLib.Controls.Continuous.LimPID conPID1(
    controllerType=Modelica.Blocks.Types.SimpleController.PID,
    k=0.004,
    Ti=20,
    yMin=0.1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    xi_start=0,
    y_start=1)
    annotation (Placement(transformation(extent={{-36,30},{-56,50}})));
  AixLib.Controls.Continuous.LimPID conPID2(
    controllerType=Modelica.Blocks.Types.SimpleController.PID,
    k=0.008,
    Ti=10,
    yMin=0.1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    xi_start=0,
    y_start=1)
    annotation (Placement(transformation(extent={{-26,-42},{-46,-22}})));
  Modelica.Blocks.Logical.Greater greater
    annotation (Placement(transformation(extent={{-18,-88},{-34,-72}})));
  Modelica.Blocks.Sources.RealExpression tHotMax(y=THotMax - DeltaTCon)
    "Maximal THot"
    annotation (Placement(transformation(extent={{76,-108},{8,-82}})));
  Modelica.Blocks.Interfaces.BooleanOutput schutdown annotation (Placement(
        transformation(extent={{-100,-90},{-120,-70}}), iconTransformation(
          extent={{-100,-90},{-120,-70}})));
  Modelica.Blocks.Logical.Greater greater1
    annotation (Placement(transformation(extent={{-18,-122},{-34,-106}})));
  Modelica.Blocks.Logical.Or or2
    annotation (Placement(transformation(extent={{-56,-104},{-72,-88}})));
protected
   replaceable package MediumCon = AixLib.Media.Water constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium heat sink";

equation
  connect(PLR, pLRMin.u)
    annotation (Line(points={{120,70},{79.6,70}}, color={0,0,127}));
  connect(pLRMin.y, or1.u1) annotation (Line(points={{61.2,70},{54,70},{54,60},
          {41.6,60}},color={255,0,255}));
  connect(tHotNom1.y, gain1.u) annotation (Line(points={{98.2,30},{88,30},{88,
          16},{81.6,16}},      color={0,0,127}));
  connect(THot, gain.u) annotation (Line(points={{120,-40},{90,-40},{90,-21},{
          65.8,-21}},                 color={0,0,127}));
  connect(add.y, gain3.u)
    annotation (Line(points={{-6.7,99},{-26.2,99}}, color={0,0,127}));
  connect(tHotNom3.y, add.u1) annotation (Line(points={{76.2,103},{9.4,103.2}},
                               color={0,0,127}));
  connect(TCold, add.u2) annotation (Line(points={{120,-90},{94,-90},{94,94.8},
          {9.4,94.8}}, color={0,0,127}));
  connect(THot, gain2.u) annotation (Line(points={{120,-40},{90,-40},{90,83},{
          -8.2,83}},  color={0,0,127}));
  connect(or1.y, switch1.u2) annotation (Line(points={{23.2,60},{6,60},{6,52},{
          -30,52},{-30,0},{-66.4,0}}, color={255,0,255}));
  connect(switch1.y, mFlowCon)
    annotation (Line(points={{-84.8,0},{-112,0}}, color={0,0,127}));
  connect(conPID.u_s, gain3.y)
    annotation (Line(points={{-79.8,99},{-46.9,99}}, color={0,0,127}));
  connect(conPID.u_m, gain2.y) annotation (Line(points={{-93,85.8},{-93,83},{
          -28.9,83}}, color={0,0,127}));
  connect(gain.y, conPID1.u_m) annotation (Line(points={{45.1,-21},{28,-21},{28,
          -14},{6,-14},{6,2},{-46,2},{-46,28}}, color={0,0,127}));
  connect(gain1.y, conPID1.u_s) annotation (Line(points={{63.2,16},{-28,16},{
          -28,40},{-34,40}}, color={0,0,127}));
  connect(conPID1.y, switch1.u1) annotation (Line(points={{-57,40},{-66.4,40},{
          -66.4,6.4}}, color={0,0,127}));
  connect(gain1.y, conPID2.u_s) annotation (Line(points={{63.2,16},{-10,16},{
          -10,-30},{-24,-30},{-24,-32}}, color={0,0,127}));
  connect(gain.y, conPID2.u_m) annotation (Line(points={{45.1,-21},{28,-21},{28,
          -54},{-36,-54},{-36,-44}}, color={0,0,127}));
  connect(conPID2.y, switch1.u3) annotation (Line(points={{-47,-32},{-56,-32},{
          -56,-6.4},{-66.4,-6.4}},                     color={0,0,127}));
  connect(tHotMax.y, greater.u2) annotation (Line(points={{4.6,-95},{4.6,-96},{
          -16.4,-96},{-16.4,-86.4}}, color={0,0,127}));
  connect(THot, greater.u1) annotation (Line(points={{120,-40},{80,-40},{80,-80},
          {-16.4,-80}}, color={0,0,127}));
  connect(TCold, greater1.u1) annotation (Line(points={{120,-90},{102,-90},{102,
          -94},{82,-94},{82,-114},{-16.4,-114}}, color={0,0,127}));
  connect(tHotNom1.y, greater1.u2) annotation (Line(points={{98.2,30},{94,30},{
          94,-120.4},{-16.4,-120.4}}, color={0,0,127}));
  connect(greater1.y, or2.u2) annotation (Line(points={{-34.8,-114},{-38,-114},
          {-38,-112},{-40,-112},{-40,-102.4},{-54.4,-102.4}}, color={255,0,255}));
  connect(greater.y, or2.u1) annotation (Line(points={{-34.8,-80},{-44,-80},{
          -44,-96},{-54.4,-96}}, color={255,0,255}));
  connect(or1.u2, or2.y) annotation (Line(points={{41.6,53.6},{44,53.6},{44,-64},
          {-78,-64},{-78,-96},{-72.8,-96}}, color={255,0,255}));
  connect(or2.y, schutdown) annotation (Line(points={{-72.8,-96},{-84,-96},{-84,
          -80},{-110,-80}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                      Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255})}),                            Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  Control unit of the relativ condenser water mass flow [0,1] for two
  different operation methods:
</p>
<ul>
  <li>constant THot
  </li>
  <li>constant temperature difference between THot and TCold
  </li>
</ul>
<p>
  <br/>
  A Shutdown is controlled with a degressiv decrease of warter mass
  flow to avoid non physical behaviour.
</p>
</html>"));
end ControlMflowNotManufacturer;
