within AixLib.UsersGuide;
package Conventions "Conventions"
  extends Modelica.Icons.Information;
  model ModelTemplateDocumentation "Template documentation for EBC's models"
    annotation(Documentation(info = "<html>
  <h4><span style=\"color:#008000\">Overview</span></h4>
  <ul>
  <li>What is it for?</li>
  <li>What is it based on?</li>
  <li>How is it used normally? </li>
  </ul>
  <h4><span style=\"color:#008000\">Level of Development</span></h4>
  <p><img src=\"modelica://AixLib/Images/stars0.png\"/></p>
  <p><br>Reward yourself for your modeling efforts by adjusting the star rating of your model to its actual level of development. This helps others to get an idea of how far the model is developed at a quick glimpse. </p>
  <p>During model design, the rating is 0 stars. </p>
  <ul>
  <li>1 star: the model is running stable, it is complete and well-structured</li>
  <li>2 stars: the model is well documented</li>
  <li>3 stars: the model comes with examples for verification, showing its correct functioning. Implementation of models from literature receive a maximum of 3 stars as long as no validation of the specific model (EBC) was done.</li>
  <li>4 stars: the model comes with examples for validation for this specific model (EBC); a comparison with measurement data includes an error analysis</li>
  <li>5 stars: the model documentation includes a link to publications which show model validation for this specific model(EBC) and can be cited by others</li>
  </ul>
  <p><br>The folder HVAC.images contains images star0.png - star5.png. Replace the image above as appropriate.</p>
  <h4><span style=\"color:#008000\">Assumptions</span></h4>
  <p>Note assumptions such as a specific definition ranges for the model, possible medium models, allowed combinations with other models etc.</p>
  <h4><span style=\"color:#008000\">Known Limitations</span></h4>
  <p>There might be limitations of the model such as reduced accuracy under specific circumstances. Please note all those limitations you know of so a potential user won&apos;t make too serious mistakes.</p>
  <h4><span style=\"color:#008000\">Concept</span></h4>
  <p>How does it work? Give some details about the formulation of the code and the idea behind it.</p>
  <p><br><b><font style=\"color: #008000; \">References</font></b></p>
  <ul>
  <li>Give the references that were used to develop the model. Theoretical (papers, etc.)</li>
  <li>Point the user to potential manufacturer data that can be used to configure a model, links on the web etc.</li>
  <li>Which examples have been provided?</li>
  <li>Which scripts can be used to work with the model?</li>
  </ul>
  <h4><span style=\"color:#008000\">Example Results</span></h4>
  <p>Present some expected results this model should show under given conditions. This way it will be easier to check the validity model. Also use and refer to the Examples section where according simulations can be stored.</p>
  </html>"));
  end ModelTemplateDocumentation;

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
end Conventions;

