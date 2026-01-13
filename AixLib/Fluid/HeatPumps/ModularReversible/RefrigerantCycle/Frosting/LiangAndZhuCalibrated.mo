within AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.Frosting;
model LiangAndZhuCalibrated
  "Measured velocities based on Liang et al. 2020 calibrated on own heat pump"
  extends
   AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.Frosting.BaseClasses.PartialVelocityBased(
    A=47,
    den_min=50,
    T=8000,
    k=3.77,
    estimateMaximalIceMass=false,
    use_varDen=true,
    mIce_max=4.334993,
    denCoe_internal(y=if zhuFroZon.zon == defrostEfficiency then 150/310*
          defrostEfficiency elseif zhuFroZon.zon == 2 then 150/190*
          defrostEfficiency else defrostEfficiency),
    groRatFor_internal(y=if timeOn.y > timeFirstFro.y then if zhuFroZon.zon == 1
           then ((1.4e-7)/(zhuFroZon.relHumMod - zhuFroZon.relHumMil)*(
          zhuFroZon.relHum - zhuFroZon.relHumMil))*corCoeffMil elseif zhuFroZon.zon
           == 2 then (1.4e-7 + (3.6e-7 - 1.4e-7)/(zhuFroZon.relHumSev -
          zhuFroZon.relHumMod)*(zhuFroZon.relHum - zhuFroZon.relHumMod))*
          corCoeffMod elseif zhuFroZon.zon == 3 then (3.6e-7 + (3.6e-7 - 1.4e-7)
          /(zhuFroZon.relHumSev - zhuFroZon.relHumMod)*(zhuFroZon.relHum -
          zhuFroZon.relHumSev))*corCoeffSev else 0 else 0));
  parameter Real timeMil=timeSev * facSevMil;
  parameter Real defrostEfficiency = 0.65 "Defrost efficiency";

    parameter Real facSevMil=1.358403;
  parameter Real timeSev=1083.524850;
  parameter Real corCoeffSev=0.231588 "Correction coefficient for severe zone";
  parameter Real corCoeffMod=0.218708 "Correction coefficient for moderate zone";
  parameter Real corCoeffMil=0.218708 "Correction coefficient for mild zone";

  AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.Frosting.BaseClasses.ZhuFrostingZone zhuFroZon
    "Current frosting zone"
    annotation (Placement(transformation(extent={{0,-100},{20,-80}})));
  Modelica.Blocks.Sources.RealExpression timeFirstFro(y=if zhuFroZon.zon == 1
         then timeMil elseif zhuFroZon.zon == 2 then (timeMil + (timeSev -
        timeMil)/(zhuFroZon.relHumSev - zhuFroZon.relHumMod)*(zhuFroZon.relHum -
        zhuFroZon.relHumMod)) elseif zhuFroZon.zon == 3 then timeSev else 0)
                              "Time of first frost after last defrost"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={-70,90})));
  Modelica.Blocks.Logical.Timer timeOn "Time device is on since last defrost"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={-30,100})));
equation

  connect(zhuFroZon.TOda, reaPasThrTOda.y) annotation (Line(points={{-2,-86},{
          -14,-86},{-14,-90},{-19,-90}},
                                   color={0,0,127}));
  connect(zhuFroZon.relHum, sigBus.relHum) annotation (Line(points={{-2,-94},{
          -8,-94},{-8,-104},{-100,-104},{-100,0},{-101,0}},
                                                 color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(timeOn.u, and1.y) annotation (Line(points={{-42,100},{-50,100},{-50,
          60},{-59,60}},                             color={255,0,255}));
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    <i>December 22, 2025</i> by Fabian Roemer:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/1520\">AixLib #1623</a>)
  </li>
</ul>
</html>", info="<html>
<p>
This model calibrates the growth velocities from Liang et al., who base their work on the zones from Zhu et al., 
onto dynamic frost densities and a custom build heat pump at the Institute for Energy Efficient Buildings and Indoor Climate.
</p>
<p>
The calibration was performed and used for Römer et al.
In addition to Liang et al., a time-delay after the last defrost is used before the frost starts to grow again.
This was added based observed data from dynamic tests and is grounded in the fact that fins are warm after defrost, and, thus, don't directly accumulate frost.
</p>
<p>
For more information, see the base-model:
<a href=\"modelica://AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.Frosting.BaseClasses.PartialVelocityBased\">
AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.Frosting.BaseClasses.PartialVelocityBased
</a>.
</p>
<h4>References</h4>
<p>
Römer, Fabian and Fuchs, Nico and Fuchs, Nico and Müller, Dirk, Practical, Near-Optimal Design Rule Extraction for Heat Pumps in Single-Family Buildings (September 03, 2025). Available at SSRN: 
<a href=\"https://ssrn.com/abstract=5633891\">https://ssrn.com/abstract=5633891</a>
</p>
<p>
J.H. Zhu, Y.Y. Sun, W. Wang, S.M. Deng, Y.J. Ge, and L.T. Li. Developing a new frosting map to guide defrosting control for air-source heat pump units. Applied Thermal Engineering, November 2015
  <a href=\"https://doi.org/10.1016/j.applthermaleng.2015.06.076\">doi:10.1016/j.applthermaleng.2015.06.076</a>.
</p>
<p>
Liang, S., Wang, W., Sun, Y., Li, Z., Zhao, J., Lin, Y., and Deng, S. (2020). A novel characteristic index for frosting suppression based on the configuration and operation of air source heat pumps. International Journal of Refrigeration, 109, 161-171.
<a href=\"https://doi.org/10.1016/j.ijrefrig.2019.10.009\">https://doi.org/10.1016/j.ijrefrig.2019.10.009</a>.
</p>
</html>"));
end LiangAndZhuCalibrated;
