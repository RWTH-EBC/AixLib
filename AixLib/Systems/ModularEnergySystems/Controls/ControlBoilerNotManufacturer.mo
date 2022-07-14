within AixLib.Systems.ModularEnergySystems.Controls;
model ControlBoilerNotManufacturer

    parameter Modelica.Units.SI.TemperatureDifference DeltaTWaterNom=20 "Temperature difference nominal";
  parameter Modelica.Units.SI.Temperature TColdNom=273.15+35 "Return temperature TCold";
  parameter Modelica.Units.SI.HeatFlowRate QNom=50000 "Thermal dimension power";
  parameter Boolean m_flowVar=false "Use variable water massflow";

  parameter Boolean Pump=true "Model includes a pump";



  parameter Boolean Advanced=false "dTWater is constant for different PLR";

  parameter Modelica.Units.SI.TemperatureDifference dTWaterSet=15 "Temperature difference setpoint";

  parameter Modelica.Units.SI.Temperature THotMax=273.15+90 "Maximal temperature to force shutdown";
  parameter Real PLRMin=0.15 "Minimal Part Load Ratio";

  parameter Modelica.Units.SI.Temperature TStart=273.15+20 "T start";


  replaceable package Medium =Media.Water constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium heat source"
      annotation (choices(
        choice(redeclare package Medium = AixLib.Media.Water "Water"),
        choice(redeclare package Medium =
            AixLib.Media.Antifreeze.PropyleneGlycolWater (
              property_T=293.15,
              X_a=0.40)
              "Propylene glycol water, 40% mass fraction")));


  Modelica.Blocks.Continuous.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.01,
    Ti=10,
    yMax=1,
    yMin=0) annotation (Placement(transformation(extent={{4,50},{24,70}})));
  Modelica.Blocks.Math.Add add(k1=-1)
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  Modelica.Blocks.Logical.Switch switch6
    annotation (Placement(transformation(extent={{-98,70},{-78,50}})));
  Modelica.Blocks.Logical.Switch switch5
    annotation (Placement(transformation(extent={{42,90},{62,70}})));
  Modelica.Blocks.Interfaces.RealOutput mFlowRel "relative mass flow [0, 1]"
    annotation (Placement(transformation(extent={{120,78},{140,98}})));
  Modelica.Blocks.Interfaces.RealInput DeltaTWater_a
    "Temperature difference Water"
    annotation (Placement(transformation(extent={{-140,-50},{-100,-10}})));
  Modelica.Blocks.Sources.RealExpression dTSetpointReal2(y=dTWaterSet)
    "Real input temperature difference setpoint"
    annotation (Placement(transformation(extent={{-42,-24},{-10,-4}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=m_flowVar)
    annotation (Placement(transformation(extent={{-100,-106},{-82,-86}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{0,-32},{20,-12}})));
  Modelica.Blocks.Logical.Or or1
    annotation (Placement(transformation(extent={{-10,-90},{10,-70}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=Advanced)
    annotation (Placement(transformation(extent={{-100,-80},{-74,-60}})));
  Modelica.Blocks.Logical.Change change1
    annotation (Placement(transformation(extent={{-56,-80},{-36,-60}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{58,-62},{78,-42}})));
  Modelica.Blocks.Sources.RealExpression dTWaterNom(y=DeltaTWaterNom)
    "Real input temperature difference dimension point"
    annotation (Placement(transformation(extent={{24,-70},{50,-52}})));
  Modelica.Blocks.Interfaces.RealInput THot "Temperature hot water"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput DeltaTWater_b
    annotation (Placement(transformation(extent={{100,-62},{120,-42}})));
  Modelica.Blocks.Sources.RealExpression realOne(y=1)
    annotation (Placement(transformation(extent={{-24,82},{-14,98}})));
  Modelica.Blocks.Interfaces.RealInput TCold "Temperature hot water"
    annotation (Placement(transformation(extent={{-140,10},{-100,50}})));
  Modelica.Blocks.Math.Gain gain2(k=-1)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-24,60})));
  Modelica.Blocks.Math.Gain gain1(k=-1)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-20,20})));
  Modelica.Blocks.Logical.LessThreshold pLRMin(threshold=PLRMin)
    annotation (Placement(transformation(extent={{-86,144},{-66,164}})));
  Modelica.Blocks.Logical.Switch switch4
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-26,154})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={74,132})));
  Modelica.Blocks.Logical.Greater greater
    annotation (Placement(transformation(extent={{-30,110},{-10,130}})));
  Modelica.Blocks.Sources.RealExpression tHotMax(y=THotMax)
    annotation (Placement(transformation(extent={{-78,100},{-50,124}})));
  Modelica.Blocks.Interfaces.RealInput plr_a "Part load ratio input"
    annotation (Placement(transformation(extent={{-140,134},{-100,174}})));
  Modelica.Blocks.Interfaces.RealOutput plr_b "part load ratio outout"
    annotation (Placement(transformation(extent={{100,122},{120,142}})));
  Modelica.Blocks.Logical.Switch switch7
    annotation (Placement(transformation(extent={{84,98},{104,78}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{-100,180},{-80,200}})));
