within AixLib.Utilities.Sources.HeaterCoolerVDI6007AC1;
model HeaterCoolerWithTabs6007C1

// DELETE
  parameter Modelica.SIunits.Power p_heater_Panel = 0
  "Limited power for panel heating" annotation(Dialog(tab = "Heater", group = "Heating"));
  parameter Modelica.SIunits.Power p_heater_Rem = 0
  "Limited power for radiative and convective heating system" annotation(Dialog(tab = "Heater", group = "Heating"));
  parameter Modelica.SIunits.Power p_cooler_Panel = 0
  "Limited power for panel cooling" annotation(Dialog(tab = "Cooler", group = "Cooling"));
  parameter Modelica.SIunits.Power p_cooler_Rem = 0
  "Limited power for radiative and convective cooling system" annotation(Dialog(tab = "Cooler", group = "Cooling"));

// Heiz- und Kühlsystemparameter
  parameter Real share_Heater_TabsExt(min=0, max=1) = 0
    "contribution from a system installed in the core of one or several exterior building components to heating load" annotation(Dialog(tab = "Heater", group = "Heating"));
  parameter Real share_Heater_TabsInt(min=0, max=1) = 0
    "contribution from a system installed in the core of one or several interior building components to heating load" annotation(Dialog(tab = "Heater", group = "Heating"));
  parameter Real share_Heater_PanelExt(min=0, max=1) = 0
    "contribution from any heated surfaces of one or several exterior building components to heating load" annotation(Dialog(tab = "Heater", group = "Heating"));
  parameter Real share_Heater_PanelInt(min=0, max=1) = 0
    "contribution from any heated surfaces of one or several interior building components to heating load" annotation(Dialog(tab = "Heater", group = "Heating"));
  parameter Real share_Heater_RadExt(min=0, max=1) = 0
    "radiant contribution of one or several exterior building components to heating load" annotation(Dialog(tab = "Heater", group = "Heating"));
  parameter Real share_Heater_RadInt(min=0, max=1) = 0
    "radiant contribution of one or several interior building components to heating load" annotation(Dialog(tab = "Heater", group = "Heating"));
  parameter Real share_Heater_Conv(min=0, max=1) = 0
    "convective contribution to heating load" annotation(Dialog(tab = "Heater", group = "Heating"));
  parameter Real share_Cooler_TabsExt(min=0, max=1) = 0
    "contribution from a system installed in the core of one or several exterior building components to cooling load" annotation(Dialog(tab = "Cooler", group = "Cooling"));
  parameter Real share_Cooler_TabsInt(min=0, max=1) = 0
    "contribution from a system installed in the core of one or several interior building components to cooling load" annotation(Dialog(tab = "Cooler", group = "Cooling"));
  parameter Real share_Cooler_PanelExt(min=0, max=1) = 0
    "contribution from any cooled surfaces of one or several exterior building components to cooling load" annotation(Dialog(tab = "Cooler", group = "Cooling"));
  parameter Real share_Cooler_PanelInt(min=0, max=1) = 0
    "contribution from any cooled surfaces of one or several interior building components to cooling load" annotation(Dialog(tab = "Cooler", group = "Cooling"));
  parameter Real share_Cooler_RadExt(min=0, max=1) = 0
    "radiant contribution of one or several exterior building components to cooling load" annotation(Dialog(tab = "Cooler", group = "Cooling"));
  parameter Real share_Cooler_RadInt(min=0, max=1) = 0
    "radiant contribution of one or several interior building components to cooling load" annotation(Dialog(tab = "Cooler", group = "Cooling"));
  parameter Real share_Cooler_Conv(min=0, max=1) = 0
    "convective contribution to cooling load" annotation(Dialog(tab = "Cooler", group = "Cooling"));

