within AixLib.Obsolete.Year2022.ThermalZones.HighOrder.Rooms;
package MFD "Multiple Family Dweling"
  extends Modelica.Icons.Package;

  package OneAppartment
    extends Modelica.Icons.Package;

    model Bathroom_VoWo "Bathroom from the VoWo appartment"
      ///////// construction parameters
      parameter Integer TMC = 1 "Thermal Mass Class" annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice = 1 "Heavy", choice = 2 "Medium", choice = 3 "Light", radioButtons = true));
      parameter Integer TIR = 4 "Thermal Insulation Regulation" annotation(Dialog(groupImage = "modelica://AixLib/Resources/Images/Building/HighOrder/VoWo_Bath.png", group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice = 1
            "EnEV_2009",                                                                                                    choice = 2
            "EnEV_2002",                                                                                                    choice = 3
            "WSchV_1995",                                                                                                    choice = 4
            "WSchV_1984",                                                                                                    radioButtons = true));
      parameter Integer Floor = 1 "Floor" annotation(Dialog(group = "Floor", compact = true, descriptionLabel = true), choices(choice = 1 "GF", choice = 2 "1F", choice = 3 "2F", radioButtons = true));
      // Outer walls properties
      parameter Real solar_absorptance_OW = 0.7 "Solar absoptance outer walls " annotation(Dialog(group = "Outer wall properties", descriptionLabel = true));
      parameter Integer calcMethod=1 "Calculation method for convective heat transfer coefficient" annotation (Dialog(
          group="Outer wall properties",
          compact=true,
          descriptionLabel=true), choices(
          choice=1 "DIN 6946",
          choice=2 "ASHRAE Fundamentals",
          choice=3 "Custom hCon (constant)",
          radioButtons=true));
      //Initial temperatures
      parameter Modelica.Units.SI.Temperature T0_air=297.15 "Air"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      parameter Modelica.Units.SI.Temperature T0_Corridor=290.15 "IWCorridor"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      parameter Modelica.Units.SI.Temperature T0_IWKitchen=295.15 "IWKitchen"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      parameter Modelica.Units.SI.Temperature T0_IWBedroom=295.15 "IWBedroom"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      parameter Modelica.Units.SI.Temperature T0_OW=295.15 "OW"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      parameter Modelica.Units.SI.Temperature T0_CE=295.35 "Ceiling"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      parameter Modelica.Units.SI.Temperature T0_FL=294.95 "Floor"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      // Sunblind
      parameter Boolean use_sunblind = false
        "Will sunblind become active automatically?"
        annotation(Dialog(group = "Sunblind"));
      parameter Real ratioSunblind(min=0.0, max=1.0) = 0.8
        "Sunblind factor. 1 means total blocking of irradiation, 0 no sunblind"
        annotation(Dialog(group = "Sunblind", enable=use_sunblind));
      parameter Modelica.Units.SI.Irradiance solIrrThreshold(min=0.0) = 350
        "Threshold for global solar irradiation on this surface to enable sunblinding (see also TOutAirLimit)"
        annotation (Dialog(group="Sunblind", enable=use_sunblind));
      parameter Modelica.Units.SI.Temperature TOutAirLimit
        "Temperature at which sunblind closes (see also solIrrThreshold)"
        annotation (Dialog(group="Sunblind", enable=use_sunblind));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Corridor(
        redeclare final model WindowModel=WindowModel,
        redeclare final model CorrSolarGainWin=CorrSolarGainWin,
        T0=T0_Corridor,
        outside=false,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        wallPar=Type_IWsimple,
        wall_length=1.31,
        wall_height=2.46,
        withWindow=false,
        withDoor=false) annotation (Placement(transformation(
            origin={7,37},
            extent={{-7,-39},{7,39}},
            rotation=270)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Bedroom(
        redeclare final model WindowModel=WindowModel,
        redeclare final model CorrSolarGainWin=CorrSolarGainWin,
        T0=T0_IWBedroom,
        outside=false,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        wallPar=Type_IWload,
        wall_length=3.28,
        wall_height=2.46,
        withWindow=false,
        withDoor=false) annotation (Placement(transformation(extent={{-60,-76},{-46,8}})));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Kitchen1(
        redeclare final model WindowModel=WindowModel,
        redeclare final model CorrSolarGainWin=CorrSolarGainWin,
        T0=T0_IWKitchen,
        outside=false,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        wallPar=Type_IWsimple,
        wall_length=3.28,
        wall_height=2.46,
        withWindow=false,
        withDoor=false) annotation (Placement(transformation(
            origin={58,-22},
            extent={{-6,-36},{6,36}},
            rotation=180)));
      AixLib.ThermalZones.HighOrder.Components.DryAir.Airload airload(
        final T0=T0_air,
        final V=room_V)
        annotation (Placement(transformation(extent={{-12,-26},{8,-6}})));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Kitchen2(
        redeclare final model WindowModel=WindowModel,
        redeclare final model CorrSolarGainWin=CorrSolarGainWin,
        T0=T0_IWKitchen,
        outside=false,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        wallPar=Type_IWsimple,
        wall_length=0.44,
        wall_height=2.46,
        withWindow=false,
        withDoor=false) annotation (Placement(transformation(
            origin={77,-59},
            extent={{-3,-15},{3,15}},
            rotation=270)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall outsideWall(
        redeclare final model WindowModel=WindowModel,
        redeclare final model CorrSolarGainWin=CorrSolarGainWin,
        wall_height=2.46,
        windowarea=0.75,
        wall_length=1.75,
        withWindow=true,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        T0=T0_OW,
        solar_absorptance=solar_absorptance_OW,
        withDoor=false,
        wallPar=Type_OW,
        WindowType=Type_Win) annotation (Placement(transformation(
            origin={8,-105},
            extent={{-11,-66},{11,66}},
            rotation=90)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Ceiling(
        redeclare final model WindowModel=WindowModel,
        redeclare final model CorrSolarGainWin=CorrSolarGainWin,
        T0=T0_CE,
        outside=false,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        wallPar=Type_CE,
        wall_length=sqrt(4.65),
        wall_height=sqrt(4.65),
        ISOrientation=3,
        withWindow=false,
        withDoor=false) annotation (Placement(transformation(
            origin={106,-80},
            extent={{-1.99998,-10},{1.99998,10}},
            rotation=270)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Floor(
        redeclare final model WindowModel=WindowModel,
        redeclare final model CorrSolarGainWin=CorrSolarGainWin,
        T0=T0_FL,
        outside=false,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        wallPar=Type_FL,
        wall_length=sqrt(4.65),
        wall_height=sqrt(4.65),
        ISOrientation=2,
        withWindow=false,
        withDoor=false) annotation (Placement(transformation(
            origin={106,-116},
            extent={{-1.99983,-10},{1.99984,10}},
            rotation=90)));
      AixLib.ThermalZones.HighOrder.Components.DryAir.InfiltrationRate_DIN12831
        infiltrationRate(
        room_V=room_V,
        n50=n50,
        e=e,
        eps=eps) annotation (Placement(transformation(extent={{-42,60},{-16,86}})));
      AixLib.Utilities.Interfaces.SolarRad_in SolarRadiation_NW annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-56,-150})));
      Modelica.Blocks.Interfaces.RealInput WindSpeedPort annotation(Placement(transformation(extent = {{-122, -30}, {-82, 10}}), iconTransformation(extent = {{-110, 12}, {-94, 28}})));
      Modelica.Blocks.Interfaces.RealInput AirExchangePort annotation(Placement(transformation(extent = {{-122, 0}, {-82, 40}}), iconTransformation(extent = {{-110, 52}, {-94, 68}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermOutside annotation(Placement(transformation(extent = {{-110, 80}, {-90, 100}}), iconTransformation(extent = {{-110, 80}, {-90, 100}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCorridor annotation(Placement(transformation(extent = {{-110, -20}, {-90, 0}}), iconTransformation(extent = {{-110, -20}, {-90, 0}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermKitchen annotation(Placement(transformation(extent = {{-110, -50}, {-90, -30}}), iconTransformation(extent = {{-110, -50}, {-90, -30}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermBedroom annotation(Placement(transformation(extent = {{-110, -80}, {-90, -60}}), iconTransformation(extent = {{-110, -80}, {-90, -60}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling annotation(Placement(transformation(extent = {{-110, -110}, {-90, -90}}), iconTransformation(extent = {{-110, -110}, {-90, -90}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor annotation(Placement(transformation(extent = {{-110, -140}, {-90, -120}}), iconTransformation(extent = {{-110, -140}, {-90, -120}})));
      AixLib.Utilities.Interfaces.RadPort StarRoom annotation (Placement(
            transformation(extent={{10,-54},{30,-34}}), iconTransformation(
              extent={{10,-54},{30,-34}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermRoom annotation(Placement(transformation(extent = {{-28, -52}, {-8, -32}}), iconTransformation(extent = {{-28, -52}, {-8, -32}})));
      AixLib.Utilities.Interfaces.Adaptors.ConvRadToCombPort thermStar_Demux annotation (Placement(transformation(
            extent={{-10,8},{10,-8}},
            rotation=90,
            origin={0,-68})));
      AixLib.ThermalZones.HighOrder.Components.DryAir.VarAirExchange
        NaturalVentilation(V=room_V)
        annotation (Placement(transformation(extent={{16,68},{44,94}})));

      replaceable model WindowModel =
          AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.PartialWindow
        constrainedby
        AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.PartialWindow
                                                                                                      annotation (Dialog(tab="Outer walls", group="Windows"), choicesAllMatching = true);

      replaceable model CorrSolarGainWin =
          AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.CorrectionSolarGain.PartialCorG
        constrainedby
        AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.CorrectionSolarGain.PartialCorG
                                                                                                                        "Correction model for solar irradiance as transmitted radiation" annotation (choicesAllMatching=true, Dialog(tab="Outer walls", group="Windows", enable = withWindow and outside));

    protected
      parameter Real n50(unit = "h-1") = if TIR == 1 or TIR == 2 then 3 else if TIR == 3 then 4 else 6
        "Air exchange rate at 50 Pa pressure difference"                                                                                                annotation(Dialog(tab = "Infiltration"));
      parameter Real e = 0.03 "Coefficient of windshield" annotation(Dialog(tab = "Infiltration"));
      parameter Real eps = 1.0 "Coefficient of height" annotation(Dialog(tab = "Infiltration"));
      // Outer wall type
      parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_OW = if TIR == 1 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_M() else AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_L() else if TIR == 2 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_S() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_M() else AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_L() else if TIR == 3 then if TMC == 1 then AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_S() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_M() else AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_L() else if TMC == 1 then AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_S() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_M() else AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_L() annotation(Dialog(tab = "Types"));
      //Inner wall Types
      parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_IWsimple = if TIR == 1 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_S_half() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_M_half() else AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_L_half() else if TIR == 2 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_S_half() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_M_half() else AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_L_half() else if TIR == 3 then if TMC == 1 then AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_S_half() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_M_half() else AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_L_half() else if TMC == 1 then AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_S_half() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_M_half() else AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_L_half() annotation(Dialog(tab = "Types"));
      parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_IWload = if TIR == 1 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_M_half() else AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_L_half() else if TIR == 2 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_S_half() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_M_half() else AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_L_half() else if TIR == 3 then if TMC == 1 then AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_S_half() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_M_half() else AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_L_half() else if TMC == 1 then AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_S_half() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_M_half() else AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_L_half() annotation(Dialog(tab = "Types"));
      // Floor type
      parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_FL = if Floor == 1 then if TIR == 1 then AixLib.DataBase.Walls.EnEV2009.Floor.FLcellar_EnEV2009_SML_upHalf() else if TIR == 2 then AixLib.DataBase.Walls.EnEV2002.Floor.FLcellar_EnEV2002_SML_upHalf() else if TIR == 3 then AixLib.DataBase.Walls.WSchV1995.Floor.FLcellar_WSchV1995_SML_upHalf() else AixLib.DataBase.Walls.WSchV1984.Floor.FLcellar_WSchV1984_SML_upHalf() else if TIR == 1 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_SM_upHalf() else AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_L_upHalf() else if TIR == 2 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.EnEV2002.Floor.FLpartition_EnEV2002_SM_upHalf() else AixLib.DataBase.Walls.EnEV2002.Floor.FLpartition_EnEV2002_L_upHalf() else if TIR == 3 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.WSchV1995.Floor.FLpartition_WSchV1995_SM_upHalf() else AixLib.DataBase.Walls.WSchV1995.Floor.FLpartition_WSchV1995_L_upHalf() else if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.WSchV1984.Floor.FLpartition_WSchV1984_SM_upHalf() else AixLib.DataBase.Walls.WSchV1984.Floor.FLpartition_WSchV1984_L_upHalf() annotation(Dialog(tab = "Types"));
      // Ceiling  type
      parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_CE = if Floor == 1 or Floor == 2 then if TIR == 1 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_SM_loHalf() else AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_L_loHalf() else if TIR == 2 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.EnEV2002.Ceiling.CEpartition_EnEV2002_SM_loHalf() else AixLib.DataBase.Walls.EnEV2002.Ceiling.CEpartition_EnEV2002_L_loHalf() else if TIR == 3 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.WSchV1995.Ceiling.CEpartition_WSchV1995_SM_loHalf() else AixLib.DataBase.Walls.WSchV1995.Ceiling.CEpartition_WSchV1995_L_loHalf() else if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.WSchV1984.Ceiling.CEpartition_WSchV1984_SM_loHalf() else AixLib.DataBase.Walls.WSchV1984.Ceiling.CEpartition_WSchV1984_L_loHalf() else if TIR == 1 then AixLib.DataBase.Walls.EnEV2009.Ceiling.CEattic_EnEV2009_SML_loHalf() else if TIR == 2 then AixLib.DataBase.Walls.EnEV2002.Ceiling.CEattic_EnEV2002_SML_loHalf() else if TIR == 3 then AixLib.DataBase.Walls.WSchV1995.Ceiling.CEattic_WSchV1995_SML_loHalf() else AixLib.DataBase.Walls.WSchV1984.Ceiling.CEattic_WSchV1984_SML_loHalf() annotation(Dialog(tab = "Types"));
      //Window type
      parameter AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple Type_Win = if TIR == 1 then AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009() else if TIR == 2 then AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2002() else if TIR == 3 then AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1995() else AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1984() annotation(Dialog(tab = "Types"));
      parameter Modelica.Units.SI.Volume room_V=4.65*2.46;
    equation
      connect(outsideWall.SolarRadiationPort, SolarRadiation_NW) annotation(Line(points = {{-52.5, -119.3}, {-52.5, -131.905}, {-56, -131.905}, {-56, -150}}, color = {255, 128, 0}));
      connect(outsideWall.WindSpeedPort, WindSpeedPort) annotation(Line(points = {{-40.4, -116.55}, {-40.4, -140}, {-80, -140}, {-80, -10}, {-102, -10}}, color = {0, 0, 127}));
      connect(Wall_Corridor.port_outside, thermCorridor) annotation(Line(points = {{7, 44.35}, {7, 60}, {-80, 60}, {-80, -10}, {-100, -10}}, color = {191, 0, 0}));
      connect(Wall_Kitchen1.port_outside, thermKitchen) annotation(Line(points = {{64.3, -22}, {94, -22}, {94, 60}, {-80, 60}, {-80, -40}, {-100, -40}}, color = {191, 0, 0}));
      connect(Wall_Kitchen2.port_outside, thermKitchen) annotation(Line(points = {{77, -55.85}, {94, -55.85}, {94, 60}, {-80, 60}, {-80, -40}, {-100, -40}}, color = {191, 0, 0}));
      connect(Wall_Bedroom.port_outside, thermBedroom) annotation(Line(points = {{-60.35, -34}, {-80, -34}, {-80, -70}, {-100, -70}}, color = {191, 0, 0}));
      connect(Wall_Ceiling.port_outside, thermCeiling) annotation(Line(points={{106,-77.9},{106,-60},{134,-60},{134,-140},{-80,-140},{-80,-100},{-100,-100}},
                                                                                                                         color = {191, 0, 0}));
      connect(Wall_Floor.port_outside, thermFloor) annotation(Line(points={{106,-118.1},{106,-140},{-80,-140},{-80,-130},{-100,-130}},            color = {191, 0, 0}));
      connect(infiltrationRate.port_a, thermOutside) annotation(Line(points = {{-42, 73}, {-80, 73}, {-80, 90}, {-100, 90}}, color = {191, 0, 0}));
      connect(infiltrationRate.port_b, airload.port) annotation(Line(points={{-16,73},{4,73},{4,60},{94,60},{94,16},{-36,16},{-36,-26},{-2,-26}},                   color = {191, 0, 0}));
      connect(outsideWall.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{8,-94},{8,-84},{-6.66134e-16,-84},{-6.66134e-16,-78}},
                                                                                                                                                    color={191,0,0}));
      connect(Wall_Bedroom.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-46,-34},{-36,-34},{-36,-84},{-6.66134e-16,-84},{-6.66134e-16,-78}},
                                                                                                                                                                   color={191,0,0}));
      connect(Wall_Corridor.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{7,30},{7,16},{-36,16},{-36,-84},{-6.66134e-16,-84},{-6.66134e-16,-78}},
                                                                                                                                                                       color={191,0,0}));
      connect(Wall_Kitchen1.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{52,-22},{40,-22},{40,16},{-36,16},{-36,-84},{-6.66134e-16,-84},{-6.66134e-16,-78}},
                                                                                                                                                                                   color={191,0,0}));
      connect(thermStar_Demux.portConv, ThermRoom) annotation (Line(points={{-5,-58},{-5,-42},{-18,-42}},       color={191,0,0}));
      connect(thermStar_Demux.portRad, StarRoom) annotation (Line(
          points={{5,-58},{5,-44},{20,-44}},
          color={95,95,95},
          pattern=LinePattern.Solid));
      connect(airload.port, thermStar_Demux.portConv) annotation (Line(points={{-11,-18},{-36,-18},{-36,-57.9},{-5.1,-57.9}}, color={191,0,0}));
      connect(AirExchangePort, NaturalVentilation.ventRate) annotation (Line(points=
             {{-102,20},{-80,20},{-80,60},{4,60},{4,72.68},{17.4,72.68}}, color={0,
              0,127}));
      connect(thermOutside, NaturalVentilation.port_a) annotation(Line(points = {{-100, 90}, {-80, 90}, {-80, 60}, {4, 60}, {4, 81}, {16, 81}}, color = {191, 0, 0}));
      connect(airload.port, NaturalVentilation.port_b) annotation(Line(points={{-2,-26},{-36,-26},{-36,16},{94,16},{94,60},{48,60},{48,81},{44,81}},                   color = {191, 0, 0}));
      connect(outsideWall.port_outside, thermOutside) annotation(Line(points = {{8, -116.55}, {8, -140}, {-80, -140}, {-80, 90}, {-100, 90}}, color = {191, 0, 0}));
      annotation(Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -150}, {150, 100}})),           Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -150}, {150, 100}}), graphics={  Polygon(points = {{-58, 62}, {-58, -118}, {104, -118}, {104, -58}, {42, -58}, {42, 62}, {-58, 62}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
                fillPattern =                                                                                                   FillPattern.Forward), Text(extent = {{-44, -108}, {82, -58}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
                fillPattern =                                                                                                   FillPattern.Forward, textString = "Bath"), Rectangle(extent = {{-30, -108}, {-8, -128}}, lineColor = {0, 0, 0}, fillColor = {85, 255, 255},
                fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-28, -110}, {-10, -126}}, lineColor = {0, 0, 0}, fillColor = {170, 213, 255},
                fillPattern =                                                                                                   FillPattern.Solid), Line(points = {{-24, -122}, {-14, -112}}, color = {255, 255, 255}, thickness = 1), Line(points = {{-20, -122}, {-14, -116}}, color = {255, 255, 255}, thickness = 1), Line(points = {{-24, -118}, {-18, -112}}, color = {255, 255, 255}, thickness = 1), Text(extent = {{-20, -118}, {30, -134}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   1, fillColor = {255, 255, 255},
                fillPattern =                                                                                                   FillPattern.Solid, textString = "OW"), Rectangle(extent = {{20, 92}, {40, 62}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   1, fillColor = {127, 0, 0},
                fillPattern =                                                                                                   FillPattern.Forward), Ellipse(extent = {{22, 80}, {24, 78}}, lineColor = {0, 0, 0}, pattern=LinePattern.None,
                lineThickness =                                                                                                   1,
                fillPattern =                                                                                                   FillPattern.Sphere, fillColor = {255, 255, 0}), Text(extent = {{36, 84}, {86, 68}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   1, fillColor = {255, 255, 255},
                fillPattern =                                                                                                   FillPattern.Solid, textString = "Corridor"), Rectangle(extent = {{-110, -120}, {-90, -140}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, -90}, {-90, -110}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, -60}, {-90, -80}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, -30}, {-90, -50}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, 0}, {-90, -20}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, 68}, {-90, 12}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, 100}, {-90, 80}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5)}), Documentation(revisions = "<html><ul>
  <li>
    <i>April 18, 2014</i> by Ana Constantin:<br/>
    Added documentation
  </li>
  <li>
    <i>August 16, 2011</i> by Ana Constantin:<br/>
    Implemented
  </li>
</ul>
</html>",     info = "<html>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Model for the bathroom.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The following figure presents the room's layout:
</p>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/Building/HighOrder/VoWo_Bath.png\"
  alt=\"Room layout\">
</p>
</html>"));
    end Bathroom_VoWo;

    model Bedroom_VoWo "Bedroom from the VoWo appartment"
      ///////// construction parameters
      parameter Integer TMC = 1 "Thermal Mass Class" annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice = 1 "Heavy", choice = 2 "Medium", choice = 3 "Light", radioButtons = true));
      parameter Integer TIR = 4 "Thermal Insulation Regulation" annotation(Dialog(groupImage = "modelica://AixLib/Resources/Images/Building/HighOrder/VoWo_Bedroom.png", group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice = 1
            "EnEV_2009",                                                                                                    choice = 2
            "EnEV_2002",                                                                                                    choice = 3
            "WSchV_1995",                                                                                                    choice = 4
            "WSchV_1984",                                                                                                    radioButtons = true));
      parameter Integer Floor = 1 "Floor" annotation(Dialog(group = "Floor", compact = true, descriptionLabel = true), choices(choice = 1 "GF", choice = 2 "1F", choice = 3 "2F", radioButtons = true));
      // Outer walls properties
      parameter Real solar_absorptance_OW = 0.7 "Solar absoptance outer walls " annotation(Dialog(group = "Outer wall properties", descriptionLabel = true));
      parameter Integer calcMethod=1 "Calculation method for convective heat transfer coefficient" annotation (Dialog(
          group="Outer wall properties",
          compact=true,
          descriptionLabel=true), choices(
          choice=1 "DIN 6946",
          choice=2 "ASHRAE Fundamentals",
          choice=3 "Custom hCon (constant)",
          radioButtons=true));
      //Initial temperatures
      parameter Modelica.Units.SI.Temperature T0_air=295.15 "Air"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      parameter Modelica.Units.SI.Temperature T0_OW=295.15 "OW"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      parameter Modelica.Units.SI.Temperature T0_IWLivingroom=295.15 "IWLivingroom"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      parameter Modelica.Units.SI.Temperature T0_IWCorridor=290.15 "IWCorridor"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      parameter Modelica.Units.SI.Temperature T0_IWBathroom=297.15 "IWBathroom"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      parameter Modelica.Units.SI.Temperature T0_IWNeighbour=295.15 "IWNeighbour"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      parameter Modelica.Units.SI.Temperature T0_CE=295.35 "Ceiling"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      parameter Modelica.Units.SI.Temperature T0_FL=294.95 "Floor"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      // Sunblind
      parameter Boolean use_sunblind = false
        "Will sunblind become active automatically?"
        annotation(Dialog(group = "Sunblind"));
      parameter Real ratioSunblind(min=0.0, max=1.0) = 0.8
        "Sunblind factor. 1 means total blocking of irradiation, 0 no sunblind"
        annotation(Dialog(group = "Sunblind", enable=use_sunblind));
      parameter Modelica.Units.SI.Irradiance solIrrThreshold(min=0.0) = 350
        "Threshold for global solar irradiation on this surface to enable sunblinding (see also TOutAirLimit)"
        annotation (Dialog(group="Sunblind", enable=use_sunblind));
      parameter Modelica.Units.SI.Temperature TOutAirLimit
        "Temperature at which sunblind closes (see also solIrrThreshold)"
        annotation (Dialog(group="Sunblind", enable=use_sunblind));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Livingroom(
        redeclare final model WindowModel=WindowModel,
        redeclare final model CorrSolarGainWin=CorrSolarGainWin,
        T0=T0_IWLivingroom,
        outside=false,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        wallPar=Type_IWload,
        wall_length=3.105,
        wall_height=2.46,
        withWindow=false,
        withDoor=false) annotation (Placement(transformation(
            origin={-10,42},
            extent={{-7.99999,-48},{7.99999,48}},
            rotation=270)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Neighbour(
        redeclare final model WindowModel=WindowModel,
        redeclare final model CorrSolarGainWin=CorrSolarGainWin,
        T0=T0_IWNeighbour,
        outside=false,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        wallPar=Type_IWNeigbour,
        wall_length=5.3,
        wall_height=2.46,
        withWindow=false,
        withDoor=false) annotation (Placement(transformation(extent={{-74,-58},{-60,20}})));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Bath(
        redeclare final model WindowModel=WindowModel,
        redeclare final model CorrSolarGainWin=CorrSolarGainWin,
        T0=T0_IWBathroom,
        outside=false,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        wallPar=Type_IWload,
        wall_length=3.28,
        wall_height=2.46,
        withWindow=false,
        withDoor=false) annotation (Placement(transformation(
            origin={61,-40},
            extent={{-4.99999,-28},{4.99999,28}},
            rotation=180)));
      AixLib.ThermalZones.HighOrder.Components.DryAir.Airload airload(
        final T0=T0_air,
        final V=room_V)
        annotation (Placement(transformation(extent={{30,-2},{10,18}})));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall outsideWall(
        redeclare final model WindowModel=WindowModel,
        redeclare final model CorrSolarGainWin=CorrSolarGainWin,
        wall_length=3.105,
        wall_height=2.46,
        windowarea=1.84,
        withWindow=true,
        T0=T0_OW,
        solar_absorptance=solar_absorptance_OW,
        wallPar=Type_OW,
        WindowType=Type_Win,
        outside=true,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        withDoor=false) annotation (Placement(transformation(
            origin={-4,-92},
            extent={{-10,-60},{10,60}},
            rotation=90)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Ceiling(
        redeclare final model WindowModel=WindowModel,
        redeclare final model CorrSolarGainWin=CorrSolarGainWin,
        T0=T0_CE,
        outside=false,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        wallPar=Type_CE,
        wall_length=3.105,
        wall_height=5.30,
        ISOrientation=3,
        withWindow=false,
        withDoor=false) annotation (Placement(transformation(
            origin={96,-62},
            extent={{-2,-12},{2,12}},
            rotation=270)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Floor(
        redeclare final model WindowModel=WindowModel,
        redeclare final model CorrSolarGainWin=CorrSolarGainWin,
        T0=T0_FL,
        outside=false,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        wallPar=Type_FL,
        wall_length=3.105,
        wall_height=5.30,
        ISOrientation=2,
        withWindow=false,
        withDoor=false) annotation (Placement(transformation(
            origin={96,-100},
            extent={{-1.99983,-10},{1.99984,10}},
            rotation=90)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Corridor(
        redeclare final model WindowModel=WindowModel,
        redeclare final model CorrSolarGainWin=CorrSolarGainWin,
        T0=T0_IWCorridor,
        outside=false,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        wallPar=Type_IWload,
        wall_length=1.96,
        wall_height=2.46,
        withWindow=false,
        withDoor=false) annotation (Placement(transformation(
            origin={59,16},
            extent={{-3.00002,-16},{2.99997,16}},
            rotation=180)));
      AixLib.ThermalZones.HighOrder.Components.DryAir.InfiltrationRate_DIN12831
        infiltrationRate(
        room_V=room_V,
        n50=n50,
        e=e,
        eps=eps) annotation (Placement(transformation(extent={{-44,80},{-18,106}})));
      AixLib.Utilities.Interfaces.SolarRad_in SolarRadiation_NW annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-60,-150})));
      Modelica.Blocks.Interfaces.RealInput WindSpeedPort annotation(Placement(transformation(extent = {{-128, -24}, {-88, 16}}), iconTransformation(extent = {{-110, 20}, {-90, 40}})));
      Modelica.Blocks.Interfaces.RealInput AirExchangePort annotation(Placement(transformation(extent = {{-130, 30}, {-90, 70}}), iconTransformation(extent = {{-110, 50}, {-90, 70}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermOutside annotation(Placement(transformation(extent = {{-110, 80}, {-90, 100}}), iconTransformation(extent = {{-110, 80}, {-90, 100}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermLivingroom annotation(Placement(transformation(extent = {{-110, -10}, {-90, 10}}), iconTransformation(extent = {{-110, -10}, {-90, 10}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCorridor annotation(Placement(transformation(extent = {{-110, -40}, {-90, -20}}), iconTransformation(extent = {{-110, -40}, {-90, -20}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermBath annotation(Placement(transformation(extent = {{-110, -70}, {-90, -50}}), iconTransformation(extent = {{-110, -70}, {-90, -50}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling annotation(Placement(transformation(extent = {{-110, -130}, {-90, -110}}), iconTransformation(extent = {{-110, -130}, {-90, -110}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor annotation(Placement(transformation(extent = {{-110, -160}, {-90, -140}}), iconTransformation(extent = {{-110, -160}, {-90, -140}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermNeigbour annotation(Placement(transformation(extent = {{-110, -100}, {-90, -80}}), iconTransformation(extent = {{-110, -100}, {-90, -80}})));
      AixLib.Utilities.Interfaces.RadPort StarRoom annotation (Placement(
            transformation(extent={{18,-44},{38,-24}}), iconTransformation(
              extent={{18,-44},{38,-24}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermRoom annotation(Placement(transformation(extent = {{-20, -46}, {0, -26}}), iconTransformation(extent = {{-20, -46}, {0, -26}})));
      AixLib.Utilities.Interfaces.Adaptors.ConvRadToCombPort thermStar_Demux annotation (Placement(transformation(
            extent={{-10,8},{10,-8}},
            rotation=90,
            origin={14,-60})));
      AixLib.ThermalZones.HighOrder.Components.DryAir.VarAirExchange
        NaturalVentilation(V=room_V)
        annotation (Placement(transformation(extent={{66,72},{94,98}})));

      replaceable model WindowModel =
          AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.PartialWindow
        constrainedby
        AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.PartialWindow
                                                                                                      annotation (Dialog(tab="Outer walls", group="Windows"), choicesAllMatching = true);

      replaceable model CorrSolarGainWin =
          AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.CorrectionSolarGain.PartialCorG
        constrainedby
        AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.CorrectionSolarGain.PartialCorG
                                                                                                                        "Correction model for solar irradiance as transmitted radiation" annotation (choicesAllMatching=true, Dialog(tab="Outer walls", group="Windows", enable = withWindow and outside));

    protected
      parameter Real n50(unit = "h-1") = if TIR == 1 or TIR == 2 then 3 else if TIR == 3 then 4 else 6
        "Air exchange rate at 50 Pa pressure difference"                                                                                                annotation(Dialog(tab = "Infiltration"));
      parameter Real e = 0.03 "Coefficient of windshield" annotation(Dialog(tab = "Infiltration"));
      parameter Real eps = 1.0 "Coefficient of height" annotation(Dialog(tab = "Infiltration"));
      // Outer wall type
      parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_OW = if TIR == 1 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_M() else AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_L() else if TIR == 2 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_S() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_M() else AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_L() else if TIR == 3 then if TMC == 1 then AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_S() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_M() else AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_L() else if TMC == 1 then AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_S() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_M() else AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_L() annotation(Dialog(tab = "Types"));
      //Inner wall Types
      parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_IWload = if TIR == 1 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_M_half() else AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_L_half() else if TIR == 2 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_S_half() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_M_half() else AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_L_half() else if TIR == 3 then if TMC == 1 then AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_S_half() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_M_half() else AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_L_half() else if TMC == 1 then AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_S_half() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_M_half() else AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_L_half() annotation(Dialog(tab = "Types"));
      parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_IWNeigbour = if TIR == 1 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2009.IW.IWneighbour_EnEV2009_S_half() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2009.IW.IWneighbour_EnEV2009_M_half() else AixLib.DataBase.Walls.EnEV2009.IW.IWneighbour_EnEV2009_L_half() else if TIR == 2 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2002.IW.IWneighbour_EnEV2002_S_half() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2002.IW.IWneighbour_EnEV2002_M_half() else AixLib.DataBase.Walls.EnEV2002.IW.IWneighbour_EnEV2002_L_half() else if TIR == 3 then if TMC == 1 then AixLib.DataBase.Walls.WSchV1995.IW.IWneighbour_WSchV1995_S_half() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1995.IW.IWneighbour_WSchV1995_M_half() else AixLib.DataBase.Walls.WSchV1995.IW.IWneighbour_WSchV1995_L_half() else if TMC == 1 then AixLib.DataBase.Walls.WSchV1984.IW.IWneighbour_WSchV1984_S_half() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1984.IW.IWneighbour_WSchV1984_M_half() else AixLib.DataBase.Walls.WSchV1984.IW.IWneighbour_WSchV1984_L_half() annotation(Dialog(tab = "Types"));
      // Floor type
      parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_FL = if Floor == 1 then if TIR == 1 then AixLib.DataBase.Walls.EnEV2009.Floor.FLcellar_EnEV2009_SML_upHalf() else if TIR == 2 then AixLib.DataBase.Walls.EnEV2002.Floor.FLcellar_EnEV2002_SML_upHalf() else if TIR == 3 then AixLib.DataBase.Walls.WSchV1995.Floor.FLcellar_WSchV1995_SML_upHalf() else AixLib.DataBase.Walls.WSchV1984.Floor.FLcellar_WSchV1984_SML_upHalf() else if TIR == 1 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_SM_upHalf() else AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_L_upHalf() else if TIR == 2 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.EnEV2002.Floor.FLpartition_EnEV2002_SM_upHalf() else AixLib.DataBase.Walls.EnEV2002.Floor.FLpartition_EnEV2002_L_upHalf() else if TIR == 3 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.WSchV1995.Floor.FLpartition_WSchV1995_SM_upHalf() else AixLib.DataBase.Walls.WSchV1995.Floor.FLpartition_WSchV1995_L_upHalf() else if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.WSchV1984.Floor.FLpartition_WSchV1984_SM_upHalf() else AixLib.DataBase.Walls.WSchV1984.Floor.FLpartition_WSchV1984_L_upHalf() annotation(Dialog(tab = "Types"));
      // Ceiling  type
      parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_CE = if Floor == 1 or Floor == 2 then if TIR == 1 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_SM_loHalf() else AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_L_loHalf() else if TIR == 2 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.EnEV2002.Ceiling.CEpartition_EnEV2002_SM_loHalf() else AixLib.DataBase.Walls.EnEV2002.Ceiling.CEpartition_EnEV2002_L_loHalf() else if TIR == 3 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.WSchV1995.Ceiling.CEpartition_WSchV1995_SM_loHalf() else AixLib.DataBase.Walls.WSchV1995.Ceiling.CEpartition_WSchV1995_L_loHalf() else if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.WSchV1984.Ceiling.CEpartition_WSchV1984_SM_loHalf() else AixLib.DataBase.Walls.WSchV1984.Ceiling.CEpartition_WSchV1984_L_loHalf() else if TIR == 1 then AixLib.DataBase.Walls.EnEV2009.Ceiling.CEattic_EnEV2009_SML_loHalf() else if TIR == 2 then AixLib.DataBase.Walls.EnEV2002.Ceiling.CEattic_EnEV2002_SML_loHalf() else if TIR == 3 then AixLib.DataBase.Walls.WSchV1995.Ceiling.CEattic_WSchV1995_SML_loHalf() else AixLib.DataBase.Walls.WSchV1984.Ceiling.CEattic_WSchV1984_SML_loHalf() annotation(Dialog(tab = "Types"));
      //Window type
      parameter AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple Type_Win = if TIR == 1 then AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009() else if TIR == 2 then AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2002() else if TIR == 3 then AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1995() else AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1984() annotation(Dialog(tab = "Types"));
      parameter Modelica.Units.SI.Volume room_V=3.105*5.30*2.46;
    equation
      connect(outsideWall.SolarRadiationPort, SolarRadiation_NW) annotation(Line(points = {{-59, -105}, {-59, -118.691}, {-60, -118.691}, {-60, -150}}, color = {255, 128, 0}));
      connect(outsideWall.WindSpeedPort, WindSpeedPort) annotation(Line(points = {{-48, -102.5}, {-48, -130}, {-80, -130}, {-80, -4}, {-108, -4}}, color = {0, 0, 127}));
      connect(infiltrationRate.port_a, thermOutside) annotation(Line(points = {{-44, 93}, {-61.35, 93}, {-61.35, 90}, {-100, 90}}, color = {191, 0, 0}));
      connect(infiltrationRate.port_b, airload.port) annotation(Line(points={{-18,93},{-18,92},{44,92},{44,-2},{20,-2}},          color = {191, 0, 0}));
      connect(Wall_Livingroom.port_outside, thermLivingroom) annotation(Line(points={{-10,50.4},{-10,50.4},{-10,66},{-80,66},{-80,0},{-100,0}},              color = {191, 0, 0}));
      connect(Wall_Corridor.port_outside, thermCorridor) annotation(Line(points={{62.15,16},{84,16},{84,66},{-80,66},{-80,-30},{-100,-30}},              color = {191, 0, 0}));
      connect(Wall_Bath.port_outside, thermBath) annotation(Line(points={{66.25,-40},{80,-40},{80,-130},{-80,-130},{-80,-60},{-100,-60}},              color = {191, 0, 0}));
      connect(Wall_Ceiling.port_outside, thermCeiling) annotation(Line(points = {{96, -59.9}, {96, -48}, {130, -48}, {130, -130}, {-80, -130}, {-80, -120}, {-100, -120}}, color = {191, 0, 0}));
      connect(Wall_Neighbour.port_outside, thermNeigbour) annotation(Line(points = {{-74.35, -19}, {-80, -19}, {-80, -90}, {-100, -90}}, color = {191, 0, 0}));
      connect(thermFloor, Wall_Floor.port_outside) annotation(Line(points={{-100,-150},{-90,-150},{-90,-142},{-80,-142},{-80,-130},{96,-130},{96,-102.1}},
                                                                                                                           color = {191, 0, 0}));
      connect(outsideWall.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-4,-82},{-4,-74},{14,-74},{14,-70}},       color={191,0,0}));
      connect(thermStar_Demux.portConvRadComb, Wall_Ceiling.thermStarComb_inside) annotation (Line(points={{14,-70},{14,-74},{96,-74},{96,-64}},       color={191,0,0}));
      connect(Wall_Floor.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{96,-98.0002},{96,-74},{14,-74},{14,-70}},       color={191,0,0}));
      connect(thermStar_Demux.portRad, StarRoom) annotation (Line(
          points={{19,-50},{19,-43.8},{28,-43.8},{28,-34}},
          color={95,95,95},
          pattern=LinePattern.Solid));
      connect(thermStar_Demux.portConv, airload.port) annotation (Line(points={{8.9,-49.9},{8.9,-16},{44,-16},{44,6},{29,6}}, color={191,0,0}));
      connect(thermStar_Demux.portConv, ThermRoom) annotation (Line(points={{8.9,-49.9},{8.9,-36},{-10,-36}}, color={191,0,0}));
      connect(Wall_Neighbour.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-60,-19},{-48,-19},{-48,-74},{15.3,-74},{15.3,-69.8}}, color={191,0,0}));
      connect(Wall_Livingroom.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-10,34},{-10,24},{-48,24},{-48,
              -74},{15.3,-74},{15.3,-69.8}},                                                                                                                                 color={191,0,0}));
      connect(Wall_Corridor.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{56,16},{44,16},{44,-74},{15.3,-74},
              {15.3,-69.8}},                                                                                                                                   color={191,0,0}));
      connect(Wall_Bath.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{56,-40},{44,-40},{44,-74},{15.3,-74},{
              15.3,-69.8}},                                                                                                                                  color={191,0,0}));
      connect(AirExchangePort, NaturalVentilation.ventRate) annotation (Line(points=
             {{-110,50},{-80,50},{-80,66},{44,66},{44,76.68},{67.4,76.68}}, color={
              0,0,127}));
      connect(NaturalVentilation.port_a, thermOutside) annotation(Line(points = {{66, 85}, {44, 85}, {44, 90}, {-100, 90}}, color = {191, 0, 0}));
      connect(airload.port, NaturalVentilation.port_b) annotation(Line(points={{20,-2},{44,-2},{44,66},{100,66},{100,85},{94,85}},            color = {191, 0, 0}));
      connect(outsideWall.port_outside, thermOutside) annotation(Line(points = {{-4, -102.5}, {-4, -130}, {-80, -130}, {-80, 90}, {-100, 90}}, color = {191, 0, 0}));
      annotation(Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -150}, {150, 100}})),           Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -150}, {150, 100}}), graphics={  Rectangle(extent = {{-54, 68}, {98, -112}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
                fillPattern =                                                                                                   FillPattern.Forward), Text(extent = {{-40, 2}, {84, -26}}, lineColor = {0, 0, 0}, fillColor = {255, 0, 0},
                fillPattern =                                                                                                   FillPattern.Forward, textString = "Bedroom"), Rectangle(extent = {{-42, -104}, {-20, -124}}, lineColor = {0, 0, 0}, fillColor = {85, 255, 255},
                fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-40, -106}, {-22, -122}}, lineColor = {0, 0, 0}, fillColor = {170, 213, 255},
                fillPattern =                                                                                                   FillPattern.Solid), Line(points = {{-36, -118}, {-26, -108}}, color = {255, 255, 255}, thickness = 1), Line(points = {{-32, -118}, {-26, -112}}, color = {255, 255, 255}, thickness = 1), Line(points = {{-36, -114}, {-30, -108}}, color = {255, 255, 255}, thickness = 1), Text(extent = {{-32, -112}, {18, -128}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   1, fillColor = {255, 255, 255},
                fillPattern =                                                                                                   FillPattern.Solid, textString = "OW"), Text(extent = {{26, 92}, {76, 76}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   1, fillColor = {255, 255, 255},
                fillPattern =                                                                                                   FillPattern.Solid, textString = "Corridor"), Rectangle(extent = {{-54, 94}, {-34, 64}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   1, fillColor = {127, 0, 0},
                fillPattern =                                                                                                   FillPattern.Forward), Ellipse(extent = {{-52, 82}, {-50, 80}}, lineColor = {0, 0, 0}, pattern=LinePattern.None,
                lineThickness =                                                                                                   1,
                fillPattern =                                                                                                   FillPattern.Sphere, fillColor = {255, 255, 0}), Text(extent = {{-72, -16}, {-76, -18}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5, textString = "Edit Here"), Rectangle(extent = {{-110, -110}, {-90, -130}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, -80}, {-90, -100}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, -20}, {-90, -40}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, 10}, {-90, -10}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, 72}, {-90, 18}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, 100}, {-90, 80}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, -50}, {-90, -70}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, -140}, {-90, -160}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5)}), Documentation(revisions = "<html><ul>
  <li>
    <i>April 18, 2014</i> by Ana Constantin:<br/>
    Added documentation
  </li>
  <li>
    <i>August 16, 2011</i> by Ana Constantin:<br/>
    Implemented
  </li>
</ul>
</html>",     info = "<html>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Model for the bedroom.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The following figure presents the room's layout:
</p>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/Building/HighOrder/VoWo_Bedroom.png\"
  alt=\"Room layout\">
</p>
</html>"));
    end Bedroom_VoWo;

    model Children_VoWo "Children room from the VoWo appartment"
      ///////// construction parameters
      parameter Integer TMC = 1 "Thermal Mass Class" annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice = 1 "Heavy", choice = 2 "Medium", choice = 3 "Light", radioButtons = true));
      parameter Integer TIR = 4 "Thermal Insulation Regulation" annotation(Dialog(groupImage = "modelica://AixLib/Resources/Images/Building/HighOrder/VoWo_Children.png", group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice = 1
            "EnEV_2009",                                                                                                    choice = 2
            "EnEV_2002",                                                                                                    choice = 3
            "WSchV_1995",                                                                                                    choice = 4
            "WSchV_1984",                                                                                                    radioButtons = true));
      parameter Integer Floor = 1 "Floor" annotation(Dialog(group = "Floor", compact = true, descriptionLabel = true), choices(choice = 1 "GF", choice = 2 "1F", choice = 3 "2F", radioButtons = true));
      // Outer walls properties
      parameter Real solar_absorptance_OW = 0.7 "Solar absoptance outer walls " annotation(Dialog(group = "Outer wall properties", descriptionLabel = true));
      parameter Integer calcMethod=1 "Calculation method for convective heat transfer coefficient" annotation (Dialog(
          group="Outer wall properties",
          compact=true,
          descriptionLabel=true), choices(
          choice=1 "DIN 6946",
          choice=2 "ASHRAE Fundamentals",
          choice=3 "Custom hCon (constant)",
          radioButtons=true));
      //Initial temperatures
      parameter Modelica.Units.SI.Temperature T0_air=295.15 "Air"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      parameter Modelica.Units.SI.Temperature T0_OW=295.15 "OW"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      parameter Modelica.Units.SI.Temperature T0_IWLivingroom=294.15 "IWLivingroom"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      parameter Modelica.Units.SI.Temperature T0_IWNeighbour=294.15 "IWNeighbour"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      parameter Modelica.Units.SI.Temperature T0_IWCorridor=290.15 "IWCorridor"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      parameter Modelica.Units.SI.Temperature T0_IWStraicase=288.15 "IWStaircase"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      parameter Modelica.Units.SI.Temperature T0_CE=295.35 "Ceiling"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      parameter Modelica.Units.SI.Temperature T0_FL=294.95 "Floor"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      // Sunblind
      parameter Boolean use_sunblind = false
        "Will sunblind become active automatically?"
        annotation(Dialog(group = "Sunblind"));
      parameter Real ratioSunblind(min=0.0, max=1.0)= 0.8
        "Sunblind factor. 1 means total blocking of irradiation, 0 no sunblind"
        annotation(Dialog(group = "Sunblind", enable=use_sunblind));
      parameter Modelica.Units.SI.Irradiance solIrrThreshold(min=0.0) = 350
        "Threshold for global solar irradiation on this surface to enable sunblinding (see also TOutAirLimit)"
        annotation (Dialog(group="Sunblind", enable=use_sunblind));
      parameter Modelica.Units.SI.Temperature TOutAirLimit
        "Temperature at which sunblind closes (see also solIrrThreshold)"
        annotation (Dialog(group="Sunblind", enable=use_sunblind));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Livingroom(
        redeclare final model WindowModel=WindowModel,
        redeclare final model CorrSolarGainWin=CorrSolarGainWin,
        T0=T0_IWLivingroom,
        outside=false,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        wallPar=Type_IWload,
        wall_length=4.2,
        wall_height=2.46,
        withWindow=false,
        withDoor=false) annotation (Placement(transformation(extent={{-76,-40},{-66,20}})));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Corridor(
        redeclare final model WindowModel=WindowModel,
        redeclare final model CorrSolarGainWin=CorrSolarGainWin,
        T0=T0_IWCorridor,
        outside=false,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        wallPar=Type_IWload,
        wall_length=2.13,
        wall_height=2.46,
        withWindow=false,
        withDoor=false) annotation (Placement(transformation(
            origin={-25.6,-49},
            extent={{-3,-21.6},{5,26.4}},
            rotation=90)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Neighbour(
        redeclare final model WindowModel=WindowModel,
        redeclare final model CorrSolarGainWin=CorrSolarGainWin,
        T0=T0_IWNeighbour,
        outside=false,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        wallPar=Type_IWload,
        wall_length=4.2,
        wall_height=2.46,
        withWindow=false,
        withDoor=false) annotation (Placement(transformation(
            origin={60,4.92309},
            extent={{-2,-35.0769},{10,36.9231}},
            rotation=180)));
      AixLib.ThermalZones.HighOrder.Components.DryAir.Airload airload(
        final T0=T0_air,
        final V=room_V)
        annotation (Placement(transformation(extent={{-38,16},{-58,36}})));
      AixLib.Utilities.Interfaces.SolarRad_in Strahlung_SE annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-82,110}), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-30,110})));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall outsideWall(
        redeclare final model WindowModel=WindowModel,
        redeclare final model CorrSolarGainWin=CorrSolarGainWin,
        wall_length=3.38,
        wall_height=2.46,
        windowarea=1.84,
        withWindow=true,
        T0=T0_OW,
        solar_absorptance=solar_absorptance_OW,
        wallPar=Type_OW,
        WindowType=Type_Win,
        outside=true,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        withDoor=false) annotation (Placement(transformation(
            origin={-12,51},
            extent={{-9,-54},{9,54}},
            rotation=270)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Staircase(
        redeclare final model WindowModel=WindowModel,
        redeclare final model CorrSolarGainWin=CorrSolarGainWin,
        T0=T0_IWStraicase,
        outside=false,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        wallPar=Type_IWload,
        wall_length=0.86,
        wall_height=2.46,
        withWindow=false,
        withDoor=false) annotation (Placement(transformation(
            origin={36.9565,-47},
            extent={{-3,-21.0435},{5,22.9565}},
            rotation=90)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Ceiling(
        redeclare final model WindowModel=WindowModel,
        redeclare final model CorrSolarGainWin=CorrSolarGainWin,
        T0=T0_CE,
        outside=false,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        wallPar=Type_CE,
        wall_length=4.20,
        wall_height=3.38,
        ISOrientation=3,
        withWindow=false,
        withDoor=false) "Decke" annotation (Placement(transformation(
            origin={112,76},
            extent={{-1.99998,-10},{1.99998,10}},
            rotation=270)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Floor(
        redeclare final model WindowModel=WindowModel,
        redeclare final model CorrSolarGainWin=CorrSolarGainWin,
        T0=T0_FL,
        outside=false,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        wallPar=Type_FL,
        wall_length=4.20,
        wall_height=3.38,
        ISOrientation=2,
        withWindow=false,
        withDoor=false) annotation (Placement(transformation(
            origin={112,42},
            extent={{-1.99998,-10},{1.99998,10}},
            rotation=90)));
      AixLib.ThermalZones.HighOrder.Components.DryAir.InfiltrationRate_DIN12831
        infiltrationRate(
        room_V=room_V,
        n50=n50,
        e=e,
        eps=eps)
        annotation (Placement(transformation(extent={{-44,-120},{-18,-94}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermOutside annotation(Placement(transformation(extent = {{-70, 88}, {-50, 108}}), iconTransformation(extent = {{-70, 88}, {-50, 108}})));
      Modelica.Blocks.Interfaces.RealInput WindSpeedPort annotation(Placement(transformation(extent = {{-124, -8}, {-84, 32}}), iconTransformation(extent = {{-110, 30}, {-90, 50}})));
      Modelica.Blocks.Interfaces.RealInput AirExchangePort annotation(Placement(transformation(extent = {{-124, 20}, {-84, 60}}), iconTransformation(extent = {{-110, 60}, {-90, 80}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermNeighbour annotation(Placement(transformation(extent = {{-110, 0}, {-90, 20}}), iconTransformation(extent = {{-110, 0}, {-90, 20}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermStaircase annotation(Placement(transformation(extent = {{-110, -30}, {-90, -10}}), iconTransformation(extent = {{-110, -30}, {-90, -10}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCorridor annotation(Placement(transformation(extent = {{-110, -60}, {-90, -40}}), iconTransformation(extent = {{-110, -60}, {-90, -40}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermLivingroom annotation(Placement(transformation(extent = {{-108, -130}, {-88, -110}}), iconTransformation(extent = {{-110, -90}, {-90, -70}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling annotation(Placement(transformation(extent = {{-110, -120}, {-90, -100}}), iconTransformation(extent = {{-110, -120}, {-90, -100}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor annotation(Placement(transformation(extent = {{-110, -152}, {-90, -132}}), iconTransformation(extent = {{-110, -152}, {-90, -132}})));
      AixLib.Utilities.Interfaces.RadPort StarRoom annotation (Placement(
            transformation(extent={{6,-6},{26,14}}), iconTransformation(extent=
                {{6,-6},{26,14}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermRoom annotation(Placement(transformation(extent = {{-26, -4}, {-6, 16}}), iconTransformation(extent = {{-26, -4}, {-6, 16}})));
      AixLib.Utilities.Interfaces.Adaptors.ConvRadToCombPort thermStar_Demux annotation (Placement(transformation(
            extent={{-10,8},{10,-8}},
            rotation=90,
            origin={0,-22})));
      AixLib.ThermalZones.HighOrder.Components.DryAir.VarAirExchange
        NaturalVentilation(V=room_V)
        annotation (Placement(transformation(extent={{-44,-94},{-16,-68}})));

      replaceable model WindowModel =
          AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.PartialWindow
        constrainedby
        AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.PartialWindow
                                                                                                      annotation (Dialog(tab="Outer walls", group="Windows"), choicesAllMatching = true);

      replaceable model CorrSolarGainWin =
          AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.CorrectionSolarGain.PartialCorG
        constrainedby
        AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.CorrectionSolarGain.PartialCorG
                                                                                                                        "Correction model for solar irradiance as transmitted radiation" annotation (choicesAllMatching=true, Dialog(tab="Outer walls", group="Windows", enable = withWindow and outside));

    protected
      parameter Real n50(unit = "h-1") = if TIR == 1 or TIR == 2 then 3 else if TIR == 3 then 4 else 6
        "Air exchange rate at 50 Pa pressure difference"                                                                                                annotation(Dialog(tab = "Infiltration"));
      parameter Real e = 0.03 "Coefficient of windshield" annotation(Dialog(tab = "Infiltration"));
      parameter Real eps = 1.0 "Coefficient of height" annotation(Dialog(tab = "Infiltration"));
      // Outer wall type
      parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_OW = if TIR == 1 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_M() else AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_L() else if TIR == 2 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_S() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_M() else AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_L() else if TIR == 3 then if TMC == 1 then AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_S() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_M() else AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_L() else if TMC == 1 then AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_S() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_M() else AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_L() annotation(Dialog(tab = "Types"));
      //Inner wall Types
      parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_IWload = if TIR == 1 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_M_half() else AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_L_half() else if TIR == 2 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_S_half() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_M_half() else AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_L_half() else if TIR == 3 then if TMC == 1 then AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_S_half() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_M_half() else AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_L_half() else if TMC == 1 then AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_S_half() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_M_half() else AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_L_half() annotation(Dialog(tab = "Types"));
      // Floor type
      parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_FL = if Floor == 1 then if TIR == 1 then AixLib.DataBase.Walls.EnEV2009.Floor.FLcellar_EnEV2009_SML_upHalf() else if TIR == 2 then AixLib.DataBase.Walls.EnEV2002.Floor.FLcellar_EnEV2002_SML_upHalf() else if TIR == 3 then AixLib.DataBase.Walls.WSchV1995.Floor.FLcellar_WSchV1995_SML_upHalf() else AixLib.DataBase.Walls.WSchV1984.Floor.FLcellar_WSchV1984_SML_upHalf() else if TIR == 1 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_SM_upHalf() else AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_L_upHalf() else if TIR == 2 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.EnEV2002.Floor.FLpartition_EnEV2002_SM_upHalf() else AixLib.DataBase.Walls.EnEV2002.Floor.FLpartition_EnEV2002_L_upHalf() else if TIR == 3 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.WSchV1995.Floor.FLpartition_WSchV1995_SM_upHalf() else AixLib.DataBase.Walls.WSchV1995.Floor.FLpartition_WSchV1995_L_upHalf() else if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.WSchV1984.Floor.FLpartition_WSchV1984_SM_upHalf() else AixLib.DataBase.Walls.WSchV1984.Floor.FLpartition_WSchV1984_L_upHalf() annotation(Dialog(tab = "Types"));
      // Ceiling  type
      parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_CE = if Floor == 1 or Floor == 2 then if TIR == 1 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_SM_loHalf() else AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_L_loHalf() else if TIR == 2 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.EnEV2002.Ceiling.CEpartition_EnEV2002_SM_loHalf() else AixLib.DataBase.Walls.EnEV2002.Ceiling.CEpartition_EnEV2002_L_loHalf() else if TIR == 3 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.WSchV1995.Ceiling.CEpartition_WSchV1995_SM_loHalf() else AixLib.DataBase.Walls.WSchV1995.Ceiling.CEpartition_WSchV1995_L_loHalf() else if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.WSchV1984.Ceiling.CEpartition_WSchV1984_SM_loHalf() else AixLib.DataBase.Walls.WSchV1984.Ceiling.CEpartition_WSchV1984_L_loHalf() else if TIR == 1 then AixLib.DataBase.Walls.EnEV2009.Ceiling.CEattic_EnEV2009_SML_loHalf() else if TIR == 2 then AixLib.DataBase.Walls.EnEV2002.Ceiling.CEattic_EnEV2002_SML_loHalf() else if TIR == 3 then AixLib.DataBase.Walls.WSchV1995.Ceiling.CEattic_WSchV1995_SML_loHalf() else AixLib.DataBase.Walls.WSchV1984.Ceiling.CEattic_WSchV1984_SML_loHalf() annotation(Dialog(tab = "Types"));
      //Window type
      parameter AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple Type_Win = if TIR == 1 then AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009() else if TIR == 2 then AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2002() else if TIR == 3 then AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1995() else AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1984() annotation(Dialog(tab = "Types"));
      parameter Modelica.Units.SI.Volume room_V=3.38*4.20*2.46;
    equation
      connect(Strahlung_SE, outsideWall.SolarRadiationPort) annotation(Line(points = {{-82, 110}, {-82, 78}, {58, 78}, {58, 62.7}, {37.5, 62.7}}, color = {255, 128, 0}));
      connect(infiltrationRate.port_b, airload.port) annotation(Line(points={{-18,-107},{0,-107},{0,-36},{-32,-36},{-32,16},{-48,16}},              color = {191, 0, 0}));
      connect(infiltrationRate.port_a, thermOutside) annotation(Line(points = {{-44, -107}, {-80, -107}, {-80, 98}, {-60, 98}}, color = {191, 0, 0}));
      connect(outsideWall.WindSpeedPort, WindSpeedPort) annotation(Line(points = {{27.6, 60.45}, {27.6, 78}, {-80, 78}, {-80, 12}, {-104, 12}}, color = {0, 0, 127}));
      connect(Wall_Neighbour.port_outside, thermNeighbour) annotation(Line(points = {{62.3, 3.99999}, {100, 3.99999}, {100, -68}, {-80, -68}, {-80, 10}, {-100, 10}}, color = {191, 0, 0}));
      connect(Wall_Staircase.port_outside, thermStaircase) annotation(Line(points = {{36, -50.2}, {36, -68}, {-80, -68}, {-80, -20}, {-100, -20}}, color = {191, 0, 0}));
      connect(Wall_Corridor.port_outside, thermCorridor) annotation(Line(points = {{-28, -52.2}, {-28, -68}, {-80, -68}, {-80, -50}, {-100, -50}}, color = {191, 0, 0}));
      connect(Wall_Livingroom.port_outside, thermLivingroom) annotation(Line(points = {{-76.25, -10}, {-80, -10}, {-80, -120}, {-98, -120}}, color = {191, 0, 0}));
      connect(Wall_Ceiling.port_outside, thermCeiling) annotation(Line(points={{112,78.1},{112,88},{100,88},{100,-68},{-80,-68},{-80,-110},{-100,-110}},                color = {191, 0, 0}));
      connect(Wall_Floor.port_outside, thermFloor) annotation(Line(points={{112,39.9},{112,8},{100,8},{100,-68},{-100,-68},{-100,-142}},              color = {191, 0, 0}));
      connect(thermStar_Demux.portRad, StarRoom) annotation (Line(
          points={{5,-12},{5,-10},{5,-8},{16,-8},{16,4}},
          color={95,95,95},
          pattern=LinePattern.Solid));
      connect(thermStar_Demux.portConv, ThermRoom) annotation (Line(points={{-5,-12},{-5,-3.95},{-16,-3.95},{-16,6}},       color={191,0,0}));
      connect(thermStar_Demux.portConv, airload.port) annotation (Line(points={{-5,-12},{-32,-12},{-32,16},{-48,16}},       color={191,0,0}));
      connect(Wall_Corridor.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-28,-44},{-28,-36},{-6.66134e-16,-36},{-6.66134e-16,-32}},
                                                                                                                                                          color={191,0,0}));
      connect(Wall_Staircase.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{36,-42},{36,-36},{-6.66134e-16,-36},{-6.66134e-16,-32}},
                                                                                                                                                         color={191,0,0}));
      connect(Wall_Neighbour.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{50,3.99999},{40,3.99999},{40,-36},{-6.66134e-16,-36},{-6.66134e-16,-32}},
                                                                                                                                                                          color={191,0,0}));
      connect(outsideWall.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-12,42},{-12,30},{40,30},{40,-36},{-6.66134e-16,-36},{-6.66134e-16,-32}},
                                                                                                                                                                       color={191,0,0}));
      connect(Wall_Floor.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{112,44},{112,52},{40,52},{40,-36},{-6.66134e-16,-36},{-6.66134e-16,-32}},
                                                                                                                                                                      color={191,0,0}));
      connect(Wall_Ceiling.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{112,74},{112,52},{40,52},{40,-36},{-6.66134e-16,-36},{-6.66134e-16,-32}},
                                                                                                                                                                        color={191,0,0}));
      connect(Wall_Livingroom.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-66,-10},{-50,-10},{-50,-36},{-6.66134e-16,-36},{-6.66134e-16,-32}},
                                                                                                                                                                      color={191,0,0}));
      connect(thermOutside, NaturalVentilation.port_a) annotation(Line(points = {{-60, 98}, {-80, 98}, {-80, -68}, {-50, -68}, {-50, -81}, {-44, -81}}, color = {191, 0, 0}));
      connect(AirExchangePort, NaturalVentilation.ventRate) annotation (Line(points=
             {{-104,40},{-80,40},{-80,-68},{-50,-68},{-50,-89.32},{-42.6,-89.32}},
            color={0,0,127}));
      connect(NaturalVentilation.port_b, airload.port) annotation(Line(points = {{-16, -81}, {0, -81}, {0, -36}, {-32, -36}, {-32, 24}, {-39, 24}}, color = {191, 0, 0}));
      connect(outsideWall.port_outside, thermOutside) annotation(Line(points = {{-12, 60.45}, {-12, 98}, {-60, 98}}, color = {191, 0, 0}));
      connect(thermOutside, thermOutside) annotation(Line(points = {{-60, 98}, {-86, 98}, {-86, 98}, {-60, 98}}, color = {191, 0, 0}));
      annotation(DDiagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -150}, {150, 100}}), graphics), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -150}, {150, 100}}), graphics={  Rectangle(extent = {{-54, 68}, {116, -108}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
                fillPattern =                                                                                                   FillPattern.Forward), Text(extent = {{-36, -20}, {98, -54}}, lineColor = {0, 0, 0}, fillColor = {255, 0, 0},
                fillPattern =                                                                                                   FillPattern.Forward, textString = "Children"), Rectangle(extent = {{-10, 80}, {12, 60}}, lineColor = {0, 0, 0}, fillColor = {85, 255, 255},
                fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-8, 78}, {10, 62}}, lineColor = {0, 0, 0}, fillColor = {170, 213, 255},
                fillPattern =                                                                                                   FillPattern.Solid), Line(points = {{-4, 66}, {6, 76}}, color = {255, 255, 255}, thickness = 1), Line(points = {{0, 66}, {6, 72}}, color = {255, 255, 255}, thickness = 1), Line(points = {{-4, 70}, {2, 76}}, color = {255, 255, 255}, thickness = 1), Text(extent = {{2, 82}, {52, 66}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   1, fillColor = {255, 255, 255},
                fillPattern =                                                                                                   FillPattern.Solid, textString = "OW"), Text(extent = {{6, -110}, {56, -126}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   1, fillColor = {255, 255, 255},
                fillPattern =                                                                                                   FillPattern.Solid, textString = "Corridor"), Rectangle(extent = {{90, -96}, {110, -126}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   1, fillColor = {127, 0, 0},
                fillPattern =                                                                                                   FillPattern.Forward), Ellipse(extent = {{92, -108}, {94, -110}}, lineColor = {0, 0, 0}, pattern=LinePattern.None,
                lineThickness =                                                                                                   1,
                fillPattern =                                                                                                   FillPattern.Sphere, fillColor = {255, 255, 0}), Rectangle(extent = {{-110, -100}, {-90, -120}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, -70}, {-90, -90}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, -40}, {-90, -60}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, 20}, {-90, 0}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5), Rectangle(extent = {{-70, 88}, {-50, 88}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, -10}, {-90, -30}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, 82}, {-90, 28}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, -132}, {-90, -152}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5)}), Documentation(revisions = "<html><ul>
  <li>
    <i>April 18, 2014</i> by Ana Constantin:<br/>
    Added documentation
  </li>
  <li>
    <i>August 16, 2011</i> by Ana Constantin:<br/>
    Implemented
  </li>
</ul>
</html>",     info = "<html>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Model for a second bedroom: the childrens' room.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The following figure presents the room's layout:
</p>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/Building/HighOrder/VoWo_Children.png\"
  alt=\"Room layout\">
</p>
</html>"));
    end Children_VoWo;

    model Corridor_VoWo "Corridor from the VoWo appartment"
      ///////// construction parameters
      parameter Integer TMC = 1 "Thermal Mass Class" annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice = 1 "Heavy", choice = 2 "Medium", choice = 3 "Light", radioButtons = true));
      parameter Integer TIR = 4 "Thermal Insulation Regulation" annotation(Dialog(groupImage = "modelica://AixLib/Resources/Images/Building/HighOrder/VoWo_Corridor.png", group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice = 1
            "EnEV_2009",                                                                                                    choice = 2
            "EnEV_2002",                                                                                                    choice = 3
            "WSchV_1995",                                                                                                    choice = 4
            "WSchV_1984",                                                                                                    radioButtons = true));
      parameter Integer Floor = 1 "Floor" annotation(Dialog(group = "Floor", compact = true, descriptionLabel = true), choices(choice = 1 "GF", choice = 2 "1F", choice = 3 "2F", radioButtons = true));
      // Outer walls properties
      parameter Real solar_absorptance_OW = 0.7 "Solar absoptance outer walls " annotation(Dialog(group = "Outer wall properties", descriptionLabel = true));
      parameter Integer calcMethod=1 "Calculation method for convective heat transfer coefficient" annotation (Dialog(
          group="Outer wall properties",
          compact=true,
          descriptionLabel=true), choices(
          choice=1 "DIN 6946",
          choice=2 "ASHRAE Fundamentals",
          choice=3 "Custom hCon (constant)",
          radioButtons=true));
      //Initial temperatures
      parameter Modelica.Units.SI.Temperature T0_air=290.15 "Air"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      parameter Modelica.Units.SI.Temperature T0_Staircase=288.15 "IWStaircase"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      parameter Modelica.Units.SI.Temperature T0_IWKitchen=295.15 "IWKitchen"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      parameter Modelica.Units.SI.Temperature T0_IWBath=297.15 "IWBath"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      parameter Modelica.Units.SI.Temperature T0_IWBedroom=295.15 "IWBedroom"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      parameter Modelica.Units.SI.Temperature T0_IWLivingroom=295.15 "IWLivingroom"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      parameter Modelica.Units.SI.Temperature T0_IWChild=295.15 "IWChild"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      parameter Modelica.Units.SI.Temperature T0_CE=295.35 "Ceiling"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      parameter Modelica.Units.SI.Temperature T0_FL=294.95 "Floor"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      // Sunblind
      parameter Boolean use_sunblind = false
        "Will sunblind become active automatically?"
        annotation(Dialog(group = "Sunblind"));
      parameter Real ratioSunblind(min=0.0, max=1.0)= 0.8
        "Sunblind factor. 1 means total blocking of irradiation, 0 no sunblind"
        annotation(Dialog(group = "Sunblind", enable=use_sunblind));
      parameter Modelica.Units.SI.Irradiance solIrrThreshold(min=0.0) = 350
        "Threshold for global solar irradiation on this surface to enable sunblinding (see also TOutAirLimit)"
        annotation (Dialog(group="Sunblind", enable=use_sunblind));
      parameter Modelica.Units.SI.Temperature TOutAirLimit
        "Temperature at which sunblind closes (see also solIrrThreshold)"
        annotation (Dialog(group="Sunblind", enable=use_sunblind));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Children(
        redeclare final model WindowModel=WindowModel,
        redeclare final model CorrSolarGainWin=CorrSolarGainWin,
        T0=T0_IWChild,
        outside=false,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        wallPar=Type_IWload,
        wall_length=2.13,
        wall_height=2.46,
        withWindow=false,
        withDoor=false) annotation (Placement(transformation(
            origin={46,24},
            extent={{-3.99999,-24},{3.99999,24}},
            rotation=270)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Kitchen2(
        redeclare final model WindowModel=WindowModel,
        redeclare final model CorrSolarGainWin=CorrSolarGainWin,
        T0=T0_IWKitchen,
        outside=false,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        wallPar=Type_IWsimple,
        wall_length=2.2,
        wall_height=2.46,
        withWindow=false,
        withDoor=false) annotation (Placement(transformation(
            origin={52,-63},
            extent={{-5.00001,-30},{5.00001,30}},
            rotation=90)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Bath(
        redeclare final model WindowModel=WindowModel,
        redeclare final model CorrSolarGainWin=CorrSolarGainWin,
        T0=T0_IWBath,
        outside=false,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        wallPar=Type_IWsimple,
        wall_length=1.31,
        wall_height=2.46,
        withWindow=false,
        withDoor=false) annotation (Placement(transformation(
            origin={-20,-99},
            extent={{-3.00001,-18},{3.00001,18}},
            rotation=90)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Kitchen1(
        redeclare final model WindowModel=WindowModel,
        redeclare final model CorrSolarGainWin=CorrSolarGainWin,
        T0=T0_IWKitchen,
        outside=false,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        wallPar=Type_IWsimple,
        wall_length=0.6,
        wall_height=2.46,
        withWindow=false,
        withDoor=false) annotation (Placement(transformation(
            origin={-2,-74},
            extent={{-2,-12},{2,12}},
            rotation=180)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Bedroom(
        redeclare final model WindowModel=WindowModel,
        redeclare final model CorrSolarGainWin=CorrSolarGainWin,
        T0=T0_IWBedroom,
        outside=false,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        wallPar=Type_IWload,
        wall_length=1.96,
        wall_height=2.46,
        withWindow=false,
        withDoor=false) annotation (Placement(transformation(extent={{-66,-70},{-54,2}})));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Staircase(
        redeclare final model WindowModel=WindowModel,
        redeclare final model CorrSolarGainWin=CorrSolarGainWin,
        T0=T0_Staircase,
        outside=false,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        wallPar=Type_IWload,
        wall_length=1.34,
        wall_height=2.46,
        withWindow=false,
        withDoor=true,
        U_door=30/31,
        eps_door=0.95,
        door_height=2) annotation (Placement(transformation(
            origin={109,-32},
            extent={{-3.00013,-22},{5.0002,22}},
            rotation=180)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Livingroom(
        redeclare final model WindowModel=WindowModel,
        redeclare final model CorrSolarGainWin=CorrSolarGainWin,
        T0=T0_IWLivingroom,
        outside=false,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        wallPar=Type_IWload,
        wall_length=1.25,
        wall_height=2.46,
        withWindow=false,
        withDoor=false) annotation (Placement(transformation(
            origin={-28,24},
            extent={{-3.99999,-24},{3.99999,24}},
            rotation=270)));
      AixLib.ThermalZones.HighOrder.Components.DryAir.Airload airload(
        final T0=T0_air,
        final V=room_V)
        annotation (Placement(transformation(extent={{-12,-12},{-32,8}})));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Ceiling(
        redeclare final model WindowModel=WindowModel,
        redeclare final model CorrSolarGainWin=CorrSolarGainWin,
        T0=T0_CE,
        outside=false,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        wallPar=Type_CE,
        wall_length=sqrt(5.73),
        wall_height=sqrt(5.73),
        ISOrientation=3,
        withWindow=false,
        withDoor=false) annotation (Placement(transformation(
            origin={117,80},
            extent={{-2,-15},{2,15}},
            rotation=270)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Floor(
        redeclare final model WindowModel=WindowModel,
        redeclare final model CorrSolarGainWin=CorrSolarGainWin,
        T0=T0_FL,
        outside=false,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        wallPar=Type_FL,
        wall_length=sqrt(5.73),
        wall_height=sqrt(5.73),
        ISOrientation=2,
        withWindow=false,
        withDoor=false) annotation (Placement(transformation(
            origin={118,55},
            extent={{-2.99998,-16},{2.99998,16}},
            rotation=90)));
      AixLib.ThermalZones.HighOrder.Components.DryAir.InfiltrationRate_DIN12831
        infiltrationRate(
        room_V=room_V,
        n50=n50,
        e=e,
        eps=eps) annotation (Placement(transformation(extent={{-44,60},{-18,86}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermStaircase annotation(Placement(transformation(extent = {{-112, 70}, {-92, 90}}), iconTransformation(extent = {{-112, 70}, {-92, 90}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermKitchen annotation(Placement(transformation(extent = {{-112, 40}, {-92, 60}}), iconTransformation(extent = {{-112, 40}, {-92, 60}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermBath annotation(Placement(transformation(extent = {{-110, -50}, {-90, -30}}), iconTransformation(extent = {{-110, -50}, {-90, -30}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermBedroom annotation(Placement(transformation(extent = {{-110, -80}, {-90, -60}}), iconTransformation(extent = {{-110, -80}, {-90, -60}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling annotation(Placement(transformation(extent = {{-110, -110}, {-90, -90}}), iconTransformation(extent = {{-110, -110}, {-90, -90}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor annotation(Placement(transformation(extent = {{-110, -140}, {-90, -120}}), iconTransformation(extent = {{-110, -140}, {-90, -120}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermLivingroom annotation(Placement(transformation(extent = {{-112, 10}, {-92, 30}}), iconTransformation(extent = {{-112, 10}, {-92, 30}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermChild annotation(Placement(transformation(extent = {{-112, -20}, {-92, 0}}), iconTransformation(extent = {{-112, -20}, {-92, 0}})));
      AixLib.Utilities.Interfaces.Adaptors.ConvRadToCombPort thermStar_Demux annotation (Placement(transformation(
            extent={{-10,8},{10,-8}},
            rotation=90,
            origin={46,-26})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=0)
        annotation (Placement(transformation(extent={{-74,-98},{-54,-78}})));

      replaceable model WindowModel =
          AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.PartialWindow
        constrainedby
        AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.PartialWindow
                                                                                                      annotation (Dialog(tab="Outer walls", group="Windows"), choicesAllMatching = true);

      replaceable model CorrSolarGainWin =
          AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.CorrectionSolarGain.PartialCorG
        constrainedby
        AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.CorrectionSolarGain.PartialCorG
                                                                                                                        "Correction model for solar irradiance as transmitted radiation" annotation (choicesAllMatching=true, Dialog(tab="Outer walls", group="Windows", enable = withWindow and outside));

    protected
      parameter Real n50(unit = "h-1") = if TIR == 1 or TIR == 2 then 3 else if TIR == 3 then 4 else 6
        "Air exchange rate at 50 Pa pressure difference"                                                                                                annotation(Dialog(tab = "Infiltration"));
      parameter Real e = 0.03 "Coefficient of windshield" annotation(Dialog(tab = "Infiltration"));
      parameter Real eps = 1.0 "Coefficient of height" annotation(Dialog(tab = "Infiltration"));
      // Outer wall type
      parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_OW = if TIR == 1 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_M() else AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_L() else if TIR == 2 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_S() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_M() else AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_L() else if TIR == 3 then if TMC == 1 then AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_S() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_M() else AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_L() else if TMC == 1 then AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_S() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_M() else AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_L() annotation(Dialog(tab = "Types"));
      //Inner wall Types
      parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_IWsimple = if TIR == 1 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_S_half() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_M_half() else AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_L_half() else if TIR == 2 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_S_half() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_M_half() else AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_L_half() else if TIR == 3 then if TMC == 1 then AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_S_half() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_M_half() else AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_L_half() else if TMC == 1 then AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_S_half() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_M_half() else AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_L_half() annotation(Dialog(tab = "Types"));
      parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_IWload = if TIR == 1 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_M_half() else AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_L_half() else if TIR == 2 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_S_half() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_M_half() else AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_L_half() else if TIR == 3 then if TMC == 1 then AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_S_half() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_M_half() else AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_L_half() else if TMC == 1 then AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_S_half() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_M_half() else AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_L_half() annotation(Dialog(tab = "Types"));
      // Floor type
      parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_FL = if Floor == 1 then if TIR == 1 then AixLib.DataBase.Walls.EnEV2009.Floor.FLcellar_EnEV2009_SML_upHalf() else if TIR == 2 then AixLib.DataBase.Walls.EnEV2002.Floor.FLcellar_EnEV2002_SML_upHalf() else if TIR == 3 then AixLib.DataBase.Walls.WSchV1995.Floor.FLcellar_WSchV1995_SML_upHalf() else AixLib.DataBase.Walls.WSchV1984.Floor.FLcellar_WSchV1984_SML_upHalf() else if TIR == 1 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_SM_upHalf() else AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_L_upHalf() else if TIR == 2 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.EnEV2002.Floor.FLpartition_EnEV2002_SM_upHalf() else AixLib.DataBase.Walls.EnEV2002.Floor.FLpartition_EnEV2002_L_upHalf() else if TIR == 3 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.WSchV1995.Floor.FLpartition_WSchV1995_SM_upHalf() else AixLib.DataBase.Walls.WSchV1995.Floor.FLpartition_WSchV1995_L_upHalf() else if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.WSchV1984.Floor.FLpartition_WSchV1984_SM_upHalf() else AixLib.DataBase.Walls.WSchV1984.Floor.FLpartition_WSchV1984_L_upHalf() annotation(Dialog(tab = "Types"));
      // Ceiling  type
      parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_CE = if Floor == 1 or Floor == 2 then if TIR == 1 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_SM_loHalf() else AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_L_loHalf() else if TIR == 2 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.EnEV2002.Ceiling.CEpartition_EnEV2002_SM_loHalf() else AixLib.DataBase.Walls.EnEV2002.Ceiling.CEpartition_EnEV2002_L_loHalf() else if TIR == 3 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.WSchV1995.Ceiling.CEpartition_WSchV1995_SM_loHalf() else AixLib.DataBase.Walls.WSchV1995.Ceiling.CEpartition_WSchV1995_L_loHalf() else if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.WSchV1984.Ceiling.CEpartition_WSchV1984_SM_loHalf() else AixLib.DataBase.Walls.WSchV1984.Ceiling.CEpartition_WSchV1984_L_loHalf() else if TIR == 1 then AixLib.DataBase.Walls.EnEV2009.Ceiling.CEattic_EnEV2009_SML_loHalf() else if TIR == 2 then AixLib.DataBase.Walls.EnEV2002.Ceiling.CEattic_EnEV2002_SML_loHalf() else if TIR == 3 then AixLib.DataBase.Walls.WSchV1995.Ceiling.CEattic_WSchV1995_SML_loHalf() else AixLib.DataBase.Walls.WSchV1984.Ceiling.CEattic_WSchV1984_SML_loHalf() annotation(Dialog(tab = "Types"));
      //Window type
      parameter AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple Type_Win = if TIR == 1 then AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009() else if TIR == 2 then AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2002() else if TIR == 3 then AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1995() else AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1984() annotation(Dialog(tab = "Types"));
      parameter Modelica.Units.SI.Volume room_V=5.73*2.46;
    equation
      connect(infiltrationRate.port_b, airload.port) annotation(Line(points={{-18,73},{0,73},{0,-12},{-22,-12}},        color = {191, 0, 0}));
      connect(Wall_Staircase.port_outside, thermStaircase) annotation(Line(points={{112.2,-32},{140,-32},{140,-130},{-80,-130},{-80,80},{-102,80}},              color = {191, 0, 0}));
      connect(Wall_Kitchen2.port_outside, thermKitchen) annotation(Line(points={{52,-68.25},{52,-130},{-80,-130},{-80,50},{-102,50}},            color = {191, 0, 0}));
      connect(infiltrationRate.port_a, thermStaircase) annotation(Line(points = {{-44, 73}, {-80, 73}, {-80, 80}, {-102, 80}}, color = {191, 0, 0}));
      connect(Wall_Kitchen1.port_outside, thermKitchen) annotation(Line(points = {{0.1, -74}, {20, -74}, {20, -130}, {-80, -130}, {-80, 50}, {-102, 50}}, color = {191, 0, 0}));
      connect(Wall_Bath.port_outside, thermBath) annotation(Line(points={{-20,-102.15},{-20,-130},{-80,-130},{-80,-40},{-100,-40}},            color = {191, 0, 0}));
      connect(Wall_Bedroom.port_outside, thermBedroom) annotation(Line(points = {{-66.3, -34}, {-80, -34}, {-80, -70}, {-100, -70}}, color = {191, 0, 0}));
      connect(Wall_Ceiling.port_outside, thermCeiling) annotation(Line(points = {{117, 82.1}, {117, 96}, {140, 96}, {140, -130}, {-80, -130}, {-80, -100}, {-100, -100}}, color = {191, 0, 0}));
      connect(Wall_Floor.port_outside, thermFloor) annotation(Line(points={{118,51.85},{118,36},{140,36},{140,-130},{-100,-130}},            color = {191, 0, 0}));
      connect(Wall_Livingroom.port_outside, thermLivingroom) annotation(Line(points={{-28,28.2},{-28,52},{-80,52},{-80,20},{-102,20}},            color = {191, 0, 0}));
      connect(Wall_Children.port_outside, thermChild) annotation(Line(points={{46,28.2},{46,52},{-80,52},{-80,-10},{-102,-10}},            color = {191, 0, 0}));
      connect(Wall_Kitchen2.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{52,-58},{52,-44.0875},{46,-44.0875},{46,-36}},       color={191,0,0}));
      connect(Wall_Staircase.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{104,-32},{94,-32},{94,-44},{46,-44},{46,-36}},       color={191,0,0}));
      connect(Wall_Kitchen1.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-4,-74},{-14,-74},{-14,-44},{46,-44},{46,-36}},       color={191,0,0}));
      connect(Wall_Bath.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-20,-96},{-20,-80},{-14,-80},{-14,-44},{46,-44},{46,-36}},       color={191,0,0}));
      connect(Wall_Bedroom.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-54,-34},{-40,-34},{-40,-80},{-14,-80},{-14,-44},{46,-44},{46,-36}},       color={191,0,0}));
      connect(Wall_Livingroom.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-28,20},{-28,12},{-40,12},{-40,-80},{-14,-80},{-14,-44},{46,-44},{46,-36}},       color={191,0,0}));
      connect(Wall_Children.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{46,20},{46,10},{94,10},{94,-44},{46,-44},{46,-36}},       color={191,0,0}));
      connect(Wall_Floor.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{118,58},{118,64},{94,64},{94,-44},{46,-44},{46,-36}},       color={191,0,0}));
      connect(Wall_Ceiling.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{117,78},{117,64},{94,64},{94,-44},{46,-44},{46,-36}},       color={191,0,0}));
      connect(airload.port, thermStar_Demux.portConv) annotation (Line(points={{-22,-12},{41,-12},{41,-16}},     color={191,0,0}));
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -150}, {150, 100}}), graphics={  Polygon(points = {{-60, 60}, {120, 60}, {120, -60}, {20, -60}, {20, -100}, {-60, -100}, {-60, -18}, {-60, 60}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
                fillPattern =                                                                                                   FillPattern.Forward), Text(extent = {{-26, 6}, {82, -26}}, lineColor = {0, 0, 0}, fillColor = {255, 0, 0},
                fillPattern =                                                                                                   FillPattern.Forward, textString = "Corridor"), Rectangle(extent = {{-110, -120}, {-90, -140}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, -90}, {-90, -110}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, -60}, {-90, -80}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, -30}, {-90, -50}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5), Rectangle(extent = {{-112, 60}, {-92, 40}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5), Rectangle(extent = {{-112, 90}, {-92, 70}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5), Rectangle(extent = {{108, 12}, {128, -18}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   1, fillColor = {127, 0, 0},
                fillPattern =                                                                                                   FillPattern.Forward), Ellipse(extent = {{110, 0}, {112, -2}}, lineColor = {0, 0, 0}, pattern=LinePattern.None,
                lineThickness =                                                                                                   1,
                fillPattern =                                                                                                   FillPattern.Sphere, fillColor = {255, 255, 0}), Text(extent = {{78, 38}, {164, 18}}, lineColor = {0, 0, 255}, textString = "Staircase"), Rectangle(extent = {{-112, 0}, {-92, -20}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5), Rectangle(extent = {{-112, 30}, {-92, 10}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5)}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -150}, {150, 100}})),           Documentation(revisions = "<html><ul>
  <li>
    <i>April 18, 2014</i> by Ana Constantin:<br/>
    Added documentation
  </li>
  <li>
    <i>August 16, 2011</i> by Ana Constantin:<br/>
    Implemented
  </li>
</ul>
</html>",     info = "<html>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Model for the corridor.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The following figure presents the room's layout:
</p>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/Building/HighOrder/VoWo_Corridor.png\"
  alt=\"Room layout\">
</p>
</html>"));
    end Corridor_VoWo;

    model Kitchen_VoWo "Kitchen from the VoWo appartment"
      ///////// construction parameters
      parameter Integer TMC = 1 "Thermal Mass Class" annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice = 1 "Heavy", choice = 2 "Medium", choice = 3 "Light", radioButtons = true));
      parameter Integer TIR = 4 "Thermal Insulation Regulation" annotation(Dialog(groupImage = "modelica://AixLib/Resources/Images/Building/HighOrder/VoWo_Kitchen.png", group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice = 1
            "EnEV_2009",                                                                                                    choice = 2
            "EnEV_2002",                                                                                                    choice = 3
            "WSchV_1995",                                                                                                    choice = 4
            "WSchV_1984",                                                                                                    radioButtons = true));
      parameter Integer Floor = 1 "Floor" annotation(Dialog(group = "Floor", compact = true, descriptionLabel = true), choices(choice = 1 "GF", choice = 2 "1F", choice = 3 "2F", radioButtons = true));
      // Outer walls properties
      parameter Real solar_absorptance_OW = 0.7 "Solar absoptance outer walls " annotation(Dialog(group = "Outer wall properties", descriptionLabel = true));
      parameter Integer calcMethod=1 "Calculation method for convective heat transfer coefficient" annotation (Dialog(
          group="Outer wall properties",
          compact=true,
          descriptionLabel=true), choices(
          choice=1 "DIN 6946",
          choice=2 "ASHRAE Fundamentals",
          choice=3 "Custom hCon (constant)",
          radioButtons=true));
      //Initial temperatures
      parameter Modelica.Units.SI.Temperature T0_air=295.15 "Air"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      parameter Modelica.Units.SI.Temperature T0_OW=295.15 "OW"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      parameter Modelica.Units.SI.Temperature T0_IWBath=297.15 "IWBathroom"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      parameter Modelica.Units.SI.Temperature T0_IWCorridor=290.15 "IWCorridor"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      parameter Modelica.Units.SI.Temperature T0_IWStraicase=288.15 "IWStaircase"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      parameter Modelica.Units.SI.Temperature T0_CE=295.35 "Ceiling"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      parameter Modelica.Units.SI.Temperature T0_FL=294.95 "Floor"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      // Sunblind
      parameter Boolean use_sunblind = false
        "Will sunblind become active automatically?"
        annotation(Dialog(group = "Sunblind"));
      parameter Real ratioSunblind(min=0.0, max=1.0) = 0.8
        "Sunblind factor. 1 means total blocking of irradiation, 0 no sunblind"
        annotation(Dialog(group = "Sunblind", enable=use_sunblind));
      parameter Modelica.Units.SI.Irradiance solIrrThreshold(min=0.0) = 350
        "Threshold for global solar irradiation on this surface to enable sunblinding (see also TOutAirLimit)"
        annotation (Dialog(group="Sunblind", enable=use_sunblind));
      parameter Modelica.Units.SI.Temperature TOutAirLimit
        "Temperature at which sunblind closes (see also solIrrThreshold)"
        annotation (Dialog(group="Sunblind", enable=use_sunblind));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Corridor1(
        redeclare final model WindowModel=WindowModel,
        redeclare final model CorrSolarGainWin=CorrSolarGainWin,
        T0=T0_IWCorridor,
        outside=false,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        wallPar=Type_IWsimple,
        wall_length=2.2,
        wall_height=2.46,
        withWindow=false,
        withDoor=false) annotation (Placement(transformation(
            origin={-3,30},
            extent={{-8,-51},{8,51}},
            rotation=270)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Bath1(
        redeclare final model WindowModel=WindowModel,
        redeclare final model CorrSolarGainWin=CorrSolarGainWin,
        T0=T0_IWBath,
        outside=false,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        wallPar=Type_IWsimple,
        wall_length=3.28,
        wall_height=2.46,
        withWindow=false,
        withDoor=false) annotation (Placement(transformation(extent={{-68,-50},{-62,-12}})));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Staircase(
        redeclare final model WindowModel=WindowModel,
        redeclare final model CorrSolarGainWin=CorrSolarGainWin,
        T0=T0_IWStraicase,
        outside=false,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        wallPar=Type_IWload,
        wall_length=3.94,
        wall_height=2.46,
        withWindow=false,
        withDoor=false) annotation (Placement(transformation(
            origin={45,-29},
            extent={{-7,-49},{7,49}},
            rotation=180)));
      AixLib.ThermalZones.HighOrder.Components.DryAir.Airload airload(
        final T0=T0_air,
        final V=room_V)
        annotation (Placement(transformation(extent={{-36,-16},{-16,4}})));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Bath2(
        redeclare final model WindowModel=WindowModel,
        redeclare final model CorrSolarGainWin=CorrSolarGainWin,
        T0=T0_IWBath,
        outside=false,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        wallPar=Type_IWsimple,
        wall_length=0.44,
        wall_height=2.46,
        withWindow=false,
        withDoor=false) annotation (Placement(transformation(
            origin={-46,-75},
            extent={{-2.99998,-16},{2.99998,16}},
            rotation=90)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall outsideWall(
        redeclare final model WindowModel=WindowModel,
        redeclare final model CorrSolarGainWin=CorrSolarGainWin,
        wall_length=1.8,
        wall_height=2.46,
        windowarea=0.75,
        T0=T0_OW,
        solar_absorptance=solar_absorptance_OW,
        withWindow=true,
        withDoor=false,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        wallPar=Type_OW,
        WindowType=Type_Win) annotation (Placement(transformation(
            origin={5,-99},
            extent={{-7,-45},{7,45}},
            rotation=90)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Corridor2(
        redeclare final model WindowModel=WindowModel,
        redeclare final model CorrSolarGainWin=CorrSolarGainWin,
        T0=T0_IWCorridor,
        outside=false,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        wallPar=Type_IWsimple,
        wall_length=0.6,
        wall_height=2.46,
        withWindow=false,
        withDoor=false) annotation (Placement(transformation(extent={{-68,-2},{-64,24}})));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Ceiling(
        redeclare final model WindowModel=WindowModel,
        redeclare final model CorrSolarGainWin=CorrSolarGainWin,
        T0=T0_CE,
        outside=false,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        wallPar=Type_CE,
        wall_length=sqrt(8.35),
        wall_height=sqrt(8.35),
        ISOrientation=3,
        withWindow=false,
        withDoor=false) annotation (Placement(transformation(
            origin={80,-72},
            extent={{-1.99998,-10},{1.99998,10}},
            rotation=270)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Floor(
        redeclare final model WindowModel=WindowModel,
        redeclare final model CorrSolarGainWin=CorrSolarGainWin,
        T0=T0_FL,
        outside=false,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        wallPar=Type_FL,
        wall_length=sqrt(8.35),
        wall_height=sqrt(8.35),
        ISOrientation=2,
        withWindow=false,
        withDoor=false) annotation (Placement(transformation(
            origin={80,-100},
            extent={{-1.99984,-10},{1.99983,10}},
            rotation=90)));
      AixLib.Utilities.Interfaces.SolarRad_in SolarRadiation_NW annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-20,-150})));
      Modelica.Blocks.Interfaces.RealInput AirExchangePort annotation(Placement(transformation(extent = {{-130, 56}, {-90, 96}}), iconTransformation(extent = {{-108, 52}, {-90, 70}})));
      Modelica.Blocks.Interfaces.RealInput WindSpeedPort annotation(Placement(transformation(extent = {{-130, 28}, {-90, 68}}), iconTransformation(extent = {{-108, 20}, {-90, 38}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermOutside annotation(Placement(transformation(extent = {{-108, 80}, {-88, 100}}), iconTransformation(extent = {{-108, 80}, {-88, 100}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCorridor annotation(Placement(transformation(extent = {{-110, -20}, {-90, 0}}), iconTransformation(extent = {{-110, -20}, {-90, 0}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermStaircase annotation(Placement(transformation(extent = {{-110, -60}, {-90, -40}}), iconTransformation(extent = {{-110, -60}, {-90, -40}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermBath annotation(Placement(transformation(extent = {{-110, -100}, {-90, -80}}), iconTransformation(extent = {{-110, -100}, {-90, -80}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling annotation(Placement(transformation(extent = {{-110, -140}, {-90, -120}}), iconTransformation(extent = {{-110, -140}, {-90, -120}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor annotation(Placement(transformation(extent = {{-70, -160}, {-50, -140}}), iconTransformation(extent = {{-70, -160}, {-50, -140}})));
      AixLib.ThermalZones.HighOrder.Components.DryAir.InfiltrationRate_DIN12831
        infiltrationRate(
        room_V=room_V,
        n50=n50,
        e=e,
        eps=eps) annotation (Placement(transformation(extent={{-42,72},{-18,96}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermRoom annotation(Placement(transformation(extent = {{-2, -18}, {18, 2}})));
      AixLib.Utilities.Interfaces.RadPort StarRoom
        annotation (Placement(transformation(extent={{-4,-48},{16,-28}})));
      AixLib.Utilities.Interfaces.Adaptors.ConvRadToCombPort thermStar_Demux annotation (Placement(transformation(
            extent={{10,-8},{-10,8}},
            rotation=180,
            origin={-30,-40})));
      AixLib.ThermalZones.HighOrder.Components.DryAir.VarAirExchange
        NaturalVentilation(V=room_V)
        annotation (Placement(transformation(extent={{-2,72},{22,96}})));

      replaceable model WindowModel =
          AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.PartialWindow
        constrainedby
        AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.PartialWindow
                                                                                                      annotation (Dialog(tab="Outer walls", group="Windows"), choicesAllMatching = true);

      replaceable model CorrSolarGainWin =
          AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.CorrectionSolarGain.PartialCorG
        constrainedby
        AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.CorrectionSolarGain.PartialCorG
                                                                                                                        "Correction model for solar irradiance as transmitted radiation" annotation (choicesAllMatching=true, Dialog(tab="Outer walls", group="Windows", enable = withWindow and outside));

    protected
      parameter Real n50(unit = "h-1") = if TIR == 1 or TIR == 2 then 3 else if TIR == 3 then 4 else 6
        "Air exchange rate at 50 Pa pressure difference"                                                                                                annotation(Dialog(tab = "Infiltration"));
      parameter Real e = 0.03 "Coefficient of windshield" annotation(Dialog(tab = "Infiltration"));
      parameter Real eps = 1.0 "Coefficient of height" annotation(Dialog(tab = "Infiltration"));
      // Outer wall type
      parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_OW = if TIR == 1 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_M() else AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_L() else if TIR == 2 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_S() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_M() else AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_L() else if TIR == 3 then if TMC == 1 then AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_S() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_M() else AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_L() else if TMC == 1 then AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_S() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_M() else AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_L() annotation(Dialog(tab = "Types"));
      //Inner wall Types
      parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_IWsimple = if TIR == 1 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_S_half() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_M_half() else AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_L_half() else if TIR == 2 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_S_half() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_M_half() else AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_L_half() else if TIR == 3 then if TMC == 1 then AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_S_half() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_M_half() else AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_L_half() else if TMC == 1 then AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_S_half() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_M_half() else AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_L_half() annotation(Dialog(tab = "Types"));
      parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_IWload = if TIR == 1 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_M_half() else AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_L_half() else if TIR == 2 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_S_half() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_M_half() else AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_L_half() else if TIR == 3 then if TMC == 1 then AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_S_half() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_M_half() else AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_L_half() else if TMC == 1 then AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_S_half() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_M_half() else AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_L_half() annotation(Dialog(tab = "Types"));
      // Floor type
      parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_FL = if Floor == 1 then if TIR == 1 then AixLib.DataBase.Walls.EnEV2009.Floor.FLcellar_EnEV2009_SML_upHalf() else if TIR == 2 then AixLib.DataBase.Walls.EnEV2002.Floor.FLcellar_EnEV2002_SML_upHalf() else if TIR == 3 then AixLib.DataBase.Walls.WSchV1995.Floor.FLcellar_WSchV1995_SML_upHalf() else AixLib.DataBase.Walls.WSchV1984.Floor.FLcellar_WSchV1984_SML_upHalf() else if TIR == 1 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_SM_upHalf() else AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_L_upHalf() else if TIR == 2 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.EnEV2002.Floor.FLpartition_EnEV2002_SM_upHalf() else AixLib.DataBase.Walls.EnEV2002.Floor.FLpartition_EnEV2002_L_upHalf() else if TIR == 3 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.WSchV1995.Floor.FLpartition_WSchV1995_SM_upHalf() else AixLib.DataBase.Walls.WSchV1995.Floor.FLpartition_WSchV1995_L_upHalf() else if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.WSchV1984.Floor.FLpartition_WSchV1984_SM_upHalf() else AixLib.DataBase.Walls.WSchV1984.Floor.FLpartition_WSchV1984_L_upHalf() annotation(Dialog(tab = "Types"));
      // Ceiling  type
      parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_CE = if Floor == 1 or Floor == 2 then if TIR == 1 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_SM_loHalf() else AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_L_loHalf() else if TIR == 2 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.EnEV2002.Ceiling.CEpartition_EnEV2002_SM_loHalf() else AixLib.DataBase.Walls.EnEV2002.Ceiling.CEpartition_EnEV2002_L_loHalf() else if TIR == 3 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.WSchV1995.Ceiling.CEpartition_WSchV1995_SM_loHalf() else AixLib.DataBase.Walls.WSchV1995.Ceiling.CEpartition_WSchV1995_L_loHalf() else if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.WSchV1984.Ceiling.CEpartition_WSchV1984_SM_loHalf() else AixLib.DataBase.Walls.WSchV1984.Ceiling.CEpartition_WSchV1984_L_loHalf() else if TIR == 1 then AixLib.DataBase.Walls.EnEV2009.Ceiling.CEattic_EnEV2009_SML_loHalf() else if TIR == 2 then AixLib.DataBase.Walls.EnEV2002.Ceiling.CEattic_EnEV2002_SML_loHalf() else if TIR == 3 then AixLib.DataBase.Walls.WSchV1995.Ceiling.CEattic_WSchV1995_SML_loHalf() else AixLib.DataBase.Walls.WSchV1984.Ceiling.CEattic_WSchV1984_SML_loHalf() annotation(Dialog(tab = "Types"));
      //Window type
      parameter AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple Type_Win = if TIR == 1 then AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009() else if TIR == 2 then AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2002() else if TIR == 3 then AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1995() else AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1984() annotation(Dialog(tab = "Types"));
      parameter Modelica.Units.SI.Volume room_V=8.35*2.46;
    equation
      connect(outsideWall.SolarRadiationPort, SolarRadiation_NW) annotation(Line(points = {{-36.25, -108.1}, {-36.25, -120}, {-20, -120}, {-20, -150}}, color = {255, 128, 0}));
      connect(outsideWall.WindSpeedPort, WindSpeedPort) annotation(Line(points = {{-28, -106.35}, {-28, -120}, {-80, -120}, {-80, 48}, {-110, 48}}, color = {0, 0, 127}));
      connect(Wall_Corridor1.port_outside, thermCorridor) annotation(Line(points = {{-3, 38.4}, {-3, 60}, {-80, 60}, {-80, -10}, {-100, -10}}, color = {191, 0, 0}));
      connect(Wall_Corridor2.port_outside, thermCorridor) annotation(Line(points = {{-68.1, 11}, {-80, 11}, {-80, -10}, {-100, -10}}, color = {191, 0, 0}));
      connect(Wall_Staircase.port_outside, thermStaircase) annotation(Line(points = {{52.35, -29}, {100, -29}, {100, -120}, {-80, -120}, {-80, -50}, {-100, -50}}, color = {191, 0, 0}));
      connect(Wall_Bath2.port_outside, thermBath) annotation(Line(points={{-46,-78.15},{-46,-90},{-100,-90}},        color = {191, 0, 0}));
      connect(Wall_Bath1.port_outside, thermBath) annotation(Line(points = {{-68.15, -31}, {-80, -31}, {-80, -90}, {-100, -90}}, color = {191, 0, 0}));
      connect(Wall_Ceiling.port_outside, thermCeiling) annotation(Line(points={{80,-69.9},{80,-48},{100,-48},{100,-130},{-100,-130}},            color = {191, 0, 0}));
      connect(Wall_Floor.port_outside, thermFloor) annotation(Line(points={{80,-102.1},{80,-120},{-60,-120},{-60,-150}},          color = {191, 0, 0}));
      connect(infiltrationRate.port_b, airload.port) annotation(Line(points={{-18,84},{-12,84},{-12,60},{-56,60},{-56,10},{-40,10},{-40,-16},{-26,-16}},                color = {191, 0, 0}));
      connect(thermCeiling, thermCeiling) annotation(Line(points = {{-100, -130}, {-100, -130}}, color = {191, 0, 0}));
      connect(infiltrationRate.port_a, thermOutside) annotation(Line(points = {{-42, 84}, {-98, 84}, {-98, 90}}, color = {191, 0, 0}));
      connect(thermStar_Demux.portRad, StarRoom) annotation (Line(
          points={{-20,-45},{-12,-45},{-12,-38},{6,-38}},
          color={95,95,95},
          pattern=LinePattern.Solid));
      connect(airload.port, thermStar_Demux.portConv) annotation (Line(points={{-35,-8},{-40,-8},{-40,-20},{-12,-20},{-12,-34.9},{-19.9,-34.9}}, color={191,0,0}));
      connect(Wall_Bath1.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-62,-31},{-52,-31},{-52,-41.3},{-39.8,-41.3}}, color={191,0,0}));
      connect(Wall_Corridor2.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-64,11},{-52,11},{-52,-40},{-39.8,-40},{-39.8,-41.3}},
                                                                                                                                                                   color={191,0,0}));
      connect(Wall_Corridor1.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-3,22},{-3,10},{-52,10},{-52,-41.3},{-39.8,-41.3}}, color={191,0,0}));
      connect(Wall_Bath2.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-46,-72},{-46,-60},{-52,-60},{-52,
              -41.3},{-39.8,-41.3}},                                                                                                                               color={191,0,0}));
      connect(outsideWall.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{5,-92},{5,-60},{-52,-60},{-52,-41.3},{-39.8,-41.3}}, color={191,0,0}));
      connect(Wall_Staircase.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{38,-29},{28,-29},{28,-60},{-52,-60},{-52,-41.3},{-39.8,-41.3}}, color={191,0,0}));
      connect(Wall_Floor.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{80,-98.0002},{80,-86},{28,-86},{28,
              -60},{-52,-60},{-52,-41.3},{-39.8,-41.3}},                                                                                                                                color={191,0,0}));
      connect(Wall_Ceiling.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{80,-74},{80,-86},{28,-86},{28,-60},
              {-52,-60},{-52,-41.3},{-39.8,-41.3}},                                                                                                                                  color={191,0,0}));
      connect(NaturalVentilation.ventRate, AirExchangePort) annotation (Line(points=
             {{-0.8,76.32},{-12,76.32},{-12,60},{-80,60},{-80,76},{-110,76}}, color=
             {0,0,127}));
      connect(NaturalVentilation.port_a, thermOutside) annotation(Line(points = {{-2, 84}, {-12, 84}, {-12, 60}, {-98, 60}, {-98, 90}}, color = {191, 0, 0}));
      connect(NaturalVentilation.port_b, airload.port) annotation(Line(points={{22,84},{24,84},{24,60},{-56,60},{-56,10},{-40,10},{-40,-16},{-26,-16}},                color = {191, 0, 0}));
      connect(outsideWall.port_outside, thermOutside) annotation(Line(points = {{5, -106.35}, {5, -120}, {-80, -120}, {-80, 60}, {-98, 60}, {-98, 90}}, color = {191, 0, 0}));
      connect(ThermRoom, airload.port) annotation(Line(points={{8,-8},{-10,-8},{-10,-20},{-40,-20},{-40,-16},{-26,-16}},            color = {191, 0, 0}));
      annotation(Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -150}, {150, 100}}), graphics), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -150}, {150, 100}}), graphics={  Polygon(points = {{-60, 58}, {-60, -62}, {-18, -62}, {-18, -122}, {100, -122}, {100, 58}, {-60, 58}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
                fillPattern =                                                                                                   FillPattern.Forward), Text(extent = {{-32, 38}, {84, 4}}, lineColor = {0, 0, 0}, fillColor = {255, 0, 0},
                fillPattern =                                                                                                   FillPattern.Forward, textString = "Kitchen"), Rectangle(extent = {{-18, -114}, {4, -134}}, lineColor = {0, 0, 0}, fillColor = {85, 255, 255},
                fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-16, -116}, {2, -132}}, lineColor = {0, 0, 0}, fillColor = {170, 213, 255},
                fillPattern =                                                                                                   FillPattern.Solid), Line(points = {{-12, -128}, {-2, -118}}, color = {255, 255, 255}, thickness = 1), Line(points = {{-8, -128}, {-2, -122}}, color = {255, 255, 255}, thickness = 1), Line(points = {{-12, -124}, {-6, -118}}, color = {255, 255, 255}, thickness = 1), Text(extent = {{-6, -122}, {44, -138}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   1, fillColor = {255, 255, 255},
                fillPattern =                                                                                                   FillPattern.Solid, textString = "OW"), Text(extent = {{12, 76}, {72, 60}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   1, fillColor = {255, 255, 255},
                fillPattern =                                                                                                   FillPattern.Solid, textString = "Corridor"), Rectangle(extent = {{72, 82}, {92, 52}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   1, fillColor = {127, 0, 0},
                fillPattern =                                                                                                   FillPattern.Forward), Ellipse(extent = {{74, 70}, {76, 68}}, lineColor = {0, 0, 0}, pattern=LinePattern.None,
                lineThickness =                                                                                                   1,
                fillPattern =                                                                                                   FillPattern.Sphere, fillColor = {255, 255, 0}), Rectangle(extent = {{-70, -140}, {-50, -160}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, -120}, {-90, -140}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, -80}, {-90, -100}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, -40}, {-90, -60}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5), Rectangle(extent = {{-110, 0}, {-90, -20}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5), Rectangle(extent = {{-108, 72}, {-88, 18}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5), Rectangle(extent = {{-108, 100}, {-88, 80}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5)}), Documentation(revisions = "<html><ul>
  <li>
    <i>April 18, 2014</i> by Ana Constantin:<br/>
    Added documentation
  </li>
  <li>
    <i>August 16, 2011</i> by Ana Constantin:<br/>
    Implemented
  </li>
</ul>
</html>",     info = "<html>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Model for the kitchen.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The following figure presents the room's layout:
</p>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/Building/HighOrder/VoWo_Kitchen.png\"
  alt=\"Room layout\">
</p>
</html>"));
    end Kitchen_VoWo;

    model Livingroom_VoWo "Livingroom from the VoWo appartment"
      ///////// construction parameters
      parameter Integer TMC = 1 "Thermal Mass Class" annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice = 1 "Heavy", choice = 2 "Medium", choice = 3 "Light", radioButtons = true));
      parameter Integer TIR = 4 "Thermal Insulation Regulation" annotation(Dialog(groupImage = "modelica://AixLib/Resources/Images/Building/HighOrder/VoWo_Livingroom.png", group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice = 1
            "EnEV_2009",                                                                                                    choice = 2
            "EnEV_2002",                                                                                                    choice = 3
            "WSchV_1995",                                                                                                    choice = 4
            "WSchV_1984",                                                                                                    radioButtons = true));
      parameter Integer Floor = 1 "Floor" annotation(Dialog(group = "Floor", compact = true, descriptionLabel = true), choices(choice = 1 "GF", choice = 2 "1F", choice = 3 "2F", radioButtons = true));
      // Outer walls properties
      parameter Real solar_absorptance_OW = 0.7 "Solar absoptance outer walls " annotation(Dialog(group = "Outer wall properties", descriptionLabel = true));
      parameter Integer calcMethod=1 "Calculation method for convective heat transfer coefficient" annotation (Dialog(
          group="Outer wall properties",
          compact=true,
          descriptionLabel=true), choices(
          choice=1 "DIN 6946",
          choice=2 "ASHRAE Fundamentals",
          choice=3 "Custom hCon (constant)",
          radioButtons=true));
      //Initial temperatures
      parameter Modelica.Units.SI.Temperature T0_air=295.15 "Air"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      parameter Modelica.Units.SI.Temperature T0_OW=295.15 "OW"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      parameter Modelica.Units.SI.Temperature T0_IWChild=295.15 "IWChild"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      parameter Modelica.Units.SI.Temperature T0_IWCorridor=290.15 "IWCorridor"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      parameter Modelica.Units.SI.Temperature T0_IWBedroom=295.15 "IWBedroom"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      parameter Modelica.Units.SI.Temperature T0_IWNeighbour=295.15 "IWNeighbour"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      parameter Modelica.Units.SI.Temperature T0_CE=295.35 "Ceiling"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      parameter Modelica.Units.SI.Temperature T0_FL=294.95 "Floor"
        annotation (Dialog(tab="Initial temperatures", descriptionLabel=true));
      // Sunblind
      parameter Boolean use_sunblind = false
        "Will sunblind become active automatically?"
        annotation(Dialog(group = "Sunblind"));
      parameter Real ratioSunblind(min=0.0, max=1.0) = 0.8
        "Sunblind factor. 1 means total blocking of irradiation, 0 no sunblind"
        annotation(Dialog(group = "Sunblind", enable=use_sunblind));
      parameter Modelica.Units.SI.Irradiance solIrrThreshold(min=0.0) = 350
        "Threshold for global solar irradiation on this surface to enable sunblinding (see also TOutAirLimit)"
        annotation (Dialog(group="Sunblind", enable=use_sunblind));
      parameter Modelica.Units.SI.Temperature TOutAirLimit
        "Temperature at which sunblind closes (see also solIrrThreshold)"
        annotation (Dialog(group="Sunblind", enable=use_sunblind));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Neighbour(
        redeclare final model WindowModel=WindowModel,
        redeclare final model CorrSolarGainWin=CorrSolarGainWin,
        T0=T0_IWNeighbour,
        outside=false,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        wallPar=Type_IWNeigbour,
        wall_length=4.2,
        wall_height=2.46,
        withWindow=false,
        withDoor=false) annotation (Placement(transformation(extent={{-80,-24},{-68,54}})));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Corridor(
        redeclare final model WindowModel=WindowModel,
        redeclare final model CorrSolarGainWin=CorrSolarGainWin,
        T0=T0_IWCorridor,
        outside=false,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        wallPar=Type_IWload,
        wall_length=1.54,
        wall_height=2.46,
        withWindow=false,
        withDoor=false) annotation (Placement(transformation(
            origin={19,-43},
            extent={{-4.99999,-31},{4.99998,31}},
            rotation=90)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Children(
        redeclare final model WindowModel=WindowModel,
        redeclare final model CorrSolarGainWin=CorrSolarGainWin,
        T0=T0_IWChild,
        outside=false,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        wallPar=Type_IWload,
        wall_length=4.2,
        wall_height=2.46,
        withWindow=false,
        withDoor=false) annotation (Placement(transformation(
            origin={75,14.9756},
            extent={{-7.00003,-39.0244},{7.00003,40.9756}},
            rotation=180)));
      AixLib.ThermalZones.HighOrder.Components.DryAir.Airload airload(
        final T0=T0_air,
        final V=room_V)
        annotation (Placement(transformation(extent={{-28,0},{-48,20}})));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall outsideWall(
        redeclare final model WindowModel=WindowModel,
        redeclare final model CorrSolarGainWin=CorrSolarGainWin,
        wall_length=4.645,
        wall_height=2.46,
        windowarea=3.99,
        door_height=0.1,
        door_width=0.1,
        withWindow=true,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        T0=T0_OW,
        solar_absorptance=solar_absorptance_OW,
        withDoor=false,
        wallPar=Type_OW,
        WindowType=Type_Win) annotation (Placement(transformation(
            origin={-14.9999,71},
            extent={{-13,-61.0001},{11,82.9999}},
            rotation=270)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Bedroom(
        redeclare final model WindowModel=WindowModel,
        redeclare final model CorrSolarGainWin=CorrSolarGainWin,
        T0=T0_IWBedroom,
        outside=false,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        wallPar=Type_IWload,
        wall_length=3.105,
        wall_height=2.46,
        withWindow=false,
        withDoor=false) annotation (Placement(transformation(
            origin={-45,-44},
            extent={{-3.99999,-25},{3.99998,25}},
            rotation=90)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Ceiling(
        redeclare final model WindowModel=WindowModel,
        redeclare final model CorrSolarGainWin=CorrSolarGainWin,
        T0=T0_CE,
        outside=false,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        wallPar=Type_CE,
        wall_length=4.2,
        wall_height=4.645,
        calcMethodOut=1,
        ISOrientation=3,
        withWindow=false,
        withDoor=false) annotation (Placement(transformation(
            origin={104,70},
            extent={{-1.99998,-10},{1.99998,10}},
            rotation=270)));
      AixLib.ThermalZones.HighOrder.Components.Walls.Wall Wall_Floor(
        redeclare final model WindowModel=WindowModel,
        redeclare final model CorrSolarGainWin=CorrSolarGainWin,
        T0=T0_FL,
        outside=false,
        final withSunblind=use_sunblind,
        final Blinding=1 - ratioSunblind,
        final LimitSolIrr=solIrrThreshold,
        final TOutAirLimit=TOutAirLimit,
        wallPar=Type_FL,
        wall_length=4.2,
        wall_height=4.645,
        ISOrientation=2,
        withWindow=false,
        withDoor=false) annotation (Placement(transformation(
            origin={104,32},
            extent={{-1.99998,-10},{1.99998,10}},
            rotation=90)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermRoom annotation(Placement(transformation(extent = {{-12, 4}, {8, 24}}), iconTransformation(extent = {{-12, 4}, {8, 24}})));
      AixLib.Utilities.Interfaces.RadPort StarInside1 annotation (Placement(
            transformation(extent={{16,4},{36,24}}), iconTransformation(extent=
                {{16,4},{36,24}})));
      AixLib.Utilities.Interfaces.SolarRad_in SolarRadiation_SE annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-66,134})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermOutside annotation(Placement(transformation(extent = {{-160, 120}, {-140, 140}}), iconTransformation(extent = {{-160, 120}, {-140, 140}})));
      Modelica.Blocks.Interfaces.RealInput AirExchangePort annotation(Placement(transformation(extent = {{-180, 50}, {-140, 90}}), iconTransformation(extent = {{-160, 70}, {-140, 90}})));
      Modelica.Blocks.Interfaces.RealInput WindSpeedPort annotation(Placement(transformation(extent = {{-180, 10}, {-140, 50}}), iconTransformation(extent = {{-160, 30}, {-140, 50}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling annotation(Placement(transformation(extent = {{-160, -120}, {-140, -100}}), iconTransformation(extent = {{-160, -120}, {-140, -100}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor annotation(Placement(transformation(extent = {{-160, -150}, {-140, -130}}), iconTransformation(extent = {{-160, -150}, {-140, -130}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermChildren annotation(Placement(transformation(extent = {{-160, -90}, {-140, -70}}), iconTransformation(extent = {{-160, -90}, {-140, -70}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCorridor annotation(Placement(transformation(extent = {{-160, -60}, {-140, -40}}), iconTransformation(extent = {{-160, -60}, {-140, -40}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermBedroom annotation(Placement(transformation(extent = {{-160, -30}, {-140, -10}}), iconTransformation(extent = {{-160, -30}, {-140, -10}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermNeighbour annotation(Placement(transformation(extent = {{-160, 0}, {-140, 20}}), iconTransformation(extent = {{-160, 0}, {-140, 20}})));
      AixLib.ThermalZones.HighOrder.Components.DryAir.InfiltrationRate_DIN12831
        infiltrationRate(
        room_V=room_V,
        n50=n50,
        e=e,
        eps=eps)
        annotation (Placement(transformation(extent={{-72,-84},{-46,-58}})));
      AixLib.Utilities.Interfaces.Adaptors.ConvRadToCombPort thermStar_Demux annotation (Placement(transformation(
            extent={{-10,8},{10,-8}},
            rotation=180,
            origin={24,-14})));
      AixLib.ThermalZones.HighOrder.Components.DryAir.VarAirExchange
        NaturalVentilation(V=room_V)
        annotation (Placement(transformation(extent={{-72,-112},{-46,-86}})));

      replaceable model WindowModel =
          AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.PartialWindow
        constrainedby
        AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.PartialWindow
                                                                                                      annotation (Dialog(tab="Outer walls", group="Windows"), choicesAllMatching = true);

      replaceable model CorrSolarGainWin =
          AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.CorrectionSolarGain.PartialCorG
        constrainedby
        AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.CorrectionSolarGain.PartialCorG
                                                                                                                        "Correction model for solar irradiance as transmitted radiation" annotation (choicesAllMatching=true, Dialog(tab="Outer walls", group="Windows", enable = withWindow and outside));

    protected
      parameter Real n50(unit = "h-1") = if TIR == 1 or TIR == 2 then 3 else if TIR == 3 then 4 else 6
        "Air exchange rate at 50 Pa pressure difference"                                                                                                annotation(Dialog(tab = "Infiltration"));
      parameter Real e = 0.03 "Coefficient of windshield" annotation(Dialog(tab = "Infiltration"));
      parameter Real eps = 1.0 "Coefficient of height" annotation(Dialog(tab = "Infiltration"));
      // Outer wall type
      parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_OW = if TIR == 1 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_M() else AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_L() else if TIR == 2 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_S() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_M() else AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_L() else if TIR == 3 then if TMC == 1 then AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_S() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_M() else AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_L() else if TMC == 1 then AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_S() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_M() else AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_L() annotation(Dialog(tab = "Types"));
      //Inner wall Types
      parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_IWload = if TIR == 1 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_M_half() else AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_L_half() else if TIR == 2 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_S_half() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_M_half() else AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_L_half() else if TIR == 3 then if TMC == 1 then AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_S_half() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_M_half() else AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_L_half() else if TMC == 1 then AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_S_half() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_M_half() else AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_L_half() annotation(Dialog(tab = "Types"));
      parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_IWNeigbour = if TIR == 1 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2009.IW.IWneighbour_EnEV2009_S_half() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2009.IW.IWneighbour_EnEV2009_M_half() else AixLib.DataBase.Walls.EnEV2009.IW.IWneighbour_EnEV2009_L_half() else if TIR == 2 then if TMC == 1 then AixLib.DataBase.Walls.EnEV2002.IW.IWneighbour_EnEV2002_S_half() else if TMC == 2 then AixLib.DataBase.Walls.EnEV2002.IW.IWneighbour_EnEV2002_M_half() else AixLib.DataBase.Walls.EnEV2002.IW.IWneighbour_EnEV2002_L_half() else if TIR == 3 then if TMC == 1 then AixLib.DataBase.Walls.WSchV1995.IW.IWneighbour_WSchV1995_S_half() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1995.IW.IWneighbour_WSchV1995_M_half() else AixLib.DataBase.Walls.WSchV1995.IW.IWneighbour_WSchV1995_L_half() else if TMC == 1 then AixLib.DataBase.Walls.WSchV1984.IW.IWneighbour_WSchV1984_S_half() else if TMC == 2 then AixLib.DataBase.Walls.WSchV1984.IW.IWneighbour_WSchV1984_M_half() else AixLib.DataBase.Walls.WSchV1984.IW.IWneighbour_WSchV1984_L_half() annotation(Dialog(tab = "Types"));
      // Floor type
      parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_FL = if Floor == 1 then if TIR == 1 then AixLib.DataBase.Walls.EnEV2009.Floor.FLcellar_EnEV2009_SML_upHalf() else if TIR == 2 then AixLib.DataBase.Walls.EnEV2002.Floor.FLcellar_EnEV2002_SML_upHalf() else if TIR == 3 then AixLib.DataBase.Walls.WSchV1995.Floor.FLcellar_WSchV1995_SML_upHalf() else AixLib.DataBase.Walls.WSchV1984.Floor.FLcellar_WSchV1984_SML_upHalf() else if TIR == 1 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_SM_upHalf() else AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_L_upHalf() else if TIR == 2 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.EnEV2002.Floor.FLpartition_EnEV2002_SM_upHalf() else AixLib.DataBase.Walls.EnEV2002.Floor.FLpartition_EnEV2002_L_upHalf() else if TIR == 3 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.WSchV1995.Floor.FLpartition_WSchV1995_SM_upHalf() else AixLib.DataBase.Walls.WSchV1995.Floor.FLpartition_WSchV1995_L_upHalf() else if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.WSchV1984.Floor.FLpartition_WSchV1984_SM_upHalf() else AixLib.DataBase.Walls.WSchV1984.Floor.FLpartition_WSchV1984_L_upHalf() annotation(Dialog(tab = "Types"));
      // Ceiling  type
      parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_CE = if Floor == 1 or Floor == 2 then if TIR == 1 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_SM_loHalf() else AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_L_loHalf() else if TIR == 2 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.EnEV2002.Ceiling.CEpartition_EnEV2002_SM_loHalf() else AixLib.DataBase.Walls.EnEV2002.Ceiling.CEpartition_EnEV2002_L_loHalf() else if TIR == 3 then if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.WSchV1995.Ceiling.CEpartition_WSchV1995_SM_loHalf() else AixLib.DataBase.Walls.WSchV1995.Ceiling.CEpartition_WSchV1995_L_loHalf() else if TMC == 1 or TMC == 2 then AixLib.DataBase.Walls.WSchV1984.Ceiling.CEpartition_WSchV1984_SM_loHalf() else AixLib.DataBase.Walls.WSchV1984.Ceiling.CEpartition_WSchV1984_L_loHalf() else if TIR == 1 then AixLib.DataBase.Walls.EnEV2009.Ceiling.CEattic_EnEV2009_SML_loHalf() else if TIR == 2 then AixLib.DataBase.Walls.EnEV2002.Ceiling.CEattic_EnEV2002_SML_loHalf() else if TIR == 3 then AixLib.DataBase.Walls.WSchV1995.Ceiling.CEattic_WSchV1995_SML_loHalf() else AixLib.DataBase.Walls.WSchV1984.Ceiling.CEattic_WSchV1984_SML_loHalf() annotation(Dialog(tab = "Types"));
      //Window type
      parameter AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple Type_Win = if TIR == 1 then AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009() else if TIR == 2 then AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2002() else if TIR == 3 then AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1995() else AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1984() annotation(Dialog(tab = "Types"));
      parameter Modelica.Units.SI.Volume room_V=4.20*4.645*2.46;
    equation
      connect(outsideWall.SolarRadiationPort, SolarRadiation_SE) annotation(Line(points = {{62, 87.6}, {62, 100}, {-66, 100}, {-66, 134}}, color = {255, 128, 0}));
      connect(outsideWall.WindSpeedPort, WindSpeedPort) annotation(Line(points = {{48.8, 84.6}, {48.8, 100}, {-86, 100}, {-86, 30}, {-160, 30}}, color = {0, 0, 127}));
      connect(Wall_Ceiling.port_outside, thermCeiling) annotation(Line(points={{104,
              72.1},{104,84},{134,84},{134,-56},{-86,-56},{-86,-110},{-150,-110}},                                                                                      color = {191, 0, 0}));
      connect(Wall_Floor.port_outside, thermFloor) annotation(Line(points={{104,
              29.9},{104,4},{134,4},{134,-56},{-86,-56},{-86,-140},{-150,-140}},                                                                                  color = {191, 0, 0}));
      connect(Wall_Children.port_outside, thermChildren) annotation(Line(points={{82.35,
              14},{104,14},{104,4},{134,4},{134,-80},{-150,-80}},                                                                                        color = {191, 0, 0}));
      connect(Wall_Corridor.port_outside, thermCorridor) annotation(Line(points={{19,
              -48.25},{19,-48.25},{19,-56},{-86,-56},{-86,-50},{-150,-50}},                                                                                     color = {191, 0, 0}));
      connect(Wall_Bedroom.port_outside, thermBedroom) annotation(Line(points={{-45,
              -48.2},{-45,-56},{-86,-56},{-86,-20},{-150,-20}},                                                                                  color = {191, 0, 0}));
      connect(Wall_Neighbour.port_outside, thermNeighbour) annotation(Line(points = {{-80.3, 15}, {-86, 15}, {-86, 10}, {-150, 10}}, color = {191, 0, 0}));
      connect(infiltrationRate.port_a, thermOutside) annotation(Line(points = {{-72, -71}, {-86, -71}, {-86, 130}, {-150, 130}}, color = {191, 0, 0}));
      connect(ThermRoom, ThermRoom) annotation(Line(points = {{-2, 14}, {-7, 14}, {-7, 14}, {-2, 14}}, color = {191, 0, 0}));
      connect(thermStar_Demux.portRad, StarInside1) annotation (Line(
          points={{14,-9},{14,3.2},{26,3.2},{26,14}},
          color={95,95,95},
          pattern=LinePattern.Solid));
      connect(Wall_Children.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{68,14},
              {54,14},{54,-32},{34,-32},{34,-14}},                                                                                                             color={191,0,0}));
      connect(Wall_Corridor.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{19,-38},
              {19,-32},{34,-32},{34,-14}},                                                                                                              color={191,0,0}));
      connect(Wall_Bedroom.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-45,-40},
              {-45,-32},{34,-32},{34,-14}},                                                                                                              color={191,0,0}));
      connect(Wall_Neighbour.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-68,15},
              {-56,15},{-56,-32},{34,-32},{34,-14}},                                                                                                               color={191,0,0}));
      connect(outsideWall.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{-4,60},
              {-4,48},{-56,48},{-56,-32},{34,-32},{34,-14}},                                                                                                           color={191,0,0}));
      connect(Wall_Ceiling.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{104,68},
              {104,58},{54,58},{54,-32},{34,-32},{34,-14}},                                                                                                             color={191,0,0}));
      connect(Wall_Floor.thermStarComb_inside, thermStar_Demux.portConvRadComb) annotation (Line(points={{104,34},
              {104,58},{54,58},{54,-32},{34,-32},{34,-14}},                                                                                                           color={191,0,0}));
      connect(thermStar_Demux.portConv, ThermRoom) annotation (Line(points={{14,-19},
              {14,-20},{-20,-20},{-20,14},{-2,14}},                                                                              color={191,0,0}));
      connect(airload.port, infiltrationRate.port_b) annotation(Line(points={{-38,0},
              {-20,0},{-20,-71},{-46,-71}},                                                                                 color = {191, 0, 0}));
      connect(NaturalVentilation.ventRate, AirExchangePort) annotation (Line(points=
             {{-70.7,-107.32},{-86,-107.32},{-86,70},{-160,70}}, color={0,0,127}));
      connect(NaturalVentilation.port_a, thermOutside) annotation(Line(points = {{-72, -99}, {-86, -99}, {-86, 130}, {-150, 130}}, color = {191, 0, 0}));
      connect(airload.port, ThermRoom) annotation(Line(points={{-38,0},{-20,0},{-20,14},{-2,14}},          color = {191, 0, 0}));
      connect(NaturalVentilation.port_b, airload.port) annotation(Line(points={{-46,-99},{-20,-99},{-20,0},{-38,0}},          color = {191, 0, 0}));
      connect(outsideWall.port_outside, thermOutside) annotation(Line(points = {{-4, 84.6}, {-4, 100}, {-86, 100}, {-86, 130}, {-150, 130}}, color = {191, 0, 0}));
      annotation(Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-170, -150}, {170, 150}})),           Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-170, -150}, {170, 150}}), graphics={  Rectangle(extent = {{-62, 60}, {112, -92}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
                fillPattern =                                                                                                   FillPattern.Forward), Rectangle(extent = {{38, 72}, {60, 52}}, lineColor = {0, 0, 0}, fillColor = {85, 255, 255},
                fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{40, 70}, {58, 54}}, lineColor = {0, 0, 0}, fillColor = {170, 213, 255},
                fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{-56, -14}, {104, -32}}, lineColor = {0, 0, 0}, fillColor = {255, 0, 0},
                fillPattern =                                                                                                   FillPattern.Forward, textString = "Livingroom"), Text(extent = {{42, -98}, {92, -114}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   1, fillColor = {255, 255, 255},
                fillPattern =                                                                                                   FillPattern.Solid, textString = "Corridor"), Rectangle(extent = {{92, -88}, {112, -118}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   1, fillColor = {127, 0, 0},
                fillPattern =                                                                                                   FillPattern.Forward), Ellipse(extent = {{94, -100}, {96, -102}}, lineColor = {0, 0, 0}, pattern=LinePattern.None,
                lineThickness =                                                                                                   1,
                fillPattern =                                                                                                   FillPattern.Sphere, fillColor = {255, 255, 0}), Rectangle(extent = {{-62, 84}, {-42, 54}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   1, fillColor = {127, 0, 0},
                fillPattern =                                                                                                   FillPattern.Forward), Ellipse(extent = {{-44, 68}, {-46, 66}}, lineColor = {0, 0, 0}, pattern = LinePattern.Solid,
                lineThickness =                                                                                                   1,
                fillPattern =                                                                                                   FillPattern.Sphere, fillColor = {255, 255, 0}), Rectangle(extent = {{-160, -130}, {-140, -150}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5), Rectangle(extent = {{-160, -100}, {-140, -120}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5), Rectangle(extent = {{-160, -70}, {-140, -90}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5), Rectangle(extent = {{-160, -10}, {-140, -30}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5), Rectangle(extent = {{-160, 20}, {-140, 0}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5), Rectangle(extent = {{-160, 140}, {-140, 120}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5), Rectangle(extent = {{-160, -40}, {-140, -60}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5), Rectangle(extent = {{-160, 90}, {-140, 28}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   0.5), Line(points = {{44, 62}, {50, 68}}, color = {255, 255, 255}, thickness = 1), Line(points = {{44, 58}, {54, 68}}, color = {255, 255, 255}, thickness = 1), Line(points = {{48, 58}, {54, 64}}, color = {255, 255, 255}, thickness = 1), Text(extent = {{50, 78}, {100, 62}}, lineColor = {0, 0, 0},
                lineThickness =                                                                                                   1, fillColor = {255, 255, 255},
                fillPattern =                                                                                                   FillPattern.Solid, textString = "OW")}), Documentation(revisions = "<html><ul>
  <li>
    <i>April 18, 2014</i> by Ana Constantin:<br/>
    Added documentation
  </li>
  <li>
    <i>August 16, 2011</i> by Ana Constantin:<br/>
    Implemented
  </li>
</ul>
</html>",     info = "<html>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Model for the livingroom.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The following figure presents the room's layout:
</p>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/Building/HighOrder/VoWo_Livingroom.png\"
  alt=\"Room layout\">
</p>
</html>"));
    end Livingroom_VoWo;
    annotation(Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Package for the rooms in the appartment.
</p>
</html>"));
  end OneAppartment;
  annotation(Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Package for rooms for an appartment in a multi family dwelling.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The multi-family dwelling is based on an existing building consisting
  of several identical apartments which is part of a larger national
  research project [1].
</p>
<p>
  The dimensions and layout of the rooms are fixed, with an apartment
  having a living area of 70 m2 and consisting of a living room, two
  bedrooms, a kitchen and a bathroom.
</p>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/Building/HighOrder/MFD_FloorPlan_En.PNG\"
  alt=\"MFD_FloorPlan_En\">
</p>
<p>
  <br/>
  <br/>
  <b><span style=\"color: #008000\">References</span></b>
</p>
<p>
  [1] Cali, D., Streblow, R., Müller, D., Osterhage, T. Holistic
  Renovation and Monitoring of Residential Buildings in <i>Proceedings
  of Rethink, renew, restart: ECEE 2013 summer study</i>, 2013.
</p>
</html>"));
end MFD;
