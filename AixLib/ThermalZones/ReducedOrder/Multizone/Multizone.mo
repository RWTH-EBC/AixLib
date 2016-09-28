within AixLib.ThermalZones.ReducedOrder.Multizone;
model Multizone
  "Multizone model"
  extends AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses.PartialMultizone;

  Modelica.Blocks.Interfaces.RealInput ventTemp[numZones](
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC",
    min=0)
    "Ventilation and infiltration temperature"
    annotation (Placement(
    transformation(extent={{-120,-12},{-80,28}}),iconTransformation(
    extent={{-10,-10},{10,10}},
    rotation=0,
    origin={-90,18})));
  Modelica.Blocks.Interfaces.RealInput ventRate[numZones](final
    quantity="VolumeFlowRate", final unit="1/h")
    "Ventilation and infiltration rate"
    annotation (Placement(transformation(
    extent={{-120,-40},{-80,0}}),  iconTransformation(extent={{-100,-20},
    {-80,0}})));

equation
  connect(zone.ventRate, ventRate) annotation (Line(points={{44.3,52.28},{44.3,
          52.28},{44.3,-20},{-100,-20}},
                                color={0,0,127}));
  connect(ventTemp, zone.ventTemp) annotation (Line(points={{-100,8},{-34,8},{
          -34,61.505},{35.27,61.505}},        color={0,0,127}));
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
end Multizone;
