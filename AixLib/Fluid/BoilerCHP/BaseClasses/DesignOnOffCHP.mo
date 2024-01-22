within AixLib.Fluid.BoilerCHP.BaseClasses;
model DesignOnOffCHP


 parameter Real PLRMin=0.5;

  SDF.NDTable pTHR(
    nin=2,
    readFromFile=true,
    filename=ModelicaServices.ExternalReferences.loadResource("modelica://AixLib/Resources/Data/Fluid/BoilerCHP/NotManufacturer/CHP/Stromkennzahl.sdf"),
    dataset="/PTHR",
    dataUnit="[-]",
    scaleUnits={"W","-"},
    extrapMethod=SDF.Types.ExtrapolationMethod.Hold)
                          "Power to Heat Ratio"
    annotation (Placement(transformation(extent={{-20,74},{0,94}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{-56,32},{-42,46}})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{48,28},{62,42}})));
  Modelica.Blocks.Sources.RealExpression internalDemand(y=0.9819)
    "Percentage of usable electrical power"
    annotation (Placement(transformation(extent={{-34,104},{34,130}})));
  Modelica.Blocks.Math.Product product2
    annotation (Placement(transformation(extent={{42,76},{58,92}})));
  Modelica.Blocks.Routing.Multiplex2 multiplex2_2
    annotation (Placement(transformation(extent={{-52,90},{-36,74}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1, uMin=PLRMin)
    annotation (Placement(transformation(extent={{-88,78},{-76,90}})));
  SDF.NDTable etaEl(
    nin=2,
    readFromFile=true,
    filename=ModelicaServices.ExternalReferences.loadResource("modelica://AixLib/Resources/Data/Fluid/BoilerCHP/NotManufacturer/CHP/EtaEL.sdf"),
    dataset="/EtaEL",
    dataUnit="-",
    scaleUnits={"W","-"},
    extrapMethod=SDF.Types.ExtrapolationMethod.Hold)
                          "Electric Efficiency"
    annotation (Placement(transformation(extent={{-20,-18},{0,2}})));
  Modelica.Blocks.Math.Division division1
    annotation (Placement(transformation(extent={{26,-52},{42,-36}})));
  Modelica.Blocks.Interfaces.RealOutput Pel "Electrical power"
    annotation (Placement(transformation(extent={{100,64},{120,84}})));
  Modelica.Blocks.Interfaces.RealInput PLR
    annotation (Placement(transformation(extent={{-140,64},{-100,104}})));
  Modelica.Blocks.Interfaces.RealOutput powerDemand "Power Demand"
    annotation (Placement(transformation(extent={{100,-56},{120,-36}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow "Thermal Power"
    annotation (Placement(transformation(extent={{100,-16},{120,4}})));
  Modelica.Blocks.Interfaces.RealInput Power
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
  Modelica.Blocks.Interfaces.BooleanInput u
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{-50,-82},{-30,-62}})));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold(threshold
      =PLRMin)
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  Modelica.Blocks.Logical.Switch switch4
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-140,42})));
  Modelica.Blocks.Sources.RealExpression zero1(y=0)
                                                   "Real"
    annotation (Placement(transformation(extent={{-236,12},{-216,32}})));
equation
  connect(pTHR.y,division. u2) annotation (Line(points={{1,84},{14,84},{14,30.8},
          {46.6,30.8}},color={0,0,127}));
  connect(internalDemand.y,product2. u1) annotation (Line(points={{37.4,117},{46,
          117},{46,98},{42,98},{42,88.8},{40.4,88.8}},
                                  color={0,0,127}));
  connect(product1.y, product2.u2) annotation (Line(points={{-41.3,39},{28,39},{
          28,79.2},{40.4,79.2}}, color={0,0,127}));
  connect(multiplex2_2.y,pTHR. u) annotation (Line(points={{-35.2,82},{-35.2,84},
          {-22,84}},         color={0,0,127}));
  connect(PLR,limiter. u)
    annotation (Line(points={{-120,84},{-89.2,84}},          color={0,0,127}));
  connect(limiter.y,multiplex2_2. u2[1])
    annotation (Line(points={{-75.4,84},{-75.4,86.8},{-53.6,86.8}},
                                                             color={0,0,127}));
  connect(multiplex2_2.y,etaEl. u) annotation (Line(points={{-35.2,82},{-30,82},
          {-30,-8},{-22,-8}}, color={0,0,127}));
  connect(etaEl.y,division1. u2) annotation (Line(points={{1,-8},{8,-8},{8,
          -48.8},{24.4,-48.8}},
                         color={0,0,127}));
  connect(product1.y, division1.u1) annotation (Line(points={{-41.3,39},{12,39},
          {12,-39.2},{24.4,-39.2}},                   color={0,0,127}));
  connect(product1.y, division.u1) annotation (Line(points={{-41.3,39},{2.65,39},
          {2.65,39.2},{46.6,39.2}},  color={0,0,127}));
  connect(Power, product1.u2) annotation (Line(points={{-120,-20},{-104,-20},{-104,
          -22},{-82,-22},{-82,34.8},{-57.4,34.8}}, color={0,0,127}));
  connect(Power, multiplex2_2.u1[1]) annotation (Line(points={{-120,-20},{-102,-20},
          {-102,-22},{-82,-22},{-82,76},{-53.6,76},{-53.6,77.2}}, color={0,0,127}));
  connect(greaterEqualThreshold.y, and1.u1) annotation (Line(points={{-59,-50},
          {-52,-50},{-52,-72}}, color={255,0,255}));
  connect(u, and1.u2)
    annotation (Line(points={{-120,-80},{-52,-80}}, color={255,0,255}));
  connect(PLR, greaterEqualThreshold.u) annotation (Line(points={{-120,84},{
          -106,84},{-106,-54},{-82,-54},{-82,-50}}, color={0,0,127}));
  connect(switch4.y, product1.u1) annotation (Line(points={{-129,42},{-57.4,42},
          {-57.4,43.2}}, color={0,0,127}));
  connect(PLR, switch4.u1) annotation (Line(points={{-120,84},{-108,84},{-108,
          88},{-96,88},{-96,118},{-170,118},{-170,50},{-152,50}}, color={0,0,
          127}));
  connect(zero1.y, switch4.u3) annotation (Line(points={{-215,22},{-184,22},{
          -184,36},{-152,36},{-152,34}}, color={0,0,127}));
  connect(and1.y, switch4.u2) annotation (Line(points={{-29,-72},{-22,-72},{-22,
          -22},{-152,-22},{-152,42}}, color={255,0,255}));
  connect(product2.y, Pel) annotation (Line(points={{58.8,84},{72,84},{72,86},{
          110,86},{110,74}}, color={0,0,127}));
  connect(division.y, Q_flow) annotation (Line(points={{62.7,35},{92,35},{92,-6},
          {110,-6}}, color={0,0,127}));
  connect(division1.y, powerDemand) annotation (Line(points={{42.8,-44},{110,
          -44},{110,-46}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end DesignOnOffCHP;
