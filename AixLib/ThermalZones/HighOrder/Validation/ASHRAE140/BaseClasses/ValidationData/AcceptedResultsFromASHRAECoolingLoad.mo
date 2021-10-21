within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.BaseClasses.ValidationData;
record AcceptedResultsFromASHRAECoolingLoad
  extends AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.BaseClasses.ValidationData.ValidationDataASHRAEBaseDataDefinition(
      Results=[600,6137,7964; 620,3417,5004; 640,5952,7811; 650,0,0; 900,2132,
        3415; 920,1840,3092; 940,2079,3241; 950,0,0; 210,162,667.9; 220,186,835;
        230,454,1139; 240,415,1246; 250,2177,3380; 270,7528,10350; 280,4873,
        7114; 300,4302,7100; 320,5061,7304; 395,0,16; 400,0,61; 410,0,84; 420,
        11,189; 430,422,875; 440,3967,5204; 800,55,325; 810,1052,1711]);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html><ul>
  <li>
    <i>July 1, 2020</i> by Konstantina Xanthopoulou:<br/>
    Implemented
  </li>
</ul>
</html>", info="<html>
<p>
  AnnualCoolingLoads for all implemented Cases as described in ASHRAE
  Standard 140.
</p>[CaseNumber,minAnnualCoolingLoad,maxAnnualCoolingLoad]
<p>
  <b><span style=\"color: #008000;\">References</span></b>
</p>
<ul>
  <li>ASHRAE140-2017 AccompanyingFiles\\Sec5-2AFiles\\Informative
  Materials\\RESULTS5-2A
  </li>
</ul>
</html>"));
end AcceptedResultsFromASHRAECoolingLoad;
