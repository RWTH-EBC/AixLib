within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler;
model FeedbackControl

    parameter Modelica.Units.SI.Temperature T_cold_Des=273.15 + 35
    "Design return temperature"
   annotation (Dialog(group="Nominal condition"));

  AixLib.Controls.Continuous.LimPID conPID3(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.05,
    Ti=30,
    yMin=0)
    annotation (Placement(transformation(extent={{-18,-66},{2,-46}})));
  Modelica.Blocks.Sources.RealExpression dTWaterNom1(y=T_cold_Des)
    "Real input temperature difference dimension point"
    annotation (Placement(transformation(extent={{-98,20},{-58,46}})));
  Modelica.Blocks.Math.Gain gain1(k=-1)
    annotation (Placement(transformation(extent={{-56,-56},{-36,-36}})));
  Modelica.Blocks.Math.Gain gain2(k=-1)
    annotation (Placement(transformation(extent={{-56,-86},{-36,-66}})));
  AixLib.Controls.Continuous.LimPID conPID1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.05,
    Ti=30,
    yMin=0)
    annotation (Placement(transformation(extent={{-18,62},{2,82}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{22,56},{42,76}})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{66,42},{86,62}})));
  Modelica.Blocks.Sources.RealExpression two(y=2) "number two"
    annotation (Placement(transformation(extent={{14,10},{54,36}})));
  Interfaces.BoilerControlBus
    boilerControlBus
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
equation
  connect(dTWaterNom1.y,gain1. u) annotation (Line(points={{-56,33},{-56,34},{-40,
          34},{-40,-22},{-66,-22},{-66,-46},{-58,-46}},
                                       color={0,0,127}));
  connect(gain1.y,conPID3. u_s)
    annotation (Line(points={{-35,-46},{-28,-46},{-28,-56},{-20,-56}},
                                                          color={0,0,127}));
  connect(boilerControlBus.TColdMea,gain2. u) annotation (Line(
      points={{-100,0},{-100,-76},{-58,-76}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(gain2.y,conPID3. u_m)
    annotation (Line(points={{-35,-76},{-8,-76},{-8,-68}},color={0,0,127}));
  connect(dTWaterNom1.y,conPID1. u_s)
    annotation (Line(points={{-56,33},{-56,34},{-40,34},{-40,72},{-20,72}},
                                                          color={0,0,127}));
  connect(conPID1.y,add. u1)
    annotation (Line(points={{3,72},{20,72}},      color={0,0,127}));
  connect(conPID3.y,add. u2) annotation (Line(points={{3,-56},{8,-56},{8,60},{20,
          60}},                                color={0,0,127}));
  connect(add.y,division. u1)
    annotation (Line(points={{43,66},{52,66},{52,58},{64,58}},
                                                   color={0,0,127}));
  connect(two.y, division.u2) annotation (Line(points={{56,23},{62,23},{62,36},{
          46,36},{46,46},{64,46}}, color={0,0,127}));
  connect(boilerControlBus.TBoilerIn, conPID1.u_m) annotation (Line(
      points={{-100,0},{-8,0},{-8,60}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(division.y, boilerControlBus.PosValFeedback) annotation (Line(points={
          {87,52},{87,0},{-100,0}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end FeedbackControl;
