within AixLib.Obsolete.Year2019.Fluid.Storage;
model StorageWall "Sandwich wall construction for heat storages"

  extends AixLib.Obsolete.BaseClasses.ObsoleteModel;
  extends AixLib.Fluid.Storage.BaseClasses.StorageCover(AWall= D1*Modelica.Constants.pi * height,
    condIns1(G=(AIns)*(lambdaIns)/(sIns/2)),
    condIns2(G=(AIns)*(lambdaIns)/(sIns/2)),
    convOutside(hCon=hConOut, A=AOutside),
    loadIns(C=cIns*(rhoIns)*(AIns)*(sIns)));

  parameter Modelica.Units.SI.Length height=0.15 "Height of layer"
    annotation (Dialog(tab="Geometrical Parameters"));
  parameter Modelica.Units.SI.Area AIns=(D1 + 2*sWall)*Modelica.Constants.pi*
      height;
  parameter Modelica.Units.SI.Area AOutside=(D1 + 2*(sWall + sIns))*Modelica.Constants.pi
      *height;

equation

  annotation (obsolete = "Obsolete model - Almost same behavior as AixLib.Fluid.Storage.BaseClasses.StorageCover.", Diagram(graphics),
                       Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}})),
    Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Model of a sandwich wall construction for a wall for heat storages.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The heat transfer is implemented consisting of the insulation
  material and the tank material. Only the material data is used for
  the calculation of losses. No additional losses are included.
</p>
</html>",
      revisions="<html><ul>
  <li>
    <i>October 12, 2016&#160;</i> by Marcus Fuchs:<br/>
    Add comments and fix documentation
  </li>
  <li>
    <i>October 11, 2016&#160;</i> by Sebastian Stinner:<br/>
    Added to AixLib
  </li>
  <li>
    <i>March 25, 2015&#160;</i> by Ana Constantin:<br/>
    Uses components from MSL
  </li>
  <li>
    <i>October 2, 2013&#160;</i> by Ole Odendahl:<br/>
    Added documentation and formatted appropriately
  </li>
</ul>
</html>
"));
end StorageWall;
