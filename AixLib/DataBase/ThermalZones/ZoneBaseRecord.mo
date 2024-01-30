within AixLib.DataBase.ThermalZones;
record ZoneBaseRecord "Base record definition for zone records"
  extends Modelica.Icons.Record;

  parameter Modelica.Units.SI.Temperature T_start "Initial temperature";
  parameter Boolean withAirCap = true "Consider capacity of indoor air";
  parameter Modelica.Units.SI.Volume VAir "Air volume of the zone";
  parameter Modelica.Units.SI.Area AZone "Net floor area of zone";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hRad
    "Coefficient of heat transfer for linearized radiation exchange between walls";
  parameter Modelica.Units.SI.Angle lat "Latitude of zone location";
  parameter Integer nOrientations(min=1) "Number of orientations";

  parameter Modelica.Units.SI.Area AWin[nOrientations]
    "Areas of windows by orientations";
  parameter Modelica.Units.SI.Area ATransparent[nOrientations]
    "Areas of transparent (solar radiation transmittend) elements by orientations";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConWin
    "Convective coefficient of heat transfer of windows (indoor)";
  parameter Modelica.Units.SI.ThermalResistance RWin "Resistor for windows";
  parameter Modelica.Units.SI.TransmissionCoefficient gWin
    "Total energy transmittance of windows";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer UWin
    "Thermal transmission coefficient of windows";
  parameter Real ratioWinConRad
    "Ratio for windows between convective and radiative heat emission";
  parameter Modelica.Units.SI.Area AExt[nOrientations]
    "Areas of exterior walls by orientations";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConExt
    "Convective coefficient of heat transfer for exterior walls (indoor)";
  parameter Integer nExt(min=1) "Number of RC-elements of exterior walls";
  parameter Modelica.Units.SI.ThermalResistance RExt[nExt]
    "Resistances of exterior walls, from inside to outside";
  parameter Modelica.Units.SI.ThermalResistance RExtRem
    "Resistance of remaining resistor RExtRem between capacity n and outside";
  parameter Modelica.Units.SI.HeatCapacity CExt[nExt]
    "Heat capacities of exterior walls, from inside to outside";
  parameter Modelica.Units.SI.Area AInt "Area of interior walls";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConInt
    "Convective coefficient of heat transfer of interior walls (indoor)";
  parameter Integer nInt(min=1) "Number of RC-elements of interior walls";
  parameter Modelica.Units.SI.ThermalResistance RInt[nInt]
    "Resistances of interior wall, from port to center";
  parameter Modelica.Units.SI.HeatCapacity CInt[nInt]
    "Heat capacities of interior walls, from port to center";
  parameter Modelica.Units.SI.Area AFloor "Area of floor plate";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConFloor
    "Convective coefficient of heat transfer of floor plate (indoor)";
  parameter Integer nFloor(min=1) "Number of RC-elements of floor plate";
  parameter Modelica.Units.SI.ThermalResistance RFloor[nFloor]
    "Resistances of floor plate, from inside to outside";
  parameter Modelica.Units.SI.ThermalResistance RFloorRem
    "Resistance of remaining resistor RFloorRem between capacity n and outside";
  parameter Modelica.Units.SI.HeatCapacity CFloor[nFloor]
    "Heat capacities of floor plate, from inside to outside";
  parameter Modelica.Units.SI.Area ARoof "Area of roof";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConRoof
    "Convective coefficient of heat transfer of roof (indoor)";
  parameter Integer nRoof(min=1) "Number of RC-elements of roof";
  parameter Modelica.Units.SI.ThermalResistance RRoof[nRoof]
    "Resistances of roof, from inside to outside";
  parameter Modelica.Units.SI.ThermalResistance RRoofRem
    "Resistance of remaining resistor RRoofRem between capacity n and outside";
  parameter Modelica.Units.SI.HeatCapacity CRoof[nRoof]
    "Heat capacities of roof, from inside to outside";
  parameter Integer nOrientationsRoof(min=1) "Number of orientations for roof";
  parameter Modelica.Units.SI.Angle tiltRoof[nOrientationsRoof] "Tilts of roof";
  parameter Modelica.Units.SI.Angle aziRoof[nOrientationsRoof]
    "Azimuths of roof";
  parameter Real wfRoof[nOrientationsRoof]
    "Weight factors of the roof";
  parameter Modelica.Units.SI.Emissivity aRoof
    "Coefficient of absorption of roof (outdoor)";

  parameter Modelica.Units.SI.Emissivity aExt
    "Coefficient of absorption of exterior walls (outdoor)";
  parameter Modelica.Units.SI.Temperature TSoil "Temperature of soil";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConWallOut
    "Exterior walls convective coefficient of heat transfer (outdoor)";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hRadWall
    "Coefficient of heat transfer for linearized radiation for exterior walls";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConWinOut
    "Windows' convective coefficient of heat transfer (outdoor)";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConRoofOut
    "Roof's convective coefficient of heat transfer (outdoor)";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hRadRoof
    "Coefficient of heat transfer for linearized radiation for roof";
  parameter Modelica.Units.SI.Angle tiltExtWalls[nOrientations]
    "Tilts of exterior walls";
  parameter Modelica.Units.SI.Angle aziExtWalls[nOrientations]
    "Azimuths of exterior walls";
  parameter Real wfWall[nOrientations]
    "Weight factors of the walls";
  parameter Real wfWin[nOrientations]
    "Weight factors of the windows";
  parameter Real wfGro
    "Weight factor of the ground";
  parameter Real specificPeople "people per squaremeter";
  parameter Real activityDegree "acitivity degree of people in met";
  parameter Modelica.Units.SI.HeatFlowRate fixedHeatFlowRatePersons "Area specific heatflowrate by persons in case of temperature independent
    calculation";
  parameter Real ratioConvectiveHeatPeople
    "Ratio of convective heat from overall heat output for people";
  parameter Real internalGainsMoistureNoPeople
    "internal moisture production of plants, etc. except from people in g/(h m²)";
  parameter Real internalGainsMachinesSpecific "Heat Flux of machines";
  parameter Real ratioConvectiveHeatMachines
    "Ratio of convective heat from overall heat output for machines";
  parameter Modelica.Units.SI.HeatFlux lightingPowerSpecific
    "Heat flux of lighting";
  parameter Real ratioConvectiveHeatLighting
    "Ratio of convective heat from overall heat output for lights";
  parameter Boolean useConstantACHrate
    "Choose if a constant infiltration rate is used";
  parameter Real baseACH "Base ACH rate for ventilation controller";
  parameter Real maxUserACH "Additional ACH value for max. user activity";
  parameter Real maxOverheatingACH[2]
    "Additional ACH value when overheating appears, transition range";
  parameter Real maxSummerACH[3]
    "Additional ACH in summer, Tmin, Tmax";
  parameter Real winterReduction[3]
    "Reduction factor of userACH for cold weather";
  parameter Boolean withAHU
    "Zone is connected to central air handling unit";
  parameter Real minAHU(unit = "m3/(h.m2)")
    "Minimum specific air flow supplied by the AHU";
  parameter Real maxAHU(unit = "m3/(h.m2)")
    "Maximum specific air flow supplied by the AHU";
  parameter Real shadingFactor[nOrientations] "Fc-Value: Factor representing how much of the actual solar irradiation goes through the sunblind and enters the window element, for the case, that the sunblind is activated. Defaults to 1, i.e. no shading is active. External sunblinds.";
  parameter Real maxIrr[nOrientations](unit = "W/m2") "Threshold value above which the sunblind (external) becomes active for the whole zone. Threshold regards to the incoming irradiation level with the window direction. This value does not account for heat flux due to the outside temperature.";
  parameter Real hHeat "Upper limit controller output";
  parameter Real lHeat "Lower limit controller output";
  parameter Real KRHeat "Gain of the controller";
  parameter Modelica.Units.SI.Time TNHeat "Time constant of the controller";
  parameter Boolean HeaterOn "Use heater component";
  parameter Real hCool "Upper limit controller output";
  parameter Real lCool "Lower limit controller output";
  parameter Real KRCool "Gain of the controller";
  parameter Modelica.Units.SI.Time TNCool "Time constant of the controller";
  parameter Boolean CoolerOn "Use chiller component";
  parameter Modelica.Units.SI.Temperature TThresholdHeater
    "Threshold temperature below ideal heater is used";
  parameter Modelica.Units.SI.Temperature TThresholdCooler
    "Threshold temperature above ideal cooler is used";
  parameter Boolean withIdealThresholds
    "Sets if the threshold temperatures for ideal heater and cooler should
        be used";
  annotation(Documentation(info="<html><p>
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
