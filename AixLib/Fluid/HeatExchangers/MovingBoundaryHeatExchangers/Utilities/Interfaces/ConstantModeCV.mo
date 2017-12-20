within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities.Interfaces;
block ConstantModeCV
  "Output of constant kind of control volume of a moving boundary heat exchanger"
  extends Modelica.Blocks.Icons.Block;

  // Definition of parameters
  //
  parameter Utilities.Types.ModeCV forModCV=
    Types.ModeCV.SCTPSH
    "Kind of control volume of moving boundary heat exchanger"
    annotation (Dialog(tab="General",group="General"));

  // Definition of subcomponents and connectors
  //
  ModeCVOutput ModCV
    "Output of kind of control volume of moving boundary heat exchanger"
    annotation (Placement(transformation(extent={{92,-10},
                {112,10}}), iconTransformation(extent={{92,-10},{112,10}})));

equation
  ModCV = forModCV "Connecting parameter with output";

  annotation (Icon(graphics={
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
        Line(points={{-80,0},{80,0}}),
        Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
        Polygon(
          points={{90,-70},{68,-62},{68,-78},{90,-70}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-80,60},{80,-40}},
          lineColor={28,108,200},
          textString="%forModCV")}));
end ConstantModeCV;
