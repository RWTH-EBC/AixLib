within AixLib.Utilities.Sources.InternalGains.Examples.InternalGains;
model Machines "Simulation to check the machine models"
  extends Modelica.Icons.Example;
  Utilities.Sources.InternalGains.Machines.Machines_DIN18599
    machines_sensibleHeat_DIN18599
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Utilities.Sources.InternalGains.Machines.Machines_Avar
    machines_sensibleHeat_Avar
    annotation (Placement(transformation(extent={{-10,-52},{10,-32}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(table=[0,0; 28740,0;
        28800,1; 64800,1; 64860,0; 86400,0])
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemp(T=293.15)
    annotation (Placement(transformation(extent={{80,-8},{60,12}})));
  AixLib.Utilities.Sources.InternalGains.Machines.MachinesAreaSpecific machinesAreaSpecific annotation (Placement(transformation(extent={{-10,32},{10,52}})));
equation
  connect(combiTimeTable.y[1],machines_sensibleHeat_DIN18599.schedule)
    annotation (Line(
      points={{-49,0},{-10,0}},
      color={0,0,127}));
  connect(combiTimeTable.y[1],machines_sensibleHeat_Avar.schedule)
    annotation (Line(
      points={{-49,0},{-28,0},{-28,-42},{-10,-42}},
      color={0,0,127}));
  connect(machines_sensibleHeat_DIN18599.convHeat, fixedTemp.port)
    annotation (Line(
      points={{9,6},{38,6},{38,2},{60,2}},
      color={191,0,0}));
  connect(machines_sensibleHeat_DIN18599.radHeat, fixedTemp.port)
    annotation (Line(
      points={{9,-6},{34.5,-6},{34.5,2},{60,2}},
      color={95,95,95},
      pattern=LinePattern.Solid));
  connect(machines_sensibleHeat_Avar.convHeat, fixedTemp.port) annotation (
      Line(
      points={{9,-36},{38,-36},{38,2},{60,2}},
      color={191,0,0}));
  connect(machines_sensibleHeat_Avar.radHeat, fixedTemp.port) annotation (
      Line(
      points={{9,-48},{34.5,-48},{34.5,2},{60,2}},
      color={95,95,95},
      pattern=LinePattern.Solid));
  connect(combiTimeTable.y[1], machinesAreaSpecific.schedule) annotation (Line(points={{-49,0},{-28,0},{-28,42},{-10,42}}, color={0,0,127}));
  connect(machinesAreaSpecific.convHeat, fixedTemp.port) annotation (Line(points={{9,48},{44,48},{44,2},{60,2}}, color={191,0,0}));
  connect(machinesAreaSpecific.radHeat, fixedTemp.port) annotation (Line(points={{9,36},{42,36},{42,2},{60,2}}, color={95,95,95}));
  annotation (
    experiment(StopTime=86400, Interval=60),
Documentation(info="<html>
<h4><font color=\"#008000\">Overview</font></h4>
<p>This simulation is to check the functionality of the machine models described by the internal gains. </p>
<h4><font color=\"#008000\">Concept</font></h4>
<p>The simulation consists of the following models:</p>
<table summary=\"Models\" cellspacing=\"2\" cellpadding=\"0\" border=\"0\"><tr>
<td bgcolor=\"#dcdcdc\"><p>index</p></td>
<td bgcolor=\"#dcdcdc\"><p>model</p></td>
</tr>
<tr>
<td><p>1</p></td>
<td><p><a href=\"AixLib.Building.Components.Sources.InternalGains.Machines.Machines_simple\">Machines_simple</a></p></td>
</tr>
<tr>
<td><p>2</p></td>
<td><p><a href=\"AixLib.Building.Components.Sources.InternalGains.Machines.Machines_DIN18599\">Machines_DIN18599</a></p></td>
</tr>
<tr>
<td><p>3</p></td>
<td><p><a href=\"AixLib.Building.Components.Sources.InternalGains.Machines.Machines_Avar\">Machines_Avar</a></p></td>
</tr>
</table>
<p><br/>Heat flow values can be displayed via the provided output. </p>
</html>",
        revisions="<html>
<ul>
<li><i>May 31, 2013&nbsp;</i> by Ole Odendahl:<br/>Implemented, added documentation and formatted appropriately</li>
</ul>
</html>"));
end Machines;
