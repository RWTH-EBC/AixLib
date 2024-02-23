within AixLib.Obsolete.Year2021.Fluid.Movers;
model Pump

  extends AixLib.Obsolete.BaseClasses.ObsoleteModel;

  extends AixLib.Fluid.Interfaces.PartialTwoPortTransport;
  parameter AixLib.DataBase.Pumps.MinMaxCharacteristicsBaseDataDefinition MinMaxCharacteristics = AixLib.DataBase.Pumps.Pump1()
    "Head = f(V_flow) for minimal and maximal rotational speed"                                                                                                     annotation(choicesAllMatching = true);
  parameter Integer ControlStrategy = 1 "Control Strategy" annotation(Dialog(group = "Control strategy"), choices(choice = 1
        "dp-const",                                                                                                    choice = 2 "dp-var", radioButtons = true));
  parameter Modelica.Units.SI.Height Head_max=max(MinMaxCharacteristics.minMaxHead[
      :, 3]) "Set head for the control strategy"
    annotation (Dialog(group="Control strategy"));
  parameter Real V_flow_max(unit="m3/h") = max(MinMaxCharacteristics.minMaxHead[:,1]) "Vmax in m3/h for the control strategy" annotation(Dialog(group = "Control strategy", enable = if ControlStrategy == 2 then true else false));
  Modelica.Units.SI.Height Head(start=0, min=0) "Pumping head";
  Modelica.Blocks.Tables.CombiTable1Ds table_minMaxCharacteristics(tableOnFile = false, columns = {2, 3}, table = MinMaxCharacteristics.minMaxHead)
    "Table with Head = f(V_flow) min amd max characteristics for the pump"                                                                                                     annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.BooleanInput IsNight annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 270, origin = {-2, 100}), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {0, 102})));

  parameter Modelica.Units.SI.MassFlowRate m_flowsPump[:]=MinMaxCharacteristics.minMaxHead[
      :, 1] ./ 3600.*rho_default "Convert VFlow in m3/h to kg/s";
  parameter Modelica.Units.SI.PressureDifference dpsPump[:]=
      MinMaxCharacteristics.minMaxHead[:, 3] .* rho_default .* Modelica.Constants.g_n
    "Convert m of head to Pa";

protected
  final parameter Medium.ThermodynamicState state_default = Medium.setState_pTX(
      T=Medium.T_default,
      p=Medium.p_default,
      X=Medium.X_default[1:Medium.nXi]) "Medium state at default values";
  // Density at medium default values, used to compute the size of control volumes
  final parameter Modelica.Units.SI.Density rho_default=Medium.density(state=
      state_default) "Density, used to volume flow rate from mass flow rate";
equation
  // Enthalpie flow
  port_a.h_outflow = inStream(port_b.h_outflow);
  port_b.h_outflow = inStream(port_a.h_outflow);
  // Set input to min max characteristics table
  table_minMaxCharacteristics.u = V_flow * 3600;
  if IsNight then
    //night mode active
    Head = table_minMaxCharacteristics.y[1];
    // minimal characteristic
  else
    if ControlStrategy == 1 then
      Head = min(max(Head_max, table_minMaxCharacteristics.y[1]), table_minMaxCharacteristics.y[2]);
      //Set Head according to the control strategy
    else
      Head = min(max(0.5 * Head_max + 0.5 * Head_max / V_flow_max * V_flow * 3600, table_minMaxCharacteristics.y[1]), table_minMaxCharacteristics.y[2]);
      //Set Head according to the control strategy
    end if;
  end if;
  // Connect the pump variables with the variables of the two port model
  Head = -dp / (Medium.density(Medium.setState_phX(port_a.p, inStream(port_a.h_outflow), inStream(port_a.Xi_outflow))) * Modelica.Constants.g_n);
  annotation (
    obsolete = "Obsolete model - Use one of the valves in package AixLib.Fluid.Movers.",
    Icon(coordinateSystem(preserveAspectRatio = false,
  extent = {{-100, -100}, {100, 100}}),
  graphics={  Ellipse(extent = {{-100, 96}, {100, -104}},
  lineColor = {0, 0, 0}, fillColor = {0, 127, 0},
            fillPattern=FillPattern.Solid),
            Polygon(points = {{-42, 70}, {78, -4}, {-42, -78}, {-42, 70}},
            lineColor = {0, 0, 0}, fillColor = {175, 175, 175},
            fillPattern=FillPattern.Solid)}), Documentation(revisions="<html><ul>
  <li>
    <i>November 2014&#160;</i> by Marcus Fuchs:<br/>
    Changed model to use Annex 60 base class
  </li>
  <li>
    <i>01.11.2013&#160;</i> by Ana Constantin:<br/>
    implemented
  </li>
</ul>
</html>", info = "<html>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Simple table based pump model.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  Simple table based pump model with the following features:
</p>
<ul>
  <li>Table for minimal and maximal characteristic
  </li>
  <li>Choice between two control strategies: 1. dp-const; 2. dp-var
  </li>
  <li>Input for switching to night mode. During night mode, the pump
  follows the minimal characteristic
  </li>
</ul>
<p>
  <br/>
  <b><span style=\"color: #008000\">Example Results</span></b>
</p>
<p>
  <a href=
  \"AixLib.HVAC.Pumps.Examples.PumpHydraulicResistance_closedLoop\">AixLib.HVAC.Pumps.Examples.PumpHydraulicResistance_closedLoop</a>
</p>
</html>"));
end Pump;
