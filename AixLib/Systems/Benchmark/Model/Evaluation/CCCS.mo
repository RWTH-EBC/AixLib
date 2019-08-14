within AixLib.Systems.Benchmark.Model.Evaluation;
model CCCS
  Modelica.Blocks.Math.Gain CostFactorHeat(k=49.41)
    annotation (Placement(transformation(extent={{-206,194},{-186,214}})));
  Modelica.Blocks.Math.Sum CostsHeat
    annotation (Placement(transformation(extent={{-38,194},{-18,214}})));
  Modelica.Blocks.Sources.Constant Constant(k=-30) annotation (Placement(
        transformation(
        extent={{-10,-11},{10,11}},
        rotation=0,
        origin={-170,131})));
  Modelica.Blocks.Sources.Constant FixedCostsConnectionHeat(k=1690)
    annotation (Placement(transformation(extent={{-124,120},{-104,140}})));
  Modelica.Blocks.Math.Gain CostFactorConnectionHeat(k=27.14)
    annotation (Placement(transformation(extent={{-124,154},{-104,174}})));
  Modelica.Blocks.Math.Sum CostsConnectingHeat
    annotation (Placement(transformation(extent={{-82,154},{-62,174}})));
  Modelica.Blocks.Math.Sum PowerConnectionHeat
    annotation (Placement(transformation(extent={{-154,154},{-134,174}})));
  Modelica.Blocks.Math.Gain CostFactorCold(k=81)
    annotation (Placement(transformation(extent={{-210,90},{-190,110}})));
  Modelica.Blocks.Math.Sum CostsCold
    annotation (Placement(transformation(extent={{-40,90},{-20,110}})));
  Modelica.Blocks.Sources.Constant FixedCostsConnectionCold(k=1690)
    annotation (Placement(transformation(extent={{-126,16},{-106,36}})));
  Modelica.Blocks.Math.Gain CostFactorConnectionCold(k=27.14)
    annotation (Placement(transformation(extent={{-126,50},{-106,70}})));
  Modelica.Blocks.Math.Sum CostsConnectionCold
    annotation (Placement(transformation(extent={{-94,50},{-74,70}})));
  Modelica.Blocks.Math.Sum PowerConnectionCold
    annotation (Placement(transformation(extent={{-156,50},{-136,70}})));
  Modelica.Blocks.Math.Gain CostFactorElictricity(k=235)
    annotation (Placement(transformation(extent={{-210,-18},{-190,2}})));
  Modelica.Blocks.Math.Sum EnergyCosts2
    annotation (Placement(transformation(extent={{10,90},{30,110}})));
  Modelica.Blocks.Math.Gain EmissionsFactorHeat(k=0.2)
    annotation (Placement(transformation(extent={{-154,-60},{-134,-40}})));
  Modelica.Blocks.Math.Gain EmissionsFactorCold(k=0.527)
    annotation (Placement(transformation(extent={{-156,-94},{-136,-74}})));
  Modelica.Blocks.Math.Gain EmissionsFactorElectricity(k=0.626)
    annotation (Placement(transformation(extent={{-154,-128},{-134,-108}})));
  Modelica.Blocks.Math.Sum Emissions
    annotation (Placement(transformation(extent={{-122,-94},{-102,-74}})));
  Modelica.Blocks.Math.Gain CostFactorEmissions(k=19.51)
    annotation (Placement(transformation(extent={{-88,-94},{-68,-74}})));
  Modelica.Blocks.Math.Sum OperatingCosts
    annotation (Placement(transformation(extent={{34,-92},{54,-72}})));
  Modelica.Blocks.Math.Sum TotalCosts
    annotation (Placement(transformation(extent={{194,-134},{214,-114}})));
  Modelica.Blocks.Math.Sum InvestmentCosts
    annotation (Placement(transformation(extent={{42,-400},{62,-380}})));
  Modelica.Blocks.Sources.Constant InvestmentCostsImplementation(k=1)
    annotation (Placement(transformation(extent={{8,-360},{28,-340}})));
  Modelica.Blocks.Sources.Constant InvestmentCostsComponents(k=190)
    annotation (Placement(transformation(extent={{8,-400},{28,-380}})));
  Modelica.Blocks.Sources.Constant Rate(k=0.05) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={76,-16})));
  Modelica.Blocks.Sources.Constant Constant2(k=1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={72,82})));
  Modelica.Blocks.Math.Product product annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={120,-10})));
  Modelica.Blocks.Sources.Constant Constant3(k=-1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={218,90})));
  Modelica.Blocks.Math.Add add annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={166,-16})));
  Modelica.Blocks.Math.Division RBF annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={138,-48})));
  Modelica.Blocks.Sources.Constant Duration(k=1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={70,48})));
  Modelica.Blocks.Math.Product product1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={152,-80})));
  AixLib.Systems.Benchmark.Model.Evaluation.CCCS.DiscountingFactor  discountingFactor annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={138,34})));
  Modelica.Blocks.Math.Add add1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={114,76})));
  Modelica.Blocks.Sources.Constant PerformanceReductionCostsTemperatureHumidity(k=1)
    annotation (Placement(transformation(extent={{-150,-176},{-130,-156}})));
  Modelica.Blocks.Math.Sum PerformanceReductionCosts3
    annotation (Placement(transformation(extent={{-4,-214},{16,-194}})));
  Modelica.Blocks.Sources.Constant PerformanceReductionCostsCO2(k=1)
    annotation (Placement(transformation(extent={{-148,-216},{-128,-196}})));
  Modelica.Blocks.Sources.Constant PerformanceReductionCostsVOC(k=1)
    annotation (Placement(transformation(extent={{-146,-258},{-126,-238}})));
  Modelica.Blocks.Sources.Constant OperationalLifetimeReductionCosts(k=1)
    annotation (Placement(transformation(extent={{-32,-312},{-12,-292}})));
