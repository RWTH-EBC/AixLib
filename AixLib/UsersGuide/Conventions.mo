within AixLib.UsersGuide;

class Conventions "Conventions"
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

  model RecordTemplateDocumentation "Template documentation for EBC's DataBase records"
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
  annotation(Documentation(info = "<html>
 <p>This library follows the conventions of the <a href=\"modelica://Modelica.UsersGuide.Conventions\">Modelica Standard Library</a>, which are as follows: </p>
 <p>Note, in the html documentation of any Modelica library, the headings &QUOT;h1, h2, h3&QUOT; should not be used, because they are utilized from the automatically generated documentation/headings. Additional headings in the html documentation should start with &QUOT;h4&QUOT;. </p>
 <p>In the Modelica package the following conventions are used: </p>
 <ol>
 <li><b>Class and instance names</b> are written in upper and lower case letters, e.g., &QUOT;PipeStraight&QUOT;. An underscore is only used at the end of a name to characterize a lower or upper index, e.g., &QUOT;port_1&QUOT;.<br>&nbsp; </li>
 <li><b>Class names</b> start always with an upper case letter.<br>&nbsp; </li>
 <li><b>Instance names</b>, i.e., names of component instances and of variables (with the exception of constants), start usually with a lower case letter with only a few exceptions if this is common sense (such as &QUOT;T&QUOT; for a temperature variable).<br>&nbsp; </li>
 <li><b>Constant names</b>, i.e., names of variables declared with the &QUOT;constant&QUOT; prefix, follow the usual naming conventions (= upper and lower case letters) and start usually with an upper case letter, e.g. UniformGravity, SteadyState.<br>&nbsp;</li>
 <li>The <b>instance name</b> of a component is always displayed in its icon (= text string &QUOT;&percnt;name&QUOT;) in <b>blue color</b>. A connector class has the instance name definition in the diagram layer and not in the icon layer. <b>Parameter</b> values, e.g., resistance, mass, gear ratio, are displayed in the icon in <b>black color</b> in a smaller font size as the instance name. <br>&nbsp;</li>
 <li>A main package has usually the following subpackages: </li>
 <li><ul>
 <li><b>UsersGuide</b> containing an overall description of the library and how to use it. </li>
 <li><b>Examples</b> containing models demonstrating the usage of the library. </li>
 <li><b>Interfaces</b> containing connectors and partial models. </li>
 <li><b>Types</b> containing type, enumeration and choice definitions. </li>
 </ul></li>
 </ul>
 </ol>
 <p>The <code>AixLib</code> library uses the following conventions in addition to the ones of the Modelica Standard Library: </p>
 <ol>
 <li>
 <li>Names of models, blocks and packages should start with an upper-case letter and be a noun or a noun with a combination of adjectives and nouns. Use camel-case notation to combine multiple words, such as <code>HeatTransfer</code> </li>
 <li>Comments should be added to each class (package, model, function etc.). The first character should be upper case. For one-line comments of parameters, variables and classes, no period should be used at the end of the comment. </li>
 <li>Where applicable, all variable must have units, also if the variable is protected. </li>
 <li>To indicate that a class (i.e., a package, model, block etc.) has not been extensively tested or validated, its class name ends with the string <code>_UC</code>. </li>
 <li>Please use the following check list each time you make a <b>new</b> model.</li>
 <p><ol type=\"a\">
 <li>Name the model according to the naming conventions</li>
 <li>Comment the code</li>
 <li>Build an example for testing the model</li>
 <li>Are the results from the test plausible</li>
 <li>Write a complete documentation</li>
 <li><ul>
 <li>Concept</li>
 <li>Detailed description </li>
 <li>Limitations</li>
 <li>References (!) </li>
 <li><ul>
 <li>for equations </li>
 <li>records only with catalogue data</li>
 <li>Add catalogue data in your literature databank (e.g.JabRef) unsing the Keyword: ModelicaDataBase </li>
 </ul></li>
 <li>Links and cross references</li>
 <li>Revisions &ndash; date, name and what was changed </li>
 <li>Stars</li>
 </ul></li>
 <li>Expand the test script with the new example (if used) </li>
 </ol></li>
 </ol type=\"a\"></p>
 </ol>
 </html>"));
end Conventions;