// von PartialHeaterCoolerPI übernommen
  parameter Boolean Heater_on = true "Activates the heater" annotation(Dialog(tab = "Heater",enable=not recOrSep));
  parameter Boolean Cooler_on = true "Activates the cooler" annotation(Dialog(tab = "Cooler",enable=not recOrSep));
  parameter Real h_heater_Panel = 0 "Upper limit controller output of the heater" annotation(Dialog(tab = "Heater", group = "Controller",enable=not recOrSep));
  parameter Real l_heater_Panel = 0 "Lower limit controller output of the heater" annotation(Dialog(tab = "Heater", group = "Controller",enable=not recOrSep));
  parameter Real h_heater_Rem = 0 "Upper limit controller output of the heater" annotation(Dialog(tab = "Heater", group = "Controller",enable=not recOrSep));
  parameter Real l_heater_Rem = 0 "Lower limit controller output of the heater" annotation(Dialog(tab = "Heater", group = "Controller",enable=not recOrSep));
  parameter Real KR_heater_Panel = 0.1 "Gain of the panel heating controller" annotation(Dialog(tab = "Heater", group = "Controller",enable=not recOrSep));
  parameter Modelica.SIunits.Time TN_heater_Panel = 4 "Time constant of the panel heating controller" annotation(Dialog(tab = "Heater", group = "Controller",enable=not recOrSep));
  parameter Real KR_heater_Rem = 0.1 "Gain of the heating controller for radiative and convective heating system" annotation(Dialog(tab = "Heater", group = "Controller",enable=not recOrSep));
  parameter Modelica.SIunits.Time TN_heater_Rem = 4 "Time constant of the heating controller for radiative and convective heating system" annotation(Dialog(tab = "Heater", group = "Controller",enable=not recOrSep));
  parameter Real h_cooler_Panel = 0 "Upper limit controller output of the cooler" annotation(Dialog(tab = "Cooler", group = "Controller",enable=not recOrSep));
  parameter Real l_cooler_Panel = 0 "Lower limit controller output of the cooler" annotation(Dialog(tab = "Cooler", group = "Controller",enable=not recOrSep));
  parameter Real h_cooler_Rem = 0 "Upper limit controller output of the cooler" annotation(Dialog(tab = "Cooler", group = "Controller",enable=not recOrSep));
  parameter Real l_cooler_Rem = 0 "Lower limit controller output of the cooler" annotation(Dialog(tab = "Cooler", group = "Controller",enable=not recOrSep));
  parameter Real KR_cooler_Panel = 0.1 "Gain of the panel cooling controller" annotation(Dialog(tab = "Cooler", group = "Controller",enable=not recOrSep));
  parameter Modelica.SIunits.Time TN_cooler_Panel = 4 "Time constant of the panel cooling controller" annotation(Dialog(tab = "Cooler", group = "Controller",enable=not recOrSep));
  parameter Real KR_cooler_Rem = 0.1 "Gain of the cooling controller for radiative and convective cooling system" annotation(Dialog(tab = "Cooler", group = "Controller",enable=not recOrSep));
  parameter Modelica.SIunits.Time TN_cooler_Rem = 4 "Time constant of the cooling controller for radiative and convective cooling system" annotation(Dialog(tab = "Cooler", group = "Controller",enable=not recOrSep));
  parameter Boolean recOrSep = false "Use record or seperate parameters" annotation(choices(choice =  false
        "Seperate",choice = true "Record",radioButtons = true));
  parameter AixLib.DataBase.ThermalZones.ZoneBaseRecord zoneParam = AixLib.DataBase.ThermalZones.ZoneRecordDummy()
    "Zone definition" annotation(choicesAllMatching=true,Dialog(enable=recOrSep));

// übernommen aus HeaterCoolerPI
  parameter Boolean staOrDyn = true "Static or dynamic activation of heater" annotation(choices(choice = true "Static", choice =  false "Dynamic",
                  radioButtons = true));
  Modelica.Blocks.Sources.BooleanExpression booleanExpressionHeater(y=if not
        recOrSep then Heater_on else zoneParam.HeaterOn) if staOrDyn annotation (Placement(transformation(extent={{-130,20},
            {-111,36}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpressionCooler(y=if not
        recOrSep then Cooler_on else zoneParam.CoolerOn) if staOrDyn annotation (Placement(transformation(extent={{-132,
            -38},{-112,-22}})));
  Modelica.Blocks.Interfaces.RealInput setPointCool(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC") if ((recOrSep and zoneParam.CoolerOn) or (not recOrSep
     and Cooler_on))    annotation (
      Placement(transformation(extent={{-180,-70},{-140,-30}}),
        iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-24,-72})));
  Modelica.Blocks.Interfaces.RealInput setPointHeat(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC") if ((recOrSep and zoneParam.HeaterOn) or (not recOrSep
     and Heater_on))    annotation (
      Placement(transformation(extent={{-180,30},{-140,70}}),iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={22,-72})));
  Modelica.Blocks.Interfaces.BooleanInput heaterActive if not staOrDyn
    "Switches Controller on and off" annotation (Placement(transformation(extent={{-180,0},
            {-140,40}}),
        iconTransformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={68,-72})));
  Modelica.Blocks.Interfaces.BooleanInput coolerActive if not staOrDyn
    "Switches Controller on and off" annotation (Placement(transformation(extent={{-180,
            -40},{-140,0}}),      iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-70,-72})));

