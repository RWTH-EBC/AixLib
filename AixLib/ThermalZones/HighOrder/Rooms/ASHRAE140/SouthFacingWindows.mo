within AixLib.ThermalZones.HighOrder.Rooms.ASHRAE140;
model SouthFacingWindows "windows facing south"

  parameter Modelica.SIunits.Length Room_Lenght=6 "length" annotation (Dialog(group = "Dimensions", descriptionLabel = true));
    parameter Modelica.SIunits.Height Room_Height=2.7 "height" annotation (Dialog(group = "Dimensions", descriptionLabel = true));
    parameter Modelica.SIunits.Length Room_Width=8 "width"
                                                          annotation (Dialog(group = "Dimensions", descriptionLabel = true));

    parameter Modelica.SIunits.Area Win_Area= 12 "Window area " annotation (Dialog(group = "Windows", descriptionLabel = true, enable = withWindow1));
    // Sunblind
    parameter Boolean use_sunblind = false
      "Will sunblind become active automatically?"
      annotation(Dialog(group = "Sunblind"));
    parameter Real ratioSunblind(min=0.0, max=1.0)
      "Sunblind factor. 1 means total blocking of irradiation, 0 no sunblind"
      annotation(Dialog(group = "Sunblind", enable=use_sunblind));
    parameter Modelica.SIunits.Irradiance solIrrThreshold(min=0.0)
      "Threshold for global solar irradiation on this surface to enable sunblinding (see also TOutAirLimit)"
      annotation(Dialog(group = "Sunblind", enable=use_sunblind));
    parameter Modelica.SIunits.Temperature TOutAirLimit
      "Temperature at which sunblind closes (see also solIrrThreshold)"
      annotation(Dialog(group = "Sunblind", enable=use_sunblind));

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
      final withSunblind=use_sunblind,
      final Blinding=1-ratioSunblind,
      final LimitSolIrr=solIrrThreshold,
      final TOutAirLimit=TOutAirLimit,
      windowarea=Win_Area,
      wall_height=Room_Height,
      surfaceType=AixLib.DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
      WindowType=AixLib.DataBase.WindowsDoors.Simple.WindowSimple_ASHRAE140())
      annotation (Placement(transformation(extent={{-76,-36},{-62,44}})));
    AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 outerWall_West(
      wall_length=Room_Lenght,
      wall_height=Room_Height,
      withDoor=false,
      T0=T0_IW,
      outside=true,
      final withSunblind=use_sunblind,
      final Blinding=1-ratioSunblind,
      final LimitSolIrr=solIrrThreshold,
      final TOutAirLimit=TOutAirLimit,
      WallType=TypOW,
      solar_absorptance=solar_absorptance_OW,
      surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
      Model=2) annotation (Placement(transformation(
          extent={{-4,-24},{4,24}},
          rotation=-90,
          origin={26,78})));
    AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 outerWall_East(
      wall_length=Room_Lenght,
      wall_height=Room_Height,
      T0=T0_IW,
      outside=true,
      final withSunblind=use_sunblind,
      final Blinding=1-ratioSunblind,
      final LimitSolIrr=solIrrThreshold,
      final TOutAirLimit=TOutAirLimit,
      WallType=TypOW,
      solar_absorptance=solar_absorptance_OW,
      surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
      Model=2) annotation (Placement(transformation(
          extent={{-4.00001,-24},{4.00001,24}},
          rotation=90,
          origin={26,-64})));
    AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 outerWall_North(
      wall_height=Room_Height,
      U_door=5.25,
      door_height=1,
      door_width=2,
      withDoor=false,
      T0=T0_IW,
      wall_length=Room_Width,
      outside=true,
      WallType=TypOW,
      final withSunblind=use_sunblind,
      final Blinding=1-ratioSunblind,
      final LimitSolIrr=solIrrThreshold,
      final TOutAirLimit=TOutAirLimit,
      solar_absorptance=solar_absorptance_OW,
      surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
      Model=2) annotation (Placement(transformation(extent={{74,-36},{60,44}})));
    AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 ceiling(
      wall_length=Room_Lenght,
      wall_height=Room_Width,
      ISOrientation=3,
      withDoor=false,
      T0=T0_CE,
      WallType=TypCE,
      outside=true,
      final withSunblind=use_sunblind,
      final Blinding=1-ratioSunblind,
      final LimitSolIrr=solIrrThreshold,
      final TOutAirLimit=TOutAirLimit,
      solar_absorptance=solar_absorptance_OW,
      surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster(),
      Model=2) annotation (Placement(transformation(
          extent={{-2,-12},{2,12}},
          rotation=270,
          origin={-32,78})));
    AixLib.ThermalZones.HighOrder.Components.Walls.Wall_ASHRAE140 floor(
      wall_length=Room_Lenght,
      wall_height=Room_Width,
      withDoor=false,
      ISOrientation=2,
      T0=T0_FL,
      WallType=TypFL,
      solar_absorptance=solar_absorptance_OW,
      outside=false,
      final withSunblind=use_sunblind,
      final Blinding=1-ratioSunblind,
      final LimitSolIrr=solIrrThreshold,
      final TOutAirLimit=TOutAirLimit,
      Model=2) annotation (Placement(transformation(
          extent={{-2.00031,-12},{2.00003,12}},
          rotation=90,
          origin={-32,-64})));
    Components.DryAir.Airload
                         airload(
      V=Room_V,
      c=1005) annotation (Placement(transformation(extent={{10,-18},{28,0}})));
    Utilities.Interfaces.Adaptors.HeatStarToComb
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
        points={{74.35,33.3333},{82,33.3333},{82,-80},{-86,-80},{-86,28},{-112,
          28}},
        color={0,0,127}));

    connect(outerWall_West.WindSpeedPort, WindSpeedPort) annotation (Line(
        points={{43.6,82.2},{43.6,88},{-86,88},{-86,28},{-112,28}},
        color={0,0,127}));

    connect(outerWall_South.solarRadWinTrans, floor.solarRadWin) annotation (Line(
        points={{-60.25,-16.6667},{-54,-16.6667},{-54,-56},{-40.8,-56},{-40.8,
          -61.8}},
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
        points={{-60.25,-16.6667},{-54,-16.6667},{-54,60},{-23.2,60},{-23.2,
          75.8}},
        color={0,0,127}));

    connect(outerWall_North.solarRadWin, outerWall_South.solarRadWinTrans)
      annotation (Line(
        points={{59.3,33.3333},{46,33.3333},{46,60},{-54,60},{-54,-16.6667},{
          -60.25,-16.6667}},
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
        points={{76.1,40.6667},{82,40.6667},{82,-80},{-86,-80},{-86,52},{-110,
          52}},
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
end SouthFacingWindows;
