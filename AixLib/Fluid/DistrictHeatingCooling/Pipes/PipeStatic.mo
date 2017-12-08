within AixLib.Fluid.DistrictHeatingCooling.Pipes;
model PipeStatic "Static pipe implementation"
  extends BaseClasses.PartialPipe;
  BaseClassesStatic.StaticCore           pipeCoreStatic(
    redeclare package Medium = Medium,
    length=length,
    m_flow_nominal=m_flow_nominal,
    roughness=roughness,
    R=1/(lambdaIns*2*Modelica.Constants.pi/
      Modelica.Math.log((diameter/2 + thicknessIns)/(diameter/2))),
    C=rho_default*Modelica.Constants.pi*(
      diameter/2)^2*cp_default,
    v_nominal=0.5,
    thickness=0.0032,
    fac=2,
    dh=diameter)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T(
        displayUnit="K") = T_ground)
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));

protected
  parameter Medium.ThermodynamicState sta_default=Medium.setState_pTX(
      T=Medium.T_default,
      p=Medium.p_default,
      X=Medium.X_default) "Default medium state";

  parameter Modelica.SIunits.Density rho_default=Medium.density_pTX(
      p=Medium.p_default,
      T=Medium.T_default,
      X=Medium.X_default)
    "Default density (e.g., rho_liquidWater = 995, rho_air = 1.2)"
    annotation (Dialog(group="Advanced", enable=use_rho_nominal));

  parameter Modelica.SIunits.SpecificHeatCapacity cp_default=
      Medium.specificHeatCapacityCp(state=sta_default)
    "Heat capacity of medium";

equation
  connect(port_a, pipeCoreStatic.port_a)
    annotation (Line(points={{-100,0},{-10,0}}, color={0,127,255}));
  connect(pipeCoreStatic.port_b, port_b)
    annotation (Line(points={{10,0},{100,0}}, color={0,127,255}));
  connect(fixedTemperature.port, pipeCoreStatic.heatPort)
    annotation (Line(points={{-20,50},{0,50},{0,10}}, color={191,0,0}));
  annotation (Icon(graphics={Rectangle(
          extent={{-100,40},{100,-40}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{40,80},{78,22},{60,22},{60,-26},{22,-26},{22,22},{4,22},{40,
              80}},
          lineColor={0,0,0},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid)}), Documentation(revisions="<html>
<ul>
<li>
Dec 8, 2017, by Marcus Fuchs:<br/>
Restore this model to work for supporting legacy tests.
</li>
<li>
Jun 21, 2017, by Marcus Fuchs:<br/>
First implementation for <a href=\"https://github.com/RWTH-EBC/AixLib/issues/403\">issue 403</a>).
</li>
</ul>
</html>", info="<html>
<p>A wrapper around the static pipe model originally proposed in 
<a href=\"https://github.com/bramvdh91/modelica-ibpsa/issues/76\">issue 76 of the IBPSA pipe model developement</a></<p>
<p>Note that this pipe uses a factor of 2 on the nominal pressure loss to account for bends etc.</p>
<p>This pipe is not meant for further development, but we had to include it in order to support some legacy tests.</p>
</html>"));
end PipeStatic;