equation
  connect(booleanExpression.y,or1. u2) annotation (Line(points={{-81.1,-96},{
          -50,-96},{-50,-88},{-12,-88}},
                                     color={255,0,255}));
  connect(or1.y,switch1. u2) annotation (Line(points={{11,-80},{20,-80},{20,-52},
          {56,-52}},   color={255,0,255}));
  connect(booleanExpression1.y,switch2. u2) annotation (Line(points={{-72.7,-70},
          {-64,-70},{-64,-22},{-2,-22}},                            color={255,0,
          255}));
  connect(switch1.y, switch6.u1) annotation (Line(points={{79,-52},{84,-52},{84,
          -116},{-146,-116},{-146,52},{-100,52}},
                                                color={0,0,127}));
  connect(or1.y, switch6.u2) annotation (Line(points={{11,-80},{20,-80},{20,-52},
          {-138,-52},{-138,60},{-100,60}},      color={255,0,255}));
  connect(dTSetpointReal2.y,switch2. u1) annotation (Line(points={{-8.4,-14},{
          -2,-14}},                       color={0,0,127}));
  connect(booleanExpression1.y,change1. u) annotation (Line(points={{-72.7,-70},
          {-58,-70}},                    color={255,0,255}));
  connect(or1.u1,change1. y) annotation (Line(points={{-12,-80},{-32,-80},{-32,
          -70},{-35,-70}},   color={255,0,255}));
  connect(switch2.y, switch6.u3) annotation (Line(points={{21,-22},{26,-22},{26,
          -46},{-156,-46},{-156,68},{-100,68}},       color={0,0,127}));
  connect(or1.y, switch5.u2) annotation (Line(points={{11,-80},{18,-80},{18,-48},
          {34,-48},{34,80},{40,80}},        color={255,0,255}));
  connect(switch2.y,switch1. u1) annotation (Line(points={{21,-22},{42,-22},{42,
          -44},{56,-44}},             color={0,0,127}));
  connect(DeltaTWater_a, switch2.u3)
    annotation (Line(points={{-120,-30},{-2,-30}},  color={0,0,127}));
  connect(dTWaterNom.y, switch1.u3)
    annotation (Line(points={{51.3,-61},{56,-61},{56,-60}}, color={0,0,127}));
  connect(switch1.y, DeltaTWater_b)
    annotation (Line(points={{79,-52},{110,-52}}, color={0,0,127}));
  connect(realOne.y, switch5.u3)
    annotation (Line(points={{-13.5,90},{34,90},{34,88},{40,88}},
                                                 color={0,0,127}));
  connect(PID.y, switch5.u1) annotation (Line(points={{25,60},{40,60},{40,72}},
                   color={0,0,127}));
  connect(THot, add.u2) annotation (Line(points={{-120,0},{-80,0},{-80,14},{-62,
          14}}, color={0,0,127}));
  connect(TCold, add.u1) annotation (Line(points={{-120,30},{-80,30},{-80,26},{
          -62,26}}, color={0,0,127}));
  connect(switch6.y, gain2.u)
    annotation (Line(points={{-77,60},{-36,60}}, color={0,0,127}));
  connect(gain2.y, PID.u_s)
    annotation (Line(points={{-13,60},{2,60}}, color={0,0,127}));
  connect(add.y, gain1.u)
    annotation (Line(points={{-39,20},{-32,20}}, color={0,0,127}));
  connect(gain1.y, PID.u_m)
    annotation (Line(points={{-9,20},{14,20},{14,48}}, color={0,0,127}));
  connect(pLRMin.y, switch4.u2)
    annotation (Line(points={{-65,154},{-38,154}}, color={255,0,255}));
  connect(tHotMax.y, greater.u2)
    annotation (Line(points={{-48.6,112},{-32,112}}, color={0,0,127}));
  connect(THot, greater.u1) annotation (Line(points={{-120,0},{-80,0},{-80,120},
          {-32,120}}, color={0,0,127}));
  connect(greater.y, switch3.u2) annotation (Line(points={{-9,120},{28,120},{28,
          132},{62,132}}, color={255,0,255}));
  connect(switch4.y, switch3.u3) annotation (Line(points={{-15,154},{40,154},{
          40,124},{62,124}}, color={0,0,127}));
  connect(plr_a, pLRMin.u)
    annotation (Line(points={{-120,154},{-88,154}}, color={0,0,127}));
  connect(plr_a, switch4.u3) annotation (Line(points={{-120,154},{-96,154},{-96,
          130},{-48,130},{-48,146},{-38,146}}, color={0,0,127}));
  connect(switch3.y, plr_b)
    annotation (Line(points={{85,132},{110,132}}, color={0,0,127}));
  connect(switch7.y, mFlowRel)
    annotation (Line(points={{105,88},{130,88}}, color={0,0,127}));
  connect(switch5.y, switch7.u1)
    annotation (Line(points={{63,80},{82,80}}, color={0,0,127}));
  connect(pLRMin.y, switch7.u2) annotation (Line(points={{-65,154},{-44,154},{
          -44,100},{-28,100},{-28,102},{74,102},{74,88},{82,88}}, color={255,0,
          255}));
  connect(const.y, switch4.u1) annotation (Line(points={{-79,190},{-60,190},{
          -60,162},{-38,162}}, color={0,0,127}));
  connect(const.y, switch3.u1) annotation (Line(points={{-79,190},{-60,190},{
          -60,162},{-44,162},{-44,168},{56,168},{56,140},{62,140}}, color={0,0,
          127}));
  connect(const.y, switch7.u3) annotation (Line(points={{-79,190},{-60,190},{
          -60,162},{-44,162},{-44,168},{56,168},{56,104},{82,104},{82,96}},
        color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,200}}),                                  graphics={
                                      Rectangle(
          extent={{-100,200},{100,-100}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255})}),                            Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            200}})),
    Documentation(info="<html>
<p>Boiler control unit, which estimates the relative water mass flow and chooses the right water temperature difference.</p>
</html>"));
end ControlBoilerNotManufacturer;
