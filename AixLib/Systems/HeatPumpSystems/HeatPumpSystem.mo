within AixLib.Systems.HeatPumpSystems;
model HeatPumpSystem
  extends AixLib.Systems.HeatPumpSystems.BaseClasses.PartialHeatPumpSystem(
    addPowerToMediumEva=false,
    transferHeat=true,
    mFlow_conNominal=QCon_nominal/(cpCon*dTCon),
    mFlow_evaNominal=QEva_nominal/(cpEva*dTEva),
    redeclare AixLib.Fluid.HeatPumps.ModularReversible.Modular heatPump(
      redeclare model RefrigerantCycleInertia = RefrigerantCycleInertia,
      dTCon_nominal=dTCon,
      dTEva_nominal=dTEva,
      QHea_flow_nominal=QCon_nominal,
      TConHea_nominal=TCon_nominal,
      TEvaHea_nominal=TEva_nominal,
      final VEva=VEva,
      redeclare final model RefrigerantCycleHeatPumpHeating = PerDataHea,
      redeclare final model RefrigerantCycleHeatPumpCooling = PerDataChi,
      redeclare final package MediumCon = Medium_con,
      redeclare final package MediumEva = Medium_eva,
      final use_rev=use_revHP,
      final use_refIne=use_refIne,
      final refIneFre_constant=refIneFre_constant,
      final nthOrder=nthOrder,
      final VCon=VCon,
      final dpCon_nominal=dpCon_nominal,
      final use_conCap=use_conCap,
      final CCon=CCon,
      final GConOut=GConOut,
      final GConIns=GConIns,
      final dpEva_nominal=dpEva_nominal,
      final use_evaCap=use_evaCap,
      final CEva=CEva,
      final GEvaOut=GEvaOut,
      final GEvaIns=GEvaIns,
      final allowFlowReversalEva=allowFlowReversalEva,
      final allowFlowReversalCon=allowFlowReversalCon,
      final initType=initType,
      final pCon_start=pCon_start,
      final TCon_start=TCon_start,
      final XCon_start=XCon_start,
      final pEva_start=pEva_start,
      final TEva_start=TEva_start,
      final XEva_start=XEva_start,
      final energyDynamics=energyDynamics,
      final mEva_flow_nominal=mFlow_evaNominal,
      final use_busConOnl=true,
      final mCon_flow_nominal=mFlow_conNominal,
      final deltaMCon=deltaM_con,
      final deltaMEva=deltaM_eva));

  //Heat Pump
  replaceable model PerDataHea =
      AixLib.Obsolete.Year2024.DataBase.HeatPump.PerformanceData.LookUpTable2D              constrainedby
    AixLib.Obsolete.Year2024.DataBase.HeatPump.PerformanceData.BaseClasses.PartialPerformanceData
  "Performance data of HP in heating mode"
    annotation (Dialog(tab="Heat Pump"),choicesAllMatching=true);

  replaceable model PerDataChi =
      AixLib.Obsolete.Year2024.DataBase.Chiller.PerformanceData.LookUpTable2D              constrainedby
    AixLib.Obsolete.Year2024.DataBase.Chiller.PerformanceData.BaseClasses.PartialPerformanceData
  "Performance data of HP in chilling mode"
    annotation (Dialog(tab="Heat Pump",enable=use_revHP), choicesAllMatching=true);
  replaceable model RefrigerantCycleInertia =
      AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.Inertias.NoInertia
      constrainedby AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.Inertias.BaseClasses.PartialInertia
    annotation (choicesAllMatching=true);
  parameter Boolean use_revHP=true "True if the HP is reversible" annotation(Dialog(tab="Heat Pump"),choices(choice=true "reversible HP",
      choice=false "only heating",
      radioButtons=true));

