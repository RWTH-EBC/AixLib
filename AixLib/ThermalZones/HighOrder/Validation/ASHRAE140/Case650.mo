within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case650
  extends
    AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.BaseClasses.PartialCase(
    dispTypeCoolOrTempMin="Q Cool",
    dispTypeHeatOrTempMax="Q Heat",
    tableCoolOrTempMin=[650,-6545,-4816],
    tableHeatOrTempMax=[650,0,0]);

  parameter AixLib.DataBase.Profiles.ProfileBaseDataDefinition SetTempProfile = AixLib.DataBase.Profiles.ASHRAE140.SetTemp_caseX50();
  parameter AixLib.DataBase.Profiles.ProfileBaseDataDefinition AERProfile = AixLib.DataBase.Profiles.ASHRAE140.Ventilation_caseX50();

  Utilities.Sources.HeaterCooler.HeaterCoolerPI idealHeaterCooler(
    Heater_on=false,
    Cooler_on=true,
    TN_heater=1,
    TN_cooler=1,
    h_heater=1e6,
    KR_heater=1000,
    l_cooler=-1e6,
    KR_cooler=1000,
    recOrSep=false)
    annotation (Placement(transformation(extent={{-16,-65},{4,-45}})));

  Modelica.Blocks.Sources.RealExpression CoolingPower(y=idealHeaterCooler.coolingPower)
    annotation (Placement(transformation(extent={{43,42},{63,62}})));

  Modelica.Blocks.Sources.CombiTimeTable AirExchangeRate(
    columns={2},
    tableOnFile=false,
    table=AERProfile.Profile,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{-39,-54},{-26,-41}})));
  Modelica.Blocks.Sources.CombiTimeTable Source_TsetCool(
    columns={2},
    tableOnFile=false,
    table=SetTempProfile.Profile,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{-30,-82},{-17,-69}})));
  parameter Real internalGains=200 "Constant Internal Gains";
  parameter Components.Types.selectorCoefficients absInnerWallSurf=AixLib.ThermalZones.HighOrder.Components.Types.selectorCoefficients.abs06
    "Coefficients for interior solar absorptance of wall surface abs={0.6, 0.9, 0.1}";
  parameter Real solar_absorptance_OW=0.6 "Solar absoptance outer walls ";
  parameter DataBase.Walls.Collections.OFD.BaseDataMultiInnerWalls wallTypes=
      AixLib.DataBase.Walls.Collections.ASHRAE140.LightMassCases()
    "Types of walls (contains multiple records)";
  replaceable parameter DataBase.WindowsDoors.Simple.WindowSimple_ASHRAE140 windowParam
    constrainedby DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple "Window parametrization"
    annotation (choicesAllMatching=true);
  parameter Modelica.SIunits.Area Win_Area=12 "Window area ";

  Modelica.Blocks.Sources.RealExpression HeatingPower(y=0)
    annotation (Placement(transformation(extent={{43,58},{63,78}})));
  Modelica.Blocks.Sources.RealExpression TransmittedRad(y=Room.outerWall_South.solarRadWinTrans)
    annotation (Placement(transformation(extent={{43,-10},{61,8}})));
equation


  connect(Source_TsetCool.y[1], idealHeaterCooler.setPointCool) annotation (
      Line(points={{-16.35,-75.5},{-16.35,-76},{-8.4,-76},{-8.4,-62.2}}, color={
          0,0,127}));
  connect(Room.AirExchangePort, AirExchangeRate.y[1]) annotation (Line(points={
          {-29.8,53.765},{-47,53.765},{-47,-33},{-19,-33},{-19,-47.5},{-25.35,
          -47.5}}, color={0,0,127}));
  connect(HeatingPower.y, integratorHeat.u)
    annotation (Line(points={{64,68},{70.9,68}}, color={0,0,127}));
  connect(CoolingPower.y, integratorCool.u)
    annotation (Line(points={{64,52},{70.9,52}}, color={0,0,127}));
  connect(idealHeaterCooler.heatCoolRoom, Room.thermRoom) annotation (Line(
        points={{3,-59},{21,-59},{21,-19},{-2,-19},{-2,35},{-2.92,35}}, color={
          191,0,0}));
  connect(to_kWhHeat.y, checkResultsAccordingToASHRAEHeatingOrTempMax.modelResults) annotation (Line(points={{102.5,68},{112,68},{112,-39},{94,-39},{94,-52.15},{97.95,-52.15}}, color={0,0,127}));
  connect(to_kWhCool.y, checkResultsAccordingToASHRAECoolingOrTempMin.modelResults) annotation (Line(points={{102.5,52},{111,52},{111,-37},{93,-37},{93,-73.15},{97.95,-73.15}}, color={0,0,127}));
  connect(TransmittedRad.y, integrator2.u) annotation (Line(points={{61.9,-1},{68,-1},{68,-0.75},{74,-0.75}},
                                              color={0,0,127}));
  annotation (
    experiment(StopTime=31539600, Tolerance=1e-06),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/ThermalZones/HighOrder/Validation/ASHRAE140/Case650.mos"
        "Simulate and plot"),
    __Dymola_experimentSetupOutput(events=true),
Diagram(coordinateSystem(
        extent={{-150,-110},{130,90}},
        preserveAspectRatio=false,
        grid={1,1})),
                  Icon(coordinateSystem(
        extent={{-150,-110},{130,90}},
        preserveAspectRatio=false,
        grid={1,1})),
    Documentation(revisions="<html><ul>
  <li>July 1, 2020, by Konstantina Xanthopoulou:<br/>
    updated
  </li>
  <li>
    <i>March 9, 2015</i> by Ana Constantin:<br/>
    Implemented
  </li>
</ul>
</html>",info="<html><p>
Input Specifications of <b>Case 650</b> as described in ASHRAE Standard
140:
<p>
  Difference to case 600:
</p>
<ul>
  <li>Air exchange rate: 10.8
  </li>
  <li>18-7 h: Vent fan = ON
  </li>
  <li>7-18 h: Vent fan = OFF
  </li>
  <li>Heating = always OFF
  </li>
  <li>18-7 h: Cool = OFF
  </li>
  <li>7-18 h: Cool =ON IF Temp &lt; 27°C, otherwise Cool=OFF
  </li>
</ul>
</html>"));
end Case650;
