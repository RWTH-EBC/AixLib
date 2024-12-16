within AixLib.Fluid.SolarCollectors.PhotovoltaicThermal.Examples.BaseClasses;
partial model PartialExample
  "Example to demonstrate the function of the photovoltaic thermal collector model"
  replaceable package Medium = AixLib.Media.Water constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium model";
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal
    "Nominal mass flow rate";
  parameter Modelica.Units.SI.PressureDifference dp_nominal
    "Nominal pressure drop";
  Sources.MassFlowSource_T
                      sou(redeclare package Medium = Medium)
    "Source model"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Sources.Boundary_pT sin(redeclare package Medium = Medium, p=2e5)
    "Sink model"
    annotation (Placement(transformation(extent={{60,-10},{40,10}})));

  BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/weatherdata/TRY2015_Jahr_City_Aachen.mos"),
      computeWetBulbTemperature=false) "Weather data file reader"
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
