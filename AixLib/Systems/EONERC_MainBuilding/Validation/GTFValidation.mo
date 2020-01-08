within AixLib.Systems.EONERC_MainBuilding.Validation;
model GTFValidation "Validation of geothermal field"
  extends Modelica.Icons.Example;
    package Medium = AixLib.Media.Water
    annotation (choicesAllMatching=true);

  parameter DataGTF Data;
  Fluid.Sources.Boundary_pT          boundary(
    redeclare package Medium = Medium,
    T=303.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={20,40})));
  Fluid.Sources.MassFlowSource_T        boundary5(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    m_flow=1,
    use_T_in=true,
    T=300.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,40})));

  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(table=Data.October2015,
      smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments)
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin1
                                                          annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-50,70})));
  GeothermalFieldSimple geothermalFieldSimple(
    redeclare package Medium = Medium,
    m_flow_nominal=10,
    T_start=285.65,
    T_amb=293.15)
    annotation (Placement(transformation(extent={{-38,-68},{8,-2}})));
  BaseClasses.TwoCircuitBus twoCircuitBus1 annotation (Placement(transformation(
          extent={{-68,-34},{-48,-14}}), iconTransformation(extent={{-80,-38},{
            -60,-18}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-98,-34},{-78,-14}})));
  Modelica.Blocks.Sources.Constant const1(k=2100)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
equation
  connect(toKelvin1.Kelvin, boundary5.T_in)
    annotation (Line(points={{-43.4,70},{-36,70},{-36,52}}, color={0,0,127}));
  connect(geothermalFieldSimple.port_a, boundary5.ports[1]) annotation (Line(
        points={{-34.1667,-2},{-34,-2},{-34,20},{-40,20},{-40,30}}, color={0,
          127,255}));
  connect(geothermalFieldSimple.port_b, boundary.ports[1]) annotation (Line(
        points={{4.16667,-2},{4.16667,20},{20,20},{20,30}}, color={0,127,255}));
  connect(geothermalFieldSimple.twoCircuitBus, twoCircuitBus1) annotation (Line(
      points={{-38.1917,-22.8312},{-58,-22.8312},{-58,-24}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boundary5.m_flow_in, combiTimeTable.y[3]) annotation (Line(points={{
          -32,52},{-32,84},{-76,84},{-76,70},{-79,70}}, color={0,0,127}));
  connect(combiTimeTable.y[1], toKelvin1.Celsius)
    annotation (Line(points={{-79,70},{-57.2,70}}, color={0,0,127}));
  connect(const1.y, twoCircuitBus1.primBus.pumpBus.rpm_Input) annotation (Line(
        points={{-79,10},{-57.95,10},{-57.95,-23.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const.y, twoCircuitBus1.secBus.valSet) annotation (Line(points={{-77,
          -24},{-68,-24},{-68,-23.95},{-57.95,-23.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (experiment(StopTime=345600, __Dymola_NumberOfIntervals=5000),
                                         __Dymola_Commands(file(ensureSimulated=
           true)=
        "Resources/Scripts/Dymola/Systems/EONERC_MainBuilding/Validation/Simulate_and_plot_HeatpumpValidation.mos"
        "Simulate and plot"));
end GTFValidation;
