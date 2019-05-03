within AixLib.PlugNHarvest.Components;
record Parameters "Record for parametrisation of simulation model"
    //  * * * * * * * * * * * * G  E  N  E  R  A  L * * * * * * * * * * * *
 replaceable package AirModel = AixLib.Media.Air "Air model" annotation (choicesAllMatching = true);
 parameter String weatherFileName = Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/weatherdata/TRY2010_12_Jahr_Modelica-Library.txt");
    //**************************E N V E L O P E ************************
    // room geometry
  parameter Modelica.SIunits.Length room_length=5 "room length"
    annotation (Dialog(group="Envelope", descriptionLabel=true));
  parameter Modelica.SIunits.Length room_width=3 "room width"
    annotation (Dialog(group="Envelope", descriptionLabel=true));
  parameter Modelica.SIunits.Height room_height=3 "room height"
    annotation (Dialog(group="Envelope", descriptionLabel=true));

  //wall types
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallType_OW1= AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_M() "wall type OW1"
    annotation (Dialog(group= "Envelope", descriptionLabel=true));
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallType_IW1=AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_M_half() "wall type IW1"
    annotation (Dialog(group= "Envelope", descriptionLabel=true));
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallType_IW2=AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_M_half() "wall type IW2"
    annotation (Dialog(group= "Envelope", descriptionLabel=true));
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallType_IW3=AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_M_half() "wall type IW3"
    annotation (Dialog(group= "Envelope", descriptionLabel=true));
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallType_CE=AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_SM_loHalf() "wall type Ceiling"
    annotation (Dialog(group= "Envelope", descriptionLabel=true));
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallType_FL=AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_SM_upHalf() "wall type Floor"
    annotation (Dialog(group= "Envelope", descriptionLabel=true));

  // window
  parameter Modelica.SIunits.Area windowarea_OW1=6 "Window area " annotation (
      Dialog(
      group="Envelope",
      descriptionLabel=true,
      enable=withWindow1));
  parameter AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple
    Type_Win=
      AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009() "window type"
      annotation (Dialog(group="Envelope"));

  //**************************S M A R T   F A C A D E ************************
  // smart facade
  parameter Boolean withSmartFacade = false annotation (Dialog( group = "Smart Facade", enable = outside), choices(checkBox=true));
  // Mechanical ventilation
  parameter Boolean withMechVent = false "with mechanical ventilation" annotation (Dialog( group = "Smart Facade", enable = withSmartFacade),choices(checkBox=true));
  // PV
  parameter Boolean withPV = false "with photovoltaics" annotation (Dialog( group = "Smart Facade", enable = withSmartFacade),choices(checkBox=true));
  //solar air heater
  parameter Boolean withSolAirHeat = false "with Solar Air Heater" annotation (Dialog( group = "Smart Facade", enable = withSmartFacade),choices(checkBox=true));
  parameter Integer NrPVpanels=5 "Number of panels" annotation(Dialog(group = "Smart Facade", enable = withPV));
  parameter AixLib.DataBase.SolarElectric.PVBaseRecord dataPV = AixLib.DataBase.SolarElectric.SymphonyEnergySE6M181()
                                                                 "PV data set" annotation(Dialog(group = "Smart Facade", enable = withPV));
  parameter Modelica.SIunits.Power PelPV_max = 4000
    "Maximum output power for inverter" annotation(Dialog(group = "Smart Facade", enable = withPV));

  parameter Modelica.SIunits.MassFlowRate MassFlowSetPoint=0.0306
    "Mass Flow Set Point for solar air heater" annotation(Dialog(group = "Smart Facade", enable = withSolAirHeat));
  parameter Modelica.SIunits.Area CoverArea=1.2634
    "Cover Area for solar air heater" annotation(Dialog(group = "Smart Facade", enable = withSolAirHeat));
  parameter Modelica.SIunits.Area InnerCrossSection=0.01181
    "Channel Cross Section for solar air heater" annotation(Dialog(group = "Smart Facade", enable = withSolAirHeat));
  parameter Modelica.SIunits.Length Perimeter=1.348
    "Perimeter for solar air heater" annotation(Dialog(group = "Smart Facade", enable = withSolAirHeat));
  parameter Modelica.SIunits.Length SAHLength1=1.8
    "Channel Length 1 for solar air heater" annotation(Dialog(group = "Smart Facade", enable = withSolAirHeat));
  parameter Modelica.SIunits.Length SAHLength2=1.5
    "Channel Length 2 for solar air heater" annotation(Dialog(group = "Smart Facade", enable = withSolAirHeat));
  parameter Modelica.SIunits.HeatCapacity AbsorberHeatCapacity=3950
    "Absorber Heat Capacityfor solar air heater" annotation(Dialog(group = "Smart Facade", enable = withSolAirHeat));
  parameter Modelica.SIunits.TransmissionCoefficient CoverTransmitance=0.84
    "Cover Transmitance for solar air heater" annotation(Dialog(group = "Smart Facade", enable = withSolAirHeat));
  parameter Modelica.SIunits.ThermalConductance CoverConductance=3.2
    "Cover Conductance for solar air heater" annotation(Dialog(group = "Smart Facade", enable = withSolAirHeat));


  //**************************I N T E R N A L  G A I N S ************************
  // persons
  parameter Modelica.SIunits.Power heatLoadForActivity = 80 "Sensible heat output occupants for activity at 20°C" annotation(Dialog(group = "Internal gains", descriptionLabel = true));
  parameter Real occupationDensity = 0.07 "Density of occupants in persons/m2" annotation(Dialog(group = "Internal gains", descriptionLabel = true));
  // lights
  parameter Real spPelSurface_lights(unit = "W/m2") =  10 "specific Pel/m2 for type of light source" annotation(Dialog(group = "Internal gains",descriptionLabel = true));
  //electrical appliances
  parameter Real spPelSurface_elApp(unit = "W/m2") =  14 "specific Pel/m2 for type of el. appliances" annotation(Dialog(group = "Internal gains",descriptionLabel = true));

    //**************************E N E R G Y   S Y S T E M ************************
  parameter Modelica.SIunits.Power Pmax_heater = 1000 "maximal power output heater" annotation(Dialog(group = "Energy system", descriptionLabel = true));
  parameter Modelica.SIunits.Temperature Tset_heater = 294.15 "set temperature for heating" annotation(Dialog(group = "Energy system", descriptionLabel = true));
  parameter Modelica.SIunits.Temperature Tout_isHeatOn = 288.15 "Touside under which heating is on" annotation(Dialog(group = "Energy system", descriptionLabel = true));
  parameter Modelica.SIunits.Temperature Tset_chiller = 297.15 "set temperature for cooling" annotation(Dialog(group = "Energy system", descriptionLabel = true));
  parameter Modelica.SIunits.Power Pmax_chiller = 1000 "maximal power output chiller" annotation(Dialog(group = "Energy system", descriptionLabel = true));

  //**************************P R O F I L E S ************************
  parameter AixLib.DataBase.Profiles.ProfileBaseDataDefinition schedulePersons =  AixLib.DataBase.Profiles.NineToFive() "Schedule for persons"  annotation (Dialog(group="Boundary conditions", descriptionLabel=true));
  parameter AixLib.DataBase.Profiles.ProfileBaseDataDefinition scheduleLights =  AixLib.DataBase.Profiles.NineToFive() "Schedule for lights" annotation (Dialog(group="Boundary conditions", descriptionLabel=true));
  parameter AixLib.DataBase.Profiles.ProfileBaseDataDefinition scheduleElAppliances =  AixLib.DataBase.Profiles.NineToFive() "Schedule for electrical appliances" annotation (Dialog(group="Boundary conditions", descriptionLabel=true));
  parameter AixLib.DataBase.Profiles.ProfileBaseDataDefinition scheduleHVAC_heating =  AixLib.DataBase.Profiles.NineToFive() "Schedule for HVAC heating" annotation (Dialog(group="Boundary conditions", descriptionLabel=true));
  parameter AixLib.DataBase.Profiles.ProfileBaseDataDefinition scheduleHVAC_cooling =  AixLib.DataBase.Profiles.NineToFive() "Schedule for HVAC cooling" annotation (Dialog(group="Boundary conditions", descriptionLabel=true));
  parameter AixLib.DataBase.Profiles.ProfileBaseDataDefinition scheduleMechVent =  AixLib.DataBase.Profiles.NineToFive() "Schedule for mechanical ventilation" annotation (Dialog(group="Boundary conditions", descriptionLabel=true));





  //  * * * * * * * * * * A  D  V  A  N  C  E  D * * * * * * * * * * * *
  //**************************E N V E L O P E ************************
  // Outer walls properties
  parameter Real solar_absorptance_OW=0.25 "Solar absoptance outer walls "
    annotation (Dialog(tab = "Advanced", group="Envelope", descriptionLabel=true));

  parameter Integer ModelConvOW=1 "Heat Convection Model" annotation (Dialog(
      tab = "Advanced", group="Envelope",
      compact=true,
      descriptionLabel=true), choices(
      choice=1 "DIN 6946",
      choice=2 "ASHRAE Fundamentals",
      choice=3 "Custom alpha",
      radioButtons=true));

  // Infiltration rate
  parameter Real n50(unit="h-1") = 3 "Air exchange rate at 50 Pa pressure differencefor infiltration "
    annotation (Dialog(tab = "Advanced", group="Envelope"));
  parameter Real e=0.02 "Coefficient of windshield for infiltration"
    annotation (Dialog(tab = "Advanced", group="Envelope"));
  parameter Real eps=1.0 "Coefficient of height for infiltration"
    annotation (Dialog(tab = "Advanced", group="Envelope"));
    // Sunblind
  parameter Boolean use_sunblind = false
    "Will sunblind become active automatically?"
    annotation(Dialog(tab = "Advanced", group="Envelope"));
  parameter Real ratioSunblind(min=0.0, max=1.0) = 0.8
    "Sunblind factor. 1 means total blocking of irradiation, 0 no sunblind"
    annotation(Dialog(tab = "Advanced", group="Envelope"));
  parameter Modelica.SIunits.Irradiance solIrrThreshold(min=0.0) = 350
    "Threshold for global solar irradiation on this surface to enable sunblinding (see also TOutAirLimit)"
    annotation(Dialog(tab = "Advanced", group="Envelope"));
  parameter Modelica.SIunits.Temperature TOutAirLimit = 293.15
    "Temperature at which sunblind closes (see also solIrrThreshold)"
    annotation(Dialog(tab = "Advanced", group="Envelope"));

         // Heat bridge
  parameter Boolean withHeatBridge = false "Choose if heat bridges should be considered or not" annotation(Dialog(tab = "Advanced", group = "Envelope", enable= outside, compact = false));
  parameter Modelica.SIunits.ThermalConductivity psiHor = 5 "Horizontal heat bridge coefficient" annotation(Dialog(tab = "Advanced", group = "Envelope", enable = withHeatBridge));
  parameter Modelica.SIunits.ThermalConductivity psiVer = 5 "Horizontal heat bridge coefficient" annotation(Dialog(tab = "Advanced", group = "Envelope", enable = withHeatBridge));

  //**************************I N T E R N A L  G A I N S ************************
  // persons
  parameter Real RatioConvectiveHeat_persons = 0.5
  "Ratio of convective heat from overall heat output for persons"                                        annotation(Dialog(tab = "Advanced", group="Internal gains", descriptionLabel = true));
  //lights
  parameter Real coeffThermal_lights = 0.9 "coeff = Pth/Pel for lights" annotation(Dialog(tab = "Advanced", group="Internal gains",descriptionLabel = true));
  parameter Real coeffRadThermal_lights = 0.89 "coeff = Pth,rad/Pth for lights" annotation(Dialog(tab = "Advanced", group="Internal gains",descriptionLabel = true));
  //electrical appliances
  parameter Real coeffThermal_elApp = 0.5 "coeff = Pth/Pel for el. appliances" annotation(Dialog(tab = "Advanced", group="Internal gains",descriptionLabel = true));
  parameter Real coeffRadThermal_elApp = 0.78 "coeff = Pth,rad/Pth for el. appliances" annotation(Dialog(tab = "Advanced", group="Internal gains", descriptionLabel = true));

    //**************************E N E R G Y   S Y S T E M ************************
  parameter Boolean isEl_heater = true "is heater electrical? (heat pump)" annotation(Dialog(tab = "Advanced", group = "Energy system", descriptionLabel = true));
  parameter Boolean isEl_cooler = true "is chiller electrical (chiller)"  annotation(Dialog(tab = "Advanced", group = "Energy system", descriptionLabel = true));
  parameter Real etaEl_heater = 2.5 "electrical efficiency of heater" annotation(Dialog(tab = "Advanced", group = "Energy system", descriptionLabel = true, enable = isEl_heater));
  parameter Real etaEl_cooler = 3.0 "electrical efficiency of chiller" annotation(Dialog(tab = "Advanced", group = "Energy system", descriptionLabel = true, enable = isEl_heater));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li><i>April, 2019&nbsp;</i> by Ana Constantin:<br>First implementation</li>
</ul>
</html>"));
end Parameters;
