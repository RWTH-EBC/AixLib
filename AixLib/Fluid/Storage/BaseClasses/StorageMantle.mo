within AixLib.Fluid.Storage.BaseClasses;
model StorageMantle

  // Assumptions
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));

  parameter Modelica.Units.SI.Length height=0.15 "Height of layer"
    annotation (Dialog(tab="Geometrical Parameters"));
  parameter Modelica.Units.SI.Diameter D1=1 "Inner tank diameter"
    annotation (Dialog(tab="Geometrical Parameters"));
  parameter Modelica.Units.SI.Thickness sWall=0.1 "Thickness of wall"
    annotation (Dialog(tab="Geometrical Parameters"));
  parameter Modelica.Units.SI.Thickness sIns=0.1 "Thickness of insulation"
    annotation (Dialog(tab="Geometrical Parameters"));

  final parameter Modelica.Units.SI.Area AInside=D1*Modelica.Constants.pi*
      height "Inner area";
  final parameter Modelica.Units.SI.Area AOutside=(D1 + 2*(sWall + sIns))*
      Modelica.Constants.pi*height "Outer area";

  parameter Modelica.Units.SI.ThermalConductivity lambdaWall=50
    "Thermal Conductivity of wall";
  parameter Modelica.Units.SI.ThermalConductivity lambdaIns=0.045
    "Thermal Conductivity of insulation";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConIn=2
    "Heat transfer coefficient water <-> wall";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConOut=2
    "Heat transfer coefficient insulation <-> air";
  parameter Modelica.Units.SI.Temperature TStartWall=293.15
    "Starting Temperature of wall in K";
  parameter Modelica.Units.SI.Temperature TStartIns=293.15
    "Starting Temperature of insulation in K";
  parameter Modelica.Units.SI.Density rhoIns=1600 "Density of insulation";
  parameter Modelica.Units.SI.SpecificHeatCapacity cIns=1000
    "Specific heat capacity of insulation";
  parameter Modelica.Units.SI.Density rhoWall=1600 "Density of Insulation";
  parameter Modelica.Units.SI.SpecificHeatCapacity cWall=1000
    "Specific heat capacity of wall";

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatportOuter
    "Outer heat port"
    annotation (Placement(transformation(extent={{80,0},{100,20}}, rotation=
           0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatportInner
    "Inner heat port"
    annotation (Placement(transformation(extent={{-100,0},{-80,20}},
          rotation=0)));

  AixLib.Utilities.HeatTransfer.CylindricHeatTransfer Insulation(
    final energyDynamics=energyDynamics,
    rho=rhoIns,
    c=cIns,
    lambda=lambdaIns,
    T0=TStartIns,
    length=height,
    d_out=D1 + 2*sWall + 2*sIns,
    d_in=D1 + 2*sWall)
    "Heat transfer through insulation"
    annotation (Placement(transformation(extent={{-4,-12},{44,32}})));

  AixLib.Utilities.HeatTransfer.CylindricHeatTransfer Wall(
    final energyDynamics=energyDynamics,
    rho=rhoWall,
    c=cWall,
    lambda=lambdaWall,
    T0=TStartWall,
    length=height,
    d_out=D1 + 2*sWall,
    d_in=D1)
    "Heat transfer through wall"
    annotation (Placement(transformation(extent={{-70,-12},{-22,32}})));

  AixLib.Utilities.HeatTransfer.HeatConv convInside(hCon=hConIn, A=AInside) "Inner heat convection"
    annotation (Placement(transformation(extent={{-80,4},{-68,16}}, rotation=0)));
  AixLib.Utilities.HeatTransfer.HeatConv convOutside(A=AOutside, hCon=hConOut) "Outer heat convection"
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={62,10})));
equation
  connect(convInside.port_a, heatportInner) annotation (Line(
      points={{-80,10},{-90,10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(convOutside.port_a, heatportOuter) annotation (Line(
      points={{68,10},{90,10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(convInside.port_b,Wall.port_a)  annotation (Line(
      points={{-68,10},{-46,10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(Wall.port_b,Insulation.port_a)  annotation (Line(
      points={{-46,29.36},{-14,29.36},{-14,10},{20,10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(Insulation.port_b,convOutside.port_b)  annotation (Line(
      points={{20,29.36},{38,29.36},{38,10},{56,10}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
            -100,-100},{100,100}}),
                      graphics),
                       Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{40,100},{60,-100}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={170,255,255}),
        Rectangle(
          extent={{40,-100},{-40,100}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,100},{-40,-100}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={170,255,255}),
        Rectangle(
          extent={{-10,100},{40,-100}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={175,175,175},
          fillPattern=FillPattern.CrossDiag),
        Text(
          extent={{-100,-40},{100,-80}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={175,175,175},
          fillPattern=FillPattern.CrossDiag,
          textString="%name")}),
    Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Model of a sandwich wall construction for a cylindric mantle for heat
  storages.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The cylindric heat transfer is implemented consisting of the
  insulation material and the tank material. Only the material data is
  used for the calculation of losses. No additional losses are
  included.
</p>
</html>",
      revisions="<html><ul>
  <li>January 24, 2020 by Philipp Mehrfeld:<br/>
    <a href=
    \"https://github.com/ibpsa/modelica-ibpsa/issues/793\">#793</a>
    Switch to Dynamics enumerator to control init and energy conversion
    during simulation.
  </li>
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
end StorageMantle;
