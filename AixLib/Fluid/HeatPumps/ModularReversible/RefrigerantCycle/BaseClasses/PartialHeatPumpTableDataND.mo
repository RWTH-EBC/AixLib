within AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.BaseClasses;
partial model PartialHeatPumpTableDataND
  "Partial model with components for TableDataND approach for heat pumps"
  extends
    AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.BaseClasses.PartialHeatPumpCycle(
    final devIde=datTab.devIde,
    PEle_nominal=evaluate(extTabPEle, uOrdSca_nominal, interpMethod, extrapMethod) * scaFac);
  extends
    AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.BaseClasses.PartialTableDataSDF(
    facGain(final k=datTab.facGai),
    final useInRevDev=not useInHeaPum,
    scaFac=QHea_flow_nominal/QHeaNoSca_flow_nominal,
    final use_TConOutForTab=datTab.use_TConOutForTab,
    final use_TEvaOutForTab=datTab.use_TEvaOutForTab,
    nDTabPEle(
      final filename=datTab.filename,
      final dataset=datTab.datasetPEle,
      final dataUnit=datTab.dataUnitPEle,
      final scaleUnits=datTab.scaleUnitsPEle),
    nDTabQUse_flow(
      final filename=datTab.filename,
      final dataset=datTab.datasetQCon_flow,
      final dataUnit=datTab.dataUnitQCon_flow,
      final scaleUnits=datTab.scaleUnitsQCon_flow),
    ordInp(final outOrd=datTab.outOrd));
  parameter Modelica.Units.SI.HeatFlowRate QHeaNoSca_flow_nominal=evaluate(
        extTabQUse_flow, uOrdSca_nominal, interpMethod, extrapMethod)
    "Unscaled nominal heating capacity "
    annotation (Dialog(group="Nominal condition"));

  replaceable parameter
    AixLib.Fluid.HeatPumps.ModularReversible.Data.TableDataSDF.GenericHeatPump
    datTab constrainedby
    AixLib.Fluid.HeatPumps.ModularReversible.Data.TableDataSDF.GenericHeatPump
    "Data Table of HP" annotation (choicesAllMatching=true);

initial algorithm
  assert(datTab.nDim == nDim, "In " + getInstanceName() + ": 
    The provided SDF record does not match the specified dimensions", AssertionLevel.error);

equation

  connect(scaFacTimPel.y, PEle) annotation (Line(points={{-40,-21},{-40,-24},{0,
          -24},{0,-130}}, color={0,0,127}));
  connect(scaFacTimPel.y, redQCon.u2) annotation (Line(points={{-40,-21},{-40,-24},
          {64,-24},{64,-78}}, color={0,0,127}));
  connect(reaPasThrTEvaOut.u, sigBus.TEvaOutMea) annotation (Line(points={{-10,102},
          {-10,120},{1,120}},      color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(reaPasThrTEvaIn.u, sigBus.TEvaInMea) annotation (Line(points={{-50,102},
          {-50,120},{1,120}},                      color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(reaPasThrTConIn.u, sigBus.TConInMea) annotation (Line(points={{50,102},
          {50,120},{1,120}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(reaPasThrTConOut.u, sigBus.TConOutMea) annotation (Line(points={{90,102},
          {90,120},{1,120}},      color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  if useInHeaPum then
    connect(reaPasThrTConIn.y, mux.u[1])
      annotation (Line(points={{50,79},{50,70},{-80,70},{-80,50}},
                                                                 color={0,0,127}));
    connect(reaPasThrTConOut.y, mux.u[1])
      annotation (Line(points={{90,79},{90,70},{-80,70},{-80,50}},
                                                                 color={0,0,127}));
    connect(reaPasThrTEvaOut.y, mux.u[2]) annotation (Line(points={{-10,79},{-10,
            70},{-80,70},{-80,50}},   color={0,0,127}));
    connect(reaPasThrTEvaIn.y, mux.u[2]) annotation (Line(points={{-50,79},{-50,
            70},{-80,70},{-80,50}},
                                  color={0,0,127}));
  else
    connect(reaPasThrTEvaOut.y, mux.u[1]) annotation (Line(points={{-10,79},{
            -10,70},{-80,70},{-80,50}},               color={0,0,127}));
    connect(reaPasThrTEvaIn.y, mux.u[1]) annotation (Line(points={{-50,79},{-50,
            70},{-80,70},{-80,50}},               color={0,0,127}));
    connect(reaPasThrTConOut.y, mux.u[2])
      annotation (Line(points={{90,79},{90,70},{-80,70},{-80,50}},
                                                                 color={0,0,127}));
    connect(reaPasThrTConIn.y, mux.u[2])
      annotation (Line(points={{50,79},{50,70},{-80,70},{-80,50}},
                                                                 color={0,0,127}));
  end if;
  connect(scaFacTimPel.y, feeHeaFloEva.u1) annotation (Line(points={{-40,-21},{-40,
          -24},{-86,-24},{-86,-10},{-78,-10}}, color={0,0,127}));
  connect(scaFacTimQUse_flow.y, feeHeaFloEva.u2) annotation (Line(points={{40,-21},
          {40,-26},{-70,-26},{-70,-18}}, color={0,0,127}));
  connect(booToRea.u, sigBus.onOffMea) annotation (Line(points={{-80,102},{-80,
          120},{1,120}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(nDTabSta.y, sigBus.extSta) annotation (Line(points={{110,19},{110,10},
          {128,10},{128,120},{1,120}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
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
end PartialHeatPumpTableDataND;
