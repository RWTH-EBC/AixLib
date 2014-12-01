within AixLib.Building.LowOrder.BaseClasses.ReducedOrderModel;
model ReducedOrderModelVDI
  extends ReducedOrderModel.partialReducedOrderModel;

parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaRad=5
    "Radiative Coefficient of heat transfer between inner and outer walls"
annotation(Dialog(tab="Inner walls",enable = if withInnerwalls then true else false));
protected
  parameter Integer dimension_help = if withInnerwalls then 2 else 1;
  parameter Real vector_help1[dimension_help]= if withInnerwalls then {(Ao - Aw)/(Ao + Ai - Aw),(Ai)/(Ao + Ai - Aw)} else {(Ao - Aw)/(Ao + Ai - Aw)};
  parameter Real vector_help2[dimension_help]= if withInnerwalls then {(Ao)/(Ao + Ai),(Ai)/(Ao + Ai)} else {(Ao)/(Ao + Ai)};

  SplitterThermPercentAir
    splitterThermPercentAir(ZoneFactor=vector_help1, dimension=dimension_help)
    annotation (Placement(transformation(extent={{-12,80},{8,100}})));
  SplitterThermPercentAir
    splitterThermPercentAir1(dimension=dimension_help, ZoneFactor=vector_help2)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={92,4})));
  Utilities.HeatTransfer.HeatConv radHeatTrans( alpha=alphaRad, A=Ao) if withInnerwalls
    annotation (Placement(transformation(extent={{0,10},{20,30}})));
equation

if withWindows and withOuterwalls then

  connect(solarRadToHeatWindowRad.heatPort, splitterThermPercentAir.signalInput)
    annotation (Line(
      points={{-27,90},{-12,90}},
      color={191,0,0},
      smooth=Smooth.None));
end if;

if withInnerwalls then
    connect(outerwall.port_b, radHeatTrans.port_a) annotation (Line(
      points={{-50,-0.909091},{-50,20},{0,20}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(radHeatTrans.port_b, innerwall.port_a) annotation (Line(
      points={{20,20},{56,20},{56,-0.909091}},
      color={191,0,0},
      smooth=Smooth.None));
end if;

  connect(splitterThermPercentAir1.signalInput, internalGainsRad) annotation (
      Line(
      points={{92,-6},{94,-6},{94,-66},{80,-66},{80,-90}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(splitterThermPercentAir1.signalOutput[2], innerwall.port_a)
    annotation (Line(
      points={{92,14},{92,16},{56,16},{56,-0.909091}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(splitterThermPercentAir1.signalOutput[1], outerwall.port_b)
    annotation (Line(
      points={{92,14},{92,32},{-50,32},{-50,-0.909091}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(splitterThermPercentAir.signalOutput[1], outerwall.port_b)
    annotation (Line(
      points={{8,90},{12,90},{12,32},{-50,32},{-50,-0.909091}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(splitterThermPercentAir.signalOutput[2], innerwall.port_a)
    annotation (Line(
      points={{8,90},{56,90},{56,-0.909091}},
      color={191,0,0},
      smooth=Smooth.None));

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Documentation(info="<html>
<p>ReducedOrderModelVDI extends from partialReducedOrderModel. </p>
<p>This class contains following additional components: </p>
<ul>
<li>constant longwave radiative heat transfer coefficient</li>
<li>distribution of radiative heat transfer</li>
</ul>
<h4>Main equations</h4>
<p>The concept is described in VDI 6007. All equations can be found in VDI 6007 </p>
<h4>Assumption and limitations</h4>
<p>The longwave radiative heat transfer between the building components is modeled with a constant coefficient (5W/m^2K. this is true for surface temperature around 20 degree celsius) </p>
<h4>Typical use and important parameters</h4>
<p>Radiative coefficient of heat transfer between inner and outer walls</p>
<h4>Options</h4>
<p>No additional options</p>
<h4>Validation</h4>
<p>The model is verified with the VDI 6007, see <a href=\"AixLib.Building.LowOrder.Validation.VDI6007\">Validation.VDI6007</a>. A validation with the use of the standard ASHRAE 140 is in progress </p>
<h4>Implementation</h4>
<h4>References</h4>
<ul>
<li>German Association of Engineers: Guideline VDI 6007-1, March 2012: Calculation of transient thermal response of rooms and buildings - Modelling of rooms.</li>
<li>Lauster, M.; Teichmann, J.; Fuchs, M.; Streblow, R.; Mueller, D. (2014): Low order thermal network models for dynamic simulations of buildings on city district scale. In: Building and Environment 73, p. 223&ndash;231. DOI: 10.1016/j.buildenv.2013.12.016.</li>
<li>Lauster, Moritz; Remmen, Peter; Fuchs, Marcus; Teichmann, Jens; Streblow, Rita; Mueller, Dirk (2014): Modelling long-wave radiation heat exchange for thermal network building simulations at urban scale using Modelica. In: the 10th International Modelica Conference, March 10-12, 2014, Lund, Sweden, March 10-12, 2014: Linkoeping University Electronic Press (Linkoeping Electronic Conference Proceedings), p. 125&ndash;133. DOI: <a href=\"http://dx.doi.org/10.3384/ECP14096125\">10.3384/ECP14096125</a>.</li>
</ul>
</html>", revisions="<html>
<p><ul>
<li><i>October 2014,&nbsp;</i> by Peter Remmen:<br/>Implemented.</li>
</ul></p>
</html>"));
end ReducedOrderModelVDI;
