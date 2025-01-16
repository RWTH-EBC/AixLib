within AixLib.Utilities.Sources.HeaterCooler;
model HeaterCoolerPIFraRadDamped
  extends PartialHeaterCoolerPIFraRad(
  fraCooRad= if traSysInt == SimplifiedTransferSystems.TransferSystem.IdealHeater then 0 elseif traSysInt == SimplifiedTransferSystems.TransferSystem.Radiator then 0.5 elseif traSysInt == SimplifiedTransferSystems.TransferSystem.UnderFloorHeating then 0.5 else 0.5,
  fraHeaRad= if traSysInt == SimplifiedTransferSystems.TransferSystem.IdealHeater then 0 elseif traSysInt == SimplifiedTransferSystems.TransferSystem.Radiator then 0.5 elseif traSysInt == SimplifiedTransferSystems.TransferSystem.UnderFloorHeating then 0.5 else 0.5);

  parameter SimplifiedTransferSystems.TransferSystem traSys=
      SimplifiedTransferSystems.TransferSystem.IdealHeater
    "Transfer system type" annotation (Dialog(compact=true,
    descriptionLabel=true,enable=not recOrSep),
      choices(
      choice=HeatingType.IdealHeater "Ideal Heater",
      choice=HeatingType.Radiator "Radiator",
      choice=HeatingType.UnderFloorHeating "Under Floor Heating",
      choice=HeatingType.ConcreteCoreActivation "Concrete Core Activation",
      radioButtons=true));

protected
parameter AixLib.Utilities.Sources.HeaterCooler.SimplifiedTransferSystems.TransferSystem
  traSysInt = if not recOrSep then traSys else zoneParam.traSys
  "Internal transfer system parameter";
  replaceable parameter SimplifiedTransferSystems.SimplifiedTransferSystem
    traSysRec "record of transfer system parameters" annotation (choicesAllMatching=true);

  parameter Real kPT1= if traSysInt == SimplifiedTransferSystems.TransferSystem.IdealHeater then 0 elseif traSysInt == SimplifiedTransferSystems.TransferSystem.Radiator then traSysRec.k_Rad elseif traSysInt == SimplifiedTransferSystems.TransferSystem.UnderFloorHeating then ((zoneParam.AZone - zoneParam.AFloor) * traSysRec.k_UfhGroFlo +
     zoneParam.AFloor * traSysRec.k_UfhFlo) / zoneParam.AZone else traSysRec.k_Cca "Gain for PT1 for damped heating transfer";
  parameter Modelica.Units.SI.Time TPT1= if traSysInt == SimplifiedTransferSystems.TransferSystem.IdealHeater then 0 elseif traSysInt == SimplifiedTransferSystems.TransferSystem.Radiator then traSysRec.T_Rad elseif traSysInt == SimplifiedTransferSystems.TransferSystem.UnderFloorHeating then ((zoneParam.AZone - zoneParam.AFloor) * traSysRec.T_UfhGroFlo +
     zoneParam.AFloor * traSysRec.T_UfhFlo) / zoneParam.AZone else traSysRec.T_Cca "Time Constant for PT1 for damped heating transfer";

  Modelica.Blocks.Continuous.FirstOrder firstOrderHeating(k=kPT1, T=TPT1) if not
    traSysInt == SimplifiedTransferSystems.TransferSystem.IdealHeater
    "Emulates the belayed heat flow into the building due to thermal activated building systems"
    annotation (Placement(transformation(extent={{-20,54},{0,74}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrderCooling(k=kPT1, T=TPT1)
                                                          if not traSysInt
     == SimplifiedTransferSystems.TransferSystem.IdealHeater
    "Emulates the belayed cooling flow into the building due to thermal activated building systems"
    annotation (Placement(transformation(extent={{-20,-84},{0,-64}})));

equation
  connect(pITempHeat.y, firstOrderHeating.u) annotation (Line(points={{-1,20},{2,
          20},{2,46},{-30,46},{-30,64},{-22,64}}, color={0,0,127},
      pattern=LinePattern.Dash));
  connect(firstOrderHeating.y, gainCon.u)
    annotation (Line(points={{1,64},{8,64},{8,80},{18,80}}, color={0,0,127}));
  connect(firstOrderHeating.y, gainRad.u) annotation (Line(points={{1,64},{10,64},
          {10,50},{18,50}}, color={0,0,127},
      pattern=LinePattern.Dash));
  connect(pITempCool.y, firstOrderCooling.u) annotation (Line(points={{-1,-20},{
          0,-20},{0,-56},{-28,-56},{-28,-74},{-22,-74}}, color={0,0,127},
      pattern=LinePattern.Dash));
  connect(firstOrderCooling.y, gainCooCon.u) annotation (Line(points={{1,-74},{10,
          -74},{10,-62},{18,-62}}, color={0,0,127}));
  connect(firstOrderCooling.y, gainCooRad.u) annotation (Line(points={{1,-74},{8,
          -74},{8,-92},{18,-92}}, color={0,0,127},
      pattern=LinePattern.Dash));
  if traSysInt == SimplifiedTransferSystems.TransferSystem.IdealHeater then
    connect(pITempHeat.y, gainCon.u) annotation (Line(
      points={{-1,20},{2,20},{2,50},{6,50},{6,62},{8,62},{8,80},{18,80}},
      color={0,0,127},
      pattern=LinePattern.Dash));
    connect(pITempHeat.y, gainRad.u) annotation (Line(
      points={{-1,20},{2,20},{2,50},{18,50}},
      color={0,0,127},
      pattern=LinePattern.Dash));
    connect(pITempCool.y, gainCooCon.u) annotation (Line(
      points={{-1,-20},{-1,-60},{10,-60},{10,-62},{18,-62}},
      color={0,0,127},
      pattern=LinePattern.Dash));
    connect(pITempCool.y, gainCooRad.u) annotation (Line(
      points={{-1,-20},{-1,-60},{8,-60},{8,-92},{18,-92}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  end if;
end HeaterCoolerPIFraRadDamped;
