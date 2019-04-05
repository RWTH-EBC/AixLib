within AixLib.ThermalZones.ReducedOrder.ThermalZone;
model ThermalZoneMoistAir "Thermal zone containing moisture balance"
  extends ThermalZone(
    redeclare replaceable Utilities.Sources.InternalGains.Humans.HumanTotalHeat_VDI2078 humanSenHea,
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
equation
  connect(humanSenHea.MoistGain, ROM.mWat_flow) annotation (Line(points={{83.6,
          -18},{90,-18},{90,-4},{34,-4},{34,35},{37,35}}, color={0,0,127}));
end ThermalZoneMoistAir;
