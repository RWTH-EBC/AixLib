within AixLib.Building;
package Components "collection of basic components"
      extends Modelica.Icons.Package;

  package DryAir "Models concerning dry air masses"
        extends Modelica.Icons.Package;

    model Airload "Air volume"
      parameter Modelica.SIunits.Density rho=1.19 "Density of air";
      parameter Modelica.SIunits.SpecificHeatCapacity c=1007
        "Specific heat capacity of air";
      parameter Modelica.SIunits.Volume V=48.0 "Volume of the room";
      Modelica.SIunits.Temperature T(start=293.15, displayUnit="degC")
        "Temperature of airload";

      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port
        annotation (Placement(transformation(extent={{-104,-24},{-76,4}}),
            iconTransformation(extent={{-100,-30},{-80,-10}})));
    protected
      parameter Modelica.SIunits.Mass  m = rho*V;

    equation
      T = port.T;
      m * c* der(T) = port.Q_flow;

      annotation (
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics={
          Rectangle(extent={{-80,60},{80,-100}}, lineColor={0,0,0}),
          Rectangle(extent={{-80,60},{80,-100}}, lineColor={0,0,0}),
          Rectangle(
            extent={{-80,60},{80,-100}},
            lineColor={0,0,0},
            fillColor={211,243,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-28,14},{32,-52}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="Air")}),
        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics={
          Rectangle(extent={{-80,60},{80,-100}}, lineColor={0,0,0}),
          Rectangle(
            extent={{-80,60},{80,-100}},
            lineColor={0,0,0},
            fillColor={211,243,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-30,16},{30,-50}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="Air")}),
        Window(
          x=0.25,
          y=0.09,
          width=0.6,
          height=0.6),
        Documentation(revisions="<html>
<p><ul>
<li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
<li><i>May 02, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
</ul></p>
</html>",
        info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>The <b>Airload</b> model represents a heat capacity consisting of air. It is described by its volume, density and specific heat capacity. </p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<p><h4><font color=\"#008000\">Example Results</font></h4></p>
<p><a href=\"AixLib.Building.Components.Examples.DryAir.DryAir_test\">AixLib.Building.Components.Examples.DryAir.DryAir_test</a> </p>
</html>"));
    end Airload;

    model VarAirExchange "Heat flow caused by air exchange"
      extends Modelica.Thermal.HeatTransfer.Interfaces.Element1D;

      parameter Modelica.SIunits.Volume V=50 "Volume of the room";
      parameter Modelica.SIunits.SpecificHeatCapacity c=1000
        "Specific heat capacity of air";
      parameter Modelica.SIunits.Density rho=1.25 "Air density";

      Modelica.Blocks.Interfaces.RealInput InPort1
        annotation (Placement(transformation(extent={{-100,-54},{-80,-74}},
              rotation=0)));
    equation
    if cardinality( InPort1)<1 then
      InPort1=0;
    end if;
      port_a.Q_flow = InPort1*V*c*rho*(port_a.T - port_b.T)/3600;
      annotation (
        Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics={
          Rectangle(extent={{-80,60},{80,-100}}, lineColor={0,0,0}),
          Rectangle(extent={{-80,60},{80,-100}}, lineColor={0,0,0}),
          Rectangle(
            extent={{-80,60},{80,-100}},
            lineColor={0,0,0},
            fillColor={211,243,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{60,-58},{30,-72},{-22,-68},{-16,-60},{-68,-52},{-30,-80},
                {-24,-74},{46,-74},{60,-58}},
            lineColor={0,0,0},
            smooth=Smooth.Bezier,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-30,16},{30,-50}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="Air"),
          Polygon(
            points={{-58,22},{-28,36},{24,32},{18,24},{70,16},{32,44},{26,38},
                {-44,38},{-58,22}},
            lineColor={0,0,0},
            smooth=Smooth.Bezier,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid)}),
        Window(
          x=0.4,
          y=0.4,
          width=0.6,
          height=0.6),
        Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>The <b>VarAirExchange</b> model describes heat transfer by air exchange (e.g. due to opening a window). It needs the air exchange rate (in <img src=\"modelica://AixLib/Images/Equations/equation-fHlz87wz.png\" alt=\"h^(-1)\"/>) as input value. </p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica:/AixLib/Images/stars3.png\"/></p>
<p><h4><font color=\"#008000\">Example Results</font></h4></p>
<p><a href=\"AixLib.Building.Components.Examples.DryAir.DryAir_test\">AixLib.Building.Components.Examples.DryAir.DryAir_test</a> </p>
</html>",
        revisions="<html>
<p><ul>
<li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
<li><i>May 02, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
</ul></p>
</html>"),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics={
            Rectangle(extent={{-80,60},{80,-100}}, lineColor={0,0,0}),
            Rectangle(extent={{-80,60},{80,-100}}, lineColor={0,0,0}),
            Rectangle(extent={{-80,60},{80,-100}}, lineColor={0,0,0}),
            Rectangle(
              extent={{-80,60},{80,-100}},
              lineColor={0,0,0},
              fillColor={211,243,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{60,-58},{30,-72},{-22,-68},{-16,-60},{-68,-52},{-30,-80},
                  {-24,-74},{46,-74},{60,-58}},
              lineColor={0,0,0},
              smooth=Smooth.Bezier,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-30,16},{30,-50}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textString="Air"),
            Polygon(
              points={{-58,22},{-28,36},{24,32},{18,24},{70,16},{32,44},{26,
                  38},{-44,38},{-58,22}},
              lineColor={0,0,0},
              smooth=Smooth.Bezier,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
        DymolaStoredErrors);
    end VarAirExchange;

    model InfiltrationRate_DIN12831
      "Heat flow caused by infiltration after european standard DIN EN 12831"
      extends Modelica.Thermal.HeatTransfer.Interfaces.Element1D;

      parameter Modelica.SIunits.Volume room_V=50 "Volume of the room";
      parameter Real n50(unit="h-1") = 4
        "Air exchange rate at 50 Pa pressure difference";
      parameter Real e=0.03 "Coefficient of windshield";
      parameter Real eps=1.0 "Coefficient of height";
      parameter Modelica.SIunits.SpecificHeatCapacity c=1000
        "Specific heat capacity of air";
      parameter Modelica.SIunits.Density rho=1.25 "Air density";
    protected
      parameter Real InfiltrationRate = 2*n50*e*eps;

    equation
      port_a.Q_flow = InfiltrationRate*room_V*c*rho*(port_a.T - port_b.T)/3600;
      annotation (
        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics={
            Rectangle(extent={{-80,60},{80,-100}}, lineColor={0,0,0}),
            Rectangle(extent={{-80,60},{80,-100}}, lineColor={0,0,0}),
            Rectangle(
              extent={{-80,60},{80,-100}},
              lineColor={0,0,0},
              fillColor={211,243,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-30,-12},{30,-78}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textString=
                   "Air"),
            Text(
              extent={{-76,26},{78,-8}},
              lineColor={0,0,0},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid,
              textString="DIN 12381")}),
        Window(
          x=0.4,
          y=0.4,
          width=0.6,
          height=0.6),
        Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>The<b> InfiltrationRate</b> model describes heat and mass transport by infiltration. </p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<p><h4><font color=\"#008000\">Concept</font></h4></p>
<p>Air exchange coefficients at 50 Pa pressure difference between ambience and room air: </p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"1\"><tr>
<td><p align=\"center\"><h4>Dwelling type</h4></p></td>
<td><p align=\"center\"><h4>highly air tight</h4></p></td>
<td><p align=\"center\"><h4>medium air tight</h4></p></td>
<td><p align=\"center\"><h4>low air tight</h4></p></td>
</tr>
<tr>
<td><p>one-family dwelling</p></td>
<td><p>&LT; 4</p></td>
<td><p>4 - 10</p></td>
<td><p>&GT; 10</p></td>
</tr>
<tr>
<td><p>multi-family dwelling/other</p></td>
<td><p>&LT; 2</p></td>
<td><p>2 - 5</p></td>
<td><p>&GT; 5</p></td>
</tr>
</table>
<p>Reference values for air shielding value e: </p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"1\"><tr>
<td></td>
<td><p align=\"center\"><h4>heated room without </h4></p><p align=\"center\">facade with openings</p><p align=\"center\">exposed to wind</p></td>
<td><p align=\"center\"><h4>heated room with</h4></p><p align=\"center\">one facade with openings</p><p align=\"center\">exposed to wind</p></td>
<td><p align=\"center\"><h4>heated room with more than</h4></p><p align=\"center\">one facade with openings</p><p align=\"center\">exposed to wind</p></td>
</tr>
<tr>
<td><p>no shielding</p></td>
<td><p>0</p></td>
<td><p>0.03</p></td>
<td><p>0.05</p></td>
</tr>
<tr>
<td><p>moderate shielding</p></td>
<td><p>0</p></td>
<td><p>0.02</p></td>
<td><p>0.03</p></td>
</tr>
<tr>
<td><p>well shielded</p></td>
<td><p>0</p></td>
<td><p>0.01</p></td>
<td><p>0.02</p></td>
</tr>
</table>
<p>Reference values for height correction value &epsilon;: </p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"1\"><tr>
<td><p><h4>Height of room</h4></p></td>
<td><p align=\"center\"><br/><b>&epsilon;</b></p></td>
</tr>
<tr>
<td><p>0 - 10 m</p></td>
<td><p>1</p></td>
</tr>
<tr>
<td><p>10 - 30 m</p></td>
<td><p>1.2</p></td>
</tr>
<tr>
<td><p>&GT; 30 m</p></td>
<td><p>1.5</p></td>
</tr>
</table>
<p><h4><font color=\"#008000\">References</font></h4></p>
<p>DIN EN 12831</p>
<p><h4><font color=\"#008000\">Example Results</font></h4></p>
<p><a href=\"AixLib.Building.Components.Examples.DryAir.DryAir_test\">AixLib.Building.Components.Examples.DryAir.DryAir_test</a> </p>
</html>",
        revisions="<html>
<ul>
<li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
  <li><i>May 02, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
  <li><i>August 2, 2011&nbsp;</i>
         by Ana Constantin:<br>
         Implemented after a model from Time Haase.</li>
