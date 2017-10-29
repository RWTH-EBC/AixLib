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
  connect(intCon.u_m, dataBus.comBus.meaConVarCom);
  connect(intCon.u_s, dataBus.comBus.intSetPoiCom);
  connect(intCon.y, manVarThr);

  if useExt then
    connect(manVarThr, dataBus.comBus.extManVarCom);
  end if;
  manVar = manVarThr;

  /*The output block 'manVarThr' is mandantory since the internal controller is 
    conditional. Therefore, the connection 'connect(internalController.y,
    manVarThr)' is required to prevent errors that would occur otherwise if the 
    internal controller is removed conditionally.
  */

  // Connect dummy signals to controllers' rest inputs
  //
  connect(trigger.y, intCon.trigger) annotation (Line(points={{-83.4,10},{-68,10},
          {-68,28}}, color={255,0,255}));
  connect(triggerVal.y, intCon.y_reset_in) annotation (Line(points={{-83.4,30},{
          -80,30},{-80,32},{-72,32}}, color={0,0,127}));

  // Connect output signals
  //
  connect(useExtBlo, dataBus.comBus.extConCom)
    annotation (Line(points={{-60,0},{-60,-80},{0.05,-80},{0.05,-99.95}},
                color={255,0,255}));
  connect(curManVar, dataBus.comBus.curManVarVal) annotation (Line(points={{60,112},
          {60,-80},{0.05,-80},{0.05,-99.95}}, color={0,0,127}));

  annotation (Icon(graphics={
                Ellipse(
                  extent={{20,-4},{-20,-44}},
                  lineColor={0,0,0},
                  startAngle=0,
                  endAngle=360,
                  fillPattern=FillPattern.Sphere,
                  fillColor={214,214,214}),
                Line(
                  points={{18,-16},{-14,-10}},
                  color={0,0,0},
                  thickness=0.5),
                Line(
                  points={{18,-32},{-14,-38}},
                  color={0,0,0},
                  thickness=0.5)}));
end ModularCompressorController;
