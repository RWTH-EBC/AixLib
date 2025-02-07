within AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle;
model TableData3D
  "3D data: condenser temperature, evaporator temperature, compressor speed"
  extends AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.BaseClasses.PartialTableData3D;
  extends
    AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.BaseClasses.PartialHeatPumpTableDataND(
    final u_nominal={TCon_nominal,TEva_nominal,y_nominal},
    final nDim=3,
    redeclare replaceable
      AixLib.Fluid.HeatPumps.ModularReversible.Data.TableDataSDF.TableData3D.Generic
      datTab);
equation
  connect(mux.u[3], sigBus.yMea) annotation (Line(points={{-80,52.3333},{-80,50},
          {-102,50},{-102,120},{1,120}},    color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (                                 Documentation(revisions="<html>
<ul>
  <li>
    <i>August 27, 2024</i> by Fabian Wuellhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/1520\">AixLib #1520</a>)
  </li>
</ul>
</html>", info="<html>
<p>
  This model uses three-dimensional table data possibly given
  by manufacturers or estimated using other tools, such as VCLibPy, to calculate
  <code>QCon_flow</code> and <code>PEle</code>.
</p>
<p>
  Note that losses are often implicitly included in measured data.
  In this case, the frosting modules should be disabled.
</p>

<h4>Scaling factor</h4>
<p>
For the scaling factor, the table data for condenser heat flow rate (<code>QConTabDat_flow</code>)
is evaluated at nominal conditions. Hence, the scaling factor is
</p>
<pre>
scaFac = QCon_flow_nominal/QConTabDat_flow(TCon_nominal, TEva_nominal, y_nominal).

</pre>
<p>
Using <code>scaFac</code>, the table data is scaled linearly.
This implies a constant COP over different design sizes:
</p>
<p><code>QCon_flow = scaFac * tabQCon_flow.y</code> </p>
<p><code>PEle = scaFac * tabPel.y</code></p>


</html>"));
end TableData3D;
