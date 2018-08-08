within AixLib.Electrical.PVSystem.Examples;
model ExamplePVTMY3
  extends Modelica.Icons.Example;

  Modelica.Blocks.Interfaces.RealOutput Power(
    final quantity="Power",
    final unit="W")
    "Output Power of the PV system including the inverter"
    annotation (Placement(transformation(extent={{56,30},{76,50}})));
  Electrical.PVSystem.PVSystemTMY3 PVsystem(
    MaxOutputPower=4000,
    NumberOfPanels=5,
    data=AixLib.DataBase.SolarElectric.SymphonyEnergySE6M181())
    "PV system model including the inverter"
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));

  AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"))
    annotation (Placement(transformation(extent={{-96,30},{-76,50}})));
equation
  connect(weaDat.weaBus, PVsystem.weaBus) annotation (Line(
      points={{-76,40},{-10,40}},
      color={255,204,51},
      thickness=0.5));
  connect(PVsystem.PVPowerW, Power)
    annotation (Line(points={{11,40},{11,40},{66,40}},
                                              color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
            -100,-100},{100,100}})),
    experiment(
      StopTime=3.1536e+007,
      Interval=3600,
      __Dymola_Algorithm="Lsodar"),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Simulation to test the <a href=\"AixLib.Fluid.Solar.Electric.PVSystemTMY3\">PVsystemTMY3</a> model.</p>
</html>",
      revisions="<html>
<ul>
<li><i>October 20, 2017 </i> ,by Larissa Kuehn:<br/>First implementation</li>
</ul>
</html>"));
end ExamplePVTMY3;
