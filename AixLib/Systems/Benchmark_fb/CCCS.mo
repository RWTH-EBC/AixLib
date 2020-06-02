within AixLib.Systems.Benchmark_fb;
package CCCS
  extends Modelica.Icons.Package;

  model Evaluation_CCCS
    parameter Real simulation_time=4838400;
    Modelica.Blocks.Math.Product product1 annotation (
      Placement(visible = true, transformation(origin={20,40},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.Systems.Benchmark_fb.CCCS.BaseClasses.RBF RBF(i = 0.05, t = 1) annotation (
      Placement(visible = true, transformation(origin={-20,80},    extent = {{-10, -10}, {10, 10}}, rotation=0)));
    Modelica.Blocks.Math.MultiSum OperationalCosts(k={1,1,1},        nu=3)   annotation (
      Placement(visible = true, transformation(extent={{-26,34},{-14,46}},      rotation = 0)));
    Modelica.Blocks.Math.Add OverallCost annotation (
      Placement(visible = true, transformation(extent={{50,-10},{70,10}},      rotation = 0)));
    AixLib.Systems.Benchmark_fb.CCCS.Components.PerformanceReductionCosts
      performanceReductionCosts1( sim_time=simulation_time) annotation (Placement(visible=true,
          transformation(
          origin={-70,20},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    Modelica.Blocks.Math.Add InvestmentCosts annotation (
      Placement(visible = true, transformation(origin={-18,-70},   extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.Systems.Benchmark_fb.CCCS.Components.InvestmentCostsStrategy
      investmentCostsStrategy1 annotation (Placement(visible=true,
          transformation(
          origin={-70,-40},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    Benchmark.BaseClasses.MainBus mainBus annotation (
      Placement(transformation(extent = {{-110, -10}, {-90, 10}})));
    Components.InvestmentCostsComponents investmentCostsComponents(k_Investment=
         0)
      annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
    AixLib.Systems.Benchmark_fb.CCCS.Components.EnergyCosts energyCosts1
      annotation (Placement(visible=true, transformation(
          origin={-70,80},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    AixLib.Systems.Benchmark_fb.CCCS.Components.EmissionsCosts emissionsCosts1
      annotation (Placement(visible=true, transformation(
          origin={-70,52},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    BaseClasses.CCCSBus CCCSBus
      annotation (Placement(transformation(extent={{78,-18},{118,18}})));
  equation
    connect(energyCosts1.EnergyCost, OperationalCosts.u[1]) annotation (
      Line(points={{-59,80},{-40,80},{-40,42.8},{-26,42.8}},                                  color = {0, 0, 127}));
    connect(emissionsCosts1.Emission_Cost, OperationalCosts.u[3]) annotation (
      Line(points={{-59,52},{-40,52},{-40,37.2},{-26,37.2}},            color = {0, 0, 127}));
    connect(performanceReductionCosts1.PRC, OperationalCosts.u[2]) annotation (
      Line(points={{-59,12},{-40,12},{-40,40},{-26,40}},                color = {0, 0, 127}));
    connect(OperationalCosts.y, product1.u2) annotation (
      Line(points={{-12.98,40},{0,40},{0,34},{8,34}},
                                             color = {0, 0, 127}));
    connect(RBF.RBF, product1.u1) annotation (
      Line(points={{-9,80},{0,80},{0,46},{8,46}},                                       color = {0, 0, 127}));
    connect(product1.y, OverallCost.u1) annotation (
      Line(points={{31,40},{40,40},{40,6},{48,6}},                                         color = {0, 0, 127}));
    connect(InvestmentCosts.y, OverallCost.u2) annotation (
      Line(points={{-7,-70},{40,-70},{40,-6},{48,-6}},          color = {0, 0, 127}));
    connect(investmentCostsComponents.y, InvestmentCosts.u2) annotation (
      Line(points={{-59.4,-70},{-40,-70},{-40,-76},{-30,-76}},        color = {0, 0, 127}));
    connect(investmentCostsStrategy1.kStrat, InvestmentCosts.u1) annotation (
      Line(points={{-59.8,-40},{-40,-40},{-40,-64},{-30,-64}},        color = {0, 0, 127}));

    connect(mainBus, performanceReductionCosts1.mainBus) annotation (Line(
        points={{-100,0},{-100,20},{-80.2,20}},
        color={255,204,51},
        thickness=0.5));
    connect(mainBus.evaBus.WelTotalMea, energyCosts1.WelTotal) annotation (Line(
        points={{-99.95,0.05},{-100,0.05},{-100,80},{-82,80}},
        color={255,204,51},
        thickness=0.5));
    connect(mainBus.evaBus.QbrTotalMea, energyCosts1.FuelTotal) annotation (
        Line(
        points={{-99.95,0.05},{-102,0.05},{-102,2},{-100,2},{-100,72},{-82,72},
            {-82,71}},
        color={255,204,51},
        thickness=0.5));
    connect(mainBus.evaBus.WelTotalMea, emissionsCosts1.WelTotal) annotation (
        Line(
        points={{-99.95,0.05},{-102,0.05},{-102,2},{-100,2},{-100,60},{-82,60},
            {-82,53}},
        color={255,204,51},
        thickness=0.5));
    connect(mainBus.evaBus.QbrTotalMea, emissionsCosts1.FuelTotal) annotation (
        Line(
        points={{-99.95,0.05},{-100,0.05},{-100,54},{-82,54},{-82,45}},
        color={255,204,51},
        thickness=0.5));
    connect(OverallCost.y, CCCSBus.CCCS)
      annotation (Line(points={{71,0},{98,0}}, color={0,0,127}));
    connect(energyCosts1.EnergyCost, CCCSBus.EnergyCosts) annotation (Line(
          points={{-59,80},{-40,80},{-40,100},{100,100},{100,0},{98,0}}, color=
            {0,0,127}));
    connect(emissionsCosts1.Emission_Cost, CCCSBus.EmissionCosts) annotation (
        Line(points={{-59,52},{-40,52},{-40,100},{100,100},{100,0},{98,0}},
          color={0,0,127}));
    connect(performanceReductionCosts1.PRC, CCCSBus.PerformanceReductionCosts)
      annotation (Line(points={{-59,12},{-40,12},{-40,100},{100,100},{100,0},{
            98,0}}, color={0,0,127}));
    connect(investmentCostsStrategy1.kStrat, CCCSBus.InvestmenCostsStrategy)
      annotation (Line(points={{-59.8,-40},{-40,-40},{-40,-100},{100,-100},{100,
            -2},{98,-2},{98,0}}, color={0,0,127}));
    connect(investmentCostsComponents.y, CCCSBus.InvestmentCostsComponents)
      annotation (Line(points={{-59.4,-70},{-40,-70},{-40,-100},{100,-100},{100,
            0},{98,0}}, color={0,0,127}));
    connect(InvestmentCosts.y, CCCSBus.InvestmentCosts) annotation (Line(points
          ={{-7,-70},{40,-70},{40,-100},{100,-100},{100,0},{98,0}}, color={0,0,
            127}));
    connect(product1.y, CCCSBus.OperationalCosts) annotation (Line(points={{31,
            40},{40,40},{40,100},{100,100},{100,0},{98,0}}, color={0,0,127}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics={  Rectangle(fillColor = {215, 215, 215},
              fillPattern =                                                                                                                    FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(lineColor = {95, 95, 95}, fillColor = {215, 215, 215},
              fillPattern =                                                                                                                                                                                                        FillPattern.Solid, extent = {{-72, 34}, {78, -30}}, textString = "CCCS")}),
      Diagram(coordinateSystem(preserveAspectRatio = false)),
      Documentation(info = "<html><head></head><body>Evaluation method Cost Coefficient for Control Strategies (CCCS) to evaluate performance of control strategies</body></html>"));
  end Evaluation_CCCS;

  package Components
    model InvestmentCostsComponents
      Modelica.Blocks.Sources.Constant InvestmentCostsComponents(k = k_Investment) "it is assumed that the control strategy only utilizes components which are already installed - if new components are required, respective costs have to be added" annotation (
        Placement(visible = true, transformation(extent = {{-14, -10}, {6, 10}}, rotation = 0)));
      parameter Real k_Investment = 0 "Investment Costs";
      Modelica.Blocks.Interfaces.RealOutput y annotation (
        Placement(transformation(extent = {{96, -10}, {116, 10}})));
    equation
      connect(InvestmentCostsComponents.y, y) annotation (
        Line(points = {{7, 0}, {106, 0}}, color = {0, 0, 127}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics={  Rectangle(fillColor = {215, 215, 215},
                fillPattern =                                                                                                                    FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(lineColor=
                  {95,95,95},                                                                                                                                                                                                        fillColor=
                  {215,215,215},
                fillPattern=FillPattern.Solid,                                                                                                                                                                                                        extent = {{-64, 38}, {58, -34}},
              textString="Investment
Components")}),
        Diagram(coordinateSystem(preserveAspectRatio = false)),
        Documentation(info = "<html><head></head><body>calculating investment for new components &nbsp;as part of the CCCS evaulation method</body></html>"));
    end InvestmentCostsComponents;

    model LifespanReductionCosts
      parameter Real simTime= 4838400;
      Modelica.Blocks.Interfaces.RealOutput y annotation (
        Placement(visible = true, transformation(origin={166,0},    extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin={166,0},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      AixLib.Systems.Benchmark.BaseClasses.MainBus mainBus annotation (
        Placement(visible = true, transformation(extent = {{-110, -4}, {-90, 16}}, rotation = 0), iconTransformation(extent = {{-110, -4}, {-90, 16}}, rotation = 0)));
      Modelica.Blocks.Routing.RealPassThrough HP_PumpHot_rpmSet annotation (
        Placement(transformation(extent={{-88,132},{-72,148}})));
      Modelica.Blocks.Routing.RealPassThrough HP_PumpCold_rpmSet annotation (
        Placement(transformation(extent={{-90,102},{-74,118}})));
      Modelica.Blocks.Routing.RealPassThrough HP_ThrottleHS_valveSet annotation (
        Placement(transformation(extent={{-90,72},{-74,88}})));
      Modelica.Blocks.Routing.RealPassThrough HP_ThrottleRecool_valveSet annotation (
        Placement(transformation(extent={{-90,42},{-74,58}})));
      Modelica.Blocks.Routing.RealPassThrough HP_ThrottleFreecool_valveSet annotation (
        Placement(transformation(extent={{-90,-18},{-74,-2}})));
      Modelica.Blocks.Routing.RealPassThrough HP_ThrottleCS_valveSet annotation (
        Placement(transformation(extent={{-90,12},{-74,28}})));
      AixLib.Systems.Benchmark_fb.CCCS.BaseClasses.Lifespan_Reduction_Cost_Component lifespan_Reduction_Cost_Pumps[36](each cost_component = 3000, each sim_time = simTime) annotation (
        Placement(visible = true, transformation(origin={100,50},   extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.MultiSum multiSum1(nu = 72) annotation (
        Placement(visible = true, transformation(origin={140,0},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      AixLib.Systems.Benchmark_fb.CCCS.BaseClasses.Lifespan_Reduction_Cost_Component lifespan_Reduction_Cost_Valves[36](each cost_component = 1000, each sim_time = simTime) annotation (
        Placement(visible = true, transformation(origin={102,-50},   extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Routing.RealPassThrough gtf_prim_rpmSet annotation (
        Placement(transformation(extent={{-46,58},{-32,72}})));
      Modelica.Blocks.Routing.RealPassThrough hts_chp_rpmSet annotation (
        Placement(transformation(extent={{-46,90},{-32,104}})));
      Modelica.Blocks.Routing.RealPassThrough hts_boiler_rpmSet annotation (
        Placement(transformation(extent={{-46,120},{-32,134}})));
      Modelica.Blocks.Routing.RealPassThrough gtf_sec_valveSet annotation (
        Placement(transformation(extent={{-46,30},{-32,44}})));
      Modelica.Blocks.Routing.RealPassThrough tabs_hotThrottle_rpmSet[5] annotation (
        Placement(transformation(extent={{-6,104},{8,118}})));
      Modelica.Blocks.Routing.RealPassThrough tabs_pump_rpmSet[5] annotation (
        Placement(transformation(extent={{-8,132},{6,146}})));
      Modelica.Blocks.Routing.RealPassThrough tabs_coldThrottle_valveSet[5] annotation (
        Placement(transformation(extent={{-6,12},{8,26}})));
      Modelica.Blocks.Routing.RealPassThrough tabs_hotThrottle_valveSet[5] annotation (
        Placement(transformation(extent={{-6,72},{8,86}})));
      Modelica.Blocks.Routing.RealPassThrough tabs_coldThrottle_rpmSet[5] annotation (
        Placement(transformation(extent={{-6,42},{8,56}})));
      Modelica.Blocks.Routing.RealPassThrough vu_heater_rpmSet[5] annotation (
        Placement(transformation(extent={{-8,-18},{6,-4}})));
      Modelica.Blocks.Routing.RealPassThrough vu_cooler_valveSet[5] annotation (
        Placement(transformation(extent={{-8,-106},{6,-92}})));
      Modelica.Blocks.Routing.RealPassThrough vu_heater_valveSet[5] annotation (
        Placement(transformation(extent={{-8,-48},{6,-34}})));
      Modelica.Blocks.Routing.RealPassThrough vu_cooler_rpmSet[5] annotation (
        Placement(transformation(extent={{-8,-78},{6,-64}})));
      Modelica.Blocks.Routing.RealPassThrough hx_sec_rpmSet annotation (
        Placement(transformation(extent={{-90,-78},{-76,-64}})));
      Modelica.Blocks.Routing.RealPassThrough hx_prim_valveSet annotation (
        Placement(transformation(extent={{-90,-46},{-76,-32}})));
      Modelica.Blocks.Routing.RealPassThrough hx_prim_rpmSet annotation (
        Placement(transformation(extent={{-88,-136},{-74,-122}})));
      Modelica.Blocks.Routing.RealPassThrough hx_sec_valveSet annotation (
        Placement(transformation(extent={{-90,-106},{-76,-92}})));
      Modelica.Blocks.Routing.RealPassThrough swu_Y3valveSet annotation (
        Placement(transformation(extent={{32,-34},{46,-20}})));
      Modelica.Blocks.Routing.RealPassThrough swu_Y2valveSet annotation (
        Placement(transformation(extent={{34,2},{48,16}})));
      Modelica.Blocks.Routing.RealPassThrough swu_pump_rpmSet annotation (
        Placement(transformation(extent={{32,28},{46,42}})));
      Modelica.Blocks.Routing.RealPassThrough swu_K1valveSet annotation (
        Placement(transformation(extent={{32,-64},{46,-50}})));
      Modelica.Blocks.Routing.RealPassThrough swu_K3valveSet annotation (
        Placement(transformation(extent={{32,-124},{46,-110}})));
      Modelica.Blocks.Routing.RealPassThrough swu_K2valveSet annotation (
        Placement(transformation(extent={{30,-96},{44,-82}})));
      Modelica.Blocks.Routing.RealPassThrough swu_K4valveSet annotation (
        Placement(transformation(extent={{32,-150},{46,-136}})));
      Modelica.Blocks.Routing.RealPassThrough ahu_heater_rpmSet annotation (
        Placement(transformation(extent={{-46,-62},{-32,-48}})));
      Modelica.Blocks.Routing.RealPassThrough ahu_preheater_valveSet annotation (
        Placement(transformation(extent={{-46,-32},{-32,-18}})));
      Modelica.Blocks.Routing.RealPassThrough ahu_preheater_rpmSet annotation (
        Placement(transformation(extent={{-46,-2},{-32,12}})));
      Modelica.Blocks.Routing.RealPassThrough ahu_heater_valveSet annotation (
        Placement(transformation(extent={{-46,-90},{-32,-76}})));
      Modelica.Blocks.Routing.RealPassThrough ahu_cooler_rpmSet annotation (
        Placement(transformation(extent={{-48,-120},{-34,-106}})));
      Modelica.Blocks.Routing.RealPassThrough ahu_cooler_valveSet annotation (
        Placement(transformation(extent={{-48,-148},{-34,-134}})));
      inner Modelica.Fluid.System system
        annotation (Placement(transformation(extent={{140,140},{160,160}})));
    equation
      connect(mainBus.hpSystemBus.busThrottleRecool.valveSet, HP_ThrottleRecool_valveSet.u) annotation (
        Line(points={{-99.95,6.05},{-99.95,50},{-91.6,50}},          color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.hpSystemBus.busThrottleFreecool.valveSet, HP_ThrottleFreecool_valveSet.u) annotation (
        Line(points={{-99.95,6.05},{-99.95,-10},{-91.6,-10}},          color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.hpSystemBus.busPumpHot.pumpBus.rpmSet, HP_PumpHot_rpmSet.u) annotation (
        Line(points={{-99.95,6.05},{-99.95,140},{-89.6,140}},        color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.hpSystemBus.busThrottleCS.valveSet, HP_ThrottleCS_valveSet.u) annotation (
        Line(points={{-99.95,6.05},{-100,6.05},{-100,20},{-91.6,20}},            color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.hpSystemBus.busThrottleHS.valveSet, HP_ThrottleHS_valveSet.u) annotation (
        Line(points={{-99.95,6.05},{-99.95,80},{-91.6,80}},        color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.hpSystemBus.busPumpCold.pumpBus.rpmSet, HP_PumpCold_rpmSet.u) annotation (
        Line(points={{-99.95,6.05},{-99.95,110},{-91.6,110}},      color = {255, 204, 51}, thickness = 0.5));
      connect(multiSum1.y, y) annotation (
        Line(points={{151.7,0},{166,0}},      color = {0, 0, 127}));
      connect(mainBus.htsBus.pumpBoilerBus.pumpBus.rpmSet, hts_boiler_rpmSet.u) annotation (
        Line(points={{-99.95,6.05},{-100,6.05},{-100,126},{-80,126},{-80,127},{
              -47.4,127}},                                                                               color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.htsBus.pumpChpBus.pumpBus.rpmSet, hts_chp_rpmSet.u) annotation (
        Line(points={{-99.95,6.05},{-99.95,97},{-47.4,97}},        color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.gtfBus.primBus.pumpBus.rpmSet, gtf_prim_rpmSet.u) annotation (
        Line(points={{-99.95,6.05},{-100,6.05},{-100,68},{-47.4,68},{-47.4,65}},
                                                                             color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.gtfBus.secBus.valveSet, gtf_sec_valveSet.u) annotation (
        Line(points={{-99.95,6.05},{-99.95,37},{-47.4,37}},          color = {255, 204, 51}, thickness = 0.5));
      connect(HP_PumpHot_rpmSet.y, lifespan_Reduction_Cost_Pumps[1].u) annotation (
        Line(points={{-71.2,140},{-68,140},{-68,160},{80,160},{80,50},{89.6,50}},              color = {0, 0, 127}));
      connect(HP_PumpCold_rpmSet.y, lifespan_Reduction_Cost_Pumps[2].u) annotation (
        Line(points={{-73.2,110},{-68,110},{-68,160},{80,160},{80,50},{89.6,50}},            color = {0, 0, 127}));
      connect(HP_ThrottleHS_valveSet.y, lifespan_Reduction_Cost_Valves[1].u) annotation (
        Line(points={{-73.2,80},{-60,80},{-60,-160},{80,-160},{80,-50},{91.6,
              -50}},                                                                             color = {0, 0, 127}));
      connect(HP_ThrottleRecool_valveSet.y, lifespan_Reduction_Cost_Valves[2].u) annotation (
        Line(points={{-73.2,50},{-60,50},{-60,-160},{80,-160},{80,-50},{91.6,
              -50}},                                                                               color = {0, 0, 127}));
      connect(HP_ThrottleCS_valveSet.y, lifespan_Reduction_Cost_Valves[3].u) annotation (
        Line(points={{-73.2,20},{-60,20},{-60,-160},{80,-160},{80,-50},{91.6,
              -50}},                                                                               color = {0, 0, 127}));
      connect(HP_ThrottleFreecool_valveSet.y, lifespan_Reduction_Cost_Valves[4].u) annotation (
        Line(points={{-73.2,-10},{-60,-10},{-60,-160},{80,-160},{80,-50},{91.6,
              -50}},                                                                                 color = {0, 0, 127}));
      connect(hts_boiler_rpmSet.y, lifespan_Reduction_Cost_Pumps[3].u) annotation (
        Line(points={{-31.3,127},{-20,127},{-20,160},{80,160},{80,50},{89.6,50}},              color = {0, 0, 127}));
      connect(hts_chp_rpmSet.y, lifespan_Reduction_Cost_Pumps[4].u) annotation (
        Line(points={{-31.3,97},{-20,97},{-20,160},{80,160},{80,50},{89.6,50}},              color = {0, 0, 127}));
      connect(gtf_prim_rpmSet.y, lifespan_Reduction_Cost_Pumps[5].u) annotation (
        Line(points={{-31.3,65},{-20,65},{-20,160},{80,160},{80,50},{89.6,50}},            color = {0, 0, 127}));
      connect(gtf_sec_valveSet.y, lifespan_Reduction_Cost_Valves[5].u) annotation (
        Line(points={{-31.3,37},{-32,37},{-32,36},{-20,36},{-20,-160},{80,-160},
              {80,-50},{91.6,-50}},                                                                color = {0, 0, 127}));
      connect(tabs_pump_rpmSet[1].y, lifespan_Reduction_Cost_Pumps[6].u) annotation (
        Line(points={{6.7,139},{20,139},{20,160},{80,160},{80,50},{89.6,50}},                color = {0, 0, 127}));
      connect(tabs_hotThrottle_rpmSet[1].y, lifespan_Reduction_Cost_Pumps[7].u) annotation (
        Line(points={{8.7,111},{20,111},{20,160},{80,160},{80,50},{89.6,50}},              color = {0, 0, 127}));
      connect(tabs_coldThrottle_rpmSet[1].y, lifespan_Reduction_Cost_Pumps[8].u) annotation (
        Line(points={{8.7,49},{20,49},{20,160},{80,160},{80,50},{89.6,50}},                                      color = {0, 0, 127}));
      connect(tabs_pump_rpmSet[2].y, lifespan_Reduction_Cost_Pumps[9].u) annotation (
        Line(points={{6.7,139},{20,139},{20,160},{80,160},{80,50},{89.6,50}},                color = {0, 0, 127}));
      connect(tabs_hotThrottle_rpmSet[2].y, lifespan_Reduction_Cost_Pumps[10].u) annotation (
        Line(points={{8.7,111},{20,111},{20,160},{80,160},{80,50},{89.6,50}},              color = {0, 0, 127}));
      connect(tabs_coldThrottle_rpmSet[2].y, lifespan_Reduction_Cost_Pumps[11].u) annotation (
        Line(points={{8.7,49},{18,49},{18,50},{20,50},{20,160},{80,160},{80,50},
              {89.6,50}},                                                                                        color = {0, 0, 127}));
      connect(tabs_pump_rpmSet[3].y, lifespan_Reduction_Cost_Pumps[12].u) annotation (
        Line(points={{6.7,139},{20,139},{20,160},{80,160},{80,50},{89.6,50}},                color = {0, 0, 127}));
      connect(tabs_hotThrottle_rpmSet[3].y, lifespan_Reduction_Cost_Pumps[13].u) annotation (
        Line(points={{8.7,111},{20,111},{20,160},{80,160},{80,50},{89.6,50}},              color = {0, 0, 127}));
      connect(tabs_coldThrottle_rpmSet[3].y, lifespan_Reduction_Cost_Pumps[14].u) annotation (
        Line(points={{8.7,49},{18,49},{18,52},{20,52},{20,160},{80,160},{80,50},
              {89.6,50}},                                                                                        color = {0, 0, 127}));
      connect(tabs_pump_rpmSet[4].y, lifespan_Reduction_Cost_Pumps[15].u) annotation (
        Line(points={{6.7,139},{20,139},{20,160},{80,160},{80,50},{89.6,50}},                color = {0, 0, 127}));
      connect(tabs_hotThrottle_rpmSet[4].y, lifespan_Reduction_Cost_Pumps[16].u) annotation (
        Line(points={{8.7,111},{20,111},{20,160},{80,160},{80,50},{89.6,50}},              color = {0, 0, 127}));
      connect(tabs_coldThrottle_rpmSet[4].y, lifespan_Reduction_Cost_Pumps[17].u) annotation (
        Line(points={{8.7,49},{18,49},{18,50},{20,50},{20,160},{80,160},{80,50},
              {89.6,50}},                                                                                        color = {0, 0, 127}));
      connect(tabs_pump_rpmSet[5].y, lifespan_Reduction_Cost_Pumps[18].u) annotation (
        Line(points={{6.7,139},{20,139},{20,160},{80,160},{80,50},{89.6,50}},                color = {0, 0, 127}));
      connect(tabs_hotThrottle_rpmSet[5].y, lifespan_Reduction_Cost_Pumps[19].u) annotation (
        Line(points={{8.7,111},{20,111},{20,160},{80,160},{80,50},{89.6,50}},              color = {0, 0, 127}));
      connect(tabs_coldThrottle_rpmSet[5].y, lifespan_Reduction_Cost_Pumps[20].u) annotation (
        Line(points={{8.7,49},{18,49},{18,50},{20,50},{20,160},{80,160},{80,50},
              {89.6,50}},                                                                                        color = {0, 0, 127}));
      connect(tabs_hotThrottle_valveSet[1].y, lifespan_Reduction_Cost_Valves[6].u) annotation (
        Line(points={{8.7,79},{2,79},{2,82},{20,82},{20,-160},{80,-160},{80,-50},
              {91.6,-50}},                                                                     color = {0, 0, 127}));
      connect(tabs_coldThrottle_valveSet[1].y, lifespan_Reduction_Cost_Valves[7].u) annotation (
        Line(points={{8.7,19},{4,19},{4,20},{20,20},{20,-160},{80,-160},{80,-50},
              {91.6,-50}},                                                                     color = {0, 0, 127}));
      connect(tabs_hotThrottle_valveSet[2].y, lifespan_Reduction_Cost_Valves[8].u) annotation (
        Line(points={{8.7,79},{2,79},{2,82},{20,82},{20,-160},{80,-160},{80,-50},
              {91.6,-50}},                                                                     color = {0, 0, 127}));
      connect(tabs_coldThrottle_valveSet[2].y, lifespan_Reduction_Cost_Valves[9].u) annotation (
        Line(points={{8.7,19},{4,19},{4,20},{20,20},{20,-160},{80,-160},{80,-50},
              {91.6,-50}},                                                                     color = {0, 0, 127}));
      connect(tabs_hotThrottle_valveSet[3].y, lifespan_Reduction_Cost_Valves[10].u) annotation (
        Line(points={{8.7,79},{2,79},{2,82},{20,82},{20,-160},{80,-160},{80,-50},
              {91.6,-50}},                                                                     color = {0, 0, 127}));
      connect(tabs_coldThrottle_valveSet[3].y, lifespan_Reduction_Cost_Valves[11].u) annotation (
        Line(points={{8.7,19},{4,19},{4,20},{20,20},{20,-160},{80,-160},{80,-50},
              {91.6,-50}},                                                                     color = {0, 0, 127}));
      connect(tabs_hotThrottle_valveSet[4].y, lifespan_Reduction_Cost_Valves[12].u) annotation (
        Line(points={{8.7,79},{2,79},{2,82},{20,82},{20,-160},{80,-160},{80,-50},
              {91.6,-50}},                                                                     color = {0, 0, 127}));
      connect(tabs_coldThrottle_valveSet[4].y, lifespan_Reduction_Cost_Valves[13].u) annotation (
        Line(points={{8.7,19},{4,19},{4,20},{20,20},{20,-160},{80,-160},{80,-50},
              {91.6,-50}},                                                                     color = {0, 0, 127}));
      connect(tabs_hotThrottle_valveSet[5].y, lifespan_Reduction_Cost_Valves[14].u) annotation (
        Line(points={{8.7,79},{2,79},{2,82},{20,82},{20,-160},{80,-160},{80,-50},
              {91.6,-50}},                                                                     color = {0, 0, 127}));
      connect(tabs_coldThrottle_valveSet[5].y, lifespan_Reduction_Cost_Valves[15].u) annotation (
        Line(points={{8.7,19},{4,19},{4,20},{20,20},{20,-160},{80,-160},{80,-50},
              {91.6,-50}},                                                                     color = {0, 0, 127}));
      connect(vu_heater_rpmSet[1].y, lifespan_Reduction_Cost_Pumps[21].u) annotation (
        Line(points={{6.7,-11},{20,-11},{20,160},{80,160},{80,50},{89.6,50}},                color = {0, 0, 127}));
      connect(vu_cooler_rpmSet[1].y, lifespan_Reduction_Cost_Pumps[22].u) annotation (
        Line(points={{6.7,-71},{20,-71},{20,160},{80,160},{80,50},{89.6,50}},                  color = {0, 0, 127}));
      connect(vu_heater_rpmSet[2].y, lifespan_Reduction_Cost_Pumps[23].u) annotation (
        Line(points={{6.7,-11},{20,-11},{20,160},{80,160},{80,50},{89.6,50}},                color = {0, 0, 127}));
      connect(vu_cooler_rpmSet[2].y, lifespan_Reduction_Cost_Pumps[24].u) annotation (
        Line(points={{6.7,-71},{20,-71},{20,160},{80,160},{80,50},{89.6,50}},                  color = {0, 0, 127}));
      connect(vu_heater_rpmSet[3].y, lifespan_Reduction_Cost_Pumps[25].u) annotation (
        Line(points={{6.7,-11},{20,-11},{20,160},{80,160},{80,50},{89.6,50}},                color = {0, 0, 127}));
      connect(vu_cooler_rpmSet[3].y, lifespan_Reduction_Cost_Pumps[26].u) annotation (
        Line(points={{6.7,-71},{20,-71},{20,160},{80,160},{80,50},{89.6,50}},                  color = {0, 0, 127}));
      connect(vu_heater_rpmSet[4].y, lifespan_Reduction_Cost_Pumps[27].u) annotation (
        Line(points={{6.7,-11},{20,-11},{20,160},{80,160},{80,50},{89.6,50}},                color = {0, 0, 127}));
      connect(vu_cooler_rpmSet[4].y, lifespan_Reduction_Cost_Pumps[28].u) annotation (
        Line(points={{6.7,-71},{20,-71},{20,160},{80,160},{80,50},{89.6,50}},                  color = {0, 0, 127}));
      connect(vu_heater_rpmSet[5].y, lifespan_Reduction_Cost_Pumps[29].u) annotation (
        Line(points={{6.7,-11},{20,-11},{20,160},{80,160},{80,50},{89.6,50}},                color = {0, 0, 127}));
      connect(vu_cooler_rpmSet[5].y, lifespan_Reduction_Cost_Pumps[30].u) annotation (
        Line(points={{6.7,-71},{20,-71},{20,160},{80,160},{80,50},{89.6,50}},                  color = {0, 0, 127}));
      connect(vu_heater_valveSet[1].y, lifespan_Reduction_Cost_Valves[16].u) annotation (
        Line(points={{6.7,-41},{12,-41},{12,-42},{20,-42},{20,-160},{80,-160},{
              80,-50},{91.6,-50}},                                                               color = {0, 0, 127}));
      connect(vu_cooler_valveSet[1].y, lifespan_Reduction_Cost_Valves[17].u) annotation (
        Line(points={{6.7,-99},{4,-99},{4,-100},{20,-100},{20,-160},{80,-160},{
              80,-50},{91.6,-50}},                                                                 color = {0, 0, 127}));
      connect(vu_heater_valveSet[2].y, lifespan_Reduction_Cost_Valves[18].u) annotation (
        Line(points={{6.7,-41},{12,-41},{12,-42},{20,-42},{20,-160},{80,-160},{
              80,-50},{91.6,-50}},                                                               color = {0, 0, 127}));
      connect(vu_cooler_valveSet[2].y, lifespan_Reduction_Cost_Valves[19].u) annotation (
        Line(points={{6.7,-99},{4,-99},{4,-100},{20,-100},{20,-160},{80,-160},{
              80,-50},{91.6,-50}},                                                                 color = {0, 0, 127}));
      connect(vu_heater_valveSet[3].y, lifespan_Reduction_Cost_Valves[20].u) annotation (
        Line(points={{6.7,-41},{12,-41},{12,-40},{20,-40},{20,-160},{80,-160},{
              80,-50},{91.6,-50}},                                                               color = {0, 0, 127}));
      connect(vu_cooler_valveSet[3].y, lifespan_Reduction_Cost_Valves[21].u) annotation (
        Line(points={{6.7,-99},{4,-99},{4,-100},{20,-100},{20,-160},{80,-160},{
              80,-50},{91.6,-50}},                                                                 color = {0, 0, 127}));
      connect(vu_heater_valveSet[4].y, lifespan_Reduction_Cost_Valves[22].u) annotation (
        Line(points={{6.7,-41},{10,-41},{10,-42},{20,-42},{20,-160},{80,-160},{
              80,-50},{91.6,-50}},                                                               color = {0, 0, 127}));
      connect(vu_cooler_valveSet[4].y, lifespan_Reduction_Cost_Valves[23].u) annotation (
        Line(points={{6.7,-99},{4,-99},{4,-100},{20,-100},{20,-160},{80,-160},{
              80,-50},{91.6,-50}},                                                                 color = {0, 0, 127}));
      connect(vu_heater_valveSet[5].y, lifespan_Reduction_Cost_Valves[24].u) annotation (
        Line(points={{6.7,-41},{10,-41},{10,-40},{20,-40},{20,-160},{80,-160},{
              80,-50},{91.6,-50}},                                                               color = {0, 0, 127}));
      connect(vu_cooler_valveSet[5].y, lifespan_Reduction_Cost_Valves[25].u) annotation (
        Line(points={{6.7,-99},{4,-99},{4,-100},{20,-100},{20,-160},{80,-160},{
              80,-50},{91.6,-50}},                                                                 color = {0, 0, 127}));
      connect(mainBus.hxBus.primBus.pumpBus.rpmSet, hx_prim_rpmSet.u) annotation (
        Line(points={{-99.95,6.05},{-100,6.05},{-100,-129},{-89.4,-129}},                            color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.ahuBus.preheaterBus.hydraulicBus.pumpBus.rpmSet, ahu_preheater_rpmSet.u) annotation (
        Line(points={{-99.95,6.05},{-99.95,84},{-100,84},{-100,5},{-47.4,5}},             color = {255, 204, 51}, thickness = 0.5));
      connect(ahu_preheater_rpmSet.y, lifespan_Reduction_Cost_Pumps[31].u) annotation (
        Line(points={{-31.3,5},{-28,5},{-28,6},{-20,6},{-20,160},{80,160},{80,
              50},{89.6,50}},                                         color = {0, 0, 127}));
      connect(ahu_heater_rpmSet.y, lifespan_Reduction_Cost_Pumps[32].u) annotation (
        Line(points={{-31.3,-55},{-20,-55},{-20,160},{80,160},{80,50},{89.6,50}},
                                                                    color = {0, 0, 127}));
      connect(ahu_cooler_rpmSet.y, lifespan_Reduction_Cost_Pumps[33].u) annotation (
        Line(points={{-33.3,-113},{-34,-113},{-34,-114},{-20,-114},{-20,160},{
              80,160},{80,50},{89.6,50}},                           color = {0, 0, 127}));
      connect(ahu_preheater_valveSet.y, lifespan_Reduction_Cost_Valves[26].u) annotation (
        Line(points={{-31.3,-25},{-32,-25},{-32,-26},{-20,-26},{-20,-160},{80,
              -160},{80,-50},{91.6,-50}},                                                     color = {0, 0, 127}));
      connect(ahu_heater_valveSet.y, lifespan_Reduction_Cost_Valves[27].u) annotation (
        Line(points={{-31.3,-83},{-32,-83},{-32,-86},{-20,-86},{-20,-160},{80,
              -160},{80,-50},{91.6,-50}},                             color = {0, 0, 127}));
      connect(ahu_cooler_valveSet.y, lifespan_Reduction_Cost_Valves[28].u) annotation (
        Line(points={{-33.3,-141},{-32,-141},{-32,-142},{-20,-142},{-20,-160},{
              80,-160},{80,-50},{91.6,-50}},                                              color = {0, 0, 127}));
      connect(hx_prim_rpmSet.y, lifespan_Reduction_Cost_Pumps[34].u) annotation (
        Line(points={{-73.3,-129},{-70,-129},{-70,-130},{-60,-130},{-60,160},{
              80,160},{80,50},{89.6,50}},                                                   color = {0, 0, 127}));
      connect(hx_sec_rpmSet.y, lifespan_Reduction_Cost_Pumps[35].u) annotation (
        Line(points={{-75.3,-71},{-60,-71},{-60,160},{80,160},{80,50},{89.6,50}},         color = {0, 0, 127}));
      connect(hx_prim_valveSet.y, lifespan_Reduction_Cost_Valves[29].u) annotation (
        Line(points={{-75.3,-39},{-70,-39},{-70,-40},{-60,-40},{-60,-160},{80,
              -160},{80,-50},{91.6,-50}},                                                     color = {0, 0, 127}));
      connect(hx_sec_valveSet.y, lifespan_Reduction_Cost_Valves[30].u) annotation (
        Line(points={{-75.3,-99},{-60,-99},{-60,-160},{80,-160},{80,-50},{91.6,
              -50}},                                                                          color = {0, 0, 127}));
      connect(swu_pump_rpmSet.y, lifespan_Reduction_Cost_Pumps[36].u) annotation (
        Line(points={{46.7,35},{48,35},{48,36},{60,36},{60,160},{80,160},{80,50},
              {89.6,50}},                                                               color = {0, 0, 127}));
      connect(swu_Y2valveSet.y, lifespan_Reduction_Cost_Valves[31].u) annotation (
        Line(points={{48.7,9},{58,9},{58,10},{60,10},{60,-160},{80,-160},{80,
              -50},{91.6,-50}},                                                                 color = {0, 0, 127}));
      connect(swu_Y3valveSet.y, lifespan_Reduction_Cost_Valves[32].u) annotation (
        Line(points={{46.7,-27},{46,-27},{46,-28},{60,-28},{60,-160},{80,-160},
              {80,-50},{91.6,-50}},                                                             color = {0, 0, 127}));
      connect(swu_K1valveSet.y, lifespan_Reduction_Cost_Valves[33].u) annotation (
        Line(points={{46.7,-57},{48,-57},{48,-52},{60,-52},{60,-158},{80,-158},
              {80,-50},{91.6,-50}},                                                             color = {0, 0, 127}));
      connect(swu_K2valveSet.y, lifespan_Reduction_Cost_Valves[34].u) annotation (
        Line(points={{44.7,-89},{54,-89},{54,-92},{60,-92},{60,-160},{80,-160},
              {80,-50},{91.6,-50}},                                                             color = {0, 0, 127}));
      connect(swu_K3valveSet.y, lifespan_Reduction_Cost_Valves[35].u) annotation (
        Line(points={{46.7,-117},{38,-117},{38,-114},{60,-114},{60,-160},{80,
              -160},{80,-50},{91.6,-50}},                                                         color = {0, 0, 127}));
      connect(swu_K4valveSet.y, lifespan_Reduction_Cost_Valves[36].u) annotation (
        Line(points={{46.7,-143},{40,-143},{40,-144},{60,-144},{60,-160},{80,
              -160},{80,-50},{91.6,-50}},                                                         color = {0, 0, 127}));
      connect(lifespan_Reduction_Cost_Pumps.y, multiSum1.u[1:36]) annotation (
        Line(points={{110,50},{120,50},{120,0},{126,0},{126,0.0972222},{130,
              0.0972222}},                                                    color = {0, 0, 127}));
      connect(lifespan_Reduction_Cost_Valves.y, multiSum1.u[37:72]) annotation (
        Line(points={{112,-50},{120,-50},{120,-8},{130,-8},{130,-6.90278}},                        color = {0, 0, 127}));
      connect(mainBus.tabs1Bus.pumpBus.pumpBus.rpmSet, tabs_pump_rpmSet[1].u) annotation (
        Line(points={{-99.95,6.05},{-99.95,84},{-100,84},{-100,160},{-20,160},{
              -20,140},{-14,140},{-14,139},{-9.4,139}},                                      color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.tabs1Bus.hotThrottleBus.pumpBus.rpmSet, tabs_hotThrottle_rpmSet[1].u) annotation (
        Line(points={{-99.95,6.05},{-99.95,84},{-100,84},{-100,160},{-20,160},{
              -20,112},{-14,112},{-14,111},{-7.4,111}},                                    color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.tabs1Bus.hotThrottleBus.valveSet, tabs_hotThrottle_valveSet[1].u) annotation (
        Line(points={{-99.95,6.05},{-100,6.05},{-100,160},{-20,160},{-20,80},{
              -14,80},{-14,79},{-7.4,79}},                                                             color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.tabs1Bus.coldThrottleBus.pumpBus.rpmSet, tabs_coldThrottle_rpmSet[1].u) annotation (
        Line(points={{-99.95,6.05},{-100,6.05},{-100,160},{-20,160},{-20,48},{
              -14,48},{-14,49},{-7.4,49}},                                                             color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.tabs1Bus.coldThrottleBus.valveSet, tabs_coldThrottle_valveSet[1].u) annotation (
        Line(points={{-99.95,6.05},{-100,6.05},{-100,160},{-20,160},{-20,18},{
              -14,18},{-14,19},{-7.4,19}},                                                             color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.tabs2Bus.pumpBus.pumpBus.rpmSet, tabs_pump_rpmSet[2].u) annotation (
        Line(points={{-99.95,6.05},{-99.95,84},{-100,84},{-100,160},{-20,160},{
              -20,140},{-14,140},{-14,139},{-9.4,139}},                                      color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.tabs2Bus.hotThrottleBus.pumpBus.rpmSet, tabs_hotThrottle_rpmSet[2].u) annotation (
        Line(points={{-99.95,6.05},{-99.95,84},{-100,84},{-100,160},{-20,160},{
              -20,112},{-14,112},{-14,111},{-7.4,111}},                                    color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.tabs2Bus.hotThrottleBus.valveSet, tabs_hotThrottle_valveSet[2].u) annotation (
        Line(points={{-99.95,6.05},{-100,6.05},{-100,160},{-20,160},{-20,80},{
              -14,80},{-14,79},{-7.4,79}},                                                             color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.tabs2Bus.coldThrottleBus.pumpBus.rpmSet, tabs_coldThrottle_rpmSet[2].u) annotation (
        Line(points={{-99.95,6.05},{-100,6.05},{-100,160},{-20,160},{-20,50},{
              -14,50},{-14,49},{-7.4,49}},                                                             color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.tabs2Bus.coldThrottleBus.valveSet, tabs_coldThrottle_valveSet[2].u) annotation (
        Line(points={{-99.95,6.05},{-100,6.05},{-100,160},{-20,160},{-20,18},{
              -14,18},{-14,19},{-7.4,19}},                                                             color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.tabs3Bus.pumpBus.pumpBus.rpmSet, tabs_pump_rpmSet[3].u) annotation (
        Line(points={{-99.95,6.05},{-99.95,84},{-100,84},{-100,160},{-20,160},{
              -20,140},{-14,140},{-14,139},{-9.4,139}},                                      color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.tabs3Bus.hotThrottleBus.pumpBus.rpmSet, tabs_hotThrottle_rpmSet[3].u) annotation (
        Line(points={{-99.95,6.05},{-99.95,84},{-100,84},{-100,160},{-20,160},{
              -20,112},{-14,112},{-14,111},{-7.4,111}},                                    color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.tabs3Bus.hotThrottleBus.valveSet, tabs_hotThrottle_valveSet[3].u) annotation (
        Line(points={{-99.95,6.05},{-100,6.05},{-100,160},{-20,160},{-20,80},{
              -14,80},{-14,79},{-7.4,79}},                                                             color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.tabs3Bus.coldThrottleBus.pumpBus.rpmSet, tabs_coldThrottle_rpmSet[3].u) annotation (
        Line(points={{-99.95,6.05},{-100,6.05},{-100,160},{-20,160},{-20,50},{
              -14,50},{-14,49},{-7.4,49}},                                                             color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.tabs3Bus.coldThrottleBus.valveSet, tabs_coldThrottle_valveSet[3].u) annotation (
        Line(points={{-99.95,6.05},{-100,6.05},{-100,160},{-20,160},{-20,18},{
              -14,18},{-14,19},{-7.4,19}},                                                             color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.tabs4Bus.pumpBus.pumpBus.rpmSet, tabs_pump_rpmSet[4].u) annotation (
        Line(points={{-99.95,6.05},{-99.95,84},{-100,84},{-100,160},{-20,160},{
              -20,140},{-14,140},{-14,139},{-9.4,139}},                                      color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.tabs4Bus.hotThrottleBus.pumpBus.rpmSet, tabs_hotThrottle_rpmSet[4].u) annotation (
        Line(points={{-99.95,6.05},{-99.95,84},{-100,84},{-100,160},{-20,160},{
              -20,112},{-14,112},{-14,111},{-7.4,111}},                                    color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.tabs4Bus.hotThrottleBus.valveSet, tabs_hotThrottle_valveSet[4].u) annotation (
        Line(points={{-99.95,6.05},{-100,6.05},{-100,160},{-20,160},{-20,80},{
              -14,80},{-14,79},{-7.4,79}},                                                             color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.tabs4Bus.coldThrottleBus.pumpBus.rpmSet, tabs_coldThrottle_rpmSet[4].u) annotation (
        Line(points={{-99.95,6.05},{-100,6.05},{-100,160},{-20,160},{-20,50},{
              -14,50},{-14,49},{-7.4,49}},                                                             color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.tabs4Bus.coldThrottleBus.valveSet, tabs_coldThrottle_valveSet[4].u) annotation (
        Line(points={{-99.95,6.05},{-100,6.05},{-100,160},{-20,160},{-20,18},{
              -14,18},{-14,19},{-7.4,19}},                                                             color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.tabs5Bus.pumpBus.pumpBus.rpmSet, tabs_pump_rpmSet[5].u) annotation (
        Line(points={{-99.95,6.05},{-99.95,84},{-100,84},{-100,160},{-20,160},{
              -20,140},{-14,140},{-14,139},{-9.4,139}},                                      color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.tabs5Bus.hotThrottleBus.pumpBus.rpmSet, tabs_hotThrottle_rpmSet[5].u) annotation (
        Line(points={{-99.95,6.05},{-99.95,84},{-100,84},{-100,160},{-20,160},{
              -20,112},{-14,112},{-14,111},{-7.4,111}},                                    color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.tabs5Bus.hotThrottleBus.valveSet, tabs_hotThrottle_valveSet[5].u) annotation (
        Line(points={{-99.95,6.05},{-100,6.05},{-100,160},{-20,160},{-20,80},{
              -14,80},{-14,79},{-7.4,79}},                                                             color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.tabs5Bus.coldThrottleBus.pumpBus.rpmSet, tabs_coldThrottle_rpmSet[5].u) annotation (
        Line(points={{-99.95,6.05},{-100,6.05},{-100,160},{-20,160},{-20,48},{
              -14,48},{-14,49},{-7.4,49}},                                                             color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.tabs5Bus.coldThrottleBus.valveSet, tabs_coldThrottle_valveSet[5].u) annotation (
        Line(points={{-99.95,6.05},{-100,6.05},{-100,160},{-20,160},{-20,18},{
              -14,18},{-14,19},{-7.4,19}},                                                             color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.vu1Bus.heaterBus.hydraulicBus.pumpBus.rpmSet, vu_heater_rpmSet[1].u) annotation (
        Line(points={{-99.95,6.05},{-99.95,-76},{-100,-76},{-100,-160},{-20,
              -160},{-20,-12},{-14,-12},{-14,-11},{-9.4,-11}},                                 color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.vu1Bus.heaterBus.hydraulicBus.valveSet, vu_heater_valveSet[1].u) annotation (
        Line(points={{-99.95,6.05},{-100,6.05},{-100,-160},{-20,-160},{-20,-40},
              {-14,-40},{-14,-41},{-9.4,-41}},                                                             color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.vu1Bus.coolerBus.hydraulicBus.pumpBus.rpmSet, vu_cooler_rpmSet[1].u) annotation (
        Line(points={{-99.95,6.05},{-100,6.05},{-100,-160},{-20,-160},{-20,-72},
              {-14,-72},{-14,-71},{-9.4,-71}},                                                               color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.vu1Bus.coolerBus.hydraulicBus.valveSet, vu_cooler_valveSet[1].u) annotation (
        Line(points={{-99.95,6.05},{-99.95,-76},{-100,-76},{-100,-160},{-20,
              -160},{-20,-100},{-14,-100},{-14,-99},{-9.4,-99}},                                 color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.vu2Bus.heaterBus.hydraulicBus.pumpBus.rpmSet, vu_heater_rpmSet[2].u) annotation (
        Line(points={{-99.95,6.05},{-99.95,-78},{-100,-78},{-100,-160},{-20,
              -160},{-20,-14},{-14,-14},{-14,-11},{-9.4,-11}},                                 color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.vu2Bus.heaterBus.hydraulicBus.valveSet, vu_heater_valveSet[2].u) annotation (
        Line(points={{-99.95,6.05},{-100,6.05},{-100,-160},{-20,-160},{-20,-42},
              {-14,-42},{-14,-41},{-9.4,-41}},                                                             color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.vu2Bus.coolerBus.hydraulicBus.pumpBus.rpmSet, vu_cooler_rpmSet[2].u) annotation (
        Line(points={{-99.95,6.05},{-100,6.05},{-100,-160},{-20,-160},{-20,-72},
              {-24,-72},{-24,-71},{-9.4,-71}},                                                               color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.vu2Bus.coolerBus.hydraulicBus.valveSet, vu_cooler_valveSet[2].u) annotation (
        Line(points={{-99.95,6.05},{-99.95,-76},{-100,-76},{-100,-160},{-20,
              -160},{-20,-98},{-14,-98},{-14,-99},{-9.4,-99}},                                   color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.vu3Bus.heaterBus.hydraulicBus.pumpBus.rpmSet, vu_heater_rpmSet[3].u) annotation (
        Line(points={{-99.95,6.05},{-99.95,-76},{-100,-76},{-100,-160},{-20,
              -160},{-20,-12},{-14,-12},{-14,-11},{-9.4,-11}},                                 color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.vu3Bus.heaterBus.hydraulicBus.valveSet, vu_heater_valveSet[3].u) annotation (
        Line(points={{-99.95,6.05},{-100,6.05},{-100,-160},{-20,-160},{-20,-42},
              {-14,-42},{-14,-41},{-9.4,-41}},                                                             color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.vu3Bus.coolerBus.hydraulicBus.pumpBus.rpmSet, vu_cooler_rpmSet[3].u) annotation (
        Line(points={{-99.95,6.05},{-100,6.05},{-100,-160},{-20,-160},{-20,-72},
              {-14,-72},{-14,-71},{-9.4,-71}},                                                               color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.vu3Bus.coolerBus.hydraulicBus.valveSet, vu_cooler_valveSet[3].u) annotation (
        Line(points={{-99.95,6.05},{-99.95,-76},{-100,-76},{-100,-160},{-20,
              -160},{-20,-100},{-14,-100},{-14,-99},{-9.4,-99}},                                 color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.vu4Bus.heaterBus.hydraulicBus.pumpBus.rpmSet, vu_heater_rpmSet[4].u) annotation (
        Line(points={{-99.95,6.05},{-99.95,-76},{-100,-76},{-100,-160},{-20,
              -160},{-20,-12},{-14,-12},{-14,-11},{-9.4,-11}},                                 color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.vu4Bus.heaterBus.hydraulicBus.valveSet, vu_heater_valveSet[4].u) annotation (
        Line(points={{-99.95,6.05},{-100,6.05},{-100,-160},{-20,-160},{-20,-42},
              {-14,-42},{-14,-41},{-9.4,-41}},                                                             color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.vu4Bus.coolerBus.hydraulicBus.pumpBus.rpmSet, vu_cooler_rpmSet[4].u) annotation (
        Line(points={{-99.95,6.05},{-100,6.05},{-100,-160},{-20,-160},{-20,-72},
              {-14,-72},{-14,-71},{-9.4,-71}},                                                               color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.vu4Bus.coolerBus.hydraulicBus.valveSet, vu_cooler_valveSet[4].u) annotation (
        Line(points={{-99.95,6.05},{-99.95,-76},{-100,-76},{-100,-160},{-20,
              -160},{-20,-98},{-14,-98},{-14,-99},{-9.4,-99}},                                   color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.vu5Bus.heaterBus.hydraulicBus.pumpBus.rpmSet, vu_heater_rpmSet[5].u) annotation (
        Line(points={{-99.95,6.05},{-99.95,-76},{-100,-76},{-100,-160},{-20,
              -160},{-20,-12},{-14,-12},{-14,-11},{-9.4,-11}},                                 color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.vu5Bus.heaterBus.hydraulicBus.valveSet, vu_heater_valveSet[5].u) annotation (
        Line(points={{-99.95,6.05},{-100,6.05},{-100,-160},{-20,-160},{-20,-42},
              {-14,-42},{-14,-41},{-9.4,-41}},                                                             color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.vu5Bus.coolerBus.hydraulicBus.pumpBus.rpmSet, vu_cooler_rpmSet[5].u) annotation (
        Line(points={{-99.95,6.05},{-100,6.05},{-100,-160},{-20,-160},{-20,-72},
              {-14,-72},{-14,-71},{-9.4,-71}},                                                               color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.vu5Bus.coolerBus.hydraulicBus.valveSet, vu_cooler_valveSet[5].u) annotation (
        Line(points={{-99.95,6.05},{-99.95,-76},{-100,-76},{-100,-160},{-20,
              -160},{-20,-100},{-14,-100},{-14,-99},{-9.4,-99}},                                 color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.hxBus.primBus.valveSet, hx_prim_valveSet.u) annotation (
        Line(points={{-99.95,6.05},{-100,6.05},{-100,-40},{-96,-40},{-96,-39},{-91.4,
              -39}},                                                                               color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.hxBus.secBus.pumpBus.rpmSet, hx_sec_rpmSet.u) annotation (
        Line(points={{-99.95,6.05},{-100,6.05},{-100,-71},{-91.4,-71}},                            color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.hxBus.secBus.valveSet, hx_sec_valveSet.u) annotation (
        Line(points={{-99.95,6.05},{-100,6.05},{-100,-100},{-91.4,-100},{-91.4,-99}},                         color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.ahuBus.preheaterBus.hydraulicBus.valveSet, ahu_preheater_valveSet.u) annotation (
        Line(points={{-99.95,6.05},{-100,6.05},{-100,-26},{-82,-26},{-82,-25},{
              -47.4,-25}},                                                                            color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.ahuBus.heaterBus.hydraulicBus.pumpBus.rpmSet, ahu_heater_rpmSet.u) annotation (
        Line(points={{-99.95,6.05},{-100,6.05},{-100,-52},{-47.4,-52},{-47.4,
              -55}},                                                                                            color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.ahuBus.heaterBus.hydraulicBus.valveSet, ahu_heater_valveSet.u) annotation (
        Line(points={{-99.95,6.05},{-100,6.05},{-100,-83},{-47.4,-83}},                             color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.ahuBus.coolerBus.hydraulicBus.pumpBus.rpmSet, ahu_cooler_rpmSet.u) annotation (
        Line(points={{-99.95,6.05},{-100,6.05},{-100,-114},{-86,-114},{-86,-113},
              {-49.4,-113}},                                                                        color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.ahuBus.coolerBus.hydraulicBus.valveSet, ahu_cooler_valveSet.u) annotation (
        Line(points={{-99.95,6.05},{-100,6.05},{-100,-140},{-80,-140},{-80,-141},
              {-49.4,-141}},                                                                        color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.swuBus.Y2valSet, swu_Y2valveSet.u) annotation (
        Line(points={{-99.95,6.05},{-100,6.05},{-100,-160},{20,-160},{20,10},{
              26,10},{26,9},{32.6,9}},                                                                 color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.swuBus.Y3valSet, swu_Y3valveSet.u) annotation (
        Line(points={{-99.95,6.05},{-100,6.05},{-100,-160},{20,-160},{20,-28},{
              28,-28},{28,-27},{30.6,-27}},                                                            color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.swuBus.K1valSet, swu_K1valveSet.u) annotation (
        Line(points={{-99.95,6.05},{-100,6.05},{-100,-160},{20,-160},{20,-56},{
              26,-56},{26,-57},{30.6,-57}},                                                            color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.swuBus.K2valSet, swu_K2valveSet.u) annotation (
        Line(points={{-99.95,6.05},{-100,6.05},{-100,-160},{20,-160},{20,-90},{
              28.6,-90},{28.6,-89}},                                                                               color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.swuBus.K3valSet, swu_K3valveSet.u) annotation (
        Line(points={{-99.95,6.05},{-100,6.05},{-100,-160},{20,-160},{20,-116},
              {22,-116},{22,-118},{26,-118},{26,-117},{30.6,-117}},                                      color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.swuBus.K4valSet, swu_K4valveSet.u) annotation (
        Line(points={{-99.95,6.05},{-100,6.05},{-100,-160},{20,-160},{20,-142},
              {24,-142},{24,-143},{30.6,-143}},                                                          color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.swuBus.pumpBus.rpmSet, swu_pump_rpmSet.u) annotation (
          Line(
          points={{-99.95,6.05},{-99.95,-160},{20,-160},{20,35},{30.6,35}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio = false, extent={{-100,-160},{160,
                160}}),                                                                          graphics={  Rectangle(extent = {{-100, 150}, {150, -152}}, lineColor = {0, 0, 0}, fillColor = {215, 215, 215},
                fillPattern =                                                                                                                                                                                                 FillPattern.Solid), Text(extent = {{-38, 36}, {90, -34}}, lineColor = {95, 95, 95}, fillColor = {215, 215, 215},
                fillPattern =                                                                                                                                                                                                        FillPattern.Solid, textString = "Lifespan
Reduction
Costs")}),
        Diagram(coordinateSystem(preserveAspectRatio = false, extent={{-100,-160},{160,
                160}})),
        Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -150}, {150, 150}}, initialScale = 0.1), graphics = {Rectangle(fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, extent = {{-100, 150}, {150, -152}}), Text(lineColor = {95, 95, 95}, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, extent = {{-38, 36}, {90, -34}}, textString = "Lifespan
Reduction
Costs")}),
        Diagram(coordinateSystem(preserveAspectRatio = false)),
        Documentation(info = "<html><head></head><body>calculation costs as part of the operational costs of the CCCS evaulation method caused by reduced lifespan of components due to wear during operation</body></html>"));
    end LifespanReductionCosts;

    model InvestmentCostsStrategy
      "calculating the investement costs to evaluate the performance of control strategies according to CCCS evaluation method"
      parameter Real G = 50000 "Average salary of employee per annum [€]";
      Real E "effort to implement control strategy in months";
      parameter Real EAF = 1.00 "effort adjustment factor";
      parameter Real KLOC = 10 "approximate number of lines of code in thousands [-]";
      Real K_Strat;
      // costs for implementing control strategy
      Modelica.Blocks.Interfaces.RealOutput kStrat annotation (
        Placement(visible = true, transformation(origin = {102, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {102, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      E = 2.8 * KLOC ^ 1.2 * EAF;
      //Investment costs for implementing control strategy
      K_Strat = E * G / 12;
      kStrat = K_Strat;
      annotation (
        Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics={  Rectangle(fillColor = {215, 215, 215},
                fillPattern =                                                                                                                    FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(lineColor=
                  {95,95,95},                                                                                                                                                                                                        fillColor=
                  {215,215,215},
                fillPattern=FillPattern.Solid,                                                                                                                                                                                                        extent={{
                  -68,42},{66,-42}},
              textString="Investment
Strategy")}),
        Diagram(coordinateSystem(preserveAspectRatio = false)),
        Documentation(info = "<html><head></head><body><h4>calculating the investement for implementing a new control strategy as part of the investment costs to evaluate the performance of control strategies according to CCCS evaluation method</h4></body></html>"));
    end InvestmentCostsStrategy;

    model PerformanceReductionCosts
      "calculating the costs due to reduced performance of employees caused by reduced air quality as part of the operational costs to evaluate the performance of a control strategy according to CCCS evaluation method"
      Modelica.Blocks.Sources.Constant Tset(k = TSet) annotation (
        Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant Tset_workshop(k = TSetWorkshop) annotation (
        Placement(visible = true, transformation(origin = {-90, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.MultiSum multiSum1(k = {1, 1, 1, 1, 1}, nu = 5) annotation (
        Placement(visible = true, transformation(origin = {0, -90}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Interfaces.RealOutput PRC annotation (
        Placement(visible = true, transformation(origin = {110, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Feedback feedback1[15] annotation (
        Placement(visible = true, transformation(origin = {0, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Sources.Constant const(k = 1) annotation (
        Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Math.Feedback feedback2[5] annotation (
        Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Sources.Constant salary_per_annum(k=sal*sim_time/(365*24*
            3600))                                               annotation (
        Placement(visible = true, transformation(origin = {90, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Sources.Constant productivity_factor(k = prodFac) annotation (
        Placement(visible = true, transformation(origin = {90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Sources.Constant const1(k = 1 / (233 * 8 * 60)) annotation (
        Placement(visible = true, transformation(origin = {90, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Continuous.Integrator integrator1[5](k = {1, 1, 1, 1, 1}, each use_reset = true) annotation (
        Placement(visible = true, transformation(origin = {0, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      parameter Real prodFac = 1.2 "productivity factor [-]";
      parameter Real sal = 50000 "average salary of employee per annum [€]";
      parameter Real TSet = 293.14 "set room temperature [K]";
      parameter Real TSetWorkshop = 288.15 "set room temperature for workshop [K]";
      parameter Real sim_time;
      Modelica.Blocks.Sources.BooleanExpression booleanExpression[5](each y = true) annotation (
        Placement(visible = true, transformation(extent = {{-100, -50}, {-80, -30}}, rotation = 0)));
      Modelica.Blocks.Math.MultiProduct multiProduct[5](each nu = 4) annotation (
        Placement(visible = true, transformation(origin = {0, -66}, extent = {{-6, -6}, {6, 6}}, rotation = 270)));
      AixLib.Systems.Benchmark_fb.CCCS.BaseClasses.LRM_Temp lRM_Temp[5] annotation (
        Placement(visible = true, transformation(extent = {{-40, 60}, {-20, 80}}, rotation = 0)));
      Benchmark.BaseClasses.MainBus mainBus annotation (
        Placement(transformation(extent = {{-112, -10}, {-92, 10}})));
      AixLib.Systems.Benchmark_fb.CCCS.BaseClasses.LRM_VOC lrm_voc1[5] annotation (
        Placement(visible = true, transformation(origin = {0, 88}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      AixLib.Systems.Benchmark_fb.CCCS.BaseClasses.LRM_CO2 lrm_co21[5] annotation (
        Placement(visible = true, transformation(origin = {30, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Math.MultiProduct multiProduct1[5](each nu = 3) annotation (
        Placement(visible = true, transformation(origin = {0, 28}, extent = {{-8, -8}, {8, 8}}, rotation = -90)));
    equation
      connect(booleanExpression[1].y, integrator1[1].reset) annotation (
        Line(points = {{-79, -40}, {-40.5, -40}, {-40.5, -36}, {-12, -36}}, color = {255, 0, 255}));
      connect(booleanExpression[2].y, integrator1[2].reset) annotation (
        Line(points = {{-79, -40}, {-40.5, -40}, {-40.5, -36}, {-12, -36}}, color = {255, 0, 255}));
      connect(booleanExpression[3].y, integrator1[3].reset) annotation (
        Line(points = {{-79, -40}, {-40.5, -40}, {-40.5, -36}, {-12, -36}}, color = {255, 0, 255}));
      connect(booleanExpression[4].y, integrator1[4].reset) annotation (
        Line(points = {{-79, -40}, {-40.5, -40}, {-40.5, -36}, {-12, -36}}, color = {255, 0, 255}));
      connect(booleanExpression[5].y, integrator1[5].reset) annotation (
        Line(points = {{-79, -40}, {-40.5, -40}, {-40.5, -36}, {-12, -36}}, color = {255, 0, 255}));
      connect(multiProduct1[1].y, feedback2[1].u2) annotation (
        Line(points = {{0, 18.64}, {0, 8}}, color = {0, 0, 127}, thickness = 0.5));
      connect(multiProduct1[2].y, feedback2[2].u2) annotation (
        Line(points = {{0, 18.64}, {0, 8}}, color = {0, 0, 127}, thickness = 0.5));
      connect(multiProduct1[3].y, feedback2[3].u2) annotation (
        Line(points = {{0, 18.64}, {0, 8}}, color = {0, 0, 127}, thickness = 0.5));
      connect(multiProduct1[4].y, feedback2[4].u2) annotation (
        Line(points = {{0, 18.64}, {0, 8}}, color = {0, 0, 127}, thickness = 0.5));
      connect(multiProduct1[5].y, feedback2[5].u2) annotation (
        Line(points = {{0, 18.64}, {0, 8}}, color = {0, 0, 127}, thickness = 0.5));
      connect(feedback1[1].y, multiProduct1[1].u[1]) annotation (
        Line(points = {{-9, 50}, {-20, 50}, {-20, 44}, {3.73333, 44}, {3.73333, 36}}, color = {0, 0, 127}, thickness = 0.5));
      connect(feedback1[2].y, multiProduct1[1].u[2]) annotation (
        Line(points = {{-9, 50}, {-20, 50}, {-20, 44}, {0, 44}, {0, 36}}, color = {0, 0, 127}, thickness = 0.5));
      connect(feedback1[3].y, multiProduct1[1].u[3]) annotation (
        Line(points = {{-9, 50}, {-20, 50}, {-20, 44}, {-3.73333, 44}, {-3.73333, 36}}, color = {0, 0, 127}, thickness = 0.5));
      connect(feedback1[13].y, multiProduct1[5].u[1]) annotation (
        Line(points = {{-9, 50}, {-20, 50}, {-20, 44}, {3.73333, 44}, {3.73333, 36}}, color = {0, 0, 127}, thickness = 0.5));
      connect(feedback1[14].y, multiProduct1[5].u[2]) annotation (
        Line(points = {{-9, 50}, {-20, 50}, {-20, 44}, {0, 44}, {0, 36}}, color = {0, 0, 127}, thickness = 0.5));
      connect(feedback1[15].y, multiProduct1[5].u[3]) annotation (
        Line(points = {{-9, 50}, {-20, 50}, {-20, 44}, {-3.73333, 44}, {-3.73333, 36}}, color = {0, 0, 127}, thickness = 0.5));
      connect(feedback1[10].y, multiProduct1[4].u[1]) annotation (
        Line(points = {{-9, 50}, {-20, 50}, {-20, 44}, {3.73333, 44}, {3.73333, 36}}, color = {0, 0, 127}, thickness = 0.5));
      connect(feedback1[11].y, multiProduct1[4].u[2]) annotation (
        Line(points = {{-9, 50}, {-20, 50}, {-20, 44}, {0, 44}, {0, 36}}, color = {0, 0, 127}, thickness = 0.5));
      connect(feedback1[12].y, multiProduct1[4].u[3]) annotation (
        Line(points = {{-9, 50}, {-20, 50}, {-20, 44}, {-3.73333, 44}, {-3.73333, 36}}, color = {0, 0, 127}, thickness = 0.5));
      connect(feedback1[7].y, multiProduct1[3].u[1]) annotation (
        Line(points = {{-9, 50}, {-20, 50}, {-20, 44}, {3.73333, 44}, {3.73333, 36}}, color = {0, 0, 127}, thickness = 0.5));
      connect(feedback1[8].y, multiProduct1[3].u[2]) annotation (
        Line(points = {{-9, 50}, {-20, 50}, {-20, 44}, {0, 44}, {0, 36}}, color = {0, 0, 127}, thickness = 0.5));
      connect(feedback1[9].y, multiProduct1[3].u[3]) annotation (
        Line(points = {{-9, 50}, {-20, 50}, {-20, 44}, {-3.73333, 44}, {-3.73333, 36}}, color = {0, 0, 127}, thickness = 0.5));
      connect(feedback1[4].y, multiProduct1[2].u[1]) annotation (
        Line(points = {{-9, 50}, {-20, 50}, {-20, 44}, {3.73333, 44}, {3.73333, 36}}, color = {0, 0, 127}, thickness = 0.5));
      connect(feedback1[5].y, multiProduct1[2].u[2]) annotation (
        Line(points = {{-9, 50}, {-20, 50}, {-20, 44}, {0, 44}, {0, 36}}, color = {0, 0, 127}, thickness = 0.5));
      connect(feedback1[6].y, multiProduct1[2].u[3]) annotation (
        Line(points = {{-9, 50}, {-20, 50}, {-20, 44}, {-3.73333, 44}, {-3.73333, 36}}, color = {0, 0, 127}, thickness = 0.5));
      connect(const.y, feedback1[1].u1) annotation (
        Line(points = {{79, 90}, {60, 90}, {60, 50}, {8, 50}}, color = {0, 0, 127}));
      connect(const.y, feedback1[2].u1) annotation (
        Line(points = {{79, 90}, {60, 90}, {60, 50}, {8, 50}}, color = {0, 0, 127}));
      connect(const.y, feedback1[3].u1) annotation (
        Line(points = {{79, 90}, {60, 90}, {60, 50}, {8, 50}}, color = {0, 0, 127}));
      connect(const.y, feedback1[4].u1) annotation (
        Line(points = {{79, 90}, {60, 90}, {60, 50}, {8, 50}}, color = {0, 0, 127}));
      connect(const.y, feedback1[5].u1) annotation (
        Line(points = {{79, 90}, {60, 90}, {60, 50}, {8, 50}}, color = {0, 0, 127}));
      connect(const.y, feedback1[6].u1) annotation (
        Line(points = {{79, 90}, {60, 90}, {60, 50}, {8, 50}}, color = {0, 0, 127}));
      connect(const.y, feedback1[7].u1) annotation (
        Line(points = {{79, 90}, {60, 90}, {60, 50}, {8, 50}}, color = {0, 0, 127}));
      connect(const.y, feedback1[8].u1) annotation (
        Line(points = {{79, 90}, {60, 90}, {60, 50}, {8, 50}}, color = {0, 0, 127}));
      connect(const.y, feedback1[9].u1) annotation (
        Line(points = {{79, 90}, {60, 90}, {60, 50}, {8, 50}}, color = {0, 0, 127}));
      connect(const.y, feedback1[10].u1) annotation (
        Line(points = {{79, 90}, {60, 90}, {60, 50}, {8, 50}}, color = {0, 0, 127}));
      connect(const.y, feedback1[11].u1) annotation (
        Line(points = {{79, 90}, {60, 90}, {60, 50}, {8, 50}}, color = {0, 0, 127}));
      connect(const.y, feedback1[12].u1) annotation (
        Line(points = {{79, 90}, {60, 90}, {60, 50}, {8, 50}}, color = {0, 0, 127}));
      connect(const.y, feedback1[13].u1) annotation (
        Line(points = {{79, 90}, {60, 90}, {60, 50}, {8, 50}}, color = {0, 0, 127}));
      connect(const.y, feedback1[14].u1) annotation (
        Line(points = {{79, 90}, {60, 90}, {60, 50}, {8, 50}}, color = {0, 0, 127}));
      connect(const.y, feedback1[15].u1) annotation (
        Line(points = {{79, 90}, {60, 90}, {60, 50}, {8, 50}}, color = {0, 0, 127}));
      connect(lRM_Temp[1].y, feedback1[1].u2) annotation (
        Line(points = {{-19.2, 70}, {0, 70}, {0, 58}}, color = {0, 0, 127}, thickness = 0.5));
      connect(lrm_voc1[1].y, feedback1[2].u2) annotation (
        Line(points = {{0, 77.4}, {0, 58}}, color = {0, 0, 127}, thickness = 0.5));
      connect(lrm_co21[1].y, feedback1[3].u2) annotation (
        Line(points = {{19.8, 70}, {0, 70}, {0, 58}}, color = {0, 0, 127}, thickness = 0.5));
      connect(lRM_Temp[5].y, feedback1[13].u2) annotation (
        Line(points = {{-19.2, 70}, {0, 70}, {0, 58}}, color = {0, 0, 127}, thickness = 0.5));
      connect(lrm_voc1[5].y, feedback1[14].u2) annotation (
        Line(points = {{0, 77.4}, {0, 58}}, color = {0, 0, 127}, thickness = 0.5));
      connect(lrm_co21[5].y, feedback1[15].u2) annotation (
        Line(points = {{19.8, 70}, {0, 70}, {0, 58}}, color = {0, 0, 127}, thickness = 0.5));
      connect(lRM_Temp[4].y, feedback1[10].u2) annotation (
        Line(points = {{-19.2, 70}, {0, 70}, {0, 58}}, color = {0, 0, 127}, thickness = 0.5));
      connect(lrm_voc1[4].y, feedback1[11].u2) annotation (
        Line(points = {{0, 77.4}, {0, 58}}, color = {0, 0, 127}, thickness = 0.5));
      connect(lrm_co21[4].y, feedback1[12].u2) annotation (
        Line(points = {{19.8, 70}, {0, 70}, {0, 58}}, color = {0, 0, 127}, thickness = 0.5));
      connect(lRM_Temp[3].y, feedback1[7].u2) annotation (
        Line(points = {{-19.2, 70}, {0, 70}, {0, 58}}, color = {0, 0, 127}, thickness = 0.5));
      connect(lrm_voc1[3].y, feedback1[8].u2) annotation (
        Line(points = {{0, 77.4}, {0, 58}}, color = {0, 0, 127}, thickness = 0.5));
      connect(lrm_co21[3].y, feedback1[9].u2) annotation (
        Line(points = {{19.8, 70}, {0, 70}, {0, 58}}, color = {0, 0, 127}, thickness = 0.5));
      connect(lRM_Temp[2].y, feedback1[4].u2) annotation (
        Line(points = {{-19.2, 70}, {0, 70}, {0, 58}}, color = {0, 0, 127}, thickness = 0.5));
      connect(lrm_voc1[2].y, feedback1[5].u2) annotation (
        Line(points = {{0, 77.4}, {0, 58}}, color = {0, 0, 127}, thickness = 0.5));
      connect(lrm_co21[2].y, feedback1[6].u2) annotation (
        Line(points = {{19.8, 70}, {0, 70}, {0, 58}}, color = {0, 0, 127}, thickness = 0.5));
      connect(productivity_factor.y, multiProduct[5].u[3]) annotation (
        Line(points = {{79, 0}, {60, 0}, {60, -60}, {-1.05, -60}}, color = {0, 0, 127}));
      connect(productivity_factor.y, multiProduct[4].u[3]) annotation (
        Line(points = {{79, 0}, {60, 0}, {60, -60}, {-1.05, -60}}, color = {0, 0, 127}));
      connect(productivity_factor.y, multiProduct[3].u[3]) annotation (
        Line(points = {{79, 0}, {60, 0}, {60, -60}, {-1.05, -60}}, color = {0, 0, 127}));
      connect(productivity_factor.y, multiProduct[2].u[3]) annotation (
        Line(points = {{79, 0}, {60, 0}, {60, -60}, {-1.05, -60}}, color = {0, 0, 127}));
      connect(productivity_factor.y, multiProduct[1].u[3]) annotation (
        Line(points = {{79, 0}, {60, 0}, {60, -60}, {-1.05, -60}}, color = {0, 0, 127}));
      connect(const1.y, multiProduct[5].u[4]) annotation (
        Line(points = {{79, -60}, {-3.15, -60}}, color = {0, 0, 127}));
      connect(const1.y, multiProduct[4].u[4]) annotation (
        Line(points = {{79, -60}, {-3.15, -60}}, color = {0, 0, 127}));
      connect(const1.y, multiProduct[3].u[4]) annotation (
        Line(points = {{79, -60}, {-3.15, -60}}, color = {0, 0, 127}));
      connect(const1.y, multiProduct[2].u[4]) annotation (
        Line(points = {{79, -60}, {-3.15, -60}}, color = {0, 0, 127}));
      connect(const1.y, multiProduct[1].u[4]) annotation (
        Line);
      connect(feedback2[1].y, integrator1[1].u) annotation (
        Line(points = {{-9, 0}, {-26, 0}, {-26, -18}, {0, -18}}, color = {0, 0, 127}));
      connect(feedback2[2].y, integrator1[2].u) annotation (
        Line(points = {{-9, 0}, {-26, 0}, {-26, -18}, {0, -18}}, color = {0, 0, 127}));
      connect(feedback2[3].y, integrator1[3].u) annotation (
        Line(points = {{-9, 0}, {-26, 0}, {-26, -18}, {0, -18}}, color = {0, 0, 127}));
      connect(feedback2[4].y, integrator1[4].u) annotation (
        Line(points = {{-9, 0}, {-26, 0}, {-26, -18}, {0, -18}}, color = {0, 0, 127}));
      connect(feedback2[5].y, integrator1[5].u) annotation (
        Line(points = {{-9, 0}, {-26, 0}, {-26, -18}, {0, -18}}, color = {0, 0, 127}));
      connect(const.y, feedback2[1].u1) annotation (
        Line(points = {{79, 90}, {60, 90}, {60, 0}, {8, 0}}, color = {0, 0, 127}));
      connect(const.y, feedback2[2].u1) annotation (
        Line(points = {{79, 90}, {60, 90}, {60, 0}, {8, 0}}, color = {0, 0, 127}));
      connect(const.y, feedback2[3].u1) annotation (
        Line(points = {{79, 90}, {60, 90}, {60, 0}, {8, 0}}, color = {0, 0, 127}));
      connect(const.y, feedback2[4].u1) annotation (
        Line(points = {{79, 90}, {60, 90}, {60, 0}, {8, 0}}, color = {0, 0, 127}));
      connect(const.y, feedback2[5].u1) annotation (
        Line(points = {{79, 90}, {60, 90}, {60, 0}, {8, 0}}, color = {0, 0, 127}));
      connect(integrator1[1].y, multiProduct[1].u[1]) annotation (
        Line(points = {{0, -41}, {0, -48}, {-4, -48}, {-4, -60}, {3.15, -60}}, color = {0, 0, 127}));
      connect(integrator1[2].y, multiProduct[2].u[1]) annotation (
        Line(points = {{0, -41}, {0, -48}, {-4, -48}, {-4, -60}, {3.15, -60}}, color = {0, 0, 127}));
      connect(integrator1[3].y, multiProduct[3].u[1]) annotation (
        Line(points = {{0, -41}, {0, -48}, {-4, -48}, {-4, -60}, {3.15, -60}}, color = {0, 0, 127}));
      connect(integrator1[4].y, multiProduct[4].u[1]) annotation (
        Line(points = {{0, -41}, {0, -48}, {-4, -48}, {-4, -60}, {3.15, -60}}, color = {0, 0, 127}));
      connect(integrator1[5].y, multiProduct[5].u[1]) annotation (
        Line(points = {{0, -41}, {0, -48}, {-4, -48}, {-4, -60}, {3.15, -60}}, color = {0, 0, 127}));
      connect(multiProduct[5].y, multiSum1.u[5]) annotation (
        Line(points = {{0, -73.02}, {0, -76}, {0, -80}, {-5.6, -80}}, color = {0, 0, 127}));
      connect(multiProduct[4].y, multiSum1.u[4]) annotation (
        Line(points = {{0, -73.02}, {0, -76}, {0, -80}, {-2.8, -80}}, color = {0, 0, 127}));
      connect(multiProduct[3].y, multiSum1.u[3]) annotation (
        Line(points = {{0, -73.02}, {0, -80}}, color = {0, 0, 127}));
      connect(multiProduct[2].y, multiSum1.u[2]) annotation (
        Line(points = {{0, -73.02}, {0, -76}, {0, -80}, {2.8, -80}}, color = {0, 0, 127}));
      connect(multiProduct[1].y, multiSum1.u[1]) annotation (
        Line(points = {{0, -73.02}, {0, -76}, {0, -80}, {5.6, -80}}, color = {0, 0, 127}));
      connect(salary_per_annum.y, multiProduct[5].u[2]) annotation (
        Line(points = {{79, 50}, {60, 50}, {60, -60}, {1.05, -60}}, color = {0, 0, 127}));
      connect(salary_per_annum.y, multiProduct[4].u[2]) annotation (
        Line(points = {{79, 50}, {60, 50}, {60, -60}, {1.05, -60}}, color = {0, 0, 127}));
      connect(salary_per_annum.y, multiProduct[3].u[2]) annotation (
        Line(points = {{79, 50}, {60, 50}, {60, -60}, {1.05, -60}}, color = {0, 0, 127}));
      connect(salary_per_annum.y, multiProduct[2].u[2]) annotation (
        Line(points = {{79, 50}, {60, 50}, {60, -60}, {1.05, -60}}, color = {0, 0, 127}));
      connect(salary_per_annum.y, multiProduct[1].u[2]) annotation (
        Line(points = {{79, 50}, {60, 50}, {60, -60}, {1.05, -60}}, color = {0, 0, 127}));
      connect(multiSum1.y, PRC) annotation (
        Line(points = {{0, -101.7}, {-0.5, -101.7}, {-0.5, -100}, {60, -100}, {60, -80}, {110, -80}}, color = {0, 0, 127}));
      connect(Tset.y, lRM_Temp[5].Tset) annotation (
        Line(points = {{-79, 90}, {-70, 90}, {-70, 64}, {-42, 64}, {-42, 65.2}, {-40, 65.2}}, color = {0, 0, 127}));
      connect(Tset.y, lRM_Temp[4].Tset) annotation (
        Line(points = {{-79, 90}, {-70, 90}, {-70, 64}, {-40, 64}, {-40, 65.2}, {-40, 65.2}}, color = {0, 0, 127}));
      connect(Tset.y, lRM_Temp[3].Tset) annotation (
        Line(points = {{-79, 90}, {-70, 90}, {-70, 64}, {-40, 64}, {-40, 65.2}, {-40, 65.2}}, color = {0, 0, 127}));
      connect(Tset.y, lRM_Temp[2].Tset) annotation (
        Line(points = {{-79, 90}, {-70, 90}, {-70, 64}, {-40, 64}, {-40, 65.2}}, color = {0, 0, 127}));
      connect(Tset_workshop.y, lRM_Temp[1].Tset) annotation (
        Line(points = {{-79, 50}, {-70, 50}, {-70, 64}, {-40, 64}, {-40, 65.2}}, color = {0, 0, 127}));
      connect(mainBus.TRoom1Mea, lRM_Temp[1].T) annotation (
        Line(points = {{-101.95, 0.05}, {-88, 0.05}, {-88, 0}, {-50, 0}, {-50, 76.5}, {-40, 76.5}, {-40, 76.8}}, color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.TRoom2Mea, lRM_Temp[2].T) annotation (
        Line(points = {{-101.95, 0.05}, {-70, 0.05}, {-70, 0}, {-50, 0}, {-50, 76.5}, {-40, 76.5}, {-40, 76.8}}, color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.TRoom3Mea, lRM_Temp[3].T) annotation (
        Line(points = {{-101.95, 0.05}, {-70, 0.05}, {-70, 0}, {-50, 0}, {-50, 76.5}, {-40, 76.5}, {-40, 76.8}}, color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.TRoom4Mea, lRM_Temp[4].T) annotation (
        Line(points = {{-101.95, 0.05}, {-70, 0.05}, {-70, 0}, {-50, 0}, {-50, 76.5}, {-40, 76.5}, {-40, 76.8}}, color = {255, 204, 51}, thickness = 0.5));
      connect(mainBus.TRoom5Mea, lRM_Temp[5].T) annotation (
        Line(points = {{-101.95, 0.05}, {-96, 0.05}, {-96, 0}, {-50, 0}, {-50, 76.5}, {-40, 76.5}, {-40, 76.8}}, color = {255, 204, 51}, thickness = 0.5));
      annotation (
        Line(points = {{79, -32}, {74, -32}, {74, -34}, {60, -34}, {60, -52}, {-2.4, -52}, {-2.4, -50}, {0.525, -50}}, color = {0, 0, 127}),
        Icon(coordinateSystem(initialScale = 0.1), graphics={  Text(lineColor = {0, 0, 255}, extent = {{-150, 110}, {150, 150}}, textString = ""), Text(extent = {{-100, 52}, {5, 92}}, textString = ""), Text(extent = {{-100, -92}, {5, -52}}, textString = ""), Rectangle(fillColor = {215, 215, 215},
                fillPattern =                                                                                                                                                                                                        FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(lineColor=
                  {95,95,95},                                                                                                                                                                                                        fillColor=
                  {215,215,215},
                fillPattern=FillPattern.Solid,                                                                                                                                                                                                        extent = {{-68, 36}, {62, -40}},
              textString="Performance
Reduction
Costs")}));
    end PerformanceReductionCosts;

    model EmissionsCosts
      "calculating the costs for emissions as part of the operational costs to evaluate the performance of a control strategy according to CCCS evaluation method"
      Modelica.Blocks.Math.Gain EmissionsFactorDistrictHeating(k = eDisHeat) annotation (
        Placement(visible = true, transformation(extent={{-38,70},{-18,90}},      rotation = 0)));
      Modelica.Blocks.Math.Gain EmissionsFactorDistrictCooling(k = eDisCool) annotation (
        Placement(visible = true, transformation(extent={{-40,40},{-20,60}},      rotation = 0)));
      Modelica.Blocks.Math.Gain EmissionsFactorElectricity(k = eEl) annotation (
        Placement(visible = true, transformation(extent={{-38,0},{-18,20}},         rotation = 0)));
      Modelica.Blocks.Math.Gain CostFactorEmissions(k = cEm) annotation (
        Placement(visible = true, transformation(extent = {{60, -10}, {80, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput Emission_Cost annotation (
        Placement(visible = true, transformation(extent = {{100, -10}, {120, 10}}, rotation = 0), iconTransformation(extent = {{100, -10}, {120, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Gain EmissionsFactorFuel(k = eFuel) annotation (
        Placement(visible = true, transformation(extent = {{-40, -80}, {-20, -60}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant EnergyDemandForDistrictHeating(k = 0) "auxiliary constabt - to be replaced by corresponding connection measure bus - EmissionsFactorDistrictHeating in case district heating is used in model" annotation (
        Placement(visible = true, transformation(origin={-90,81},    extent = {{-10, -11}, {10, 11}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant EnergyDemandForDistrictCooling(k = 0) "auxiliary constant - to be replaced by corresponding connection measure bus - EmissionsFactorDistrictCooling in case district cooling is used in model" annotation (
        Placement(visible = true, transformation(origin={-90,49},    extent = {{-10, -11}, {10, 11}}, rotation = 0)));
      parameter Real eFuel = 0.201 "emissions factor fuel [kg/kWh]";
      parameter Real eEl = 0.474 "emissions factor electricity [kg/kWh]";
      parameter Real eDisHeat = 0.2 "emissions factor district heating [kg/kWh]";
      parameter Real eDisCool = 0.527 "emissions factor district cooling [kg/kWh]";
      parameter Real cEm = 0.0258 "cost factor emissions [€/kg]";
      Modelica.Blocks.Interfaces.RealInput WelTotal annotation (
        Placement(visible = true, transformation(origin={-120,10},     extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin={-120,10},     extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput FuelTotal annotation (
        Placement(visible = true, transformation(origin = {-120, -70}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -70}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Math.MultiSum multiSum1(nu = 4) annotation (
        Placement(visible = true, transformation(origin = {30, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(EmissionsFactorFuel.y, multiSum1.u[4]) annotation (
        Line(points = {{-19, -70}, {0, -70}, {0, 0}, {20, 0}, {20, -5.25}, {20, -5.25}}, color = {0, 0, 127}));
      connect(FuelTotal, EmissionsFactorFuel.u) annotation (
        Line(points = {{-120, -70}, {-42, -70}, {-42, -70}, {-42, -70}}, color = {0, 0, 127}));
      connect(EmissionsFactorElectricity.y, multiSum1.u[3]) annotation (
        Line(points={{-17,10},{0,10},{0,-1.75},{20,-1.75}},            color = {0, 0, 127}));
      connect(WelTotal, EmissionsFactorElectricity.u) annotation (
        Line(points={{-120,10},{-40,10}},                                color = {0, 0, 127}));
      connect(EmissionsFactorDistrictCooling.y, multiSum1.u[2]) annotation (
        Line(points={{-19,50},{0,50},{0,0},{20,0},{20,1.75}},                        color = {0, 0, 127}));
      connect(EmissionsFactorDistrictHeating.y, multiSum1.u[1]) annotation (
        Line(points={{-17,80},{0,80},{0,5.25},{20,5.25}},          color = {0, 0, 127}));
      connect(multiSum1.y, CostFactorEmissions.u) annotation (
        Line(points = {{41.7, 0}, {56, 0}, {56, 0}, {58, 0}}, color = {0, 0, 127}));
      connect(EnergyDemandForDistrictCooling.y, EmissionsFactorDistrictCooling.u) annotation (
        Line(points={{-79,49},{-54,49},{-54,50},{-42,50}},          color = {0, 0, 127}));
      connect(EnergyDemandForDistrictHeating.y, EmissionsFactorDistrictHeating.u) annotation (
        Line(points={{-79,81},{-40,81},{-40,80}},        color = {0, 0, 127}));
      connect(CostFactorEmissions.y, Emission_Cost) annotation (
        Line(points = {{81, 0}, {110, 0}}, color = {0, 0, 127}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics={  Rectangle(fillColor = {215, 215, 215},
                fillPattern =                                                                                                                    FillPattern.Solid, extent = {{-100, 100}, {100, -102}}), Text(lineColor=
                  {95,95,95},                                                                                                                                                                                                        fillColor=
                  {215,215,215},
                fillPattern=FillPattern.Solid,                                                                                                                                                                                                        extent = {{-62, 26}, {54, -32}},
              textString="Emission
Costs")}),
        Diagram(coordinateSystem(preserveAspectRatio = false), graphics={  Rectangle(extent = {{308, -308}, {788, 354}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 255},
                fillPattern =                                                                                                                                                                FillPattern.Solid)}));
    end EmissionsCosts;

    model EnergyCosts
      "calculating the energy costs as part of the operational costs to evaluate the performance of a control strategy according to CCCS evaluation method"
      parameter Real cFuel = 0.0455 "cost factor fuel [€/kWh]";
      parameter Real cEl = 0.222 "cost factor electricity [€/kWh]";
      parameter Real cDisCool = 0.081 "cost factor district cooling [€/kWh]";
      parameter Real cDisHeat = 0.0494 "cost factor district heating [€/kWh]";
      parameter Real NomPowDisCool = 0 "Nominal power dsitrict cooling [kW]";
      parameter Real NomPowDisHeat = 0 "Nominal power district heating [kW]";
      parameter Real cConDisHeat = 27.14 "cost factor for district heating connection [€/kW]";
      parameter Real cConDisCool = 27.14 "cost factor for district cooling connection [€/kW]";
      parameter Real cConDisHeatFix = 1690 "fixed costs for district heating connection [€]";
      parameter Real cConDisCoolFix = 1690 "fixed costs for district cooling connection [€]";
      Modelica.Blocks.Math.Gain CostFactorDistrictHeating(k = cDisHeat) annotation (
        Placement(visible = true, transformation(extent={{-28,80},{-8,100}},       rotation = 0)));
      Modelica.Blocks.Sources.Constant Constant(k = -30) annotation (
        Placement(visible = true, transformation(origin={-80.9091,30},    extent = {{-9.09091, -10}, {9.09091, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant FixedCostsConnectionDistrictHeating(k = cConDisHeatFix) annotation (
        Placement(visible = true, transformation(extent = {{-10, 30}, {10, 50}}, rotation = 0)));
      Modelica.Blocks.Math.Gain CostFactorConnectionDistrictHeating(k = cConDisHeat) annotation (
        Placement(visible = true, transformation(extent={{-26,50},{-6,70}},       rotation = 0)));
      Modelica.Blocks.Math.Gain CostFactorDistrictCooling(k = cDisCool) annotation (
        Placement(visible = true, transformation(extent={{-28,-50},{-8,-30}},       rotation = 0)));
      Modelica.Blocks.Sources.Constant FixedCostsConnection_DistrictCooling(k = cConDisCoolFix) annotation (
        Placement(visible = true, transformation(extent = {{-10, 0}, {10, 20}}, rotation = 0)));
      Modelica.Blocks.Math.Gain CostFactorConnection_DistrictCooling(k = cConDisCool) annotation (
        Placement(visible = true, transformation(extent={{-30,-20},{-10,0}},      rotation = 0)));
      Modelica.Blocks.Math.Gain CostFactorElectricity(k = cEl) annotation (
        Placement(visible = true, transformation(extent = {{-4, -70}, {16, -50}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput EnergyCost annotation (
        Placement(visible = true, transformation(extent = {{100, -10}, {120, 10}}, rotation = 0), iconTransformation(extent = {{100, -10}, {120, 10}}, rotation = 0)));
      Modelica.Blocks.Math.MultiSum Sum_EnergyCost(nu = 4) annotation (
        Placement(visible = true, transformation(extent = {{80, -6}, {92, 6}}, rotation = 0)));
      Modelica.Blocks.Math.MultiSum Cost_DistrictCooling(nu = 2) annotation (
        Placement(visible = true, transformation(extent = {{54, -46}, {66, -34}}, rotation = 0)));
      Modelica.Blocks.Math.MultiSum PowerConnection_DistrictCooling(nu = 2) annotation (
        Placement(visible = true, transformation(extent={{-54,-16},{-42,-4}},      rotation = 0)));
      Modelica.Blocks.Math.MultiSum CostConnection_DistrictCooling(nu = 2) annotation (
        Placement(visible = true, transformation(extent={{34,-16},{46,-4}},      rotation = 0)));
      Modelica.Blocks.Math.MultiSum CostConnectio_DistrictHeating(nu = 2) annotation (
        Placement(visible = true, transformation(extent={{34,54},{46,66}},      rotation = 0)));
      Modelica.Blocks.Math.MultiSum Cost_DistrictHeating(nu = 2) annotation (
        Placement(visible = true, transformation(extent = {{54, 84}, {66, 96}}, rotation = 0)));
      Modelica.Blocks.Math.Gain CostFactor_Fuel(k = cFuel) annotation (
        Placement(visible = true, transformation(extent = {{0, -100}, {20, -80}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant EnergyDemandOfDistrictCooling(k = 0) "Auxiliary Constant - to be replaced by corresponding connection measure bus - CostFactorDistrictCooling in case district cooling is used in model" annotation (
        Placement(visible = true, transformation(origin={-78.9091,-40},    extent = {{-9.09091, -10}, {9.09091, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant EnergyDemandForDistrictHeating(k = 0) "auxiliary constant - to be replaced by corresponding connection measure bus - CostFactorDistrictHeating in case district heating is used in model" annotation (
        Placement(visible = true, transformation(origin={-78.9091,90},    extent = {{-9.09091, -10}, {9.09091, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant NominalPowerOfDistrictHeating(k = NomPowDisHeat) annotation (
        Placement(visible = true, transformation(origin={-80.9091,60},    extent = {{-9.09091, -10}, {9.09091, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant NominalPowerOfDistrictCooling(k = NomPowDisCool) annotation (
        Placement(visible = true, transformation(origin={-78.9091,-10},    extent = {{-9.09091, -10}, {9.09091, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput WelTotal annotation (
        Placement(visible = true, transformation(origin={-120,0},      extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin={-120,0},      extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput FuelTotal annotation (
        Placement(visible = true, transformation(origin = {-120, -90}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -90}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Math.MultiSum PowerConnection_DistrictHeating(nu = 2) annotation (
        Placement(visible = true, transformation(extent={{-52,54},{-40,66}},      rotation = 0)));
    equation
      connect(Constant.y, PowerConnection_DistrictHeating.u[2]) annotation (
        Line(points={{-70.9091,30},{-60,30},{-60,60},{-52,60},{-52,57.9}},            color = {0, 0, 127}));
      connect(NominalPowerOfDistrictHeating.y, PowerConnection_DistrictHeating.u[1]) annotation (
        Line(points={{-70.9091,60},{-64,60},{-64,62.1},{-52,62.1}},          color = {0, 0, 127}));
      connect(Constant.y, PowerConnection_DistrictCooling.u[1]) annotation (
        Line(points={{-70.9091,30},{-70.9091,29.25},{-73,29.25},{-73,29.5},{-60,
              29.5},{-60,-8},{-54,-8},{-54,-7.9}},                                                                                            color = {0, 0, 127}));
      connect(NominalPowerOfDistrictCooling.y, PowerConnection_DistrictCooling.u[2]) annotation (
        Line(points={{-68.9091,-10},{-74,-10},{-74,-12.1},{-54,-12.1}},          color = {0, 0, 127}));
      connect(PowerConnection_DistrictHeating.y, CostFactorConnectionDistrictHeating.u) annotation (
        Line(points={{-38.98,60},{-28,60}},                            color = {0, 0, 127}));
      connect(FixedCostsConnectionDistrictHeating.y, CostConnectio_DistrictHeating.u[2]) annotation (
        Line(points={{11,40},{20,40},{20,56},{28,56},{28,57.9},{34,57.9}},
                                                                    color = {0, 0, 127}));
      connect(EnergyDemandForDistrictHeating.y, CostFactorDistrictHeating.u) annotation (
        Line(points={{-68.9091,90},{-30,90}},      color = {0, 0, 127}));
      connect(CostFactorConnectionDistrictHeating.y, CostConnectio_DistrictHeating.u[1]) annotation (
        Line(points={{-5,60},{4,60},{4,62.1},{34,62.1}},           color = {0, 0, 127}));
      connect(CostConnectio_DistrictHeating.y, Cost_DistrictHeating.u[1]) annotation (
        Line(points={{47.02,60},{48,60},{48,90},{54,90},{54,92.1}},                        color = {0, 0, 127}));
      connect(FixedCostsConnection_DistrictCooling.y, CostConnection_DistrictCooling.u[2]) annotation (
        Line(points={{11,10},{20,10},{20,-12.1},{34,-12.1}},          color = {0, 0, 127}));
      connect(CostConnection_DistrictCooling.y, Cost_DistrictCooling.u[2]) annotation (
        Line(points={{47.02,-10},{54,-10},{54,-42.1}},        color = {0, 0, 127}));
      connect(CostFactorConnection_DistrictCooling.y, CostConnection_DistrictCooling.u[1]) annotation (
        Line(points={{-9,-10},{4,-10},{4,-7.9},{34,-7.9}},           color = {0, 0, 127}));
      connect(PowerConnection_DistrictCooling.y, CostFactorConnection_DistrictCooling.u) annotation (
        Line(points={{-40.98,-10},{-32,-10}},      color = {0, 0, 127}));
      connect(EnergyDemandOfDistrictCooling.y, CostFactorDistrictCooling.u) annotation (
        Line(points={{-68.9091,-40},{-30,-40}},      color = {0, 0, 127}));
      connect(CostFactorDistrictHeating.y, Cost_DistrictHeating.u[2]) annotation (
        Line(points={{-7,90},{18,90},{18,87.9},{54,87.9}},           color = {0, 0, 127}));
      connect(Cost_DistrictHeating.y, Sum_EnergyCost.u[3]) annotation (
        Line(points = {{67.02, 90}, {72, 90}, {72, -1.05}, {80, -1.05}}, color = {0, 0, 127}));
      connect(CostFactorDistrictCooling.y, Cost_DistrictCooling.u[1]) annotation (
        Line(points={{-7,-40},{18,-40},{18,-37.9},{54,-37.9}},           color = {0, 0, 127}));
      connect(Cost_DistrictCooling.y, Sum_EnergyCost.u[2]) annotation (
        Line(points = {{67.02, -40}, {71.5, -40}, {71.5, 1.05}, {80, 1.05}}, color = {0, 0, 127}));
      connect(WelTotal, CostFactorElectricity.u) annotation (
        Line(points={{-120,0},{-100,0},{-100,-60},{-6,-60}},
                                                color = {0, 0, 127}));
      connect(CostFactorElectricity.y, Sum_EnergyCost.u[1]) annotation (
        Line(points = {{17, -60}, {80, -60}, {80, 3.15}}, color = {0, 0, 127}));
      connect(FuelTotal, CostFactor_Fuel.u) annotation (
        Line(points = {{-120, -90}, {-2, -90}}, color = {0, 0, 127}));
      connect(CostFactor_Fuel.y, Sum_EnergyCost.u[4]) annotation (
        Line(points = {{21, -90}, {80, -90}, {80, -3.15}}, color = {0, 0, 127}));
      connect(Sum_EnergyCost.y, EnergyCost) annotation (
        Line(points = {{93.02, 0}, {110, 0}}, color = {0, 0, 127}));
      annotation (
        Diagram(graphics={  Text(lineColor = {0, 0, 255}, extent = {{-106, -18}, {-1, -58}}, textString = "")}),
        Icon(graphics={  Text(lineColor = {0, 0, 255}, extent = {{-150, 110}, {150, 150}}, textString = ""), Text(lineColor = {0, 0, 255}, extent = {{-38, -34}, {38, 34}}, textString = ""), Text(extent = {{-100, -92}, {5, -52}}, textString = ""), Rectangle(fillColor = {215, 215, 215},
                fillPattern =                                                                                                                                                                                                        FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin = {22, 8}, lineColor=
                  {95,95,95},                                                                                                                                                                                                        fillColor=
                  {215,215,215},
                fillPattern=FillPattern.Solid,                                                                                                                                                                                                        extent = {{-118, 32}, {76, -40}},
              textString="Energy
Costs")}),
        __OpenModelica_commandLineOptions = "");
    end EnergyCosts;
  end Components;

  package BaseClasses
    model RBF
      Modelica.Blocks.Sources.Constant Constant2(k = 1) annotation (
        Placement(visible = true, transformation(origin = {-90, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Product product annotation (
        Placement(visible = true, transformation(origin = {38, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant Constant3(k = -1) annotation (
        Placement(visible = true, transformation(origin = {0, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Add add annotation (
        Placement(visible = true, transformation(origin = {40, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Division Prod annotation (
        Placement(visible = true, transformation(origin = {80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Add q annotation (
        Placement(visible = true, transformation(origin = {-42, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput RBF annotation (
        Placement(visible = true, transformation(extent = {{100, -10}, {120, 10}}, rotation = 0), iconTransformation(extent = {{100, -10}, {120, 10}}, rotation = 0)));
      AixLib.Systems.Benchmark_fb.CCCS.BaseClasses.discountingFactor discountingFactor1 annotation (
        Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant Rate(k = i) annotation (
        Placement(visible = true, transformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant Duration(k = t) annotation (
        Placement(visible = true, transformation(origin = {-90, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      parameter Real t = 1 "duration in years";
      parameter Real i = 0.05 "interest rate";
    equation
      connect(Duration.y, discountingFactor1.duration) annotation (
        Line(points = {{-79, -60}, {-10, -60}, {-10, -5}}, color = {0, 0, 127}));
      connect(Constant3.y, add.u1) annotation (
        Line(points = {{11, 60}, {12, 60}, {12, 26}, {28, 26}}, color = {0, 0, 127}));
      connect(Constant2.y, q.u1) annotation (
        Line(points = {{-79, 60}, {-71.5, 60}, {-71.5, 36}, {-54, 36}}, color = {0, 0, 127}));
      connect(Rate.y, q.u2) annotation (
        Line(points = {{-79, 0}, {-68.5, 0}, {-68.5, 24}, {-54, 24}}, color = {0, 0, 127}));
      connect(Rate.y, product.u2) annotation (
        Line(points = {{-79, 0}, {-68, 0}, {-68, -26}, {26, -26}}, color = {0, 0, 127}));
      connect(q.y, discountingFactor1.discountingfactor) annotation (
        Line(points = {{-31, 30}, {-26, 30}, {-26, 5}, {-10, 5}}, color = {0, 0, 127}));
      connect(discountingFactor1.y, add.u2) annotation (
        Line(points = {{10.6, 0}, {18.3, 0}, {18.3, 14}, {28, 14}}, color = {0, 0, 127}));
      connect(discountingFactor1.y, product.u1) annotation (
        Line(points = {{10.6, 0}, {18, 0}, {18, -13}, {26, -13}, {26, -14}}, color = {0, 0, 127}));
      connect(product.y, Prod.u2) annotation (
        Line(points = {{49, -20}, {60.5, -20}, {60.5, -6}, {68, -6}}, color = {0, 0, 127}));
      connect(add.y, Prod.u1) annotation (
        Line(points = {{51, 20}, {51, 20.75}, {59, 20.75}, {59, 5.5}, {68, 5.5}, {68, 6}}, color = {0, 0, 127}));
      connect(Prod.y, RBF) annotation (
        Line(points = {{91, 0}, {110, 0}}, color = {0, 0, 127}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics={  Rectangle(fillColor = {215, 215, 215},
                fillPattern =                                                                                                                    FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(lineColor = {95, 95, 95}, fillColor = {215, 215, 215},
                fillPattern =                                                                                                                                                                                                        FillPattern.Solid, extent = {{-54, 28}, {56, -26}}, textString = "RBF")}),
        Diagram(coordinateSystem(preserveAspectRatio = false)),
        Documentation(info = "<html><head></head><body>calculating annuity factor</body></html>"));
    end RBF;

    model LRM_TempAndHum "performance reduction due to room temperature and humidity"
      Modelica.Blocks.Logical.And and1 annotation (
        Placement(visible = true, transformation(origin = {-218, -96}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.LessThreshold lessThreshold1(threshold = 0.25) annotation (
        Placement(visible = true, transformation(origin = {-246, -86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.GreaterThreshold greaterThreshold1 annotation (
        Placement(visible = true, transformation(origin = {-246, -118}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.Switch switch1 annotation (
        Placement(visible = true, transformation(origin = {-186, -96}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const(k = 0) annotation (
        Placement(visible = true, transformation(origin = {-216, -124}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.LessThreshold lessThreshold2(threshold = 0) annotation (
        Placement(visible = true, transformation(origin = {-290, 108}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.GreaterThreshold greaterThreshold2(threshold = -2) annotation (
        Placement(visible = true, transformation(origin = {-290, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Feedback feedback1 annotation (
        Placement(visible = true, transformation(origin = {-354, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.And and11 annotation (
        Placement(visible = true, transformation(origin = {-262, 104}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.Switch switch11 annotation (
        Placement(visible = true, transformation(origin = {-234, 106}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const1(k = 0) annotation (
        Placement(visible = true, transformation(origin = {-260, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Blocks.Sources.Constant const2(k = -4) annotation (
        Placement(visible = true, transformation(origin = {-150, 170}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Sources.Constant const3(k = 1) annotation (
        Placement(visible = true, transformation(origin = {-110, 170}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Math.Product product1 annotation (
        Placement(visible = true, transformation(origin = {-128, 106}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Sources.Constant const4(k = 0.2) annotation (
        Placement(visible = true, transformation(origin = {-30, 170}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Sources.Constant const5(k = 0.04) annotation (
        Placement(visible = true, transformation(origin = {-70, 170}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Math.Add add1 annotation (
        Placement(visible = true, transformation(origin = {-154, 106}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Math.Product product2 annotation (
        Placement(visible = true, transformation(origin = {-180, 106}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Math.Add add2 annotation (
        Placement(visible = true, transformation(origin = {-206, 106}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Math.MultiSum multiSum1(k = {1, 1, 1}, nu = 3) annotation (
        Placement(visible = true, transformation(origin = {-206, 8}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Math.Add add3 annotation (
        Placement(visible = true, transformation(origin = {-154, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Sources.Constant const6(k = -2) annotation (
        Placement(visible = true, transformation(origin = {12, 170}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Math.Abs abs1 annotation (
        Placement(visible = true, transformation(origin = {-126, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Math.Product product3 annotation (
        Placement(visible = true, transformation(origin = {-180, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Sources.Constant const7(k = 0) annotation (
        Placement(visible = true, transformation(origin = {-260, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Blocks.Math.Product product5 annotation (
        Placement(visible = true, transformation(origin = {-180, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Math.Add add6 annotation (
        Placement(visible = true, transformation(origin = {-154, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Math.Product product6 annotation (
        Placement(visible = true, transformation(origin = {-128, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Logical.Switch switch12 annotation (
        Placement(visible = true, transformation(origin = {-234, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.And and12 annotation (
        Placement(visible = true, transformation(origin = {-262, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold1(threshold = 2) annotation (
        Placement(visible = true, transformation(origin = {-290, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold1(threshold = 0) annotation (
        Placement(visible = true, transformation(origin = {-292, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const8(k = 0.02) annotation (
        Placement(visible = true, transformation(origin = {50, 170}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Math.Product product4 annotation (
        Placement(visible = true, transformation(origin = {-184, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Math.Abs abs11 annotation (
        Placement(visible = true, transformation(origin = {-130, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Math.Add add4 annotation (
        Placement(visible = true, transformation(origin = {-158, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Sources.Constant const9(k = 0) annotation (
        Placement(visible = true, transformation(origin = {-264, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Blocks.Logical.GreaterThreshold greaterThreshold3(threshold = 2) annotation (
        Placement(visible = true, transformation(origin = {-294, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.And and13 annotation (
        Placement(visible = true, transformation(origin = {-266, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Add add5 annotation (
        Placement(visible = true, transformation(origin = {-210, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Math.Product product7 annotation (
        Placement(visible = true, transformation(origin = {-184, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Math.Add add7 annotation (
        Placement(visible = true, transformation(origin = {-158, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Math.Product product8 annotation (
        Placement(visible = true, transformation(origin = {-132, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Logical.Switch switch13 annotation (
        Placement(visible = true, transformation(origin = {-238, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.LessThreshold lessThreshold3(threshold = 1000) annotation (
        Placement(visible = true, transformation(origin = {-294, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Add add8 annotation (
        Placement(visible = true, transformation(origin = {100, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Math.Product product9 annotation (
        Placement(visible = true, transformation(origin = {74, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Logical.Switch switch14 annotation (
        Placement(visible = true, transformation(origin = {-10, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.And and14 annotation (
        Placement(visible = true, transformation(origin = {-38, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const10(k = 0) annotation (
        Placement(visible = true, transformation(origin = {-36, -52}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Blocks.Logical.LessThreshold lessThreshold4(threshold = 1000) annotation (
        Placement(visible = true, transformation(origin = {-66, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.GreaterThreshold greaterThreshold4(threshold = 2) annotation (
        Placement(visible = true, transformation(origin = {-66, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold2(threshold = 0) annotation (
        Placement(visible = true, transformation(origin = {-64, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const11(k = 0) annotation (
        Placement(visible = true, transformation(origin = {-32, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Blocks.Math.MultiSum multiSum2(k = {1, 1, 1}, nu = 3) annotation (
        Placement(visible = true, transformation(origin = {22, 6}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Logical.And and15 annotation (
        Placement(visible = true, transformation(origin = {-34, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.Switch switch15 annotation (
        Placement(visible = true, transformation(origin = {-6, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.Switch switch16 annotation (
        Placement(visible = true, transformation(origin = {10, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold2(threshold = 2) annotation (
        Placement(visible = true, transformation(origin = {-62, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Product product14 annotation (
        Placement(visible = true, transformation(origin = {48, 104}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Math.Abs abs13 annotation (
        Placement(visible = true, transformation(origin = {102, 104}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Math.Add add12 annotation (
        Placement(visible = true, transformation(origin = {74, 104}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Sources.Constant const12(k = 0) annotation (
        Placement(visible = true, transformation(origin = {-32, 76}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Blocks.Logical.GreaterThreshold greaterThreshold5(threshold = -2) annotation (
        Placement(visible = true, transformation(origin = {-62, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const13(k = 0) annotation (
        Placement(visible = true, transformation(origin = {-20, -128}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.And and16 annotation (
        Placement(visible = true, transformation(origin = {-22, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.And and17 annotation (
        Placement(visible = true, transformation(origin = {-34, 102}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.Switch switch17 annotation (
        Placement(visible = true, transformation(origin = {-6, 104}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.LessThreshold lessThreshold5(threshold = 0) annotation (
        Placement(visible = true, transformation(origin = {-62, 106}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Product product17 annotation (
        Placement(visible = true, transformation(origin = {298, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Math.Add add15 annotation (
        Placement(visible = true, transformation(origin = {328, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Logical.Switch switch18 annotation (
        Placement(visible = true, transformation(origin = {240, -104}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Add add16 annotation (
        Placement(visible = true, transformation(origin = {268, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Math.Product product18 annotation (
        Placement(visible = true, transformation(origin = {298, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Math.Add add17 annotation (
        Placement(visible = true, transformation(origin = {328, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Math.MultiSum multiSum3(k = {1, 1, 1}, nu = 3) annotation (
        Placement(visible = true, transformation(origin = {252, 2}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Logical.Switch switch19 annotation (
        Placement(visible = true, transformation(origin = {220, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.And and18 annotation (
        Placement(visible = true, transformation(origin = {208, -104}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const14(k = 0) annotation (
        Placement(visible = true, transformation(origin = {210, -132}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Product product20 annotation (
        Placement(visible = true, transformation(origin = {300, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Math.Add add18 annotation (
        Placement(visible = true, transformation(origin = {332, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Logical.Switch switch110 annotation (
        Placement(visible = true, transformation(origin = {224, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.And and19 annotation (
        Placement(visible = true, transformation(origin = {196, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const15(k = 0) annotation (
        Placement(visible = true, transformation(origin = {198, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Blocks.Sources.Constant const16(k = 0) annotation (
        Placement(visible = true, transformation(origin = {194, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Blocks.Logical.And and110 annotation (
        Placement(visible = true, transformation(origin = {192, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.LessThreshold lessThreshold7(threshold = 1000) annotation (
        Placement(visible = true, transformation(origin = {180, -94}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.GreaterThreshold greaterThreshold7(threshold = 0.65) annotation (
        Placement(visible = true, transformation(origin = {180, -126}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const17(k = 0) annotation (
        Placement(visible = true, transformation(origin = {198, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Blocks.Math.Add add19 annotation (
        Placement(visible = true, transformation(origin = {304, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Math.Abs abs15 annotation (
        Placement(visible = true, transformation(origin = {332, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Math.Product product22 annotation (
        Placement(visible = true, transformation(origin = {278, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Logical.LessThreshold lessThreshold8(threshold = 0) annotation (
        Placement(visible = true, transformation(origin = {168, 102}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.Switch switch111 annotation (
        Placement(visible = true, transformation(origin = {224, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Add add20 annotation (
        Placement(visible = true, transformation(origin = {332, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Math.Product product24 annotation (
        Placement(visible = true, transformation(origin = {304, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Math.Add add21 annotation (
        Placement(visible = true, transformation(origin = {252, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Modelica.Blocks.Logical.And and111 annotation (
        Placement(visible = true, transformation(origin = {196, 98}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.GreaterThreshold greaterThreshold8(threshold = -2) annotation (
        Placement(visible = true, transformation(origin = {168, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold3(threshold = 2) annotation (
        Placement(visible = true, transformation(origin = {168, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold3(threshold = 0) annotation (
        Placement(visible = true, transformation(origin = {166, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.GreaterThreshold greaterThreshold9(threshold = 2) annotation (
        Placement(visible = true, transformation(origin = {164, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.LessThreshold lessThreshold9(threshold = 1000) annotation (
        Placement(visible = true, transformation(origin = {164, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput T annotation (
        Placement(visible = true, transformation(origin = {-400, 72}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-400, 72}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput Tset annotation (
        Placement(visible = true, transformation(origin = {-400, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-400, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput X annotation (
        Placement(visible = true, transformation(origin = {-400, -70}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-400, -70}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput PRC annotation (
        Placement(visible = true, transformation(origin = {2, -186}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {2, -186}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Math.MultiSum multiSum4(k = {1, 1, 1}, nu = 3) annotation (
        Placement(visible = true, transformation(origin = {-2, -156}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold4(threshold = 0.25) annotation (
        Placement(visible = true, transformation(origin = {-64, -92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold4(threshold = 0.65) annotation (
        Placement(visible = true, transformation(origin = {-64, -122}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const18(k = -0.65) annotation (
        Placement(visible = true, transformation(origin = {90, 170}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Sources.Constant const19(k = 0.42) annotation (
        Placement(visible = true, transformation(origin = {130, 170}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Math.Add add9 annotation (
        Placement(visible = true, transformation(origin = {328, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    equation
      connect(const8.y, product17.u2) annotation (
        Line(points = {{50, 159}, {50, 159}, {50, 140}, {354, 140}, {354, -42}, {310, -42}, {310, -50}, {310, -50}}, color = {0, 0, 127}));
      connect(const6.y, add15.u1) annotation (
        Line(points = {{12, 159}, {12, 159}, {12, 140}, {354, 140}, {354, -62}, {340, -62}, {340, -62}}, color = {0, 0, 127}));
      connect(const19.y, add9.u1) annotation (
        Line(points = {{130, 159}, {130, 159}, {130, 140}, {354, 140}, {354, -34}, {340, -34}, {340, -34}}, color = {0, 0, 127}));
      connect(const18.y, add17.u1) annotation (
        Line(points = {{90, 159}, {90, 159}, {90, 140}, {354, 140}, {354, -8}, {340, -8}, {340, -8}}, color = {0, 0, 127}));
      connect(const19.y, product20.u2) annotation (
        Line(points = {{130, 159}, {130, 159}, {130, 140}, {354, 140}, {354, 46}, {314, 46}, {314, 38}, {312, 38}, {312, 38}}, color = {0, 0, 127}));
      connect(const18.y, add18.u1) annotation (
        Line(points = {{90, 159}, {90, 159}, {90, 140}, {354, 140}, {354, 26}, {344, 26}, {344, 26}}, color = {0, 0, 127}));
      connect(const5.y, product22.u2) annotation (
        Line(points = {{-70, 159}, {-70, 159}, {-70, 140}, {354, 140}, {354, 88}, {292, 88}, {292, 78}, {290, 78}}, color = {0, 0, 127}));
      connect(const6.y, add19.u2) annotation (
        Line(points = {{12, 159}, {12, 159}, {12, 140}, {354, 140}, {354, 88}, {318, 88}, {318, 78}, {316, 78}}, color = {0, 0, 127}));
      connect(const19.y, product24.u1) annotation (
        Line(points = {{130, 159}, {130, 159}, {130, 140}, {354, 140}, {354, 88}, {316, 88}, {316, 94}, {316, 94}}, color = {0, 0, 127}));
      connect(const18.y, add20.u1) annotation (
        Line(points = {{90, 159}, {90, 159}, {90, 140}, {354, 140}, {354, 94}, {344, 94}, {344, 94}}, color = {0, 0, 127}));
      connect(X, add17.u2) annotation (
        Line(points = {{-400, -70}, {-332, -70}, {-332, 140}, {354, 140}, {354, 6}, {342, 6}, {342, 4}, {340, 4}}, color = {0, 0, 127}));
      connect(X, add18.u2) annotation (
        Line(points = {{-400, -70}, {-332, -70}, {-332, 140}, {354, 140}, {354, 38}, {344, 38}, {344, 38}, {344, 38}}, color = {0, 0, 127}));
      connect(X, add20.u2) annotation (
        Line(points = {{-400, -70}, {-332, -70}, {-332, 140}, {354, 140}, {354, 106}, {346, 106}, {346, 106}, {344, 106}}, color = {0, 0, 127}));
      connect(feedback1.y, add15.u2) annotation (
        Line(points = {{-345, 38}, {-332, 38}, {-332, 140}, {354, 140}, {354, -50}, {342, -50}, {342, -50}, {340, -50}}, color = {0, 0, 127}));
      connect(feedback1.y, add9.u2) annotation (
        Line(points = {{-345, 38}, {-332, 38}, {-332, 140}, {354, 140}, {354, -22}, {340, -22}, {340, -22}, {340, -22}}, color = {0, 0, 127}));
      connect(add15.y, product17.u1) annotation (
        Line(points = {{317, -56}, {310, -56}, {310, -62}}, color = {0, 0, 127}));
      connect(product17.y, add16.u1) annotation (
        Line(points = {{287, -56}, {287, -45}, {280, -45}, {280, -32}}, color = {0, 0, 127}));
      connect(add16.y, switch19.u1) annotation (
        Line(points = {{257, -26}, {236, -26}, {236, -12}, {208, -12}, {208, -20}}, color = {0, 0, 127}));
      connect(product18.y, add16.u2) annotation (
        Line(points = {{287, -26}, {280, -26}, {280, -20}}, color = {0, 0, 127}));
      connect(add9.y, product18.u1) annotation (
        Line(points = {{317, -28}, {310, -28}, {310, -32}}, color = {0, 0, 127}));
      connect(add17.y, product18.u2) annotation (
        Line(points = {{317, -2}, {310, -2}, {310, -20}}, color = {0, 0, 127}));
      connect(feedback1.y, abs15.u) annotation (
        Line(points = {{-345, 38}, {-332, 38}, {-332, 140}, {354, 140}, {354, 72}, {346, 72}, {346, 72}, {344, 72}}, color = {0, 0, 127}));
      connect(product20.y, switch110.u1) annotation (
        Line(points = {{289, 32}, {268, 32}, {268, 48}, {212, 48}, {212, 40}, {212, 40}}, color = {0, 0, 127}));
      connect(add18.y, product20.u1) annotation (
        Line(points = {{321, 32}, {312, 32}, {312, 26}, {312, 26}}, color = {0, 0, 127}));
      connect(add19.y, product22.u1) annotation (
        Line(points = {{293, 72}, {290, 72}, {290, 66}, {290, 66}}, color = {0, 0, 127}));
      connect(abs15.y, add19.u1) annotation (
        Line(points = {{321, 72}, {316, 72}, {316, 66}, {316, 66}}, color = {0, 0, 127}));
      connect(add20.y, product24.u2) annotation (
        Line(points = {{321, 100}, {316, 100}, {316, 106}}, color = {0, 0, 127}));
      connect(product24.y, add21.u2) annotation (
        Line(points = {{293, 100}, {264, 100}, {264, 106}}, color = {0, 0, 127}));
      connect(product22.y, add21.u1) annotation (
        Line(points = {{267, 72}, {264, 72}, {264, 94}, {264, 94}}, color = {0, 0, 127}));
      connect(add21.y, switch111.u1) annotation (
        Line(points = {{241, 100}, {240, 100}, {240, 122}, {212, 122}, {212, 108}, {212, 108}}, color = {0, 0, 127}));
      connect(feedback1.y, add8.u2) annotation (
        Line(points = {{-345, 38}, {-332, 38}, {-332, 140}, {122, 140}, {122, -18}, {114, -18}, {114, -18}, {112, -18}}, color = {0, 0, 127}));
      connect(feedback1.y, abs13.u) annotation (
        Line(points = {{-345, 38}, {-332, 38}, {-332, 140}, {122, 140}, {122, 104}, {114, 104}, {114, 104}, {114, 104}}, color = {0, 0, 127}));
      connect(multiSum2.y, switch16.u1) annotation (
        Line(points = {{22, -5.7}, {14, -5.7}, {14, -82}, {-2, -82}, {-2, -92}, {-2, -92}}, color = {0, 0, 127}));
      connect(product9.y, switch14.u1) annotation (
        Line(points = {{63, -24}, {12, -24}, {12, -8}, {-22, -8}, {-22, -16}}, color = {0, 0, 127}));
      connect(add8.y, product9.u2) annotation (
        Line(points = {{89, -24}, {86, -24}, {86, -18}, {86, -18}}, color = {0, 0, 127}));
      connect(const8.y, product9.u1) annotation (
        Line(points = {{50, 159}, {50, 159}, {50, 140}, {122, 140}, {122, -40}, {86, -40}, {86, -30}, {86, -30}}, color = {0, 0, 127}));
      connect(const6.y, add8.u1) annotation (
        Line(points = {{12, 159}, {12, 159}, {12, 140}, {122, 140}, {122, -30}, {112, -30}, {112, -30}}, color = {0, 0, 127}));
      connect(const6.y, add12.u1) annotation (
        Line(points = {{12, 159}, {12, 140}, {122, 140}, {122, 86}, {86, 86}, {86, 98}}, color = {0, 0, 127}));
      connect(const6.y, add4.u2) annotation (
        Line(points = {{12, 159}, {12, 140}, {-104, 140}, {-104, -38}, {-146, -38}, {-146, -44}}, color = {0, 0, 127}));
      connect(const6.y, add3.u2) annotation (
        Line(points = {{12, 159}, {12, 140}, {-104, 140}, {-104, 94}, {-140, 94}, {-140, 84}, {-142, 84}}, color = {0, 0, 127}));
      connect(product14.y, switch17.u1) annotation (
        Line(points = {{37, 104}, {28, 104}, {28, 120}, {-18, 120}, {-18, 112}, {-18, 112}, {-18, 112}}, color = {0, 0, 127}));
      connect(const5.y, product14.u1) annotation (
        Line(points = {{-70, 159}, {-70, 159}, {-70, 140}, {122, 140}, {122, 86}, {60, 86}, {60, 98}, {60, 98}}, color = {0, 0, 127}));
      connect(add12.y, product14.u2) annotation (
        Line(points = {{63, 104}, {60, 104}, {60, 110}, {60, 110}}, color = {0, 0, 127}));
      connect(abs13.y, add12.u2) annotation (
        Line(points = {{91, 104}, {86, 104}, {86, 110}, {86, 110}}, color = {0, 0, 127}));
      connect(const11.y, switch15.u1) annotation (
        Line(points = {{-32, 19}, {-22, 19}, {-22, 44}, {-18, 44}, {-18, 44}}, color = {0, 0, 127}));
      connect(const4.y, product7.u1) annotation (
        Line(points = {{-30, 159}, {-30, 159}, {-30, 140}, {-104, 140}, {-104, -38}, {-170, -38}, {-170, -28}, {-172, -28}}, color = {0, 0, 127}));
      connect(add7.y, product7.u2) annotation (
        Line(points = {{-169, -22}, {-172, -22}, {-172, -16}, {-172, -16}}, color = {0, 0, 127}));
      connect(const3.y, add7.u1) annotation (
        Line(points = {{-110, 159}, {-110, 159}, {-110, 140}, {-104, 140}, {-104, -38}, {-146, -38}, {-146, -28}, {-146, -28}}, color = {0, 0, 127}));
      connect(const2.y, product8.u1) annotation (
        Line(points = {{-150, 159}, {-150, 159}, {-150, 140}, {-104, 140}, {-104, -28}, {-120, -28}, {-120, -28}}, color = {0, 0, 127}));
      connect(const8.y, product4.u2) annotation (
        Line(points = {{50, 159}, {50, 159}, {50, 140}, {-104, 140}, {-104, -38}, {-170, -38}, {-170, -44}, {-172, -44}}, color = {0, 0, 127}));
      connect(product7.y, add5.u2) annotation (
        Line(points = {{-195, -22}, {-196, -22}, {-196, -16}, {-198, -16}}, color = {0, 0, 127}));
      connect(add5.y, switch13.u1) annotation (
        Line(points = {{-221, -22}, {-220, -22}, {-220, -6}, {-250, -6}, {-250, -14}, {-250, -14}}, color = {0, 0, 127}));
      connect(product4.y, add5.u1) annotation (
        Line(points = {{-195, -50}, {-198, -50}, {-198, -28}, {-198, -28}}, color = {0, 0, 127}));
      connect(add4.y, product4.u1) annotation (
        Line(points = {{-169, -50}, {-172, -50}, {-172, -56}, {-172, -56}}, color = {0, 0, 127}));
      connect(abs11.y, add4.u1) annotation (
        Line(points = {{-141, -50}, {-144, -50}, {-144, -56}, {-146, -56}}, color = {0, 0, 127}));
      connect(X, product8.u2) annotation (
        Line(points = {{-400, -70}, {-332, -70}, {-332, 140}, {-104, 140}, {-104, -14}, {-120, -14}, {-120, -16}, {-120, -16}}, color = {0, 0, 127}));
      connect(feedback1.y, abs11.u) annotation (
        Line(points = {{-345, 38}, {-332, 38}, {-332, 140}, {-104, 140}, {-104, -50}, {-116, -50}, {-116, -50}, {-118, -50}}, color = {0, 0, 127}));
      connect(X, product6.u2) annotation (
        Line(points = {{-400, -70}, {-332, -70}, {-332, 140}, {-104, 140}, {-104, 44}, {-116, 44}, {-116, 44}, {-116, 44}}, color = {0, 0, 127}));
      connect(product5.y, switch12.u1) annotation (
        Line(points = {{-191, 38}, {-200, 38}, {-200, 54}, {-248, 54}, {-248, 46}, {-246, 46}, {-246, 46}}, color = {0, 0, 127}));
      connect(add6.y, product5.u2) annotation (
        Line(points = {{-165, 38}, {-168, 38}, {-168, 44}, {-168, 44}}, color = {0, 0, 127}));
      connect(const4.y, product5.u1) annotation (
        Line(points = {{-30, 159}, {-30, 159}, {-30, 140}, {-104, 140}, {-104, 20}, {-168, 20}, {-168, 32}, {-168, 32}}, color = {0, 0, 127}));
      connect(product6.y, add6.u2) annotation (
        Line(points = {{-139, 38}, {-142, 38}, {-142, 44}, {-142, 44}}, color = {0, 0, 127}));
      connect(const3.y, add6.u1) annotation (
        Line(points = {{-110, 159}, {-110, 159}, {-110, 140}, {-104, 140}, {-104, 20}, {-142, 20}, {-142, 32}, {-142, 32}}, color = {0, 0, 127}));
      connect(const2.y, product6.u1) annotation (
        Line(points = {{-150, 159}, {-150, 159}, {-150, 140}, {-104, 140}, {-104, 30}, {-114, 30}, {-114, 32}, {-116, 32}}, color = {0, 0, 127}));
      connect(const4.y, product2.u1) annotation (
        Line(points = {{-30, 159}, {-30, 140}, {-104, 140}, {-104, 94}, {-168, 94}, {-168, 100}}, color = {0, 0, 127}));
      connect(add1.y, product2.u2) annotation (
        Line(points = {{-165, 106}, {-168, 106}, {-168, 112}, {-168, 112}}, color = {0, 0, 127}));
      connect(const3.y, add1.u1) annotation (
        Line(points = {{-110, 159}, {-110, 159}, {-110, 140}, {-104, 140}, {-104, 94}, {-140, 94}, {-140, 100}, {-142, 100}}, color = {0, 0, 127}));
      connect(product1.y, add1.u2) annotation (
        Line(points = {{-139, 106}, {-140, 106}, {-140, 112}, {-142, 112}}, color = {0, 0, 127}));
      connect(const2.y, product1.u1) annotation (
        Line(points = {{-150, 159}, {-150, 159}, {-150, 140}, {-104, 140}, {-104, 100}, {-116, 100}, {-116, 100}}, color = {0, 0, 127}));
      connect(X, product1.u2) annotation (
        Line(points = {{-400, -70}, {-332, -70}, {-332, 140}, {-104, 140}, {-104, 112}, {-116, 112}, {-116, 112}}, color = {0, 0, 127}));
      connect(add2.y, switch11.u1) annotation (
        Line(points = {{-217, 106}, {-216, 106}, {-216, 120}, {-246, 120}, {-246, 114}, {-246, 114}}, color = {0, 0, 127}));
      connect(product2.y, add2.u2) annotation (
        Line(points = {{-191, 106}, {-194, 106}, {-194, 112}, {-194, 112}, {-194, 112}}, color = {0, 0, 127}));
      connect(product3.y, add2.u1) annotation (
        Line(points = {{-191, 78}, {-194, 78}, {-194, 100}, {-194, 100}}, color = {0, 0, 127}));
      connect(const5.y, product3.u2) annotation (
        Line(points = {{-70, 159}, {-70, 159}, {-70, 140}, {-104, 140}, {-104, 94}, {-168, 94}, {-168, 84}, {-168, 84}}, color = {0, 0, 127}));
      connect(add3.y, product3.u1) annotation (
        Line(points = {{-165, 78}, {-166, 78}, {-166, 72}, {-168, 72}}, color = {0, 0, 127}));
      connect(abs1.y, add3.u1) annotation (
        Line(points = {{-137, 78}, {-142, 78}, {-142, 72}, {-142, 72}}, color = {0, 0, 127}));
      connect(feedback1.y, abs1.u) annotation (
        Line(points = {{-345, 38}, {-332, 38}, {-332, 140}, {-104, 140}, {-104, 80}, {-112, 80}, {-112, 78}, {-114, 78}}, color = {0, 0, 127}));
      connect(T, feedback1.u1) annotation (
        Line(points = {{-400, 72}, {-366, 72}, {-366, 38}, {-362, 38}}, color = {0, 0, 127}));
      connect(Tset, feedback1.u2) annotation (
        Line(points = {{-400, 0}, {-354, 0}, {-354, 30}}, color = {0, 0, 127}));
      connect(X, lessThreshold1.u) annotation (
        Line(points = {{-400, -70}, {-260, -70}, {-260, -86}, {-258, -86}}, color = {0, 0, 127}));
      connect(X, greaterThreshold1.u) annotation (
        Line(points = {{-400, -70}, {-260, -70}, {-260, -118}, {-258, -118}}, color = {0, 0, 127}));
      connect(X, lessThreshold7.u) annotation (
        Line(points = {{-400, -70}, {166, -70}, {166, -94}, {168, -94}}, color = {0, 0, 127}));
      connect(X, greaterThreshold7.u) annotation (
        Line(points = {{-400, -70}, {164, -70}, {164, -126}, {168, -126}}, color = {0, 0, 127}));
      connect(X, greaterEqualThreshold4.u) annotation (
        Line(points = {{-400, -70}, {-76, -70}, {-76, -92}}, color = {0, 0, 127}));
      connect(X, lessEqualThreshold4.u) annotation (
        Line(points = {{-400, -70}, {-76, -70}, {-76, -122}}, color = {0, 0, 127}));
      connect(feedback1.y, lessThreshold8.u) annotation (
        Line(points = {{-345, 38}, {-332, 38}, {-332, 140}, {140, 140}, {140, 102}, {156, 102}, {156, 102}, {156, 102}}, color = {0, 0, 127}));
      connect(feedback1.y, greaterThreshold8.u) annotation (
        Line(points = {{-345, 38}, {-332, 38}, {-332, 140}, {140, 140}, {140, 74}, {154, 74}, {154, 74}, {156, 74}}, color = {0, 0, 127}));
      connect(feedback1.y, lessEqualThreshold3.u) annotation (
        Line(points = {{-345, 38}, {-332, 38}, {-332, 140}, {140, 140}, {140, 40}, {156, 40}, {156, 40}, {156, 40}}, color = {0, 0, 127}));
      connect(feedback1.y, greaterEqualThreshold3.u) annotation (
        Line(points = {{-345, 38}, {-332, 38}, {-332, 140}, {140, 140}, {140, 10}, {154, 10}, {154, 10}, {154, 10}}, color = {0, 0, 127}));
      connect(feedback1.y, lessThreshold9.u) annotation (
        Line(points = {{-345, 38}, {-332, 38}, {-332, 140}, {140, 140}, {140, -24}, {152, -24}, {152, -26}, {152, -26}, {152, -26}}, color = {0, 0, 127}));
      connect(feedback1.y, greaterThreshold9.u) annotation (
        Line(points = {{-345, 38}, {-332, 38}, {-332, 140}, {140, 140}, {140, -52}, {152, -52}, {152, -54}}, color = {0, 0, 127}));
      connect(feedback1.y, lessThreshold5.u) annotation (
        Line(points = {{-345, 38}, {-332, 38}, {-332, 140}, {-90, 140}, {-90, 106}, {-74, 106}}, color = {0, 0, 127}));
      connect(feedback1.y, greaterThreshold5.u) annotation (
        Line(points = {{-345, 38}, {-332, 38}, {-332, 140}, {-90, 140}, {-90, 80}, {-74, 80}, {-74, 78}}, color = {0, 0, 127}));
      connect(feedback1.y, lessEqualThreshold2.u) annotation (
        Line(points = {{-345, 38}, {-332, 38}, {-332, 140}, {-90, 140}, {-90, 46}, {-74, 46}, {-74, 44}}, color = {0, 0, 127}));
      connect(feedback1.y, greaterEqualThreshold2.u) annotation (
        Line(points = {{-345, 38}, {-332, 38}, {-332, 140}, {-90, 140}, {-90, 16}, {-76, 16}, {-76, 14}}, color = {0, 0, 127}));
      connect(feedback1.y, lessThreshold4.u) annotation (
        Line(points = {{-345, 38}, {-332, 38}, {-332, 140}, {-90, 140}, {-90, -20}, {-78, -20}, {-78, -22}}, color = {0, 0, 127}));
      connect(feedback1.y, greaterThreshold4.u) annotation (
        Line(points = {{-345, 38}, {-332, 38}, {-332, 140}, {-90, 140}, {-90, -50}, {-78, -50}}, color = {0, 0, 127}));
      connect(feedback1.y, greaterThreshold3.u) annotation (
        Line(points = {{-345, 38}, {-332, 38}, {-332, -46}, {-308, -46}, {-308, -48}, {-306, -48}}, color = {0, 0, 127}));
      connect(feedback1.y, lessThreshold3.u) annotation (
        Line(points = {{-345, 38}, {-332, 38}, {-332, -20}, {-306, -20}}, color = {0, 0, 127}));
      connect(feedback1.y, greaterEqualThreshold1.u) annotation (
        Line(points = {{-345, 38}, {-332, 38}, {-332, 14}, {-306, 14}, {-306, 16}, {-304, 16}}, color = {0, 0, 127}));
      connect(feedback1.y, lessEqualThreshold1.u) annotation (
        Line(points = {{-345, 38}, {-332, 38}, {-332, 46}, {-302, 46}}, color = {0, 0, 127}));
      connect(feedback1.y, greaterThreshold2.u) annotation (
        Line(points = {{-345, 38}, {-332, 38}, {-332, 80}, {-302, 80}}, color = {0, 0, 127}));
      connect(feedback1.y, lessThreshold2.u) annotation (
        Line(points = {{-345, 38}, {-332, 38}, {-332, 108}, {-302, 108}}, color = {0, 0, 127}));
      connect(const17.y, switch111.u3) annotation (
        Line(points = {{198, 83}, {212, 83}, {212, 92}, {212, 92}}, color = {0, 0, 127}));
      connect(and111.y, switch111.u2) annotation (
        Line(points = {{207, 98}, {212, 98}, {212, 100}, {212, 100}}, color = {255, 0, 255}));
      connect(lessThreshold8.y, and111.u1) annotation (
        Line(points = {{179, 102}, {182, 102}, {182, 98}, {184, 98}}, color = {255, 0, 255}));
      connect(greaterThreshold8.y, and111.u2) annotation (
        Line(points = {{179, 74}, {184, 74}, {184, 90}, {184, 90}}, color = {255, 0, 255}));
      connect(const15.y, switch110.u3) annotation (
        Line(points = {{198, 15}, {212, 15}, {212, 24}, {212, 24}}, color = {0, 0, 127}));
      connect(and19.y, switch110.u2) annotation (
        Line(points = {{207, 30}, {210, 30}, {210, 32}, {212, 32}}, color = {255, 0, 255}));
      connect(greaterEqualThreshold3.y, and19.u2) annotation (
        Line(points = {{177, 10}, {184, 10}, {184, 22}, {184, 22}}, color = {255, 0, 255}));
      connect(lessEqualThreshold3.y, and19.u1) annotation (
        Line(points = {{179, 40}, {182, 40}, {182, 30}, {184, 30}}, color = {255, 0, 255}));
      connect(const16.y, switch19.u3) annotation (
        Line(points = {{194, -45}, {206, -45}, {206, -36}, {208, -36}}, color = {0, 0, 127}));
      connect(and110.y, switch19.u2) annotation (
        Line(points = {{203, -30}, {208, -30}, {208, -28}, {208, -28}}, color = {255, 0, 255}));
      connect(lessThreshold9.y, and110.u1) annotation (
        Line(points = {{175, -26}, {180, -26}, {180, -30}, {180, -30}}, color = {255, 0, 255}));
      connect(greaterThreshold9.y, and110.u2) annotation (
        Line(points = {{175, -54}, {180, -54}, {180, -38}, {180, -38}}, color = {255, 0, 255}));
      connect(multiSum3.y, switch18.u1) annotation (
        Line(points = {{252, -9.7}, {250, -9.7}, {250, -82}, {228, -82}, {228, -96}, {228, -96}}, color = {0, 0, 127}));
      connect(const10.y, switch14.u3) annotation (
        Line(points = {{-36, -41}, {-24, -41}, {-24, -32}, {-22, -32}}, color = {0, 0, 127}));
      connect(and14.y, switch14.u2) annotation (
        Line(points = {{-27, -26}, {-24, -26}, {-24, -24}, {-22, -24}}, color = {255, 0, 255}));
      connect(greaterThreshold4.y, and14.u2) annotation (
        Line(points = {{-55, -50}, {-50, -50}, {-50, -34}, {-50, -34}}, color = {255, 0, 255}));
      connect(lessThreshold4.y, and14.u1) annotation (
        Line(points = {{-55, -22}, {-50, -22}, {-50, -26}, {-50, -26}}, color = {255, 0, 255}));
      connect(and15.y, switch15.u2) annotation (
        Line(points = {{-23, 34}, {-18, 34}, {-18, 36}, {-18, 36}}, color = {255, 0, 255}));
      connect(const11.y, switch15.u3) annotation (
        Line(points = {{-32, 19}, {-20, 19}, {-20, 28}, {-18, 28}}, color = {0, 0, 127}));
      connect(greaterEqualThreshold2.y, and15.u2) annotation (
        Line(points = {{-53, 14}, {-48, 14}, {-48, 26}, {-46, 26}}, color = {255, 0, 255}));
      connect(lessEqualThreshold2.y, and15.u1) annotation (
        Line(points = {{-51, 44}, {-46, 44}, {-46, 34}, {-46, 34}}, color = {255, 0, 255}));
      connect(and17.y, switch17.u2) annotation (
        Line(points = {{-23, 102}, {-18, 102}, {-18, 104}, {-18, 104}}, color = {255, 0, 255}));
      connect(const12.y, switch17.u3) annotation (
        Line(points = {{-32, 87}, {-18, 87}, {-18, 96}, {-18, 96}}, color = {0, 0, 127}));
      connect(greaterThreshold5.y, and17.u2) annotation (
        Line(points = {{-51, 78}, {-46, 78}, {-46, 94}, {-46, 94}}, color = {255, 0, 255}));
      connect(lessThreshold5.y, and17.u1) annotation (
        Line(points = {{-51, 106}, {-46, 106}, {-46, 102}, {-46, 102}}, color = {255, 0, 255}));
      connect(const13.y, switch16.u3) annotation (
        Line(points = {{-9, -128}, {-4, -128}, {-4, -108}, {-2, -108}}, color = {0, 0, 127}));
      connect(and13.y, switch13.u2) annotation (
        Line(points = {{-255, -24}, {-250, -24}, {-250, -22}, {-250, -22}}, color = {255, 0, 255}));
      connect(const9.y, switch13.u3) annotation (
        Line(points = {{-264, -39}, {-252, -39}, {-252, -30}, {-250, -30}}, color = {0, 0, 127}));
      connect(greaterThreshold3.y, and13.u2) annotation (
        Line(points = {{-283, -48}, {-278, -48}, {-278, -32}, {-278, -32}}, color = {255, 0, 255}));
      connect(lessThreshold3.y, and13.u1) annotation (
        Line(points = {{-283, -20}, {-278, -20}, {-278, -24}, {-278, -24}, {-278, -24}}, color = {255, 0, 255}));
      connect(const7.y, switch12.u3) annotation (
        Line(points = {{-260, 21}, {-248, 21}, {-248, 30}, {-246, 30}}, color = {0, 0, 127}));
      connect(and12.y, switch12.u2) annotation (
        Line(points = {{-251, 36}, {-246, 36}, {-246, 38}, {-246, 38}}, color = {255, 0, 255}));
      connect(greaterEqualThreshold1.y, and12.u2) annotation (
        Line(points = {{-281, 16}, {-274, 16}, {-274, 28}, {-274, 28}}, color = {255, 0, 255}));
      connect(lessEqualThreshold1.y, and12.u1) annotation (
        Line(points = {{-279, 46}, {-274, 46}, {-274, 36}, {-274, 36}}, color = {255, 0, 255}));
      connect(multiSum1.y, switch1.u1) annotation (
        Line(points = {{-206, -3.7}, {-206, -3.7}, {-206, -76}, {-198, -76}, {-198, -88}, {-198, -88}}, color = {0, 0, 127}));
      connect(and11.y, switch11.u2) annotation (
        Line(points = {{-251, 104}, {-246, 104}, {-246, 106}, {-246, 106}}, color = {255, 0, 255}));
      connect(const1.y, switch11.u3) annotation (
        Line(points = {{-260, 89}, {-248, 89}, {-248, 98}, {-246, 98}}, color = {0, 0, 127}));
      connect(greaterThreshold2.y, and11.u2) annotation (
        Line(points = {{-279, 80}, {-274, 80}, {-274, 96}, {-274, 96}}, color = {255, 0, 255}));
      connect(lessThreshold2.y, and11.u1) annotation (
        Line(points = {{-279, 108}, {-274, 108}, {-274, 104}, {-274, 104}}, color = {255, 0, 255}));
      connect(const14.y, switch18.u3) annotation (
        Line(points = {{221, -132}, {228, -132}, {228, -112}, {228, -112}}, color = {0, 0, 127}));
      connect(and18.y, switch18.u2) annotation (
        Line(points = {{219, -104}, {228, -104}, {228, -104}, {228, -104}}, color = {255, 0, 255}));
      connect(greaterThreshold7.y, and18.u2) annotation (
        Line(points = {{191, -126}, {196, -126}, {196, -112}, {196, -112}}, color = {255, 0, 255}));
      connect(lessThreshold7.y, and18.u1) annotation (
        Line(points = {{191, -94}, {196, -94}, {196, -104}, {196, -104}}, color = {255, 0, 255}));
      connect(and16.y, switch16.u2) annotation (
        Line(points = {{-11, -100}, {-2, -100}, {-2, -100}, {-2, -100}}, color = {255, 0, 255}));
      connect(and1.y, switch1.u2) annotation (
        Line(points = {{-207, -96}, {-198, -96}, {-198, -96}, {-198, -96}}, color = {255, 0, 255}));
      connect(lessEqualThreshold4.y, and16.u2) annotation (
        Line(points = {{-53, -122}, {-34, -122}, {-34, -108}, {-34, -108}}, color = {255, 0, 255}));
      connect(greaterEqualThreshold4.y, and16.u1) annotation (
        Line(points = {{-53, -92}, {-34, -92}, {-34, -100}, {-34, -100}}, color = {255, 0, 255}));
      connect(greaterThreshold1.y, and1.u2) annotation (
        Line(points = {{-235, -118}, {-230, -118}, {-230, -104}, {-230, -104}}, color = {255, 0, 255}));
      connect(const.y, switch1.u3) annotation (
        Line(points = {{-205, -124}, {-200, -124}, {-200, -104}, {-198, -104}}, color = {0, 0, 127}));
      connect(lessThreshold1.y, and1.u1) annotation (
        Line(points = {{-235, -86}, {-230, -86}, {-230, -96}, {-230, -96}}, color = {255, 0, 255}));
      connect(multiSum4.y, PRC) annotation (
        Line(points = {{-2, -167.7}, {-17.5, -167.7}, {-17.5, -163.7}, {-21, -163.7}, {-21, -165.7}, {-14, -165.7}, {-14, -185.7}, {-15, -185.7}, {-15, -186}, {2, -186}}, color = {0, 0, 127}));
      connect(switch111.y, multiSum3.u[1]) annotation (
        Line(points = {{235, 100}, {236, 100}, {236, 12}, {256.667, 12}}, color = {0, 0, 127}));
      connect(switch110.y, multiSum3.u[2]) annotation (
        Line(points = {{235, 32}, {254, 32}, {254, 12}, {252, 12}}, color = {0, 0, 127}));
      connect(switch19.y, multiSum3.u[3]) annotation (
        Line(points = {{231, -28}, {238, -28}, {238, 20}, {247.333, 20}, {247.333, 12}}, color = {0, 0, 127}));
      connect(switch17.y, multiSum2.u[1]) annotation (
        Line(points = {{5, 104}, {26.6667, 104}, {26.6667, 16}}, color = {0, 0, 127}));
      connect(switch15.y, multiSum2.u[2]) annotation (
        Line(points = {{5, 36}, {24, 36}, {24, 16}, {22, 16}}, color = {0, 0, 127}));
      connect(switch14.y, multiSum2.u[3]) annotation (
        Line(points = {{1, -24}, {10, -24}, {10, 24}, {17.3333, 24}, {17.3333, 16}}, color = {0, 0, 127}));
      connect(switch11.y, multiSum1.u[1]) annotation (
        Line(points = {{-223, 106}, {-224, 106}, {-224, 76}, {-201.333, 76}, {-201.333, 18}}, color = {0, 0, 127}));
      connect(switch12.y, multiSum1.u[2]) annotation (
        Line(points = {{-223, 38}, {-206, 38}, {-206, 18}}, color = {0, 0, 127}));
      connect(switch13.y, multiSum1.u[3]) annotation (
        Line(points = {{-227, -22}, {-226, -22}, {-226, 26}, {-210.667, 26}, {-210.667, 18}}, color = {0, 0, 127}));
      connect(switch1.y, multiSum4.u[1]) annotation (
        Line(points = {{-175, -96}, {-170, -96}, {-170, -98}, {-136, -98}, {-136, -142}, {2.66667, -142}, {2.66667, -146}}, color = {0, 0, 127}));
      connect(switch16.y, multiSum4.u[2]) annotation (
        Line(points = {{21, -100}, {20, -100}, {20, -138}, {-10, -138}, {-10, -146}, {-2, -146}}, color = {0, 0, 127}));
      connect(switch18.y, multiSum4.u[3]) annotation (
        Line(points = {{251, -104}, {251, -154}, {-6.66667, -154}, {-6.66667, -146}}, color = {0, 0, 127}));
      connect(product8.y, add7.u2) annotation (
        Line(points = {{-143, -22}, {-144, -22}, {-144, -16}, {-146, -16}}, color = {0, 0, 127}));
      annotation (
        Diagram(coordinateSystem(extent = {{-400, -180}, {400, 180}})),
        Icon(coordinateSystem(extent = {{-400, -180}, {400, 180}}, initialScale = 0.1), graphics={  Rectangle(fillColor = {215, 215, 215},
                fillPattern =                                                                                                                            FillPattern.Solid, extent = {{-398, 180}, {402, -180}}), Text(lineColor = {95, 95, 95}, fillColor = {215, 215, 215},
                fillPattern =                                                                                                                                                                                                        FillPattern.Solid, extent = {{-154, 48}, {142, -32}}, textString = "LRM_Temp_Hum")}),
        __OpenModelica_commandLineOptions = "",
        Documentation(info = "<html><head></head><body><h4>calaculating costs as part of the operational costs of the CCCS evaluation method caused by performance reduction due to deviation in room temperature and humidity from setpoints</h4></body></html>"));
    end LRM_TempAndHum;

    block discountingFactor "u1 is the discounting factor, u2 is the duration in years"
      Modelica.Blocks.Interfaces.RealInput duration annotation (
        Placement(visible = true, transformation(origin = {-100, -50}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -50}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput discountingfactor annotation (
        Placement(visible = true, transformation(origin = {-100, 50}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 50}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput y annotation (
        Placement(visible = true, transformation(origin = {106, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {106, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      y = discountingfactor ^ duration;
      annotation (
        Icon(graphics={  Rectangle(fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(lineColor = {95, 95, 95}, fillColor = {215, 215, 215},
                fillPattern =                                                                                                                                                                                    FillPattern.Solid, extent = {{-56, 30}, {56, -30}}, textString = "Discounting
Factor")}, coordinateSystem(initialScale = 0.1)));
    end discountingFactor;

    model LRM_Temp "performance reduction due to room temperature"
      Modelica.Blocks.Math.Feedback feedback1 annotation (
        Placement(visible = true, transformation(origin = {-60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput T annotation (
        Placement(visible = true, transformation(origin = {-100, 68}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 68}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput Tset annotation (
        Placement(visible = true, transformation(origin = {-100, -48}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -48}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Logical.Switch switch12 annotation (
        Placement(visible = true, transformation(origin = {6, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.LessThreshold lessThreshold(threshold = -2) annotation (
        Placement(transformation(extent = {{-36, 22}, {-16, 42}})));
      Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold = 2) annotation (
        Placement(transformation(extent = {{-36, -44}, {-16, -24}})));
      Modelica.Blocks.Logical.Switch switch1 annotation (
        Placement(visible = true, transformation(origin = {6, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput y annotation (
        Placement(transformation(extent = {{98, -10}, {118, 10}})));
      Modelica.Blocks.Sources.Constant const(k = 0.02) annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {90, -60})));
      Modelica.Blocks.Sources.Constant const1(k = 0.04) annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {90, 50})));
      Modelica.Blocks.Sources.Constant const2(k = -2) annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {90, 80})));
      Modelica.Blocks.Math.Product product annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {20, 60})));
      Modelica.Blocks.Math.Add add annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {54, 74})));
      Modelica.Blocks.Sources.Constant const3(k = 0) annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {-28, 0})));
      Modelica.Blocks.Math.Add add1 annotation (
        Placement(transformation(extent = {{60, -10}, {80, 10}})));
      Modelica.Blocks.Sources.Constant const4(k = -2) annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {90, -90})));
      Modelica.Blocks.Math.Product product1 annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {18, -74})));
      Modelica.Blocks.Math.Add add2 annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {52, -80})));
      Modelica.Blocks.Math.Abs abs1 annotation (
        Placement(transformation(extent = {{0, 80}, {20, 100}})));
    equation
      connect(T, feedback1.u1) annotation (
        Line(points = {{-100, 68}, {-74, 68}, {-74, 0}, {-68, 0}}, color = {0, 0, 127}));
      connect(Tset, feedback1.u2) annotation (
        Line(points = {{-100, -48}, {-60, -48}, {-60, -8}}, color = {0, 0, 127}));
      connect(feedback1.y, lessThreshold.u) annotation (
        Line(points = {{-51, 0}, {-46, 0}, {-46, 32}, {-38, 32}}, color = {0, 0, 127}));
      connect(feedback1.y, greaterThreshold.u) annotation (
        Line(points = {{-51, 0}, {-46, 0}, {-46, -34}, {-38, -34}}, color = {0, 0, 127}));
      connect(lessThreshold.y, switch12.u2) annotation (
        Line(points = {{-15, 32}, {-6, 32}}, color = {255, 0, 255}));
      connect(greaterThreshold.y, switch1.u2) annotation (
        Line(points = {{-15, -34}, {-6, -34}}, color = {255, 0, 255}));
      connect(const3.y, switch12.u3) annotation (
        Line(points = {{-17, 0}, {-12, 0}, {-12, 24}, {-6, 24}}, color = {0, 0, 127}));
      connect(const3.y, switch1.u3) annotation (
        Line(points = {{-17, 0}, {-12, 0}, {-12, -42}, {-6, -42}}, color = {0, 0, 127}));
      connect(add1.y, y) annotation (
        Line(points = {{81, 0}, {108, 0}}, color = {0, 0, 127}));
      connect(switch1.y, add1.u2) annotation (
        Line(points = {{17, -34}, {58, -34}, {58, -6}}, color = {0, 0, 127}));
      connect(switch12.y, add1.u1) annotation (
        Line(points = {{17, 32}, {58, 32}, {58, 6}}, color = {0, 0, 127}));
      connect(const2.y, add.u1) annotation (
        Line(points = {{79, 80}, {74, 80}, {74, 68}, {66, 68}}, color = {0, 0, 127}));
      connect(add.y, product.u2) annotation (
        Line(points = {{43, 74}, {38, 74}, {38, 66}, {32, 66}}, color = {0, 0, 127}));
      connect(const1.y, product.u1) annotation (
        Line(points = {{79, 50}, {40, 50}, {40, 54}, {32, 54}}, color = {0, 0, 127}));
      connect(product.y, switch12.u1) annotation (
        Line(points = {{9, 60}, {-12, 60}, {-12, 40}, {-6, 40}}, color = {0, 0, 127}));
      connect(const4.y, add2.u2) annotation (
        Line(points = {{79, -90}, {72, -90}, {72, -74}, {64, -74}}, color = {0, 0, 127}));
      connect(feedback1.y, add2.u1) annotation (
        Line(points = {{-51, 0}, {-46, 0}, {-46, -100}, {72, -100}, {72, -86}, {64, -86}}, color = {0, 0, 127}));
      connect(add2.y, product1.u1) annotation (
        Line(points = {{41, -80}, {30, -80}}, color = {0, 0, 127}));
      connect(const.y, product1.u2) annotation (
        Line(points = {{79, -60}, {38, -60}, {38, -68}, {30, -68}}, color = {0, 0, 127}));
      connect(product1.y, switch1.u1) annotation (
        Line(points = {{7, -74}, {-12, -74}, {-12, -26}, {-6, -26}}, color = {0, 0, 127}));
      connect(feedback1.y, abs1.u) annotation (
        Line(points = {{-51, 0}, {-46, 0}, {-46, 90}, {-2, 90}}, color = {0, 0, 127}));
      connect(abs1.y, add.u2) annotation (
        Line(points = {{21, 90}, {74, 90}, {74, 80}, {66, 80}}, color = {0, 0, 127}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics={  Rectangle(fillColor = {215, 215, 215},
                fillPattern =                                                                                                                    FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(lineColor = {95, 95, 95}, fillColor = {215, 215, 215},
                fillPattern =                                                                                                                                                                                                        FillPattern.Solid, extent = {{-64, 36}, {64, -28}}, textString = "LRM_Temp")}),
        Diagram(coordinateSystem(preserveAspectRatio = false)),
        Documentation(info = "<html><head></head><body><h4>calculating costs as part of the operational costs of the CCCS evaluation mtheod caused by performance reduction due to devation of room temperature from setpoint</h4></body></html>"));
    end LRM_Temp;

    model LRM_VOC
      Modelica.Blocks.Interfaces.RealOutput y annotation (
        Placement(visible = true, transformation(origin = {106, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {106, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant VOC_Concentration(k = 150) "auxiliara constant - to be replaced with corresponding connection from mainBus" annotation (
        Placement(visible = true, transformation(origin = {-84, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const1(k = 0) annotation (
        Placement(visible = true, transformation(origin = {-20, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.Switch switch1 annotation (
        Placement(visible = true, transformation(origin = {20, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.Switch switch11 annotation (
        Placement(visible = true, transformation(origin = {-10, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Add add1 annotation (
        Placement(visible = true, transformation(origin = {74, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const(k = 1) annotation (
        Placement(visible = true, transformation(origin = {-90, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const2(k = 0) annotation (
        Placement(visible = true, transformation(origin = {-90, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const3(k = 0.0000442) annotation (
        Placement(visible = true, transformation(origin = {-92, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const4(k = -0.00884) annotation (
        Placement(visible = true, transformation(origin = {-50, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold1(threshold = 22500) annotation (
        Placement(visible = true, transformation(origin = {-50, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.LessThreshold lessThreshold1(threshold = 22500) annotation (
        Placement(visible = true, transformation(origin = {-50, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.GreaterThreshold greaterThreshold1(threshold = 200) annotation (
        Placement(visible = true, transformation(origin = {-50, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.And and1 annotation (
        Placement(visible = true, transformation(origin = {-20, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Product product1 annotation (
        Placement(visible = true, transformation(origin = {-50, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Add add2 annotation (
        Placement(visible = true, transformation(origin = {-18, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(add2.y, switch1.u1) annotation (
        Line(points = {{-7, 60}, {0, 60}, {0, 8}, {8, 8}, {8, 8}, {8, 8}, {8, 8}}, color = {0, 0, 127}));
      connect(const4.y, add2.u1) annotation (
        Line(points = {{-39, 90}, {-34, 90}, {-34, 66}, {-30, 66}}, color = {0, 0, 127}));
      connect(product1.y, add2.u2) annotation (
        Line(points = {{-39, 60}, {-34, 60}, {-34, 54}, {-30, 54}, {-30, 54}}, color = {0, 0, 127}));
      connect(const3.y, product1.u1) annotation (
        Line(points = {{-81, 90}, {-68, 90}, {-68, 66}, {-64, 66}, {-64, 66}, {-62, 66}}, color = {0, 0, 127}));
      connect(VOC_Concentration.y, greaterThreshold1.u) annotation (
        Line(points = {{-73, 0}, {-68, 0}, {-68, 20}, {-62, 20}, {-62, 20}, {-62, 20}}, color = {0, 0, 127}));
      connect(VOC_Concentration.y, product1.u2) annotation (
        Line(points = {{-73, 0}, {-68, 0}, {-68, 54}, {-62, 54}, {-62, 54}}, color = {0, 0, 127}));
      connect(const1.y, switch1.u3) annotation (
        Line(points = {{-9, -30}, {0, -30}, {0, -8}, {8, -8}, {8, -8}}, color = {0, 0, 127}));
      connect(add1.y, y) annotation (
        Line(points = {{85, 0}, {98, 0}, {98, 0}, {106, 0}}, color = {0, 0, 127}));
      connect(and1.y, switch1.u2) annotation (
        Line(points = {{-9, 0}, {8, 0}}, color = {255, 0, 255}));
      connect(switch1.y, add1.u1) annotation (
        Line(points = {{31, 0}, {47.5, 0}, {47.5, 6}, {62, 6}}, color = {0, 0, 127}));
      connect(greaterThreshold1.y, and1.u1) annotation (
        Line(points = {{-39, 20}, {-35.5, 20}, {-35.5, 0}, {-32, 0}}, color = {255, 0, 255}));
      connect(lessThreshold1.y, and1.u2) annotation (
        Line(points = {{-39, -20}, {-35.5, -20}, {-35.5, -8}, {-32, -8}}, color = {255, 0, 255}));
      connect(VOC_Concentration.y, lessThreshold1.u) annotation (
        Line(points = {{-73, 0}, {-68, 0}, {-68, -20}, {-62, -20}}, color = {0, 0, 127}));
      connect(VOC_Concentration.y, greaterEqualThreshold1.u) annotation (
        Line(points = {{-73, 0}, {-68, 0}, {-68, -80}, {-62, -80}, {-62, -80}, {-62, -80}}, color = {0, 0, 127}));
      connect(greaterEqualThreshold1.y, switch11.u2) annotation (
        Line(points = {{-39, -80}, {-22, -80}, {-22, -80}, {-22, -80}}, color = {255, 0, 255}));
      connect(const.y, switch11.u1) annotation (
        Line(points = {{-79, -50}, {-28, -50}, {-28, -72}, {-22, -72}}, color = {0, 0, 127}));
      connect(switch11.y, add1.u2) annotation (
        Line(points = {{1, -80}, {56, -80}, {56, -6}, {62, -6}}, color = {0, 0, 127}));
      connect(const2.y, switch11.u3) annotation (
        Line(points = {{-79, -90}, {-74.75, -90}, {-74.75, -98}, {-74.5, -98}, {-74.5, -100}, {-30, -100}, {-30, -88}, {-22, -88}}, color = {0, 0, 127}));
      annotation (
        Icon(graphics={  Rectangle(fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin = {-1, 3}, lineColor = {95, 95, 95}, extent = {{-55, 21}, {55, -21}}, textString = "LRM_VOC")}, coordinateSystem(initialScale = 0.1)),
        Documentation(info = "<html><head></head><body>calculating costs as part of the operational costs of the CCCS evaluation method due to performance reduction caused by concentration of volatile organic compounds &nbsp;in air</body></html>"));
    end LRM_VOC;

    model LRM_CO2
      Modelica.Blocks.Interfaces.RealOutput y annotation (
        Placement(visible = true, transformation(origin = {102, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {102, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant Concentration_CO2(k = 400) "auxiliary constant - to be replaced by corresponding connection from mainBus" annotation (
        Placement(visible = true, transformation(origin = {-82, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const1(k = 0.0000575) annotation (
        Placement(visible = true, transformation(origin = {-70, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const2(k = -0.023) annotation (
        Placement(visible = true, transformation(origin = {-30, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Add add1 annotation (
        Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Product product1 annotation (
        Placement(visible = true, transformation(origin = {-40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(add1.y, y) annotation (
        Line(points = {{11, 0}, {94, 0}, {94, 0}, {102, 0}}, color = {0, 0, 127}));
      connect(const2.y, add1.u1) annotation (
        Line(points = {{-19, 30}, {-16, 30}, {-16, 6}, {-14, 6}, {-14, 6}, {-12, 6}}, color = {0, 0, 127}));
      connect(product1.y, add1.u2) annotation (
        Line(points = {{-29, 0}, {-22, 0}, {-22, -6}, {-12, -6}, {-12, -6}, {-12, -6}}, color = {0, 0, 127}));
      connect(Concentration_CO2.y, product1.u2) annotation (
        Line(points = {{-71, 0}, {-64, 0}, {-64, -6}, {-52, -6}, {-52, -6}, {-52, -6}}, color = {0, 0, 127}));
      connect(const1.y, product1.u1) annotation (
        Line(points = {{-59, 30}, {-56, 30}, {-56, 6}, {-52, 6}, {-52, 6}}, color = {0, 0, 127}));
      annotation (
        Icon(graphics={  Rectangle(fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin = {-1, 1}, lineColor = {95, 95, 95}, extent = {{-53, 21}, {53, -21}}, textString = "LRM_CO2")}, coordinateSystem(initialScale = 0.1)),
        Documentation(info = "<html><head></head><body><span style=\"font-size: 12px;\">calculating costs as part of the operational costs of the CCCS evaluation method due to performance reduction caused by concentration of CO2 in air</span></body></html>"));
    end LRM_CO2;

    model Lifespan_Reduction_Cost_Component
      Modelica.Blocks.Continuous.Derivative derivative1 annotation (
        Placement(visible = true, transformation(origin = {-70, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Abs abs1(generateEvent = true) annotation (
        Placement(visible = true, transformation(origin = {-40, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.GreaterThreshold greaterThreshold1(threshold = 0.001) annotation (
        Placement(visible = true, transformation(origin = {-10, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Continuous.Integrator integrator1 annotation (
        Placement(visible = true, transformation(origin = {50, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const(k = 0) annotation (
        Placement(visible = true, transformation(origin = {-10, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const1(k = 1) annotation (
        Placement(visible = true, transformation(origin = {-10, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.Switch switch1 annotation (
        Placement(visible = true, transformation(origin = {20, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const2(k = 0) annotation (
        Placement(visible = true, transformation(origin = {30, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.BooleanExpression booleanExpression1 annotation (
        Placement(visible = true, transformation(origin = {30, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput u annotation (
        Placement(visible = true, transformation(origin = {-104, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-104, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Product product1 annotation (
        Placement(visible = true, transformation(origin = {-40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const3(k = 365 * 24 * 3600 / sim_time) annotation (
        Placement(visible = true, transformation(origin = {-70, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      parameter Real cost_component "cost for one component";
      parameter Real sim_time "simulated interval in s";
      Modelica.Blocks.Sources.Constant const4(k = 60000 / 20.55) annotation (
        Placement(visible = true, transformation(origin = {-70, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.Switch switch11 annotation (
        Placement(visible = true, transformation(origin = {26, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.Less less1 annotation (
        Placement(visible = true, transformation(origin = {-10, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Feedback feedback1 annotation (
        Placement(visible = true, transformation(origin = {-42, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Product product2 annotation (
        Placement(visible = true, transformation(origin = {-10, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const5(k = cost_component) annotation (
        Placement(visible = true, transformation(origin = {-70, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput y annotation (
        Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(const5.y, product2.u2) annotation (
        Line(points = {{-59, -90}, {-28, -90}, {-28, -66}, {-22, -66}}, color = {0, 0, 127}));
      connect(switch11.y, y) annotation (
        Line(points = {{37, 0}, {92, 0}, {92, 0}, {100, 0}}, color = {0, 0, 127}));
      connect(const1.y, switch1.u1) annotation (
        Line(points = {{1, 90}, {1, 89.5}, {7, 89.5}, {7, 89}, {8, 89}, {8, 68}}, color = {0, 0, 127}));
      connect(product2.y, switch11.u3) annotation (
        Line(points = {{1, -60}, {8, -60}, {8, -8}, {12, -8}, {12, -8}, {14, -8}}, color = {0, 0, 127}));
      connect(feedback1.y, product2.u1) annotation (
        Line(points = {{-33, -60}, {-28, -60}, {-28, -54}, {-22, -54}, {-22, -54}}, color = {0, 0, 127}));
      connect(const4.y, feedback1.u2) annotation (
        Line(points = {{-59, -30}, {-54, -30}, {-54, -74}, {-42, -74}, {-42, -68}}, color = {0, 0, 127}));
      connect(const.y, switch11.u1) annotation (
        Line(points = {{1, 30}, {8, 30}, {8, 8}, {14, 8}}, color = {0, 0, 127}));
      connect(less1.y, switch11.u2) annotation (
        Line(points = {{1, 0}, {14, 0}, {14, 0}, {14, 0}}, color = {255, 0, 255}));
      connect(const4.y, less1.u2) annotation (
        Line(points = {{-59, -30}, {-26, -30}, {-26, -8}, {-22, -8}, {-22, -8}}, color = {0, 0, 127}));
      connect(product1.y, less1.u1) annotation (
        Line(points = {{-29, 0}, {-24, 0}, {-24, 0}, {-22, 0}}, color = {0, 0, 127}));
      connect(integrator1.y, product1.u2) annotation (
        Line(points = {{61, 60}, {68, 60}, {68, 12}, {-60, 12}, {-60, -6}, {-52, -6}}, color = {0, 0, 127}));
      connect(const3.y, product1.u1) annotation (
        Line(points = {{-59, 30}, {-59, 7}, {-52, 7}, {-52, 6}}, color = {0, 0, 127}));
      connect(booleanExpression1.y, integrator1.reset) annotation (
        Line(points = {{41, 24}, {48.5, 24}, {48.5, 24}, {56, 24}, {56, 48}}, color = {255, 0, 255}));
      connect(greaterThreshold1.y, switch1.u2) annotation (
        Line(points = {{1, 60}, {8, 60}}, color = {255, 0, 255}));
      connect(switch1.y, integrator1.u) annotation (
        Line(points = {{31, 60}, {38, 60}}, color = {0, 0, 127}));
      connect(const.y, switch1.u3) annotation (
        Line(points = {{1, 30}, {8, 30}, {8, 52}}, color = {0, 0, 127}));
      connect(const2.y, integrator1.set) annotation (
        Line(points = {{41, 90}, {41, 86}, {56, 86}, {56, 72}}, color = {0, 0, 127}));
      connect(abs1.y, greaterThreshold1.u) annotation (
        Line(points = {{-29, 60}, {-22, 60}}, color = {0, 0, 127}));
      connect(derivative1.y, abs1.u) annotation (
        Line(points = {{-59, 60}, {-52, 60}}, color = {0, 0, 127}));
      connect(u, derivative1.u) annotation (
        Line(points = {{-104, 0}, {-92, 0}, {-92, 60}, {-82, 60}}, color = {0, 0, 127}));
      connect(product1.y, feedback1.u1) annotation (Line(points={{-29,0},{-26,0},
              {-26,-14},{-88,-14},{-88,-60},{-50,-60}}, color={0,0,127}));
      annotation (
        Icon(graphics={  Rectangle(fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin = {1, 2}, lineColor = {95, 95, 95}, extent = {{-63, 30}, {63, -30}}, textString = "LifespanReductionCost \n One Component")}, coordinateSystem(initialScale = 0.1)),
        Documentation(info = "<html><head></head><body>calculation costs as part of the operational costs of the CCCS evaluation method caused by reduced lifespan of a single component due to wear during opration</body></html>"));
    end Lifespan_Reduction_Cost_Component;

    model EnergyCounter2

      parameter Modelica.SIunits.Temperature Tset = 273.15+21 "Set Temperature of rooms for ISE calculation";

      AixLib.Systems.Benchmark.BaseClasses.MainBus mainBus annotation (Placement(transformation(extent={{-118,-18},{-80,18}}),
            iconTransformation(extent={{-18,-42},{16,-6}})));
      Modelica.Blocks.Continuous.Integrator integrator
        annotation (Placement(transformation(extent={{-10,90},{0,100}})));
      Modelica.Blocks.Continuous.Integrator integrator1
        annotation (Placement(transformation(extent={{-10,74},{0,84}})));
      Modelica.Blocks.Math.Add add
        annotation (Placement(transformation(extent={{-26,74},{-16,84}})));
      Modelica.Blocks.Continuous.Integrator integrator2
        annotation (Placement(transformation(extent={{-10,56},{0,66}})));
      Modelica.Blocks.Math.Add add1
        annotation (Placement(transformation(extent={{-26,40},{-16,50}})));
      Modelica.Blocks.Continuous.Integrator integrator3
        annotation (Placement(transformation(extent={{-10,40},{0,50}})));
      Modelica.Blocks.Continuous.Integrator integrator4
        annotation (Placement(transformation(extent={{-10,20},{0,30}})));
      Modelica.Blocks.Continuous.Integrator integrator5
        annotation (Placement(transformation(extent={{-10,4},{0,14}})));
      Modelica.Blocks.Continuous.Integrator integrator6
        annotation (Placement(transformation(extent={{-10,-22},{0,-12}})));
      Modelica.Blocks.Continuous.Integrator integrator7
        annotation (Placement(transformation(extent={{-10,-40},{0,-30}})));
      Modelica.Blocks.Continuous.Integrator integrator9
        annotation (Placement(transformation(extent={{-10,-80},{0,-70}})));
      Modelica.Blocks.Continuous.Integrator integrator10
        annotation (Placement(transformation(extent={{-10,-100},{0,-90}})));
      Modelica.Blocks.Math.Sum sum1(nin=2)
        annotation (Placement(transformation(extent={{-30,-22},{-20,-12}})));
      Modelica.Blocks.Math.Sum sumWel(nin=7)
        annotation (Placement(transformation(extent={{58,4},{68,14}})));
      Modelica.Blocks.Math.Sum sumQbr(nin=2)
        annotation (Placement(transformation(extent={{60,-40},{70,-30}})));
      Modelica.Blocks.Continuous.Integrator integrator11
        annotation (Placement(transformation(extent={{112,88},{122,98}})));
      Modelica.Blocks.Math.Add add2(k2=-1)
        annotation (Placement(transformation(extent={{86,88},{96,98}})));
      Modelica.Blocks.Math.Product product
        annotation (Placement(transformation(extent={{102,90},{108,96}})));
      Modelica.Blocks.Sources.Constant const(k=Tset)
        annotation (Placement(transformation(extent={{74,86},{80,92}})));
      Modelica.Blocks.Continuous.Integrator integrator12
        annotation (Placement(transformation(extent={{112,66},{122,76}})));
      Modelica.Blocks.Math.Add add3(k2=-1)
        annotation (Placement(transformation(extent={{86,66},{96,76}})));
      Modelica.Blocks.Sources.Constant const1(k=Tset)
        annotation (Placement(transformation(extent={{74,64},{80,70}})));
      Modelica.Blocks.Math.Product product1
        annotation (Placement(transformation(extent={{102,68},{108,74}})));
      Modelica.Blocks.Continuous.Integrator integrator13
        annotation (Placement(transformation(extent={{114,40},{124,50}})));
      Modelica.Blocks.Math.Add add4(k2=-1)
        annotation (Placement(transformation(extent={{88,40},{98,50}})));
      Modelica.Blocks.Sources.Constant const2(k=Tset)
        annotation (Placement(transformation(extent={{76,38},{82,44}})));
      Modelica.Blocks.Math.Product product2
        annotation (Placement(transformation(extent={{104,42},{110,48}})));
      Modelica.Blocks.Continuous.Integrator integrator14
        annotation (Placement(transformation(extent={{114,20},{124,30}})));
      Modelica.Blocks.Math.Add add5(k2=-1)
        annotation (Placement(transformation(extent={{88,20},{98,30}})));
      Modelica.Blocks.Sources.Constant const3(k=Tset)
        annotation (Placement(transformation(extent={{76,18},{82,24}})));
      Modelica.Blocks.Math.Product product3
        annotation (Placement(transformation(extent={{104,22},{110,28}})));
      Modelica.Blocks.Continuous.Integrator integrator8
        annotation (Placement(transformation(extent={{112,106},{122,116}})));
      Modelica.Blocks.Math.Add add6(k2=-1)
        annotation (Placement(transformation(extent={{86,106},{96,116}})));
      Modelica.Blocks.Math.Product product4
        annotation (Placement(transformation(extent={{102,108},{108,114}})));
      Modelica.Blocks.Sources.Constant const4(k=Tset)
        annotation (Placement(transformation(extent={{74,104},{80,110}})));
    equation
      connect(integrator.u, mainBus.hpSystemBus.busHP.Pel) annotation (Line(points={
              {-11,95},{-98.905,95},{-98.905,0.09}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(add.y, integrator1.u)
        annotation (Line(points={{-15.5,79},{-11,79}}, color={0,0,127}));
      connect(integrator.y, mainBus.evaBus.WelHPMea) annotation (Line(points={{0.5,95},
              {32,95},{32,0.09},{-98.905,0.09}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(integrator1.y, mainBus.evaBus.WelPumpsHPMea) annotation (Line(points={{0.5,79},
              {32,79},{32,0.09},{-98.905,0.09}},          color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(integrator2.u, mainBus.hpSystemBus.PelAirCoolerMea) annotation (Line(
            points={{-11,61},{-98.905,61},{-98.905,0.09}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(integrator2.y, mainBus.evaBus.WelGCMea) annotation (Line(points={{0.5,61},
              {32,61},{32,0.09},{-98.905,0.09}},     color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(add1.y, integrator3.u) annotation (Line(points={{-15.5,45},{-11,45}},
                                     color={0,0,127}));
      connect(integrator3.y, mainBus.evaBus.WelPumpsHXMea) annotation (Line(points={{0.5,45},
              {32,45},{32,0.09},{-98.905,0.09}},            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(integrator4.y, mainBus.evaBus.WelPumpSWUMea) annotation (Line(points={{0.5,25},
              {32,25},{32,0.09},{-98.905,0.09}},          color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(integrator5.y, mainBus.evaBus.WelPumpGTFMea) annotation (Line(points={{0.5,9},
              {32,9},{32,0.09},{-98.905,0.09}},             color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(integrator6.y, mainBus.evaBus.WelPumpsHTSMea) annotation (Line(points={{0.5,-17},
              {32,-17},{32,0.09},{-98.905,0.09}},           color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(integrator7.u, mainBus.htsBus.fuelPowerBoilerMea) annotation (Line(
            points={{-11,-35},{-98.905,-35},{-98.905,0.09}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(integrator7.y, mainBus.evaBus.QbrBoiMea) annotation (Line(points={{0.5,-35},
              {32,-35},{32,0.09},{-98.905,0.09}},      color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));

      connect(integrator9.u, mainBus.htsBus.fuelPowerChpMea) annotation (Line(
            points={{-11,-75},{-98.905,-75},{-98.905,0.09}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(integrator9.y, mainBus.evaBus.QbrCHPMea) annotation (Line(points={{
              0.5,-75},{32,-75},{32,0.09},{-98.905,0.09}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(integrator10.u, mainBus.htsBus.electricalPowerChpMea) annotation (
          Line(points={{-11,-95},{-98.905,-95},{-98.905,0.09}}, color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(integrator10.y, mainBus.evaBus.WelCPHMea) annotation (Line(points={{
              0.5,-95},{32,-95},{32,0.09},{-98.905,0.09}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));

      connect(sum1.y, integrator6.u) annotation (Line(points={{-19.5,-17},{-14.75,
              -17},{-14.75,-17},{-11,-17}}, color={0,0,127}));
      connect(integrator.y, sumWel.u[1])
        annotation (Line(points={{0.5,95},{57,95},{57,8.14286}}, color={0,0,127}));
      connect(integrator1.y, sumWel.u[2])
        annotation (Line(points={{0.5,79},{57,79},{57,8.42857}}, color={0,0,127}));
      connect(integrator2.y, sumWel.u[3]) annotation (Line(points={{0.5,61},{32,
              61},{32,10},{57,10},{57,8.71429}},
                                             color={0,0,127}));
      connect(integrator3.y, sumWel.u[4]) annotation (Line(points={{0.5,45},{16,
              45},{16,46},{32,46},{32,9},{57,9}},
                                              color={0,0,127}));
      connect(integrator4.y, sumWel.u[5]) annotation (Line(points={{0.5,25},{
              32.25,25},{32.25,9.28571},{57,9.28571}},
                                                 color={0,0,127}));
      connect(integrator5.y, sumWel.u[6])
        annotation (Line(points={{0.5,9},{57,9},{57,9.57143}}, color={0,0,127}));
      connect(integrator6.y, sumWel.u[7]) annotation (Line(points={{0.5,-17},{57,
              -17},{57,9.85714}}, color={0,0,127}));
      connect(sumWel.y, mainBus.evaBus.WelTotalMea) annotation (Line(points={{68.5,9},
              {80,9},{80,0.09},{-98.905,0.09}},    color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(integrator7.y, sumQbr.u[1]) annotation (Line(points={{0.5,-35},{21.25,
              -35},{21.25,-35.5},{59,-35.5}},       color={0,0,127}));
      connect(sumQbr.y, mainBus.evaBus.QbrTotalMea) annotation (Line(points={{70.5,-35},
              {76,-35},{76,-36},{80,-36},{80,0},{-10,0},{-10,0.09},{-98.905,0.09}},
                                                                         color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(product.y, integrator11.u) annotation (Line(points={{108.3,93},{
              109.15,93},{109.15,93},{111,93}}, color={0,0,127}));
      connect(const.y, add2.u2) annotation (Line(points={{80.3,89},{82.15,89},{82.15,
              90},{85,90}},       color={0,0,127}));
      connect(const1.y, add3.u2) annotation (Line(points={{80.3,67},{82.15,67},{82.15,
              68},{85,68}},       color={0,0,127}));
      connect(integrator12.u, product1.y)
        annotation (Line(points={{111,71},{108.3,71}}, color={0,0,127}));
      connect(const2.y, add4.u2) annotation (Line(points={{82.3,41},{84.15,41},{84.15,
              42},{87,42}},       color={0,0,127}));
      connect(integrator13.u, product2.y)
        annotation (Line(points={{113,45},{110.3,45}}, color={0,0,127}));
      connect(const3.y, add5.u2) annotation (Line(points={{82.3,21},{84.15,21},{84.15,
              22},{87,22}},       color={0,0,127}));
      connect(integrator14.u, product3.y)
        annotation (Line(points={{113,25},{110.3,25}}, color={0,0,127}));
      connect(integrator9.y, sumQbr.u[2]) annotation (Line(points={{0.5,-75},{50,-75},
              {50,-34.5},{59,-34.5}}, color={0,0,127}));
      connect(product4.y, integrator8.u)
        annotation (Line(points={{108.3,111},{111,111}}, color={0,0,127}));
      connect(const4.y, add6.u2) annotation (Line(points={{80.3,107},{82.15,107},{82.15,
              108},{85,108}}, color={0,0,127}));
      connect(add6.y, product4.u2) annotation (Line(points={{96.5,111},{99.25,111},
              {99.25,109.2},{101.4,109.2}}, color={0,0,127}));
      connect(add6.y, product4.u1) annotation (Line(points={{96.5,111},{99.25,111},
              {99.25,112.8},{101.4,112.8}}, color={0,0,127}));
      connect(add2.y, product.u1) annotation (Line(points={{96.5,93},{99.25,93},{
              99.25,94.8},{101.4,94.8}}, color={0,0,127}));
      connect(add2.y, product.u2) annotation (Line(points={{96.5,93},{99.25,93},{
              99.25,91.2},{101.4,91.2}}, color={0,0,127}));
      connect(add3.y, product1.u1) annotation (Line(points={{96.5,71},{99.25,71},
              {99.25,72.8},{101.4,72.8}}, color={0,0,127}));
      connect(add3.y, product1.u2) annotation (Line(points={{96.5,71},{99.25,71},
              {99.25,69.2},{101.4,69.2}}, color={0,0,127}));
      connect(add4.y, product2.u1) annotation (Line(points={{98.5,45},{100.25,45},
              {100.25,46.8},{103.4,46.8}}, color={0,0,127}));
      connect(add4.y, product2.u2) annotation (Line(points={{98.5,45},{101.25,45},
              {101.25,43.2},{103.4,43.2}}, color={0,0,127}));
      connect(add5.y, product3.u1) annotation (Line(points={{98.5,25},{100.25,25},
              {100.25,26.8},{103.4,26.8}}, color={0,0,127}));
      connect(add5.y, product3.u2) annotation (Line(points={{98.5,25},{101.25,25},
              {101.25,23.2},{103.4,23.2}}, color={0,0,127}));
      connect(add6.u1, mainBus.TRoom1Mea) annotation (Line(points={{85,114},{-14,
              114},{-14,116},{-98.905,116},{-98.905,0.09}}, color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(add2.u1, mainBus.TRoom2Mea) annotation (Line(points={{85,96},{74,96},
              {74,108},{-110,108},{-110,0.09},{-98.905,0.09}}, color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(add3.u1, mainBus.TRoom3Mea) annotation (Line(points={{85,74},{64,74},
              {64,124},{-108,124},{-108,-6},{-98.905,-6},{-98.905,0.09}}, color={
              0,0,127}), Text(
          string="%second",
          index=1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(add4.u1, mainBus.TRoom4Mea) annotation (Line(points={{87,48},{74,48},
              {74,50},{68,50},{68,124},{-98.905,124},{-98.905,0.09}}, color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(add5.u1, mainBus.TRoom5Mea) annotation (Line(points={{87,28},{66,28},
              {66,128},{-98,128},{-98,0.09},{-98.905,0.09}}, color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(integrator8.y, mainBus.evaBus.IseRoom1) annotation (Line(points={{
              122.5,111},{130,111},{130,130},{-98.905,130},{-98.905,0.09}}, color=
             {0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(integrator11.y, mainBus.evaBus.IseRoom2) annotation (Line(points={{
              122.5,93},{136,93},{136,132},{-98.905,132},{-98.905,0.09}}, color={
              0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(integrator12.y, mainBus.evaBus.IseRoom3) annotation (Line(points={{
              122.5,71},{144,71},{144,128},{-106,128},{-106,0.09},{-98.905,0.09}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(integrator13.y, mainBus.evaBus.IseRoom4) annotation (Line(points={{
              124.5,45},{150,45},{150,130},{-98.905,130},{-98.905,0.09}}, color={
              0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(integrator14.y, mainBus.evaBus.IseRoom5) annotation (Line(points={{
              124.5,25},{158,25},{158,132},{-98.905,132},{-98.905,0.09}}, color={
              0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));

      connect(mainBus.hxBus.primBus.pumpBus.PelMea, add1.u1) annotation (Line(
          points={{-98.905,0.09},{-144,0.09},{-144,48},{-27,48}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(mainBus.gtfBus.primBus.pumpBus.PelMea, integrator5.u) annotation (
          Line(
          points={{-98.905,0.09},{-88,0.09},{-88,2},{-11,2},{-11,9}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(mainBus.swuBus.pumpBus.PelMea, integrator4.u) annotation (Line(
          points={{-98.905,0.09},{-174,0.09},{-174,32},{-11,32},{-11,25}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(mainBus.hxBus.secBus.pumpBus.PelMea, add1.u2) annotation (Line(
          points={{-98.905,0.09},{-196,0.09},{-196,42},{-27,42}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(mainBus.hpSystemBus.busPumpHot.pumpBus.PelMea, add.u2) annotation (
          Line(
          points={{-98.905,0.09},{-134,0.09},{-134,-44},{-218,-44},{-218,76},{-27,76}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));

      connect(mainBus.hpSystemBus.busPumpCold.pumpBus.PelMea, add.u1) annotation (
          Line(
          points={{-98.905,0.09},{-256,0.09},{-256,82},{-27,82}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(mainBus.htsBus.pumpBoilerBus.pumpBus.PelMea, sum1.u[1]) annotation (
          Line(
          points={{-98.905,0.09},{-92,0.09},{-92,-10},{-31,-10},{-31,-17.5}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(mainBus.htsBus.pumpChpBus.pumpBus.PelMea, sum1.u[2]) annotation (Line(
          points={{-98.905,0.09},{-106,0.09},{-106,-32},{-31,-32},{-31,-16.5}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));

      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
              extent={{-86,80},{94,-20}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{30,36}}, color={0,0,0}),
            Polygon(
              points={{44,48},{-8,2},{2,-6},{44,48}},
              lineColor={0,0,0},
              fillColor={238,46,47},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-74,64},{-56,42}},
              color={0,0,0},
              thickness=1),
            Line(
              points={{-26,70},{-22,46}},
              color={0,0,0},
              thickness=1),
            Line(
              points={{28,70},{22,46}},
              color={0,0,0},
              thickness=1),
            Line(
              points={{86,60},{66,38}},
              color={0,0,0},
              thickness=1)}),                                        Diagram(
            coordinateSystem(preserveAspectRatio=false)),
                  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end EnergyCounter2;

    expandable connector CCCSBus
      "Data bus for Cost Coefficient of Control Strategies (CCCS)"
    extends Modelica.Icons.SignalBus;
    import SI = Modelica.SIunits;

    annotation (
      Icon(graphics,
           coordinateSystem(preserveAspectRatio=false)),
      Diagram(graphics,
              coordinateSystem(preserveAspectRatio=false)),
      Documentation(info="<html>
<p>Definition of a bus connector for the ERC Heatpump System.</p>
</html>",   revisions="<html>
<ul>
<li>October 25, 2017, by Alexander K&uuml;mpel:<br/>Adaption for hydraulic modules in AixLib.</li>
<li>February 6, 2016, by Peter Matthes:<br/>First implementation. </li>
</ul>
</html>"));
    end CCCSBus;
  end BaseClasses;
end CCCS;
