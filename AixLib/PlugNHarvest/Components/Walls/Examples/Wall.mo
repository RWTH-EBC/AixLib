within AixLib.PlugNHarvest.Components.Walls.Examples;
model Wall
  import AixLib.PlugNHarvest;
  extends Modelica.Icons.Example;
  package Medium = AixLib.Media.Air;
  PlugNHarvest.Components.Walls.Wall wall(
    roomV=vol.V,
    room_V=vol.V,
    withWindow=true,
    redeclare package AirModel = Medium,
    outside=true,
    withHeatBridge=false,
    withSmartFacade=true,
    withPV=true,
    withMechVent=true,
    withSolAirHeat=true)
    annotation (Placement(transformation(extent={{-10,-6},{-4,28}})));
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
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{0,74},{20,94}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedTemperature(Q_flow=0)
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  Modelica.Blocks.Sources.Pulse const1(
    period=24*3600,
    startTime=8*3600,
    amplitude=0.3,
    offset=0.2)
    annotation (Placement(transformation(extent={{-64,-38},{-44,-18}})));
  AixLib.Utilities.Interfaces.Adaptors.ConvRadToCombPort heatStarToComb
    annotation (Placement(transformation(
        extent={{7,-6},{-7,6}},
        rotation=180,
        origin={13,-18})));
  Modelica.Blocks.Sources.Constant Solarradiation(k=0)
    annotation (Placement(transformation(extent={{-82,34},{-66,50}})));
  AixLib.Utilities.Sources.PrescribedSolarRad
                                       varRad            annotation(Placement(transformation(extent={{9,-9},{
            -9,9}},                                                                                                           rotation = 180, origin={-45,39})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature Tinside2(T = 293.15) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, origin={16,-50})));
  Modelica.Blocks.Sources.Constant Solarradiation1(k=100)
    annotation (Placement(transformation(extent={{-80,58},{-64,74}})));
equation
  connect(const.y, vol.mWat_flow)
    annotation (Line(points={{21,84},{34,84},{34,22}}, color={0,0,127}));
  connect(fixedTemperature.port, vol.heatPort) annotation (Line(points={{20,50},
          {22,50},{22,14},{36,14}}, color={191,0,0}));
  connect(wall.thermStarComb_inside, heatStarToComb.portConvRadComb)
    annotation (Line(points={{-4,11},{0,11},{0,-17.925},{6.42,-17.925}}, color=
          {191,0,0}));
  connect(heatStarToComb.portConv, vol.heatPort) annotation (Line(points={{
          20.07,-14.175},{36,-14.175},{36,14}}, color={191,0,0}));
  connect(Solarradiation.y, varRad.AOI[1]) annotation (Line(points={{-65.2,42},
          {-60,42},{-60,46},{-56,46},{-56,45.3},{-53.1,45.3}}, color={0,0,127}));
  connect(Solarradiation.y, varRad.I_gr[1]) annotation (Line(points={{-65.2,42},
          {-60,42},{-60,41.79},{-53.01,41.79}}, color={0,0,127}));
  connect(Solarradiation.y, varRad.I_diff[1]) annotation (Line(points={{-65.2,
          42},{-60,42},{-60,38.1},{-53.1,38.1}}, color={0,0,127}));
  connect(Solarradiation.y, varRad.I_dir[1]) annotation (Line(points={{-65.2,42},
          {-60,42},{-60,34.5},{-53.1,34.5}}, color={0,0,127}));
  connect(Tinside2.port, heatStarToComb.portRad) annotation (Line(points={{26,-50},
          {38,-50},{38,-22.35},{20.28,-22.35}}, color={191,0,0}));
  connect(weaDat.weaBus, wall.weaBus) annotation (Line(
      points={{-60,10},{-36,10},{-36,11},{-11.8,11}},
      color={255,204,51},
      thickness=0.5));
  connect(varRad.solarRad_out[1], wall.SolarRadiationPort) annotation (Line(
        points={{-36.9,39},{-24.45,39},{-24.45,26.5833},{-10.9,26.5833}}, color=
         {255,128,0}));
  connect(wall.port_b, vol.ports[1]) annotation (Line(points={{-2.9875,
          -0.439583},{23.4312,-0.439583},{23.4312,4},{44,4}}, color={0,127,255}));
  connect(wall.port_a, vol.ports[2]) annotation (Line(points={{-2.9875,-3.76875},
          {48,-3.76875},{48,4}}, color={0,127,255}));
  connect(Solarradiation1.y, varRad.I[1]) annotation (Line(points={{-63.2,66},{
          -60,66},{-60,30.99},{-53.01,30.99}}, color={0,0,127}));
  connect(const1.y, wall.Schedule_mechVent) annotation (Line(points={{-43,-28},
          {-34,-28},{-34,-1.1125},{-11.425,-1.1125}}, color={0,0,127}));
  annotation (Documentation(revisions="<html>
<ul>
<li><i>April, 2019&nbsp;</i> by Ana Constantin:<br>First implementation</li>
</ul>
</html>", info="<html>
<p>Testing for wall with smart facade.</p>
</html>"));
end Wall;
