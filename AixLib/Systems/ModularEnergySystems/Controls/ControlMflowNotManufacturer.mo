within AixLib.Systems.ModularEnergySystems.Controls;
model ControlMflowNotManufacturer

   parameter Modelica.SIunits.Temperature THotMax=333.15 "Max. value of THot before shutdown"
  annotation (Dialog(tab="NotManufacturer", group="General machine information"));
  parameter Modelica.SIunits.Temperature THotNom=313.15 "Nominal temperature of THot"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));
  parameter Modelica.SIunits.Temperature TSourceNom=278.15 "Nominal temperature of TSource"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));
  parameter Modelica.SIunits.HeatFlowRate QNom=150000
                                                     "Nominal heat flow"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));
  parameter Real PLRMin=0.4 "Limit of PLR; less =0"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));
  parameter Boolean HighTemp=false "true: THot > 60°C"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));
  parameter Modelica.SIunits.TemperatureDifference DeltaTCon=7 "Temperature difference heat sink condenser"
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
  Modelica.Blocks.Continuous.LimPID PI(
    controllerType=Modelica.Blocks.Types.SimpleController.PID,
    k=0.008,
    Ti=10,
    yMax=1,
    yMin=0.05,
    initType=Modelica.Blocks.Types.InitPID.InitialOutput,
    y_start=1,
    limitsAtInit=true)
            annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=0,
        origin={38,16})));
  Modelica.Blocks.Sources.RealExpression tHotNom1(y=THotNom)
    annotation (Placement(transformation(extent={{118,16},{100,44}})));
  Modelica.Blocks.Logical.Or or1
    annotation (Placement(transformation(extent={{40,52},{24,68}})));
  Modelica.Blocks.Logical.LessThreshold pLRMin(threshold=PLRMin)
    annotation (Placement(transformation(extent={{78,62},{62,78}})));
  Modelica.Blocks.Interfaces.BooleanInput Shutdown annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,0})));

  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{64,-30},{46,-12}})));
  Modelica.Blocks.Math.Gain gain1(k=-1)
    annotation (Placement(transformation(extent={{80,8},{64,24}})));
  Modelica.Blocks.Continuous.LimPID PI1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.008,
    Ti=10,
    yMax=1,
    yMin=0.5,
    initType=Modelica.Blocks.Types.InitPID.InitialOutput,
    y_start=1)
            annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=0,
        origin={-72,98})));
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
  Modelica.Blocks.Continuous.LimPID PI2(
    controllerType=Modelica.Blocks.Types.SimpleController.PID,
    k=0.004,
    Ti=20,
    yMax=1,
    yMin=0,
    initType=Modelica.Blocks.Types.InitPID.InitialOutput,
    y_start=1,
    limitsAtInit=true)
            annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=0,
        origin={-50,38})));
protected
   replaceable package MediumCon = AixLib.Media.Water constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium heat sink";

equation
  connect(PLR, pLRMin.u)
    annotation (Line(points={{120,70},{79.6,70}}, color={0,0,127}));
  connect(Shutdown, or1.u2) annotation (Line(points={{120,-8.88178e-16},{106,
          -8.88178e-16},{106,0},{92,0},{92,34},{46,34},{46,53.6},{41.6,53.6}},
                                      color={255,0,255}));
  connect(pLRMin.y, or1.u1) annotation (Line(points={{61.2,70},{54,70},{54,60},
          {41.6,60}},color={255,0,255}));
  connect(tHotNom1.y, gain1.u) annotation (Line(points={{99.1,30},{90,30},{90,
          16},{81.6,16}},      color={0,0,127}));
  connect(THot, gain.u) annotation (Line(points={{120,-40},{90,-40},{90,-21},{
          65.8,-21}},                 color={0,0,127}));
  connect(gain.y, PI.u_m) annotation (Line(points={{45.1,-21},{38,-21},{38,6.4}},
                        color={0,0,127}));
  connect(gain1.y, PI.u_s) annotation (Line(points={{63.2,16},{47.6,16}},
                                  color={0,0,127}));
  connect(add.y, gain3.u)
    annotation (Line(points={{-6.7,99},{-26.2,99}}, color={0,0,127}));
  connect(tHotNom3.y, add.u1) annotation (Line(points={{76.2,103},{9.4,103.2}},
                               color={0,0,127}));
  connect(TCold, add.u2) annotation (Line(points={{120,-90},{94,-90},{94,94.8},
          {9.4,94.8}}, color={0,0,127}));
  connect(THot, gain2.u) annotation (Line(points={{120,-40},{90,-40},{90,83},{
          -8.2,83}},  color={0,0,127}));
  connect(gain2.y, PI1.u_m) annotation (Line(points={{-28.9,83},{-72,83},{-72,
          88.4}}, color={0,0,127}));
  connect(gain3.y, PI1.u_s) annotation (Line(points={{-46.9,99},{-54,99},{-54,
          98},{-62.4,98}}, color={0,0,127}));
  connect(or1.y, switch1.u2) annotation (Line(points={{23.2,60},{6,60},{6,52},{
          -30,52},{-30,0},{-66.4,0}}, color={255,0,255}));
  connect(PI.y, switch1.u3) annotation (Line(points={{29.2,16},{20,16},{20,18},
          {8,18},{8,-6.4},{-66.4,-6.4}}, color={0,0,127}));
  connect(gain.y, PI2.u_m) annotation (Line(points={{45.1,-21},{-50,-21},{-50,
          28.4}}, color={0,0,127}));
  connect(gain1.y, PI2.u_s) annotation (Line(points={{63.2,16},{32,16},{32,20},
          {-40.4,20},{-40.4,38}}, color={0,0,127}));
  connect(PI2.y, switch1.u1) annotation (Line(points={{-58.8,38},{-66.4,38},{
          -66.4,6.4}}, color={0,0,127}));
  connect(switch1.y, mFlowCon)
    annotation (Line(points={{-84.8,0},{-112,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                      Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255})}),                            Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Control unit of the relativ condenser water mass flow [0,1] for two different operation methods:</p>
<ul>
<li>constant THot </li>
<li>constant temperature difference between THot and TCold</li>
</ul>
<p><br>A Shutdown is controlled with a degressiv decrease of warter mass flow to avoid non physical behaviour.</p>
</html>"));
end ControlMflowNotManufacturer;
