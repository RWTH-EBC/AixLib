within AixLib.Electrical.PVSystem.BaseClasses;
partial model PartialCellTemperature "Partial model for determining the cell temperature of a PV module"


 connector PVModuleData = input AixLib.DataBase.SolarElectric.PVBaseRecordNew
    "Connector for PV record data" annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          origin={0.0,-25.0},
          lineColor={64,64,64},
          fillColor={255,215,136},
          fillPattern=FillPattern.Solid,
          extent={{-100.0,-75.0},{100.0,75.0}},
          radius=25.0),
        Line(
          points={{-100.0,0.0},{100.0,0.0}},
          color={64,64,64}),
        Line(
          origin={0.0,-50.0},
          points={{-100.0,0.0},{100.0,0.0}},
          color={64,64,64}),
        Line(
          origin={0.0,-25.0},
          points={{0.0,75.0},{0.0,-75.0}},
          color={64,64,64})}));


// Adjustable input parameters

 PVModuleData data
    "PV module record"
    annotation (Placement(transformation(extent={{-140,-16},{-100,24}}),
    iconTransformation(extent={{-142,-22},{-100,24}})));

 Modelica.Blocks.Interfaces.RealInput T_a(final quantity=
    "Temp_C", final unit="K")
    "Ambient temperature"
    annotation (Placement(transformation(extent={{-140,64},{-100,114}}),iconTransformation(extent={{-140,74},{-100,114}})));

 Modelica.Blocks.Interfaces.RealInput winVel(final quantity= "Velocity",
    final unit= "m/s")
    "Wind velocity"
    annotation (Placement(transformation(extent={{-140,24},{-100,74}}), iconTransformation(extent={{-140,44},{-100,74}})));

 Modelica.Blocks.Interfaces.RealInput eta(final quantity="Efficiency",
      final unit="1",
      min=0)
    "Efficiency of the PV module under operating conditions"
    annotation (Placement(transformation(extent={{-140,-72},{-100,-22}}),
                                                                        iconTransformation(extent={{-140,-62},{-100,-22}})));

 Modelica.Blocks.Interfaces.RealInput radTil(final quantity="Irradiance",
    final unit="W/m2")
    "total solar irradiance on the tilted surface"
    annotation (Placement(transformation(extent={{-140,-102},{-100,-62}}), iconTransformation(extent={{-140,-102},{-100,
            -62}})));


// Parameters from module data sheet

 parameter Modelica.SIunits.Efficiency eta_0=data.eta_0
    "Efficiency under standard conditions";

 parameter Modelica.SIunits.Temp_K T_NOCT=data.T_NOCT
    "Cell temperature under NOCT conditions";

 final parameter Real radNOCT(final quantity="Irradiance",
    final unit="W/m2")= 800
    "Irradiance under NOCT conditions";



 Modelica.Blocks.Interfaces.RealOutput T_c(final quantity=
    "ThermodynamicTemperature", final unit="K")
    "Cell temperature"
    annotation (Placement(transformation(extent={{100,-20},{140,20}}),  iconTransformation(extent={{100,-20},{140,20}})));





  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
     Rectangle(
      lineColor={0,0,0},
      fillColor={255,255,255},
      fillPattern=FillPattern.Solid,
      extent={{-100,100},{100,-100}}),
     Text(
      lineColor={0,0,0},
      extent={{-96,95},{97,-97}},
          textString="Tc")}),
     Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PartialCellTemperature;
