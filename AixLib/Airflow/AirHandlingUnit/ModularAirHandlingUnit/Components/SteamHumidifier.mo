within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components;
model SteamHumidifier
  extends
    AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.BaseClasses.PartialHumidifier;

  parameter Modelica.Units.SI.Temperature TSteam=373.15
    "Temperature of steam"
    annotation (Dialog(
      tab="Advanced",
      group="Vaporization"));

  Modelica.Units.SI.SpecificEnthalpy hSteam "specific enthalpy of steam";

  Modelica.Blocks.Interfaces.RealOutput Q_flow "heat flow rate"
    annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
equation

  XAirOut = X_intern;

  //mass balances
  mAirIn_flow + mWat_flow_intern - mAirOut_flow = 0;
  mDryAirIn_flow * (1 + XAirIn) = mAirIn_flow;

  //mass balance moisture
  mDryAirIn_flow * XAirIn + mWat_flow_intern - mDryAirOut_flow * X_intern = 0;

  //heat flows
  Qb_flow = mWat_flow_intern * hSteam;
  Q_flow = Qb_flow;

  // specific enthalpies
   hSteam = cpWater * (373.15 - TWatIn) + cpSteam * (TSteam - 373.15) + r100;

   connect(max.y,X_intern);

        annotation (
    preferredView="info",
    Documentation(info="<html><p>
  This model describes an idealized steam humidifier.The enthalpy of
  the steam is considered by its temperature. All steam added to the
  air flow is binded in the air and leads to an increase of the
  absolute humidity.
</p>
<p>
  The heat flow is calculated using the specific steam enthalpy and
  mass flow rate of the steam.
</p>
</html>", revisions="<html>
<ul>
  <li>May 2019, by Ervin Lejlic:<br/>
    First implementation.
  </li>
  <li>May 2019, by Martin Kremer:<br/>
    Changed variable names for naming convention and deleting
    efficiency.
  </li>
  <li>June 2019, by Martin Kremer:<br/>
    Fixed bug in calculation of heat flow due to wrong calculation of
    steam enthalpy. Added assertion for steam temperature.
  </li>
  <li>April 2020, by Martin Kremer:<br/>
    Changed to extend from partial humidifier.
  </li>
</ul>
</html>"),                  Icon(coordinateSystem(preserveAspectRatio=false),
        graphics={
        Rectangle(
          extent={{-8,-78},{-12,68}},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{4,-50},{-8,-58},{-8,-58},{4,-64},{4,-62},{-4,-58},{-4,-58},{
              4,-52},{4,-50}},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{-24,-50},{-12,-58},{-12,-58},{-24,-64},{-24,-62},{-16,-58},{
              -16,-58},{-24,-52},{-24,-50}},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{-24,-14},{-12,-22},{-12,-22},{-24,-28},{-24,-26},{-16,-22},{
              -16,-22},{-24,-16},{-24,-14}},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{4,-14},{-8,-22},{-8,-22},{4,-28},{4,-26},{-4,-22},{-4,-22},{
              4,-16},{4,-14}},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{4,18},{-8,10},{-8,10},{4,4},{4,6},{-4,10},{-4,10},{4,16},{4,
              18}},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{-24,18},{-12,10},{-12,10},{-24,4},{-24,6},{-16,10},{-16,10},
              {-24,16},{-24,18}},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{-24,46},{-12,38},{-12,38},{-24,32},{-24,34},{-16,38},{-16,38},
              {-24,44},{-24,46}},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{-24,74},{-12,66},{-12,66},{-24,60},{-24,62},{-16,66},{-16,66},
              {-24,72},{-24,74}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{4,46},{-8,38},{-8,38},{4,32},{4,34},{-4,38},{-4,38},{4,44},{
              4,46}},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{4,74},{-8,66},{-8,66},{4,60},{4,62},{-4,66},{-4,66},{4,72},{
              4,74}},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{54,-78},{50,68}},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{66,-50},{54,-58},{54,-58},{66,-64},{66,-62},{58,-58},{58,-58},
              {66,-52},{66,-50}},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{38,-50},{50,-58},{50,-58},{38,-64},{38,-62},{46,-58},{46,-58},
              {38,-52},{38,-50}},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{38,-14},{50,-22},{50,-22},{38,-28},{38,-26},{46,-22},{46,-22},
              {38,-16},{38,-14}},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{66,-14},{54,-22},{54,-22},{66,-28},{66,-26},{58,-22},{58,-22},
              {66,-16},{66,-14}},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{66,18},{54,10},{54,10},{66,4},{66,6},{58,10},{58,10},{66,16},
              {66,18}},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{38,18},{50,10},{50,10},{38,4},{38,6},{46,10},{46,10},{38,16},
              {38,18}},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{38,46},{50,38},{50,38},{38,32},{38,34},{46,38},{46,38},{38,
              44},{38,46}},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{38,74},{50,66},{50,66},{38,60},{38,62},{46,66},{46,66},{38,
              72},{38,74}},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{66,46},{54,38},{54,38},{66,32},{66,34},{58,38},{58,38},{66,
              44},{66,46}},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{66,74},{54,66},{54,66},{66,60},{66,62},{58,66},{58,66},{66,
              72},{66,74}},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0})}),                                                Diagram(
        coordinateSystem(preserveAspectRatio=false)),
                    Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
              Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SteamHumidifier;
