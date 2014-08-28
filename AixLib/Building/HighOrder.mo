within AixLib.Building;
package HighOrder "Standard house models"
            extends Modelica.Icons.Package;

  package Rooms
              extends Modelica.Icons.Package;

    package OFD "One Family Dwelling"
                extends Modelica.Icons.Package;

      model Ow2IwL1IwS1Gr1Uf1
        "2 outer walls, 1 inner wall load, 1 inner wall simple, 1 floor towards ground, 1 ceiling towards upper floor"
        import AixLib;

        ///////// construction parameters
        parameter Integer TMC =  1 "Themal Mass Class"
          annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice=1 "S", choice = 2 "M", choice = 3 "L", radioButtons = true));
        parameter Integer TIR = 1 "Thermal Insulation Regulation"
         annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice=1
              "EnEV_2009",                                                                                                    choice = 2
              "EnEV_2002",                                                                                                    choice = 3
              "WSchV_1995",  choice = 4 "WSchV_1984",                                                                          radioButtons = true));

        parameter Boolean withFloorHeating = false
          "If true, that floor has different connectors" annotation (Dialog(group = "Construction parameters"), choices(checkBox=true));

        //Initial temperatures
        parameter Modelica.SIunits.Temperature T0_air=295.15 "Air"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_OW1=295.15 "OW1"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_OW2=295.15 "OW2"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_IW1=295.15 "IW1"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_IW2=295.15 "IW2"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_CE=295.13 "Ceiling"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_FL=295.13 "Floor"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));

       //////////room geometry
       parameter Modelica.SIunits.Length room_length=2 "length " annotation (Dialog(group = "Dimensions", descriptionLabel = true));
       parameter Modelica.SIunits.Length room_width=2 "width" annotation (Dialog(group = "Dimensions", descriptionLabel = true));
       parameter Modelica.SIunits.Height room_height=2 "height" annotation (Dialog(group = "Dimensions", descriptionLabel = true));

       // Outer wall properties
       parameter Real solar_absorptance_OW=0.25 "Solar absoptance outer walls "
                                                                               annotation (Dialog(group = "Outer wall properties", descriptionLabel = true));
       parameter Modelica.SIunits.Temperature T_Ground=278.15
          "Ground temperature"                                   annotation(Dialog(group="Outer wall properties", descriptionLabel = true));
       parameter Integer ModelConvOW =  1 "Heat Convection Model"
         annotation(Dialog(group = "Outer wall properties", compact = true, descriptionLabel = true), choices(choice = 1
              "DIN 6946",                                                                                                    choice = 2
              "ASHRAE Fundamentals",                                                                                                    choice = 3
              "Custom alpha",                                                                                                    radioButtons = true));

       // Windows and Doors
       parameter Boolean withWindow1 = true "Window 1" annotation (Dialog(group = "Windows and Doors", joinNext = true, descriptionLabel = true), choices(checkBox=true));
       parameter Modelica.SIunits.Area windowarea_OW1=0 "Window area " annotation (Dialog(group = "Windows and Doors", descriptionLabel = true, enable = withWindow1));
       parameter Boolean withWindow2 = true "Window 2 " annotation (Dialog(group = "Windows and Doors", joinNext = true, descriptionLabel = true), choices(checkBox=true));
       parameter Modelica.SIunits.Area windowarea_OW2=0 "Window area" annotation (Dialog(group = "Windows and Doors", naturalWidth = 10, descriptionLabel = true, enable = withWindow2));
       parameter Boolean withDoor1 = true "Door 1" annotation (Dialog(group = "Windows and Doors", joinNext = true, descriptionLabel = true), choices(checkBox=true));
       parameter Modelica.SIunits.Length door_width_OD1=0 "width " annotation (Dialog(group = "Windows and Doors", joinNext = true, descriptionLabel = true, enable = withDoor1));
       parameter Modelica.SIunits.Length door_height_OD1=0 "height " annotation (Dialog(group = "Windows and Doors", descriptionLabel = true, enable = withDoor1));
       parameter Boolean withDoor2 = true "Door 2" annotation (Dialog( group = "Windows and Doors", joinNext = true, descriptionLabel = true), choices(checkBox=true));
       parameter Modelica.SIunits.Length door_width_OD2=0 "width " annotation (Dialog(group = "Windows and Doors", joinNext = true, descriptionLabel = true, enable = withDoor2));
       parameter Modelica.SIunits.Length door_height_OD2=0 "height " annotation (Dialog(group = "Windows and Doors",descriptionLabel = true, enable = withDoor2));

       // Dynamic Ventilation
        parameter Boolean withDynamicVentilation = false "Dynamic ventilation" annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true), choices(checkBox=true));
        parameter Modelica.SIunits.Temperature HeatingLimit = 288.15
          "Outside temperature at which the heating activates" annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true,  enable = if withDynamicVentilation then true else false));
        parameter Real Max_VR = 10 "Maximal ventilation rate" annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true,  enable = if withDynamicVentilation then true else false));
        parameter Modelica.SIunits.TemperatureDifference Diff_toTempset = 2
          "Difference to set temperature" annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true,  enable = if withDynamicVentilation then true else false));
        parameter Modelica.SIunits.Temperature Tset = 295.15 "Tset"
                 annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true,  enable = if withDynamicVentilation then true else false));

       //Door properties
      protected
       parameter Real U_door_OD1=if TIR == 1 then 1.8 else  2.9 "U-value"  annotation (Dialog(group = "Windows and Doors", joinNext = true, descriptionLabel = true, enable = withDoor1));
       parameter Real eps_door_OD1=0.95 "eps" annotation (Dialog(group = "Windows and Doors", descriptionLabel = true, enable = withDoor1));
       parameter Real U_door_OD2=if TIR == 1 then 1.8 else  2.9 "U-value" annotation (Dialog(group = "Windows and Doors", joinNext = true, descriptionLabel = true, enable = withDoor2));
       parameter Real eps_door_OD2=0.95 "eps" annotation (Dialog(group = "Windows and Doors", descriptionLabel = true, enable = withDoor2));

        // Infiltration rate
        parameter Real n50(unit="h-1")=
        if (TIR == 1 or TIR ==2) then 3 else
        if TIR == 3 then 4 else 6
          "Air exchange rate at 50 Pa pressure difference" annotation (Dialog(tab = "Infiltration"));
        parameter Real e=0.03 "Coefficient of windshield" annotation (Dialog(tab = "Infiltration"));
        parameter Real eps=1.0 "Coefficient of height" annotation (Dialog(tab = "Infiltration"));

        // Outer wall type
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_OW=if TIR
             == 1 then if TMC == 1 then
            AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S() else if TMC == 2
             then AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_M() else
            AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_L() else if TIR == 2
             then if TMC == 1 then
            AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_S() else if TMC == 2
             then AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_M() else
            AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_L() else if TIR == 3
             then if TMC == 1 then
            AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_S() else if TMC ==
            2 then AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_M() else
            AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_L() else if TMC ==
            1 then AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_S() else if
            TMC == 2 then AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_M()
             else AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_L()
          annotation (Dialog(tab="Types"));

        //Inner wall Types
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_IWsimple=
            if TIR == 1 then if TMC == 1 then
            AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_S_half() else
            if TMC == 2 then
            AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_M_half() else
            AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_L_half() else
            if TIR == 2 then if TMC == 1 then
            AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_S_half() else
            if TMC == 2 then
            AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_M_half() else
            AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_L_half() else
            if TIR == 3 then if TMC == 1 then
            AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_S_half()
             else if TMC == 2 then
            AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_M_half()
             else AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_L_half()
             else if TMC == 1 then
            AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_S_half()
             else if TMC == 2 then
            AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_M_half()
             else AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_L_half()
          annotation (Dialog(tab="Types"));

        parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_IWload=if
            TIR == 1 then if TMC == 1 then
            AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half() else if
            TMC == 2 then
            AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_M_half() else
            AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_L_half() else if
            TIR == 2 then if TMC == 1 then
            AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_S_half() else if
            TMC == 2 then
            AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_M_half() else
            AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_L_half() else if
            TIR == 3 then if TMC == 1 then
            AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_S_half() else
            if TMC == 2 then
            AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_M_half() else
            AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_L_half() else
            if TMC == 1 then
            AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_S_half() else
            if TMC == 2 then
            AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_M_half() else
            AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_L_half()
          annotation (Dialog(tab="Types"));

         // Floor to ground type
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_FL=if TIR
             == 1 then
            AixLib.DataBase.Walls.EnEV2009.Floor.FLground_EnEV2009_SML() else
            if TIR == 2 then
            AixLib.DataBase.Walls.EnEV2002.Floor.FLground_EnEV2002_SML() else
            if TIR == 3 then
            AixLib.DataBase.Walls.WSchV1995.Floor.FLground_WSchV1995_SML()
             else AixLib.DataBase.Walls.WSchV1984.Floor.FLground_WSchV1984_SML()
          annotation (Dialog(tab="Types"));

        // Ceiling to upper floor type
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_CE=if TIR
             == 1 then if (TMC == 1 or TMC == 2) then
            AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_SM_loHalf()
             else
            AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_L_loHalf()
             else if TIR == 2 then if (TMC == 1 or TMC == 2) then
            AixLib.DataBase.Walls.EnEV2002.Ceiling.CEpartition_EnEV2002_SM_loHalf()
             else
            AixLib.DataBase.Walls.EnEV2002.Ceiling.CEpartition_EnEV2002_L_loHalf()
             else if TIR == 3 then if (TMC == 1 or TMC == 2) then
            AixLib.DataBase.Walls.WSchV1995.Ceiling.CEpartition_WSchV1995_SM_loHalf()
             else
            AixLib.DataBase.Walls.WSchV1995.Ceiling.CEpartition_WSchV1995_L_loHalf()
             else if (TMC == 1 or TMC == 2) then
            AixLib.DataBase.Walls.WSchV1984.Ceiling.CEpartition_WSchV1984_SM_loHalf()
             else
            AixLib.DataBase.Walls.WSchV1984.Ceiling.CEpartition_WSchV1984_L_loHalf()
          annotation (Dialog(tab="Types"));

         //Window type
        parameter
          AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple
          Type_Win=if TIR == 1 then
            AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009() else
            if TIR == 2 then
            AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2002() else
            if TIR == 3 then
            AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1995() else
            AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1984()
          annotation (Dialog(tab="Types"));

          parameter Modelica.SIunits.Volume room_V=room_length*room_width*room_height;

      public
        AixLib.Building.Components.Walls.Wall outside_wall1(
          solar_absorptance=solar_absorptance_OW,
          windowarea=windowarea_OW1,
          T0=T0_OW1,
          door_height=door_height_OD1,
          door_width=door_width_OD1,
          wall_length=room_length,
          wall_height=room_height,
          withWindow=withWindow1,
          withDoor=withDoor1,
          WallType=Type_OW,
          Model=ModelConvOW,
          WindowType=Type_Win,
          withSunblind=false,
          U_door=U_door_OD1,
          eps_door=eps_door_OD1) annotation (Placement(transformation(
                extent={{-64,-28},{-54,36}}, rotation=0)));
        AixLib.Building.Components.Walls.Wall outside_wall2(
          solar_absorptance=solar_absorptance_OW,
          windowarea=windowarea_OW2,
          T0=T0_OW2,
          door_height=door_height_OD2,
          door_width=door_width_OD2,
          wall_length=room_width,
          wall_height=room_height,
          withWindow=withWindow2,
          withDoor=withDoor2,
          WallType=Type_OW,
          Model=ModelConvOW,
          WindowType=Type_Win,
          U_door=U_door_OD2,
          eps_door=eps_door_OD2) annotation (Placement(transformation(
              origin={19,57},
              extent={{-5.00018,-29},{5.00003,29}},
              rotation=270)));
        AixLib.Building.Components.Walls.Wall inside_wall1(
          T0=T0_IW1,
          outside=false,
          wall_length=room_length,
          wall_height=room_height,
          withWindow=false,
          withDoor=false,
          WallType=Type_IWload) annotation (Placement(transformation(
              origin={58,5},
              extent={{-6,-35},{6,35}},
              rotation=180)));
        AixLib.Building.Components.Walls.Wall inside_wall2(
          T0=T0_IW2,
          outside=false,
          WallType=Type_IWsimple,
          wall_length=room_width,
          wall_height=room_height,
          withWindow=false,
          withDoor=false) annotation (Placement(transformation(
              origin={16,-60},
              extent={{-4,-24},{4,24}},
              rotation=90)));
        AixLib.Building.Components.DryAir.Airload airload(V=room_V, T(start=
               T0_air)) annotation (Placement(transformation(extent={{0,-20},
                  {20,0}}, rotation=0)));
        AixLib.Building.Components.Walls.Wall Ceiling(
          T0=T0_CE,
          outside=false,
          WallType=Type_CE,
          wall_length=room_length,
          wall_height=room_width,
          withWindow=false,
          withDoor=false,
          ISOrientation=3) annotation (Placement(transformation(
              origin={-30,59},
              extent={{2.99997,-16},{-3.00002,16}},
              rotation=90)));
        AixLib.Building.Components.Walls.Wall floor(
          T0=T0_FL,
          WallType=Type_FL,
          wall_length=room_length,
          wall_height=room_width,
          withWindow=false,
          outside=false,
          withDoor=false,
          ISOrientation=2) if withFloorHeating == false annotation (
            Placement(transformation(
              origin={-29,-53},
              extent={{-3.00001,-15},{2.99998,15}},
              rotation=90)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall2
          annotation (Placement(transformation(extent={{20,-100},{40,-80}},
                rotation=0)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall1
          annotation (Placement(transformation(extent={{80,0},{100,20}}, rotation=0)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermOutside
          annotation (Placement(transformation(extent={{-100,80},{-80,100}},
                rotation=0)));
        Modelica.Blocks.Interfaces.RealInput WindSpeedPort
          annotation (Placement(transformation(extent={{-109.5,-50},{-89.5,-30}},
                rotation=0)));
        Utilities.Interfaces.SolarRad_in SolarRadiationPort_OW1 annotation (
           Placement(transformation(extent={{-109.5,20},{-89.5,40}},
                rotation=0)));
        Utilities.Interfaces.SolarRad_in SolarRadiationPort_OW2 annotation (
           Placement(transformation(
              origin={50.5,99},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling
          annotation (Placement(transformation(extent={{80,60},{100,80}}, rotation=
                  0)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermRoom annotation (
            Placement(transformation(extent={{-32,10},{-12,30}}),
              iconTransformation(extent={{-32,10},{-12,30}})));
        Modelica.Blocks.Interfaces.RealInput AirExchangePort annotation (
            Placement(transformation(
              extent={{-13,-13},{13,13}},
              rotation=270,
              origin={-20,100}), iconTransformation(
              extent={{-10.5,-10.5},{10.5,10.5}},
              rotation=270,
              origin={-20.5,98.5})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature Ground
          annotation (Placement(transformation(extent={{0,-100},{-20,-80}})));
        Modelica.Blocks.Sources.Constant GroundTemperature(k=T_Ground)
          annotation (Placement(transformation(extent={{-62,-100},{-42,-80}})));
        Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor Tair
          annotation (Placement(transformation(extent={{24,-20},{38,-6}})));
        AixLib.Building.Components.DryAir.InfiltrationRate_DIN12831
          infiltrationRate(
          room_V=room_V,
          n50=n50,
          e=e,
          eps=eps) annotation (Placement(transformation(extent={{-68,44},{-50,
                  52}})));
        AixLib.Building.Components.DryAir.DynamicVentilation
          dynamicVentilation(
          HeatingLimit=HeatingLimit,
          Max_VR=Max_VR,
          Diff_toTempset=Diff_toTempset,
          Tset=Tset) if withDynamicVentilation annotation (Placement(
              transformation(extent={{-68,-66},{-46,-54}})));
        Utilities.Interfaces.Adaptors.HeatStarToComb thermStar_Demux
          annotation (Placement(transformation(
              extent={{-10,8},{10,-8}},
              rotation=90,
              origin={-20,-26})));
        Utilities.Interfaces.Star starRoom annotation (Placement(
              transformation(extent={{10,10},{30,30}}), iconTransformation(
                extent={{10,10},{30,30}})));
        AixLib.Building.Components.DryAir.VarAirExchange NaturalVentilation(
            V=room_V) annotation (Placement(transformation(extent={{-68,-50},
                  {-48,-30}})));
        AixLib.Building.Components.Walls.BaseClasses.SimpleNLayer floor_FH(
          h=room_width,
          l=room_length,
          n=Type_FL.n,
          d=Type_FL.d,
          rho=Type_FL.rho,
          lambda=Type_FL.lambda,
          c=Type_FL.c,
          T0=T0_FL) if withFloorHeating
          "floor component if using Floor heating" annotation (Placement(
              transformation(
              origin={-24,-75},
              extent={{-3.00007,16},{3,-16}},
              rotation=90)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor if
                                               withFloorHeating
          "thermal connector for floor heating" annotation (Placement(
              transformation(extent={{-24,-68},{-14,-58}}), iconTransformation(
                extent={{-32,-34},{-12,-14}})));
      equation

          // Connect equations for dynamic ventilation
          if withDynamicVentilation then
          connect(thermOutside, dynamicVentilation.port_outside);
          connect(dynamicVentilation.port_inside, airload.port);
          end if;

          //Connect floor for cases with or without floor heating
          if withFloorHeating then
          connect(floor_FH.port_a, Ground.port) annotation (Line(
              points={{-25.6,-77.7001},{-25.6,-90},{-20,-90}},
              color={191,0,0},
              smooth=Smooth.None));
            connect(floor_FH.port_b, thermFloor) annotation (Line(
            points={{-25.6,-72.3},{-25.6,-63},{-19,-63}},
            color={191,0,0},
            smooth=Smooth.None));
          else
          connect(floor.port_outside, Ground.port) annotation (Line(
              points={{-29,-56.15},{-29,-90},{-20,-90}},
              color={191,0,0},
              smooth=Smooth.None,
              pattern=LinePattern.Dash));
          connect(floor.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{-29,-50},{-29,-40},{-20.1,-40},{-20.1,-35.4}},
              color={191,0,0},
              smooth=Smooth.None,
              pattern=LinePattern.Dash));
          end if;

        connect(outside_wall1.WindSpeedPort,WindSpeedPort)   annotation (Line(
              points={{-64.25,27.4667},{-72,27.4667},{-80,27.4667},{-80,-40},{
                -99.5,-40}},                                color={0,0,127}));
        connect(thermInsideWall2,thermInsideWall2)  annotation (Line(
            points={{30,-90},{30,-90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(inside_wall1.port_outside, thermInsideWall1) annotation (Line(
            points={{64.3,5},{90,5},{90,10}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(outside_wall2.WindSpeedPort,WindSpeedPort)  annotation (Line(
            points={{40.2667,62.2502},{40.2667,68},{40.2667,70},{-80,70},{-80,
                -40},{-99.5,-40}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(GroundTemperature.y, Ground.T) annotation (Line(
            points={{-41,-90},{2,-90}},
            color={0,0,127},
            smooth=Smooth.None));

        connect(infiltrationRate.port_a, thermOutside) annotation (Line(
            points={{-68,48},{-80,48},{-80,80},{-90,80},{-90,90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(outside_wall1.port_outside, thermOutside) annotation (Line(
            points={{-64.25,4},{-80,4},{-80,80},{-90,80},{-90,90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(thermRoom, thermRoom) annotation (Line(
            points={{-22,20},{-22,20}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(starRoom, thermStar_Demux.star)
                                            annotation (Line(
            points={{20,20},{20,4},{-14.2,4},{-14.2,-15.6}},
            color={95,95,95},
            pattern=LinePattern.None,
            smooth=Smooth.None));
        connect(outside_wall2.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{19,52},{19,52},{19,40},{-40,40},{-40,-40},{-20.1,-40},{
                -20.1,-35.4}},
            color={191,0,0},
            smooth=Smooth.None));

        connect(outside_wall2.SolarRadiationPort, SolarRadiationPort_OW2)
          annotation (Line(
            points={{45.5833,63.5002},{45.5833,80.7501},{50.5,80.7501},{50.5,99}},
            color={255,128,0},
            smooth=Smooth.None));
        connect(SolarRadiationPort_OW1, outside_wall1.SolarRadiationPort)
          annotation (Line(
            points={{-99.5,30},{-80,30},{-80,33.3333},{-65.5,33.3333}},
            color={255,128,0},
            smooth=Smooth.None));
        connect(thermOutside, thermOutside) annotation (Line(
            points={{-90,90},{-90,90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(inside_wall2.port_outside, thermInsideWall2) annotation (Line(
            points={{16,-64.2},{16,-75.45},{30,-75.45},{30,-90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(inside_wall1.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{52,5},{50,6},{40,6},{40,-40},{-20.1,-40},{-20.1,-35.4}},
            color={191,0,0},
            smooth=Smooth.None));

        connect(Ceiling.port_outside, thermCeiling) annotation (Line(
            points={{-30,62.15},{-30,70},{90,70}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(thermStar_Demux.therm, thermRoom) annotation (Line(
            points={{-25.1,-15.9},{-25.1,1.05},{-22,1.05},{-22,20}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(thermStar_Demux.therm, airload.port) annotation (Line(
            points={{-25.1,-15.9},{-25.1,-12},{1,-12}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(outside_wall2.port_outside, thermOutside) annotation (Line(
            points={{19,62.2502},{19,70},{-80,70},{-80,80},{-90,80},{-90,90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(infiltrationRate.port_b, airload.port) annotation (Line(
            points={{-50,48},{-40,48},{-40,-40},{-6,-40},{-6,-12},{1,-12}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(Tair.port, airload.port) annotation (Line(
            points={{24,-13},{24,-40},{-6,-40},{-6,-12},{1,-12}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(Ceiling.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{-30,56},{-30,40},{-40,40},{-40,-40},{-20.1,-40},{-20.1,
                -35.4}},
            color={191,0,0},
            smooth=Smooth.None));

        connect(inside_wall2.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{16,-56},{16,-40},{-20.1,-40},{-20.1,-35.4}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(outside_wall1.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{-54,4},{-40,4},{-40,-40},{-20.1,-40},{-20.1,-35.4}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(AirExchangePort, NaturalVentilation.InPort1) annotation (Line(
            points={{-20,100},{-20,70},{-80,70},{-80,-46.4},{-67,-46.4}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(thermOutside,NaturalVentilation.port_a)  annotation (Line(
            points={{-90,90},{-80,90},{-80,-40},{-68,-40}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(NaturalVentilation.port_b, airload.port) annotation (Line(
            points={{-48,-40},{-6,-40},{-6,-12},{1,-12}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(floor_FH.port_a, Ground.port) annotation (Line(
            points={{-25.6,-77.7001},{-25.6,-90},{-20,-90}},
            color={191,0,0},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        connect(floor_FH.port_b, thermFloor) annotation (Line(
            points={{-25.6,-72.3},{-25.6,-63},{-19,-63}},
            color={191,0,0},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
       annotation (__Dymola_Images(Parameters(source="AixLib/Images/House/2OW_1IWl_1IWs_1Gr_Pa.png")),
                    Icon(coordinateSystem(preserveAspectRatio=false, extent={{
                  -100,-100},{100,100}}),
                         graphics={
              Rectangle(
                extent={{-80,80},{80,60}},
                lineColor={0,0,0},
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{0,80},{-50,60}},
                lineColor={0,0,0},
                fillColor={170,213,255},
                fillPattern=FillPattern.Solid,
                visible = withWindow2),
              Rectangle(
                extent={{6,64},{-6,-64}},
                lineColor={0,0,0},
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid,
                origin={74,-4},
                rotation=360),
              Rectangle(
                extent={{-60,-68},{80,-80}},
                lineColor={0,0,0},
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-80,60},{-60,-80}},
                lineColor={0,0,0},
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-80,50},{-60,0}},
                lineColor={0,0,0},
                fillColor={170,213,255},
                fillPattern=FillPattern.Solid,
                visible=withWindow1),
              Rectangle(
                extent={{-60,60},{68,-68}},
                lineColor={0,0,0},
                fillColor={47,102,173},
                fillPattern=FillPattern.Solid),
              Line(
                points={{38,46},{68,46}},
                color={255,255,255},
                smooth=Smooth.None),
              Text(
                extent={{64,52},{-56,40}},
                lineColor={255,255,255},
                textString="width"),
              Line(
                points={{-46,-38},{-46,-68}},
                color={255,255,255},
                smooth=Smooth.None),
              Text(
                extent={{3,-6},{-117,6}},
                lineColor={255,255,255},
                origin={-46,53},
                rotation=90,
                textString="length"),
              Rectangle(
                extent={{-80,-20},{-60,-40}},
                fillColor={127,127,0},
                fillPattern=FillPattern.Solid,
                lineColor={0,0,0},
                visible=withDoor1),
              Rectangle(
                extent={{20,80},{40,60}},
                lineColor={0,0,0},
                fillColor={127,127,0},
                fillPattern=FillPattern.Solid,
                visible=withDoor2),
              Text(
                extent={{-50,76},{0,64}},
                lineColor={255,255,255},
                fillColor={255,85,85},
                fillPattern=FillPattern.Solid,
                visible = withWindow2,
                textString="Win2",
                lineThickness=0.5),
              Text(
                extent={{-25,6},{25,-6}},
                lineColor={255,255,255},
                fillColor={255,85,85},
                fillPattern=FillPattern.Solid,
                origin={-70,25},
                rotation=90,
                visible = withWindow1,
                textString="Win1"),
              Text(
                extent={{20,74},{40,66}},
                lineColor={255,255,255},
                fillColor={255,170,170},
                fillPattern=FillPattern.Solid,
                visible = withDoor2,
                textString="D2"),
              Text(
                extent={{-10,4},{10,-4}},
                lineColor={255,255,255},
                fillColor={255,85,85},
                fillPattern=FillPattern.Solid,
                origin={-70,-30},
                rotation=90,
                visible = withDoor1,
                textString="D1"),
              Line(
                points={{-60,46},{-30,46}},
                color={255,255,255},
                smooth=Smooth.None),
              Line(
                points={{-46,60},{-46,30}},
                color={255,255,255},
                smooth=Smooth.None)}),
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                  100}}),
                  graphics),
          Documentation(revisions="<html>
<p><ul>
<li><i>April 18, 2014</i> by Ana Constantin:<br/>Added documentation</li>
<li><i>July 7, 2011</i> by Ana Constantin:<br/>Implemented</li>
</ul></p>
</html>",     info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Model for a room with 2&nbsp;outer&nbsp;walls,&nbsp;1&nbsp;inner&nbsp;wall&nbsp;load,&nbsp;1&nbsp;inner&nbsp;wall&nbsp;simple,&nbsp;1&nbsp;floor&nbsp;towards&nbsp;ground,&nbsp;1&nbsp;ceiling&nbsp;towards&nbsp;upper&nbsp;floor.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The following figure presents the room&apos;s layout:</p>
<p><img src=\"modelica://AixLib/Images/House/2OW_1IWl_1IWs_1Gr_Pa.png\"/></p>
</html>"));
      end Ow2IwL1IwS1Gr1Uf1;

      model Ow2IwL2IwS1Gr1Uf1
        "2 outer walls, 2 inner walls load, 1 inner wall simple, 1 floor towards ground, 1 ceiling towards upper floor"
        import AixLib;

        ///////// construction parameters
        parameter Integer TMC =  1 "Themal Mass Class"
          annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice=1 "S", choice = 2 "M", choice = 3 "L", radioButtons = true));
        parameter Integer TIR = 1 "Thermal Insulation Regulation"
         annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice=1
              "EnEV_2009",                                                                                                    choice = 2
              "EnEV_2002",                                                                                                    choice = 3
              "WSchV_1995",  choice = 4 "WSchV_1984",                                                                          radioButtons = true));

        parameter Boolean withFloorHeating = false
          "If true, that floor has different connectors" annotation (Dialog(group = "Construction parameters"), choices(checkBox=true));

        parameter Modelica.SIunits.Temperature T0_air=295.15 "Air"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_OW1=295.15 "OW1"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_OW2=295.15 "OW2"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_IW1a=295.15 "IW1a"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_IW1b=295.15 "IW1b"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_IW2=295.15 "IW2"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_CE=295.13 "Ceiling"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_FL=295.13 "Floor"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));

       //////////room geometry
       parameter Modelica.SIunits.Length room_length=2 "length " annotation (Dialog(group = "Dimensions", descriptionLabel = true));
       parameter Modelica.SIunits.Length room_lengthb=1 "length_b " annotation (Dialog(group = "Dimensions", descriptionLabel = true));
       parameter Modelica.SIunits.Length room_width=2 "width " annotation (Dialog(group = "Dimensions", descriptionLabel = true));
       parameter Modelica.SIunits.Height room_height=2 "height" annotation (Dialog(group = "Dimensions", descriptionLabel = true));

       // Outer walls properties
       parameter Real solar_absorptance_OW=0.25 "Solar absoptance outer walls "
                                                                               annotation (Dialog(group = "Outer wall properties", descriptionLabel = true));
       parameter Modelica.SIunits.Temperature T_Ground=278.15
          "Ground Temperature"                                   annotation(Dialog(group="Outer wall properties", descriptionLabel = true));
       parameter Integer ModelConvOW =  1 "Heat Convection Model"
         annotation(Dialog(group = "Outer wall properties", compact = true, descriptionLabel = true), choices(choice = 1
              "DIN 6946",                                                                                                    choice = 2
              "ASHRAE Fundamentals",                                                                                                    choice = 3
              "Custom alpha",                                                                                                    radioButtons = true));

       // Windows and Doors
       parameter Boolean withWindow1 = true "Window 1" annotation (Dialog(group = "Windows and Doors", joinNext = true, descriptionLabel = true), choices(checkBox=true));
       parameter Modelica.SIunits.Area windowarea_OW1=0 "Window area " annotation (Dialog(group = "Windows and Doors", descriptionLabel = true, enable = withWindow1));
       parameter Boolean withWindow2 = true "Window 2 " annotation (Dialog(group = "Windows and Doors", joinNext = true, descriptionLabel = true), choices(checkBox=true));
       parameter Modelica.SIunits.Area windowarea_OW2=0 "Window area" annotation (Dialog(group = "Windows and Doors", naturalWidth = 10, descriptionLabel = true, enable = withWindow2));
       parameter Boolean withDoor1 = true "Door 1" annotation (Dialog(group = "Windows and Doors", joinNext = true, descriptionLabel = true), choices(checkBox=true));
       parameter Modelica.SIunits.Length door_width_OD1=0 "width " annotation (Dialog(group = "Windows and Doors", joinNext = true, descriptionLabel = true, enable = withDoor1));
       parameter Modelica.SIunits.Length door_height_OD1=0 "height " annotation (Dialog(group = "Windows and Doors", descriptionLabel = true, enable = withDoor1));
       parameter Boolean withDoor2 = true "Door 2" annotation (Dialog( group = "Windows and Doors", joinNext = true, descriptionLabel = true), choices(checkBox=true));
       parameter Modelica.SIunits.Length door_width_OD2=0 "width " annotation (Dialog(group = "Windows and Doors", joinNext = true, descriptionLabel = true, enable = withDoor2));
       parameter Modelica.SIunits.Length door_height_OD2=0 "height " annotation (Dialog(group = "Windows and Doors", descriptionLabel = true, enable = withDoor2));

      // Dynamic Ventilation
      parameter Boolean withDynamicVentilation = false "Dynamic ventilation" annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true), choices(checkBox=true));
      parameter Modelica.SIunits.Temperature HeatingLimit = 288.15
          "Outside temperature at which the heating activates"
                                                             annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true,  enable = if withDynamicVentilation then true else false));
      parameter Real Max_VR = 10 "Maximal ventilation rate" annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true,  enable = if withDynamicVentilation then true else false));
      parameter Modelica.SIunits.TemperatureDifference Diff_toTempset = 2
          "Difference to set temperature" annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true,  enable = if withDynamicVentilation then true else false));
      parameter Modelica.SIunits.Temperature Tset = 295.15 "Tset"
                 annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true,  enable = if withDynamicVentilation then true else false));

        //Door properties
      protected
       parameter Real U_door_OD1=if TIR == 1 then 1.8 else  2.9 "U-value"  annotation (Dialog(group = "Windows and Doors", joinNext = true, descriptionLabel = true, enable = withDoor1));
       parameter Real eps_door_OD1=0.95 "eps" annotation (Dialog(group = "Windows and Doors", descriptionLabel = true, enable = withDoor1));
       parameter Real U_door_OD2=if TIR == 1 then 1.8 else  2.9 "U-value" annotation (Dialog(group = "Windows and Doors", joinNext = true, descriptionLabel = true, enable = withDoor2));
       parameter Real eps_door_OD2=0.95 "eps" annotation (Dialog(group = "Windows and Doors", descriptionLabel = true, enable = withDoor2));

        // Infiltration rate
        parameter Real n50(unit="h-1")=
        if (TIR == 1 or TIR ==2) then 3 else
        if TIR == 3 then 4 else 6
          "Air exchange rate at 50 Pa pressure difference" annotation (Dialog(tab = "Infiltration"));
        parameter Real e=0.03 "Coefficient of windshield" annotation (Dialog(tab = "Infiltration"));
        parameter Real eps=1.0 "Coefficient of height" annotation (Dialog(tab = "Infiltration"));

        // Outer wall type
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_OW=if TIR
             == 1 then if TMC == 1 then
            AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S() else if TMC == 2
             then AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_M() else
            AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_L() else if TIR == 2
             then if TMC == 1 then
            AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_S() else if TMC == 2
             then AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_M() else
            AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_L() else if TIR == 3
             then if TMC == 1 then
            AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_S() else if TMC ==
            2 then AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_M() else
            AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_L() else if TMC ==
            1 then AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_S() else if
            TMC == 2 then AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_M()
             else AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_L()
          annotation (Dialog(tab="Types"));

        //Inner wall Types
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_IWsimple=
            if TIR == 1 then if TMC == 1 then
            AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_S_half() else
            if TMC == 2 then
            AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_M_half() else
            AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_L_half() else
            if TIR == 2 then if TMC == 1 then
            AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_S_half() else
            if TMC == 2 then
            AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_M_half() else
            AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_L_half() else
            if TIR == 3 then if TMC == 1 then
            AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_S_half()
             else if TMC == 2 then
            AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_M_half()
             else AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_L_half()
             else if TMC == 1 then
            AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_S_half()
             else if TMC == 2 then
            AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_M_half()
             else AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_L_half()
          annotation (Dialog(tab="Types"));

        parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_IWload=if
            TIR == 1 then if TMC == 1 then
            AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half() else if
            TMC == 2 then
            AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_M_half() else
            AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_L_half() else if
            TIR == 2 then if TMC == 1 then
            AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_S_half() else if
            TMC == 2 then
            AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_M_half() else
            AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_L_half() else if
            TIR == 3 then if TMC == 1 then
            AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_S_half() else
            if TMC == 2 then
            AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_M_half() else
            AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_L_half() else
            if TMC == 1 then
            AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_S_half() else
            if TMC == 2 then
            AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_M_half() else
            AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_L_half()
          annotation (Dialog(tab="Types"));

         // Floor to ground type
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_FL=if TIR
             == 1 then
            AixLib.DataBase.Walls.EnEV2009.Floor.FLground_EnEV2009_SML() else
            if TIR == 2 then
            AixLib.DataBase.Walls.EnEV2002.Floor.FLground_EnEV2002_SML() else
            if TIR == 3 then
            AixLib.DataBase.Walls.WSchV1995.Floor.FLground_WSchV1995_SML()
             else AixLib.DataBase.Walls.WSchV1984.Floor.FLground_WSchV1984_SML()
          annotation (Dialog(tab="Types"));

        // Ceiling to upper floor type
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_CE=if TIR
             == 1 then if (TMC == 1 or TMC == 2) then
            AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_SM_loHalf()
             else
            AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_L_loHalf()
             else if TIR == 2 then if (TMC == 1 or TMC == 2) then
            AixLib.DataBase.Walls.EnEV2002.Ceiling.CEpartition_EnEV2002_SM_loHalf()
             else
            AixLib.DataBase.Walls.EnEV2002.Ceiling.CEpartition_EnEV2002_L_loHalf()
             else if TIR == 3 then if (TMC == 1 or TMC == 2) then
            AixLib.DataBase.Walls.WSchV1995.Ceiling.CEpartition_WSchV1995_SM_loHalf()
             else
            AixLib.DataBase.Walls.WSchV1995.Ceiling.CEpartition_WSchV1995_L_loHalf()
             else if (TMC == 1 or TMC == 2) then
            AixLib.DataBase.Walls.WSchV1984.Ceiling.CEpartition_WSchV1984_SM_loHalf()
             else
            AixLib.DataBase.Walls.WSchV1984.Ceiling.CEpartition_WSchV1984_L_loHalf()
          annotation (Dialog(tab="Types"));

         //Window type
        parameter
          AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple
          Type_Win=if TIR == 1 then
            AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009() else
            if TIR == 2 then
            AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2002() else
            if TIR == 3 then
            AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1995() else
            AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1984()
          annotation (Dialog(tab="Types"));

          parameter Modelica.SIunits.Volume room_V=room_length*room_width*room_height;

      public
        AixLib.Building.Components.Walls.Wall outside_wall1(
          solar_absorptance=solar_absorptance_OW,
          windowarea=windowarea_OW1,
          T0=T0_OW1,
          door_height=door_height_OD1,
          door_width=door_width_OD1,
          wall_length=room_length,
          wall_height=room_height,
          withWindow=withWindow1,
          withDoor=withDoor1,
          WallType=Type_OW,
          WindowType=Type_Win,
          U_door=U_door_OD1,
          eps_door=eps_door_OD1) annotation (Placement(transformation(
                extent={{-64,-22},{-54,36}}, rotation=0)));
        AixLib.Building.Components.Walls.Wall outside_wall2(
          solar_absorptance=solar_absorptance_OW,
          windowarea=windowarea_OW2,
          T0=T0_OW2,
          door_height=door_height_OD2,
          door_width=door_width_OD2,
          wall_length=room_width,
          wall_height=room_height,
          withWindow=withWindow2,
          withDoor=withDoor2,
          WallType=Type_OW,
          WindowType=Type_Win,
          U_door=U_door_OD2,
          eps_door=eps_door_OD2) annotation (Placement(transformation(
              origin={23,59},
              extent={{-4.99998,-27},{5.00001,27}},
              rotation=270)));
        AixLib.Building.Components.Walls.Wall inside_wall1a(
          T0=T0_IW1a,
          outside=false,
          WallType=Type_IWload,
          wall_length=room_length - room_lengthb,
          wall_height=room_height,
          withWindow=false,
          withDoor=false) annotation (Placement(transformation(
              origin={61,24},
              extent={{-2.99999,-16},{2.99999,16}},
              rotation=180)));
        AixLib.Building.Components.Walls.Wall inside_wall2(
          T0=T0_IW2,
          outside=false,
          WallType=Type_IWsimple,
          wall_length=room_width,
          wall_height=room_height,
          withWindow=false,
          withDoor=false) annotation (Placement(transformation(
              origin={22,-60},
              extent={{-4.00002,-26},{4.00001,26}},
              rotation=90)));
        AixLib.Building.Components.DryAir.Airload airload(V=room_V, T(start=
               T0_air)) annotation (Placement(transformation(extent={{0,-20},
                  {20,0}}, rotation=0)));
        AixLib.Building.Components.Walls.Wall Ceiling(
          T0=T0_CE,
          outside=false,
          WallType=Type_CE,
          wall_length=room_length,
          wall_height=room_width,
          withWindow=false,
          withDoor=false,
          ISOrientation=3) annotation (Placement(transformation(
              origin={-30,61},
              extent={{2.99997,-16},{-3.00002,16}},
              rotation=90)));
        AixLib.Building.Components.Walls.Wall floor(
          T0=T0_FL,
          outside=false,
          WallType=Type_FL,
          wall_length=room_length,
          wall_height=room_width,
          withWindow=false,
          withDoor=false,
          ISOrientation=2) if withFloorHeating == false annotation (
            Placement(transformation(
              origin={-27,-60},
              extent={{-2.00002,-11},{2.00001,11}},
              rotation=90)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall2
          annotation (Placement(transformation(extent={{20,-100},{40,-80}},
                rotation=0)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall1a
          annotation (Placement(transformation(extent={{80,20},{100,40}}, rotation=
                  0)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermOutside
          annotation (Placement(transformation(extent={{-100,80},{-80,100}},
                rotation=0), iconTransformation(extent={{-100,80},{-80,100}})));
        Modelica.Blocks.Interfaces.RealInput WindSpeedPort
          annotation (Placement(transformation(extent={{-109.5,-50},{-89.5,-30}},
                rotation=0)));
        Utilities.Interfaces.SolarRad_in SolarRadiationPort_OW1 annotation (
           Placement(transformation(extent={{-109.5,20},{-89.5,40}},
                rotation=0)));
        Utilities.Interfaces.SolarRad_in SolarRadiationPort_OW2 annotation (
           Placement(transformation(
              origin={50.5,101},
              extent={{-10,-10},{10,10}},
              rotation=270), iconTransformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={50.5,99})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling
          annotation (Placement(transformation(extent={{80,60},{100,80}}, rotation=
                  0)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermRoom
          annotation (Placement(transformation(extent={{-30,10},{-10,30}})));
        Utilities.Interfaces.Star starRoom
          annotation (Placement(transformation(extent={{10,10},{30,30}})));
        Modelica.Blocks.Interfaces.RealInput AirExchangePort annotation (
            Placement(transformation(
              extent={{-13,-13},{13,13}},
              rotation=270,
              origin={-20,100}), iconTransformation(
              extent={{-10.5,-10.5},{10.5,10.5}},
              rotation=270,
              origin={-20.5,98.5})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature Ground
          annotation (Placement(transformation(extent={{-24,-100},{-4,-80}})));
        Modelica.Blocks.Sources.Constant GroundTemperature(k=T_Ground)
          annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));
        AixLib.Building.Components.Walls.Wall inside_wall1b(
          T0=T0_IW1b,
          outside=false,
          WallType=Type_IWload,
          wall_length=room_lengthb,
          wall_height=room_height,
          withWindow=false,
          withDoor=false) annotation (Placement(transformation(
              origin={61,-15},
              extent={{-3,-15},{3,15}},
              rotation=180)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall1b
          annotation (Placement(transformation(extent={{80,-20},{100,0}}, rotation=
                  0)));
        Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor Tair
          annotation (Placement(transformation(extent={{24,-20},{38,-6}})));
        AixLib.Building.Components.DryAir.InfiltrationRate_DIN12831
          infiltrationRate(
          room_V=room_V,
          n50=n50,
          e=e,
          eps=eps) annotation (Placement(transformation(extent={{-68,44},{-50,
                  52}})));
        AixLib.Building.Components.DryAir.DynamicVentilation
          dynamicVentilation(
          HeatingLimit=HeatingLimit,
          Max_VR=Max_VR,
          Diff_toTempset=Diff_toTempset,
          Tset=Tset) if withDynamicVentilation annotation (Placement(
              transformation(extent={{-70,-66},{-46,-54}})));
        Utilities.Interfaces.Adaptors.HeatStarToComb thermStar_Demux
          annotation (Placement(transformation(
              extent={{-10,8},{10,-8}},
              rotation=90,
              origin={-20,-26})));
        AixLib.Building.Components.DryAir.VarAirExchange NaturalVentilation(
            V=room_V) annotation (Placement(transformation(extent={{-68,-50},
                  {-48,-30}})));
        AixLib.Building.Components.Walls.BaseClasses.SimpleNLayer floor_FH(
          h=room_width,
          l=room_length,
          n=Type_FL.n,
          d=Type_FL.d,
          rho=Type_FL.rho,
          lambda=Type_FL.lambda,
          c=Type_FL.c,
          T0=T0_FL) if withFloorHeating
          "floor component if using Floor heating" annotation (Placement(
              transformation(
              origin={-22,-77},
              extent={{-3.00007,16},{3,-16}},
              rotation=90)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor if
                                               withFloorHeating
          "thermal connector for floor heating" annotation (Placement(
              transformation(extent={{-24,-72},{-14,-62}}), iconTransformation(
                extent={{-32,-34},{-12,-14}})));
      equation

            // Connect equations for dynamic ventilation
          if withDynamicVentilation then
          connect(thermOutside, dynamicVentilation.port_outside);
          connect(dynamicVentilation.port_inside, airload.port);
          end if;

          //Connect floor for cases with or without floor heating
          if withFloorHeating then
            connect(floor_FH.port_b,thermFloor)  annotation (Line(
            points={{-23.6,-74.3},{-23.6,-67},{-19,-67}},
            color={191,0,0},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
          connect(floor_FH.port_a, Ground.port) annotation (Line(
              points={{-23.6,-79.7001},{-23.6,-90},{-4,-90}},
              color={191,0,0},
              smooth=Smooth.None,
              pattern=LinePattern.Dash));
          else
          connect(floor.port_outside, Ground.port) annotation (Line(
              points={{-27,-62.1},{-27,-90},{-4,-90}},
              color={191,0,0},
              smooth=Smooth.None,
              pattern=LinePattern.Dash));
          connect(floor.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{-27,-58},{-27,-40},{-20.1,-40},{-20.1,-38},{-20.1,-35.4}},
              color={191,0,0},
              smooth=Smooth.None,
              pattern=LinePattern.Dash));

          end if;

        connect(thermInsideWall2,thermInsideWall2)  annotation (Line(
            points={{30,-90},{30,-90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(GroundTemperature.y, Ground.T) annotation (Line(
            points={{-39,-90},{-30,-90},{-30,-90},{-26,-90}},
            color={0,0,127},
            smooth=Smooth.None));

        connect(WindSpeedPort, outside_wall2.WindSpeedPort) annotation (Line(
            points={{-99.5,-40},{-80,-40},{-80,74},{42.8,74},{42.8,64.25}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(thermRoom, thermRoom) annotation (Line(
            points={{-20,20},{-20,20}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(thermOutside, thermOutside) annotation (Line(
            points={{-90,90},{-90,90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(thermOutside, outside_wall1.port_outside) annotation (Line(
            points={{-90,90},{-90,82},{-80,82},{-80,6},{-68,6},{-68,7},{-64.25,7}},
            color={191,0,0},
            smooth=Smooth.None));

        connect(outside_wall1.WindSpeedPort, WindSpeedPort) annotation (Line(
            points={{-64.25,28.2667},{-80,28.2667},{-80,-40},{-99.5,-40}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(inside_wall1b.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{58,-15},{52,-15},{52,-40},{-20,-40},{-20,-38},{-20.1,-35.4}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(inside_wall1a.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{58,24},{52,24},{52,-40},{-20.1,-40},{-20.1,-38},{-20.1,
                -35.4}},
            color={191,0,0},
            smooth=Smooth.None));

        connect(outside_wall1.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{-54,7},{-48,6},{-40,6},{-40,-40},{-20.1,-40},{-20.1,-35.4}},
            color={191,0,0},
            smooth=Smooth.None));

        connect(outside_wall2.SolarRadiationPort, SolarRadiationPort_OW2)
          annotation (Line(
            points={{47.75,65.5},{47.75,74},{50.5,74},{50.5,88},{50.5,101}},
            color={255,128,0},
            smooth=Smooth.None));
        connect(outside_wall2.port_outside, thermOutside) annotation (Line(
            points={{23,64.25},{23,74},{-80,74},{-80,82},{-90,82},{-90,90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(Ceiling.port_outside, thermCeiling) annotation (Line(
            points={{-30,64.15},{-30,64.15},{-30,74},{84,74},{84,70},{90,70}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(starRoom, thermStar_Demux.star) annotation (Line(
            points={{20,20},{20,4},{-14.2,4},{-14.2,-15.6}},
            color={95,95,95},
            pattern=LinePattern.None,
            smooth=Smooth.None));
        connect(outside_wall2.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{23,54},{23,54},{23,40},{-40,40},{-40,-40},{-20.1,-40},{
                -20.1,-35.4}},
            color={191,0,0},
            smooth=Smooth.None));

        connect(inside_wall2.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{22,-56},{22,-40},{-20.1,-40},{-20.1,-38},{-20.1,-35.4}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(inside_wall2.port_outside, thermInsideWall2) annotation (Line(
            points={{22,-64.2},{22,-77.3},{30,-77.3},{30,-90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(inside_wall1a.port_outside, thermInsideWall1a) annotation (Line(
            points={{64.15,24},{77.225,24},{77.225,30},{90,30}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(inside_wall1b.port_outside, thermInsideWall1b) annotation (Line(
            points={{64.15,-15},{79.225,-15},{79.225,-10},{90,-10}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(thermStar_Demux.therm, airload.port) annotation (Line(
            points={{-25.1,-15.9},{-25.1,-12},{1,-12}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(infiltrationRate.port_a, thermOutside) annotation (Line(
            points={{-68,48},{-80,48},{-80,82},{-90,82},{-90,90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(SolarRadiationPort_OW1, outside_wall1.SolarRadiationPort)
          annotation (Line(
            points={{-99.5,30},{-80,30},{-80,33.5833},{-65.5,33.5833}},
            color={255,128,0},
            smooth=Smooth.None));
        connect(thermStar_Demux.therm, thermRoom) annotation (Line(
            points={{-25.1,-15.9},{-25.1,2.05},{-20,2.05},{-20,20}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(Tair.port, airload.port) annotation (Line(
            points={{24,-13},{24,-40},{-6,-40},{-6,-12},{1,-12}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(infiltrationRate.port_b, airload.port) annotation (Line(
            points={{-50,48},{-40,48},{-40,-40},{-6,-40},{-6,-12},{1,-12}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(Ceiling.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{-30,58},{-30,40},{-40,40},{-40,-40},{-20.1,-40},{-20.1,
                -35.4}},
            color={191,0,0},
            smooth=Smooth.None));

        connect(NaturalVentilation.port_a, thermOutside) annotation (Line(
            points={{-68,-40},{-80,-40},{-80,90},{-90,90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(NaturalVentilation.InPort1, AirExchangePort) annotation (Line(
            points={{-67,-46.4},{-80,-46.4},{-80,74},{-20,74},{-20,100}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(NaturalVentilation.port_b, airload.port) annotation (Line(
            points={{-48,-40},{-6,-40},{-6,-12},{1,-12}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(thermInsideWall1b, thermInsideWall1b) annotation (Line(
            points={{90,-10},{85,-10},{85,-10},{90,-10}},
            color={191,0,0},
            smooth=Smooth.None));

       annotation (__Dymola_Images(Parameters( source="AixLib/Images/House/2OW_2IWl_1IWs_1Gr_Pa.png", Width = 5, Length = 5)),
                    Icon(graphics={
              Rectangle(
                extent={{-6,-46},{6,46}},
                lineColor={0,0,0},
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid,
                origin={74,-22},
                rotation=0,
                radius=0),
              Rectangle(
                extent={{-80,80},{80,60}},
                lineColor={0,0,0},
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{25,10},{-25,-10}},
                lineColor={0,0,0},
                fillColor={170,213,255},
                fillPattern=FillPattern.Solid,
                origin={-25,70},
                rotation=180,
                visible=withWindow2),
              Rectangle(
                extent={{6,18},{-6,-18}},
                lineColor={0,0,0},
                fillColor={135,135,135},
                fillPattern=FillPattern.Solid,
                origin={74,42},
                rotation=0),
              Rectangle(
                extent={{-80,60},{-60,-80}},
                lineColor={0,0,0},
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-60,60},{68,-68}},
                lineColor={0,0,0},
                fillColor={47,102,173},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-60,-68},{80,-80}},
                lineColor={0,0,0},
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-80,50},{-60,0}},
                lineColor={0,0,0},
                fillColor={170,213,255},
                fillPattern=FillPattern.Solid,
                visible=withWindow1),
              Rectangle(
                extent={{20,80},{40,60}},
                lineColor={0,0,0},
                fillColor={127,127,0},
                fillPattern=FillPattern.Solid,
                visible=withDoor2),
              Rectangle(
                extent={{-80,-20},{-60,-40}},
                lineColor={0,0,0},
                fillColor={127,127,0},
                fillPattern=FillPattern.Solid,
                visible=withDoor1),
              Line(
                points={{-46,-38},{-46,-68}},
                color={255,255,255},
                smooth=Smooth.None),
              Line(
                points={{68,24},{56,24}},
                color={255,255,255},
                smooth=Smooth.None),
              Text(
                extent={{-56,52},{64,40}},
                lineColor={255,255,255},
                fillColor={255,170,170},
                fillPattern=FillPattern.Solid,
                textString="width"),
              Text(
                extent={{-120,6},{0,-6}},
                lineColor={255,255,255},
                fillColor={255,170,170},
                fillPattern=FillPattern.Solid,
                origin={-46,56},
                rotation=90,
                textString="length"),
              Text(
                extent={{57,6},{-57,-6}},
                lineColor={255,255,255},
                fillColor={255,170,170},
                fillPattern=FillPattern.Solid,
                origin={58,-23},
                rotation=90,
                textString="length_b"),
              Text(
                extent={{20,74},{40,66}},
                lineColor={255,255,255},
                fillColor={255,170,170},
                fillPattern=FillPattern.Solid,
                textString="D2",
                visible=withDoor2),
              Text(
                extent={{-50,76},{0,64}},
                lineColor={255,255,255},
                fillColor={255,170,170},
                fillPattern=FillPattern.Solid,
                textString="Win2",
                visible = withWindow2),
              Text(
                extent={{50,-6},{0,6}},
                lineColor={255,255,255},
                fillColor={255,170,170},
                fillPattern=FillPattern.Solid,
                textString="Win1",
                origin={-70,0},
                rotation=90,
                visible = withWindow1),
              Text(
                extent={{2.85713,-4},{-17.1429,4}},
                lineColor={255,255,255},
                fillColor={255,170,170},
                fillPattern=FillPattern.Solid,
                textString="D1",
                origin={-70,-22.8571},
                rotation=90,
                visible = withDoor1),
              Line(
                points={{-46,60},{-46,30}},
                color={255,255,255},
                smooth=Smooth.None),
              Line(
                points={{-60,46},{-30,46}},
                color={255,255,255},
                smooth=Smooth.None),
              Line(
                points={{38,46},{68,46}},
                color={255,255,255},
                smooth=Smooth.None),
              Line(
                points={{60,24},{60,16}},
                color={255,255,255},
                smooth=Smooth.None),
              Line(
                points={{60,-64},{60,-68}},
                color={255,255,255},
                smooth=Smooth.None)}),
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                  100}}),
                  graphics),
          Documentation(revisions="<html>
<p><ul>
<li><i>April 18, 2014</i> by Ana Constantin:<br/>Added documentation</li>
<li><i>July 7, 2011</i> by Ana Constantin:<br/>Implemented</li>
</ul></p>
</html>",     info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Model for a room with 2&nbsp;outer&nbsp;walls,&nbsp;2&nbsp;inner&nbsp;walls&nbsp;load towards two different rooms but with the same orientation,&nbsp;1&nbsp;inner&nbsp;wall&nbsp;simple,&nbsp;1&nbsp;floor&nbsp;towards&nbsp;ground,&nbsp;1&nbsp;ceiling&nbsp;towards&nbsp;upper&nbsp;floor.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The following figure presents the room&apos;s layout:</p>
<p><img src=\"modelica://AixLib/Images/House/2OW_2IWl_1IWs_1Gr_Pa.png\"/></p>
</html>"));
      end Ow2IwL2IwS1Gr1Uf1;

      model Ow1IwL2IwS1Gr1Uf1
        "1 outer wall, 2 inner walls load, 1 inner wall simple, 1 floor towards ground, 1 ceiling towards upper floor"
        import AixLib;

        ///////// construction parameters
        parameter Integer TMC =  1 "Themal Mass Class"
          annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice=1 "S", choice = 2 "M", choice = 3 "L", radioButtons = true));
        parameter Integer TIR = 1 "Thermal Insulation Regulation"
         annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice=1
              "EnEV_2009",                                                                                                    choice = 2
              "EnEV_2002",                                                                                                    choice = 3
              "WSchV_1995",  choice = 4 "WSchV_1984",                                                                          radioButtons = true));

        parameter Boolean withFloorHeating = false
          "If true, that floor has different connectors" annotation (Dialog(group = "Construction parameters"), choices(checkBox=true));

        parameter Modelica.SIunits.Temperature T0_air=295.15 "Air"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_OW1=295.15 "OW1"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_IW1=295.15 "IW1"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_IW2a=295.15 "IW2a"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_IW2b=295.15 "IW2b"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_IW3=295.15 "IW3"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_CE=295.13 "Ceiling"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_FL=295.13 "Floor"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));

       //////////room geometry
       parameter Modelica.SIunits.Length room_length=2 "length" annotation (Dialog(group = "Dimensions", descriptionLabel = true));
       parameter Modelica.SIunits.Length room_lengthb=1 "length_b " annotation (Dialog(group = "Dimensions", descriptionLabel = true));
       parameter Modelica.SIunits.Length room_width=2 "width " annotation (Dialog(group = "Dimensions", descriptionLabel = true));
       parameter Modelica.SIunits.Height room_height=2 "height " annotation (Dialog(group = "Dimensions", descriptionLabel = true));

       // Outer walls properties
       parameter Real solar_absorptance_OW=0.25 "Solar absoptance outer walls "
                                                                               annotation (Dialog(group = "Outer wall properties", descriptionLabel = true));
       parameter Modelica.SIunits.Temperature T_Ground=278.15
          "Ground Temperature"                                   annotation(Dialog(group="Outer wall properties", descriptionLabel = true));
       parameter Integer ModelConvOW =  1 "Heat Convection Model"
         annotation(Dialog(group = "Outer wall properties", compact = true, descriptionLabel = true), choices(choice = 1
              "DIN 6946",                                                                                                    choice = 2
              "ASHRAE Fundamentals",                                                                                                    choice = 3
              "Custom alpha",                                                                                                    radioButtons = true));

       // Windows and Doors
       parameter Boolean withWindow1 = true "Window 1" annotation (Dialog(group = "Windows and Doors", joinNext = true, descriptionLabel = true), choices(checkBox=true));
       parameter Modelica.SIunits.Area windowarea_OW1=0 "Window area " annotation (Dialog(group = "Windows and Doors", descriptionLabel = true, enable = withWindow1));
       parameter Boolean withDoor1 = true "Door 1" annotation (Dialog(group = "Windows and Doors", joinNext = true, descriptionLabel = true), choices(checkBox=true));
       parameter Modelica.SIunits.Length door_width_OD1=0 "width " annotation (Dialog(group = "Windows and Doors", joinNext = true, descriptionLabel = true, enable = withDoor1));
       parameter Modelica.SIunits.Length door_height_OD1=0 "height " annotation (Dialog(group = "Windows and Doors", descriptionLabel = true, enable = withDoor1));

       // Dynamic Ventilation
      parameter Boolean withDynamicVentilation = false "Dynamic ventilation" annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true), choices(checkBox=true));
      parameter Modelica.SIunits.Temperature HeatingLimit = 288.15
          "Outside temperature at which the heating activates"
                                                             annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true,  enable = if withDynamicVentilation then true else false));
      parameter Real Max_VR = 10 "Maximal ventilation rate" annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true,  enable = if withDynamicVentilation then true else false));
      parameter Modelica.SIunits.TemperatureDifference Diff_toTempset = 2
          "Difference to set temperature" annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true,  enable = if withDynamicVentilation then true else false));
      parameter Modelica.SIunits.Temperature Tset = 295.15 "Tset"
                 annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true,  enable = if withDynamicVentilation then true else false));

       //Door properties
      protected
       parameter Real U_door_OD1=if TIR == 1 then 1.8 else  2.9 "U-value"  annotation (Dialog(group = "Windows and Doors", joinNext = true, descriptionLabel = true, enable = withDoor1));
       parameter Real eps_door_OD1=0.95 "eps" annotation (Dialog(group = "Windows and Doors", descriptionLabel = true, enable = withDoor1));

        // Infiltration rate
        parameter Real n50(unit="h-1")=
        if (TIR == 1 or TIR ==2) then 3 else
        if TIR == 3 then 4 else 6
          "Air exchange rate at 50 Pa pressure difference" annotation (Dialog(tab = "Infiltration"));
        parameter Real e=0.02 "Coefficient of windshield" annotation (Dialog(tab = "Infiltration"));
        parameter Real eps=1.0 "Coefficient of height" annotation (Dialog(tab = "Infiltration"));

        // Outer wall type
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_OW=if TIR
             == 1 then if TMC == 1 then
            AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S() else if TMC == 2
             then AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_M() else
            AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_L() else if TIR == 2
             then if TMC == 1 then
            AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_S() else if TMC == 2
             then AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_M() else
            AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_L() else if TIR == 3
             then if TMC == 1 then
            AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_S() else if TMC ==
            2 then AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_M() else
            AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_L() else if TMC ==
            1 then AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_S() else if
            TMC == 2 then AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_M()
             else AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_L()
          annotation (Dialog(tab="Types"));

        //Inner wall Types
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_IWsimple=
            if TIR == 1 then if TMC == 1 then
            AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_S_half() else
            if TMC == 2 then
            AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_M_half() else
            AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_L_half() else
            if TIR == 2 then if TMC == 1 then
            AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_S_half() else
            if TMC == 2 then
            AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_M_half() else
            AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_L_half() else
            if TIR == 3 then if TMC == 1 then
            AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_S_half()
             else if TMC == 2 then
            AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_M_half()
             else AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_L_half()
             else if TMC == 1 then
            AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_S_half()
             else if TMC == 2 then
            AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_M_half()
             else AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_L_half()
          annotation (Dialog(tab="Types"));

        parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_IWload=if
            TIR == 1 then if TMC == 1 then
            AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half() else if
            TMC == 2 then
            AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_M_half() else
            AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_L_half() else if
            TIR == 2 then if TMC == 1 then
            AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_S_half() else if
            TMC == 2 then
            AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_M_half() else
            AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_L_half() else if
            TIR == 3 then if TMC == 1 then
            AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_S_half() else
            if TMC == 2 then
            AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_M_half() else
            AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_L_half() else
            if TMC == 1 then
            AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_S_half() else
            if TMC == 2 then
            AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_M_half() else
            AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_L_half()
          annotation (Dialog(tab="Types"));

         // Floor to ground type
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_FL=if TIR
             == 1 then
            AixLib.DataBase.Walls.EnEV2009.Floor.FLground_EnEV2009_SML() else
            if TIR == 2 then
            AixLib.DataBase.Walls.EnEV2002.Floor.FLground_EnEV2002_SML() else
            if TIR == 3 then
            AixLib.DataBase.Walls.WSchV1995.Floor.FLground_WSchV1995_SML()
             else AixLib.DataBase.Walls.WSchV1984.Floor.FLground_WSchV1984_SML()
          annotation (Dialog(tab="Types"));

        // Ceiling to upper floor type
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_CE=if TIR
             == 1 then if (TMC == 1 or TMC == 2) then
            AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_SM_loHalf()
             else
            AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_L_loHalf()
             else if TIR == 2 then if (TMC == 1 or TMC == 2) then
            AixLib.DataBase.Walls.EnEV2002.Ceiling.CEpartition_EnEV2002_SM_loHalf()
             else
            AixLib.DataBase.Walls.EnEV2002.Ceiling.CEpartition_EnEV2002_L_loHalf()
             else if TIR == 3 then if (TMC == 1 or TMC == 2) then
            AixLib.DataBase.Walls.WSchV1995.Ceiling.CEpartition_WSchV1995_SM_loHalf()
             else
            AixLib.DataBase.Walls.WSchV1995.Ceiling.CEpartition_WSchV1995_L_loHalf()
             else if (TMC == 1 or TMC == 2) then
            AixLib.DataBase.Walls.WSchV1984.Ceiling.CEpartition_WSchV1984_SM_loHalf()
             else
            AixLib.DataBase.Walls.WSchV1984.Ceiling.CEpartition_WSchV1984_L_loHalf()
          annotation (Dialog(tab="Types"));

         //Window type
        parameter
          AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple
          Type_Win=if TIR == 1 then
            AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009() else
            if TIR == 2 then
            AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2002() else
            if TIR == 3 then
            AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1995() else
            AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1984()
          annotation (Dialog(tab="Types"));

          parameter Modelica.SIunits.Volume room_V=room_length*room_width*room_height;

      public
        AixLib.Building.Components.Walls.Wall outside_wall1(
          solar_absorptance=solar_absorptance_OW,
          windowarea=windowarea_OW1,
          T0=T0_OW1,
          door_height=door_height_OD1,
          door_width=door_width_OD1,
          wall_length=room_length,
          wall_height=room_height,
          withWindow=withWindow1,
          withDoor=withDoor1,
          WallType=Type_OW,
          WindowType=Type_Win,
          U_door=U_door_OD1,
          eps_door=eps_door_OD1) annotation (Placement(transformation(
                extent={{-64,-30},{-54,26}}, rotation=0)));
        AixLib.Building.Components.Walls.Wall inside_wall1(
          T0=T0_IW1,
          outside=false,
          WallType=Type_IWsimple,
          wall_length=room_width,
          wall_height=room_height,
          withWindow=false,
          withDoor=false) annotation (Placement(transformation(
              origin={23,59},
              extent={{-5.00018,-29},{5.00003,29}},
              rotation=270)));
        AixLib.Building.Components.Walls.Wall inside_wall2a(
          T0=T0_IW2a,
          outside=false,
          WallType=Type_IWload,
          wall_length=room_length - room_lengthb,
          wall_height=room_height,
          withWindow=false,
          withDoor=false) annotation (Placement(transformation(
              origin={61,23},
              extent={{-3,-15},{3,15}},
              rotation=180)));
        AixLib.Building.Components.Walls.Wall inside_wall3(
          T0=T0_IW3,
          outside=false,
          WallType=Type_IWsimple,
          wall_length=room_width,
          wall_height=room_height,
          withWindow=false,
          withDoor=false) annotation (Placement(transformation(
              origin={25,-59},
              extent={{-5.00002,-29},{5.00001,29}},
              rotation=90)));
        AixLib.Building.Components.DryAir.Airload airload(V=room_V, T(start=
               T0_air)) annotation (Placement(transformation(extent={{0,-20},
                  {20,0}}, rotation=0)));
        AixLib.Building.Components.Walls.Wall Ceiling(
          T0=T0_CE,
          outside=false,
          WallType=Type_CE,
          wall_length=room_length,
          wall_height=room_width,
          withWindow=false,
          withDoor=false,
          ISOrientation=3) annotation (Placement(transformation(
              origin={-31,60},
              extent={{2,-9},{-2,9}},
              rotation=90)));
        AixLib.Building.Components.Walls.Wall floor(
          T0=T0_FL,
          outside=false,
          WallType=Type_FL,
          wall_length=room_length,
          wall_height=room_width,
          withWindow=false,
          withDoor=false,
          ISOrientation=2) if withFloorHeating == false annotation (
            Placement(transformation(
              origin={-27,-60},
              extent={{-2.00002,-11},{2.00001,11}},
              rotation=90)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall3
          annotation (Placement(transformation(extent={{20,-100},{40,-80}},
                rotation=0)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall2a
          annotation (Placement(transformation(extent={{80,20},{100,40}}, rotation=
                  0)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermOutside
          annotation (Placement(transformation(extent={{-100,80},{-80,100}},
                rotation=0)));
        Modelica.Blocks.Interfaces.RealInput WindSpeedPort
          annotation (Placement(transformation(extent={{-109.5,-70},{-89.5,-50}},
                rotation=0), iconTransformation(extent={{-109.5,-70},{-89.5,-50}})));
        Utilities.Interfaces.SolarRad_in SolarRadiationPort_OW1 annotation (
           Placement(transformation(extent={{-109.5,50},{-89.5,70}},
                rotation=0)));
        Modelica.Blocks.Interfaces.RealInput AirExchangePort
          annotation (Placement(transformation(
              origin={-100,-19.5},
              extent={{-10,-10.5},{10,10.5}},
              rotation=0), iconTransformation(extent={{-110,-30},{-90,-10}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling
          annotation (Placement(transformation(extent={{80,60},{100,80}}, rotation=
                  0)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermRoom
          annotation (Placement(transformation(extent={{-30,10},{-10,30}})));
        Utilities.Interfaces.Star starRoom
          annotation (Placement(transformation(extent={{10,10},{30,30}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature Ground
          annotation (Placement(transformation(extent={{-22,-100},{-2,-80}})));
        Modelica.Blocks.Sources.Constant GroundTemperature(k=T_Ground)
          annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));
        AixLib.Building.Components.Walls.Wall inside_wall2b(
          T0=T0_IW2b,
          outside=false,
          WallType=Type_IWload,
          wall_length=room_lengthb,
          wall_height=room_height,
          withWindow=false,
          withDoor=false) annotation (Placement(transformation(
              origin={61,-17},
              extent={{-3,-15},{3,15}},
              rotation=180)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall2b
          annotation (Placement(transformation(extent={{80,-20},{100,0}}, rotation=
                  0)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall1
          annotation (Placement(transformation(extent={{20,80},{40,100}})));
        Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor Tair
          annotation (Placement(transformation(extent={{24,-20},{38,-6}})));
        AixLib.Building.Components.DryAir.InfiltrationRate_DIN12831
          infiltrationRate(
          room_V=room_V,
          n50=n50,
          e=e,
          eps=eps) annotation (Placement(transformation(extent={{-66,44},{-48,
                  52}})));
        AixLib.Building.Components.DryAir.DynamicVentilation
          dynamicVentilation(
          HeatingLimit=HeatingLimit,
          Max_VR=Max_VR,
          Diff_toTempset=Diff_toTempset,
          Tset=Tset) if withDynamicVentilation annotation (Placement(
              transformation(extent={{-70,-70},{-46,-58}})));
        Utilities.Interfaces.Adaptors.HeatStarToComb thermStar_Demux
          annotation (Placement(transformation(
              extent={{-10,8},{10,-8}},
              rotation=90,
              origin={-20,-26})));
        AixLib.Building.Components.DryAir.VarAirExchange NaturalVentilation(
            V=room_V) annotation (Placement(transformation(extent={{-68,-50},
                  {-48,-30}})));
        AixLib.Building.Components.Walls.BaseClasses.SimpleNLayer floor_FH(
          h=room_width,
          l=room_length,
          n=Type_FL.n,
          d=Type_FL.d,
          rho=Type_FL.rho,
          lambda=Type_FL.lambda,
          c=Type_FL.c,
          T0=T0_FL) if withFloorHeating
          "floor component if using Floor heating" annotation (Placement(
              transformation(
              origin={-16,-77},
              extent={{-3.00007,16},{3,-16}},
              rotation=90)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor if
                                               withFloorHeating
          "thermal connector for floor heating" annotation (Placement(
              transformation(extent={{-18,-68},{-8,-58}}), iconTransformation(
                extent={{-32,-34},{-12,-14}})));
      equation

            // Connect equations for dynamic ventilation
          if withDynamicVentilation then
          connect(thermOutside, dynamicVentilation.port_outside);
          connect(dynamicVentilation.port_inside, airload.port);
          end if;

          //Connect floor for cases with or without floor heating
          if withFloorHeating then
            connect(floor_FH.port_b,thermFloor)  annotation (Line(
            points={{-17.6,-74.3},{-17.6,-63},{-13,-63}},
            color={191,0,0},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
          connect(floor_FH.port_a, Ground.port) annotation (Line(
              points={{-17.6,-79.7001},{-17.6,-90},{-2,-90}},
              color={191,0,0},
              smooth=Smooth.None,
              pattern=LinePattern.Dash));
          else
          connect(floor.port_outside, Ground.port) annotation (Line(
              points={{-27,-62.1},{-27,-90},{-2,-90}},
              color={191,0,0},
              smooth=Smooth.None,
              pattern=LinePattern.Dash));
          connect(floor.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{-27,-58},{-27,-40},{-20.1,-40},{-20.1,-35.4}},
              color={191,0,0},
              smooth=Smooth.None,
              pattern=LinePattern.Dash));
          end if;

        connect(thermInsideWall3,thermInsideWall3)  annotation (Line(
            points={{30,-90},{30,-90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(GroundTemperature.y, Ground.T) annotation (Line(
            points={{-39,-90},{-30,-90},{-30,-90},{-24,-90}},
            color={0,0,127},
            smooth=Smooth.None));

        connect(Tair.port, airload.port) annotation (Line(
            points={{24,-13},{24,-40},{-6,-40},{-6,-12},{1,-12}},
            color={191,0,0},
            smooth=Smooth.None));

        connect(starRoom, thermStar_Demux.star) annotation (Line(
            points={{20,20},{20,4},{-14.2,4},{-14.2,-15.6}},
            color={95,95,95},
            pattern=LinePattern.None,
            smooth=Smooth.None));
        connect(inside_wall2b.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{58,-17},{40,-17},{40,-40},{-20.1,-40},{-20.1,-35.4}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(inside_wall2a.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{58,23},{40,23},{40,-40},{-20.1,-40},{-20.1,-35.4}},
            color={191,0,0},
            smooth=Smooth.None));

        connect(inside_wall1.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{23,54},{23,54},{23,40},{-40,40},{-40,-40},{-20.1,-40},{
                -20.1,-35.4}},
            color={191,0,0},
            smooth=Smooth.None));

        connect(inside_wall3.port_outside, thermInsideWall3) annotation (Line(
            points={{25,-64.25},{25,-77.375},{30,-77.375},{30,-90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(inside_wall2b.port_outside, thermInsideWall2b) annotation (Line(
            points={{64.15,-17},{77.225,-17},{77.225,-10},{90,-10}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(inside_wall2a.port_outside, thermInsideWall2a) annotation (Line(
            points={{64.15,23},{78.225,23},{78.225,30},{90,30}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(inside_wall1.port_outside, thermInsideWall1) annotation (Line(
            points={{23,64.2502},{23,76.3751},{30,76.3751},{30,90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(Ceiling.port_outside, thermCeiling) annotation (Line(
            points={{-31,62.1},{-31,70},{90,70}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(outside_wall1.WindSpeedPort, WindSpeedPort) annotation (Line(
            points={{-64.25,18.5333},{-80,18.5333},{-80,-60},{-99.5,-60}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(thermStar_Demux.therm, airload.port) annotation (Line(
            points={{-25.1,-15.9},{-25.1,-12},{1,-12}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(thermStar_Demux.therm, thermRoom) annotation (Line(
            points={{-25.1,-15.9},{-25.1,0.05},{-20,0.05},{-20,20}},
            color={191,0,0},
            smooth=Smooth.None));

        connect(inside_wall3.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{25,-54},{25,-40},{-20.1,-40},{-20.1,-35.4}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(outside_wall1.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{-54,-2},{-40,-2},{-40,-40},{-20.1,-40},{-20.1,-35.4}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(infiltrationRate.port_b, airload.port) annotation (Line(
            points={{-48,48},{-40,48},{-40,-40},{-6,-40},{-6,-12},{1,-12}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(Ceiling.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{-31,58},{-31,40},{-40,40},{-40,-40},{-20.1,-40},{-20.1,-35.4}},
            color={191,0,0},
            smooth=Smooth.None));

        connect(infiltrationRate.port_a, thermOutside) annotation (Line(
            points={{-66,48},{-80,48},{-80,84},{-90,84},{-90,90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(outside_wall1.port_outside, thermOutside) annotation (Line(
            points={{-64.25,-2},{-80,-2},{-80,84},{-90,84},{-90,90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(SolarRadiationPort_OW1, outside_wall1.SolarRadiationPort)
          annotation (Line(
            points={{-99.5,60},{-80,60},{-80,23.6667},{-65.5,23.6667}},
            color={255,128,0},
            smooth=Smooth.None));
        connect(AirExchangePort, NaturalVentilation.InPort1) annotation (Line(
            points={{-100,-19.5},{-80,-19.5},{-80,-46.4},{-67,-46.4}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(NaturalVentilation.port_a, thermOutside) annotation (Line(
            points={{-68,-40},{-80,-40},{-80,90},{-90,90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(NaturalVentilation.port_b, airload.port) annotation (Line(
            points={{-48,-40},{-6,-40},{-6,-12},{1,-12}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(thermCeiling, thermCeiling) annotation (Line(
            points={{90,70},{85,70},{85,70},{90,70}},
            color={191,0,0},
            smooth=Smooth.None));

       annotation (__Dymola_Images(Parameters(source="AixLib/Images/House/1OW_2IWl_2IWs_1Gr_Pa.png", Width = 5, Length = 5)),
                    Icon(graphics={
              Rectangle(
                extent={{6,65},{-6,-65}},
                lineColor={0,0,0},
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid,
                origin={74,-3},
                rotation=180),
              Rectangle(
                extent={{-60,68},{68,-68}},
                lineColor={0,0,0},
                fillColor={47,102,173},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-80,68},{-60,-80}},
                lineColor={0,0,0},
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-60,-68},{80,-80}},
                lineColor={0,0,0},
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-80,0},{-60,-50}},
                lineColor={0,0,0},
                fillColor={170,213,255},
                fillPattern=FillPattern.Solid,
                visible=withWindow1),
              Rectangle(
                extent={{80,80},{-80,68}},
                lineColor={0,0,0},
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{80,68},{68,26}},
                lineColor={0,0,0},
                fillColor={135,135,135},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-46,68},{-46,38}},
                color={255,255,255},
                smooth=Smooth.None),
              Line(
                points={{-60,54},{-30,54}},
                color={255,255,255},
                smooth=Smooth.None),
              Text(
                extent={{-56,60},{62,48}},
                lineColor={255,255,255},
                fillColor={255,170,170},
                fillPattern=FillPattern.Solid,
                textString="width"),
              Line(
                points={{38,54},{68,54}},
                color={255,255,255},
                smooth=Smooth.None),
              Text(
                extent={{-126,6},{0,-6}},
                lineColor={255,255,255},
                fillColor={255,170,170},
                fillPattern=FillPattern.Solid,
                origin={-46,64},
                rotation=90,
                textString="length"),
              Line(
                points={{-46,-38},{-46,-68}},
                color={255,255,255},
                smooth=Smooth.None),
              Line(
                points={{68,26},{54,26}},
                color={255,255,255},
                smooth=Smooth.None),
              Line(
                points={{58,-58},{58,-68}},
                color={255,255,255},
                smooth=Smooth.None),
              Text(
                extent={{59,6},{-59,-6}},
                lineColor={255,255,255},
                fillColor={255,170,170},
                fillPattern=FillPattern.Solid,
                origin={58,-21},
                rotation=90,
                textString="length_b"),
              Rectangle(
                extent={{-80,40},{-60,20}},
                lineColor={0,0,0},
                fillColor={127,127,0},
                fillPattern=FillPattern.Solid,
                visible=withDoor1),
              Text(
                extent={{-10,4},{10,-4}},
                lineColor={255,255,255},
                fillColor={255,170,170},
                fillPattern=FillPattern.Solid,
                textString="D1",
                origin={-70,30},
                rotation=90,
                visible = withDoor1),
              Text(
                extent={{-25,6},{25,-6}},
                lineColor={255,255,255},
                fillColor={255,170,170},
                fillPattern=FillPattern.Solid,
                origin={-70,-25},
                rotation=90,
                textString="Win1",
                visible = withWindow1),
              Line(
                points={{58,26},{58,18}},
                color={255,255,255},
                smooth=Smooth.None)}),
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                  100}}),
                  graphics),
          Documentation(revisions="<html>
<p><ul>
<li><i>April 18, 2014</i> by Ana Constantin:<br/>Added documentation</li>
<li><i>July 7, 2011</i> by Ana Constantin:<br/>Implemented</li>
</ul></p>
</html>",     info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Model for a room with 1&nbsp;outer&nbsp;wall,&nbsp;2&nbsp;inner&nbsp;walls&nbsp;load,&nbsp;1&nbsp;inner&nbsp;wall&nbsp;simple,&nbsp;1&nbsp;floor&nbsp;towards&nbsp;ground,&nbsp;1&nbsp;ceiling&nbsp;towards&nbsp;upper&nbsp;floor.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The following figure presents the room&apos;s layout:</p>
<p><img src=\"modelica://AixLib/Images/House/1OW_2IWl_2IWs_1Gr_Pa.png\"/></p>
</html>"));
      end Ow1IwL2IwS1Gr1Uf1;

      model Ow2IwL1IwS1Lf1At1Ro1
        "2 outer walls, 1 inner wall load, 1 inner wall simple, 1 floor towards lower floor, 1 ceiling towards attic, 1 roof towards outside"
        import AixLib;

        ///////// construction parameters
        parameter Integer TMC =  1 "Themal Mass Class"
          annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice=1 "S", choice = 2 "M", choice = 3 "L", radioButtons = true));
        parameter Integer TIR = 1 "Thermal Insulation Regulation"
         annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice=1
              "EnEV_2009",                                                                                                    choice = 2
              "EnEV_2002",                                                                                                    choice = 3
              "WSchV_1995",  choice = 4 "WSchV_1984",                                                                          radioButtons = true));

        parameter Boolean withFloorHeating = false
          "If true, that floor has different connectors" annotation (Dialog(group = "Construction parameters"), choices(checkBox=true));

        parameter Modelica.SIunits.Temperature T0_air=295.11 "Air"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_OW1=295.15 "OW1"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_OW2=295.15 "OW2"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_IW1=295.15 "IW1"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_IW2=295.15 "IW2"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_CE=295.10 "Ceiling"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_RO=295.15 "Roof"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_FL=295.12 "Floor"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));

       //////////room geometry
       parameter Modelica.SIunits.Length room_length=2 "length " annotation (Dialog(group = "Dimensions", descriptionLabel = true));
       parameter Modelica.SIunits.Length room_width_long=2 "w1 " annotation (Dialog(group = "Dimensions", descriptionLabel = true));
       parameter Modelica.SIunits.Length room_width_short=2 "w2 " annotation (Dialog(group = "Dimensions", descriptionLabel = true));
       parameter Modelica.SIunits.Height room_height_long=2 "h1 " annotation (Dialog(group = "Dimensions", descriptionLabel = true));
       parameter Modelica.SIunits.Height room_height_short=2 "h2 " annotation (Dialog(group = "Dimensions", descriptionLabel = true));
       parameter Modelica.SIunits.Length roof_width = 2 "wRO" annotation (Dialog(group = "Dimensions", descriptionLabel = true));

       // Outer walls properties
       parameter Real solar_absorptance_OW=0.25 "Solar absoptance outer walls "
                                                                               annotation (Dialog(group = "Outer wall properties", descriptionLabel = true));
       parameter Real solar_absorptance_RO=0.25 "Solar absoptance roof "
                                                                        annotation (Dialog(group = "Outer wall properties", descriptionLabel = true));
       parameter Integer ModelConvOW =  1 "Heat Convection Model"
         annotation(Dialog(group = "Outer wall properties", compact = true, descriptionLabel = true), choices(choice = 1
              "DIN 6946",                                                                                                    choice = 2
              "ASHRAE Fundamentals",                                                                                                    choice = 3
              "Custom alpha",                                                                                                    radioButtons = true));

       // Windows and Doors
       parameter Boolean withWindow2 = true "Window 2" annotation (Dialog(group = "Windows and Doors", joinNext = true, descriptionLabel = true), choices(checkBox=true));
       parameter Modelica.SIunits.Area windowarea_OW2=0 "Window area " annotation (Dialog(group = "Windows and Doors", descriptionLabel = true, enable = withWindow2));
       parameter Boolean withWindow3 = true "Window 3 " annotation (Dialog(group = "Windows and Doors", joinNext = true, descriptionLabel = true), choices(checkBox=true));
       parameter Modelica.SIunits.Area windowarea_RO=0 "Window area" annotation (Dialog(group = "Windows and Doors", naturalWidth = 10, descriptionLabel = true, enable = withWindow3));
       parameter Boolean withDoor2 = true "Door 2" annotation (Dialog( group = "Windows and Doors", joinNext = true, descriptionLabel = true), choices(checkBox=true));
       parameter Modelica.SIunits.Length door_width_OD2=0 "width " annotation (Dialog(group = "Windows and Doors", joinNext = true, descriptionLabel = true, enable = withDoor2));
       parameter Modelica.SIunits.Length door_height_OD2=0 "height " annotation (Dialog(group = "Windows and Doors", descriptionLabel = true, enable = withDoor2));

      // Dynamic Ventilation
      parameter Boolean withDynamicVentilation = false "Dynamic ventilation" annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true), choices(checkBox=true));
      parameter Modelica.SIunits.Temperature HeatingLimit = 288.15
          "Outside temperature at which the heating activates"
                                                             annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true,  enable = if withDynamicVentilation then true else false));
      parameter Real Max_VR = 10 "Maximal ventilation rate" annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true,  enable = if withDynamicVentilation then true else false));
      parameter Modelica.SIunits.TemperatureDifference Diff_toTempset = 2
          "Difference to set temperature" annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true,  enable = if withDynamicVentilation then true else false));
      parameter Modelica.SIunits.Temperature Tset = 295.15 "Tset"
                 annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true,  enable = if withDynamicVentilation then true else false));

        //Door properties
      protected
       parameter Real U_door_OD2=if TIR == 1 then 1.8 else  2.9 "U-value" annotation (Dialog(group = "Windows and Doors", joinNext = true, descriptionLabel = true, enable = withDoor2));
       parameter Real eps_door_OD2=0.95 "eps" annotation (Dialog(group = "Windows and Doors", descriptionLabel = true, enable = withDoor2));

        // Infiltration rate
        parameter Real n50(unit="h-1")=
        if (TIR == 1 or TIR ==2) then 3 else
        if TIR == 3 then 4 else 6
          "Air exchange rate at 50 Pa pressure difference" annotation (Dialog(tab = "Infiltration"));
        parameter Real e=0.03 "Coefficient of windshield" annotation (Dialog(tab = "Infiltration"));
        parameter Real eps=1.0 "Coefficient of height" annotation (Dialog(tab = "Infiltration"));

        // Outer wall type
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_OW=if TIR
             == 1 then if TMC == 1 then
            AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S() else if TMC == 2
             then AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_M() else
            AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_L() else if TIR == 2
             then if TMC == 1 then
            AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_S() else if TMC == 2
             then AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_M() else
            AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_L() else if TIR == 3
             then if TMC == 1 then
            AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_S() else if TMC ==
            2 then AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_M() else
            AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_L() else if TMC ==
            1 then AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_S() else if
            TMC == 2 then AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_M()
             else AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_L()
          annotation (Dialog(tab="Types"));

        //Inner wall Types
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_IWsimple=
            if TIR == 1 then if TMC == 1 then
            AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_S_half() else
            if TMC == 2 then
            AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_M_half() else
            AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_L_half() else
            if TIR == 2 then if TMC == 1 then
            AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_S_half() else
            if TMC == 2 then
            AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_M_half() else
            AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_L_half() else
            if TIR == 3 then if TMC == 1 then
            AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_S_half()
             else if TMC == 2 then
            AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_M_half()
             else AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_L_half()
             else if TMC == 1 then
            AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_S_half()
             else if TMC == 2 then
            AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_M_half()
             else AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_L_half()
          annotation (Dialog(tab="Types"));

        parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_IWload=if
            TIR == 1 then if TMC == 1 then
            AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half() else if
            TMC == 2 then
            AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_M_half() else
            AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_L_half() else if
            TIR == 2 then if TMC == 1 then
            AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_S_half() else if
            TMC == 2 then
            AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_M_half() else
            AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_L_half() else if
            TIR == 3 then if TMC == 1 then
            AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_S_half() else
            if TMC == 2 then
            AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_M_half() else
            AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_L_half() else
            if TMC == 1 then
            AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_S_half() else
            if TMC == 2 then
            AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_M_half() else
            AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_L_half()
          annotation (Dialog(tab="Types"));

         // Floor to lower floor type
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_FL=if TIR
             == 1 then if (TMC == 1 or TMC == 2) then
            AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_SM_upHalf()
             else
            AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_L_upHalf()
             else if TIR == 2 then if (TMC == 1 or TMC == 2) then
            AixLib.DataBase.Walls.EnEV2002.Floor.FLpartition_EnEV2002_SM_upHalf()
             else
            AixLib.DataBase.Walls.EnEV2002.Floor.FLpartition_EnEV2002_L_upHalf()
             else if TIR == 3 then if (TMC == 1 or TMC == 2) then
            AixLib.DataBase.Walls.WSchV1995.Floor.FLpartition_WSchV1995_SM_upHalf()
             else
            AixLib.DataBase.Walls.WSchV1995.Floor.FLpartition_WSchV1995_L_upHalf()
             else if (TMC == 1 or TMC == 2) then
            AixLib.DataBase.Walls.WSchV1984.Floor.FLpartition_WSchV1984_SM_upHalf()
             else
            AixLib.DataBase.Walls.WSchV1984.Floor.FLpartition_WSchV1984_L_upHalf()
          annotation (Dialog(tab="Types"));

        // Ceiling to attic type
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_CE=if TIR
             == 1 then
            AixLib.DataBase.Walls.EnEV2009.Ceiling.CEattic_EnEV2009_SML_loHalf()
             else if TIR == 2 then
            AixLib.DataBase.Walls.EnEV2002.Ceiling.CEattic_EnEV2002_SML_loHalf()
             else if TIR == 3 then
            AixLib.DataBase.Walls.WSchV1995.Ceiling.CEattic_WSchV1995_SML_loHalf()
             else
            AixLib.DataBase.Walls.WSchV1984.Ceiling.CEattic_WSchV1984_SML_loHalf()
          annotation (Dialog(tab="Types"));

         // Saddle roof type
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_RO=if TIR
             == 1 then
            AixLib.DataBase.Walls.EnEV2009.Ceiling.ROsaddleRoom_EnEV2009_SML()
             else if TIR == 2 then
            AixLib.DataBase.Walls.EnEV2002.Ceiling.ROsaddleRoom_EnEV2002_SML()
             else if TIR == 3 then
            AixLib.DataBase.Walls.WSchV1995.Ceiling.ROsaddleRoom_WSchV1995_SML()
             else
            AixLib.DataBase.Walls.WSchV1984.Ceiling.ROsaddleRoom_WSchV1984_SML()
          annotation (Dialog(tab="Types"));

         //Window type
        parameter
          AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple
          Type_Win=if TIR == 1 then
            AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009() else
            if TIR == 2 then
            AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2002() else
            if TIR == 3 then
            AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1995() else
            AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1984()
          annotation (Dialog(tab="Types"));

          parameter Modelica.SIunits.Volume room_V=room_length*room_width_long*room_height_long - room_length*(room_width_long-room_width_short)*(room_height_long-room_height_short)*0.5;

      public
        AixLib.Building.Components.Walls.Wall outside_wall1(
          solar_absorptance=solar_absorptance_OW,
          T0=T0_OW1,
          wall_length=room_length,
          wall_height=room_height_short,
          withWindow=false,
          windowarea=0,
          withDoor=false,
          door_height=0,
          door_width=0,
          WallType=Type_OW) annotation (Placement(transformation(extent={{-64,
                  -26},{-54,32}}, rotation=0)));
        AixLib.Building.Components.Walls.Wall outside_wall2(
          solar_absorptance=solar_absorptance_OW,
          windowarea=windowarea_OW2,
          T0=T0_OW2,
          door_height=door_height_OD2,
          door_width=door_width_OD2,
          withWindow=withWindow2,
          withDoor=withDoor2,
          wall_length=room_width_long,
          wall_height=0.5*(room_height_long + room_height_short +
              room_width_short/room_width_long*(room_height_long -
              room_height_short)),
          WindowType=Type_Win,
          WallType=Type_OW,
          ISOrientation=1,
          U_door=U_door_OD2,
          eps_door=eps_door_OD2) annotation (Placement(transformation(
              origin={-29,59},
              extent={{-5.00001,-29},{5.00001,29}},
              rotation=270)));
        AixLib.Building.Components.Walls.Wall inside_wall1(
          T0=T0_IW1,
          outside=false,
          WallType=Type_IWload,
          wall_length=room_length,
          wall_height=room_height_long,
          withWindow=false,
          withDoor=false) annotation (Placement(transformation(
              origin={61,4.00001},
              extent={{-4.99999,-30},{5,30}},
              rotation=180)));
        AixLib.Building.Components.Walls.Wall inside_wall2(
          T0=T0_IW2,
          outside=false,
          WallType=Type_IWsimple,
          wall_length=room_width_long,
          wall_height=0.5*(room_height_long + room_height_short +
              room_width_short/room_width_long*(room_height_long -
              room_height_short)),
          withWindow=false,
          withDoor=false) annotation (Placement(transformation(
              origin={32,-59},
              extent={{-4.99998,-28},{4.99998,28}},
              rotation=90)));
        AixLib.Building.Components.DryAir.Airload airload(V=room_V, T(start=
               T0_air)) annotation (Placement(transformation(extent={{0,-20},
                  {20,0}}, rotation=0)));
        AixLib.Building.Components.Walls.Wall Ceiling(
          T0=T0_CE,
          outside=false,
          WallType=Type_CE,
          wall_length=room_length,
          wall_height=room_width_short,
          withWindow=false,
          withDoor=false,
          ISOrientation=3) annotation (Placement(transformation(
              origin={22,60},
              extent={{1.99999,-10},{-1.99998,10}},
              rotation=90)));
        AixLib.Building.Components.Walls.Wall floor(
          T0=T0_FL,
          outside=false,
          WallType=Type_FL,
          wall_length=room_length,
          wall_height=room_width_long,
          withWindow=false,
          withDoor=false,
          ISOrientation=2) if withFloorHeating == false annotation (
            Placement(transformation(
              origin={-27,-60},
              extent={{-2.00002,-11},{2.00001,11}},
              rotation=90)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall2
          annotation (Placement(transformation(extent={{20,-100},{40,-80}},
                rotation=0)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall1
          annotation (Placement(transformation(extent={{80,0},{100,20}}, rotation=0)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermOutside
          annotation (Placement(transformation(extent={{-100,80},{-80,100}},
                rotation=0)));
        Modelica.Blocks.Interfaces.RealInput WindSpeedPort
          annotation (Placement(transformation(extent={{-109.5,-50},{-89.5,-30}},
                rotation=0)));
        Utilities.Interfaces.SolarRad_in SolarRadiationPort_OW1 annotation (
           Placement(transformation(extent={{-109.5,20},{-89.5,40}},
                rotation=0)));
        Utilities.Interfaces.SolarRad_in SolarRadiationPort_OW2 annotation (
           Placement(transformation(
              origin={44.5,101},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling
          annotation (Placement(transformation(extent={{80,60},{100,80}}, rotation=
                  0)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermRoom annotation (
            Placement(transformation(extent={{-30,10},{-10,30}}),
              iconTransformation(extent={{-30,10},{-10,30}})));
        Utilities.Interfaces.Star starRoom annotation (Placement(
              transformation(extent={{10,10},{30,30}}), iconTransformation(
                extent={{10,10},{30,30}})));
        Modelica.Blocks.Interfaces.RealInput AirExchangePort annotation (
            Placement(transformation(
              extent={{-13,-13},{13,13}},
              rotation=270,
              origin={-20,100}), iconTransformation(
              extent={{-10.5,-10.5},{10.5,10.5}},
              rotation=270,
              origin={-20.5,98.5})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor
          annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));
        AixLib.Building.Components.Walls.Wall roof(
          T0=T0_RO,
          solar_absorptance=solar_absorptance_RO,
          wall_length=room_length,
          withDoor=false,
          door_height=0,
          door_width=0,
          wall_height=roof_width,
          withWindow=withWindow3,
          windowarea=windowarea_RO,
          WallType=Type_RO,
          WindowType=Type_Win) annotation (Placement(transformation(
              origin={55,59},
              extent={{-2.99995,-17},{2.99997,17}},
              rotation=270)));
        Utilities.Interfaces.SolarRad_in SolarRadiationPort_Roof
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={74,100})));
        Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor Tair
          annotation (Placement(transformation(extent={{24,-20},{38,-6}})));
        AixLib.Building.Components.DryAir.InfiltrationRate_DIN12831
          infiltrationRate(
          room_V=room_V,
          n50=n50,
          e=e,
          eps=eps) annotation (Placement(transformation(extent={{-72,36},{-54,
                  44}})));
        AixLib.Building.Components.DryAir.DynamicVentilation
          dynamicVentilation(
          HeatingLimit=HeatingLimit,
          Max_VR=Max_VR,
          Diff_toTempset=Diff_toTempset,
          Tset=Tset) if withDynamicVentilation annotation (Placement(
              transformation(extent={{-70,-68},{-46,-56}})));
        Utilities.Interfaces.Adaptors.HeatStarToComb thermStar_Demux
          annotation (Placement(transformation(
              extent={{-10,8},{10,-8}},
              rotation=90,
              origin={-20,-26})));
        AixLib.Building.Components.DryAir.VarAirExchange NaturalVentilation(
            V=room_V) annotation (Placement(transformation(extent={{-68,-50},
                  {-48,-30}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor1 if
                                               withFloorHeating
          "thermal connector for floor heating" annotation (Placement(
              transformation(extent={{-8,-58},{2,-48}}), iconTransformation(extent=
                  {{-32,-34},{-12,-14}})));
        AixLib.Building.Components.Walls.BaseClasses.SimpleNLayer floor_FH(
          l=room_length,
          n=Type_FL.n,
          d=Type_FL.d,
          rho=Type_FL.rho,
          lambda=Type_FL.lambda,
          c=Type_FL.c,
          T0=T0_FL,
          h=room_width_long) if withFloorHeating
          "floor component if using Floor heating" annotation (Placement(
              transformation(
              origin={-6,-67},
              extent={{-3.00007,16},{3,-16}},
              rotation=90)));
      equation

          // Connect equations for dynamic ventilation
          if withDynamicVentilation then
          connect(thermOutside, dynamicVentilation.port_outside);
          connect(dynamicVentilation.port_inside, airload.port);
          end if;

          //Connect floor for cases with or without floor heating
          if withFloorHeating then

          else
          connect(floor.port_outside, thermFloor) annotation (Line(
              points={{-27,-62.1},{-27,-82},{-30,-82},{-30,-90}},
              color={191,0,0},
              smooth=Smooth.None,
              pattern=LinePattern.Dash));
          connect(floor.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{-27,-58},{-27,-40},{-20.1,-40},{-20.1,-35.4}},
              color={191,0,0},
              smooth=Smooth.None,
              pattern=LinePattern.Dash));
          end if;

        connect(outside_wall1.WindSpeedPort,WindSpeedPort)   annotation (Line(
              points={{-64.25,24.2667},{-80,24.2667},{-80,-40},{-99.5,-40}},
                                                            color={0,0,127}));
        connect(inside_wall2.port_outside, thermInsideWall2) annotation (Line(
            points={{32,-64.25},{32,-72},{30,-72},{30,-90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(thermInsideWall2,thermInsideWall2)  annotation (Line(
            points={{30,-90},{30,-90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(inside_wall1.port_outside, thermInsideWall1) annotation (Line(
            points={{66.25,4.00001},{90,4.00001},{90,10}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(Ceiling.port_outside, thermCeiling) annotation (Line(
            points={{22,62.1},{22,70},{90,70}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(outside_wall2.WindSpeedPort,WindSpeedPort)  annotation (Line(
            points={{-7.73333,64.25},{-7.73333,68},{-7.73333,70},{-80,70},{-80,
                -40},{-99.5,-40}},
            color={0,0,127},
            smooth=Smooth.None));

        connect(airload.port, Tair.port) annotation (Line(
            points={{1,-12},{-6,-12},{-6,-40},{24,-40},{24,-13}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(thermOutside,infiltrationRate.port_a)  annotation (Line(
            points={{-90,90},{-90,80},{-80,80},{-80,40},{-72,40},{-72,40}},
            color={191,0,0},
            smooth=Smooth.None));

        connect(SolarRadiationPort_OW1, outside_wall1.SolarRadiationPort)
          annotation (Line(
            points={{-99.5,30},{-65.5,30},{-65.5,29.5833}},
            color={255,128,0},
            smooth=Smooth.None));
        connect(outside_wall2.SolarRadiationPort, SolarRadiationPort_OW2)
          annotation (Line(
            points={{-2.41667,65.5},{-2.41667,70},{44.5,70},{44.5,92},{44.5,101}},
            color={255,128,0},
            smooth=Smooth.None));
        connect(roof.SolarRadiationPort, SolarRadiationPort_Roof) annotation (Line(
            points={{70.5833,62.8999},{70.5833,70},{74,70},{74,100}},
            color={255,128,0},
            smooth=Smooth.None));
        connect(roof.port_outside, thermOutside) annotation (Line(
            points={{55,62.1499},{55,70},{-80,70},{-80,80},{-90,80},{-90,90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(outside_wall1.port_outside, thermOutside) annotation (Line(
            points={{-64.25,3},{-70,2},{-80,2},{-80,80},{-90,80},{-90,90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(outside_wall2.port_outside, thermOutside) annotation (Line(
            points={{-29,64.25},{-29,70},{-80,70},{-80,80},{-90,80},{-90,90}},
            color={191,0,0},
            smooth=Smooth.None));

        connect(outside_wall1.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{-54,3},{-40,3},{-40,-40},{-20.1,-40},{-20.1,-35.4}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(outside_wall2.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{-29,54},{-29,40},{-40,40},{-40,-40},{-20.1,-40},{-20.1,
                -35.4}},
            color={191,0,0},
            smooth=Smooth.None));

        connect(Ceiling.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{22,58},{22,40},{-40,40},{-40,-40},{-20.1,-40},{-20.1,-35.4}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(roof.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{55,56},{55,40},{-40,40},{-40,-40},{-20.1,-40},{-20.1,-35.4}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(starRoom, thermStar_Demux.star) annotation (Line(
            points={{20,20},{20,4},{-14.2,4},{-14.2,-15.6}},
            color={95,95,95},
            pattern=LinePattern.None,
            smooth=Smooth.None));
        connect(thermStar_Demux.therm, thermRoom) annotation (Line(
            points={{-25.1,-15.9},{-25.1,6},{-20,6},{-20,20}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(thermStar_Demux.therm, airload.port) annotation (Line(
            points={{-25.1,-15.9},{-25.1,-12},{1,-12}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(inside_wall1.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{56,4.00001},{40,4.00001},{40,-40},{-20.1,-40},{-20.1,-35.4}},
            color={191,0,0},
            smooth=Smooth.None));

        connect(inside_wall2.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{32,-54},{32,-40},{-20.1,-40},{-20.1,-35.4}},
            color={191,0,0},
            smooth=Smooth.None));

        connect(infiltrationRate.port_b, airload.port) annotation (Line(
            points={{-54,40},{-40,40},{-40,-40},{-6,-40},{-6,-12},{1,-12}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(NaturalVentilation.InPort1, AirExchangePort) annotation (Line(
            points={{-67,-46.4},{-80,-46.4},{-80,70},{-20,70},{-20,100}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(NaturalVentilation.port_a, thermOutside) annotation (Line(
            points={{-68,-40},{-80,-40},{-80,90},{-90,90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(NaturalVentilation.port_b, airload.port) annotation (Line(
            points={{-48,-40},{-6,-40},{-6,-12},{1,-12}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(roof.WindSpeedPort, WindSpeedPort) annotation (Line(
            points={{67.4667,62.1499},{67.4667,70},{-80,70},{-80,-40},{-99.5,
                -40}},
            color={0,0,127},
            smooth=Smooth.None));

        connect(floor_FH.port_b, thermFloor1)
                                             annotation (Line(
            points={{-7.6,-64.3},{-7.6,-53},{-3,-53}},
            color={191,0,0},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        connect(floor_FH.port_a, thermFloor) annotation (Line(
            points={{-7.6,-69.7001},{-7.6,-90},{-30,-90}},
            color={191,0,0},
            pattern=LinePattern.Dash,
            smooth=Smooth.None));
       annotation (__Dymola_Images(Parameters(source="AixLib/Images/House/OW2_1IWl_1IWs_1Pa_1At1Ro.png", Width = 5, Length = 5)),
                    Icon(graphics={
              Rectangle(
                extent={{-80,80},{80,60}},
                lineColor={0,0,0},
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{0,80},{-50,60}},
                lineColor={0,0,0},
                fillColor={170,213,255},
                fillPattern=FillPattern.Solid,
                visible = withWindow2),
              Rectangle(
                extent={{6,64},{-6,-64}},
                lineColor={0,0,0},
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid,
                origin={74,-4},
                rotation=0),
              Rectangle(
                extent={{-60,60},{68,-68}},
                lineColor={0,0,0},
                fillColor={47,102,173},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-80,60},{-60,-80}},
                lineColor={0,0,0},
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-60,-68},{80,-80}},
                lineColor={0,0,0},
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{20,80},{40,60}},
                lineColor={0,0,0},
                fillColor={127,127,0},
                fillPattern=FillPattern.Solid,
                visible=withDoor2),
              Text(
                extent={{20,74},{40,66}},
                lineColor={255,255,255},
                fillColor={255,170,170},
                fillPattern=FillPattern.Solid,
                textString="D2",
                visible = withDoor2),
              Text(
                extent={{-50,76},{0,64}},
                lineColor={255,255,255},
                fillColor={255,170,170},
                fillPattern=FillPattern.Solid,
                textString="Win2",
                visible = withWindow2),
              Text(
                extent={{-56,52},{64,40}},
                lineColor={255,255,255},
                fillColor={255,170,170},
                fillPattern=FillPattern.Solid,
                textString="width"),
              Line(
                points={{38,46},{68,46}},
                color={255,255,255},
                smooth=Smooth.None),
              Line(
                points={{-60,46},{-30,46}},
                color={255,255,255},
                smooth=Smooth.None),
              Text(
                extent={{-120,6},{0,-6}},
                lineColor={255,255,255},
                fillColor={255,170,170},
                fillPattern=FillPattern.Solid,
                origin={-46,56},
                rotation=90,
                textString="length"),
              Line(
                points={{-46,60},{-46,30}},
                color={255,255,255},
                smooth=Smooth.None),
              Line(
                points={{-46,-42},{-46,-68}},
                color={255,255,255},
                smooth=Smooth.None),
              Rectangle(
                extent={{-80,30},{-60,-20}},
                lineColor={0,0,0},
                fillColor={170,213,255},
                fillPattern=FillPattern.Solid,
                visible = withWindow3),
              Text(
                extent={{-25,6},{25,-6}},
                lineColor={255,255,255},
                fillColor={255,170,170},
                fillPattern=FillPattern.Solid,
                textString="Win3",
                origin={-70,5},
                rotation=90,
                visible = withWindow3)}),
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                  100}}),
                  graphics),
          Documentation(revisions="<html>
<p><ul>
<li><i>April 18, 2014</i> by Ana Constantin:<br/>Added documentation</li>
<li><i>July 8, 2011</i> by Ana Constantin:<br/>Implemented</li>
</ul></p>
</html>",     info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Model for a room with 2&nbsp;outer&nbsp;walls,&nbsp;1&nbsp;inner&nbsp;wall&nbsp;load,&nbsp;1&nbsp;inner&nbsp;wall&nbsp;simple,&nbsp;1&nbsp;floor&nbsp;towards&nbsp;lower&nbsp;floor,&nbsp;1&nbsp;ceiling&nbsp;towards&nbsp;attic,&nbsp;1&nbsp;roof&nbsp;towards&nbsp;outside.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The following figure presents the room&apos;s layout:</p>
<p><img src=\"modelica://AixLib/Images/House/OW2_1IWl_1IWs_1Pa_1At1Ro.png\"/></p>
</html>"));
      end Ow2IwL1IwS1Lf1At1Ro1;

      model Ow2IwL2IwS1Lf1At1Ro1
        "2 outer walls, 2 inner walls load, 1 inner wall simple, 1 floor towards lower floor, 1 ceiling towards attic, 1 roof towards outside"
        import AixLib;

        ///////// construction parameters
        parameter Integer TMC =  1 "Themal Mass Class"
          annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice=1 "S", choice = 2 "M", choice = 3 "L", radioButtons = true));
        parameter Integer TIR = 1 "Thermal Insulation Regulation"
         annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice=1
              "EnEV_2009",                                                                                                    choice = 2
              "EnEV_2002",                                                                                                    choice = 3
              "WSchV_1995",  choice = 4 "WSchV_1984",                                                                          radioButtons = true));

        parameter Boolean withFloorHeating = false
          "If true, that floor has different connectors" annotation (Dialog(group = "Construction parameters"), choices(checkBox=true));

        parameter Modelica.SIunits.Temperature T0_air=295.11 "Air"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_OW1=295.15 "OW1"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_OW2=295.15 "OW2"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_IW1a=295.15 "IW1a"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_IW1b=295.15 "IW1b"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_IW2=295.15 "IW2"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_CE=295.10 "Ceiling"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_RO=295.15 "Roof"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_FL=295.12 "Floor"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));

       //////////room geometry
       parameter Modelica.SIunits.Length room_length=2 "length " annotation (Dialog(group = "Dimensions", descriptionLabel = true));
       parameter Modelica.SIunits.Length room_lengthb=2 "length_b " annotation (Dialog(group = "Dimensions", descriptionLabel = true));
       parameter Modelica.SIunits.Length room_width_long=2 "w1 " annotation (Dialog(group = "Dimensions", descriptionLabel = true));
       parameter Modelica.SIunits.Length room_width_short=2 "w2 " annotation (Dialog(group = "Dimensions", descriptionLabel = true));
       parameter Modelica.SIunits.Height room_height_long=2 "h1 " annotation (Dialog(group = "Dimensions", descriptionLabel = true));
       parameter Modelica.SIunits.Height room_height_short=2 "h2 " annotation (Dialog(group = "Dimensions", descriptionLabel = true));
       parameter Modelica.SIunits.Length roof_width = 2 "wRO" annotation (Dialog(group = "Dimensions", descriptionLabel = true));

       // Outer walls properties
       parameter Real solar_absorptance_OW=0.25 "Solar absoptance outer walls "
                                                                               annotation (Dialog(group = "Outer wall properties", descriptionLabel = true));
       parameter Real solar_absorptance_RO=0.25 "Solar absoptance roof "
                                                                        annotation (Dialog(group = "Outer wall properties", descriptionLabel = true));
       parameter Integer ModelConvOW =  1 "Heat Convection Model"
         annotation(Dialog(group = "Outer wall properties", compact = true, descriptionLabel = true), choices(choice = 1
              "DIN 6946",                                                                                                    choice = 2
              "ASHRAE Fundamentals",                                                                                                    choice = 3
              "Custom alpha",                                                                                                    radioButtons = true));

       // Windows and Doors
       parameter Boolean withWindow2 = true "Window 2" annotation (Dialog(group = "Windows and Doors", joinNext = true, descriptionLabel = true), choices(checkBox=true));
       parameter Modelica.SIunits.Area windowarea_OW2=0 "Window area " annotation (Dialog(group = "Windows and Doors", descriptionLabel = true, enable = withWindow2));
       parameter Boolean withWindow3 = true "Window 3 " annotation (Dialog(group = "Windows and Doors", joinNext = true, descriptionLabel = true), choices(checkBox=true));
       parameter Modelica.SIunits.Area windowarea_RO=0 "Window area" annotation (Dialog(group = "Windows and Doors", naturalWidth = 10, descriptionLabel = true, enable = withWindow3));
       parameter Boolean withDoor2 = true "Door 2" annotation (Dialog( group = "Windows and Doors", joinNext = true, descriptionLabel = true), choices(checkBox=true));
       parameter Modelica.SIunits.Length door_width_OD2=0 "width " annotation (Dialog(group = "Windows and Doors", joinNext = true, descriptionLabel = true, enable = withDoor2));
       parameter Modelica.SIunits.Length door_height_OD2=0 "height " annotation (Dialog(group = "Windows and Doors", descriptionLabel = true, enable = withDoor2));

      // Dynamic Ventilation
      parameter Boolean withDynamicVentilation = false "Dynamic ventilation" annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true), choices(checkBox=true));
      parameter Modelica.SIunits.Temperature HeatingLimit = 288.15
          "Outside temperature at which the heating activates"
                                                             annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true,  enable = if withDynamicVentilation then true else false));
      parameter Real Max_VR = 10 "Maximal ventilation rate" annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true,  enable = if withDynamicVentilation then true else false));
      parameter Modelica.SIunits.TemperatureDifference Diff_toTempset = 2
          "Difference to set temperature" annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true,  enable = if withDynamicVentilation then true else false));
      parameter Modelica.SIunits.Temperature Tset = 295.15 "Tset"
                 annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true,  enable = if withDynamicVentilation then true else false));

        //Door properties
      protected
       parameter Real U_door_OD2=if TIR == 1 then 1.8 else  2.9 "U-value" annotation (Dialog(group = "Windows and Doors", joinNext = true, descriptionLabel = true, enable = withDoor2));
       parameter Real eps_door_OD2=0.95 "eps" annotation (Dialog(group = "Windows and Doors", descriptionLabel = true, enable = withDoor2));

        // Infiltration rate
        parameter Real n50(unit="h-1")=
        if (TIR == 1 or TIR ==2) then 3 else
        if TIR == 3 then 4 else 6
          "Air exchange rate at 50 Pa pressure difference" annotation (Dialog(tab = "Infiltration"));
        parameter Real e=0.03 "Coefficient of windshield" annotation (Dialog(tab = "Infiltration"));
        parameter Real eps=1.0 "Coefficient of height" annotation (Dialog(tab = "Infiltration"));

        // Outer wall type
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_OW=if TIR
             == 1 then if TMC == 1 then
            AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S() else if TMC == 2
             then AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_M() else
            AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_L() else if TIR == 2
             then if TMC == 1 then
            AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_S() else if TMC == 2
             then AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_M() else
            AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_L() else if TIR == 3
             then if TMC == 1 then
            AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_S() else if TMC ==
            2 then AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_M() else
            AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_L() else if TMC ==
            1 then AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_S() else if
            TMC == 2 then AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_M()
             else AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_L()
          annotation (Dialog(tab="Types"));

        //Inner wall Types
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_IWsimple=
            if TIR == 1 then if TMC == 1 then
            AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_S_half() else
            if TMC == 2 then
            AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_M_half() else
            AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_L_half() else
            if TIR == 2 then if TMC == 1 then
            AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_S_half() else
            if TMC == 2 then
            AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_M_half() else
            AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_L_half() else
            if TIR == 3 then if TMC == 1 then
            AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_S_half()
             else if TMC == 2 then
            AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_M_half()
             else AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_L_half()
             else if TMC == 1 then
            AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_S_half()
             else if TMC == 2 then
            AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_M_half()
             else AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_L_half()
          annotation (Dialog(tab="Types"));

        parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_IWload=if
            TIR == 1 then if TMC == 1 then
            AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half() else if
            TMC == 2 then
            AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_M_half() else
            AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_L_half() else if
            TIR == 2 then if TMC == 1 then
            AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_S_half() else if
            TMC == 2 then
            AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_M_half() else
            AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_L_half() else if
            TIR == 3 then if TMC == 1 then
            AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_S_half() else
            if TMC == 2 then
            AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_M_half() else
            AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_L_half() else
            if TMC == 1 then
            AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_S_half() else
            if TMC == 2 then
            AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_M_half() else
            AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_L_half()
          annotation (Dialog(tab="Types"));

         // Floor to lower floor type
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_FL=if TIR
             == 1 then if (TMC == 1 or TMC == 2) then
            AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_SM_upHalf()
             else
            AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_L_upHalf()
             else if TIR == 2 then if (TMC == 1 or TMC == 2) then
            AixLib.DataBase.Walls.EnEV2002.Floor.FLpartition_EnEV2002_SM_upHalf()
             else
            AixLib.DataBase.Walls.EnEV2002.Floor.FLpartition_EnEV2002_L_upHalf()
             else if TIR == 3 then if (TMC == 1 or TMC == 2) then
            AixLib.DataBase.Walls.WSchV1995.Floor.FLpartition_WSchV1995_SM_upHalf()
             else
            AixLib.DataBase.Walls.WSchV1995.Floor.FLpartition_WSchV1995_L_upHalf()
             else if (TMC == 1 or TMC == 2) then
            AixLib.DataBase.Walls.WSchV1984.Floor.FLpartition_WSchV1984_SM_upHalf()
             else
            AixLib.DataBase.Walls.WSchV1984.Floor.FLpartition_WSchV1984_L_upHalf()
          annotation (Dialog(tab="Types"));

        // Ceiling to attic type
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_CE=if TIR
             == 1 then
            AixLib.DataBase.Walls.EnEV2009.Ceiling.CEattic_EnEV2009_SML_loHalf()
             else if TIR == 2 then
            AixLib.DataBase.Walls.EnEV2002.Ceiling.CEattic_EnEV2002_SML_loHalf()
             else if TIR == 3 then
            AixLib.DataBase.Walls.WSchV1995.Ceiling.CEattic_WSchV1995_SML_loHalf()
             else
            AixLib.DataBase.Walls.WSchV1984.Ceiling.CEattic_WSchV1984_SML_loHalf()
          annotation (Dialog(tab="Types"));

         // Saddle roof type
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_RO=if TIR
             == 1 then
            AixLib.DataBase.Walls.EnEV2009.Ceiling.ROsaddleRoom_EnEV2009_SML()
             else if TIR == 2 then
            AixLib.DataBase.Walls.EnEV2002.Ceiling.ROsaddleRoom_EnEV2002_SML()
             else if TIR == 3 then
            AixLib.DataBase.Walls.WSchV1995.Ceiling.ROsaddleRoom_WSchV1995_SML()
             else
            AixLib.DataBase.Walls.WSchV1984.Ceiling.ROsaddleRoom_WSchV1984_SML()
          annotation (Dialog(tab="Types"));

         //Window type
        parameter
          AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple
          Type_Win=if TIR == 1 then
            AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009() else
            if TIR == 2 then
            AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2002() else
            if TIR == 3 then
            AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1995() else
            AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1984()
          annotation (Dialog(tab="Types"));

          parameter Modelica.SIunits.Volume room_V=room_length*room_width_long*room_height_long - room_length*(room_width_long-room_width_short)*(room_height_long-room_height_short)*0.5;

      public
        AixLib.Building.Components.Walls.Wall outside_wall1(
          solar_absorptance=solar_absorptance_OW,
          T0=T0_OW1,
          wall_length=room_length,
          wall_height=room_height_short,
          withWindow=false,
          windowarea=0,
          withDoor=false,
          door_height=0,
          door_width=0,
          WallType=Type_OW) annotation (Placement(transformation(extent={{-64,
                  -24},{-54,32}}, rotation=0)));
        AixLib.Building.Components.Walls.Wall outside_wall2(
          solar_absorptance=solar_absorptance_OW,
          windowarea=windowarea_OW2,
          T0=T0_OW2,
          door_height=door_height_OD2,
          door_width=door_width_OD2,
          withWindow=withWindow2,
          withDoor=withDoor2,
          wall_length=room_width_long,
          wall_height=0.5*(room_height_long + room_height_short +
              room_width_short/room_width_long*(room_height_long -
              room_height_short)),
          WallType=Type_OW,
          WindowType=Type_Win,
          U_door=U_door_OD2,
          eps_door=eps_door_OD2) annotation (Placement(transformation(
              origin={-25,58},
              extent={{-6,-33},{6,33}},
              rotation=270)));
        AixLib.Building.Components.Walls.Wall inside_wall1a(
          T0=T0_IW1a,
          outside=false,
          WallType=Type_IWload,
          wall_length=room_length - room_lengthb,
          wall_height=room_height_long,
          withWindow=false,
          withDoor=false) annotation (Placement(transformation(
              origin={60,19},
              extent={{-2,-15},{2,15}},
              rotation=180)));
        AixLib.Building.Components.Walls.Wall inside_wall2(
          T0=T0_IW2,
          outside=false,
          WallType=Type_IWsimple,
          wall_length=room_width_long,
          wall_height=0.5*(room_height_long + room_height_short +
              room_width_short/room_width_long*(room_height_long -
              room_height_short)),
          withWindow=false,
          withDoor=false) annotation (Placement(transformation(
              origin={28,-60},
              extent={{-4.00002,-26},{4.00001,26}},
              rotation=90)));
        AixLib.Building.Components.DryAir.Airload airload(V=room_V, T(start=
               T0_air)) annotation (Placement(transformation(extent={{0,-20},
                  {20,0}}, rotation=0)));
        AixLib.Building.Components.Walls.Wall Ceiling(
          T0=T0_CE,
          outside=false,
          WallType=Type_CE,
          wall_length=room_length,
          wall_height=room_width_short,
          withWindow=false,
          withDoor=false,
          ISOrientation=3) annotation (Placement(transformation(
              origin={28,60},
              extent={{1.99999,-10},{-1.99998,10}},
              rotation=90)));
        AixLib.Building.Components.Walls.Wall floor(
          T0=T0_FL,
          outside=false,
          WallType=Type_FL,
          wall_length=room_length,
          wall_height=room_width_long,
          withWindow=false,
          withDoor=false,
          ISOrientation=2) if withFloorHeating == false annotation (
            Placement(transformation(
              origin={-24,-60},
              extent={{-1.99999,-10},{1.99999,10}},
              rotation=90)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall2
          annotation (Placement(transformation(extent={{20,-100},{40,-80}},
                rotation=0), iconTransformation(extent={{20,-100},{40,-80}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall1a
          annotation (Placement(transformation(extent={{80,0},{100,20}}, rotation=0)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermOutside
          annotation (Placement(transformation(extent={{-100,80},{-80,100}},
                rotation=0)));
        Modelica.Blocks.Interfaces.RealInput WindSpeedPort
          annotation (Placement(transformation(extent={{-109.5,-60},{-89.5,-40}},
                rotation=0)));
        Utilities.Interfaces.SolarRad_in SolarRadiationPort_OW1 annotation (
           Placement(transformation(extent={{-109.5,20},{-89.5,40}},
                rotation=0)));
        Utilities.Interfaces.SolarRad_in SolarRadiationPort_OW2 annotation (
           Placement(transformation(
              origin={44.5,101},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling
          annotation (Placement(transformation(extent={{80,40},{100,60}}, rotation=
                  0)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermRoom annotation (
            Placement(transformation(extent={{-30,10},{-10,30}}),
              iconTransformation(extent={{-30,10},{-10,30}})));
        Utilities.Interfaces.Star starRoom annotation (Placement(
              transformation(extent={{10,10},{30,30}}), iconTransformation(
                extent={{10,10},{30,30}})));
        Modelica.Blocks.Interfaces.RealInput AirExchangePort annotation (
            Placement(transformation(
              extent={{-13,-13},{13,13}},
              rotation=270,
              origin={-28,100}), iconTransformation(
              extent={{-10.5,-10.5},{10.5,10.5}},
              rotation=270,
              origin={-26.5,96.5})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor annotation (
            Placement(transformation(extent={{-40,-100},{-20,-80}}),
              iconTransformation(extent={{-40,-100},{-20,-80}})));
        AixLib.Building.Components.Walls.Wall roof(
          T0=T0_RO,
          solar_absorptance=solar_absorptance_RO,
          wall_length=room_length,
          withDoor=false,
          door_height=0,
          door_width=0,
          wall_height=roof_width,
          withWindow=withWindow3,
          windowarea=windowarea_RO,
          WallType=Type_RO,
          WindowType=Type_Win) annotation (Placement(transformation(
              origin={59,59},
              extent={{-3.00001,-17},{3.00002,17}},
              rotation=270)));
        Utilities.Interfaces.SolarRad_in SolarRadiationPort_Roof
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={74,100})));
        AixLib.Building.Components.Walls.Wall inside_wall1b(
          T0=T0_IW1b,
          outside=false,
          WallType=Type_IWload,
          wall_length=room_lengthb,
          wall_height=room_height_long,
          withWindow=false,
          withDoor=false) annotation (Placement(transformation(
              origin={60,-19},
              extent={{-2,-15},{2,15}},
              rotation=180)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall1b
          annotation (Placement(transformation(extent={{80,-40},{100,-20}},
                rotation=0)));
        Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor Tair
          annotation (Placement(transformation(extent={{22,-20},{36,-6}})));
        AixLib.Building.Components.DryAir.InfiltrationRate_DIN12831
          infiltrationRate(
          room_V=room_V,
          n50=n50,
          e=e,
          eps=eps) annotation (Placement(transformation(extent={{-72,42},{-54,
                  50}})));
        AixLib.Building.Components.DryAir.DynamicVentilation
          dynamicVentilation(
          HeatingLimit=HeatingLimit,
          Max_VR=Max_VR,
          Diff_toTempset=Diff_toTempset,
          Tset=Tset) if withDynamicVentilation annotation (Placement(
              transformation(extent={{-70,-66},{-46,-54}})));
        Utilities.Interfaces.Adaptors.HeatStarToComb thermStar_Demux
          annotation (Placement(transformation(
              extent={{-10,8},{10,-8}},
              rotation=90,
              origin={-20,-26})));
        AixLib.Building.Components.DryAir.VarAirExchange NaturalVentilation(
            V=room_V) annotation (Placement(transformation(extent={{-68,-50},
                  {-48,-30}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor1 if
                                               withFloorHeating
          "thermal connector for floor heating" annotation (Placement(
              transformation(extent={{-8,-58},{2,-48}}), iconTransformation(extent=
                  {{-32,-34},{-12,-14}})));
        AixLib.Building.Components.Walls.BaseClasses.SimpleNLayer floor_FH(
          l=room_length,
          n=Type_FL.n,
          d=Type_FL.d,
          rho=Type_FL.rho,
          lambda=Type_FL.lambda,
          c=Type_FL.c,
          T0=T0_FL,
          h=room_width_long) if withFloorHeating
          "floor component if using Floor heating" annotation (Placement(
              transformation(
              origin={-6,-67},
              extent={{-3.00007,16},{3,-16}},
              rotation=90)));
      equation

          // Connect equations for dynamic ventilation
          if withDynamicVentilation then
          connect(thermOutside, dynamicVentilation.port_outside);
          connect(dynamicVentilation.port_inside, airload.port);
          end if;

          //Connect floor for cases with or without floor heating
          if withFloorHeating then
            connect(floor_FH.port_b, thermFloor1)
                                             annotation (Line(
            points={{-7.6,-64.3},{-7.6,-53},{-3,-53}},
            color={191,0,0},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
            connect(thermFloor,floor_FH.port_a)  annotation (Line(
            points={{-30,-90},{-6,-90},{-6,-69.7001},{-7.6,-69.7001}},
            color={191,0,0},
            pattern=LinePattern.Dash,
            smooth=Smooth.None));
          else
          connect(floor.port_outside, thermFloor) annotation (Line(
              points={{-24,-62.1},{-24,-74.5},{-30,-74.5},{-30,-90}},
              color={191,0,0},
              smooth=Smooth.None,
              pattern=LinePattern.Dash));
          connect(floor.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{-24,-58},{-24,-40},{-20.1,-40},{-20.1,-38},{-20.1,-35.4}},
              color={191,0,0},
              smooth=Smooth.None,
              pattern=LinePattern.Dash));
          end if;

        connect(outside_wall1.SolarRadiationPort, SolarRadiationPort_OW1)
          annotation (Line(points={{-65.5,29.6667},{-80,29.6667},{-80,30},{
                -99.5,30}},
              color={0,0,0}));
        connect(inside_wall2.port_outside, thermInsideWall2) annotation (Line(
            points={{28,-64.2},{28,-90},{30,-90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(thermInsideWall2,thermInsideWall2)  annotation (Line(
            points={{30,-90},{30,-90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(outside_wall2.WindSpeedPort,WindSpeedPort)  annotation (Line(
            points={{-0.8,64.3},{-0.8,74},{-80,74},{-80,-50},{-99.5,-50}},
            color={0,0,127},
            smooth=Smooth.None));

        connect(inside_wall1b.port_outside, thermInsideWall1b) annotation (Line(
            points={{62.1,-19},{90,-19},{90,-30}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(inside_wall1a.port_outside, thermInsideWall1a) annotation (Line(
            points={{62.1,19},{84,19},{84,20},{90,20},{90,10}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(airload.port, Tair.port) annotation (Line(
            points={{1,-12},{-6,-12},{-6,-40},{22,-40},{22,-13}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(thermRoom, thermStar_Demux.therm) annotation (Line(
            points={{-20,20},{-20,6},{-25.1,6},{-25.1,-15.9}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(starRoom, thermStar_Demux.star) annotation (Line(
            points={{20,20},{20,4},{-14.2,4},{-14.2,-15.6}},
            color={95,95,95},
            pattern=LinePattern.None,
            smooth=Smooth.None));
        connect(infiltrationRate.port_a, thermOutside) annotation (Line(
            points={{-72,46},{-80,46},{-80,82},{-90,82},{-90,90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(outside_wall1.port_outside, thermOutside) annotation (Line(
            points={{-64.25,4},{-80,4},{-80,82},{-90,82},{-90,90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(outside_wall2.port_outside, thermOutside) annotation (Line(
            points={{-25,64.3},{-25,74},{-80,74},{-80,82},{-90,82},{-90,90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(roof.port_outside, thermOutside) annotation (Line(
            points={{59,62.15},{59,74},{-80,74},{-80,82},{-90,82},{-90,90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(roof.SolarRadiationPort, SolarRadiationPort_Roof) annotation (Line(
            points={{74.5833,62.9},{74.5833,92},{74,92},{74,100}},
            color={255,128,0},
            smooth=Smooth.None));
        connect(Ceiling.port_outside, thermCeiling) annotation (Line(
            points={{28,62.1},{28,62.1},{28,74},{90,74},{90,50}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(outside_wall2.SolarRadiationPort, SolarRadiationPort_OW2)
          annotation (Line(
            points={{5.25,65.8},{5.25,74},{44.5,74},{44.5,101}},
            color={255,128,0},
            smooth=Smooth.None));
        connect(outside_wall1.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{-54,4},{-40,4},{-40,-40},{-20,-40},{-20,-38},{-20.1,-35.4}},
            color={191,0,0},
            smooth=Smooth.None));

        connect(inside_wall2.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{28,-56},{28,-40},{-20.1,-40},{-20.1,-38},{-20.1,-35.4}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(inside_wall1b.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{58,-19},{40,-19},{40,-40},{-20.1,-40},{-20.1,-35.4}},
            color={191,0,0},
            smooth=Smooth.None));

        connect(outside_wall2.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{-25,52},{-25,40},{40,40},{40,-40},{-20.1,-40},{-20.1,-35.4}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(roof.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{59,56},{59,40},{40,40},{40,-40},{-20.1,-40},{-20.1,-35.4}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(Ceiling.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{28,58},{28,40},{40,40},{40,-40},{-20.1,-40},{-20.1,-35.4}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(outside_wall1.WindSpeedPort, WindSpeedPort) annotation (Line(
            points={{-64.25,24.5333},{-80,24.5333},{-80,-50},{-99.5,-50}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(thermStar_Demux.therm, airload.port) annotation (Line(
            points={{-25.1,-15.9},{-25.1,-12},{1,-12}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(inside_wall1a.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{58,19},{40,19},{40,-40},{-20.1,-40},{-20.1,-35.4}},
            color={191,0,0},
            smooth=Smooth.None));

        connect(infiltrationRate.port_b, airload.port) annotation (Line(
            points={{-54,46},{-40,46},{-40,-40},{-6,-40},{-6,-12},{1,-12}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(NaturalVentilation.InPort1, AirExchangePort) annotation (Line(
            points={{-67,-46.4},{-80,-46.4},{-80,74},{-28,74},{-28,100}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(NaturalVentilation.port_a, thermOutside) annotation (Line(
            points={{-68,-40},{-80,-40},{-80,90},{-90,90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(NaturalVentilation.port_b, airload.port) annotation (Line(
            points={{-48,-40},{-6,-40},{-6,-12},{1,-12}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(roof.WindSpeedPort, WindSpeedPort) annotation (Line(
            points={{71.4667,62.15},{71.4667,74},{-80,74},{-80,-50},{-99.5,-50}},
            color={0,0,127},
            smooth=Smooth.None));

       annotation (__Dymola_Images(Parameters(source="AixLib/Images/House/OW2_2IWl_1IWs_1Pa_1At1Ro.png", Width = 5, Length = 5)),
                    Icon(graphics={
              Rectangle(
                extent={{-80,80},{80,60}},
                lineColor={0,0,0},
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{0,80},{-50,60}},
                lineColor={0,0,0},
                fillColor={170,213,255},
                fillPattern=FillPattern.Solid,
                visible=withWindow2),
              Rectangle(
                extent={{80,60},{68,-68}},
                lineColor={0,0,0},
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-80,60},{-60,-80}},
                lineColor={0,0,0},
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-60,-68},{80,-80}},
                lineColor={0,0,0},
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{80,60},{68,8}},
                lineColor={0,0,0},
                fillColor={135,135,135},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-80,30},{-60,-20}},
                lineColor={0,0,0},
                fillColor={170,213,255},
                fillPattern=FillPattern.Solid,
                visible=withWindow3),
              Rectangle(
                extent={{-60,60},{68,-68}},
                lineColor={0,0,0},
                fillColor={47,102,173},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-56,52},{64,40}},
                lineColor={255,255,255},
                fillColor={255,170,170},
                fillPattern=FillPattern.Solid,
                textString="width"),
              Line(
                points={{38,46},{68,46}},
                color={255,255,255},
                smooth=Smooth.None),
              Line(
                points={{-46,60},{-46,30}},
                color={255,255,255},
                smooth=Smooth.None),
              Line(
                points={{-60,46},{-30,46}},
                color={255,255,255},
                smooth=Smooth.None),
              Text(
                extent={{-120,6},{0,-6}},
                lineColor={255,255,255},
                fillColor={255,170,170},
                fillPattern=FillPattern.Solid,
                origin={-46,56},
                rotation=90,
                textString="length"),
              Line(
                points={{-46,-42},{-46,-68}},
                color={255,255,255},
                smooth=Smooth.None),
              Rectangle(
                extent={{20,80},{40,60}},
                lineColor={0,0,0},
                fillColor={127,127,0},
                fillPattern=FillPattern.Solid,
                visible = withDoor2),
              Text(
                extent={{-50,76},{0,64}},
                lineColor={255,255,255},
                fillColor={255,170,170},
                fillPattern=FillPattern.Solid,
                textString="Win2",
                visible = withWindow2),
              Text(
                extent={{-25,6},{25,-6}},
                lineColor={255,255,255},
                fillColor={255,170,170},
                fillPattern=FillPattern.Solid,
                textString="Win3",
                origin={-70,5},
                rotation=90,
                visible = withWindow3),
              Text(
                extent={{20,74},{40,66}},
                lineColor={255,255,255},
                fillColor={255,170,170},
                fillPattern=FillPattern.Solid,
                textString="D2",
                visible = withDoor2),
              Line(
                points={{68,8},{54,8}},
                color={255,255,255},
                smooth=Smooth.None),
              Line(
                points={{58,8},{58,0}},
                color={255,255,255},
                smooth=Smooth.None),
              Text(
                extent={{50,6},{-50,-6}},
                lineColor={255,255,255},
                fillColor={255,170,170},
                fillPattern=FillPattern.Solid,
                origin={58,-30},
                rotation=90,
                textString="length_b"),
              Line(
                points={{58,-62},{58,-68}},
                color={255,255,255},
                smooth=Smooth.None)}),
          Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
                  -100},{100,100}}),
                  graphics),
          Documentation(revisions="<html>
<p><ul>
<li><i>April 18, 2014</i> by Ana Constantin:<br/>Added documentation</li>
<li><i>July 8, 2011</i> by Ana Constantin:<br/>Implemented</li>
</ul></p>
</html>",     info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Model for a room with 2&nbsp;outer&nbsp;walls,&nbsp;2&nbsp;inner&nbsp;walls&nbsp;load towards two different rooms but with the same orientation,&nbsp;1&nbsp;inner&nbsp;wall&nbsp;simple,&nbsp;1&nbsp;floor&nbsp;towards&nbsp;lower&nbsp;floor,&nbsp;1&nbsp;ceiling&nbsp;towards&nbsp;attic,&nbsp;1&nbsp;roof&nbsp;towards&nbsp;outside.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The following figure presents the room&apos;s layout:</p>
<p><img src=\"modelica://AixLib/Images/House/OW2_2IWl_1IWs_1Pa_1At1Ro.png\"/></p>
</html>"));
      end Ow2IwL2IwS1Lf1At1Ro1;

      model Ow1IwL2IwS1Lf1At1Ro1
        "1 outer wall, 2 inner walls load, 2 inner walls simple, 1 floor towards lower floor, 1 ceiling towards attic, 1 roof towards outside"
        import AixLib;

        ///////// construction parameters
        parameter Integer TMC =  1 "Themal Mass Class"
          annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice=1 "S", choice = 2 "M", choice = 3 "L", radioButtons = true));
        parameter Integer TIR = 1 "Thermal Insulation Regulation"
         annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice=1
              "EnEV_2009",                                                                                                    choice = 2
              "EnEV_2002",                                                                                                    choice = 3
              "WSchV_1995",  choice = 4 "WSchV_1984",                                                                          radioButtons = true));

        parameter Boolean withFloorHeating = false
          "If true, that floor has different connectors" annotation (Dialog(group = "Construction parameters"), choices(checkBox=true));

        parameter Modelica.SIunits.Temperature T0_air=295.11 "Air"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_OW1=295.15 "OW1"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_IW1=295.15 "IW1"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_IW2a=295.15 "IW2a"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_IW2b=295.15 "IW2b"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_IW3=295.15 "IW3"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_CE=295.10 "Ceiling"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_RO=295.15 "Roof"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_FL=295.12 "Floor"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));

       //////////room geometry
       parameter Modelica.SIunits.Length room_length=2 "length " annotation (Dialog(group = "Dimensions", descriptionLabel = true));
       parameter Modelica.SIunits.Length room_lengthb=2 "length_b " annotation (Dialog(group = "Dimensions", descriptionLabel = true));
       parameter Modelica.SIunits.Length room_width_long=2 "w1 " annotation (Dialog(group = "Dimensions", descriptionLabel = true));
       parameter Modelica.SIunits.Length room_width_short=2 "w2 " annotation (Dialog(group = "Dimensions", descriptionLabel = true));
       parameter Modelica.SIunits.Height room_height_long=2 "h1 " annotation (Dialog(group = "Dimensions", descriptionLabel = true));
       parameter Modelica.SIunits.Height room_height_short=2 "h2 " annotation (Dialog(group = "Dimensions", descriptionLabel = true));
       parameter Modelica.SIunits.Length roof_width = 2 "wRO" annotation (Dialog(group = "Dimensions", descriptionLabel = true));

       // Outer walls properties
       parameter Real solar_absorptance_OW=0.25 "Solar absoptance outer walls "
                                                                               annotation (Dialog(group = "Outer wall properties", descriptionLabel = true));
       parameter Real solar_absorptance_RO=0.25 "Solar absoptance roof "
                                                                        annotation (Dialog(group = "Outer wall properties", descriptionLabel = true));
       parameter Integer ModelConvOW =  1 "Heat Convection Model"
         annotation(Dialog(group = "Outer wall properties", compact = true, descriptionLabel = true), choices(choice = 1
              "DIN 6946",                                                                                                    choice = 2
              "ASHRAE Fundamentals",                                                                                                    choice = 3
              "Custom alpha",                                                                                                    radioButtons = true));

       // Windows and Doors
       parameter Boolean withWindow3 = true "Window 3 " annotation (Dialog(group = "Windows and Doors", joinNext = true, descriptionLabel = true), choices(checkBox=true));
       parameter Modelica.SIunits.Area windowarea_RO=0 "Window area" annotation (Dialog(group = "Windows and Doors", naturalWidth = 10, descriptionLabel = true, enable = if withWindow3 then true else false));

       // Dynamic Ventilation
      parameter Boolean withDynamicVentilation = false "Dynamic ventilation" annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true), choices(checkBox=true));
      parameter Modelica.SIunits.Temperature HeatingLimit = 288.15
          "Outside temperature at which the heating activates"
                                                             annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true,  enable = if withDynamicVentilation then true else false));
      parameter Real Max_VR = 10 "Maximal ventilation rate" annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true,  enable = if withDynamicVentilation then true else false));
      parameter Modelica.SIunits.TemperatureDifference Diff_toTempset = 2
          "Difference to set temperature" annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true,  enable = if withDynamicVentilation then true else false));
      parameter Modelica.SIunits.Temperature Tset = 295.15 "Tset"
                 annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true,  enable = if withDynamicVentilation then true else false));

       // Infiltration rate
      protected
        parameter Real n50(unit="h-1")=
        if (TIR == 1 or TIR ==2) then 3 else
        if TIR == 3 then 4 else 6
          "Air exchange rate at 50 Pa pressure difference" annotation (Dialog(tab = "Infiltration"));
        parameter Real e=0.02 "Coefficient of windshield" annotation (Dialog(tab = "Infiltration"));
        parameter Real eps=1.0 "Coefficient of height" annotation (Dialog(tab = "Infiltration"));

        // Outer wall type
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_OW=if TIR
             == 1 then if TMC == 1 then
            AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S() else if TMC == 2
             then AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_M() else
            AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_L() else if TIR == 2
             then if TMC == 1 then
            AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_S() else if TMC == 2
             then AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_M() else
            AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_L() else if TIR == 3
             then if TMC == 1 then
            AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_S() else if TMC ==
            2 then AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_M() else
            AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_L() else if TMC ==
            1 then AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_S() else if
            TMC == 2 then AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_M()
             else AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_L()
          annotation (Dialog(tab="Types"));

        //Inner wall Types
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_IWsimple=
            if TIR == 1 then if TMC == 1 then
            AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_S_half() else
            if TMC == 2 then
            AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_M_half() else
            AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_L_half() else
            if TIR == 2 then if TMC == 1 then
            AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_S_half() else
            if TMC == 2 then
            AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_M_half() else
            AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_L_half() else
            if TIR == 3 then if TMC == 1 then
            AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_S_half()
             else if TMC == 2 then
            AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_M_half()
             else AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_L_half()
             else if TMC == 1 then
            AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_S_half()
             else if TMC == 2 then
            AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_M_half()
             else AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_L_half()
          annotation (Dialog(tab="Types"));

        parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_IWload=if
            TIR == 1 then if TMC == 1 then
            AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half() else if
            TMC == 2 then
            AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_M_half() else
            AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_L_half() else if
            TIR == 2 then if TMC == 1 then
            AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_S_half() else if
            TMC == 2 then
            AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_M_half() else
            AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_L_half() else if
            TIR == 3 then if TMC == 1 then
            AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_S_half() else
            if TMC == 2 then
            AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_M_half() else
            AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_L_half() else
            if TMC == 1 then
            AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_S_half() else
            if TMC == 2 then
            AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_M_half() else
            AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_L_half()
          annotation (Dialog(tab="Types"));

         // Floor to lower floor type
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_FL=if TIR
             == 1 then if (TMC == 1 or TMC == 2) then
            AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_SM_upHalf()
             else
            AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_L_upHalf()
             else if TIR == 2 then if (TMC == 1 or TMC == 2) then
            AixLib.DataBase.Walls.EnEV2002.Floor.FLpartition_EnEV2002_SM_upHalf()
             else
            AixLib.DataBase.Walls.EnEV2002.Floor.FLpartition_EnEV2002_L_upHalf()
             else if TIR == 3 then if (TMC == 1 or TMC == 2) then
            AixLib.DataBase.Walls.WSchV1995.Floor.FLpartition_WSchV1995_SM_upHalf()
             else
            AixLib.DataBase.Walls.WSchV1995.Floor.FLpartition_WSchV1995_L_upHalf()
             else if (TMC == 1 or TMC == 2) then
            AixLib.DataBase.Walls.WSchV1984.Floor.FLpartition_WSchV1984_SM_upHalf()
             else
            AixLib.DataBase.Walls.WSchV1984.Floor.FLpartition_WSchV1984_L_upHalf()
          annotation (Dialog(tab="Types"));

        // Ceiling to attic type
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_CE=if TIR
             == 1 then
            AixLib.DataBase.Walls.EnEV2009.Ceiling.CEattic_EnEV2009_SML_loHalf()
             else if TIR == 2 then
            AixLib.DataBase.Walls.EnEV2002.Ceiling.CEattic_EnEV2002_SML_loHalf()
             else if TIR == 3 then
            AixLib.DataBase.Walls.WSchV1995.Ceiling.CEattic_WSchV1995_SML_loHalf()
             else
            AixLib.DataBase.Walls.WSchV1984.Ceiling.CEattic_WSchV1984_SML_loHalf()
          annotation (Dialog(tab="Types"));

         // Saddle roof type
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_RO=if TIR
             == 1 then
            AixLib.DataBase.Walls.EnEV2009.Ceiling.ROsaddleRoom_EnEV2009_SML()
             else if TIR == 2 then
            AixLib.DataBase.Walls.EnEV2002.Ceiling.ROsaddleRoom_EnEV2002_SML()
             else if TIR == 3 then
            AixLib.DataBase.Walls.WSchV1995.Ceiling.ROsaddleRoom_WSchV1995_SML()
             else
            AixLib.DataBase.Walls.WSchV1984.Ceiling.ROsaddleRoom_WSchV1984_SML()
          annotation (Dialog(tab="Types"));

         //Window type
        parameter
          AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple
          Type_Win=if TIR == 1 then
            AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009() else
            if TIR == 2 then
            AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2002() else
            if TIR == 3 then
            AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1995() else
            AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1984()
          annotation (Dialog(tab="Types"));

          parameter Modelica.SIunits.Volume room_V=room_length*room_width_long*room_height_long - room_length*(room_width_long-room_width_short)*(room_height_long-room_height_short)*0.5;

      public
        AixLib.Building.Components.Walls.Wall outside_wall1(
          solar_absorptance=solar_absorptance_OW,
          T0=T0_OW1,
          wall_length=room_length,
          wall_height=room_height_short,
          withWindow=false,
          windowarea=0,
          withDoor=false,
          door_height=0,
          door_width=0,
          WallType=Type_OW) annotation (Placement(transformation(extent={{-64,
                  -24},{-54,34}}, rotation=0)));
        AixLib.Building.Components.Walls.Wall inner_wall1(
          T0=T0_IW1,
          outside=false,
          WallType=Type_IWsimple,
          wall_length=room_width_long,
          wall_height=0.5*(room_height_long + room_height_short +
              room_width_short/room_width_long*(room_height_long -
              room_height_short)),
          withWindow=false,
          withDoor=false) annotation (Placement(transformation(
              origin={-14,58},
              extent={{-3.99997,-22},{3.99999,22}},
              rotation=270)));
        AixLib.Building.Components.Walls.Wall inside_wall2a(
          T0=T0_IW2a,
          outside=false,
          WallType=Type_IWload,
          wall_length=room_length - room_lengthb,
          wall_height=room_height_long,
          withWindow=false,
          withDoor=false) annotation (Placement(transformation(
              origin={61,19},
              extent={{-3,-15},{3,15}},
              rotation=180)));
        AixLib.Building.Components.Walls.Wall inside_wall3(
          T0=T0_IW3,
          outside=false,
          WallType=Type_IWsimple,
          wall_length=room_width_long,
          wall_height=0.5*(room_height_long + room_height_short +
              room_width_short/room_width_long*(room_height_long -
              room_height_short)),
          withWindow=false,
          withDoor=false) annotation (Placement(transformation(
              origin={20,-60},
              extent={{-4,-24},{4,24}},
              rotation=90)));
        AixLib.Building.Components.DryAir.Airload airload(V=room_V, T(start=
               T0_air)) annotation (Placement(transformation(extent={{0,-20},
                  {20,0}}, rotation=0)));
        AixLib.Building.Components.Walls.Wall Ceiling(
          T0=T0_CE,
          outside=false,
          WallType=Type_CE,
          wall_length=room_length,
          wall_height=room_width_short,
          withWindow=false,
          withDoor=false,
          ISOrientation=3) annotation (Placement(transformation(
              origin={28,60},
              extent={{1.99999,-10},{-1.99998,10}},
              rotation=90)));
        AixLib.Building.Components.Walls.Wall floor(
          T0=T0_FL,
          outside=false,
          WallType=Type_FL,
          wall_length=room_length,
          wall_height=room_width_long,
          withWindow=false,
          withDoor=false,
          ISOrientation=2) if withFloorHeating == false annotation (
            Placement(transformation(
              origin={-24,-60},
              extent={{-1.99999,-10},{1.99999,10}},
              rotation=90)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall3
          annotation (Placement(transformation(extent={{20,-100},{40,-80}},
                rotation=0), iconTransformation(extent={{20,-100},{40,-80}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall2a
          annotation (Placement(transformation(extent={{80,0},{100,20}}, rotation=0)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermOutside
          annotation (Placement(transformation(extent={{-100,80},{-80,100}},
                rotation=0)));
        Modelica.Blocks.Interfaces.RealInput WindSpeedPort
          annotation (Placement(transformation(extent={{-109.5,-60},{-89.5,-40}},
                rotation=0)));
        Utilities.Interfaces.SolarRad_in SolarRadiationPort_OW1 annotation (
           Placement(transformation(extent={{-109.5,20},{-89.5,40}},
                rotation=0)));
        Modelica.Blocks.Interfaces.RealInput AirExchangePort
          annotation (Placement(transformation(
              origin={-100,-9},
              extent={{-10,-10},{10,10}},
              rotation=0)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling
          annotation (Placement(transformation(extent={{80,40},{100,60}}, rotation=
                  0)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermRoom annotation (
            Placement(transformation(extent={{-30,10},{-10,30}}),
              iconTransformation(extent={{-30,10},{-10,30}})));
        Utilities.Interfaces.Star starRoom annotation (Placement(
              transformation(extent={{10,10},{30,30}}), iconTransformation(
                extent={{10,10},{30,30}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor annotation (
            Placement(transformation(extent={{-40,-100},{-20,-80}}),
              iconTransformation(extent={{-40,-100},{-20,-80}})));
        AixLib.Building.Components.Walls.Wall roof(
          T0=T0_RO,
          solar_absorptance=solar_absorptance_RO,
          wall_length=room_length,
          withDoor=false,
          door_height=0,
          door_width=0,
          wall_height=roof_width,
          withWindow=withWindow3,
          windowarea=windowarea_RO,
          WallType=Type_RO,
          WindowType=Type_Win,
          ISOrientation=1) annotation (Placement(transformation(
              origin={58,59},
              extent={{-2.99997,-16},{2.99999,16}},
              rotation=270)));
        Utilities.Interfaces.SolarRad_in SolarRadiationPort_Roof
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={74,100})));
        AixLib.Building.Components.Walls.Wall inside_wall2b(
          T0=T0_IW2b,
          outside=false,
          WallType=Type_IWload,
          wall_length=room_lengthb,
          wall_height=room_height_long,
          withWindow=false,
          withDoor=false) annotation (Placement(transformation(
              origin={61,-20},
              extent={{-2.99998,-16},{2.99998,16}},
              rotation=180)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall2b
          annotation (Placement(transformation(extent={{80,-40},{100,-20}},
                rotation=0)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermInsideWall1
          annotation (Placement(transformation(extent={{-20,80},{0,100}}),
              iconTransformation(extent={{-20,80},{0,100}})));
        Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor Tair
          annotation (Placement(transformation(extent={{24,-20},{38,-6}})));
        AixLib.Building.Components.DryAir.InfiltrationRate_DIN12831
          infiltrationRate(
          room_V=room_V,
          n50=n50,
          e=e,
          eps=eps) annotation (Placement(transformation(extent={{-72,52},{-54,
                  60}})));
        AixLib.Building.Components.DryAir.DynamicVentilation
          dynamicVentilation(
          HeatingLimit=HeatingLimit,
          Max_VR=Max_VR,
          Diff_toTempset=Diff_toTempset,
          Tset=Tset) if withDynamicVentilation annotation (Placement(
              transformation(extent={{-70,-66},{-46,-54}})));
        Utilities.Interfaces.Adaptors.HeatStarToComb thermStar_Demux
          annotation (Placement(transformation(
              extent={{-10,8},{10,-8}},
              rotation=90,
              origin={-20,-26})));
        AixLib.Building.Components.DryAir.VarAirExchange NaturalVentilation(
            V=room_V) annotation (Placement(transformation(extent={{-68,-50},
                  {-48,-30}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor1 if
                                               withFloorHeating
          "thermal connector for floor heating" annotation (Placement(
              transformation(extent={{-8,-58},{2,-48}}), iconTransformation(extent=
                  {{-32,-34},{-12,-14}})));
        AixLib.Building.Components.Walls.BaseClasses.SimpleNLayer floor_FH(
          l=room_length,
          n=Type_FL.n,
          d=Type_FL.d,
          rho=Type_FL.rho,
          lambda=Type_FL.lambda,
          c=Type_FL.c,
          T0=T0_FL,
          h=room_width_long) if withFloorHeating
          "floor component if using Floor heating" annotation (Placement(
              transformation(
              origin={-6,-67},
              extent={{-3.00007,16},{3,-16}},
              rotation=90)));
      equation

             // Connect equations for dynamic ventilation
          if withDynamicVentilation then
          connect(thermOutside, dynamicVentilation.port_outside);
          connect(dynamicVentilation.port_inside, airload.port);
          end if;

          //Connect floor for cases with or without floor heating
          if withFloorHeating then
            connect(floor_FH.port_b, thermFloor1)
                                             annotation (Line(
            points={{-7.6,-64.3},{-7.6,-53},{-3,-53}},
            color={191,0,0},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        connect(thermFloor,floor_FH.port_a)  annotation (Line(
            points={{-30,-90},{-7.6,-90},{-7.6,-69.7001}},
            color={191,0,0},
            pattern=LinePattern.Dash,
            smooth=Smooth.None));
          else
          connect(floor.port_outside, thermFloor) annotation (Line(
              points={{-24,-62.1},{-24,-74.5},{-30,-74.5},{-30,-90}},
              color={191,0,0},
              smooth=Smooth.None,
              pattern=LinePattern.Dash));
          connect(floor.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{-24,-58},{-24,-40},{-20.1,-40},{-20.1,-35.4}},
              color={191,0,0},
              smooth=Smooth.None,
              pattern=LinePattern.Dash));
          end if;

        connect(outside_wall1.WindSpeedPort,WindSpeedPort)   annotation (Line(
              points={{-64.25,26.2667},{-80,26.2667},{-80,-50},{-99.5,-50}},
                                                            color={0,0,127}));
        connect(outside_wall1.SolarRadiationPort, SolarRadiationPort_OW1)
          annotation (Line(points={{-65.5,31.5833},{-80,31.5833},{-80,30},{
                -99.5,30}},
              color={0,0,0}));
        connect(inside_wall3.port_outside, thermInsideWall3) annotation (Line(
            points={{20,-64.2},{20,-74},{30,-74},{30,-90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(thermInsideWall3,thermInsideWall3)  annotation (Line(
            points={{30,-90},{30,-90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(Ceiling.port_outside, thermCeiling) annotation (Line(
            points={{28,62.1},{28,72},{92,72},{92,50},{90,50}},
            color={191,0,0},
            smooth=Smooth.None));

        connect(inside_wall2b.port_outside, thermInsideWall2b) annotation (Line(
            points={{64.15,-20},{90,-20},{90,-30}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(inside_wall2a.port_outside, thermInsideWall2a) annotation (Line(
            points={{64.15,19},{84,19},{84,20},{90,20},{90,10}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(inner_wall1.port_outside, thermInsideWall1) annotation (Line(
            points={{-14,62.2},{-14,90},{-10,90}},
            color={191,0,0},
            smooth=Smooth.None));

        connect(thermOutside, thermOutside) annotation (Line(
            points={{-90,90},{-90,84},{-90,84},{-90,90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(airload.port, Tair.port) annotation (Line(
            points={{1,-12},{-6,-12},{-6,-40},{24,-40},{24,-13}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(infiltrationRate.port_a, thermOutside) annotation (Line(
            points={{-72,56},{-72,56},{-80,56},{-80,82},{-90,82},{-90,90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(outside_wall1.port_outside, thermOutside) annotation (Line(
            points={{-64.25,5},{-80,5},{-80,82},{-90,82},{-90,90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(roof.SolarRadiationPort, SolarRadiationPort_Roof) annotation (Line(
            points={{72.6667,62.9},{72.6667,72},{74,72},{74,100}},
            color={255,128,0},
            smooth=Smooth.None));
        connect(roof.port_outside, thermOutside) annotation (Line(
            points={{58,62.15},{58,72},{-80,72},{-80,82},{-90,82},{-90,90}},
            color={191,0,0},
            smooth=Smooth.None));

        connect(inside_wall2b.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{58,-20},{40,-20},{40,-40},{-20.1,-40},{-20.1,-35.4}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(inside_wall2a.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{58,19},{40,19},{40,-40},{-20.1,-40},{-20.1,-35.4}},
            color={191,0,0},
            smooth=Smooth.None));

        connect(roof.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{58,56},{58,40},{40,40},{40,-40},{-20.1,-40},{-20.1,-35.4}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(Ceiling.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{28,58},{28,40},{40,40},{40,-40},{-20.1,-40},{-20.1,-35.4}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(inner_wall1.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{-14,54},{-14,40},{40,40},{40,-40},{-20.1,-40},{-20.1,-35.4}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(infiltrationRate.port_b, airload.port) annotation (Line(
            points={{-54,56},{-40,56},{-40,-40},{-6,-40},{-6,-12},{1,-12}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(outside_wall1.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{-54,5},{-40,5},{-40,-40},{-20.1,-40},{-20.1,-35.4}},
            color={191,0,0},
            smooth=Smooth.None));

        connect(inside_wall3.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{20,-56},{20,-40},{-20.1,-40},{-20.1,-35.4}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(starRoom, thermStar_Demux.star) annotation (Line(
            points={{20,20},{20,4},{-14.2,4},{-14.2,-15.6}},
            color={95,95,95},
            pattern=LinePattern.None,
            smooth=Smooth.None));
        connect(thermRoom, thermStar_Demux.therm) annotation (Line(
            points={{-20,20},{-20,3},{-25.1,3},{-25.1,-15.9}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(thermStar_Demux.therm, airload.port) annotation (Line(
            points={{-25.1,-15.9},{-25.1,-12},{1,-12}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(NaturalVentilation.InPort1, AirExchangePort) annotation (Line(
            points={{-67,-46.4},{-80,-46.4},{-80,-9},{-100,-9}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(NaturalVentilation.port_a, thermOutside) annotation (Line(
            points={{-68,-40},{-80,-40},{-80,90},{-90,90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(NaturalVentilation.port_b, airload.port) annotation (Line(
            points={{-48,-40},{-6,-40},{-6,-12},{1,-12}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(roof.WindSpeedPort, WindSpeedPort) annotation (Line(
            points={{69.7333,62.15},{69.7333,72},{-80,72},{-80,-50},{-99.5,-50}},
            color={0,0,127},
            smooth=Smooth.None));

       annotation (__Dymola_Images(Parameters(source="AixLib/Images/House/OW1_2IWl_2IWs_1Pa_1At1Ro.png", Width = 5, Length = 5)),
                    Icon(graphics={
              Rectangle(
                extent={{-80,80},{80,68}},
                lineColor={0,0,0},
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{80,60},{68,-68}},
                lineColor={0,0,0},
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-60,68},{68,-68}},
                lineColor={0,0,0},
                fillColor={47,102,173},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-80,68},{-60,-80}},
                lineColor={0,0,0},
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-60,-68},{80,-80}},
                lineColor={0,0,0},
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-80,50},{-60,0}},
                lineColor={0,0,0},
                fillColor={170,213,255},
                fillPattern=FillPattern.Solid,
                visible = withWindow3),
              Rectangle(
                extent={{80,68},{68,12}},
                lineColor={0,0,0},
                fillColor={135,135,135},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-25,6},{25,-6}},
                lineColor={255,255,255},
                fillColor={255,170,170},
                fillPattern=FillPattern.Solid,
                textString="Win3",
                origin={-70,25},
                rotation=90,
                visible = withWindow3),
              Line(
                points={{38,54},{68,54}},
                color={255,255,255},
                smooth=Smooth.None),
              Text(
                extent={{-56,60},{62,48}},
                lineColor={255,255,255},
                fillColor={255,170,170},
                fillPattern=FillPattern.Solid,
                textString="width"),
              Line(
                points={{-46,68},{-46,38}},
                color={255,255,255},
                smooth=Smooth.None),
              Line(
                points={{-60,54},{-30,54}},
                color={255,255,255},
                smooth=Smooth.None),
              Text(
                extent={{-126,6},{0,-6}},
                lineColor={255,255,255},
                fillColor={255,170,170},
                fillPattern=FillPattern.Solid,
                origin={-46,64},
                rotation=90,
                textString="length"),
              Line(
                points={{-46,-42},{-46,-68}},
                color={255,255,255},
                smooth=Smooth.None),
              Line(
                points={{68,12},{54,12}},
                color={255,255,255},
                smooth=Smooth.None),
              Text(
                extent={{53,6},{-53,-6}},
                lineColor={255,255,255},
                fillColor={255,170,170},
                fillPattern=FillPattern.Solid,
                origin={58,-27},
                rotation=90,
                textString="length_b"),
              Line(
                points={{58,-58},{58,-68}},
                color={255,255,255},
                smooth=Smooth.None),
              Line(
                points={{58,12},{58,2}},
                color={255,255,255},
                smooth=Smooth.None)}),
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                  100}}),
                  graphics),
          Documentation(revisions="<html>
<p><ul>
<li><i>April 18, 2014</i> by Ana Constantin:<br/>Added documentation</li>
<li><i>July 8, 2011</i> by Ana Constantin:<br/>Implemented</li>
</ul></p>
</html>",     info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Model for a room with 1&nbsp;outer&nbsp;wall,&nbsp;2&nbsp;inner&nbsp;walls&nbsp;load,&nbsp;2&nbsp;inner&nbsp;walls&nbsp;simple,&nbsp;1&nbsp;floor&nbsp;towards&nbsp;lower&nbsp;floor,&nbsp;1&nbsp;ceiling&nbsp;towards&nbsp;attic,&nbsp;1&nbsp;roof&nbsp;towards&nbsp;outside.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The following figure presents the room&apos;s layout:</p>
<p><img src=\"modelica://AixLib/Images/House/OW1_2IWl_2IWs_1Pa_1At1Ro.png\"/></p>
</html>"));
      end Ow1IwL2IwS1Lf1At1Ro1;

      model Attic_Ro2Lf5
        "Attic with 2 saddle roofs and a floor toward 5 rooms on the lower floor, with all other walls towards the outside"
        import AixLib;

        ///////// construction parameters
        parameter Integer TMC =  1 "Themal Mass Class"
          annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice=1 "S", choice = 2 "M", choice = 3 "L", radioButtons = true));
        parameter Integer TIR = 1 "Thermal Insulation Regulation"
         annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice=1
              "EnEV_2009",                                                                                                    choice = 2
              "EnEV_2002",                                                                                                    choice = 3
              "WSchV_1995",  choice = 4 "WSchV_1984",                                                                          radioButtons = true));

        parameter Modelica.SIunits.Temperature T0_air=283.15 "Air"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_RO1=282.15 "RO1"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_RO2=282.15 "RO2"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_OW1=282.15 "OW1"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_OW2=282.15 "OW2"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_FL1=284.15 "FL1" annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_FL2=284.15 "FL2" annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_FL3=284.15 "FL3" annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_FL4=284.15 "FL4"
                                                                 annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
        parameter Modelica.SIunits.Temperature T0_FL5=284.15 "FL5"
                                                                  annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));

       //////////room geometry
       parameter Modelica.SIunits.Length length=2 "length " annotation (Dialog(group = "Dimensions", absoluteWidth=6, descriptionLabel = true, joinNext=true));
       parameter Modelica.SIunits.Length room1_length=2 "l1 " annotation (Dialog(group = "Dimensions", absoluteWidth=6, descriptionLabel = true, joinNext=true));
       parameter Modelica.SIunits.Length room2_length=2 "l2 " annotation (Dialog(group = "Dimensions", absoluteWidth=6, descriptionLabel = true, joinNext=true));
       parameter Modelica.SIunits.Length room3_length=2 "l3 " annotation (Dialog(group = "Dimensions", absoluteWidth=6, descriptionLabel = true, joinNext=true));
       parameter Modelica.SIunits.Length room4_length=2 "l4 " annotation (Dialog(group = "Dimensions", absoluteWidth=6, descriptionLabel = true, joinNext=true));
       parameter Modelica.SIunits.Length room5_length=2 "l5 " annotation (Dialog(group = "Dimensions", absoluteWidth=6, descriptionLabel = true));
       parameter Modelica.SIunits.Length width=2 "width " annotation (Dialog(group = "Dimensions", absoluteWidth=6, descriptionLabel = true, joinNext = true));
       parameter Modelica.SIunits.Length room1_width=2 "w1 " annotation (Dialog(group = "Dimensions", absoluteWidth=6, descriptionLabel = true, joinNext = true));
       parameter Modelica.SIunits.Length room2_width=2 "w2 " annotation (Dialog(group = "Dimensions", absoluteWidth=6, descriptionLabel = true, joinNext = true));
       parameter Modelica.SIunits.Length room3_width=2 "w3 " annotation (Dialog(group = "Dimensions", absoluteWidth=6, descriptionLabel = true, joinNext = true));
       parameter Modelica.SIunits.Length room4_width=2 "w4 " annotation (Dialog(group = "Dimensions", absoluteWidth=6, descriptionLabel = true, joinNext = true));
       parameter Modelica.SIunits.Length room5_width=2 "w5 " annotation (Dialog(group = "Dimensions", absoluteWidth=6, descriptionLabel = true));
       parameter Modelica.SIunits.Length roof_width1 = 2 "wRO1" annotation (Dialog(group = "Dimensions", absoluteWidth=28, descriptionLabel = true, joinNext = true));
       parameter Modelica.SIunits.Length roof_width2 = 2 "wRO2" annotation (Dialog(group = "Dimensions", absoluteWidth=28, descriptionLabel = true));
       parameter Modelica.SIunits.Angle alfa =  Modelica.SIunits.Conversions.from_deg(90) "alfa" annotation (Dialog(group = "Dimensions", descriptionLabel = true));

       // Outer walls properties
       parameter Real solar_absorptance_RO=0.25 "Solar absoptance roof "
                                                                        annotation (Dialog(group = "Outer wall properties", descriptionLabel = true));
       parameter Real solar_absorptance_OW=0.25 "Solar absoptance outer walls "
                                                                               annotation (Dialog(group = "Outer wall properties", descriptionLabel = true));
       parameter Integer ModelConvOW =  1 "Heat Convection Model"
         annotation(Dialog(group = "Outer wall properties", compact = true, descriptionLabel = true), choices(choice = 1
              "DIN 6946",                                                                                                    choice = 2
              "ASHRAE Fundamentals",                                                                                                    choice = 3
              "Custom alpha",                                                                                                    radioButtons = true));

       // Windows and Doors
       parameter Boolean withWindow1 = false "Window 1 " annotation (Dialog(group = "Windows and Doors", joinNext = true, descriptionLabel = true), choices(checkBox=true));
       parameter Modelica.SIunits.Area windowarea_RO1=0 "Window area" annotation (Dialog(group = "Windows and Doors", naturalWidth = 10, descriptionLabel = true, enable = withWindow1));
       parameter Boolean withWindow2 = false "Window 2 " annotation (Dialog(group = "Windows and Doors", joinNext = true, descriptionLabel = true), choices(checkBox=true));
       parameter Modelica.SIunits.Area windowarea_RO2=0 "Window area" annotation (Dialog(group = "Windows and Doors", naturalWidth = 10, descriptionLabel = true, enable = withWindow2));

       // Infiltration rate
      protected
        parameter Real n50(unit="h-1")=
        if (TIR == 1 or TIR ==2) then 3 else
        if TIR == 3 then 4 else 6
          "Air exchange rate at 50 Pa pressure difference" annotation (Dialog(tab = "Infiltration"));
        parameter Real e=0.03 "Coefficient of windshield" annotation (Dialog(tab = "Infiltration"));
        parameter Real eps=1.0 "Coefficient of height" annotation (Dialog(tab = "Infiltration"));
        parameter Modelica.SIunits.Length p = (width + roof_width2 + roof_width1)* 0.5; // semi perimeter
        parameter Modelica.SIunits.Area VerticalWall_Area = sqrt(p * (p - width)*(p -roof_width2)*(p-roof_width1)); // Heron's formula

      // Outer wall type
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_OW=if TIR
             == 1 then if TMC == 1 then
            AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S() else if TMC == 2
             then AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_M() else
            AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_L() else if TIR == 2
             then if TMC == 1 then
            AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_S() else if TMC == 2
             then AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_M() else
            AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_L() else if TIR == 3
             then if TMC == 1 then
            AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_S() else if TMC ==
            2 then AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_M() else
            AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_L() else if TMC ==
            1 then AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_S() else if
            TMC == 2 then AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_M()
             else AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_L()
          annotation (Dialog(tab="Types"));

      // Floor to lower floor type
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_FL=if TIR
             == 1 then
            AixLib.DataBase.Walls.EnEV2009.Ceiling.CEattic_EnEV2009_SML_loHalf()
             else if TIR == 2 then
            AixLib.DataBase.Walls.EnEV2002.Ceiling.CEattic_EnEV2002_SML_loHalf()
             else if TIR == 3 then
            AixLib.DataBase.Walls.WSchV1995.Ceiling.CEattic_WSchV1995_SML_loHalf()
             else
            AixLib.DataBase.Walls.WSchV1984.Ceiling.CEattic_WSchV1984_SML_loHalf()
          annotation (Dialog(tab="Types"));

         // Saddle roof type
        parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_RO=if TIR
             == 1 then
            AixLib.DataBase.Walls.EnEV2009.Ceiling.ROsaddleAttic_EnEV2009_SML()
             else if TIR == 2 then
            AixLib.DataBase.Walls.EnEV2002.Ceiling.ROsaddleAttic_EnEV2002_SML()
             else if TIR == 3 then
            AixLib.DataBase.Walls.WSchV1995.Ceiling.ROsaddleAttic_WSchV1995_SML()
             else
            AixLib.DataBase.Walls.WSchV1984.Ceiling.ROsaddleAttic_WSchV1984_SML()
          annotation (Dialog(tab="Types"));

         //Window type
        parameter
          AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple
          Type_Win=if TIR == 1 then
            AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009() else
            if TIR == 2 then
            AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2002() else
            if TIR == 3 then
            AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1995() else
            AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1984()
          annotation (Dialog(tab="Types"));

          parameter Modelica.SIunits.Volume room_V=roof_width1*roof_width2*sin(alfa)*0.5*length;

      public
        AixLib.Building.Components.Walls.Wall roof1(
          withDoor=false,
          door_height=0,
          door_width=0,
          T0=T0_RO1,
          solar_absorptance=solar_absorptance_RO,
          withWindow=withWindow1,
          windowarea=windowarea_RO1,
          wall_length=length,
          wall_height=roof_width1,
          WallType=Type_RO,
          WindowType=Type_Win,
          ISOrientation=1) annotation (Placement(transformation(
              extent={{-5.00001,-29},{5.00001,29}},
              rotation=270,
              origin={-41,59})));
        AixLib.Building.Components.Walls.Wall floorRoom2(
          T0=T0_FL2,
          WallType=Type_FL,
          wall_length=room2_length,
          wall_height=room2_width,
          withWindow=false,
          ISOrientation=2,
          outside=false,
          withDoor=false) annotation (Placement(transformation(
              origin={-29,-40},
              extent={{-1.99999,-13},{1.99999,13}},
              rotation=90)));
        AixLib.Building.Components.DryAir.Airload airload(V=room_V, T(start=
               T0_air)) annotation (Placement(transformation(extent={{0,-20},
                  {20,0}}, rotation=0)));
        AixLib.Building.Components.Walls.Wall floorRoom1(
          T0=T0_FL1,
          WallType=Type_FL,
          wall_length=room1_length,
          wall_height=room1_width,
          withWindow=false,
          ISOrientation=2,
          outside=false,
          withDoor=false) annotation (Placement(transformation(
              origin={-60,-40},
              extent={{-2,-12},{2,12}},
              rotation=90)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermOutside
          annotation (Placement(transformation(extent={{-100,80},{-80,100}},
                rotation=0)));
        Modelica.Blocks.Interfaces.RealInput WindSpeedPort
          annotation (Placement(transformation(extent={{-109.5,-10},{-89.5,10}},
                rotation=0), iconTransformation(extent={{-109.5,-10},{-89.5,10}})));
        Utilities.Interfaces.SolarRad_in SolarRadiationPort_RO1 annotation (
           Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-45.5,100}), iconTransformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-50,90})));
        Modelica.Blocks.Interfaces.RealInput AirExchangePort
            annotation (Placement(transformation(
              origin={-100,17},
              extent={{-10,-10},{10,10}},
              rotation=0), iconTransformation(extent={{-110,30},{-90,50}})));
        AixLib.Building.Components.Walls.Wall roof2(
          solar_absorptance=solar_absorptance_RO,
          withDoor=false,
          door_height=0,
          door_width=0,
          T0=T0_RO2,
          wall_height=roof_width2,
          withWindow=withWindow2,
          windowarea=windowarea_RO2,
          wall_length=length,
          WallType=Type_RO,
          WindowType=Type_Win,
          ISOrientation=1) annotation (Placement(transformation(
              origin={47,59},
              extent={{-5,-27},{5,27}},
              rotation=270)));
        Utilities.Interfaces.SolarRad_in SolarRadiationPort_RO2 annotation (
           Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={48,100}), iconTransformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={50,90})));
        AixLib.Building.Components.Walls.Wall floorRoom3(
          T0=T0_FL3,
          WallType=Type_FL,
          wall_length=room3_length,
          wall_height=room3_width,
          withWindow=false,
          ISOrientation=2,
          outside=false,
          withDoor=false) annotation (Placement(transformation(
              origin={3,-40},
              extent={{-1.99999,-13},{1.99999,13}},
              rotation=90)));
        AixLib.Building.Components.Walls.Wall floorRoom4(
          T0=T0_FL4,
          WallType=Type_FL,
          wall_length=room4_length,
          wall_height=room4_width,
          withWindow=false,
          ISOrientation=2,
          outside=false,
          withDoor=false) annotation (Placement(transformation(
              origin={35,-40},
              extent={{-1.99998,-13},{1.99999,13}},
              rotation=90)));
        AixLib.Building.Components.Walls.Wall floorRoom5(
          T0=T0_FL5,
          WallType=Type_FL,
          wall_length=room5_length,
          wall_height=room5_width,
          withWindow=false,
          ISOrientation=2,
          outside=false,
          withDoor=false) annotation (Placement(transformation(
              origin={69,-40},
              extent={{-1.99998,-13},{1.99998,13}},
              rotation=90)));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermRoom1
          annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermRoom2
          annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermRoom3
          annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermRoom4
          annotation (Placement(transformation(extent={{20,-100},{40,-80}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermRoom5
          annotation (Placement(transformation(extent={{60,-100},{80,-80}})));
        Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor Tair
          annotation (Placement(transformation(extent={{24,-20},{38,-6}})));
        AixLib.Building.Components.DryAir.InfiltrationRate_DIN12831
          infiltrationRate(
          room_V=room_V,
          n50=n50,
          e=e,
          eps=eps)
          annotation (Placement(transformation(extent={{-62,0},{-46,16}})));
        Utilities.Interfaces.Adaptors.HeatStarToComb thermStar_Demux
          annotation (Placement(transformation(
              extent={{-10,-8},{10,8}},
              rotation=90,
              origin={-30,-10})));
        AixLib.Building.Components.DryAir.VarAirExchange NaturalVentilation(
            V=room_V) annotation (Placement(transformation(extent={{-64,16},
                  {-44,36}})));
      public
        AixLib.Building.Components.Walls.Wall OW1(
          withDoor=false,
          door_height=0,
          door_width=0,
          windowarea=windowarea_RO1,
          WindowType=Type_Win,
          ISOrientation=1,
          WallType=Type_OW,
          wall_length=sqrt(VerticalWall_Area),
          wall_height=sqrt(VerticalWall_Area),
          solar_absorptance=solar_absorptance_OW,
          withWindow=false,
          T0=T0_OW1) annotation (Placement(transformation(
              extent={{-4,-21},{4,21}},
              rotation=0,
              origin={-75,-22})));
        Utilities.Interfaces.SolarRad_in SolarRadiationPort_OW1 annotation (
           Placement(transformation(extent={{-116,-30},{-96,-10}})));
      public
        AixLib.Building.Components.Walls.Wall OW2(
          withDoor=false,
          door_height=0,
          door_width=0,
          windowarea=windowarea_RO1,
          WindowType=Type_Win,
          ISOrientation=1,
          WallType=Type_OW,
          wall_length=sqrt(VerticalWall_Area),
          wall_height=sqrt(VerticalWall_Area),
          solar_absorptance=solar_absorptance_OW,
          withWindow=false,
          T0=T0_OW2) annotation (Placement(transformation(
              extent={{-4,21},{4,-21}},
              rotation=180,
              origin={85,-16})));
        Utilities.Interfaces.SolarRad_in SolarRadiationPort_OW2 annotation (
           Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={110,-18})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermAttic annotation (
            Placement(transformation(extent={{8,8},{28,28}}), iconTransformation(
                extent={{8,8},{28,28}})));
      equation

        connect(SolarRadiationPort_RO1, roof1.SolarRadiationPort) annotation (Line(
            points={{-45.5,100},{-45.5,80},{-14.4167,80},{-14.4167,65.5}},
            color={255,128,0},
            smooth=Smooth.None));

        connect(SolarRadiationPort_RO2, roof2.SolarRadiationPort) annotation (Line(
            points={{48,100},{48,80},{71.75,80},{71.75,65.5}},
            color={255,128,0},
            smooth=Smooth.None));
        connect(thermOutside, thermOutside) annotation (Line(
            points={{-90,90},{-90,90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(roof1.WindSpeedPort, WindSpeedPort) annotation (Line(
            points={{-19.7333,64.25},{-19.7333,80},{-80,80},{-80,0},{-99.5,0}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(roof2.WindSpeedPort, WindSpeedPort) annotation (Line(
            points={{66.8,64.25},{66.8,80},{-80,80},{-80,0},{-99.5,0}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(floorRoom1.port_outside, thermRoom1) annotation (Line(
            points={{-60,-42.1},{-60,-90},{-90,-90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(floorRoom2.port_outside, thermRoom2) annotation (Line(
            points={{-29,-42.1},{-29,-90},{-50,-90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(thermRoom3, floorRoom3.port_outside) annotation (Line(
            points={{-10,-90},{3,-90},{3,-42.1}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(thermRoom4, floorRoom4.port_outside) annotation (Line(
            points={{30,-90},{38,-90},{38,-70},{35,-70},{35,-42.1}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(floorRoom5.port_outside, thermRoom5) annotation (Line(
            points={{69,-42.1},{69,-84},{72,-84},{72,-88},{70,-88},{70,-90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(airload.port, Tair.port) annotation (Line(
            points={{1,-12},{-10,-12},{-10,8},{24,8},{24,-13}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(infiltrationRate.port_a, thermOutside) annotation (Line(
            points={{-62,8},{-80,8},{-80,90},{-90,90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(infiltrationRate.port_b, airload.port) annotation (Line(
            points={{-46,8},{-10,8},{-10,-12},{1,-12}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(thermStar_Demux.therm, airload.port) annotation (Line(
            points={{-24.9,0.1},{-24.9,8},{-10,8},{-10,-12},{1,-12}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(roof1.port_outside, thermOutside) annotation (Line(
            points={{-41,64.25},{-41,80},{-90,80},{-90,90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(roof2.port_outside, thermOutside) annotation (Line(
            points={{47,64.25},{47,80},{-90,80},{-90,90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(floorRoom3.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{3,-38},{3,-28},{-30,-28},{-30,-19.4},{-29.9,-19.4}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(floorRoom1.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{-60,-38},{-60,-28},{-30,-28},{-30,-19.4},{-29.9,-19.4}},
            color={191,0,0},
            smooth=Smooth.None));

        connect(floorRoom2.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{-29,-38},{-29,-28},{-29.9,-28},{-29.9,-19.4}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(floorRoom4.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{35,-38},{35,-28},{-29.9,-28},{-29.9,-19.4}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(floorRoom5.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{69,-38},{69,-28},{-29.9,-28},{-29.9,-19.4}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(roof2.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{47,54},{47,40},{60,40},{60,-28},{-29.9,-28},{-29.9,-19.4}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(roof1.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{-41,54},{-41,40},{60,40},{60,-28},{-29.9,-28},{-29.9,-19.4}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(NaturalVentilation.InPort1, AirExchangePort) annotation (Line(
            points={{-63,19.6},{-80,19.6},{-80,17},{-100,17}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(NaturalVentilation.port_a, thermOutside) annotation (Line(
            points={{-64,26},{-80,26},{-80,90},{-90,90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(NaturalVentilation.port_b, airload.port) annotation (Line(
            points={{-44,26},{-40,26},{-40,8},{-10,8},{-10,-12},{1,-12}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(OW1.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{-71,-22},{-64,-22},{-64,-28},{-29.9,-28},{-29.9,-19.4}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(OW1.port_outside, thermOutside) annotation (Line(
            points={{-79.2,-22},{-86,-22},{-86,0},{-80,0},{-80,90},{-90,90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(OW1.WindSpeedPort, WindSpeedPort) annotation (Line(
            points={{-79.2,-6.6},{-86,-6.6},{-86,0},{-99.5,0}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(OW1.SolarRadiationPort, SolarRadiationPort_OW1) annotation (Line(
            points={{-80.2,-2.75},{-86,-2.75},{-86,-20},{-106,-20}},
            color={255,128,0},
            smooth=Smooth.None));
        connect(OW2.thermStarComb_inside, thermStar_Demux.thermStarComb)
          annotation (Line(
            points={{81,-16},{76,-16},{76,-28},{-29.9,-28},{-29.9,-19.4}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(OW2.port_outside, thermOutside) annotation (Line(
            points={{89.2,-16},{100,-16},{100,80},{-90,80},{-90,90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(OW2.WindSpeedPort, WindSpeedPort) annotation (Line(
            points={{89.2,-0.6},{100,-0.6},{100,-28},{-86,-28},{-86,0},{-99.5,0}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(OW2.SolarRadiationPort, SolarRadiationPort_OW2) annotation (Line(
            points={{90.2,3.25},{100,3.25},{100,-18},{110,-18}},
            color={255,128,0},
            smooth=Smooth.None));
        connect(airload.port, ThermAttic) annotation (Line(
            points={{1,-12},{-4,-12},{-4,-10},{18,-10},{18,18}},
            color={191,0,0},
            smooth=Smooth.None));
       annotation (__Dymola_Images(Parameters(source="AixLib/Images/House/Attic_2Ro_5Rooms.png", Width = 5, Length = 5)),
                    Icon(graphics={Polygon(
                points={{-58,-20},{16,54},{90,-20},{76,-20},{16,40},{-44,-20},{-58,-20}},
                lineColor={0,0,0},
                smooth=Smooth.None,
                fillPattern=FillPattern.Solid,
                fillColor={175,175,175}),
              Polygon(
                points={{-24,0},{6,30},{-8,30},{-38,0},{-24,0}},
                lineColor={0,0,0},
                smooth=Smooth.None,
                fillColor={170,213,255},
                fillPattern=FillPattern.Solid,
                visible=  withWindow1),
              Text(
                extent={{-36,10},{12,22}},
                lineColor={0,0,0},
                fillColor={170,213,255},
                fillPattern=FillPattern.Solid,
                textString="Win1",
                visible=  withWindow1),
              Polygon(
                points={{26,30},{56,0},{70,0},{40,30},{26,30}},
                lineColor={0,0,0},
                smooth=Smooth.None,
                fillColor={170,213,255},
                fillPattern=FillPattern.Solid,
                visible=withWindow2),
              Text(
                extent={{22,10},{70,22}},
                lineColor={0,0,0},
                fillColor={170,213,255},
                fillPattern=FillPattern.Solid,
                textString="Win2",
                visible=withWindow2),
              Text(
                extent={{-44,-14},{74,-26}},
                lineColor={0,0,0},
                fillColor={255,170,170},
                fillPattern=FillPattern.Solid,
                textString="width"),
              Line(
                points={{48,-20},{76,-20}},
                color={0,0,0},
                smooth=Smooth.None),
              Line(
                points={{-44,-20},{-20,-20}},
                color={0,0,0},
                smooth=Smooth.None),
              Line(
                points={{-62,-16},{12,58}},
                color={0,0,0},
                smooth=Smooth.None),
              Line(
                points={{16,54},{10,60}},
                color={0,0,0},
                smooth=Smooth.None),
              Line(
                points={{-58,-20},{-64,-14}},
                color={0,0,0},
                smooth=Smooth.None),
              Text(
                extent={{-40,52},{16,42}},
                lineColor={0,0,0},
                textString="wRO1"),
              Line(
                points={{3,-3},{-3,3}},
                color={0,0,0},
                smooth=Smooth.None,
                origin={93,-17},
                rotation=90),
              Line(
                points={{-37,-37},{37,37}},
                color={0,0,0},
                smooth=Smooth.None,
                origin={57,21},
                rotation=90),
              Line(
                points={{3,-3},{-3,3}},
                color={0,0,0},
                smooth=Smooth.None,
                origin={19,57},
                rotation=90),
              Text(
                extent={{-28,5},{28,-5}},
                lineColor={0,0,0},
                origin={44,47},
                rotation=0,
                textString="wRO2"),
              Line(
                points={{-44,-20},{-44,-24}},
                color={0,0,0},
                smooth=Smooth.None),
              Line(
                points={{76,-20},{76,-24}},
                color={0,0,0},
                smooth=Smooth.None)}),
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                  100,100}}),
                  graphics),
          Documentation(revisions="<html>
<p><ul>
<li><i>April 18, 2014</i> by Ana Constantin:<br/>Added documentation</li>
<li><i>July 8, 2011</i> by Ana Constantin:<br/>Implemented</li>
</ul></p>
</html>",     info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Model for an attic&nbsp;with&nbsp;2&nbsp;saddle&nbsp;roofs&nbsp;and&nbsp;a&nbsp;floor&nbsp;toward&nbsp;5&nbsp;rooms&nbsp;on&nbsp;the&nbsp;lower&nbsp;floor,&nbsp;with&nbsp;all&nbsp;other&nbsp;walls&nbsp;towards&nbsp;the&nbsp;outside.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The following figure presents the room&apos;s layout:</p>
<p><img src=\"modelica://AixLib/Images/House/Attic_2Ro_5Rooms.png\"/></p>
<p>We also tested a model where the attic has just one floor, over the whole building and each room connects to this component through the ceiling. However the model didn&apos;t lead to the expected lower simulation times, on the contrary. This model is also more correct, as it is not realistic to think that every layer of the attic&apos;s floor has a single temperature.</p>
</html>"));
      end Attic_Ro2Lf5;

      annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Package for rooms for a one familiy dwelling.</p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The one family dwelling isn&rsquo;t based on an existing building, but on a virtual two storey building with ten rooms and a saddle roof, which is typical for German houses. A core of six room types was developed to model the different rooms in the house: room types with two outer walls and room types with one outer wall. Some inner walls can face just one room, while others can face two rooms. Rooms on the ground floor are connected to the ground, while rooms on the upper floor have a saddle roof. The layout of the two floors is the same. </p>
<p><br>The room model is realized by aggregating together all the components in a model, parameterizing on a room level and referencing the parameter on the component level. In this way the number of parameters is reduced, e.g. for a simple rectangular room only three parameters are needed for the dimensions of all the walls: height, length, width.</p>
<p>The set of room types developed for the one family dwelling can, if necessary, be parameterized differently than the standard model or extended in order to build up specific house models. New sets of wall, window and door types can be developed, e.g. for older, not renovated buildings, and incorporated in the existing structure.</p>
</html>",     revisions="<html>
<p><ul>
<li><i>April 14, 2014</i> by Ana Constantin:<br/>Added documentation</li>
<li><i>July 7, 2011</i> by Ana Constantin:<br/>Implemented</li>
</ul></p>
</html>"));
    end OFD;

    package MFD "Multiple Family Dweling"
                extends Modelica.Icons.Package;
      package OneApparment
                  extends Modelica.Icons.Package;

        model Livingroom_VoWo "Livingroom from the VoWo appartment"
          import AixLib;
         ///////// construction parameters
          parameter Integer TMC =  1 "Themal Mass Class"
            annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice=1 "S", choice = 2 "M", choice = 3 "L", radioButtons = true));
          parameter Integer TIR = 4 "Thermal Insulation Regulation"
           annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice=1
                "EnEV_2009",                                                                                                    choice = 2
                "EnEV_2002",                                                                                                    choice = 3
                "WSchV_1995",  choice = 4 "WSchV_1984",                                                                          radioButtons = true));

          parameter Integer Floor =  1 "Floor"
            annotation(Dialog(group = "Floor", compact = true, descriptionLabel = true), choices(choice=1 "GF", choice = 2 "1F", choice = 3 "2F", radioButtons = true));

          // Outer walls properties
         parameter Real solar_absorptance_OW=0.7
            "Solar absoptance outer walls "                                     annotation (Dialog(group = "Outer wall properties", descriptionLabel = true));
         parameter Integer ModelConvOW =  1 "Heat Convection Model"
           annotation(Dialog(group = "Outer wall properties", compact = true, descriptionLabel = true), choices(choice = 1
                "DIN 6946",                                                                                                    choice = 2
                "ASHRAE Fundamentals",                                                                                                    choice = 3
                "Custom alpha",                                                                                                    radioButtons = true));

          //Initial temperatures
          parameter Modelica.SIunits.Temperature T0_air=295.15 "Air"
                                                                   annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_OW=295.15 "OW" annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_IWChild=295.15 "IWChild"
                                                                   annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_IWCorridor=290.15
            "IWCorridor"                                           annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_IWBedroom=295.15
            "IWBedroom"                                            annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_IWNeighbour=295.15
            "IWNeighbour"                                          annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_CE=295.35 "Ceiling"
                                                                   annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_FL=294.95 "Floor"
                                                                   annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));

          // Infiltration rate

        protected
          parameter Real n50(unit="h-1")=
          if (TIR == 1 or TIR ==2) then 3 else
          if TIR == 3 then 4 else 6
            "Air exchange rate at 50 Pa pressure difference" annotation (Dialog(tab = "Infiltration"));
          parameter Real e=0.03 "Coefficient of windshield" annotation (Dialog(tab = "Infiltration"));
          parameter Real eps=1.0 "Coefficient of height" annotation (Dialog(tab = "Infiltration"));

          // Outer wall type
          parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_OW=if TIR
               == 1 then if TMC == 1 then
              AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S() else if TMC ==
              2 then AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_M() else
              AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_L() else if TIR ==
              2 then if TMC == 1 then
              AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_S() else if TMC ==
              2 then AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_M() else
              AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_L() else if TIR ==
              3 then if TMC == 1 then
              AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_S() else if TMC
               == 2 then AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_M()
               else AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_L() else
              if TMC == 1 then
              AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_S() else if TMC
               == 2 then AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_M()
               else AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_L()
            annotation (Dialog(tab="Types"));

          //Inner wall Types

          parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_IWload=
              if TIR == 1 then if TMC == 1 then
              AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half() else
              if TMC == 2 then
              AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_M_half() else
              AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_L_half() else
              if TIR == 2 then if TMC == 1 then
              AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_S_half() else
              if TMC == 2 then
              AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_M_half() else
              AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_L_half() else
              if TIR == 3 then if TMC == 1 then
              AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_S_half()
               else if TMC == 2 then
              AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_M_half()
               else AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_L_half()
               else if TMC == 1 then
              AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_S_half()
               else if TMC == 2 then
              AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_M_half()
               else AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_L_half()
            annotation (Dialog(tab="Types"));

          parameter AixLib.DataBase.Walls.WallBaseDataDefinition
            Type_IWNeigbour=if TIR == 1 then if TMC == 1 then
              AixLib.DataBase.Walls.EnEV2009.IW.IWneighbour_EnEV2009_S_half()
               else if TMC == 2 then
              AixLib.DataBase.Walls.EnEV2009.IW.IWneighbour_EnEV2009_M_half()
               else
              AixLib.DataBase.Walls.EnEV2009.IW.IWneighbour_EnEV2009_L_half()
               else if TIR == 2 then if TMC == 1 then
              AixLib.DataBase.Walls.EnEV2002.IW.IWneighbour_EnEV2002_S_half()
               else if TMC == 2 then
              AixLib.DataBase.Walls.EnEV2002.IW.IWneighbour_EnEV2002_M_half()
               else
              AixLib.DataBase.Walls.EnEV2002.IW.IWneighbour_EnEV2002_L_half()
               else if TIR == 3 then if TMC == 1 then
              AixLib.DataBase.Walls.WSchV1995.IW.IWneighbour_WSchV1995_S_half()
               else if TMC == 2 then
              AixLib.DataBase.Walls.WSchV1995.IW.IWneighbour_WSchV1995_M_half()
               else
              AixLib.DataBase.Walls.WSchV1995.IW.IWneighbour_WSchV1995_L_half()
               else if TMC == 1 then
              AixLib.DataBase.Walls.WSchV1984.IW.IWneighbour_WSchV1984_S_half()
               else if TMC == 2 then
              AixLib.DataBase.Walls.WSchV1984.IW.IWneighbour_WSchV1984_M_half()
               else
              AixLib.DataBase.Walls.WSchV1984.IW.IWneighbour_WSchV1984_L_half()
            annotation (Dialog(tab="Types"));

           // Floor type
          parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_FL=if
              Floor == 1 then if TIR == 1 then
              AixLib.DataBase.Walls.EnEV2009.Floor.FLcellar_EnEV2009_SML_upHalf()
               else if TIR == 2 then
              AixLib.DataBase.Walls.EnEV2002.Floor.FLcellar_EnEV2002_SML_upHalf()
               else if TIR == 3 then
              AixLib.DataBase.Walls.WSchV1995.Floor.FLcellar_WSchV1995_SML_upHalf()
               else
              AixLib.DataBase.Walls.WSchV1984.Floor.FLcellar_WSchV1984_SML_upHalf()
               else if TIR == 1 then if (TMC == 1 or TMC == 2) then
              AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_SM_upHalf()
               else
              AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_L_upHalf()
               else if TIR == 2 then if (TMC == 1 or TMC == 2) then
              AixLib.DataBase.Walls.EnEV2002.Floor.FLpartition_EnEV2002_SM_upHalf()
               else
              AixLib.DataBase.Walls.EnEV2002.Floor.FLpartition_EnEV2002_L_upHalf()
               else if TIR == 3 then if (TMC == 1 or TMC == 2) then
              AixLib.DataBase.Walls.WSchV1995.Floor.FLpartition_WSchV1995_SM_upHalf()
               else
              AixLib.DataBase.Walls.WSchV1995.Floor.FLpartition_WSchV1995_L_upHalf()
               else if (TMC == 1 or TMC == 2) then
              AixLib.DataBase.Walls.WSchV1984.Floor.FLpartition_WSchV1984_SM_upHalf()
               else
              AixLib.DataBase.Walls.WSchV1984.Floor.FLpartition_WSchV1984_L_upHalf()
            annotation (Dialog(tab="Types"));

          // Ceiling  type
          parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_CE=if (
              Floor == 1) or (Floor == 2) then if TIR == 1 then if (TMC == 1
               or TMC == 2) then
              AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_SM_loHalf()
               else
              AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_L_loHalf()
               else if TIR == 2 then if (TMC == 1 or TMC == 2) then
              AixLib.DataBase.Walls.EnEV2002.Ceiling.CEpartition_EnEV2002_SM_loHalf()
               else
              AixLib.DataBase.Walls.EnEV2002.Ceiling.CEpartition_EnEV2002_L_loHalf()
               else if TIR == 3 then if (TMC == 1 or TMC == 2) then
              AixLib.DataBase.Walls.WSchV1995.Ceiling.CEpartition_WSchV1995_SM_loHalf()
               else
              AixLib.DataBase.Walls.WSchV1995.Ceiling.CEpartition_WSchV1995_L_loHalf()
               else if (TMC == 1 or TMC == 2) then
              AixLib.DataBase.Walls.WSchV1984.Ceiling.CEpartition_WSchV1984_SM_loHalf()
               else
              AixLib.DataBase.Walls.WSchV1984.Ceiling.CEpartition_WSchV1984_L_loHalf()
               else if TIR == 1 then
              AixLib.DataBase.Walls.EnEV2009.Ceiling.CEattic_EnEV2009_SML_loHalf()
               else if TIR == 2 then
              AixLib.DataBase.Walls.EnEV2002.Ceiling.CEattic_EnEV2002_SML_loHalf()
               else if TIR == 3 then
              AixLib.DataBase.Walls.WSchV1995.Ceiling.CEattic_WSchV1995_SML_loHalf()
               else
              AixLib.DataBase.Walls.WSchV1984.Ceiling.CEattic_WSchV1984_SML_loHalf()
            annotation (Dialog(tab="Types"));

           //Window type
          parameter
            AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple
            Type_Win=if TIR == 1 then
              AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009() else
              if TIR == 2 then
              AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2002() else
              if TIR == 3 then
              AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1995()
               else AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1984()
            annotation (Dialog(tab="Types"));

            parameter Modelica.SIunits.Volume room_V=4.20*4.645*2.46;

        public
          AixLib.Building.Components.Walls.Wall Wall_Neighbour(
            T0=T0_IWNeighbour,
            outside=false,
            WallType=Type_IWNeigbour,
            wall_length=4.2,
            wall_height=2.46,
            withWindow=false,
            withDoor=false) annotation (Placement(transformation(extent={{-80,
                    -24},{-68,54}}, rotation=0)));
          AixLib.Building.Components.Walls.Wall Wall_Corridor(
            T0=T0_IWCorridor,
            outside=false,
            WallType=Type_IWload,
            wall_length=1.54,
            wall_height=2.46,
            withWindow=false,
            withDoor=false) annotation (Placement(transformation(
                origin={19,-43},
                extent={{-4.99999,-31},{4.99998,31}},
                rotation=90)));
          AixLib.Building.Components.Walls.Wall Wall_Children(
            T0=T0_IWChild,
            outside=false,
            WallType=Type_IWload,
            wall_length=4.2,
            wall_height=2.46,
            withWindow=false,
            withDoor=false) annotation (Placement(transformation(
                origin={75,14.9756},
                extent={{-7.00003,-39.0244},{7.00003,40.9756}},
                rotation=180)));
          AixLib.Building.Components.DryAir.Airload airload(V=room_V, T(
                start=T0_air)) annotation (Placement(transformation(extent=
                    {{-28,0},{-48,20}}, rotation=0)));

          AixLib.Building.Components.Walls.Wall outsideWall(
            wall_length=4.645,
            wall_height=2.46,
            windowarea=3.99,
            door_height=0.1,
            door_width=0.1,
            withWindow=true,
            T0=T0_OW,
            solar_absorptance=solar_absorptance_OW,
            withDoor=false,
            WallType=Type_OW,
            WindowType=Type_Win) annotation (Placement(transformation(
                origin={-14.9999,71},
                extent={{-13,-61.0001},{11,82.9999}},
                rotation=270)));

          AixLib.Building.Components.Walls.Wall Wall_Bedroom(
            T0=T0_IWBedroom,
            outside=false,
            WallType=Type_IWload,
            wall_length=3.105,
            wall_height=2.46,
            withWindow=false,
            withDoor=false) annotation (Placement(transformation(
                origin={-45,-44},
                extent={{-3.99999,-25},{3.99998,25}},
                rotation=90)));
          AixLib.Building.Components.Walls.Wall Wall_Ceiling(
            T0=T0_CE,
            outside=false,
            WallType=Type_CE,
            wall_length=4.2,
            wall_height=4.645,
            Model=1,
            ISOrientation=3,
            withWindow=false,
            withDoor=false) annotation (Placement(transformation(
                origin={104,70},
                extent={{-1.99998,-10},{1.99998,10}},
                rotation=270)));
          AixLib.Building.Components.Walls.Wall Wall_Floor(
            T0=T0_FL,
            outside=false,
            WallType=Type_FL,
            wall_length=4.2,
            wall_height=4.645,
            ISOrientation=2,
            withWindow=false,
            withDoor=false) annotation (Placement(transformation(
                origin={104,32},
                extent={{-1.99998,-10},{1.99998,10}},
                rotation=90)));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermRoom annotation (
             Placement(transformation(extent={{-12,4},{8,24}}), iconTransformation(
                  extent={{-12,4},{8,24}})));
          Utilities.Interfaces.Star StarInside1 annotation (Placement(
                transformation(extent={{16,4},{36,24}}), iconTransformation(
                  extent={{16,4},{36,24}})));
        public
          Utilities.Interfaces.SolarRad_in SolarRadiation_SE annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-66,134})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermOutside
            annotation (Placement(transformation(extent={{-160,120},{-140,140}}),
                iconTransformation(extent={{-160,120},{-140,140}})));
          Modelica.Blocks.Interfaces.RealInput AirExchangePort        annotation (
              Placement(transformation(extent={{-180,50},{-140,90}}),iconTransformation(
                  extent={{-160,70},{-140,90}})));
          Modelica.Blocks.Interfaces.RealInput WindSpeedPort annotation (Placement(
                transformation(extent={{-180,10},{-140,50}}),
                                                            iconTransformation(extent={{-160,30},
                    {-140,50}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling
            annotation (Placement(transformation(extent={{-160,-120},{-140,-100}}),
                iconTransformation(extent={{-160,-120},{-140,-100}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor
            annotation (Placement(transformation(extent={{-160,-150},{-140,-130}}),
                iconTransformation(extent={{-160,-150},{-140,-130}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermChildren
            annotation (Placement(transformation(extent={{-160,-90},{-140,-70}}),
                iconTransformation(extent={{-160,-90},{-140,-70}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCorridor
            annotation (Placement(transformation(extent={{-160,-60},{-140,-40}}),
                iconTransformation(extent={{-160,-60},{-140,-40}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermBedroom
            annotation (Placement(transformation(extent={{-160,-30},{-140,-10}}),
                iconTransformation(extent={{-160,-30},{-140,-10}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermNeighbour
            annotation (Placement(transformation(extent={{-160,0},{-140,20}}),
                iconTransformation(extent={{-160,0},{-140,20}})));
          AixLib.Building.Components.DryAir.InfiltrationRate_DIN12831
            infiltrationRate(
            room_V=room_V,
            n50=n50,
            e=e,
            eps=eps) annotation (Placement(transformation(extent={{-72,-84},
                    {-46,-58}})));
          Utilities.Interfaces.Adaptors.HeatStarToComb thermStar_Demux
            annotation (Placement(transformation(
                extent={{-10,8},{10,-8}},
                rotation=180,
                origin={24,-14})));
          AixLib.Building.Components.DryAir.VarAirExchange
            NaturalVentilation(V=room_V) annotation (Placement(
                transformation(extent={{-72,-112},{-46,-86}})));
        equation

          connect(outsideWall.SolarRadiationPort,SolarRadiation_SE)  annotation (Line(
              points={{62,87.6},{62,100},{-66,100},{-66,134}},
              color={255,128,0},
              smooth=Smooth.None));
          connect(outsideWall.WindSpeedPort, WindSpeedPort) annotation (Line(
              points={{48.8,84.6},{48.8,100},{-86,100},{-86,30},{-160,30}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(Wall_Ceiling.port_outside, thermCeiling) annotation (Line(
              points={{104,72.1},{104,84},{134,84},{134,-56},{-86,-56},{-86,
                  -110},{-150,-110}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Floor.port_outside, thermFloor) annotation (Line(
              points={{104,29.9},{104,4},{134,4},{134,-56},{-86,-56},{-86,-140},
                  {-150,-140}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Children.port_outside, thermChildren) annotation (Line(
              points={{82.35,14},{104,14},{104,4},{134,4},{134,-80},{-150,-80}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Corridor.port_outside, thermCorridor) annotation (Line(
              points={{19,-48.25},{19,-48.25},{19,-56},{-86,-56},{-86,-50},{
                  -150,-50}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Wall_Bedroom.port_outside, thermBedroom) annotation (Line(
              points={{-45,-48.2},{-45,-56},{-86,-56},{-86,-20},{-150,-20}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Neighbour.port_outside, thermNeighbour) annotation (Line(
              points={{-80.3,15},{-86,15},{-86,10},{-150,10}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(infiltrationRate.port_a, thermOutside) annotation (Line(
              points={{-72,-71},{-86,-71},{-86,130},{-150,130}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(ThermRoom, ThermRoom) annotation (Line(
              points={{-2,14},{-7,14},{-7,14},{-2,14}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(thermStar_Demux.star, StarInside1) annotation (Line(
              points={{13.6,-8.2},{13.6,3.2},{26,3.2},{26,14}},
              color={95,95,95},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          connect(Wall_Children.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{68,14},{54,14},{54,-32},{33.4,-32},{33.4,-14.1}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Wall_Corridor.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{19,-38},{19,-32},{33.4,-32},{33.4,-14.1}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Bedroom.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{-45,-40},{-45,-32},{33.4,-32},{33.4,-14.1}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Neighbour.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{-68,15},{-56,15},{-56,-32},{33.4,-32},{33.4,-14.1}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(outsideWall.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{-4,60},{-4,48},{-56,48},{-56,-32},{33.4,-32},{33.4,-14.1}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Ceiling.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{104,68},{104,58},{54,58},{54,-32},{33.4,-32},{33.4,-14.1}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Floor.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{104,34},{104,58},{54,58},{54,-32},{33.4,-32},{33.4,-14.1}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(thermStar_Demux.therm, ThermRoom) annotation (Line(
              points={{13.9,-19.1},{13.9,-20},{-20,-20},{-20,14},{-2,14}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(airload.port, infiltrationRate.port_b) annotation (Line(
              points={{-29,8},{-20,8},{-20,-71},{-46,-71}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(NaturalVentilation.InPort1, AirExchangePort) annotation (Line(
              points={{-70.7,-107.32},{-86,-107.32},{-86,70},{-160,70}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(NaturalVentilation.port_a, thermOutside) annotation (Line(
              points={{-72,-99},{-86,-99},{-86,130},{-150,130}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(airload.port, ThermRoom) annotation (Line(
              points={{-29,8},{-20,8},{-20,14},{-2,14}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(NaturalVentilation.port_b, airload.port) annotation (Line(
              points={{-46,-99},{-20,-99},{-20,8},{-29,8}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(outsideWall.port_outside, thermOutside) annotation (Line(
              points={{-4,84.6},{-4,100},{-86,100},{-86,130},{-150,130}},
              color={191,0,0},
              smooth=Smooth.None));
          annotation (__Dymola_Images(Parameters(source="AixLib/Images/House/VoWo_Livingroom.png")),
            Diagram(coordinateSystem(
                preserveAspectRatio=true,
                extent={{-170,-150},{170,150}},
                initialScale=0.1), graphics),
            Icon(coordinateSystem(
                preserveAspectRatio=true,
                extent={{-170,-150},{170,150}},
                initialScale=0.1), graphics={
                Rectangle(
                  extent={{-62,60},{112,-92}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Forward),
                Rectangle(
                  extent={{38,72},{60,52}},
                  lineColor={0,0,0},
                  fillColor={85,255,255},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{40,70},{58,54}},
                  lineColor={0,0,0},
                  fillColor={170,213,255},
                  fillPattern=FillPattern.Solid),
                Text(
                  extent={{-56,-14},{104,-32}},
                  lineColor={0,0,0},
                  fillColor={255,0,0},
                  fillPattern=FillPattern.Forward,
                  textString="Livingroom"),
                Text(
                  extent={{42,-98},{92,-114}},
                  lineColor={0,0,0},
                  lineThickness=1,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="Corridor"),
                Rectangle(
                  extent={{92,-88},{112,-118}},
                  lineColor={0,0,0},
                  lineThickness=1,
                  fillColor={127,0,0},
                  fillPattern=FillPattern.Forward),
                Ellipse(
                  extent={{94,-100},{96,-102}},
                  lineColor={0,0,0},
                  pattern=LinePattern.None,
                  lineThickness=1,
                  fillPattern=FillPattern.Sphere,
                  fillColor={255,255,0}),
                Rectangle(
                  extent={{-62,84},{-42,54}},
                  lineColor={0,0,0},
                  lineThickness=1,
                  fillColor={127,0,0},
                  fillPattern=FillPattern.Forward),
                Ellipse(
                  extent={{-44,68},{-46,66}},
                  lineColor={0,0,0},
                  pattern=LinePattern.None,
                  lineThickness=1,
                  fillPattern=FillPattern.Sphere,
                  fillColor={255,255,0}),
                Rectangle(
                  extent={{-160,-130},{-140,-150}},
                  lineColor={0,0,0},
                  lineThickness=0.5),
                Rectangle(
                  extent={{-160,-100},{-140,-120}},
                  lineColor={0,0,0},
                  lineThickness=0.5),
                Rectangle(
                  extent={{-160,-70},{-140,-90}},
                  lineColor={0,0,0},
                  lineThickness=0.5),
                Rectangle(
                  extent={{-160,-10},{-140,-30}},
                  lineColor={0,0,0},
                  lineThickness=0.5),
                Rectangle(
                  extent={{-160,20},{-140,0}},
                  lineColor={0,0,0},
                  lineThickness=0.5),
                Rectangle(
                  extent={{-160,140},{-140,120}},
                  lineColor={0,0,0},
                  lineThickness=0.5),
                Rectangle(
                  extent={{-160,-40},{-140,-60}},
                  lineColor={0,0,0},
                  lineThickness=0.5),
                Rectangle(
                  extent={{-160,90},{-140,28}},
                  lineColor={0,0,0},
                  lineThickness=0.5),
                Line(
                  points={{44,62},{50,68}},
                  color={255,255,255},
                  thickness=1),
                Line(
                  points={{44,58},{54,68}},
                  color={255,255,255},
                  thickness=1),
                Line(
                  points={{48,58},{54,64}},
                  color={255,255,255},
                  thickness=1),
                Text(
                  extent={{50,78},{100,62}},
                  lineColor={0,0,0},
                  lineThickness=1,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="OW")}),
            Documentation(revisions="<html>
<p><ul>
<li><i>April 18, 2014</i> by Ana Constantin:<br/>Added documentation</li>
<li><i>August 16, 2011</i> by Ana Constantin:<br/>Implemented</li>
</ul></p>
</html>",     info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Model for the livingroom. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The following figure presents the room&apos;s layout:</p>
<p><img src=\"modelica://AixLib/Images/House/VoWo_Livingroom.png\"/></p>
</html>"));
        end Livingroom_VoWo;

        model Kitchen_VoWo "Kitchen from the VoWo appartment"
          import AixLib;

          ///////// construction parameters
          parameter Integer TMC =  1 "Themal Mass Class"
            annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice=1 "S", choice = 2 "M", choice = 3 "L", radioButtons = true));
          parameter Integer TIR = 4 "Thermal Insulation Regulation"
           annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice=1
                "EnEV_2009",                                                                                                    choice = 2
                "EnEV_2002",                                                                                                    choice = 3
                "WSchV_1995",  choice = 4 "WSchV_1984",                                                                          radioButtons = true));

           parameter Integer Floor =  1 "Floor"
            annotation(Dialog(group = "Floor", compact = true, descriptionLabel = true), choices(choice=1 "GF", choice = 2 "1F", choice = 3 "2F", radioButtons = true));

          // Outer walls properties
         parameter Real solar_absorptance_OW=0.7
            "Solar absoptance outer walls "                                     annotation (Dialog(group = "Outer wall properties", descriptionLabel = true));
         parameter Integer ModelConvOW =  1 "Heat Convection Model"
           annotation(Dialog(group = "Outer wall properties", compact = true, descriptionLabel = true), choices(choice = 1
                "DIN 6946",                                                                                                    choice = 2
                "ASHRAE Fundamentals",                                                                                                    choice = 3
                "Custom alpha",                                                                                                    radioButtons = true));

          //Initial temperatures
          parameter Modelica.SIunits.Temperature T0_air=295.15 "Air"
                                                                   annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_OW=295.15 "OW" annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_IWBath=297.15 "IWBathroom"
                                                                   annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_IWCorridor=290.15
            "IWCorridor"                                           annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_IWStraicase=288.15
            "IWStaircase"                                          annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_CE=295.35 "Ceiling"
                                                                   annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_FL=294.95 "Floor"
                                                                   annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));

          // Infiltration rate
        protected
          parameter Real n50(unit="h-1")=
          if (TIR == 1 or TIR ==2) then 3 else
          if TIR == 3 then 4 else 6
            "Air exchange rate at 50 Pa pressure difference" annotation (Dialog(tab = "Infiltration"));
          parameter Real e=0.03 "Coefficient of windshield" annotation (Dialog(tab = "Infiltration"));
          parameter Real eps=1.0 "Coefficient of height" annotation (Dialog(tab = "Infiltration"));

          // Outer wall type
          parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_OW=if TIR
               == 1 then if TMC == 1 then
              AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S() else if TMC ==
              2 then AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_M() else
              AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_L() else if TIR ==
              2 then if TMC == 1 then
              AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_S() else if TMC ==
              2 then AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_M() else
              AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_L() else if TIR ==
              3 then if TMC == 1 then
              AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_S() else if TMC
               == 2 then AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_M()
               else AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_L() else
              if TMC == 1 then
              AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_S() else if TMC
               == 2 then AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_M()
               else AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_L()
            annotation (Dialog(tab="Types"));

          //Inner wall Types
          parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_IWsimple=
              if TIR == 1 then if TMC == 1 then
              AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_S_half()
               else if TMC == 2 then
              AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_M_half()
               else AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_L_half()
               else if TIR == 2 then if TMC == 1 then
              AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_S_half()
               else if TMC == 2 then
              AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_M_half()
               else AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_L_half()
               else if TIR == 3 then if TMC == 1 then
              AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_S_half()
               else if TMC == 2 then
              AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_M_half()
               else
              AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_L_half()
               else if TMC == 1 then
              AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_S_half()
               else if TMC == 2 then
              AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_M_half()
               else
              AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_L_half()
            annotation (Dialog(tab="Types"));

          parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_IWload=
              if TIR == 1 then if TMC == 1 then
              AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half() else
              if TMC == 2 then
              AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_M_half() else
              AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_L_half() else
              if TIR == 2 then if TMC == 1 then
              AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_S_half() else
              if TMC == 2 then
              AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_M_half() else
              AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_L_half() else
              if TIR == 3 then if TMC == 1 then
              AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_S_half()
               else if TMC == 2 then
              AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_M_half()
               else AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_L_half()
               else if TMC == 1 then
              AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_S_half()
               else if TMC == 2 then
              AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_M_half()
               else AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_L_half()
            annotation (Dialog(tab="Types"));

           // Floor type
          parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_FL=if
              Floor == 1 then if TIR == 1 then
              AixLib.DataBase.Walls.EnEV2009.Floor.FLcellar_EnEV2009_SML_upHalf()
               else if TIR == 2 then
              AixLib.DataBase.Walls.EnEV2002.Floor.FLcellar_EnEV2002_SML_upHalf()
               else if TIR == 3 then
              AixLib.DataBase.Walls.WSchV1995.Floor.FLcellar_WSchV1995_SML_upHalf()
               else
              AixLib.DataBase.Walls.WSchV1984.Floor.FLcellar_WSchV1984_SML_upHalf()
               else if TIR == 1 then if (TMC == 1 or TMC == 2) then
              AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_SM_upHalf()
               else
              AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_L_upHalf()
               else if TIR == 2 then if (TMC == 1 or TMC == 2) then
              AixLib.DataBase.Walls.EnEV2002.Floor.FLpartition_EnEV2002_SM_upHalf()
               else
              AixLib.DataBase.Walls.EnEV2002.Floor.FLpartition_EnEV2002_L_upHalf()
               else if TIR == 3 then if (TMC == 1 or TMC == 2) then
              AixLib.DataBase.Walls.WSchV1995.Floor.FLpartition_WSchV1995_SM_upHalf()
               else
              AixLib.DataBase.Walls.WSchV1995.Floor.FLpartition_WSchV1995_L_upHalf()
               else if (TMC == 1 or TMC == 2) then
              AixLib.DataBase.Walls.WSchV1984.Floor.FLpartition_WSchV1984_SM_upHalf()
               else
              AixLib.DataBase.Walls.WSchV1984.Floor.FLpartition_WSchV1984_L_upHalf()
            annotation (Dialog(tab="Types"));

          // Ceiling  type
          parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_CE=if (
              Floor == 1) or (Floor == 2) then if TIR == 1 then if (TMC == 1
               or TMC == 2) then
              AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_SM_loHalf()
               else
              AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_L_loHalf()
               else if TIR == 2 then if (TMC == 1 or TMC == 2) then
              AixLib.DataBase.Walls.EnEV2002.Ceiling.CEpartition_EnEV2002_SM_loHalf()
               else
              AixLib.DataBase.Walls.EnEV2002.Ceiling.CEpartition_EnEV2002_L_loHalf()
               else if TIR == 3 then if (TMC == 1 or TMC == 2) then
              AixLib.DataBase.Walls.WSchV1995.Ceiling.CEpartition_WSchV1995_SM_loHalf()
               else
              AixLib.DataBase.Walls.WSchV1995.Ceiling.CEpartition_WSchV1995_L_loHalf()
               else if (TMC == 1 or TMC == 2) then
              AixLib.DataBase.Walls.WSchV1984.Ceiling.CEpartition_WSchV1984_SM_loHalf()
               else
              AixLib.DataBase.Walls.WSchV1984.Ceiling.CEpartition_WSchV1984_L_loHalf()
               else if TIR == 1 then
              AixLib.DataBase.Walls.EnEV2009.Ceiling.CEattic_EnEV2009_SML_loHalf()
               else if TIR == 2 then
              AixLib.DataBase.Walls.EnEV2002.Ceiling.CEattic_EnEV2002_SML_loHalf()
               else if TIR == 3 then
              AixLib.DataBase.Walls.WSchV1995.Ceiling.CEattic_WSchV1995_SML_loHalf()
               else
              AixLib.DataBase.Walls.WSchV1984.Ceiling.CEattic_WSchV1984_SML_loHalf()
            annotation (Dialog(tab="Types"));

           //Window type
          parameter
            AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple
            Type_Win=if TIR == 1 then
              AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009() else
              if TIR == 2 then
              AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2002() else
              if TIR == 3 then
              AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1995()
               else AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1984()
            annotation (Dialog(tab="Types"));

            parameter Modelica.SIunits.Volume room_V=8.35*2.46;
        public
          AixLib.Building.Components.Walls.Wall Wall_Corridor1(
            T0=T0_IWCorridor,
            outside=false,
            WallType=Type_IWsimple,
            wall_length=2.2,
            wall_height=2.46,
            withWindow=false,
            withDoor=false) annotation (Placement(transformation(
                origin={-3,30},
                extent={{-8,-51},{8,51}},
                rotation=270)));
          AixLib.Building.Components.Walls.Wall Wall_Bath1(
            T0=T0_IWBath,
            outside=false,
            WallType=Type_IWsimple,
            wall_length=3.28,
            wall_height=2.46,
            withWindow=false,
            withDoor=false) annotation (Placement(transformation(extent={{-68,
                    -50},{-62,-12}}, rotation=0)));
          AixLib.Building.Components.Walls.Wall Wall_Staircase(
            T0=T0_IWStraicase,
            outside=false,
            WallType=Type_IWload,
            wall_length=3.94,
            wall_height=2.46,
            withWindow=false,
            withDoor=false) annotation (Placement(transformation(
                origin={45,-29},
                extent={{-7,-49},{7,49}},
                rotation=180)));
        public
          AixLib.Building.Components.DryAir.Airload airload(V=room_V, T(
                start=T0_air)) annotation (Placement(transformation(extent=
                    {{-36,-16},{-16,4}}, rotation=0)));

        public
          AixLib.Building.Components.Walls.Wall Wall_Bath2(
            T0=T0_IWBath,
            outside=false,
            WallType=Type_IWsimple,
            wall_length=0.44,
            wall_height=2.46,
            withWindow=false,
            withDoor=false) annotation (Placement(transformation(
                origin={-46,-75},
                extent={{-2.99998,-16},{2.99998,16}},
                rotation=90)));
          AixLib.Building.Components.Walls.Wall outsideWall(
            wall_length=1.8,
            wall_height=2.46,
            windowarea=0.75,
            T0=T0_OW,
            solar_absorptance=solar_absorptance_OW,
            withWindow=true,
            withDoor=false,
            WallType=Type_OW,
            WindowType=Type_Win) annotation (Placement(transformation(
                origin={5,-99},
                extent={{-7,-45},{7,45}},
                rotation=90)));
          AixLib.Building.Components.Walls.Wall Wall_Corridor2(
            T0=T0_IWCorridor,
            outside=false,
            WallType=Type_IWsimple,
            wall_length=0.6,
            wall_height=2.46,
            withWindow=false,
            withDoor=false) annotation (Placement(transformation(extent={{-68,
                    -2},{-64,24}}, rotation=0)));
          AixLib.Building.Components.Walls.Wall Wall_Ceiling(
            T0=T0_CE,
            outside=false,
            WallType=Type_CE,
            wall_length=sqrt(8.35),
            wall_height=sqrt(8.35),
            ISOrientation=3,
            withWindow=false,
            withDoor=false) annotation (Placement(transformation(
                origin={80,-72},
                extent={{-1.99998,-10},{1.99998,10}},
                rotation=270)));
          AixLib.Building.Components.Walls.Wall Wall_Floor(
            T0=T0_FL,
            outside=false,
            WallType=Type_FL,
            wall_length=sqrt(8.35),
            wall_height=sqrt(8.35),
            ISOrientation=2,
            withWindow=false,
            withDoor=false) annotation (Placement(transformation(
                origin={80,-100},
                extent={{-1.99984,-10},{1.99983,10}},
                rotation=90)));
        public
          Utilities.Interfaces.SolarRad_in SolarRadiation_NW annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-20,-150})));
          Modelica.Blocks.Interfaces.RealInput AirExchangePort
            annotation (Placement(transformation(extent={{-130,56},{-90,96}}),
                iconTransformation(extent={{-108,52},{-90,70}})));
          Modelica.Blocks.Interfaces.RealInput WindSpeedPort annotation (
              Placement(transformation(extent={{-130,28},{-90,68}}),
                iconTransformation(extent={{-108,20},{-90,38}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermOutside
            annotation (Placement(transformation(extent={{-108,80},{-88,100}}),
                iconTransformation(extent={{-108,80},{-88,100}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCorridor
            annotation (Placement(transformation(extent={{-110,-20},{-90,0}}),
                iconTransformation(extent={{-110,-20},{-90,0}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermStaircase
            annotation (Placement(transformation(extent={{-110,-60},{-90,-40}}),
                iconTransformation(extent={{-110,-60},{-90,-40}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermBath annotation (
             Placement(transformation(extent={{-110,-100},{-90,-80}}),
                iconTransformation(extent={{-110,-100},{-90,-80}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling
            annotation (Placement(transformation(extent={{-110,-140},{-90,-120}}),
                iconTransformation(extent={{-110,-140},{-90,-120}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor
            annotation (Placement(transformation(extent={{-70,-160},{-50,-140}}),
                iconTransformation(extent={{-70,-160},{-50,-140}})));
          AixLib.Building.Components.DryAir.InfiltrationRate_DIN12831
            infiltrationRate(
            room_V=room_V,
            n50=n50,
            e=e,
            eps=eps) annotation (Placement(transformation(extent={{-42,72},
                    {-18,96}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermRoom
            annotation (Placement(transformation(extent={{-2,-18},{18,2}})));
          Utilities.Interfaces.Star StarRoom annotation (Placement(
                transformation(extent={{-4,-48},{16,-28}})));
          Utilities.Interfaces.Adaptors.HeatStarToComb thermStar_Demux
            annotation (Placement(transformation(
                extent={{10,-8},{-10,8}},
                rotation=180,
                origin={-30,-40})));
          AixLib.Building.Components.DryAir.VarAirExchange
            NaturalVentilation(V=room_V) annotation (Placement(
                transformation(extent={{-2,72},{22,96}})));
        equation

          connect(outsideWall.SolarRadiationPort, SolarRadiation_NW)
            annotation (Line(
              points={{-36.25,-108.1},{-36.25,-120},{-20,-120},{-20,-150}},
              color={255,128,0},
              smooth=Smooth.None));
          connect(outsideWall.WindSpeedPort, WindSpeedPort) annotation (Line(
              points={{-28,-106.35},{-28,-120},{-80,-120},{-80,48},{-110,48}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(Wall_Corridor1.port_outside, thermCorridor) annotation (Line(
              points={{-3,38.4},{-3,60},{-80,60},{-80,-10},{-100,-10}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Corridor2.port_outside, thermCorridor) annotation (Line(
              points={{-68.1,11},{-80,11},{-80,-10},{-100,-10}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Staircase.port_outside, thermStaircase) annotation (Line(
              points={{52.35,-29},{100,-29},{100,-120},{-80,-120},{-80,-50},{-100,-50}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Wall_Bath2.port_outside, thermBath) annotation (Line(
              points={{-46,-78.15},{-46,-90},{-100,-90}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Bath1.port_outside, thermBath) annotation (Line(
              points={{-68.15,-31},{-80,-31},{-80,-90},{-100,-90}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Ceiling.port_outside, thermCeiling) annotation (Line(
              points={{80,-69.9},{80,-48},{100,-48},{100,-130},{-100,-130}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Floor.port_outside, thermFloor) annotation (Line(
              points={{80,-102.1},{80,-120},{-60,-120},{-60,-150}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(infiltrationRate.port_b, airload.port) annotation (Line(
              points={{-18,84},{-12,84},{-12,60},{-56,60},{-56,10},{-40,10},{-40,-8},
                  {-35,-8}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(thermCeiling, thermCeiling) annotation (Line(
              points={{-100,-130},{-100,-130}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(infiltrationRate.port_a, thermOutside) annotation (Line(
              points={{-42,84},{-98,84},{-98,90}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(thermStar_Demux.star, StarRoom) annotation (Line(
              points={{-19.6,-45.8},{-12,-45.8},{-12,-38},{6,-38}},
              color={95,95,95},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          connect(airload.port, thermStar_Demux.therm) annotation (Line(
              points={{-35,-8},{-40,-8},{-40,-20},{-12,-20},{-12,-34.9},{-19.9,-34.9}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Wall_Bath1.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{-62,-31},{-52,-31},{-52,-39.9},{-39.4,-39.9}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Corridor2.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{-64,11},{-52,11},{-52,-40},{-46,-40},{-39.4,-39.9}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Wall_Corridor1.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{-3,22},{-3,10},{-52,10},{-52,-39.9},{-39.4,-39.9}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Bath2.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{-46,-72},{-46,-60},{-52,-60},{-52,-39.9},{-39.4,-39.9}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(outsideWall.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{5,-92},{5,-60},{-52,-60},{-52,-39.9},{-39.4,-39.9}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Wall_Staircase.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{38,-29},{28,-29},{28,-60},{-52,-60},{-52,-39.9},{-39.4,-39.9}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Wall_Floor.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{80,-98.0002},{80,-86},{28,-86},{28,-60},{-52,-60},{-52,
                  -39.9},{-39.4,-39.9}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Ceiling.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{80,-74},{80,-86},{28,-86},{28,-60},{-52,-60},{-52,-39.9},
                  {-39.4,-39.9}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(NaturalVentilation.InPort1, AirExchangePort) annotation (Line(
              points={{-0.8,76.32},{-12,76.32},{-12,60},{-80,60},{-80,76},{-110,76}},
              color={0,0,127},
              smooth=Smooth.None));

          connect(NaturalVentilation.port_a, thermOutside) annotation (Line(
              points={{-2,84},{-12,84},{-12,60},{-98,60},{-98,90}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(NaturalVentilation.port_b, airload.port) annotation (Line(
              points={{22,84},{24,84},{24,60},{-56,60},{-56,10},{-40,10},{-40,-8},{
                  -35,-8}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(outsideWall.port_outside, thermOutside) annotation (Line(
              points={{5,-106.35},{5,-120},{-80,-120},{-80,60},{-98,60},{-98,90}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(ThermRoom, airload.port) annotation (Line(
              points={{8,-8},{-10,-8},{-10,-20},{-40,-20},{-40,-8},{-35,-8}},
              color={191,0,0},
              smooth=Smooth.None));
             annotation (__Dymola_Images(Parameters(source="AixLib/Images/House/VoWo_Kitchen.png")),
                                                                        Diagram(
                coordinateSystem(
                preserveAspectRatio=true,
                extent={{-100,-150},{150,100}},
                initialScale=0.1), graphics),
            Icon(coordinateSystem(
                preserveAspectRatio=true,
                extent={{-100,-150},{150,100}},
                initialScale=0.1), graphics={
                Polygon(
                  points={{-60,58},{-60,-62},{-18,-62},{-18,-122},{100,-122},{
                      100,58},{-60,58}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Forward),
                Text(
                  extent={{-32,38},{84,4}},
                  lineColor={0,0,0},
                  fillColor={255,0,0},
                  fillPattern=FillPattern.Forward,
                  textString="Kitchen"),
                Rectangle(
                  extent={{-18,-114},{4,-134}},
                  lineColor={0,0,0},
                  fillColor={85,255,255},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{-16,-116},{2,-132}},
                  lineColor={0,0,0},
                  fillColor={170,213,255},
                  fillPattern=FillPattern.Solid),
                Line(
                  points={{-12,-128},{-2,-118}},
                  color={255,255,255},
                  thickness=1),
                Line(
                  points={{-8,-128},{-2,-122}},
                  color={255,255,255},
                  thickness=1),
                Line(
                  points={{-12,-124},{-6,-118}},
                  color={255,255,255},
                  thickness=1),
                Text(
                  extent={{-6,-122},{44,-138}},
                  lineColor={0,0,0},
                  lineThickness=1,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="OW"),
                Text(
                  extent={{12,76},{72,60}},
                  lineColor={0,0,0},
                  lineThickness=1,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="Corridor"),
                Rectangle(
                  extent={{72,82},{92,52}},
                  lineColor={0,0,0},
                  lineThickness=1,
                  fillColor={127,0,0},
                  fillPattern=FillPattern.Forward),
                Ellipse(
                  extent={{74,70},{76,68}},
                  lineColor={0,0,0},
                  pattern=LinePattern.None,
                  lineThickness=1,
                  fillPattern=FillPattern.Sphere,
                  fillColor={255,255,0}),
                Rectangle(
                  extent={{-70,-140},{-50,-160}},
                  lineColor={0,0,0},
                  lineThickness=0.5),
                Rectangle(
                  extent={{-110,-120},{-90,-140}},
                  lineColor={0,0,0},
                  lineThickness=0.5),
                Rectangle(
                  extent={{-110,-80},{-90,-100}},
                  lineColor={0,0,0},
                  lineThickness=0.5),
                Rectangle(
                  extent={{-110,-40},{-90,-60}},
                  lineColor={0,0,0},
                  lineThickness=0.5),
                Rectangle(
                  extent={{-110,0},{-90,-20}},
                  lineColor={0,0,0},
                  lineThickness=0.5),
                Rectangle(
                  extent={{-108,72},{-88,18}},
                  lineColor={0,0,0},
                  lineThickness=0.5),
                Rectangle(
                  extent={{-108,100},{-88,80}},
                  lineColor={0,0,0},
                  lineThickness=0.5)}),
            Documentation(revisions="<html>
<p><ul>
<li><i>April 18, 2014</i> by Ana Constantin:<br/>Added documentation</li>
<li><i>August 16, 2011</i> by Ana Constantin:<br/>Implemented</li>
</ul></p>
</html>",     info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Model for the kitchen.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The following figure presents the room&apos;s layout:</p>
<p><img src=\"modelica://AixLib/Images/House/VoWo_Kitchen.png\"/></p>
</html>"));
        end Kitchen_VoWo;

        model Corridor_VoWo "Corridor from the VoWo appartment"
          import AixLib;
           ///////// construction parameters
          parameter Integer TMC =  1 "Themal Mass Class"
            annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice=1 "S", choice = 2 "M", choice = 3 "L", radioButtons = true));
          parameter Integer TIR = 4 "Thermal Insulation Regulation"
           annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice=1
                "EnEV_2009",                                                                                                    choice = 2
                "EnEV_2002",                                                                                                    choice = 3
                "WSchV_1995",  choice = 4 "WSchV_1984",                                                                          radioButtons = true));

            parameter Integer Floor =  1 "Floor"
            annotation(Dialog(group = "Floor", compact = true, descriptionLabel = true), choices(choice=1 "GF", choice = 2 "1F", choice = 3 "2F", radioButtons = true));

          // Outer walls properties
         parameter Real solar_absorptance_OW=0.7
            "Solar absoptance outer walls "                                     annotation (Dialog(group = "Outer wall properties", descriptionLabel = true));
         parameter Integer ModelConvOW =  1 "Heat Convection Model"
           annotation(Dialog(group = "Outer wall properties", compact = true, descriptionLabel = true), choices(choice = 1
                "DIN 6946",                                                                                                    choice = 2
                "ASHRAE Fundamentals",                                                                                                    choice = 3
                "Custom alpha",                                                                                                    radioButtons = true));

          //Initial temperatures
          parameter Modelica.SIunits.Temperature T0_air=290.15 "Air"
                                                                   annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_Staircase=288.15
            "IWStaircase"                                                          annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_IWKitchen=295.15
            "IWKitchen"                                            annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_IWBath=297.15 "IWBath"
                                                                   annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_IWBedroom=295.15
            "IWBedroom"                                            annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_IWLivingroom=295.15
            "IWLivingroom"                                         annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_IWChild=295.15 "IWChild"
                                                                   annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_CE=295.35 "Ceiling"
                                                                   annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_FL=294.95 "Floor"
                                                                   annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));

          // Infiltration rate
        protected
          parameter Real n50(unit="h-1")=
          if (TIR == 1 or TIR ==2) then 3 else
          if TIR == 3 then 4 else 6
            "Air exchange rate at 50 Pa pressure difference" annotation (Dialog(tab = "Infiltration"));
          parameter Real e=0.03 "Coefficient of windshield" annotation (Dialog(tab = "Infiltration"));
          parameter Real eps=1.0 "Coefficient of height" annotation (Dialog(tab = "Infiltration"));

          // Outer wall type
          parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_OW=if TIR
               == 1 then if TMC == 1 then
              AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S() else if TMC ==
              2 then AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_M() else
              AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_L() else if TIR ==
              2 then if TMC == 1 then
              AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_S() else if TMC ==
              2 then AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_M() else
              AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_L() else if TIR ==
              3 then if TMC == 1 then
              AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_S() else if TMC
               == 2 then AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_M()
               else AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_L() else
              if TMC == 1 then
              AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_S() else if TMC
               == 2 then AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_M()
               else AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_L()
            annotation (Dialog(tab="Types"));

          //Inner wall Types
          parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_IWsimple=
              if TIR == 1 then if TMC == 1 then
              AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_S_half()
               else if TMC == 2 then
              AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_M_half()
               else AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_L_half()
               else if TIR == 2 then if TMC == 1 then
              AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_S_half()
               else if TMC == 2 then
              AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_M_half()
               else AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_L_half()
               else if TIR == 3 then if TMC == 1 then
              AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_S_half()
               else if TMC == 2 then
              AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_M_half()
               else
              AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_L_half()
               else if TMC == 1 then
              AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_S_half()
               else if TMC == 2 then
              AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_M_half()
               else
              AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_L_half()
            annotation (Dialog(tab="Types"));

          parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_IWload=
              if TIR == 1 then if TMC == 1 then
              AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half() else
              if TMC == 2 then
              AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_M_half() else
              AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_L_half() else
              if TIR == 2 then if TMC == 1 then
              AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_S_half() else
              if TMC == 2 then
              AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_M_half() else
              AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_L_half() else
              if TIR == 3 then if TMC == 1 then
              AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_S_half()
               else if TMC == 2 then
              AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_M_half()
               else AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_L_half()
               else if TMC == 1 then
              AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_S_half()
               else if TMC == 2 then
              AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_M_half()
               else AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_L_half()
            annotation (Dialog(tab="Types"));

           // Floor type
          parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_FL=if
              Floor == 1 then if TIR == 1 then
              AixLib.DataBase.Walls.EnEV2009.Floor.FLcellar_EnEV2009_SML_upHalf()
               else if TIR == 2 then
              AixLib.DataBase.Walls.EnEV2002.Floor.FLcellar_EnEV2002_SML_upHalf()
               else if TIR == 3 then
              AixLib.DataBase.Walls.WSchV1995.Floor.FLcellar_WSchV1995_SML_upHalf()
               else
              AixLib.DataBase.Walls.WSchV1984.Floor.FLcellar_WSchV1984_SML_upHalf()
               else if TIR == 1 then if (TMC == 1 or TMC == 2) then
              AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_SM_upHalf()
               else
              AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_L_upHalf()
               else if TIR == 2 then if (TMC == 1 or TMC == 2) then
              AixLib.DataBase.Walls.EnEV2002.Floor.FLpartition_EnEV2002_SM_upHalf()
               else
              AixLib.DataBase.Walls.EnEV2002.Floor.FLpartition_EnEV2002_L_upHalf()
               else if TIR == 3 then if (TMC == 1 or TMC == 2) then
              AixLib.DataBase.Walls.WSchV1995.Floor.FLpartition_WSchV1995_SM_upHalf()
               else
              AixLib.DataBase.Walls.WSchV1995.Floor.FLpartition_WSchV1995_L_upHalf()
               else if (TMC == 1 or TMC == 2) then
              AixLib.DataBase.Walls.WSchV1984.Floor.FLpartition_WSchV1984_SM_upHalf()
               else
              AixLib.DataBase.Walls.WSchV1984.Floor.FLpartition_WSchV1984_L_upHalf()
            annotation (Dialog(tab="Types"));

          // Ceiling  type
          parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_CE=if (
              Floor == 1) or (Floor == 2) then if TIR == 1 then if (TMC == 1
               or TMC == 2) then
              AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_SM_loHalf()
               else
              AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_L_loHalf()
               else if TIR == 2 then if (TMC == 1 or TMC == 2) then
              AixLib.DataBase.Walls.EnEV2002.Ceiling.CEpartition_EnEV2002_SM_loHalf()
               else
              AixLib.DataBase.Walls.EnEV2002.Ceiling.CEpartition_EnEV2002_L_loHalf()
               else if TIR == 3 then if (TMC == 1 or TMC == 2) then
              AixLib.DataBase.Walls.WSchV1995.Ceiling.CEpartition_WSchV1995_SM_loHalf()
               else
              AixLib.DataBase.Walls.WSchV1995.Ceiling.CEpartition_WSchV1995_L_loHalf()
               else if (TMC == 1 or TMC == 2) then
              AixLib.DataBase.Walls.WSchV1984.Ceiling.CEpartition_WSchV1984_SM_loHalf()
               else
              AixLib.DataBase.Walls.WSchV1984.Ceiling.CEpartition_WSchV1984_L_loHalf()
               else if TIR == 1 then
              AixLib.DataBase.Walls.EnEV2009.Ceiling.CEattic_EnEV2009_SML_loHalf()
               else if TIR == 2 then
              AixLib.DataBase.Walls.EnEV2002.Ceiling.CEattic_EnEV2002_SML_loHalf()
               else if TIR == 3 then
              AixLib.DataBase.Walls.WSchV1995.Ceiling.CEattic_WSchV1995_SML_loHalf()
               else
              AixLib.DataBase.Walls.WSchV1984.Ceiling.CEattic_WSchV1984_SML_loHalf()
            annotation (Dialog(tab="Types"));

           //Window type
          parameter
            AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple
            Type_Win=if TIR == 1 then
              AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009() else
              if TIR == 2 then
              AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2002() else
              if TIR == 3 then
              AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1995()
               else AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1984()
            annotation (Dialog(tab="Types"));

            parameter Modelica.SIunits.Volume room_V=5.73*2.46;
        public
          AixLib.Building.Components.Walls.Wall Wall_Children(
            T0=T0_IWChild,
            outside=false,
            WallType=Type_IWload,
            wall_length=2.13,
            wall_height=2.46,
            withWindow=false,
            withDoor=false) annotation (Placement(transformation(
                origin={46,24},
                extent={{-3.99999,-24},{3.99999,24}},
                rotation=270)));
          AixLib.Building.Components.Walls.Wall Wall_Kitchen2(
            T0=T0_IWKitchen,
            outside=false,
            WallType=Type_IWsimple,
            wall_length=2.2,
            wall_height=2.46,
            withWindow=false,
            withDoor=false) annotation (Placement(transformation(
                origin={52,-63},
                extent={{-5.00001,-30},{5.00001,30}},
                rotation=90)));
          AixLib.Building.Components.Walls.Wall Wall_Bath(
            T0=T0_IWBath,
            outside=false,
            WallType=Type_IWsimple,
            wall_length=1.31,
            wall_height=2.46,
            withWindow=false,
            withDoor=false) annotation (Placement(transformation(
                origin={-20,-99},
                extent={{-3.00001,-18},{3.00001,18}},
                rotation=90)));
          AixLib.Building.Components.Walls.Wall Wall_Kitchen1(
            T0=T0_IWKitchen,
            outside=false,
            WallType=Type_IWsimple,
            wall_length=0.6,
            wall_height=2.46,
            withWindow=false,
            withDoor=false) annotation (Placement(transformation(
                origin={-2,-74},
                extent={{-2,-12},{2,12}},
                rotation=180)));
          AixLib.Building.Components.Walls.Wall Wall_Bedroom(
            T0=T0_IWBedroom,
            outside=false,
            WallType=Type_IWload,
            wall_length=1.96,
            wall_height=2.46,
            withWindow=false,
            withDoor=false) annotation (Placement(transformation(extent={{-66,
                    -70},{-54,2}}, rotation=0)));
          AixLib.Building.Components.Walls.Wall Wall_Staircase(
            T0=T0_Staircase,
            outside=false,
            WallType=Type_IWload,
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
          AixLib.Building.Components.Walls.Wall Wall_Livingroom(
            T0=T0_IWLivingroom,
            outside=false,
            WallType=Type_IWload,
            wall_length=1.25,
            wall_height=2.46,
            withWindow=false,
            withDoor=false) annotation (Placement(transformation(
                origin={-28,24},
                extent={{-3.99999,-24},{3.99999,24}},
                rotation=270)));
          AixLib.Building.Components.DryAir.Airload airload(V=room_V, T(
                start=T0_air)) annotation (Placement(transformation(extent=
                    {{-12,-12},{-32,8}}, rotation=0)));
          AixLib.Building.Components.Walls.Wall Wall_Ceiling(
            T0=T0_CE,
            outside=false,
            WallType=Type_CE,
            wall_length=sqrt(5.73),
            wall_height=sqrt(5.73),
            ISOrientation=3,
            withWindow=false,
            withDoor=false) annotation (Placement(transformation(
                origin={117,80},
                extent={{-2,-15},{2,15}},
                rotation=270)));
          AixLib.Building.Components.Walls.Wall Wall_Floor(
            T0=T0_FL,
            outside=false,
            WallType=Type_FL,
            wall_length=sqrt(5.73),
            wall_height=sqrt(5.73),
            ISOrientation=2,
            withWindow=false,
            withDoor=false) annotation (Placement(transformation(
                origin={118,55},
                extent={{-2.99998,-16},{2.99998,16}},
                rotation=90)));
          AixLib.Building.Components.DryAir.InfiltrationRate_DIN12831
            infiltrationRate(
            room_V=room_V,
            n50=n50,
            e=e,
            eps=eps) annotation (Placement(transformation(extent={{-44,60},
                    {-18,86}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermStaircase
            annotation (Placement(transformation(extent={{-112,70},{-92,90}}),
                iconTransformation(extent={{-112,70},{-92,90}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermKitchen
            annotation (Placement(transformation(extent={{-112,40},{-92,60}}),
                iconTransformation(extent={{-112,40},{-92,60}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermBath annotation (
             Placement(transformation(extent={{-110,-50},{-90,-30}}),
                iconTransformation(extent={{-110,-50},{-90,-30}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermBedroom
            annotation (Placement(transformation(extent={{-110,-80},{-90,-60}}),
                iconTransformation(extent={{-110,-80},{-90,-60}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling
            annotation (Placement(transformation(extent={{-110,-110},{-90,-90}}),
                iconTransformation(extent={{-110,-110},{-90,-90}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor
            annotation (Placement(transformation(extent={{-110,-140},{-90,-120}}),
                iconTransformation(extent={{-110,-140},{-90,-120}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermLivingroom
            annotation (Placement(transformation(extent={{-112,10},{-92,30}}),
                iconTransformation(extent={{-112,10},{-92,30}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermChild
            annotation (Placement(transformation(extent={{-112,-20},{-92,0}}),
                iconTransformation(extent={{-112,-20},{-92,0}})));
          Utilities.Interfaces.Adaptors.HeatStarToComb thermStar_Demux
            annotation (Placement(transformation(
                extent={{-10,8},{10,-8}},
                rotation=90,
                origin={46,-26})));
        equation

          connect(infiltrationRate.port_b, airload.port) annotation (Line(
              points={{-18,73},{0,73},{0,-4},{-13,-4}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Staircase.port_outside, thermStaircase) annotation (Line(
              points={{112.2,-32},{140,-32},{140,-130},{-80,-130},{-80,80},{
                  -102,80}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Wall_Kitchen2.port_outside, thermKitchen) annotation (Line(
              points={{52,-68.25},{52,-130},{-80,-130},{-80,50},{-102,50}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(infiltrationRate.port_a, thermStaircase) annotation (Line(
              points={{-44,73},{-80,73},{-80,80},{-102,80}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Kitchen1.port_outside, thermKitchen) annotation (Line(
              points={{0.1,-74},{20,-74},{20,-130},{-80,-130},{-80,50},{-102,50}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Bath.port_outside, thermBath) annotation (Line(
              points={{-20,-102.15},{-20,-130},{-80,-130},{-80,-40},{-100,-40}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Bedroom.port_outside, thermBedroom) annotation (Line(
              points={{-66.3,-34},{-80,-34},{-80,-70},{-100,-70}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Ceiling.port_outside, thermCeiling) annotation (Line(
              points={{117,82.1},{117,96},{140,96},{140,-130},{-80,-130},{-80,-100},
                  {-100,-100}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Floor.port_outside, thermFloor) annotation (Line(
              points={{118,51.85},{118,36},{140,36},{140,-130},{-100,-130}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Livingroom.port_outside, thermLivingroom) annotation (Line(
              points={{-28,28.2},{-28,52},{-80,52},{-80,20},{-102,20}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Children.port_outside, thermChild) annotation (Line(
              points={{46,28.2},{46,52},{-80,52},{-80,-10},{-102,-10}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Kitchen2.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{52,-58},{52,-44.0875},{45.9,-44.0875},{45.9,-35.4}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Staircase.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{104,-32},{94,-32},{94,-44},{45.9,-44},{45.9,-35.4}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Kitchen1.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{-4,-74},{-14,-74},{-14,-44},{45.9,-44},{45.9,-35.4}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Bath.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{-20,-96},{-20,-80},{-14,-80},{-14,-44},{45.9,-44},{45.9,
                  -35.4}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Wall_Bedroom.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{-54,-34},{-40,-34},{-40,-80},{-14,-80},{-14,-44},{45.9,-44},
                  {45.9,-35.4}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Livingroom.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{-28,20},{-28,12},{-40,12},{-40,-80},{-14,-80},{-14,-44},
                  {45.9,-44},{45.9,-35.4}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Children.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{46,20},{46,10},{94,10},{94,-44},{45.9,-44},{45.9,-35.4}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Floor.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{118,58},{118,64},{94,64},{94,-44},{45.9,-44},{45.9,-35.4}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Ceiling.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{117,78},{117,64},{94,64},{94,-44},{45.9,-44},{45.9,-35.4}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(airload.port, thermStar_Demux.therm) annotation (Line(
              points={{-13,-4},{40.9,-4},{40.9,-15.9}},
              color={191,0,0},
              smooth=Smooth.None));
          annotation (__Dymola_Images(Parameters(source="AixLib/Images/House/VoWo_Corridor.png")),
            Icon(coordinateSystem(
                preserveAspectRatio=true,
                extent={{-100,-150},{150,100}},
                initialScale=0.1), graphics={
                Polygon(
                  points={{-60,60},{120,60},{120,-60},{20,-60},{20,-100},{-60,-100},
                      {-60,-18},{-60,60}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Forward),
                Text(
                  extent={{-26,6},{82,-26}},
                  lineColor={0,0,0},
                  fillColor={255,0,0},
                  fillPattern=FillPattern.Forward,
                  textString="Corridor"),
                Rectangle(
                  extent={{-110,-120},{-90,-140}},
                  lineColor={0,0,0},
                  lineThickness=0.5),
                Rectangle(
                  extent={{-110,-90},{-90,-110}},
                  lineColor={0,0,0},
                  lineThickness=0.5),
                Rectangle(
                  extent={{-110,-60},{-90,-80}},
                  lineColor={0,0,0},
                  lineThickness=0.5),
                Rectangle(
                  extent={{-110,-30},{-90,-50}},
                  lineColor={0,0,0},
                  lineThickness=0.5),
                Rectangle(
                  extent={{-112,60},{-92,40}},
                  lineColor={0,0,0},
                  lineThickness=0.5),
                Rectangle(
                  extent={{-112,90},{-92,70}},
                  lineColor={0,0,0},
                  lineThickness=0.5),
                Rectangle(
                  extent={{108,12},{128,-18}},
                  lineColor={0,0,0},
                  lineThickness=1,
                  fillColor={127,0,0},
                  fillPattern=FillPattern.Forward),
                Ellipse(
                  extent={{110,0},{112,-2}},
                  lineColor={0,0,0},
                  pattern=LinePattern.None,
                  lineThickness=1,
                  fillPattern=FillPattern.Sphere,
                  fillColor={255,255,0}),
                Text(
                  extent={{78,38},{164,18}},
                  lineColor={0,0,255},
                  textString="Staircase"),
                Rectangle(
                  extent={{-112,0},{-92,-20}},
                  lineColor={0,0,0},
                  lineThickness=0.5),
                Rectangle(
                  extent={{-112,30},{-92,10}},
                  lineColor={0,0,0},
                  lineThickness=0.5)}),
            Diagram(coordinateSystem(
                preserveAspectRatio=true,
                extent={{-100,-150},{150,100}},
                initialScale=0.1), graphics),
            Documentation(revisions="<html>
<p><ul>
<li><i>April 18, 2014</i> by Ana Constantin:<br/>Added documentation</li>
<li><i>August 16, 2011</i> by Ana Constantin:<br/>Implemented</li>
</ul></p>
</html>",     info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Model for the corridor.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The following figure presents the room&apos;s layout:</p>
<p><img src=\"modelica://AixLib/Images/House/VoWo_Corridor.png\"/></p>
</html>"));
        end Corridor_VoWo;

        model Bathroom_VoWo "Bathroom from the VoWo appartment"
          import AixLib;

          ///////// construction parameters
          parameter Integer TMC =  1 "Themal Mass Class"
            annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice=1 "S", choice = 2 "M", choice = 3 "L", radioButtons = true));
          parameter Integer TIR = 4 "Thermal Insulation Regulation"
           annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice=1
                "EnEV_2009",                                                                                                    choice = 2
                "EnEV_2002",                                                                                                    choice = 3
                "WSchV_1995",  choice = 4 "WSchV_1984",                                                                          radioButtons = true));
           parameter Integer Floor =  1 "Floor"
            annotation(Dialog(group = "Floor", compact = true, descriptionLabel = true), choices(choice=1 "GF", choice = 2 "1F", choice = 3 "2F", radioButtons = true));

          // Outer walls properties
         parameter Real solar_absorptance_OW=0.7
            "Solar absoptance outer walls "                                     annotation (Dialog(group = "Outer wall properties", descriptionLabel = true));
         parameter Integer ModelConvOW =  1 "Heat Convection Model"
           annotation(Dialog(group = "Outer wall properties", compact = true, descriptionLabel = true), choices(choice = 1
                "DIN 6946",                                                                                                    choice = 2
                "ASHRAE Fundamentals",                                                                                                    choice = 3
                "Custom alpha",                                                                                                    radioButtons = true));

          //Initial temperatures
          parameter Modelica.SIunits.Temperature T0_air=297.15 "Air"
                                                                   annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_Corridor=290.15
            "IWCorridor"                                                         annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_IWKitchen=295.15
            "IWKitchen"                                            annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_IWBedroom=295.15
            "IWBedroom"                                            annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_OW=295.15 "OW" annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_CE=295.35 "Ceiling"
                                                                   annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_FL=294.95 "Floor"
                                                                   annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));

          // Infiltration rate
        protected
          parameter Real n50(unit="h-1")=
          if (TIR == 1 or TIR ==2) then 3 else
          if TIR == 3 then 4 else 6
            "Air exchange rate at 50 Pa pressure difference" annotation (Dialog(tab = "Infiltration"));
          parameter Real e=0.03 "Coefficient of windshield" annotation (Dialog(tab = "Infiltration"));
          parameter Real eps=1.0 "Coefficient of height" annotation (Dialog(tab = "Infiltration"));

          // Outer wall type
          parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_OW=if TIR
               == 1 then if TMC == 1 then
              AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S() else if TMC ==
              2 then AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_M() else
              AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_L() else if TIR ==
              2 then if TMC == 1 then
              AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_S() else if TMC ==
              2 then AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_M() else
              AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_L() else if TIR ==
              3 then if TMC == 1 then
              AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_S() else if TMC
               == 2 then AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_M()
               else AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_L() else
              if TMC == 1 then
              AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_S() else if TMC
               == 2 then AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_M()
               else AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_L()
            annotation (Dialog(tab="Types"));

          //Inner wall Types
          parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_IWsimple=
              if TIR == 1 then if TMC == 1 then
              AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_S_half()
               else if TMC == 2 then
              AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_M_half()
               else AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_L_half()
               else if TIR == 2 then if TMC == 1 then
              AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_S_half()
               else if TMC == 2 then
              AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_M_half()
               else AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_L_half()
               else if TIR == 3 then if TMC == 1 then
              AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_S_half()
               else if TMC == 2 then
              AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_M_half()
               else
              AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_L_half()
               else if TMC == 1 then
              AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_S_half()
               else if TMC == 2 then
              AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_M_half()
               else
              AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_L_half()
            annotation (Dialog(tab="Types"));

          parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_IWload=
              if TIR == 1 then if TMC == 1 then
              AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half() else
              if TMC == 2 then
              AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_M_half() else
              AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_L_half() else
              if TIR == 2 then if TMC == 1 then
              AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_S_half() else
              if TMC == 2 then
              AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_M_half() else
              AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_L_half() else
              if TIR == 3 then if TMC == 1 then
              AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_S_half()
               else if TMC == 2 then
              AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_M_half()
               else AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_L_half()
               else if TMC == 1 then
              AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_S_half()
               else if TMC == 2 then
              AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_M_half()
               else AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_L_half()
            annotation (Dialog(tab="Types"));

             // Floor type
          parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_FL=if
              Floor == 1 then if TIR == 1 then
              AixLib.DataBase.Walls.EnEV2009.Floor.FLcellar_EnEV2009_SML_upHalf()
               else if TIR == 2 then
              AixLib.DataBase.Walls.EnEV2002.Floor.FLcellar_EnEV2002_SML_upHalf()
               else if TIR == 3 then
              AixLib.DataBase.Walls.WSchV1995.Floor.FLcellar_WSchV1995_SML_upHalf()
               else
              AixLib.DataBase.Walls.WSchV1984.Floor.FLcellar_WSchV1984_SML_upHalf()
               else if TIR == 1 then if (TMC == 1 or TMC == 2) then
              AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_SM_upHalf()
               else
              AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_L_upHalf()
               else if TIR == 2 then if (TMC == 1 or TMC == 2) then
              AixLib.DataBase.Walls.EnEV2002.Floor.FLpartition_EnEV2002_SM_upHalf()
               else
              AixLib.DataBase.Walls.EnEV2002.Floor.FLpartition_EnEV2002_L_upHalf()
               else if TIR == 3 then if (TMC == 1 or TMC == 2) then
              AixLib.DataBase.Walls.WSchV1995.Floor.FLpartition_WSchV1995_SM_upHalf()
               else
              AixLib.DataBase.Walls.WSchV1995.Floor.FLpartition_WSchV1995_L_upHalf()
               else if (TMC == 1 or TMC == 2) then
              AixLib.DataBase.Walls.WSchV1984.Floor.FLpartition_WSchV1984_SM_upHalf()
               else
              AixLib.DataBase.Walls.WSchV1984.Floor.FLpartition_WSchV1984_L_upHalf()
            annotation (Dialog(tab="Types"));

          // Ceiling  type
          parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_CE=if (
              Floor == 1) or (Floor == 2) then if TIR == 1 then if (TMC == 1
               or TMC == 2) then
              AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_SM_loHalf()
               else
              AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_L_loHalf()
               else if TIR == 2 then if (TMC == 1 or TMC == 2) then
              AixLib.DataBase.Walls.EnEV2002.Ceiling.CEpartition_EnEV2002_SM_loHalf()
               else
              AixLib.DataBase.Walls.EnEV2002.Ceiling.CEpartition_EnEV2002_L_loHalf()
               else if TIR == 3 then if (TMC == 1 or TMC == 2) then
              AixLib.DataBase.Walls.WSchV1995.Ceiling.CEpartition_WSchV1995_SM_loHalf()
               else
              AixLib.DataBase.Walls.WSchV1995.Ceiling.CEpartition_WSchV1995_L_loHalf()
               else if (TMC == 1 or TMC == 2) then
              AixLib.DataBase.Walls.WSchV1984.Ceiling.CEpartition_WSchV1984_SM_loHalf()
               else
              AixLib.DataBase.Walls.WSchV1984.Ceiling.CEpartition_WSchV1984_L_loHalf()
               else if TIR == 1 then
              AixLib.DataBase.Walls.EnEV2009.Ceiling.CEattic_EnEV2009_SML_loHalf()
               else if TIR == 2 then
              AixLib.DataBase.Walls.EnEV2002.Ceiling.CEattic_EnEV2002_SML_loHalf()
               else if TIR == 3 then
              AixLib.DataBase.Walls.WSchV1995.Ceiling.CEattic_WSchV1995_SML_loHalf()
               else
              AixLib.DataBase.Walls.WSchV1984.Ceiling.CEattic_WSchV1984_SML_loHalf()
            annotation (Dialog(tab="Types"));

           //Window type
          parameter
            AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple
            Type_Win=if TIR == 1 then
              AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009() else
              if TIR == 2 then
              AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2002() else
              if TIR == 3 then
              AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1995()
               else AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1984()
            annotation (Dialog(tab="Types"));

            parameter Modelica.SIunits.Volume room_V=4.65*2.46;

        public
          AixLib.Building.Components.Walls.Wall Wall_Corridor(
            T0=T0_Corridor,
            outside=false,
            WallType=Type_IWsimple,
            wall_length=1.31,
            wall_height=2.46,
            withWindow=false,
            withDoor=false) annotation (Placement(transformation(
                origin={7,37},
                extent={{-7,-39},{7,39}},
                rotation=270)));
          AixLib.Building.Components.Walls.Wall Wall_Bedroom(
            T0=T0_IWBedroom,
            outside=false,
            WallType=Type_IWload,
            wall_length=3.28,
            wall_height=2.46,
            withWindow=false,
            withDoor=false) annotation (Placement(transformation(extent={{-60,
                    -76},{-46,8}}, rotation=0)));
          AixLib.Building.Components.Walls.Wall Wall_Kitchen1(
            T0=T0_IWKitchen,
            outside=false,
            WallType=Type_IWsimple,
            wall_length=3.28,
            wall_height=2.46,
            withWindow=false,
            withDoor=false) annotation (Placement(transformation(
                origin={58,-22},
                extent={{-6,-36},{6,36}},
                rotation=180)));
          AixLib.Building.Components.DryAir.Airload airload(V=room_V, T(
                start=T0_air)) annotation (Placement(transformation(extent=
                    {{-12,-26},{8,-6}}, rotation=0)));

          AixLib.Building.Components.Walls.Wall Wall_Kitchen2(
            T0=T0_IWKitchen,
            outside=false,
            WallType=Type_IWsimple,
            wall_length=0.44,
            wall_height=2.46,
            withWindow=false,
            withDoor=false) annotation (Placement(transformation(
                origin={77,-59},
                extent={{-3,-15},{3,15}},
                rotation=270)));
          AixLib.Building.Components.Walls.Wall outsideWall(
            wall_height=2.46,
            windowarea=0.75,
            wall_length=1.75,
            withWindow=true,
            T0=T0_OW,
            solar_absorptance=solar_absorptance_OW,
            withDoor=false,
            WallType=Type_OW,
            WindowType=Type_Win) annotation (Placement(transformation(
                origin={8,-105},
                extent={{-11,-66},{11,66}},
                rotation=90)));
          AixLib.Building.Components.Walls.Wall Wall_Ceiling(
            T0=T0_CE,
            outside=false,
            WallType=Type_CE,
            wall_length=sqrt(4.65),
            wall_height=sqrt(4.65),
            ISOrientation=3,
            withWindow=false,
            withDoor=false) annotation (Placement(transformation(
                origin={106,-80},
                extent={{-1.99998,-10},{1.99998,10}},
                rotation=270)));
          AixLib.Building.Components.Walls.Wall Wall_Floor(
            T0=T0_FL,
            outside=false,
            WallType=Type_FL,
            wall_length=sqrt(4.65),
            wall_height=sqrt(4.65),
            ISOrientation=2,
            withWindow=false,
            withDoor=false) annotation (Placement(transformation(
                origin={106,-116},
                extent={{-1.99983,-10},{1.99984,10}},
                rotation=90)));
          AixLib.Building.Components.DryAir.InfiltrationRate_DIN12831
            infiltrationRate(
            room_V=room_V,
            n50=n50,
            e=e,
            eps=eps) annotation (Placement(transformation(extent={{-42,60},
                    {-16,86}})));
          Utilities.Interfaces.SolarRad_in SolarRadiation_NW annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-56,-150})));
          Modelica.Blocks.Interfaces.RealInput WindSpeedPort annotation (Placement(
                transformation(extent={{-122,-30},{-82,10}}), iconTransformation(extent={{-110,12},
                    {-94,28}})));
          Modelica.Blocks.Interfaces.RealInput AirExchangePort        annotation (
              Placement(transformation(extent={{-122,0},{-82,40}}), iconTransformation(
                  extent={{-110,52},{-94,68}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermOutside
            annotation (Placement(transformation(extent={{-110,80},{-90,100}}),
                iconTransformation(extent={{-110,80},{-90,100}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCorridor
            annotation (Placement(transformation(extent={{-110,-20},{-90,0}}),
                iconTransformation(extent={{-110,-20},{-90,0}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermKitchen
            annotation (Placement(transformation(extent={{-110,-50},{-90,-30}}),
                iconTransformation(extent={{-110,-50},{-90,-30}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermBedroom
            annotation (Placement(transformation(extent={{-110,-80},{-90,-60}}),
                iconTransformation(extent={{-110,-80},{-90,-60}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling
            annotation (Placement(transformation(extent={{-110,-110},{-90,-90}}),
                iconTransformation(extent={{-110,-110},{-90,-90}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor
            annotation (Placement(transformation(extent={{-110,-140},{-90,-120}}),
                iconTransformation(extent={{-110,-140},{-90,-120}})));
          Utilities.Interfaces.Star StarRoom annotation (Placement(
                transformation(extent={{10,-54},{30,-34}}),
                iconTransformation(extent={{10,-54},{30,-34}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermRoom annotation (
             Placement(transformation(extent={{-28,-52},{-8,-32}}),
                iconTransformation(extent={{-28,-52},{-8,-32}})));
          Utilities.Interfaces.Adaptors.HeatStarToComb thermStar_Demux
            annotation (Placement(transformation(
                extent={{-10,8},{10,-8}},
                rotation=90,
                origin={0,-68})));
          AixLib.Building.Components.DryAir.VarAirExchange
            NaturalVentilation(V=room_V) annotation (Placement(
                transformation(extent={{16,68},{44,94}})));
        equation

          connect(outsideWall.SolarRadiationPort, SolarRadiation_NW) annotation (Line(
              points={{-52.5,-119.3},{-52.5,-131.905},{-56,-131.905},{-56,-150}},
              color={255,128,0},
              smooth=Smooth.None));

          connect(outsideWall.WindSpeedPort, WindSpeedPort) annotation (Line(
              points={{-40.4,-116.55},{-40.4,-140},{-80,-140},{-80,-10},{-102,-10}},
              color={0,0,127},
              smooth=Smooth.None));

          connect(Wall_Corridor.port_outside, thermCorridor) annotation (Line(
              points={{7,44.35},{7,60},{-80,60},{-80,-10},{-100,-10}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Kitchen1.port_outside, thermKitchen) annotation (Line(
              points={{64.3,-22},{94,-22},{94,60},{-80,60},{-80,-40},{-100,-40}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Kitchen2.port_outside, thermKitchen) annotation (Line(
              points={{77,-55.85},{94,-55.85},{94,60},{-80,60},{-80,-40},{-100,-40}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Wall_Bedroom.port_outside, thermBedroom) annotation (Line(
              points={{-60.35,-34},{-80,-34},{-80,-70},{-100,-70}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Ceiling.port_outside, thermCeiling) annotation (Line(
              points={{106,-77.9},{106,-60},{134,-60},{134,-140},{-80,-140},{
                  -80,-100},{-100,-100}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Floor.port_outside, thermFloor) annotation (Line(
              points={{106,-118.1},{106,-140},{-80,-140},{-80,-130},{-100,-130}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(infiltrationRate.port_a, thermOutside) annotation (Line(
              points={{-42,73},{-80,73},{-80,90},{-100,90}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(infiltrationRate.port_b, airload.port) annotation (Line(
              points={{-16,73},{4,73},{4,60},{94,60},{94,16},{-36,16},{-36,-18},{
                  -11,-18}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(outsideWall.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{8,-94},{8,-84},{-0.1,-84},{-0.1,-77.4}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Bedroom.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{-46,-34},{-36,-34},{-36,-84},{-0.1,-84},{-0.1,-77.4}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Corridor.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{7,30},{7,16},{-36,16},{-36,-84},{-0.1,-84},{-0.1,-77.4}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Kitchen1.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{52,-22},{40,-22},{40,16},{-36,16},{-36,-84},{-0.1,-84},{-0.1,
                  -77.4}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Kitchen2.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{77,-62},{77,-84},{-0.1,-84},{-0.1,-77.4}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Ceiling.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{106,-82},{106,-92},{76,-92},{76,-84},{-0.1,-84},{-0.1,
                  -77.4}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Wall_Floor.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{106,-114},{106,-92},{76,-92},{76,-84},{-0.1,-84},{-0.1,
                  -77.4}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(thermStar_Demux.therm, ThermRoom) annotation (Line(
              points={{-5.1,-57.9},{-5.1,-42},{-18,-42}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(thermStar_Demux.star, StarRoom) annotation (Line(
              points={{5.8,-57.6},{5.8,-44},{20,-44}},
              color={95,95,95},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          connect(airload.port, thermStar_Demux.therm) annotation (Line(
              points={{-11,-18},{-36,-18},{-36,-57.9},{-5.1,-57.9}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(AirExchangePort, NaturalVentilation.InPort1) annotation (Line(
              points={{-102,20},{-80,20},{-80,60},{4,60},{4,72.68},{17.4,72.68}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(thermOutside,NaturalVentilation.port_a)  annotation (Line(
              points={{-100,90},{-80,90},{-80,60},{4,60},{4,81},{16,81}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(airload.port, NaturalVentilation.port_b) annotation (Line(
              points={{-11,-18},{-36,-18},{-36,16},{94,16},{94,60},{48,60},{48,81},
                  {44,81}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(outsideWall.port_outside, thermOutside) annotation (Line(
              points={{8,-116.55},{8,-140},{-80,-140},{-80,90},{-100,90}},
              color={191,0,0},
              smooth=Smooth.None));
            annotation (__Dymola_Images(Parameters(source="AixLib/Images/House/VoWo_Bath.png")),
                                                                        Diagram(
                coordinateSystem(
                preserveAspectRatio=true,
                extent={{-100,-150},{150,100}},
                initialScale=0.1), graphics),
            Icon(coordinateSystem(
                preserveAspectRatio=true,
                extent={{-100,-150},{150,100}},
                initialScale=0.1), graphics={
                Polygon(
                  points={{-58,62},{-58,-118},{104,-118},{104,-58},{42,-58},{42,62},{-58,
                      62}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Forward),
                Text(
                  extent={{-44,-108},{82,-58}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Forward,
                  textString="Bath"),
                Rectangle(
                  extent={{-30,-108},{-8,-128}},
                  lineColor={0,0,0},
                  fillColor={85,255,255},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{-28,-110},{-10,-126}},
                  lineColor={0,0,0},
                  fillColor={170,213,255},
                  fillPattern=FillPattern.Solid),
                Line(
                  points={{-24,-122},{-14,-112}},
                  color={255,255,255},
                  thickness=1),
                Line(
                  points={{-20,-122},{-14,-116}},
                  color={255,255,255},
                  thickness=1),
                Line(
                  points={{-24,-118},{-18,-112}},
                  color={255,255,255},
                  thickness=1),
                Text(
                  extent={{-20,-118},{30,-134}},
                  lineColor={0,0,0},
                  lineThickness=1,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="OW"),
                Rectangle(
                  extent={{20,92},{40,62}},
                  lineColor={0,0,0},
                  lineThickness=1,
                  fillColor={127,0,0},
                  fillPattern=FillPattern.Forward),
                Ellipse(
                  extent={{22,80},{24,78}},
                  lineColor={0,0,0},
                  pattern=LinePattern.None,
                  lineThickness=1,
                  fillPattern=FillPattern.Sphere,
                  fillColor={255,255,0}),
                Text(
                  extent={{36,84},{86,68}},
                  lineColor={0,0,0},
                  lineThickness=1,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="Corridor"),
                Rectangle(
                  extent={{-110,-120},{-90,-140}},
                  lineColor={0,0,0},
                  lineThickness=0.5),
                Rectangle(
                  extent={{-110,-90},{-90,-110}},
                  lineColor={0,0,0},
                  lineThickness=0.5),
                Rectangle(
                  extent={{-110,-60},{-90,-80}},
                  lineColor={0,0,0},
                  lineThickness=0.5),
                Rectangle(
                  extent={{-110,-30},{-90,-50}},
                  lineColor={0,0,0},
                  lineThickness=0.5),
                Rectangle(
                  extent={{-110,0},{-90,-20}},
                  lineColor={0,0,0},
                  lineThickness=0.5),
                Rectangle(
                  extent={{-110,68},{-90,12}},
                  lineColor={0,0,0},
                  lineThickness=0.5),
                Rectangle(
                  extent={{-110,100},{-90,80}},
                  lineColor={0,0,0},
                  lineThickness=0.5)}),
            Documentation(revisions="<html>
<p><ul>
<li><i>April 18, 2014</i> by Ana Constantin:<br/>Added documentation</li>
<li><i>August 16, 2011</i> by Ana Constantin:<br/>Implemented</li>
</ul></p>
</html>",     info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Model for the bathroom.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The following figure presents the room&apos;s layout:</p>
<p><img src=\"modelica://AixLib/Images/House/VoWo_Bath.png\"/></p>
</html>"));
        end Bathroom_VoWo;

        model Bedroom_VoWo "Bedroom from the VoWo appartment"
          import AixLib;
          ///////// construction parameters
          parameter Integer TMC =  1 "Themal Mass Class"
            annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice=1 "S", choice = 2 "M", choice = 3 "L", radioButtons = true));
          parameter Integer TIR = 4 "Thermal Insulation Regulation"
           annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice=1
                "EnEV_2009",                                                                                                    choice = 2
                "EnEV_2002",                                                                                                    choice = 3
                "WSchV_1995",  choice = 4 "WSchV_1984",                                                                          radioButtons = true));

          parameter Integer Floor =  1 "Floor"
            annotation(Dialog(group = "Floor", compact = true, descriptionLabel = true), choices(choice=1 "GF", choice = 2 "1F", choice = 3 "2F", radioButtons = true));

          // Outer walls properties
         parameter Real solar_absorptance_OW=0.7
            "Solar absoptance outer walls "                                     annotation (Dialog(group = "Outer wall properties", descriptionLabel = true));
         parameter Integer ModelConvOW =  1 "Heat Convection Model"
           annotation(Dialog(group = "Outer wall properties", compact = true, descriptionLabel = true), choices(choice = 1
                "DIN 6946",                                                                                                    choice = 2
                "ASHRAE Fundamentals",                                                                                                    choice = 3
                "Custom alpha",                                                                                                    radioButtons = true));

          //Initial temperatures
          parameter Modelica.SIunits.Temperature T0_air=295.15 "Air"
                                                                   annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_OW=295.15 "OW" annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_IWLivingroom=295.15
            "IWLivingroom"                                         annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_IWCorridor=290.15
            "IWCorridor"                                           annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_IWBathroom=297.15
            "IWBathroom"                                           annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_IWNeighbour=295.15
            "IWNeighbour"                                          annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_CE=295.35 "Ceiling"
                                                                   annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_FL=294.95 "Floor"
                                                                   annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));

          // Infiltration rate
        protected
          parameter Real n50(unit="h-1")=
          if (TIR == 1 or TIR ==2) then 3 else
          if TIR == 3 then 4 else 6
            "Air exchange rate at 50 Pa pressure difference" annotation (Dialog(tab = "Infiltration"));
          parameter Real e=0.03 "Coefficient of windshield" annotation (Dialog(tab = "Infiltration"));
          parameter Real eps=1.0 "Coefficient of height" annotation (Dialog(tab = "Infiltration"));

          // Outer wall type
          parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_OW=if TIR
               == 1 then if TMC == 1 then
              AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S() else if TMC ==
              2 then AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_M() else
              AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_L() else if TIR ==
              2 then if TMC == 1 then
              AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_S() else if TMC ==
              2 then AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_M() else
              AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_L() else if TIR ==
              3 then if TMC == 1 then
              AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_S() else if TMC
               == 2 then AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_M()
               else AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_L() else
              if TMC == 1 then
              AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_S() else if TMC
               == 2 then AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_M()
               else AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_L()
            annotation (Dialog(tab="Types"));

          //Inner wall Types

          parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_IWload=
              if TIR == 1 then if TMC == 1 then
              AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half() else
              if TMC == 2 then
              AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_M_half() else
              AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_L_half() else
              if TIR == 2 then if TMC == 1 then
              AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_S_half() else
              if TMC == 2 then
              AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_M_half() else
              AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_L_half() else
              if TIR == 3 then if TMC == 1 then
              AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_S_half()
               else if TMC == 2 then
              AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_M_half()
               else AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_L_half()
               else if TMC == 1 then
              AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_S_half()
               else if TMC == 2 then
              AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_M_half()
               else AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_L_half()
            annotation (Dialog(tab="Types"));

          parameter AixLib.DataBase.Walls.WallBaseDataDefinition
            Type_IWNeigbour=if TIR == 1 then if TMC == 1 then
              AixLib.DataBase.Walls.EnEV2009.IW.IWneighbour_EnEV2009_S_half()
               else if TMC == 2 then
              AixLib.DataBase.Walls.EnEV2009.IW.IWneighbour_EnEV2009_M_half()
               else
              AixLib.DataBase.Walls.EnEV2009.IW.IWneighbour_EnEV2009_L_half()
               else if TIR == 2 then if TMC == 1 then
              AixLib.DataBase.Walls.EnEV2002.IW.IWneighbour_EnEV2002_S_half()
               else if TMC == 2 then
              AixLib.DataBase.Walls.EnEV2002.IW.IWneighbour_EnEV2002_M_half()
               else
              AixLib.DataBase.Walls.EnEV2002.IW.IWneighbour_EnEV2002_L_half()
               else if TIR == 3 then if TMC == 1 then
              AixLib.DataBase.Walls.WSchV1995.IW.IWneighbour_WSchV1995_S_half()
               else if TMC == 2 then
              AixLib.DataBase.Walls.WSchV1995.IW.IWneighbour_WSchV1995_M_half()
               else
              AixLib.DataBase.Walls.WSchV1995.IW.IWneighbour_WSchV1995_L_half()
               else if TMC == 1 then
              AixLib.DataBase.Walls.WSchV1984.IW.IWneighbour_WSchV1984_S_half()
               else if TMC == 2 then
              AixLib.DataBase.Walls.WSchV1984.IW.IWneighbour_WSchV1984_M_half()
               else
              AixLib.DataBase.Walls.WSchV1984.IW.IWneighbour_WSchV1984_L_half()
            annotation (Dialog(tab="Types"));

           // Floor type
          parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_FL=if
              Floor == 1 then if TIR == 1 then
              AixLib.DataBase.Walls.EnEV2009.Floor.FLcellar_EnEV2009_SML_upHalf()
               else if TIR == 2 then
              AixLib.DataBase.Walls.EnEV2002.Floor.FLcellar_EnEV2002_SML_upHalf()
               else if TIR == 3 then
              AixLib.DataBase.Walls.WSchV1995.Floor.FLcellar_WSchV1995_SML_upHalf()
               else
              AixLib.DataBase.Walls.WSchV1984.Floor.FLcellar_WSchV1984_SML_upHalf()
               else if TIR == 1 then if (TMC == 1 or TMC == 2) then
              AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_SM_upHalf()
               else
              AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_L_upHalf()
               else if TIR == 2 then if (TMC == 1 or TMC == 2) then
              AixLib.DataBase.Walls.EnEV2002.Floor.FLpartition_EnEV2002_SM_upHalf()
               else
              AixLib.DataBase.Walls.EnEV2002.Floor.FLpartition_EnEV2002_L_upHalf()
               else if TIR == 3 then if (TMC == 1 or TMC == 2) then
              AixLib.DataBase.Walls.WSchV1995.Floor.FLpartition_WSchV1995_SM_upHalf()
               else
              AixLib.DataBase.Walls.WSchV1995.Floor.FLpartition_WSchV1995_L_upHalf()
               else if (TMC == 1 or TMC == 2) then
              AixLib.DataBase.Walls.WSchV1984.Floor.FLpartition_WSchV1984_SM_upHalf()
               else
              AixLib.DataBase.Walls.WSchV1984.Floor.FLpartition_WSchV1984_L_upHalf()
            annotation (Dialog(tab="Types"));

          // Ceiling  type
          parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_CE=if (
              Floor == 1) or (Floor == 2) then if TIR == 1 then if (TMC == 1
               or TMC == 2) then
              AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_SM_loHalf()
               else
              AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_L_loHalf()
               else if TIR == 2 then if (TMC == 1 or TMC == 2) then
              AixLib.DataBase.Walls.EnEV2002.Ceiling.CEpartition_EnEV2002_SM_loHalf()
               else
              AixLib.DataBase.Walls.EnEV2002.Ceiling.CEpartition_EnEV2002_L_loHalf()
               else if TIR == 3 then if (TMC == 1 or TMC == 2) then
              AixLib.DataBase.Walls.WSchV1995.Ceiling.CEpartition_WSchV1995_SM_loHalf()
               else
              AixLib.DataBase.Walls.WSchV1995.Ceiling.CEpartition_WSchV1995_L_loHalf()
               else if (TMC == 1 or TMC == 2) then
              AixLib.DataBase.Walls.WSchV1984.Ceiling.CEpartition_WSchV1984_SM_loHalf()
               else
              AixLib.DataBase.Walls.WSchV1984.Ceiling.CEpartition_WSchV1984_L_loHalf()
               else if TIR == 1 then
              AixLib.DataBase.Walls.EnEV2009.Ceiling.CEattic_EnEV2009_SML_loHalf()
               else if TIR == 2 then
              AixLib.DataBase.Walls.EnEV2002.Ceiling.CEattic_EnEV2002_SML_loHalf()
               else if TIR == 3 then
              AixLib.DataBase.Walls.WSchV1995.Ceiling.CEattic_WSchV1995_SML_loHalf()
               else
              AixLib.DataBase.Walls.WSchV1984.Ceiling.CEattic_WSchV1984_SML_loHalf()
            annotation (Dialog(tab="Types"));

           //Window type
          parameter
            AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple
            Type_Win=if TIR == 1 then
              AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009() else
              if TIR == 2 then
              AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2002() else
              if TIR == 3 then
              AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1995()
               else AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1984()
            annotation (Dialog(tab="Types"));

            parameter Modelica.SIunits.Volume room_V=3.105*5.30*2.46;

        public
          AixLib.Building.Components.Walls.Wall Wall_Livingroom(
            T0=T0_IWLivingroom,
            outside=false,
            WallType=Type_IWload,
            wall_length=3.105,
            wall_height=2.46,
            withWindow=false,
            withDoor=false) annotation (Placement(transformation(
                origin={-10,42},
                extent={{-7.99999,-48},{7.99999,48}},
                rotation=270)));
          AixLib.Building.Components.Walls.Wall Wall_Neighbour(
            T0=T0_IWNeighbour,
            outside=false,
            WallType=Type_IWNeigbour,
            wall_length=5.3,
            wall_height=2.46,
            withWindow=false,
            withDoor=false) annotation (Placement(transformation(extent={{-74,
                    -58},{-60,20}}, rotation=0)));
          AixLib.Building.Components.Walls.Wall Wall_Bath(
            T0=T0_IWBathroom,
            outside=false,
            WallType=Type_IWload,
            wall_length=3.28,
            wall_height=2.46,
            withWindow=false,
            withDoor=false) annotation (Placement(transformation(
                origin={61,-40},
                extent={{-4.99999,-28},{4.99999,28}},
                rotation=180)));
          AixLib.Building.Components.DryAir.Airload airload(V=room_V, T(
                start=T0_air)) annotation (Placement(transformation(extent=
                    {{30,-2},{10,18}}, rotation=0)));

          AixLib.Building.Components.Walls.Wall outsideWall(
            wall_length=3.105,
            wall_height=2.46,
            windowarea=1.84,
            withWindow=true,
            T0=T0_OW,
            solar_absorptance=solar_absorptance_OW,
            WallType=Type_OW,
            WindowType=Type_Win,
            outside=true,
            withDoor=false) annotation (Placement(transformation(
                origin={-4,-92},
                extent={{-10,-60},{10,60}},
                rotation=90)));
          AixLib.Building.Components.Walls.Wall Wall_Ceiling(
            T0=T0_CE,
            outside=false,
            WallType=Type_CE,
            wall_length=3.105,
            wall_height=5.30,
            ISOrientation=3,
            withWindow=false,
            withDoor=false) annotation (Placement(transformation(
                origin={96,-62},
                extent={{-2,-12},{2,12}},
                rotation=270)));
          AixLib.Building.Components.Walls.Wall Wall_Floor(
            T0=T0_FL,
            outside=false,
            WallType=Type_FL,
            wall_length=3.105,
            wall_height=5.30,
            ISOrientation=2,
            withWindow=false,
            withDoor=false) annotation (Placement(transformation(
                origin={96,-100},
                extent={{-1.99983,-10},{1.99984,10}},
                rotation=90)));
          AixLib.Building.Components.Walls.Wall Wall_Corridor(
            T0=T0_IWCorridor,
            outside=false,
            WallType=Type_IWload,
            wall_length=1.96,
            wall_height=2.46,
            withWindow=false,
            withDoor=false) annotation (Placement(transformation(
                origin={59,16},
                extent={{-3.00002,-16},{2.99997,16}},
                rotation=180)));
          AixLib.Building.Components.DryAir.InfiltrationRate_DIN12831
            infiltrationRate(
            room_V=room_V,
            n50=n50,
            e=e,
            eps=eps) annotation (Placement(transformation(extent={{-44,80},
                    {-18,106}})));
          Utilities.Interfaces.SolarRad_in SolarRadiation_NW annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-60,-150})));
          Modelica.Blocks.Interfaces.RealInput WindSpeedPort annotation (Placement(
                transformation(extent={{-128,-24},{-88,16}}), iconTransformation(extent={{-110,20},
                    {-90,40}})));
          Modelica.Blocks.Interfaces.RealInput AirExchangePort        annotation (
              Placement(transformation(extent={{-130,30},{-90,70}}),iconTransformation(
                  extent={{-110,50},{-90,70}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermOutside
            annotation (Placement(transformation(extent={{-110,80},{-90,100}}),
                iconTransformation(extent={{-110,80},{-90,100}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermLivingroom
            annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
                iconTransformation(extent={{-110,-10},{-90,10}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCorridor
            annotation (Placement(transformation(extent={{-110,-40},{-90,-20}}),
                iconTransformation(extent={{-110,-40},{-90,-20}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermBath annotation (
             Placement(transformation(extent={{-110,-70},{-90,-50}}),
                iconTransformation(extent={{-110,-70},{-90,-50}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling
            annotation (Placement(transformation(extent={{-110,-130},{-90,-110}}),
                iconTransformation(extent={{-110,-130},{-90,-110}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor
            annotation (Placement(transformation(extent={{-110,-160},{-90,-140}}),
                iconTransformation(extent={{-110,-160},{-90,-140}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermNeigbour
            annotation (Placement(transformation(extent={{-110,-100},{-90,-80}}),
                iconTransformation(extent={{-110,-100},{-90,-80}})));
          Utilities.Interfaces.Star StarRoom annotation (Placement(
                transformation(extent={{18,-44},{38,-24}}),
                iconTransformation(extent={{18,-44},{38,-24}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermRoom annotation (
             Placement(transformation(extent={{-20,-46},{0,-26}}),
                iconTransformation(extent={{-20,-46},{0,-26}})));
          Utilities.Interfaces.Adaptors.HeatStarToComb thermStar_Demux
            annotation (Placement(transformation(
                extent={{-10,8},{10,-8}},
                rotation=90,
                origin={14,-60})));
          AixLib.Building.Components.DryAir.VarAirExchange
            NaturalVentilation(V=room_V) annotation (Placement(
                transformation(extent={{66,72},{94,98}})));
        equation

          connect(outsideWall.SolarRadiationPort, SolarRadiation_NW) annotation (Line(
              points={{-59,-105},{-59,-118.691},{-60,-118.691},{-60,-150}},
              color={255,128,0},
              smooth=Smooth.None));

          connect(outsideWall.WindSpeedPort, WindSpeedPort) annotation (Line(
              points={{-48,-102.5},{-48,-130},{-80,-130},{-80,-4},{-108,-4}},
              color={0,0,127},
              smooth=Smooth.None));

          connect(infiltrationRate.port_a, thermOutside) annotation (Line(
              points={{-44,93},{-61.35,93},{-61.35,90},{-100,90}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(infiltrationRate.port_b, airload.port) annotation (Line(
              points={{-18,93},{-18,92},{44,92},{44,6},{29,6}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Livingroom.port_outside, thermLivingroom) annotation (Line(
              points={{-10,50.4},{-10,50.4},{-10,66},{-80,66},{-80,0},{-100,0}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Corridor.port_outside, thermCorridor) annotation (Line(
              points={{62.15,16},{84,16},{84,66},{-80,66},{-80,-30},{-100,-30}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Bath.port_outside, thermBath) annotation (Line(
              points={{66.25,-40},{80,-40},{80,-130},{-80,-130},{-80,-60},{-100,
                  -60}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Wall_Ceiling.port_outside, thermCeiling) annotation (Line(
              points={{96,-59.9},{96,-48},{130,-48},{130,-130},{-80,-130},{-80,-120},
                  {-100,-120}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Neighbour.port_outside, thermNeigbour) annotation (Line(
              points={{-74.35,-19},{-80,-19},{-80,-90},{-100,-90}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(thermFloor, Wall_Floor.port_outside) annotation (Line(
              points={{-100,-150},{-90,-150},{-90,-142},{-80,-142},{-80,-130},{
                  96,-130},{96,-102.1}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(outsideWall.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{-4,-82},{-4,-74},{13.9,-74},{13.9,-69.4}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(thermStar_Demux.thermStarComb, Wall_Ceiling.thermStarComb_inside)
            annotation (Line(
              points={{13.9,-69.4},{13.9,-74},{96,-74},{96,-64}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Floor.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{96,-98.0002},{96,-74},{13.9,-74},{13.9,-69.4}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(thermStar_Demux.star, StarRoom) annotation (Line(
              points={{19.8,-49.6},{19.8,-43.8},{28,-43.8},{28,-34}},
              color={95,95,95},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          connect(thermStar_Demux.therm, airload.port) annotation (Line(
              points={{8.9,-49.9},{8.9,-16},{44,-16},{44,6},{29,6}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(thermStar_Demux.therm, ThermRoom) annotation (Line(
              points={{8.9,-49.9},{8.9,-36},{-10,-36}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Neighbour.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{-60,-19},{-48,-19},{-48,-74},{13.9,-74},{13.9,-69.4}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Livingroom.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{-10,34},{-10,24},{-48,24},{-48,-74},{13.9,-74},{13.9,
                  -69.4}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Wall_Corridor.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{56,16},{44,16},{44,-74},{13.9,-74},{13.9,-69.4}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Wall_Bath.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{56,-40},{44,-40},{44,-74},{13.9,-74},{13.9,-69.4}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(AirExchangePort, NaturalVentilation.InPort1) annotation (Line(
              points={{-110,50},{-80,50},{-80,66},{44,66},{44,76.68},{67.4,76.68}},
              color={0,0,127},
              smooth=Smooth.None));

          connect(NaturalVentilation.port_a, thermOutside) annotation (Line(
              points={{66,85},{44,85},{44,90},{-100,90}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(airload.port, NaturalVentilation.port_b) annotation (Line(
              points={{29,6},{44,6},{44,66},{100,66},{100,85},{94,85}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(outsideWall.port_outside, thermOutside) annotation (Line(
              points={{-4,-102.5},{-4,-130},{-80,-130},{-80,90},{-100,90}},
              color={191,0,0},
              smooth=Smooth.None));
          annotation (__Dymola_Images(Parameters(source="AixLib/Images/House/VoWo_Bedroom.png")),
            Diagram(coordinateSystem(
                preserveAspectRatio=true,
                extent={{-100,-150},{150,100}},
                initialScale=0.1), graphics),
            Icon(coordinateSystem(
                preserveAspectRatio=true,
                extent={{-100,-150},{150,100}},
                initialScale=0.1), graphics={
                Rectangle(
                  extent={{-54,68},{98,-112}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Forward),
                Text(
                  extent={{-40,2},{84,-26}},
                  lineColor={0,0,0},
                  fillColor={255,0,0},
                  fillPattern=FillPattern.Forward,
                  textString="Bedroom"),
                Rectangle(
                  extent={{-42,-104},{-20,-124}},
                  lineColor={0,0,0},
                  fillColor={85,255,255},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{-40,-106},{-22,-122}},
                  lineColor={0,0,0},
                  fillColor={170,213,255},
                  fillPattern=FillPattern.Solid),
                Line(
                  points={{-36,-118},{-26,-108}},
                  color={255,255,255},
                  thickness=1),
                Line(
                  points={{-32,-118},{-26,-112}},
                  color={255,255,255},
                  thickness=1),
                Line(
                  points={{-36,-114},{-30,-108}},
                  color={255,255,255},
                  thickness=1),
                Text(
                  extent={{-32,-112},{18,-128}},
                  lineColor={0,0,0},
                  lineThickness=1,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="OW"),
                Text(
                  extent={{26,92},{76,76}},
                  lineColor={0,0,0},
                  lineThickness=1,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="Corridor"),
                Rectangle(
                  extent={{-54,94},{-34,64}},
                  lineColor={0,0,0},
                  lineThickness=1,
                  fillColor={127,0,0},
                  fillPattern=FillPattern.Forward),
                Ellipse(
                  extent={{-52,82},{-50,80}},
                  lineColor={0,0,0},
                  pattern=LinePattern.None,
                  lineThickness=1,
                  fillPattern=FillPattern.Sphere,
                  fillColor={255,255,0}),
                Text(
                  extent={{-72,-16},{-76,-18}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  textString="Edit Here"),
                Rectangle(
                  extent={{-110,-110},{-90,-130}},
                  lineColor={0,0,0},
                  lineThickness=0.5),
                Rectangle(
                  extent={{-110,-80},{-90,-100}},
                  lineColor={0,0,0},
                  lineThickness=0.5),
                Rectangle(
                  extent={{-110,-20},{-90,-40}},
                  lineColor={0,0,0},
                  lineThickness=0.5),
                Rectangle(
                  extent={{-110,10},{-90,-10}},
                  lineColor={0,0,0},
                  lineThickness=0.5),
                Rectangle(
                  extent={{-110,72},{-90,18}},
                  lineColor={0,0,0},
                  lineThickness=0.5),
                Rectangle(
                  extent={{-110,100},{-90,80}},
                  lineColor={0,0,0},
                  lineThickness=0.5),
                Rectangle(
                  extent={{-110,-50},{-90,-70}},
                  lineColor={0,0,0},
                  lineThickness=0.5),
                Rectangle(
                  extent={{-110,-140},{-90,-160}},
                  lineColor={0,0,0},
                  lineThickness=0.5)}),
            Documentation(revisions="<html>
<p><ul>
<li><i>April 18, 2014</i> by Ana Constantin:<br/>Added documentation</li>
<li><i>August 16, 2011</i> by Ana Constantin:<br/>Implemented</li>
</ul></p>
</html>",     info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Model for the bedroom.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The following figure presents the room&apos;s layout:</p>
<p><img src=\"modelica://AixLib/Images/House/VoWo_Bedroom.png\"/></p>
</html>"));
        end Bedroom_VoWo;

        model Children_VoWo "Children room from the VoWo appartment"
          import AixLib;

          ///////// construction parameters
          parameter Integer TMC =  1 "Themal Mass Class"
            annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice=1 "S", choice = 2 "M", choice = 3 "L", radioButtons = true));
          parameter Integer TIR = 4 "Thermal Insulation Regulation"
           annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice=1
                "EnEV_2009",                                                                                                    choice = 2
                "EnEV_2002",                                                                                                    choice = 3
                "WSchV_1995",  choice = 4 "WSchV_1984",                                                                          radioButtons = true));

           parameter Integer Floor =  1 "Floor"
            annotation(Dialog(group = "Floor", compact = true, descriptionLabel = true), choices(choice=1 "GF", choice = 2 "1F", choice = 3 "2F", radioButtons = true));

          // Outer walls properties
         parameter Real solar_absorptance_OW=0.7
            "Solar absoptance outer walls "                                     annotation (Dialog(group = "Outer wall properties", descriptionLabel = true));
         parameter Integer ModelConvOW =  1 "Heat Convection Model"
           annotation(Dialog(group = "Outer wall properties", compact = true, descriptionLabel = true), choices(choice = 1
                "DIN 6946",                                                                                                    choice = 2
                "ASHRAE Fundamentals",                                                                                                    choice = 3
                "Custom alpha",                                                                                                    radioButtons = true));

          //Initial temperatures
          parameter Modelica.SIunits.Temperature T0_air=295.15 "Air"
                                                                   annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_OW=295.15 "OW" annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_IWLivingroom=294.15
            "IWLivingroom"                                         annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_IWNeighbour=294.15
            "IWNeighbour"                                          annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_IWCorridor=290.15
            "IWCorridor"                                           annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_IWStraicase=288.15
            "IWStaircase"                                          annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_CE=295.35 "Ceiling"
                                                                   annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_FL=294.95 "Floor"
                                                                   annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));

          // Infiltration rate
        protected
          parameter Real n50(unit="h-1")=
          if (TIR == 1 or TIR ==2) then 3 else
          if TIR == 3 then 4 else 6
            "Air exchange rate at 50 Pa pressure difference" annotation (Dialog(tab = "Infiltration"));
          parameter Real e=0.03 "Coefficient of windshield" annotation (Dialog(tab = "Infiltration"));
          parameter Real eps=1.0 "Coefficient of height" annotation (Dialog(tab = "Infiltration"));

          // Outer wall type
          parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_OW=if TIR
               == 1 then if TMC == 1 then
              AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S() else if TMC ==
              2 then AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_M() else
              AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_L() else if TIR ==
              2 then if TMC == 1 then
              AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_S() else if TMC ==
              2 then AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_M() else
              AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_L() else if TIR ==
              3 then if TMC == 1 then
              AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_S() else if TMC
               == 2 then AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_M()
               else AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_L() else
              if TMC == 1 then
              AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_S() else if TMC
               == 2 then AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_M()
               else AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_L()
            annotation (Dialog(tab="Types"));

          //Inner wall Types
          parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_IWload=
              if TIR == 1 then if TMC == 1 then
              AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half() else
              if TMC == 2 then
              AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_M_half() else
              AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_L_half() else
              if TIR == 2 then if TMC == 1 then
              AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_S_half() else
              if TMC == 2 then
              AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_M_half() else
              AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_L_half() else
              if TIR == 3 then if TMC == 1 then
              AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_S_half()
               else if TMC == 2 then
              AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_M_half()
               else AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_L_half()
               else if TMC == 1 then
              AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_S_half()
               else if TMC == 2 then
              AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_M_half()
               else AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_L_half()
            annotation (Dialog(tab="Types"));

           // Floor type
          parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_FL=if
              Floor == 1 then if TIR == 1 then
              AixLib.DataBase.Walls.EnEV2009.Floor.FLcellar_EnEV2009_SML_upHalf()
               else if TIR == 2 then
              AixLib.DataBase.Walls.EnEV2002.Floor.FLcellar_EnEV2002_SML_upHalf()
               else if TIR == 3 then
              AixLib.DataBase.Walls.WSchV1995.Floor.FLcellar_WSchV1995_SML_upHalf()
               else
              AixLib.DataBase.Walls.WSchV1984.Floor.FLcellar_WSchV1984_SML_upHalf()
               else if TIR == 1 then if (TMC == 1 or TMC == 2) then
              AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_SM_upHalf()
               else
              AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_L_upHalf()
               else if TIR == 2 then if (TMC == 1 or TMC == 2) then
              AixLib.DataBase.Walls.EnEV2002.Floor.FLpartition_EnEV2002_SM_upHalf()
               else
              AixLib.DataBase.Walls.EnEV2002.Floor.FLpartition_EnEV2002_L_upHalf()
               else if TIR == 3 then if (TMC == 1 or TMC == 2) then
              AixLib.DataBase.Walls.WSchV1995.Floor.FLpartition_WSchV1995_SM_upHalf()
               else
              AixLib.DataBase.Walls.WSchV1995.Floor.FLpartition_WSchV1995_L_upHalf()
               else if (TMC == 1 or TMC == 2) then
              AixLib.DataBase.Walls.WSchV1984.Floor.FLpartition_WSchV1984_SM_upHalf()
               else
              AixLib.DataBase.Walls.WSchV1984.Floor.FLpartition_WSchV1984_L_upHalf()
            annotation (Dialog(tab="Types"));

          // Ceiling  type
          parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_CE=if (
              Floor == 1) or (Floor == 2) then if TIR == 1 then if (TMC == 1
               or TMC == 2) then
              AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_SM_loHalf()
               else
              AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_L_loHalf()
               else if TIR == 2 then if (TMC == 1 or TMC == 2) then
              AixLib.DataBase.Walls.EnEV2002.Ceiling.CEpartition_EnEV2002_SM_loHalf()
               else
              AixLib.DataBase.Walls.EnEV2002.Ceiling.CEpartition_EnEV2002_L_loHalf()
               else if TIR == 3 then if (TMC == 1 or TMC == 2) then
              AixLib.DataBase.Walls.WSchV1995.Ceiling.CEpartition_WSchV1995_SM_loHalf()
               else
              AixLib.DataBase.Walls.WSchV1995.Ceiling.CEpartition_WSchV1995_L_loHalf()
               else if (TMC == 1 or TMC == 2) then
              AixLib.DataBase.Walls.WSchV1984.Ceiling.CEpartition_WSchV1984_SM_loHalf()
               else
              AixLib.DataBase.Walls.WSchV1984.Ceiling.CEpartition_WSchV1984_L_loHalf()
               else if TIR == 1 then
              AixLib.DataBase.Walls.EnEV2009.Ceiling.CEattic_EnEV2009_SML_loHalf()
               else if TIR == 2 then
              AixLib.DataBase.Walls.EnEV2002.Ceiling.CEattic_EnEV2002_SML_loHalf()
               else if TIR == 3 then
              AixLib.DataBase.Walls.WSchV1995.Ceiling.CEattic_WSchV1995_SML_loHalf()
               else
              AixLib.DataBase.Walls.WSchV1984.Ceiling.CEattic_WSchV1984_SML_loHalf()
            annotation (Dialog(tab="Types"));

           //Window type
          parameter
            AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple
            Type_Win=if TIR == 1 then
              AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009() else
              if TIR == 2 then
              AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2002() else
              if TIR == 3 then
              AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1995()
               else AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1984()
            annotation (Dialog(tab="Types"));

            parameter Modelica.SIunits.Volume room_V=3.38*4.20*2.46;
        public
          AixLib.Building.Components.Walls.Wall Wall_Livingroom(
            T0=T0_IWLivingroom,
            outside=false,
            WallType=Type_IWload,
            wall_length=4.2,
            wall_height=2.46,
            withWindow=false,
            withDoor=false) annotation (Placement(transformation(extent={{-76,
                    -40},{-66,20}}, rotation=0)));
          AixLib.Building.Components.Walls.Wall Wall_Corridor(
            T0=T0_IWCorridor,
            outside=false,
            WallType=Type_IWload,
            wall_length=2.13,
            wall_height=2.46,
            withWindow=false,
            withDoor=false) annotation (Placement(transformation(
                origin={-25.6,-49},
                extent={{-3,-21.6},{5,26.4}},
                rotation=90)));
          AixLib.Building.Components.Walls.Wall Wall_Neighbour(
            T0=T0_IWNeighbour,
            outside=false,
            WallType=Type_IWload,
            wall_length=4.2,
            wall_height=2.46,
            withWindow=false,
            withDoor=false) annotation (Placement(transformation(
                origin={60,4.92309},
                extent={{-2,-35.0769},{10,36.9231}},
                rotation=180)));
          AixLib.Building.Components.DryAir.Airload airload(V=room_V, T(
                start=T0_air)) annotation (Placement(transformation(extent=
                    {{-38,16},{-58,36}}, rotation=0)));
          Utilities.Interfaces.SolarRad_in Strahlung_SE annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-82,110}), iconTransformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-30,110})));

          AixLib.Building.Components.Walls.Wall outsideWall(
            wall_length=3.38,
            wall_height=2.46,
            windowarea=1.84,
            withWindow=true,
            T0=T0_OW,
            solar_absorptance=solar_absorptance_OW,
            WallType=Type_OW,
            WindowType=Type_Win,
            outside=true,
            withDoor=false) annotation (Placement(transformation(
                origin={-12,51},
                extent={{-9,-54},{9,54}},
                rotation=270)));

          AixLib.Building.Components.Walls.Wall Wall_Staircase(
            T0=T0_IWStraicase,
            outside=false,
            WallType=Type_IWload,
            wall_length=0.86,
            wall_height=2.46,
            withWindow=false,
            withDoor=false) annotation (Placement(transformation(
                origin={36.9565,-47},
                extent={{-3,-21.0435},{5,22.9565}},
                rotation=90)));
          AixLib.Building.Components.Walls.Wall Wall_Ceiling(
            T0=T0_CE,
            outside=false,
            WallType=Type_CE,
            wall_length=4.20,
            wall_height=3.38,
            ISOrientation=3,
            withWindow=false,
            withDoor=false) "Decke" annotation (Placement(transformation(
                origin={112,76},
                extent={{-1.99998,-10},{1.99998,10}},
                rotation=270)));
          AixLib.Building.Components.Walls.Wall Wall_Floor(
            T0=T0_FL,
            outside=false,
            WallType=Type_FL,
            wall_length=4.20,
            wall_height=3.38,
            ISOrientation=2,
            withWindow=false,
            withDoor=false) annotation (Placement(transformation(
                origin={112,42},
                extent={{-1.99998,-10},{1.99998,10}},
                rotation=90)));
          AixLib.Building.Components.DryAir.InfiltrationRate_DIN12831
            infiltrationRate(
            room_V=room_V,
            n50=n50,
            e=e,
            eps=eps) annotation (Placement(transformation(extent={{-44,-120},
                    {-18,-94}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermOutside
            annotation (Placement(transformation(extent={{-70,88},{-50,108}}),
                iconTransformation(extent={{-70,88},{-50,108}})));
          Modelica.Blocks.Interfaces.RealInput WindSpeedPort annotation (Placement(
                transformation(extent={{-124,-8},{-84,32}}), iconTransformation(extent={{-110,30},
                    {-90,50}})));
          Modelica.Blocks.Interfaces.RealInput AirExchangePort        annotation (
              Placement(transformation(extent={{-124,20},{-84,60}}), iconTransformation(
                  extent={{-110,60},{-90,80}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermNeighbour
            annotation (Placement(transformation(extent={{-110,0},{-90,20}}),
                iconTransformation(extent={{-110,0},{-90,20}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermStaircase
            annotation (Placement(transformation(extent={{-110,-30},{-90,-10}}),
                iconTransformation(extent={{-110,-30},{-90,-10}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCorridor
            annotation (Placement(transformation(extent={{-110,-60},{-90,-40}}),
                iconTransformation(extent={{-110,-60},{-90,-40}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermLivingroom
            annotation (Placement(transformation(extent={{-108,-130},{-88,-110}}),
                iconTransformation(extent={{-110,-90},{-90,-70}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling
            annotation (Placement(transformation(extent={{-110,-120},{-90,-100}}),
                iconTransformation(extent={{-110,-120},{-90,-100}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor
            annotation (Placement(transformation(extent={{-110,-152},{-90,-132}}),
                iconTransformation(extent={{-110,-152},{-90,-132}})));
          Utilities.Interfaces.Star StarRoom annotation (Placement(
                transformation(extent={{6,-6},{26,14}}), iconTransformation(
                  extent={{6,-6},{26,14}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermRoom annotation (
             Placement(transformation(extent={{-26,-4},{-6,16}}),
                iconTransformation(extent={{-26,-4},{-6,16}})));
          Utilities.Interfaces.Adaptors.HeatStarToComb thermStar_Demux
            annotation (Placement(transformation(
                extent={{-10,8},{10,-8}},
                rotation=90,
                origin={0,-22})));
          AixLib.Building.Components.DryAir.VarAirExchange
            NaturalVentilation(V=room_V) annotation (Placement(
                transformation(extent={{-44,-94},{-16,-68}})));
        equation

          connect(Strahlung_SE,outsideWall. SolarRadiationPort)   annotation (
              Line(
              points={{-82,110},{-82,78},{58,78},{58,62.7},{37.5,62.7}},
              color={255,128,0},
              smooth=Smooth.None));

          connect(infiltrationRate.port_b, airload.port) annotation (Line(
              points={{-18,-107},{0,-107},{0,-36},{-32,-36},{-32,24},{-39,24}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(infiltrationRate.port_a, thermOutside) annotation (Line(
              points={{-44,-107},{-80,-107},{-80,98},{-60,98}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(outsideWall.WindSpeedPort, WindSpeedPort) annotation (Line(
              points={{27.6,60.45},{27.6,78},{-80,78},{-80,12},{-104,12}},
              color={0,0,127},
              smooth=Smooth.None));

          connect(Wall_Neighbour.port_outside, thermNeighbour) annotation (Line(
              points={{62.3,3.99999},{100,3.99999},{100,-68},{-80,-68},{-80,10},{-100,
                  10}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Staircase.port_outside, thermStaircase) annotation (Line(
              points={{36,-50.2},{36,-68},{-80,-68},{-80,-20},{-100,-20}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Corridor.port_outside, thermCorridor) annotation (Line(
              points={{-28,-52.2},{-28,-68},{-80,-68},{-80,-50},{-100,-50}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Livingroom.port_outside, thermLivingroom) annotation (Line(
              points={{-76.25,-10},{-80,-10},{-80,-120},{-98,-120}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Ceiling.port_outside, thermCeiling) annotation (Line(
              points={{112,78.1},{112,88},{100,88},{100,-68},{-80,-68},{-80,
                  -110},{-100,-110}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Floor.port_outside, thermFloor) annotation (Line(
              points={{112,39.9},{112,8},{100,8},{100,-68},{-100,-68},{-100,
                  -142}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(thermStar_Demux.star, StarRoom) annotation (Line(
              points={{5.8,-11.6},{6,-10},{6,-8},{16,-8},{16,4}},
              color={95,95,95},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          connect(thermStar_Demux.therm, ThermRoom) annotation (Line(
              points={{-5.1,-11.9},{-5.1,-3.95},{-16,-3.95},{-16,6}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(thermStar_Demux.therm, airload.port) annotation (Line(
              points={{-5.1,-11.9},{-32,-11.9},{-32,24},{-39,24}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Corridor.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{-28,-44},{-28,-36},{-0.1,-36},{-0.1,-31.4}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Staircase.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{36,-42},{36,-36},{-0.1,-36},{-0.1,-31.4}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Neighbour.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{50,3.99999},{40,3.99999},{40,-36},{-0.1,-36},{-0.1,-31.4}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(outsideWall.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{-12,42},{-12,30},{40,30},{40,-36},{-0.1,-36},{-0.1,-31.4}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Floor.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{112,44},{112,52},{40,52},{40,-36},{-0.1,-36},{-0.1,-31.4}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Ceiling.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{112,74},{112,52},{40,52},{40,-36},{-0.1,-36},{-0.1,-31.4}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Livingroom.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{-66,-10},{-50,-10},{-50,-36},{-0.1,-36},{-0.1,-31.4}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(thermOutside,NaturalVentilation.port_a)  annotation (Line(
              points={{-60,98},{-80,98},{-80,-68},{-50,-68},{-50,-81},{-44,-81}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(AirExchangePort, NaturalVentilation.InPort1) annotation (Line(
              points={{-104,40},{-80,40},{-80,-68},{-50,-68},{-50,-89.32},{-42.6,
                  -89.32}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(NaturalVentilation.port_b, airload.port) annotation (Line(
              points={{-16,-81},{0,-81},{0,-36},{-32,-36},{-32,24},{-39,24}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(outsideWall.port_outside, thermOutside) annotation (Line(
              points={{-12,60.45},{-12,98},{-60,98}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(thermOutside, thermOutside) annotation (Line(
              points={{-60,98},{-86,98},{-86,98},{-60,98}},
              color={191,0,0},
              smooth=Smooth.None));
            annotation (__Dymola_Images(Parameters(source="AixLib/Images/House/VoWo_Children.png")),
            Diagram(coordinateSystem(
                preserveAspectRatio=true,
                extent={{-100,-150},{150,100}},
                initialScale=0.1), graphics),
            Icon(coordinateSystem(
                preserveAspectRatio=true,
                extent={{-100,-150},{150,100}},
                initialScale=0.1), graphics={
                Rectangle(
                  extent={{-54,68},{116,-108}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Forward),
                Text(
                  extent={{-36,-20},{98,-54}},
                  lineColor={0,0,0},
                  fillColor={255,0,0},
                  fillPattern=FillPattern.Forward,
                  textString="Children"),
                Rectangle(
                  extent={{-10,80},{12,60}},
                  lineColor={0,0,0},
                  fillColor={85,255,255},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{-8,78},{10,62}},
                  lineColor={0,0,0},
                  fillColor={170,213,255},
                  fillPattern=FillPattern.Solid),
                Line(
                  points={{-4,66},{6,76}},
                  color={255,255,255},
                  thickness=1),
                Line(
                  points={{0,66},{6,72}},
                  color={255,255,255},
                  thickness=1),
                Line(
                  points={{-4,70},{2,76}},
                  color={255,255,255},
                  thickness=1),
                Text(
                  extent={{2,82},{52,66}},
                  lineColor={0,0,0},
                  lineThickness=1,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="OW"),
                Text(
                  extent={{6,-110},{56,-126}},
                  lineColor={0,0,0},
                  lineThickness=1,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="Corridor"),
                Rectangle(
                  extent={{90,-96},{110,-126}},
                  lineColor={0,0,0},
                  lineThickness=1,
                  fillColor={127,0,0},
                  fillPattern=FillPattern.Forward),
                Ellipse(
                  extent={{92,-108},{94,-110}},
                  lineColor={0,0,0},
                  pattern=LinePattern.None,
                  lineThickness=1,
                  fillPattern=FillPattern.Sphere,
                  fillColor={255,255,0}),
                Rectangle(
                  extent={{-110,-100},{-90,-120}},
                  lineColor={0,0,0},
                  lineThickness=0.5),
                Rectangle(
                  extent={{-110,-70},{-90,-90}},
                  lineColor={0,0,0},
                  lineThickness=0.5),
                Rectangle(
                  extent={{-110,-40},{-90,-60}},
                  lineColor={0,0,0},
                  lineThickness=0.5),
                Rectangle(
                  extent={{-110,20},{-90,0}},
                  lineColor={0,0,0},
                  lineThickness=0.5),
                Rectangle(
                  extent={{-70,88},{-50,88}},
                  lineColor={0,0,0},
                  lineThickness=0.5),
                Rectangle(
                  extent={{-110,-10},{-90,-30}},
                  lineColor={0,0,0},
                  lineThickness=0.5),
                Rectangle(
                  extent={{-110,82},{-90,28}},
                  lineColor={0,0,0},
                  lineThickness=0.5),
                Rectangle(
                  extent={{-110,-132},{-90,-152}},
                  lineColor={0,0,0},
                  lineThickness=0.5)}),
            Documentation(revisions="<html>
<p><ul>
<li><i>April 18, 2014</i> by Ana Constantin:<br/>Added documentation</li>
<li><i>August 16, 2011</i> by Ana Constantin:<br/>Implemented</li>
</ul></p>
</html>",     info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Model for a second bedroom: the childrens&apos; room. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The following figure presents the room&apos;s layout:</p>
<p><img src=\"modelica://AixLib/Images/House/VoWo_Children.png\"/></p>
</html>"));
        end Children_VoWo;

        annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Package for the rooms in the appartment.</p>
</html>"));
      end OneApparment;

      package CellarAttic
                  extends Modelica.Icons.Package;

        model Cellar "Cellar completly under ground"
          import AixLib;
         ///////// construction parameters
          parameter Integer TMC =  1 "Themal Mass Class"
            annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice=1 "S", choice = 2 "M", choice = 3 "L", radioButtons = true));
          parameter Integer TIR = 4 "Thermal Insulation Regulation"
           annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice=1
                "EnEV_2009",                                                                                                    choice = 2
                "EnEV_2002",                                                                                                    choice = 3
                "WSchV_1995",  choice = 4 "WSchV_1984",                                                                          radioButtons = true));

          // Room geometry
          parameter Modelica.SIunits.Length room_length = 10.24 "length" annotation (Dialog(group = "Room geometry", descriptionLabel = true));
          parameter Modelica.SIunits.Length room_width = 17.01 "width" annotation (Dialog(group = "Room geometry", descriptionLabel = true));
          parameter Modelica.SIunits.Height room_height = 2.5 "length" annotation (Dialog(group = "Room geometry", descriptionLabel = true));

          // Outer walls properties
          parameter Modelica.SIunits.Temperature T_Ground = 283.15
            "GroundTemperature"                                                        annotation (Dialog(group = "Outer wall properties", descriptionLabel = true));
         parameter Integer ModelConvOW =  1 "Heat Convection Model"
           annotation(Dialog(group = "Outer wall properties", compact = true, descriptionLabel = true), choices(choice = 1
                "DIN 6946",                                                                                                    choice = 2
                "ASHRAE Fundamentals",                                                                                                    choice = 3
                "Custom alpha",                                                                                                    radioButtons = true));

          //Initial temperatures
          parameter Modelica.SIunits.Temperature T0_air=285.15 "Air"
                                                                   annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_Walls=284.95 "Walls" annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_Ceiling=285.25 "Ceiling"  annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          // Infiltration rate
        protected
          parameter Real n50(unit="h-1")=
          if (TIR == 1 or TIR ==2) then 3 else
          if TIR == 3 then 4 else 6
            "Air exchange rate at 50 Pa pressure difference" annotation (Dialog(tab = "Infiltration"));
          parameter Real e=0.03 "Coefficient of windshield" annotation (Dialog(tab = "Infiltration"));
          parameter Real eps=1.0 "Coefficient of height" annotation (Dialog(tab = "Infiltration"));

           // Floor type
          parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_FL=if TIR
               == 1 then
              AixLib.DataBase.Walls.EnEV2009.Floor.FLground_EnEV2009_SML()
               else if TIR == 2 then
              AixLib.DataBase.Walls.EnEV2002.Floor.FLground_EnEV2002_SML()
               else if TIR == 3 then
              AixLib.DataBase.Walls.WSchV1995.Floor.FLground_WSchV1995_SML()
               else
              AixLib.DataBase.Walls.WSchV1984.Floor.FLground_WSchV1984_SML();

          // Ceiling  type
          parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_CE=if TIR
               == 1 then
              AixLib.DataBase.Walls.EnEV2009.Ceiling.CEcellar_EnEV2009_SML_loHalf()
               else if TIR == 2 then
              AixLib.DataBase.Walls.EnEV2002.Ceiling.CEcellar_EnEV2002_SML_loHalf()
               else if TIR == 3 then
              AixLib.DataBase.Walls.WSchV1995.Ceiling.CEcellar_WSchV1995_SML_loHalf()
               else
              AixLib.DataBase.Walls.WSchV1984.Ceiling.CEcellar_WSchV1984_SML_loHalf();

            parameter Modelica.SIunits.Volume room_V=room_length*room_width*room_height;

        public
          AixLib.Building.Components.DryAir.Airload airload(V=room_V, T(
                start=T0_air)) annotation (Placement(transformation(extent=
                    {{-18,-4},{-38,16}}, rotation=0)));

          AixLib.Building.Components.Walls.Wall Wall_Ceiling(
            T0=T0_Ceiling,
            outside=false,
            WallType=Type_CE,
            wall_length=room_width,
            wall_height=room_length,
            ISOrientation=3,
            withWindow=false,
            withDoor=false) annotation (Placement(transformation(
                origin={110,62},
                extent={{-1.99998,-10},{1.99998,10}},
                rotation=270)));
          AixLib.Building.Components.Walls.Wall Wall_Floor(
            T0=T0_Walls,
            outside=false,
            WallType=Type_FL,
            wall_length=room_width,
            wall_height=room_length,
            ISOrientation=2,
            withWindow=false,
            withDoor=false) annotation (Placement(transformation(
                origin={110,32},
                extent={{-1.99998,-10},{1.99998,10}},
                rotation=90)));
          AixLib.Building.Components.DryAir.InfiltrationRate_DIN12831
            infiltrationRate(
            room_V=room_V,
            n50=n50,
            e=e,
            eps=eps) annotation (Placement(transformation(extent={{-44,-100},
                    {-18,-74}})));
        public
          AixLib.Building.Components.Walls.Wall Wall1(
            T0=T0_Walls,
            outside=false,
            WallType=Type_FL,
            wall_length=room_width,
            wall_height=room_height,
            ISOrientation=1,
            withWindow=false,
            withDoor=false) annotation (Placement(transformation(
                extent={{-9,-50},{9,50}},
                rotation=270,
                origin={2,65})));
        public
          AixLib.Building.Components.Walls.Wall Wall3(
            T0=T0_Walls,
            outside=false,
            WallType=Type_FL,
            wall_height=room_height,
            wall_length=room_width,
            withDoor=false) annotation (Placement(transformation(
                extent={{-9,-50},{9,50}},
                rotation=90,
                origin={2,-45})));
        public
          AixLib.Building.Components.Walls.Wall Wall2(
            T0=T0_Walls,
            outside=false,
            WallType=Type_FL,
            wall_height=room_height,
            wall_length=room_length,
            withDoor=false) annotation (Placement(transformation(
                extent={{-9,-50},{9,50}},
                rotation=180,
                origin={68,13})));
        public
          AixLib.Building.Components.Walls.Wall Wall4(
            T0=T0_Walls,
            outside=false,
            WallType=Type_FL,
            wall_height=room_height,
            wall_length=room_length,
            withDoor=false) annotation (Placement(transformation(
                extent={{-9,-50},{9,50}},
                rotation=0,
                origin={-70,13})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermOutside
            annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCellar
            annotation (Placement(transformation(extent={{100,80},{120,100}})));
          Modelica.Thermal.HeatTransfer.Sources.FixedTemperature TGround(T=T_Ground)
            annotation (Placement(transformation(extent={{118,-80},{138,-60}})));
          Utilities.Interfaces.Adaptors.HeatStarToComb thermStar_Demux
            annotation (Placement(transformation(
                extent={{-10,8},{10,-8}},
                rotation=90,
                origin={4,-6})));
        equation

          connect(infiltrationRate.port_a, thermOutside) annotation (Line(
              points={{-44,-87},{-42,-87},{-42,-90},{-90,-90}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(infiltrationRate.port_b, airload.port) annotation (Line(
              points={{-18,-87},{-2,-87},{-2,-64},{-54,-64},{-54,-24},{-12,-24},{
                  -12,4},{-19,4}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Ceiling.port_outside, thermCellar) annotation (Line(
              points={{110,64.1},{110,90}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(TGround.port, Wall3.port_outside) annotation (Line(
              points={{138,-70},{2,-70},{2,-54.45}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall2.port_outside, TGround.port) annotation (Line(
              points={{77.45,13},{100,13},{100,-70},{138,-70}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Floor.port_outside, TGround.port) annotation (Line(
              points={{110,29.9},{110,8},{100,8},{100,-70},{138,-70}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall1.port_outside, TGround.port) annotation (Line(
              points={{2,74.45},{2,88},{100,88},{100,-70},{138,-70}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall4.port_outside, TGround.port) annotation (Line(
              points={{-79.45,13},{-86,13},{-86,-64},{-2,-64},{-2,-70},{138,-70}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall2.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{59,13},{46,13},{46,-24},{3.9,-24},{3.9,-15.4}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Wall3.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{2,-36},{2,-25.1125},{3.9,-25.1125},{3.9,-15.4}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall1.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{2,56},{2,44},{46,44},{46,-24},{3.9,-24},{3.9,-15.4}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall4.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{-61,13},{-48,13},{-48,-24},{3.9,-24},{3.9,-15.4}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Wall_Floor.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{110,34},{110,34},{110,44},{46,44},{46,-24},{3.9,-24},{
                  3.9,-15.4}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Wall_Ceiling.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{110,60},{110,44},{46,44},{46,-24},{3.9,-24},{3.9,-15.4}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(thermStar_Demux.therm, airload.port) annotation (Line(
              points={{-1.1,4.1},{-1.1,12},{-12,12},{-12,4},{-19,4}},
              color={191,0,0},
              smooth=Smooth.None));
          annotation (
            Diagram(coordinateSystem(
                preserveAspectRatio=false,
                extent={{-100,-150},{150,100}},
                initialScale=0.1), graphics),
            Icon(coordinateSystem(
                preserveAspectRatio=true,
                extent={{-100,-150},{150,100}},
                initialScale=0.1), graphics={Rectangle(
                  extent={{-68,74},{134,-128}},
                  lineColor={0,0,255},
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid), Text(
                  extent={{-66,10},{126,-48}},
                  lineColor={0,0,255},
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  textString="Cellar")}),
            Documentation(revisions="<html>
<p><ul>
<li><i>April 18, 2014</i> by Ana Constantin:<br/>Added documentation</li>
<li><i>August 17, 2011</i> by Ana Constantin:<br/>Implemented</li>
</ul></p>
</html>",     info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Model for a cellar for the whole building.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The model can extended, if one wants to consider each of the floors belongig to the upper rooms individually.</p>
</html>"));
        end Cellar;

        model Attic_Ro2Lf1
          "Attic with two saddle roofs and on floor towards the rooms on the lower floors"
          import AixLib;

          ///////// construction parameters
          parameter Integer TMC =  1 "Themal Mass Class"
            annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice=1 "S", choice = 2 "M", choice = 3 "L", radioButtons = true));
          parameter Integer TIR = 4 "Thermal Insulation Regulation"
           annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice=1
                "EnEV_2009",                                                                                                    choice = 2
                "EnEV_2002",                                                                                                    choice = 3
                "WSchV_1995",  choice = 4 "WSchV_1984",                                                                          radioButtons = true));

          // Room geometry
          parameter Modelica.SIunits.Length room_length = 10.24 "length" annotation (Dialog(group = "Room geometry", descriptionLabel = true));
          parameter Modelica.SIunits.Length room_width = 17.01 "width" annotation (Dialog(group = "Room geometry", descriptionLabel = true));
          parameter Modelica.SIunits.Length roof_width1 = 5.7 "wRO1" annotation (Dialog(group = "Room geometry",absoluteWidth=25, joinNext = true, descriptionLabel = true));
         parameter Modelica.SIunits.Length roof_width2 = 5.7 "wRO2" annotation (Dialog(group = "Room geometry", absoluteWidth=25, descriptionLabel = true));
         parameter Modelica.SIunits.Angle alfa =  Modelica.SIunits.Conversions.from_deg(120) "alfa"
                                                                                                annotation (Dialog(group = "Room geometry", descriptionLabel = true));

          parameter Modelica.SIunits.Temperature T0_air=283.15 "Air"
                                                                   annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_RO1=282.15 "RO1"
                                                                   annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_RO2=282.15 "RO2"
                                                                   annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));
          parameter Modelica.SIunits.Temperature T0_FL=284.15 "FL" annotation(Dialog(tab="Initial temperatures", descriptionLabel = true));

         // Outer walls properties
         parameter Real solar_absorptance_RO=0.25 "Solar absoptance roof "
                                                                          annotation (Dialog(group = "Outer wall properties", descriptionLabel = true));
         parameter Integer ModelConvOW =  1 "Heat Convection Model"
           annotation(Dialog(group = "Outer wall properties", compact = true, descriptionLabel = true), choices(choice = 1
                "DIN 6946",                                                                                                    choice = 2
                "ASHRAE Fundamentals",                                                                                                    choice = 3
                "Custom alpha",                                                                                                    radioButtons = true));

         // Windows and Doors
         parameter Boolean withWindow1 = false "Window 1 " annotation (Dialog(group = "Windows and Doors", joinNext = true, descriptionLabel = true), choices(checkBox=true));
         parameter Modelica.SIunits.Area windowarea_RO1=0 "Window area" annotation (Dialog(group = "Windows and Doors", naturalWidth = 10, descriptionLabel = true, enable = withWindow1));
         parameter Boolean withWindow2 = false "Window 2 " annotation (Dialog(group = "Windows and Doors", joinNext = true, descriptionLabel = true), choices(checkBox=true));
         parameter Modelica.SIunits.Area windowarea_RO2=0 "Window area" annotation (Dialog(group = "Windows and Doors", naturalWidth = 10, descriptionLabel = true, enable = withWindow2));

         // Infiltration rate
        protected
          parameter Real n50(unit="h-1")=
          if (TIR == 1 or TIR ==2) then 3 else
          if TIR == 3 then 4 else 6
            "Air exchange rate at 50 Pa pressure difference" annotation (Dialog(tab = "Infiltration"));
          parameter Real e=0.03 "Coefficient of windshield" annotation (Dialog(tab = "Infiltration"));
          parameter Real eps=1.0 "Coefficient of height" annotation (Dialog(tab = "Infiltration"));

        // Floor to lower floor type
          parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_FL=if TIR
               == 1 then
              AixLib.DataBase.Walls.EnEV2009.Ceiling.CEattic_EnEV2009_SML_loHalf()
               else if TIR == 2 then
              AixLib.DataBase.Walls.EnEV2002.Ceiling.CEattic_EnEV2002_SML_loHalf()
               else if TIR == 3 then
              AixLib.DataBase.Walls.WSchV1995.Ceiling.CEattic_WSchV1995_SML_loHalf()
               else
              AixLib.DataBase.Walls.WSchV1984.Ceiling.CEattic_WSchV1984_SML_loHalf()
            annotation (Dialog(tab="Types"));

           // Saddle roof type
          parameter AixLib.DataBase.Walls.WallBaseDataDefinition Type_RO=if TIR
               == 1 then
              AixLib.DataBase.Walls.EnEV2009.Ceiling.ROsaddleAttic_EnEV2009_SML()
               else if TIR == 2 then
              AixLib.DataBase.Walls.EnEV2002.Ceiling.ROsaddleAttic_EnEV2002_SML()
               else if TIR == 3 then
              AixLib.DataBase.Walls.WSchV1995.Ceiling.ROsaddleAttic_WSchV1995_SML()
               else
              AixLib.DataBase.Walls.WSchV1984.Ceiling.ROsaddleAttic_WSchV1984_SML()
            annotation (Dialog(tab="Types"));

           //Window type
          parameter
            AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple
            Type_Win=if TIR == 1 then
              AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009() else
              if TIR == 2 then
              AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2002() else
              if TIR == 3 then
              AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1995()
               else AixLib.DataBase.WindowsDoors.Simple.WindowSimple_WSchV1984()
            annotation (Dialog(tab="Types"));

            parameter Modelica.SIunits.Volume room_V=roof_width1*roof_width2*sin(alfa)*0.5*room_width;

        public
          AixLib.Building.Components.Walls.Wall roof1(
            withDoor=false,
            door_height=0,
            door_width=0,
            T0=T0_RO1,
            solar_absorptance=solar_absorptance_RO,
            wall_height=roof_width1,
            wall_length=room_width,
            withWindow=false,
            WallType=Type_RO,
            ISOrientation=1) annotation (Placement(transformation(
                extent={{-4.99998,-28},{4.99998,28}},
                rotation=270,
                origin={-42,63})));
          AixLib.Building.Components.DryAir.Airload airload(V=room_V, T(
                start=T0_air)) annotation (Placement(transformation(extent=
                    {{0,-20},{20,0}}, rotation=0)));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermOutside
            annotation (Placement(transformation(extent={{-100,80},{-80,100}},
                  rotation=0)));
          Modelica.Blocks.Interfaces.RealInput WindSpeedPort
            annotation (Placement(transformation(extent={{-109.5,-10},{-89.5,10}},
                  rotation=0), iconTransformation(extent={{-109.5,-10},{-89.5,10}})));
          Utilities.Interfaces.SolarRad_in SolarRadiationPort_RoofNW
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-45.5,100}), iconTransformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-50,90})));
          AixLib.Building.Components.Walls.Wall roof2(
            solar_absorptance=solar_absorptance_RO,
            withDoor=false,
            door_height=0,
            door_width=0,
            T0=T0_RO2,
            wall_height=roof_width2,
            wall_length=room_width,
            withWindow=false,
            WallType=Type_RO,
            outside=true,
            ISOrientation=1) annotation (Placement(transformation(
                origin={50,63},
                extent={{-4.99998,-28},{4.99998,28}},
                rotation=270)));
          Utilities.Interfaces.SolarRad_in SolarRadiationPort_RoofSE
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={48,100}), iconTransformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={50,90})));
          AixLib.Building.Components.Walls.Wall Floor(
            T0=T0_FL,
            outside=false,
            WallType=Type_FL,
            wall_length=room_length,
            wall_height=room_width,
            ISOrientation=2,
            withWindow=false,
            withDoor=false) annotation (Placement(transformation(
                origin={1,-46},
                extent={{-1.99999,-13},{1.99999,13}},
                rotation=90)));
          AixLib.Building.Components.DryAir.InfiltrationRate_DIN12831
            infiltrationRate(
            room_V=room_V,
            n50=n50,
            e=e,
            eps=eps) annotation (Placement(transformation(extent={{-64,-24},
                    {-46,-16}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor
            annotation (Placement(transformation(extent={{-10,-86},{10,-66}})));
          Utilities.Interfaces.Adaptors.HeatStarToComb thermStar_Demux
            annotation (Placement(transformation(
                extent={{-10,8},{10,-8}},
                rotation=90,
                origin={-28,6})));
          Modelica.Blocks.Interfaces.RealInput AirExchangePort
              annotation (Placement(transformation(
                origin={-100,25},
                extent={{-10,-10},{10,10}},
                rotation=0), iconTransformation(extent={{-110,30},{-90,50}})));
          AixLib.Building.Components.DryAir.VarAirExchange
            NaturalVentilation(V=room_V) annotation (Placement(
                transformation(extent={{-70,-56},{-50,-36}})));
        equation

          // Connect-equation for ventilation/infiltration. If there are two windows, the ventilation rate is equally distributed between the two. the same with two door.
          // Be careful to set a given ventilation rate only for the windows, or for the doors, otherweise you will have double the ventilation rate.

          connect(SolarRadiationPort_RoofNW, roof1.SolarRadiationPort)
                                                                    annotation (Line(
              points={{-45.5,100},{-45.5,80},{-16.3333,80},{-16.3333,69.5}},
              color={255,128,0},
              smooth=Smooth.None));

          connect(SolarRadiationPort_RoofSE, roof2.SolarRadiationPort)
                                                                    annotation (Line(
              points={{48,100},{48,80},{75.6667,80},{75.6667,69.5}},
              color={255,128,0},
              smooth=Smooth.None));
          connect(thermOutside, thermOutside) annotation (Line(
              points={{-90,90},{-90,90}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(roof1.WindSpeedPort, WindSpeedPort) annotation (Line(
              points={{-21.4667,68.25},{-21.4667,80},{-80,80},{-80,0},{-99.5,0}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(roof2.WindSpeedPort, WindSpeedPort) annotation (Line(
              points={{70.5333,68.25},{70.5333,80},{-80,80},{-80,0},{-99.5,0}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(infiltrationRate.port_a, thermOutside) annotation (Line(
              points={{-64,-20},{-80,-20},{-80,90},{-90,90}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(infiltrationRate.port_b, airload.port) annotation (Line(
              points={{-46,-20},{-28,-20},{-28,-28},{-10,-28},{-10,-12},{1,-12}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Floor.port_outside, thermFloor) annotation (Line(
              points={{1,-48.1},{1,-65.55},{0,-65.55},{0,-76}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Floor.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{1,-44},{1,-28},{-28.1,-28},{-28.1,-3.4}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(thermStar_Demux.therm, airload.port) annotation (Line(
              points={{-33.1,16.1},{-33.1,26},{-10,26},{-10,-12},{1,-12}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(roof2.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{50,58},{50,50},{-42,50},{-42,-3.4},{-28.1,-3.4}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(roof1.thermStarComb_inside, thermStar_Demux.thermStarComb)
            annotation (Line(
              points={{-42,58},{-42,-3.4},{-28.1,-3.4}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(roof1.port_outside, thermOutside) annotation (Line(
              points={{-42,68.25},{-42,80},{-90,80},{-90,90}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(roof2.port_outside, thermOutside) annotation (Line(
              points={{50,68.25},{50,80},{-90,80},{-90,90}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(NaturalVentilation.port_a, thermOutside) annotation (Line(
              points={{-70,-46},{-80,-46},{-80,90},{-90,90}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(NaturalVentilation.port_b, airload.port) annotation (Line(
              points={{-50,-46},{-28,-46},{-28,-28},{-10,-28},{-10,-12},{1,-12}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(NaturalVentilation.InPort1, AirExchangePort) annotation (Line(
              points={{-69,-52.4},{-80,-52.4},{-80,25},{-100,25}},
              color={0,0,127},
              smooth=Smooth.None));
         annotation (__Dymola_Images(Parameters(source="AixLib/Images/House/MFD_Attic.png", Width = 5, Length = 5)),
                      Icon(graphics={Polygon(
                  points={{-58,-20},{16,54},{90,-20},{76,-20},{16,40},{-44,-20},{-58,-20}},
                  lineColor={0,0,0},
                  smooth=Smooth.None,
                  fillPattern=FillPattern.Solid,
                  fillColor={175,175,175}),
                Polygon(
                  points={{-24,0},{6,30},{-8,30},{-38,0},{-24,0}},
                  lineColor={0,0,0},
                  smooth=Smooth.None,
                  fillColor={170,213,255},
                  fillPattern=FillPattern.Solid,
                  visible=  withWindow1),
                Text(
                  extent={{-36,10},{12,22}},
                  lineColor={0,0,0},
                  fillColor={170,213,255},
                  fillPattern=FillPattern.Solid,
                  textString="Win1",
                  visible=  withWindow1),
                Polygon(
                  points={{26,30},{56,0},{70,0},{40,30},{26,30}},
                  lineColor={0,0,0},
                  smooth=Smooth.None,
                  fillColor={170,213,255},
                  fillPattern=FillPattern.Solid,
                  visible=withWindow2),
                Text(
                  extent={{22,10},{70,22}},
                  lineColor={0,0,0},
                  fillColor={170,213,255},
                  fillPattern=FillPattern.Solid,
                  textString="Win2",
                  visible=withWindow2),
                Text(
                  extent={{-44,-14},{74,-26}},
                  lineColor={0,0,0},
                  fillColor={255,170,170},
                  fillPattern=FillPattern.Solid,
                  textString="width"),
                Line(
                  points={{-44,-20},{-44,-24}},
                  color={0,0,0},
                  smooth=Smooth.None),
                Line(
                  points={{-44,-20},{-20,-20}},
                  color={0,0,0},
                  smooth=Smooth.None),
                Line(
                  points={{48,-20},{76,-20}},
                  color={0,0,0},
                  smooth=Smooth.None),
                Line(
                  points={{76,-20},{76,-24}},
                  color={0,0,0},
                  smooth=Smooth.None),
                Line(
                  points={{-37,-37},{37,37}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  origin={57,21},
                  rotation=90),
                Line(
                  points={{3,-3},{-3,3}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  origin={93,-17},
                  rotation=90),
                Text(
                  extent={{-28,5},{28,-5}},
                  lineColor={0,0,0},
                  origin={44,47},
                  rotation=0,
                  textString="wRO2"),
                Line(
                  points={{3,-3},{-3,3}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  origin={19,57},
                  rotation=90),
                Line(
                  points={{16,54},{10,60}},
                  color={0,0,0},
                  smooth=Smooth.None),
                Line(
                  points={{-62,-16},{12,58}},
                  color={0,0,0},
                  smooth=Smooth.None),
                Text(
                  extent={{-40,52},{16,42}},
                  lineColor={0,0,0},
                  textString="wRO1"),
                Line(
                  points={{-58,-20},{-64,-14}},
                  color={0,0,0},
                  smooth=Smooth.None)}),
            Diagram(graphics),
            Documentation(revisions="<html>
<p><ul>
<li><i>April 18, 2014</i> by Ana Constantin:<br/>Added documentation</li>
<li><i>August 17, 2011</i> by Ana Constantin:<br/>Implemented</li>
</ul></p>
</html>",     info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Model for an attic for the whole building.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The model can extended, if one wants to consider each of the ceilings belongig to the lower rooms individually.</p>
</html>"));
        end Attic_Ro2Lf1;
        annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Package with models for cellar and attic for the whole building.</p>
</html>"));
      end CellarAttic;
      annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Package for rooms for an appartment in a multi family dwelling.</p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The multi-family dwelling is based on an existing building consisting of several identical apartments which is part of a larger national research project [1].</p>
<p>The dimensions and layout of the rooms are fixed, with an apartment having a living area of 70 m2 and consisting of a living room, two bedrooms, a kitchen and a bathroom.</p>
<p><img src=\"modelica://AixLib/Images/House/MFD_FloorPlan_En.PNG\"/></p>
<p><br><br><b><font style=\"color: #008000; \">References</font></b></p>
<p>[1] Cali, D., Streblow, R., M&uuml;ller, D., Osterhage, T. Holistic Renovation and Monitoring of Residential Buildings in <i>Proceedings of Rethink, renew, restart: ECEE 2013 summer study</i>, 2013.</p>
</html>"));
    end MFD;
  annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Package for rooms.</p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>In a room model the following physical processes are considered:</p>
<ul>
<li>transient heat conduction through walls; each wall consists of several layers with different physical properties; further discretization of each layer is possible</li>
<li>steady-state heat conduction through glazing systems; transmission of short wave radiation through the window depends on a constant coefficient; transmitted radiation is considered together with the radiation from room facing elements</li>
<li>heat convection at outside facing surfaces either with a constant coefficient, depending on wind speed, or depending on wind speed and surface abrasiveness</li>
<li>heat convection at inside facing surfaces either with a constant coefficient, depending on wind speed, or depending on wind speed and surface abrasiveness</li>
<li>heat convection at inside facing surfaces depends on the wall orientation and the temperature difference between the room air and the wall surface</li>
<li>radiation exchange between room facing elements</li>
<li>temperature balance equations for the room airvolume; per room only one air node is considered; humidity is not considered in the air node</li>
</ul>
<p><br>All outer walls are whole walls connected to the room air and the ambient, while inner walls are half walls, each half belonging to one of the rooms which share the wall. Airflow among rooms is not explicitly considered.</p>
<p><br>We chose to parameterize according to the following criteria:</p>
<ul>
<li>thermal mass class: heavy, middle and light</li>
<li>energy saving ordinance: WSchV 1984, WSchV1995, EnEV 2002 and EnEV 2009</li>
</ul>
<p>By specifying these two parameters, all wall, window and door types in a house are automatically set correctly. Furthermore for a multi-family dwelling, for each apartment, the types for floor and ceiling are automatically set if the apartment is situated on the ground, last or an arbitrary upper floor.</p>
<p><br>We wanted to make the library easy to use and extend by future users and developers. To this purpose we put extra effort in creating easy to understand icons and graphical interfaces for parameter input. Because users might want to rotate or mirror a room to build up a whole floor, we wanted to transfer the information about the position of the walls in the room, the meaning of the parameters width and length as well as the existence of windows on the icon level.</p>
</html>"));
  end Rooms;

  package House
              extends Modelica.Icons.Package;

    package OFD_MiddleInnerLoadWall
      "The one family dwelling model, with the inner load wall divides the house in two"
                extends Modelica.Icons.Package;

      package BuildingEnvelope
                  extends Modelica.Icons.Package;

        model GroundFloorBuildingEnvelope
            ///////// construction parameters
          parameter Integer TMC =  1 "Themal Mass Class"
            annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice=1 "S", choice = 2 "M", choice = 3 "L", radioButtons = true));
          parameter Integer TIR = 1 "Thermal Insulation Regulation"
           annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice=1
                "EnEV_2009",                                                                                                    choice = 2
                "EnEV_2002",                                                                                                    choice = 3
                "WSchV_1995",  choice = 4 "WSchV_1984",                                                                          radioButtons = true));

          parameter Boolean withFloorHeating = false
            "If true, that floor has different connectors" annotation (Dialog(group = "Construction parameters"), choices(checkBox=true));

            //////////room geometry
         parameter Modelica.SIunits.Length room_width=if TIR == 1 then 3.86 else 3.97 "width" annotation (Dialog(group = "Dimensions", descriptionLabel = true));
         parameter Modelica.SIunits.Height room_height=2.60 "height" annotation (Dialog(group = "Dimensions", descriptionLabel = true));
         parameter Modelica.SIunits.Length length1=if TIR == 1 then 3.23 else 3.34 "l1 " annotation (Dialog(group = "Dimensions", descriptionLabel = true));
         parameter Modelica.SIunits.Length length2=2.44 "l2 " annotation (Dialog(group = "Dimensions", descriptionLabel = true));
         parameter Modelica.SIunits.Length length3=1.33 "l3 " annotation (Dialog(group = "Dimensions", descriptionLabel = true));
         parameter Modelica.SIunits.Length length4=if TIR == 1 then 3.23 else 3.34 "l4 " annotation (Dialog(group = "Dimensions", descriptionLabel = true));
         parameter Modelica.SIunits.Length thickness_IWsimple=0.145
            "thickness IWsimple "                                                         annotation (Dialog(group = "Dimensions", descriptionLabel = true));

         // Outer walls properties
         parameter Real solar_absorptance_OW=0.6
            "Solar absoptance outer walls "                                     annotation (Dialog(group = "Outer wall properties", descriptionLabel = true));
         parameter Modelica.SIunits.Temperature T_Ground=283.15
            "Ground temperature"                                   annotation(Dialog(group="Outer wall properties", descriptionLabel = true));

         //Windows and Doors
          parameter Modelica.SIunits.Area windowarea_11=8.44 " Area Window11" annotation (Dialog(group = "Windows and Doors", descriptionLabel = true, joinNext = true));
          parameter Modelica.SIunits.Area windowarea_12=1.73 " Area Window12  "
                                                                                annotation (Dialog(group = "Windows and Doors", descriptionLabel = true));
          parameter Modelica.SIunits.Area windowarea_22=1.73 " Area Window22" annotation (Dialog(group = "Windows and Doors", descriptionLabel = true, joinNext=true));
          parameter Modelica.SIunits.Area windowarea_41=1.4 " Area Window41  " annotation (Dialog(group = "Windows and Doors", descriptionLabel = true));
          parameter Modelica.SIunits.Area windowarea_51=3.46 " Area Window51" annotation (Dialog(group = "Windows and Doors", descriptionLabel = true, joinNext = true));
          parameter Modelica.SIunits.Area windowarea_52=1.73 " Area Window52  "
                                                                                annotation (Dialog(group = "Windows and Doors", descriptionLabel = true));
          parameter Modelica.SIunits.Length door_width_31=1.01 "Width Door31" annotation (Dialog(group = "Windows and Doors", joinNext = true, descriptionLabel = true));
          parameter Modelica.SIunits.Length door_height_31=2.25
            "Height Door31  "                                                     annotation (Dialog(group = "Windows and Doors", descriptionLabel = true));
          parameter Modelica.SIunits.Length door_width_42=1.25 "Width Door42" annotation (Dialog(group = "Windows and Doors", joinNext = true, descriptionLabel = true));
          parameter Modelica.SIunits.Length door_height_42=2.25
            "Height Door42  "                                                     annotation (Dialog(group = "Windows and Doors", descriptionLabel = true));

             parameter Real AirExchangeCorridor = 2
            "Air exchange corridors in 1/h "                                         annotation(Dialog(group = "Air Exchange Corridors", descriptionLabel = true));

                // Dynamic Ventilation
          parameter Boolean withDynamicVentilation = true "Dynamic ventilation"
                                                                                annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true), choices(checkBox=true));
          parameter Modelica.SIunits.Temperature HeatingLimit = 253.15
            "Outside temperature at which the heating activates" annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true,  enable = if withDynamicVentilation then true else false));
          parameter Real Max_VR = 200 "Maximal ventilation rate" annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true,  enable = if withDynamicVentilation then true else false));
          parameter Modelica.SIunits.TemperatureDifference Diff_toTempset = 3
            "Difference to set temperature" annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true,  enable = if withDynamicVentilation then true else false));
          parameter Modelica.SIunits.Temperature Tset_Livingroom = 295.15
            "Tset_livingroom"
                   annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true,  joinNext = true, enable = if withDynamicVentilation then true else false));
          parameter Modelica.SIunits.Temperature Tset_Hobby = 295.15
            "Tset_hobby"
                   annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true, enable = if withDynamicVentilation then true else false));
          parameter Modelica.SIunits.Temperature Tset_WC = 291.15 "Tset_WC"
                   annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true,  joinNext = true, enable = if withDynamicVentilation then true else false));
           parameter Modelica.SIunits.Temperature Tset_Kitchen = 295.15
            "Tset_kitchen"
                   annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true, enable = if withDynamicVentilation then true else false));

          Modelica.Blocks.Sources.Constant AirExchangePort_doorSt(k=0)
            "Storage"                                               annotation (
             Placement(transformation(extent={{-116,-68},{-100,-52}})));

          Rooms.OFD.Ow2IwL2IwS1Gr1Uf1         Livingroom(
            TMC=TMC,
            TIR=TIR,
            room_lengthb=length2,
            room_width=room_width,
            room_height=room_height,
            room_length=length1 + length2 + thickness_IWsimple,
            solar_absorptance_OW=solar_absorptance_OW,
            T_Ground=T_Ground,
            windowarea_OW1=windowarea_11,
            windowarea_OW2=windowarea_12,
            withDoor1=false,
            withDoor2=false,
            withWindow1=true,
            withWindow2=true,
            withFloorHeating=withFloorHeating,
            withDynamicVentilation=withDynamicVentilation,
            HeatingLimit=HeatingLimit,
            Max_VR=Max_VR,
            Diff_toTempset=Diff_toTempset,
            Tset=Tset_Livingroom,
            T0_air=295.15,
            T0_OW1=295.15,
            T0_OW2=295.15,
            T0_IW1a=295.15,
            T0_IW1b=295.15,
            T0_IW2=295.15,
            T0_CE=295.13,
            T0_FL=295.13)
            annotation (Placement(transformation(extent={{-86,14},{-42,78}})));
          Rooms.OFD.Ow2IwL1IwS1Gr1Uf1         Hobby(
            TMC=TMC,
            TIR=TIR,
            room_length=length1,
            room_width=room_width,
            room_height=room_height,
            solar_absorptance_OW=solar_absorptance_OW,
            T_Ground=T_Ground,
            windowarea_OW2=windowarea_22,
            withDoor1=false,
            withDoor2=false,
            withWindow1=false,
            withWindow2=true,
            withFloorHeating=withFloorHeating,
            T0_air=295.15,
            T0_OW1=295.15,
            T0_OW2=295.15,
            T0_IW1=295.15,
            T0_IW2=295.15,
            T0_CE=295.13,
            T0_FL=295.13,
            withDynamicVentilation=withDynamicVentilation,
            HeatingLimit=HeatingLimit,
            Max_VR=Max_VR,
            Diff_toTempset=Diff_toTempset,
            Tset=Tset_Hobby)
            annotation (Placement(transformation(extent={{84,28},{46,76}})));
          Rooms.OFD.Ow2IwL1IwS1Gr1Uf1         WC_Storage(
            TMC=TMC,
            TIR=TIR,
            room_length=length4,
            room_width=room_width,
            room_height=room_height,
            solar_absorptance_OW=solar_absorptance_OW,
            T_Ground=T_Ground,
            withWindow1=true,
            windowarea_OW1=windowarea_41,
            withDoor2=true,
            door_width_OD2=door_width_42,
            door_height_OD2=door_height_42,
            withWindow2=false,
            withDoor1=false,
            withFloorHeating=withFloorHeating,
            T0_air=291.15,
            T0_OW1=291.15,
            T0_OW2=291.15,
            T0_IW1=291.15,
            T0_IW2=291.15,
            T0_CE=291.13,
            T0_FL=291.13,
            withDynamicVentilation=withDynamicVentilation,
            HeatingLimit=HeatingLimit,
            Max_VR=Max_VR,
            Diff_toTempset=Diff_toTempset,
            Tset=Tset_WC)
            annotation (Placement(transformation(extent={{84,-36},{46,-84}})));
          Rooms.OFD.Ow2IwL2IwS1Gr1Uf1         Kitchen(
            TMC=TMC,
            TIR=TIR,
            room_length=length3 + length4 + thickness_IWsimple,
            room_width=room_width,
            room_height=room_height,
            solar_absorptance_OW=solar_absorptance_OW,
            T_Ground=T_Ground,
            withWindow1=true,
            windowarea_OW1=windowarea_51,
            withWindow2=true,
            windowarea_OW2=windowarea_52,
            room_lengthb=length3,
            withDoor1=false,
            withDoor2=false,
            withFloorHeating=withFloorHeating,
            T0_air=295.15,
            T0_OW1=295.15,
            T0_OW2=295.15,
            T0_IW1a=295.15,
            T0_IW1b=295.15,
            T0_IW2=295.15,
            T0_CE=295.13,
            T0_FL=295.13,
            withDynamicVentilation=withDynamicVentilation,
            HeatingLimit=HeatingLimit,
            Max_VR=Max_VR,
            Diff_toTempset=Diff_toTempset,
            Tset=Tset_Kitchen)                                              annotation (Placement(
                transformation(extent={{-84,-20},{-44,-84}})));
          Rooms.OFD.Ow1IwL2IwS1Gr1Uf1         Corridor(
            TMC=TMC,
            TIR=TIR,
            room_length=length2 + length3 + thickness_IWsimple,
            room_width=room_width,
            room_height=room_height,
            solar_absorptance_OW=solar_absorptance_OW,
            T_Ground=T_Ground,
            withDoor1=true,
            door_width_OD1=door_width_31,
            door_height_OD1=door_height_31,
            room_lengthb=length3,
            withWindow1=false,
            withFloorHeating=withFloorHeating,
            T0_air=291.15,
            T0_OW1=291.15,
            T0_IW1=291.15,
            T0_IW2a=291.15,
            T0_IW2b=291.15,
            T0_IW3=291.15,
            T0_CE=291.13,
            T0_FL=291.13)
            annotation (Placement(transformation(extent={{82,-28},{42,10}})));
          Utilities.Interfaces.SolarRad_in North annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={110,88})));
          Utilities.Interfaces.SolarRad_in East annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={110,60})));
          Utilities.Interfaces.SolarRad_in South annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={110,26})));
          Utilities.Interfaces.SolarRad_in West annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={110,-16})));
          Modelica.Blocks.Interfaces.RealInput WindSpeedPort annotation (
              Placement(transformation(extent={{-130,12},{-100,42}})));
          Modelica.Blocks.Interfaces.RealInput AirExchangePort[4]
            annotation (Placement(transformation(extent={{-130,-18},{-100,12}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermOutside
            annotation (Placement(transformation(extent={{-116,66},{-100,82}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling_Livingroom
            annotation (Placement(transformation(extent={{-100,100},{-84,118}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling_Hobby
            annotation (Placement(transformation(extent={{-58,100},{-40,118}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling_Corridor
            annotation (Placement(transformation(extent={{-20,100},{-2,118}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling_WCStorage
            annotation (Placement(transformation(extent={{20,100},{38,118}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling_Kitchen
            annotation (Placement(transformation(extent={{62,100},{80,118}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCorridor
            annotation (Placement(transformation(extent={{100,100},{120,120}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermLivingroom
            annotation (Placement(transformation(extent={{-26,54},{-14,66}}),
                iconTransformation(extent={{-28,56},{-14,66}})));
          Utilities.Interfaces.Star StarLivingroom annotation (Placement(
                transformation(extent={{-28,32},{-12,48}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermHobby
            annotation (Placement(transformation(extent={{14,54},{26,66}})));
          Utilities.Interfaces.Star StarHobby annotation (Placement(
                transformation(extent={{12,32},{28,48}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermCorridor
            annotation (Placement(transformation(extent={{-6,-6},{6,6}})));
          Utilities.Interfaces.Star StarCorridor annotation (Placement(
                transformation(extent={{-8,-28},{8,-12}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermWC_Storage
            annotation (Placement(transformation(extent={{14,-46},{26,-34}})));
          Utilities.Interfaces.Star StarWC_Storage annotation (Placement(
                transformation(extent={{12,-68},{28,-52}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermKitchen
            annotation (Placement(transformation(extent={{-26,-46},{-14,-34}})));
          Utilities.Interfaces.Star StarKitchen annotation (Placement(
                transformation(extent={{-28,-68},{-12,-52}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermFloor[5] if
                                                     withFloorHeating annotation (
              Placement(transformation(extent={{-4,-100},{8,-88}}),
                iconTransformation(extent={{0,-88},{14,-78}})));
        equation
          if withFloorHeating then
              connect(Livingroom.thermFloor, ThermFloor[1]) annotation (Line(
              points={{-68.84,38.32},{-68.84,6},{-90,6},{-90,-92},{2,-92},{2,
                    -98.8}},
              color={191,0,0},
              pattern=LinePattern.Dash,
              smooth=Smooth.None));

          connect(Hobby.thermFloor, ThermFloor[2]) annotation (Line(
              points={{69.18,46.24},{69.18,22},{90,22},{90,-92},{8,-92},{2,
                    -96.4}},
              color={191,0,0},
              pattern=LinePattern.Dash,
              smooth=Smooth.None));

          connect(Corridor.thermFloor, ThermFloor[3]) annotation (Line(
              points={{66.4,-13.56},{66.4,-32},{90,-32},{90,-92},{4,-92},{4,-94},{2,-94}},
              color={191,0,0},
              pattern=LinePattern.Dash,
              smooth=Smooth.None));

          connect(WC_Storage.thermFloor, ThermFloor[4]) annotation (Line(
              points={{69.18,-54.24},{90,-54.24},{90,-91.6},{2,-91.6}},
              color={191,0,0},
              pattern=LinePattern.Dash,
              smooth=Smooth.None));
          connect(Kitchen.thermFloor, ThermFloor[5]) annotation (Line(
              points={{-68.4,-44.32},{-90,-44.32},{-90,-92},{-4,-92},{2,-89.2}},
              color={191,0,0},
              pattern=LinePattern.Dash,
              smooth=Smooth.None));

          end if;

          connect(Livingroom.SolarRadiationPort_OW2, West) annotation (Line(
              points={{-52.89,77.68},{-52.89,86},{90,86},{90,-16},{110,-16}},
              color={255,128,0},
              smooth=Smooth.None));
          connect(Hobby.SolarRadiationPort_OW2, West) annotation (Line(
              points={{55.405,75.76},{55.405,86},{90,86},{90,-16},{110,-16}},
              color={255,128,0},
              smooth=Smooth.None));
          connect(Hobby.SolarRadiationPort_OW1, North) annotation (Line(
              points={{83.905,59.2},{90,59.2},{90,88},{110,88}},
              color={255,128,0},
              smooth=Smooth.None));
          connect(Corridor.SolarRadiationPort_OW1, North)
            annotation (Line(
              points={{81.9,2.4},{90,2.4},{90,88},{110,88}},
              color={255,128,0},
              smooth=Smooth.None));
          connect(WC_Storage.SolarRadiationPort_OW1, North) annotation (Line(
              points={{83.905,-67.2},{90,-67.2},{90,88},{110,88}},
              color={255,128,0},
              smooth=Smooth.None));
          connect(WC_Storage.SolarRadiationPort_OW2, East) annotation (Line(
              points={{55.405,-83.76},{55.405,-92},{-90,-92},{-90,86},{90,86},{90,
                  60},{110,60}},
              color={255,128,0},
              smooth=Smooth.None));
          connect(Kitchen.SolarRadiationPort_OW2, East) annotation (Line(
              points={{-53.9,-83.68},{-53.9,-92},{-90,-92},{-90,86},{90,86},{90,60},
                  {110,60}},
              color={255,128,0},
              smooth=Smooth.None));
          connect(Livingroom.SolarRadiationPort_OW1, South) annotation (Line(
              points={{-85.89,55.6},{-90,55.6},{-90,86},{90,86},{90,26},{110,26}},
              color={255,128,0},
              smooth=Smooth.None));
          connect(Livingroom.WindSpeedPort, WindSpeedPort) annotation (Line(
              points={{-85.89,33.2},{-90,33.2},{-90,27},{-115,27}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(Kitchen.WindSpeedPort, WindSpeedPort) annotation (Line(
              points={{-83.9,-39.2},{-90,-39.2},{-90,27},{-115,27}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(WC_Storage.WindSpeedPort, WindSpeedPort) annotation (Line(
              points={{83.905,-50.4},{90,-50.4},{90,-92},{-90,-92},{-90,27},{-115,
                  27}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(Corridor.WindSpeedPort, WindSpeedPort)
            annotation (Line(
              points={{81.9,-20.4},{90,-20.4},{90,-92},{-90,-92},{-90,27},{-115,27}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(Hobby.WindSpeedPort, WindSpeedPort) annotation (Line(
              points={{83.905,42.4},{90,42.4},{90,-92},{-90,-92},{-90,27},{-115,27}},
              color={0,0,127},
              smooth=Smooth.None));

          connect(Livingroom.thermOutside, thermOutside) annotation (Line(
              points={{-83.8,74.8},{-90,74.8},{-90,74},{-108,74}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Kitchen.thermOutside, thermOutside) annotation (Line(
              points={{-82,-80.8},{-90,-80.8},{-90,74},{-108,74}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(WC_Storage.thermOutside, thermOutside) annotation (Line(
              points={{82.1,-81.6},{82.1,-92},{-90,-92},{-90,74},{-108,74}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Corridor.thermOutside, thermOutside)              annotation (
             Line(
              points={{80,8.1},{86,8.1},{86,8},{90,8},{90,-92},{-90,-92},{-90,74},{
                  -108,74}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Hobby.thermOutside, thermOutside) annotation (Line(
              points={{82.1,73.6},{90,73.6},{90,86},{-90,86},{-90,74},{-108,74}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Livingroom.thermCeiling, thermCeiling_Livingroom) annotation (
             Line(
              points={{-44.2,68.4},{-32,68.4},{-32,86},{-92,86},{-92,109}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Livingroom.thermInsideWall1a, Hobby.thermInsideWall1)
            annotation (Line(
              points={{-44.2,55.6},{-32,55.6},{-32,86},{36,86},{36,54.4},{47.9,54.4}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Hobby.thermCeiling, thermCeiling_Hobby) annotation (Line(
              points={{47.9,68.8},{36,68.8},{36,86},{-50,86},{-50,109},{-49,109}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Corridor.thermCeiling, thermCeiling_Corridor)
            annotation (Line(
              points={{44,4.3},{36,4.3},{36,86},{-10,86},{-10,109},{-11,109}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(WC_Storage.thermCeiling, thermCeiling_WCStorage) annotation (
              Line(
              points={{47.9,-76.8},{36,-76.8},{36,-92},{90,-92},{90,86},{29,86},{29,
                  109}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Kitchen.thermCeiling, thermCeiling_Kitchen) annotation (Line(
              points={{-46,-74.4},{-34,-74.4},{-34,-92},{90,-92},{90,86},{71,86},{
                  71,109}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Kitchen.thermInsideWall1a, WC_Storage.thermInsideWall1)
            annotation (Line(
              points={{-46,-61.6},{-34,-61.6},{-34,-92},{36,-92},{36,-62},{47.9,-62},
                  {47.9,-62.4}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Livingroom.thermInsideWall1b, Corridor.thermInsideWall2a)
            annotation (Line(
              points={{-44.2,42.8},{-32,42.8},{-32,86},{36,86},{36,-3.3},{44,-3.3}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Kitchen.thermInsideWall2, Livingroom.thermInsideWall2)
            annotation (Line(
              points={{-58,-23.2},{-58,-14},{-90,-14},{-90,6},{-57.4,6},{-57.4,17.2}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Corridor.thermInsideWall3, WC_Storage.thermInsideWall2)
            annotation (Line(
              points={{56,-26.1},{56,-32},{59.3,-32},{59.3,-38.4}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Hobby.thermInsideWall2, Corridor.thermInsideWall1)
            annotation (Line(
              points={{59.3,30.4},{59.3,22},{90,22},{90,14},{56,14},{56,8.1}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Corridor.thermRoom, thermCorridor) annotation (Line(
              points={{66,-5.2},{66,-32},{90,-32},{90,100},{110,100},{110,110}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Hobby.starRoom, StarHobby) annotation (Line(
              points={{61.2,56.8},{61.2,44},{36,44},{36,40},{20,40}},
              color={95,95,95},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          connect(Corridor.starRoom, StarCorridor) annotation (Line(
              points={{58,-5.2},{58,-20},{0,-20}},
              color={95,95,95},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          connect(StarWC_Storage, StarWC_Storage) annotation (Line(
              points={{20,-60},{20,-60}},
              color={95,95,95},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          connect(Corridor.thermRoom, ThermCorridor) annotation (Line(
              points={{66,-5.2},{66,14},{36,14},{36,0},{0,0}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Hobby.thermRoom, ThermHobby) annotation (Line(
              points={{69.18,56.8},{69.18,44},{36,44},{36,60},{20,60}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(ThermLivingroom, Livingroom.thermRoom) annotation (Line(
              points={{-20,60},{-32,60},{-32,48},{-68.4,48},{-68.4,52.4}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Livingroom.AirExchangePort, AirExchangePort[1]) annotation (Line(
              points={{-68.51,77.52},{-68.51,86},{-90,86},{-90,-14.25},{-115,-14.25}},
              color={0,0,127},
              smooth=Smooth.None));

          connect(Hobby.AirExchangePort, AirExchangePort[2]) annotation (Line(
              points={{68.895,75.64},{68.895,86},{-90,86},{-90,-6.75},{-115,-6.75}},
              color={0,0,127},
              smooth=Smooth.None));

          connect(Kitchen.SolarRadiationPort_OW1, South) annotation (Line(
              points={{-83.9,-61.6},{-90,-61.6},{-90,-92},{90,-92},{90,26},{110,26}},
              color={255,128,0},
              smooth=Smooth.None));

          connect(Corridor.thermInsideWall2b, Kitchen.thermInsideWall1b)
            annotation (Line(
              points={{44,-10.9},{36,-10.9},{36,-92},{-34,-92},{-34,-48.8},{-46,
                  -48.8}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(WC_Storage.starRoom, StarWC_Storage) annotation (Line(
              points={{61.2,-64.8},{61.2,-70},{36,-70},{36,-60},{20,-60}},
              color={95,95,95},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          connect(WC_Storage.thermRoom, ThermWC_Storage) annotation (Line(
              points={{69.18,-64.8},{69.18,-70},{36,-70},{36,-40},{20,-40}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(WC_Storage.AirExchangePort, AirExchangePort[3]) annotation (Line(
              points={{68.895,-83.64},{68.895,-92},{-90,-92},{-90,0.75},{-115,0.75}},
              color={0,0,127},
              smooth=Smooth.None));

          connect(Kitchen.AirExchangePort, AirExchangePort[4]) annotation (Line(
              points={{-68.1,-83.52},{-68.1,-92},{-90,-92},{-90,8.25},{-115,8.25}},
              color={0,0,127},
              smooth=Smooth.None));

          connect(Kitchen.starRoom, StarKitchen) annotation (Line(
              points={{-60,-58.4},{-60,-54},{-34,-54},{-34,-60},{-20,-60}},
              color={95,95,95},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          connect(Kitchen.thermRoom, ThermKitchen) annotation (Line(
              points={{-68,-58.4},{-68,-54},{-34,-54},{-34,-40},{-20,-40}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Corridor.AirExchangePort, AirExchangePort_doorSt.y) annotation (
              Line(
              points={{82,-12.8},{90,-12.8},{90,-92},{-90,-92},{-90,-60},{-99.2,-60}},
              color={0,0,127},
              smooth=Smooth.None));

          connect(Livingroom.starRoom, StarLivingroom) annotation (Line(
              points={{-59.6,52.4},{-59.6,48},{-32,48},{-32,40},{-20,40}},
              color={95,95,95},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          connect(Livingroom.thermFloor, ThermFloor[1]) annotation (Line(
              points={{-68.84,38.32},{-68.84,6},{-90,6},{-90,-92},{2,-92},{2,
                  -98.8}},
              color={191,0,0},
              pattern=LinePattern.Dash,
              smooth=Smooth.None));

          connect(Hobby.thermFloor, ThermFloor[2]) annotation (Line(
              points={{69.18,46.24},{69.18,22},{90,22},{90,-92},{8,-92},{2,
                  -96.4}},
              color={191,0,0},
              pattern=LinePattern.Dash,
              smooth=Smooth.None));

          connect(Corridor.thermFloor, ThermFloor[3]) annotation (Line(
              points={{66.4,-13.56},{66.4,-32},{90,-32},{90,-92},{4,-92},{4,-94},{2,-94}},
              color={191,0,0},
              pattern=LinePattern.Dash,
              smooth=Smooth.None));

          connect(WC_Storage.thermFloor, ThermFloor[4]) annotation (Line(
              points={{69.18,-54.24},{90,-54.24},{90,-91.6},{2,-91.6}},
              color={191,0,0},
              pattern=LinePattern.Dash,
              smooth=Smooth.None));
          connect(Kitchen.thermFloor, ThermFloor[5]) annotation (Line(
              points={{-68.4,-44.32},{-90,-44.32},{-90,-92},{-4,-92},{2,-89.2}},
              color={191,0,0},
              pattern=LinePattern.Dash,
              smooth=Smooth.None));

                annotation (__Dymola_Images(Parameters(source="AixLib/Images/House/Groundfloor_5Rooms.png")),
                      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}),
                              graphics), Icon(coordinateSystem(
                  preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                                              graphics={Bitmap(extent={{-96,90},{
                      100,-106}}, fileName=
                      "modelica://AixLib/Images/House/Groundfloor_icon.png"),
                Text(
                  extent={{-66,66},{10,54}},
                  lineColor={0,0,0},
                  textString="Livingroom"),
                Text(
                  extent={{14,76},{64,62}},
                  lineColor={0,0,0},
                  textString="Hobby"),
                Text(
                  extent={{22,24},{56,14}},
                  lineColor={0,0,0},
                  textString="Corridor"),
                Text(
                  extent={{-2,-42},{74,-52}},
                  lineColor={0,0,0},
                  textString="WC_Storage"),
                Text(
                  extent={{-50,-10},{-6,-24}},
                  lineColor={0,0,0},
                  textString="Kitchen")}),
            Documentation(revisions="<html>
<p><ul>
<li><i>April 18, 2014</i> by Ana Constantin:<br/>Added documentation</li>
<li><i>July 10, 2011</i> by Ana Constantin:<br/>Implemented</li>
</ul></p>
</html>",       info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Model for the envelope of the ground floor.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
</html>"));
        end GroundFloorBuildingEnvelope;

        model UpperFloorBuildingEnvelope

            ///////// construction parameters

          parameter Integer TMC =  1 "Themal Mass Class"
            annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice=1 "S", choice = 2 "M", choice = 3 "L", radioButtons = true));

          parameter Integer TIR = 1 "Thermal Insulation Regulation"
           annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice=1
                "EnEV_2009",                                                                                                    choice = 2
                "EnEV_2002",                                                                                                    choice = 3
                "WSchV_1995",  choice = 4 "WSchV_1984",                                                                          radioButtons = true));

          parameter Boolean withFloorHeating = false
            "If true, that floor has different connectors" annotation (Dialog(group = "Construction parameters"), choices(checkBox=true));

            //////////room geometry

         parameter Modelica.SIunits.Length room_width_long=if TIR == 1 then 3.86 else 3.97 "w1 " annotation (Dialog(group = "Dimensions", descriptionLabel = true));

         parameter Modelica.SIunits.Length room_width_short=2.28 "w2 " annotation (Dialog(group = "Dimensions", descriptionLabel = true));

         parameter Modelica.SIunits.Height room_height_long=2.60 "h1 " annotation (Dialog(group = "Dimensions", descriptionLabel = true));

         parameter Modelica.SIunits.Height room_height_short=1 "h2 " annotation (Dialog(group = "Dimensions", descriptionLabel = true));

         parameter Modelica.SIunits.Length roof_width = 2.21 "wRO" annotation (Dialog(group = "Dimensions", descriptionLabel = true));

         parameter Modelica.SIunits.Length length5=if TIR == 1 then 3.23 else 3.34 "l5 " annotation (Dialog(group = "Dimensions", descriptionLabel = true));

         parameter Modelica.SIunits.Length length6=2.44 "l6 " annotation (Dialog(group = "Dimensions", descriptionLabel = true));

         parameter Modelica.SIunits.Length length7=1.33 "l7 " annotation (Dialog(group = "Dimensions", descriptionLabel = true));

         parameter Modelica.SIunits.Length length8=if TIR == 1 then 3.23 else 3.34 "l8 " annotation (Dialog(group = "Dimensions", descriptionLabel = true));

         parameter Modelica.SIunits.Length thickness_IWsimple=0.145
            "thickness IWsimple "                                                         annotation (Dialog(group = "Dimensions", descriptionLabel = true));

         // Outer walls properties

         parameter Real solar_absorptance_OW=0.6
            "Solar absoptance outer walls "                                     annotation (Dialog(group = "Outer wall properties", descriptionLabel = true));

         parameter Real solar_absorptance_RO=0.1 "Solar absoptance roof "
                                                                         annotation (Dialog(group = "Outer wall properties", descriptionLabel = true));

         //Windows and Doors

          parameter Modelica.SIunits.Area windowarea_62=1.73 " Area Window62" annotation (Dialog(group = "Windows and Doors", descriptionLabel = true, joinNext = true));

          parameter Modelica.SIunits.Area windowarea_63=1.73 " Area Window63  "
                                                                                annotation (Dialog(group = "Windows and Doors", descriptionLabel = true));

          parameter Modelica.SIunits.Area windowarea_72=1.73 " Area Window72" annotation (Dialog(group = "Windows and Doors", descriptionLabel = true, joinNext=true));

          parameter Modelica.SIunits.Area windowarea_73=1.73 " Area Window73  "
                                                                                annotation (Dialog(group = "Windows and Doors", descriptionLabel = true));

          parameter Modelica.SIunits.Area windowarea_92=1.73 " Area Window51" annotation (Dialog(group = "Windows and Doors", descriptionLabel = true));

          parameter Modelica.SIunits.Area windowarea_102=1.73 " Area Window102"
                                                                                annotation (Dialog(group = "Windows and Doors", descriptionLabel = true, joinNext=true));

          parameter Modelica.SIunits.Area windowarea_103=1.73
            " Area Window103  "                                                   annotation (Dialog(group = "Windows and Doors", descriptionLabel = true));

             parameter Real AirExchangeCorridor = 2
            "Air exchange corridors in 1/h "                                         annotation(Dialog(group = "Air Exchange Corridors", descriptionLabel = true));

                // Dynamic Ventilation
          parameter Boolean withDynamicVentilation = true "Dynamic ventilation"
                                                                                annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true), choices(checkBox=true));
          parameter Modelica.SIunits.Temperature HeatingLimit = 253.15
            "Outside temperature at which the heating activates" annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true,  enable = if withDynamicVentilation then true else false));
          parameter Real Max_VR = 200 "Maximal ventilation rate" annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true,  enable = if withDynamicVentilation then true else false));
          parameter Modelica.SIunits.TemperatureDifference Diff_toTempset = 3
            "Difference to set temperature" annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true,  enable = if withDynamicVentilation then true else false));
          parameter Modelica.SIunits.Temperature Tset_Bedroom = 295.15
            "Tset_bedroom"
                   annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true,  joinNext = true, enable = if withDynamicVentilation then true else false));
          parameter Modelica.SIunits.Temperature Tset_Children1 = 295.15
            "Tset_children1"
                   annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true, enable = if withDynamicVentilation then true else false));
          parameter Modelica.SIunits.Temperature Tset_Bath = 297.15 "Tset_Bath"
                   annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true,  joinNext = true, enable = if withDynamicVentilation then true else false));
           parameter Modelica.SIunits.Temperature Tset_Children2 = 295.15
            "Tset_children2"
                   annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true, enable = if withDynamicVentilation then true else false));

          Utilities.Interfaces.SolarRad_in RoofS annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={110,44})));

          Utilities.Interfaces.SolarRad_in RoofN annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={110,76})));

          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor_Bedroom
            annotation (Placement(transformation(extent={{-100,-120},{-80,-100}})));

          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor_Children1
            annotation (Placement(transformation(extent={{-60,-120},{-40,-100}})));

          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor_Corridor
            annotation (Placement(transformation(extent={{-20,-120},{0,-100}})));

          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor_Bath
            annotation (Placement(transformation(extent={{20,-120},{40,-100}})));

          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor_Children2
            annotation (Placement(transformation(extent={{60,-120},{80,-100}})));

          Rooms.OFD.Ow2IwL2IwS1Lf1At1Ro1         Bedroom(
            TMC=TMC,
            TIR=TIR,
            solar_absorptance_OW=solar_absorptance_OW,
            withWindow2=true,
            room_length=length5 + length6 + thickness_IWsimple,
            room_lengthb=length6,
            room_width_long=room_width_long,
            room_width_short=room_width_short,
            room_height_long=room_height_long,
            room_height_short=room_height_short,
            roof_width=roof_width,
            solar_absorptance_RO=solar_absorptance_RO,
            windowarea_OW2=windowarea_62,
            withWindow3=true,
            windowarea_RO=windowarea_63,
            withDoor2=false,
            withFloorHeating=withFloorHeating,
            T0_air=295.11,
            T0_OW1=295.15,
            T0_OW2=295.15,
            T0_IW1a=295.15,
            T0_IW1b=295.15,
            T0_IW2=295.15,
            T0_CE=295.1,
            T0_RO=295.15,
            T0_FL=295.12,
            withDynamicVentilation=withDynamicVentilation,
            HeatingLimit=HeatingLimit,
            Max_VR=Max_VR,
            Diff_toTempset=Diff_toTempset,
            Tset=Tset_Bedroom)
            annotation (Placement(transformation(extent={{-82,14},{-42,78}})));

          Rooms.OFD.Ow2IwL1IwS1Lf1At1Ro1         Children1(
            TMC=TMC,
            TIR=TIR,
            solar_absorptance_OW=solar_absorptance_OW,
            withWindow2=true,
            room_length=length5,
            room_width_long=room_width_long,
            room_width_short=room_width_short,
            room_height_long=room_height_long,
            room_height_short=room_height_short,
            roof_width=roof_width,
            solar_absorptance_RO=solar_absorptance_RO,
            windowarea_OW2=windowarea_72,
            withWindow3=true,
            windowarea_RO=windowarea_73,
            withDoor2=false,
            withFloorHeating=withFloorHeating,
            T0_air=295.11,
            T0_OW1=295.15,
            T0_OW2=295.15,
            T0_IW1=295.15,
            T0_IW2=295.15,
            T0_CE=295.1,
            T0_RO=295.15,
            T0_FL=295.12,
            withDynamicVentilation=withDynamicVentilation,
            HeatingLimit=HeatingLimit,
            Max_VR=Max_VR,
            Diff_toTempset=Diff_toTempset,
            Tset=Tset_Children1)
            annotation (Placement(transformation(extent={{82,28},{44,76}})));

          Rooms.OFD.Ow2IwL1IwS1Lf1At1Ro1         Bath(
            TMC=TMC,
            TIR=TIR,
            solar_absorptance_OW=solar_absorptance_OW,
            room_length=length8,
            room_width_long=room_width_long,
            room_width_short=room_width_short,
            room_height_long=room_height_long,
            room_height_short=room_height_short,
            roof_width=roof_width,
            solar_absorptance_RO=solar_absorptance_RO,
            windowarea_OW2=windowarea_92,
            withDoor2=false,
            door_width_OD2=0,
            door_height_OD2=0,
            withWindow2=true,
            withWindow3=false,
            withFloorHeating=withFloorHeating,
            T0_air=297.11,
            T0_OW1=297.15,
            T0_OW2=297.15,
            T0_IW1=297.15,
            T0_IW2=297.15,
            T0_CE=297.1,
            T0_RO=297.15,
            T0_FL=297.12,
            withDynamicVentilation=withDynamicVentilation,
            HeatingLimit=HeatingLimit,
            Max_VR=Max_VR,
            Diff_toTempset=Diff_toTempset,
            Tset=Tset_Bath)
            annotation (Placement(transformation(extent={{84,-36},{46,-84}})));

          Rooms.OFD.Ow2IwL2IwS1Lf1At1Ro1         Children2(
            TMC=TMC,
            TIR=TIR,
            solar_absorptance_OW=solar_absorptance_OW,
            withWindow2=true,
            room_length=length7 + length8 + thickness_IWsimple,
            room_width_long=room_width_long,
            room_width_short=room_width_short,
            room_height_long=room_height_long,
            room_height_short=room_height_short,
            roof_width=roof_width,
            solar_absorptance_RO=solar_absorptance_RO,
            windowarea_OW2=windowarea_102,
            withWindow3=true,
            windowarea_RO=windowarea_103,
            room_lengthb=length7,
            withDoor2=false,
            withFloorHeating=withFloorHeating,
            T0_air=295.11,
            T0_OW1=295.15,
            T0_OW2=295.15,
            T0_IW1a=295.15,
            T0_IW1b=295.15,
            T0_IW2=295.15,
            T0_CE=295.1,
            T0_RO=295.15,
            T0_FL=295.12,
            withDynamicVentilation=withDynamicVentilation,
            HeatingLimit=HeatingLimit,
            Max_VR=Max_VR,
            Diff_toTempset=Diff_toTempset,
            Tset=Tset_Children2)                                            annotation (Placement(
                transformation(extent={{-84,-20},{-44,-84}})));

          Rooms.OFD.Ow1IwL2IwS1Lf1At1Ro1         Corridor(
            TMC=TMC,
            TIR=TIR,
            solar_absorptance_OW=solar_absorptance_OW,
            room_length=length6 + length7 + thickness_IWsimple,
            room_lengthb=length7,
            room_width_long=room_width_long,
            room_width_short=room_width_short,
            room_height_long=room_height_long,
            room_height_short=room_height_short,
            roof_width=roof_width,
            solar_absorptance_RO=solar_absorptance_RO,
            withWindow3=false,
            withFloorHeating=withFloorHeating,
            T0_air=291.11,
            T0_OW1=291.15,
            T0_IW1=291.15,
            T0_IW2a=291.15,
            T0_IW2b=291.15,
            T0_IW3=291.15,
            T0_CE=291.1,
            T0_RO=291.15,
            T0_FL=291.12)
            annotation (Placement(transformation(extent={{82,-28},{42,10}})));

          Utilities.Interfaces.SolarRad_in North annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={110,6})));

          Utilities.Interfaces.SolarRad_in East annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={110,-24})));

          Utilities.Interfaces.SolarRad_in South annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={110,-54})));

          Utilities.Interfaces.SolarRad_in West annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={110,-84})));

          Modelica.Blocks.Interfaces.RealInput WindSpeedPort annotation (
              Placement(transformation(extent={{-130,10},{-100,40}})));

          Modelica.Blocks.Interfaces.RealInput AirExchangePort[4]
            annotation (Placement(transformation(extent={{-130,-26},{-100,4}})));

          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermOutside
            annotation (Placement(transformation(extent={{-116,66},{-100,82}})));

          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling_Bedroom
            annotation (Placement(transformation(extent={{-98,100},{-82,118}})));

          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling_Children1
            annotation (Placement(transformation(extent={{-58,100},{-40,118}})));

          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling_Corridor
            annotation (Placement(transformation(extent={{-20,100},{-2,118}})));

          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling_Bath
            annotation (Placement(transformation(extent={{20,100},{38,118}})));

          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling_Children2
            annotation (Placement(transformation(extent={{60,100},{78,118}})));

          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCorridor
            annotation (Placement(transformation(extent={{100,-120},{120,-100}})));

          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermBedroom
            annotation (Placement(transformation(extent={{-26,54},{-14,66}})));

          Utilities.Interfaces.Star StarBedroom annotation (Placement(
                transformation(extent={{-28,32},{-12,48}})));

          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermChildren1
            annotation (Placement(transformation(extent={{14,54},{26,66}})));

          Utilities.Interfaces.Star StarChildren1 annotation (Placement(
                transformation(extent={{12,32},{28,48}})));

          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermBath
            annotation (Placement(transformation(extent={{14,-46},{26,-34}})));

          Utilities.Interfaces.Star StarBath annotation (Placement(
                transformation(extent={{12,-68},{28,-52}})));

          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermChildren2
            annotation (Placement(transformation(extent={{-26,-46},{-14,-34}})));

          Utilities.Interfaces.Star StarChildren2 annotation (Placement(
                transformation(extent={{-28,-68},{-12,-52}})));

          Modelica.Blocks.Sources.Constant AirExchangePort_doorSt(k=0)
            "Storage"                                               annotation (
             Placement(transformation(extent={{-116,-68},{-100,-52}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermFloor[4] if
                                                    withFloorHeating annotation (
              Placement(transformation(extent={{-6,-6},{6,6}}), iconTransformation(
                  extent={{-4,-2},{10,8}})));
        equation
          if withFloorHeating then
             connect(Bedroom.thermFloor1, ThermFloor[1]) annotation (Line(
              points={{-66.4,38.32},{-90,38.32},{-90,-4.5},{0,-4.5}},
              color={191,0,0},
              pattern=LinePattern.Dash,
              smooth=Smooth.None));
          connect(Children1.thermFloor1, ThermFloor[2]) annotation (Line(
              points={{67.18,46.24},{90,46.24},{90,20},{0,20},{0,-1.5}},
              color={191,0,0},
              pattern=LinePattern.Dash,
              smooth=Smooth.None));
          connect(Bath.thermRoom, ThermFloor[3]) annotation (Line(
              points={{68.8,-64.8},{90,-64.8},{90,20},{0,20},{0,1.5}},
              color={191,0,0},
              pattern=LinePattern.Dash,
              smooth=Smooth.None));
          connect(Children2.thermRoom, ThermFloor[4]) annotation (Line(
              points={{-68,-58.4},{-90,-58.4},{-90,-4},{0,-4},{0,4.5}},
              color={191,0,0},
              pattern=LinePattern.Dash,
              smooth=Smooth.None));

          end if;

          connect(Bedroom.SolarRadiationPort_OW2, West)    annotation (Line(
              points={{-53.1,78.32},{-53.1,86},{90,86},{90,-84},{110,-84}},
              color={255,128,0},
              smooth=Smooth.None));

          connect(Children1.SolarRadiationPort_OW2, West)
                                                      annotation (Line(
              points={{54.545,76.24},{54.545,86},{90,86},{90,-84},{110,-84}},
              color={255,128,0},
              smooth=Smooth.None));

          connect(Children1.SolarRadiationPort_OW1, North)
                                                       annotation (Line(
              points={{81.905,59.2},{90,59.2},{90,6},{110,6}},
              color={255,128,0},
              smooth=Smooth.None));

          connect(Corridor.SolarRadiationPort_OW1, North)
            annotation (Line(
              points={{81.9,-3.3},{90,-3.3},{90,6},{110,6}},
              color={255,128,0},
              smooth=Smooth.None));

          connect(Bath.SolarRadiationPort_OW1, North)       annotation (Line(
              points={{83.905,-67.2},{90,-67.2},{90,6},{110,6}},
              color={255,128,0},
              smooth=Smooth.None));

          connect(Bath.SolarRadiationPort_OW2, East)       annotation (Line(
              points={{56.545,-84.24},{56.545,-92},{-90,-92},{-90,86},{90,86},
                  {90,-24},{110,-24}},
              color={255,128,0},
              smooth=Smooth.None));

          connect(Children2.SolarRadiationPort_OW2, East)
                                                        annotation (Line(
              points={{-55.1,-84.32},{-55.1,-92},{-90,-92},{-90,86},{90,86},{90,
                  -24},{110,-24}},
              color={255,128,0},
              smooth=Smooth.None));

          connect(Children2.SolarRadiationPort_OW1, South)
                                                         annotation (Line(
              points={{-83.9,-61.6},{-90,-61.6},{-90,86},{90,86},{90,-54},{110,
                  -54}},
              color={255,128,0},
              smooth=Smooth.None));

          connect(Bedroom.SolarRadiationPort_OW1, South)    annotation (Line(
              points={{-81.9,55.6},{-90,55.6},{-90,86},{90,86},{90,-54},{110,
                  -54}},
              color={255,128,0},
              smooth=Smooth.None));

          connect(Bedroom.WindSpeedPort, WindSpeedPort)    annotation (Line(
              points={{-81.9,30},{-90,30},{-90,25},{-115,25}},
              color={0,0,127},
              smooth=Smooth.None));

          connect(Children2.WindSpeedPort, WindSpeedPort)
                                                        annotation (Line(
              points={{-83.9,-36},{-90,-36},{-90,25},{-115,25}},
              color={0,0,127},
              smooth=Smooth.None));

          connect(Bath.WindSpeedPort, WindSpeedPort)       annotation (Line(
              points={{83.905,-50.4},{90,-50.4},{90,-92},{-90,-92},{-90,25},{-115,
                  25}},
              color={0,0,127},
              smooth=Smooth.None));

          connect(Corridor.WindSpeedPort, WindSpeedPort)
            annotation (Line(
              points={{81.9,-18.5},{90,-18.5},{90,-92},{-90,-92},{-90,25},{-115,25}},
              color={0,0,127},
              smooth=Smooth.None));

          connect(Children1.WindSpeedPort, WindSpeedPort)
                                                      annotation (Line(
              points={{81.905,42.4},{90,42.4},{90,-92},{-90,-92},{-90,25},{-115,25}},
              color={0,0,127},
              smooth=Smooth.None));

          connect(Bedroom.thermOutside, thermOutside)    annotation (Line(
              points={{-80,74.8},{-90,74.8},{-90,74},{-108,74}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Children2.thermOutside, thermOutside)
                                                      annotation (Line(
              points={{-82,-80.8},{-90,-80.8},{-90,74},{-108,74}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Bath.thermOutside, thermOutside)       annotation (Line(
              points={{82.1,-81.6},{82.1,-92},{-90,-92},{-90,74},{-108,74}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Corridor.thermOutside, thermOutside)              annotation (
             Line(
              points={{80,8.1},{86,8.1},{86,8},{90,8},{90,-92},{-90,-92},{-90,
                  74},{-108,74}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Children1.thermOutside, thermOutside)
                                                    annotation (Line(
              points={{80.1,73.6},{90,73.6},{90,86},{-90,86},{-90,74},{-108,74}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Bedroom.thermCeiling, thermCeiling_Bedroom)       annotation (
             Line(
              points={{-44,62},{-32,62},{-32,86},{-90,86},{-90,109}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Children1.thermCeiling, thermCeiling_Children1)
                                                          annotation (Line(
              points={{45.9,68.8},{36,68.8},{36,86},{-50,86},{-50,110},{-49,109}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Corridor.thermCeiling, thermCeiling_Corridor)
            annotation (Line(
              points={{44,0.5},{36,0.5},{36,86},{-12,86},{-12,110},{-11,109}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Bath.thermCeiling, thermCeiling_Bath)            annotation (
              Line(
              points={{47.9,-76.8},{36,-76.8},{36,-92},{90,-92},{90,86},{29,86},{29,
                  109}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Children2.thermCeiling, thermCeiling_Children2)
                                                              annotation (Line(
              points={{-46,-68},{-34,-68},{-34,-92},{90,-92},{90,86},{69,86},{69,
                  109}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Children2.thermInsideWall1a, Bath.thermInsideWall1)
            annotation (Line(
              points={{-46,-55.2},{-46,-56},{-34,-56},{-34,-92},{36,-92},{36,-62},{
                  47.9,-62},{47.9,-62.4}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Children2.thermInsideWall1b, Corridor.thermInsideWall2b)
            annotation (Line(
              points={{-46,-42.4},{-34,-42.4},{-34,-92},{36,-92},{36,-14},{44,
                  -14},{44,-14.7}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Children2.thermInsideWall2, Bedroom.thermInsideWall2)
            annotation (Line(
              points={{-58,-23.2},{-58,-14},{-90,-14},{-90,6},{-56,6},{-56,17.2}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Corridor.thermInsideWall3, Bath.thermInsideWall2)
            annotation (Line(
              points={{56,-26.1},{56,-32},{59.3,-32},{59.3,-38.4}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Children1.thermInsideWall2, Corridor.thermInsideWall1)
            annotation (Line(
              points={{57.3,30.4},{57.3,18},{64,18},{64,8.1}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Bedroom.SolarRadiationPort_Roof, RoofS)
            annotation (Line(
              points={{-47.2,78},{-48,78},{-48,86},{90,86},{90,44},{110,44}},
              color={255,128,0},
              smooth=Smooth.None));

          connect(Children1.SolarRadiationPort_Roof, RoofN)
            annotation (Line(
              points={{48.94,76},{48.94,86},{90,86},{90,76},{110,76}},
              color={255,128,0},
              smooth=Smooth.None));

          connect(Corridor.SolarRadiationPort_Roof, RoofN)
            annotation (Line(
              points={{47.2,10},{48,10},{48,18},{90,18},{90,76},{110,76}},
              color={255,128,0},
              smooth=Smooth.None));

          connect(Bath.SolarRadiationPort_Roof, RoofN)
            annotation (Line(
              points={{50.94,-84},{50,-84},{50,-92},{90,-92},{90,76},{110,76}},
              color={255,128,0},
              smooth=Smooth.None));

          connect(Bedroom.thermFloor, thermFloor_Bedroom) annotation (Line(
              points={{-68,17.2},{-68,6},{-90,6},{-90,-110}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Children1.thermFloor, thermFloor_Children1) annotation (Line(
              points={{68.7,30.4},{68,26},{68,20},{90,20},{90,-92},{-50,-92},{
                  -50,-110}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Corridor.thermFloor, thermFloor_Corridor) annotation (Line(
              points={{68,-26.1},{68,-32},{90,-32},{90,-92},{-10,-92},{-10,-110}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Bath.thermFloor, thermFloor_Bath) annotation (Line(
              points={{70.7,-38.4},{70.7,-32},{90,-32},{90,-92},{30,-92},{30,
                  -110}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Children2.thermFloor, thermFloor_Children2) annotation (Line(
              points={{-70,-23.2},{-70,-14},{-90,-14},{-90,-92},{70,-92},{70,-110}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Corridor.thermRoom, thermCorridor) annotation (Line(
              points={{66,-5.2},{66,-14},{90,-14},{90,-110},{110,-110}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Bedroom.AirExchangePort, AirExchangePort[1]) annotation (Line(
              points={{-67.3,76.88},{-67.3,86},{-90,86},{-90,-22.25},{-115,-22.25}},
              color={0,0,127},
              smooth=Smooth.None));

          connect(Children1.AirExchangePort, AirExchangePort[2]) annotation (Line(
              points={{66.895,75.64},{66.895,86},{-90,86},{-90,-14.75},{-115,-14.75}},
              color={0,0,127},
              smooth=Smooth.None));

          connect(Bath.AirExchangePort, AirExchangePort[3]) annotation (Line(
              points={{68.895,-83.64},{68.895,-92},{-90,-92},{-90,-7.25},{-115,
                  -7.25}},
              color={0,0,127},
              smooth=Smooth.None));

          connect(Children2.AirExchangePort, AirExchangePort[4]) annotation (Line(
              points={{-69.3,-82.88},{-69.3,-92},{-90,-92},{-90,0.25},{-115,0.25}},
              color={0,0,127},
              smooth=Smooth.None));

          connect(Children1.starRoom, StarChildren1) annotation (Line(
              points={{59.2,56.8},{59.2,46},{36,46},{36,40},{20,40}},
              color={95,95,95},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          connect(Children1.thermRoom, ThermChildren1) annotation (Line(
              points={{66.8,56.8},{66.8,46},{36,46},{36,60},{20,60}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Bedroom.thermInsideWall1a, Children1.thermInsideWall1)
            annotation (Line(
              points={{-44,49.2},{-32,49.2},{-32,86},{36,86},{36,54.4},{45.9,54.4}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Bedroom.thermRoom, ThermBedroom) annotation (Line(
              points={{-66,52.4},{-66,28},{-32,28},{-32,60},{-20,60}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Bedroom.starRoom, StarBedroom) annotation (Line(
              points={{-58,52.4},{-58,28},{-32,28},{-32,40},{-20,40}},
              color={95,95,95},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          connect(Bedroom.thermInsideWall1b, Corridor.thermInsideWall2a)
            annotation (Line(
              points={{-44,36.4},{-32,36.4},{-32,86},{36,86},{36,-7.1},{44,-7.1}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Children2.starRoom, StarChildren2) annotation (Line(
              points={{-60,-58.4},{-60,-34},{-34,-34},{-34,-60},{-20,-60}},
              color={95,95,95},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          connect(Children2.thermRoom, ThermChildren2) annotation (Line(
              points={{-68,-58.4},{-68,-34},{-34,-34},{-34,-40},{-20,-40}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Bath.starRoom, StarBath) annotation (Line(
              points={{61.2,-64.8},{61.2,-52},{36,-52},{36,-60},{20,-60}},
              color={95,95,95},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          connect(Bath.thermRoom, ThermBath) annotation (Line(
              points={{68.8,-64.8},{68.8,-52},{36,-52},{36,-40},{20,-40}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Children2.SolarRadiationPort_Roof, RoofS) annotation (Line(
              points={{-49.2,-84},{-50,-84},{-50,-92},{90,-92},{90,44},{110,44}},
              color={255,128,0},
              smooth=Smooth.None));
          connect(Corridor.AirExchangePort, AirExchangePort_doorSt.y) annotation (
              Line(
              points={{82,-10.71},{90,-10.71},{90,-92},{-90,-92},{-90,-60},{-99.2,
                  -60}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(Bedroom.thermFloor1, ThermFloor[1]) annotation (Line(
              points={{-66.4,38.32},{-90,38.32},{-90,-4.5},{0,-4.5}},
              color={191,0,0},
              pattern=LinePattern.Dash,
              smooth=Smooth.None));
          connect(Children1.thermFloor1, ThermFloor[2]) annotation (Line(
              points={{67.18,46.24},{90,46.24},{90,20},{0,20},{0,-1.5}},
              color={191,0,0},
              pattern=LinePattern.Dash,
              smooth=Smooth.None));
          connect(Bath.thermRoom, ThermFloor[3]) annotation (Line(
              points={{68.8,-64.8},{90,-64.8},{90,20},{0,20},{0,1.5}},
              color={191,0,0},
              pattern=LinePattern.Dash,
              smooth=Smooth.None));
          connect(Children2.thermRoom, ThermFloor[4]) annotation (Line(
              points={{-68,-58.4},{-90,-58.4},{-90,-4},{0,-4},{0,4.5}},
              color={191,0,0},
              pattern=LinePattern.Dash,
              smooth=Smooth.None));
                annotation (__Dymola_Images(Parameters(source="AixLib/Images/House/Upperfloor_5Rooms.png")),
                      Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
                    -100},{100,100}}),
                              graphics), Icon(coordinateSystem(
                  preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                                              graphics={Bitmap(extent={{-96,90},{100,-106}},
                    fileName=
                      "modelica://AixLib/Images/House/Upperfloor_icon.png"),
                Text(
                  extent={{-56,74},{-4,60}},
                  lineColor={0,0,0},
                  textString="Bedroom"),
                Text(
                  extent={{16,76},{62,66}},
                  lineColor={0,0,0},
                  textString="Children1"),
                Text(
                  extent={{22,28},{64,14}},
                  lineColor={0,0,0},
                  textString="Corridor"),
                Text(
                  extent={{22,-42},{58,-56}},
                  lineColor={0,0,0},
                  textString="Bath"),
                Text(
                  extent={{-62,-2},{-6,-16}},
                  lineColor={0,0,0},
                  textString="Children2")}),
            Documentation(revisions="<html>

<p><ul>
<li><i>April 18, 2014</i> by Ana Constantin:<br/>Added documentation</li>
<li><i>July 10, 2011</i> by Ana Constantin:<br/>Implemented</li>

</ul></p>

</html>",       info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Model for the envelope of the upper floor.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
</html>"));
        end UpperFloorBuildingEnvelope;

        model WholeHouseBuildingEnvelope
          import AixLib;

          ///////// construction parameters

          parameter Integer TMC =  1 "Themal Mass Class"
            annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice=1 "S", choice = 2 "M", choice = 3 "L", radioButtons = true));

          parameter Integer TIR = 1 "Thermal Insulation Regulation"
           annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice=1
                "EnEV_2009",                                                                                                    choice = 2
                "EnEV_2002",                                                                                                    choice = 3
                "WSchV_1995",  choice = 4 "WSchV_1984",                                                                          radioButtons = true));
          parameter Integer TRY = 1 "Region according to TRY" annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice=1 "TRY01",
                         choice = 2 "TRY02", choice = 3 "TRY03",  choice = 4 "TRY04", choice = 5 "TRY05", choice = 6 "TRY06", choice = 7 "TRY07", choice = 8 "TRY08",
                choice = 9 "TRY09", choice = 10 "TRY10", choice = 11 "TRY11", choice = 12 "TRY12", choice = 13 "TRY13", choice = 14 "TRY14", choice= 15 "TRY15",radioButtons = true));

          parameter Boolean withFloorHeating = false
            "If true, that floor has different connectors" annotation (Dialog(group = "Construction parameters"), choices(checkBox=true));

          replaceable package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater
            "Medium in the system"
            annotation (Dialog(tab = "Hydraulics", group = "Medium"),choicesAllMatching=true);
          parameter Real AirExchangeCorridor = 2
            "Air exchange corridors in 1/h "                                      annotation(Dialog(group = "Air Exchange Corridors", descriptionLabel = true));
          parameter Real AirExchangeAttic = 0 "Air exchange attic in 1/h " annotation(Dialog(group = "Air Exchange Attic", descriptionLabel = true));

                // Dynamic Ventilation
          parameter Boolean withDynamicVentilation = true "Dynamic ventilation"
                                                                                annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true), choices(checkBox=true));
          parameter Modelica.SIunits.Temperature HeatingLimit = 253.15
            "Outside temperature at which the heating activates" annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true,  enable = if withDynamicVentilation then true else false));
          parameter Real Max_VR = 200 "Maximal ventilation rate" annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true,  enable = if withDynamicVentilation then true else false));
          parameter Modelica.SIunits.TemperatureDifference Diff_toTempset = 3
            "Difference to set temperature" annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true,  enable = if withDynamicVentilation then true else false));

          GroundFloorBuildingEnvelope
            groundFloor_Building(
            TMC=TMC,
            TIR=TIR,
            withDynamicVentilation=withDynamicVentilation,
            HeatingLimit=HeatingLimit,
            Max_VR=Max_VR,
            Diff_toTempset=Diff_toTempset,
            withFloorHeating=withFloorHeating)
            annotation (Placement(transformation(extent={{-26,-94},{22,-42}})));
          AixLib.Building.HighOrder.House.OFD_MiddleInnerLoadWall.BuildingEnvelope.UpperFloorBuildingEnvelope
            upperFloor_Building(
            TMC=TMC,
            TIR=TIR,
            HeatingLimit=HeatingLimit,
            Max_VR=Max_VR,
            Diff_toTempset=Diff_toTempset,
            withDynamicVentilation=withDynamicVentilation,
            withFloorHeating=withFloorHeating)
            annotation (Placement(transformation(extent={{-26,-22},{20,30}})));
          Rooms.OFD.Attic_Ro2Lf5         attic_2Ro_5Rooms(
            length=10.64,
            room1_length=5.875,
            room2_length=3.215,
            room3_length=3.92,
            room4_length=3.215,
            room5_length=4.62,
            room1_width=3.84,
            room2_width=3.84,
            room3_width=3.84,
            room4_width=3.84,
            room5_width=3.84,
            roof_width1=3.36,
            roof_width2=3.36,
            solar_absorptance_RO=0.1,
            width=4.75,
            TMC=TMC,
            TIR=TIR,
            alfa=1.5707963267949)
            annotation (Placement(transformation(extent={{-26,46},{20,86}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermOutside
            annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
          Modelica.Blocks.Interfaces.RealInput WindSpeedPort
            annotation (Placement(transformation(extent={{-120,26},{-80,66}}),
                iconTransformation(extent={{-108,38},{-80,66}})));
          Modelica.Blocks.Interfaces.RealInput AirExchangePort[4]
            annotation (Placement(transformation(extent={{-120,-16},{-80,24}}),
                iconTransformation(extent={{-108,-4},{-80,24}})));
          Utilities.Interfaces.SolarRad_in SolarRadiationPort_RoofS
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={90,58})));
          Utilities.Interfaces.SolarRad_in SolarRadiationPort_RoofN
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={90,90})));
          Utilities.Interfaces.SolarRad_in North annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={90,18})));
          Utilities.Interfaces.SolarRad_in East annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={90,-18})));
          Utilities.Interfaces.SolarRad_in South annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={90,-56})));
          Utilities.Interfaces.SolarRad_in West annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={90,-90})));
          AixLib.Building.Components.DryAir.VarAirExchange varAirExchange(V=
                upperFloor_Building.Corridor.airload.V) annotation (Placement(
                transformation(
                extent={{-6,-6},{6,6}},
                rotation=270,
                origin={36,-32})));
          Modelica.Blocks.Sources.Constant AirExchangeCorridor_Source(k=
                AirExchangeCorridor) annotation (Placement(transformation(
                  extent={{22,-34},{26,-30}})));
          Modelica.Blocks.Sources.Constant AirExchangeAttic_Source(k=AirExchangeAttic)
                                     annotation (Placement(transformation(
                  extent={{-60,70},{-52,78}})));
        equation
          connect(groundFloor_Building.thermCeiling_Livingroom, upperFloor_Building.thermFloor_Bedroom)
            annotation (Line(
              points={{-24.08,-39.66},{-24.08,-32.83},{-23.7,-32.83},{-23.7,-24.6}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(groundFloor_Building.thermCeiling_Hobby, upperFloor_Building.thermFloor_Children1)
            annotation (Line(
              points={{-13.76,-39.66},{-13.76,-32.83},{-14.5,-32.83},{-14.5,-24.6}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(groundFloor_Building.thermCeiling_Corridor, upperFloor_Building.thermFloor_Corridor)
            annotation (Line(
              points={{-4.64,-39.66},{-4.64,-32.83},{-5.3,-32.83},{-5.3,-24.6}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(groundFloor_Building.thermCeiling_WCStorage, upperFloor_Building.thermFloor_Bath)
            annotation (Line(
              points={{4.96,-39.66},{4.96,-32.83},{3.9,-32.83},{3.9,-24.6}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(groundFloor_Building.thermCeiling_Kitchen, upperFloor_Building.thermFloor_Children2)
            annotation (Line(
              points={{15.04,-39.66},{15.04,-32.83},{13.1,-32.83},{13.1,-24.6}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(upperFloor_Building.thermOutside, thermOutside) annotation (Line(
              points={{-27.84,23.24},{-74,23.24},{-74,90},{-90,90}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(attic_2Ro_5Rooms.thermOutside, thermOutside) annotation (Line(
              points={{-23.7,84},{-74,84},{-74,90},{-90,90}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(groundFloor_Building.thermOutside, thermOutside) annotation (Line(
              points={{-27.92,-48.76},{-74,-48.76},{-74,90},{-90,90}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(upperFloor_Building.thermCeiling_Bedroom, attic_2Ro_5Rooms.thermRoom1)
            annotation (Line(
              points={{-23.7,32.34},{-23.7,48}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(upperFloor_Building.thermCeiling_Children1, attic_2Ro_5Rooms.thermRoom2)
            annotation (Line(
              points={{-14.27,32.34},{-14.27,40.17},{-14.5,40.17},{-14.5,48}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(upperFloor_Building.thermCeiling_Corridor, attic_2Ro_5Rooms.thermRoom3)
            annotation (Line(
              points={{-5.53,32.34},{-5.53,40.17},{-5.3,40.17},{-5.3,48}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(upperFloor_Building.thermCeiling_Bath, attic_2Ro_5Rooms.thermRoom4)
            annotation (Line(
              points={{3.67,32.34},{3.67,40.17},{3.9,40.17},{3.9,48}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(upperFloor_Building.thermCeiling_Children2, attic_2Ro_5Rooms.thermRoom5)
            annotation (Line(
              points={{12.87,32.34},{12.87,39.17},{13.1,39.17},{13.1,48}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(attic_2Ro_5Rooms.WindSpeedPort, WindSpeedPort) annotation (Line(
              points={{-25.885,66},{-74,66},{-74,46},{-100,46}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(upperFloor_Building.WindSpeedPort, WindSpeedPort) annotation (Line(
              points={{-29.45,10.5},{-32,12},{-74,12},{-74,46},{-100,46}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(groundFloor_Building.WindSpeedPort, WindSpeedPort) annotation (Line(
              points={{-29.6,-60.98},{-74,-60.98},{-74,46},{-100,46}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(upperFloor_Building.North, North) annotation (Line(
              points={{22.3,5.56},{60,5.56},{60,18},{90,18}},
              color={255,128,0},
              smooth=Smooth.None));
          connect(groundFloor_Building.North, North) annotation (Line(
              points={{24.4,-45.12},{60,-45.12},{60,18},{90,18}},
              color={255,128,0},
              smooth=Smooth.None));
          connect(upperFloor_Building.East, East) annotation (Line(
              points={{22.3,-2.24},{60,-2.24},{60,-18},{90,-18}},
              color={255,128,0},
              smooth=Smooth.None));
          connect(groundFloor_Building.East, East) annotation (Line(
              points={{24.4,-52.4},{60,-52.4},{60,-18},{90,-18}},
              color={255,128,0},
              smooth=Smooth.None));
          connect(upperFloor_Building.South, South) annotation (Line(
              points={{22.3,-10.04},{60,-10.04},{60,-56},{90,-56}},
              color={255,128,0},
              smooth=Smooth.None));
          connect(groundFloor_Building.South, South) annotation (Line(
              points={{24.4,-61.24},{60,-61.24},{60,-56},{90,-56}},
              color={255,128,0},
              smooth=Smooth.None));
          connect(upperFloor_Building.West, West)  annotation (Line(
              points={{22.3,-17.84},{60,-17.84},{60,-90},{90,-90}},
              color={255,128,0},
              smooth=Smooth.None));
          connect(groundFloor_Building.West, West)  annotation (Line(
              points={{24.4,-72.16},{60,-72.16},{60,-90},{90,-90}},
              color={255,128,0},
              smooth=Smooth.None));
          connect(upperFloor_Building.RoofS, SolarRadiationPort_RoofS)
            annotation (Line(
              points={{22.3,15.44},{60,15.44},{60,58},{90,58}},
              color={255,128,0},
              smooth=Smooth.None));
          connect(upperFloor_Building.RoofN, SolarRadiationPort_RoofN)
            annotation (Line(
              points={{22.3,23.76},{60,23.76},{60,90},{90,90}},
              color={255,128,0},
              smooth=Smooth.None));
          connect(groundFloor_Building.thermCorridor,varAirExchange.port_b)
            annotation (Line(
              points={{24.4,-39.4},{36,-39.4},{36,-38}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(upperFloor_Building.thermCorridor,varAirExchange.port_a)  annotation (
             Line(
              points={{22.3,-24.6},{36,-24.6},{36,-26}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(AirExchangeCorridor_Source.y, varAirExchange.InPort1)
            annotation (Line(
              points={{26.2,-32},{28,-32},{28,-24},{32.16,-24},{32.16,-26.6}},
              color={0,0,127},
              smooth=Smooth.None));

          connect(groundFloor_Building.AirExchangePort, AirExchangePort)
            annotation (Line(
              points={{-29.6,-68.78},{-74,-68.78},{-74,4},{-100,4}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(upperFloor_Building.AirExchangePort, AirExchangePort) annotation (
             Line(
              points={{-29.45,1.14},{-74,1.14},{-74,4},{-100,4}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(AirExchangeAttic_Source.y, attic_2Ro_5Rooms.AirExchangePort)
            annotation (Line(
              points={{-51.6,74},{-26,74}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(attic_2Ro_5Rooms.SolarRadiationPort_RO1, SolarRadiationPort_RoofS)
            annotation (Line(
              points={{-14.5,84},{-14,88},{-14,90},{60,90},{60,58},{90,58}},
              color={255,128,0},
              smooth=Smooth.None));
          connect(attic_2Ro_5Rooms.SolarRadiationPort_RO2, SolarRadiationPort_RoofN)
            annotation (Line(
              points={{8.5,84},{10,84},{10,90},{90,90}},
              color={255,128,0},
              smooth=Smooth.None));
          connect(attic_2Ro_5Rooms.SolarRadiationPort_OW1, SolarRadiationPort_RoofS)
            annotation (Line(
              points={{-27.38,62},{-74,62},{-74,90},{60,90},{60,58},{90,58}},
              color={255,128,0},
              smooth=Smooth.None));
          connect(attic_2Ro_5Rooms.SolarRadiationPort_OW2, SolarRadiationPort_RoofN)
            annotation (Line(
              points={{22.3,62.4},{60,62.4},{60,90},{90,90}},
              color={255,128,0},
              smooth=Smooth.None));
          annotation (__Dymola_Images(Parameters(source="AixLib/Images/House/Grundriss.png")), Icon(
                graphics={Bitmap(extent={{-78,74},{72,-68}}, fileName=
                      "modelica://AixLib/Images/House/Grundriss.PNG")}),
                      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                    -100,-100},{100,100}}),
                              graphics),
            Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Model for the envelope of the whole one family dwelling.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
</html>",       revisions="<html>

<p><ul>
<li><i>April 18, 2014</i> by Ana Constantin:<br/>Added documentation</li>
<li><i>July 10, 2011</i> by Ana Constantin:<br/>Implemented</li>

</ul></p>

</html>"));
        end WholeHouseBuildingEnvelope;
        annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Package with models for the whole building envelope.</p>
</html>"));
      end BuildingEnvelope;

      package EnergySystem
                  extends Modelica.Icons.Package;

        package IdealHeaters
          extends Modelica.Icons.Package;

          model GroundFloor
            parameter Real ratioRadHeat=0.3
              "ratio of radiative heat from total heat generated";

            Utilities.Interfaces.Star Rad_Livingroom annotation (Placement(
                  transformation(extent={{-145,84},{-129,101}})));
            Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Con_Livingroom
              annotation (Placement(transformation(extent={{-143,64},{-130,77}})));
            Utilities.Interfaces.Star Rad_Kitchen annotation (Placement(
                  transformation(extent={{-146,-38},{-129,-22}})));
            Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Con_Kitchen
              annotation (Placement(transformation(extent={{-145,-66},{-131,-51}})));
            Utilities.Interfaces.Star Rad_Hobby annotation (Placement(
                  transformation(extent={{128,90},{146,108}})));
            Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Con_Hobby
              annotation (Placement(transformation(extent={{130,64},{146,82}})));
            Utilities.Interfaces.Star Rad_Corridor annotation (Placement(
                  transformation(extent={{128,34},{148,54}})));
            Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Con_Corridor
              annotation (Placement(transformation(extent={{130,7},{145,24}})));
            Utilities.Interfaces.Star Rad_WC annotation (Placement(
                  transformation(extent={{129,-26},{149,-6}})));
            Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Con_Storage
              annotation (Placement(transformation(extent={{131,-51},{150,-33}})));
            Modelica.Blocks.Interfaces.RealInput TSet_GF[5]    annotation (Placement(
                  transformation(extent={{-86,85},{-58,115}}), iconTransformation(extent={
                      {-79,91},{-58,115}})));

            Modelica.Blocks.Continuous.LimPID PI_livingroom(
              controllerType=Modelica.Blocks.Types.SimpleController.PI,
              k=0.3,
              Ti=10,
              yMax=2000,
              yMin=0) annotation (Placement(transformation(extent={{-106,-14},{
                      -86,6}})));
            Modelica.Blocks.Math.Gain gainConv_livinrgoom(k=1 - ratioRadHeat)
              annotation (Placement(transformation(extent={{-75,0},{-66,9}})));
            Modelica.Blocks.Math.Gain gainRad_livinrgoom(k=ratioRadHeat)
              annotation (Placement(transformation(extent={{-74,-17},{-65,-8}})));
            Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
              SourceConv_livingroom "source convective heat livingroom"
              annotation (Placement(transformation(extent={{-60,-5},{-40,15}})));
            Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
              SourceRad_livingroom "source radiative heat livingroom"
              annotation (Placement(transformation(extent={{-59,-23},{-39,-3}})));
            Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor
              tempSensor_livingroom annotation (Placement(transformation(extent=
                     {{-126,-24},{-114,-12}})));
            Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor
              tempSensor_hobby
              annotation (Placement(transformation(extent={{5,63},{17,75}})));
            Modelica.Blocks.Continuous.LimPID PI_hobby(
              controllerType=Modelica.Blocks.Types.SimpleController.PI,
              k=0.3,
              Ti=10,
              yMax=2000,
              yMin=0)
              annotation (Placement(transformation(extent={{25,73},{45,93}})));
            Modelica.Blocks.Math.Gain gainConv_hobby(k=1 - ratioRadHeat)
              annotation (Placement(transformation(extent={{56,87},{65,96}})));
            Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
              SourceRad_hobby "source radiative heat hobby"
              annotation (Placement(transformation(extent={{72,64},{92,84}})));
            Modelica.Blocks.Math.Gain gainRad_hobby(k=ratioRadHeat)
              annotation (Placement(transformation(extent={{57,70},{66,79}})));
            Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
              SourceConv_hobby "source convective heat hobby"
              annotation (Placement(transformation(extent={{71,82},{91,102}})));
            Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor
              tempSensor_corridor
              annotation (Placement(transformation(extent={{14,15},{26,27}})));
            Modelica.Blocks.Continuous.LimPID PI_corridor(
              controllerType=Modelica.Blocks.Types.SimpleController.PI,
              k=0.3,
              Ti=10,
              yMax=2000,
              yMin=0)
              annotation (Placement(transformation(extent={{34,25},{54,45}})));
            Modelica.Blocks.Math.Gain gainConv_corridor(k=1 - ratioRadHeat)
              annotation (Placement(transformation(extent={{65,39},{74,48}})));
            Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
              SourceRad_corridor "source radiative heat corridor"
              annotation (Placement(transformation(extent={{81,16},{101,36}})));
            Modelica.Blocks.Math.Gain gainRad_corridor(k=ratioRadHeat)
              annotation (Placement(transformation(extent={{66,22},{75,31}})));
            Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
              SourceConv_corridor "source convective heat corridor"
              annotation (Placement(transformation(extent={{80,34},{100,54}})));
            Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor
              tempSensor_WC annotation (Placement(transformation(extent={{24,
                      -66},{36,-54}})));
            Modelica.Blocks.Continuous.LimPID PI_WC(
              controllerType=Modelica.Blocks.Types.SimpleController.PI,
              k=0.3,
              Ti=10,
              yMax=2000,
              yMin=0) annotation (Placement(transformation(extent={{44,-56},{64,
                      -36}})));
            Modelica.Blocks.Math.Gain gainConv_WC(k=1 - ratioRadHeat)
              annotation (Placement(transformation(extent={{75,-42},{84,-33}})));
            Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
              SourceRad_WC "source radiative heat WC" annotation (Placement(
                  transformation(extent={{91,-65},{111,-45}})));
            Modelica.Blocks.Math.Gain gainRad_WC(k=ratioRadHeat) annotation (
                Placement(transformation(extent={{76,-59},{85,-50}})));
            Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
              SourceConv_WC "source convective heat WC" annotation (Placement(
                  transformation(extent={{90,-47},{110,-27}})));
            Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor
              tempSensor_kitchen annotation (Placement(transformation(extent={{
                      -124,-92},{-112,-80}})));
            Modelica.Blocks.Continuous.LimPID PI_kitchen(
              controllerType=Modelica.Blocks.Types.SimpleController.PI,
              k=0.3,
              Ti=10,
              yMax=2000,
              yMin=0) annotation (Placement(transformation(extent={{-104,-82},{
                      -84,-62}})));
            Modelica.Blocks.Math.Gain gainConv_kitchen(k=1 - ratioRadHeat)
              annotation (Placement(transformation(extent={{-73,-68},{-64,-59}})));
            Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
              SourceRad_kitchen "source radiative heat kitchen" annotation (
                Placement(transformation(extent={{-57,-91},{-37,-71}})));
            Modelica.Blocks.Math.Gain gainRad_kitchen(k=ratioRadHeat)
              annotation (Placement(transformation(extent={{-72,-85},{-63,-76}})));
            Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
              SourceConv_kitchen "source convective heat kitchen" annotation (
                Placement(transformation(extent={{-58,-73},{-38,-53}})));
          equation
            connect(PI_livingroom.y, gainConv_livinrgoom.u) annotation (Line(
                points={{-85,-4},{-80,-4},{-80,4.5},{-75.9,4.5}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(PI_livingroom.y, gainRad_livinrgoom.u) annotation (Line(
                points={{-85,-4},{-80,-4},{-80,-12.5},{-74.9,-12.5}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(SourceConv_livingroom.Q_flow, gainConv_livinrgoom.y)
              annotation (Line(
                points={{-60,5},{-62,5},{-62,4.5},{-65.55,4.5}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(gainRad_livinrgoom.y, SourceRad_livingroom.Q_flow)
              annotation (Line(
                points={{-64.55,-12.5},{-61,-12.5},{-61,-13},{-59,-13}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(tempSensor_livingroom.T, PI_livingroom.u_m) annotation (
                Line(
                points={{-114,-18},{-96,-18},{-96,-16}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(tempSensor_livingroom.port, Con_Livingroom) annotation (
                Line(
                points={{-126,-18},{-130,-18},{-130,70.5},{-136.5,70.5}},
                color={191,0,0},
                smooth=Smooth.None));
            connect(PI_livingroom.u_s, TSet_GF[1]) annotation (Line(
                points={{-108,-4},{-114,-4},{-114,-3},{-130,-3},{-130,88},{-72,
                    88}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(SourceConv_livingroom.port, Con_Livingroom) annotation (
                Line(
                points={{-40,5},{-22,5},{-22,28},{-125,28},{-125,70.5},{-136.5,
                    70.5}},
                color={191,0,0},
                smooth=Smooth.None));
            connect(SourceRad_livingroom.port, Rad_Livingroom) annotation (Line(
                points={{-39,-13},{-22,-13},{-22,28},{-125,28},{-125,92.5},{
                    -137,92.5}},
                color={191,0,0},
                smooth=Smooth.None));
            connect(tempSensor_hobby.T, PI_hobby.u_m) annotation (Line(
                points={{17,69},{35,69},{35,71}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(PI_hobby.y, gainRad_hobby.u) annotation (Line(
                points={{46,83},{51,83},{51,74.5},{56.1,74.5}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(PI_hobby.y, gainConv_hobby.u) annotation (Line(
                points={{46,83},{51,83},{51,91.5},{55.1,91.5}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(tempSensor_corridor.T, PI_corridor.u_m) annotation (Line(
                points={{26,21},{44,21},{44,23}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(PI_corridor.y, gainRad_corridor.u) annotation (Line(
                points={{55,35},{60,35},{60,26.5},{65.1,26.5}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(PI_corridor.y, gainConv_corridor.u) annotation (Line(
                points={{55,35},{60,35},{60,43.5},{64.1,43.5}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(tempSensor_WC.T, PI_WC.u_m) annotation (Line(
                points={{36,-60},{54,-60},{54,-58}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(PI_WC.y, gainRad_WC.u) annotation (Line(
                points={{65,-46},{70,-46},{70,-54.5},{75.1,-54.5}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(PI_WC.y, gainConv_WC.u) annotation (Line(
                points={{65,-46},{70,-46},{70,-37.5},{74.1,-37.5}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(tempSensor_kitchen.T, PI_kitchen.u_m) annotation (Line(
                points={{-112,-86},{-94,-86},{-94,-84}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(PI_kitchen.y, gainRad_kitchen.u) annotation (Line(
                points={{-83,-72},{-78,-72},{-78,-80.5},{-72.9,-80.5}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(PI_kitchen.y, gainConv_kitchen.u) annotation (Line(
                points={{-83,-72},{-78,-72},{-78,-63.5},{-73.9,-63.5}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(gainConv_hobby.y, SourceConv_hobby.Q_flow) annotation (Line(
                points={{65.45,91.5},{67.725,91.5},{67.725,92},{71,92}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(gainRad_hobby.y, SourceRad_hobby.Q_flow) annotation (Line(
                points={{66.45,74.5},{68.225,74.5},{68.225,74},{72,74}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(gainRad_corridor.y, SourceRad_corridor.Q_flow) annotation (
                Line(
                points={{75.45,26.5},{77.725,26.5},{77.725,26},{81,26}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(gainConv_corridor.y, SourceConv_corridor.Q_flow)
              annotation (Line(
                points={{74.45,43.5},{76.725,43.5},{76.725,44},{80,44}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(gainConv_WC.y, SourceConv_WC.Q_flow) annotation (Line(
                points={{84.45,-37.5},{87.225,-37.5},{87.225,-37},{90,-37}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(gainRad_WC.y, SourceRad_WC.Q_flow) annotation (Line(
                points={{85.45,-54.5},{87.225,-54.5},{87.225,-55},{91,-55}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(gainConv_kitchen.y, SourceConv_kitchen.Q_flow) annotation (
                Line(
                points={{-63.55,-63.5},{-61.775,-63.5},{-61.775,-63},{-58,-63}},
                color={0,0,127},
                smooth=Smooth.None));

            connect(gainRad_kitchen.y, SourceRad_kitchen.Q_flow) annotation (
                Line(
                points={{-62.55,-80.5},{-59.775,-80.5},{-59.775,-81},{-57,-81}},
                color={0,0,127},
                smooth=Smooth.None));

            connect(tempSensor_kitchen.port, Con_Kitchen) annotation (Line(
                points={{-124,-86},{-124,-86},{-130,-86},{-130,-59},{-134,-59},
                    {-134,-58.5},{-138,-58.5}},
                color={191,0,0},
                smooth=Smooth.None));
            connect(SourceConv_kitchen.port, Con_Kitchen) annotation (Line(
                points={{-38,-63},{-23,-63},{-23,-49},{-130,-49},{-130,-58.5},{
                    -138,-58.5}},
                color={191,0,0},
                smooth=Smooth.None));
            connect(SourceRad_kitchen.port, Rad_Kitchen) annotation (Line(
                points={{-37,-81},{-23,-81},{-23,-30},{-137.5,-30}},
                color={191,0,0},
                smooth=Smooth.None));
            connect(SourceConv_WC.port, Con_Storage) annotation (Line(
                points={{110,-37},{127,-37},{127,-42},{140.5,-42}},
                color={191,0,0},
                smooth=Smooth.None));
            connect(SourceRad_WC.port, Rad_WC) annotation (Line(
                points={{111,-55},{127,-55},{127,-16},{139,-16}},
                color={191,0,0},
                smooth=Smooth.None));
            connect(tempSensor_WC.port, Con_Storage) annotation (Line(
                points={{24,-60},{24,-67},{127,-67},{127,-42},{140.5,-42}},
                color={191,0,0},
                smooth=Smooth.None));
            connect(tempSensor_corridor.port, Con_Corridor) annotation (Line(
                points={{14,21},{3,21},{3,10},{137.5,10},{137.5,15.5}},
                color={191,0,0},
                smooth=Smooth.None));
            connect(SourceRad_corridor.port, Rad_Corridor) annotation (Line(
                points={{101,26},{139,26},{139,44},{138,44}},
                color={191,0,0},
                smooth=Smooth.None));
            connect(SourceConv_corridor.port, Con_Corridor) annotation (Line(
                points={{100,44},{126,44},{126,10},{138,10},{138,13},{137.5,13},
                    {137.5,15.5}},
                color={191,0,0},
                smooth=Smooth.None));
            connect(tempSensor_hobby.port, Con_Hobby) annotation (Line(
                points={{5,69},{0,69},{0,63},{138,63},{138,73}},
                color={191,0,0},
                smooth=Smooth.None));
            connect(SourceRad_hobby.port, Rad_Hobby) annotation (Line(
                points={{92,74},{126,74},{126,99},{137,99}},
                color={191,0,0},
                smooth=Smooth.None));
            connect(SourceConv_hobby.port, Con_Hobby) annotation (Line(
                points={{91,92},{126,92},{126,73},{138,73}},
                color={191,0,0},
                smooth=Smooth.None));
            connect(PI_hobby.u_s, TSet_GF[2]) annotation (Line(
                points={{23,83},{1,83},{1,94},{-72,94}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(PI_corridor.u_s, TSet_GF[3]) annotation (Line(
                points={{32,35},{1,35},{1,100},{-72,100}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(PI_WC.u_s, TSet_GF[4]) annotation (Line(
                points={{42,-46},{24,-46},{24,-46},{1,-46},{1,106},{-72,106}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(PI_kitchen.u_s, TSet_GF[5]) annotation (Line(
                points={{-106,-72},{-130,-72},{-130,112},{-72,112}},
                color={0,0,127},
                smooth=Smooth.None));
          annotation (  Diagram(coordinateSystem(
                  preserveAspectRatio=false,
                  extent={{-130,-100},{130,100}},
                  grid={1,1}), graphics={
                  Rectangle(
                    extent={{1,100},{126,63}},
                    pattern=LinePattern.None,
                    lineColor={0,0,0},
                    fillColor={215,215,215},
                    fillPattern=FillPattern.Solid),
                  Rectangle(
                    extent={{3,58},{126,15}},
                    pattern=LinePattern.None,
                    lineColor={0,0,0},
                    fillColor={215,215,215},
                    fillPattern=FillPattern.Solid),
                  Rectangle(
                    extent={{1,-14},{127,-67}},
                    pattern=LinePattern.None,
                    lineColor={0,0,0},
                    fillColor={215,215,215},
                    fillPattern=FillPattern.Solid),
                  Rectangle(
                    extent={{-129,28},{-22,-26}},
                    pattern=LinePattern.None,
                    lineColor={0,0,0},
                    fillColor={215,215,215},
                    fillPattern=FillPattern.Solid),
                  Rectangle(
                    extent={{-130,-49},{-23,-103}},
                    pattern=LinePattern.None,
                    lineColor={0,0,0},
                    fillColor={215,215,215},
                    fillPattern=FillPattern.Solid),
                  Text(
                    extent={{-120,-88},{-69,-103}},
                    lineColor={0,0,0},
                    fillColor={0,0,0},
                    fillPattern=FillPattern.Solid,
                    textString="Kitchen"),
                  Text(
                    extent={{-155,24},{-48,11}},
                    lineColor={0,0,0},
                    fillColor={0,0,0},
                    fillPattern=FillPattern.Solid,
                    textString="Livingroom"),
                  Text(
                    extent={{31,-15},{138,-28}},
                    lineColor={0,0,0},
                    fillColor={0,0,0},
                    fillPattern=FillPattern.Solid,
                    textString="WC/Storage"),
                  Text(
                    extent={{49,58},{156,45}},
                    lineColor={0,0,0},
                    fillColor={0,0,0},
                    fillPattern=FillPattern.Solid,
                    textString="Corridor"),
                  Text(
                    extent={{51,99},{158,86}},
                    lineColor={0,0,0},
                    fillColor={0,0,0},
                    fillPattern=FillPattern.Solid,
                    textString="Hobby"),
                  Text(
                    extent={{-68,87},{-15,55}},
                    lineColor={0,0,0},
                    textString="1 - Livingroom
2- Hobby
3 - Corridor
4 - WC/Storage
5 - Kitchen")}),                          Icon(coordinateSystem(
                  preserveAspectRatio=true,
                  extent={{-130,-100},{130,100}},
                  grid={1,1}), graphics={
                  Rectangle(
                    extent={{-119,92},{123,-79}},
                    lineColor={255,0,0},
                    fillColor={135,135,135},
                    fillPattern=FillPattern.Solid),
                  Line(
                    points={{-99,22},{104,22},{104,-6}},
                    color={255,0,0},
                    smooth=Smooth.None,
                    thickness=1),
                  Line(
                    points={{-98,13},{95,13},{95,-6}},
                    color={0,0,255},
                    smooth=Smooth.None,
                    thickness=1),
                  Line(
                    points={{-21,13},{-21,35}},
                    color={0,0,255},
                    thickness=1,
                    smooth=Smooth.None),
                  Line(
                    points={{-14,23},{-14,45}},
                    color={255,0,0},
                    thickness=1,
                    smooth=Smooth.None),
                  Text(
                    extent={{-87,74},{-34,42}},
                    lineColor={0,0,0},
                    textString="1 - Livingroom
2- Hobby
3 - Corridor
4 - WC/Storage
5 - Kitchen")}),
              Documentation(revisions="<html>
<p><ul>
<li><i>June 19, 2014</i> by Ana Constantin:<br/>Implemented</li>
</ul></p>
</html>",       info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Model for the ground floor.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
</html>"));
          end GroundFloor;

          model UpperFloor
              parameter Real ratioRadHeat=0.3
              "ratio of radiative heat from total heat generated";

            Utilities.Interfaces.Star Rad_Bedroom annotation (Placement(
                  transformation(extent={{-149,80},{-129,100}})));
            Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Con_Bedroom
              annotation (Placement(transformation(extent={{-150,49},{-130,69}})));
            Utilities.Interfaces.Star Rad_Children2 annotation (Placement(
                  transformation(extent={{-149,-25},{-129,-5}})));
            Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Con_Children2
              annotation (Placement(transformation(extent={{-151,-61},{-131,-41}})));
            Utilities.Interfaces.Star Rad_Children1 annotation (Placement(
                  transformation(extent={{127,63},{147,83}})));
            Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Con_Chidlren1
              annotation (Placement(transformation(extent={{129,40},{149,60}})));
            Utilities.Interfaces.Star Rad_Bath annotation (Placement(
                  transformation(extent={{130,-50},{150,-30}})));
            Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Con_Bath
              annotation (Placement(transformation(extent={{129,-78},{149,-58}})));
            Modelica.Blocks.Interfaces.RealInput TSet_UF[4]    annotation (Placement(
                  transformation(extent={{-85,82},{-57,112}}), iconTransformation(extent={
                      {-77,90},{-57,112}})));

            Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor tempSensor_bedroom
              annotation (Placement(transformation(extent={{-119,-11},{-107,1}})));
            Modelica.Blocks.Continuous.LimPID PI_bedroom(
              controllerType=Modelica.Blocks.Types.SimpleController.PI,
              k=0.3,
              Ti=10,
              yMax=2000,
              yMin=0) annotation (Placement(transformation(extent={{-99,-1},{-79,19}})));
            Modelica.Blocks.Math.Gain gainRad_bedroom(k=ratioRadHeat)
              annotation (Placement(transformation(extent={{-67,-4},{-58,5}})));
            Modelica.Blocks.Math.Gain gainConv_bedroom(k=1 - ratioRadHeat)
              annotation (Placement(transformation(extent={{-68,13},{-59,22}})));
            Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow SourceRad_bedroom
              "source radiative heat bedroom"
              annotation (Placement(transformation(extent={{-52,-10},{-32,10}})));
            Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow SourceConv_bedroom
              "source convective heat bedroom"
              annotation (Placement(transformation(extent={{-53,8},{-33,28}})));
            Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor tempSensor_children1
              annotation (Placement(transformation(extent={{4,36},{16,48}})));
            Modelica.Blocks.Continuous.LimPID PI_children1(
              controllerType=Modelica.Blocks.Types.SimpleController.PI,
              k=0.3,
              Ti=10,
              yMax=2000,
              yMin=0) annotation (Placement(transformation(extent={{24,46},{44,66}})));
            Modelica.Blocks.Math.Gain gainRad_children1(k=ratioRadHeat)
              annotation (Placement(transformation(extent={{56,43},{65,52}})));
            Modelica.Blocks.Math.Gain gainConv_children1(k=1 - ratioRadHeat)
              annotation (Placement(transformation(extent={{55,60},{64,69}})));
            Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow SourceRad_children1
              "source radiative heat children1"
              annotation (Placement(transformation(extent={{71,37},{91,57}})));
            Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow SourceConv_children1
              "source convective heat children1"
              annotation (Placement(transformation(extent={{70,55},{90,75}})));
            Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor tempSensor_bath
              annotation (Placement(transformation(extent={{17,-64},{29,-52}})));
            Modelica.Blocks.Continuous.LimPID PI_bath(
              controllerType=Modelica.Blocks.Types.SimpleController.PI,
              k=0.3,
              Ti=10,
              yMax=2000,
              yMin=0) annotation (Placement(transformation(extent={{37,-54},{57,-34}})));
            Modelica.Blocks.Math.Gain gainRad_bath(k=ratioRadHeat)
              annotation (Placement(transformation(extent={{69,-57},{78,-48}})));
            Modelica.Blocks.Math.Gain gainConv_bath(k=1 - ratioRadHeat)
              annotation (Placement(transformation(extent={{68,-40},{77,-31}})));
            Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow SourceRad_bath
              "source radiative heat bath"
              annotation (Placement(transformation(extent={{84,-63},{104,-43}})));
            Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow SourceConv_bath
              "source convective heat bath"
              annotation (Placement(transformation(extent={{83,-45},{103,-25}})));
            Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor tempSensor_children2
              annotation (Placement(transformation(extent={{-123,-69},{-111,-57}})));
            Modelica.Blocks.Continuous.LimPID PI_children2(
              controllerType=Modelica.Blocks.Types.SimpleController.PI,
              k=0.3,
              Ti=10,
              yMax=2000,
              yMin=0)
              annotation (Placement(transformation(extent={{-103,-59},{-83,-39}})));
            Modelica.Blocks.Math.Gain gainRad_children2(k=ratioRadHeat)
              annotation (Placement(transformation(extent={{-71,-62},{-62,-53}})));
            Modelica.Blocks.Math.Gain gainConv_children2(k=1 - ratioRadHeat)
              annotation (Placement(transformation(extent={{-72,-45},{-63,-36}})));
            Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow SourceRad_children2
              "source radiative heat children2"
              annotation (Placement(transformation(extent={{-56,-68},{-36,-48}})));
            Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow SourceConv_children2
              "source convective heat children2"
              annotation (Placement(transformation(extent={{-57,-50},{-37,-30}})));
          equation
            connect(tempSensor_bedroom.T, PI_bedroom.u_m) annotation (Line(
                points={{-107,-5},{-89,-5},{-89,-3}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(PI_bedroom.y, gainRad_bedroom.u) annotation (Line(
                points={{-78,9},{-73,9},{-73,0.5},{-67.9,0.5}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(PI_bedroom.y, gainConv_bedroom.u) annotation (Line(
                points={{-78,9},{-73,9},{-73,17.5},{-68.9,17.5}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(gainRad_bedroom.y, SourceRad_bedroom.Q_flow) annotation (Line(
                points={{-57.55,0.5},{-54,0.5},{-54,0},{-52,0}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(SourceConv_bedroom.Q_flow, gainConv_bedroom.y) annotation (Line(
                points={{-53,18},{-55,18},{-55,17.5},{-58.55,17.5}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(tempSensor_children1.T, PI_children1.u_m) annotation (Line(
                points={{16,42},{34,42},{34,44}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(PI_children1.y, gainRad_children1.u) annotation (Line(
                points={{45,56},{50,56},{50,47.5},{55.1,47.5}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(PI_children1.y, gainConv_children1.u) annotation (Line(
                points={{45,56},{50,56},{50,64.5},{54.1,64.5}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(gainRad_children1.y, SourceRad_children1.Q_flow) annotation (Line(
                points={{65.45,47.5},{69,47.5},{69,47},{71,47}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(SourceConv_children1.Q_flow, gainConv_children1.y) annotation (Line(
                points={{70,65},{68,65},{68,64.5},{64.45,64.5}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(tempSensor_bath.T, PI_bath.u_m) annotation (Line(
                points={{29,-58},{47,-58},{47,-56}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(PI_bath.y, gainRad_bath.u) annotation (Line(
                points={{58,-44},{63,-44},{63,-52.5},{68.1,-52.5}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(PI_bath.y, gainConv_bath.u) annotation (Line(
                points={{58,-44},{63,-44},{63,-35.5},{67.1,-35.5}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(gainRad_bath.y, SourceRad_bath.Q_flow) annotation (Line(
                points={{78.45,-52.5},{82,-52.5},{82,-53},{84,-53}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(SourceConv_bath.Q_flow, gainConv_bath.y) annotation (Line(
                points={{83,-35},{81,-35},{81,-35.5},{77.45,-35.5}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(tempSensor_children2.T, PI_children2.u_m) annotation (Line(
                points={{-111,-63},{-93,-63},{-93,-61}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(PI_children2.y, gainRad_children2.u) annotation (Line(
                points={{-82,-49},{-77,-49},{-77,-57.5},{-71.9,-57.5}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(PI_children2.y, gainConv_children2.u) annotation (Line(
                points={{-82,-49},{-77,-49},{-77,-40.5},{-72.9,-40.5}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(gainRad_children2.y, SourceRad_children2.Q_flow) annotation (Line(
                points={{-61.55,-57.5},{-58,-57.5},{-58,-58},{-56,-58}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(SourceConv_children2.Q_flow, gainConv_children2.y) annotation (Line(
                points={{-57,-40},{-59,-40},{-59,-40.5},{-62.55,-40.5}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(Con_Bedroom, tempSensor_bedroom.port) annotation (Line(
                points={{-140,59},{-129,59},{-129,-5},{-119,-5}},
                color={191,0,0},
                smooth=Smooth.None));
            connect(tempSensor_children1.port, Con_Chidlren1) annotation (Line(
                points={{4,42},{0,42},{0,30},{139,30},{139,50}},
                color={191,0,0},
                smooth=Smooth.None));
            connect(tempSensor_bath.port, Con_Bath) annotation (Line(
                points={{17,-58},{1,-58},{1,-68},{139,-68}},
                color={191,0,0},
                smooth=Smooth.None));
            connect(tempSensor_children2.port, Con_Children2) annotation (Line(
                points={{-123,-63},{-129,-63},{-129,-51},{-141,-51}},
                color={191,0,0},
                smooth=Smooth.None));
            connect(SourceRad_children2.port, Rad_Children2) annotation (Line(
                points={{-36,-58},{-23,-58},{-23,-15},{-139,-15}},
                color={191,0,0},
                smooth=Smooth.None));
            connect(SourceConv_children2.port, Con_Children2) annotation (Line(
                points={{-37,-40},{-23,-40},{-23,-71},{-129,-71},{-129,-51},{-141,-51}},
                color={191,0,0},
                smooth=Smooth.None));
            connect(SourceConv_children1.port, Con_Chidlren1) annotation (Line(
                points={{90,65},{139,65},{139,50}},
                color={191,0,0},
                smooth=Smooth.None));
            connect(SourceRad_children1.port, Rad_Children1) annotation (Line(
                points={{91,47},{137,47},{137,73}},
                color={191,0,0},
                smooth=Smooth.None));
            connect(SourceConv_bath.port, Con_Bath) annotation (Line(
                points={{103,-35},{111,-35},{111,-36},{139,-36},{139,-68}},
                color={191,0,0},
                smooth=Smooth.None));
            connect(SourceRad_bath.port, Rad_Bath) annotation (Line(
                points={{104,-53},{118,-53},{118,-55},{140,-55},{140,-40}},
                color={191,0,0},
                smooth=Smooth.None));
            connect(PI_bedroom.u_s, TSet_UF[1]) annotation (Line(
                points={{-101,9},{-129,9},{-129,85.75},{-71,85.75}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(PI_children1.u_s, TSet_UF[2]) annotation (Line(
                points={{22,56},{0,56},{0,93.25},{-71,93.25}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(PI_bath.u_s, TSet_UF[3]) annotation (Line(
                points={{35,-44},{0,-44},{0,100.75},{-71,100.75}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(PI_children2.u_s, TSet_UF[4]) annotation (Line(
                points={{-105,-49},{-129,-49},{-129,108.25},{-71,108.25}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(SourceConv_bedroom.port, Con_Bedroom) annotation (Line(
                points={{-33,18},{-22,18},{-22,43},{-140,43},{-140,59}},
                color={191,0,0},
                smooth=Smooth.None));
            connect(SourceRad_bedroom.port, Rad_Bedroom) annotation (Line(
                points={{-32,0},{-22,0},{-22,43},{-139,43},{-139,90}},
                color={191,0,0},
                smooth=Smooth.None));
                                                                                                                annotation (Dialog(group = "Radiators", descriptionLabel = true),
                                                                                                Dialog(group = "Valves", descriptionLabel = true),
                       __Dymola_Images(Parameters(source="AixLib/Images/House/UpperFloor_Hydraulics.png")),
                        Diagram(coordinateSystem(
                  preserveAspectRatio=false,
                  extent={{-130,-100},{130,100}},
                  grid={1,1}), graphics={
                  Rectangle(
                    extent={{0,73},{127,30}},
                    pattern=LinePattern.None,
                    lineColor={0,0,0},
                    fillColor={215,215,215},
                    fillPattern=FillPattern.Solid),
                  Rectangle(
                    extent={{0,-14},{129,-71}},
                    pattern=LinePattern.None,
                    lineColor={0,0,0},
                    fillColor={215,215,215},
                    fillPattern=FillPattern.Solid),
                  Rectangle(
                    extent={{-129,43},{-22,-11}},
                    pattern=LinePattern.None,
                    lineColor={0,0,0},
                    fillColor={215,215,215},
                    fillPattern=FillPattern.Solid),
                  Rectangle(
                    extent={{-130,-16},{-23,-70}},
                    pattern=LinePattern.None,
                    lineColor={0,0,0},
                    fillColor={215,215,215},
                    fillPattern=FillPattern.Solid),
                  Text(
                    extent={{-129,-17},{-78,-31}},
                    lineColor={0,0,0},
                    fillColor={0,0,0},
                    fillPattern=FillPattern.Solid,
                    textString="Children2"),
                  Text(
                    extent={{-155,38},{-48,25}},
                    lineColor={0,0,0},
                    fillColor={0,0,0},
                    fillPattern=FillPattern.Solid,
                    textString="Bedroom"),
                  Text(
                    extent={{31,-15},{138,-28}},
                    lineColor={0,0,0},
                    fillColor={0,0,0},
                    fillPattern=FillPattern.Solid,
                    textString="Bath"),
                  Text(
                    extent={{52,41},{159,28}},
                    lineColor={0,0,0},
                    fillColor={0,0,0},
                    fillPattern=FillPattern.Solid,
                    textString="Children1"),
                  Text(
                    extent={{-53,95},{-11,72}},
                    lineColor={0,0,0},
                    textString="1 - Bedroom
2- Children1
3 - Bath
4 - Children2")}),                        Icon(coordinateSystem(
                  preserveAspectRatio=true,
                  extent={{-130,-100},{130,100}},
                  grid={1,1}), graphics={
                  Rectangle(
                    extent={{-122,91},{120,-80}},
                    lineColor={255,0,0},
                    fillColor={135,135,135},
                    fillPattern=FillPattern.Solid),
                  Line(
                    points={{-17,22},{-17,44}},
                    color={255,0,0},
                    thickness=1,
                    smooth=Smooth.None),
                  Line(
                    points={{-102,21},{101,21},{101,-7}},
                    color={255,0,0},
                    smooth=Smooth.None,
                    thickness=1),
                  Line(
                    points={{-101,12},{92,12},{92,-7}},
                    color={0,0,255},
                    smooth=Smooth.None,
                    thickness=1),
                  Line(
                    points={{-24,12},{-24,34}},
                    color={0,0,255},
                    thickness=1,
                    smooth=Smooth.None),
                  Text(
                    extent={{-79,66},{-37,43}},
                    lineColor={0,0,0},
                    textString="1 - Bedroom
2- Children1
3 - Bath
4 - Children2")}),
              Documentation(revisions="<html>
<p><ul>
<li><i>June 19, 2014</i> by Ana Constantin:<br/>Implemented</li>
</ul></p>
</html>",       info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Model for the upper floor.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
</html>"));
          end UpperFloor;
          annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p><br>Package for models with ideal heaters</p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The model is only an example on how an energy system is built and what connectors it need to connect to the building&apos;s envelope. </p>
</html>"));
        end IdealHeaters;

        annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Package for energy systems for the one family dwelling.</p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The package includes an energy systems based on ideal heaters. It should  serve as an example of how such a model can be built.</p>
</html>"));
      end EnergySystem;

      package BuildingAndEnergySystem
                  extends Modelica.Icons.Package;

        model OFD_IdealHeaters
            parameter Real ratioRadHeat=0.3
            "ratio of radiative heat from total heat generated";
             parameter Integer TMC =  1 "Themal Mass Class"
            annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice=1 "S", choice = 2 "M", choice = 3 "L", radioButtons = true));

          parameter Integer TIR = 1 "Thermal Insulation Regulation"
           annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice=1
                "EnEV_2009",                                                                                                    choice = 2
                "EnEV_2002",                                                                                                    choice = 3
                "WSchV_1995",  choice = 4 "WSchV_1984",                                                                          radioButtons = true));

          parameter Real AirExchangeCorridor = 2
            "Air exchange corridors in 1/h "                                      annotation(Dialog(group = "Air Exchange Corridors", descriptionLabel = true));
          parameter Real AirExchangeAttic = 0 "Air exchange attic in 1/h " annotation(Dialog(group = "Air Exchange Attic", descriptionLabel = true));

                // Dynamic Ventilation
          parameter Boolean withDynamicVentilation = true "Dynamic ventilation"
                                                                                annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true), choices(checkBox=true));
          parameter Modelica.SIunits.Temperature HeatingLimit = 253.15
            "Outside temperature at which the heating activates" annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true,  enable = if withDynamicVentilation then true else false));
          parameter Real Max_VR = 200 "Maximal ventilation rate" annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true,  enable = if withDynamicVentilation then true else false));
          parameter Modelica.SIunits.TemperatureDifference Diff_toTempset = 3
            "Difference to set temperature" annotation (Dialog(group = "Dynamic ventilation", descriptionLabel = true,  enable = if withDynamicVentilation then true else false));

          BuildingEnvelope.GroundFloorBuildingEnvelope
            GF(
            TMC=TMC,
            TIR=TIR,
            withDynamicVentilation=withDynamicVentilation,
            HeatingLimit=HeatingLimit,
            Max_VR=Max_VR,
            Diff_toTempset=Diff_toTempset,
            withFloorHeating=false)
            annotation (Placement(transformation(extent={{-26,-94},{22,-42}})));
          BuildingEnvelope.UpperFloorBuildingEnvelope UF(
            TMC=TMC,
            TIR=TIR,
            withDynamicVentilation=withDynamicVentilation,
            HeatingLimit=HeatingLimit,
            Max_VR=Max_VR,
            Diff_toTempset=Diff_toTempset,
            withFloorHeating=false)
            annotation (Placement(transformation(extent={{-26,-24},{20,28}})));
          Rooms.OFD.Attic_Ro2Lf5                          Attic(
            length=10.64,
            room1_length=5.875,
            room2_length=3.215,
            room3_length=3.92,
            room4_length=3.215,
            room5_length=4.62,
            roof_width1=3.36,
            roof_width2=3.36,
            solar_absorptance_RO=0.1,
            width=4.75,
            room1_width=2.28,
            room2_width=2.28,
            room3_width=2.28,
            room4_width=2.28,
            room5_width=2.28,
            alfa=1.5707963267949)
            annotation (Placement(transformation(extent={{-26,46},{20,86}})));
          Modelica.Blocks.Interfaces.RealInput WindSpeedPort
            annotation (Placement(transformation(extent={{-20,-20},{20,20}},
                rotation=270,
                origin={-74,120}),
                iconTransformation(extent={{-14,-14},{14,14}},
                rotation=270,
                origin={-68,114})));
          Utilities.Interfaces.SolarRad_in SolarRadiationPort[6]
            "[1:6]=[N, E, S, W, RoofN, RoofS]" annotation (Placement(
                transformation(
                extent={{-10,10},{10,-10}},
                rotation=180,
                origin={190,90})));
          Modelica.Blocks.Interfaces.RealInput NaturalVentilation_UF[4] annotation (
              Placement(transformation(extent={{-118,42},{-86,74}}), iconTransformation(
                  extent={{-118,42},{-86,74}})));
          Modelica.Blocks.Interfaces.RealInput NaturalVentilation_GF[4] annotation (
              Placement(transformation(extent={{-116,-2},{-84,30}}), iconTransformation(
                  extent={{-116,-2},{-84,30}})));
          Modelica.Blocks.Interfaces.RealInput TSet_UF[4] annotation (Placement(
                transformation(extent={{-118,-52},{-84,-18}}), iconTransformation(
                  extent={{-118,-52},{-84,-18}})));
          Modelica.Blocks.Interfaces.RealInput TSet_GF[5] annotation (Placement(
                transformation(extent={{-118,-100},{-82,-64}}), iconTransformation(
                  extent={{-118,-100},{-82,-64}})));
          Modelica.Blocks.Sources.Constant AirExchangeCorridor_Source(k=
                AirExchangeCorridor)
            annotation (Placement(transformation(extent={{20,-34},{24,-30}})));
          AixLib.Building.Components.DryAir.VarAirExchange varAirExchange(V=UF.Corridor.airload.V)
            annotation (Placement(transformation(
                extent={{-6,-6},{6,6}},
                rotation=270,
                origin={34,-32})));
          EnergySystem.IdealHeaters.GroundFloor GF_Hydraulic(ratioRadHeat=
                ratioRadHeat)
            annotation (Placement(transformation(extent={{86,-84},{128,-52}})));

          EnergySystem.IdealHeaters.UpperFloor UF_Hydraulic(ratioRadHeat=
                ratioRadHeat)
            annotation (Placement(transformation(extent={{88,-10},{132,24}})));

          Modelica.Blocks.Sources.Constant AirExchangeAttic_Source(k=
                AirExchangeAttic) "Storage"                         annotation (
             Placement(transformation(extent={{-96,80},{-80,96}}),
                iconTransformation(extent={{-122,-72},{-100,-50}})));
          Modelica.Blocks.Interfaces.RealInput Air_Temp annotation (Placement(
                transformation(
                extent={{-20,-20},{20,20}},
                rotation=-90,
                origin={120,116}), iconTransformation(
                extent={{-14,-14},{14,14}},
                rotation=-90,
                origin={120,114})));
        public
          Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature tempOutside
            annotation (Placement(transformation(extent={{138.5,62},{158,80}})));
        equation

          connect(GF.thermCeiling_Livingroom, UF.thermFloor_Bedroom)
            annotation (Line(
              points={{-24.08,-39.66},{-24.08,-32.83},{-23.7,-32.83},{-23.7,
                  -26.6}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(GF.thermCeiling_Hobby, UF.thermFloor_Children1)
            annotation (Line(
              points={{-13.76,-39.66},{-13.76,-32.83},{-14.5,-32.83},{-14.5,
                  -26.6}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(GF.thermCeiling_Kitchen, UF.thermFloor_Children2)
            annotation (Line(
              points={{15.04,-39.66},{15.04,-32.83},{13.1,-32.83},{13.1,-26.6}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(UF.thermCeiling_Bedroom, Attic.thermRoom1)
            annotation (Line(
              points={{-23.7,30.34},{-23.7,48}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(UF.thermCeiling_Children1, Attic.thermRoom2)
            annotation (Line(
              points={{-14.27,30.34},{-14.27,40.17},{-14.5,40.17},{-14.5,48}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(UF.thermCeiling_Corridor, Attic.thermRoom3)
            annotation (Line(
              points={{-5.53,30.34},{-5.53,40.17},{-5.3,40.17},{-5.3,48}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(UF.thermCeiling_Bath, Attic.thermRoom4)
            annotation (Line(
              points={{3.67,30.34},{3.67,40.17},{3.9,40.17},{3.9,48}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(UF.thermCeiling_Children2, Attic.thermRoom5)
            annotation (Line(
              points={{12.87,30.34},{12.87,39.17},{13.1,39.17},{13.1,48}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Attic.WindSpeedPort, WindSpeedPort)            annotation (Line(
              points={{-25.885,66},{-74,66},{-74,120}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(UF.WindSpeedPort, WindSpeedPort)                  annotation (Line(
              points={{-29.45,8.5},{-29.45,12},{-74,12},{-74,120}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(GF.WindSpeedPort, WindSpeedPort)                   annotation (Line(
              points={{-29.6,-60.98},{-74,-60.98},{-74,120}},
              color={0,0,127},
              smooth=Smooth.None));

          connect(AirExchangeCorridor_Source.y,varAirExchange. InPort1) annotation (
              Line(
              points={{24.2,-32},{26,-32},{26,-24},{30.16,-24},{30.16,-26.6}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(UF.thermCorridor,varAirExchange.port_a)  annotation (Line(
              points={{22.3,-26.6},{34,-26.6},{34,-26}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(GF.thermCorridor,varAirExchange.port_b)  annotation (Line(
              points={{24.4,-39.4},{34,-39.4},{34,-38}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(UF.StarBedroom, UF_Hydraulic.Rad_Bedroom)         annotation (
              Line(
              points={{-7.6,12.4},{-2,12.4},{-2,4},{74,4},{74,22.3},{86.4769,
                  22.3}},
              color={95,95,95},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          connect(UF.StarChildren1, UF_Hydraulic.Rad_Children1)         annotation (
             Line(
              points={{1.6,12.4},{-2,12.4},{-2,4},{74,4},{74,30},{146,30},{146,
                  20},{136,20},{136,19.41},{133.185,19.41}},
              color={95,95,95},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          connect(GF.StarLivingroom, GF_Hydraulic.Rad_Livingroom)
            annotation (Line(
              points={{-6.8,-57.6},{-6.8,-68},{76,-68},{76,-53.2},{84.8692,
                  -53.2}},
              color={95,95,95},
              pattern=LinePattern.None,
              smooth=Smooth.None));

          connect(GF.StarHobby, GF_Hydraulic.Rad_Hobby)          annotation (Line(
              points={{2.8,-57.6},{2.8,-62},{0,-62},{0,-68},{76,-68},{76,-46},{
                  140,-46},{140,-52.16},{129.131,-52.16}},
              color={95,95,95},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          connect(GF.StarCorridor, GF_Hydraulic.Rad_Corridor)          annotation (
              Line(
              points={{-2,-73.2},{0,-73.2},{0,-68},{76,-68},{76,-46},{140,-46},
                  {140,-60.96},{129.292,-60.96}},
              color={95,95,95},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          connect(GF.StarWC_Storage, GF_Hydraulic.Rad_WC)          annotation (Line(
              points={{2.8,-83.6},{0,-83.6},{0,-68},{76,-68},{76,-46},{140,-46},
                  {140,-70.56},{129.454,-70.56}},
              color={95,95,95},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          connect(GF.StarKitchen, GF_Hydraulic.Rad_Kitchen)          annotation (
              Line(
              points={{-6.8,-83.6},{0,-83.6},{0,-68},{76,-68},{76,-72.8},{
                  84.7885,-72.8}},
              color={95,95,95},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          connect(UF.ThermBedroom, UF_Hydraulic.Con_Bedroom)         annotation (
              Line(
              points={{-7.6,17.6},{-2,17.6},{-2,4},{74,4},{74,17.03},{86.3077,
                  17.03}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(UF.ThermChildren1, UF_Hydraulic.Con_Chidlren1)
            annotation (Line(
              points={{1.6,17.6},{-2,17.6},{-2,4},{74,4},{74,30},{146,30},{146,
                  15.5},{133.523,15.5}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(UF.ThermChildren2, UF_Hydraulic.Con_Children2)
            annotation (Line(
              points={{-7.6,-8.4},{-2,-8.4},{-2,4},{74,4},{74,-1.67},{86.1385,
                  -1.67}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(UF.ThermBath, UF_Hydraulic.Con_Bath)         annotation (Line(
              points={{1.6,-8.4},{-2,-8.4},{-2,4},{74,4},{74,30},{146,30},{146,
                  -4.56},{133.523,-4.56}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(UF.StarBath, UF_Hydraulic.Rad_Bath)         annotation (Line(
              points={{1.6,-13.6},{-2,-13.6},{-2,4},{74,4},{74,30},{146,30},{
                  146,0.2},{133.692,0.2}},
              color={95,95,95},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          connect(GF.ThermLivingroom, GF_Hydraulic.Con_Livingroom)
            annotation (Line(
              points={{-7.04,-52.14},{-7.04,-68},{76,-68},{76,-56.72},{84.95,-56.72}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(GF.ThermHobby, GF_Hydraulic.Con_Hobby)          annotation (Line(
              points={{2.8,-52.4},{2.8,-58},{0,-58},{0,-68},{76,-68},{76,-46},{
                  140,-46},{140,-56.32},{129.292,-56.32}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(GF.ThermKitchen, GF_Hydraulic.Con_Kitchen)          annotation (
              Line(
              points={{-6.8,-78.4},{54,-78.4},{54,-80},{76,-80},{76,-78},{82,
                  -78},{82,-77.36},{84.7077,-77.36}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(GF.ThermCorridor, GF_Hydraulic.Con_Corridor)          annotation (
             Line(
              points={{-2,-68},{76,-68},{76,-46},{140,-46},{140,-65.52},{
                  129.212,-65.52}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(GF.ThermWC_Storage, GF_Hydraulic.Con_Storage)
            annotation (Line(
              points={{2.8,-78.4},{0,-78.4},{0,-68},{76,-68},{76,-46},{140,-46},
                  {140,-74.72},{129.696,-74.72}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(UF_Hydraulic.Rad_Children2, UF.StarChildren2)         annotation (
             Line(
              points={{86.4769,4.45},{74,4.45},{74,4},{-2,4},{-2,-13.6},{-7.6,
                  -13.6}},
              color={95,95,95},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          connect(GF.thermCeiling_Corridor, UF.thermFloor_Corridor) annotation (Line(
              points={{-4.64,-39.66},{-4.64,-32.83},{-5.3,-32.83},{-5.3,-26.6}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(GF.thermCeiling_WCStorage, UF.thermFloor_Bath) annotation (Line(
              points={{4.96,-39.66},{4.96,-33.83},{3.9,-33.83},{3.9,-26.6}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(TSet_UF, UF_Hydraulic.TSet_UF) annotation (Line(
              points={{-101,-35},{-74,-35},{-74,90},{98,90},{98,24.17},{98.6615,
                  24.17}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(TSet_GF, GF_Hydraulic.TSet_GF) annotation (Line(
              points={{-100,-82},{-74,-82},{-74,90},{74,90},{74,-46},{95.9346,
                  -46},{95.9346,-51.52}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(UF.AirExchangePort, NaturalVentilation_UF) annotation (Line(
              points={{-29.45,-0.86},{-74,-0.86},{-74,58},{-102,58}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(GF.AirExchangePort, NaturalVentilation_GF) annotation (Line(
              points={{-29.6,-68.78},{-74,-68.78},{-74,14},{-100,14}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(Attic.AirExchangePort, AirExchangeAttic_Source.y)
                                                                  annotation (Line(
              points={{-26,74},{-74,74},{-74,88},{-79.2,88}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(UF.North, SolarRadiationPort[1]) annotation (Line(
              points={{22.3,3.56},{36,3.56},{36,-22},{172,-22},{172,81.6667},{
                  190,81.6667}},
              color={255,128,0},
              smooth=Smooth.None));
          connect(UF.RoofS, SolarRadiationPort[6]) annotation (Line(
              points={{22.3,13.44},{36,13.44},{36,-22},{172,-22},{172,98.3333},
                  {190,98.3333}},
              color={255,128,0},
              smooth=Smooth.None));
          connect(UF.RoofN, SolarRadiationPort[5]) annotation (Line(
              points={{22.3,21.76},{36,21.76},{36,-22},{172,-22},{172,95},{190,
                  95}},
              color={255,128,0},
              smooth=Smooth.None));

          connect(UF.East, SolarRadiationPort[2]) annotation (Line(
              points={{22.3,-4.24},{36,-4.24},{36,-22},{172,-22},{172,85},{190,
                  85}},
              color={255,128,0},
              smooth=Smooth.None));

          connect(UF.South, SolarRadiationPort[3]) annotation (Line(
              points={{22.3,-12.04},{36,-12.04},{36,-22},{172,-22},{172,88.3333},
                  {190,88.3333}},
              color={255,128,0},
              smooth=Smooth.None));
          connect(UF.West, SolarRadiationPort[4]) annotation (Line(
              points={{22.3,-19.84},{36,-19.84},{36,-22},{172,-22},{172,91.6667},
                  {190,91.6667}},
              color={255,128,0},
              smooth=Smooth.None));
          connect(GF.North, SolarRadiationPort[1]) annotation (Line(
              points={{24.4,-45.12},{46,-45.12},{46,-22},{172,-22},{172,81.6667},
                  {190,81.6667}},
              color={255,128,0},
              smooth=Smooth.None));
          connect(GF.East, SolarRadiationPort[2]) annotation (Line(
              points={{24.4,-52.4},{46,-52.4},{46,-22},{172,-22},{172,85},{190,
                  85}},
              color={255,128,0},
              smooth=Smooth.None));

          connect(GF.South, SolarRadiationPort[3]) annotation (Line(
              points={{24.4,-61.24},{46,-61.24},{46,-22},{172,-22},{172,88.3333},
                  {190,88.3333}},
              color={255,128,0},
              smooth=Smooth.None));
          connect(GF.West, SolarRadiationPort[4]) annotation (Line(
              points={{24.4,-72.16},{46,-72.16},{46,-22},{172,-22},{172,91.6667},
                  {190,91.6667}},
              color={255,128,0},
              smooth=Smooth.None));

          connect(tempOutside.port, GF.thermOutside) annotation (Line(
              points={{158,71},{98,71},{98,90},{-74,90},{-74,-48.76},{-27.92,-48.76}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(tempOutside.T, Air_Temp) annotation (Line(
              points={{136.55,71},{120,71},{120,116}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(UF.thermOutside, tempOutside.port) annotation (Line(
              points={{-27.84,21.24},{-74,21.24},{-74,90},{98,90},{98,71},{158,
                  71}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Attic.thermOutside, tempOutside.port) annotation (Line(
              points={{-23.7,84},{-24,84},{-24,90},{98,90},{98,71},{158,71}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Attic.SolarRadiationPort_RO1, SolarRadiationPort[6]) annotation (
              Line(
              points={{-14.5,84},{-16,84},{-16,90},{74,90},{74,-22},{172,-22},{
                  172,98.3333},{190,98.3333}},
              color={255,128,0},
              smooth=Smooth.None));
          connect(Attic.SolarRadiationPort_RO2, SolarRadiationPort[5]) annotation (
              Line(
              points={{8.5,84},{8,84},{8,90},{74,90},{74,-22},{172,-22},{172,95},
                  {190,95}},
              color={255,128,0},
              smooth=Smooth.None));
          connect(Attic.SolarRadiationPort_OW1, SolarRadiationPort[4]) annotation (
              Line(
              points={{-27.38,62},{-44,62},{-44,90},{74,90},{74,-22},{172,-22},
                  {172,91.6667},{190,91.6667}},
              color={255,128,0},
              smooth=Smooth.None));
          connect(Attic.SolarRadiationPort_OW2, SolarRadiationPort[2]) annotation (
              Line(
              points={{22.3,62.4},{36,62.4},{36,90},{74,90},{74,-20},{172,-20},
                  {172,85},{190,85}},
              color={255,128,0},
              smooth=Smooth.None));
          annotation (__Dymola_Images(Parameters(source="AixLib/Images/House/Hydraulik.png")), Icon(
                coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{200,
                    100}}),
                graphics={Bitmap(extent={{-76,122},{172,-124}}, fileName=
                      "modelica://AixLib/Images/House/Hydraulik.png")}),
                      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                    -100},{200,100}}),
                              graphics={
                Text(
                  extent={{-160,84},{-110,82}},
                  lineColor={0,0,255},
                  textString="1-Bedroom"),
                Text(
                  extent={{-160,78},{-110,76}},
                  lineColor={0,0,255},
                  textString="2-Children1"),
                Text(
                  extent={{-160,72},{-110,70}},
                  lineColor={0,0,255},
                  textString="3-Bath"),
                Text(
                  extent={{-160,66},{-110,64}},
                  lineColor={0,0,255},
                  textString="4-Children2"),
                Text(
                  extent={{-164,-4},{-114,-6}},
                  lineColor={0,0,255},
                  textString="1-Bedroom"),
                Text(
                  extent={{-164,-10},{-114,-12}},
                  lineColor={0,0,255},
                  textString="2-Children1"),
                Text(
                  extent={{-164,-16},{-114,-18}},
                  lineColor={0,0,255},
                  textString="3-Bath"),
                Text(
                  extent={{-164,-22},{-114,-24}},
                  lineColor={0,0,255},
                  textString="4-Children2"),
                Text(
                  extent={{-164,-48},{-114,-50}},
                  lineColor={0,0,255},
                  textString="1-Livingroom"),
                Text(
                  extent={{-164,-54},{-114,-56}},
                  lineColor={0,0,255},
                  textString="2-Hobby"),
                Text(
                  extent={{-164,-60},{-114,-62}},
                  lineColor={0,0,255},
                  textString="3-Corridor"),
                Text(
                  extent={{-164,-66},{-114,-68}},
                  lineColor={0,0,255},
                  textString="4-WC"),
                Text(
                  extent={{-164,-72},{-114,-74}},
                  lineColor={0,0,255},
                  textString="5-Kitchen"),
                Text(
                  extent={{-162,42},{-112,40}},
                  lineColor={0,0,255},
                  textString="1-Livingroom"),
                Text(
                  extent={{-162,36},{-112,34}},
                  lineColor={0,0,255},
                  textString="2-Hobby"),
                Text(
                  extent={{-162,30},{-112,28}},
                  lineColor={0,0,255},
                  textString="3-WC"),
                Text(
                  extent={{-162,24},{-112,22}},
                  lineColor={0,0,255},
                  textString="4-Kitchen")}),
            Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Model for a complete model with building envelope and an energy system based on ideal heaters.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
</html>",       revisions="<html>
<p><ul>
<li><i>June 19, 2014</i> by Ana Constantin:<br/>Implemented</li>
</ul></p>
</html>"));
        end OFD_IdealHeaters;

        annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Package with complete models with building envelopes and energy systems.</p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>Three models are available:</p>
<ul>
<li>with an energy system based on radiators</li>
<li>with an energy system based on radiators and the possibility of inputing variable convective internal gains for each room </li>
<li>with an energy system based on floor heating</li>
</ul>
</html>"));
      end BuildingAndEnergySystem;
    annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Package with set-up models for a one family dwelling.</p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The room models are connected together. The name OFD_MiddleInnerLoadWall denotes the fact that the standard house has a middle load bearing wall. Other positions of the load bearing inner wall are possible, but not included in the library. Walls are connected together and they form a room. Multiple rooms are connected together and they form a storey for the one family dwelling.</p>
<p>The living area over both storeys is 150 m2.</p>
<p>The following figure shows the floor layout for the ground and upper floor. For simplification the toilet and the storage room are aggregated to one room. The side view shows the saddle roof.</p>
<p><img src=\"modelica://AixLib/Images/House/OFD_FloorPlan_En.PNG\"/></p>
<p><img src=\"modelica://AixLib/Images/House/OFD_SideView_En.PNG\"/></p>
</html>"));
    end OFD_MiddleInnerLoadWall;

    package MFD "Multiple Family Dwelling"
                extends Modelica.Icons.Package;

      package Building
                  extends Modelica.Icons.Package;

        model OneAppartment_VoWo
            parameter Integer TMC =  1 "Themal Mass Class"
            annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice=1 "S", choice = 2 "M", choice = 3 "L", radioButtons = true));
          parameter Integer TIR = 4 "Thermal Insulation Regulation"
           annotation(Dialog(group = "Construction parameters", compact = true, descriptionLabel = true), choices(choice=1
                "EnEV_2009",                                                                                                    choice = 2
                "EnEV_2002",                                                                                                    choice = 3
                "WSchV_1995",  choice = 4 "WSchV_1984",                                                                          radioButtons = true));

          parameter Integer Floor =  1 "Floor"
            annotation(Dialog(group = "Floor", compact = true, descriptionLabel = true), choices(choice=1 "GF", choice = 2 "1F", choice = 3 "2F", radioButtons = true));

          Rooms.MFD.OneApparment.Livingroom_VoWo     Livingroom(
            TMC=TMC,
            TIR=TIR,
            Floor=Floor)
            annotation (Placement(transformation(extent={{-68,26},{-16,78}})));
          Rooms.MFD.OneApparment.Children_VoWo     Children(
            TMC=TMC,
            TIR=TIR,
            Floor=Floor)
            annotation (Placement(transformation(extent={{36,38},{74,76}})));
          Rooms.MFD.OneApparment.Corridor_VoWo     Corridor(
            TMC=TMC,
            TIR=TIR,
            Floor=Floor)
            annotation (Placement(transformation(extent={{22,-12},{60,26}})));
          Rooms.MFD.OneApparment.Bedroom_VoWo     Bedroom(
            TMC=TMC,
            TIR=TIR,
            Floor=Floor)
            annotation (Placement(transformation(extent={{-64,-74},{-20,-30}})));
          Rooms.MFD.OneApparment.Bathroom_VoWo     Bathroom(
            TMC=TMC,
            TIR=TIR,
            Floor=Floor)
            annotation (Placement(transformation(extent={{-6,-72},{32,-34}})));
          Rooms.MFD.OneApparment.Kitchen_VoWo     Kitchen(
            TMC=TMC,
            TIR=TIR,
            Floor=Floor)
            annotation (Placement(transformation(extent={{46,-74},{88,-28}})));
          Utilities.Interfaces.SolarRad_in SolarRadiation_SE annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={28,110})));
          Utilities.Interfaces.SolarRad_in SolarRadiation_NW annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={58,110})));
          Modelica.Blocks.Interfaces.RealInput AirExchangePort[5]
            annotation (Placement(transformation(extent={{-15,-15},{15,15}},
                rotation=270,
                origin={-9,115}),
                iconTransformation(extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-4,110})));
          Modelica.Blocks.Interfaces.RealInput WindSpeedPort annotation (
              Placement(transformation(
                extent={{-13,-13},{13,13}},
                rotation=270,
                origin={-41,113}), iconTransformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-38,110})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermOutside
            annotation (Placement(transformation(extent={{-82,100},{-62,120}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
            thermNeighbour_Livingroom
            annotation (Placement(transformation(extent={{-120,80},{-100,100}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermNeigbour_Bedroom
            annotation (Placement(transformation(extent={{-120,56},{-100,76}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermNeighbour_Child
            annotation (Placement(transformation(extent={{100,80},{120,100}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermStaircase
            annotation (Placement(transformation(extent={{100,54},{120,74}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling_Livingroom
            annotation (Placement(transformation(extent={{-120,28},{-100,48}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor_Livingroom
            annotation (Placement(transformation(extent={{-120,4},{-100,24}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling_Bedroom
            annotation (Placement(transformation(extent={{-120,-22},{-100,-2}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor_Bedroom
            annotation (Placement(transformation(extent={{-120,-46},{-100,-26}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling_Bath
            annotation (Placement(transformation(extent={{-120,-72},{-100,-52}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor_Bath
            annotation (Placement(transformation(extent={{-120,-100},{-100,-80}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling_Children
            annotation (Placement(transformation(extent={{100,26},{120,46}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor_Children
            annotation (Placement(transformation(extent={{100,2},{120,22}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling_Corridor
            annotation (Placement(transformation(extent={{100,-22},{120,-2}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor_Corridor
            annotation (Placement(transformation(extent={{100,-46},{120,-26}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling_Kitchen
            annotation (Placement(transformation(extent={{100,-72},{120,-52}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor_Kitchen
            annotation (Placement(transformation(extent={{100,-96},{120,-76}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermLivingroom
            annotation (Placement(transformation(extent={{-60,12},{-44,28}}),
                iconTransformation(extent={{-56,14},{-44,28}})));
          Utilities.Interfaces.Star StarLivingroom annotation (Placement(
                transformation(extent={{-40,12},{-24,28}}),
                iconTransformation(extent={{-40,0},{-24,14}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermChildren
            annotation (Placement(transformation(extent={{40,24},{56,40}}),
                iconTransformation(extent={{40,24},{56,40}})));
          Utilities.Interfaces.Star StarChildren annotation (Placement(
                transformation(extent={{60,24},{76,40}}),
                iconTransformation(extent={{56,22},{76,42}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermBedroom
            annotation (Placement(transformation(extent={{-60,-20},{-44,-4}}),
                iconTransformation(extent={{-60,-20},{-44,-4}})));
          Utilities.Interfaces.Star StarBedroom annotation (Placement(
                transformation(extent={{-40,-20},{-24,-4}}),
                iconTransformation(extent={{-40,-20},{-24,-2}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermBath annotation (
              Placement(transformation(extent={{-20,-28},{-4,-12}}),
                iconTransformation(extent={{-20,-28},{-4,-12}})));
          Utilities.Interfaces.Star StarBath annotation (Placement(
                transformation(extent={{0,-28},{16,-12}}),
                iconTransformation(extent={{-2,-28},{16,-12}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermKitchen
            annotation (Placement(transformation(extent={{40,-22},{56,-6}}),
                iconTransformation(extent={{40,-20},{56,-4}})));
          Utilities.Interfaces.Star StarKitchen annotation (Placement(
                transformation(extent={{62,-22},{78,-6}}),
                iconTransformation(extent={{34,-44},{52,-26}})));
        equation
          connect(Bedroom.SolarRadiation_NW, SolarRadiation_NW) annotation (
              Line(
              points={{-56.96,-74},{-56,-74},{-56,-80},{-80,-80},{-80,90},{58,90},{58,
                  110}},
              color={255,128,0},
              smooth=Smooth.None));
          connect(Bathroom.SolarRadiation_NW, SolarRadiation_NW)  annotation (
              Line(
              points={{0.688,-72},{0,-72},{0,-80},{-80,-80},{-80,90},{58,90},{58,110}},
              color={255,128,0},
              smooth=Smooth.None));
          connect(Kitchen.SolarRadiation_NW, SolarRadiation_NW) annotation (
              Line(
              points={{59.44,-74},{56,-74},{56,-80},{80,-80},{80,90},{58,90},{58,110}},
              color={255,128,0},
              smooth=Smooth.None));
          connect(Children.WindSpeedPort, WindSpeedPort) annotation (Line(
              points={{36,66.88},{20,66.88},{20,90},{-41,90},{-41,113}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(Livingroom.WindSpeedPort, WindSpeedPort) annotation (Line(
              points={{-64.9412,58.9333},{-80,58.9333},{-80,90},{-41,90},{-41,
                  113}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(Bedroom.WindSpeedPort, WindSpeedPort) annotation (Line(
              points={{-64,-42.32},{-80,-42.32},{-80,90},{-41,90},{-41,113}},
              color={0,0,127},
              smooth=Smooth.None));

          connect(Bathroom.WindSpeedPort, WindSpeedPort)  annotation (Line(
              points={{-6.304,-46.16},{-18,-46.16},{-18,-80},{80,-80},{80,90},{-41,90},
                  {-41,113}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(Kitchen.WindSpeedPort, WindSpeedPort) annotation (Line(
              points={{46.168,-41.064},{36,-41.064},{36,-80},{80,-80},{80,90},{-41,90},
                  {-41,113}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(Livingroom.thermOutside, thermOutside) annotation (Line(
              points={{-64.9412,74.5333},{-80,74.5333},{-80,110},{-72,110}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Children.thermOutside, thermOutside) annotation (Line(
              points={{42.08,75.696},{20,75.696},{20,90},{-72,90},{-72,110}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Bedroom.thermOutside, thermOutside) annotation (Line(
              points={{-64,-31.76},{-80,-31.76},{-80,90},{-72,90},{-72,110}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Bathroom.thermOutside, thermOutside)  annotation (Line(
              points={{-6,-35.52},{-18,-35.52},{-18,-80},{-80,-80},{-80,90},{-72,90},
                  {-72,110}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Kitchen.thermOutside, thermOutside) annotation (Line(
              points={{46.336,-29.84},{42,-29.84},{42,-30},{36,-30},{36,-80},{-80,-80},
                  {-80,90},{-72,90},{-72,110}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Livingroom.thermNeighbour, thermNeighbour_Livingroom)
            annotation (Line(
              points={{-64.9412,53.7333},{-80,53.7333},{-80,90},{-110,90}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Bedroom.thermNeigbour, thermNeigbour_Bedroom) annotation (
              Line(
              points={{-64,-63.44},{-80,-63.44},{-80,66},{-110,66}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Children.thermNeighbour, thermNeighbour_Child) annotation (
              Line(
              points={{36,62.32},{20,62.32},{20,90},{110,90}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Children.thermStaircase, thermStaircase) annotation (Line(
              points={{36,57.76},{20,57.76},{20,90},{80,90},{80,64},{110,64}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Corridor.thermStaircase, thermStaircase) annotation (Line(
              points={{21.696,22.96},{18,22.96},{18,-20},{36,-20},{36,-80},{80,-80},{
                  80,64},{110,64}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Livingroom.thermBedroom, Bedroom.thermLivingroom) annotation (
             Line(
              points={{-64.9412,48.5333},{-80,48.5333},{-80,-47.6},{-64,-47.6}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Corridor.thermLivingroom, Livingroom.thermCorridor)
            annotation (Line(
              points={{21.696,13.84},{18,13.84},{18,-20},{36,-20},{36,-80},{-80,
                  -80},{-80,43.3333},{-64.9412,43.3333}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Livingroom.thermChildren, Children.thermLivingroom)
            annotation (Line(
              points={{-64.9412,38.1333},{-80,38.1333},{-80,90},{20,90},{20,
                  48.64},{36,48.64}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Livingroom.thermCeiling, thermCeiling_Livingroom) annotation (
             Line(
              points={{-64.9412,32.9333},{-80,32.9333},{-80,38},{-110,38}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Livingroom.thermFloor, thermFloor_Livingroom) annotation (
              Line(
              points={{-64.9412,27.7333},{-80,27.7333},{-80,14},{-110,14}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Bedroom.thermCorridor, Corridor.thermBedroom) annotation (
              Line(
              points={{-64,-52.88},{-80,-52.88},{-80,-80},{36,-80},{36,-20},{18,-20},
                  {18,0},{22,0},{22,0.16}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Bedroom.thermBath, Bathroom.thermBedroom)  annotation (Line(
              points={{-64,-58.16},{-80,-58.16},{-80,-80},{-18,-80},{-18,-59.84},{-6,
                  -59.84}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Bedroom.thermCeiling, thermCeiling_Bedroom) annotation (Line(
              points={{-64,-68.72},{-80,-68.72},{-80,-12},{-110,-12}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Bedroom.thermFloor, thermFloor_Bedroom) annotation (Line(
              points={{-64,-74},{-80,-74},{-80,-36},{-110,-36}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Bathroom.thermCorridor, Corridor.thermBath)  annotation (Line(
              points={{-6,-50.72},{-18,-50.72},{-18,-80},{36,-80},{36,-20},{18,-20},{
                  18,4},{22,4},{22,4.72}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Bathroom.thermKitchen, Kitchen.thermBath)  annotation (Line(
              points={{-6,-55.28},{-18,-55.28},{-18,-80},{36,-80},{36,-62.96},{46,
                  -62.96}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Kitchen.thermStaircase, thermStaircase) annotation (Line(
              points={{46,-55.6},{36,-55.6},{36,-80},{80,-80},{80,64},{110,64}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Bathroom.thermCeiling, thermCeiling_Bath)  annotation (Line(
              points={{-6,-64.4},{-18,-64.4},{-18,-80},{-80,-80},{-80,-62},{-110,-62}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Bathroom.thermFloor, thermFloor_Bath)  annotation (Line(
              points={{-6,-68.96},{-18,-68.96},{-18,-80},{-110,-80},{-110,-90}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Kitchen.thermCorridor, Corridor.thermKitchen) annotation (
              Line(
              points={{46,-48.24},{36,-48.24},{36,-20},{18,-20},{18,18.4},{21.696,
                  18.4}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Children.thermCorridor, Corridor.thermChild) annotation (Line(
              points={{36,53.2},{20,53.2},{20,90},{80,90},{80,-80},{36,-80},{36,-20},
                  {18,-20},{18,9.28},{21.696,9.28}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Children.thermCeiling, thermCeiling_Children) annotation (
              Line(
              points={{36,44.08},{20,44.08},{20,90},{80,90},{80,36},{110,36}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Children.thermFloor, thermFloor_Children) annotation (Line(
              points={{36,39.216},{20,39.216},{20,90},{80,90},{80,12},{110,12}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Kitchen.thermCeiling, thermCeiling_Kitchen) annotation (Line(
              points={{46,-70.32},{36,-70.32},{36,-80},{80,-80},{80,-62},{110,-62}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Kitchen.thermFloor, thermFloor_Kitchen) annotation (Line(
              points={{52.72,-74},{36,-74},{36,-80},{80,-80},{80,-86},{110,-86}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Livingroom.ThermRoom, thermLivingroom)
                                                    annotation (Line(
              points={{-42.3059,54.4267},{-42.3059,51.64},{-52,51.64},{-52,20}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Livingroom.StarInside1, StarLivingroom)
                                                       annotation (Line(
              points={{-38.0235,54.4267},{-38.0235,54},{-32,54},{-32,20}},
              color={95,95,95},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          connect(Children.StarRoom, StarChildren)
                                                annotation (Line(
              points={{53.632,61.408},{54,60},{72,60},{72,32},{68,32}},
              color={95,95,95},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          connect(Bedroom.StarRoom, StarBedroom)
                                               annotation (Line(
              points={{-41.472,-53.584},{-32,-53.584},{-32,-12}},
              color={95,95,95},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          connect(Bathroom.ThermRoom, ThermBath)   annotation (Line(
              points={{6.464,-55.584},{6.464,-30},{-12,-30},{-12,-20}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Bathroom.StarRoom, StarBath)   annotation (Line(
              points={{12.24,-55.888},{12.24,-44},{6,-44},{6,-30},{8,-30},{8,-20}},
              color={95,95,95},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          connect(Kitchen.StarRoom, StarKitchen)
                                               annotation (Line(
              points={{63.808,-53.392},{58,-53.392},{58,-14},{70,-14}},
              color={95,95,95},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          connect(ThermBath, ThermBath)   annotation (Line(
              points={{-12,-20},{-12,-20}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Livingroom.AirExchangePort, AirExchangePort[1]) annotation (Line(
              points={{-64.9412,65.8667},{-80,65.8667},{-80,90},{-9,90},{-9,127}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(Children.AirExchangePort, AirExchangePort[2]) annotation (Line(
              points={{36,71.44},{20,71.44},{20,90},{-9,90},{-9,121}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(Children.ThermRoom, ThermChildren) annotation (Line(
              points={{48.768,61.712},{46,61.712},{46,32},{48,32}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Bedroom.ThermRoom, ThermBedroom) annotation (Line(
              points={{-48.16,-53.936},{-52,-53.936},{-52,-40},{-48,-40},{-48,-30},{
                  -52,-30},{-52,-12}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Kitchen.AirExchangePort, AirExchangePort[3]) annotation (Line(
              points={{46.168,-35.176},{36,-35.176},{36,-80},{80,-80},{80,90},{-9,90},
                  {-9,115}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(Bathroom.AirExchangePort, AirExchangePort[4]) annotation (Line(
              points={{-6.304,-40.08},{-18,-40.08},{-18,-80},{80,-80},{80,90},{
                  -9,90},{-9,109}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(Bedroom.AirExchangePort, AirExchangePort[5]) annotation (Line(
              points={{-64,-37.04},{-80,-37.04},{-80,90},{-9,90},{-9,103}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(Corridor.thermFloor, thermFloor_Corridor) annotation (Line(
              points={{22,-8.96},{18,-8.96},{18,-20},{36,-20},{36,-80},{80,-80},{80,
                  -36},{110,-36}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Corridor.thermCeiling, thermCeiling_Corridor) annotation (Line(
              points={{22,-4.4},{18,-4.4},{18,-20},{36,-20},{36,-80},{80,-80},{80,-12},
                  {110,-12}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Kitchen.ThermRoom, ThermKitchen) annotation (Line(
              points={{64.144,-47.872},{58,-47.872},{58,-14},{48,-14}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Children.Strahlung_SE, SolarRadiation_SE) annotation (Line(
              points={{46.64,77.52},{46.64,90},{28,90},{28,110}},
              color={255,128,0},
              smooth=Smooth.None));
          connect(Livingroom.SolarRadiation_SE, SolarRadiation_SE) annotation (Line(
              points={{-52.0941,75.2267},{-52.0941,90},{28,90},{28,110}},
              color={255,128,0},
              smooth=Smooth.None));
          annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-150,
                    -150},{150,150}}),
                              graphics), Icon(coordinateSystem(
                  preserveAspectRatio=true, extent={{-150,-150},{150,150}}),
                                              graphics={Bitmap(extent={{-86,94},
                      {88,-96}}, fileName=
                      "modelica://AixLib/Images/House/MFD_FloorPlan_En.PNG"),
                Rectangle(
                  extent={{-52,56},{-4,36}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Text(
                  extent={{-72,58},{16,44}},
                  lineColor={0,0,0},
                  textString="Livingroom"),
                Rectangle(
                  extent={{28,56},{70,18}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Text(
                  extent={{8,58},{82,46}},
                  lineColor={0,0,0},
                  textString="Children"),
                Rectangle(
                  extent={{-8,6},{52,-14}},
                  fillColor={170,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None,
                  lineColor={170,255,255}),
                Text(
                  extent={{-16,4},{58,-8}},
                  lineColor={0,0,0},
                  textString="Corridor"),
                Rectangle(
                  extent={{-62,-28},{-20,-78}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Text(
                  extent={{-76,-52},{-2,-64}},
                  lineColor={0,0,0},
                  textString="Bedroom"),
                Rectangle(
                  extent={{-8,-28},{12,-70}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Text(
                  extent={{-36,-50},{38,-62}},
                  lineColor={0,0,0},
                  textString="Bath"),
                Rectangle(
                  extent={{16,-28},{52,-68}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Text(
                  extent={{0,-54},{74,-66}},
                  lineColor={0,0,0},
                  textString="Kitchen")}),
            Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Complete model appartment</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
</html>",       revisions="<html>
<p><ul>
<li><i>April 18, 2014</i> by Ana Constantin:<br/>Added documentation</li>
<li><i>August 16, 2011</i> by Ana Constantin:<br/>Implemented</li>
</ul></p>
</html>"));
        end OneAppartment_VoWo;
        annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Package for the appartment model used for the muti family dwelling.</p>
</html>"));
      end Building;

      package EnergySystem
                  extends Modelica.Icons.Package;

        package OneAppartment
                    extends Modelica.Icons.Package;

          model Radiators

          //Pipe lengths
          parameter Modelica.SIunits.Length Length_thSt=2.5 "L1" annotation (Dialog(group = "Pipe lengths", descriptionLabel = true, joinNext = true));
          parameter Modelica.SIunits.Length Length_thBath=2.5 "L2  " annotation (Dialog(group = "Pipe lengths", descriptionLabel = true, joinNext = true));
          parameter Modelica.SIunits.Length Length_thChildren1=2.3 "L3  " annotation (Dialog(group = "Pipe lengths", descriptionLabel = true,joinNext = true));
          parameter Modelica.SIunits.Length Length_thChildren2=1.5 "L4  " annotation (Dialog(group = "Pipe lengths", descriptionLabel = true));
          parameter Modelica.SIunits.Length Length_toKi=2.5 "l5" annotation (Dialog(group = "Pipe lengths", descriptionLabel = true, joinNext = true));
          parameter Modelica.SIunits.Length Length_toBath=2 "l4  " annotation (Dialog(group = "Pipe lengths", descriptionLabel = true, joinNext = true));
          parameter Modelica.SIunits.Length Length_toChildren=0.5 "l3  " annotation (Dialog(group = "Pipe lengths", descriptionLabel = true, joinNext = true));
          parameter Modelica.SIunits.Length Length_toBedroom=4.0 "l2  "
                                                                       annotation (Dialog(group = "Pipe lengths", descriptionLabel = true, joinNext = true));
          parameter Modelica.SIunits.Length Length_toLi=7 "l1  " annotation (Dialog(group = "Pipe lengths", descriptionLabel = true));

          //Pipe diameters
          parameter Modelica.SIunits.Diameter Diam_Main = 0.016
              "Diameter main pipe"                                                   annotation (Dialog(group = "Pipe diameters", descriptionLabel = true));
          parameter Modelica.SIunits.Diameter Diam_Sec = 0.013
              "Diameter secondary pipe  "                                                  annotation (Dialog(group = "Pipe diameters", descriptionLabel = true));

          //Hydraulic resistance
          parameter Real zeta_lateral = 2.5 "zeta lateral" annotation (Dialog(group = "Hydraulic resistance", descriptionLabel = true, joinNext = true));
          parameter Real zeta_through = 0.6 "zeta through" annotation (Dialog(group = "Hydraulic resistance", descriptionLabel = true));
          parameter Real zeta_bend = 1.0 "zeta bend" annotation (Dialog(group = "Hydraulic resistance", descriptionLabel = true));

          //Radiators

            parameter AixLib.DataBase.Radiators.RadiatiorBaseDataDefinition
              Type_Radiator_Livingroom=
                AixLib.DataBase.Radiators.StandardMFD_WSchV1984_OneAppartment.Livingroom()
              "Livingroom"
              annotation (Dialog(group="Radiators", descriptionLabel=true));

            parameter AixLib.DataBase.Radiators.RadiatiorBaseDataDefinition
              Type_Radiator_Bedroom=
                AixLib.DataBase.Radiators.StandardMFD_WSchV1984_OneAppartment.Bedroom()
              "Bedroom"
              annotation (Dialog(group="Radiators", descriptionLabel=true));
            parameter AixLib.DataBase.Radiators.RadiatiorBaseDataDefinition
              Type_Radiator_Children=
                AixLib.DataBase.Radiators.StandardMFD_WSchV1984_OneAppartment.Children()
              "Corridor"
              annotation (Dialog(group="Radiators", descriptionLabel=true));
            parameter AixLib.DataBase.Radiators.RadiatiorBaseDataDefinition
              Type_Radiator_Bath=
                AixLib.DataBase.Radiators.StandardMFD_WSchV1984_OneAppartment.Bathroom() "Bath"
              annotation (Dialog(group="Radiators", descriptionLabel=true));
            parameter AixLib.DataBase.Radiators.RadiatiorBaseDataDefinition
              Type_Radiator_Kitchen=
                AixLib.DataBase.Radiators.StandardMFD_WSchV1984_OneAppartment.Kitchen()
              "Kitchen"
              annotation (Dialog(group="Radiators", descriptionLabel=true));

           HVAC.Radiators.Radiator radiatorKitchen(RadiatorType=Type_Radiator_Kitchen)
              annotation (Placement(transformation(extent={{-89,-83},{-106,-66}})));

            HVAC.Radiators.Radiator radiator_bath(RadiatorType=Type_Radiator_Bath)
              annotation (Placement(transformation(extent={{83,-48},{100,-31}})));

            HVAC.Valves.ThermostaticValve valve_kitchen(
              Kvs=0.41,
              Kv_setT=0.262,
              p(start=1000)) annotation (Placement(transformation(extent={{-67,
                      -82.5},{-82,-66.5}})));

            HVAC.Radiators.Radiator radiator_livingroom(RadiatorType=
                  Type_Radiator_Livingroom) annotation (Placement(
                  transformation(extent={{-95,-5},{-113,13}})));
            HVAC.Radiators.Radiator radiator_bedroom(RadiatorType=Type_Radiator_Bedroom)
              annotation (Placement(transformation(extent={{78,72},{94,88}})));
            HVAC.Radiators.Radiator radiatorCorridor(RadiatorType=Type_Radiator_Children)
              annotation (Placement(transformation(extent={{86,33},{101,48}})));

            HVAC.Valves.ThermostaticValve valve_bath(Kvs=0.24, Kv_setT=0.162,
              p(start=1000))
              annotation (Placement(transformation(extent={{38,-47},{50,-31}})));
            HVAC.Valves.ThermostaticValve valve_livingroom(
              Kvs=1.43,
              Kv_setT=0.4,
              p(start=1000)) annotation (Placement(transformation(extent={{-67,
                      -4},{-79,12}})));

            HVAC.Valves.ThermostaticValve valve_children(Kvs=0.16, Kv_setT=0.088,
              p(start=1000))
              annotation (Placement(transformation(extent={{64,32},{76,48}})));

            HVAC.Valves.ThermostaticValve valve_bedroom(Kvs=0.24, Kv_setT=0.182,
              p(start=1000))
              annotation (Placement(transformation(extent={{49,74},{60,87}})));
            HVAC.Pipes.StaticPipe thStF(D=Diam_Main, l=Length_thSt)
              "through the storage room, flow stream"
              annotation (Placement(transformation(extent={{57,-85},{40,-74}})));
            HVAC.Pipes.StaticPipe toKiF(D=Diam_Sec, l=Length_toKi)
              "to kitchen, flow stream" annotation (Placement(transformation(
                  extent={{8,-5},{-8,5}},
                  rotation=0,
                  origin={-49,-74.5})));
            HVAC.Pipes.StaticPipe thStR(D=Diam_Main, l=Length_thSt)
              "through the storage room, return stream"
              annotation (Placement(transformation(extent={{40,-102},{58,-90}})));
            HVAC.Pipes.StaticPipe toKiR(D=Diam_Sec, l=Length_toKi)
              "to kitchen, return stream"
              annotation (Placement(transformation(extent={{-72,-102},{-56,-90}})));
            HVAC.Pipes.StaticPipe thBathF(D=Diam_Main, l=Length_thBath)
              "through Bath, flow stream" annotation (Placement(transformation(
                  extent={{8,4.5},{-8,-4.5}},
                  rotation=270,
                  origin={-4.5,-62})));
            HVAC.Pipes.StaticPipe thBathR(D=Diam_Main, l=Length_thBath)
              "through bath, return stream"
                                          annotation (Placement(transformation(
                  extent={{8.75,-4.25},{-8.75,4.25}},
                  rotation=90,
                  origin={-18.25,-62.75})));
            HVAC.Pipes.StaticPipe thChildren1R(D=Diam_Main, l=
                  Length_thChildren1) "through chidlren room 1, return stream"
              annotation (Placement(transformation(
                  extent={{6.5,-5},{-6.5,5}},
                  rotation=90,
                  origin={-18,-27.5})));
            HVAC.Pipes.StaticPipe thChildren1F(D=Diam_Main, l=
                  Length_thChildren1) "through chidlren room 1, flow stream"
              annotation (Placement(transformation(
                  extent={{6.5,5},{-6.5,-5}},
                  rotation=270,
                  origin={-5,-26.5})));
            HVAC.Pipes.StaticPipe toBathF(D=Diam_Sec, l=Length_toBath)
              "to Bath, flow stream" annotation (Placement(transformation(
                  extent={{-8.5,4.5},{8.5,-4.5}},
                  rotation=0,
                  origin={18.5,-38.5})));
            HVAC.Pipes.StaticPipe toBathR(D=Diam_Sec, l=Length_toBath)
              "to bath return stream" annotation (Placement(transformation(
                  extent={{8.5,4.5},{-8.5,-4.5}},
                  rotation=0,
                  origin={18.5,-49.5})));
            HVAC.Interfaces.Port_b RETURN
              "Fluid connector b (positive design flow direction is from port_a to port_b)"
              annotation (Placement(transformation(extent={{66,-114},{86,-94}})));
            HVAC.Interfaces.Port_a FLOW
              "Fluid connector a (positive design flow direction is from port_a to port_b)"
              annotation (Placement(transformation(extent={{92,-114},{112,-94}})));
            HVAC.Pipes.StaticPipe toChildrenF(D=Diam_Sec, l=Length_toChildren)
              "to Children, flow stream" annotation (Placement(transformation(
                  extent={{-8.5,4.5},{8.5,-4.5}},
                  rotation=0,
                  origin={45.5,40.5})));
            HVAC.Pipes.StaticPipe toChildrenR(D=Diam_Sec, l=Length_toChildren)
              "to Children, return stream" annotation (Placement(transformation(
                  extent={{7.5,4.5},{-7.5,-4.5}},
                  rotation=0,
                  origin={47.5,27})));
            HVAC.Pipes.StaticPipe thChildrenF2(D=Diam_Main, l=
                  Length_thChildren2) "through chidlren room, flow stream"
              annotation (Placement(transformation(
                  extent={{7,5},{-7,-5}},
                  rotation=270,
                  origin={-5,13})));
            HVAC.Pipes.StaticPipe thChildrenR2(D=Diam_Main, l=
                  Length_thChildren2) "through chidlren room, return stream"
                                                annotation (Placement(transformation(
                  extent={{7.5,-5},{-7.5,5}},
                  rotation=90,
                  origin={-19,12.5})));
            HVAC.Pipes.StaticPipe toBedroomF(D=Diam_Sec, l=Length_toBedroom)
              "to Bedroom , flow stream" annotation (Placement(transformation(
                  extent={{-6.5,4.5},{6.5,-4.5}},
                  rotation=0,
                  origin={23.5,80.5})));
            HVAC.Pipes.StaticPipe toBedroomR(D=Diam_Sec, l=Length_toBedroom)
              "to Bedroom, return stream" annotation (Placement(transformation(
                  extent={{6.5,4.5},{-6.5,-4.5}},
                  rotation=0,
                  origin={20.5,66})));
            HVAC.Pipes.StaticPipe toLiF(D=Diam_Sec, l=Length_toLi)
              "to livingroom, flow stream" annotation (Placement(transformation(
                  extent={{6,-4.5},{-6,4.5}},
                  rotation=0,
                  origin={-47.5,3})));
            HVAC.Pipes.StaticPipe toLiR(D=Diam_Main, l=Length_toLi)
              "to livingroom, return stream" annotation (Placement(transformation(
                  extent={{6.5,-5},{-6.5,5}},
                  rotation=180,
                  origin={-88.5,-16.5})));
            HVAC.Interfaces.RadPort Rad_Livingroom
              annotation (Placement(transformation(extent={{-148,38},{-132,55}})));
            Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
                                                        Con_Livingroom
              annotation (Placement(transformation(extent={{-146,25},{-133,38}})));
            HVAC.Interfaces.RadPort Rad_kitchen
              annotation (Placement(transformation(extent={{-146,-50},{-129,-34}})));
            Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
                                                        Con_kitchen
              annotation (Placement(transformation(extent={{-145,-66},{-131,-51}})));
            HVAC.Interfaces.RadPort Rad_bedroom
              annotation (Placement(transformation(extent={{128,88},{146,106}})));
            Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Con_bedroom
              annotation (Placement(transformation(extent={{130,64},{146,82}})));
            HVAC.Interfaces.RadPort Rad_children
              annotation (Placement(transformation(extent={{130,39},{150,59}})));
            Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
                                                        Con_children
              annotation (Placement(transformation(extent={{131,17},{146,34}})));
            HVAC.Interfaces.RadPort Rad_bath
              annotation (Placement(transformation(extent={{128,-38},{148,-18}})));
            Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Con_bath
              annotation (Placement(transformation(extent={{129,-59},{148,-41}})));
            Modelica.Blocks.Interfaces.RealInput TSet[5] annotation (Placement(
                  transformation(extent={{-123,78},{-95,108}}), iconTransformation(
                  extent={{-10.5,-12},{10.5,12}},
                  rotation=270,
                  origin={-105.5,96})));
            HVAC.HydraulicResistances.HydraulicResistance HydRes_InFl(zeta=zeta_bend, D=
                  Diam_Main) "hydraulic resistance in floor"
              annotation (Placement(transformation(extent={{24,-84},{10,-75}})));
            HVAC.HydraulicResistances.HydraulicResistance HydRes_RadKi(zeta=3*zeta_bend,
                D=Diam_Sec)
              annotation (Placement(transformation(extent={{-113,-100.5},{-99,-91.5}})));
            HVAC.HydraulicResistances.HydraulicResistance HydRes_BendRight(zeta=zeta_bend,
                D=Diam_Main) "hydraulic resistance bend right" annotation (Placement(
                  transformation(
                  extent={{-3.25,-2.25},{3.25,2.25}},
                  rotation=90,
                  origin={-3.75,-75.75})));
            HVAC.HydraulicResistances.HydraulicResistance HydRes_RadWC(zeta=2*zeta_bend,
                D=Diam_Sec)
              annotation (Placement(transformation(extent={{67,-53},{57,-44}})));
            HVAC.HydraulicResistances.HydraulicResistance HydRes_RadLi(zeta=3*zeta_bend,
                D=Diam_Sec)
              annotation (Placement(transformation(extent={{-116,-21},{-102,-12}})));
            HVAC.HydraulicResistances.HydraulicResistance HydRes_RadChildren(zeta=2*
                  zeta_bend, D=Diam_Sec)
              annotation (Placement(transformation(extent={{84,22.5},{74,31.5}})));
            HVAC.HydraulicResistances.HydraulicResistance HydRes_RadBedroom(zeta=3*
                  zeta_bend, D=Diam_Sec)
              annotation (Placement(transformation(extent={{74,61.5},{60,70.5}})));

            Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor
              tempSensor_livingroom annotation (Placement(transformation(extent={{-108,30},
                      {-96,42}})));
            Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor tempSensor_bedroom
              annotation (Placement(transformation(extent={{75,92},{63,104}})));
            Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor tempSensor_children
              annotation (Placement(transformation(extent={{88,49},{76,61}})));
            Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor tempSensor_bath
              annotation (Placement(transformation(extent={{66,-21},{54,-9}})));
            Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor tempSensor_bath1
              annotation (Placement(transformation(extent={{-91,-57},{-79,-45}})));
          equation
            connect(radiator_livingroom.port_a, valve_livingroom.port_b)
              annotation (Line(
                points={{-95.72,4},{-79,4}},
                color={255,0,0},
                smooth=Smooth.None,
                thickness=0.5));

            connect(valve_bath.port_b, radiator_bath.port_a) annotation (Line(
                points={{50,-39},{83.68,-39},{83.68,-39.5}},
                color={255,0,0},
                smooth=Smooth.None,
                thickness=0.5));
            connect(valve_children.port_b, radiatorCorridor.port_a) annotation (Line(
                points={{76,40},{86.6,40},{86.6,40.5}},
                color={255,0,0},
                smooth=Smooth.None,
                thickness=0.5));
            connect(valve_bedroom.port_b, radiator_bedroom.port_a) annotation (Line(
                points={{60,80.5},{78.64,80.5},{78.64,80}},
                color={255,0,0},
                smooth=Smooth.None,
                thickness=0.5));
            connect(thStR.port_b, RETURN) annotation (Line(
                points={{58,-96},{76,-96},{76,-104}},
                color={0,0,255},
                smooth=Smooth.None,
                thickness=0.5));
            connect(thStF.port_a, FLOW) annotation (Line(
                points={{57,-79.5},{60,-80},{62,-80},{62,-95},{102,-95},{102,-104}},
                color={255,0,0},
                smooth=Smooth.None,
                thickness=0.5));

            connect(toBathF.port_b, valve_bath.port_a) annotation (Line(
                points={{27,-38.5},{39,-38.5},{39,-39},{38,-39}},
                color={255,0,0},
                smooth=Smooth.None,
                thickness=0.5));
            connect(toChildrenF.port_b, valve_children.port_a) annotation (Line(
                points={{54,40.5},{56,40},{64,40}},
                color={255,0,0},
                smooth=Smooth.None,
                thickness=0.5));
            connect(toBedroomF.port_b, valve_bedroom.port_a) annotation (Line(
                points={{30,80.5},{49,80.5}},
                color={255,0,0},
                smooth=Smooth.None,
                thickness=0.5));
            connect(toLiF.port_b, valve_livingroom.port_a) annotation (Line(
                points={{-53.5,3},{-53.5,4},{-67,4}},
                color={255,0,0},
                thickness=0.5,
                smooth=Smooth.None));

            connect(valve_kitchen.port_a, toKiF.port_b) annotation (Line(
                points={{-67,-74.5},{-57,-74.5}},
                color={255,0,0},
                smooth=Smooth.None,
                thickness=0.5));
            connect(radiatorKitchen.port_a, valve_kitchen.port_b) annotation (
                Line(
                points={{-89.68,-74.5},{-82,-74.5}},
                color={255,0,0},
                smooth=Smooth.None,
                thickness=0.5));

            connect(HydRes_InFl.port_a, thStF.port_b)
                                                  annotation (Line(
                points={{24,-79.5},{40,-79.5}},
                color={255,0,0},
                smooth=Smooth.None,
                thickness=0.5));

            connect(radiatorKitchen.port_b, HydRes_RadKi.port_a) annotation (Line(
                points={{-105.32,-74.5},{-118,-74.5},{-118,-75},{-130,-75},{-130,-96},
                    {-113,-96}},
                color={0,128,255},
                smooth=Smooth.None,
                thickness=0.5));
            connect(HydRes_RadKi.port_b, toKiR.port_a) annotation (Line(
                points={{-99,-96},{-72,-96}},
                color={0,128,255},
                smooth=Smooth.None,
                thickness=0.5));
            connect(toBathR.port_a, HydRes_RadWC.port_b) annotation (Line(
                points={{27,-49.5},{42,-49.5},{42,-48.5},{57,-48.5}},
                color={0,128,255},
                smooth=Smooth.None,
                thickness=0.5));
            connect(HydRes_RadWC.port_a, radiator_bath.port_b) annotation (Line(
                points={{67,-48.5},{127,-48.5},{127,-39.5},{99.32,-39.5}},
                color={0,128,255},
                smooth=Smooth.None,
                thickness=0.5));
            connect(HydRes_RadLi.port_b, toLiR.port_a) annotation (Line(
                points={{-102,-16.5},{-95,-16.5}},
                color={0,128,255},
                smooth=Smooth.None,
                thickness=0.5));
            connect(HydRes_RadLi.port_a, radiator_livingroom.port_b)
              annotation (Line(
                points={{-116,-16.5},{-129,-16.5},{-129,4},{-112.28,4}},
                color={0,128,255},
                smooth=Smooth.None,
                thickness=0.5));
            connect(toChildrenR.port_a, HydRes_RadChildren.port_b) annotation (Line(
                points={{55,27},{74,27}},
                color={0,128,255},
                smooth=Smooth.None,
                thickness=0.5));
            connect(HydRes_RadChildren.port_a, radiatorCorridor.port_b) annotation (Line(
                points={{84,27},{126,27},{126,40.5},{100.4,40.5}},
                color={0,128,255},
                smooth=Smooth.None,
                thickness=0.5));
            connect(toBedroomR.port_a, HydRes_RadBedroom.port_b) annotation (Line(
                points={{27,66},{60,66}},
                color={0,128,255},
                smooth=Smooth.None,
                thickness=0.5));
            connect(HydRes_RadBedroom.port_a, radiator_bedroom.port_b) annotation (Line(
                points={{74,66},{126,66},{126,80},{93.36,80}},
                color={0,128,255},
                smooth=Smooth.None,
                thickness=0.5));
            connect(HydRes_BendRight.port_b, thBathF.port_a) annotation (Line(
                points={{-3.75,-72.5},{-3.75,-70},{-4.5,-70}},
                color={0,127,255},
                smooth=Smooth.None));
            connect(radiatorKitchen.radPort,Rad_kitchen)  annotation (Line(
                points={{-100.9,-67.87},{-100.9,-42},{-137.5,-42}},
                color={0,0,0},
                smooth=Smooth.None));
            connect(radiatorKitchen.convPort,Con_kitchen)  annotation (Line(
                points={{-93.93,-68.04},{-93.93,-58.5},{-138,-58.5}},
                color={191,0,0},
                smooth=Smooth.None));
            connect(radiator_bath.convPort, Con_bath) annotation (Line(
                points={{87.93,-33.04},{88,-33.04},{88,-33},{119,-33},{119,-50},{138.5,-50}},
                color={191,0,0},
                smooth=Smooth.None));

            connect(radiator_bath.radPort, Rad_bath) annotation (Line(
                points={{94.9,-32.87},{94.9,-28},{138,-28}},
                color={0,0,0},
                smooth=Smooth.None));
            connect(radiatorCorridor.radPort,Rad_children)  annotation (Line(
                points={{96.5,46.35},{96.5,49},{140,49}},
                color={0,0,0},
                smooth=Smooth.None));
            connect(radiatorCorridor.convPort,Con_children)  annotation (Line(
                points={{90.35,46.2},{90,46.2},{90,46},{113,46},{113,25.5},{138.5,25.5}},
                color={191,0,0},
                smooth=Smooth.None));
            connect(radiator_bedroom.convPort, Con_bedroom) annotation (Line(
                points={{82.64,86.08},{82.64,91},{119,91},{119,73},{138,73}},
                color={191,0,0},
                smooth=Smooth.None));
            connect(radiator_bedroom.radPort, Rad_bedroom) annotation (Line(
                points={{89.2,86.24},{89.2,97},{137,97}},
                color={0,0,0},
                smooth=Smooth.None));
            connect(radiator_livingroom.radPort, Rad_Livingroom) annotation (
                Line(
                points={{-107.6,11.02},{-107.6,11},{-131,11},{-131,46},{-136,46},
                    {-136,46.5},{-140,46.5}},
                color={0,0,0},
                smooth=Smooth.None));
            connect(radiator_livingroom.convPort, Con_Livingroom) annotation (
                Line(
                points={{-100.22,10.84},{-100.22,12},{-100,12},{-100,14},{-133,
                    14},{-133,32},{-137,32},{-137,31.5},{-139.5,31.5}},
                color={191,0,0},
                smooth=Smooth.None));
            connect(toKiR.port_b, thStR.port_a) annotation (Line(
                points={{-56,-96},{40,-96}},
                color={0,127,255},
                smooth=Smooth.None,
                thickness=0.5));
            connect(thBathR.port_b, thStR.port_a) annotation (Line(
                points={{-18.25,-71.5},{-18.25,-96},{40,-96}},
                color={0,127,255},
                smooth=Smooth.None,
                thickness=0.5));
            connect(thChildren1R.port_b, thBathR.port_a) annotation (Line(
                points={{-18,-34},{-18,-54},{-18.25,-54}},
                color={0,127,255},
                smooth=Smooth.None,
                thickness=0.5));
            connect(thChildrenR2.port_b, thChildren1R.port_a) annotation (Line(
                points={{-19,5},{-19,-21},{-18,-21}},
                color={0,127,255},
                smooth=Smooth.None,
                thickness=0.5));
            connect(toLiR.port_b, thChildren1R.port_a) annotation (Line(
                points={{-82,-16.5},{-19,-16.5},{-19,-21},{-18,-21}},
                color={0,127,255},
                smooth=Smooth.None,
                thickness=0.5));
            connect(toBedroomR.port_b, thChildrenR2.port_a) annotation (Line(
                points={{14,66},{-19,66},{-19,20}},
                color={0,127,255},
                smooth=Smooth.None,
                thickness=0.5));
            connect(toChildrenR.port_b, thChildrenR2.port_a) annotation (Line(
                points={{40,27},{-19,27},{-19,20}},
                color={0,127,255},
                smooth=Smooth.None,
                thickness=0.5));
            connect(toBathR.port_b, thBathR.port_a) annotation (Line(
                points={{10,-49.5},{-18,-49.5},{-18,-54},{-18.25,-54}},
                color={0,127,255},
                smooth=Smooth.None,
                thickness=0.5));
            connect(HydRes_BendRight.port_a, HydRes_InFl.port_b) annotation (Line(
                points={{-3.75,-79},{-3.75,-79.5},{10,-79.5}},
                color={0,127,255},
                smooth=Smooth.None));
            connect(thBathF.port_b, toBathF.port_a) annotation (Line(
                points={{-4.5,-54},{-4.5,-38.5},{10,-38.5}},
                color={255,0,0},
                smooth=Smooth.None,
                thickness=0.5));
            connect(toKiF.port_a, HydRes_InFl.port_b) annotation (Line(
                points={{-41,-74.5},{-23,-74.5},{-23,-80},{10,-80},{10,-79.5}},
                color={255,0,0},
                smooth=Smooth.None,
                thickness=0.5));
            connect(thBathF.port_b, thChildren1F.port_a) annotation (Line(
                points={{-4.5,-54},{-4.5,-44},{-5,-44},{-5,-33}},
                color={255,0,0},
                smooth=Smooth.None,
                thickness=0.5));
            connect(thChildren1F.port_b, thChildrenF2.port_a) annotation (Line(
                points={{-5,-20},{-5,6}},
                color={0,127,255},
                smooth=Smooth.None));
            connect(thChildrenF2.port_b, toChildrenF.port_a) annotation (Line(
                points={{-5,20},{-5,40.5},{37,40.5}},
                color={255,0,0},
                smooth=Smooth.None,
                thickness=0.5));
            connect(thChildrenF2.port_b, toBedroomF.port_a) annotation (Line(
                points={{-5,20},{-5,80.5},{17,80.5}},
                color={255,0,0},
                smooth=Smooth.None,
                thickness=0.5));
            connect(thChildren1F.port_b, toLiF.port_a) annotation (Line(
                points={{-5,-20},{-5,3},{-41.5,3}},
                color={255,0,0},
                smooth=Smooth.None,
                thickness=0.5));
            connect(valve_bedroom.T_setRoom, TSet[2]) annotation (Line(
                points={{57.58,86.87},{57.58,87},{-109,87}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(valve_children.T_setRoom, TSet[3]) annotation (Line(
                points={{73.36,47.84},{73.36,57},{-77,57},{-77,92},{-109,92},{-109,93}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(valve_bath.T_setRoom, TSet[4]) annotation (Line(
                points={{47.36,-31.16},{47.36,-7},{18,-7},{18,29},{-76,29},{-76,99},{-109,
                    99}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(valve_kitchen.T_setRoom, TSet[5]) annotation (Line(
                points={{-78.7,-66.66},{-78.7,-62},{-76,-62},{-76,105},{-109,
                    105}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(valve_livingroom.T_setRoom, TSet[1]) annotation (Line(
                points={{-76.36,11.84},{-76.36,52},{-76,52},{-76,92},{-109,92},
                    {-109,81}},
                color={0,0,127},
                smooth=Smooth.None));

            connect(Con_Livingroom, tempSensor_livingroom.port) annotation (Line(
                points={{-139.5,31.5},{-120,31.5},{-120,36},{-108,36}},
                color={191,0,0},
                smooth=Smooth.None));
            connect(tempSensor_livingroom.T, valve_livingroom.T_room)
              annotation (Line(
                points={{-96,36},{-69.16,36},{-69.16,11.84}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(valve_bedroom.T_room, tempSensor_bedroom.T) annotation (Line(
                points={{50.98,86.87},{50.98,98},{63,98}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(tempSensor_bedroom.port, Con_bedroom) annotation (Line(
                points={{75,98},{89,98},{89,97},{141,97},{141,73},{138,73}},
                color={191,0,0},
                smooth=Smooth.None));
            connect(valve_children.T_room, tempSensor_children.T) annotation (Line(
                points={{66.16,47.84},{66.16,55},{76,55}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(tempSensor_children.port,Con_children)  annotation (Line(
                points={{88,55},{138,55},{138,53},{138.5,53},{138.5,25.5}},
                color={191,0,0},
                smooth=Smooth.None));
            connect(valve_bath.T_room, tempSensor_bath.T) annotation (Line(
                points={{40.16,-31.16},{40.16,-15},{54,-15}},
                color={0,0,127},
                smooth=Smooth.None));
            connect(tempSensor_bath.port, Con_bath) annotation (Line(
                points={{66,-15},{97,-15},{97,-21},{138.5,-21},{138.5,-50}},
                color={191,0,0},
                smooth=Smooth.None));
            connect(tempSensor_bath1.port,Con_kitchen)  annotation (Line(
                points={{-91,-51},{-107,-51},{-107,-50},{-138,-50},{-138,-58.5}},
                color={191,0,0},
                smooth=Smooth.None));
            connect(tempSensor_bath1.T, valve_kitchen.T_room) annotation (Line(
                points={{-79,-51},{-69.7,-51},{-69.7,-66.66}},
                color={0,0,127},
                smooth=Smooth.None));
          annotation (  Diagram(coordinateSystem(
                  preserveAspectRatio=false,
                  extent={{-150,-100},{150,110}},
                  grid={1,1}), graphics={
                  Rectangle(
                    extent={{1,100},{126,63}},
                    pattern=LinePattern.None,
                    lineColor={0,0,0},
                    fillColor={215,215,215},
                    fillPattern=FillPattern.Solid),
                  Rectangle(
                    extent={{4,58},{127,15}},
                    pattern=LinePattern.None,
                    lineColor={0,0,0},
                    fillColor={215,215,215},
                    fillPattern=FillPattern.Solid),
                  Rectangle(
                    extent={{4,-14},{127,-67}},
                    pattern=LinePattern.None,
                    lineColor={0,0,0},
                    fillColor={215,215,215},
                    fillPattern=FillPattern.Solid),
                  Rectangle(
                    extent={{-129,29},{-22,-25}},
                    pattern=LinePattern.None,
                    lineColor={0,0,0},
                    fillColor={215,215,215},
                    fillPattern=FillPattern.Solid),
                  Rectangle(
                    extent={{-130,-49},{-23,-103}},
                    pattern=LinePattern.None,
                    lineColor={0,0,0},
                    fillColor={215,215,215},
                    fillPattern=FillPattern.Solid),
                  Text(
                    extent={{-120,-81},{-69,-96}},
                    lineColor={0,0,0},
                    fillColor={0,0,0},
                    fillPattern=FillPattern.Solid,
                    textString="Kitchen"),
                  Text(
                    extent={{-156.5,29},{-49.5,16}},
                    lineColor={0,0,0},
                    fillColor={0,0,0},
                    fillPattern=FillPattern.Solid,
                    textString="Livingroom"),
                  Text(
                    extent={{31,-15},{138,-28}},
                    lineColor={0,0,0},
                    fillColor={0,0,0},
                    fillPattern=FillPattern.Solid,
                    textString="Bath"),
                  Text(
                    extent={{-27,56},{80,43}},
                    lineColor={0,0,0},
                    fillColor={0,0,0},
                    fillPattern=FillPattern.Solid,
                    textString="Children"),
                  Text(
                    extent={{-34,100},{73,87}},
                    lineColor={0,0,0},
                    fillColor={0,0,0},
                    fillPattern=FillPattern.Solid,
                    textString="Bedroom"),
                  Text(
                    extent={{-70,103},{-17,71}},
                    lineColor={0,0,0},
                    textString="1 - Livingroom
2- Bedroom
3 - Children
4 - Bath
5 - Kitchen")}),                          Icon(coordinateSystem(
                  preserveAspectRatio=false,
                  extent={{-150,-100},{150,110}},
                  grid={1,1}), graphics={
                  Rectangle(
                    extent={{-119,92},{123,-79}},
                    lineColor={255,0,0},
                    fillColor={135,135,135},
                    fillPattern=FillPattern.Solid),
                  Line(
                    points={{-99,22},{104,22},{104,-6}},
                    color={255,0,0},
                    smooth=Smooth.None,
                    thickness=1),
                  Line(
                    points={{-98,13},{95,13},{95,-6}},
                    color={0,0,255},
                    smooth=Smooth.None,
                    thickness=1),
                  Line(
                    points={{-21,13},{-21,35}},
                    color={0,0,255},
                    thickness=1,
                    smooth=Smooth.None),
                  Line(
                    points={{-14,23},{-14,45}},
                    color={255,0,0},
                    thickness=1,
                    smooth=Smooth.None),
                  Text(
                    extent={{-124,119},{-84,111}},
                    lineColor={0,0,0},
                    lineThickness=0.5,
                    fillColor={215,215,215},
                    fillPattern=FillPattern.Solid,
                    textString="Set"),
                  Text(
                    extent={{-70,81},{-17,49}},
                    lineColor={0,0,0},
                    textString="1 - Livingroom
2- Bedroom
3 - Children
4 - Bath
5 - Kitchen")}),
              Documentation(revisions="<html>
<p><ul>
<li><i>June 19, 2014</i> by Ana Constantin:<br/>Implemented</li>
</ul></p>
</html>",       info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>The model is exemplarly build with components found in the HVAC package.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The model should be used as an example on how such a system can be built and connected to the building envelope.</p>
</html>"));
          end Radiators;
          annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Package with two hydraulic systems based on radiators for the one appartment, considered as a single unit.</p>
</html>"));
        end OneAppartment;
        annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Package for energy systems for the multi family dwelling.</p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The package contains a model for an energy system based on radiators, for just one appartment.</p>
</html>"));
      end EnergySystem;

      package BuildingAndEnergySystem
                  extends Modelica.Icons.Package;

        model OneAppartment_Radiators
          "just one appartment (same appartment as in MFD, but hydraulic network fit to this one appartment)"
          import HouseModels = AixLib.Building.HighOrder;
              replaceable package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater
            "Medium in the system" annotation (Dialog(group="Medium"),
              choicesAllMatching=true);
          HouseModels.House.MFD.EnergySystem.OneAppartment.Radiators
            Hydraulic
            annotation (Placement(transformation(extent={{-22,-72},{38,-12}})));
          Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow6(Q_flow=0)
            annotation (Placement(transformation(extent={{-62,26},{-50,32}})));
          Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow1(Q_flow=0)
            annotation (Placement(transformation(extent={{-78,62},{-66,68}})));
          Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow2(Q_flow=0)
            annotation (Placement(transformation(extent={{-78,26},{-66,32}})));
          Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow3(Q_flow=0)
            annotation (Placement(transformation(extent={{-78,46},{-66,52}})));
          Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow4(Q_flow=0)
            annotation (Placement(transformation(extent={{-62,38},{-50,44}})));
          Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow5(Q_flow=0)
            annotation (Placement(transformation(extent={{-64,52},{-52,58}})));
          Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow8(Q_flow=0)
            annotation (Placement(transformation(extent={{76,18},{64,24}})));
          Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow9(Q_flow=0)
            annotation (Placement(transformation(extent={{-80,14},{-68,20}})));
          Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow10(Q_flow=
                0) annotation (Placement(transformation(extent={{-60,18},{-48,24}})));
          Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow7(Q_flow=0)
            annotation (Placement(transformation(extent={{78,38},{66,44}})));
          Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow11(Q_flow=
                0) annotation (Placement(transformation(extent={{72,60},{60,66}})));
          Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow12(Q_flow=
                0) annotation (Placement(transformation(extent={{58,40},{46,46}})));
          Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow13(Q_flow=
                0) annotation (Placement(transformation(extent={{60,18},{48,24}})));
          Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow14(Q_flow=
                0) annotation (Placement(transformation(extent={{60,28},{48,34}})));
          Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow15(Q_flow=
                0) annotation (Placement(transformation(extent={{74,28},{62,34}})));
          Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow16(Q_flow=
                0) annotation (Placement(transformation(extent={{74,50},{62,56}})));
          HVAC.Interfaces.Port_a                Inflow
            "Inflow to connect with external models (boiler, pump etc.)"
            annotation (Placement(transformation(extent={{-26,-118},{-6,-98}}),
                iconTransformation(extent={{-26,-118},{-6,-98}})));
          HVAC.Interfaces.Port_b                Returnflow
            "Returnflow to connect with external models (boiler, pump etc.)"
            annotation (Placement(transformation(extent={{-2,-118},{18,-98}}),
                iconTransformation(extent={{-2,-118},{18,-98}})));
          Modelica.Blocks.Interfaces.RealInput WindSpeedPort  annotation (Placement(
                transformation(
                extent={{-20,-20},{20,20}},
                rotation=-90,
                origin={-32,112}), iconTransformation(
                extent={{-15,-15},{15,15}},
                rotation=-90,
                origin={-31,105})));
          Modelica.Blocks.Interfaces.RealInput AirExchangePort_Window[5]  annotation (
             Placement(transformation(
                extent={{-20,-20},{20,20}},
                rotation=-90,
                origin={20,112}), iconTransformation(
                extent={{-14,-14},{14,14}},
                rotation=-90,
                origin={26,106})));
          Utilities.Interfaces.SolarRad_in SolarRadiation[2] "[SE, NW]"
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={58,108})));
          HouseModels.House.MFD.Building.OneAppartment_VoWo      Appartment(Floor=2,
            Livingroom(
              T0_air=293.15,
              T0_OW=293.15,
              T0_IWChild=293.15,
              T0_IWBedroom=293.15,
              T0_IWNeighbour=293.15,
              T0_CE=293.35,
              T0_FL=292.95),
            Children(
              T0_air=293.15,
              T0_OW=293.15,
              T0_IWLivingroom=293.15,
              T0_IWNeighbour=293.15,
              T0_CE=293.35,
              T0_FL=292.95),
            Bedroom(
              T0_air=293.15,
              T0_OW=293.15,
              T0_IWLivingroom=293.15,
              T0_IWNeighbour=293.15,
              T0_CE=293.35,
              T0_FL=292.95),
            Bathroom(
              T0_IWKitchen=293.15,
              T0_IWBedroom=293.15,
              T0_OW=293.15,
              T0_CE=297.35,
              T0_FL=296.95),
            Kitchen(
              T0_air=293.15,
              T0_OW=293.15,
              T0_CE=293.35,
              T0_FL=292.95),
            Corridor(
              T0_IWKitchen=293.15,
              T0_IWBedroom=293.15,
              T0_IWLivingroom=293.15,
              T0_IWChild=293.15,
              T0_CE=293.35,
              T0_FL=292.95))
            annotation (Placement(transformation(extent={{-30,8},{32,70}})));
        public
          Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature tempOutside3
            annotation (Placement(transformation(extent={{-48,78},{-67.5,96}})));
          Modelica.Blocks.Interfaces.RealInput air_temp annotation (Placement(
                transformation(
                extent={{20,-20},{-20,20}},
                rotation=90,
                origin={-80,112}), iconTransformation(
                extent={{14,-14},{-14,14}},
                rotation=90,
                origin={-86,106})));
          Modelica.Blocks.Interfaces.RealInput TSet[5] "1 - Livingroom
2- Bedroom
3 - Children
4 - Bath
5 - Kitchen" annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
                iconTransformation(extent={{-120,-14},{-90,16}})));
        equation

          connect(Appartment.WindSpeedPort, WindSpeedPort)               annotation (
              Line(
              points={{-6.85333,61.7333},{-6.85333,80},{-32,80},{-32,112}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(Appartment.thermNeighbour_Livingroom, fixedHeatFlow1.port)
            annotation (Line(
              points={{-21.7333,57.6},{-38,57.6},{-38,65},{-66,65}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Appartment.thermNeigbour_Bedroom, fixedHeatFlow5.port) annotation (
              Line(
              points={{-21.7333,52.64},{-38,52.64},{-38,55},{-52,55}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Appartment.thermCeiling_Livingroom, fixedHeatFlow3.port)
            annotation (Line(
              points={{-21.7333,46.8533},{-38,46.8533},{-38,49},{-66,49}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Appartment.thermFloor_Livingroom, fixedHeatFlow4.port) annotation (
              Line(
              points={{-21.7333,41.8933},{-38,41.8933},{-38,41},{-50,41}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Appartment.thermCeiling_Bath, fixedHeatFlow10.port) annotation (
              Line(
              points={{-21.7333,26.1867},{-38,26.1867},{-38,21},{-48,21}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Appartment.thermFloor_Bath, fixedHeatFlow9.port) annotation (Line(
              points={{-21.7333,20.4},{-38,20.4},{-38,17},{-68,17}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Appartment.thermNeighbour_Child, fixedHeatFlow11.port) annotation (
              Line(
              points={{23.7333,57.6},{38,57.6},{38,63},{60,63}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Appartment.thermStaircase, fixedHeatFlow16.port) annotation (Line(
              points={{23.7333,52.2267},{38,52.2267},{38,53},{62,53}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Appartment.thermCeiling_Children, fixedHeatFlow12.port) annotation (
             Line(
              points={{23.7333,46.44},{38,46.44},{38,43},{46,43}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Appartment.thermCeiling_Corridor, fixedHeatFlow14.port) annotation (
             Line(
              points={{23.7333,36.52},{38,36.52},{38,31},{48,31}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Appartment.thermCeiling_Kitchen, fixedHeatFlow13.port) annotation (
              Line(
              points={{23.7333,26.1867},{38,26.1867},{38,21},{48,21}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Appartment.SolarRadiation_SE, SolarRadiation[1])
            annotation (Line(
              points={{6.78667,61.7333},{6.78667,72},{58,72},{58,103}},
              color={255,128,0},
              smooth=Smooth.None));
          connect(Appartment.SolarRadiation_NW, SolarRadiation[2])
            annotation (Line(
              points={{12.9867,61.7333},{12.9867,72},{58,72},{58,113}},
              color={255,128,0},
              smooth=Smooth.None));
          connect(fixedHeatFlow7.port, Appartment.thermFloor_Children) annotation (
              Line(
              points={{66,41},{64,41},{64,38},{38,38},{38,41.48},{23.7333,41.48}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(fixedHeatFlow8.port, Appartment.thermFloor_Kitchen) annotation (
              Line(
              points={{64,21},{62,21},{62,16},{38,16},{38,21.2267},{23.7333,
                  21.2267}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(fixedHeatFlow15.port, Appartment.thermFloor_Corridor) annotation (
              Line(
              points={{62,31},{60,31},{60,26},{38,26},{38,31.56},{23.7333,31.56}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(fixedHeatFlow6.port, Appartment.thermCeiling_Bedroom) annotation (
              Line(
              points={{-50,29},{-38,29},{-38,36.52},{-21.7333,36.52}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(fixedHeatFlow2.port, Appartment.thermFloor_Bedroom) annotation (
              Line(
              points={{-66,29},{-62,29},{-62,26},{-38,26},{-38,31.56},{-21.7333,
                  31.56}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(tempOutside3.T, air_temp) annotation (Line(
              points={{-46.05,87},{-46.05,112},{-80,112}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(AirExchangePort_Window, Appartment.AirExchangePort) annotation (
              Line(
              points={{20,112},{20,80},{0.173333,80},{0.173333,61.7333}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(tempOutside3.port, Appartment.thermOutside) annotation (Line(
              points={{-67.5,87},{-80,87},{-80,74},{-13.88,74},{-13.88,61.7333}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(Inflow, Hydraulic.FLOW) annotation (Line(
              points={{-16,-108},{20,-108},{20,-73.1429},{28.4,-73.1429}},
              color={0,127,255},
              smooth=Smooth.None));
          connect(Returnflow, Hydraulic.RETURN) annotation (Line(
              points={{8,-108},{8,-74},{23.2,-74},{23.2,-73.1429}},
              color={0,127,255},
              smooth=Smooth.None));
          connect(Hydraulic.Rad_Livingroom, Appartment.StarLivingroom)
            annotation (Line(
              points={{-20,-30.1429},{-26,-30.1429},{-26,-30},{-34,-30},{-34,0},
                  {-5.61333,0},{-5.61333,40.4467}},
              color={0,0,0},
              smooth=Smooth.None));
          connect(Hydraulic.Con_Livingroom, Appartment.thermLivingroom)
            annotation (Line(
              points={{-19.9,-34.4286},{-34,-34.4286},{-34,0},{-6,0},{-6,43.34},
                  {-9.33333,43.34}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Hydraulic.Rad_bedroom, Appartment.StarBedroom) annotation (
              Line(
              points={{35.4,-15.7143},{54,-15.7143},{54,0},{-5.61333,0},{
                  -5.61333,36.7267}},
              color={0,0,0},
              smooth=Smooth.None));
          connect(Hydraulic.Con_bedroom, Appartment.ThermBedroom) annotation (
              Line(
              points={{35.6,-22.5714},{54,-22.5714},{54,0},{-9.74667,0},{
                  -9.74667,36.52}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Hydraulic.Rad_children, Appartment.StarChildren) annotation (
              Line(
              points={{36,-29.4286},{54,-29.4286},{54,0},{14.64,0},{14.64,
                  45.6133}},
              color={0,0,0},
              smooth=Smooth.None));
          connect(Hydraulic.Con_children, Appartment.ThermChildren) annotation (
             Line(
              points={{35.7,-36.1429},{54,-36.1429},{54,0},{12,0},{12,22},{
                  10.92,22},{10.92,45.6133}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Hydraulic.Rad_bath, Appartment.StarBath) annotation (Line(
              points={{35.6,-51.4286},{54,-51.4286},{54,0},{2.44667,0},{2.44667,
                  34.8667}},
              color={0,0,0},
              smooth=Smooth.None));
          connect(Hydraulic.Con_bath, Appartment.ThermBath) annotation (Line(
              points={{35.7,-57.7143},{54,-57.7143},{54,0},{-1.48,0},{-1.48,
                  34.8667}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Hydraulic.Rad_kitchen, Appartment.StarKitchen) annotation (
              Line(
              points={{-19.5,-55.4286},{-34,-55.4286},{-34,0},{9.88667,0},{
                  9.88667,31.7667}},
              color={0,0,0},
              smooth=Smooth.None));
          connect(Hydraulic.Con_kitchen, Appartment.ThermKitchen) annotation (
              Line(
              points={{-19.6,-60.1429},{-34,-60.1429},{-34,0},{10.92,0},{10.92,
                  36.52}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Hydraulic.TSet, TSet) annotation (Line(
              points={{-13.1,-16},{-14,-16},{-14,0},{-120,0}},
              color={0,0,127},
              smooth=Smooth.None));
          annotation (Diagram(coordinateSystem(preserveAspectRatio=false,
                  extent={{-120,-120},{100,120}}),
                              graphics), Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Model for an appartment, considered as a single unit with an energy system based on radiators.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
</html>",       revisions="<html>
<p><ul>
<li><i>June 19, 2014</i> by Ana Constantin:<br/>Implemented</li>
</ul></p>
</html>"),  Icon(coordinateSystem(extent={{-120,-120},{100,120}},
                  preserveAspectRatio=false), graphics={Bitmap(extent={{-86,80},
                      {76,-84}}, fileName=
                      "modelica://AixLib/Images/House/MFD_FloorPlan_En.PNG")}));
        end OneAppartment_Radiators;
        annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Package with models with building envelope and energy systems. </p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>There is a complete model for a multi family building: middle entrance, three storeys (including the groundfloor).</p>
<p>There is also a complete model for an appartment, considered as a single unit and not part of a multi family dwelling.</p>
<p><b><font style=\"color: #ff0000; \">Attention: </font></b>there exissa only a parametrisation (the default parametrisation) for the energy system for a heavy building build accoring to the energy saving ordinance WSchV1984.</p>
</html>"));
      end BuildingAndEnergySystem;
    annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Package with rooms aggregated to an appartment and appartments aggregated to a complete building.</p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>Multiple rooms are connected together and they form an apartment. </p>
<p><img src=\"modelica://AixLib/Images/House/MFD_FloorPlan_En.PNG\"/></p>
<p>It is possible to model several storeys with apartments on top of each other, as well as several wings with apartments next to each other. Storeys are connected together to form a whole house.</p>
<p>The example here has three wings and three storeys.</p>
</html>"));
    end MFD;
  annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Package with complete standard house models</p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>For each standard house type there are packages for the building envelope (Building), for the energy system (EnergySystem) and for the building as a whole (BuildingAndEnergySystem).</p>
</html>"));
  end House;

  package Examples
    extends Modelica.Icons.ExamplesPackage;

    model RoomGFOw2_DayNightMode
      "Room on groudn floor with 2 outer walls with day and night"
      import AixLib;
      extends Modelica.Icons.Example;

         replaceable package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater
        "Medium in the system" annotation (choicesAllMatching=true);

      Rooms.OFD.Ow2IwL1IwS1Gr1Uf1                  room_GF_2OW(
        withDoor1=false,
        withDoor2=false,
        withWindow1=true,
        solar_absorptance_OW=0.6,
        room_length=5.87,
        room_width=3.84,
        room_height=2.6,
        windowarea_OW1=8.4,
        withWindow2=true,
        windowarea_OW2=1.73,
        withFloorHeating=false,
        TIR=1,
        T0_air=294.15,
        T0_IW1=291.15,
        T0_IW2=291.15,
        T0_FL=289.15,
        T_Ground=279.15)
        annotation (Placement(transformation(extent={{16,8},{52,44}})));

      AixLib.Building.Components.Weather.Weather combinedWeather(
        Latitude=49.5,
        Longitude=8.5,
        Cloud_cover=false,
        Wind_speed=true,
        Air_temp=true,
        fileName=
            "modelica://AixLib/Resources/WeatherData/TRY2010_12_Jahr_Modelica-Library.txt")
        annotation (Placement(transformation(extent={{-100,78},{-62,104}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature varTemp
        annotation (Placement(transformation(extent={{-58,38},{-38,58}})));
      Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow thermCeiling(Q_flow=0)
        annotation (Placement(transformation(extent={{102,58},{82,78}})));
      Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow thermInsideWall1(Q_flow=
           0) annotation (Placement(transformation(extent={{102,34},{82,54}})));
      Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow thermInsideWall2(Q_flow=
           0) annotation (Placement(transformation(extent={{102,10},{82,30}})));

      AixLib.HVAC.Valves.ThermostaticValve              heatValve_new(p(start=
              1000))
        annotation (Placement(transformation(extent={{22,-36},{42,-16}})));

      AixLib.HVAC.Pumps.Pump                  Pumo
        annotation (Placement(transformation(extent={{-92,-36},{-72,-16}})));

      AixLib.HVAC.HeatGeneration.Boiler
                                     boilerTaktTable
        annotation (Placement(transformation(extent={{-56,-36},{-36,-16}})));

      AixLib.Utilities.Sources.NightMode nightMode(dayEnd=22, dayStart=6)
        annotation (Placement(transformation(extent={{-104,0},{-84,20}})));
      AixLib.HVAC.Pipes.StaticPipe pipe_flow(p(start=100))
        annotation (Placement(transformation(extent={{-6,-36},{14,-16}})));
      AixLib.HVAC.Pipes.StaticPipe pipe_return(p(start=100))
        annotation (Placement(transformation(extent={{28,-82},{8,-62}})));
      Modelica.Blocks.Sources.Constant Tset(k=273.15 + 20)
        annotation (Placement(transformation(extent={{-6,-4},{4,6}})));
      Modelica.Blocks.Sources.Constant AirExchange(k=0.7)
        annotation (Placement(transformation(extent={{8,68},{18,78}})));
      AixLib.HVAC.Sources.Boundary_p  tank
        annotation (Placement(transformation(extent={{-120,-32},{-106,-18}})));
      AixLib.HVAC.Radiators.Radiator radiator_ML_delta(RadiatorType=
            AixLib.DataBase.Radiators.StandardOFD_EnEV2009.Livingroom())
        annotation (Placement(transformation(extent={{54,-36},{74,-16}})));

      Modelica.Blocks.Sources.Constant Tset_flowTemperature(k=273.15 + 55)
        annotation (Placement(transformation(extent={{-72,-6},{-62,4}})));
      Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
        annotation (Placement(transformation(
            extent={{-5,-5},{5,5}},
            rotation=270,
            origin={23,-5})));
      inner AixLib.HVAC.BaseParameters baseParameters(T0=293.15)
        annotation (Placement(transformation(extent={{80,80},{100,100}})));
      Modelica.Blocks.Interfaces.RealOutput Troom
        "Absolute temperature as output signal"
        annotation (Placement(transformation(extent={{90,-20},{110,0}})));
    equation
      connect(varTemp.port, room_GF_2OW.thermOutside) annotation (Line(
          points={{-38,48},{17.8,48},{17.8,42.2}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(room_GF_2OW.thermCeiling, thermCeiling.port) annotation (Line(
          points={{50.2,38.6},{80,38.6},{80,68},{82,68}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(room_GF_2OW.thermInsideWall1, thermInsideWall1.port) annotation (
          Line(
          points={{50.2,27.8},{80,27.8},{80,44},{82,44}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(room_GF_2OW.thermInsideWall2, thermInsideWall2.port) annotation (
          Line(
          points={{39.4,9.8},{39.4,0},{80,0},{80,20},{82,20}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(Pumo.port_b, boilerTaktTable.port_a)
        annotation (Line(
          points={{-72,-26},{-56,-26}},
          color={0,127,255},
          smooth=Smooth.None));

      connect(pipe_flow.port_b, heatValve_new.port_a) annotation (Line(
          points={{14,-26},{22,-26}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(boilerTaktTable.port_b, pipe_flow.port_a) annotation (Line(
          points={{-36,-26},{-6,-26}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(heatValve_new.port_b, radiator_ML_delta.port_a) annotation (Line(
          points={{42,-26},{54.8,-26}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(radiator_ML_delta.port_b, pipe_return.port_a) annotation (Line(
          points={{73.2,-26},{100,-26},{100,-72},{28,-72}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(room_GF_2OW.AirExchangePort, AirExchange.y) annotation (Line(
          points={{30.31,43.73},{30.31,73},{18.5,73}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(combinedWeather.SolarRadiation_OrientedSurfaces[1], room_GF_2OW.SolarRadiationPort_OW2)
        annotation (Line(
          points={{-90.88,76.7},{-90.88,70},{0,70},{0,84},{43.09,84},{43.09,43.82}},
          color={255,128,0},
          smooth=Smooth.None));

      connect(combinedWeather.SolarRadiation_OrientedSurfaces[2], room_GF_2OW.SolarRadiationPort_OW1)
        annotation (Line(
          points={{-90.88,76.7},{-90.88,70},{0,70},{0,31.4},{16.09,31.4}},
          color={255,128,0},
          smooth=Smooth.None));
      connect(combinedWeather.WindSpeed, room_GF_2OW.WindSpeedPort) annotation (
          Line(
          points={{-60.7333,98.8},{0,98.8},{0,18.8},{16.09,18.8}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(combinedWeather.AirTemp, varTemp.T) annotation (Line(
          points={{-60.7333,94.9},{0,94.9},{0,60},{-64,60},{-64,48},{-60,48}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(Pumo.port_a, pipe_return.port_b) annotation (Line(
          points={{-92,-26},{-100,-26},{-100,-72},{8,-72}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(tank.port_a, Pumo.port_a) annotation (Line(
          points={{-106,-25},{-100,-25},{-100,-26},{-92,-26}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(nightMode.SwitchToNightMode, Pumo.IsNight) annotation (Line(
          points={{-85.15,10.3},{-82,10.3},{-82,-15.8}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(Tset.y, heatValve_new.T_setRoom) annotation (Line(
          points={{4.5,1},{37.6,1},{37.6,-16.2}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(radiator_ML_delta.convPort, room_GF_2OW.thermRoom) annotation (
          Line(
          points={{59.8,-18.4},{59.8,0},{30.04,0},{30.04,29.6}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(radiator_ML_delta.radPort, room_GF_2OW.starRoom) annotation (Line(
          points={{68,-18.2},{68,0},{37.6,0},{37.6,29.6}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(Tset_flowTemperature.y, boilerTaktTable.T_set) annotation (Line(
          points={{-61.5,-1},{-56.8,-1},{-56.8,-19}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(temperatureSensor.T, heatValve_new.T_room) annotation (Line(
          points={{23,-10},{22,-10},{22,-16.2},{25.6,-16.2}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(temperatureSensor.port, room_GF_2OW.thermRoom) annotation (Line(
          points={{23,0},{23,29},{30.04,29},{30.04,29.6}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(temperatureSensor.T, Troom) annotation (Line(
          points={{23,-10},{100,-10}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),
                          graphics={                Text(
              extent={{-56,-44},{82,-130}},
              lineColor={0,0,255},
              textString="Set initial values for iteration variables (list given by translate, usually pressure drops). Rule of thumb: valves 1000 Pa, pipes 100 Pa. Simulation may still work without some of them, but  it gives warning of division by zero at initialization.
")}),   experiment(
          StopTime=86400,
          Interval=60,
          __Dymola_Algorithm="Lsodar"),
        experimentSetupOutput(events=false),
        Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Example for setting up a simulation for a room.</p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>Energy generation and delivery system consisting of boiler and pump.</p>
<p>The example works for a day and shows how such a simulation can be set up. It is not guranteed that the model will work stable under sifferent conditions or for longer periods of time.</p>
</html>",   revisions="<html>
<p><ul>
<li><i>June 19, 2014</i> by Ana Constantin:<br/>Implemented</li>
</ul></p>
</html>"));
    end RoomGFOw2_DayNightMode;

    model Appartment_VoWo "Simulation of 1 apartment "
      import AixLib;
        extends Modelica.Icons.Example;
            replaceable package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater
        "Medium in the system" annotation (Dialog(group="Medium"),
          choicesAllMatching=true);

      AixLib.Building.HighOrder.House.MFD.BuildingAndEnergySystem.OneAppartment_Radiators
                                                                VoWoWSchV1984(
        redeclare package Medium = Medium,
        fixedHeatFlow3(T_ref=288.15),
        fixedHeatFlow5(T_ref=283.15),
        fixedHeatFlow16(T_ref=288.15))
        annotation (Placement(transformation(extent={{-42,-4},{36,46}})));

      AixLib.HVAC.HeatGeneration.Boiler boilerTable(boilerEfficiencyB=
            AixLib.DataBase.Boiler.BoilerConst()) annotation (Placement(
            transformation(extent={{-44,-86},{-64,-66}}, rotation=0)));

      AixLib.HVAC.Pumps.Pump                  Pumpe
        annotation (Placement(transformation(extent={{4,-82},{-16,-62}})));
      AixLib.HVAC.Pipes.StaticPipe     pipe
        annotation (Placement(transformation(extent={{-30,-48},{-18,-36}})));
      AixLib.HVAC.Pipes.StaticPipe     pipe2
        annotation (Placement(transformation(extent={{26,-50},{38,-38}})));
      AixLib.Building.Components.Weather.Weather combinedWeather(
        Latitude=49.5,
        Longitude=8.5,
        Wind_dir=false,
        Wind_speed=true,
        Air_temp=true,
        SOD=AixLib.DataBase.Weather.SurfaceOrientation.SurfaceOrientationData_NE_SE_SW_NW_Hor(),
        fileName=
            "modelica://AixLib/Resources/WeatherData/TRY2010_12_Jahr_Modelica-Library.txt")
        annotation (Placement(transformation(extent={{-82,74},{-50,96}},
              rotation=0)));

      Modelica.Blocks.Sources.Constant Source_TsetChildren(k=273.15 + 22)
        annotation (Placement(transformation(extent={{-100,8},{-86,22}})));
      Modelica.Blocks.Sources.Constant Source_TsetLivingroom(k=273.15 + 20)
        annotation (Placement(transformation(extent={{-100,52},{-86,66}})));
      Modelica.Blocks.Sources.Constant Source_TsetBedroom(k=273.15 + 20)
        annotation (Placement(transformation(extent={{-100,30},{-86,44}})));
      Modelica.Blocks.Sources.Constant Source_TsetKitchen(k=273.15 + 20)
        annotation (Placement(transformation(extent={{-100,-36},{-86,-22}})));
      Modelica.Blocks.Sources.Constant Source_TsetBath(k=273.15 + 24)
        annotation (Placement(transformation(extent={{-100,-16},{-86,-2}})));
      Modelica.Blocks.Sources.Constant AirExWindow[5](k=0.5)
        annotation (Placement(transformation(extent={{-6,74},{0,80}})));
      AixLib.HVAC.Sources.Boundary_p  tank
        annotation (Placement(transformation(extent={{-8,-8},{8,8}},
            rotation=270,
            origin={28,-64})));

      Modelica.Blocks.Sources.BooleanExpression booleanExpression
        annotation (Placement(transformation(extent={{-94,-56},{-74,-36}})));
      inner AixLib.HVAC.BaseParameters baseParameters
        annotation (Placement(transformation(extent={{80,80},{100,100}})));
      Modelica.Blocks.Sources.Constant Source_TseBoiler(k=273.15 + 55)
        annotation (Placement(transformation(extent={{-86,-96},{-72,-82}})));
    equation

      connect(Pumpe.port_b, boilerTable.port_a)                   annotation (
          Line(
          points={{-16,-72},{-38,-72},{-38,-76},{-44,-76}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(boilerTable.port_b, pipe.port_a) annotation (Line(
          points={{-64,-76},{-74,-76},{-74,-42},{-30,-42}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(pipe.port_b, VoWoWSchV1984.Inflow)             annotation (Line(
          points={{-18,-42},{-5.12727,-42},{-5.12727,-1.5}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(VoWoWSchV1984.Returnflow, pipe2.port_a)             annotation (Line(
          points={{3.38182,-1.5},{3.38182,-44},{26,-44}},
          color={0,127,255},
          smooth=Smooth.None));
    // Here the relevant Variables for the simulation are set as output to limit the dimension of the result file

    public
     output Real Ta = combinedWeather.AirTemp;

     // Livingroom
     output Real airTLiving = VoWoWSchV1984.Appartment.Livingroom.airload.T;
     output Real radPowerLiConv = - VoWoWSchV1984.Hydraulic.Con_Livingroom.Q_flow;
     output Real radPowerLiRad = - VoWoWSchV1984.Hydraulic.Rad_Livingroom.Q_flow;
     output Real travelHVLi = VoWoWSchV1984.Hydraulic.valve_livingroom.opening;
     output Real massFlowLi = VoWoWSchV1984.Hydraulic.valve_livingroom.port_a.m_flow;

     // Bath
     output Real airTBath = VoWoWSchV1984.Appartment.Bathroom.airload.T;
     output Real radPowerBConv = - VoWoWSchV1984.Hydraulic.Con_bath.Q_flow;
     output Real radPowerBRad = - VoWoWSchV1984.Hydraulic.Rad_bath.Q_flow;
     output Real travelHVB = VoWoWSchV1984.Hydraulic.valve_bath.opening;
     output Real massFlowB = VoWoWSchV1984.Hydraulic.valve_bath.port_a.m_flow;

    // Bedroom
     output Real airTBedromm = VoWoWSchV1984.Appartment.Bedroom.airload.T;
     output Real radPowerBrConv = - VoWoWSchV1984.Hydraulic.Con_bedroom.Q_flow;
     output Real radPowerBrRad = - VoWoWSchV1984.Hydraulic.Rad_bedroom.Q_flow;
     output Real travelHVBr = VoWoWSchV1984.Hydraulic.valve_bedroom.opening;
     output Real massFlowBr = VoWoWSchV1984.Hydraulic.valve_bedroom.port_a.m_flow;

    // Children
     output Real airTChildren = VoWoWSchV1984.Appartment.Children.airload.T;
     output Real radPowerChConv = - VoWoWSchV1984.Hydraulic.Con_children.Q_flow;
     output Real radPowerChRad = - VoWoWSchV1984.Hydraulic.Rad_children.Q_flow;
     output Real travelHVCh = VoWoWSchV1984.Hydraulic.valve_children.opening;
     output Real massFlowCh = VoWoWSchV1984.Hydraulic.valve_children.port_a.m_flow;

     // Kitchen
     output Real airTKitchen = VoWoWSchV1984.Appartment.Kitchen.airload.T;
     output Real radPowerKitConv = - VoWoWSchV1984.Hydraulic.Con_kitchen.Q_flow;
     output Real radPowerKitRad = - VoWoWSchV1984.Hydraulic.Rad_kitchen.Q_flow;
     output Real travelHVKit = VoWoWSchV1984.Hydraulic.valve_kitchen.opening;
     output Real massFlowKit = VoWoWSchV1984.Hydraulic.valve_kitchen.port_a.m_flow;

    equation
      connect(combinedWeather.WindSpeed, VoWoWSchV1984.WindSpeedPort)
        annotation (Line(
          points={{-48.9333,91.6},{-10.4455,91.6},{-10.4455,42.875}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(AirExWindow.y, VoWoWSchV1984.AirExchangePort_Window)
        annotation (Line(
          points={{0.3,77},{6,77},{6,43.0833},{9.76364,43.0833}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(combinedWeather.SolarRadiation_OrientedSurfaces[2], VoWoWSchV1984.SolarRadiation[
        1])                                          annotation (Line(
          points={{-74.32,72.9},{-74.32,60},{21.1091,60},{21.1091,42.4583}},
          color={255,128,0},
          smooth=Smooth.None));
      connect(combinedWeather.SolarRadiation_OrientedSurfaces[4], VoWoWSchV1984.SolarRadiation[
        2])                                          annotation (Line(
          points={{-74.32,72.9},{-74.32,60},{21.1091,60},{21.1091,44.5417}},
          color={255,128,0},
          smooth=Smooth.None));
      connect(combinedWeather.AirTemp, VoWoWSchV1984.air_temp) annotation (Line(
          points={{-48.9333,88.3},{-29.9455,88.3},{-29.9455,43.0833}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(Source_TsetLivingroom.y, VoWoWSchV1984.TSet[1]) annotation (Line(
          points={{-85.3,59},{-60,59},{-60,18.7083},{-36.6818,18.7083}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(Source_TsetBedroom.y, VoWoWSchV1984.TSet[2]) annotation (Line(
          points={{-85.3,37},{-60,37},{-60,19.9583},{-36.6818,19.9583}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(Source_TsetChildren.y, VoWoWSchV1984.TSet[3]) annotation (Line(
          points={{-85.3,15},{-72,15},{-72,14},{-60,14},{-60,21.2083},{-36.6818,
              21.2083}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(booleanExpression.y, Pumpe.IsNight) annotation (Line(
          points={{-73,-46},{-6,-46},{-6,-61.8}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(Pumpe.port_a, tank.port_a) annotation (Line(
          points={{4,-72},{28,-72}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(tank.port_a, pipe2.port_b) annotation (Line(
          points={{28,-72},{28,-78},{56,-78},{56,-44},{38,-44}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(Source_TsetBath.y, VoWoWSchV1984.TSet[4]) annotation (Line(
          points={{-85.3,-9},{-60,-9},{-60,22.4583},{-36.6818,22.4583}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(Source_TsetKitchen.y, VoWoWSchV1984.TSet[5]) annotation (Line(
          points={{-85.3,-29},{-60,-29},{-60,23.7083},{-36.6818,23.7083}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(Source_TseBoiler.y, boilerTable.T_set) annotation (Line(
          points={{-71.3,-89},{-36,-89},{-36,-69},{-43.2,-69}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -140},{100,100}}),
                          graphics={                Text(
              extent={{-48,-82},{90,-168}},
              lineColor={0,0,255},
              textString="Set initial values for iteration variables (list given by translate, usually pressure drops). Rule of thumb: valves 1000 Pa, pipes 100 Pa. Simulation may still work without some of them, but  it gives warning of division by zero at initialization.
")}),   experiment(
          StopTime=86400,
          Interval=60,
          __Dymola_Algorithm="Lsodar"),
        experimentSetupOutput(
          states=false,
          derivatives=false,
          auxiliaries=false,
          events=false),
        Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Example for setting up a simulation for an appartment.</p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>Energy generation and delivery system consisting of boiler and pump.</p>
<p>The example works for a day and shows how such a simulation can be set up. It is not guranteed that the model will work stable under sifferent conditions or for longer periods of time.</p>
</html>",   revisions="<html>
<p><ul>
<li><i>June 19, 2014</i> by Ana Constantin:<br/>Implemented</li>
</ul></p>
</html>"),
        Icon(coordinateSystem(extent={{-100,-140},{100,100}})));
    end Appartment_VoWo;

    model OFD_1Jan "OFD with TMC, TIR and TRY"
      import AixLib;
        extends Modelica.Icons.Example;
      replaceable package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater
        "Medium in the system"
        annotation (Dialog(group = "Medium"),choicesAllMatching=true);

      parameter AixLib.DataBase.Profiles.Profile_BaseDataDefinition
        VentilationProfile=
          AixLib.DataBase.Profiles.Ventilation_2perDay_Mean05perH();
      parameter AixLib.DataBase.Profiles.Profile_BaseDataDefinition TSetProfile=
         AixLib.DataBase.Profiles.SetTemperatures_Ventilation2perDay();

    public
      AixLib.Building.HighOrder.House.OFD_MiddleInnerLoadWall.BuildingAndEnergySystem.OFD_IdealHeaters
        OFD(
        TIR=3) annotation (Placement(transformation(extent={{94,-20},{153,19}})));

    protected
      AixLib.Building.Components.Weather.Weather Weather(
        Latitude=49.5,
        Longitude=8.5,
        GroundReflection=0.2,
        tableName="wetter",
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
        SOD=AixLib.DataBase.Weather.SurfaceOrientation.SurfaceOrientationData_N_E_S_W_RoofN_Roof_S(),
        Wind_dir=false,
        Wind_speed=true,
        Air_temp=true,
        fileName=
            "modelica://AixLib/Resources/WeatherData/TRY2010_12_Jahr_Modelica-Library.txt")
        annotation (Placement(transformation(extent={{-199,69},{-151,101}})));

    public
      inner Modelica.Fluid.System system annotation (Placement(transformation(
              extent={{181,78.5},{200.5,99.5}})));

    public
      Modelica.Blocks.Sources.CombiTimeTable NaturalVentilation(
        columns={2,3,4,5,6},
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
        tableOnFile=false,
        table=VentilationProfile.Profile)
        annotation (Placement(transformation(extent={{18,25},{38,45}})));
      Modelica.Blocks.Sources.CombiTimeTable TSet(
        columns={2,3,4,5,6,7},
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
        tableOnFile=false,
        table=TSetProfile.Profile)
        annotation (Placement(transformation(extent={{20,-23},{40,-3}})));

    public
      Modelica.Blocks.Interfaces.RealOutput TAirRooms[10]( unit = "degC")
        annotation (Placement(transformation(extent={{177,11},{197,31}}),
            iconTransformation(extent={{171,-29},{187,-13}})));
      Modelica.Blocks.Interfaces.RealOutput Toutside( unit = "degC")
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=270,
            origin={142,-111}),
            iconTransformation(extent={{172,-95},{188,-79}})));
      Modelica.Blocks.Interfaces.RealOutput SolarRadiation[6](unit="W/m2")
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=270,
            origin={186,-112}),
            iconTransformation(extent={{172,-95},{188,-79}})));
      Modelica.Blocks.Interfaces.RealOutput VentilationSchedule[4]
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=270,
            origin={100,-111}),
            iconTransformation(extent={{171,-29},{187,-13}})));
      Modelica.Blocks.Interfaces.RealOutput TsetValvesSchedule[5]( unit = "degC")
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=270,
            origin={121,-111}),
            iconTransformation(extent={{171,-29},{187,-13}})));
    equation
      // Romm Temperatures
      TAirRooms[1] =Modelica.SIunits.Conversions.to_degC(OFD.GF.Livingroom.airload.port.T);
      TAirRooms[2] =Modelica.SIunits.Conversions.to_degC(OFD.GF.Hobby.airload.port.T);
      TAirRooms[3] =Modelica.SIunits.Conversions.to_degC(OFD.GF.Corridor.airload.port.T);
      TAirRooms[4] =Modelica.SIunits.Conversions.to_degC(OFD.GF.WC_Storage.airload.port.T);
      TAirRooms[5] =Modelica.SIunits.Conversions.to_degC(OFD.GF.Kitchen.airload.port.T);
      TAirRooms[6] =Modelica.SIunits.Conversions.to_degC(OFD.UF.Bedroom.airload.port.T);
      TAirRooms[7] =Modelica.SIunits.Conversions.to_degC(OFD.UF.Children1.airload.port.T);
      TAirRooms[8] =Modelica.SIunits.Conversions.to_degC(OFD.UF.Corridor.airload.port.T);
      TAirRooms[9] =Modelica.SIunits.Conversions.to_degC(OFD.UF.Bath.airload.port.T);
      TAirRooms[10] =Modelica.SIunits.Conversions.to_degC(OFD.UF.Children2.airload.port.T);

      //SimulationData
      VentilationSchedule[1] = NaturalVentilation.y[1];
      VentilationSchedule[2] = NaturalVentilation.y[2];
      VentilationSchedule[3] = NaturalVentilation.y[3];
      VentilationSchedule[4] = NaturalVentilation.y[4];

      TsetValvesSchedule[1] = Modelica.SIunits.Conversions.to_degC(TSet.y[1]);
      TsetValvesSchedule[2] = Modelica.SIunits.Conversions.to_degC(TSet.y[2]);
      TsetValvesSchedule[3] = Modelica.SIunits.Conversions.to_degC(TSet.y[3]);
      TsetValvesSchedule[4] = Modelica.SIunits.Conversions.to_degC(TSet.y[4]);
      TsetValvesSchedule[5] = Modelica.SIunits.Conversions.to_degC(TSet.y[5]);

      Toutside = Modelica.SIunits.Conversions.to_degC(Weather.AirTemp);

      //SolarRadiation
      SolarRadiation[1] = Weather.SolarRadiation_OrientedSurfaces[1].I;
      SolarRadiation[2] = Weather.SolarRadiation_OrientedSurfaces[2].I;
      SolarRadiation[3] = Weather.SolarRadiation_OrientedSurfaces[3].I;
      SolarRadiation[4] = Weather.SolarRadiation_OrientedSurfaces[4].I;
      SolarRadiation[5] = Weather.SolarRadiation_OrientedSurfaces[5].I;
      SolarRadiation[6] = Weather.SolarRadiation_OrientedSurfaces[6].I;

      connect(NaturalVentilation.y[1], OFD.NaturalVentilation_UF[1])
        annotation (Line(
          points={{39,35},{59,35},{59,8.47},{93.6067,8.47}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(NaturalVentilation.y[1], OFD.NaturalVentilation_GF[1])
        annotation (Line(
          points={{39,35},{59,35},{59,-0.11},{94,-0.11}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(NaturalVentilation.y[2], OFD.NaturalVentilation_UF[2])
        annotation (Line(
          points={{39,35},{59,35},{59,10.03},{93.6067,10.03}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(NaturalVentilation.y[2], OFD.NaturalVentilation_GF[2])
        annotation (Line(
          points={{39,35},{59,35},{59,1.45},{94,1.45}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(TSet.y[1], OFD.TSet_UF[1]) annotation (Line(
          points={{41,-13},{59,-13},{59,-9.81125},{93.8033,-9.81125}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(TSet.y[1], OFD.TSet_GF[1]) annotation (Line(
          points={{41,-13},{59,-13},{59,-19.298},{94,-19.298}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(TSet.y[2], OFD.TSet_UF[2]) annotation (Line(
          points={{41,-13},{59,-13},{59,-8.15375},{93.8033,-8.15375}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(TSet.y[2], OFD.TSet_GF[2]) annotation (Line(
          points={{41,-13},{59,-13},{59,-17.894},{94,-17.894}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(TSet.y[6], OFD.TSet_GF[3]) annotation (Line(
          points={{41,-13},{60,-13},{60,-16.49},{94,-16.49}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(TSet.y[4], OFD.TSet_UF[3]) annotation (Line(
          points={{41,-13},{60,-13},{60,-6.49625},{93.8033,-6.49625}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(TSet.y[5], OFD.TSet_GF[4]) annotation (Line(
          points={{41,-13},{59,-13},{59,-15.086},{94,-15.086}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(TSet.y[3], OFD.TSet_UF[4]) annotation (Line(
          points={{41,-13},{60,-13},{60,-4.83875},{93.8033,-4.83875}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(TSet.y[3], OFD.TSet_GF[5]) annotation (Line(
          points={{41,-13},{60,-13},{60,-27},{94,-27},{94,-13.682}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(NaturalVentilation.y[3], OFD.NaturalVentilation_UF[4])
        annotation (Line(
          points={{39,35},{60,35},{60,13.15},{93.6067,13.15}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(NaturalVentilation.y[3], OFD.NaturalVentilation_GF[4])
        annotation (Line(
          points={{39,35},{59,35},{59,4.57},{94,4.57}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(NaturalVentilation.y[4], OFD.NaturalVentilation_UF[3])
        annotation (Line(
          points={{39,35},{60,35},{60,11.59},{93.6067,11.59}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(NaturalVentilation.y[4], OFD.NaturalVentilation_GF[3])
        annotation (Line(
          points={{39,35},{59,35},{59,3.01},{94,3.01}},
          color={0,0,127},
          smooth=Smooth.None));

      connect(Weather.WindSpeed, OFD.WindSpeedPort)            annotation (Line(
          points={{-149.4,94.6},{-126,94.6},{-126,70},{100.293,70},{100.293,
              21.73}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(Weather.SolarRadiation_OrientedSurfaces, OFD.SolarRadiationPort)
        annotation (Line(
          points={{-187.48,67.4},{-187.48,52},{-169,52},{-169,70},{147,70},{147,
              17.05},{151.033,17.05}},
          color={255,128,0},
          smooth=Smooth.None));
      connect(OFD.Air_Temp, Weather.AirTemp) annotation (Line(
          points={{137.267,21.73},{137.267,70},{-126,70},{-126,90},{-149.4,90},
              {-149.4,89.8}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-200,-100},{200,100}},
            grid={1,1}),     graphics={
            Rectangle(
              extent={{-63,15},{-28,-13}},
              lineColor={0,0,255},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-23,50},{12,22}},
              lineColor={0,0,255},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-35,45},{15,43}},
              lineColor={0,0,255},
              textString="1-Bedroom"),
            Text(
              extent={{-35,39},{15,37}},
              lineColor={0,0,255},
              textString="2-Children1"),
            Text(
              extent={{-35,33},{15,31}},
              lineColor={0,0,255},
              textString="3-Bath"),
            Text(
              extent={{-35,27},{15,25}},
              lineColor={0,0,255},
              textString="4-Children2"),
            Text(
              extent={{-76,13},{-26,11}},
              lineColor={0,0,255},
              textString="1-Livingroom"),
            Text(
              extent={{-76,7},{-26,5}},
              lineColor={0,0,255},
              textString="2-Hobby"),
            Text(
              extent={{-76,1},{-26,-1}},
              lineColor={0,0,255},
              textString="3-Corridor"),
            Text(
              extent={{-76,-5},{-26,-7}},
              lineColor={0,0,255},
              textString="4-WC"),
            Text(
              extent={{-76,-11},{-26,-13}},
              lineColor={0,0,255},
              textString="5-Kitchen"),
            Text(
              extent={{-3,38},{13,49}},
              lineColor={0,0,255},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              textString="UF"),
            Rectangle(
              extent={{-63,50},{-28,22}},
              lineColor={0,0,255},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-43,38},{-27,49}},
              lineColor={0,0,255},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              textString="GF"),
            Text(
              extent={{-75,41},{-25,39}},
              lineColor={0,0,255},
              textString="1-Livingroom"),
            Text(
              extent={{-75,35},{-25,33}},
              lineColor={0,0,255},
              textString="2-Hobby"),
            Text(
              extent={{-75,29},{-25,27}},
              lineColor={0,0,255},
              textString="3-WC"),
            Text(
              extent={{-76,25},{-26,23}},
              lineColor={0,0,255},
              textString="4-Kitchen"),
            Rectangle(
              extent={{-23,15},{12,-13}},
              lineColor={0,0,255},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-43,3},{-27,14}},
              lineColor={0,0,255},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              textString="GF"),
            Text(
              extent={{-3,3},{13,14}},
              lineColor={0,0,255},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              textString="UF"),
            Text(
              extent={{-32,10},{18,8}},
              lineColor={0,0,255},
              textString="1-Bedroom"),
            Text(
              extent={{-32,4},{18,2}},
              lineColor={0,0,255},
              textString="2-Children1"),
            Text(
              extent={{-32,-2},{18,-4}},
              lineColor={0,0,255},
              textString="3-Bath"),
            Text(
              extent={{-32,-8},{18,-10}},
              lineColor={0,0,255},
              textString="4-Children2")}),
                                        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-200,-100},{200,100}},
            grid={1,1}), graphics),
        experiment(
          StopTime=86400,
          Interval=15,
          __Dymola_Algorithm="Lsodar"),
        experimentSetupOutput(events=false),
        Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Example for setting up a simulation for a one family dwelling.</p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>Energy generation and delivery system consisting of boiler and pump.</p>
<p>The example works for a day and shows how such a simulation can be set up. It is not guranteed that the model will work stable under sifferent conditions or for longer periods of time.</p>
</html>",   revisions="<html>
<p><ul>
<li><i>June 19, 2014</i> by Ana Constantin:<br/>Implemented</li>
</ul></p>
</html>"));
    end OFD_1Jan;

    annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Package with exemplary simulation setups for a room, an apartment and a one family dwelling. </p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The examples can be used to learn how to set up a simulation for these models (e.g. assumption for boundary conditions for a single room) and to compare the different CPU-times for simulations using the models.</p>
</html>"));
  end Examples;
  annotation (
  conversion(noneFromVersion="", noneFromVersion="1.0",
    noneFromVersion="1.1", noneFromVersion="1.2",
    from(version="1.3", script="Conversions/ConvertFromHouse_Models_1.3.mos"),
    from(version = "2.0", script="Conversions/ConvertFromHouse_Models_2.0_To_2.1"),
    from(version = "2.1", script="Conversions/ConvertFromHouse_Models_2.1_To_2.2")),
  Documentation(revisions="",
          info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Package for standard house models, derived form the EBC-Library HouseModels.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The H library aims to provide standard models for one family dwellings (stand alone house), single apartments and multi-family dwellings consisting of several apartments. The particularity of this library lies in providing ready to use models for the dynamic simulation of building energy systems, while allowing for a degree of flexibility in adapting or extending these models to ones needs.</p>
<p>A library with models for standard houses as such does not yet exist. While at the moment the standard house models are tailor-made for the German market, it is possible to adapt them to other markets.</p>
<p>When developing the HouseModels library we followed several goals: </p>
<ul>
<li>develop standard models</li>
<li>model only the necessary physical processes</li>
<li>build a model so that changing the parameters is easy, quick and will not lead to hidden mistakes</li>
<li>have an easy to use graphical interface</li>
<li>ensure a degree of flexibility for expanding or building new models</li>
</ul>
<p><br>We call these house models standard for the following reasons:</p>
<ul>
<li>the floor layouts were made based on existing buildings, by analyzing data provided by the German Federal Statistical Office and by consulting with experts</li>
<li>for modeling realistical wall structures building catalogues as well as experts were consulted</li>
<li>the physical properties of the materials for the wall layers were chosen to satisfy the insulation requirements of current and past German energy saving ordinances: WSchV 1984, WSchV1995, EnEV 2002 and EnEV 2009</li>
</ul>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Ana Constantin, Rita Streblow and Dirk Mueller The Modelica HouseModels Library: Presentation and Evaluation of a Room Model with the ASHRAE Standard 140 in Proceedings of Modelica Conference, Lund 2014, Pages 293-299. DOI: <a href=\"http://dx.doi.org/10.3384/ECP14096293\">10.3384/ECP14096293</a></p>
</html>"));
end HighOrder;
