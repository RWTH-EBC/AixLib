within AixLib.Fluid.BoilerCHP.BaseClasses.Controllers;
model ControlCHPTest
   parameter Modelica.SIunits.Power PelNom=200000 "Nominal electrical power";

  parameter Modelica.SIunits.TemperatureDifference deltaTHeatingCircuit=20 "Nominal temperature difference heat circuit";

  parameter Modelica.SIunits.Temperature THotCoolingWaterMax=273.15+95 "Max. water temperature THot heat circuit";

  parameter Real PLRMin=0.5;

  parameter Modelica.SIunits.Temperature TStart=273.15+20 "T start"
   annotation (Dialog(tab="Advanced"));


  Modelica.Blocks.Sources.RealExpression TMin(y=273.15 + 81) "MinimalStartTemp"
    annotation (Placement(transformation(extent={{-104,58},{-80,76}})));
  Modelica.Blocks.Math.Add add3(k1=-1)
    annotation (Placement(transformation(extent={{-68,40},{-48,60}})));
  NominalBehaviourNotManufacturer             nominalBehaviourNotManufacturer(PelNom=
        PelNom)
    annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
  Modelica.Blocks.Continuous.LimPID PID3(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.01,
    Ti=10,
    yMax=1,
    yMin=0)
    annotation (Placement(transformation(extent={{42,52},{62,72}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=0)
    annotation (Placement(transformation(extent={{48,-4},{58,16}})));
  Modelica.Blocks.Logical.Switch switch1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={50,-70})));
  Modelica.Blocks.Logical.Or or1
    annotation (Placement(transformation(extent={{-70,-60},{-50,-40}})));
  Modelica.Blocks.Interfaces.RealInput TVolume
    "Temperature cooling water exhaust heat exchanger exit"
    annotation (Placement(transformation(extent={{-140,24},{-100,64}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=0)
    annotation (Placement(transformation(extent={{8,-96},{18,-76}})));
  Modelica.Blocks.Interfaces.BooleanInput shutdown
    annotation (Placement(transformation(extent={{-140,-50},{-100,-10}})));
  Modelica.Blocks.Interfaces.BooleanInput PLROff
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
  Modelica.Blocks.Interfaces.RealOutput mFlowRelHC
    annotation (Placement(transformation(extent={{100,-80},{120,-60}})));
  Modelica.Blocks.Interfaces.RealOutput mFlowCC
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Math.Gain gain2(k=-1)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={0,62})));
  Modelica.Blocks.Math.Gain gain1(k=-1)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={22,44})));
  Modelica.Blocks.Continuous.LimPID PID1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.01,
    Ti=10,
    yMax=1,
    yMin=0)
    annotation (Placement(transformation(extent={{30,-30},{50,-10}})));
  Modelica.Blocks.Interfaces.RealInput THot
    "Temperature cooling water exhaust heat exchanger exit"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Sources.RealExpression TMin1(y=273.15 + 60)
                                                             "MinimalStartTemp"
    annotation (Placement(transformation(extent={{-68,-30},{-40,-10}})));
  Modelica.Blocks.Logical.Switch switch2 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={82,30})));
  Modelica.Blocks.Sources.RealExpression TMin2(y=273.15 + 75)
                                                             "MinimalStartTemp"
    annotation (Placement(transformation(extent={{-50,-4},{-26,14}})));
  Modelica.Blocks.Logical.Greater greater
    annotation (Placement(transformation(extent={{4,4},{24,24}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{100,80},{120,100}})));
  Modelica.Blocks.Math.Gain gain3(k=-1)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-78,0})));
  Modelica.Blocks.Math.Gain gain4(k=-1)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={0,-20})));
