within AixLib.DataBase.WindowsDoors.Simple;
record WindowSimple_TwinHouses2 "Window according to Twin Houses 2"

extends AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple(
    Uw=1.2,
    g=0.62,
    Emissivity=0.837,
    frameFraction=0.25);
  annotation (Documentation(revisions="<html>
<ul>
<li><i>August 4, 2020</i> by Konstantina Xanthopoulou:<br/>implemented</li>
</ul>
</html>",
        info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Window definition according to TwinHouses for a simple window. </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Source:</p>
<ul>
<li>Empirical Whole Model Validation
Modelling Specification (Test Case Twin_House_1)</li>
</ul>
</html>"));
end WindowSimple_TwinHouses2;
