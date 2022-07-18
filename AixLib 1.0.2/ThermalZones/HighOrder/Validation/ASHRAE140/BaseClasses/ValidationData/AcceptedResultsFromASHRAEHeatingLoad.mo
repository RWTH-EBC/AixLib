within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.BaseClasses.ValidationData;
record AcceptedResultsFromASHRAEHeatingLoad
  extends AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.BaseClasses.ValidationData.ValidationDataASHRAEBaseDataDefinition(
      Results=[600,4296,5709; 620,4613,5944; 640,2751,3803; 650,0,0; 900,1170,
        2041; 920,3313,4300; 940,793,1411; 950,0,0; 210,6456,6967; 220,6944,
        8787; 230,10376,12243; 240,5649,7448; 250,4751,7024; 270,4510,5920; 280,
        4675,6148; 300,4761,5964; 320,3859,5141; 395,4799,5835; 400,6900,8770;
        410,8596,10506; 420,7298,9151; 430,5429,7827; 440,4449,5811; 800,4868,
        7228; 810,1839,3004]);

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
  AnnualHeatingLoads for all implemented Cases as described in ASHRAE
  Standard 140.
</p>[CaseNumber,minAnnualHeatingLoad,maxAnnualHeatingLoad]
<p>
  <b><span style=\"color: #008000;\">References</span></b>
</p>
<ul>
  <li>ASHRAE140-2017 AccompanyingFiles\\Sec5-2AFiles\\Informative
  Materials\\RESULTS5-2A
  </li>
</ul>
</html>"));
end AcceptedResultsFromASHRAEHeatingLoad;
