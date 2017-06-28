within AixLib.Fluid.Examples.DistrictHeating.Controller;
model SolarDistrictHeatingController "Controller model for solar district heating "

  AixLib.Fluid.Examples.DistrictHeating.Controller.StgCirController_TempBased stgCirController_TempBased
    annotation (Placement(transformation(extent={{-8,-4},{22,20}})));
  AixLib.Fluid.Examples.DistrictHeating.Controller.SolCirController_TempIrradBased
    solCirController_TempIrradBased
    annotation (Placement(transformation(extent={{-64,16},{-28,42}})));
  Modelica.Blocks.Interfaces.RealInput CurrIrrad "measured irradiation"
    annotation (Placement(transformation(extent={{-124,34},{-88,70}}),
        iconTransformation(extent={{-122,30},{-100,52}})));
  Modelica.Blocks.Interfaces.RealInput SeasStgBotTemp
    "Storage temperature at the bottom" annotation (Placement(transformation(
          extent={{-124,-40},{-88,-4}}), iconTransformation(extent={{-122,-12},
            {-100,10}})));
  Modelica.Blocks.Interfaces.RealInput FlowTempSol
    "Solar flow temperature in C" annotation (Placement(transformation(extent={{-124,
            -14},{-88,22}}),      iconTransformation(extent={{-122,-56},{-100,
            -34}})));
  Modelica.Blocks.Interfaces.RealInput AmbTemp "ambient temperature in C"
    annotation (Placement(transformation(extent={{-124,10},{-88,46}}),
        iconTransformation(extent={{-122,10},{-100,32}})));
  Modelica.Blocks.Interfaces.RealOutput MFSolCirPump annotation (Placement(
        transformation(extent={{176,64},{200,88}}),iconTransformation(extent={{188,62},
            {206,80}})));
  Modelica.Blocks.Interfaces.RealOutput MFStgCirPump annotation (Placement(
        transformation(extent={{176,46},{200,70}}),  iconTransformation(
          extent={{188,44},{206,62}})));
  Modelica.Blocks.Interfaces.BooleanOutput SolColPump annotation (Placement(
        transformation(extent={{-12,-12},{12,12}},
        rotation=90,
        origin={50,82}),                           iconTransformation(extent={{-12,-12},
            {12,12}},
        rotation=90,
        origin={26,80})));
  Modelica.Blocks.Interfaces.BooleanOutput StgCirPump annotation (Placement(
        transformation(extent={{-12,-12},{12,12}},
        rotation=90,
        origin={72,82}),                             iconTransformation(
          extent={{-12,-12},{12,12}},
        rotation=90,
        origin={54,80})));
  Modelica.Blocks.Interfaces.RealInput SeasStgTopTemp
    "Storage temperature at the top" annotation (Placement(transformation(
          extent={{-126,-66},{-88,-28}}), iconTransformation(extent={{-122,
            -34},{-100,-12}})));
  Modelica.Blocks.Interfaces.RealInput setPointBuffStg
    "Set point temperature of buffer storage in [°C]"
                                              annotation (Placement(
        transformation(extent={{-125,58},{-87,96}}), iconTransformation(
          extent={{-122,52},{-100,74}})));
  Modelica.Blocks.Interfaces.RealOutput ValveOpIndir annotation (Placement(
        transformation(extent={{176,13},{200,37}}),  iconTransformation(
          extent={{188,9},{206,26}})));
  Modelica.Blocks.Interfaces.RealOutput ValveOpDir annotation (Placement(
        transformation(extent={{176,30},{200,54}}),iconTransformation(extent={{188,26},
            {206,44}})));
  AixLib.Fluid.Examples.DistrictHeating.Controller.ModeBasedController stateMachine
    annotation (Placement(transformation(extent={{-8,-52},{22,-28}})));
  Modelica.Blocks.Interfaces.RealOutput EvaMF
    annotation (Placement(transformation(extent={{176,-2},{200,22}}),
        iconTransformation(extent={{188,-10},{206,8}})));
  Modelica.Blocks.Interfaces.RealOutput ConMF
    annotation (Placement(transformation(extent={{176,-18},{200,6}}),
        iconTransformation(extent={{188,-28},{206,-10}})));
  Modelica.Blocks.Interfaces.RealOutput DirSuppMF
    annotation (Placement(transformation(extent={{176,-34},{200,-10}}),
        iconTransformation(extent={{188,-46},{206,-28}})));
  Modelica.Blocks.Interfaces.RealInput TopTempBuffStg
    "Top temperature of the buffer storage in [°C]" annotation (Placement(
        transformation(
        extent={{-19,-19},{19,19}},
        rotation=90,
        origin={-67,-85}), iconTransformation(
        extent={{-11,-11},{11,11}},
        rotation=270,
        origin={-73,74})));
  Modelica.Blocks.Interfaces.BooleanOutput hpSignal
    "OnOff signal of the heat pump" annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=270,
        origin={16,-86}), iconTransformation(
        extent={{-11,-11},{11,11}},
        rotation=270,
        origin={25,-77})));
  Modelica.Blocks.Interfaces.BooleanOutput DirSupp annotation (Placement(
        transformation(
        extent={{-12,-12},{12,12}},
        rotation=270,
        origin={-2,-86}), iconTransformation(
        extent={{-11,-11},{11,11}},
        rotation=270,
        origin={-1,-77})));
  Modelica.Blocks.Interfaces.RealOutput hpRPM annotation (Placement(
        transformation(
        extent={{-12,-12},{12,12}},
        rotation=270,
        origin={36,-86}), iconTransformation(
        extent={{-11,-11},{11,11}},
        rotation=270,
        origin={51,-77})));
  Modelica.Blocks.Interfaces.RealInput hpCondTemp
    "Flow temperature of condensator in C" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-22,-85}), iconTransformation(
        extent={{-11,-11},{11,11}},
        rotation=0,
        origin={-111,-65})));
  AixLib.Fluid.Examples.DistrictHeating.Controller.BackupController BackupSystemController
    annotation (Placement(transformation(extent={{62,-26},{104,4}})));
  Modelica.Blocks.Interfaces.RealInput FlowTempSDH
    "Flow temperature of the solar district heating network in [°C]"
    annotation (Placement(transformation(extent={{-127,-94},{-87,-54}}),
        iconTransformation(extent={{-11,-10.5},{11,10.5}},
        rotation=270,
        origin={-49,74.5})));
  Modelica.Blocks.Interfaces.RealOutput valOpBypass annotation (Placement(
        transformation(extent={{176,-56},{200,-32}}), iconTransformation(
          extent={{188,-64},{206,-46}})));
  Modelica.Blocks.Interfaces.RealOutput valOpAux annotation (Placement(
        transformation(extent={{176,-74},{200,-50}}), iconTransformation(
          extent={{188,-82},{206,-64}})));
