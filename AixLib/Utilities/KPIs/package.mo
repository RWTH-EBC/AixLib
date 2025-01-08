within AixLib.Utilities;
package KPIs "Key Performance Indicators (KPIs) for control system"
  extends Modelica.Icons.Package;

annotation (Documentation(info="<html>
<p>This package contains models to calculate several fundamental KPIs (Key-Performance-Indicators) essential for assessing control performance in various systems. This evaluation typically involves comparing specific system values against single or dual reference boundaries.</p>
<p>Within this package, two primary sub-packages are included:</p>
<ul>
<li>The package <a href=\"modelica://AixLib/Utilities/KPIs/IntegralErrorSingleReference/package.mo\">IntegralErrorSingleReference</a> features integrators specifically designed to calculate errors associated with a single reference point. By integrating these errors over time, users can gain insights into how well the system adheres to its desired performance target.</li>
<li>The package <a href=\"modelica://AixLib/Utilities/KPIs/IntegralErrorDualReference/package.mo\">IntegralErrorDualReference</a> provides integrators for scenarios involving dual boundaries&mdash;both upper and lower limits. These integrators are particularly useful when evaluating system performance in relation to predefined thresholds, allowing users to assess how often and by how much values exceed these boundaries.</li>
</ul>
<p>Building upon these primary sub-packages, additional specialized sub-packages have been developed to address specific aspects of control performance:</p>
<ul>
<li>The package <a href=\"modelica://AixLib/Utilities/KPIs/Energy/package.mo\">Energy</a> focuses on evaluating both electrical and thermal energy metrics.</li>
<li>The package <a href=\"modelica://AixLib/Utilities/KPIs/Temperature/package.mo\">Temperature</a> aims at assessing thermal comfort based on room temperature.</li>
</ul>
</html>"));
end KPIs;
