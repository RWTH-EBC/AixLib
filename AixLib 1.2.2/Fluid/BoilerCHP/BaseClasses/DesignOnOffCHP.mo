within AixLib.Fluid.BoilerCHP.BaseClasses;
model DesignOnOffCHP


 parameter Real PLRMin=0.5;

  SDF.NDTable pTHR(
    nin=2,
    readFromFile=true,
    filename=ModelicaServices.ExternalReferences.loadResource("modelica://AixLib/Resources/Data/Fluid/BoilerCHP/NotManufacturer/CHP/Stromkennzahl.sdf"),
    dataset="/PTHR",
    dataUnit="[-]",
    scaleUnits={"W","-"}) "Power to Heat Ratio"
    annotation (Placement(transformation(extent={{-20,74},{0,94}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{-56,32},{-42,46}})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{36,28},{50,42}})));
  Modelica.Blocks.Sources.RealExpression internalDemand(y=0.9819)
    "Percentage of usable electrical power"
    annotation (Placement(transformation(extent={{-34,104},{34,130}})));
  Modelica.Blocks.Math.Product product2
    annotation (Placement(transformation(extent={{42,76},{58,92}})));
  Modelica.Blocks.Routing.Multiplex2 multiplex2_2
    annotation (Placement(transformation(extent={{-52,90},{-36,74}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1, uMin=PLRMin)
    annotation (Placement(transformation(extent={{-88,78},{-76,90}})));
  Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold(threshold=
        PLRMin)
    annotation (Placement(transformation(extent={{18,8},{30,20}})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={62,-10})));
  Modelica.Blocks.Sources.RealExpression zero(y=0) "Real"
    annotation (Placement(transformation(extent={{74,12},{94,32}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=0,
        origin={86,74})));
  SDF.NDTable etaEl(
    nin=2,
    readFromFile=true,
    filename=ModelicaServices.ExternalReferences.loadResource("modelica://AixLib/Resources/Data/Fluid/BoilerCHP/NotManufacturer/CHP/EtaEL.sdf"),
    dataset="/EtaEL",
    dataUnit="-",
    scaleUnits={"W","-"}) "Electric Efficiency"
    annotation (Placement(transformation(extent={{-20,-18},{0,2}})));
  Modelica.Blocks.Math.Division division1
    annotation (Placement(transformation(extent={{62,-54},{78,-38}})));
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
equation
  connect(pTHR.y,division. u2) annotation (Line(points={{1,84},{14,84},{14,30.8},
          {34.6,30.8}},color={0,0,127}));
  connect(internalDemand.y,product2. u1) annotation (Line(points={{37.4,117},{46,
          117},{46,98},{42,98},{42,88.8},{40.4,88.8}},
                                  color={0,0,127}));
  connect(product1.y, product2.u2) annotation (Line(points={{-41.3,39},{28,39},{
          28,79.2},{40.4,79.2}}, color={0,0,127}));
  connect(multiplex2_2.y,pTHR. u) annotation (Line(points={{-35.2,82},{-35.2,84},
          {-22,84}},         color={0,0,127}));
  connect(division.y,switch3. u3) annotation (Line(points={{50.7,35},{56,35},{56,
          10},{54,10},{54,2}},color={0,0,127}));
  connect(PLR,limiter. u)
    annotation (Line(points={{-120,84},{-89.2,84}},          color={0,0,127}));
  connect(limiter.y,multiplex2_2. u2[1])
    annotation (Line(points={{-75.4,84},{-75.4,86.8},{-53.6,86.8}},
                                                             color={0,0,127}));
  connect(lessEqualThreshold.y,switch3. u2) annotation (Line(points={{30.6,14},{
          62,14},{62,2}},                 color={255,0,255}));
  connect(zero.y,switch3. u1) annotation (Line(points={{95,22},{95,6},{78,6},{78,
          2},{70,2}},      color={0,0,127}));
  connect(zero.y,switch1. u1) annotation (Line(points={{95,22},{100,22},{100,58},
          {74,58},{74,66}},         color={0,0,127}));
  connect(product2.y,switch1. u3) annotation (Line(points={{58.8,84},{58.8,82},{
          74,82}},                      color={0,0,127}));
  connect(switch1.y,Pel)  annotation (Line(points={{97,74},{110,74}},
                            color={0,0,127}));
  connect(multiplex2_2.y,etaEl. u) annotation (Line(points={{-35.2,82},{-30,82},
          {-30,-8},{-22,-8}}, color={0,0,127}));
  connect(PLR,lessEqualThreshold. u) annotation (Line(points={{-120,84},{-120,14},
          {16.8,14}},          color={0,0,127}));
  connect(lessEqualThreshold.y,switch1. u2) annotation (Line(points={{30.6,14},{
          64,14},{64,74},{74,74}},    color={255,0,255}));
  connect(etaEl.y,division1. u2) annotation (Line(points={{1,-8},{46,-8},{46,-50.8},
          {60.4,-50.8}}, color={0,0,127}));
  connect(division1.y,powerDemand)
    annotation (Line(points={{78.8,-46},{110,-46}}, color={0,0,127}));
  connect(product1.y, division1.u1) annotation (Line(points={{-41.3,39},{10,39},
          {10,-26},{54,-26},{54,-41.2},{60.4,-41.2}}, color={0,0,127}));
  connect(product1.y, division.u1) annotation (Line(points={{-41.3,39},{-3.35,39},
          {-3.35,39.2},{34.6,39.2}}, color={0,0,127}));
  connect(PLR, product1.u1) annotation (Line(points={{-120,84},{-120,43.2},{-57.4,
          43.2}}, color={0,0,127}));
  connect(switch3.y, Q_flow) annotation (Line(points={{62,-21},{64,-21},{64,-28},
          {86,-28},{86,-8},{110,-8},{110,-6}}, color={0,0,127}));
  connect(Power, product1.u2) annotation (Line(points={{-120,-20},{-104,-20},{-104,
          -22},{-82,-22},{-82,34.8},{-57.4,34.8}}, color={0,0,127}));
  connect(Power, multiplex2_2.u1[1]) annotation (Line(points={{-120,-20},{-102,-20},
          {-102,-22},{-82,-22},{-82,76},{-53.6,76},{-53.6,77.2}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end DesignOnOffCHP;
