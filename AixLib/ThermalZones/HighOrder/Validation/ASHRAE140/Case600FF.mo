within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case600FF
  extends AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.BaseClasses.PartialCase(
    checkTimeCoolOrTempMin=288000,
    checkTimeHeatOrTempMax=25029000,
    dispTypeCoolOrTempMin="T Min",
    dispTypeHeatOrTempMax="T Max",
    tableCoolOrTempMin=[600,-18.8,-15.6],
    tableHeatOrTempMax=[600,64.9,69.5],
    Room(redeclare Components.Types.CoeffTableSouthWindow coeffTableSolDistrFractions));

  Modelica.Blocks.Sources.RealExpression HeatingPower(y=0)
    annotation (Placement(transformation(extent={{43,58},{63,78}})));
  Modelica.Blocks.Sources.RealExpression CoolingPower(y=0)
    annotation (Placement(transformation(extent={{43,42},{63,62}})));
  Modelica.Blocks.Sources.Constant AirExchangeRate(final k=airExchange)
    annotation (Placement(transformation(extent={{-38,-56},{-25,-43}})));

equation

  connect(Room.AirExchangePort, AirExchangeRate.y) annotation (Line(points={{
          -29.8,53.765},{-47,53.765},{-47,-37},{-17,-37},{-17,-49.5},{-24.35,
          -49.5}}, color={0,0,127}));
  connect(HeatingPower.y, integratorHeat.u)
    annotation (Line(points={{64,68},{70.9,68}}, color={0,0,127}));
  connect(CoolingPower.y, integratorCool.u) annotation (Line(points={{64,52},{
          68,52},{68,52},{70.9,52}}, color={0,0,127}));
  connect(to_degCRoomConvTemp.y, checkResultsAccordingToASHRAEHeatingOrTempMax.modelResults) annotation (Line(points={{102.5,36},{112,36},{112,-39},{92,-39},{92,-52.15},{97.95,-52.15}}, color={0,0,127}));
  connect(to_degCRoomConvTemp.y, checkResultsAccordingToASHRAECoolingOrTempMin.modelResults) annotation (Line(points={{102.5,36},{111,36},{111,-38},{91,-38},{91,-73.15},{97.95,-73.15}}, color={0,0,127}));
  connect(Room.transShoWaveRadWin, integrator2.u) annotation (Line(points={{17.8,5.3},{17.8,-0.75},{74,-0.75}}, color={0,0,127}));
  annotation (
    experiment(StopTime=31539600, Tolerance=1e-06),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/ThermalZones/HighOrder/Validation/ASHRAE140/Case600FF.mos"
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
Input Specifications of <b>Case 600FF</b> as described in ASHRAE
Standard 140:
<p>
  Difference to case 600:
</p>
<ul>
  <li>no cooling or heating equipment
  </li>
</ul>
</html>"));
end Case600FF;
