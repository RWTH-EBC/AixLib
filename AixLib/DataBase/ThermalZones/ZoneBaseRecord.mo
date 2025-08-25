within AixLib.DataBase.ThermalZones;
record ZoneBaseRecord "Base record definition for zone records"
  extends Modelica.Icons.Record;

  // General
  // Thermal Zone
  parameter Boolean withAirCap = true "Consider capacity of indoor air" annotation(Dialog(group="Thermal Zone"));
  parameter Modelica.Units.SI.Volume VAir "Air volume of the zone" annotation(Dialog(group="Thermal Zone"));
  parameter Modelica.Units.SI.Area AZone "Net floor area of zone" annotation(Dialog(group="Thermal Zone"));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hRad
    "Coefficient of heat transfer for linearized radiation exchange between walls" annotation(Dialog(group="Thermal Zone"));
  parameter Modelica.Units.SI.Angle lat "Latitude of zone location" annotation(Dialog(group="Thermal Zone"));
  parameter Integer nOrientations(min=1) "Number of total facades with different
   combination of tilt and orientation" annotation(Dialog(group="Thermal Zone"));
  parameter Integer zoneInd=1
    "Index of this zone in the multizone (starting at 1)" annotation(Dialog(group="Thermal Zone"));
  parameter Modelica.Units.SI.ThermalConductance heaLoadFacOut "Factor for heat load calculation (part 1) , needs to be multiplied with (indoor set temperature - nominal outside temperature)" annotation(Dialog(group="Thermal Zone"));
  parameter Modelica.Units.SI.ThermalConductance heaLoadFacGrd "Factor for heat load calculation, (part 2), needs to be multiplied with (indoor set temperature - nominal ground temperature)" annotation(Dialog(group="Thermal Zone"));

  // Windows
  parameter Modelica.Units.SI.Area AWin[nOrientations]
    "Areas of windows by orientations" annotation(Dialog(group="Windows"));
  parameter Modelica.Units.SI.Area ATransparent[nOrientations]
    "Areas of transparent (solar radiation transmittend) elements by orientations" annotation(Dialog(group="Windows", enable=integer(AWin)>0));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConWin
    "Convective coefficient of heat transfer of windows (indoor)" annotation(Dialog(group="Windows", enable=integer(AWin)>0));
  parameter Modelica.Units.SI.ThermalResistance RWin "Resistor for windows" annotation(Dialog(group="Windows", enable=integer(AWin)>0));
  parameter Modelica.Units.SI.TransmissionCoefficient gWin
    "Total energy transmittance of windows" annotation(Dialog(group="Windows", enable=integer(AWin)>0));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer UWin
    "Thermal transmission coefficient of windows" annotation(Dialog(group="Windows", enable=integer(AWin)>0));
  parameter Real ratioWinConRad
    "Ratio for windows between convective and radiative heat emission" annotation(Dialog(group="Windows", enable=integer(AWin)>0));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConWinOut
    "Windows' convective coefficient of heat transfer (outdoor)" annotation(Dialog(group="Windows", enable=integer(AWin)>0));
  parameter Real wfWin[nOrientations]
    "Weight factors of the windows" annotation(Dialog(group="Windows", enable=integer(AWin)>0));

  // Exterior Walls
  parameter Modelica.Units.SI.Area AExt[nOrientations]
    "Areas of exterior walls by orientations" annotation(Dialog(group="Exterior Walls"));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConExt
    "Convective coefficient of heat transfer for exterior walls (indoor)" annotation(Dialog(group="Exterior Walls", enable=integer(AExt)>0));
  parameter Integer nExt(min=1) "Number of RC-elements of exterior walls" annotation(Dialog(group="Exterior Walls", enable=integer(AExt)>0));
  parameter Modelica.Units.SI.ThermalResistance RExt[nExt]
    "Resistances of exterior walls, from inside to outside" annotation(Dialog(group="Exterior Walls", enable=integer(AExt)>0));
  parameter Modelica.Units.SI.ThermalResistance RExtRem
    "Resistance of remaining resistor RExtRem between capacity n and outside" annotation(Dialog(group="Exterior Walls", enable=integer(AExt)>0));
  parameter Modelica.Units.SI.HeatCapacity CExt[nExt]
    "Heat capacities of exterior walls, from inside to outside" annotation(Dialog(group="Exterior Walls", enable=integer(AExt)>0));
  parameter Modelica.Units.SI.Emissivity aExt
    "Coefficient of absorption of exterior walls (outdoor)" annotation(Dialog(group="Exterior Walls", enable=integer(AExt)>0));
  parameter Modelica.Units.SI.Angle tiltExtWalls[nOrientations]
    "Tilts of exterior walls" annotation(Dialog(group="Exterior Walls", enable=integer(AExt)>0));
  parameter Modelica.Units.SI.Angle aziExtWalls[nOrientations]
    "Azimuths of exterior walls" annotation(Dialog(group="Exterior Walls", enable=integer(AExt)>0));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConWallOut
    "Exterior walls convective coefficient of heat transfer (outdoor)" annotation(Dialog(group="Exterior Walls", enable=integer(AExt)>0));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hRadWall
    "Coefficient of heat transfer for linearized radiation for exterior walls" annotation(Dialog(group="Exterior Walls", enable=integer(AExt)>0));
  parameter Real wfWall[nOrientations]
    "Weight factors of the exterior walls" annotation(Dialog(group="Exterior Walls", enable=integer(AExt)>0));

  // Interior Walls
  parameter Modelica.Units.SI.Area AInt "Area of interior walls" annotation(Dialog(group="Interior Walls"));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConInt
    "Convective coefficient of heat transfer of interior walls (indoor)" annotation(Dialog(group="Interior Walls", enable=integer(AInt)>0));
  parameter Integer nInt(min=1) "Number of RC-elements of interior walls" annotation(Dialog(group="Interior Walls", enable=integer(AInt)>0));
  parameter Modelica.Units.SI.ThermalResistance RInt[nInt]
    "Resistances of interior wall, from port to center" annotation(Dialog(group="Interior Walls", enable=integer(AInt)>0));
  parameter Modelica.Units.SI.HeatCapacity CInt[nInt]
    "Heat capacities of interior walls, from port to center" annotation(Dialog(group="Interior Walls", enable=integer(AInt)>0));

  // Floor Plate
  parameter Modelica.Units.SI.Area AFloor "Area of floor plate" annotation(Dialog(group="Floor Plate"));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConFloor
    "Convective coefficient of heat transfer of floor plate (indoor)" annotation(Dialog(group="Floor Plate", enable=integer(AFloor)>0));
  parameter Integer nFloor(min=1) "Number of RC-elements of floor plate" annotation(Dialog(group="Floor Plate", enable=integer(AFloor)>0));
  parameter Modelica.Units.SI.ThermalResistance RFloor[nFloor]
    "Resistances of floor plate, from inside to outside" annotation(Dialog(group="Floor Plate", enable=integer(AFloor)>0));
  parameter Modelica.Units.SI.ThermalResistance RFloorRem
    "Resistance of remaining resistor RFloorRem between capacity n and outside" annotation(Dialog(group="Floor Plate", enable=integer(AFloor)>0));
  parameter Modelica.Units.SI.HeatCapacity CFloor[nFloor]
    "Heat capacities of floor plate, from inside to outside" annotation(Dialog(group="Floor Plate", enable=integer(AFloor)>0));

  // Soil
  parameter Modelica.Units.SI.Temperature TSoil
    "Temperature of soil (used for outside surface temperature of floors and thermal radiation)" annotation(Dialog(group="Soil"));
  parameter AixLib.BoundaryConditions.GroundTemperature.DataSourceGroTem
    TSoiDatSou=AixLib.BoundaryConditions.GroundTemperature.DataSourceGroTem.Constant
    "choice for the data source of the outside surface temperature of floors" annotation(Dialog(group="Soil"));
  parameter Real TSoiOffTim=6004800
    "Time from simulation start to minimum soil temperature in s if sine model is chosen as TSoiDatSou" annotation(Dialog(group="Soil"));
  parameter Modelica.Units.SI.Temperature TSoiAmp=0
    "Amplitude of TSoil if sine model is chosen as TSoiDatSou" annotation(Dialog(group="Soil"));
  parameter String TSoiFil="NoName"
    "File with TSoil table if file is chosen as TSoiDatSou" annotation(Dialog(group="Soil"));
  parameter Real wfGro
    "Weight factor of the ground" annotation(Dialog(group="Soil"));

  // Roof
  parameter Modelica.Units.SI.Area ARoof "Area of roof" annotation(Dialog(group="Roof"));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConRoof
    "Convective coefficient of heat transfer of roof (indoor)" annotation(Dialog(group="Roof", enable=integer(ARoof)>0));
  parameter Integer nRoof(min=1) "Number of RC-elements of roof" annotation(Dialog(group="Roof", enable=integer(ARoof)>0));
  parameter Modelica.Units.SI.ThermalResistance RRoof[nRoof]
    "Resistances of roof, from inside to outside" annotation(Dialog(group="Roof", enable=integer(ARoof)>0));
  parameter Modelica.Units.SI.ThermalResistance RRoofRem
    "Resistance of remaining resistor RRoofRem between capacity n and outside" annotation(Dialog(group="Roof", enable=integer(ARoof)>0));
  parameter Modelica.Units.SI.HeatCapacity CRoof[nRoof]
    "Heat capacities of roof, from inside to outside" annotation(Dialog(group="Roof", enable=integer(ARoof)>0));
  parameter Integer nOrientationsRoof(min=1) "Number of orientations for roof" annotation(Dialog(group="Roof", enable=integer(ARoof)>0));
  parameter Modelica.Units.SI.Angle tiltRoof[nOrientationsRoof] "Tilts of roof" annotation(Dialog(group="Roof", enable=integer(ARoof)>0));
  parameter Modelica.Units.SI.Angle aziRoof[nOrientationsRoof]
    "Azimuths of roof" annotation(Dialog(group="Roof", enable=integer(ARoof)>0));
  parameter Real wfRoof[nOrientationsRoof]
    "Weight factors of the roof" annotation(Dialog(group="Roof", enable=integer(ARoof)>0));
  parameter Modelica.Units.SI.Emissivity aRoof
    "Coefficient of absorption of roof (outdoor)" annotation(Dialog(group="Roof", enable=integer(ARoof)>0));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConRoofOut
    "Roof's convective coefficient of heat transfer (outdoor)" annotation(Dialog(group="Roof", enable=integer(ARoof)>0));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hRadRoof
    "Coefficient of heat transfer for linearized radiation for roof" annotation(Dialog(group="Roof", enable=integer(ARoof)>0));

  // Connection to other zones
  parameter Integer nIze(min=1)=1 "Number of interzonal elements to consider" annotation(Dialog(group="Connection to other zones"));
  parameter Modelica.Units.SI.Area AIze[nIze]= {0.0} "Area of interzonal elements" annotation(Dialog(group="Connection to other zones"));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConIze[nIze]={0.0}
    "Convective coefficient of heat transfer of interzonal elements (indoor)" annotation(Dialog(group="Connection to other zones"));
  parameter Integer nIzeRC(min=1)=1
    "Number of RC-elements of interzonal elements" annotation(Dialog(group="Connection to other zones"));
  parameter Modelica.Units.SI.ThermalResistance RIze[nIze,nIzeRC]={{0.00001}}
    "Resistances of interzonal elements, from inside to outside" annotation(Dialog(group="Connection to other zones"));
  parameter Modelica.Units.SI.ThermalResistance RIzeRem[nIze]={0.00001}
    "Resistance of remaining resistor of interzonal elements between capacity nIzeRC and outside" annotation(Dialog(group="Connection to other zones"));
  parameter .Modelica.Units.SI.HeatCapacity CIze[nIze,nIzeRC]={{0.00001}}
    "Heat capacities of interzonal elements, from inside to outside" annotation(Dialog(group="Connection to other zones"));
  parameter Integer othZoneInd[nIze]={1}
    "Index of the zone in the multizone (starting at 1) to which each interzonal element is adjacent" annotation(Dialog(group="Connection to other zones"));

  // Gains
  // Internal Gains
  parameter Real specificPeople "people per squaremeter" annotation(Dialog(tab="Gains", group="Internal gains"));
  parameter Real activityDegree "acitivity degree of people in met" annotation(Dialog(tab="Gains", group="Internal gains"));
  parameter Modelica.Units.SI.HeatFlowRate fixedHeatFlowRatePersons "Area specific heatflowrate by persons in case of temperature independent
    calculation" annotation(Dialog(tab="Gains", group="Internal gains"));
  parameter Real ratioConvectiveHeatPeople
    "Ratio of convective heat from overall heat output for people" annotation(Dialog(tab="Gains", group="Internal gains"));
  parameter Real internalGainsMoistureNoPeople
    "internal moisture production of plants, etc. except from people in g/(h m²)" annotation(Dialog(tab="Gains", group="Internal gains"));
  parameter Real internalGainsMachinesSpecific "Heat Flux of machines" annotation(Dialog(tab="Gains", group="Internal gains"));
  parameter Real ratioConvectiveHeatMachines
    "Ratio of convective heat from overall heat output for machines" annotation(Dialog(tab="Gains", group="Internal gains"));
  parameter Modelica.Units.SI.HeatFlux lightingPowerSpecific
    "Heat flux of lighting" annotation(Dialog(tab="Gains", group="Internal gains"));
  parameter Real ratioConvectiveHeatLighting
    "Ratio of convective heat from overall heat output for lights" annotation(Dialog(tab="Gains", group="Internal gains"));

  // External Gains
  parameter Real shadingFactor[nOrientations]
  "Fc-Value: Factor representing how much of the actual solar irradiation goes through the sunblind and enters the window element, for the case, that the sunblind is activated. Defaults to 1, i.e. no shading is active. External sunblinds."
  annotation(Dialog(tab="Gains", group="External gains"));
  parameter Real maxIrr[nOrientations](unit="W/m2")
  "Threshold value above which the sunblind (external) becomes active for the whole zone. Threshold regards to the incoming irradiation level with the window direction. This value does not account for heat flux due to the outside temperature."
  annotation(Dialog(tab="Gains", group="External gains"));


  // Air Exchange
  parameter Boolean useConstantACHrate=false
    "Choose if a constant infiltration rate is used" annotation(Dialog(tab="Air exchange"));
  parameter Real baseACH "Base ACH rate for ventilation controller" annotation(Dialog(tab="Air exchange"));
  parameter Real maxUserACH "Additional ACH value for max. user activity" annotation(Dialog(tab="Air exchange", enable=useConstantACHrate==false));
  parameter Real maxOverheatingACH[2]
    "Additional ACH value when overheating appears, transition range" annotation(Dialog(tab="Air exchange", enable=useConstantACHrate==false));
  parameter Real maxSummerACH[3]
    "Additional ACH in summer, Tmin, Tmax" annotation(Dialog(tab="Air exchange", enable=useConstantACHrate==false));
  parameter Real winterReduction[3]
    "Reduction factor of userACH for cold weather";
  parameter Boolean withAHU
    "Zone is connected to central air handling unit";
  parameter Real minAHU(unit="m3/(h.m2)")
    "Minimum specific air flow supplied by the AHU";
  parameter Real maxAHU(unit="m3/(h.m2)")
    "Maximum specific air flow supplied by the AHU";

  // Heating
  parameter Real hHeat "Upper limit controller output";
  parameter Real lHeat "Lower limit controller output";
  parameter Real KRHeat "Gain of the controller";
  parameter Modelica.Units.SI.Time TNHeat "Time constant of the controller";
  parameter Boolean HeaterOn "Use heater component";
  parameter Modelica.Units.SI.Temperature TThresholdHeater
    "Threshold temperature below ideal heater is used" annotation(Dialog(tab="Energy Supply", group="Heating", enable=HeaterOn==true and withIdealThresholds==true));

  // Cooling
  parameter Boolean CoolerOn=true
                             "Use chiller component" annotation(Dialog(tab="Energy Supply", group="Cooling"));
  parameter Real hCool "Upper limit controller output" annotation(Dialog(tab="Energy Supply", group="Cooling", enable=CoolerOn==true));
  parameter Real lCool "Lower limit controller output" annotation(Dialog(tab="Energy Supply", group="Cooling", enable=CoolerOn==true));
  parameter Real KRCool "Gain of the controller" annotation(Dialog(tab="Energy Supply", group="Cooling", enable=CoolerOn==true));
  parameter Modelica.Units.SI.Time TNCool "Time constant of the controller" annotation(Dialog(tab="Energy Supply", group="Cooling", enable=CoolerOn==true));
  parameter Modelica.Units.SI.Temperature TThresholdCooler
    "Threshold temperature above ideal cooler is used" annotation(Dialog(tab="Energy Supply", group="Cooling", enable=CoolerOn==true and withIdealThresholds==true));

  // Heating & Cooling
  parameter Boolean withIdealThresholds=false
    "Sets if the threshold temperatures for ideal heater and cooler should be used";
  parameter Real traSysHeatK "Gain for PT1 for damped heating transfer";
  parameter Modelica.Units.SI.Time traSysHeatT
    "Time Constant for PT1 for damped heating transfer";
  parameter Real traSysCoolK "Gain for PT1 for damped cooling transfer";
  parameter Modelica.Units.SI.Time traSysCoolT
    "Time Constant for PT1 for damped cooling transfer";
  parameter Real traSysFraHeaRad "Fraction of heat transfer to radiation";
  parameter Real traSysFraCooRad "Fraction of cool transfer to radiation";

  // Initialization
  parameter Modelica.Units.SI.Temperature T_start "Initial temperature" annotation(Dialog(tab="Initialization"));
                                                                                     annotation(Documentation(info="<html><p>
        be used"),
              Documentation(info="<html><p>
  This is the base definition of zone records used in <a href=
  \"AixLib.ThermalZones.ReducedOrder.ThermalZone\">AixLib.ThermalZones.ReducedOrder.ThermalZone</a>.
  It aggregates all parameters at one record to enhance usability,
  exchanging entire datasets and automatic generation of these
  datasets.
</p>
<h4>
  References
</h4>
<p>
  For automatic generation of thermal zone and multizone models as well
  as for datasets, see <a href=
  \"https://github.com/RWTH-EBC/TEASER\">https://github.com/RWTH-EBC/TEASER</a>
</p>
<ul>
  <li>May 5, 2023, by Philip Groesdonk:<br/>
    Additional soil temperature and neighboured zone border parameters.
  </li>
  <li>November 27, 2019, by David Jansen:<br/>
    Integrate threshold for heater and cooler.
  </li>
  <li>July 10, 2019, by David Jansen:<br/>
    Adds specificPeople (persons per squaremetre). Adds activityDegree.
  </li>
  <li>September 27, 2016, by Moritz Lauster:<br/>
    Reimplementation.
  </li>
  <li>January 4, 2016, by Moritz Lauster:<br/>
    Clean up.
  </li>
  <li>June, 2015, by Moritz Lauster:<br/>
    Added new parameters to use further calculation cores.
  </li>
  <li>February 4, 2014, by Ole Odendahl:<br/>
    Added new parameters for the setup of the ACH. It is now possible
    to assign different values to the ACH for each zone based on this
    record.
  </li>
  <li>January 27, 2014, by Ole Odendahl:<br/>
    Added new parameter withAHU to choose whether the zone is connected
    to a central air handling unit. Default is false.
  </li>
  <li>November, 2012, by Moritz Lauster:<br/>
    Restored links
  </li>
  <li>March, 2012, by Peter Matthes:<br/>
    Implemented
  </li>
</ul>
</html>"));


end ZoneBaseRecord;
