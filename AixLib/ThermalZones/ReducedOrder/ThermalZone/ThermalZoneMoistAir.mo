within AixLib.ThermalZones.ReducedOrder.ThermalZone;
model ThermalZoneMoistAir "Thermal zone containing moisture balance"
  extends ThermalZone(
    redeclare final Utilities.Sources.InternalGains.Humans.HumanTotalHeat_VDI2078 humanSenHea,
    ROM(redeclare Fluid.MixingVolumes.MixingVolumeMoistAir volAir(
      redeclare final package Medium = Medium,
      final nPorts=nPorts,
      m_flow_nominal=ROM.VAir*6/3600*1.2,
      final V=ROM.VAir,
      final energyDynamics=ROM.energyDynamics,
      final massDynamics=ROM.massDynamics,
      final p_start=ROM.p_start,
      final T_start=ROM.T_start,
      final X_start=ROM.X_start,
      final C_start=ROM.C_start,
      final C_nominal=ROM.C_nominal,
      final mSenFac=ROM.mSenFac,
      final use_C_flow=false),
    final use_moisture_balance=true));
  Modelica.Blocks.Interfaces.RealInput ventHum(
    final quantity="MassFraction",
    final unit="kg/kg",
    min=0) if ATot > 0 or zoneParam.VAir > 0
    "Ventilation and infiltration humidity" annotation (Placement(
        transformation(extent={{-120,-90},{-80,-50}}), iconTransformation(
          extent={{-126,-80},{-100,-54}})));
  Modelica.Blocks.Math.MultiSum SumMoistFlow(nu=2) if ATot > 0
    annotation (Placement(transformation(extent={{16,-36},{28,-24}})));
  Modelica.Blocks.Interfaces.RealOutput X_w if ATot > 0
    "absolute humidity in thermal zone"
    annotation (Placement(transformation(extent={{100,64},{120,84}})));
  Utilities.Sources.InternalGains.Moisture.MoistureGains moistureGains if ATot > 0
    "internal moisture gains by plants, etc."
    annotation (Placement(transformation(extent={{18,-72},{38,-52}})));
equation
  connect(humanSenHea.MoistGain, SumMoistFlow.u[1]) annotation (Line(points={{83.6,
          -18},{88,-18},{88,-6},{48,-6},{48,-40},{10,-40},{10,-27.9},{16,-27.9}},
        color={0,0,127}));
  connect(SumMoistFlow.y, ROM.mWat_flow) annotation (Line(points={{29.02,-30},{34,
          -30},{34,35},{37,35}}, color={0,0,127}));
  connect(ROM.X_w, X_w) annotation (Line(points={{87,34},{92,34},{92,74},{110,74}},
        color={0,0,127}));
  connect(moistureGains.MoistGain, SumMoistFlow.u[2]) annotation (Line(points={{
          37.6,-58},{44,-58},{44,-40},{10,-40},{10,-32.1},{16,-32.1}}, color={0,
          0,127}));
  connect(moistureGains.ConvHeat, ROM.intGainsConv) annotation (Line(points={{37,
          -66.8},{52,-66.8},{52,-4},{92,-4},{92,50},{86,50}}, color={191,0,0}));
  connect(ROM.intGainsConv, moistureGains.TRoom) annotation (Line(points={{86,50},
          {90,50},{90,-4},{48,-4},{48,-48},{20,-48},{20,-53.6}}, color={191,0,0}));
  annotation (Documentation(revisions="<html>
<ul>
  <li>
  April, 2019, by Martin Kremer:<br/>
  First implementation.
  </li>
 </ul>
</html>", info="<html>
<p><b><font style=\"color: #008000; \">Overview</font></b> </p>
<p>This model enhances the existing thermal zone model considering moisture balance in the zone. Moisture is considered in internal gains. </p>
<p>Comprehensive ready-to-use model for thermal zones, combining caclulation core, handling of solar radiation and internal gains. Core model is a <a href=\"AixLib.ThermalZones.ReducedOrder.RC.FourElements\">AixLib.ThermalZones.ReducedOrder.RC.FourElements</a> model. Conditional removements of the core model are passed-through and related models on thermal zone level are as well conditional. All models for solar radiation are part of Annex60 library. Internal gains are part of AixLib.</p>
<h4>Typical use and important parameters</h4>
<p>All parameters are collected in one <a href=\"AixLib.DataBase.ThermalZones.ZoneBaseRecord\">AixLib.DataBase.ThermalZones.ZoneBaseRecord</a> record. Further parameters for medium, initialization and dynamics originate from <a href=\"AixLib.Fluid.Interfaces.LumpedVolumeDeclarations\">AixLib.Fluid.Interfaces.LumpedVolumeDeclarations</a>. A typical use case is a single thermal zone connected via heat ports and fluid ports to a heating system. The thermal zone model serves as boundary condition for the heating system and calculates the room&apos;s reaction to external and internal heat sources. The model is used as thermal zone core model in <a href=\"AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses.PartialMultizone\">AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses.PartialMultizone</a></p>
<p><b><font style=\"color: #008000; \">Assumptions</font></b> </p>
<p> There is no moisture exchange through the walls or windows. Only moisture exchange is realized by the internal gains, through the fluid ports and over the ventilation moisture. This leads to a steady increase of moisture in the room, when there is no ventilation.</p>
<h4>References</h4>
<p>For automatic generation of thermal zone and multizone models as well as for datasets, see <a href=\"https://github.com/RWTH-EBC/TEASER\">https://github.com/RWTH-EBC/TEASER</a></p>
<ul>
<li>German Association of Engineers: Guideline VDI 6007-1, March 2012: Calculation of transient thermal response of rooms and buildings - Modelling of rooms. </li>
<li>Lauster, M.; Teichmann, J.; Fuchs, M.; Streblow, R.; Mueller, D. (2014): Low order thermal network models for dynamic simulations of buildings on city district scale. In: Building and Environment 73, p. 223&ndash;231. DOI: <a href=\"http://dx.doi.org/10.1016/j.buildenv.2013.12.016\">10.1016/j.buildenv.2013.12.016</a>. </li>
</ul>
<h4>Examples</h4>
<p>See <a href=\"AixLib.ThermalZones.ReducedOrder.Examples.ThermalZone\">AixLib.ThermalZones.ReducedOrder.Examples.ThermalZone</a>.</p>
</html>"));
end ThermalZoneMoistAir;
