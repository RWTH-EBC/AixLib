within AixLib.Systems.EONERC_Testhall;
model Controller
  Modelica.Blocks.Math.Max maxTSupSet
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Subsystems.CeilingPanelHeaters.Controls.ControlCPH controlCPH_ProgrammHall
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Subsystems.ConcreteCoreActivation.Controls.ControlCCA controlCCA
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  Subsystems.BaseClasses.Interfaces.MainBus mainBus annotation (Placement(
        transformation(extent={{80,-20},{120,20}}), iconTransformation(extent={
            {80,-20},{120,20}})));
  Subsystems.DistrictHeatingStation.Controls.ControlDHS controlDHS
    annotation (Placement(transformation(extent={{-20,80},{0,100}})));
  Modelica.Blocks.Interfaces.RealInput T_amb annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}}), iconTransformation(
          extent={{-118,-20},{-78,20}})));
  Subsystems.JetNozzle.Controls.ControlJN controlJN
    annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
  ModularAHU.Controller.CtrAHUBasic                controlAHU(
    TFlowSet=310.15,
    TFrostProtect=273.15 + 8,
    ctrPh(
      useExternalTMea=false,
      k=0.001,
      rpm_pump=2300),
    ctrRh(k=0.01, Ti=1000),
    VFlowSet=3.08,
    dpMax=5000,
    useTwoFanCtr=true,
    k=10)  annotation (Placement(transformation(extent={{40,60},{60,80}})));
equation
  connect(controlCCA.distributeBus_CCA, mainBus.bus_cca) annotation (Line(
      points={{-20,-50.1},{72,-50.1},{72,0.1},{100.1,0.1}},
      color={255,204,51},
      thickness=0.5));
  connect(controlCPH_ProgrammHall.distributeBus_CPH, mainBus.bus_cph)
    annotation (Line(
      points={{-20.2,49.9},{72,49.9},{72,0},{86,0},{86,0.1},{100.1,0.1}},
      color={255,204,51},
      thickness=0.5));
  connect(maxTSupSet.u1, mainBus.bus_cca.TSupSet) annotation (Line(points={{-2,
          6},{-12,6},{-12,20},{100.1,20},{100.1,0.1}}, color={0,0,127}));
  connect(maxTSupSet.u2, mainBus.bus_cph.TSupSet) annotation (Line(points={{-2,
          -6},{-12,-6},{-12,-20},{100,-20},{100,-10},{100.1,-10},{100.1,0.1}},
        color={0,0,127}));
  connect(controlDHS.distributeBus_DHS, mainBus.bus_dhs) annotation (Line(
      points={{-0.2,89.9},{100.1,89.9},{100.1,0.1}},
      color={255,204,51},
      thickness=0.5));
  connect(maxTSupSet.y, mainBus.bus_dhs.setpoint) annotation (Line(points={{21,
          0},{60,0},{60,0.1},{100.1,0.1}}, color={0,0,127}));
  connect(controlCCA.T_amb, T_amb) annotation (Line(points={{-40,-50},{-70,-50},
          {-70,0},{-120,0}}, color={0,0,127}));
  connect(controlCPH_ProgrammHall.T_amb, T_amb) annotation (Line(points={{-40,
          50},{-70,50},{-70,0},{-120,0}}, color={0,0,127}));
  connect(controlJN.jnBus, mainBus.bus_jn) annotation (Line(
      points={{-0.2,-90.1},{100.1,-90.1},{100.1,0.1}},
      color={255,204,51},
      thickness=0.5));
  connect(controlAHU.genericAHUBus, mainBus.bus_ahu) annotation (Line(
      points={{60,70.1},{100.1,70.1},{100.1,0.1}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Text(
          extent={{-90,20},{56,-20}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="HCMI"),
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{20,100},{100,0},{20,-100}},
          color={95,95,95},
          thickness=0.5),
        Text(
          extent={{-90,20},{56,-20}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Control")}), Diagram(coordinateSystem(preserveAspectRatio
          =false)));
end Controller;
