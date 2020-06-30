within AixLib.Fluid.BoilerCHP.BaseClasses.Controllers;
model ControllerOnOff "On/Off controller for boiler models"

  Modelica.Blocks.Interfaces.BooleanInput onOffExtern
    "On/Off signal"
    annotation (Placement(
        transformation(
        extent={{-12,-12},{12,12}},
        rotation=0,
        origin={-100,0}), iconTransformation(extent={{-112,-38},{-88,-14}})));
  Modelica.Blocks.Interfaces.BooleanInput THigh
    "Medium temperature is too high" annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=90,
        origin={46,-100})));
  Modelica.Blocks.Interfaces.BooleanInput TLow
    "Medium temperature is too low"
    annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=90,
        origin={-78,-100})));
  Modelica.Blocks.Interfaces.BooleanOutput onOffFinal
    "Output signal"
    annotation (Placement(
        transformation(
        extent={{-11,-10},{11,10}},
        rotation=0,
        origin={99,0}), iconTransformation(extent={{93,-34},{115,-14}})));
  Modelica.Blocks.Logical.And onOff
    annotation (Placement(transformation(extent={{-12,-8},{4,8}})));

equation
  connect(onOffExtern,onOff. u1)
                               annotation (Line(
      points={{-100,0},{-13.6,0}},
      color={255,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(onOff.y,onOffFinal)
                             annotation (Line(
      points={{4.8,0},{99,0}},
      color={255,0,255},
      thickness=0.5,
      smooth=Smooth.None));
algorithm
  if TLow then
    onOff.u2 :=true;
  elseif THigh then
    onOff.u2 :=false;
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
          textString="Controller")}),
    Documentation(revisions="<html><ul>
  <li>
    <i>December 08, 2016&#160;</i> by Moritz Lauster:<br/>
    Adapted to AixLib conventions
  </li>
  <li>
    <i>October 7, 2013&#160;</i> by Ole Odendahl:<br/>
    Formatted documentation appropriately
  </li>
  <li>
    <i>Mai 23, 2011&#160;</i>by Ana Constantin:<br/>
    Adapted from a model of Kristian Huchtemann.
  </li>
</ul>
</html>",
info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Switches the boiler off if the flow temperature is too high.
</p>
</html>"),
    experiment);
end ControllerOnOff;
