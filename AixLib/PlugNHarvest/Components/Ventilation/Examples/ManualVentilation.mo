within AixLib.PlugNHarvest.Components.Ventilation.Examples;
model ManualVentilation
  extends Modelica.Icons.Example;
  package Medium = AixLib.Media.Air;

  MechVent_schedule
                  infiltrationNew(redeclare package AirModel = Medium, room_V=
        vol.V)
    annotation (Placement(transformation(extent={{-26,0},{0,22}})));
  AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    filNam=Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  AixLib.Fluid.MixingVolumes.MixingVolumeMoistAir vol(
    redeclare package Medium = Medium,
    m_flow_nominal=0.002,
    V=50,
    nPorts=2)
    annotation (Placement(transformation(extent={{36,4},{56,24}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedTemperature(Q_flow=0)
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{0,74},{20,94}})));
  Modelica.Blocks.Sources.Pulse const1(
    period=24*3600,
    startTime=8*3600,
    amplitude=0.3)
    annotation (Placement(transformation(extent={{-64,-38},{-44,-18}})));
equation
  connect(weaDat.weaBus, infiltrationNew.weaBus) annotation (Line(
      points={{-60,10},{-42,10},{-42,18.26},{-25.48,18.26}},
      color={255,204,51},
      thickness=0.5));
  connect(fixedTemperature.port, vol.heatPort) annotation (Line(points={{20,50},
          {22,50},{22,14},{36,14}}, color={191,0,0}));
  connect(const.y, vol.mWat_flow)
    annotation (Line(points={{21,84},{34,84},{34,22}}, color={0,0,127}));
  connect(infiltrationNew.port_b, vol.ports[1]) annotation (Line(points={{-0.52,
          13.86},{16,13.86},{16,4},{44,4}}, color={0,127,255}));
  connect(infiltrationNew.port_a, vol.ports[2]) annotation (Line(points={{-0.52,
          9.46},{8,9.46},{8,10},{16,10},{16,4},{48,4}}, color={0,127,255}));
  connect(const1.y, infiltrationNew.Schedule_mechVent) annotation (Line(points=
          {{-43,-28},{-24.7,-28},{-24.7,3.3}}, color={0,0,127}));
  annotation (experiment(StopTime=86400, Interval=600), Documentation(revisions=
         "<html>
<ul>
<li>
April 17, 2019, by Ana Constantin:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>Test for the impact of manual ventilation on an air volume.</p>
</html>"));
end ManualVentilation;
