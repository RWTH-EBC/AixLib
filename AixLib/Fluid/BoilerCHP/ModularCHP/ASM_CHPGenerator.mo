within AixLib.Fluid.BoilerCHP.ModularCHP;
model ASM_CHPGenerator
  "AsynchronousInductionMachineSquirrelCage for CHP"
  import ModularCHP;

  constant Integer m=3 "Number of phases";
  parameter Modelica.SIunits.Voltage VNominal=100
    "Nominal RMS voltage per phase";
  parameter Modelica.SIunits.Frequency fNominal=50 "Nominal frequency";
 // parameter Modelica.SIunits.Time tStart1=0   "Start time";
 // parameter Modelica.SIunits.Torque TLoad=100.78  "Nominal load torque";
 // parameter Modelica.SIunits.AngularVelocity wLoad=1535*2*Modelica.Constants.pi/60  "Nominal load speed";
  parameter Modelica.SIunits.Inertia JLoad=0.29
    "Load's moment of inertia";
  Modelica.Electrical.Machines.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage
    aimc(
    p=aimcData.p,
    fsNominal=aimcData.fsNominal,
    TsRef=aimcData.TsRef,
    alpha20s(displayUnit="1/K") = aimcData.alpha20s,
    Lszero=aimcData.Lszero,
    Lssigma=aimcData.Lssigma,
    Jr=aimcData.Jr,
    Js=aimcData.Js,
    frictionParameters=aimcData.frictionParameters,
    phiMechanical(fixed=true),
    wMechanical(fixed=true),
    statorCoreParameters=aimcData.statorCoreParameters,
    strayLoadParameters=aimcData.strayLoadParameters,
    Lm=aimcData.Lm,
    Lrsigma=aimcData.Lrsigma,
    TrRef=aimcData.TrRef,
    useThermalPort=true,
    TsOperational=293.15,
    Rs=aimcData.Rs,
    Rr=aimcData.Rr,
    alpha20r=aimcData.alpha20r,
    TrOperational=293.15)
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
  Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={0,24})));
  Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage(
    final m=m,
    freqHz=fill(fNominal, m),
    V=fill(sqrt(2/3)*VNominal, m)) annotation (Placement(transformation(
        origin={0,76},
        extent={{10,-10},{-10,10}},
        rotation=270)));
  Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) annotation (
      Placement(transformation(extent={{-50,80},{-70,100}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-90,90},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
    annotation (Placement(transformation(extent={{18,-50},{38,-30}})));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox(
      terminalConnection="D")
    annotation (Placement(transformation(extent={{-20,-34},{0,-14}})));
  parameter
    Modelica.Electrical.Machines.Utilities.ParameterRecords.AIM_SquirrelCageData
    aimcData annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
  Modelica.Electrical.Machines.Sensors.ElectricalPowerSensor
    electricalPowerSensor annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={0,-4})));
  Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor
    annotation (Placement(transformation(extent={{50,-50},{70,-30}})));
  Modelica.Electrical.Machines.Thermal.AsynchronousInductionMachines.ThermalAmbientAIMC
    thermalAmbientAIMC(Ts=353.15, Tr=393.15) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-84,-50})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange "Shaft"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
initial equation
  aimc.is = zeros(3);
  aimc.ir = zeros(2);
equation
  connect(star.pin_n, ground.p)
    annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
  connect(sineVoltage.plug_n, star.plug_p)
    annotation (Line(points={{0,86},{0,90},{-50,90}}, color={0,0,255}));
  connect(terminalBox.plug_sn, aimc.plug_sn) annotation (Line(
      points={{-16,-30},{-16,-30}},
      color={0,0,255}));
  connect(terminalBox.plug_sp, aimc.plug_sp) annotation (Line(
      points={{-4,-30},{-4,-30}},
      color={0,0,255}));
  connect(aimc.flange, loadInertia.flange_a)
    annotation (Line(points={{0,-40},{18,-40}}, color={0,0,0}));
  connect(loadInertia.flange_b, powerSensor.flange_a)
    annotation (Line(points={{38,-40},{50,-40}}, color={0,0,0}));
  connect(terminalBox.plugSupply, electricalPowerSensor.plug_p) annotation (
      Line(points={{-10,-28},{-10,-20},{0,-20},{0,-14}}, color={0,0,255}));
  connect(electricalPowerSensor.plug_ni, currentQuasiRMSSensor.plug_n)
    annotation (Line(points={{0,6},{0,14}}, color={0,0,255}));
  connect(thermalAmbientAIMC.thermalPort, aimc.thermalPort) annotation (Line(
        points={{-74,-50},{-48,-50},{-48,-50},{-42,-50},{-42,-50},{-10,-50},{-10,
          -50}}, color={191,0,0}));
  connect(powerSensor.flange_b, flange) annotation (Line(points={{70,-40},{80,-40},
          {80,0},{100,0}}, color={0,0,0}));
  connect(sineVoltage.plug_p, currentQuasiRMSSensor.plug_p)
    annotation (Line(points={{0,66},{0,34}}, color={0,0,255}));
  connect(electricalPowerSensor.plug_nv, star.plug_p) annotation (Line(points={{
          10,-4},{30,-4},{30,90},{-50,90}}, color={0,0,255}));
  annotation (experiment(StopTime=1.5, Interval=0.001), Documentation(
        info="<html>
<b>Test example: Asynchronous induction machine with squirrel cage - direct on line starting</b><br>
At start time tStart three phase voltage is supplied to the asynchronous induction machine with squirrel cage;
the machine starts from standstill, accelerating inertias against load torque quadratic dependent on speed, finally reaching nominal speed.<br>
Simulate for 1.5 seconds and plot (versus time):
<ul>
<li>currentQuasiRMSSensor.I: stator current RMS</li>
<li>aimc.wMechanical: motor's speed</li>
<li>aimc.tauElectrical: motor's torque</li>
</ul>
Default machine parameters of model <i>AIM_SquirrelCage</i> are used.
</html>"),
    Icon(graphics={
        Rectangle(
          extent={{-40,60},{80,-60}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,128,255}),
        Rectangle(
          extent={{-40,60},{-60,-60}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={128,128,128}),
        Rectangle(
          extent={{80,10},{100,-10}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={95,95,95}),
        Rectangle(
          extent={{-40,70},{40,50}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-50,-90},{-40,-90},{-10,-20},{40,-20},{70,-90},{80,-90},
              {80,-100},{-50,-100},{-50,-90}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{80,-80},{120,-120}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(
          visible=not useSupport,
          points={{80,-100},{120,-100}}),
        Line(
          visible=not useSupport,
          points={{90,-100},{80,-120}}),
        Line(
          visible=not useSupport,
          points={{100,-100},{90,-120}}),
        Line(
          visible=not useSupport,
          points={{110,-100},{100,-120}}),
        Line(
          visible=not useSupport,
          points={{120,-100},{110,-120}})}));
end ASM_CHPGenerator;
