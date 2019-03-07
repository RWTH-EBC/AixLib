within AixLib.Fluid.BoilerCHP.ModularCHP;
package BaseClasses "Package with base classes for AixLib.Fluid.BoilerCHP.ModularCHP"
  extends Modelica.Icons.BasesPackage
annotation (preferredView="info", Documentation(info="<html>
<p>
This package contains base classes that are used to construct the models in
<a href=\"modelica://AixLib.Fluid.BoilerCHP.ModularCHP\">AixLib.Fluid.BoilerCHP.ModularCHP</a>.
</p>
</html>"));
  model Submodel_Cooling
    import AixLib;
    Modelica.Fluid.Sensors.TemperatureTwoPort senTCooEngIn(
      redeclare package Medium = Medium_Coolant,
      allowFlowReversal=allowFlowReversalCoolant,
      m_flow_nominal=m_flow,
      m_flow_small=mCool_flow_small) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-60,0})));
    FixedResistances.Pipe engineHeatTransfer(
      redeclare package Medium = Medium_Coolant,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal=CHPEngineModel.dp_Coo, m_flow_nominal=m_flow),
      Heat_Loss_To_Ambient=true,
      alpha=engineHeatTransfer.alpha_i,
      eps=0,
      isEmbedded=true,
      use_HeatTransferConvective=false,
      p_a_start=system.p_start,
      p_b_start=system.p_start,
      alpha_i=GCoolChannel/(engineHeatTransfer.perimeter*engineHeatTransfer.length),
      diameter=CHPEngineModel.dCoo,
      allowFlowReversal=allowFlowReversalCoolant)
      annotation (Placement(transformation(extent={{8,12},{32,-12}})));

    Modelica.Fluid.Sensors.TemperatureTwoPort senTCooEngOut(
      redeclare package Medium = Medium_Coolant,
      allowFlowReversal=allowFlowReversalCoolant,
      m_flow_nominal=m_flow,
      m_flow_small=mCool_flow_small)
      annotation (Placement(transformation(extent={{50,-10},{70,10}})));
    replaceable package Medium_Coolant =
        DataBase.CHP.ModularCHPEngineMedia.CHPCoolantPropyleneGlycolWater (
                                   property_T=356, X_a=0.50) constrainedby
      Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);
    parameter
      DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord
      CHPEngineModel=DataBase.CHP.ModularCHPEngineData.CHP_ECPowerXRGI15()
      "CHP engine data for calculations"
      annotation (choicesAllMatching=true, Dialog(group="Unit properties"));
    outer Modelica.Fluid.System system
      annotation (Placement(transformation(extent={{-100,-100},{-84,-84}})));
    parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate m_flow=
        CHPEngineModel.m_floCooNominal
      "Nominal mass flow rate of coolant inside the engine cooling circle" annotation (Dialog(tab="Engine Cooling Circle"));
    parameter Modelica.SIunits.ThermalConductance GCoolChannel=45
      "Thermal conductance of engine housing from the cylinder wall to the water cooling channels"
      annotation (Dialog(tab="Engine Cooling Circle", group="Calibration Parameters"));
    parameter Modelica.SIunits.Temperature T_HeaRet=303.15
      "Constant heating circuit return temperature"
      annotation (Dialog(tab="Engine Cooling Circle"));
    parameter Boolean allowFlowReversalCoolant=true
      "= false to simplify equations, assuming, but not enforcing, no flow reversal for coolant medium"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
      mCool_flow_small=0.0001
      "Small coolant mass flow rate for regularization of zero flow"
      annotation (Dialog(tab="Advanced", group="Assumptions"));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_outside
      annotation (Placement(transformation(rotation=0, extent={{-10,-70},{10,-50}}),
          iconTransformation(extent={{-12,-66},{12,-42}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
          Medium_Coolant) annotation (Placement(transformation(rotation=0, extent=
             {{-110,-10},{-90,10}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
          Medium_Coolant) annotation (Placement(transformation(rotation=0, extent=
             {{90,-10},{110,10}})));
    AixLib.Controls.Interfaces.CHPControlBus sigBus_Cooling(meaTemInEng=
          senTCooEngIn.T, meaTemOutEng=senTCooEngOut.T) annotation (Placement(
          transformation(extent={{-28,26},{28,80}}), iconTransformation(extent=
              {{-28,26},{30,82}})));
    Movers.FlowControlled_m_flow                coolantPump(
      m_flow_small=mCool_flow_small,
      redeclare package Medium = Medium_Coolant,
      dp_nominal=CHPEngineModel.dp_Coo,
      allowFlowReversal=allowFlowReversalCoolant,
      addPowerToMedium=false,
      m_flow_nominal=m_flow)
      annotation (Placement(transformation(extent={{-30,12},{-10,-12}})));
    Modelica.Fluid.Sources.FixedBoundary fixedPressureLevel(
      nPorts=1,
      redeclare package Medium = Medium_Coolant,
      T(displayUnit="K") = T_HeaRet,
      p=300000)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-80,-40})));
    Modelica.Blocks.Sources.RealExpression massFlowCoolant(y=if sigBus_Cooling.isOnPump
           then m_flow else mCool_flow_small)
      annotation (Placement(transformation(extent={{12,-50},{-8,-30}})));
  equation
    connect(engineHeatTransfer.port_b, senTCooEngOut.port_a)
      annotation (Line(points={{32.48,0},{50,0}},     color={0,127,255}));
    connect(heatPort_outside, engineHeatTransfer.heatPort_outside) annotation (
        Line(points={{0,-60},{21.92,-60},{21.92,-6.72}},          color={191,0,0}));
    connect(port_a, senTCooEngIn.port_a)
      annotation (Line(points={{-100,0},{-70,0}}, color={0,127,255}));
    connect(port_b, senTCooEngOut.port_b)
      annotation (Line(points={{100,0},{70,0}}, color={0,127,255}));
    connect(senTCooEngIn.port_b, coolantPump.port_a)
      annotation (Line(points={{-50,0},{-30,0}}, color={0,127,255}));
    connect(engineHeatTransfer.port_a, coolantPump.port_b)
      annotation (Line(points={{7.52,0},{-10,0}}, color={0,127,255}));
    connect(massFlowCoolant.y, coolantPump.m_flow_in) annotation (Line(points={{-9,
            -40},{-20,-40},{-20,-14.4}}, color={0,0,127}));
    connect(fixedPressureLevel.ports[1], senTCooEngIn.port_a)
      annotation (Line(points={{-80,-30},{-80,0},{-70,0}}, color={0,127,255}));
    annotation (Icon(graphics={
          Rectangle(
            extent={{-100,40},{100,-40}},
            lineColor={0,0,0},
            fillColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Ellipse(
            extent={{-76,14},{-56,-10}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={0,0,0}),
          Ellipse(
            extent={{56,14},{76,-10}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={0,0,0}),    Text(
            extent={{-151,113},{149,73}},
            lineColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={0,127,255},
            textString="%name")}));
  end Submodel_Cooling;

  model GasolineEngineChp
    import AixLib;
    AixLib.Fluid.BoilerCHP.ModularCHP.BaseClasses.BaseClassComponents.GasolineEngineChp_CHPCombustionEngineModulate
      cHPCombustionEngine(
      redeclare package Medium1 = Medium_Fuel,
      redeclare package Medium2 = Medium_Air,
      redeclare package Medium3 = Medium_Exhaust,
      T_Amb=T_ambient,
      CHPEngData=CHPEngineModel,
      inertia(phi(fixed=false), w(fixed=false, displayUnit="rad/s")),
      T_logEngCool=T_logEngCool,
      T_ExhCHPOut=T_ExhCHPOut,
      modFac=modFac,
      SwitchOnOff=cHPControlBus.isOn)
      annotation (Placement(transformation(extent={{-30,0},{30,56}})));
    AixLib.Fluid.BoilerCHP.ModularCHP.BaseClasses.BaseClassComponents.GasolineEngineChp_EngineHousing
      engineToCoolant(
      z=CHPEngineModel.z,
      eps=CHPEngineModel.eps,
      m_Exh=cHPCombustionEngine.m_Exh,
      T_Amb=T_ambient,
      redeclare package Medium3 = Medium_Exhaust,
      dCyl=CHPEngineModel.dCyl,
      hStr=CHPEngineModel.hStr,
      meanCpExh=cHPCombustionEngine.meanCpExh,
      cylToInnerWall(maximumEngineHeat(y=cHPCombustionEngine.Q_therm),
          heatLimit(strict=true)),
      T_Com=cHPCombustionEngine.T_Com,
      nEng=cHPCombustionEngine.nEng,
      lambda=EngMat.lambda,
      rhoEngWall=EngMat.rhoEngWall,
      c=EngMat.c,
      EngMatData=EngMat,
      mEng=mEng,
      dInn=dInn,
      T_ExhPowUniOut=T_ExhCHPOut,
      GEngToAmb=GEngToAmb)
      "A physikal model for calculating the thermal, mass and mechanical output of an ice powered CHP"
      annotation (Placement(transformation(extent={{-22,-52},{22,-8}})));
    replaceable package Medium_Fuel =
        DataBase.CHP.ModularCHPEngineMedia.LiquidFuel_LPG             constrainedby
      DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                  annotation(choicesAllMatching=true);
    replaceable package Medium_Air =
        AixLib.DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir
                                                                 constrainedby
      DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir
                           annotation(choicesAllMatching=true);
    replaceable package Medium_Exhaust =
        DataBase.CHP.ModularCHPEngineMedia.CHPFlueGasLambdaOnePlus  constrainedby
      DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                   annotation(choicesAllMatching=true);
    parameter
      DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord
      CHPEngineModel=DataBase.CHP.ModularCHPEngineData.CHP_ECPowerXRGI15()
      "CHP engine data for calculations"
      annotation (choicesAllMatching=true, Dialog(group="Unit properties"));
    parameter Data.ModularCHP.EngineMaterialData EngMat=
        Data.ModularCHP.EngineMaterial_CastIron()
      "Thermal engine material data for calculations"
      annotation (choicesAllMatching=true, Dialog(group="Unit properties"));
    parameter Modelica.SIunits.Temperature T_ambient=298.15
      "Default ambient temperature"
      annotation (Dialog(group="Ambient Parameters"));
    parameter Modelica.SIunits.Mass mEng=CHPEngineModel.mEng
      "Total engine mass for heat capacity calculation"
      annotation (Dialog(tab="Engine Cooling Circle"));
  parameter Modelica.SIunits.Thickness dInn=0.005
      "Typical value for the thickness of the cylinder wall (between combustion chamber and cooling circle)"
      annotation (Dialog(tab="Engine Cooling Circle"));
    parameter Modelica.SIunits.ThermalConductance GEngToAmb=0.23
      "Thermal conductance from engine housing to the surrounding air"
      annotation (Dialog(tab="Engine Cooling Circle"));
    Real modFac=cHPControlBus.modFac
      "Modulation factor for energy outuput control of the Chp unit  "
      annotation (Dialog(group="Engine Parameters"));
    Modelica.SIunits.Temperature T_logEngCool=(cHPControlBus.meaTemInEng +
        cHPControlBus.meaTemOutEng)/2                "Logarithmic mean temperature of coolant inside the engine"
      annotation(Dialog(group="Engine Parameters"));
    Modelica.SIunits.Temperature T_ExhCHPOut=cHPControlBus.meaTemExhOutHex
                                                     "Exhaust gas outlet temperature of CHP unit"
      annotation(Dialog(group="Engine Parameters"));
    Modelica.SIunits.Temperature T_Exh=engineToCoolant.T_Exh "Inlet temperature of exhaust gas"
      annotation (Dialog(group="Thermal"));

    Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a annotation (
        Placement(transformation(rotation=0, extent={{-114,-6},{-94,14}}),
          iconTransformation(extent={{-114,-6},{-94,14}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_Exhaust(redeclare package Medium
        = Medium_Exhaust) annotation (Placement(transformation(rotation=0, extent={{92,-8},
              {112,12}}),         iconTransformation(extent={{92,-8},{112,12}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_Ambient annotation (
        Placement(transformation(rotation=0, extent={{-10,-100},{10,-80}}),
          iconTransformation(extent={{-10,-100},{10,-80}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_CoolingCircle
      annotation (Placement(transformation(rotation=0, extent={{90,-98},{110,-78}}),
          iconTransformation(extent={{90,-98},{110,-78}})));
    AixLib.Controls.Interfaces.CHPControlBus cHPControlBus(
      meaRotEng=cHPCombustionEngine.nEng,
      meaFuePowEng=cHPCombustionEngine.P_Fue,
      meaThePowEng=cHPCombustionEngine.Q_therm,
      meaTorEng=cHPCombustionEngine.Mmot,
      meaMasFloFueEng=cHPCombustionEngine.m_Fue,
      meaMasFloAirEng=cHPCombustionEngine.m_Air,
      meaMasFloCO2Eng=cHPCombustionEngine.m_CO2Exh,
      calMeaCpExh=cHPCombustionEngine.meanCpExh) annotation (Placement(
          transformation(
          extent={{-30,-32},{30,32}},
          rotation=0,
          origin={0,92}), iconTransformation(
          extent={{-26,-26},{26,26}},
          rotation=0,
          origin={0,88})));

  equation
    connect(port_Exhaust, cHPCombustionEngine.port_Exhaust) annotation (Line(
          points={{102,2},{64,2},{64,28},{29.4,28}},   color={0,127,255}));
    connect(port_Ambient, engineToCoolant.port_Ambient)
      annotation (Line(points={{0,-90},{0,-52}}, color={191,0,0}));
    connect(port_CoolingCircle, engineToCoolant.port_CoolingCircle)
      annotation (Line(points={{100,-88},{100,-30},{22,-30}}, color={191,0,0}));
    connect(engineToCoolant.exhaustGasTemperature, cHPCombustionEngine.exhaustGasTemperature)
      annotation (Line(points={{0,-3.16},{0,8.4}}, color={0,0,127}));
    connect(cHPCombustionEngine.flange_a, flange_a) annotation (Line(points={{-30,
            28},{-68,28},{-68,4},{-104,4}}, color={0,0,0}));
    annotation (Icon(graphics={
            Bitmap(extent={{-136,-134},{144,160}}, fileName=
                "modelica://AixLib/Resources/Images/Fluid/BoilerCHP/Icon_ICE.png")}));
  end GasolineEngineChp;

  model CHP_StarterGenerator
    "Model of a general induction machine working as a starter generator"
    import AixLib;
    extends Modelica.Electrical.Machines.Icons.TransientMachine;

    parameter
      AixLib.DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord
      CHPEngData=DataBase.CHP.ModularCHPEngineData.CHP_ECPowerXRGI15()
      "Needed engine data for calculations"
      annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

    parameter Modelica.SIunits.Frequency n0=CHPEngData.n0
      "Idling speed of the electric machine"
      annotation (Dialog(group="Machine specifications"));
    parameter Modelica.SIunits.Frequency n_nominal=CHPEngData.n_nominal
                                                           "Rated rotor speed"
      annotation (Dialog(group="Machine specifications"));
    parameter Modelica.SIunits.Frequency f_1=CHPEngData.f_1
                                                "Frequency"
      annotation (Dialog(group="Machine specifications"));
    parameter Modelica.SIunits.Voltage U_1=CHPEngData.U_1
                                               "Rated voltage"
      annotation (Dialog(group="Machine specifications"));
    parameter Modelica.SIunits.Current I_elNominal=CHPEngData.I_elNominal
                                                        "Rated current"
      annotation (Dialog(group="Machine specifications"));
    parameter Modelica.SIunits.Current I_1_start=if P_Mec_nominal<=15000 then 7.2*I_elNominal else 8*I_elNominal
      "Motor start current (realistic factors used from DIN VDE 2650/2651)"
      annotation (Dialog(                           tab="Calculations"));
    parameter Modelica.SIunits.Power P_elNominal=CHPEngData.P_elNominal
      "Nominal electrical power of electric machine"
      annotation (Dialog(group="Machine specifications"));
    parameter Modelica.SIunits.Power P_Mec_nominal=P_elNominal*(1+s_nominal/0.22) "Nominal mechanical power of electric machine"
      annotation (Dialog(tab="Calculations"));
    parameter Modelica.SIunits.Torque M_nominal=P_Mec_nominal/(2*Modelica.Constants.pi*n_nominal) "Nominal torque of electric machine"
      annotation (Dialog(tab="Calculations"));
    parameter Modelica.SIunits.Torque M_til=2*M_nominal "Tilting torque of electric machine (realistic factor used from DIN VDE 2650/2651)"
      annotation (Dialog(tab="Calculations"));
    parameter Modelica.SIunits.Torque M_start=if P_Mec_nominal<=4000 then 1.6*M_nominal
    elseif P_Mec_nominal>=22000 then 1*M_nominal else 1.25*M_nominal
     "Tilting torque of electric machine (realistic factor used from DIN VDE 2650/2651)"
      annotation (Dialog(tab="Calculations"));
    parameter Modelica.SIunits.Inertia J_Gen=0.3
      "Moment of inertia of the electric machine (default=0.5kg.m2)"
      annotation (Dialog(group="Calibration"));
    parameter Boolean useHeat=CHPEngData.useHeat
      "Is the thermal loss energy of the elctric machine used?"
      annotation (Dialog(group="Machine specifications"));
    parameter Real s_nominal=abs(1-n_nominal*p/f_1) "Nominal slip of electric machine"
      annotation (Dialog(tab="Calculations"));
    parameter Real s_til=abs((s_nominal*(M_til/M_nominal)+s_nominal*sqrt(abs(((M_til/M_nominal)^2)-1+2*s_nominal*((M_til/M_nominal)-1))))/(1-2*s_nominal*((M_til/M_nominal)-1)))
     "Tilting slip of electric machine"
      annotation (Dialog(tab="Calculations"));
    parameter Real p=CHPEngData.p
                       "Number of pole pairs"
      annotation (Dialog(group="Machine specifications"));
    parameter Real cosPhi=CHPEngData.cosPhi
                              "Power factor of electric machine (default=0.8)"
      annotation (Dialog(group="Machine specifications"));
    parameter Real calFac=1
      "Calibration factor for electric power outuput (default=1)"
      annotation (Dialog(group="Calibration"));
    parameter Real gearRatio=CHPEngData.gearRatio
                               "Transmission ratio (engine speed / generator speed)"
      annotation (Dialog(group="Machine specifications"));
    parameter Real rho0=s_til^2 "Calculation variable for analytical approach (Aree, 2017)"
      annotation (Dialog(tab="Calculations"));
    parameter Real rho1=(M_start*(1+s_til^2)-2*s_til*M_til)/(M_til-M_start) "Calculation variable for analytical approach (Aree, 2017)"
      annotation (Dialog(tab="Calculations"));
    parameter Real rho3=(M_til*M_start*(1-s_til)^2)/(M_til-M_start) "Calculation variable for analytical approach (Aree, 2017)"
      annotation (Dialog(tab="Calculations"));
    parameter Real k=((I_elNominal/I_1_start)^2)*(((s_nominal^2)+rho1*s_nominal+rho0)/(1+rho1+rho0)) "Calculation variable for analytical approach (Aree, 2017)"
      annotation (Dialog(tab="Calculations"));

    Modelica.SIunits.Frequency n=inertia.w/(2*Modelica.Constants.pi) "Speed of machine rotor [1/s]";
    Modelica.SIunits.Current I_1 "Electric current of machine stator";
    Modelica.SIunits.Power P_E "Electrical power at the electric machine";
    Modelica.SIunits.Power P_Mec "Mechanical power at the electric machine";
    Modelica.SIunits.Power CalQ_Loss
      "Calculated heat flow from electric machine";
    Modelica.SIunits.Power Q_Therm=if useHeat then CalQ_Loss else 0
      "Heat flow from electric machine"
      annotation (Dialog(group="Machine specifications"));
    Modelica.SIunits.Torque M "Torque at electric machine";
    Real s=1-n*p/f_1 "Current slip of electric machine";
    Real eta "Total efficiency of the electric machine (as motor)";
    Real calI_1 = 1/(1+((k-1)/((s_nominal^2)-k))*((s^2)+rho1*abs(s)+rho0));
    Boolean OpMode = (n<=n0) "Operation mode (true=motor, false=generator)";
    Boolean SwitchOnOff=cHPControlBus.isOn "Operation of electric machine (true=On, false=Off)";
    Modelica.Mechanics.Rotational.Components.Inertia inertia(       w(fixed=false), J=J_Gen)
      annotation (Placement(transformation(extent={{20,-10},{40,10}})));
    Modelica.Blocks.Sources.RealExpression electricTorque(y=M)
      annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
    Modelica.Mechanics.Rotational.Sources.Torque torque
      annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
    Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));

    Modelica.Mechanics.Rotational.Components.IdealGear gearEngineToGenerator(
        ratio=gearRatio)
      annotation (Placement(transformation(extent={{80,-10},{60,10}})));

    AixLib.Controls.Interfaces.CHPControlBus cHPControlBus(
      meaElPowGen=P_E,
      meaCurGen=I_1,
      meaTorGen=M,
      calEtaGen=eta) annotation (Placement(transformation(extent={{-132,28},{-72,84}}),
          iconTransformation(
          extent={{-30,-28},{30,28}},
          rotation=90,
          origin={-76,0})));
  equation

  if noEvent(SwitchOnOff) then

    I_1=sign(s)*I_1_start*sqrt(abs((1+((k-1)/((s_nominal^2)-k))*(s^2)*(1+rho1+rho0))*calI_1));
    P_E=if noEvent(s>0) then sqrt(3)*I_1*U_1*cosPhi elseif noEvent(s<0) then calFac*(P_Mec+CalQ_Loss) else 1;
   // P_Mec=if noEvent(s>0) then 2*Modelica.Constants.pi*M*n else 2*Modelica.Constants.pi*n*M;
    P_Mec=2*Modelica.Constants.pi*M*n;
    CalQ_Loss= (calFac-1)*P_E + 2*Modelica.Constants.pi*M*(s*n0)/0.22;
    M=sign(s)*(rho3*abs(s))/((s^2)+rho1*abs(s)+rho0);
    eta=if noEvent(s>0) then abs(P_Mec/(P_E+1))
    elseif noEvent(s<0) then abs(P_E/(P_Mec-1)) else 0;

  else

    I_1=0;
    P_E=0;
    P_Mec=0;
    CalQ_Loss=0;
    M=if noEvent(s<0) then sign(s)*(rho3*abs(s))/((s^2)+rho1*abs(s)+rho0) else 0;
    eta=0;

    end if;

    connect(electricTorque.y, torque.tau)
      annotation (Line(points={{-39,0},{-22,0}}, color={0,0,127}));
    connect(torque.flange, inertia.flange_a)
      annotation (Line(points={{0,0},{20,0}}, color={0,0,0}));
    connect(inertia.flange_b, gearEngineToGenerator.flange_b)
      annotation (Line(points={{40,0},{60,0}}, color={0,0,0}));
    connect(gearEngineToGenerator.flange_a, flange_a)
      annotation (Line(points={{80,0},{100,0}}, color={0,0,0}));
    annotation (Documentation(info="<html>
<p>Model of an electric induction machine that includes the calculation of:</p>
<p>-&gt; mechanical output (torque and speed)</p>
<p>-&gt; electrical output (current and power)</p>
<p>It delivers positive torque and negative electrical power when operating below the synchronous speed (motor) and can switch into generating electricity (positive electrical power and negative torque) when operating above the synchronous speed (generator).</p>
<p>The calculations are based on simple electrical equations and an analytical approach by Pichai Aree (2017) that determinates stator current and torque depending on the slip.</p>
<p>The parameters rho0, rho1, rho3 and k are used for the calculation of the characteristic curves. They are determined from the general machine data at nominal operation and realistic assumptions about the ratio between starting torque, starting current, breakdown torque, breakdown slip and nominal current and torque. These assumptions are taken from DIN VDE 2650/2651. It shows good agreement for machines up to 100kW of mechanical power operating at a speed up to 3000rpm and with a rated voltage up to 500V.</p>
<p>The only data required is:</p>
<p>- number of polepairs or synchronous speed (<b>p</b> or <b>n0</b>)</p>
<p>- voltage and frequence of the electric power supply (<b>U_1</b> and <b>f_1</b>)</p>
<p>- nominal current and speed (<b>I_elNominal</b> and <b>n_nominal</b> )</p>
<p>- power factor if available (default=0.8)</p>
<p><br>Additional Information:</p>
<p><br>- Electric power calculation as a generator from mechanical input speed can be further approached by small changes to the speed.</p>
<p>- The electric losses are calculated from the slip depending rotor loss which corresponds to roughly 22&percnt; of the total losses according to Almeida (DOI: 10.1109/MIAS.2010.939427).</p>
</html>"),   Icon(graphics={
          Text(
            extent={{-86,98},{84,82}},
            lineColor={28,108,200},
            textStyle={TextStyle.Bold},
            textString="%name")}));
  end CHP_StarterGenerator;

  model ExhaustHeatExchanger
    "Exhaust gas heat exchanger for engine combustion and its heat transfer to a cooling circle"
    import AixLib;

    extends AixLib.Fluid.Interfaces.PartialFourPortInterface(
      m1_flow_nominal=0.023,
      m2_flow_nominal=0.5556,
      m1_flow_small=0.0001,
      m2_flow_small=0.0001,
      show_T=true,
      redeclare package Medium1 = Medium3,
      redeclare package Medium2 = Medium4);

    AixLib.Fluid.Sensors.TemperatureTwoPort senTExhHot(
      redeclare final package Medium = Medium1,
      final tau=tau,
      final m_flow_nominal=m1_flow_nominal,
      final initType=initType,
      final T_start=T1_start,
      final transferHeat=transferHeat,
      final TAmb=TAmb,
      final tauHeaTra=tauHeaTra,
      final allowFlowReversal=allowFlowReversal1,
      final m_flow_small=m1_flow_small)
      "Temperature sensor of hot side of exhaust heat exchanger"
      annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
    AixLib.Fluid.Sensors.TemperatureTwoPort senTExhCold(
      redeclare final package Medium = Medium1,
      final tau=tau,
      final m_flow_nominal=m1_flow_nominal,
      final initType=initType,
      final T_start=T1_start,
      final transferHeat=transferHeat,
      final TAmb=TAmb,
      final tauHeaTra=tauHeaTra,
      final allowFlowReversal=allowFlowReversal1,
      final m_flow_small=m1_flow_small)
      "Temperature sensor of cold side of exhaust heat exchanger"
      annotation (Placement(transformation(extent={{28,50},{48,70}})));
    AixLib.Fluid.Sensors.MassFlowRate senMasFloExh(redeclare final package
        Medium =
          Medium1, final allowFlowReversal=allowFlowReversal1)
      "Sensor for mass flwo rate"
      annotation (Placement(transformation(extent={{60,70},{80,50}})));
    AixLib.Fluid.Sensors.TemperatureTwoPort senTCoolCold(
      redeclare final package Medium = Medium2,
      final tau=tau,
      final m_flow_nominal=m2_flow_nominal,
      final initType=initType,
      final T_start=T2_start,
      final transferHeat=transferHeat,
      final TAmb=TAmb,
      final tauHeaTra=tauHeaTra,
      final allowFlowReversal=allowFlowReversal2,
      final m_flow_small=m2_flow_small)
      "Temperature sensor of coolant cold side of exhaust heat exchanger"
      annotation (Placement(transformation(extent={{60,-70},{80,-50}})));
    AixLib.Fluid.Sensors.TemperatureTwoPort senTCoolHot(
      redeclare final package Medium = Medium2,
      final tau=tau,
      final m_flow_nominal=m2_flow_nominal,
      final initType=initType,
      final T_start=T2_start,
      final transferHeat=transferHeat,
      final TAmb=TAmb,
      final tauHeaTra=tauHeaTra,
      final allowFlowReversal=allowFlowReversal2,
      final m_flow_small=m2_flow_small)
      "Temperature sensor of coolant hot side of exhaust heat exchanger"
      annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
    AixLib.Fluid.Sensors.MassFlowRate senMasFloCool(redeclare final package
        Medium = Medium2, final allowFlowReversal=allowFlowReversal2)
      "Sensor for mass flwo rate"
      annotation (Placement(transformation(extent={{-60,-70},{-80,-50}})));

    parameter
      AixLib.DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord
      CHPEngData=DataBase.CHP.ModularCHPEngineData.CHP_ECPowerXRGI15()
      "Needed engine data for calculations"
      annotation (choicesAllMatching=true, Dialog(group="Unit properties"));
    parameter Modelica.SIunits.Time tau=1
      "Time constant of the temperature sensors at nominal flow rate"
      annotation (Dialog(tab="Advanced", group="Sensor Properties"));
    parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.InitialState
      "Type of initialization (InitialState and InitialOutput are identical)"
      annotation (Dialog(tab="Advanced", group="Sensor Properties"));
    parameter Modelica.SIunits.Temperature T1_start=TAmb
      "Initial or guess value of output (= state)"
      annotation (Dialog(tab="Advanced", group="Initialization"));
    parameter Modelica.SIunits.Temperature T2_start=TAmb
      "Initial or guess value of output (= state)"
      annotation (Dialog(tab="Advanced", group="Initialization"));
    parameter Modelica.Media.Interfaces.Types.AbsolutePressure p1_start=pAmb
      "Start value of pressure"
      annotation (Dialog(tab="Advanced", group="Initialization"));
    parameter Modelica.Media.Interfaces.Types.AbsolutePressure p2_start=pAmb
      "Start value of pressure"
      annotation (Dialog(tab="Advanced", group="Initialization"));
    parameter Boolean transferHeat=false
      "If true, temperature T converges towards TAmb when no flow"
      annotation (Dialog(tab="Advanced", group="Sensor Properties"));
    parameter Boolean ConTec=false
      "Is condensing technology used and should latent heat be considered?"
      annotation (Dialog(tab="Advanced", group="Condensing technology"));
    parameter Modelica.SIunits.Temperature TAmb=298.15
      "Fixed ambient temperature for heat transfer"
      annotation (Dialog(group="Ambient Properties"));
    parameter Modelica.SIunits.Temperature T_ExhPowUniOut=CHPEngData.T_ExhPowUniOut
      "Outlet temperature of exhaust gas flow"
    annotation (Dialog(group="Thermal"));
    parameter Modelica.SIunits.Area A_surExhHea=50
      "Surface for exhaust heat transfer" annotation (Dialog(tab="Calibration parameters"));
    parameter Modelica.SIunits.Length d_iExh=CHPEngData.dExh
      "Inner diameter of exhaust pipe"
      annotation (Dialog(group="Nominal condition"));
    parameter Modelica.SIunits.Volume VExhHex=l_ExhHex/4*Modelica.Constants.pi*
        d_iExh^2
      "Exhaust gas volume inside the exhaust heat exchanger" annotation(Dialog(tab="Calibration parameters",group="Engine parameters"));
    parameter Modelica.SIunits.ThermalConductance G_Amb=5
      "Constant thermal conductance of material"
      annotation (Dialog(tab="Calibration parameters"));
    parameter Modelica.SIunits.ThermalConductance G_Cool=850
      "Constant thermal conductance of material"
      annotation (Dialog(tab="Calibration parameters"));
    parameter Modelica.SIunits.HeatCapacity C_ExhHex=4000
      "Heat capacity of exhaust heat exchanger(default= 4000 J/K)"
    annotation (Dialog(tab="Calibration parameters"));
    parameter Modelica.Media.Interfaces.Types.AbsolutePressure pAmb=101325
      "Start value of pressure"
      annotation (Dialog(group="Ambient Properties"));
    parameter Modelica.Media.Interfaces.Types.AbsolutePressure dp_start=
        CHPEngData.dp_Coo
      "Guess value of dp = port_a.p - port_b.p"
      annotation (Dialog(tab="Advanced", group="Initialization"));
    parameter Modelica.SIunits.Time tauHeaTra=1200
      "Time constant for heat transfer, default 20 minutes"
      annotation (Dialog(tab="Advanced", group="Sensor Properties"));
    parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate m_flow_start=0
      "Guess value of m_flow = port_a.m_flow"
      annotation (Dialog(tab="Advanced", group="Initialization"));
    constant Modelica.SIunits.MolarMass M_H2O=0.01802
      "Molar mass of water";
    constant Modelica.SIunits.MolarMass M_Exh
      "Molar mass of the exhaust gas"
      annotation (Dialog(group="Thermal"));

      //Antoine-Parameters needed for the calculation of the saturation vapor pressure xSat_H2OExhDry
    constant Real A=11.7621;
    constant Real B=3874.61;
    constant Real C=229.73;

    Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=
          C_ExhHex, T(start=TAmb, fixed=true))
      annotation (Placement(transformation(extent={{10,-12},{30,8}})));
    Modelica.Thermal.HeatTransfer.Components.ThermalConductor ambientLoss(G=G_Amb)
      annotation (Placement(transformation(extent={{-46,-22},{-66,-2}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_Ambient annotation (
        Placement(transformation(extent={{-110,-10},{-90,10}}),
          iconTransformation(extent={{-110,-10},{-90,10}})));
    replaceable package Medium3 =
        AixLib.DataBase.CHP.ModularCHPEngineMedia.CHPFlueGasLambdaOnePlus
      constrainedby Modelica.Media.Interfaces.PartialMedium annotation (
        __Dymola_choicesAllMatching=true);
    replaceable package Medium4 =
        DataBase.CHP.ModularCHPEngineMedia.CHPCoolantPropyleneGlycolWater (
                                        property_T=356, X_a=0.50) constrainedby
      Modelica.Media.Interfaces.PartialMedium annotation (
        __Dymola_choicesAllMatching=true);

    parameter Modelica.SIunits.Length l_ExhHex=1
      "Length of the exhaust pipe inside the exhaust heat exchanger" annotation (
        Dialog(tab="Calibration parameters", group="Engine parameters"));
    parameter Modelica.SIunits.PressureDifference dp_CooExhHex=CHPEngData.dp_Coo
      "Pressure drop at nominal mass flow rate inside the coolant circle "
      annotation (Dialog(group="Nominal condition"));
    AixLib.Fluid.FixedResistances.Pipe pipeCoolant(
      redeclare package Medium = Medium2,
      p_b_start=system.p_start - 15000,
      isEmbedded=true,
      Heat_Loss_To_Ambient=true,
      withInsulation=false,
      use_HeatTransferConvective=false,
      eps=0,
      alpha=pipeCoolant.alpha_i,
      alpha_i=G_Cool/(pipeCoolant.perimeter*pipeCoolant.length),
      diameter=0.03175,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            m_flow_nominal=m2_flow_nominal, dp_nominal=10))
      annotation (Placement(transformation(extent={{32,-70},{12,-50}})));

    Modelica.Fluid.Vessels.ClosedVolume volExhaust(
      redeclare final package Medium = Medium1,
      final m_flow_nominal=m1_flow_nominal,
      final p_start=p1_start,
      final T_start=T1_start,
      use_HeatTransfer=true,
      redeclare model HeatTransfer =
          Modelica.Fluid.Vessels.BaseClasses.HeatTransfer.IdealHeatTransfer,
      use_portsData=false,
      final m_flow_small=m1_flow_small,
      nPorts=3,
      V=VExhHex)                         "Fluid volume"
      annotation (Placement(transformation(extent={{-20,60},{-40,40}})));
    AixLib.Fluid.FixedResistances.HydraulicDiameter
                                  pressureDropExhaust(
      redeclare final package Medium = Medium1,
      final show_T=false,
      final allowFlowReversal=allowFlowReversal1,
      final m_flow_nominal=m1_flow_nominal,
      dh=d_iExh,
      rho_default=1.18,
      mu_default=1.82*10^(-5),
      length=l_ExhHex)               "Pressure drop"
      annotation (Placement(transformation(extent={{0,50},{20,70}})));
    AixLib.Utilities.HeatTransfer.HeatConvPipeInsideDynamic
      heatConvExhaustPipeInside(
      d_i=d_iExh,
      A_sur=A_surExhHea,
      rho=rho1_in,
      lambda=lambda1_in,
      eta=eta1_in,
      c=cHPControlBus.calMeaCpExh,
      m_flow=cHPControlBus.meaMasFloFueEng + cHPControlBus.meaMasFloAirEng)
                   annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-20,20})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow additionalHeat
      "Heat flow from water condensation in the exhaust gas and generator losses"
      annotation (Placement(transformation(extent={{60,-22},{40,-2}})));
    Modelica.Blocks.Sources.RealExpression latentExhaustHeat(y=if cHPControlBus.isOn
           then m_ConH2OExh*deltaH_Vap else 0)
                      "Calculated latent exhaust heat from water condensation"
      annotation (Placement(transformation(extent={{126,-12},{106,8}})));

    Real QuoT_ExhInOut=senTExhHot.T/senTExhCold.T
    "Quotient of exhaust gas in and outgoing temperature";

     //Variables for water condensation and its usable latent heat calculation
    Real x_H2OExhDry
      "Water load of the exhaust gas";
    Real xSat_H2OExhDry
      "Saturation water load of the exhaust gas";
    Modelica.SIunits.MassFlowRate m_H2OExh
      "Mass flow of water in the exhaust gas";
    Modelica.SIunits.MassFlowRate m_ExhDry
      "Mass flow of dry exhaust gas";
    Modelica.SIunits.MassFlowRate m_ConH2OExh
      "Mass flow of condensing water";
    Modelica.SIunits.AbsolutePressure pExh
      "Pressure in the exhaust gas stream (assuming ambient conditions)";
    Modelica.SIunits.AbsolutePressure pSatH2OExh
      "Saturation vapor pressure of the exhaust gas water";
    Modelica.SIunits.SpecificEnthalpy deltaH_Vap
      "Specific enthalpy of vaporization (empirical formula based on table data)";
    Modelica.SIunits.SpecificHeatCapacity meanCpExh=1227.23
      "Calculated specific heat capacity of the exhaust gas for the calculated combustion temperature"
     annotation (Dialog(group = "Thermal"));
    Modelica.SIunits.HeatFlowRate Q_Gen
      "Calculated loss heat from the induction machine"
     annotation (Dialog(group = "Thermal"));
   /* Modelica.SIunits.HeatFlowRate Q_flowExhHea=senMasFloExh.m_flow*meanCpExh*(
      senTExhHot.T - T_ExhPowUniOut)
    "Calculated exhaust heat from fixed exhaust outlet temperature";*/
    Modelica.SIunits.Temperature T_LogMeanExh
      "Mean logarithmic temperature of exhaust gas";

      //Calculation of the thermodynamic state of the exhaust gas inlet used by the convective heat transfer model
    Medium1.ThermodynamicState state1 = Medium1.setState_pTX(senTExhHot.port_b.p,T_LogMeanExh,senTExhHot.port_b.Xi_outflow);
    Modelica.SIunits.SpecificEnthalpy h1_in = Medium1.specificEnthalpy(state1);
    Modelica.SIunits.DynamicViscosity eta1_in = Medium1.dynamicViscosity(state1);
    Modelica.SIunits.Density rho1_in = Medium1.density_phX(state1.p,h1_in,state1.X);
    Modelica.SIunits.Velocity v1_in = senMasFloExh.m_flow/(Modelica.Constants.pi*rho1_in*d_iExh^2/4);
    Modelica.SIunits.ThermalConductivity lambda1_in = Medium1.thermalConductivity(state1);
    Modelica.SIunits.ReynoldsNumber Re1_in = Modelica.Fluid.Pipes.BaseClasses.CharacteristicNumbers.ReynoldsNumber(v1_in,rho1_in,eta1_in,d_iExh);

    Modelica.Blocks.Sources.RealExpression generatorHeat(y=if cHPControlBus.isOn
           then Q_Gen else 0)
      "Calculated heat from generator losses"
      annotation (Placement(transformation(extent={{126,-32},{106,-12}})));
    Modelica.Blocks.Math.MultiSum multiSum(nu=2)
      annotation (Placement(transformation(extent={{86,-18},{74,-6}})));
    AixLib.Controls.Interfaces.CHPControlBus cHPControlBus(
      meaTemExhOutHex=senTExhCold.T,
      meaTemExhInHex=senTExhHot.T,
      meaThePowOutHex=pipeCoolant.heatPort_outside.Q_flow,
      meaMasFloConHex=m_ConH2OExh,
      meaTemInHex=senTCoolCold.T,
      meaTemOutHex=senTCoolHot.T) annotation (Placement(transformation(extent={
              {-28,72},{28,126}}), iconTransformation(extent={{-28,72},{28,126}})));
  equation
  //Calculation of water condensation and its usable latent heat
    if ConTec then
    x_H2OExhDry=senTExhHot.port_a.Xi_outflow[3]/(1 - senTExhHot.port_a.Xi_outflow[3]);
    xSat_H2OExhDry=if noEvent(M_H2O*pSatH2OExh/((pExh-pSatH2OExh)*M_Exh)>=0) then M_H2O*pSatH2OExh/((pExh-pSatH2OExh)*M_Exh) else x_H2OExhDry;
    m_H2OExh=senMasFloExh.m_flow*senTExhHot.port_a.Xi_outflow[3];
    m_ExhDry=senMasFloExh.m_flow-m_H2OExh;
    m_ConH2OExh=if (x_H2OExhDry>xSat_H2OExhDry) then m_ExhDry*(x_H2OExhDry-xSat_H2OExhDry) else 0;
    pExh=senTExhHot.port_a.p;
    pSatH2OExh=100000*Modelica.Math.exp(A-B/(senTExhCold.T-273.15+C));
    deltaH_Vap=2697400+446.25*senTExhCold.T-4.357*(senTExhCold.T)^2;
    else
    x_H2OExhDry=0;
    xSat_H2OExhDry=0;
    m_H2OExh=0;
    m_ExhDry=0;
    m_ConH2OExh=0;
    pExh=0;
    pSatH2OExh=0;
    deltaH_Vap=0;
    end if;

    if (QuoT_ExhInOut-1)>0.0001 then
    T_LogMeanExh=(senTExhHot.T-senTExhCold.T)/Modelica.Math.log(QuoT_ExhInOut);
    else
    T_LogMeanExh=senTExhHot.T;
    end if;

    connect(senTExhCold.port_b, senMasFloExh.port_a)
      annotation (Line(points={{48,60},{60,60}}, color={0,127,255}));
    connect(port_a1, senTExhHot.port_a)
      annotation (Line(points={{-100,60},{-80,60}}, color={0,127,255}));
    connect(senMasFloExh.port_b, port_b1)
      annotation (Line(points={{80,60},{100,60}}, color={0,127,255}));
    connect(port_a2, senTCoolCold.port_b)
      annotation (Line(points={{100,-60},{80,-60}}, color={0,127,255}));
    connect(senTCoolHot.port_a, senMasFloCool.port_a)
      annotation (Line(points={{-40,-60},{-60,-60}}, color={0,127,255}));
    connect(senMasFloCool.port_b, port_b2)
      annotation (Line(points={{-80,-60},{-100,-60}}, color={0,127,255}));
    connect(port_Ambient, ambientLoss.port_b) annotation (Line(points={{-100,0},{-90,
            0},{-90,-12},{-66,-12}}, color={191,0,0}));
    connect(senTCoolCold.port_a, pipeCoolant.port_a)
      annotation (Line(points={{60,-60},{32.4,-60}}, color={0,127,255}));
    connect(senTCoolHot.port_b, pipeCoolant.port_b)
      annotation (Line(points={{-20,-60},{11.6,-60}}, color={0,127,255}));
    connect(ambientLoss.port_a, heatCapacitor.port)
      annotation (Line(points={{-46,-12},{20,-12}},color={191,0,0}));
    connect(heatCapacitor.port, pipeCoolant.heatPort_outside) annotation (Line(
          points={{20,-12},{20.4,-12},{20.4,-54.4}},color={191,0,0}));
    connect(volExhaust.heatPort, heatConvExhaustPipeInside.port_a)
      annotation (Line(points={{-20,50},{-20,30}}, color={191,0,0}));
    connect(heatConvExhaustPipeInside.port_b, heatCapacitor.port)
      annotation (Line(points={{-20,10},{-20,-12},{20,-12}},color={191,0,0}));
    connect(pressureDropExhaust.port_a, volExhaust.ports[1]) annotation (Line(
          points={{0,60},{-14,60},{-14,64},{-27.3333,64},{-27.3333,60}},
                                                               color={0,127,255}));
    connect(senTExhHot.port_b, volExhaust.ports[2]) annotation (Line(points={{-60,60},
            {-46,60},{-46,64},{-30,64},{-30,60}},     color={0,127,255}));
    connect(pressureDropExhaust.port_b, senTExhCold.port_a)
      annotation (Line(points={{20,60},{28,60}}, color={0,127,255}));
    connect(additionalHeat.port, heatCapacitor.port)
      annotation (Line(points={{40,-12},{20,-12}}, color={191,0,0}));
    connect(additionalHeat.Q_flow, multiSum.y)
      annotation (Line(points={{60,-12},{72.98,-12}}, color={0,0,127}));
    connect(latentExhaustHeat.y, multiSum.u[1]) annotation (Line(points={{105,-2},
            {96,-2},{96,-9.9},{86,-9.9}}, color={0,0,127}));
    connect(generatorHeat.y, multiSum.u[2]) annotation (Line(points={{105,-22},{
            96,-22},{96,-14.1},{86,-14.1}}, color={0,0,127}));
    annotation (Icon(graphics={
          Rectangle(
            extent={{-70,80},{70,-80}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-99,64},{102,54}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-99,-56},{102,-66}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>Exhaust gas heat exchanger for engine combustion and its heat transfer to a cooling circle.</p>
<p><b>Assumptions</b> </p>
<p>- Berechnung eines konvektiven W&auml;rme&uuml;bergangs zwischen Abgas und W&auml;rme&uuml;bertrager als zylindrisches Abgasrohr</p>
<p>-&gt; F&uuml;r den Rohrquerschnitt wird der Anschlussquerschnitt der Erzeugereinheit verwendet, die w&auml;rme&uuml;bertragende Fl&auml;che und die Kapazit&auml;t des W&auml;rme&uuml;bertragers k&ouml;nnen kalibriert werden</p>
<p>-&gt; Bekannte Gr&ouml;&szlig;en sind die Abgastemperatur bei Austritt und die Gr&ouml;&szlig;enordnung des W&auml;rmestroms an den K&uuml;hlwasserkreislauf</p>
<p>- Die W&auml;rme&uuml;bertragung an die Umgebung (G_Amb) und den K&uuml;hlwasserkreislauf (G_Cool) wird mittels W&auml;rmeleitung berechnet</p>
<p>-&gt; Koeffizienten k&ouml;nnen mittels bekannter Gr&ouml;&szlig;en angen&auml;hert werden</p>
<p>- W&auml;rmeleistung aus der Kondensation von Wasser im Abgas kann ber&uuml;cksichtigt werden</p>
<p>-&gt; Berechnung aus der Bestimmung des ausfallenden Wassers &uuml;ber den S&auml;ttigungsdampfdruck und die kritische Beladung im Abgas f&uuml;r den niedrigsten Zustand (bei Austrittstemperatur)</p>
<p>-&gt; Bestimmung der Verdampfungsenthalpie &uuml;ber eine empirische Formel aus Tabellendaten</p>
<p>-&gt; Annahme: Der latente W&auml;rmestrom geht zus&auml;tzlich zum konvektiven W&auml;rmestrom auf die Kapazit&auml;t des Abgasw&auml;rme&uuml;bertragers &uuml;ber</p>
<p><br>- Calculation of a convective heat transfer between exhaust gas and heat exchanger capacity as a cylindrical exhaust pipe</p>
<p>-&gt; For the pipe cross section, the connection cross section of the power unit is used, the heat transfer area and the capacity of the heat exchanger can be calibrated</p>
<p>-&gt; Known quantities are the exhaust gas temperature at the outlet and the magnitude of the heat flow to the cooling water circuit</p>
<p>- The heat transfer to the environment (G_Amb) and the cooling water circuit (G_Cool) is calculated by means of heat conduction</p>
<p>-&gt; Coefficients can be approximated using known quantities</p>
<p>- Heat output from water condensation in the exhaust gas is can be considered</p>
<p>-&gt; Calculation from the determination of the condensing water over the saturation vapor pressure and the critical load in the exhaust gas for the ExhHex outlet state (lowest temperature)</p>
<p>-&gt; Determination of the enthalpy of vaporization using an empirical formula from tabular data</p>
<p>-&gt; Assumption: The latent heat flow is is added to the convective heat flow to the capacity of the exhaust heat exchanger</p>
</html>"));
  end ExhaustHeatExchanger;

  model OnOff_ControllerEasy
    import AixLib;

    parameter
      AixLib.DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord
      CHPEngineModel=DataBase.CHP.ModularCHPEngineData.CHP_ECPowerXRGI15()
      "CHP engine data for calculations"
      annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

    parameter Modelica.SIunits.Time startTimeChp=0
      "Start time for discontinous simulation tests to heat the Chp unit up to the prescribed return temperature";
    Modelica.Blocks.Logical.Timer timerIsOff
      annotation (Placement(transformation(extent={{-6,0},{8,14}})));
    Modelica.Blocks.Logical.Not not1
      annotation (Placement(transformation(extent={{-32,0},{-18,14}})));
    Modelica.Blocks.Logical.LessThreshold declarationTime(threshold=7200)
      annotation (Placement(transformation(extent={{20,0},{34,14}})));
    Modelica.Blocks.Logical.Or pumpControl
      annotation (Placement(transformation(extent={{48,-8},{64,8}})));
    AixLib.Controls.Interfaces.CHPControlBus modularCHPControlBus annotation (
        Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={100,0})));
    Modelica.Blocks.Sources.TimeTable modulationFactorControl(
                            startTime=startTimeChp, table=[0.0,0.8; 7200,0.8;
          7200,0.93; 10800,0.93; 10800,0.62; 14400,0.62; 14400,0.8; 18000,0.8;
          18000,0.0])
      annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
    Modelica.Blocks.Logical.GreaterThreshold greaterThreshold
      annotation (Placement(transformation(extent={{-68,-10},{-48,10}})));
  equation
    connect(timerIsOff.u,not1. y)
      annotation (Line(points={{-7.4,7},{-17.3,7}},    color={255,0,255}));
    connect(timerIsOff.y,declarationTime. u)
      annotation (Line(points={{8.7,7},{18.6,7}},   color={0,0,127}));
    connect(declarationTime.y,pumpControl. u1) annotation (Line(points={{34.7,7},
            {38,7},{38,0},{46.4,0}},  color={255,0,255}));
    connect(pumpControl.y, modularCHPControlBus.isOnPump) annotation (Line(points=
           {{64.8,0},{82,0},{82,-0.1},{100.1,-0.1}}, color={255,0,255}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(modulationFactorControl.y, modularCHPControlBus.modFac) annotation (
        Line(points={{11,-50},{100.1,-50},{100.1,-0.1}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(greaterThreshold.y, not1.u) annotation (Line(points={{-47,0},{-40,0},
            {-40,7},{-33.4,7}}, color={255,0,255}));
    connect(pumpControl.u2, not1.u) annotation (Line(points={{46.4,-6.4},{-40,
            -6.4},{-40,7},{-33.4,7}}, color={255,0,255}));
    connect(greaterThreshold.y, modularCHPControlBus.isOn) annotation (Line(
          points={{-47,0},{-40,0},{-40,-16},{92,-16},{92,-0.1},{100.1,-0.1}},
          color={255,0,255}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(greaterThreshold.u, modulationFactorControl.y) annotation (Line(
          points={{-70,0},{-82,0},{-82,-32},{38,-32},{38,-50},{11,-50}}, color={0,
            0,127}));
    annotation (Icon(graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
            extent={{-86,18},{82,-8}},
            lineColor={28,108,200},
            textString="onOff
Controller
CHP")}), Documentation(info="<html>
<p>Model of an easy on-off-controller for the modular CHP model.</p>
<p>It allows to manually modulate the load of the power unit. A modulation factor (modFac) of 0 indicates that the machine is not in operation.</p>
</html>"));
  end OnOff_ControllerEasy;

  package BaseClassComponents
    "Package with base classe components for AixLib.Fluid.BoilerCHP.ModularCHP"
    extends Modelica.Icons.BasesPackage
  annotation (preferredView="info", Documentation(info="<html>
<p>
This package contains base classes that are used to construct the models in
<a href=\"modelica://AixLib.Fluid.BoilerCHP.ModularCHP\">AixLib.Fluid.BoilerCHP.ModularCHP</a>.
</p>
</html>"));
    class GasolineEngineChp_EngineHousing
      "Engine housing as a simple two layer wall."
      import AixLib;

      replaceable package Medium3 =
          DataBase.CHP.ModularCHPEngineMedia.CHPFlueGasLambdaOnePlus
                                                               constrainedby
        DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                     annotation(choicesAllMatching=true);

      parameter Modelica.SIunits.Thickness dInn=0.005
        "Typical value for the thickness of the cylinder wall (between combustion chamber and cooling circle)"
        annotation (Dialog(tab="Calibration properties"));

      parameter AixLib.Fluid.BoilerCHP.Data.ModularCHP.EngineMaterialData
        EngMatData=AixLib.Fluid.BoilerCHP.Data.ModularCHP.EngineMaterial_CastIron()
        "Thermal engine material data for calculations (most common is cast iron)"
        annotation (choicesAllMatching=true, Dialog(tab="Structure", group=
              "Material Properties"));

      constant Modelica.SIunits.ThermalConductivity lambda=EngMatData.lambda
        "Thermal conductivity of the engine block material" annotation (Dialog(tab="Structure", group="Material Properties"));
      constant Modelica.SIunits.Density rhoEngWall=EngMatData.rhoEngWall
        "Density of the the engine block material" annotation (Dialog(tab="Structure", group="Material Properties"));
      constant Modelica.SIunits.SpecificHeatCapacity c=EngMatData.c
        "Specific heat capacity of the cylinder wall material" annotation (Dialog(tab="Structure", group="Material Properties"));
      constant Real z
        "Number of engine cylinders"
        annotation (Dialog(tab="Structure", group="Engine Properties"));
      constant Modelica.SIunits.Thickness dCyl
        "Engine cylinder diameter"
        annotation (Dialog(tab="Structure", group="Engine Properties"));
      constant Modelica.SIunits.Thickness hStr
        "Engine stroke"
        annotation (Dialog(tab="Structure", group="Engine Properties"));
      constant Real eps
        "Engine compression ratio"
        annotation (Dialog(tab="Structure", group="Engine Properties"));
      parameter Modelica.SIunits.Mass mEng
        "Total engine mass"
        annotation (Dialog(tab="Structure", group="Engine Properties"));
      Real nEng
        "Current engine speed"
        annotation (Dialog(tab="Structure", group="Engine Properties"));
      parameter Modelica.SIunits.ThermalConductance GEngToAmb=0.23
        "Thermal conductance from engine housing to the surrounding air"
       annotation (Dialog(tab="Thermal"));
      parameter Modelica.SIunits.Temperature T_Amb=298.15
        "Ambient temperature"
        annotation (Dialog(tab="Thermal"));

    protected
      constant Modelica.SIunits.Area A_WInn=z*(Modelica.Constants.pi*dCyl*(dCyl/2 + hStr*(1 + 1/(eps - 1))))
        "Area of heat transporting surface from cylinder wall to outer engine block"
        annotation (Dialog(tab="Structure"));
      parameter Modelica.SIunits.Mass mEngWall=A_WInn*rhoEngWall*dInn
        "Calculated mass of cylinder wall between combustion chamber and cooling circle"
        annotation (Dialog(tab="Structure"));
      parameter Modelica.SIunits.Mass mEngBlo=mEng - mEngWall
        "Calculated mass of the remaining engine body"
        annotation (Dialog(tab="Structure"));
      parameter Modelica.SIunits.Thickness dOut=mEngBlo/A_WInn/rhoEngWall
        "Thickness of outer wall of the remaining engine body"
        annotation (Dialog(tab="Structure"));
      parameter Modelica.SIunits.HeatCapacity CEngWall=dInn*A_WInn*rhoEngWall*c
        "Heat capacity of cylinder wall between combustion chamber and cooling circle"
        annotation (Dialog(tab="Thermal"));
      parameter Modelica.SIunits.HeatCapacity CEngBlo=dOut*A_WInn*rhoEngWall*c
        "Heat capacity of the remaining engine body"
        annotation (Dialog(tab="Thermal"));
      parameter Modelica.SIunits.ThermalConductance GInnWall=lambda*A_WInn/dInn
       "Thermal conductance of the inner engine wall"
        annotation (Dialog(tab="Thermal"));
      parameter Modelica.SIunits.ThermalConductance GEngBlo=lambda*A_WInn/dOut
       "Thermal conductance of the remaining engine body"
       annotation (Dialog(tab="Thermal"));

    public
      Modelica.SIunits.ThermalConductance CalT_Exh
     "Calculation variable for the temperature of the exhaust gas";
      Modelica.SIunits.Temperature T_Com
        "Calculated maximum combustion temperature inside the engine"
       annotation (Dialog(tab="Thermal"));
      Modelica.SIunits.Temperature T_CylWall
        "Temperature of cylinder wall";
     /* Modelica.SIunits.Temperature T_LogMeanCool
 "Mean logarithmic coolant temperature" annotation (Dialog(tab="Thermal")); */
      Modelica.SIunits.Temperature T_Exh
        "Inlet temperature of exhaust gas" annotation (Dialog(group="Thermal"));
      Modelica.SIunits.Temperature T_ExhPowUniOut
        "Outlet temperature of exhaust gas"
        annotation (Dialog(tab="Thermal"));
      type RotationSpeed=Real(final unit="1/s", min=0);
      Modelica.SIunits.MassFlowRate m_Exh
        "Mass flow rate of exhaust gas" annotation (Dialog(tab="Thermal"));
      Modelica.SIunits.SpecificHeatCapacity meanCpExh
        "Mean specific heat capacity of the exhaust gas" annotation (Dialog(tab="Thermal"));

      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_Ambient
        annotation (Placement(transformation(extent={{-12,-112},{12,-88}}),
            iconTransformation(extent={{-10,-110},{10,-90}})));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor innerWall(
        C=CEngWall,
        der_T(fixed=false, start=0),
        T(start=T_Amb,
          fixed=true))       annotation (Placement(transformation(
            origin={-24,-58},
            extent={{-10,-10},{10,10}},
            rotation=180)));
      Modelica.Blocks.Sources.RealExpression realExpr1(y=innerWall.T)
        annotation (Placement(transformation(extent={{-116,-48},{-96,-28}})));
      Modelica.Blocks.Sources.RealExpression realExpr2(y=T_CylWall) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-106,-58})));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor innerThermalCond2_1(G=GInnWall/2)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                                                                       rotation=0,
            origin={-10,0})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow actualHeatFlowEngine
        annotation (Placement(transformation(extent={{-56,-58},{-36,-38}})));
      AixLib.Fluid.BoilerCHP.ModularCHP.BaseClasses.BaseClassComponents.GasolineEngineChp_EngineHousing_CylToInnerWall
        cylToInnerWall(
        GInnWall=GInnWall,
        dInn=dInn,
        lambda=lambda,
        A_WInn=A_WInn,
        z=z) annotation (Placement(transformation(rotation=0, extent={{-84,-58},
                {-64,-38}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_CoolingCircle
        annotation (Placement(transformation(extent={{88,-12},{112,12}}),
            iconTransformation(extent={{90,-10},{110,10}})));
      Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor engHeatToCoolant
        annotation (Placement(transformation(extent={{30,-10},{50,10}})));
      AixLib.Fluid.BoilerCHP.ModularCHP.BaseClasses.BaseClassComponents.GasolineEngineChp_EngineHousing_EngineBlock
        engineBlock(
        CEngBlo=CEngBlo,
        GInnWall=GInnWall,
        GEngBlo=GEngBlo,
        dInn=dInn,
        dOut=dOut,
        lambda=lambda,
        rhoEngWall=rhoEngWall,
        c=c,
        A_WInn=A_WInn,
        z=z,
        mEngBlo=mEngBlo,
        mEng=mEng,
        mEngWall=mEngWall,
        GEngToAmb=GEngToAmb,
        outerEngineBlock(T(start=T_Amb))) annotation (Placement(transformation(
              rotation=0, extent={{-6,-46},{14,-26}})));

      Modelica.Blocks.Sources.RealExpression calculatedExhaustTemp(y=T_Exh)
        annotation (Placement(transformation(extent={{28,40},{10,60}})));
      Modelica.Blocks.Interfaces.RealOutput exhaustGasTemperature
        annotation (Placement(transformation(extent={{12,-12},{-12,12}},
            rotation=270,
            origin={0,106}),
            iconTransformation(extent={{14,-14},{-14,14}},
            rotation=270,
            origin={0,122})));
    equation

     /* if EngOp and m_Exh>0.001 then
  T_CylWall=0.5*(T_Com+T_Amb)*CalTCyl;
  else
  T_CylWall=T_Amb;
  end if;*/
      CalT_Exh = meanCpExh*m_Exh;

      if noEvent(nEng*60<800) then
      T_CylWall=innerWall.T;
      T_Exh=innerWall.T;
      else
      T_CylWall=T_Amb+0.2929*(T_Com-T_Amb);
      T_Exh=T_ExhPowUniOut + abs((cylToInnerWall.maximumEngineHeat.y-actualHeatFlowEngine.Q_flow)/CalT_Exh);
      end if;

     // T_CylWall=T_Amb+0.2929*(T_Com-T_Amb);
      // T_CylWall=(T_Com-T_Amb)/Modelica.Math.log(T_Com/T_Amb);

     /* if abs(QuoT_SupRet-1)>0.0001 then
  T_LogMeanCool=(T_CoolSup-T_CoolRet)/Modelica.Math.log(QuoT_SupRet);
  else
  T_LogMeanCool=T_CoolRet;
  end if; */

      connect(actualHeatFlowEngine.port,innerWall. port)
        annotation (Line(points={{-36,-48},{-24,-48}},color={191,0,0}));
      connect(engineBlock.port_a, innerWall.port) annotation (Line(points={{-5,-32},
              {-24,-32},{-24,-48}},      color={191,0,0}));
      connect(cylToInnerWall.y, actualHeatFlowEngine.Q_flow)
        annotation (Line(points={{-63.4,-48},{-56,-48}}, color={0,0,127}));
      connect(cylToInnerWall.T, realExpr2.y) annotation (Line(points={{-83.8,-51},{
              -92,-51},{-92,-58},{-95,-58}},
                                           color={0,0,127}));
      connect(realExpr1.y, cylToInnerWall.T1) annotation (Line(points={{-95,-38},{
              -92,-38},{-92,-45},{-83.8,-45}},
                                            color={0,0,127}));
      connect(engineBlock.port_a1, port_Ambient)
        annotation (Line(points={{0,-45},{0,-100}}, color={191,0,0}));
      connect(innerThermalCond2_1.port_a, innerWall.port)
        annotation (Line(points={{-20,0},{-24,0},{-24,-48}}, color={191,0,0}));
      connect(port_CoolingCircle, engHeatToCoolant.port_b)
        annotation (Line(points={{100,0},{50,0}}, color={191,0,0}));
      connect(innerThermalCond2_1.port_b, engHeatToCoolant.port_a)
        annotation (Line(points={{0,0},{30,0}}, color={191,0,0}));
      connect(calculatedExhaustTemp.y, exhaustGasTemperature)
        annotation (Line(points={{9.1,50},{0,50},{0,106}}, color={0,0,127}));
      annotation (
        Documentation(revisions="<html>
<ul>
<li><i>October, 2016&nbsp;</i> by Peter Remmen:<br/>Transfer to AixLib.</li>
<li><i>October 7, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
</ul>
</html>
",     info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>Engine&nbsp;housing&nbsp;as&nbsp;a&nbsp;simple&nbsp;two&nbsp;layer&nbsp;wall.</p>
<h4>Assumptions</h4>
<p>- Aus einzelnen Zylindern wird eine Gesamtfl&auml;che (Annahme: Zylinder liegt im unteren Totpunkt) berechnet und die W&auml;rmeleitung als ebene Wand modelliert</p>
<p>-&gt; N&auml;herung der unbekannten Motorengeometrie mit zu kalibrierenden W&auml;rme&uuml;berg&auml;ngen an Umgebung und K&uuml;hlwasserkreislauf</p>
<p>- Motorblock besteht aus einem homogenen Material mit bekanntem Gesamtgewicht und teilt sich in einen inneren und einen &auml;u&szlig;eren Teil auf (default ist Grauguss)</p>
<p>- &Ouml;lkreislauf wird zur Vereinfachung als Kapazit&auml;t in dem &auml;u&szlig;eren Motorblock ber&uuml;cksichtigt</p>
<p>-&gt; K&uuml;hlwasserkreislauf liegt zwischen diesen beiden Teilen (nur &auml;u&szlig;erer Teil wechselwirkt mit der Umgebung)</p>
<p>-&gt; Dicke des inneren Motorblocks ist eine wesentliche, aber unbekannte Gr&ouml;&szlig;e (Literatur gibt Werte um 5mm f&uuml;r PKW-Motoren an)</p>
<p>-&gt; Anbauteile und einzelne unterschiedliche Materialschichten im Motorblock bleiben zur Vereinfachung unber&uuml;cksichtigt und k&ouml;nnen durch Kalibration angen&auml;hert werden</p>
<p>- Das isolierende/d&auml;mmende Geh&auml;use der Erzeugereinheit besitzt keine eigene Kapazit&auml;t</p>
<p>-&gt; Erh&ouml;hte Komplexit&auml;t der Modelle wird so vermieden (W&auml;rmeverlust an Umgebung sehr gering)</p>
<p>- W&auml;rme&uuml;bergang (Zylinderwand zu K&uuml;hlwasserkreislauf) wird kalibriert und ist proportional zur Temperaturdifferenz </p>
<p>-&gt; Annahme eines konstanten Durchflusses von K&uuml;hlwasser und Geometrie der K&uuml;hlkan&auml;le ist unbekannt, daher keine Berechnung eines konvektiven W&auml;rme&uuml;bergangs zum K&uuml;hlwasserkreislauf</p>
<p>- Zylinderwand mit homogenem Temperaturprofil gebildet aus der Umgebungstemperatur und der maximalen Verbrennungstemperatur (Temperaturverlauf in Zylinder als Dreieck mit T_Amb - T_Com - T_Amb)</p>
<p>-&gt; Bestimmung einer mittleren Zylinderwandtemperatur mithilfe einer Fl&auml;chenhalbierenden im Temperaturverlauf</p>
<p align=\"center\"><img src=\"modelica://AixLib/Resources/Images/Fluid/BoilerCHP/CylinderWallTemperature.png\" width=\"426\" height=\"300\"
alt=\"Calculation of the cylinder wall temperature\"/> </p>
<p>- From individual cylinders, a total area (assumption: cylinder is at bottom dead center) is calculated and the heat conduction is modeled as a flat wall</p>
<p>-&gt; Approximation of the unknown motor geometry with heat transfers to the environment and the cooling water circuit to be calibrated</p>
<p>- Engine block consists of a homogeneous material with known total weight and is divided into an inner and an outer part (default is gray cast iron)</p>
<p>- Oil circuit is considered as a capacity in the outer engine block for simplicity</p>
<p>-&gt; Cooling water circuit lies between these two parts (only outer part interacts with the environment)</p>
<p>-&gt; Thickness of the inner engine block is an essential, but unknown size (literature indicates values ​​around 5mm for car engines)</p>
<p>-&gt; Attachments and individual different material layers in the engine block are not taken into account for simplicity and can be approximated by calibration</p>
<p>- The insulating housing of the power unit has no own capacity</p>
<p>-&gt; Increased complexity of the models is thus avoided (heat loss to environment on very low level)</p>
<p>- Heat transfer (cylinder wall to cooling water circuit) is calibrated and is proportional to the temperature difference</p>
<p>-&gt; Assumption of a constant flow of cooling water and geometry of the cooling channels is unknown, therefore no calculation of a convective heat transfer to the cooling water circuit</p>
<p>Cylinder wall with homogeneous temperature profile formed from the ambient temperature and the maximum combustion temperature (temperature curve in cylinder as a triangle with T_Amb - T_Com - T_Amb)</p>
<p>-&gt; Determination of a mean cylinder wall temperature using a bisector in the temperature profile</p>
</html>"),   Icon(coordinateSystem(extent={{-100,-100},{100,100}}),
                  graphics={
            Rectangle(
              extent={{-80,80},{-50,-80}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-50,80},{-20,-80}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-20,80},{20,-80}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{20,80},{52,-80}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{50,80},{80,-80}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-86,98},{84,82}},
              lineColor={28,108,200},
              textStyle={TextStyle.Bold},
              textString="%name")}),
        Diagram(coordinateSystem(extent={{-100,-100},{100,100}})));
    end GasolineEngineChp_EngineHousing;

    model GasolineEngineChp_EngineHousing_CylToInnerWall
      Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
        logMeanTempCylWall
        annotation (Placement(transformation(extent={{-76,-22},{-56,-2}})));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor
        innerThermalConductor1(G=GInnWall/2) annotation (Placement(transformation(
              extent={{-32,-22},{-12,-2}}, rotation=0)));
      Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowEngine
        annotation (Placement(transformation(extent={{12,-22},{32,-2}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
        temperatureInnerWall
        annotation (Placement(transformation(extent={{-32,6},{-12,26}})));
      Modelica.Blocks.Nonlinear.VariableLimiter heatLimit(strict=true)
        annotation (Placement(transformation(extent={{12,-54},{28,-38}})));
      Modelica.Blocks.Sources.RealExpression maximumEngineHeat
        annotation (Placement(transformation(extent={{-34,-50},{-14,-30}})));
      Modelica.Blocks.Sources.Constant const(k=0)
        annotation (Placement(transformation(extent={{-24,-60},{-14,-50}})));
      parameter Modelica.SIunits.ThermalConductance GInnWall=lambda*A_WInn/dInn
      "Thermal conductance of the inner engine wall"
      annotation (Dialog(group="Thermal"));
      parameter Modelica.SIunits.Thickness dInn=0.005
        "Typical value for the thickness of the cylinder wall (between combustion chamber and cooling circle)"
        annotation (Dialog(tab="Structure Calculations"));
      parameter Modelica.SIunits.ThermalConductivity lambda=44.5
        "Thermal conductivity of the engine block material" annotation (Dialog(tab="Structure", group="Material Properties"));
      parameter Modelica.SIunits.Area A_WInn=z*(Modelica.Constants.pi*dCyl*(dCyl/2 +
          hStr*(1 + 1/(eps - 1))))
        "Area of heat transporting surface from cylinder wall to outer engine block"
        annotation (Dialog(tab="Structure Calculations"));
      parameter Real z=4
      annotation (Dialog(tab="Structure", group="Engine Properties"));
      Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(
            transformation(rotation=0, extent={{96,-10},{116,10}})));
      Modelica.Blocks.Interfaces.RealInput T(unit="K") annotation (Placement(
            transformation(rotation=0, extent={{-118,-40},{-94,-16}}),
            iconTransformation(extent={{-108,-40},{-88,-20}})));
      Modelica.Blocks.Interfaces.RealInput T1(unit="K") annotation (Placement(
            transformation(rotation=0, extent={{-118,4},{-94,28}}),
            iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-98,30})));
    equation
      connect(heatFlowEngine.Q_flow,heatLimit. u) annotation (Line(points={{22,-22},
              {22,-30},{-46,-30},{-46,-46},{10.4,-46}},     color={0,0,127}));
      connect(innerThermalConductor1.port_b,heatFlowEngine. port_a)
        annotation (Line(points={{-12,-12},{12,-12}},  color={191,0,0}));
      connect(heatFlowEngine.port_b,temperatureInnerWall. port) annotation (Line(
            points={{32,-12},{36,-12},{36,16},{-12,16}},    color={191,0,0}));
      connect(T, logMeanTempCylWall.T) annotation (Line(points={{-106,-28},{-88,
              -28},{-88,-12},{-78,-12}}, color={0,0,127}));
      connect(heatLimit.y, y) annotation (Line(points={{28.8,-46},{54,-46},{54,0},
              {106,0}}, color={0,0,127}));
      connect(logMeanTempCylWall.port, innerThermalConductor1.port_a)
        annotation (Line(points={{-56,-12},{-32,-12}}, color={191,0,0}));
      connect(temperatureInnerWall.T, T1)
        annotation (Line(points={{-34,16},{-106,16}}, color={0,0,127}));
      connect(maximumEngineHeat.y, heatLimit.limit1) annotation (Line(points={{
              -13,-40},{-2,-40},{-2,-39.6},{10.4,-39.6}}, color={0,0,127}));
      connect(const.y, heatLimit.limit2) annotation (Line(points={{-13.5,-55},{-2,
              -55},{-2,-52.4},{10.4,-52.4}}, color={0,0,127}));
      annotation (Icon(graphics={ Rectangle(
              extent={{-60,80},{60,-80}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={170,170,255}),
            Text(
              extent={{-40,50},{42,32}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={0,0,0},
              fillPattern=FillPattern.None,
              textString="Cylinder
to engine"),Line(
              points={{60,0},{96,0},{96,10},{116,0},{96,-10},{96,0}},
              color={238,46,47},
              thickness=1),
            Text(
              extent={{62,14},{94,-2}},
              lineColor={238,46,47},
              lineThickness=1,
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              textString="Q_Cyl",
              fontSize=20)}));
    end GasolineEngineChp_EngineHousing_CylToInnerWall;

    model GasolineEngineChp_EngineHousing_EngineBlock
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor
        innerThermalCond2_2(G=GInnWall/2) annotation (Placement(transformation(
              extent={{-42,-10},{-22,10}},rotation=0)));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor outerThermalCond(
          G=GEngBlo/2) annotation (Placement(transformation(extent={{-10,-10},{10,
                10}},  rotation=0)));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor outerEngineBlock(
        der_T(fixed=false, start=0),
        C=CEngBlo,
        T(start=T_Amb,
          fixed=true))      annotation (Placement(transformation(
            origin={22,-10},
            extent={{-10,-10},{10,10}},
            rotation=180)));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor outerThermalCond2(
         G=GEngBlo/2) annotation (Placement(transformation(extent={{34,-10},{54,10}},
              rotation=0)));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor toAmbient(G=GEngToAmb)
                       annotation (Placement(transformation(extent={{0,-70},{20,-50}},
                       rotation=0)));
      parameter Modelica.SIunits.HeatCapacity CEngBlo=dOut*A_WInn*rhoEngWall*c
        "Heat capacity of the remaining engine body"
        annotation (Dialog(group="Thermal"));
      parameter Modelica.SIunits.ThermalConductance GEngToAmb=0.23
        "Thermal conductance from the engine block to the ambient"    annotation (Dialog(group="Thermal"));
      parameter Modelica.SIunits.ThermalConductance GInnWall=lambda*A_WInn/dInn
      "Thermal conductance of the inner engine wall"
      annotation (Dialog(group="Thermal"));
      parameter Modelica.SIunits.ThermalConductance GEngBlo=lambda*A_WInn/dOut
      "Thermal conductance of the outer engine wall"
      annotation (Dialog(group="Thermal"));
      parameter Modelica.SIunits.Temperature T_Amb=298.15
        "Ambient temperature"
        annotation (Dialog(tab="Thermal"));
      parameter Modelica.SIunits.Thickness dInn=0.005
        "Typical value for the thickness of the cylinder wall (between combustion chamber and cooling circle)"
        annotation (Dialog(tab="Structure Calculations"));
      parameter Modelica.SIunits.Thickness dOut=mEngBlo/A_WInn/rhoEngWall
        "Thickness of outer wall of the remaining engine body"
        annotation (Dialog(tab="Structure Calculations"));
      parameter Modelica.SIunits.ThermalConductivity lambda=44.5
        "Thermal conductivity of the engine block material" annotation (Dialog(tab="Structure", group="Material Properties"));
      parameter Modelica.SIunits.Density rhoEngWall=72000
        "Density of the the engine block material" annotation (Dialog(tab="Structure", group="Material Properties"));
      parameter Modelica.SIunits.SpecificHeatCapacity c=535
        "Specific heat capacity of the cylinder wall material" annotation (Dialog(tab="Structure", group="Material Properties"));
      parameter Modelica.SIunits.Area A_WInn=z*(Modelica.Constants.pi*dCyl*(dCyl/2 +
          hStr*(1 + 1/(eps - 1))))
        "Area of heat transporting surface from cylinder wall to outer engine block"
        annotation (Dialog(tab="Structure Calculations"));
      parameter Real z
      annotation (Dialog(tab="Structure", group="Engine Properties"));
      parameter Modelica.SIunits.Mass mEngBlo=mEng - mEngWall
        annotation (Dialog(tab="Structure Calculations"));
      parameter Modelica.SIunits.Mass mEng
      annotation (Dialog(tab="Structure", group="Engine Properties"));
      parameter Modelica.SIunits.Mass mEngWall=A_WInn*rhoEngWall*dInn
        annotation (Dialog(tab="Structure Calculations"));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a annotation (
          Placement(transformation(rotation=0, extent={{-100,30},{-80,50}}),
            iconTransformation(extent={{-100,30},{-80,50}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a1 annotation (
          Placement(transformation(rotation=0, extent={{-50,-100},{-30,-80}}),
            iconTransformation(extent={{-50,-100},{-30,-80}})));
    equation
      connect(outerThermalCond.port_b,outerEngineBlock. port)
        annotation (Line(points={{10,0},{22,0}},     color={191,0,0}));
      connect(outerThermalCond.port_a,innerThermalCond2_2. port_b)
        annotation (Line(points={{-10,0},{-22,0}},   color={191,0,0}));
      connect(outerEngineBlock.port,outerThermalCond2. port_a)
        annotation (Line(points={{22,0},{34,0}},     color={191,0,0}));
      connect(port_a, innerThermalCond2_2.port_a) annotation (Line(points={{-90,40},
              {-60,40},{-60,0},{-42,0}},         color={191,0,0}));
      connect(port_a1, toAmbient.port_a) annotation (Line(points={{-40,-90},{-40,
              -60},{0,-60}},  color={191,0,0}));
      connect(outerThermalCond2.port_b, toAmbient.port_b) annotation (Line(points={{54,0},{
              70,0},{70,-60},{20,-60}},            color={191,0,0}));
      annotation (Icon(graphics={Rectangle(
              extent={{-80,80},{80,-80}},
              lineColor={28,108,200},
              lineThickness=1,
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid), Text(
              extent={{-60,14},{58,-8}},
              lineColor={255,255,255},
              lineThickness=1,
              fillColor={0,0,0},
              fillPattern=FillPattern.None,
              textString="EngineBlock
to ambient")}));
    end GasolineEngineChp_EngineHousing_EngineBlock;

    model GasolineEngineChp_CHPCombustionEngineModulate
      "Internal combustion engine model for CHP-applications."
      import AixLib;

      replaceable package Medium1 =
          DataBase.CHP.ModularCHPEngineMedia.NaturalGasMixture_TypeAachen
                                                                    constrainedby
        DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                    annotation(choicesAllMatching=true,
          Documentation(revisions="<html>
</html>"));
      replaceable package Medium2 =
          AixLib.DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir
                                                                constrainedby
        DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir
                             annotation(choicesAllMatching=true);

      replaceable package Medium3 =
          DataBase.CHP.ModularCHPEngineMedia.CHPFlueGasLambdaOnePlus constrainedby
        DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                     annotation(choicesAllMatching=true);

      parameter
        AixLib.DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord
        CHPEngData=DataBase.CHP.ModularCHPEngineData.CHP_SenerTecDachsG5_5()
        "Needed engine data for calculations"
        annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

      constant Modelica.SIunits.Volume VCyl = CHPEngData.VEng/CHPEngData.z "Cylinder displacement";
      type RotationSpeed=Real(final unit="1/s", min=0);
      constant RotationSpeed nEngNominal = 25.583 "Nominal engine speed at operating point";
      constant Modelica.SIunits.Power P_mecNominal = CHPEngData.P_mecNominal "Mecanical power output at nominal operating point";
      parameter Modelica.SIunits.Temperature T_Amb=298.15     "Ambient temperature (matches to fuel and combustion air temperature)";
      type GasConstant=Real(final unit="J/(mol.K)");
      constant GasConstant R = 8.31446 "Gasconstant for calculation purposes";
      constant Real QuoDCyl = CHPEngData.QuoDCyl;
      constant Boolean FuelType = Medium1.isGas "True = Gasoline fuel, False = Liquid fuel";
      constant Modelica.SIunits.MassFlowRate m_MaxExh=CHPEngData.P_FueNominal/H_U*(1
           + Lambda*L_St)
        "Maximal exhaust gas flow based on the fuel and combustion properties";
      constant Modelica.SIunits.Mass m_FueEngRot=CHPEngData.P_FueNominal*60/(H_U*
          CHPEngData.nEngMax*CHPEngData.i)
        "Injected fuel mass per engine rotation(presumed as constant)";
      constant Modelica.SIunits.Pressure p_Amb = 101325 "Ambient pressure";
      constant Modelica.SIunits.Pressure p_mi = p_mfNominal+p_meNominal "Constant indicated mean effective cylinder pressure";
      constant Modelica.SIunits.Pressure p_meNominal = CHPEngData.p_meNominal "Nominal mean effective cylinder pressure";
      constant Modelica.SIunits.Pressure ref_p_mfNominal = CHPEngData.ref_p_mfNominal "Friction mean pressure of reference engine for calculation(dCyl=91mm & nEng=3000rpm & TEng=90°C)";
      constant Modelica.SIunits.Pressure p_mfNominal=ref_p_mfNominal*QuoDCyl^(-0.3) "Nominal friction mean pressure";
      constant Modelica.SIunits.Temperature T_ExhOut = CHPEngData.T_ExhPowUniOut "Assumed exhaust gas outlet temperature of the CHP unit for heat calculations";
      constant Modelica.SIunits.SpecificEnergy H_U = Medium1.H_U "Specific calorific value of the fuel";
      constant Real Lambda=CHPEngData.Lambda "Combustion air ratio";
      constant Real L_St = Medium1.L_st "Stoichiometric air consumption per mass fuel";
      constant Real l_Min = L_St*MM_Fuel/MM_Air "Minimum molar air consumption per mole fuel";
      constant Modelica.SIunits.MolarMass MM_Fuel = Medium1.MM "Molar mass of the fuel";
      constant Modelica.SIunits.MolarMass MM_Air = Medium2.MM "Molar mass of the combustion air";
      constant Modelica.SIunits.MolarMass MM_ComExh[:] = Medium3.data[:].MM "Molar masses of the combustion products: N2, O2, H2O, CO2";
      constant Real expFacCpComExh[:] = {0.11, 0.15, 0.20, 0.30} "Exponential factor for calculating the specific heat capacity of N2, O2, H2O, CO2";
      constant Modelica.SIunits.SpecificHeatCapacity cpRefComExh[:] = {1000, 900, 1750, 840} "Specific heat capacities of the combustion products at reference state at 0°C";
      constant Modelica.SIunits.Temperature RefT_Com = 1473.15 "Reference combustion temperature for calculation purposes";

      // Exhaust composition for gasoline fuels

      constant Real n_N2Exh = if FuelType then Medium1.moleFractions_Gas[1] + Lambda*l_Min*Medium2.moleFractions_Air[1]
      else Lambda*l_Min*Medium2.moleFractions_Air[1] "Exhaust: Number of molecules Nitrogen per mole of fuel";
      constant Real n_O2Exh = (Lambda-1)*l_Min*Medium2.moleFractions_Air[2] "Exhaust: Number of molecules Oxygen per mole of fuel";
      constant Real n_H2OExh = if FuelType then 0.5*sum(Medium1.moleFractions_Gas[i]*Medium1.Fuel.nue_H[i] for i in 1:size(Medium1.Fuel.nue_H, 1))
      else 0.5*(Medium1.Fuel.Xi_liq[2]*Medium1.MM/Medium1.Fuel.MMi_liq[2]) "Exhaust: Number of molecules H20 per mole of fuel";
      constant Real n_CO2Exh = if FuelType then sum(Medium1.moleFractions_Gas[i]*Medium1.Fuel.nue_C[i] for i in 1:size(Medium1.Fuel.nue_C, 1))
      else Medium1.Fuel.Xi_liq[1]*Medium1.MM/Medium1.Fuel.MMi_liq[1] "Exhaust: Number of molecules CO2 per mole of fuel";
      constant Real n_ComExh[:] = {n_N2Exh, n_O2Exh, n_H2OExh, n_CO2Exh};
      constant Real n_Exh = sum(n_ComExh[j] for j in 1:size(n_ComExh, 1)) "Number of exhaust gas molecules per mole of fuel";
      constant Modelica.SIunits.MolarMass MM_Exh = sum(n_ComExh[i]*MM_ComExh[i] for i in 1:size(n_ComExh, 1))/sum(n_ComExh[i] for i in 1:size(n_ComExh, 1))
      "Molar mass of the exhaust gas";
      constant Modelica.SIunits.MassFraction X_N2Exh =  MM_ComExh[1]*n_ComExh[1]/(MM_Exh*n_Exh)  "Mass fraction of N2 in the exhaust gas";
      constant Modelica.SIunits.MassFraction X_O2Exh =  MM_ComExh[2]*n_ComExh[2]/(MM_Exh*n_Exh)  "Mass fraction of O2 in the exhaust gas";
      constant Modelica.SIunits.MassFraction X_H2OExh =  MM_ComExh[3]*n_ComExh[3]/(MM_Exh*n_Exh)  "Mass fraction of H2O in the exhaust gas";
      constant Modelica.SIunits.MassFraction X_CO2Exh =  MM_ComExh[4]*n_ComExh[4]/(MM_Exh*n_Exh)  "Mass fraction of CO2 in the exhaust gas";
      constant Modelica.SIunits.MassFraction Xi_Exh[size(n_ComExh, 1)] = {X_N2Exh, X_O2Exh, X_H2OExh, X_CO2Exh};

     // RotationSpeed nEng(max=CHPEngData.nEngMax) = 25.583 "Current engine speed";

      Boolean SwitchOnOff=true
                          "Operation switch of the CHP unit (true=On, false=Off)"
        annotation (Dialog(group="Modulation"));
      RotationSpeed nEng(min=0) "Current engine speed";
      Modelica.SIunits.MassFlowRate m_Exh "Mass flow rate of exhaust gas";
      Modelica.SIunits.MassFlowRate m_CO2Exh "Mass flow rate of CO2 in the exhaust gas";
      Modelica.SIunits.MassFlowRate m_Fue(min=0) "Mass flow rate of fuel";
      Modelica.SIunits.MassFlowRate m_Air(min=0) "Mass flow rate of combustion air";
      Modelica.SIunits.SpecificHeatCapacity meanCpComExh[size(n_ComExh, 1)] "Calculated specific heat capacities of the exhaust gas components for the calculated combustion temperature";
      Modelica.SIunits.SpecificHeatCapacity meanCpExh "Calculated specific heat capacity of the exhaust gas for the calculated combustion temperature";
      Modelica.SIunits.SpecificEnergy h_Exh = 1000*(-286 + 1.011*T_ExhCHPOut - 27.29*Lambda + 0.000136*T_ExhCHPOut^2 - 0.0255*T_ExhCHPOut*Lambda + 6.425*Lambda^2) "Specific enthalpy of the exhaust gas";
      Modelica.SIunits.Power P_eff "Effective(mechanical) engine power";
      Modelica.SIunits.Power P_Fue(min=0) = m_Fue*H_U "Fuel expenses at operating point";
      Modelica.SIunits.Power H_Exh "Enthalpy stream of the exhaust gas";
      Modelica.SIunits.Power CalQ_therm "Calculated heat from engine combustion";
      Modelica.SIunits.Power Q_therm(min=0) "Total heat from engine combustion";
      Modelica.SIunits.Torque Mmot "Calculated engine torque";
      Modelica.SIunits.Temperature T_logEngCool=356.15 "Logarithmic mean temperature of coolant inside the engine"
      annotation(Dialog(group="Parameters"));
      Modelica.SIunits.Temperature T_Com(start=T_Amb) "Temperature of the combustion gases";
      Modelica.SIunits.Temperature T_ExhCHPOut=383.15 "Exhaust gas outlet temperature of CHP unit"
      annotation(Dialog(group="Parameters"));
      Real modFac=1 "Modulation factor for energy outuput control of the Chp unit"
        annotation (Dialog(group="Modulation"));

      // Dynamic engine friction calculation model for the mechanical power and heat output of the combustion engine

      Real A0 = 1.0895-1.079*10^(-2)*(T_logEngCool-273.15)+5.525*10^(-5)*(T_logEngCool-273.15)^2;
      Real A1 = 4.68*10^(-4)-5.904*10^(-6)*(T_logEngCool-273.15)+1.88*10^(-8)*(T_logEngCool-273.15)^2;
      Real A2 = -4.35*10^(-8)+1.12*10^(-9)*(T_logEngCool-273.15)-4.79*10^(-12)*(T_logEngCool-273.15)^2;
      Real B0 = -2.625*10^(-3)+3.75*10^(-7)*(nEng*60)+1.75*10^(-5)*(T_logEngCool-273.15)+2.5*10^(-9)*(T_logEngCool-273.15)*(nEng*60);
      Real B1 = 8.95*10^(-3)+1.5*10^(-7)*(nEng*60)+7*10^(-6)*(T_logEngCool-273.15)-10^(-9)*(T_logEngCool-273.15)*(nEng*60);
      Modelica.SIunits.Pressure p_mf = p_mfNominal*((A0+A1*(nEng*60)+A2*(nEng*60)^2)+(B0+B1*(p_meNominal/100000))) "Current friction mean pressure at operating point";
      Modelica.SIunits.Pressure p_me = (modFac*p_mi)-p_mf "Current mean effective pressure at operating point";
      Real etaMec = p_me/p_mi "Current percentage of usable mechanical power compared to inner cylinder power from combustion";

      Modelica.Fluid.Interfaces.FluidPort_b port_Exhaust(redeclare package
          Medium =
            Medium3)
        annotation (Placement(transformation(extent={{108,-10},{88,10}})));
      Modelica.Fluid.Sources.MassFlowSource_T exhaustFlow(
        use_m_flow_in=true,
        use_T_in=true,
        redeclare package Medium = Medium3,
        X=Xi_Exh,
        use_X_in=false,
        nPorts=1)
        annotation (Placement(transformation(extent={{66,-10},{86,10}})));
      Modelica.Blocks.Sources.RealExpression massFlowExhaust(y=m_Exh)
        annotation (Placement(transformation(extent={{28,-4},{50,20}})));
      Modelica.Blocks.Sources.RealExpression effectiveMechanicalTorque(y=Mmot)
        annotation (Placement(transformation(extent={{18,-12},{-6,12}})));
      Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      Modelica.Mechanics.Rotational.Sources.Torque engineTorque annotation (
          Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=180,
            origin={-30,0})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia(J=0.5*CHPEngData.z/4)
                                                                    annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-68,0})));

      Modelica.Blocks.Interfaces.RealInput exhaustGasTemperature
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=270,
            origin={0,-104}), iconTransformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={0,-70})));
    equation

    for i in 1:size(n_ComExh, 1) loop
      meanCpComExh[i] = cpRefComExh[i]/(expFacCpComExh[i] + 1)/(T_Com/273.15 - 1)*(-1 + (T_Com/273.15)^(expFacCpComExh[i] + 1));
      end for;
      meanCpExh = sum(meanCpComExh[i]*Xi_Exh[i] for i in 1:size(n_ComExh, 1));
      m_Fue = modFac*m_FueEngRot*nEng*CHPEngData.i/60;
      m_Air = m_Fue*Lambda*L_St;
     // m_Exh = m_Fue + m_Air;
      m_CO2Exh = m_Fue*(1+Lambda*L_St)*X_CO2Exh;
      H_Exh = h_Exh*m_Fue*(1+Lambda*L_St);
      if inertia.w>=80 and SwitchOnOff then
      Mmot = CHPEngData.i*p_me*CHPEngData.VEng/(2*Modelica.Constants.pi);
      nEng = inertia.w/(2*Modelica.Constants.pi);
      m_Exh = m_Fue + m_Air;
      elseif inertia.w>=80 and not
                                  (SwitchOnOff) then
      Mmot = -CHPEngData.i*p_mf*CHPEngData.VEng/(2*Modelica.Constants.pi);
      nEng = inertia.w/(2*Modelica.Constants.pi);
      m_Exh = m_Fue + m_Air + 0.0001;
      elseif inertia.w<80 and noEvent(inertia.w>0.1) then
      Mmot = -CHPEngData.i*p_mf*CHPEngData.VEng/(2*Modelica.Constants.pi);
      nEng = inertia.w/(2*Modelica.Constants.pi);
      m_Exh = m_Fue + m_Air + 0.0001;
      else
      Mmot = 0;
      nEng = 0;
      m_Exh = 0.001;
      end if;
      CalQ_therm = P_Fue - P_eff - H_Exh;
      Q_therm = if (nEng>1) and (CalQ_therm>=10) then CalQ_therm else 0;
      T_Com = (H_U-(60*p_me*CHPEngData.VEng)/m_FueEngRot)/((1 + Lambda*L_St)*meanCpExh) + T_Amb;
      P_eff = CHPEngData.i*nEng*p_me*CHPEngData.VEng;
     /* if m_Fue>0 then
  T_Com = (P_Fue - P_eff)/(m_Fue*(1 + Lambda*L_St)*meanCpExh) + T_Amb;
  else
  T_Com = T_Amb;
  end if;  */

      connect(exhaustFlow.m_flow_in, massFlowExhaust.y)
        annotation (Line(points={{66,8},{51.1,8}},   color={0,0,127}));
      connect(exhaustFlow.ports[1], port_Exhaust)
        annotation (Line(points={{86,0},{98,0}},   color={0,127,255}));
      connect(inertia.flange_b, flange_a) annotation (Line(points={{-78,
              1.33227e-015},{-100,1.33227e-015},{-100,0}},
                               color={0,0,0}));
      connect(inertia.flange_a, engineTorque.flange)
        annotation (Line(points={{-58,-1.33227e-015},{-58,1.33227e-015},{-40,
              1.33227e-015}},                    color={0,0,0}));
      connect(exhaustFlow.T_in, exhaustGasTemperature) annotation (Line(points={{64,
              4},{56,4},{56,-40},{0,-40},{0,-104}}, color={0,0,127}));
      connect(engineTorque.tau, effectiveMechanicalTorque.y) annotation (Line(
            points={{-18,-1.55431e-015},{-12,-1.55431e-015},{-12,0},{-7.2,0}},
            color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Bitmap(extent={{-120,-134},{122,134}}, fileName=
                  "modelica://AixLib/Resources/Images/Fluid/BoilerCHP/Icon_ICE.png"),
            Text(
              extent={{-100,80},{100,64}},
              lineColor={28,108,200},
              textStyle={TextStyle.Bold},
              textString="%name")}),                                 Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        Documentation(revisions="<html>
</html>",     info="<html>
<p>Getroffene Annahmen und daraus resultierende Einschr&auml;nkungen des Modells Verbrennungsmotor:</p>
<p>- Volllast- / Nennleistungspunkt der Erzeugereinheit ist bekannt und Wechsel zwischen Stillstand und Volllastbetrieb wird angenommen </p>
<p>-&gt; Modellierender Betrieb ist noch nicht implementiert</p>
<p>- Steuerung des Motors erfolgt &uuml;ber die Freigabe der Brennstoffmenge ab einer Mindestdrehzahl (800rpm) / Die Drehzahl steigt dann bis zum Gleichgewicht mit dem entgegen wirkendem Generatormoment an</p>
<p>- Vollst&auml;ndige und &uuml;berst&ouml;chiometrische Verbrennung wird angenommen zur L&ouml;sung der Bruttoreaktionsgleichung</p>
<p>-&gt; Motor l&auml;uft deutlich unterhalb seiner Leistungsgrenze zur m&ouml;glichst optimalen und schadstoffarmen Brennstoffausnutzung</p>
<p>- Wandtemperatur im Zylinder wird &uuml;ber die gesamte Fl&auml;che gleich angenommen (zeitlich variabel und r&auml;umlich konstant)</p>
<p>-&gt; Berechnung eines gemittelten W&auml;rmeflusses nach Au&szlig;en (Zyklische Betrachtung ist nicht umsetzbar wegen geringem Datenumfang)</p>
<p>- Eintritt von Luft und Brennstoff bei Umgebungsbedingungen und konstante Kraftstoff- und Luftmenge je Verbrennungszyklus</p>
<p>-&gt; Gilt nur bedingt bei Turboaufladung der Motoren, da so die Zylinderf&uuml;llung je nach Ladedruck variieren kann (Geringf&uuml;gige Ber&uuml;cksichtigung durch hinterlegte Nennleistungsdaten)</p>
<p>-&gt; Kommt bei BHKWs gro&szlig;er Leistung zu Einsatz</p>
<p>- Luftverh&auml;ltnis oder Restsauerstoff im Abgas ist bekannt</p>
<p>-&gt; Notwendige Annahme zur Berechnung der Stofffl&uuml;sse (Massenfl&uuml;sse, Zusammensetzung des Abgases)</p>
<p>- Verwendung einer gemittelten spezifischen W&auml;rmekapazit&auml;t des Abgases f&uuml;r einen Temperaturbereich von 0&deg;C bis zur maximalen adiabaten Verbrennungstemperatur</p>
<p>-&gt; Bestimmung &uuml;ber einen Potenzansatz nach M&uuml;ller(1968)</p>
<p>- Reibverluste werden in nutzbare W&auml;rme umgewandelt</p>
<p>- Berechnung der Abgasenthalpie nach einem empirischen Ansatz auf Grundlage von Untersuchungen durch R.Pischinger</p>
<p>-&gt; Verwendung einer Nullpunkttemperatur von 25&deg;C (Eingangszustand der Reaktionsedukte in Verbrennungsluft und Kraftstoff)</p>
<p>-&gt; Ber&uuml;cksichtigung chemischer und thermischer Anteile der Enthalpie</p>
<p>-&gt; Eingeschr&auml;nkte Genauigkeit f&uuml;r dieselmotorische (nicht-vorgemischte) Prozesse</p>
<p>- Enthaltenes Wasser im Kraftstoff oder der Verbrennungsluft wird nicht ber&uuml;cksichtigt</p>
<p>-&gt; Annahme der Lufttrocknung vor Eintritt in Erzeugereinheit -&gt; SONST: Zus&auml;tzliche Schwankungen durch Wettereinfl&uuml;sse m&uuml;ssten ber&uuml;cksichtigt werden</p>
<p>- Nebenprodukte der Verbrennung bleiben unber&uuml;cksichtigt (Stickoxide, Wasserstoff usw.)</p>
<p>-&gt; Umfassende Kenntnis des Verbrennungsprozesses und des Motors notwendig (Geringf&uuml;gige Ber&uuml;cksichtigung in Energiebilanz, da Abgasenthalpie auf empirischen Ansatz nach Messungen beruht)</p>
<p>- Annahme einer direkten Kopplung zwischen Motor und Generator (keine &Uuml;bersetzung dazwischen: n_Mot = n_Gen)</p>
<p>-&gt; Kann aber mithilfe von mechanischen Modulen eingebracht werden</p>
<p>- Annahme eines konstanten indizierten Mitteldrucks als notwendige Ma&szlig;nahme zur Berechnung der Motorleistung </p>
<p>-&gt; Bedeutet, dass der Verbrennungsmotor mit einem gleichbleibenden thermodynamischen Kreisprozess arbeitet</p>
<p>- Ausgehend von einem bekannten Reibmitteldruck bei einer Drehzahl von 3000rpm (falls nicht bekannt, default Mittelwerte aus VK1 von S. Pischinger) wird drehzahl- und temperaturabh&auml;ngig der Reibmitteldruck bestimmt</p>
<p>-&gt; Unterscheidung zwischen SI- und DI-Motor - Weitere Motorenbauarten sind unber&uuml;cksichtigt!</p>
<p><br><br><b><span style=\"color: #005500;\">Assumptions</span></b></p>
<p><br><br>Assumptions made and resulting limitations of the internal combustion engine model:</p>
<p>- Full load / nominal operating point of the power unit is known and a change between standstill and full load operation is assumed</p>
<p>-&gt; Modeling operation is not implemented yet</p>
<p>- The engine is controlled by the release of the fuel quantity from a minimum speed (800rpm) / The speed then increases to equilibrium with the counteracting generator torque</p>
<p>- Complete and superstoichiometric combustion is assumed to solve the gross reaction equation</p>
<p>-&gt; Engine runs well below its performance limit for optimum and low-emission fuel utilization</p>
<p>- Wall temperature in the cylinder is assumed to be the same over the entire surface (variable in time and spatially constant)</p>
<p>-&gt; Calculation of a mean heat flow to the outside (cyclic analysis is not feasible due to missing data)</p>
<p>- Entry of air and fuel at ambient conditions and constant amount of fuel and air per combustion cycle</p>
<p>-&gt; Only conditionally with turbocharging of the engines, since then the cylinder filling can vary depending on the boost pressure (slight consideration due to stored rated performance data)</p>
<p>-&gt; Used in CHPs of high performance</p>
<p>- Air ratio or residual oxygen in the exhaust gas is known</p>
<p>-&gt; Necessary assumption for the calculation of material flows (mass flows, composition of the exhaust gas)</p>
<p>- Use of the mean specific heat capacity of the exhaust gas for a temperature range from 0 &deg; C to the maximum adiabatic combustion temperature</p>
<p>-&gt; Determination of a potency approach according to M&uuml;ller (1968)</p>
<p>- Frictional losses are converted into usable heat</p>
<p>- Calculation of the exhaust gas enthalpy according to an empirical approach based on investigations by R.Pischinger</p>
<p>-&gt; Use of a reference point temperature of 25 &deg; C (initial state of the reaction educts from combustion air and fuel)</p>
<p>-&gt; Consideration of the chemical and thermal proportions of the enthalpy</p>
<p>-&gt; Limited accuracy for diesel engine (non-premixed) processes</p>
<p>- Contained water in the fuel or the combustion air is not considered</p>
<p>-&gt; Assumption of air drying before entering power unit -&gt; ELSE: Additional fluctuations due to weather conditions must be taken into account</p>
<p>- Combustion by-products are ignored (nitrogen oxides, hydrogen, etc.)</p>
<p>-&gt; Comprehensive knowledge of the combustion process and the engine necessary (slight consideration in energy balance, since exhaust enthalpy is based on empirical approach after exhaust gas measurements)</p>
<p>- Assumption of a direct coupling between engine and generator (no translation in between: n_Mot = n_Gen)</p>
<p>-&gt; Can be introduced by means of mechanical modules</p>
<p>- Assumption of a constant indicated mean pressure as a necessary measure for the calculation of engine power</p>
<p>-&gt; Means that the combustion engine operates with a constant thermodynamic cycle</p>
<p>- Based on a known friction mean pressure at a speed of 3000rpm (if not known, default average values ​​from VK1 by S.Pischinger) - Is dependent on speed and temperature of the engine</p>
<p>-&gt; Distinction between SI and DI engine - Other engine types are not considered!</p>
</html>"));
    end GasolineEngineChp_CHPCombustionEngineModulate;
    annotation (Documentation(info="<html>
<p>This package contains base classe components that are used to construct the models in <a href=\"modelica://AixLib.Fluid.ModularCHP\">AixLib.Fluid.ModularCHP</a>. </p>
</html>"));
  end BaseClassComponents;
  annotation (Documentation(info="<html>
<p>
This package contains base classes that are used to construct the models in
<a href=\"modelica://AixLib.Fluid.ModularCHP\">AixLib.Fluid.ModularCHP</a>.
</p>
</html>"));
end BaseClasses;
