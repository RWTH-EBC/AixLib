within AixLib.Controls.HeatPump.ModularHeatPumps;
model ModularExpansionValveController
  "Model of an internal controller for modular expansion valves"
  extends BaseClasses.PartialModularController;

  Modelica.Blocks.Sources.Sine valveOpening(
    amplitude=0.45,
    freqHz=1,
    offset=0.5)
    "Input signal to prediscribe expansion valve's opening"
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));


equation
  opeSet = fill(valveOpening.y,nVal);

  annotation (Icon(graphics={
        Polygon(
          points={{0,-34},{-30,-14},{-30,-54},{0,-34}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Polygon(
          points={{0,-34},{30,-14},{30,-54},{0,-34}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Line(
          points={{0,-22},{0,-34}},
          color={0,0,0},
          thickness=0.5),
        Ellipse(
          extent={{-14,6},{14,-22}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-14,6},{14,-22}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          textString="M",
          textStyle={TextStyle.Bold})}));
end ModularExpansionValveController;
