within AixLib.Systems.Benchmark.Model.Evaluation;
package CCCS
  Modelica.Blocks.Math.Gain CostFactorHeat(k=49.41)
    annotation (Placement(transformation(extent={{-226,156},{-206,176}})));
  Modelica.Blocks.Math.Sum CostsHeat
    annotation (Placement(transformation(extent={{-58,156},{-38,176}})));
  Modelica.Blocks.Sources.Constant Constant(k=-30) annotation (Placement(
        transformation(
        extent={{-10,-11},{10,11}},
        rotation=0,
        origin={-190,93})));
  Modelica.Blocks.Sources.Constant FixedCostsConnectionHeat(k=1690)
    annotation (Placement(transformation(extent={{-144,82},{-124,102}})));
  Modelica.Blocks.Math.Gain CostFactorConnectionHeat(k=27.14)
    annotation (Placement(transformation(extent={{-144,116},{-124,136}})));
  Modelica.Blocks.Math.Sum CostsConnectingHeat
    annotation (Placement(transformation(extent={{-102,116},{-82,136}})));
  Modelica.Blocks.Math.Sum PowerConnectionHeat
    annotation (Placement(transformation(extent={{-174,116},{-154,136}})));
  Modelica.Blocks.Math.Gain CostFactorCold(k=81)
    annotation (Placement(transformation(extent={{-230,52},{-210,72}})));
  Modelica.Blocks.Math.Sum CostsCold
    annotation (Placement(transformation(extent={{-60,52},{-40,72}})));
  Modelica.Blocks.Sources.Constant FixedCostsConnectionCold(k=1690)
    annotation (Placement(transformation(extent={{-146,-22},{-126,-2}})));
  Modelica.Blocks.Math.Gain CostFactorConnectionCold(k=27.14)
    annotation (Placement(transformation(extent={{-146,12},{-126,32}})));
  Modelica.Blocks.Math.Sum CostsConnectionCold
    annotation (Placement(transformation(extent={{-114,12},{-94,32}})));
  Modelica.Blocks.Math.Sum PowerConnectionCold
    annotation (Placement(transformation(extent={{-176,12},{-156,32}})));
  Modelica.Blocks.Math.Gain CostFactorElictricity(k=235)
    annotation (Placement(transformation(extent={{-230,-56},{-210,-36}})));
  Modelica.Blocks.Math.Sum EnergyCosts2
    annotation (Placement(transformation(extent={{-10,52},{10,72}})));
  Modelica.Blocks.Math.Gain EmissionsFactorHeat(k=0.2)
    annotation (Placement(transformation(extent={{-174,-98},{-154,-78}})));
  Modelica.Blocks.Math.Gain EmissionsFactorCold(k=0.527)
    annotation (Placement(transformation(extent={{-176,-132},{-156,-112}})));
  Modelica.Blocks.Math.Gain EmissionsFactorElectricity(k=0.626)
    annotation (Placement(transformation(extent={{-174,-166},{-154,-146}})));
  Modelica.Blocks.Math.Sum Emissions
    annotation (Placement(transformation(extent={{-142,-132},{-122,-112}})));
  Modelica.Blocks.Math.Gain CostFactorEmissions(k=19.51)
    annotation (Placement(transformation(extent={{-108,-132},{-88,-112}})));
  Modelica.Blocks.Math.Sum OperatingCosts
    annotation (Placement(transformation(extent={{30,-132},{50,-112}})));
  Modelica.Blocks.Math.Sum TotalCosts
    annotation (Placement(transformation(extent={{174,-172},{194,-152}})));
  Modelica.Blocks.Math.Sum InvestmentCosts
    annotation (Placement(transformation(extent={{32,-204},{52,-184}})));
  Modelica.Blocks.Sources.Constant InvestmentCostsImplementation(k=1)
    annotation (Placement(transformation(extent={{-18,-186},{2,-166}})));
  Modelica.Blocks.Sources.Constant InvestmentCostsComponents(k=190)
    annotation (Placement(transformation(extent={{-18,-222},{2,-202}})));
  Modelica.Blocks.Sources.Constant Rate(k=0.05) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={82,52})));
  Modelica.Blocks.Sources.Constant Constant2(k=1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={120,52})));
  Modelica.Blocks.Math.Product product annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={90,-20})));
  Modelica.Blocks.Sources.Constant Constant3(k=-1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={198,52})));
  Modelica.Blocks.Math.Add add annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={146,-22})));
  Modelica.Blocks.Math.Division RBF annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={118,-58})));
  Modelica.Blocks.Sources.Constant Duration(k=1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={160,52})));
  Modelica.Blocks.Math.Product product1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={134,-118})));
