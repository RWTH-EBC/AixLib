within AixLib.Systems.HeatPumpSystems_old;
model HeatPumpSystem
  extends AixLib.Systems.HeatPumpSystems_old.BaseClasses.PartialHeatPumpSystem(
    addPowerToMediumEva=false,
    transferHeat=true,
    mFlow_conNominal=QCon_nominal/(cpCon*dTCon),
    mFlow_evaNominal=QEva_nominal/(cpEva*dTEva),
    redeclare AixLib.Fluid.HeatPumps.HeatPump heatPump(
      use_autoCalc=false,
      Q_useNominal=0,
      redeclare final model PerDataMainHP = PerDataHea,
      redeclare final model PerDataRevHP = PerDataChi,
      redeclare final package Medium_con = Medium_con,
      redeclare final package Medium_eva = Medium_eva,
      final use_rev=use_revHP,
      final scalingFactor=scalingFactor,
      final use_refIne=use_refIne,
      final refIneFre_constant=refIneFre_constant,
      final nthOrder=nthOrder,
      final dpCon_nominal=dpCon_nominal,
      final deltaM_con=deltaM_con,
      final use_conCap=use_conCap,
      final CCon=CCon,
      final GConOut=GConOut,
      final GConIns=GConIns,
      final dpEva_nominal=dpEva_nominal,
      final deltaM_eva=deltaM_eva,
      final use_evaCap=use_evaCap,
      final CEva=CEva,
      final GEvaOut=GEvaOut,
      final GEvaIns=GEvaIns,
      final tauSenT=tauSenT,
      final transferHeat=transferHeat,
      final allowFlowReversalEva=allowFlowReversalEva,
      final allowFlowReversalCon=allowFlowReversalCon,
      final tauHeaTraEva=tauHeaTraEva,
      final tauHeaTraCon=tauHeaTraCon,
      final TAmbCon_nominal=TAmbCon_nominal,
      final TAmbEva_nominal=TAmbEva_nominal,
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
      final fixed_TCon_start=fixed_TCon_start,
      final fixed_TEva_start=fixed_TEva_start,
      mFlow_conNominal=mFlow_conNominal,
      mFlow_evaNominal=mFlow_evaNominal));

//Heat Pump
  replaceable model PerDataHea =
      AixLib.DataBase.ThermalMachines.HeatPump.PerformanceData.LookUpTable2D              constrainedby
    AixLib.DataBase.ThermalMachines.HeatPump.PerformanceData.BaseClasses.PartialPerformanceData
  "Performance data of HP in heating mode"
    annotation (Dialog(tab="Heat Pump"),choicesAllMatching=true);
  replaceable model PerDataChi =
      AixLib.DataBase.ThermalMachines.HeatPump.PerformanceData.LookUpTable2D              constrainedby
    AixLib.DataBase.ThermalMachines.HeatPump.PerformanceData.BaseClasses.PartialPerformanceData
  "Performance data of HP in chilling mode"
    annotation (Dialog(tab="Heat Pump",enable=use_revHP), choicesAllMatching=true);

  parameter Boolean use_revHP=true "True if the HP is reversible" annotation(Dialog(tab="Heat Pump"),choices(choice=true "reversible HP",
      choice=false "only heating",
      radioButtons=true));
  parameter Real scalingFactor=1 "Scaling-factor of HP" annotation(Dialog(tab="Heat Pump"), Evaluate=true);
  parameter Boolean use_refIne=true  "Consider the inertia of the refrigerant cycle"
    annotation (Dialog(tab="Heat Pump",group="Refrigerant cycle inertia"), choices(checkBox=true));
  constant Modelica.SIunits.Frequency refIneFre_constant
    "Cut off frequency representing inertia of refrigerant cycle"
    annotation (Dialog(tab="Heat Pump",group="Refrigerant cycle inertia", enable=use_refIne), Evaluate=true);
  parameter Integer nthOrder=3 "Order of refrigerant cycle interia"
    annotation (Dialog(tab="Heat Pump",group="Refrigerant cycle inertia", enable=use_refIne));
