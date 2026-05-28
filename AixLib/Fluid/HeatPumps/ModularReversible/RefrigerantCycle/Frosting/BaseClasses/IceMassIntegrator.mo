within AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.Frosting.BaseClasses;
model IceMassIntegrator "Integrate the ice mass"
  parameter Modelica.Units.SI.Mass mIce_max "Maximal ice mass";
  parameter Boolean use_reset = false "= true, if reset port enabled";

  Modelica.Blocks.Interfaces.RealInput mIceGro(unit="kg/s") "Ice growth rate"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput mIce(
    final start=0, final min=0, final max=mIce_max, unit="kg", fixed=true)
    "Ice mass"
    annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Interfaces.BooleanInput reset if use_reset
    "Optional connector of reset signal" annotation(Placement(
    transformation(
      extent={{-20,-20},{20,20}},
      rotation=90,
      origin={0,-120})));
protected
  Modelica.Blocks.Interfaces.BooleanOutput local_reset annotation(HideResult=true);
  Modelica.Units.SI.MassFlowRate mIceGro_internal
    "Internal growth rate to keep mass in limits";
equation

  if use_reset then
    connect(reset, local_reset);
    when local_reset then
      reinit(mIce, 0);
    end when;
  else
    local_reset = false;
  end if;
  der(mIce)=mIceGro_internal;
  if mIce > mIce_max then
    // Already fully frozen, can only melt
    mIceGro_internal = min(0, mIceGro);
  elseif mIce < 0 then
    // No ice, can only grow
    mIceGro_internal = max(0, mIceGro);
  else
    mIceGro_internal = mIceGro;
  end if;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
                                        Text(
        extent={{-150,138},{150,98}},
        textString="%name",
        textColor={0,0,255})}),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Helper model to integrate the ice mass and reset its value depending on the boolean input.</p>
</html>", revisions="<html>
<ul>
  <li>
    <i>December 22, 2025</i> by Fabian Roemer:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/1520\">AixLib #1623</a>)
  </li>
</ul>
</html>"));
end IceMassIntegrator;
