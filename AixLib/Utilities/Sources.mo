within AixLib.Utilities;
package Sources "Sources"
    extends Modelica.Icons.Package;

   model PrescribedSolarRad "variable radiation condition"
     parameter Integer n=1 "number of output vector length";
     AixLib.Utilities.Interfaces.SolarRad_out solarRad_out[n] annotation (Placement(
           transformation(extent={{80,-10},{100,10}}, rotation=0)));
     Modelica.Blocks.Interfaces.RealInput u[n] "radiation on surface (W/m2)"
       annotation (Placement(transformation(extent={{-120,-20},{-80,20}},
            rotation=0)));

     parameter Modelica.SIunits.RadiantEnergyFluenceRate I[n] = fill(0,n)
      "fixed radiation if u is not connected"  annotation (Diagram(graphics));

   equation
     if cardinality(u) < 1 then
         u[:] = fill(0,n);
         solarRad_out[:].I = I[:];
     else
         solarRad_out[:].I = u[:] "Radiant energy fluence rate";
     end if;
     annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={
          Line(
            points={{0,80},{0,-80}},
            color={255,170,85},
            pattern=LinePattern.Dot,
            thickness=0.5),
          Line(
            points={{80,0},{-80,0}},
            color={255,170,85},
            pattern=LinePattern.Dot,
            thickness=0.5),
          Line(
            points={{-68,42},{68,-42}},
            color={255,170,85},
            pattern=LinePattern.Dot,
            thickness=0.5),
          Line(
            points={{-38,70},{38,-70}},
            color={255,170,85},
            pattern=LinePattern.Dot,
            thickness=0.5),
          Line(
            points={{-68,-42},{68,42}},
            color={255,170,85},
            pattern=LinePattern.Dot,
            thickness=0.5),
          Line(
            points={{-40,-70},{40,70}},
            color={255,170,85},
            pattern=LinePattern.Dot,
            thickness=0.5),
          Ellipse(
            extent={{-60,60},{60,-60}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Sphere,
            fillColor={255,255,0})}),     Documentation(revisions="<html>
<ul>
<li><i>April 01, 2014 </i> by Moritz Lauster:<br>Renamed</li>
<li><i>April 11, 2013&nbsp;</i> by Ole Odendahl:<br>Formatted documentation appropriately </li>
<li><i>October 23, 2006&nbsp;</i> by Peter Matthes:<br>Implemented.</li>
</ul>
</html>",
       info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>The VarRad Model is a source model to represent a varying radiation source.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Assumption</span></h4>
<p>If nothing is specified through the input port solar radiation of 0 W/m2 is assumed by default. </p>
</html>"),
       Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
               100}}), graphics));
   end PrescribedSolarRad;

  model HourOfDay "Computes the hour of day taking the second of year as input"

    Modelica.Blocks.Sources.Clock clock(offset=-startTime)
      annotation (Placement(transformation(extent={{-20,20},{0,40}}, rotation=0)));

    Modelica.Blocks.Interfaces.RealOutput SOY "second of the year"
      annotation (Placement(transformation(extent={{90,70},{110,90}}, rotation=
              0)));
    Modelica.Blocks.Interfaces.RealOutput H "passed hours"
      annotation (Placement(transformation(extent={{90,10},{110,30}}, rotation=
              0)));

    Modelica.Blocks.Interfaces.RealOutput D "passed days"
      annotation (Placement(transformation(extent={{90,-50},{110,-30}},
            rotation=0)));
    Modelica.Blocks.Interfaces.RealOutput SOD "second of the day"
      annotation (Placement(transformation(
          origin={40,-100},
          extent={{-10,-10},{10,10}},
          rotation=270)));

    Modelica.Blocks.Interfaces.RealOutput HOD "hour of the day"
      annotation (Placement(transformation(
          origin={-20,-100},
          extent={{-10,-10},{10,10}},
          rotation=270)));
    parameter Real startTime = 0
      "The start time of the simulation in reference to 1st of Jan. 0:00 o'clock";
  equation
    // Modulo(SOY,SecondsInDay) gives the passed seconds of the current day.
    SOD=mod(SOY,86400) "passed seconds of the current day";

    H=SOY/3600 "passed hours";
    D=SOY/86400 "passed days";

    // computes the hour of day from second of day.
    HOD=SOD/3600;

    connect(clock.y, SOY) annotation (Line(points={{1,30},{20,30},{20,80},{100,
            80}}, color={0,0,127}));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
              -100,-100},{100,100}}),
                        graphics),
                         Icon(coordinateSystem(preserveAspectRatio=false,
            extent={{-100,-100},{100,100}}), graphics={
          Text(
            extent={{34,96},{88,62}},
            lineColor={0,0,255},
            textString="SoY"),
          Text(
            extent={{-6,-62},{100,-90}},
            lineColor={0,0,255},
            textString="SoD"),
          Text(
            extent={{-92,-62},{28,-92}},
            lineColor={0,0,255},
            textString="HoD"),
          Line(points={{-38,70},{-28,51}}, color={160,160,164}),
          Line(points={{-71,37},{-54,28}}, color={160,160,164}),
          Line(points={{-80,0},{-60,0}}, color={160,160,164}),
          Line(points={{-71,-37},{-50,-26}}, color={160,160,164}),
          Line(points={{-39,-70},{-29,-52}}, color={160,160,164}),
          Line(points={{0,-80},{0,-60}}, color={160,160,164}),
          Line(points={{39,-70},{29,-51}}, color={160,160,164}),
          Line(points={{71,-37},{52,-27}}, color={160,160,164}),
          Line(points={{80,0},{60,0}}, color={160,160,164}),
          Line(points={{70,38},{49,26}}, color={160,160,164}),
          Line(points={{37,70},{26,50}}, color={160,160,164}),
          Line(points={{0,80},{0,60}}, color={160,160,164}),
          Ellipse(extent={{-80,80},{80,-80}}, lineColor={160,160,164}),
          Line(
            points={{0,0},{-50,50}},
            color={0,0,0},
            thickness=0.5),
          Line(
            points={{0,0},{40,0}},
            color={0,0,0},
            thickness=0.5)}),
      Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>
