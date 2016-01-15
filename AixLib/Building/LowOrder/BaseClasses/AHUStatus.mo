within AixLib.Building.LowOrder.BaseClasses;
function AHUStatus "checks if AHU is on or off"
  input Boolean heating "Status of heating mode";
  input Boolean cooling "Status of cooling mode";
  input Boolean humidification "Status of humidification mode";
  input Boolean dehumidification "Status of dehumidification mode";
  input Integer dimension "length of withAHU";
  input Boolean[dimension] withAHU "Status of zones";
  output Boolean AHUStat "Status of AHU";
protected
  Boolean withAHUSum=false "Helper for zones";
algorithm
  for i in 1:dimension loop
    if withAHU[i] then
      withAHUSum:=true;
    end if;
  end for;
  if (heating or cooling or humidification or dehumidification) and withAHUSum then
    AHUStat:=true;
  else
    AHUStat:=false;
  end if;

  annotation (Documentation(info="<html>
<p>This function gives the status of AHU model, dependent on</p>
<ul>
<li>heating mode status</li>
<li>cooling mode status</li>
<li>humidification mode status</li>
<li>dehumdification mode status</li>
<li>supplied zones</li>
</ul>
<p>if all modes are of (booleans are <code>false</code>) and all zones are not supplied (booleans are <code>false</code>), then it returns <code>false</code>, else <code>true</code></p>
</html>", revisions="<html>
<p><ul>
<li><i>January 15, 2016&nbsp;</i> by Moritz Lauster:<br/>First implementation.</li>
</ul></p>
</html>"));
end AHUStatus;
