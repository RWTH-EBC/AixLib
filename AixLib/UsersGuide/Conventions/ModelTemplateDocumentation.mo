within AixLib.UsersGuide.Conventions;


model ModelTemplateDocumentation "Template documentation for EBC's models"
  annotation(Documentation(info = "<html>
  <h4><span style=\"color:#008000\">Overview</span></h4>
  <ul>
  <li>What is it for?</li>
  <li>What is it based on?</li>
  <li>How is it used normally? </li>
  </ul>
  <h4><span style=\"color:#008000\">Level of Development</span></h4>
  <p><img src=\"modelica://AixLib/Resources/Images/Stars/stars0.png\" alt=\"stars: 0 out of 5\"/></p>
  <p><br/>Reward yourself for your modeling efforts by adjusting the star rating of your model to its actual level of development. This helps others to get an idea of how far the model is developed at a quick glimpse. </p>
  <p>During model design, the rating is 0 stars. </p>
  <ul>
  <li>1 star: the model is running stable, it is complete and well-structured</li>
  <li>2 stars: the model is well documented</li>
  <li>3 stars: the model comes with examples for verification, showing its correct functioning. Implementation of models from literature receive a maximum of 3 stars as long as no validation of the specific model (EBC) was done.</li>
  <li>4 stars: the model comes with examples for validation for this specific model (EBC); a comparison with measurement data includes an error analysis</li>
  <li>5 stars: the model documentation includes a link to publications which show model validation for this specific model(EBC) and can be cited by others</li>
  </ul>
  <p><br/>The folder AixLib.HVAC.Resources/Images contains Resources/Images star0.png - star5.png. Replace the image above as appropriate.</p>
  <h4><span style=\"color:#008000\">Assumptions</span></h4>
  <p>Note assumptions such as a specific definition ranges for the model, possible medium models, allowed combinations with other models etc.</p>
  <h4><span style=\"color:#008000\">Known Limitations</span></h4>
  <p>There might be limitations of the model such as reduced accuracy under specific circumstances. Please note all those limitations you know of so a potential user won&apos;t make too serious mistakes.</p>
  <h4><span style=\"color:#008000\">Concept</span></h4>
  <p>How does it work? Give some details about the formulation of the code and the idea behind it.</p>
  <p><br/><b><font style=\"color: #008000; \">References</font></b></p>
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
