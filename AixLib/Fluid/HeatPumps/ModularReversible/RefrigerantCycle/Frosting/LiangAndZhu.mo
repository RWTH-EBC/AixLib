within AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.Frosting;
model LiangAndZhu "Measured velocities based on Liang et al. 2020"
  extends AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.Frosting.BaseClasses.PartialVelocityBased(
    den_constant(displayUnit="kg/m3") = 30,
    denCoe_internal(y=if zhuFroZon.zon == 1 then 150/310 elseif zhuFroZon.zon
           == 2 then 150/190 else 1),
    groRatFor_internal(y=if zhuFroZon.zon == 1 then 0.7e-7 elseif zhuFroZon.zon
           == 2 then 2.5e-7 elseif zhuFroZon.zon == 3 then 3.6e-7 else 0));
  AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.Frosting.BaseClasses.ZhuFrostingZone zhuFroZon
    "Current frosting zone"
    annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
equation

  connect(zhuFroZon.TOda, reaPasThrTOda.y) annotation (Line(points={{58,-46},{
          46,-46},{46,-90},{-19,-90}},
                                   color={0,0,127}));
  connect(zhuFroZon.relHum, sigBus.relHum) annotation (Line(points={{58,-54},{
          50,-54},{50,-92},{-101,-92},{-101,0}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    <i>December 22, 2025</i> by Fabian Roemer:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/1520\">AixLib #1623</a>)
  </li>
</ul>
</html>", info="<html>
This model estimates the frosting based on the growth velocities derived for a constant density in Liang et al., who base their work on the zones from Zhu et al.
<p>
For more information, see the base-model:
<a href=\"modelica://AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.Frosting.BaseClasses.PartialVelocityBased\">
AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.Frosting.BaseClasses.PartialVelocityBased
</a>.
</p>
<h4>References</h4>
<p>
J.H. Zhu, Y.Y. Sun, W. Wang, S.M. Deng, Y.J. Ge, and L.T. Li. Developing a new frosting map to guide defrosting control for air-source heat pump units. Applied Thermal Engineering, November 2015
  <a href=\"https://doi.org/10.1016/j.applthermaleng.2015.06.076\">doi:10.1016/j.applthermaleng.2015.06.076</a>.
</p>
<p>
Liang, S., Wang, W., Sun, Y., Li, Z., Zhao, J., Lin, Y., and Deng, S. (2020). A novel characteristic index for frosting suppression based on the configuration and operation of air source heat pumps. International Journal of Refrigeration, 109, 161-171.
<a href=\"https://doi.org/10.1016/j.ijrefrig.2019.10.009\">https://doi.org/10.1016/j.ijrefrig.2019.10.009</a>.
</p>
</html>"));
end LiangAndZhu;
