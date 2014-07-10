within AixLib.DataBase;
package WindowsDoors "Windows and doors definition package"
      extends Modelica.Icons.Package;

  package Simple "Collection of simple window records"
    extends Modelica.Icons.Package;

    record OWBaseDataDefinition_Simple
      "Outer window base definition for simple model"
        extends Modelica.Icons.Record;

      parameter Modelica.SIunits.CoefficientOfHeatTransfer Uw=2.875
        "Thermal transmission coefficient of whole window: glass + frame";
      parameter Real g=0.8 "coefficient of solar energy transmission";
      parameter Modelica.SIunits.Emissivity Emissivity = 0.84
        "Material emissivity";
      parameter Real frameFraction=0.2
        "frame fraction from total fenestration area";
      annotation (Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Base data defintion for simple windows. </p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<p><h4><font color=\"#008000\">References</font></h4></p>
<p>Base data definition for record to be used in model <a href=\"Building.Components.WindowsDoors.WindowSimple\">Building.Components.WindowsDoors.WindowSimple</a></p>
</html>",   revisions="<html>
<p><ul>
<li><i>September 11, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
</ul></p>
</html>"));
    end OWBaseDataDefinition_Simple;

    record WindowSimple_EnEV2009 "Window according to EnEV 2009"

    extends OWBaseDataDefinition_Simple(
        Uw=1.3,
        g=0.6,
        Emissivity=0.9,
        frameFraction=0.2);
      annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 11, 2013&nbsp;</i> by Ole Odendahl:<br/>Added reference</li>
<li><i>July 5, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>",   info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Window definition according to EnEV 2009 for a simple window. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">References</span></h4>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.WindowsDoors.WindowSimple\">Building.Components.WindowsDoors.WindowSimple</a></p>
<p>Source:</p>
<ul>
<li>For EnEV see Bundesregierung (Veranst.): Verordnung &uuml;ber energiesparenden W&auml;rmeschutz und energiesparende Anlagentechnik bei Geb&auml;uden. Berlin, 2009</li>
</ul>
</html>"));
    end WindowSimple_EnEV2009;

    record WindowSimple_EnEV2002 "Window according to EnEv 2002"

    extends OWBaseDataDefinition_Simple(
        Uw=1.7,
        g=0.6,
        Emissivity=0.9,
        frameFraction=0.2);
      annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 11, 2013&nbsp;</i> by Ole Odendahl:<br/>Added reference</li>
<li><i>July 5, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>",   info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Window definition according to EnEV 2002 for a simple window. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.WindowsDoors.WindowSimple\">Building.Components.WindowsDoors.WindowSimple</a></p>
<p>Source:</p>
<ul>
<li>For EnEV see Energieeinsparverordnung 2002. 2002</li>
</ul>
</html>"));
    end WindowSimple_EnEV2002;

    record WindowSimple_WSchV1995 "Window according to WSchV1995"

    extends OWBaseDataDefinition_Simple(
        Uw=1.8,
        g=0.7,
        Emissivity=0.9,
        frameFraction=0.2);
      annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 11, 2013&nbsp;</i> by Ole Odendahl:<br/>Added reference</li>
<li><i>July 5, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>",   info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Window definition according to WSchV 1995 for a simple window. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.WindowsDoors.WindowSimple\">Building.Components.WindowsDoors.WindowSimple</a></p>
<p>Source:</p>
<ul>
<li>For EnEV see W&auml;rmeschutzverordnung 1995. 1995</li>
</ul>
</html>"));
    end WindowSimple_WSchV1995;

    record WindowSimple_WSchV1984 "Window according to WSchV1984"

    extends OWBaseDataDefinition_Simple(
        Uw=2.5,
        g=0.8,
        Emissivity=0.9,
        frameFraction=0.2);
      annotation (Documentation(revisions="<html>
<p><ul>
<li><i>September 11, 2013&nbsp;</i> by Ole Odendahl:<br/>Added reference</li>
<li><i>July 5, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>",   info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Window definition according to WSchV 1984 for a simple window. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Record is used in model <a href=\"Building.Components.WindowsDoors.WindowSimple\">Building.Components.WindowsDoors.WindowSimple</a></p>
<p>Source:</p>
<ul>
<li>For EnEV see W&auml;rmeschutzverordnung 1984. 1984</li>
</ul>
</html>"));
    end WindowSimple_WSchV1984;
  end Simple;
  annotation (Documentation(info="<html>
Window types as well as shading types.
<dl>
<dt><b>Main Author:</b>
<dd>Peter Matthes<br>
    RWTH Aachen University<br>
    E.ON Energy Research Center<br>
    EBC | Institute for Energy Efficient Buildings and Indoor Climate<br>
    Mathieustra&szlig;e 6<br> 
    52074 Aachen<br>
    e-mail: <a href=\"mailto:pmatthes@eonerc.rwth-aachen.de\">pmatthes@eonerc.rwth-aachen.de</a><br>
</dl>
</html>"));
end WindowsDoors;