</ul>
</html>"),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics={
            Rectangle(extent={{-80,60},{80,-100}}, lineColor={0,0,0}),
            Rectangle(extent={{-80,60},{80,-100}}, lineColor={0,0,0}),
            Rectangle(extent={{-80,60},{80,-100}}, lineColor={0,0,0}),
            Rectangle(
              extent={{-80,60},{80,-100}},
              lineColor={0,0,0},
              fillColor={211,243,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-30,16},{30,-50}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textString=
                   "Air")}),
        DymolaStoredErrors);
    end InfiltrationRate_DIN12831;

    model DynamicVentilation
      "Dynamic ventilation to ventilate away the solar gains"
      parameter Modelica.SIunits.Temperature HeatingLimit = 285.15
        "Outside temperature at which the heating activates";
      parameter Real Max_VR = 200 "Maximal ventilation rate";
      parameter Modelica.SIunits.TemperatureDifference Diff_toTempset = 2
        "Difference to set temperature";
      parameter Modelica.SIunits.Temperature Tset = 295.15 "set temperature";
      VarAirExchange     varAirExchange
        annotation (Placement(transformation(extent={{36,-20},{62,4}})));
      Utilities.Control.PITemp pITemp(
        h=0,
        l=-Max_VR,
        PI(controllerType=Modelica.Blocks.Types.SimpleController.PI))
        annotation (Placement(transformation(extent={{-22,26},{-2,46}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_inside
        annotation (Placement(transformation(extent={{84,-20},{104,0}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_outside
        annotation (Placement(transformation(extent={{-106,-20},{-86,0}})));
      Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor Sensor_Toutside
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-90,12})));
      Modelica.Blocks.Logical.GreaterThreshold Higher_HeatingLimit(threshold=
            HeatingLimit)
        annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
      Modelica.Blocks.Sources.Constant Input_Tset(k=Tset)
                                                      annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-70,90}),  iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-60,90})));
      Modelica.Blocks.Math.MultiSum multiSum(nu=2)
        annotation (Placement(transformation(extent={{-40,68},{-28,80}})));
      Modelica.Blocks.Sources.Constant Source_Tdiff(k=Diff_toTempset)
        annotation (Placement(transformation(extent={{-80,46},{-60,66}})));
      Modelica.Blocks.Math.Gain Inverter(k=-1)
        annotation (Placement(transformation(extent={{8,30},{20,42}})));
      Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor Sensor_Tinside
        annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=0,
            origin={14,-80})));
      Modelica.Blocks.Logical.And Colder_and_HeatingLimit
        annotation (Placement(transformation(extent={{-46,28},{-32,42}})));
      Modelica.Blocks.Logical.Less less
        annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
    equation
      connect(port_outside, Sensor_Toutside.port) annotation (Line(
          points={{-96,-10},{-96,-4},{-90,-4},{-90,2}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(port_inside, pITemp.Therm1) annotation (Line(
          points={{94,-10},{94,27},{-18,27}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(Sensor_Toutside.T, Higher_HeatingLimit.u) annotation (Line(
          points={{-90,22},{-90,30},{-82,30}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(multiSum.y, pITemp.soll) annotation (Line(
          points={{-26.98,74},{-22,74},{-22,45},{-20,45}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(Source_Tdiff.y, multiSum.u[1]) annotation (Line(
          points={{-59,56},{-50,56},{-50,76.1},{-40,76.1}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(pITemp.y, Inverter.u) annotation (Line(
          points={{-3,36},{6.8,36}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(Inverter.y, varAirExchange.InPort1) annotation (Line(
          points={{20.6,36},{24,36},{24,-15.68},{37.3,-15.68}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(Input_Tset.y, multiSum.u[2]) annotation (Line(
          points={{-59,90},{-54,90},{-54,88},{-50,88},{-50,71.9},{-40,71.9}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(Sensor_Tinside.port, port_inside) annotation (Line(
          points={{24,-80},{94,-80},{94,-10}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(Higher_HeatingLimit.y, Colder_and_HeatingLimit.u1) annotation (Line(
          points={{-59,30},{-52,30},{-52,35},{-47.4,35}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(Colder_and_HeatingLimit.y, pITemp.onOff) annotation (Line(
          points={{-31.3,35},{-24,35},{-24,31},{-21,31}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(less.u2, Sensor_Tinside.T) annotation (Line(
          points={{-82,-58},{-100,-58},{-100,-80},{4,-80}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(Sensor_Toutside.T, less.u1) annotation (Line(
          points={{-90,22},{-100,22},{-100,-50},{-82,-50}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(less.y, Colder_and_HeatingLimit.u2) annotation (Line(
          points={{-59,-50},{-52,-50},{-52,29.4},{-47.4,29.4}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(port_outside, varAirExchange.port_a) annotation (Line(
          points={{-96,-10},{-96,-8},{36,-8}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(varAirExchange.port_b, port_inside) annotation (Line(
          points={{62,-8},{94,-8},{94,-10}},
          color={191,0,0},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}),
                          graphics),
        Icon(graphics={
            Rectangle(
              extent={{-80,80},{80,-80}},
              lineColor={0,0,0},
              fillColor={211,243,255},
              fillPattern=FillPattern.Solid)}),
        Documentation(revisions="<html>
<ul>
<li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
  <li><i>May 02, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
  <li><i>October 16, 2011&nbsp;</i> by Ana Constantin:<br/>implemented<br></li>
</ul>
</html>",   info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>This model ventilates the solar gains away. </p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<p><h4><font color=\"#008000\">Concept</font></h4></p>
<p>The model is used for simulations of heating periods. The outside temperature can be so high, that the heating system shuts down and the temperature in the room rises too high.</p>
<p>When the outside temperature rises above the heating limit, the model is activated and tries to lower the temperature under the set temperature of the room plus 2K.</p>
<p>Furthermore the model is only activated when the outdside temperature lower is than the inside temeperature. </p>
<p>The maximum ventilation rate can be adjusted according to the type of building. You can try to set it really high, e.g. 200 1/h, in order to exhaust the potential of this type of ventilation for cooling the rooms. </p>
<p><h4><font color=\"#008000\">Example Results</font></h4></p>
<p><a href=\"AixLib.Building.Components.Examples.DryAir.DryAir_test\">AixLib.Building.Components.Examples.DryAir.DryAir_test</a> </p>
</html>"));
    end DynamicVentilation;
  end DryAir;

  package Sources
        extends Modelica.Icons.Package;

    package InternalGains
      "Models for humans, maschines, light and other heat sources"
      extends Modelica.Icons.Package;

      package Humans
        extends Modelica.Icons.Package;

        model HumanSensibleHeat_VDI2078
          "Model for sensible heat output after VDI 2078 "
         // Number of Persons
         parameter Integer ActivityType = 2 "Physical activity"
            annotation(Dialog( compact = true, descriptionLabel = true), choices(choice=2 "light", choice = 3
                "moderate",                                                                                              choice = 4 "heavy ", radioButtons = true));
         parameter Real NrPeople = 1.0 "Number of people in the room" annotation(Dialog(descriptionLabel = true));
         parameter Real RatioConvectiveHeat = 0.5
            "Ratio of convective heat from overall heat output" annotation(Dialog( descriptionLabel = true));
        protected
         parameter Modelica.SIunits.Area SurfaceArea_Human=2;
         parameter Real Emissivity_Human = 0.98;
          Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow ConvectiveHeat(T_ref=T0)
            annotation (Placement(transformation(extent={{18,20},{42,44}})));
          Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow RadiativeHeat(T_ref=T0)
            annotation (Placement(transformation(extent={{18,-20},{42,4}})));
          Modelica.Blocks.Tables.CombiTable1D HeatOutput(table=[10,100,125,155; 18,100,125,
                155; 20,95,115,140; 22,90,105,120; 23,85,100,115; 24,75,95,110; 25,75,85,
                105; 26,70,85,95; 35,70,85,95],
            smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
            tableOnFile=false,
            columns={ActivityType})
            annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
        public
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ConvHeat
            annotation (Placement(transformation(extent={{80,40},{100,60}})));
          Utilities.HeatTransfer.HeatToStar_Avar RadiationConvertor(eps=
                Emissivity_Human) annotation (Placement(transformation(
                  extent={{48,-22},{72,2}})));
          Utilities.Interfaces.Star RadHeat annotation (Placement(
                transformation(extent={{80,-20},{100,0}})));
          Modelica.Blocks.Math.MultiProduct productHeatOutput(nu=2)
            annotation (Placement(transformation(extent={{-24,10},{-4,30}})));
        public
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a TRoom
            "Air temperature in room"
            annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
          Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-90,64})));
          Modelica.Blocks.Math.UnitConversions.To_degC to_degC
            annotation (Placement(transformation(extent={{-82,46},{-72,56}})));
          Modelica.Blocks.Interfaces.RealInput Schedule annotation (Placement(
                transformation(extent={{-120,-40},{-80,0}}), iconTransformation(
                  extent={{-102,-22},{-80,0}})));
          Modelica.Blocks.Math.Gain Nr_People(k=NrPeople)
            annotation (Placement(transformation(extent={{-66,-26},{-54,-14}})));
          Modelica.Blocks.Math.Gain SurfaceArea_People(k=SurfaceArea_Human)
            annotation (Placement(transformation(extent={{-16,-56},{-4,-44}})));
          parameter Modelica.SIunits.Temperature T0=
              Modelica.SIunits.Conversions.from_degC(22) "Initial temperature";
          Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1e+23, uMin=1e-4)
            annotation (Placement(transformation(extent={{8,-60},{28,-40}})));
          Modelica.Blocks.Math.Gain gain(k=RatioConvectiveHeat)
            annotation (Placement(transformation(extent={{6,28},{14,36}})));
          Modelica.Blocks.Math.Gain gain1(k=1 - RatioConvectiveHeat)
            annotation (Placement(transformation(extent={{6,-12},{14,-4}})));
        equation
          connect(ConvectiveHeat.port, ConvHeat) annotation (Line(
              points={{42,32},{42,50},{90,50}},
              color={191,0,0},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          connect(RadiativeHeat.port, RadiationConvertor.Therm) annotation (Line(
              points={{42,-8},{44,-8},{44,-12},{48,-12},{48,-10},{48.96,-10}},
              color={191,0,0},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          connect(RadiationConvertor.Star, RadHeat)
                                             annotation (Line(
              points={{70.92,-10},{90,-10}},
              color={95,95,95},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          connect(TRoom, temperatureSensor.port) annotation (Line(
              points={{-90,90},{-90,74}},
              color={191,0,0},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          connect(temperatureSensor.T, to_degC.u) annotation (Line(
              points={{-90,54},{-84,54},{-84,52},{-83,51}},
              color={0,0,127},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          connect(to_degC.y, HeatOutput.u[1]) annotation (Line(
              points={{-71.5,51},{-67.75,51},{-67.75,50},{-62,50}},
              color={0,0,127},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          connect(HeatOutput.y[1], productHeatOutput.u[1]) annotation (Line(
              points={{-39,50},{-32,50},{-32,23.5},{-24,23.5}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(Schedule, Nr_People.u) annotation (Line(
              points={{-100,-20},{-67.2,-20}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(Nr_People.y, productHeatOutput.u[2]) annotation (Line(
              points={{-53.4,-20},{-32,-20},{-32,16.5},{-24,16.5}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(Nr_People.y, SurfaceArea_People.u) annotation (Line(
              points={{-53.4,-20},{-32,-20},{-32,-50},{-17.2,-50}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(SurfaceArea_People.y, limiter.u) annotation (Line(
              points={{-3.4,-50},{6,-50}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(limiter.y, RadiationConvertor.A) annotation (Line(
              points={{29,-50},{44,-50},{44,16},{60,16},{60,0.8}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(gain.y, ConvectiveHeat.Q_flow) annotation (Line(
              points={{14.4,32},{18,32}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(gain1.y, RadiativeHeat.Q_flow) annotation (Line(
              points={{14.4,-8},{18,-8}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(productHeatOutput.y, gain.u) annotation (Line(
              points={{-2.3,20},{2,20},{2,32},{5.2,32}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(productHeatOutput.y, gain1.u) annotation (Line(
              points={{-2.3,20},{2,20},{2,-8},{5.2,-8}},
              color={0,0,127},
              smooth=Smooth.None));
          annotation (Icon(graphics={
                Ellipse(
                  extent={{-36,98},{36,26}},
                  lineColor={255,213,170},
                  fillColor={255,213,170},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{-48,20},{54,-94}},
                  fillColor={255,0,0},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Text(
                  extent={{-40,-2},{44,-44}},
                  lineColor={255,255,255},
                  fillColor={255,0,0},
                  fillPattern=FillPattern.Solid,
                  textString="ERC"),
                Ellipse(
                  extent={{-24,80},{-14,70}},
                  fillColor={0,0,0},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None,
                  lineColor={0,0,0}),
                Ellipse(
                  extent={{10,80},{20,70}},
                  fillColor={0,0,0},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None,
                  lineColor={0,0,0}),
                Line(
                  points={{-18,54},{-16,48},{-10,44},{-4,42},{2,42},{10,44},{16,48},{18,
                      54}},
                  smooth=Smooth.None,
                  color={0,0,0},
                  thickness=1)}), Diagram(coordinateSystem(preserveAspectRatio=false,
                           extent={{-100,-100},{100,100}}),
                                          graphics),
            Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Model for heat ouput of a human according to VDI 2078 (Table A.1). The model only considers the dry heat emission and divides it into convective and radiative heat transmission. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>It is possible to choose between several types of physical activity.</p>
<p>The heat output depends on the air temperature in the room where the activity takes place.</p>
<p>A schedule of the activity is also required as constant presence of people in a room is not realistic. The schedule describes the presence of only one person, and can take values from 0 to 1. </p>
<h4><span style=\"color:#008000\">Assumptions</span></h4>
<p>The surface for radiation exchange is computed from the number of persons in the room, which leads to a surface area of zero, when no one is present. In particular cases this might lead to an error as depending of the rest of the system a division by this surface will be introduced in the system of equations -&GT; division by zero. For this reson a limitiation for the surface has been intoduced: a minimum of 1e-4 m2 and a maximum of 1e+23 m2 (only needed for a complete parametrization of the model). </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>VDI 2078: Calculation of cooling load and room temperatures of rooms and buildings (VDI Cooling Load Code of Practice) - March 2012</p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p><a href=\"AixLib.Building.Components.Examples.Sources.InternalGains.Humans\">AixLib.Building.Components.Examples.Sources.InternalGains.Humans</a> </p>
<p><a href=\"AixLib.Building.Components.Examples.Sources.InternalGains.OneOffice\">AixLib.Building.Components.Examples.Sources.InternalGains.OneOffice</a></p>
</html>",     revisions="<html>
<ul>
<li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
<li><i>April 10, 2014&nbsp;</i> by Ana Constantin:<br>Added a lower positive limit to the surface area, so it won&apos;t lead to a division by zero</li>
<li><i>May 07, 2013&nbsp;</i> by Ole Odendahl:<br>Formatted documentation appropriately</li>
<li><i>August 10, 2011</i> by Ana Constantin:<br>implemented</li>
</ul>
</html>"));
        end HumanSensibleHeat_VDI2078;
      end Humans;

      package Machines
        extends Modelica.Icons.Package;

        model Machines_DIN18599
          extends BaseClasses.PartialInternalGain;

          parameter Integer ActivityType=2 "Machine activity"
            annotation(Dialog( compact = true, descriptionLabel = true), choices(choice=1 "low", choice = 2 "middle",  choice = 3 "high", radioButtons = true));
          parameter Real NrPeople=1.0 "Number of people with machines"  annotation(Dialog(descriptionLabel = true));
          parameter Modelica.SIunits.Area SurfaceArea_Machines=2
            "surface area of radiative heat source";
          parameter Real Emissivity_Machines=0.98;
        protected
          Modelica.Blocks.Tables.CombiTable1D HeatOutput(
            smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
            tableOnFile=false,
            table=[1,50; 2,100; 3,150],
            columns={2})
            annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
          Modelica.Blocks.Math.MultiProduct productHeatOutput(nu=2)
            annotation (Placement(transformation(extent={{-24,-10},{-4,10}})));
        public
          Modelica.Blocks.Math.Gain Nr_People(k=NrPeople)
            annotation (Placement(transformation(extent={{-60,-46},{-48,-34}})));
          Modelica.Blocks.Sources.Constant Activity(k=ActivityType)
            annotation (Placement(transformation(extent={{-90,40},{-70,60}})));
          Utilities.HeatTransfer.HeatToStar RadiationConvertor(eps=
                Emissivity_Machines, A=SurfaceArea_Machines*NrPeople)
            annotation (Placement(transformation(extent={{50,-70},{70,-50}})));
        equation
          connect(HeatOutput.y[1], productHeatOutput.u[1]) annotation (Line(
              points={{-39,50},{-32,50},{-32,3.5},{-24,3.5}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(Nr_People.y, productHeatOutput.u[2]) annotation (Line(
              points={{-47.4,-40},{-32,-40},{-32,-3.5},{-24,-3.5}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(Schedule, Nr_People.u) annotation (Line(
              points={{-100,0},{-85.6,0},{-85.6,-40},{-61.2,-40}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(Activity.y, HeatOutput.u[1]) annotation (Line(
              points={{-69,50},{-62,50}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(RadiationConvertor.Star, RadHeat) annotation (Line(
              points={{69.1,-60},{90,-60}},
              color={95,95,95},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          connect(RadiativeHeat.port, RadiationConvertor.Therm) annotation (Line(
              points={{40,-10},{48,-10},{48,-60},{50.8,-60}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(productHeatOutput.y, gain.u) annotation (Line(
              points={{-2.3,0},{0,0},{0,30},{3.2,30}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(productHeatOutput.y, gain1.u) annotation (Line(
              points={{-2.3,0},{0,0},{0,-10},{3.2,-10}},
              color={0,0,127},
              smooth=Smooth.None));
          annotation (Icon(graphics={
                Text(
                  extent={{-40,-20},{44,-62}},
                  lineColor={255,255,255},
                  fillColor={255,0,0},
                  fillPattern=FillPattern.Solid,
                  textString="ERC"),
                Polygon(
                  points={{-90,-86},{-58,-42},{60,-42},{98,-86},{-90,-86}},
                  pattern=LinePattern.None,
                  smooth=Smooth.None,
                  fillColor={0,0,0},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{-54,-48},{-46,-54}},
                  pattern=LinePattern.None,
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0}),
                Rectangle(
                  extent={{-42,-48},{-34,-54}},
                  pattern=LinePattern.None,
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0}),
                Rectangle(
                  extent={{-30,-48},{-22,-54}},
                  pattern=LinePattern.None,
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0}),
                Rectangle(
                  extent={{-18,-48},{-10,-54}},
                  pattern=LinePattern.None,
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0}),
                Rectangle(
                  extent={{-6,-48},{2,-54}},
                  pattern=LinePattern.None,
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0}),
                Rectangle(
                  extent={{6,-48},{14,-54}},
                  pattern=LinePattern.None,
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0}),
                Rectangle(
                  extent={{18,-48},{26,-54}},
                  pattern=LinePattern.None,
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0}),
                Rectangle(
                  extent={{30,-48},{38,-54}},
                  pattern=LinePattern.None,
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0}),
                Rectangle(
                  extent={{42,-48},{50,-54}},
                  pattern=LinePattern.None,
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0}),
                Rectangle(
                  extent={{-62,-58},{-54,-64}},
                  pattern=LinePattern.None,
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0}),
                Rectangle(
                  extent={{-50,-58},{-42,-64}},
                  pattern=LinePattern.None,
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0}),
                Rectangle(
                  extent={{-38,-58},{-30,-64}},
                  pattern=LinePattern.None,
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0}),
                Rectangle(
                  extent={{-26,-58},{-18,-64}},
                  pattern=LinePattern.None,
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0}),
                Rectangle(
                  extent={{-14,-58},{-6,-64}},
                  pattern=LinePattern.None,
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0}),
                Rectangle(
                  extent={{-2,-58},{6,-64}},
                  pattern=LinePattern.None,
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0}),
                Rectangle(
                  extent={{10,-58},{18,-64}},
                  pattern=LinePattern.None,
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0}),
                Rectangle(
                  extent={{22,-58},{30,-64}},
                  pattern=LinePattern.None,
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0}),
                Rectangle(
                  extent={{34,-58},{42,-64}},
                  pattern=LinePattern.None,
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0}),
                Rectangle(
                  extent={{46,-58},{54,-64}},
                  pattern=LinePattern.None,
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0}),
                Rectangle(
                  extent={{58,-58},{66,-64}},
                  pattern=LinePattern.None,
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0}),
                Rectangle(
                  extent={{-72,-68},{-64,-74}},
                  pattern=LinePattern.None,
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0}),
                Rectangle(
                  extent={{-60,-68},{-52,-74}},
                  pattern=LinePattern.None,
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0}),
                Rectangle(
                  extent={{-48,-68},{-40,-74}},
                  pattern=LinePattern.None,
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0}),
                Rectangle(
                  extent={{-36,-68},{-28,-74}},
                  pattern=LinePattern.None,
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0}),
                Rectangle(
                  extent={{-24,-68},{-16,-74}},
                  pattern=LinePattern.None,
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0}),
                Rectangle(
                  extent={{-12,-68},{-4,-74}},
                  pattern=LinePattern.None,
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0}),
                Rectangle(
                  extent={{0,-68},{8,-74}},
                  pattern=LinePattern.None,
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0}),
                Rectangle(
                  extent={{12,-68},{20,-74}},
                  pattern=LinePattern.None,
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0}),
                Rectangle(
                  extent={{24,-68},{32,-74}},
                  pattern=LinePattern.None,
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0}),
                Rectangle(
                  extent={{36,-68},{44,-74}},
                  pattern=LinePattern.None,
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0}),
                Rectangle(
                  extent={{48,-68},{56,-74}},
                  pattern=LinePattern.None,
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0}),
                Rectangle(
                  extent={{60,-68},{68,-74}},
                  pattern=LinePattern.None,
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0}),
                Rectangle(
                  extent={{72,-68},{80,-74}},
                  pattern=LinePattern.None,
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0}),
                Rectangle(
                  extent={{-60,60},{60,-38}},
                  fillColor={175,175,175},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),
                Rectangle(
                  extent={{-56,56},{56,-34}},
                  pattern=LinePattern.None,
                  fillColor={0,0,0},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,0}),
                Text(
                  extent={{-54,30},{58,-8}},
                  lineColor={255,0,0},
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid,
                  textString="ERC")}), Diagram(coordinateSystem(
                  preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                                               graphics),
            Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Heat cource with convective and radiative component. The load is determined by a schedule and the type of activity. </p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica:/AixLib/Images/stars2.png\"/></p>
<p><h4><font color=\"#008000\">Concept</font></h4></p>
<p>The schedule sets the usage of the room by people. To set a higher number of people, a multiplier is given.</p>
<p>The schedule describes the presence of only one person, and can take values from 0 to 1. </p>
<p>The type of activity determines the load by a person in the room according to DIN 18599. The following values are provided:</p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"0\"><tr>
<td bgcolor=\"#dcdcdc\"><p>Activity Type</p></td>
<td bgcolor=\"#dcdcdc\"><p>Heat Load [W]</p></td>
</tr>
<tr>
<td><p>1</p></td>
<td><p>50</p></td>
</tr>
<tr>
<td><p>2</p></td>
<td><p>100</p></td>
</tr>
<tr>
<td><p>3</p></td>
<td><p>150</p></td>
</tr>
</table>
<p><h4><font color=\"#008000\">References</font></h4></p>
<p>DIN 18599 </p>
<p><h4><font color=\"#008000\">Example Results</font></h4></p>
<p><a href=\"AixLib.Building.Components.Examples.Sources.InternalGains.Machines\">AixLib.Building.Components.Examples.Sources.InternalGains.Machines </a></p>
<p><a href=\"AixLib.Building.Components.Examples.Sources.InternalGains.OneOffice\">AixLib.Building.Components.Examples.Sources.InternalGains.OneOffice</a></p>
</html>",   revisions="<html>
<p><ul>
<li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
<li><i>May 07, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
</ul></p>
</html>"));
        end Machines_DIN18599;
      end Machines;

      package Lights
        extends Modelica.Icons.Package;

        model Lights_relative "light heat source model"
          extends BaseClasses.PartialInternalGain(ratioConv=0.5);
          parameter Modelica.SIunits.Area RoomArea=20 "Area of room"    annotation(Dialog( descriptionLabel = true));
          parameter Real LightingPower = 10 "Heating power of lighting in W/m2"
                                                                                annotation(Dialog( descriptionLabel = true));
          parameter Modelica.SIunits.Area SurfaceArea_Lighting=1;
          parameter Real Emissivity_Lighting = 0.98;
          Modelica.Blocks.Sources.Constant MaxLighting(k=RoomArea*LightingPower)
            annotation (Placement(transformation(extent={{-90,40},{-70,60}})));
          Modelica.Blocks.Math.MultiProduct productHeatOutput(nu=2)
            annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
          Utilities.HeatTransfer.HeatToStar RadiationConvertor(A=
                SurfaceArea_Lighting, eps=Emissivity_Lighting)
            annotation (Placement(transformation(extent={{50,-70},{70,-50}})));
        equation
          connect(MaxLighting.y,productHeatOutput. u[2])
                                                  annotation (Line(
              points={{-69,50},{-48,50},{-48,-3.5},{-40,-3.5}},
              color={0,0,0},
              smooth=Smooth.None));
          connect(Schedule,productHeatOutput. u[1]) annotation (Line(
              points={{-100,0},{-76,0},{-76,-20},{-48,-20},{-48,-4},{-40,-4},{-40,3.5}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(RadiativeHeat.port, RadiationConvertor.Therm) annotation (Line(
              points={{40,-10},{46,-10},{46,-60},{50.8,-60}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(RadiationConvertor.Star, RadHeat) annotation (Line(
              points={{69.1,-60},{90,-60}},
              color={95,95,95},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          connect(productHeatOutput.y, gain.u) annotation (Line(
              points={{-18.3,0},{-8,0},{-8,30},{3.2,30}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(productHeatOutput.y, gain1.u) annotation (Line(
              points={{-18.3,0},{-8,0},{-8,-10},{3.2,-10}},
              color={0,0,127},
              smooth=Smooth.None));
          annotation (Icon(graphics={
                Ellipse(
                  extent={{-52,72},{50,-40}},
                  lineColor={255,255,0},
                  fillColor={255,255,0},
                  fillPattern=FillPattern.Solid),
                Line(
                  points={{-26,-48},{22,-48}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  thickness=1),
                Line(
                  points={{-24,-56},{22,-56}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  thickness=1),
                Line(
                  points={{-24,-64},{22,-64}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  thickness=1),
                Line(
                  points={{-24,-72},{22,-72}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  thickness=1),
                Line(
                  points={{-28,-42},{-28,-80},{26,-80},{26,-42}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  thickness=1)}), Documentation(revisions="<html>
<p><ul>
<li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
<li><i>May 07, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
</ul></p>
</html>",   info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Light heat source model. Maximum lighting can be given as input and be adjusted by a schedule input.</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://AixLib/Images/stars2.png\"/></p>
<p><h4><font color=\"#008000\">Known limitation</font></h4></p>
<p>The parameter <b>A</b> cannot be set by default since other models must be able to implement their own equations for <b>A</b>.</p>
<p>The input signal can take values from 0 to 1, and is then multiplied with the maximum lighting power per square meter and the room area. </p>
<p><h4><font color=\"#008000\">Example Results</font></h4></p>
<p><a href=\"AixLib.Building.Components.Examples.Sources.InternalGains.Lights\">AixLib.Building.Components.Examples.Sources.InternalGains.Lights</a> </p>
<p><a href=\"AixLib.Building.Components.Examples.Sources.InternalGains.OneOffice\">AixLib.Building.Components.Examples.Sources.InternalGains.OneOffice</a></p>
</html>"),  Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}), graphics));
        end Lights_relative;
        annotation (Icon(graphics), Documentation(info="<html>
<p>Simple model for internal gains through lights.</p>
</html>"));
      end Lights;

      package BaseClasses
        extends Modelica.Icons.BasesPackage;

        partial model PartialInternalGain
          "Partial model to build a heat source with convective and radiative component"
          parameter Real ratioConv=0.6 "Ratio convective to total heat release"
                                                     annotation(Dialog( descriptionLabel = true));
          parameter Real emissivity=0.95
            "emissivity of radiative heat source surface";
          parameter Modelica.SIunits.Temperature T0=
              Modelica.SIunits.Conversions.from_degC(22) "Initial temperature";

          Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow ConvectiveHeat(T_ref=T0)
            annotation (Placement(transformation(extent={{20,20},{40,40}})));
          Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow RadiativeHeat(T_ref=
                ratioConv)
            annotation (Placement(transformation(extent={{20,-20},{40,0}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ConvHeat
            "convective heat connector" annotation (Placement(transformation(
                  extent={{80,50},{100,70}}), iconTransformation(extent={{80,50},
                    {100,70}})));
          Utilities.Interfaces.Star RadHeat "radiative heat connector"
            annotation (Placement(transformation(extent={{80,-70},{100,-50}}),
                iconTransformation(extent={{80,-68},{100,-48}})));
          Modelica.Blocks.Interfaces.RealInput Schedule annotation (Placement(
                transformation(extent={{-120,-20},{-80,20}}),iconTransformation(extent={{-100,
                    -10},{-80,10}})));
          Modelica.Blocks.Math.Gain gain(k=ratioConv)
            annotation (Placement(transformation(extent={{4,26},{12,34}})));
          Modelica.Blocks.Math.Gain gain1(k=1 - ratioConv)
            annotation (Placement(transformation(extent={{4,-14},{12,-6}})));
        equation
          connect(ConvectiveHeat.port, ConvHeat) annotation (Line(
              points={{40,30},{46,30},{46,60},{90,60}},
              color={191,0,0},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          connect(gain.y, ConvectiveHeat.Q_flow) annotation (Line(
              points={{12.4,30},{20,30}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(gain1.y, RadiativeHeat.Q_flow) annotation (Line(
              points={{12.4,-10},{20,-10}},
              color={0,0,127},
              smooth=Smooth.None));
          annotation (
            Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                    100,100}}),
                 graphics),
            Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}),
                    graphics),
            Documentation(revisions="<html>
<p><ul>
<li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
<li><i>May 02, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
<li><i>April 30, 2012</i> by Peter Matthes:<br/>implemented partial model for heat sources to work with Ana's models.</li>
<li><i>August 10, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>",         info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Partial model to build a heat source with convective and radiative components. The parameter <code>ratioConv</code> determines the percentage of convective heat.</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
</html>"));
        end PartialInternalGain;
      end BaseClasses;
    end InternalGains;
  end Sources;

  package Walls "Wall models"
        extends Modelica.Icons.Package;

    model Wall
      "Simple wall model for outside and inside walls with windows and doors"
      import BaseLib = AixLib.Utilities;

      //Type parameter

       parameter Boolean outside = true
        "Choose if the wall is an outside or an inside wall"                                  annotation(Dialog(group="General Wall Type Parameter",compact = true),choices(choice=true
            "Outside Wall",choice=false "Inside Wall",        radioButtons = true));

      // general wall parameters

      parameter DataBase.Walls.WallBaseDataDefinition WallType=
          DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S()
        "Choose an outside wall type from the database"
        annotation (Dialog(group="Room Geometry"), choicesAllMatching=true);

       parameter Modelica.SIunits.Length wall_length=2 "Length of wall"
                          annotation(Dialog(group="Room Geometry"));
       parameter Modelica.SIunits.Height wall_height=2 "Height of wall"
                          annotation(Dialog(group="Room Geometry"));

    // Surface parameters
      parameter Real solar_absorptance=0.25
        "Solar absorptance coefficient of outside wall surface"  annotation(Dialog(tab="Surface Parameters", group = "Outside surface", enable = outside));

      parameter Integer Model =  1
        "Choose the model for calculation of heat convection at outside surface"
        annotation(Dialog(tab = "Surface Parameters",  group = "Outside surface", enable = outside, compact = true), choices(choice=1
            "DIN 6946",                                                                                                  choice = 2
            "ASHRAE Fundamentals", choice = 3 "Custom alpha",radioButtons =  true));

      parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_custom=25
        "Custom alpha for convection (just for manual selection, not recommended)"
                                                                                   annotation(Dialog(tab="Surface Parameters", group = "Outside surface", enable= Model == 3 and outside));
      parameter
        DataBase.Surfaces.RoughnessForHT.PolynomialCoefficients_ASHRAEHandbook
        surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster()
        "Surface type of outside wall" annotation (Dialog(
          tab="Surface Parameters",
          group="Outside surface",
          enable=Model == 2 and outside), choicesAllMatching=true);

      parameter Integer ISOrientation = 1 "Inside surface orientation" annotation(Dialog(tab = "Surface Parameters",  group = "Inside surface", compact = true, descriptionLabel = true), choices(choice=1
            "vertical wall",                                                                                                  choice = 2 "floor",
                     choice = 3 "ceiling",radioButtons =  true));

        // window parameters
       parameter Boolean withWindow = false
        "Choose if the wall has got a window (only outside walls)"                                     annotation(Dialog( tab="Window", enable = outside));

      parameter DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple
        WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009()
        "Choose a window type from the database" annotation (Dialog(tab=
              "Window", enable=withWindow and outside), choicesAllMatching=true);
       parameter Modelica.SIunits.Area windowarea=2 "Area of window" annotation(Dialog( tab="Window",  enable = withWindow and outside));

       parameter Boolean withSunblind = false "enable support of sunblinding?" annotation(Dialog( tab="Window", enable = outside and withWindow));
       parameter Real Blinding=0 "blinding factor <=1" annotation(Dialog( tab="Window", enable = withWindow and outside and withSunblind));
       parameter Real Limit=180
        "minimum specific total solar radiation in W/m2 for blinding becoming active"
                                                                                       annotation(Dialog( tab="Window", enable = withWindow and outside and withSunblind));

       // door parameters
       parameter Boolean withDoor = false "Choose if the wall has got a door"  annotation(Dialog(tab="Door"));

      parameter Modelica.SIunits.CoefficientOfHeatTransfer U_door=1.8
        "Thermal transmission coefficient of door"
        annotation (Dialog(tab="Door", enable = withDoor));

      parameter Modelica.SIunits.Emissivity eps_door = 0.9
        "Solar emissivity of door material"                                                    annotation (Dialog(tab="Door", enable = withDoor));

       parameter Modelica.SIunits.Length door_height=2 annotation(Dialog(tab="Door", enable = withDoor));
       parameter Modelica.SIunits.Length door_width=1 annotation(Dialog( tab="Door", enable = withDoor));

    // Calculation of clearance

     final parameter Modelica.SIunits.Area clearance=
     if not (outside) and withDoor then  door_height*door_width else
     if outside and withDoor and withWindow then (windowarea + door_height*door_width) else
     if outside and withWindow then  windowarea else
     if outside and withDoor then door_height*door_width else
          0 "Wall clearance";

    // Initial temperature

     parameter Modelica.SIunits.Temperature T0 = Modelica.SIunits.Conversions.from_degC(20)
        "Initial temperature"                                                   annotation(Dialog(tab="Advanced Parameters"));

    // COMPONENT PART

    public
      BaseClasses.ConvNLayerClearanceStar Wall(
        h=wall_height,
        l=wall_length,
        T0=T0,
        clearance=clearance,
        selectable=true,
        eps=WallType.eps,
        wallType=WallType,
        surfaceOrientation=ISOrientation) "Wall" annotation (Placement(
            transformation(extent={{-20,14},{2,34}}, rotation=0)));

      Utilities.HeatTransfer.SolarRadToHeat SolarAbsorption(coeff=
            solar_absorptance, A=wall_height*wall_length - clearance) if     outside
        annotation (Placement(transformation(
            origin={-39,89},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      Utilities.Interfaces.SolarRad_in SolarRadiationPort if
                                                            outside
        annotation (Placement(transformation(extent={{-116,79},{-96,99}},
              rotation=0), iconTransformation(extent={{-36,100},{-16,120}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_outside
        annotation (Placement(transformation(extent={{-108,-6},{-88,14}},
              rotation=0), iconTransformation(extent={{-31,-10},{-11,10}})));

      Modelica.Blocks.Interfaces.RealInput WindSpeedPort if outside and (Model ==1 or Model ==2)
        annotation (Placement(transformation(extent={{-113,54},{-93,74}},
              rotation=0), iconTransformation(extent={{-31,78},{-11,98}})));

      Weather.Sunblind Sunblind(
        n=1,
        gsunblind={Blinding},
        Imax=Limit) if outside and withWindow and withSunblind
        annotation (Placement(transformation(extent={{-44,-22},{-21,4}})));

      WindowsDoors.Door Door(
        T0=T0,
        door_area=door_height*door_width,
        eps=eps_door,
        U=if outside then U_door else U_door*2) if
                         withDoor
        annotation (Placement(transformation(extent={{-21,-102},{11,-70}})));
      WindowsDoors.WindowSimple windowSimple(
        T0=T0,
        windowarea=windowarea,
        WindowType=WindowType) if outside and withWindow
        annotation (Placement(transformation(extent={{-15,-48},{11,-22}})));
      Utilities.HeatTransfer.HeatConv_outside heatTransfer_Outside(
        A=wall_length*wall_height - clearance,
        Model=Model,
        surfaceType=surfaceType,
        alpha_custom=alpha_custom) if            outside annotation (
          Placement(transformation(extent={{-47,48},{-27,68}})));

      Utilities.Interfaces.Adaptors.HeatStarToComb heatStarToComb
        annotation (Placement(transformation(
            extent={{-10,8},{10,-8}},
            rotation=180,
            origin={69,-1})));
      Utilities.Interfaces.HeatStarComb thermStarComb_inside annotation (
          Placement(transformation(extent={{92,-10},{112,10}}),
            iconTransformation(extent={{10,-10},{30,10}})));
    equation
    //   if outside and cardinality(WindSpeedPort) < 2 then
    //     WindSpeedPort = 3;
    //   end if;

    //******************************************************************
    // **********************standard connection************************
    //******************************************************************
      connect(Wall.Star, heatStarToComb.star) annotation (Line(
          points={{0.9,30},{48,30},{48,4.8},{58.6,4.8}},
          color={95,95,95},
          pattern=LinePattern.None,
          smooth=Smooth.None));
      connect(Wall.port_b, heatStarToComb.therm) annotation (Line(
          points={{0.9,23},{48,23},{48,-6.1},{58.9,-6.1}},
          color={191,0,0},
          smooth=Smooth.None));
    //******************************************************************
    // **********************standard connection for inside wall********
    //******************************************************************
    if not (outside) then
        connect(Wall.port_a, port_outside) annotation (Line(
            points={{-18.9,23},{-56.45,23},{-56.45,4},{-98,4}},
            color={191,0,0},
            smooth=Smooth.None));
    end if;

    //******************************************************************
    // ********************standard connection for outside wall*********
    //******************************************************************

    if (outside) then
        connect(SolarRadiationPort, SolarAbsorption.solarRad_in) annotation (Line(
            points={{-106,89},{-77,89},{-77,87},{-49.1,87}},
            color={255,128,0},
            smooth=Smooth.None));
      if Model == 1 or Model == 2 then
        connect(WindSpeedPort, heatTransfer_Outside.WindSpeedPort) annotation (Line(
          points={{-103,64},{-68,64},{-68,50.8},{-46.2,50.8}},
          color={0,0,127},
          smooth=Smooth.None));
      end if;
        connect(heatTransfer_Outside.port_a, port_outside) annotation (Line(
            points={{-47,58},{-56,58},{-56,4},{-98,4}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(heatTransfer_Outside.port_b,Wall.port_a)  annotation (Line(
            points={{-27,58},{-24,58},{-24,23},{-18.9,23}},
            color={191,0,0},
            smooth=Smooth.None));

        connect(SolarAbsorption.heatPort,Wall.port_a)  annotation (Line(
            points={{-30,87},{-26,87},{-26,84},{-18.9,84},{-18.9,23}},
            color={191,0,0},
            smooth=Smooth.None));

    end if;

    //******************************************************************
    // *******standard connections for wall with door************
    //******************************************************************

    if withDoor then

        connect(Door.port_a, port_outside) annotation (Line(
            points={{-19.4,-86},{-56,-86},{-56,24},{-24,24},{-24,4},{-98,4}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(Door.port_b, heatStarToComb.therm) annotation (Line(
            points={{9.4,-86},{48,-86},{48,-6.1},{58.9,-6.1}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(Door.Star, heatStarToComb.star) annotation (Line(
            points={{9.4,-76.4},{48,-76.4},{48,4.8},{58.6,4.8}},
            color={95,95,95},
            pattern=LinePattern.None,
            smooth=Smooth.None));

    end if;

    //******************************************************************
    // ****standard connections for outside wall with window***********
    //******************************************************************

    if outside and withWindow then
        connect(windowSimple.Star, heatStarToComb.star) annotation (Line(
            points={{9.7,-27.2},{48,-27.2},{48,4.8},{58.6,4.8}},
            color={95,95,95},
            pattern=LinePattern.None,
            smooth=Smooth.None));
        connect(windowSimple.port_inside, heatStarToComb.therm) annotation (Line(
            points={{9.7,-36.3},{48,-36.3},{48,-6.1},{58.9,-6.1}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(windowSimple.port_outside, port_outside) annotation (Line(
            points={{-13.7,-36.3},{-56,-36.3},{-56,4},{-98,4}},
            color={191,0,0},
            smooth=Smooth.None));
    end if;

    //******************************************************************
    // **** connections for outside wall with window without sunblind****
    //******************************************************************

    if outside and withWindow and not (withSunblind) then

        connect(windowSimple.solarRad_in, SolarRadiationPort) annotation (Line(
            points={{-13.7,-27.2},{-81,-27.2},{-81,89},{-106,89}},
            color={255,128,0},
            smooth=Smooth.None));

    end if;

    //******************************************************************
    // **** connections for outside wall with window and sunblind****
    //******************************************************************

    if outside and withWindow and withSunblind then
        connect(Sunblind.Rad_Out[1], windowSimple.solarRad_in) annotation (Line(
            points={{-22.15,-7.7},{-18,-7.7},{-18,-27.2},{-13.7,-27.2}},
            color={255,128,0},
            smooth=Smooth.None));
      connect(Sunblind.Rad_In[1], SolarRadiationPort) annotation (Line(
          points={{-42.85,-7.7},{-81,-7.7},{-81,89},{-106,89}},
          color={255,128,0},
          smooth=Smooth.None));
    end if;

      connect(heatStarToComb.thermStarComb, thermStarComb_inside) annotation (
          Line(
          points={{78.4,-1.1},{78.4,-1.05},{102,-1.05},{102,0}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(port_outside, port_outside) annotation (Line(
          points={{-98,4},{-98,4}},
          color={191,0,0},
          pattern=LinePattern.None,
          smooth=Smooth.None));
      annotation (
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics),
        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-20,-120},{20,120}},
            grid={1,1}), graphics={
          Rectangle(
              extent={{-16,120},{15,-60}},
              fillColor={215,215,215},
              fillPattern=FillPattern.Backward,
              pattern=LinePattern.None,
              lineColor={0,0,0}),
          Rectangle(
              extent={{-16,-90},{15,-120}},
              pattern=LinePattern.None,
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Backward),
          Rectangle(
              extent={{-16,-51},{15,-92}},
              lineColor={0,0,0},
              pattern=LinePattern.None,
              fillColor={215,215,215},
              fillPattern=FillPattern.Backward,
              visible=not ((withDoor))),
          Rectangle(
              extent={{-16,80},{15,20}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              visible= outside and withWindow,
              lineColor={255,255,255}),
            Line(
              points={{-2,80},{-2,20}},
              color={0,0,0},
              smooth=Smooth.None,
              visible=outside and withWindow),
            Line(
              points={{1,80},{1,20}},
              color={0,0,0},
              smooth=Smooth.None,
              visible=outside and withWindow),
            Line(
              points={{1,77},{-2,77}},
              color={0,0,0},
              smooth=Smooth.None,
              visible=outside and withWindow),
            Line(
              points={{1,23},{-2,23}},
              color={0,0,0},
              smooth=Smooth.None,
              visible=outside and withWindow),
            Ellipse(
              extent={{-16,-60},{44,-120}},
              lineColor={0,0,0},
              startAngle=359,
              endAngle=450,
              visible= withDoor),
            Rectangle(
              extent={{-16,-60},{15,-90}},
              visible= withDoor,
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{1,50},{-2,50}},
              color={0,0,0},
              smooth=Smooth.None,
              visible=outside and withWindow),
            Line(
              points={{15,80},{15,20}},
              color={0,0,0},
              smooth=Smooth.None,
              visible=outside and withWindow),
            Line(
              points={{-16,80},{-16,20}},
              color={0,0,0},
              smooth=Smooth.None,
              visible=outside and withWindow),
            Line(
              points={{-16,-60},{-16,-90}},
              color={0,0,0},
              smooth=Smooth.None,
              visible=withDoor),
            Line(
              points={{15,-60},{15,-90}},
              color={0,0,0},
              smooth=Smooth.None,
              visible=withDoor),
            Line(
              points={{-16,-90},{15,-60}},
              color={0,0,0},
              smooth=Smooth.None,
              visible=withDoor),
            Line(
              points={{-16,-60},{15,-90}},
              color={0,0,0},
              smooth=Smooth.None,
              visible=withDoor)}),
        Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Flexible Model for Inside Walls and Outside Walls. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The<b> WallSimple</b> model models </p>
<ul>
<li>Conduction and convection for a wall (different on the inside surface depending on the surface orientation: vertical wall, floor or ceiling)</li>
<li>Outside walls may have a window and/ or a door</li>
<li>Inside walls may have a door</li>
</ul>
<p>This model uses a <a href=\"AixLib.Utilities.Interfaces.HeatStarComb\">HeatStarComb</a> Connector for an easier connection of temperature and radiance inputs.</p>
<p><b><font style=\"color: #008000; \">Assumptions</font></b> </p>
<ul>
<li>Outside walls are represented as complete walls</li>
<li>Inside walls are modeled as a half of a wall, you need to connect a corresponding second half with the same values</li>
<li>Door and window got a constant U-value</li>
<li>No heat storage in doors or window </li>
</ul>
<p>Have a closer look at the used models to get more information about the assumptions. </p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p><a href=\"AixLib.Building.Components.Examples.Walls.InsideWall\">AixLib.Building.Components.Examples.Walls.InsideWall</a> </p>
</html>",
    revisions="<html>
<p><ul>
<li><i>August 22, 2014&nbsp;</i> by Ana Constantin:<br/>Corrected implementation of door also for outside walls. This closes ticket <a href=\"https://github.com/RWTH-EBC/AixLib/issues/13\">issue 13</li>
<li><i>May 19, 2014&nbsp;</i> by Ana Constantin:<br/>Formatted documentation appropriately</li>
<li><i>May 02, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
<li><i>June 22, 2012&nbsp;</i> by Lukas Mencher:<br/>Outside wall may have a door now, icon adjusted</li>
<li><i>Mai 24, 2012&nbsp;</i> by Ana Constantin:<br/>Added inside surface orientation</li>
<li><i>April, 2012&nbsp;</i> by Mark Wesseling:<br/>Implemented.</li>
</ul></p>
</html>"));
    end Wall;

    package BaseClasses
      extends Modelica.Icons.BasesPackage;

      model SimpleNLayer "Wall consisting of n layers"

        parameter Modelica.SIunits.Height h=3 "Height"
          annotation (Dialog(group="Geometry"));
        parameter Modelica.SIunits.Length l=4 "Length"
          annotation (Dialog(group="Geometry"));

        parameter Integer n(min=1) = 8 "Number of layers"
          annotation (Dialog(group="Structure of wall layers"));
        parameter Modelica.SIunits.Thickness d[n]=fill(0.1, n) "Thickness"
          annotation (Dialog(group="Structure of wall layers"));
        parameter Modelica.SIunits.Density rho[n]=fill(1600, n) "Density"
          annotation (Dialog(group="Structure of wall layers"));
        parameter Modelica.SIunits.ThermalConductivity lambda[n]=fill(2.4, n)
          "Thermal conductivity"
          annotation (Dialog(group="Structure of wall layers"));
        parameter Modelica.SIunits.SpecificHeatCapacity c[n]=fill(1000, n)
          "Specific heat capacity"
          annotation (Dialog(group="Structure of wall layers"));

        parameter Modelica.SIunits.Temperature T0=Modelica.SIunits.Conversions.from_degC(16)
          "Initial temperature" annotation (Dialog(group="Thermal"));

        // 2n HeatConds
        Modelica.Thermal.HeatTransfer.Components.ThermalConductor HeatCondb[n](G=(h .*
              l .* lambda) ./ (d/2))    annotation (Placement(transformation(
                extent={{30,-28},{50,-8}}, rotation=0)));

        Modelica.Thermal.HeatTransfer.Components.ThermalConductor HeatConda[n](G=h
               .* l .* lambda ./ (d/2)) annotation (Placement(transformation(
                extent={{-52,-28},{-32,-8}}, rotation=0)));

        // n Loads
        Modelica.Thermal.HeatTransfer.Components.HeatCapacitor Load[n](
                   T(start=fill(T0, n)), C=c .* rho .* h .* l .* d)
                   annotation (Placement(transformation(extent={{-10,-60},{10,-40}},
                rotation=0)));

        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
          annotation (Placement(transformation(extent={{-100,-20},{-80,0}}),
              iconTransformation(extent={{-100,-20},{-80,0}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b
          annotation (Placement(transformation(extent={{80,-20},{100,0}}),
              iconTransformation(extent={{80,-20},{100,0}})));
      equation
        // connecting inner elements HeatCondb[i]--Load[i]--HeatConda[i] to n groups
        for i in 1:n loop
          connect(HeatConda[i].port_b, Load[i].port);
          connect(Load[i].port,HeatCondb [i].port_a);
        end for;

        // establishing n-1 connections of HeatCondb--Load--HeatConda groups
        for i in 1:(n - 1) loop
          connect(HeatCondb[i].port_b, HeatConda[i + 1].port_a);
        end for;

        // connecting outmost elements to connectors: port_a--HeatCondb[1]...HeatConda[n]--port_b
        connect(HeatConda[1].port_a, port_a);
        connect(HeatCondb[n].port_b, port_b);

        annotation (
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {100,100}}),       graphics={Rectangle(extent={{-80,60},{80,-100}},
                  lineColor={0,0,0})}),
          Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                             graphics={
            Rectangle(extent={{-80,60},{80,-100}}, lineColor={0,0,0}),
            Rectangle(
              extent={{-32,60},{32,-100}},
              lineColor={166,166,166},
              pattern=LinePattern.None,
              fillColor={190,190,190},
              fillPattern=FillPattern.Solid),
            Rectangle(extent={{-80,60},{80,-100}}, lineColor={135,135,135}),
            Rectangle(
              extent={{-48,60},{-32,-100}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={208,208,208},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-64,60},{-48,-100}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={190,190,190},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-80,60},{-64,-100}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={156,156,156},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{64,60},{80,-100}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={156,156,156},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{32,60},{48,-100}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={208,208,208},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{48,60},{64,-100}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={190,190,190},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{10,-36},{106,-110}},
              lineColor={0,0,0},
              textString="n")}),
          Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>The <b>SimpleNLayer</b> model represents a simple wall, consisting of n different layers. </p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<p><h4><font color=\"#008000\">Concept</font></h4></p>
<p>There is one inner and one outer <b><a href=\"Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a\">HeatPort</a></b>-connector to simulate one-dimensional heat transfer through the wall and heat storage within the wall.</p>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>HeatPort_a</code>, the last element represents the layer connected to <code>HeatPort_b</code>. </p>
</html>
",        revisions="<html>
<ul>
<li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
  <li><i>May 02, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
  <li><i>March 14, 2005&nbsp;</i>
         by Timo Haase:<br>
         Implemented.</li>
</ul>
</html>"));
      end SimpleNLayer;

      model ConvNLayerClearanceStar
        "Wall consisting of n layers, with convection on one surface and (window) clearance"

        parameter Modelica.SIunits.Height h=3 "Height"
          annotation (Dialog(group="Geometry"));
        parameter Modelica.SIunits.Length l=4 "Length"
          annotation (Dialog(group="Geometry"));
        parameter Modelica.SIunits.Area clearance=0 "Area of clearance"
          annotation (Dialog(group="Geometry"));

        parameter Boolean selectable=false
          "Determines if wall type is set manually (false) or by definitions (true)"
          annotation(Dialog(group="Structure of wall layers"));
        parameter DataBase.Walls.WallBaseDataDefinition wallType=
            DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S() "Type of wall"
          annotation (Dialog(group="Structure of wall layers", enable=
                selectable), choicesAllMatching=true);
        parameter Integer n(min=1) = (if selectable then wallType.n else 8)
          "Number of layers"
          annotation (Dialog(group="Structure of wall layers",enable=not selectable));
        parameter Modelica.SIunits.Thickness d[n]=(if selectable then wallType.d else fill(0.1, n))
          "Thickness"
          annotation (Dialog(group="Structure of wall layers",enable=not selectable));
        parameter Modelica.SIunits.Density rho[n]=(if selectable then wallType.rho else fill(1600, n))
          "Density"
          annotation (Dialog(group="Structure of wall layers",enable=not selectable));
        parameter Modelica.SIunits.ThermalConductivity lambda[n]=(if selectable then wallType.lambda else fill(2.4, n))
          "Thermal conductivity"
          annotation (Dialog(group="Structure of wall layers",enable=not selectable));
        parameter Modelica.SIunits.SpecificHeatCapacity c[n]=(if selectable then wallType.c else fill(1000, n))
          "Specific heat capacity"
          annotation (Dialog(group="Structure of wall layers",enable=not selectable));

        // which orientation of surface?
        parameter Integer surfaceOrientation = 1 "Surface orientation"
                       annotation(Dialog(descriptionLabel = true, enable = if IsAlphaConstant == true then false else true), choices(choice=1
              "vertical",                                                                                                  choice = 2
              "horizontal facing up",                                                                                                  choice = 3
              "horizontal facing down",                                                                                                  radioButtons = true));

        parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_custom=2
          "Constant heat transfer coefficient" annotation (Dialog(group="Convection",
              enable=(control_type == ct.custom)));

        parameter Modelica.SIunits.Emissivity eps=(if selectable then wallType.eps else 0.95)
          "Longwave emission coefficient" annotation (Dialog(group="Radiation"));
        parameter Modelica.SIunits.Temperature T0=Modelica.SIunits.Conversions.from_degC(16)
          "Initial temperature" annotation (Dialog(group="Thermal"));

        // 2n HeatConds
        Modelica.Thermal.HeatTransfer.Components.ThermalConductor HeatCondb[n](
          port_b(each T(start=T0)),
          port_a(each T(start=T0)),
          G=(A*lambda) ./ (d/2))    annotation (Placement(transformation(extent={
                  {8,-8},{28,12}}, rotation=0)));

        Modelica.Thermal.HeatTransfer.Components.ThermalConductor HeatConda[n](
          port_b(each T(start=T0)),
          port_a(each T(start=T0)),
          G=(A .* lambda) ./ (d/2)) annotation (Placement(transformation(extent={
                  {-50,-8},{-30,12}}, rotation=0)));

        // n Loads
        Modelica.Thermal.HeatTransfer.Components.HeatCapacitor Load[n](
                        T(start=fill(T0, n)), C=c .* rho .* A .* d)
                        annotation (Placement(transformation(extent={{-8,-62},{12,
                  -42}}, rotation=0)));

        Utilities.HeatTransfer.HeatConv_inside HeatConv1(
          port_b(T(start=T0)),
          alpha_custom=alpha_custom,
          A=A,
          surfaceOrientation=surfaceOrientation) annotation (Placement(
              transformation(
              origin={64,-2},
              extent={{-10,-10},{10,10}},
              rotation=180)));
        Utilities.Interfaces.Star Star annotation (Placement(
              transformation(extent={{80,50},{100,70}}, rotation=0)));
        Utilities.HeatTransfer.HeatToStar twoStar_RadEx(
          A=A,
          eps=eps,
          Therm(T(start=T0)),
          Star(T(start=T0))) annotation (Placement(transformation(extent=
                  {{54,30},{74,50}}, rotation=0)));

      protected
        parameter Modelica.SIunits.Area A=h*l - clearance;

      protected
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a dummyTherm
          "This really helps to solve initialisation problems in huge equation systems ..."
          annotation (Placement(transformation(extent={{49,-41},{54,-36}},
                rotation=0)));
      public
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
          annotation (Placement(transformation(extent={{-104,-8},{-84,12}}),
              iconTransformation(extent={{-100,-20},{-80,0}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b
          annotation (Placement(transformation(extent={{76,-8},{96,12}}),
              iconTransformation(extent={{80,-20},{100,0}})));
      equation

        // connecting inner elements HeatCondb[i]--Load[i]--HeatConda[i] to n groups
        for i in 1:n loop
          connect(HeatConda[i].port_b, Load[i].port) annotation (Line(points={{-30,
                  2},{-10,2},{-10,-62},{2,-62}}, color={200,100,0}));
          connect(Load[i].port,HeatCondb [i].port_a) annotation (Line(points={{2,
                  -62},{-10,-62},{-10,2},{8,2}}, color={200,100,0}));
        end for;

        // establishing n-1 connections of HeatCondb--Load--HeatConda groups
        for i in 1:(n - 1) loop
          connect(HeatCondb[i].port_b, HeatConda[i + 1].port_a);
        end for;

        // connecting outmost elements to connectors: port_a--HeatCondb[1]...HeatConda[n]--HeatConv1--port_b
        connect(HeatConda[1].port_a, port_a)
          annotation (Line(points={{-50,2},{-94,2}}, color={200,100,0}));
        connect(HeatConv1.port_a, port_b) annotation (Line(points={{74,-2},{84.5,
                -2},{84.5,2},{86,2}},                                     color={
                200,100,0}));
        connect(HeatCondb[n].port_b,HeatConv1.port_b)  annotation (Line(points={{28,2},{
                52,2},{52,-2},{54,-2}},                         color={200,100,0}));
        connect(HeatConv1.port_b, twoStar_RadEx.Therm) annotation (Line(points={{54,-2},
                {50,-2},{50,40},{54.8,40}},              color={200,100,0}));
        connect(twoStar_RadEx.Star, Star) annotation (Line(
            points={{73.1,40},{90,40},{90,60}},
            color={95,95,95},
            pattern=LinePattern.None));
        connect(HeatConv1.port_b, dummyTherm) annotation (Line(points={{54,-2},{
                51.5,-2},{51.5,-38.5}},                          color={200,100,0}));

        // computing approximated longwave radiation exchange

        annotation (
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {100,100}}),       graphics={Rectangle(extent={{-80,60},{80,-100}},
                  lineColor={0,0,0})}),
          Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics={
            Rectangle(extent={{-80,60},{80,-100}}, lineColor={0,0,0}),
            Rectangle(extent={{-80,60},{80,-100}}, lineColor={0,0,0}),
            Rectangle(extent={{-80,60},{80,-100}}, lineColor={0,0,0}),
            Rectangle(
              extent={{24,100},{80,-100}},
              lineColor={0,0,0},
              fillColor={211,243,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-56,100},{0,-100}},
              lineColor={166,166,166},
              pattern=LinePattern.None,
              fillColor={190,190,190},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-64,100},{-56,-100}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={208,208,208},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-72,100},{-64,-100}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={190,190,190},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-80,100},{-72,-100}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={156,156,156},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{0,100},{8,-100}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={208,208,208},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{16,100},{24,-100}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={156,156,156},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{8,100},{16,-100}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={190,190,190},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-80,-30},{80,-42}},
              lineColor={0,0,0},
              pattern=LinePattern.Dash,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-80,-32},{80,-39}},
              lineColor={0,0,0},
              pattern=LinePattern.Dash,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              textString="gap"),
            Text(
              extent={{-44,-40},{52,-114}},
              lineColor={0,0,0},
              textString="n")}),
          Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>The <b>ConvNLayerClearanceStar</b> model represents a wall, consisting of n different layers with natural convection on one side and (window) clearance.</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<p><h4><font color=\"#008000\">Concept</font></h4></p>
<p>There is one inner and one outer <b><a href=\"Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a\">HeatPort</a></b>-connector to simulate one-dimensional heat transfer through the wall and heat storage within the wall.</p>
<p>The <b>ConvNLayerClearanceStar</b> model extends the basic concept by adding the functionality of approximated longwave radiation exchange. Simply connect all radiation exchanging surfaces via their <b><a href=\"Modelica://AixLib.Utilities.Interfaces.Star\">Star</a></b>-connectors. </p>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>HeatPort_a</code>, the last element represents the layer connected to <code>HeatPort_b</code>. </p>
<p><h4><font color=\"#008000\">Example Results</font></h4></p>
<p>This model is part of <a href=\"AixLib.Building.Components.Walls.Wall\">Wall</a>  therefore also part of the corresponding examples <a href=\"AixLib.Building.Components.Examples.Walls.InsideWall\">InsideWall</a> and <a href=\"AixLib.Building.Components.Examples.Walls.OutsideWall\">OutsideWall</a>. </p>
</html>", revisions="<html>
<ul>
<li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
  <li><i>May 02, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
  <li><i>Aug. 08, 2006&nbsp;</i>
         by Peter Matthes:<br>
         Fixed wrong connection with heatConv-Module and added connection graphics.</li>
 
  <li><i>June 19, 2006&nbsp;</i>
         by Timo Haase:<br>
         Implemented.</li>
</ul>
</html>"));
      end ConvNLayerClearanceStar;
    end BaseClasses;
    annotation (Documentation(info="<html>
<p>
This package contains aggregated models for definition of walls.
</p>
 
<dl>
<dt><b>Main Author:</b>
<dd>Timo Haase <br>
    Technische Universtit&auml;t Berlin <br>
    Hermann-Rietschel-Institut <br>
    Marchstr. 4 <br> 
    D-10587 Berlin <br>
    e-mail: <a href=\"mailto:timo.haase@tu-berlin.de\">timo.haase@tu-berlin.de</a><br>
</dl>
<br>
 
</html>"));
  end Walls;

  package Weather
        extends Modelica.Icons.Package;

      model Weather "Complex weather model"

        parameter Modelica.SIunits.Conversions.NonSIunits.Angle_deg Latitude= 49.5
        "latitude of location"
          annotation (Dialog(group="Location Properties"));
        parameter Modelica.SIunits.Conversions.NonSIunits.Angle_deg Longitude = 8.5
        "longitude of location"
          annotation (Dialog(group="Location Properties"));
        parameter Modelica.SIunits.Conversions.NonSIunits.Time_hour
        DiffWeatherDataTime =                                                            1
        "difference between weather data time and UTC, e.g. +1 for CET"
          annotation (Dialog(group="Properties of Weather Data"));
        parameter Real GroundReflection=0.2 "ground reflection coefficient"
          annotation (Dialog(group="Location Properties"));

        parameter String tableName="wetter"
        "table name on file or in function usertab"
          annotation (Dialog(group="Properties of Weather Data"));
        parameter String fileName="modelica://AixLib/Resources/WeatherData/TRY2010_12_Jahr_Modelica-Library.txt"
        "file where matrix is stored"
          annotation (Dialog(group="Properties of Weather Data",
                               __Dymola_loadSelector(filter="Text files (*.txt);;Matlab files (*.mat)",
                               caption="Open file in which table is present")));
        parameter Real offset[:]={0} "offsets of output signals"
          annotation (Dialog(group="Properties of Weather Data"));
        parameter Modelica.Blocks.Types.Smoothness smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments
        "Smoothness of table interpolation"
         annotation (Dialog(group="Properties of Weather Data"));
        parameter Modelica.Blocks.Types.Extrapolation extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic
        "Extrapolation of data outside the definition range"
        annotation (Dialog(group="Properties of Weather Data"));
        parameter Real startTime[1]={0}
        "output = offset for time < startTime (same value for all columns)"
          annotation (Dialog(group="Properties of Weather Data"));

      parameter
        DataBase.Weather.SurfaceOrientation.SurfaceOrientationBaseDataDefinition
        SOD=
          DataBase.Weather.SurfaceOrientation.SurfaceOrientationData_N_E_S_W_Hor()
        "Surface orientation data" annotation (Dialog(group=
              "Solar radiation on oriented surfaces", descriptionLabel=true),
          choicesAllMatching=true);

      //   parameter Integer wdv_choice[:]={7,8,9,10,11,12,13,18,19} "<html><font size=2><table border=0 cellspacing=2>
      //         <tr width=100%>
      //             <td width=35%><b> 7 </b>- Cloud cover, 0..8; 9 </td>
      //             <td width=65%><b>12 </b>- Mass fraction of water in dry air, kg/kg </td>
      //         </tr><tr>
      //             <td><b> 8 </b>- Wind direction,  </td>
      //             <td><b>13 </b>- Relative humidity of air, 0..1 </td>
      //         </tr><tr>
      //             <td><b> 9 </b>- Wind speed, m/s </td>
      //             <td><b>18 </b>- Longwave sky radiation on horizontal </td>
      //         </tr><tr>
      //             <td></td><td> surface, W/m </td>
      //         </tr><tr>
      //             <td><b>10 </b>- Air temperature, C </td>
      //             <td><b>19 </b>- Longwave terrestric radiation from horizontal </td>
      //         </tr><tr>
      //             <td></td><td> surface, W/m </td>
      //         </tr><tr>
      //             <td><b>11 </b>- Air pressure, Pa </td>
      //         </tr><tr>
      //         </tr>
      //     </table></font></html>"
      //                       annotation (Dialog(group=
      //          "Weather Data Vector  -  choose output vector elements"));

      Utilities.Interfaces.SolarRad_out SolarRadiation_OrientedSurfaces[
        size(RadOnTiltedSurf, 1)] annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={50,98}), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-78,-110})));
       parameter Integer Outopt =  2 "Output options"
          annotation(Dialog(tab="Optional output vector", compact = true, descriptionLabel = true), choices(choice=1
            "one vector",                                                                                                  choice = 2
            "individual vectors",                                                                                                  radioButtons = true));

       parameter Boolean Cloud_cover=false "Cloud cover [-] (TRY col 7)"
        annotation (Dialog(tab="Optional output vector", descriptionLabel = true), choices(checkBox=true));
       parameter Boolean Wind_dir=false "Wind direction [deg] (TRY col 8)"
        annotation (Dialog(tab="Optional output vector", descriptionLabel = true), choices(checkBox=true));
       parameter Boolean Wind_speed=false "Wind speed [m/s]  (TRY col 9)"
        annotation (Dialog(tab="Optional output vector", descriptionLabel = true), choices(checkBox=true));
       parameter Boolean Air_temp=false "Air temperature [K] (TRY col 10)"
        annotation (Dialog(tab="Optional output vector", descriptionLabel = true), choices(checkBox=true));
       parameter Boolean Air_press=false "Air pressure [Pa] (TRY col 11)"
        annotation (Dialog(tab="Optional output vector", descriptionLabel = true), choices(checkBox=true));
       parameter Boolean Mass_frac=false
        "Mass fraction of water in dry air [kg/kg] (TRY col 12)"
        annotation (Dialog(tab="Optional output vector", descriptionLabel = true), choices(checkBox=true));
       parameter Boolean Rel_hum=false
        "Realtive humidity of air [-] (TRY col 13)"
        annotation (Dialog(tab="Optional output vector", descriptionLabel = true), choices(checkBox=true));
       parameter Boolean Sky_rad=false
        "Longwave sky radiation on horizontal [W/m2] (TRY col 18)"
        annotation (Dialog(tab="Optional output vector", descriptionLabel = true), choices(checkBox=true));
       parameter Boolean Ter_rad=false
        "Longwave terrestric radiation from horizontal [W/m2] (TRY col 19)"
        annotation (Dialog(tab="Optional output vector", descriptionLabel = true), choices(checkBox=true));

    protected
       parameter Integer m = BaseClasses.CalculateNrOfOutputs(
                                                  Cloud_cover, Wind_dir, Wind_speed, Air_temp, Air_press, Mass_frac, Rel_hum, Sky_rad, Ter_rad)
        "Number of choosen output variables";
       parameter Integer[9] PosWV = BaseClasses.DeterminePositionsInWeatherVector(
                                                                      Cloud_cover, Wind_dir, Wind_speed, Air_temp, Air_press, Mass_frac, Rel_hum, Sky_rad, Ter_rad)
        "Positions Weather Vector";
       parameter Integer columns[:]={16,15,7,8,9,10,11,12,13,18,19};

    public
        BaseClasses.Sun Sun(
        Longitude=Longitude,
        Latitude=Latitude,
        DiffWeatherDataTime=DiffWeatherDataTime) annotation (Placement(
            transformation(extent={{-62,18},{-38,42}}, rotation=0)));
        BaseClasses.RadOnTiltedSurf RadOnTiltedSurf[SOD.nSurfaces](
        each Latitude=Latitude,
        each GroundReflection=GroundReflection,
        Azimut=SOD.Azimut,
        Tilt=SOD.Tilt) annotation (Placement(transformation(extent={{-2,
                18},{22,42}}, rotation=0)));
        Modelica.Blocks.Sources.CombiTimeTable WeatherData(
          fileName=fileName,
          columns=columns,
          offset=offset,
          table=[0, 0; 1, 1],
          startTime=scalar(startTime),
          tableName=tableName,
          tableOnFile=(tableName) <> "NoName",
        smoothness=smoothness,
        extrapolation=extrapolation)
          annotation (Placement(transformation(extent={{-60,-70},{-40,-50}},
                rotation=0)));

        Modelica.Blocks.Routing.DeMultiplex3 deMultiplex(n3=9)
          annotation (Placement(transformation(extent={{-26,-70},{-6,-50}},
                rotation=0)));
        Modelica.Blocks.Interfaces.RealOutput WeatherDataVector[m] if Outopt == 1 and (Cloud_cover or Wind_dir or Wind_speed or Air_temp or Air_press or Mass_frac or Rel_hum or Sky_rad or Ter_rad)
          annotation (Placement(transformation(
              origin={-1,-110},
              extent={{-10,-10},{10,10}},
              rotation=270)));

        Modelica.Blocks.Interfaces.RealOutput CloudCover if Cloud_cover and Outopt == 2 "[0..8]"
                                                                                        annotation (Placement(
              transformation(extent={{114,74},{134,94}}), iconTransformation(extent={{150,110},
                {170,130}})));
        Modelica.Blocks.Interfaces.RealOutput WindDirection(unit = "deg") if Wind_dir and Outopt == 2
        "in deg [0...360]"
          annotation (Placement(transformation(extent={{126,52},{146,72}}),
              iconTransformation(extent={{150,80},{170,100}})));
        Modelica.Blocks.Interfaces.RealOutput WindSpeed(unit = "m/s") if Wind_speed and Outopt == 2 "in m/s"
                                                                                              annotation (
            Placement(transformation(extent={{126,32},{146,52}}), iconTransformation(
                extent={{150,50},{170,70}})));
        Modelica.Blocks.Interfaces.RealOutput AirTemp(unit = "K") if Air_temp and Outopt == 2
        "in Kelvin"                                                                           annotation (
            Placement(transformation(extent={{126,14},{146,34}}), iconTransformation(
                extent={{150,20},{170,40}})));
        Modelica.Blocks.Interfaces.RealOutput AirPressure(unit= "Pa") if Air_press and Outopt == 2 "in Pa"
                                                                                              annotation (
            Placement(transformation(extent={{126,-8},{146,12}}), iconTransformation(
                extent={{150,-10},{170,10}})));
        Modelica.Blocks.Interfaces.RealOutput WaterInAir if Mass_frac and Outopt == 2
        "in kg/kg"                                                                    annotation (Placement(
              transformation(extent={{126,-24},{146,-4}}), iconTransformation(extent={{150,-40},
                {170,-20}})));
        Modelica.Blocks.Interfaces.RealOutput RelHumidity if Rel_hum and Outopt == 2
        "in percent"                                                                 annotation (Placement(
              transformation(extent={{126,-42},{146,-22}}), iconTransformation(extent={{150,-70},
                {170,-50}})));
        Modelica.Blocks.Interfaces.RealOutput SkyRadiation(unit= "W/m2") if Sky_rad and Outopt == 2 "in W/m2"
          annotation (Placement(transformation(extent={{126,-62},{146,-42}}),
              iconTransformation(extent={{150,-100},{170,-80}})));
        Modelica.Blocks.Interfaces.RealOutput TerrestrialRadiation(unit = "W/m2") if Ter_rad and Outopt == 2 "in W/m2"
          annotation (Placement(transformation(extent={{126,-78},{146,-58}}),
              iconTransformation(extent={{150,-130},{170,-110}})));

        Modelica.Blocks.Math.Gain hPa_to_Pa(k=100) if Air_press
          annotation (Placement(transformation(extent={{26,-60},{36,-50}})));
        Modelica.Blocks.Math.Gain percent_to_unit(k=0.01) if Rel_hum
          annotation (Placement(transformation(extent={{26,-78},{36,-68}})));
        Modelica.Blocks.Math.Gain g_to_kg(k=0.001) if Mass_frac
          annotation (Placement(transformation(extent={{28,-96},{38,-86}})));
        Modelica.Blocks.Math.UnitConversions.From_degC from_degC if Air_temp
          annotation (Placement(transformation(extent={{26,-42},{36,-32}})));
      initial equation
        assert(SOD.nSurfaces==size(SOD.name,1),"name has to have the nSurfaces Elements (see Surface orientation data in the Weather Model)");
        assert(SOD.nSurfaces==size(SOD.Azimut,1),"Azimut has to have the nSurfaces Elements (see Surface orientation data in the Weather Model)");
        assert(SOD.nSurfaces==size(SOD.Tilt,1),"Tilt has to have the nSurfaces Elements (see Surface orientation data in the Weather Model)");
      equation
        // cloud cover
        if Cloud_cover then
          if Outopt == 1 then
           connect(WeatherDataVector[PosWV[1]], deMultiplex.y3[1]);
          else
           connect( CloudCover, deMultiplex.y3[1]);
          end if;
        end if;

         // wind direction
        if Wind_dir then
          if Outopt == 1 then
            connect(WeatherDataVector[PosWV[2]], deMultiplex.y3[2]);
          else
            connect(WindDirection, deMultiplex.y3[2]);
          end if;
        end if;

        // wind speed
        if Wind_speed then
         if Outopt == 1 then
            connect(WeatherDataVector[PosWV[3]], deMultiplex.y3[3]);
         else
           connect(WindSpeed, deMultiplex.y3[3]);
         end if;
        end if;

        // air temperature
        if Air_temp then
         if Outopt == 1 then
           connect(deMultiplex.y3[4], from_degC.u);
           connect(WeatherDataVector[PosWV[4]], from_degC.y);
         else
           connect(deMultiplex.y3[4], from_degC.u);
           connect(AirTemp, from_degC.y);
         end if;
        end if;

        // air pressure, conversion from hPa to Pa
        if Air_press then
          if Outopt == 1 then
            connect(deMultiplex.y3[5], hPa_to_Pa.u);
            connect( WeatherDataVector[PosWV[5]], hPa_to_Pa.y);
          else
            connect(deMultiplex.y3[5], hPa_to_Pa.u);
            connect(AirPressure, hPa_to_Pa.y);
          end if;
        end if;

        // mass fraction water in dry air, conversion from g/kg to kg/kg
        if Mass_frac then
          if Outopt == 1 then
            connect(deMultiplex.y3[6], g_to_kg.u);
            connect(WeatherDataVector[PosWV[6]], g_to_kg.y);
          else
           connect(deMultiplex.y3[6], g_to_kg.u);
           connect(WaterInAir, g_to_kg.y);
          end if;
        end if;

        // rel. humidity, conversion from % to 0..1
        if Rel_hum then
          if Outopt == 1 then
            connect(deMultiplex.y3[7], percent_to_unit.u);
            connect(WeatherDataVector[PosWV[7]], percent_to_unit.y);
          else
            connect(deMultiplex.y3[7], percent_to_unit.u);
            connect(RelHumidity, percent_to_unit.y);
          end if;
        end if;

        // longwave sky radiation
        if Sky_rad then
         if Outopt == 1 then
            connect(WeatherDataVector[PosWV[8]], deMultiplex.y3[8]);
         else
           connect(SkyRadiation, deMultiplex.y3[8]);
         end if;
        end if;

        // longwave terrestric radiation
        if Ter_rad then
          if Outopt == 1 then
            connect(WeatherDataVector[PosWV[9]], deMultiplex.y3[9]);
          else
            connect(TerrestrialRadiation, deMultiplex.y3[9]);
          end if;
        end if;

        connect(WeatherData.y, deMultiplex.u) annotation (Line(points={{-39,-60},{
                -28,-60}}, color={0,0,127}));

        // Connecting n RadOnTiltedSurf
        for i in 1:SOD.nSurfaces loop
          connect(Sun.OutHourAngleSun, RadOnTiltedSurf[i].InHourAngleSun);
          connect(Sun.OutDeclinationSun, RadOnTiltedSurf[i].InDeclinationSun);
          connect(Sun.OutAzimutSun, RadOnTiltedSurf[i].InAzimutSun);
          connect(deMultiplex.y1[1], RadOnTiltedSurf[i].InDiffRadHor);
          connect(deMultiplex.y2[1], RadOnTiltedSurf[i].InBeamRadHor);
        end for;

        connect(RadOnTiltedSurf.OutTotalRadTilted, SolarRadiation_OrientedSurfaces)
          annotation (Line(
            points={{20.8,27.6},{50.4,27.6},{50.4,98},{50,98}},
            color={255,128,0},
            smooth=Smooth.None));
          annotation (Dialog(group="Solar radiation on oriented surfaces"),
                    Dialog(tab="Optional output vector", descriptionLabel = true),
          Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-150,-100},
                {150,100}}),         graphics={
              Line(points={{-36,32},{-4,32}}, color={0,0,255}),
              Line(points={{-36,28},{-4,28}}, color={0,0,255}),
              Line(points={{-36,24},{-4,24}}, color={0,0,255}),
              Line(points={{5,13},{5,-53},{-3,-53}}, color={0,0,255}),
              Line(points={{15,14},{15,-60},{-3,-60}}, color={0,0,255})}),
          Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-150,-100},{
                150,100}}),  graphics={
            Rectangle(
              extent={{-150,78},{10,-82}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-150,78},{10,-72}},
              lineColor={0,0,0},
              pattern=LinePattern.None,
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={170,213,255}),
            Ellipse(
              extent={{-96,20},{-44,-32}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={255,225,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-150,-22},{10,-82}},
              lineColor={0,0,0},
              pattern=LinePattern.None,
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={0,127,0}),
            Rectangle(
              extent={{-150,-54},{10,-82}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={0,127,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-126,-32},{-118,-50}},
              lineColor={0,0,0},
              pattern=LinePattern.None,
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={180,90,0}),
            Ellipse(
              extent={{-134,-12},{-110,-36}},
              lineColor={0,0,0},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Sphere,
              fillColor={0,158,0}),
            Polygon(
              points={{-126,-50},{-138,-56},{-130,-56},{-118,-50},{-126,-50}},
              lineColor={0,0,0},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Sphere,
              fillColor={0,77,0}),
            Ellipse(
              extent={{-125,-54},{-150,-64}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={0,77,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-52,46},{-36,38}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={226,226,226},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-42,42},{-28,36}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={226,226,226},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-44,42},{-22,50}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={226,226,226},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-40,46},{-16,38}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={226,226,226},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-12,-10},{-2,-50}},
              lineColor={0,0,0},
              pattern=LinePattern.None,
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={226,226,226}),
            Line(points={{-8,-16},{-6,-16}}, color={0,0,0}),
            Line(points={{-8,-18},{-6,-18}}, color={0,0,0}),
            Line(points={{-8,-28},{-6,-28}}, color={0,0,0}),
            Line(points={{-8,-22},{-6,-22}}, color={0,0,0}),
            Line(points={{-8,-20},{-6,-20}}, color={0,0,0}),
            Line(points={{-8,-26},{-6,-26}}, color={0,0,0}),
            Line(points={{-8,-24},{-6,-24}}, color={0,0,0}),
            Line(points={{-8,-30},{-6,-30}}, color={0,0,0}),
            Line(points={{-8,-32},{-6,-32}}, color={0,0,0}),
            Line(points={{-8,-34},{-6,-34}}, color={0,0,0}),
            Line(points={{-8,-36},{-6,-36}}, color={0,0,0}),
            Line(points={{-8,-38},{-6,-38}}, color={0,0,0}),
            Line(points={{-8,-40},{-6,-40}}, color={0,0,0}),
            Line(
              points={{-7,-19},{-7,-47}},
              color={0,0,0},
              thickness=0.5),
            Line(
              points={{-7,-43},{-7,-47}},
              color={0,0,0},
              thickness=1),
            Text(
              extent={{-9,-11},{-5,-15}},
              lineColor={0,0,0},
              lineThickness=1,
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={226,226,226},
              textString="degC"),
            Text(
              extent={{-176,114},{24,74}},
              lineColor={0,0,255},
                textString="Weather"),
              Text(
                extent={{12,122},{150,110}},
                lineColor={0,0,255},     visible=  Cloud_cover,
              textString="Cloud cov.",
              horizontalAlignment=TextAlignment.Right),
              Text(
                extent={{10,64},{150,52}},
                lineColor={0,0,255},     visible=  Wind_speed,
              textString="Wind speed",
              horizontalAlignment=TextAlignment.Right),
              Text(
                extent={{10,94},{150,82}},
                lineColor={0,0,255},         visible=  Wind_dir,
              textString="Wind dir.",
              horizontalAlignment=TextAlignment.Right),
              Text(
                extent={{10,34},{150,22}},
                lineColor={0,0,255},          visible=  Air_temp,
              textString="Air temp.",
              horizontalAlignment=TextAlignment.Right),
              Text(
                extent={{10,6},{150,-6}},
                lineColor={0,0,255},       visible=  Air_press,
              textString="Air pressure",
              horizontalAlignment=TextAlignment.Right),
              Text(
                extent={{10,-26},{150,-38}},
                lineColor={0,0,255},       visible=  Mass_frac,
              textString="Water in air",
              horizontalAlignment=TextAlignment.Right),
              Text(
                extent={{10,-54},{150,-66}},
                lineColor={0,0,255},        visible=  Rel_hum,
              textString="Rel. humidity",
              horizontalAlignment=TextAlignment.Right),
              Text(
                extent={{10,-84},{150,-96}},
                lineColor={0,0,255},        visible=  Sky_rad,
              horizontalAlignment=TextAlignment.Right,
              textString="Sky rad."),
              Text(
                extent={{10,-114},{150,-126}},
                lineColor={0,0,255},                visible=  Ter_rad,
              horizontalAlignment=TextAlignment.Right,
              textString="Terrest. rad.")}),
          Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Supplies weather data using a TRY - data set. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>Input: a TRY data set in an accepted Modelica format (.mat, .txt, with header). The structure should be exactly the one of a TRY, status: TRY 2011.</p>
<p>Output: </p>
<ul>
<li>Total radiation on &QUOT;n&QUOT; oriented surfaces</li>
<li>Cloud cover</li>
<li>Wind direction</li>
<li>Wind speed</li>
<li>Air temperature</li>
<li>Air pressure</li>
<li>Mass fraction of water in dry air</li>
<li>Relative humidity</li>
<li>Long wave sky radiation on horizontal surface</li>
<li>Long wave terrestrial radiation from horizontal surface</li>
</ul>
<p>The outputs can be supplied individually or in one vector, with the exception of total solar radiation, which are always supplied separately in a vector. </p>
<h4><span style=\"color:#008000\">Known Limitations</span></h4>
<p>Be aware that the calculation of the total solar radiation may cause problems at simulation times close to sunset and sunrise. In this case, change the cut-off angles. refer to model <a href=\"Modelica://AixLib.Building.Components.Weather.BaseClasses.RadOnTiltedSurf\">RadOnTiltedSurf.</a></p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>DWD: TRYHandbuch.2011.DWD,2011</p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p><a href=\"Modelica://AixLib.Building.Components.Examples.Weather.WeatherModels\">Examples.Weather.WeatherModels</a> </p>
</html>", revisions="<html>
<ul>
  <li><i>May 02, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately, Rewarded 5*****!</li>
  <li><i>Mai 1, 2012&nbsp;</i>
         by Moritz Lauster and Ana Constantin:<br>
         Improved beyond belief.</li>
  <li><i>September 12, 2006&nbsp;</i>
         by Timo Haase:<br>
         Implemented.</li>
</ul>
</html>"),DymolaStoredErrors);
      end Weather;

    model Sunblind "Reduces beam at Imax"

     parameter Integer n=4 "Number of orientations";
     parameter Modelica.SIunits.TransmissionCoefficient gsunblind[n]={1,1,1,1}
        "Total energy transmittances if sunblind is closed";
     parameter Modelica.SIunits.RadiantEnergyFluenceRate Imax=100
        "Intensity at which the sunblind closes";

      Utilities.Interfaces.SolarRad_in Rad_In[n] annotation (Placement(
            transformation(extent={{-100,0},{-80,20}})));
      Utilities.Interfaces.SolarRad_out Rad_Out[n]
        annotation (Placement(transformation(extent={{80,0},{100,20}})));
      Modelica.Blocks.Interfaces.RealOutput sunblindonoff[n] annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={8,-100}), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={0,-90})));                               /*if OutputSunblind*/
    initial equation
      assert(n==size(gsunblind,1),"gsunblind has to have n elements");
    equation
       for i in 1:n loop
         if (Rad_In[i].I>Imax) then
           Rad_Out[i].I=Rad_In[i].I*gsunblind[i];
           sunblindonoff[i]=1-gsunblind[i];
         else
           Rad_Out[i].I=Rad_In[i].I;
           sunblindonoff[i]=0;
         end if;
         end for;
                annotation (Diagram(graphics), Icon(graphics={
            Rectangle(
              extent={{-80,80},{80,-80}},
              lineColor={0,0,0},
              fillColor={87,205,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-80,80},{80,66}},
              lineColor={0,0,0},
              fillColor={135,135,135},
              fillPattern=FillPattern.HorizontalCylinder),
            Ellipse(
              extent={{-36,44},{36,-22}},
              lineColor={255,255,0},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-80,16},{80,2}},
              lineColor={0,0,0},
              fillColor={135,135,135},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-80,32},{80,18}},
              lineColor={0,0,0},
              fillColor={135,135,135},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-80,48},{80,34}},
              lineColor={0,0,0},
              fillColor={135,135,135},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-80,64},{80,50}},
              lineColor={0,0,0},
              fillColor={135,135,135},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-80,80},{-76,2}},
              lineColor={0,0,0},
              fillPattern=FillPattern.Solid,
              fillColor={0,0,0}),
            Rectangle(
              extent={{76,80},{80,2}},
              lineColor={0,0,0},
              fillPattern=FillPattern.Solid,
              fillColor={0,0,0}),
            Rectangle(
              extent={{-56,-14},{-54,-44}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-59,-17},{-55,-9},{-51,-17}},
              color={0,0,0},
              smooth=Smooth.None,
              thickness=1),
            Line(
              points={{-51,-41},{-55,-49},{-59,-41}},
              color={0,0,0},
              smooth=Smooth.None,
              thickness=1),
            Rectangle(
              extent={{-76,-64},{76,-76}},
              lineColor={0,127,0},
              fillColor={0,127,0},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-70,-56},{-12,-70}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              textString="Imax"),
            Rectangle(
              extent={{-2,80},{2,-80}},
              lineColor={0,0,0},
              fillPattern=FillPattern.Solid,
              fillColor={0,0,0},
              origin={0,-78},
              rotation=-90),
            Rectangle(
              extent={{-80,2},{-76,-76}},
              lineColor={0,0,0},
              fillPattern=FillPattern.Solid,
              fillColor={0,0,0}),
            Rectangle(
              extent={{76,2},{80,-76}},
              lineColor={0,0,0},
              fillPattern=FillPattern.Solid,
              fillColor={0,0,0}),
            Rectangle(
              extent={{-2,80},{2,-80}},
              lineColor={0,0,0},
              fillPattern=FillPattern.Solid,
              fillColor={0,0,0},
              origin={0,78},
              rotation=-90),
            Rectangle(
              extent={{46,-52},{52,-64}},
              lineColor={144,72,0},
              fillColor={144,72,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{42,-38},{56,-54}},
              lineColor={0,127,0},
              fillColor={0,127,0},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>This model represents a sunblind to reduce the vectorial radiance on facades, windows. etc. </p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<p><h4><font color=\"#008000\">Concept</font></h4></p>
<p><ul>
<li>You can define the amount of radiance hitting the facade with gsunblind, which states how much radiance goes through the closed sunblind</li>
<li>At which amount of radiance the sunblind will be closed is defined by Imax. Each directon is independent from all other directions and closes/opens seperately due to the radiance hitting the direction.</li>
<li>The output sunblindonoff can be used to transfer the state of the shading to another model component. It contains 1-gsunblind, which is the amount of radiances, detained by the shading.</li>
</ul></p>
<p><h4><font color=\"#008000\">Assumptions</font></h4></p>
<p>Each direction closes seperatly, which means that in reality each direction has to have his own sensor. It seems, that if a building uses automatic shading, the sensor is on the roof and computes the radiance on each facade. This is quite similar to the concept of different sensors for different directions, as both systems close the sunblinds seperately for each direction.</p>
<p>There is no possibilty to disable the sunblind in a specific direction. This isn&apos;t necessary, as you can set gsunblind in this direction to 1, which means, that the whole radiance is passing through the closed sunblind.</p>
<p><h4><font color=\"#008000\">Example Results</font></h4></p>
<p>This model is part of <a href=\"AixLib.Building.Components.Walls.Wall\">Wall</a> and checked in the Examples <a href=\"AixLib.Building.Components.Examples.Walls.InsideWall\">InsideWall</a> and <a href=\"AixLib.Building.Components.Examples.Walls.OutsideWall\">OutsideWall</a>. </p>
</html>",   revisions="<html>
<p><ul>
<li><i>May 02, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
<li><i>January 2012,&nbsp;</i> by Moritz Lauster:<br/>Implemented.</li>
</ul></p>
</html>"));
    end Sunblind;

    package BaseClasses

        model Sun "Solar radiation model"

        import Modelica.SIunits.Conversions.from_deg;
        import Modelica.SIunits.Conversions.to_deg;
          parameter Modelica.SIunits.Conversions.NonSIunits.Angle_deg Latitude
          "latitude of location";
          parameter Modelica.SIunits.Conversions.NonSIunits.Angle_deg Longitude
          "longitude of location in";
          parameter Modelica.SIunits.Conversions.NonSIunits.Time_hour
          DiffWeatherDataTime
          "difference between local time and UTC, e.g. +1 for MET";

          Real NumberOfDay;
          Real AzimutSun;
          Real ElevationSun;

          Modelica.Blocks.Interfaces.RealOutput OutHourAngleSun
            annotation (Placement(transformation(extent={{80,10},{100,30}}, rotation=
                    0)));
          Modelica.Blocks.Interfaces.RealOutput OutDeclinationSun
            annotation (Placement(transformation(extent={{80,-30},{100,-10}},
                  rotation=0)));
          Modelica.Blocks.Interfaces.RealOutput OutAzimutSun
            annotation (Placement(transformation(extent={{80,-70},{100,-50}},
                  rotation=0)));
      protected
          Real DeclinationSun;
          Real HourAngleSun;
          Real TimeEquation;
          Real DayAngleSun;
          Real ArgACOS(min=-1, max=1)
          "helper variable to protect 'acos' from Arguments > 1";

        equation
          // number of day: 1 = Jan 1st
          NumberOfDay = time/86400 + 1;

          // day angle of sun
          DayAngleSun = 360/365.25*(NumberOfDay - 1);

          // equation of time in hours - used to convert local time in solar time
          TimeEquation = -0.128*sin(from_deg(
            DayAngleSun - 2.8)) - 0.165*sin(
            from_deg(2*DayAngleSun + 19.7));

          // hour angle of sun, first term calculates local time of day from continuous time signal
          HourAngleSun = 15*(mod(time/3600, 24) - DiffWeatherDataTime +
            TimeEquation + Longitude/15 - 12);
          if (HourAngleSun > 180) then
            OutHourAngleSun = HourAngleSun - 360;
          elseif (HourAngleSun < -180) then
            OutHourAngleSun = HourAngleSun + 360;
          else
            OutHourAngleSun = HourAngleSun;
          end if;

          // declination of sun
          DeclinationSun = noEvent(to_deg(
            asin(0.3978*sin(from_deg(
            DayAngleSun - 80.2 + 1.92*sin(
            from_deg(DayAngleSun - 2.8)))))));
          OutDeclinationSun = DeclinationSun;

          // elevation of sun over horizon
          ElevationSun = noEvent(to_deg(asin(
            cos(from_deg(DeclinationSun))*cos(
            from_deg(OutHourAngleSun))*cos(
            from_deg(Latitude)) + sin(
            from_deg(DeclinationSun))*sin(
            from_deg(Latitude)))));

          // azimut of sun
          // AzimutSun = noEvent(to_deg(arctan((cos(from_deg(DeclinationSun))*sin(from_deg(
          //   OutHourAngleSun)))/(cos(from_deg(DeclinationSun))*cos(from_deg(
          //   OutHourAngleSun))*sin(from_deg(Latitude)) - sin(from_deg(
          //   DeclinationSun))*cos(from_deg(Latitude))))));
          ArgACOS = (sin(from_deg(ElevationSun))
            *sin(from_deg(Latitude)) - sin(
            from_deg(DeclinationSun)))/(cos(
            from_deg(ElevationSun))*cos(
            from_deg(Latitude)));
          AzimutSun = to_deg(acos(if noEvent(
            ArgACOS > 1) then 1 else (if noEvent(ArgACOS < -1) then -1 else ArgACOS)));
          if AzimutSun >= 0 then
            OutAzimutSun = 180 - AzimutSun;
          else
            OutAzimutSun = 180 + AzimutSun;
          end if;

        algorithm
          // correcting azimut calculation for output
          // OutAzimutSun := AzimutSun;
          // while (OutAzimutSun < 0) loop
          //   OutAzimutSun := OutAzimutSun + 180;
          // end while;

          annotation (
            Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {100,100}}), graphics={
              Rectangle(
                extent={{-80,60},{80,-100}},
                lineColor={0,0,0},
                pattern=LinePattern.None,
                fillPattern=FillPattern.HorizontalCylinder,
                fillColor={170,213,255}),
              Ellipse(
                extent={{-50,30},{50,-70}},
                lineColor={255,255,0},
                lineThickness=0.5,
                fillColor={255,255,0},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-100,100},{100,60}},
                lineColor={0,0,255},
                textString="%name")}),
            DymolaStoredErrors,
            Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}), graphics={Rectangle(
                  extent={{-80,60},{80,-100}},
                  lineColor={0,0,0},
                  pattern=LinePattern.None,
                  fillPattern=FillPattern.HorizontalCylinder,
                  fillColor={170,213,255}), Ellipse(
                  extent={{-50,30},{50,-70}},
                  lineColor={255,255,0},
                  lineThickness=0.5,
                  fillColor={255,255,0},
                  fillPattern=FillPattern.Solid)}),
            Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>The <b>Sun</b> model computes the hour angle, the declination and the azimut of the sun for a given set of geographic position and local time. </p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<p><h4><font color=\"#008000\">Concept</font></h4></p>
<p>The model needs information on the difference between the local time zone (corresponding to the time basis of the simulation) and UTC (universal time coordinated) in hours. The ouput data of the <b>Sun</b> model is yet not very useful itself, but it is most commonly used as input data for e.g. <b><a href=\"RadOnTiltedSurf\">RadOnTiltedSurf</a></b> models to compute the solar radiance according to the azimut of a surface. </p>
<p><h4><font color=\"#008000\">Example Results</font></h4></p>
<p>The model is checked within the <a href=\"AixLib.Building.Components.Examples.Weather.WeatherModels\">weather</a> example as part of the <a href=\"AixLib.Building.Components.Weather.Weather\">weather</a> model. </p>
</html>",   revisions="<html>
<ul>
  <li><i>May 02, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
  <li><i>September 29, 2006&nbsp;</i>
         by Peter Matthes:<br>
         Included ArgACOS variable to protect acos function from arguments &gt; 1. Added protection for some variables.</li>
  <li><i>March 14, 2005&nbsp;</i>
         by Timo Haase:<br>
         Implemented.</li>
</ul>
</html>"));
        end Sun;
      extends Modelica.Icons.BasesPackage;

        model RadOnTiltedSurf "Compute radiation on tilted surface"

        import Modelica.SIunits.Conversions.from_deg;
          parameter Modelica.SIunits.Conversions.NonSIunits.Angle_deg Latitude = 52.517
          "latitude of location";
          parameter Modelica.SIunits.Conversions.NonSIunits.Angle_deg Azimut = 13.400
          "azimut of tilted surface, e.g. 0=south, 90=west, 180=north, -90=east";
          parameter Modelica.SIunits.Conversions.NonSIunits.Angle_deg Tilt = 90
          "tilt of surface, e.g. 0=horizontal surface, 90=vertical surface";
          parameter Real GroundReflection=0.2 "ground reflection coefficient";

          Real cos_theta;
          Real cos_theta_help;
          Real cos_theta_z;
          Real cos_theta_z_help;
          Real R;
          Real R_help;
          Real term;

          Modelica.Blocks.Interfaces.RealInput InHourAngleSun
                                 annotation (Placement(transformation(extent={{-100,
                    10},{-80,30}}, rotation=0)));
          Modelica.Blocks.Interfaces.RealInput InDeclinationSun
                                 annotation (Placement(transformation(extent={{-100,
                    -30},{-80,-10}}, rotation=0)));
          Modelica.Blocks.Interfaces.RealInput InAzimutSun
                                 annotation (Placement(transformation(extent={{-100,
                    -70},{-80,-50}}, rotation=0)));
          Modelica.Blocks.Interfaces.RealInput InDiffRadHor
            annotation (Placement(transformation(
                origin={-40,-110},
                extent={{-10,-10},{10,10}},
                rotation=90)));
          Modelica.Blocks.Interfaces.RealInput InBeamRadHor
            annotation (Placement(transformation(
                origin={40,-110},
                extent={{-10,-10},{10,10}},
                rotation=90)));
        Utilities.Interfaces.SolarRad_out OutTotalRadTilted annotation (
            Placement(transformation(extent={{80,-30},{100,-10}},
                rotation=0)));

        equation
          // calculation of cos_theta_z [Duffie/Beckman, p.15], cos_theta_z is manually cut at 0 (no neg. values)
          cos_theta_z_help = sin(from_deg(InDeclinationSun))*sin(from_deg(
            Latitude)) + cos(from_deg(InDeclinationSun))*cos(from_deg(Latitude))*
            cos(from_deg(InHourAngleSun));
          cos_theta_z = (cos_theta_z_help + abs(cos_theta_z_help))/2;

          // calculation of cos_theta [Duffie/Beckman, p.15], cos_theta is manually cut at 0 (no neg. values)
          term = cos(from_deg(InDeclinationSun))*sin(from_deg(Tilt))*sin(from_deg(
            Azimut))*sin(from_deg(InHourAngleSun));
          cos_theta_help = sin(from_deg(InDeclinationSun))*sin(from_deg(Latitude))
            *cos(from_deg(Tilt)) - sin(from_deg(InDeclinationSun))*cos(from_deg(
            Latitude))*sin(from_deg(Tilt))*cos(from_deg(Azimut)) + cos(from_deg(
            InDeclinationSun))*cos(from_deg(Latitude))*cos(from_deg(Tilt))*cos(
            from_deg(InHourAngleSun)) + cos(from_deg(InDeclinationSun))*sin(
            from_deg(Latitude))*sin(from_deg(Tilt))*cos(from_deg(Azimut))*cos(
            from_deg(InHourAngleSun)) + term;
          cos_theta = (cos_theta_help + abs(cos_theta_help))/2;

          // calculation of R factor [Duffie/Beckman, p.25], due to numerical problems (cos_theta_z in denominator)
          // R is manually set to 0 for theta_z >= 80° (-> 90° means sunset)
          if noEvent(cos_theta_z <= 0.17365) then
            R_help = cos_theta_z*cos_theta;

          else
            R_help = cos_theta/cos_theta_z;

          end if;

          R = R_help;

          // calculation of total radiation on tilted surface according to model of Liu and Jordan
          // according to [Dissertation Nytsch-Geusen, p.98]
          OutTotalRadTilted.I = max(0, R*InBeamRadHor + 0.5*(1 + cos(from_deg(
            Tilt)))*InDiffRadHor + GroundReflection*(InBeamRadHor + InDiffRadHor)
            *((1 - cos(from_deg(Tilt)))/2));

          annotation (
            Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {100,100}}), graphics={
              Rectangle(
                extent={{-80,60},{80,-100}},
                lineColor={0,0,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-80,60},{80,-100}},
                lineColor={0,0,0},
                pattern=LinePattern.None,
                fillPattern=FillPattern.HorizontalCylinder,
                fillColor={170,213,255}),
              Ellipse(
                extent={{14,36},{66,-16}},
                lineColor={0,0,255},
                pattern=LinePattern.None,
                fillColor={255,225,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-80,-40},{80,-100}},
                lineColor={0,0,0},
                pattern=LinePattern.None,
                fillPattern=FillPattern.HorizontalCylinder,
                fillColor={0,127,0}),
              Rectangle(
                extent={{-80,-72},{80,-100}},
                lineColor={0,0,255},
                pattern=LinePattern.None,
                fillColor={0,127,0},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{-60,-64},{-22,-76},{-22,-32},{-60,-24},{-60,-64}},
                lineColor={0,0,0},
                fillPattern=FillPattern.VerticalCylinder,
                fillColor={226,226,226}),
              Polygon(
                points={{-60,-64},{-80,-72},{-80,-100},{-60,-100},{-22,-76},{-60,
                    -64}},
                lineColor={0,0,0},
                pattern=LinePattern.None,
                fillPattern=FillPattern.VerticalCylinder,
                fillColor={0,77,0}),
              Text(
                extent={{-100,100},{100,60}},
                lineColor={0,0,255},
                textString="%name")}),
            DymolaStoredErrors,
            Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}), graphics={
                Rectangle(
                  extent={{-80,60},{80,-100}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{-80,60},{80,-100}},
                  lineColor={0,0,0},
                  pattern=LinePattern.None,
                  fillPattern=FillPattern.HorizontalCylinder,
                  fillColor={170,213,255}),
                Ellipse(
                  extent={{14,36},{66,-16}},
                  lineColor={0,0,255},
                  pattern=LinePattern.None,
                  fillColor={255,225,0},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{-80,-40},{80,-100}},
                  lineColor={0,0,0},
                  pattern=LinePattern.None,
                  fillPattern=FillPattern.HorizontalCylinder,
                  fillColor={0,127,0}),
                Rectangle(
                  extent={{-80,-72},{80,-100}},
                  lineColor={0,0,255},
                  pattern=LinePattern.None,
                  fillColor={0,127,0},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{-60,-64},{-22,-76},{-22,-32},{-60,-24},{-60,-64}},
                  lineColor={0,0,0},
                  fillPattern=FillPattern.VerticalCylinder,
                  fillColor={226,226,226}),
                Polygon(
                  points={{-60,-64},{-80,-72},{-80,-100},{-60,-100},{-22,-76},{-60,
                      -64}},
                  lineColor={0,0,0},
                  pattern=LinePattern.None,
                  fillPattern=FillPattern.VerticalCylinder,
                  fillColor={0,77,0})}),
            Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>
The <b>RadOnTiltedSurf</b> model calculates the total radiance on a tilted surface.
</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<p><h4><font color=\"#008000\">Concept</font></h4></p>
<p>
The <b>RadOnTiltedSurf</b> model uses output data of the <a href=\"Sun\"><b>Sun</b></a> model and weather data (beam and diffuse radiance on a horizontal surface) to compute total radiance on a tilted surface. It needs information on the tilt angle and the azimut angle of the surface, the latitude of the location and the ground reflection coefficient.
</p>
<p><h4><font color=\"#008000\">Example Results</font></h4></p>
<p>The model is checked within the <a href=\"AixLib.Building.Components.Examples.Weather.WeatherModels\">weather</a> example as part of the <a href=\"AixLib.Building.Components.Weather.Weather\">weather</a> model. </p>
</html>",   revisions="<html>
<ul>
  <li><i>May 02, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
  <li><i>March 14, 2005&nbsp;</i>
         by Timo Haase:<br>
         Implemented.</li>
</ul>
</html>"));
        end RadOnTiltedSurf;

      function CalculateNrOfOutputs "Calculates number of outputs"
        input Boolean Cloud_cover "Cloud cover";
        input Boolean Wind_dir "Wind direction";
        input Boolean Wind_speed "Wind speed";
        input Boolean Air_temp "Air temperature";
        input Boolean Air_press "Air pressure";
        input Boolean Mass_frac "Mass fraction of water in dry air";
        input Boolean Rel_hum "Relative humidity";
        input Boolean Sky_rad
          "Long wave radiation of the sky on horizontal surface";
        input Boolean Ter_rad
          "Long wave terrestrial radiation from horizontal surface";

        output Integer m "Number of Outputs";

      algorithm
        m :=0;

        if Cloud_cover then
          m :=m + 1;
        end if;

        if Wind_dir then
          m :=m + 1;
        end if;

        if Wind_speed then
          m :=m + 1;
        end if;

        if Air_temp then
          m :=m + 1;
        end if;

        if Air_press then
          m :=m + 1;
        end if;

        if Mass_frac then
          m :=m + 1;
        end if;

        if Rel_hum then
          m :=m + 1;
        end if;

        if Sky_rad then
          m :=m + 1;
        end if;

        if Ter_rad then
          m :=m + 1;
        end if;

        annotation (Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Calculates the number of outputs based on the given inputs. </p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
</html>",       revisions="<html>
<p><ul>
<li><i>May 02, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately, added descriptions for variables</li>
</ul></p>
</html>"));
      end CalculateNrOfOutputs;

      function DeterminePositionsInWeatherVector
        "Determines position in weather vector"

        input Boolean Cloud_cover "Cloud cover";
        input Boolean Wind_dir "Wind direction";
        input Boolean Wind_speed "Wind speed";
        input Boolean Air_temp "Air temperature";
        input Boolean Air_press "Air pressure";
        input Boolean Mass_frac "Mass fraction of water in dry air";
        input Boolean Rel_hum "Relative humidity";
        input Boolean Sky_rad "Long wave sky radiation on horizontal surface";
        input Boolean Ter_rad
          "Long Wave terrestrial radiation from horizontal surface";

        output Integer[9] PosWV = fill(0, 9)
          "Determined postition in weather data vector";
      protected
        Integer m;

      algorithm
        m :=1;

        if Cloud_cover then
          PosWV[1] :=m;
          m :=m + 1;
        end if;

        if Wind_dir then
          PosWV[2] :=m;
          m :=m + 1;
        end if;

        if Wind_speed then
          PosWV[3] :=m;
          m :=m + 1;
        end if;

        if Air_temp then
          PosWV[4] :=m;
          m :=m + 1;
        end if;

        if Air_press then
          PosWV[5] :=m;
          m :=m + 1;
        end if;

        if Mass_frac then
          PosWV[6] :=m;
          m :=m + 1;
        end if;

        if Rel_hum then
          PosWV[7] :=m;
          m :=m + 1;
        end if;

        if Sky_rad then
          PosWV[8] :=m;
          m :=m + 1;
        end if;

        if Ter_rad then
          PosWV[9] :=m;
          m :=m + 1;
        end if;

        annotation (Documentation(revisions="<html>
<p><ul>
<li><i>May 02, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately, added variable descriptions</li>
</ul></p>
</html>",       info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Determines the position of the given input(s) in the weather vector of the <a href=\"Building.Components.Weather.Weather\">weather</a> model. </p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
</html>"));
      end DeterminePositionsInWeatherVector;
    end BaseClasses;
  end Weather;

  package WindowsDoors "Models for windows and doors "
        extends Modelica.Icons.Package;

        model Door "Simple door"

          parameter Modelica.SIunits.Area door_area=2 "Total door area"
            annotation (Dialog(group="Geometry"));

          parameter Modelica.SIunits.CoefficientOfHeatTransfer U=1.8
        "Thermal transmission coefficient"
            annotation (Dialog(group="Properties"));
          parameter Modelica.SIunits.Temperature T0=Modelica.SIunits.Conversions.from_degC(20)
        "Initial temperature" annotation (Dialog(group="Properties"));
          parameter Modelica.SIunits.Emissivity eps = 0.9
        "Emissivity of door material"
        annotation (Dialog(group="Properties"));

      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
        annotation (
          Placement(transformation(extent={{-100,-10},{-80,10}}, rotation=0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b
        annotation (
          Placement(transformation(extent={{80,-10},{100,10}}, rotation=0)));
      Utilities.HeatTransfer.HeatToStar twoStar_RadEx(
        Therm(T(start=T0)),
        Star(T(start=T0)),
        A=door_area,
        eps=eps) annotation (Placement(transformation(extent={{30,50},{50,
                70}}, rotation=0)));
      Utilities.Interfaces.Star Star annotation (Placement(transformation(
              extent={{80,50},{100,70}}, rotation=0)));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor HeatTrans(
          G =                                                               (
            door_area)*(U)) annotation (Placement(transformation(extent={{-10,-8},
                {10,12}}, rotation=0)));

      Utilities.HeatTransfer.HeatToStar twoStar_RadEx1(
        Therm(T(start=T0)),
        Star(T(start=T0)),
        A=door_area,
        eps=eps) annotation (Placement(transformation(extent={{-32,50},{-52,
                70}}, rotation=0)));
      Utilities.Interfaces.Star Star1 annotation (Placement(
            transformation(extent={{-100,50},{-80,70}}, rotation=0)));
        equation

          connect(twoStar_RadEx.Star, Star)
            annotation (Line(points={{49.1,60},{90,60}}, pattern=LinePattern.None));
      connect(port_a, HeatTrans.port_a)
        annotation (Line(points={{-90,0},{-49.5,0},{-49.5,2},{-10,2}}));
      connect(HeatTrans.port_b, port_b)
        annotation (Line(points={{10,2},{49.5,2},{49.5,0},{90,0}}));
          connect(twoStar_RadEx.Therm,HeatTrans.port_b)  annotation (Line(
              points={{30.8,60},{20,60},{20,2},{10,2}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(twoStar_RadEx1.Therm,HeatTrans.port_a)  annotation (Line(
              points={{-32.8,60},{-20,60},{-20,2},{-10,2}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(twoStar_RadEx1.Star, Star1) annotation (Line(
              points={{-51.1,60},{-90,60}},
              color={95,95,95},
              pattern=LinePattern.None,
              smooth=Smooth.None));
         annotation (Dialog(group="Air exchange"),
            Icon(coordinateSystem(
                preserveAspectRatio=true,
                extent={{-100,-100},{100,100}},
                grid={2,2}), graphics={
              Line(
                points={{-40,18},{-36,18}},
                color={255,255,0},
                smooth=Smooth.None),
              Rectangle(extent={{-52,82},{48,-78}}, lineColor={0,0,0},
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-46,76},{40,-68}},
                lineColor={0,0,0},
                fillPattern=FillPattern.Solid,
                fillColor={127,0,0}),
              Rectangle(
                extent={{28,12},{36,0}},
                lineColor={0,0,0},
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid)}),
            Window(
              x=0.26,
              y=0.21,
              width=0.49,
              height=0.55),
            Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>The<b> Door</b> model models </p>
<ul>
<li>the conductive heat transfer through the door with a U-Value is set to 1.8 W/(m&sup2;K) (EnEV2009)</li>
<li>the radiative heat transfer on both sides</li>
</ul>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Assumptions</span></h4>
<ul>
<li>Constant U-value.</li>
</ul>
<h4><span style=\"color:#008000\">References/ U-values special doors</span></h4>
<ul>
<li>Doors of wood or plastic 40 mm: 2,2 W/(m&sup2;K)</li>
<li>Doors of wood 60 mm: 1,7 W/(m&sup2;K)</li>
<li>Doors of wood with glass:</li>
<li>7 mm wired glass: 4,5 W/(m&sup2;K)</li>
<li>20 mm insulated glass: 2,8 W/(m&sup2;K) </li>
</ul>
<p>- Doors with a frame of light metal and with glass:</p>
<ul>
<li>7 mm wired glass: 5,5 W/(m&sup2;K)</li>
<li>20 mm insulated glass: 3,5 W/(m&sup2;K) </li>
</ul>
<p>- Doors of wood or plastic for new building (standard construction): 1,6 W/(m&sup2;K)</p>
<p>- insulated doors of wood or plastic with triplex glass: 0,7 W/(m&sup2;K)</p>
<p>Reference:[Hessisches Ministerium f&uuml;r Umwelt 2011] UMWELT, Energie Landwirtschaft und V. f.: Energieeinsparung</p>
<p>an Fenstern und Au&szlig;entueren. Version: 2011. www.hmuelv.hessen.de, p.10</p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p><a href=\"AixLib.Building.Components.Examples.WindowsDoors.DoorSimple\">AixLib.Building.Examples.WindowsDoors.DoorSimple </a></p>
</html>",revisions="<html>
<ul>
<li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
  <li><i>May 02, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
  <li><i>March 30, 2012&nbsp;</i>
         by Corinna Leonhardt and Ana Constantin:<br>
         Implemented.</li>
</ul>
</html>"),  Diagram(coordinateSystem(
                preserveAspectRatio=false,
                extent={{-100,-100},{100,100}},
                grid={2,2}), graphics={Rectangle(extent={{-80,80},{80,-80}},
                    lineColor={0,0,0})}),
            DymolaStoredErrors);
        end Door;

        model WindowSimple "Window with radiation and U-Value"

        //  parameter Modelica.SIunits.Area windowarea=2 "Total fenestration area";
          parameter Real windowarea=2 "Total fenestration area";
            parameter Modelica.SIunits.Temperature T0= 293.15
        "Initial temperature";
          parameter Boolean selectable = true "Select window type" annotation (Dialog(group="Window type", descriptionLabel = true));
      parameter DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple
        WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009()
        "Window type" annotation (Dialog(
          group="Window type",
          enable=selectable,
          descriptionLabel=true));
          parameter Real frameFraction(max=1.0) = if selectable then WindowType.frameFraction else 0.2
        "Frame fraction" annotation (Dialog(
          group="Window type",
          enable=not selectable,
          descriptionLabel=true));
          parameter Modelica.SIunits.CoefficientOfHeatTransfer Uw=if selectable then WindowType.Uw else 1.50
        "Thermal transmission coefficient of whole window"
        annotation (Dialog(group="Window type", enable=not selectable));

          parameter Real g= if selectable then WindowType.g else 0.60
        "Coefficient of solar energy transmission"
        annotation (Dialog(group="Window type", enable=not selectable));

      Utilities.Interfaces.SolarRad_in solarRad_in annotation (Placement(
            transformation(extent={{-100,50},{-80,70}}, rotation=0)));
      Utilities.HeatTransfer.SolarRadToHeat RadCondAdapt(coeff=g, A=
            windowarea*(1 - frameFraction)) annotation (Placement(
            transformation(extent={{-50,52},{-30,72}}, rotation=0)));
      Utilities.HeatTransfer.HeatToStar twoStar_RadEx(
        Therm(T(start=T0)),
        Star(T(start=T0)),
        A=(1 - frameFraction)*windowarea,
        eps=WindowType.Emissivity) annotation (Placement(transformation(
              extent={{30,50},{50,70}}, rotation=0)));
      Utilities.Interfaces.Star Star annotation (Placement(transformation(
              extent={{80,50},{100,70}}, rotation=0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_outside
        annotation (Placement(transformation(extent={{-100,-20},{-80,0}},
              rotation=0)));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor HeatTrans(
          G=windowarea*Uw) annotation (Placement(transformation(extent={{-10,-20},
                {10,0}}, rotation=0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_inside
        annotation (
         Placement(transformation(extent={{80,-20},{100,0}}, rotation=0)));
        equation
      connect(RadCondAdapt.heatPort, twoStar_RadEx.Therm)
        annotation (Line(points={{-31,60},{30.8,60}}));
      connect(solarRad_in, RadCondAdapt.solarRad_in)
        annotation (Line(points={{-90,60},{-50.1,60}}, color={0,0,0}));
          connect(twoStar_RadEx.Star,Star)
            annotation (Line(points={{49.1,60},{90,60}}, pattern=LinePattern.None));
      connect(port_outside, HeatTrans.port_a)
        annotation (Line(points={{-90,-10},{-49.5,-10},{-10,-10}}));
      connect(HeatTrans.port_b, port_inside)
        annotation (Line(points={{10,-10},{10,-10},{90,-10}}));
          annotation (
            Icon(coordinateSystem(
                preserveAspectRatio=false,
                extent={{-100,-100},{100,100}},
                grid={2,2}), graphics={
              Line(
                points={{-66,18},{-62,18}},
                color={255,255,0},
                smooth=Smooth.None),
              Rectangle(extent={{-80,80},{80,-80}}, lineColor={0,0,0}),
              Rectangle(
                extent={{-80,80},{80,-80}},
                lineColor={0,0,255},
                pattern=LinePattern.None,
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-4,42},{10,-76}},
                lineColor={0,0,255},
                pattern=LinePattern.None,
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-76,46},{74,38}},
                lineColor={0,0,255},
                pattern=LinePattern.None,
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid),
              Line(
                points={{2,40},{2,-76},{76,-76},{76,40},{2,40}},
                color={0,0,0},
                smooth=Smooth.None),
              Line(
                points={{-76,40},{-76,-76},{-2,-76},{-2,40},{-76,40}},
                color={0,0,0},
                smooth=Smooth.None),
              Line(
                points={{-76,76},{-76,44},{76,44},{76,76},{-76,76}},
                color={0,0,0},
                smooth=Smooth.None),
              Rectangle(
                extent={{4,-8},{6,-20}},
                lineColor={0,0,0},
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-72,72},{-72,48},{72,48},{72,72},{-72,72}},
                color={0,0,0},
                smooth=Smooth.None),
              Rectangle(
                extent={{-72,72},{72,48}},
                lineColor={0,0,0},
                fillColor={211,243,255},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{10,36},{72,-72}},
                lineColor={0,0,0},
                fillColor={211,243,255},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-72,36},{-8,-72}},
                lineColor={0,0,0},
                fillColor={211,243,255},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-8,36},{-8,-72},{-72,-72},{-72,36},{-8,36}},
                color={0,0,0},
                smooth=Smooth.None),
              Line(
                points={{72,36},{72,-72},{10,-72},{10,36},{72,36}},
                color={0,0,0},
                smooth=Smooth.None),
              Rectangle(extent={{-80,80},{80,-80}}, lineColor={0,0,0})}),
            Window(
              x=0.26,
              y=0.21,
              width=0.49,
              height=0.55),
            Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>The <b>WindowSimple</b> model represents a window described by the thermal transmission coefficient and the coefficient of solar energy transmission. </p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<p><h4><font color=\"#008000\">Concept</font></h4></p>
<p>Phenomena being simulated: </p>
<p><ul>
<li>Solar energy transmission through the glass</li>
<li>Heat transmission through the whole window</li>
</ul></p>
<p><h4><font color=\"#008000\">References</font></h4></p>
<p>Exemplary U-Values for windows from insulation standards</p>
<p><ul>
<li>WschV 1984: specified &QUOT;two panes&QUOT; assumed 2,5 W/m2K</li>
<li>WschV 1995: 1,8 W/m2K</li>
<li>EnEV 2002: 1,7 W/m2K</li>
<li>EnEV 2009: 1,3 W/m2K</li>
</ul></p>
<p><h4><font color=\"#008000\">Example Results</font></h4></p>
<p><a href=\"AixLib.Building.Components.Examples.WindowsDoors.WindowSimple\">AixLib.Building.Components.Examples.WindowsDoors.WindowSimple</a></p>
</html>",revisions="<html>
<p><ul>
<li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
<li><i>May 02, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
<li><i>March 30, 2012&nbsp;</i> by Ana Constantin and Corinna Leonhardt:<br/>Implemented.</li>
</ul></p>
</html>"),  Diagram(coordinateSystem(
                preserveAspectRatio=false,
                extent={{-100,-100},{100,100}},
                grid={2,2}), graphics={Rectangle(extent={{-80,80},{80,-80}},
                    lineColor={0,0,0})}),
            DymolaStoredErrors);
        end WindowSimple;
  end WindowsDoors;

  package Examples "Examples for Building models"
    extends Modelica.Icons.ExamplesPackage;

    package DryAir
      extends Modelica.Icons.ExamplesPackage;
      model DryAir_test "Simulation to test the dry air models"
      extends Modelica.Icons.Example;
        Components.DryAir.DynamicVentilation dynamicVentilation(
          pITemp(triggeredTrapezoid(falling=1), TN=60),
          HeatingLimit=288.15,
          Max_VR=0.15,
          Tset=295.15)
          annotation (Placement(transformation(extent={{-12,-14},{8,6}})));
        Components.DryAir.Airload airload(V=100, T(start=303.15))
          annotation (Placement(transformation(extent={{30,-12},{50,8}})));
        Components.DryAir.Airload airload1(T(start=289.15))
          annotation (Placement(transformation(extent={{-12,70},{8,90}})));
        Components.DryAir.VarAirExchange varAirExchange
          annotation (Placement(transformation(extent={{-12,38},{8,58}})));
        Components.DryAir.InfiltrationRate_DIN12831 infiltrationRate_DIN12831
          annotation (Placement(transformation(extent={{-12,12},{8,32}})));
        Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow(Q_flow=
              150)
          annotation (Placement(transformation(extent={{-90,72},{-70,92}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
          TempOutsideDaycurve
          annotation (Placement(transformation(extent={{-90,40},{-70,60}})));
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature TempInside(T=293.15)
          annotation (Placement(transformation(extent={{90,40},{70,60}})));
        Modelica.Blocks.Sources.Sine sine(
          amplitude=7,
          offset=273.15 + 13,
          freqHz=1/(3600*24))
          annotation (Placement(transformation(extent={{-74,20},{-86,32}})));
        Modelica.Blocks.Sources.Sine sine1(
          amplitude=1,
          freqHz=1/3600,
          offset=1.5)
          annotation (Placement(transformation(extent={{-34,32},{-24,42}})));
        Modelica.Blocks.Interfaces.RealOutput realOut[4]
          annotation (Placement(transformation(extent={{72,-22},{92,-2}})));
      equation
         //Connecting the most relevant outputs
         realOut[1] = airload1.T;
         realOut[2] =varAirExchange.port_b.Q_flow;
         realOut[3] =infiltrationRate_DIN12831.port_b.Q_flow;
         realOut[4] =dynamicVentilation.port_inside.Q_flow;

        connect(dynamicVentilation.port_inside, airload.port) annotation (Line(
            points={{7.4,-5},{19.5,-5},{19.5,-4},{31,-4}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(fixedHeatFlow.port, airload1.port) annotation (Line(
            points={{-70,82},{-38,82},{-38,78},{-11,78}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(TempOutsideDaycurve.port,varAirExchange.port_a)  annotation (Line(
            points={{-70,50},{-41,50},{-41,48},{-12,48}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(TempInside.port,varAirExchange.port_b)  annotation (Line(
            points={{70,50},{49,50},{49,48},{8,48}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(TempOutsideDaycurve.port,infiltrationRate_DIN12831.port_a)
          annotation (Line(
            points={{-70,50},{-50,50},{-50,22},{-12,22}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(TempInside.port,infiltrationRate_DIN12831.port_b)  annotation (Line(
            points={{70,50},{40,50},{40,22},{8,22}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(sine.y, TempOutsideDaycurve.T) annotation (Line(
            points={{-86.6,26},{-92,26},{-92,50}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(sine1.y, varAirExchange.InPort1) annotation (Line(
            points={{-23.5,37},{-17.75,37},{-17.75,41.6},{-11,41.6}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(TempOutsideDaycurve.port, dynamicVentilation.port_outside)
          annotation (Line(
            points={{-70,50},{-50,50},{-50,-5},{-11.6,-5}},
            color={191,0,0},
            smooth=Smooth.None));
        annotation (
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                  100}}),
                  graphics={
              Text(
                extent={{12,90},{20,82}},
                lineColor={0,0,255},
                textString="1"),
              Text(
                extent={{12,60},{20,52}},
                lineColor={0,0,255},
                textString="2"),
              Text(
                extent={{12,32},{20,24}},
                lineColor={0,0,255},
                textString="3"),
              Text(
                extent={{12,6},{20,-2}},
                lineColor={0,0,255},
                textString="4")}),
          experiment(
            StopTime=86400,
            Interval=15,
            Algorithm="Lsodar"),
          experimentSetupOutput(events=false),
          Documentation(revisions="<html>
<ul>
  <li><i>May 14, 2013&nbsp;</i> by Ole Odendahl:<br/>Implemented remaining DryAir models, adjusted existing model, documentated</li>
  <li><i>May 07, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
  <li><i>October 16, 2011&nbsp;</i>
         by Ana Constantin:</br>implemented DynamicVentilation</li>
</ul>
</html>",       info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>This simulation tests the functionality of the dry air models. Default simulation parameters are provided. </p>
<p><h4><font color=\"#008000\">Concept</font></h4></p>
<p>The simulation consists of the following models:</p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"0\"><tr>
<td bgcolor=\"#dcdcdc\"><p>index</p></td>
<td bgcolor=\"#dcdcdc\"><p>model</p></td>
</tr>
<tr>
<td><p>1</p></td>
<td><p><a href=\"Building.Components.DryAir.Airload\">Airload</a></p></td>
</tr>
<tr>
<td><p>2</p></td>
<td><p><a href=\"Building.Components.DryAir.VarAirExchange\">VarAirExchange</a></p></td>
</tr>
<tr>
<td><p>3</p></td>
<td><p><a href=\"Building.Components.DryAir.InfiltrationRate_DIN12831\">InfiltrationRate_DIN12831</a></p></td>
</tr>
<tr>
<td><p>4</p></td>
<td><p><a href=\"Building.Components.DryAir.DynamicVentilation\">DynamicVentilation</a></p></td>
</tr>
</table>
<p>Outputs can easily be displayed via the provided outputs.</p>
</html>"));
      end DryAir_test;

    end DryAir;

    package Weather
      extends Modelica.Icons.ExamplesPackage;
      model WeatherModels
        extends Modelica.Icons.Example;

        Components.Weather.Weather weather(
          Cloud_cover=true,
          Wind_dir=true,
          Wind_speed=true,
          Air_temp=true,
          Air_press=true,
          Mass_frac=true,
          Rel_hum=true,
          Sky_rad=true,
          Ter_rad=true,
          fileName=
              "D:/EBC_SVN/projects/EBC9999_Modelica-Library/branches/2014-31-01_V2_2/DataBase/additionalFiles/TRY2010_12_Jahr_Modelica-Library.txt")
          annotation (Placement(transformation(extent={{-60,16},{6,60}})));
      equation

        annotation (
          experiment(
            StopTime=3.1536e+007,
            Interval=3600,
            Algorithm="Lsodar"),
          experimentSetupOutput,
          Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>A test to see if the <a href=\"AixLib.Building.Components.Weather.Weather\">weather</a> model is functioning correctly. A input file containing weather data (TRY standard) has to be provided and linked to. Check out the default path in order to set the path correctly considering the current directory.</p>
</html>",     revisions="<html>
<p><ul>
<li><i>May 28, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately, Added SkyTemp model to simulation.</li>
<li><i>December 13, 2011&nbsp;</i> by Ana Constantin:<br/>Implemented.</li>
</ul></p>
</html>"),Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                  100}}), graphics));
      end WeatherModels;
    end Weather;

    package WindowsDoors
      extends Modelica.Icons.ExamplesPackage;
      model WindowSimple
        extends Modelica.Icons.Example;
        Components.WindowsDoors.WindowSimple windowSimple(windowarea=10)
          annotation (Placement(transformation(extent={{-24,-4},{12,28}})));
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature Toutside(T=273.15)
          annotation (Placement(transformation(extent={{-62,0},{-42,20}})));
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature Tinside(T=293.15)
          annotation (Placement(transformation(extent={{58,0},{38,20}})));
        Modelica.Blocks.Sources.RealExpression UValue(y=windowSimple.port_inside.Q_flow
              /(1 - windowSimple.frameFraction)/windowSimple.windowarea/(
              windowSimple.port_inside.T - windowSimple.port_outside.T))
          annotation (Placement(transformation(extent={{-20,-46},{0,-26}})));
        Utilities.Sources.PrescribedSolarRad
                                           varRad(I={100}, n=1)
          annotation (Placement(transformation(extent={{-66,40},{-46,60}})));
        Modelica.Blocks.Sources.Constant SolarRadiation(k=100)
          annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature Tinside1(T=293.15)
          annotation (Placement(transformation(extent={{58,32},{38,52}})));
      equation
        connect(Toutside.port, windowSimple.port_outside) annotation (Line(
            points={{-42,10},{-34,10},{-34,10.4},{-22.2,10.4}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(windowSimple.port_inside, Tinside.port) annotation (Line(
            points={{10.2,10.4},{24,10.4},{24,10},{38,10}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(windowSimple.Star, Tinside1.port) annotation (Line(
            points={{10.2,21.6},{20,21.6},{20,42},{38,42}},
            color={95,95,95},
            pattern=LinePattern.None,
            smooth=Smooth.None));
        connect(varRad.solarRad_out[1], windowSimple.solarRad_in) annotation (Line(
            points={{-47,50},{-32,50},{-32,21.6},{-22.2,21.6}},
            color={255,128,0},
            smooth=Smooth.None));
        connect(SolarRadiation.y, varRad.u[1]) annotation (Line(
            points={{-79,50},{-66,50}},
            color={0,0,127},
            smooth=Smooth.None));
        annotation (
          Diagram(graphics),
          experiment(
            StopTime=3600,
            Interval=60,
            Algorithm="Lsodar"),
          experimentSetupOutput,
          Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Simulation to test the <a href=\"AixLib.Building.Components.WindowsDoors.WindowSimple\">WindowSimple</a> model.</p>
<p><h4><font color=\"#008000\">Concept</font></h4></p>
<p>Test case for calculation of U-value</p>
<p><ul>
<li>Area of component: 10 m2</li>
<li>Temperature difference: 20 K</li>
<li>Test time: 1 h</li>
</ul></p>
</html>",     revisions="<html>
<ul>
  <li><i>April 1, 2012&nbsp;</i>
         by Ana Constantin and Corinna Leonhard:<br>
         Implemented.</li>
</ul>
</html>"));
      end WindowSimple;

      model DoorSimple
        extends Modelica.Icons.Example;
        Components.WindowsDoors.Door doorSimple(
          eps=1,
          door_area=10,
          T0=293.15)
          annotation (Placement(transformation(extent={{-24,-4},{12,28}})));
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature Toutside(T=273.15)
          annotation (Placement(transformation(extent={{-62,0},{-42,20}})));
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature Tinside(T=293.15)
          annotation (Placement(transformation(extent={{58,0},{38,20}})));
        Modelica.Blocks.Sources.RealExpression UValue(y=doorSimple.port_b.Q_flow/(
              doorSimple.port_b.T - doorSimple.port_a.T)/doorSimple.door_area)
          annotation (Placement(transformation(extent={{-20,-46},{0,-26}})));
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature Tinside1(T=293.15)
          annotation (Placement(transformation(extent={{58,32},{38,52}})));
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature Toutside1(T=273.15)
          annotation (Placement(transformation(extent={{-62,26},{-42,46}})));
      equation
        connect(Toutside.port, doorSimple.port_a) annotation (Line(
            points={{-42,10},{-34,10},{-34,12},{-22.2,12}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(doorSimple.port_b, Tinside.port) annotation (Line(
            points={{10.2,12},{24,12},{24,10},{38,10}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(doorSimple.Star, Tinside1.port) annotation (Line(
            points={{10.2,21.6},{20,21.6},{20,42},{38,42}},
            color={95,95,95},
            pattern=LinePattern.None,
            smooth=Smooth.None));
        connect(Toutside1.port, doorSimple.Star1) annotation (Line(
            points={{-42,36},{-34,36},{-34,21.6},{-22.2,21.6}},
            color={191,0,0},
            smooth=Smooth.None));
        annotation (
          Diagram(graphics),
          experiment(
            StopTime=3600,
            Interval=60,
            Algorithm="Lsodar"),
          experimentSetupOutput,
          Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Simulation to test the <a href=\"AixLib.Building.Components.WindowsDoors.Door\">Door</a> model.</p>
<p><h4><font color=\"#008000\">Concept</font></h4></p>
<p>Test case for calculation of U-value</p>
<p><ul>
<li>Area of component: 10 m2</li>
<li>Temperature difference: 20 K</li>
<li>Test time: 1 h</li>
</ul></p>
</html>",     revisions="<html>
<ul>
  <li><i>April 1, 2012&nbsp;</i>
         by Ana Constantin and Corinna Leonhard:<br>
         Implemented.</li>
</ul>
</html>"));
      end DoorSimple;

    end WindowsDoors;

    package Walls
      extends Modelica.Icons.ExamplesPackage;
    model InsideWall
      extends Modelica.Icons.Example;

        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature Tinside(T=293.15)
          annotation (Placement(transformation(extent={{92,10},{72,30}})));
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature Tinside1(T=293.15)
          annotation (Placement(transformation(extent={{92,50},{72,70}})));
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature Tinside2(T=283.15)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-84,62})));
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature Tinside3(T=283.15)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-84,22})));
        Components.Walls.Wall wall_simple_new(
          outside=false,
          wall_length=5,
          wall_height=2,
          withDoor=true,
          WallType=DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_L_half(),
          T0=289.15)
          annotation (Placement(transformation(extent={{28,-4},{40,68}})));
        Components.Walls.Wall wall_simple1_new(
          outside=false,
          wall_length=5,
          wall_height=2,
          withDoor=true,
          WallType=DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_L_half(),
          T0=287.15) annotation (Placement(transformation(
              extent={{-6,36},{6,-36}},
              rotation=180,
              origin={-30,30})));
        Modelica.Blocks.Sources.RealExpression UValue_new(y=-Tinside3.port.Q_flow/(
              Tinside3.T - Tinside.T)/(wall_simple_new.wall_length*wall_simple_new.wall_height))
          annotation (Placement(transformation(extent={{-28,-100},{28,-80}})));
        Utilities.Interfaces.Adaptors.HeatStarToComb
                                                   thermStar_Demux
          annotation (Placement(transformation(extent={{-56,-50},{-72,-38}})));
        Utilities.Interfaces.Adaptors.HeatStarToComb
                                                   thermStar_Demux1
          annotation (Placement(transformation(extent={{56,-52},{70,-40}})));
    equation
        connect(wall_simple1_new.port_outside, wall_simple_new.port_outside)
          annotation (Line(
            points={{-23.7,30},{-23.7,32},{27.7,32}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(thermStar_Demux.thermStarComb, wall_simple1_new.thermStarComb_inside)
          annotation (Line(
            points={{-56.48,-44.075},{-39.24,-44.075},{-39.24,30},{-36,30}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(thermStar_Demux1.thermStarComb, wall_simple_new.thermStarComb_inside)
          annotation (Line(
            points={{56.42,-46.075},{49.21,-46.075},{49.21,32},{40,32}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(Tinside2.port, thermStar_Demux.star) annotation (Line(
            points={{-74,62},{-56,62},{-56,-22},{-88,-22},{-88,-39.65},{-72.32,
                -39.65}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(Tinside3.port, thermStar_Demux.therm) annotation (Line(
            points={{-74,22},{-60,22},{-60,-18},{-92,-18},{-92,-47.825},{-72.08,
                -47.825}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(Tinside1.port, thermStar_Demux1.star) annotation (Line(
            points={{72,60},{56,60},{56,-22},{88,-22},{88,-41.65},{70.28,-41.65}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(Tinside.port, thermStar_Demux1.therm) annotation (Line(
            points={{72,20},{60,20},{60,-18},{94,-18},{94,-50},{82,-50},{82,-49.825},
                {70.07,-49.825}},
            color={191,0,0},
            smooth=Smooth.None));

      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}),
                          graphics),
        experiment(
            StopTime=90000,
            Interval=60,
            __Dymola_Algorithm="Lsodar"),
        experimentSetupOutput,
        Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Simulation to test the <a href=\"AixLib.Building.Components.Walls.Wall\">Wall</a> model in case of an <b>inside wall</b> application.</p>
<p><h4><font color=\"#008000\">Concept</font></h4></p>
<p>Test case for calculation of U-value</p>
<p><ul>
<li>Area of Wall: 10 m&sup2;</li>
<li>Area of Door: 2 m&sup2;</li>
<li>Temperature difference: 10 K</li>
<li>Test time: 25 h</li>
</ul></p>
<p>The u-values are calculated via calculation moduls and may be displayed easily. </p>
</html>",   revisions="<html>
<ul>
  <li><i>April, 2012&nbsp;</i>
         by Mark Wesseling:<br>
         Implemented.</li>
</ul>
</html>"));
    end InsideWall;

    model OutsideWall
      extends Modelica.Icons.Example;

        Components.Walls.Wall wall_simple(
          wall_length=5,
          wall_height=2,
          withWindow=true,
          WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
          withSunblind=true,
          WallType=DataBase.Walls.WSchV1984.OW.OW_WSchV1984_S(),
          outside=true,
          Model=3,
          T0=289.15) annotation (Placement(transformation(
              extent={{-6,57},{6,-57}},
              rotation=180,
              origin={-30,25})));
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature Tinside1(T=293.15)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-90,44})));
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature Tinside2(T=293.15)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-90,10})));
        Modelica.Blocks.Sources.RealExpression UValue(y=-Tinside2.port.Q_flow/(
              Tinside2.T - Toutside.T)/(wall_simple.wall_length*wall_simple.wall_height))
          annotation (Placement(transformation(extent={{-32,-78},{24,-58}})));
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature Toutside(T=283.15)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={30,22})));
        Utilities.Sources.PrescribedSolarRad
                                           varRad(I={100}) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={50,80})));
        Utilities.Interfaces.Adaptors.HeatStarToComb
                                                   heatStarToComb annotation (
            Placement(transformation(
              extent={{-10,-8},{10,8}},
              rotation=180,
              origin={-58,26})));
        Modelica.Blocks.Sources.RealExpression WindSpeed(y=4)
          annotation (Placement(transformation(extent={{30,48},{12,64}})));
    equation
        connect(Toutside.port, wall_simple.port_outside) annotation (Line(
            points={{20,22},{4,22},{4,25},{-23.7,25}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(wall_simple.SolarRadiationPort, varRad.solarRad_out[1]) annotation (
           Line(
            points={{-22.2,77.25},{9.9,77.25},{9.9,80},{41,80}},
            color={255,128,0},
            smooth=Smooth.None));
        connect(heatStarToComb.thermStarComb, wall_simple.thermStarComb_inside)
          annotation (Line(
            points={{-48.6,26.1},{-43.3,26.1},{-43.3,25},{-36,25}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(Tinside2.port, heatStarToComb.therm) annotation (Line(
            points={{-80,10},{-74,10},{-74,31.1},{-68.1,31.1}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(Tinside1.port, heatStarToComb.star) annotation (Line(
            points={{-80,44},{-74,44},{-74,20.2},{-68.4,20.2}},
            color={191,0,0},
            smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}),
                          graphics),
        experiment(
          StopTime=36000,
          Interval=60,
          Algorithm="Lsodar"),
        experimentSetupOutput,
        Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Simulation to test the <a href=\"AixLib.Building.Components.Walls.Wall\">Wall</a> model in case of an outside wall application.</p>
<p><h4><font color=\"#008000\">Concept</font></h4></p>
<p>Test case for calculation of U-value</p>
<p><ul>
<li>Area of Wall: 10 m2</li>
<li>Area of Window: 2 m2</li>
<li>Temperature difference: 10 K</li>
<li>Test time: 10 h</li>
</ul></p>
</html>",   revisions="<html>
<ul>
  <li><i>April, 2012&nbsp;</i>
         by Mark Wesseling:<br>
         Implemented.</li>
</ul>
</html>"));
    end OutsideWall;

    end Walls;

    package Sources "Package for examples of sources"
      extends Modelica.Icons.ExamplesPackage;

      package InternalGains
        extends Modelica.Icons.ExamplesPackage;
        model OneOffice
          extends Modelica.Icons.Example;

          Components.Sources.InternalGains.Humans.HumanSensibleHeat_VDI2078
            human_SensibleHeat_VDI2078(NrPeople=2)
            annotation (Placement(transformation(extent={{-10,40},{12,64}})));
          Building.Components.Sources.InternalGains.Machines.Machines_DIN18599
            machines_SensibleHeat_DIN18599(NrPeople=2)
            annotation (Placement(transformation(extent={{-10,-6},{14,24}})));
          Components.Sources.InternalGains.Lights.Lights_relative lights
            annotation (Placement(transformation(extent={{-8,-46},{12,-22}})));
          Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature RoomTemp
            annotation (Placement(transformation(extent={{-58,40},{-38,60}})));
          Modelica.Blocks.Sources.Ramp Evolution_RoomTemp(
            duration=36000,
            offset=293.15,
            startTime=4000,
            height=0)
            annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
          Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
            columns={2,3,4,5},
            extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
            tableOnFile=false,
            table=[0,0,0.1,0,0; 36000,0,0.1,0,0; 36060,1,1,0.3,0.8; 72000,1,1,0.3,0.8;
                72060,0,0.1,0,0; 86400,0,0.1,0,0])
            annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
          Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemp(T=293.15)
            annotation (Placement(transformation(extent={{62,46},{42,66}})));
        equation
          connect(RoomTemp.port, human_SensibleHeat_VDI2078.TRoom) annotation (Line(
              points={{-38,50},{-28,50},{-28,64},{-8.9,64},{-8.9,62.8}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Evolution_RoomTemp.y, RoomTemp.T) annotation (Line(
              points={{-79,50},{-60,50}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(combiTimeTable.y[1], human_SensibleHeat_VDI2078.Schedule)
            annotation (Line(
              points={{-59,-10},{-20,-10},{-20,50.68},{-9.01,50.68}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(combiTimeTable.y[2], machines_SensibleHeat_DIN18599.Schedule)
            annotation (Line(
              points={{-59,-10},{-20,-10},{-20,9},{-8.8,9}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(combiTimeTable.y[3], lights.Schedule) annotation (Line(
              points={{-59,-10},{-20,-10},{-20,-34},{-7,-34}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(human_SensibleHeat_VDI2078.ConvHeat, fixedTemp.port) annotation (
              Line(
              points={{10.9,58},{34,58},{34,56},{42,56}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(human_SensibleHeat_VDI2078.RadHeat, fixedTemp.port) annotation (
              Line(
              points={{10.9,50.8},{36,50.8},{36,56},{42,56}},
              color={95,95,95},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          connect(machines_SensibleHeat_DIN18599.ConvHeat, fixedTemp.port)
            annotation (Line(
              points={{12.8,18},{38,18},{38,56},{42,56}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(machines_SensibleHeat_DIN18599.RadHeat, fixedTemp.port)
            annotation (Line(
              points={{12.8,0.3},{38,0.3},{38,56},{42,56}},
              color={95,95,95},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          connect(lights.ConvHeat, fixedTemp.port) annotation (Line(
              points={{11,-26.8},{38,-26.8},{38,56},{42,56}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(lights.RadHeat, fixedTemp.port) annotation (Line(
              points={{11,-40.96},{38,-40.96},{38,56},{42,56}},
              color={95,95,95},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          annotation (
            Diagram(graphics),
            experiment(
              StopTime=86400,
              Interval=60,
              __Dymola_Algorithm="Lsodar"),
            experimentSetupOutput(events=false),
            Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Simulation to test the functionalty of the internal gains in a modelled room. </p>
</html>",     revisions="<html>
<p><ul>
<li><i>May 07, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
<li><i>August 12, 2011</i> by Ana Constantin:<br/>implemented</li>
</ul></p>
</html>"));
        end OneOffice;

        model Humans "Simulation to check the human models"
          extends Modelica.Icons.Example;
          Components.Sources.InternalGains.Humans.HumanSensibleHeat_VDI2078
            human_SensibleHeat_VDI2078_1(RatioConvectiveHeat=0.6)
            annotation (Placement(transformation(extent={{-24,-20},{22,32}})));
          Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature varTempRoom
            annotation (Placement(transformation(extent={{-64,42},{-84,62}})));
          Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemp(T=293.15)
            annotation (Placement(transformation(extent={{78,4},{58,24}})));
          Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(table=[0,0; 28740,0; 28800,
                1; 43200,1; 43260,0; 46800,0; 46860,1; 64800,1; 64860,0; 86400,0])
            annotation (Placement(transformation(extent={{-82,-26},{-62,-6}})));
          Modelica.Blocks.Sources.Sine sine(
            amplitude=2,
            freqHz=1/(24*3600),
            offset=273.15 + 20,
            phase(displayUnit="deg") = -3.1415926535898)
            annotation (Placement(transformation(extent={{-82,18},{-70,30}})));
          Modelica.Blocks.Interfaces.RealOutput HeatOut
            annotation (Placement(transformation(extent={{58,-74},{78,-54}})));
        equation
        //Connect human heat output
        human_SensibleHeat_VDI2078_1.productHeatOutput.y = HeatOut;

          connect(varTempRoom.port, human_SensibleHeat_VDI2078_1.TRoom) annotation (
             Line(
              points={{-84,52},{-44,52},{-44,29.4},{-21.7,29.4}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(sine.y, varTempRoom.T) annotation (Line(
              points={{-69.4,24},{-54,24},{-54,52},{-62,52}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(human_SensibleHeat_VDI2078_1.ConvHeat, fixedTemp.port)
            annotation (Line(
              points={{19.7,19},{38.85,19},{38.85,14},{58,14}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(human_SensibleHeat_VDI2078_1.RadHeat, fixedTemp.port) annotation (
             Line(
              points={{19.7,3.4},{39.85,3.4},{39.85,14},{58,14}},
              color={95,95,95},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          connect(combiTimeTable.y[1], human_SensibleHeat_VDI2078_1.Schedule)
            annotation (Line(
              points={{-61,-16},{-42,-16},{-42,3.14},{-21.93,3.14}},
              color={0,0,127},
              smooth=Smooth.None));
          annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}),      graphics),
            experiment(StopTime=86400),
            __Dymola_experimentSetupOutput,
            Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Simulation to check the functionality of the human heat sources. It only consists of one human (VDI 2078). </p>
<p>The timetable represents typical working hours with one hour lunch time. The room temperature follows a sine input varying between 18 and 22 degrees over a 24 hour time period.</p>
</html>",       revisions="<html>
<p><ul>
<li><i>May 31, 2013&nbsp;</i> by Ole Odendahl:<br/>Implemented, added documentation and formatted appropriately</li>
</ul></p>
</html>"));
        end Humans;

        model Machines "Simulation to check the machine models"
          extends Modelica.Icons.Example;
          Components.Sources.InternalGains.Machines.Machines_DIN18599
            machines_sensibleHeat_DIN18599
            annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
          Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(table=[0,0; 28740,0;
                28800,1; 64800,1; 64860,0; 86400,0])
            annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
          Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemp(T=293.15)
            annotation (Placement(transformation(extent={{80,-8},{60,12}})));
        equation
          connect(combiTimeTable.y[1], machines_sensibleHeat_DIN18599.Schedule)
            annotation (Line(
              points={{-49,0},{-9,0}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(machines_sensibleHeat_DIN18599.ConvHeat, fixedTemp.port)
            annotation (Line(
              points={{9,6},{38,6},{38,2},{60,2}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(machines_sensibleHeat_DIN18599.RadHeat, fixedTemp.port)
            annotation (Line(
              points={{9,-5.8},{34.5,-5.8},{34.5,2},{60,2}},
              color={95,95,95},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          annotation (
            Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                    100,100}}), graphics),
            experiment(StopTime=86400, Interval=60),
            __Dymola_experimentSetupOutput,
            Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>This simulation is to check the functionality of the machine models described by the internal gains. </p>
<p><b><font style=\"color: #008000; \">Concept</font></b></p><p>Heat flow values can be displayed via the provided output. </p>
</html>",       revisions="<html>
<p><ul>
<li><i>May 31, 2013&nbsp;</i> by Ole Odendahl:<br/>Implemented, added documentation and formatted appropriately</li>
</ul></p>
</html>"));
        end Machines;

        model Lights "Simulation to check the light models"
          extends Modelica.Icons.Example;
          Components.Sources.InternalGains.Lights.Lights_relative lights
            annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
          Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(table=[0,0; 28740,0;
                28800,1; 64800,1; 64860,0; 86400,0])
            annotation (Placement(transformation(extent={{-76,-10},{-56,10}})));
          Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemp(T=293.15)
            annotation (Placement(transformation(extent={{78,-8},{58,12}})));
        equation
          connect(combiTimeTable.y[1], lights.Schedule) annotation (Line(
              points={{-55,0},{-9,0}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(lights.ConvHeat, fixedTemp.port) annotation (Line(
              points={{9,6},{34,6},{34,2},{58,2}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(lights.RadHeat, fixedTemp.port) annotation (Line(
              points={{9,-5.8},{46,-5.8},{46,2},{58,2}},
              color={95,95,95},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          annotation (
            Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                    100,100}}), graphics),
            experiment(
              StopTime=86400,
              Interval=60,
              __Dymola_Algorithm="Lsodar"),
            __Dymola_experimentSetupOutput,
            Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>This simulation is to check the functionality of the light models described by the internal gains. </p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>Heat flow values can be displayed via the provided output. </p>
</html>",       revisions="<html>
<p><ul>
<li><i>May 31, 2013&nbsp;</i> by Ole Odendahl:<br/>Implemented, added documentation and formatted appropriately</li>
</ul></p>
</html>"));
        end Lights;
      end InternalGains;
    end Sources;
  end Examples;
end Components;
