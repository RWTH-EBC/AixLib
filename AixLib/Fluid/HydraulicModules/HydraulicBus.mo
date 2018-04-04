within AixLib.Fluid.HydraulicModules;
expandable connector HydraulicBus "Data bus for hydraulic circuits"
  extends Modelica.Icons.SignalBus;
  import SI = Modelica.SIunits;
  Real rpm_Input "Pump speed"
    annotation (HideResult=false);
  SI.Power P "Electrical pump power" annotation (HideResult=false);
  Real valveSet "Opening valve 0..1";
  SI.Temperature Tambient "Ambient temperature";
  SI.Temperature TfwrdIn "Flow Temperature into forward line";
  SI.Temperature TfwrdOut "Flow Temperature out of forward line";
  SI.Temperature TrtrnIn "Temperature into return line";
  SI.Temperature TrtrnOut "Temperature out of return line";
  annotation (
    Icon(graphics,
         coordinateSystem(preserveAspectRatio=false)),
    Diagram(graphics,
            coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
Definition of a standard module bus for use with the Zugabe library. A module 
bus should contain all the information that is necessary to exchange within a 
particular module type.
</p>
</html>", revisions="<html>
<ul>
<li>October 25, 2017, by Alexander K&uuml;mpel:<br/>Adaption for hydraulic modules in AixLib.</li>
<li>February 6, 2016, by Peter Matthes:<br/>First implementation. </li>
</ul>
</html>"));
end HydraulicBus;
