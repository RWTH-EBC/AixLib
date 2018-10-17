within PhysicalCompressors.BaseClasses.Mechanics;
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
