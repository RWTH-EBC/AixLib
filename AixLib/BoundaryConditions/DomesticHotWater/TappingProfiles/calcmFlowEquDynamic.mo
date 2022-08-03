within AixLib.BoundaryConditions.DomesticHotWater.TappingProfiles;
model calcmFlowEquDynamic "Dynamic way to calc m_flow_equivalent"
  extends BaseClasses.PartialcalcmFlowEqu;
  Modelica.Blocks.Continuous.Integrator
                            mDHWTapped
    annotation (Placement(transformation(extent={{-62,44},{-42,24}})));
equation
  connect(TIs, dTIs.u1) annotation (Line(points={{-120,0},{-76,0},{-76,0},{-44,0}},
        color={0,0,127}));
  connect(m_flow_in, mDHWTapped.u) annotation (Line(points={{-120,60},{-92,60},
          {-92,34},{-64,34}}, color={0,0,127}));
end calcmFlowEquDynamic;