equation
  connect(FixedCostsConnectionHeat.y, CostsConnectingHeat.u[1])
    annotation (Line(points={{-123,92},{-104,92},{-104,126}},
                                                        color={0,0,127}));
  connect(CostFactorConnectionHeat.y, CostsConnectingHeat.u[1])
    annotation (Line(points={{-123,126},{-104,126}},
                                                color={0,0,127}));
  connect(CostsConnectingHeat.y, CostsHeat.u[1])
    annotation (Line(points={{-81,126},{-60,126},{-60,166}},
                                                       color={0,0,127}));
  connect(CostFactorHeat.y, CostsHeat.u[1])
    annotation (Line(points={{-205,166},{-60,166}},
                                                 color={0,0,127}));
  connect(PowerConnectionHeat.y, CostFactorConnectionHeat.u)
    annotation (Line(points={{-153,126},{-146,126}},
                                                 color={0,0,127}));
  connect(Constant.y, PowerConnectionHeat.u[1])
    annotation (Line(points={{-179,93},{-179,126},{-176,126}},
                                                         color={0,0,127}));
  connect(FixedCostsConnectionCold.y, CostsConnectionCold.u[1])
    annotation (Line(points={{-125,-12},{-116,-12},{-116,22}},
                                                             color={0,0,127}));
  connect(CostFactorConnectionCold.y, CostsConnectionCold.u[1])
    annotation (Line(points={{-125,22},{-116,22}}, color={0,0,127}));
  connect(CostsConnectionCold.y, CostsCold.u[1])
    annotation (Line(points={{-93,22},{-62,22},{-62,62}},color={0,0,127}));
  connect(CostFactorCold.y, CostsCold.u[1])
    annotation (Line(points={{-209,62},{-62,62}},  color={0,0,127}));
  connect(PowerConnectionCold.y, CostFactorConnectionCold.u)
    annotation (Line(points={{-155,22},{-148,22}}, color={0,0,127}));
  connect(CostsHeat.y, EnergyCosts2.u[1])
    annotation (Line(points={{-37,166},{-12,166},{-12,62}},
                                                        color={0,0,127}));
  connect(CostsCold.y, EnergyCosts2.u[1])
    annotation (Line(points={{-39,62},{-12,62}}, color={0,0,127}));
  connect(CostFactorElictricity.y, EnergyCosts2.u[1]) annotation (Line(points={{-209,
          -46},{-12,-46},{-12,62}},       color={0,0,127}));
  connect(EmissionsFactorHeat.y, Emissions.u[1]) annotation (Line(points={{-153,
          -88},{-144,-88},{-144,-122}},
                                  color={0,0,127}));
  connect(EmissionsFactorCold.y, Emissions.u[1])
    annotation (Line(points={{-155,-122},{-144,-122}},
                                                     color={0,0,127}));
  connect(EmissionsFactorElectricity.y, Emissions.u[1]) annotation (Line(points={{-153,
          -156},{-144,-156},{-144,-122}},    color={0,0,127}));
  connect(Emissions.y, CostFactorEmissions.u)
    annotation (Line(points={{-121,-122},{-110,-122}},
                                                    color={0,0,127}));
  connect(CostFactorEmissions.y, OperatingCosts.u[1])
    annotation (Line(points={{-87,-122},{28,-122}}, color={0,0,127}));
  connect(EnergyCosts2.y, OperatingCosts.u[1]) annotation (Line(points={{11,62},
          {28,62},{28,-122}},    color={0,0,127}));
  connect(InvestmentCosts.y, TotalCosts.u[1]) annotation (Line(points={{53,-194},
          {172,-194},{172,-162}}, color={0,0,127}));
  connect(InvestmentCostsImplementation.y, InvestmentCosts.u[1]) annotation (
      Line(points={{3,-176},{30,-176},{30,-194}},     color={0,0,127}));
  connect(InvestmentCostsComponents.y, InvestmentCosts.u[1]) annotation (Line(
        points={{3,-212},{30,-212},{30,-194}},     color={0,0,127}));
  connect(Rate.y, product.u2)
    annotation (Line(points={{82,41},{82,-8},{84,-8}},       color={0,0,127}));
  connect(Constant3.y, add.u1)
    annotation (Line(points={{198,41},{198,-10},{152,-10}},  color={0,0,127}));
  connect(add.y, RBF.u1) annotation (Line(points={{146,-33},{146,-46},{124,-46}},
        color={0,0,127}));
  connect(product.y, RBF.u2) annotation (Line(points={{90,-31},{90,-46},{112,
          -46}},  color={0,0,127}));
  connect(RBF.y, product1.u1) annotation (Line(points={{118,-69},{122,-69},{122,
          -112}}, color={0,0,127}));
  connect(OperatingCosts.y, product1.u2) annotation (Line(points={{51,-122},{86,
          -122},{86,-124},{122,-124}},  color={0,0,127}));
  connect(product1.y, TotalCosts.u[1]) annotation (Line(points={{145,-118},{172,
          -118},{172,-162}}, color={0,0,127}));
