within AixLib.DataBase.Pumps.PumpPolynomialBased.Examples;
model testPumpHeadCalculation
  "Calculates pump head from volume flow rate and pump speed."
  extends Modelica.Icons.Example;

  // **************************************************
  //           Select pump record here:
  //
  parameter AixLib.DataBase.Pumps.PumpPolynomialBased.PumpBaseRecord param=
      AixLib.DataBase.Pumps.PumpPolynomialBased.Pump_DN25_H1_6_V4()
    "new pump record with coefficients.";
  //
  // **************************************************

  function headFlowSpeedFuncNew =
      AixLib.Fluid.Movers.PumpsPolynomialBased.BaseClasses.polynomial2D
    "polynomial evaluator using new aproach with coefficient matrix";

  function headFlowSpeedFuncNewABC =
      AixLib.Fluid.Movers.PumpsPolynomialBased.BaseClasses.polynomialABC
    "polynomial evaluator using new aproach with coefficient matrix";

  parameter Real maxQ(unit="m3/h", displayUnit="m3/h") = param.maxMinHeight[
    size(param.maxMinHeight, 1), 1];

  Modelica.Blocks.Sources.TimeTable speedTable(table=[
    0.00, param.nMin + (param.nMax - param.nMin)*0;
    0.99, param.nMin + (param.nMax - param.nMin)*0;
    1.00, param.nMin + (param.nMax - param.nMin)*0.25;
    1.99, param.nMin + (param.nMax - param.nMin)*0.25;
    2.00, param.nMin + (param.nMax - param.nMin)*0.5;
    2.99, param.nMin + (param.nMax - param.nMin)*0.5;
    3.00, param.nMin + (param.nMax - param.nMin)*0.75;
    3.99, param.nMin + (param.nMax - param.nMin)*0.75;
    4.00, param.nMin + (param.nMax - param.nMin)*1.0;
    4.99, param.nMin + (param.nMax - param.nMin)*1.0])
    "selects different pump speeds"
    annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  Modelica.Blocks.Sources.TimeTable volumeFlowTable(table=[
    0.0,  0.0;
    0.99, maxQ;
    1,    0.0;
    1.99, maxQ;
    2,    0.0;
    2.99, maxQ;
    3,    0.0;
    3.99, maxQ;
    4,    0.0;
    4.99, maxQ]) "selects different pump speeds"
    annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));
  Modelica.Blocks.Sources.RealExpression headNew(y=headFlowSpeedFuncNew(
        param.cHQN,
        volumeFlowTable.y,
        speedTable.y)) if sum(abs(param.cHQN)) <> 0
    annotation (Placement(transformation(extent={{-20,10},{0,30}})));

  Modelica.Blocks.Sources.RealExpression headNewABC(y=headFlowSpeedFuncNewABC(
        {param.cHQN[3,1], param.cHQN[2,2], param.cHQN[1,3]},
        volumeFlowTable.y,
        speedTable.y)) if sum(abs({param.cHQN[3,1], param.cHQN[2,2],
          param.cHQN[1,3]})) <> 0
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));

  annotation (
    experiment(StopTime=5),
    __Dymola_Commands(file(ensureSimulated=true) = "Resources/Scripts/Dymola/DataBase/Pumps/ControlPump/Examples/testPumpHeadCalculation.mos"),
    Documentation(info="<html><p>
  simulate and plot script
</p>
<p>
  Use this test to check pump head calculation with the polynomial
  functions and respective coefficients from <a href=
  \"Zugabe.Zugabe_DB.Pump.PumpBaseRecord\">Zugabe.Zugabe_DB.Pump.PumpBaseRecord</a>.
</p>
<p>
  This test case makes use of nMin and nMax parameters of the pump
  record in the table for setting pump speed. Make sure that these
  values are set properly in the pump record or change the profile in
  the speed table.
</p>
<ul>
  <li>2018-01-24 by Peter Matthes:<br/>
    Highlights pumpParam parameter and adds graphic for pump head curve
    display in plot Script.
  </li>
  <li>2017-12-06 by Peter Matthes:<br/>
    Adds hint for nMin and nMax in the documentation and fixes test for
    missing ABC coefficients.
  </li>
  <li>2017-11-23 by Peter Matthes:<br/>
    Implemented
  </li>
</ul>
</html>"),
    Diagram(graphics={Text(
          extent={{-92,94},{92,60}},
          lineColor={28,108,200},
          textString="Select function \"headFlowSpeedFuncNew\" and
parameter record \"param\" for comparison
in text view.",
          horizontalAlignment=TextAlignment.Left)}));
end testPumpHeadCalculation;