equation
  connect(FixedCostsConnectionHeat.y, CostsConnectingHeat.u[1])
    annotation (Line(points={{-103,130},{-84,130},{-84,164}},
                                                        color={0,0,127}));
  connect(CostFactorConnectionHeat.y, CostsConnectingHeat.u[1])
    annotation (Line(points={{-103,164},{-84,164}},
                                                color={0,0,127}));
  connect(CostsConnectingHeat.y, CostsHeat.u[1])
    annotation (Line(points={{-61,164},{-40,164},{-40,204}},
                                                       color={0,0,127}));
  connect(CostFactorHeat.y, CostsHeat.u[1])
    annotation (Line(points={{-185,204},{-40,204}},
                                                 color={0,0,127}));
  connect(PowerConnectionHeat.y, CostFactorConnectionHeat.u)
    annotation (Line(points={{-133,164},{-126,164}},
                                                 color={0,0,127}));
  connect(Constant.y, PowerConnectionHeat.u[1])
    annotation (Line(points={{-159,131},{-159,164},{-156,164}},
                                                         color={0,0,127}));
  connect(FixedCostsConnectionCold.y, CostsConnectionCold.u[1])
    annotation (Line(points={{-105,26},{-96,26},{-96,60}},   color={0,0,127}));
  connect(CostFactorConnectionCold.y, CostsConnectionCold.u[1])
    annotation (Line(points={{-105,60},{-96,60}},  color={0,0,127}));
  connect(CostsConnectionCold.y, CostsCold.u[1])
    annotation (Line(points={{-73,60},{-42,60},{-42,100}},
                                                         color={0,0,127}));
  connect(CostFactorCold.y, CostsCold.u[1])
    annotation (Line(points={{-189,100},{-42,100}},color={0,0,127}));
  connect(PowerConnectionCold.y, CostFactorConnectionCold.u)
    annotation (Line(points={{-135,60},{-128,60}}, color={0,0,127}));
  connect(CostsHeat.y, EnergyCosts2.u[1])
    annotation (Line(points={{-17,204},{8,204},{8,100}},color={0,0,127}));
  connect(CostsCold.y, EnergyCosts2.u[1])
    annotation (Line(points={{-19,100},{8,100}}, color={0,0,127}));
  connect(CostFactorElictricity.y, EnergyCosts2.u[1]) annotation (Line(points={{-189,-8},
          {8,-8},{8,100}},                color={0,0,127}));
  connect(EmissionsFactorHeat.y, Emissions.u[1]) annotation (Line(points={{-133,
          -50},{-124,-50},{-124,-84}},
                                  color={0,0,127}));
  connect(EmissionsFactorCold.y, Emissions.u[1])
    annotation (Line(points={{-135,-84},{-124,-84}}, color={0,0,127}));
  connect(EmissionsFactorElectricity.y, Emissions.u[1]) annotation (Line(points={{-133,
          -118},{-124,-118},{-124,-84}},     color={0,0,127}));
  connect(Emissions.y, CostFactorEmissions.u)
    annotation (Line(points={{-101,-84},{-90,-84}}, color={0,0,127}));
  connect(CostFactorEmissions.y, OperatingCosts.u[1])
    annotation (Line(points={{-67,-84},{-14,-84},{-14,-82},{32,-82}},
                                                    color={0,0,127}));
  connect(EnergyCosts2.y, OperatingCosts.u[1]) annotation (Line(points={{31,100},
          {32,100},{32,-82}},    color={0,0,127}));
  connect(InvestmentCosts.y, TotalCosts.u[1]) annotation (Line(points={{63,-390},
          {192,-390},{192,-124}}, color={0,0,127}));
  connect(InvestmentCostsImplementation.y, InvestmentCosts.u[1]) annotation (
      Line(points={{29,-350},{40,-350},{40,-390}},    color={0,0,127}));
  connect(InvestmentCostsComponents.y, InvestmentCosts.u[1]) annotation (Line(
        points={{29,-390},{40,-390}},              color={0,0,127}));
  connect(Rate.y, product.u2)
    annotation (Line(points={{87,-16},{108,-16}},            color={0,0,127}));
  connect(Constant3.y, add.u1)
    annotation (Line(points={{218,79},{218,-4},{172,-4}},    color={0,0,127}));
  connect(add.y, RBF.u1) annotation (Line(points={{166,-27},{166,-36},{144,-36}},
        color={0,0,127}));
  connect(product.y, RBF.u2) annotation (Line(points={{131,-10},{131,-36},{132,-36}},
                  color={0,0,127}));
  connect(RBF.y, product1.u1) annotation (Line(points={{138,-59},{138,-74},{140,
          -74}},  color={0,0,127}));
  connect(OperatingCosts.y, product1.u2) annotation (Line(points={{55,-82},{106,
          -82},{106,-86},{140,-86}},    color={0,0,127}));
  connect(product1.y, TotalCosts.u[1]) annotation (Line(points={{163,-80},{192,-80},
          {192,-124}},       color={0,0,127}));