public
  model DicsountingFactor
    extends Modelica.Blocks.Icons.Block;

     Modelica.Blocks.Interfaces.RealInput q annotation (
    defaultComponentName="u",
    Icon(graphics={
      Polygon(
        lineColor={0,0,127},
        fillColor={0,0,127},
        fillPattern=FillPattern.Solid,
        points={{-100.0,100.0},{100.0,0.0},{-100.0,-100.0}})},
      coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}},
        preserveAspectRatio=true,
        initialScale=0.2)),
    Diagram(
      coordinateSystem(preserveAspectRatio=true,
        initialScale=0.2,
        extent={{-100.0,-100.0},{100.0,100.0}}),
        graphics={
      Polygon(
        lineColor={0,0,127},
        fillColor={0,0,127},
        fillPattern=FillPattern.Solid,
        points={{0.0,50.0},{100.0,0.0},{0.0,-50.0},{0.0,50.0}}),
      Text(
        lineColor={0,0,127},
        extent={{-10.0,60.0},{-10.0,85.0}},
        textString="q")}));

    Modelica.Blocks.Interfaces.RealOutput t annotation (
    defaultComponentName="u",
    Icon(graphics={
      Polygon(
        lineColor={0,0,127},
        fillColor={0,0,127},
        fillPattern=FillPattern.Solid,
        points={{-100.0,100.0},{100.0,0.0},{-100.0,-100.0}})},
      coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}},
        preserveAspectRatio=true,
        initialScale=0.2)),
    Diagram(
      coordinateSystem(preserveAspectRatio=true,
        initialScale=0.2,
        extent={{-100.0,-100.0},{100.0,100.0}}),
        graphics={
      Polygon(
        lineColor={0,0,127},
        fillColor={0,0,127},
        fillPattern=FillPattern.Solid,
        points={{0.0,50.0},{100.0,0.0},{0.0,-50.0},{0.0,50.0}}),
      Text(
        lineColor={0,0,127},
        extent={{-10.0,60.0},{-10.0,85.0}},
        textString="q")}));

     Modelica.Blocks.Interfaces.RealOutput y annotation (
    defaultComponentName="u",
    Icon(graphics={
      Polygon(
        lineColor={0,0,127},
        fillColor={0,0,127},
        fillPattern=FillPattern.Solid,
        points={{-100.0,100.0},{100.0,0.0},{-100.0,-100.0}})},
      coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}},
        preserveAspectRatio=true,
        initialScale=0.2)),
    Diagram(
      coordinateSystem(preserveAspectRatio=true,
        initialScale=0.2,
        extent={{-100.0,-100.0},{100.0,100.0}}),
        graphics={
      Polygon(
        lineColor={0,0,127},
        fillColor={0,0,127},
        fillPattern=FillPattern.Solid,
        points={{0.0,50.0},{100.0,0.0},{0.0,-50.0},{0.0,50.0}}),
      Text(
        lineColor={0,0,127},
        extent={{-10.0,60.0},{-10.0,85.0}},
        textString="q")}));


  equation
    y = q^t;
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Text(
            extent={{-50,-20},{40,20}},
            lineColor={0,0,0},
            textString="DiscountingFactor")}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Rectangle(
              extent={{-100,-100},{100,100}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Text(
              extent={{-100,50},{5,90}},
              lineColor={0,0,0},
              textString="q"),Text(
              extent={{-100,-20},{5,20}},
              lineColor={0,0,0},
              textString=""),Text(
              extent={{-100,-50},{5,-90}},
              lineColor={0,0,0},
              textString="t"),Text(
              extent={{2,46},{100,-34}},
              lineColor={0,0,0},
              textString="DiscountingFactor")}));
  end DicsountingFactor;
