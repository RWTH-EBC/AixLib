within AixLib.Fluid.DistrictHeatingCooling.Demands.Substations.HeatTransfer;
model NoHeatTransfer
  "Ideal container with direct throughflow instead of heat transfer in DHC substations"
  extends BaseClasses.Demands.Substations.HeatTransfer.PartialHeatTransfer(
    use_Q_in=false,
    prescribedQ=0);
equation
  connect(port_a, port_b)
    annotation (Line(points={{-100,0},{100,0}}, color={0,127,255}));
  annotation (Documentation(info="<html><p>
  This is a basic placeholder. Instead of heat exchanger behavior, this
  model does not affect the fluid.
</p>
</html>", revisions="<html>
<ul>
  <li>June 18, 2017, by Marcus Fuchs:<br/>
    First implementation for <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/403\">issue 403</a>).
  </li>
</ul>
</html>"), Icon(graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Line(points={{-90,0},{90,0}}, color={
              28,108,200})}));
end NoHeatTransfer;
