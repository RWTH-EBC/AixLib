within AixLib.Systems.Benchmark.Model.Generation;
package BaseClasses "Base class package"
  extends Modelica.Icons.BasesPackage;
  expandable connector HighTemperatureSystemBus
    "Data bus for high temperature circuit"
    extends Modelica.Icons.SignalBus;
    import SI = Modelica.SIunits;
    HydraulicModules.BaseClasses.HydraulicBus pumpBoilerBus "Hydraulic circuit of the boiler";
    HydraulicModules.BaseClasses.HydraulicBus pumpChpBus "Hydraulic circuit of the chp";
    Real uRelBoilerSet "Set value for relative power of boiler 1 [0..1]";
    Real fuelPowerBoilerMea "Fuel consumption of boiler 1 [0..1]";
    Real TChpSet "Set temperature for chp";
    Boolean onOffChpSet "On off set point for chp";
    Real fuelPowerChpMea "Fuel consumption of chp [0..1]";
    Real thermalPowerChpMea "Thermal power of chp [0..1]";
    Real electricalPowerChpMea "Electrical power consumption of chp [0..1]";
    SI.Temperature T_in "Inflow temperature";
    SI.Temperature T_out "Inflow temperature";
    annotation (
      Icon(graphics,
           coordinateSystem(preserveAspectRatio=false)),
      Diagram(graphics,
              coordinateSystem(preserveAspectRatio=false)),
      Documentation(info="<html>
<p>Definition of a bus connector for the ERC Heatpump System.</p>
</html>",   revisions="<html>
<ul>
<li>October 25, 2017, by Alexander K&uuml;mpel:<br/>Adaption for hydraulic modules in AixLib.</li>
<li>February 6, 2016, by Peter Matthes:<br/>First implementation. </li>
</ul>
</html>"));
  end HighTemperatureSystemBus;

  expandable connector TabsBus "Data bus for concrete cora activation"
    extends Modelica.Icons.SignalBus;
    import SI = Modelica.SIunits;
    HydraulicModules.BaseClasses.HydraulicBus admixBus "Hydraulic circuit of the boiler";
    Real valSet(min=0, max=1) "Valve opening (0: ports_a1, 1: port_a2)";
    Real valSetAct(min=0, max=1) "Actual valve opening (0: ports_a1, 1: port_a2)";
    annotation (
      Icon(graphics,
           coordinateSystem(preserveAspectRatio=false)),
      Diagram(graphics,
              coordinateSystem(preserveAspectRatio=false)),
      Documentation(info="<html>
<p>Definition of a bus connector for the ERC Heatpump System.</p>
</html>",   revisions="<html>
<ul>
<li>October 25, 2017, by Alexander K&uuml;mpel:<br/>Adaption for hydraulic modules in AixLib.</li>
<li>February 6, 2016, by Peter Matthes:<br/>First implementation. </li>
</ul>
</html>"));
  end TabsBus;
end BaseClasses;
