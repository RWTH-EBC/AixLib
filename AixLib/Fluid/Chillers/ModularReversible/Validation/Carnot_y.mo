within AixLib.Fluid.Chillers.ModularReversible.Validation;
model Carnot_y "Example using the Carnot model approach"
  extends AixLib.Fluid.HeatPumps.ModularReversible.Validation.Comparative.BaseClasses.PartialComparison(
    m1_flow_nominal=chi.m1_flow_nominal,
    m2_flow_nominal=chi.m2_flow_nominal,
    sin2(nPorts=1),
    sou2(nPorts=1),
    sin1(nPorts=1),
    sou1(nPorts=1));
  extends Modelica.Icons.Example;
  AixLib.Fluid.Chillers.Carnot_y chi(
    redeclare package Medium1 = Medium1,
    redeclare package Medium2 = Medium2,
    etaCarnot_nominal=etaCarnot_nominal,
    TCon_nominal=TCon_nominal,
    TEva_nominal=TEva_nominal,
    tau1=tau1,
    tau2=tau2,
    P_nominal=QUse_flow_nominal/chi.COP_nominal,
    dTEva_nominal=-dTEva_nominal,
    dTCon_nominal=dTCon_nominal,
    use_eta_Carnot_nominal=false,
    dp1_nominal=dp1_nominal,
    dp2_nominal=dp2_nominal,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    show_T=true,
    T1_start=T1_start,
    T2_start=T2_start)
                     "Chiller model"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

equation
  connect(sin2.ports[1], chi.port_b2) annotation (Line(points={{-40,-30},{-16,-30},
          {-16,-6},{-10,-6}}, color={0,127,255}));
  connect(chi.port_a2, sou2.ports[1])
    annotation (Line(points={{10,-6},{40,-6}}, color={0,127,255}));
  connect(chi.port_b1, sin1.ports[1])
    annotation (Line(points={{10,6},{36,6},{36,30},{60,30}}, color={0,127,255}));
  connect(chi.port_a1, sou1.ports[1]) annotation (Line(points={{-10,6},{-40,6}},
                       color={0,127,255}));
  connect(chi.y, uCom.y)
    annotation (Line(points={{-12,9},{-12,50},{-39,50}}, color={0,0,127}));

  annotation (experiment(Tolerance=1e-6, StopTime=3600),
__Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Fluid/Chillers/ModularReversible/Validation/Carnot_y.mos"
        "Simulate and plot"),
    Documentation(revisions="<html>
<ul>
<li>
November 13, 2023 by Fabian Wuellhorst:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>
Validation case for <a href=\"modelica://AixLib.Fluid.Chillers.Carnot_y\">
AixLib.Fluid.Chillers.Carnot_y</a>, duplicate of the example
<a href=\"modelica://AixLib.Fluid.Chillers.Examples.Carnot_y\">
AixLib.Fluid.Chillers.Examples.Carnot_y</a>.
</p>
</html>"),  
   __Dymola_LockedEditing="Model from IBPSA");
end Carnot_y;
