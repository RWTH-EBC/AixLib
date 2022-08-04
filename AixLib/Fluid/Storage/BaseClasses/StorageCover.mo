within AixLib.Fluid.Storage.BaseClasses;
model StorageCover "Sandwich wall construction for heat storage cover"

  // Assumptions
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));

  parameter Modelica.Units.SI.Diameter D1=1 "Inner tank diameter"
    annotation (Dialog(tab="Geometrical Parameters"));
  parameter Modelica.Units.SI.Thickness sWall=0.1 "Thickness of wall"
    annotation (Dialog(tab="Geometrical Parameters"));
  parameter Modelica.Units.SI.Thickness sIns=0.1 "Thickness of insulation"
    annotation (Dialog(tab="Geometrical Parameters"));

  parameter Modelica.Units.SI.Area AWall=D1^2/4*Modelica.Constants.pi "Area"
    annotation (Dialog(tab="Geometrical Parameters"));

  parameter Modelica.Units.SI.ThermalConductivity lambdaWall=50
    "Thermal Conductivity of wall"
    annotation (Dialog(group="Thermal properties"));
  parameter Modelica.Units.SI.ThermalConductivity lambdaIns=0.045
    "Thermal Conductivity of insulation"
    annotation (Dialog(group="Thermal properties"));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConIn=2
    "Convective heat transfer coefficient water <-> wall"
    annotation (Dialog(group="Thermal properties"));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConOut=2
    "Convective heat transfer coefficient insulation <-> air"
    annotation (Dialog(group="Thermal properties"));
  parameter Modelica.Units.SI.Temperature TStartWall=293.15
    "Starting Temperature of wall in K"
    annotation (Dialog(tab="Initialization"));
  parameter Modelica.Units.SI.Temperature TStartIns=293.15
    "Starting Temperature of insulation in K"
    annotation (Dialog(tab="Initialization"));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatportInner
    "Inner heat port"
    annotation (Placement(transformation(extent={{-100,0},{-80,20}},
          rotation=0)));
  parameter Modelica.Units.SI.Density rhoIns=1600 "Density of insulation"
    annotation (Dialog(group="Material properties"));
  parameter Modelica.Units.SI.SpecificHeatCapacity cIns=1000
    "Specific heat capacity of insulation"
    annotation (Dialog(group="Material properties"));
  parameter Modelica.Units.SI.Density rhoWall=1600 "Density of Insulation"
    annotation (Dialog(group="Material properties"));
  parameter Modelica.Units.SI.SpecificHeatCapacity cWall=1000
    "Specific heat capacity of wall"
    annotation (Dialog(group="Material properties"));

  AixLib.Utilities.HeatTransfer.HeatConv convInside(final hCon=hConIn, final A=AWall)
                                                                          "Inside heat convection"
    annotation (Placement(transformation(extent={{-80,0},{-60,20}}, rotation=0)));


  Modelica.Thermal.HeatTransfer.Components.ThermalConductor condWall1(final G=(AWall)*(lambdaWall)/(sWall/2))
        "Heat conduction through first wall layer" annotation (Placement(
        transformation(extent={{-50,0},{-30,20}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor loadWall(
    final C=cWall*rhoWall*AWall*sWall,
    final T(
      stateSelect=StateSelect.always,
      fixed=(energyDynamics == Modelica.Fluid.Types.Dynamics.FixedInitial),
      start=TStartWall),
    final der_T(
      fixed=(energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyStateInitial),
      start=0)) if not (energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState)
        "Heat capacity of wall" annotation (Placement(
        transformation(extent={{-20,-26},{0,-6}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor condWall2(final G=(AWall)*(lambdaWall)/(sWall/2))
        "Heat conduction through second wall layer" annotation (Placement(
        transformation(extent={{-20,0},{0,20}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor condIns1(G=(AWall)*(lambdaIns)/(sIns/2))
        "Heat conduction through first insulation layer" annotation (Placement(
        transformation(extent={{10,0},{30,20}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor loadIns(
    C=cIns*rhoIns*AWall*sIns,
    final T(
      stateSelect=StateSelect.always,
      fixed=(energyDynamics == Modelica.Fluid.Types.Dynamics.FixedInitial),
      start=TStartIns),
    final der_T(
      fixed=(energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyStateInitial),
      start=0)) if not (energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState)
        "Heat capacity of insulation" annotation (Placement(transformation(
          extent={{36,-28},{56,-8}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor condIns2(G=(AWall)*(lambdaIns)/(sIns/2))
        "Heat conduction through second insulation layer" annotation (Placement(
        transformation(extent={{38,0},{58,20}}, rotation=0)));

  AixLib.Utilities.HeatTransfer.HeatConv convOutside(final hCon=hConOut, A=AWall)
                                                                            "Outside heat convection"
    annotation (Placement(transformation(
        origin={72,10},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatportOuter
    "Outer heat port"
    annotation (Placement(transformation(extent={{80,0},{100,20}}, rotation=
           0)));
equation
  connect(convOutside.port_a, heatportOuter) annotation (Line(
      points={{82,10},{90,10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(condWall1.port_b,condWall2.port_a)  annotation (Line(
      points={{-30,10},{-25,10},{-25,10},{-20,10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(condWall2.port_b,condIns1.port_a)  annotation (Line(
      points={{0,10},{10,10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(condIns1.port_b,condIns2.port_a)  annotation (Line(
      points={{30,10},{34,10},{34,10},{38,10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(condIns2.port_b,convOutside.port_b)  annotation (Line(
      points={{58,10},{62,10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(loadWall.port, condWall1.port_b) annotation (Line(
      points={{-10,-26},{-26,-26},{-26,10},{-30,10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(loadIns.port, condIns1.port_b) annotation (Line(
      points={{46,-28},{32,-28},{32,10},{30,10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(convInside.port_a, heatportInner) annotation (Line(
      points={{-80,10},{-90,10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(convInside.port_b,condWall1.port_a)  annotation (Line(
      points={{-60,10},{-50,10}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (         Icon(coordinateSystem(preserveAspectRatio=false,
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
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  Model of a sandwich wall construction as cover of a hot water tank
  (thermal storage).
</p>
<h4>
  <span style=\"color: #008000\">Concept</span>
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
end StorageCover;
