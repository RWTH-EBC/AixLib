within AixLib.ThermalZones.ReducedOrder.ThermalZone.BaseClasses.Examples;
model StratifiedAirVolume
  "Test of the stratified air volume with supply air at the top and extract air at the bottom"
  extends Modelica.Icons.Example;

  package Medium = AixLib.Media.Air;

  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=3
    "Nominal mass flow rate";

  AixLib.ThermalZones.ReducedOrder.ThermalZone.BaseClasses.StratifiedAirVolume
    stratAir(
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=303.15,
    nLay=3,
    AFloor=552,
    hLay={0.6,1.4,12.9},
    nPorts=2,
    layPort={3,1},
    m_flow_nominal=m_flow_nominal) "Stratified air volume"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  AixLib.Fluid.Sources.MassFlowSource_T sou(
    redeclare package Medium = Medium,
    m_flow=m_flow_nominal,
    T=303.15,
    X={0.008,1 - 0.008},
    nPorts=1) "Supply air into the top layer"
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  AixLib.Fluid.Sources.Boundary_pT sin(redeclare package Medium = Medium,
      nPorts=1) "Extract air from the lowest layer"
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  Modelica.Blocks.Sources.Constant mEva(k=0.01)
    "Evaporation into the lowest layer"
    annotation (Placement(transformation(extent={{-90,70},{-70,90}})));
  Modelica.Blocks.Sources.Constant zero[2](each k=0)
    "No moisture source in the upper layers"
    annotation (Placement(transformation(extent={{-90,40},{-70,60}})));
  Modelica.Blocks.Routing.Multiplex3 mux "Water mass flow rates of the layers"
    annotation (Placement(transformation(extent={{-50,60},{-30,80}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow heaPool(Q_flow=2000 +
        mEva.k*2.5e6)
    "Convective heat from the pool plus enthalpy of the evaporated water (approx. 2.5 MJ/kg) into the lowest layer"
    annotation (Placement(transformation(extent={{60,-30},{40,-10}})));
equation
  connect(mEva.y, mux.u1[1]) annotation (Line(points={{-69,80},{-60,80},{-60,77},
          {-52,77}}, color={0,0,127}));
  connect(zero[1].y, mux.u2[1]) annotation (Line(points={{-69,50},{-60,50},{-60,
          70},{-52,70}}, color={0,0,127}));
  connect(zero[2].y, mux.u3[1]) annotation (Line(points={{-69,50},{-60,50},{-60,
          63},{-52,63}}, color={0,0,127}));
  connect(mux.y, stratAir.mWat_flow) annotation (Line(points={{-29,70},{-20,70},
          {-20,9},{-12,9}}, color={0,0,127}));
  connect(sou.ports[1], stratAir.ports[1]) annotation (Line(points={{-40,40},{
          -30,40},{-30,-1},{-10,-1}}, color={0,127,255}));
  connect(sin.ports[1], stratAir.ports[2]) annotation (Line(points={{-40,-40},{
          -30,-40},{-30,1},{-10,1}}, color={0,127,255}));
  connect(heaPool.port, stratAir.heatPort[1]) annotation (Line(points={{40,-20},
          {20,-20},{20,-3},{10,-3}}, color={191,0,0}));
  annotation (
    experiment(StopTime=86400, Tolerance=1e-06),
    __Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/ThermalZones/ReducedOrder/ThermalZone/BaseClasses/Examples/StratifiedAirVolume.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
Test of
<a href=\"modelica://AixLib.ThermalZones.ReducedOrder.ThermalZone.BaseClasses.StratifiedAirVolume\">
AixLib.ThermalZones.ReducedOrder.ThermalZone.BaseClasses.StratifiedAirVolume</a>
with three layers. Supply air enters the top layer, extract air leaves the lowest layer,
so the supply air flows downwards through all layers. Evaporation and convective pool heat
act on the lowest layer. All values are generic and not calibrated.
</p>
</html>", revisions="<html>
<ul>
<li>November 10, 2026, by Leander Waerder:<br/>
First implementation for issue
<a href=\"https://github.com/RWTH-EBC/AixLib/issues/1649\">#1649</a>.
</li>
</ul>
</html>"));
end StratifiedAirVolume;
