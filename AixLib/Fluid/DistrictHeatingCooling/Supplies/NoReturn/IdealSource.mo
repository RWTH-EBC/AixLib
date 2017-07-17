within AixLib.Fluid.DistrictHeatingCooling.Supplies.NoReturn;
model IdealSource
  "Simple supply node model with ideal flow source and no return port"
  extends BaseClasses.Supplies.NoReturn.PartialSupply(
    redeclare AixLib.Fluid.DistrictHeatingCooling.Supplies.Controllers.Temperature.ControllerTConst controllerT(T_set=
          T_supply));
  AixLib.Fluid.Sources.Boundary_pT source(          redeclare package Medium =
        Medium,
    p=p_supply,
    nPorts=1,
    T=T_supply,
    use_T_in=true)
              "Flow source with fixed supply pressure for the network"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,40})));

equation
  connect(source.ports[1], senT_supply.port_a)
    annotation (Line(points={{0,30},{0,0},{40,0}}, color={0,127,255}));
  connect(controllerT.y, source.T_in)
    annotation (Line(points={{-59,70},{4,70},{4,52}}, color={0,0,127}));
  annotation (Icon(graphics={Ellipse(
          extent={{-78,40},{2,-40}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid)}), Documentation(revisions="<html>
<ul>
<li>
May 27, 2017, by Marcus Fuchs:<br/>
Implemented for <a href=\"https://github.com/RWTH-EBC/AixLib/issues/402\">issue 403</a>.
</li>
</ul>
</html>", info="<html>
<p>
This model represents the supply node with an ideal pressure source. It provides
a constant supply pressure and a constant supply temperature to the network.
</p>
</html>"));
end IdealSource;
