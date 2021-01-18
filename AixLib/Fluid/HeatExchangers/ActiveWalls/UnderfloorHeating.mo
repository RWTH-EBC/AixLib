within AixLib.Fluid.HeatExchangers.ActiveWalls;
package UnderfloorHeating
  "Package with all models for an underfloor heating system"

  model UnderfloorHeatingSystem "Model for an underfloor heating system"
  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface(allowFlowReversal=
          false, final m_flow_nominal = m_flow_total);
    import Modelica.Constants.e;
    replaceable package Medium =
      Modelica.Media.Interfaces.PartialMedium "Medium in the component"
        annotation (choices(
          choice(redeclare package Medium = AixLib.Media.Water "Water"),
          choice(redeclare package Medium =
              AixLib.Media.Antifreeze.PropyleneGlycolWater (
                property_T=293.15,
                X_a=0.40)
                "Propylene glycol water, 40% mass fraction")));
    extends AixLib.Fluid.Interfaces.LumpedVolumeDeclarations;

    parameter Integer RoomNo(min=1) "Number of rooms heated with panel heating" annotation (Dialog(group="General"));
    final parameter Integer CircuitNo[RoomNo]=underfloorHeatingRoom.CircuitNo
      "Number of circuits in a certain room";
    parameter Integer dis  "Number of discretization layers for panel heating pipe";
    parameter Modelica.SIunits.Power Q_Nf[RoomNo] "Calculated Heat Load for room with panel heating" annotation (Dialog(group="Room Specifications"));
    parameter Modelica.SIunits.Area A[RoomNo] "Floor Area" annotation(Dialog(group = "Room Specifications"));
    parameter Integer calculateVol = 1 annotation (Dialog(group="Panel Heating",
          descriptionLabel=true), choices(
        choice=1 "Calculate Water Volume with inner diameter",
        choice=2 "Calculate Water Volume with time constant",
        radioButtons=true));
    parameter Integer use_vmax(min = 1, max = 2) = 1 "Output if v > v_max (0.5 m/s)" annotation(choices(choice = 1 "Warning", choice = 2 "Error"));
    parameter Modelica.SIunits.Length maxLength = 120 "Maximum Length for one Circuit" annotation(Dialog(group = "Panel Heating"));
    parameter Modelica.SIunits.Temperature T_Fmax[RoomNo] = fill(29 + 273.15, RoomNo) "Maximum surface temperature" annotation (Dialog(group="Room Specifications"));
    parameter Modelica.SIunits.Temperature T_Room[RoomNo] = fill(20 + 273.15, RoomNo) "Nominal room temperature" annotation (Dialog(group="Room Specifications"));
    parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallTypeFloor[RoomNo] "Wall type for floor" annotation (Dialog(group="Room Specifications"), choicesAllMatching=true);
    parameter Boolean Ceiling[RoomNo] "false if ground plate is under panel heating" annotation (Dialog(group = "Room Specifications"));
    parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallTypeCeiling[RoomNo] "Wall type for ceiling" annotation (Dialog(group="Room Specifications", enable = Ceiling), choicesAllMatching=true);
    parameter Modelica.SIunits.Temperature T_U[RoomNo] = fill(Modelica.SIunits.Conversions.from_degC(20), RoomNo) "Set value for Room Temperature lying under panel heating" annotation (Dialog(group="Room Specifications"));
    parameter Modelica.SIunits.Distance Spacing[RoomNo] "Spacing between tubes" annotation (Dialog( group = "Panel Heating"));
    final parameter Modelica.SIunits.Length PipeLength[RoomNo] = A ./ Spacing "Pipe Length in every room";

    parameter
      UnderfloorHeating.BaseClasses.PipeMaterials.PipeMaterialDefinition PipeMaterial=
        UnderfloorHeating.BaseClasses.PipeMaterials.PERTpipe() "Pipe Material"
      annotation (Dialog(group="Panel Heating"), choicesAllMatching=true);
    parameter Modelica.SIunits.Thickness PipeThickness[RoomNo] "Thickness of pipe wall" annotation (Dialog( group = "Panel Heating"));
    parameter Modelica.SIunits.Diameter d_a[RoomNo] "Outer diameter of pipe" annotation (Dialog( group = "Panel Heating"));

    parameter Boolean withSheathing = true "false if pipe has no Sheathing" annotation (Dialog(group = "Panel Heating"), choices(checkBox=true));
    parameter
      UnderfloorHeating.BaseClasses.Sheathing_Materials.SheathingMaterialDefinition
      SheathingMaterial=
        UnderfloorHeating.BaseClasses.Sheathing_Materials.PVCwithTrappedAir()
      "Sheathing Material" annotation (Dialog(group="Panel Heating", enable=
            withSheathing), choicesAllMatching=true);
    parameter Modelica.SIunits.Diameter d[RoomNo](min = d_a) = d_a "Outer diameter of pipe including Sheathing" annotation (Dialog( group = "Panel Heating", enable = withSheathing));

    final parameter Modelica.SIunits.MassFlowRate m_flow_total=sum(
        underfloorHeatingRoom.m_flow_PanelHeating)
      "Total mass flow in the panel heating system";
    final parameter Modelica.SIunits.HeatFlux q_max=max(underfloorHeatingRoom.q)
      "highest specific heat flux in system";
    parameter Modelica.SIunits.TemperatureDifference sigma_des(max = 5) = 5  "Temperature Spread for room with highest heat load (max = 5)";
    final parameter Modelica.SIunits.TemperatureDifference dT_Hdes = q_max / K_H[1] "Temperature difference between medium and room for room with highest heat flux";
    final parameter Modelica.SIunits.TemperatureDifference dT_Vdes = dT_Hdes + sigma_des / 2 + sigma_des^(2) / (12 * dT_Hdes) "Temperature difference at flow temperature";
    final parameter Modelica.SIunits.Temperature T_Vdes = (T_Roomdes - ((sigma_des + T_Roomdes) * e^(sigma_des / dT_Hdes))) / (1 - e^(sigma_des / dT_Hdes)) "Flow Temperature according to EN 1264";
    final parameter Modelica.SIunits.Temperature T_Roomdes = T_Room[1] "Room temperature in room with highest heat flux";
    final parameter Modelica.SIunits.TemperatureDifference sigma_i[RoomNo] = cat(1, {sigma_des}, {(3 * dT_Hi[n] * (( 1 + 4 * ( dT_Vdes - dT_Hi[n])  / ( 3 * dT_Hi[n])) ^ (0.5) - 1)) for n in 2:RoomNo}) "Nominal temperature spread in rooms";
    final parameter Modelica.SIunits.Temperature T_Return[RoomNo] = fill(T_Vdes, RoomNo) .- sigma_i "Nominal return temperature in each room";

    final parameter Real K_H[RoomNo]=underfloorHeatingRoom.K_H
      "Specific parameter for dimensioning according to EN 1264 that shows the relation between temperature difference and heat flux";
    final parameter Real q[RoomNo]=underfloorHeatingRoom.q
      "needed heat flux from underfloor heating";
    final parameter Modelica.SIunits.TemperatureDifference dT_Hi[RoomNo] = q ./ K_H "Nominal temperature difference between heating medium and room for each room";

    parameter Modelica.SIunits.PressureDifference dp_Pipe[RoomNo] = 100 * PipeLength ./ CircuitNo "Pressure Difference in each pipe for every room";
    final parameter Modelica.SIunits.PressureDifference dp_Valve[RoomNo] = max(dp_Pipe) .- dp_Pipe "Pressure Difference set in regulating valve for pressure equalization";
    final parameter Modelica.SIunits.PressureDifference dp_Distributor=if sum(
        CircuitNo) == 1 then 0 else
        UnderfloorHeating.BaseClasses.PressureLoss.GetPressureLossOfUFHDistributor(
        V_flow_total/n_Distributors, n_HC)
      "Nominal pressure drop of control equipment";
    final parameter Integer n_Distributors(min = 1) = integer(ceil(sum(CircuitNo)/14)) "Number of Distributors needed in the underfloor heating system";
    final parameter Modelica.SIunits.VolumeFlowRate V_flow_total = m_flow_total / rho_default "Nominal system volume flow rate";
    final parameter Integer n_HC(min=1) = integer(ceil(sum(CircuitNo) / n_Distributors)) "Average number of heating circuits in distributor";

    BaseClasses.Distributor distributor(
      redeclare package Medium = Medium,
      energyDynamics=energyDynamics,
      massDynamics=massDynamics,
      p_start=p_start,
      T_start=T_start,
      X_start=X_start,
      C_start=C_start,
      C_nominal=C_nominal,
      mSenFac=mSenFac,
      m_flow_nominal=m_flow_total,
      n=integer(sum(CircuitNo))) annotation (Placement(transformation(
          extent={{-12,-12},{12,12}},
          rotation=0,
          origin={-28,0})));
    UnderfloorHeatingRoom underfloorHeatingRoom[RoomNo](
      redeclare each final package Medium = Medium,
      each allowFlowReversal=false,
      each final energyDynamics=energyDynamics,
      each final massDynamics=massDynamics,
      each final p_start=p_start,
      each final T_start=T_start,
      each final X_start=X_start,
      each final C_start=C_start,
      each final C_nominal=C_nominal,
      each final mSenFac=mSenFac,
      final Q_Nf=Q_Nf,
      final A=A,
      final dp_Pipe=dp_Pipe,
      final dp_Valve=dp_Valve,
      each final dpFixed_nominal=dp_Distributor,
      final Ceiling=Ceiling,
      final T_U=T_U,
      final T_Fmax=T_Fmax,
      final T_Room=T_Room,
      each final PipeMaterial=PipeMaterial,
      final PipeThickness=PipeThickness,
      final d_a=d_a,
      each final withSheathing=withSheathing,
      each final SheathingMaterial=SheathingMaterial,
      final d=d,
      each use_vmax=use_vmax,
      each T_Flow=T_Vdes,
      T_Return=T_Return,
      each calculateVol=calculateVol,
      each final dis=dis,
      final Spacing=Spacing,
      each maxLength=maxLength,
      final wallTypeFloor=wallTypeFloor,
      final wallTypeCeiling=wallTypeCeiling,
      final dT_Hi=dT_Hi)
      annotation (Placement(transformation(extent={{-16,16},{16,36}})));
    AixLib.Fluid.Sensors.TemperatureTwoPort TFlow(
      redeclare package Medium = Medium,
      allowFlowReversal=false,
      m_flow_nominal=m_flow_total,
      T_start=T_start)
      annotation (Placement(transformation(extent={{-74,-8},{-58,8}})));
    AixLib.Fluid.Sensors.TemperatureTwoPort TReturn(
      redeclare package Medium = Medium,
      allowFlowReversal=false,
      m_flow_nominal=m_flow_total,
      T_start=T_start)
      annotation (Placement(transformation(extent={{34,-8},{50,8}})));

    Modelica.Blocks.Sources.RealExpression m_flowNom(y=m_flow_total)
      annotation (Placement(transformation(extent={{-60,-46},{-80,-26}})));
    Modelica.Blocks.Interfaces.RealOutput m_flowNominal
      annotation (Placement(transformation(extent={{-90,-46},{-110,-26}})));
    Modelica.Blocks.Sources.RealExpression T_FlowNom(y=T_Vdes)
      annotation (Placement(transformation(extent={{-60,-64},{-80,-44}})));
    Modelica.Blocks.Interfaces.RealOutput T_FlowNominal
      annotation (Placement(transformation(extent={{-90,-64},{-110,-44}})));
    Modelica.Blocks.Interfaces.RealInput valveInput[sum(CircuitNo)] annotation (
        Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=-90,
          origin={-64,68})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatFloor[RoomNo*dis]
      annotation (Placement(transformation(extent={{-10,50},{10,70}}),
          iconTransformation(extent={{-10,50},{10,70}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatCeiling[RoomNo*dis]
      annotation (Placement(transformation(extent={{-10,-70},{10,-50}}),
          iconTransformation(extent={{-10,-70},{10,-50}})));
  protected
    parameter Medium.ThermodynamicState sta_default=Medium.setState_pTX(
        T=Medium.T_default,
        p=Medium.p_default,
        X=Medium.X_default);
    parameter Modelica.SIunits.Density rho_default=Medium.density(sta_default)
      "Density, used to compute fluid volume";

  initial equation
    // Check validity of data
    assert(q[1] == q_max, "The room with the highest specific heat load needs to be the first element of the vector. Ignore if highest heat load appears in bathroom", AssertionLevel.warning);

  equation

    // HEAT CONNECTIONS

     for i in 1:RoomNo loop
       for n in 1:dis loop
    connect(heatFloor[(i-1)*dis+n], underfloorHeatingRoom[i].heatFloor[n])
      annotation (Line(points={{0,60},{0,36}}, color={191,0,0}));
    connect(underfloorHeatingRoom[i].heatCeiling[n], heatCeiling[(i-1)*dis+n])
      annotation (Line(points={{0,16},{0,-60}}, color={191,0,0}));
       end for;
            end for;

   // OUTER FLUID CONNECTIONS
    connect(port_a, TFlow.port_a)
      annotation (Line(points={{-100,0},{-74,0}}, color={0,127,255}));
    connect(TFlow.port_b, distributor.mainFlow)
      annotation (Line(points={{-58,0},{-40,0}}, color={0,127,255}));
    connect(TReturn.port_a, distributor.mainReturn)
      annotation (Line(points={{34,0},{-16,0}}, color={0,127,255}));
    connect(TReturn.port_b, port_b)
      annotation (Line(points={{50,0},{100,0}}, color={0,127,255}));

    // HEATING CIRCUITS FLUID CONNECTIONS

       for m in 1:CircuitNo[1] loop
      connect(distributor.flowPorts[m], underfloorHeatingRoom[1].ports_a[m]);
      connect(underfloorHeatingRoom[1].ports_b[m], distributor.returnPorts[m]);
      connect(underfloorHeatingRoom[1].valveInput[m], valveInput[m]) annotation (
          Line(points={{-9.92,38},{-10,38},{-10,42},{-64,42},{-64,68}}, color={0,0,
              127}));
    end for;

    if RoomNo > 1 then
      for x in 2:RoomNo loop
        for u in 1:CircuitNo[x] loop
          connect(distributor.flowPorts[(sum(CircuitNo[v] for v in 1:(x - 1)) + u)],
            underfloorHeatingRoom[x].ports_a[u]) annotation (Line(points={{-29.6,
                  12},{-29.6,27.4286},{-16,27.4286}},
                                                  color={0,127,255}));
          connect(underfloorHeatingRoom[x].ports_b[u], distributor.returnPorts[(
            sum(CircuitNo[v] for v in 1:(x - 1)) + u)]) annotation (Line(points={{16,
                  27.4286},{24,27.4286},{24,-22},{-26.4,-22},{-26.4,-12.4}},
                color={0,127,255}));
          connect(underfloorHeatingRoom[x].valveInput[u], valveInput[(sum(
            CircuitNo[v] for v in 1:(x - 1)) + u)]) annotation (Line(points={{-9.92,
                  38},{-10,38},{-10,42},{-64,42},{-64,68}}, color={0,0,127}));
        end for;
            end for;
    end if;

    // OTHER CONNECTIONS

    connect(m_flowNom.y, m_flowNominal)
      annotation (Line(points={{-81,-36},{-100,-36}}, color={0,0,127}));
    connect(T_FlowNom.y, T_FlowNominal)
      annotation (Line(points={{-81,-54},{-100,-54}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(extent={{-100,-60},{100,60}}, initialScale=0.1),
          graphics={
          Rectangle(
            extent={{-100,60},{100,-60}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-40,40},{100,-16}},
            lineColor={0,0,0},
            fillColor={215,215,215},
            fillPattern=FillPattern.Forward),
          Rectangle(
            extent={{-88,42},{-64,-38}},
            lineColor={0,0,0},
            fillColor={175,175,175},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-80,40},{-72,32}},
            lineColor={238,46,47},
            fillColor={238,46,47},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-80,26},{-72,18}},
            lineColor={28,108,200},
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-80,12},{-72,4}},
            lineColor={238,46,47},
            fillColor={238,46,47},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-80,0},{-72,-8}},
            lineColor={28,108,200},
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-80,-28},{-72,-36}},
            lineColor={28,108,200},
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-80,-14},{-72,-22}},
            lineColor={238,46,47},
            fillColor={238,46,47},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-40,-40},{100,-50}},
            lineColor={0,0,0},
            fillColor={215,215,215},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{-40,-32},{100,-40}},
            lineColor={0,0,0},
            fillColor={215,215,215},
            fillPattern=FillPattern.Forward),
          Rectangle(
            extent={{-40,-16},{100,-32}},
            lineColor={0,0,0},
            fillColor={175,175,175},
            fillPattern=FillPattern.Backward),
          Rectangle(
            extent={{-40,50},{100,40}},
            lineColor={0,0,0},
            fillColor={215,215,215},
            fillPattern=FillPattern.CrossDiag),
          Line(points={{-74,8},{-60,8},{-50,8},{-50,-8},{-28,-8}},
              color={255,0,0}),
          Line(points={{-78,-4},{-64,-4},{-54,-4},{-54,-14},{-28,-14}},
              color={28,108,200}),
          Line(points={{-74,-18},{-50,-18},{-50,-8}},     color={238,46,47}),
          Line(points={{-78,-32},{-54,-32},{-54,-14}},    color={28,108,200}),
          Line(points={{-76,36},{-62,36},{-50,36},{-50,8}},      color={238,46,47}),
          Line(points={{-76,22},{-54,22},{-54,-4}},     color={28,108,200}),
          Text(
            extent={{-36,38},{82,24}},
            lineColor={0,0,0},
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid,
            textString="1 ... RoomNo"),
          Ellipse(
            extent={{-34,-6},{-26,-14}},
            lineColor={200,200,200},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-20,-6},{-12,-14}},
            lineColor={200,200,200},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-6,-6},{2,-14}},
            lineColor={200,200,200},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{8,-6},{16,-14}},
            lineColor={200,200,200},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{22,-6},{30,-14}},
            lineColor={200,200,200},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{36,-6},{44,-14}},
            lineColor={200,200,200},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{50,-6},{58,-14}},
            lineColor={200,200,200},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{64,-6},{72,-14}},
            lineColor={200,200,200},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{78,-6},{86,-14}},
            lineColor={200,200,200},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-100,0},{-88,0}}, color={238,46,47}),
          Line(points={{82,0},{94,0}}, color={28,108,200}),
          Line(points={{82,-6},{82,0}}, color={28,108,200})}), Documentation(
     info="<html>
<p>
  <b><span style=\"color: #008000;\">Overview</span></b>
</p>
<p>
Model for heat transfer of an underfloor heating system for heating of multiple rooms. It can be directly used with the High Order Model.
</p>
<p>
  <b><span style=\"color: #008000;\">Concept</span></b>
</p>
<p>This model represents an underfloor heating system for several rooms. It calculates the number of heating circuits for each room and merges them in a distributor.
</p>
<p> Every heating circuit has an equal percentage valve that has to be regulated from outside.
</p>
<p>For the determination of the nominal mass flow and the flow temperature the regulations by prEN 1264 are implemented.
</p>
<b><span style=\"color: #008000;\">Heat Flow</span></b>
<p> For correct dimensioning, the room with the highest heat load needs to be the first one that is connected!</p>
<p> Every room needs to have <i>dis</i> heat connections to the underfloor heating system to determine the right surface temperatures.</p>
<b><span style=\"color: #008000;\">Layer Structure</span></b>
<p>For dimensioning it is important that the layer structure of the floor is set right! </p>
<p> The wall layers above the heating circuits have to be in the following order:</p>
<p>1. Cover / Screed </p>
<p>2. Floor </p>
<p> The wall layers below the heating circuits need to be in the record with the following order: </p>
<p>1. Isolation</p>
<p>2. Load-bearing substrate </p>
<p>3. Plaster </p>
<p> If there is a floor plate underneath the heating circuits, the wall record needs to consist of 4 layers, whereas the first layer needs to be the isolation!</p>
<b><span style=\"color: #008000;\">Isolation</span></b>
<p> The thermal resistance of the isolation needs to fulfill the following requirements:</p>
<p> Room underneath the underfloor heating is heated: R<sub>lambda,Ins</sub> <code> >= 0,75 W/m²K</code></p>
<p> Room underneath the underfloor heating is not heated / floor plate: R<sub>lambda,Ins</sub> <code> >= 1,25 W/m²K</code></p>
<b><span style=\"color: #008000;\">Water Volume</span></b>
</p>
<p>
The water volume in the pipe element can be calculated by the inner diameter of the pipe or by time constant and the mass flow. 
</p>
<p>
The maximum velocity in the pipe is set for 0.5 m/s. If the Water Volume is calculated by time constant,
a nominal inner diameter is calculated with the maximum velocity for easier parametrization.
</p>
</html>"),                                    Diagram(coordinateSystem(extent={{-100,
              -60},{100,60}}, initialScale=0.1)));
  end UnderfloorHeatingSystem;

  model UnderfloorHeatingRoom "Model for heating of one room with underfloor heating"
    extends UnderfloorHeating.BaseClasses.PartialModularPort_ab(final nPorts=
          CircuitNo, final m_flow_nominal=m_flow_PanelHeating);
     extends AixLib.Fluid.Interfaces.LumpedVolumeDeclarations;
     import Modelica.Constants.pi;

    parameter Integer dis(min=1) "Number of Discreatisation Layers";
    final parameter Integer CircuitNo(min=1) = integer(ceil(PipeLength/maxLength))
      "number of circuits in one room";

    parameter Integer calculateVol annotation (Dialog(group="Panel Heating",
          descriptionLabel=true), choices(
        choice=1 "Calculate Water Volume with inner diameter",
        choice=2 "Calculate Water Volume with time constant",
        radioButtons=true));
    parameter Modelica.SIunits.Length maxLength=120
      "Maximum Length for one Circuit" annotation (Dialog(group="Panel Heating"));

    parameter Modelica.SIunits.Power Q_Nf
      "Calculated Heat Load for room with panel heating"
      annotation (Dialog(group="Room Specifications"));
    final parameter Modelica.SIunits.HeatFlux q=Q_Nf/A
      "set value for panel heating heat flux";
    final parameter Modelica.SIunits.Power Q_F=if q <= q_G then q*A else q_G*A
      "nominal heat flow of panel heating";
    parameter Modelica.SIunits.Area A "Floor Area"
      annotation (Dialog(group="Room Specifications"));
    final parameter Modelica.SIunits.Power Q_out=Q_Nf - Q_F
      "needed heating power by other heating equipment";

    parameter Modelica.SIunits.Temperature T_Flow "nominal flow temperature";
    parameter Modelica.SIunits.Temperature T_Return "nominal return temperature";
    parameter Modelica.SIunits.PressureDifference dp_Pipe=100*PipeLength
      "Nominal pressure drop in every heating circuit" annotation (Dialog(group="Pressure Drop"));
    parameter Modelica.SIunits.PressureDifference dp_Valve = 0
      "Pressure Difference set in regulating valve for pressure equalization" annotation (Dialog(group="Pressure Drop"));
    parameter Modelica.SIunits.PressureDifference dpFixed_nominal =  0  "Additional pressure drop for every heating circuit, e.g. for distributor" annotation (Dialog(group="Pressure Drop"));

    parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallTypeFloor
      "Wall type for floor"
      annotation (Dialog(group="Room Specifications"), choicesAllMatching=true);
    parameter Modelica.SIunits.Temperature T_Fmax=29 + 273.15
      "Maximum surface temperature"
      annotation (Dialog(group="Room Specifications"));
    parameter Modelica.SIunits.Temperature T_Room=20 + 273.15
      "Nominal room temperature" annotation (Dialog(group="Room Specifications"));
    final parameter Modelica.SIunits.HeatFlux q_Gmax=8.92*(T_Fmax - T_Room)^(1.1)
      "Maxium possible heat flux with given surface temperature and room temperature";
    parameter Boolean Ceiling "false if ground plate is under panel heating"
      annotation (Dialog(group="Room Specifications"), choices(checkBox=true));
    parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallTypeCeiling
      "Wall type for ceiling"
      annotation (Dialog(group="Room Specifications"), choicesAllMatching=true);
    parameter Modelica.SIunits.Temperature T_U=
        Modelica.SIunits.Conversions.from_degC(20)
      "Nominal Room Temperature lying under panel heating"
      annotation (Dialog(group="Room Specifications"));

    parameter Modelica.SIunits.Distance Spacing "Spacing between tubes"
      annotation (Dialog(group="Panel Heating"));
    final parameter Modelica.SIunits.Length PipeLength=A/Spacing
      "possible pipe length for given panel heating area";

    parameter
      UnderfloorHeating.BaseClasses.PipeMaterials.PipeMaterialDefinition PipeMaterial
      "Pipe Material"
      annotation (Dialog(group="Panel Heating"), choicesAllMatching=true);
    final parameter Modelica.SIunits.ThermalConductivity lambda_R=PipeMaterial.lambda
      "Thermal conductivity of pipe material";
    parameter Modelica.SIunits.Thickness PipeThickness "thickness of pipe wall"
      annotation (Dialog(group="Panel Heating"));
    parameter Modelica.SIunits.Diameter d_a "outer diameter of pipe"
      annotation (Dialog(group="Panel Heating"));
    final parameter Modelica.SIunits.Diameter d_i=d_a - 2*PipeThickness
      "inner diameter of pipe";

    parameter Boolean withSheathing=false "false if pipe has no sheathing"
      annotation (Dialog(group="Panel Heating"), choices(checkBox=true));
    parameter
      UnderfloorHeating.BaseClasses.Sheathing_Materials.SheathingMaterialDefinition
      SheathingMaterial=
        UnderfloorHeating.BaseClasses.Sheathing_Materials.PVCwithTrappedAir()
      "Sheathing Material" annotation (Dialog(group="Panel Heating"));
    final parameter Modelica.SIunits.ThermalConductivity lambda_M=if
        withSheathing then SheathingMaterial.lambda else 0
      "Thermal Conductivity for sheathing";
    parameter Modelica.SIunits.Diameter d(min=d_a) = d_a
      "Outer diameter of pipe including sheathing"
      annotation (Dialog(group="Panel Heating", enable=withSheathing));
    final parameter Modelica.SIunits.Diameter d_M=if withSheathing then d else 0
      "Outer diameter of sheathing";

    final parameter Modelica.SIunits.Thickness InsulationThickness=
        wallTypeCeiling.d[1] "Thickness of thermal insulation";
    final parameter Modelica.SIunits.ThermalConductivity lambda_ins=
        wallTypeCeiling.lambda[1] "Thermal conductivity of thermal insulation";
    final parameter Modelica.SIunits.ThermalInsulance R_lambdaIns= InsulationThickness/lambda_ins "Thermal resistance of thermal insulation";

    final parameter Modelica.SIunits.Thickness CoverThickness=wallTypeFloor.d[1]
      "thickness of cover above pipe";
    final parameter Modelica.SIunits.ThermalConductivity lambda_u=wallTypeFloor.lambda[1]
      "Thermal conductivity of wall layers above panel heating without flooring (coverage)";
    final parameter Modelica.SIunits.ThermalConductivity lambda_E=lambda_u
      "Thermal conductivity of cover";

    final parameter Modelica.SIunits.ThermalInsulance R_lambdaB=wallTypeFloor.d[2]
        /wallTypeFloor.lambda[2] "Thermal resistance of flooring";

    final parameter Modelica.SIunits.ThermalInsulance R_lambdaCeiling=if Ceiling
         then wallTypeCeiling.d[2]/wallTypeCeiling.lambda[2] else (wallTypeCeiling.d[2]/wallTypeCeiling.lambda[2] + wallTypeCeiling.d[3]/wallTypeCeiling.lambda[3] + wallTypeCeiling.d[4]/wallTypeCeiling.lambda[4])
      "Thermal resistance of ceiling";
    final parameter Modelica.SIunits.ThermalInsulance R_lambdaPlaster=if Ceiling
         then wallTypeCeiling.d[3]/wallTypeCeiling.lambda[3] else 0
      "Thermal resistance of plaster";
    final parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_Ceiling = 5.8824 "Coefficient of heat transfer at Ceiling Surface";

    final parameter Modelica.SIunits.ThermalInsulance R_U=EN_1264.R_U
      "Thermal resistance of wall layers under panel heating";
    final parameter Modelica.SIunits.ThermalInsulance R_O=EN_1264.R_O
      "Thermal resistance of wall layers above panel heating";

    final parameter Modelica.SIunits.TemperatureDifference sigma_i=T_Flow -
        T_Return
      "Temperature spread for room (max = 5 for room with highest heat load)"
      annotation (Dialog(group="Room Specifications"));

    final parameter Modelica.SIunits.MassFlowRate m_flow_PanelHeating=A*q/(
        sigma_i*Cp_Medium)*(1 + (R_O/R_U) + (T_Room - T_U)/(q*R_U))
      "nominal mass flow rate";
    final parameter Modelica.SIunits.MassFlowRate m_flow_Circuit=
        m_flow_PanelHeating/CircuitNo
      "Nominal mass flow rate in each heating circuit";
    parameter Integer use_vmax(min=1, max=2) "Output if v > v_max (0.5 m/s)"
      annotation (choices(choice=1 "Warning", choice=2 "Error"));

    final parameter Real K_H=EN_1264.K_H
      "Specific parameter for dimensioning according to EN 1264 that shows the relation between temperature difference and heat flux";
    final parameter Modelica.SIunits.HeatFlux q_G=EN_1264.q_G
      "specific limiting heat flux";
    parameter Modelica.SIunits.TemperatureDifference dT_Hi
      "Nominal temperature difference between heating medium"
      annotation (Dialog(group="Panel Heating"));
    final parameter Modelica.SIunits.TemperatureDifference dT_HU=
        UnderfloorHeating.BaseClasses.logDT({T_Flow,T_Return,T_U});

    final parameter Modelica.SIunits.ThermalResistance R_add = 1/(K_H*(1 + R_O/R_U*dT_Hi/dT_HU)*A + A*(T_Room-T_U)/(R_U*dT_HU)) - 1/(A/R_O + A/R_U*dT_Hi/dT_HU) - R_pipe - 1/(2200 * pi*d_i*PipeLength) "additional thermal resistance";
    final parameter Modelica.SIunits.ThermalResistance R_pipe = if withSheathing then (log(d_M/d_a))/(2*lambda_M*pi*PipeLength) + (log(d_a/d_i))/(2*lambda_R*pi*PipeLength) else (log(d_a/d_i))/(2*lambda_R*pi*PipeLength) "thermal resistance through pipe layers";
    UnderfloorHeatingCircuit underfloorHeatingCircuit[CircuitNo](
      each final energyDynamics=energyDynamics,
      each final massDynamics=massDynamics,
      each final p_start=p_start,
      each final T_start=T_start,
      each final X_start=X_start,
      each final C_start=C_start,
      each final C_nominal=C_nominal,
      each final mSenFac=mSenFac,
      each final dp_Pipe=dp_Pipe,
      each final dp_Valve=dp_Valve,
      each final dpFixed_nominal=dpFixed_nominal,
      each final T_Fmax=T_Fmax,
      each final T_Room=T_Room,
      each final PipeMaterial=PipeMaterial,
      each final PipeThickness=PipeThickness,
      each final d_a=d_a,
      each final withSheathing=withSheathing,
      each SheathingMaterial=SheathingMaterial,
      each d=d,
      redeclare each final package Medium = Medium,
      each final A=A/CircuitNo,
      each calculateVol=calculateVol,
      each final dis=dis,
      each use_vmax=use_vmax,
      each final Spacing=Spacing,
      each m_flow_Circuit=m_flow_Circuit,
      each final wallTypeFloor=wallTypeFloor,
      each final wallTypeCeiling=wallTypeCeiling,
      each R_x=R_add*CircuitNo)
      annotation (Placement(transformation(extent={{-22,-8},{22,8}})));
    BaseClasses.EN1264.HeatFlux EN_1264(
      lambda_E=lambda_E,
      R_lambdaB0=R_lambdaB,
      R_lambdaIns=R_lambdaIns,
      alpha_Ceiling=alpha_Ceiling,
      T_U=T_U,
      d_a=d_a,
      lambda_R=lambda_R,
      s_R=PipeThickness,
      withSheathing=withSheathing,
      lambda_M=lambda_M,
      s_u=CoverThickness,
      T_Fmax=T_Fmax,
      T_Room=T_Room,
      q_Gmax=q_Gmax,
      dT_H=dT_Hi,
      Ceiling=Ceiling,
      R_lambdaCeiling=R_lambdaCeiling,
      R_lambdaPlaster=R_lambdaPlaster,
      D=d,
      T=Spacing)
      annotation (Placement(transformation(extent={{-100,-60},{-60,-40}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatFloor[dis]
      annotation (Placement(transformation(extent={{-10,50},{10,70}}),
          iconTransformation(extent={{-10,50},{10,70}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatCeiling[dis]
      annotation (Placement(transformation(extent={{-10,-90},{10,-70}}),
          iconTransformation(extent={{-10,-90},{10,-70}})));
    Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollectorCeiling[dis](each m=
          CircuitNo)
      annotation (Placement(transformation(extent={{-10,-58},{10,-38}})));
    Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollectorFloor[dis](each m=
          CircuitNo)
      annotation (Placement(transformation(extent={{-10,40},{10,20}})));
    Modelica.Blocks.Interfaces.RealInput valveInput[CircuitNo] annotation (
        Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=-90,
          origin={-62,74})));

  protected
     parameter Medium.ThermodynamicState sta_default=Medium.setState_pTX(
        T=Medium.T_default,
        p=Medium.p_default,
        X=Medium.X_default);
    parameter Modelica.SIunits.SpecificHeatCapacity Cp_Medium=Medium.specificHeatCapacityCp(sta_default)
      "Specific Heat capacity of medium";

  initial equation
    assert(q_Gmax >= K_H*dT_Hi and q_G >= K_H*dT_Hi, "Panel Heating Parameters evaluate to a limiting heat flux that exceeds the maximum limiting heat flux in"
       + getInstanceName());

    if Q_out > 1 then
      Modelica.Utilities.Streams.print("In" + getInstanceName() + "additional heating equipment is required to cover heat load");
    end if;

    if Ceiling then
      assert(wallTypeFloor.n == 2 and wallTypeCeiling.n == 3, "EN 1264 calculates parameters only for panel heating type A (2 floor layers, 3 ceiling layers). Error accuring in"
         + getInstanceName());
    else
      assert(wallTypeFloor.n == 2 and wallTypeCeiling.n == 4, "EN 1264 calculates parameters only for panel heating type A (2 floor layers, 4 ground plate layers). Error accuring in"
         + getInstanceName());
    end if;

    if T_U >= 18 + 273.15 then
      assert(R_lambdaIns >= 0.75, "Thermal resistivity of insulation layer needs to be greater than 0.75 m²K / W (see EN 1264-4 table 1)");
    else
      assert(R_lambdaIns >= 1.25, "Thermal resistivity of insulation layer needs to be greater than 1.25 m²K / W (see EN 1264-4 table 1)");
    end if;
    assert(T_Return < T_Flow, "Return Temperature is higher than the Flow Temperature in" + getInstanceName());
  equation

    // FLUID CONNECTIONS

    for i in 1:CircuitNo loop
      connect(ports_a[i], underfloorHeatingCircuit[i].port_a)
        annotation (Line(points={{-100,0},{-22,0}}, color={0,127,255}));
      connect(underfloorHeatingCircuit[i].port_b, ports_b[i])
        annotation (Line(points={{22,0},{100,0}}, color={0,127,255}));

    end for;

    // HEAT CONNECTIONS

    for i in 1:CircuitNo loop
      for m in 1:dis loop
      connect(underfloorHeatingCircuit[i].heatCeiling[m], thermalCollectorCeiling[m].port_a[
        i]) annotation (Line(points={{0.44,-8.8},{0.44,-24},{0,-24},{0,-38}},
            color={191,0,0}));
      connect(thermalCollectorFloor[m].port_a[i], underfloorHeatingCircuit[i].heatFloor[m])
        annotation (Line(points={{0,20},{0,7.6}}, color={191,0,0}));
      end for;
    end for;
    for m in 1:dis loop
    connect(thermalCollectorCeiling[m].port_b, heatCeiling[m])
      annotation (Line(points={{0,-58},{0,-80}}, color={191,0,0}));
    connect(heatFloor[m], thermalCollectorFloor[m].port_b)
      annotation (Line(points={{0,60},{0,40}}, color={191,0,0}));
    end for;

    // VALVE CONNECTION
    for i in 1:CircuitNo loop
    connect(valveInput[i], underfloorHeatingCircuit[i].valveInput) annotation (Line(
          points={{-62,74},{-62,32},{-16.28,32},{-16.28,11.6}}, color={0,0,127}));
    end for;
    annotation (
      Dialog(group="Panel Heating", enable=withSheathing),
      choicesAllMatching=true,
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-80},{100,60}}),
          graphics={
          Rectangle(
            extent={{-100,-62},{100,-70}},
            lineColor={0,0,0},
            fillColor={215,215,215},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{-100,42},{100,-10}},
            lineColor={0,0,0},
            fillColor={215,215,215},
            fillPattern=FillPattern.Forward),
          Ellipse(
            extent={{-86,6},{-76,-4}},
            lineColor={175,175,175},
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-66,6},{-56,-4}},
            lineColor={175,175,175},
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-46,6},{-36,-4}},
            lineColor={175,175,175},
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-26,6},{-16,-4}},
            lineColor={175,175,175},
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-6,6},{4,-4}},
            lineColor={175,175,175},
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{14,6},{24,-4}},
            lineColor={175,175,175},
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{34,6},{44,-4}},
            lineColor={175,175,175},
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{54,6},{64,-4}},
            lineColor={175,175,175},
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{74,6},{84,-4}},
            lineColor={175,175,175},
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-100,50},{100,42}},
            lineColor={0,0,0},
            fillColor={215,215,215},
            fillPattern=FillPattern.CrossDiag),
          Rectangle(
            extent={{-100,-10},{100,-48}},
            lineColor={0,0,0},
            fillColor={175,175,175},
            fillPattern=FillPattern.Backward),
          Rectangle(
            extent={{-100,-48},{100,-62}},
            lineColor={0,0,0},
            fillColor={215,215,215},
            fillPattern=FillPattern.Forward),
          Text(
            extent={{-78,32},{-54,22}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Sphere,
            fillColor={175,175,175},
            textString="R_o"),
          Line(points={{-48,50},{-52,46},{-52,28},{-56,26},{-52,24},{-52,8},{-48,4}},
              color={0,0,0}),
          Text(
            extent={{-80,-34},{-56,-44}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Sphere,
            fillColor={175,175,175},
            textString="R_u"),
          Line(points={{-48,-2},{-52,-6},{-52,-38},{-56,-40},{-52,-42},{-52,-66},{
                -46,-70}}, color={0,0,0})}),Documentation(
     info="<html>
<p>
  <b><span style=\"color: #008000;\">Overview</span></b>
</p>
<p>
Model for heat transfer of an underfloor heating for one room
</p>
<p>
  <b><span style=\"color: #008000;\">Concept</span></b>
</p>
<p>This model calculates the number of heating circuits needed for the heating of one room by an underfloor heating.
</p>
<p> Every heating circuit has an equal percentage valve that has to be regulated from outside.
</p>
<p>For the determination of the nominal mass flow the regulations by prEN 1264 are implemented.
</p>
<b><span style=\"color: #008000;\">Layer Structure</span></b>
<p>For dimensioning it is important that the layer structure of the floor is set right! </p>
<p> The wall layers above the heating circuits have to be in the following order:</p>
<p>1. Cover/Screed </p>
<p>2. Floor </p>
<p> The wall layers below the heating circuits need to be in the record with the following order: </p>
<p>1. Isolation</p>
<p>2. Load-bearing substrate </p>
<p>3. Plaster </p>
<p> If there is a floor plate underneath the heating circuits, the wall record needs to consist of 4 layers, whereas the first layer needs to be the isolation!</p>
<b><span style=\"color: #008000;\">Isolation</span></b>
<p> The thermal resistance of the isolation needs to fulfill the following requirements:</p>
<p> Room underneath the underfloor heating is heated: R<sub>lambda,Ins</sub> <code> >= 0,75 W/m²K</code></p>
<p> Room underneath the underfloor heating is not heated / floor plate: R<sub>lambda,Ins</sub> <code> >= 1,25 W/m²K</code></p>
<b><span style=\"color: #008000;\">Water Volume</span></b>
</p>
<p>
The water volume in the pipe element can be calculated by the inner diameter of the pipe or by time constant and the mass flow. 
</p>
<p>
The maximum velocity in the pipe is set for 0.5 m/s. If the Water Volume is calculated by time constant,
a nominal inner diameter is calculated with the maximum velocity for easier parametrization.
</p>
</html>"),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-80},{100,
              60}})));
  end UnderfloorHeatingRoom;

  model UnderfloorHeatingCircuit "One Circuit in an Underfloor Heating System"
   extends AixLib.Fluid.Interfaces.PartialTwoPortInterface(allowFlowReversal=
          false, final m_flow_nominal = m_flow_Circuit);
    import Modelica.Constants.pi;
    extends AixLib.Fluid.Interfaces.LumpedVolumeDeclarations;

    parameter Integer dis(min=1) "Number of Discreatisation Layers";
    parameter Integer calculateVol annotation (Dialog(group="Panel Heating",
          descriptionLabel=true), choices(
        choice=1 "Calculate water volume with inner diameter",
        choice=2 "Calculate water volume with time constant",
        radioButtons=true));

    parameter Modelica.SIunits.Area A "Floor Area" annotation(Dialog(group = "Room Specifications"));
    parameter Modelica.SIunits.MassFlowRate m_flow_Circuit "nominal mass flow rate" annotation (Dialog(group = "Panel Heating"));
    final parameter Modelica.SIunits.VolumeFlowRate V_flow_nominal = m_flow_Circuit / rho_default "nominal volume flow rate";
    parameter Modelica.SIunits.PressureDifference dp_Pipe=100*PipeLength
      "Nominal pressure drop" annotation (Dialog(group="Pressure Drop"));
    parameter Modelica.SIunits.PressureDifference dp_Valve = 0 "Pressure Difference set in regulating valve for pressure equalization in heating system" annotation (Dialog(group="Pressure Drop"));
    parameter Modelica.SIunits.PressureDifference dpFixed_nominal = 0 "Nominal additional pressure drop e.g. for distributor" annotation (Dialog(group="Pressure Drop"));

    parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallTypeFloor
      "Wall type for floor"
      annotation (Dialog(group="Room Specifications"), choicesAllMatching=true);
    parameter Modelica.SIunits.Temperature T_Fmax = 29 + 273.15 "Maximum surface temperature" annotation (Dialog(group = "Room Specifications"));
    parameter Modelica.SIunits.Temperature T_Room = 20 + 273.15 "Nominal Room Temperature" annotation (Dialog(group = "Room Specifications"));
    parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallTypeCeiling
      "Wall type for ceiling"
      annotation (Dialog(group="Room Specifications"), choicesAllMatching=true);

    parameter Modelica.SIunits.Distance Spacing "Spacing between tubes" annotation (Dialog( group = "Panel Heating"));
    final parameter Modelica.SIunits.Length PipeLength = A / Spacing
      "Length of Panel Heating Pipe" annotation (Dialog(group="Panel Heating"));

    parameter
      UnderfloorHeating.BaseClasses.PipeMaterials.PipeMaterialDefinition PipeMaterial
      "Pipe Material"
      annotation (Dialog(group="Panel Heating"), choicesAllMatching=true);
    final parameter Modelica.SIunits.ThermalConductivity lambda_R = PipeMaterial.lambda "Thermal conductivity of pipe material";
    parameter Modelica.SIunits.Thickness PipeThickness "thickness of pipe wall" annotation (Dialog( group = "Panel Heating"));
    parameter Modelica.SIunits.Diameter d_a "outer diameter of pipe" annotation (Dialog( group = "Panel Heating"));
    final parameter Modelica.SIunits.Diameter d_i = d_a - 2*PipeThickness "inner diameter of pipe";

    parameter Boolean withSheathing = false "false if pipe has no Sheathing" annotation (Dialog(group = "Panel Heating"), choices(checkBox=true));
    parameter
      UnderfloorHeating.BaseClasses.Sheathing_Materials.SheathingMaterialDefinition
      SheathingMaterial=
        UnderfloorHeating.BaseClasses.Sheathing_Materials.PVCwithTrappedAir()
      "Sheathing Material" annotation (Dialog(group="Panel Heating", enable=
            withSheathing), choicesAllMatching=true);
    final parameter Modelica.SIunits.ThermalConductivity lambda_M = if withSheathing then SheathingMaterial.lambda else 0 "Thermal Conductivity for Sheathing";
    parameter Modelica.SIunits.Diameter d(min = d_a) = d_a  "Outer diameter of pipe including Sheathing" annotation (Dialog( group = "Panel Heating", enable = withSheathing));
    final parameter Modelica.SIunits.Diameter d_M = if withSheathing then d else 0;

    final parameter Integer n_pipe( min = 1) = if withSheathing then 2 else 1;
    final parameter Modelica.SIunits.Thickness d_pipe[n_pipe] = if withSheathing then {PipeThickness, (d - d_a)} else {PipeThickness} "Thickness of pipe layers";
    final parameter Modelica.SIunits.ThermalConductivity lambda_pipe[n_pipe] = if withSheathing then {lambda_R, lambda_M} else {lambda_R} "Thermal conductivity of pipe layer";

    parameter Integer use_vmax(min = 1, max = 2) "Output if v > v_max (0.5 m/s)" annotation(choices(choice = 1 "Warning", choice = 2 "Error"));

    parameter Modelica.SIunits.ThermalResistance R_x = 0 "additional thermal resistance";

  protected
    parameter Medium.ThermodynamicState sta_default=Medium.setState_pTX(
        T=Medium.T_default,
        p=Medium.p_default,
        X=Medium.X_default);
    parameter Modelica.SIunits.Density rho_default=Medium.density(sta_default)
      "Density, used to compute fluid volume";

  public
    AixLib.Fluid.Sensors.TemperatureTwoPort TFlow(
      redeclare package Medium = Medium,
      m_flow_nominal=m_flow_Circuit,
      allowFlowReversal=false)
      annotation (Placement(transformation(extent={{-48,-6},{-36,6}})));
    AixLib.Fluid.Sensors.TemperatureTwoPort TReturn(
      redeclare package Medium = Medium,
      m_flow_nominal=m_flow_Circuit,
      allowFlowReversal=false)
      annotation (Placement(transformation(extent={{60,-6},{72,6}})));

    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatFloor[dis]
      annotation (Placement(transformation(extent={{-10,34},{10,54}}),
          iconTransformation(extent={{-8,30},{8,46}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatCeiling[dis]
      annotation (Placement(transformation(extent={{-10,-56},{10,-36}}),
          iconTransformation(extent={{-6,-52},{10,-36}})));
    BaseClasses.SumT_F sumT_Fm(dis=integer(dis))
      annotation (Placement(transformation(extent={{16,10},{28,22}})));
    Modelica.Blocks.Interaction.Show.RealValue T_Fm "arithmetic mean of floor surface temperature"
      annotation (Placement(transformation(extent={{38,10},{48,22}})));
    UnderfloorHeatingElement underfloorHeatingElement[dis](
      each final energyDynamics=energyDynamics,
      each final massDynamics=massDynamics,
      each final p_start=p_start,
      each final T_start=T_start,
      each final X_start=X_start,
      each final C_start=C_start,
      each final C_nominal=C_nominal,
      each final mSenFac=mSenFac,
      each final energyDynamicsWalls=energyDynamics,
      each m_flow_Circuit=m_flow_Circuit,
      each final A=A/dis,
      redeclare each final package Medium = Medium,
      each final n_pipe=n_pipe,
      each final lambda_pipe=lambda_pipe,
      each final T0=T_Room,
      each final d_a=if withSheathing then {d_a,d} else {d_a},
      each final d_i=if withSheathing then {d_i,d_a} else {d_i},
      each calculateVol=calculateVol,
      each final dis=integer(dis),
      each final PipeLength=PipeLength/dis,
      each final wallTypeFloor=wallTypeFloor,
      each final wallTypeCeiling=wallTypeCeiling,
      each use_vmax=use_vmax,
      each R_x=R_x*dis)
      annotation (Placement(transformation(extent={{-10,-4},{10,4}})));

    AixLib.Fluid.Actuators.Valves.TwoWayEqualPercentage val(
      redeclare package Medium = Medium,
      allowFlowReversal=false,
      each m_flow_nominal=m_flow_Circuit,
      from_dp=false,
      dpValve_nominal=dp_Pipe + dp_Valve,
      dpFixed_nominal=dpFixed_nominal)
      annotation (Placement(transformation(extent={{-84,-10},{-64,10}})));
    Modelica.Blocks.Interfaces.RealInput valveInput annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          rotation=-90,
          origin={-74,58})));
  initial equation
  assert(dp_Pipe + dp_Valve <= 25000, "According to prEN1264 pressure drop in a heating circuit is supposed to be under 250 mbar. Error accuring in" + getInstanceName(), AssertionLevel.warning);

  equation
    assert(
        sumT_Fm.T_Fm <= T_Fmax,
        "Surface temperature in" + getInstanceName() + "too high",
        AssertionLevel.warning);
  //OUTER CONNECTIONS
   connect(port_a, val.port_a)
      annotation (Line(points={{-100,0},{-84,0}}, color={0,127,255}));
    connect(val.port_b, TFlow.port_a)
      annotation (Line(points={{-64,0},{-48,0}}, color={0,127,255}));
    connect(TFlow.port_b, underfloorHeatingElement[1].port_a)
      annotation (Line(points={{-36,0},{-10,0}}, color={0,127,255}));
    connect(underfloorHeatingElement[dis].port_b, TReturn.port_a)
      annotation (Line(points={{10,0},{60,0}}, color={0,127,255}));
       connect(TReturn.port_b, port_b)
      annotation (Line(points={{72,0},{100,0}}, color={0,127,255}));

  //INNER CONNECTIONS

    if dis > 1 then
      for i in 1:(dis-1) loop
        connect(underfloorHeatingElement[i].port_b, underfloorHeatingElement[i + 1].port_a)
          annotation (Line(
            points={{10,0},{10,-10},{-10,-10},{-10,0}},
            color={0,127,255},
            pattern=LinePattern.Dash));
      end for;
    end if;

  // HEAT CONNECTIONS

    for i in 1:dis loop
       connect(underfloorHeatingElement[i].heatFloor, heatFloor[i])
      annotation (Line(points={{0,4.2},{0,44}}, color={191,0,0}));
    connect(underfloorHeatingElement[i].heatCeiling, heatCeiling[i]) annotation (Line(
          points={{-0.2,-4.2},{-0.2,-46},{0,-46}}, color={191,0,0}));
      connect(sumT_Fm.port_a[i], underfloorHeatingElement[i].heatFloor)
        annotation (Line(points={{16,16},{0,16},{0,4.2}}, color={191,0,0}));
    end for;

    //OTHER CONNECTIONS
    connect(sumT_Fm.T_Fm, T_Fm.numberPort)
      annotation (Line(points={{28.12,16},{37.25,16}}, color={0,0,127}));
    connect(val.y, valveInput)
      annotation (Line(points={{-74,12},{-74,58}}, color={0,0,127}));
     annotation (Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-40},{100,40}},
          initialScale=0.1), graphics={
          Rectangle(
            extent={{-100,40},{100,14}},
            lineColor={200,200,200},
            fillColor={170,255,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-100,14},{100,-40}},
            lineColor={200,200,200},
            fillColor={150,150,150},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-80,10},{-80,2}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(points={{-80,10},{-78,6},{-80,10},{-82,6}}, color={238,46,47}),
          Ellipse(
            extent={{-84,-2},{-76,-10}},
            lineColor={200,200,200},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-68,-2},{-60,-10}},
            lineColor={200,200,200},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-52,-2},{-44,-10}},
            lineColor={200,200,200},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-36,-2},{-28,-10}},
            lineColor={200,200,200},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-20,-2},{-12,-10}},
            lineColor={200,200,200},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-4,-2},{4,-10}},
            lineColor={200,200,200},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{12,-2},{20,-10}},
            lineColor={200,200,200},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{28,-2},{36,-10}},
            lineColor={200,200,200},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{44,-2},{52,-10}},
            lineColor={200,200,200},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{60,-2},{68,-10}},
            lineColor={200,200,200},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{76,-2},{84,-10}},
            lineColor={200,200,200},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-64,10},{-64,2}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(
            points={{-48,10},{-48,2}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(
            points={{-32,10},{-32,2}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(
            points={{-16,10},{-16,2}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(
            points={{0,10},{0,2}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(
            points={{16,10},{16,2}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(
            points={{32,10},{32,2}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(
            points={{48,10},{48,2}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(
            points={{64,10},{64,2}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(
            points={{80,10},{80,2}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(points={{-64,10},{-62,6},{-64,10},{-66,6}}, color={238,46,47}),
          Line(points={{-48,10},{-46,6},{-48,10},{-50,6}}, color={238,46,47}),
          Line(points={{-32,10},{-30,6},{-32,10},{-34,6}}, color={238,46,47}),
          Line(points={{-16,10},{-14,6},{-16,10},{-18,6}}, color={238,46,47}),
          Line(points={{0,10},{2,6},{0,10},{-2,6}}, color={238,46,47}),
          Line(points={{16,10},{18,6},{16,10},{14,6}}, color={238,46,47}),
          Line(points={{32,10},{34,6},{32,10},{30,6}}, color={238,46,47}),
          Line(points={{48,10},{50,6},{48,10},{46,6}}, color={238,46,47}),
          Line(points={{64,10},{66,6},{64,10},{62,6}}, color={238,46,47}),
          Line(points={{80,10},{82,6},{80,10},{78,6}}, color={238,46,47})}),
                                                                   Diagram(
          coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-45},{100,45}},
          initialScale=0.1)),Documentation(
     info="<html>
<p>
  <b><span style=\"color: #008000;\">Overview</span></b>
</p>
<p>
Model for a heating circuit within wall layers
</p>
<p>
  <b><span style=\"color: #008000;\">Concept</span></b>
</p>
<p>
The heating circuits consists of <i>dis</i> pipe elements of the model <a href=\"UnderfloorHeating.UnderfloorHeatingElement\">
UnderfloorHeatingElement</a>
</p>
<p>The middle surface temperature is calculated and a maximum surface temperature is checked within the model.
</p>
<p>A two way equal percentage valve sets the pressure difference and mass flow.
</p>
<p>
<b><span style=\"color: #008000;\">Heat Transfer</span></b>
</p>
<p>
The heat transfer from the fluid to the surface of the wall elements is split into the following parts:
</p>
<p>
- convection from fluid to inner pipe
</p>
<p>
- heat conduction in pipe layers
</p>
<p>
- heat transfer from pipe outside to heat conductive floor layer
</p>
<p>
- heat conduction through upper wall layers
</p>
<p>
- heat conduction through lower wall layers
</p>
<p>
<b><span style=\"color: #008000;\">Thermal Resistance R_x</span></b>
<p>
The thermal resistance R_x represents the heat transfer from pipe outside to the middle temperaatur of the heat conductive layer.
It needs to be added according to the type of the heating systen (see EN 11855-2 p. 45).
</p>
<b><span style=\"color: #008000;\">Water Volume</span></b>
</p>
<p>
The water volume in the pipe element can be calculated by the inner diameter of the pipe or by time constant and the mass flow. 
</p>
<p>
The maximum velocity in the pipe is set for 0.5 m/s. If the Water Volume is calculated by time constant,
a nominal inner diameter is calculated with the maximum velocity for easier parametrization.
</p>
</html>"));
  end UnderfloorHeatingCircuit;

  model UnderfloorHeatingElement "Pipe Segment of Underfloor Heating System"

        extends AixLib.Fluid.Interfaces.PartialTwoPortInterface(allowFlowReversal=
          false, final m_flow_nominal = m_flow_Circuit);
        extends AixLib.Fluid.Interfaces.LumpedVolumeDeclarations;
        import Modelica.Constants.pi;
     parameter Modelica.Fluid.Types.Dynamics energyDynamicsWalls=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
      "Type of energy balance for wall capacities: dynamic (3 initialization options) or steady state"
      annotation(Evaluate=true, Dialog(tab="Dynamics"));

    parameter Integer n_pipe(min = 1) "Number of Pipe Layers" annotation (Dialog( group = "Panel Heating"));
    parameter Modelica.SIunits.Length PipeLength "Length of pipe" annotation (Dialog( group = "Panel Heating"));
    parameter Modelica.SIunits.Thickness d_a[n_pipe] "Outer Diameters of pipe layers" annotation(Dialog(group = "Panel Heating"));
    parameter Modelica.SIunits.Thickness d_i[n_pipe] "Inner Diameters of pipe layers" annotation(Dialog(group = "Panel Heating"));
    parameter Modelica.SIunits.ThermalConductivity lambda_pipe[n_pipe] "Thermal conductivity of pipe layers" annotation(Dialog(group = "Panel Heating"));

    parameter Integer dis(min = 1) "Parameter to enable dissertisation layers";

    parameter Integer calculateVol "Calculation method to determine Water Volume" annotation (Dialog(group="Calculation Method to determine Water Volume in Pipe",
          descriptionLabel=true), choices(
        choice=1 "Calculation with inner diameter",
        choice=2 "Calculation with time constant",
        radioButtons=true));
    final parameter Modelica.SIunits.Volume V_Water = if calculateVol == 1 then (pi / 4 * d_i[1]^(2) * PipeLength) else (vol.m_flow_nominal * tau / (rho_default * dis))  "Water Volume in Tube";
    final parameter Modelica.SIunits.Time tau = 250 "Time constant to heat up the medium";
    final parameter Modelica.SIunits.Time tau_nom = V_Water * (rho_default * dis) / m_flow_Circuit;

    parameter Modelica.SIunits.Area A "Floor Area" annotation(Dialog(group = "Room Specifications"));
    parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallTypeFloor
      "Wall type for floor"
      annotation (Dialog(group="Room Specifications"), choicesAllMatching=true);
    final parameter Integer n_floor(min = 1) = wallTypeFloor.n "Number of floor layers";

    parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallTypeCeiling
      "Wall type for ceiling"
      annotation (Dialog(group="Room Specifications", enable = Ceiling), choicesAllMatching=true);
    final parameter Integer n_ceiling(min = 1) = wallTypeCeiling.n "Number of ceiling layers";

    parameter Modelica.SIunits.Temperature T0(start = 273.15 + 20) "Start Temperature";

    parameter Modelica.SIunits.MassFlowRate m_flow_Circuit "Nominal Mass Flow Rate";
    final parameter Modelica.SIunits.VolumeFlowRate V_flow = m_flow_Circuit / rho_default "Nominal Volume Flow Rate in pipe";
    parameter Integer use_vmax(min = 1, max = 2) "Output if v > v_max (0.5 m/s)" annotation(choices(choice = 1 "Warning", choice = 2 "Error"));
    final parameter Modelica.SIunits.Velocity v = V_flow / (pi / 4 * d_i[1] ^ (2)) "velocity of medium in pipe";
    final parameter Modelica.SIunits.Diameter d_i_nom = sqrt(4 * V_flow / (pi * 0.5)) "Inner pipe diameter as a comparison for user parameter";

    final parameter Modelica.SIunits.Area A_sur = pi * d_i[1] * PipeLength "Surface area inside the pipe";
    final parameter Modelica.SIunits.CoefficientOfHeatTransfer h_turb = 2200 "Coefficient of heat transfer at the inner surface of pipe due to turbulent flow";

    parameter Modelica.SIunits.ThermalResistance R_x = 0 "Thermal Resistance between Screed and Pipe";

    AixLib.Fluid.MixingVolumes.MixingVolume vol(
      redeclare package Medium = Medium,
      energyDynamics=energyDynamics,
      massDynamics=massDynamics,
      p_start=p_start,
      T_start=T_start,
      X_start=X_start,
      C_start=C_start,
      C_nominal=C_nominal,
      mSenFac=mSenFac,
      allowFlowReversal=false,
      V=V_Water,
      nPorts=2,
      m_flow_nominal=m_flow_Circuit)
      annotation (Placement(transformation(extent={{54,0},{78,24}})));

    AixLib.ThermalZones.HighOrder.Components.Walls.BaseClasses.SimpleNLayer simpleNLayerFloor(
      final A=A,
      T_start=fill((T0), (n_floor)),
      wallRec=wallTypeFloor,
      energyDynamics=energyDynamicsWalls)
                             annotation (Placement(transformation(
          extent={{-7,-8},{7,8}},
          rotation=90,
          origin={0,27})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatFloor "upward heat flow to heated room" annotation (
        Placement(transformation(extent={{-8,34},{8,50}}), iconTransformation(
            extent={{-10,32},{10,52}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatCeiling "downward heat flow" annotation (
        Placement(transformation(extent={{-8,-48},{8,-32}}), iconTransformation(
            extent={{-12,-52},{8,-32}})));

    AixLib.Utilities.HeatTransfer.CylindricHeatConduction heatCondaPipe[n_pipe](
      d_out=d_a,
      lambda=lambda_pipe,
      d_in=d_i,
      each nParallel=1,
      each length=PipeLength) annotation (Placement(transformation(
          extent={{7,-7},{-7,7}},
          rotation=0,
          origin={23,9})));
    AixLib.Utilities.HeatTransfer.HeatConv           heatConvPipeInside(hCon=
          h_turb, A=A_sur)
      annotation (Placement(transformation(extent={{36,8},{44,16}})));
    Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor(R=R_x)
                 annotation (Placement(transformation(extent={{6,10},{14,18}})));
  protected
      parameter Medium.ThermodynamicState sta_default=Medium.setState_pTX(
        T=Medium.T_default,
        p=Medium.p_default,
        X=Medium.X_default);
    parameter Modelica.SIunits.Density rho_default=Medium.density(sta_default)
      "Density, used to compute fluid volume";
  initial equation
    if use_vmax == 1 then
    assert(v <= 0.5, "In" + getInstanceName() + "Medium velocity in pipe is "+String(v)+"and exceeds 0.5 m/s", AssertionLevel.warning);
    else
    assert(v <= 0.5, "In" + getInstanceName() + "Medium velocity in pipe is "+String(v)+"and exceeds 0.5 m/s",  AssertionLevel.error);
    end if;
    if calculateVol == 2 then
      if v > 0.5 then
    Modelica.Utilities.Streams.print("d_i_nom ="+String(d_i_nom)+".Use this parameter for useful parametrization of d_i for pipe to stay in velocity range.");
      end if;
    end if;
  equation

  public
    AixLib.ThermalZones.HighOrder.Components.Walls.BaseClasses.SimpleNLayer simpleNLayerCeiling(
      final A=A,
      T_start=fill((T0), (n_ceiling)),
      wallRec=wallTypeCeiling) annotation (Placement(transformation(
          extent={{7,-8},{-7,8}},
          rotation=90,
          origin={0,-13})));
  equation

    // FLUID CONNECTIONS

     connect(port_a, vol.ports[1])
      annotation (Line(points={{-100,0},{63.6,0}}, color={0,127,255}));
     connect(vol.ports[2], port_b)
      annotation (Line(points={{68.4,0},{100,0}}, color={0,127,255}));

    // HEAT CONNECTIONS

        for i in 1:(n_pipe-1) loop
      connect(heatCondaPipe[i].port_b, heatCondaPipe[i + 1].port_a) annotation (
          Line(
          points={{23,15.16},{23,14},{24,14},{24,12},{23,12},{23,9.28}},
          color={191,0,0},
          pattern=LinePattern.Dash));
        end for;

    connect(simpleNLayerFloor.port_b, heatFloor) annotation (Line(points={{1.33227e-15,
            34},{0,34},{0,42}}, color={191,0,0}));
    connect(simpleNLayerCeiling.port_b, heatCeiling) annotation (Line(points={{-1.33227e-15,
            -20},{0,-20},{0,-40}}, color={191,0,0}));

    connect(heatConvPipeInside.port_b, vol.heatPort)
      annotation (Line(points={{44,12},{54,12}}, color={191,0,0}));
    connect(heatConvPipeInside.port_a, heatCondaPipe[1].port_a) annotation (Line(
          points={{36,12},{34,12},{34,9.28},{23,9.28}},color={191,0,0}));
    connect(thermalResistor.port_b, heatCondaPipe[n_pipe].port_b) annotation (Line(
          points={{14,14},{18,14},{18,15.16},{23,15.16}}, color={191,0,0}));
    connect(thermalResistor.port_a, simpleNLayerFloor.port_a)
      annotation (Line(points={{6,14},{0,14},{0,20}}, color={191,0,0}));
    connect(thermalResistor.port_a, simpleNLayerCeiling.port_a)
      annotation (Line(points={{6,14},{0,14},{0,-6}}, color={191,0,0}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -40},{100,40}},
          initialScale=0.1),        graphics={
          Rectangle(
            extent={{-100,40},{100,18}},
            lineColor={135,135,135},
            fillColor={175,175,175},
            fillPattern=FillPattern.Forward),
          Rectangle(
            extent={{-100,18},{100,-18}},
            lineColor={135,135,135},
            fillColor={135,135,135},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-100,14},{100,-14}},
            lineColor={0,0,0},
            fillColor={28,108,200},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-100,-18},{100,-40}},
            lineColor={0,0,0},
            fillColor={135,135,135},
            fillPattern=FillPattern.Backward)}),  Documentation(
     info="<html>
<p>
  <b><span style=\"color: #008000;\">Overview</span></b>
</p>
<p>
Model for heat transfer of a pipe element within wall layers
</p>
<p>
  <b><span style=\"color: #008000;\">Concept</span></b>
</p>
<p>
The fluid in the pipe segment is represented by a mass flow and a volume element with heat transfer.
</p>
<p>
The heat transfer from the fluid to the surface of the wall elements is split into the following parts:
</p>
<p>
- convection from fluid to inner pipe
</p>
<p>
- heat conduction in pipe layers
</p>
<p>
- heat transfer from pipe outside to heat conductive floor layer
</p>
<p>
- heat conduction through upper wall layers
</p>
<p>
- heat conduction through lower wall layers
</p>
<p>
<b><span style=\"color: #008000;\">Thermal Resistance R_x</span></b>
<p>
The thermal resistance R_x represents the heat transfer from pipe outside to the middle temperaatur of the heat conductive layer.
It needs to be added according to the type of the heating systen (see EN 11855-2 p. 45).
</p>
<b><span style=\"color: #008000;\">Water Volume</span></b>
</p>
<p>
The water volume in the pipe element can be calculated by the inner diameter of the pipe or by time constant and the mass flow. 
</p>
<p>
The maximum velocity in the pipe is set for 0.5 m/s. If the Water Volume is calculated by time constant,
a nominal inner diameter is calculated with the maximum velocity for easier parametrization.
</p>
</html>"),                   Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-100,-40},{100,
              40}},
          initialScale=0.1)));
  end UnderfloorHeatingElement;

  package BaseClasses
    "Package for all models that are used in underfloor heating system"
    extends Modelica.Icons.Package;

     function logDT =
        AixLib.Fluid.HeatExchangers.ActiveWalls.BaseClasses.logDT;
     model SumT_F "Calculation of average floor surface temperature"
       parameter Integer dis(min=1);

       Modelica.Blocks.Math.MultiSum multiSum(nu=dis, k=fill(1, dis))
         annotation (Placement(transformation(extent={{-16,12},{-2,26}})));
       Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor T_F[dis]
         annotation (Placement(transformation(extent={{-68,10},{-48,30}})));
       Modelica.Blocks.Math.Division division
         annotation (Placement(transformation(extent={{46,-8},{62,8}})));
       Modelica.Blocks.Sources.Constant const(k=dis)
         annotation (Placement(transformation(extent={{-18,-34},{-2,-18}})));
       Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a[dis]
         annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
       Modelica.Blocks.Interfaces.RealOutput T_Fm
         annotation (Placement(transformation(extent={{92,-10},{112,10}})));
     equation
       connect(multiSum.y,division. u1)
         annotation (Line(points={{-0.81,19},{32,19},{32,4.8},{44.4,4.8}},
                                                       color={0,0,127}));
       connect(division.u2,const. y) annotation (Line(points={{44.4,-4.8},{32,
              -4.8},{32,-26},{-1.2,-26}},
                           color={0,0,127}));

       connect(division.y, T_Fm)
         annotation (Line(points={{62.8,0},{102,0}}, color={0,0,127}));
         for i in 1:dis loop
           connect(T_F[i].port, port_a[i]) annotation (Line(points={{-68,20},{-84,20},
                 {-84,0},{-100,0}},        color={191,0,0}));
           connect(T_F[i].T,multiSum. u[i])
         annotation (Line(points={{-48,20},{-16,20},{-16,19}},color={0,0,127}));
         end for;
      annotation (Icon(graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={28,108,200},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-62,36},{4,36},{-30,36},{-30,-36}}, color={28,108,200}),
            Line(points={{-6,-56},{-6,-20},{12,-20},{-6,-20},{-6,-38},{4,-38}},
                color={28,108,200}),
            Line(points={{14,-52},{14,-58}}, color={28,108,200}),
            Line(points={{24,-56},{24,-40},{38,-40},{38,-56},{38,-40},{52,-40},
                  {52,-56}}, color={28,108,200})}),
                      Documentation(info="<html>
<h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
Model for the calculation of the medium floor surface temperature using an underfloor heating circuit with <span style=
\"font-family: Courier New;\">dis</span> elements
</p>
</html>"));
     end SumT_F;

    model Distributor
      "Heating circuit distributor for underfloor heating systems"
      extends AixLib.Fluid.Interfaces.LumpedVolumeDeclarations;

      //General
      parameter Integer n(min=1) "Number of underfloor heating circuits / registers"
        annotation (Dialog(connectorSizing=true, group="General"));

      parameter Modelica.SIunits.MassFlowRate m_flow_nominal
        "Nominal mass flow rate" annotation (Dialog(group="General"));

      parameter Modelica.SIunits.Time tau=10
        "Time constant at nominal flow (if energyDynamics <> SteadyState)"
        annotation (Dialog(tab="Dynamics", group="Nominal condition"));

      // Assumptions
      parameter Boolean allowFlowReversal=true
        "= false to simplify equations, assuming, but not enforcing, no flow reversal"
        annotation (Dialog(tab="Assumptions"), Evaluate=true);

      Modelica.Fluid.Interfaces.FluidPort_a mainFlow(redeclare final package
          Medium = Medium)
        annotation (Placement(transformation(extent={{-70,-10},{-50,10}}),
            iconTransformation(extent={{-70,-10},{-50,10}})));

      Modelica.Fluid.Interfaces.FluidPort_b mainReturn(redeclare final package
          Medium = Medium) annotation (Placement(transformation(extent={{50,-10},
                {70,10}}),
                        iconTransformation(extent={{50,-10},{70,10}})));
      AixLib.Fluid.MixingVolumes.MixingVolume vol_flow(
        final m_flow_nominal=m_flow_nominal,
        final V=m_flow_nominal*tau/rho_default,
        redeclare final package Medium = Medium,
        final energyDynamics=energyDynamics,
        final massDynamics=massDynamics,
        final p_start=p_start,
        final T_start=T_start,
        final X_start=X_start,
        final C_start=C_start,
        final mSenFac=mSenFac,
        each final C_nominal=C_nominal,
        final allowFlowReversal=allowFlowReversal,
        nPorts=n+1)                                          annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={0,12})));
      AixLib.Fluid.MixingVolumes.MixingVolume vol_return(
        final m_flow_nominal=m_flow_nominal,
        final V=m_flow_nominal*tau/rho_default,
        redeclare final package Medium = Medium,
        final energyDynamics=energyDynamics,
        final massDynamics=massDynamics,
        final p_start=p_start,
        final T_start=T_start,
        final X_start=X_start,
        final C_start=C_start,
        final mSenFac=mSenFac,
        each final C_nominal=C_nominal,
        final allowFlowReversal=allowFlowReversal,
        nPorts=n+1)                                              annotation (Placement(
            transformation(extent={{-10,-20},{10,0}}, rotation=0)));
      Modelica.Fluid.Interfaces.FluidPorts_b flowPorts[n](redeclare each final
          package Medium = Medium) annotation (Placement(
          visible=true,
          transformation(
            origin={0,60},
            extent={{-10,-40},{10,40}},
            rotation=90),
          iconTransformation(
            origin={-8,60},
            extent={{-6,-24},{6,24}},
            rotation=90)));
      Modelica.Fluid.Interfaces.FluidPorts_a returnPorts[n](redeclare each
          final package Medium =
                           Medium) annotation (Placement(
          visible=true,
          transformation(
            origin={0,-60},
            extent={{-10,-40},{10,40}},
            rotation=90),
          iconTransformation(
            origin={8,-62},
            extent={{-6,-24},{6,24}},
            rotation=90)));

    protected
      parameter Medium.ThermodynamicState sta_default=Medium.setState_pTX(
          T=Medium.T_default,
          p=Medium.p_default,
          X=Medium.X_default);
      parameter Modelica.SIunits.Density rho_default=Medium.density(sta_default)
        "Density, used to compute fluid volume";
    equation

      for k in 1:n loop
        connect(vol_flow.ports[k + 1], flowPorts[k])
          annotation (Line(points={{0,22},{0,60}}, color={255,0,0}));
        connect(vol_return.ports[k + 1], returnPorts[k])
          annotation (Line(points={{0,-20},{0,-60}}, color={0,0,255}));
      end for;

      connect(mainFlow, vol_flow.ports[1]) annotation (Line(points={{-60,0},{-24,0},
              {-24,22},{1.77636e-15,22}}, color={0,127,255}));
      connect(vol_return.ports[1], mainReturn) annotation (Line(points={{0,-20},{30,
              -20},{30,0},{60,0},{60,0}}, color={0,127,255}));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-60,-60},{60,60}})),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-60,-60},{60,60}}),
            graphics={
            Rectangle(
              extent={{-60,60},{60,-60}},
              lineColor={28,108,200},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{50,0},{8,0},{8,-68}},
              color={0,0,255},
              thickness=1),
            Line(
              points={{-68,0},{-8,0},{-8,60}},
              color={238,46,47},
              thickness=1),
            Text(
              extent={{-78,18},{16,8}},
              lineColor={28,108,200},
              fillColor={255,255,255},
              fillPattern=FillPattern.None,
              textString="[n] flow"),
            Text(
              extent={{-18,-10},{78,-20}},
              lineColor={28,108,200},
              fillColor={255,255,255},
              fillPattern=FillPattern.None,
              textString="[n] return")}),
        Documentation(revisions="<html><ul>
  <li>
    <i>January 11, 2019&#160;</i> by Fabian Wüllhorst:<br/>
    Make model more dynamic (See <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/673\">#673</a>)
  </li>
  <li>
    <i>June 15, 2017&#160;</i> by Tobias Blacha:<br/>
    Moved into AixLib
  </li>
  <li>
    <i>November 06, 2014&#160;</i> by Ana Constantin:<br/>
    Added documentation.
  </li>
</ul>
</html>",     info="<html>
<h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  Model for a contributor for different floor heating circuits in a
  house.
</p>
<h4>
  <span style=\"color: #008000\">Concept</span>
</h4>
<p>
  The contributor is built to connect <span style=
  \"font-family: Courier New;\">n</span> floor heating circuits together.
  The volume is used for nummerical reasons, to have a point where all
  the flows mix together.
</p>
<h4>
  <span style=\"color: #008000\">Example Results</span>
</h4>
<p>
  <a href=
  \"AixLib.Fluid.HeatExchangers.Examples.ActiveWalls.ActiveWalls_Test\">AixLib.Fluid.HeatExchangers.Examples.ActiveWalls.ActiveWalls_Test</a>
</p>
</html>"));
    end Distributor;

    partial model PartialModularPort_ab
      "Base model for all modular models with multiple inlet and outlet ports"

      // Definition of the medium model
      //
      replaceable package Medium =
        Modelica.Media.Interfaces.PartialMedium "Medium in the component"
          annotation (choices(
            choice(redeclare package Medium = AixLib.Media.Air "Moist air"),
            choice(redeclare package Medium = AixLib.Media.Water "Water"),
            choice(redeclare package Medium =
                AixLib.Media.Antifreeze.PropyleneGlycolWater (
                  property_T=293.15,
                  X_a=0.40)
                  "Propylene glycol water, 40% mass fraction")));

      // Definition of parameters describing modular approach
      //
      parameter Integer nPorts = 1
        "Number of inlet and outlet ports"
        annotation(Dialog(group="Modular approach", enable = false));

      // Definition of parameters describing assumptions
      //
      parameter Boolean allowFlowReversal = true
        "= false to simplify equations, assuming, but not enforcing, no flow reversal"
        annotation(Dialog(tab="Assumptions",group="General"), Evaluate=true);

      // Definition of parameters describing initialisation and numeric limits
      //
      parameter Medium.MassFlowRate m_flow_nominal = 0.1
        "Nominal mass flow rate"
        annotation(Dialog(tab = "Advanced",group="Numeric limitations"));
      parameter Medium.MassFlowRate m_flow_small = 1e-6*m_flow_nominal
        "Small mass flow rate for regularization of zero flow"
        annotation(Dialog(tab = "Advanced",group="Numeric limitations"));

      // Definition of connectors
      //
      Modelica.Fluid.Interfaces.FluidPorts_a ports_a[nPorts](
        redeclare final package Medium = Medium,
         m_flow(each min=if allowFlowReversal then -Modelica.Constants.inf else 0),
         h_outflow(each start = Medium.h_default), p(each start=Medium.p_default))
        "Fluid connectors a (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{-110,-40},{-90,40}})));
      Modelica.Fluid.Interfaces.FluidPorts_b ports_b[nPorts](
        redeclare each final package Medium = Medium,
        m_flow(each max=if allowFlowReversal then +Modelica.Constants.inf else 0),
        h_outflow(each start = Medium.h_default), p(each start=Medium.p_default))
        "Fluid connectors b (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{90,40},{110,-40}})));

      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
              extent={{-100,140},{100,100}},
              lineColor={28,108,200},
              textString="%name")}),                                 Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        Documentation(revisions="<html>
<ul>
  <li>
  October 16, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/457\">issue 457</a>).
  </li>
</ul>
</html>",     info="<html>
<p>
This component transports fluid between its multiple inlet and outlet
ports, without storing mass or energy. Energy may be exchanged with the 
environment though, for example, in the form of work. 
<code>PartialModularPort_a</code> is intended as base class for devices like 
modular sensors that are used, for example, in modular heat pumps.
</p>
<p>
Three equations need to be added by an extending class using this component:
</p>
<ul>
<li>The momentum balance specifying the relationship between the pressure drops 
<code>dp_i</code> and the mass flow rates <code>m_flow_i</code> if these 
variables are introduced by the modeller</li>
<li><code>port_b.h_outflow_i</code> for flow in design direction.</li>
<li><code>port_a.h_outflow_i</code> for flow in reverse direction.</li>
</ul>
<p>
Moreover, appropriate values shall be assigned to the following parameters:
</p>
<ul>
<li><code>dp_start</code> for a guess of the pressure drop</li>
<li><code>m_flow_small</code> for regularization of zero flow.</li>
<li><code>dp_nominal</code> for nominal pressure drop.</li>
<li><code>m_flow_nominal</code> for nominal mass flow rate.</li>
</ul>
</html>"));
    end PartialModularPort_ab;

    package PipeMaterials
      "Determining the thermal conductivity for the used pipe material according to table A.13 p.38 DIN 1264-2"
      record PipeMaterialDefinition "Record for definition of pipe material"
        extends Modelica.Icons.Record;

       parameter Modelica.SIunits.ThermalConductivity lambda;

        annotation (Icon(coordinateSystem(preserveAspectRatio=false)),Documentation(info="<html>
<h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
Record with definition for a pipe material
</p>
</html>"),       Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end PipeMaterialDefinition;

      record PBpipe "Pipe Material PB"
        extends Modelica.Icons.Record;
        extends PipeMaterialDefinition(
          lambda=0.22);

        annotation (Icon(coordinateSystem(preserveAspectRatio=false)),Documentation(info="<html>
<h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
Record for pipe material polybutene
</p>
</html>"),       Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end PBpipe;

      record PPpipe "Pipe Material PP"
        extends Modelica.Icons.Record;
        extends PipeMaterialDefinition(
          lambda=0.22);

        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Documentation(info="<html>
<h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
Record for pipe material polypropylene
</p>
</html>"),      Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end PPpipe;

      record PEXpipe "Pipe Material PE-X"
        extends Modelica.Icons.Record;
        extends PipeMaterialDefinition(
          lambda=0.35);

        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Documentation(info="<html>
<h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
Record for pipe material of cross-linked polyethylene 
</p>
</html>"),      Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end PEXpipe;

      record PERTpipe "Pipe-Material PE-RT"
        extends Modelica.Icons.Record;
        extends PipeMaterialDefinition(
          lambda=0.35);

        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Documentation(info="<html>
<h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
Record for pipe material polyethylene of increased temperature resistance
</p>
</html>"),      Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end PERTpipe;

      record Steel "Pipe Material Steel"
        extends Modelica.Icons.Record;
        extends PipeMaterialDefinition(
          lambda=52);

        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Documentation(info="<html>
<h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
Record for pipe material steel
</p>
</html>"),      Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end Steel;

      record Copper "Pipe Material Copper"
        extends Modelica.Icons.Record;
        extends PipeMaterialDefinition(
          lambda=390);

        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Documentation(info="<html>
<h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
Record for pipe material copper
</p>
</html>"),      Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end Copper;
    end PipeMaterials;

    package Sheathing_Materials
      "Determining the thermal conductivity for the used material for the insulating according to table A.13 p.38 DIN 1264-2"
      record SheathingMaterialDefinition "Record for definition of sheathing material"
        extends Modelica.Icons.Record;

       parameter Modelica.SIunits.ThermalConductivity lambda;

        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Documentation(info="<html>
<h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
Record with definition for a sheathing material
</p>
</html>"),      Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end SheathingMaterialDefinition;

      record PVCwithTrappedAir "PVC with trapped air according to EN 1264"
        extends Modelica.Icons.Record;
        extends SheathingMaterialDefinition(  lambda=0.15);

        annotation (Icon(coordinateSystem(preserveAspectRatio=false)),Documentation(info="<html>
<h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
Record for sheathing material polyvinyl chloride with trapped air
</p>
</html>"),       Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end PVCwithTrappedAir;

      record PVCwithoutAir "PVC according to EN 1264"
        extends Modelica.Icons.Record;
        extends SheathingMaterialDefinition(  lambda=0.2);

        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Documentation(info="<html>
<h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
Record for sheathing material polyvinyl chloride (without air)
</p>
</html>"),       Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end PVCwithoutAir;

    end Sheathing_Materials;

    package EN1264
      "Calculation of parameters for dimensioning the underfloor heating for types A and C according to EN 1264"
      package TablesAndParameters
        "Package includes tables and parameters for underfloor heating Type A (EN 1264)"
        extends Modelica.Icons.UtilitiesPackage;
        model K_H_TypeA
         "Merge of all functions to calculate K_H for underfloor heating type A (EN 1264)"

         parameter Modelica.SIunits.Distance T "Spacing between tubes";
         parameter Modelica.SIunits.Diameter d_a "outer diameter of pipe";
         parameter Modelica.SIunits.ThermalConductivity lambda_R "Coefficient of heat transfer of pipe material";
         constant Modelica.SIunits.ThermalConductivity lambda_R0 = 0.35;
         parameter Modelica.SIunits.Thickness s_R "thickness of pipe wall";
         constant Modelica.SIunits.Thickness s_R0 = 0.002;

         parameter Boolean withSheathing = true "false if pipe has no Sheathing" annotation (choices(checkBox=true));
         parameter Modelica.SIunits.Diameter D = d_a  "Outer diameter of pipe including Sheathing" annotation (Dialog(enable = withSheathing));
         final parameter Modelica.SIunits.Diameter d_M = if withSheathing then D else 0;
         parameter Modelica.SIunits.ThermalConductivity lambda_M = 0  "Thermal Conductivity for Sheathing" annotation (Dialog(enable = withSheathing));

         parameter Modelica.SIunits.Thickness s_u "thickness of floor screed";
         parameter Modelica.SIunits.ThermalConductivity lambda_E "Thermal conductivity of floor screed";
         parameter Modelica.SIunits.ThermalInsulance R_lambdaB0 "Thermal resistance of flooring";
         final parameter Modelica.SIunits.ThermalInsulance R_lambdaB = if R_lambdaB0 < 0.1 then 0.1 else R_lambdaB0 "Thermal resistance of flooring used for dimensioning";

         final parameter Modelica.SIunits.CoefficientOfHeatTransfer B =  if withSheathing == false then
         if lambda_R == 0.35 and s_R == 0.002 then
           6.7
         else
           if T <= 0.375 then
           (1 / B_0 + 1.1 / Modelica.Constants.pi * product_ai * T * ( 1 / (2 * lambda_R) * log(d_a / (d_a - 2 * s_R)) - 1 / (2 * lambda_R0) * log(d_a / (d_a - 2 * s_R0))))^(-1)
           else
            (1 / B_0 + 1.1 / Modelica.Constants.pi * product_ai * 0.375 * ( 1 / (2 * lambda_R) * log(d_a / (d_a - 2 * s_R)) - 1 / (2 * lambda_R0) * log(d_a / (d_a - 2 * s_R0))))^(-1)
           else
             if T <= 0.375 then
           (1 / B_0 + 1.1 / Modelica.Constants.pi * product_ai * T * ( 1 / (2 * lambda_M) * log(d_M / d_a) + 1 / (2 * lambda_R) * log(d_a / (d_a - 2 * s_R)) - 1 / (2 * lambda_R0) * log(d_M / (d_M - 2 * s_R0))))^(-1)
             else
               (1 / B_0 + 1.1 / Modelica.Constants.pi * product_ai * T * ( 1 / (2 * lambda_M) * log(d_M / d_a) + 1 / (2 * lambda_R) * log(d_a / (d_a - 2 * s_R)) - 1 / (2 * lambda_R0) * log(d_M / (d_M - 2 * s_R0))))^(-1)
         "system dependent coefficient" annotation (Dialog(enable = false));
         constant Modelica.SIunits.CoefficientOfHeatTransfer B_0 = 6.7 "system dependent coefficient for lambda_R0 = 0.35 W/(m.K) abd s_R0 = 0.002 m";

         final parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_Floor = 10.8 "Coefficient of heat transfer at floor surface";
         constant Modelica.SIunits.ThermalConductivity lambda_u0 = 1;
         constant Modelica.SIunits.Diameter s_u0 = 0.045;
         final parameter Real a_B = (1 / alpha_Floor + s_u0 / lambda_u0) / (1 / alpha_Floor + s_u0 / lambda_E + R_lambdaB);
         final parameter Real a_T = determine_aT.y;
         final parameter Real a_u = determine_au.y;
         final parameter Real a_D = determine_aD.y;

         final parameter Real m_T = if T <= 0.375 then 1 - T / 0.075 else 1 - 0.375 / 0.075;
         final parameter Real m_u = 100 * (0.045 - s_u);
         final parameter Real m_D = 250 * (D - 0.02);

         final parameter Real product_ai = a_B * a_T^(m_T) * a_u^(m_u) * a_D^(m_D) "product of powers for parameters of floor heating";

         final parameter Modelica.SIunits.CoefficientOfHeatTransfer K_H = if s_u > s_uStar and s_u > 0.065 then
         1 / ( (1 / K_HStar) + ((s_u - s_uStar) / lambda_E))
         else
         if T > 0.375 then
         B * product_ai * 0.375 / T
         else
         B * product_ai;

        protected
         final parameter Modelica.SIunits.Thickness s_uStar = if T > 0.2 then (0.5 * T) else 0.1;
         final parameter Modelica.SIunits.CoefficientOfHeatTransfer K_HStar = B * a_B * a_T^(m_T) * a_u^(100*(0.045-s_uStar)) * a_D^(m_D);

         import Modelica.Math.log;

          Tables.CombiTable2DParameter determine_au(
            table=[0.0,0,0.05,0.1,0.15; 0.05,1.069,1.056,1.043,1.037; 0.075,1.066,1.053,1.041,1.035; 0.1,1.063,1.05,1.039,1.0335;
                0.15,1.057,1.046,1.035,1.0305; 0.2,1.051,1.041,1.0315,1.0275; 0.225,1.048,1.038,1.0295,1.026; 0.3,1.0395,1.031,
                1.024,1.021; 0.375,1.03,1.0221,1.0181,1.015],
            u2=R_lambdaB,
            u1=if T <= 0.375 then T else 0.375)
                          "Table A.2 according to EN 1264-2 p. 29"
            annotation (Placement(transformation(extent={{-96,20},{-70,46}})));
          Tables.CombiTable2DParameter determine_aD(
            table=[0.0,0,0.05,0.1,0.15; 0.05,1.013,1.013,1.012,1.011; 0.075,1.021,1.019,1.016,1.014; 0.1,1.029,1.025,1.022,1.018;
                0.15,1.04,1.034,1.029,1.024; 0.2,1.046,1.04,1.035,1.03; 0.225,1.049,1.043,1.038,1.033; 0.3,1.053,1.049,1.044,1.039;
                0.375,1.056,1.051,1.046,1.042],
            u2=R_lambdaB,
            u1=if T <= 0.375 then T else 0.375)
                          "Table A.3 according to EN 1264-2 p. 30"
            annotation (Placement(transformation(extent={{-96,-20},{-70,6}})));
          Tables.CombiTable1DParameter determine_aT(table=[0,1.23; 0.05,1.188; 0.10,1.156; 0.15,1.134], u=R_lambdaB)
            "Table A.1 according to EN 1264-2 p. 29" annotation (Placement(transformation(extent={{-96,60},{-72,84}})));

        initial equation
           assert(D >= 0.008 and D <= 0.03, "For dimensioning the outer diameter including Sheathing needs to be between 8 mm and 30 mm", AssertionLevel.warning);
           assert(s_u > 0.01, "For dimensioning the floor screed needs to be thicker than 10 mm", AssertionLevel.warning);

           annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
               coordinateSystem(preserveAspectRatio=false)));
        end K_H_TypeA;

        model qG_TypeA
          "Calculating the limiting heat flux for underfloor heating Types A and C according to EN 1264"
          import Modelica.Constants.e;

          extends
            UnderfloorHeating.BaseClasses.EN1264.TablesAndParameters.K_H_TypeA;

          parameter Modelica.SIunits.Temperature T_Fmax "maximum surface temperature";
          parameter Modelica.SIunits.Temperature T_Room "Room temperature";

          final parameter Real f_G = if s_u/T <= 0.173 then 1 else (q_Gmax - (q_Gmax - phi * B_G * (dT_HG375 / phi) ^(n_G) * 0.375 / T) * e^(-20 * (s_u / T - 0.173)^2)) / (phi * B_G * (dT_HG375 / phi) ^(n_G) * 0.375 / T);
          final parameter Real phi = ((T_Fmax - T_Room) / d_T0)^(1.1);
          final parameter Modelica.SIunits.TemperatureDifference d_T0 = 9;
          final parameter Real B_G = if s_u / lambda_E <= 0.0792 then
            tableA4.y
         else
             tableA5.y;
          final parameter Real n_G = if s_u / lambda_E <= 0.0792 then
            tableA6.y
          else
            tableA7.y;

          final parameter Modelica.SIunits.HeatFlux q_G = if T <= 0.375 then phi * B_G * (dT_HG /phi)^(n_G)
            else
          phi * B_G * (dT_HG / phi) ^(n_G) * 0.375 / T * f_G "limiting heat flux";

          parameter Modelica.SIunits.HeatFlux q_Gmax "maximum possible heat flux";

          final parameter Modelica.SIunits.TemperatureDifference dT_HG375 = phi *  (B_G / (B * product_ai))^(1/(1-n_G)) "maximum temperature difference at Spacing = 0.375 m";
          final parameter Modelica.SIunits.TemperatureDifference dT_HG = if T <= 0.375 then phi *  (B_G / (B * product_ai))^(1/(1-n_G)) else phi * ( B_G / (B * product_ai))^(1/(1-n_G)) * f_G "maximum temperature difference between heating medium and room";
          parameter Modelica.SIunits.TemperatureDifference dT_H "logarithmic temperature difference between heating medium and room";

          Tables.CombiTable2DParameter tableA4(
            table=[0.0,0.01,0.0208,0.0292,0.0375,0.0458,0.0542,0.0625,0.0708,0.0792; 0.05,
                85,91.5,96.8,100,100,100,100,100,100; 0.075,75.3,83.5,89.9,96.3,99.5,100,
                100,100,100; 0.1,66,75.4,82.9,89.3,95.5,98.8,100,100,100; 0.15,51,61.1,69.2,
                76.3,82.7,87.5,91.8,95.1,97.8; 0.2,38.5,48.2,56.2,63.1,69.1,74.5,81.3,86.4,
                90; 0.225,33,42.5,49.5,56.5,62,67.5,75.3,81.6,86.1; 0.3,20.5,26.8,31.6,36.4,
                41.5,47.5,57.5,65.3,72.4; 0.375,11.5,13.7,15.5,18.2,21.5,27.5,40,49.1,58.3],
            u2=s_u/lambda_E,
            u1=if T <= 0.375 then T else 0.375)
            "Table A.4 according to prEN 1264-2 p. 29"
            annotation (Placement(transformation(extent={{-96,-60},{-70,-34}})));

          Tables.CombiTable1DParameter tableA5(table=[0.173,27.5; 0.20,40; 0.25,57.5; 0.30,
                69.5; 0.35,78.2; 0.40,84.4; 0.45,88.3; 0.50,91.6; 0.55,94; 0.60,96.3; 0.65,
                98.6; 0.70,99.8; 0.75,100], u=if T <= 0.375 then s_u/T else s_u/0.375)
            "Table A.5 according to prEN 1264-2 p. 29"
            annotation (Placement(transformation(extent={{-54,-60},{-28,-34}})));

          Tables.CombiTable2DParameter tableA6(
            table=[0.0,0.01,0.0208,0.0292,0.0375,0.0458,0.0542,0.0625,0.0708,0.0792; 0.05,
                0.008,0.005,0.002,0,0,0,0,0,0; 0.075,0.024,0.021,0.018,0.011,0.002,0,0,0,
                0; 0.1,0.046,0.043,0.041,0.033,0.014,0.005,0,0,0; 0.15,0.088,0.085,0.082,
                0.076,0.055,0.038,0.024,0.014,0.006; 0.2,0.131,0.13,0.129,0.123,0.105,0.083,
                0.057,0.04,0.028; 0.225,0.155,0.154,0.153,0.146,0.13,0.11,0.077,0.056,0.041;
                0.2625,0.197,0.196,0.196,0.19,0.173,0.15,0.11,0.083,0.062; 0.3,0.254,0.253,
                0.253,0.245,0.228,0.195,0.145,0.114,0.086; 0.3375,0.322,0.321,0.321,0.31,
                0.293,0.26,0.187,0.148,0.115; 0.375,0.422,0.421,0.421,0.405,0.385,0.325,
                0.23,0.183,0.142],
            u2=s_u/lambda_E,
            u1=if T <= 0.375 then T else 0.375)
            "Table A.6 according to prEN 1264-2 p. 30"
            annotation (Placement(transformation(extent={{-96,-96},{-70,-70}})));
          Tables.CombiTable1DParameter tableA7(table=[0.173,0.32; 0.2,0.23; 0.25,0.145;
                0.3,0.097; 0.35,0.067; 0.4,0.048; 0.45,0.033; 0.5,0.023; 0.55,0.015; 0.6,
                0.009; 0.65,0.005; 0.7,0.002; 0.75,0], u=if T <= 0.375 then s_u/T else
                s_u/0.375) "Table A.7 according to prEN 1264-2 p. 30"
            annotation (Placement(transformation(extent={{-54,-96},{-28,-70}})));

        initial equation
          assert(dT_H <= dT_HG, "Temperature difference between medium and room seems to be higher than the maximum temperature difference (see EN 1264)");

          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end qG_TypeA;

        package Tables "Basic tables for the calculation of parameters"
          block CombiTable1DParameter
            "Table look-up in one dimension with one inputs and one output as parameters"

          function getTableValue "Interpolate 1-dim. table defined by matrix"
            extends Modelica.Icons.Function;
            input Modelica.Blocks.Types.ExternalCombiTable1D tableID;
            input Integer icol;
            input Real u;
            input Real tableAvailable
              "Dummy input to ensure correct sorting of function calls";
            output Real y;
            external"C" y = ModelicaStandardTables_CombiTable1D_getValue(tableID, icol, u)
              annotation (Library={"ModelicaStandardTables", "ModelicaMatIO", "zlib"});
            annotation (derivative(noDerivative=tableAvailable) = getDerTableValue);
          end getTableValue;

          function getDerTableValue
            "Derivative of interpolated 1-dim. table defined by matrix"
            extends Modelica.Icons.Function;
            input Modelica.Blocks.Types.ExternalCombiTable1D tableID;
            input Integer icol;
            input Real u;
            input Real tableAvailable
              "Dummy input to ensure correct sorting of function calls";
            input Real der_u;
            output Real der_y;
            external"C" der_y = ModelicaStandardTables_CombiTable1D_getDerValue(tableID, icol, u, der_u)
              annotation (Library={"ModelicaStandardTables", "ModelicaMatIO", "zlib"});
          end getDerTableValue;

            parameter Real table[:, :]
              "Table matrix (grid = first column; e.g., table=[0,2])"
              annotation (Dialog(group="Table data definition",enable=not tableOnFile));
            final parameter Integer columns[:]=2:size(table, 2)
              "Columns of table to be interpolated"
              annotation (Dialog(group="Table data interpretation"));

            final parameter Modelica.Blocks.Types.ExternalCombiTable1D tableID=
                Modelica.Blocks.Types.ExternalCombiTable1D(
                  "NoName",
                  "NoName",
                  table,
                  columns,
                  Modelica.Blocks.Types.Smoothness.LinearSegments) "External table object";

            final parameter Integer n= 1;
            parameter Real u;
            final parameter Real y = getTableValue(tableID, n, u, 1.0);

          equation

            annotation ( Icon(
              coordinateSystem(preserveAspectRatio=true,
                extent={{-100.0,-100.0},{100.0,100.0}}),
                graphics={                Rectangle(
                  extent={{-100,-100},{100,100}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
              Line(points={{-60.0,40.0},{-60.0,-40.0},{60.0,-40.0},{60.0,40.0},{30.0,40.0},{30.0,-40.0},{-30.0,-40.0},{-30.0,40.0},{-60.0,40.0},{-60.0,20.0},{60.0,20.0},{60.0,0.0},{-60.0,0.0},{-60.0,-20.0},{60.0,-20.0},{60.0,-40.0},{-60.0,-40.0},{-60.0,40.0},{60.0,40.0},{60.0,-40.0}}),
              Line(points={{0.0,40.0},{0.0,-40.0}}),
              Rectangle(fillColor={255,215,136},
                fillPattern=FillPattern.Solid,
                extent={{-60.0,20.0},{-30.0,40.0}}),
              Rectangle(fillColor={255,215,136},
                fillPattern=FillPattern.Solid,
                extent={{-60.0,0.0},{-30.0,20.0}}),
              Rectangle(fillColor={255,215,136},
                fillPattern=FillPattern.Solid,
                extent={{-60.0,-20.0},{-30.0,0.0}}),
              Rectangle(fillColor={255,215,136},
                fillPattern=FillPattern.Solid,
                extent={{-60.0,-40.0},{-30.0,-20.0}}),
                                                  Text(
                  extent={{-150,150},{150,110}},
                  textString="%name",
                  lineColor={0,0,255})}),
              Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                      100,100}}), graphics={
                  Rectangle(
                    extent={{-60,60},{60,-60}},
                    fillColor={235,235,235},
                    fillPattern=FillPattern.Solid,
                    lineColor={0,0,255}),
                  Text(
                    extent={{-100,100},{100,64}},
                    textString="1 dimensional linear table interpolation",
                    lineColor={0,0,255}),
                  Line(points={{-54,40},{-54,-40},{54,-40},{54,40},{28,40},{28,-40},{-28,
                        -40},{-28,40},{-54,40},{-54,20},{54,20},{54,0},{-54,0},{-54,-20},
                        {54,-20},{54,-40},{-54,-40},{-54,40},{54,40},{54,-40}}, color={
                        0,0,0}),
                  Line(points={{0,40},{0,-40}}),
                  Rectangle(
                    extent={{-54,40},{-28,20}},
                    lineColor={0,0,0},
                    fillColor={255,255,0},
                    fillPattern=FillPattern.Solid),
                  Rectangle(
                    extent={{-54,20},{-28,0}},
                    lineColor={0,0,0},
                    fillColor={255,255,0},
                    fillPattern=FillPattern.Solid),
                  Rectangle(
                    extent={{-54,0},{-28,-20}},
                    lineColor={0,0,0},
                    fillColor={255,255,0},
                    fillPattern=FillPattern.Solid),
                  Rectangle(
                    extent={{-54,-20},{-28,-40}},
                    lineColor={0,0,0},
                    fillColor={255,255,0},
                    fillPattern=FillPattern.Solid),
                  Text(
                    extent={{-50,54},{-32,42}},
                    textString="u[1]/[2]",
                    lineColor={0,0,255}),
                  Text(
                    extent={{-24,54},{0,42}},
                    textString="y[1]",
                    lineColor={0,0,255}),
                  Text(
                    extent={{-2,-40},{30,-54}},
                    textString="columns",
                    lineColor={0,0,255}),
                  Text(
                    extent={{2,54},{26,42}},
                    textString="y[2]",
                    lineColor={0,0,255})}));
          end CombiTable1DParameter;

          block CombiTable2DParameter
            "Table look-up in two dimensions with two inputs and one output as parameters"

          function getTableValue "Interpolate 2-dim. table defined by matrix"
              extends Modelica.Icons.Function;
              input Modelica.Blocks.Types.ExternalCombiTable2D tableID;
              input Real u1;
              input Real u2;
              input Real tableAvailable
                "Dummy input to ensure correct sorting of function calls";
              output Real y;
              external"C" y = ModelicaStandardTables_CombiTable2D_getValue(tableID, u1, u2)
                annotation (Library={"ModelicaStandardTables", "ModelicaMatIO", "zlib"});
              annotation (derivative(noDerivative=tableAvailable) = getDerTableValue);
          end getTableValue;

          function getDerTableValue
              "Derivative of interpolated 2-dim. table defined by matrix"
              extends Modelica.Icons.Function;
              input Modelica.Blocks.Types.ExternalCombiTable2D tableID;
              input Real u1;
              input Real u2;
              input Real tableAvailable
                "Dummy input to ensure correct sorting of function calls";
              input Real der_u1;
              input Real der_u2;
              output Real der_y;
              external"C" der_y = ModelicaStandardTables_CombiTable2D_getDerValue(tableID, u1, u2, der_u1, der_u2)
                annotation (Library={"ModelicaStandardTables", "ModelicaMatIO", "zlib"});
          end getDerTableValue;

            parameter Real table[:, :]
               "Table matrix (grid u1 = first column, grid u2 = first row; e.g., table=[0,0;0,1])"
              annotation (Dialog(group="Table data definition"));

            final parameter Modelica.Blocks.Types.ExternalCombiTable2D tableID=
                Modelica.Blocks.Types.ExternalCombiTable2D(
                  "NoName",
                  "NoName",
                  table,
                  Modelica.Blocks.Types.Smoothness.LinearSegments) "External table object";

            parameter Real u1;
            parameter Real u2;
            final parameter Real y = getTableValue(tableID, u1, u2, 1.0);

          equation

            annotation (Icon(
              coordinateSystem(preserveAspectRatio=true,
                extent={{-100.0,-100.0},{100.0,100.0}}),
                graphics={                Rectangle(
                  extent={{-100,-100},{100,100}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
              Line(points={{-60.0,40.0},{-60.0,-40.0},{60.0,-40.0},{60.0,40.0},{30.0,40.0},{30.0,-40.0},{-30.0,-40.0},{-30.0,40.0},{-60.0,40.0},{-60.0,20.0},{60.0,20.0},{60.0,0.0},{-60.0,0.0},{-60.0,-20.0},{60.0,-20.0},{60.0,-40.0},{-60.0,-40.0},{-60.0,40.0},{60.0,40.0},{60.0,-40.0}}),
              Line(points={{0.0,40.0},{0.0,-40.0}}),
              Line(points={{-60.0,40.0},{-30.0,20.0}}),
              Line(points={{-30.0,40.0},{-60.0,20.0}}),
              Rectangle(origin={2.3077,-0.0},
                fillColor={255,215,136},
                fillPattern=FillPattern.Solid,
                extent={{-62.3077,0.0},{-32.3077,20.0}}),
              Rectangle(origin={2.3077,-0.0},
                fillColor={255,215,136},
                fillPattern=FillPattern.Solid,
                extent={{-62.3077,-20.0},{-32.3077,0.0}}),
              Rectangle(origin={2.3077,-0.0},
                fillColor={255,215,136},
                fillPattern=FillPattern.Solid,
                extent={{-62.3077,-40.0},{-32.3077,-20.0}}),
              Rectangle(fillColor={255,215,136},
                fillPattern=FillPattern.Solid,
                extent={{-30.0,20.0},{0.0,40.0}}),
              Rectangle(fillColor={255,215,136},
                fillPattern=FillPattern.Solid,
                extent={{0.0,20.0},{30.0,40.0}}),
              Rectangle(origin={-2.3077,-0.0},
                fillColor={255,215,136},
                fillPattern=FillPattern.Solid,
                extent={{32.3077,20.0},{62.3077,40.0}}),
                                                  Text(
                  extent={{-150,150},{150,110}},
                  textString="%name",
                  lineColor={0,0,255})}),
              Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                      100,100}}), graphics={
                  Rectangle(
                    extent={{-60,60},{60,-60}},
                    fillColor={235,235,235},
                    fillPattern=FillPattern.Solid,
                    lineColor={0,0,255}),
                  Text(
                    extent={{-100,100},{100,64}},
                    textString="2 dimensional linear table interpolation",
                    lineColor={0,0,255}),
                  Line(points={{-54,40},{-54,-40},{54,-40},{54,40},{28,40},{28,-40},{-28,
                        -40},{-28,40},{-54,40},{-54,20},{54,20},{54,0},{-54,0},{-54,-20},
                        {54,-20},{54,-40},{-54,-40},{-54,40},{54,40},{54,-40}}, color={
                        0,0,0}),
                  Line(points={{0,40},{0,-40}}),
                  Rectangle(
                    extent={{-54,20},{-28,0}},
                    lineColor={0,0,0},
                    fillColor={255,255,0},
                    fillPattern=FillPattern.Solid),
                  Rectangle(
                    extent={{-54,0},{-28,-20}},
                    lineColor={0,0,0},
                    fillColor={255,255,0},
                    fillPattern=FillPattern.Solid),
                  Rectangle(
                    extent={{-54,-20},{-28,-40}},
                    lineColor={0,0,0},
                    fillColor={255,255,0},
                    fillPattern=FillPattern.Solid),
                  Rectangle(
                    extent={{-28,40},{0,20}},
                    lineColor={0,0,0},
                    fillColor={255,255,0},
                    fillPattern=FillPattern.Solid),
                  Rectangle(
                    extent={{0,40},{28,20}},
                    lineColor={0,0,0},
                    fillColor={255,255,0},
                    fillPattern=FillPattern.Solid),
                  Rectangle(
                    extent={{28,40},{54,20}},
                    lineColor={0,0,0},
                    fillColor={255,255,0},
                    fillPattern=FillPattern.Solid),
                  Line(points={{-54,40},{-28,20}}),
                  Line(points={{-28,40},{-54,20}}),
                  Text(
                    extent={{-54,-40},{-30,-56}},
                    textString="u1",
                    lineColor={0,0,255}),
                  Text(
                    extent={{28,58},{52,44}},
                    textString="u2",
                    lineColor={0,0,255}),
                  Text(
                    extent={{-2,12},{32,-22}},
                    textString="y",
                    lineColor={0,0,255})}));
          end CombiTable2DParameter;
        end Tables;
      end TablesAndParameters;

      function BasicCharacteristic
        "Calculation of basic characteristic according to EN 1264"
        input Modelica.SIunits.Temperature T_Fm;
        input Modelica.SIunits.Temperature T_Room;
        output Modelica.SIunits.HeatFlux q_Basis;

      algorithm
        q_Basis :=8.92*(T_Fm - T_Room)^1.1;

        annotation (Documentation(revisions="<html>
<ul>
<li><i>June 1, 2020&nbsp;</i> by Elaine Schmitt:<br/>
Moved into AixLib</li>
<li><i>November 06, 2014&nbsp;</i> by Ana Constantin:<br/>
Added documentation.</li>
</ul>
</html>",   info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Calculation of heat flux that is supposed to be generated from panel heating with given floor temperature (Temp_in[1]) and room temperature (Temp_in[2]). </p>
</html>"));
      end BasicCharacteristic;

      model HeatFlux "Upward and downward heat flux of an underfloor heating circuit according to EN 1264-2"
        extends
          UnderfloorHeating.BaseClasses.EN1264.TablesAndParameters.qG_TypeA;

        parameter Boolean Ceiling "false if ground plate is under panel heating" annotation (choices(checkBox=true));
        parameter Modelica.SIunits.ThermalInsulance R_lambdaIns "Thermal resistance of thermal insulation";
        parameter Modelica.SIunits.ThermalInsulance R_lambdaCeiling "Thermal resistance of ceiling";
        parameter Modelica.SIunits.ThermalInsulance R_lambdaPlaster "Thermal resistance of plaster";
        final parameter Modelica.SIunits.ThermalInsulance R_alphaCeiling = if Ceiling then 1/alpha_Ceiling else 0 "Thermal resistance at the ceiling";
        parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_Ceiling =  5.8824 "Coefficient of heat transfer at Ceiling Surface";
        final parameter Modelica.SIunits.ThermalConductivity lambda_u = lambda_E "Thermal conductivity of wall layers above panel heating without flooring (coverage)";
        parameter Modelica.SIunits.Temperature T_U "Temperature of room / ground under panel heating";

        final parameter Modelica.SIunits.ThermalInsulance R_U = if Ceiling then R_lambdaIns + R_lambdaCeiling + R_lambdaPlaster + R_alphaCeiling  else R_lambdaIns + R_lambdaCeiling + R_lambdaPlaster "Thermal resistance of wall layers under panel heating";
        final parameter Modelica.SIunits.ThermalInsulance R_O = 1 / alpha_Floor + R_lambdaB + s_u / lambda_u "Thermal resistance of wall layers above panel heating";

        final parameter Modelica.SIunits.HeatFlux q_max = K_H * dT_H;
        final parameter Modelica.SIunits.HeatFlux q_U = 1 / R_U * (R_O * q_max + T_Room - T_U);

      initial equation

          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end HeatFlux;

    end EN1264;

    package Flooring "Different flooring types for parameter study of underfloor heating system"
      record FLpartition_EnEV2009_SM_upHalf_UFH_Linoleum
        "Floor partition after EnEV 2009, for building of type S (schwer) and M (mittel), upper half for undefloor heating with Linoleum Gerflor DLW Marmorette"
        extends AixLib.DataBase.Walls.WallBaseDataDefinition(
          n(min=1) = 2 "Number of wall layers (1 - screed, 2 - flooring)",
          d={0.06,0.032} "Thickness of wall layers",
          rho={2000,1160} "Density of wall layers",
          lambda={1.2,0.17} "Thermal conductivity of wall layers",
          c={1000,1400} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation(Documentation(revisions = "<html><ul>
  <li>
    <i>September 5, 2013&#160;</i> by Ole Odendahl:<br/>
    Added documentation and formatted appropriately
  </li>
  <li>
    <i>Juni 1, 2011</i> by Ana Constantin:<br/>
    implemented
  </li>
</ul>
</html>",       info = "<html>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Wall definition according to EnEV 2009. For detailed wall type see
  above.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  <b><span style=\"color: #ff0000\">Attention:</span></b> The first
  element in each vector represents the layer connected to
  <code>port_a</code>(outside), the last element represents the layer
  connected to <code>port_b</code>(surface facing the room).
</p>
<h4>
  <span style=\"color:#008000\">References</span>
</h4>
<p>
  Record is used in model <a href=
  \"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a>
</p>
<p>
  Norm:
</p>
<ul>
  <li>Bundesregierung (Veranst.): Verordnung über energiesparenden
  Wärmeschutz und energiesparende Anlagentechnik bei Gebäuden. Berlin,
  2009
  </li>
</ul>
</html>"));
      end FLpartition_EnEV2009_SM_upHalf_UFH_Linoleum;

      record FLpartition_EnEV2009_SM_upHalf_UFH_WoodenParquet
        "Floor partition after EnEV 2009, for building of type S (schwer) and M (mittel), upper half for undefloor heating with wooden parquett Bawart 3schicht Dielen Trio"
        extends AixLib.DataBase.Walls.WallBaseDataDefinition(
          n(min=1) = 2 "Number of wall layers (1 - screed, 2 - flooring)",
          d={0.06,0.014} "Thickness of wall layers",
          rho={2000,675} "Density of wall layers",
          lambda={1.2,0.16} "Thermal conductivity of wall layers",
          c={1000,1600} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation(Documentation(revisions = "<html><ul>
  <li>
    <i>September 5, 2013&#160;</i> by Ole Odendahl:<br/>
    Added documentation and formatted appropriately
  </li>
  <li>
    <i>Juni 1, 2011</i> by Ana Constantin:<br/>
    implemented
  </li>
</ul>
</html>",       info = "<html>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Wall definition according to EnEV 2009. For detailed wall type see
  above.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  <b><span style=\"color: #ff0000\">Attention:</span></b> The first
  element in each vector represents the layer connected to
  <code>port_a</code>(outside), the last element represents the layer
  connected to <code>port_b</code>(surface facing the room).
</p>
<h4>
  <span style=\"color:#008000\">References</span>
</h4>
<p>
  Record is used in model <a href=
  \"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a>
</p>
<p>
  Norm:
</p>
<ul>
  <li>Bundesregierung (Veranst.): Verordnung über energiesparenden
  Wärmeschutz und energiesparende Anlagentechnik bei Gebäuden. Berlin,
  2009
  </li>
</ul>
</html>"));
      end FLpartition_EnEV2009_SM_upHalf_UFH_WoodenParquet;

      record FLpartition_EnEV2009_SM_upHalf_UFH_Laminate
        "Floor partition after EnEV 2009, for building of type S (schwer) and M (mittel), upper half for undefloor heating with Laminate Kaindl Laminate Flooring"
        extends AixLib.DataBase.Walls.WallBaseDataDefinition(
          n(min=1) = 2 "Number of wall layers (1 - screed, 2 - flooring)",
          d={0.06,0.007} "Thickness of wall layers",
          rho={2000,860} "Density of wall layers",
          lambda={1.2,0.13} "Thermal conductivity of wall layers",
          c={1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation(Documentation(revisions = "<html><ul>
  <li>
    <i>September 5, 2013&#160;</i> by Ole Odendahl:<br/>
    Added documentation and formatted appropriately
  </li>
  <li>
    <i>Juni 1, 2011</i> by Ana Constantin:<br/>
    implemented
  </li>
</ul>
</html>",       info = "<html>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Wall definition according to EnEV 2009. For detailed wall type see
  above.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  <b><span style=\"color: #ff0000\">Attention:</span></b> The first
  element in each vector represents the layer connected to
  <code>port_a</code>(outside), the last element represents the layer
  connected to <code>port_b</code>(surface facing the room).
</p>
<h4>
  <span style=\"color:#008000\">References</span>
</h4>
<p>
  Record is used in model <a href=
  \"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a>
</p>
<p>
  Norm:
</p>
<ul>
  <li>Bundesregierung (Veranst.): Verordnung über energiesparenden
  Wärmeschutz und energiesparende Anlagentechnik bei Gebäuden. Berlin,
  2009
  </li>
</ul>
</html>"));
      end FLpartition_EnEV2009_SM_upHalf_UFH_Laminate;

      record FLpartition_EnEV2009_SM_upHalf_UFH_NaturalStone
        "Floor partition after EnEV 2009, for building of type S (schwer) and M (mittel), upper half for undefloor heating with natural stone"
        extends AixLib.DataBase.Walls.WallBaseDataDefinition(
          n(min=1) = 2 "Number of wall layers (1 - screed, 2 - flooring)",
          d={0.06,0.02} "Thickness of wall layers",
          rho={2000,2600} "Density of wall layers",
          lambda={1.2,2.3} "Thermal conductivity of wall layers",
          c={1000,1300} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation(Documentation(revisions = "<html><ul>
  <li>
    <i>September 5, 2013&#160;</i> by Ole Odendahl:<br/>
    Added documentation and formatted appropriately
  </li>
  <li>
    <i>Juni 1, 2011</i> by Ana Constantin:<br/>
    implemented
  </li>
</ul>
</html>",       info = "<html>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Wall definition according to EnEV 2009. For detailed wall type see
  above.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  <b><span style=\"color: #ff0000\">Attention:</span></b> The first
  element in each vector represents the layer connected to
  <code>port_a</code>(outside), the last element represents the layer
  connected to <code>port_b</code>(surface facing the room).
</p>
<h4>
  <span style=\"color:#008000\">References</span>
</h4>
<p>
  Record is used in model <a href=
  \"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a>
</p>
<p>
  Norm:
</p>
<ul>
  <li>Bundesregierung (Veranst.): Verordnung über energiesparenden
  Wärmeschutz und energiesparende Anlagentechnik bei Gebäuden. Berlin,
  2009
  </li>
</ul>
</html>"));
      end FLpartition_EnEV2009_SM_upHalf_UFH_NaturalStone;

      record FLpartition_EnEV2009_SM_upHalf_UFH_Carpet
        "Floor partition after EnEV 2009, for building of type S (schwer) and M (mittel), upper half for undefloor heating with Carpet Interface Composure 50x50cm SL"
        extends AixLib.DataBase.Walls.WallBaseDataDefinition(
          n(min=1) = 2 "Number of wall layers (1 - screed, 2 - flooring)",
          d={0.06,0.0056} "Thickness of wall layers",
          rho={2000,2000} "Density of wall layers",
          lambda={1.2,0.06} "Thermal conductivity of wall layers",
          c={1000,1300} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation(Documentation(revisions = "<html><ul>
  <li>
    <i>September 5, 2013&#160;</i> by Ole Odendahl:<br/>
    Added documentation and formatted appropriately
  </li>
  <li>
    <i>Juni 1, 2011</i> by Ana Constantin:<br/>
    implemented
  </li>
</ul>
</html>",       info = "<html>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Wall definition according to EnEV 2009. For detailed wall type see
  above.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  <b><span style=\"color: #ff0000\">Attention:</span></b> The first
  element in each vector represents the layer connected to
  <code>port_a</code>(outside), the last element represents the layer
  connected to <code>port_b</code>(surface facing the room).
</p>
<h4>
  <span style=\"color:#008000\">References</span>
</h4>
<p>
  Record is used in model <a href=
  \"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a>
</p>
<p>
  Norm:
</p>
<ul>
  <li>Bundesregierung (Veranst.): Verordnung über energiesparenden
  Wärmeschutz und energiesparende Anlagentechnik bei Gebäuden. Berlin,
  2009
  </li>
</ul>
</html>"));
      end FLpartition_EnEV2009_SM_upHalf_UFH_Carpet;

      record FLpartition_EnEV2009_SM_upHalf_UFH_Elastomer
        "Floor partition after EnEV 2009, for building of type S (schwer) and M (mittel), upper half for undefloor heating with Elastomer flooring Norament 926"
        extends AixLib.DataBase.Walls.WallBaseDataDefinition(
          n(min=1) = 2 "Number of wall layers (1 - screed, 2 - flooring)",
          d={0.06,0.002} "Thickness of wall layers",
          rho={2000,1700} "Density of wall layers",
          lambda={1.2,0.17} "Thermal conductivity of wall layers",
          c={1000,1400} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation(Documentation(revisions = "<html><ul>
  <li>
    <i>September 5, 2013&#160;</i> by Ole Odendahl:<br/>
    Added documentation and formatted appropriately
  </li>
  <li>
    <i>Juni 1, 2011</i> by Ana Constantin:<br/>
    implemented
  </li>
</ul>
</html>",       info = "<html>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Wall definition according to EnEV 2009. For detailed wall type see
  above.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  <b><span style=\"color: #ff0000\">Attention:</span></b> The first
  element in each vector represents the layer connected to
  <code>port_a</code>(outside), the last element represents the layer
  connected to <code>port_b</code>(surface facing the room).
</p>
<h4>
  <span style=\"color:#008000\">References</span>
</h4>
<p>
  Record is used in model <a href=
  \"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a>
</p>
<p>
  Norm:
</p>
<ul>
  <li>Bundesregierung (Veranst.): Verordnung über energiesparenden
  Wärmeschutz und energiesparende Anlagentechnik bei Gebäuden. Berlin,
  2009
  </li>
</ul>
</html>"));
      end FLpartition_EnEV2009_SM_upHalf_UFH_Elastomer;
    end Flooring;

    package FloorLayers
      "Records with floor and ceiling layers for usage with underfloor heating"
      record CEpartition_EnEV2009_SM_loHalf_UFH
        "Ceiling partition after EnEV 2009, for building of type S (schwer) and M (mittel), lower half for underfloor heating"
        extends AixLib.DataBase.Walls.WallBaseDataDefinition(
          n(min=1) = 3 "Number of wall layers (1 - Insulation, 2 - Ceiling, 3 - Plaster)",
          d={0.035,0.16,0.015} "Thickness of wall layers",
          rho={120,2300,1200} "Density of wall layers",
          lambda={0.045,2.3,0.51} "Thermal conductivity of wall layers",
          c={1030,1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation(Documentation(revisions = "<html><ul>
  <li>
    <i>September 5, 2013&#160;</i> by Ole Odendahl:<br/>
    Added documentation and formatted appropriately
  </li>
  <li>
    <i>Juni 1, 2011</i> by Ana Constantin:<br/>
    implemented
  </li>
</ul>
</html>",       info = "<html>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Wall definition according to EnEV 2009. For detailed wall type see
  above.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  <b><span style=\"color: #ff0000\">Attention:</span></b> The first
  element in each vector represents the layer connected to
  <code>port_a</code>(outside), the last element represents the layer
  connected to <code>port_b</code>(surface facing the room).
</p>
<h4>
  <span style=\"color:#008000\">References</span>
</h4>
<p>
  Record is used in model <a href=
  \"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a>
</p>
<p>
  Norm:
</p>
<ul>
  <li>Bundesregierung (Veranst.): Verordnung über energiesparenden
  Wärmeschutz und energiesparende Anlagentechnik bei Gebäuden. Berlin,
  2009
  </li>
</ul>
</html>"));
      end CEpartition_EnEV2009_SM_loHalf_UFH;

      record FLground_EnEV2009_SML_loHalf_UFH
        "Floor towards ground (lower part) after EnEV 2009, for building of type S (schwer), M (mittel) and L (leicht) for underfloor heating"
        extends AixLib.DataBase.Walls.WallBaseDataDefinition(
          n(min=1) = 4 "Number of wall layers (1 - Insulation, 2 - concrete, 3 - foam glass, 4 - gravel)",
          d={0.045, 0.15,0.06, 0.1} "Thickness of wall layers",
          rho={120, 2300, 120, 2000} "Density of wall layers",
          lambda={0.035, 2.3, 0.04, 1.4} "Thermal conductivity of wall layers",
          c={1030,1000,1000,840} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html><ul>
  <li>
    <i>September 5, 2013&#160;</i> by Ole Odendahl:<br/>
    Added documentation and formatted appropriately
  </li>
  <li>
    <i>Juni 1, 2011</i> by Ana Constantin:<br/>
    implemented
  </li>
</ul>
</html>",       info="<html>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Wall definition according to EnEV 2009. For detailed wall type see
  above.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  <b><span style=\"color: #ff0000\">Attention:</span></b> The first
  element in each vector represents the layer connected to
  <code>port_a</code>(outside), the last element represents the layer
  connected to <code>port_b</code>(surface facing the room).
</p>
<h4>
  <span style=\"color:#008000\">References</span>
</h4>
<p>
  Record is used in model <a href=
  \"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a>
</p>
<p>
  Norm:
</p>
<ul>
  <li>Bundesregierung (Veranst.): Verordnung über energiesparenden
  Wärmeschutz und energiesparende Anlagentechnik bei Gebäuden. Berlin,
  2009
  </li>
</ul>
</html>"));
      end FLground_EnEV2009_SML_loHalf_UFH;

      record FLpartition_EnEV2009_SM_upHalf_UFH
        "Floor partition after EnEV 2009, for building of type S (schwer) and M (mittel), upper half for undefloor heating"
        extends AixLib.DataBase.Walls.WallBaseDataDefinition(
          n(min=1) = 2 "Number of wall layers (1 - screed, 2 - flooring)",
          d={0.060,0.0045} "Thickness of wall layers",
          rho={2000,120} "Density of wall layers",
          lambda={1.2,0.045} "Thermal conductivity of wall layers",
          c={1000,1030} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation(Documentation(revisions = "<html><ul>
  <li>
    <i>September 5, 2013&#160;</i> by Ole Odendahl:<br/>
    Added documentation and formatted appropriately
  </li>
  <li>
    <i>Juni 1, 2011</i> by Ana Constantin:<br/>
    implemented
  </li>
</ul>
</html>",       info = "<html>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Wall definition according to EnEV 2009. For detailed wall type see
  above.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  <b><span style=\"color: #ff0000\">Attention:</span></b> The first
  element in each vector represents the layer connected to
  <code>port_a</code>(outside), the last element represents the layer
  connected to <code>port_b</code>(surface facing the room).
</p>
<h4>
  <span style=\"color:#008000\">References</span>
</h4>
<p>
  Record is used in model <a href=
  \"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a>
</p>
<p>
  Norm:
</p>
<ul>
  <li>Bundesregierung (Veranst.): Verordnung über energiesparenden
  Wärmeschutz und energiesparende Anlagentechnik bei Gebäuden. Berlin,
  2009
  </li>
</ul>
</html>"));
      end FLpartition_EnEV2009_SM_upHalf_UFH;

      record FLground_EnEV2009_SML_upHalf_UFH
        "Floor towards ground (upper part) after EnEV 2009, for building of type S (schwer), M (mittel) and L (leicht) for underfloor heating"
        extends AixLib.DataBase.Walls.WallBaseDataDefinition(
          n(min=1) = 2 "Number of wall layers (1 - screed, 2 - flooring)",
          d={0.060,0.0045} "Thickness of wall layers",
          rho={2000,140} "Density of wall layers",
          lambda={1.2,0.045} "Thermal conductivity of wall layers",
          c={1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html><ul>
  <li>
    <i>September 5, 2013&#160;</i> by Ole Odendahl:<br/>
    Added documentation and formatted appropriately
  </li>
  <li>
    <i>Juni 1, 2011</i> by Ana Constantin:<br/>
    implemented
  </li>
</ul>
</html>",       info="<html>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Wall definition according to EnEV 2009. For detailed wall type see
  above.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  <b><span style=\"color: #ff0000\">Attention:</span></b> The first
  element in each vector represents the layer connected to
  <code>port_a</code>(outside), the last element represents the layer
  connected to <code>port_b</code>(surface facing the room).
</p>
<h4>
  <span style=\"color:#008000\">References</span>
</h4>
<p>
  Record is used in model <a href=
  \"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a>
</p>
<p>
  Norm:
</p>
<ul>
  <li>Bundesregierung (Veranst.): Verordnung über energiesparenden
  Wärmeschutz und energiesparende Anlagentechnik bei Gebäuden. Berlin,
  2009
  </li>
</ul>
</html>"));
      end FLground_EnEV2009_SML_upHalf_UFH;

      record EnEV2009Heavy_UFH
        "Heavy building mass, insulation according to regulation EnEV 2009 in combination with underfloor heating"
        extends AixLib.DataBase.Walls.Collections.OFD.BaseDataMultiInnerWalls(
          OW=AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S(),
          IW_vert_half_a=AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_S_half(),
          IW_vert_half_b=AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_S_half(),
          IW_hori_upp_half=
              UnderfloorHeating.BaseClasses.FloorLayers.FLpartition_EnEV2009_SM_upHalf_UFH(),
          IW_hori_low_half=
              UnderfloorHeating.BaseClasses.FloorLayers.CEpartition_EnEV2009_SM_loHalf_UFH(),
          IW_hori_att_upp_half=
              AixLib.DataBase.Walls.EnEV2009.Floor.FLattic_EnEV2009_SML_upHalf(),
          IW_hori_att_low_half=
              AixLib.DataBase.Walls.EnEV2009.Ceiling.CEattic_EnEV2009_SML_loHalf(),
          groundPlate_upp_half=
              UnderfloorHeating.BaseClasses.FloorLayers.FLground_EnEV2009_SML_upHalf_UFH(),
          groundPlate_low_half=
              UnderfloorHeating.BaseClasses.FloorLayers.FLground_EnEV2009_SML_loHalf_UFH(),
          roof=AixLib.DataBase.Walls.EnEV2009.Ceiling.ROsaddleAttic_EnEV2009_SML(),
          IW2_vert_half_a=AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half(),
          IW2_vert_half_b=AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half(),
          roofRoomUpFloor=
              AixLib.DataBase.Walls.EnEV2009.Ceiling.ROsaddleRoom_EnEV2009_SML());

      end EnEV2009Heavy_UFH;

      record Ceiling_Dummy "Ceiling dummy to prevent downward heat flow in underfloor heating"
        extends AixLib.DataBase.Walls.WallBaseDataDefinition(
          n(min=1) = 4 "Number of wall layers (1 - screed, 2 - flooring)",
          d={1,1,1,1} "Thickness of wall layers",
          rho={2000,140,100,100} "Density of wall layers",
          lambda={0.0001,0.0001,0.0001,0.0001} "Thermal conductivity of wall layers",
          c={1000,1000,1000,1000} "Specific heat capacity of wall layers",
          eps=0.95 "Emissivity of inner wall surface");
        annotation (Documentation(revisions="<html><ul>
  <li>
    <i>September 5, 2013&#160;</i> by Ole Odendahl:<br/>
    Added documentation and formatted appropriately
  </li>
  <li>
    <i>Juni 1, 2011</i> by Ana Constantin:<br/>
    implemented
  </li>
</ul>
</html>",       info="<html>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Wall definition according to EnEV 2009. For detailed wall type see
  above.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  <b><span style=\"color: #ff0000\">Attention:</span></b> The first
  element in each vector represents the layer connected to
  <code>port_a</code>(outside), the last element represents the layer
  connected to <code>port_b</code>(surface facing the room).
</p>
<h4>
  <span style=\"color:#008000\">References</span>
</h4>
<p>
  Record is used in model <a href=
  \"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a>
</p>
<p>
  Norm:
</p>
<ul>
  <li>Bundesregierung (Veranst.): Verordnung über energiesparenden
  Wärmeschutz und energiesparende Anlagentechnik bei Gebäuden. Berlin,
  2009
  </li>
</ul>
</html>"));
      end Ceiling_Dummy;
    end FloorLayers;

    package PressureLoss
      "Calculation of pressure loss in valve according to SCHUETZ ENERGY SYSTEMS"
      function GetPressureLossOfUFHDistributor
        "Function to evaluate the pressure loss for a given number of heating circuit distributor outlets."
        input Modelica.SIunits.VolumeFlowRate vol_flow "Volume flow rate";
        input Integer numHeaCirDisOut(min=2, max=14) "Number of heating circuit distributor outlets";
        output Modelica.SIunits.PressureDifference preDrop "Pressure drop for the given input";
      protected
        Real vol_flow_internal= vol_flow*1000*3600 "Used for conversion of m^3/s to litre/h";
        Real table_internal "Table with offset for the different number of heating circuit outlets";
        // Based on the table in Schuetz Energy Systems- see info.
        parameter Real slope=2.12944 "Constant for every number of registers.";
        Real offset "Output of the table";
      algorithm
        assert(numHeaCirDisOut > 1, "The calculated number of heating circuit distribution outlets is " + String(numHeaCirDisOut) + ". This value is too low! You could set a smaller zone spacing.", level = AssertionLevel.error);
        assert(numHeaCirDisOut < 15, "The calculated number of heating circuit distribution outlets is " + String(numHeaCirDisOut) + ". This value is too high! You could set a higher zone spacing.", level = AssertionLevel.error);
        // Based on the table in Schuetz Energy Systems- see info.
        if numHeaCirDisOut==2 then
          offset := -11.788371506907453;
        elseif numHeaCirDisOut==3 then
          offset := -12.571094906030572;
        elseif numHeaCirDisOut==4 then
          offset := -13.048512484688304;
        elseif numHeaCirDisOut==5 then
          offset := -13.2811178491032;
        elseif numHeaCirDisOut==6 then
          offset := -13.502462293474359;
        elseif numHeaCirDisOut==7 then
          offset := -13.652547735813013;
        elseif numHeaCirDisOut==8 then
          offset := -13.713987271819773;
        else
          offset := -13.799344983248627;
        end if;
        preDrop := Modelica.Constants.e^(slope * Modelica.Math.log(vol_flow_internal) + offset)*1000;
        annotation (Documentation(info="<html>
<p>Get the pressure loss of an under floor heating system based on the number of heating circuit distributor outlets. The data is calculated based on the log-log-diagram in the following image. Based on [1, p. 11].</p>
<p><img src=\"modelica://UnderfloorHeating/Resources/PressureLossOfUFHDistributor.png\"/></p>
<p>[1] SCH&Uuml;TZ ENERGY SYSTEMS: Heizkreisverteiler: Montageanleitung/- Technische Information. 2017; <a href=\"https://www.schuetz-energy.net/downloads/anleitungen/montageanleitung-heizkreisverteiler/schuetz-montageanleitung-fbh-heizkreisverteiler-de.pdf\">Link to pdf</a></p>
</html>"));
      end GetPressureLossOfUFHDistributor;

      function GetPressureLossOfUFHValve
        "Function to evaluate the pressure loss for regulating valve of heating circuit."
        input Modelica.SIunits.VolumeFlowRate vol_flow "Volume flow rate";
        input Modelica.SIunits.PressureDifference dp_Pipe "Pressure Drop in Pipe";
        output Modelica.SIunits.PressureDifference preDrop "Pressure drop for the given input";
      protected
        Real vol_flow_internal= vol_flow*1000*3600 "Used for conversion of m^3/s to litre/h";
        Real table_internal "Table with offset for the different Kv-Values";
        Real K_v(max=1.02) = vol_flow*3600 * sqrt(10^5 / dp_Pipe) "Kv-value for valve";
        // Based on the table in Schuetz Energy Systems - see info.
        parameter Real slope=2.05 "Constant for every Kv-value";
        Real offset "Output of the table";
      algorithm
        assert(vol_flow_internal <= 1000, "Volume flow is too high, maximum 1000 L/h", level = AssertionLevel.error);
        assert(K_v <= 1.02, "K_v value for valve is "+String(K_v)+" and exceeds maximum of 1.02, check m_flow or dp_pipe for reasonable pressure drop in valve", AssertionLevel.warning);
        // Based on the table in Schuetz Energy Systems- see info.
          if K_v <= 0.56 then
          offset := -12.08;
          elseif K_v <= 0.85 then
          offset := -13.02;
          elseif K_v < 1.02 then
          offset := -13.89;
          else
          offset:= -14.18;
        end if;
        preDrop := Modelica.Constants.e^(slope * Modelica.Math.log(vol_flow_internal) + offset)*1000;
        annotation (Documentation(info="<html>
<p>Get the pressure loss of an under floor heating valve. The data is calculated based on the log-log-diagram in the following image. Based on [1, p. 11].</p>
<p><img src=\"modelica://UnderfloorHeating/Resources/PressureLossOfUFHValve.png\"/></p>
<p>[1] SCH&Uuml;TZ ENERGY SYSTEMS: Heizkreisverteiler: Montageanleitung/- Technische Information. 2017; <a href=\"https://www.schuetz-energy.net/downloads/anleitungen/montageanleitung-heizkreisverteiler/schuetz-montageanleitung-fbh-heizkreisverteiler-de.pdf\">Link to pdf</a></p>
</html>"));
      end GetPressureLossOfUFHValve;
    end PressureLoss;
  end BaseClasses;

  package Examples "Package with examples for underfloor heating system"
    extends Modelica.Icons.ExamplesPackage;

    package SimpleRoom
      "Examples for underfloor heating system with simple rooms represented by a volume element"
      model OneRoomSimple "Example for underfloor heating system with one ideal room"
        extends Modelica.Icons.Example;
        package MediumAir = AixLib.Media.Air;
         package MediumWater = AixLib.Media.Water;
         parameter Modelica.SIunits.Area area=20;

        AixLib.Fluid.MixingVolumes.MixingVolume vol(
          redeclare package Medium = MediumAir,
          m_flow_nominal=0.1,
          V=area*3)
          annotation (Placement(transformation(extent={{-10,12},{10,32}})));
        Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow(Q_flow=-1000)
          annotation (Placement(transformation(extent={{-40,74},{-20,94}})));
        UnderfloorHeating.UnderfloorHeatingSystem underfloorHeatingSystem(
          redeclare package Medium = MediumWater,
          RoomNo=1,
          dis=dis,
          Q_Nf=-1.*{fixedHeatFlow.Q_flow},
          A={area},
          wallTypeFloor={
              UnderfloorHeating.BaseClasses.FloorLayers.FLpartition_EnEV2009_SM_upHalf_UFH()},

          Ceiling={false},
          wallTypeCeiling={
              UnderfloorHeating.BaseClasses.FloorLayers.Ceiling_Dummy()},
          Spacing={0.35},
          PipeThickness={0.002},
          d_a={0.017},
          withSheathing=false)
          annotation (Placement(transformation(extent={{-32,-64},{18,-34}})));
        Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor[dis](
            each G=area/dis*10.8)
          annotation (Placement(transformation(extent={{-4,-12},{-24,8}})));
        parameter Integer dis=100
          "Number of discretization layers for panel heating pipe";
        Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow1(Q_flow=0)
          annotation (Placement(transformation(extent={{58,-100},{38,-80}})));
        Modelica.Blocks.Sources.Constant const[1](each k=1)
          annotation (Placement(transformation(extent={{-100,-26},{-86,-12}})));
        AixLib.Fluid.Sources.MassFlowSource_T boundary(
          redeclare package Medium = MediumWater,
          use_m_flow_in=true,
          use_T_in=true,
          nPorts=1)
          annotation (Placement(transformation(extent={{-98,-58},{-78,-38}})));
        AixLib.Fluid.Sources.Boundary_pT bou(redeclare package Medium =
              MediumWater,
            nPorts=1)
          annotation (Placement(transformation(extent={{74,-60},{54,-40}})));
      equation

        for i in 1:dis loop
          connect(fixedHeatFlow1.port, underfloorHeatingSystem.heatCeiling[i])
          annotation (Line(points={{38,-90},{20,-90},{20,-92},{-7,-92},{-7,-64}},
              color={191,0,0}));
          connect(thermalConductor[i].port_b, vol.heatPort) annotation (Line(points={{-24,-2},
                {-34,-2},{-34,22},{-10,22}}, color={191,0,0}));
        end for;

        connect(const.y, underfloorHeatingSystem.valveInput) annotation (Line(points={
                {-85.3,-19},{-23,-19},{-23,-32}}, color={0,0,127}));
        connect(boundary.ports[1], underfloorHeatingSystem.port_a) annotation (Line(
              points={{-78,-48},{-56,-48},{-56,-49},{-32,-49}}, color={0,127,255}));
        connect(underfloorHeatingSystem.port_b, bou.ports[1]) annotation (Line(points=
               {{18,-49},{38,-49},{38,-50},{54,-50}}, color={0,127,255}));
        connect(underfloorHeatingSystem.m_flowNominal, boundary.m_flow_in)
          annotation (Line(points={{-32,-58},{-40,-58},{-40,-56},{-68,-56},{-68,-62},{
                -106,-62},{-106,-40},{-100,-40}}, color={0,0,127}));
        connect(underfloorHeatingSystem.T_FlowNominal, boundary.T_in) annotation (
            Line(points={{-32,-62.5},{-62,-62.5},{-62,-70},{-114,-70},{-114,-44},{-100,
                -44}}, color={0,0,127}));
        connect(thermalConductor.port_a, underfloorHeatingSystem.heatFloor)
          annotation (Line(points={{-4,-2},{-2,-2},{-2,-4},{4,-4},{4,-24},{-7,-24},{-7,
                -34}}, color={191,0,0}));
        connect(fixedHeatFlow.port, vol.heatPort) annotation (Line(points={{-20,84},{-14,
                84},{-14,22},{-10,22}}, color={191,0,0}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end OneRoomSimple;

      model OneRoomSimple_qu "Example for underfloor heating system with two rooms for ideal upward and downward heat flow"
        extends Modelica.Icons.Example;
        package MediumAir = AixLib.Media.Air;
         package MediumWater = AixLib.Media.Water;
         parameter Modelica.SIunits.Area area=20;

        AixLib.Fluid.MixingVolumes.MixingVolume vol(
          redeclare package Medium = MediumAir,
          m_flow_nominal=0.1,
          V=area*3)
          annotation (Placement(transformation(extent={{-10,44},{10,64}})));
        Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow(Q_flow=-1000)
          annotation (Placement(transformation(extent={{-40,74},{-20,94}})));
        UnderfloorHeating.UnderfloorHeatingSystem underfloorHeatingSystem(
          redeclare package Medium = MediumWater,
          RoomNo=1,
          dis=dis,
          Q_Nf=-1.*{fixedHeatFlow.Q_flow},
          A={area},
          wallTypeFloor={
              UnderfloorHeating.BaseClasses.FloorLayers.FLpartition_EnEV2009_SM_upHalf_UFH()},

          Ceiling={true},
          wallTypeCeiling={
              UnderfloorHeating.BaseClasses.FloorLayers.CEpartition_EnEV2009_SM_loHalf_UFH()},

          Spacing={0.35},
          PipeThickness={0.002},
          d_a={0.017},
          withSheathing=false)
          annotation (Placement(transformation(extent={{-32,-32},{18,-2}})));
        Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor[dis](each G=
              area/dis*10.8)
          annotation (Placement(transformation(extent={{-4,20},{-24,40}})));
        parameter Integer dis=100
          "Number of discretization layers for panel heating pipe";
        Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow1(Q_flow=-232)
          annotation (Placement(transformation(extent={{58,-100},{38,-80}})));
        Modelica.Blocks.Sources.Constant const[1](each k=1)
          annotation (Placement(transformation(extent={{-100,6},{-86,20}})));
        AixLib.Fluid.Sources.MassFlowSource_T boundary(
          redeclare package Medium = MediumWater,
          use_m_flow_in=true,
          use_T_in=true,
          nPorts=1)
          annotation (Placement(transformation(extent={{-98,-26},{-78,-6}})));
        AixLib.Fluid.Sources.Boundary_pT bou(redeclare package Medium =
              MediumWater,
            nPorts=1)
          annotation (Placement(transformation(extent={{74,-28},{54,-8}})));
        Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor1
                                                                                  [dis](each G=
              area/dis*5.8824)
          annotation (Placement(transformation(extent={{18,-76},{-2,-56}})));
        AixLib.Fluid.MixingVolumes.MixingVolume vol1(
          redeclare package Medium = MediumAir,
          m_flow_nominal=0.1,
          V=area*3)
          annotation (Placement(transformation(extent={{36,-76},{56,-56}})));
      equation

        for i in 1:dis loop
          connect(thermalConductor[i].port_b, vol.heatPort) annotation (Line(points={{-24,30},
                  {-34,30},{-34,54},{-10,54}},
                                             color={191,0,0}));
          connect(thermalConductor1[i].port_a, vol1.heatPort)
          annotation (Line(points={{18,-66},{36,-66}}, color={191,0,0}));
        end for;

        connect(const.y, underfloorHeatingSystem.valveInput) annotation (Line(points={{-85.3,
                13},{-23,13},{-23,0}},            color={0,0,127}));
        connect(boundary.ports[1], underfloorHeatingSystem.port_a) annotation (Line(
              points={{-78,-16},{-56,-16},{-56,-17},{-32,-17}}, color={0,127,255}));
        connect(underfloorHeatingSystem.port_b, bou.ports[1]) annotation (Line(points={{18,-17},
                {38,-17},{38,-18},{54,-18}},          color={0,127,255}));
        connect(underfloorHeatingSystem.m_flowNominal, boundary.m_flow_in)
          annotation (Line(points={{-32,-26},{-40,-26},{-40,-24},{-68,-24},{-68,-30},{
                -106,-30},{-106,-8},{-100,-8}},   color={0,0,127}));
        connect(underfloorHeatingSystem.T_FlowNominal, boundary.T_in) annotation (
            Line(points={{-32,-30.5},{-62,-30.5},{-62,-38},{-114,-38},{-114,-12},{-100,
                -12}}, color={0,0,127}));
        connect(thermalConductor.port_a, underfloorHeatingSystem.heatFloor)
          annotation (Line(points={{-4,30},{-2,30},{-2,28},{4,28},{4,8},{-7,8},{-7,-2}},
                       color={191,0,0}));
        connect(fixedHeatFlow.port, vol.heatPort) annotation (Line(points={{-20,84},{-16,
                84},{-16,54},{-10,54}}, color={191,0,0}));
        connect(underfloorHeatingSystem.heatCeiling, thermalConductor1.port_b)
          annotation (Line(points={{-7,-32},{-7,-49},{-2,-49},{-2,-66}}, color={191,0,
                0}));

        connect(fixedHeatFlow1.port, vol1.heatPort) annotation (Line(points={{38,-90},
                {28,-90},{28,-66},{36,-66}}, color={191,0,0}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)),
          experiment(StopTime=8640000));
      end OneRoomSimple_qu;

    annotation ();
    end SimpleRoom;

    package OFD

      model OFD_UFH
        "Test environment for OFD with underfloor heating system"
        extends Modelica.Icons.Example;

        parameter Integer nRooms = 11;
        parameter Integer nHeatedRooms = 10;

        parameter Integer TIR=1 "Thermal Insulation Regulation" annotation (Dialog(
            group="Construction parameters",
            compact=true,
            descriptionLabel=true), choices(
            choice=1 "EnEV_2009",
            choice=2 "EnEV_2002",
            choice=3 "WSchV_1995",
            choice=4 "WSchV_1984",
            radioButtons=true));
        parameter Integer dis = 50;
        parameter Modelica.SIunits.Distance Spacing[nHeatedRooms] = fill(0.2, 10);
        parameter Modelica.SIunits.Diameter d_a[nHeatedRooms] = fill(0.017, 10);
        parameter Modelica.SIunits.Diameter d[nHeatedRooms] = fill(0.018, 10);
        Modelica.Blocks.Sources.Constant constAirEx[nRooms](k={0.5,0.5,0,0.5,0.5,0.5,0.5,0,0.5,0.5,0}) "1: LivingRoom_GF, 2: Hobby_GF, 3: Corridor_GF, 4: WC_Storage_GF, 5: Kitchen_GF, 6: Bedroom_UF, 7: Child1_UF, 8: Corridor_UF, 9: Bath_UF, 10: Child2_UF, 11: Attic" annotation (Placement(transformation(extent={{-70,6},{-50,26}})));
        Modelica.Blocks.Sources.Constant constWind(k=0)
          annotation (Placement(transformation(extent={{-70,36},{-50,56}})));
        Modelica.Blocks.Sources.Constant constAmb(k=261.15)
          annotation (Placement(transformation(extent={{-70,70},{-50,90}})));
        Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow    groundTemp[5](Q_flow=
              fill(0, 5))
          annotation (Placement(transformation(extent={{-54,-96},{-42,-84}})));
        AixLib.Utilities.Interfaces.Adaptors.ConvRadToCombPort heatStarToComb[nRooms]
          annotation (Placement(transformation(
              extent={{8,-6},{-8,6}},
              rotation=0,
              origin={-36,-12})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature prescribedAmbTemperature
          annotation (Placement(transformation(extent={{-40,58},{-28,70}})));
        AixLib.Utilities.Sources.PrescribedSolarRad varRad(n=6)
          annotation (Placement(transformation(extent={{70,60},{50,80}})));
        Modelica.Blocks.Sources.Constant constSun[6](k=fill(0, 6))
          annotation (Placement(transformation(extent={{100,70},{80,90}})));
        AixLib.ThermalZones.HighOrder.House.OFD_MiddleInnerLoadWall.BuildingEnvelopeDiscretized.WholeHouseBuildingEnvelope
          wholeHouseBuildingEnvelope(
          use_UFH=true,
          redeclare BaseClasses.FloorLayers.EnEV2009Heavy_UFH wallTypes,
          energyDynamicsWalls=Modelica.Fluid.Types.Dynamics.FixedInitial,
          initDynamicsAir=Modelica.Fluid.Types.Dynamics.FixedInitial,
          T0_air=294.15,
          TWalls_start=292.15,
          calcMethodIn=1,
          redeclare AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009
            Type_Win,
          use_infiltEN12831=true,
          n50=if TIR == 1 or TIR == 2 then 3 else if TIR == 3 then 4 else 6,
          dis=dis,
          AirExchangeCorridor=0,
          UValOutDoors=if TIR == 1 then 1.8 else 2.9)
          annotation (Placement(transformation(extent={{-14,-10},{42,46}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlowRad[nRooms] annotation (Placement(transformation(extent={{-60,-16},
                  {-48,-4}})));
        Modelica.Blocks.Sources.Constant adiabaticRadRooms[nRooms](k=fill(0, nRooms)) "1: LivingRoom_GF, 2: Hobby_GF, 3: Corridor_GF, 4: WC_Storage_GF, 5: Kitchen_GF, 6: Bedroom_UF, 7: Child1_UF, 8: Corridor_UF, 9: Bath_UF, 10: Child2_UF, 11: Attic" annotation (Placement(transformation(extent={{-90,-18},
                  {-74,-2}})));
        Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlowAttic[1](Q_flow={0}) annotation (Placement(transformation(extent={{-62,-26},
                  {-52,-16}})));
        UnderfloorHeating.UnderfloorHeatingSystem underfloorHeatingSystem(
          redeclare package Medium = AixLib.Media.Water,
          RoomNo=10,
          dis=dis,
          Q_Nf={638,1078,502,341,783,766,506,196,443,658},
          A={wholeHouseBuildingEnvelope.groundFloor_Building.WC_Storage.floor[1].Wall.A
              *dis,wholeHouseBuildingEnvelope.groundFloor_Building.Livingroom.floor[
              1].Wall.A*dis,wholeHouseBuildingEnvelope.groundFloor_Building.Hobby.floor[
              1].Wall.A*dis,wholeHouseBuildingEnvelope.groundFloor_Building.Corridor.floor[
              1].Wall.A*dis,wholeHouseBuildingEnvelope.groundFloor_Building.Kitchen.floor[
              1].Wall.A*dis,wholeHouseBuildingEnvelope.upperFloor_Building.Bedroom.floor[
              1].Wall.A*dis,wholeHouseBuildingEnvelope.upperFloor_Building.Children1.floor[
              1].Wall.A*dis,wholeHouseBuildingEnvelope.upperFloor_Building.Corridor.floor[
              1].Wall.A*dis,wholeHouseBuildingEnvelope.upperFloor_Building.Bath.floor[
              1].Wall.A*dis,wholeHouseBuildingEnvelope.upperFloor_Building.Children2.floor[
              1].Wall.A*dis},
          calculateVol=2,
          wallTypeFloor=fill(
              BaseClasses.FloorLayers.FLpartition_EnEV2009_SM_upHalf_UFH(), 10),

          Ceiling={false,false,false,false,false,true,true,true,true,true},
          wallTypeCeiling={
              UnderfloorHeating.BaseClasses.FloorLayers.Ceiling_Dummy(),
              UnderfloorHeating.BaseClasses.FloorLayers.Ceiling_Dummy(),
              UnderfloorHeating.BaseClasses.FloorLayers.Ceiling_Dummy(),
              UnderfloorHeating.BaseClasses.FloorLayers.Ceiling_Dummy(),
              UnderfloorHeating.BaseClasses.FloorLayers.Ceiling_Dummy(),
              wholeHouseBuildingEnvelope.groundFloor_Building.Livingroom.Ceiling[
              1].Wall.wallType,wholeHouseBuildingEnvelope.groundFloor_Building.Hobby.Ceiling[
              1].Wall.wallType,wholeHouseBuildingEnvelope.groundFloor_Building.Corridor.Ceiling[
              1].Wall.wallType,wholeHouseBuildingEnvelope.groundFloor_Building.WC_Storage.Ceiling[
              1].Wall.wallType,wholeHouseBuildingEnvelope.groundFloor_Building.Kitchen.Ceiling[
              1].Wall.wallType},
          T_U={293.15,293.15,293.15,293.15,293.15,293.15,293.15,293.15,293.15,
              293.15},
          Spacing=fill(0.2, 10),
          PipeMaterial=BaseClasses.PipeMaterials.PERTpipe(),
          PipeThickness=fill(0.002, 10),
          d_a=fill(0.017, 10),
          withSheathing=false)
          annotation (Placement(transformation(extent={{-68,-66},{-44,-52}})));

        AixLib.Fluid.Sources.MassFlowSource_T m_flow_specification1(
          redeclare package Medium = AixLib.Media.Water,
          use_m_flow_in=true,
          use_T_in=true,
          nPorts=1)
          annotation (Placement(transformation(extent={{-98,-66},{-82,-50}})));
        AixLib.Fluid.Sources.Boundary_pT boundary(redeclare package Medium =
              AixLib.Media.Water, nPorts=1)
          annotation (Placement(transformation(extent={{-12,-64},{-24,-52}})));
        Modelica.Blocks.Sources.Constant const[sum(underfloorHeatingSystem.CircuitNo)](each k=
              1)
                annotation (Placement(transformation(
              extent={{-6,-6},{6,6}},
              rotation=0,
              origin={-86,-36})));
      equation
        connect(constAmb.y, prescribedAmbTemperature.T) annotation (Line(
            points={{-49,80},{-46,80},{-46,64},{-41.2,64}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(constSun.y,varRad. I) annotation (Line(
            points={{79,80},{74,80},{74,78.9},{68.9,78.9}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(constSun.y,varRad. I_dir) annotation (Line(
            points={{79,80},{74,80},{74,75},{69,75}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(constSun.y,varRad. I_diff) annotation (Line(
            points={{79,80},{74,80},{74,71},{69,71}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(constSun.y,varRad. I_gr) annotation (Line(
            points={{79,80},{74,80},{74,66.9},{68.9,66.9}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(constSun.y,varRad. AOI) annotation (Line(
            points={{79,80},{74,80},{74,63},{69,63}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(constWind.y, wholeHouseBuildingEnvelope.WindSpeedPort) annotation (
            Line(points={{-49,46},{-38,46},{-38,37.6},{-16.8,37.6}},    color={0,0,
                127}));
        connect(prescribedAmbTemperature.port, wholeHouseBuildingEnvelope.thermOutside)
          annotation (Line(points={{-28,64},{-14,64},{-14,45.44}},    color={191,0,0}));
        connect(groundTemp.port, wholeHouseBuildingEnvelope.groundTemp)
          annotation (Line(points={{-42,-90},{14,-90},{14,-10}}, color={191,0,0}));
        connect(varRad.solarRad_out[1], wholeHouseBuildingEnvelope.North) annotation (
           Line(points={{51,69.1667},{48,69.1667},{48,26.4},{43.68,26.4}},  color={
                255,128,0}));
        connect(varRad.solarRad_out[2], wholeHouseBuildingEnvelope.East) annotation (
            Line(points={{51,69.5},{48,69.5},{48,18},{43.68,18}},      color={255,128,
                0}));
        connect(varRad.solarRad_out[3], wholeHouseBuildingEnvelope.South) annotation (
           Line(points={{51,69.8333},{48,69.8333},{48,9.6},{43.68,9.6}},  color={255,
                128,0}));
        connect(varRad.solarRad_out[4], wholeHouseBuildingEnvelope.West) annotation (
            Line(points={{51,70.1667},{48,70.1667},{48,1.2},{43.68,1.2}},  color={255,
                128,0}));
        connect(varRad.solarRad_out[5], wholeHouseBuildingEnvelope.SolarRadiationPort_RoofN)
          annotation (Line(points={{51,70.5},{48,70.5},{48,43.2},{43.68,43.2}},color=
                {255,128,0}));
        connect(varRad.solarRad_out[6], wholeHouseBuildingEnvelope.SolarRadiationPort_RoofS)
          annotation (Line(points={{51,70.8333},{48,70.8333},{48,34.8},{43.68,
                34.8}},
              color={255,128,0}));
        connect(heatStarToComb.portConvRadComb, wholeHouseBuildingEnvelope.heatingToRooms) annotation (Line(points={{-28,-12},
                {-26,-12},{-26,10},{-14,10},{-14,10.16}},                                                                                                                      color={191,0,0}));
        connect(constAirEx.y, wholeHouseBuildingEnvelope.AirExchangePort) annotation (
           Line(points={{-49,16},{-44,16},{-44,32},{-16.8,32}},      color={0,0,127}));
        connect(prescribedHeatFlowRad.port, heatStarToComb.portRad) annotation (Line(points={{-48,-10},
                {-46,-10},{-46,-8.25},{-44,-8.25}},                                                                                          color={191,0,0}));
        connect(adiabaticRadRooms.y, prescribedHeatFlowRad.Q_flow)
          annotation (Line(points={{-73.2,-10},{-60,-10}}, color={0,0,127}));
        connect(fixedHeatFlowAttic[1].port, heatStarToComb[1].portConv) annotation (Line(points={{-52,-21},
                {-50,-21},{-50,-15.75},{-44,-15.75}},                                                                                            color={191,0,0}));
        connect(m_flow_specification1.ports[1], underfloorHeatingSystem.port_a)
          annotation (Line(points={{-82,-58},{-76,-58},{-76,-59},{-68,-59}}, color={0,
                127,255}));
        connect(underfloorHeatingSystem.T_FlowNominal, m_flow_specification1.T_in)
          annotation (Line(points={{-68,-65.3},{-78,-65.3},{-78,-66},{-110,-66},{-110,
                -54.8},{-99.6,-54.8}}, color={0,0,127}));
        connect(underfloorHeatingSystem.port_b, boundary.ports[1]) annotation (Line(
              points={{-44,-59},{-44,-58},{-24,-58}}, color={0,127,255}));
        connect(const.y, underfloorHeatingSystem.valveInput) annotation (Line(points={{-79.4,
                -36},{-63.68,-36},{-63.68,-51.0667}},        color={0,0,127}));
                for i in 1:dis loop
        connect(underfloorHeatingSystem.heatFloor[i], wholeHouseBuildingEnvelope.groFloDown[3*dis+i])
          annotation (Line(points={{-56,-52},{-54,-52},{-54,-44},{-22,-44},{-22,2.32},
                {-14,2.32}}, color={191,0,0}));
        connect(underfloorHeatingSystem.heatCeiling[i], wholeHouseBuildingEnvelope.groPlateUp[4])
          annotation (Line(points={{-56,-66},{-56,-70},{-4,-70},{-4,-30},{-14,-30},{-14,
                  -3.28}},
                        color={191,0,0}));
        connect(underfloorHeatingSystem.heatFloor[dis+i], wholeHouseBuildingEnvelope.groFloDown[i])
          annotation (Line(points={{-56,-52},{-54,-52},{-54,-44},{-22,-44},{-22,2.32},
                {-14,2.32}}, color={191,0,0}));
        connect(underfloorHeatingSystem.heatCeiling[dis+i], wholeHouseBuildingEnvelope.groPlateUp[1])
          annotation (Line(points={{-56,-66},{-56,-70},{-4,-70},{-4,-30},{-14,-30},{-14,
                  -6.64}},
                        color={191,0,0}));
        connect(underfloorHeatingSystem.heatFloor[2*dis+i], wholeHouseBuildingEnvelope.groFloDown[dis+i])
          annotation (Line(points={{-56,-52},{-54,-52},{-54,-44},{-22,-44},{-22,2.32},
                {-14,2.32}}, color={191,0,0}));
        connect(underfloorHeatingSystem.heatCeiling[2*dis+i], wholeHouseBuildingEnvelope.groPlateUp[2])
          annotation (Line(points={{-56,-66},{-56,-70},{-4,-70},{-4,-30},{-14,-30},{-14,
                  -5.52}},
                        color={191,0,0}));
        connect(underfloorHeatingSystem.heatFloor[3*dis+i], wholeHouseBuildingEnvelope.groFloDown[2*dis+i])
          annotation (Line(points={{-56,-52},{-54,-52},{-54,-44},{-22,-44},{-22,2.32},
                {-14,2.32}}, color={191,0,0}));
        connect(underfloorHeatingSystem.heatCeiling[3*dis+i], wholeHouseBuildingEnvelope.groPlateUp[3])
          annotation (Line(points={{-56,-66},{-56,-70},{-4,-70},{-4,-30},{-14,-30},{-14,
                -4.4}}, color={191,0,0}));
        connect(underfloorHeatingSystem.heatFloor[4*dis+i], wholeHouseBuildingEnvelope.groFloDown[4*dis+i])
          annotation (Line(points={{-56,-52},{-54,-52},{-54,-44},{-22,-44},{-22,2.32},
                {-14,2.32}}, color={191,0,0}));
        connect(underfloorHeatingSystem.heatCeiling[4*dis+i], wholeHouseBuildingEnvelope.groPlateUp[5])
          annotation (Line(points={{-56,-66},{-56,-70},{-4,-70},{-4,-30},{-14,-30},{-14,
                  -2.16}},
                        color={191,0,0}));
        connect(underfloorHeatingSystem.heatFloor[5*dis+i], wholeHouseBuildingEnvelope.uppFloDown[i])
          annotation (Line(points={{-56,-52},{-54,-52},{-54,-44},{-22,-44},{-22,24.72},
                {-14,24.72}}, color={191,0,0}));
        connect(wholeHouseBuildingEnvelope.groFloUp[i], underfloorHeatingSystem.heatCeiling[5*dis+i])
          annotation (Line(points={{-14,18},{-18,18},{-18,-30},{-4,-30},{-4,-70},{-44,
                -70},{-44,-66},{-56,-66}}, color={191,0,0}));
        connect(underfloorHeatingSystem.heatFloor[6*dis+i], wholeHouseBuildingEnvelope.uppFloDown[dis+i])
          annotation (Line(points={{-56,-52},{-54,-52},{-54,-44},{-22,-44},{-22,24.72},
                {-14,24.72}}, color={191,0,0}));
        connect(wholeHouseBuildingEnvelope.groFloUp[dis+i], underfloorHeatingSystem.heatCeiling[6*dis+i])
          annotation (Line(points={{-14,18},{-18,18},{-18,-30},{-4,-30},{-4,-70},{-44,
                -70},{-44,-66},{-56,-66}}, color={191,0,0}));
        connect(underfloorHeatingSystem.heatFloor[7*dis+i], wholeHouseBuildingEnvelope.uppFloDown[2*dis+i])
          annotation (Line(points={{-56,-52},{-54,-52},{-54,-44},{-22,-44},{-22,24.72},
                {-14,24.72}}, color={191,0,0}));
        connect(wholeHouseBuildingEnvelope.groFloUp[2*dis+i], underfloorHeatingSystem.heatCeiling[7*dis+i])
          annotation (Line(points={{-14,18},{-18,18},{-18,-30},{-4,-30},{-4,-70},{-44,
                -70},{-44,-66},{-56,-66}}, color={191,0,0}));
        connect(underfloorHeatingSystem.heatFloor[8*dis+i], wholeHouseBuildingEnvelope.uppFloDown[3*dis+i])
          annotation (Line(points={{-56,-52},{-54,-52},{-54,-44},{-22,-44},{-22,24.72},
                {-14,24.72}}, color={191,0,0}));
        connect(wholeHouseBuildingEnvelope.groFloUp[3*dis+i], underfloorHeatingSystem.heatCeiling[8*dis+i])
          annotation (Line(points={{-14,18},{-18,18},{-18,-30},{-4,-30},{-4,-70},{-44,
                -70},{-44,-66},{-56,-66}}, color={191,0,0}));
        connect(underfloorHeatingSystem.heatFloor[9*dis+i], wholeHouseBuildingEnvelope.uppFloDown[4*dis+i])
          annotation (Line(points={{-56,-52},{-54,-52},{-54,-44},{-22,-44},{-22,24.72},
                {-14,24.72}}, color={191,0,0}));
        connect(wholeHouseBuildingEnvelope.groFloUp[4*dis+i], underfloorHeatingSystem.heatCeiling[9*dis+i])
          annotation (Line(points={{-14,18},{-18,18},{-18,-30},{-4,-30},{-4,-70},{-44,
                -70},{-44,-66},{-56,-66}}, color={191,0,0}));
                end for;
        connect(underfloorHeatingSystem.m_flowNominal, m_flow_specification1.m_flow_in)
          annotation (Line(points={{-68,-63.2},{-74,-63.2},{-74,-64},{-118,-64},{-118,
                -51.6},{-99.6,-51.6}}, color={0,0,127}));
        annotation (experiment(StartTime = 0, StopTime = 25920000, Interval=3600, Tolerance=1e-6, Algorithm="dassl"),
          __Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/ThermalZones/HighOrder/Examples/OFDHeatLoad.mos"
                            "Simulate and plot"),
          Diagram(graphics={
              Text(
                extent={{-112,26},{-74,4}},
                lineColor={28,108,200},
                textString="DIN EN 12831 Beiblatt 1
Table 8"),    Text(
                extent={{-94,-80},{-56,-102}},
                lineColor={28,108,200},
                textString="DIN EN 12831 Beiblatt 1
Table 1 \\theta'_m,e and see
Calculation example: Chapter 6.1.3.4"),
              Text(
                extent={{-112,90},{-74,68}},
                lineColor={28,108,200},
                textString="DIN EN 12831 Beiblatt 1
Table 1")}),       experiment(StopTime=25920000, Interval=3600),
          Documentation(revisions="<html><ul>
  <li>
    <i>August 1, 2017</i> by Philipp Mehrfeld:<br/>
    Implement example
  </li>
</ul>
</html>"));
      end OFD_UFH;

    end OFD;
  end Examples;
  annotation (
    conversion(from(version="", script="ConvertFromPanelHeatingNew_.mos")));
end UnderfloorHeating;
