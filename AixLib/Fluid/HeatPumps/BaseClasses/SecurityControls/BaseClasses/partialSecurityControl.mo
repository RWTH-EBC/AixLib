within AixLib.Fluid.HeatPumps.BaseClasses.SecurityControls.BaseClasses;
partial block partialSecurityControl "base Block"
  Modelica.Blocks.Interfaces.RealInput nSet
    "Set value relative speed of compressor. Analog from 0 to 1"
    annotation (Placement(transformation(extent={{-150,22},{-120,52}})));
  Modelica.Blocks.Interfaces.RealOutput nOut
    "Relative speed of compressor. From 0 to 1"
    annotation (Placement(transformation(extent={{120,-10},{140,10}})));
  Modelica.Blocks.Logical.Switch SwiErr
    "If an error occurs, the value of the conZero block will be used(0)"
    annotation (Placement(transformation(extent={{86,-10},{106,10}})));
  Modelica.Blocks.Sources.Constant conZer(k=0)
    "If an error occurs, the compressor speed is set to zero"
    annotation (Placement(transformation(extent={{58,-24},{70,-12}})));
  Controls.Interfaces.HeatPumpControlBus heatPumpControlBus
    annotation (Placement(transformation(extent={{-154,-42},{-120,-12}})));
equation
  connect(conZer.y, SwiErr.u3) annotation (Line(points={{70.6,-18},{78,-18},
          {78,-8},{84,-8}}, color={0,0,127}));
  connect(SwiErr.y, nOut)
    annotation (Line(points={{107,0},{130,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{
            -120,-100},{120,100}}), graphics={
        Polygon(
          points={{-42,20},{0,62},{-42,20}},
          lineColor={28,108,200},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-48,-26},{48,66}},
          lineColor={0,0,0},
          fillColor={91,91,91},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-36,-14},{36,54}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,20},{60,-80}},
          lineColor={0,0,0},
          fillColor={91,91,91},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-10,-30},{10,-70}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-14,-40},{16,-12}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
                                     Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-120,-100},{120,100}})));
end partialSecurityControl;
