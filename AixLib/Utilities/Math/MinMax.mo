within AixLib.Utilities.Math;
block MinMax
  "MinMax element for vector input"
  extends Modelica.Blocks.Icons.Block;

  parameter Integer nu(min=1)=1 "Number of input connections";

  Modelica.Blocks.Interfaces.RealInput u[nu]
    annotation (Placement(transformation(extent={{-140,20},{-100,-20}}),
        iconTransformation(extent={{-140,20},{-100,-20}})));
  Modelica.Blocks.Interfaces.RealOutput yMax annotation (Placement(
        transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput yMin annotation (Placement(
        transformation(extent={{100,-70},{120,-50}})));
  Modelica.Blocks.Interfaces.IntegerOutput iMax "Vector indice of max value"
    annotation (Placement(transformation(extent={{100,84},{120,104}})));
  Modelica.Blocks.Interfaces.IntegerOutput iMin "Vector indice of min value"
    annotation (Placement(transformation(extent={{100,-104},{120,-84}})));


algorithm

  yMax := u[1];
  iMax := 1;
  yMin := u[1];
  iMin := 1;
  for i in 2:nu loop
    if u[i] > yMax then
      yMax := u[i];
      iMax := i;
    end if;
    if u[i] < yMin then
      yMin := u[i];
      iMin := i;
    end if;
  end for;


annotation (defaultComponentName="max",
Documentation(info="<html>
<p>
Outputs the minimum and maximum of a vector input including the
respective vetcor indices of the min/max value.
</p>
</html>",
revisions="<html>
<ul>

  <li>January, 2026 by Jonatan Höpp:<br/>
    First implementation
  </li>
</ul>
</html>"), Icon(graphics={Text(
          extent={{-74,90},{70,-70}},
          textColor={0,0,255},
          textString="max
          min")}));
end MinMax;
