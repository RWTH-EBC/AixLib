within AixLib.ThermalZones.ReducedOrder.Multizone;
model MultizoneSimpleHRS "Multizone model"
  extends
    AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses.PartialMultizone;

  parameter Real pinchT=2;
  parameter Real etaHRS= 0.8;
  parameter Real shareVolume[numZones];

  Modelica.Blocks.Interfaces.RealInput ventTemp[numZones](
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC",
    min=0)
    "Ventilation and infiltration temperature"
    annotation (Placement(transformation(extent={{-120,-12},{-80,28}}),
        iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,0})));
  Modelica.Blocks.Interfaces.RealInput ventRate[numZones](final
    quantity="VolumeFlowRate", final unit="1/h")
    "Ventilation and infiltration rate"
    annotation (Placement(transformation(extent={{-120,-40},{-80,0}}),
        iconTransformation(extent={{-100,-36},{-80,-16}})));

  BaseClasses.SimpleHRS simpleHRS(
    pinchT=pinchT,
    etaHRS=etaHRS,
    nZones=numZones,
    shareVolume=shareVolume,) if ASurTot > 0 or VAir > 0
    annotation (Placement(transformation(extent={{-56,46},{-36,66}})));
  Utilities.Psychrometrics.MixedTemperature mixedTemperature[numZones] if ASurTot > 0 or VAir > 0
    annotation (Placement(transformation(extent={{-8,38},{12,58}})));
  Modelica.Blocks.Interfaces.RealInput ventHRS[numZones](final quantity="VolumeFlowRate",
      final unit="1/h") "Ventilation with HRS" annotation (Placement(
        transformation(extent={{-120,20},{-80,60}}), iconTransformation(extent={
            {-100,-36},{-80,-16}})));
  Modelica.Blocks.Math.Add addVent[numZones] annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={44,20})));
equation

  connect(ventTemp, simpleHRS.Tair) annotation (Line(points={{-100,8},{-70,8},{-70,
          63},{-56,63}}, color={0,0,127}));
  connect(mixedTemperature.mixedTemperatureOut, zone.ventTemp) annotation (Line(
        points={{12,48},{16,48},{16,50},{20,50},{20,61.505},{35.27,61.505}},
        color={0,0,127}));
  connect(simpleHRS.Tinlet, mixedTemperature.temperature_flow1) annotation (
      Line(points={{-34.5,55.9},{-15.25,55.9},{-15.25,55.8},{-7.6,55.8}}, color=
         {0,0,127}));
  connect(ventTemp, mixedTemperature.temperature_flow2) annotation (Line(points={{-100,8},
          {-26,8},{-26,46},{-7.6,46}},          color={0,0,127}));
  connect(zone.TAir, simpleHRS.Tzone) annotation (Line(points={{82.1,81.8},{90,81.8},
          {90,98},{-78,98},{-78,55},{-56,55}}, color={0,0,127}));
  connect(ventRate, mixedTemperature.flowRate_flow2) annotation (Line(points={{-100,
          -20},{-20,-20},{-20,41},{-7.6,41}}, color={0,0,127}));
  connect(mixedTemperature.flowRate_flow1, ventHRS) annotation (Line(points={{-7.6,
          51},{-28.8,51},{-28.8,40},{-100,40}}, color={0,0,127}));
  connect(ventRate, addVent.u2)
    annotation (Line(points={{-100,-20},{50,-20},{50,8}}, color={0,0,127}));
  connect(ventHRS, addVent.u1) annotation (Line(points={{-100,40},{-28,40},{-28,
          -12},{38,-12},{38,8}}, color={0,0,127}));
  connect(addVent.y, zone.ventRate) annotation (Line(points={{44,31},{44,42},{44,
          52.28},{44.3,52.28}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})), Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}})),
    Documentation(revisions="<html>
<ul>
  <li>
  September 27, 2016, by Moritz Lauster:<br/>
  Reimplementation based on Annex60 and AixLib models.
  </li>
  <li>
  June 22, 2015, by Moritz Lauster:<br/>
  First implementation.
  </li>
</ul>
</html>",
        info="<html>
<p>This is a ready-to-use multizone model with a variable number of thermal zones. It defines connectors and a replaceable vector of <a href=\"AixLib.ThermalZones.ReducedOrder.ThermalZone\">AixLib.ThermalZones.ReducedOrder.ThermalZone</a> models. Most connectors are conditional to allow conditional modifications according to parameters or to pass-through conditional removements in <a href=\"AixLib.ThermalZones.ReducedOrder.ThermalZone\">AixLib.ThermalZones.ReducedOrder.ThermalZone</a> and subsequently in <a href=\"AixLib.ThermalZones.ReducedOrder.RC.FourElements\">AixLib.ThermalZones.ReducedOrder.RC.FourElements</a>.</p>
<h4>Typical use and important parameters</h4>
<p>The model needs parameters describing general properties of the building (indoor air volume, net floor area, overall surface area) and a vector with length of number of zones containing <a href=\"AixLib.DataBase.ThermalZones.ZoneBaseRecord\">AixLib.DataBase.ThermalZones.ZoneBaseRecord</a> records to define zone properties. The user can redeclare the thermal zone model choosing from <a href=\"AixLib.ThermalZones.ReducedOrder.ThermalZone\">AixLib.ThermalZones.ReducedOrder.ThermalZone</a>. Further parameters for medium, initialization and dynamics originate from <a href=\"AixLib.Fluid.Interfaces.LumpedVolumeDeclarations\">AixLib.Fluid.Interfaces.LumpedVolumeDeclarations</a>. A typical use case is a simulation of a multizone building for district simulations where the model is connected via heat ports and fluid ports to a heating system. The multizone model serves as boundary condition for the heating system and calculates the building&apos;s reaction to external and internal heat sources. </p>
<h4>References</h4>
<p>For automatic generation of thermal zone and multizone models as well as for datasets, see <a href=\"https://github.com/RWTH-EBC/TEASER\">https://github.com/RWTH-EBC/TEASER</a></p>
<ul>
<li>German Association of Engineers: Guideline VDI 6007-1, March 2012: Calculation of transient thermal response of rooms and buildings - Modelling of rooms. </li>
<li>Lauster, M.; Teichmann, J.; Fuchs, M.; Streblow, R.; Mueller, D. (2014): Low order thermal network models for dynamic simulations of buildings on city district scale. In: Building and Environment 73, p. 223&ndash;231. DOI: <a href=\"http://dx.doi.org/10.1016/j.buildenv.2013.12.016\">10.1016/j.buildenv.2013.12.016</a>. </li>
</ul>
<h4>Examples</h4>
<p>See <a href=\"AixLib.ThermalZones.ReducedOrder.Examples.Multizone\">AixLib.ThermalZones.ReducedOrder.Examples.Multizone</a>.</p>
</html>"));
end MultizoneSimpleHRS;
