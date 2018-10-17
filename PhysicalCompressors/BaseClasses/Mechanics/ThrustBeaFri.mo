within PhysicalCompressors.BaseClasses.Mechanics;
model ThrustBeaFri "Model that calculate the torque of thrust bearing"

  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a annotation (
      Placement(transformation(extent={{-110,-10},{-90,10}}),
        iconTransformation(extent={{-110,-10},{-90,10}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b annotation (
      Placement(transformation(extent={{90,-10},{110,10}}), iconTransformation(
          extent={{90,-10},{110,10}})));
      constant Real pi = Modelica.Constants.pi;
      parameter Modelica.SIunits.Radius r_ThrBea = 3.3E-2;
      parameter Modelica.SIunits.Radius r_ShaThrBea = 1.15E-2;
      parameter Real my_ThrBea = 0.01;
      parameter Modelica.SIunits.Distance delta = 1E-3;
      Modelica.SIunits.Angle phi;
      Modelica.SIunits.AngularVelocity w;
      Modelica.SIunits.Torque taufri; //friction Torque

equation

  //Angle and velocity
  flange_a.phi = flange_b.phi;
  phi = flange_a.phi;
  der(phi) = w;

  //Friction torque
  taufri * 2 * delta = -pi*my_ThrBea*w*(2*r_ThrBea^4-r_ShaThrBea^4);

  //torque equilibrium
  flange_a.tau + flange_b.tau + taufri = 0;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
    Rectangle(fillColor={192,192,192},
      fillPattern=FillPattern.Solid,
      extent={{-60,10},{60,25}}),
    Rectangle(fillColor={192,192,192},
      fillPattern=FillPattern.Solid,
      extent={{-60,-61},{60,-45}}),
    Polygon(fillColor={160,160,164},
      fillPattern=FillPattern.Solid,
      points={{60,-60},{60,-70},{75,-70},{75,-80},{-75,-80},{-75,-70},{-60,-70},
              {-60,-60},{60,-60}}),
    Rectangle(fillColor={255,255,255},
      fillPattern=FillPattern.Solid,
      extent={{-50,-50},{50,-18}}),
    Rectangle(fillColor={192,192,192},
      fillPattern=FillPattern.Solid,
      extent={{-60,-25},{60,-10}}),
    Polygon(fillColor={160,160,164},
      fillPattern=FillPattern.Solid,
      points={{60,60},{60,70},{75,70},{75,80},{-75,80},{-75,70},{-60,70},{-60,60},
              {60,60}}),
    Rectangle(fillColor={192,192,192},
      fillPattern=FillPattern.Solid,
      extent={{-60,45},{60,60}}),
    Rectangle(fillColor={255,255,255},
      fillPattern=FillPattern.Solid,
      extent={{-50,19},{50,51}}),
    Rectangle(lineColor={64,64,64},
      fillColor={192,192,192},
      fillPattern=FillPattern.HorizontalCylinder,
      extent={{-100,-10},{100,10}}),
        Text(
          extent={{-40,94},{20,76}},
          lineColor={28,108,200},
          textString="ThrBeaFri
")}),                                  Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end ThrustBeaFri;
