within AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop.BaseClasses;
model MassFlowControllerCooling

    final parameter Modelica.SIunits.Density rho = 1000 "Density of Water";
    final parameter Real cp_default = 4180 "Cp-value of Water";

    parameter Modelica.SIunits.Temperature T_max_directCooling = 273.15 + 14 "Maximal temperature for direct cooling supply";
    parameter Real deltaT_coolingSet = 2 "set temperature difference for cooling on the building site";
    parameter Modelica.SIunits.Time time_step = 3600 "Time Step of considered demand";
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal
    "Nominal mass flow rate";

    Modelica.Blocks.Interfaces.RealInput T_Grid_in "Grid Temperature in"
      annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=0,
          origin={-120,-82}),iconTransformation(
          extent={{-16,-16},{16,16}},
          rotation=0,
          origin={-116,-92})));
    Modelica.Blocks.Interfaces.RealInput CoolingDemand
      "Building Cooling Demand"
      annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=0,
          origin={-120,12}),   iconTransformation(extent={{-16,-16},{16,16}},
            origin={-116,16})));
    Modelica.Blocks.Interfaces.RealInput T_HE_Cooling_out
      "Outlet Temperature Heat Exchanger Cooling" annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          rotation=0,
          origin={-120,-134}),iconTransformation(
          extent={{-15,-15},{15,15}},
          rotation=0,
          origin={-117,-151})));
    Modelica.Blocks.Interfaces.RealInput deltaT_CoolingGridSet annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,-38}), iconTransformation(
        extent={{-16,-16},{16,16}},
        rotation=0,
        origin={-118,-38})));
    Modelica.Blocks.Logical.Switch switch2
      annotation (Placement(transformation(extent={{302,-98},{322,-78}})));
    Modelica.Blocks.Math.Division division3
      annotation (Placement(transformation(extent={{120,-40},{134,-26}})));
    Modelica.Blocks.Math.Gain        const2(k=cp_default)
      annotation (Placement(transformation(extent={{-46,-44},{-34,-32}})));
    Modelica.Blocks.Interfaces.RealOutput m_dc
      "Output for direct cooling pump mass flow rate"
      annotation (Placement(transformation(extent={{402,-104},{434,-72}})));
    Modelica.Blocks.Interfaces.RealInput T_supplyCoolingSet annotation (
        Placement(transformation(extent={{-138,-202},{-98,-162}}),
          iconTransformation(extent={{-132,-228},{-100,-196}})));
    Modelica.Blocks.Math.Add add5(k1=+1, k2=-1)
      annotation (Placement(transformation(extent={{-52,-204},{-32,-184}})));
    Modelica.Blocks.Sources.RealExpression deltaT_HE(y=deltaT_coolingSet)
    annotation (Placement(transformation(extent={{-98,-214},{-78,-194}})));
    Modelica.Blocks.Math.Add add6(k1=+1, k2=-1)
      annotation (Placement(transformation(extent={{-10,-154},{10,-134}})));
    Modelica.Blocks.Math.Product product3
      annotation (Placement(transformation(extent={{50,-160},{70,-140}})));
    Modelica.Blocks.Sources.Constant const3(
                                           k=cp_default)
      annotation (Placement(transformation(extent={{12,-180},{24,-168}})));
    Modelica.Blocks.Math.Division division4
      annotation (Placement(transformation(extent={{120,-160},{140,-140}})));
    Modelica.Blocks.Interfaces.RealOutput m_ch_he
      " pump mass flow rate for chiller circle"
      annotation (Placement(transformation(extent={{402,-160},{432,-130}})));
    Modelica.Blocks.Logical.Switch switch3
      annotation (Placement(transformation(extent={{302,-156},{322,-136}})));
    Modelica.Blocks.Interfaces.RealInput P_chiller "Chiller Power" annotation (
        Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=0,
          origin={-120,80}), iconTransformation(extent={{-15,-15},{15,15}},
            origin={-117,81})));
    Modelica.Blocks.Interfaces.RealOutput m_chiller
      "Output for chiller pump mass flow rate"
      annotation (Placement(transformation(extent={{400,64},{428,92}})));
    Modelica.Blocks.Math.Add add1(k1=+1, k2=+1)
      annotation (Placement(transformation(extent={{-42,64},{-22,84}})));
    Modelica.Blocks.Math.Division division1
      annotation (Placement(transformation(extent={{62,64},{76,78}})));
    Modelica.Blocks.Logical.Switch switch1
      annotation (Placement(transformation(extent={{238,68},{258,88}})));
    Modelica.Blocks.Interfaces.RealOutput T_set_Chiller
      "Setting temperature for chiller"
      annotation (Placement(transformation(extent={{402,-214},{432,-184}})));
  Modelica.Blocks.Sources.RealExpression zero(y=0) annotation (Placement(
        transformation(
        extent={{-4,-10},{4,10}},
        rotation=0,
        origin={248,-96})));
  Modelica.Blocks.Sources.RealExpression zero1(y=0)
                                                   annotation (Placement(
        transformation(
        extent={{-4,-10},{4,10}},
        rotation=0,
        origin={264,-134})));
  Modelica.Blocks.Sources.RealExpression zero2(y=0)
                                                   annotation (Placement(
        transformation(
        extent={{-4,-10},{4,10}},
        rotation=0,
        origin={154,100})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=10, uMin=0.01)
    annotation (Placement(transformation(extent={{350,-98},{370,-78}})));
    Modelica.Blocks.Interfaces.RealInput T_HP_in "Heat Demand Building"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-122,-480}), iconTransformation(extent={{-21,-21},{21,21}},
          origin={-117,-321})));
    Modelica.Blocks.Interfaces.RealInput T_HP_in1 "Heat Demand Building"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-122,-480}), iconTransformation(extent={{-21,-21},{21,21}},
          origin={-117,-321})));
  Modelica.Blocks.Continuous.CriticalDamping criticalDamping(f=1/60)
    annotation (Placement(transformation(extent={{-78,-92},{-58,-72}})));
  Modelica.Blocks.Math.Max max
    annotation (Placement(transformation(extent={{352,-152},{372,-132}})));
    Modelica.Blocks.Math.Add add2(k1=+1, k2=+1)
      annotation (Placement(transformation(extent={{76,-228},{96,-208}})));
    Modelica.Blocks.Sources.Constant const1(k=0.2)
      annotation (Placement(transformation(extent={{12,-242},{24,-230}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(
    uLow=T_max_directCooling - 0.5,
    uHigh=T_max_directCooling + 0.5,
    pre_y_start=true)
    annotation (Placement(transformation(extent={{-24,-92},{-4,-72}})));
equation
    connect(division3.u2,const2. y) annotation (Line(points={{118.6,-37.2},{
            107.1,-37.2},{107.1,-38},{-33.4,-38}},
                                         color={0,0,127}));
  connect(deltaT_CoolingGridSet, const2.u)
    annotation (Line(points={{-120,-38},{-47.2,-38}}, color={0,0,127}));
    connect(CoolingDemand, division3.u1) annotation (Line(points={{-120,12},{0,
          12},{0,-28.8},{118.6,-28.8}},
                                    color={0,0,127}));
  connect(deltaT_HE.y, add5.u2) annotation (Line(points={{-77,-204},{-66,-204},{
          -66,-200},{-54,-200}}, color={0,0,127}));
    connect(T_supplyCoolingSet, add5.u1) annotation (Line(points={{-118,-182},{
          -90,-182},{-90,-188},{-54,-188}},   color={0,0,127}));
    connect(add5.y, add6.u2) annotation (Line(points={{-31,-194},{-22,-194},{
            -22,-150},{-12,-150}}, color={0,0,127}));
    connect(add6.y, product3.u1)
      annotation (Line(points={{11,-144},{48,-144}}, color={0,0,127}));
    connect(const3.y, product3.u2) annotation (Line(points={{24.6,-174},{36,
            -174},{36,-156},{48,-156}}, color={0,0,127}));
    connect(division4.u1, division3.u1) annotation (Line(points={{118,-144},{84,
            -144},{84,-28},{48,-28},{118.6,-28.8}}, color={0,0,127}));
    connect(product3.y, division4.u2) annotation (Line(points={{71,-150},{94,
            -150},{94,-156},{118,-156}}, color={0,0,127}));
    connect(switch3.u2, switch2.u2) annotation (Line(points={{300,-146},{176,
            -146},{176,-88},{300,-88}}, color={255,0,255}));
    connect(P_chiller, add1.u1)
      annotation (Line(points={{-120,80},{-44,80}}, color={0,0,127}));
    connect(add1.u2, division3.u1) annotation (Line(points={{-44,68},{-56,68},{
            -56,12},{0,12},{0,-28.8},{118.6,-28.8}}, color={0,0,127}));
    connect(division1.u2, const2.y) annotation (Line(points={{60.6,66.8},{60.6,-38},
          {-33.4,-38}},        color={0,0,127}));
    connect(add1.y, division1.u1) annotation (Line(points={{-21,74},{20,74},{20,
          75.2},{60.6,75.2}},   color={0,0,127}));
    connect(switch1.y, m_chiller)
      annotation (Line(points={{259,78},{414,78}}, color={0,0,127}));
    connect(switch1.u2, switch2.u2) annotation (Line(points={{236,78},{204,78},
            {204,-88},{300,-88}}, color={255,0,255}));
    connect(m_ch_he, m_ch_he) annotation (Line(points={{417,-145},{409.5,-145},
            {409.5,-145},{417,-145}}, color={0,0,127}));
  connect(T_HE_Cooling_out, add6.u1) annotation (Line(points={{-120,-134},{-66,
          -134},{-66,-138},{-12,-138}}, color={0,0,127}));
  connect(limiter.y, m_dc)
    annotation (Line(points={{371,-88},{418,-88}}, color={0,0,127}));
  connect(switch2.y, limiter.u)
    annotation (Line(points={{323,-88},{348,-88}}, color={0,0,127}));
  connect(T_Grid_in, criticalDamping.u)
    annotation (Line(points={{-120,-82},{-80,-82}}, color={0,0,127}));
  connect(switch3.y, max.u2) annotation (Line(points={{323,-146},{336,-146},{
          336,-148},{350,-148}}, color={0,0,127}));
  connect(zero1.y, max.u1) annotation (Line(points={{268.4,-134},{282,-134},{
          282,-124},{340,-124},{340,-136},{350,-136}}, color={0,0,127}));
  connect(max.y, m_ch_he) annotation (Line(points={{373,-142},{388,-142},{388,
          -145},{417,-145}}, color={0,0,127}));
  connect(T_supplyCoolingSet, add2.u1) annotation (Line(points={{-118,-182},{
          -116,-182},{-116,-214},{74,-214},{74,-212}}, color={0,0,127}));
  connect(add2.y, T_set_Chiller) annotation (Line(points={{97,-218},{250,-218},
          {250,-199},{417,-199}}, color={0,0,127}));
  connect(const1.y, add2.u2) annotation (Line(points={{24.6,-236},{58,-236},{58,
          -224},{74,-224}}, color={0,0,127}));
  connect(criticalDamping.y, hysteresis.u)
    annotation (Line(points={{-57,-82},{-26,-82}}, color={0,0,127}));
  connect(division1.y, switch1.u1) annotation (Line(points={{76.7,71},{155.35,
          71},{155.35,86},{236,86}}, color={0,0,127}));
  connect(zero2.y, switch1.u3) annotation (Line(points={{158.4,100},{198,100},{
          198,70},{236,70}}, color={0,0,127}));
  connect(zero.y, switch2.u1) annotation (Line(points={{252.4,-96},{276.2,-96},
          {276.2,-80},{300,-80}}, color={0,0,127}));
  connect(division3.y, switch2.u3) annotation (Line(points={{134.7,-33},{284,
          -33},{284,-96},{300,-96}}, color={0,0,127}));
  connect(division4.y, switch3.u1) annotation (Line(points={{141,-150},{220,
          -150},{220,-138},{300,-138}}, color={0,0,127}));
  connect(zero1.y, switch3.u3) annotation (Line(points={{268.4,-134},{283.2,
          -134},{283.2,-154},{300,-154}}, color={0,0,127}));
  connect(hysteresis.y, switch2.u2) annotation (Line(points={{-3,-82},{100,-82},
          {100,-88},{300,-88}}, color={255,0,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -240},{400,120}}),   graphics={ Text(
            extent={{-70,6},{56,-12}},
            lineColor={135,135,135},
            fillColor={255,255,170},
            fillPattern=FillPattern.Solid,
            textString="%name"),                               Rectangle(extent={{
                -100,140},{400,-320}},lineColor={135,135,135},
            fillColor={255,255,170},
            fillPattern=FillPattern.Solid), Text(
            extent={{6,-28},{282,-190}},
            lineColor={135,135,135},
            fillColor={255,255,170},
            fillPattern=FillPattern.Solid,
          textString="%Mass
Flow
Controller
Cooling
Substation

")}), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-240},{
            400,120}})));
end MassFlowControllerCooling;
