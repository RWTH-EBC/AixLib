within AixLib.Building.LowOrder.BaseClasses.ReducedOrderModel;
model ReducedOrderModelEBCMod
  import AixLib;
  extends
    AixLib.Building.LowOrder.BaseClasses.ReducedOrderModel.PartialReducedOrderModel(
      heatConvOuterwall(A=Ao - Aw));

   parameter Modelica.SIunits.ThermalResistance RWin=0.017727777777
    "Resistor Window"
   annotation(Dialog(tab="Outer walls",group = "Windows",enable = if withWindows then true else false));
   parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaWin=3.16
    "Coefficient of convective heat transfer (Window)"
   annotation(Dialog(tab="Outer walls",group = "Windows",enable = if withWindows then true else false));
protected
  parameter Integer dimensionSplitter = if withInnerwalls then 2 else 1;
  parameter Real vectorSplitterWin[dimensionSplitter]= if withInnerwalls then {(Ao - Aw)/(Ao + Ai - Aw),(Ai)/(Ao + Ai - Aw)} else {(Ao - Aw)/(Ao + Ai - Aw)};
  parameter Real vectorSplitterLoads[dimensionSplitter]= if withInnerwalls then {(Ao)/(Ao + Ai),(Ai)/(Ao + Ai)} else {(Ao)/(Ao + Ai)};
