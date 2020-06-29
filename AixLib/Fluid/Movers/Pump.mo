within AixLib.Fluid.Movers;
model Pump
  import AixLib;
  extends AixLib.Fluid.Interfaces.PartialTwoPortTransport;
  parameter AixLib.DataBase.Pumps.MinMaxCharacteristicsBaseDataDefinition MinMaxCharacteristics = AixLib.DataBase.Pumps.Pump1()
    "Head = f(V_flow) for minimal and maximal rotational speed"                                                                                                     annotation(choicesAllMatching = true);
  parameter Integer ControlStrategy = 1 "Control Strategy" annotation(Dialog(group = "Control strategy"), choices(choice = 1
        "dp-const",                                                                                                    choice = 2 "dp-var", radioButtons = true));
  parameter Modelica.SIunits.Height Head_max = 3
    "Set head for the control strategy"                                              annotation(Dialog(group = "Control strategy"));
  parameter Real V_flow_max = 2 "Vmax in m3/h for the control strategy" annotation(Dialog(group = "Control strategy", enable = if ControlStrategy == 2 then true else false));
  Modelica.SIunits.Height Head(start = 0, min = 0) "Pumping head";
  Modelica.Blocks.Tables.CombiTable1Ds table_minMaxCharacteristics(tableOnFile = false, columns = {2, 3}, table = MinMaxCharacteristics.minMaxHead)
    "Table with Head = f(V_flow) min amd max characteristics for the pump"                                                                                                     annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.BooleanInput IsNight annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 270, origin = {-2, 100}), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {0, 102})));
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
  annotation(Icon(coordinateSystem(preserveAspectRatio = false,
  extent = {{-100, -100}, {100, 100}}),
  graphics={  Ellipse(extent = {{-100, 96}, {100, -104}},
  lineColor = {0, 0, 0}, fillColor = {0, 127, 0},
            fillPattern=FillPattern.Solid),
            Polygon(points = {{-42, 70}, {78, -4}, {-42, -78}, {-42, 70}},
            lineColor = {0, 0, 0}, fillColor = {175, 175, 175},
            fillPattern=FillPattern.Solid)}), Documentation(revisions="<html>
 <ul>
 <li><i>November 2014&nbsp;</i>
    by Marcus Fuchs:<br/>
    Changed model to use Annex 60 base class</li>
 <li><i>01.11.2013&nbsp;</i>
    by Ana Constantin:<br/>
    implemented</li>
 </ul>
 </html>", info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Simple table based pump model.</p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>Simple table based pump model with the following features:</p>
 <ul>
 <li>Table for minimal and maximal characteristic</li>
 <li>Choice between two control strategies: 1. dp-const; 2. dp-var</li>
 <li>Input for switching to night mode. During night mode, the pump follows the minimal characteristic </li>
 </ul>
 <p><br/><b><font style=\"color: #008000; \">Example Results</font></b></p>
 <p><a href=\"AixLib.HVAC.Pumps.Examples.PumpHydraulicResistance_closedLoop\">AixLib.HVAC.Pumps.Examples.PumpHydraulicResistance_closedLoop</a></p>
 </html>"));
end Pump;
