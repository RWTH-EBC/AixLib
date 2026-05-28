within AixLib.Fluid.HeatPumps.ModularReversible.Examples;
model VCLib4DAirToWater_OneRoomRadiator
  "Air to water heat pump with 4D data based on VCLib"
  extends Modelica.Icons.Example;
  extends BaseClasses.PartialOneRoomRadiator(
    mEva_flow_nominal=heaPum.mEva_flow_nominal,
    mCon_flow_nominal=heaPum.mCon_flow_nominal,
    witCoo=false,
    sin(nPorts=1, redeclare package Medium = MediumAir),
    pumHeaPumSou(
    dp_nominal=heaPum.dpEva_nominal,
      redeclare package Medium = MediumAir),
    sou(use_T_in=true,
      redeclare package Medium = MediumAir),
    pumHeaPum(dp_nominal=heaPum.dpCon_nominal),
    booToReaPumEva(realTrue=heaPum.mEva_flow_nominal),
    oneRooRadHeaPumCtr(PIDHea(k=0.08)));

  AixLib.Fluid.HeatPumps.ModularReversible.Modular heaPum(
    redeclare package MediumCon = MediumWat,
    redeclare package MediumEva = MediumAir,
    use_rev=true,
    allowDifferentDeviceIdentifiers=true,
    dTCon_nominal=8,
    use_conCap=false,
    dTEva_nominal=3,
    use_evaCap=false,
    QHea_flow_nominal=Q_flow_nominal,
    use_intSafCtr=true,
    QCoo_flow_nominal=-heaPum.refCyc.refCycHeaPumCoo.COP_constant*heaPum.refCyc.refCycHeaPumCoo.PEle_nominal
        *heaPum.refCyc.refCycHeaPumCoo.y_constant,
    redeclare model RefrigerantCycleHeatPumpHeating =
        AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.TableData4DDeltaT
        (redeclare
          AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.Frosting.LiangAndZhuCalibrated
          iceFacCal, redeclare
          AixLib.Fluid.HeatPumps.ModularReversible.Data.TableDataSDF.TableData4DDeltaTCon.VCLibPy.EN_MEN412_Linear
          datTab),
    redeclare model RefrigerantCycleHeatPumpCooling =
        AixLib.Fluid.HeatPumps.ModularReversible.Controls.Defrost.ReverseCycleDefrostHeatPump,
    TConHea_nominal=TRadSup_nominal,
    dpCon_nominal(displayUnit="Pa") = 2000,
    TEvaHea_nominal=sou.T,
    dpEva_nominal(displayUnit="Pa") = 200,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    redeclare AixLib.Fluid.HeatPumps.ModularReversible.Controls.Safety.Data.Wuellhorst2021
      safCtrPar,
    TConCoo_nominal=sou.T,
    TEvaCoo_nominal=TRadSup_nominal)
    "Large scale water to water heat pump"
    annotation (Placement(transformation(extent={{20,-160},{0,-140}})));
  Modelica.Blocks.Sources.Pulse TAirSouSte(
    amplitude=5,
    width=10,
    period=86400,
    offset=275.15,
    startTime=86400/2)           "Air source temperature step for cooling phase"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-150,-200})));
  Controls.Defrost.ZhuTimeBasedDefrost zhuDef
    annotation (Placement(transformation(extent={{80,-180},{60,-160}})));
  AixLib.Fluid.HeatPumps.ModularReversible.BaseClasses.RefrigerantMachineControlBus
    sigBusHeaPum
    "Bus with the most relevant information for hp frosting calculation"
    annotation (Placement(transformation(extent={{68,-106},{108,-66}}),
        iconTransformation(extent={{68,-106},{108,-66}})));
  Modelica.Blocks.Routing.RealPassThrough reaPasThr "To connect bus signals"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-150,10})));
equation
  connect(heaPum.port_b2, sin.ports[1]) annotation (Line(points={{20,-156},{38,
          -156},{38,-200},{60,-200}},               color={0,127,255}));
  connect(heaPum.port_a2, pumHeaPumSou.port_b) annotation (Line(
        points={{0,-156},{-30,-156},{-30,-170}}, color={0,127,255}));
  connect(heaPum.port_b1, pumHeaPum.port_a) annotation (Line(
        points={{0,-144},{-70,-144},{-70,-120}}, color={0,127,255}));
  connect(heaPum.port_a1, temRet.port_b) annotation (Line(points={{20,-144},{60,
          -144},{60,-30}},                color={0,127,255}));
  connect(oneRooRadHeaPumCtr.ySet, heaPum.ySet) annotation (Line(
        points={{-139.167,-66.6667},{26,-66.6667},{26,-148.1},{21.1,-148.1}},
                                                                        color={
          0,0,127}));
  connect(TAirSouSte.y, sou.T_in) annotation (Line(points={{-139,-200},{-92,-200},
          {-92,-196},{-82,-196}}, color={0,0,127}));
  connect(zhuDef.hea, heaPum.hea) annotation (Line(points={{59,-170},{42,-170},{
          42,-152.1},{21.1,-152.1}}, color={255,0,255}));
  connect(zhuDef.sigBus, sigBusHeaPum) annotation (Line(
      points={{80.2,-170},{88,-170},{88,-86}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(heaPum.sigBus, sigBusHeaPum) annotation (Line(
      points={{19.9,-153.9},{68,-153.9},{68,-86},{88,-86}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(reaPasThr.u, weaBus.relHum) annotation (Line(points={{-150,22},{-150,
          36},{-150,50.05},{-149.95,50.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(reaPasThr.y, sigBusHeaPum.relHum) annotation (Line(points={{-150,-1},
          {-152,-1},{-152,-48},{88,-48},{88,-86}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(heaPum.QEva_flow, sigBusHeaPum.QEva_flow) annotation (Line(points={{
          -1,-159},{-20,-159},{-20,-86},{88,-86}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (
     __Dymola_Commands(file=
     "modelica://AixLib/Resources/Scripts/Dymola/Fluid/HeatPumps/ModularReversible/Examples/VCLib4DAirToWater_OneRoomRadiator.mos"
        "Simulate and plot"),
  experiment(
      StartTime=0,
      StopTime=86400,
      Tolerance=1e-08),
  Documentation(
   info="<html>
<p>
  This example demonstrates how to use the
  <a href=\"modelica://AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.TableData4DDeltaT\">
  AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.TableData4DDeltaT</a>
  refrigerant cycle model with dynamic frosting and defrosting models. 
  Please check the associated documentation for further information.
</p>
<p>
Note, it is important to add the <code>QEva_flow</code> and <code>relHum</code> to the signal bus in order for the frosting models to work properly.
</p>
<p>
  Please check the documentation of
  <a href=\"modelica://AixLib.Fluid.HeatPumps.ModularReversible.Examples.BaseClasses.PartialOneRoomRadiator\">
  AixLib.Fluid.HeatPumps.ModularReversible.Examples.BaseClasses.PartialOneRoomRadiator</a>
  for further information on the example.
</p>
</html>", revisions="<html>
<ul>
<li>
  <i>August 27, 2024</i> by Fabian Wuellhorst:<br/>
  First implementation (see issue <a href=
  \"https://github.com/ibpsa/modelica-ibpsa/issues/1576\">#1576</a>)
</li>
</ul>
</html>"),
    Diagram(coordinateSystem(extent={{-240,-220},{100,100}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
end VCLib4DAirToWater_OneRoomRadiator;
