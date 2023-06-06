within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses;
model DiscretizedFloorTemperatureAnalysis
  "Calculation of min, mean, and max floor surface temperature"
  parameter Integer dis(min=1);

  Modelica.Blocks.Math.MultiSum mulSum(final k=fill(1, mulSum.nu), nu=dis)
    "Sum up the single temperatures"
    annotation (Placement(transformation(extent={{-16,12},{-2,26}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor senTFloor[dis]
    "Temperature sensor for floor"
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.Blocks.Math.Division div "Divide sum by dis to build average"
    annotation (Placement(transformation(extent={{60,-50},{80,-30}})));
  Modelica.Blocks.Sources.Constant constDis(k=dis)
    "Constant discretization value"
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a[dis]
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Interfaces.RealOutput TFloorMea(unit="K", displayUnit="degC")
    "Mean floor temperature"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Math.MinMax minMax(nu=dis)
    "Min and max of all temperatures"
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  Modelica.Blocks.Interfaces.RealOutput TFloorMin(unit="K", displayUnit="degC")
    "Minimal floor temperature"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput TFloorMax(unit="K", displayUnit="degC")
    "Maximum floor temperature"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
equation
  connect(mulSum.y, div.u1) annotation (Line(points={{-0.81,19},{-0.81,18},{52,
          18},{52,-34},{58,-34}}, color={0,0,127}));
  connect(div.u2, constDis.y) annotation (Line(points={{58,-46},{8,-46},{8,-30},
          {1,-30}}, color={0,0,127}));

  connect(div.y, TFloorMea)
    annotation (Line(points={{81,-40},{110,-40}}, color={0,0,127}));
  connect(port_a, senTFloor.port) annotation (Line(points={{-100,0},{-66,0},{-66,
          30},{-60,30}}, color={191,0,0}));
  connect(senTFloor.T, mulSum.u) annotation (Line(points={{-39,30},{-22,30},{-22,
          19},{-16,19}}, color={0,0,127}));
  connect(minMax.u, senTFloor.T) annotation (Line(points={{-20,50},{-32,50},{-32,
          30},{-39,30}}, color={0,0,127}));
  connect(minMax.yMin, TFloorMin) annotation (Line(points={{1,44},{16,44},{16,
          40},{74,40},{74,0},{110,0}}, color={0,0,127}));
  connect(TFloorMax, minMax.yMax) annotation (Line(points={{110,40},{82,40},{82,
          56},{1,56}}, color={0,0,127}));
 annotation (Icon(graphics={
       Rectangle(
         extent={{-100,100},{100,-100}},
         lineColor={28,108,200},
         fillColor={255,255,255},
         fillPattern=FillPattern.Solid),
       Line(points={{-62,36},{4,36},{-30,36},{-30,-36}}, color={28,108,200}),
       Line(points={{-6,-56},{-6,-20},{12,-20},{-6,-20},{-6,-38},{4,-38}},
           color={28,108,200}),
       Line(points={{14,-52},{14,-58}}, color={28,108,200}),
       Line(points={{24,-56},{24,-40},{38,-40},{38,-56},{38,-40},{52,-40},
             {52,-56}}, color={28,108,200})}),
                 Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  Model for the calculation of the medium floor surface temperature
  using an underfloor heating circuit with <span style=
  \"font-family: Courier New;\">dis</span> elements
</p>
</html>"));
end DiscretizedFloorTemperatureAnalysis;
