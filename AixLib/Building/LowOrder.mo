within AixLib.Building;
package LowOrder "Low Order Building Models"
  extends Modelica.Icons.Package;

  model ThermalZone "Ready-to-use Low Order building model"
    parameter DataBase.Buildings.ZoneBaseRecord zoneParam=
        DataBase.Buildings.OfficePassiveHouse.OPH_1_Meeting()
      "choose setup for this zone" annotation (choicesAllMatching=true);

    Components.Sources.InternalGains.Humans.HumanSensibleHeat_VDI2078
      human_SensibleHeat_VDI2078(
      ActivityType=zoneParam.ActivityTypePeople,
      NrPeople=zoneParam.NrPeople,
      RatioConvectiveHeat=zoneParam.RatioConvectiveHeatPeople,
      T0=zoneParam.T0all) annotation (choicesAllMatching=true, Placement(
          transformation(extent={{40,0},{60,20}})));
    Components.Sources.InternalGains.Machines.Machines_DIN18599
      machines_SensibleHeat_DIN18599(
      ActivityType=zoneParam.ActivityTypeMachines,
      NrPeople=zoneParam.NrPeopleMachines,
      ratioConv=zoneParam.RatioConvectiveHeatMachines,
      T0=zoneParam.T0all)
      annotation (Placement(transformation(extent=
              {{40,-20},{60,-1}})));
    Components.Sources.InternalGains.Lights.Lights_relative
      lights(
      RoomArea=zoneParam.RoomArea,
      LightingPower=zoneParam.LightingPower,
      ratioConv=zoneParam.RatioConvectiveHeatLighting,
      T0=zoneParam.T0all)
      annotation (Placement(transformation(extent=
              {{40,-40},{60,-21}})));
    Modelica.Blocks.Interfaces.RealInput infiltrationRate annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={-40,-100}), iconTransformation(
          extent={{-12,-12},{12,12}},
          rotation=90,
          origin={-40,-88})));
    Modelica.Blocks.Interfaces.RealInput weather[3] if       zoneParam.withOuterwalls
      "[1]: Air temperature<br>[2]: Horizontal radiation of sky<br>[3]: Horizontal radiation of earth"
      annotation (Placement(transformation(extent={{-120,0},{-80,40}}),
          iconTransformation(extent={{-86,-12},{-62,12}})));
    Utilities.Interfaces.SolarRad_in solarRad_in[zoneParam.n] if              zoneParam.withOuterwalls
      annotation (Placement(transformation(extent={{-100,70},{-80,90}}),
          iconTransformation(extent={{-100,40},{-60,80}})));
    Modelica.Blocks.Interfaces.RealInput internalGains[3]
      "persons, machines, lighting" annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={80,-100}), iconTransformation(
          extent={{-12,-12},{12,12}},
          rotation=90,
          origin={80,-88})));
    BaseClasses.ThermalZonePhysics thermalZonePhysics(
      RRest=zoneParam.RRest,
      R1o=zoneParam.R1o,
      C1o=zoneParam.C1o,
      Ao=zoneParam.Ao,
      T0all=zoneParam.T0all,
      alphaowi=zoneParam.alphaowi,
      alphaowo=zoneParam.alphaowo,
      epso=zoneParam.epso,
      R1i=zoneParam.R1i,
      C1i=zoneParam.C1i,
      Ai=zoneParam.Ai,
      Vair=zoneParam.Vair,
      alphaiwi=zoneParam.alphaiwi,
      rhoair=zoneParam.rhoair,
      cair=zoneParam.cair,
      epsi=zoneParam.epsi,
      aowo=zoneParam.aowo,
      epsw=zoneParam.epsw,
      g=zoneParam.g,
      Imax=zoneParam.Imax,
      n=zoneParam.n,
      weightfactorswall=zoneParam.weightfactorswall,
      weightfactorswindow=zoneParam.weightfactorswindow,
      weightfactorground=zoneParam.weightfactorground,
      temperatureground=zoneParam.temperatureground,
      Aw=zoneParam.Aw,
      gsunblind=zoneParam.gsunblind,
      withInnerwalls=zoneParam.withInnerwalls,
      withWindows=zoneParam.withWindows,
      withOuterwalls=zoneParam.withOuterwalls,
      splitfac=zoneParam.splitfac)
      annotation (Placement(transformation(extent={{-20,0},{20,40}})));
    Modelica.Blocks.Interfaces.RealInput infiltrationTemperature annotation (
        Placement(transformation(extent={{-100,-60},{-60,-20}}),
          iconTransformation(extent={{-88,-52},{-62,-26}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a internalGainsConv
      annotation (Placement(transformation(extent={{-10,-100},{10,-80}}),
          iconTransformation(extent={{-10,-100},{10,-80}})));
    Utilities.Interfaces.Star internalGainsRad
      annotation (Placement(transformation(extent={{30,-100},{50,-80}})));
  equation
    if zoneParam.withOuterwalls then
      connect(weather, thermalZonePhysics.weather) annotation (Line(
          points={{-100,20},{-64,20},{-64,23.8},{-15,23.8}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(solarRad_in, thermalZonePhysics.solarRad_in) annotation (Line(
          points={{-90,80},{-60,80},{-60,33},{-15.4,33}},
          color={255,128,0},
          smooth=Smooth.None));
    end if;
    connect(infiltrationRate, thermalZonePhysics.ventilationRate)
      annotation (Line(
        points={{-40,-100},{-40,-40},{-8,-40},{-8,2.8}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(human_SensibleHeat_VDI2078.TRoom, thermalZonePhysics.internalGainsConv)
      annotation (Line(
        points={{41,19},{46,19},{46,32},{96,32},{96,-52},{8,-52},{8,2}},
        color={191,0,0},
        smooth=Smooth.None));

    connect(human_SensibleHeat_VDI2078.ConvHeat, thermalZonePhysics.internalGainsConv)
      annotation (Line(
        points={{59,15},{96,15},{96,-52},{8,-52},{8,2}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(machines_SensibleHeat_DIN18599.ConvHeat, thermalZonePhysics.internalGainsConv)
      annotation (Line(
        points={{59,-4.8},{96,-4.8},{96,-52},{8,-52},{8,2}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(lights.ConvHeat, thermalZonePhysics.internalGainsConv) annotation (Line(
        points={{59,-24.8},{96,-24.8},{96,-52},{8,-52},{8,2}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(human_SensibleHeat_VDI2078.RadHeat, thermalZonePhysics.internalGainsRad)
      annotation (Line(
        points={{59,9},{92,9},{92,-48},{16,-48},{16,2}},
        color={95,95,95},
        pattern=LinePattern.None,
        smooth=Smooth.None));
    connect(machines_SensibleHeat_DIN18599.RadHeat, thermalZonePhysics.internalGainsRad)
      annotation (Line(
        points={{59,-16.01},{92,-16.01},{92,-48},{16,-48},{16,2}},
        color={95,95,95},
        pattern=LinePattern.None,
        smooth=Smooth.None));
    connect(lights.RadHeat, thermalZonePhysics.internalGainsRad) annotation (Line(
        points={{59,-36.01},{92,-36.01},{92,-48},{16,-48},{16,2}},
        color={95,95,95},
        pattern=LinePattern.None,
        smooth=Smooth.None));
    connect(human_SensibleHeat_VDI2078.Schedule, internalGains[1]) annotation (
        Line(
        points={{40.9,8.9},{30,8.9},{30,-74},{80,-74},{80,-113.333}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(machines_SensibleHeat_DIN18599.Schedule, internalGains[2])
      annotation (Line(
        points={{41,-10.5},{30,-10.5},{30,-74},{80,-74},{80,-100}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(lights.Schedule, internalGains[3]) annotation (Line(
        points={{41,-30.5},{30,-30.5},{30,-74},{80,-74},{80,-86.6667}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(infiltrationTemperature, thermalZonePhysics.ventilationTemperature)
      annotation (Line(
        points={{-80,-40},{-60,-40},{-60,12},{-15.2,12}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(thermalZonePhysics.internalGainsConv, internalGainsConv) annotation (
        Line(
        points={{8,2},{8,-52},{0,-52},{0,-90}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(thermalZonePhysics.internalGainsRad, internalGainsRad) annotation (Line(
        points={{16,2},{16,-80},{40,-80},{40,-90}},
        color={95,95,95},
        pattern=LinePattern.None,
        smooth=Smooth.None));
    annotation (
      Dialog(
        tab="Windows",
        group="Shading",
        descriptionLabel=false),
      Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-100,-100},{100,
              100}}),      graphics),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}),     graphics={
          Rectangle(
            extent={{-60,80},{100,-58}},
            lineColor={0,128,255},
            lineThickness=1,
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-60,-58},{100,-70}},
            lineColor={0,127,0},
            lineThickness=1,
            fillColor={0,127,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{14,36},{100,-58}},
            lineColor={135,135,135},
            fillColor={135,135,135},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{100,36},{-2,36},{100,60},{100,36}},
            lineColor={255,85,85},
            lineThickness=1,
            smooth=Smooth.None,
            fillColor={255,85,85},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-50,72},{-22,44}},
            lineColor={255,255,0},
            lineThickness=1,
            fillColor={255,255,0},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-18,54},{-6,44}},
            color={255,255,0},
            thickness=1,
            smooth=Smooth.None),
          Line(
            points={{-26,44},{-18,32}},
            color={255,255,0},
            thickness=1,
            smooth=Smooth.None),
          Line(
            points={{-36,40},{-36,26}},
            color={255,255,0},
            thickness=1,
            smooth=Smooth.None),
          Line(
            points={{-48,-58},{-50,-52},{-46,-48},{-48,-42}},
            color={0,0,0},
            thickness=1,
            smooth=Smooth.Bezier),
          Line(
            points={{-40,-58},{-42,-52},{-38,-48},{-40,-42}},
            color={0,0,0},
            thickness=1,
            smooth=Smooth.Bezier),
          Line(
            points={{-32,-58},{-34,-52},{-30,-48},{-32,-42}},
            color={0,0,0},
            thickness=1,
            smooth=Smooth.Bezier),
          Line(
            points={{-50,-44},{-48,-40},{-46,-44}},
            color={0,0,0},
            thickness=1,
            smooth=Smooth.Bezier),
          Line(
            points={{-42,-44},{-40,-40},{-38,-44}},
            color={0,0,0},
            thickness=1,
            smooth=Smooth.Bezier),
          Line(
            points={{-34,-44},{-32,-40},{-30,-44}},
            color={0,0,0},
            thickness=1,
            smooth=Smooth.Bezier),
          Rectangle(
            extent={{22,36},{100,-50}},
            fillColor={127,0,127},
            fillPattern=FillPattern.Solid,
            lineThickness=1,
            pattern=LinePattern.None,
            lineColor={0,0,0}),
          Rectangle(
            extent={{64,12},{80,0}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{64,0},{80,-12}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{48,0},{64,-12}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{48,12},{64,0}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{4,-4},{-4,4}},
            lineColor={255,255,0},
            fillColor={255,255,0},
            fillPattern=FillPattern.Solid,
            origin={65,28},
            rotation=180),
          Line(
            points={{-12,-24},{-18,-24}},
            color={0,0,0},
            smooth=Smooth.None,
            thickness=1,
            origin={50,8},
            rotation=180),
          Line(
            points={{-11,-37},{-11,-41},{-17,-41},{-17,-37}},
            color={0,0,0},
            smooth=Smooth.None,
            thickness=1,
            origin={51,-5},
            rotation=180),
          Rectangle(
            extent={{62,36},{68,32}},
            pattern=LinePattern.None,
            lineThickness=1,
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,0}),
          Rectangle(
            extent={{74,-24},{92,-36}},
            pattern=LinePattern.None,
            lineThickness=1,
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,0}),
          Rectangle(
            extent={{75,-25},{91,-35}},
            pattern=LinePattern.None,
            lineThickness=1,
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,0}),
          Polygon(
            points={{74,-42},{78,-38},{88,-38},{92,-42},{74,-42}},
            pattern=LinePattern.None,
            smooth=Smooth.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{78,-41},{80,-39},{86,-39},{88,-41},{78,-41}},
            pattern=LinePattern.None,
            smooth=Smooth.None,
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,0}),
          Ellipse(
            extent={{40,-26},{46,-32}},
            lineColor={255,213,170},
            fillColor={255,213,170},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{43,-29},{41,-27}},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid,
            pattern=LinePattern.None,
            lineColor={0,0,0}),
          Ellipse(
            extent={{45,-29},{43,-27}},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid,
            pattern=LinePattern.None,
            lineColor={0,0,0}),
          Line(
            points={{40,-29},{40,-29},{40,-29},{42,-31},{44,-31},{46,-29},{46,
                -29},{46,-29}},
            smooth=Smooth.None,
            color={0,0,0},
            thickness=1),
          Rectangle(
            extent={{39,-32},{47,-44}},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid,
            pattern=LinePattern.None),
          Text(
            extent={{-90,134},{98,76}},
            lineColor={127,0,127},
            textString="%name")}),
      Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<ul>
<li>The ThermalZone reflects the VDI 6007 components (in ThermalZonePhysics) and adds some standards parts of the EBC library for easy simulation with persons, lights and maschines.</li>
<li>Inputs: real weather vector, as defined in <a href=\"AixLib.Building.LowOrder.BaseClasses.EqAirTemp\">EqAirTemp</a>; vectorial solarRad_in, the solar radiation (diffuse and direct) for all n directions; real infiltration/ventilation as defined in <a href=\"AixLib.Building.LowOrder.BaseClasses.ReducedOrderModel\">ReducedOrderModel</a> and real inner loads input for profiles. </li>
<li>Parameters: All parameters are collected in a ZoneRecord (see <a href=\"AixLib.DataBase.Buildings.ZoneBaseRecord\">ZoneBaseRecord</a>). </li>
</ul>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>ThermalZone is thought for easy computations to get information about air temperatures and heating profiles. Therefore, some simplifications have been implemented (one air node, one inner wall, one outer wall). </p>
<p>All theory is documented in VDI 6007. How to gather the physical parameters for the thermal zone is documented in this standard. It is possible to get this information out of the normal information of a building. Various data can be used, depending on the abilities of the preprocessing tools. </p>
<p><br><b><font style=\"color: #008000; \">References</font></b></p>
<ul>
<li>German Association of Engineers: Guideline VDI 6007-1, March 2012: Calculation of transient thermal response of rooms and buildings - Modelling of rooms.</li>
<li>Lauster, M.; Teichmann, J.; Fuchs, M.; Streblow, R.; Mueller, D. (2014): Low order thermal network models for dynamic simulations of buildings on city district scale. In: Building and Environment 73, p. 223&ndash;231. DOI: <a href=\"http://dx.doi.org/10.1016/j.buildenv.2013.12.016\">10.1016/j.buildenv.2013.12.016</a></p>.</li>
</ul>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p>See <a href=\"Examples\">Examples</a> for some results. </p>
</html>",
        revisions="<html>
<ul>
  <li><i>March, 2012&nbsp;</i>
         by Moritz Lauster:<br>
         Implemented</li>
</ul>
</html>"));
  end ThermalZone;

  package BaseClasses "Sub-models for ThermalZone"
    extends Modelica.Icons.BasesPackage;

    model EqAirTemp "equivalent air temperature according to VDI 6007"

      parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaowo=20
        "Outer wall's coefficient of heat transfer (outer side)";
      parameter Real aowo=0.6 "Coefficient of absorption of the outer walls";
      parameter Real eowo=0.9 "Coefficient of emission of the outer walls";
      parameter Integer n=4 "Number of orientations (without ground)";
      //parameter Real orientationswallsvertical[n]={0,90,180,270,0} "orientations of the walls against the horizontal (n,e,s,w)"; //Muss rein bei genauer Beachtung der Orientierungen ueber phi fuer die langwellige Strahlung
      //parameter Real orientationswallshorizontal[n]={90,90,90,90,0} "orientations of the walls against the vertical (wall,roof)"; //Muss rein bei genauer Beachtung der Orientierungen ueber phi fuer die langwellige Strahlung
      parameter Real wf_wall[n]={0.5,0.2,0.2,0.1} "Weight factors of the walls";
      //parameter Integer m=4 "Number of window orientations";
      //parameter Real orientationswindowsvertical[m]={0,90,180,270,0} "orientations of the windows against the horizontal (n,e,s,w)"; //Muss rein bei genauer Beachtung der Orientierungen ueber phi fuer die langwellige Strahlung
      //parameter Real orientationswindowshorizontal[m]={90,90,90,90,0} "orientations of the windows against the vertical (wall,roof)"; //Muss rein bei genauer Beachtung der Orientierungen ueber phi fuer die langwellige Strahlung
      parameter Real wf_win[n]={0,0,0,0} "Weight factors of the windows";
      parameter Real wf_ground=0
        "Weight factor of the ground (0 if not considered)";
      parameter Modelica.SIunits.Temp_K T_ground=284.15
        "Temperature of the ground in contact with ground slab";
    protected
                parameter Real phiprivate=0.5;
                parameter Real unitvec[n]=ones(n);
               // parameter Real unitvecwindow[m]=ones(m);
    public
      Modelica.Blocks.Interfaces.RealInput weatherData[3]
        "[1]: Air temperature<br>[2]: Horizontal radiation of sky<br>[3]: Horizontal radiation of earth"
        annotation (Placement(transformation(extent={{-120,-20},{-80,20}}),
            iconTransformation(extent={{-100,-20},{-60,20}})));
      Utilities.Interfaces.SolarRad_in solarRad_in[n] annotation (Placement(
            transformation(extent={{-100,56},{-80,76}}), iconTransformation(
              extent={{-99,42},{-71,70}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a equalAirTemp annotation (
          Placement(transformation(extent={{80,-6},{100,14}}), iconTransformation(
              extent={{60,-20},{100,20}})));

      Modelica.SIunits.Temp_K T_earth
        "radiative temperature of the land surface";
      Modelica.SIunits.Temp_K T_sky "radiative temperature of the sky";

      Modelica.SIunits.Temp_K T_eqWall[n] "temperature equal wall";
      Modelica.SIunits.Temp_K T_eqWin[n] "temperature equal window";

    protected
      Modelica.SIunits.RadiantEnergyFluenceRate E_earth
        "Iradiation from land surface";
      Modelica.SIunits.RadiantEnergyFluenceRate E_sky "Iradiation from sky";

      Modelica.SIunits.Temp_K T_air "outdoor air temperature";

      Modelica.SIunits.Temp_K T_eqLWs "equal long wave scalar";
      Modelica.SIunits.TemperatureDifference T_eqLW[n] "equal long wave";
      Modelica.SIunits.TemperatureDifference T_eqSW[n] "equal short wave";

      Modelica.SIunits.CoefficientOfHeatTransfer alpharad;

    public
      Modelica.Blocks.Interfaces.RealInput sunblindsig[n]
        annotation (Placement(transformation(extent={{-20,-20},{20,20}},
            rotation=-90,
            origin={-10,100}),
            iconTransformation(extent={{-20,-20},{20,20}},
            rotation=-90,
            origin={0,80})));

    initial equation
      assert(n==size(wf_wall,1),"weightfactorswall has to have n elements");
      assert(n==size(wf_win,1),"weightfactorswall has to have n elements");
      if ((sum(wf_wall)+sum(wf_win)+wf_ground)<>0.00001)==false then
        Modelica.Utilities.Streams.print("WARNING!:The sum of the weightfactors (walls,windows and ground) in eqairtemp is 0. This means, that eqairtemp is 0 °C. If there are no walls, windows and ground at all, this might be irrelevant.");
      end if;
      if (abs((sum(wf_wall)+sum(wf_win)+wf_ground)-1)>0.1) then
        Modelica.Utilities.Streams.print("WARNING!:The sum of the weightfactors (walls,windows and ground) in eqairtemp is <0.9 or >1.1. Normally, the sum should be 1, as the influence of all weightfactors should the whole influence on the temperature.");
      end if;
    equation
      if cardinality(sunblindsig)<1 then
        sunblindsig=fill(0,n);
      end if;

      T_air=weatherData[1];
      E_sky=weatherData[2];
      E_earth=weatherData[3];
      if (abs(E_sky+E_earth)<0.1) then
        alpharad=5.0;
      else
        alpharad=(E_sky+E_earth)/(T_sky-T_earth);
      end if;

      T_earth=((-E_earth/(0.93*5.67))^0.25)*100;//-273.15
      T_sky=((E_sky/(0.93*5.67))^0.25)*100;//-273.15

      T_eqLWs=((T_earth-(T_air))*(1-phiprivate)+(T_sky-(T_air))*phiprivate)*((eowo*alpharad)/(alphaowo*0.93));
      T_eqLW=T_eqLWs*abs(sunblindsig-unitvec);

      T_eqSW=solarRad_in.I*aowo/alphaowo;

      T_eqWin=(T_air*unitvec)+T_eqLW;
      T_eqWall=(T_air+T_eqLWs)*unitvec+T_eqSW;
    //  T_ground is currently a parameter

      //temperatureequalwindowcelsius = Modelica.SIunits.Conversions.to_degC(temperatureequalwindow);
      //temperatureequalwallcelsius = Modelica.SIunits.Conversions.to_degC(temperatureequalwall);
      //temperaturegroundcelsius = Modelica.SIunits.Conversions.to_degC(temperatureground);

      equalAirTemp.T = T_eqWall*wf_wall + T_eqWin*wf_win + T_ground*wf_ground;

      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),
                          graphics), Icon(graphics={
            Rectangle(
              extent={{-70,-76},{78,76}},
              lineColor={0,128,255},
              lineThickness=1,
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{20,46},{60,-76}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{60,46},{2,46},{60,74},{60,70},{60,46}},
              lineColor={0,0,0},
              smooth=Smooth.None,
              fillColor={255,85,85},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-60,72},{-28,40}},
              lineColor={255,255,0},
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-70,-76},{78,-90}},
              lineColor={0,127,0},
              fillColor={0,127,0},
              fillPattern=FillPattern.Forward),
            Line(
              points={{-54,-74},{-58,-66},{-50,-62},{-56,-54},{-52,-50},{-54,-44}},
              color={0,0,0},
              smooth=Smooth.Bezier,
              thickness=1),
            Line(
              points={{-58,-48},{-54,-40},{-50,-46}},
              color={0,0,0},
              thickness=1,
              smooth=Smooth.Bezier),
            Line(
              points={{-40,-74},{-44,-66},{-36,-62},{-42,-54},{-38,-50},{-40,-44}},
              color={0,0,0},
              smooth=Smooth.Bezier,
              thickness=1),
            Line(
              points={{-44,-48},{-40,-40},{-36,-46}},
              color={0,0,0},
              thickness=1,
              smooth=Smooth.Bezier),
            Line(
              points={{-50,34},{-50,10}},
              color={255,255,0},
              thickness=1,
              smooth=Smooth.Bezier),
            Line(
              points={{-36,36},{-24,14}},
              color={255,255,0},
              thickness=1,
              smooth=Smooth.Bezier),
            Line(
              points={{-24,46},{-6,32}},
              color={255,255,0},
              thickness=1,
              smooth=Smooth.Bezier),
            Line(
              points={{12,-30},{12,-68},{6,-70},{4,-60},{4,-30},{10,-22},{12,-30}},
              color={0,0,0},
              thickness=1,
              smooth=Smooth.Bezier),
            Line(
              points={{10,-48},{12,-38},{14,-48}},
              color={0,0,0},
              thickness=1,
              smooth=Smooth.Bezier)}),
        Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<ul>
<li>This component computes the so called &QUOT;equivalent outdoor air temperature&QUOT;. Basically, this includes a correction for the longwave and shortwave radiance (not on windows!). </li>
<li>The computed temperature is the temperature near the wall surface. The radiant and convective heat transfer is considered in the model. The next component connected to the heat port should be the description of the heat conductance through the wall.</li>
<li>This component was written for usage in combination with the <a href=\"AixLib.Building.LowOrder.BaseClasses.ReducedOrderModel\">ReducedOrderModel</a> (see <a href=\"AixLib.Building.LowOrder.BaseClasses.ThermalZonePhysics\">ThermalZonePhysics</a>). As input it needs weather data, radiance (beam) by the radiance input and longwave sky radiation, longwave terrestric radiation and air temperature by the Real WeatherData input. There is the possibility to link a <a href=\"AixLib.Building.Components.Weather.Sunblind\">Sunblind</a> by the sunblindsig input. This takes the changes in radiation on the windows through a closed shading into account.</li>
<li>Weightfactors: The different equivalent temperatures for the different directions (due to shortwave radiance and the ground) are weighted and summed up with the weightfactors. See VDI 6007 for more information about the weightfactors (equation: U_i*A_i/sum(U*A)). As the equivalent temperature is a weighted temperature for all surfaces and it was originally written for building zones, the temperature of the ground under the thermal zone can be considered (weightfactorgound &GT; 0). The sum of all weightfactors should be 1.</li>
<li>Additionally, you need the coefficient of heat transfer and the coefficient of absorption on the outer side of the walls and windows for all directions (weighted scalars) . The coefficient of absorption is different to the emissivity due to the spectrum of the sunlight (0.6 might be a good choice).</li>
</ul>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Known Limitations</span></h4>
<p>The heat transfer through the radiance is considered by an alpha. It is computed and is somewhere around 5. In cases of exorbitant high radiance values, this alpha could be not as accurate as a real T^4 equation.</p>
<p>The longwave radiation is normally also considered for each direction separately, but this means that you need the angles for each direction. As the longwave term has no great impact on the equivalent temperature, the improvement is not worth the costs. Phiprivate is set to 0.5. Nonetheless, the parameters are prepared, but the equations for phiprivate ( in which the angles have an effect) are not yet implemented.</p>
<p>In addition, the convective heat transfer coefficient alpha is weighted over the areas per each direction. In VDI 6007, alpha is considered for each element and not averaged per direction. This may cause deviations if the alphas of the single elements are considerabely different. </p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>To the air temperature is added (or substracted) a term for longwave radiation and one term for shortwave radiation. As the shortwave radiation is taken into account only for the walls and the windows can be equipped with a shading, the equal temperatures are computed separately for the windows and for the walls. Due to the different beams in different directions, the temperatures are also computed separately for each direction. You need one weightfactor per direction and wall or window, e.g. 4 directions means 8 weightfactors (4 windows, 4 walls). Additionally, one weightfactor for the ground (for the ground temperature) .</p>
<p><br>First, a temperature of the earth (not the ground temperature!) and temperature of the sky are computed. The difference is taken into account for the longwave radiance term. </p>
<p>For the windows, the shading input is considered on the longwave term.</p>
<p>For the walls, the shortwave radiance term is computed with the beam of the radiance input.</p>
<p>The n temperature of the walls, the n temperature of the windows and the ground temperature are weighted with the weightfactors and summed up. As this equations only works in &deg;C, the unit is changed and rechanged to use Kelvin for the heat port again.</p>
<p><br><br><b><font style=\"color: #008000; \">References</font></b></p>
<ul>
<li>German Association of Engineers: Guideline VDI 6007-1, March 2012: Calculation of transient thermal response of rooms and buildings - Modelling of rooms.</li>
<li>Lauster, Moritz; Remmen, Peter; Fuchs, Marcus; Teichmann, Jens; Streblow, Rita; M&uuml;ller, Dirk (2014): Modelling long-wave radiation heat exchange for thermal network building simulations at urban scale using Modelica. In: the 10th International Modelica Conference, March 10-12, 2014, Lund, Sweden, March 10-12, 2014: Link&ouml;ping University Electronic Press (Link&ouml;ping Electronic Conference Proceedings), p. 125&ndash;133. DOI: <a href=\"http://dx.doi.org/10.3384/ECP14096125\">10.3384/ECP14096125</a></p>.</li>
<li>Lauster, M.; Teichmann, J.; Fuchs, M.; Streblow, R.; Mueller, D. (2014): Low order thermal network models for dynamic simulations of buildings on city district scale. In: Building and Environment 73, p. 223&ndash;231. DOI: <a href=\"http://dx.doi.org/10.1016/j.buildenv.2013.12.016\">10.1016/j.buildenv.2013.12.016</a></p>.</li>
</ul>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p>See <a href=\"AixLib.Building.LowOrder.Validation\">Validation</a> for some results.</p>
</html>",   revisions="<html>
<p><ul>
<li><i>January 2012,&nbsp;</i> by Moritz Lauster:<br/>Implemented.</li>
</ul></p>
</html>"));
    end EqAirTemp;

    model ReducedOrderModel
      "Low Order building envelope model corresponding to VDI 6007"

      parameter Boolean withInnerwalls=true "If inner walls are existent"   annotation(Dialog(tab="Inner walls"));
      parameter Modelica.SIunits.ThermalResistance R1i=0.0005955
        "Resistor 1 inner wall"
        annotation(Dialog(tab="Inner walls",enable = if withInnerwalls then true else false));
      parameter Modelica.SIunits.HeatCapacity C1i=14860000
        "Capacity 1 inner wall"
        annotation(Dialog(tab="Inner walls",enable = if withInnerwalls then true else false));
      parameter Modelica.SIunits.Area Ai=75.5 "Inner wall area"
        annotation(Dialog(tab="Inner walls",enable = if withInnerwalls then true else false));
      parameter Modelica.SIunits.Temp_K T0all=295.15
        "Initial temperature for all components";
      parameter Boolean withWindows=true "If windows are existent"   annotation(Dialog(tab="Outer walls",group = "Windows",enable = if withOuterwalls then true else false));
      parameter Real splitfac=0 "Factor for conv. part of rad. through windows"
       annotation(Dialog(tab="Outer walls",group = "Windows",enable = if withWindows and withOuterwalls then true else false));
      parameter Modelica.SIunits.Area Aw=10.5 "Window area"
        annotation(Dialog(tab="Outer walls",group = "Windows",enable = if withWindows and withOuterwalls then true else false));
      parameter Modelica.SIunits.Emissivity epsw=0.95
        "Emissivity of the windows"
        annotation(Dialog(tab="Outer walls",group = "Windows",enable = if withWindows and withOuterwalls then true else false));
      parameter Modelica.SIunits.TransmissionCoefficient g=0.7
        "Total energy transmittance"
        annotation(Dialog(tab="Outer walls",group = "Windows",enable = if withWindows and withOuterwalls then true else false));
      parameter Boolean withOuterwalls=true
        "If outer walls (including windows) are existent"  annotation(Dialog(tab="Outer walls"));
      parameter Modelica.SIunits.ThermalResistance RRest=0.0427487
        "Resistor Rest outer wall"
        annotation(Dialog(tab="Outer walls",enable = if withOuterwalls then true else false));
      parameter Modelica.SIunits.ThermalResistance R1o=0.004366
        "Resistor 1 outer wall"
        annotation(Dialog(tab="Outer walls",enable = if withOuterwalls then true else false));
      parameter Modelica.SIunits.HeatCapacity C1o=1557570
        "Capacity 1 outer wall"
        annotation(Dialog(tab="Outer walls",enable = if withOuterwalls then true else false));
      parameter Modelica.SIunits.Area Ao=10.5 "Outer wall area"
        annotation(Dialog(tab="Outer walls",enable = if withOuterwalls then true else false));
      parameter Modelica.SIunits.Volume Vair=52.5
        "Volume of the air in the zone"
        annotation(Dialog(tab="Room air"));
      parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaiwi=2.7
        "Coefficient of heat transfer for inner walls"
        annotation(Dialog(tab="Inner walls",enable = if withInnerwalls then true else false));
      parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaowi=2.7
        "Outer wall's coefficient of heat transfer (inner side)"
        annotation(Dialog(tab="Outer walls",enable = if withOuterwalls then true else false));
      parameter Modelica.SIunits.Density rhoair=1.19 "Density of the air"
        annotation(Dialog(tab="Room air"));
      parameter Modelica.SIunits.SpecificHeatCapacity cair=1007
        "Heat capacity of the air"
        annotation(Dialog(tab="Room air"));
      parameter Modelica.SIunits.Emissivity epsi=0.95
        "Emissivity of the inner walls"
        annotation(Dialog(tab="Inner walls",enable = if withInnerwalls then true else false));
      parameter Modelica.SIunits.Emissivity epso=0.95
        "Emissivity of the outer walls"
        annotation(Dialog(tab="Outer walls",enable = if withOuterwalls then true else false));

      Components.DryAir.Airload airload(
        V=Vair,
        rho=rhoair,
        c=cair,
        T(nominal=293.15,
          min=278.15,
          max=323.15)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={2,2})));
      Utilities.HeatTransfer.HeatConv heatConvInnerwall(A=Ai, alpha=
            alphaiwi) if                                                    withInnerwalls
        annotation (Placement(transformation(extent={{28,-10},{48,10}})));

      SimpleOuterWall outerwall(
        RRest=RRest,
        R1=R1o,
        C1=C1o,
        T0=T0all,
        port_b(T(
            nominal=293.15,
            min=278.15,
            max=323.15))) if
                     withOuterwalls
        annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
      SimpleInnerWall innerwall(
        R1=R1i,
        C1=C1i,
        T0=T0all,
        port_a(T(
            nominal=293.15,
            min=278.15,
            max=323.15))) if
                     withInnerwalls
              annotation (Placement(transformation(extent={{56,-10},{76,10}})));

      Utilities.HeatTransfer.HeatConv heatConvOuterwall(A=Ao, alpha=
            alphaowi) if withOuterwalls
        annotation (Placement(transformation(extent={{-24,-10},{-44,10}})));

      Utilities.HeatTransfer.HeatToStar heatToStarOuterwall(eps=epso, A=Ao) if
                           withOuterwalls annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-46,22})));
      Utilities.HeatTransfer.HeatToStar heatToStarInnerwall(A=Ai, eps=epsi) if   withInnerwalls
        annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={52,22})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a internalGainsConv(T(
          nominal=273.15 + 22,
          min=273.15 - 30,
          max=273.15 + 60)) annotation (Placement(transformation(extent={{10,-100},{
                30,-80}}), iconTransformation(extent={{0,-100},{40,-60}})));
      Components.DryAir.VarAirExchange airExchange(
        V=Vair,
        c=cair,
        rho=rhoair)
        annotation (Placement(transformation(extent={{-44,-40},{-24,-20}})));
      Modelica.Blocks.Interfaces.RealInput ventilationRate annotation (Placement(
            transformation(
            extent={{20,-20},{-20,20}},
            rotation=270,
            origin={-40,-100}), iconTransformation(
            extent={{20,-20},{-20,20}},
            rotation=270,
            origin={-40,-80})));
    public
      Modelica.Blocks.Interfaces.RealInput ventilationTemperature annotation (
          Placement(transformation(extent={{-120,-82},{-80,-42}}),
            iconTransformation(extent={{-100,-28},{-60,-68}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a equalAirTemp if
        withOuterwalls annotation (Placement(transformation(extent={{-110,-20},{-70,
                20}}), iconTransformation(extent={{-100,-16},{-60,24}})));
      Utilities.Interfaces.Star internalGainsRad annotation (Placement(
            transformation(extent={{70,-100},{90,-80}}), iconTransformation(
              extent={{54,-102},{100,-58}})));
      Utilities.HeatTransfer.SolarRadToHeat solarRadToHeatWindowRad(coeff=g,
          A=Aw) if                                                               withWindows and withOuterwalls
        annotation (Placement(transformation(extent={{-46,74},{-26,94}},
              rotation=0)));
      Utilities.Interfaces.SolarRad_in solarRad_in if withWindows and withOuterwalls
        annotation (Placement(transformation(extent={{-102,60},{-82,80}},
              rotation=0), iconTransformation(extent={{-102,34},{-60,74}})));

      SolarRadMultiplier solarRadMultiplierWindowRad(x=1 - splitfac) if
        withWindows and withOuterwalls
        annotation (Placement(transformation(extent={{-72,72},{-52,92}})));
      SolarRadMultiplier solarRadMultiplierWindowConv(x=splitfac) if   withWindows
         and withOuterwalls
        annotation (Placement(transformation(extent={{-72,48},{-52,68}})));
      Utilities.HeatTransfer.SolarRadToHeat solarRadToHeatWindowConv(A=Aw,
          coeff=g) if                                                             withWindows and withOuterwalls
        annotation (Placement(transformation(extent={{-46,50},{-26,70}},
              rotation=0)));
      Utilities.HeatTransfer.HeatToStar heatToStarWindow(A=Aw, eps=epsw) if   withWindows and withOuterwalls
        annotation (Placement(transformation(extent={{-20,72},{0,92}})));

      Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
        ventilationTemperatureConverter annotation (Placement(transformation(
            extent={{-8,-8},{8,8}},
            rotation=90,
            origin={-68,-42})));
    initial equation
      if abs(Aw) < 0.00001 and withWindows then
        Modelica.Utilities.Streams.print("WARNING!:in ReducedModel, withWindows is true (windows existent), but the area of the windows Aw is zero (or nearly zero). This might cause an error.");
      end if;
      if abs(Ao) < 0.00001 and withOuterwalls then
        Modelica.Utilities.Streams.print("WARNING!:in ReducedModel,withWindows is true (windows existent), but the area of the windows Aw is zero (or nearly zero). This might cause an error.");
      end if;
      if abs(Ai) < 0.00001 and withInnerwalls then
        Modelica.Utilities.Streams.print("WARNING!:in ReducedModel,withWindows is true (windows existent), but the area of the windows Aw is zero (or nearly zero). This might cause an error.");
      end if;

    equation
      if withWindows and withOuterwalls then
        connect(solarRad_in, solarRadMultiplierWindowRad.solarRad_in) annotation (Line(
            points={{-92,70},{-75,70},{-75,82},{-71,82}},
            color={255,128,0},
            smooth=Smooth.None));
        connect(solarRad_in, solarRadMultiplierWindowConv.solarRad_in) annotation (Line(
            points={{-92,70},{-75,70},{-75,58},{-71,58}},
            color={255,128,0},
            smooth=Smooth.None));
        connect(solarRadMultiplierWindowRad.solarRad_out, solarRadToHeatWindowRad.solarRad_in)
          annotation (Line(
            points={{-53,82},{-46.1,82}},
            color={255,128,0},
            smooth=Smooth.None));
        connect(solarRadMultiplierWindowConv.solarRad_out, solarRadToHeatWindowConv.solarRad_in)
          annotation (Line(
            points={{-53,58},{-46.1,58}},
            color={255,128,0},
            smooth=Smooth.None));
        connect(solarRadToHeatWindowRad.heatPort, heatToStarWindow.Therm)
          annotation (Line(
            points={{-27,82},{-19.2,82}},
            color={191,0,0},
            smooth=Smooth.None));
        if withOuterwalls then
        else
          assert(withOuterwalls,"There must be outer walls, windows have to be counted too!");
        end if;
        if withInnerwalls then
        end if;
      end if;

      if withOuterwalls then
        connect(equalAirTemp, outerwall.port_a) annotation (Line(
            points={{-90,0},{-80,0},{-80,-0.909091},{-70,-0.909091}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(outerwall.port_b, heatToStarOuterwall.Therm) annotation (Line(
            points={{-50,-0.909091},{-46,-0.909091},{-46,12.8}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(outerwall.port_b, heatConvOuterwall.port_b) annotation (Line(
            points={{-50,-0.909091},{-46.5,-0.909091},{-46.5,0},{-44,0}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(heatConvOuterwall.port_a, airload.port) annotation (Line(
            points={{-24,0},{-7,0}},
            color={191,0,0},
            smooth=Smooth.None));
        if withInnerwalls then
        else
        end if;
      end if;

      if withInnerwalls then
        connect(innerwall.port_a, heatConvInnerwall.port_b) annotation (Line(
            points={{56,-0.909091},{51.5,-0.909091},{51.5,0},{48,0}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(internalGainsRad, heatToStarInnerwall.Star) annotation (Line(
            points={{80,-90},{80,54},{10,54},{10,40},{52,40},{52,31.1}},
            color={95,95,95},
            pattern=LinePattern.None,
            smooth=Smooth.None));
      end if;

      connect(airExchange.port_b, airload.port)                  annotation (
          Line(
          points={{-24,-30},{-16,-30},{-16,0},{-7,0}},
          color={191,0,0},
          smooth=Smooth.None));

      connect(internalGainsConv, airload.port) annotation (Line(
          points={{20,-90},{20,-30},{-16,-30},{-16,0},{-7,0}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(airload.port, heatConvInnerwall.port_a) annotation (Line(
          points={{-7,0},{-16,0},{-16,-30},{20,-30},{20,0},{28,0}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(heatToStarInnerwall.Therm, innerwall.port_a) annotation (Line(
          points={{52,12.8},{52,-0.909091},{56,-0.909091}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(heatToStarOuterwall.Star, internalGainsRad) annotation (Line(
          points={{-46,31.1},{-46,40},{10,40},{10,54},{80,54},{80,-90}},
          color={95,95,95},
          pattern=LinePattern.None,
          smooth=Smooth.None));
      connect(heatToStarWindow.Star, internalGainsRad) annotation (Line(
          points={{-0.9,82},{10,82},{10,54},{80,54},{80,-90}},
          color={95,95,95},
          pattern=LinePattern.None,
          smooth=Smooth.None));
      connect(solarRadToHeatWindowConv.heatPort, airload.port) annotation (Line(
          points={{-27,58},{-16,58},{-16,0},{-7,0}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(ventilationRate, airExchange.InPort1) annotation (Line(
          points={{-40,-100},{-40,-60},{-50,-60},{-50,-36.4},{-43,-36.4}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(ventilationTemperature, ventilationTemperatureConverter.T)
        annotation (Line(
          points={{-100,-62},{-68,-62},{-68,-51.6}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(ventilationTemperatureConverter.port, airExchange.port_a) annotation (
         Line(
          points={{-68,-34},{-68,-30},{-44,-30}},
          color={191,0,0},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),
                          graphics),
        experiment(StopTime=864000),
        experimentSetupOutput,
        Icon(graphics={
            Rectangle(
              extent={{-60,74},{100,-72}},
              lineColor={135,135,135},
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{14,38},{46,12}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Rectangle(
              extent={{14,12},{46,-14}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Rectangle(
              extent={{-18,12},{14,-14}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Rectangle(
              extent={{-18,38},{14,12}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineThickness=1)}),
        Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<ul>
<li>ReducedOrderModel is a simple component to compute the air temperature, heating load, etc. for a thermal zone. The zone is simplified to one outer wall, one inner wall and one air node. It is build out of standard components and <a href=\"AixLib.Building.LowOrder.BaseClasses.SimpleOuterWall\">SimpleOuterWall</a> and <a href=\"AixLib.Building.LowOrder.BaseClasses.SimpleInnerWall\">SimpleInnerWall</a>.</li>
<li>The simplifications are based on the VDI 6007, which describes the thermal behaviour of a thermal zone with the equations for an electric circuit, hence they are equal. The heat transfer is described with resistances and the heat storage with capacitances.</li>
<li>The resolution of the model is very rough (only one air node), so the model is primarly thought for computing the air temperature of the room and with that, the heating and cooling load. It is more a heat load generator than a full building model. It is thought mainly for city district simulations, in which a lot of buildings has to be taken into account and the specific cirumstances in one building can be neglected.</li>
<li>Inputs: The model needs the outdoor air temperature and the Infiltration/VentilationRate for the Ventilation, the equivalent outdoor temperature (see <a href=\"AixLib.Building.LowOrder.BaseClasses.EqAirTemp\">EqAirTemp</a>) for the heat conductance through the outer walls and the solar radiation through the windows. There are two ports, one thermal, one star, for inner loads, heating etc. . </li>
<li>Parameters: Inner walls: R and C for the heat conductance and storage in the wall, A, alpha and epsilon for the heat transfer. Outer walls: Similar to inner walls, but with two R&apos;s, as there is also a conductance through the walls. Windows: g, A, epsilon and a splitfac. Please see VDI 6007 for computing the R&apos;s and C&apos;s.</li>
</ul>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The concept is described in VDI 6007. All outer walls and inner walls (including the windows) are merged together to one wall respectively. The inner walls are used as heat storages only, there is no heat transfer out of the zone (adiabate). This assumption is valid as long as the walls are in the zone or touch zones with a similar temperature. All walls, which touch other thermal zones are put together in the outer walls, which have an heat transfer with <a href=\"AixLib.Building.LowOrder.BaseClasses.EqAirTemp\">EqAirTemp</a>.</p>
<p>The two different &QUOT;wall types&QUOT; are connected through a convective heat circuit and a star circuit (different as in VDI 6007). As the air node can only react to convective heat, it is integrated in the convectice heat circuit. To add miscellaneous other heat sources/sinks (inner loads, heating) to the circiuts, there is one heat port to the convective circuit and one star port to the star circuit.</p>
<p>The last influence is the solar radiation through the windows. The heat transfer through the windows is considered in the outer walls. The beam is considered in the star circuit. There is a bypass from the beam to the convective circuit implemented, as a part of the beam is sometimes considered directly as convective heat.</p>
<p><br><b><font style=\"color: #008000; \">References</font></b></p>
<ul>
<li>German Association of Engineers: Guideline VDI 6007-1, March 2012: Calculation of transient thermal response of rooms and buildings - Modelling of rooms.</li>
<li>Lauster, M.; Teichmann, J.; Fuchs, M.; Streblow, R.; Mueller, D. (2014): Low order thermal network models for dynamic simulations of buildings on city district scale. In: Building and Environment 73, p. 223&ndash;231. DOI: <a href=\"http://dx.doi.org/10.1016/j.buildenv.2013.12.016\">10.1016/j.buildenv.2013.12.016</a></p>.</li>
</ul>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p>See <a href=\"AixLib.Building.LowOrder.Validation\">Vadliation</a> for some results. </p>
</html>",     revisions="<html>
<p><ul>
<li><i>January 2012,&nbsp;</i> by Moritz Lauster:<br/>Implemented.</li>
</ul></p>
</html>"));
    end ReducedOrderModel;

    model SimpleInnerWall "1 capacitance, 1 resistance"
      import SI = Modelica.SIunits;
      parameter SI.ThermalResistance R1=1 "Resistance 1";
      parameter SI.HeatCapacity C1=1 "Capacity 1";
      parameter Modelica.SIunits.Temp_K T0=295.15
        "Initial temperature for all components";
      //parameter SI.Area A=16 "Wall Area";

      Modelica.Thermal.HeatTransfer.Components.ThermalResistor
                                 Res1(R=R1)                    annotation (
          Placement(transformation(extent={{-18,18},{2,38}}, rotation=0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}},
              rotation=0), iconTransformation(extent={{-110,-10},{-90,10}})));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor load1(C=C1, T(start=T0))
        annotation (Placement(transformation(extent={{32,4},{52,24}})));
    equation
      connect(port_a, Res1.port_a) annotation (Line(
          points={{-100,0},{-60,0},{-60,28},{-18,28}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(Res1.port_b, load1.port) annotation (Line(
          points={{2,28},{20,28},{20,0},{42,0},{42,4}},
          color={191,0,0},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-100,
                -100},{100,120}}),
                          graphics), Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<ul>
<li>This thermal model represents the one dimensional heat transfer into a simple wall with dynamic characteristics (heat storage, 1 capacitance). Therefore, this (inner) wall is only used as a heat storage with a heat resistance.</li>
<li>It is based on the VDI 6007, in which the heat transfer through inner walls is described by a comparison with an electric circuit.</li>
<li>Normally, it should be used together with the other parts of the VDI 6007 model library. It represents all walls with a heat transfer in only one zone. Make sure, you got the right R&apos;s and C&apos;s (e.g. like they are computed in VDI 6007).</li>
</ul>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars4.png\"/></p>
<h4><span style=\"color:#008000\">Assumptions</span></h4>
<p>The model underlies all assumptions which are made in VDI 6007, especially that all heat transfer parts are combined in one part. It can be used in combination with various other models.</p>
<h4><span style=\"color:#008000\">Known Limitations</span></h4>
<p>There are no known limitaions.</p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The model works like an electric circuit as the equations of heat transfer are similar to them. All elements used in the model are taken from the EBC standard library.</p>
<p><br><b><font style=\"color: #008000; \">References</font></b></p>
<ul>
<li>German Association of Engineers: Guideline VDI 6007-1, March 2012: Calculation of transient thermal response of rooms and buildings - Modelling of rooms.</li>
</ul>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p>The wall model is tested and validated in the context of the <a href=\"AixLib.Building.LowOrder.BaseClasses.ReducedOrderModel\">ReducedOrderModel</a>. See <a href=\"AixLib.Building.LowOrder.Validation\">Validation</a> for some results.</p>
</html>",   revisions="<html>
<p><ul>
<li><i>January 2012,&nbsp;</i> by Moritz Lauster:<br/>Implemented.</li>
</ul></p>
</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                120}}),
             graphics={
            Rectangle(
              extent={{-86,60},{-34,26}},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              lineColor={175,175,175}),
            Rectangle(
              extent={{-28,60},{26,26}},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              lineColor={175,175,175}),
            Rectangle(
              extent={{32,60},{86,26}},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              lineColor={175,175,175}),
            Rectangle(
              extent={{0,20},{54,-14}},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              lineColor={175,175,175}),
            Rectangle(
              extent={{-60,20},{-6,-14}},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              lineColor={175,175,175}),
            Rectangle(
              extent={{-86,-20},{-34,-54}},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              lineColor={175,175,175}),
            Rectangle(
              extent={{-28,-20},{26,-54}},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              lineColor={175,175,175}),
            Rectangle(
              extent={{32,-20},{86,-54}},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              lineColor={175,175,175}),
            Rectangle(
              extent={{-60,-60},{-6,-94}},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              lineColor={175,175,175}),
            Rectangle(
              extent={{0,-60},{54,-94}},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              lineColor={175,175,175}),
            Rectangle(
              extent={{-60,100},{-6,66}},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              lineColor={175,175,175}),
            Rectangle(
              extent={{0,100},{54,66}},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              lineColor={175,175,175}),
            Rectangle(
              extent={{60,-60},{114,-94}},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              lineColor={175,175,175}),
            Rectangle(
              extent={{60,20},{116,-14}},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              lineColor={175,175,175}),
            Rectangle(
              extent={{60,100},{116,66}},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              lineColor={175,175,175}),
            Rectangle(
              extent={{-120,-60},{-66,-94}},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              lineColor={175,175,175}),
            Rectangle(
              extent={{-120,20},{-66,-14}},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              lineColor={175,175,175}),
            Rectangle(
              extent={{-120,100},{-66,66}},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              lineColor={175,175,175}),
            Rectangle(
              extent={{-88,120},{-120,-100}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
            Rectangle(
              extent={{120,120},{89,-100}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
            Line(
              points={{-90,0},{-2,0}},
              color={0,0,0},
              thickness=0.5,
              smooth=Smooth.None),
            Rectangle(
              extent={{-74,12},{-26,-10}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-2,0},{-2,-32}},
              color={0,0,0},
              thickness=0.5,
              smooth=Smooth.None),
            Rectangle(
              extent={{15,-32},{-19,-44}},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
            Line(
              points={{-19,-32},{15,-32}},
              pattern=LinePattern.None,
              thickness=0.5,
              smooth=Smooth.None),
            Line(
              points={{-19,-44},{15,-44}},
              pattern=LinePattern.None,
              thickness=0.5,
              smooth=Smooth.None),
            Text(
              extent={{-90,142},{90,104}},
              lineColor={0,0,255},
              textString="%name")}));
    end SimpleInnerWall;

    model SimpleOuterWall "1 capacitance, 2 resistors"
      import SI = Modelica.SIunits;
      parameter SI.ThermalResistance RRest=1 "Resistor Rest";
      parameter SI.ThermalResistance R1=1 "Resistor 1";
      parameter SI.HeatCapacity C1=1 "Capacity 1";
      //parameter SI.Area A=16 "Wall Area";
      parameter Modelica.SIunits.Temp_K T0=295.15
        "Initial temperature for all components";

      Modelica.Thermal.HeatTransfer.Components.ThermalResistor
                                 ResRest(R=RRest)
                                  annotation (Placement(transformation(extent={{-48,
                20},{-28,40}}, rotation=0)));
      Modelica.Thermal.HeatTransfer.Components.ThermalResistor
                                 Res1(R=R1)
                            annotation (Placement(transformation(extent={{38,20},{
                58,40}}, rotation=0)));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}},
              rotation=0), iconTransformation(extent={{-110,-10},{-90,10}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b annotation (
          Placement(transformation(extent={{90,-10},{110,10}}, rotation=0),
            iconTransformation(extent={{90,-10},{110,10}})));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor load1(C=C1, T(start=T0))
        annotation (Placement(transformation(extent={{-12,2},{8,-18}})));
    equation
      connect(port_a, ResRest.port_a) annotation (Line(
          points={{-100,0},{-62,0},{-62,30},{-48,30}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(ResRest.port_b, load1.port) annotation (Line(
          points={{-28,30},{-2,30},{-2,2}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(load1.port, Res1.port_a) annotation (Line(
          points={{-2,2},{-2,30},{38,30}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(Res1.port_b, port_b) annotation (Line(
          points={{58,30},{80,30},{80,0},{100,0}},
          color={191,0,0},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-100,-100},
                {100,120}}),
                          graphics), Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<ul>
<li>This thermal model represents the one dimensional heat transfer of a simple wall with dynamic characteristics (heat storage, 1 capacitance)</li>
<li>It is based on the VDI 6007, in which the heat transfer through outer walls is described by a comparison with an electric circuit.</li>
<li>Normally, it should be used together with the other parts of the VDI 6007 model library. It represents all walls with a heat transfer. Make sure, you got the right R&apos;s and C&apos;s (e.g. like they are computed in VDI 6007).</li>
</ul>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars4.png\"/></p>
<h4><span style=\"color:#008000\">Assumptions</span></h4>
<p>The model underlies all assumptions which are made in VDI 6007, especially that all heat transfer parts are combined in one part. It can be used in combination with various other models.</p>
<h4><span style=\"color:#008000\">Known Limitations</span></h4>
<p>There are no known limitaions.</p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The model works like an electric circuit as the equations of heat transfer are similar to them. All elements used in the model are taken from the EBC standard library.</p>
<p><br><b><font style=\"color: #008000; \">References</font></b></p>
<ul>
<li>German Association of Engineers: Guideline VDI 6007-1, March 2012: Calculation of transient thermal response of rooms and buildings - Modelling of rooms.</li>
</ul>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p>The wall model is tested and validated in the context of the <a href=\"AixLib.Building.LowOrder.BaseClasses.ReducedOrderModel\">ReducedOrderModel</a>. See <a href=\"AixLib.Building.LowOrder.Validation\">Validation</a> for some results.</p>
</html>",   revisions="<html>
<p><ul>
<li><i>January 2012,&nbsp;</i> by Moritz Lauster:<br/>Implemented.</li>
</ul></p>
</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                120}}),
             graphics={
            Rectangle(
              extent={{-86,60},{-34,26}},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              lineColor={175,175,175}),
            Rectangle(
              extent={{-28,60},{26,26}},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              lineColor={175,175,175}),
            Rectangle(
              extent={{32,60},{86,26}},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              lineColor={175,175,175}),
            Rectangle(
              extent={{0,20},{54,-14}},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              lineColor={175,175,175}),
            Rectangle(
              extent={{-60,20},{-6,-14}},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              lineColor={175,175,175}),
            Rectangle(
              extent={{-86,-20},{-34,-54}},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              lineColor={175,175,175}),
            Rectangle(
              extent={{-28,-20},{26,-54}},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              lineColor={175,175,175}),
            Rectangle(
              extent={{32,-20},{86,-54}},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              lineColor={175,175,175}),
            Rectangle(
              extent={{-60,-60},{-6,-94}},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              lineColor={175,175,175}),
            Rectangle(
              extent={{0,-60},{54,-94}},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              lineColor={175,175,175}),
            Rectangle(
              extent={{-60,100},{-6,66}},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              lineColor={175,175,175}),
            Rectangle(
              extent={{0,100},{54,66}},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              lineColor={175,175,175}),
            Rectangle(
              extent={{60,-60},{114,-94}},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              lineColor={175,175,175}),
            Rectangle(
              extent={{60,20},{116,-14}},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              lineColor={175,175,175}),
            Rectangle(
              extent={{60,100},{116,66}},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              lineColor={175,175,175}),
            Rectangle(
              extent={{-120,-60},{-66,-94}},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              lineColor={175,175,175}),
            Rectangle(
              extent={{-120,20},{-66,-14}},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              lineColor={175,175,175}),
            Rectangle(
              extent={{-120,100},{-66,66}},
              fillColor={255,213,170},
              fillPattern=FillPattern.Solid,
              lineColor={175,175,175}),
            Rectangle(
              extent={{-90,120},{-120,-100}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
            Rectangle(
              extent={{120,120},{89,-100}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
            Line(
              points={{-90,0},{90,0}},
              color={0,0,0},
              thickness=0.5,
              smooth=Smooth.None),
            Rectangle(
              extent={{-74,12},{-26,-10}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{28,12},{76,-10}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-1,0},{-1,-32}},
              color={0,0,0},
              thickness=0.5,
              smooth=Smooth.None),
            Rectangle(
              extent={{16,-32},{-18,-44}},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
            Line(
              points={{-18,-32},{16,-32}},
              pattern=LinePattern.None,
              thickness=0.5,
              smooth=Smooth.None),
            Line(
              points={{-18,-44},{16,-44}},
              pattern=LinePattern.None,
              thickness=0.5,
              smooth=Smooth.None),
            Text(
              extent={{-90,142},{90,104}},
              lineColor={0,0,255},
              textString="%name")}));
    end SimpleOuterWall;

    model SolarRadMultiplier "scalar radiant input * factor x"
      parameter Real x=1;
      Utilities.Interfaces.SolarRad_in solarRad_in annotation (Placement(
            transformation(extent={{-100,-10},{-80,10}})));
      Utilities.Interfaces.SolarRad_out solarRad_out
        annotation (Placement(transformation(extent={{80,-10},{100,10}})));
    equation
      solarRad_out.I=solarRad_in.I*x;
      annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<ul>
<li>Multiplies the scalar radiance input with a factor x</li>
<li>This component can be used to in- or decrease a scalar radiance, e.g. if you would like to split the radiance, use two blocks, one with x, one with 1-x.</li>
</ul>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
</html>",   revisions="<html>
<p><ul>
<li><i>January 2012,&nbsp;</i> by Moritz Lauster:<br/>Implemented.</li>
</ul></p>
</html>"),     Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}),
                       graphics),
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}}),
             graphics={
            Rectangle(
              extent={{-80,40},{80,-40}},
              lineColor={215,215,215},
              fillColor={239,239,159},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-80,20},{-40,-20}},
              lineColor={0,0,0},
              textString="I",
              fontName="Times New Roman"),
            Text(
              extent={{-60,12},{-20,-28}},
              lineColor={0,0,0},
              fontName="Times New Roman",
              textString="in"),
            Text(
              extent={{-50,20},{62,-20}},
              lineColor={0,0,0},
              fontName="Times New Roman",
              textString=" * fac"),
            Line(
              points={{54,0},{72,0},{62,6}},
              color={0,0,255},
              smooth=Smooth.None),
            Line(
              points={{72,0},{62,-6}},
              color={0,0,255},
              smooth=Smooth.None)}));
    end SolarRadMultiplier;

    model SolarRadWeightedSum
      "weights vec input and sums it up to one scalar output"
      parameter Integer n=1 "number of inputs and weightfactors";
      parameter Real weightfactors[n]={1}
        "weightfactors with which the inputs are to be weighted";

      Utilities.Interfaces.SolarRad_in solarRad_in[n] annotation (Placement(
            transformation(extent={{-100,0},{-80,20}}), iconTransformation(
              extent={{-100,-10},{-80,10}})));
      Utilities.Interfaces.SolarRad_out solarRad_out annotation (Placement(
            transformation(extent={{80,0},{100,20}}), iconTransformation(
              extent={{80,-10},{100,10}})));
    protected
      parameter Real sumWeightfactors = if (sum(weightfactors) == 0) then  0.0001 else sum(weightfactors);

    initial equation
      assert(n==size(weightfactors,1),"weightfactors (likely Aw) has to have n elements");
      if (sum(weightfactors)==0) then
        Modelica.Utilities.Streams.print("WARNING!:The sum of the weightfactors (likely the window areas) in rad_weighted_sum is 0. In case of no radiation (e.g. no windows) this might be correct.");
      end if;
    equation
      solarRad_out.I=solarRad_in.I*weightfactors/sumWeightfactors;
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),
                          graphics), Icon(graphics={
            Rectangle(extent={{-80,80},{80,-80}}, lineColor={0,0,0}),
            Text(
              extent={{-40,70},{-22,60}},
              lineColor={0,0,0},
              textString="*Gn"),
            Line(
              points={{-80,0},{-60,-20}},
              color={0,0,0},
              smooth=Smooth.None),
            Line(
              points={{-80,0},{-60,20}},
              color={0,0,0},
              smooth=Smooth.None),
            Line(
              points={{-80,0},{-60,60}},
              color={0,0,0},
              smooth=Smooth.None),
            Line(
              points={{72,0},{82,0},{20,0}},
              color={0,0,0},
              smooth=Smooth.None),
            Line(
              points={{-60,-20},{0,-20}},
              color={0,0,0},
              smooth=Smooth.None),
            Line(
              points={{-60,20},{0,20}},
              color={0,0,0},
              smooth=Smooth.None),
            Line(
              points={{-60,60},{0,60}},
              color={0,0,0},
              smooth=Smooth.None),
            Line(
              points={{-60,-60},{0,-60}},
              color={0,0,0},
              smooth=Smooth.None),
            Line(
              points={{-80,0},{-60,-60}},
              color={0,0,0},
              smooth=Smooth.None),
            Line(
              points={{0,20},{20,0}},
              color={0,0,0},
              smooth=Smooth.None),
            Line(
              points={{0,60},{20,0}},
              color={0,0,0},
              smooth=Smooth.None),
            Line(
              points={{20,0},{0,-60}},
              color={0,0,0},
              smooth=Smooth.None),
            Line(
              points={{0,-20},{20,0}},
              color={0,0,0},
              smooth=Smooth.None),
            Text(
              extent={{10,-2},{72,-14}},
              lineColor={0,0,0},
              textString="/sum(Gn)"),
            Text(
              extent={{-42,30},{-20,20}},
              lineColor={0,0,0},
              textString="*Gn"),
            Text(
              extent={{-42,-10},{-20,-20}},
              lineColor={0,0,0},
              textString="*Gn"),
            Text(
              extent={{-42,-50},{-20,-60}},
              lineColor={0,0,0},
              textString="*Gn")}),
        Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<ul>
<li>This component weights the n-vectorial radiant input with n weightfactors and has a scalar output.</li>
<li>There is one fundamental equation: input(n)*weightfactors(n)/sum(weightfactors).</li>
<li>You can use this component to weight a radiant input and sum it up to one scalar output, e.g. weight the radiance of the sun of n directions with the areas of windows in n directions and sum it up to one scalar radiance on a non-directional window</li>
</ul>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Known Limitations</span></h4>
<p>If the weightfactors are all zero, Dymola tries to divide through zero. You will get a warning and the output is set to zero.</p>
</html>",   revisions="<html>
<p><ul>
<li><i>January 2012,&nbsp;</i> by Moritz Lauster:<br/>Implemented.</li>
</ul></p>
</html>"));
    end SolarRadWeightedSum;

    model ThermalZonePhysics
      "All sub-models of VDI 6007 connected to one model"

      parameter Boolean withInnerwalls=true "If inner walls are existent"   annotation(Dialog(tab="Inner walls"));
      parameter Modelica.SIunits.ThermalResistance R1i=0.000656956
        "Resistor 1 inner wall"
        annotation(Dialog(tab="Inner walls",enable = if withInnerwalls then true else false));
      parameter Modelica.SIunits.HeatCapacity C1i=12049200
        "Capacity 1 inner wall"
        annotation(Dialog(tab="Inner walls",enable = if withInnerwalls then true else false));
      parameter Modelica.SIunits.Area Ai=60.5 "Inner wall area"
        annotation(Dialog(tab="Inner walls",enable = if withInnerwalls then true else false));
      parameter Modelica.SIunits.Temp_K T0all=295.15
        "Initial temperature for all components";
      parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaiwi=2.1
        "Coefficient of heat transfer for inner walls"
        annotation(Dialog(tab="Inner walls",enable = if withInnerwalls then true else false));
      parameter Boolean withOuterwalls=true
        "If outer walls (including windows) are existent"  annotation(Dialog(tab="Outer walls"));
      parameter Modelica.SIunits.ThermalResistance RRest=0.001717044
        "Resistor Rest outer wall"
        annotation(Dialog(tab="Outer walls",enable = if withOuterwalls then true else false));
      parameter Modelica.SIunits.ThermalResistance R1o=0.02045808
        "Resistor 1 outer wall"
        annotation(Dialog(tab="Outer walls",enable = if withOuterwalls then true else false));
      parameter Modelica.SIunits.HeatCapacity C1o=4896650
        "Capacity 1 outer wall"
        annotation(Dialog(tab="Outer walls",enable = if withOuterwalls then true else false));
      parameter Modelica.SIunits.Area Ao=25.5 "Outer wall area"
        annotation(Dialog(tab="Outer walls",enable = if withOuterwalls then true else false));
      parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaowi=2.7
        "Outer wall's coefficient of heat transfer (inner side)"
        annotation(Dialog(tab="Outer walls",enable = if withOuterwalls then true else false));
      parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaowo=20
        "Outer wall's coefficient of heat transfer (outer side) "
        annotation(Dialog(tab="Outer walls",enable = if withOuterwalls then true else false));
      parameter Modelica.SIunits.Emissivity epsi=1
        "Emissivity of the inner walls"
        annotation(Dialog(tab="Inner walls",enable = if withInnerwalls then true else false));
      parameter Modelica.SIunits.Emissivity epso=1
        "Emissivity of the outer walls"
        annotation(Dialog(tab="Outer walls",enable = if withOuterwalls then true else false));
      parameter Real aowo=0.7 "Coefficient of absorption of the outer walls"
        annotation(Dialog(tab="Outer walls",enable = if withOuterwalls then true else false));
      parameter Boolean withWindows=true "If windows are existent"   annotation(Dialog(tab="Windows",enable = if withOuterwalls then true else false));
      parameter Real splitfac = 0
        "Factor for conv. part of rad. through windows"                           annotation(Dialog(tab="Windows",enable = if withOuterwalls then true else false));
      parameter Modelica.SIunits.Area Aw[n]={1,1,1,1} "Area of the windows"
        annotation(Dialog(tab="Windows",enable = if withWindows and withOuterwalls then true else false));
      parameter Modelica.SIunits.TransmissionCoefficient gsunblind[n]={1,1,1,1}
        "Total energy transmittances if sunblind is closed"
        annotation(Dialog(tab="Windows",group="Shading",enable = if withWindows and withOuterwalls then true else false));
      parameter Modelica.SIunits.RadiantEnergyFluenceRate Imax=100
        "Intensity at which the sunblind closes"
        annotation(Dialog(tab="Windows",group="Shading",enable = if withWindows and withOuterwalls then true else false));
      parameter Integer n=4 "Number of orientations (without ground)" annotation(Dialog(tab="Outer walls",enable = if withOuterwalls then true else false));
      parameter Real weightfactorswall[n]={0.5,0.2,0.2,0.1}
        "Weight factors of the walls" annotation(Dialog(tab="Outer walls",enable = if withOuterwalls then true else false));
      parameter Real weightfactorswindow[n]={0,0,0,0}
        "Weight factors of the windows" annotation(Dialog(tab="Windows",enable = if withWindows and withOuterwalls then true else false));
      parameter Real weightfactorground=0
        "Weight factor of the earth (0 if not considered)" annotation(Dialog(tab="Outer walls",enable = if withOuterwalls then true else false));
      parameter Modelica.SIunits.Temp_K temperatureground=284.15
        "Temperature of the earth" annotation(Dialog(tab="Outer walls",enable = if withOuterwalls then true else false));
      parameter Modelica.SIunits.Emissivity epsw=0.95
        "Emissivity of the windows"
        annotation(Dialog(tab="Windows",enable = if withWindows and withOuterwalls then true else false));
      parameter Modelica.SIunits.TransmissionCoefficient g=0.7
        "Total energy transmittance"
        annotation(Dialog(tab="Windows",enable = if withWindows and withOuterwalls then true else false));
      parameter Modelica.SIunits.Volume Vair=52.5
        "Volume of the air in the zone"
        annotation(Dialog(tab="Room air"));
      parameter Modelica.SIunits.Density rhoair=1.19 "Density of the air"
        annotation(Dialog(tab="Room air"));
      parameter Modelica.SIunits.SpecificHeatCapacity cair=1007
        "Heat capacity of the air"
        annotation(Dialog(tab="Room air"));

      SolarRadWeightedSum solRadWeightedSum(n=n, weightfactors=Aw) if      withWindows and withOuterwalls
        annotation (Placement(transformation(extent={{0,56},{28,86}})));
      Components.Weather.Sunblind sunblind(
        Imax=Imax,
        n=n,
        gsunblind=gsunblind) if withWindows and withOuterwalls
        annotation (Placement(transformation(extent={{-26,62},{-6,82}})));
      Utilities.Interfaces.SolarRad_in solarRad_in[n] if       withOuterwalls
        annotation (Placement(transformation(extent={{-100,60},{-80,80}}),
            iconTransformation(extent={{-94,50},{-60,80}})));
      Modelica.Blocks.Interfaces.RealInput weather[3] if        withOuterwalls
        "[1]: Air temperature<br>[2]: Horizontal radiation of sky<br>[3]: Horizontal radiation of earth"
        annotation (Placement(transformation(extent={{-120,-10},{-80,30}}),
            iconTransformation(extent={{-90,4},{-60,34}})));
      Modelica.Blocks.Interfaces.RealInput ventilationRate annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={-28,-90}), iconTransformation(
            extent={{-14,-14},{14,14}},
            rotation=90,
            origin={-40,-86})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a internalGainsConv
        annotation (Placement(transformation(extent={{30,-100},{50,-80}}),
            iconTransformation(extent={{30,-100},{50,-80}})));
      Utilities.Interfaces.Star internalGainsRad annotation (Placement(
            transformation(extent={{70,-100},{90,-80}}), iconTransformation(
              extent={{70,-100},{90,-80}})));
      EqAirTemp eqAirTemp(
        alphaowo=alphaowo,
        aowo=aowo,
        wf_wall=weightfactorswall,
        wf_win=weightfactorswindow,
        wf_ground=weightfactorground,
        T_ground=temperatureground,
        n=n) if withOuterwalls
        annotation (Placement(transformation(extent={{-46,0},{-26,20}})));
      ReducedOrderModel reducedOrderModel(
        epsw=epsw,
        g=g,
        RRest=RRest,
        R1o=R1o,
        C1o=C1o,
        Ao=Ao,
        R1i=R1i,
        C1i=C1i,
        Ai=Ai,
        T0all=T0all,
        Vair=Vair,
        alphaiwi=alphaiwi,
        alphaowi=alphaowi,
        rhoair=rhoair,
        cair=cair,
        epsi=epsi,
        epso=epso,
        Aw=sum(Aw),
        withInnerwalls=withInnerwalls,
        withWindows=withWindows,
        withOuterwalls=withOuterwalls,
        splitfac=splitfac)
        annotation (Placement(transformation(extent={{18,-10},{76,46}})));
      Modelica.Blocks.Interfaces.RealInput ventilationTemperature annotation (
          Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=0,
            origin={-100,-50}), iconTransformation(
            extent={{-15,-15},{15,15}},
            rotation=0,
            origin={-76,-40})));
    equation
      if withWindows and withOuterwalls then
        connect(sunblind.sunblindonoff, eqAirTemp.sunblindsig) annotation (Line(
            points={{-16,63},{-26,63},{-26,18},{-36,18}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(solRadWeightedSum.solarRad_out, reducedOrderModel.solarRad_in) annotation (
            Line(
            points={{26.6,71},{26.6,52.25},{23.51,52.25},{23.51,33.12}},
            color={255,128,0},
            smooth=Smooth.None));
      end if;
      if withOuterwalls then
        connect(weather, eqAirTemp.weatherData) annotation (Line(
            points={{-100,10},{-44,10}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(solarRad_in, eqAirTemp.solarRad_in) annotation (Line(
            points={{-90,70},{-68,70},{-68,15.6},{-44.5,15.6}},
            color={255,128,0},
            smooth=Smooth.None));
        connect(eqAirTemp.equalAirTemp, reducedOrderModel.equalAirTemp)
          annotation (Line(
            points={{-28,10},{-2,10},{-2,19.12},{23.8,19.12}},
            color={191,0,0},
            smooth=Smooth.None));
      end if;
      connect(internalGainsConv, reducedOrderModel.internalGainsConv) annotation (Line(
          points={{40,-90},{40,-49},{52.8,-49},{52.8,-4.4}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(internalGainsRad, reducedOrderModel.internalGainsRad) annotation (Line(
          points={{80,-90},{80,-4.4},{69.33,-4.4}},
          color={95,95,95},
          pattern=LinePattern.None,
          smooth=Smooth.None));
      connect(ventilationRate, reducedOrderModel.ventilationRate)
        annotation (Line(
          points={{-28,-90},{4,-90},{4,-4.4},{35.4,-4.4}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(ventilationTemperature, reducedOrderModel.ventilationTemperature) annotation (
         Line(
          points={{-100,-50},{-12,-50},{-12,4.56},{23.8,4.56}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(sunblind.Rad_Out, solRadWeightedSum.solarRad_in) annotation (Line(
          points={{-7,73},{-2.5,73},{-2.5,71},{1.4,71}},
          color={255,128,0},
          smooth=Smooth.None));
      connect(solarRad_in, sunblind.Rad_In) annotation (Line(
          points={{-90,70},{-58,70},{-58,73},{-25,73}},
          color={255,128,0},
          smooth=Smooth.None));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}}),
                graphics),
        Icon(graphics={
            Rectangle(
              extent={{-60,80},{100,-58}},
              lineColor={0,128,255},
              lineThickness=1,
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-60,-58},{100,-70}},
              lineColor={0,127,0},
              lineThickness=1,
              fillColor={0,127,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{14,36},{100,-58}},
              lineColor={135,135,135},
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{100,36},{-2,36},{100,60},{100,36}},
              lineColor={255,85,85},
              lineThickness=1,
              smooth=Smooth.None,
              fillColor={255,85,85},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{64,12},{80,0}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{64,0},{80,-12}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{48,0},{64,-12}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{48,12},{64,0}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-50,72},{-22,44}},
              lineColor={255,255,0},
              lineThickness=1,
              fillColor={255,255,0},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-18,54},{-6,44}},
              color={255,255,0},
              thickness=1,
              smooth=Smooth.None),
            Line(
              points={{-26,44},{-18,32}},
              color={255,255,0},
              thickness=1,
              smooth=Smooth.None),
            Line(
              points={{-36,40},{-36,26}},
              color={255,255,0},
              thickness=1,
              smooth=Smooth.None),
            Line(
              points={{-48,-58},{-50,-52},{-46,-48},{-48,-42}},
              color={0,0,0},
              thickness=1,
              smooth=Smooth.Bezier),
            Line(
              points={{-40,-58},{-42,-52},{-38,-48},{-40,-42}},
              color={0,0,0},
              thickness=1,
              smooth=Smooth.Bezier),
            Line(
              points={{-32,-58},{-34,-52},{-30,-48},{-32,-42}},
              color={0,0,0},
              thickness=1,
              smooth=Smooth.Bezier),
            Line(
              points={{-50,-44},{-48,-40},{-46,-44}},
              color={0,0,0},
              thickness=1,
              smooth=Smooth.Bezier),
            Line(
              points={{-42,-44},{-40,-40},{-38,-44}},
              color={0,0,0},
              thickness=1,
              smooth=Smooth.Bezier),
            Line(
              points={{-34,-44},{-32,-40},{-30,-44}},
              color={0,0,0},
              thickness=1,
              smooth=Smooth.Bezier)}),
        experiment(StopTime=864000, Interval=3599),
        experimentSetupOutput,
        Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<ul>
<li>This model connects <a href=\"AixLib.Building.LowOrder.BaseClasses.ReducedOrderModel\">ReducedOrderModel</a> with <a href=\"AixLib.Building.Components.Weather.Sunblind\">Sunblind</a> and <a href=\"AixLib.Building.LowOrder.BaseClasses.EqAirTemp\">EqAirTemp</a>. All this models have been developed in the context of VDI 6007 to have the whole VDI 6007 model in Dymola. ThermalZonePhysics reflects all components described in the standard. </li>
<li>Additionally some other parts are used, like <a href=\"AixLib.Building.LowOrder.BaseClasses.SolarRadWeightedSum\">SolarRadWeightedSum</a>. They are necessary for an easy handling of the complex model. </li>
<li>Inputs: real weather vector, as defined in <a href=\"AixLib.Building.LowOrder.BaseClasses.EqAirTemp\">EqAirTemp</a>; vectorial SolarRad_in, the solar radiation (diffuse and direct) for all n directions; real infiltration/ventilation as defined in <a href=\"AixLib.Building.LowOrder.BaseClasses.ReducedOrderModel\">ReducedOrderModel</a>; one thermal and one star input for inner loads, heating, etc. . </li>
<li>Parameters: Most of the parameters are geometric and building pyhsic parameters and are used in the ReducedOrderModel or in the eqAirTemp component. See the documentation of the submodels or VDI 6007 for more information.</li>
</ul>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The concept is desrcibed in VDI 6007 and in the submodels. Basically, ThermalZonePhysics is thought for the easy computation of room temperatures and heat load profiles for thermal zones, e.g. buildings. To reduce computation time, number of parameters and work, some simplifications are implemented into the model (only one air node, ideal building technology, one outer wall, one inner wall). See VDI 6007 for more information.</p>
<p><br><b><font style=\"color: #008000; \">References</font></b></p>
<ul>
<li>German Association of Engineers: Guideline VDI 6007-1, March 2012: Calculation of transient thermal response of rooms and buildings - Modelling of rooms.</li>
<li>Lauster, M.; Teichmann, J.; Fuchs, M.; Streblow, R.; Mueller, D. (2014): Low order thermal network models for dynamic simulations of buildings on city district scale. In: Building and Environment 73, p. 223&ndash;231. DOI: <a href=\"http://dx.doi.org/10.1016/j.buildenv.2013.12.016\">10.1016/j.buildenv.2013.12.016</a></p>.</li>
</ul>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p>See <a href=\"AixLib.Building.LowOrder.Validation\">Validation</a> for some results.</p>
</html>",     revisions="<html>
<p><ul>
<li><i>January 2012,&nbsp;</i> by Moritz Lauster:<br/>Implemented.</li>
</ul></p>
</html>"));
    end ThermalZonePhysics;

  end BaseClasses;

  package Validation "Contains Test Cases from VDI 6007 Validation"
    package VDI6007
      extends Modelica.Icons.ExamplesPackage;
      model TestCase_1
        extends Modelica.Icons.Example;

        output Modelica.SIunits.Conversions.NonSIunits.Temperature_degC referenceTemp[1];
        output Modelica.SIunits.Temp_K simulationTemp;

        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature outdoorTemp(T=295.15)
          annotation (Placement(transformation(extent={{-56,8},{-36,28}})));
        Modelica.Blocks.Sources.Constant infiltrationTemp(k=22)
          annotation (Placement(transformation(extent={{-56,-22},{-36,-2}})));
        Modelica.Blocks.Sources.Constant infiltrationRate(k=0)
          annotation (Placement(transformation(extent={{-14,-50},{6,-30}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow machinesConvective
          annotation (Placement(transformation(extent={{-8,-86},{12,-66}})));
        Building.LowOrder.BaseClasses.ReducedOrderModel reducedModel(
          Ao=10.5,
          Aw=0.000000001,
          Ai=75.5,
          epsi=1,
          epso=1,
          epsw=1,
          g=1,
          alphaiwi=2.2,
          alphaowi=2.7,
          splitfac=0.09,
          R1i=0.000595515,
          C1i=1.48216e+007,
          withWindows=false,
          RRest=0.042748777,
          R1o=0.004366222,
          C1o=1.60085e+006)
          annotation (Placement(transformation(extent={{0,0},{34,34}})));
        Modelica.Blocks.Sources.CombiTimeTable tableMachines(
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          tableName="UserProfilesOffice",
          fileName="./Tables/J1615/UserProfilesOffice.txt",
          tableOnFile=false,
          table=[0,0; 3600,0; 7200,0; 10800,0; 14400,0; 18000,0; 21600,0; 21600,
              1000; 25200,1000; 28800,1000; 32400,1000; 36000,1000; 39600,1000;
              43200,1000; 46800,1000; 50400,1000; 54000,1000; 57600,1000; 61200,
              1000; 64800,1000; 64800,0; 68400,0; 72000,0; 75600,0; 79200,0;
              82800,0; 86400,0],
          columns={2})
          annotation (Placement(transformation(extent={{-40,-83},{-26,-69}})));
        Modelica.Blocks.Sources.CombiTimeTable reference(
          tableName="UserProfilesOffice",
          fileName="./Tables/J1615/UserProfilesOffice.txt",
          tableOnFile=false,
          columns={2},
          table=[3600,22; 7200,22; 10800,22; 14400,22; 18000,22; 21600,22; 25200,
              27.7; 28800,27.9; 32400,28.1; 36000,28.4; 39600,28.6; 43200,28.8;
              46800,29; 50400,29.2; 54000,29.4; 57600,29.6; 61200,29.8; 64800,30;
              68400,24.5; 72000,24.5; 75600,24.5; 79200,24.5; 82800,24.5; 86400,
              24.5; 781200,37.7; 784800,37.6; 788400,37.5; 792000,37.5; 795600,37.4;
              799200,37.3; 802800,43; 806400,43.2; 810000,43.3; 813600,43.5; 817200,
              43.6; 820800,43.8; 824400,43.9; 828000,44.1; 831600,44.3; 835200,44.4;
              838800,44.6; 842400,44.7; 846000,39.1; 849600,39.1; 853200,39; 856800,
              38.9; 860400,38.9; 864000,38.8; 5101200,49.9; 5104800,49.8; 5108400,
              49.7; 5112000,49.6; 5115600,49.4; 5119200,49.3; 5122800,54.9; 5126400,
              55.1; 5130000,55.2; 5133600,55.3; 5137200,55.4; 5140800,55.5; 5144400,
              55.6; 5148000,55.7; 5151600,55.8; 5155200,55.9; 5158800,56.1; 5162400,
              56.2; 5166000,50.6; 5169600,50.4; 5173200,50.3; 5176800,50.2; 5180400,
              50.1; 5184000,50],
          extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
          annotation (Placement(transformation(extent={{80,80},{100,99}})));
      equation

        referenceTemp = reference.y;
        simulationTemp = reducedModel.airload.port.T;

        connect(tableMachines.y[1], machinesConvective.Q_flow) annotation (Line(
            points={{-25.3,-76},{-8,-76}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(outdoorTemp.port, reducedModel.equalAirTemp) annotation (Line(
            points={{-36,18},{-14,18},{-14,17.68},{3.4,17.68}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(infiltrationTemp.y, reducedModel.ventilationTemperature)
          annotation (Line(
            points={{-35,-12},{-18,-12},{-18,8.84},{3.4,8.84}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(infiltrationRate.y, reducedModel.ventilationRate) annotation (
            Line(
            points={{7,-40},{10.2,-40},{10.2,3.4}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(machinesConvective.port, reducedModel.internalGainsConv)
          annotation (Line(
            points={{12,-76},{20.4,-76},{20.4,3.4}},
            color={191,0,0},
            smooth=Smooth.None));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                  -100,-100},{100,100}}),
                            graphics),
          experiment(StopTime=5.184e+006, Interval=3600),
          experimentSetupOutput(events=false), Documentation(revisions="<html>
<p><ul>
<li><i>March, 2012&nbsp;</i> by Moritz Lauster:<br/>Implemented</li>
</ul></p>
<p><br/><br/> </p>
</html>",     info="<html>
<p>Test Case 1 of the VDI6007: <a name=\"result_box\">C</a>alculation of the reaction indoor temperature to a convective heat source for Type room S</p>
<ul>
<li>constant outdoor temperature 22&deg;C</li>
<li>no shortwave radiation on the outer wall</li>
<li>no shortwave radiation through the window</li>
<li>no longwave radiation exchange between outer wall, window and ambience</li>
</ul>
<p>Reference: Room air temperature</p>
<p>Variable path: <code>reducedModel.airload.T</code></p>
<p><br><br>All values are given in the VDI 6007-1.</p>
<p>Same Test Case exists in VDI 6020.</p>
</html>"));
      end TestCase_1;

      model TestCase_2
        extends Modelica.Icons.Example;

         output Modelica.SIunits.Conversions.NonSIunits.Temperature_degC referenceTemp[1];
        output Modelica.SIunits.Temp_K simulationTemp;

        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature outdoorTemp(T=295.15)
          annotation (Placement(transformation(extent={{-44,20},{-24,40}})));
        Modelica.Blocks.Sources.Constant infiltrationTemp(k=22)
          annotation (Placement(transformation(extent={{-44,-10},{-24,10}})));
        Modelica.Blocks.Sources.Constant infiltrationRate(k=0)
          annotation (Placement(transformation(extent={{-4,-40},{16,-20}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow machinesRadiative
          annotation (Placement(transformation(extent={{38,-76},{58,-56}})));
        Building.LowOrder.BaseClasses.ReducedOrderModel reducedModel(
          Aw=0.000000001,
          Ai=75.5,
          epsi=1,
          epso=1,
          epsw=1,
          g=1,
          alphaiwi=2.2,
          alphaowi=2.7,
          splitfac=0.09,
          R1i=0.000595515,
          C1i=1.48216e+007,
          withWindows=false,
          RRest=0.042748777,
          R1o=0.004366222,
          C1o=1.60085e+006,
          Ao=10.5)
          annotation (Placement(transformation(extent={{12,10},{46,44}})));
        Modelica.Blocks.Sources.CombiTimeTable tableMachines(
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          tableName="UserProfilesOffice",
          fileName="./Tables/J1615/UserProfilesOffice.txt",
          tableOnFile=false,
          table=[0,0; 3600,0; 7200,0; 10800,0; 14400,0; 18000,0; 21600,0; 21600,
              1000; 25200,1000; 28800,1000; 32400,1000; 36000,1000; 39600,1000;
              43200,1000; 46800,1000; 50400,1000; 54000,1000; 57600,1000; 61200,
              1000; 64800,1000; 64800,0; 68400,0; 72000,0; 75600,0; 79200,0;
              82800,0; 86400,0],
          columns={2})
          annotation (Placement(transformation(extent={{2,-73},{16,-59}})));
        Utilities.HeatTransfer.HeatToStar HeatToStar(A=2, eps=1) annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={70,-38})));
        Modelica.Blocks.Sources.CombiTimeTable reference(
          tableName="UserProfilesOffice",
          fileName="./Tables/J1615/UserProfilesOffice.txt",
          tableOnFile=false,
          columns={2},
          table=[3600,22; 7200,22; 10800,22; 14400,22; 18000,22; 21600,22; 25200,
              22.6; 28800,22.9; 32400,23.1; 36000,23.3; 39600,23.5; 43200,23.7;
              46800,23.9; 50400,24.1; 54000,24.3; 57600,24.6; 61200,24.8; 64800,25;
              68400,24.5; 72000,24.5; 75600,24.5; 79200,24.5; 82800,24.5; 86400,
              24.5; 781200,37.7; 784800,37.7; 788400,37.6; 792000,37.5; 795600,37.5;
              799200,37.4; 802800,38; 806400,38.2; 810000,38.3; 813600,38.5; 817200,
              38.6; 820800,38.8; 824400,38.9; 828000,39.1; 831600,39.2; 835200,39.4;
              838800,39.5; 842400,39.7; 846000,39.2; 849600,39.1; 853200,39.1;
              856800,39; 860400,38.9; 864000,38.9; 5101200,50; 5104800,49.9;
              5108400,49.8; 5112000,49.7; 5115600,49.6; 5119200,49.5; 5122800,50;
              5126400,50.1; 5130000,50.2; 5133600,50.3; 5137200,50.5; 5140800,50.6;
              5144400,50.7; 5148000,50.8; 5151600,50.9; 5155200,51; 5158800,51.1;
              5162400,51.2; 5166000,50.7; 5169600,50.6; 5173200,50.4; 5176800,50.3;
              5180400,50.2; 5184000,50.1],
          extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
          annotation (Placement(transformation(extent={{80,80},{100,99}})));
      equation
       referenceTemp = reference.y;
        simulationTemp = reducedModel.airload.port.T;

        connect(machinesRadiative.port, HeatToStar.Therm) annotation (Line(
            points={{58,-66},{70,-66},{70,-47.2}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(tableMachines.y[1], machinesRadiative.Q_flow) annotation (Line(
            points={{16.7,-66},{38,-66}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(outdoorTemp.port, reducedModel.equalAirTemp) annotation (Line(
            points={{-24,30},{-6,30},{-6,27.68},{15.4,27.68}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(infiltrationTemp.y, reducedModel.ventilationTemperature)
          annotation (Line(
            points={{-23,0},{-4,0},{-4,18.84},{15.4,18.84}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(infiltrationRate.y, reducedModel.ventilationRate) annotation (
            Line(
            points={{17,-30},{20,-30},{20,13.4},{22.2,13.4}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(HeatToStar.Star, reducedModel.internalGainsRad) annotation (
            Line(
            points={{70,-28.9},{70,-18},{42.09,-18},{42.09,13.4}},
            color={95,95,95},
            pattern=LinePattern.None,
            smooth=Smooth.None));
        annotation (
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}),
                  graphics),
          experiment(StopTime=5.184e+006, Interval=3600),
          __Dymola_experimentSetupOutput(events=false),
          Icon(graphics),
          Documentation(info="<html>
<p>Test Case 2 of the VDI6007: <a name=\"result_box\">C</a>alculation of the reaction indoor temperature to a radiant heat source for Type room S</p>
<ul>
<li>constant outdoor temperature 22&deg;C</li>
<li>no shortwave radiation on the outer wall</li>
<li>no shortwave radiation through the window</li>
<li>no longwave radiation exchange between outer wall, window and ambience</li>
</ul>
<p>Reference: Room air temperature</p>
<p>Variable path: <code>reducedModel.airload.T</code></p>
<p><br><br>All values are given in the VDI 6007-1.</p>
<p>Same Test Case exists in VDI 6020.</p>
</html>",     revisions="<html>
<p><i>February 2014</i>, by Peter Remmen:</p><p>Implemented</p>
</html>"));
      end TestCase_2;

      model TestCase_3
        extends Modelica.Icons.Example;
       output Modelica.SIunits.Conversions.NonSIunits.Temperature_degC referenceTemp[1];
        output Modelica.SIunits.Temp_K simulationTemp;

        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature outdoorTemp(T=295.15)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-34,30})));
        Modelica.Blocks.Sources.Constant infiltrationTemp(k=22)
          annotation (Placement(transformation(extent={{-44,-8},{-24,12}})));
        Modelica.Blocks.Sources.Constant infiltrationRate(k=0)
          annotation (Placement(transformation(extent={{-4,-40},{16,-20}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow machinesConvective
          annotation (Placement(transformation(extent={{4,-68},{24,-48}})));
        Building.LowOrder.BaseClasses.ReducedOrderModel reducedModel(
          Ao=10.5,
          Aw=0.000000001,
          Ai=75.5,
          epsi=1,
          epso=1,
          epsw=1,
          g=1,
          alphaiwi=2.2,
          alphaowi=2.7,
          splitfac=0.09,
          withWindows=false,
          C1o=4.78618e+004,
          R1i=0.003237138,
          C1i=7.297100e+006,
          RRest=0.043120170,
          R1o=0.004047899)
          annotation (Placement(transformation(extent={{12,10},{46,44}})));
        Modelica.Blocks.Sources.CombiTimeTable tableMachines(
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          tableName="UserProfilesOffice",
          fileName="./Tables/J1615/UserProfilesOffice.txt",
          tableOnFile=false,
          table=[0,0; 3600,0; 7200,0; 10800,0; 14400,0; 18000,0; 21600,0; 21600,
              1000; 25200,1000; 28800,1000; 32400,1000; 36000,1000; 39600,1000;
              43200,1000; 46800,1000; 50400,1000; 54000,1000; 57600,1000; 61200,
              1000; 64800,1000; 64800,0; 68400,0; 72000,0; 75600,0; 79200,0;
              82800,0; 86400,0],
          columns={2})
          annotation (Placement(transformation(extent={{-32,-65},{-18,-51}})));
        Modelica.Blocks.Sources.CombiTimeTable reference(
          tableName="UserProfilesOffice",
          fileName="./Tables/J1615/UserProfilesOffice.txt",
          tableOnFile=false,
          columns={2},
          table=[3600,22; 7200,22; 10800,22; 14400,22; 18000,22; 21600,22; 25200,
              30.2; 28800,30.8; 32400,31.2; 36000,31.6; 39600,32; 43200,32.4; 46800,
              32.8; 50400,33.2; 54000,33.6; 57600,34; 61200,34.3; 64800,34.7; 68400,
              26.9; 72000,26.7; 75600,26.7; 79200,26.6; 82800,26.6; 86400,26.6;
              781200,43.7; 784800,43.5; 788400,43.4; 792000,43.2; 795600,43; 799200,
              42.9; 802800,50.9; 806400,51.3; 810000,51.6; 813600,51.8; 817200,52.1;
              820800,52.3; 824400,52.5; 828000,52.8; 831600,53; 835200,53.3; 838800,
              53.5; 842400,53.7; 846000,45.8; 849600,45.4; 853200,45.3; 856800,45.1;
              860400,44.9; 864000,44.7; 5101200,48.7; 5104800,48.5; 5108400,48.3;
              5112000,48.1; 5115600,47.9; 5119200,47.7; 5122800,55.7; 5126400,56;
              5130000,56.3; 5133600,56.5; 5137200,56.7; 5140800,56.9; 5144400,57.1;
              5148000,57.3; 5151600,57.5; 5155200,57.7; 5158800,57.9; 5162400,58.1;
              5166000,50.1; 5169600,49.8; 5173200,49.5; 5176800,49.3; 5180400,49.1;
              5184000,48.9],
          extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
          annotation (Placement(transformation(extent={{62,76},{82,95}})));
      equation
       referenceTemp = reference.y;
        simulationTemp = reducedModel.airload.port.T;

        connect(tableMachines.y[1], machinesConvective.Q_flow) annotation (Line(
            points={{-17.3,-58},{4,-58}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(outdoorTemp.port, reducedModel.equalAirTemp) annotation (Line(
            points={{-24,30},{-4,30},{-4,27.68},{15.4,27.68}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(infiltrationTemp.y, reducedModel.ventilationTemperature)
          annotation (Line(
            points={{-23,2},{-4,2},{-4,18.84},{15.4,18.84}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(infiltrationRate.y, reducedModel.ventilationRate) annotation (
            Line(
            points={{17,-30},{22,-30},{22,13.4},{22.2,13.4}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(machinesConvective.port, reducedModel.internalGainsConv)
          annotation (Line(
            points={{24,-58},{32.4,-58},{32.4,13.4}},
            color={191,0,0},
            smooth=Smooth.None));
        annotation (Documentation(revisions="<html>
<p><i>February 2014</i>, by Peter Remmen:</p><p>Implemented</p>
</html>",     info="<html>
<p>Test Case 3 of the VDI6007: <a name=\"result_box\">C</a>alculation of the reaction indoor temperature to a convective heat source for Type room L</p>
<ul>
<li>constant outdoor temperature 22&deg;C</li>
<li>no shortwave radiation on the outer wall</li>
<li>no shortwave radiation through the window</li>
<li>no longwave radiation exchange between outer wall, window and ambience</li>
</ul>
<p>Reference: Room air temperature</p>
<p>Variable path: <code>reducedModel.airload.T</code></p>
<p><br><br>All values are given in the VDI 6007-1.</p>
<p>Same Test Case exists in VDI 6020.</p>
</html>"),     Icon(graphics),
          experiment(StopTime=5.184e+006, Interval=3600),
          __Dymola_experimentSetupOutput(events=false),
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}),
                               graphics));
      end TestCase_3;

      model TestCase_4
        extends Modelica.Icons.Example;
       output Modelica.SIunits.Conversions.NonSIunits.Temperature_degC referenceTemp[1];
        output Modelica.SIunits.Temp_K simulationTemp;

        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature outdoorTemp(T=295.15)
          annotation (Placement(transformation(extent={{-46,20},{-26,40}})));
        Modelica.Blocks.Sources.Constant infiltrationTemp(k=22)
          annotation (Placement(transformation(extent={{-46,-10},{-26,10}})));
        Modelica.Blocks.Sources.Constant infiltrationRate(k=0)
          annotation (Placement(transformation(extent={{-6,-40},{14,-20}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow machinesRadiative
          annotation (Placement(transformation(extent={{10,-68},{30,-48}})));
        Building.LowOrder.BaseClasses.ReducedOrderModel reducedModel(
          Ao=10.5,
          Aw=0.000000001,
          Ai=75.5,
          epsi=1,
          epso=1,
          epsw=1,
          g=1,
          alphaiwi=2.2,
          alphaowi=2.7,
          splitfac=0.09,
          withWindows=false,
          RRest=0.043120170,
          R1o=0.004047899,
          C1o=4.78618e+004,
          R1i=0.003237138,
          C1i=7.297100e+006)
          annotation (Placement(transformation(extent={{10,10},{44,44}})));
        Modelica.Blocks.Sources.CombiTimeTable tableMachines(
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          tableName="UserProfilesOffice",
          fileName="./Tables/J1615/UserProfilesOffice.txt",
          tableOnFile=false,
          table=[0,0; 3600,0; 7200,0; 10800,0; 14400,0; 18000,0; 21600,0; 21600,
              1000; 25200,1000; 28800,1000; 32400,1000; 36000,1000; 39600,1000;
              43200,1000; 46800,1000; 50400,1000; 54000,1000; 57600,1000; 61200,
              1000; 64800,1000; 64800,0; 68400,0; 72000,0; 75600,0; 79200,0;
              82800,0; 86400,0],
          columns={2})
          annotation (Placement(transformation(extent={{-22,-65},{-8,-51}})));
        Utilities.HeatTransfer.HeatToStar HeatToStar(A=2, eps=1)
          annotation (Placement(transformation(extent={{36,-68},{56,-48}})));
        Modelica.Blocks.Sources.CombiTimeTable reference(
          tableName="UserProfilesOffice",
          fileName="./Tables/J1615/UserProfilesOffice.txt",
          tableOnFile=false,
          columns={2},
          table=[3600,22; 7200,22; 10800,22; 14400,22; 18000,22; 21600,22; 25200,
              25.1; 28800,25.7; 32400,26.1; 36000,26.5; 39600,26.9; 43200,27.3;
              46800,27.7; 50400,28.1; 54000,28.5; 57600,28.9; 61200,29.3; 64800,
              29.7; 68400,26.9; 72000,26.7; 75600,26.7; 79200,26.7; 82800,26.6;
              86400,26.6; 781200,43.8; 784800,43.6; 788400,43.5; 792000,43.3;
              795600,43.1; 799200,43; 802800,45.9; 806400,46.3; 810000,46.6; 813600,
              46.8; 817200,47.1; 820800,47.3; 824400,47.6; 828000,47.8; 831600,48.1;
              835200,48.3; 838800,48.5; 842400,48.8; 846000,45.9; 849600,45.6;
              853200,45.4; 856800,45.2; 860400,45.1; 864000,44.9; 5101200,48.8;
              5104800,48.6; 5108400,48.4; 5112000,48.2; 5115600,48; 5119200,47.8;
              5122800,50.7; 5126400,51.1; 5130000,51.3; 5133600,51.5; 5137200,51.7;
              5140800,51.9; 5144400,52.1; 5148000,52.4; 5151600,52.6; 5155200,52.8;
              5158800,53; 5162400,53.2; 5166000,50.2; 5169600,49.9; 5173200,49.7;
              5176800,49.5; 5180400,49.2; 5184000,49],
          extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
          annotation (Placement(transformation(extent={{78,78},{98,97}})));
      equation
        referenceTemp = reference.y;
        simulationTemp = reducedModel.airload.port.T;

        connect(machinesRadiative.port, HeatToStar.Therm) annotation (Line(
            points={{30,-58},{36.8,-58}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(tableMachines.y[1], machinesRadiative.Q_flow) annotation (Line(
            points={{-7.3,-58},{10,-58}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(outdoorTemp.port, reducedModel.equalAirTemp) annotation (Line(
            points={{-26,30},{-8,30},{-8,27.68},{13.4,27.68}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(infiltrationTemp.y, reducedModel.ventilationTemperature)
          annotation (Line(
            points={{-25,0},{-8,0},{-8,18.84},{13.4,18.84}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(infiltrationRate.y, reducedModel.ventilationRate) annotation (
            Line(
            points={{15,-30},{18,-30},{18,13.4},{20.2,13.4}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(HeatToStar.Star, reducedModel.internalGainsRad) annotation (
            Line(
            points={{55.1,-58},{58,-58},{58,-10},{40.09,-10},{40.09,13.4}},
            color={95,95,95},
            pattern=LinePattern.None,
            smooth=Smooth.None));
        annotation (Documentation(revisions="<html>
<p><i>February 2014</i>, by Peter Remmen:</p><p>Implemented</p>
</html>",     info="<html>
<p>Test Case 4 of the VDI6007: <a name=\"result_box\">C</a>alculation of the reaction indoor temperature to a radiant heat source for Type room L</p>
<ul>
<li>constant outdoor temperature</li>
<li>no shortwave radiation on the outer wall</li>
<li>no shortwave radiation through the window</li>
<li>no longwave radiation exchange between outer wall, window and ambience</li>
</ul>
<p>Reference: Room air temperature</p>
<p>Variable path: <code>reducedModel.airload.T</code></p>
<p><br><br>All values are given in the VDI 6007-1.</p>
<p>Same Test Case exists in VDI 6020.</p>
</html>"),Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {100,100}}),graphics),
          Icon(graphics),
          experiment(StopTime=5.184e+006, Interval=3600),
          __Dymola_experimentSetupOutput(events=false));
      end TestCase_4;

      model TestCase_5
        extends Modelica.Icons.Example;
        output Modelica.SIunits.Conversions.NonSIunits.Temperature_degC referenceTemp[1];
        output Modelica.SIunits.Temp_K simulationTemp;
        Modelica.Blocks.Sources.Constant infiltrationRate(k=0)
          annotation (Placement(transformation(extent={{30,-4},{40,6}})));
        Modelica.Blocks.Sources.Constant infiltrationTemp(k=22)
          annotation (Placement(transformation(extent={{6,-4},{16,6}})));
        Utilities.HeatTransfer.HeatToStar HeatToStar(A=2)
          annotation (Placement(transformation(extent={{42,-100},{62,-80}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow machinesConvective
          annotation (Placement(transformation(extent={{10,-52},{30,-32}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow personsConvective
          annotation (Placement(transformation(extent={{10,-72},{30,-52}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow personsRadiative
          annotation (Placement(transformation(extent={{10,-100},{30,-80}})));
        Modelica.Blocks.Sources.CombiTimeTable innerLoads(
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          tableOnFile=false,
          table=[0,0,0,0; 3600,0,0,0; 7200,0,0,0; 10800,0,0,0; 14400,0,0,0; 18000,0,0,
              0; 21600,0,0,0; 25200,0,0,0; 25200,80,80,200; 28800,80,80,200; 32400,80,
              80,200; 36000,80,80,200; 39600,80,80,200; 43200,80,80,200; 46800,80,80,200;
              50400,80,80,200; 54000,80,80,200; 57600,80,80,200; 61200,80,80,200; 61200,
              0,0,0; 64800,0,0,0; 72000,0,0,0; 75600,0,0,0; 79200,0,0,0; 82800,0,0,0;
              86400,0,0,0],
          columns={2,3,4})
          annotation (Placement(transformation(extent={{-58,-72},{-38,-52}})));
        Building.LowOrder.BaseClasses.ReducedOrderModel reducedModel(
          C1i=1.48216e+007,
          C1o=1.60085e+006,
          alphaiwi=2.2,
          epsi=1,
          epso=1,
          T0all(displayUnit="K") = 295.15,
          Aw=7,
          splitfac=0.09,
          R1i=0.000595515,
          Ai=75.5,
          epsw=1,
          g=1,
          RRest=0.042748777,
          R1o=0.004366222,
          Ao=10.5)
          annotation (Placement(transformation(extent={{48,26},{82,66}})));

        Modelica.Blocks.Sources.CombiTimeTable outdoorTemp(
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          columns={2,3,4},
          table=[0,291.95,0,0; 3600,291.95,0,0; 3600,290.25,0,0; 7200,290.25,0,
              0; 7200,289.65,0,0; 10800,289.65,0,0; 10800,289.25,0,0; 14400,
              289.25,0,0; 14400,289.65,0,0; 18000,289.65,0,0; 18000,290.95,0,0;
              21600,290.95,0,0; 21600,293.45,0,0; 25200,293.45,0,0; 25200,
              295.95,0,0; 28800,295.95,0,0; 28800,297.95,0,0; 32400,297.95,0,0;
              32400,299.85,0,0; 36000,299.85,0,0; 36000,301.25,0,0; 39600,
              301.25,0,0; 39600,302.15,0,0; 43200,302.15,0,0; 43200,302.85,0,0;
              46800,302.85,0,0; 46800,303.55,0,0; 50400,303.55,0,0; 50400,
              304.05,0,0; 54000,304.05,0,0; 54000,304.15,0,0; 57600,304.15,0,0;
              57600,303.95,0,0; 61200,303.95,0,0; 61200,303.25,0,0; 64800,
              303.25,0,0; 64800,302.05,0,0; 68400,302.05,0,0; 68400,300.15,0,0;
              72000,300.15,0,0; 72000,297.85,0,0; 75600,297.85,0,0; 75600,
              296.05,0,0; 79200,296.05,0,0; 79200,295.05,0,0; 82800,295.05,0,0;
              82800,294.05,0,0; 86400,294.05,0,0])
          annotation (Placement(transformation(extent={{-62,22},{-42,42}})));
        Modelica.Blocks.Sources.CombiTimeTable windowRad(
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          table=[0,0,0,0,0,0.0; 3600,0,0,0,0,0.0; 10800,0,0,0,0,0.0; 14400,0,0,
              0,0,0.0; 14400,0,0,17,0,0.0; 18000,0,0,17,0,0.0; 18000,0,0,38,0,
              0.0; 21600,0,0,38,0,0.0; 21600,0,0,59,0,0.0; 25200,0,0,59,0,0.0;
              25200,0,0,98,0,0.0; 28800,0,0,98,0,0.0; 28800,0,0,186,0,0.0;
              32400,0,0,186,0,0.0; 32400,0,0,287,0,0.0; 36000,0,0,287,0,0.0;
              36000,0,0,359,0,0.0; 39600,0,0,359,0,0.0; 39600,0,0,385,0,0.0;
              43200,0,0,385,0,0.0; 43200,0,0,359,0,0.0; 46800,0,0,359,0,0.0;
              46800,0,0,287,0,0.0; 50400,0,0,287,0,0.0; 50400,0,0,186,0,0.0;
              54000,0,0,186,0,0.0; 54000,0,0,98,0,0.0; 57600,0,0,98,0,0.0;
              57600,0,0,59,0,0.0; 61200,0,0,59,0,0.0; 61200,0,0,38,0,0.0; 64800,
              0,0,38,0,0.0; 64800,0,0,17,0,0.0; 68400,0,0,17,0,0.0; 68400,0,0,0,
              0,0.0; 72000,0,0,0,0,0.0; 82800,0,0,0,0,0.0; 86400,0,0,0,0,0.0],
          columns={2,3,4,5,6})
          annotation (Placement(transformation(extent={{-96,68},{-76,88}})));
        Utilities.Sources.PrescribedSolarRad PrescribedSolarRad(n=5)
          annotation (Placement(transformation(extent={{-60,68},{-40,88}})));
        Components.Weather.Sunblind sunblind(n=5, gsunblind={0,0,0.15,0,0})
          annotation (Placement(transformation(extent={{-30,67},{-10,87}})));
        Building.LowOrder.BaseClasses.SolarRadWeightedSum SolarRadWeightedSum(n=5,
            weightfactors={0,0,7,0,0})
          annotation (Placement(transformation(extent={{-2,68},{18,88}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature varTemp
          annotation (Placement(transformation(extent={{-8,22},{12,42}})));
        Modelica.Blocks.Sources.CombiTimeTable reference(
          tableName="UserProfilesOffice",
          fileName="./Tables/J1615/UserProfilesOffice.txt",
          tableOnFile=false,
          table=[3600,22; 7200,22; 10800,21.9; 14400,21.9; 18000,22; 21600,22.2;
              25200,22.4; 28800,24.4; 32400,24.1; 36000,24.4; 39600,24.7; 43200,
              24.9; 46800,25.1; 50400,25.2; 54000,25.3; 57600,26; 61200,25.9; 64800,
              24.3; 68400,24.2; 72000,24.1; 75600,24.1; 79200,24.1; 82800,24.1;
              86400,24.1; 781200,34.9; 784800,34.8; 788400,34.7; 792000,34.6;
              795600,34.7; 799200,34.8; 802800,34.9; 806400,36.9; 810000,36.6;
              813600,36.8; 817200,37; 820800,37.2; 824400,37.3; 828000,37.4; 831600,
              37.4; 835200,38.1; 838800,38; 842400,36.4; 846000,36.2; 849600,36.1;
              853200,36.1; 856800,36; 860400,35.9; 864000,35.9; 5101200,44.9;
              5104800,44.8; 5108400,44.7; 5112000,44.6; 5115600,44.6; 5119200,44.6;
              5122800,44.8; 5126400,46.7; 5130000,46.3; 5133600,46.5; 5137200,46.7;
              5140800,46.8; 5144400,46.9; 5148000,47; 5151600,47; 5155200,47.6;
              5158800,47.5; 5162400,45.8; 5166000,45.6; 5169600,45.4; 5173200,45.4;
              5176800,45.3; 5180400,45.2; 5184000,45.1],
          columns={2},
          extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
          annotation (Placement(transformation(extent={{78,80},{98,99}})));
      equation
        referenceTemp = reference.y;
        simulationTemp = reducedModel.airload.port.T;

        connect(personsRadiative.port, HeatToStar.Therm) annotation (Line(
            points={{30,-90},{42.8,-90}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(outdoorTemp.y[1], varTemp.T) annotation (Line(
            points={{-41,32},{-10,32}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(windowRad.y, PrescribedSolarRad.u) annotation (Line(
            points={{-75,78},{-60,78}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(PrescribedSolarRad.solarRad_out, sunblind.Rad_In) annotation (
            Line(
            points={{-41,78},{-29,78}},
            color={255,128,0},
            smooth=Smooth.None));
        connect(SolarRadWeightedSum.solarRad_out, reducedModel.solarRad_in)
          annotation (Line(
            points={{17,78},{34,78},{34,56.8},{51.23,56.8}},
            color={255,128,0},
            smooth=Smooth.None));
        connect(varTemp.port, reducedModel.equalAirTemp) annotation (Line(
            points={{12,32},{22,32},{22,46.8},{51.4,46.8}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(infiltrationTemp.y, reducedModel.ventilationTemperature)
          annotation (Line(
            points={{16.5,1},{16.5,18.5},{51.4,18.5},{51.4,36.4}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(infiltrationRate.y, reducedModel.ventilationRate) annotation (
            Line(
            points={{40.5,1},{40.5,14.5},{58.2,14.5},{58.2,30}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(personsConvective.port, reducedModel.internalGainsConv)
          annotation (Line(
            points={{30,-62},{68.4,-62},{68.4,30}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(machinesConvective.port, reducedModel.internalGainsConv)
          annotation (Line(
            points={{30,-42},{68.4,-42},{68.4,30}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(HeatToStar.Star, reducedModel.internalGainsRad) annotation (
            Line(
            points={{61.1,-90},{78,-90},{78,30},{78.09,30}},
            color={95,95,95},
            pattern=LinePattern.None,
            smooth=Smooth.None));
        connect(sunblind.Rad_Out, SolarRadWeightedSum.solarRad_in) annotation (
            Line(
            points={{-11,78},{-1,78}},
            color={255,128,0},
            smooth=Smooth.None));
        connect(innerLoads.y[3], machinesConvective.Q_flow) annotation (Line(
            points={{-37,-62},{-18,-62},{-18,-42},{10,-42}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(innerLoads.y[2], personsConvective.Q_flow) annotation (Line(
            points={{-37,-62},{10,-62}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(innerLoads.y[1], personsRadiative.Q_flow) annotation (Line(
            points={{-37,-62},{-18,-62},{-18,-90},{10,-90}},
            color={0,0,127},
            smooth=Smooth.None));
        annotation (                  Diagram(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                                              graphics),
          experiment(
            StartTime=3600,
            StopTime=5.184e+006,
            Interval=3600,
            __Dymola_Algorithm="Lsodar"),
          __Dymola_experimentSetupOutput(events=false),
          Documentation(revisions="<html>
<p><i>February 2014</i>, by Peter Remmen:</p><p>Implemented</p>
</html>",     info="<html>
<p>Test Case 5 of the VDI6007: <a name=\"result_box\">C</a>alculation of the reaction indoor temperature to radiant and convective heat source for Type room S</p>
<ul>
<li>daily input for outdoor temperature </li>
<li>no shortwave radiation on the outer wall</li>
<li>shortwave radiation through the window</li>
<li>sunblind is closed at &GT;100W/m&sup2;, behind the window</li>
<li>no longwave radiation exchange between outer wall, window and ambience</li>
</ul>
<p>Reference: Room air temperature</p>
<p>Variable path: <code>reducedModel.airload.T</code></p>
<p><br><br>All values are given in the VDI 6007-1.</p>
<p>Same Test Case exists in VDI 6020.</p>
</html>"),Icon(graphics));
      end TestCase_5;

      model TestCase_6
        extends Modelica.Icons.Example;

        output Real referenceLoad[1];
        output Real simulationLoad;

        Modelica.Blocks.Sources.Constant infiltrationRate(k=0)
          annotation (Placement(transformation(extent={{30,-4},{40,6}})));
        Modelica.Blocks.Sources.Constant infiltrationTemp(k=22)
          annotation (Placement(transformation(extent={{6,-4},{16,6}})));
        Utilities.HeatTransfer.HeatToStar HeatToStar(A=2)
          annotation (Placement(transformation(extent={{40,-98},{60,-78}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow machinesRadiative
          annotation (Placement(transformation(extent={{-4,-100},{22,-78}})));
        Modelica.Blocks.Sources.CombiTimeTable innerLoads(
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          tableOnFile=false,
          table=[0,0,0; 3600,0,0; 7200,0,0; 10800,0,0; 14400,0,0; 18000,0,0;
              21600,0,0; 25200,0,1000; 28800,0,1000; 32400,0,1000; 36000,0,1000;
              39600,0,1000; 43200,0,1000; 46800,0,1000; 50400,0,1000; 54000,0,
              1000; 57600,0,1000; 61200,0,1000; 64800,0,1000; 68400,0,0; 72000,
              0,0; 75600,0,0; 79200,0,0; 82800,0,0; 86400,0,0])
          annotation (Placement(transformation(extent={{-48,-98},{-28,-78}})));
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature outdoorTemp(T=295.15)
          annotation (Placement(transformation(extent={{-24,39},{-4,59}})));
        Building.LowOrder.BaseClasses.ReducedOrderModel reducedModel(
          C1i=1.48216e+007,
          Aw=7,
          g=0.15,
          C1o=1.60085e+006,
          alphaiwi=2.2,
          epsi=1,
          epso=1,
          T0all(displayUnit="K") = 295.15,
          R1i=0.000595515,
          Ai=75.5,
          RRest=0.042748777,
          R1o=0.004366222,
          Ao=10.5,
          withWindows=false)
          annotation (Placement(transformation(extent={{54,26},{88,66}})));
        Modelica.Blocks.Sources.CombiTimeTable setTemp(
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          columns={2},
          table=[0,295.1; 3600,295.1; 7200,295.1; 10800,295.1; 14400,295.1;
              18000,295.1; 21600,295.1; 25200,300.1; 28800,300.1; 32400,300.1;
              36000,300.1; 39600,300.1; 43200,300.1; 46800,300.1; 50400,300.1;
              54000,300.1; 57600,300.1; 61200,300.1; 64800,300.1; 68400,295.1;
              72000,295.1; 75600,295.1; 79200,295.1; 82800,295.1; 86400,295.1])
          annotation (Placement(transformation(extent={{-62,-38},{-42,-18}})));
        Modelica.Blocks.Sources.CombiTimeTable reference(
          tableName="UserProfilesOffice",
          fileName="./Tables/J1615/UserProfilesOffice.txt",
          tableOnFile=false,
          columns={2,3},
          table=[3600,22,0; 7200,22,0; 10800,22,0; 14400,22,0; 18000,22,0; 21600,22,
              0; 25200,27,-764; 28800,27,-696; 32400,27,-632; 36000,27,-570; 39600,
              27,-511; 43200,27,-455; 46800,27,-402; 50400,27,-351; 54000,27,-302;
              57600,27,-255; 61200,27,-210; 64800,27,-167; 68400,22,638; 72000,22,
              610; 75600,22,583; 79200,22,557; 82800,22,533; 86400,22,511; 781200,
              22,774; 784800,22,742; 788400,22,711; 792000,22,682; 795600,22,654;
              799200,22,627; 802800,27,-163; 806400,27,-120; 810000,27,-79; 813600,
              27,-40; 817200,27,-2; 820800,27,33; 824400,27,67; 828000,27,99;
              831600,27,130; 835200,27,159; 838800,27,187; 842400,27,214; 846000,22,
              1004; 849600,22,960; 853200,22,919; 856800,22,880; 860400,22,843;
              864000,22,808; 5101200,22,774; 5104800,22,742; 5108400,22,711;
              5112000,22,682; 5115600,22,654; 5119200,22,627; 5122800,27,-163;
              5126400,27,-120; 5130000,27,-78; 5133600,27,-39; 5137200,27,-2;
              5140800,27,33; 5144400,27,67; 5148000,27,99; 5151600,27,130; 5155200,
              27,159; 5158800,27,187; 5162400,27,214; 5166000,22,1004; 5169600,22,
              960; 5173200,22,919; 5176800,22,880; 5180400,22,843; 5184000,22,808],
          extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
          annotation (Placement(transformation(extent={{80,78},{100,97}})));
        Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
          annotation (Placement(transformation(extent={{24,-38},{44,-18}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature varTemp
          annotation (Placement(transformation(extent={{-6,-38},{14,-18}})));
      equation

        referenceLoad[1]=-reference.y[2];
        simulationLoad=heatFlowSensor.Q_flow;

        connect(machinesRadiative.port, HeatToStar.Therm) annotation (Line(
            points={{22,-89},{28,-89},{28,-88},{40.8,-88}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(innerLoads.y[2], machinesRadiative.Q_flow) annotation (Line(
            points={{-27,-88},{-16,-88},{-16,-89},{-4,-89}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(infiltrationTemp.y, reducedModel.ventilationTemperature)
          annotation (Line(
            points={{16.5,1},{21.25,1},{21.25,36.4},{57.4,36.4}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(infiltrationRate.y, reducedModel.ventilationRate) annotation (
            Line(
            points={{40.5,1},{40.5,13.5},{64.2,13.5},{64.2,30}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(HeatToStar.Star, reducedModel.internalGainsRad) annotation (
            Line(
            points={{59.1,-88},{84.09,-88},{84.09,30}},
            color={95,95,95},
            pattern=LinePattern.None,
            smooth=Smooth.None));
        connect(outdoorTemp.port, reducedModel.equalAirTemp) annotation (Line(
            points={{-4,49},{26.5,49},{26.5,46.8},{57.4,46.8}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(heatFlowSensor.port_a, varTemp.port) annotation (Line(
            points={{24,-28},{14,-28}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(setTemp.y[1], varTemp.T) annotation (Line(
            points={{-41,-28},{-8,-28}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(heatFlowSensor.port_b, reducedModel.internalGainsConv)
          annotation (Line(
            points={{44,-28},{74.4,-28},{74.4,30}},
            color={191,0,0},
            smooth=Smooth.None));
        annotation (                  Diagram(coordinateSystem(preserveAspectRatio=false,
                         extent={{-100,-100},{100,100}}),
                                              graphics),
          experiment(
            StopTime=5.184e+006,
            Interval=3600,
            __Dymola_Algorithm="Lsodar"),
          __Dymola_experimentSetupOutput(events=false),
          Documentation(revisions="<html>
<p><i>February 2014</i>, by Peter Remmen:</p><p>Implemented</p>
</html>",     info="<html>
<p>Test Case 6 of the VDI6007: <a name=\"result_box\">L</a>oad calculation in compliance with the desired values of the indoor temperature and a setpoint for the type space S:</p>
<ul>
<li>constant outdoor temperature </li>
<li>no shortwave radiation on the outer wall</li>
<li>no shortwave radiation through the window</li>
<li>no longwave radiation exchange between outer wall, window and ambience</li>
</ul>
<p><br>Reference: Heating/Cooling load</p>
<p>Variable path: <code>heatFlowSensor.Q_flow</code></p>
<p><br><br><br>All values are given in the VDI 6007-1.</p>
<p>Same Test Case exists in VDI 6020.</p>
</html>"),Icon(graphics));
      end TestCase_6;

      model TestCase_7
        extends Modelica.Icons.Example;
        output Real referenceLoad[1];
        output Real simulationLoad;
        Modelica.Blocks.Sources.Constant infiltrationRate(k=0)
          annotation (Placement(transformation(extent={{32,-15},{42,-5}})));
        Modelica.Blocks.Sources.Constant infiltrationTemp(k=22)
          annotation (Placement(transformation(extent={{6,-4},{16,6}})));
        Utilities.HeatTransfer.HeatToStar HeatToStar(A=2)
          annotation (Placement(transformation(extent={{40,-99},{60,-79}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow machinesRadiative
          annotation (Placement(transformation(extent={{-4,-100},{22,-78}})));
        Modelica.Blocks.Sources.CombiTimeTable innerLoads(
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          tableOnFile=false,
          table=[0,0,0; 3600,0,0; 7200,0,0; 10800,0,0; 14400,0,0; 18000,0,0;
              21600,0,0; 25200,0,1000; 28800,0,1000; 32400,0,1000; 36000,0,1000;
              39600,0,1000; 43200,0,1000; 46800,0,1000; 50400,0,1000; 54000,0,
              1000; 57600,0,1000; 61200,0,1000; 64800,0,1000; 68400,0,0; 72000,
              0,0; 75600,0,0; 79200,0,0; 82800,0,0; 86400,0,0])
          annotation (Placement(transformation(extent={{-46,-99},{-26,-79}})));
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature outdoorTemp(T=295.15)
          annotation (Placement(transformation(extent={{-24,49},{-4,69}})));
        Building.LowOrder.BaseClasses.ReducedOrderModel reducedModel(
          C1i=1.48216e+007,
          Aw=7,
          g=0.15,
          C1o=1.60085e+006,
          alphaiwi=2.2,
          epsi=1,
          epso=1,
          T0all(displayUnit="K") = 295.15,
          withWindows=false,
          R1i=0.000595515,
          Ai=75.5,
          RRest=0.042748777,
          R1o=0.004366222,
          Ao=10.5)
          annotation (Placement(transformation(extent={{44,38},{78,78}})));
        Utilities.Sources.HeaterCooler.IdealHeaterCoolerVar1
          idealHeaterCoolerVar1_1(
          Q_flow_heat=1,
          Q_flow_cooler=1,
          h_cooler=0,
          TN_heater=1,
          TN_cooler=1,
          h_heater=500,
          l_cooler=-500,
          KR_heater=1000,
          KR_cooler=1000) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=-90,
              origin={-26,-20})));
        Modelica.Blocks.Sources.CombiTimeTable setTemp(
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          columns={2,3},
          table=[0,295.15,295.2; 3600,295.1,295.2; 7200,295.1,295.2; 10800,
              295.1,295.2; 14400,295.1,295.2; 18000,295.1,295.2; 21600,295.1,
              295.2; 25200,300.1,300.2; 28800,300.1,300.2; 32400,300.1,300.2;
              36000,300.1,300.2; 39600,300.1,300.2; 43200,300.1,300.2; 46800,
              300.1,300.2; 50400,300.1,300.2; 54000,300.1,300.2; 57600,300.1,
              300.2; 61200,300.1,300.2; 64800,300.1,300.2; 68400,295.1,295.2;
              72000,295.1,295.2; 75600,295.1,295.2; 79200,295.1,295.2; 82800,
              295.1,295.2; 86400,295.1,295.2])
          annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));
        Modelica.Blocks.Sources.CombiTimeTable reference(
          tableName="UserProfilesOffice",
          fileName="./Tables/J1615/UserProfilesOffice.txt",
          tableOnFile=false,
          columns={2,3},
          table=[3600,22,0; 7200,22,0; 10800,22,0; 14400,22,0; 18000,22,0; 21600,22,
              0; 25200,25.5,-500; 28800,25.8,-500; 32400,26.1,-500; 36000,26.5,-500;
              39600,26.8,-500; 43200,27,-481; 46800,27,-426; 50400,27,-374; 54000,
              27,-324; 57600,27,-276; 61200,27,-230; 64800,27,-186; 68400,22.7,500;
              72000,22.6,500; 75600,22.4,500; 79200,22.3,500; 82800,22.2,500; 86400,
              22,500; 781200,25.1,500; 784800,25,500; 788400,24.8,500; 792000,24.7,
              500; 795600,24.6,500; 799200,24.4,500; 802800,27,142; 806400,27,172;
              810000,27,201; 813600,27,228; 817200,27,254; 820800,27,278; 824400,27,
              302; 828000,27,324; 831600,27,345; 835200,27,366; 838800,27,385;
              842400,27,404; 846000,25.9,500; 849600,25.8,500; 853200,25.6,500;
              856800,25.5,500; 860400,25.4,500; 864000,25.2,500; 5101200,25.1,500;
              5104800,25,500; 5108400,24.9,500; 5112000,24.7,500; 5115600,24.6,500;
              5119200,24.5,500; 5122800,27,149; 5126400,27,179; 5130000,27,207;
              5133600,27,234; 5137200,27,259; 5140800,27,284; 5144400,27,307;
              5148000,27,329; 5151600,27,350; 5155200,27,371; 5158800,27,390;
              5162400,27,409; 5166000,25.9,500; 5169600,25.8,500; 5173200,25.7,500;
              5176800,25.5,500; 5180400,25.4,500; 5184000,25.3,500],
          extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
          annotation (Placement(transformation(extent={{80,80},{100,99}})));
        Modelica.Blocks.Math.Add sumHeatLoad
          annotation (Placement(transformation(extent={{-96,86},{-86,96}})));
      equation
        connect(machinesRadiative.port, HeatToStar.Therm) annotation (Line(
            points={{22,-89},{40.8,-89}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(innerLoads.y[2], machinesRadiative.Q_flow) annotation (Line(
            points={{-25,-89},{-4,-89}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(setTemp.y[2], idealHeaterCoolerVar1_1.soll_cool) annotation (
            Line(
            points={{-59,-20},{-50,-20},{-50,-15.2},{-30.8,-15.2}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(setTemp.y[1], idealHeaterCoolerVar1_1.soll_heat) annotation (
            Line(
            points={{-59,-20},{-50,-20},{-50,-23},{-30.8,-23}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(sumHeatLoad.u1,idealHeaterCoolerVar1_1.heatMeter.p);
        connect(sumHeatLoad.u2,idealHeaterCoolerVar1_1.coolMeter.p);
        referenceLoad[1]=-reference.y[2];
        simulationLoad=sumHeatLoad.y;

        connect(outdoorTemp.port, reducedModel.equalAirTemp) annotation (Line(
            points={{-4,59},{26.5,59},{26.5,58.8},{47.4,58.8}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(idealHeaterCoolerVar1_1.HeatCoolRoom, reducedModel.internalGainsConv)
          annotation (Line(
            points={{-26,-29},{30,-29},{30,-32},{64.4,-32},{64.4,42}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(infiltrationTemp.y, reducedModel.ventilationTemperature)
          annotation (Line(
            points={{16.5,1},{35.25,1},{35.25,48.4},{47.4,48.4}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(infiltrationRate.y, reducedModel.ventilationRate) annotation (
            Line(
            points={{42.5,-10},{54.2,-10},{54.2,42}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(HeatToStar.Star, reducedModel.internalGainsRad) annotation (
            Line(
            points={{59.1,-89},{72,-89},{72,42},{74.09,42}},
            color={95,95,95},
            pattern=LinePattern.None,
            smooth=Smooth.None));
        annotation (                  Diagram(coordinateSystem(preserveAspectRatio=false,
                         extent={{-100,-100},{100,100}}),
                                              graphics),
          experiment(
            StopTime=5.184e+006,
            Interval=3600,
            Algorithm="Lsodar"),
          __Dymola_experimentSetupOutput(events=false),
          Documentation(revisions="<html>
<p><i>February 2014</i>, by Peter Remmen:</p><p>Implemented</p>
</html>",     info="<html>
<p>Test Case 7 of the VDI6007: <a name=\"result_box\">L</a>oad calculation in compliance with the desired values of the indoor temperature and a setpoint for the type space S:</p>
<p><br>This case is the same like case 6, but with a maximum heating/cooling power.</p>
<ul>
<li>constant outdoor temperature </li>
<li>no shortwave radiation on the outer wall</li>
<li>no shortwave radiation through the window</li>
<li>no longwave radiation exchange between outer wall, window and ambience</li>
</ul>
<p>Reference: Heating/Cooling load</p>
<p>Variable path: <code>sumHeatLoad.y</code></p>
<p><br><br>All values are given in the VDI 6007-1.</p>
<p>Same Test Case exists in VDI 6020.</p>
</html>"),Icon(graphics));
      end TestCase_7;

      model TestCase_8
        extends Modelica.Icons.Example;
        output Modelica.SIunits.Conversions.NonSIunits.Temperature_degC referenceTemp[1];
        output Modelica.SIunits.Temp_K simulationTemp;
        Modelica.Blocks.Sources.Constant infiltrationRate(k=0)
          annotation (Placement(transformation(extent={{38,-5},{48,5}})));
        Modelica.Blocks.Sources.Constant infiltrationTemp(k=22)
          annotation (Placement(transformation(extent={{16,14},{26,24}})));
        Utilities.HeatTransfer.HeatToStar HeatTorStar(A=2)
          annotation (Placement(transformation(extent={{42,-98},{62,-78}})));
        Building.LowOrder.BaseClasses.ReducedOrderModel reducedModel(
          epsi=1,
          epso=1,
          T0all(displayUnit="K") = 295.15,
          R1i=0.000668639,
          C1i=1.23849e+007,
          Ai=60.5,
          splitfac=0.09,
          Aw=14,
          epsw=1,
          g=1,
          R1o=0.001735719,
          C1o=5.25993e+006,
          Ao=25.5,
          alphaiwi=2.1,
          RRest=0.020439688)
          annotation (Placement(transformation(extent={{48,26},{82,66}})));

        Modelica.Blocks.Sources.CombiTimeTable outdoorTemp(
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          columns={2,3,4},
          table=[0,291.95,0,0; 3600,291.95,0,0; 3600,290.25,0,0; 7200,290.25,0,
              0; 7200,289.65,0,0; 10800,289.65,0,0; 10800,289.25,0,0; 14400,
              289.25,0,0; 14400,289.65,0,0; 18000,289.65,0,0; 18000,290.95,0,0;
              21600,290.95,0,0; 21600,293.45,0,0; 25200,293.45,0,0; 25200,
              295.95,0,0; 28800,295.95,0,0; 28800,297.95,0,0; 32400,297.95,0,0;
              32400,299.85,0,0; 36000,299.85,0,0; 36000,301.25,0,0; 39600,
              301.25,0,0; 39600,302.15,0,0; 43200,302.15,0,0; 43200,302.85,0,0;
              46800,302.85,0,0; 46800,303.55,0,0; 50400,303.55,0,0; 50400,
              304.05,0,0; 54000,304.05,0,0; 54000,304.15,0,0; 57600,304.15,0,0;
              57600,303.95,0,0; 61200,303.95,0,0; 61200,303.25,0,0; 64800,
              303.25,0,0; 64800,302.05,0,0; 68400,302.05,0,0; 68400,300.15,0,0;
              72000,300.15,0,0; 72000,297.85,0,0; 75600,297.85,0,0; 75600,
              296.05,0,0; 79200,296.05,0,0; 79200,295.05,0,0; 82800,295.05,0,0;
              82800,294.05,0,0; 86400,294.05,0,0])
          annotation (Placement(transformation(extent={{-88,8},{-68,28}})));

        Utilities.Sources.PrescribedSolarRad Quelle_Wand(n=5) annotation (
            Placement(transformation(extent={{-60,36},{-40,56}})));
        Modelica.Blocks.Sources.CombiTimeTable wallRad(
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          table=[0,0,0,0,0,0.0; 3600,0,0,0,0,0.0; 10800,0,0,0,0,0.0; 14400,0,0,
              0,0,0.0; 14400,0,0,24,23,0.0; 18000,0,0,24,23,0.0; 18000,0,0,58,
              53,0.0; 21600,0,0,58,53,0.0; 21600,0,0,91,77,0.0; 25200,0,0,91,77,
              0.0; 25200,0,0,203,97,0.0; 28800,0,0,203,97,0.0; 28800,0,0,348,
              114,0.0; 32400,0,0,348,114,0.0; 32400,0,0,472,131,0.0; 36000,0,0,
              472,131,0.0; 36000,0,0,553,144,0.0; 39600,0,0,553,144,0.0; 39600,
              0,0,581,159,0.0; 43200,0,0,581,159,0.0; 43200,0,0,553,372,0.0;
              46800,0,0,553,372,0.0; 46800,0,0,472,557,0.0; 50400,0,0,472,557,
              0.0; 50400,0,0,348,685,0.0; 54000,0,0,348,685,0.0; 54000,0,0,203,
              733,0.0; 57600,0,0,203,733,0.0; 57600,0,0,91,666,0.0; 61200,0,0,
              91,666,0.0; 61200,0,0,58,474,0.0; 64800,0,0,58,474,0.0; 64800,0,0,
              24,177,0.0; 68400,0,0,24,177,0.0; 68400,0,0,0,0,0.0; 72000,0,0,0,
              0,0.0; 82800,0,0,0,0,0.0; 86400,0,0,0,0,0.0],
          columns={2,3,4,5,6})
          annotation (Placement(transformation(extent={{-88,36},{-68,56}})));
        Modelica.Blocks.Sources.CombiTimeTable windowRad(
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          table=[0,0,0,0,0,0.0; 3600,0,0,0,0,0.0; 10800,0,0,0,0,0.0; 14400,0,0,
              0,0,0.0; 14400,0,0,17,17,0.0; 18000,0,0,17,17,0.0; 18000,0,0,38,
              36,0.0; 21600,0,0,38,36,0.0; 21600,0,0,59,51,0.0; 25200,0,0,59,51,
              0.0; 25200,0,0,98,64,0.0; 28800,0,0,98,64,0.0; 28800,0,0,186,74,
              0.0; 32400,0,0,186,74,0.0; 32400,0,0,287,84,0.0; 36000,0,0,287,84,
              0.0; 36000,0,0,359,92,0.0; 39600,0,0,359,92,0.0; 39600,0,0,385,
              100,0.0; 43200,0,0,385,100,0.0; 43200,0,0,359,180,0.0; 46800,0,0,
              359,180,0.0; 46800,0,0,287,344,0.0; 50400,0,0,287,344,0.0; 50400,
              0,0,186,475,0.0; 54000,0,0,186,475,0.0; 54000,0,0,98,528,0.0;
              57600,0,0,98,528,0.0; 57600,0,0,59,492,0.0; 61200,0,0,59,492,0.0;
              61200,0,0,38,359,0.0; 64800,0,0,38,359,0.0; 64800,0,0,17,147,0.0;
              68400,0,0,17,147,0.0; 68400,0,0,0,0,0.0; 72000,0,0,0,0,0.0; 82800,
              0,0,0,0,0.0; 86400,0,0,0,0,0.0],
          columns={2,3,4,5,6})
          annotation (Placement(transformation(extent={{-88,68},{-68,88}})));
        Utilities.Sources.PrescribedSolarRad Quelle_Fenster(n=5)
          annotation (Placement(transformation(extent={{-60,68},{-40,88}})));
        Components.Weather.Sunblind sunblind(n=5, gsunblind={0,0,0.15,0.15,
              0}) annotation (Placement(transformation(extent={{-30,67},{-10,
                  87}})));
        Building.LowOrder.BaseClasses.SolarRadWeightedSum rad_weighted_sum(
            weightfactors={0,0,7,7,0}, n=5)
          annotation (Placement(transformation(extent={{-2,68},{18,88}})));
        VDIComponents.EqAirTemp_TestCase_8 eqAirTemp(
          aowo=0.7,
          n=5,
          wf_wall={0.000000000,0.000000000,0.057948807,0.132454416,0.000000000},
          wf_win={0.000000000,0.000000000,0.404798388,0.404798388,0.000000000},
          alphaowo=25)
          annotation (Placement(transformation(extent={{-16,30},{4,50}})));
        Modelica.Blocks.Sources.CombiTimeTable reference(
          tableName="UserProfilesOffice",
          fileName="./Tables/J1615/UserProfilesOffice.txt",
          tableOnFile=false,
          columns={2},
          extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
          table=[3600,22; 7200,21.9; 10800,21.9; 14400,21.8; 18000,22; 21600,22.3;
              25200,22.7; 28800,24.8; 32400,24.7; 36000,25.2; 39600,25.6; 43200,
              26.1; 46800,25.9; 50400,26.3; 54000,26.6; 57600,27.5; 61200,27.6;
              64800,26; 68400,25.8; 72000,25.6; 75600,25.6; 79200,25.5; 82800,25.5;
              86400,25.5; 781200,37.6; 784800,37.5; 788400,37.3; 792000,37.1;
              795600,37.1; 799200,37.3; 802800,37.5; 806400,39.6; 810000,39.4;
              813600,39.7; 817200,40; 820800,40.3; 824400,40; 828000,40.3; 831600,
              40.5; 835200,41.3; 838800,41.3; 842400,39.6; 846000,39.2; 849600,38.9;
              853200,38.8; 856800,38.7; 860400,38.5; 864000,38.4; 5101200,40.9;
              5104800,40.7; 5108400,40.5; 5112000,40.2; 5115600,40.3; 5119200,40.4;
              5122800,40.6; 5126400,42.6; 5130000,42.4; 5133600,42.7; 5137200,43;
              5140800,43.3; 5144400,43; 5148000,43.2; 5151600,43.4; 5155200,44.2;
              5158800,44.1; 5162400,42.4; 5166000,42; 5169600,41.7; 5173200,41.6;
              5176800,41.4; 5180400,41.2; 5184000,41.1])
          annotation (Placement(transformation(extent={{80,80},{100,99}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow machinesConvective
          annotation (Placement(transformation(extent={{6,-50},{26,-30}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow personsConvective
          annotation (Placement(transformation(extent={{6,-70},{26,-50}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow personsRadiative
          annotation (Placement(transformation(extent={{6,-98},{26,-78}})));
        Modelica.Blocks.Sources.CombiTimeTable innerLoads(
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          tableOnFile=false,
          table=[0,0,0,0; 3600,0,0,0; 7200,0,0,0; 10800,0,0,0; 14400,0,0,0; 18000,0,0,
              0; 21600,0,0,0; 25200,0,0,0; 25200,80,80,200; 28800,80,80,200; 32400,80,
              80,200; 36000,80,80,200; 39600,80,80,200; 43200,80,80,200; 46800,80,80,200;
              50400,80,80,200; 54000,80,80,200; 57600,80,80,200; 61200,80,80,200; 61200,
              0,0,0; 64800,0,0,0; 72000,0,0,0; 75600,0,0,0; 79200,0,0,0; 82800,0,0,0;
              86400,0,0,0],
          columns={2,3,4})
          annotation (Placement(transformation(extent={{-62,-70},{-42,-50}})));
      equation
       referenceTemp = reference.y;
        simulationTemp = reducedModel.airload.port.T;

        connect(eqAirTemp.WeatherDataVector, outdoorTemp.y) annotation (Line(
            points={{-14,40},{-40,40},{-40,18},{-67,18}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(windowRad.y, Quelle_Fenster.u) annotation (Line(
            points={{-67,78},{-60,78}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(Quelle_Fenster.solarRad_out, sunblind.Rad_In) annotation (Line(
            points={{-41,78},{-29,78}},
            color={255,128,0},
            smooth=Smooth.None));
        connect(Quelle_Wand.solarRad_out, eqAirTemp.Rad_In) annotation (Line(
            points={{-41,46},{-27.75,46},{-27.75,45.6},{-14.5,45.6}},
            color={255,128,0},
            smooth=Smooth.None));
        connect(wallRad.y, Quelle_Wand.u) annotation (Line(
            points={{-67,46},{-60,46}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(sunblind.sunblindonoff, eqAirTemp.sunblindsig) annotation (Line(
            points={{-20,68},{-14,68},{-14,48},{-6,48}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(eqAirTemp.equalairtemp, reducedModel.equalAirTemp) annotation (
            Line(
            points={{2,40},{24,40},{24,46.8},{51.4,46.8}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(rad_weighted_sum.solarRad_out, reducedModel.solarRad_in)
          annotation (Line(
            points={{17,78},{34,78},{34,56.8},{51.23,56.8}},
            color={255,128,0},
            smooth=Smooth.None));
        connect(sunblind.Rad_Out, rad_weighted_sum.solarRad_in) annotation (Line(
            points={{-11,78},{-1,78}},
            color={255,128,0},
            smooth=Smooth.None));
        connect(infiltrationRate.y, reducedModel.ventilationRate) annotation (
            Line(
            points={{48.5,0},{58.2,0},{58.2,30}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(HeatTorStar.Star, reducedModel.internalGainsRad) annotation (
            Line(
            points={{61.1,-88},{78,-88},{78,30},{78.09,30}},
            color={95,95,95},
            pattern=LinePattern.None,
            smooth=Smooth.None));
        connect(infiltrationTemp.y, reducedModel.ventilationTemperature)
          annotation (Line(
            points={{26.5,19},{34,19},{34,36.4},{51.4,36.4}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(personsConvective.port, reducedModel.internalGainsConv)
          annotation (Line(
            points={{26,-60},{68.4,-60},{68.4,30}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(machinesConvective.port, reducedModel.internalGainsConv)
          annotation (Line(
            points={{26,-40},{68.4,-40},{68.4,30}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(innerLoads.y[3], machinesConvective.Q_flow) annotation (Line(
            points={{-41,-60},{-22,-60},{-22,-40},{6,-40}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(innerLoads.y[2], personsConvective.Q_flow) annotation (Line(
            points={{-41,-60},{6,-60}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(innerLoads.y[1], personsRadiative.Q_flow) annotation (Line(
            points={{-41,-60},{-22,-60},{-22,-88},{6,-88}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(personsRadiative.port, HeatTorStar.Therm) annotation (Line(
            points={{26,-88},{42.8,-88}},
            color={191,0,0},
            smooth=Smooth.None));
        annotation (                  Diagram(coordinateSystem(preserveAspectRatio=false,
                         extent={{-100,-100},{100,100}}),
                                              graphics),
          experiment(
            StopTime=5.184e+006,
            Interval=3600,
            Algorithm="Lsodar"),
          __Dymola_experimentSetupOutput(events=false),
          Icon(graphics),
          Documentation(revisions="<html>
<p><i>February 2014</i>, by Peter Remmen:</p><p>Implemented</p>
</html>",     info="<html>
<p>Test Case 8 of the VDI6007:: <a name=\"result_box\">C</a>alculation of the reaction indoor temperature to mixed inner and outer heat sources for Type Room S:</p>
<p>Based on Test Case 5</p>
<ul>
<li>Second outer wall to the west</li>
<li>shortwave radiation on the outer wall</li>
<li>shortwave radiation through the windows</li>
<li>Shutter cloeses &GT;100W/m&sup2;</li>
<li>no longwave radiation heat exchange (special EqAirTemp see: EqAirTemp_TestCase_8)</li>
</ul>
<p><br>Reference: Room air temperature</p>
<p>Variable path: <code>reducedModel.airload.T</code></p>
<p><br><br>All values are given in the VDI 6007-1.</p>
<p>Same Test Case exists in VDI 6020.</p>
</html>"));
      end TestCase_8;

      model TestCase_9
        extends Modelica.Icons.Example;

        output Modelica.SIunits.Conversions.NonSIunits.Temperature_degC referenceTemp[1];
        output Modelica.SIunits.Temp_K simulationTemp;

        Modelica.Blocks.Sources.Constant infiltrationTemp(k=273.15 + 22)
          annotation (Placement(transformation(extent={{12,9},{26,23}})));
        Modelica.Blocks.Sources.Constant infiltrationRate(k=0)
          annotation (Placement(transformation(extent={{28,-10},{40,2}})));
        Building.LowOrder.BaseClasses.SolarRadWeightedSum
          window_shortwave_rad_sum(n=4, weightfactors={0,0,7,7})
          annotation (Placement(transformation(extent={{6,62},{28,84}})));
        Building.LowOrder.BaseClasses.EqAirTemp eqAirTemp(
          aowo=0.7,
          wf_wall={0,0,0.05795,0.13245},
          wf_win={0,0,0.4048,0.4048},
          alphaowo=25)
          annotation (Placement(transformation(extent={{-20,0},{0,20}})));
        Components.Weather.Sunblind sunblind(Imax=100, gsunblind={1,1,0.15,
              0.15})
          annotation (Placement(transformation(extent={{-20,62},{0,82}})));
        Building.LowOrder.BaseClasses.ReducedOrderModel reducedModel(
          Ao=25.5,
          Aw=14,
          Ai=60.5,
          epsi=1,
          epso=1,
          epsw=1,
          g=1,
          splitfac=0.09,
          T0all(displayUnit="degC"),
          R1i=0.000668639,
          C1i=1.23849e+007,
          R1o=0.001735719,
          C1o=5.25993e+006,
          alphaiwi=2.1,
          alphaowi=2.7,
          RRest=0.020439688)
          annotation (Placement(transformation(extent={{38,8},{80,46}})));
        Utilities.Sources.PrescribedSolarRad varRad3(n=4) annotation (
            Placement(transformation(extent={{-58,63},{-38,83}})));
        Utilities.Sources.PrescribedSolarRad varRad1(n=4) annotation (
            Placement(transformation(extent={{-44,23},{-24,43}})));
        Modelica.Blocks.Sources.CombiTimeTable windowRad(
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          tableName="UserProfilesOffice",
          fileName="./Tables/J1615/UserProfilesOffice.txt",
          tableOnFile=false,
          table=[0,0,0,0,0; 3600,0,0,0,0; 10800,0,0,0,0; 14400,0,0,0,0; 14400,0,
              0,17,17; 18000,0,0,17,17; 18000,0,0,38,36; 21600,0,0,38,36; 21600,
              0,0,59,51; 25200,0,0,59,51; 25200,0,0,98,64; 28800,0,0,98,64;
              28800,0,0,186,74; 32400,0,0,186,74; 32400,0,0,287,84; 36000,0,0,
              287,84; 36000,0,0,359,92; 39600,0,0,359,92; 39600,0,0,385,100;
              43200,0,0,385,100; 43200,0,0,359,180; 46800,0,0,359,180; 46800,0,
              0,287,344; 50400,0,0,287,344; 50400,0,0,186,475; 54000,0,0,186,
              475; 54000,0,0,98,528; 57600,0,0,98,528; 57600,0,0,59,492; 61200,
              0,0,59,492; 61200,0,0,38,359; 64800,0,0,38,359; 64800,0,0,17,147;
              68400,0,0,17,147; 68400,0,0,0,0; 72000,0,0,0,0; 82800,0,0,0,0;
              86400,0,0,0,0],
          columns={2,3,4,5})
          annotation (Placement(transformation(extent={{-88,66},{-74,80}})));
        Modelica.Blocks.Sources.CombiTimeTable wallRad(
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          tableName="UserProfilesOffice",
          fileName="./Tables/J1615/UserProfilesOffice.txt",
          tableOnFile=false,
          columns={2,3,4,5},
          table=[0,0,0,0,0; 3600,0,0,0,0; 10800,0,0,0,0; 14400,0,0,0,0; 14400,0,
              0,24,23; 18000,0,0,24,23; 18000,0,0,58,53; 21600,0,0,58,53; 21600,
              0,0,91,77; 25200,0,0,91,77; 25200,0,0,203,97; 28800,0,0,203,97;
              28800,0,0,348,114; 32400,0,0,348,114; 32400,0,0,472,131; 36000,0,
              0,472,131; 36000,0,0,553,144; 39600,0,0,553,144; 39600,0,0,581,
              159; 43200,0,0,581,159; 43200,0,0,553,372; 46800,0,0,553,372;
              46800,0,0,472,557; 50400,0,0,472,557; 50400,0,0,348,685; 54000,0,
              0,348,685; 54000,0,0,203,733; 57600,0,0,203,733; 57600,0,0,91,666;
              61200,0,0,91,666; 61200,0,0,58,474; 64800,0,0,58,474; 64800,0,0,
              24,177; 68400,0,0,24,177; 68400,0,0,0,0; 72000,0,0,0,0; 82800,0,0,
              0,0; 86400,0,0,0,0])
          annotation (Placement(transformation(extent={{-88,26},{-74,40}})));
        Modelica.Blocks.Sources.CombiTimeTable outdoorTemp(
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          tableName="UserProfilesOffice",
          fileName="./Tables/J1615/UserProfilesOffice.txt",
          tableOnFile=false,
          table=[0,0,0,0,18.8,0,0,0,343,-382,0; 0.36,0,0,0,18.8,0,0,0,343,-382,
              0; 3600,0,0,0,17.1,0,0,0,344,-384,0; 7200,0,0,0,17.1,0,0,0,344,-384,
              0; 7200,0,0,0,16.5,0,0,0,345,-384,0; 10800,0,0,0,16.5,0,0,0,345,-384,
              0; 10800,0,0,0,16.1,0,0,0,347,-381,0; 14400,0,0,0,16.1,0,0,0,347,
              -381,0; 14400,0,0,0,16.5,0,0,0,355,-406,0; 18000,0,0,0,16.5,0,0,0,
              355,-406,0; 18000,0,0,0,17.8,0,0,0,359,-422,0; 21600,0,0,0,17.8,0,
              0,0,359,-422,0; 21600,0,0,0,20.3,0,0,0,353,-448,0; 25200,0,0,0,
              20.3,0,0,0,353,-448,0; 25200,0,0,0,22.8,0,0,0,356,-472,0; 28800,0,
              0,0,22.8,0,0,0,356,-472,0; 28800,0,0,0,24.8,0,0,0,356,-499,0;
              32400,0,0,0,24.8,0,0,0,356,-499,0; 32400,0,0,0,26.7,0,0,0,359,-519,
              0; 36000,0,0,0,26.7,0,0,0,359,-519,0; 36000,0,0,0,28.1,0,0,0,360,
              -537,0; 39600,0,0,0,28.1,0,0,0,360,-537,0; 39600,0,0,0,29,0,0,0,
              361,-553,0; 43200,0,0,0,29,0,0,0,361,-553,0; 43200,0,0,0,29.7,0,0,
              0,367,-552,0; 46800,0,0,0,29.7,0,0,0,367,-552,0; 46800,0,0,0,30.4,
              0,0,0,370,-550,0; 50400,0,0,0,30.4,0,0,0,370,-550,0; 50400,0,0,0,
              30.9,0,0,0,371,-544,0; 54000,0,0,0,30.9,0,0,0,371,-544,0; 54000,0,
              0,0,31,0,0,0,372,-533,0; 57600,0,0,0,31,0,0,0,372,-533,0; 57600,0,
              0,0,30.8,0,0,0,371,-519,0; 61200,0,0,0,30.8,0,0,0,371,-519,0;
              61200,0,0,0,30.1,0,0,0,382,-495,0; 64800,0,0,0,30.1,0,0,0,382,-495,
              0; 64800,0,0,0,28.9,0,0,0,400,-474,0; 68400,0,0,0,28.9,0,0,0,400,
              -474,0; 68400,0,0,0,27,0,0,0,395,-445,0; 72000,0,0,0,27,0,0,0,395,
              -445,0; 72000,0,0,0,24.7,0,0,0,389,-436,0; 75600,0,0,0,24.7,0,0,0,
              389,-436,0; 75600,0,0,0,22.9,0,0,0,383,-427,0; 79200,0,0,0,22.9,0,
              0,0,383,-427,0; 79200,0,0,0,21.9,0,0,0,377,-418,0; 82800,0,0,0,
              21.9,0,0,0,377,-418,0; 82800,0,0,0,20.9,0,0,0,372,-408,0; 86400,0,
              0,0,20.9,0,0,0,372,-408,0],
          columns={5,9,10})
          annotation (Placement(transformation(extent={{-88,3},{-74,17}})));
        Modelica.Blocks.Routing.DeMultiplex3 deMultiplex3_1
          annotation (Placement(transformation(extent={{-68,4},{-56,16}})));
        Modelica.Blocks.Math.UnitConversions.From_degC from_degC
          annotation (Placement(transformation(extent={{-50,11},{-44,17}})));
        Modelica.Blocks.Routing.Multiplex3 multiplex3_1
          annotation (Placement(transformation(extent={{-37,4},{-25,16}})));
        Modelica.Blocks.Sources.CombiTimeTable reference(
          tableName="UserProfilesOffice",
          fileName="./Tables/J1615/UserProfilesOffice.txt",
          tableOnFile=false,
          columns={2},
          extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
          table=[3600,22; 7200,21.9; 10800,21.9; 14400,21.8; 18000,22; 21600,22.3;
              25200,22.7; 28800,24.8; 32400,24.7; 36000,25.2; 39600,25.6; 43200,
              26.1; 46800,25.9; 50400,26.3; 54000,26.6; 57600,27.5; 61200,27.6;
              64800,26; 68400,25.8; 72000,25.6; 75600,25.6; 79200,25.5; 82800,25.5;
              86400,25.5; 781200,37.6; 784800,37.4; 788400,37.3; 792000,37.1;
              795600,37.1; 799200,37.3; 802800,37.5; 806400,39.6; 810000,39.4;
              813600,39.7; 817200,40; 820800,40.3; 824400,40; 828000,40.3; 831600,
              40.5; 835200,41.3; 838800,41.3; 842400,39.6; 846000,39.2; 849600,38.9;
              853200,38.8; 856800,38.7; 860400,38.5; 864000,38.4; 5101200,40.8;
              5104800,40.6; 5108400,40.4; 5112000,40.2; 5115600,40.2; 5119200,40.4;
              5122800,40.5; 5126400,42.6; 5130000,42.3; 5133600,42.6; 5137200,42.9;
              5140800,43.2; 5144400,42.9; 5148000,43.2; 5151600,43.4; 5155200,44.1;
              5158800,44.1; 5162400,42.3; 5166000,42; 5169600,41.6; 5173200,41.5;
              5176800,41.3; 5180400,41.2; 5184000,41])
          annotation (Placement(transformation(extent={{80,80},{100,99}})));
        Utilities.HeatTransfer.HeatToStar HeatTorStar(A=2)
          annotation (Placement(transformation(extent={{38,-96},{58,-76}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow machinesConvective
          annotation (Placement(transformation(extent={{2,-48},{22,-28}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow personsConvective
          annotation (Placement(transformation(extent={{2,-68},{22,-48}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow personsRadiative
          annotation (Placement(transformation(extent={{2,-96},{22,-76}})));
        Modelica.Blocks.Sources.CombiTimeTable innerLoads(
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          tableOnFile=false,
          table=[0,0,0,0; 3600,0,0,0; 7200,0,0,0; 10800,0,0,0; 14400,0,0,0; 18000,0,0,
              0; 21600,0,0,0; 25200,0,0,0; 25200,80,80,200; 28800,80,80,200; 32400,80,
              80,200; 36000,80,80,200; 39600,80,80,200; 43200,80,80,200; 46800,80,80,200;
              50400,80,80,200; 54000,80,80,200; 57600,80,80,200; 61200,80,80,200; 61200,
              0,0,0; 64800,0,0,0; 72000,0,0,0; 75600,0,0,0; 79200,0,0,0; 82800,0,0,0;
              86400,0,0,0],
          columns={2,3,4})
          annotation (Placement(transformation(extent={{-66,-68},{-46,-48}})));
      equation
       referenceTemp = reference.y;
        simulationTemp = reducedModel.airload.port.T;

        connect(sunblind.sunblindonoff, eqAirTemp.sunblindsig)  annotation (Line(
            points={{-10,63},{-10,18}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(varRad3.solarRad_out, sunblind.Rad_In)  annotation (Line(
            points={{-39,73},{-19,73}},
            color={255,128,0},
            smooth=Smooth.None));

        connect(windowRad.y, varRad3.u) annotation (Line(
            points={{-73.3,73},{-58,73}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(wallRad.y, varRad1.u) annotation (Line(
            points={{-73.3,33},{-44,33}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(outdoorTemp.y, deMultiplex3_1.u) annotation (Line(
            points={{-73.3,10},{-69.2,10}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(deMultiplex3_1.y1[1], from_degC.u) annotation (Line(
            points={{-55.4,14.2},{-52.7,14.2},{-52.7,14},{-50.6,14}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(from_degC.y, multiplex3_1.u1[1]) annotation (Line(
            points={{-43.7,14},{-39.95,14},{-39.95,14.2},{-38.2,14.2}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(deMultiplex3_1.y2, multiplex3_1.u2) annotation (Line(
            points={{-55.4,10},{-38.2,10}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(deMultiplex3_1.y3, multiplex3_1.u3) annotation (Line(
            points={{-55.4,5.8},{-38.2,5.8}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(window_shortwave_rad_sum.solarRad_out, reducedModel.solarRad_in)
          annotation (Line(
            points={{26.9,73},{26.9,54.5},{41.99,54.5},{41.99,37.26}},
            color={255,128,0},
            smooth=Smooth.None));
        connect(eqAirTemp.equalAirTemp, reducedModel.equalAirTemp) annotation (
            Line(
            points={{-2,10},{8,10},{8,27.76},{42.2,27.76}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(infiltrationTemp.y, reducedModel.ventilationTemperature)
          annotation (Line(
            points={{26.7,16},{32,16},{32,17.88},{42.2,17.88}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(infiltrationRate.y, reducedModel.ventilationRate) annotation (
            Line(
            points={{40.6,-4},{48,-4},{48,11.8},{50.6,11.8}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(sunblind.Rad_Out, window_shortwave_rad_sum.solarRad_in)
          annotation (Line(
            points={{-1,73},{7.1,73}},
            color={255,128,0},
            smooth=Smooth.None));
        connect(varRad1.solarRad_out, eqAirTemp.solarRad_in) annotation (Line(
            points={{-25,33},{-25,24.5},{-18.5,24.5},{-18.5,15.6}},
            color={255,128,0},
            smooth=Smooth.None));
        connect(multiplex3_1.y, eqAirTemp.weatherData) annotation (Line(
            points={{-24.4,10},{-18,10}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(HeatTorStar.Star, reducedModel.internalGainsRad) annotation (
            Line(
            points={{57.1,-86},{74,-86},{74,11.8},{75.17,11.8}},
            color={95,95,95},
            pattern=LinePattern.None,
            smooth=Smooth.None));
        connect(personsConvective.port, reducedModel.internalGainsConv)
          annotation (Line(
            points={{22,-58},{63.2,-58},{63.2,11.8}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(machinesConvective.port, reducedModel.internalGainsConv)
          annotation (Line(
            points={{22,-38},{63.2,-38},{63.2,11.8}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(innerLoads.y[3], machinesConvective.Q_flow) annotation (Line(
            points={{-45,-58},{-26,-58},{-26,-38},{2,-38}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(innerLoads.y[2], personsConvective.Q_flow) annotation (Line(
            points={{-45,-58},{2,-58}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(innerLoads.y[1], personsRadiative.Q_flow) annotation (Line(
            points={{-45,-58},{-26,-58},{-26,-86},{2,-86}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(personsRadiative.port, HeatTorStar.Therm) annotation (Line(
            points={{22,-86},{38.8,-86}},
            color={191,0,0},
            smooth=Smooth.None));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}),
                            graphics), Icon(graphics),
          experiment(StopTime=5.184e+006, Interval=3600),
          experimentSetupOutput(events=false), Documentation(revisions="<html>
<ul>
  <li><i>March, 2012&nbsp;</i>
         by Moritz Lauster:<br>
         Implemented</li>
</ul>
</html>",     info="<html>
<p>Test Case 9 of the VDI6007:: <a name=\"result_box\">C</a>alculation of the reaction indoor temperature to mixed inner and outer heat sources for Type Room S:</p>
<p>Based on Test Case 8</p>
<ul>
<li>longwave radiation heat exchange is taken into account</li>
</ul>
<p><br>Reference: Room air temperature</p>
<p>Variable path: <code>reducedModel.airload.T</code></p>
<p><br><br>All values are given in the VDI 6007-1.</p>
<p>Same Test Case exists in VDI 6020.</p>
</html>"));
      end TestCase_9;

      model TestCase_10
        extends Modelica.Icons.Example;

        output Modelica.SIunits.Conversions.NonSIunits.Temperature_degC referenceTemp[1];
        output Modelica.SIunits.Temp_K simulationTemp;

        Modelica.Blocks.Sources.Constant infiltrationRate(k=0)
          annotation (Placement(transformation(extent={{40,0},{50,10}})));
        Modelica.Blocks.Sources.Constant infiltrationTemp(k=22)
          annotation (Placement(transformation(extent={{16,0},{26,10}})));
        Modelica.Blocks.Sources.CombiTimeTable windowRad(
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          table=[0,0,0,0,0,0.0; 3600,0,0,0,0,0.0; 10800,0,0,0,0,0.0; 14400,0,0,
              0,0,0.0; 14400,0,0,17,0,0.0; 18000,0,0,17,0,0.0; 18000,0,0,38,0,
              0.0; 21600,0,0,38,0,0.0; 21600,0,0,59,0,0.0; 25200,0,0,59,0,0.0;
              25200,0,0,98,0,0.0; 28800,0,0,98,0,0.0; 28800,0,0,186,0,0.0;
              32400,0,0,186,0,0.0; 32400,0,0,287,0,0.0; 36000,0,0,287,0,0.0;
              36000,0,0,359,0,0.0; 39600,0,0,359,0,0.0; 39600,0,0,385,0,0.0;
              43200,0,0,385,0,0.0; 43200,0,0,359,0,0.0; 46800,0,0,359,0,0.0;
              46800,0,0,287,0,0.0; 50400,0,0,287,0,0.0; 50400,0,0,186,0,0.0;
              54000,0,0,186,0,0.0; 54000,0,0,98,0,0.0; 57600,0,0,98,0,0.0;
              57600,0,0,59,0,0.0; 61200,0,0,59,0,0.0; 61200,0,0,38,0,0.0; 64800,
              0,0,38,0,0.0; 64800,0,0,17,0,0.0; 68400,0,0,17,0,0.0; 68400,0,0,0,
              0,0.0; 72000,0,0,0,0,0.0; 82800,0,0,0,0,0.0; 86400,0,0,0,0,0.0],
          columns={2,3,4,5,6})
          annotation (Placement(transformation(extent={{-86,72},{-66,92}})));
        Utilities.Sources.PrescribedSolarRad Quelle_Fenster(n=5)
          annotation (Placement(transformation(extent={{-50,72},{-30,92}})));
        Components.Weather.Sunblind sunblind(n=5, gsunblind={0,0,0.15,0,0})
          annotation (Placement(transformation(extent={{-20,71},{0,91}})));
        Building.LowOrder.BaseClasses.SolarRadWeightedSum rad_weighted_sum(
            n=5, weightfactors={0,0,7,0,0})
          annotation (Placement(transformation(extent={{8,72},{28,92}})));
        BaseClasses.EqAirTemp eqAirTemp_TestCase_8_1(
          alphaowo=25,
          wf_ground=0.629038674,
          n=5,
          wf_wall={0.000000000,0.000000000,0.046454666,0.000000000,0.0},
          wf_win={0.000000000,0.000000000,0.324506660,0.000000000,0.0},
          T_ground=288.15) annotation (Placement(transformation(extent={{-36,30},
                  {-16,50}})));
        Utilities.Sources.PrescribedSolarRad Quelle_Wand(n=5) annotation (
            Placement(transformation(extent={{-58,44},{-38,64}})));
        Modelica.Blocks.Sources.CombiTimeTable outdoorTemp(
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          columns={2,3,4},
          table=[0,291.95,0,0; 3600,291.95,0,0; 3600,290.25,0,0; 7200,290.25,0,
              0; 7200,289.65,0,0; 10800,289.65,0,0; 10800,289.25,0,0; 14400,
              289.25,0,0; 14400,289.65,0,0; 18000,289.65,0,0; 18000,290.95,0,0;
              21600,290.95,0,0; 21600,293.45,0,0; 25200,293.45,0,0; 25200,
              295.95,0,0; 28800,295.95,0,0; 28800,297.95,0,0; 32400,297.95,0,0;
              32400,299.85,0,0; 36000,299.85,0,0; 36000,301.25,0,0; 39600,
              301.25,0,0; 39600,302.15,0,0; 43200,302.15,0,0; 43200,302.85,0,0;
              46800,302.85,0,0; 46800,303.55,0,0; 50400,303.55,0,0; 50400,
              304.05,0,0; 54000,304.05,0,0; 54000,304.15,0,0; 57600,304.15,0,0;
              57600,303.95,0,0; 61200,303.95,0,0; 61200,303.25,0,0; 64800,
              303.25,0,0; 64800,302.05,0,0; 68400,302.05,0,0; 68400,300.15,0,0;
              72000,300.15,0,0; 72000,297.85,0,0; 75600,297.85,0,0; 75600,
              296.05,0,0; 79200,296.05,0,0; 79200,295.05,0,0; 82800,295.05,0,0;
              82800,294.05,0,0; 86400,294.05,0,0])
          annotation (Placement(transformation(extent={{-100,12},{-80,32}})));
        Modelica.Blocks.Sources.Constant wallRad(k=0)
          annotation (Placement(transformation(extent={{-126,50},{-116,60}})));
        Modelica.Blocks.Routing.Multiplex5 multiplex5_1
          annotation (Placement(transformation(extent={{-84,44},{-64,64}})));
        Building.LowOrder.BaseClasses.ReducedOrderModel reducedModel(
          R1i=0.000779672,
          C1i=1.23140e+07,
          Ai=58,
          splitfac=0.09,
          Aw=7,
          epsw=1,
          RRest=0.014406788,
          R1o=0.001719315,
          C1o=4.33875e+06,
          Ao=28,
          alphaiwi=2.4,
          alphaowi=2.1,
          epsi=1,
          epso=1,
          g=1,
          T0all=290.75)
          annotation (Placement(transformation(extent={{50,42},{98,92}})));
        Modelica.Blocks.Sources.CombiTimeTable reference(
          tableName="UserProfilesOffice",
          fileName="./Tables/J1615/UserProfilesOffice.txt",
          tableOnFile=false,
          columns={2},
          table=[3600,17.6; 7200,17.6; 10800,17.5; 14400,17.5; 18000,17.6; 21600,
              17.8; 25200,18; 28800,20; 32400,19.7; 36000,20; 39600,20.3; 43200,
              20.5; 46800,20.6; 50400,20.7; 54000,20.8; 57600,21.5; 61200,21.4;
              64800,19.8; 68400,19.7; 72000,19.6; 75600,19.6; 79200,19.5; 82800,
              19.5; 86400,19.5; 781200,24.7; 784800,24.6; 788400,24.5; 792000,24.4;
              795600,24.4; 799200,24.5; 802800,24.6; 806400,26.6; 810000,26.2;
              813600,26.4; 817200,26.6; 820800,26.8; 824400,26.9; 828000,26.9;
              831600,26.9; 835200,27.5; 838800,27.4; 842400,25.7; 846000,25.5;
              849600,25.3; 853200,25.3; 856800,25.2; 860400,25.1; 864000,25;
              5101200,25.5; 5104800,25.3; 5108400,25.2; 5112000,25.1; 5115600,25.1;
              5119200,25.2; 5122800,25.3; 5126400,27.3; 5130000,26.9; 5133600,27.1;
              5137200,27.3; 5140800,27.4; 5144400,27.5; 5148000,27.5; 5151600,27.5;
              5155200,28.1; 5158800,28; 5162400,26.3; 5166000,26.1; 5169600,26;
              5173200,25.9; 5176800,25.8; 5180400,25.7; 5184000,25.6],
          extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
          annotation (Placement(transformation(extent={{-98,-26},{-78,-7}})));
        Utilities.HeatTransfer.HeatToStar HeatTorStar(A=2)
          annotation (Placement(transformation(extent={{56,-100},{76,-80}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow machinesConvective
          annotation (Placement(transformation(extent={{20,-52},{40,-32}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow personsConvective
          annotation (Placement(transformation(extent={{20,-72},{40,-52}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow personsRadiative
          annotation (Placement(transformation(extent={{20,-100},{40,-80}})));
        Modelica.Blocks.Sources.CombiTimeTable innerLoads(
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          tableOnFile=false,
          table=[0,0,0,0; 3600,0,0,0; 7200,0,0,0; 10800,0,0,0; 14400,0,0,0; 18000,0,0,
              0; 21600,0,0,0; 25200,0,0,0; 25200,80,80,200; 28800,80,80,200; 32400,80,
              80,200; 36000,80,80,200; 39600,80,80,200; 43200,80,80,200; 46800,80,80,200;
              50400,80,80,200; 54000,80,80,200; 57600,80,80,200; 61200,80,80,200; 61200,
              0,0,0; 64800,0,0,0; 72000,0,0,0; 75600,0,0,0; 79200,0,0,0; 82800,0,0,0;
              86400,0,0,0],
          columns={2,3,4})
          annotation (Placement(transformation(extent={{-48,-72},{-28,-52}})));
      equation
        referenceTemp = reference.y;
        simulationTemp = reducedModel.airload.port.T;

        connect(windowRad.y, Quelle_Fenster.u) annotation (Line(
            points={{-65,82},{-50,82}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(Quelle_Fenster.solarRad_out,sunblind. Rad_In) annotation (Line(
            points={{-31,82},{-19,82}},
            color={255,128,0},
            smooth=Smooth.None));
        connect(multiplex5_1.y, Quelle_Wand.u) annotation (Line(
            points={{-63,54},{-58,54}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(wallRad.y, multiplex5_1.u1[1]) annotation (Line(
            points={{-115.5,55},{-104,55},{-104,64},{-86,64}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(wallRad.y, multiplex5_1.u2[1]) annotation (Line(
            points={{-115.5,55},{-104,55},{-104,59},{-86,59}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(wallRad.y, multiplex5_1.u3[1]) annotation (Line(
            points={{-115.5,55},{-104,55},{-104,54},{-86,54}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(wallRad.y, multiplex5_1.u4[1]) annotation (Line(
            points={{-115.5,55},{-104,55},{-104,49},{-86,49}},
            color={0,0,127},
            smooth=Smooth.None));

        connect(sunblind.sunblindonoff, eqAirTemp_TestCase_8_1.sunblindsig)
          annotation (Line(
            points={{-10,72},{-10,60},{-26,60},{-26,48}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(infiltrationTemp.y, reducedModel.ventilationTemperature)
          annotation (Line(
            points={{26.5,5},{34,5},{34,55},{54.8,55}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(infiltrationRate.y, reducedModel.ventilationRate) annotation (
            Line(
            points={{50.5,5},{64.4,5},{64.4,47}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(rad_weighted_sum.solarRad_out, reducedModel.solarRad_in)
          annotation (Line(
            points={{27,82},{42,82},{42,80.5},{54.56,80.5}},
            color={255,128,0},
            smooth=Smooth.None));
        connect(sunblind.Rad_Out, rad_weighted_sum.solarRad_in) annotation (Line(
            points={{-1,82},{9,82}},
            color={255,128,0},
            smooth=Smooth.None));
        connect(eqAirTemp_TestCase_8_1.equalAirTemp, reducedModel.equalAirTemp)
          annotation (Line(
            points={{-18,40},{-2,40},{-2,36},{18,36},{18,68},{54.8,68}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(outdoorTemp.y, eqAirTemp_TestCase_8_1.weatherData) annotation (
            Line(
            points={{-79,22},{-34,22},{-34,40}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(Quelle_Wand.solarRad_out, eqAirTemp_TestCase_8_1.solarRad_in)
          annotation (Line(
            points={{-39,54},{-38,54},{-38,45.6},{-34.5,45.6}},
            color={255,128,0},
            smooth=Smooth.None));
        connect(wallRad.y, multiplex5_1.u5[1]) annotation (Line(
            points={{-115.5,55},{-104.75,55},{-104.75,44},{-86,44}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(HeatTorStar.Star, reducedModel.internalGainsRad) annotation (
            Line(
            points={{75.1,-90},{92,-90},{92,47},{92.48,47}},
            color={95,95,95},
            pattern=LinePattern.None,
            smooth=Smooth.None));
        connect(personsConvective.port, reducedModel.internalGainsConv)
          annotation (Line(
            points={{40,-62},{78.8,-62},{78.8,47}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(machinesConvective.port, reducedModel.internalGainsConv)
          annotation (Line(
            points={{40,-42},{78.8,-42},{78.8,47}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(innerLoads.y[3], machinesConvective.Q_flow) annotation (Line(
            points={{-27,-62},{-8,-62},{-8,-42},{20,-42}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(innerLoads.y[2], personsConvective.Q_flow) annotation (Line(
            points={{-27,-62},{20,-62}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(innerLoads.y[1], personsRadiative.Q_flow) annotation (Line(
            points={{-27,-62},{-8,-62},{-8,-90},{20,-90}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(personsRadiative.port, HeatTorStar.Therm) annotation (Line(
            points={{40,-90},{56.8,-90}},
            color={191,0,0},
            smooth=Smooth.None));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}),
                            graphics),
          experiment(StopTime=5.184e+006, Interval=3600),
          __Dymola_experimentSetupOutput(events=false),
          Icon(graphics),
          Documentation(revisions="<html>
<p><i>February 2014</i>, by Peter Remmen:</p><p>Implemented</p>
</html>",     info="<html>
<p>Test Case 10 of the VDI6007:: <a name=\"result_box\">C</a>alculation of the reaction indoor temperature to mixed inner and outer heat sources for Type Room S:</p>
<p>Based on Test Case 5</p>
<ul>
<li>The floor is a non adiabatic wall, this changes the parameter calculation. The floor is considered to be anouter wall for RC-Calculation. In order to calculate the weightfactors for EqAirTemp correctly the orientation of this element is not &QUOT;floor&QUOT;. In the parameter calculation &QUOT;West&QUOT; is used. The weightfactor calculated for the west outer wall has to used as the weightfactor of the ground.</li>
<li>changed initial temperature(!!)</li>
</ul>
<p><br><br>Reference: Room air temperature</p>
<p>Variable path: <code>reducedModel.airload.T</code></p>
<p><br><br>All values are given in the VDI 6007-1.</p>
<p>Same Test Case exists in VDI 6020.</p>
</html>"));
      end TestCase_10;

      model TestCase_11
        extends Modelica.Icons.Example;

        output Real referenceLoad[1];
        output Real simulationLoad;

        Modelica.Blocks.Sources.Constant infiltrationRate(k=0)
          annotation (Placement(transformation(extent={{40,6},{50,16}})));
        Modelica.Blocks.Sources.Constant infiltrationTemp(k=22)
          annotation (Placement(transformation(extent={{16,26},{26,36}})));
        Utilities.HeatTransfer.HeatToStar Konvektiv_Strahlung(A=2)
          annotation (Placement(transformation(extent={{50,-92},{70,-72}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow machinesRadiative
          annotation (Placement(transformation(extent={{4,-94},{30,-72}})));
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature outdoorTemp(T=295.15)
          annotation (Placement(transformation(extent={{-14,47},{6,67}})));
        VDIComponents.ReducedOrderModel_surfaceCooling reducedModel(
          C1i=1.48216e+007,
          Aw=7,
          g=0.15,
          C1o=1.60085e+006,
          epsi=1,
          epso=1,
          T0all(displayUnit="K") = 295.15,
          rad_split_conv(x=0.09),
          withWindows=false,
          R1i=0.000595515,
          Ai=75.5,
          RRest=0.042748777,
          R1o=0.004366222,
          Ao=10.5,
          alphaiwi=3)
          annotation (Placement(transformation(extent={{64,36},{98,76}})));
        Utilities.Sources.HeaterCooler.IdealHeaterCoolerVar1 heater(
          Q_flow_heat=1,
          Q_flow_cooler=1,
          h_cooler=0,
          KR_heater=1000,
          KR_cooler=1000,
          TN_heater=1,
          TN_cooler=1,
          h_heater=500,
          l_cooler=-500,
          Cooler_on=false) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=-90,
              origin={-26,-20})));
        Modelica.Blocks.Sources.CombiTimeTable setTemp(
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          columns={2,3},
          table=[0,295.15,295.2; 3600,295.1,295.2; 7200,295.1,295.2; 10800,
              295.1,295.2; 14400,295.1,295.2; 18000,295.1,295.2; 21600,295.1,
              295.2; 25200,300.1,300.2; 28800,300.1,300.2; 32400,300.1,300.2;
              36000,300.1,300.2; 39600,300.1,300.2; 43200,300.1,300.2; 46800,
              300.1,300.2; 50400,300.1,300.2; 54000,300.1,300.2; 57600,300.1,
              300.2; 61200,300.1,300.2; 64800,300.1,300.2; 68400,295.1,295.2;
              72000,295.1,295.2; 75600,295.1,295.2; 79200,295.1,295.2; 82800,
              295.1,295.2; 86400,295.1,295.2])
          annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));
        Modelica.Blocks.Sources.CombiTimeTable reference(
          tableName="UserProfilesOffice",
          fileName="./Tables/J1615/UserProfilesOffice.txt",
          tableOnFile=false,
          columns={2,3},
          table=[3600,22,0; 7200,22,0; 10800,22,0; 14400,22,0; 18000,22,0; 21600,22,
              0; 25200,24.9,-500; 28800,25.2,-500; 32400,25.6,-500; 36000,25.9,-500;
              39600,26.2,-500; 43200,26.5,-500; 46800,26.8,-500; 50400,27,-464;
              54000,27,-397; 57600,27,-333; 61200,27,-272; 64800,27,-215; 68400,
              25.3,500; 72000,25.2,500; 75600,25.1,500; 79200,24.9,500; 82800,24.8,
              500; 86400,24.7,500; 781200,26.2,500; 784800,26.1,500; 788400,26,500;
              792000,25.8,500; 795600,25.7,500; 799200,25.6,500; 802800,26.7,-126;
              806400,26.8,-76; 810000,26.9,-28; 813600,27,121; 817200,27,391;
              820800,27,500; 824400,27.1,500; 828000,27.2,500; 831600,27.3,500;
              835200,27.4,500; 838800,27.5,500; 842400,27.6,500; 846000,27,500;
              849600,26.9,500; 853200,26.7,500; 856800,26.6,500; 860400,26.5,500;
              864000,26.4,500; 5101200,26.2,500; 5104800,26.1,500; 5108400,26,500;
              5112000,25.8,500; 5115600,25.7,500; 5119200,25.6,500; 5122800,27,-126;
              5126400,27,-76; 5130000,27,-28; 5133600,27,121; 5137200,27,391;
              5140800,27,500; 5144400,27.1,500; 5148000,27.2,500; 5151600,27.3,500;
              5155200,27.4,500; 5158800,27.5,500; 5162400,27.6,500; 5166000,27,500;
              5169600,26.9,500; 5173200,26.7,500; 5176800,26.6,500; 5180400,26.5,
              500; 5184000,26.4,500],
          extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
          annotation (Placement(transformation(extent={{-96,78},{-76,97}})));
        Modelica.Blocks.Math.Add sumHeatLoad
          annotation (Placement(transformation(extent={{86,86},{96,96}})));
        Utilities.Sources.HeaterCooler.IdealHeaterCoolerVar1 cooler(
          Q_flow_heat=1,
          Q_flow_cooler=1,
          h_cooler=0,
          KR_heater=1000,
          KR_cooler=1000,
          TN_heater=1,
          TN_cooler=1,
          h_heater=500,
          l_cooler=-500,
          Heater_on=false) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=-90,
              origin={-26,-48})));
        Modelica.Blocks.Sources.CombiTimeTable innerLoads(
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          tableName="UserProfilesOffice",
          fileName="./Tables/J1615/UserProfilesOffice.txt",
          tableOnFile=false,
          columns={2,3},
          table=[0,0,0; 3600,0,0; 7200,0,0; 10800,0,0; 14400,0,0; 18000,0,0;
              21600,0,0; 21600,0,1000; 25200,0,1000; 28800,0,1000; 32400,0,1000;
              36000,0,1000; 39600,0,1000; 43200,0,1000; 46800,0,1000; 50400,0,
              1000; 54000,0,1000; 57600,0,1000; 61200,0,1000; 64800,0,1000;
              64800,0,0; 68400,0,0; 72000,0,0; 75600,0,0; 79200,0,0; 82800,0,0;
              86400,0,0])
          annotation (Placement(transformation(extent={{-24,-93},{-10,-79}})));
      equation
        connect(machinesRadiative.port, Konvektiv_Strahlung.Therm) annotation (
            Line(
            points={{30,-83},{38,-83},{38,-82},{50.8,-82}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(setTemp.y[1], heater.soll_heat) annotation (Line(
            points={{-59,-20},{-50,-20},{-50,-23},{-30.8,-23}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(sumHeatLoad.u1, heater.heatMeter.p);
        connect(sumHeatLoad.u2, cooler.coolMeter.p);
       referenceLoad[1]=-reference.y[2];
        simulationLoad=sumHeatLoad.y;

        connect(setTemp.y[2], cooler.soll_cool) annotation (Line(
            points={{-59,-20},{-44,-20},{-44,-43.2},{-30.8,-43.2}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(innerLoads.y[2], machinesRadiative.Q_flow) annotation (Line(
            points={{-9.3,-86},{-2,-86},{-2,-83},{4,-83}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(outdoorTemp.port, reducedModel.equivalentoutdoortemp)
          annotation (Line(
            points={{6,57},{36.5,57},{36.5,56.8},{67.4,56.8}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(infiltrationTemp.y, reducedModel.outdoorairtemp) annotation (
            Line(
            points={{26.5,31},{38,31},{38,46.4},{67.4,46.4}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(infiltrationRate.y, reducedModel.InfiltrationVentilationRate)
          annotation (Line(
            points={{50.5,11},{72.5,11},{72.5,40}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(heater.HeatCoolRoom, reducedModel.innerLoadskonv) annotation (
            Line(
            points={{-26,-29},{28,-29},{28,-28},{79.64,-28},{79.64,40}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(cooler.HeatCoolRoom, reducedModel.surfaceCooling) annotation (
            Line(
            points={{-26,-57},{38,-57},{38,-54},{87.12,-54},{87.12,40}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(Konvektiv_Strahlung.Star, reducedModel.innerLoadsrad) annotation (
           Line(
            points={{69.1,-82},{84,-82},{84,-84},{94.09,-84},{94.09,40}},
            color={95,95,95},
            pattern=LinePattern.None,
            smooth=Smooth.None));
        annotation (experiment(StopTime=5.184e+006, Interval=3600),
            __Dymola_experimentSetupOutput(events=false),
          Icon(graphics),
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {100,100}}),graphics),
          Documentation(revisions="<html>
<p><i>February 2014</i>, by Peter Remmen:</p><p>Implemented</p>
</html>",     info="<html>
<p>Test Case 11 of the VDI6007: <a name=\"result_box\">L</a>oad calculation in compliance with the desired values of the indoor temperature and a setpoint for the type space S:</p>
<p>Based on Test Case 7</p>
<ul>
<li>implementation of a cooling ceeling (only cooling)</li>
</ul>
<p>Reference: Heating/Cooling load</p>
<p>Variable path: <code>sumHeatLoad.y</code></p>
<p><br><br>All values are given in the VDI 6007-1.</p>
</html>"));
      end TestCase_11;

      model TestCase_12
        extends Modelica.Icons.Example;

        output Modelica.SIunits.Conversions.NonSIunits.Temperature_degC referenceTemp[1];
        output Modelica.SIunits.Temp_K simulationTemp;
        Building.LowOrder.BaseClasses.ReducedOrderModel reducedModel(
          C1i=1.48216e+007,
          Aw=7,
          C1o=1.60085e+006,
          epsi=1,
          epso=1,
          T0all(displayUnit="K") = 295.15,
          R1i=0.000595515,
          Ai=75.5,
          RRest=0.042748777,
          R1o=0.004366222,
          Ao=10.5,
          splitfac=0.09,
          epsw=1,
          g=1,
          airload(V=0.1),
          alphaiwi=2.2)
          annotation (Placement(transformation(extent={{54,30},{88,70}})));
        Modelica.Blocks.Sources.CombiTimeTable outdoorTemp(
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          columns={2,3,4},
          table=[0,291.95,0,0; 3600,291.95,0,0; 3600,290.25,0,0; 7200,290.25,0,
              0; 7200,289.65,0,0; 10800,289.65,0,0; 10800,289.25,0,0; 14400,
              289.25,0,0; 14400,289.65,0,0; 18000,289.65,0,0; 18000,290.95,0,0;
              21600,290.95,0,0; 21600,293.45,0,0; 25200,293.45,0,0; 25200,
              295.95,0,0; 28800,295.95,0,0; 28800,297.95,0,0; 32400,297.95,0,0;
              32400,299.85,0,0; 36000,299.85,0,0; 36000,301.25,0,0; 39600,
              301.25,0,0; 39600,302.15,0,0; 43200,302.15,0,0; 43200,302.85,0,0;
              46800,302.85,0,0; 46800,303.55,0,0; 50400,303.55,0,0; 50400,
              304.05,0,0; 54000,304.05,0,0; 54000,304.15,0,0; 57600,304.15,0,0;
              57600,303.95,0,0; 61200,303.95,0,0; 61200,303.25,0,0; 64800,
              303.25,0,0; 64800,302.05,0,0; 68400,302.05,0,0; 68400,300.15,0,0;
              72000,300.15,0,0; 72000,297.85,0,0; 75600,297.85,0,0; 75600,
              296.05,0,0; 79200,296.05,0,0; 79200,295.05,0,0; 82800,295.05,0,0;
              82800,294.05,0,0; 86400,294.05,0,0])
          annotation (Placement(transformation(extent={{-60,18},{-40,38}})));
        Modelica.Blocks.Sources.CombiTimeTable windowRad(
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          table=[0,0,0,0,0,0.0; 3600,0,0,0,0,0.0; 10800,0,0,0,0,0.0; 14400,0,0,
              0,0,0.0; 14400,0,0,17,0,0.0; 18000,0,0,17,0,0.0; 18000,0,0,38,0,
              0.0; 21600,0,0,38,0,0.0; 21600,0,0,59,0,0.0; 25200,0,0,59,0,0.0;
              25200,0,0,98,0,0.0; 28800,0,0,98,0,0.0; 28800,0,0,186,0,0.0;
              32400,0,0,186,0,0.0; 32400,0,0,287,0,0.0; 36000,0,0,287,0,0.0;
              36000,0,0,359,0,0.0; 39600,0,0,359,0,0.0; 39600,0,0,385,0,0.0;
              43200,0,0,385,0,0.0; 43200,0,0,359,0,0.0; 46800,0,0,359,0,0.0;
              46800,0,0,287,0,0.0; 50400,0,0,287,0,0.0; 50400,0,0,186,0,0.0;
              54000,0,0,186,0,0.0; 54000,0,0,98,0,0.0; 57600,0,0,98,0,0.0;
              57600,0,0,59,0,0.0; 61200,0,0,59,0,0.0; 61200,0,0,38,0,0.0; 64800,
              0,0,38,0,0.0; 64800,0,0,17,0,0.0; 68400,0,0,17,0,0.0; 68400,0,0,0,
              0,0.0; 72000,0,0,0,0,0.0; 82800,0,0,0,0,0.0; 86400,0,0,0,0,0.0],
          columns={2,3,4,5,6})
          annotation (Placement(transformation(extent={{-82,72},{-62,92}})));
        Utilities.Sources.PrescribedSolarRad Quelle_Fenster(n=5)
          annotation (Placement(transformation(extent={{-54,72},{-34,92}})));
        Components.Weather.Sunblind sunblind(n=5, gsunblind={0,0,0.15,0,0})
          annotation (Placement(transformation(extent={{-24,71},{-4,91}})));
        Building.LowOrder.BaseClasses.SolarRadWeightedSum rad_weighted_sum(
            n=5, weightfactors={0,0,7,0,0})
          annotation (Placement(transformation(extent={{4,72},{24,92}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature varTemp
          annotation (Placement(transformation(extent={{-2,26},{18,46}})));
        Modelica.Blocks.Sources.CombiTimeTable ventitaltionRate(
          table=[0,1.9048; 3600,1.9048; 7200,1.9048; 10800,1.9048; 14400,1.9048;
              18000,1.9048; 21600,1.9048; 25200,1.9048; 25200,0.95238; 28800,
              0.95238; 32400,0.95238; 36000,0.95238; 39600,0.95238; 43200,0.95238;
              46800,0.95238; 50400,0.95238; 54000,0.95238; 57600,0.95238; 61200,
              0.95238; 61200,1.9048; 64800,1.9048; 72000,1.9048; 75600,1.9048;
              79200,1.9048; 82800,1.9048; 86400,1.9048],
          columns={2},
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
          annotation (Placement(transformation(extent={{-60,-16},{-40,4}})));
        Modelica.Blocks.Sources.CombiTimeTable reference(
          tableName="UserProfilesOffice",
          fileName="./Tables/J1615/UserProfilesOffice.txt",
          tableOnFile=false,
          columns={2},
          table=[3600,21.5; 7200,21.2; 10800,21; 14400,20.9; 18000,21; 21600,21.3;
              25200,21.9; 28800,24.1; 32400,24; 36000,24.4; 39600,24.8; 43200,25.1;
              46800,25.4; 50400,25.5; 54000,25.7; 57600,26.3; 61200,26.3; 64800,
              25.2; 68400,25; 72000,24.7; 75600,24.3; 79200,24; 82800,23.8; 86400,
              23.6; 781200,29.1; 784800,28.7; 788400,28.5; 792000,28.3; 795600,28.3;
              799200,28.6; 802800,29.1; 806400,31.8; 810000,31.7; 813600,32; 817200,
              32.3; 820800,32.6; 824400,32.8; 828000,32.9; 831600,33; 835200,33.6;
              838800,33.5; 842400,31.8; 846000,31.5; 849600,31.1; 853200,30.7;
              856800,30.3; 860400,30.1; 864000,29.8; 5101200,30.5; 5104800,30;
              5108400,29.8; 5112000,29.6; 5115600,29.6; 5119200,29.8; 5122800,30.3;
              5126400,33.1; 5130000,33; 5133600,33.3; 5137200,33.7; 5140800,33.9;
              5144400,34.1; 5148000,34.2; 5151600,34.3; 5155200,34.9; 5158800,34.8;
              5162400,33; 5166000,32.7; 5169600,32.2; 5173200,31.8; 5176800,31.4;
              5180400,31.2; 5184000,30.9],
          extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
          annotation (Placement(transformation(extent={{-96,-38},{-76,-19}})));
        Utilities.HeatTransfer.HeatToStar HeatTorStar(A=2)
          annotation (Placement(transformation(extent={{48,-104},{68,-84}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow machinesConvective
          annotation (Placement(transformation(extent={{12,-56},{32,-36}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow personsConvective
          annotation (Placement(transformation(extent={{12,-76},{32,-56}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow personsRadiative
          annotation (Placement(transformation(extent={{12,-104},{32,-84}})));
        Modelica.Blocks.Sources.CombiTimeTable innerLoads(
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          tableOnFile=false,
          table=[0,0,0,0; 3600,0,0,0; 7200,0,0,0; 10800,0,0,0; 14400,0,0,0; 18000,0,0,
              0; 21600,0,0,0; 25200,0,0,0; 25200,80,80,200; 28800,80,80,200; 32400,80,
              80,200; 36000,80,80,200; 39600,80,80,200; 43200,80,80,200; 46800,80,80,200;
              50400,80,80,200; 54000,80,80,200; 57600,80,80,200; 61200,80,80,200; 61200,
              0,0,0; 64800,0,0,0; 72000,0,0,0; 75600,0,0,0; 79200,0,0,0; 82800,0,0,0;
              86400,0,0,0],
          columns={2,3,4})
          annotation (Placement(transformation(extent={{-56,-76},{-36,-56}})));
      equation
        referenceTemp = reference.y;
        simulationTemp = reducedModel.airload.port.T;

        connect(outdoorTemp.y[1], varTemp.T) annotation (Line(
            points={{-39,28},{-22,28},{-22,36},{-4,36}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(windowRad.y, Quelle_Fenster.u) annotation (Line(
            points={{-61,82},{-54,82}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(Quelle_Fenster.solarRad_out, sunblind.Rad_In) annotation (Line(
            points={{-35,82},{-23,82}},
            color={255,128,0},
            smooth=Smooth.None));
        connect(varTemp.port, reducedModel.equalAirTemp) annotation (Line(
            points={{18,36},{28,36},{28,50.8},{57.4,50.8}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(sunblind.Rad_Out, rad_weighted_sum.solarRad_in) annotation (Line(
            points={{-5,82},{5,82}},
            color={255,128,0},
            smooth=Smooth.None));
        connect(rad_weighted_sum.solarRad_out, reducedModel.solarRad_in)
          annotation (Line(
            points={{23,82},{32,82},{32,60.8},{57.23,60.8}},
            color={255,128,0},
            smooth=Smooth.None));
        connect(ventitaltionRate.y[1], reducedModel.ventilationTemperature)
          annotation (Line(
            points={{-39,-6},{44,-6},{44,40.4},{57.4,40.4}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(outdoorTemp.y[1], reducedModel.ventilationRate) annotation (
            Line(
            points={{-39,28},{-22,28},{-22,8},{64.2,8},{64.2,34}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(HeatTorStar.Star, reducedModel.internalGainsRad) annotation (
            Line(
            points={{67.1,-94},{84,-94},{84,34},{84.09,34}},
            color={95,95,95},
            pattern=LinePattern.None,
            smooth=Smooth.None));
        connect(personsConvective.port, reducedModel.internalGainsConv)
          annotation (Line(
            points={{32,-66},{74.4,-66},{74.4,34}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(machinesConvective.port, reducedModel.internalGainsConv)
          annotation (Line(
            points={{32,-46},{74.4,-46},{74.4,34}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(innerLoads.y[3], machinesConvective.Q_flow) annotation (Line(
            points={{-35,-66},{-16,-66},{-16,-46},{12,-46}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(innerLoads.y[2], personsConvective.Q_flow) annotation (Line(
            points={{-35,-66},{12,-66}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(innerLoads.y[1], personsRadiative.Q_flow) annotation (Line(
            points={{-35,-66},{-16,-66},{-16,-94},{12,-94}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(personsRadiative.port, HeatTorStar.Therm) annotation (Line(
            points={{32,-94},{48.8,-94}},
            color={191,0,0},
            smooth=Smooth.None));
        annotation (
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}),
                  graphics),
          experiment(StopTime=5.184e+006, Interval=3600),
          __Dymola_experimentSetupOutput(events=false),
          Icon(graphics),
          Documentation(revisions="<html>
<p><i>February 2014</i>, by Peter Remmen:</p><p>Implemented</p>
</html>",     info="<html>
<p>Test Case 12 of the VDI6007: <a name=\"result_box\">C</a>alculation of the reaction indoor temperature to mixed inner and outer heat sources for Type Room S:</p>
<p>Based on Test Case 5</p>
<ul>
<li>fixed ventialation day and night</li>
</ul>
<p>Reference: Room air temperature</p>
<p>Variable path: <code>reducedModel.airload.T</code></p>
<p><br><br>All values are given in the VDI 6007-1.</p>
<p>Same Test Case exists in VDI 6020.</p>
</html>"));
      end TestCase_12;

      package VDIComponents
        "BaseClass-Components with modifications to fulfill requirements of Test Cases"
          extends Modelica.Icons.Package;
        model EqAirTemp_TestCase_8

          parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaowo=20
            "Outer wall's coefficient of heat transfer (outer side)";
          parameter Real aowo=0.6
            "Coefficient of absorption of the outer walls";
          parameter Real eowo=0.9 "Coefficientasdission of the outer walls";
          parameter Integer n=5 "Number of orientations (without ground)";
          //parameter Real orientationswallsvertical[n]={0,90,180,270,0} "orientations of the walls against the horizontal (n,e,s,w)"; //Muss rein bei genauer Beachtung der Orientierungen ueber phi fuer die langwellige Strahlung
          //parameter Real orientationswallshorizontal[n]={90,90,90,90,0} "orientations of the walls against the vertical (wall,roof)"; //Muss rein bei genauer Beachtung der Orientierungen ueber phi fuer die langwellige Strahlung
          parameter Real wf_wall[n]={0.5,0.2,0.2,0.1,0}
            "Weight factors of the walls";
          //parameter Integer m=4 "Number of window orientations";
          //parameter Real orientationswindowsvertical[m]={0,90,180,270,0} "orientations of the windows against the horizontal (n,e,s,w)"; //Muss rein bei genauer Beachtung der Orientierungen ueber phi fuer die langwellige Strahlung
          //parameter Real orientationswindowshorizontal[m]={90,90,90,90,0} "orientations of the windows against the vertical (wall,roof)"; //Muss rein bei genauer Beachtung der Orientierungen ueber phi fuer die langwellige Strahlung
          parameter Real wf_win[n]={0,0,0,0,0} "Weight factors of the windows";
          parameter Real wf_ground=0
            "Weight factor of the ground (0 if not considered)";
          parameter Modelica.SIunits.Temp_K T_ground=284.15
            "Temperature of the ground in contact with ground slab";
        protected
                    parameter Real phiprivate=0.5; //Phi muss für horizontal geneigte Flaechen agepasst werden
                    parameter Real unitvec[n]=ones(n);
                   // parameter Real unitvecwindow[m]=ones(m);
        public
          Modelica.Blocks.Interfaces.RealInput WeatherDataVector[3]
            "[1]: Air temperature<br>[2]: Horizontal radiation of sky<br>[3]: Horizontal radiation of earth"
            annotation (Placement(transformation(extent={{-120,-20},{-80,20}}),
                iconTransformation(extent={{-100,-20},{-60,20}}))); //Muss noch auf neues Modell von Ana angepasst werden
          Utilities.Interfaces.SolarRad_in Rad_In[n] annotation (Placement(
                transformation(extent={{-100,56},{-80,76}}),
                iconTransformation(extent={{-99,42},{-71,70}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a equalairtemp
            annotation (Placement(transformation(extent={{80,-6},{100,14}}),
                iconTransformation(extent={{60,-20},{100,20}})));

         Modelica.SIunits.TemperatureDifference T_earth
            "radiative temperature of the land surface";
          Modelica.SIunits.TemperatureDifference T_sky
            "radiative temperature of the sky";

          Modelica.SIunits.Temp_K T_eqWall[n] "temperature equal wall";
          Modelica.SIunits.Temp_K T_eqWin[n] "temperature equal window";

        protected
          Modelica.SIunits.RadiantEnergyFluenceRate E_earth
            "Iradiation from land surface";
          Modelica.SIunits.RadiantEnergyFluenceRate E_sky "Iradiation from sky";

          Modelica.SIunits.Temp_K T_air "outdoor air temperature";

          Modelica.SIunits.TemperatureDifference T_eqLWs
            "equal long wave scalar";
          Modelica.SIunits.TemperatureDifference T_eqLW[n] "equal long wave";
          Modelica.SIunits.TemperatureDifference T_eqSW[n] "equal short wave";

          Modelica.SIunits.CoefficientOfHeatTransfer alpharad;

        public
          Modelica.Blocks.Interfaces.RealInput sunblindsig[n]
            annotation (Placement(transformation(extent={{-20,-20},{20,20}},
                rotation=-90,
                origin={-10,100}),
                iconTransformation(extent={{-20,-20},{20,20}},
                rotation=-90,
                origin={0,80})));

        initial equation
          assert(n==size(wf_wall,1),"weightfactorswall has to have n elements");
          assert(n==size(wf_win,1),"weightfactorswall has to have n elements");
          if ((sum(wf_wall)+sum(wf_win)+wf_ground)<>0.00001)==false then
            Modelica.Utilities.Streams.print("WARNING!:The sum of the weightfactors (walls,windows and ground) in eqairtemp is 0. This means, that eqairtemp is 0 °C. If there are no walls, windows and ground at all, this might be irrelevant.");
          end if;
          if (abs((sum(wf_wall)+sum(wf_win)+wf_ground)-1)>0.1) then
            Modelica.Utilities.Streams.print("WARNING!:The sum of the weightfactors (walls,windows and ground) in eqairtemp is <0.9 or >1.1. Normally, the sum should be 1, as the influence of all weightfactors should the whole influence on the temperature.");
          end if;
        equation
          if cardinality(sunblindsig)<1 then
            sunblindsig=fill(0,n);
          end if;

          T_air=WeatherDataVector[1];
          E_sky=WeatherDataVector[2];
          E_earth=WeatherDataVector[3];
          if (abs(E_sky+E_earth)<0.1) then
            alpharad=5.0;
          else
            alpharad=(E_sky+E_earth)/(T_sky-T_earth);
          end if;

          T_earth=((-E_earth/(0.93*5.67))^0.25)*100;//-273.15
          T_sky=((E_sky/(0.93*5.67))^0.25)*100;//-273.15

          T_eqLWs=0;
          T_eqLW={0,0,0,0,0};

          T_eqSW=Rad_In.I*aowo/alphaowo;

          T_eqWin=(T_air*unitvec)+T_eqLW;
          T_eqWall=(T_air+T_eqLWs)*unitvec+T_eqSW;
        //  T_ground is currently a parameter

          //temperatureequalwindowcelsius = Modelica.SIunits.Conversions.to_degC(temperatureequalwindow);
          //temperatureequalwallcelsius = Modelica.SIunits.Conversions.to_degC(temperatureequalwall);
          //temperaturegroundcelsius = Modelica.SIunits.Conversions.to_degC(temperatureground);

          equalairtemp.T = T_eqWall*wf_wall + T_eqWin*wf_win + T_ground*wf_ground;

          annotation (Diagram(graphics), Icon(graphics={
                Rectangle(
                  extent={{-70,-76},{78,76}},
                  lineColor={0,128,255},
                  lineThickness=1,
                  fillColor={0,128,255},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{20,46},{60,-76}},
                  lineColor={0,0,0},
                  fillColor={0,0,0},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{60,46},{2,46},{60,74},{60,70},{60,46}},
                  lineColor={0,0,0},
                  smooth=Smooth.None,
                  fillColor={255,85,85},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-60,72},{-28,40}},
                  lineColor={255,255,0},
                  fillColor={255,255,0},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{-70,-76},{78,-90}},
                  lineColor={0,127,0},
                  fillColor={0,127,0},
                  fillPattern=FillPattern.Forward),
                Line(
                  points={{-54,-74},{-58,-66},{-50,-62},{-56,-54},{-52,-50},{-54,-44}},
                  color={0,0,0},
                  smooth=Smooth.Bezier,
                  thickness=1),
                Line(
                  points={{-58,-48},{-54,-40},{-50,-46}},
                  color={0,0,0},
                  thickness=1,
                  smooth=Smooth.Bezier),
                Line(
                  points={{-40,-74},{-44,-66},{-36,-62},{-42,-54},{-38,-50},{-40,-44}},
                  color={0,0,0},
                  smooth=Smooth.Bezier,
                  thickness=1),
                Line(
                  points={{-44,-48},{-40,-40},{-36,-46}},
                  color={0,0,0},
                  thickness=1,
                  smooth=Smooth.Bezier),
                Line(
                  points={{-50,34},{-50,10}},
                  color={255,255,0},
                  thickness=1,
                  smooth=Smooth.Bezier),
                Line(
                  points={{-36,36},{-24,14}},
                  color={255,255,0},
                  thickness=1,
                  smooth=Smooth.Bezier),
                Line(
                  points={{-24,46},{-6,32}},
                  color={255,255,0},
                  thickness=1,
                  smooth=Smooth.Bezier),
                Line(
                  points={{12,-30},{12,-68},{6,-70},{4,-60},{4,-30},{10,-22},{12,-30}},
                  color={0,0,0},
                  thickness=1,
                  smooth=Smooth.Bezier),
                Line(
                  points={{10,-48},{12,-38},{14,-48}},
                  color={0,0,0},
                  thickness=1,
                  smooth=Smooth.Bezier)}),
            Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<ul>
<li>This component computes the so called &QUOT;equivalent outdoor air temperature&QUOT;. Basically, this includes a correction for the longwave and shortwave radiance (not on windows!). </li>
<li>The computed temperature is the temperature near the wall surface. The radiant and convective heat transfer is considered in the model. The next component connected to the heat port should be the description of the heat conductance through the wall.</li>
<li>This component was written for usage in combination with the <a href=\"AixLib.Building.LowOrder.BaseClasses.ReducedOrderModel\">ReducedOrderModel</a> (see <a href=\"AixLib.Building.LowOrder.BaseClasses.ThermalZonePhysics\">ThermalZonePhysics</a>). As input it needs weather data, radiance (beam) by the radiance input and longwave sky radiation, longwave terrestric radiation and air temperature by the Real WeatherData input. There is the possibility to link a <a href=\"AixLib.Building.Components.Weather.Sunblind\">Sunblind</a> by the sunblindsig input. This takes the changes in radiation on the windows through a closed shading into account.</li>
<li>Weightfactors: The different equivalent temperatures for the different directions (due to shortwave radiance and the ground) are weighted and summed up with the weightfactors. See VDI 6007 for more information about the weightfactors (equation: U_i*A_i/sum(U*A)). As the equivalent temperature is a weighted temperature for all surfaces and it was originally written for building zones, the temperature of the ground under the thermal zone can be considered (weightfactorgound &GT; 0). The sum of all weightfactors should be 1.</li>
<li>Additionally, you need the coefficient of heat transfer and the coefficient of absorption on the outer side of the walls and windows for all directions (weighted scalars) . The coefficient of absorption is different to the emissivity due to the spectrum of the sunlight (0.6 might be a good choice).</li>
</ul>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Known Limitations</span></h4>
<p>The heat transfer through the radiance is considered by an alpha. It is computed and is somewhere around 5. In cases of exorbitant high radiance values, this alpha could be not as accurate as a real T^4 equation.</p>
<p>The longwave radiation is normally also considered for each direction separately, but this means that you need the angles for each direction. As the longwave term has no great impact on the equivalent temperature, the improvement is not worth the costs. Phiprivate is set to 0.5. Nonetheless, the parameters are prepared, but the equations for phiprivate ( in which the angles have an effect) are not yet implemented.</p>
<p>In addition, the convective heat transfer coefficient alpha is weighted over the areas per each direction. In VDI 6007, alpha is considered for each element and not averaged per direction. This may cause deviations if the alphas of the single elements are considerabely different. </p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>To the air temperature is added (or substracted) a term for longwave radiation and one term for shortwave radiation. As the shortwave radiation is taken into account only for the walls and the windows can be equipped with a shading, the equal temperatures are computed separately for the windows and for the walls. Due to the different beams in different directions, the temperatures are also computed separately for each direction. You need one weightfactor per direction and wall or window, e.g. 4 directions means 8 weightfactors (4 windows, 4 walls). Additionally, one weightfactor for the ground (for the ground temperature) .</p>
<p><br>First, a temperature of the earth (not the ground temperature!) and temperature of the sky are computed. The difference is taken into account for the longwave radiance term. </p>
<p>For the windows, the shading input is considered on the longwave term.</p>
<p>For the walls, the shortwave radiance term is computed with the beam of the radiance input.</p>
<p>The n temperature of the walls, the n temperature of the windows and the ground temperature are weighted with the weightfactors and summed up. As this equations only works in &deg;C, the unit is changed and rechanged to use Kelvin for the heat port again.</p>
<p><br><br><b><font style=\"color: #008000; \">References</font></b></p>
<ul>
<li>German Association of Engineers: Guideline VDI 6007-1, March 2012: Calculation of transient thermal response of rooms and buildings - Modelling of rooms.</li>
<li>Lauster, Moritz; Remmen, Peter; Fuchs, Marcus; Teichmann, Jens; Streblow, Rita; M&uuml;ller, Dirk (2014): Modelling long-wave radiation heat exchange for thermal network building simulations at urban scale using Modelica. In: the 10th International Modelica Conference, March 10-12, 2014, Lund, Sweden, March 10-12, 2014: Link&ouml;ping University Electronic Press (Link&ouml;ping Electronic Conference Proceedings), p. 125&ndash;133. DOI: <a href=\"http://dx.doi.org/10.3384/ECP14096125\">10.3384/ECP14096125</a>.</li>
<li>Lauster, M.; Teichmann, J.; Fuchs, M.; Streblow, R.; Mueller, D. (2014): Low order thermal network models for dynamic simulations of buildings on city district scale. In: Building and Environment 73, p. 223&ndash;231. DOI: <a href=\"http://dx.doi.org/10.1016/j.buildenv.2013.12.016\">10.1016/j.buildenv.2013.12.016</a>.</li>
</ul>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p>See <a href=\"AixLib.Building.LowOrder.Validation\">Validation</a> for some results.</p>
</html>",       revisions="<html>
<p><ul>
<li><i>January 2012,&nbsp;</i> by Moritz Lauster:<br/>Implemented.</li>
<li><i>February 2014</i>, by Peter Remmen: No calculation of longwave radiation heat exchange</li>
</ul></p>
</html>"));
        end EqAirTemp_TestCase_8;

        model ReducedOrderModel_surfaceCooling
          "Modell corresponding to VDI 6007"

          parameter Boolean withInnerwalls=true "If inner walls are existent"   annotation(Dialog(tab="Inner walls"));
          parameter Modelica.SIunits.ThermalResistance R1i=0.0005955
            "Resistor 1 inner wall"
            annotation(Dialog(tab="Inner walls",enable = if withInnerwalls then true else false));
          parameter Modelica.SIunits.HeatCapacity C1i=14860000
            "Capacity 1 inner wall"
            annotation(Dialog(tab="Inner walls",enable = if withInnerwalls then true else false));
          parameter Modelica.SIunits.Area Ai=75.5 "Inner wall area"
            annotation(Dialog(tab="Inner walls",enable = if withInnerwalls then true else false));
          parameter Modelica.SIunits.Temp_K T0all=295.15
            "Initial temperature for all components";
          parameter Boolean withWindows=true "If windows are existent"   annotation(Dialog(tab="Outer walls",group = "Windows",enable = if withOuterwalls then true else false));
          parameter Real splitfac=0
            "Factor for conv. part of rad. through windows"
           annotation(Dialog(tab="Outer walls",group = "Windows",enable = if withWindows and withOuterwalls then true else false));
          parameter Modelica.SIunits.Area Aw=10.5 "Window area"
            annotation(Dialog(tab="Outer walls",group = "Windows",enable = if withWindows and withOuterwalls then true else false));
          parameter Modelica.SIunits.Emissivity epsw=0.95
            "Emissivity of the windows"
            annotation(Dialog(tab="Outer walls",group = "Windows",enable = if withWindows and withOuterwalls then true else false));
          parameter Modelica.SIunits.TransmissionCoefficient g=0.7
            "Total energy transmittance"
            annotation(Dialog(tab="Outer walls",group = "Windows",enable = if withWindows and withOuterwalls then true else false));
          parameter Boolean withOuterwalls=true
            "If outer walls (including windows) are existent"  annotation(Dialog(tab="Outer walls"));
          parameter Modelica.SIunits.ThermalResistance RRest=0.0427487
            "Resistor Rest outer wall"
            annotation(Dialog(tab="Outer walls",enable = if withOuterwalls then true else false));
          parameter Modelica.SIunits.ThermalResistance R1o=0.004366
            "Resistor 1 outer wall"
            annotation(Dialog(tab="Outer walls",enable = if withOuterwalls then true else false));
          parameter Modelica.SIunits.HeatCapacity C1o=1557570
            "Capacity 1 outer wall"
            annotation(Dialog(tab="Outer walls",enable = if withOuterwalls then true else false));
          parameter Modelica.SIunits.Area Ao=10.5 "Outer wall area"
            annotation(Dialog(tab="Outer walls",enable = if withOuterwalls then true else false));
          parameter Modelica.SIunits.Volume Vair=52.5
            "Volume of the air in the zone"
            annotation(Dialog(tab="Room air"));
          parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaiwi=2.7
            "Coefficient of heat transfer for inner walls"
            annotation(Dialog(tab="Inner walls",enable = if withInnerwalls then true else false));
          parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaowi=2.7
            "Outer wall's coefficient of heat transfer (inner side)"
            annotation(Dialog(tab="Outer walls",enable = if withOuterwalls then true else false));
          parameter Modelica.SIunits.Density rhoair=1.19 "Density of the air"
            annotation(Dialog(tab="Room air"));
          parameter Modelica.SIunits.SpecificHeatCapacity cair=1007
            "Heat capacity of the air"
            annotation(Dialog(tab="Room air"));
          parameter Modelica.SIunits.Emissivity epsi=0.95
            "Emissivity of the inner walls"
            annotation(Dialog(tab="Inner walls",enable = if withInnerwalls then true else false));
          parameter Modelica.SIunits.Emissivity epso=0.95
            "Emissivity of the outer walls"
            annotation(Dialog(tab="Outer walls",enable = if withOuterwalls then true else false));

          Components.DryAir.Airload airload(
            V=Vair,
            rho=rhoair,
            c=cair) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=0,
                origin={2,2})));
          Utilities.HeatTransfer.HeatConv conv_innerwall(A=Ai, alpha=alphaiwi) if
                                                                                withInnerwalls
            annotation (Placement(transformation(extent={{28,-10},{48,10}})));

          Building.LowOrder.BaseClasses.SimpleOuterWall outerwall(
            RRest=RRest,
            R1=R1o,
            C1=C1o,
            T0=T0all) if withOuterwalls annotation (Placement(
                transformation(extent={{-70,-10},{-50,10}})));
          Building.LowOrder.BaseClasses.SimpleInnerWall innerwall(
            R1=R1i,
            C1=C1i,
            T0=T0all) if withInnerwalls annotation (Placement(
                transformation(extent={{56,-10},{76,10}})));

          Utilities.HeatTransfer.HeatConv conv_outerwall_innerside(A=Ao, alpha=
                alphaowi) if withOuterwalls
            annotation (Placement(transformation(extent={{-24,-10},{-44,10}})));

          Utilities.HeatTransfer.HeatToStar rad_outerwall_innerside(eps=
                epso, A=Ao) if withOuterwalls annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-46,22})));
          Utilities.HeatTransfer.HeatToStar rad_innerwall(A=Ai, eps=epsi) if         withInnerwalls
            annotation (Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=270,
                origin={52,22})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a innerLoadskonv(T(
              nominal=273.15 + 22,
              min=273.15 - 30,
              max=273.15 + 60)) annotation (Placement(transformation(extent={{-4,-100},
                    {16,-80}}), iconTransformation(extent={{-28,-100},{12,-60}})));
          Components.DryAir.VarAirExchange airexchange(
            V=Vair,
            c=cair,
            rho=rhoair) annotation (Placement(transformation(extent={{-44,-40},
                    {-24,-20}})));
          Modelica.Blocks.Interfaces.RealInput InfiltrationVentilationRate
                                                            annotation (Placement(
                transformation(
                extent={{20,-20},{-20,20}},
                rotation=270,
                origin={-40,-100}), iconTransformation(
                extent={{20,-20},{-20,20}},
                rotation=270,
                origin={-50,-80})));
        protected
          Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
            outdoorairtemp1 annotation (Placement(transformation(extent={{-74,-64},
                    {-54,-44}})));
        public
          Modelica.Blocks.Interfaces.RealInput outdoorairtemp
            annotation (Placement(transformation(extent={{-120,-82},{-80,-42}}),
                iconTransformation(extent={{-100,-28},{-60,-68}})));
          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a equivalentoutdoortemp if
            withOuterwalls
            annotation (Placement(transformation(extent={{-110,-20},{-70,20}}),
                iconTransformation(extent={{-100,-16},{-60,24}})));
          Utilities.Interfaces.Star innerLoadsrad annotation (Placement(
                transformation(extent={{70,-100},{90,-80}}),
                iconTransformation(extent={{54,-102},{100,-58}})));
          Utilities.HeatTransfer.SolarRadToHeat conv_window_rad(coeff=g, A=
                Aw) if                                                               withWindows and withOuterwalls
            annotation (Placement(transformation(extent={{-46,74},{-26,94}},
                  rotation=0)));
          Utilities.Interfaces.SolarRad_in Rad_In if      withWindows and withOuterwalls
            annotation (Placement(transformation(extent={{-102,60},{-82,80}},
                  rotation=0), iconTransformation(extent={{-102,34},{-60,74}})));

          Building.LowOrder.BaseClasses.SolarRadMultiplier rad_split_rad(x=
                1 - splitfac) if
                             withWindows and withOuterwalls annotation (
              Placement(transformation(extent={{-72,72},{-52,92}})));
          Building.LowOrder.BaseClasses.SolarRadMultiplier rad_split_conv(x=
               splitfac) if
               withWindows and withOuterwalls annotation (Placement(
                transformation(extent={{-72,48},{-52,68}})));
          Utilities.HeatTransfer.SolarRadToHeat conv_window_conv(A=Aw,
              coeff=g) if                                                             withWindows and withOuterwalls
            annotation (Placement(transformation(extent={{-46,50},{-26,70}},
                  rotation=0)));
          Utilities.HeatTransfer.HeatToStar rad_window(A=Aw, eps=epsw) if         withWindows and withOuterwalls
            annotation (Placement(transformation(extent={{-20,72},{0,92}})));

          Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a surfaceCooling(T(
              nominal=273.15 + 22,
              min=273.15 - 30,
              max=273.15 + 60)) annotation (Placement(transformation(extent={{40,-100},
                    {60,-80}}), iconTransformation(extent={{16,-100},{56,-60}})));
        initial equation
          if abs(Aw) < 0.00001 and withWindows then
            Modelica.Utilities.Streams.print("WARNING!:in ReducedModel, withWindows is true (windows existent), but the area of the windows Aw is zero (or nearly zero). This might cause an error.");
          end if;
          if abs(Ao) < 0.00001 and withOuterwalls then
            Modelica.Utilities.Streams.print("WARNING!:in ReducedModel,withWindows is true (windows existent), but the area of the windows Aw is zero (or nearly zero). This might cause an error.");
          end if;
          if abs(Ai) < 0.00001 and withInnerwalls then
            Modelica.Utilities.Streams.print("WARNING!:in ReducedModel,withWindows is true (windows existent), but the area of the windows Aw is zero (or nearly zero). This might cause an error.");
          end if;

        equation
          if withWindows and withOuterwalls then
            connect(conv_window_rad.heatPort, rad_window.Therm) annotation (Line(
                points={{-27,82},{-19.2,82}},
                color={191,0,0},
                smooth=Smooth.None));
            if withOuterwalls then
            else
              assert(withOuterwalls,"There must be outer walls, windows have to be counted too!");
            end if;
            if withInnerwalls then
            end if;
          end if;

          if withOuterwalls then
            connect(equivalentoutdoortemp, outerwall.port_a)  annotation (Line(
              points={{-90,0},{-80,0},{-80,-0.909091},{-70,-0.909091}},
              color={191,0,0},
              smooth=Smooth.None));
            connect(outerwall.port_b, rad_outerwall_innerside.Therm)
                                                                 annotation (Line(
              points={{-50,-0.909091},{-46,-0.909091},{-46,12.8}},
              color={191,0,0},
              smooth=Smooth.None));
            connect(outerwall.port_b,conv_outerwall_innerside.port_b)
                                                             annotation (Line(
              points={{-50,-0.909091},{-46.5,-0.909091},{-46.5,0},{-44,0}},
              color={191,0,0},
              smooth=Smooth.None));
            connect(conv_outerwall_innerside.port_a, airload.port)
                                                         annotation (Line(
              points={{-24,0},{-24,0},{-7,0}},
              color={191,0,0},
              smooth=Smooth.None));
            if withInnerwalls then
            else
            end if;
          end if;

          if withInnerwalls then
            connect(innerwall.port_a,conv_innerwall.port_b)
                                                          annotation (Line(
              points={{56,-0.909091},{51.5,-0.909091},{51.5,0},{48,0}},
              color={191,0,0},
              smooth=Smooth.None));
            connect(innerLoadsrad, rad_innerwall.Star)      annotation (Line(
              points={{80,-90},{80,54},{10,54},{10,40},{52,40},{52,31.1}},
              color={95,95,95},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          end if;

          connect(outdoorairtemp1.T, outdoorairtemp) annotation (Line(
              points={{-76,-54},{-88,-54},{-88,-62},{-100,-62}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(airexchange.port_b, airload.port)                  annotation (
              Line(
              points={{-24,-30},{-16,-30},{-16,0},{-7,0}},
              color={191,0,0},
              smooth=Smooth.None));

          connect(innerLoadskonv, airload.port) annotation (Line(
              points={{6,-90},{6,-30},{-16,-30},{-16,0},{-7,0}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(airload.port,conv_innerwall.port_a)  annotation (Line(
              points={{-7,0},{-16,0},{-16,-30},{20,-30},{20,0},{28,0}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(rad_innerwall.Therm, innerwall.port_a) annotation (Line(
              points={{52,12.8},{52,-0.909091},{56,-0.909091}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(rad_outerwall_innerside.Star, innerLoadsrad) annotation (Line(
              points={{-46,31.1},{-46,40},{10,40},{10,54},{80,54},{80,-90}},
              color={95,95,95},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          connect(rad_window.Star, innerLoadsrad) annotation (Line(
              points={{-0.9,82},{10,82},{10,54},{80,54},{80,-90}},
              color={95,95,95},
              pattern=LinePattern.None,
              smooth=Smooth.None));
          connect(conv_window_conv.heatPort, airload.port) annotation (Line(
              points={{-27,58},{-16,58},{-16,0},{-7,0}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(outdoorairtemp1.port, airexchange.port_a) annotation (Line(
              points={{-54,-54},{-78,-54},{-78,-30},{-44,-30}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(InfiltrationVentilationRate, airexchange.InPort1) annotation (Line(
              points={{-40,-100},{-40,-60},{-50,-60},{-50,-36.4},{-43,-36.4}},
              color={0,0,127},
              smooth=Smooth.None));
          connect(surfaceCooling,conv_innerwall.port_b)  annotation (Line(
              points={{50,-90},{50,0},{48,0}},
              color={191,0,0},
              smooth=Smooth.None));
          connect(Rad_In, rad_split_rad.solarRad_in) annotation (Line(
              points={{-92,70},{-82,70},{-82,82},{-71,82}},
              color={255,128,0},
              smooth=Smooth.None));
          connect(rad_split_conv.solarRad_in, Rad_In) annotation (Line(
              points={{-71,58},{-78,58},{-78,70},{-92,70}},
              color={255,128,0},
              smooth=Smooth.None));
          connect(rad_split_conv.solarRad_out, conv_window_conv.solarRad_in)
            annotation (Line(
              points={{-53,58},{-46.1,58}},
              color={255,128,0},
              smooth=Smooth.None));
          connect(rad_split_rad.solarRad_out, conv_window_rad.solarRad_in)
            annotation (Line(
              points={{-53,82},{-46.1,82}},
              color={255,128,0},
              smooth=Smooth.None));
                                    annotation (Line(
              points={{50,-90},{-4,-90},{-4,-90},{50,-90}},
              color={191,0,0},
              smooth=Smooth.None),
                      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                    -100},{100,100}}),
                              graphics),
            experiment(StopTime=864000),
            experimentSetupOutput,
            Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                    100}}),
                 graphics={
                Rectangle(
                  extent={{-60,74},{100,-72}},
                  lineColor={135,135,135},
                  fillColor={135,135,135},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{14,38},{46,12}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  lineThickness=1),
                Rectangle(
                  extent={{14,12},{46,-14}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  lineThickness=1),
                Rectangle(
                  extent={{-18,12},{14,-14}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  lineThickness=1),
                Rectangle(
                  extent={{-18,38},{14,12}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  lineThickness=1)}),
            Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<ul>
<li>ReducedOrderModel is a simple component to compute the air temperature, heating load, etc. for a thermal zone. The zone is simplified to one outer wall, one inner wall and one air node. It is build out of standard components and <a href=\"AixLib.Building.LowOrder.BaseClasses.SimpleOuterWall\">SimpleOuterWall</a> and <a href=\"AixLib.Building.LowOrder.BaseClasses.SimpleInnerWall\">SimpleInnerWall</a>.</li>
<li>The simplifications are based on the VDI 6007, which describes the thermal behaviour of a thermal zone with the equations for an electric circuit, hence they are equal. The heat transfer is described with resistances and the heat storage with capacitances.</li>
<li>The resolution of the model is very rough (only one air node), so the model is primarly thought for computing the air temperature of the room and with that, the heating and cooling load. It is more a heat load generator than a full building model. It is thought mainly for city district simulations, in which a lot of buildings has to be taken into account and the specific cirumstances in one building can be neglected.</li>
<li>Inputs: The model needs the outdoor air temperature and the Infiltration/VentilationRate for the Ventilation, the equivalent outdoor temperature (see <a href=\"AixLib.Building.LowOrder.BaseClasses.EqAirTemp\">EqAirTemp</a>) for the heat conductance through the outer walls and the solar radiation through the windows. There are two ports, one thermal, one star, for inner loads, heating etc. . </li>
<li>Parameters: Inner walls: R and C for the heat conductance and storage in the wall, A, alpha and epsilon for the heat transfer. Outer walls: Similar to inner walls, but with two R&apos;s, as there is also a conductance through the walls. Windows: g, A, epsilon and a splitfac. Please see VDI 6007 for computing the R&apos;s and C&apos;s.</li>
</ul>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars5.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The concept is described in VDI 6007. All outer walls and inner walls (including the windows) are merged together to one wall respectively. The inner walls are used as heat storages only, there is no heat transfer out of the zone (adiabate). This assumption is valid as long as the walls are in the zone or touch zones with a similar temperature. All walls, which touch other thermal zones are put together in the outer walls, which have an heat transfer with <a href=\"AixLib.Building.LowOrder.BaseClasses.EqAirTemp\">EqAirTemp</a>.</p>
<p>The two different &QUOT;wall types&QUOT; are connected through a convective heat circuit and a star circuit (different as in VDI 6007). As the air node can only react to convective heat, it is integrated in the convectice heat circuit. To add miscellaneous other heat sources/sinks (inner loads, heating) to the circiuts, there is one heat port to the convective circuit and one star port to the star circuit.</p>
<p>The last influence is the solar radiation through the windows. The heat transfer through the windows is considered in the outer walls. The beam is considered in the star circuit. There is a bypass from the beam to the convective circuit implemented, as a part of the beam is sometimes considered directly as convective heat.</p>
<p><br><b><font style=\"color: #008000; \">References</font></b></p>
<ul>
<li>German Association of Engineers: Guideline VDI 6007-1, March 2012: Calculation of transient thermal response of rooms and buildings - Modelling of rooms.</li>
<li>Lauster, M.; Teichmann, J.; Fuchs, M.; Streblow, R.; Mueller, D. (2014): Low order thermal network models for dynamic simulations of buildings on city district scale. In: Building and Environment 73, p. 223&ndash;231. DOI: <a href=\"http://dx.doi.org/10.1016/j.buildenv.2013.12.016\">10.1016/j.buildenv.2013.12.016</a></p>.</li>
</ul>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p>See <a href=\"AixLib.Building.LowOrder.Validation\">Vadliation</a> for some results. </p>
</html>",         revisions="<html>
<p><ul>
<li><i>January 2012,&nbsp;</i> by Moritz Lauster:<br/>Implemented.</li>
<li><i>Febraury 2014</i>, by Moritz Lauster: Reduced model with cooling ceeling</li>
</ul></p>
</html>"));
        end ReducedOrderModel_surfaceCooling;
      end VDIComponents;
      annotation (
        conversion(noneFromVersion="", noneFromVersion="1"));
    end VDI6007;

    annotation (Icon(graphics={
          Rectangle(
            lineColor={200,200,200},
            fillColor={248,248,248},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{-100,-100},{100,100}},
            radius=25.0),
          Rectangle(
            lineColor={128,128,128},
            fillPattern=FillPattern.None,
            extent={{-100,-100},{100,100}},
            radius=25.0),
          Polygon(
            origin={8,14},
            lineColor={78,138,73},
            fillColor={78,138,73},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            points={{-58.0,46.0},{42.0,-14.0},{-58.0,-74.0},{-58.0,46.0}})}));
  end Validation;

  package Examples
    extends Modelica.Icons.ExamplesPackage;

    model LowOrderExample
      extends Modelica.Icons.Example;
      import AixLib;
      output Real TRoom;
      output Real heatDemand;
      output Real coolDemand;

      ThermalZone thermalZone(zoneParam=
            AixLib.DataBase.Buildings.OfficePassiveHouse.OPH_1_Meeting())
        annotation (Placement(transformation(extent={{-10,-12},{16,14}})));
      Components.Weather.Weather weather(
        fileName=
            "modelica://AixLib/Resources/WeatherData/TRY2010_12_Jahr_Modelica-Library.txt",
        Air_temp=true,
        Sky_rad=true,
        Ter_rad=true,
        Outopt=1)
        annotation (Placement(transformation(extent={{-60,42},{-30,62}})));

      Utilities.Sources.HeaterCooler.IdealHeaterCoolerVar1
        idealHeaterCoolerVar1_1
        annotation (Placement(transformation(extent={{-22,-52},{-2,-32}})));
      Modelica.Blocks.Sources.Constant infiltrationRate(k=1)
        annotation (Placement(transformation(extent={{-88,-32},{-74,-18}})));
      Modelica.Blocks.Sources.Constant infiltrationTemperature(k=288.15)
        annotation (Placement(transformation(extent={{-88,-10},{-74,4}})));
      Modelica.Blocks.Sources.CombiTimeTable internalGains(
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
        tableOnFile=true,
        tableName="UserProfiles",
        fileName=
            "modelica://AixLib/Resources/LowOrder_ExampleData/UserProfiles_18599_SIA_Besprechung_Sitzung_Seminar.txt",
        columns={2,3,4})
        annotation (Placement(transformation(extent={{14,-71},{28,-57}})));

      Modelica.Blocks.Sources.CombiTimeTable heatingCooling(
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
        tableName="UserProfilesHeat",
        fileName=
            "modelica://AixLib/Resources/LowOrder_ExampleData/UserProfilesHeatSimple.txt",
        columns={2,3},
        tableOnFile=false,
        table=[0,295.15,295.2; 3600,295.1,295.2; 7200,295.1,295.2; 10800,295.1,
            295.2; 14400,295.1,295.2; 18000,295.1,295.2; 21600,295.1,295.2;
            25200,300.1,300.2; 28800,300.1,300.2; 32400,300.1,300.2; 36000,
            300.1,300.2; 39600,300.1,300.2; 43200,300.1,300.2; 46800,300.1,
            300.2; 50400,300.1,300.2; 54000,300.1,300.2; 57600,300.1,300.2;
            61200,300.1,300.2; 64800,300.1,300.2; 68400,295.1,295.2; 72000,
            295.1,295.2; 75600,295.1,295.2; 79200,295.1,295.2; 82800,295.1,
            295.2; 86400,295.1,295.2])
        annotation (Placement(transformation(extent={{-56,-75},{-42,-61}})));

    equation
      TRoom=thermalZone.thermalZonePhysics.reducedOrderModel.airload.T;
      heatDemand=idealHeaterCoolerVar1_1.heatMeter.q_kwh;
      coolDemand=idealHeaterCoolerVar1_1.coolMeter.q_kwh;
      connect(weather.SolarRadiation_OrientedSurfaces, thermalZone.solarRad_in)
        annotation (Line(
          points={{-52.8,41},{-52.8,8.8},{-7.4,8.8}},
          color={255,128,0},
          smooth=Smooth.None));
      connect(idealHeaterCoolerVar1_1.HeatCoolRoom, thermalZone.internalGainsConv)
        annotation (Line(
          points={{-3,-42},{3,-42},{3,-10.7}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(infiltrationRate.y, thermalZone.infiltrationRate) annotation (
          Line(
          points={{-73.3,-25},{-2.2,-25},{-2.2,-10.44}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(infiltrationTemperature.y, thermalZone.infiltrationTemperature)
        annotation (Line(
          points={{-73.3,-3},{-40.65,-3},{-40.65,-4.07},{-6.75,-4.07}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(weather.WeatherDataVector, thermalZone.weather) annotation (Line(
          points={{-45.1,41},{-45.1,1},{-6.62,1}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(internalGains.y, thermalZone.internalGains) annotation (Line(
          points={{28.7,-64},{34,-64},{34,-34},{13.4,-34},{13.4,-10.44}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(heatingCooling.y[1], idealHeaterCoolerVar1_1.soll_heat)
        annotation (Line(
          points={{-41.3,-68},{-9,-68},{-9,-46.8}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(heatingCooling.y[2], idealHeaterCoolerVar1_1.soll_cool)
        annotation (Line(
          points={{-41.3,-68},{-16.8,-68},{-16.8,-46.8}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics), Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Example for setting up a simulation for a thermal zone.</p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>Calculation of room temperatures and heating and cooling demands.</p>
</html>",     revisions="<html>
<ul>
<li><i>June 24, 2014  </i>by Moritz Lauster:<br>Implemented</li>
</ul>
</html>"),
        experiment(StopTime=3.1536e+007, Interval=3600),
        __Dymola_experimentSetupOutput);
    end LowOrderExample;
  end Examples;
  annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Package of Low Order Models for thermal building simulations.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars4.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The Low Order library provides low order models for thermal building simulation using a bundle of simplifications. One major question is the number of capacitances used to discretize thermal masses and to describe heat storage and transfer effects. This number defines the order of the model. Further simplifications are made for the consideration of long-wave radiation exchange, outdoor as well as indoor radiation exchange.</p>
<p>Most of the models in this package base on the German Guideline VDI 6007, though some changes have been applied, especially regarding long-wave radiation exchange. All models have been validated using test cases given in VDI 6007 (see <a href=\"Validation\">Validation</a>) and ASHRAE 140.</p>
<p><a href=\"ThermalZone\">Thermal Zone</a> serves as a ready-to-use model and represents one thermal zone that can be connected to external loads, weather and variable internal gains or sinks, radiative as well as convective. It calculates the indoor air temperature and is usually connectd to heating and cooling devices that calculate heat and cool demands. It is thus some kind of heating and cooling load generator. This model has been developed in the context of city district simulations and thus extensively tested for this purpose. Nevertheless, it has also been applied in different simulations of single buildings for e.g. control strategy optimization. <a href=\"ThermalZone\">Thermal Zone</a> uses all sub-models given in <a href=\"BaseClasses\">BaseClasses</a> with <a href=\"BaseClasses.ThermalZonePhysics\">Thermal Zone Physics</a>, <a href=\"BaseClasses.EqAirtEmp\">EqAirTemp</a> and <a href=\"BaseClasses.ReducedOrderModel\">Reduced Order Model</a> being the main sub-models.</p>
<p>For an easy-to-use parameterization of <a href=\"ThermalZone\">Thermal Zone</a>, all parameters have been bundled in one <a href=\"AixLib.DataBase.Buildings.ZoneBaseRecord\">ZoneBaseRecord</a>. To simulate a specific building, calculate and collect all parameters and define a new record according to your building.</p>
<h4><span style=\"color:#008000\">References</span></h4>
<ul>
<li>German Association of Engineers: Guideline VDI 6007-1, March 2012: Calculation of transient thermal response of rooms and buildings - Modelling of rooms.</li>
<li>Lauster, M.; Teichmann, J.; Fuchs, M.; Streblow, R.; Mueller, D. (2014): Low order thermal network models for dynamic simulations of buildings on city district scale. In: Building and Environment 73, p. 223&ndash;231. DOI: <a href=\"http://dx.doi.org/10.1016/j.buildenv.2013.12.016\">10.1016/j.buildenv.2013.12.016</a>.</li>
<li>Lauster, Moritz; Remmen, Peter; Fuchs, Marcus; Teichmann, Jens; Streblow, Rita; M&uuml;ller, Dirk (2014): Modelling long-wave radiation heat exchange for thermal network building simulations at urban scale using Modelica. In: the 10th International Modelica Conference, March 10-12, 2014, Lund, Sweden, March 10-12, 2014: Link&ouml;ping University Electronic Press (Link&ouml;ping Electronic Conference Proceedings), p. 125&ndash;133. DOI: <a href=\"http://dx.doi.org/10.3384/ECP14096125\">10.3384/ECP14096125</a>.</li>
<li>Lauster M, Constantin A, Fuchs M, Streblow R, M&uuml;ller D. Comparison of two Standard Simplified Thermal Building Models. In: Proceedings CISBAT Conference; 2013.</li>
<li>Lauster, M., Fuchs, M., Teichmann, J., Streblow, R., and M&uuml;ller, D. 2013. Energy Simulation of a Research Campus with Typical Building Setups. In Proceedings Building Simulation Conference, 769&ndash;775.</li>
<li>Teichmann, J., Lauster, M., Fuchs, M., Streblow, R., and M&uuml;ller, D. 2013. Validation of a Simplified Building Model used for City District Simulation. In Proceedings Building Simulation Conference, 2807&ndash;2814.</li>
<li>Fuchs, M., Dixius, T., Teichmann, J., Lauster, M., Streblow, R., and M&uuml;ller, D. 2013. Evaluation of Interactions between Buildings and District Heating Networks. In Proceedings Building Simulation Conference, 96&ndash;103.</li>
</ul>
</html>", revisions="<html>
<p><b>2014-06-24: Version 1.0</b>: by Moritz Lauster</p>
<p><ul>
<li>Added documentation for all models and examples</li>
<li>Renaming according to the MSL naming conventions</li>
<li>Uses new MSL comform models from Building</li>
</ul></p>
<p><b>2014-05-19: Version 0.9</b>: by Moritz Lauster</p>
<p><ul>
<li>Collected existing models and libraries and created LowOrder-library</li>
<li>Inserted Vadliation package</li>
</html>"));
end LowOrder;
