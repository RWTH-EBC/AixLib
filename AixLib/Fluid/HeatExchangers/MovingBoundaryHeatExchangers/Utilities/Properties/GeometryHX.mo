within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities.Properties;
record GeometryHX
  "Record that contains parameters describing the heat exchanger's geometry"

  // Definition of explicit parameters
  //
  parameter Types.GeometryCV CroSecGeo = Types.GeometryCV.Circular
    "Cross-sectional geometry of the heat exchanger"
    annotation(Dialog(tab="General", group="General"));
  parameter Integer nFloCha = 25
    "Number of flow channels"
    annotation(Dialog(tab="General", group="General"));
  parameter Modelica.SIunits.Length lFloCha = 1.5
    "Total length of each flow channel"
    annotation(Dialog(tab="General", group="General"));
  parameter Modelica.SIunits.Length sFloCha = 0.002
    "Thickness of each flow channel's wall"
    annotation(Dialog(tab="General", group="General"));

  parameter Modelica.SIunits.Diameter dFloChaCir = 0.01
    "Diameter of each flow channel of a circular heat exchanger"
    annotation(Dialog(tab="General", group="Circular heat exchanger",
               enable=(CroSecGeo == Types.GeometryCV.Circular)));

  parameter Modelica.SIunits.Area ACroSecPla = 7.85e-5
    "Cross-sectional area of each flow channel of a plate heat exchanger"
    annotation(Dialog(tab="General", group="Plate heat exchanger",
               enable=(CroSecGeo == Types.GeometryCV.Plate)));
  parameter Modelica.SIunits.Length uFloChaPla = 0.0315
    "Perimeter of each flow channel of a plate heat exchanger"
    annotation(Dialog(tab="General", group="Plate heat exchanger",
               enable=(CroSecGeo == Types.GeometryCV.Plate)));

  // Definition if implicit parameters
  //
  final parameter Modelica.SIunits.Length l=
    nFloCha*lFloCha
    "Length of all flow channels";
  final parameter Modelica.SIunits.Diameter dFloCha=
    if (CroSecGeo == Types.GeometryCV.Circular)
      then dFloChaCir
    else (4*ACroSecPla)/uFloChaPla
    "Hydraulic diameter of each flow channel";

  final parameter Modelica.SIunits.Area ACroSec=
    if (CroSecGeo == Types.GeometryCV.Circular)
      then nFloCha*Modelica.Constants.pi*dFloChaCir^2/4
    else nFloCha*ACroSecPla
    "Cross-sectional area of all flow channels";
  final parameter Modelica.SIunits.Area ACroSecFloCha=
    ACroSec/nFloCha
    "Cross-sectional area of each flow channel";

  final parameter Modelica.SIunits.Area ACroSecWal=
    nFloCha*Modelica.Constants.pi/4*((dFloCha+sFloCha)^2-dFloCha^2)
    "Cross-sectional area of the wall of all flow channels";
  final parameter Modelica.SIunits.Area ACroSecWalFloCha=
    ACroSecWal/nFloCha
    "Cross-sectional area of the wall of each flow channel";

  final parameter Modelica.SIunits.Area AHeaTra=
    if (CroSecGeo == Types.GeometryCV.Circular)
      then nFloCha*Modelica.Constants.pi*dFloChaCir*lFloCha
    else nFloCha*uFloChaPla*lFloCha
    "Heat transfer area of each flow channel";
  final parameter Modelica.SIunits.Area AHeaTraFloCha=
    AHeaTra/nFloCha
    "Heat transfer area of each flow channel";

  final parameter Modelica.SIunits.Volume VCroSec=
    lFloCha*ACroSec
    "Volume of all flow channels";
  final parameter Modelica.SIunits.Volume VCroSecFloCha=
    VCroSec/nFloCha
    "Volume of each flow channel";

  final parameter Modelica.SIunits.Volume VCroSecWal=
    lFloCha*ACroSecWal
    "Volume of the wall of all flow channels";
  final parameter Modelica.SIunits.Volume VCroSecWalFloCha=
    VCroSecWal/nFloCha
    "Volume of the wall of each flow channel";

  annotation (Icon(graphics={
        Rectangle(
          extent={{-90,40},{90,-100}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Forward),
        Text(
          lineColor={0,0,255},
          extent={{-100,50},{100,90}},
          textString="%name")}), Documentation(revisions="<html>
<ul>
  <li>
  December 08, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/516\">issue 516</a>).
  </li>
</ul>
</html>",
        info="<html>
<p>
This record summarises the basic geometric parameters of a
moving boundary heat exchanger. These parameters are listed
below
</p>
<ul>
<li>
Cross-sectional geometry of the heat exchanger (i.e. tube or plate heat exhanger).
</li>
<li>
Number of flow channels.
</li>
<li>
Length of each flow channel.
</li>
<li>
Thickness of the wall of each flow channel.
</li>
</ul>
<p>
Depending on the cross-sectional geometry of the heat exchanger, the
User has to add either the circular diameter or the cross-sectional
area and perimeter of the flow channel. The latter is used in order
to calculate a fictitious hydraulic diameter.<br />
These parameters allow the calculation of some final parameters
given below:<br />
</p>
<table summary=\"Final parameters\" border=\"1\" cellspacing=\"0\" 
cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr>
<th>Name</th> 
<th>Comment</th> 
</tr> 
<tr>
<td><code>l</code></td> 
<td>Length of all flow channels.</td> 
</tr> 
<tr>
<td><code>dFloCha</code></td> 
<td>Hydraulic diameter of each flow channel.</td> 
</tr> 
<tr>
<td><code>ACroSec</code></td> 
<td>Cross-sectional area of all flow channels.</td> 
</tr> 
<tr>
<td><code>ACroSecFloCha</code></td> 
<td>Cross-sectional area of each flow channel.</td> 
</tr> 
<tr>
<td><code>ACroSecWal</code></td> 
<td>Cross-sectional area of the wall of all flow channels.</td> 
</tr> 
<tr>
<td><code>ACroSecWalFloCha</code></td> 
<td>Cross-sectional area of the wall of each flow channel.</td> 
</tr> 
<tr>
<td><code>AHeaTra</code></td> 
<td>Heat transfer area of each flow channel.</td> 
</tr> 
<tr>
<td><code>VCroSec</code></td> 
<td>Volume of all flow channels.</td> 
</tr> 
<tr>
<td><code>VCroSecFloCha</code></td> 
<td>Volume of each flow channel.</td> 
</tr> 
<tr>
<td><code>VCroSecWal</code></td> 
<td>Volume of the wall of all flow channels.</td> 
</tr> 
<tr>
<td><code>VCroSecWalFloCha</code></td> 
<td>Volume of the wall of each flow channel.</td> 
</tr> 
</table>
<p>
All models that include this record have access to the 
parameters listed in the table.
</p>
</html>"));
end GeometryHX;
