within AixLib.FastHVAC.Components.HeatGenerators;
package CHP

  model PEMFC
  parameter AixLib.FastHVAC.Media.BaseClasses.MediumSimple medium=
        AixLib.FastHVAC.Media.WaterSimple()
      "Standard flow charastics for water (heat capacity, density, thermal conductivity)"    annotation (choicesAllMatching);

     parameter
      Data.CHP.FuelcellPEM.BaseDataDefinition param=
        AixLib.FastHVAC.Data.CHP.FuelcellPEM.MorrisonPEMFC()
           "Record for PCM Parametrization"
      annotation (choicesAllMatching=true, Dialog(enable=
            EfficiencyByDatatable and CHPType == 2));

protected
    parameter Modelica.SIunits.Volume V_water = 3e-3;

public
    parameter Modelica.SIunits.Temperature T0 = Modelica.SIunits.Conversions.from_degC(40);
    parameter Modelica.SIunits.Time tauQ_start = 100;
    parameter Real dotP_pos = 0.61;
    parameter Real dotP_neg = 0.60;

  constant Real LHV(unit="J/mol")=802350 "Lower heating value [J/mol]";
  constant Real a = 5;

  Modelica.SIunits.Temperature T_win;
  Modelica.SIunits.Temperature T_wout;
  Modelica.SIunits.Power P_elDC;
  Modelica.SIunits.Power P_PCU;
  Modelica.SIunits.Power P_anc;
  Modelica.SIunits.HeatFlowRate dotQ_th;
  Modelica.SIunits.HeatFlowRate dotQ_loss;
  Modelica.SIunits.MolarFlowRate dotN_B;
  //Modelica.SIunits.MolarFlowRate dotN_L;
  Modelica.SIunits.Efficiency eta_el;
  Modelica.SIunits.Efficiency eta_PCU;

    Modelica.Blocks.Interfaces.RealInput u
      annotation (Placement(transformation(extent={{-120,54},{-80,94}})));
    Modelica.Blocks.Interfaces.BooleanInput OnOff
      annotation (Placement(transformation(extent={{-120,-40},{-80,0}})));
    Modelica.Blocks.Interfaces.BooleanInput Start
      annotation (Placement(transformation(extent={{-120,20},{-80,60}})));
    Modelica.Blocks.Interfaces.BooleanInput Stop
      annotation (Placement(transformation(extent={{-120,-6},{-80,34}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow varHeatFlow
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=90,
          origin={0,-58})));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor T_flow
      annotation (Placement(transformation(extent={{-52,-92},{-32,-72}})));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor T_return
      annotation (Placement(transformation(extent={{34,-92},{54,-72}})));
    AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate
      annotation (Placement(transformation(extent={{-86,-92},{-66,-72}})));
    AixLib.FastHVAC.BaseClasses.WorkingFluid workingFluid(
      medium=medium,
      T0=T0,
      m_fluid=V_water*medium.rho)
      annotation (Placement(transformation(extent={{-10,-92},{10,-72}})));
    AixLib.FastHVAC.Interfaces.EnthalpyPort_b enthalpyPort_b1
                                                      "Output connector"
      annotation (Placement(transformation(extent={{92,-92},{112,-72}})));
    AixLib.FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_a1
                                                      "Input connector"
      annotation (Placement(transformation(extent={{-116,-92},{-96,-72}})));
    Modelica.Blocks.Interfaces.RealOutput Capacity[3]
      "1=P_el 2=dotQ_th 3=dotE_fuel"
      annotation (Placement(transformation(extent={{100,56},{124,80}})));
    Modelica.Blocks.Interfaces.RealOutput Energy[3](unit="J") "1=W_el 2=Q_th 3=E_fuel"
      annotation (Placement(transformation(extent={{100,30},{124,54}})));
    Modelica.Blocks.Continuous.Integrator integrator[3]
      annotation (Placement(transformation(extent={{70,32},{90,52}})));
    Modelica.Blocks.Math.Gain P_demand(k=param.P_elRated)
      annotation (Placement(transformation(extent={{-66,66},{-50,82}})));
    Modelica.Blocks.Nonlinear.SlewRateLimiter dotP(Rising=dotP_pos, Falling=-
          dotP_neg)
      annotation (Placement(transformation(extent={{0,64},{20,84}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrderQ_start(T=tauQ_start)
      annotation (Placement(transformation(extent={{0,36},{20,56}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrderQ_startloss(T=tauQ_start)
      annotation (Placement(transformation(extent={{0,6},{20,26}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrderP(T=a)
      annotation (Placement(transformation(extent={{-66,-40},{-46,-20}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrderdotN_B(T=a)
      annotation (Placement(transformation(extent={{-66,-70},{-46,-50}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrderP_elDC(T=a)
      annotation (Placement(transformation(extent={{-36,-40},{-16,-20}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrderP_anc(T=a)
      annotation (Placement(transformation(extent={{-36,-70},{-16,-50}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrderP_PCU(T=a)
      annotation (Placement(transformation(extent={{-6,-40},{14,-20}})));
    //Modelica.Blocks.Continuous.FirstOrder firstOrderdotN_L(T=a)
  equation

    T_win = T_flow.T;
    T_wout = T_return.T;
    eta_el = param.eta_0 + param.eta_1*P_elDC + param.eta_2*P_elDC^2;
    eta_PCU = param.u_0 + param.u_1*P_elDC + param.u_2*P_elDC^2;
    varHeatFlow.Q_flow = dotQ_th;
    Capacity[1] = firstOrderP.y;
    Capacity[2] = dotQ_th;
    Capacity[3] = dotN_B * LHV;
    integrator[1].u = firstOrderP.y;
    integrator[2].u = dotQ_th;
    integrator[3].u = dotN_B * LHV;
    P_elDC = dotP.y;
    dotQ_th = firstOrderQ_start.y;
    dotQ_loss = firstOrderQ_startloss.y;
    dotN_B =firstOrderdotN_B.y;
    dotP.u = firstOrderP_elDC.y;
    P_anc = firstOrderP_anc.y;
    P_PCU = firstOrderP_PCU.y;
    //dotN_L = firstOrderdotN_L.y;

    if OnOff then
      if Start then
        firstOrderP_elDC.u = 146;
        firstOrderQ_start.u = 0;
        firstOrderQ_startloss.u = 0;
        firstOrderP_anc.u = 453;
        firstOrderdotN_B.u = 0.001;
        //firstOrderdotN_L.u = param.a_0 + param.a_1*dotN_B/1000 + param.a_2 * (dotN_B/1000)^2;
        firstOrderP_PCU.u = P_elDC;
        firstOrderP.u = P_elDC - P_anc;
      else
        firstOrderP_elDC.u = P_demand.y;
        firstOrderQ_start.u = param.r_0 + param.r_1*(P_elDC)^param.alpha_0 + param.r_2*(Modelica.SIunits.Conversions.to_degC(T_win) - param.T_0)^param.alpha_1;
        firstOrderQ_startloss.u = param.s_0 + param.s_1 * P_elDC^param.beta_0 + param.s_2 * (Modelica.SIunits.Conversions.to_degC(T_win) - param.T_1)^param.beta_1;
        firstOrderP_anc.u = param.anc_0 + param.anc_1*dotN_B/1000;
        firstOrderdotN_B.u = P_elDC/(eta_el*LHV);
        //firstOrderdotN_L.u = param.a_0 + param.a_1*dotN_B/1000 + param.a_2 * (dotN_B/1000)^2;
        firstOrderP_PCU.u = eta_PCU*P_elDC;
        firstOrderP.u = P_PCU - P_anc;
      end if;
    else
      if Stop then
        firstOrderP_elDC.u = 0;
        firstOrderQ_start.u = 0;
        firstOrderQ_startloss.u = 0;
        firstOrderP_anc.u = 16.67;
        firstOrderdotN_B.u = 3.3e-5;
        //firstOrderdotN_L.u = 0;
        firstOrderP_PCU.u = P_elDC;
        firstOrderP.u = P_PCU - P_anc;
      else
        firstOrderP_elDC.u = 0;
        firstOrderQ_start.u = 0;
        firstOrderQ_startloss.u = 0;
        firstOrderP_anc.u = param.anc_0 + param.anc_1*dotN_B/1000;
        firstOrderdotN_B.u = P_elDC/(eta_el*LHV);
        //firstOrderdotN_L.u = 0;
        firstOrderP_PCU.u = eta_PCU*P_elDC;
        firstOrderP.u = 0;
      end if;
    end if;

    connect(T_return.enthalpyPort_b,enthalpyPort_b1)  annotation (Line(points={{53,
            -82.1},{102,-82.1},{102,-82}}, color={176,0,0}));
    connect(enthalpyPort_a1,massFlowRate. enthalpyPort_a) annotation (Line(points={{-106,
            -82},{-84.8,-82},{-84.8,-82.1}},       color={176,0,0}));
    connect(massFlowRate.enthalpyPort_b,T_flow. enthalpyPort_a) annotation (Line(
          points={{-67,-82.1},{-58.5,-82.1},{-50.8,-82.1}}, color={176,0,0}));
    connect(varHeatFlow.port,workingFluid. heatPort)
      annotation (Line(points={{0,-68},{0,-68},{0,-72.6}},  color={191,0,0}));
    connect(T_flow.enthalpyPort_b,workingFluid. enthalpyPort_a) annotation (Line(
          points={{-33,-82.1},{-9,-82.1},{-9,-82}}, color={176,0,0}));
    connect(workingFluid.enthalpyPort_b,T_return. enthalpyPort_a) annotation (
        Line(points={{9,-82},{35.2,-82},{35.2,-82.1}},  color={176,0,0}));
    connect(integrator.y, Energy)
      annotation (Line(points={{91,42},{112,42},{112,42}}, color={0,0,127}));
    connect(u, P_demand.u)
      annotation (Line(points={{-100,74},{-67.6,74}}, color={0,0,127}));
      annotation (Placement(transformation(extent={{-96,-70},{-76,-50}})),
                Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end PEMFC;
end CHP;
