within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Validation.WallCells;
model ConstantControlVolumes
  "Validation model to test the wall's energy balances at constant lengths of 
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
    iniSteSta=false,
    TSCIni=288.15,
    TTPIni=288.15,
    TSHIni=288.15)
    "Wall of a moving boundary heat exchanger"
    annotation (Placement(transformation(extent={{-12,-60},{8,-80}})));

  Utilities.Interfaces.ConstantModeCV modCV(
    forModCV=Utilities.Types.ModeCV.SCTPSH)
    "Provide type of moving boundary heat exchanger"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Sources.Sine lenInp[3](
    each freqHz=1/12.5,
    amplitude={0,0,0},
    phase={0,0,0},
    offset={1/3,1/3,1/3})
    "Provide lengths of different regimes"
    annotation (Placement(transformation(extent={{-100,50},{-80,70}})));
   Modelica.Blocks.Sources.Ramp ramSCPri(
    duration=25,
    height=60,
    offset=273.15)
    "Ramp to provide dummy signal for heat flow of SC regime"
    annotation (Placement(transformation(extent={{-100,-50},{-80,-30}})));
  Modelica.Blocks.Sources.Ramp ramTPPri(
    duration=25,
    height=60,
    offset=283.15)
    "Ramp to provide dummy signal for heat flow of TH regime"
    annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
  Modelica.Blocks.Sources.Ramp ramSHPri(
    duration=25,
    height=60,
    offset=293.15)
    "Ramp to provide dummy signal for heat flow of SH regime"
    annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemSCPri
    "Dummy signal of heat flow of SC regime"
    annotation (Placement(transformation(extent={{-68,-50},{-48,-30}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemTPPri
    "Dummy signal of heat flow of TP regime"
    annotation (Placement(transformation(extent={{-68,-20},{-48,0}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemSHPri
    "Dummy signal of heat flow of SC regime"
    annotation (Placement(transformation(extent={{-68,10},{-48,30}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor theConSCPri(G=25)
    "Heat transfer of SC regime"
    annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor theConTPPri(G=25)
    "Heat transfer of TP regime"
    annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor theConSHPri(G=25)
    "Heat transfer of SH regime"
    annotation (Placement(transformation(extent={{-40,10},{-20,30}})));

   Modelica.Blocks.Sources.Ramp ramSCSec(
    duration=25,
    offset=273.15,
    height=5)
    "Ramp to provide dummy signal for heat flow of SC regime"
    annotation (Placement(transformation(extent={{100,-50},{80,-30}})));
  Modelica.Blocks.Sources.Ramp ramTPSec(
    duration=25,
    offset=278.15,
    height=5)
    "Ramp to provide dummy signal for heat flow of TH regime"
    annotation (Placement(transformation(extent={{100,-20},{80,0}})));
  Modelica.Blocks.Sources.Ramp ramSHSec(
    duration=25,
    offset=283.15,
    height=5)
    "Ramp to provide dummy signal for heat flow of SH regime"
    annotation (Placement(transformation(extent={{100,10},{80,30}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemSCSec
    "Dummy signal of heat flow of SC regime"
    annotation (Placement(transformation(extent={{70,-50},{50,-30}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemTPSec
    "Dummy signal of heat flow of TP regime"
    annotation (Placement(transformation(extent={{70,-20},{50,0}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemSHSec
    "Dummy signal of heat flow of SC regime"
    annotation (Placement(transformation(extent={{70,10},{50,30}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor theConSCSec(G=25)
    "Heat transfer of SC regime"
    annotation (Placement(transformation(extent={{40,-50},{20,-30}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor theConTPSec(G=25)
    "Heat transfer of TP regime"
    annotation (Placement(transformation(extent={{40,-20},{20,0}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor theConSHSec(G=25)
    "Heat transfer of SH regime"
    annotation (Placement(transformation(extent={{40,10},{20,30}})));


equation
  // Connection of lengths and mode
  //
  connect(lenInp.y, wal.lenInl)
    annotation (Line(points={{-79,60},{3,60},{3,-60}}, color={0,0,127}));
  connect(modCV.ModCV, wal.modCV)
    annotation (Line(points={{-79.8,90},{5,90},{5,-60}}, color={0,0,127}));

  // Connection of prescribed heat flows
  //
  connect(ramSCPri.y, preTemSCPri.T)
    annotation (Line(points={{-79,-40},{-70,-40}}, color={0,0,127}));
  connect(ramTPPri.y, preTemTPPri.T)
    annotation (Line(points={{-79,-10},{-70,-10}}, color={0,0,127}));
  connect(ramSHPri.y, preTemSHPri.T)
    annotation (Line(points={{-79,20},{-70,20}}, color={0,0,127}));
  connect(preTemSCPri.port, theConSCPri.port_a)
    annotation (Line(points={{-48,-40},{-40,-40}}, color={191,0,0}));
  connect(preTemTPPri.port, theConTPPri.port_a)
    annotation (Line(points={{-48,-10},{-40,-10}}, color={191,0,0}));
  connect(preTemSHPri.port, theConSHPri.port_a)
    annotation (Line(points={{-48,20},{-40,20}}, color={191,0,0}));
  connect(theConSCPri.port_b, wal.heatPortSCPri)
    annotation (Line(points={{-20,-40},{-4.6,-40},{-4.6,-60}}, color={191,0,0}));
  connect(theConTPPri.port_b, wal.heatPortTPPri)
    annotation (Line(points={{-20,-10},{-2,-10},{-2,-60}}, color={191,0,0}));
  connect(theConSHPri.port_b, wal.heatPortSHPri)
    annotation (Line(points={{-20,20},{0.6,20},{0.6,-60}}, color={191,0,0}));

  connect(ramSCSec.y, preTemSCSec.T)
    annotation (Line(points={{79,-40},{76,-40},{72,-40}}, color={0,0,127}));
  connect(ramTPSec.y, preTemTPSec.T)
    annotation (Line(points={{79,-10},{72,-10}}, color={0,0,127}));
  connect(ramSHSec.y, preTemSHSec.T)
    annotation (Line(points={{79,20},{76,20},{72,20}}, color={0,0,127}));
  connect(preTemSCSec.port, theConSCSec.port_a)
    annotation (Line(points={{50,-40},{50,-40},{40,-40}}, color={191,0,0}));
  connect(preTemTPSec.port, theConTPSec.port_a)
    annotation (Line(points={{50,-10},{50,-10},{40,-10}}, color={191,0,0}));
  connect(preTemSHSec.port, theConSHSec.port_a)
    annotation (Line(points={{50,20},{50,20},{40,20}}, color={191,0,0}));
  connect(theConSCSec.port_b, wal.heatPortSCSec)
    annotation (Line(points={{20,-40},{16,-40},{16,-94},{-4.6,-94},{-4.6,-80}},
                color={191,0,0}));
  connect(theConTPSec.port_b, wal.heatPortTPSec)
    annotation (Line(points={{20,-10},{14,-10},{14,-92},{-2,-92},{-2,-80}},
                color={191,0,0}));
  connect(theConSHSec.port_b, wal.heatPortSHSec)
    annotation (Line(points={{20,20},{18,20},{12,20},{12,-90},{0.6,-90},
                {0.6,-80}}, color={191,0,0}));


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
lengths of the control volumes are prescribed and do not vary with time.
</p>
</html>"));
end ConstantControlVolumes;
