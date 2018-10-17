within AixLib.Systems.HeatPumpSystems;
model HeatPumpSystem
  extends AixLib.Systems.HeatPumpSystems.BaseClasses.PartialHeatPumpSystem(
    redeclare Fluid.HeatPumps.HeatPump heatPump(
      final initType=initType,
      final pCon_start=pCon_start,
      final TCon_start=TCon_start,
      final XCon_start=XCon_start,
      final pEva_start=pEva_start,
      final TEva_start=TEva_start,
      final XEva_start=XEva_start,
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
      final TAmbCon_nominal=TAmbCon_nominal,
      final TAmbEva_nominal=TAmbEva_nominal,
      final use_ConCap=use_conCap,
      final use_EvaCap=use_evaCap,
      final use_refIne=use_refIne,
      final transferHeat=transferHeat,
      final scalingFactor=scalingFactor,
      redeclare final package Medium_con = Medium_con,
      redeclare final package Medium_eva = Medium_eva,
      redeclare final model PerDataHea = PerDataHea,
      redeclare final model PerDataChi = PerDataChi,
      GConIns=10,
      GEvaIns=10));
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
  parameter Real scalingFactor=1 "Scaling-factor of HP" annotation(Dialog(tab="Heat Pump"), Evaluate=false);
  parameter Boolean use_refIne=true  "Consider the inertia of the refrigerant cycle"
    annotation (Dialog(tab="Heat Pump",group="Refrigerant cycle inertia"), choices(checkBox=true));
  constant Modelica.SIunits.Frequency refIneFre_constant
    "Cut off frequency representing inertia of refrigerant cycle"
    annotation (Dialog(tab="Heat Pump",group="Refrigerant cycle inertia", enable=use_refIne), Evaluate=false);
  parameter Integer nthOrder=3 "Order of refrigerant cycle interia"
    annotation (Dialog(tab="Heat Pump",group="Refrigerant cycle inertia", enable=use_refIne));
//Condenser/Evaporator
  parameter Modelica.SIunits.Volume VCon "Volume in condenser"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Condenser"), Evaluate=false);
  parameter Modelica.SIunits.Volume VEva "Volume in evaporator"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Evaporator"), Evaluate=false);
  parameter Modelica.SIunits.PressureDifference dpEva_nominal
    "Pressure drop at nominal mass flow rate"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Evaporator"));
  parameter Modelica.SIunits.PressureDifference dpCon_nominal
    "Pressure drop at nominal mass flow rate"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Condenser"));
  parameter Real deltaM_con=0.1
    "Fraction of nominal mass flow rate where transition to turbulent occurs"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Condenser"), Evaluate=false);
  parameter Real deltaM_eva=0.1
    "Fraction of nominal mass flow rate where transition to turbulent occurs"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Evaporator"), Evaluate=false);

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
      enable=use_evaCap), Evaluate=false);
  parameter Modelica.SIunits.ThermalConductance GEva
    "Constant thermal conductance of Evaporator material"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Evaporator",
      enable=use_evaCap), Evaluate=false);
  parameter Modelica.SIunits.HeatCapacity CCon
    "Heat capacity of Condenser (= cp*m)"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Condenser",
      enable=use_conCap), Evaluate=false);
  parameter Modelica.SIunits.ThermalConductance GCon
    "Constant thermal conductance of condenser material"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Condenser",
      enable=use_conCap), Evaluate=false);
//Dynamics
  parameter Real x_start[nthOrder]=zeros(nthOrder)
    "Initial or guess values of states"
    annotation (Dialog(tab="Initialization", group="System inertia", enable=use_refIne));
  parameter Real yRefIne_start=0 "Initial or guess value of output (= state)"
    annotation (Dialog(tab="Initialization", group="System inertia",enable=initType ==
          Init.InitialOutput and use_refIne));
  Modelica.Blocks.Sources.Constant constTAmb(final k=273.15 + 20) annotation (
      Placement(transformation(
        extent={{-7,7},{7,-7}},
        rotation=180,
        origin={87,-1})));
equation

  connect(constTAmb.y, heatPump.T_amb_con) annotation (Line(points={{79.3,-1},{
          79.3,0},{28,0},{28,16},{20.2,16},{20.2,16.3333}},
                                                       color={0,0,127}));
  connect(constTAmb.y, heatPump.T_amb_eva) annotation (Line(points={{79.3,-1},{
          79.3,0},{28,0},{28,-20.3333},{20.2,-20.3333}},
                                                    color={0,0,127}));
  connect(port_a1, port_a1)
    annotation (Line(points={{-100,60},{-100,60}}, color={0,127,255}));
  connect(hPSystemController.modeOut, heatPump.modeSet) annotation (Line(points=
         {{-20.6,93.1},{-20.6,32},{-48,32},{-48,-5.66667},{-29.52,-5.66667}},
        color={255,0,255}));
  connect(hPSystemController.nOut, heatPump.nSet) annotation (Line(points={{-1,93.1},
          {-1,30},{-40,30},{-40,1.66667},{-29.52,1.66667}}, color={0,0,127}));
  connect(hPSystemController.iceFac_out, heatPump.iceFac_in) annotation (Line(
        points={{54.86,161},{58,161},{58,-2},{36,-2},{36,-54},{-20.72,-54},{
          -20.72,-26.9333}},
                      color={0,0,127}));
  connect(heatPump.sigBusHP, hPSystemController.sigBusHP) annotation (Line(
      points={{-25.78,-9.15},{-84,-9.15},{-84,115.85},{-50.49,115.85}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HeatPumpSystem;
