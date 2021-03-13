within AixLib.Utilities.Sources;
package HeaterCoolerVDI6007AC1
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
    PITempCwe pITempHeat(
      rangeSwitch=false,
      h=if not recOrSep then h_heater else zoneParam.hHeat,
      l=if not recOrSep then l_heater else zoneParam.lHeat,
      KR=if not recOrSep then KR_heater else zoneParam.KRHeat,
      TN=if not recOrSep then TN_heater else zoneParam.TNHeat) if ((recOrSep and
      zoneParam.HeaterOn) or (not recOrSep and Heater_on))
      annotation (Placement(transformation(extent={{-56,6},{-40,22}})));

    PITempCwe pITempHeat1(
      rangeSwitch=false,
      h=if not recOrSep then h_heater else zoneParam.hHeat,
      l=if not recOrSep then l_heater else zoneParam.lHeat,
      KR=if not recOrSep then KR_heater else zoneParam.KRHeat,
      TN=if not recOrSep then TN_heater else zoneParam.TNHeat) if ((recOrSep and
      zoneParam.HeaterOn) or (not recOrSep and Heater_on))
      annotation (Placement(transformation(extent={{-36,6},{-20,22}})));
    PITempCwe pITempHeat2(
      rangeSwitch=false,
      h=if not recOrSep then h_heater else zoneParam.hHeat,
      l=if not recOrSep then l_heater else zoneParam.lHeat,
      KR=if not recOrSep then KR_heater else zoneParam.KRHeat,
      TN=if not recOrSep then TN_heater else zoneParam.TNHeat) if ((recOrSep and
      zoneParam.HeaterOn) or (not recOrSep and Heater_on))
      annotation (Placement(transformation(extent={{-16,6},{0,22}})));
    PITempCwe pITempHeat3(
      rangeSwitch=false,
      h=if not recOrSep then h_heater else zoneParam.hHeat,
      l=if not recOrSep then l_heater else zoneParam.lHeat,
      KR=if not recOrSep then KR_heater else zoneParam.KRHeat,
      TN=if not recOrSep then TN_heater else zoneParam.TNHeat) if ((recOrSep and
      zoneParam.HeaterOn) or (not recOrSep and Heater_on))
      annotation (Placement(transformation(extent={{4,6},{20,22}})));
    PITempCwe pITempHeat4(
      rangeSwitch=false,
      h=if not recOrSep then h_heater else zoneParam.hHeat,
      l=if not recOrSep then l_heater else zoneParam.lHeat,
      KR=if not recOrSep then KR_heater else zoneParam.KRHeat,
      TN=if not recOrSep then TN_heater else zoneParam.TNHeat) if ((recOrSep and
      zoneParam.HeaterOn) or (not recOrSep and Heater_on))
      annotation (Placement(transformation(extent={{24,6},{40,22}})));
    PITempCwe pITempHeat5(
      rangeSwitch=false,
      h=if not recOrSep then h_heater else zoneParam.hHeat,
      l=if not recOrSep then l_heater else zoneParam.lHeat,
      KR=if not recOrSep then KR_heater else zoneParam.KRHeat,
      TN=if not recOrSep then TN_heater else zoneParam.TNHeat) if ((recOrSep and
      zoneParam.HeaterOn) or (not recOrSep and Heater_on))
      annotation (Placement(transformation(extent={{44,6},{60,22}})));
    PITempCwe pITempHeat6(
      rangeSwitch=false,
      h=if not recOrSep then h_heater else zoneParam.hHeat,
      l=if not recOrSep then l_heater else zoneParam.lHeat,
      KR=if not recOrSep then KR_heater else zoneParam.KRHeat,
      TN=if not recOrSep then TN_heater else zoneParam.TNHeat) if ((recOrSep and
      zoneParam.HeaterOn) or (not recOrSep and Heater_on))
      annotation (Placement(transformation(extent={{64,6},{80,22}})));
    PITempCwe pITempCool(
      rangeSwitch=false,
      h=if not recOrSep then h_cooler else zoneParam.hCool,
      l=if not recOrSep then l_cooler else zoneParam.lCool,
      KR=if not recOrSep then KR_cooler else zoneParam.KRCool,
      TN=if not recOrSep then TN_cooler else zoneParam.TNCool) if ((recOrSep and
      zoneParam.CoolerOn) or (not recOrSep and Cooler_on))
      "PI control for cooler"
      annotation (Placement(transformation(extent={{-56,-6},{-40,-22}})));
    PITempCwe pITempCool1(
      rangeSwitch=false,
      h=if not recOrSep then h_cooler else zoneParam.hCool,
      l=if not recOrSep then l_cooler else zoneParam.lCool,
      KR=if not recOrSep then KR_cooler else zoneParam.KRCool,
      TN=if not recOrSep then TN_cooler else zoneParam.TNCool) if ((recOrSep and
      zoneParam.CoolerOn) or (not recOrSep and Cooler_on))
      "PI control for cooler"
      annotation (Placement(transformation(extent={{-36,-6},{-20,-22}})));
    PITempCwe pITempCool2(
      rangeSwitch=false,
      h=if not recOrSep then h_cooler else zoneParam.hCool,
      l=if not recOrSep then l_cooler else zoneParam.lCool,
      KR=if not recOrSep then KR_cooler else zoneParam.KRCool,
      TN=if not recOrSep then TN_cooler else zoneParam.TNCool) if ((recOrSep and
      zoneParam.CoolerOn) or (not recOrSep and Cooler_on))
      "PI control for cooler"
      annotation (Placement(transformation(extent={{-16,-6},{0,-22}})));
    PITempCwe pITempCool3(
      rangeSwitch=false,
      h=if not recOrSep then h_cooler else zoneParam.hCool,
      l=if not recOrSep then l_cooler else zoneParam.lCool,
      KR=if not recOrSep then KR_cooler else zoneParam.KRCool,
      TN=if not recOrSep then TN_cooler else zoneParam.TNCool) if ((recOrSep and
      zoneParam.CoolerOn) or (not recOrSep and Cooler_on))
      "PI control for cooler"
      annotation (Placement(transformation(extent={{4,-6},{20,-22}})));
    PITempCwe pITempCool4(
      rangeSwitch=false,
      h=if not recOrSep then h_cooler else zoneParam.hCool,
      l=if not recOrSep then l_cooler else zoneParam.lCool,
      KR=if not recOrSep then KR_cooler else zoneParam.KRCool,
      TN=if not recOrSep then TN_cooler else zoneParam.TNCool) if ((recOrSep and
      zoneParam.CoolerOn) or (not recOrSep and Cooler_on))
      "PI control for cooler"
      annotation (Placement(transformation(extent={{24,-6},{40,-22}})));
    PITempCwe pITempCool5(
      rangeSwitch=false,
      h=if not recOrSep then h_cooler else zoneParam.hCool,
      l=if not recOrSep then l_cooler else zoneParam.lCool,
      KR=if not recOrSep then KR_cooler else zoneParam.KRCool,
      TN=if not recOrSep then TN_cooler else zoneParam.TNCool) if ((recOrSep and
      zoneParam.CoolerOn) or (not recOrSep and Cooler_on))
      "PI control for cooler"
      annotation (Placement(transformation(extent={{44,-6},{60,-22}})));
    PITempCwe pITempCool6(
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

  model TOpe
    "Operative temperature"
    Modelica.Blocks.Math.Add add annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={30,0})));
    Modelica.Blocks.Math.Gain gainTempOp(k=0.5)
      annotation (Placement(transformation(extent={{0,-10},{-20,10}})));
    Modelica.Blocks.Interfaces.RealOutput TOpe "Operative temperature as the average of the mean radiant and ambient air temperatures" annotation (Placement(
          transformation(extent={{-80,-20},{-120,20}}),  iconTransformation(
            extent={{-80,-20},{-120,20}})));
    Modelica.Blocks.Interfaces.RealInput TAir "Indoor air temperature from Thermal Zone"
      annotation (Placement(transformation(extent={{120,12},{80,52}})));
    Modelica.Blocks.Interfaces.RealInput TRad "Mean indoor radiation temperature from Thermal Zone"
      annotation (Placement(transformation(extent={{120,-50},{80,-10}})));
  equation
    connect(gainTempOp.u, add.y) annotation (Line(points={{2,0},{12,0},{12,8.88178e-16},
            {19,8.88178e-16}}, color={0,0,127}));
    connect(gainTempOp.y, TOpe)
      annotation (Line(points={{-21,0},{-100,0}}, color={0,0,127}));
    connect(TAir, add.u1) annotation (Line(points={{100,32},{80,32},{80,6},{42,
            6}},
          color={0,0,127}));
    connect(TRad, add.u2) annotation (Line(points={{100,-30},{81,-30},{81,-6},{
            42,-6}},
                  color={0,0,127}));
    annotation (Documentation(revisions="<html>
  <ul>
  <li>
  February 19, 2021, by Christian Wenzel:<br/>
  First implementation.
  </li>
  </ul>
</html>",     info="<html>
<p>This model calculates the operative temperature as the average of the mean radiant and ambient air temperatures.
  </p>
  </html>"),
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                Rectangle(extent = {{-80, 80}, {80, -80}}, lineColor = {135, 135, 135}, fillColor = {255, 255, 170},
              fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{-58, 32}, {62, -20}}, lineColor = {175, 175, 175}, textString = "%name")}), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end TOpe;

  model PITempCwe "PI controller"

    Modelica.Blocks.Interfaces.RealInput setPoint annotation (Placement(
          transformation(
          origin={-80,90},
          extent={{-10,-10},{10,10}},
          rotation=270)));
    parameter Real h = 1 "upper limit controller output" annotation(Dialog(group = "Control"));
    parameter Real l = 0 "lower limit of controller output" annotation(Dialog(group = "Control"));
    parameter Real KR = 1 "Gain" annotation(Dialog(group = "Control"));
    parameter Modelica.SIunits.Time TN = 1 "Time Constant (T>0 required)" annotation(Dialog(group = "Control"));
    parameter Real p = 0 "Power" annotation(Dialog(group = "Control"));
    Modelica.Blocks.Interfaces.RealOutput y annotation(Placement(transformation(extent={{90,-10},
              {110,10}}),                                                                                         iconTransformation(extent={{90,-10},
              {110,10}})));
    parameter Boolean rangeSwitch = false "Switch controller output range";
    Modelica.Blocks.Interfaces.BooleanInput onOff "Switches Controler on and off" annotation(Placement(transformation(extent = {{-120, -80}, {-80, -40}}), iconTransformation(extent = {{-100, -60}, {-80, -40}})));
    Modelica.Blocks.Logical.Switch switch2 annotation(Placement(transformation(extent={{40,-10},
              {60,10}})));
    Modelica.Blocks.Logical.TriggeredTrapezoid triggeredTrapezoid(rising = 0, falling = 60) annotation(Placement(transformation(extent = {{-40, -60}, {-20, -40}})));
    Modelica.Blocks.Math.Product product annotation(Placement(transformation(extent={{10,-26},
              {30,-46}})));
    Modelica.Blocks.Continuous.LimPID PI(k = KR, yMax = if rangeSwitch then -l else h, yMin = if rangeSwitch then -h else l, controllerType = Modelica.Blocks.Types.SimpleController.PI, Ti = TN, Td = 0.1) annotation(Placement(transformation(extent = {{-18, 30}, {2, 50}})));
    Modelica.Blocks.Logical.Switch switch1
      annotation (Placement(transformation(extent={{-54,8},{-34,28}})));
    Modelica.Blocks.Interfaces.RealInput TOpe "Input for operative temperature"
      annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={-60,-100})));
    Modelica.Blocks.Math.Gain power(k = p)
      annotation (Placement(transformation(extent={{68,-8},{84,8}})));
  equation
    connect(onOff, switch2.u2) annotation(Line(points={{-100,-60},{-80,-60},{-80,-18},
            {-16,-18},{-16,0},{38,0}},                                                                                                                color = {255, 0, 255}));
    connect(onOff, triggeredTrapezoid.u) annotation(Line(points = {{-100, -60}, {-80, -60}, {-80, -30}, {-50, -30}, {-50, -50}, {-42, -50}}, color = {255, 0, 255}));
    connect(triggeredTrapezoid.y, product.u1) annotation(Line(points={{-19,-50},{-2,
            -50},{-2,-42},{8,-42}},                                                             color = {0, 0, 127}));
    connect(product.y, switch2.u3) annotation(Line(points={{31,-36},{34,-36},{34,-8},
            {38,-8}},                                                                                     color = {0, 0, 127}));
    connect(PI.y, switch2.u1) annotation(Line(points={{3,40},{8,40},{8,8},{38,8}},            color = {0, 0, 127}));
    connect(PI.y, product.u2) annotation(Line(points={{3,40},{8,40},{8,-30}},                     color = {0, 0, 127}));
    connect(setPoint, PI.u_s)
      annotation (Line(points={{-80,90},{-80,40},{-20,40}}, color={0,0,127}));
    connect(onOff, switch1.u2) annotation (Line(points={{-100,-60},{-78,-60},{-78,
            18},{-56,18}}, color={255,0,255}));
    connect(switch1.y, PI.u_m)
      annotation (Line(points={{-33,18},{-8,18},{-8,28}}, color={0,0,127}));
    connect(setPoint, switch1.u3)
      annotation (Line(points={{-80,90},{-80,10},{-56,10}}, color={0,0,127}));
    connect(TOpe, switch1.u1)
      annotation (Line(points={{-60,-100},{-60,26},{-56,26}}, color={0,0,127}));
    connect(switch2.y, power.u)
      annotation (Line(points={{61,0},{66.4,0}}, color={0,0,127}));
    connect(power.y, y)
      annotation (Line(points={{84.8,0},{100,0}}, color={0,0,127}));
    connect(y, y) annotation (Line(points={{100,0},{100,0}}, color={0,0,127}));
    annotation (Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Based on a model by Alexander Hoh with some modifications and the
  Modelica-Standard PI controller. If set to \"on\" it will controll the
  thermal port temperature to the target value (soll). If set to \"off\"
  the controller error will become zero and therefore the current
  output level of the PI controller will remain constant. When this
  switching occurs the TriggeredTrapezoid will level the current
  controller output down to zero in a selectable period of time.
</p>
<ul>
  <li>
    <i>April, 2016&#160;</i> by Peter Remmen:<br/>
    Moved from Utilities to Controls
  </li>
</ul>
<ul>
  <li>
    <i>October 7, 2013&#160;</i> by Ole Odendahl:<br/>
    Formatted documentation appropriately
  </li>
  <li>by Peter Matthes:<br/>
    implemented
  </li>
</ul>
</html> "),   Icon(graphics={  Rectangle(extent = {{-80, 80}, {80, -80}}, lineColor = {135, 135, 135}, fillColor = {255, 255, 170},
              fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{-58, 32}, {62, -20}}, lineColor = {175, 175, 175}, textString = "%name")}));
  end PITempCwe;

  model HeaterCooler6007_2

  // Heiz- und Kühlsystemparameter
    parameter Modelica.SIunits.Power powerHeatTabs = 0 annotation(Dialog(tab = "Heater", group = "Heating"));
    parameter Modelica.SIunits.Power powerHeatPanel = 0 annotation(Dialog(tab = "Heater", group = "Heating"));
    parameter Modelica.SIunits.Power powerHeatRem = 0 annotation(Dialog(tab = "Heater", group = "Heating"));
    parameter Modelica.SIunits.Power powerCoolTabs = 0 annotation(Dialog(tab = "Cooler", group = "Cooling"));
    parameter Modelica.SIunits.Power powerCoolPanel = 0 annotation(Dialog(tab = "Cooler", group = "Cooling"));
    parameter Modelica.SIunits.Power powerCoolRem = 0 annotation(Dialog(tab = "Cooler", group = "Cooling"));
    parameter Real shareHeatTabsExt(min=0, max=1) annotation(Dialog(tab = "Heater", group = "Heating"));
    parameter Real shareHeatTabsInt(min=0, max=1) annotation(Dialog(tab = "Heater", group = "Heating"));
    parameter Real shareHeatPanelExt(min=0, max=1) annotation(Dialog(tab = "Heater", group = "Heating"));
    parameter Real shareHeatPanelInt(min=0, max=1) annotation(Dialog(tab = "Heater", group = "Heating"));
    parameter Real shareHeatRadExt(min=0, max=1) annotation(Dialog(tab = "Heater", group = "Heating"));
    parameter Real shareHeatRadInt(min=0, max=1) annotation(Dialog(tab = "Heater", group = "Heating"));
    parameter Real shareHeatConv(min=0, max=1) annotation(Dialog(tab = "Heater", group = "Heating"));
    parameter Real shareCoolTabsExt(min=0, max=1) annotation(Dialog(tab = "Cooler", group = "Cooling"));
    parameter Real shareCoolTabsInt(min=0, max=1) annotation(Dialog(tab = "Cooler", group = "Cooling"));
    parameter Real shareCoolPanelExt(min=0, max=1) annotation(Dialog(tab = "Cooler", group = "Cooling"));
    parameter Real shareCoolPanelInt(min=0, max=1) annotation(Dialog(tab = "Cooler", group = "Cooling"));
    parameter Real shareCoolRadExt(min=0, max=1) annotation(Dialog(tab = "Cooler", group = "Cooling"));
    parameter Real shareCoolRadInt(min=0, max=1) annotation(Dialog(tab = "Cooler", group = "Cooling"));
    parameter Real shareCoolConv(min=0, max=1) annotation(Dialog(tab = "Cooler", group = "Cooling"));

  // von HeaterCoolerPI übernommen, nicht sicher was es macht
    parameter Boolean staOrDyn = true "Static or dynamic activation of heater" annotation(choices(choice = true "Static", choice =  false "Dynamic",
                    radioButtons = true));
    Modelica.Blocks.Sources.BooleanExpression booleanExpressionHeater(y=if not
          recOrSep then Heater_on else zoneParam.HeaterOn) if staOrDyn annotation (Placement(transformation(extent={{-130,20},
              {-111,36}})));
    Modelica.Blocks.Sources.BooleanExpression booleanExpressionCooler(y=if not
          recOrSep then Cooler_on else zoneParam.CoolerOn) if staOrDyn annotation (Placement(transformation(extent={{-132,
              -38},{-112,-22}})));

  // von PartialHeaterCoolerPI übernommen, nicht sicher was es macht
    parameter Boolean Heater_on = true "Activates the heater" annotation(Dialog(tab = "Heater",enable=not recOrSep));
    parameter Boolean Cooler_on = true "Activates the cooler" annotation(Dialog(tab = "Cooler",enable=not recOrSep));
    parameter Real h_heater = 0 "Upper limit controller output of the heater" annotation(Dialog(tab = "Heater", group = "Controller",enable=not recOrSep));
    parameter Real l_heater = 0 "Lower limit controller output of the heater" annotation(Dialog(tab = "Heater", group = "Controller",enable=not recOrSep));
    parameter Real KR_heater_TABS = 18 "Gain of the heating controller" annotation(Dialog(tab = "Heater", group = "Controller",enable=not recOrSep));
    parameter Modelica.SIunits.Time TN_heater_TABS = 2300 "Time constant of the heating controller" annotation(Dialog(tab = "Heater", group = "Controller",enable=not recOrSep));
    parameter Real KR_heater_Panel = 0.1 "Gain of the heating controller" annotation(Dialog(tab = "Heater", group = "Controller",enable=not recOrSep));
    parameter Modelica.SIunits.Time TN_heater_Panel = 4 "Time constant of the heating controller" annotation(Dialog(tab = "Heater", group = "Controller",enable=not recOrSep));
    parameter Real KR_heater_Rem = 0.1 "Gain of the heating controller" annotation(Dialog(tab = "Heater", group = "Controller",enable=not recOrSep));
    parameter Modelica.SIunits.Time TN_heater_Rem = 4 "Time constant of the heating controller" annotation(Dialog(tab = "Heater", group = "Controller",enable=not recOrSep));
    parameter Real h_cooler = 0 "Upper limit controller output of the cooler" annotation(Dialog(tab = "Cooler", group = "Controller",enable=not recOrSep));
    parameter Real l_cooler = 0 "Lower limit controller output of the cooler" annotation(Dialog(tab = "Cooler", group = "Controller",enable=not recOrSep));
    parameter Real KR_cooler_TABS = 18 "Gain of the cooling controller" annotation(Dialog(tab = "Cooler", group = "Controller",enable=not recOrSep));
    parameter Modelica.SIunits.Time TN_cooler_TABS = 2300 "Time constant of the cooling controller" annotation(Dialog(tab = "Cooler", group = "Controller",enable=not recOrSep));
    parameter Real KR_cooler_Panel = 0.1 "Gain of the cooling controller" annotation(Dialog(tab = "Cooler", group = "Controller",enable=not recOrSep));
    parameter Modelica.SIunits.Time TN_cooler_Panel = 4 "Time constant of the cooling controller" annotation(Dialog(tab = "Cooler", group = "Controller",enable=not recOrSep));
    parameter Real KR_cooler_Rem = 0.1 "Gain of the cooling controller" annotation(Dialog(tab = "Cooler", group = "Controller",enable=not recOrSep));
    parameter Modelica.SIunits.Time TN_cooler_Rem = 4 "Time constant of the cooling controller" annotation(Dialog(tab = "Cooler", group = "Controller",enable=not recOrSep));
    parameter Boolean recOrSep = false "Use record or seperate parameters" annotation(choices(choice =  false
          "Seperate",choice = true "Record",radioButtons = true));
    parameter AixLib.DataBase.ThermalZones.ZoneBaseRecord zoneParam = AixLib.DataBase.ThermalZones.ZoneRecordDummy()
      "Zone definition" annotation(choicesAllMatching=true,Dialog(enable=recOrSep));

  // übernommen aus HeaterCoolerPI
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
    TOpe tOpe "Operative Temperature" annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-96,68})));
    Modelica.Blocks.Interfaces.RealInput TAir "Indoor air temperature from Thermal Zone" annotation (Placement(transformation(extent={{20,-20},{-20,20}},
          rotation=90,
          origin={-110,100})));
    Modelica.Blocks.Interfaces.RealInput TRad "Mean indoor radiation temperature from Thermal Zone" annotation (Placement(transformation(extent={{20,-20},{-20,20}},
          rotation=90,
          origin={-80,100})));

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
    PITempCwe pITempHeatTabs(
      p=powerHeatTabs,
      rangeSwitch=false,
      h=if not recOrSep then h_heater else zoneParam.hHeat,
      l=if not recOrSep then l_heater else zoneParam.lHeat,
      KR=if not recOrSep then KR_heater_TABS else zoneParam.KRHeat,
      TN=if not recOrSep then TN_heater_TABS else zoneParam.TNHeat) if
                                                                  ((recOrSep and
      zoneParam.HeaterOn) or (not recOrSep and Heater_on))
      annotation (Placement(transformation(extent={{-38,6},{-22,22}})));

    PITempCwe pITempHeatPanel(
      p=powerHeatPanel,
      rangeSwitch=false,
      h=if not recOrSep then h_heater else zoneParam.hHeat,
      l=if not recOrSep then l_heater else zoneParam.lHeat,
      KR=if not recOrSep then KR_heater_Panel else zoneParam.KRHeat,
      TN=if not recOrSep then TN_heater_Panel else zoneParam.TNHeat) if
                                                                  ((recOrSep and
      zoneParam.HeaterOn) or (not recOrSep and Heater_on))
      annotation (Placement(transformation(extent={{2,6},{18,22}})));
    PITempCwe pITempHeatRem(
      p=powerHeatRem,
      rangeSwitch=false,
      h=if not recOrSep then h_heater else zoneParam.hHeat,
      l=if not recOrSep then l_heater else zoneParam.lHeat,
      KR=if not recOrSep then KR_heater_Rem else zoneParam.KRHeat,
      TN=if not recOrSep then TN_heater_Rem else zoneParam.TNHeat) if
                                                                  ((recOrSep and
      zoneParam.HeaterOn) or (not recOrSep and Heater_on))
      annotation (Placement(transformation(extent={{52,6},{68,22}})));
    PITempCwe pITempCoolTabs(
      p=powerCoolTabs,
      rangeSwitch=false,
      h=if not recOrSep then h_cooler else zoneParam.hCool,
      l=if not recOrSep then l_cooler else zoneParam.lCool,
      KR=if not recOrSep then KR_cooler_TABS else zoneParam.KRCool,
      TN=if not recOrSep then TN_cooler_TABS else zoneParam.TNCool) if
                                                                  ((recOrSep and
      zoneParam.CoolerOn) or (not recOrSep and Cooler_on))
      "PI control for cooler"
      annotation (Placement(transformation(extent={{-38,-6},{-22,-22}})));
    PITempCwe pITempCoolPanel(
      p=powerCoolPanel,
      rangeSwitch=false,
      h=if not recOrSep then h_cooler else zoneParam.hCool,
      l=if not recOrSep then l_cooler else zoneParam.lCool,
      KR=if not recOrSep then KR_cooler_Panel else zoneParam.KRCool,
      TN=if not recOrSep then TN_cooler_Panel else zoneParam.TNCool) if
                                                                  ((recOrSep and
      zoneParam.CoolerOn) or (not recOrSep and Cooler_on))
      "PI control for cooler"
      annotation (Placement(transformation(extent={{2,-6},{18,-22}})));
    PITempCwe pITempCoolRem(
      p=powerCoolRem,
      rangeSwitch=false,
      h=if not recOrSep then h_cooler else zoneParam.hCool,
      l=if not recOrSep then l_cooler else zoneParam.lCool,
      KR=if not recOrSep then KR_cooler_Rem else zoneParam.KRCool,
      TN=if not recOrSep then TN_cooler_Rem else zoneParam.TNCool) if
                                                                  ((recOrSep and
      zoneParam.CoolerOn) or (not recOrSep and Cooler_on))
      "PI control for cooler"
      annotation (Placement(transformation(extent={{52,-6},{68,-22}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatCoolTabsExt
      "Heat port to thermal zone" annotation (Placement(transformation(extent={{-50,86},{-30,106}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatCoolTabsInt
      "Heat port to thermal zone" annotation (Placement(transformation(extent={{-30,86},{-10,106}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatCoolPanelExt
      "Heat port to thermal zone" annotation (Placement(transformation(extent={{-10,86},{10,106}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatCoolPanelInt
      "Heat port to thermal zone" annotation (Placement(transformation(extent={{10,86},{30,106}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatCoolRadExt
      "Heat port to thermal zone" annotation (Placement(transformation(extent={{30,86},{50,106}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatCoolRadInt
      "Heat port to thermal zone" annotation (Placement(transformation(extent={{50,86},{70,106}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatCoolConv
      "Heat port to thermal zone" annotation (Placement(transformation(extent={{70,86},{90,106}})));

   // Anteile der Wärmeströme
    Modelica.Blocks.Math.Gain gainHTabsExt(k=shareHeatTabsExt) annotation (
        Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=90,
          origin={-40,44})));
    Modelica.Blocks.Math.Gain gainHTabsInt(k=shareHeatTabsInt) annotation (
        Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=90,
          origin={-20,44})));
    Modelica.Blocks.Math.Gain gainHPanelExt(k=shareHeatPanelExt) annotation (
        Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=90,
          origin={0,44})));
    Modelica.Blocks.Math.Gain gainHPanelInt(k=shareHeatPanelInt) annotation (
        Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=90,
          origin={20,44})));
    Modelica.Blocks.Math.Gain gainHRadExt(k=shareHeatRadExt) annotation (Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=90,
          origin={40,44})));
    Modelica.Blocks.Math.Gain gainHRadInt(k=shareHeatRadInt) annotation (Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=90,
          origin={60,44})));
    Modelica.Blocks.Math.Gain gainHConv(k=shareHeatConv) annotation (Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=90,
          origin={80,44})));
    Modelica.Blocks.Math.Gain gainCTabsExt(k=shareCoolTabsExt) annotation (
        Placement(transformation(
          extent={{4,-4},{-4,4}},
          rotation=90,
          origin={-40,-42})));
    Modelica.Blocks.Math.Gain gainCTabsInt(k=shareCoolTabsInt) annotation (
        Placement(transformation(
          extent={{4,-4},{-4,4}},
          rotation=90,
          origin={-20,-42})));
    Modelica.Blocks.Math.Gain gainCPanelExt(k=shareCoolPanelExt) annotation (
        Placement(transformation(
          extent={{4,-4},{-4,4}},
          rotation=90,
          origin={0,-42})));
    Modelica.Blocks.Math.Gain gainCPanelInt(k=shareCoolPanelInt) annotation (
        Placement(transformation(
          extent={{4,-4},{-4,4}},
          rotation=90,
          origin={20,-42})));
    Modelica.Blocks.Math.Gain gainCRadExt(k=shareCoolRadExt) annotation (
        Placement(transformation(
          extent={{4,-4},{-4,4}},
          rotation=90,
          origin={40,-42})));
    Modelica.Blocks.Math.Gain gainCRadInt(k=shareCoolRadInt) annotation (
        Placement(transformation(
          extent={{4,-4},{-4,4}},
          rotation=90,
          origin={60,-42})));
    Modelica.Blocks.Math.Gain gainCConv(k=shareCoolConv) annotation (Placement(
          transformation(
          extent={{4,-4},{-4,4}},
          rotation=90,
          origin={80,-42})));

    Modelica.Blocks.Math.Sum sumHeating(nin=3) annotation (Placement(transformation(extent={{122,24},{134,36}})));
    Modelica.Blocks.Math.Sum sumCooling(nin=3) annotation (Placement(transformation(extent={{122,-36},{134,-24}})));
  equation

    connect(TAir, tOpe.TAir) annotation (Line(points={{-110,100},{-110,78},{-99.2,
            78}},      color={0,0,127}));
    connect(TRad, tOpe.TRad) annotation (Line(points={{-80,100},{-80,78},{-93,78}},
                  color={0,0,127}));
    connect(setPointHeat, pITempHeatTabs.setPoint) annotation (Line(points={{-160,
            50},{-68,50},{-68,22},{-36.4,22},{-36.4,21.2}}, color={0,0,127}));
    connect(setPointHeat, pITempHeatPanel.setPoint) annotation (Line(points={{-160,
            50},{-68,50},{-68,22},{3.6,22},{3.6,21.2}}, color={0,0,127}));
    connect(setPointHeat, pITempHeatRem.setPoint) annotation (Line(points={{-160,50},
            {-68,50},{-68,22},{53.6,22},{53.6,21.2}}, color={0,0,127}));
    connect(tOpe.TOpe, pITempHeatTabs.TOpe) annotation (Line(points={{-96,58},{-74,
            58},{-74,6},{-34.8,6}}, color={0,0,127}));
    connect(tOpe.TOpe, pITempHeatPanel.TOpe) annotation (Line(points={{-96,58},{-74,
            58},{-74,6},{5.2,6}}, color={0,0,127}));
    connect(tOpe.TOpe, pITempHeatRem.TOpe) annotation (Line(points={{-96,58},{-74,
            58},{-74,6},{55.2,6}}, color={0,0,127}));
    connect(setPointCool, pITempCoolTabs.setPoint) annotation (Line(points={{-160,
            -50},{-68,-50},{-68,-21.2},{-36.4,-21.2}}, color={0,0,127}));
    connect(setPointCool, pITempCoolPanel.setPoint) annotation (Line(points={{-160,
            -50},{-68,-50},{-68,-21.2},{3.6,-21.2}}, color={0,0,127}));
    connect(setPointCool, pITempCoolRem.setPoint) annotation (Line(points={{-160,-50},
            {-68,-50},{-68,-21.2},{53.6,-21.2}}, color={0,0,127}));
    connect(tOpe.TOpe, pITempCoolTabs.TOpe) annotation (Line(points={{-96,58},{-74,
            58},{-74,-6},{-34.8,-6}}, color={0,0,127}));
    connect(tOpe.TOpe, pITempCoolPanel.TOpe) annotation (Line(points={{-96,58},{-74,
            58},{-74,-6},{5.2,-6}}, color={0,0,127}));
    connect(tOpe.TOpe, pITempCoolRem.TOpe) annotation (Line(points={{-96,58},{-74,
            58},{-74,-6},{55.2,-6}}, color={0,0,127}));

  // übernommen aus HeaterCoolerPI und nicht sicher was es macht
    if staOrDyn then
    connect(booleanExpressionHeater.y, pITempHeatTabs.onOff) annotation (Line(
        points={{-110.05,28},{-82,28},{-82,10},{-37.2,10}},
        color={255,0,255},
        pattern=LinePattern.Dash));
    connect(booleanExpressionHeater.y, pITempHeatPanel.onOff) annotation (Line(
        points={{-110.05,28},{-82,28},{-82,10},{2.8,10}},
        color={255,0,255},
        pattern=LinePattern.Dash));
    connect(booleanExpressionHeater.y, pITempHeatRem.onOff) annotation (Line(
        points={{-110.05,28},{-82,28},{-82,10},{52.8,10}},
        color={255,0,255},
        pattern=LinePattern.Dash));
    connect(booleanExpressionCooler.y, pITempCoolTabs.onOff) annotation (Line(
        points={{-111,-30},{-96,-30},{-96,-10},{-37.2,-10}},
        color={255,0,255},
        pattern=LinePattern.Dash));
    connect(booleanExpressionCooler.y, pITempCoolPanel.onOff) annotation (Line(
        points={{-111,-30},{-96,-30},{-96,-10},{2.8,-10}},
        color={255,0,255},
        pattern=LinePattern.Dash));
    connect(booleanExpressionCooler.y, pITempCoolRem.onOff) annotation (Line(
        points={{-111,-30},{-96,-30},{-96,-10},{52.8,-10}},
        color={255,0,255},
        pattern=LinePattern.Dash));
    else
    connect(heaterActive, pITempHeatTabs.onOff) annotation (Line(
        points={{-160,20},{-116,20},{-116,10},{-37.2,10}},
        color={255,0,255},
        pattern=LinePattern.Dash));
    connect(heaterActive, pITempHeatPanel.onOff) annotation (Line(
        points={{-160,20},{-116,20},{-116,10},{2.8,10}},
        color={255,0,255},
        pattern=LinePattern.Dash));
    connect(heaterActive, pITempHeatRem.onOff) annotation (Line(
        points={{-160,20},{-116,20},{-116,10},{52.8,10}},
        color={255,0,255},
        pattern=LinePattern.Dash));
    connect(coolerActive, pITempCoolTabs.onOff) annotation (Line(
        points={{-160,-20},{-102,-20},{-102,-10},{-37.2,-10}},
        color={255,0,255},
        pattern=LinePattern.Dash));
    connect(coolerActive, pITempCoolPanel.onOff) annotation (Line(
        points={{-160,-20},{-102,-20},{-102,-10},{2.8,-10}},
        color={255,0,255},
        pattern=LinePattern.Dash));
    connect(coolerActive, pITempCoolRem.onOff) annotation (Line(
        points={{-160,-20},{-102,-20},{-102,-10},{52.8,-10}},
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
    connect(pITempHeatTabs.y, gainHTabsExt.u) annotation (Line(points={{-22,14},{-20,
            14},{-20,30},{-40,30},{-40,39.2}}, color={0,0,127}));
    connect(pITempHeatTabs.y, gainHTabsInt.u) annotation (Line(points={{-22,14},{-20,
            14},{-20,39.2}},             color={0,0,127}));
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
    connect(pITempCoolTabs.y, gainCTabsExt.u) annotation (Line(points={{-22,-14},{-20,-14},{-20,-28},
            {-40,-28},{-40,-37.2}}, color={0,0,127}));
    connect(pITempCoolTabs.y, gainCTabsInt.u) annotation (Line(points={{-22,-14},{-20,-14},{-20,-37.2}}, color={0,0,127}));
    connect(pITempCoolPanel.y, gainCPanelExt.u) annotation (Line(points={{18,-14},{20,-14},{20,-28},{
            0,-28},{0,-37.2}}, color={0,0,127}));
    connect(pITempCoolPanel.y, gainCPanelInt.u) annotation (Line(points={{18,-14},{20,-14},{20,-37.2}}, color={0,0,127}));
    connect(pITempCoolRem.y, gainCRadExt.u) annotation (Line(points={{68,-14},{80,-14},{80,-28},{40,-28},
            {40,-37.2}}, color={0,0,127}));
    connect(pITempCoolRem.y, gainCRadInt.u) annotation (Line(points={{68,-14},{80,-14},{80,-28},{60,-28},
            {60,-37.2}}, color={0,0,127}));
    connect(pITempCoolRem.y, gainCConv.u) annotation (Line(points={{68,-14},{80,-14},{80,-37.2}}, color={0,0,127}));

    connect(pITempHeatTabs.y, sumHeating.u[1]) annotation (Line(
        points={{-22,14},{112,14},{112,29.2},{120.8,29.2}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(pITempHeatPanel.y, sumHeating.u[2]) annotation (Line(
        points={{18,14},{112,14},{112,30},{120.8,30}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(pITempHeatRem.y, sumHeating.u[3]) annotation (Line(
        points={{68,14},{112,14},{112,30.8},{120.8,30.8}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(sumHeating.y, heatingPower) annotation (Line(points={{134.6,30},{160,30}}, color={0,0,127}));
    connect(pITempCoolTabs.y, sumCooling.u[1]) annotation (Line(
        points={{-22,-14},{112,-14},{112,-30.8},{120.8,-30.8}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(pITempCoolPanel.y, sumCooling.u[2]) annotation (Line(
        points={{18,-14},{112,-14},{112,-30},{120.8,-30}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(pITempCoolRem.y, sumCooling.u[3]) annotation (Line(
        points={{68,-14},{112,-14},{112,-29.2},{120.8,-29.2}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(sumCooling.y, coolingPower)
      annotation (Line(points={{134.6,-30},{160,-30}}, color={0,0,127}));
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
  end HeaterCooler6007_2;

  model HeaterCooler6007_3

  // Heiz- und Kühlsystemparameter
    parameter Modelica.SIunits.Power powerHeatTabs = 0 annotation(Dialog(tab = "Heater", group = "Heating"));
    parameter Modelica.SIunits.Power powerHeatPanel = 0 annotation(Dialog(tab = "Heater", group = "Heating"));
    parameter Modelica.SIunits.Power powerHeatRem = 0 annotation(Dialog(tab = "Heater", group = "Heating"));
    parameter Modelica.SIunits.Power powerCoolTabs = 0 annotation(Dialog(tab = "Cooler", group = "Cooling"));
    parameter Modelica.SIunits.Power powerCoolPanel = 0 annotation(Dialog(tab = "Cooler", group = "Cooling"));
    parameter Modelica.SIunits.Power powerCoolRem = 0 annotation(Dialog(tab = "Cooler", group = "Cooling"));
    parameter Real shareHeatTabsExt(min=0, max=1) annotation(Dialog(tab = "Heater", group = "Heating"));
    parameter Real shareHeatTabsInt(min=0, max=1) annotation(Dialog(tab = "Heater", group = "Heating"));
    parameter Real shareHeatPanelExt(min=0, max=1) annotation(Dialog(tab = "Heater", group = "Heating"));
    parameter Real shareHeatPanelInt(min=0, max=1) annotation(Dialog(tab = "Heater", group = "Heating"));
    parameter Real shareHeatRadExt(min=0, max=1) annotation(Dialog(tab = "Heater", group = "Heating"));
    parameter Real shareHeatRadInt(min=0, max=1) annotation(Dialog(tab = "Heater", group = "Heating"));
    parameter Real shareHeatConv(min=0, max=1) annotation(Dialog(tab = "Heater", group = "Heating"));
    parameter Real shareCoolTabsExt(min=0, max=1) annotation(Dialog(tab = "Cooler", group = "Cooling"));
    parameter Real shareCoolTabsInt(min=0, max=1) annotation(Dialog(tab = "Cooler", group = "Cooling"));
    parameter Real shareCoolPanelExt(min=0, max=1) annotation(Dialog(tab = "Cooler", group = "Cooling"));
    parameter Real shareCoolPanelInt(min=0, max=1) annotation(Dialog(tab = "Cooler", group = "Cooling"));
    parameter Real shareCoolRadExt(min=0, max=1) annotation(Dialog(tab = "Cooler", group = "Cooling"));
    parameter Real shareCoolRadInt(min=0, max=1) annotation(Dialog(tab = "Cooler", group = "Cooling"));
    parameter Real shareCoolConv(min=0, max=1) annotation(Dialog(tab = "Cooler", group = "Cooling"));

  // von HeaterCoolerPI übernommen, nicht sicher was es macht
    parameter Boolean staOrDyn = true "Static or dynamic activation of heater" annotation(choices(choice = true "Static", choice =  false "Dynamic",
                    radioButtons = true));
    Modelica.Blocks.Sources.BooleanExpression booleanExpressionHeater(y=if not
          recOrSep then Heater_on else zoneParam.HeaterOn) if staOrDyn annotation (Placement(transformation(extent={{-130,20},
              {-111,36}})));
    Modelica.Blocks.Sources.BooleanExpression booleanExpressionCooler(y=if not
          recOrSep then Cooler_on else zoneParam.CoolerOn) if staOrDyn annotation (Placement(transformation(extent={{-132,
              -38},{-112,-22}})));

  // von PartialHeaterCoolerPI übernommen, nicht sicher was es macht
    parameter Boolean Heater_on = true "Activates the heater" annotation(Dialog(tab = "Heater",enable=not recOrSep));
    parameter Boolean Cooler_on = true "Activates the cooler" annotation(Dialog(tab = "Cooler",enable=not recOrSep));
    parameter Real h_heater = 0 "Upper limit controller output of the heater" annotation(Dialog(tab = "Heater", group = "Controller",enable=not recOrSep));
    parameter Real l_heater = 0 "Lower limit controller output of the heater" annotation(Dialog(tab = "Heater", group = "Controller",enable=not recOrSep));
    parameter Real KR_heater_TABS = 18 "Gain of the heating controller" annotation(Dialog(tab = "Heater", group = "Controller",enable=not recOrSep));
    parameter Modelica.SIunits.Time TN_heater_TABS = 2300 "Time constant of the heating controller" annotation(Dialog(tab = "Heater", group = "Controller",enable=not recOrSep));
    parameter Real KR_heater_Panel = 0.1 "Gain of the heating controller" annotation(Dialog(tab = "Heater", group = "Controller",enable=not recOrSep));
    parameter Modelica.SIunits.Time TN_heater_Panel = 4 "Time constant of the heating controller" annotation(Dialog(tab = "Heater", group = "Controller",enable=not recOrSep));
    parameter Real KR_heater_Rem = 0.1 "Gain of the heating controller" annotation(Dialog(tab = "Heater", group = "Controller",enable=not recOrSep));
    parameter Modelica.SIunits.Time TN_heater_Rem = 4 "Time constant of the heating controller" annotation(Dialog(tab = "Heater", group = "Controller",enable=not recOrSep));
    parameter Real h_cooler = 0 "Upper limit controller output of the cooler" annotation(Dialog(tab = "Cooler", group = "Controller",enable=not recOrSep));
    parameter Real l_cooler = 0 "Lower limit controller output of the cooler" annotation(Dialog(tab = "Cooler", group = "Controller",enable=not recOrSep));
    parameter Real KR_cooler_TABS = 18 "Gain of the cooling controller" annotation(Dialog(tab = "Cooler", group = "Controller",enable=not recOrSep));
    parameter Modelica.SIunits.Time TN_cooler_TABS = 2300 "Time constant of the cooling controller" annotation(Dialog(tab = "Cooler", group = "Controller",enable=not recOrSep));
    parameter Real KR_cooler_Panel = 0.1 "Gain of the cooling controller" annotation(Dialog(tab = "Cooler", group = "Controller",enable=not recOrSep));
    parameter Modelica.SIunits.Time TN_cooler_Panel = 4 "Time constant of the cooling controller" annotation(Dialog(tab = "Cooler", group = "Controller",enable=not recOrSep));
    parameter Real KR_cooler_Rem = 0.1 "Gain of the cooling controller" annotation(Dialog(tab = "Cooler", group = "Controller",enable=not recOrSep));
    parameter Modelica.SIunits.Time TN_cooler_Rem = 4 "Time constant of the cooling controller" annotation(Dialog(tab = "Cooler", group = "Controller",enable=not recOrSep));
    parameter Boolean recOrSep = false "Use record or seperate parameters" annotation(choices(choice =  false
          "Seperate",choice = true "Record",radioButtons = true));
    parameter AixLib.DataBase.ThermalZones.ZoneBaseRecord zoneParam = AixLib.DataBase.ThermalZones.ZoneRecordDummy()
      "Zone definition" annotation(choicesAllMatching=true,Dialog(enable=recOrSep));

  // übernommen aus HeaterCoolerPI
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
    TOpe tOpe "Operative Temperature" annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-126,68})));
    Modelica.Blocks.Interfaces.RealInput TAir "Indoor air temperature from Thermal Zone" annotation (Placement(transformation(extent={{20,-20},{-20,20}},
          rotation=90,
          origin={-140,100})));
    Modelica.Blocks.Interfaces.RealInput TRad "Mean indoor radiation temperature from Thermal Zone" annotation (Placement(transformation(extent={{20,-20},{-20,20}},
          rotation=90,
          origin={-110,100})));

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

    PITempCwe pITempHeatPanel(
      p=powerHeatPanel,
      rangeSwitch=false,
      h=if not recOrSep then h_heater else zoneParam.hHeat,
      l=if not recOrSep then l_heater else zoneParam.lHeat,
      KR=if not recOrSep then KR_heater_Panel else zoneParam.KRHeat,
      TN=if not recOrSep then TN_heater_Panel else zoneParam.TNHeat) if
                                                                  ((recOrSep and
      zoneParam.HeaterOn) or (not recOrSep and Heater_on))
      annotation (Placement(transformation(extent={{2,6},{18,22}})));
    PITempCwe pITempHeatRem(
      p=powerHeatRem,
      rangeSwitch=false,
      h=if not recOrSep then h_heater else zoneParam.hHeat,
      l=if not recOrSep then l_heater else zoneParam.lHeat,
      KR=if not recOrSep then KR_heater_Rem else zoneParam.KRHeat,
      TN=if not recOrSep then TN_heater_Rem else zoneParam.TNHeat) if
                                                                  ((recOrSep and
      zoneParam.HeaterOn) or (not recOrSep and Heater_on))
      annotation (Placement(transformation(extent={{52,6},{68,22}})));
    PITempCwe pITempCoolPanel(
      p=powerCoolPanel,
      rangeSwitch=false,
      h=if not recOrSep then h_cooler else zoneParam.hCool,
      l=if not recOrSep then l_cooler else zoneParam.lCool,
      KR=if not recOrSep then KR_cooler_Panel else zoneParam.KRCool,
      TN=if not recOrSep then TN_cooler_Panel else zoneParam.TNCool) if
                                                                  ((recOrSep and
      zoneParam.CoolerOn) or (not recOrSep and Cooler_on))
      "PI control for cooler"
      annotation (Placement(transformation(extent={{2,-6},{18,-22}})));
    PITempCwe pITempCoolRem(
      p=powerCoolRem,
      rangeSwitch=false,
      h=if not recOrSep then h_cooler else zoneParam.hCool,
      l=if not recOrSep then l_cooler else zoneParam.lCool,
      KR=if not recOrSep then KR_cooler_Rem else zoneParam.KRCool,
      TN=if not recOrSep then TN_cooler_Rem else zoneParam.TNCool) if
                                                                  ((recOrSep and
      zoneParam.CoolerOn) or (not recOrSep and Cooler_on))
      "PI control for cooler"
      annotation (Placement(transformation(extent={{52,-6},{68,-22}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatCoolTabsExt
      "Heat port to thermal zone" annotation (Placement(transformation(extent={{-50,86},{-30,106}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatCoolTabsInt
      "Heat port to thermal zone" annotation (Placement(transformation(extent={{-30,86},{-10,106}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatCoolPanelExt
      "Heat port to thermal zone" annotation (Placement(transformation(extent={{-10,86},{10,106}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatCoolPanelInt
      "Heat port to thermal zone" annotation (Placement(transformation(extent={{10,86},{30,106}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatCoolRadExt
      "Heat port to thermal zone" annotation (Placement(transformation(extent={{30,86},{50,106}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatCoolRadInt
      "Heat port to thermal zone" annotation (Placement(transformation(extent={{50,86},{70,106}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatCoolConv
      "Heat port to thermal zone" annotation (Placement(transformation(extent={{70,86},{90,106}})));

   // Anteile der Wärmeströme
    Modelica.Blocks.Math.Gain gainHTabsExt(k=shareHeatTabsExt) annotation (
        Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=90,
          origin={-40,44})));
    Modelica.Blocks.Math.Gain gainHTabsInt(k=shareHeatTabsInt) annotation (
        Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=90,
          origin={-20,44})));
    Modelica.Blocks.Math.Gain gainHPanelExt(k=shareHeatPanelExt) annotation (
        Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=90,
          origin={0,44})));
    Modelica.Blocks.Math.Gain gainHPanelInt(k=shareHeatPanelInt) annotation (
        Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=90,
          origin={20,44})));
    Modelica.Blocks.Math.Gain gainHRadExt(k=shareHeatRadExt) annotation (Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=90,
          origin={40,44})));
    Modelica.Blocks.Math.Gain gainHRadInt(k=shareHeatRadInt) annotation (Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=90,
          origin={60,44})));
    Modelica.Blocks.Math.Gain gainHConv(k=shareHeatConv) annotation (Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=90,
          origin={80,44})));
    Modelica.Blocks.Math.Gain gainCTabsExt(k=shareCoolTabsExt) annotation (
        Placement(transformation(
          extent={{4,-4},{-4,4}},
          rotation=90,
          origin={-40,-42})));
    Modelica.Blocks.Math.Gain gainCTabsInt(k=shareCoolTabsInt) annotation (
        Placement(transformation(
          extent={{4,-4},{-4,4}},
          rotation=90,
          origin={-20,-42})));
    Modelica.Blocks.Math.Gain gainCPanelExt(k=shareCoolPanelExt) annotation (
        Placement(transformation(
          extent={{4,-4},{-4,4}},
          rotation=90,
          origin={0,-42})));
    Modelica.Blocks.Math.Gain gainCPanelInt(k=shareCoolPanelInt) annotation (
        Placement(transformation(
          extent={{4,-4},{-4,4}},
          rotation=90,
          origin={20,-42})));
    Modelica.Blocks.Math.Gain gainCRadExt(k=shareCoolRadExt) annotation (
        Placement(transformation(
          extent={{4,-4},{-4,4}},
          rotation=90,
          origin={40,-42})));
    Modelica.Blocks.Math.Gain gainCRadInt(k=shareCoolRadInt) annotation (
        Placement(transformation(
          extent={{4,-4},{-4,4}},
          rotation=90,
          origin={60,-42})));
    Modelica.Blocks.Math.Gain gainCConv(k=shareCoolConv) annotation (Placement(
          transformation(
          extent={{4,-4},{-4,4}},
          rotation=90,
          origin={80,-42})));

    Modelica.Blocks.Math.Sum sumHeating(nin=3) annotation (Placement(transformation(extent={{122,24},{134,36}})));
    Modelica.Blocks.Math.Sum sumCooling(nin=3) annotation (Placement(transformation(extent={{122,-36},{134,-24}})));

    // TABS Controller
    TABSHeaterCoolerController tABSHeaterCoolerController annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-74,86})));
    BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
          transformation(extent={{-92,86},{-52,126}}), iconTransformation(
            extent={{-268,14},{-248,34}})));
  equation

    connect(TAir, tOpe.TAir) annotation (Line(points={{-140,100},{-140,78},{
            -129.2,78}},
                       color={0,0,127}));
    connect(TRad, tOpe.TRad) annotation (Line(points={{-110,100},{-110,78},{
            -123,78}},
                  color={0,0,127}));
    connect(setPointHeat, pITempHeatPanel.setPoint) annotation (Line(points={{-160,
            50},{-68,50},{-68,22},{3.6,22},{3.6,21.2}}, color={0,0,127}));
    connect(setPointHeat, pITempHeatRem.setPoint) annotation (Line(points={{-160,50},
            {-68,50},{-68,22},{53.6,22},{53.6,21.2}}, color={0,0,127}));
    connect(tOpe.TOpe, pITempHeatPanel.TOpe) annotation (Line(points={{-126,58},
            {-74,58},{-74,6},{5.2,6}},
                                  color={0,0,127}));
    connect(tOpe.TOpe, pITempHeatRem.TOpe) annotation (Line(points={{-126,58},{
            -74,58},{-74,6},{55.2,6}},
                                   color={0,0,127}));
    connect(setPointCool, pITempCoolPanel.setPoint) annotation (Line(points={{-160,
            -50},{-68,-50},{-68,-21.2},{3.6,-21.2}}, color={0,0,127}));
    connect(setPointCool, pITempCoolRem.setPoint) annotation (Line(points={{-160,-50},
            {-68,-50},{-68,-21.2},{53.6,-21.2}}, color={0,0,127}));
    connect(tOpe.TOpe, pITempCoolPanel.TOpe) annotation (Line(points={{-126,58},
            {-74,58},{-74,-6},{5.2,-6}},
                                    color={0,0,127}));
    connect(tOpe.TOpe, pITempCoolRem.TOpe) annotation (Line(points={{-126,58},{
            -74,58},{-74,-6},{55.2,-6}},
                                     color={0,0,127}));

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
        points={{-111,-30},{-96,-30},{-96,-10},{2.8,-10}},
        color={255,0,255},
        pattern=LinePattern.Dash));
    connect(booleanExpressionCooler.y, pITempCoolRem.onOff) annotation (Line(
        points={{-111,-30},{-96,-30},{-96,-10},{52.8,-10}},
        color={255,0,255},
        pattern=LinePattern.Dash));
    else
    connect(heaterActive, pITempHeatPanel.onOff) annotation (Line(
        points={{-160,20},{-116,20},{-116,10},{2.8,10}},
        color={255,0,255},
        pattern=LinePattern.Dash));
    connect(heaterActive, pITempHeatRem.onOff) annotation (Line(
        points={{-160,20},{-116,20},{-116,10},{52.8,10}},
        color={255,0,255},
        pattern=LinePattern.Dash));
    connect(coolerActive, pITempCoolPanel.onOff) annotation (Line(
        points={{-160,-20},{-102,-20},{-102,-10},{2.8,-10}},
        color={255,0,255},
        pattern=LinePattern.Dash));
    connect(coolerActive, pITempCoolRem.onOff) annotation (Line(
        points={{-160,-20},{-102,-20},{-102,-10},{52.8,-10}},
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
        points={{18,14},{112,14},{112,30},{120.8,30}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(pITempHeatRem.y, sumHeating.u[3]) annotation (Line(
        points={{68,14},{112,14},{112,30.8},{120.8,30.8}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(sumHeating.y, heatingPower) annotation (Line(points={{134.6,30},{160,30}}, color={0,0,127}));
    connect(pITempCoolPanel.y, sumCooling.u[2]) annotation (Line(
        points={{18,-14},{112,-14},{112,-30},{120.8,-30}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(pITempCoolRem.y, sumCooling.u[3]) annotation (Line(
        points={{68,-14},{112,-14},{112,-29.2},{120.8,-29.2}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(sumCooling.y, coolingPower)
      annotation (Line(points={{134.6,-30},{160,-30}}, color={0,0,127}));
    connect(tABSHeaterCoolerController.weaBus, weaBus.TDryBul) annotation (Line(
        points={{-69.7,93.7},{-69.7,100.208},{-72,100.208},{-72,106}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(tABSHeaterCoolerController.tabsHeatingPower, gainHTabsExt.u)
      annotation (Line(points={{-72,75},{-56,75},{-56,34},{-40,34},{-40,39.2}},
          color={0,0,127}));
    connect(tABSHeaterCoolerController.tabsHeatingPower, gainHTabsInt.u)
      annotation (Line(points={{-72,75},{-56,75},{-56,34},{-20,34},{-20,39.2}},
          color={0,0,127}));
    connect(tABSHeaterCoolerController.tabsCoolingPower, gainCTabsInt.u)
      annotation (Line(points={{-76,75},{-78,75},{-78,-30},{-20,-30},{-20,-37.2}},
          color={0,0,127}));
    connect(tABSHeaterCoolerController.tabsCoolingPower, gainCTabsExt.u)
      annotation (Line(points={{-76,75},{-78,75},{-78,-30},{-40,-30},{-40,-37.2}},
          color={0,0,127}));
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
  end HeaterCooler6007_3;

  model TABSHeaterCoolerController
      parameter AixLib.DataBase.ThermalZones.ZoneBaseRecord zoneParam
      "Zone definition";
    parameter Modelica.SIunits.Power heatingPower = 0;
    parameter Modelica.SIunits.Power coolingPower = 0;
    BoundaryConditions.WeatherData.Bus weaBus
      "Weather data bus"
      annotation (Placement(
      transformation(extent={{-111,75},{-77,107}}),iconTransformation(
      extent={{-92,28},{-62,58}})));
  Modelica.Blocks.Sources.Constant TAirThresholdHeating(k=zoneParam.TThresholdHeater)
    "Threshold temperature below which heating is activated"
    annotation (Placement(transformation(extent={{-86,6},{-74,18}})));
    Modelica.Blocks.Logical.Less less
    "check if outside temperature below threshold"
                                      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-42,20})));
    Modelica.Blocks.Interfaces.BooleanOutput heaterActive
      "true if heater is active" annotation (Placement(transformation(extent={{-20,28},
              {-4,12}}),      iconTransformation(extent={{-14,10},{6,30}})));
    Modelica.Blocks.Interfaces.BooleanOutput coolerActive
      "true if cooler is active" annotation (Placement(transformation(extent={{-20,-28},
              {-4,-12}}),     iconTransformation(extent={{-14,30},{-26,30}})));
    Modelica.Blocks.Logical.Greater greater
    "check if outside temperature above threshold"
                                            annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-42,-20})));
  Modelica.Blocks.Sources.Constant TAirThresholdCooling(k=zoneParam.TThresholdCooler)
    "Threshold temperature above which cooling is activated"
    annotation (Placement(transformation(extent={{-86,-34},{-74,-22}})));
    Math.MovingAverage movingAverage
      annotation (Placement(transformation(extent={{-88,58},{-70,76}})));
    Modelica.Blocks.Logical.Switch switchHeater
      annotation (Placement(transformation(extent={{60,10},{80,30}})));
    Modelica.Blocks.Logical.Switch switchCooler
      annotation (Placement(transformation(extent={{60,-30},{80,-10}})));
    Modelica.Blocks.Sources.Constant off(k=0)
      annotation (Placement(transformation(extent={{6,-6},{20,8}})));
    Modelica.Blocks.Sources.Constant heatingPower1(k=heatingPower)
      annotation (Placement(transformation(extent={{6,38},{20,52}})));
    Modelica.Blocks.Sources.Constant coolingPower1(k=coolingPower)
      annotation (Placement(transformation(extent={{6,-46},{20,-32}})));
    Modelica.Blocks.Interfaces.RealOutput tabsHeatingPower
      annotation (Placement(transformation(extent={{100,10},{120,30}})));
    Modelica.Blocks.Interfaces.RealOutput tabsCoolingPower
      annotation (Placement(transformation(extent={{100,-30},{120,-10}})));
  equation

    connect(TAirThresholdHeating.y, less.u2)
      annotation (Line(points={{-73.4,12},{-54,12}}, color={0,0,127}));
    connect(TAirThresholdCooling.y, greater.u2)
      annotation (Line(points={{-73.4,-28},{-54,-28}}, color={0,0,127}));
    connect(less.y, heaterActive)
      annotation (Line(points={{-31,20},{-12,20}},
                                                color={255,0,255}));
    connect(greater.y, coolerActive) annotation (Line(points={{-31,-20},{-12,
            -20}},              color={255,0,255}));
    connect(weaBus.TDryBul, movingAverage.u) annotation (Line(
        points={{-94,91},{-94,67},{-89.8,67}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(movingAverage.y, less.u1) annotation (Line(points={{-69.1,67},{
            -69.1,68},{-66,68},{-66,20},{-54,20}},
                                         color={0,0,127}));
    connect(movingAverage.y, greater.u1) annotation (Line(points={{-69.1,67},{
            -69.1,68},{-66,68},{-66,-20},{-54,-20}},
                                               color={0,0,127}));
    connect(switchHeater.y, tabsHeatingPower)
      annotation (Line(points={{81,20},{110,20}}, color={0,0,127}));
    connect(switchCooler.y, tabsCoolingPower)
      annotation (Line(points={{81,-20},{110,-20}}, color={0,0,127}));
    connect(off.y, switchHeater.u3) annotation (Line(points={{20.7,1},{44,1},{
            44,12},{58,12}}, color={0,0,127}));
    connect(off.y, switchCooler.u3) annotation (Line(points={{20.7,1},{44,1},{
            44,-28},{58,-28}}, color={0,0,127}));
    connect(heatingPower1.y, switchHeater.u1) annotation (Line(points={{20.7,45},
            {43.5,45},{43.5,28},{58,28}}, color={0,0,127}));
    connect(coolingPower1.y, switchCooler.u1) annotation (Line(points={{20.7,
            -39},{36,-39},{36,-12},{58,-12}}, color={0,0,127}));
    connect(heaterActive, switchHeater.u2)
      annotation (Line(points={{-12,20},{58,20}}, color={255,0,255}));
    connect(coolerActive, switchCooler.u2)
      annotation (Line(points={{-12,-20},{58,-20}}, color={255,0,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                Rectangle(extent = {{-80, 80}, {80, -80}}, lineColor = {135, 135, 135}, fillColor = {255, 255, 170},
              fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{-58, 32}, {62, -20}}, lineColor = {175, 175, 175}, textString = "%name")}),
        Diagram(coordinateSystem(preserveAspectRatio=false)),
      Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  This is a simple controller which sets a threshold for heating and
  cooling based on the outside temperature. This should prevent heating
  in summer if the AHU lowers the temperature below set temperature of
  TABS heater and cooler and vice versa in winter.
</p>
</html>", revisions="<html><ul>
  <li>
  <i>March, 2021&#160;</i> by Christian Wenzel:<br/>
    Initial integration
  </li>
</ul>
</html>"));
  end TABSHeaterCoolerController;

  model tabsOnOffController
    Modelica.Blocks.Logical.Switch switch1
      annotation (Placement(transformation(extent={{80,10},{100,30}})));
    Modelica.Blocks.Logical.Switch switch2
      annotation (Placement(transformation(extent={{80,-30},{100,-10}})));
    Modelica.Blocks.Interfaces.RealOutput tabsHeatingPower
      annotation (Placement(transformation(extent={{120,10},{140,30}})));
    Modelica.Blocks.Interfaces.RealOutput tabsCoolingPower
      annotation (Placement(transformation(extent={{120,-30},{140,-10}})));
    Modelica.Blocks.Sources.Constant off(k=0)
      annotation (Placement(transformation(extent={{20,-12},{40,8}})));
    Modelica.Blocks.Sources.Constant heatingPower
      annotation (Placement(transformation(extent={{20,32},{40,52}})));
    Modelica.Blocks.Sources.Constant coolingPower
      annotation (Placement(transformation(extent={{20,-52},{40,-32}})));
  equation
    connect(switch1.y, tabsHeatingPower)
      annotation (Line(points={{101,20},{130,20}}, color={0,0,127}));
    connect(switch2.y, tabsCoolingPower)
      annotation (Line(points={{101,-20},{130,-20}}, color={0,0,127}));
    connect(off.y, switch1.u3) annotation (Line(points={{41,-2},{64,-2},{64,12},
            {78,12}}, color={0,0,127}));
    connect(off.y, switch2.u3) annotation (Line(points={{41,-2},{64,-2},{64,-28},
            {78,-28}}, color={0,0,127}));
    connect(heatingPower.y, switch1.u1) annotation (Line(points={{41,42},{63.5,
            42},{63.5,28},{78,28}}, color={0,0,127}));
    connect(coolingPower.y, switch2.u1) annotation (Line(points={{41,-42},{56,
            -42},{56,-12},{78,-12}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,
              -100},{120,100}})), Diagram(coordinateSystem(preserveAspectRatio=
              false, extent={{-120,-100},{120,100}})));
  end tabsOnOffController;

  model MovingAverageTest
    Math.MovingAverage movingAverage(aveTime=1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Modelica.Blocks.Interfaces.RealOutput y
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));
    Modelica.Blocks.Sources.Pulse pulse(amplitude=1, period=7200)
      annotation (Placement(transformation(extent={{-82,70},{-62,90}})));
    Modelica.Blocks.Sources.Step step(height=20, startTime=5*3600)
      annotation (Placement(transformation(extent={{-76,-10},{-56,10}})));
  equation
    connect(movingAverage.y, y)
      annotation (Line(points={{11,0},{100,0}}, color={0,0,127}));
    connect(step.y, movingAverage.u)
      annotation (Line(points={{-55,0},{-12,0}}, color={0,0,127}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(coordinateSystem(preserveAspectRatio=false)),
      experiment(
        StopTime=86400,
        __Dymola_NumberOfIntervals=900,
        __Dymola_Algorithm="Dassl"));
  end MovingAverageTest;
end HeaterCoolerVDI6007AC1;
