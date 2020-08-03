within AixLib.DataBase.ThermalMachines.HeatPump;
package Functions "Functions for AixLib.Fluid.HeatPumps"
extends Modelica.Icons.Package;
  package Characteristics
    extends Modelica.Icons.Package;

    function ConstantCoP "Constant CoP and constant electric power"
      extends
        AixLib.DataBase.ThermalMachines.HeatPump.Functions.Characteristics.PartialBaseFct(
        N,
        T_con,
        T_eva,
        mFlow_eva,
        mFlow_con);
        parameter Modelica.SIunits.Power powerCompressor=2000
        "Constant electric power input for compressor";
        parameter Real CoP "Constant CoP";
    algorithm
      Char:= {powerCompressor,powerCompressor*CoP};

      annotation (Documentation(info="<html>
<p>Carnot CoP and constant electric power, no dependency on speed or mass flow rates!</p>
</html>",
        revisions="<html>
<ul>
<li><i>June 21, 2015&nbsp;</i> by Kristian Huchtemann:<br/>implemented</li>
</ul>
</html>
"));
    end ConstantCoP;

    function ConstantQualityGrade
      "Carnot CoP multiplied with constant quality grade and constant electric power"
      extends
        AixLib.DataBase.ThermalMachines.HeatPump.Functions.Characteristics.PartialBaseFct(
        N,
        T_con,
        T_eva,
        mFlow_eva,
        mFlow_con);
        parameter Real qualityGrade=0.3 "Constant quality grade";
        parameter Modelica.SIunits.Power P_com=2000
        "Constant electric power input for compressor";
    protected
        Real CoP_C "Carnot CoP";
    algorithm
      CoP_C:=T_con/(T_con - T_eva);
      Char:= {P_com,P_com*CoP_C*qualityGrade};

      annotation (Documentation(info="<html>
<p>Carnot CoP multiplied with constant quality grade and constant electric power, no dependency on speed or mass flow rates! </p>
</html>",
        revisions="<html>
<ul>
<li><i>June 21, 2015&nbsp;</i> by Kristian Huchtemann:<br/>implemented</li>
</ul>
</html>
"));
    end ConstantQualityGrade;

    partial function PartialBaseFct "Base class for Cycle Characteristic"
      extends Modelica.Icons.Function;
      input Real N "Relative compressor speed";
      input Real T_con "Condenser outlet temperature";
      input Real T_eva "Evaporator inlet temperature";
      input Real mFlow_eva "Mass flow rate at evaporator";
      input Real mFlow_con "Mass flow rate at condenser";
      output Real Char[2] "Array with [Pel, QCon]";

      annotation (Documentation(info="<html>
<p>Base funtion used in HeatPump model. It defines the inputs speed N (1/min), condenser outlet temperature T_co (K) and evaporator inlet temperature T_ev (K). The output is the vector Char: first value is compressor power, second value is the condenser heat flow rate. </p>
</html>",
        revisions="<html>
<ul>
<li><i>December 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
</ul>
</html>
"));
    end PartialBaseFct;

    function CarnotFunction
      "Function to emulate the polynomal approach of the Carnot_y heat pump model"
      extends PartialBaseFct;
      parameter Modelica.SIunits.Power Pel_nominal=2000
        "Constant nominal electric power";
      parameter Real etaCarnot_nominal(unit="1") = 0.5
          "Carnot effectiveness (=COP/COP_Carnot) used if use_eta_Carnot_nominal = true"
          annotation (Dialog(group="Efficiency", enable=use_eta_Carnot_nominal));

      parameter Real a[:] = {1}
        "Coefficients for efficiency curve (need p(a=a, yPL=1)=1)"
        annotation (Dialog(group="Efficiency"));
    protected
      Modelica.SIunits.Power Pel;
      Real COP;
      Real COP_carnot;
      Real etaPartLoad = AixLib.Utilities.Math.Functions.polynomial(a=a, x=N);
    algorithm
      assert(abs(T_con - T_eva)>Modelica.Constants.eps, "Temperatures have to differ to calculate the Carnot efficiency", AssertionLevel.warning);
      COP_carnot :=T_con/(T_con - T_eva);
      Pel :=Pel_nominal*N;
      COP :=etaCarnot_nominal*etaPartLoad*COP_carnot;
      Char[1] :=Pel;
      Char[2] :=COP*Pel;
      annotation (Documentation(revisions="<html>
<ul>
<li>
<i>November 26, 2018&nbsp;</i> by Fabian Wüllhorst: <br/>
First implementation (see issue <a href=\"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
</li>
</ul>
</html>",     info="<html>
<p>This function emulated the the Carnot model (<a href=\"modelica://AixLib.Fluid.Chillers.BaseClasses.Carnot\">AixLib.Fluid.Chillers.BaseClasses.Carnot</a>). See this description for more info on assumptions etc.</p>
</html>"));
    end CarnotFunction;

    function PolynomalApproach
      "Function to emulate the polynomal approach of the TRNSYS Type 401 heat pump model"
      extends PartialBaseFct;
      parameter Modelica.SIunits.Power p[6] = {0,0,0,0,0,0}
        "Polynomal coefficient for the electrical power";
      parameter Modelica.SIunits.HeatFlowRate q[6] = {0,0,0,0,0,0}
        "Polynomal coefficient for the condenser heat flow";

    protected
      Real TEva_n = T_eva/273.15 + 1 "Normalized evaporator temperature";
      Real TCon_n = T_con/273.15 + 1 "Normalized condenser temperature";
    algorithm
      if N >= Modelica.Constants.eps then
        Char[1] := p[1] + p[2]*TEva_n + p[3]*TCon_n + p[4]*TCon_n*TEva_n + p[5]*TEva_n^2 + p[6]*TCon_n^2; //Pel
        Char[2] := q[1] + q[2]*TEva_n + q[3]*TCon_n + q[4]*TCon_n*TEva_n + q[5]*TEva_n^2 + q[6]*TCon_n^2; //QCon
      else //Maybe something better could be used such as smooth()
        Char[1] := 0;
        Char[2] := 0;
      end if;
      annotation (Documentation(revisions="<html>
<ul>
<li>
<i>November 26, 2018&nbsp;</i> by Fabian Wüllhorst: <br/>
First implementation (see issue <a href=\"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
</li>
</ul>
</html>",     info="<html>
<p>Based on the work of Afjej and Wetter, 1997 [1] and the TRNYS Type 401 heat pump model, this function uses a six-coefficient polynom to calculate the electrical power and the heat flow to the condenser. The coefficients are calculated based on the data in DIN EN 14511 with a minimization-problem in python using the root-mean-square-error.</p>
<p>The normalized input temperatures are calculated with the formular:</p>
<p align=\"center\"><i>T_n = (T/273.15) + 1</i></p>
<p>The coefficients for the polynomal functions are stored inside the record for heat pumps in <a href=\"modelica://AixLib.DataBase.HeatPump\">AixLib.DataBase.HeatPump</a>.</p>
<p>[1]: https://www.trnsys.de/download/en/ts_type_401_en.pdf</p>
</html>"));
    end PolynomalApproach;
  end Characteristics;

  package DefrostCorrection
     extends Modelica.Icons.Package;

    function NoModel "No model"
      extends
        AixLib.DataBase.ThermalMachines.HeatPump.Functions.DefrostCorrection.PartialBaseFct(
          T_eva);

    algorithm
    f_CoPicing:=1;

      annotation (Documentation(info="<html>
<p>No correction factor for icing/defrosting: f_cop_icing=1. </p>
</html>",
      revisions="<html>
<ul>
<li><i>December 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
</ul>
</html>"));
    end NoModel;

    partial function PartialBaseFct
      "Base class for correction model, icing and defrosting of evaporator"
      extends Modelica.Icons.Function;
      input Real T_eva;
      output Real f_CoPicing;
      annotation (Documentation(info="<html>
<p>Base funtion used in HeatPump model. Input is the evaporator inlet temperature, output is a CoP-correction factor f_cop_icing. </p>
</html>",
      revisions="<html>
<ul>
<li><i>December 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
</ul>
</html>"));
    end PartialBaseFct;

    function WetterAfjei1996
      "Correction of CoP (Icing, Defrost) according to Wetter,Afjei 1996"
      extends
        AixLib.DataBase.ThermalMachines.HeatPump.Functions.DefrostCorrection.PartialBaseFct(
          T_eva);

    parameter Real A=0.03;
    parameter Real B=-0.004;
    parameter Real C=0.1534;
    parameter Real D=0.8869;
    parameter Real E=26.06;
    protected
    Real factor;
    Real linear_term;
    Real gauss_curve;
    algorithm
    linear_term:=A + B*T_eva;
    gauss_curve:=C*Modelica.Math.exp(-(T_eva - D)*(T_eva - D)/E);
    if linear_term>0 then
      factor:=linear_term + gauss_curve;
    else
      factor:=gauss_curve;
    end if;
    f_CoPicing:=1-factor;
      annotation (Documentation(info="<html>
<p>Correction of CoP (Icing, Defrost) according to Wetter,Afjei 1996. </p>
</html>",
      revisions="<html>
<ul>
<li><i>December 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
</ul>
</html>"));
    end WetterAfjei1996;
  end DefrostCorrection;

  package IcingFactor "Package with functions to calculate current icing factor on evaporator"
    function BasicIcingApproach
      "A function which utilizes the outdoor air temperature and current heat flow from the evaporator"
      extends PartialBaseFct;
    algorithm
      //Just a placeholder for a future icing function
      iceFac :=1;

      annotation (Documentation(revisions="<html>
<ul>
<li>
<i>November 26, 2018&nbsp;</i> by Fabian Wüllhorst: <br/>
First implementation (see issue <a href=\"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
</li>
</ul>
</html>",     info="<html>
<p>This function can be used to implement a simple icing approach, e.g. based on outdoor air temperature or time based.</p>
</html>"));
    end BasicIcingApproach;

    partial function PartialBaseFct "Base function for all icing factor functions"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.ThermodynamicTemperature T_flow_ev "Evaporator supply temperature";
      input Modelica.SIunits.ThermodynamicTemperature T_ret_ev "Evaporator return temperature";
      input Modelica.SIunits.ThermodynamicTemperature T_oda "Outdoor air temperature";
      input Modelica.SIunits.MassFlowRate m_flow_ev "Mass flow rate at the evaporator";
      output Real iceFac(min=0, max=1) "Icing factor, normalized value between 0 and 1";

      annotation (Documentation(revisions="<html>
<ul>
<li>
<i>November 26, 2018&nbsp;</i> by Fabian Wüllhorst: <br/>
First implementation (see issue <a href=\"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
</li>
</ul>
</html>",     info="<html>
<p>Base function for calculation of the icing factor. The normalized value represents reduction of heat exchange as a result of icing of the evaporator.</p>
</html>"));
    end PartialBaseFct;

    function WetterAfjei1996
      "Correction of CoP (Icing, Defrost) according to Wetter,Afjei 1996"
      extends
        AixLib.DataBase.ThermalMachines.HeatPump.Functions.IcingFactor.PartialBaseFct;

    parameter Real A=0.03;
    parameter Real B=-0.004;
    parameter Real C=0.1534;
    parameter Real D=0.8869;
    parameter Real E=26.06;
    protected
    Real factor;
    Real linear_term;
    Real gauss_curve;
    algorithm
    linear_term:=A + B*T_flow_ev;
    gauss_curve:=C*Modelica.Math.exp(-(T_flow_ev - D)*(T_flow_ev - D)/E);
    if linear_term>0 then
      factor:=linear_term + gauss_curve;
    else
      factor:=gauss_curve;
    end if;
    iceFac:=1-factor;
      annotation (Documentation(info="<html>
<p>Correction of CoP (Icing, Defrost) according to Wetter,Afjei 1996.</p>
</html>",
      revisions="<html>
<ul>
<li>
<i>November 26, 2018&nbsp;</i> by Fabian Wüllhorst: <br/>
First implementation (see issue <a href=\"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
</li>
</ul>
</html>"));
    end WetterAfjei1996;
  annotation (Documentation(revisions="<html>
<ul>
<li>
<i>November 26, 2018&nbsp;</i> by Fabian Wüllhorst: <br/>
First implementation (see issue <a href=\"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
</li>
</ul>
</html>",   info="<html>
<p>This package contains functions for calculation of an icing factor used in <a href=\"modelica://AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.IcingBlock\">AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.IcingBlock</a>.</p>
</html>"));
  end IcingFactor;
end Functions;
