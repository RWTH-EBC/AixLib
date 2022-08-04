within AixLib.Electrical.PVSystem;
package BaseClasses
        extends Modelica.Icons.BasesPackage;


  partial model PartialIVCharacteristics
    "Partial model for IV Characteristic of a PV module"

  replaceable parameter AixLib.DataBase.SolarElectric.PVBaseDataDefinition data
   constrainedby AixLib.DataBase.SolarElectric.PVBaseDataDefinition
   "PV Panel data definition"
                             annotation (choicesAllMatching);

  // Adjustable input parameters

   parameter Real n_mod(final quantity=
      "NumberOfModules", final unit="1") "Number of connected PV modules"
      annotation ();


  // Parameters from module data sheet

  final parameter Modelica.Units.SI.Efficiency eta_0=data.eta_0
    "Efficiency under standard conditions";

   final parameter Real n_ser=data.n_ser
      "Number of cells connected in series on the PV panel";

  final parameter Modelica.Units.SI.Area A_pan=data.A_pan
    "Area of one Panel, must not be confused with area of the whole module";

  final parameter Modelica.Units.SI.Area A_mod=data.A_mod
    "Area of one module (housing)";

  final parameter Modelica.Units.SI.Voltage V_oc0=data.V_oc0
    "Open circuit voltage under standard conditions";

  final parameter Modelica.Units.SI.ElectricCurrent I_sc0=data.I_sc0
    "Short circuit current under standard conditions";

  final parameter Modelica.Units.SI.Voltage V_mp0=data.V_mp0
    "MPP voltage under standard conditions";

  final parameter Modelica.Units.SI.ElectricCurrent I_mp0=data.I_mp0
    "MPP current under standard conditions";

  final parameter Modelica.Units.SI.Power P_Max=data.P_mp0*1.05
    "Maximal power of one PV module under standard conditions. P_MPP with 5 % tolerance. This is used to limit DCOutputPower.";

   final parameter Real TCoeff_Isc(unit = "A/K")=data.TCoeff_Isc
      "Temperature coefficient for short circuit current, >0";

   final parameter Real TCoeff_Voc(unit = "V/K")=data.TCoeff_Voc
      "Temperature coefficient for open circuit voltage, <0";

  final parameter Modelica.Units.SI.LinearTemperatureCoefficient alpha_Isc=data.alpha_Isc
    "Normalized temperature coefficient for short circuit current, >0";

  final parameter Modelica.Units.SI.LinearTemperatureCoefficient beta_Voc=data.beta_Voc
    "Normalized temperature coefficient for open circuit voltage, <0";

  final parameter Modelica.Units.SI.LinearTemperatureCoefficient gamma_Pmp=data.gamma_Pmp
    "Normalized temperature coefficient for power at MPP";

  final parameter Modelica.Units.SI.Temperature T_c0=25 + 273.15
    "Thermodynamic cell temperature under standard conditions";


   Modelica.Blocks.Interfaces.RealOutput DCOutputPower(
    final quantity="Power",
    final unit="W")
    "DC output power of the PV array"
    annotation(Placement(
    transformation(extent={{100,50},{120,70}}),
    iconTransformation(extent={{100,50},{120,70}})));


   Modelica.Blocks.Interfaces.RealOutput eta(
    final quantity="Efficiency",
    final unit="1",
    min=0)
    "Efficiency of the PV module under operating conditions"
    annotation(Placement(
    transformation(extent={{100,-70},{120,-50}}),
    iconTransformation(extent={{100,-70},{120,-50}})));

    Modelica.Blocks.Interfaces.RealInput T_c(final quantity=
      "ThermodynamicTemperature", final unit="K")
      "Cell temperature"
      annotation (Placement(transformation(extent={{-140,20},{-100,60}}), iconTransformation(extent={{-140,20},{-100,60}})));

   Modelica.Blocks.Interfaces.RealInput absRadRat(final unit= "1")
      "Ratio of absorbed radiation under operating conditions to standard conditions"
      annotation (Placement(transformation(extent={{-140,-60},{-100,-20}}), iconTransformation(extent={{-140,-60},{-100,-20}})));

   Modelica.Blocks.Interfaces.RealInput radTil(final unit="W/m2")
      "Total solar irradiance on the tilted surface"
      annotation (Placement(transformation(extent={{-140,-100},{-100,-60}}), iconTransformation(extent={{-140,-100},{-100,
              -60}})));


    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
       Rectangle(
        lineColor={0,0,0},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid,
        extent={{-100,100},{100,-100}}),
          Line(
            points={{-66,-64},{-66,88}},
            color={0,0,0},
            arrow={Arrow.None,Arrow.Filled},
            thickness=0.5),
          Line(
            points={{-66,-64},{64,-64}},
            color={0,0,0},
            arrow={Arrow.None,Arrow.Filled},
            thickness=0.5),
          Text(
            extent={{-72,80},{-102,68}},
            lineColor={0,0,0},
            lineThickness=0.5,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="I"),
          Text(
            extent={{80,-80},{50,-92}},
            lineColor={0,0,0},
            lineThickness=0.5,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="U"),
          Line(
            points={{-66,54},{-66,54},{-6,54},{12,50},{22,42},{32,28},{38,8},{42,-14},
                {44,-44},{44,-64}},
            color={0,0,0},
            thickness=0.5,
            smooth=Smooth.Bezier)}),
                                 Diagram(coordinateSystem(preserveAspectRatio=false)));
  end PartialIVCharacteristics;


end BaseClasses;
