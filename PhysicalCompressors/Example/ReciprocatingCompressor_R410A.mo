within PhysicalCompressors.Example;
model ReciprocatingCompressor_R410A
  "Compressor Model using fluid dependent correlation for effective valve areas"

  ReciprocatingCompressor.Utilities.Geometry.Volumes volumes annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-10,68})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(w_fixed=314.16)
    annotation (Placement(transformation(extent={{-96,68},{-76,88}})));
  Modelica.Fluid.Sources.FixedBoundary Evaporator_out(
    use_p=true,
    use_T=true,
    redeclare package Medium = ReciprocatingCompressor.Medium,
    nPorts=1,
    T(displayUnit="K") = 290.15,
    p(displayUnit="bar") = 400000)
              annotation (Placement(transformation(extent={{-100,30},{-80,50}})));
  Modelica.Fluid.Sources.FixedBoundary Condenser_in(
    use_T=true,
    redeclare package Medium = ReciprocatingCompressor.Medium,
    T(displayUnit="degC") = 373.15,
    nPorts=1,
    p=4500000)                      annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={88,40})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature Ambient(T=298.15)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={28,-62})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor CompressorWall(
                                 C=5, T(start=340, displayUnit="K"))
                       annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-38,-12})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor
    thermalConductor_ambient(G=G)
    "Thermal conduction between cylinder and ambient" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-12,-36})));
  final parameter Modelica.SIunits.ThermalConductance G=ReciprocatingCompressor.Utilities.Geometry_Roskoch.G_wall_env
    "Constant thermal conductance of material";
  ReciprocatingCompressor.Utilities.ThermalConductor_Gas_Cylinder
    thermalConductor_Gas_Cylinder annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-12,12})));
  ReciprocatingCompressor.Utilities.closedVolume2 Piston
    annotation (Placement(transformation(extent={{-20,30},{0,50}})));
equation

  connect(constantSpeed.flange, volumes.flange_a) annotation (Line(points={{-76,78},
          {-10,78}},                       color={0,0,0}));
  connect(Ambient.port, thermalConductor_ambient.port_a)
    annotation (Line(points={{18,-62},{-12,-62},{-12,-46}},
                                                 color={191,0,0}));
  connect(thermalConductor_ambient.port_b, CompressorWall.port)
    annotation (Line(points={{-12,-26},{-12,-12},{-28,-12}},
                                                           color={191,0,0}));
  connect(thermalConductor_Gas_Cylinder.port_a, CompressorWall.port)
    annotation (Line(points={{-12,2},{-12,-12},{-28,-12}},         color={191,0,
          0}));
  connect(volumes.A_gas_cyl, thermalConductor_Gas_Cylinder.A_cg) annotation (
      Line(points={{-14,57},{-28,57},{-28,16},{-22,16}}, color={0,0,127}));
  connect(volumes.v_x_avg, Piston.v_pis)
    annotation (Line(points={{-10,57},{-12,57},{-12,50}}, color={0,0,127}));
  connect(volumes.V1, Piston.u)
    annotation (Line(points={{-6,57},{-8,57},{-8,50}}, color={0,0,127}));
  connect(Evaporator_out.ports[1], Piston.Fluid_in)
    annotation (Line(points={{-80,40},{-20,40}}, color={0,127,255}));
  connect(Piston.Fluid_out, Condenser_in.ports[1])
    annotation (Line(points={{0,40},{78,40}}, color={0,127,255}));
  connect(Piston.Heat_port, thermalConductor_Gas_Cylinder.port_b)
    annotation (Line(points={{-12,30},{-12,22}}, color={191,0,0}));
  connect(Piston.alpha_gas_cyl, thermalConductor_Gas_Cylinder.alpha)
    annotation (Line(points={{-7.8,29.8},{-7.8,26},{-36,26},{-36,8},{-22,8}},
        color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=0.2,
      Interval=0.001,
      Tolerance=1e-05,
      __Dymola_Algorithm="Dassl"));
end ReciprocatingCompressor_R410A;
