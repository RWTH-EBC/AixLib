within AixLib.Fluid.DistrictHeatingCooling.Pipes;
model PipeStatic "Static pipe implementation"
  extends BaseClasses.PartialPipe;
  IBPSA.Experimental.Pipe.PipeCoreStatic pipeCoreStatic(
    redeclare package Medium = Medium,
    diameter=diameter,
    length=length,
    m_flow_nominal=m_flow_nominal,
    roughness=roughness,
    thicknessIns=thicknessIns,
    lambdaI=lambdaIns,
    res(fac=2))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T(
        displayUnit="K") = T_ground)
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
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
Jun 21, 2017, by Marcus Fuchs:<br/>
First implementation for <a href=\"https://github.com/RWTH-EBC/AixLib/issues/403\">issue 403</a>).
</li>
</ul>
</html>", info="<html>
<p>A wrapper around the static pipe model proposed in 
<a href=\"https://github.com/bramvdh91/modelica-ibpsa/issues/76\">issue 76 of the IBPSA pipe model developement</a></<p>
<p>Note that this pipe currently uses a factor of 2 on the nominal pressure loss to account for bends etc.</p>
<p>Currently, this pipe requires loading the fork of the Modelica IBPSA library from https://github.com/bramvdh91/modelica-ibpsa
and using branch <code>pipe_issue76_static</code>.</p>
</html>"));
end PipeStatic;