public
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a equalAirTempWindow if withWindows
    annotation (Placement(transformation(extent={{-108,19},{-72,55}}),
        iconTransformation(extent={{-100,34},{-60,74}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResWindow(R=
        RWin) if withWindows annotation (Placement(transformation(extent={{-66,42},{-56,52}})));
  Utilities.HeatTransfer.HeatConv heatConvWinRes(alpha=alphaWin, A=Aw) if
                                                    withWindows
    annotation (Placement(transformation(extent={{-48,32},{-38,42}})));
  Utilities.HeatTransfer.HeatToStar heatToStarWinRes(A=Aw, eps=epsw) if
                                                        withWindows
    annotation (Placement(transformation(extent={{-48,46},{-38,56}})));
  Utilities.HeatTransfer.HeatToStar heatToStarOuterwall(A=Ao - Aw, eps=epso) if withOuterwalls
    annotation (Placement(transformation(extent={{-38,16},{-26,28}})));
  Utilities.HeatTransfer.HeatToStar heatToStarInnerwall(A=Ai, eps=epsi) if withInnerwalls
    annotation (Placement(transformation(extent={{52,16},{40,28}})));
  AixLib.Building.LowOrder.BaseClasses.ThermSplitter thermSplitterWin(dimension=
       dimensionSplitter, splitFactor=vectorSplitterWin)
    annotation (Placement(transformation(extent={{-14,80},{6,100}})));
  AixLib.Building.LowOrder.BaseClasses.ThermSplitter thermSplitterLoads(dimension=
       dimensionSplitter, splitFactor=vectorSplitterLoads) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={94,0})));

equation
  if withWindows and withOuterwalls then
  connect(equalAirTempWindow, thermalResWindow.port_a) annotation (Line(
      points={{-90,37},{-78,37},{-78,47},{-66,47}},
      color={191,0,0}));
  connect(thermalResWindow.port_b, heatToStarWinRes.Therm) annotation (Line(
      points={{-56,47},{-52,47},{-52,51},{-47.6,51}},
      color={191,0,0}));
  connect(thermalResWindow.port_b, heatConvWinRes.port_a) annotation (Line(
      points={{-56,47},{-52,47},{-52,37},{-48,37}},
      color={191,0,0}));
  connect(heatConvWinRes.port_b, airload.port) annotation (Line(
      points={{-38,37},{-7,37},{-7,0}},
      color={191,0,0}));
  end if;

  if withInnerwalls then
    connect(heatToStarInnerwall.Therm, innerwall.port_a) annotation (Line(
      points={{51.52,22},{56,22},{56,-0.909091}},
      color={191,0,0}));
  connect(heatToStarWinRes.Star, heatToStarInnerwall.Star) annotation (Line(
      points={{-38.45,51},{2,51},{2,22},{40.54,22}},
      color={95,95,95},
      pattern=LinePattern.Solid));
  connect(heatToStarOuterwall.Star, heatToStarInnerwall.Star) annotation (Line(
      points={{-26.54,22},{40.54,22}},
      color={95,95,95},
      pattern=LinePattern.Solid));
    connect(thermSplitterLoads.signalOutput[2], innerwall.port_a) annotation (
        Line(
        points={{94,10},{94,16},{56,16},{56,-0.909091}},
        color={191,0,0}));
    connect(thermSplitterWin.signalOutput[2], innerwall.port_a) annotation (
        Line(
        points={{6,90},{56,90},{56,-0.909091}},
        color={191,0,0}));
  end if;

  connect(heatToStarOuterwall.Therm, outerwall.port_b) annotation (Line(
      points={{-37.52,22},{-50,22},{-50,-0.909091}},
      color={191,0,0}));

  connect(internalGainsRad, thermSplitterLoads.signalInput) annotation (Line(
      points={{80,-90},{80,-26},{94,-26},{94,-10}},
      color={95,95,95},
      pattern=LinePattern.Solid));

  connect(thermSplitterLoads.signalOutput[1], outerwall.port_b) annotation (
      Line(
      points={{94,10},{94,30},{-50,30},{-50,-0.909091}},
      color={191,0,0}));

  connect(thermSplitterWin.signalOutput[1], outerwall.port_b) annotation (Line(
      points={{6,90},{6,30},{-50,30},{-50,-0.909091}},
      color={191,0,0}));
  connect(solarRadToHeatRad.port, thermSplitterWin.signalInput) annotation (
      Line(
      points={{-26,90},{-14,90}},
      color={191,0,0}));
  annotation (    Documentation(revisions="<html>
<ul>
<li><i>October 2014,&nbsp;</i> by Peter Remmen:<br/>Implemented.</li>
</ul>
</html>", info="<html>
<p>ReducedOrderModelEBCMod extends from partialReducedOrderModel. </p>
<p>As windows have nearly no capacity an additional resistance for heat transfer calculation through the window is implemented. </p>
<p>This class contains following additional components: </p>
<ul>
<li>additional Resistance for window, with additional equivalent air temperature for window</li>
<li>distribution of radiative heat transfer</li>
<li>longwave radiative heat transfer between inner and outer walls and windows</li>
<li>convective heat transfer for windows</li>
</ul>
<h4>Main equations</h4>
<p>The concept is described in VDI 6007. All equations can be found in VDI 6007 and &quot;Improving a Low Order Building Model for Urban Scale Applications&quot; </p>
<h4>Assumption and limitations</h4>
<p>This model will only work with <a href=\"AixLib.Building.LowOrder.BaseClasses.EqAirTemp.EqAirTempEBCMod\">EqAirTempEBCMod</a>The longwave radiative heat transfer between the building components is modeled according to Stefan-Boltzmann Law. </p>
<h4>Typical use and important parameters</h4>
<p>Resistance and coefficient of heat transfer for windows</p>
<h4>Options</h4>
<p>No additional options</p>
<h4>Validation</h4>
<p>The model is verified with the VDI 6007, see <a href=\"AixLib.Building.LowOrder.Validation.VDI6007\">Validation.VDI6007</a>. A validation with the use of the standard ASHRAE 140 is in progress </p>
<h4>Implementation</h4>
<h4>References</h4>
<ul>
<li>German Association of Engineers: Guideline VDI 6007-1, March 2012: Calculation of transient thermal response of rooms and buildings - Modelling of rooms.</li>
<li>Lauster, M.; Teichmann, J.; Fuchs, M.; Streblow, R.; Mueller, D. (2014): Low order thermal network models for dynamic simulations of buildings on city district scale. In: Building and Environment 73, p. 223&ndash;231. DOI: 10.1016/j.buildenv.2013.12.016.</li>
<li>Lauster, Moritz; Bruentjen, Mark-Alexander; Leppmann, Henning; Fuchs, Marcus; Teichmann, Jens; Streblow, Rita; Mueller, Dirk (2014): Improving a Low Order Building Model for Urban Scale Applications. In: Fifth German-Austrian IBPSA Conference, September 2014, Aachen, Germany, page 511-518</li>
</ul>
</html>"));
end ReducedOrderModelEBCMod;