equation
  connect(Constant.y, PowerConnectionCold.u[1]) annotation (Line(points={{-179,93},
          {-179,56.5},{-178,56.5},{-178,22}}, color={0,0,127}));
public
  model EnergyCosts
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end EnergyCosts;

  model EmissionsCosts
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end EmissionsCosts;

  model PerformanceReductionCosts

  Real humidity;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      __Dymola_DymolaStoredErrors(thetext="model PerformanceReductionCosts
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));

Real humidity;



if (humidty<0.25)
then (
        if (deltaT<-2)
        then (LRM=0.2*(-4*humidity+1)+0.04*(abs(deltaT)-2));
        else (
               if (deltaT>2)
              then(LRM=0.2*(-4*humidity+1)+0.02*(abs(deltaT)-2));
              else(LRM=0.2*(-4*humidity+1));
             )
  
    )
else (
        if (humidity>0.65)
        then( 
              if (deltaT<-2)
              then (LRM=(humidity-0.65)*0.42+0.04*(abs(deltaT)-2));
              else (
                     if (deltaT>2)
                    then(LRM=(humidity-0.65)*0.42+0.02*(abs(deltaT)-2));
                    else(LRM=(humidity-0.65)*0.42);  
                   )
             )
        else(
                 
              if (deltaT<-2)
              then (LRM=0.04*(abs(deltaT)-2));
              else (
                     if (deltaT>2)
                    then(LRM=0.02*(deltaT-2));
                    else(LRM=0);
                  
                  )
            )
                
    )
end PerformanceReductionCosts;
"));
  end PerformanceReductionCosts;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Text(
          extent={{-50,-20},{40,20}},
          lineColor={0,0,0},
          textString="CCCS")}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-200,-200},{
            200,200}}), graphics={Rectangle(
            extent={{-244,-238},{230,208}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),Text(
            extent={{-202,136},{-97,176}},
            lineColor={0,0,0},
            textString=""),Text(
            extent={{-202,66},{-97,106}},
            lineColor={0,0,0},
            textString=""),Text(
            extent={{-202,36},{-97,-4}},
            lineColor={0,0,0},
            textString=""),Text(
            extent={{78,190},{176,110}},
            lineColor={0,0,0},
            textString="CCCS")}));

end CCCS;
