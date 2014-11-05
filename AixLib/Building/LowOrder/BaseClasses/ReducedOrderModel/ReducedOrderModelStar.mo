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
<p>ReducedOrderModelStar extends from partialReducedOrderModel. </p>
<p>This class contains following additional components: </p>
<ul>
<li>longwave radiative heat transfer between inner and outer walls and windows</li>
</ul>
<h4>Main equations</h4>
<p>The concept is described in VDI 6007. All equations can be found in VDI 6007 and \"Low order thermal network models for dynamic simulations of buildings on city district scale\" </p>

<h4>Assumption and limitations</h4>
<p>The longwave radiative heat transfer between the building components is modeled according to Stefan-Boltzmann Law </p>
<h4>Typical use and important parameters</h4>
<p>No additional parameters</p>
<h4>Options</h4>
<p>No additional options</p>
<h4>Validation</h4>
<p>The model is verified with the VDI 6007, see <a href=\"AixLib.Building.LowOrder.Validation.VDI6007\">Validation.VDI6007</a>. A validation with the use of the standard ASHRAE 140 is in progress </p>
<h4>Implementation</h4>
<p> </p>
<h4>References</h4>
<ul>
<li>German Association of Engineers: Guideline VDI 6007-1, March 2012: Calculation of transient thermal response of rooms and buildings - Modelling of rooms.</li>
<li>Lauster, M.; Teichmann, J.; Fuchs, M.; Streblow, R.; Mueller, D. (2014): Low order thermal network models for dynamic simulations of buildings on city district scale. In: Building and Environment 73, p. 223&ndash;231. DOI: 10.1016/j.buildenv.2013.12.016.</li>
</ul>
</html>", revisions="<html>
<p><ul>
<li><i>October 2014,&nbsp;</i> by Peter Remmen:<br/>extended from partial Model</li>
</ul></p>
<p><ul>
<li><i>January 2012,&nbsp;</i> by Moritz Lauster:<br/>Implemented.</li>
</ul></p>

</html>"));
end ReducedOrderModelStar;
