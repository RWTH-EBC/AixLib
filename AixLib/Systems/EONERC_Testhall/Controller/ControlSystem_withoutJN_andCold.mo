within AixLib.Systems.EONERC_Testhall.Controller;
model ControlSystem_withoutJN_andCold
  .Testhall.BaseClass.DistributeBus dB_Buildings annotation (Placement(
        transformation(extent={{-214,268},{-142,352}}), iconTransformation(
          extent={{374,350},{414,390}})));

  Obsolete.BaseClasses_ControlSystem.RLTControl_Hot rLTControl_Heater(
    RPM=2000,
    Temp_Set_Room(displayUnit="K") = 293.15,
    Temp_Set_Circ(displayUnit="K") = 343.15,
    Temp_Set_Air(displayUnit="K") = 310.15)
    annotation (Placement(transformation(extent={{-74,172},{-94,192}})));
  Obsolete.BaseClasses_ControlSystem.RLTControl_Cold rLTControl_Cooler(
    RPM=2000,
    ki=0.01,
    ti=850,
    Temp_Set_Room(displayUnit="K") = 293.15,
    Temp_Set_Circ(displayUnit="K") = 283.15,
    Temp_Set_Air(displayUnit="K") = 284.15)
    annotation (Placement(transformation(extent={{318,0},{298,20}})));
  AixLib.Systems.EONERC_Testhall.BaseClass.AHU.AHUControl aHUControl
    annotation (Placement(transformation(extent={{-10,-112},{72,-40}})));
  .Testhall.BaseClass.DistributeBus dB_AHU annotation (Placement(transformation(
          extent={{-102,-124},{-30,-40}}), iconTransformation(extent={{0,0},{0,
            0}})));
  AixLib.Systems.ModularAHU.BaseClasses.GenericAHUBus
                            genericAHUBus "Bus connector for genericAHU"
    annotation (Placement(transformation(extent={{104,-112},{168,-38}}),
        iconTransformation(extent={{378,14},{418,62}})));
  Obsolete.BaseClasses_ControlSystem.RLTControl_Hot rLTControl_Preheater(
    RPM=2300,
    Temp_Set_Room(displayUnit="K") = 293.15,
    Temp_Set_Circ(displayUnit="K") = 343.15,
    Temp_Set_Air(displayUnit="K") = 310.15)
    annotation (Placement(transformation(extent={{-78,142},{-98,162}})));
equation

  connect(rLTControl_Heater.Temperature_Room_m, dB_Buildings.control_building.Hall1_Air_m)
    annotation (Line(points={{-96,182},{-134,182},{-134,310.21},{-177.82,310.21}},
        color={0,0,127}));
  connect(rLTControl_Cooler.Temperature_Room_m, dB_Buildings.control_building.Hall1_Air_m)
    annotation (Line(points={{296,10},{285,10},{285,310.21},{-177.82,310.21}},
        color={0,0,127}));
  connect(aHUControl.genericAHUBus,genericAHUBus)  annotation (Line(
      points={{72,-75.64},{72,-75},{136,-75}},
      color={255,204,51},
      thickness=0.5));
  connect(dB_AHU.bus_ahu,aHUControl. hydraulicBus_heater) annotation (Line(
      points={{-65.82,-81.79},{-65.82,-96},{-10,-96},{-10,-94}},
      color={255,204,51},
      thickness=0.5));
  connect(dB_AHU.bus_ahu_cold,aHUControl. hydraulicBus_cooler) annotation (Line(
      points={{-65.82,-81.79},{-65.82,-102},{-10,-102},{-10,-100.48}},
      color={255,204,51},
      thickness=0.5));
  connect(rLTControl_Heater.RPM_Output, dB_AHU.bus_ahu.pumpBus.rpmSet)
    annotation (Line(points={{-73,190},{-66,190},{-66,-81.79},{-65.82,-81.79}},
        color={0,0,127}));
  connect(rLTControl_Heater.Valve_Set_Admix, dB_AHU.bus_ahu.valveSet)
    annotation (Line(points={{-73,182},{-66,182},{-66,-81.79},{-65.82,-81.79}},
        color={0,0,127}));
  connect(rLTControl_Cooler.RPM_Output, dB_AHU.bus_ahu_cold.pumpBus.rpmSet)
    annotation (Line(points={{319,18},{334,18},{334,-128},{-66,-128},{-66,-82},
          {-65.82,-82},{-65.82,-81.79}}, color={0,0,127}));
  connect(rLTControl_Cooler.Valve_Set_Admix, dB_AHU.bus_ahu_cold.valveSet)
    annotation (Line(points={{319,10},{334,10},{334,-128},{-66,-128},{-66,-81.79},
          {-65.82,-81.79}}, color={0,0,127}));
  connect(rLTControl_Heater.RPM_Output, dB_AHU.bus_ahu.pumpBus.rpmSet)
    annotation (Line(points={{-73,190},{-65.82,190},{-65.82,-81.79}}, color={0,
          0,127}));
  connect(rLTControl_Heater.Valve_Set_Admix, dB_AHU.bus_ahu.valveSet)
    annotation (Line(points={{-73,182},{-65.82,182},{-65.82,-81.79}}, color={0,
          0,127}));
  connect(rLTControl_Heater.Temperature_Air_RLT, genericAHUBus.TSupMea)
    annotation (Line(points={{-96,174},{-132,174},{-132,-74.815},{136.16,-74.815}},
        color={0,0,127}));
  connect(rLTControl_Cooler.Temperature_Air_RLT, genericAHUBus.TSupMea)
    annotation (Line(points={{296,2},{198,2},{198,-74.815},{136.16,-74.815}},
        color={0,0,127}));
  connect(rLTControl_Preheater.Temperature_Room_m, dB_Buildings.control_building.Hall1_Air_m)
    annotation (Line(points={{-100,152},{-177.82,152},{-177.82,310.21}},color={
          0,0,127}));
  connect(rLTControl_Preheater.Temperature_Air_RLT, genericAHUBus.TSupMea)
    annotation (Line(points={{-100,144},{-120,144},{-120,-74.815},{136.16,
          -74.815}}, color={0,0,127}));
  connect(rLTControl_Preheater.Valve_Set_Admix, dB_AHU.bus_ahu_pre.valveSet)
    annotation (Line(points={{-77,152},{-65.82,152},{-65.82,-81.79}}, color={0,
          0,127}));
  connect(rLTControl_Preheater.RPM_Output, dB_AHU.bus_ahu_pre.pumpBus.rpmSet)
    annotation (Line(points={{-77,160},{-65.82,160},{-65.82,-81.79}}, color={0,
          0,127}));
  connect(aHUControl.hydraulicBus_preheater, dB_AHU.bus_ahu_pre) annotation (
      Line(
      points={{-10,-88.24},{-10,-88},{-65.82,-88},{-65.82,-81.79}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-400,-400},
            {400,400}}), graphics={Rectangle(
          extent={{-22,400},{400,-400}},
          lineColor={0,0,0},
          fillColor={143,143,143},
          fillPattern=FillPattern.Solid)}),
                          Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-400,-400},{400,400}}), graphics={
        Rectangle(
          extent={{-260,382},{252,258}},
          lineColor={28,108,200},
          fillColor={211,211,211},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-250,378},{-180,356}},
          textColor={28,108,200},
          textString="Buildings"),
        Text(
          extent={{208,68},{278,46}},
          textColor={28,108,200},
          textString="Cold")}),
    experiment(StopTime=10, __Dymola_Algorithm="Dassl"));
end ControlSystem_withoutJN_andCold;
