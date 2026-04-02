within AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle;
model TableData4DDeltaT
  "4D data: condenser temperature, evaporator temperature, compressor speed, condenser dT"
  extends AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.BaseClasses.PartialTableData3D;
  extends
    AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.BaseClasses.PartialHeatPumpTableDataND
    (
    redeclare replaceable
      AixLib.Fluid.HeatPumps.ModularReversible.Data.TableDataSDF.TableData4DDeltaTCon.VCLibPy.GenericVCLibPy4D
      datTab constrainedby AixLib.Fluid.HeatPumps.ModularReversible.Data.TableDataSDF.TableData4DDeltaTCon.VCLibPy.GenericVCLibPy4D,
    final u_nominal={TCon_nominal,TEva_nominal,y_nominal,dTCon_nominal},
    final nDim=4);

  parameter Modelica.Units.SI.TemperatureDifference dTCon_nominal=10
    "Nominal condenser temperature difference to calculate scaling factor";
  Modelica.Blocks.Math.Add dTConMea(final k2=-1, final k1=1) "Condenser delta T" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-130,50})));
equation
  connect(mux.u[3], sigBus.yMea) annotation (Line(points={{-80,50.875},{-80,50},
          {-102,50},{-102,120},{1,120}},    color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(dTConMea.y, mux.u[4]) annotation (Line(points={{-119,50},{-108,50},{
          -108,52.625},{-80,52.625}},
                    color={0,0,127}));
  connect(dTConMea.u1, sigBus.TConOutMea) annotation (Line(points={{-142,56},{
          -146,56},{-146,120},{1,120}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(dTConMea.u2, sigBus.TConInMea) annotation (Line(points={{-142,44},{
          -156,44},{-156,120},{1,120}}, color={0,0,127}), Text(
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
  This model uses four-dimensional table data estimated using tools, such as VCLibPy, to calculate
  <code>QCon_flow</code> and <code>PEle</code>.
  In addition to <a href=\"AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.TableData3D\">AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.TableData3D</a>, this model uses the secondary sides temperature spread at the condenser
  to estimate efficiency and power. Thus, simulation studies with influence of consnder mass flow control 
  are possible. Developed for the publication Römer et al., where you can also see the validation and impact on heat pump system design.
</p>
<p>
  Note that losses are often not implicitly included in generated data.
  Thus, frosting modules should be used.
</p>

<h4>Scaling factor</h4>
<p>
For the scaling factor, the table data for condenser heat flow rate (<code>QConTabDat_flow</code>)
is evaluated at nominal conditions. Hence, the scaling factor is
</p>
<code>
scaFac = QCon_flow_nominal/QConTabDat_flow(TCon_nominal, TEva_nominal, y_nominal, dTCon_nominal).

</code>
<p>
Using <code>scaFac</code>, the table data is scaled linearly.
This implies a constant COP over different design sizes:
</p>
<p><code>QCon_flow = scaFac * tabQCon_flow.y</code> </p>
<p><code>PEle = scaFac * tabPel.y</code></p>
<h4>References</h4>
<p>
Römer, Fabian and Fuchs, Nico and Fuchs, Nico and Müller, Dirk, Practical, Near-Optimal Design Rule Extraction for Heat Pumps in Single-Family Buildings (September 03, 2025). Available at SSRN: 
<a href=\"https://ssrn.com/abstract=5633891\">https://ssrn.com/abstract=5633891</a>
</p>

</html>"));
end TableData4DDeltaT;
