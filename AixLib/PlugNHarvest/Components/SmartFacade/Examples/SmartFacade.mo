within AixLib.PlugNHarvest.Components.SmartFacade.Examples;
model SmartFacade
  import AixLib.PlugNHarvest;
  extends Modelica.Icons.Example;
    package Medium = AixLib.Media.Air;
  PlugNHarvest.Components.SmartFacade.SmartFacade smartFacade(
    withPV=true,
    withMechVent=true,
    room_V=vol.V,
    redeclare package AirModel = Medium)
    annotation (Placement(transformation(extent={{-24,-2},{14,36}})));
  AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    filNam=Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{-94,-2},{-74,18}})));
  Modelica.Blocks.Sources.Constant Solarradiation(k=0)
    annotation (Placement(transformation(extent={{-96,32},{-80,48}})));
  AixLib.Utilities.Sources.PrescribedSolarRad
                                       varRad            annotation(Placement(transformation(extent={{9,-9},{
            -9,9}},                                                                                                           rotation = 180, origin={-59,37})));
  Modelica.Blocks.Sources.Constant Solarradiation1(k=100)
    annotation (Placement(transformation(extent={{-94,56},{-78,72}})));
  Modelica.Blocks.Sources.Pulse const1(
    period=24*3600,
    startTime=8*3600,
    amplitude=0.3)
    annotation (Placement(transformation(extent={{-64,-48},{-44,-28}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{24,64},{44,84}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedTemperature(Q_flow=0)
    annotation (Placement(transformation(extent={{24,30},{44,50}})));
  AixLib.Fluid.MixingVolumes.MixingVolumeMoistAir vol(
    redeclare package Medium = Medium,
    m_flow_nominal=0.002,
    V=50,
    nPorts=2)
    annotation (Placement(transformation(extent={{56,4},{76,24}})));
equation
  connect(Solarradiation.y, varRad.AOI[1]) annotation (Line(points={{-79.2,40},{
          -74,40},{-74,44},{-70,44},{-70,43.3},{-67.1,43.3}}, color={0,0,127}));
  connect(Solarradiation.y, varRad.I_gr[1]) annotation (Line(points={{-79.2,40},
          {-74,40},{-74,39.79},{-67.01,39.79}}, color={0,0,127}));
  connect(Solarradiation.y, varRad.I_diff[1]) annotation (Line(points={{-79.2,40},
          {-74,40},{-74,36.1},{-67.1,36.1}}, color={0,0,127}));
  connect(Solarradiation.y, varRad.I_dir[1]) annotation (Line(points={{-79.2,40},
          {-74,40},{-74,32.5},{-67.1,32.5}}, color={0,0,127}));
  connect(Solarradiation1.y, varRad.I[1]) annotation (Line(points={{-77.2,64},{-74,
          64},{-74,28.99},{-67.01,28.99}}, color={0,0,127}));
  connect(weaDat.weaBus, smartFacade.weaBus) annotation (Line(
      points={{-74,8},{-50,8},{-50,17},{-22.1,17}},
      color={255,204,51},
      thickness=0.5));
  connect(varRad.solarRad_out[1], smartFacade.solRadPort) annotation (Line(
        points={{-50.9,37},{-36.45,37},{-36.45,26.5},{-22.1,26.5}}, color={255,128,
          0}));
  connect(fixedTemperature.port, vol.heatPort) annotation (Line(points={{44,40},
          {46,40},{46,14},{56,14}}, color={191,0,0}));
  connect(const.y, vol.mWat_flow)
    annotation (Line(points={{45,74},{54,74},{54,22}}, color={0,0,127}));
  connect(const1.y, smartFacade.Schedule_mechVent) annotation (Line(points={{-43,
          -38},{-34,-38},{-34,7.5},{-22.1,7.5}}, color={0,0,127}));
  connect(smartFacade.port_b, vol.ports[1]) annotation (Line(points={{13.24,14.72},
          {37.62,14.72},{37.62,4},{64,4}}, color={0,127,255}));
  connect(smartFacade.port_a, vol.ports[2]) annotation (Line(points={{13.24,7.12},
          {41.62,7.12},{41.62,4},{68,4}}, color={0,127,255}));
  annotation (Documentation(info="<html>
<p>Test for the smart facade model. To ckech how the individual components can be activated an if they work properly.</p>
</html>"));
end SmartFacade;
