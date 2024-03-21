within AixLib.Systems.ModularEnergySystems.Modules.ModularHeatPump;
model ModularHeatPump_Air

   extends AixLib.Fluid.Interfaces.PartialTwoPortInterface(redeclare package
      Medium = AixLib.Media.Water,
                           final m_flow_nominal=QDes/MediumCon.cp_const/DeltaTCon);

  parameter Modelica.Units.SI.Temperature THotDes=313.15 "Design temperature of THot"
   annotation (Evaluate=false,Dialog(group="Design condition"));
  parameter Modelica.Units.SI.Temperature TSourceDes=278.15 "Design temperature of heat source"
   annotation (Evaluate=false,Dialog(group="Design condition"));
  parameter Modelica.Units.SI.HeatFlowRate QDes=150000 "Design heat flow rate of heat pump"
   annotation (Evaluate=false,Dialog(group="Design condition"));
  parameter Modelica.Units.SI.TemperatureDifference DeltaTCon=5 "Temperature difference heat sink condenser"
   annotation (Evaluate=false,Dialog(tab="Advanced",group="General machine information"));

    parameter Modelica.Units.SI.Temperature TCon_start=THotDes
                                                              "Initial temperature condenser"
    annotation (Dialog(tab="Advanced"));

    parameter Boolean TSourceInternal=true
                                          "Use internal TSource?"
    annotation (choices(checkBox=true), Dialog(descriptionLabel=true, tab="Advanced",group="General machine information"));
      parameter Modelica.Units.SI.Temperature TSource=TSourceDes "Temperature of heat source"
   annotation (Dialog(enable=TSourceInternal,tab="Advanced",group="General machine information"));

parameter  Modelica.Units.SI.MassFlowRate m_flow_nominal=QDes/MediumCon.cp_const/DeltaTCon;


parameter Modelica.Units.SI.Pressure dpExternal=0               "Additional system pressure difference";

parameter Modelica.Units.SI.Pressure dpInternal(displayUnit="Pa")=10000
                                                     "Pressure difference condenser";

package MediumCon = AixLib.Media.Water "Medium heat sink";

 AixLib.Fluid.HeatPumps.HeatPump heatPump(
    redeclare package Medium_con =
        AixLib.Media.Water,
    redeclare package Medium_eva =
        AixLib.Media.Air,
    refIneFre_constant=0.02,
    nthOrder=3,
    final useBusConnectorOnly=true,
    mFlow_conNominal=m_flow_nominal,
    VCon=max(0.0000001*QDes - 0.0094, 0.003),
    mFlow_evaNominal=max(0.00004*QDes - 0.3177, 0.3),
    VEva=max(0.0000001*QDes - 0.0075, 0.003),
    TCon_start=TCon_start,
    redeclare model PerDataMainHP = PerDataMainHP,
    use_non_manufacturer=false,
    use_rev=false,
    use_autoCalc=false,
    Q_useNominal=QDes,
    use_refIne=false,
    dpCon_nominal=dpInternal,
    use_conCap=false,
    dpEva_nominal=25000,
    use_evaCap=false,
    tauSenT=1,
    transferHeat=false,
    allowFlowReversalEva=true,
    allowFlowReversalCon=true,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    massDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    show_TPort=false,
    THotNom=THotDes,
    TSourceNom=TSourceDes,
    QNom=QDes,
    DeltaTCon=DeltaTCon,
    DeltaTEvap=DeltaTEvap,
    TSource=TSourceDes,
    TSourceInternal=TSourceInternal,
    eta_carnot=eta_carnot)
    annotation (Placement(transformation(extent={{-6,-18},{14,6}})));

  Fluid.Sensors.MassFlowRate        senMasFloHP(redeclare package Medium =
        Media.Water)        annotation (Placement(transformation(
        extent={{8,8},{-8,-8}},
        rotation=180,
        origin={32,0})));
  AixLib.Controls.Interfaces.VapourCompressionMachineControlBus sigBus annotation (
      Placement(transformation(extent={{-14,84},{16,118}}),
        iconTransformation(extent={{-108,-52},{-90,-26}})));
  Fluid.Movers.SpeedControlled_y fan(
    redeclare package Medium = AixLib.Media.Water,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=THotDes,
    allowFlowReversal=true,
    redeclare AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per(
        pressure(V_flow={0,heatPump.con.m_flow_nominal/1000,heatPump.con.m_flow_nominal
            /1000/0.7}, dp={(dpInternal + dpExternal)/0.7,(dpInternal +
            dpExternal),0})),
    inputType=AixLib.Fluid.Types.InputType.Continuous,
    addPowerToMedium=false,
    use_inputFilter=false,
    riseTime=10,
    init=Modelica.Blocks.Types.Init.SteadyState,
    y_start=1)
    annotation (Placement(transformation(extent={{-52,-10},{-32,10}})));

  BaseClasses.HeatPump_Sources.Air air(
    TSourceNom=TSourceDes,
    TSourceInternal=TSourceInternal,
    TSource=TSource,                   redeclare package MediumEvap =
        AixLib.Media.Air,
    DeltaTEvap=7)
    annotation (Placement(transformation(extent={{-16,-54},{4,-34}})));
  Modelica.Blocks.Sources.RealExpression zero3(y=1)
    annotation (Placement(transformation(extent={{-88,94},{-60,112}})));


  Modelica.Blocks.Sources.BooleanExpression mode(y=true)
    annotation (Placement(transformation(extent={{162,60},{126,86}})));
  replaceable model PerDataMainHP =
      AixLib.DataBase.HeatPump.PerformanceData.Generic_Air constrainedby
    DataBase.HeatPump.PerformanceData.BaseClasses.PartialPerformanceData
    annotation (choicesAllMatching=true);
  parameter Real eta_carnot=0.405;
  BaseClasses.COP_calc cOP_calc
    annotation (Placement(transformation(extent={{-72,54},{-52,76}})));
