within AixLib.Systems.HydraulicModules.BaseClasses;
expandable connector HydraulicBus "Data bus for hydraulic circuits"
  extends Modelica.Icons.SignalBus;
  import SI = Modelica.SIunits;
  AixLib.Fluid.Movers.PumpsPolynomialBased.BaseClasses.PumpBus
    pumpBus;
  Real valveSet(min=0, max=1) "Valve opening setpoint 0..1";
  Real valveMea(min=0, max=1) "Actual valve opening 0..1";
  SI.Temperature TFwrdInMea "Flow Temperature into forward line";
  SI.Temperature TFwrdOutMea "Flow Temperature out of forward line";
  SI.Temperature TRtrnInMea "Temperature into return line";
  SI.Temperature TRtrnOutMea "Temperature out of return line";
  SI.VolumeFlowRate VFlowInMea "Volume flow into forward line";
  SI.VolumeFlowRate VFlowOutMea "Volume flow out of forward line";
  annotation (
    Icon(graphics, coordinateSystem(preserveAspectRatio=false)),
    Diagram(graphics, coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  Definition of a standard bus connector for hydraulic modules. A
  module bus should contain all the information that is necessary to
  exchange within a particular module type.
</p>
<ul>
  <li>January 09, 2020, by Alexander Kümpel:<br/>
    Variables renamed.
  </li>
  <li>October 25, 2017, by Alexander Kümpel:<br/>
    Adaption for hydraulic modules in AixLib.
  </li>
  <li>February 6, 2016, by Peter Matthes:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end HydraulicBus;
