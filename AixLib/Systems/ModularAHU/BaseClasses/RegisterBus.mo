within AixLib.Systems.ModularAHU.BaseClasses;
expandable connector RegisterBus "Data bus for modular ahu registers"
  extends Modelica.Icons.SignalBus;
  import SI = Modelica.SIunits;
  Systems.HydraulicModules.BaseClasses.HydraulicBus hydraulicBus;
  SI.Temperature TAirInMea "Inlet air temperature";
  SI.Temperature TAirOutMea "Outlet air temperatur";
  SI.VolumeFlowRate  VFlowAirMea  "Air volume flow";
  annotation (
    Icon(graphics,
         coordinateSystem(preserveAspectRatio=false)),
    Diagram(graphics,
            coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  Definition of a standard bus connector for ahu register modules. The
  bus connector includes the <a href=
  \"modelica://AixLib/Systems/HydraulicModules/BaseClasses/HydraulicBus.mo\">
  HydraulicBus</a>.
</p>
<ul>
  <li>January 23, 2018, by Alexander Kümpel:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end RegisterBus;
