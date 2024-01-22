within AixLib.Controls.HeatPump.Examples;
model HeatPumpController "Example for usage of heat pump controller"
  extends Modelica.Icons.Example;

  HPControllerOnOff hPControllerOnOff(bandwidth=2)
    "Simple on/off controller for a heat pump"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Interaction.Show.RealValue showN
    "Shows the current value of the revolution speed"
    annotation (Placement(transformation(extent={{60,60},{80,80}})));
  Modelica.Blocks.Interaction.Show.BooleanValue showOnOff
    "Shows the current value of the on/off signal"
    annotation (Placement(transformation(extent={{66,40},{86,60}})));
  AixLib.Controls.Interfaces.VapourCompressionMachineControlBus heatPumpControlBus
    "Required to make the signals on the bus accessible" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,0})));
  Modelica.Blocks.Interaction.Show.BooleanValue showMode
    "Shows the current value of the mode signal"
    annotation (Placement(transformation(extent={{66,18},{86,38}})));
  Modelica.Blocks.Sources.RealExpression temperatureMeasurements[4](y={280,290,
        300,310}) "Represents temperature measurements in heat pump"
                  annotation (Placement(transformation(
        extent={{-30,-10},{30,10}},
        rotation=0,
        origin={-70,-76})));
  Modelica.Blocks.Sources.RealExpression massFlowRateMeasurements[2](y={0.5,1})
    "Represents mass flow rate measurements in heat pump"
    annotation (Placement(transformation(
        extent={{-30,-10},{30,10}},
        rotation=0,
        origin={-70,-96})));
  Modelica.Blocks.Sources.Sine T_meas(
    f=1/3600,
    amplitude=6,
    offset=310) "Generates the measured temperature"
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  Modelica.Blocks.Sources.Constant T_set(k=310)
    "Provides the temperature set point"
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Modelica.Blocks.Interaction.Show.RealValue showT_meas
    "Shows the current value of the measured temperature"
    annotation (Placement(transformation(extent={{-60,70},{-20,90}})));
  Modelica.Blocks.Interfaces.RealOutput output_T_meas(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC",
    min=0) "Outputs the temperature measurement"
    annotation (Placement(transformation(extent={{85,-75},{115,-45}})));
  Modelica.Blocks.Interfaces.BooleanOutput output_on
    "Outputs the on/off signal"
    annotation (Placement(transformation(extent={{86,-94},{114,-66}})));
equation
  connect(hPControllerOnOff.heatPumpControlBus, heatPumpControlBus) annotation (
     Line(
      points={{-40.05,0.05},{-20.025,0.05},{-20.025,0},{0,0}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(heatPumpControlBus.nSet, showN.numberPort) annotation (Line(
      points={{0.05,-0.05},{20,-0.05},{20,70},{58.5,70}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(temperatureMeasurements[1].y, heatPumpControlBus.TEvaInMea)
    annotation (Line(points={{-37,-76},{0.05,-76},{0.05,-0.05}},
                   color={0,0,127}), Text(
      index=1,
      extent={{6,3},{6,3}}));
  connect(temperatureMeasurements[2].y, heatPumpControlBus.TConInMea)
    annotation (Line(points={{-37,-76},{0.05,-76},{0.05,-0.05}},
                   color={0,0,127}), Text(
      index=1,
      extent={{6,3},{6,3}}));
  connect(temperatureMeasurements[3].y, heatPumpControlBus.TEvaOutMea)
    annotation (Line(points={{-37,-76},{0.05,-76},{0.05,-0.05}},
                   color={0,0,127}), Text(
      index=1,
      extent={{6,3},{6,3}}));
  connect(temperatureMeasurements[4].y, heatPumpControlBus.TConOutMea)
    annotation (Line(points={{-37,-76},{0.05,-76},{0.05,-0.05}},
                   color={0,0,127}), Text(
      index=1,
      extent={{6,3},{6,3}}));
  connect(massFlowRateMeasurements[1].y, heatPumpControlBus.m_flowEvaMea)
    annotation (Line(points={{-37,-96},{20,-96},{20,-0.05},{0.05,-0.05}},
        color={0,0,127}), Text(
      index=1,
      extent={{6,3},{6,3}}));
  connect(massFlowRateMeasurements[2].y, heatPumpControlBus.m_flowConMea)
    annotation (Line(points={{-37,-96},{0,-96},{0,-0.05},{0.05,-0.05}},
        color={0,0,127}), Text(
      index=1,
      extent={{6,3},{6,3}}));
  connect(T_meas.y,showT_meas. numberPort) annotation (Line(points={{-79,30},{
          -66,30},{-66,80},{-63,80}}, color={0,0,127}));
  connect(T_meas.y, output_T_meas) annotation (Line(points={{-79,30},{-74,30},{
          -74,-60},{100,-60}}, color={0,0,127}));
  connect(heatPumpControlBus.modeSet, showMode.activePort) annotation (Line(
      points={{0.05,-0.05},{10,-0.05},{20,-0.05},{20,28},{64.5,28}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(heatPumpControlBus.onOffMea, showOnOff.activePort) annotation (Line(
      points={{0.05,-0.05},{20,-0.05},{20,50},{64.5,50}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(heatPumpControlBus.onOffMea, output_on) annotation (Line(
      points={{0.05,-0.05},{20,-0.05},{20,-80},{100,-80}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(T_meas.y, hPControllerOnOff.TSet) annotation (Line(points={{-79,30},{
          -68,30},{-68,4},{-60,4}}, color={0,0,127}));
  connect(T_set.y, hPControllerOnOff.TMea) annotation (Line(points={{-79,-30},{
          -68,-30},{-68,-4},{-60,-4}}, color={0,0,127}));
  annotation (experiment(StopTime=10000, Interval=10), Documentation(info="<html><p>
  This example can be used to test that <a href=
  \"modelica://AixLib.Controls.HeatPump.HPControllerOnOff\">AixLib.Controls.HeatPump.HPControllerOnOff</a>
  supplies all required signals as specified in <a href=
  \"modelica://AixLib.Controls.ControllerInterfaces.HeatPumpControlBus\">AixLib.Controls.ControllerInterfaces.HeatPumpControlBus</a>.
  The generated signals are visualized using the <a href=
  \"modelica://Modelica.Blocks.Interaction.Show\">Show</a> package. The
  temperature measurement is supplied by a sine block so that the
  reaction of the controller can be tested.
</p>
<p>
  The example also shows how to connect two models, typically a model
  of a physical component and a controller, via the bus connector. The
  temperatureMeasurements and the massFlowRateMeasurements are only
  connected for demonstration purposes and are not required by the
  controller.
</p>
</html>"));
end HeatPumpController;
