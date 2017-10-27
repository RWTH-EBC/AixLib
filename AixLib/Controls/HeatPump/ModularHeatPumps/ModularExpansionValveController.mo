within AixLib.Controls.HeatPump.ModularHeatPumps;
model ModularExpansionValveController
  "Model of an internal controller for modular expansion valves"
  extends BaseClasses.PartialModularController;

  // Definition of dummy signals for controllers' rest inputs
  //
  Modelica.Blocks.Sources.BooleanConstant tri[nCom](each k=false)
    "Boolean block to provide dummy signal to controllers' trigger signals"
    annotation (Placement(transformation(extent={{-96,4},{-84,16}})),
      HideResult=true);
  Modelica.Blocks.Sources.Constant triVal[nCom](each k=0)
    "Real block to provide dummy signal to controllers' rest signals"
    annotation (Placement(transformation(extent={{-96,24},{-84,36}})),
      HideResult=true);


equation
  // Connect internal controller with inputs and outputs
  //
  connect(internalController.u_m,  dataBus.expValBus.meaConVarVal);
  connect(internalController.u_s,  dataBus.expValBus.intSetPoiVal);
  connect(internalController.y,  manVar);

  if useExt then
    connect(manVarVal, dataBus.expValBus.extManVarVal);
  end if;
  manVarVal = manVar;

  /*The output block 'manVar' is mandantory since the internal controller is 
    conditional. Therefore, the connection 'connect(internalController.y,manVar)'
    is required to prevent errors that would occur otherwise if the internal
    controller is removed conditionally.
  */

  // Connect dummy signals to controllers' rest inputs
  //
  connect(tri.y, internalController.trigger) annotation (Line(points={{-83.4,10},
          {-68,10},{-68,28}}, color={255,0,255}));
  connect(triVal.y, internalController.y_reset_in) annotation (Line(points={{-83.4,
          30},{-80,30},{-80,32},{-72,32}}, color={0,0,127}));

  // Connect parameters describing if internal or external signal is used
  //
  connect(useExtBlo, dataBus.expValBus.extConVal)
    annotation (Line(points={{-60,0},{-60,-80},{0.05,-80},{0.05,-99.95}},
                color={255,0,255}));

  annotation (Icon(graphics={
        Polygon(
          points={{0,-34},{-30,-14},{-30,-54},{0,-34}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Polygon(
          points={{0,-34},{30,-14},{30,-54},{0,-34}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Line(
          points={{0,-22},{0,-34}},
          color={0,0,0},
          thickness=0.5),
        Ellipse(
          extent={{-14,6},{14,-22}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-14,6},{14,-22}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          textString="M",
          textStyle={TextStyle.Bold})}), Documentation(info="<html>
<p>
This a controller block used for modular expansion valve models as presented in 
<a href=\"modelica://AixLib.Fluid.Actuators.Valves.ExpansionValves.ModularExpansionValves\">
AixLib.Fluid.Actuators.Valves.ExpansionValves.ModularExpansionValves</a>. The 
controller block consists of simple PID controllers for each expansion valve and
no further control strategy is implemented.
However, these PID controller are only initialised and activated if no
external controller is provided (i.g. if <code>useExt = false</code>).
</p>
<h4>Implementation</h4>
<p>
If the controller block is implemented, appropriate values must be applied
for all parameters describing the PID controller.
</p>
</html>", revisions="<html>
<ul>
  <li>
  October 17, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/457\">issue 457</a>).
  </li>
</ul>
</html>"));
end ModularExpansionValveController;
