within AixLib.Systems.Benchmark.Model.Generation;
package BaseClasses "Base class package"
  extends Modelica.Icons.BasesPackage;
  expandable connector HighTempSysBus
    "Data bus for high temperature system"
    extends Modelica.Icons.SignalBus;
    import SI = Modelica.SIunits;
    HydraulicModules.BaseClasses.HydraulicBus pumpCHPBus;
    HydraulicModules.BaseClasses.HydraulicBus pumpBoilerBus;
    SI.Temperature Tset_boiler(min=0, max=1) "Set temperature of boiler";
    SI.Temperature Tset_chp(min=0, max=1) "Set tmeperature of chp";

    annotation (
      Icon(graphics,
           coordinateSystem(preserveAspectRatio=false)),
      Diagram(graphics,
              coordinateSystem(preserveAspectRatio=false)),
      Documentation(info="<html>
<p>Definition of a standard bus connector for hydraulic modules. A module bus should contain all the information that is necessary to exchange within a particular module type. </p>
</html>",   revisions="<html>
<ul>
<li>October 25, 2017, by Alexander K&uuml;mpel:<br/>Adaption for hydraulic modules in AixLib.</li>
<li>February 6, 2016, by Peter Matthes:<br/>First implementation. </li>
</ul>
</html>"));
  end HighTempSysBus;
end BaseClasses;