equation
  connect(CurrIrrad, solCirController_TempIrradBased.CurrIrradiation)
    annotation (Line(points={{-106,52},{-82,52},{-82,35.89},{-63.8875,35.89}},
        color={0,0,127}));
  connect(AmbTemp, solCirController_TempIrradBased.ambTemp) annotation (Line(
        points={{-106,28},{-82,28},{-82,31.47},{-63.8875,31.47}},
                                                                color={0,0,
          127}));
  connect(FlowTempSol, solCirController_TempIrradBased.FlowTempSol)
    annotation (Line(points={{-106,4},{-106,10},{-78,10},{-78,26.53},{
          -63.8875,26.53}}, color={0,0,127}));
  connect(SeasStgBotTemp, solCirController_TempIrradBased.StgTempBott)
    annotation (Line(points={{-106,-22},{-72,-22},{-72,21.85},{-63.8875,21.85}},
        color={0,0,127}));
  connect(FlowTempSol, stgCirController_TempBased.FlowTempSol) annotation (
      Line(points={{-106,4},{-40,4},{-40,7.76},{-7.1,7.76}},     color={0,0,
          127}));
  connect(SeasStgBotTemp, stgCirController_TempBased.StgTempBott) annotation (
     Line(points={{-106,-22},{-24,-22},{-24,3.92},{-7.1,3.92}}, color={0,0,
          127}));
  connect(solCirController_TempIrradBased.MFSolColPump, MFSolCirPump)
    annotation (Line(points={{-27.8875,29},{130,29},{130,76},{188,76}},
                                                                      color={
          0,0,127}));
  connect(setPointBuffStg, stateMachine.setPointStg2) annotation (Line(points={{-106,77},
          {-76,77},{-76,-30.72},{-7.68421,-30.72}},           color={0,0,127}));
  connect(SeasStgTopTemp, stateMachine.Stg1TopTemp) annotation (Line(points={{-107,
          -47},{-58,-47},{-58,-34.4},{-7.76316,-34.4}},       color={0,0,127}));
  connect(stateMachine.ValveOpDir, ValveOpDir) annotation (Line(points={{22.3947,
          -31.28},{144,-31.28},{144,42},{188,42}},
                                                 color={0,0,127}));
  connect(stateMachine.ValveOpIndir, ValveOpIndir) annotation (Line(points={{22.5526,
          -37.84},{148,-37.84},{148,25},{188,25}}, color={0,0,127}));
  connect(TopTempBuffStg, stateMachine.Stg2TopTemp) annotation (Line(points={{-67,-85},
          {-67,-60},{-24,-60},{-24,-28.48},{-7.68421,-28.48}},
        color={0,0,127}));
  connect(stateMachine.MFDirSupp, DirSuppMF) annotation (Line(points={{22.3947,
          -33.68},{130,-33.68},{130,-22},{188,-22}},
                                           color={0,0,127}));
  connect(stateMachine.IndirSuppSignal, hpSignal) annotation (Line(points={{11.5789,
          -51.84},{11.5789,-64},{16,-64},{16,-86}},         color={255,0,255}));
  connect(stateMachine.DirSuppSignal, DirSupp) annotation (Line(points={{8.89474,
          -51.84},{8.89474,-64},{-2,-64},{-2,-86}}, color={255,0,255}));
  connect(solCirController_TempIrradBased.OnOffSolPump, SolColPump) annotation (
     Line(points={{-27.8875,36.15},{-27.8875,36},{14,36},{14,62},{50,62},{50,82}},
        color={255,0,255}));
  connect(stgCirController_TempBased.OnOffStgCirPump, StgCirPump) annotation (
      Line(points={{22.75,11.72},{22.75,12},{72,12},{72,82}}, color={255,0,255}));
  connect(stgCirController_TempBased.OnOffSolPump, SolColPump) annotation (Line(
        points={{-7.1,11.6},{-14,11.6},{-14,36},{14,36},{14,62},{50,62},{50,82}},
        color={255,0,255}));
  connect(stateMachine.CompRPM, hpRPM) annotation (Line(points={{22.3158,-50.24},
          {36,-50.24},{36,-86}},         color={0,0,127}));
  connect(hpCondTemp, stateMachine.HPCondTemp) annotation (Line(points={{-22,-85},
          {-22,-49.28},{-8,-49.28}},      color={0,0,127}));
  connect(stateMachine.evaMF, EvaMF) annotation (Line(points={{22.5526,-40.24},
          {156,-40.24},{156,10},{188,10}}, color={0,0,127}));
  connect(stateMachine.conMF, ConMF) annotation (Line(points={{22.7105,-46},{
          150,-46},{150,-6},{188,-6}}, color={0,0,127}));
  connect(stgCirController_TempBased.MFStgCirPump, MFStgCirPump) annotation (
      Line(points={{22.75,8},{138,8},{138,58},{188,58}},
                                                       color={0,0,127}));
  connect(setPointBuffStg, BackupSystemController.buffStgSetpoint)
    annotation (Line(points={{-106,77},{-56,77},{-56,44},{52,44},{52,-2.45},{
          62.825,-2.45}}, color={0,0,127}));
  connect(FlowTempSDH, BackupSystemController.FlowTempSDH) annotation (Line(
        points={{-107,-74},{-94,-74},{-84,-74},{-84,-11},{62.825,-11}}, color=
         {0,0,127}));
  connect(TopTempBuffStg, BackupSystemController.buffStgTopTemp) annotation (
      Line(points={{-67,-85},{-67,-19.25},{63.125,-19.25}}, color={0,0,127}));
  connect(BackupSystemController.BypassValve, valOpBypass) annotation (Line(
        points={{104.45,-4.325},{164,-4.325},{164,-44},{188,-44}}, color={0,0,
          127}));
  connect(BackupSystemController.AuxValve, valOpAux) annotation (Line(points=
          {{104.45,-11},{130,-11},{130,-62},{188,-62}}, color={0,0,127}));
  connect(DirSuppMF, DirSuppMF) annotation (Line(points={{188,-22},{184,-22},
          {184,-22},{188,-22}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,
            -80},{200,80}}), graphics={Rectangle(
          extent={{-120,80},{200,-80}},
          lineColor={0,0,0},
          fillColor={66,143,244},
          fillPattern=FillPattern.Solid), Text(
          extent={{26,4},{64,-22}},
          lineColor={255,255,255},
          textString="%name
")}),                                       Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-120,-80},{200,80}}), graphics={
          Rectangle(
          extent={{-38,80},{28,72}},
          lineColor={33,130,241},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
          Text(
          extent={{-30,82},{22,64}},
          lineColor={0,0,255},
          fillColor={202,234,243},
          fillPattern=FillPattern.Solid,
          textString="***All temperature inputs should be in Celcius*** 

")}),
    Documentation(info="<html>
<h4>Overview</h4>
<p>This model represents a mode-based controller for the heat generation unit. The controller comprises following blocks: </p>
<ol>
<li>&QUOT;Solar circuit controller&QUOT; block which controls the pump in the solar circuit</li>
<li>&QUOT;Storage circuit controller&QUOT; block which controls the pump in the seasonal storage circuit</li>
<li>&QUOT;StateMachine&QUOT; block in which operation modes are defined</li>
<li>&QUOT;BackupSystemController&QUOT; block which controls control vavles after the buffer storage  </li>
</ol>
</html>"));
end SolarDistrictHeatingController;
