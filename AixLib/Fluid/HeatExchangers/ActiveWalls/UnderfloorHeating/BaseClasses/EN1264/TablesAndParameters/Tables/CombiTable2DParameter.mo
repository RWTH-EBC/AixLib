within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.EN1264.TablesAndParameters.Tables;
block CombiTable2DParameter
  "Table look-up in two dimensions with two inputs and one output as parameters"

function getTableValue "Interpolate 2-dim. table defined by matrix"
    extends Modelica.Icons.Function;
    input Modelica.Blocks.Types.ExternalCombiTable2D tableID;
    input Real u1;
    input Real u2;
    input Real tableAvailable
      "Dummy input to ensure correct sorting of function calls";
    output Real y;
    external"C" y = ModelicaStandardTables_CombiTable2D_getValue(tableID, u1, u2)
      annotation (Library={"ModelicaStandardTables", "ModelicaMatIO", "zlib"});
    annotation (derivative(noDerivative=tableAvailable) = getDerTableValue);
end getTableValue;

function getDerTableValue
    "Derivative of interpolated 2-dim. table defined by matrix"
    extends Modelica.Icons.Function;
    input Modelica.Blocks.Types.ExternalCombiTable2D tableID;
    input Real u1;
    input Real u2;
    input Real tableAvailable
      "Dummy input to ensure correct sorting of function calls";
    input Real der_u1;
    input Real der_u2;
    output Real der_y;
    external"C" der_y = ModelicaStandardTables_CombiTable2D_getDerValue(tableID, u1, u2, der_u1, der_u2)
      annotation (Library={"ModelicaStandardTables", "ModelicaMatIO", "zlib"});
end getDerTableValue;

  parameter Real table[:, :]
     "Table matrix (grid u1 = first column, grid u2 = first row; e.g., table=[0,0;0,1])"
    annotation (Dialog(group="Table data definition"));

  final parameter Modelica.Blocks.Types.ExternalCombiTable2D tableID=
      Modelica.Blocks.Types.ExternalCombiTable2D(
        "NoName",
        "NoName",
        table,
        Modelica.Blocks.Types.Smoothness.LinearSegments) "External table object";

  parameter Real u1;
  parameter Real u2;
  final parameter Real y = getTableValue(tableID, u1, u2, 1.0);

equation

  annotation (Icon(
    coordinateSystem(preserveAspectRatio=true,
      extent={{-100.0,-100.0},{100.0,100.0}}),
      graphics={                Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
    Line(points={{-60.0,40.0},{-60.0,-40.0},{60.0,-40.0},{60.0,40.0},{30.0,40.0},{30.0,-40.0},{-30.0,-40.0},{-30.0,40.0},{-60.0,40.0},{-60.0,20.0},{60.0,20.0},{60.0,0.0},{-60.0,0.0},{-60.0,-20.0},{60.0,-20.0},{60.0,-40.0},{-60.0,-40.0},{-60.0,40.0},{60.0,40.0},{60.0,-40.0}}),
    Line(points={{0.0,40.0},{0.0,-40.0}}),
    Line(points={{-60.0,40.0},{-30.0,20.0}}),
    Line(points={{-30.0,40.0},{-60.0,20.0}}),
    Rectangle(origin={2.3077,-0.0},
      fillColor={255,215,136},
      fillPattern=FillPattern.Solid,
      extent={{-62.3077,0.0},{-32.3077,20.0}}),
    Rectangle(origin={2.3077,-0.0},
      fillColor={255,215,136},
      fillPattern=FillPattern.Solid,
      extent={{-62.3077,-20.0},{-32.3077,0.0}}),
    Rectangle(origin={2.3077,-0.0},
      fillColor={255,215,136},
      fillPattern=FillPattern.Solid,
      extent={{-62.3077,-40.0},{-32.3077,-20.0}}),
    Rectangle(fillColor={255,215,136},
      fillPattern=FillPattern.Solid,
      extent={{-30.0,20.0},{0.0,40.0}}),
    Rectangle(fillColor={255,215,136},
      fillPattern=FillPattern.Solid,
      extent={{0.0,20.0},{30.0,40.0}}),
    Rectangle(origin={-2.3077,-0.0},
      fillColor={255,215,136},
      fillPattern=FillPattern.Solid,
      extent={{32.3077,20.0},{62.3077,40.0}}),
                                        Text(
        extent={{-150,150},{150,110}},
        textString="%name",
        lineColor={0,0,255})}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Rectangle(
          extent={{-60,60},{60,-60}},
          fillColor={235,235,235},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Text(
          extent={{-100,100},{100,64}},
          textString="2 dimensional linear table interpolation",
          lineColor={0,0,255}),
        Line(points={{-54,40},{-54,-40},{54,-40},{54,40},{28,40},{28,-40},{-28,
              -40},{-28,40},{-54,40},{-54,20},{54,20},{54,0},{-54,0},{-54,-20},
              {54,-20},{54,-40},{-54,-40},{-54,40},{54,40},{54,-40}}, color={
              0,0,0}),
        Line(points={{0,40},{0,-40}}),
        Rectangle(
          extent={{-54,20},{-28,0}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-54,0},{-28,-20}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-54,-20},{-28,-40}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-28,40},{0,20}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{0,40},{28,20}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{28,40},{54,20}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Line(points={{-54,40},{-28,20}}),
        Line(points={{-28,40},{-54,20}}),
        Text(
          extent={{-54,-40},{-30,-56}},
          textString="u1",
          lineColor={0,0,255}),
        Text(
          extent={{28,58},{52,44}},
          textString="u2",
          lineColor={0,0,255}),
        Text(
          extent={{-2,12},{32,-22}},
          textString="y",
          lineColor={0,0,255})}));
end CombiTable2DParameter;
