within AixLib.PlugNHarvest.Components.SmartFacade;
model SmartFacade
  extends BaseClasses.PartialSmartFassade;
  replaceable package MyMedium = Modelica.Media.Air.DryAirNasa  ;
  // Mechanical ventilation
  parameter Boolean withMechVent = false "with mechanical ventilation" annotation (choices(checkBox=true));
  // PV
  parameter Boolean withPV = false "with photovoltaics" annotation (choices(checkBox=true));
  //solar air heater
  parameter Boolean withSolAirHeat = false "with Solar Air Heater" annotation (choices(checkBox=true));
  parameter Modelica.SIunits.Volume room_V=50 "Volume of the room" annotation(Dialog(tab = "Mechanical ventilation", enable = withMechVent));
  parameter Integer NrPVpanels=5 "Number of panels" annotation(Dialog(tab = "PV", enable = withPV));
  parameter AixLib.DataBase.SolarElectric.PVBaseRecord dataPV = AixLib.DataBase.SolarElectric.SymphonyEnergySE6M181() "PV data set" annotation(Dialog(tab = "PV", enable = withPV));
  parameter Modelica.SIunits.Power PelPV_max = 4000
    "Maximum output power for inverter" annotation(Dialog(tab = "PV", enable = withPV));
  Ventilation.MechVent_schedule mechVent(
      room_V=room_V, redeclare package AirModel = AirModel) if
                                            withMechVent
    annotation (Placement(transformation(extent={{-22,-14},{12,20}})));
  AixLib.Electrical.PVSystem.PVSystem pVSystem(
    data=dataPV,
    MaxOutputPower=PelPV_max,
    NumberOfPanels=NrPVpanels) if                 withPV
    annotation (Placement(transformation(extent={{-20,60},{0,80}})));
  Modelica.Blocks.Interfaces.RealOutput Pel_PV if withPV
    "Output electrical power of the PV system including the inverter"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-32,-100}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-28,-94})));
  Modelica.Blocks.Interfaces.RealInput Schedule_mechVent if withMechVent
    "schedule mechanical ventilation in x1/h over time"
    annotation (Placement(visible = true,transformation(extent = {{-120, -80}, {-80, -40}}, rotation = 0),
        iconTransformation(extent = {{-100, -60}, {-80, -40}}, rotation = 0)));

  sahaix                                     solarAirHeater(
    MassFlowSetPoint=MassFlowSetPoint,
    CoverArea=CoverArea,
    InnerCrossSection=InnerCrossSection,
    Perimeter=Perimeter,
    SAHLength1=SAHLength1,
    SAHLength2=SAHLength2,
    AbsorberHeatCapacity=AbsorberHeatCapacity,
    CoverTransmitance=CoverTransmitance,
    CoverConductance=CoverConductance, redeclare package MyMedium = MyMedium) if                      withSolAirHeat annotation (Placement(transformation(
        extent={{-21,-21},{21,21}},
        rotation=180,
        origin={-9,-55})));
  AixLib.Utilities.Interfaces.SolarRad_in solRadPort
    annotation (Placement(transformation(extent={{-106,59},{-86,79}}),
        iconTransformation(extent={{-100,40},{-80,60}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        AirModel) if withMechVent
    annotation (Placement(transformation(extent={{86,-62},{106,-42}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        AirModel) if
                    withMechVent
    annotation (Placement(transformation(extent={{86,-22},{106,-2}})));
  Modelica.Blocks.Interfaces.RealOutput heatOutput_SAH if withSolAirHeat
    "Connector of Real output signal" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={6,-100})));
  parameter Modelica.SIunits.MassFlowRate MassFlowSetPoint=0.0306
    "Mass Flow Set Point for solar air heater" annotation(Dialog(tab = "Solar Air Heater", enable = withSolAirHeat));
  parameter Modelica.SIunits.Area CoverArea=1.2634
    "Cover Area for solar air heater" annotation(Dialog(tab = "Solar Air Heater", enable = withSolAirHeat));
  parameter Modelica.SIunits.Area InnerCrossSection=0.01181
    "Channel Cross Section for solar air heater" annotation(Dialog(tab = "Solar Air Heater", enable = withSolAirHeat));
  parameter Modelica.SIunits.Length Perimeter=1.348
    "Perimeter for solar air heater" annotation(Dialog(tab = "Solar Air Heater", enable = withSolAirHeat));
  parameter Modelica.SIunits.Length SAHLength1=1.8
    "Channel Length 1 for solar air heater" annotation(Dialog(tab = "Solar Air Heater", enable = withSolAirHeat));
  parameter Modelica.SIunits.Length SAHLength2=1.5
    "Channel Length 2 for solar air heater" annotation(Dialog(tab = "Solar Air Heater", enable = withSolAirHeat));
  parameter Modelica.SIunits.HeatCapacity AbsorberHeatCapacity=3950
    "Absorber Heat Capacityfor solar air heater" annotation(Dialog(tab = "Solar Air Heater", enable = withSolAirHeat));
  parameter Modelica.SIunits.TransmissionCoefficient CoverTransmitance=0.84
    "Cover Transmitance for solar air heater" annotation(Dialog(tab = "Solar Air Heater", enable = withSolAirHeat));
  parameter Modelica.SIunits.ThermalConductance CoverConductance=3.2
    "Cover Conductance for solar air heater" annotation(Dialog(tab = "Solar Air Heater", enable = withSolAirHeat));
equation
  
  if withMechVent then
    connect(weaBus, mechVent.weaBus) annotation (Line(
      points={{-90,6},{-40,6},{-40,14},{-30,14},{-30,14.22},{-21.32,14.22}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
    connect(mechVent.Schedule_mechVent, Schedule_mechVent) annotation (Line(
        points={{-20.3,-8.9},{-40,-8.9},{-40,-60},{-100,-60}}, color={0,0,127}));
    connect(mechVent.port_b, port_b) annotation (Line(points={{11.32,7.42},{20,7.42},
            {20,-12},{96,-12}},
                              color={0,127,255}));
    connect(port_a, mechVent.port_a) annotation (Line(points={{96,-52},{20,-52},
            {20,0.62},{11.32,0.62}},
                               color={0,127,255}));
  end if;

  if withPV then
    connect(solRadPort, pVSystem.IcTotalRad) annotation (Line(points={{-96,69},{
            -40,69},{-40,70},{-20,70},{-20,69.5},{-21.8,69.5}},
        color={255,128,0}));
    connect(pVSystem.TOutside, weaBus.TDryBul) annotation (Line(points={{-22,
          77.6},{-40,77.6},{-40,6},{-90,6}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
    connect(pVSystem.PVPowerW, Pel_PV)
    annotation (Line(points={{1,70},{20,70},{20,-76},{-32,-76},{-32,-100}},
                                              color={0,0,127}));
  end if;

  if withSolAirHeat then
    connect(solarAirHeater.solarRad_in, solRadPort) annotation (Line(points={{-24.54,
            -55},{-40,-55},{-40,69},{-96,69}},
                                             color={255,128,0}));
    connect(solarAirHeater.T_in, weaBus.TDryBul) annotation (Line(points={{-17.4,-69.28},
          {-17.4,-70},{-40,-70},{-40,6},{-90,6}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
    connect(solarAirHeater.heatOutput, heatOutput_SAH) annotation (Line(points={{-29.16,
          -39.6},{-40,-39.6},{-40,-76},{6,-76},{6,-100}}, color={0,0,127}));
  connect(solarAirHeater.sahaix_switch, Schedule_mechVent) annotation(
    Line(points = {{12, -40}, {22, -40}, {22, -30}, {-92, -30}, {-92, -60}, {-100, -60}}, color = {0, 0, 127}));
  end if;

  annotation (Icon(graphics={Rectangle(
          extent={{-80,80},{80,-80}},
          lineColor={28,108,200},
          fillColor={58,200,184},
          fillPattern=FillPattern.Sphere), Text(
          extent={{-58,46},{58,-42}},
          lineColor={255,255,255},
          fillPattern=FillPattern.Sphere,
          fillColor={58,200,184},
          textString="Fancy 
Facade")}), Documentation(revisions="<html>
<ul>
<li><i>April, 2019&nbsp;</i> by Ana Constantin:<br>First implementation</li>
</ul>
</html>", info="<html>
<p>Model for a smart facade with the following components:</p>
<ul>
<li>PV-generation module</li>
<li>Mechanical ventilation</li>
<li>Solar Air Heater</li>
</ul>
<p>Each of these components can be individualy (de)activated.</p>
</html>"));
end SmartFacade;
