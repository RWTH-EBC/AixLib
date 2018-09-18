within AixLib.Systems.HeatPumpSystems;
model HeatPumpSystem
  extends AixLib.Systems.HeatPumpSystems.BaseClasses.partialHeatPumpSystem(
      redeclare Fluid.HeatPumps.HeatPump heatPump(
      final initType=initType,
      final pCon_start=pCon_start,
      final TCon_start=TCon_start,
      final XCon_start=XCon_start,
      final pEva_start=pEva_start,
      final TEva_start=TEva_start,
      final XEva_start=XEva_start,
      final x_start=x_start,
      final yRefIne_start=yRefIne_start,
      final massDynamics=massDynamics,
      final energyDynamics=energyDynamics,
      final mSenFacCon=mSenFacCon,
      final mSenFacEva=mSenFacEva,
      final refIneFre_constant=refIneFre_constant,
      final nthOrder=nthOrder,
      final mFlow_conNominal=mFlow_conNominal,
      final VCon=VCon,
      final dpCon_nominal=dpCon_nominal,
      final deltaM_con=deltaM_con,
      final CCon=CCon,
      final GCon=GCon,
      final mFlow_evaNominal=mFlow_evaNominal,
      final VEva=VEva,
      final dpEva_nominal=dpEva_nominal,
      final deltaM_eva=deltaM_eva,
      final CEva=CEva,
      final GEva=GEva,
      final allowFlowReversalEva=allowFlowReversalEva,
      final allowFlowReversalCon=allowFlowReversalCon,
      final tauSenT=tauSenT,
      final tauHeaTra=tauHeaTra,
      final TAmbCon_nom=TAmbCon_nom,
      final TAmbEva_nom=TAmbEva_nom,
      final use_ConCap=use_conCap,
      final use_EvaCap=use_evaCap,
      final use_refIne=use_refIne,
      final transferHeat=transferHeat,
      final scalingFactor=scalingFactor,
      redeclare final package Medium_con = Medium_con,
      redeclare final package Medium_eva = Medium_eva,
      redeclare final model PerDataHea = PerDataHea,
      redeclare final model PerDataChi = PerDataChi), final calcQHeat(final y=
          heatPump.sigBusHP.m_flow_co*(senTSup.T - heatPump.sigBusHP.T_flow_co)
          *4180));
//Heat Pump
  parameter Boolean use_revHP=true "True if the HP is reversible" annotation(Dialog(tab="Heat Pump"),choices(choice=true "reversible HP",
      choice=false "only heating",
      radioButtons=true));
  replaceable model PerDataHea =
      Fluid.HeatPumps.BaseClasses.PerformanceData.LookUpTable2D constrainedby
    AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.BaseClasses.PartialPerformanceData
  "Performance data of HP in heating mode"
    annotation (Dialog(tab="Heat Pump"),choicesAllMatching=true);

  replaceable model PerDataChi =
      Fluid.HeatPumps.BaseClasses.PerformanceData.LookUpTable2D constrainedby
    AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.BaseClasses.PartialPerformanceData
  "Performance data of HP in chilling mode"
    annotation (Dialog(tab="Heat Pump",enable=use_revHP), choicesAllMatching=true);
  parameter Real scalingFactor=1 "Scaling-factor of HP" annotation(Dialog(tab="Heat Pump"));
  parameter Boolean use_refIne=false "Consider the inertia of the refrigerant cycle"
    annotation (Dialog(tab="Heat Pump",group="Refrigerant cycle inertia"), choices(checkBox=true));
  constant Modelica.SIunits.Frequency refIneFre_constant
    "Cut off frequency representing inertia of refrigerant cycle"
    annotation (Dialog(tab="Heat Pump",group="Refrigerant cycle inertia", enable=use_refIne));
  parameter Integer nthOrder=3 "Order of refrigerant cycle interia"
    annotation (Dialog(tab="Heat Pump",group="Refrigerant cycle inertia", enable=use_refIne));
