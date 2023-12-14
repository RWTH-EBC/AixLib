within AixLib.Systems.EONERC_Testhall.TestModels;
model CCA "Model of EON ERC Testhall including Monitoring Data and Weather Data from 25.Oct 2022 12am till 26.Oct 2023 12am"
  ThermalZone.EON_ERC_Testhall eON_ERC_Testhall
    annotation (Placement(transformation(extent={{-18,-14},{14,16}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow thermalzone_intGains_rad(alpha=0)
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-32,6})));
  Modelica.Blocks.Sources.Constant intGains_rad(k=0)
    annotation (Placement(transformation(extent={{-60,4},{-50,14}})));
  BaseClass.CCA.CCA cCA
    annotation (Placement(transformation(extent={{-82,-26},{-60,-6}})));
  Controller.ControlCCA controlCCA
    annotation (Placement(transformation(extent={{-116,-24},{-98,-10}})));
  Fluid.Sources.Boundary_pT                   bound_sup(redeclare package
      Medium = AixLib.Media.Water,
    p=310000,
    use_T_in=true,                 nPorts=1)
                    annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=180,
        origin={-86,-50})));
  Fluid.Sources.Boundary_pT bound_ret(redeclare package Medium =
        AixLib.Media.Water, nPorts=1) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={-58,-50})));
  Modelica.Blocks.Sources.Constant intGains_rad1(k=55 + 273.15)
    annotation (Placement(transformation(extent={{-118,-58},{-108,-48}})));

  BoundaryConditions.WeatherData.ReaderTMY3        weaDat(
      computeWetBulbTemperature=false, filNam=
        ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Systems/EONERC_Testhall/DataBase/Aachen_251022_251023.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{-140,28},{-120,48}})));
  BoundaryConditions.WeatherData.Bus
      weaBus "Weather data bus" annotation (Placement(transformation(extent={{-128,
            -14},{-116,-2}}),    iconTransformation(extent={{190,-10},{210,10}})));
equation
  connect(intGains_rad.y, thermalzone_intGains_rad.Q_flow) annotation (Line(
        points={{-49.5,9},{-46,9},{-46,6},{-38,6}}, color={0,0,127}));
  connect(thermalzone_intGains_rad.port, eON_ERC_Testhall.intGainsRad_port)
    annotation (Line(points={{-26,6},{-26,4.6},{-17.68,4.6}}, color={191,0,0}));
  connect(controlCCA.distributeBus_CCA,cCA. dB_CCA) annotation (Line(
      points={{-102.292,-17.07},{-102.292,-16.4},{-82.22,-16.4}},
      color={255,204,51},
      thickness=0.5));
  connect(cCA.heat_port_CCA, eON_ERC_Testhall.intGainsConv_port) annotation (
      Line(points={{-71,-5.6},{-71,-0.5},{-17.68,-0.5}}, color={191,0,0}));
  connect(bound_sup.ports[1], cCA.cca_supprim) annotation (Line(points={{-80,
          -50},{-74.74,-50},{-74.74,-26}}, color={0,127,255}));
  connect(bound_ret.ports[1], cCA.cca_retprim) annotation (Line(points={{-64,
          -50},{-66.6,-50},{-66.6,-26}}, color={0,127,255}));
  connect(intGains_rad1.y, bound_sup.T_in) annotation (Line(points={{-107.5,-53},
          {-100.35,-53},{-100.35,-52.4},{-93.2,-52.4}}, color={0,0,127}));
  connect(weaDat.weaBus, eON_ERC_Testhall.weaBus) annotation (Line(
      points={{-120,38},{-22,38},{-22,10.6},{-17.68,10.6}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{-120,38},{-116,38},{-116,-8},{-122,-8}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus.TDryBul, controlCCA.T_amb) annotation (Line(
      points={{-122,-8},{-120,-8},{-120,-17},{-116,-17}},
      color={255,204,51},
      thickness=0.5));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,-140},{140,
            140}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,-140},{
            140,140}})),
    experiment(
      StartTime=25660800,
      StopTime=28080000,
      Interval=3600,
      __Dymola_Algorithm="Dassl"));
end CCA;
