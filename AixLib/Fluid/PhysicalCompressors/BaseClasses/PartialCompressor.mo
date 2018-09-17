within AixLib.Fluid.PhysicalCompressors.BaseClasses;
partial model PartialCompressor

// Definition of the medium
  //
  replaceable package Medium =
    Modelica.Media.Air.SimpleAir
    "Medium in the component"
    annotation (choicesAllMatching = true);
   // constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium

//general parameters

  parameter Modelica.SIunits.Length hcyl = 2.8E-2
  "Cylinder height"
  annotation(Dialog(tab="Cylinder",group="Geometry"));
  parameter Modelica.SIunits.Radius Rcyl = 5.4E-2
  "Cylinder radius"
  annotation(Dialog(tab="Cylinder",group="Geometry"));
  parameter Modelica.SIunits.Radius Rrol = 4.68E-2
  "Roller outer radius"
  annotation(Dialog(tab="Roller",group="Geometry"));
  parameter Modelica.SIunits.Radius Rvan = 0.25E-2
  "Radius of vane tip"
  annotation(Dialog(tab="Vane",group="Geometry"));
  parameter Modelica.SIunits.Thickness Vanthi = 0.47E-2
  "Vane thickness"
  annotation(Dialog(tab="Vane",group="Geometry"));
  parameter Modelica.SIunits.Length lvan = 2.45E-2
  "Length of complete vane"
  annotation(Dialog(tab="Vane",group="Geometry"));
  parameter Modelica.SIunits.Length widVan = 0.47
  "Vane width"
  annotation(Dialog(tab="Vane",group="Geometry"));
  parameter Modelica.SIunits.Density rho=7850
  "Density of steel"
  annotation(Dialog(tab="General",group="others"));
  parameter Modelica.SIunits.Length e = 0.48E-2
  "shaft eccentricity"
  annotation(Dialog(tab="General",group="Geometry"));
  parameter Real myvan = 0.01
  "coefficient of friction at vane tip"
  annotation(Dialog(tab="Vane",group="Coeffients"));

  annotation (Icon(graphics={
        Ellipse(
          extent={{-40,42},{40,-38}},
          lineColor={0,0,0},
          fillColor={230,230,230},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-20,32},{40,-28}},
          lineColor={0,0,0},
          fillColor={182,182,182},
          fillPattern=FillPattern.CrossDiag),
        Ellipse(
          extent={{-6,10},{6,-2}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-2,50},{2,30}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}));
end PartialCompressor;
