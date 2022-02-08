within ControlUnity.ModularCHP;
model ControlCHPNotManufacturerModular


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
  AixLib.Systems.ModularEnergySystems.Controls.NominalBehaviourNotManufacturer nominalBehaviourNotManufacturer(PelNom=
        PelNom)
    annotation (Placement(transformation(extent={{-100,2},{-80,22}})));
  Modelica.Blocks.Continuous.LimPID PID3(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.01,
    Ti=10,
    yMax=1,
    yMin=0)
    annotation (Placement(transformation(extent={{-34,52},{-14,72}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=1)
    annotation (Placement(transformation(extent={{-24,80},{-14,100}})));
  Modelica.Blocks.Math.Abs abs1
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1, uMin=0)
    annotation (Placement(transformation(extent={{30,24},{42,36}})));
  Modelica.Blocks.Math.Product mflowCC
    annotation (Placement(transformation(extent={{-6,-10},{14,10}})));
  Modelica.Blocks.Math.Add add1(k1=-1)
    annotation (Placement(transformation(extent={{0,58},{20,78}})));
  Modelica.Blocks.Interfaces.RealInput TVolume
    "Temperature cooling water exhaust heat exchanger exit"
    annotation (Placement(transformation(extent={{-140,10},{-100,50}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=0.0003)
    annotation (Placement(transformation(extent={{10,-72},{20,-52}})));
  Modelica.Blocks.Interfaces.RealOutput mFlowRelHC "Normalized mFlow HC"
    annotation (Placement(transformation(extent={{100,-80},{120,-60}})));
  Modelica.Blocks.Interfaces.RealOutput mFlowCC "Absolut mFlow CC"
    annotation (Placement(transformation(extent={{100,-18},{120,2}})));
  Modelica.Blocks.Logical.Switch switch2 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={74,-8})));
  Modelica.Blocks.Interfaces.BooleanInput PLROff
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{54,-80},{74,-60}})));
equation
  connect(nominalBehaviourNotManufacturer.dTCCNom,add3. u2) annotation (Line(
        points={{-79,12},{-66,12},{-66,57.2},{-59.6,57.2}},
                  color={0,0,127}));
  connect(TMin.y,add3. u1) annotation (Line(points={{-78.8,67},{-68,67},{-68,
          66.8},{-59.6,66.8}},                      color={0,0,127}));
  connect(add3.y,PID3. u_s) annotation (Line(points={{-41.2,62},{-36,62}},
                               color={0,0,127}));
  connect(PID3.y, add1.u2) annotation (Line(points={{-13,62},{-2,62}},
                          color={0,0,127}));
  connect(realExpression4.y, add1.u1) annotation (Line(points={{-13.5,90},{-12,90},
          {-12,74},{-2,74}},              color={0,0,127}));
  connect(add1.y,abs1. u) annotation (Line(points={{21,68},{22,68},{22,46},{-8,
          46},{-8,30},{-2,30}},           color={0,0,127}));
  connect(abs1.y,limiter. u) annotation (Line(points={{21,30},{28.8,30}},
                color={0,0,127}));
  connect(nominalBehaviourNotManufacturer.mWaterCC,mflowCC. u1) annotation (
      Line(points={{-79,6},{-8,6}},                                   color={0,0,
          127}));
  connect(TVolume, PID3.u_m)
    annotation (Line(points={{-120,30},{-24,30},{-24,50}}, color={0,0,127}));
  connect(switch2.y, mFlowCC) annotation (Line(points={{85,-8},{92,-8},{92,-8},
          {110,-8}}, color={0,0,127}));
  connect(mflowCC.y, switch2.u3) annotation (Line(points={{15,0},{44,0},{44,-16},
          {62,-16}}, color={0,0,127}));
  connect(limiter.y, switch1.u3) annotation (Line(points={{42.6,30},{46,30},{46,
          -78},{52,-78}}, color={0,0,127}));
  connect(realExpression2.y, switch1.u1)
    annotation (Line(points={{20.5,-62},{52,-62}}, color={0,0,127}));
  connect(switch1.y, mFlowRelHC)
    annotation (Line(points={{75,-70},{110,-70}}, color={0,0,127}));
  connect(limiter.y, mflowCC.u2) annotation (Line(points={{42.6,30},{54,30},{54,
          16},{-24,16},{-24,-6},{-8,-6}}, color={0,0,127}));
  connect(realExpression2.y, switch2.u1) annotation (Line(points={{20.5,-62},{
          48,-62},{48,-2},{56,-2},{56,0},{62,0}}, color={0,0,127}));
  connect(PLROff, switch1.u2) annotation (Line(points={{-120,-80},{-34,-80},{
          -34,-70},{52,-70}}, color={255,0,255}));
  connect(PLROff, switch2.u2) annotation (Line(points={{-120,-80},{-44,-80},{
          -44,-22},{54,-22},{54,-8},{62,-8}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                      Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255})}),                            Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Controlunit of BHKW water massflows. Both massflows depends on the temperature of the volume of PartialHeatGenerator which represents the water temperature after exhaust heat exchanger.</p>
<p>To describe a realistic beahviour during a cold start the system increases water massflows after TVolume has reached nominal temperature:file:</p>
<p><span style=\"font-size: 16pt;\"><img src=\"modelica://AixLib/../../../Diagramme AixLib/BHKW/Temp_Verläufe.png\"/></span></p>
</html>"));
end ControlCHPNotManufacturerModular;
