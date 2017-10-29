within AixLib.Controls.HeatPump.ModularHeatPumps;
model ModularCompressorController
  "Model of an internal controller for modular compressors"
  extends BaseClasses.PartialModularController(
    dataBus(final nCom=nCom));

  // Definition of dummy signals for controllers' rest inputs
  //
  Modelica.Blocks.Sources.BooleanConstant trigger[nCom](each k=false)
    "Boolean block to provide dummy signal to controllers' trigger signals"
    annotation(Placement(transformation(extent={{-96,4},{-84,16}})),
               HideResult=true);
  Modelica.Blocks.Sources.Constant triggerVal[nCom](each k=0)
    "Real block to provide dummy signal to controllers' rest signals"
    annotation(Placement(transformation(extent={{-96,24},{-84,36}})),
               HideResult=true);


equation
  // Connect internal controller with inputs and outputs
  //
  connect(internalController.u_m,  dataBus.comBus.meaConVarCom);
  connect(internalController.u_s,  dataBus.comBus.intSetPoiCom);
  connect(internalController.y,  manVar);

  if useExt then
    connect(manVar, dataBus.comBus.extManVarCom);
  end if;
  manVarVal = manVar;

  /*The output block 'manVar' is mandantory since the internal controller is 
    conditional. Therefore, the connection 'connect(internalController.y,manVar)'
    is required to prevent errors that would occur otherwise if the internal
    controller is removed conditionally.
  */

  // Connect dummy signals to controllers' rest inputs
  //
  connect(trigger.y, internalController.trigger)
    annotation(Line(points={{-83.4,10},{-68,10},{-68,28}},
               color={255,0,255}));
  connect(triggerVal.y, internalController.y_reset_in)
    annotation(Line(points={{-83.4,30},{-80,30},{-80,32},{-72,32}},
               color={0,0,127}));

  // Connect output signals
  //
  connect(useExtBlo, dataBus.comBus.extConCom)
    annotation (Line(points={{-60,0},{-60,-80},{0.05,-80},{0.05,-99.95}},
                color={255,0,255}));
  connect(curManVarVal, dataBus.comBus.curManVarVal)
    annotation (Line(points={{60,112},{60,-80},{0.05,-80},{0.05,-99.95}},
                color={0,0,127}));

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
          textStyle={TextStyle.Bold})}));
end ModularCompressorController;