public
  block DiscountingFactor
    extends Modelica.Blocks.Interfaces.SI2SO;

    parameter Real k1=+1 "Gain of upper input";
    parameter Real k2=+1 "Gain of lower input";

  equation
    y = (k1*u1)^(k2*u2);
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Text(
            lineColor={0,0,255},
            extent={{-150,110},{150,150}},
            textString="DiscountingFactor"),
          Text(extent={{-38,-34},{38,34}}, textString="DiscountingFactor"),
          Text(extent={{-100,52},{5,92}}, textString="q"),
          Text(extent={{-100,-92},{5,-52}}, textString="t")}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics={Rectangle(
              extent={{-100,-100},{100,100}},
              lineColor={0,0,127},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Text(
              extent={{-36,38},{40,-30}},
              lineColor={0,0,0},
              textString="DiscountingFactor"),Text(
              extent={{-100,52},{5,92}},
              lineColor={0,0,0},
              textString="q"),Text(
              extent={{-100,-52},{5,-92}},
              lineColor={0,0,0},
              textString="t")}));
  end DiscountingFactor;
equation
  connect(Constant.y, PowerConnectionCold.u[1]) annotation (Line(points={{-159,131},
          {-159,94.5},{-158,94.5},{-158,60}}, color={0,0,127}));
