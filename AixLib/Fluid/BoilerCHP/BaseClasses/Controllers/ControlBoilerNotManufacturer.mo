within AixLib.Fluid.BoilerCHP.BaseClasses.Controllers;
model ControlBoilerNotManufacturer

    parameter Modelica.SIunits.TemperatureDifference DeltaTWaterNom=20 "Temperature difference nominal";
  parameter Modelica.SIunits.Temperature TColdNom=273.15+35 "Return temperature TCold";
  parameter Modelica.SIunits.HeatFlowRate QNom=50000 "Thermal dimension power";
  parameter Boolean m_flowVar=false "Use variable water massflow";

  parameter Boolean Pump=true "Model includes a pump";



  parameter Boolean Advanced=false "dTWater is constant for different PLR";

  parameter Modelica.SIunits.TemperatureDifference dTWaterSet=15 "Temperature difference setpoint";

  parameter Modelica.SIunits.Temperature THotMax=273.15+90 "Maximal temperature to force shutdown";
  parameter Real PLRMin=0.15 "Minimal Part Load Ratio";

  parameter Modelica.SIunits.Temperature TStart=273.15+20 "T start";


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
    Ti=5,
    yMax=1,
    yMin=0) annotation (Placement(transformation(extent={{-16,24},{4,44}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1, uMin=0)
    annotation (Placement(transformation(extent={{18,24},{38,44}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=TColdNom)
    annotation (Placement(transformation(extent={{-82,20},{-62,38}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-50,24},{-30,44}})));
  Modelica.Blocks.Logical.Switch switch6
    annotation (Placement(transformation(extent={{-86,68},{-66,48}})));
  Modelica.Blocks.Logical.Switch switch5
    annotation (Placement(transformation(extent={{64,82},{84,62}})));
  Modelica.Blocks.Interfaces.RealOutput mFlowRel "relative mass flow [0, 1]"
    annotation (Placement(transformation(extent={{100,62},{120,82}})));
  Modelica.Blocks.Interfaces.RealInput DeltaTWater_a
    "Temperature difference Water"
    annotation (Placement(transformation(extent={{-140,-50},{-100,-10}})));
  Modelica.Blocks.Sources.RealExpression dTSetpointReal2(y=dTWaterSet)
    "Real input temperature difference setpoint"
    annotation (Placement(transformation(extent={{-30,-24},{-10,-4}})));
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
    annotation (Placement(transformation(extent={{28,-70},{50,-52}})));
  Modelica.Blocks.Interfaces.RealInput THot "Temperature hot water"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput DeltaTWater_b
    annotation (Placement(transformation(extent={{100,-62},{120,-42}})));
  Modelica.Blocks.Sources.RealExpression realOne(y=1)
    annotation (Placement(transformation(extent={{40,72},{50,88}})));
equation
  connect(PID.y,limiter. u) annotation (Line(points={{5,34},{16,34}},
                            color={0,0,127}));
  connect(realExpression4.y,add. u2) annotation (Line(points={{-61,29},{-52,29},
          {-52,28}},        color={0,0,127}));
  connect(switch6.y,add. u1) annotation (Line(points={{-65,58},{-60,58},{-60,40},
          {-52,40}},                            color={0,0,127}));
  connect(switch5.y, mFlowRel)
    annotation (Line(points={{85,72},{110,72}}, color={0,0,127}));
  connect(add.y, PID.u_s) annotation (Line(points={{-29,34},{-18,34}},
                color={0,0,127}));
  connect(booleanExpression.y,or1. u2) annotation (Line(points={{-81.1,-96},{
          -50,-96},{-50,-88},{-12,-88}},
                                     color={255,0,255}));
  connect(or1.y,switch1. u2) annotation (Line(points={{11,-80},{20,-80},{20,-52},
          {56,-52}},   color={255,0,255}));
  connect(booleanExpression1.y,switch2. u2) annotation (Line(points={{-72.7,-70},
          {-64,-70},{-64,-22},{-2,-22}},                            color={255,0,
          255}));
  connect(switch1.y, switch6.u1) annotation (Line(points={{79,-52},{90,-52},{90,
          -116},{-140,-116},{-140,50},{-88,50}},color={0,0,127}));
  connect(or1.y, switch6.u2) annotation (Line(points={{11,-80},{20,-80},{20,-52},
          {-138,-52},{-138,58},{-88,58}},       color={255,0,255}));
  connect(dTSetpointReal2.y,switch2. u1) annotation (Line(points={{-9,-14},{-2,
          -14}},                          color={0,0,127}));
  connect(booleanExpression1.y,change1. u) annotation (Line(points={{-72.7,-70},
          {-58,-70}},                    color={255,0,255}));
  connect(or1.u1,change1. y) annotation (Line(points={{-12,-80},{-32,-80},{-32,
          -70},{-35,-70}},   color={255,0,255}));
  connect(switch2.y, switch6.u3) annotation (Line(points={{21,-22},{26,-22},{26,
          -46},{-156,-46},{-156,66},{-88,66}},        color={0,0,127}));
  connect(or1.y, switch5.u2) annotation (Line(points={{11,-80},{20,-80},{20,-52},
          {-138,-52},{-138,72},{62,72}},    color={255,0,255}));
  connect(switch2.y,switch1. u1) annotation (Line(points={{21,-22},{42,-22},{42,
          -44},{56,-44}},             color={0,0,127}));
  connect(DeltaTWater_a, switch2.u3)
    annotation (Line(points={{-120,-30},{-2,-30}},  color={0,0,127}));
  connect(PID.u_m, THot)
    annotation (Line(points={{-6,22},{-6,0},{-120,0}},     color={0,0,127}));
  connect(dTWaterNom.y, switch1.u3)
    annotation (Line(points={{51.1,-61},{56,-61},{56,-60}}, color={0,0,127}));
  connect(switch1.y, DeltaTWater_b)
    annotation (Line(points={{79,-52},{110,-52}}, color={0,0,127}));
  connect(realOne.y, switch5.u3)
    annotation (Line(points={{50.5,80},{62,80}}, color={0,0,127}));
  connect(limiter.y, switch5.u1) annotation (Line(points={{39,34},{44,34},{44,
          64},{62,64}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Boiler control unit, which estimates the relative water mass flow and chooses the right water temperature difference.</p>
</html>"));
end ControlBoilerNotManufacturer;
