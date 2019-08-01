within AixLib.Building.Benchmark;
package BenchmarkModel_reworked_TestModularization
  extends Modelica.Icons.ExamplesPackage;
  model HighOrder_ASHRAE140_SouthFacingWindows "windows facing south"

    parameter Modelica.SIunits.Length Room_Lenght={30,30,5,5,30}
                                                    "length" annotation (Dialog(group = "Dimensions", descriptionLabel = true));
    parameter Modelica.SIunits.Height Room_Height={3,3,3,3,3}
                                                      "height" annotation (Dialog(group = "Dimensions", descriptionLabel = true));
    parameter Modelica.SIunits.Length Room_Width={20,30,10,20,50}
                                                   "width"
                                                          annotation (Dialog(group = "Dimensions", descriptionLabel = true));

    parameter Modelica.SIunits.Area Win_Area={40,1,1,1,1}
                                                 "Window area " annotation (Dialog(group = "Windows", descriptionLabel = true, enable = withWindow1));

    parameter Modelica.SIunits.Temperature T0=295.15 "Outside"
                                                              annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
    parameter Modelica.SIunits.Temperature T0_IW=295.15 "IW"  annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
    parameter Modelica.SIunits.Temperature T0_OW=295.15 "OW"  annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
    parameter Modelica.SIunits.Temperature T0_CE=295.15 "Ceiling"
                                                              annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
    parameter Modelica.SIunits.Temperature T0_FL=295.15 "Floor"
                                                              annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
    parameter Modelica.SIunits.Temperature T0_Air=295.15 "Air"
                                                              annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));

    parameter Real solar_absorptance_OW = 0.6 "Solar absoptance outer walls " annotation (Dialog(group = "Outer wall properties", descriptionLabel = true));
    parameter Real eps_out=0.9 "emissivity of the outer surface"
                                         annotation (Dialog(group = "Outer wall properties", descriptionLabel = true));

    parameter AixLib.DataBase.Walls.WallBaseDataDefinition TypOW=
        AixLib.DataBase.Walls.ASHRAE140.OW_Case600()
      "choose an external wall type "
      annotation (Dialog(group="Wall Types"), choicesAllMatching=true);
    parameter AixLib.DataBase.Walls.WallBaseDataDefinition TypCE=
        AixLib.DataBase.Walls.ASHRAE140.RO_Case600() "choose a ceiling type "
      annotation (Dialog(group="Wall Types"), choicesAllMatching=true);
    parameter DataBase.Walls.WallBaseDataDefinition TypFL=
       AixLib.DataBase.Walls.ASHRAE140.FL_Case600() "choose a floor type "
      annotation (Dialog(group="Wall Types"), choicesAllMatching=true);

    parameter AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple Win=AixLib.DataBase.WindowsDoors.Simple.WindowSimple_ASHRAE140()
      "choose a Window type" annotation(Dialog(group="Windows"),choicesAllMatching= true);

  protected
    parameter Modelica.SIunits.Volume Room_V=Room_Lenght*Room_Height*Room_Width;

  public
    AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 outerWall_South(
      withDoor=false,
      WallType=TypOW,
      T0=T0_OW,
      wall_length=Room_Width,
      solar_absorptance=solar_absorptance_OW,
      Model=2,
      outside=true,
      withWindow=true,
      windowarea=Win_Area,
      wall_height=Room_Height,
      surfaceType=AixLib.DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
      WindowType=AixLib.DataBase.WindowsDoors.Simple.WindowSimple_ASHRAE140())
      annotation (Placement(transformation(extent={{-76,-36},{-62,44}})));
    AixLib.Building.Components.Walls.Wall_ASHRAE140 outerWall_West(
      wall_length=Room_Lenght,
      wall_height=Room_Height,
      withDoor=false,
      T0=T0_IW,
      outside=true,
      WallType=TypOW,
      solar_absorptance=solar_absorptance_OW,
      surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
      Model=2) annotation (Placement(transformation(
          extent={{-4,-24},{4,24}},
          rotation=-90,
          origin={26,78})));
    AixLib.Building.Components.Walls.Wall_ASHRAE140 outerWall_East(
      wall_length=Room_Lenght,
      wall_height=Room_Height,
      T0=T0_IW,
      outside=true,
      WallType=TypOW,
      solar_absorptance=solar_absorptance_OW,
      surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
      Model=2) annotation (Placement(transformation(
          extent={{-4.00001,-24},{4.00001,24}},
          rotation=90,
          origin={26,-64})));
    AixLib.Building.Components.Walls.Wall_ASHRAE140 outerWall_North(
      wall_height=Room_Height,
      U_door=5.25,
      door_height=1,
      door_width=2,
      withDoor=false,
      T0=T0_IW,
      wall_length=Room_Width,
      outside=true,
      WallType=TypOW,
      solar_absorptance=solar_absorptance_OW,
      surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
      Model=2) annotation (Placement(transformation(extent={{74,-36},{60,44}})));
    AixLib.Building.Components.Walls.Wall_ASHRAE140 ceiling(
      wall_length=Room_Lenght,
      wall_height=Room_Width,
      ISOrientation=3,
      withDoor=false,
      T0=T0_CE,
      WallType=TypCE,
      outside=true,
      solar_absorptance=solar_absorptance_OW,
      surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
      Model=2) annotation (Placement(transformation(
          extent={{-2,-12},{2,12}},
          rotation=270,
          origin={-32,78})));
    AixLib.Building.Components.Walls.Wall_ASHRAE140 floor(
      wall_length=Room_Lenght,
      wall_height=Room_Width,
      withDoor=false,
      ISOrientation=2,
      T0=T0_FL,
      WallType=TypFL,
      solar_absorptance=solar_absorptance_OW,
      outside=false,
      Model=2) annotation (Placement(transformation(
          extent={{-2.00031,-12},{2.00003,12}},
          rotation=90,
          origin={-32,-64})));
    Components.DryAir.Airload
                         airload(
      V=Room_V,
      c=1005) annotation (Placement(transformation(extent={{10,-18},{28,0}})));
    Utilities.Interfaces.Adaptors.ConvRadToCombPort
                                               thermStar_Demux annotation (
        Placement(transformation(
          extent={{-10,8},{10,-8}},
          rotation=90,
          origin={-32,-32})));
    Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
      annotation (Placement(transformation(extent={{32,-34},{42,-24}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Therm_ground
      annotation (Placement(transformation(extent={{-36,-100},{-28,-92}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Therm_outside
      annotation (Placement(transformation(extent={{-110,92},{-100,102}})));
    Modelica.Blocks.Interfaces.RealInput WindSpeedPort
      annotation (Placement(transformation(extent={{-120,20},{-104,36}}),
          iconTransformation(extent={{-120,20},{-100,40}})));
  public
    Utilities.Interfaces.Star
                            starRoom
      annotation (Placement(transformation(extent={{0,18},{18,34}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermRoom
      annotation (Placement(transformation(extent={{-36,16},{-22,30}})));
    Utilities.Interfaces.SolarRad_in   SolarRadiationPort[5] "N,E,S,W,Hor"
      annotation (Placement(transformation(extent={{-120,50},{-100,70}})));
    Components.DryAir.VarAirExchange varAirExchange(
      V=Room_V,
      c=airload.c,
      rho=airload.rho)
      annotation (Placement(transformation(extent={{-82,-66},{-62,-46}})));
    Modelica.Blocks.Interfaces.RealInput AER "Air exchange rate "
      annotation (Placement(transformation(extent={{-122,-62},{-100,-40}}),
          iconTransformation(extent={{-120,-60},{-100,-40}})));
  equation
    connect(thermStar_Demux.star, starRoom) annotation (Line(
        points={{-26.2,-21.6},{-26.2,0.2},{9,0.2},{9,26}},
        color={95,95,95},
        pattern=LinePattern.Solid));
    connect(thermStar_Demux.therm, thermRoom) annotation (Line(
        points={{-37.1,-21.9},{-37.1,-0.95},{-29,-0.95},{-29,23}},
        color={191,0,0}));
    connect(varAirExchange.InPort1, AER) annotation (Line(
        points={{-81,-62.4},{-111,-62.4},{-111,-51}},
        color={0,0,127}));
    connect(outerWall_South.port_outside, Therm_outside) annotation (Line(
        points={{-76.35,4},{-86,4},{-86,97},{-105,97}},
        color={191,0,0}));
    connect(floor.port_outside, Therm_ground) annotation (Line(
        points={{-32,-66.1003},{-32,-96}},
        color={191,0,0}));
    connect(outerWall_East.port_outside, Therm_outside) annotation (Line(
        points={{26,-68.2},{26,-80},{-86,-80},{-86,97},{-105,97}},
        color={191,0,0}));
    connect(outerWall_North.port_outside, Therm_outside) annotation (Line(
        points={{74.35,4},{82,4},{82,-80},{-86,-80},{-86,97},{-105,97}},
        color={191,0,0}));
    connect(outerWall_West.port_outside, Therm_outside) annotation (Line(
        points={{26,82.2},{26,88},{-86,88},{-86,97},{-105,97}},
        color={191,0,0}));
    connect(outerWall_South.WindSpeedPort, WindSpeedPort) annotation (Line(
        points={{-76.35,33.3333},{-86,33.3333},{-86,28},{-112,28}},
        color={0,0,127}));
    connect(outerWall_South.thermStarComb_inside, thermStar_Demux.thermStarComb)
      annotation (Line(
        points={{-62,4},{-54,4},{-54,-56},{-32.1,-56},{-32.1,-41.4}},
        color={191,0,0}));
    connect(floor.thermStarComb_inside, thermStar_Demux.thermStarComb)
      annotation (Line(
        points={{-32,-62},{-32,-41.4},{-32.1,-41.4}},
        color={191,0,0}));
    connect(outerWall_East.thermStarComb_inside, thermStar_Demux.thermStarComb)
      annotation (Line(
        points={{26,-60},{28,-60},{28,-56},{-32.1,-56},{-32.1,-41.4}},
        color={191,0,0}));
    connect(outerWall_North.thermStarComb_inside, thermStar_Demux.thermStarComb)
      annotation (Line(
        points={{60,4},{46,4},{46,-56},{-32.1,-56},{-32.1,-41.4}},
        color={191,0,0}));
    connect(outerWall_West.thermStarComb_inside, thermStar_Demux.thermStarComb)
      annotation (Line(
        points={{26,74},{26,60},{46,60},{46,-56},{-32.1,-56},{-32.1,-41.4}},
        color={191,0,0}));
    connect(ceiling.thermStarComb_inside, thermStar_Demux.thermStarComb)
      annotation (Line(
        points={{-32,76},{-32,60},{46,60},{46,-56},{-32.1,-56},{-32.1,-41.4}},
        color={191,0,0}));
    connect(ceiling.port_outside, Therm_outside) annotation (Line(
        points={{-32,80.1},{-32,88},{-86,88},{-86,97},{-105,97}},
        color={191,0,0}));
    connect(outerWall_East.WindSpeedPort, WindSpeedPort) annotation (Line(
        points={{8.4,-68.2},{8.4,-80},{-86,-80},{-86,28},{-112,28}},
        color={0,0,127}));
    connect(ceiling.WindSpeedPort, WindSpeedPort) annotation (Line(
        points={{-23.2,80.1},{-23.2,88},{-86,88},{-86,28},{-112,28}},
        color={0,0,127}));
    connect(outerWall_North.WindSpeedPort, WindSpeedPort) annotation (Line(
        points={{74.35,33.3333},{82,33.3333},{82,-80},{-86,-80},{-86,28},{-112,28}},
        color={0,0,127}));

    connect(outerWall_West.WindSpeedPort, WindSpeedPort) annotation (Line(
        points={{43.6,82.2},{43.6,88},{-86,88},{-86,28},{-112,28}},
        color={0,0,127}));

    connect(outerWall_South.solarRadWinTrans, floor.solarRadWin) annotation (Line(
        points={{-60.25,-16.6667},{-54,-16.6667},{-54,-56},{-40.8,-56},{-40.8,-61.8}},
        color={0,0,127}));

    connect(outerWall_South.solarRadWinTrans, outerWall_East.solarRadWin)
      annotation (Line(
        points={{-60.25,-16.6667},{-54,-16.6667},{-54,-56},{8.4,-56},{8.4,-59.6}},
        color={0,0,127}));

    connect(outerWall_South.solarRadWinTrans, outerWall_South.solarRadWin)
      annotation (Line(
        points={{-60.25,-16.6667},{-54,-16.6667},{-54,33.3333},{-61.3,33.3333}},
        color={0,0,127}));

    connect(outerWall_South.solarRadWinTrans, ceiling.solarRadWin) annotation (
        Line(
        points={{-60.25,-16.6667},{-54,-16.6667},{-54,60},{-23.2,60},{-23.2,75.8}},
        color={0,0,127}));

    connect(outerWall_North.solarRadWin, outerWall_South.solarRadWinTrans)
      annotation (Line(
        points={{59.3,33.3333},{46,33.3333},{46,60},{-54,60},{-54,-16.6667},{-60.25,
            -16.6667}},
        color={0,0,127}));
    connect(SolarRadiationPort[3], outerWall_South.SolarRadiationPort)
      annotation (Line(
        points={{-110,60},{-86,60},{-86,40.6667},{-78.1,40.6667}},
        color={255,128,0}));
    connect(ceiling.SolarRadiationPort, SolarRadiationPort[5]) annotation (
        Line(
        points={{-21,80.6},{-21,88},{-86,88},{-86,68},{-110,68}},
        color={255,128,0}));
    connect(outerWall_West.SolarRadiationPort, SolarRadiationPort[4]) annotation (
       Line(
        points={{48,83.2},{48,88},{-86,88},{-86,64},{-110,64}},
        color={255,128,0}));
    connect(outerWall_North.SolarRadiationPort, SolarRadiationPort[1])
      annotation (Line(
        points={{76.1,40.6667},{82,40.6667},{82,-80},{-86,-80},{-86,52},{-110,52}},
        color={255,128,0}));

    connect(outerWall_East.SolarRadiationPort, SolarRadiationPort[2]) annotation (
       Line(
        points={{4,-69.2},{4,-80},{-86,-80},{-86,56},{-110,56}},
        color={255,128,0}));
    connect(outerWall_South.solarRadWinTrans, outerWall_West.solarRadWin)
      annotation (Line(
        points={{-60.25,-16.6667},{-54,-16.6667},{-54,60},{43.6,60},{43.6,73.6}},
        color={0,0,127}));
    connect(varAirExchange.port_a, Therm_outside) annotation (Line(
        points={{-82,-56},{-86,-56},{-86,97},{-105,97}},
        color={191,0,0}));
    connect(thermStar_Demux.therm, airload.port) annotation (Line(
        points={{-37.1,-21.9},{-37.1,-10.8},{10.9,-10.8}},
        color={191,0,0}));
    connect(airload.port, temperatureSensor.port) annotation (Line(
        points={{10.9,-10.8},{4,-10.8},{4,-29},{32,-29}},
        color={191,0,0}));
    connect(varAirExchange.port_b, airload.port) annotation (Line(
        points={{-62,-56},{4,-56},{4,-10.8},{10.9,-10.8}},
        color={191,0,0}));
    annotation ( Icon(coordinateSystem(extent={{-100,-100},
              {100,100}}, preserveAspectRatio=false),
                                        graphics={
          Rectangle(
            extent={{-100,92},{94,-92}},
            lineColor={215,215,215},
            fillColor={0,127,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-86,76},{80,-80}},
            lineColor={135,135,135},
            fillColor={135,135,135},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-100,26},{-86,-34}},
            lineColor={170,213,255},
            fillColor={170,213,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-22,12},{22,-12}},
            lineColor={0,0,0},
            fillColor={175,175,175},
            fillPattern=FillPattern.Solid,
            textString="Window",
            textStyle={TextStyle.Bold},
            origin={-94,-2},
            rotation=90),
          Text(
            extent={{-54,-54},{54,-76}},
            lineColor={0,0,0},
            fillColor={175,175,175},
            fillPattern=FillPattern.Solid,
            textString="Length"),
          Text(
            extent={{-22,11},{22,-11}},
            lineColor={0,0,0},
            fillColor={175,175,175},
            fillPattern=FillPattern.Solid,
            textString="width",
            origin={65,0},
            rotation=90)}),
      Documentation(revisions="<html>
 <ul>
 <li><i>March 9, 2015</i> by Ana Constantin:<br/>Implemented</li>
 </ul>
 </html>",  info="<html>
</html>"));
  end HighOrder_ASHRAE140_SouthFacingWindows;

  model ReducedOrder_FourElements "Thermal Zone with four elements for exterior walls,
  interior walls, floor plate and roof"
    extends ThermalZones.ReducedOrder.RC.ThreeElements(AArray={ATotExt,ATotWin,
          AInt,AFloor,ARoof});

    parameter Modelica.SIunits.Area ARoof "Area of roof"
      annotation(Dialog(group="Roof"));
    parameter Modelica.SIunits.CoefficientOfHeatTransfer hConvRoof "Convective coefficient of heat transfer of roof (indoor)"
      annotation(Dialog(group="Roof"));
    parameter Integer nRoof(min = 1) "Number of RC-elements of roof"
      annotation(Dialog(group="Roof"));
    parameter Modelica.SIunits.ThermalResistance RRoof[nExt](
      each min=Modelica.Constants.small)
      "Vector of resistances of roof, from inside to outside"
      annotation(Dialog(group="Roof"));
    parameter Modelica.SIunits.ThermalResistance RRoofRem(
      min=Modelica.Constants.small)
      "Resistance of remaining resistor RRoofRem between capacity n and outside"
      annotation(Dialog(group="Roof"));
    parameter Modelica.SIunits.HeatCapacity CRoof[nExt](
      each min=Modelica.Constants.small)
      "Vector of heat capacities of roof, from inside to outside"
      annotation(Dialog(group="Roof"));
    parameter Boolean indoorPortRoof = false
      "Additional heat port at indoor surface of roof"
      annotation(Dialog(group="Roof"),choices(checkBox = true));

    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a roof if ARoof > 0
      "Ambient port for roof"
        annotation (Placement(transformation(extent={{-21,170},{-1,190}}),
                         iconTransformation(extent={{-21,170},{-1,190}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a roofIndoorSurface if
       indoorPortRoof "Auxiliary port at indoor surface of roof"
        annotation (Placement(
        transformation(extent={{-50,-190},{-30,-170}}), iconTransformation(
        extent={{-50,-190},{-30,-170}})));
    ThermalZones.ReducedOrder.RC.BaseClasses.ExteriorWall roofRC(
      final RExt=RRoof,
      final RExtRem=RRoofRem,
      final CExt=CRoof,
      final n=nRoof,
      final T_start=T_start) if ARoof > 0 "RC-element for roof" annotation (
        Placement(transformation(
          extent={{-10,-11},{10,11}},
          rotation=90,
          origin={-12,155})));

  protected
    Modelica.Thermal.HeatTransfer.Components.Convection convRoof if
       ARoof > 0 "Convective heat transfer of roof"
      annotation (Placement(transformation(
      extent={{10,10},{-10,-10}},
      rotation=90,
      origin={-12,120})));
    Modelica.Blocks.Sources.Constant hConvRoof_const(final k=ARoof*hConvRoof) "Coefficient of convective heat transfer for roof"
       annotation (Placement(transformation(extent={{-5,-5},{5,5}}, rotation=180)));
    Modelica.Thermal.HeatTransfer.Components.ThermalConductor resIntRoof(final G=min(AInt, ARoof)*hRad) if AInt > 0 and ARoof > 0
      "Resistor between interior walls and roof"
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={186,10})));
    Modelica.Thermal.HeatTransfer.Components.ThermalConductor resRoofWin(final G=min(ARoof, ATotWin)*hRad) if ARoof > 0 and ATotWin > 0
      "Resistor between roof and windows" annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={-154,100})));
    Modelica.Thermal.HeatTransfer.Components.ThermalConductor resRoofFloor(final G=min(ARoof, AFloor)*hRad) if ARoof > 0 and AFloor > 0
      "Resistor between floor plate and roof"
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-56,-112})));
    Modelica.Thermal.HeatTransfer.Components.ThermalConductor resExtWallRoof(final G=min(ATotExt, ARoof)*hRad) if ATotExt > 0 and ARoof > 0
      "Resistor between exterior walls and roof" annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={-108,6})));

  equation
    connect(convRoof.solid, roofRC.port_a)
      annotation (Line(points={{-12,130},{-12,138},{-12,145},{-11,145}},
                                                       color={191,0,0}));
    connect(roofRC.port_b, roof)
      annotation (Line(points={{-11,165},{-11,168},{-11,180}},
                                                       color={191,0,0}));
    connect(resRoofWin.port_a, convWin.solid)
      annotation (Line(points={{-164,100},{-174,100},{-174,82},{-146,82},{-146,40},
            {-116,40}},                                         color={191,
      0,0}));
    connect(resRoofWin.port_b, convRoof.solid)
      annotation (Line(points={{-144,100},
      {-114,100},{-82,100},{-82,132},{-12,132},{-12,130}}, color={191,0,0}));
    connect(resRoofFloor.port_a, convRoof.solid)
      annotation (Line(points={{-56,-102},
      {-54,-102},{-54,132},{-12,132},{-12,130}}, color={191,0,0}));
    connect(resRoofFloor.port_b, resExtWallFloor.port_b)
      annotation (Line(
      points={{-56,-122},{-56,-132},{-144,-132},{-144,-121}}, color={191,0,0}));
    connect(resIntRoof.port_b, intWallRC.port_a)
      annotation (Line(points={{186,0},{186,-10},{168,-10},{168,-40},{182,-40}},
                                                 color={191,0,0}));
    connect(resIntRoof.port_a, convRoof.solid)
      annotation (Line(points={{186,20},
      {186,20},{186,132},{-12,132},{-12,130}}, color={191,0,0}));
    connect(resExtWallRoof.port_a, convExtWall.solid)
      annotation (Line(points={{-118,6},{-130,6},{-130,-12},{-144,-12},{-144,-40},
            {-114,-40}},                                        color={191,
      0,0}));
    connect(resExtWallRoof.port_b, convRoof.solid)
      annotation (Line(points={{-98,
      6},{-54,6},{-54,132},{-12,132},{-12,130}}, color={191,0,0}));
    if not ATotExt > 0 and not ATotWin > 0 and not AInt > 0 and not AFloor > 0
      and ARoof > 0 then
      connect(thermSplitterIntGains.portOut[1], roofRC.port_a);
      connect(roofRC.port_a, thermSplitterSolRad.portOut[1]);
    elseif ATotExt > 0 and not ATotWin > 0 and not AInt > 0 and not AFloor > 0
      and ARoof > 0
       or not ATotExt > 0 and ATotWin > 0 and not AInt > 0 and not AFloor > 0
       and ARoof > 0
       or not ATotExt > 0 and not ATotWin > 0 and AInt > 0 and not AFloor > 0
       and ARoof > 0
       or not ATotExt > 0 and not ATotWin > 0 and not AInt > 0 and AFloor > 0
       and ARoof > 0 then
      connect(thermSplitterIntGains.portOut[2], roofRC.port_a);
      connect(roofRC.port_a, thermSplitterSolRad.portOut[2]);
    elseif ATotExt > 0 and ATotWin > 0 and not AInt > 0 and not AFloor > 0 and ARoof > 0
       or ATotExt > 0 and not ATotWin > 0 and AInt > 0 and not AFloor > 0 and ARoof > 0
       or ATotExt > 0 and not ATotWin > 0 and not AInt > 0 and AFloor > 0 and ARoof > 0
       or not ATotExt > 0 and ATotWin > 0 and AInt > 0 and not AFloor > 0 and ARoof > 0
       or not ATotExt > 0 and ATotWin > 0 and not AInt > 0 and AFloor > 0 and ARoof > 0
       or not ATotExt > 0 and not ATotWin > 0 and AInt > 0 and AFloor > 0
       and ARoof > 0 then
      connect(thermSplitterIntGains.portOut[3], roofRC.port_a);
      connect(roofRC.port_a, thermSplitterSolRad.portOut[3]);
    elseif not ATotExt > 0 and ATotWin > 0 and AInt > 0 and AFloor > 0 and ARoof > 0
       or ATotExt > 0 and not ATotWin > 0 and AInt > 0 and AFloor > 0 and ARoof > 0
       or ATotExt > 0 and ATotWin > 0 and not AInt > 0 and AFloor > 0 and ARoof > 0
       or ATotExt > 0 and ATotWin > 0 and AInt > 0 and not AFloor > 0 and ARoof > 0 then
      connect(thermSplitterIntGains.portOut[4], roofRC.port_a);
      connect(roofRC.port_a, thermSplitterSolRad.portOut[4]);
    elseif ATotExt > 0 and ATotWin > 0 and AInt > 0 and AFloor > 0 and ARoof > 0 then
      connect(thermSplitterSolRad.portOut[5], roofRC.port_a)
      annotation (Line(
      points={{-122,146},{-122,146},{-38,146},{-38,142},{-11,142},{-11,145}},
      color={191,0,0}));
      connect(thermSplitterIntGains.portOut[5], roofRC.port_a)
      annotation (Line(points={{190,86},{190,86},{190,138},{-11,138},{-11,145}},
      color={191,0,0}));
    end if;
    connect(hConvRoof_const.y, convRoof.Gc) annotation (Line(points={{-5.5,0},{-2,0},{-2,120}}, color={0,0,127}));
    connect(convRoof.fluid, senTAir.port)
      annotation (Line(points={{-12,110},{-12,110},{-12,96},{66,96},{66,0},{80,0}},
                                                   color={191,0,0}));
    connect(roofRC.port_a, roofIndoorSurface)
      annotation (Line(points={{-11,145},{-11,136},{-112,136},{-112,112},{-216,
            112},{-216,-140},{-40,-140},{-40,-180}},
      color={191,0,0}));
    annotation (defaultComponentName="theZon",
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-240,
    -180},{240,180}}), graphics={
    Rectangle(
      extent={{-36,170},{46,104}},
      lineColor={0,0,255},
      fillColor={215,215,215},
      fillPattern=FillPattern.Solid),
    Text(
      extent={{16,168},{46,156}},
      lineColor={0,0,255},
      fillColor={215,215,215},
      fillPattern=FillPattern.Solid,
      textString="Roof")}),
      Icon(coordinateSystem(preserveAspectRatio=false,
      extent={{-240,-180},{240,180}}),
    graphics={Rectangle(
    extent={{-40,50},{28,-44}},
    pattern=LinePattern.None,
    fillColor={230,230,230},
    fillPattern=FillPattern.Solid), Text(
    extent={{-60,60},{64,-64}},
    lineColor={0,0,0},
    textString="4")}),
    Documentation(revisions="<html><ul>
  <li>August 31, 2018 by Moritz Lauster:<br/>
    Updated schema in documentation and fixes orientation and
    connections of roofRC for <a href=
    \"https://github.com/ibpsa/modelica-ibpsa/issues/997\">issue 997</a>.
  </li>
  <li>September 11, 2015 by Moritz Lauster:<br/>
    First Implementation.
  </li>
</ul>
</html>",   info="<html>
<p>
  This model adds another element for the roof. Roofs commonly exhibit
  the same excitations as exterior walls but have different
  coefficients of heat transfer due to their orientation. Adding an
  extra element for the roof might lead to a finer resolution of the
  dynamic behaviour but increases calculation times. The roof is
  parameterized via the length of the RC-chain <code>nRoof</code>, the
  vector of capacities <code>CRoof[nRoof]</code>, the vector of
  resistances <code>RRoof[nRoof]</code> and remaining resistances
  <code>RRoofRem</code>.
</p>
<p>
  The image below shows the RC-network of this model.
</p>
<p align=\"center\">
  <img src=
  \"modelica://AixLib/Resources/Images/ThermalZones/ReducedOrder/RC/FourElements.png\"
  alt=\"image\" />
</p>
</html>"));
  end ReducedOrder_FourElements;

  model HighOrder "Test of high order modeling"
    extends Modelica.Icons.Example;
    ThermalZones.ReducedOrder.RC.FourElements theZon
      annotation (Placement(transformation(extent={{-26,40},{22,76}})));
    ThermalZones.HighOrder.Rooms.ASHRAE140.SouthFacingWindows
      southFacingWindows(Room_Lenght=1)
      annotation (Placement(transformation(extent={{-26,-40},{28,6}})));
  end HighOrder;
end BenchmarkModel_reworked_TestModularization;
