within AixLib.Utilities.Math;
block MinMax
  "MinMax element for vector input"
  extends Modelica.Blocks.Icons.Block;

  parameter Integer nu(min=0) = 0 "Number of input connections"
    annotation (Dialog(connectorSizing=true), HideResult=true);

  Modelica.Blocks.Interfaces.RealVectorInput u[nu]
    annotation (Placement(transformation(extent={{-120,70},{-80,-70}})));
  Modelica.Blocks.Interfaces.RealOutput yMax annotation (Placement(
        transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput yMin annotation (Placement(
        transformation(extent={{100,-70},{120,-50}})));
  Modelica.Blocks.Interfaces.IntegerOutput iMax "Vector indice of max value"
    annotation (Placement(transformation(extent={{100,84},{120,104}})));
  Modelica.Blocks.Interfaces.IntegerOutput iMin "Vector indice of min value"
    annotation (Placement(transformation(extent={{100,-104},{120,-84}})));


equation

  if nu > 0 then
    yMax =  u[1];
    iMax =  1;
    for i in 2:size(u, 1) loop
      if u[i] > yMax then
        yMax =  u[i];
        iMax =  i;
      else
        yMax = yMax;
        iMax = iMax;
      end if;

    end for;


    yMin =  u[1];
    iMin =  1;
    for i in 2:size(u, 1) loop
      if u[i] < yMin then
        yMin =  u[i];
        iMin =  i;
      else
        yMin = yMin;
        iMin = iMin;
      end if;
    end for;


  else
    yMax = max(u);
    yMin = min(u);
    iMax = 1;
    iMin = 1;
  end if;


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
          min")}),
          __Dymola_LockedEditing="Locked");
end MinMax;
