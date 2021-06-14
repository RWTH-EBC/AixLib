within AixLib.Systems.EONERC_MainBuilding.BaseClasses;
expandable connector HeatpumpAndConsumerControllerBus
  "Data bus for heat pump and Consumer Bus"
  extends Modelica.Icons.SignalBus;
  import SI = Modelica.SIunits;
  Real pElHp(min=0, max=51) "HeatPumpPower in kW";
  Real mfSetHpEva(min=0, max=10.72) "Mass Flow Heat Pump Evaporator Side in kg/s";
  Real mfSetHpCon(min=0, max=16) "Mass Flow Heat Pump Condensor Side in kg/s";
  Real mfSetCsIn(min=0,max=80) "Mass Flow Cold Storage In in kg/s";
  Real mfSetReCool(min=0,max=16) "Mass Flow Recooler in kg/s";
  Real mfSetFreeCool(min=0,max=80) "Mass Flow Freecooler in kg/s";
  Real mfSetLTC(min=0,max=20) "Mass Flow Low Temperature Consumer in kg/s";
  Real mfSetCold1(min=0,max=40) "Mass Flow Cold Consumer1 in kg/s";
  Real mfSetCold2(min=0,max=40) "Mass Flow Cold Consumer2 in kg/s";
  Real tAmb(min=260,max=330)    "Ambient Temperatur in K";


  annotation (
    Icon(graphics,
         coordinateSystem(preserveAspectRatio=false)),
    Diagram(graphics,
            coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Definition of a standard bus connector for hydraulic modules. A module bus should contain all the information that is necessary to exchange within a particular module type. </p>
</html>", revisions="<html>
<ul>
<li>October 25, 2017, by Alexander K&uuml;mpel:<br/>Adaption for hydraulic modules in AixLib.</li>
<li>February 6, 2016, by Peter Matthes:<br/>First implementation. </li>
</ul>
</html>"));
end HeatpumpAndConsumerControllerBus;
