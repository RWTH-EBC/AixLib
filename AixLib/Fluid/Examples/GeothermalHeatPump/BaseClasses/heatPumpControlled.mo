within AixLib.Fluid.Examples.GeothermalHeatPump.BaseClasses;
model heatPumpControlled "Simple model of heat pump and controller"
  extends HeatPumps.HeatPumpSimple;
  Controls.Interfaces.HeatPumpControlBus heatPumpControlBus
    annotation (Placement(transformation(extent={{-10,88},{10,108}})));
equation
  connect(heatPumpControlBus.onOff, OnOff) annotation (Line(
      points={{0.05,98.05},{0,98.05},{0,80}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(heatPumpControlBus.T_ret_co, temperatureSinkOut.T) annotation (Line(
      points={{0.05,98.05},{24,98.05},{48,98.05},{48,50},{69,50}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(heatPumpControlBus.T_flow_ev, temperatureSourceIn.T) annotation (Line(
      points={{0.05,98.05},{-66,98.05},{-66,36},{-69,36}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  annotation (Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">This is an interim solution. The model extends <a href=\"modelica://AixLib.Fluid.HeatPumps.HeatPumpSimple\">AixLib.Fluid.HeatPumps.HeatPumpSimple</a>. Additionally, the bus connector for the controller model is added. The model should be replaced as soon as the bus connector has been added to the actual heat pump model.</span></p>
</html>"));
end heatPumpControlled;
