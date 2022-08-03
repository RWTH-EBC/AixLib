within AixLib.BoundaryConditions.DomesticHotWater.TappingProfiles;
model calcmFlowEquStatic "Static way to calc m_flow_equivalent"
  extends BaseClasses.PartialcalcmFlowEqu;
  Modelica.Blocks.Sources.Constant constTSet(final k=TSetDHW)
    annotation (Placement(transformation(extent={{-82,-10},{-62,10}})));
equation
  connect(constTSet.y, dTIs.u1)
    annotation (Line(points={{-61,0},{-44,0}}, color={0,0,127}));
end calcmFlowEquStatic;
