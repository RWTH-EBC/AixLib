within AixLib.Fluid.Examples.ERCBuilding.Control.SupervisoryControl;
model AverageTemperatures

  parameter Integer n = 1 "Number of inputs";
  parameter Boolean top
    "='true' if only the upper part of the storage is relevant";
  parameter Boolean bottom
    "='true' if only the lower part of the storage is relevant";

  Modelica.Blocks.Interfaces.RealInput temperatures[n](                              final unit="K", min=0,
    final quantity="ThermodynamicTemperature")
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.RealOutput averageTemperature(                              final unit="K", min=0,
    final quantity="ThermodynamicTemperature")
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

algorithm
  averageTemperature := 0;

  if top then

    if mod(n, 2) > 0.01 then

      for i in integer(ceil(n/2)):integer(floor(n/2)) + integer(ceil(n/2)) loop

        averageTemperature := averageTemperature + temperatures[i];

      end for;
      averageTemperature := averageTemperature/integer(ceil(n/2));
    else

      for i in (integer(n/2) + 1):n loop

        averageTemperature := averageTemperature + temperatures[i];

      end for;
      averageTemperature := averageTemperature/n*2;
    end if;

  elseif bottom then

    if mod(n, 2) > 0.01 then

      for i in 1:integer(floor(n/2)) loop

        averageTemperature := averageTemperature + temperatures[i];

      end for;

      averageTemperature := averageTemperature/integer(floor(n/2));
    else

      for i in 1:integer(n/2) loop

        averageTemperature := averageTemperature + temperatures[i];

      end for;

      averageTemperature := averageTemperature/n*2;
    end if;

  else

    for i in 1:n loop

      averageTemperature := averageTemperature + temperatures[i];

    end for;

    averageTemperature := averageTemperature/n;

  end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={
            {-100,-100},{100,100}}), graphics={
        Text(
          extent={{-76,88},{-20,18}},
          lineColor={0,0,255},
          textString="top = "),
        Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,255}),
        Text(
          extent={{-88,40},{-26,18}},
          lineColor={0,0,255},
          textString="%top"),
        Text(
          extent={{-80,-18},{14,-46}},
          lineColor={0,0,255},
          textString="bottom ="),
        Text(
          extent={{-86,-48},{-30,-66}},
          lineColor={0,0,255},
          textString="%bottom"),
        Text(
          extent={{-84,100},{92,80}},
          lineColor={0,0,255},
          textStyle={TextStyle.Bold,TextStyle.UnderLine},
          textString="AvTemp"),
        Line(
          points={{-100,80},{100,80}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-84,0},{94,0}},
          color={0,0,255},
          smooth=Smooth.None)}), Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics));
end AverageTemperatures;
