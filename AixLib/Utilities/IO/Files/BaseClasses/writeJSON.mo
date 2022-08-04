within AixLib.Utilities.IO.Files.BaseClasses;
function writeJSON
  "Write a vector of Real variables to a JSON file"
    input AixLib.Utilities.IO.Files.BaseClasses.JSONWriterObject ID "JSON writer object id";
    input Real[:] varVals "Variable values";

    external "C" writeJson(ID, varVals, size(varVals,1))
    annotation(Include=" #include \"jsonWriterInit.h\"",
    IncludeDirectory="modelica://AixLib/Resources/C-Sources");

  annotation (Documentation(info="<html>
 <p>
 Function for writing data to a JSON file.
 </p>
 </html>",revisions="<html>
 <ul>
 <li>
 April 15 2019, by Filip Jorissen:<br/>
 First implementation.
 </li>
 </ul>
 </html>"),
  __Dymola_LockedEditing="Model from IBPSA");
end writeJSON;
