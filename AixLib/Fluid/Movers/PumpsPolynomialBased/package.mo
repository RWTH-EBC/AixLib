within AixLib.Fluid.Movers;
package PumpsPolynomialBased "Pump models with control block and new configuration approach"
extends Modelica.Icons.Package;



  annotation (preferredView="info",
    Icon(graphics={Ellipse(
        extent={{-68,66},{66,-68}},
        lineColor={0,0,0},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid), Polygon(
        points={{-2,66},{-2,-68},{66,0},{-2,66}},
        lineColor={0,0,0},
        fillColor={0,0,0},
        fillPattern=FillPattern.Solid)}),
  Documentation(info="<html><p>
  This packages contains pump models with a different, not so
  sophisitcated, mathematical approach than the original IBPSA models
  in Fluid.Movers.
</p>
<p>
  The models PumpSpeedControlled and PumpHeadControlled were developed
  in the Zugabe project at the E.ON Energy Research Center. The main
  advantage to users might be
</p>
<ul>
  <li>the way how to generate pump curves (performance data).
  </li>
  <li>That the model respects power limitation that manufacturers
  impose on most of their pumps.
  </li>
</ul>
<p>
  Using measurement or catalogue data of volume flow rate (m³/h), pump
  head (m), rotational speed set (rpm) and rotational speed act (rpm) a
  python script will generate a record with all necessary parameters
  for the model. Documentation with a visualization of the respective
  pump curves is included in the record.
</p>
<p>
  In order to limit the pump's power consumption manufacturer normally
  will reduce the allowed pump speed for large volume flow rates, hence
  deforming the pump curves. This model takes the limitation into
  account based on the available catalogue or measurement data. Note
  that a design engineer normally only has catalogue data at his
  command.
</p>
<p>
  This package is currently work in progress.
</p>
<ul>
  <li>Documentation needs updating.
  </li>
  <li>Some models in Examples package might be transferred to a
  Validation package.
  </li>
  <li>The names of the pump models might change in oder to better suite
  the naming convention in Fluid.Movers.
  </li>
  <li>The Fluid.Movers package is designed around Michael Wetter's pump
  models. Integrating the pumps in this package directly might confuse
  users as it is not clear what the differences are. Especially
  intergrating models in the sub-packages might lead to confusion to
  which top level package they belong to. Therefore, we decided to keep
  them a separate. Maybe it is possible to merge ideas (stable
  mathematical approach) from the Fluid.Movers-pumps into here.
  </li>
</ul>
<ul>
  <li>2019-09-18 by Alexander Kümpel:<br/>
    Renaming and restructuring.
  </li>
  <li>2018-05-14 by Peter Matthes:<br/>
    Transfered package from internal \"Zugabe\" library into AixLib.
  </li>
</ul>
</html>"));
end PumpsPolynomialBased;
