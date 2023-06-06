within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Verification;
model ComparisonOfAHUHeatingCooling
  "Comparitive simulation with existing AHU model"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Constant Vflow_in(k=100)
    annotation (Placement(transformation(extent={{-100,82},{-88,94}})));
  Modelica.Blocks.Sources.Constant TSupDes(k=293)
    "desired supply air temperature"
    annotation (Placement(transformation(extent={{100,56},{88,68}})));
  AHU                                 ahu(
    clockPeriodGeneric=30,
    heating=true,
    cooling=true,
    dehumidificationSet=false,
    humidificationSet=false,
    HRS=false,
    dp_sup(displayUnit="Pa"),
    dp_eta(displayUnit="Pa"))
              annotation (Placement(transformation(extent={{-66,50},{28,86}})));
  Modelica.Blocks.Sources.Constant phiSupMin(k=0.45)
    annotation (Placement(transformation(extent={{100,-10},{88,2}})));
  Modelica.Blocks.Sources.Constant phiSupMax(k=0.55)
    annotation (Placement(transformation(extent={{100,12},{88,24}})));
  Modelica.Blocks.Sources.Constant phi_RoomExtractAir(k=0.6)
    annotation (Placement(transformation(extent={{100,34},{88,46}})));
protected
  Modelica.Blocks.Math.Add addToEtaTem
    annotation (Placement(transformation(extent={{74,76},{60,90}})));
public
  ModularAHU modularAHU(
    humidifying=false,
    cooling=true,
    dehumidifying=false,
    heating=true,
    heatRecovery=false,
    use_PhiSet=false,
    Twat=273.15,
    dp_sup(displayUnit="Pa"),
    dp_eta(displayUnit="Pa"),
    redeclare model humidifier = Components.SprayHumidifier)
    annotation (Placement(transformation(extent={{-54,-12},{16,26}})));
  Modelica.Blocks.Sources.Step TempOutside(
    height=20,
    offset=278.5,
    startTime(displayUnit="s") = 43200)
    annotation (Placement(transformation(extent={{-100,60},{-88,72}})));
  Modelica.Blocks.Sources.Constant WaterLoadOutside(k=0.003)
    annotation (Placement(transformation(extent={{-100,38},{-88,50}})));
  Modelica.Blocks.Sources.Constant temAddInRoo(k=2)
    "temperature increase over the room"
    annotation (Placement(transformation(extent={{100,80},{86,94}})));
  ThermalZones.ReducedOrder.Multizone.BaseClasses.AbsToRelHum absToRelHum annotation (Placement(transformation(extent={{-76,0},
            {-66,10}})));
  Modelica.Blocks.Sources.RealExpression dQCooPer(y=(abs(ahu.QflowC -
        modularAHU.QflowC)/max(abs(ahu.QflowC), 1E-4))*100)
    "percentual difference in cooling demand between air handling unit models"
    annotation (Placement(transformation(extent={{-80,-50},{-66,-36}})));
  Modelica.Blocks.Sources.RealExpression dQCoo(y=abs(ahu.QflowC - modularAHU.QflowC))
    "difference in cooling demand between air handling unit models"
    annotation (Placement(transformation(extent={{-80,-64},{-66,-50}})));
  Modelica.Blocks.Sources.RealExpression dQHeaPer(y=(abs(ahu.QflowH -
        modularAHU.QflowH)/max(abs(ahu.QflowH), 1E-4))*100)
    "percentual difference in heating demand between air handling unit models"
    annotation (Placement(transformation(extent={{-36,-50},{-22,-36}})));
  Modelica.Blocks.Sources.RealExpression dQHea(y=abs(ahu.QflowH - modularAHU.QflowH))
    "difference in heating demand between air handling unit models"
    annotation (Placement(transformation(extent={{-36,-64},{-22,-50}})));
  Modelica.Blocks.Sources.RealExpression dPelPer(y=(abs(ahu.Pel - modularAHU.Pel)
        /max(abs(ahu.Pel), 1E-4))*100)
    "percentual difference in electrical energy demand between air handling unit models"
    annotation (Placement(transformation(extent={{4,-50},{18,-36}})));
  Modelica.Blocks.Sources.RealExpression dPel(y=abs(ahu.Pel - modularAHU.Pel))
    "difference in electrical energy demand between air handling unit models"
    annotation (Placement(transformation(extent={{4,-64},{18,-50}})));
