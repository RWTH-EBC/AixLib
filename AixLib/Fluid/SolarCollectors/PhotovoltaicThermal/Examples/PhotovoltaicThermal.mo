within AixLib.Fluid.SolarCollectors.PhotovoltaicThermal.Examples;
model PhotovoltaicThermal
  "Example to demonstrate the function of the photovoltaic thermal collector model"
  extends Modelica.Icons.Example;
  extends
    AixLib.Fluid.SolarCollectors.PhotovoltaicThermal.Examples.BaseClasses.PartialExample(
    sin(nPorts=1),
    sou(nPorts=1),
    m_flow_nominal=pvt.m_flow_nominal,
    dp_nominal=pvt.dp_nominal);

  EN12975Curves pvt(
    redeclare package Medium = AixLib.Media.Water,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    nSeg=3,
    azi=0,
    til=0.5235987755983,
    rho=0.2,
    totalArea=20,
    redeclare
      AixLib.Fluid.SolarCollectors.PhotovoltaicThermal.Data.ThermalGlazedWithLowEmissionCoating
      perPVT) "Photovoltaic thermal model"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

equation
  connect(sou.ports[1], pvt.port_a)
    annotation (Line(points={{-40,0},{-10,0}}, color={0,127,255}));
  connect(pvt.port_b, sin.ports[1])
    annotation (Line(points={{10,0},{40,0}}, color={0,127,255}));
  connect(weaDat.weaBus, pvt.weaBus) annotation (Line(
      points={{-20,50},{-14,50},{-14,8},{-10,8}},
      color={255,204,51},
      thickness=0.5));
  annotation (
    experiment(
      StartTime=10368000,
      StopTime=10540800,
      Tolerance=1e-6,
      Interval=3600),
    __Dymola_experimentSetupOutput(events=false),
    Documentation(info="<html>
<p><b><span style=\"color: #008000;\">Overview</span></b> </p>
<p>This test demonstrates the photovoltaic thermal collector model. 
Different types of collectors can be tested at fixed boundary conditions. </p>
</html>", revisions="<html><ul>
  <li>
    <i>January 23, 2024</i> by Philipp Schmitz and Fabian Wuellhorst:<br/>
    First implementation. This is for
 <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1451\">
 issue 1451</a>.
  </li>
</ul>
</html>"),
    __Dymola_Commands(file=
          "modelica://AixLib/Resources/Scripts/Dymola/Fluid/SolarCollectors/PhotovoltaicThermal/Examples/PhotovoltaicThermal.mos" "Simulate and plot"));
end PhotovoltaicThermal;
