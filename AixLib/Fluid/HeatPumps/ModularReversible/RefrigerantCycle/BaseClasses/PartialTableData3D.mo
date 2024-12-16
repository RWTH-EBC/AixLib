within AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.BaseClasses;
partial model PartialTableData3D
  "Partial model with components for TableData3D approach for heat pumps and chillers"
  extends AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.BaseClasses.PartialTableDataSDF(final
      nDim=3);
  parameter Real y_nominal(final min=0, final max=1, final unit="1")=1
    "Nominal electrical power consumption"
    annotation (Dialog(group="Nominal condition"));


  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,
            -120},{120,120}})),
    Documentation(info="<html>
<p>
  Partial model for equations and componenents used in both heat pump
  and chiller models using three-dimensional data.
</p>
</html>", revisions="<html>
<ul>  <li>
    <i>August 27, 2024</i> by Fabian Wuellhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/1520\">AixLib #1520</a>)
  </li></ul>
</html>"),
    Icon(coordinateSystem(extent={{-120,-120},{120,120}})));
end PartialTableData3D;
