within AixLib.Controls.HeatPump;
model HPControllerOnOff
  "Simple on/off controller for heat pump model"
  extends BaseClasses.PartialHPController;

  parameter Real bandwidth(start=0.1) "Bandwidth around reference signal";
  parameter Boolean pre_y_start=false "Value of pre(y) at initial time";

  Modelica.Blocks.Sources.BooleanConstant mode "Dummy signal for unit mode, true: heat pump, false: chiller"
    annotation (Placement(transformation(extent={{-12,-50},{8,-30}})));
  Modelica.Blocks.Sources.Constant N(k=0) "Dummy signal for rotational speed of compressor"
    annotation (Placement(transformation(extent={{-12,30},{8,50}})));
  Modelica.Blocks.Logical.OnOffController onOffController(bandwidth=bandwidth,
      pre_y_start=pre_y_start) "Generates the on/off signal depending on the temperature inputs"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealInput T_meas(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC",
    min=0) "Temperature measurement"
    annotation (Placement(transformation(extent={{-115,25},{-85,55}})));
  Modelica.Blocks.Interfaces.RealInput T_set(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC",
    min=0) "Temperature set point"
    annotation (Placement(transformation(extent={{-115,-55},{-85,-25}})));
equation

  connect(N.y,heatPumpControlBus.n)  annotation (Line(points={{9,40},{40,40},{40,
          0.3525},{99.6475,0.3525}},
                                   color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(T_meas, onOffController.reference) annotation (Line(points={{-100,40},
          {-40,40},{-40,6},{-12,6}}, color={0,0,127}));
  connect(T_set, onOffController.u) annotation (Line(points={{-100,-40},{-40,-40},
          {-40,-6},{-12,-6}}, color={0,0,127}));
  connect(mode.y, heatPumpControlBus.mode) annotation (Line(points={{9,-40},{24,
          -40},{40,-40},{40,0.3525},{99.6475,0.3525}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(onOffController.y, heatPumpControlBus.onOff) annotation (Line(points=
          {{11,0},{99.6475,0},{99.6475,0.3525}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  annotation (Documentation(info="<html>
<p>This model represents a simple controller for a heat pump. It is based on the <a href=\"modelica://Modelica.Blocks.Logical.OnOffController\">Modelica.Blocks.Logical.OnOffController</a> 
but includes further constant sources so that the <a href=\"modelica://AixLib.Controls.Interfaces.HeatPumpControlBus\">AixLib.Controls.Interfaces.HeatPumpControlBus</a> can be used.</p>
</html>", revisions="<html>
<p>March 31, 2017, by Marc Baranski:</p>
<p>First implementation. </p>
</html>"));
end HPControllerOnOff;
