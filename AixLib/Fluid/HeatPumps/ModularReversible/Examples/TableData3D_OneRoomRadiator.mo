within AixLib.Fluid.HeatPumps.ModularReversible.Examples;
model TableData3D_OneRoomRadiator
  "Large scale water to water heat pump with 3D data"
  extends Modelica.Icons.Example;
  extends BaseClasses.PartialOneRoomRadiator(
    mEva_flow_nominal=heaPum.mEva_flow_nominal,
    mCon_flow_nominal=heaPum.mCon_flow_nominal,
    V=6*100*3,
    witCoo=true,
    mAirRoo_flow_nominal=V*1.2*6/3600*10,
    Q_flow_nominal=200000,
    sin(nPorts=1),
    booToReaPumEva(realTrue=heaPum.mEva_flow_nominal),
    pumHeaPumSou(dp_nominal=150000),
    pumHeaPum(dp_nominal=150000),
    sou(use_T_in=true),
    cooLoa(amplitude=0));

  Modular                                                         heaPum(
    redeclare package MediumCon = MediumWat,
    redeclare package MediumEva = MediumWat,
    use_rev=false,
    allowDifferentDeviceIdentifiers=true,
    dTCon_nominal=8,
    use_conCap=false,
    dTEva_nominal=5,
    use_evaCap=false,
    QHea_flow_nominal=Q_flow_nominal,
    use_intSafCtr=true,
    redeclare model RefrigerantCycleHeatPumpHeating =
        AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.TableData3D (
        PEle_nominal=1000,
        scaFac=1,
        extrapMethod=SDF.Types.ExtrapolationMethod.Hold,
        redeclare
          AixLib.Fluid.HeatPumps.ModularReversible.Data.TableDataSDF.TableData3D.VZH088AG
          datTab),
    TConHea_nominal=TRadSup_nominal,
    dpCon_nominal(displayUnit="kPa") = 40000,
    TEvaHea_nominal=sou.T,
    dpEva_nominal(displayUnit="kPa") = 40000,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    redeclare AixLib.Fluid.HeatPumps.ModularReversible.Controls.Safety.Data.Wuellhorst2021
      safCtrPar,
    TConCoo_nominal=273.15,
    TEvaCoo_nominal=273.15)
    "Large scale water to water heat pump"
    annotation (Placement(transformation(extent={{20,-160},{0,-140}})));
  Modelica.Blocks.Sources.Pulse TAirSouSte(
    amplitude=20,
    width=10,
    period=86400,
    offset=283.15,
    startTime=86400/2) if witCoo "Air source temperature step for cooling phase"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-150,-200})));
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
  annotation (
     __Dymola_Commands(file=
     "modelica://AixLib/Resources/Scripts/Dymola/Fluid/HeatPumps/ModularReversible/Examples/TableData3D_OneRoomRadiator.mos"
        "Simulate and plot"),
  experiment(
      StartTime=0,
      StopTime=86400,
      Tolerance=1e-08),
  Documentation(
   info="<html>
<p>
  This example demonstrates how to use the
  <a href=\"modelica://AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.TableData3D\">
  AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.TableData3D</a>
  refrigerant cycle model. Please check the associated documentation for
  further information.
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
end TableData3D_OneRoomRadiator;
