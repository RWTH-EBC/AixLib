within PhysicalCompressors.ReciprocatingCompressor.Geometry;
model Volumes "Model that calculates the piston hub volume"
  extends ReciprocatingCompressor.Geometry.Geometry_Roskoch;
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Real small = Modelica.Constants.small;
  Modelica.SIunits.Volume V_gas;
  Modelica.SIunits.Volume V_hub = Modelica.Constants.pi*(0.5*D_pis)^2*H;
  Modelica.SIunits.Volume V_dead = c_dead*V_hub;
  Real pi = Modelica.Constants.pi;
  Modelica.Blocks.Interfaces.RealOutput V1
    annotation (Placement(transformation(extent={{100,30},{120,50}})));

  Modelica.SIunits.Length x;
  Modelica.SIunits.Length x_int(start=0.001);
  Modelica.SIunits.Angle phi;

  Modelica.Blocks.Interfaces.RealOutput v_x_avg "average velocity of piston"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput A_gas_cyl
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
equation
  phi = flange_a.phi +  0.5*Modelica.Constants.pi;
  //Volume inside compressor
  flange_a.tau = 0;
  x = -0.5*H*(1 - cos(phi) + pistonRod_ratio*(1 - sqrt(1 - (1/pistonRod_ratio * sin(phi))^2))) + (1 + c_dead)*H;
  V_gas = pi*(0.5*D_pis)^2*x;
  //V_gas = Modelica.Constants.pi*D_pis*x;
  V1 = V_gas;
  A_gas_cyl = pi*D_pis*x + 2*(0.5*D_pis)^2;


  //Average velocity of piston
  der(x_int) = abs(der(x));
  if time > 0 then
    v_x_avg = x_int / time;
  else
    v_x_avg = 0;
  end if;

   annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(
          extent={{-52,52},{58,-54}},
          lineColor={0,0,0},
          fillColor={230,230,230},
          fillPattern=FillPattern.Solid)}),                       Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Volumes;
