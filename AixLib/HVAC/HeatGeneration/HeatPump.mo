within AixLib.HVAC.HeatGeneration;
package HeatPump
  extends Modelica.Icons.Package;

  model HeatPump
    import SI = Modelica.SIunits;
    parameter Boolean HPctrlType =  true "Capacity control type"
      annotation(Dialog(group = "Heat Pump cycle", compact = true, descriptionLabel = true), choices(choice=true
          "On/off heat pump",choice = false "Speed controlled heat pump",
                                radioButtons = true));
    parameter Integer capCalcType = 1 "Type of capacity calculation"
      annotation(Dialog(group = "Heat Pump cycle", compact = true, descriptionLabel = true, enable=HPctrlType), choices(choice=1
          "Polynomial", choice = 2 "Table (only on/off heat pump)",   radioButtons = true));
    replaceable package Medium_con =
        Modelica.Media.Interfaces.PartialMedium
      "Medium outside the refrigerant cycle (Condenser)"
                              annotation (Evaluate=true, Dialog(tab="Evaporator, Condenser",group="Condenser"),choicesAllMatching=true);
      parameter Real quaPresLoss_con=0
      "Pressure loss: Coefficient for quadratic term"   annotation ( Dialog(tab="Evaporator, Condenser",group="Condenser"));
    parameter Real linPresLoss_con=0
      "Pressure loss: Coefficient for linear term"                                annotation ( Dialog(tab="Evaporator, Condenser",group="Condenser"));

    replaceable package Medium_eva =
        Modelica.Media.Interfaces.PartialMedium
      "Medium outside the refrigerant cycle (Evaporator)"
                              annotation (Evaluate=true, Dialog(tab="Evaporator, Condenser",group="Evaporator"),choicesAllMatching=true);

    parameter Real quaPresLoss_eva=0
      "Pressure loss: Coefficient for quadratic term" annotation ( Dialog(tab="Evaporator, Condenser",group="Evaporator"));
    parameter Real linPresLoss_eva=0
      "Pressure loss: Coefficient for linear term"                                annotation ( Dialog(tab="Evaporator, Condenser",group="Evaporator"));

    parameter SI.Volume volume_eva=0.004
      "External medium volume in heat exchanger"                                   annotation ( Dialog(tab="Evaporator, Condenser",group="Evaporator"));
   parameter SI.Volume volume_con=0.004
      "External medium volume in heat exchanger"                                  annotation ( Dialog(tab="Evaporator, Condenser",group="Condenser"));
    parameter AixLib.DataBase.HeatPump.HeatPumpBaseDataDefinition dataTable=
        AixLib.DataBase.HeatPump.EN255.Vitocal350BWH113()
      "Look-up table data for on/off heat pump according to EN255 or EN14511" annotation (
        choicesAllMatching=true, Dialog(enable=HPctrlType and (capCalcType ==
            2), group="Capacity data"));

  public
    replaceable function data_poly =
    AixLib.HVAC.HeatGeneration.HeatPump.Characteristics.constantQualityGrade
      constrainedby AixLib.HVAC.HeatGeneration.HeatPump.Characteristics.baseFct
      "Polynomial heat pump characteristics for inverter heat pump"
     annotation(choicesAllMatching = true,Dialog(enable=(capCalcType==1),group="Capacity data"));

    parameter SI.Temperature T_startEva=273.15 "initial evaporator temperature"
     annotation (Evaluate=true, Dialog(tab="Evaporator, Condenser", group="Initialization", enable=initEvaporatorVol));
    parameter SI.Temperature T_startCon=308.15 "initial condenser temperature"
    annotation (Evaluate=true, Dialog(tab="Evaporator, Condenser", group="Initialization", enable=initCondenserVol));
    replaceable function Corr_icing =
    AixLib.HVAC.HeatGeneration.HeatPump.DefrostCorrection.noModel
      constrainedby
      AixLib.HVAC.HeatGeneration.HeatPump.DefrostCorrection.baseFct
      "Frost/Defrost model (only air-to-water heat pumps)"
     annotation(choicesAllMatching = true,Dialog(enable=(capCalcType==1),group="Defrosting/Icing correction",tab="Advanced"));

    parameter Real N_max=4200 "Maximum speed of compressor in 1/min"  annotation(Dialog(enable=not
                                                                                                (HPctrlType),group="Capacity data"));
    parameter Real N_min=1500 "Minimum speed of compressor in 1/min"  annotation(Dialog(enable=not
                                                                                                (HPctrlType),group="Capacity data"));
    parameter Real N_nom=3600 "Nominal speed of compressor in 1/min"  annotation(Dialog(enable=HPctrlType and (capCalcType == 1),group="Capacity data"));
    parameter Boolean P_eleOutput=false "Electric power consumption"
    annotation (Dialog(group="Optional outputs",tab="Advanced", descriptionLabel = true), choices(checkBox=true));
    parameter Boolean CoP_output=false "CoP"
    annotation (Dialog(group="Optional outputs",tab="Advanced", descriptionLabel = true), choices(checkBox=true));
    parameter Boolean PT1_cycle=false "First Order model for capacity" annotation(Dialog(group = "Start/stop behavior",tab="Advanced"), choices(checkBox=true));
    parameter SI.Time timeConstantCycle=1 "Time constant for first order model"
                                                                                annotation(Dialog(group = "Start/stop behavior",tab="Advanced", enable=PT1_cycle));

    parameter Real eta_ele=1
      "assumption of P_tech/P_el (for calculation of Evaporator load)"                         annotation(Dialog(group="Assumptions",tab="Advanced"));
    parameter Real factorScale=1
      "scaling factor (Attention: not physically correct)"
       annotation(Dialog(group="Assumptions",tab="Advanced"));
    parameter SI.Power P_eleAdd=0
      "additional electric power when heat pump is on (not influenced through scaling factor)"
       annotation(Dialog(group="Assumptions",tab="Advanced"));

    parameter Boolean CorrFlowCo=false
      "Correction of mass flow different from nominal flow in condenser"
      annotation(Dialog(group="Mass flow correction",tab="Advanced"), choices(checkBox=true));
    parameter SI.MassFlowRate mFlow_conNominal=0.5
      "Nominal mass flow rate in condenser, only for polynomials, as already included in data tables"
                                                                                                      annotation(Dialog(group="Mass flow correction",tab="Advanced",enable=(CorrFlowCo and capCalcType==1)));

    parameter Boolean CorrFlowEv=false
      "Correction of mass flow different from nominal flow in evaporator"
      annotation(Dialog(group="Mass flow correction",tab="Advanced"), choices(checkBox=true));
    parameter SI.MassFlowRate mFlow_evaNominal=0.5
      "Nominal mass flow rate in evaporator, only for polynomials, as already included in data tables"
                                                                                                       annotation(Dialog(group="Mass flow correction",tab="Advanced",enable=(CorrFlowEv and capCalcType==1)));

    Partial.HeatExchangerHP  condenser(  redeclare package Medium =
          Medium_con,
      a=quaPresLoss_con,
      b=linPresLoss_con,
      volume=volume_con,
      T_start=T_startCon)      annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={130,0})));
    Partial.HeatExchangerHP  evaporator( redeclare package Medium =
          Medium_eva,
      b=linPresLoss_eva,
      volume=volume_eva,
      a=quaPresLoss_eva,
      T_start=T_startEva)  annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-130,0})));
    Modelica.Fluid.Interfaces.FluidPort_b port_evaOut(redeclare package Medium
        = Medium_eva) "Evaporator fluid output port"
      annotation (Placement(transformation(extent={{-140,-80},{-120,-60}},
            rotation=0)));
    Modelica.Fluid.Interfaces.FluidPort_a port_evaIn(redeclare package Medium
        = Medium_eva) "Evaporator fluid input port"
      annotation (Placement(transformation(extent={{-140,60},{-120,80}},
            rotation=0)));
    Modelica.Fluid.Sensors.TemperatureTwoPort T_evaIn(
                                                redeclare package Medium =
          Medium_eva) annotation (Placement(transformation(
          origin={-130,26},
          extent={{-10,-10},{10,10}},
          rotation=270)));
    Modelica.Fluid.Sensors.TemperatureTwoPort T_conIn(
                                               redeclare package Medium =
          Medium_con) annotation (Placement(transformation(
          origin={130,-26},
          extent={{-10,-10},{10,10}},
          rotation=90)));
    Modelica.Fluid.Interfaces.FluidPort_a port_conIn(redeclare package Medium
        = Medium_con) "Condenser fluid input port"
      annotation (Placement(transformation(extent={{120,-80},{140,-60}},
            rotation=0)));
    Modelica.Fluid.Interfaces.FluidPort_b port_conOut(redeclare package Medium
        = Medium_con) "Condenser fluid ouput port"
      annotation (Placement(transformation(extent={{120,60},{140,80}},
            rotation=0)));
    Modelica.Fluid.Sensors.TemperatureTwoPort T_conOut(
                                               redeclare package Medium =
          Medium_con) annotation (Placement(transformation(
          origin={130,30},
          extent={{-10,-10},{10,10}},
          rotation=90)));
    Modelica.Fluid.Sensors.TemperatureTwoPort T_evaOut(
                                                redeclare package Medium =
          Medium_eva) annotation (Placement(transformation(
          origin={-130,-30},
          extent={{-10,-10},{10,10}},
          rotation=270)));
    Modelica.Fluid.Sensors.MassFlowRate mFlow_con(redeclare package Medium =
          Medium_con) annotation (Placement(transformation(
          origin={130,-50},
          extent={{-10,-10},{10,10}},
          rotation=90)));
    Modelica.Blocks.Interfaces.RealOutput P_eleOut if
                                                     P_eleOutput annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-50,-90})));
    Modelica.Blocks.Interfaces.RealOutput CoP_out if CoP_output annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-10,-90})));

    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heatFlowRate_con
      annotation (Placement(transformation(
          origin={95,1},
          extent={{9,-9},{-9,9}},
          rotation=180)));

  public
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heatFlowRate_eva
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=180,
          origin={-100,2})));

    parameter Modelica.Blocks.Types.Smoothness smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments
      "smoothness of table interpolation" annotation(Dialog(group = "Assumptions",tab="Advanced", enable=not
                                                                                                (capCalcType==1)));

    Modelica.Fluid.Sensors.MassFlowRate mFlow_eva(redeclare package Medium =
          Medium_eva) annotation (Placement(transformation(
          origin={-130,52},
          extent={{-10,-10},{10,10}},
          rotation=270)));
    Partial.Cycle cycle(HPctrlType=HPctrlType,capCalcType=capCalcType,
      dataTable=dataTable,
      redeclare function data_poly=data_poly,
      N_max=N_max,
      N_min=N_min,
      N_nom=N_nom,
      Corr_icing=Corr_icing,
      eta_ele=eta_ele,
      factorScale=factorScale,
      P_eleAdd=P_eleAdd,
      CorrFlowCo=CorrFlowCo,
      CorrFlowEv=CorrFlowEv,
      timeConstantCycle=timeConstantCycle,
      smoothness=smoothness,
      PT1_cycle=true,
      mFlow_conNominal=mFlow_conNominal,
      mFlow_evaNominal=mFlow_evaNominal,
      T_conMax=T_conMax)
      annotation (Placement(transformation(extent={{-50,-20},{40,40}})));
    Modelica.Blocks.Interfaces.BooleanInput onOff_in annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-50,90})));
    Modelica.Blocks.Interfaces.RealInput N_in if not HPctrlType annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-10,90})));

  parameter Boolean heatLosses_con=false
      "Consider heat losses of condenser to ambient"  annotation(Dialog(group="Heat losses of condenser",tab="Advanced"), choices(checkBox=true));
  parameter SI.ThermalConductance R_loss=1
      "Thermal conductance of heat loss to ambient"                                      annotation(Dialog(group = "Heat losses of condenser",tab="Advanced", enable=heatLosses_con));
  protected
    Modelica.Blocks.Interfaces.RealInput N_inInternal
      "Needed to connect to conditional connector";
    Modelica.Blocks.Interfaces.RealInput T_ambInternal
      "Needed to connect to conditional connector";
  public
    Modelica.Blocks.Sources.RealExpression dummyZero(y=0)
      annotation (Placement(transformation(extent={{0,60},{20,80}}, rotation=0)));
    Modelica.Thermal.HeatTransfer.Components.ThermalConductor
                                  heatConv(G=R_loss)
      annotation (Placement(transformation(extent={{80,40},{100,60}})));
    Modelica.Blocks.Interfaces.RealInput T_amb if
                                                 heatLosses_con annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={50,90})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature varTemp
      annotation (Placement(transformation(extent={{80,76},{100,96}})));
    parameter SI.Temperature T_conMax=338.15
      "Maximum condenser outlet temperature" annotation(Dialog(group = "Capacity data"));
    Modelica.Blocks.Math.Gain gainMinusOne(k=-1) annotation (Placement(
          transformation(
          extent={{-5,-5},{5,5}},
          rotation=180,
          origin={-73,5})));
  equation

    if HPctrlType then
      connect(N_inInternal, dummyZero.y);
    else
      connect(N_in,N_inInternal);
    end if;
    connect(N_inInternal,cycle.N_in);

    if heatLosses_con then
      connect(T_ambInternal, T_amb);
      connect(condenser.thermalPort, heatConv.port_b);
    else
      connect(varTemp.T, dummyZero.y);
    end if;
    connect(varTemp.T, T_ambInternal);
    connect(varTemp.port, heatConv.port_a);

    //fluid connections evaporator
    connect(evaporator.port_a1,T_evaIn. port_b) annotation (Line(
        points={{-130,10},{-130,16}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(evaporator.port_b1,T_evaOut. port_a) annotation (Line(
        points={{-130,-10},{-130,-20}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(T_evaOut.port_b,port_evaOut)  annotation (Line(
        points={{-130,-40},{-130,-70}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(port_evaIn, mFlow_eva.port_a) annotation (Line(
        points={{-130,70},{-130,62}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(mFlow_eva.port_b, T_evaIn.port_a) annotation (Line(
        points={{-130,42},{-130,36}},
        color={0,127,255},
        smooth=Smooth.None));

    //fluid connections condenser
    connect(mFlow_con.port_a, port_conIn) annotation (Line(
        points={{130,-60},{130,-70}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(mFlow_con.port_b, T_conIn.port_a) annotation (Line(
        points={{130,-40},{130,-36}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(T_conIn.port_b,condenser. port_a1) annotation (Line(
        points={{130,-16},{130,-10}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(condenser.port_b1,T_conOut. port_a) annotation (Line(
        points={{130,10},{130,20}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(T_conOut.port_b,port_conOut)
     annotation (Line(
        points={{130,40},{130,70}},
        color={0,127,255},
        smooth=Smooth.None));
    // other connections
    connect(heatFlowRate_con.port,condenser. thermalPort) annotation (Line(
        points={{104,1},{104,0},{124,0},{124,3.67394e-016}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(heatFlowRate_eva.port,evaporator. thermalPort) annotation (Line(
        points={{-110,2},{-116.5,2},{-116.5,-1.10218e-015},{-124,
            -1.10218e-015}},
        color={191,0,0},
        smooth=Smooth.None));

    connect(cycle.CoP_out, CoP_out) annotation (Line(
        points={{-8,-17},{-8,-64},{-10,-64},{-10,-90}},
        color={0,0,127},
        smooth=Smooth.None));

    connect(heatFlowRate_eva.Q_flow, gainMinusOne.y) annotation (Line(
        points={{-90,2},{-80,2},{-80,5},{-78.5,5}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(T_conOut.T, cycle.T_conOut) annotation (Line(
        points={{119,30},{60,30},{60,25},{34,25}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(cycle.Qdot_conOut,heatFlowRate_con. Q_flow) annotation (Line(
        points={{34,13},{70,13},{70,1},{86,1}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(cycle.T_conIn,T_conIn. T) annotation (Line(
        points={{34,1},{62,1},{62,-26},{119,-26}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(cycle.mFlow_con, mFlow_con.m_flow) annotation (Line(
        points={{34,7},{54,7},{54,-50},{119,-50}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(cycle.T_evaOut,T_evaOut. T) annotation (Line(
        points={{-44,25},{-48,25},{-48,24},{-58,24},{-58,-30},{-119,-30}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(cycle.mFlow_eva, mFlow_eva.m_flow) annotation (Line(
        points={{-44,19},{-72,19},{-72,52},{-119,52}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(gainMinusOne.u, cycle.Qdot_evaOut) annotation (Line(
        points={{-67,5},{-62,5},{-62,13},{-44,13}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(T_evaIn.T, cycle.T_evaIn) annotation (Line(
        points={{-119,26},{-86,26},{-86,-8},{-50,-8},{-50,1},{-44,1}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(cycle.P_eleOut, P_eleOut) annotation (Line(
        points={{-20,-17},{-18,-17},{-18,-56},{-50,-56},{-50,-90}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(cycle.onOff_in, onOff_in) annotation (Line(
        points={{-20,37},{-22,37},{-22,60},{-50,60},{-50,90}},
        color={255,0,255},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-150,-100},
              {150,100}}), graphics), Icon(coordinateSystem(preserveAspectRatio=true,
            extent={{-150,-100},{150,100}}), graphics={
          Rectangle(
            extent={{-130,90},{130,-90}},
            fillColor={230,230,230},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,0}),
          Rectangle(
            extent={{-120,80},{-80,-80}},
            fillColor={170,213,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,0}),
          Rectangle(
            extent={{80,80},{120,-80}},
            fillColor={255,0,128},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,0}),
          Text(
            extent={{-80,2},{80,-40}},
            lineColor={0,0,0},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid,
            textString="%name
"),       Ellipse(extent={{-80,80},{80,-80}}, lineColor={0,0,0}),
          Line(
            points={{-88,40},{-112,40},{-94,-2},{-112,-40},{-88,-40}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{88,40},{112,40},{94,-2},{112,-40},{88,-40}},
            color={0,0,0},
            smooth=Smooth.None)}),
               Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Heat pump black box model with two simple heat exchangers, no controllers included. </p>
<p>Works as on/off-controlled heat pump or heat pump with capacity control. The type of capacity and electrical power calculation can be chosen: </p>
<ol>
<li>Polynom<br>a) depending on evaporator input temperature, condenser output temperature and variable speed (via conditional speed connector) for capacity controlled heat pumps <br>b) depending on evaporator input temperature, condenser output temperature and nominal speed for on/off-controlled heat pump </li>
<li>Table data according for on/off-controlled heat pump, depending on evaporator input temperature, condenser output temperature </li>
</ol>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\" alt=\"stars: 3 out of 5\"/></p>
<h4><span style=\"color:#008000\">Assumptions</span></h4>
<p>Correction models of the calculation can be activated that effect the efficiency or the start-up and shut-off behavior of the heat pump. </p>
<ol>
<li>Icing and Defrosting: Simple model that uses the evaporator inlet temperature and calculates a factor for CoP correction (according to Wetter and Afjei, 1996). Not enabled for table data, as usually already included (data according EN255 and EN14511). </li>
<li>Mass flow in condenser/evaporator: Model according to Pahud and Lachal, 2004, that corrects the temperatures used within table and polynomial. If the mass flow rates are already taken into account in the chosen polynomial, this sould be deactivated!</li>
<li>First order behavior of heat pump capacity: Start-up and shut-off of heat pump can be modeled with a first order behavior. </li>
<li>Electric efficiency: The electric efficiency of the electric drive is implemented to calculate the evaporator heat flow </li>
<li>Scaling factor: A scaling facor is implemented for scaling of the heat pump power and capacity without effecting the heat pump efficiency which is not physically correct but may be helpful for rough calculation. </li>
<li>Additional electric power: This is a constant value that is added to the power consumption. This may be helpful if e.g. an electric drive operates together with the compressor and shall be included in overall electric power and CoP calculation. </li>
<li>The smoothness of table interpolation can be chosen. </li>
<li>Allowed sink temperature: A maximum condenser outlet temperature limits the condenser heat flow through a PID controller. </li>
</ol>
<h4><span style=\"color:#008000\">Known Limitations</span></h4>
<ul>
<li>Allowed source temperature: No limits for source temperature is implemented. Though, usually this is not a problem if the heat pump is properly integrated into a system model. </li>
<li>Defrost: No direct implementation of defrost behavior. This heat pump does not operate in a defrost mode. Only a general CoP correction can be chosen therefore.</li>
</ul>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The heat pump speed is helt between the boundaries N_min and N_max even if the input speed is higher or lower. But no further controlling is implemented. The control logic is conciously not integrated into this model.</p>
<p>The calculation of the capacity and electric power does not represent any dynamic behavior of the refrigerant cycle as it occurs in real heat pumps. Therefor two possibilities exist, to add dynamic behavior: </p>
<ol>
<li>The condenser and evaporator can be parametized with a certain external fluid volume to represent their thermal inertia in the tab Evaporator/Condenser</li>
<li>A first order element can be added to the calculation in the tab Advanced if the check box PT1_cycle is enabled (see: <i>Correction models)</i></li>
</ol>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Sources:</p>
<ul>
<li>Pahud, D. and Lachal, B.: <i>Mesure des performances thermiques d?une pompe &agrave; chaleur coupl&eacute;e sur des sondes g&eacute;othermiques &agrave; Lugano (TI)</i>. Office f&eacute;d&eacute;ral de l&apos;energie, Bern, Switzerland. 2004. </li>
<li>Wetter, M. and Afjei, T.: <i>TRNSYS TYPE 401 - Kompressionsw&auml;rmepumpe inklusiv Frost- und Taktverluste</i>. Zentralschweizerisches Technikum Luzern - Ingenieruschule HTL, Switzerland. 1996. </li>
</ul>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p>See <a href=\"HVAC.Examples.HeatPump\">HVAC.Examples.HeatPump</a> </p>
</html>",
        revisions="<html>
<p><ul>
<li><i>January 09, 2006&nbsp;</i> by Peter Matthes:<br/>V0.1: Initial configuration.</li>
<li><i>March 27, 2013</i> by Kristian Huchtemann:<br/>Corrected connection of evaporator inlet and outlet temperature connectors. Added maximum condenser temperature implementation.</li>
<li><i>December 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately </li>
<li><i>April 23, 2013&nbsp;</i> by Kristian Huchtemann:<br/>implemented</li>
<li><i>June 23, 2015&nbsp;</i> by Kristian Huchtemann:<br/>formatted for use in AixLib</li>
</ul></p>
</html>"));
  end HeatPump;

  package Partial
    extends Modelica.Icons.BasesPackage;

    model HeatExchangerHP
      import SI = Modelica.SIunits;
     outer Modelica.Fluid.System system;

        parameter Boolean use_p_start=true "select p_start or d_start"
        annotation (Evaluate=true, Dialog(tab="Initialization"));

      parameter Medium.AbsolutePressure p_start = system.p_start
        "Start value of pressure"
        annotation(Dialog(tab = "Initialization"));
      parameter Boolean use_T_start = true
        "= true, use T_start, otherwise h_start"
        annotation(Dialog(tab = "Initialization"), Evaluate=true);
      parameter Medium.Temperature T_start=
        if use_T_start then system.T_start else Medium.temperature_phX(p_start,h_start,X_start)
        "Start value of temperature"
        annotation(Dialog(tab = "Initialization", enable = use_T_start));
      parameter Medium.SpecificEnthalpy h_start=
        if use_T_start then Medium.specificEnthalpy_pTX(p_start, T_start, X_start) else Medium.h_default
        "Start value of specific enthalpy"
        annotation(Dialog(tab = "Initialization", enable = not use_T_start));
      parameter Medium.MassFraction X_start[Medium.nX] = Medium.X_default
        "Start value of mass fractions m_i/m"
        annotation (Dialog(tab="Initialization", enable=Medium.nXi > 0));
      parameter Medium.ExtraProperty C_start[Medium.nC](
           quantity=Medium.extraPropertiesNames)=fill(0, Medium.nC)
        "Start value of trace substances"
       annotation (Dialog(tab="Initialization", enable=Medium.nC > 0));
      parameter SI.MassFlowRate m_flow_start=0.5 annotation (Dialog(tab="Initialization"));

     replaceable package Medium =
          Modelica.Media.Interfaces.PartialMedium "Medium model"
         annotation (choicesAllMatching=true);
           parameter Real a=0 "Pressure loss: Coefficient for quadratic term";
      parameter Real b=0 "Pressure loss: Coefficient for linear term";
      parameter SI.Volume volume=0.004
        "External medium volume in heat exchanger";

      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermalPort
        "Thermal port" annotation (extent=[-10,50; 10,70]);

      Modelica.Fluid.Fittings.GenericResistances.VolumeFlowRate
                                                   simpleGenericOrifice(
         redeclare package Medium = Medium,
        m_flow(start=m_flow_start),
        a=a,
        b=b)                 annotation (extent=[20,-10; 40,10], Placement(
            transformation(extent={{26,-10},{46,10}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b1( redeclare package Medium
          =                                                                     Medium)
        "Fluid connector b (positive design flow direction is from port_a to port_b)"
        annotation (extent=[90,-10; 110,10]);
      Modelica.Fluid.Interfaces.FluidPort_a port_a1( redeclare package Medium
          =                                                                     Medium)
        "Fluid inlet port" annotation (extent=[-110,-10; -90,10]);

      Modelica.Fluid.Vessels.ClosedVolume fluidVolume(
        redeclare package Medium = Medium,
        T_start(displayUnit="K") = T_start,
        nPorts=2,
        use_HeatTransfer=true,
        use_portsData=false,
        V=volume)
        annotation (Placement(transformation(extent={{-25.5,-1},{-4.5,20}})));
    equation
      connect(simpleGenericOrifice.port_b, port_b1) annotation (Line(
          points={{46,0},{100,0}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(fluidVolume.ports[1], simpleGenericOrifice.port_a) annotation (
          Line(
          points={{-17.1,-1},{-17.1,-2},{4,-2},{4,0},{26,0}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(port_a1, fluidVolume.ports[2]) annotation (Line(
          points={{-100,0},{-48,0},{-48,-1},{-12.9,-1}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(fluidVolume.heatPort, thermalPort) annotation (Line(
          points={{-25.5,9.5},{-36,9.5},{-36,34},{0,34},{0,60}},
          color={191,0,0},
          smooth=Smooth.None));
      annotation (Diagram(graphics),
                           Icon(Rectangle(extent=[-100,60; 100,-60], style(
              color=0,
              rgbcolor={0,0,0},
              gradient=2,
              fillColor=30,
              rgbfillColor={215,215,215})), Text(
            extent=[-100,-60; 100,-100],
            style(color=3, rgbcolor={0,0,255}),
            string="%name")),
        Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>
Models external fluid volumes and pressure drop in a heat pump. Used as condenser and evaporator in model HeatPump. It uses the Modelica.Fluid.Vessels.ClosedVolume and Modelica.Fluid.Fittings.GenericResistances.VolumeFlowRate model.
</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://AixLib/Images/stars3.png\" alt=\"stars: 3 out of 5\"/></p>
</html>",
        revisions="<html>
<ul>
<li><i>December 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
  <li>
         by Kristian Huchtemann:<br>
         Implemented.</li>
</ul>
</html>"),       Documentation(info="<html>
 
<dl>
<dt><b>Main Author: </b>
<dd>Kristian Huchtemann <br>
    E.ON Energy Research Center <br>
    Institute for Energy Efficient Buildings and Indoor Climate <br>
    J&auml;gerstra&szlig;e 17/19 <br> 
    D-52066 Aachen <br>
    <a href=\"mailto:khuchtemann@eonerc.rwth-aachen.de\">khuchtemann@eonerc.rwth-aachen.de</a><br>
    <a href=\"http://www.eonerc.rwth-aachen.de/ebc\">www.eonerc.rwth-aachen.de/ebc</a><br>
</dl>
 
</html>"));
    end HeatExchangerHP;

    model Cycle
      import SI = Modelica.SIunits;
      parameter Boolean HPctrlType =  true "Capacity control type"
        annotation(Dialog(group = "Heat Pump cycle", compact = true, descriptionLabel = true), choices(choice=true
            "On/off heat pump",choice = false "Speed controlled heat pump",
                                  radioButtons = true));
      parameter Integer capCalcType = 1 "Type of capacity calculation"
        annotation(Dialog(group = "Heat Pump cycle", compact = true, descriptionLabel = true, enable=HPctrlType), choices(choice=1
            "Polynomial", choice = 2 "Table (only on/off heat pump)",   radioButtons = true));

      parameter DataBase.HeatPump.HeatPumpBaseDataDefinition dataTable=
          AixLib.DataBase.HeatPump.EN255.Vitocal350BWH113()
        "Look-up table data for on/off heat pump according to EN255/EN14511"
        annotation (choicesAllMatching=true, Dialog(enable=HPctrlType and (
              capCalcType == 2), group="Capacity data"));
    protected
      final parameter Real tableQdot_con[:,:]=dataTable.tableQdot_con;
      final parameter Real tableP_ele[:,:]= dataTable.tableP_ele;
    public
      replaceable function data_poly =
      AixLib.HVAC.HeatGeneration.HeatPump.Characteristics.constantQualityGrade
        constrainedby
        AixLib.HVAC.HeatGeneration.HeatPump.Characteristics.baseFct
        "Polynomial heat pump characteristics"
       annotation(choicesAllMatching = true,Dialog(enable=(capCalcType==1),group="Capacity data"));

      replaceable function Corr_icing =
      AixLib.HVAC.HeatGeneration.HeatPump.DefrostCorrection.noModel
        constrainedby
        AixLib.HVAC.HeatGeneration.HeatPump.DefrostCorrection.baseFct
        "Frost/Defrost model (only air-to-water heat pumps)"
       annotation(choicesAllMatching = true,Dialog(enable=(capCalcType==1),group="Defrosting/Icing correction",tab="Advanced"));
    parameter SI.Temperature T_conMax=338.15
        "Maximum condenser outlet temperature"                                        annotation(Dialog(group="Heat Pump cycle"));
      parameter Real N_max=4200 "Maximum speed of compressor in 1/min"  annotation(Dialog(enable=not
                                                                                                (HPctrlType),group="Capacity data"));
      parameter Real N_min=1500 "Minimum speed of compressor in 1/min"  annotation(Dialog(enable=not
                                                                                                (HPctrlType),group="Capacity data"));
      parameter Real N_nom=3600 "Nominal speed of compressor in 1/min"  annotation(Dialog(enable=HPctrlType and (capCalcType == 1),group="Capacity data"));
      parameter Boolean PT1_cycle=false "First Order model for capacity" annotation(Dialog(group = "Start/stop behavior",tab="Advanced"), choices(checkBox=true));
      parameter SI.Time timeConstantCycle=1
        "Time constant for first order model"                                     annotation(Dialog(group = "Start/stop behavior",tab="Advanced", enable=PT1_cycle));
      parameter Real eta_ele=1
        "assumption of P_tech/P_el (for calculation of Evaporator load)"                         annotation(Dialog(group="Assumptions",tab="Advanced"));
      parameter Real factorScale=1
        "scaling factor (Attention: not physically correct)"
         annotation(Dialog(group="Assumptions",tab="Advanced"));
      parameter SI.Power P_eleAdd=0
        "additional electric power when heat pump is on (not influenced through scaling factor)"
        annotation(Dialog(group="Assumptions",tab="Advanced"));

      parameter Boolean CorrFlowCo=false
        "Correction of mass flow different from nominal flow in condenser (use only if not included in polynom)"
        annotation(Dialog(group="Mass flow correction",tab="Advanced"), choices(checkBox=true));

      parameter SI.MassFlowRate mFlow_conNominal=0.5
        "Nominal mass flow rate in condenser"
      annotation(Dialog(group="Mass flow correction",tab="Advanced", enable=(CorrFlowCo and capCalcType==1)));

      parameter Boolean CorrFlowEv=false
        "Correction of mass flow different from nominal flow in evaporator  (use only if not included in polynom)"
        annotation(Dialog(group="Mass flow correction",tab="Advanced"), choices(checkBox=true));

      parameter SI.MassFlowRate mFlow_evaNominal=0.5
        "Nominal mass flow rate in evaporator"
      annotation(Dialog(group="Mass flow correction",tab="Advanced",enable=(CorrFlowEv and capCalcType==1)));

      SI.Power P_ele;
      SI.Power P_eleChar;
      SI.HeatFlowRate Qdot_eva;
      SI.HeatFlowRate Qdot_con;
      SI.HeatFlowRate Qdot_conChar;
      Real CoP;
      Real CoP_corr;
      Real CoP_char;
      Real N;
      Real factorCoP_icing;
      Real Char[2];
      Real T_conOutCorr;
      Real T_evaInCorr;

      Modelica.Blocks.Interfaces.RealOutput P_eleOut annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-50,-90})));
      Modelica.Blocks.Interfaces.BooleanInput onOff_in annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-50,90})));
      Modelica.Blocks.Interfaces.RealOutput CoP_out annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-10,-90})));
      Modelica.Blocks.Interfaces.RealInput N_in  annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-10,90})));

    protected
      Modelica.Blocks.Interfaces.RealInput firstOrder_outInternal
        "Needed to connect to conditional model";
      Modelica.Blocks.Interfaces.RealOutput firstOrder_inInternal
        "Needed to connect to conditional model";
      Modelica.Blocks.Interfaces.RealInput Qdot_conTableInternal
        "Needed to connect to conditional model";
      Modelica.Blocks.Interfaces.RealInput P_eleTableInternal
        "Needed to connect to conditional model";
      SI.MassFlowRate mFlow_conNom;
      SI.MassFlowRate mFlow_evaNom;

    public
      Modelica.Blocks.Sources.RealExpression realQdot_con(y=Qdot_con)
        annotation (Placement(transformation(extent={{40,24},{60,44}},
              rotation=0)));
    public
      Modelica.Blocks.Sources.RealExpression realQdot_eva(y=Qdot_eva)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=180,
            origin={-110,-10})));
    public
      Modelica.Blocks.Sources.RealExpression realPel(y=P_ele) annotation (Placement(
            transformation(extent={{-92,-40},{-72,-20}}, rotation=0)));
    public
      Modelica.Blocks.Sources.RealExpression realCoP(y=CoP) annotation (Placement(
            transformation(extent={{-32,-66},{-12,-46}}, rotation=0)));

      Modelica.Blocks.Tables.CombiTable2D Qdot_ConTable(
        tableName="NoName",
        fileName="NoName",
        table=tableQdot_con,
        smoothness=smoothness) if
                                not (capCalcType == 1)
        annotation (extent=[-60,40; -40,60], Placement(transformation(extent={{-40,20},
                {-20,40}})));

      Modelica.Blocks.Tables.CombiTable2D P_eleTable(
        tableName="NoName",
        fileName="NoName",
        table=tableP_ele,
        smoothness=smoothness) if
                            not (capCalcType == 1) "Electrical power table"
        annotation (extent=[-60,-20; -40,0], Placement(transformation(extent={{-40,-10},
                {-20,10}})));
    public
      Modelica.Blocks.Sources.RealExpression realT_evaIn(y=T_evaInCorr)
        annotation (Placement(transformation(extent={{-94,26},{-74,46}}, rotation=0)));
    public
      Modelica.Blocks.Sources.RealExpression realT_conOut(y=T_conOutCorr)
        annotation (Placement(transformation(extent={{-94,6},{-74,26}}, rotation=0)));
      Modelica.Blocks.Continuous.FirstOrder firstOrder(T=timeConstantCycle) if
                                                                        PT1_cycle
        annotation (Placement(transformation(extent={{42,-6},{62,14}})));
    public
      Modelica.Blocks.Math.Product productPelCoP1 annotation (Placement(
            transformation(extent={{8,-46},{28,-26}}, rotation=0)));
      Modelica.Blocks.Math.UnitConversions.To_degC t_Ev_in
        annotation (extent=[-88,38; -76,50], Placement(transformation(extent={{-68,30},
                {-56,42}})));
      Modelica.Blocks.Math.UnitConversions.To_degC t_Co_out
        annotation (extent=[-88,38; -76,50], Placement(transformation(extent={{-68,10},
                {-56,22}})));
    public
      Modelica.Blocks.Sources.RealExpression dummyZero(y=0) annotation (Placement(
            transformation(extent={{40,-86},{60,-66}}, rotation=0)));
    public
      Modelica.Blocks.Sources.RealExpression realCoP_corr(y=CoP_corr) annotation (
          Placement(transformation(extent={{-32,-50},{-12,-30}}, rotation=0)));
      parameter Modelica.Blocks.Types.Smoothness smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments
        "smoothness of table interpolation" annotation(Dialog(group = "Assumptions",tab="Advanced", enable=not
                                                                                                (capCalcType==1)));
    public
      Modelica.Blocks.Logical.TriggeredTrapezoid realP_eleAdd(amplitude=P_eleAdd)
        annotation (Placement(transformation(extent={{-72,-54},{-64,-46}},
              rotation=0)));
    public
      Modelica.Blocks.Logical.GreaterThreshold greaterZero annotation (Placement(
            transformation(extent={{-88,-54},{-80,-46}}, rotation=0)));
      Modelica.Blocks.Math.Add add
        annotation (Placement(transformation(extent={{-56,-52},{-46,-42}})));

    public
      Modelica.Blocks.Sources.RealExpression dummyOne(y=1) annotation (Placement(
            transformation(extent={{40,-70},{60,-50}}, rotation=0)));

    public
      Modelica.Blocks.Interfaces.RealOutput Qdot_conOut "Value of Real output"
        annotation (Placement(transformation(extent={{120,0},{140,20}})));
      Modelica.Blocks.Math.UnitConversions.To_degC t_conIn
        annotation (extent=[-88,38; -76,50], Placement(transformation(extent={{116,-36},
                {104,-24}})));
      Modelica.Blocks.Interfaces.RealInput T_conIn
        "Connector of Real input signal to be converted" annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={130,-30})));
      Modelica.Blocks.Interfaces.RealInput T_evaIn
        "Connector of Real input signal to be converted" annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-130,-30})));
      Modelica.Blocks.Interfaces.RealOutput Qdot_evaOut "Value of Real output"
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-130,10})));
      Modelica.Blocks.Interfaces.RealInput T_conOut
        "Connector of Real input signal to be converted" annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={130,50})));
      Modelica.Blocks.Interfaces.RealInput T_evaOut
        "Connector of Real input signal to be converted" annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-130,50})));
      Modelica.Blocks.Interfaces.RealInput mFlow_eva
        "Connector of Real input signal to be converted" annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-130,30})));
      Modelica.Blocks.Interfaces.RealInput mFlow_con
        "Connector of Real input signal to be converted" annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={130,-10})));
    public
      Modelica.Blocks.Sources.RealExpression maxTempCon(y=T_conMax) annotation (
          Placement(transformation(extent={{14,52},{34,72}}, rotation=0)));
    public
      Modelica.Blocks.Math.Product productPelCoP2 annotation (Placement(
            transformation(extent={{80,30},{100,50}}, rotation=0)));
      Modelica.Blocks.Continuous.LimPID PIDmaxHeatFlowCon(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        Ti=1,
        yMax=1,
        yMin=0,
        y_start=1) annotation (Placement(transformation(extent={{46,52},{66,72}})));
    equation
      // correction of temperatures used in the table/polynomial
      if capCalcType==1 then
        mFlow_conNom= mFlow_conNominal;
        mFlow_evaNom= mFlow_evaNominal;
      else
        mFlow_conNom=dataTable.mFlow_conNom;
        mFlow_evaNom=dataTable.mFlow_evaNom;
      end if;

      if CorrFlowCo then
        T_conOutCorr=1/2*(mFlow_con/mFlow_conNom*(T_conOut-T_conIn)+T_conIn+T_conOut);
      else
        T_conOutCorr=T_conOut;
      end if;

      if CorrFlowEv then
        T_evaInCorr=1/2*(mFlow_eva/mFlow_evaNom*(T_evaIn-T_evaOut)+(T_evaIn+T_evaOut));
      else
        T_evaInCorr=T_evaIn;
      end if;

      // determination of speed N
    if HPctrlType then
        N=N_nom;
    else
      if N_in > N_max then
          N=N_max;
      else
        if N_in < N_min then
          N=N_min;
        else
          N=N_in;
        end if;
      end if;
    end if;
      // determination of basic heat pump characteristics Qdot_conChar and P_eleChar and CoP_char
      if capCalcType==1 then //polynom
        Char=data_poly(N,T_conOutCorr, T_evaInCorr,mFlow_con,mFlow_eva);
      else //table
        Char={P_eleTableInternal,Qdot_conTableInternal};
      end if;

      if onOff_in then
        Qdot_conChar=Char[2];
        P_eleChar=Char[1];
        CoP_char=Qdot_conChar/P_eleChar;
      else
        Qdot_conChar=0;
        P_eleChar=0;
        CoP_char=0;
      end if;

      // determination of CoP-corrections
      if capCalcType==1 then
        factorCoP_icing=Corr_icing( T_evaInCorr-273.15);
      else
        factorCoP_icing=1;
      end if;

      CoP_corr=CoP_char*factorCoP_icing;//*f_cop_spread;

        P_ele=P_eleChar*factorScale;
      Qdot_con=firstOrder_outInternal;
      if onOff_in then
        if Qdot_con-P_ele*eta_ele>0 then
          Qdot_eva=Qdot_con-P_ele*eta_ele;
        else
          Qdot_eva=0;
        end if;
        CoP=Qdot_con/add.y;
      else
        Qdot_eva=0;
        CoP=0;
      end if;
      //internal connections for conditional models

      connect(productPelCoP1.y, firstOrder_inInternal);
      if PT1_cycle then
        connect(firstOrder_inInternal,firstOrder.u);
        connect(firstOrder.y,firstOrder_outInternal);
      else
         connect(firstOrder_inInternal,firstOrder_outInternal);
      end if;

       if capCalcType==1 then //polynom
        connect(Qdot_conTableInternal, dummyZero.y);
        connect(P_eleTableInternal, dummyZero.y);
       else
         connect(Qdot_conTableInternal,Qdot_ConTable.y);
        connect(P_eleTableInternal, P_eleTable.y);
       end if;

      connect(realPel.y, productPelCoP1.u1) annotation (Line(
          points={{-71,-30},{6,-30}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(realCoP.y, CoP_out) annotation (Line(
          points={{-11,-56},{-10,-56},{-10,-90}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(realT_evaIn.y, t_Ev_in.u) annotation (Line(
          points={{-73,36},{-69.2,36}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(realT_conOut.y, t_Co_out.u) annotation (Line(
          points={{-73,16},{-69.2,16}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(realCoP_corr.y, productPelCoP1.u2) annotation (Line(
          points={{-11,-40},{-2,-40},{-2,-42},{6,-42}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(t_Ev_in.y,Qdot_ConTable. u2) annotation (Line(
          points={{-55.4,36},{-50,36},{-50,24},{-42,24}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(t_Ev_in.y, P_eleTable.u2) annotation (Line(
          points={{-55.4,36},{-50,36},{-50,-6},{-42,-6}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(t_Co_out.y,Qdot_ConTable. u1) annotation (Line(
          points={{-55.4,16},{-48,16},{-48,36},{-42,36}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(t_Co_out.y, P_eleTable.u1) annotation (Line(
          points={{-55.4,16},{-48,16},{-48,6},{-42,6}},
          color={0,0,127},
          smooth=Smooth.None));

      connect(greaterZero.y, realP_eleAdd.u) annotation (Line(
          points={{-79.6,-50},{-78,-50},{-78,-48},{-76,-48},{-76,-50},{-72.8,-50}},
          color={255,0,255},
          smooth=Smooth.None));

      connect(realPel.y, greaterZero.u) annotation (Line(
          points={{-71,-30},{-66,-30},{-66,-40},{-92,-40},{-92,-50},{-88.8,-50}},
          color={0,0,127},
          smooth=Smooth.None));

      connect(realP_eleAdd.y, add.u2) annotation (Line(
          points={{-63.6,-50},{-57,-50}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(realPel.y, add.u1) annotation (Line(
          points={{-71,-30},{-66,-30},{-66,-40},{-62,-40},{-62,-44},{-57,-44}},
          color={0,0,127},
          smooth=Smooth.None));

      connect(t_conIn.u,T_conIn)  annotation (Line(
          points={{117.2,-30},{130,-30}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(realQdot_eva.y,Qdot_evaOut)  annotation (Line(
          points={{-121,-10},{-130,-10},{-130,10}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(add.y, P_eleOut) annotation (Line(
          points={{-45.5,-47},{-40,-47},{-40,-66},{-50,-66},{-50,-90}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(productPelCoP2.y, Qdot_conOut) annotation (Line(
          points={{101,40},{112,40},{112,10},{130,10}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(realQdot_con.y, productPelCoP2.u2) annotation (Line(
          points={{61,34},{78,34}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(PIDmaxHeatFlowCon.u_s, maxTempCon.y) annotation (Line(
          points={{44,62},{35,62}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(PIDmaxHeatFlowCon.u_m, T_conOut) annotation (Line(
          points={{56,50},{4,50},{4,80},{114,80},{114,50},{130,50}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(PIDmaxHeatFlowCon.y, productPelCoP2.u1) annotation (Line(
          points={{67,62},{70,62},{70,46},{78,46}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-150,-100},
                {150,100}}), graphics), Icon(coordinateSystem(preserveAspectRatio=true,
              extent={{-150,-100},{150,100}}), graphics={
            Rectangle(
              extent={{-130,90},{130,-90}},
              fillColor={230,230,230},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,0}),
            Text(
              extent={{-80,2},{80,-40}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              textString="%name
"),         Ellipse(extent={{-80,80},{80,-80}}, lineColor={0,0,0})}),
                 Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Heat pump refrigerant circuit black box model, no controllers included. It is used within the HeatPump model and delivers the basic functionality of the heat pump. The HeatPump model only adds the external heat exchangers and according connectors. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\" alt=\"stars: 3 out of 5\"/></p>
<h4><span style=\"color:#008000\">Assumptions</span></h4>
<p>Correction models of the calculation can be activated that effect the efficiency or the start-up and shut-off behavior of the heat pump. </p>
<ol>
<li>Icing and Defrosting: Simple model that uses the evaporator inlet temperature and calculates a factor for CoP correction (according to Wetter and Afjei, 1996). Not enabled for table data, as usually already included (data according EN255 and EN14511). </li>
<li>Mass flow in condenser/evaporator: Model according to Pahud and Lachal, 2004, that corrects the temperatures used within table and polynomial. If the mass flow rates are already taken into account in the chosen polynomial, this sould be deactivated!</li>
<li>First order behavior of heat pump capacity: Start-up and shut-off of heat pump can be modeled with a first order behavior. </li>
<li>Electric efficiency: The electric efficiency of the electric drive is implemented to calculate the evaporator heat flow </li>
<li>Scaling factor: A scaling facor is implemented for scaling of the heat pump power and capacity without effecting the heat pump efficiency which is not physically correct but may be helpful for rough calculation. </li>
<li>Additional electric power: This is a constant value that is added to the power consumption. This may be helpful if e.g. an electric drive operates together with the compressor and shall be included in overall electric power and CoP calculation. </li>
<li>The smoothness of table interpolation can be chosen. </li>
<li>Allowed sink temperature: A maximum condenser outlet temperature limits the condenser heat flow through a PID controller. </li>
</ol>
<h4><span style=\"color:#008000\">Known Limitations</span></h4>
<ul>
<li>Allowed source temperature: No limits for source temperature is implemented. Though, usually this is not a problem if the heat pump is properly integrated into a system model. </li>
</ul>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>Works as on/off-controlled heat pump or heat pump with capacity control. The type of capacity and electrical power calculation can be chosen: </p>
<ol>
<li>Polynom 
<br>a) depending on evaporator input temperature, condenser output temperature and variable speed (via conditional speed connector) for capacity controlled heat pumps 
<br>b) depending on evaporator input temperature, condenser output temperature and nominal speed for on/off-controlled heat pump </li>
<li>Table data according for on/off-controlled heat pump, depending on evaporator input temperature, condenser output temperature </li>
</ol>
<p>The heat pump speed is helt between the boundaries N_min and N_max even if the input speed is higher or lower. But no further controlling is implemented! The control logic is conciously not integrated into this model! </p>
<p>The calculation of the capacity and electric power does not represent any dynamic behavior of the refrigerant cycle as it occurs in real heat pumps. Therefore two possibilities exist, to add dynamic behavior: </p>
<ol>
<li>The condenser and evaporator can be parametized with a certain external fluid volume to represent their thermal inertia in the tab Evaporator/Condenser</li>
<li>A first order element can be added to the calculation in the tab Advanced if the check box PT1_cycle is enabled (see: <i>Correction models)</i> </li>
</ol>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Sources:</p>
<ul>
<li>Pahud, D. and Lachal, B.: <i>Mesure des performances thermiques d?une pompe &agrave; chaleur coupl&eacute;e sur des sondes g&eacute;othermiques &agrave; Lugano (TI)</i>. Office f&eacute;d&eacute;ral de l&apos;energie, Bern, Switzerland. 2004. </li>
<li>Wetter, M. and Afjei, T.: <i>TRNSYS TYPE 401 - Kompressionsw&auml;rmepumpe inklusiv Frost- und Taktverluste</i>. Zentralschweizerisches Technikum Luzern - Ingenieruschule HTL, Switzerland. 1996. </li>
</ul>
</html>", revisions="<html>
<p><ul>
<li><i>March 27, 2013</i> by Kristian Huchtemann:<br/>Added maximum condenser temperature implementation.</li>
<li><i>December 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately </li>
<li><i>April 23, 2013&nbsp;</i> by Kristian Huchtemann:<br/>implemented</li>
</ul></p>
</html>"));
    end Cycle;
  end Partial;

  package Characteristics
    extends Modelica.Icons.Package;

    partial function baseFct "Base class for Cycle Characteristic"
      extends Modelica.Icons.Function;
      input Real N;
      input Real T_con;
      input Real T_eva;
      input Real mFlow_eva;
      input Real mFlow_con;
      output Real Char[2];

      annotation (Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>
Base funtion used in HeatPump model. It defines the inputs speed N (1/min), condenser outlet temperature T_co (K) and evaporator inlet temperature T_ev (K). The output is the vector Char: first value is compressor power, second value is the condenser heat flow rate.
</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars2.png\"/></p>
</html>",
        revisions="<html>
<p><ul>
<li><i>December 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
</ul></p>
</html>
"));
    end baseFct;


    function constantQualityGrade
      "Carnot CoP multiplied with constant quality grade and constant electric power"
      extends AixLib.HVAC.HeatGeneration.HeatPump.Characteristics.baseFct(
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
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Carnot CoP multiplied with constant quality grade and constant electric power, no dependency on speed or mass flow rates! </p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://AixLib/Images/stars3.png\" alt=\"stars: 3 out of 5\"/></p>
<p><h4><font color=\"#008000\">References</font></h4></p>
</html>",
        revisions="<html>
<p><ul>
<li><i>June 21, 2015&nbsp;</i> by Kristian Huchtemann:<br/>implemented</li>
</ul></p>
</html>
"));
    end constantQualityGrade;

    function constantCoP "Constant CoP and constant electric power"
      extends AixLib.HVAC.HeatGeneration.HeatPump.Characteristics.baseFct(
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
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Carnot CoP and constant electric power, no dependency on speed or mass flow rates!</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://AixLib/Images/stars3.png\" alt=\"stars: 3 out of 5\"/></p>
<p><h4><font color=\"#008000\">References</font></h4></p>
</html>",
        revisions="<html>
<p><ul>
<li><i>June 21, 2015&nbsp;</i> by Kristian Huchtemann:<br/>implemented</li>
</ul></p>
</html>
"));
    end constantCoP;
  end Characteristics;

  package DefrostCorrection
     extends Modelica.Icons.Package;

    partial function baseFct
      "Base class for correction model, icing and defrosting of evaporator"
      extends Modelica.Icons.Function;
      input Real T_eva;
      output Real f_CoPicing;
      annotation (Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>
Base funtion used in HeatPump model. Input is the evaporator inlet temperature, output is a CoP-correction factor f_cop_icing.
</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars2.png\"/></p>
</html>",
      revisions="<html>
<p><ul>
<li><i>December 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
</ul></p>
</html>"));
    end baseFct;

    function noModel "No model"
      extends AixLib.HVAC.HeatGeneration.HeatPump.DefrostCorrection.baseFct(
          T_eva);

    algorithm
    f_CoPicing:=1;

      annotation (Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>
No correction factor for icing/defrosting: f_cop_icing=1.
</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars2.png\"/></p>
</html>",
      revisions="<html>
<p><ul>
<li><i>December 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
</ul></p>
</html>"));
    end noModel;

    function WetterAfjei1996
      "Correction of CoP (Icing, Defrost) according to Wetter,Afjei 1996"
      extends AixLib.HVAC.HeatGeneration.HeatPump.DefrostCorrection.baseFct(
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
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>
Correction of CoP (Icing, Defrost) according to Wetter,Afjei 1996.
</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars2.png\"/></p>
</html>",
      revisions="<html>
<p><ul>
<li><i>December 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
</ul></p>
</html>"));
    end WetterAfjei1996;
  end DefrostCorrection;
end HeatPump;
