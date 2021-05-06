within AixLib.Fluid.BoilerCHP.BaseClasses.Controllers;
model ControlCHPNotManufacturer

   parameter Modelica.SIunits.Power PelNom=200000 "Nominal electrical power";

  parameter Modelica.SIunits.TemperatureDifference deltaTHeatingCircuit=20 "Nominal temperature difference heat circuit";

  parameter Modelica.SIunits.Temperature THotCoolingWaterMax=273.15+95 "Max. water temperature THot heat circuit";

  parameter Real PLRMin=0.5;

  parameter Modelica.SIunits.Temperature TStart=273.15+20 "T start"
   annotation (Dialog(tab="Advanced"));




  Modelica.Blocks.Sources.RealExpression TMin(y=273.15 + 81) "MinimalStartTemp"
    annotation (Placement(transformation(extent={{-104,58},{-80,76}})));
  Modelica.Blocks.Math.Add add3
    annotation (Placement(transformation(extent={{-58,54},{-42,70}})));
  NominalBehaviourNotManufacturer             nominalBehaviourNotManufacturer(PelNom=
        PelNom)
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  Modelica.Blocks.Continuous.LimPID PID3(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.01,
    Ti=10,
    yMax=1,
    yMin=0)
    annotation (Placement(transformation(extent={{-34,52},{-14,72}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=1)
    annotation (Placement(transformation(extent={{-26,80},{-16,100}})));
  Modelica.Blocks.Math.Abs abs1
    annotation (Placement(transformation(extent={{-2,18},{18,38}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1, uMin=0)
    annotation (Placement(transformation(extent={{28,22},{40,34}})));
  Modelica.Blocks.Math.Product mflowHC
    annotation (Placement(transformation(extent={{20,-46},{34,-32}})));
  Modelica.Blocks.Math.Product mflowCC
    annotation (Placement(transformation(extent={{54,-26},{66,-14}})));
  Modelica.Blocks.Logical.Switch switch1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={50,-70})));
  Modelica.Blocks.Logical.Or or1
    annotation (Placement(transformation(extent={{-70,-60},{-50,-40}})));
  Modelica.Blocks.Math.Add add1(k1=-1)
    annotation (Placement(transformation(extent={{0,58},{20,78}})));
  Modelica.Blocks.Interfaces.RealInput TVolume
    "Temperature cooling water exhaust heat exchanger exit"
    annotation (Placement(transformation(extent={{-140,10},{-100,50}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=0)
    annotation (Placement(transformation(extent={{8,-96},{18,-76}})));
  Modelica.Blocks.Interfaces.BooleanInput shutdown
    annotation (Placement(transformation(extent={{-140,-50},{-100,-10}})));
  Modelica.Blocks.Interfaces.BooleanInput PLROff
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
  Modelica.Blocks.Interfaces.RealOutput mFlowRel
    annotation (Placement(transformation(extent={{100,-80},{120,-60}})));
equation
  connect(nominalBehaviourNotManufacturer.dTCCNom,add3. u2) annotation (Line(
        points={{-59,-10},{-52,-10},{-52,14},{-66,14},{-66,57.2},{-59.6,57.2}},
                  color={0,0,127}));
  connect(TMin.y,add3. u1) annotation (Line(points={{-78.8,67},{-68,67},{-68,
          66.8},{-59.6,66.8}},                      color={0,0,127}));
  connect(add3.y,PID3. u_s) annotation (Line(points={{-41.2,62},{-36,62}},
                               color={0,0,127}));
  connect(PID3.y, add1.u2) annotation (Line(points={{-13,62},{-2,62}},
                          color={0,0,127}));
  connect(realExpression4.y, add1.u1) annotation (Line(points={{-15.5,90},{-12,
          90},{-12,74},{-2,74}},          color={0,0,127}));
  connect(add1.y,abs1. u) annotation (Line(points={{21,68},{22,68},{22,46},{-8,
          46},{-8,28},{-4,28}},           color={0,0,127}));
  connect(abs1.y,limiter. u) annotation (Line(points={{19,28},{26.8,28}},
                color={0,0,127}));
  connect(nominalBehaviourNotManufacturer.mWaterCC,mflowCC. u1) annotation (
      Line(points={{-59,-16},{48,-16},{48,-16.4},{52.8,-16.4}},       color={0,0,
          127}));
  connect(nominalBehaviourNotManufacturer.mWaterHC,mflowHC. u1) annotation (
      Line(points={{-59,-4},{6,-4},{6,-34.8},{18.6,-34.8}},            color={0,
          0,127}));
  connect(or1.y, switch1.u2) annotation (Line(points={{-49,-50},{-38,-50},{-38,
          -70},{38,-70}}, color={255,0,255}));
  connect(TVolume, PID3.u_m)
    annotation (Line(points={{-120,30},{-24,30},{-24,50}}, color={0,0,127}));
  connect(limiter.y, mflowHC.u2) annotation (Line(points={{40.6,28},{46,28},{46,
          2},{-2,2},{-2,-43.2},{18.6,-43.2}}, color={0,0,127}));
  connect(limiter.y, mflowCC.u2) annotation (Line(points={{40.6,28},{46,28},{46,
          -23.6},{52.8,-23.6}}, color={0,0,127}));
  connect(shutdown, or1.u1) annotation (Line(points={{-120,-30},{-88,-30},{-88,
          -50},{-72,-50}},
                 color={255,0,255}));
  connect(PLROff, or1.u2) annotation (Line(points={{-120,-80},{-88,-80},{-88,
          -58},{-72,-58}}, color={255,0,255}));
  connect(switch1.y, mFlowRel)
    annotation (Line(points={{61,-70},{110,-70}}, color={0,0,127}));
  connect(limiter.y, switch1.u1) annotation (Line(points={{40.6,28},{46,28},{46,
          -52},{24,-52},{24,-62},{38,-62}}, color={0,0,127}));
  connect(realExpression2.y, switch1.u3) annotation (Line(points={{18.5,-86},{
          28,-86},{28,-78},{38,-78}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Controlunit of BHKW water massflows. Both massflows depends on the temperature of the volume of PartialHeatGenerator which represents the water temperature after exhaust heat exchanger.</p>
<p>To describe a realistic beahviour during a cold start the system increases water massflows after TVolume has reached nominal temperature:file:</p>
<p><span style=\"font-size: 16pt;\"><img src=\"modelica://AixLib/../../../Diagramme AixLib/BHKW/Temp_Verläufe.png\"/></span></p>
</html>"));
end ControlCHPNotManufacturer;
