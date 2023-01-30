within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler.ControlsModularBoiler.NotUsed;
model InternalPumpControl

  parameter Real PLRMin=0.15 "Minimal Part Load Ratio";

  Modelica.Blocks.Continuous.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.01,
    Ti=10,
    yMax=1,
    yMin=0.05,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=1)
            annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Modelica.Blocks.Interfaces.RealOutput mFlowRel "relative mass flow [0, 1]"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput TFlowMea(unit="K")
    "Measured flow temperature of boiler"
    annotation (Placement(transformation(extent={{-140,-76},{-100,-36}})));
  Modelica.Blocks.Interfaces.RealInput TFlowSet(unit="K")
    "Set flow temperature of boiler"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{30,-12},{50,8}})));
equation
  connect(TFlowSet, PID.u_s)
    annotation (Line(points={{-120,0},{-52,0}}, color={0,0,127}));
  connect(TFlowMea, PID.u_m) annotation (Line(points={{-120,-56},{-40,-56},{
          -40,-12}}, color={0,0,127}));
  connect(const.y, mFlowRel) annotation (Line(points={{51,-2},{96,-2},{96,0},
          {110,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
                            Text(
          extent={{-102,26},{98,-18}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="%name")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  Boiler control unit, which estimates the relative water mass flow and
  chooses the right water temperature difference.
</p>
</html>"));
end InternalPumpControl;
