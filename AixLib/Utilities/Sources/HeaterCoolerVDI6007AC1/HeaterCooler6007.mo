within AixLib.Utilities.Sources.HeaterCoolerVDI6007AC1;
model HeaterCooler6007

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
    "Switches Controler on and off" annotation (Placement(transformation(extent={{-180,0},
            {-140,40}}),          iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={68,-72})));
  Modelica.Blocks.Interfaces.BooleanInput coolerActive if not staOrDyn
    "Switches Controler on and off" annotation (Placement(transformation(extent={{-180,
            -40},{-140,0}}),      iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-70,-72})));
  Modelica.Blocks.Interfaces.RealOutput heatingPower(final quantity="HeatFlowRate",
      final unit="W") if
                      ((recOrSep and zoneParam.HeaterOn) or (not recOrSep and
    Heater_on))    "Power for heating"
    annotation (Placement(transformation(extent={{160,10},{200,50}}),
        iconTransformation(extent={{80,20},{120,60}})));
  Modelica.Blocks.Interfaces.RealOutput coolingPower(final quantity="HeatFlowRate",
      final unit="W") if
                      ((recOrSep and zoneParam.CoolerOn) or (not recOrSep and
    Cooler_on))    "Power for cooling"
    annotation (Placement(transformation(extent={{160,-50},{200,-10}}),
        iconTransformation(extent={{80,-26},{120,14}})));
  TOpe tOpe "Operative Temperature"
            annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-96,68})));
  Modelica.Blocks.Interfaces.RealInput TAir "Indoor air temperature from Thermal Zone"
    annotation (Placement(transformation(extent={{20,-20},{-20,20}},
        rotation=90,
        origin={-110,100})));
  Modelica.Blocks.Interfaces.RealInput TRad "Mean indoor radiation temperature from Thermal Zone"
    annotation (Placement(transformation(extent={{20,-20},{-20,20}},
        rotation=90,
        origin={-80,100})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Heating if ((
    recOrSep and zoneParam.HeaterOn) or (not recOrSep and Heater_on))
    "TABS Ext"                                                     annotation(Placement(transformation(extent={{-10,10},
            {10,-10}},
        rotation=90,
        origin={-40,52})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Heating1 if
                                                                      ((
    recOrSep and zoneParam.HeaterOn) or (not recOrSep and Heater_on))
    "TABS Int"                                                     annotation(Placement(transformation(extent={{-10,10},
            {10,-10}},
        rotation=90,
        origin={-20,52})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Heating2 if
                                                                      ((
    recOrSep and zoneParam.HeaterOn) or (not recOrSep and Heater_on)) "FHK Ext"
                                                                   annotation(Placement(transformation(extent={{-10,10},
            {10,-10}},
        rotation=90,
        origin={0,52})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Heating3 if
                                                                      ((
    recOrSep and zoneParam.HeaterOn) or (not recOrSep and Heater_on)) "FHK Int"
                                                                   annotation(Placement(transformation(extent={{-10,10},
            {10,-10}},
        rotation=90,
        origin={20,52})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Heating4 if
                                                                      ((
    recOrSep and zoneParam.HeaterOn) or (not recOrSep and Heater_on)) "Rad Ext"
                                                                   annotation(Placement(transformation(extent={{-10,10},
            {10,-10}},
        rotation=90,
        origin={40,52})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Heating5 if
                                                                      ((
    recOrSep and zoneParam.HeaterOn) or (not recOrSep and Heater_on)) "Rad Int"
                                                                   annotation(Placement(transformation(extent={{-10,10},
            {10,-10}},
        rotation=90,
        origin={60,52})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Heating6 if
                                                                      ((
    recOrSep and zoneParam.HeaterOn) or (not recOrSep and Heater_on)) "Conv"
                                                                   annotation(Placement(transformation(extent={{-10,10},
            {10,-10}},
        rotation=90,
        origin={80,52})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Cooling if ((
    recOrSep and zoneParam.CoolerOn) or (not recOrSep and Cooler_on))
    "TABS Ext"                                                     annotation(Placement(transformation(extent={{-10,
            -10.5},{10,10.5}},
        rotation=270,
        origin={-40,-52.5})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Cooling1 if
                                                                      ((
    recOrSep and zoneParam.CoolerOn) or (not recOrSep and Cooler_on))
    "TABS Int"                                                     annotation(Placement(transformation(extent={{-10,
            -10.5},{10,10.5}},
        rotation=270,
        origin={-20,-52.5})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Cooling2 if
                                                                      ((
    recOrSep and zoneParam.CoolerOn) or (not recOrSep and Cooler_on)) "FHK Ext"
                                                                   annotation(Placement(transformation(extent={{-10,
            -10.5},{10,10.5}},
        rotation=270,
        origin={0,-52.5})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Cooling3 if
                                                                      ((
    recOrSep and zoneParam.CoolerOn) or (not recOrSep and Cooler_on)) "FHK Int"
                                                                   annotation(Placement(transformation(extent={{-10,
            -10.5},{10,10.5}},
        rotation=270,
        origin={20,-52.5})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Cooling4 if
                                                                      ((
    recOrSep and zoneParam.CoolerOn) or (not recOrSep and Cooler_on)) "Rad Ext"
                                                                   annotation(Placement(transformation(extent={{-10,
            -10.5},{10,10.5}},
        rotation=270,
        origin={40,-52.5})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Cooling5 if
                                                                      ((
    recOrSep and zoneParam.CoolerOn) or (not recOrSep and Cooler_on)) "Rad Int"
                                                                   annotation(Placement(transformation(extent={{-10,
            -10.5},{10,10.5}},
        rotation=270,
        origin={60,-52.5})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Cooling6 if
                                                                      ((
    recOrSep and zoneParam.CoolerOn) or (not recOrSep and Cooler_on)) "Conv"
                                                                   annotation(Placement(transformation(extent={{-10,
            -10.5},{10,10.5}},
        rotation=270,
        origin={80,-52.5})));
  PITempOpe pITempHeat(
    rangeSwitch=false,
    h=if not recOrSep then h_heater else zoneParam.hHeat,
    l=if not recOrSep then l_heater else zoneParam.lHeat,
    KR=if not recOrSep then KR_heater else zoneParam.KRHeat,
    TN=if not recOrSep then TN_heater else zoneParam.TNHeat) if ((recOrSep and
    zoneParam.HeaterOn) or (not recOrSep and Heater_on))
    annotation (Placement(transformation(extent={{-56,6},{-40,22}})));

  PITempOpe pITempHeat1(
    rangeSwitch=false,
    h=if not recOrSep then h_heater else zoneParam.hHeat,
    l=if not recOrSep then l_heater else zoneParam.lHeat,
    KR=if not recOrSep then KR_heater else zoneParam.KRHeat,
    TN=if not recOrSep then TN_heater else zoneParam.TNHeat) if ((recOrSep and
    zoneParam.HeaterOn) or (not recOrSep and Heater_on))
    annotation (Placement(transformation(extent={{-36,6},{-20,22}})));
  PITempOpe pITempHeat2(
    rangeSwitch=false,
    h=if not recOrSep then h_heater else zoneParam.hHeat,
    l=if not recOrSep then l_heater else zoneParam.lHeat,
    KR=if not recOrSep then KR_heater else zoneParam.KRHeat,
    TN=if not recOrSep then TN_heater else zoneParam.TNHeat) if ((recOrSep and
    zoneParam.HeaterOn) or (not recOrSep and Heater_on))
    annotation (Placement(transformation(extent={{-16,6},{0,22}})));
  PITempOpe pITempHeat3(
    rangeSwitch=false,
    h=if not recOrSep then h_heater else zoneParam.hHeat,
    l=if not recOrSep then l_heater else zoneParam.lHeat,
    KR=if not recOrSep then KR_heater else zoneParam.KRHeat,
    TN=if not recOrSep then TN_heater else zoneParam.TNHeat) if ((recOrSep and
    zoneParam.HeaterOn) or (not recOrSep and Heater_on))
    annotation (Placement(transformation(extent={{4,6},{20,22}})));
  PITempOpe pITempHeat4(
    rangeSwitch=false,
    h=if not recOrSep then h_heater else zoneParam.hHeat,
    l=if not recOrSep then l_heater else zoneParam.lHeat,
    KR=if not recOrSep then KR_heater else zoneParam.KRHeat,
    TN=if not recOrSep then TN_heater else zoneParam.TNHeat) if ((recOrSep and
    zoneParam.HeaterOn) or (not recOrSep and Heater_on))
    annotation (Placement(transformation(extent={{24,6},{40,22}})));
  PITempOpe pITempHeat5(
    rangeSwitch=false,
    h=if not recOrSep then h_heater else zoneParam.hHeat,
    l=if not recOrSep then l_heater else zoneParam.lHeat,
    KR=if not recOrSep then KR_heater else zoneParam.KRHeat,
    TN=if not recOrSep then TN_heater else zoneParam.TNHeat) if ((recOrSep and
    zoneParam.HeaterOn) or (not recOrSep and Heater_on))
    annotation (Placement(transformation(extent={{44,6},{60,22}})));
  PITempOpe pITempHeat6(
    rangeSwitch=false,
    h=if not recOrSep then h_heater else zoneParam.hHeat,
    l=if not recOrSep then l_heater else zoneParam.lHeat,
    KR=if not recOrSep then KR_heater else zoneParam.KRHeat,
    TN=if not recOrSep then TN_heater else zoneParam.TNHeat) if ((recOrSep and
    zoneParam.HeaterOn) or (not recOrSep and Heater_on))
    annotation (Placement(transformation(extent={{64,6},{80,22}})));
  PITempOpe pITempCool(
    rangeSwitch=false,
    h=if not recOrSep then h_cooler else zoneParam.hCool,
    l=if not recOrSep then l_cooler else zoneParam.lCool,
    KR=if not recOrSep then KR_cooler else zoneParam.KRCool,
    TN=if not recOrSep then TN_cooler else zoneParam.TNCool) if ((recOrSep and
    zoneParam.CoolerOn) or (not recOrSep and Cooler_on))
    "PI control for cooler"
    annotation (Placement(transformation(extent={{-56,-6},{-40,-22}})));
  PITempOpe pITempCool1(
    rangeSwitch=false,
    h=if not recOrSep then h_cooler else zoneParam.hCool,
    l=if not recOrSep then l_cooler else zoneParam.lCool,
    KR=if not recOrSep then KR_cooler else zoneParam.KRCool,
    TN=if not recOrSep then TN_cooler else zoneParam.TNCool) if ((recOrSep and
    zoneParam.CoolerOn) or (not recOrSep and Cooler_on))
    "PI control for cooler"
    annotation (Placement(transformation(extent={{-36,-6},{-20,-22}})));
  PITempOpe pITempCool2(
    rangeSwitch=false,
    h=if not recOrSep then h_cooler else zoneParam.hCool,
    l=if not recOrSep then l_cooler else zoneParam.lCool,
    KR=if not recOrSep then KR_cooler else zoneParam.KRCool,
    TN=if not recOrSep then TN_cooler else zoneParam.TNCool) if ((recOrSep and
    zoneParam.CoolerOn) or (not recOrSep and Cooler_on))
    "PI control for cooler"
    annotation (Placement(transformation(extent={{-16,-6},{0,-22}})));
  PITempOpe pITempCool3(
    rangeSwitch=false,
    h=if not recOrSep then h_cooler else zoneParam.hCool,
    l=if not recOrSep then l_cooler else zoneParam.lCool,
    KR=if not recOrSep then KR_cooler else zoneParam.KRCool,
    TN=if not recOrSep then TN_cooler else zoneParam.TNCool) if ((recOrSep and
    zoneParam.CoolerOn) or (not recOrSep and Cooler_on))
    "PI control for cooler"
    annotation (Placement(transformation(extent={{4,-6},{20,-22}})));
  PITempOpe pITempCool4(
    rangeSwitch=false,
    h=if not recOrSep then h_cooler else zoneParam.hCool,
    l=if not recOrSep then l_cooler else zoneParam.lCool,
    KR=if not recOrSep then KR_cooler else zoneParam.KRCool,
    TN=if not recOrSep then TN_cooler else zoneParam.TNCool) if ((recOrSep and
    zoneParam.CoolerOn) or (not recOrSep and Cooler_on))
    "PI control for cooler"
    annotation (Placement(transformation(extent={{24,-6},{40,-22}})));
  PITempOpe pITempCool5(
    rangeSwitch=false,
    h=if not recOrSep then h_cooler else zoneParam.hCool,
    l=if not recOrSep then l_cooler else zoneParam.lCool,
    KR=if not recOrSep then KR_cooler else zoneParam.KRCool,
    TN=if not recOrSep then TN_cooler else zoneParam.TNCool) if ((recOrSep and
    zoneParam.CoolerOn) or (not recOrSep and Cooler_on))
    "PI control for cooler"
    annotation (Placement(transformation(extent={{44,-6},{60,-22}})));
  PITempOpe pITempCool6(
    rangeSwitch=false,
    h=if not recOrSep then h_cooler else zoneParam.hCool,
    l=if not recOrSep then l_cooler else zoneParam.lCool,
    KR=if not recOrSep then KR_cooler else zoneParam.KRCool,
    TN=if not recOrSep then TN_cooler else zoneParam.TNCool) if ((recOrSep and
    zoneParam.CoolerOn) or (not recOrSep and Cooler_on))
    "PI control for cooler"
    annotation (Placement(transformation(extent={{64,-6},{80,-22}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatCoolTabsExt
    "Heat port to thermal zone"
    annotation (Placement(transformation(extent={{-50,86},{-30,106}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatCoolTabsInt
    "Heat port to thermal zone"
    annotation (Placement(transformation(extent={{-30,86},{-10,106}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatCoolFhkExt
    "Heat port to thermal zone"
    annotation (Placement(transformation(extent={{-10,86},{10,106}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatCoolFhkInt
    "Heat port to thermal zone"
    annotation (Placement(transformation(extent={{10,86},{30,106}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatCoolRadExt
    "Heat port to thermal zone"
    annotation (Placement(transformation(extent={{30,86},{50,106}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatCoolRadInt
    "Heat port to thermal zone"
    annotation (Placement(transformation(extent={{50,86},{70,106}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatCoolConv
    "Heat port to thermal zone"
    annotation (Placement(transformation(extent={{70,86},{90,106}})));
equation
        connect(booleanExpressionCooler.y, pITempCool.onOff) annotation (Line(points={{-111,
          -30},{-96,-30},{-96,-10},{-55.2,-10}},
                                               color={255,0,255},
        pattern=LinePattern.Dash));

    connect(coolerActive, pITempCool.onOff)  annotation (Line(points={{-160,-20},
          {-102,-20},{-102,-10},{-55.2,-10}},
                                      color={255,0,255},
        pattern=LinePattern.Dash));
  connect(TAir, tOpe.TAir) annotation (Line(points={{-110,100},{-110,78},{-99.2,
          78}},      color={0,0,127}));
  connect(TRad, tOpe.TRad) annotation (Line(points={{-80,100},{-80,78},{-93,78}},
                color={0,0,127}));

  connect(Heating6.Q_flow, heatingPower)
    annotation (Line(points={{80,42},{80,30},{180,30}}, color={0,0,127}));
  connect(Heating5.Q_flow, heatingPower)
    annotation (Line(points={{60,42},{60,30},{180,30}}, color={0,0,127}));
  connect(Heating4.Q_flow, heatingPower)
    annotation (Line(points={{40,42},{40,30},{180,30}}, color={0,0,127}));
  connect(Heating3.Q_flow, heatingPower)
    annotation (Line(points={{20,42},{20,30},{180,30}}, color={0,0,127}));
  connect(Heating2.Q_flow, heatingPower)
    annotation (Line(points={{0,42},{0,30},{180,30}}, color={0,0,127}));
  connect(Heating1.Q_flow, heatingPower)
    annotation (Line(points={{-20,42},{-20,30},{180,30}}, color={0,0,127}));
  connect(Heating.Q_flow, heatingPower)
    annotation (Line(points={{-40,42},{-40,30},{180,30}}, color={0,0,127}));
  connect(Cooling6.Q_flow, coolingPower)
    annotation (Line(points={{80,-42.5},{80,-30},{180,-30}}, color={0,0,127}));
  connect(Cooling5.Q_flow, coolingPower)
    annotation (Line(points={{60,-42.5},{60,-30},{180,-30}}, color={0,0,127}));
  connect(Cooling4.Q_flow, coolingPower)
    annotation (Line(points={{40,-42.5},{40,-30},{180,-30}}, color={0,0,127}));
  connect(Cooling3.Q_flow, coolingPower)
    annotation (Line(points={{20,-42.5},{20,-30},{180,-30}}, color={0,0,127}));
  connect(Cooling2.Q_flow, coolingPower) annotation (Line(points={{1.77636e-15,-42.5},
          {1.77636e-15,-30},{180,-30}}, color={0,0,127}));
  connect(Cooling1.Q_flow, coolingPower) annotation (Line(points={{-20,-42.5},{-20,
          -30},{180,-30}}, color={0,0,127}));
  connect(Cooling.Q_flow, coolingPower) annotation (Line(points={{-40,-42.5},{-40,
          -30},{180,-30}}, color={0,0,127}));
  connect(pITempHeat.y, Heating.Q_flow)
    annotation (Line(points={{-40,14},{-40,42}}, color={0,0,127}));
  connect(pITempHeat1.y, Heating1.Q_flow)
    annotation (Line(points={{-20,14},{-20,42}}, color={0,0,127}));
  connect(pITempHeat2.y, Heating2.Q_flow) annotation (Line(points={{0,14},{0,42},
          {-4.44089e-16,42}}, color={0,0,127}));
  connect(pITempHeat3.y, Heating3.Q_flow)
    annotation (Line(points={{20,14},{20,42}}, color={0,0,127}));
  connect(pITempHeat4.y, Heating4.Q_flow)
    annotation (Line(points={{40,14},{40,42}}, color={0,0,127}));
  connect(pITempHeat5.y, Heating5.Q_flow)
    annotation (Line(points={{60,14},{60,42}}, color={0,0,127}));
  connect(pITempHeat6.y, Heating6.Q_flow)
    annotation (Line(points={{80,14},{80,42}}, color={0,0,127}));
  connect(setPointHeat, pITempHeat.setPoint) annotation (Line(points={{-160,50},
          {-68,50},{-68,22},{-54.4,22},{-54.4,21.2}}, color={0,0,127}));
  connect(setPointHeat, pITempHeat1.setPoint) annotation (Line(points={{-160,50},
          {-68,50},{-68,22},{-34.4,22},{-34.4,21.2}}, color={0,0,127}));
  connect(setPointHeat, pITempHeat2.setPoint) annotation (Line(points={{-160,50},
          {-68,50},{-68,22},{-14.4,22},{-14.4,21.2}}, color={0,0,127}));
  connect(setPointHeat, pITempHeat3.setPoint) annotation (Line(points={{-160,50},
          {-68,50},{-68,22},{5.6,22},{5.6,21.2}}, color={0,0,127}));
  connect(setPointHeat, pITempHeat4.setPoint) annotation (Line(points={{-160,50},
          {-68,50},{-68,22},{25.6,22},{25.6,21.2}}, color={0,0,127}));
  connect(setPointHeat, pITempHeat5.setPoint) annotation (Line(points={{-160,50},
          {-68,50},{-68,22},{46,22},{46,21.2},{45.6,21.2}}, color={0,0,127}));
  connect(setPointHeat, pITempHeat6.setPoint) annotation (Line(points={{-160,50},
          {-68,50},{-68,22},{65.6,22},{65.6,21.2}}, color={0,0,127}));
  connect(tOpe.TOpe, pITempHeat.TOpe) annotation (Line(points={{-96,58},{-74,58},
          {-74,6},{-52.8,6}}, color={0,0,127}));
  connect(tOpe.TOpe, pITempHeat1.TOpe) annotation (Line(points={{-96,58},{-74,58},
          {-74,6},{-32.8,6}}, color={0,0,127}));
  connect(tOpe.TOpe, pITempHeat2.TOpe) annotation (Line(points={{-96,58},{-74,58},
          {-74,6},{-12.8,6}}, color={0,0,127}));
  connect(tOpe.TOpe, pITempHeat3.TOpe) annotation (Line(points={{-96,58},{-74,58},
          {-74,6},{7.2,6}}, color={0,0,127}));
  connect(tOpe.TOpe, pITempHeat4.TOpe) annotation (Line(points={{-96,58},{-74,58},
          {-74,6},{27.2,6}}, color={0,0,127}));
  connect(tOpe.TOpe, pITempHeat5.TOpe) annotation (Line(points={{-96,58},{-74,58},
          {-74,6},{47.2,6}}, color={0,0,127}));
  connect(tOpe.TOpe, pITempHeat6.TOpe) annotation (Line(points={{-96,58},{-74,58},
          {-74,6},{67.2,6}}, color={0,0,127}));
  connect(heaterActive, pITempHeat.onOff) annotation (Line(points={{-160,20},{
          -116,20},{-116,10},{-55.2,10}},
                                   color={255,0,255},
        pattern=LinePattern.Dash));
  connect(heaterActive, pITempHeat1.onOff) annotation (Line(points={{-160,20},{-116,
          20},{-116,10},{-35.2,10}}, color={255,0,255},
      pattern=LinePattern.Dash));
  connect(heaterActive, pITempHeat2.onOff) annotation (Line(points={{-160,20},{-116,
          20},{-116,10},{-15.2,10}}, color={255,0,255},
      pattern=LinePattern.Dash));
  connect(heaterActive, pITempHeat3.onOff) annotation (Line(points={{-160,20},{-116,
          20},{-116,10},{4.8,10}}, color={255,0,255},
      pattern=LinePattern.Dash));
  connect(heaterActive, pITempHeat4.onOff) annotation (Line(points={{-160,20},{-116,
          20},{-116,10},{24.8,10}}, color={255,0,255},
      pattern=LinePattern.Dash));
  connect(heaterActive, pITempHeat5.onOff) annotation (Line(points={{-160,20},{-116,
          20},{-116,10},{44.8,10}}, color={255,0,255},
      pattern=LinePattern.Dash));
  connect(heaterActive, pITempHeat6.onOff) annotation (Line(points={{-160,20},{-116,
          20},{-116,10},{64.8,10}}, color={255,0,255},
      pattern=LinePattern.Dash));
  connect(booleanExpressionHeater.y, pITempHeat.onOff) annotation (Line(points={{-110.05,
          28},{-82,28},{-82,10},{-55.2,10}},
                                           color={255,0,255},
        pattern=LinePattern.Dash));
  connect(booleanExpressionHeater.y, pITempHeat1.onOff) annotation (Line(points=
         {{-110.05,28},{-82,28},{-82,10},{-35.2,10}}, color={255,0,255},
      pattern=LinePattern.Dash));
  connect(booleanExpressionHeater.y, pITempHeat2.onOff) annotation (Line(points=
         {{-110.05,28},{-82,28},{-82,10},{-15.2,10}}, color={255,0,255},
      pattern=LinePattern.Dash));
  connect(booleanExpressionHeater.y, pITempHeat3.onOff) annotation (Line(points=
         {{-110.05,28},{-82,28},{-82,10},{4.8,10}}, color={255,0,255},
      pattern=LinePattern.Dash));
  connect(booleanExpressionHeater.y, pITempHeat4.onOff) annotation (Line(points=
         {{-110.05,28},{-82,28},{-82,10},{24.8,10}}, color={255,0,255},
      pattern=LinePattern.Dash));
  connect(booleanExpressionHeater.y, pITempHeat5.onOff) annotation (Line(points=
         {{-110.05,28},{-82,28},{-82,10},{44.8,10}}, color={255,0,255},
      pattern=LinePattern.Dash));
  connect(booleanExpressionHeater.y, pITempHeat6.onOff) annotation (Line(points=
         {{-110.05,28},{-82,28},{-82,10},{64.8,10}}, color={255,0,255},
      pattern=LinePattern.Dash));
  connect(setPointCool, pITempCool.setPoint) annotation (Line(points={{-160,-50},
          {-68,-50},{-68,-21.2},{-54.4,-21.2}}, color={0,0,127}));
  connect(setPointCool, pITempCool1.setPoint) annotation (Line(points={{-160,-50},
          {-68,-50},{-68,-21.2},{-34.4,-21.2}}, color={0,0,127}));
  connect(setPointCool, pITempCool2.setPoint) annotation (Line(points={{-160,-50},
          {-68,-50},{-68,-21.2},{-14.4,-21.2}}, color={0,0,127}));
  connect(setPointCool, pITempCool3.setPoint) annotation (Line(points={{-160,-50},
          {-68,-50},{-68,-21.2},{5.6,-21.2}}, color={0,0,127}));
  connect(setPointCool, pITempCool4.setPoint) annotation (Line(points={{-160,-50},
          {-68,-50},{-68,-21.2},{25.6,-21.2}}, color={0,0,127}));
  connect(setPointCool, pITempCool5.setPoint) annotation (Line(points={{-160,-50},
          {-68,-50},{-68,-21.2},{45.6,-21.2}}, color={0,0,127}));
  connect(setPointCool, pITempCool6.setPoint) annotation (Line(points={{-160,-50},
          {-68,-50},{-68,-21.2},{65.6,-21.2}}, color={0,0,127}));
  connect(tOpe.TOpe, pITempCool.TOpe) annotation (Line(points={{-96,58},{-74,58},
          {-74,-6},{-52.8,-6}}, color={0,0,127}));
  connect(tOpe.TOpe, pITempCool1.TOpe) annotation (Line(points={{-96,58},{-74,58},
          {-74,-6},{-32.8,-6}}, color={0,0,127}));
  connect(tOpe.TOpe, pITempCool2.TOpe) annotation (Line(points={{-96,58},{-74,58},
          {-74,-6},{-12.8,-6}}, color={0,0,127}));
  connect(tOpe.TOpe, pITempCool3.TOpe) annotation (Line(points={{-96,58},{-74,58},
          {-74,-6},{7.2,-6}}, color={0,0,127}));
  connect(tOpe.TOpe, pITempCool4.TOpe) annotation (Line(points={{-96,58},{-74,58},
          {-74,-6},{27.2,-6}}, color={0,0,127}));
  connect(tOpe.TOpe, pITempCool5.TOpe) annotation (Line(points={{-96,58},{-74,58},
          {-74,-6},{47.2,-6}}, color={0,0,127}));
  connect(tOpe.TOpe, pITempCool6.TOpe) annotation (Line(points={{-96,58},{-74,58},
          {-74,-6},{67.2,-6}}, color={0,0,127}));
  connect(pITempCool.y, Cooling.Q_flow)
    annotation (Line(points={{-40,-14},{-40,-42.5}}, color={0,0,127}));
  connect(pITempCool1.y, Cooling1.Q_flow)
    annotation (Line(points={{-20,-14},{-20,-42.5}}, color={0,0,127}));
  connect(pITempCool2.y, Cooling2.Q_flow)
    annotation (Line(points={{0,-14},{0,-42.5}}, color={0,0,127}));
  connect(pITempCool3.y, Cooling3.Q_flow)
    annotation (Line(points={{20,-14},{20,-42.5}}, color={0,0,127}));
  connect(pITempCool4.y, Cooling4.Q_flow)
    annotation (Line(points={{40,-14},{40,-42.5}}, color={0,0,127}));
  connect(pITempCool5.y, Cooling5.Q_flow)
    annotation (Line(points={{60,-14},{60,-42.5}}, color={0,0,127}));
  connect(pITempCool6.y, Cooling6.Q_flow)
    annotation (Line(points={{80,-14},{80,-42.5}}, color={0,0,127}));
  connect(Heating.port, heatCoolTabsExt)
    annotation (Line(points={{-40,62},{-40,96}}, color={191,0,0}));
  connect(Heating1.port, heatCoolTabsInt)
    annotation (Line(points={{-20,62},{-20,96}}, color={191,0,0}));
  connect(Heating2.port, heatCoolFhkExt)
    annotation (Line(points={{0,62},{0,96}}, color={191,0,0}));
  connect(Heating3.port, heatCoolFhkInt)
    annotation (Line(points={{20,62},{20,96}}, color={191,0,0}));
  connect(Heating4.port, heatCoolRadExt)
    annotation (Line(points={{40,62},{40,96}}, color={191,0,0}));
  connect(Heating5.port, heatCoolRadInt)
    annotation (Line(points={{60,62},{60,96}}, color={191,0,0}));
  connect(Heating6.port, heatCoolConv)
    annotation (Line(points={{80,62},{80,96}}, color={191,0,0}));
  connect(Cooling.port, heatCoolTabsExt) annotation (Line(points={{-40,-62.5},{-40,
          -80},{120,-80},{120,78},{-40,78},{-40,96}}, color={191,0,0}));
  connect(Cooling1.port, heatCoolTabsInt) annotation (Line(points={{-20,-62.5},{
          -20,-80},{120,-80},{120,78},{-20,78},{-20,96}}, color={191,0,0}));
  connect(Cooling2.port, heatCoolFhkExt) annotation (Line(points={{-1.77636e-15,
          -62.5},{-1.77636e-15,-72},{0,-72},{0,-80},{120,-80},{120,78},{0,78},{0,
          96}}, color={191,0,0}));
  connect(Cooling3.port, heatCoolFhkInt) annotation (Line(points={{20,-62.5},{20,
          -80},{120,-80},{120,78},{20,78},{20,96}}, color={191,0,0}));
  connect(Cooling4.port, heatCoolRadExt) annotation (Line(points={{40,-62.5},{40,
          -80},{120,-80},{120,78},{40,78},{40,96}}, color={191,0,0}));
  connect(heatCoolRadExt, heatCoolRadExt)
    annotation (Line(points={{40,96},{40,96}}, color={191,0,0}));
  connect(Cooling5.port, heatCoolRadInt) annotation (Line(points={{60,-62.5},{60,
          -80},{120,-80},{120,78},{60,78},{60,96}}, color={191,0,0}));
  connect(Cooling6.port, heatCoolConv) annotation (Line(points={{80,-62.5},{80,-80},
          {120,-80},{120,78},{80,78},{80,96}}, color={191,0,0}));
  connect(coolerActive, pITempCool1.onOff) annotation (Line(
      points={{-160,-20},{-102,-20},{-102,-10},{-35.2,-10}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(coolerActive, pITempCool2.onOff) annotation (Line(
      points={{-160,-20},{-102,-20},{-102,-10},{-15.2,-10}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(coolerActive, pITempCool3.onOff) annotation (Line(
      points={{-160,-20},{-102,-20},{-102,-10},{4.8,-10}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(coolerActive, pITempCool4.onOff) annotation (Line(
      points={{-160,-20},{-102,-20},{-102,-10},{24.8,-10}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(coolerActive, pITempCool5.onOff) annotation (Line(
      points={{-160,-20},{-102,-20},{-102,-10},{44.8,-10}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(coolerActive, pITempCool6.onOff) annotation (Line(
      points={{-160,-20},{-102,-20},{-102,-10},{64.8,-10}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(booleanExpressionCooler.y, pITempCool1.onOff) annotation (Line(
      points={{-111,-30},{-96,-30},{-96,-10},{-35.2,-10}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(booleanExpressionCooler.y, pITempCool2.onOff) annotation (Line(
      points={{-111,-30},{-96,-30},{-96,-10},{-15.2,-10}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(booleanExpressionCooler.y, pITempCool3.onOff) annotation (Line(
      points={{-111,-30},{-96,-30},{-96,-10},{4.8,-10}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(booleanExpressionCooler.y, pITempCool4.onOff) annotation (Line(
      points={{-111,-30},{-96,-30},{-96,-10},{24.8,-10}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(booleanExpressionCooler.y, pITempCool5.onOff) annotation (Line(
      points={{-111,-30},{-96,-30},{-96,-10},{44.8,-10}},
      color={255,0,255},
      pattern=LinePattern.Dash));
  connect(booleanExpressionCooler.y, pITempCool6.onOff) annotation (Line(
      points={{-111,-30},{-96,-30},{-96,-10},{64.8,-10}},
      color={255,0,255},
      pattern=LinePattern.Dash));
annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,-100},
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
end HeaterCooler6007;
