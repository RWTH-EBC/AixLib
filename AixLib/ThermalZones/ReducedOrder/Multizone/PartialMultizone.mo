within AixLib.ThermalZones.ReducedOrder.Multizone;
partial model PartialMultizone "Partial class for multizone models"
  parameter AixLib.DataBase.Buildings.BuildingBaseRecord buildingParam
    "Choose setup for the building" annotation (choicesAllMatching = false);
protected
  parameter AixLib.DataBase.Buildings.ZoneBaseRecord zoneParam[:]=buildingParam.zoneSetup
    "Choose setup for zones" annotation (choicesAllMatching=false);
  parameter Integer orientations[:]=zoneParam.n "Number cardinal directions";
public
  replaceable AixLib.Building.LowOrder.ThermalZone.ThermalZoneEquipped zone[buildingParam.numZones] constrainedby
    AixLib.Building.LowOrder.ThermalZone.PartialThermalZone(zoneParam=zoneParam)
    "Choose thermal zone model" annotation (Placement(transformation(extent={{40,35},
            {80,75}})),choicesAllMatching=true);
  AixLib.Utilities.Interfaces.SolarRad_in radIn[max(orientations)]
    "Solar radiation" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,92}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-62,90})));
  Modelica.Blocks.Interfaces.RealInput internalGains[3*buildingParam.numZones]
    "Input profiles for internal gains persons, machines, light"
    annotation (Placement(transformation(extent={{20,-20},{-20,20}},
        rotation=-90,
        origin={76,-100}),
        iconTransformation(extent={{-7,-7},{7,7}},
        rotation=180,
        origin={93,65})));
  Modelica.Blocks.Interfaces.RealInput weather[4]
    "Weather Input Vector [1]: Air Temperature [2]: Water mass fraction [3]: Sky Radiation [4]: Terrestrial Radiation"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-56,100}), iconTransformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={-16,94})));

equation
  for i in 1:buildingParam.numZones loop
    connect(internalGains[(i*3)-2], zone[i].internalGains[1]) annotation (Line(
      points={{76,-100},{76,41.4}},
      color={0,0,127},
      smooth=Smooth.None));
    connect(internalGains[(i*3)-1], zone[i].internalGains[2]) annotation (Line(
      points={{76,-100},{76,43}},
      color={0,0,127},
      smooth=Smooth.None));
    connect(internalGains[(i*3)], zone[i].internalGains[3]) annotation (Line(
      points={{76,-100},{76,44.6}},
      color={0,0,127},
      smooth=Smooth.None));
    //Connect Outside Temperature
    connect(weather[1], zone[i].weather[1]) annotation (Line(
          points={{-56,115},{-56,68},{40,68},{40,53.4},{45.2,53.4}},
          color={0,0,127},
          smooth=Smooth.None));
    for j in 3:4 loop
      //Connect Radiation Vectors. Index has shifted because the absolute humidity has been added at vector position 2.
      connect(weather[j], zone[i].weather[j - 1]) annotation (Line(
            points={{-56,100},{-56,68},{40,68},{40,55},{45.2,55}},
            color={0,0,127},
            smooth=Smooth.None));
    end for;
    for k in 1:orientations[i] loop
      //Connect the radiation Input according to the required orientations for the individual zone
      connect(radIn[k], zone[i].solarRad_in[k]) annotation (Line(
            points={{-20,92},{-20,72},{40,72},{40,64.2},{44,64.2}},
            color={255,128,0},
            smooth=Smooth.None));
    end for;
  end for;

  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),
            graphics={
        Rectangle(
          extent={{34,78},{86,-70}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={213,255,170}),
        Rectangle(
          extent={{32,78},{-66,32}},
          lineColor={0,0,255},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-52,78},{-24,68}},
          lineColor={0,0,255},
          fillColor={212,221,253},
          fillPattern=FillPattern.Solid,
          textString="Weather"),
        Text(
          extent={{38,-50},{66,-64}},
          lineColor={0,0,255},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid,
          textString="Building")}),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
         graphics={                                                       Text(
          extent={{-80,-150},{100,-110}},
          lineColor={0,0,255},
          textString="%name%"),
        Rectangle(
          extent={{-60,-80},{60,40}},
          lineColor={95,95,95},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-80,40},{0,80},{80,40},{-80,40}},
          lineColor={95,95,95},
          smooth=Smooth.None,
          fillColor={217,72,72},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-38,20},{-8,-16}},
          lineColor={95,95,95},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{10,20},{40,-16}},
          lineColor={95,95,95},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-12,-44},{12,-80}},
          lineColor={95,95,95},
          fillColor={154,77,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-42,20},{-4,24}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{6,20},{44,24}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid)}),
    Documentation(revisions="<html>
<ul>
<li><i>June 22, 2015&nbsp;</i> by Moritz Lauster:<br/>Changed building physics to AixLib</li>
<li><i>April 25, 2014&nbsp;</i> by Ole Odendahl:<br/>Implemented</li>
</ul>
</html>", info="<html>
<p>This is a partial model for multi-zone models. It defines connectors and a replaceable thermal zone model.</p>
</html>"));
end PartialMultizone;
