within AixLib.Utilities.Sources.HeaterCooler;
model HeaterCoolerPIFraRadDamped
  extends PartialHeaterCoolerPIFraRad(
    recOrSep=true,
    fraHeaRad = if not recOrSep then 0 else zoneParam.traSysFraHeaRad,
    fraCooRad = if not recOrSep then 0 else zoneParam.traSysFraCooRad);
//  fraCooRad= if traSysInt == SimplifiedTransferSystems.TransferSystem.IdealHeater then 0 elseif traSysInt == SimplifiedTransferSystems.TransferSystem.Radiator then traSysRec.fraHeaRadRad elseif traSysInt == SimplifiedTransferSystems.TransferSystem.UnderFloorHeating then traSysRec.fraHeaRadUfh else traSysRec.fraHeaRadCca,
//  fraHeaRad= if traSysInt == SimplifiedTransferSystems.TransferSystem.IdealHeater then 0 elseif traSysInt == SimplifiedTransferSystems.TransferSystem.Radiator then traSysRec.fraCooRadRad elseif traSysInt == SimplifiedTransferSystems.TransferSystem.UnderFloorHeating then traSysRec.fraCooRadUfh else traSysRec.fraCooRadCca);

  parameter Real K_PT1 = if not recOrSep then 0 else zoneParam.traSysK
  "Gain for PT1 for damped heating transfer"
      annotation(Dialog(tab = "Heater", group = "PT1 Damper",enable=not recOrSep));
  parameter Modelica.Units.SI.Time T_PT1 = if not recOrSep then 0 else zoneParam.traSysT
  "Time Constant for PT1 for damped heating transfer"
      annotation (Dialog(tab="Heater", group="PT1 Damper", enable=not recOrSep));


//  parameter SimplifiedTransferSystems.TransferSystem traSys=
//      SimplifiedTransferSystems.TransferSystem.ConcreteCoreActivation
//    "Transfer system type" annotation (Dialog(compact=true,
//    descriptionLabel=true,enable=not recOrSep),
//      choices(
//      choice=SimplifiedTransferSystems.TransferSystem.IdealHeater "Ideal Heater",
//      choice=SimplifiedTransferSystems.TransferSystem.Radiator "Radiator",
//      choice=SimplifiedTransferSystems.TransferSystem.UnderFloorHeating "Under Floor Heating",
//      choice=SimplifiedTransferSystems.TransferSystem.ConcreteCoreActivation "Concrete Core Activation",
//      radioButtons=true));

// protected

//  parameter SimplifiedTransferSystems.TransferSystem traSysInt = if not recOrSep then traSys else zoneParam.traSys
//  "Internal transfer system parameter";
//  replaceable parameter SimplifiedTransferSystems.SimplifiedTransferSystem
//    traSysRec "record of transfer system parameters" annotation (choicesAllMatching=true);
//  parameter Real kPT1= if traSysInt == SimplifiedTransferSystems.TransferSystem.IdealHeater then 0 elseif traSysInt == SimplifiedTransferSystems.TransferSystem.Radiator then traSysRec.k_Rad elseif traSysInt == SimplifiedTransferSystems.TransferSystem.UnderFloorHeating then ((zoneParam.AZone - zoneParam.AFloor) * traSysRec.k_UfhGroFlo +
//     zoneParam.AFloor * traSysRec.k_UfhFlo) / zoneParam.AZone else traSysRec.k_Cca "Gain for PT1 for damped heating transfer";
//  parameter Modelica.Units.SI.Time TPT1= if traSysInt == SimplifiedTransferSystems.TransferSystem.IdealHeater then 0 elseif traSysInt == SimplifiedTransferSystems.TransferSystem.Radiator then traSysRec.T_Rad elseif traSysInt == SimplifiedTransferSystems.TransferSystem.UnderFloorHeating then ((zoneParam.AZone - zoneParam.AFloor) * traSysRec.T_UfhGroFlo +
//     zoneParam.AFloor * traSysRec.T_UfhFlo) / zoneParam.AZone else traSysRec.T_Cca "Time Constant for PT1 for damped heating transfer";


protected
  Modelica.Blocks.Continuous.FirstOrder firstOrderCooling(k=kPT1, T=TPT1) if ((recOrSep and zoneParam.CoolerOn) or (not recOrSep and Cooler_on))
    "Emulates the belayed cooling flow into the building due to thermal activated building systems"
    annotation (Placement(transformation(extent={{-16,-82},{4,-62}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrderHeating(k=kPT1, T=TPT1) if ((recOrSep and zoneParam.HeaterOn) or (not recOrSep and Heater_on))
    "Emulates the belayed heat flow into the building due to thermal activated building systems"
    annotation (Placement(transformation(extent={{-20,58},{0,78}})));
equation
  connect(firstOrderHeating.y, gainCon.u) annotation (Line(points={{1,68},{10,68},
          {10,80},{18,80}}, color={0,0,127}));
  connect(firstOrderHeating.y, gainRad.u)
    annotation (Line(points={{1,68},{8,68},{8,50},{18,50}}, color={0,0,127}));
  connect(pITempHeat.y, firstOrderHeating.u) annotation (Line(points={{-1,20},{-1,
          44},{-30,44},{-30,68},{-22,68}}, color={0,0,127}));
  connect(pITempCool.y, firstOrderCooling.u) annotation (Line(points={{-1,-20},{
          2,-20},{2,-48},{-34,-48},{-34,-72},{-18,-72}}, color={0,0,127}));
  connect(firstOrderCooling.y, gainCooCon.u) annotation (Line(points={{5,-72},{10,
          -72},{10,-62},{18,-62}}, color={0,0,127}));
  connect(firstOrderCooling.y, gainCooRad.u) annotation (Line(points={{5,-72},{12,
          -72},{12,-84},{10,-84},{10,-92},{18,-92}}, color={0,0,127}));
end HeaterCoolerPIFraRadDamped;
