within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case650FF
  extends AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.BaseClasses.PartialCase(
    checkTimeCoolOrTempMin=284400,
    checkTimeHeatOrTempMax=25027200,
    dispTypeCoolOrTempMin="T Min",
    dispTypeHeatOrTempMax="T Max",
    tableCoolOrTempMin=[650,-23,-21.6],
    tableHeatOrTempMax=[650,63.2,68.2],
    Room(redeclare Components.Types.CoeffTableSouthWindow coeffTableSolDistrFractions));

  parameter AixLib.DataBase.Profiles.ProfileBaseDataDefinition SetTempProfile = AixLib.DataBase.Profiles.ASHRAE140.SetTemp_caseX50();
  parameter AixLib.DataBase.Profiles.ProfileBaseDataDefinition AERProfile = AixLib.DataBase.Profiles.ASHRAE140.Ventilation_caseX50();

  Modelica.Blocks.Sources.RealExpression HeatingPower(y=0)
    annotation (Placement(transformation(extent={{43,58},{63,78}})));
  Modelica.Blocks.Sources.RealExpression CoolingPower(y=0)
    annotation (Placement(transformation(extent={{43,42},{63,62}})));
  Modelica.Blocks.Sources.CombiTimeTable AirExchangeRate(
    columns={2},
    tableOnFile=false,
    table=AERProfile.Profile,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{-39,-54},{-26,-41}})));

equation

  connect(Room.AirExchangePort, AirExchangeRate.y[1]) annotation (Line(points={
          {-29.8,53.765},{-47,53.765},{-47,-36},{-18,-36},{-18,-47.5},{-25.35,
          -47.5}}, color={0,0,127}));
  connect(HeatingPower.y, integratorHeat.u)
    annotation (Line(points={{64,68},{70.9,68}}, color={0,0,127}));
  connect(CoolingPower.y, integratorCool.u)
    annotation (Line(points={{64,52},{70.9,52}}, color={0,0,127}));
  connect(to_degCRoomConvTemp.y, checkResultsAccordingToASHRAEHeatingOrTempMax.modelResults) annotation (Line(points={{102.5,36},{112,36},{112,-39},{92,-39},{92,-52.15},{97.95,-52.15}}, color={0,0,127}));
  connect(to_degCRoomConvTemp.y, checkResultsAccordingToASHRAECoolingOrTempMin.modelResults) annotation (Line(points={{102.5,36},{111,36},{111,-38},{91,-38},{91,-73.15},{97.95,-73.15}}, color={0,0,127}));
  connect(Room.transShoWaveRadWin, integrator2.u) annotation (Line(points={{17.8,5.3},{17.8,-0.75},{74,-0.75}}, color={0,0,127}));
  annotation (
    experiment(StopTime=31539600, Tolerance=1e-06),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/ThermalZones/HighOrder/Validation/ASHRAE140/Case650FF.mos"
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
Input Specifications of <b>Case 650FF</b> as described in ASHRAE
Standard 140:
<p>
  Difference to case 650:
</p>
<ul>
  <li>no cooling or heating equipment
  </li>
</ul>
</html>"));
end Case650FF;
