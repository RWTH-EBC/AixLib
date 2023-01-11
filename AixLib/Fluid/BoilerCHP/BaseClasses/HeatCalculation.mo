within AixLib.Fluid.BoilerCHP.BaseClasses;
model HeatCalculation
  Controllers.StationaryBehaviour             DemandCalc(
    TColdNom=TColdNom,
    QNom=QNom,
    dTWaterNom=dTWaterNom,
    m_flowVar=m_flowVar)
    annotation (Placement(transformation(extent={{-24,56},{-4,76}})));
  Controllers.ReturnInfluence             HeatCalc(
    TColdNom=TColdNom,
    QNom=QNom,
    dTWaterNom=dTWaterNom,
    m_flowVar=m_flowVar)
    annotation (Placement(transformation(extent={{10,22},{30,42}})));
  Modelica.Blocks.Sources.RealExpression RealZero(y=0) "RealZero"
    annotation (Placement(transformation(extent={{6,48},{26,68}})));
  Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold(threshold=
        PLRMin)
    annotation (Placement(transformation(extent={{-50,6},{-38,18}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1, uMin=PLRMin)
    annotation (Placement(transformation(extent={{-70,34},{-58,46}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={88,26})));
  Modelica.Blocks.Interfaces.RealInput PLR "Part Load Ratio" annotation (
      Placement(transformation(extent={{-140,-20},{-100,20}}),
        iconTransformation(extent={{-140,34},{-100,74}})));
      Modelica.Blocks.Interfaces.RealInput dTWater
    "temperature difference THot-TCold"            annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,90})));
  Modelica.Blocks.Interfaces.RealOutput PowerDemand(quantity="Power", final
      unit="W") "Power demand" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={116,6}),  iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,-70})));
  Modelica.Blocks.Interfaces.RealInput HeatLosses "Heat losses to environment"
    annotation (Placement(transformation(extent={{-140,-110},{-100,-70}}),
        iconTransformation(extent={{-140,34},{-100,74}})));
  Modelica.Blocks.Interfaces.RealOutput HeatFlow(quantity="Power", final unit=
        "W") "HeatFlow from combustion to fluid" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={40,-110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,-70})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{-9,-9},{9,9}},
        rotation=270,
        origin={43,-31})));
equation
  connect(dTWater,DemandCalc. dTWater) annotation (Line(points={{-120,90},{-78,
          90},{-78,24},{-28,24},{-28,62},{-32,62},{-32,68},{-26,68}},
                              color={0,0,127}));
  connect(dTWater,HeatCalc. dTWater) annotation (Line(points={{-120,90},{-78,90},
          {-78,25},{8,25}}, color={0,0,127}));
  connect(RealZero.y, switch3.u1) annotation (Line(points={{27,58},{52,58},{52,
          -14},{50.2,-14},{50.2,-20.2}},
                       color={0,0,127}));
  connect(PLR,lessEqualThreshold. u) annotation (Line(points={{-120,0},{-72,0},
          {-72,12},{-51.2,12}},                    color={0,0,127}));
  connect(lessEqualThreshold.y, switch3.u2) annotation (Line(points={{-37.4,12},
          {42,12},{42,-16},{43,-16},{43,-20.2}},
                                        color={255,0,255}));
  connect(PLR,limiter. u) annotation (Line(points={{-120,0},{-72,0},{-72,30},{
          -74,30},{-74,34},{-76,34},{-76,40},{-71.2,40}},
                              color={0,0,127}));
  connect(limiter.y,HeatCalc. PLR) annotation (Line(points={{-57.4,40},{-34,40},
          {-34,32},{8,32}}, color={0,0,127}));
  connect(limiter.y,DemandCalc. PLR) annotation (Line(points={{-57.4,40},{-54,
          40},{-54,72},{-26,72}},
                              color={0,0,127}));
  connect(lessEqualThreshold.y,switch1. u2) annotation (Line(points={{-37.4,12},
          {68,12},{68,46},{88,46},{88,38}},                   color={255,0,255}));
  connect(RealZero.y,switch1. u1) annotation (Line(points={{27,58},{96,58},{96,
          38}},                       color={0,0,127}));
  connect(switch1.y,PowerDemand)
    annotation (Line(points={{88,15},{88,6},{116,6}},     color={0,0,127}));
  connect(DemandCalc.PowerDemand,switch1. u3) annotation (Line(points={{-14,77},
          {-14,82},{80,82},{80,38}}, color={0,0,127}));
  connect(HeatCalc.Q_flow, switch3.u3)
    annotation (Line(points={{31,32},{36,32},{36,-20.2},{35.8,-20.2}},
                                                            color={0,0,127}));
  connect(HeatLosses, DemandCalc.QLosses) annotation (Line(points={{-120,-90},{
          20,-90},{20,14},{-6,14},{-6,48},{-14,48},{-14,54}}, color={0,0,127}));
  connect(HeatLosses, HeatCalc.QLosses)
    annotation (Line(points={{-120,-90},{20,-90},{20,20}}, color={0,0,127}));
  connect(switch3.y, HeatFlow) annotation (Line(points={{43,-40.9},{42,-40.9},{
          42,-96},{40,-96},{40,-110}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HeatCalculation;
