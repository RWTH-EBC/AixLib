within AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle;
model TableData4DdTeva
  "4D data: condenser temperature, evaporator temperature, compressor speed, evaporator dT"
  extends
    AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.BaseClasses.PartialHeatPumpTableDataND(
    redeclare
      AixLib.Fluid.HeatPumps.ModularReversible.Data.TableDataSDF.TableData4DDeltaTEva.VCLibPy.StandardPropane
      datTab,
    final u_nominal={TCon_nominal,TEva_nominal,y_nominal,dTEva_nominal},
    final nDim=4);
  parameter Modelica.Units.SI.TemperatureDifference dTEva_nominal=10
    "Nominal evaporator temperature difference to calculate scaling factor";
  parameter Real y_nominal(final min=0, final max=1, final unit="1")=1
    "Nominal compressor speed"
    annotation (Dialog(group="Nominal condition"));
  Modelica.Blocks.Math.Add dTEvaMea(final k2=-1, final k1=1)
    "Evaporator delta T"                                                         annotation (
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
  connect(dTEvaMea.y, mux.u[4]) annotation (Line(points={{-119,50},{-108,50},{
          -108,52.625},{-80,52.625}},
                    color={0,0,127}));
  connect(dTEvaMea.u1, sigBus.TEvaInMea) annotation (Line(points={{-142,56},{
          -146,56},{-146,120},{1,120}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(dTEvaMea.u2, sigBus.TEvaOutMea) annotation (Line(points={{-142,44},{
          -156,44},{-156,120},{1,120}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (                                 Documentation(revisions="<html>
<ul>
<li>October 09, 2025, by Hannah Vering:<br>Adapted to include dt Evaporator (see issue <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1602\">AixLib #1602</a>) </li>
<li><i>August 27, 2024</i> by Fabian Wuellhorst:<br>First implementation (see issue <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1520\">AixLib #1520</a>) </li>
</ul>
</html>", info="<html>
<p>This model uses four-dimensional table data estimated using tools, such as VCLibPy, to calculate <span style=\"font-family: Courier New;\">QCon_flow</span> and <span style=\"font-family: Courier New;\">PEle</span>. In addition to <a href=\"AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.TableData3D\">AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.TableData3D</a>, this model uses the secondary side&apos;s temperature spread at the evaporator to estimate efficiency and power. This is mainly relevant for heat pumps with large temperature difference over the heat source such asfor example exhaust air heat pumps due to limited exhaust air flow.</p>
<p>Note that losses are often implicitly included in measured data. In this case, the frosting modules should be disabled. </p>
<h4>Scaling factor</h4>
<p>For the scaling factor, the table data for condenser heat flow rate (<span style=\"font-family: Courier New;\">QConTabDat_flow</span>) is evaluated at nominal conditions. Hence, the scaling factor is </p>
<p><span style=\"font-family: Courier New;\">scaFac = QCon_flow_nominal/QConTabDat_flow(TCon_nominal, TEva_nominal, y_nominal, dTEva_nominal).</span></p>
<p><br>Using <span style=\"font-family: Courier New;\">scaFac</span>, the table data is scaled linearly. This implies a constant COP over different design sizes: </p>
<p><span style=\"font-family: Courier New;\">QCon_flow = scaFac * tabQCon_flow.y</span> </p>
<p><span style=\"font-family: Courier New;\">PEle = scaFac * tabPel.y</span> </p>
</html>"));
end TableData4DdTeva;
