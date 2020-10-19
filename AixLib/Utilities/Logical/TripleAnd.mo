within AixLib.Utilities.Logical;
block TripleAnd "Logical 'and': y = u1 and u2 and u3"
  extends Modelica.Blocks.Interfaces.partialBooleanSI2SO;
  Modelica.Blocks.Interfaces.BooleanInput
                                 u3 "Connector of third Boolean input signal"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput cold_input
    "Input for cooling demand profile of substation in W. Values are positive or zero."
                                                 annotation (Placement(
        transformation(extent={{-478,70},{-438,110}}),    iconTransformation(
          extent={{232,76},{192,116}})));
  Modelica.Blocks.Interfaces.RealInput cold_input1
    "Input for cooling demand profile of substation in W. Values are positive or zero."
                                                 annotation (Placement(
        transformation(extent={{-478,70},{-438,110}}),    iconTransformation(
          extent={{232,76},{192,116}})));
  Modelica.Blocks.Interfaces.RealInput cold_input2
    "Input for cooling demand profile of substation in W. Values are positive or zero."
                                                 annotation (Placement(
        transformation(extent={{-478,70},{-438,110}}),    iconTransformation(
          extent={{232,76},{192,116}})));
  Modelica.Blocks.Interfaces.RealInput cold_input3
    "Input for cooling demand profile of substation in W. Values are positive or zero."
                                                 annotation (Placement(
        transformation(extent={{-478,70},{-438,110}}),    iconTransformation(
          extent={{232,76},{192,116}})));
  Modelica.Blocks.Interfaces.RealInput cold_input4
    "Input for cooling demand profile of substation in W. Values are positive or zero."
                                                 annotation (Placement(
        transformation(extent={{-478,70},{-438,110}}),    iconTransformation(
          extent={{232,76},{192,116}})));
equation
  y = u1 and u2 and u3;
  annotation (
    defaultComponentName="and1",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={Text(
          extent={{-90,40},{90,-40}},
          textString="and")}),
    Documentation(info="<html><p>
  The output is <strong>true</strong> if all inputs are
  <strong>true</strong>, otherwise the output is
  <strong>false</strong>.
</p>
</html>"));
end TripleAnd;
