within AixLib.Systems.EONERC_Testhall.Test;
model CID
  Fluid.Sources.Boundary_pT ret_water(
    redeclare package Medium = AixLib.Media.Water,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{-38,-60},{-24,-46}})));
  Fluid.Sources.Boundary_pT sup_water(
    redeclare package Medium = AixLib.Media.Water,
    p=172000,
    use_T_in=false,
    nPorts=1) annotation (Placement(transformation(extent={{8,-60},{-6,-46}})));
  Fluid.Sources.Boundary_pT sup_air(
    redeclare package Medium = AixLib.Media.Air,
    p=102420,
    use_T_in=false,
    nPorts=1) annotation (Placement(transformation(extent={{54,-42},{40,-28}})));
  Fluid.Sources.Boundary_pT ret_air(
    redeclare package Medium = AixLib.Media.Air,
    use_T_in=false,
    nPorts=1) annotation (Placement(transformation(extent={{-36,28},{-22,42}})));
  BaseClass.CID.CID_ConsumerAir_and_Water cID_ConsumerAir_and_Water
    annotation (Placement(transformation(extent={{-42,-14},{-22,6}})));
equation
  connect(cID_ConsumerAir_and_Water.cid_rl_air, ret_air.ports[1]) annotation (
      Line(points={{-22.2,1},{-16,1},{-16,35},{-22,35}}, color={0,127,255}));
  connect(cID_ConsumerAir_and_Water.cid_vl_air, sup_air.ports[1]) annotation (
      Line(points={{-22.2,-8.4},{34,-8.4},{34,-35},{40,-35}}, color={0,127,255}));
  connect(cID_ConsumerAir_and_Water.cid_rl_water, ret_water.ports[1])
    annotation (Line(points={{-29.6,-13.8},{-29.6,-53},{-24,-53}}, color={0,127,
          255}));
  connect(cID_ConsumerAir_and_Water.cid_vl_water, sup_water.ports[1])
    annotation (Line(points={{-33.2,-13.8},{-33.2,-53},{-6,-53}}, color={0,127,
          255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=100000, __Dymola_Algorithm="Dassl"));
end CID;
