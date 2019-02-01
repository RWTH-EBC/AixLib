within PhysicalCompressors.RotaryCompressor;
package BaseClasses
  extends Modelica.Icons.BasesPackage;

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

  package Mechanics "Package that contains models for the mechanical processes"

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
")}),                                      Diagram(coordinateSystem(
              preserveAspectRatio=false)));
    end ThrustBeaFri;

    model JourBearFri
      "Model that calculate the torque of journal bearing"

      Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a annotation (
          Placement(transformation(extent={{-110,-10},{-90,10}}),
            iconTransformation(extent={{-110,-10},{-90,10}})));
      Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b annotation (
          Placement(transformation(extent={{90,-10},{110,10}}), iconTransformation(
              extent={{90,-10},{110,10}})));

          parameter Modelica.SIunits.Radius r_ShaJouBea = 1.15E-2
          "radius of shaft"
          annotation(Dialog(tab="General",group="Geometry"));
          parameter Real my = 0.01
          "coefficient of friction at journal bearing"
          annotation(Dialog(tab="General",group="Coeffients"));
          parameter Modelica.SIunits.Distance delta = 1E-3
          "clearance"
          annotation(Dialog(tab="General",group="Geometry"));
          parameter Modelica.SIunits.Height hjoubea = 2E-3
          "height of journal bearing"
          annotation(Dialog(tab="General",group="Geometry"));
          Modelica.SIunits.Angle phi;
          Modelica.SIunits.AngularVelocity w;
          Modelica.SIunits.Torque taufri; //friction Torque

    equation

      //Angle and velocity
      flange_a.phi = flange_b.phi;
      phi = flange_a.phi;
      der(phi) = w;

      //Friction torque
      taufri * delta = - 0.66*my*hjoubea*r_ShaJouBea^3*w;

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
              extent={{-30,94},{10,82}},
              lineColor={28,108,200},
              textString="JouBeaFri")}),   Diagram(coordinateSystem(
              preserveAspectRatio=false)));
    end JourBearFri;

    model RolTor
      "Model that calculate the torque acting on the crankshaft by the roller"

      Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a annotation (
          Placement(transformation(extent={{-110,-10},{-90,10}}),
            iconTransformation(extent={{-110,-10},{-90,10}})));
      Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b annotation (
          Placement(transformation(extent={{90,-10},{110,10}}), iconTransformation(
              extent={{90,-10},{110,10}})));
          parameter Modelica.SIunits.Length h_cyl = 2.8E-2
          "Cylinder height"
          annotation(Dialog(tab="Cylinder",group="Geometry"));
          parameter Modelica.SIunits.Radius r_cyl = 5.4E-2
            "Cylinder radius"
          annotation(Dialog(tab="Cylinder",group="Geometry"));
          parameter Modelica.SIunits.Radius r_rol = 4.68E-2
          "Roller outer radius"
          annotation(Dialog(tab="Roller",group="Geometry"));
          parameter Modelica.SIunits.Radius r_van = 0.25E-2
          "Radius of vane tip"
          annotation(Dialog(tab="Vane",group="Geometry"));
          parameter Modelica.SIunits.Thickness thi_van = 0.47E-2
          "Vane thickness"
          annotation(Dialog(tab="Vane",group="Geometry"));
          parameter Modelica.SIunits.Length l_van = 2.45E-2
          "Length of complete vane"
          annotation(Dialog(tab="Vane",group="Geometry"));
          parameter Modelica.SIunits.Length wid_van = 0.47
          "Vane width"
          annotation(Dialog(tab="Vane",group="Geometry"));
          parameter Modelica.SIunits.Density rho=7850
          "Density of steel"
          annotation(Dialog(tab="General",group="others"));
          parameter Modelica.SIunits.Length e = 0.48E-2
          "shaft eccentricity"
          annotation(Dialog(tab="General",group="Geometry"));
          parameter Real my_van = 0.01
          "coefficient of friction at vane tip"
          annotation(Dialog(tab="Vane",group="Coeffients"));
          parameter Modelica.SIunits.TranslationalSpringConstant c=1 "Spring constant of vane"
          annotation(Dialog(tab="Vane",group="Coeffients"));
          parameter Modelica.SIunits.Length x0=0
          "Length of spring"
          annotation(Dialog(tab="Vane",group="Geometry"));
          constant Modelica.SIunits.Acceleration g = Modelica.Constants.g_n;
          Modelica.SIunits.Angle phi;
          Modelica.SIunits.Angle alpha;
          //eccentric angle of the roller based on the contact point of the vane
          Modelica.SIunits.Torque tau_pre; //Torque by pressure difference
          Modelica.SIunits.Torque tau_friVan; //Torque caused by vane friction
          Modelica.SIunits.Torque tau_van; //.Torque caused by vane force
          Modelica.SIunits.Torque tau_gesRol; //resulting torque
          Modelica.SIunits.Force F_pre; //Force caused by pressure difference
          Modelica.SIunits.Force F_van; //Force of Vane
          Modelica.SIunits.Force F_gas; //Force of gas on vane
          Modelica.SIunits.Force F_spr; //Force of spring
          Modelica.SIunits.Force F_ine; //Inertia Force of vane
          Modelica.SIunits.Length l_vis; //Length of vane inside vane slot
          Modelica.SIunits.Length x_van; //Length of vane displacement

      Modelica.Blocks.Interfaces.RealInput p_suc "Pressure at suction part"
        annotation (Placement(transformation(
            extent={{-22,-22},{22,22}},
            rotation=-90,
            origin={0,100}), iconTransformation(
            extent={{20,20},{-20,-20}},
            rotation=90,
            origin={0,100})));
      Modelica.Blocks.Interfaces.RealInput p_dis "pressure at discharge part"
        annotation (Placement(transformation(
            extent={{22,-22},{-22,22}},
            rotation=90,
            origin={40,100}), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=-90,
            origin={60,100})));
      Modelica.Blocks.Interfaces.RealInput x "Vane displacement length" annotation (
         Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=-90,
            origin={-40,100}), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=-90,
            origin={-60,100})));
    equation
      //Forces
      F_gas=0;
      F_spr=c*(x0-x_van); //Spring force of vane
      F_ine=g*rho*l_van*wid_van*thi_van; //inertia force of vane
      F_pre = r_rol*h_cyl*sin((phi+alpha)/2) * (p_dis-p_suc); // Force caused by pressure difference
      x_van =x;
      l_vis = l_van-x_van;

      //Calculation of Force by the vane on roller
      F_van = (-l_vis*(F_gas+F_spr+F_ine)+ my_van*F_gas*(l_vis+x+thi_van*my_van))/
             (- (cos(alpha)+my_van*sin(alpha)) * (l_vis+2*my_van*r_van*sin(alpha))
             +my_van*(sin(alpha)-my_van*cos(alpha))
             *(2*x_van+l_vis+thi_van*my_van-2*r_van*(1-cos(alpha))));

      //Angle and velocity
      flange_a.phi = flange_b.phi;
      phi = flange_a.phi;

      //eccentric angle of the roller based on the contact point of the vane
      alpha = asin((r_cyl-r_rol)*sin(phi)/(r_rol+r_van));

      //Torques
      tau_pre =e * F_pre * sin(0.5*(alpha+phi));//1.Torque caused by pressure difference
      tau_van = - e*F_van*sin(alpha+phi);       //2.Torque caused by vane force
      tau_friVan = +e*my_van*F_van*cos(alpha+phi);  //3.Torque caused by vane friction
      -tau_gesRol = tau_pre+tau_van+tau_friVan;
       //torque equilibrium
       flange_a.tau + flange_b.tau + tau_gesRol = 0;

      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
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
              fillPattern=FillPattern.Solid)}),
                                           Diagram(coordinateSystem(
              preserveAspectRatio=false)));
    end RolTor;

    model MechanicProcess
      BaseClasses.Mechanics.JourBearFri jourBearFri(
        r_ShaJouBea=r_ShaJouBea,
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
  end Mechanics;

  model CompressorVolumes
    "Model that describes the volumes of suction and discharge port"

    Modelica.Blocks.Interfaces.RealOutput Vout1
      annotation (Placement(transformation(extent={{100,60},{128,88}})));
          parameter Modelica.SIunits.Radius r_cyl;
          parameter Modelica.SIunits.Radius r_rol;
          parameter Modelica.SIunits.Length h_cyl;
          parameter Modelica.SIunits.Thickness thi_van;
          import Modelica.Constants.pi;
          Modelica.SIunits.Volume V_cha;
          Modelica.SIunits.Volume V_disCha;
          Modelica.SIunits.Volume V_suc;
          Modelica.SIunits.Volume V_ges; //Volume of cylinder minus roller
          Modelica.SIunits.Volume V_vanDis;
          Modelica.SIunits.Volume V2;
          Modelica.SIunits.Volume V1;
          Modelica.SIunits.VolumeFlowRate Vdot;
          Modelica.SIunits.Angle phi_rel; //Current angle of crankshaft for suction part
          Modelica.SIunits.Length x_vanDis; //Vane Displacement length
          Modelica.SIunits.AngularVelocity w; //angular velocity
          Modelica.SIunits.Frequency n; //rounds per second
          Real b;
          Modelica.SIunits.AngularAcceleration a; //Winkelbeschleinigung
          Real counter; //Umdrehungen

    Modelica.Blocks.Interfaces.RealOutput Vout2
      annotation (Placement(transformation(extent={{100,26},{130,56}})));
    Modelica.Blocks.Interfaces.RealOutput x "Vane displacement length"
      annotation (Placement(transformation(extent={{100,-22},{130,8}})));
    Modelica.Blocks.Interfaces.RealOutput valve1
      annotation (Placement(transformation(extent={{100,-58},{126,-32}})));
    Modelica.Blocks.Interfaces.RealOutput valve2
      annotation (Placement(transformation(extent={{100,-86},{126,-60}})));
    Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  equation
    counter = (div(flange_a.phi,2*pi));
    der(flange_a.phi) = w;
    der(w) = a;
    2*pi*n = w;
    flange_a.tau = 0;
    phi_rel = rem(flange_a.phi,2*pi);
    b=r_rol/r_cyl;
    V_ges = pi*h_cyl*(r_cyl^2-r_rol^2);
    V_cha = 0.5*h_cyl * r_cyl^2*
    (
    (1-b^2)*phi_rel
    -(1-b)^2*0.5*sin(2*phi_rel)
    -b^2*asin((1/b-1)*sin(phi_rel))
    -b*(1-b)*sin(phi_rel)*sqrt((1-(b-1)^2*sin(phi_rel)^2)));

    x_vanDis = r_cyl*(1-(1-b)*cos(phi_rel)-sqrt((1-b)^2*cos(phi_rel)^2+2*b-1));
    V_vanDis = x_vanDis * thi_van * h_cyl;
    V_suc = V_cha - 0.5 * V_vanDis;
    V_disCha = V_ges - V_suc - V_vanDis;

    if rem(counter,2) == 0 then
      V1 = V_suc;
      V2 = V_disCha;
      valve1 = 1;
      valve2 = 0;
    else
      V1 = V_disCha;
      V2 = V_suc;
      valve1 = 0;
      valve2 = 1;
    end if;
    //Outputs
    x=x_vanDis;
    Vout1 = V1;
    Vout2 = V2;
    Vdot = abs(der(V1));

    annotation (Icon(graphics={
          Ellipse(
            extent={{-52,52},{58,-54}},
            lineColor={0,0,0},
            fillColor={230,230,230},
            fillPattern=FillPattern.Solid)}));
  end CompressorVolumes;

  model CompressionProcess
    Modelica.Fluid.Interfaces.FluidPort_a port_a annotation (Placement(
          transformation(extent={{-116,-16},{-84,14}}), iconTransformation(extent=
             {{-108,-10},{-88,10}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b annotation (Placement(
          transformation(extent={{82,-18},{116,16}}), iconTransformation(extent={{
              88,-12},{114,12}})));
    Modelica.Blocks.Interfaces.RealInput v1 annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=-90,
          origin={-20,100}), iconTransformation(
          extent={{-20,-20},{20,20}},
          rotation=-90,
          origin={-40,80})));
    Modelica.Blocks.Interfaces.RealInput v2 annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=-90,
          origin={20,100}), iconTransformation(
          extent={{-20,-20},{20,20}},
          rotation=-90,
          origin={40,80})));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
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
            fillPattern=FillPattern.Solid)}), Diagram(coordinateSystem(
            preserveAspectRatio=false)));

  end CompressionProcess;
end BaseClasses;
