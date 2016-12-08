within AixLib.Fluid.BoilerCHP.BaseClasses.Controllers;
model ControllerOnOff

  Modelica.Blocks.Interfaces.BooleanInput OnOffExtern annotation (Placement(
        transformation(
        extent={{-12,-12},{12,12}},
        rotation=0,
        origin={-100,0}), iconTransformation(extent={{-112,-38},{-88,-14}})));
  Modelica.Blocks.Interfaces.BooleanInput T_high
      "Medium temperature is too high" annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=90,
        origin={46,-100})));
  Modelica.Blocks.Interfaces.BooleanInput T_low "Medium temperature is too low"
    annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=90,
        origin={-78,-100})));
  Modelica.Blocks.Interfaces.BooleanOutput OnOffFinal "Output signal" annotation (Placement(
        transformation(
        extent={{-11,-10},{11,10}},
        rotation=0,
        origin={99,0}), iconTransformation(extent={{93,-34},{115,-14}})));
  Modelica.Blocks.Logical.And OnOff
    annotation (Placement(transformation(extent={{-12,-8},{4,8}})));

equation
  connect(OnOffExtern, OnOff.u1)
                               annotation (Line(
      points={{-100,0},{-13.6,0}},
      color={255,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(OnOff.y, OnOffFinal)
                             annotation (Line(
      points={{4.8,0},{99,0}},
      color={255,0,255},
      thickness=0.5,
      smooth=Smooth.None));
algorithm
  if T_low then
    OnOff.u2 :=true;
  elseif T_high then
    OnOff.u2 :=false;
  end if;

  annotation (Icon(graphics={Rectangle(
          extent={{-88,22},{92,-90}},
          lineColor={175,175,175},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid), Text(
          extent={{-82,-12},{88,-52}},
          lineColor={175,175,175},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="Controller")}),       Diagram(graphics),
    Documentation(revisions="<html>
<ul>
  <li><i>October 7, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
<li><i>Mai 23, 2011&nbsp;</i>
         by Ana Constantin:<br>
         Adapted from a model of Kristian Huchtemann.</li>
</ul>
</html>",
info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Swicthes the boiler off if the flow temperature is too high.</p>
</html>"),
    experiment);
end ControllerOnOff;