//Condenser/Evaporator
  parameter Modelica.Units.SI.Volume VCon(displayUnit="l")
    "Volume in condenser. Typical values range from 1 to 20 l, depending on the size of the heat pump and the mass flow rate."
    annotation (Dialog(tab="Evaporator/ Condenser", group="Condenser"),
      Evaluate=true);
  parameter Modelica.Units.SI.Volume VEva(displayUnit="l")
    "Volume in evaporator. Typical values range from 1 to 20 l, depending on the size of the heat pump and the mass flow rate."
    annotation (Dialog(tab="Evaporator/ Condenser", group="Evaporator"),
      Evaluate=true);
  parameter Modelica.Units.SI.PressureDifference dpEva_nominal(displayUnit=
        "kPa")
    "Pressure drop at nominal mass flow rate. Only relevant if a mover is used. Try to select values to match the nominal mass flow rate."
    annotation (Dialog(tab="Evaporator/ Condenser", group="Evaporator"));
  parameter Modelica.Units.SI.PressureDifference dpCon_nominal(displayUnit=
        "kPa")
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
  parameter Modelica.Units.SI.HeatCapacity CEva
    "Heat capacity of Evaporator (= cp*m). If you want to neglace the dry mass of the evaporator, you can set this value to zero"
    annotation (Dialog(
      tab="Evaporator/ Condenser",
      group="Evaporator",
      enable=use_evaCap), Evaluate=true);
  parameter Modelica.Units.SI.ThermalConductance GEvaOut=percHeatLoss*
      QEva_nominal/(TEva_nominal - TAmbEva_nominal)
    "Constant parameter for heat transfer to the ambient. Represents a sum of thermal resistances such as conductance, insulation and natural convection. If you want to simulate a evaporator with additional dry mass but without external heat losses, set the value to zero"
    annotation (Evaluate=true, Dialog(
      group="Evaporator",
      tab="Evaporator/ Condenser",
      enable=use_evaCap));
  parameter Modelica.Units.SI.ThermalConductance GEvaIns=QEva_nominal/
      dTPinchEva
    "Constant parameter for heat transfer to heat exchangers capacity. Represents a sum of thermal resistances such as forced convection and conduction inside of the capacity"
    annotation (Evaluate=true, Dialog(
      group="Evaporator",
      tab="Evaporator/ Condenser",
      enable=use_evaCap));
  parameter Modelica.Units.SI.HeatCapacity CCon
    "Heat capacity of Condenser (= cp*m). If you want to neglace the dry mass of the condenser, you can set this value to zero"
    annotation (Dialog(
      tab="Evaporator/ Condenser",
      group="Condenser",
      enable=use_conCap), Evaluate=true);
  parameter Modelica.Units.SI.ThermalConductance GConOut=percHeatLoss*
      QCon_nominal/(TCon_nominal - TAmbCon_nominal)
    "Constant parameter for heat transfer to the ambient. Represents a sum of thermal resistances such as conductance, insulation and natural convection. If you want to simulate a condenser with additional dry mass but without external heat losses, set the value to zero"
    annotation (Evaluate=true, Dialog(
      group="Condenser",
      tab="Evaporator/ Condenser",
      enable=use_conCap));
  parameter Modelica.Units.SI.ThermalConductance GConIns=QCon_nominal/
      dTPinchCon
    "Constant parameter for heat transfer to heat exchangers capacity. Represents a sum of thermal resistances such as forced convection and conduction inside of the capacity"
    annotation (Evaluate=true, Dialog(
      group="Condenser",
      tab="Evaporator/ Condenser",
      enable=use_conCap));
//Dynamics
  parameter Real x_start[nthOrder]=zeros(nthOrder)
    "Initial or guess values of states"
    annotation (Dialog(tab="Initialization", group="System inertia", enable=use_refIne));
  parameter Real yRefIne_start=0 "Initial or guess value of output (= state)"
    annotation (Dialog(tab="Initialization", group="System inertia",enable=initType ==
          Modelica.Blocks.Types.Init.InitialOutput and use_refIne));
//Initialization
  parameter Modelica.Units.SI.Temperature TConCap_start=Medium_con.T_default
    "Initial temperature of heat capacity of condenser" annotation (Dialog(
      tab="Initialization",
      group="Condenser",
      enable=use_conCap));
  parameter Modelica.Units.SI.Temperature TEvaCap_start=Medium_eva.T_default
    "Initial temperature of heat capacity at evaporator" annotation (Dialog(
      tab="Initialization",
      group="Evaporator",
      enable=use_evaCap));

equation

  connect(port_a1, port_a1)
    annotation (Line(points={{-100,60},{-100,60}}, color={0,127,255}));
  connect(hPControls.sigBusHP, heatPump.sigBus) annotation (Line(
      points={{-20.38,118.4},{-50,118.4},{-50,-10.58},{-25.78,-10.58}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html><ul>
  <li>
    <i>October 31, 2018&#160;</i> by Alexander Kümpel:<br/>
    Connection between controller and heat pump only via bus connector
  </li>
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
  This model uses the heat pump model <a href=\"modelica://AixLib.Fluid.HeatPumps.ModularReversible.Modular\">AixLib.Obsolete.Year2024.Fluid.HeatPumps.HeatPump</a>
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
