within AixLib.Fluid.HeatExchangers;
package Utilities "Components needed for the Heat Exchangers"
  model cP_HS
    "Calculation of the fluid's specific heat capacity in the warm circuit"
    Modelica.Blocks.Math.Add dh_cp_HS(
      k1=+1,
      k2=-1,
      u1(
        min=1,
        max=5000,
        nominal=4000),
      u2(
        min=1,
        max=5000,
        nominal=4000)) "h_out-h_in"
      annotation (Placement(transformation(extent={{58,34},{46,46}})));
    Modelica.Blocks.Math.Add dT_cp_HS(
      k1=+1,
      k2=-1,
      u1(
        min=253.15,
        max=323.15,
        nominal=293.15),
      u2(
        min=253.15,
        max=323.15,
        nominal=278.15)) "T_out-T_in"
      annotation (Placement(transformation(extent={{56,-46},{44,-34}})));
    Modelica.Blocks.Math.Division division_cp_HS(
      u1(
        min=-5000,
        max=5000,
        nominal=4000),
      u2(
        min=0.1,
        max=50,
        nominal=20),
      y(min=1,
        max=5000,
        nominal=4000)) "cp = dh/dT"
      annotation (Placement(transformation(extent={{-26,-10},{-46,10}})));
    Modelica.Blocks.Interfaces.RealInput u1(
      min=253.15,
      max=323.15,
      nominal=293.15) annotation (Placement(transformation(rotation=0, extent={{
              110,-30},{90,-10}})));
    Modelica.Blocks.Interfaces.RealInput u2(
      min=253.15,
      max=323.15,
      nominal=278.15) annotation (Placement(transformation(rotation=0, extent={{
              110,-70},{90,-50}})));
    Modelica.Blocks.Interfaces.RealInput u3(
      min=1,
      max=5000,
      nominal=4000) annotation (Placement(transformation(rotation=0, extent={{110,
              50},{90,70}})));
    Modelica.Blocks.Interfaces.RealInput u4(
      min=1,
      max=5000,
      nominal=4000) annotation (Placement(transformation(rotation=0, extent={{110,
              10},{90,30}})));
    Modelica.Blocks.Interfaces.RealOutput y(
      min=1,
      max=5000,
      nominal=4000) annotation (Placement(transformation(rotation=0, extent={{-90,
              -10},{-110,10}})));
  equation
    connect(dh_cp_HS.y, division_cp_HS.u1) annotation (Line(points={{45.4,40},{16,
            40},{16,6},{-24,6}},           color={0,0,127}));
    connect(u1, dT_cp_HS.u1) annotation (Line(points={{100,-20},{100,-20},{78,-20},
            {78,-20},{78,-36.4},{68,-36.4},{57.2,-36.4}}, color={0,0,127}));
    connect(u2, dT_cp_HS.u2) annotation (Line(points={{100,-60},{98,-60},{77.2,
            -60},{77.2,-43.6},{57.2,-43.6}}, color={0,0,127}));
    connect(u3, dh_cp_HS.u1) annotation (Line(points={{100,60},{90,60},{69.2,60},
            {69.2,43.6},{59.2,43.6}}, color={0,0,127}));
    connect(u4, dh_cp_HS.u2) annotation (Line(points={{100,20},{100,20},{80,20},{
            69.2,20},{69.2,36.4},{59.2,36.4}}, color={0,0,127}));
    connect(y, division_cp_HS.y)
      annotation (Line(points={{-100,0},{-47,0}}, color={0,0,127}));
    connect(dT_cp_HS.y, division_cp_HS.u2) annotation (Line(
        points={{43.4,-40},{10,-40},{10,-6},{-24,-6}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (                                 Diagram(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
          graphics));
  end cP_HS;

  model cP_DH
    "Calculation of the fluid's specific heat capacity in the cold circuit"
    Modelica.Blocks.Math.Add dh_cp_DH(
      k1=+1,
      k2=-1,
      u1(
        min=1,
        max=5000,
        nominal=4000),
      u2(
        min=1,
        max=5000,
        nominal=4000)) "h_out-h_in"
      annotation (Placement(transformation(extent={{-50,30},{-30,50}})));
    Modelica.Blocks.Math.Add dT_cp_DH(
      k1=+1,
      k2=-1,
      u1(
        min=253.15,
        max=323.15,
        nominal=293.15),
      u2(
        min=253.15,
        max=323.15,
        nominal=278.15)) "T_out-T_in"
      annotation (Placement(transformation(extent={{-78,-52},{-58,-32}})));
    Modelica.Blocks.Math.Division division_cp_DH(
      u1(
        min=-5000,
        max=5000,
        nominal=4000),
      u2(
        min=0.1,
        max=50,
        nominal=20),
      y(min=1,
        max=5000,
        nominal=4000)) "cp = dh/dT"
      annotation (Placement(transformation(extent={{12,-10},{32,10}})));
    Modelica.Blocks.Interfaces.RealInput u1(
      min=253.15,
      max=323.15,
      nominal=293.15) annotation (Placement(transformation(rotation=0, extent={{
              -110,-30},{-90,-10}})));
    Modelica.Blocks.Interfaces.RealInput u2(
      min=253.15,
      max=323.15,
      nominal=278.15) annotation (Placement(transformation(rotation=0, extent={{
              -110,-70},{-90,-50}})));
    Modelica.Blocks.Interfaces.RealInput u3(
      min=1,
      max=5000,
      nominal=4000) annotation (Placement(transformation(rotation=0, extent={{
              -110,50},{-90,70}})));
    Modelica.Blocks.Interfaces.RealInput u4(
      min=1,
      max=5000,
      nominal=4000) annotation (Placement(transformation(rotation=0, extent={{
              -110,10},{-90,30}})));
    Modelica.Blocks.Interfaces.RealOutput y(
      min=1,
      max=5000,
      nominal=4000) annotation (Placement(transformation(rotation=0, extent={{90,
              -10},{110,10}})));
    Modelica.Blocks.Logical.Switch switch1
      annotation (Placement(transformation(extent={{54,-68},{74,-48}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=1)
      annotation (Placement(transformation(extent={{14,-58},{34,-38}})));
    Modelica.Blocks.Sources.Clock clock
      annotation (Placement(transformation(extent={{-34,-64},{-24,-54}})));
    Modelica.Blocks.Logical.Less less
      annotation (Placement(transformation(extent={{-2,-70},{12,-54}})));
    Modelica.Blocks.Sources.RealExpression realExpression3(y=150)
      annotation (Placement(transformation(extent={{-42,-64},{-22,-84}})));
  equation
    connect(dh_cp_DH.y, division_cp_DH.u1) annotation (Line(points={{-29,40},{-16,
            40},{-16,6},{10,6}},              color={0,0,127}));
    connect(u1, dT_cp_DH.u1) annotation (Line(points={{-100,-20},{-100,-20.4},
            {-80,-20.4},{-80,-36}},color={0,0,127}));
    connect(u2, dT_cp_DH.u2) annotation (Line(points={{-100,-60},{-100,-61.6},
            {-80,-61.6},{-80,-48}},color={0,0,127}));
    connect(u3, dh_cp_DH.u1)
      annotation (Line(points={{-100,60},{-52,60},{-52,46}}, color={0,0,127}));
    connect(u4, dh_cp_DH.u2) annotation (Line(points={{-100,20},{-80,20},{-80,34},
            {-52,34}}, color={0,0,127}));
    connect(y, division_cp_DH.y)
      annotation (Line(points={{100,0},{62,0},{33,0}}, color={0,0,127}));
    connect(realExpression.y,switch1. u1) annotation (Line(points={{35,-48},{
            44,-48},{44,-50},{52,-50}}, color={0,0,127}));
    connect(switch1.y, division_cp_DH.u2) annotation (Line(points={{75,-58},{
            80,-58},{80,-22},{-12,-22},{-12,-6},{10,-6}}, color={0,0,127}));
    connect(clock.y, less.u1) annotation (Line(
        points={{-23.5,-59},{-13.75,-59},{-13.75,-62},{-3.4,-62}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(realExpression3.y, less.u2) annotation (Line(
        points={{-21,-74},{-14,-74},{-14,-68.4},{-3.4,-68.4}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(less.y, switch1.u2) annotation (Line(
        points={{12.7,-62},{32,-62},{32,-58},{52,-58}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(dT_cp_DH.y, switch1.u3) annotation (Line(
        points={{-57,-42},{-54,-42},{-54,-90},{42,-90},{42,-66},{52,-66}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (                                 Diagram(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
          graphics));
  end cP_DH;

  model Heat_Transfer
    "Calculation of the heat which is transported in the plate heat exchanger"

    Utilities.Temperature_detection temperature_detection
      annotation (Placement(transformation(rotation=0, extent={{-10,46},{10,66}})));
    Modelica.Blocks.Math.Add add2(k2=-1, u2(
        min=253.15,
        max=323.15,
        nominal=278.15)) "y = T_Return_DH - T_DH_in" annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-46,20})));
    Modelica.Blocks.Math.Add add1(
      k1=-1,
      k2=+1,
      u1(
        min=253.15,
        max=323.15,
        nominal=278.15)) "y = - T_HS_in + T_Forward_HS" annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={46,20})));
    Modelica.Blocks.Math.Product product1(u1(
        min=0,
        max=50,
        nominal=17.5), u2(
        min=1,
        max=5000,
        nominal=4000)) "y = m_flow_HS * cp_HS " annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={20,-10})));
    Modelica.Blocks.Math.Product product2(u1(
        min=1,
        max=5000,
        nominal=4000), u2(
        min=0,
        max=50,
        nominal=17.5)) "y = cp_DH *  m_flow_DH" annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-20,-10})));
    Modelica.Blocks.Math.Product productQsink "Qsink" annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-40,-50})));
    Modelica.Blocks.Math.Product productQsource "Qsource" annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={40,-50})));
    Modelica.Blocks.Interfaces.RealInput u1(
      min=253.15,
      max=323.15,
      nominal=278.15) annotation (Placement(transformation(
          rotation=-90,
          extent={{-10,-10},{10,10}},
          origin={80,100})));
    Modelica.Blocks.Interfaces.RealInput u2(
      min=253.15,
      max=323.15,
      nominal=278.15) annotation (Placement(transformation(
          rotation=-90,
          extent={{-10,-10},{10,10}},
          origin={-80,100})));
    Modelica.Blocks.Interfaces.RealInput u3(
      min=0,
      max=50,
      nominal=17.5) annotation (Placement(transformation(
          rotation=-90,
          extent={{-10,-10},{10,10}},
          origin={20,100})));
    Modelica.Blocks.Interfaces.RealInput u4(
      min=1,
      max=5000,
      nominal=4000) annotation (Placement(transformation(
          rotation=-90,
          extent={{-10,-10},{10,10}},
          origin={40,100})));
    Modelica.Blocks.Interfaces.RealInput u5(
      min=1,
      max=5000,
      nominal=4000) annotation (Placement(transformation(
          rotation=-90,
          extent={{-10,-10},{10,10}},
          origin={-40,100})));
    Modelica.Blocks.Interfaces.RealInput u6(
      min=0,
      max=50,
      nominal=17.5) annotation (Placement(transformation(
          rotation=-90,
          extent={{-10,-10},{10,10}},
          origin={-20,100})));
    Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(transformation(
          rotation=-90,
          extent={{-10,-10},{10,10}},
          origin={-40,-100})));
    Modelica.Blocks.Interfaces.RealOutput y1 annotation (Placement(transformation(
          rotation=-90,
          extent={{-10,-10},{10,10}},
          origin={40,-100})));
  equation
    connect(product1.y, productQsource.u2) annotation (Line(points={{20,-21},{20,
            -28.25},{34,-28.25},{34,-38}},
                               color={0,0,127}));
    connect(product2.y, productQsink.u1) annotation (Line(points={{-20,-21},{-20,
            -28.25},{-34,-28.25},{-34,-38}},
                                 color={0,0,127}));
    connect(add1.y, productQsource.u1) annotation (Line(points={{46,9},{46,2},{46,
            -38}},               color={0,0,127}));
    connect(add2.y, productQsink.u2) annotation (Line(points={{-46,9},{-46,9},{
            -46,-28},{-46,-38}},         color={0,0,127}));
    connect(temperature_detection.y,
                           add1. u2) annotation (Line(points={{8,46},{8,40},{40,
            40},{40,32}}, color={0,0,127}));
    connect(temperature_detection.y1,
                           add2.u1) annotation (Line(points={{-8,46},{-8,40},{-40,
            40},{-40,32}}, color={0,0,127}));
    connect(u1, add1.u1) annotation (Line(points={{80,100},{80,100},{80,50},{80,
            40},{52,40},{52,32}}, color={0,0,127}));
    connect(u2, add2.u2) annotation (Line(points={{-80,100},{-80,100},{-80,48},{
            -80,40},{-52,40},{-52,38},{-52,38},{-52,32},{-52,32}}, color={0,0,127}));
    connect(u3, product1.u1) annotation (Line(points={{20,100},{20,100},{20,94},{
            20,80},{26,80},{26,2}}, color={0,0,127}));
    connect(u4, product1.u2) annotation (Line(points={{40,100},{40,100},{40,56},{
            14,56},{14,54},{14,2}}, color={0,0,127}));
    connect(u5, product2.u1) annotation (Line(points={{-40,100},{-40,100},{-40,56},
            {-38,56},{-14,56},{-14,2}}, color={0,0,127}));
    connect(u6, product2.u2) annotation (Line(points={{-20,100},{-20,100},{-20,80},
            {-26,80},{-26,46},{-26,2}}, color={0,0,127}));
    connect(y, productQsink.y)
      annotation (Line(points={{-40,-100},{-40,-61}}, color={0,0,127}));
    connect(y1, productQsource.y)
      annotation (Line(points={{40,-100},{40,-61}}, color={0,0,127}));
    connect(u6, temperature_detection.C_P_DH) annotation (Line(points={{-20,100},
            {-20,100},{-20,92},{-20,80},{-2,80},{-2,66}}, color={0,0,127}));
    connect(u3, temperature_detection.C_P_HS) annotation (Line(points={{20,100},{
            20,100},{20,94},{20,96},{20,80},{2,80},{2,66}}, color={0,0,127}));
    connect(u5, temperature_detection.MassFlowRate_DH) annotation (Line(points={{
            -40,100},{-40,100},{-40,76},{-14,76},{-4,76},{-4,66}}, color={0,0,127}));
    connect(u4, temperature_detection.MassFlowRate_HS) annotation (Line(points={{
            40,100},{40,100},{40,76},{4,76},{4,66}}, color={0,0,127}));
    connect(u1, temperature_detection.u1) annotation (Line(points={{80,100},{80,
            100},{80,96},{80,80},{80,80},{80,80},{80,70},{8,70},{8,68},{8,66}},
          color={0,0,127}));
    connect(u2, temperature_detection.u2) annotation (Line(points={{-80,100},{-80,
            100},{-80,70},{-44,70},{-8,70},{-8,66}}, color={0,0,127}));
    annotation (                                 Diagram(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
  end Heat_Transfer;

  model Inputs4toOutputs2 "Model with 4 Inputs resulting in 2 Outputs"

    // constants
    parameter Modelica.SIunits.Area A "Heat transfer area";
    parameter Modelica.SIunits.CoefficientOfHeatTransfer k
      "Coefficient of heat transfer";

     //dimensionless key figures based on the "VDI-Wärmeatlas"
     Real R1 "heat capacity ratio";
     Real R2 "heat capacity ratio";
     Real NTU_1 "Number of transfer units";
     Real NTU_2 "Number of transfer units";
     Real P1 "Effectiveness of a counterflow plate heat exchanger";
     Real P2 "Effectiveness of a counterflow plate heat exchanger";

    Modelica.Blocks.Interfaces.RealInput MassFlowRate_DH
      " Mass flow rate in the district heating circuit"               annotation (
       Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={-60,100})));
    Modelica.Blocks.Interfaces.RealInput MassFlowRate_HS
      " Mass flow rate in the heating system"                       annotation (
        Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={60,100})));
    Modelica.Blocks.Interfaces.RealOutput P1_Output
      "Effectiveness based on the VDI-Wärmeatlas"  annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-40,-100})));
    Modelica.Blocks.Interfaces.RealOutput P2_Output
      "Effectiveness based on the VDI-Wärmeatlas"  annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={40,-100})));
    Modelica.Blocks.Interfaces.RealInput C_P_DH
      "Constant specific heat capacity of the district heating medium"
                                             annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={-20,100})));
    Modelica.Blocks.Interfaces.RealInput C_P_HS
      "Constant specific heat capacity of the heating system medium"
                                             annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={20,100})));
  equation
      R1= if (C_P_HS == 0 or MassFlowRate_HS == 0) then 0 else (C_P_DH*MassFlowRate_DH)/(C_P_HS*MassFlowRate_HS);
      R2= if (C_P_DH == 0 or MassFlowRate_DH == 0) then 0 else (C_P_HS*MassFlowRate_HS)/(C_P_DH*MassFlowRate_DH);
      NTU_1= if (C_P_DH == 0 or MassFlowRate_DH == 0) then 0 else (k*A)/(C_P_DH*MassFlowRate_DH);
      NTU_2= if (C_P_HS == 0 or MassFlowRate_HS == 0) then 0 else (k*A)/(C_P_HS*MassFlowRate_HS);
       P1 = if R1<>1.0 then (1-exp((R1-1)*NTU_1))/(1-R1*exp((R1-1)*NTU_1)) else NTU_1/(1+NTU_1);
       P2 = if R1<>1.0 then (1-exp((R2-1)*NTU_2))/(1-R2*exp((R2-1)*NTU_2)) else NTU_2/(1+NTU_2);

     P1_Output=P1;
     P2_Output=P2;
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}})),  Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>This model determines the dimensionless key figures (for a counterflow heat exchanger) based on the VDI-W&auml;rmeatlas. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://HVAC/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>To determine these key figures, the heat transfer area A, the coefficient of heat transfer k, the specific heat capacity c_p and the mass flow rates of the district heating and the heating circuit are needed.</p>
<p>Following equations are used:</p>
<p><br><u>Heat capacity ratio:</u> </p>
<pre>R1=(C_P_DH*MassFlowRate_DH)/(C_P_HS*MassFlowRate_HS)
R2=(C_P_HS*MassFlowRate_HS)/(C_P_DH*MassFlowRate_DH)</pre>
<p><u>Number of transfer units:</u></p>
<pre>NTU_1=(k*A)/(C_P_DH*MassFlowRate_DH)
NTU_2=(k*A)/(C_P_HS*MassFlowRate_HS)

