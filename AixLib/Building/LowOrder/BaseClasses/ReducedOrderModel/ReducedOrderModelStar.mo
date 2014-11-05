within AixLib.Building.LowOrder.BaseClasses.ReducedOrderModel;
model ReducedOrderModelStar
  extends partialReducedOrderModel;
  Utilities.HeatTransfer.HeatToStar heatToStarWindow(A=Aw, eps=epsw) if withWindows
    annotation (Placement(transformation(extent={{-16,72},{4,92}})));
  Utilities.HeatTransfer.HeatToStar heatToStarOuterwall(A=Ao, eps=epso) if withOuterwalls
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-46,28})));
  Utilities.HeatTransfer.HeatToStar heatToStarInnerwall(A=Ai, eps=epsi) if withInnerwalls
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,28})));
equation
  if withWindows and withOuterwalls then
  connect(solarRadToHeatWindowRad.heatPort, heatToStarWindow.Therm) annotation (
     Line(
      points={{-27,90},{-22,90},{-22,82},{-15.2,82}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(heatToStarWindow.Star, internalGainsRad) annotation (Line(
      points={{3.1,82},{12,82},{12,45},{80,45},{80,-90}},
      color={95,95,95},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  end if;

  if withOuterwalls then
      connect(outerwall.port_b, heatToStarOuterwall.Therm) annotation (Line(
      points={{-50,-0.909091},{-46,-0.909091},{-46,18.8}},
      color={191,0,0},
      smooth=Smooth.None));

  connect(heatToStarOuterwall.Star, internalGainsRad) annotation (Line(
      points={{-46,37.1},{-14,37.1},{-14,37},{12,37},{12,45},{80,45},{80,-90}},
      color={95,95,95},
      pattern=LinePattern.None,
      smooth=Smooth.None));

  end if;

  if withInnerwalls then
      connect(heatToStarInnerwall.Star, internalGainsRad) annotation (Line(
      points={{50,37.1},{12,37.1},{12,45},{80,45},{80,-90}},
      color={95,95,95},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(heatToStarInnerwall.Therm, innerwall.port_a) annotation (Line(
      points={{50,18.8},{54,18.8},{54,-0.909091},{56,-0.909091}},
      color={191,0,0},
      smooth=Smooth.None));
  end if;

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<ul>
<li>ReducedOrderModel is a simple component to compute the air temperature, heating load, etc. for a thermal zone. The zone is simplified to one outer wall, one inner wall and one air node. It is build out of standard components and <a href=\"Cities.BuildingPhysics.Components.SimpleOuterWall\">SimpleOuterWall</a> and <a href=\"Cities.BuildingPhysics.Components.SimpleInnerWall\">SimpleInnerWall</a>.</li>
<li>The simplifications are based on the VDI 6007, which describes the thermal behaviour of a thermal zone with the equations for an electric circuit, hence they are equal. The heat transfer is described with resistances and the heat storage with capacitances.</li>
<li>The resolution of the model is very rough (only one air node), so the model is primarly thought for computing the air temperature of the room and with that, the heating and cooling load. It is more a heat load generator than a full building model. It is thought mainly for city district simulations, in which a lot of buildings has to be taken into account and the specific cirumstances in one building can be neglected.</li>
<li>Inputs: The model needs the outdoor air temperature and the Infiltration/VentilationRate for the Ventilation, the equivalent outdoor temperature (see <a href=\"Cities.BuildingPhysics.Components.EqAirTemp\">EqAirTemp</a>) for the heat conductance through the outer walls and the solar radiation through the windows. There are two ports, one thermal, one star, for inner loads, heating etc. . </li>
<li>Parameters: Inner walls: R and C for the heat conductance and storage in the wall, A, alpha and epsilon for the heat transfer. Outer walls: Similar to inner walls, but with two R&apos;s, as there is also a conductance through the walls. Windows: g, A, epsilon and a splitfac. Please see VDI 6007 for computing the R&apos;s and C&apos;s.</li>
</ul>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The concept is described in VDI 6007. All outer walls and inner walls (including the windows) are merged together to one wall respectively. The inner walls are used as heat storages only, there is no heat transfer out of the zone (adiabate). This assumption is valid as long as the walls are in the zone or touch zones with a similar temperature. All walls, which touch other thermal zones are put together in the outer walls, which have an heat transfer with <a href=\"Cities.BuildingPhysics.Components.EqAirTemp\">EqAirTemp</a>.</p>
<p>The two different &QUOT;wall types&QUOT; are connected through a convective heat circuit and a star circuit (different as in VDI 6007). As the air node can only react to convective heat, it is integrated in the convectice heat circuit. To add miscellaneous other heat sources/sinks (inner loads, heating) to the circiuts, there is one heat port to the convective circuit and one star port to the star circuit.</p>
<p>The last influence is the solar radiation through the windows. The heat transfer through the windows is considered in the outer walls. The beam is considered in the star circuit. There is a bypass from the beam to the convective circuit implemented, as a part of the beam is sometimes considered directly as convective heat.</p>
<p><br><b><font style=\"color: #008000; \">References</font></b></p>
<ul>
<li>German Association of Engineers: Guideline VDI 6007-1, March 2012: Calculation of transient thermal response of rooms and buildings - Modelling of rooms.</li>
<li>Lauster, M.; Teichmann, J.; Fuchs, M.; Streblow, R.; Mueller, D. (2014): Low order thermal network models for dynamic simulations of buildings on city district scale. In: Building and Environment 73, p. 223&ndash;231. DOI: 10.1016/j.buildenv.2013.12.016.</li>
</ul>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p>Some examples you can use to see a typical configuration and to create example output data can be found in <a href=\"Cities.BuildingPhysics.Examples\">Examples</a>.</p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p>See <a href=\"Cities.BuildingPhysics.Examples\">Examples</a> for some results. </p>
<h4><span style=\"color:#008000\">Main Author: </span></h4>
<p>Moritz Lauster</p>
<p>E.ON Energy Research Center</p>
<p>Institute for Energy Efficient Buildings and Indoor Climate</p>
<p>Mathieustr. 10</p>
<p>D-52074 Aachen</p>
<p>e-mail: <a href=\"mailto:moritz.lauster@eonerc.rwth-aachen.de\">moritz.lauster@eonerc.rwth-aachen.de</a></p>
</html>", revisions="<html>
<p><ul>
<li><i>October 2014,&nbsp;</i> by Peter Remmen:<br/>extended from partial Model</li>
</ul></p>
<p><ul>
<li><i>January 2012,&nbsp;</i> by Moritz Lauster:<br/>Implemented.</li>
</ul></p>

</html>"));
end ReducedOrderModelStar;
