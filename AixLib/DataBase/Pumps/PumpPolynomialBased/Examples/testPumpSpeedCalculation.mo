within AixLib.DataBase.Pumps.PumpPolynomialBased.Examples;
model testPumpSpeedCalculation
  "test the functions to calculate pump speed from volume flow rate and pump head."
  extends Modelica.Icons.Example;

  // **************************************************
  //           Select pump record here:
  //
  parameter AixLib.DataBase.Pumps.PumpPolynomialBased.PumpBaseRecord param=
      AixLib.DataBase.Pumps.PumpPolynomialBased.Pump_DN25_H1_6_V4()
    "New pump record with coefficients.";
  //
  // **************************************************

  function speedFlowHeadFunc =
      AixLib.Fluid.Movers.PumpsPolynomialBased.BaseClasses.polynomial2D
    "polynomial evaluator using new aproach with coefficient matrix";
  function speedFlowHeadFuncABC =
      AixLib.Fluid.Movers.PumpsPolynomialBased.BaseClasses.polynomialABCinverse
    "polynomial evaluator using new aproach with coefficient matrix";

  parameter Real maxQ(unit="m3/h", displayUnit="m3/h") = param.maxMinHeight[
    size(param.maxMinHeight, 1), 1];
  parameter Modelica.Units.SI.Length maxHead=max(param.maxMinHeight[:, 2])
    "maximum static head of the pump";
  parameter Modelica.Units.SI.Length minHead=max(param.maxMinHeight[:, 3])
    "aprox. minimum static head of the pump";

  Modelica.Blocks.Sources.TimeTable headTable(table=[
    0.0,  minHead+(maxHead-minHead)*0.0;
    0.99, minHead+(maxHead-minHead)*0.0;
    1,    minHead+(maxHead-minHead)*0.25;
    1.99, minHead+(maxHead-minHead)*0.25;
    2,    minHead+(maxHead-minHead)*0.5;
    2.99, minHead+(maxHead-minHead)*0.5;
    3,    minHead+(maxHead-minHead)*0.75;
    3.99, minHead+(maxHead-minHead)*0.75;
    4,    minHead+(maxHead-minHead)*1.0;
    4.99, minHead+(maxHead-minHead)*1.0])
    "selects different pump speeds"
    annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  Modelica.Blocks.Sources.TimeTable volumeFlowTable(table=[
    0.0,  0.0;
    0.99, maxQ;
    1,    0;
    1.99, maxQ;
    2,    0;
    2.99, maxQ;
    3,    0;
    3.99, maxQ;
    4,    0;
    4.99, maxQ]) "selects different volume flows"
    annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));
//   Modelica.Blocks.Sources.RealExpression speed(y=speedFlowHeadFunc(
//         param.cNQH,
//         volumeFlowTable.y,
//         headTable.y)) if sum(abs(param.cNQH)) <> 0
//     annotation (Placement(transformation(extent={{-20,10},{0,30}})));
  Modelica.Blocks.Sources.RealExpression speedABC(y=speedFlowHeadFuncABC(
        {param.cHQN[3,1], param.cHQN[2,2], param.cHQN[1,3]},
        volumeFlowTable.y,
        headTable.y)) if sum(abs({param.cHQN[3,1], param.cHQN[2,2],
          param.cHQN[1,3]})) <> 0
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));

  annotation (
    experiment(StopTime=5),
    Documentation(info="<html><p>
  simulate and plot script
</p>
<p>
  Use this test to test the polynomial functions for pump speed
  calculation and their respective coefficients from <a href=
  \"Zugabe.Zugabe_DB.Pump.PumpBaseRecord\">Zugabe.Zugabe_DB.Pump.PumpBaseRecord</a>.
  As of December 2017 the coefficient matrix cNQH has been disregarded
  due to the new pump model that only uses pump speed for control and
  which will limit the pump speed (maxMinSpeedCurves) rather than the
  pump head. Therefore, a direct calculation using the cNQH
  coefficients is not possible anymore in the old pump models.
</p>
<p>
  Currently only the ABC-coefficients may be used to compute pump speed
  from cHQN coefficients applied to the inverse p-q-formula.
</p>
<p>
  This test case makes use of nMin and nMax parameters of the pump
  record in the table for setting pump speed. Make sure that these
  values are set properly in the pump record or change the profile in
  the speed table.
</p>
<ul>
  <li>2018-01-24 by Peter Matthes:<br/>
    Highlights pumpParam parameter and adds graphic for pump speed
    curve display in plot Script.
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
          extent={{-92,96},{92,62}},
          lineColor={28,108,200},
          horizontalAlignment=TextAlignment.Left,
          textString="Select parameter record \"param\" in text view.
Test is not fully functional anymore due to missing cNQH coefficient matrix.")}),
    __Dymola_Commands(file(ensureSimulated=true) = "Resources/Scripts/Dymola/DataBase/Pumps/ControlPump/Examples/testPumpSpeedCalculation.mos"));
end testPumpSpeedCalculation;
