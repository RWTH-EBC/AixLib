within AixLib.Fluid.Solar.Thermal.Examples;
model PhotovoltaicThermal
  "Example to demonstrate the function of the photovoltaic thermal collector model"
  extends Modelica.Icons.Example;
  extends AixLib.Fluid.Solar.Thermal.Examples.BaseClasses.PartialExample(sin(
        nPorts=1), sou(nPorts=1),
        m_flow_nominal=1.5*pvt.A/60*995/1000,
        dp_nominal=pvt.pressureDropCoeff*(m_flow_nominal/995)^2);

  AixLib.Fluid.Solar.Thermal.PhotovoltaicThermal pvt(
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=m_flow_nominal,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    A=2,
    volPip=0.05,
    redeclare
      AixLib.DataBase.PhotovoltaicThermal.ThermalGlazedWithLowEmissionCoating
      parCol)    "Photovoltaic thermal model"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

equation
  connect(sou.ports[1], pvt.port_a)
    annotation (Line(points={{-40,0},{-10,0}}, color={0,127,255}));
  connect(pvt.port_b, sin.ports[1])
    annotation (Line(points={{10,0},{40,0}}, color={0,127,255}));
  connect(pvt.TAir, hotSumDay.y[1]) annotation (Line(points={{-6,10},{-8,10},{-8,50},
          {-19,50}}, color={0,0,127}));
  connect(pvt.Irr, hotSumDay.y[2])
    annotation (Line(points={{0,10},{0,50},{-19,50}}, color={0,0,127}));
  annotation (
    experiment(
      StopTime=86400,
      Interval=3600,
      __Dymola_Algorithm="Dassl"),
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
          "modelica://AixLib/Resources/Scripts/Dymola/Fluid/Solar/Thermal/Examples/PhotovoltaicThermal.mos" "Simulate and plot"));
end PhotovoltaicThermal;
