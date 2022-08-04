within AixLib.DataBase.Pumps.PumpPolynomialBased.Examples;
model testMaxMinHeightTable
  "Testing the max and min height curves from that table."
  extends Modelica.Icons.Example;
  parameter AixLib.DataBase.Pumps.PumpPolynomialBased.PumpBaseRecord param=
      AixLib.DataBase.Pumps.PumpPolynomialBased.Pump_DN30_H1_12_V13()
    "select the parameter record that you want to check here";
  parameter Real maxQ(unit="m3/h", displayUnit="m3/h") = param.maxMinHeight[
    size(param.maxMinHeight, 1), 1];
  Modelica.Blocks.Sources.Ramp Q(
    height=maxQ,
    duration=1,
    offset=0,
    startTime=0) "volume flow rate"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Interfaces.RealOutput HmaxCurve
    annotation (Placement(transformation(extent={{40,10},{80,50}})));
  Modelica.Blocks.Interfaces.RealOutput HminCurve
    annotation (Placement(transformation(extent={{40,-50},{80,-10}})));
  Modelica.Blocks.Tables.CombiTable1Dv maxMinTable(
    columns={2,3},
    tableName="NoName",
    tableOnFile=false,
    table=param.maxMinHeight)
    "Outputs static head (H). Maximum, minimum and freely selectable pump curve"
    annotation (Placement(transformation(extent={{-11,-10},{9,10}}, rotation=0)));
initial equation
  assert(
    (sum(abs(param.maxMinHeight)) <> 0),
    "In a pump model parameter record
    parameter matrix 'maxMinHeight' was all zero.",
    level=AssertionLevel.error);
equation

  connect(Q.y, maxMinTable.u[1])
    annotation (Line(points={{-39,0},{-13,0}}, color={0,0,127}));
  connect(maxMinTable.y[1], HmaxCurve)
    annotation (Line(points={{10,0},{28,0},{28,30},{60,30}}, color={0,0,127}));
  connect(maxMinTable.y[2], HminCurve) annotation (Line(points={{10,0},{28,0},{28,
          -30},{60,-30}}, color={0,0,127}));
  connect(Q.y, maxMinTable.u[2])
    annotation (Line(points={{-39,0},{-13,0}}, color={0,0,127}));
  annotation (
    Documentation(revisions="<html><ul>
  <li>
    <pre>2017-11-23 by Peter Matthes<br/>Implemented.</pre>
  </li>
</ul>
</html>", info="<html>
<p>
  This test can be used to display the maximum and minimum pump curves
  as defined in the maxMinHeight parameter matrix.
</p>
</html>"),
    experiment,
    __Dymola_Commands(file(ensureSimulated=true) = "Resources/Scripts/Dymola/DataBase/Pumps/ControlPump/Examples/testMaxMinHeightTable.mos"));
end testMaxMinHeightTable;
