within AixLib.Systems.Benchmark_fb.BenchmarkModel_reworked_Modularization;
package CCCS
  extends Modelica.Icons.BasesPackage;

model EnergyCosts "calculating the energy costs as part of the operational costs to evaluate the performance of a control strategy according to CCCS evaluation method"
  parameter Real cFuel=0.00657  "cost factor fuel [€/kWh]";
parameter Real cEl=0.235 "cost factor electricity [€/kWh]";
parameter Real cDisCool=0.081 "cost factor district cooling [€/kWh]";
parameter Real cDisHeat=0.0494  "cost factor district heating [€/kWh]";
parameter Real NomPowDisCool=0 "Nominal power dsitrict cooling [kW]";
parameter Real NomPowDisHeat=0 "Nominal power district heating [kW]";
parameter Real cConDisHeat=27.14 "cost factor for district heating connection [€/kW]";
parameter Real cConDisCool=27.14  "cost factor for district cooling connection [€/kW]";
parameter Real cConDisHeatFix=1690 "fixed costs for district heating connection [€]";
parameter Real cConDisCoolFix=1690 "fixed costs for district cooling connection [€]";
  Modelica.Blocks.Math.Gain CostFactorDistrictHeating(k = cDisHeat) annotation (
    Placement(transformation(extent = {{-130, 102}, {-110, 122}})));
  Modelica.Blocks.Sources.Constant Constant(k = -30) annotation (
    Placement(visible = true, transformation(origin = {-114, 75}, extent = {{-10, -11}, {10, 11}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant FixedCostsConnectionDistrictHeating(k = cConDisHeatFix)  annotation (
    Placement(visible = true, transformation(extent = {{-18, 94}, {2, 114}}, rotation = 0)));
  Modelica.Blocks.Math.Gain CostFactorConnectionDistrictHeating(k =  cConDisHeat) annotation (
    Placement(transformation(extent = {{-48, 62}, {-28, 82}})));
  Modelica.Blocks.Math.Gain CostFactorDistrictCooling(k= cDisCool) annotation (
    Placement(visible = true, transformation(extent = {{-130, 32}, {-110, 52}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant FixedCostsConnection_DistrictCooling(k = cConDisCoolFix) annotation (
    Placement(visible = true, transformation(extent = {{-46, -14}, {-26, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Gain CostFactorConnection_DistrictCooling(k = cConDisCool) annotation (
    Placement(visible = true, transformation(extent = {{-42, 16}, {-22, 36}}, rotation = 0)));
  Modelica.Blocks.Math.Gain CostFactorElectricity(k = cEl) annotation (
    Placement(visible = true, transformation(extent = {{12, -46}, {32, -26}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput EnergyCost annotation (
    Placement(transformation(extent = {{100, -10}, {120, 10}})));
  Modelica.Blocks.Math.MultiSum Sum_EnergyCost(nu = 4) annotation (
    Placement(visible = true, transformation(extent = {{68, -6}, {80, 6}}, rotation = 0)));
  Modelica.Blocks.Math.MultiSum Cost_DistrictCooling(nu = 2) annotation (
    Placement(visible = true, transformation(extent = {{28, 36}, {40, 48}}, rotation = 0)));
  Modelica.Blocks.Math.MultiSum PowerConnection_DistrictCooling(nu = 2) annotation (
    Placement(visible = true, transformation(extent = {{-74, 20}, {-62, 32}}, rotation = 0)));
  Modelica.Blocks.Math.MultiSum CostConnection_DistrictCooling(nu = 2) annotation (
    Placement(visible = true, transformation(extent = {{0, 20}, {12, 32}}, rotation = 0)));
  Modelica.Blocks.Math.MultiSum PowerConnection_DistrictHeating(nu = 2) annotation (
    Placement(transformation(extent = {{-76, 66}, {-64, 78}})));
  Modelica.Blocks.Math.MultiSum CostConnectio_DistrictHeating(nu = 2) annotation (
    Placement(transformation(extent = {{-6, 68}, {6, 80}})));
  Modelica.Blocks.Math.MultiSum Cost_DistrictHeating(nu = 2) annotation (
    Placement(transformation(extent = {{52, 70}, {64, 82}})));
  Modelica.Blocks.Math.Gain CostFactor_Fuel(k = cFuel) annotation (
    Placement(visible = true, transformation(extent = {{14, -86}, {34, -66}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant EnergyDemandOfDistrictCooling(k = 0) "Auxiliary Constant - to be replaced by corresponding connection measure bus - CostFactorDistrictCooling in case district cooling is used in model" annotation (
    Placement(visible = true, transformation(origin = {-154, 43}, extent = {{-10, -11}, {10, 11}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant EnergyDemandForDistrictHeating(k = 0) "auxiliary constant - to be replaced by corresponding connection measure bus - CostFactorDistrictHeating in case district heating is used in model" annotation (
    Placement(visible = true, transformation(origin = {-152, 111}, extent = {{-10, -11}, {10, 11}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant NominalPowerOfDistrictHeating(k = NomPowDisHeat)  annotation (
    Placement(visible = true, transformation(origin = {-152, 77}, extent = {{-10, -11}, {10, 11}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant NominalPowerOfDistrictCooling(k = NomPowDisCool)  annotation (
    Placement(visible = true, transformation(origin = {-124, 9}, extent = {{-10, -11}, {10, 11}}, rotation = 0)));

equation
  connect(bus_measure.Total_Fuel, CostFactor_Fuel.u) annotation (
    Line(points = {{-159.95, 0.05}, {-153, 0.05}, {-153, -36}, {-154, -36}, {-154, -76}, {12, -76}}, color = {0, 0, 127}));
  connect(bus_measure.Total_Power, CostFactorElectricity.u) annotation (
    Line(points = {{-159.95, 0.05}, {-154, 0.05}, {-154, -36}, {10, -36}}, color = {0, 0, 127}));
  connect(Cost_DistrictHeating.y, Sum_EnergyCost.u[3]) annotation (
    Line(points = {{65.02, 76}, {66, 76}, {66, -1.05}, {68, -1.05}}, color = {0, 0, 127}));
  connect(Cost_DistrictCooling.y, Sum_EnergyCost.u[2]) annotation (
    Line(points = {{41.02, 42}, {54.51, 42}, {54.51, 1.05}, {68, 1.05}}, color = {0, 0, 127}));
  connect(CostFactorElectricity.y, Sum_EnergyCost.u[1]) annotation (
    Line(points = {{33, -36}, {68, -36}, {68, 3.15}}, color = {0, 0, 127}));
  connect(Sum_EnergyCost.y, EnergyCost) annotation (
    Line(points = {{81.02, 0}, {110, 0}}, color = {0, 0, 127}));
  connect(Constant.y, PowerConnection_DistrictCooling.u[1]) annotation (
    Line(points = {{-103, 75}, {-103, 25.5}, {-74, 25.5}, {-74, 28.1}}, color = {0, 0, 127}));
  connect(PowerConnection_DistrictCooling.y, CostFactorConnection_DistrictCooling.u) annotation (
    Line(points = {{-60.98, 26}, {-44, 26}}, color = {0, 0, 127}));
  connect(CostFactorConnection_DistrictCooling.y, CostConnection_DistrictCooling.u[1]) annotation (
    Line(points = {{-21, 26}, {-10, 26}, {-10, 28.1}, {0, 28.1}}, color = {0, 0, 127}));
  connect(CostFactorDistrictCooling.y, Cost_DistrictCooling.u[1]) annotation (
    Line(points = {{-109, 42}, {-40, 42}, {-40, 44.1}, {28, 44.1}}, color = {0, 0, 127}));
  connect(FixedCostsConnectionDistrictHeating.y, CostConnectio_DistrictHeating.u[2]) annotation (
    Line(points = {{3, 104}, {-16, 104}, {-16, 71.9}, {-6, 71.9}}, color = {0, 0, 127}));
  connect(Constant.y, PowerConnection_DistrictHeating.u[1]) annotation (
    Line(points = {{-103, 75}, {-103, 74.5}, {-76, 74.5}, {-76, 74.1}}, color = {0, 0, 127}));
  connect(PowerConnection_DistrictHeating.y, CostFactorConnectionDistrictHeating.u) annotation (
    Line(points = {{-62.98, 72}, {-50, 72}}, color = {0, 0, 127}));
  connect(CostFactorConnectionDistrictHeating.y, CostConnectio_DistrictHeating.u[1]) annotation (
    Line(points = {{-27, 72}, {-18, 72}, {-18, 76.1}, {-6, 76.1}}, color = {0, 0, 127}));
  connect(CostConnectio_DistrictHeating.y, Cost_DistrictHeating.u[1]) annotation (
    Line(points = {{7.02, 74}, {30, 74}, {30, 78.1}, {52, 78.1}}, color = {0, 0, 127}));
  connect(CostFactorDistrictHeating.y, Cost_DistrictHeating.u[2]) annotation (
    Line(points = {{-109, 112}, {-28, 112}, {-28, 73.9}, {52, 73.9}}, color = {0, 0, 127}));
  connect(CostFactor_Fuel.y, Sum_EnergyCost.u[4]) annotation (
    Line(points = {{35, -76}, {68, -76}, {68, -3.15}}, color = {0, 0, 127}));
  connect(CostConnection_DistrictCooling.y, Cost_DistrictCooling.u[2]) annotation (
    Line(points = {{13.02, 26}, {16, 26}, {16, 24}, {28, 24}, {28, 39.9}}, color = {0, 0, 127}));
  connect(FixedCostsConnection_DistrictCooling.y, CostConnection_DistrictCooling.u[2]) annotation (
    Line(points = {{-25, -4}, {-4, -4}, {-4, 23.9}, {4.44089e-16, 23.9}}, color = {0, 0, 127}));
  connect(EnergyDemandOfDistrictCooling.y, CostFactorDistrictCooling.u) annotation (
    Line(points = {{-143, 43}, {-132, 43}, {-132, 42}}, color = {0, 0, 127}));
  connect(EnergyDemandForDistrictHeating.y, CostFactorDistrictHeating.u) annotation (
    Line(points = {{-141, 111}, {-137.5, 111}, {-137.5, 112}, {-132, 112}}, color = {0, 0, 127}));
  connect(NominalPowerOfDistrictHeating.y, PowerConnection_DistrictHeating.u[2]) annotation (
    Line(points = {{-141, 77}, {-132, 77}, {-132, 56}, {-84, 56}, {-84, 69.9}, {-76, 69.9}}, color = {0, 0, 127}));
  connect(NominalPowerOfDistrictCooling.y, PowerConnection_DistrictCooling.u[2]) annotation (
    Line(points = {{-113, 9}, {-78, 9}, {-78, 23.9}, {-74, 23.9}}, color = {0, 0, 127}));
  annotation (Diagram(graphics={Text(
            extent={{-106,12},{-1,52}},
            lineColor={0,0,255},
            textString=""), Text(
            extent={{-106,-18},{-1,-58}},
            lineColor={0,0,255},
            textString="")}), Icon(coordinateSystem(preserveAspectRatio=false,
            extent={{-150,-100},{100,100}}), graphics={
          Rectangle(extent={{-150,100},{100,-100}}, lineColor={0,0,255}),
          Text(
            lineColor={0,0,255},
            extent={{-150,110},{150,150}},
            textString=""),
          Text(
            lineColor={0,0,255},
            extent={{-38,-34},{38,34}},
            textString=""),
          Text(
            extent={{-74,-18},{31,22}},
            textString="Energy Costs",
            lineColor={0,0,255}),
          Text(extent={{-100,-92},{5,-52}}, textString="")}));
end EnergyCosts;

  model EmissionsCosts "calculating the costs for emissions as part of the operational costs to evaluate the performance of a control strategy according to CCCS evaluation method"
    Modelica.Blocks.Math.Gain EmissionsFactorDistrictHeating(k = eDisHeat) annotation (
      Placement(transformation(extent = {{-38, 24}, {-18, 44}})));
    Modelica.Blocks.Math.Gain EmissionsFactorDistrictCooling(k = eDisCool) annotation (
      Placement(transformation(extent = {{-40, -10}, {-20, 10}})));
    Modelica.Blocks.Math.Gain EmissionsFactorElectricity(k = eEl) annotation (
      Placement(transformation(extent = {{-38, -44}, {-18, -24}})));
    Modelica.Blocks.Math.Gain CostFactorEmissions(k = cEm) annotation (
      Placement(transformation(extent = {{28, -10}, {48, 10}})));
    Modelica.Blocks.Interfaces.RealOutput Emission_Cost annotation (
      Placement(transformation(extent = {{100, -10}, {120, 10}})));
    Modelica.Blocks.Math.Gain EmissionsFactorFuel(k = eFuel) annotation (
      Placement(visible = true, transformation(extent = {{-38, -80}, {-18, -60}}, rotation = 0)));
    Modelica.Blocks.Math.MultiSum Emissions(nu = 4) annotation (
      Placement(visible = true, transformation(origin = {4, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant EnergyDemandForDistrictHeating(k = 0) "auxiliary constabt - to be replaced by corresponding connection measure bus - EmissionsFactorDistrictHeating in case district heating is used in model" annotation (
      Placement(visible = true, transformation(origin = {-68, 35}, extent = {{-10, -11}, {10, 11}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant EnergyDemandForDistrictCooling(k = 0) "auxiliary constant - to be replaced by corresponding connection measure bus - EmissionsFactorDistrictCooling in case district cooling is used in model" annotation (
      Placement(visible = true, transformation(origin = {-68, -1}, extent = {{-10, -11}, {10, 11}}, rotation = 0)));
  parameter Real eFuel=0.2001 "emissions factor fuel [kg/kWh]";
  parameter Real eEl=0.474 "emissions factor electricity [kg/kWh]";
  parameter Real eDisHeat=0.2 "emissions factor district heating [kg/kWh]";
  parameter Real eDisCool=0.527 "emissions factor district cooling [kg/kWh]";
  parameter Real cEm=0.0242 "cost factor emissions [€/kg]";

  equation
    connect(Emissions.y, CostFactorEmissions.u) annotation (
      Line(points = {{15.7, 0}, {24, 0}, {24, 0}, {26, 0}}, color = {0, 0, 127}));
    connect(bus_measure.Total_Fuel, EmissionsFactorFuel.u) annotation (
      Line(points = {{-99.95, 0.05}, {-99.95, 0.05}, {-99.95, -70}, {-40, -70}, {-40, -70}}, color = {0, 0, 127}));
    connect(bus_measure.Total_Power, EmissionsFactorElectricity.u) annotation (
      Line(points = {{-99.95, 0.05}, {-99.95, -34}, {-40, -34}}, color = {0, 0, 127}));
    connect(CostFactorEmissions.y, Emission_Cost) annotation (
      Line(points = {{49, 0}, {110, 0}}, color = {0, 0, 127}));
    connect(Emission_Cost, Emission_Cost) annotation (
      Line(points = {{110, 0}, {110, 0}}, color = {0, 0, 127}));
    connect(EmissionsFactorDistrictHeating.y, Emissions.u[1]) annotation (
      Line(points = {{-17, 34}, {-10, 34}, {-10, 5.25}, {-6, 5.25}}, color = {0, 0, 127}));
    connect(EmissionsFactorDistrictCooling.y, Emissions.u[2]) annotation (
      Line(points = {{-19, 0}, {-12, 0}, {-12, 1.75}, {-6, 1.75}}, color = {0, 0, 127}));
    connect(EmissionsFactorElectricity.y, Emissions.u[3]) annotation (
      Line(points = {{-17, -34}, {-6, -34}, {-6, -1.75}}, color = {0, 0, 127}));
    connect(EmissionsFactorFuel.y, Emissions.u[4]) annotation (
      Line(points = {{-17, -70}, {-6, -70}, {-6, -5.25}}, color = {0, 0, 127}));
    connect(EnergyDemandForDistrictHeating.y, EmissionsFactorDistrictHeating.u) annotation (
      Line(points = {{-57, 35}, {-40, 35}, {-40, 34}}, color = {0, 0, 127}));
    connect(EnergyDemandForDistrictCooling.y, EmissionsFactorDistrictCooling.u) annotation (
      Line(points = {{-57, -1}, {-54, -1}, {-54, 0}, {-42, 0}}, color = {0, 0, 127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,255}), Text(
            extent={{-62,14},{74,-14}},
            lineColor={0,0,255},
            textString="Emissions Costs")}),
        Diagram(coordinateSystem(preserveAspectRatio=false),graphics={Rectangle(
            extent={{308,-308},{788,354}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid)}));
  end EmissionsCosts;

  model PerformanceReductionCosts "calculating the costs due to reduced performance of employees caused by reduced air quality as part of the operational costs to evaluate the performance of a control strategy according to CCCS evaluation method"
    Modelica.Blocks.Sources.Constant Tset(k = TSet) annotation (
      Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant Tset_workshop(k = TSetWorkshop) annotation (
      Placement(visible = true, transformation(origin = {-90, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.MultiSum multiSum1(k={1,1,1,1,1}, nu=5)
                                            annotation (
      Placement(visible = true, transformation(origin = {0, -84}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Interfaces.RealOutput PRC annotation (
      Placement(visible = true, transformation(origin={108,-70},   extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin={108,-70},   extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Feedback feedback1[5] annotation (
      Placement(visible = true, transformation(origin = {0, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.Constant const(k = 1) annotation (
      Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Math.Feedback feedback2[5] annotation (
      Placement(visible = true, transformation(origin = {0, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.Constant salary_per_annum(k = sal) annotation (
      Placement(visible = true, transformation(origin = {90, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.Constant productivity_factor(k = prodFac) annotation (
      Placement(visible = true, transformation(origin = {90, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.Constant const1(k = 1 / (233 * 8 * 60)) annotation (
      Placement(visible = true, transformation(origin = {90, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Continuous.Integrator integrator1[5](k={1,1,1,1,1}, each use_reset=
         true)                                           annotation (
      Placement(visible = true, transformation(origin={0,-20},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    LRM lrm[5] annotation (
      Placement(visible = true, transformation(origin = {2, 80}, extent = {{-40, -18}, {40, 18}}, rotation = 0)));
  parameter Real prodFac = 1.2 "productivity factor [-]";
  parameter Real sal = 50000 "average salary of employee per annum [€]";
  parameter Real TSet=293.14 "set room temperature [K]";
  parameter Real TSetWorkshop=288.15 "set room temperature for workshop [K]";

    Modelica.Blocks.Sources.BooleanExpression booleanExpression[5](each y=true)
      annotation (Placement(transformation(extent={{-84,-36},{-64,-16}})));
    Modelica.Blocks.Math.MultiProduct multiProduct[5](each nu=4) annotation (Placement(
          transformation(
          extent={{-6,-6},{6,6}},
          rotation=270,
          origin={0,-56})));
  equation

    connect(multiSum1.y, PRC) annotation (
      Line(points={{0,-95.7},{54,-95.7},{54,-70},{108,-70}},                           color = {0, 0, 127}));
    connect(const.y, feedback2[5].u1) annotation (
      Line(points={{79,90},{44,90},{44,10},{8,10}},          color = {0, 0, 127}));
    connect(const.y, feedback2[4].u1) annotation (
      Line(points={{79,90},{44,90},{44,10},{8,10}},          color = {0, 0, 127}));
    connect(const.y, feedback2[3].u1) annotation (
      Line(points={{79,90},{44,90},{44,10},{8,10}},          color = {0, 0, 127}));
    connect(const.y, feedback2[2].u1) annotation (
      Line(points={{79,90},{44,90},{44,10},{8,10}},          color = {0, 0, 127}));
    connect(const.y, feedback2[1].u1) annotation (
      Line(points = {{79, 90}, {44, 90}, {44, 10}, {8, 10}}, color = {0, 0, 127}));
    connect(feedback1[5].y, feedback2[5].u2) annotation (
      Line(points={{-9,40},{-26,40},{-26,20},{0,20},{0,18}},             color = {0, 0, 127}, thickness = 0.5));
    connect(feedback1[4].y, feedback2[4].u2) annotation (
      Line(points={{-9,40},{-26,40},{-26,20},{0,20},{0,18}},             color = {0, 0, 127}, thickness = 0.5));
    connect(feedback1[3].y, feedback2[3].u2) annotation (
      Line(points={{-9,40},{-26,40},{-26,20},{0,20},{0,18}},             color = {0, 0, 127}, thickness = 0.5));
    connect(feedback1[2].y, feedback2[2].u2) annotation (
      Line(points={{-9,40},{-26,40},{-26,20},{0,20},{0,18}},             color = {0, 0, 127}, thickness = 0.5));
    connect(feedback1[1].y, feedback2[1].u2) annotation (
      Line(points={{-9,40},{-26,40},{-26,20},{2,20},{2,18},{0,18}},               color = {0, 0, 127}, thickness = 0.5));
    connect(const.y, feedback1[5].u1) annotation (
      Line(points = {{79, 90}, {44, 90}, {44, 40}, {8, 40}}, color = {0, 0, 127}));
    connect(const.y, feedback1[4].u1) annotation (
      Line(points = {{79, 90}, {44, 90}, {44, 40}, {8, 40}}, color = {0, 0, 127}));
    connect(const.y, feedback1[3].u1) annotation (
      Line(points = {{79, 90}, {44, 90}, {44, 40}, {8, 40}}, color = {0, 0, 127}));
    connect(const.y, feedback1[2].u1) annotation (
      Line(points = {{79, 90}, {44, 90}, {44, 40}, {8, 40}}, color = {0, 0, 127}));
    connect(const.y, feedback1[1].u1) annotation (
      Line(points = {{79, 90}, {44, 90}, {44, 40}, {8, 40}}, color = {0, 0, 127}));
  connect(lrm[5].PRC, feedback1[5].u2) annotation (
      Line(points={{0.6,61.2},{0.6,61.2},{0.6,48},{0,48}},color = {0, 0, 127}, thickness = 0.5));
  connect(lrm[4].PRC, feedback1[4].u2) annotation (
      Line(points={{0.6,61.2},{0.6,61.2},{0.6,48},{0,48}},color = {0, 0, 127}, thickness = 0.5));
  connect(lrm[3].PRC, feedback1[3].u2) annotation (
      Line(points={{0.6,61.2},{0.6,61.2},{0.6,48},{0,48}},color = {0, 0, 127}, thickness = 0.5));
  connect(lrm[2].PRC, feedback1[2].u2) annotation (
      Line(points={{0.6,61.2},{0.6,61.2},{0.6,48},{0,48}},color = {0, 0, 127}, thickness = 0.5));
  connect(lrm[1].PRC, feedback1[1].u2) annotation (
      Line(points={{0.6,61.2},{0.6,61.2},{0.6,48},{0,48}},color = {0, 0, 127}, thickness = 0.5));
  connect(bus_measure.X_OpenplanOffice, lrm[5].X) annotation (
      Line(points={{-99.95,-1.95},{-56,-1.95},{-56,72},{-38,72},{-38,73},{-38,73}},      color = {255, 204, 51}, thickness = 0.5));
  connect(bus_measure.X_Multipersonoffice, lrm[4].X) annotation (
      Line(points={{-99.95,-1.95},{-56,-1.95},{-56,72},{-38,72},{-38,73},{-38,73}},      color = {255, 204, 51}, thickness = 0.5));
  connect(bus_measure.X_Conferenceroom, lrm[3].X) annotation (
      Line(points={{-99.95,-1.95},{-56,-1.95},{-56,72},{-40,72},{-40,73},{-38,73}},      color = {255, 204, 51}, thickness = 0.5));
  connect(bus_measure.X_Workshop, lrm[2].X) annotation (
      Line(points={{-99.95,-1.95},{-56,-1.95},{-56,72},{-40,72},{-40,73},{-38,73}},      color = {255, 204, 51}, thickness = 0.5));
  connect(bus_measure.X_Canteen, lrm[1].X) annotation (
      Line(points={{-99.95,-1.95},{-56,-1.95},{-56,72},{-38,72},{-38,73},{-38,73}},      color = {255, 204, 51}, thickness = 0.5));
  connect(bus_measure.RoomTemp_Openplanoffice, lrm[5].T) annotation (
      Line(points={{-99.95,-1.95},{-56,-1.95},{-56,88},{-38,88},{-38,87.2},{-38,87.2}},  color = {255, 204, 51}, thickness = 0.5));
  connect(bus_measure.RoomTemp_Multipersonoffice, lrm[4].T) annotation (
      Line(points={{-99.95,-1.95},{-56,-1.95},{-56,88},{-40,88},{-40,87.2},{-38,87.2}},  color = {255, 204, 51}, thickness = 0.5));
  connect(bus_measure.RoomTemp_Conferenceroom, lrm[3].T) annotation (
      Line(points={{-99.95,-1.95},{-56,-1.95},{-56,88},{-38,88},{-38,87.2},{-38,87.2}},  color = {255, 204, 51}, thickness = 0.5));
  connect(bus_measure.RoomTemp_Workshop, lrm[2].T) annotation (
      Line(points={{-99.95,-1.95},{-56,-1.95},{-56,88},{-38,88},{-38,87.2},{-38,87.2}},  color = {255, 204, 51}, thickness = 0.5));
  connect(bus_measure.RoomTemp_Canteen, lrm[1].T) annotation (
      Line(points={{-99.95,-1.95},{-56,-1.95},{-56,88},{-38,88},{-38,87.2},{-38,87.2}},  color = {255, 204, 51}, thickness = 0.5));
  connect(Tset.y, lrm[5].Tset) annotation (
      Line(points={{-79,90},{-56,90},{-56,80},{-38,80},{-38,80},{-38,80}},              color = {0, 0, 127}));
  connect(Tset.y, lrm[4].Tset) annotation (
      Line(points={{-79,90},{-56,90},{-56,80},{-38,80},{-38,80},{-38,80}},              color = {0, 0, 127}));
  connect(Tset_workshop.y, lrm[2].Tset) annotation (
      Line(points={{-79,50},{-56,50},{-56,80},{-38,80},{-38,80},{-38,80},{-38,80}},                color = {0, 0, 127}));
  connect(Tset.y, lrm[3].Tset) annotation (
      Line(points={{-79,90},{-56,90},{-56,80},{-38,80},{-38,80},{-38,80}},              color = {0, 0, 127}));
  connect(Tset.y, lrm[1].Tset) annotation (
      Line(points={{-79,90},{-56,90},{-56,80},{-38,80},{-38,80}},            color = {0, 0, 127}));
    connect(booleanExpression[1].y, integrator1[1].reset) annotation (Line(points={{-63,-26},
            {-12,-26}},                              color={255,0,255}));
    connect(booleanExpression[2].y, integrator1[2].reset) annotation (Line(points={{-63,-26},
            {-12,-26}},                              color={255,0,255}));
    connect(booleanExpression[3].y, integrator1[3].reset) annotation (Line(points={{-63,-26},
            {-12,-26}},                              color={255,0,255}));
    connect(booleanExpression[4].y, integrator1[4].reset) annotation (Line(points={{-63,-26},
            {-12,-26}},                              color={255,0,255}));
    connect(booleanExpression[4].y, integrator1[4].reset) annotation (Line(points={{-63,-26},
            {-12,-26}},                              color={255,0,255}));
    connect(booleanExpression[5].y, integrator1[5].reset) annotation (Line(points={{-63,-26},
            {-12,-26}},                              color={255,0,255}));

    connect(feedback2[1].y, integrator1[1].u) annotation (Line(points={{-9,10},{-26,
            10},{-26,-8},{0,-8}}, color={0,0,127}));
    connect(feedback2[2].y, integrator1[2].u) annotation (Line(points={{-9,10},{-26,
            10},{-26,-8},{0,-8}}, color={0,0,127}));
    connect(feedback2[3].y, integrator1[3].u) annotation (Line(points={{-9,10},{-26,
            10},{-26,-8},{2.22045e-15,-8}}, color={0,0,127}));
    connect(feedback2[4].y, integrator1[4].u) annotation (Line(points={{-9,10},{-26,
            10},{-26,-8},{2.22045e-15,-8}}, color={0,0,127}));
    connect(feedback2[5].y, integrator1[5].u) annotation (Line(points={{-9,10},{-26,
            10},{-26,-8},{0,-8}}, color={0,0,127}));

    connect(integrator1[1].y, multiProduct[1].u[1]) annotation (Line(points={{0,-31},
            {0,-48},{-4,-48},{-4,-50},{3.15,-50}},  color={0,0,127}));
    connect(salary_per_annum.y, multiProduct[1].u[2]) annotation (Line(points={{79,52},
            {60,52},{60,-52},{1.05,-52},{1.05,-50}},     color={0,0,127}));
    connect(productivity_factor.y, multiProduct[1].u[3]) annotation (Line(points={{79,10},
            {60,10},{60,-52},{-3.5,-52},{-3.5,-50},{-1.05,-50}},      color={0,0,127}));
    connect(const1.y, multiProduct[1].u[4]);
    connect(integrator1[2].y, multiProduct[2].u[1]) annotation (Line(points={{0,-31},
            {0,-48},{-4,-48},{-4,-50},{3.15,-50}},  color={0,0,127}));
    connect(salary_per_annum.y, multiProduct[2].u[2]) annotation (Line(points={{79,52},
            {60,52},{60,-52},{1.05,-52},{1.05,-50}},     color={0,0,127}));
    connect(productivity_factor.y, multiProduct[2].u[3]) annotation (Line(points={{79,10},
            {60,10},{60,-52},{-3.5,-52},{-3.5,-50},{-1.05,-50}},      color={0,0,127}));
    connect(const1.y, multiProduct[2].u[4]) annotation (Line(points={{79,-32},{74,
            -32},{74,-34},{60,-34},{60,-52},{-2.4,-52},{-2.4,-50},{-3.15,-50}},
                                                                            color=
           {0,0,127}));
    connect(integrator1[3].y, multiProduct[3].u[1]) annotation (Line(points={{0,-31},
            {0,-48},{-4,-48},{-4,-50},{3.15,-50}},  color={0,0,127}));
    connect(salary_per_annum.y, multiProduct[3].u[2]) annotation (Line(points={{79,52},
            {60,52},{60,-52},{1.05,-52},{1.05,-50}},     color={0,0,127}));
    connect(productivity_factor.y, multiProduct[3].u[3]) annotation (Line(points={{79,10},
            {60,10},{60,-52},{-3.5,-52},{-3.5,-50},{-1.05,-50}},      color={0,0,127}));
    connect(const1.y, multiProduct[3].u[4]) annotation (Line(points={{79,-32},{74,
            -32},{74,-34},{60,-34},{60,-52},{-2.4,-52},{-2.4,-50},{-3.15,-50}},
                                                                            color=
           {0,0,127}));
           connect(integrator1[4].y, multiProduct[4].u[1]) annotation (Line(points={{0,-31},
            {0,-48},{-4,-48},{-4,-50},{3.15,-50}},  color={0,0,127}));
    connect(salary_per_annum.y, multiProduct[4].u[2]) annotation (Line(points={{79,52},
            {60,52},{60,-52},{1.05,-52},{1.05,-50}},     color={0,0,127}));
    connect(productivity_factor.y, multiProduct[4].u[3]) annotation (Line(points={{79,10},
            {60,10},{60,-52},{-3.5,-52},{-3.5,-50},{-1.05,-50}},      color={0,0,127}));
    connect(const1.y, multiProduct[4].u[4]) annotation (Line(points={{79,-32},{74,
            -32},{74,-34},{60,-34},{60,-52},{-2.4,-52},{-2.4,-50},{-3.15,-50}},
                                                                            color=
           {0,0,127}));
      connect(integrator1[5].y, multiProduct[5].u[1]) annotation (Line(points={{0,-31},
            {0,-48},{-4,-48},{-4,-50},{3.15,-50}},  color={0,0,127}));
    connect(salary_per_annum.y, multiProduct[5].u[2]) annotation (Line(points={{79,52},
            {60,52},{60,-52},{1.05,-52},{1.05,-50}},     color={0,0,127}));
    connect(productivity_factor.y, multiProduct[5].u[3]) annotation (Line(points={{79,10},
            {60,10},{60,-52},{-3.5,-52},{-3.5,-50},{-1.05,-50}},      color={0,0,127}));
    connect(const1.y, multiProduct[5].u[4]) annotation (Line(points={{79,-32},{74,
            -32},{74,-34},{60,-34},{60,-52},{-2.4,-52},{-2.4,-50},{-3.15,-50}},
                                                                            color=
           {0,0,127}));
    connect(multiProduct[1].y, multiSum1.u[1]) annotation (Line(points={{0,-63.02},
            {0,-68},{0,-74},{5.6,-74}},  color={0,0,127}));
            connect(multiProduct[2].y, multiSum1.u[2]) annotation (Line(points={{0,
            -63.02},{0,-68},{0,-74},{2.8,-74}},
                                         color={0,0,127}));
            connect(multiProduct[3].y, multiSum1.u[3]) annotation (Line(points={{0,
            -63.02},{0,-68},{0,-74},{1.77636e-15,-74}},
                                         color={0,0,127}));
            connect(multiProduct[4].y, multiSum1.u[4]) annotation (Line(points={{0,
            -63.02},{0,-68},{0,-74},{-2.8,-74}},
                                         color={0,0,127}));
            connect(multiProduct[5].y, multiSum1.u[5]) annotation (Line(points={{0,-63.02},
            {0,-68},{0,-74},{-5.6,-74}}, color={0,0,127}));
      annotation (Line(points={{79,-32},{74,-32},{74,-34},{60,-34},{60,-52},{-2.4,
            -52},{-2.4,-50},{0.525,-50}}, color={0,0,127}), Icon(
          coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Text(
            lineColor={0,0,255},
            extent={{-150,110},{150,150}},
            textString=""),
          Text(
            extent={{-38,-34},{38,34}},
            textString="Performancem Reduction Costs",
            lineColor={0,0,255}),
          Text(extent={{-100,52},{5,92}}, textString=""),
          Text(extent={{-100,-92},{5,-52}}, textString=""),
          Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,255})}));
  end PerformanceReductionCosts;

  model LifespanReductionCosts "calculating costs of lifespan reduction due to wear as part of operating costs to evaluate the performance of a control strategy according to CCCS evaluation method"
    Real k = 60000 / 20.55 "number of switches per p.a. without wear";
    parameter Real K_valve = 1000
    "cost of a valve [€]";
    parameter Real K_pump = 3000
    "cost of a pump [€]";
    Real I_valve_ges;
    //overall number of switches of valves
    Real I_pump_ges;
    //overall number of switches of pumps
    Real i_Pump_Hotwater_y;
    //counter of hotwaterpump
    Real i_Pump_Warmwater_y "counter of warmwaterpump";
    Real i_Pump_Coldwater_y "counter of coldwaterpump";
    Real i_Pump_Coldwater_heatpump_y "counter of coldwaterpump on heatpumpside";
    Real i_Pump_Warmwater_heatpump_1_y "counter of warmwaterpump on heatpumpside";
    Real i_Pump_Warmwater_heatpump_2_y "counter of warmwaterpump on heatpumpside";
    Real i_Pump_Aircooler_y "counter of aircoolerpump";
    Real i_Pump_Hotwater_CHP_y "counter  of aircoolerpump";
    Real i_Pump_Hotwater_Boiler_y "counter of aircoolerpump";
    Real i_Pump_RLT_Central_hot_y "counter of hotwaterpump of the central RLT";
    Real i_Pump_RLT_OpenPlanOffice_hot_y "counter of hotwaterpump of the openplanoffice RLT";
    Real i_Pump_RLT_ConferenceRoom_hot_y "counter speed of hotwaterpump of the conferenceroom RLT";
    Real i_Pump_RLT_MultiPersonOffice_hot_y "counter of hotwaterpump of the multipersonoffice RLT";
    Real i_Pump_RLT_Canteen_hot_y "counter of hotwaterpump of the canteen RLT";
    Real i_Pump_RLT_Workshop_hot_y "counter of hotwaterpump of the workshop RLT";
    Real i_Pump_RLT_Central_cold_y "counter of coldwaterpump of the central RLT";
    Real i_Pump_RLT_OpenPlanOffice_cold_y "counter of coldwaterpump of the openplanoffice RLT";
    Real i_Pump_RLT_ConferenceRoom_cold_y "counter of coldwaterpump of the conferenceroom RLT";
    Real i_Pump_RLT_MultiPersonOffice_cold_y "counter of coldwaterpump of the multipersonoffice";
    Real i_Pump_RLT_Canteen_cold_y "counter of coldwaterpump of the canteen RLT";
    Real i_Pump_RLT_Workshop_cold_y "counter of coldwaterpump of the workshop RLT";
    Real i_Pump_TBA_OpenPlanOffice_y "counter of waterpump of the openplanoffice TBA";
    Real i_Pump_TBA_ConferenceRoom_y "counter of waterpump of the conferenceroom TBA";
    Real i_Pump_TBA_MultiPersonOffice_y "counter of waterpump of the multipersonoffice TBA";
    Real i_Pump_TBA_Canteen_y "counter of waterpump of the canteen TBA";
    Real i_Pump_TBA_Workshop_y "counter of waterpump of the workshop TBA";
    Real i_Valve1 "counter of Valve1 (Coldwater geothermalprobe)";
    Real i_Valve2 "counter of Valve2 (Coldwater coldwater bufferstorage)";
    Real i_Valve3 "counter of Valve3 (Coldwater heatexchanger)";
    Real i_Valve4 "counter of Valve4 (Warmwater heatexchanger)";
    Real i_Valve5 "counter of Valve5 (Warmwater warmwater bufferstorage)";
    Real i_Valve6 "counter of Valve6 (Hotwater boiler)";
    Real i_Valve7 "counter of Valve7 (Hotwater warmwater bufferstorage)";
    Real i_Valve8 "counter of Valve8 (Aircooler)";
    Real i_Valve_RLT_Hot_Central "counter of valve to control the hotwater-temperature to the Central";
    Real i_Valve_RLT_Hot_OpenPlanOffice "counter of valve to control the hotwater-temperature to the OpenPlanOffice";
    Real i_Valve_RLT_Hot_ConferenceRoom "counter of valve to control the hotwater-temperature to the ConferenceRoom";
    Real i_Valve_RLT_Hot_MultiPersonOffice "counter of valve to control the hotwater-temperature to the MultiPersonOffice";
    Real i_Valve_RLT_Hot_Canteen "counter of valve to control the hotwater-temperature to the canteen";
    Real i_Valve_RLT_Hot_Workshop "counter of valve to control the hotwater-temperature to the workshop";
    Real i_Valve_RLT_Cold_Central "counter of valve to control the coldwater-temperature to the Central";
    Real i_Valve_RLT_Cold_OpenPlanOffice "counter of valve to control the coldwater-temperature to the OpenPlanOffice";
    Real i_Valve_RLT_Cold_ConferenceRoom "counter of valve to control the coldwater-temperature to the ConferenceRoom";
    Real i_Valve_RLT_Cold_MultiPersonOffice "counter of valve to control the coldwater-temperature to the MultiPersonOffice";
    Real i_Valve_RLT_Cold_Canteen "counter of valve to control the coldwater-temperature to the canteen";
    Real i_Valve_RLT_Cold_Workshop "counter of valve to control the coldwater-temperature to the workshop";
    Real i_Valve_TBA_Warm_OpenPlanOffice "counter of valve for warm or cold of the openplanoffice";
    Real i_Valve_TBA_Warm_conferenceroom "counter of valve for warm or cold of the conferenceroom";
    Real i_Valve_TBA_Warm_multipersonoffice "counter of valve for warm or cold of the multipersonoffice";
    Real i_Valve_TBA_Warm_canteen "Vcounter of valve for warm or cold of the canteen";
    Real i_Valve_TBA_Warm_workshop "counter of valve for warm or cold of the workshop";
    Real i_Valve_TBA_OpenPlanOffice_Temp "counter of valve to control the temperature to the OpenPlanOffice";
    Real i_Valve_TBA_ConferenceRoom_Temp "counter of valve to control the temperature to the ConferenceRoom";
    Real i_Valve_TBA_MultiPersonOffice_Temp "counter of valve to control the temperatur to the MultiPersonOffice";
    Real i_Valve_TBA_Canteen_Temp "counter of valve to control the temperature to the canteen";
    Real i_Valve_TBA_Workshop_Temp "counter of valve to control the temperature to the workshop";
    Modelica.Blocks.Interfaces.RealOutput y annotation (
      Placement(visible = true, transformation(origin = {96, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {96, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    //overall number of switches of pumps

     Modelica.Blocks.Routing.RealPassThrough Speed_Pumps[26]
      annotation (Placement(transformation(extent={{-42,-62},{-16,-36}})));

    Modelica.Blocks.Routing.RealPassThrough Pos_Valves[30]
      annotation (Placement(transformation(extent={{-30,-4},{-10,16}})));
  equation
    when (I_valve_ges / 56) * 365 - 30 * k > 0 and (I_pump_ges / 56) * 365 - 26 * k > 0 then
      y = K_valve * ((I_valve_ges / 56) * 365 - 30 * k) + K_pump * ((I_pump_ges / 56) * 365 - 26 * k);
    end when;

    I_pump_ges = i_Pump_Hotwater_y + i_Pump_Warmwater_y + i_Pump_Coldwater_y + i_Pump_Coldwater_heatpump_y + i_Pump_Warmwater_heatpump_1_y + i_Pump_Warmwater_heatpump_2_y + i_Pump_Aircooler_y + i_Pump_Hotwater_CHP_y + i_Pump_Hotwater_Boiler_y + i_Pump_TBA_OpenPlanOffice_y + i_Pump_TBA_ConferenceRoom_y + i_Pump_TBA_MultiPersonOffice_y + i_Pump_TBA_Canteen_y + i_Pump_TBA_Workshop_y + i_Pump_RLT_Central_hot_y + i_Pump_RLT_OpenPlanOffice_hot_y + i_Pump_RLT_ConferenceRoom_hot_y + i_Pump_RLT_MultiPersonOffice_hot_y + i_Pump_RLT_Canteen_hot_y + i_Pump_RLT_Workshop_hot_y + i_Pump_RLT_Central_cold_y + i_Pump_RLT_OpenPlanOffice_cold_y + i_Pump_RLT_ConferenceRoom_cold_y + i_Pump_RLT_MultiPersonOffice_cold_y + i_Pump_RLT_Canteen_cold_y + i_Pump_RLT_Workshop_cold_y;
    I_valve_ges = i_Valve1 + i_Valve2 + i_Valve3 + i_Valve4 + i_Valve5 + i_Valve6 + i_Valve7 + i_Valve8 + i_Valve_RLT_Hot_Central + i_Valve_RLT_Hot_OpenPlanOffice + i_Valve_RLT_Hot_ConferenceRoom + i_Valve_RLT_Hot_MultiPersonOffice + i_Valve_RLT_Hot_Canteen + i_Valve_RLT_Hot_Workshop + i_Valve_RLT_Cold_Central + i_Valve_RLT_Cold_OpenPlanOffice + i_Valve_RLT_Cold_ConferenceRoom + i_Valve_RLT_Cold_MultiPersonOffice + i_Valve_RLT_Cold_Canteen + i_Valve_RLT_Cold_Workshop + i_Valve_TBA_Warm_OpenPlanOffice + i_Valve_TBA_Warm_conferenceroom + i_Valve_TBA_Warm_multipersonoffice + i_Valve_TBA_Warm_canteen + i_Valve_TBA_Warm_workshop + i_Valve_TBA_OpenPlanOffice_Temp + i_Valve_TBA_ConferenceRoom_Temp + i_Valve_TBA_MultiPersonOffice_Temp + i_Valve_TBA_Canteen_Temp + i_Valve_TBA_Workshop_Temp;

      when abs(der(Speed_Pumps[1].y))>0 then
      i_Pump_Hotwater_y = pre(i_Pump_Hotwater_y) + 1;end when;

      when abs(der(Speed_Pumps[2].y))>0 then
      i_Pump_Warmwater_y = pre(i_Pump_Warmwater_y) + 1;
    end when;

      when abs(der(Speed_Pumps[3].y))>0 then
      i_Pump_Coldwater_y = pre(i_Pump_Coldwater_y) + 1;
    end when;

      when abs(der(Speed_Pumps[4].y))>0 then
      i_Pump_Coldwater_heatpump_y = pre(i_Pump_Coldwater_heatpump_y) + 1;
    end when;

      when abs(der(Speed_Pumps[5].y))>0 then
      i_Pump_Warmwater_heatpump_1_y = pre(i_Pump_Warmwater_heatpump_1_y) + 1;
    end when;

      when abs(der(Speed_Pumps[6].y))>0 then
      i_Pump_Warmwater_heatpump_2_y = pre(i_Pump_Warmwater_heatpump_2_y) + 1;
    end when;

      when abs(der(Speed_Pumps[7].y))>0 then
      i_Pump_Aircooler_y = pre(i_Pump_Aircooler_y) + 1;
    end when;

      when abs(der(Speed_Pumps[8].y))>0 then
      i_Pump_Hotwater_CHP_y = pre(i_Pump_Hotwater_CHP_y) + 1;
    end when;

      when abs(der(Speed_Pumps[9].y))>0 then
      i_Pump_Hotwater_Boiler_y = pre(i_Pump_Hotwater_Boiler_y) + 1;
    end when;

      when abs(der(Speed_Pumps[10].y))>0 then
      i_Pump_RLT_Central_hot_y = pre(i_Pump_RLT_Central_hot_y) + 1;
    end when;

      when abs(der(Speed_Pumps[11].y))>0 then
      i_Pump_RLT_OpenPlanOffice_hot_y = pre(i_Pump_RLT_OpenPlanOffice_hot_y) + 1;
    end when;

      when abs(der(Speed_Pumps[12].y))>0 then
      i_Pump_RLT_MultiPersonOffice_hot_y = pre(i_Pump_RLT_MultiPersonOffice_hot_y) + 1;
    end when;

      when abs(der(Speed_Pumps[13].y))>0 then
      i_Pump_RLT_ConferenceRoom_hot_y = pre(i_Pump_RLT_ConferenceRoom_hot_y) + 1;
    end when;

      when abs(der(Speed_Pumps[14].y))>0 then
      i_Pump_RLT_Canteen_hot_y = pre(i_Pump_RLT_Canteen_hot_y) + 1;
    end when;

      when abs(der(Speed_Pumps[15].y))>0 then
      i_Pump_RLT_Workshop_hot_y = pre(i_Pump_RLT_Workshop_hot_y) + 1;
    end when;

      when abs(der(Speed_Pumps[16].y))>0 then
      i_Pump_RLT_Workshop_cold_y = pre(i_Pump_RLT_Workshop_cold_y) + 1;
    end when;

      when abs(der(Speed_Pumps[17].y))>0 then
      i_Pump_RLT_Canteen_cold_y = pre(i_Pump_RLT_Canteen_cold_y) + 1;
    end when;

      when abs(der(Speed_Pumps[18].y))>0 then
      i_Pump_RLT_ConferenceRoom_cold_y = pre(i_Pump_RLT_ConferenceRoom_cold_y) + 1;
    end when;

      when abs(der(Speed_Pumps[19].y))>0 then
      i_Pump_RLT_OpenPlanOffice_cold_y = pre(i_Pump_RLT_OpenPlanOffice_cold_y) + 1;
    end when;

      when abs(der(Speed_Pumps[20].y))>0 then
      i_Pump_RLT_MultiPersonOffice_cold_y = pre(i_Pump_RLT_MultiPersonOffice_cold_y) + 1;
    end when;

      when abs(der(Speed_Pumps[21].y))>0 then
      i_Pump_RLT_Central_cold_y = pre(i_Pump_Hotwater_y) + 1;
    end when;

      when abs(der(Speed_Pumps[22].y))>0 then
      i_Pump_TBA_OpenPlanOffice_y = pre(i_Pump_TBA_OpenPlanOffice_y) + 1;
    end when;

      when abs(der(Speed_Pumps[23].y))>0 then
      i_Pump_TBA_ConferenceRoom_y = pre(i_Pump_TBA_ConferenceRoom_y) + 1;
    end when;

      when abs(der(Speed_Pumps[24].y))>0 then
      i_Pump_TBA_MultiPersonOffice_y = pre(i_Pump_TBA_MultiPersonOffice_y) + 1;
    end when;

      when abs(der(Speed_Pumps[25].y))>0 then
      i_Pump_TBA_Canteen_y = pre(i_Pump_TBA_Canteen_y) + 1;
    end when;

      when abs(der(Speed_Pumps[26].y))>0 then
      i_Pump_TBA_Workshop_y = pre(i_Pump_TBA_Workshop_y) + 1;
    end when;

    when abs(der(Pos_Valves[1].y))>0 then
      i_Valve1=pre(i_Valve1)+1;
    end when;

    when abs(der(Pos_Valves[2].y))>0 then
      i_Valve2 = pre(i_Valve2) + 1;
    end when;

    when abs(der(Pos_Valves[3].y))>0 then
      i_Valve3 = pre(i_Valve3) + 1;
    end when;

    when abs(der(Pos_Valves[4].y))>0 then
      i_Valve4 = pre(i_Valve4) + 1;
    end when;

    when abs(der(Pos_Valves[5].y))>0 then
      i_Valve5 = pre(i_Valve5) + 1;
    end when;

    when abs(der(Pos_Valves[6].y))>0 then
      i_Valve6 = pre(i_Valve6) + 1;
    end when;

    when abs(der(Pos_Valves[7].y))>0 then
      i_Valve7 = pre(i_Valve7) + 1;
    end when;
    when abs(der(Pos_Valves[8].y))>0 then
      i_Valve8 = pre(i_Valve8) + 1;
    end when;

    when abs(der(Pos_Valves[9].y))>0 then
      i_Valve_RLT_Hot_Central = pre(i_Valve_RLT_Hot_Central) + 1;
    end when;

    when abs(der(Pos_Valves[10].y))>0 then
      i_Valve_RLT_Hot_OpenPlanOffice = pre(i_Valve_RLT_Hot_OpenPlanOffice) + 1;
    end when;

    when abs(der(Pos_Valves[11].y))>0 then
      i_Valve_RLT_Hot_ConferenceRoom = pre(i_Valve_RLT_Hot_ConferenceRoom) + 1;
    end when;

    when abs(der(Pos_Valves[12].y))>0 then
      i_Valve_RLT_Hot_MultiPersonOffice = pre(i_Valve_RLT_Hot_MultiPersonOffice) + 1;
    end when;

    when abs(der(Pos_Valves[13].y))>0 then
      i_Valve_RLT_Hot_Workshop = pre(i_Valve_RLT_Hot_Workshop) + 1;
    end when;

    when abs(der(Pos_Valves[14].y))>0 then
      i_Valve_RLT_Hot_Canteen = pre(i_Valve_RLT_Hot_Canteen) + 1;
    end when;

    when abs(der(Pos_Valves[15].y))>0 then
      i_Valve_RLT_Cold_Canteen = pre(i_Valve_RLT_Cold_Canteen) + 1;
    end when;

    when abs(der(Pos_Valves[16].y))>0 then
      i_Valve_RLT_Cold_Workshop = pre(i_Valve_RLT_Cold_Workshop) + 1;
    end when;

    when abs(der(Pos_Valves[17].y))>0 then
      i_Valve_RLT_Cold_MultiPersonOffice = pre(i_Valve_RLT_Cold_MultiPersonOffice) + 1;
    end when;

      when abs(der(Pos_Valves[18].y))>0 then
      i_Valve_RLT_Cold_ConferenceRoom = pre(i_Valve_RLT_Cold_ConferenceRoom) + 1;
    end when;

    when abs(der(Pos_Valves[19].y))>0 then
      i_Valve_RLT_Cold_OpenPlanOffice = pre(i_Valve_RLT_Cold_OpenPlanOffice) + 1;
    end when;

    when abs(der(Pos_Valves[20].y))>0 then
      i_Valve_RLT_Cold_Central = pre(i_Valve_RLT_Cold_Central) + 1;
    end when;

    when abs(der(Pos_Valves[21].y))>0 then
      i_Valve_TBA_Warm_OpenPlanOffice = pre(i_Valve_TBA_Warm_OpenPlanOffice) + 1;
    end when;

      when abs(der(Pos_Valves[22].y))>0 then
      i_Valve_TBA_Warm_conferenceroom = pre(i_Valve_TBA_Warm_conferenceroom) + 1;
      end when;

    when abs(der(Pos_Valves[23].y))>0 then
      i_Valve_TBA_Warm_multipersonoffice = pre(i_Valve_TBA_Warm_multipersonoffice) + 1;
    end when;

    when abs(der(Pos_Valves[24].y))>0 then
      i_Valve_TBA_Warm_canteen = pre(i_Valve_TBA_Warm_canteen) + 1;
    end when;

    when abs(der(Pos_Valves[25].y))>0 then
      i_Valve_TBA_Warm_workshop = pre(i_Valve_TBA_Warm_workshop) + 1;
    end when;

    when abs(der(Pos_Valves[26].y))>0 then
      i_Valve_TBA_OpenPlanOffice_Temp = pre(i_Valve_TBA_OpenPlanOffice_Temp) + 1;
    end when;

    when abs(der(Pos_Valves[27].y))>0 then
      i_Valve_TBA_ConferenceRoom_Temp = pre(i_Valve_TBA_ConferenceRoom_Temp) + 1;
    end when;

    when abs(der(Pos_Valves[28].y))>0 then
      i_Valve_TBA_MultiPersonOffice_Temp = pre(i_Valve_TBA_MultiPersonOffice_Temp) + 1;
    end when;

    when abs(der(Pos_Valves[29].y))>0 then
      i_Valve_TBA_Canteen_Temp = pre(i_Valve_TBA_Canteen_Temp) + 1;
    end when;

    when abs(der(Pos_Valves[30].y))>0 then
      i_Valve_TBA_Workshop_Temp = pre(i_Valve_TBA_Workshop_Temp) + 1;
    end when;

    connect(bus_Control1.Valve1, Pos_Valves[1].u) annotation (Line(
        points={{-99.95,-1.95},{-99.95,6},{-32,6}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));

    connect(bus_Control1.Valve2, Pos_Valves[2].u) annotation (Line(
        points={{-99.95,-1.95},{-99.95,6},{-32,6}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));

    connect(bus_Control1.Valve3, Pos_Valves[3].u) annotation (Line(
        points={{-99.95,-1.95},{-99.95,6},{-32,6}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));

    connect(bus_Control1.Valve4, Pos_Valves[4].u) annotation (Line(
        points={{-99.95,-1.95},{-99.95,8},{-32,8},{-32,6}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));

    connect(bus_Control1.Valve5, Pos_Valves[5].u) annotation (Line(
        points={{-99.95,-1.95},{-99.95,6},{-32,6}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));

    connect(bus_Control1.Valve6, Pos_Valves[6].u) annotation (Line(
        points={{-99.95,-1.95},{-99.95,6},{-32,6}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(bus_Control1.Valve7, Pos_Valves[7].u) annotation (Line(
        points={{-99.95,-1.95},{-99.95,6},{-32,6}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));

    connect(bus_Control1.Valve8, Pos_Valves[8].u) annotation (Line(
        points={{-99.95,-1.95},{-99.95,8},{-32,8},{-32,6}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));

    connect(bus_Control1.Valve_RLT_Hot_Central, Pos_Valves[9].u) annotation (Line(
        points={{-99.95,-1.95},{-102,-1.95},{-102,6},{-32,6}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));

      connect(bus_Control1.Valve_RLT_Hot_OpenPlanOffice, Pos_Valves[10].u) annotation (Line(
        points={{-99.95,-1.95},{-102,-1.95},{-102,6},{-32,6}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));

        connect(bus_Control1.Valve_RLT_Hot_ConferenceRoom, Pos_Valves[11].u) annotation (Line(
        points={{-99.95,-1.95},{-102,-1.95},{-102,6},{-32,6}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));

        connect(bus_Control1.Valve_RLT_Hot_MultiPersonOffice, Pos_Valves[12].u) annotation (Line(
        points={{-99.95,-1.95},{-102,-1.95},{-102,6},{-32,6}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));

        connect(bus_Control1.Valve_RLT_Hot_Canteen, Pos_Valves[13].u) annotation (Line(
        points={{-99.95,-1.95},{-102,-1.95},{-102,6},{-32,6}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));

   connect(bus_Control1.Valve_RLT_Hot_Workshop, Pos_Valves[14].u) annotation (Line(
        points={{-99.95,-1.95},{-102,-1.95},{-102,6},{-32,6}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(bus_Control1.Valve_RLT_Cold_Central, Pos_Valves[15].u) annotation (Line(
        points={{-99.95,-1.95},{-102,-1.95},{-102,6},{-32,6}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));

      connect(bus_Control1.Valve_RLT_Cold_OpenPlanOffice, Pos_Valves[16].u) annotation (Line(
        points={{-99.95,-1.95},{-102,-1.95},{-102,6},{-32,6}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));

         connect(bus_Control1.Valve_RLT_Cold_ConferenceRoom, Pos_Valves[17].u) annotation (Line(
        points={{-99.95,-1.95},{-102,-1.95},{-102,6},{-32,6}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));

         connect(bus_Control1.Valve_RLT_Cold_MultiPersonOffice, Pos_Valves[18].u) annotation (Line(
        points={{-99.95,-1.95},{-102,-1.95},{-102,6},{-32,6}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));

         connect(bus_Control1.Valve_RLT_Cold_Canteen, Pos_Valves[19].u) annotation (Line(
        points={{-99.95,-1.95},{-102,-1.95},{-102,6},{-32,6}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));

         connect(bus_Control1.Valve_RLT_Cold_Workshop, Pos_Valves[20].u) annotation (Line(
        points={{-99.95,-1.95},{-102,-1.95},{-102,6},{-32,6}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));

    connect(bus_Control1.Valve_TBA_Warm_OpenPlanOffice, Pos_Valves[21].u)
      annotation (Line(
        points={{-99.95,-1.95},{-99.95,8},{-32,8},{-32,6}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));

        connect(bus_Control1.Valve_TBA_Warm_conferenceroom, Pos_Valves[22].u)
      annotation (Line(
        points={{-99.95,-1.95},{-99.95,6},{-32,6}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
        connect(bus_Control1.Valve_TBA_Warm_multipersonoffice, Pos_Valves[23].u)
      annotation (Line(
        points={{-99.95,-1.95},{-99.95,8},{-32,8},{-32,6}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
        connect(bus_Control1.Valve_TBA_Warm_canteen, Pos_Valves[24].u)
      annotation (Line(
        points={{-99.95,-1.95},{-99.95,8},{-32,8},{-32,6}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
        connect(bus_Control1.Valve_TBA_Warm_workshop, Pos_Valves[25].u)
      annotation (Line(
        points={{-99.95,-1.95},{-99.95,6},{-32,6}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));

    connect(bus_Control1.Valve_TBA_OpenPlanOffice_Temp, Pos_Valves[26].u)
      annotation (Line(
        points={{-99.95,-1.95},{-102,-1.95},{-102,8},{-32,8},{-32,6}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
         connect(bus_Control1.Valve_TBA_ConferenceRoom_Temp, Pos_Valves[27].u)
      annotation (Line(
        points={{-99.95,-1.95},{-102,-1.95},{-102,8},{-32,8},{-32,6}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
         connect(bus_Control1.Valve_TBA_MultiPersonOffice_Temp, Pos_Valves[28].u)
      annotation (Line(
        points={{-99.95,-1.95},{-102,-1.95},{-102,6},{-32,6}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
         connect(bus_Control1.Valve_TBA_Canteen_Temp, Pos_Valves[29].u)
      annotation (Line(
        points={{-99.95,-1.95},{-102,-1.95},{-102,6},{-32,6}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));

        connect(bus_Control1.Valve_TBA_Workshop_Temp, Pos_Valves[30].u)
      annotation (Line(
        points={{-99.95,-1.95},{-102,-1.95},{-102,6},{-32,6}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(bus_Control1.Pump_Hotwater_y, Speed_Pumps[1].u) annotation (Line(
        points={{-99.95,-1.95},{-99.95,-49},{-44.6,-49}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(bus_Control1.Pump_Warmwater_y, Speed_Pumps[2].u) annotation (Line(
        points={{-99.95,-1.95},{-99.95,-49},{-44.6,-49}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(bus_Control1.Pump_Coldwater_y, Speed_Pumps[3].u) annotation (Line(
        points={{-99.95,-1.95},{-99.95,-49},{-44.6,-49}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(bus_Control1.Pump_Coldwater_heatpump_y, Speed_Pumps[4].u) annotation (
        Line(
        points={{-99.95,-1.95},{-99.95,-50},{-44.6,-50},{-44.6,-49}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(bus_Control1.Pump_Warmwater_heatpump_1_y, Speed_Pumps[5].u) annotation (
       Line(
        points={{-99.95,-1.95},{-99.95,-49},{-44.6,-49}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(bus_Control1.Pump_Warmwater_heatpump_2_y, Speed_Pumps[6].u) annotation (
       Line(
        points={{-99.95,-1.95},{-99.95,-49},{-44.6,-49}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(bus_Control1.Pump_Aircooler_y, Speed_Pumps[7].u) annotation (Line(
        points={{-99.95,-1.95},{-99.95,-49},{-44.6,-49}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(bus_Control1.Pump_Hotwater_CHP_y, Speed_Pumps[8].u) annotation (Line(
        points={{-99.95,-1.95},{-102,-1.95},{-102,-50},{-44.6,-50},{-44.6,-49}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(bus_Control1.Pump_Hotwater_Boiler_y, Speed_Pumps[9].u) annotation (Line(
        points={{-99.95,-1.95},{-99.95,-50},{-44.6,-50},{-44.6,-49}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(bus_Control1.Pump_RLT_Central_hot_y, Speed_Pumps[10].u) annotation (
        Line(
        points={{-99.95,-1.95},{-99.95,-50},{-44.6,-50},{-44.6,-49}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));

    connect(bus_Control1.Pump_RLT_OpenPlanOffice_hot_y, Speed_Pumps[11].u)
      annotation (Line(
        points={{-99.95,-1.95},{-99.95,-49},{-44.6,-49}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));

    connect(bus_Control1.Pump_RLT_ConferenceRoom_hot_y, Speed_Pumps[12].u)
      annotation (Line(
        points={{-99.95,-1.95},{-102,-1.95},{-102,-48},{-44.6,-48},{-44.6,-49}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));

    connect(bus_Control1.Pump_RLT_MultiPersonOffice_hot_y, Speed_Pumps[13].u) annotation (
        Line(
        points={{-99.95,-1.95},{-99.95,-24},{-100,-24},{-100,-49},{-44.6,-49}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));

    connect(bus_Control1.Pump_RLT_Canteen_hot_y, Speed_Pumps[14].u) annotation (
        Line(
        points={{-99.95,-1.95},{-99.95,-24},{-102,-24},{-102,-49},{-44.6,-49}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));

    connect(bus_Control1.Pump_RLT_Workshop_hot_y, Speed_Pumps[15].u) annotation (
        Line(
        points={{-99.95,-1.95},{-99.95,-49},{-44.6,-49}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));

    connect(bus_Control1.Pump_RLT_Central_cold_y, Speed_Pumps[16].u) annotation (
        Line(
        points={{-99.95,-1.95},{-99.95,-49},{-44.6,-49}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));

    connect(bus_Control1.Pump_RLT_OpenPlanOffice_cold_y, Speed_Pumps[17].u)
      annotation (Line(
        points={{-99.95,-1.95},{-99.95,-50},{-44.6,-50},{-44.6,-49}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));

    connect(bus_Control1.Pump_RLT_ConferenceRoom_cold_y, Speed_Pumps[18].u)
      annotation (Line(
        points={{-99.95,-1.95},{-99.95,-49},{-44.6,-49}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));

    connect(bus_Control1.Pump_RLT_MultiPersonOffice_cold_y, Speed_Pumps[19].u)
      annotation (Line(
        points={{-99.95,-1.95},{-99.95,-49},{-44.6,-49}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(bus_Control1.Pump_RLT_Canteen_cold_y, Speed_Pumps[20].u) annotation (
        Line(
        points={{-99.95,-1.95},{-99.95,-49},{-44.6,-49}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));

    connect(bus_Control1.Pump_RLT_Workshop_cold_y, Speed_Pumps[21].u) annotation (
        Line(
        points={{-99.95,-1.95},{-99.95,-50},{-44.6,-50},{-44.6,-49}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));

    connect(bus_Control1.Pump_TBA_OpenPlanOffice_y, Speed_Pumps[22].u) annotation (
        Line(
        points={{-99.95,-1.95},{-99.95,-50},{-44.6,-50},{-44.6,-49}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(bus_Control1.Pump_TBA_ConferenceRoom_y, Speed_Pumps[23].u) annotation (
        Line(
        points={{-99.95,-1.95},{-99.95,-49},{-44.6,-49}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));

    connect(bus_Control1.Pump_TBA_MultiPersonOffice_y, Speed_Pumps[24].u)
      annotation (Line(
        points={{-99.95,-1.95},{-99.95,-50},{-44.6,-50},{-44.6,-49}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));

    connect(bus_Control1.Pump_TBA_Canteen_y, Speed_Pumps[25].u) annotation (Line(
        points={{-99.95,-1.95},{-99.95,-49},{-44.6,-49}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(bus_Control1.Pump_TBA_Workshop_y, Speed_Pumps[26].u) annotation (Line(
        points={{-99.95,-1.95},{-99.95,-49},{-44.6,-49}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));

    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Text(
            extent={{-56,24},{56,-18}},
            lineColor={0,0,255},
            textString="Lifespan Reductions Costs"), Rectangle(extent={{-100,
                100},{100,-100}}, lineColor={0,0,255})}), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end LifespanReductionCosts;

  model InvestmentCostsStrategy "calculating the investement costs to evaluate the performance of control strategies according to CCCS evaluation method"
    parameter Real G=50000 "Average salary of employee per annum [€]";

    Real E "effort to implement control strategy in months";

    parameter Real EAF=1.00  "effor adjustment factor";

    parameter Real KLOC=10 "approximate number of lines of code in thousands [-]";

    Real K_Strat;
    // costs for implementing control strategy

        Modelica.Blocks.Interfaces.RealOutput kStrat annotation (
      Placement(visible = true, transformation(origin = {102, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {102, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation

    E = 2.8 * KLOC ^ 1.2 * EAF;

  //Investment costs for implementing control strategy
    K_Strat = E * G / 12;

    kStrat=K_Strat;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,255}),
            Text(
            extent={{-72,16},{68,-16}},
            lineColor={0,0,255},
            textString="Investment Costs Strategy")}), Diagram(coordinateSystem(
            preserveAspectRatio=false)));
  end InvestmentCostsStrategy;

  model RBF
    Modelica.Blocks.Sources.Constant Constant2(k = 1) annotation (
      Placement(visible = true, transformation(origin = {-90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Product product annotation (
      Placement(visible = true, transformation(origin = {36, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant Constant3(k = -1) annotation (
      Placement(visible = true, transformation(origin = {-4, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add annotation (
      Placement(visible = true, transformation(origin = {44, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Division Prod annotation (
      Placement(visible = true, transformation(origin = {78, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add q annotation (
      Placement(visible = true, transformation(origin = {-48, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput RBF annotation (
      Placement(visible = true, transformation(extent = {{100, -66}, {120, -46}}, rotation = 0), iconTransformation(extent = {{100, -66}, {120, -46}}, rotation = 0)));
    AixLib.Systems.Benchmark_fb.BenchmarkModel_reworked_Modularization.CCCS.discountingFactor
      discountingFactor1 annotation (Placement(visible=true, transformation(
          origin={-10,-40},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    Modelica.Blocks.Sources.Constant Rate(k = i) annotation (
      Placement(visible = true, transformation(origin = {-88, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant Duration(k = t) annotation (
      Placement(visible = true, transformation(origin = {-90, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter Real t=1 "duration in years";
  parameter Real i=0.05 "interest rate";
  equation
    connect(Rate.y, product.u2) annotation (
      Line(points={{-77,40},{-68,40},{-68,-72},{24,-72}},          color = {0, 0, 127}));
    connect(product.y, Prod.u2) annotation (
      Line(points = {{47, -66}, {60.5, -66}, {60.5, -62}, {66, -62}}, color = {0, 0, 127}));
    connect(discountingFactor1.y, product.u1) annotation (
      Line(points={{0.6,-40},{24,-40},{24,-60}},      color = {0, 0, 127}));
    connect(add.y, Prod.u1) annotation (
      Line(points = {{55, -34}, {55, -42.25}, {57, -42.25}, {57, -42.5}, {66, -42.5}, {66, -50}}, color = {0, 0, 127}));
    connect(Duration.y, discountingFactor1.duration) annotation (
      Line(points={{-79,-44},{-20,-44},{-20,-45},{-20,-45}},          color = {0, 0, 127}));
    connect(Rate.y, q.u2) annotation (
      Line(points={{-77,40},{-60,40},{-60,40},{-60,40}},          color = {0, 0, 127}));
    connect(discountingFactor1.y, add.u2) annotation (
      Line(points={{0.6,-40},{32,-40},{32,-40},{32,-40}},        color = {0, 0, 127}));
    connect(q.y, discountingFactor1.discountingfactor) annotation (
      Line(points={{-37,46},{-26,46},{-26,-35},{-20,-35}},          color = {0, 0, 127}));
    connect(Constant3.y, add.u1) annotation (
      Line(points={{7,46},{12,46},{12,-28},{32,-28}},          color = {0, 0, 127}));
    connect(Prod.y, RBF) annotation (
      Line(points = {{89, -56}, {110, -56}}, color = {0, 0, 127}));
    connect(Constant2.y, q.u1) annotation (
      Line(points = {{-79, 90}, {-71.5, 90}, {-71.5, 52}, {-60, 52}}, color = {0, 0, 127}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio = false)),
      Diagram(coordinateSystem(preserveAspectRatio = false)));
  end RBF;

  model LRM
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
    Modelica.Blocks.Math.MultiSum multiSum1(k={1,1,1}, nu=3)
                                            annotation (
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
    Modelica.Blocks.Math.MultiSum multiSum2(k={1,1,1}, nu=3)
                                            annotation (
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
    Modelica.Blocks.Math.MultiSum multiSum3(k={1,1,1}, nu=3)
                                            annotation (
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
      Placement(visible = true, transformation(origin = {-14, -188}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {-14, -188}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.MultiSum multiSum4(k={1,1,1}, nu=3)
                                            annotation (
      Placement(visible = true, transformation(origin = {-14, -156}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
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
      Line(points={{50,159},{50,159},{50,140},{354,140},{354,-42},{310,-42},{
            310,-50},{310,-50}},                                                                                   color = {0, 0, 127}));
    connect(const6.y, add15.u1) annotation (
      Line(points={{12,159},{12,159},{12,140},{354,140},{354,-62},{340,-62},{
            340,-62}},                                                                                 color = {0, 0, 127}));
    connect(const19.y, add9.u1) annotation (
      Line(points={{130,159},{130,159},{130,140},{354,140},{354,-34},{340,-34},
            {340,-34}},                                                                                   color = {0, 0, 127}));
    connect(const18.y, add17.u1) annotation (
      Line(points={{90,159},{90,159},{90,140},{354,140},{354,-8},{340,-8},{340,
            -8}},                                                                                   color = {0, 0, 127}));
    connect(const19.y, product20.u2) annotation (
      Line(points={{130,159},{130,159},{130,140},{354,140},{354,46},{314,46},{
            314,38},{312,38},{312,38}},                                                                                      color = {0, 0, 127}));
    connect(const18.y, add18.u1) annotation (
      Line(points={{90,159},{90,159},{90,140},{354,140},{354,26},{344,26},{344,
            26}},                                                                                   color = {0, 0, 127}));
    connect(const5.y, product22.u2) annotation (
      Line(points={{-70,159},{-70,159},{-70,140},{354,140},{354,88},{292,88},{
            292,78},{290,78}},                                                                                    color = {0, 0, 127}));
    connect(const6.y, add19.u2) annotation (
      Line(points={{12,159},{12,159},{12,140},{354,140},{354,88},{318,88},{318,
            78},{316,78}},                                                                                     color = {0, 0, 127}));
    connect(const19.y, product24.u1) annotation (
      Line(points={{130,159},{130,159},{130,140},{354,140},{354,88},{316,88},{
            316,94},{316,94}},                                                                                    color = {0, 0, 127}));
    connect(const18.y, add20.u1) annotation (
      Line(points={{90,159},{90,159},{90,140},{354,140},{354,94},{344,94},{344,
            94}},                                                                                   color = {0, 0, 127}));
    connect(X, add17.u2) annotation (
      Line(points = {{-400, -70}, {-332, -70}, {-332, 140}, {354, 140}, {354, 6}, {342, 6}, {342, 4}, {340, 4}}, color = {0, 0, 127}));
    connect(X, add18.u2) annotation (
      Line(points = {{-400, -70}, {-332, -70}, {-332, 140}, {354, 140}, {354, 38}, {344, 38}, {344, 38}, {344, 38}}, color = {0, 0, 127}));
    connect(X, add20.u2) annotation (
      Line(points = {{-400, -70}, {-332, -70}, {-332, 140}, {354, 140}, {354, 106}, {346, 106}, {346, 106}, {344, 106}}, color = {0, 0, 127}));
    connect(feedback1.y, add15.u2) annotation (
      Line(points={{-345,38},{-332,38},{-332,140},{354,140},{354,-50},{342,-50},
            {342,-50},{340,-50}},                                                                                      color = {0, 0, 127}));
    connect(feedback1.y, add9.u2) annotation (
      Line(points={{-345,38},{-332,38},{-332,140},{354,140},{354,-22},{340,-22},
            {340,-22},{340,-22}},                                                                                      color = {0, 0, 127}));
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
      Line(points={{317,-2},{310,-2},{310,-20}},        color = {0, 0, 127}));
    connect(feedback1.y, abs15.u) annotation (
      Line(points={{-345,38},{-332,38},{-332,140},{354,140},{354,72},{346,72},{
            346,72},{344,72}},                                                                                     color = {0, 0, 127}));
    connect(product20.y, switch110.u1) annotation (
      Line(points={{289,32},{268,32},{268,48},{212,48},{212,40},{212,40}},              color = {0, 0, 127}));
    connect(add18.y, product20.u1) annotation (
      Line(points={{321,32},{312,32},{312,26},{312,26}},          color = {0, 0, 127}));
    connect(add19.y, product22.u1) annotation (
      Line(points={{293,72},{290,72},{290,66},{290,66}},          color = {0, 0, 127}));
    connect(abs15.y, add19.u1) annotation (
      Line(points={{321,72},{316,72},{316,66},{316,66}},          color = {0, 0, 127}));
    connect(add20.y, product24.u2) annotation (
      Line(points = {{321, 100}, {316, 100}, {316, 106}}, color = {0, 0, 127}));
    connect(product24.y, add21.u2) annotation (
      Line(points = {{293, 100}, {264, 100}, {264, 106}}, color = {0, 0, 127}));
    connect(product22.y, add21.u1) annotation (
      Line(points={{267,72},{264,72},{264,94},{264,94}},          color = {0, 0, 127}));
    connect(add21.y, switch111.u1) annotation (
      Line(points={{241,100},{240,100},{240,122},{212,122},{212,108},{212,108}},              color = {0, 0, 127}));
    connect(feedback1.y, add8.u2) annotation (
      Line(points={{-345,38},{-332,38},{-332,140},{122,140},{122,-18},{114,-18},
            {114,-18},{112,-18}},                                                                                      color = {0, 0, 127}));
    connect(feedback1.y, abs13.u) annotation (
      Line(points={{-345,38},{-332,38},{-332,140},{122,140},{122,104},{114,104},
            {114,104},{114,104}},                                                                                      color = {0, 0, 127}));
    connect(multiSum2.y, switch16.u1) annotation (
      Line(points={{22,-5.7},{14,-5.7},{14,-82},{-2,-82},{-2,-92},{-2,-92}},          color = {0, 0, 127}));
    connect(product9.y, switch14.u1) annotation (
      Line(points={{63,-24},{12,-24},{12,-8},{-22,-8},{-22,-16}},            color = {0, 0, 127}));
    connect(add8.y, product9.u2) annotation (
      Line(points={{89,-24},{86,-24},{86,-18},{86,-18}},          color = {0, 0, 127}));
    connect(const8.y, product9.u1) annotation (
      Line(points={{50,159},{50,159},{50,140},{122,140},{122,-40},{86,-40},{86,
            -30},{86,-30}},                                                                                     color = {0, 0, 127}));
    connect(const6.y, add8.u1) annotation (
      Line(points={{12,159},{12,159},{12,140},{122,140},{122,-30},{112,-30},{
            112,-30}},                                                                                 color = {0, 0, 127}));
    connect(const6.y, add12.u1) annotation (
      Line(points = {{12, 159}, {12, 140}, {122, 140}, {122, 86}, {86, 86}, {86, 98}}, color = {0, 0, 127}));
    connect(const6.y, add4.u2) annotation (
      Line(points = {{12, 159}, {12, 140}, {-104, 140}, {-104, -38}, {-146, -38}, {-146, -44}}, color = {0, 0, 127}));
    connect(const6.y, add3.u2) annotation (
      Line(points = {{12, 159}, {12, 140}, {-104, 140}, {-104, 94}, {-140, 94}, {-140, 84}, {-142, 84}}, color = {0, 0, 127}));
    connect(product14.y, switch17.u1) annotation (
      Line(points={{37,104},{28,104},{28,120},{-18,120},{-18,112},{-18,112},{
            -18,112}},                                                                                 color = {0, 0, 127}));
    connect(const5.y, product14.u1) annotation (
      Line(points={{-70,159},{-70,159},{-70,140},{122,140},{122,86},{60,86},{60,
            98},{60,98}},                                                                                      color = {0, 0, 127}));
    connect(add12.y, product14.u2) annotation (
      Line(points={{63,104},{60,104},{60,110},{60,110}},          color = {0, 0, 127}));
    connect(abs13.y, add12.u2) annotation (
      Line(points={{91,104},{86,104},{86,110},{86,110}},          color = {0, 0, 127}));
    connect(const11.y, switch15.u1) annotation (
      Line(points={{-32,19},{-22,19},{-22,44},{-18,44},{-18,44}},            color = {0, 0, 127}));
    connect(const4.y, product7.u1) annotation (
      Line(points={{-30,159},{-30,159},{-30,140},{-104,140},{-104,-38},{-170,
            -38},{-170,-28},{-172,-28}},                                                                                   color = {0, 0, 127}));
    connect(add7.y, product7.u2) annotation (
      Line(points={{-169,-22},{-172,-22},{-172,-16},{-172,-16}},          color = {0, 0, 127}));
    connect(const3.y, add7.u1) annotation (
      Line(points={{-110,159},{-110,159},{-110,140},{-104,140},{-104,-38},{-146,
            -38},{-146,-28},{-146,-28}},                                                                                      color = {0, 0, 127}));
    connect(const2.y, product8.u1) annotation (
      Line(points={{-150,159},{-150,159},{-150,140},{-104,140},{-104,-28},{-120,
            -28},{-120,-28}},                                                                                    color = {0, 0, 127}));
    connect(const8.y, product4.u2) annotation (
      Line(points={{50,159},{50,159},{50,140},{-104,140},{-104,-38},{-170,-38},
            {-170,-44},{-172,-44}},                                                                                     color = {0, 0, 127}));
    connect(product7.y, add5.u2) annotation (
      Line(points={{-195,-22},{-196,-22},{-196,-16},{-198,-16}},          color = {0, 0, 127}));
    connect(add5.y, switch13.u1) annotation (
      Line(points={{-221,-22},{-220,-22},{-220,-6},{-250,-6},{-250,-14},{-250,
            -14}},                                                                                color = {0, 0, 127}));
    connect(product4.y, add5.u1) annotation (
      Line(points={{-195,-50},{-198,-50},{-198,-28},{-198,-28}},          color = {0, 0, 127}));
    connect(add4.y, product4.u1) annotation (
      Line(points={{-169,-50},{-172,-50},{-172,-56},{-172,-56}},          color = {0, 0, 127}));
    connect(abs11.y, add4.u1) annotation (
      Line(points={{-141,-50},{-144,-50},{-144,-56},{-146,-56}},          color = {0, 0, 127}));
    connect(X, product8.u2) annotation (
      Line(points = {{-400, -70}, {-332, -70}, {-332, 140}, {-104, 140}, {-104, -14}, {-120, -14}, {-120, -16}, {-120, -16}}, color = {0, 0, 127}));
    connect(feedback1.y, abs11.u) annotation (
      Line(points={{-345,38},{-332,38},{-332,140},{-104,140},{-104,-50},{-116,
            -50},{-116,-50},{-118,-50}},                                                                                    color = {0, 0, 127}));
    connect(X, product6.u2) annotation (
      Line(points = {{-400, -70}, {-332, -70}, {-332, 140}, {-104, 140}, {-104, 44}, {-116, 44}, {-116, 44}, {-116, 44}}, color = {0, 0, 127}));
    connect(product5.y, switch12.u1) annotation (
      Line(points={{-191,38},{-200,38},{-200,54},{-248,54},{-248,46},{-246,46},
            {-246,46}},                                                                                   color = {0, 0, 127}));
    connect(add6.y, product5.u2) annotation (
      Line(points={{-165,38},{-168,38},{-168,44},{-168,44}},          color = {0, 0, 127}));
    connect(const4.y, product5.u1) annotation (
      Line(points={{-30,159},{-30,159},{-30,140},{-104,140},{-104,20},{-168,20},
            {-168,32},{-168,32}},                                                                                      color = {0, 0, 127}));
    connect(product6.y, add6.u2) annotation (
      Line(points={{-139,38},{-142,38},{-142,44},{-142,44}},          color = {0, 0, 127}));
    connect(const3.y, add6.u1) annotation (
      Line(points={{-110,159},{-110,159},{-110,140},{-104,140},{-104,20},{-142,
            20},{-142,32},{-142,32}},                                                                                     color = {0, 0, 127}));
    connect(const2.y, product6.u1) annotation (
      Line(points={{-150,159},{-150,159},{-150,140},{-104,140},{-104,30},{-114,
            30},{-114,32},{-116,32}},                                                                                     color = {0, 0, 127}));
    connect(const4.y, product2.u1) annotation (
      Line(points={{-30,159},{-30,140},{-104,140},{-104,94},{-168,94},{-168,100}},              color = {0, 0, 127}));
    connect(add1.y, product2.u2) annotation (
      Line(points={{-165,106},{-168,106},{-168,112},{-168,112}},          color = {0, 0, 127}));
    connect(const3.y, add1.u1) annotation (
      Line(points={{-110,159},{-110,159},{-110,140},{-104,140},{-104,94},{-140,
            94},{-140,100},{-142,100}},                                                                                     color = {0, 0, 127}));
    connect(product1.y, add1.u2) annotation (
      Line(points={{-139,106},{-140,106},{-140,112},{-142,112}},          color = {0, 0, 127}));
    connect(const2.y, product1.u1) annotation (
      Line(points={{-150,159},{-150,159},{-150,140},{-104,140},{-104,100},{-116,
            100},{-116,100}},                                                                                    color = {0, 0, 127}));
    connect(X, product1.u2) annotation (
      Line(points = {{-400, -70}, {-332, -70}, {-332, 140}, {-104, 140}, {-104, 112}, {-116, 112}, {-116, 112}}, color = {0, 0, 127}));
    connect(add2.y, switch11.u1) annotation (
      Line(points={{-217,106},{-216,106},{-216,120},{-246,120},{-246,114},{-246,
            114}},                                                                                  color = {0, 0, 127}));
    connect(product2.y, add2.u2) annotation (
      Line(points={{-191,106},{-194,106},{-194,112},{-194,112},{-194,112}},            color = {0, 0, 127}));
    connect(product3.y, add2.u1) annotation (
      Line(points={{-191,78},{-194,78},{-194,100},{-194,100}},          color = {0, 0, 127}));
    connect(const5.y, product3.u2) annotation (
      Line(points={{-70,159},{-70,159},{-70,140},{-104,140},{-104,94},{-168,94},
            {-168,84},{-168,84}},                                                                                      color = {0, 0, 127}));
    connect(add3.y, product3.u1) annotation (
      Line(points={{-165,78},{-166,78},{-166,72},{-168,72}},          color = {0, 0, 127}));
    connect(abs1.y, add3.u1) annotation (
      Line(points={{-137,78},{-142,78},{-142,72},{-142,72}},          color = {0, 0, 127}));
    connect(feedback1.y, abs1.u) annotation (
      Line(points={{-345,38},{-332,38},{-332,140},{-104,140},{-104,80},{-112,80},
            {-112,78},{-114,78}},                                                                                       color = {0, 0, 127}));
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
      Line(points={{-345,38},{-332,38},{-332,140},{140,140},{140,102},{156,102},
            {156,102},{156,102}},                                                                                      color = {0, 0, 127}));
    connect(feedback1.y, greaterThreshold8.u) annotation (
      Line(points={{-345,38},{-332,38},{-332,140},{140,140},{140,74},{154,74},{
            154,74},{156,74}},                                                                                     color = {0, 0, 127}));
    connect(feedback1.y, lessEqualThreshold3.u) annotation (
      Line(points={{-345,38},{-332,38},{-332,140},{140,140},{140,40},{156,40},{
            156,40},{156,40}},                                                                                     color = {0, 0, 127}));
    connect(feedback1.y, greaterEqualThreshold3.u) annotation (
      Line(points={{-345,38},{-332,38},{-332,140},{140,140},{140,10},{154,10},{
            154,10},{154,10}},                                                                                     color = {0, 0, 127}));
    connect(feedback1.y, lessThreshold9.u) annotation (
      Line(points={{-345,38},{-332,38},{-332,140},{140,140},{140,-24},{152,-24},
            {152,-26},{152,-26},{152,-26}},                                                                                        color = {0, 0, 127}));
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
      Line(points={{198,83},{212,83},{212,92},{212,92}},          color = {0, 0, 127}));
    connect(and111.y, switch111.u2) annotation (
      Line(points={{207,98},{212,98},{212,100},{212,100}},          color = {255, 0, 255}));
    connect(lessThreshold8.y, and111.u1) annotation (
      Line(points={{179,102},{182,102},{182,98},{184,98}},          color = {255, 0, 255}));
    connect(greaterThreshold8.y, and111.u2) annotation (
      Line(points={{179,74},{184,74},{184,90},{184,90}},          color = {255, 0, 255}));
    connect(const15.y, switch110.u3) annotation (
      Line(points={{198,15},{212,15},{212,24},{212,24}},          color = {0, 0, 127}));
    connect(and19.y, switch110.u2) annotation (
      Line(points={{207,30},{210,30},{210,32},{212,32}},          color = {255, 0, 255}));
    connect(greaterEqualThreshold3.y, and19.u2) annotation (
      Line(points={{177,10},{184,10},{184,22},{184,22}},          color = {255, 0, 255}));
    connect(lessEqualThreshold3.y, and19.u1) annotation (
      Line(points={{179,40},{182,40},{182,30},{184,30}},          color = {255, 0, 255}));
    connect(const16.y, switch19.u3) annotation (
      Line(points={{194,-45},{206,-45},{206,-36},{208,-36}},          color = {0, 0, 127}));
    connect(and110.y, switch19.u2) annotation (
      Line(points={{203,-30},{208,-30},{208,-28},{208,-28}},          color = {255, 0, 255}));
    connect(lessThreshold9.y, and110.u1) annotation (
      Line(points={{175,-26},{180,-26},{180,-30},{180,-30}},          color = {255, 0, 255}));
    connect(greaterThreshold9.y, and110.u2) annotation (
      Line(points={{175,-54},{180,-54},{180,-38},{180,-38}},          color = {255, 0, 255}));
    connect(multiSum3.y, switch18.u1) annotation (
      Line(points={{252,-9.7},{250,-9.7},{250,-82},{228,-82},{228,-96},{228,-96}},            color = {0, 0, 127}));
    connect(const10.y, switch14.u3) annotation (
      Line(points={{-36,-41},{-24,-41},{-24,-32},{-22,-32}},          color = {0, 0, 127}));
    connect(and14.y, switch14.u2) annotation (
      Line(points={{-27,-26},{-24,-26},{-24,-24},{-22,-24}},          color = {255, 0, 255}));
    connect(greaterThreshold4.y, and14.u2) annotation (
      Line(points={{-55,-50},{-50,-50},{-50,-34},{-50,-34}},          color = {255, 0, 255}));
    connect(lessThreshold4.y, and14.u1) annotation (
      Line(points={{-55,-22},{-50,-22},{-50,-26},{-50,-26}},          color = {255, 0, 255}));
    connect(and15.y, switch15.u2) annotation (
      Line(points={{-23,34},{-18,34},{-18,36},{-18,36}},          color = {255, 0, 255}));
    connect(const11.y, switch15.u3) annotation (
      Line(points={{-32,19},{-20,19},{-20,28},{-18,28}},          color = {0, 0, 127}));
    connect(greaterEqualThreshold2.y, and15.u2) annotation (
      Line(points={{-53,14},{-48,14},{-48,26},{-46,26}},          color = {255, 0, 255}));
    connect(lessEqualThreshold2.y, and15.u1) annotation (
      Line(points={{-51,44},{-46,44},{-46,34},{-46,34}},          color = {255, 0, 255}));
    connect(and17.y, switch17.u2) annotation (
      Line(points={{-23,102},{-18,102},{-18,104},{-18,104}},          color = {255, 0, 255}));
    connect(const12.y, switch17.u3) annotation (
      Line(points={{-32,87},{-18,87},{-18,96},{-18,96}},          color = {0, 0, 127}));
    connect(greaterThreshold5.y, and17.u2) annotation (
      Line(points={{-51,78},{-46,78},{-46,94},{-46,94}},          color = {255, 0, 255}));
    connect(lessThreshold5.y, and17.u1) annotation (
      Line(points={{-51,106},{-46,106},{-46,102},{-46,102}},          color = {255, 0, 255}));
    connect(const13.y, switch16.u3) annotation (
      Line(points={{-9,-128},{-4,-128},{-4,-108},{-2,-108}},          color = {0, 0, 127}));
    connect(and13.y, switch13.u2) annotation (
      Line(points={{-255,-24},{-250,-24},{-250,-22},{-250,-22}},          color = {255, 0, 255}));
    connect(const9.y, switch13.u3) annotation (
      Line(points={{-264,-39},{-252,-39},{-252,-30},{-250,-30}},          color = {0, 0, 127}));
    connect(greaterThreshold3.y, and13.u2) annotation (
      Line(points={{-283,-48},{-278,-48},{-278,-32},{-278,-32}},          color = {255, 0, 255}));
    connect(lessThreshold3.y, and13.u1) annotation (
      Line(points={{-283,-20},{-278,-20},{-278,-24},{-278,-24},{-278,-24}},            color = {255, 0, 255}));
    connect(const7.y, switch12.u3) annotation (
      Line(points={{-260,21},{-248,21},{-248,30},{-246,30}},          color = {0, 0, 127}));
    connect(and12.y, switch12.u2) annotation (
      Line(points={{-251,36},{-246,36},{-246,38},{-246,38}},          color = {255, 0, 255}));
    connect(greaterEqualThreshold1.y, and12.u2) annotation (
      Line(points={{-281,16},{-274,16},{-274,28},{-274,28}},          color = {255, 0, 255}));
    connect(lessEqualThreshold1.y, and12.u1) annotation (
      Line(points={{-279,46},{-274,46},{-274,36},{-274,36}},          color = {255, 0, 255}));
    connect(multiSum1.y, switch1.u1) annotation (
      Line(points={{-206,-3.7},{-206,-3.7},{-206,-76},{-198,-76},{-198,-88},{
            -198,-88}},                                                                           color = {0, 0, 127}));
    connect(and11.y, switch11.u2) annotation (
      Line(points={{-251,104},{-246,104},{-246,106},{-246,106}},          color = {255, 0, 255}));
    connect(const1.y, switch11.u3) annotation (
      Line(points={{-260,89},{-248,89},{-248,98},{-246,98}},          color = {0, 0, 127}));
    connect(greaterThreshold2.y, and11.u2) annotation (
      Line(points={{-279,80},{-274,80},{-274,96},{-274,96}},          color = {255, 0, 255}));
    connect(lessThreshold2.y, and11.u1) annotation (
      Line(points={{-279,108},{-274,108},{-274,104},{-274,104}},          color = {255, 0, 255}));
    connect(const14.y, switch18.u3) annotation (
      Line(points={{221,-132},{228,-132},{228,-112},{228,-112}},          color = {0, 0, 127}));
    connect(and18.y, switch18.u2) annotation (
      Line(points={{219,-104},{228,-104},{228,-104},{228,-104}},          color = {255, 0, 255}));
    connect(greaterThreshold7.y, and18.u2) annotation (
      Line(points={{191,-126},{196,-126},{196,-112},{196,-112}},          color = {255, 0, 255}));
    connect(lessThreshold7.y, and18.u1) annotation (
      Line(points={{191,-94},{196,-94},{196,-104},{196,-104}},          color = {255, 0, 255}));
    connect(and16.y, switch16.u2) annotation (
      Line(points={{-11,-100},{-2,-100},{-2,-100},{-2,-100}},          color = {255, 0, 255}));
    connect(and1.y, switch1.u2) annotation (
      Line(points={{-207,-96},{-198,-96},{-198,-96},{-198,-96}},          color = {255, 0, 255}));
    connect(lessEqualThreshold4.y, and16.u2) annotation (
      Line(points={{-53,-122},{-34,-122},{-34,-108},{-34,-108}},          color = {255, 0, 255}));
    connect(greaterEqualThreshold4.y, and16.u1) annotation (
      Line(points={{-53,-92},{-34,-92},{-34,-100},{-34,-100}},          color = {255, 0, 255}));
    connect(greaterThreshold1.y, and1.u2) annotation (
      Line(points={{-235,-118},{-230,-118},{-230,-104},{-230,-104}},          color = {255, 0, 255}));
    connect(const.y, switch1.u3) annotation (
      Line(points={{-205,-124},{-200,-124},{-200,-104},{-198,-104}},          color = {0, 0, 127}));
    connect(lessThreshold1.y, and1.u1) annotation (
      Line(points={{-235,-86},{-230,-86},{-230,-96},{-230,-96}},          color = {255, 0, 255}));
    connect(multiSum4.y, PRC) annotation (
      Line(points={{-14,-167.7},{-17.5,-167.7},{-17.5,-163.7},{-21,-163.7},{-21,
            -165.7},{-14,-165.7},{-14,-185.7},{-15,-185.7},{-15,-188},{-14,-188}},                                                                                              color = {0, 0, 127}));
    connect(switch111.y, multiSum3.u[1]) annotation (Line(points={{235,100},{
            236,100},{236,12},{256.667,12}}, color={0,0,127}));
    connect(switch110.y, multiSum3.u[2]) annotation (Line(points={{235,32},{254,
            32},{254,12},{252,12}}, color={0,0,127}));
    connect(switch19.y, multiSum3.u[3]) annotation (Line(points={{231,-28},{238,
            -28},{238,20},{247.333,20},{247.333,12}}, color={0,0,127}));
    connect(switch17.y, multiSum2.u[1]) annotation (Line(points={{5,104},{
            26.6667,104},{26.6667,16}}, color={0,0,127}));
    connect(switch15.y, multiSum2.u[2]) annotation (Line(points={{5,36},{24,36},
            {24,16},{22,16}}, color={0,0,127}));
    connect(switch14.y, multiSum2.u[3]) annotation (Line(points={{1,-24},{10,
            -24},{10,24},{17.3333,24},{17.3333,16}}, color={0,0,127}));
    connect(switch11.y, multiSum1.u[1]) annotation (Line(points={{-223,106},{
            -224,106},{-224,76},{-201.333,76},{-201.333,18}}, color={0,0,127}));
    connect(switch12.y, multiSum1.u[2]) annotation (Line(points={{-223,38},{
            -206,38},{-206,18}}, color={0,0,127}));
    connect(switch13.y, multiSum1.u[3]) annotation (Line(points={{-227,-22},{
            -226,-22},{-226,26},{-210.667,26},{-210.667,18}}, color={0,0,127}));
    connect(switch1.y, multiSum4.u[1]) annotation (Line(points={{-175,-96},{
            -170,-96},{-170,-98},{-136,-98},{-136,-142},{-9.33333,-142},{
            -9.33333,-146}}, color={0,0,127}));
    connect(switch16.y, multiSum4.u[2]) annotation (Line(points={{21,-100},{20,
            -100},{20,-138},{-10,-138},{-10,-146},{-14,-146}}, color={0,0,127}));
    connect(switch18.y, multiSum4.u[3]) annotation (Line(points={{251,-104},{
            251,-154},{-18.6667,-154},{-18.6667,-146}}, color={0,0,127}));
    connect(product8.y, add7.u2) annotation (Line(points={{-143,-22},{-144,-22},
            {-144,-16},{-146,-16}}, color={0,0,127}));
    annotation (
      Diagram(coordinateSystem(extent = {{-400, -180}, {400, 180}})),
      Icon(coordinateSystem(extent = {{-400, -180}, {400, 180}})),
      __OpenModelica_commandLineOptions = "");
  end LRM;

  block discountingFactor "u1 is the discounting factor, u2 is the duration in years"
    Modelica.Blocks.Interfaces.RealInput duration annotation (
      Placement(visible = true, transformation(origin = {-100, -50}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -50}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput discountingfactor annotation (
      Placement(visible = true, transformation(origin = {-100, 50}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 50}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y annotation (
      Placement(visible = true, transformation(origin = {106, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {106, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    y = discountingfactor ^ duration;
  end discountingFactor;
end CCCS;
