within ;
block CalcSOCHeatingDual
  extends partialCalcSOC;
  Modelica.Blocks.Routing.RealPassThrough DynamicGridReturnTemperatureMeaPassthrough annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-80,70})));
  Modelica.Blocks.Routing.RealPassThrough DynamicGridSetTemperaturePassthrough annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-50,70})));
  Modelica.Blocks.Routing.RealPassThrough StaticGridSetTemperaturePassthrough annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={80,70})));
  Modelica.Blocks.Routing.RealPassThrough StaticGridReturnTemperatureMeaPassthrough annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={50,70})));
  Modelica.Blocks.Math.Add meanSoc(k1=StaticStorageVolume/(StaticStorageVolume + DynamicStorageVolume), k2=
        DynamicStorageVolume/(StaticStorageVolume + DynamicStorageVolume))
                                  annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={0,70})));
  Leverage leverage annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-60,30})));
  Leverage leverage1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={60,30})));
  Modelica.Blocks.Nonlinear.Limiter SOCDynamic(uMax=1, uMin=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,30})));
  Modelica.Blocks.Nonlinear.Limiter SOCStatic(uMax=1, uMin=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,30})));
equation
  connect(energySystemBus.gridBus.HeatingStaticGridSetTemperature,
    StaticGridSetTemperaturePassthrough.u) annotation (Line(
      points={{0.05,100.05},{0,100.05},{0,100},{80,100},{80,82}},
      color={255,204,51},
      thickness=0.5));
  connect(energySystemBus.gridBus.HeatingDynamicGridSetTemperature,
    DynamicGridSetTemperaturePassthrough.u) annotation (Line(
      points={{0.05,100.05},{0,100.05},{0,100},{-50,100},{-50,82}},
      color={255,204,51},
      thickness=0.5));
  connect(energySystemBus.gridBus.HeatingStaticGridSupplyTemperatureStorageMea,
    DynamicGridReturnTemperatureMeaPassthrough.u) annotation (Line(
      points={{0.05,100.05},{0.05,100},{-80,100},{-80,82}},
      color={255,204,51},
      thickness=0.5));
  connect(energySystemBus.gridBus.HeatingStaticGridReturnTemperatureMea,
    StaticGridReturnTemperatureMeaPassthrough.u) annotation (Line(
      points={{0.05,100.05},{0,100.05},{0,100},{50,100},{50,82}},
      color={255,204,51},
      thickness=0.5));
  connect(meanSoc.y, energySystemBus.storageBus.HeatingStorageMeanSOC)
    annotation (Line(points={{2.22045e-15,81},{2.22045e-15,79},{0.05,79},{0.05,100.05}},
                                                                      color={255,204,
          51},
      thickness=0.5));
  connect(SOCStatic.y, energySystemBus.storageBus.HeatingStaticStorageS5_2WSOC)
    annotation (Line(points={{20,41},{20,90},{0.05,90},{0.05,100.05}}, color={255,204,
          51},
      thickness=0.5));
  connect(SOCDynamic.y, energySystemBus.storageBus.HeatingDynamicStorageS5_1WSOC)
    annotation (Line(points={{-20,41},{-20,90},{0.05,90},{0.05,100.05}}, color={255,204,
          51},
      thickness=0.5));
  connect(leverage.y,SOCDynamic. u)
    annotation (Line(points={{-60,19},{-60,0},{-20,0},{-20,18}}, color={0,0,127}));
  connect(leverage1.y,SOCStatic. u) annotation (Line(points={{60,19},{60,0},{20,0},{20,18}}, color={0,0,127}));
  connect(SOCStatic.y,meanSoc. u1) annotation (Line(points={{20,41},{20,50},{6,50},{6,58}}, color={0,0,127}));
  connect(SOCDynamic.y,meanSoc. u2)
    annotation (Line(points={{-20,41},{-20,50},{-6,50},{-6,58}}, color={0,0,127}));
  connect(DynamicGridSetTemperaturePassthrough.y,leverage. uHigh) annotation (
      Line(points={{-50,59},{-50,50},{-53,50},{-53,42}}, color={0,0,127}));
  connect(DynamicGridReturnTemperatureMeaPassthrough.y,leverage. uLow)
    annotation (Line(points={{-80,59},{-80,50},{-67,50},{-67,42}}, color={0,0,
          127}));
  connect(meanTemperatureDynamicStorage.y,leverage. uMea) annotation (Line(
        points={{-19,-60},{-10,-60},{-10,-20},{-80,-20},{-80,46},{-60,46},{-60,42}},
                color={0,0,127}));
  connect(meanTemperatureStaticStorage.y,leverage1. uMea) annotation (Line(
        points={{19,-60},{10,-60},{10,-20},{80,-20},{80,46},{60,46},{60,42}},
        color={0,0,127}));
  connect(StaticGridSetTemperaturePassthrough.y,leverage1. uHigh) annotation (
      Line(points={{80,59},{80,50},{67,50},{67,42}}, color={0,0,127}));
  connect(StaticGridReturnTemperatureMeaPassthrough.y,leverage1. uLow)
    annotation (Line(points={{50,59},{50,50},{53,50},{53,42}}, color={0,0,127}));
end CalcSOCHeatingDual;