Additional to passed simulation seconds (SOY), hours (HOY) and days (DOY) this model provides the passed seconds of a day and the passed hours of a day. That can be used for a controller that will act depending on the time of the day for example.
</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<p><h4><font color=\"#008000\">Example Results</font></h4></p>
<p><a href=\"AixLib.Utilities.Examples.TimeUtilities_test\">AixLib.Utilities.Examples.TimeUtilities_test</a> </p>
</html>", revisions="<html>
<ul>
  <li><i>April 11, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
  <li>
         by Peter Matthes:<br>
         Implemented.</li>
</ul>
</html>"));
  end HourOfDay;

  model NightMode
    "Module to establish if an element should opperate in night mode or not."
    import BaseLib = AixLib.Utilities;

    //Parameters
    parameter Real dayStart "hour when day operation starts";
    parameter Real dayEnd "hour when night operation starts";
    parameter Real startTime = 0
      "The start time of the simulation in reference to 1st of Jan. 0:00 o'clock";

    BaseLib.Sources.HourOfDay hourOfDay
      annotation (Placement(transformation(extent={{-72,10},{-52,30}})));
    Modelica.Blocks.Logical.GreaterEqualThreshold greaterThreshold(
                                                              threshold=dayStart)
      annotation (Placement(transformation(extent={{-11.5,7.5},{3,22.5}})));
    Modelica.Blocks.Logical.LessThreshold lessEqualThreshold(     threshold=
          dayEnd)
      annotation (Placement(transformation(extent={{-12,-19.5},{3,-4.5}})));
    Modelica.Blocks.Logical.Nand IsNight
      annotation (Placement(transformation(extent={{18,-4.5},{33,10.5}})));
    Modelica.Blocks.Interfaces.BooleanOutput SwitchToNightMode
      "Connector of Boolean output signal"
      annotation (Placement(transformation(extent={{78.5,-7},{98.5,13}}),
          iconTransformation(extent={{78.5,-7},{98.5,13}})));
  equation

    connect(hourOfDay.HOD,lessEqualThreshold. u) annotation (Line(
        points={{-64,10},{-64,1.5},{-21,1.5},{-21,-12},{-13.5,-12}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(hourOfDay.HOD,greaterThreshold. u) annotation (Line(
        points={{-64,10},{-64,1.5},{-21,1.5},{-21,15},{-12.95,15}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(lessEqualThreshold.y, IsNight.u2) annotation (Line(
        points={{3.75,-12},{9,-12},{9,-3},{16.5,-3}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(greaterThreshold.y, IsNight.u1) annotation (Line(
        points={{3.725,15},{9,15},{9,3},{16.5,3}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(IsNight.y, SwitchToNightMode) annotation (Line(
        points={{33.75,3},{88.5,3}},
        color={255,0,255},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1.5,1.5}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1.5,1.5}), graphics={
          Ellipse(extent={{-70.5,73.5},{78,-76.5}}, lineColor={0,0,255}),
          Line(
            points={{3,73.5},{3,57},{3,58.5}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{3,-60},{3,-76.5},{3,-75}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{-54,0},{-70.5,0},{-70.5,1.5}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{78,0},{61.5,0},{61.5,1.5}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{-51,49.5},{-42,37.5},{-51,49.5}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{46.5,-42},{55.5,-54},{46.5,-42}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{-39,-40.5},{-51,-52.5},{-39,-40.5}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{60,48},{48,36},{60,48}},
            color={0,0,255},
            smooth=Smooth.None),
          Ellipse(
            extent={{-70.5,73.5},{78,-76.5}},
            lineColor={0,255,255},
            lineThickness=1,
            fillColor={0,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-40.5,18},{-15,-9}},
            lineColor={255,255,0},
            fillColor={255,255,0},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-27,18},{-27,30},{-28.5,-18},{-27,4.5},{-49.5,4.5},
                {-4.5,4.5},{-30,4.5},{-12,21},{-45,-12},{-27,6},{-43.5,
                21},{-12,-10.5},{-28.5,6}},
            color={255,255,0},
            smooth=Smooth.None,
            thickness=0.5),
          Polygon(
            points={{4.5,73.5},{4.5,-78},{19.5,-75},{31.5,-72},{43.5,
                -66},{54,-58.5},{63,-49.5},{72,-34.5},{78,-21},{79.5,
                -4.5},{79.5,13.5},{72,31.5},{64.5,45},{49.5,60},{24,72},
                {22.5,72},{4.5,73.5}},
            lineColor={0,0,255},
            lineThickness=0.5,
            smooth=Smooth.None,
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{16.5,22.5},{49.5,-12}},
            lineColor={255,255,0},
            fillColor={255,255,0},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{28.5,22.5},{63,-10.5}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineThickness=1)}),
      Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>
Model for the switching between night and day operation modes based on the simulation time.
</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<p><h4><font color=\"#008000\">Example Results</font></h4></p>
<p><a href=\"AixLib.Utilities.Examples.TimeUtilities_test\">AixLib.Utilities.Examples.TimeUtilities_test</a> </p>
</html>",
  revisions="<html>
<p><ul>
<li><i>April 11, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
<li><i>Mai 20, 2011</i> by Ana Constantin:<br/>Implemented</li>
</ul></p>
</html>"));
  end NightMode;

  package HeaterCooler
    "Collection of heater and cooler models to supply the thermal energy to the building"
    extends Modelica.Icons.Package;

    partial model IdealHeaterCoolerBase

      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatCoolRoom
        annotation (Placement(transformation(extent={{80,-10},{100,10}})));
      annotation (Diagram(graphics), Icon(graphics={
            Rectangle(
              extent={{-94,6},{80,-28}},
              lineColor={135,135,135},
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-82,6},{-82,40},{-48,6},{-82,6}},
              lineColor={135,135,135},
              lineThickness=1,
              smooth=Smooth.None,
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-46,6},{-8,6},{-8,40},{-46,6}},
              lineColor={135,135,135},
              lineThickness=1,
              smooth=Smooth.None,
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{30,6},{-8,6},{-8,40},{30,6}},
              lineColor={135,135,135},
              lineThickness=1,
              smooth=Smooth.None,
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{64,6},{64,40},{30,6},{64,6}},
              lineColor={135,135,135},
              lineThickness=1,
              smooth=Smooth.None,
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{64,-18},{-80,-4}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid,
              textString="T_set_room<->T_air_room"),
            Line(
              points={{-62,24},{-62,50}},
              color={0,128,255},
              thickness=1,
              smooth=Smooth.None),
            Line(
              points={{-46,10},{-46,50}},
              color={0,128,255},
              thickness=1,
              smooth=Smooth.None),
            Line(
              points={{-30,24},{-30,50}},
              color={0,128,255},
              thickness=1,
              smooth=Smooth.None),
            Line(
              points={{-66,48},{-62,54},{-58,48}},
              color={0,128,255},
              thickness=1,
              smooth=Smooth.None),
            Line(
              points={{-50,48},{-46,54},{-42,48}},
              color={0,128,255},
              thickness=1,
              smooth=Smooth.None),
            Line(
              points={{-34,48},{-30,54},{-26,48}},
              color={0,128,255},
              thickness=1,
              smooth=Smooth.None),
            Line(
              points={{16,24},{16,50}},
              color={255,0,0},
              thickness=1,
              smooth=Smooth.None),
            Line(
              points={{12,48},{16,54},{20,48}},
              color={255,0,0},
              thickness=1,
              smooth=Smooth.None),
            Line(
              points={{44,24},{44,50}},
              color={255,0,0},
              thickness=1,
              smooth=Smooth.None),
            Line(
              points={{40,48},{44,54},{48,48}},
              color={255,0,0},
              thickness=1,
              smooth=Smooth.None),
            Line(
              points={{30,10},{30,50}},
              color={255,0,0},
              thickness=1,
              smooth=Smooth.None),
            Line(
              points={{26,48},{30,54},{34,48}},
              color={255,0,0},
              thickness=1,
              smooth=Smooth.None)}),
        Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>This is the base class of an ideal heater and/or cooler. It is used in full ideal heater/cooler models as an extension.</p>
</html>", revisions="<html>
<p><ul>
<li><i>June, 2014&nbsp;</i> by Moritz Lauster:<br/>Added some basic documentation</li>
</ul></p>
</html>"));
    end IdealHeaterCoolerBase;

    partial model IdealHeaterCoolerBase_seperate_parameters
        extends AixLib.Utilities.Sources.HeaterCooler.IdealHeaterCoolerBase;
      Sensors.TEnergyMeter coolMeter if Cooler_on "measures cooling energy"
        annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Cooling if
                                  Cooler_on
        annotation (Placement(transformation(extent={{6,-23},{26,-2}})));
      Control.PITemp pITemp2(
        RangeSwitch=false,
        h=h_cooler,
        l=l_cooler,
        KR=KR_cooler,
        TN=TN_cooler) if Cooler_on
        annotation (Placement(transformation(extent={{-20,-10},{0,-30}})));
      Sensors.TEnergyMeter heatMeter if               Heater_on
        "measures heating energy"
        annotation (Placement(transformation(extent={{40,30},{60,50}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Heating if
                                  Heater_on
        annotation (Placement(transformation(extent={{6,22},{26,2}})));
      Control.PITemp pITemp1(
        RangeSwitch=false,
        h=h_heater,
        l=l_heater,
        KR=KR_heater,
        TN=TN_heater) if Heater_on
        annotation (Placement(transformation(extent={{-20,10},{0,30}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatCoolRoom
        annotation (Placement(transformation(extent={{80,-10},{100,10}})));
      parameter Modelica.SIunits.Temp_K T0all=295.15
        "Initial temperature for all components";
      parameter Modelica.SIunits.HeatFlowRate Q_flow_heat=1
        "Heat flow rate of the heater"
        annotation(Dialog(tab="Heater"));
      parameter Real weightfactor_heater=1 "weightfactor of the heater"
        annotation(Dialog(tab="Heater"));
      parameter Modelica.SIunits.HeatFlowRate Q_flow_cooler=1
        "Heat flow rate of the cooler"
        annotation(Dialog(tab="Cooler"));
      parameter Real weightfactor_cooler=1 "weightfactor of the cooler"
        annotation(Dialog(tab="Cooler"));
      parameter Real h_heater=100000
        "upper limit controller output of the heater"
        annotation(Dialog(tab="Heater",group = "Controller"));
      parameter Real l_heater=0 "lower limit controller output of the heater"
        annotation(Dialog(tab="Heater",group = "Controller"));
      parameter Real KR_heater=10000 "Gain of the heating controller"
        annotation(Dialog(tab="Heater",group = "Controller"));
      parameter Modelica.SIunits.Time TN_heater=1
        "Time constant of the heating controller"
        annotation(Dialog(tab="Heater",group = "Controller"));
      parameter Real h_cooler=0 "upper limit controller output of the cooler"
        annotation(Dialog(tab="Cooler",group = "Controller"));
      parameter Real l_cooler=-100000
        "lower limit controller output of the cooler"
        annotation(Dialog(tab="Cooler",group = "Controller"));
      parameter Real KR_cooler=10000 "Gain of the cooling controller"
        annotation(Dialog(tab="Cooler",group = "Controller"));
      parameter Modelica.SIunits.Time TN_cooler=1
        "Time constant of the cooling controller"
        annotation(Dialog(tab="Cooler",group = "Controller"));
      parameter Boolean Heater_on=true "Activates the heater"
        annotation(Dialog(tab="Heater"));
      parameter Boolean Cooler_on=true "Activates the cooler"
        annotation(Dialog(tab="Cooler"));
    equation
      connect(pITemp2.y,Cooling.Q_flow)  annotation (Line(
          points={{-1,-20},{6,-20},{6,-12.5}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(Cooling.Q_flow, coolMeter.p)     annotation (Line(
          points={{6,-12.5},{6,-40},{41.4,-40}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(pITemp1.y,Heating.Q_flow)  annotation (Line(
          points={{-1,20},{2,20},{2,12},{6,12}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(Heating.Q_flow, heatMeter.p)     annotation (Line(
          points={{6,12},{6,40},{41.4,40}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(Heating.port, HeatCoolRoom) annotation (Line(
          points={{26,12},{2,12},{2,0},{90,0}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(Cooling.port, HeatCoolRoom) annotation (Line(
          points={{26,-12.5},{2.4,-12.5},{2.4,0},{90,0}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(pITemp2.Therm1, HeatCoolRoom) annotation (Line(
          points={{-16,-11},{-16,0},{90,0}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(pITemp1.Therm1, HeatCoolRoom) annotation (Line(
          points={{-16,11},{-16,0},{90,0}},
          color={191,0,0},
          smooth=Smooth.None));
      annotation (Diagram(graphics), Icon(graphics={
            Rectangle(
              extent={{-94,6},{80,-28}},
              lineColor={135,135,135},
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-82,6},{-82,40},{-48,6},{-82,6}},
              lineColor={135,135,135},
              lineThickness=1,
              smooth=Smooth.None,
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-46,6},{-8,6},{-8,40},{-46,6}},
              lineColor={135,135,135},
              lineThickness=1,
              smooth=Smooth.None,
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{30,6},{-8,6},{-8,40},{30,6}},
              lineColor={135,135,135},
              lineThickness=1,
              smooth=Smooth.None,
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{64,6},{64,40},{30,6},{64,6}},
              lineColor={135,135,135},
              lineThickness=1,
              smooth=Smooth.None,
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{64,-18},{-80,-4}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid,
              textString="T_set_room<->T_air_room"),
            Line(
              points={{-62,24},{-62,50}},
              color={0,128,255},
              thickness=1,
              smooth=Smooth.None),
            Line(
              points={{-46,10},{-46,50}},
              color={0,128,255},
              thickness=1,
              smooth=Smooth.None),
            Line(
              points={{-30,24},{-30,50}},
              color={0,128,255},
              thickness=1,
              smooth=Smooth.None),
            Line(
              points={{-66,48},{-62,54},{-58,48}},
              color={0,128,255},
              thickness=1,
              smooth=Smooth.None),
            Line(
              points={{-50,48},{-46,54},{-42,48}},
              color={0,128,255},
              thickness=1,
              smooth=Smooth.None),
            Line(
              points={{-34,48},{-30,54},{-26,48}},
              color={0,128,255},
              thickness=1,
              smooth=Smooth.None),
            Line(
              points={{16,24},{16,50}},
              color={255,0,0},
              thickness=1,
              smooth=Smooth.None),
            Line(
              points={{12,48},{16,54},{20,48}},
              color={255,0,0},
              thickness=1,
              smooth=Smooth.None),
            Line(
              points={{44,24},{44,50}},
              color={255,0,0},
              thickness=1,
              smooth=Smooth.None),
            Line(
              points={{40,48},{44,54},{48,48}},
              color={255,0,0},
              thickness=1,
              smooth=Smooth.None),
            Line(
              points={{30,10},{30,50}},
              color={255,0,0},
              thickness=1,
              smooth=Smooth.None),
            Line(
              points={{26,48},{30,54},{34,48}},
              color={255,0,0},
              thickness=1,
              smooth=Smooth.None)}),
        Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>This is the base class of an ideal heater and/or cooler. It is used in full ideal heater/cooler models as an extension. It extends another base class and adds some basic elements.</p>
</html>", revisions="<html>
<p><ul>
<li><i>June, 2014&nbsp;</i> by Moritz Lauster:<br/>Added some basic documentation</li>
</ul></p>
</html>"));
    end IdealHeaterCoolerBase_seperate_parameters;

    model IdealHeaterCoolerVar1 "heater and cooler with variable setpoints"
      extends
        AixLib.Utilities.Sources.HeaterCooler.IdealHeaterCoolerBase_seperate_parameters;
      Modelica.Blocks.Interfaces.RealInput soll_cool if Cooler_on annotation (Placement(
            transformation(extent={{-120,-60},{-80,-20}}), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={-48,-48})));
      Modelica.Blocks.Interfaces.RealInput soll_heat if Heater_on annotation (Placement(
            transformation(extent={{-120,20},{-80,60}}), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={30,-48})));
      Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=Heater_on) if Heater_on
        annotation (Placement(transformation(extent={{-52,14},{-33,30}})));
      Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=
            Cooler_on) if Cooler_on
        annotation (Placement(transformation(extent={{-52,-30},{-32,-14}})));
    equation
      connect(booleanExpression.y, pITemp1.onOff) annotation (Line(
          points={{-32.05,22},{-24,22},{-24,15},{-19,15}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(booleanExpression1.y, pITemp2.onOff) annotation (Line(
          points={{-31,-22},{-24,-22},{-24,-15},{-19,-15}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(soll_heat, pITemp1.soll) annotation (Line(
          points={{-100,40},{-18,40},{-18,29},{-18,29}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(soll_cool, pITemp2.soll) annotation (Line(
          points={{-100,-40},{-58,-40},{-58,-40},{-18,-40},{-18,-29}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (Diagram(graphics), Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>This is just as simple heater and/or cooler with a PI-controller. It can be used as an quasi-ideal source for heating and cooling applications. </p>
</html>", revisions="<html>
<p><ul>
<li><i>June, 2014&nbsp;</i> by Moritz Lauster:<br/>Added some basic documentation</li>
</ul></p>
</html>"));
    end IdealHeaterCoolerVar1;
  end HeaterCooler;
end Sources;
