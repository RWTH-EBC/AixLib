within AixLib.DataBase.Pumps.PumpPolynomialBased;
package Examples "Contains tests to check the parameters of the records."
extends Modelica.Icons.ExamplesPackage;
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
    Modelica.Blocks.Tables.CombiTable1D maxMinTable(
      columns={2,3},
      tableName="NoName",
      tableOnFile=false,
      table=param.maxMinHeight)
      "Outputs static head (H). Maximum, minimum and freely selectable pump curve"
      annotation (Placement(transformation(extent={{-11,-10},{9,10}},  rotation=0)));
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
      Documentation(revisions="<html>
<ul>
<li><pre>2017-11-23 by Peter Matthes<br />Implemented.</pre></li>
</ul>
</html>",   info="<html>
<p>This test can be used to display the maximum and minimum pump curves as defined in the maxMinHeight parameter matrix.</p>
</html>"),
      experiment,
      __Dymola_Commands(file(ensureSimulated=true) = "Resources/Scripts/Dymola/DataBase/Pumps/ControlPump/Examples/testMaxMinHeightTable.mos"));
  end testMaxMinHeightTable;

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
      Documentation(info="<html>
<p>simulate and plot script</p>
<p>Use this test to check pump head calculation with the polynomial functions and respective coefficients from <a href=\"Zugabe.Zugabe_DB.Pump.PumpBaseRecord\">Zugabe.Zugabe_DB.Pump.PumpBaseRecord</a>.</p>
<p>This test case makes use of nMin and nMax parameters of the pump record in the table for setting pump speed. Make sure that these values are set properly in the pump record or change the profile in the speed table.</p>
</html>",   revisions="<html>
<ul>
<li>2018-01-24 by Peter Matthes:<br />Highlights pumpParam parameter and adds graphic for pump head curve display in plot Script.</li>
<li>2017-12-06 by Peter Matthes:<br />Adds hint for nMin and nMax in the documentation and fixes test for missing ABC coefficients.</li>
<li>2017-11-23 by Peter Matthes:<br />Implemented</li>
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

  model testPumpPowerCalculation
    "Calculates pump power from volume flow rate and pump speed."
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

    Modelica.Blocks.Sources.RealExpression power(y=headFlowSpeedFuncNew(
          param.cPQN,
          volumeFlowTable.y,
          speedTable.y)) if sum(abs(param.cPQN)) <> 0
      annotation (Placement(transformation(extent={{-20,10},{0,30}})));

    annotation (
      experiment(StopTime=5),
      __Dymola_Commands(file(ensureSimulated=true) = "Resources/Scripts/Dymola/DataBase/Pumps/ControlPump/Examples/testPumpPowerCalculation.mos"),
      Documentation(info="<html>
<p>simulate and plot script</p>
<p>Use this test to check pump power calculation with the polynomial function and the cPQN coefficients from <a href=\"Zugabe.Zugabe_DB.Pump.PumpBaseRecord\">Zugabe.Zugabe_DB.Pump.PumpBaseRecord</a>.</p>
<p>Be aware, that there is no power limitation implemented here. So the results show only the output of the pure polynomial function. In the pump model the power will be limited by the maxMinHeight curves.</p>
<p>This test case makes use of nMin and nMax parameters of the pump record in the table for setting pump speed. Make sure that these values are set properly in the pump record or change the profile in the speed table.</p>
</html>",   revisions="<html>
<ul>
<li>2018-01-24 by Peter Matthes:<br />Highlights pumpParam parameter and adds graphic for pump power curve display in plot Script.</li>
<li>2017-12-06 by Peter Matthes:<br />Adds hint for nMin and nMax in the documentation.</li>
<li>2017-11-23 by Peter Matthes:<br />Implemented</li>
</ul>
</html>"),
      Diagram(graphics={Text(
            extent={{-92,94},{92,60}},
            lineColor={28,108,200},
            textString="Select parameter record \"param\" in text view.",
            horizontalAlignment=TextAlignment.Left)}));
  end testPumpPowerCalculation;

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
    parameter Modelica.SIunits.Length maxHead = max(param.maxMinHeight[:, 2])
      "maximum static head of the pump";
    parameter Modelica.SIunits.Length minHead = max(param.maxMinHeight[:, 3])
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
      Documentation(info="<html>
<p>simulate and plot script</p>
<p>Use this test to test the polynomial functions for pump speed calculation and their respective coefficients from <a href=\"Zugabe.Zugabe_DB.Pump.PumpBaseRecord\">Zugabe.Zugabe_DB.Pump.PumpBaseRecord</a>. As of December 2017 the coefficient matrix cNQH has been disregarded due to the new pump model that only uses pump speed for control and which will limit the pump speed (maxMinSpeedCurves) rather than the pump head. Therefore, a direct calculation using the cNQH coefficients is not possible anymore in the old pump models. </p>
<p>Currently only the ABC-coefficients may be used to compute pump speed from cHQN coefficients applied to the inverse p-q-formula. </p>
<p>This test case makes use of nMin and nMax parameters of the pump record in the table for setting pump speed. Make sure that these values are set properly in the pump record or change the profile in the speed table.</p>
</html>",   revisions="<html>
<ul>
<li>2018-01-24 by Peter Matthes:<br />Highlights pumpParam parameter and adds graphic for pump speed curve display in plot Script.</li>
<li>2017-12-06 by Peter Matthes:<br />Adds hint for nMin and nMax in the documentation and fixes test for missing ABC coefficients.</li>
<li>2017-11-23 by Peter Matthes:<br />Implemented</li>
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
end Examples;
