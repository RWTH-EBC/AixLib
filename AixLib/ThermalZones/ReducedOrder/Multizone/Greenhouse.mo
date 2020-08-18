within AixLib.ThermalZones.ReducedOrder.Multizone;
model Greenhouse "Greenhouse with moisture"
   extends
    AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses.PartialMultizone(redeclare
      model                                                                                 thermalZone =
        AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZoneMoistAirExchange);
  parameter Real zoneVolume[numZones];
  Modelica.Blocks.Interfaces.RealInput ventHum[numZones] if ASurTot > 0 or
    VAir > 0 "Ventilation and infiltration humidity"
     annotation (Placement(
        transformation(
        extent={{20,20},{-20,-20}},
        rotation=180,
        origin={-100,36}),  iconTransformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-90,24})));
  Modelica.Blocks.Interfaces.RealInput ventTemp[numZones](
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC",
    min=0)
    "Ventilation and infiltration temperature"
    annotation (Placement(transformation(extent={{-120,-12},{-80,28}}),
        iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,0})));
  Modelica.Blocks.Interfaces.RealInput ventRate[numZones](final
    quantity="VolumeFlowRate", final unit="1/h")
    "Ventilation and infiltration rate"
    annotation (Placement(transformation(extent={{-120,-40},{-80,0}}),
        iconTransformation(extent={{-100,-36},{-80,-16}})));
  Modelica.Blocks.Interfaces.RealOutput X_w[size(zone, 1)] "Humidity output"
    annotation (Placement(transformation(extent={{100,32},{120,52}})));
  Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.RecircFlap
    recircFlap[numZones](redeclare model PartialPressureDrop =
        Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.PressureDrop.PressureDropSimple)
    annotation (Placement(transformation(extent={{-32,0},{14,50}})));
  BaseClasses.InfiltrationToMassflow infiltrationToMassflow(nZones=numZones,
      zoneVolume=zoneVolume)
    annotation (Placement(transformation(extent={{-74,-30},{-54,-10}})));
  BaseClasses.MassflowToInfiltration massflowToInfiltration(nZones=numZones,
      zoneVolume=zoneVolume) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={44,22})));
  Utilities.Psychrometrics.Phi_pTX phi[numZones]
    annotation (Placement(transformation(extent={{42,-70},{22,-50}})));
  Modelica.Blocks.Sources.RealExpression realExpression[numZones](y=101325)
    annotation (Placement(transformation(extent={{120,-90},{100,-70}})));
  Modelica.Blocks.Continuous.LimPID PID[numZones](
    Td=0.01,                                      yMax=0.8,
    yMin=0.0)
    annotation (Placement(transformation(extent={{8,-42},{-12,-22}})));
  Modelica.Blocks.Sources.RealExpression setRelHum[numZones](y=0.7)
    "Set Temperature for relative humidity"
    annotation (Placement(transformation(extent={{46,-42},{26,-22}})));
  Modelica.Blocks.Math.Feedback feedback[numZones]
    annotation (Placement(transformation(extent={{-62,-54},{-42,-34}})));
  Modelica.Blocks.Sources.RealExpression realExpression2[numZones](y=1)
    annotation (Placement(transformation(extent={{-26,-76},{-46,-56}})));
  Modelica.Blocks.Math.Product product[numZones] annotation (Placement(
        transformation(
        extent={{-3,-3},{3,3}},
        rotation=90,
        origin={-33,-21})));
equation
  connect(zone.X_w, X_w) annotation (Line(points={{82.1,72.78},{92,72.78},{92,42},
          {110,42}}, color={0,0,127}));
  connect(infiltrationToMassflow.infiltration, ventRate)
    annotation (Line(points={{-74,-20},{-100,-20}}, color={0,0,127}));
  connect(ventTemp, recircFlap.T_airInOda) annotation (Line(points={{-100,8},{-56,
          8},{-56,12.5},{-34.3,12.5}}, color={0,0,127}));
  connect(ventHum, recircFlap.X_airInOda) annotation (Line(points={{-100,36},{
          -60,36},{-60,20},{-34.3,20}}, color={0,0,127}));
  connect(infiltrationToMassflow.m_flow, recircFlap.m_flow_airInEta)
    annotation (Line(points={{-53,-20},{-42,-20},{-42,56},{26,56},{26,45},{16.3,
          45}}, color={0,0,127}));
  connect(TAir, recircFlap.T_airInEta) annotation (Line(points={{110,81},{132,
          81},{132,36},{16.3,36},{16.3,37.5}}, color={0,0,127}));
  connect(X_w, recircFlap.X_airInEta) annotation (Line(points={{110,42},{120,42},
          {120,40},{124,40},{124,30},{16.3,30}}, color={0,0,127}));
  connect(recircFlap.X_airOutOda, zone.ventHum) annotation (Line(points={{16.3,
          20},{32,20},{32,55.765},{35.27,55.765}}, color={0,0,127}));
  connect(recircFlap.T_airOutOda, zone.ventTemp) annotation (Line(points={{16.3,
          12.5},{30,12.5},{30,61.505},{35.27,61.505}}, color={0,0,127}));
  connect(recircFlap.m_flow_airOutOda, massflowToInfiltration.m_flow)
    annotation (Line(points={{16.3,5},{44.15,5},{44.15,12},{44,12}}, color={0,0,
          127}));
  connect(massflowToInfiltration.infiltration, zone.ventRate) annotation (Line(
        points={{44,33},{44,52.28},{44.3,52.28}}, color={0,0,127}));
  connect(TAir, phi.T) annotation (Line(points={{110,81},{148,81},{148,-52},{43,
          -52}}, color={0,0,127}));
  connect(phi.X_w, X_w) annotation (Line(points={{43,-60},{170,-60},{170,42},{
          110,42}}, color={0,0,127}));
  connect(realExpression.y, phi.p) annotation (Line(points={{99,-80},{72,-80},{
          72,-68},{43,-68}},   color={0,0,127}));
  connect(PID.y, recircFlap.flapPosition) annotation (Line(points={{-13,-32},{
          -20.5,-32},{-20.5,0}}, color={0,0,127}));
  connect(phi.phi, PID.u_m) annotation (Line(points={{21,-60},{8,-60},{8,-62},{
          -2,-62},{-2,-44}}, color={0,0,127}));
  connect(PID.u_s, setRelHum.y)
    annotation (Line(points={{10,-32},{25,-32}}, color={0,0,127}));
  connect(realExpression2.y, feedback.u1) annotation (Line(points={{-47,-66},{
          -72,-66},{-72,-44},{-60,-44}}, color={0,0,127}));
  connect(feedback.u2, PID.y) annotation (Line(points={{-52,-52},{-26,-52},{-26,
          -32},{-13,-32}}, color={0,0,127}));
  connect(feedback.y, product.u2) annotation (Line(points={{-43,-44},{-31.2,-44},
          {-31.2,-24.6}}, color={0,0,127}));
  connect(infiltrationToMassflow.m_flow, product.u1) annotation (Line(points={{
          -53,-20},{-48,-20},{-48,-30},{-34,-30},{-34,-24.6},{-34.8,-24.6}},
        color={0,0,127}));
  connect(product.y, recircFlap.m_flow_airInOda) annotation (Line(points={{-33,
          -17.7},{-33,-6},{-40,-6},{-40,5},{-34.3,5}}, color={0,0,127}));
end Greenhouse;
