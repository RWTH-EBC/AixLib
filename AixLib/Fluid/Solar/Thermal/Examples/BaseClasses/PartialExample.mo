within AixLib.Fluid.Solar.Thermal.Examples.BaseClasses;
model PartialExample
  "Example to demonstrate the function of the photovoltaic thermal collector model"
  replaceable package Medium = AixLib.Media.Water constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium model";
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal
    "Nominal mass flow rate";
  parameter Modelica.Units.SI.PressureDifference dp_nominal
    "Nominal pressure drop";
  Sources.Boundary_pT sou(redeclare package Medium = Medium, p=2e5 + dp_nominal)
    "Source model"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Sources.Boundary_pT sin(redeclare package Medium = Medium, p=2e5)
    "Sink model"
    annotation (Placement(transformation(extent={{60,-10},{40,10}})));
  Modelica.Blocks.Sources.CombiTimeTable weaDat(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    table=[0,6,0; 3600,5.6,0; 7200,5.5,0; 10800,5.4,0; 14400,5,6; 18000,5.5,106;
        21600,7.4,251; 25200,9.1,402; 28800,11.3,540; 32400,13.4,657; 36000,15,
        739; 39600,16.5,777; 43200,16.5,778; 46800,17.5,737; 50400,17.5,657;
        54000,17.5,544; 57600,17.5,407; 61200,17.5,257; 64800,16.6,60; 68400,15.8,
        5; 72000,7.9,0; 75600,6.2,0; 79200,5.6,0; 82800,5.3,0],
    offset={273.15,0.01}) "Profile for a day"
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));

  annotation (
    experiment(StopTime=82600, Interval=3600),
    __Dymola_experimentSetupOutput(events=false),
    Documentation(info="<html>
<p>
This partial model introduces common blocks used for solar thermal examples.
</p>
</html>", revisions="<html><ul>
  <li>
    <i>January 23, 2024</i> by Philipp Schmitz and Fabian Wuellhorst:<br/>
    First implementation. This is for
 <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1451\">
 issue 1451</a>.
  </li>
</ul>
</html>"),
    __Dymola_Commands(file(ensureSimulated=true)=
        "Resources/Scripts/Dymola/Fluid/Solar/Thermal/Examples/SolarThermalCollector.mos"));
end PartialExample;
