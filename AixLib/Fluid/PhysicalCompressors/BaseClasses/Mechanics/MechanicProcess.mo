within AixLib.Fluid.PhysicalCompressors.BaseClasses.Mechanics;
model MechanicProcess
  BaseClasses.Mechanics.JourBearFri jourBearFri(r_ShaJouBea=r_ShaJouBea,
    my=my,
    delta=delta,
    hjoubea=hjoubea)
    annotation (Placement(transformation(extent={{-48,-10},{-28,10}})));
  BaseClasses.Mechanics.ThrustBeaFri thrustBeaFri(
    r_ThrBea=r_ThrBea,
    r_ShaThrBea=r_ShaThrBea,
    my_ThrBea=my_ThrBea,
    delta=delta)
    annotation (Placement(transformation(extent={{-14,-10},{6,10}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J=J)
    annotation (Placement(transformation(extent={{-82,-10},{-62,10}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a annotation (
      Placement(transformation(extent={{-110,-10},{-90,10}}),
        iconTransformation(extent={{-110,-10},{-90,10}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b annotation (
      Placement(transformation(extent={{90,-10},{110,10}}), iconTransformation(
          extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealInput x "displacement length of vane"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-50,100}), iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=90,
        origin={-60,98})));
  Modelica.Blocks.Interfaces.RealInput p1 "pressure Input" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-6,100}), iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=90,
        origin={-6,100})));
  Modelica.Blocks.Interfaces.RealInput p2 "pressure output" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={44,100}), iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=90,
        origin={46,100})));
  parameter Modelica.SIunits.Inertia J=0.1 "Moment of inertia"
  annotation(Dialog(tab="Inertia",group="Geometry"));
  parameter Modelica.SIunits.Radius r_ShaJouBea=1.15E-2 "radius of shaft"
  annotation(Dialog(tab="Journal Bearing",group="Geometry"));
  parameter Modelica.SIunits.Distance delta=1E-3 "clearance"
  annotation(Dialog(tab="Journal Bearing",group="Geometry"));
  parameter Modelica.SIunits.Height hjoubea=2E-3 "height of journal bearing"
  annotation(Dialog(tab="Journal Bearing",group="Geometry"));
  parameter Real my=0.01 "coefficient of friction at journal bearing"
  annotation(Dialog(tab="Journal Bearing",group="Others"));

  parameter Modelica.SIunits.Radius r_ThrBea=3.3E-2 "Radius of thrust bearing"
annotation(Dialog(tab="Thrust Bearing",group="Geometry"));
  parameter Modelica.SIunits.Radius r_ShaThrBea=1.15E-2
    "Radius of shaft of Thrust Bearing"
    annotation(Dialog(tab="Thrust Bearing",group="Geometry"));
  parameter Real my_ThrBea=0.01 "Friction coefficient "
  annotation(Dialog(tab="Thrust Bearing",group="Others"));
  parameter Modelica.SIunits.TranslationalSpringConstant c=1
    "Spring constant of vane"
annotation(Dialog(tab="Vane",group="Coeffients"));

  parameter Modelica.SIunits.Length x0=0 "Length of spring"
annotation(Dialog(tab="Vane",group="Geometry"));
  parameter Modelica.SIunits.Density rho=7850 "Density of steel"
  annotation(Dialog(tab="Roller",group="Others"));
  parameter Modelica.SIunits.Length e=0.48E-2 "shaft eccentricity"
  annotation(Dialog(tab="Roller",group="Geometry"));

  RolTor rolTor(
    rho=rho,
    e=e,
    c=c,
    x0=x0,
    h_cyl=h_cyl,
    r_cyl=r_cyl,
    r_rol=r_rol,
    r_van=r_van,
    thi_van=thi_van,
    l_van=l_van,
    wid_van=wid_van,
    my_van=my_van)
    annotation (Placement(transformation(extent={{38,-10},{58,10}})));
  parameter Modelica.SIunits.Length h_cyl=2.8E-2 "Cylinder height"
    annotation (Dialog(tab="Cylinder", group="Geometry"));
  parameter Modelica.SIunits.Radius r_cyl=5.4E-2 "Cylinder radius"
    annotation (Dialog(tab="Cylinder", group="Geometry"));
  parameter Modelica.SIunits.Radius r_rol=4.68E-2 "Roller outer radius"
    annotation (Dialog(tab="Roller", group="Geometry"));
  parameter Modelica.SIunits.Radius r_van=0.25E-2 "Radius of vane tip"
    annotation (Dialog(tab="Vane", group="Geometry"));
  parameter Modelica.SIunits.Thickness thi_van=0.47E-2 "Vane thickness"
    annotation (Dialog(tab="Vane", group="Geometry"));
  parameter Modelica.SIunits.Length l_van=2.45E-2
    "Length of complete vane"
    annotation (Dialog(tab="Vane", group="Geometry"));
  parameter Modelica.SIunits.Length wid_van=0.47 "Vane width"
    annotation (Dialog(tab="Vane", group="Geometry"));
  parameter Real my_van=0.01 "coefficient of friction at vane tip"
    annotation (Dialog(tab="Vane", group="Coeffients"));
equation
  connect(jourBearFri.flange_b, thrustBeaFri.flange_a)
    annotation (Line(points={{-28,0},{-14,0}}, color={0,0,0}));
  connect(inertia.flange_b, jourBearFri.flange_a)
    annotation (Line(points={{-62,0},{-48,0}}, color={0,0,0}));
  connect(flange_a, inertia.flange_a)
    annotation (Line(points={{-100,0},{-82,0}}, color={0,0,0}));
  connect(thrustBeaFri.flange_b, rolTor.flange_a)
    annotation (Line(points={{6,0},{38,0}}, color={0,0,0}));
  connect(rolTor.flange_b, flange_b)
    annotation (Line(points={{58,0},{100,0}}, color={0,0,0}));
  connect(p2, rolTor.p_dis) annotation (Line(points={{44,100},{44,62},{54,62},{54,
          10}}, color={0,0,127}));
  connect(p1, rolTor.p_suc) annotation (Line(points={{-6,100},{-6,46},{48,46},{48,
          10}}, color={0,0,127}));
  connect(x, rolTor.x) annotation (Line(points={{-50,100},{-50,38},{42,38},{42,10}},
        color={0,0,127}));
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
      extent={{-100,-10},{100,10}})}), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end MechanicProcess;
