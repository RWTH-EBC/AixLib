within AixLib.Fluid.HeatExchangers.Utilities;
block Inputs4toOutputs2 "Model with 4 Inputs resulting in 2 Outputs"

  // constants
  parameter Modelica.SIunits.Area A "Heat transfer area";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer k
    "Coefficient of heat transfer";

   //dimensionless key figures based on the "VDI-Wärmeatlas"
   Real R1(min=0, max=1, nominal=0.5) "mass flow heat capacity ratio for medium 1";
   Real R2(min=0, max=1, nominal=0.5) "mass flow heat capacity ratio for medium 2";
   Real NTU_1(min=0) "Number of transfer units";
   Real NTU_2(min=0) "Number of transfer units";

  Modelica.Blocks.Interfaces.RealInput m_flow_DH(
    min=0,
    max=50,
    nominal=17.5,
    quantity="MassFlowRate",
    unit="kg/s")
    " Mass flow rate in the district heating circuit" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-60,100})));
  Modelica.Blocks.Interfaces.RealInput m_flow_HS(
    min=0,
    max=50,
    nominal=17.5,
    quantity="MassFlowRate",
    unit="kg/s")
    " Mass flow rate in the heating system" annotation (Placement(
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
  Modelica.Blocks.Interfaces.RealInput cp_DH(
    min=1,
    max=5000,
    nominal=4000,
    quantity="SpecificHeatCapacity",
    unit="J/(kg.K)")
    "Constant specific heat capacity of the district heating medium"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-20,100})));
  Modelica.Blocks.Interfaces.RealInput cp_HS(
    min=1,
    max=5000,
    nominal=4000,
    quantity="SpecificHeatCapacity",
    unit="J/(kg.K)")
    "Constant specific heat capacity of the heating system medium" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={20,100})));
equation
    R1=if (cp_HS == 0 or m_flow_HS == 0) then 0 else (cp_DH*m_flow_DH)/(cp_HS*
    m_flow_HS);
    R2=if (cp_DH == 0 or m_flow_DH == 0) then 0 else (cp_HS*m_flow_HS)/(cp_DH*
    m_flow_DH);
    NTU_1=if (cp_DH == 0 or m_flow_DH == 0) then 0 else (k*A)/(cp_DH*m_flow_DH);
    NTU_2=if (cp_HS == 0 or m_flow_HS == 0) then 0 else (k*A)/(cp_HS*m_flow_HS);
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
end Inputs4toOutputs2;