// übernommen aus PartialHeaterCoolerPI
  Modelica.Blocks.Interfaces.RealOutput heatingPower(final quantity="HeatFlowRate",
      final unit="W") if ((recOrSep and zoneParam.HeaterOn) or (not recOrSep and Heater_on))
        "Power for heating" annotation (Placement(transformation(extent={{140,10},{180,50}}),
        iconTransformation(extent={{80,20},{120,60}})));
  Modelica.Blocks.Interfaces.RealOutput coolingPower(final quantity="HeatFlowRate",
      final unit="W") if ((recOrSep and zoneParam.CoolerOn) or (not recOrSep and Cooler_on))
        "Power for cooling" annotation (Placement(transformation(extent={{140,-50},{180,-10}}),
        iconTransformation(extent={{80,-26},{120,14}})));

// operative Temperatur
  TOpe tOpe "Calculates the operative temperature as mean of air and radiative temperature from thermal zone" annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-136,68})));
  Modelica.Blocks.Interfaces.RealInput TAir "Indoor air temperature from thermal zone" annotation (Placement(transformation(extent={{20,-20},{-20,20}},
        rotation=90,
        origin={-150,100})));
  Modelica.Blocks.Interfaces.RealInput TRad "Mean indoor radiation temperature from thermal zone" annotation (Placement(transformation(extent={{20,-20},{-20,20}},
        rotation=90,
        origin={-120,100})));

