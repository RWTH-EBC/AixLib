within AixLib.Systems.ModularAHU.BaseClasses;
expandable connector GenericAHUBus
  "Data bus for generic air-handling unit"
  extends Modelica.Icons.SignalBus;
  import SI = Modelica.SIunits;
  Systems.ModularAHU.BaseClasses.RegisterBus preheaterBus;
  Systems.ModularAHU.BaseClasses.RegisterBus coolerBus;
  Systems.ModularAHU.BaseClasses.RegisterBus heaterBus;
  SI.Temperature TOutsAirMea "Outside air temperature";
  SI.Temperature TSupAirMea "Supply air temperature";
  SI.Temperature TRetAirMea "Return air temperature";
  SI.Temperature TExhAirMea "Exhaust air temperature";
  SI.VolumeFlowRate  V_flow_RetAirMea  "Return air volume flow";
  Real dpFanRetSet "Set pressure difference for fan in return air canal";
  Real dpFanRetMea "Measured pressure difference for fan in return air canal";
  Real powerFanRetMea "Power of fan in return air canal";
  Real dpFanSupSet "Set pressure difference for fan in supply air canal";
  Real dpFanSupMea "Measured pressure difference for fan in supply air canal";
  Real powerFanSupMea "Power of fan in supply air canal";
  Real flapRetSet(start=1) "Flap opening of flap in return air canal [0..1]";
  Real flapRetMea "Actual flap opening of flap in return air canal";
  Real flapSupSet(start=1) "Flap opening of flap in supply air canal [0..1]";
  Real flapSupMea "Actual flap opening of flap in supply air canal";
  Real bypassHrsSet "Flap opening of bypass of heat recovery system [0..1]";
  Real bypassHrsMea "Actual flap opening of bypass of heat recovery system";
  Real steamHumSet "Set value for steam humidifier [0..1]";
  Real powerSteamHumMea "Consumed power of steam humidifier [0..1]";
  Real adiabHumSet "Set value for adiabatic humidifier [0..1]";
  Real relHumSupMea "Relative humidity of supply air";
  Real relHumRetMea "Relative humidity of return air";
  annotation (
    Icon(graphics,
         coordinateSystem(preserveAspectRatio=false)),
    Diagram(graphics,
            coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Definition of a standard bus connector for ahu register modules. The bus connector includes the <a href=\"modelica://AixLib/Systems/HydraulicModules/BaseClasses/HydraulicBus.mo\">HydraulicBus</a>.</p>
</html>", revisions="<html>
<ul>
<li>January 23, 2018, by Alexander Kümpel:<br/>First implementation. </li>
</ul>
</html>"));
end GenericAHUBus;
