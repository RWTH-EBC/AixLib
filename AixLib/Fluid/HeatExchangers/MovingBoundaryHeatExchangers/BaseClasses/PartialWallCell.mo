within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.BaseClasses;
partial model PartialWallCell
  "This model is a base class for all models describing wall cells"

  // Definition of records describing the cross-sectional geometry
  //
  inner replaceable parameter
    Utilities.Properties.GeometryHX geoCV
    "Record that contains geometric parameters of the heat exchanger"
    annotation (choicesAllMatching=true,
                Dialog(tab="General",group="Parameters"),
                Placement(transformation(extent={{-90,72},{-70,92}})));
  inner replaceable parameter
  Utilities.Properties.MaterialHX matHX
    "Record that contains parameters of the heat exchanger's material properties"
    annotation (choicesAllMatching=true,
                Dialog(tab="General",group="Parameters"),
                Placement(transformation(extent={{-90,42},{-70,62}})));

  // Definition of parameters describing advanced options
  //
  parameter Modelica.SIunits.Frequency tauTem = 1
    "Time constant describing convergence of wall temperatures of inactive regimes"
    annotation(Dialog(tab="Advanced",group="Heat Conduction"));

  parameter Boolean iniSteSta = false
    "=true, if temperatures of different regimes are initialised steady state"
    annotation(Dialog(tab="Advanced",group="Initialisation"));
  parameter Modelica.SIunits.Temperature TSCIni = 293.15
    "Temperature of supercooled regime at initialisation"
    annotation(Dialog(tab="Advanced",group="Initialisation",
               enable=not iniSteSta));
  parameter Modelica.SIunits.Temperature TTPIni = 293.15
    "Temperature of two-phase regime at initialisation"
    annotation(Dialog(tab="Advanced",group="Initialisation",
               enable=not iniSteSta));
  parameter Modelica.SIunits.Temperature TSHIni = 293.15
    "Temperature of superheated regime at initialisation"
    annotation(Dialog(tab="Advanced",group="Initialisation",
               enable=not iniSteSta));

  // Definition of subcomponents and connectors
  //
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortSCPri
    "Heat port of the heat exchange with the primary fluid of the 
    supercooled regime"
    annotation (Placement(transformation(extent={{-36,-110},{-16,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortTPPri
    "Heat port of the heat exchange with the primary fluid of the 
    two-phase regime"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortSHPri
    "Heat port of the heat exchange with the primary fluid of the 
    superheated regime"
    annotation (Placement(transformation(extent={{16,-110},{36,-90}})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortSCSec
    "Heat port of the heat exchange with the secondary fluid of the 
    supercooled regime"
    annotation (Placement(transformation(extent={{-36,90},{-16,110}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortTPSec
    "Heat port of the heat exchange with the secondary fluid of the 
    two-phase regime"
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortSHSec
    "Heat port of the heat exchange with the secondary fluid of the 
    superheated regime"
    annotation (Placement(transformation(extent={{16,90},{36,110}})));

  Modelica.Blocks.Interfaces.RealInput lenInl[3]
    "Lengths of the different regimes"
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,-104}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,-100})));
  Modelica.Blocks.Interfaces.RealOutput lenOut[3]
    "Lengths of the different regimes"
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,104}),  iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,100})));

  Utilities.Interfaces.ModeCVInput modCV
    "Current mode of the control volumes"
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={70,-104}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={70,-100})));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Forward), Text(
          extent={{-80,80},{80,-80}},
          lineColor={28,108,200},
          textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
  <li>
  December 09, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/516\">issue 516</a>).
  </li>
</ul>
</html>", info="<html>
<p>
This model is a base class for all wall cells of a moving boundary 
heat exchanger. Therefore, this models defines some connectors, 
parameters and submodels that are required for all wall cells.
These basic definitions are listed below:
</p>
<ul>
<li>
Parameters describing the cross-sectional geometry.
</li>
<li>
Parameters describing the material properties.
</li>
<li>
Parameters describing the thermal conductance.
</li>
<li>
Definition of heat ports.
</li>
</ul>
<p>
Models that inherits from this base class are stored in
<a href=\"modelica://AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities.WallCells\">
AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities.WallCells.</a>
</p>
</html>"));
end PartialWallCell;
