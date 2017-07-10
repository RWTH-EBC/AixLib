within AixLib.Fluid.HeatExchangers;
package Utilities "Components needed for the Heat Exchangers"




  block HXcharacteristic "HX characteristics based on the VDI-Wärmeatlas"

    // constants
    parameter Modelica.SIunits.Area A "Heat transfer area";
    parameter Modelica.SIunits.CoefficientOfHeatTransfer k
      "Coefficient of heat transfer";

     //dimensionless key figures based on the "VDI-Wärmeatlas"
     Real R1(min=0, max=1, nominal=0.5) "mass flow heat capacity ratio for medium 1";
     Real R2(min=0, max=1, nominal=0.5) "mass flow heat capacity ratio for medium 2";
     Real NTU_1(min=0) "Number of transfer units";
     Real NTU_2(min=0) "Number of transfer units";

    Modelica.Blocks.Interfaces.RealInput mFlow1(
    min=0,
    max=50,
    nominal=17.5,
    quantity="MassFlowRate",
    unit="kg/s") " Mass flow rate in the first circuit" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-60,100})));
    Modelica.Blocks.Interfaces.RealInput mFlow2(
    min=0,
    max=50,
    nominal=17.5,
    quantity="MassFlowRate",
    unit="kg/s") " Mass flow rate in the second circuit" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={60,100})));
    Modelica.Blocks.Interfaces.RealOutput P1(min=0, max=1, nominal=0.5)
      "Effectiveness medium 1 based on the VDI-Wärmeatlas"  annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-40,-100})));
    Modelica.Blocks.Interfaces.RealOutput P2(min=0, max=1, nominal=0.5)
      "Effectiveness medium 2 based on the VDI-Wärmeatlas"  annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={40,-100})));
    Modelica.Blocks.Interfaces.RealInput cP1(
    min=1,
    max=5000,
    nominal=4000,
    quantity="SpecificHeatCapacity",
    unit="J/(kg.K)") "Constant specific heat capacity of the first medium"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-20,100})));
    Modelica.Blocks.Interfaces.RealInput cP2(
    min=1,
    max=5000,
    nominal=4000,
    quantity="SpecificHeatCapacity",
    unit="J/(kg.K)") "Constant specific heat capacity of the second medium"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={20,100})));
  equation
      R1=if (cP2 == 0 or mFlow2 == 0) then 0 else (cP1*mFlow1)/(cP2*mFlow2);
      R2=if (cP1 == 0 or mFlow1 == 0) then 0 else (cP2*mFlow2)/(cP1*mFlow1);
      NTU_1=if (cP1 == 0 or mFlow1 == 0) then 0 else (k*A)/(cP1*mFlow1);
      NTU_2=if (cP2 == 0 or mFlow2 == 0) then 0 else (k*A)/(cP2*mFlow2);
       P1 = if R1<1.0 then (1-exp((R1-1)*NTU_1))/(1-R1*exp((R1-1)*NTU_1)) else NTU_1/(1+NTU_1);
       P2 = if R2<1.0 then (1-exp((R2-1)*NTU_2))/(1-R2*exp((R2-1)*NTU_2)) else NTU_2/(1+NTU_2);

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
<ul>
<li><i>2017-04-25</i> by Peter Matthes:<br>Removes P_Output variables. Adds bounds to P1 and P2. Adds units to inputs. Changes comparison for Rx&LT;&GT;1.0 into Rx&LT;1.0<br>Even though there are checks for singular conditions in this model it will still be a problem when the variables aproach those values. Variables will most likely not be continuous in those points.</li>
<li><i>March 2013&nbsp;</i> by Thomas Dixius (supervised by Marcus Fuchs):<br>implemented</li>
</ul>
</html>"));
  end HXcharacteristic;

  block TempCalcOutflow "Temperature detection for Heat Transfer"

    Modelica.Blocks.Math.Add T2_return(k1=+1, u1(
        min=253.15,
        max=323.15,
        nominal=278.15,
        quantity="ThermodynamicTemperature",
        unit="K",
        displayUnit="degC")) "y = T2_in + y(prod3)" annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={80,-50})));
    Modelica.Blocks.Math.Add T1_return(k1=-1, u2(
        min=253.15,
        max=323.15,
        nominal=278.15,
        quantity="ThermodynamicTemperature",
        unit="K",
        displayUnit="degC")) "y = - y(prod4) +  T1_in"
                                                 annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-80,-50})));
    Modelica.Blocks.Math.Product prod4(u1(
      quantity="ThermodynamicTemperature",
      unit="K",
      displayUnit="degC"))
      "y = Delta_T * P1(effectiveness)"
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-40,-16})));
    Modelica.Blocks.Math.Product prod3(u2(
      quantity="ThermodynamicTemperature",
      unit="K",
      displayUnit="degC"))
      "y =P2(effectiveness) * Delta_T"
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
    Utilities.HXcharacteristic effectiveness(A=140, k=4000)
      annotation (Placement(transformation(extent={{-10,46},{10,66}})));
    Modelica.Blocks.Interfaces.RealInput T2_in(
      min=253.15,
      max=323.15,
      nominal=303.15,
      quantity="ThermodynamicTemperature",
      unit="K",
      displayUnit="degC") annotation (Placement(transformation(
          rotation=-90,
          extent={{-10,-10},{10,10}},
          origin={80,100})));
    Modelica.Blocks.Interfaces.RealInput T1_in(
      min=253.15,
      max=323.15,
      nominal=278.15,
      quantity="ThermodynamicTemperature",
      unit="K",
      displayUnit="degC") annotation (Placement(transformation(
          rotation=-90,
          extent={{-10,-10},{10,10}},
          origin={-80,100})));
    Modelica.Blocks.Interfaces.RealOutput T2_out(
      min=253.15,
      max=323.15,
      nominal=278.15,
      quantity="ThermodynamicTemperature",
      unit="K",
      displayUnit="degC") annotation (Placement(transformation(
          rotation=-90,
          extent={{-10,-10},{10,10}},
          origin={80,-100})));
    Modelica.Blocks.Interfaces.RealOutput T1_out(
      min=253.15,
      max=323.15,
      nominal=303.15,
      quantity="ThermodynamicTemperature",
      unit="K",
      displayUnit="degC") annotation (Placement(transformation(
          rotation=-90,
          extent={{-10,-10},{10,10}},
          origin={-80,-100})));
    Modelica.Blocks.Interfaces.RealInput cP1(
      min=1,
      max=5000,
      nominal=4000,
      quantity="SpecificHeatCapacity",
      unit="J/(kg.K)") annotation (Placement(transformation(
          rotation=-90,
          extent={{-10,-10},{10,10}},
          origin={-20,100})));
    Modelica.Blocks.Interfaces.RealInput cP2(
      min=1,
      max=5000,
      nominal=4000,
      quantity="SpecificHeatCapacity",
      unit="J/(kg.K)") annotation (Placement(transformation(
          rotation=-90,
          extent={{-10,-10},{10,10}},
          origin={20,100})));
    Modelica.Blocks.Interfaces.RealInput mFlow1(
      min=0,
      max=50,
      nominal=17.5,
      quantity="MassFlowRate",
      unit="kg/s") annotation (Placement(transformation(
          rotation=-90,
          extent={{-10,-10},{10,10}},
          origin={-40,100})));
    Modelica.Blocks.Interfaces.RealInput mFlow2(
      min=0,
      max=50,
      nominal=17.5,
      quantity="MassFlowRate",
      unit="kg/s") annotation (Placement(transformation(
          rotation=-90,
          extent={{-10,-10},{10,10}},
          origin={40,100})));
  equation
    connect(prod3.y, T2_return.u2)
      annotation (Line(points={{40,-27},{74,-27},{74,-38}}, color={0,0,127}));
    connect(prod4.y, T1_return.u1) annotation (Line(points={{-40,-27},{-40,-30},{-74,
            -30},{-74,-38}}, color={0,0,127}));
    connect(Delta_T.y, prod3.u2) annotation (Line(points={{-2.22045e-015,8.8},{-2.22045e-015,
            4.85},{34,4.85},{34,-4}}, color={0,0,127}));
    connect(Delta_T.y, prod4.u1) annotation (Line(points={{-2.22045e-015,8.8},{-2.22045e-015,
            4.85},{-34,4.85},{-34,-4}}, color={0,0,127}));
    connect(effectiveness.P2, prod3.u1)
      annotation (Line(points={{4,46},{4,42},{46,42},{46,-4}}, color={0,0,127}));
    connect(effectiveness.P1, prod4.u2) annotation (Line(points={{-4,46},{-4,42},
            {-46,42},{-46,-4}}, color={0,0,127}));
    connect(T2_in, Delta_T.u1) annotation (Line(points={{80,100},{80,100},{80,60},
            {20,60},{20,44},{7.2,44},{7.2,36.4}}, color={0,0,127}));
    connect(T1_in, Delta_T.u2) annotation (Line(points={{-80,100},{-80,100},{-80,60},
            {-20,60},{-20,44},{-7.2,44},{-7.2,40},{-7.2,36.4}}, color={0,0,127}));
    connect(T2_in, T2_return.u1) annotation (Line(points={{80,100},{80,60},{86,60},
            {86,-38}}, color={0,0,127}));
    connect(T2_out, T2_return.y)
      annotation (Line(points={{80,-100},{80,-84},{80,-61}}, color={0,0,127}));
    connect(T1_out, T1_return.y) annotation (Line(points={{-80,-100},{-80,-82},{-80,
            -61}}, color={0,0,127}));
  connect(cP1, effectiveness.cP1) annotation (Line(points={{-20,100},{-20,100},
          {-20,84},{-2,84},{-2,66}}, color={0,0,127}));
  connect(cP2, effectiveness.cP2) annotation (Line(points={{20,100},{20,84},{2,
          84},{2,66}}, color={0,0,127}));
  connect(mFlow1, effectiveness.mFlow1) annotation (Line(points={{-40,100},{-40,
          100},{-40,72},{-38,72},{-6,72},{-6,66}}, color={0,0,127}));
  connect(mFlow2, effectiveness.mFlow2) annotation (Line(points={{40,100},{40,
          100},{40,84},{40,72},{6,72},{6,66}}, color={0,0,127}));
    connect(T1_in, T1_return.u2) annotation (Line(points={{-80,100},{-80,100},{-80,
            14},{-80,0},{-86,0},{-86,-38}}, color={0,0,127}));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}})), Documentation(revisions="<html>
<ul>
<li><i>2017-04-25</i> by Peter Matthes:<br>Renames inputs and outputs. Adds units to inputs and outputs. Changes &QUOT;model&QUOT; into &QUOT;block&QUOT;.</li>
</ul>
</html>"));
  end TempCalcOutflow;
end Utilities;