<u>Effectiveness:</u>
If R1=R2:
P1=NTU_1/(1+NTU_1)
P2=NTU_2/(1+NTU_2)
Else:
P1=(1-exp((R1-1)*NTU_1))/(1-R1*exp((R1-1)*NTU_1))
P2=(1-exp((R2-1)*NTU_2))/(1-R2*exp((R2-1)*NTU_2))

The output of this model is P1 and P2.</pre>
<p><br><h4><span style=\"color:#008000\">Known Limitations</span></h4></p>
<p>The mass flow rates of the primary and the secondary circuit must be higher than zero.</p>
<p><br><h4><span style=\"color:#008000\">References</span></h4></p>
<p>The dimensionless key figures are based on the VDI W&auml;rmeatlas (VDI W&auml;rmeatlas, Springer 2006, Kapitel C). <code></p><p></code>See: <a href=\"modelica://Campus/Miscellaneous/SubStation/References/Chapter C.pdf\">SubStation.References.Chapter C</a></p>
<p>For more detailed information see bachelor thesis &QUOT;Modelling and Simulation of a Heat Transfer Station for District Heating Grids&QUOT; by Thomas Dixius. </p>
</html>",
  revisions="<html>
<p><ul>
<li><i>March 2013&nbsp;</i> by Thomas Dixius (supervised by Marcus Fuchs):<br/>implemented</li>
</ul></p>
</html>"));
  end Inputs4toOutputs2;

  model Temperature_detection "Temperature detection for Heat Transfer"

    Modelica.Blocks.Math.Add T_Forward_HS(k1=+1, u1(
        min=253.15,
        max=323.15,
        nominal=278.15)) "y = T_HS_in * y(prod3)" annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={80,-50})));
    Modelica.Blocks.Math.Add T_Return_DH(k1=-1, u2(
        min=253.15,
        max=323.15,
        nominal=278.15)) "y = y(prod4) *  T_DH_in" annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-80,-50})));
    Modelica.Blocks.Math.Product prod4 "y = Delta_T * P1(effectiveness)"
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-40,-16})));
    Modelica.Blocks.Math.Product prod3 "y =P2(effectiveness) * Delta_T"
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={40,-16})));
    Modelica.Blocks.Math.Add Delta_T(
      k1=-1,
      u1(
        min=253.15,
        max=323.15,
        nominal=278.15),
      u2(
        min=253.15,
        max=323.15,
        nominal=278.15)) "Delta_T = - T_HS_in + T_DH_in" annotation (Placement(
          transformation(
          extent={{-12,-12},{12,12}},
          rotation=270,
          origin={0,22})));
    Utilities.Inputs4toOutputs2 effectiveness(A=140, k=4000)
      annotation (Placement(transformation(extent={{-10,46},{10,66}})));
    Modelica.Blocks.Interfaces.RealInput u1(
      min=253.15,
      max=323.15,
      nominal=278.15) annotation (Placement(transformation(
          rotation=-90,
          extent={{-10,-10},{10,10}},
          origin={80,100})));
    Modelica.Blocks.Interfaces.RealInput u2(
      min=253.15,
      max=323.15,
      nominal=278.15) annotation (Placement(transformation(
          rotation=-90,
          extent={{-10,-10},{10,10}},
          origin={-80,100})));
    Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(transformation(
          rotation=-90,
          extent={{-10,-10},{10,10}},
          origin={80,-100})));
    Modelica.Blocks.Interfaces.RealOutput y1 annotation (Placement(transformation(
          rotation=-90,
          extent={{-10,-10},{10,10}},
          origin={-80,-100})));
    Modelica.Blocks.Interfaces.RealInput C_P_DH annotation (Placement(
          transformation(
          rotation=-90,
          extent={{-10,-10},{10,10}},
          origin={-20,100})));
    Modelica.Blocks.Interfaces.RealInput C_P_HS annotation (Placement(
          transformation(
          rotation=-90,
          extent={{-10,-10},{10,10}},
          origin={20,100})));
    Modelica.Blocks.Interfaces.RealInput MassFlowRate_DH annotation (Placement(
          transformation(
          rotation=-90,
          extent={{-10,-10},{10,10}},
          origin={-40,100})));
    Modelica.Blocks.Interfaces.RealInput MassFlowRate_HS annotation (Placement(
          transformation(
          rotation=-90,
          extent={{-10,-10},{10,10}},
          origin={40,100})));
  equation
    connect(prod3.y, T_Forward_HS.u2) annotation (Line(points={{40,-27},{74,-27},
            {74,-38}},   color={0,0,127}));
    connect(prod4.y, T_Return_DH.u1) annotation (Line(points={{-40,-27},{-40,-30},
            {-74,-30},{-74,-38}},
                              color={0,0,127}));
    connect(Delta_T.y, prod3.u2) annotation (Line(points={{-2.22045e-015,8.8},{
            -2.22045e-015,4.85},{34,4.85},{34,-4}},
                                color={0,0,127}));
    connect(Delta_T.y, prod4.u1) annotation (Line(points={{-2.22045e-015,8.8},{
            -2.22045e-015,4.85},{-34,4.85},{-34,-4}},
                                 color={0,0,127}));
    connect(effectiveness.P2_Output, prod3.u1) annotation (Line(points={{4,46},{4,
            42},{46,42},{46,-4}},               color={0,0,127}));
    connect(effectiveness.P1_Output, prod4.u2) annotation (Line(points={{-4,46},{
            -4,42},{-46,42},{-46,-4}},             color={0,0,127}));
    connect(u1, Delta_T.u1) annotation (Line(points={{80,100},{80,100},{80,60},{
            20,60},{20,44},{7.2,44},{7.2,36.4}}, color={0,0,127}));
    connect(u2, Delta_T.u2) annotation (Line(points={{-80,100},{-80,100},{-80,60},
            {-20,60},{-20,44},{-7.2,44},{-7.2,40},{-7.2,36.4}}, color={0,0,127}));
    connect(u1, T_Forward_HS.u1) annotation (Line(points={{80,100},{80,60},{86,60},
            {86,-38}}, color={0,0,127}));
    connect(y, T_Forward_HS.y)
      annotation (Line(points={{80,-100},{80,-84},{80,-61}}, color={0,0,127}));
    connect(u2, T_Return_DH.u2) annotation (Line(points={{-80,100},{-80,100},{-80,
            82},{-80,82},{-80,22},{-86,22},{-86,-38}}, color={0,0,127}));
    connect(y1, T_Return_DH.y) annotation (Line(points={{-80,-100},{-80,-82},{-80,
            -61}}, color={0,0,127}));
    connect(C_P_DH, effectiveness.C_P_DH) annotation (Line(points={{-20,100},{-20,
            100},{-20,84},{-2,84},{-2,66},{-2,66}}, color={0,0,127}));
    connect(C_P_HS, effectiveness.C_P_HS) annotation (Line(points={{20,100},{20,
            84},{2,84},{2,66}}, color={0,0,127}));
    connect(MassFlowRate_DH, effectiveness.MassFlowRate_DH) annotation (Line(
          points={{-40,100},{-40,100},{-40,72},{-38,72},{-38,72},{-6,72},{-6,66},
            {-6,66}}, color={0,0,127}));
    connect(MassFlowRate_HS, effectiveness.MassFlowRate_HS) annotation (Line(
          points={{40,100},{40,100},{40,84},{40,72},{6,72},{6,66}}, color={0,0,
            127}));
    annotation (                                 Diagram(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
  end Temperature_detection;
end Utilities;
