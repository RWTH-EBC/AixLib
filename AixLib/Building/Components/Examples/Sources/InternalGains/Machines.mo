within AixLib.Building.Components.Examples.Sources.InternalGains;
model Machines "Simulation to check the machine models"
  extends Modelica.Icons.Example;
  Components.Sources.InternalGains.Machines.Machines_DIN18599
    machines_sensibleHeat_DIN18599
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(table=[0,0; 28740,0;
        28800,1; 64800,1; 64860,0; 86400,0])
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemp(T=293.15)
    annotation (Placement(transformation(extent={{80,-8},{60,12}})));
equation
  connect(combiTimeTable.y[1], machines_sensibleHeat_DIN18599.Schedule)
    annotation (Line(
      points={{-49,0},{-9,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(machines_sensibleHeat_DIN18599.ConvHeat, fixedTemp.port)
    annotation (Line(
      points={{9,6},{38,6},{38,2},{60,2}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(machines_sensibleHeat_DIN18599.RadHeat, fixedTemp.port)
    annotation (Line(
      points={{9,-5.8},{34.5,-5.8},{34.5,2},{60,2}},
      color={95,95,95},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics),
    experiment(StopTime=86400, Interval=60),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>This simulation is to check the functionality of the machine models described by the internal gains. </p>
<p><b><font style=\"color: #008000; \">Concept</font></b></p><p>Heat flow values can be displayed via the provided output. </p>
</html>",
        revisions="<html>
<p><ul>
<li><i>May 31, 2013&nbsp;</i> by Ole Odendahl:<br/>Implemented, added documentation and formatted appropriately</li>
</ul></p>
</html>"));
end Machines;