//Condenser/Evaporator
  parameter Modelica.SIunits.MassFlowRate mFlow_conNominal
    "Nominal mass flow rate, used for regularization near zero flow"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Condenser"));

  parameter Modelica.SIunits.Volume VCon "Volume in condenser"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Condenser"));
  parameter Modelica.SIunits.Volume VEva "Volume in evaporator"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Evaporator"));
  parameter Modelica.SIunits.PressureDifference dpEva_nominal
    "Pressure drop at nominal mass flow rate"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Evaporator"));
  parameter Modelica.SIunits.PressureDifference dpCon_nominal
    "Pressure drop at nominal mass flow rate"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Condenser"));
  parameter Real deltaM_con=0.1
    "Fraction of nominal mass flow rate where transition to turbulent occurs"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Condenser"));
  parameter Real deltaM_eva=0.1
    "Fraction of nominal mass flow rate where transition to turbulent occurs"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Evaporator"));

  parameter Boolean use_conCap=false
    "If heat losses at capacitor side are considered or not"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Condenser"),
                                          choices(checkBox=true));
  parameter Boolean use_evaCap=false
    "If heat losses at capacitor side are considered or not"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Evaporator"),
                                          choices(checkBox=true));
  parameter Modelica.SIunits.HeatCapacity CEva
    "Heat capacity of Evaporator (= cp*m)"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Evaporator",
      enable=use_evaCap));
  parameter Modelica.SIunits.ThermalConductance GEva
    "Constant thermal conductance of Evaporator material"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Evaporator",
      enable=use_evaCap));
  parameter Modelica.SIunits.HeatCapacity CCon
    "Heat capacity of Condenser (= cp*m)"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Condenser",
      enable=use_conCap));
  parameter Modelica.SIunits.ThermalConductance GCon
    "Constant thermal conductance of condenser material"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Condenser",
      enable=use_conCap));
//Dynamics
  parameter Real x_start[nthOrder]=zeros(nthOrder)
    "Initial or guess values of states"
    annotation (Dialog(tab="Initialization", group="System inertia", enable=use_refIne));
  parameter Real yRefIne_start=0 "Initial or guess value of output (= state)"
    annotation (Dialog(tab="Initialization", group="System inertia",enable=initType ==
          Init.InitialOutput and use_refIne));
  Fluid.HeatPumps.BaseClasses.PerformanceData.IcingBlock icingBlock if
    use_deFro
    annotation (Placement(transformation(extent={{-72,-74},{-62,-64}})));
  Modelica.Blocks.Sources.Constant constIceFacOne(final k=1) if not use_deFro
    "If defrost is neglacted, iceFac is constant 1"
    annotation (Placement(transformation(extent={{-72,-88},{-62,-78}})));
  Modelica.Blocks.Sources.Constant const(final k=273.15) annotation (Placement(
        transformation(
        extent={{-7,-7},{7,7}},
        rotation=180,
        origin={41,-3})));
equation
  connect(realPasThrSec.y, heatPump.nSet) annotation (Line(
      points={{-77.3,-39},{-40,-39},{-40,4},{-25.84,4}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(securityControl.nOut, heatPump.nSet) annotation (Line(
      points={{-70.75,-6},{-46,-6},{-46,4},{-25.84,4}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(securityControl.modeOut, heatPump.modeSet) annotation (Line(points={{
          -70.75,-12},{-46,-12},{-46,-4},{-25.84,-4}}, color={255,0,255}));
  connect(sigBusHP, heatPump.sigBusHP) annotation (Line(
      points={{-93,-67},{-92,-67},{-92,-54},{-34,-54},{-34,-7.8},{-21.76,-7.8}},

      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));

  connect(icingBlock.iceFac, heatPump.iceFac_in) annotation (Line(
      points={{-61.5,-69},{-16.24,-69},{-16.24,-27.2}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(constIceFacOne.y, heatPump.iceFac_in) annotation (Line(
      points={{-61.5,-83},{-16.24,-83},{-16.24,-27.2}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(sigBusHP.T_flow_ev, icingBlock.T_flow_ev) annotation (Line(
      points={{-92.925,-66.915},{-78,-66.915},{-78,-68},{-72.4,-68}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBusHP.T_oda, icingBlock.T_oda) annotation (Line(
      points={{-92.925,-66.915},{-84,-66.915},{-84,-66},{-72.4,-66}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sigBusHP.T_ret_ev, icingBlock.T_ret_ev) annotation (Line(
      points={{-92.925,-66.915},{-78,-66.915},{-78,-70},{-72.4,-70}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBusHP.m_flow_ev, icingBlock.m_flow_ev) annotation (Line(
      points={{-92.925,-66.915},{-78,-66.915},{-78,-72},{-72.4,-72}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(const.y, heatPump.T_amb_con) annotation (Line(points={{33.3,-3},{33.3,
          20.5},{28.4,20.5},{28.4,20}}, color={0,0,127}));
  connect(const.y, heatPump.T_amb_eva) annotation (Line(points={{33.3,-3},{33.3,
          -12},{34,-12},{34,-20},{28.4,-20}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HeatPumpSystem;
