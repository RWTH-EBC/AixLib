within AixLib.Fluid.DistrictHeatingCooling.Demands.Examples.ClosedLoop;
model SubstationDirectHeatingDirectCoolingDHW
  import AixLib;
  extends Modelica.Icons.Example;
  package Medium = AixLib.Media.Water "Fluid in the pipes";
  AixLib.Fluid.Sources.Boundary_pT    coo(
    redeclare package Medium = Medium,
    use_T_in=true,
    nPorts=1)      "Cool pipe" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-56,-44})));
  AixLib.Fluid.Sources.Boundary_pT    coo1(
    redeclare package Medium = Medium,
    use_T_in=true,
    nPorts=1)      "Cool pipe" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={44,70})));
  Modelica.Blocks.Sources.Constant const(k=289.15)
    annotation (Placement(transformation(extent={{-52,72},{-32,92}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
        Medium, m_flow_nominal=2)
    annotation (Placement(transformation(extent={{-56,-18},{-36,2}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium =
        Medium, m_flow_nominal=2)
    annotation (Placement(transformation(extent={{22,2},{42,22}})));
  Modelica.Blocks.Sources.Constant
                               const1(k=273.15 + 27)
    annotation (Placement(transformation(extent={{-96,-84},{-76,-64}})));
  Modelica.Blocks.Sources.TimeTable timeTable1(table=[0,0; 3600,0; 3600,1500;
        7200,1500; 7200,2000; 10800,1000; 14400,0; 18000,0; 18000,2000; 24000,
        2000; 24000,0])
    annotation (Placement(transformation(extent={{-98,2},{-78,22}})));
  Modelica.Blocks.Sources.TimeTable timeTable(table=[0,0; 24000,0; 24000,2000;
        34800,3000; 34800,0; 45600,0; 45600,4000; 63600,4000; 63600,0])
    annotation (Placement(transformation(extent={{76,-30},{56,-10}})));
  AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop.SubstationDirectHeatingDirectCoolingDHW
    substationDirectHeatingDirectCoolingDHW(
    heatDemand_max=40000,
    deltaT_heatingSet(displayUnit="K") = 10,
    deltaT_coolingGridSet(displayUnit="K") = 6,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,

    T_supplyDHWSet=333.15,
    T_returnSpaceHeatingSet=283.15,
    m_flow_nominal=0.1)
    annotation (Placement(transformation(extent={{-34,-2},{14,30}})));

  Modelica.Blocks.Sources.TimeTable timeTable2(table=[0,0; 3600,0; 3600,0; 7200,
        0; 7200,0; 10800,3000; 14400,3000; 18000,0; 18000,2000; 21600,2000;
        21600,0; 31200,0; 31200,2500; 42000,2500; 42000,0])
    annotation (Placement(transformation(extent={{-98,38},{-78,58}})));
equation
  connect(const1.y, coo.T_in)
    annotation (Line(points={{-75,-74},{-60,-74},{-60,-56}}, color={0,0,127}));
  connect(senTem1.port_b, coo1.ports[1])
    annotation (Line(points={{42,12},{44,12},{44,60}}, color={0,127,255}));
  connect(coo.ports[1], senTem.port_a)
    annotation (Line(points={{-56,-34},{-56,-8}}, color={0,127,255}));
  connect(const.y, coo1.T_in) annotation (Line(points={{-31,82},{4,82},{4,82},{
          40,82}}, color={0,0,127}));
  connect(substationDirectHeatingDirectCoolingDHW.port_b, senTem1.port_a)
    annotation (Line(points={{14,14},{18,14},{18,12},{22,12}}, color={0,127,255}));
  connect(senTem.port_b, substationDirectHeatingDirectCoolingDHW.port_a)
    annotation (Line(points={{-36,-8},{-36,14},{-34,14}}, color={0,127,255}));
  connect(timeTable1.y, substationDirectHeatingDirectCoolingDHW.coolingDemand)
    annotation (Line(points={{-77,12},{-52,12},{-52,18.2},{-24,18.2}}, color={0,
          0,127}));
  connect(substationDirectHeatingDirectCoolingDHW.heatDemand, timeTable.y)
    annotation (Line(points={{-24,27.6},{30.6,27.6},{30.6,-20},{55,-20}}, color
        ={0,0,127}));
  connect(timeTable2.y, substationDirectHeatingDirectCoolingDHW.dhwDemand)
    annotation (Line(points={{-77,48},{-48,48},{-48,23},{-24,23}}, color={0,0,
          127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=60,
      Tolerance=1e-007),
  Documentation(info="<html><p>
  This example shows a simple example of a closed loop substation model
  for bidirctional low-temperature networks for buildings with heat
  pump,direct cooling and DHW demand <a href=
  \"modelica://AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop.SubstationDirectHeatingDirectCoolingDHW\">
  AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop.SubstationDirectHeatingDirectCoolingDHW</a>.
  It illustrates the settings needed to run the demand model.
</p>
</html>", revisions="<html><ul>
  <li>
    <i>February 20, 2024</i> by Rahul Karuvingal:<br/>
    Added documentation.
  </li>
  <li>
    <i>February 20, 2024</i> by Rahul Karuvingal:<br/>
    Revised to make it compatible with MSL 4.0.0 and Aixlib 1.3.2.
  </li>
  <li>
    <i>April 15, 2020</i> by Tobias Blacha:<br/>
    First Implementation
  </li>
</ul>
</html>"));
end SubstationDirectHeatingDirectCoolingDHW;