public
  model EnergyCosts



    Modelica.Blocks.Math.Gain CostFactorHeat(k=49.41)
      annotation (Placement(transformation(extent={{-130,102},{-110,122}})));
    Modelica.Blocks.Math.Sum CostsHeat
      annotation (Placement(transformation(extent={{38,102},{58,122}})));
    Modelica.Blocks.Sources.Constant Constant(k=-30) annotation (Placement(
          transformation(
          extent={{-10,-11},{10,11}},
          rotation=0,
          origin={-94,39})));
    Modelica.Blocks.Sources.Constant FixedCostsConnectionHeat(k=1690)
      annotation (Placement(transformation(extent={{-48,28},{-28,48}})));
    Modelica.Blocks.Math.Gain CostFactorConnectionHeat(k=27.14)
      annotation (Placement(transformation(extent={{-48,62},{-28,82}})));
    Modelica.Blocks.Math.Sum CostsConnectingHeat
      annotation (Placement(transformation(extent={{-6,62},{14,82}})));
    Modelica.Blocks.Math.Sum PowerConnectionHeat
      annotation (Placement(transformation(extent={{-78,62},{-58,82}})));
    Modelica.Blocks.Math.Gain CostFactorCold(k=81)
      annotation (Placement(transformation(extent={{-134,-2},{-114,18}})));
    Modelica.Blocks.Math.Sum CostsCold
      annotation (Placement(transformation(extent={{36,-2},{56,18}})));
    Modelica.Blocks.Sources.Constant FixedCostsConnectionCold(k=1690)
      annotation (Placement(transformation(extent={{-50,-76},{-30,-56}})));
    Modelica.Blocks.Math.Gain CostFactorConnectionCold(k=27.14)
      annotation (Placement(transformation(extent={{-50,-42},{-30,-22}})));
    Modelica.Blocks.Math.Sum CostsConnectionCold
      annotation (Placement(transformation(extent={{-18,-42},{2,-22}})));
    Modelica.Blocks.Math.Sum PowerConnectionCold
      annotation (Placement(transformation(extent={{-80,-42},{-60,-22}})));
    Modelica.Blocks.Math.Gain CostFactorElictricity(k=235)
      annotation (Placement(transformation(extent={{-134,-110},{-114,-90}})));
    Modelica.Blocks.Math.Sum EnergyCosts2
      annotation (Placement(transformation(extent={{90,-2},{110,18}})));
  equation

    connect(FixedCostsConnectionHeat.y,CostsConnectingHeat. u[1])
      annotation (Line(points={{-27,38},{-8,38},{-8,72}}, color={0,0,127}));
    connect(CostFactorConnectionHeat.y,CostsConnectingHeat. u[1])
      annotation (Line(points={{-27,72},{-8,72}}, color={0,0,127}));
    connect(CostsConnectingHeat.y,CostsHeat. u[1])
      annotation (Line(points={{15,72},{36,72},{36,112}},color={0,0,127}));
    connect(CostFactorHeat.y,CostsHeat. u[1])
      annotation (Line(points={{-109,112},{36,112}},
                                                   color={0,0,127}));
    connect(PowerConnectionHeat.y,CostFactorConnectionHeat. u)
      annotation (Line(points={{-57,72},{-50,72}}, color={0,0,127}));
    connect(Constant.y,PowerConnectionHeat. u[1])
      annotation (Line(points={{-83,39},{-83,72},{-80,72}},color={0,0,127}));
    connect(FixedCostsConnectionCold.y,CostsConnectionCold. u[1])
      annotation (Line(points={{-29,-66},{-20,-66},{-20,-32}}, color={0,0,127}));
    connect(CostFactorConnectionCold.y,CostsConnectionCold. u[1])
      annotation (Line(points={{-29,-32},{-20,-32}}, color={0,0,127}));
    connect(CostsConnectionCold.y,CostsCold. u[1])
      annotation (Line(points={{3,-32},{34,-32},{34,8}},   color={0,0,127}));
    connect(CostFactorCold.y,CostsCold. u[1])
      annotation (Line(points={{-113,8},{34,8}},     color={0,0,127}));
    connect(PowerConnectionCold.y,CostFactorConnectionCold. u)
      annotation (Line(points={{-59,-32},{-52,-32}}, color={0,0,127}));
    connect(CostsHeat.y,EnergyCosts2. u[1])
      annotation (Line(points={{59,112},{88,112},{88,8}}, color={0,0,127}));
    connect(CostsCold.y,EnergyCosts2. u[1])
      annotation (Line(points={{57,8},{88,8}},     color={0,0,127}));
    connect(CostFactorElictricity.y,EnergyCosts2. u[1]) annotation (Line(points={{-113,
            -100},{88,-100},{88,8}},        color={0,0,127}));
    connect(Constant.y,PowerConnectionCold. u[1]) annotation (Line(points={{-83,39},
            {-83,2.5},{-82,2.5},{-82,-32}},     color={0,0,127}));

    annotation (Diagram(graphics={  Rectangle(
              extent={{-164,-148},{148,160}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),Text(
              extent={{-106,86},{-1,126}},
              lineColor={0,0,0},
              textString=""),Text(
              extent={{-106,12},{-1,52}},
              lineColor={0,0,0},
              textString=""),Text(
              extent={{-106,-18},{-1,-58}},
              lineColor={0,0,0},
              textString="")}),
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Text(
            lineColor={0,0,255},
            extent={{-150,110},{150,150}},
            textString="EnergyCosts"),
          Text(extent={{-38,-34},{38,34}}, textString="EnergyCosts"),
          Text(extent={{-100,52},{5,92}}, textString=""),
          Text(extent={{-100,-92},{5,-52}}, textString="")}));
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
  
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Text(
          lineColor={0,0,255},
          extent={{-150,110},{150,150}},
          textString=\"EnergyCosts\"),
        Text(extent={{-38,-34},{38,34}}, textString=\"PerformanceReductionCosts\"),
        Text(extent={{-100,52},{5,92}}, textString=\"\"),
        Text(extent={{-100,-92},{5,-52}}, textString=\"\")}));
  

Real humidity;
Real LRM;

equation
  
if humidty<0.25
then 
        if deltaT<-2
        then LRM=0.2*(-4*humidity+1)+0.04*(abs(deltaT)-2);
        else   if (deltaT>2)
              then LRM=0.2*(-4*humidity+1)+0.02*(abs(deltaT)-2);
              else LRM=0.2*(-4*humidity+1);
             ;
  
    ;
else 
        if humidity>0.65
        then 
              if deltaT<-2
              then LRM=(humidity-0.65)*0.42+0.04*(abs(deltaT)-2);
              else   if (deltaT>2)
                    then LRM=(humidity-0.65)*0.42+0.02*(abs(deltaT)-2);
                    else LRM=(humidity-0.65)*0.42;  
                  ; 
             ;
        else
                 
              if deltaT<-)
              then LRM=0.04*(abs(deltaT)-2);
              else 
                     if (deltaT>2)
                    then(LRM=0.02*(deltaT-2));
                    else(LRM=0);
                  
                  ;
            ;
                
    ;
end PerformanceReductionCosts;
"));
  end PerformanceReductionCosts;
equation
  connect(discountingFactor.y, product.u1)
    annotation (Line(points={{138,23},{108,23},{108,-4}}, color={0,0,127}));
  connect(discountingFactor.y, add.u2) annotation (Line(points={{138,23},{161.5,23},
          {161.5,-4},{160,-4}}, color={0,0,127}));
  connect(Duration.y, discountingFactor.u2)
    annotation (Line(points={{81,48},{132,48},{132,46}}, color={0,0,127}));
  connect(Constant2.y, add1.u1)
    annotation (Line(points={{83,82},{102,82}}, color={0,0,127}));
  connect(Rate.y, add1.u2) annotation (Line(points={{87,-16},{87,48},{88,48},{88,
          70},{102,70}}, color={0,0,127}));
  connect(add1.y, discountingFactor.u1)
    annotation (Line(points={{125,76},{144,76},{144,46}}, color={0,0,127}));
  connect(PerformanceReductionCostsCO2.y, PerformanceReductionCosts3.u[1])
    annotation (Line(points={{-127,-206},{-66,-206},{-66,-204},{-6,-204}},
        color={0,0,127}));
  connect(PerformanceReductionCostsTemperatureHumidity.y,
    PerformanceReductionCosts3.u[1]) annotation (Line(points={{-129,-166},{-6,-166},
          {-6,-204}}, color={0,0,127}));
  connect(PerformanceReductionCostsVOC.y, PerformanceReductionCosts3.u[1])
    annotation (Line(points={{-125,-248},{-6,-248},{-6,-204}}, color={0,0,127}));
  connect(PerformanceReductionCosts3.y, OperatingCosts.u[1])
    annotation (Line(points={{17,-204},{32,-204},{32,-82}}, color={0,0,127}));
  connect(OperationalLifetimeReductionCosts.y, OperatingCosts.u[1])
    annotation (Line(points={{-11,-302},{32,-302},{32,-82}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Text(
          extent={{-50,-20},{40,20}},
          lineColor={0,0,0},
          textString="CCCS")}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-200,-200},{
            200,200}}), graphics={Rectangle(
            extent={{-250,-414},{230,248}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),Text(
            extent={{-182,174},{-77,214}},
            lineColor={0,0,0},
            textString=""),Text(
            extent={{-182,104},{-77,144}},
            lineColor={0,0,0},
            textString=""),Text(
            extent={{-182,74},{-77,34}},
            lineColor={0,0,0},
            textString=""),Text(
            extent={{98,228},{196,148}},
            lineColor={0,0,0},
            textString="CCCS")}));
end CCCS;
