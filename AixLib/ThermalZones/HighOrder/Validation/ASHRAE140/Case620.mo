within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case620
  extends AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.BaseClasses.PartialCase(
    dispTypeCoolOrTempMin="Q Cool",
    dispTypeHeatOrTempMax="Q Heat",
    tableCoolOrTempMin=[620,-5004,-3417],
    tableHeatOrTempMax=[620,4613,5944],
    redeclare model RoomModel = Rooms.ASHRAE140.EastWestFacingWindows (
        wallTypes=wallTypes,
        calcMethodIn=4,
        Type_Win=windowParam,
        solar_absorptance_OW=solar_absorptance_OW,
        calcMethodOut=2,
        Win_Area=Win_Area,
        absInnerWallSurf=absInnerWallSurf),
    Room(redeclare Components.Types.CoeffTableEastWestWindow coeffTableSolDistrFractions));

  Utilities.Sources.HeaterCooler.HeaterCoolerPI idealHeaterCooler(
    TN_heater=1,
    TN_cooler=1,
    h_heater=1e6,
    KR_heater=1000,
    l_cooler=-1e6,
    KR_cooler=1000,
    recOrSep=false)
    annotation (Placement(transformation(extent={{-15,-65},{5,-45}})));

  Modelica.Blocks.Sources.Constant AirExchangeRate(final k=airExchange)
    annotation (Placement(transformation(extent={{-38,-56},{-25,-43}})));
  Modelica.Blocks.Sources.Constant Tset_Cooler(final k=TsetCooler)
    annotation (Placement(transformation(extent={{-38,-82},{-27,-71}})));
  Modelica.Blocks.Sources.Constant TSet_Heater(final k=TsetHeater)
    annotation (Placement(transformation(extent={{30,-81},{19,-70}})));
  Modelica.Blocks.Sources.RealExpression HeatingPower(y=idealHeaterCooler.heatingPower)
    annotation (Placement(transformation(extent={{43,58},{63,78}})));
  Modelica.Blocks.Sources.RealExpression CoolingPower(y=idealHeaterCooler.coolingPower)
    annotation (Placement(transformation(extent={{43,42},{63,62}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC
    annotation (Placement(transformation(extent={{-20,-82},{-9,-71}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC1 annotation (
      Placement(transformation(
        extent={{-5.5,-5.5},{5.5,5.5}},
        rotation=180,
        origin={6.5,-75.5})));


equation

  connect(Tset_Cooler.y, from_degC.u)
    annotation (Line(points={{-26.45,-76.5},{-21.1,-76.5}},
                                                          color={0,0,127}));
  connect(from_degC.y, idealHeaterCooler.setPointCool) annotation (Line(points={{-8.45,
          -76.5},{-7.4,-76.5},{-7.4,-62.2}},      color={0,0,127}));
  connect(TSet_Heater.y, from_degC1.u)
    annotation (Line(points={{18.45,-75.5},{13.1,-75.5}}, color={0,0,127}));
  connect(from_degC1.y, idealHeaterCooler.setPointHeat) annotation (Line(points={{0.45,
          -75.5},{-2.8,-75.5},{-2.8,-62.2}},        color={0,0,127}));
  connect(Room.AirExchangePort, AirExchangeRate.y) annotation (Line(points={{-29.8,
          53.765},{-47,53.765},{-47,-36},{-18,-36},{-18,-49.5},{-24.35,-49.5}},
        color={0,0,127}));
  connect(idealHeaterCooler.heatCoolRoom, Room.thermRoom) annotation (Line(
        points={{4,-59},{22,-59},{22,-19},{-2,-19},{-2,35},{-2.92,35}}, color={191,
          0,0}));
  connect(HeatingPower.y, integratorHeat.u)
    annotation (Line(points={{64,68},{70.9,68}}, color={0,0,127}));
  connect(CoolingPower.y, integratorCool.u)
    annotation (Line(points={{64,52},{70.9,52}}, color={0,0,127}));
  connect(to_kWhHeat.y, checkResultsAccordingToASHRAEHeatingOrTempMax.modelResults) annotation (Line(points={{102.5,68},{112,68},{112,-39},{94,-39},{94,-52.15},{97.95,-52.15}}, color={0,0,127}));
  connect(to_kWhCool.y, checkResultsAccordingToASHRAECoolingOrTempMin.modelResults) annotation (Line(points={{102.5,52},{111,52},{111,-37},{93,-37},{93,-73.15},{97.95,-73.15}}, color={0,0,127}));
  connect(Room.transShoWaveRadWin, integrator2.u) annotation (Line(points={{17.8,5.3},{17.8,-0.75},{74,-0.75}}, color={0,0,127}));
  annotation (
    experiment(StopTime=31539600, Tolerance=1e-06),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/ThermalZones/HighOrder/Validation/ASHRAE140/Case620.mos"
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
Input Specifications of <b>Case 620</b> as described in ASHRAE Standard
140:
<p>
  Difference to case 600:
</p>
<ul>
  <li>no windows on south side. two windows, one facing east, one
  facing west, each with a surface of 6m2.
  </li>
</ul>
</html>"));
end Case620;