equation
  connect(TSupDes.y, addToEtaTem.u2) annotation (Line(points={{87.4,62},{82,62},
          {82,78.8},{75.4,78.8}}, color={0,0,127}));
  connect(temAddInRoo.y, addToEtaTem.u1) annotation (Line(points={{85.3,87},{85.3,
          87.2},{75.4,87.2}}, color={0,0,127}));
  connect(Vflow_in.y, ahu.Vflow_in) annotation (Line(points={{-87.4,88},{-82,88},
          {-82,63.5},{-64.12,63.5}}, color={0,0,127}));
  connect(WaterLoadOutside.y, ahu.X_outdoorAir) annotation (Line(points={{-87.4,
          44},{-82,44},{-82,56.3},{-60.36,56.3}}, color={0,0,127}));
  connect(WaterLoadOutside.y, absToRelHum.absHum) annotation (Line(points={{-87.4,
          44},{-82,44},{-82,7.6},{-77,7.6}}, color={0,0,127}));
  connect(TempOutside.y, ahu.T_outdoorAir) annotation (Line(points={{-87.4,66},{
          -82,66},{-82,60.8},{-60.36,60.8}}, color={0,0,127}));
  connect(TempOutside.y, absToRelHum.TDryBul) annotation (Line(points={{-87.4,66},
          {-82,66},{-82,2.2},{-77,2.2}}, color={0,0,127}));
  connect(absToRelHum.relHum, modularAHU.phi_oda) annotation (Line(points={{-65,
          5},{-60,5},{-60,10.8},{-54.875,10.8}}, color={0,0,127}));
  connect(TempOutside.y, modularAHU.T_oda) annotation (Line(points={{-87.4,66},{
          -82,66},{-82,14.6},{-54.875,14.6}}, color={0,0,127}));
  connect(Vflow_in.y, modularAHU.VflowOda) annotation (Line(points={{-87.4,88},{
          -82,88},{-82,18.4},{-54.875,18.4}}, color={0,0,127}));
  connect(Vflow_in.y, modularAHU.VflowEta) annotation (Line(points={{-87.4,88},{
          -82,88},{-82,30},{22,30},{22,18.4},{16.875,18.4}}, color={0,0,127}));
  connect(addToEtaTem.y, ahu.T_extractAir) annotation (Line(points={{59.3,83},{52,
          83},{52,77.9},{20.48,77.9}}, color={0,0,127}));
  connect(addToEtaTem.y, modularAHU.T_eta) annotation (Line(points={{59.3,83},{52,
          83},{52,14.6},{16.875,14.6}}, color={0,0,127}));
  connect(phi_RoomExtractAir.y, ahu.phi_extractAir) annotation (Line(points={{87.4,
          40},{52,40},{52,73.4},{20.48,73.4}}, color={0,0,127}));
  connect(phi_RoomExtractAir.y, modularAHU.phi_eta) annotation (Line(points={{87.4,
          40},{52,40},{52,10.8},{16.875,10.8}}, color={0,0,127}));
  connect(TSupDes.y, ahu.T_supplyAir) annotation (Line(points={{87.4,62},{54,62},
          {54,61.7},{20.48,61.7}}, color={0,0,127}));
  connect(TSupDes.y, modularAHU.T_supplyAir) annotation (Line(points={{87.4,62},
          {52,62},{52,-18},{11.625,-18},{11.625,-12.76}}, color={0,0,127}));
  connect(phiSupMax.y, ahu.phi_supplyAir[2]) annotation (Line(points={{87.4,18},
          {52,18},{52,56.3},{20.48,56.3}}, color={0,0,127}));
  connect(phiSupMin.y, ahu.phi_supplyAir[1]) annotation (Line(points={{87.4,-4},
          {52,-4},{52,58.1},{20.48,58.1}}, color={0,0,127}));
  connect(phiSupMin.y, modularAHU.phi_supplyAir[1]) annotation (Line(points={{87.4,
          -4},{52,-4},{52,-18},{7.25,-18},{7.25,-13.14}}, color={0,0,127}));
  connect(phiSupMax.y, modularAHU.phi_supplyAir[2]) annotation (Line(points={{87.4,
          18},{52,18},{52,-18},{7.25,-18},{7.25,-12.38}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86400,
      Interval=1,
      __Dymola_Algorithm="Dassl"));
end ComparisonOfAHUHeatingCooling;
