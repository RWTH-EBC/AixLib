within AixLib.UsersGuide.Conventions;


model RecordTemplateDocumentation
  "Template documentation for EBC's DataBase records"
  annotation(Documentation(info = "<html>
  <p><h4><font color=\"#008000\">Overview</font></h4></p>
  <p><ul>
  <li>Name of product</li>
  <li>What does it describe?</li>
  </ul></p>
  <p><h4><font color=\"#008000\">Level of Development</font></h4></p>
  <p><img src=\"modelica://AixLib/Images/stars0.png\"/></p>
  <p><br/>Reward yourself for your data inputing efforts by adjusting the star rating of your record to its actual level of development. This helps others to get an idea of how complete the record is. </p>
  <p>If no description or reference is available, the rating is 0 stars. </p>
  <p><ul>
  <li>3 stars: a description of the record is available and the documentation is correctly formated</li>
  <li>4 stars: references exist for certain parameters in the record, but not all of them</li>
  <li>5 stars: references exist for all parameters in the record</li>
  </ul></p>
  <p><br/>The folder HVAC.images contains images star0.png - star5.png. Replace the image above as appropriate.</p>
  <p><h4><font color=\"#008000\">Assumptions</font></h4></p>
  <p>Note assumptions for certain parameter values (3 or 4 stars).</p>
  <p><h4><font color=\"#008000\">Concept</font></h4></p>
  <p>How were certain parameter values / tables calculated, e.g. extrapolation for power values for heat pumps.</p>
  <p><br/><b><font style=\"color: #008000; \">References</font></b></p>
  <p>Record is used in model ....</p>
  <p>Source:</p>
  <p><ul>
  <li>Manufacturer:</li>
  <li>Booklet:</li>
  <li>Bibtexkey:</li>
  <li>URL (accessed XX.XX.XXX):</li>
  </ul></p>
  </html>"));
end RecordTemplateDocumentation;
