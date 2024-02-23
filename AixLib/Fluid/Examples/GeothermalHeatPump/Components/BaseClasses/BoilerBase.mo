within AixLib.Fluid.Examples.GeothermalHeatPump.Components.BaseClasses;
partial model BoilerBase
  "Base class containing the simple boiler model as peak load device"
  extends Interfaces.PartialTwoPort;
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation (Dialog(tab="Dynamics"));
  BoilerCHP.Boiler boiler(
    redeclare final package Medium = Medium,
    m_flow_nominal=0.5,
    paramHC=AixLib.DataBase.Boiler.DayNightMode.HeatingCurves_Vitotronic_Day23_Night10(),
    paramBoiler=AixLib.DataBase.Boiler.General.Boiler_Vitogas200F_11kW(),
    energyDynamics=energyDynamics)
    "Peak load energy conversion unit"
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={0,0})));
  Modelica.Blocks.Sources.RealExpression chemicalEnergyFlowRateSource(
    y=boiler.internalControl.ControlerHeater.y)
    "Outputs the chemical energy flow rate of the boiler"
    annotation (Placement(transformation(extent={{-60,-66},{-40,-46}})));

equation
  connect(port_a, boiler.port_a)
    annotation (Line(points={{-100,0},{-10,0}}, color={0,127,255}));
  connect(boiler.port_b, port_b)
    annotation (Line(points={{10,0},{100,0}}, color={0,127,255}));
  annotation (Documentation(info="<html><p>
  Base class containing the <a href=
  \"modelica://AixLib.Fluid.BoilerCHP.Boiler\">AixLib.Fluid.BoilerCHP.Boiler</a>
  to be used in the examples of <a href=
  \"modelica://AixLib.Fluid.Examples.GeothermalHeatPump\">AixLib.Fluid.Examples.GeothermalHeatPump</a>.
</p>
</html>", revisions="<html>
<ul>
  <li>
    <i>May 5, 2021</i> by Fabian Wüllhorst:<br/>
    Add energyDynamics as parameter (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/1093\">#1093</a>)
  </li>
  <li>May 19, 2017, by Marc Baranski:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end BoilerBase;
