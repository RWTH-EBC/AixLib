within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case600
  extends
    AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.BaseClasses.PartialCase(
      ReferenceCoolingLoadOrTempMin(table=[600,-7964,-6137]),
      ReferenceHeatingLoadOrTempMax(table=[600,4296,5709]));

  Utilities.Sources.HeaterCooler.HeaterCoolerPI idealHeaterCooler(
    TN_heater=1,
    TN_cooler=1,
    h_heater=1e6,
    KR_heater=1000,
    l_cooler=-1e6,
    KR_cooler=1000,
    recOrSep=false)
    annotation (Placement(transformation(extent={{-15,-65},{5,-45}})));

  Utilities.Sources.HourOfDay hourOfDay
    annotation (Placement(transformation(extent={{104,78},{117,90}})));
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

  parameter Real airExchange=0.41 "Constant Air Exchange Rate";
  parameter Real TsetCooler=27 "Constant Set Temperature for Cooler";
  parameter Real TsetHeater=20 "Constant Set Temperature for Heater";
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
equation
    //Connections for input solar model
  for i in 1:5 loop
  end for;

  connect(Tset_Cooler.y, from_degC.u)
    annotation (Line(points={{-26.45,-76.5},{-21.1,-76.5}},
                                                          color={0,0,127}));
  connect(from_degC.y, idealHeaterCooler.setPointCool) annotation (Line(points={{-8.45,
          -76.5},{-7.4,-76.5},{-7.4,-62.2}},      color={0,0,127}));
  connect(TSet_Heater.y, from_degC1.u)
    annotation (Line(points={{18.45,-75.5},{13.1,-75.5}}, color={0,0,127}));
  connect(from_degC1.y, idealHeaterCooler.setPointHeat) annotation (Line(points={{0.45,
          -75.5},{-2.8,-75.5},{-2.8,-62.2}},        color={0,0,127}));
  connect(HeatingPower.y, integratorHeat.u)
    annotation (Line(points={{64,68},{70.9,68}}, color={0,0,127}));
  connect(CoolingPower.y, integratorCool.u) annotation (Line(points={{64,52},{
          68,52},{68,52},{70.9,52}}, color={0,0,127}));
  connect(Room.AirExchangePort, AirExchangeRate.y) annotation (Line(points={{
          -29.8,53.765},{-47,53.765},{-47,-33},{-20,-33},{-20,-49.5},{-24.35,
          -49.5}}, color={0,0,127}));
  connect(idealHeaterCooler.heatCoolRoom, Room.thermRoom) annotation (Line(
        points={{4,-59},{21,-59},{21,-19},{-2,-19},{-2,35},{-2.92,35}}, color={
          191,0,0}));
  annotation (
    experiment(StopTime=31539600, Tolerance=1e-06),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/ThermalZones/HighOrder/Validation/ASHRAE140/Case600.mos"
        "Simulate and plot"),
    __Dymola_experimentSetupOutput(events=true),
Diagram(coordinateSystem(
        extent={{-150,-110},{130,90}},
        preserveAspectRatio=false,
        grid={1,1}), graphics={
        Text(
          extent={{-56,-2},{12,-10}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Building physics")}),
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
As described in ASHRAE Standard 140.
</html>"));
end Case600;
