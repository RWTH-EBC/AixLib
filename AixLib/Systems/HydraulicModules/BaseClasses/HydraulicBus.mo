within AixLib.Systems.HydraulicModules.BaseClasses;
expandable connector HydraulicBus "Data bus for hydraulic circuits"
  extends Modelica.Icons.SignalBus;
  import SI = Modelica.SIunits;
  PumpBus pumpBus;
  Real valSet(min=0, max=1) "Valve opening 0..1";
  Real valSetAct(min=0, max=1) "Actual valve opening 0..1";
  SI.Temperature TFwrd_in "Flow Temperature into forward line";
  SI.Temperature TFwrd_out "Flow Temperature out of forward line";
  SI.Temperature TRtrn_in "Temperature into return line";
  SI.Temperature TRtrn_out "Temperature out of return line";
  SI.VolumeFlowRate  VF_in  "Volume flow into forward line";
  SI.VolumeFlowRate  VF_out  "Volume flow out of forward line";
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
end HydraulicBus;
