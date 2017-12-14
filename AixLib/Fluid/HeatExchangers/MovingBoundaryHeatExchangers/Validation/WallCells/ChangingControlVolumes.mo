within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Validation.WallCells;
model ChangingControlVolumes "Validation model to test the wall's energy balances at variable lengths of 
  the control volumes"
  extends Modelica.Icons.Example;

  // Definition of subcomponents and connectors
  //
  Utilities.WallCells.SimpleWallCell wal(
    geoCV(
      CroSecGeo=Utilities.Types.GeometryCV.Circular,
      nFloCha=50,
      lFloCha=1,
      dFloChaCir=0.015),
    matHX(
      dWal=8000,
      cpWal=485),
    tauTem=0.1,
    iniSteSta=true,
    TSCIni=288.15,
    TTPIni=288.15,
    TSHIni=288.15)
    "Wall of a moving boundary heat exchanger"
    annotation (Placement(transformation(extent={{-12,-50},{8,-70}})));

  Modelica.Blocks.Sources.Sine lenInp[3](
    each freqHz=1/12.5,
    phase={0,0,0},
    offset={1/3,1/3,1/3},
    amplitude={1/3 - 0.001,-1/3 + 0.001,0})
    "Provide lengths of different regimes"
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
   Modelica.Blocks.Sources.Ramp ramSCPri(
    duration=25,
    height=60,
    offset=273.15)
    "Ramp to provide dummy signal for heat flow of SC regime"
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Modelica.Blocks.Sources.Ramp ramTPPri(
    duration=25,
    height=60,
    offset=283.15)
    "Ramp to provide dummy signal for heat flow of TH regime"
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Modelica.Blocks.Sources.Ramp ramSHPri(
    duration=25,
    height=60,
    offset=293.15)
    "Ramp to provide dummy signal for heat flow of SH regime"
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemSCPri
    "Dummy signal of heat flow of SC regime"
    annotation (Placement(transformation(extent={{-68,-40},{-48,-20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemTPPri
    "Dummy signal of heat flow of TP regime"
    annotation (Placement(transformation(extent={{-68,-10},{-48,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemSHPri
    "Dummy signal of heat flow of SC regime"
    annotation (Placement(transformation(extent={{-68,20},{-48,40}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor theConSCPri(G=25)
    "Heat transfer of SC regime"
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor theConTPPri(G=25)
    "Heat transfer of TP regime"
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor theConSHPri(G=25)
    "Heat transfer of SH regime"
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));

   Modelica.Blocks.Sources.Ramp ramSCSec(
    duration=25,
    offset=273.15,
    height=5)
    "Ramp to provide dummy signal for heat flow of SC regime"
    annotation (Placement(transformation(extent={{100,-40},{80,-20}})));
  Modelica.Blocks.Sources.Ramp ramTPSec(
    duration=25,
    offset=278.15,
    height=5)
    "Ramp to provide dummy signal for heat flow of TH regime"
    annotation (Placement(transformation(extent={{100,-10},{80,10}})));
  Modelica.Blocks.Sources.Ramp ramSHSec(
    duration=25,
    offset=283.15,
    height=5)
    "Ramp to provide dummy signal for heat flow of SH regime"
    annotation (Placement(transformation(extent={{100,20},{80,40}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemSCSec
    "Dummy signal of heat flow of SC regime"
    annotation (Placement(transformation(extent={{70,-40},{50,-20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemTPSec
    "Dummy signal of heat flow of TP regime"
    annotation (Placement(transformation(extent={{70,-10},{50,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemSHSec
    "Dummy signal of heat flow of SC regime"
    annotation (Placement(transformation(extent={{70,20},{50,40}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor theConSCSec(G=25)
    "Heat transfer of SC regime"
    annotation (Placement(transformation(extent={{40,-40},{20,-20}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor theConTPSec(G=25)
    "Heat transfer of TP regime"
    annotation (Placement(transformation(extent={{40,-10},{20,10}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor theConSHSec(G=25)
    "Heat transfer of SH regime"
    annotation (Placement(transformation(extent={{40,20},{20,40}})));


initial equation
  wal.modCV = Utilities.Types.ModeCV.SCTPSH
    "Set flow state at initialisation";


equation
  // Definition of dummy state machine
  //
  when time>9.3 then
      reinit(wal.TTP,wal.TTP);
      wal.modCV=Utilities.Types.ModeCV.TPSH;
  end when;

  // Connection of lengths and mode
  //
  connect(lenInp.y, wal.lenInl)
    annotation (Line(points={{-79,70},{3,70},{3,-50}}, color={0,0,127}));

  // Connection of prescribed heat flows
  //
  connect(ramSCPri.y, preTemSCPri.T)
    annotation (Line(points={{-79,-30},{-70,-30}}, color={0,0,127}));
  connect(ramTPPri.y, preTemTPPri.T)
    annotation (Line(points={{-79,0},{-70,0}},     color={0,0,127}));
  connect(ramSHPri.y, preTemSHPri.T)
    annotation (Line(points={{-79,30},{-70,30}}, color={0,0,127}));
  connect(preTemSCPri.port, theConSCPri.port_a)
    annotation (Line(points={{-48,-30},{-40,-30}}, color={191,0,0}));
  connect(preTemTPPri.port, theConTPPri.port_a)
    annotation (Line(points={{-48,0},{-40,0}},     color={191,0,0}));
  connect(preTemSHPri.port, theConSHPri.port_a)
    annotation (Line(points={{-48,30},{-40,30}}, color={191,0,0}));
  connect(theConSCPri.port_b, wal.heatPortSCPri)
    annotation (Line(points={{-20,-30},{-4.6,-30},{-4.6,-50}}, color={191,0,0}));
  connect(theConTPPri.port_b, wal.heatPortTPPri)
    annotation (Line(points={{-20,0},{-2,0},{-2,-50}},     color={191,0,0}));
  connect(theConSHPri.port_b, wal.heatPortSHPri)
    annotation (Line(points={{-20,30},{0.6,30},{0.6,-50}}, color={191,0,0}));

  connect(ramSCSec.y, preTemSCSec.T)
    annotation (Line(points={{79,-30},{76,-30},{72,-30}}, color={0,0,127}));
  connect(ramTPSec.y, preTemTPSec.T)
    annotation (Line(points={{79,0},{72,0}},     color={0,0,127}));
  connect(ramSHSec.y, preTemSHSec.T)
    annotation (Line(points={{79,30},{76,30},{72,30}}, color={0,0,127}));
  connect(preTemSCSec.port, theConSCSec.port_a)
    annotation (Line(points={{50,-30},{50,-30},{40,-30}}, color={191,0,0}));
  connect(preTemTPSec.port, theConTPSec.port_a)
    annotation (Line(points={{50,0},{50,0},{40,0}},       color={191,0,0}));
  connect(preTemSHSec.port, theConSHSec.port_a)
    annotation (Line(points={{50,30},{50,30},{40,30}}, color={191,0,0}));
  connect(theConSCSec.port_b, wal.heatPortSCSec)
    annotation (Line(points={{20,-30},{16,-30},{16,-84},{-4.6,-84},{-4.6,-70}},
                color={191,0,0}));
  connect(theConTPSec.port_b, wal.heatPortTPSec)
    annotation (Line(points={{20,0},{14,0},{14,-82},{-2,-82},{-2,-70}},
                color={191,0,0}));
  connect(theConSHSec.port_b, wal.heatPortSHSec)
    annotation (Line(points={{20,30},{18,30},{12,30},{12,-80},{0.6,-80},{0.6,
          -70}},            color={191,0,0}));

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  December 09, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/516\">issue 516</a>).
  </li>
</ul>
</html>", info="<html>
<p>
This model is a validation model to check the simple wall cell. Therefore, the
lengths of the control volumes are prescribed and vary with time. In consequence,
the current flow state may be change.<br/><br/>
In order to change the flow state, a self-made state machine is introduced. This
state machine is not sensible, however, demonstrates how to add a state machine that
is not modelled within one component. Therefore, the <code>reinit()-operator</code>
calls a state variable of the subcomponent <code>wal</code> within a <code>when()-
clause</code>. The same approach is implemented for the simple moving boundary
heat exchanger stored in
<a href=\"modelica://AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.SimpleHeatExchangers\">
AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.SimpleHeatExchangers.</a>
</p>
</html>"), experiment(StopTime=10));
end ChangingControlVolumes;
