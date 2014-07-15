within AixLib;
package UsersGuide "User's Guide"
 extends Modelica.Icons.Information;
 class Conventions "Conventions"
   extends Modelica.Icons.Information;
     model ModelTemplateDocumentation "Template documentation for EBC's models"

     annotation (Documentation(info="<html>
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

     annotation (Documentation(info="<html>
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
   annotation (Documentation(info="<html>
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

 package ReleaseNotes "Release notes"
   extends Modelica.Icons.ReleaseNotes;
 end ReleaseNotes;

 class Contact "Contact"
   extends Modelica.Icons.Contact;
   annotation (Documentation(info="<html>
      <h4><font color=\"#008000\" size=5>Contact</font></h4>
      <p>
      The development of the AixLib library is organized by<br>
          Modelica Group<br>
          RWTH Aachen University<br>
          E.ON Energy Research Center<br>
          Institute for Energy Efficient Buildings and Indoor Climate<br>
          Mathieustraße 10<br> 
          D-52074 Aachen<br>
          Germany<br>
          email: <A HREF=\"mailto:aixlib@eonerc.rwth-aachen.de\">aixlib@eonerc.rwth-aachen.de</A><br>
      </p>
      </html>
      "));
 end Contact;

 class Acknowledgements "Acknowledgements"
   extends Modelica.Icons.Information;
   annotation (Documentation(info="<html>
      <h4><font color=\"#008000\" size=5>Acknowledgements</font></h4>
      <p>
      The following people from RWTH Aachen University, E.ON Energy Research Center, Institute for Energy Efficient Buildings and Indoor Climate have directly contributed to the implementation of the AixLib library
      <ul>
      <li>Ana Constantin
      </li>
      <li>Björn Flieger
      </li>
      <li>Marcus Fuchs
      </li>
      <li>Kristian Huchtemann
      </li>
      <li>Pooyan Jahangiri
      </li>
      <li>Amir Javadi
      </li>
      <li>Moritz Lauster
      </li>
      <li>Peter Matthes
      </li>
      <li>Ole Odendahl
      </li>
      <li>Markus Schumacher
      </li>
      <li>Sebastian Stinner
      </li>
      <li>Mark Wesseling
      </li>
      </ul>
      </p>
      </html>
      "));
 end Acknowledgements;

 class License "Modelica License 2"
   extends Modelica.Icons.Information;
   annotation (Documentation(info="<html>
<h4><font color=\"#008000\" size=5>The Modelica License 2</font></h4>
<p>
<strong>Preamble.</strong> The goal of this license is that Modelica related model libraries, software, images, documents, data files etc. can be used freely in the original or a modified form, in open source and in commercial environments (as long as the license conditions below are fulfilled, in particular sections 2c) and 2d). The Original Work is provided free of charge and the use is completely at your own risk. Developers of free Modelica packages are encouraged to utilize this license for their work.
</p>
<p>
The Modelica License applies to any original work that contains the following licensing notice adjacent to the copyright notice(s) for this Original Work: 
</p>
<p>
This version of the license including exceptions has been inspired by the license of Buildings library published by The Regents of the University of California, through Lawrence Berkeley National Laboratory.
</p>
<p>
<strong>Note.</strong> This is the standard Modelica License 2, except for the following changes: the parenthetical in paragraph 7., paragraph 5., and the addition of paragraph 15.d). 
</p>
<p>
<strong>Licensed by RWTH Aachen University, E.ON Energy Research Center, Institute for Energy Efficient Buildings and Indoor Climate under the Modelica License 2 </strong> 
</p>

<h4>1. Definitions</h4>
<ol type=\"a\"><li>
\"License\" is this Modelica License.
</li><li>
\"Original Work\" is any work of authorship, including software, images, documents, data files, that contains the above licensing notice or that is packed together with a licensing notice referencing it. 
</li><li>
\"Licensor\" is the provider of the Original Work who has placed this licensing notice adjacent to the copyright notice(s) for the Original Work. The Original Work is either directly provided by the owner of the Original Work, or by a licensee of the owner. 
</li><li>
\"Derivative Work\" is any modification of the Original Work which represents, as a whole, an original work of authorship. For the matter of clarity and as examples:
<ol type=\"A\">
<li>
Derivative Work shall not include work that remains separable from the Original Work, as well as merely extracting a part of the Original Work without modifying it. 
</li><li>
Derivative Work shall not include (a) fixing of errors and/or (b) adding vendor specific Modelica annotations and/or (c) using a subset of the classes of a Modelica package, and/or (d) using a different representation, e.g., a binary representation. 
</li><li>
Derivative Work shall include classes that are copied from the Original Work where declarations, equations or the documentation are modified. 
</li><li>
Derivative Work shall include executables to simulate the models that are generated by a Modelica translator based on the Original Work (of a Modelica package). </li>
</ol>
</li>
<li>
\"Modified Work\" is any modification of the Original Work with the following exceptions: (a) fixing of errors and/or (b) adding vendor specific Modelica annotations and/or (c) using a subset of the classes of a Modelica package, and/or (d) using a different representation, e.g., a binary representation. 
</li><li>
\"Source Code\" means the preferred form of the Original Work for making modifications to it and all available documentation describing how to modify the Original Work. 
</li><li>
\"You\" means an individual or a legal entity exercising rights under, and complying with all of the terms of, this License. 
</li><li>
\"Modelica package\" means any Modelica library that is defined with the
 <b>package</b> &lt;Name&gt; ... <b>end</b> &lt;Name&gt;<b>;</b> Modelica language element.
</li>
</ol>
 
<h4>2. Grant of Copyright License</h4>
<p>
Licensor grants You a worldwide, royalty-free, non-exclusive, sublicensable license, for the duration of the copyright, to do the following:
</p>
<ol type=\"a\">
<li>
To reproduce the Original Work in copies, either alone or as part of a collection. 
</li><li>
To create Derivative Works according to Section 1d) of this License. 
</li><li>
To distribute or communicate to the public copies of the <u>Original Work</u> or a <u>Derivative Work</u> under <u>this License</u>. No fee, neither as a copyright-license fee, nor as a selling fee for the copy as such may be charged under this License. Furthermore, a verbatim copy of this License must be included in any copy of the Original Work or a Derivative Work under this License. 
<br/>
For the matter of clarity, it is permitted A) to distribute or communicate such copies as part of a (possible commercial) collection where other parts are provided under different licenses and a license fee is charged for the other parts only and B) to charge for mere printing and shipping costs. 
</li><li>
To distribute or communicate to the public copies of a <u>Derivative Work</u>, alternatively to Section 2c), under <u>any other license</u> of your choice, especially also under a license for commercial/proprietary software, as long as You comply with Sections 3, 4 and 8 below. 
<br/>
For the matter of clarity, no restrictions regarding fees, either as to a copyright-license fee or as to a selling fee for the copy as such apply. 
</li><li>
To perform the Original Work publicly. 
</li><li>
To display the Original Work publicly. 
</li></ol>

<h4>3. Acceptance</h4>
<p>
Any use of the Original Work or a Derivative Work, or any action according to either Section 2a) to 2f) above constitutes Your acceptance of this License.
</p>

<h4>4. Designation of Derivative Works and of Modified Works</h4>
<p>
The identifying designation of Derivative Work and of Modified Work must be different to the corresponding identifying designation of the Original Work. This means especially that the (root-level) name of a Modelica package under this license must be changed if the package is modified (besides fixing of errors, adding vendor specific Modelica annotations, using a subset of the classes of a Modelica package, or using another representation, e.g. a binary representation). 
</p>

<h4>5. [reserved]</h4>
<h4>6. Provision of Source Code</h4>
<p>
Licensor agrees to provide You with a copy of the Source Code of the Original Work but reserves the right to decide freely on the manner of how the Original Work is provided. For the matter of clarity, Licensor might provide only a binary representation of the Original Work. In that case, You may (a) either reproduce the Source Code from the binary representation if this is possible (e.g., by performing a copy of an encrypted Modelica package, if encryption allows the copy operation) or (b) request the Source Code from the Licensor who will provide it to You.
</p>

<h4>7. Exclusions from License Grant</h4>
<p>
Neither the names of Licensor (including, but not limited to, RWTH Aachen University, E.ON Energy Research Center, Institute for Energy Efficient Buildings and Indoor Climate), nor the names of any contributors to the Original Work, nor any of their trademarks or service marks, may be used to endorse or promote products derived from this Original Work without express prior permission of the Licensor. Except as otherwise expressly stated in this License and in particular in Sections 2 and 5, nothing in this License grants any license to Licensor's trademarks, copyrights, patents, trade secrets or any other intellectual property, and no patent license is granted to make, use, sell, offer for sale, have made, or import embodiments of any patent claims. 
No license is granted to the trademarks of Licensor even if such trademarks are included in the Original Work, except as expressly stated in this License. Nothing in this License shall be interpreted to prohibit Licensor from licensing under terms different from this License any Original Work that Licensor otherwise would have a right to license.
</p>

<h4>8. Attribution Rights</h4>
<p>
You must retain in the Source Code of the Original Work and of any Derivative Works that You create, all author, copyright, patent, or trademark notices, as well as any descriptive text identified therein as an \"Attribution Notice\". The same applies to the licensing notice of this License in the Original Work. For the matter of clarity, \"author notice\" means the notice that identifies the original author(s).
</p>
<p>
You must cause the Source Code for any Derivative Works that You create to carry a prominent Attribution Notice reasonably calculated to inform recipients that You have modified the Original Work. 
</p>
<p>
In case the Original Work or Derivative Work is not provided in Source Code, the Attribution Notices shall be appropriately displayed, e.g., in the documentation of the Derivative Work.
</p>

<h4>9. Disclaimer of Warranty</h4>
<p>
<u><strong>The Original Work is provided under this License on an \"as is\" basis and without warranty, either express or implied, including, without limitation, the warranties of non-infringement, merchantability or fitness for a particular purpose. The entire risk as to the quality of the Original Work is with You.</strong></u> This disclaimer of warranty constitutes an essential part of this License. No license to the Original Work is granted by this License except under this disclaimer.
</p>

<h4>10. Limitation of Liability</h4>
<p>
Under no circumstances and under no legal theory, whether in tort (including negligence), contract, or otherwise, shall the Licensor, the owner or a licensee of the Original Work be liable to anyone for any direct, indirect, general, special, incidental, or consequential damages of any character arising as a result of this License or the use of the Original Work including, without limitation, damages for loss of goodwill, work stoppage, computer failure or malfunction, or any and all other commercial damages or losses. This limitation of liability shall not apply to the extent applicable law prohibits such limitation. 
</p>

<h4>11. Termination</h4>
<p>
This License conditions your rights to undertake the activities listed in Section 2 and 5, including your right to create Derivative Works based upon the Original Work, and doing so without observing these terms and conditions is prohibited by copyright law and international treaty. Nothing in this License is intended to affect copyright exceptions and limitations. This License shall terminate immediately and You may no longer exercise any of the rights granted to You by this License upon your failure to observe the conditions of this license. 
</p>

<h4>12. Termination for Patent Action</h4>
<p>
This License shall terminate automatically and You may no longer exercise any of the rights granted to You by this License as of the date You commence an action, including a cross-claim or counterclaim, against Licensor, any owners of the Original Work or any licensee alleging that the Original Work infringes a patent. This termination provision shall not apply for an action alleging patent infringement through combinations of the Original Work under combination with other software or hardware.
</p>

<h4>13. Jurisdiction</h4>
<p>
Any action or suit relating to this License may be brought only in the courts of a jurisdiction wherein the Licensor resides and under the laws of that jurisdiction excluding its conflict-of-law provisions. The application of the United Nations Convention on Contracts for the International Sale of Goods is expressly excluded. Any use of the Original Work outside the scope of this License or after its termination shall be subject to the requirements and penalties of copyright or patent law in the appropriate jurisdiction. This section shall survive the termination of this License. 
</p>

<h4>14. Attorneys' Fees</h4>
<p>
In any action to enforce the terms of this License or seeking damages relating thereto, the prevailing party shall be entitled to recover its costs and expenses, including, without limitation, reasonable attorneys' fees and costs incurred in connection with such action, including any appeal of such action. This section shall survive the termination of this License. 
</p>

<h4>15. Miscellaneous</h4>
<ol type=\"a\">
<li>If any provision of this License is held to be unenforceable, such provision shall be reformed only to the extent necessary to make it enforceable. 
</li><li>
No verbal ancillary agreements have been made. Changes and additions to this License must appear in writing to be valid. This also applies to changing the clause pertaining to written form. 
</li><li>
You may use the Original Work in all ways not otherwise restricted or conditioned by this License or by law, and Licensor promises not to interfere with or be responsible for such uses by You. 
</li><li>
You are under no obligation whatsoever to provide any bug fixes, patches, or upgrades to the features, functionality or performance of the source code (\"Enhancements\") to anyone; however, if you choose to make your Enhancements available either publicly, or directly to RWTH Aachen University, E.ON Energy Research Center, Institute for Energy Efficient Buildings and Indoor Climate, without imposing a separate written license agreement for such Enhancements, then you hereby grant the following license: a non-exclusive, royalty-free perpetual license to install, use, modify, prepare derivative works, incorporate into other computer software, distribute, and sublicense such enhancements or derivative works thereof, in binary and source code form. 
</li></ol>

<h4>How to Apply the Modelica License 2</h4>
<p>
At the top level of your Modelica package and at every important subpackage, add the following notices in the info layer of the package:
</p>
<ul><li style=\"list-style-type:none\">
Licensed by RWTH Aachen University, E.ON Energy Research Center, Institute for Energy Efficient Buildings and Indoor Climate under the Modelica License 2 Copyright (c) 2009-2013, RWTH Aachen University, E.ON Energy Research Center, Institute for Energy Efficient Buildings and Indoor Climate. 
</li>
<li style=\"list-style-type:none\"><i>
This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica license 2, see the license conditions (including the disclaimer of warranty) here or at <a href=\"http://www.modelica.org/modelica-legal-documents/ModelicaLicense2.html\">http://www.modelica.org/modelica-legal-documents/ModelicaLicense2.html</a>. 
</i></li></ul>

<p>
Include a copy of the Modelica License 2 under <strong>&lt;library&gt;.UsersGuide.ModelicaLicense2</strong> 
(use <a href=\"http://www.modelica.org/modelica-legal-documents/ModelicaLicense2.mo\">
http://www.modelica.org/modelica-legal-documents/ModelicaLicense2.mo</a>) 
Furthermore, add the list of authors and contributors under 
<strong>&lt;library&gt;.UsersGuide.Contributors</strong> or <strong>&lt;library&gt;.UsersGuide.Contact</strong> 
</p>
<p>
For example, sublibrary Modelica.Blocks of the Modelica Standard Library may have the following notices:</p>
<ul><li style=\"list-style-type:none\">
Licensed by Modelica Association under the Modelica License 2 Copyright (c) 1998-2008, Modelica Association. 
<li style=\"list-style-type:none\"><i>
This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica license 2, see the license conditions (including the disclaimer of warranty) here or at 
<a href=\"http://www.modelica.org/modelica-legal-documents/ModelicaLicense2.html\">http://www.modelica.org/modelica-legal-documents/ModelicaLicense2.html</a>. 
</i>
</li></ul>

<p>For C-source code and documents, add similar notices in the corresponding file.</p>
<p>
For images, add a \"readme.txt\" file to the directories where the images are stored and include a similar notice in this file. 
</p>

<p>
In these cases, save a copy of the Modelica License 2 in one directory of the distribution, e.g., 
<a href=\"http://www.modelica.org/modelica-legal-documents/ModelicaLicense2-standalone.html\">http://www.modelica.org/modelica-legal-documents/ModelicaLicense2-standalone.html</a> in directory <strong>&lt;library&gt;/help/documentation/ModelicaLicense2.html</strong>.
</p>

</html>
"));
 end License;

 class Copyright "Copyright"
   extends Modelica.Icons.Information;
   annotation (Documentation(info="<html>
        <h4><font color=\"#008000\" size=5>Copyright</font></h4>
        <p>
        Copyright (c) 2010-2014, RWTH Aachen University, E.ON Energy Research Center, Institute for Energy Efficient Buildings and Indoor Climate. All rights reserved.
        </p><p>
        </html>
        "));
 end Copyright;
 annotation (DocumentationClass=true, Documentation(info="<html>
<p>The free open-source <code>AixLib</code> library is being developed for research and teaching purposes. It aims at dynamic simulations of thermal and hydraulic systems to develop control strategies for HVAC systems and analyse interactions in complex systems. It is used for simulations on component, building and city district level. As this library is developed mainly for academic purposes, user-friendliness and model robustness is not a main task. This research focus thus influences the layout and philosophy of the library. Various models are highly inspired by other libraries, especially by Modelica Standard Library and LBNL&apos;s Building Library.</p>
<p>Various connectors of the Modelica Standard Library are used, e.g. <code>Modelica.Fluid</code> and <code>Modelica.HeatTransfer</code>. These are accompanied by own connectors for simplified hydraulics (no <code>fluid.media</code>, incompressible, one phase) , shortwave radiation (intensity), longwave radiation (heat flow combined with a virtual temperature) and combined longwave radiation and thermal. The pressure in the connectors is the total pressure. The used media models are simplified from the <code>Modelica.Media</code> library. If possible and necessary, components use continuously differentiable equations. In general, zero mass flow rate and reverse flow are supported.</p>
<p>Most models have been analytically verified. In addition, hydraulic components are compared to empirical data such as performance curves. High and low order building models have been validated using a standard test suite provided by the ANSI/ASHRAE Standard 140 and VDI 6007 Guideline. The library has only been tested with Dymola.</p>
<p>The web page for this library is <a href=\"https://www.github.com/RWTH-EBC/AixLib\">https://www.github.com/RWTH-EBC/AixLib</a>. We welcome contributions from different users to further advance this library, whether it is through collaborative model development, through model use and testing or through requirements definition or by providing feedback regarding the model applicability to solve specific problems. </p>
</html>"));
end UsersGuide;
