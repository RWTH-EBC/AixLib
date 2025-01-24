within AixLib.Utilities.Sources.HeaterCooler;
model HeaterCoolerPIFraRadDamped
  extends PartialHeaterCoolerPIFraRad(
    recOrSep=true,
    fraHeaRad = if not recOrSep then 0 else zoneParam.traSysFraHeaRad,
    fraCooRad = if not recOrSep then 0 else zoneParam.traSysFraCooRad);

  parameter Real K_PT1 = if not recOrSep then 1 else zoneParam.traSysK
    "Gain for PT1 for damped heating transfer"
      annotation(Dialog(tab = "General", group = "PT1 Damper", enable=not recOrSep));
  parameter Modelica.Units.SI.Time T_PT1 = if not recOrSep then 1 else zoneParam.traSysT
    "Time Constant for PT1 for damped heating transfer"
      annotation (Dialog(tab="General", group = "PT1 Damper", enable=not recOrSep));

protected
  Modelica.Blocks.Continuous.FirstOrder firstOrderCooling(k=K_PT1, T=T_PT1) if ((recOrSep and zoneParam.CoolerOn) or (not recOrSep and Cooler_on))
    "Emulates the belayed cooling flow into the building due to thermal activated building systems"
    annotation (Placement(transformation(extent={{-16,-82},{4,-62}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrderHeating(k=K_PT1, T=T_PT1) if ((recOrSep and zoneParam.HeaterOn) or (not recOrSep and Heater_on))
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
