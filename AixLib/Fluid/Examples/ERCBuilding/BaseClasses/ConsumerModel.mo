within AixLib.Fluid.Examples.ERCBuilding.BaseClasses;
model ConsumerModel

  parameter Integer n=2 "Ammount of consumers";
  parameter Real T_flow_Initial=35+273.15 "Initial flow temperature (t=0)";
  parameter Boolean Type_of_Consumer = false
    "= true:Cold consumer; false:Hot consumer"                                          annotation(Evaluate=true);
  parameter Real m_flow_max = 10 "Maximal flow mass rate [kg/s]";
  parameter Real m_flow_min = 0.1 "Minimal flow mass rate [kg/s]";

  Modelica.SIunits.ThermodynamicTemperature DeltaT_min=0.3;

  Modelica.SIunits.MassFlowRate m_return;
  Modelica.SIunits.ThermodynamicTemperature T_flow;
  Modelica.SIunits.ThermodynamicTemperature T_return;
  Modelica.SIunits.ThermodynamicTemperature T_return_ini;

  Modelica.SIunits.Power Q_dot[n];
  Modelica.SIunits.MassFlowRate m_ret[n];
  Modelica.SIunits.ThermodynamicTemperature T_ret[n];

  replaceable package Water = AixLib.Media.Water;

  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium = Water)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium = Water)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
  AixLib.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = Water,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{-60,30},{-80,50}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
        Water)
    annotation (Placement(transformation(extent={{-50,-60},{-30,-40}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem(
    redeclare package Medium = Water,
    m_flow_nominal=0.5,
    T_start=T_flow_Initial)
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  Modelica.Blocks.Sources.RealExpression ReturnTemperature1(y=T_return)
    annotation (Placement(transformation(extent={{12,18},{-8,38}})));
  Modelica.Blocks.Sources.RealExpression ReturnTemperature2(y=T_return_ini)
    annotation (Placement(transformation(extent={{12,2},{-8,22}})));
  Modelica.Blocks.Sources.RealExpression ReturnMassFlow1(y=m_return)
    annotation (Placement(transformation(extent={{12,48},{-8,68}})));
  Modelica.Blocks.Sources.RealExpression ReturnMassFlow2(y=0.5)
    annotation (Placement(transformation(extent={{12,32},{-8,52}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Blocks.Interfaces.RealInput Temp_return_in[n] annotation (Placement(
        transformation(
        extent={{-20,20},{20,-20}},
        rotation=180,
        origin={100,-40})));
  Modelica.Blocks.Interfaces.RealInput Q_dot_in[n] annotation (Placement(
        transformation(
        extent={{20,-20},{-20,20}},
        rotation=0,
        origin={100,40})));

  Modelica.Blocks.Sources.RealExpression timeMeasurement(y=time)
    annotation (Placement(transformation(extent={{68,80},{48,100}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold1(threshold=300)
    annotation (Placement(transformation(extent={{40,80},{20,100}})));
  Modelica.Blocks.Logical.Switch switchMassFlow
    annotation (Placement(transformation(extent={{-20,40},{-40,60}})));
  Modelica.Blocks.Logical.Switch switchTempReturn
    annotation (Placement(transformation(extent={{-20,10},{-40,30}})));

  AixLib.Fluid.Sources.MassFlowSource_T boundary1(
    redeclare package Medium = Water,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{4,-60},{-16,-40}})));
  Modelica.Blocks.Math.Gain gain(k=-1) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=180,
        origin={31,-29})));
equation
  T_flow = senTem.T;

  for i in 1:n loop
    T_ret[i] = Temp_return_in[i];
    Q_dot[i] = Q_dot_in[i];

    if Type_of_Consumer then
      //if T_ret[i] > T_flow then
      if (T_ret[i] - T_flow) > DeltaT_min then
        //Q_dot[i] = Q_dot_in[i];
        Q_dot[i] = m_ret[i]*Water.cp_const*(T_ret[i] - T_flow);
      else
        //Q_dot[i] = 0;
        //m_ret[i] = m_flow_min/n;
        Q_dot[i] = m_ret[i]*Water.cp_const*DeltaT_min;
      end if;
    else
      //if T_flow > T_ret[i] then
      if (T_flow - T_ret[i])> DeltaT_min then
        //Q_dot[i] = Q_dot_in[i];
        Q_dot[i] = m_ret[i]*Water.cp_const*(T_flow - T_ret[i]);
      else
        //Q_dot[i] = 0;
        //m_ret[i] = m_flow_min/n;
        Q_dot[i] = m_ret[i]*Water.cp_const*DeltaT_min;
      end if;
    end if;
  end for;

//   if sum(m_ret) > m_flow_max then
//     m_return = m_flow_max;
//   else
//     m_return = sum(m_ret);
//   end if;

   if sum(m_ret) > m_flow_max then
     m_return = m_flow_max;
     T_return = sum(T_ret)/n;
   elseif sum(m_ret) < m_flow_min then
     m_return = m_flow_min;
     T_return = sum(T_ret)/n;
   else
     m_return = sum(m_ret);
     T_return = (m_ret*T_ret)/m_return;
   end if;

//   T_return = (m_ret*T_ret)/m_return;
  T_return_ini = sum(T_ret)/n;

  connect(port_a, senTem.port_a)
    annotation (Line(points={{-100,-40},{-90,-40},{-90,-50},{-80,-50}}, color={0,127,255}));
  connect(senMasFlo.port_a, senTem.port_b)
    annotation (Line(points={{-50,-50},{-60,-50}}, color={0,127,255}));
  connect(port_b, boundary.ports[1])
    annotation (Line(points={{-100,40},{-100,40},{-80,40}}, color={0,127,255}));
  connect(greaterThreshold1.u, timeMeasurement.y)
    annotation (Line(points={{42,90},{47,90}}, color={0,0,127}));
  connect(switchMassFlow.u1, ReturnMassFlow1.y)
    annotation (Line(points={{-18,58},{-9,58}}, color={0,0,127}));
  connect(switchTempReturn.u1, ReturnTemperature1.y)
    annotation (Line(points={{-18,28},{-9,28}}, color={0,0,127}));
  connect(greaterThreshold1.y, switchMassFlow.u2) annotation (Line(points={{19,90},
          {16,90},{16,50},{-18,50}}, color={255,0,255}));
  connect(switchTempReturn.u2, greaterThreshold1.y) annotation (Line(points={{-18,
          20},{16,20},{16,90},{19,90}}, color={255,0,255}));
  connect(switchMassFlow.u3, ReturnMassFlow2.y)
    annotation (Line(points={{-18,42},{-9,42}}, color={0,0,127}));
  connect(ReturnTemperature2.y, switchTempReturn.u3)
    annotation (Line(points={{-9,12},{-18,12},{-18,12}}, color={0,0,127}));
  connect(switchTempReturn.y, boundary.T_in) annotation (Line(points={{-41,20},{
          -48,20},{-50,20},{-50,44},{-58,44}}, color={0,0,127}));
  connect(switchMassFlow.y, boundary.m_flow_in) annotation (Line(points={{-41,50},
          {-50,50},{-50,48},{-60,48}}, color={0,0,127}));
  connect(senMasFlo.port_b, boundary1.ports[1]) annotation (Line(points={{-30,
          -50},{-23,-50},{-16,-50}}, color={0,127,255}));
  connect(boundary1.m_flow_in, gain.y) annotation (Line(points={{4,-42},{14,-42},
          {14,-29},{25.5,-29}}, color={0,0,127}));
  connect(switchMassFlow.y, gain.u) annotation (Line(points={{-41,50},{-46,50},
          {-46,-2},{44,-2},{44,-29},{37,-29}}, color={0,0,127}));
  connect(switchTempReturn.y, boundary1.T_in) annotation (Line(points={{-41,20},
          {-50,20},{-50,-18},{18,-18},{18,-46},{6,-46}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),                                   graphics={Bitmap(extent={{-100,-100},{100,100}},
            fileName="N:/Forschung/EBC0155_PTJ_Exergiebasierte_regelung_rsa/Students/Students-Exchange/Photos Dymola/CCA.jpg"),
                                 Text(
          extent={{-153,135},{147,95}},
          lineColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255},
          textString="%name"),
        Text(
          extent={{-70,46},{74,-32}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="Consumer")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation( info="<html> Model of an simple consumer. The heat(cool)demand and the return temperature are given by inputs. Based on these demand, the flow temperature and the retrun temperature the needed massflowrate is calculated. 
    The incomiming stream is deleted in a sink, while the return stream is generated by a massflow source with the calculated temperature. If the demand is bigger than the potential of the incoming 
    stream the massflowrate and the delta temperature are bounded and default values are used. </html>"));
end ConsumerModel;
