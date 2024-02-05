within AixLib.Fluid.DistrictHeatingCooling.Supplies.Controllers.Temperature;
model ControllerTConst "Constant temperature control signal"
  extends PartialControllerT;

  Modelica.Blocks.Sources.Constant const(k=T_set)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  parameter Modelica.SIunits.Temperature T_set "Constant set temperature";


equation
  connect(const.y, y)
    annotation (Line(points={{11,0},{110,0}}, color={0,0,127}));
  annotation (Icon(graphics={Text(
          extent={{-68,-8},{76,-74}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.None,
          textString="const")}));
end ControllerTConst;