// Heating, Cooling & Control Struktur übernommen aus PartialHeaterCoolerPI
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Heating if ((
    recOrSep and zoneParam.HeaterOn) or (not recOrSep and Heater_on))
    "TABS Ext"                                                     annotation(Placement(transformation(extent={{-10,10},
            {10,-10}},
        rotation=90,
        origin={-40,64})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Heating1 if
                                                                      ((
    recOrSep and zoneParam.HeaterOn) or (not recOrSep and Heater_on))
    "TABS Int"                                                     annotation(Placement(transformation(extent={{-10,10},
            {10,-10}},
        rotation=90,
        origin={-20,64})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Heating2 if
                                                                      ((
    recOrSep and zoneParam.HeaterOn) or (not recOrSep and Heater_on)) "FH Ext"
                                                                   annotation(Placement(transformation(extent={{-10,10},
            {10,-10}},
        rotation=90,
        origin={0,64})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Heating3 if
                                                                      ((
    recOrSep and zoneParam.HeaterOn) or (not recOrSep and Heater_on)) "FH Int"
                                                                   annotation(Placement(transformation(extent={{-10,10},
            {10,-10}},
        rotation=90,
        origin={20,64})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Heating4 if
                                                                      ((
    recOrSep and zoneParam.HeaterOn) or (not recOrSep and Heater_on)) "Rad Ext"
                                                                   annotation(Placement(transformation(extent={{-10,10},
            {10,-10}},
        rotation=90,
        origin={40,64})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Heating5 if
                                                                      ((
    recOrSep and zoneParam.HeaterOn) or (not recOrSep and Heater_on)) "Rad Int"
                                                                   annotation(Placement(transformation(extent={{-10,10},
            {10,-10}},
        rotation=90,
        origin={60,64})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Heating6 if
                                                                      ((
    recOrSep and zoneParam.HeaterOn) or (not recOrSep and Heater_on)) "Conv"
                                                                   annotation(Placement(transformation(extent={{-10,10},
            {10,-10}},
        rotation=90,
        origin={80,64})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Cooling if ((
    recOrSep and zoneParam.CoolerOn) or (not recOrSep and Cooler_on))
    "TABS Ext"                                                     annotation(Placement(transformation(extent={{-10,
            -10.5},{10,10.5}},
        rotation=270,
        origin={-40,-64.5})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Cooling1 if
                                                                      ((
    recOrSep and zoneParam.CoolerOn) or (not recOrSep and Cooler_on)) "TABS Int"
                                                                   annotation(Placement(transformation(extent={{-10,
            -10.5},{10,10.5}},
        rotation=270,
        origin={-20,-64.5})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Cooling2 if
                                                                      ((
    recOrSep and zoneParam.CoolerOn) or (not recOrSep and Cooler_on)) "FHK Ext"
                                                                   annotation(Placement(transformation(extent={{-10,
            -10.5},{10,10.5}},
        rotation=270,
        origin={0,-64.5})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Cooling3 if
                                                                      ((
    recOrSep and zoneParam.CoolerOn) or (not recOrSep and Cooler_on)) "FHK Int"
                                                                   annotation(Placement(transformation(extent={{-10,
            -10.5},{10,10.5}},
        rotation=270,
        origin={20,-64.5})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Cooling4 if
                                                                      ((
    recOrSep and zoneParam.CoolerOn) or (not recOrSep and Cooler_on)) "Rad Ext"
                                                                   annotation(Placement(transformation(extent={{-10,
            -10.5},{10,10.5}},
        rotation=270,
        origin={40,-64.5})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Cooling5 if
                                                                      ((
    recOrSep and zoneParam.CoolerOn) or (not recOrSep and Cooler_on)) "Rad Int"
                                                                   annotation(Placement(transformation(extent={{-10,
            -10.5},{10,10.5}},
        rotation=270,
        origin={60,-64.5})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Cooling6 if
                                                                      ((
    recOrSep and zoneParam.CoolerOn) or (not recOrSep and Cooler_on)) "Conv"
                                                                   annotation(Placement(transformation(extent={{-10,
            -10.5},{10,10.5}},
        rotation=270,
        origin={80,-64.5})));

  PITempOpe pITempHeatPanel(
    p=if not recOrSep then p_heater_Panel else zoneParam.powerHeatPanel,
    rangeSwitch=false,
    h=if not recOrSep then h_heater_Panel else zoneParam.hHeatPanel,
    l=if not recOrSep then l_heater_Panel else zoneParam.lHeatPanel,
    KR=if not recOrSep then KR_heater_Panel else zoneParam.KRHeatPanel,
    TN=if not recOrSep then TN_heater_Panel else zoneParam.TNHeatPanel) if
                                                                ((recOrSep and
    zoneParam.HeaterOn) or (not recOrSep and Heater_on))
    "PI controller for panel heating"
    annotation (Placement(transformation(extent={{2,6},{18,22}})));
    //DELETE
  PITempOpe pITempHeatRem(
    p=if not recOrSep then p_heater_Rem else zoneParam.powerHeatRem,
    rangeSwitch=false,
    h=if not recOrSep then h_heater_Rem else zoneParam.hHeatRem,
    l=if not recOrSep then l_heater_Rem else zoneParam.lHeatRem,
    KR=if not recOrSep then KR_heater_Rem else zoneParam.KRHeatRem,
    TN=if not recOrSep then TN_heater_Rem else zoneParam.TNHeatRem) if
      ((recOrSep and zoneParam.HeaterOn) or (not recOrSep and Heater_on))
    "PI controller for radiative and convective heating system"
    annotation (Placement(transformation(extent={{52,6},{68,22}})));
    //DELETE
  PITempOpe pITempCoolPanel(
    p=if not recOrSep then p_cooler_Panel else zoneParam.powerCoolPanel,
    rangeSwitch=false,
    h=if not recOrSep then h_cooler_Panel else zoneParam.hCoolPanel,
    l=if not recOrSep then l_cooler_Panel else zoneParam.lCoolPanel,
    KR=if not recOrSep then KR_cooler_Panel else zoneParam.KRCoolPanel,
    TN=if not recOrSep then TN_cooler_Panel else zoneParam.TNCoolPanel) if
                                                                ((recOrSep and
    zoneParam.CoolerOn) or (not recOrSep and Cooler_on))
    "PI controller for panel cooling"
    annotation (Placement(transformation(extent={{2,-6},{18,-22}})));
  PITempOpe pITempCoolRem(
    p=if not recOrSep then p_cooler_Rem else zoneParam.powerCoolRem,
    rangeSwitch=false,
    h=if not recOrSep then h_cooler_Rem else zoneParam.hCoolRem,
    l=if not recOrSep then l_cooler_Rem else zoneParam.lCoolRem,
    KR=if not recOrSep then KR_cooler_Rem else zoneParam.KRCoolRem,
    TN=if not recOrSep then TN_cooler_Rem else zoneParam.TNCoolRem) if
                                                                ((recOrSep and
    zoneParam.CoolerOn) or (not recOrSep and Cooler_on))
    "PI controller for radiative and convective cooling system"
    annotation (Placement(transformation(extent={{52,-6},{68,-22}})));
    //DELETE
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatCoolTabsExt
    "Heat port to thermal zone" annotation (Placement(transformation(extent={{-50,86},{-30,106}}),iconTransformation(extent={{-90,86},{-70,106}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatCoolTabsInt
    "Heat port to thermal zone" annotation (Placement(transformation(extent={{-30,86},{-10,106}}),iconTransformation(extent={{-65,86},{-45,106}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatCoolPanelExt
    "Heat port to thermal zone" annotation (Placement(transformation(extent={{-10,86},{10,106}}),iconTransformation(extent={{-40,86},{-20,106}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatCoolPanelInt
    "Heat port to thermal zone" annotation (Placement(transformation(extent={{10,86},{30,106}}),iconTransformation(extent={{-15,86},{5,106}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatCoolRadExt
    "Heat port to thermal zone" annotation (Placement(transformation(extent={{30,86},{50,106}}),iconTransformation(extent={{10,86},{30,106}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatCoolRadInt
    "Heat port to thermal zone" annotation (Placement(transformation(extent={{50,86},{70,106}}),iconTransformation(extent={{35,86},{55,106}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatCoolConv
    "Heat port to thermal zone" annotation (Placement(transformation(extent={{70,86},{90,106}}),iconTransformation(extent={{60,86},{80,106}})));

 // Anteile der Wärmeströme
  Modelica.Blocks.Math.Gain gainHTabsExt(k=if not recOrSep then share_Heater_TabsExt else zoneParam.shareHeatTabsExt) if
       ((recOrSep and zoneParam.HeaterOn) or (not recOrSep and Heater_on)) annotation (
      Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={-40,44})));
  Modelica.Blocks.Math.Gain gainHTabsInt(k=if not recOrSep then share_Heater_TabsInt else zoneParam.shareHeatTabsInt) if
       ((recOrSep and zoneParam.HeaterOn) or (not recOrSep and Heater_on)) annotation (
      Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={-20,44})));
  Modelica.Blocks.Math.Gain gainHPanelExt(k=if not recOrSep then share_Heater_PanelExt else zoneParam.shareHeatPanelExt) if
       ((recOrSep and zoneParam.HeaterOn) or (not recOrSep and Heater_on)) annotation (
      Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={0,44})));
  Modelica.Blocks.Math.Gain gainHPanelInt(k=if not recOrSep then share_Heater_PanelInt else zoneParam.shareHeatPanelInt) if
       ((recOrSep and zoneParam.HeaterOn) or (not recOrSep and Heater_on)) annotation (
      Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={20,44})));
  Modelica.Blocks.Math.Gain gainHRadExt(k=if not recOrSep then share_Heater_RadExt else zoneParam.shareHeatRadExt) if
       ((recOrSep and zoneParam.HeaterOn) or (not recOrSep and Heater_on)) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={40,44})));
  Modelica.Blocks.Math.Gain gainHRadInt(k=if not recOrSep then share_Heater_RadInt else zoneParam.shareHeatRadInt) if
       ((recOrSep and zoneParam.HeaterOn) or (not recOrSep and Heater_on)) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={60,44})));
  Modelica.Blocks.Math.Gain gainHConv(k=if not recOrSep then share_Heater_Conv else zoneParam.shareHeatConv) if
       ((recOrSep and zoneParam.HeaterOn) or (not recOrSep and Heater_on)) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={80,44})));
  Modelica.Blocks.Math.Gain gainCTabsExt(k=if not recOrSep then share_Cooler_TabsExt else zoneParam.shareCoolTabsExt) if
       ((recOrSep and zoneParam.CoolerOn) or (not recOrSep and Cooler_on)) annotation (
      Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=90,
        origin={-40,-42})));
  Modelica.Blocks.Math.Gain gainCTabsInt(k=if not recOrSep then share_Cooler_TabsInt else zoneParam.shareCoolTabsInt) if
       ((recOrSep and zoneParam.CoolerOn) or (not recOrSep and Cooler_on)) annotation (
      Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=90,
        origin={-20,-42})));
  Modelica.Blocks.Math.Gain gainCPanelExt(k=if not recOrSep then share_Cooler_PanelExt else zoneParam.shareCoolPanelExt) if
       ((recOrSep and zoneParam.CoolerOn) or (not recOrSep and Cooler_on)) annotation (
      Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=90,
        origin={0,-42})));
  Modelica.Blocks.Math.Gain gainCPanelInt(k=if not recOrSep then share_Cooler_PanelInt else zoneParam.shareCoolPanelInt) if
       ((recOrSep and zoneParam.CoolerOn) or (not recOrSep and Cooler_on)) annotation (
      Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=90,
        origin={20,-42})));
  Modelica.Blocks.Math.Gain gainCRadExt(k=if not recOrSep then share_Cooler_RadExt else zoneParam.shareCoolRadExt) if
       ((recOrSep and zoneParam.CoolerOn) or (not recOrSep and Cooler_on)) annotation (
      Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=90,
        origin={40,-42})));
  Modelica.Blocks.Math.Gain gainCRadInt(k=if not recOrSep then share_Cooler_RadInt else zoneParam.shareCoolRadInt) if
       ((recOrSep and zoneParam.CoolerOn) or (not recOrSep and Cooler_on)) annotation (
      Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=90,
        origin={60,-42})));
  Modelica.Blocks.Math.Gain gainCConv(k=if not recOrSep then share_Cooler_Conv else zoneParam.shareCoolConv) if
       ((recOrSep and zoneParam.CoolerOn) or (not recOrSep and Cooler_on)) annotation (Placement(
        transformation(
        extent={{4,-4},{-4,4}},
        rotation=90,
        origin={80,-42})));

  Modelica.Blocks.Math.Sum sumHeating(nin=2) if
       ((recOrSep and zoneParam.HeaterOn) or (not recOrSep and Heater_on)) annotation (Placement(transformation(extent={{122,24},{134,36}})));
  Modelica.Blocks.Math.Sum sumCooling(nin=2) if
       ((recOrSep and zoneParam.CoolerOn) or (not recOrSep and Cooler_on)) annotation (Placement(transformation(extent={{122,-36},{134,-24}})));

  // TABS Controller

  Modelica.Blocks.Interfaces.RealInput tabsHeatingPower annotation (Placement(
        transformation(
        extent={{20,-20},{-20,20}},
        rotation=90,
        origin={-90,100}),iconTransformation(extent={{-180,
            0},{-140,40}})));
  Modelica.Blocks.Interfaces.RealInput tabsCoolingPower annotation (Placement(
        transformation(
        extent={{20,-20},{-20,20}},
        rotation=90,
        origin={-64,100}),iconTransformation(extent={{-180,
            -40},{-140,0}})));
equation

  connect(TAir, tOpe.TAir) annotation (Line(points={{-150,100},{-150,78},{-139.2,
          78}},      color={0,0,127}));
  connect(TRad, tOpe.TRad) annotation (Line(points={{-120,100},{-120,78},{-133,78}},
                color={0,0,127}));
  connect(setPointHeat, pITempHeatPanel.setPoint) annotation (Line(points={{-160,
          50},{-68,50},{-68,22},{3.6,22},{3.6,21.2}}, color={0,0,127}));
  connect(setPointHeat, pITempHeatRem.setPoint) annotation (Line(points={{-160,50},
          {-68,50},{-68,22},{53.6,22},{53.6,21.2}}, color={0,0,127}));
  connect(tOpe.TOpe, pITempHeatPanel.TOpe) annotation (Line(points={{-136,58},{-74,
          58},{-74,6},{5.2,6}}, color={0,0,127}));
  connect(tOpe.TOpe, pITempHeatRem.TOpe) annotation (Line(points={{-136,58},{-74,
          58},{-74,6},{55.2,6}}, color={0,0,127}));
  connect(setPointCool, pITempCoolPanel.setPoint) annotation (Line(points={{-160,
          -50},{-68,-50},{-68,-21.2},{3.6,-21.2}}, color={0,0,127}));
  connect(setPointCool, pITempCoolRem.setPoint) annotation (Line(points={{-160,-50},
          {-68,-50},{-68,-21.2},{53.6,-21.2}}, color={0,0,127}));
  connect(tOpe.TOpe, pITempCoolPanel.TOpe) annotation (Line(points={{-136,58},{-74,
          58},{-74,-6},{5.2,-6}}, color={0,0,127}));
  connect(tOpe.TOpe, pITempCoolRem.TOpe) annotation (Line(points={{-136,58},{-74,
          58},{-74,-6},{55.2,-6}}, color={0,0,127}));

// übernommen aus HeaterCoolerPI und nicht sicher was es macht
  if staOrDyn then
  connect(booleanExpressionHeater.y, pITempHeatPanel.onOff) annotation (Line(
      points={{-110.05,28},{-82,28},{-82,10},{2.8,10}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(booleanExpressionHeater.y, pITempHeatRem.onOff) annotation (Line(
      points={{-110.05,28},{-82,28},{-82,10},{52.8,10}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(booleanExpressionCooler.y, pITempCoolPanel.onOff) annotation (Line(
      points={{-111,-30},{-82,-30},{-82,-10},{2.8,-10}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(booleanExpressionCooler.y, pITempCoolRem.onOff) annotation (Line(
      points={{-111,-30},{-82,-30},{-82,-10},{52.8,-10}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  else
  connect(heaterActive, pITempHeatPanel.onOff) annotation (Line(
      points={{-160,20},{-82,20},{-82,10},{2.8,10}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(heaterActive, pITempHeatRem.onOff) annotation (Line(
      points={{-160,20},{-82,20},{-82,10},{52.8,10}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(coolerActive, pITempCoolPanel.onOff) annotation (Line(
      points={{-160,-20},{-82,-20},{-82,-10},{2.8,-10}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(coolerActive, pITempCoolRem.onOff) annotation (Line(
      points={{-160,-20},{-82,-20},{-82,-10},{52.8,-10}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  end if;

  connect(Heating.port, heatCoolTabsExt) annotation (Line(points={{-40,74},{-40,96}}, color={191,0,0}));
  connect(Heating1.port, heatCoolTabsInt) annotation (Line(points={{-20,74},{-20,96}}, color={191,0,0}));
  connect(Heating2.port, heatCoolPanelExt) annotation (Line(points={{6.66134e-16,
          74},{6.66134e-16,78},{0,78},{0,96}}, color={191,0,0}));
  connect(Heating3.port, heatCoolPanelInt) annotation (Line(points={{20,74},{20,96}}, color={191,0,0}));
  connect(Heating4.port, heatCoolRadExt) annotation (Line(points={{40,74},{40,96}}, color={191,0,0}));
  connect(Heating5.port, heatCoolRadInt) annotation (Line(points={{60,74},{60,96}}, color={191,0,0}));
  connect(Heating6.port, heatCoolConv) annotation (Line(points={{80,74},{80,96}}, color={191,0,0}));
  connect(Cooling.port, heatCoolTabsExt) annotation (Line(points={{-40,-74.5},{-40,-80},{100,-80},{100,78},
          {-40,78},{-40,96}},                         color={191,0,0}));
  connect(Cooling1.port, heatCoolTabsInt) annotation (Line(points={{-20,-74.5},{-20,-80},{100,-80},{100,
          78},{-20,78},{-20,96}},                         color={191,0,0}));
  connect(Cooling2.port, heatCoolPanelExt) annotation (Line(points={{-1.77636e-15,-74.5},{-1.77636e-15,-72},
          {0,-72},{0,-80},{100,-80},{100,78},{0,78},{0,96}},
                color={191,0,0}));
  connect(Cooling3.port, heatCoolPanelInt) annotation (Line(points={{20,-74.5},{20,-80},{100,-80},{100,78},
          {20,78},{20,96}},                            color={191,0,0}));
  connect(Cooling4.port, heatCoolRadExt) annotation (Line(points={{40,-74.5},{40,-80},{100,-80},{100,78},
          {40,78},{40,96}},                         color={191,0,0}));
  connect(Cooling5.port, heatCoolRadInt) annotation (Line(points={{60,-74.5},{60,-80},{100,-80},{100,78},
          {60,78},{60,96}},                         color={191,0,0}));
  connect(Cooling6.port, heatCoolConv) annotation (Line(points={{80,-74.5},{80,-80},{100,-80},{100,78},{
          80,78},{80,96}},                     color={191,0,0}));

  connect(gainHTabsExt.y, Heating.Q_flow) annotation (Line(points={{-40,48.4},{-40,54}}, color={0,0,127}));
  connect(gainHTabsInt.y, Heating1.Q_flow) annotation (Line(points={{-20,48.4},{-20,54},{-20,54}}, color={0,0,127}));
  connect(gainHPanelExt.y, Heating2.Q_flow) annotation (Line(points={{0,48.4},{0,54}}, color={0,0,127}));
  connect(gainHPanelInt.y, Heating3.Q_flow) annotation (Line(points={{20,48.4},{20,54}}, color={0,0,127}));
  connect(gainHRadExt.y, Heating4.Q_flow) annotation (Line(points={{40,48.4},{40,54}}, color={0,0,127}));
  connect(gainHRadInt.y, Heating5.Q_flow) annotation (Line(points={{60,48.4},{60,54}}, color={0,0,127}));
  connect(gainHConv.y, Heating6.Q_flow) annotation (Line(points={{80,48.4},{80,54}}, color={0,0,127}));
  connect(pITempHeatPanel.y, gainHPanelExt.u) annotation (Line(points={{18,14},{
          20,14},{20,30},{0,30},{0,42},{-4.44089e-16,42},{-4.44089e-16,39.2}},
        color={0,0,127}));
  connect(pITempHeatPanel.y, gainHPanelInt.u) annotation (Line(points={{18,14},{20,14},{20,39.2}}, color={0,0,127}));
  connect(pITempHeatRem.y, gainHRadExt.u) annotation (Line(points={{68,14},{80,14},
          {80,30},{40,30},{40,39.2}}, color={0,0,127}));
  connect(pITempHeatRem.y, gainHRadInt.u) annotation (Line(points={{68,14},{80,14},
          {80,30},{60,30},{60,39.2}}, color={0,0,127}));
  connect(pITempHeatRem.y, gainHConv.u) annotation (Line(points={{68,14},{80,14},{80,39.2}}, color={0,0,127}));

  connect(gainCTabsExt.y, Cooling.Q_flow) annotation (Line(points={{-40,-46.4},{-40,-54.5}}, color={0,0,127}));
  connect(gainCTabsInt.y, Cooling1.Q_flow) annotation (Line(points={{-20,-46.4},{-20,-54.5}}, color={0,0,127}));
  connect(gainCPanelExt.y, Cooling2.Q_flow) annotation (Line(points={{0,-46.4},{0,-54.5}}, color={0,0,127}));
  connect(gainCPanelInt.y, Cooling3.Q_flow) annotation (Line(points={{20,-46.4},{20,-54.5}}, color={0,0,127}));
  connect(gainCRadExt.y, Cooling4.Q_flow) annotation (Line(points={{40,-46.4},{40,-54.5}}, color={0,0,127}));
  connect(gainCRadInt.y, Cooling5.Q_flow) annotation (Line(points={{60,-46.4},{60,-54.5}}, color={0,0,127}));
  connect(gainCConv.y, Cooling6.Q_flow) annotation (Line(points={{80,-46.4},{80,-54.5}}, color={0,0,127}));
  connect(pITempCoolPanel.y, gainCPanelExt.u) annotation (Line(points={{18,-14},{20,-14},{20,-28},{
          0,-28},{0,-37.2}}, color={0,0,127}));
  connect(pITempCoolPanel.y, gainCPanelInt.u) annotation (Line(points={{18,-14},{20,-14},{20,-37.2}}, color={0,0,127}));
  connect(pITempCoolRem.y, gainCRadExt.u) annotation (Line(points={{68,-14},{80,-14},{80,-28},{40,-28},
          {40,-37.2}}, color={0,0,127}));
  connect(pITempCoolRem.y, gainCRadInt.u) annotation (Line(points={{68,-14},{80,-14},{80,-28},{60,-28},
          {60,-37.2}}, color={0,0,127}));
  connect(pITempCoolRem.y, gainCConv.u) annotation (Line(points={{68,-14},{80,-14},{80,-37.2}}, color={0,0,127}));

  connect(pITempHeatPanel.y, sumHeating.u[2]) annotation (Line(
      points={{18,14},{112,14},{112,30.6},{120.8,30.6}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(pITempHeatRem.y, sumHeating.u[1]) annotation (Line(
      points={{68,14},{112,14},{112,29.4},{120.8,29.4}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(sumHeating.y, heatingPower) annotation (Line(points={{134.6,30},{160,30}}, color={0,0,127}));
  connect(pITempCoolPanel.y, sumCooling.u[2]) annotation (Line(
      points={{18,-14},{112,-14},{112,-29.4},{120.8,-29.4}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(pITempCoolRem.y, sumCooling.u[1]) annotation (Line(
      points={{68,-14},{112,-14},{112,-30.6},{120.8,-30.6}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(sumCooling.y, coolingPower)
    annotation (Line(points={{134.6,-30},{160,-30}}, color={0,0,127}));
  connect(tabsCoolingPower, gainCTabsExt.u) annotation (Line(points={{-64,100},{
          -64,36},{-54,36},{-54,-28},{-40,-28},{-40,-37.2}}, color={0,0,127}));
  connect(tabsCoolingPower, gainCTabsInt.u) annotation (Line(points={{-64,100},{
          -64,36},{-54,36},{-54,-28},{-20,-28},{-20,-37.2}}, color={0,0,127}));
  connect(tabsHeatingPower, gainHTabsExt.u) annotation (Line(points={{-90,100},{
          -90,32},{-40,32},{-40,39.2}}, color={0,0,127}));
  connect(tabsHeatingPower, gainHTabsInt.u) annotation (Line(points={{-90,100},{
          -90,32},{-20,32},{-20,39.2}}, color={0,0,127}));
annotation (Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
This is a heater and/or cooler implemented after VDI 6007 Blatt 1 Anhang C1: Differenzierte Berücksichtigung von Flächenheiz- und
Flächenkühlsystemen beim 2-Kapazitäten-Modell.
   
</p>
<h4>References </h4>
<p>
</p>
</html>",revisions="<html>
<ul>
<li>March, 2021, by Christian Wenzel:<br>First implementation.</li>
</ul>
</html>"), Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,-100},
            {160,100}}),
                   graphics={  Rectangle(extent={{-94,-30},{80,-50}},    lineColor = {135, 135, 135}, fillColor = {135, 135, 135},
            fillPattern =                                                                                                   FillPattern.Solid),                                                                                                    Line(points={{
              -46,-30},{-46,60}},                                                                                                    color={0,
              128,255}),                                                                                                    Line(points={{
              -66,36},{-46,60},{-26,36}},                                                                                                    color={0,
              128,255}),                                                                                                    Line(points={{
              30,-30},{30,60}},                                                                                                    color={255,
              0,0}),                                                                                                    Line(points={{
              10,36},{30,60},{50,36}}, color={255,0,0}),
        Rectangle(
          extent={{-68,-20},{-24,-30}},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{8,-20},{52,-30}},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None)}), Diagram(coordinateSystem(extent={{-160,-100},
            {160,100}})));
end HeaterCoolerWithTabs6007C1;