equation
  connect(TMin.y,add3. u1) annotation (Line(points={{-78.8,67},{-74,67},{-74,56},
          {-70,56}},                                color={0,0,127}));
  connect(or1.y, switch1.u2) annotation (Line(points={{-49,-50},{-38,-50},{-38,
          -70},{38,-70}}, color={255,0,255}));
  connect(shutdown, or1.u1) annotation (Line(points={{-120,-30},{-88,-30},{-88,
          -50},{-72,-50}},
                 color={255,0,255}));
  connect(PLROff, or1.u2) annotation (Line(points={{-120,-80},{-88,-80},{-88,
          -58},{-72,-58}}, color={255,0,255}));
  connect(realExpression2.y, switch1.u3) annotation (Line(points={{18.5,-86},{
          28,-86},{28,-78},{38,-78}}, color={0,0,127}));
  connect(TVolume, add3.u2)
    annotation (Line(points={{-120,44},{-70,44}}, color={0,0,127}));
  connect(nominalBehaviourNotManufacturer.dTCCNom, gain2.u) annotation (Line(
        points={{-59,90},{-28,90},{-28,62},{-12,62}}, color={0,0,127}));
  connect(gain2.y, PID3.u_s)
    annotation (Line(points={{11,62},{40,62}}, color={0,0,127}));
  connect(add3.y, gain1.u) annotation (Line(points={{-47,50},{-20,50},{-20,44},
          {10,44}}, color={0,0,127}));
  connect(gain1.y, PID3.u_m)
    annotation (Line(points={{33,44},{52,44},{52,50}}, color={0,0,127}));
  connect(PID1.y, mFlowRelHC) annotation (Line(points={{51,-20},{74,-20},{74,
          -36},{84,-36},{84,-70},{110,-70}}, color={0,0,127}));
  connect(TMin1.y, switch1.u1) annotation (Line(points={{-38.6,-20},{-22,-20},{
          -22,-62},{38,-62}}, color={0,0,127}));
  connect(PID3.y, switch2.u1) annotation (Line(points={{63,62},{64,62},{64,38},
          {70,38}}, color={0,0,127}));
  connect(realExpression4.y, switch2.u3) annotation (Line(points={{58.5,6},{50,
          6},{50,22},{70,22}}, color={0,0,127}));
  connect(greater.y, switch2.u2) annotation (Line(points={{25,14},{50,14},{50,
          30},{70,30}}, color={255,0,255}));
  connect(TMin2.y, greater.u2) annotation (Line(points={{-24.8,5},{-10,5},{-10,
          6},{2,6}}, color={0,0,127}));
  connect(TVolume, greater.u1) annotation (Line(points={{-120,44},{-94,44},{-94,
          14},{2,14}}, color={0,0,127}));
  connect(switch2.y, product.u1) annotation (Line(points={{93,30},{100,30},{100,
          48},{72,48},{72,96},{98,96}}, color={0,0,127}));
  connect(nominalBehaviourNotManufacturer.mWaterCC, product.u2)
    annotation (Line(points={{-59,84},{98,84}}, color={0,0,127}));
  connect(product.y, mFlowCC) annotation (Line(points={{121,90},{130,90},{130,
          12},{92,12},{92,0},{110,0}}, color={0,0,127}));
  connect(THot, gain3.u) annotation (Line(points={{-120,0},{-105,0},{-105,
          1.55431e-15},{-90,1.55431e-15}}, color={0,0,127}));
  connect(gain3.y, PID1.u_m) annotation (Line(points={{-67,-1.38778e-15},{0,0},
          {0,-40},{40,-40},{40,-32}}, color={0,0,127}));
  connect(TMin1.y, gain4.u)
    annotation (Line(points={{-38.6,-20},{-12,-20}}, color={0,0,127}));
  connect(gain4.y, PID1.u_s)
    annotation (Line(points={{11,-20},{28,-20}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Controlunit of BHKW water massflows. Both massflows depends on the temperature of the volume of PartialHeatGenerator which represents the water temperature after exhaust heat exchanger.</p>
<p>To describe a realistic beahviour during a cold start the system increases water massflows after TVolume has reached nominal temperature:file:</p>
<p><span style=\"font-size: 16pt;\"><img src=\"modelica://AixLib/../../../Diagramme AixLib/BHKW/Temp_Verläufe.png\"/></span></p>
</html>"));
end ControlCHPTest;
