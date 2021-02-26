within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case600FF
  extends
    AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.BaseClasses.PartialCase(
    checkTimeCoolOrTempMin=288000,
    checkTimeHeatOrTempMax=25029000,
    dispTypeCoolOrTempMin="T Min",
    dispTypeHeatOrTempMax="T Max",
    tableCoolOrTempMin=[600,-18.8,-15.6],
    tableHeatOrTempMax=[600,64.9,69.5]);

  Modelica.Blocks.Sources.Constant AirExchangeRate(final k=airExchange)
    annotation (Placement(transformation(extent={{-38,-56},{-25,-43}})));

  parameter Real airExchange=0.41 "Constant Air Exchange Rate";
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
  Modelica.Blocks.Sources.RealExpression CoolingPower(y=0)
    annotation (Placement(transformation(extent={{43,42},{63,62}})));
  Modelica.Blocks.Sources.RealExpression TransmittedRad(y=Room.outerWall_South.solarRadWinTrans)
    annotation (Placement(transformation(extent={{43,-10},{61,8}})));
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
  connect(TransmittedRad.y, integrator2.u) annotation (Line(points={{61.9,-1},{68,-1},{68,-0.75},{74,-0.75}},
                                              color={0,0,127}));
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