protected
 parameter Modelica.Units.SI.TemperatureDifference DeltaTEvap=7 "Temperature difference heat source evaporator"
   annotation (Dialog(tab="Advanced",group="General machine information"));

equation

  connect(port_a, port_a)
    annotation (Line(points={{-100,0},{-100,0}}, color={0,127,255}));
  connect(sigBus, heatPump.sigBus) annotation (Line(
      points={{1,101},{1,52},{-22,52},{-22,-9.9},{-5.9,-9.9}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(fan.port_b, heatPump.port_a1) annotation (Line(points={{-32,0},{-6,0}},
                                color={0,127,255}));
  connect(heatPump.port_b1, senMasFloHP.port_a)
    annotation (Line(points={{14,0},{19,0},{19,8.88178e-16},{24,8.88178e-16}},
                                             color={0,127,255}));
  connect(port_a, fan.port_a)
    annotation (Line(points={{-100,0},{-52,0}}, color={0,127,255}));
  connect(senMasFloHP.port_b, port_b)
    annotation (Line(points={{40,0},{100,0}}, color={0,127,255}));
  connect(sigBus.mFlowSet, fan.y) annotation (Line(
      points={{1.075,101.085},{1.075,28},{-42,28},{-42,12}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(air.port_b, heatPump.port_a2)
    annotation (Line(points={{4,-44},{14,-44},{14,-12}}, color={0,127,255}));
  connect(heatPump.port_b2, air.port_a) annotation (Line(points={{-6,-12},{-32,-12},
          {-32,-44},{-16,-44}}, color={0,127,255}));
  connect(sigBus, air.sigBus) annotation (Line(
      points={{1,101},{64,101},{64,-33.7},{-5.9,-33.7}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(zero3.y, sigBus.iceFacMea) annotation (Line(points={{-58.6,103},{
          1.075,103},{1.075,101.085}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(mode.y, sigBus.modeSet) annotation (Line(points={{124.2,73},{88,73},{
          88,101.085},{1.075,101.085}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBus.PelMea, cOP_calc.P_el_mea) annotation (Line(
      points={{1.075,101.085},{1.075,86},{-86,86},{-86,69.4},{-74,69.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBus.QCon, cOP_calc.Q_con) annotation (Line(
      points={{1.075,101.085},{1.075,88},{-98,88},{-98,60.6},{-74,60.6}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(cOP_calc.COP, sigBus.COP) annotation (Line(points={{-51,65},{1.075,65},
          {1.075,101.085}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-17,83},{17,-83}},
          fillColor={255,0,128},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          origin={1,61},
          rotation=90),
        Rectangle(
          extent={{-82,42},{84,-46}},
          lineColor={238,46,47},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-16,83},{16,-83}},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          origin={1,-64},
          rotation=90)}),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=40000),
    Documentation(info="<html>
<p>Modular heat pump with different options</p>
<ul>
<li>with or without pump</li>
<li>with or without an external temperature for TSource</li>
</ul>
<p><br>with different operation types:</p>
<ul>
<li>with a fixed THot, which is THotNom -&gt; temperature difference between THot and TCold is not constant</li>
<li>with a fixed DeltaTCon -&gt; THot is not equal THotNom. THotNom is only important for nominal electrical demand</li>
<li>as a high temperature heat pump, using R134a and a piston compressor</li>
<li>as a low temperature heat pump, using R410a and a scroll compressor</li>
</ul>
<p><br>Concept </p>
<p><br>The inner cycle of the heat pump is a Black-Box. The Black-Box uses 4-D performance maps, which describe the COP. The maps are based on a given THot, TSource, DeltaTCon and PLR (for further informations: AixLib.DataBase.ThermalMachines.HeatPump.PerformanceData.LookUpTableNDNotManudacturer). The parameters QNom, THotNom, TSourceNom describe the nominal behaviour for a full load operation point e.g. W10W55 or B0W45. The nominal full load electircal power is calculated with the nominal COP and is constant for different TSource. The part load beaviour describes the part load of the compressor as a product of PLR and nominal full load electrical power (variable speed control). The thermal power and the thermal demand are calculated for any operation point as a function of COP and electrical power.</p>
</html>"));
end ModularHeatPump_Air;