//Condenser/Evaporator
  parameter Modelica.SIunits.Volume VCon(displayUnit="l")
                                         "Volume in condenser. Typical values range from 1 to 20 l, depending on the size of the heat pump and the mass flow rate."
    annotation (Dialog(tab="Evaporator/ Condenser", group="Condenser"), Evaluate=true);
  parameter Modelica.SIunits.Volume VEva(displayUnit="l")
                                         "Volume in evaporator. Typical values range from 1 to 20 l, depending on the size of the heat pump and the mass flow rate."
    annotation (Dialog(tab="Evaporator/ Condenser", group="Evaporator"), Evaluate=true);
  parameter Modelica.SIunits.PressureDifference dpEva_nominal(displayUnit="kPa")
    "Pressure drop at nominal mass flow rate. Only relevant if a mover is used. Try to select values to match the nominal mass flow rate."
    annotation (Dialog(tab="Evaporator/ Condenser", group="Evaporator"));
  parameter Modelica.SIunits.PressureDifference dpCon_nominal(displayUnit="kPa")
    "Pressure drop at nominal mass flow rate. Only relevant if a mover is used. Try to select values to match the nominal mass flow rate."
    annotation (Dialog(tab="Evaporator/ Condenser", group="Condenser"));
  parameter Real deltaM_con=0.1
    "Fraction of nominal mass flow rate where transition to turbulent occurs"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Condenser"), Evaluate=true);
  parameter Real deltaM_eva=0.1
    "Fraction of nominal mass flow rate where transition to turbulent occurs"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Evaporator"), Evaluate=true);

  parameter Boolean use_conCap=true
    "If heat losses at capacitor side are considered or not"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Condenser"),
                                          choices(checkBox=true));
  parameter Boolean use_evaCap=true
    "If heat losses at capacitor side are considered or not"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Evaporator"),
                                          choices(checkBox=true));
  parameter Modelica.SIunits.HeatCapacity CEva
    "Heat capacity of Evaporator (= cp*m)"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Evaporator",
      enable=use_evaCap), Evaluate=true);
  parameter Modelica.SIunits.ThermalConductance GEvaOut=percHeatLoss*
      QEva_nominal/(TEva_nominal - TAmbEva_nominal)
    "Constant parameter for heat transfer to the ambient. Represents a sum of thermal resistances such as conductance, insulation and natural convection"
    annotation (Evaluate=true,Dialog(group="Evaporator", tab="Evaporator/ Condenser",
      enable=use_evaCap));
  parameter Modelica.SIunits.ThermalConductance GEvaIns=QEva_nominal/dTPinchEva
    "Constant parameter for heat transfer to heat exchangers capacity. Represents a sum of thermal resistances such as forced convection and conduction inside of the capacity"
    annotation (Evaluate=true,Dialog(group="Evaporator", tab="Evaporator/ Condenser",
      enable=use_evaCap));
  parameter Modelica.SIunits.HeatCapacity CCon
    "Heat capacity of Condenser (= cp*m)"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Condenser",
      enable=use_conCap), Evaluate=true);
  parameter Modelica.SIunits.ThermalConductance GConOut=percHeatLoss*
      QCon_nominal/(TCon_nominal - TAmbCon_nominal)
    "Constant parameter for heat transfer to the ambient. Represents a sum of thermal resistances such as conductance, insulation and natural convection"
    annotation (Evaluate=true, Dialog(
      group="Condenser",
      tab="Evaporator/ Condenser",
      enable=use_conCap));
  parameter Modelica.SIunits.ThermalConductance GConIns=QCon_nominal/dTPinchCon
    "Constant parameter for heat transfer to heat exchangers capacity. Represents a sum of thermal resistances such as forced convection and conduction inside of the capacity"
    annotation (Evaluate=true,Dialog(group="Condenser", tab="Evaporator/ Condenser",
      enable=use_conCap));
//Dynamics
  parameter Real x_start[nthOrder]=zeros(nthOrder)
    "Initial or guess values of states"
    annotation (Dialog(tab="Initialization", group="System inertia", enable=use_refIne));
  parameter Real yRefIne_start=0 "Initial or guess value of output (= state)"
    annotation (Dialog(tab="Initialization", group="System inertia",enable=initType ==
          Modelica.Blocks.Types.Init.InitialOutput and use_refIne));
  parameter Boolean fixed_TCon_start
    "true if T_start of non-fluid capacity in condenser should be fixed at initialization"
    annotation (Dialog(
      tab="Initialization",
      group="Condenser",
      enable=use_conCap));
  parameter Boolean fixed_TEva_start
    "true if T_start of non-fluid capacity in evaporator should be fixed at initialization"
    annotation (Dialog(
      tab="Initialization",
      group="Evaporator",
      enable=use_evaCap));

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
  connect(heatPump.sigBus, hPSystemController.sigBusHP) annotation (Line(
      points={{-25.78,-9.15},{-84,-9.15},{-84,115.85},{-50.49,115.85}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html><ul>
  <li>
    <i>May 22, 2019</i> by Julian Matthes:<br/>
    Rebuild due to the introducion of the thermal machine partial model
    (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/715\">#715</a>)
  </li>
  <li>
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
  </li>
</ul>
</html>", info="<html>
<p>
  This model uses the heat pump model <a href=
  \"modelica://AixLib.Fluid.HeatPumps.HeatPump\">AixLib.Fluid.HeatPumps.HeatPump</a>
  to simulate a whole system, including controls, pumps and second heat
  generator.
</p>
<p>
  A <a href=
  \"modelica://AixLib.Systems.HeatPumpSystems.BaseClasses.HeatPumpSystemParameters\">
  set of parameters</a> is used to estimate the model parameters.
</p>
<p>
  See <a href=
  \"modelica://AixLib.Systems.HeatPumpSystems.BaseClasses.PartialHeatPumpSystem\">
  AixLib.Systems.HeatPumpSystems.BaseClasses.PartialHeatPumpSystem</a>
  for information about the features of the heat pump system.
</p>
</html>"));
end HeatPumpSystem;
