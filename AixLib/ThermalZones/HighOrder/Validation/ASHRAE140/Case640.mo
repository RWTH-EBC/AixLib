within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case640
  extends
    AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.BaseClasses.PartialCase(
      ReferenceHeatingLoadOrTempMax(table=[640,2751,3803]),
      ReferenceCoolingLoadOrTempMin(table=[640,-7811,-5952]),
    checkResultsAccordingToASHRAEHeatingOrTempMax(dispType="Q Heat"),
    checkResultsAccordingToASHRAECoolingOrTempMin(dispType="Q Cool"));

  parameter AixLib.DataBase.Profiles.ProfileBaseDataDefinition SetTempProfile = AixLib.DataBase.Profiles.ASHRAE140.SetTemp_caseX40();

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
  Modelica.Blocks.Sources.RealExpression HeatingPower(y=idealHeaterCooler.heatingPower)
    annotation (Placement(transformation(extent={{44,58},{64,78}})));
  Modelica.Blocks.Sources.RealExpression CoolingPower(y=idealHeaterCooler.coolingPower)
    annotation (Placement(transformation(extent={{44,42},{64,62}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC
    annotation (Placement(transformation(extent={{-20,-82},{-9,-71}})));

  Modelica.Blocks.Sources.CombiTimeTable Source_TsetHeat(
    columns={2},
    tableOnFile=false,
    table=SetTempProfile.Profile,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(extent={{23,-82},{10,-69}})));
  parameter Real airExchange=0.41 "Constant Air Exchange Rate";
  parameter Real TsetCooler=27 "Constant Set Temperature for Cooler";
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
  connect(Source_TsetHeat.y[1], idealHeaterCooler.setPointHeat) annotation (
      Line(points={{9.35,-75.5},{-2.8,-75.5},{-2.8,-62.2}}, color={0,0,127}));
  connect(HeatingPower.y, integratorHeat.u) annotation (Line(points={{65,68},{
          69,68},{69,68},{70.9,68}}, color={0,0,127}));
  connect(CoolingPower.y, integratorCool.u)
    annotation (Line(points={{65,52},{70.9,52}}, color={0,0,127}));
  connect(Room.AirExchangePort, AirExchangeRate.y) annotation (Line(points={{
          -29.8,53.765},{-47,53.765},{-47,-34},{-20,-34},{-20,-49.5},{-24.35,
          -49.5}}, color={0,0,127}));
  connect(idealHeaterCooler.heatCoolRoom, Room.thermRoom) annotation (Line(
        points={{4,-59},{21,-59},{21,-19},{-2,-19},{-2,35},{-2.92,35}}, color={
          191,0,0}));
  annotation (
    experiment(StopTime=31539600, Tolerance=1e-06),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/ThermalZones/HighOrder/Validation/ASHRAE140/Case640.mos"
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
 Input Specifications of <b>Case 640</b> as described in ASHRAE Standard 140:
<p>
  Difference to case 600:
</p>
<ul>

  <li>23-7 h: Heat = ON IF Temp &lt; 10°C
  </li>
  <li>7-23 h: Heat = ON IF Temp &lt; 20°C
  </li>
<li>Cool = ON IF Temp &gt; 27°C

  </li>
</ul>
</html>"));
end Case640;
