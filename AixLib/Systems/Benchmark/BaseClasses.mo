within AixLib.Systems.Benchmark;
package BaseClasses "Base class package"
  extends Modelica.Icons.BasesPackage;
  expandable connector HighTempSystemBus
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
  end HighTempSystemBus;

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

  expandable connector MainBus
    "Data bus for E.ON ERC main building system"
    extends Modelica.Icons.SignalBus;
    import SI = Modelica.SIunits;
    EONERC_MainBuilding.BaseClasses.HeatPumpSystemBus hpSystemBus
      "Heat pump system bus";
    EONERC_MainBuilding.BaseClasses.SwitchingUnitBus swuBus "Switching unit bus";
    HighTempSystemBus htsBus
      "High temoerature system bus";
    EONERC_MainBuilding.BaseClasses.TwoCircuitBus gtfBus "Geothermalfield bus";
    EONERC_MainBuilding.BaseClasses.TwoCircuitBus hxBus
      "Heat exchanger system bus";
    TabsBus tabs1Bus "Bus for concrete core activation 1";
    TabsBus tabs2Bus "Bus for concrete core activation 2";
    TabsBus tabs3Bus "Bus for concrete core activation 3";
    TabsBus tabs4Bus "Bus for concrete core activation 4";
    TabsBus tabs5Bus "Bus for concrete core activation 5";
    ModularAHU.BaseClasses.GenericAHUBus ahuBus "Bus for AHU";
    ModularAHU.BaseClasses.GenericAHUBus vu1Bus "Ventilation unit 1";
    ModularAHU.BaseClasses.GenericAHUBus vu2Bus "Ventilation unit 2";
    ModularAHU.BaseClasses.GenericAHUBus vu3Bus "Ventilation unit 3";
    ModularAHU.BaseClasses.GenericAHUBus vu4Bus "Ventilation unit 4";
    ModularAHU.BaseClasses.GenericAHUBus vu5Bus "Ventilation unit 5";
    SI.Temperature TRoom1Mea "Temperature in room 1";
    SI.Temperature TRoom2Mea "Temperature in room 2";
    SI.Temperature TRoom3Mea "Temperature in room 3";
    SI.Temperature TRoom4Mea "Temperature in room 4";
    SI.Temperature TRoom5Mea "Temperature in room 5";
    EONERC_MainBuilding.BaseClasses.EvaluationBus evaBus
      "Bus for energy consumption measurement";
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
  end MainBus;

  record HeatpumpBenchmarkSystem "Benchmark Heatpump Big"
    extends AixLib.DataBase.ThermalMachines.HeatPump.HeatPumpBaseDataDefinition(
      tableP_ele=[0,-5,0,5; 35,19350,19800,19800; 45,24000,24000,24000; 55,28950,29400,29400],
      tableQdot_con=[0,-5,0,5; 35,76572,87000,96600; 45,72600,83400,93600; 55,69078,
          79200,89400],
      mFlow_conNom=12,
      mFlow_evaNom=1000,
      tableUppBou=[-20, 50;-10, 60; 30, 60; 35,55],
      tableLowBou = [-20, 25; 25, 25; 35, 35]);
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end HeatpumpBenchmarkSystem;
end BaseClasses;
