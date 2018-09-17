within AixLib.Fluid.PhysicalCompressors.BaseClasses;
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
