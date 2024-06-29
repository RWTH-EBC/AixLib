within AixLib.Airflow;
package WindowVentilation "Package of different window ventilation models"

annotation (Documentation(info="<html>
<h4>Overview </h4>
<p>This package contains models of window ventilation with various types of sash openings from literature. </p>
<p>Currently, the models are only applicable for single-sided ventilation. </p>
<h4>Window opening types </h4>
<p>This package considers the following types of window openings: </p>
<ul>
<li>Simple opening, without window sash </li>
<li>Side-hung opening, in- or outward, for casement window </li>
<li>Top-hung opening, outward, for awning window </li>
<li>Bottom-hung opening, inward, for hopper window, tilt window </li>
<li>Pivot opening, vertical or horizontal, for center hinge window </li>
<li>Sliding opening, vertical, for single-hung or double-hung window </li>
<li>Sliding opening, horizontal, for slider window </li>
</ul>
<p>These opening types are included in <a href=\"modelica://AixLib/Airflow/WindowVentilation/BaseClasses/Types/WindowOpeningTypes.mo\">WindowOpeningTypes</a>. </p>
<p><img src=\"modelica://AixLib/Resources/Images/Airflow/WindowVentilation/WindowOpeningTypes.png\"/> </p>
<h4>Opening area types </h4>
<p>For hinged and pivot openings, there are five different types to define the opening area: </p>
<ul>
<li>Clear opening area, as shown in the figure on the left </li>
<li>Geometric opening area, as shown in the figure in the middle, see function <a href=\"modelica://AixLib/Airflow/WindowVentilation/BaseClasses/Functions/OpeningAreaHinged/geometricOpeningArea.mo\">geometricOpeningArea</a> </li>
<li>Projective opening area, as shown in the figure on the right, see function <a href=\"modelica://AixLib/Airflow/WindowVentilation/BaseClasses/Functions/OpeningAreaHinged/projectiveOpeningArea.mo\">projectiveOpeningArea</a> </li>
<li>Equivalent opening area, derived from clear opening area and geometric opening area, see function <a href=\"modelica://AixLib/Airflow/WindowVentilation/BaseClasses/Functions/OpeningAreaHinged/equivalentOpeningArea.mo\">equivalentOpeningArea</a> </li>
<li>Effective opening area, derived from clear opening area and equivalent opening area, see function <a href=\"modelica://AixLib/Airflow/WindowVentilation/BaseClasses/Functions/OpeningAreaHinged/effectiveOpeningArea.mo\">effectiveOpeningArea</a> </li>
</ul>
<p><br><br><img src=\"modelica://AixLib/Resources/Images/Airflow/WindowVentilation/WindowOpeningAreaQu.png\"/><img src=\"modelica://AixLib/Resources/Images/Airflow/WindowVentilation/WindowOpeningAreaGeo.png\"/><img src=\"modelica://AixLib/Resources/Images/Airflow/WindowVentilation/WindowOpeningAreaProj.png\"/> </p>
<h4>Nomenclature</h4>
<p>Abv: Above</p>
<p>Amb: Ambient</p>
<p>Ang: Angle</p>
<p>ASL: Above see level</p>
<p>Avg: Average</p>
<p>Axs: Axis</p>
<p>Clr: Clear</p>
<p>Cof: Coefficient</p>
<p>Cor: Correlation; Correction</p>
<p>Dcg: Discharge</p>
<p>Dif: Difference</p>
<p>Eff: Effective</p>
<p>Eqv: Equivalent</p>
<p>Ext: External</p>
<p>Frm: Frame</p>
<p>Geo: Geometric</p>
<p>Inc: Incidence</p>
<p>Int: Interim; Internal</p>
<p>Lim: Limit</p>
<p>Loc: Local</p>
<p>NPL: Neutral pressure level</p>
<p>Opn: Open; Opening</p>
<p>Ovl: Overlap</p>
<p>Prj: Projective</p>
<p>Ref: Reference</p>
<p>Rev: Reveal</p>
<p>Ruf: Rough; Roughness</p>
<p>Sas: Sash</p>
</html>"));
end WindowVentilation;
