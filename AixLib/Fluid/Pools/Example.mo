within AixLib.Fluid.Pools;
model Example
  IndoorSwimmingPool indoorSwimmingPool(poolParam=
        DataBase.Pools.TypesOfIndoorSwimmingPools.SportPool(),
      m_flow_recycledStart=0.0001)
    annotation (Placement(transformation(extent={{-28,-28},{34,28}})));
  Modelica.Blocks.Sources.CombiTimeTable tableOpeningHours(
    tableOnFile=true,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    tableName="OpeningHours",
    columns=2:16,
    fileName=ModelicaServices.ExternalReferences.loadResource("modelica://Output_Schwimmbad_Modell/Hallenbad/OpeningHours_Hallenbad.txt"))  "Boundary condition: Opening Hours of swiming pools"
    annotation (Placement(transformation(extent={{-72,16},{-56,32}})));
  Modelica.Blocks.Sources.Constant const(k=298.15)
    annotation (Placement(transformation(extent={{-62,62},{-42,82}})));
  Modelica.Blocks.Sources.Constant const1(k=281.15)
    annotation (Placement(transformation(extent={{20,56},{40,76}})));
  Modelica.Blocks.Sources.Sine sine(amplitude=0.1, freqHz=0.005)
    annotation (Placement(transformation(extent={{-30,76},{-10,96}})));
  Modelica.Blocks.Sources.Constant const2(k=303.15)
    annotation (Placement(transformation(extent={{-18,44},{2,64}})));
equation
  connect(indoorSwimmingPool.openingHours, tableOpeningHours.y[1])
    annotation (Line(points={{-29.55,24.36},{-42,24.36},{-42,24},{-55.2,24}}, color={0,0,127}));
  connect(const.y, indoorSwimmingPool.TRad)
    annotation (Line(points={{-41,72},{-41,51},{-19.32,51},{-19.32,29.68}}, color={0,0,127}));
  connect(const1.y, indoorSwimmingPool.TSoil)
    annotation (Line(points={{41,66},{40,66},{40,15.4},{36.17,15.4}}, color={0,0,127}));
  connect(sine.y, indoorSwimmingPool.X_w)
    annotation (Line(points={{-9,86},{8,86},{8,29.4},{25.63,29.4}}, color={0,0,127}));
  connect(const2.y, indoorSwimmingPool.TAir)
    annotation (Line(points={{3,54},{-66,54},{-66,29.4},{16.33,29.4}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
          preserveAspectRatio=false)),
    experiment(StopTime=200));
end Example;
