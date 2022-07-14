within AixLib.Controls.HeatPump.Examples;
partial model PartialHeatPumpController
  "Example for usage of heat pump controller"
  extends Modelica.Icons.Example;

  AixLib.Controls.Interfaces.VapourCompressionMachineControlBus heatPumpControlBus
    "Required to make the signals on the bus accessible" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-56,-50})));
  Modelica.Blocks.Sources.Sine T_meas(
    freqHz=1/3600,
    amplitude=6,
    offset=310) "Generates the measured temperature"
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  Modelica.Blocks.Sources.Constant T_set(k=310)
    "Provides the temperature set point"
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Modelica.Blocks.Interfaces.RealOutput TMea(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC",
    min=0) "Outputs the temperature measurement"
    annotation (Placement(transformation(extent={{101,-75},{131,-45}})));
  replaceable BaseClasses.PartialTSetToNSet hPController constrainedby
    BaseClasses.PartialTSetToNSet(
    final use_secHeaGen=false,
    use_heaLim=false,
    T_heaLim=293.15,
    movAveTime=300) annotation (Placement(transformation(extent={{-20,-20},
            {20,20}})), __Dymola_choicesAllMatching=true);
  Modelica.Blocks.Interfaces.RealOutput TSet(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC",
    min=0) "Outputs the temperature measurement"
    annotation (Placement(transformation(extent={{101,-15},{131,15}})));
  Modelica.Blocks.Interfaces.RealOutput nSet
    "Outputs the temperature measurement"
    annotation (Placement(transformation(extent={{101,45},{131,75}})));
  Modelica.Blocks.Sources.Constant T_oda(k=273.15)
    "Provides the temperature set point"
    annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
equation
  connect(T_meas.y, TMea) annotation (Line(points={{-79,30},{-70,30},{-70,-60},{
          116,-60}}, color={0,0,127}));
  connect(hPController.TSet, T_set.y) annotation (Line(points={{-23.2,12},{-62,12},
          {-62,-30},{-79,-30}}, color={0,0,127}));
  connect(hPController.TMea, T_meas.y) annotation (Line(points={{-23.2,-16},{-70,
          -16},{-70,30},{-79,30}}, color={0,0,127}));
  connect(nSet, hPController.nOut) annotation (Line(points={{116,60},{102,60},{102,
          58},{76,58},{76,0},{22,0}}, color={0,0,127}));
  connect(T_oda.y, heatPumpControlBus.TOdaMea) annotation (Line(points={{-79,-70},
          {-55.95,-70},{-55.95,-49.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(heatPumpControlBus, hPController.sigBusHP) annotation (Line(
      points={{-56,-50},{-36,-50},{-36,-6},{-21.4,-6},{-21.4,-6.2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(T_set.y, TSet) annotation (Line(points={{-79,-30},{86,-30},{86,0},{116,
          0}}, color={0,0,127}));
  annotation (experiment(StopTime=10000, Interval=10), Documentation(info="<html>
<p>Partial example model for heat pump controls.</p>
</html>", revisions="<html><ul>
  <li>
    <i>July 14, 2022</i> by Fabian Wüllhorst:<br/>
    First implementation (see
    issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/1128\">#1128</a>)
  </li>
</ul>
</html>"));
end PartialHeatPumpController;
