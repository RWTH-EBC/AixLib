within AixLib.Airflow.WindowVentilation;
package EmpiricalExpressions "Empirical expressions for calculation of the airflow"
  extends Modelica.Icons.VariantsPackage;

annotation (Documentation(info="<html>
<p>This package contains different empirical expressions to estimate the air flow rate by single-sided window ventilation.</p>
<p>The table below presents the applicable use cases for each expression.</p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\" width=\"100%\"><tr>
<td><p>Model</p></td>
<td><p>Simple opening</p></td>
<td><p>Side-hung opening</p></td>
<td><p>Top- and Bottom-hung opening</p></td>
<td><p>Pivot opening</p></td>
<td><p>Sliding opening</p></td>
</tr>
<tr>
<td><p>Gids and Phaff (1982)</p></td>
<td><p><span style=\"color: #ee2e2f;\">Y</span></p></td>
<td><p><span style=\"color: #1c6cc8;\">?</span></p></td>
<td><p><span style=\"color: #1c6cc8;\">?</span></p></td>
<td><p><span style=\"color: #1c6cc8;\">?</span></p></td>
<td><p><span style=\"color: #1c6cc8;\">?</span></p></td>
</tr>
<tr>
<td><p>Warren and Parkins (1984)</p></td>
<td><p><span style=\"color: #ee2e2f;\">Y</span></p></td>
<td><p><span style=\"color: #1c6cc8;\">?</span></p></td>
<td><p><span style=\"color: #1c6cc8;\">?</span></p></td>
<td><p><span style=\"color: #1c6cc8;\">?</span></p></td>
<td><p><span style=\"color: #1c6cc8;\">?</span></p></td>
</tr>
<tr>
<td><p>Maas (1995)</p></td>
<td><p>N</p></td>
<td><p><span style=\"color: #ee2e2f;\">Y</span></p></td>
<td><p><span style=\"color: #ee2e2f;\">Y</span></p></td>
<td><p>N</p></td>
<td><p>N</p></td>
</tr>
<tr>
<td><p>Hall (2004)</p></td>
<td><p>N</p></td>
<td><p>N</p></td>
<td><p>Only bottom-hung, inward</p></td>
<td><p>N</p></td>
<td><p>N</p></td>
</tr>
<tr>
<td><p>Larsen and Heiselberg (2008)</p></td>
<td><p><span style=\"color: #ee2e2f;\">Y</span></p></td>
<td><p><span style=\"color: #1c6cc8;\">?</span></p></td>
<td><p><span style=\"color: #1c6cc8;\">?</span></p></td>
<td><p><span style=\"color: #1c6cc8;\">?</span></p></td>
<td><p><span style=\"color: #1c6cc8;\">?</span></p></td>
</tr>
<tr>
<td><p>ASHRAE (2009)</p></td>
<td><p><span style=\"color: #ee2e2f;\">Y</span></p></td>
<td><p><span style=\"color: #1c6cc8;\">?</span></p></td>
<td><p><span style=\"color: #1c6cc8;\">?</span></p></td>
<td><p><span style=\"color: #1c6cc8;\">?</span></p></td>
<td><p><span style=\"color: #1c6cc8;\">?</span></p></td>
</tr>
<tr>
<td><p>Caciolo et al. (2013)</p></td>
<td><p><span style=\"color: #ee2e2f;\">Y</span></p></td>
<td><p><span style=\"color: #1c6cc8;\">?</span></p></td>
<td><p><span style=\"color: #1c6cc8;\">?</span></p></td>
<td><p><span style=\"color: #1c6cc8;\">?</span></p></td>
<td><p><span style=\"color: #1c6cc8;\">?</span></p></td>
</tr>
<tr>
<td><p>VDI 2078 (2015)</p></td>
<td><p><span style=\"color: #ee2e2f;\">Y</span></p></td>
<td><p>N</p></td>
<td><p>Only bottom-hung, inward</p></td>
<td><p>N</p></td>
<td><p>N</p></td>
</tr>
<tr>
<td><p>Tang et al. (2016)</p></td>
<td><p><span style=\"color: #ee2e2f;\">Y</span></p></td>
<td><p><span style=\"color: #1c6cc8;\">?</span></p></td>
<td><p><span style=\"color: #1c6cc8;\">?</span></p></td>
<td><p><span style=\"color: #1c6cc8;\">?</span></p></td>
<td><p><span style=\"color: #1c6cc8;\">?</span></p></td>
</tr>
<tr>
<td><p>DIN EN 16798-7 (2017)</p></td>
<td><p><span style=\"color: #ee2e2f;\">Y</span></p></td>
<td><p>N</p></td>
<td><p><span style=\"color: #ee2e2f;\">Y</span></p></td>
<td><p>N</p></td>
<td><p><span style=\"color: #ee2e2f;\">Y</span></p></td>
</tr>
<tr>
<td><p>Jiang et al. (2022)</p></td>
<td><p>N</p></td>
<td><p>N</p></td>
<td><p>Only bottom-hung, inward</p></td>
<td><p>N</p></td>
<td><p>N</p></td>
</tr>
<tr>
<td><p>DIN/TS 4108-8 (2022)</p></td>
<td><p><span style=\"color: #ee2e2f;\">Y</span></p></td>
<td><p><span style=\"color: #ee2e2f;\">Y</span></p></td>
<td><p><span style=\"color: #ee2e2f;\">Y</span></p></td>
<td><p><span style=\"color: #ee2e2f;\">Y</span></p></td>
<td><p><span style=\"color: #ee2e2f;\">Y</span></p></td>
</tr>
</table>
<ul>
<li><span style=\"color: #ee2e2f;\">Y</span> = Applicable</li>
<li><span style=\"color: #1c6cc8;\">?</span> = Applicable without validation</li>
<li>N = Not applicable</li>
</ul>
</html>"));
end EmpiricalExpressions;
